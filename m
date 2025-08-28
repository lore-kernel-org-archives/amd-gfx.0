Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4A3C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 14:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA9010E9EF;
	Thu, 28 Aug 2025 14:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ykXixMT1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C508310E9F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 14:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKSZWgdrIR6klNPmCA2PAdEcGeyf1YCZ9C9vJENE84dldNyvbqnYi63yq4lAYCDnB0bpi5V/BsUqCSZ2UTx2lUNjKZ+PUQZRdFZ5VjGCsp5vRX52x85i5w+W9yryVpiCr/JqNFUfwNCbfJ3tW5BA5ZVU/aCtT4MlJnNLJWKnc8aAgJi9AUvcxi/j6v6pE0DBJiPNSZzwpLecrGGSKyGiFHyw0FXg7CkFs0euOCfQDznOK2x+WqnIMZr636MTRaMOJCowUScjdvLqiefkKS1OsywMl5TOKfC+DIzM1aKP2ZRkf/9XIK4g617gnORTNmPu36E/s4f7VjbIInQO13+Bcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmOaCXAh+WW00w3ViKkolS7QhuVeJ5VsaKiw0VhwiPo=;
 b=MthmWf5i32bT5j3XnUyDhtjjrgvtfO4vNhdBKyp0KuKgcvvX8gB+HTdOUcpQZNhT19s71Oyw+jRVcY58CavK30Ju+Z+AalFOR9BCvUiOiHMvnevnaGrvGpWqMT2K7Z/+z+U/hSI7+MAuIiphxnQ3gSPfZ/uAVpU5LSLvnevtS4e5Dvc2iSUvYxZ0F+t1hubwURJ8QJO5a1IHlM24udRQazAiIeQbPXhL6g4cLeZJM/zbcoueo5a+hqSjC4VnM/ABfguaL1SnKwUqKwiG8etuhtUb9qk1tEd/mNXbQYMcWj+UTWELd14fHpd3jhb1o3hsdfBEInM4EW4vGTTdANw6iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmOaCXAh+WW00w3ViKkolS7QhuVeJ5VsaKiw0VhwiPo=;
 b=ykXixMT1+sJp8PallQ/gvTtUdUtVUPXJ7ZuXkfhylgmu9HFE5/9zl02Jlc9tJ80XUV3jq/bE1PtJD6syg2Kitoqnu+1Cl7+EfTl+6KCOUoDlXPZ4oO7sOCciGZJUjp5WF7EwFGZaIgFqYydftKX+nSxj0SZ5ph8Yho7wLp6t1QM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 14:29:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 14:29:10 +0000
Message-ID: <12672040-365a-4619-a12f-797c76290727@amd.com>
Date: Thu, 28 Aug 2025 16:29:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clean up and unify hw fence handling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: David.Wu3@amd.com
References: <20250828140548.5792-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250828140548.5792-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0318.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b229a84-d141-4def-733d-08dde63f4087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3AxN2RlTVNCZTdkZ2hzNUloV3RxR3ZOc0Y4MnEwYmFrc3huY1RZeWs4YUht?=
 =?utf-8?B?ZmhQb2lIOTVkU1AzNUM5Z2ZYYzdVSFMrZXNUdUVoc2tUQmNWbWN1UHZEZjVI?=
 =?utf-8?B?cjQvM1ArL09xQS80UTJXZXBrRStFYzNUWldvcWlzUXh0Zk9GMkZqdkpVVzI4?=
 =?utf-8?B?SFdnd2Njckp3VVRQYysrZGVhTUttenJna1ZqOWswRFlST0hodGhJRXdPZ2xI?=
 =?utf-8?B?ZGpyUWczVG55L0haU3RLV2N4S3RlNnNtQm9yb1NYenNkODNCa3lkQzRDWTF4?=
 =?utf-8?B?M0tHVUZBdTEyWWg0NzlKd1JKRVF0L3A0cy96RjloYnlkdVhoMkVKaXQwSnlk?=
 =?utf-8?B?ZTVSVmNjQzdMbUpUcms3U1VlTnJmcTEzS082L0hUN3JYSkRmUXNIYmJOMjlO?=
 =?utf-8?B?SUQ1ZXB3cS9ZYkxZZjhibXZsWjRobnEvcllVR2JRMk1qZ000aWlDV0RnWmxM?=
 =?utf-8?B?SFVXTjlGTWFaWGs3OFNjN1RCKzFubndwZVRTVkVSL052ZXRwaEdpaUs2cit6?=
 =?utf-8?B?MUsyWlovcGxYejlrdzVOOXJzRHBBMXN1M1VaVXgwZkl2Q04wOCttZis2ZmlG?=
 =?utf-8?B?R3RaZ09KMmgzc0JTSXBCdEM5VmRtTUEzWHJXN1F6em50UTFsamVueHVocVJu?=
 =?utf-8?B?NXhRYzI1TGZmbGt6SmpjeGd4N09BaHFxQUMyZUJtNS9LeDYrK3l1L2hsNVIx?=
 =?utf-8?B?WUpHMWd3OFBLd3FFK0xxeTArY2hkTVhETWdaTWRzN01IYlpZalViOG9uYzkv?=
 =?utf-8?B?WWtpVnZNTHJRcDdOK01SUTNERGZkZ1lqdG1aZFY0blBpeXpuTUFOUG82MHIv?=
 =?utf-8?B?TlgwR3NScURiYTNBdFhLZk9MclVLbFBnVklCQjU5dFlVTEZQdG1jWm4rZTRm?=
 =?utf-8?B?U09wR2RtZ3NOZE1MVXFUMU5CdURRNWdzU1BvVEhPQ25KRlRZemNvKzkrME94?=
 =?utf-8?B?L1diK0tOWGFiYmxITVpTZklRS1NnNDFtOVJ1eWJ0VWs5bExkeEJ3OU91V0sr?=
 =?utf-8?B?NStKdHZHcU5HRTA1aHJQbVBaWmRPb2NPUmdRZmFWN09ocnA3ZGdXZE9sMXZO?=
 =?utf-8?B?K0lKTEt3Ty9FckZndXp6UkdCY2VGNFF5ODEwc25sSHhiYURTb3U5czRsTVBi?=
 =?utf-8?B?WnpTZW5hdUlyZjFOaUVQdjF4bFluV3pDdTRnL01NTFlaLy9Bd0s2Qk9GdUtw?=
 =?utf-8?B?dk5zSFBFZGYzTTExamRXbGRTTGY3TUVjZ1NGY0dRaXZZK0hiOERYN0N6WjVl?=
 =?utf-8?B?YndiMDg2THF0c2FFcUNnaG5SU2FicUk2K1REaTB0dGFzZzRaL2N5VEwyYldv?=
 =?utf-8?B?Qm5WaXdya0VFZ2xiSGc5SW5jTS9qTSt0WnB5TWtJU3ZQb3k4RFBGbFdrcG1D?=
 =?utf-8?B?eThyeWVRNGo4M0dUclYyMzBLZk1STlA1WHNTNEpBT0ZnYWlVRkpkaWpkempY?=
 =?utf-8?B?NmVLRklQc01NMlJXWmdEcjZFRWhJRzVJc25RZGo0bE9WcUJCTVVubnhNczAr?=
 =?utf-8?B?cUlkMElJRjRPejNJeWdCb1VZdlErbWdwTnZGVUZKbzFCOHFmcHQyaWUxYzB2?=
 =?utf-8?B?a0JvUnFqcTYvc0tFTzBveWxaZk1xN0xEZk0vRUtpWWFCUS9SNU4xUk05aU5N?=
 =?utf-8?B?OW0zZC9tQWJ4OEhyRlF6bUxMSXU0UWtUbFk2REFSdk5JUm1idlBRZWhNTTcz?=
 =?utf-8?B?WlFURGRMak8vSktuUzVCMkN4VVRPSEQ3Rys1cEI2bWwyc1p1elQ2aXZqNzRM?=
 =?utf-8?B?UnVMdkNqY0ZycmtEM2dwZXdGQWZ0OGppa2c2QjdiZEJ3cFp0eG9GajlYeUhY?=
 =?utf-8?B?VGlHaU8wdG41bVJUYTdUUmdTMkRTMTJmKytpNitNSHZQc3RVdVpoMEJHRk92?=
 =?utf-8?B?NlFhR0JDZ083VURwanBxdmJkaG9Vb2JuT0Q3REUxVU1KS0kyMWNsb1ZkOE8r?=
 =?utf-8?Q?YBHpX30bDxQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnhSNndwaE1ZMHVoWFBXMURRMnhLemNpUUpMRmNxbGVwb2pPTVVOd3ZKWERv?=
 =?utf-8?B?b08vOTEyNUg4djFJTDNGYnNza3BYd0JFRTFhakZ2L3d5SUdNdTlYNDdDMFR4?=
 =?utf-8?B?YStJVjJlb1JsbEJqNWdaMTNkWGYyU2kxd1pTc1BoUStLMHFZbXRmeVdKYXNr?=
 =?utf-8?B?VXpDOHQ0eERHZnhETllqOEcvemFRZ0dUaFpVN1JhRlp5Sy85ODFZK0tlbFlQ?=
 =?utf-8?B?WGw4RWg2Q1NwS0p0V3F0VWtLejFhVWE4cGZodjlxODlNcVZGckYrSDN3S3oy?=
 =?utf-8?B?SWJsRWlEOE16eEpJL2lsMVlQbUk5VS83d2FWSG5JWUcrZ0ZXOFRpZXVVOThz?=
 =?utf-8?B?ZmhwVDgwOEp6b0FUaVo5M25Ca1VGVWdJanhyMnFiTEpLN2dZS0w3dVNnR2hY?=
 =?utf-8?B?TWlHWWV5d3ZFRTZtKy9iSTdIOGJ1bXBzSU9Nb0NkNmkrN0hGTkJvLzhRMzZl?=
 =?utf-8?B?TXdlSk5kSHYzdTJqVGNocklEcDl2VmpJamNQSS9mQXdJMGRHZmNzQWlKNGVC?=
 =?utf-8?B?bVY2YUxYc01VWlYzMElGVEtucmRCYXh4elJ4TmJyNi9aNi9zV0N4bDRNS2Yv?=
 =?utf-8?B?OC9TL0RveEVtQXdnZnMxVVVtbWI3aFYvb3piZVZnOUVLNnA5aXV2NnZ3MHV1?=
 =?utf-8?B?Z0lVTmtmaG1UV3hmNDdOTXV4S2Z4ejNLaSs4T0pDQlgxY0JvZjE0Sm5lRG54?=
 =?utf-8?B?RE9zRkVUbGhONFViRUc2N0JLODFxbGNqZytFQzZ1Z1NXaTlIUDBXeGlaVzlY?=
 =?utf-8?B?Myt0WDVuam5TaUdkRmRSWHViYmVBUmw1bW5Ja1M0bCtPY3F2Y0FuNkhwK21U?=
 =?utf-8?B?MkJqMWpRcXBLY2ZxWTBKOVBUclJRV3FnbGhzYy9lc1ZSRXRnRzh5Mnl6NVM4?=
 =?utf-8?B?MG9QSDdZdGJ5SlB1T3RCTzI4WnA3WkxBUm40RjcxSzBDVDdsTy83SlEySHJq?=
 =?utf-8?B?b3JNOHJlWTZ2Smp3eHNlY1N2S290TGRoQ1hyUE9iWXJqVWwxMGlqSWFsZ291?=
 =?utf-8?B?dDRpRVlMTXZ5NlpTU2ZvSzROb1BuVm9CV01ya3YwekpITE0wQnl1ZFJiSUpj?=
 =?utf-8?B?QTJ5YVl2L1pSZDBzVG1LMjVXdC8xMkFhVjJKRHZSY1VHODVkeXZQRGpJejVl?=
 =?utf-8?B?NlQ0YWRHWnZvMmFCNzAzYkYxYmNQU09JWk1LZXdCYjFTcFgvZGpWRGc5UEpj?=
 =?utf-8?B?aHJWVHdhLzZtYzlVUFNraFlHNFJSdjFUZGtlUFlMZkJXY1RxT1hubHlkSlVB?=
 =?utf-8?B?YkNHQktnNUp6K1czNXFaN3ByYS8wNnUxK3B1WmQ5NDVpNXdLckZGampBRm02?=
 =?utf-8?B?RWJtTzRCSTBwQVBzZlJ4Z1RaaTBVdFpKWTdUVzNJbXdSb0Ixbi81M1pSc0oy?=
 =?utf-8?B?KzlwdEtpbUp4c0RwTlFQVGx6OGJqSzIxUWZjL21GMDRuRkVuajdyeHNWZDFK?=
 =?utf-8?B?ZTQzNjRwZGlFU25RSWlROXFPR0J3aGE1Ukl3QlFXT3BJcEJxbFBnVDJIbHlH?=
 =?utf-8?B?K1o2c2dqZk5OTmlCbmVJam9leis4cmFKSnhnM1hNQ0MrRGJienhmNndlSlNK?=
 =?utf-8?B?NjdFb1J0eDVvdWxLWGEvRVpVRk1mMlRzYUJFS3VlbGt0eFF0M3E1aGxwY2w5?=
 =?utf-8?B?T1NJSjhvbEFBd1ZaTlgxUDNsbnY3Yy96MXh4dUpPU2ZtWHMrMFBqZTFVMkFm?=
 =?utf-8?B?ZWR3OW94L3J4SytidlB2bG53WWRUbmdjcGVyZzU3dXpXNktYakY2ZVFzYm8v?=
 =?utf-8?B?bzJyLzVBVERFd1VTZnFybE93RSt6aHJpNFQraStkUkpxVHE5WE9YMGludHhj?=
 =?utf-8?B?cE1pT3RNM1VNb1JWL050b09tV1MxSzhUVWljdHNocDBwNEdOYjNwWlN6SWRT?=
 =?utf-8?B?eUN3WEU0SWZ2WWlsUlJUZnprSkZIcnFya1B6M21mUldyd05mQUVrcXlSc0NE?=
 =?utf-8?B?eU5PYW9acHZIZTNhUUdUYjdoZ3lEOGtSam5vck5TQVZlNWZYREl0MUhzMnhj?=
 =?utf-8?B?NklSd1E3WlpkT1hsSGdQMjhoWDcwMkk5Y1dtYmd0YjFuRnRmdVM3WTZwMXBy?=
 =?utf-8?B?SURybWYwNTZLL1d6UWFUL0s0SEwxS2F2VDZxQzl5M2hLWSthdnRKdkpWSHJr?=
 =?utf-8?Q?8j7C3pxuahbsawSZGMvIuWsd3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b229a84-d141-4def-733d-08dde63f4087
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 14:29:10.1333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8fWWOTRrGNfE+eOrs37f5wQ9yLBm98R7Ud+MFZYdxCRkhHZji9EQrWddru0YHsw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 28.08.25 16:05, Alex Deucher wrote:
> Decouple the amdgpu fence from the amdgpu_job structure.
> This lets us clean up the separate fence ops for the embedded
> fence and other fences.  This also allows us to allocate the
> vm fence up front when we allocate the job.
> 
> Cc: David.Wu3@amd.com
> Cc: christian.koenig@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
> 
> v2: Additional cleanup suggested by Christian
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 140 ++------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  22 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  41 ++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |   7 +-
>  8 files changed, 64 insertions(+), 165 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index f81608330a3d0..7ea3cb6491b1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>  			continue;
>  		}
>  		job = to_amdgpu_job(s_job);
> -		if (preempted && (&job->hw_fence.base) == fence)
> +		if (preempted && (&job->hw_fence->base) == fence)
>  			/* mark the job as preempted */
>  			job->preemption_status |= AMDGPU_IB_PREEMPTED;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7783272a79302..add272fa31288 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5798,11 +5798,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>  		if (!amdgpu_ring_sched_ready(ring))
>  			continue;
>  
> -		/* Clear job fence from fence drv to avoid force_completion
> -		 * leave NULL and vm flush fence in fence drv
> -		 */
> -		amdgpu_fence_driver_clear_job_fences(ring);
> -
>  		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>  		amdgpu_fence_driver_force_completion(ring);
>  	}
> @@ -6526,7 +6521,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	 *
>  	 * job->base holds a reference to parent fence
>  	 */
> -	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
> +	if (job && dma_fence_is_signaled(&job->hw_fence->base)) {
>  		job_signaled = true;
>  		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>  		goto skip_hw_reset;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 2d58aefbd68a7..1355fee0e978d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -45,16 +45,11 @@
>   * Cast helper
>   */
>  static const struct dma_fence_ops amdgpu_fence_ops;
> -static const struct dma_fence_ops amdgpu_job_fence_ops;
>  static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)
>  {
>  	struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);
>  
> -	if (__f->base.ops == &amdgpu_fence_ops ||
> -	    __f->base.ops == &amdgpu_job_fence_ops)
> -		return __f;
> -
> -	return NULL;
> +	return __f;
>  }
>  
>  /**
> @@ -98,51 +93,33 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>   * amdgpu_fence_emit - emit a fence on the requested ring
>   *
>   * @ring: ring the fence is associated with
> - * @f: resulting fence object
>   * @af: amdgpu fence input
>   * @flags: flags to pass into the subordinate .emit_fence() call
>   *
>   * Emits a fence command on the requested ring (all asics).
>   * Returns 0 on success, -ENOMEM on failure.
>   */
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> -		      struct amdgpu_fence *af, unsigned int flags)
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +		      unsigned int flags)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct dma_fence *fence;
> -	struct amdgpu_fence *am_fence;
>  	struct dma_fence __rcu **ptr;
>  	uint32_t seq;
>  	int r;
>  
> -	if (!af) {
> -		/* create a separate hw fence */
> -		am_fence = kzalloc(sizeof(*am_fence), GFP_KERNEL);
> -		if (!am_fence)
> -			return -ENOMEM;
> -	} else {
> -		am_fence = af;
> -	}
> -	fence = &am_fence->base;
> -	am_fence->ring = ring;
> +	fence = &af->base;
> +	af->ring = ring;
>  
>  	seq = ++ring->fence_drv.sync_seq;
> -	am_fence->seq = seq;
> -	if (af) {
> -		dma_fence_init(fence, &amdgpu_job_fence_ops,
> -			       &ring->fence_drv.lock,
> -			       adev->fence_context + ring->idx, seq);
> -		/* Against remove in amdgpu_job_{free, free_cb} */
> -		dma_fence_get(fence);
> -	} else {
> -		dma_fence_init(fence, &amdgpu_fence_ops,
> -			       &ring->fence_drv.lock,
> -			       adev->fence_context + ring->idx, seq);
> -	}
> +	af->seq = seq;

Why we have af->seq in the first place? That is identical to af->base.seq as far as I can see.

> +	dma_fence_init(fence, &amdgpu_fence_ops,
> +		       &ring->fence_drv.lock,
> +		       adev->fence_context + ring->idx, seq);
>  
>  	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>  			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> -	amdgpu_fence_save_wptr(fence);
> +	amdgpu_fence_save_wptr(af);
>  	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>  	ptr = &ring->fence_drv.fences[seq & ring->fence_drv.num_fences_mask];
>  	if (unlikely(rcu_dereference_protected(*ptr, 1))) {
> @@ -167,8 +144,6 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>  	 */
>  	rcu_assign_pointer(*ptr, dma_fence_get(fence));
>  
> -	*f = fence;
> -
>  	return 0;
>  }
>  
> @@ -669,36 +644,6 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>  	}
>  }
>  
> -/**
> - * amdgpu_fence_driver_clear_job_fences - clear job embedded fences of ring
> - *
> - * @ring: fence of the ring to be cleared
> - *
> - */
> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
> -{
> -	int i;
> -	struct dma_fence *old, **ptr;
> -
> -	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
> -		ptr = &ring->fence_drv.fences[i];
> -		old = rcu_dereference_protected(*ptr, 1);
> -		if (old && old->ops == &amdgpu_job_fence_ops) {
> -			struct amdgpu_job *job;
> -
> -			/* For non-scheduler bad job, i.e. failed ib test, we need to signal
> -			 * it right here or we won't be able to track them in fence_drv
> -			 * and they will remain unsignaled during sa_bo free.
> -			 */
> -			job = container_of(old, struct amdgpu_job, hw_fence.base);
> -			if (!job->base.s_fence && !dma_fence_is_signaled(old))
> -				dma_fence_signal(old);
> -			RCU_INIT_POINTER(*ptr, NULL);
> -			dma_fence_put(old);
> -		}
> -	}
> -}
> -
>  /**
>   * amdgpu_fence_driver_set_error - set error code on fences
>   * @ring: the ring which contains the fences
> @@ -765,11 +710,9 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
>  	amdgpu_fence_process(fence->ring);
>  }
>  
> -void amdgpu_fence_save_wptr(struct dma_fence *fence)
> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af)
>  {
> -	struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
> -
> -	am_fence->wptr = am_fence->ring->wptr;
> +	af->wptr = af->ring->wptr;
>  }
>  
>  static void amdgpu_ring_backup_unprocessed_command(struct amdgpu_ring *ring,
> @@ -830,13 +773,6 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>  	return (const char *)to_amdgpu_fence(f)->ring->name;
>  }
>  
> -static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
> -{
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
> -
> -	return (const char *)to_amdgpu_ring(job->base.sched)->name;
> -}
> -
>  /**
>   * amdgpu_fence_enable_signaling - enable signalling on fence
>   * @f: fence
> @@ -853,23 +789,6 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>  	return true;
>  }
>  
> -/**
> - * amdgpu_job_fence_enable_signaling - enable signalling on job fence
> - * @f: fence
> - *
> - * This is the simliar function with amdgpu_fence_enable_signaling above, it
> - * only handles the job embedded fence.
> - */
> -static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
> -{
> -	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
> -
> -	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
> -		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
> -
> -	return true;
> -}
> -
>  /**
>   * amdgpu_fence_free - free up the fence memory
>   *
> @@ -885,21 +804,6 @@ static void amdgpu_fence_free(struct rcu_head *rcu)
>  	kfree(to_amdgpu_fence(f));
>  }
>  
> -/**
> - * amdgpu_job_fence_free - free up the job with embedded fence
> - *
> - * @rcu: RCU callback head
> - *
> - * Free up the job with embedded fence after the RCU grace period.
> - */
> -static void amdgpu_job_fence_free(struct rcu_head *rcu)
> -{
> -	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> -
> -	/* free job if fence has a parent job */
> -	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
> -}
> -
>  /**
>   * amdgpu_fence_release - callback that fence can be freed
>   *
> @@ -913,19 +817,6 @@ static void amdgpu_fence_release(struct dma_fence *f)
>  	call_rcu(&f->rcu, amdgpu_fence_free);
>  }
>  
> -/**
> - * amdgpu_job_fence_release - callback that job embedded fence can be freed
> - *
> - * @f: fence
> - *
> - * This is the simliar function with amdgpu_fence_release above, it
> - * only handles the job embedded fence.
> - */
> -static void amdgpu_job_fence_release(struct dma_fence *f)
> -{
> -	call_rcu(&f->rcu, amdgpu_job_fence_free);
> -}
> -
>  static const struct dma_fence_ops amdgpu_fence_ops = {
>  	.get_driver_name = amdgpu_fence_get_driver_name,
>  	.get_timeline_name = amdgpu_fence_get_timeline_name,
> @@ -933,13 +824,6 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
>  	.release = amdgpu_fence_release,
>  };
>  
> -static const struct dma_fence_ops amdgpu_job_fence_ops = {
> -	.get_driver_name = amdgpu_fence_get_driver_name,
> -	.get_timeline_name = amdgpu_job_fence_get_timeline_name,
> -	.enable_signaling = amdgpu_job_fence_enable_signaling,
> -	.release = amdgpu_job_fence_release,
> -};
> -
>  /*
>   * Fence debugfs
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 7d9bcb72e8dd3..71215aeb1b6f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -128,7 +128,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_ib *ib = &ibs[0];
>  	struct dma_fence *tmp = NULL;
> -	struct amdgpu_fence *af;
> +	struct amdgpu_fence *af, *vm_af;
>  	bool need_ctx_switch;
>  	struct amdgpu_vm *vm;
>  	uint64_t fence_ctx;
> @@ -148,18 +148,20 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	/* ring tests don't use a job */
>  	if (job) {
>  		vm = job->vm;
> -		fence_ctx = job->base.s_fence ?
> -			job->base.s_fence->scheduled.context : 0;
> +		fence_ctx = job->base.s_fence ? job->base.s_fence->finished.context : 0;

Please keep the 80 chars length, otherwise my editor starts to show it in red.

>  		shadow_va = job->shadow_va;
>  		csa_va = job->csa_va;
>  		gds_va = job->gds_va;
>  		init_shadow = job->init_shadow;
> -		af = &job->hw_fence;
> +		af = job->hw_fence;
>  		/* Save the context of the job for reset handling.
>  		 * The driver needs this so it can skip the ring
>  		 * contents for guilty contexts.
>  		 */
> -		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
> +		af->context = fence_ctx;
> +		vm_af = job->hw_vm_fence;
> +		/* the vm fence is also part of the job's context */
> +		vm_af->context = fence_ctx;
>  	} else {
>  		vm = NULL;
>  		fence_ctx = 0;
> @@ -167,7 +169,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		csa_va = 0;
>  		gds_va = 0;
>  		init_shadow = false;
> -		af = NULL;
> +		af = kzalloc(sizeof(*af), GFP_NOWAIT);

Thinking more about it GFP_NOWAIT can fail to easily. Since this is relevant only for the extreme case of an IB test under a device reset it's probably ok to use GFP_ATOMIC and dip into the extra reserve.

Regards,
Christian.

> +		if (!af)
> +			return -ENOMEM;
> +		vm_af = NULL;
>  	}
>  
>  	if (!ring->sched.ready) {
> @@ -289,7 +294,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		amdgpu_ring_init_cond_exec(ring, ring->cond_exe_gpu_addr);
>  	}
>  
> -	r = amdgpu_fence_emit(ring, f, af, fence_flags);
> +	r = amdgpu_fence_emit(ring, af, fence_flags);
>  	if (r) {
>  		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>  		if (job && job->vmid)
> @@ -297,6 +302,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  		amdgpu_ring_undo(ring);
>  		return r;
>  	}
> +	*f = &af->base;
>  
>  	if (ring->funcs->insert_end)
>  		ring->funcs->insert_end(ring);
> @@ -317,7 +323,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>  	 * fence so we know what rings contents to backup
>  	 * after we reset the queue.
>  	 */
> -	amdgpu_fence_save_wptr(*f);
> +	amdgpu_fence_save_wptr(af);
>  
>  	amdgpu_ring_ib_end(ring);
>  	amdgpu_ring_commit(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 311e97c96c4e0..9a78fe01efa3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -138,7 +138,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		   ring->funcs->reset) {
>  		dev_err(adev->dev, "Starting %s ring reset\n",
>  			s_job->sched->name);
> -		r = amdgpu_ring_reset(ring, job->vmid, &job->hw_fence);
> +		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
>  		if (!r) {
>  			atomic_inc(&ring->adev->gpu_reset_counter);
>  			dev_err(adev->dev, "Ring %s reset succeeded\n",
> @@ -185,6 +185,9 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		     struct drm_sched_entity *entity, void *owner,
>  		     unsigned int num_ibs, struct amdgpu_job **job)
>  {
> +	struct amdgpu_fence *af;
> +	int r;
> +
>  	if (num_ibs == 0)
>  		return -EINVAL;
>  
> @@ -192,6 +195,20 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (!*job)
>  		return -ENOMEM;
>  
> +	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	if (!af) {
> +		r = -ENOMEM;
> +		goto err_job;
> +	}
> +	(*job)->hw_fence = af;
> +
> +	af = kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	if (!af) {
> +		r = -ENOMEM;
> +		goto err_fence;
> +	}
> +	(*job)->hw_vm_fence = af;
> +
>  	(*job)->vm = vm;
>  
>  	amdgpu_sync_create(&(*job)->explicit_sync);
> @@ -202,6 +219,13 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		return 0;
>  
>  	return drm_sched_job_init(&(*job)->base, entity, 1, owner);
> +
> +err_fence:
> +	kfree((*job)->hw_fence);
> +err_job:
> +	kfree(*job);
> +
> +	return r;
>  }
>  
>  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
> @@ -251,8 +275,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>  	/* Check if any fences where initialized */
>  	if (job->base.s_fence && job->base.s_fence->finished.ops)
>  		f = &job->base.s_fence->finished;
> -	else if (job->hw_fence.base.ops)
> -		f = &job->hw_fence.base;
> +	else if (job->hw_fence)
> +		f = &job->hw_fence->base;
>  	else
>  		f = NULL;
>  
> @@ -268,11 +292,7 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>  
>  	amdgpu_sync_free(&job->explicit_sync);
>  
> -	/* only put the hw fence if has embedded fence */
> -	if (!job->hw_fence.base.ops)
> -		kfree(job);
> -	else
> -		dma_fence_put(&job->hw_fence.base);
> +	kfree(job);
>  }
>  
>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
> @@ -301,10 +321,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>  	if (job->gang_submit != &job->base.s_fence->scheduled)
>  		dma_fence_put(job->gang_submit);
>  
> -	if (!job->hw_fence.base.ops)
> -		kfree(job);
> -	else
> -		dma_fence_put(&job->hw_fence.base);
> +	kfree(job);
>  }
>  
>  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 931fed8892cc1..077b2414a24b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -48,7 +48,8 @@ struct amdgpu_job {
>  	struct drm_sched_job    base;
>  	struct amdgpu_vm	*vm;
>  	struct amdgpu_sync	explicit_sync;
> -	struct amdgpu_fence	hw_fence;
> +	struct amdgpu_fence	*hw_fence;
> +	struct amdgpu_fence	*hw_vm_fence;
>  	struct dma_fence	*gang_submit;
>  	uint32_t		preamble_status;
>  	uint32_t                preemption_status;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7670f5d82b9e4..901f8bd375212 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -152,11 +152,10 @@ struct amdgpu_fence {
>  
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>  
> -void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>  void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
> -void amdgpu_fence_save_wptr(struct dma_fence *fence);
> +void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
>  
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
> @@ -166,8 +165,8 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>  void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>  int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>  void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> -		      struct amdgpu_fence *af, unsigned int flags);
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
> +		      unsigned int flags);
>  int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>  			      uint32_t timeout);
>  bool amdgpu_fence_process(struct amdgpu_ring *ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index bf42246a3db2f..7d1a363ad6878 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -772,7 +772,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	bool cleaner_shader_needed = false;
>  	bool pasid_mapping_needed = false;
>  	struct dma_fence *fence = NULL;
> -	struct amdgpu_fence *af;
>  	unsigned int patch;
>  	int r;
>  
> @@ -835,13 +834,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>  	}
>  
>  	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
> -		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
> +		r = amdgpu_fence_emit(ring, job->hw_vm_fence, 0);
>  		if (r)
>  			return r;
> -		/* this is part of the job's context */
> -		af = container_of(fence, struct amdgpu_fence, base);
> -		af->context = job->base.s_fence ? job->base.s_fence->finished.context : 0;
>  	}
> +	fence = &job->hw_vm_fence->base;
>  
>  	if (vm_flush_needed) {
>  		mutex_lock(&id_mgr->lock);

