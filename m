Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB657CD8C92
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 08:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FEE10EF3C;
	Mon,  8 Jun 2026 08:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oh3Oj4VJ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCFE010EF77
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 08:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTCCmIqiiAIRiHv6VbIdzeqsqzf/7eh6r5AZKco9QMX8ACjB0B4MJrnW4/4lx1+EwVnsICFUsdQBAiAkZ356uHjZg03PI1OjSa+Ro6UgjqTwcxzoUpfFscBpHfUv4ecemo4bvMsZMraOSO0EtKP98O/gY9rNFjuRBUwpKTd4TkHljEatZ0uzk55KtUIzwEeN4uP0Mp95RGLpOD4sJl9p9ClU4bXWWvyc+VUAtfeVJ9oAWTolZnZGVLqUQL1OK8+sH1tLvlnYqtqT6fp6gB+POxHjlsFMdHkAfnDPTiem2LOuNkZPh5Q8IXmhGGgKuxBG82rPWmXom+dJQBZ8kSq0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4KkgEmd7IMrczsE1igQnmQFdNwphGMm6gVNSH/rnE0=;
 b=KT/Z8oMScFbZguQ6s5dj+WbIsxa7Y2XOEPUJKs8PFalWeRhoW92jiE6+1IRS80ysCDUqZ1iyertUXeR92vnfBdEPyTeesaf32d7j1SK2EiV/8RzNj68Mvdrj96GgkMtbsBsIzmOGQ/0D+NNQvaRdFJ7hYqBgeJOAh2cUQoD82W9AOF2mAi16UWRvnjYktL18iSU1uXwbkXDjRVf3R+Aeyp1kLwGJIUx00PU1nVe/SosrQVCK0EpQMc2Zj8j2973cb1sxQcEJH2pNXL12/krj6l419c1HRHd7qfyCpAufuVaDhh7rAE+d1AzGm6cPDSFLkCmrZPJnBo5VbjVAjTozOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4KkgEmd7IMrczsE1igQnmQFdNwphGMm6gVNSH/rnE0=;
 b=oh3Oj4VJHu2Lan70veyHi1pogb4RLU/uvYP6ktcFgW7WAs0jCkVXJyUe3wGAC844DOjtF1b2wnv5a57lf9ViFLScCeC/WWXIXadbGJbKGS2BGoLtivIcdg8Q7GDJ0/tRIONP16v8ZepeLxOsdIcifj5wyW9w0lZaZDgk02lvmpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 08:34:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Mon, 8 Jun 2026
 08:34:51 +0000
Message-ID: <165b0fd0-32af-44e6-aea7-924432974268@amd.com>
Date: Mon, 8 Jun 2026 10:34:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: add userq job and state transition trace
 events
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Pierre-eric.Pelloux-prayer@amd.com
References: <20260527122001.69831-1-Prike.Liang@amd.com>
 <20260527122001.69831-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260527122001.69831-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:91::37) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c047ae-386c-48d4-c1e9-08dec538cece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MiNBVkHAA4FeZUG2AY7Jt7VPCJaWCzm2GNe43gVYMk8jQMM1inCt5Nc45dVVndv6RW9qGVsZUSDOdgtaFMmmdkQtZu+b32I85pc+TPGrvQzfHwZASDkzCR7W4QrUPjpQs9fB3afEKSiEwmubM+1rVXYKJamT2GRJOcjNRLHjBwdTJDU/vEZgzXhV/nELAtB3iffXOAySuum+guLPMl+GDBagPx9vCvAkvihucOUtyCTTik+v3TVtzYlSKE3a6h/vWqsHpgv8NagOVWmhXKIV/Vdd7ev60Z7cFrGtmGFzOsaA12/lKSz0nxl6EEznDkTsqG4qYN2zWahgZHcTGRJTsztNwKDNg/ti+9s4aRwCKZ/CCqC+Pd3mbEHuzhPzYv8UO3JwfRHACP5MzAtoDFd+H33w9bdZAFT5KJ1L8P4WFULKrW+XWYWTgyq7+1rggPidqkI3M7k5GQLrTHzEPgkxIgLuEfyEPPJSPLweobufUEopbW732C7TSbHXIuLFn21O/BTms6jXs5K5lNCTU1vVge95pMOHYN19AhDUmLilxYtCrL4oiVy/ovPuBbzRV0yP0Sd4ImCOeMFisYDlcUNKW70bXYNfh4xySOcqhpJhgotDFZZsbhzrkTMSylPDeowX3ObNuZXB0CPEc1te5hYoYM8eIaiUXxhqKAcVm7wRp7bacxgSOSjecpzL6bBeM1a5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWdlakNKVDVVeGtPaTk5T2dPOFdKL0VWNFRuUkNtMWs2UkpXVzluSGxEMTVI?=
 =?utf-8?B?MFBzbEJRbU81Zng3TDhRRTFmeEtBYmQ1Y1lCK1djc1BmL0I3VDhLaXkrNWc4?=
 =?utf-8?B?WFFVZDdJNjVGMkRuN1UrZTVuL2RvdWZ2OWlXa21wS3hseGt2NDJobFFzNzR0?=
 =?utf-8?B?UDlHZFcwUHFpUmJ2N1VhMXl4b1FXOFFjcUtGSVZuS2xRL1YzVTBSbHNPM2Ry?=
 =?utf-8?B?U1B4L2svWndHNlhCck9vODlwMENaT3BCVlBaMEE2ZTRoUGxQeHBBM0ZYQThn?=
 =?utf-8?B?b2hKTXJoRWhQcm1LVlp1bGVtSG8rRCtsTU1YVmN3aWJhbS9RUlpDeVFaSXJa?=
 =?utf-8?B?TTdJOVg4UXBScTQyV3NzU1BjVStHSU9GUXZIbUI5bmxaK1U3ajVSNHp1VGlx?=
 =?utf-8?B?SWFNQ1lOZEhUUy9MZGJWQXpZU2psS1oxTjYyQjNlVmtSNkZLdHl2NlFyQTBV?=
 =?utf-8?B?UE5HUU5uazV6V05ocmp2NDZ2dUJwa2dSNmZqVm1VOW9NaU4wRmYvVVJ0TmFr?=
 =?utf-8?B?a2dvM1V5MFBzZ0lZOGU3ZG1kS1JIRWNJQ0xpdVh3QVlTd1dIOUI1RGNtc09a?=
 =?utf-8?B?K0NWbnVpUFdzcTY3aldUTm9mNENHZ3VLYWp5KzhXM0J5TlNBTHl4ejZqMnVz?=
 =?utf-8?B?NE5KYWl6RWxldTkwdGZaaW00Z1pXSlZMZG40Z2dGSzNoVDVodmVkbXMraTVU?=
 =?utf-8?B?VXRWaTFKeDc1TDd0MEYzOGRBVUMrSG1aMnFzYjR3OUYzeFFGdjY4MzZ0eFls?=
 =?utf-8?B?ZTZYTGh6ZzdZTC9jTEJnT25YS1FMbmJWb01MRUF2TFNBdkY3NWxua3Zsb0pE?=
 =?utf-8?B?YUg2NWFQV1JkZFdYVU5yUVJ4ZkdWeThjMFV0bFRxYTZJMjRYKzR6WURpOWxh?=
 =?utf-8?B?aUNYUW5XZWRsdXExUU1ybEhDd3hsbCtXQVY3Rld5L3gremxFcVFOcmR1Q1k1?=
 =?utf-8?B?SnBtaWJPUElTc2xhTHl5SHhlNkdXdXN2SklERGNxc0dZUkkvWFd0SE80UHlD?=
 =?utf-8?B?WDY2YVkzTWZnNGZreGlKVC9Gd2FpaFYxNkZIdFQvajF4ZnhFYVBhRlc1MUsx?=
 =?utf-8?B?aWtkSHdhZWYxWXJHc1JoZWFqb2pOZElPMkhqa0xpVUs4TjZ0V1U2ZERWR094?=
 =?utf-8?B?dVo1L3AvaFNSakhkMW9lRXdnSnovTmVTYjBEaEo0T2lUTC9rdnltSDZ2Z1d3?=
 =?utf-8?B?WHVxYUtZck5HZ3BZeUZQZCtRK3lHNkFQeldzVjNMMGE3bHNRY05mRUp6WmJN?=
 =?utf-8?B?TEZUR0RxRm5hNDZSOHlGQnJuZUdtdzhYcGJFcGJQUnRSbVFuS2VxK0dGanJ3?=
 =?utf-8?B?Q0lVSlVtNEZyK2JDb1NZNm9oUUNmZFFLL1lrZVIxTk0veEllSk0wQmJEejYv?=
 =?utf-8?B?d00wMTluME1nQUVac0RVcGpIS3NsUG5OdFl3ZzNieEd5Q2x6VjJmNldTYnk1?=
 =?utf-8?B?d291MDVDYU9ZdVpEam1KMjFhTnZzUFllS0VIRVlpUTcvVjhQSElXVVUxQ2lz?=
 =?utf-8?B?RmhOTnlhR3h5VFM3Q3JOTGhkc2hwTldZOWJmQlBsaitxKzRCZmhobkhxQWFY?=
 =?utf-8?B?dVlCY3JqeG96L1A0MUF6KzV6azZxc2dubk5Qc203cFNkWEUrcDRLMVdVUzdN?=
 =?utf-8?B?NGRWbjRMSWdSQUt6L0VnRzVnSGhtT0dMNDdIR2dIYllwUk5YdVgrTEc3V0cy?=
 =?utf-8?B?TkJ2cDhNeVEvOXlXaUFiRkx1c00yZ1RNblN3S0w5SnhIVEN6eTNycUt0MFZ1?=
 =?utf-8?B?RVViUXQ3eGVBVzdhbWZQdFFQSW1KWlNWMUg1U05mRFBZbGRIeGVNdU9ZSkFY?=
 =?utf-8?B?RFN2TkNTT3dtdEF2eVdGVTNuS2JEeTN5QkNJUGV6L2UrNGExVDVmTURQSnM4?=
 =?utf-8?B?ZzZEVFdsY0hoM2E3enJMc3ZXS085a3o4djB1R2VUeEhrMmhPRDFxMFlxZENX?=
 =?utf-8?B?NFh3dklhQTVacEUyMHVKdFBqS1p0bkFDaHA5UDlJV3B4WjF2Y2lWRWN3aFRr?=
 =?utf-8?B?QzNucnZ5TWF5Q3pPejZRUjZ1SlZJSHc0cGRUWnB0VmFXdENNSFNTbyt2cFov?=
 =?utf-8?B?dS9jVkJWcUhNUWJQYklsczVXcmxES0YzTHBIY2pseDZDc2JPYnJoRXI4R1Uy?=
 =?utf-8?B?N2xXRkU5R0x6RnVWVVdCLzRZU20xVWQxcTBPbml6dkc3S0YxeTVrN2grcEFM?=
 =?utf-8?B?ZHVnUUdIY1dCSTVMTTVMTkg0QTBNRllLYlRyWWt5L3hIb3A3S0plOEhSTFpC?=
 =?utf-8?B?MS85UExLTVI5MmNDbW9TUmRQcDZGTUh3cUhqVXhNZm1XSm1zdjEvR2liQjcw?=
 =?utf-8?Q?1PaVf18O8Cn1cGO1rB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c047ae-386c-48d4-c1e9-08dec538cece
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:34:51.3658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsVdHnuoHomN2AF+BNIj40ZWOPOjdcduvh5S/yeuPgqt+mg4zu6OmC5cJvkGXr58
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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

On 5/27/26 14:20, Prike Liang wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Add ftrace events for tracking the userq fence emit, signal
> and queue state transition.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 113 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 ++++
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  12 +-
>  3 files changed, 143 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index df98be22f1f5..ef6a1fb82ff3 100644
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
> @@ -636,6 +638,117 @@ DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
>  	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>  	     TP_ARGS(queue, result));
>  
> +TRACE_EVENT(amdgpu_userq_job_run,

Please don't call this job_run.

There is no concept of a "job" as in the DRM scheduler which gets submitted to the HW.

So just re-using the name from the scheduler is a clear NO-GO from my side.

Regards,
Christian.

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
> index 9dc6cb579ac7..536e73c7e9ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -296,11 +296,15 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
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
> @@ -316,10 +320,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
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
> @@ -337,12 +345,15 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
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
> @@ -359,11 +370,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
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
> @@ -894,6 +909,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>  			drm_file_err(uq_mgr->file,
>  				     "trying restore queue without va mapping\n");
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
>  			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>  			continue;
>  		}
> @@ -1389,12 +1405,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
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
> @@ -1413,6 +1431,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>  
>  	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>  		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
> +			trace_amdgpu_userq_state_start(queue);
> +
>  			userq_funcs = adev->userq_funcs[queue->queue_type];
>  			/* Re-map queue */
>  			r = userq_funcs->map(queue);
> @@ -1420,6 +1440,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>  				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
>  				continue;
>  			}
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>  			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 008330a0d852..6071e83acd9e 100644
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
> @@ -528,6 +528,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	/* Create the new fence */
>  	amdgpu_userq_fence_init(queue, fence, wptr);
>  
> +	trace_amdgpu_userq_job_run(dev->dev, queue, fence);
> +
>  	mutex_unlock(&userq_mgr->userq_mutex);
>  
>  	/*
> @@ -701,7 +703,7 @@ amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
>  }
>  
>  static int
> -amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
> +amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *filp,
>  				    struct drm_amdgpu_userq_wait *wait_info,
>  				    u32 *syncobj_handles, u32 *timeline_points,
>  				    u32 *timeline_handles,
> @@ -835,6 +837,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>  		goto free_fences;
>  	}
>  
> +	trace_amdgpu_userq_job_queue(dev->dev, waitq);
> +
>  	for (i = 0, cnt = 0; i < num_fences; i++) {
>  		struct amdgpu_userq_fence_driver *fence_drv;
>  		struct amdgpu_userq_fence *userq_fence;
> @@ -869,6 +873,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>  
>  		amdgpu_userq_fence_driver_get(fence_drv);
>  
> +		trace_amdgpu_userq_job_add_dep(dev->dev, waitq, userq_fence);
> +
>  		/* Store drm syncobj's gpu va address and value */
>  		fence_info[cnt].va = fence_drv->va;
>  		fence_info[cnt].value = fences[i]->seqno;
> @@ -968,7 +974,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  						   gobj_write,
>  						   gobj_read);
>  	} else {
> -		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
> +		r = amdgpu_userq_wait_return_fence_info(dev, filp, wait_info,
>  							syncobj_handles,
>  							timeline_points,
>  							timeline_handles,

