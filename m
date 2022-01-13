Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468B8C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 07:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5C3010F1F6;
	Thu, 13 Jan 2022 07:20:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E53F10E690
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 07:20:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6Rz9VGJG+BONKBF4wmFXM3CaJ5rkaS3Duk7z4Q4cuhNqBpxiaWrW0AgCW3fzZKegAWkR6Y1mW83HD5+hpC1x3T+POww+tlYUKlbdSwpJupq2xBqo7O0UsGn5WhkF6q6yTZ6MRDkjuRildTfire+k/UqscydGsy9qpmg/fwHgtyx/TyGVKMZmz+Pgrr0ec04qV2wjq35jfe7hdiW1xD+vib0Y7DRHvpFlDJyP7hJYlXGxxoiCVMQ+HfM6ciAzyQdEhNvMZlkmIysLX5k82GGbFt4gF1i2DFIn/HGhbRJ5G0yC+SqKYSG+525ynbT5D+VDyl/4ogTlrYaQjYOXLlQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiAQ7AxBlC80k31WiYhpRfvGLMutHRyesAgEPvEo0Ik=;
 b=oVSDOFTS2eSseiVXdQnAFPFjDoKX+3yZ4Oe3WZVKBlbcHuotEdyCWBSPn2384nDrMlUYVmx8ZBD7yK6m0WVquVJmyQ60BkxaXlZIfqyB9DPrR9b7u4tNX5N87iJjEosSD4Xa7PDpnob6Fnmd/yIsusXpADL0CEwlJiGSzdksvfzSmtaXZDNw40xAat2Vg/3igQpHUuAoh1AwtwTtEf8Beos5xI2UT3agB81z1W6LmJJahLOT7SfahgQyDGpDRZlVJetdtpQZY6xjYiz6aUQB/OX6io/KM+MNPWrBBkzwbzFlipR27HVrHY9weMyXpdd/0nmArVaKxRt1zaFik2aCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiAQ7AxBlC80k31WiYhpRfvGLMutHRyesAgEPvEo0Ik=;
 b=WBrsmsapQfX2dsmakpTVCmDqxJxMCxSRMedWqu09UkSa9jNGlpqqk2sOxl3mG7lmP/1Qyda0qVj/0xL5yz3qioshdzA3G/K+rbT78Q8z1Na1im+obMDWDC5stxA8UUWRSep4lgyurjjqsL/krMcrJD3iqh3odmWyD5F1Gdw/DaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by BN6PR1201MB2515.namprd12.prod.outlook.com
 (2603:10b6:404:a7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 07:20:36 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4888.010; Thu, 13 Jan 2022
 07:20:36 +0000
Subject: Re: [PATCH] drm/amdgpu: cleanup ttm debug sdma vram access function
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220112185218.2648420-1-jonathan.kim@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <40687ea4-b58e-896c-d879-f1bcfa73926d@amd.com>
Date: Thu, 13 Jan 2022 08:20:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220112185218.2648420-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:203:91::12) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5525d523-bf05-4868-af53-08d9d6653151
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2515:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB25152722928C2BC92772004683539@BN6PR1201MB2515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEqiAi1auugzXWpm+BXNEwDT3TUyyOPURA6uQIPKldacJ6COkuCkj6HvP10VaZA3KPqyqOB5nHcXr76EKJ9hqik7M3lUU/sZsS/WxcbSHsiTlSy0j5uARyuhjnCTHNbd91PtUsZGByRG18iTTuRNzVhjxGrbJnNRFgFJ4SNeDZuZZQWpqaq9tYNDdksvKUPR1G4kHg05FNaJsO2TX15ZQffwgj2fvjSr45hQWhJ4EkDJ/+tUGTEDr9YKB//bYAxGmBTVZ638JMtuGxRD6CbxRVMcDNWofGTrW6gq9EXPjfPPil6DoJu0KMTAZqviJr7XhLhqGSYS9YU8sH1lYfn/6UW/Mlu9EKt4YBUjZSTUEwpANmD2oPLpyJtDsIlHZLUb20F6M6lwEzeVOr/gZoK0jmXQgPAcBJYjTBuxsqtlW3JL26Jb2zHZuh1LBKONxVKu09cyH+o/H54XHbM+U9N9OjtlkIy/aSyZ38jo7t6Cgec5Rl7wmt4aQSnWX1Yio93RYHrxHYSiNkBDLckX+5xtGfjnyelixvccKKsNxKy92pt7NR0nuNRdCqddNJ9XM/DLKnZM/l2LIMTu0H2eiP9SzBRY7KmO2uQZNsfMfbTHmFkwaT59XfbfhEApgG46K4euk82LYTUMvVvp6b9+i3F9umOtop6hqR9MZRtk5jJ/TgpGUS/ldYzOD0oZLFAN+kuHe+nbxjB7a/60OZ1S6BWXNUbaH0cGrqZ6vRuRpfgHcJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(8676002)(31686004)(6666004)(5660300002)(316002)(6512007)(36756003)(86362001)(66556008)(508600001)(38100700002)(6486002)(8936002)(66476007)(31696002)(6506007)(2616005)(83380400001)(66574015)(2906002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkt1bFJFZmtqcVhQOVVKUDJVdElBOXdBdXVhZGhSNzNsWC9FNnNMajVkQjZK?=
 =?utf-8?B?amZDaTJWNXlvWGFYVWtSSDFkQytyemRDWGhUcTRzZ3BTOWV5QkRud0Y5NzNs?=
 =?utf-8?B?MVF0VEEybFZtSitYOFl3a3V6WVozTWtVVFN4WmJvNEIrQ2FFWVFYVW1jRVk5?=
 =?utf-8?B?OUZaY3g3anE4T2xUTWVza0RtSW5aTXlSKzN4OHQyd0pXMnFCWXBJRUJPVFd5?=
 =?utf-8?B?U1JBVGszQWR3T25GYndjZjBvT2VNbGtsSzNwUjliVWxXTlhyUXFTWE9YRnRl?=
 =?utf-8?B?NjlJOW95VnZPSTR5YVJtN1B4NDluSXA5UVlKd0I3eUVWRXNQSzFrTHVWZzdM?=
 =?utf-8?B?OHFlbWVWTmhyaU96bkxIenh2czlFVlk3NmdXK2ZyVm9pWjNWYUtLZElEcWJq?=
 =?utf-8?B?bi9FK1p0NXpCbDgyMm5UMzVrNFZzZTZDWEtlRHVFSU9EQ2FpRTFLbkl0YnQy?=
 =?utf-8?B?aSsxbW9UMC8zTWxXTVNPaXphL3FScTF0K1RMZTVBTUl2VFpFcVhLWFkyOXFI?=
 =?utf-8?B?LzVDUFIveFhaNEJHOXAzdG93Z0pPS2tCVXNGQnB3TmdXU2szV2szMUNBRk5I?=
 =?utf-8?B?QS9TZ2VURzRwRnNkVmlDeTJOVWJyL0VpZ3BmM2JzelZGWmhJbmpqQnFYSHQw?=
 =?utf-8?B?RnY1QzdkbEVvN1VSWm5EMkNMYkNHQ1lwaVFYZ2Qrd01Fd2pMWUVJMmVlVkVZ?=
 =?utf-8?B?NVRKVGZkTmJ5UTdYb0JiQ3JqaG5iZVp0K0hrUFV4SnJaSlZUM1RMMUNsNStQ?=
 =?utf-8?B?dE1SMVJhYXkvcktaMGhoTDZlOUFTSmYyUjBGMjFPbW5YMXhtTjE1TVdyaXIz?=
 =?utf-8?B?L3N4MEp1dUZZMExwa01mRzJaQ1lGWDAwcUJXNUlOMUVvcHl0S2p4YzZGUDYx?=
 =?utf-8?B?a0JWbGFxTWdGNXh5K1ZqUzQxWXRFVFAreDhvaTQ1WC8rZ2VmZkltbnlGeHoy?=
 =?utf-8?B?YnNqM0t6eDIrQXZUSUpqNjJrMWVrLzJ6aGV1Q3Zqa0cxbGlPYzFBaVlpUGdW?=
 =?utf-8?B?VHdyTDdLM1prTGJVRWU2S0FTQVJKbTV2SU41SWJZczM1dVRaWVhTVnVOcUpk?=
 =?utf-8?B?UmN6NFBOYk96cjBxZ0txQUEvajh3WVM2U2p0VHRETkZwdlB4Z3pkZ1U2N2Zw?=
 =?utf-8?B?WTZIMXJXeUcrbUtPL1FTbXc5bHlxYjhWbUdRR1FweFVDdW9DdVRmb1o5ZEF3?=
 =?utf-8?B?V0YvZHdleU1XdFVyelhtT2dZQTUzUDB3eW8vSlRPQ1ZYcnFzeDVwMmhqUFZ6?=
 =?utf-8?B?VXNOWDRmWnpqc3E3YjNqQStpMW9rcUpaVEpBSk9xeVIyc3ludVg1T0F0ZE84?=
 =?utf-8?B?OHgyVHVZcnRhUmJ2YWpoVklHbUxYWnQyckFzK1lKM3JtS2oxMDdnZFpMK3Bo?=
 =?utf-8?B?cEcrVDhoZkJVNTlGczlpL2Jscm5ZS0R0REVRZ0R6QnYwSUhIV09hRzExZGtP?=
 =?utf-8?B?NnZyaFFiTXFUMk1uTzc3andpY0JuNzVjN3p5QWE4K0gycmxzUWNDVW1GdlB6?=
 =?utf-8?B?eFBzZVdDMmhlSjBUK0F3d3VKVmViUzhmVTE3aXhIWVFOYytzbmdIRnlzbkJH?=
 =?utf-8?B?YStYY2hXbTJJUTA5OThocFdpL1NaaSswdjJXa1VPWFM4SFpEcDZybUV3VWM1?=
 =?utf-8?B?YVJQVlk1NXRjTE83S2QvRUxOVFI5eXpPbFVXUGlUclUraHRBUUV6dXVOOWJ3?=
 =?utf-8?B?YjZXbjhxZzZXMGEzV3U3ODBCMjBKTFZZU0JFbVkwS1hzNXJUeTErSFJvcHkz?=
 =?utf-8?B?WHl6SjJMSVEvV0RGQUkrV282UjhMWGhoZlkvRERjQk1PVk01M3oyMTk4clp4?=
 =?utf-8?B?VEhmLzJweDVLS1lDd21oditINDlJWnJDYWFabHFQb2VJNHBFdk1vdk9zcnBx?=
 =?utf-8?B?ZjdwVEtrTHRmSFJqbE5TcytqdlJ4SFhuUnlRV25WZDVWRWZLKytReW91OFdF?=
 =?utf-8?B?SlhsZWgzWEF1OHE4ckRrMVFrNUNIUWlyenI4OTZaVFRTcXI4ZWwvMXl5T0c3?=
 =?utf-8?B?OWZteWNINXN1dGcwK2ppZ1YrZ0l1MkNvTDRVbkkvenBXSDlORFd1K0ZWWXI3?=
 =?utf-8?B?RzY1N0RlZUtKdUlNTktqa0tKRTQvR3ZScWpWN3U2VjZ3cDE0b2hQTVVtZnNz?=
 =?utf-8?B?Mk5oMjR4UllUUmpFNTBOdjlzZ0V0UnRON3dVUjlxOE45c2ovcUw3U29MWFJ2?=
 =?utf-8?Q?PUGK8n/0z4lWeYLiczo9Nt4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5525d523-bf05-4868-af53-08d9d6653151
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 07:20:36.2113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1YpCMPeLiVLEIbVVh2rSq7wc50RGqB8/nLjbWcOpnCXTUmEP5UARKxk3dKUrC35
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2515
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

Am 12.01.22 um 19:52 schrieb Jonathan Kim:
> Some suggested cleanups to declutter ttm when doing debug VRAM access over
> SDMA.
>
> v2: rename post_mortem_allowed func to has_timeouts_enable.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  9 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 23 +++++++----------------
>   2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a675dde81ce0..747d310aa72f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1448,6 +1448,15 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
>   int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
>   			       enum amd_powergating_state state);
>   
> +static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device *adev)
> +{
> +	return amdgpu_gpu_recovery != 0 &&
> +		adev->gfx_timeout != MAX_SCHEDULE_TIMEOUT &&
> +		adev->compute_timeout != MAX_SCHEDULE_TIMEOUT &&
> +		adev->sdma_timeout != MAX_SCHEDULE_TIMEOUT &&
> +		adev->video_timeout != MAX_SCHEDULE_TIMEOUT;
> +}
> +
>   #include "amdgpu_object.h"
>   
>   static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 33781509838c..b489cd8abe31 100644
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
> +	if (amdgpu_device_has_timeouts_enabled(adev) &&
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

