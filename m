Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD34C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 17:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AA2C1379;
	Mon, 25 Jul 2022 17:49:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A0CC1378
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 17:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUrjYcYwhhQTqwzb22bP95XBfNArxi1dfkdzX3eK9UxBxnifBG8lmchGave545qf55ipj0ofrZCHlIwPxkOZNIOKcvgYQnNnMGGhxj3FdhD3v2sEvg6PDCV5lcjy8t/zhBYc54wqOoIny+k3ecObRviLZymQmxEFN5sVqXNjcS+xZcxD0vqY4pmk91sP8U82PADUNUKSqFwaHyeByiv+EK4Kk7IvsU2eP3P5f3rsd03n3ngg+pe/JBo6ZrDzvV1O1v+fEJfUd2V139P1Cmvr/rUeln4nS5ONdlCXUKMO+sIzAzYvQr1KtlaPRliAQvKpF96dbCSLQMGMBbAe20R32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6OUztF10UoXgrWHxGRPatQci82U8oyMWKhFgAK2nAE=;
 b=dzLDCdUvV6Ouj1C5OpMtYxQpmVJL4wrBHzRZKnx3cxCgdYe5DvwPEDHiVh5u2H8q6vZtlRKW+iHL0ThouP1GHQsH9kFNsDgFVn4vZMddQ1G+2+N5KmeDTGbyMR//deronK1SFUrnKP2jyFdhi2ZRMM46bt/wjH0GlJmlvBgMg5WG3xxQmBee6hUcmTkMApAEcKJqQLSBJDVFe3DWkITN+2lIYzqgnLHuD8dA9lQvNtKMhUfxA7LHV4vasZ2cd6ZN5F2reqXPt9EbqCVqwt5x7PBs1HGQ44fr8wdinBZJmPqI1KHR89MAYyYJMeOsxrCwRiU05A1GE9xncjq4TzRDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6OUztF10UoXgrWHxGRPatQci82U8oyMWKhFgAK2nAE=;
 b=w+74HwHLroVYEZVLoVfus5auj6OGmtDTPyKiwUrM/F1oCJC9yz74y+ijlkIwEefx9bhTqvzttzJKdbooPWrFPebADf6vbt1sSlturJ4K/qg1KAnJ7WPSMDzls3o6Lb1+5H8IH9uzLZ4WQw0gbSsMDk9OEGo2gXUIcrp9mqmlBb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 17:49:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 17:49:47 +0000
Message-ID: <da579155-bda5-2740-d831-24c323e4cdfc@amd.com>
Date: Mon, 25 Jul 2022 13:49:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Remove rounding from vram allocation path
Content-Language: en-US
To: Daniel Phillips <daniel.phillips@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220725171441.11695-1-daniel.phillips@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220725171441.11695-1-daniel.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32bdbf23-c605-4c44-d3dd-08da6e66107f
X-MS-TrafficTypeDiagnostic: CO6PR12MB5441:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6kpSeBafUYKfu4HFppWshXGY8PuLAumfGac03ryC2ciYxVzHnJjxgf7egez6vrGHHql8nEVT9OqvjBBvS19mYr1jerQVwwyItiMqO86GeioTHj3v5NhEsujG4qlqkERdR3GrHV3SiNz9ItpCECac6B7lprfZZfe7loEdxcw6+C9ggqrDgn0iKA8zbY8d1T8vpHaLyp5qtdoZ6KGVSpvg85h91Qd0LVC7wXpMi7NpzbRHEItHS0vGcDA+5N0ohJgvA/aUZOplJbvyqlcNveR3nTsmpUfcCb7uOskqwzNGWEQT1+dH3rsIE4FIlSSQYl4Bo9mokeP11Zudr8NZNfFeH+X2jea0LS7BVKUzQiEPQDvYFNp/EXRSErLjLV0HKK9ycsQXFXw/Wht7i2y936lL0yG0P4qHEKThUrHgGeVufonrKysYG8mn/sH7GVlrIUCg5AChWL2HpnQUIHXSO8vLNtvWisKenCFp4ec88XyRaknuiH45RGn8wc4bg9dWz9T7++7LnG3SbUxDLOJFPzMViDCJQ0bH7f/3SH5UMjY5JQ4fDiyNCiDl5bmZmckyw5cKwCEgoGZQzSl6vbhXeyM4HBJuAM5ij96TyUHGB66elcY25pi13v4ZIicHFLyKwHrXtZ2jcR7xxqDCJRj/sxP3Qbo6wsf8sUC4TXVv6DKN9OAiWFqZI2uZi2j2LrkQkib2lfjZ6mQArtdkQIRZn75CO0bDiVIEYNktwKpuNfe9G7dGlL2M2ZNIDU/EsXNP3QwYU2WY3jDXrctohC12zJ9MhxqrXyKgJ1Wk5O5Jai5vtGlL+SAQX6U0TDpELR5r0BsZvaJKm/HQhW+a7xJrrkA4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(38100700002)(31696002)(36756003)(8936002)(186003)(2616005)(2906002)(83380400001)(31686004)(6486002)(6506007)(6666004)(26005)(6512007)(478600001)(86362001)(41300700001)(316002)(44832011)(66476007)(5660300002)(4326008)(8676002)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm1IRUlRWmJlL2hlUWxHMm8zOTIrK21mdHpNWVk0WmlrN1RvajAxdDBubnF1?=
 =?utf-8?B?U3JnL1dPYnlXNmU2S0RXdnBGbHpZNSt1THZLMzZQcjM3Y0dOWXEwbmJaSEhQ?=
 =?utf-8?B?V2l2RCtQWWZ2NnRzR3MvazJGODd2dHNXRkRsdyttVkJhYjk4QUdPMm1mUHVK?=
 =?utf-8?B?M0pKTXBrVG4vWlAyVEp3YndRWjBaWjAxOGFxMzFTRXc3Rm1nZWNFV3ZNd1hi?=
 =?utf-8?B?bEJKd0dLYTJyNG1uOEg1cWNhUlZVbjB2R0FFYTlGN0k3V3kvNkFiU1pFSE15?=
 =?utf-8?B?cGNReEZmKzhaU1hqRFVTcmRiWkYvcFhLWG9xci9vbndCQldmM0Q0Q21kSHRV?=
 =?utf-8?B?SFp6QmdkQmlOVG41d21SZTE3WkliMTExTDF1R3cyMm9ETWtDUW5aUG5qVzJr?=
 =?utf-8?B?WGI1QlprY29HdlRHRGpEa1dJNVU4eUxVeW9iL3BHKysrcm9WTzdCdWVkSGlx?=
 =?utf-8?B?WGJVZFZmakx6eCtCcm9XMGlodVZtUGxJNk1uNkp2WVpZcnljbzE5MnZyZmtU?=
 =?utf-8?B?d1dnNUo1SEN4RnZGbVZpN2gyb3JuclZhN2dld2J0VUtZTGhUL25hT3dJemRQ?=
 =?utf-8?B?OFVTWFlkandsU2VmY3Uva0lLVFNENUVoTnlTTzZ6OVRkMWJPY2YxZHFHOSt2?=
 =?utf-8?B?cGh1MXhsRmczZVc5YU9BLzNteWVhWDhXSWp3NmhUVFFqeW9IUm5pbVk3c0p2?=
 =?utf-8?B?RXl6Y2p6K0h2UmlwL1BKdklibHhxVGRNUTZocmpxYmM3YlZyQ3RvYXVHb3Jm?=
 =?utf-8?B?bkhsWDdQYzIyOGttUG5ydnp3VmMvK0oyRkFJbXNya044aXh0T29hOE1aSFRk?=
 =?utf-8?B?RTl2T2JDSy9XYXcrbHNwN2FwdkFtbjZkbGFvV3FjNlgydUNGUGRwT0Q3TnIx?=
 =?utf-8?B?dXhVQWlIN1NVdjVSZEZkSmNGNjN4RUdxRnNHd1JuTjlUSndHamtad0g1OERo?=
 =?utf-8?B?VTUxVE1KSDdNcmVEWExCT2lhOEh5b2JQLzhWZzFncGhVQ2k2MEd3RHhoRnVw?=
 =?utf-8?B?SkNadzZtekpNMUtSS28wSmpIaXJjSURnMnlBN3luTVpBdXVqK0RUZ3FiN3Yw?=
 =?utf-8?B?cGp4QnU0YUpMVGRwZHp6S1ZKVWIrOUxQcnZFNVRSaFptUHZ3cDVKYXBwQ0s5?=
 =?utf-8?B?TEpLL09pWU4xUlRUSkRxcWVQYjI1WHFYVFpIOTdFY0F1dnFXWDJzQW9EMmFl?=
 =?utf-8?B?ZDAyR01hdVJkQVJVOHAvNERuendzL2s0cmZGdXhiVjJ0TFkvb2EzUkpmUDRX?=
 =?utf-8?B?Q3pYNEI0eXdzWXhTUGprT0VSazFGVFRnMUNKenYrS21vR3JmWlJDbUVab0xC?=
 =?utf-8?B?MnVEM01tMDlOUk0xNFVucjhORUlOdjJTTDNpRy9yc1huSm5VTnNvWC9NL1pG?=
 =?utf-8?B?YWM3bStMQ05xc3U0bXVZQ0tHSVJTSUJHWUZRdjA2NDk1YU02MWx5cXpSM05G?=
 =?utf-8?B?a1poRTNoUDZNb2xXTVh5dlgvTGs2OHdFVUZseEhwUU1WUGJCa1FPb2Y2ZmJn?=
 =?utf-8?B?QUZIVkxEQU8yU3pBSGRXbmxEYXAwQ0xUbjA2ZXZtVzQ3TENReWcvZFRKWklU?=
 =?utf-8?B?SlRqMFlZZXF1dDNFRU5jeWtCYVBIR0JjYzNERWQ5R24vY3hmUUJkVEsrYi8v?=
 =?utf-8?B?YlFwNFNHTFZ4V1BRakpneEJZbzd3blFuUmN1VVhKSmdGbkthWjExNzZSQXpo?=
 =?utf-8?B?d1ZZR0VneFpLV0tJbWtFbEVNNklJTzJGMDQrMkpERHZpd3Nyb3BVOUQ4MlZx?=
 =?utf-8?B?d0czb3NUOU1mZzkvamNsZ2xFbGV4dVE3R3JiUDl5Z3ZTVllna0VQSmhubVNs?=
 =?utf-8?B?bTJ1QmNaL1JwTkc1SnBSQTlCYVd1TE13SlBYTmw1M1p1R3l1VEN5aUhjV1pC?=
 =?utf-8?B?RGZTOXBBVnhLSjZCL25FZnpieGpGblhFdDJhaWN6OVZqc1EzcmIrUGVsSElI?=
 =?utf-8?B?eXhTYTNZTmlndTMrRndQa29tb0tKTVlnYjAzdGVzMXN1SmcvbFFoL2hXSGpx?=
 =?utf-8?B?T3dpRW1KMzM3TVVSODNRQlVSZDVwbzdCQitiSWd4Rit2SUlWMGZFd1VLcjlp?=
 =?utf-8?B?V2xWcXRXZk5rbFc4Qk9hRnRFQUt1UE52WGZzcVlPTHlsT3diVnlsUVh6d3dC?=
 =?utf-8?Q?rCJd4ouXU7+nBvzb8Q5WJeh1L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bdbf23-c605-4c44-d3dd-08da6e66107f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 17:49:47.0441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZnJ7C4E8hxnf4C2PbqwQcrxkSx5E16+mmglLWRY9HV5Plmg8fGN2RI3giplsIYaOSBRgmVuNHLv0VCWPywQbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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

Am 2022-07-25 um 13:14 schrieb Daniel Phillips:
> Rounding up allocations in the allocation path caused test regressions,
> so now just round in the availability path.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 043a808c88a3..014a594899fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -40,10 +40,10 @@
>   #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
>   
>   /*
> - * Align VRAM allocations to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
> + * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
>    * BO chunk
>    */
> -#define VRAM_ALLOCATION_ALIGN (1 << 21)
> +#define VRAM_AVAILABLITY_ALIGN (1 << 21)
>   
>   /* Impose limit on how much memory KFD can use */
>   static struct {
> @@ -149,7 +149,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		 * to avoid fragmentation caused by 4K allocations in the tail
>   		 * 2M BO chunk.
>   		 */
> -		vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
> +		vram_needed = size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		system_mem_needed = size;
>   	} else if (!(alloc_flag &
> @@ -198,7 +198,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   		kfd_mem_limit.system_mem_used -= size;
>   		kfd_mem_limit.ttm_mem_used -= size;
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
> -		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
> +		adev->kfd.vram_used -= size;

To calculate the available size taking potential fragmentation into 
account, we still need to track the aligned VRAM usage somewhere (say 
adev->kfd.vram_used_aligned), and use that in 
amdgpu_amdkfd_get_available_memory instead of adev->kfd.vram_used.

Regards,
   Felix


>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		kfd_mem_limit.system_mem_used -= size;
>   	} else if (!(alloc_flag &
> @@ -1642,7 +1642,6 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
>   	uint64_t reserved_for_pt =
>   		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
>   	size_t available;
> -
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
>   	available = adev->gmc.real_vram_size
>   		- adev->kfd.vram_used
> @@ -1650,7 +1649,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
>   		- reserved_for_pt;
>   	spin_unlock(&kfd_mem_limit.mem_limit_lock);
>   
> -	return ALIGN_DOWN(available, VRAM_ALLOCATION_ALIGN);
> +	return ALIGN_DOWN(available, VRAM_AVAILABLITY_ALIGN);
>   }
>   
>   int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
