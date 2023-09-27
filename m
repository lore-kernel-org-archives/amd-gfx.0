Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DD3E82CAE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 16:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E8610E576;
	Wed, 27 Sep 2023 16:49:16 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B144710E56E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 16:49:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5gYdsu/ziopFqfsqnlJypjNjmPAzn3hknWde+6TrvEfSW/NFTVgp4O4joebEus0o+JOJUgtwOgJ9XYzgXbNYIo+iNk6ToTUd4E7N5PxFn0gWKmptY7VVtpRtSvzlGzrxbgbmRAmW4yHJzPA2ZgOfnAeXwR6rxUhuWOAOZI8qqXKBa3n+KU/echZwIUya7sJGiAXzm4odntDnk9lAgXh0Pi5dOeJn05UgNQhyWeq0awXY9ppTlO4KxMR7ROYoW5Mib3xs4Yeg4GqB48WwyskrFRt3XuZ03ldG1Tn82nYLl370Po2bTBOgx6jCxb11W+1DzQHrLm+stc9ifSwHqXtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKE4wDFfO19nfR4QdQ55wcSe5OPwd3b1BB4iyhLfBTs=;
 b=naK2yZxqmfzZaV0EB1dSsfw4gxzCI7xUOlMsE1xIS6YH4wQJyQ6lz1M+v/AcPRF1E9qTfwOijkpehEs6U7xjzJVAsuXjbx/sbEl4nq8giJi3M0dwfvqVCJy6wsY7VYApZWnGu2Q51jIyYJ2c6yqJq8dxl+SU76RbgMOlsCCIU/DuuaEuhRazaDaXRN4gGlRjN1KZXgEox8LHNSUQdyVQtlyQspVe5qBzsFkp93XHNh3qPsg0Tx0xFoSSRL79++rrJuijcr0dcqtd68e/v8DD1IP7pRbIGgfpg2GqZCUXX2oauK0532myT6ZBBUicKn5Inv6am2isfSUFoKR4ZkonVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKE4wDFfO19nfR4QdQ55wcSe5OPwd3b1BB4iyhLfBTs=;
 b=1DSTqCXY7o3RG4ntbCC6Z6R9UsmVCQ4QO8l+lpAe4+oYTdp5MQDhhaXwUvKDmwQpOnjY6jL+8sL+6J8w4EIcuK+zLHFoOTEwT21HuVm0aJrMj2wRd57PT6Tn2CxPTNUF+gRrt8ZVIrykOI0VDftTZ5FSp4h5/dqHkJoAcold/8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 16:49:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 16:49:10 +0000
Message-ID: <717d4b08-42ae-478f-af94-d52704d6cfbf@amd.com>
Date: Wed, 27 Sep 2023 12:49:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: drop struct kfd_cu_info
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230926163938.1013775-1-alexander.deucher@amd.com>
 <20230926163938.1013775-2-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230926163938.1013775-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::49) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3e511b-d2b2-4922-e187-08dbbf79abd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGZVL5lsz6eTvlwaVXl7ZVlwotEf277FUwbdETVfxEEo1KlWhI2VQDtQ+1YNQ0eHJMzl4aDvan+EG/uPCR0T4cshcxs/e51JSPlfoK2Wkj7JvkVhWRz55JM0oq3VMA3E1r/4GnZopadPKXfeAQNjcXaYju/mzCVFsW6bKtDhrA1BrxODs30Ty0wHug57sF59cyuZEqS1FO5q1C7twUHoamvD7qsjPOsbsYiFrLOwLHKNRofLNjQvN0z8GTN3Vxp1VzuO74jLx4f30872PivnxLHoU0mLwON2KD8VPxHHLWZZUBTeI8SkSsjgJGD7d1Jk+wBPdjmKtcy7Bd7fNHOF/aUbaa8/0X5uarnEVkfgpMrCrR9NZ5izauxvj3JNEvnWXd5AKKBFGo1r+QqpLXfLLYQg6flTieibwJAEELsONsafCsVd6v3u6VyX5DPJoj/cum42UAOVyxpKS95fgRat+9YD7PLAyj8vE5vVDIVspGwUVTBJy/RWmqW291suJPXJrqmQMq+S+kIsTbqU86nCkdOB+HiX2jINetHVVhEYTUvc8TguyIGP1ygDlNv1iRi7xozHJbKBgDmDRltZxJr8ZoYVynYRaxyEMI+XxkutSUixXwxEr3n/6odl+K4NoReazD3p0wjALljTzGcKV3SFPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(478600001)(83380400001)(38100700002)(30864003)(2616005)(316002)(26005)(66476007)(66556008)(66946007)(2906002)(31696002)(41300700001)(5660300002)(4326008)(6512007)(53546011)(6666004)(6506007)(6486002)(44832011)(31686004)(36756003)(86362001)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmNYZXJYdEJxUlRtYTZPTWtJb3ptdnV3K3lKOHFpWUhyZUpDcDBDQmU2ZVdz?=
 =?utf-8?B?YTBLMTcwUjRBbzFjZDFveU5tRFEwaFQ4YStha3JGZGNCc2ZTYzFVUk9xNG5o?=
 =?utf-8?B?QjJDYkhvNCtKdHgwNzVSd205YkhEZkdGSVQ0UUhOcUdUZlpObiswcFlWZWJ0?=
 =?utf-8?B?RXR6ZE1pdmlxMTMvMlpQWW85WmhsTGlBL1dDQmgydmtPdm1OeFMrMDFTMk42?=
 =?utf-8?B?TGM2TzArb3NjTzRvQjlONkdwT1hlVC85blVsY3g2UXMrTjF0bWhqVkp1NGd5?=
 =?utf-8?B?VVpEMHErdUpLejNSdDRTbFdGL1g3dmx2Z2hGTzcwaGZjV2I1TDVWTlJjT2dN?=
 =?utf-8?B?TEtXTlhjSTNhZm0xc3RSd3pTUS9tS0xJc21USCtuNnQ2VVRPSjRXREFsbDQr?=
 =?utf-8?B?UFlBcHV3RVIzbysxV2RnWE9uZ1YwZExWcW04OEg2R3E3QlJDRmJPdlYxaEZS?=
 =?utf-8?B?MTJkZXBlU2YyLzhpV0JNblYyUExsVHRwSTVEcFRlQ0dDZGF3cy9oQjV4NVVU?=
 =?utf-8?B?WmEyQzJ6WEpEdTBMWDJQOHJPVE95RHJoTXdCZlBxRkNNUTFrcktnWHZxbitO?=
 =?utf-8?B?dVNyRldPNTdidzBvZnhxZzN2K0ZlMStsTit6UzQyWFFURCtRQnFhd0lDZCtI?=
 =?utf-8?B?dVI5RGhMUEZIb1N2djdBSVhaQWx5TG9kZ3VDYnV2ZytsQUthRmVmem1ueWoy?=
 =?utf-8?B?TWZHYXJrOTRmd1VpaldRaHlTQU5pWG5rQzUvZFFtWi9Za2kvWi9vNVRWc09J?=
 =?utf-8?B?QjJnRUxuMnAxMUx5L1RGTGlPYkVna0hXbE0xTUM2ZE10MDVEK1JIK2RFdCtl?=
 =?utf-8?B?L3dKQ3V4bDFmVm9RTmNTRlFDc0pYM3ppekh6dUM1RVlETlRNZ1N1Yy9yZ3FH?=
 =?utf-8?B?bllIVDV1clV5aDRnUDBIYzh1RjZ4aFExWWd2OFpXclJIWkp4NEJjdGZQa3FB?=
 =?utf-8?B?Rnh2dk8vOWRhaVg4N2tSVTBhY2VqQnYveGtubmpNWXZoYW5Qa0k0d05hTG1R?=
 =?utf-8?B?MU4vTFJVVjNsVFRDREMyc3NiUzFiU0Jsa25sOTFtWFdkYTNsK3Z0OHJuc21H?=
 =?utf-8?B?dUZ2VFphRlJRUklVWC9lWGZZbVZOallBcXlPYk5SZVNCV1J2UWNJVGVHWVJW?=
 =?utf-8?B?azI1RzhTZitSaGs4Mndib2xuNko3Y1lRRDE0S2xGV0xxS0R3SDRwc0MzNCtM?=
 =?utf-8?B?S29hWXlTOHhlZlFjdmZnZC9IUitEK1RpOUlZU2IycU1DemdIRy9sM3AyR1Rr?=
 =?utf-8?B?WlRmSDZGU29ZSUVKMlk2QVhoY3Vlc1YycFhsQ3Y3N1BCczZJRlo2ckx4R0hv?=
 =?utf-8?B?OGtibHQ2S0w1MkFhbVRsL000ZzQ4aHFFQitNblZaNjZjTEpzemhYT1UzQWU0?=
 =?utf-8?B?TlBPRytCNWNtZEFyWk1GcnRyd3F1SFkvU1ZVQW9Mb2xzSExvWVZIRktXTk1E?=
 =?utf-8?B?SEZJMFFoa29uN201SkpNTzhuTlR2aTNrRE1tOE93bHlhY2dKYTM2VDlMMGhE?=
 =?utf-8?B?UTNzdFkvR0Z5MGFZK3kzdDI2NjFaYmtBVVQ5bmhJMUtORVFpU2NIUzNmQUpr?=
 =?utf-8?B?STRZWStVWUhUVFcvSklOUWNKT296RFd0ZWxSbWVhSWI3Nk0zaGRpRWVEK2FQ?=
 =?utf-8?B?N25Ya0dnTzBOUWhDVmwxSCtvb29UbDFHbzV2dFc5VFRxaFdrcnEwbmQvdW9k?=
 =?utf-8?B?cW9iSm9WcERsN1oyTm51SXVRbnFSMHZ3dkt6ZWhKcmpSM3puOUliSlZLeFlG?=
 =?utf-8?B?MGdtcTZGZWowVHpNdzZFT2IyMnhUbVBLUEcxRGJ3M3JwOFdWUjdJRDV5dDFi?=
 =?utf-8?B?bzB6WGVydXV3dXJMRE5ya0dmNmJzYW1Qbi8yUG5jeEQydHE0dE54OTBnc3Y2?=
 =?utf-8?B?WlYxaDNGdkN1eWJJZUo5THk0YzVEZ01PRjlhMURPZFZWdGovY1pFb3lpQ3JH?=
 =?utf-8?B?M1hEWDMrYVo2ejM4WjN6ZzRKLzRoZ0JadjF6MmNSTUlKbFFhL0VNUEg3bHhD?=
 =?utf-8?B?aUs4TStON25DbXdWRjJBVUROcUtmeXpTMk54c2NTZ3RFVXpZVzh2VTk2UW5W?=
 =?utf-8?B?cWFydGNzWXZ2ZkllQlUrL0U3L2ZKVFN0bzJvVkczUkJpY2RlWXRsOTlyK2Vv?=
 =?utf-8?Q?yc27s0M7KMWJ0gY5kcAWudADH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3e511b-d2b2-4922-e187-08dbbf79abd2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:49:09.9546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3f2NiJBIMWR7ihtk201HvufYe3QBOv3xKYKsVfq7LwSQt0M6uRPC5+MFDh69fEp0caGkX46KkbIeSFKN+GW1sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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
Cc: Arnd Bergmann <arnd@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-26 12:39, Alex Deucher wrote:
> I think this was an abstraction back from when
> kfd supported both radeon and amdgpu.  Since we just
> support amdgpu now, there is no more need for this and
> we can use the amdgpu structures directly.
>
> This also avoids having the kfd_cu_info structures on
> the stack when inlining which can blow up the stack.
>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Thanks for this cleanup. The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 22 ---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 -
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 28 +++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 28 +++++------
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 49 ++++++++-----------
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   | 14 ------
>   6 files changed, 48 insertions(+), 95 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 38b5457baded..d95fd76102d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -467,28 +467,6 @@ uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev)
>   		return 100;
>   }
>   
> -void amdgpu_amdkfd_get_cu_info(struct amdgpu_device *adev, struct kfd_cu_info *cu_info)
> -{
> -	struct amdgpu_cu_info acu_info = adev->gfx.cu_info;
> -
> -	memset(cu_info, 0, sizeof(*cu_info));
> -	if (sizeof(cu_info->cu_bitmap) != sizeof(acu_info.bitmap))
> -		return;
> -
> -	cu_info->cu_active_number = acu_info.number;
> -	cu_info->cu_ao_mask = acu_info.ao_cu_mask;
> -	memcpy(&cu_info->cu_bitmap[0], &acu_info.bitmap[0],
> -	       sizeof(cu_info->cu_bitmap));
> -	cu_info->num_shader_engines = adev->gfx.config.max_shader_engines;
> -	cu_info->num_shader_arrays_per_engine = adev->gfx.config.max_sh_per_se;
> -	cu_info->num_cu_per_sh = adev->gfx.config.max_cu_per_sh;
> -	cu_info->simd_per_cu = acu_info.simd_per_cu;
> -	cu_info->max_waves_per_simd = acu_info.max_waves_per_simd;
> -	cu_info->wave_front_size = acu_info.wave_front_size;
> -	cu_info->max_scratch_slots_per_cu = acu_info.max_scratch_slots_per_cu;
> -	cu_info->lds_size = acu_info.lds_size;
> -}
> -
>   int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>   				  struct amdgpu_device **dmabuf_adev,
>   				  uint64_t *bo_size, void *metadata_buffer,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 609a6fefd85f..3ad8dc523b42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -236,8 +236,6 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>   uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev);
>   
>   uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev);
> -void amdgpu_amdkfd_get_cu_info(struct amdgpu_device *adev,
> -			       struct kfd_cu_info *cu_info);
>   int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
>   				  struct amdgpu_device **dmabuf_adev,
>   				  uint64_t *bo_size, void *metadata_buffer,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 9459603804b9..0e792a8496d6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -2038,11 +2038,12 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   				      uint32_t proximity_domain)
>   {
>   	struct crat_header *crat_table = (struct crat_header *)pcrat_image;
> +	struct amdgpu_gfx_config *gfx_info = &kdev->adev->gfx.config;
> +	struct amdgpu_cu_info *cu_info = &kdev->adev->gfx.cu_info;
>   	struct crat_subtype_generic *sub_type_hdr;
>   	struct kfd_local_mem_info local_mem_info;
>   	struct kfd_topology_device *peer_dev;
>   	struct crat_subtype_computeunit *cu;
> -	struct kfd_cu_info cu_info;
>   	int avail_size = *size;
>   	uint32_t total_num_of_cu;
>   	uint32_t nid = 0;
> @@ -2086,21 +2087,20 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>   	cu->flags |= CRAT_CU_FLAGS_GPU_PRESENT;
>   	cu->proximity_domain = proximity_domain;
>   
> -	amdgpu_amdkfd_get_cu_info(kdev->adev, &cu_info);
> -	cu->num_simd_per_cu = cu_info.simd_per_cu;
> -	cu->num_simd_cores = cu_info.simd_per_cu *
> -			(cu_info.cu_active_number / kdev->kfd->num_nodes);
> -	cu->max_waves_simd = cu_info.max_waves_per_simd;
> +	cu->num_simd_per_cu = cu_info->simd_per_cu;
> +	cu->num_simd_cores = cu_info->simd_per_cu *
> +			(cu_info->number / kdev->kfd->num_nodes);
> +	cu->max_waves_simd = cu_info->max_waves_per_simd;
>   
> -	cu->wave_front_size = cu_info.wave_front_size;
> -	cu->array_count = cu_info.num_shader_arrays_per_engine *
> -		cu_info.num_shader_engines;
> -	total_num_of_cu = (cu->array_count * cu_info.num_cu_per_sh);
> +	cu->wave_front_size = cu_info->wave_front_size;
> +	cu->array_count = gfx_info->max_sh_per_se *
> +		gfx_info->max_shader_engines;
> +	total_num_of_cu = (cu->array_count * gfx_info->max_cu_per_sh);
>   	cu->processor_id_low = get_and_inc_gpu_processor_id(total_num_of_cu);
> -	cu->num_cu_per_array = cu_info.num_cu_per_sh;
> -	cu->max_slots_scatch_cu = cu_info.max_scratch_slots_per_cu;
> -	cu->num_banks = cu_info.num_shader_engines;
> -	cu->lds_size_in_kb = cu_info.lds_size;
> +	cu->num_cu_per_array = gfx_info->max_cu_per_sh;
> +	cu->max_slots_scatch_cu = cu_info->max_scratch_slots_per_cu;
> +	cu->num_banks = gfx_info->max_shader_engines;
> +	cu->lds_size_in_kb = cu_info->lds_size;
>   
>   	cu->hsa_capability = 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 447829c22295..050a6936ff84 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -99,7 +99,8 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   		const uint32_t *cu_mask, uint32_t cu_mask_count,
>   		uint32_t *se_mask, uint32_t inst)
>   {
> -	struct kfd_cu_info cu_info;
> +	struct amdgpu_cu_info *cu_info = &mm->dev->adev->gfx.cu_info;
> +	struct amdgpu_gfx_config *gfx_info = &mm->dev->adev->gfx.config;
>   	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
>   	bool wgp_mode_req = KFD_GC_VERSION(mm->dev) >= IP_VERSION(10, 0, 0);
>   	uint32_t en_mask = wgp_mode_req ? 0x3 : 0x1;
> @@ -108,9 +109,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   	int inc = cu_inc * NUM_XCC(mm->dev->xcc_mask);
>   	int xcc_inst = inst + ffs(mm->dev->xcc_mask) - 1;
>   
> -	amdgpu_amdkfd_get_cu_info(mm->dev->adev, &cu_info);
> -
> -	cu_active_per_node = cu_info.cu_active_number / mm->dev->kfd->num_nodes;
> +	cu_active_per_node = cu_info->number / mm->dev->kfd->num_nodes;
>   	if (cu_mask_count > cu_active_per_node)
>   		cu_mask_count = cu_active_per_node;
>   
> @@ -118,13 +117,14 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   	 * Returning with no CU's enabled will hang the queue, which should be
>   	 * attention grabbing.
>   	 */
> -	if (cu_info.num_shader_engines > KFD_MAX_NUM_SE) {
> -		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n", cu_info.num_shader_engines);
> +	if (gfx_info->max_shader_engines > KFD_MAX_NUM_SE) {
> +		pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n",
> +		       gfx_info->max_shader_engines);
>   		return;
>   	}
> -	if (cu_info.num_shader_arrays_per_engine > KFD_MAX_NUM_SH_PER_SE) {
> +	if (gfx_info->max_sh_per_se > KFD_MAX_NUM_SH_PER_SE) {
>   		pr_err("Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
> -			cu_info.num_shader_arrays_per_engine * cu_info.num_shader_engines);
> +			gfx_info->max_sh_per_se * gfx_info->max_shader_engines);
>   		return;
>   	}
>   
> @@ -142,10 +142,10 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   	 * See note on Arcturus cu_bitmap layout in gfx_v9_0_get_cu_info.
>   	 * See note on GFX11 cu_bitmap layout in gfx_v11_0_get_cu_info.
>   	 */
> -	for (se = 0; se < cu_info.num_shader_engines; se++)
> -		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++)
> +	for (se = 0; se < gfx_info->max_shader_engines; se++)
> +		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++)
>   			cu_per_sh[se][sh] = hweight32(
> -				cu_info.cu_bitmap[xcc_inst][se % 4][sh + (se / 4) *
> +				cu_info->bitmap[xcc_inst][se % 4][sh + (se / 4) *
>   				cu_bitmap_sh_mul]);
>   
>   	/* Symmetrically map cu_mask to all SEs & SHs:
> @@ -184,13 +184,13 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   	 *
>   	 * First ensure all CUs are disabled, then enable user specified CUs.
>   	 */
> -	for (i = 0; i < cu_info.num_shader_engines; i++)
> +	for (i = 0; i < gfx_info->max_shader_engines; i++)
>   		se_mask[i] = 0;
>   
>   	i = inst;
>   	for (cu = 0; cu < 16; cu += cu_inc) {
> -		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
> -			for (se = 0; se < cu_info.num_shader_engines; se++) {
> +		for (sh = 0; sh < gfx_info->max_sh_per_se; sh++) {
> +			for (se = 0; se < gfx_info->max_shader_engines; se++) {
>   				if (cu_per_sh[se][sh] > cu) {
>   					if (cu_mask[i / 32] & (en_mask << (i % 32)))
>   						se_mask[se] |= en_mask << (cu + sh * 16);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3f9f882d3f5c..4e530791507e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1533,7 +1533,6 @@ static int kfd_dev_create_p2p_links(void)
>   /* Helper function. See kfd_fill_gpu_cache_info for parameter description */
>   static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
>   				struct kfd_gpu_cache_info *pcache_info,
> -				struct kfd_cu_info *cu_info,
>   				int cu_bitmask,
>   				int cache_type, unsigned int cu_processor_id,
>   				int cu_block)
> @@ -1595,7 +1594,8 @@ static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
>   /* Helper function. See kfd_fill_gpu_cache_info for parameter description */
>   static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>   				struct kfd_gpu_cache_info *pcache_info,
> -				struct kfd_cu_info *cu_info,
> +				struct amdgpu_cu_info *cu_info,
> +				struct amdgpu_gfx_config *gfx_info,
>   				int cache_type, unsigned int cu_processor_id,
>   				struct kfd_node *knode)
>   {
> @@ -1606,7 +1606,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>   
>   	start = ffs(knode->xcc_mask) - 1;
>   	end = start + NUM_XCC(knode->xcc_mask);
> -	cu_sibling_map_mask = cu_info->cu_bitmap[start][0][0];
> +	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
>   	cu_sibling_map_mask &=
>   		((1 << pcache_info[cache_type].num_cu_shared) - 1);
>   	first_active_cu = ffs(cu_sibling_map_mask);
> @@ -1642,15 +1642,15 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>   		k = 0;
>   
>   		for (xcc = start; xcc < end; xcc++) {
> -			for (i = 0; i < cu_info->num_shader_engines; i++) {
> -				for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
> +			for (i = 0; i < gfx_info->max_shader_engines; i++) {
> +				for (j = 0; j < gfx_info->max_sh_per_se; j++) {
>   					pcache->sibling_map[k] = (uint8_t)(cu_sibling_map_mask & 0xFF);
>   					pcache->sibling_map[k+1] = (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
>   					pcache->sibling_map[k+2] = (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
>   					pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
>   					k += 4;
>   
> -					cu_sibling_map_mask = cu_info->cu_bitmap[xcc][i % 4][j + i / 4];
> +					cu_sibling_map_mask = cu_info->bitmap[xcc][i % 4][j + i / 4];
>   					cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
>   				}
>   			}
> @@ -1675,16 +1675,14 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
>   	unsigned int cu_processor_id;
>   	int ret;
>   	unsigned int num_cu_shared;
> -	struct kfd_cu_info cu_info;
> -	struct kfd_cu_info *pcu_info;
> +	struct amdgpu_cu_info *cu_info = &kdev->adev->gfx.cu_info;
> +	struct amdgpu_gfx_config *gfx_info = &kdev->adev->gfx.config;
>   	int gpu_processor_id;
>   	struct kfd_cache_properties *props_ext;
>   	int num_of_entries = 0;
>   	int num_of_cache_types = 0;
>   	struct kfd_gpu_cache_info cache_info[KFD_MAX_CACHE_TYPES];
>   
> -	amdgpu_amdkfd_get_cu_info(kdev->adev, &cu_info);
> -	pcu_info = &cu_info;
>   
>   	gpu_processor_id = dev->node_props.simd_id_base;
>   
> @@ -1711,12 +1709,12 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
>   		cu_processor_id = gpu_processor_id;
>   		if (pcache_info[ct].cache_level == 1) {
>   			for (xcc = start; xcc < end; xcc++) {
> -				for (i = 0; i < pcu_info->num_shader_engines; i++) {
> -					for (j = 0; j < pcu_info->num_shader_arrays_per_engine; j++) {
> -						for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
> +				for (i = 0; i < gfx_info->max_shader_engines; i++) {
> +					for (j = 0; j < gfx_info->max_sh_per_se; j++) {
> +						for (k = 0; k < gfx_info->max_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
>   
> -							ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
> -										pcu_info->cu_bitmap[xcc][i % 4][j + i / 4], ct,
> +							ret = fill_in_l1_pcache(&props_ext, pcache_info,
> +										cu_info->bitmap[xcc][i % 4][j + i / 4], ct,
>   										cu_processor_id, k);
>   
>   							if (ret < 0)
> @@ -1729,9 +1727,9 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
>   
>   							/* Move to next CU block */
>   							num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
> -								pcu_info->num_cu_per_sh) ?
> +								gfx_info->max_cu_per_sh) ?
>   								pcache_info[ct].num_cu_shared :
> -								(pcu_info->num_cu_per_sh - k);
> +								(gfx_info->max_cu_per_sh - k);
>   							cu_processor_id += num_cu_shared;
>   						}
>   					}
> @@ -1739,7 +1737,7 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
>   			}
>   		} else {
>   			ret = fill_in_l2_l3_pcache(&props_ext, pcache_info,
> -					pcu_info, ct, cu_processor_id, kdev);
> +						   cu_info, gfx_info, ct, cu_processor_id, kdev);
>   
>   			if (ret < 0)
>   				break;
> @@ -1918,10 +1916,11 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   {
>   	uint32_t gpu_id;
>   	struct kfd_topology_device *dev;
> -	struct kfd_cu_info *cu_info;
>   	int res = 0;
>   	int i;
>   	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
> +	struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
> +	struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
>   
>   	gpu_id = kfd_generate_gpu_id(gpu);
>   	if (gpu->xcp && !gpu->xcp->ddev) {
> @@ -1959,12 +1958,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	/* Fill-in additional information that is not available in CRAT but
>   	 * needed for the topology
>   	 */
> -	cu_info = kzalloc(sizeof(struct kfd_cu_info), GFP_KERNEL);
> -	if (!cu_info)
> -		return -ENOMEM;
> -
> -	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, cu_info);
> -
>   	for (i = 0; i < KFD_TOPOLOGY_PUBLIC_NAME_SIZE-1; i++) {
>   		dev->node_props.name[i] = __tolower(asic_name[i]);
>   		if (asic_name[i] == '\0')
> @@ -1973,7 +1966,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	dev->node_props.name[i] = '\0';
>   
>   	dev->node_props.simd_arrays_per_engine =
> -		cu_info->num_shader_arrays_per_engine;
> +		gfx_info->max_sh_per_se;
>   
>   	dev->node_props.gfx_target_version =
>   				gpu->kfd->device_info.gfx_target_version;
> @@ -2054,7 +2047,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	 */
>   	if (dev->gpu->adev->asic_type == CHIP_CARRIZO) {
>   		dev->node_props.simd_count =
> -			cu_info->simd_per_cu * cu_info->cu_active_number;
> +			cu_info->simd_per_cu * cu_info->number;
>   		dev->node_props.max_waves_per_simd = 10;
>   	}
>   
> @@ -2081,8 +2074,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   
>   	kfd_notify_gpu_change(gpu_id, 1);
>   
> -	kfree(cu_info);
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index 255adc30f802..6d094cf3587d 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -57,20 +57,6 @@ struct kfd_vm_fault_info {
>   	bool		prot_exec;
>   };
>   
> -struct kfd_cu_info {
> -	uint32_t num_shader_engines;
> -	uint32_t num_shader_arrays_per_engine;
> -	uint32_t num_cu_per_sh;
> -	uint32_t cu_active_number;
> -	uint32_t cu_ao_mask;
> -	uint32_t simd_per_cu;
> -	uint32_t max_waves_per_simd;
> -	uint32_t wave_front_size;
> -	uint32_t max_scratch_slots_per_cu;
> -	uint32_t lds_size;
> -	uint32_t cu_bitmap[AMDGPU_MAX_GC_INSTANCES][4][4];
> -};
> -
>   /* For getting GPU local memory information from KGD */
>   struct kfd_local_mem_info {
>   	uint64_t local_mem_size_private;
