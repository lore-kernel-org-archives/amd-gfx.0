Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4928EC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 08:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE9610EF36;
	Wed, 15 Jul 2026 08:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qu5JyCw5";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010036.outbound.protection.outlook.com
 [52.101.193.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B785410EF36
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 08:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDMs2LgoGqH4RjMQHIXOa+ZCDwaYbT0Oiv1JG24h1P8PqinNewqJaELpDknZhFHocitSWD27qskDj8Lgye9f37tZCYV7Ivm7X8Ml1o6DJ2XGfnNaZd9kXZO91Q2EdtqzWPom6393q/fwJf2yAEQ5Jxh2CFeHRIZtUj98S1wB+T91kMXepiUfz+I5V1POkb+izmT9oBTFrQlrxShCL9/67Kv6mpnQ3we9fMJmb6bZd0HvaAYijcEQfFq3PUBe4mZK1Stw7WLn8S4lG3vhcnFNN/SNJfj2S3xN5+TIihQm2O0j6qJMdmX7WnTI9cYlNtRpJsPPGCNrQaPL8AEv955Q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WF1Rf1pMkGqE3E8/UhTVPyW/cU2s3KK6ZL/0XKJpdK0=;
 b=ZTmI5UrvDBA1fvHhSraVs8ZZ1DPnbeW/GAnoiYzVDWZnRw6d0LtuvmvdVy2S2nz/fUemPe/W3Ka7qI3Tjdx+UykQxhMhA2VoqREAtYz+OXPctyzjrlLhwGAWOe6hvTuW7DHAnb0C1OHGxshyY4jopLIhB6crhbrwCcFizleyg5G4giiR8A37BSJ+DJ2ZOmPgvUL4vHaHdloQJBsZIxDG3MvUazP54eNCISUnqE3be+4Oh73stewuen5Y6QeBISXqAzTcKvVDRLNBQiCsJ38NZ7ezpOm68QJc6iNouRkAgtjl9G7mQgoDa3TRrBoHCva7Pcxbz5UfUF22DbovmNdATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF1Rf1pMkGqE3E8/UhTVPyW/cU2s3KK6ZL/0XKJpdK0=;
 b=qu5JyCw5KS7Lf2dioQpHKsfyY+bzD7eer9pQyVGNGWJ6wz5hjRdAqSVTERskydOZChOg73EUgo6ujlY4FSdmUfjTTziCboiM5iMU/Vu53Kr9tlBixKJObRg0kL7P//A+UZL4OSy+jjXqAcjTEvbTpZ8bD0UVGNkI0GThEI+tt9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 08:12:44 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 08:12:44 +0000
Message-ID: <97b0eb91-80a4-4df8-a75b-a2bcfeaa578b@amd.com>
Date: Wed, 15 Jul 2026 13:42:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: properly account for resets with user
 queues
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Prike Liang <Prike.Liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
References: <20260714155516.684775-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260714155516.684775-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: b22ec15e-cf8b-4b7a-9d56-08dee248d8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: StqPDzE7SP3VO4iu7RDzeZex64DeBI7LxbZX/z3bmyL4FultEWullaFssDrmTNOGbc8XwobU81d3Kon8jfn/XVOXSvnF0jjsuVHbh5/vzZggEHgXFSZeXkrMNKZ+d8zPCJeyFhHzKbRcxa9/YpSVseHr1CgsImb88CAPVRYheUrp+oAnmXdVmYVc8HAVojepynv4T2EI3NlSg5gTxqijK97eCzxpLNccIvSz0kboIMbY+9LMrJ7sUArHJRf608Gp9qrzW7vUHcFE4UNk5bHE+CyodF9vtonIa2nK/2NBIE9YlPxqV7nk0tonCOINTeEXk4hKCnlH3ErcPFS8YvC3rkDjJfb1sZn3EV91yq5UGqJwvbITWRxAKVOnmspxcndobr6wd1/N8zaYq9OnsajI7LMsCH6iafgmlpLcSd0iQnsz6+A7AFGfXnMAg8TbKiNZTyigKcBt3gt4YEh/d7yt26jC4pJ2ukaoWoyK6n84oXQUipmZbUD/J9mZe/Np3aFzD6CmRGtG/yj6JsU18HRyHxWQjfeLwKwHWO4XguzYTCOShSl8VMBEHjazWy28FRz6cUNqhFS3apk+URMzvou+VQOoRCGQW3iN0C4y0SKqI7ssoXGoy/z1j0S5cWp2uU2vX3LLIg3AvhiJHCAom9NiDm+kEUsFtrwBwm50PAUY67g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNkbUN2dWV5N204Nnd6VW80Sm0vZGxHd2RJdkFqenRqZkpuNHh6cHdTNWpm?=
 =?utf-8?B?N2JJOC8zL00yelRHREVmdHVtQmdzV1h1YlpwcDRRVGZ2K2R0MHgraWRJYmJs?=
 =?utf-8?B?MWJWZW5pMms0OGZGbytoVU5jWTM1aVkrMXFjb2Z5TnZJSDQyYm5oZDFqcDY5?=
 =?utf-8?B?ZnNQWXlxdktyYm5UQW9JZXJmV3hMRkpSdStxMGpPVTFlUkQ3MmRUdm9tL2FF?=
 =?utf-8?B?NWFDbFllWVdlTWZFNkVlajFiSndzZWFpWTdsZmIzdlVnQUs3Ni9sUmdlTDE5?=
 =?utf-8?B?RkQwUStWcmwwZENaT1A5Uis5OCtVYjBRSmFkYUZZK1NsVXB0WHhCTmtjUVdJ?=
 =?utf-8?B?VWQ0bzJmc0dlU0pOUmM4TjVpZ08wZTlGQWdFMWFKalRrcG8vTWdVbFdzWmRq?=
 =?utf-8?B?RXYrdTJjMDllRzRCQlNXbFFIZEVkeWdSNmVpYlhjK2xWZWtOMWsyQ0g1VzNT?=
 =?utf-8?B?Y1pxcnFodkVPajlMKzlhWlBHYTlYSWhSczJRbEV1RG5iUUF1K2dPRWtlNitl?=
 =?utf-8?B?T0NSYy94TGdIR0JUMWQwT3dMcnZaNnJyS01jczM0UENpS1BRVE9EZkhqakdm?=
 =?utf-8?B?WVZ2eFBMbGNGL3lxVXpCZnNjWitIa1RaRitEdURDVU50ZE9BR0dOSzFMQlFT?=
 =?utf-8?B?QzFHSGZyeEVvdlF1dXhkbE94QWZnMWxtaG1Rdk91a1EydzlTWmNTZ3A3Y3gx?=
 =?utf-8?B?TVdHNWtXQjZEQ0ZNU3BGS0dZcENsK0tiVXNOTUlBbUprS1kxYUUzZktkdFM2?=
 =?utf-8?B?eE0yS1RLNk91eFk1OE16S2dOQ2VuQjI1aDZ0RmFxRXZxVDYzTHR1QnhMY2pG?=
 =?utf-8?B?SkRnaHpidEF1WEFxZHZKU0JEaCtSVFd5WG5jRndDVy9vUnNoaDhValNUb0VY?=
 =?utf-8?B?Rk9iRW1yYkNjWmd4VXdteE1KYWszYXNsVGEzZFZxNTRyZkxWaWFvcHg3QUp2?=
 =?utf-8?B?aDB4bmdob0s4dGk4SGk2K1NXNUVUblgzRW94MVVIMTZGNWJyUWw4d1FLZVM2?=
 =?utf-8?B?dktZNW9DMjAydUNuSzh1RUxkWUxGYTVsYU5pc2tjOTZBWXAzK2RuRUVPalM3?=
 =?utf-8?B?ZlA3YXhqK3kzcG14NC9hc1VNMEk0dFA0T2MvelE5cHFiaVloakdpdFpRTU9P?=
 =?utf-8?B?WGF2ZFZkeUoxM3A5RHFiaWVLbEFrUnhiMWZCS3YvTFkzbGhzc2JvU0g0bER1?=
 =?utf-8?B?bHE3K1JSVkcwLzB2WU1GSFZ4TFFzZzVyYzIxQ0NvejFaSFNLaURSQkNIVFhP?=
 =?utf-8?B?MDFYQk1sajBBdXVSK0JhS3dwbS9uVDRkYWQyTmNMRWNhbzVnUjlWai9FZDl4?=
 =?utf-8?B?eGR3QzlPSXA3QTYrcHVYWEVPNklQWksvNVNMcDlTeFRLVlp1OGd6V0FHRUJU?=
 =?utf-8?B?UXJrcFo3Qk5OVlZQTjBWaGZ1QXB3dVcvZG1PT2NQd3Uxa1kxRk9WVGdDeHBx?=
 =?utf-8?B?a1B6ZWc5WERldzlrdWFxZm52cXdybFMwRjhwY3dPejkrUzA1aEpsU053M2l1?=
 =?utf-8?B?OFRxUXFucXFjUklDTGxJYWFsSUZZTzQ2N3lvT3NBZEptR0R5TGZVb1pFakts?=
 =?utf-8?B?VEd4RDhOZTArRjBoWjBYT3R1MVJnb1ZSZnpFY1Y5c2V3K1B6djkzK3R5cGgz?=
 =?utf-8?B?ZWJIY3N6ZURmN29aandaeHRYaC9DYk5OemsxcVZVQThkN08zUUVKYkhRd0ZF?=
 =?utf-8?B?YlhEU2VLVURKV2ZGNXBwVXZlSU4vYVdRbEhKbDF3eEY4WmRCalVORlVCTmJu?=
 =?utf-8?B?cW1DV3BMcldaaGlUYjZ0TlowMGMvZHFFbW50cVB1WHQrR1hMUGhVZjlPRzNr?=
 =?utf-8?B?TXBtaFRXampONmQrODFLQUcrMmRIVXFtdjhhS1ArNzVKajZHeE9YczlUVlJI?=
 =?utf-8?B?T1M3K243MXVObTJFSkFjS3ExbTFFYzFEMWlPOFVGZkUvc2wyQllSK1YyUjcv?=
 =?utf-8?B?WmJwWFU4K1k2c3hwQXN3VWJTVmdJN3dCSkxJM2djeDZzNmVtNXpDc1NQdmxi?=
 =?utf-8?B?VUF4UkdTK2lXcUZoZ2JSNUVkMFJGRjFob0ZQQmU0VFpSWmtpZE5ub3NLTnpZ?=
 =?utf-8?B?Y1hmTUpvbCtFSjMzK3NadmkrUks4alBPdkhaYnpBZWpSNGd3TXB2UUxLQUNC?=
 =?utf-8?B?VXdDdkhlQmRBTkJVUTI0RENFMGJTRTRGMWVuV1hEUlY5NHdYOERienB6RW5k?=
 =?utf-8?B?WU1zMHJROXlVamNHZVBrdGJFN2ZFNHhMMXA1NDBhZUxZaVo2VXZ1alBKOGJZ?=
 =?utf-8?B?aFk2azgyYXlNaW5RclQ0cHdkNEZjT3kxeDgvUHl2ekc0TnpQNE1wTzVIdzdN?=
 =?utf-8?B?TFREK2FRWmFiZ3NFRWpqdURsRS93QzkrTHg3M29BZEtJalgvWTcyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22ec15e-cf8b-4b7a-9d56-08dee248d8e7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 08:12:44.5274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXzeol3j78bbGRh/MFtKbrDfehcTalQArYR26LWBjrH7cnM1cOd3AqFZcfrKDrQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
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



On 14-Jul-26 9:25 PM, Alex Deucher wrote:
> We need to increment the reset counter, force fence completion,
> and set the wedged event when a user queue is reset, but only
> for the guilty queue.  We don't want additional events for
> collateral damage.
> 
> Only increment the reset counter and set the wedged event
> in the top level userq reset callers (both KGD and KFD).
> This aligns with how this is managed for kernel queue resets.
> 
> v2: fix task info refcount handling, align with
>      kfd error reporting.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Prike Liang <Prike.Liang@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Lazar, Lijo <lijo.lazar@amd.com>
> ---

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c      | 18 +++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c     |  2 --
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c  | 17 ++++++++++++++++-
>   3 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6aa75da27f912..58754fc41bb6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -123,6 +123,8 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>   	struct amdgpu_device *adev = uq_mgr->adev;
>   	const struct amdgpu_userq_funcs *userq_funcs =
>   		adev->userq_funcs[queue->queue_type];
> +	struct drm_wedge_task_info *info = NULL;
> +	struct amdgpu_task_info *ti = NULL;
>   	bool gpu_reset = false;
>   
>   	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> @@ -137,6 +139,14 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>   	if (!amdgpu_gpu_recovery)
>   		return;
>   
> +	if (queue->vm && queue->vm->pasid) {
> +		ti = amdgpu_vm_get_task_info_pasid(adev, queue->vm->pasid);
> +		if (ti) {
> +			amdgpu_vm_print_task_info(adev, ti);
> +			info = &ti->task;
> +		}
> +	}
> +
>   	if (amdgpu_userq_is_reset_type_supported(adev, queue->queue_type,
>   						 AMDGPU_RESET_TYPE_PER_QUEUE)) {
>   		int r;
> @@ -146,11 +156,17 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>   							 queue, NULL, NULL);
>   		else
>   			r = userq_funcs->reset(queue);
> -		if (r)
> +		if (r) {
>   			gpu_reset = true;
> +		} else {
> +			atomic_inc(&adev->gpu_reset_counter);
> +			amdgpu_userq_fence_driver_force_completion(queue);
> +			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
> +		}
>   	} else {
>   		gpu_reset = true;
>   	}
> +	amdgpu_vm_put_task_info(ti);
>   
>   	/*
>   	 * Don't schedule the work here! Scheduling or queue work from one reset
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index d3d79bbaf9eb7..a1371a9f961d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -234,9 +234,7 @@ int mes_userq_reset_queue(struct amdgpu_device *adev,
>   				r = mes_userq_unmap(uq);
>   				if (r)
>   					return r;
> -				atomic_inc(&adev->gpu_reset_counter);
>   				amdgpu_userq_fence_driver_force_completion(uq);
> -				drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
>   				break;
>   			}
>   		}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0419fe869d4b0..58ccbf955f287 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -448,6 +448,9 @@ int kfd_reset_queue_mes(struct device_queue_manager *dqm, int queue_type,
>   static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
> +	struct drm_wedge_task_info *info = NULL;
> +	struct amdgpu_task_info *ti = NULL;
> +	struct kfd_process_device *pdd;
>   	unsigned int num_hung = 0;
>   	int r = 0;
>   	struct mes_remove_queue_input queue_input;
> @@ -476,13 +479,25 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
>   	r = amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_hung, &queue_input);
>   	if (r)
>   		goto fail;
> +	pdd = kfd_get_process_device_data(q->device, q->process);
> +	if (pdd) {
> +		ti = amdgpu_vm_get_task_info_pasid(adev, pdd->pasid);
> +		if (ti) {
> +			amdgpu_vm_print_task_info(adev, ti);
> +			info = &ti->task;
> +		}
> +	}
>   
>   	dqm->detect_hang_count = num_hung;
>   	/* When MES doesn't detect any queue hang, no reset happens. Don't signal reset
>   	 * event.
>   	 */
> -	if (dqm->detect_hang_count)
> +	if (dqm->detect_hang_count) {
>   		kfd_signal_reset_event(dqm->dev);
> +		atomic_inc(&adev->gpu_reset_counter);
> +		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
> +	}
> +	amdgpu_vm_put_task_info(ti);
>   
>   fail:
>   	dqm->detect_hang_count = 0;

