Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97817C0015E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 22:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD9210E61C;
	Thu, 27 Jul 2023 22:01:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65CFC10E618
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 22:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQAu0ghnj/ff3ow3TwFBTSqbLDp+mc/54D1eqMKMfBjUTOpmNOo+kRzzCMGSe+HJFtiFkinG3t+blKPUECKYR5xuetFHVACxL1alVIyf9EvFZ/YuyU0E0pyUWfkqQWb2LnaPLhHVDCcBbKkgQZBd9hWX10klzgnUCd19YG+jynkAteeGmlr+LoU/v1+jorhC/kfoyrLukAu0n0dGPP6d9N3wetyLDBN+Jm4cPEp9vwC0e7IgdwdHae6vx+lgHDbuBNTKyn1ShZXs1oOus61KKsckpcXwCK0Mv30V024wd4E+nN8OM7VvtFPmreKVjANsk38ew1MHYBJQheeJ+1ipEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NDuWTUJZKgjO3XfoIJqRXmk+BpoiEYTRiKAzbT6qpk=;
 b=QsDEEUhq6J5f+qJlTfT1TqQ9GgJj2iMFfjyCXlNii4Tnfz1qt9QA7IbTsg8L7I6sXbYMsDcCYvKyQZmRh9svWRo2QQm0UgHFTzhTHCejj7YpOe6WLFQNDk/6k+4FpfX2shsLG+mzAbmWoLCDaPMKaNLFJU/An4egIpS6BFYjaNq0n9EZkyXK4B4DxLFecC6S31uIKDLdsxg8mXkjdYHt2INfWhzpziNLZq8uk/3niV9vHOvG5pyLlx+QMFXcsrt0zw6AB5qBqDQ4pz+Bgi08C609py2keixXc0nRqRxiB5CbmKTxvK2Kl3NIItZPeRjh7WOg8ci8FwKRsdxOpgcDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NDuWTUJZKgjO3XfoIJqRXmk+BpoiEYTRiKAzbT6qpk=;
 b=UU/XRV1s9xStdeFi2VkYp+zKEDmsqmFElt/bT5u7YKxo9Gw475GzFLrmuzYpLjeHxSfaHGp2ndkiD4W0mabPCXAxKeEZdAW02w8ChLN9rT+sycSOCzm2CEKiKbRi5YF7U6QsRShvNP6hd3/AwSyQQLF4/yXFPvbtoq3DVndkoBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 22:01:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 22:01:31 +0000
Message-ID: <185f2f14-5ac2-21b8-0a75-5eb3b9746a12@amd.com>
Date: Thu, 27 Jul 2023 18:01:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] drm/amdgpu: Add EXT_COHERENCE memory allocation flags
Content-Language: en-US
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org,
 "Yat Sin, David" <David.YatSin@amd.com>
References: <20230726133402.2516737-1-David.Francis@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230726133402.2516737-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 2130a880-a11a-4ce3-6d13-08db8eed093b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQdwLPNR9QJO2BuvtYnHa6/EfzP4pbwJNZp1evud1X/qiMbhDYWR4TJBBiFEDrtDP+G0UznBUgRZ7VelVHK9CxFNbD3Rlze+KzLNbcKyFvGsTc81YrizZm8BWMG9fCbnOeyHdiOg1bC7MEIOBY1rXBUIasvHM59146Hn6rRJEPDMyFAWgI47iDk+N67Zut9t9CpAnhuvHSBYbUNKArHymZfyBbrMkHjo1NIbJyu8TjDPdp1KXKoVsExKjo58ytxQ4CRANCu81Mi4Fz6qFQT5REF4KyojXjzbfzNtpY33IxNZZe0y+uhLq9fRTlAJTPu55CfxGWh6uxZiMA2n1fzQtAkemTD6ksYIKQsTLNylvlSYk93OnnId0UP1loghAaYjucEzm4GzP81kPMAEQS4cO6Jp2PetcxCb4aed6EGosogJ1IwFNk7vg0TQKfda+yiHrMeDAYfNDGpcwTKpfWEBtsRtaawu6VAYGjrxJCqoM470+2rw4rTQg9hcbsqksT8Fz1fZIlkBOu1UxghOTiWq3gYQIotlhfBYieODpQGIIx3BGK1LA9WNnSIjsxldpVhjci7iVwAvYPSIOanrlwj0E2+O3nqoDGKYk9J7+daIAeJ3K7gE4pFLXokARA1dyfshqitjjFWmkKCOBYHnkbNhiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(31696002)(36756003)(86362001)(31686004)(38100700002)(478600001)(110136005)(2906002)(41300700001)(2616005)(6506007)(26005)(186003)(8676002)(966005)(6486002)(8936002)(6512007)(5660300002)(66556008)(316002)(66476007)(6636002)(66946007)(83380400001)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2VnSC9tRyszZHVxZ3lsamU1TTFLOHVpRlkycG52QkMyU2huOHc1OEhlcjQ5?=
 =?utf-8?B?V0poZFhaWXFTQWNJQUxSTkRTajJVdXYzV0ZkNTdNa2NadVlwTFF5K2k4V2dz?=
 =?utf-8?B?UFd4ZE4wVldmTGV5bXd3ZmtWN1FweVNHSVJ5RnQxcTJCNVpQdG5PdkNVakd1?=
 =?utf-8?B?akp6c0prbXJiOG53TDEvRi85MWVUYm1tdlZwMjUzY1FQKzVscEtENW1HQTV5?=
 =?utf-8?B?dGFJSjEzTVdBRDYxWHNpYU9VS25UTlAvSVFvMW01NkU4dlZHbkZoVWh1dmN5?=
 =?utf-8?B?TW8vMmxhS0dVWEtESnBxbXRpcjA4T2ZZK2J0VEU1R0ZKOHdqQzJJaTVtM3BS?=
 =?utf-8?B?dnMvb0NxZHZUblBmM05YU2lzYWNOWjZOS0xXUTVJdmgzSU93TXlUQkFYbEVN?=
 =?utf-8?B?cnF1dFk4cjhDcXVPdklaUElMT3hXRlV1c0EyS2lOVXMwSTFLc1RjaEg4UmZS?=
 =?utf-8?B?TjZnZUI2RnBLNWJqMkZRNEdMSG9FTDNUUUw2OWx6dXorNHpVVXZjK3RoZGpI?=
 =?utf-8?B?ZmhrY0lac3JYY2ZWb085VWx6T3NaK3FFL1FNdks3N3EvbHdDdlZ4NGlqYUZn?=
 =?utf-8?B?UWtmYU03eGhsUlR2ODd5cTYyMHRTNWNwdmN4MUR6ZXhVU2RpV09ITjJKV29T?=
 =?utf-8?B?RlY4SEJuUUN0K1ROM1FRcXM2VFhZRldsb3Q2djBqVEk0czhyRW9DbzVoalBn?=
 =?utf-8?B?QmgxbUs0Zk9mNDFkcWJINklVcGs3MHR5TFZ4dlIybS9GYU9EY2pESnFwQ1Vj?=
 =?utf-8?B?SjFkY3JSbFVjd1BpVStPYjdkcFUvbEVJSTlzcU5ERXRSSmhISXZvYkJublRm?=
 =?utf-8?B?WFUxeGVoTnVpbW1aYmZvODhERTlLTGUybXk5NnY4bnpmRjAzZU92dzhlaElX?=
 =?utf-8?B?V090VCtJcVVQWVBNZHRJOGZpOHE1QUJFcm1WVXN2UW1LNVROT1Q5UVFweWV5?=
 =?utf-8?B?aVEra3FlTlJhNE93bkdocWVnSUlrMU55djhKV2lCYTI0VXdLVFdHL01reE5n?=
 =?utf-8?B?YnFOWDRWVmFNYjlLVnB0Z2kwSk5LNzZqcWVXTk5XZUFucnRuczFRQ2UyQ0Ez?=
 =?utf-8?B?djk1UEMvVkJJdHl4OU9kaGpyaUFXNkI4MmpXZkh1K0tLTExhL2FQOFdYaGRq?=
 =?utf-8?B?SnQ5Wko2UExkdFN3N3FhM0Vld0IxNUt3Sm1XaG03cmFQeHNOb1ptcjMrTHpq?=
 =?utf-8?B?Q05KUWFJU3FjZWV0ZlF2MnBqUzkzWUNxUWRMbG5CaXBxTW9TSG92bUlJV3pX?=
 =?utf-8?B?QWxiandGSndyZGxLdmI2ZUJ2a0xKZGVkVDRlVkluY3dFOGRnc3h6SlhXcVNP?=
 =?utf-8?B?QVdGaTd1Z3diTDkrcmlkcU1yZmRpMU9sMzMzNnlPT2dsaCtaK3dlcVd3Smg2?=
 =?utf-8?B?bW8zd21uK0tjZWRHSmxjRXF0RXkyYnBQa0owaHFVRDEyWHJISFlHNUpweXdF?=
 =?utf-8?B?WmtjYWNJMWRhOHdmbHpQSkJ0TjNCck1MVFA4eWJocGhWcjZ3d1pvWFVrbnpS?=
 =?utf-8?B?Yk9iVlNwa1J1M2dvWHRPdVIzbEZQRCtqRWRPZlFsTDVnUE0zZTliNjUzTkp2?=
 =?utf-8?B?SzVlcDZ0enFHN0REaWsxTDlLdnhZOWhUeVJnTTBlWFI0MDk1dmxaTWl5b0NO?=
 =?utf-8?B?NXVzT2lQQWMyZllCUWg0TGhwNnpqVFlHRytUY1FkOTBXcnhwK0h4U001bm1q?=
 =?utf-8?B?c2pQNmdaeDJ3Wmx4RWQzMmtxOUIyZmxlZ3ovdDZIQ3NkbXhZSzJVTUhxMENs?=
 =?utf-8?B?TnV1TUx4SFNXeFJjdzBZVHZIdENyME1Oa3IvZ3kwejB6OGx1eGJ6NnJVbGhS?=
 =?utf-8?B?R1kvVzFZNTltOGRTSC95QlB5RHE5Z1Q0TS90YnhKUmtGNW1veXNZdDJvM1Ey?=
 =?utf-8?B?T3EvSXVRNjIvYUNQMldvdEx2d2dFQXpTREFDU1FMMkZaTHNYWERzSnd6QnEz?=
 =?utf-8?B?NjdIZ2x1L3VxMlI5Q1NISXZQYndzdEdqVllVdFZLNHVRTUNrL0xGaFNDdStY?=
 =?utf-8?B?UXp3T1FVeEl3eERjaktUUXc4ZEg3b0pjcnBKS0FFU0FBK3ZPZEplRVMvUTR0?=
 =?utf-8?B?LytTVnI2d2JBcXdaYlhoYkxNUHNwNUxLQ3phWXRHMUlUMTIyV0RRK2d0T3VQ?=
 =?utf-8?Q?YcBB8nWti3AETz3OaVfBmM86S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2130a880-a11a-4ce3-6d13-08db8eed093b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 22:01:31.8870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFCeNXs1QkcUgGYo7iYf6vfz2qJo44P7Nrh8tRGdB8iPmJ79xC5WGnG0OwMSKgVPNg8ImkfLUg35mLLGbSHfag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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

In amdgpu_dma_buf_create_obj we copy the coherence-related flags to the 
SG BO that's used to attach the BO to the importer device. You need to 
add the new flag to the list.

Some more nit-picks inline.

Am 2023-07-26 um 09:34 schrieb David Francis:
> These flags (for GEM and SVM allocations) allocate
> memory that allows for system-scope atomic semantics.
>
> On GFX943 these flags cause caches to be avoided on
> non-local memory.
>
> On all other ASICs they are identical in functionality to the
> equivalent COHERENT flags.
>
> Corresponding Thunk patch is at
> https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/pull/88
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 ++
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c           |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c           |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            |  5 ++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 10 +++++++++-
>   include/uapi/drm/amdgpu_drm.h                    |  7 +++++++
>   include/uapi/linux/kfd_ioctl.h                   |  3 +++
>   7 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d34c3ef8f3ed..7f23bc0ee592 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1738,6 +1738,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   
>   	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT)
>   		alloc_flags |= AMDGPU_GEM_CREATE_COHERENT;
> +	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENCE)
> +		alloc_flags |= AMDGPU_GEM_CREATE_EXT_COHERENCE;
>   	if (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)
>   		alloc_flags |= AMDGPU_GEM_CREATE_UNCACHED;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 6b430e10d38e..8e951688668b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -632,6 +632,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
>   	}
>   
>   	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +			       AMDGPU_GEM_CREATE_EXT_COHERENCE |
>   			       AMDGPU_GEM_CREATE_UNCACHED))
>   		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
>   			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index a6ee0220db56..ff330c7c0232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -540,6 +540,7 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
>   	}
>   
>   	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +			       AMDGPU_GEM_CREATE_EXT_COHERENCE |
>   			       AMDGPU_GEM_CREATE_UNCACHED))
>   		*flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
>   			 AMDGPU_PTE_MTYPE_NV10(MTYPE_UC);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 880460cd3239..e40fcfc1a3f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1183,7 +1183,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
> -	bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
> +	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT | AMDGPU_GEM_CREATE_EXT_COHERENCE);
> +	bool ext_coherence = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENCE;
>   	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
>   	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
>   	unsigned int mtype_local, mtype;
> @@ -1251,6 +1252,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   		snoop = true;
>   		if (uncached) {
>   			mtype = MTYPE_UC;
> +		} else if (ext_coherence) {
> +			mtype = is_local ? MTYPE_CC : MTYPE_UC;
>   		} else if (adev->flags & AMD_IS_APU) {
>   			mtype = is_local ? mtype_local : MTYPE_NC;
>   		} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 1b50eae051a4..28304b93a990 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1155,7 +1155,8 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   	uint32_t mapping_flags = 0;
>   	uint64_t pte_flags;
>   	bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
> -	bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
> +	bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCTL_SVM_FLAG_EXT_COHERENCE);
> +	bool ext_coherence = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENCE;
>   	bool uncached = false; /*flags & KFD_IOCTL_SVM_FLAG_UNCACHED;*/
>   	unsigned int mtype_local;
>   
> @@ -1203,6 +1204,13 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   		snoop = true;
>   		if (uncached) {
>   			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> +		} else if (ext_coherence) {
> +			/* local HBM region close to partition */
> +			if (bo_node->adev == node->adev &&
> +			    (!bo_node->xcp || !node->xcp || bo_node->xcp->mem_id == node->xcp->mem_id))
> +				mapping_flags |= AMDGPU_VM_MTYPE_CC;
> +			else
> +				mapping_flags |= AMDGPU_VM_MTYPE_UC;
>   		} else if (domain == SVM_RANGE_VRAM_DOMAIN) {
>   			/* local HBM region close to partition */
>   			if (bo_node->adev == node->adev &&
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 79b14828d542..d67102dc214a 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -158,6 +158,13 @@ extern "C" {
>    * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
>    */
>   #define AMDGPU_GEM_CREATE_UNCACHED		(1 << 14)
> +/* Flag that BO should be coherent across devices when using device-level
> + * atomics. May depend on GPU instructions to flush caches explicitly.
> + *
> + * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs and
> + * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
> + */
> +#define AMDGPU_GEM_CREATE_EXT_COHERENCE		(1 << 15)

The name of this flag is a noun, which is inconsistent with the existing 
flag AMDGPU_GEM_CREATE_COHERENT (adjective). Please change the name to 
KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT

The comment should say something about how these two flags differ. I'd 
update the comment for AMDGPU_GEM_CREATE_COHERENT to say "May depend on 
GPU instructions to flush caches to system scope explicitly". And this 
one to say "May depend on GPU instructions to flush caches to device 
scope explicitly, promoting them to system scope automatically".


>   
>   struct drm_amdgpu_gem_create_in  {
>   	/** the requested memory size */
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index eeb2fdcbdcb7..dd8f0dba7631 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -405,6 +405,7 @@ struct kfd_ioctl_acquire_vm_args {
>   #define KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM	(1 << 27)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT	(1 << 26)
>   #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED	(1 << 25)
> +#define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENCE	(1 << 24)

..._COHERENT


>   
>   /* Allocate memory for later SVM (shared virtual memory) mapping.
>    *
> @@ -659,6 +660,8 @@ enum kfd_mmio_remap {
>   #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
>   /* Keep GPU memory mapping always valid as if XNACK is disable */
>   #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
> +/* Fine grained coherency between all devices using device-scope atomics */
> +#define KFD_IOCTL_SVM_FLAG_EXT_COHERENCE       0x00000080

..._COHERENT

Regards,
   Felix


>   
>   /**
>    * kfd_ioctl_svm_op - SVM ioctl operations
