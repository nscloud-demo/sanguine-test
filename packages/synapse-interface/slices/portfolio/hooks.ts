import { useCallback } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { createAsyncThunk } from '@reduxjs/toolkit'
import { getAccount, Address } from '@wagmi/core'

import { AppDispatch, RootState } from '@/store/store'
import { FetchState, typeSearchInput, resetSearchState } from './actions'
import { useAppDispatch, useAppSelector } from '@/store/hooks'
import {
  fetchPortfolioBalances,
  NetworkTokenBalances,
  getTokenBalances,
  TokenAndBalance,
} from '@/utils/actions/fetchPortfolioBalances'
import { Token } from '@/utils/types'
import { initialState } from './reducer'

export const usePortfolioState = (): RootState['portfolio'] => {
  return useAppSelector((state) => state.portfolio)
}

export const usePortfolioBalances = (): NetworkTokenBalances => {
  return useAppSelector((state) => state.portfolio.balances)
}

export const usePortfolioActionHandlers = (): {
  onSearchInput: (searchInput: string) => void
  clearSearchInput: () => void
  clearSearchResults: () => void
} => {
  const dispatch = useAppDispatch()

  const onSearchInput = useCallback(
    (searchInput: string) => {
      dispatch(typeSearchInput({ searchInput }))
    },
    [dispatch]
  )

  const clearSearchInput = useCallback(() => {
    dispatch(typeSearchInput({ searchInput: initialState.searchInput }))
  }, [dispatch])

  const clearSearchResults = useCallback(() => {
    dispatch(resetSearchState())
  }, [dispatch])

  return {
    onSearchInput,
    clearSearchInput,
    clearSearchResults,
  }
}

export const fetchAndStorePortfolioBalances = createAsyncThunk(
  'portfolio/fetchAndStorePortfolioBalances',
  async (address: string) => {
    const portfolioData = await fetchPortfolioBalances(address)
    return portfolioData
  }
)

export const fetchAndStoreSearchInputPortfolioBalances = createAsyncThunk(
  'portfolio/fetchAndStoreSearchInputPortfolioBalances',
  async (address: string) => {
    const portfolioData = await fetchPortfolioBalances(address)
    return { ...portfolioData, address }
  }
)

export const fetchAndStoreSingleNetworkPortfolioBalances = createAsyncThunk(
  'portfolio/fetchAndStoreSingleNetworkPortfolioBalances',
  async ({ address, chainId }: { address: string; chainId: number }) => {
    const portfolioData = await fetchPortfolioBalances(address, chainId)
    return portfolioData
  }
)

export const useFetchPortfolioBalances = (): {
  balances: NetworkTokenBalances
  fetchPortfolioBalances: () => void
  status: FetchState
  error: string
} => {
  const dispatch: AppDispatch = useDispatch()
  const { address } = getAccount()
  const { balances, status, error } = useSelector(
    (state: RootState) => state.portfolio
  )

  const fetch = () => {
    if (address) {
      dispatch(fetchAndStorePortfolioBalances(address))
    }
  }

  return { balances, fetchPortfolioBalances: fetch, status, error }
}

export const fetchAndStoreSingleTokenBalance = createAsyncThunk(
  'portfolio/fetchAndStoreSingleTokenBalance',
  async ({
    token,
    routerAddress,
    address,
    chainId,
  }: {
    token: Token
    routerAddress: Address
    address: Address
    chainId: number
  }) => {
    const data: TokenAndBalance[] = await getTokenBalances(
      address,
      [token],
      chainId
    )
    const { balance, parsedBalance }: TokenAndBalance = data[0]
    const tokenAddress = token.addresses[chainId] as Address
    return {
      routerAddress,
      chainId,
      tokenAddress,
      balance,
      parsedBalance,
    }
  }
)
