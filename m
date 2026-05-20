Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66747CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 09:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E38892F8;
	Wed, 20 May 2026 09:14:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GCqj09iC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560D2892F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 09:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQy0LvRkpBiGlPeJ3oFPYE12cNxwfgMKRRxEWXqt5QU/V1c+RP/tGk7cGWmfR59UeNE1z9YIMGRXNPf4Kz0QLPo7d9Z2x68ReRNvxT0m9HmtKHjiEpraieeKGvpUKMN1GD0u1GJ//4+vqD+GlTJTaC7s6u1D02MDDCtiXGX8na2uJVvQJsT1kPNCTr+wmH2TIRdGBWFu/SmShmgCjMqb580fUQPAhWNtOxibvjDHki2jM3tOfZ2Qzwa3lTh1M4ThudZRZL1Fzj1tXwGP8OJGj5qW9/dyX+RXAmh10flMXe2GFiizooSD5f7lrRgQwHXEfDnDg8u+meXPGmZ7I2rOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ghy9e1fb10WZiu0gT/LB0JsSSY4KPYiSvio6i0nf2x0=;
 b=UAOLr0UrTiO8uFFN0m4e1uZpv9cGt5jxYuVEPax7S2ttQutOKNYsRGFl/H/t+kP5N8HyDomwGAcq5mW3ajMlxYagFo40v0vTdZ8dq1NoNtozAXPE7KCMDUIWiwYPl6+7OGURFJUevPTwUTxW/jwi4Ozi42/nn+0AtvoWODc3HTMjxn1YAzPMCKjElxns+4/ZTwtVOswkEmQ63+4oADF/hj2wqVKCR8V39W4RHHpSmQnwwoNctfyCT0Ej83PoprX5OuSQtHV1x9q+pOIUgqggnv++j91OB7RNZL1T+gnTjtaXYz3vQEazomFYkRMag/7vlPBMoBoQuL7C4xhx4o1q0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ghy9e1fb10WZiu0gT/LB0JsSSY4KPYiSvio6i0nf2x0=;
 b=GCqj09iCkjsnQuuLS4M0GR8kfz2Jnk1u0PEAy/Luw9/9wMK0bqj1xD6zt9Z7ZP8WDdas81ITKVF699WIAQCahLTNYnV8UEsD6I9ZyYoRJKs8VADW9HsrjhWY8UMeet6z4UKfrqfIkAu1znJsbH3kLrzFFm74BbnzyYXyFVFgJVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:14:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 09:14:39 +0000
Message-ID: <15b6482a-e102-430f-ad91-36d1024766df@amd.com>
Date: Wed, 20 May 2026 11:14:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: add userq job and state transition trace
 events
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, pierre-eric.pelloux-prayer@amd.com
References: <20260520063859.15914-1-Prike.Liang@amd.com>
 <20260520063859.15914-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520063859.15914-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:208:32a::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 15cb672c-b4c8-4a15-e9f2-08deb6503886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|11063799006|4143699003|56012099003;
X-Microsoft-Antispam-Message-Info: d6NbVAw87u7I96QPZjfMBkRDxOIRws6RCxirhZh0UJCCTjXPjrYHVdYIxH3s0rmZGSBftbA5UXj98diEojd49hgaiD58b/t9ZdKwxbmWDbENM5DOPLvrJixvUnd/QwQsCqy81SnAcEyoGoRr5KO0diSZuJrFReEn9Os30+k6MIv31nlhq6Vpn6RISQkgZlN2I58R1dcIHcA3skEopf4DPxVNrW4Ro7Hq6DUuM/j2m43ROlFgJw6EaWZOCThTNN56+PZp54nm/T/7+nKxEP9HjkWhZDr9SyNC2hgYx5CcYXOXQmqXcU9tF5Xiqgpygkiw3+csXJn/xsHKkzUf+k/c/li7jaz38IRYFP2S/jaCsJZFv4ctgq8O4pBNQ0khFW/7QKrY0pAvQFToKdPQsBiPVc4IuzkFTRrV0TtlA3Kt/K5a6qR8LVBI4NX3WYmr8R/R/iH2i6hBsGXOdrwvC0ulsja6V1pk6JRMcrbZsKnuJ5WfbVEPp4gHsvABZB+jVP9xVZ6hbFwp2c8aKWDqLvLYptAg4WK+L88kVDP7OfmcTaRIKYLGdfJ3CBHnMRv6wAq49rOgWfNRzvmlIGCJGA21aAg1XREtQnaMqG6pI+iECyeFp2wSbiGhOuuAlbJTgPTffBgRjNGCH+G6dmZrQBr7t30lwCYufNHGh19QM3Pusglt25F/TrrksRVN6rAwgyV8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhqUFJGbGcxYXp6TEFjb0EwK0t6TE5XcFNKUVhpeHJ2Y3hZTFRRSEk3UFRP?=
 =?utf-8?B?K1J2eTlaQzdwVTIyb0hPSkV1ckRuWXJISTE4R3JKc2FidVpkV1VzNndwWFVF?=
 =?utf-8?B?R0YzV1RuRkFPZVp4TXhuL293emd6UmZRWDZLVVQweWpOOHFsS3NOVTRxSm9R?=
 =?utf-8?B?Rm5GSCtEdm1xM0JBTWdwSFV0SmVIOEIyeVBqUHZJQ0MyMnAyN1dqOE9lNXZV?=
 =?utf-8?B?WW1lbkZJRmVJc1lUakkxWVRqTWl1bnlGcXQ2VGM3WDh1anhEWVZSb1ZESVJO?=
 =?utf-8?B?QVFBbVdCUThXQSsvRUs4STVHeWVWckZ4SjJtOEF6ZmZGMk1WcHhtRG1vQzFu?=
 =?utf-8?B?UmVmRTN0SEpmV3RGWnJ2aUpWaEZzSGNSdUszTXF1SUI2QXpYcGhJelJkZHpZ?=
 =?utf-8?B?NDZDbHBSRm9QQzkva0puZXdmYTBwSTd6UDg1L0RYa0dsVlNieXlVelpMRDRH?=
 =?utf-8?B?K29wdkJRdDlrZUFkRnIraGFlanRhN0UvelNZelk2NVZ2QTFxV2ZVSVJUbEFt?=
 =?utf-8?B?dkdXcStmOVJuaGIxL0I1eW5Ba1NMaXZEb0pPYlFEQnZBQ2hXZXpGcldONnQw?=
 =?utf-8?B?b0Z0czhzWVcxZ05BYjYzT2VxbTNUL1ZyK0ErbCt3YWM2YkY4emFpUjFGNTUw?=
 =?utf-8?B?MWl4bnVEbnQ4SzFFT3dkdFdKaEVFdkJzb2ZCYjhKelFZOWozN2hSSkllT3cv?=
 =?utf-8?B?RmtqdU9DRWdGRGFEQzQxbmNRZHlQNFlJQTVTNzZ4dENEbHVBbzhYbHhMQ2Y3?=
 =?utf-8?B?cnpsRkRxOWlCYklMNGxFZUI3Rk01VlJRTGloT2tGNnpKOUpaUlFSVXVVL1ds?=
 =?utf-8?B?cG9hREZtaHE1WHZrbUJZdnUvL2ZFM3YwQU04UFFwUFpmUmVsRTl0Rkh5ZFBK?=
 =?utf-8?B?Rmp3TGtHeFlQYTFVZUJYY3JMMkdsOTFGdzZpeTJpWlp0QXJuemdlRkNtT1dN?=
 =?utf-8?B?WEttTkZpM3Rpdll5cXNRVENmVnlITFNzckd6T3p3T01aNHlTMEFWM0JjWnJ2?=
 =?utf-8?B?WnFEMVFpRTVjRWJiOHF1YzU0S2trYnNicXNMWEVNOWhNNjVDVEZFcmpCZklP?=
 =?utf-8?B?WGtnNzB6eEdjNmswTVdkYjZLU2U3NDNXRTd2V21JNkw5SEdVTWk5bURWelBC?=
 =?utf-8?B?blk1M2hqS3JXeGpaN29UcFNaWTcvUmRsdzZaNk5lVzZTZmNvREN3V0VoNCt4?=
 =?utf-8?B?UDEzajFzVUNTMDdaUGRiME95d2U5ODJueVBUNWh6T1pBbEpBWFUzOHFsRnZR?=
 =?utf-8?B?WkpRNk9hTEtzK3Jib0drdk0yZ1BWODJ3UTlzNU9VelM4TzY1M0hMcyttUWlu?=
 =?utf-8?B?K2ZyRE5lVmlvZWJkVFlHZ0VDdm9PdDUza1FWWVR3QWFWc3BIc1JzUDZhUVFC?=
 =?utf-8?B?MTVIaURZYTl2OFpxN2gyT1RyR3RkUERQRXllOXhGd0lzVXBxbStiUUlycDlZ?=
 =?utf-8?B?NHJFVCtQRzcyalNVVkk4dzFab0RsMm1vYXBpVzREalpuU1NmYThVRHViL1lt?=
 =?utf-8?B?NXRQMGJUbTR1YW1SOFE2ZkkyNG9ONW40RVZZS3VPWHpYdFZtL3JkaFRTZWg0?=
 =?utf-8?B?d2xQSlB1Yko3ZWdnYzcvZ2FZRVRXQjdLZzgvLzA4Q3NYY09TOXhTM3duTXBk?=
 =?utf-8?B?SnJoUDFKMk0rY2NZZE9vZEZZQzQ1SnY2TEE2ejRrMlRQUXE2dUNVd0NQeWV4?=
 =?utf-8?B?ckpIQ2xHRUhFRkVyUkFFTFdGemtrT0lYN2tMTFRyOFJYM2Z1MnByQUthODdT?=
 =?utf-8?B?N3U4dzlLSEZVK2ZBdkYzOW5DektLMXE4L3drQWp4VEhqSzJOcHJaRXR3b0VE?=
 =?utf-8?B?QytqRTZXUERSaW9zbHI2T3djMUlYT1dZa2NtSm42ZS9vOHAyaEtMYWF1aThH?=
 =?utf-8?B?T3Bzbm1ZaFlQcU1PMGM5WkRIQm1vVzNxckJuMkt1SGU0VWN4STAvbXdpV0xV?=
 =?utf-8?B?ZXp4bmJCL1hTSy9lRG1WbHY0SGx4YmpFZjdGc2NQbFYrYkdaQWlIZEhzNHcr?=
 =?utf-8?B?N0NZTXp2YmpEdnRGM29VQTZZaXNLa09SdFlpQUo5MlZHeVFPakRJQzVWaG1u?=
 =?utf-8?B?ZWhXYnZqYm1odW51NnRIeHNWUkJIYUN1bTlORDg4WEh5SFlIcklPWGdLRW1s?=
 =?utf-8?B?cmxHMC82RXJ5Y1hLczkyTEd4S0hHQ0ZhUkFBSkxyNHRFUnJOdnVpNkpaaEVq?=
 =?utf-8?B?Y3VsMkdWV25VRnVZRGtkMXZQaGdoUmxEZm4zSXpRTysrbm1GcHVweno1czlx?=
 =?utf-8?B?ZVI0aVlhSEJjVFZrWE16dWFvM3pNLy90U2FSRit4eVQ3cDg4aHlXT0tUd0lu?=
 =?utf-8?Q?PL6cFVFWNZ16VBGEAN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cb672c-b4c8-4a15-e9f2-08deb6503886
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:14:39.7352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqbpLBCP9DRGwTfgeGIOG721FxrbETgk0Px5G7PrhXtuJe8bFGDFKn/sXnBK64Ol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227
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

On 5/20/26 08:38, Prike Liang wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Add ftrace events for tracking the userq fence emit, signal
> and queue state transition.

The queue trace points look good to me, but clear NAK to the fence trace points those just duplicates the common trace points in the dma_fence framework.

Regards,
Christian.

> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 129 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 +++
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  13 +-
>  3 files changed, 160 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 4ff8a4d7bb8b..32d8c36caaf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -28,6 +28,8 @@
>  #include <linux/types.h>
>  #include <linux/tracepoint.h>
>  
> +#include "amdgpu_userq_fence.h"
> +
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM amdgpu
>  #define TRACE_INCLUDE_FILE amdgpu_trace
> @@ -659,6 +661,133 @@ DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_enable_sig
>  DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_signal,
>  	    TP_PROTO(u64 context, u64 seqno),
>  	    TP_ARGS(context, seqno));
> +TRACE_EVENT(amdgpu_userq_job_run,
> +	    TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *fence),
> +	    TP_ARGS(device, queue, fence),
> +	    TP_STRUCT__entry(
> +			     __field(u64, fence_context)
> +			     __field(u64, fence_seqno)
> +			     __string(dev, dev_name(device))
> +			     __field(u64, doorbell_index)
> +			     __field(u64, client_id)
> +			     __field(u32, queue_type)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->fence_context = fence->base.context;
> +			   __entry->fence_seqno = fence->base.seqno;
> +			   __assign_str(dev);
> +			   __entry->doorbell_index = queue->doorbell_index;
> +			   __entry->client_id = queue->userq_mgr->file->client_id;
> +			   __entry->queue_type = queue->queue_type;
> +			   ),
> +	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, fence=%llu:%llu",
> +		      __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index,
> +		      __entry->fence_context,
> +		      __entry->fence_seqno)
> +);
> +
> +TRACE_EVENT(amdgpu_userq_job_done,
> +	    TP_PROTO(struct amdgpu_userq_fence *fence),
> +	    TP_ARGS(fence),
> +	    TP_STRUCT__entry(
> +			     __field(u64, fence_context)
> +			     __field(u64, fence_seqno)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->fence_context = fence->base.context;
> +			   __entry->fence_seqno = fence->base.seqno;
> +			   ),
> +	    TP_printk("fence=%llu:%llu",
> +		      __entry->fence_context,
> +		      __entry->fence_seqno)
> +);
> +
> +TRACE_EVENT(amdgpu_userq_job_queue,
> +	    TP_PROTO(struct device *device,
> +		     struct amdgpu_usermode_queue *queue),
> +	    TP_ARGS(device, queue),
> +	    TP_STRUCT__entry(__field(u64, context)
> +			     __string(dev, dev_name(device))
> +			     __field(u64, doorbell_index)
> +			     __field(u64, client_id)
> +			     __field(u32, queue_type)
> +			     ),
> +	    TP_fast_assign(__assign_str(dev);
> +			   __entry->doorbell_index = queue->doorbell_index;
> +			   __entry->queue_type = queue->queue_type;
> +			   __entry->client_id = queue->userq_mgr->file->client_id;
> +			   __entry->context = queue->fence_drv->context;
> +			  ),
> +	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu",
> +		      __get_str(dev), __entry->client_id, __entry->queue_type,
> +		      __entry->doorbell_index, __entry->context)
> +);
> +
> +TRACE_EVENT(amdgpu_userq_job_add_dep,
> +	    TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *dep),
> +	    TP_ARGS(device, queue, dep),
> +	    TP_STRUCT__entry(
> +			     __field(u64, context)
> +			     __field(u64, dep_context)
> +			     __field(u64, dep_seqno)
> +			     __string(dev, dev_name(device))
> +			     __field(u64, doorbell_index)
> +			     __field(u64, client_id)
> +			     __field(u32, queue_type)
> +			     ),
> +	    TP_fast_assign(
> +			   __assign_str(dev);
> +			   __entry->doorbell_index = queue->doorbell_index;
> +			   __entry->queue_type = queue->queue_type;
> +			   __entry->client_id = queue->userq_mgr->file->client_id;
> +			   __entry->context = queue->fence_drv->context;
> +			   __entry->dep_context = dep->base.context;
> +			   __entry->dep_seqno = dep->base.seqno;
> +			   ),
> +	    TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu depends on fence=%llu:%llu",
> +		      __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->context,
> +		      __entry->dep_context,
> +		      __entry->dep_seqno)
> +);
> +
> +TRACE_EVENT(amdgpu_userq_state_start,
> +	    TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	    TP_ARGS(queue),
> +	    TP_STRUCT__entry(
> +			     __field(u64, doorbell_index)
> +			     __field(u64, client_id)
> +			     __field(u32, queue_type)
> +			     __field(u32, from)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->doorbell_index = queue->doorbell_index;
> +			   __entry->queue_type = queue->queue_type;
> +			   __entry->client_id = queue->userq_mgr->file->client_id;
> +			   __entry->from = queue->state;
> +			   ),
> +	    TP_printk("client_id=%llu, type=%u, doorbell=%llu, from=%d",
> +		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->from)
> +);
> +
> +TRACE_EVENT(amdgpu_userq_state_changed,
> +	    TP_PROTO(struct amdgpu_usermode_queue *queue, enum amdgpu_userq_state new_state),
> +	    TP_ARGS(queue, new_state),
> +	    TP_STRUCT__entry(
> +			     __field(u64, doorbell_index)
> +			     __field(u64, client_id)
> +			     __field(u32, queue_type)
> +			     __field(u32, to)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->doorbell_index = queue->doorbell_index;
> +			   __entry->queue_type = queue->queue_type;
> +			   __entry->client_id = queue->userq_mgr->file->client_id;
> +			   __entry->to = new_state;
> +			   ),
> +	    TP_printk("client_id=%llu, type=%u, doorbell=%llu, to=%d",
> +		      __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
> +);
> +
>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>  #endif
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index e27f9a76f986..60d1186af286 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -329,11 +329,15 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
>  	int r;
>  
>  	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
> +		trace_amdgpu_userq_state_start(queue);
> +
>  		r = userq_funcs->preempt(queue);
>  		if (r) {
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>  			queue->state = AMDGPU_USERQ_STATE_HUNG;
>  			return r;
>  		} else {
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_PREEMPTED);
>  			queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
>  		}
>  	}
> @@ -349,10 +353,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
>  	int r = 0;
>  
>  	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
> +		trace_amdgpu_userq_state_start(queue);
> +
>  		r = userq_funcs->restore(queue);
>  		if (r) {
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>  			queue->state = AMDGPU_USERQ_STATE_HUNG;
>  		} else {
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>  			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>  		}
>  	}
> @@ -370,12 +378,15 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
>  
>  	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
>  	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
> +		trace_amdgpu_userq_state_start(queue);
>  
>  		r = userq_funcs->unmap(queue);
>  		if (r) {
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>  			queue->state = AMDGPU_USERQ_STATE_HUNG;
>  			return r;
>  		} else {
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
>  			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
>  		}
>  	}
> @@ -392,11 +403,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
>  	int r;
>  
>  	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
> +		trace_amdgpu_userq_state_start(queue);
> +
>  		r = userq_funcs->map(queue);
>  		if (r) {
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>  			queue->state = AMDGPU_USERQ_STATE_HUNG;
>  			return r;
>  		} else {
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>  			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>  		}
>  	}
> @@ -1007,6 +1022,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>  			drm_file_err(uq_mgr->file,
>  				     "trying restore queue without va mapping\n");
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
>  			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>  			continue;
>  		}
> @@ -1502,12 +1518,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
>  		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
>  			continue;
>  
> +		trace_amdgpu_userq_state_start(queue);
>  		userq_funcs = adev->userq_funcs[queue->queue_type];
>  		userq_funcs->unmap(queue);
>  		/* just mark all queues as hung at this point.
>  		 * if unmap succeeds, we could map again
>  		 * in amdgpu_userq_post_reset() if vram is not lost
>  		 */
> +		trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>  		queue->state = AMDGPU_USERQ_STATE_HUNG;
>  		amdgpu_userq_fence_driver_force_completion(queue);
>  	}
> @@ -1526,6 +1544,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>  
>  	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>  		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
> +			trace_amdgpu_userq_state_start(queue);
> +
>  			userq_funcs = adev->userq_funcs[queue->queue_type];
>  			/* Re-map queue */
>  			r = userq_funcs->map(queue);
> @@ -1533,6 +1553,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>  				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
>  				continue;
>  			}
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>  			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 008330a0d852..00cc7194321c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -30,7 +30,7 @@
>  #include <drm/drm_syncobj.h>
>  
>  #include "amdgpu.h"
> -#include "amdgpu_userq_fence.h"
> +#include "amdgpu_trace.h"
>  
>  #define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
>  
> @@ -169,6 +169,7 @@ amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>  		fence = &userq_fence->base;
>  		list_del_init(&userq_fence->link);
>  		dma_fence_signal(fence);
> +		trace_amdgpu_userq_job_done(userq_fence);
>  		/* Drop fence_drv_array outside fence_list_lock
>  		 * to avoid the recursion lock.
>  		 */
> @@ -528,6 +529,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	/* Create the new fence */
>  	amdgpu_userq_fence_init(queue, fence, wptr);
>  
> +	trace_amdgpu_userq_job_run(dev->dev, queue, fence);
> +
>  	mutex_unlock(&userq_mgr->userq_mutex);
>  
>  	/*
> @@ -701,7 +704,7 @@ amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
>  }
>  
>  static int
> -amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> +amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *filp,
>  				    struct drm_amdgpu_userq_wait *wait_info,
>  				    u32 *syncobj_handles, u32 *timeline_points,
>  				    u32 *timeline_handles,
> @@ -835,6 +838,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>  		goto free_fences;
>  	}
>  
> +	trace_amdgpu_userq_job_queue(dev->dev, waitq);
> +
>  	for (i = 0, cnt = 0; i < num_fences; i++) {
>  		struct amdgpu_userq_fence_driver *fence_drv;
>  		struct amdgpu_userq_fence *userq_fence;
> @@ -869,6 +874,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>  
>  		amdgpu_userq_fence_driver_get(fence_drv);
>  
> +		trace_amdgpu_userq_job_add_dep(dev->dev, waitq, userq_fence);
> +
>  		/* Store drm syncobj's gpu va address and value */
>  		fence_info[cnt].va = fence_drv->va;
>  		fence_info[cnt].value = fences[i]->seqno;
> @@ -968,7 +975,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  						   gobj_write,
>  						   gobj_read);
>  	} else {
> -		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
> +		r = amdgpu_userq_wait_return_fence_info(dev, filp, wait_info,
>  							syncobj_handles,
>  							timeline_points,
>  							timeline_handles,

