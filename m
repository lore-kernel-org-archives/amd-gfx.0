Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A82C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 16:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FB410E3D2;
	Wed, 12 Jan 2022 16:08:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 315A010E3D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 16:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpVR+KHpALmpLCeT+MAAUHvYFqEU/NMsXpJYjVafIRS9lbfy1/UzYCng1zXnKxNbQMh2x/gxoEyMwIGp+OFVM5XgPyop6N2gbVyL6ddCcw6tsBsuGSYDl6w8rGHoHSUmmpRexUG+ulueV6IqSs4qJM+vcP0Vn81b2p4paZP9Kqt2zDUC6MXJjQNZNLWXUpjir6UKSYFFDJYb4XufSaA4ewwfWBu+x1QkB8elcV/DMAuyaKJFMVAvH8ilMdPVhaj4z8wz8Tfwe4eY/5D3d9LDxSq6RpopZPGKJh5gnvFajIZIFYEoxfMfbnwoPcV7DzyJTJv2tX3RtaNkdKK/5HuiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGfBhsoWrxCoYYZf0soPFtnaU8XngmmsMWd3tEp/9uc=;
 b=Nu0lZteMcol49tvkHnCdVJlTqE7D5XnsoE9nCcQ6OhxVbmNv3hIg8uFbJUv62kqOBnCJejV9kwlaNohzcd8Q5HxkjK8fMBduZvTplvXIYudJ5D2DZKXh/vLqX8NmI8Fvhs+Z7CXkhIDP0ZYJdPDpNVOvWcfhNLB8SuwDcYKctH8ZKpA4tsHCBvCyhuwh3oBDmwJcgjcnYBIIPmVs19tmEHPDGS+VxCr/YpeteqjegTWJKfKKz79gR9R1fqFus39r7xJ9ukXWifLOL1oJiqYw5ayTkItvJdHgw0inLbw1+JqOwTJCkh8UyeqgHo1FkQMv1gfyFMng/muTAXkqigqJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGfBhsoWrxCoYYZf0soPFtnaU8XngmmsMWd3tEp/9uc=;
 b=tBh2dv5FOp8scQ65e3PExeiRax8a+sF9veCxvBVNe6pBK8ImM/2JFOY7Q0xRpe8yCxajXhCLr1/d2wYJqngSRWW8IQAgll/BOrZhL11G5E6BjH6CTmk8jtRH/wP22hx2BcL0P2eZJTbvJ14JcxrZxkrJdrzxSnvQC6VKqnehrCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by DM5PR12MB2486.namprd12.prod.outlook.com
 (2603:10b6:4:b2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 16:08:47 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 16:08:47 +0000
Subject: Re: [PATCH] drm/amdgpu: cleanup ttm debug sdma vram access function
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220112155945.2466798-1-jonathan.kim@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <70ceee8f-04f9-205f-93e2-a589d7af2035@amd.com>
Date: Wed, 12 Jan 2022 17:08:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220112155945.2466798-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR0301CA0057.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::11) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a9d5037-5f9a-4197-b784-08d9d5e5d06c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB24866A8A68BD8ED81BBEE4F983529@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcjCRnKoDUrOteY4kIXGiv0oJBtOgBm/XxHSxFGddxkp6eqqbQcjGihPE2fLOWMJzccaKEpQo6yW4AaKCuMr5NB3ubwwHep8HMJ3Bpsq9OiZmnsIADIbq7DvbDiKWKPVzSqfgwaYfh0MpvBPVg1MF9Fh/ixXJ8u6VNrF+9zJvsOU/4amMB/mJkr3WUbNGqtEQxhn9mRtmEkLBdQ3QpURe0yi6vJz2BXkEh5ta3WxcxPgcXUJ9RWqqiskFRcRVVMl9MOnkRIm6MyWjWlKyoVqzACcQdzMViKWSKrT56GBhcbaw2kj81siXfQqGePUbuu5zkBy/J6sjhE/IX0jgKRZM7FfAQvWZ2gNZIpFszZYkcG6DFsXaPduLlE2rZ/sH0UdmzR+0PM4g3cxIQ8IHDnpjW1ID/KQpFeIIpkPmm28gmobWFbh0/mpccT+e+50XB5SFkl2zcEn6jCd5JIdrSt21rhWauzk+b4OLnwebElxx7X0w5yEf+bYPNTK25A+bBZCe/jghw92sLP2cMfll1v0Wswckmj0jAP1LIOfNUsUUsEHGNLmpSJ/A7oBzw6oS0YVIxadC4Fj877hhzTFc5eQ8amFkIS674ILqxxD2SnhAiu/JOsi18HuVlRMsDhJtid2DEOPd4I+1ZDf4kokzCLEkQY2f88XStKcsKP7uAJZyJOC5TA3+efsrBgsuW0hCY/7hf6UWyZ03ZJeVMYhSagsHOSwyjWktmMaiXseTOO8QX8ztTUNwzzyxuBfyvF0Z9Si
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(38100700002)(186003)(86362001)(316002)(66946007)(6666004)(508600001)(31686004)(2616005)(5660300002)(6506007)(31696002)(6512007)(2906002)(83380400001)(8936002)(8676002)(36756003)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZMRkR6eS9wMmFPQXVIdDZGczArWVRMV2Ywa3dwczhCRkNJK29jWGRWZVdy?=
 =?utf-8?B?b09ra2pCaW9QdG5QanI5ekZEd3pWeUk5RmFPb295aXcvZmJWbVhidEFOQUYy?=
 =?utf-8?B?QnorTlphdVFDQVB0bHNQck80U28wYVJrY0hzT1c0RWpndGkyOGM2UkdUdUph?=
 =?utf-8?B?Uko2SVd6c09nNW1lL3RBcDRNbWxlZS9xUlllSVBnd1ZudGcvQU51NDJybkxC?=
 =?utf-8?B?UjhrUGhhT2JQdm9pbVpHWU1kTkgzTmxJazAyN1lzTlJGZ1VFQ2lyRnd1U1lX?=
 =?utf-8?B?VE03S3J0c3pzV0REZjd6WlUyeE5oYXlzMUdKMnJ2Z0lQam9Ja2xJeWNDWEty?=
 =?utf-8?B?TU51cmdpeUxjQjdPWUpOL1M2cjNSaXh5Nk1NOGhBbGN3dnRWZnpDTGtNMEpw?=
 =?utf-8?B?TTBMckZkSnkvbXdUeVlQTEhnVU83UHJjRE8zSEFYeDZYMUF6NFh0RFZSM2xm?=
 =?utf-8?B?anVvVi9SYytKbG9FK1lKV0VmMkFsdUhjVnJCQ3g0a0VPTTJFaVl3SFZhNkR2?=
 =?utf-8?B?MEdib2krUGtFNmtiN1c2MFV6TFVoTy9hUGN3N2VsY29iSmxjSmFDRVJNMGRs?=
 =?utf-8?B?NjNMWVZ2U2M5UWFkUW9JNlozMFlTbzI5SHZvQjBYSjAraldoU1Y5M1hpVkdo?=
 =?utf-8?B?Z3B1R1BkanhSVmFmbC9xRk9teTdFTnladmpobUdtWGRWZ0VSUHVWUkFEanBt?=
 =?utf-8?B?dFNWZEpUZFFFcFVOOEdlSXlxMjhxa1RRQk9ZekNDNTFLQVZWTmdKZFpHeEVG?=
 =?utf-8?B?bUxuQU9KMCtGMFN0UVgvbEdRNlVRYUpGL0JjSmtOY0s4ajJLVzRUVFh0OXU5?=
 =?utf-8?B?b09sZjZNSEd5SWthYUdlRjhWK2J5Z0tDTlNFYU92Q1VFL29sY1ZKV1ZWZElQ?=
 =?utf-8?B?L1pnOFQ3SHFjY1VwbEh4emgwTXVoRWZlb2FPa3dpQjl6OEU4c09JT3RnTkJE?=
 =?utf-8?B?dnRTUGczMVdISll0a3RUMCt5RXFjS3FRMVlUY2xzVy80SGpLOUk2amVsbGVm?=
 =?utf-8?B?M0NRVDVISVM0ckdySkhCeS9Zc2JlM0pkV3NPeTdnMGNPYzJFOXRnZjJNTGdQ?=
 =?utf-8?B?NUhGS3BHekVuUEVNTDFwOVE4SFNtMDFiVHFRekdUKzVyQzd5bXNDcjI3WGZl?=
 =?utf-8?B?eFFVNCtXUGJXV3QybVZxRkQrZHNXTnE2NTBQNjlZdEI5L1VZbXMxMXltOXlt?=
 =?utf-8?B?dy81VVdVTzBJVmNJaGVlSm5JSFRMQ2JOSDRwZnhvNUxSSnF2ZWYrelIwQWZ4?=
 =?utf-8?B?dUhUZlFIQnJRdU9pK1pzdkZxMHh0RWI4NmlHUEwvYXQ0TGduMzJUQWI4Sk83?=
 =?utf-8?B?U1YzdmxoeVRxeWdRb1c2cjhkcks4bWU5R05vTm5MZkFJakQzZldXUGxJUWdx?=
 =?utf-8?B?TjBTMEcrSkpmWFhqS0dBRjZyRnVQbGNmUW1mKzBsdVlBMFJzMEpOTlFZcTNv?=
 =?utf-8?B?WVl5Ym1QUm5lTlEzeEsyckJvLzBMVXord1ZoL3JLV1NHVnF0RFUzWkZJM3JZ?=
 =?utf-8?B?QTdkSWNOcWJncjI5S3BKd2UvalZ1aS9ZYXRGeXdDVVZpbEVVT04yb3hjSWJ0?=
 =?utf-8?B?RG9BeVVVejdZc1pYTmxkS0o2WjBTWndNL2lreWxBZ1BoM1FJR3NWZkl6ald3?=
 =?utf-8?B?OFNiMXNiRkRHWGR5ODZiVHFyL2kyK0VsWEs5eFk5Y2h4cnhDczdjR05aMHFv?=
 =?utf-8?B?eHlCMHFnWk51c211Y2xOc0h3TStiTEdkQjlZMGMySFRqMFM2UGJMK1NLTngz?=
 =?utf-8?B?VnYyZnhLYUFpdU9NWGt4WWs3ektJdGhTSUZ1b3kxdXo5UFZTNERTcm12YTJS?=
 =?utf-8?B?SGJ1WGVuMzFZS1ZVQ1F0c24wNG9qMUNkaFh6NXNDaXpTam1TK3ZybFFXRDBh?=
 =?utf-8?B?RWk3RGxRajhmNUh2Q3RVUlpCSklZeForWG1vZmMxM0pORGNaa25KSUp5U2Fu?=
 =?utf-8?B?ZG1mYVBMNGQxOER1T2NYRlQ1QlRjUFo2WGpjbHNHMTJmYVVwYWYyYTBlUDdl?=
 =?utf-8?B?bVl1M1JFYk1nVndVd3UwdDVmQ203OFhacTRaOE84V3BUM01STEw5Q3MyKzdW?=
 =?utf-8?B?bTVzd2pTaGpRRWVGTE0vclQ2a2w1VHNZMERtbWQ1Y3ZjNFJZQXI5YXUvOXV5?=
 =?utf-8?B?RFJpQ0NQNFBScmZ1QXVlK3lSMkFZZHhyOHV6YkxzSEdwcDVGSitUSitMOUNx?=
 =?utf-8?Q?/zC6zwNlLaajvwLsBmjLtd4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9d5037-5f9a-4197-b784-08d9d5e5d06c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 16:08:47.2992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljV6kSQrrNbsWk41kW28H/SolzDnAC4pZnz1VyQlhxett6pzy1TZbeHakcuBNi6i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
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



Am 12.01.22 um 16:59 schrieb Jonathan Kim:
> Some suggested cleanups to declutter ttm when doing debug VRAM access over
> SDMA.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 23 +++++++----------------
>   2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a675dde81ce0..4d77842f2183 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1448,6 +1448,15 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
>   int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
>   			       enum amd_powergating_state state);
>   
> +static inline bool amdgpu_allow_post_mortem_debug(struct amdgpu_device *adev)

Give that a better name, something like 
amdgpu_device_are_timeouts_enabled().

Apart from that looks good to me,
Christian.

> +{
> +	return amdgpu_gpu_recovery == 0 ||
> +		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
> +		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
> +		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
> +		adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
> +}
> +
>   #include "amdgpu_object.h"
>   
>   static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 33781509838c..02515f1ea5fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1460,10 +1460,11 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	if (r)
>   		goto out;
>   
> -	src_addr = write ? amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo) :
> -			amdgpu_bo_gpu_offset(abo);
> -	dst_addr = write ? amdgpu_bo_gpu_offset(abo) :
> -			amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
> +	src_addr = amdgpu_bo_gpu_offset(abo);
> +	dst_addr = amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
> +	if (write)
> +		swap(src_addr, dst_addr);
> +
>   	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr, PAGE_SIZE, false);
>   
>   	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
> @@ -1486,15 +1487,6 @@ static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
>   	return r;
>   }
>   
> -static inline bool amdgpu_ttm_allow_post_mortem_debug(struct amdgpu_device *adev)
> -{
> -	return amdgpu_gpu_recovery == 0 ||
> -		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
> -		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
> -		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
> -		adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
> -}
> -
>   /**
>    * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
>    *
> @@ -1519,7 +1511,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>   	if (bo->resource->mem_type != TTM_PL_VRAM)
>   		return -EIO;
>   
> -	if (!amdgpu_ttm_allow_post_mortem_debug(adev) &&
> +	if (!amdgpu_allow_post_mortem_debug(adev) &&
>   			!amdgpu_ttm_access_memory_sdma(bo, offset, buf, len, write))
>   		return len;
>   
> @@ -1909,8 +1901,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>   	ttm_device_fini(&adev->mman.bdev);
>   	adev->mman.initialized = false;
> -	if (adev->mman.sdma_access_ptr)
> -		amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> +	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>   					&adev->mman.sdma_access_ptr);
>   	DRM_INFO("amdgpu: ttm finalized\n");
>   }

