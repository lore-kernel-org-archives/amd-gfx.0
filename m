Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF866CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 09:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D4DD10E02E;
	Wed, 20 May 2026 09:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IWNAuQKu";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E552D10E02E
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 09:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2IRmt/fsl/x3uc9AJXN8FRXVjglXjR5UcJsnJ0us5Ag/LNKqdXyD0KehoeENP6qOJiWRr7TrVAKiszA1J1ZCvBzbyYOHGfoTdHziwUVSOy0soj3yDmZ6uF6vUTo9Q5KrOnnSMmSyShTO97WYyN1CZNqwfSq4Ffy0dYTO6ho+TlnuXOYnAoffb8Z7FeOA3Zjkpw3tMte8VplxBzZhb+EtOTJC6ZcoQcIXJSqyqMymP/MbX1iesqQuwmp54L5y7UvQArlodUUZYu6eh2ZjLCwvNOGinOYrRInmn529R5G25Y881U0RtryQF9bWnxPhj4GcNAv8zEhUs1OhodwnA3nGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVPFdgjnG+VyASA1cE8NYCg0VQMKjJXIfxrzObMQ5IU=;
 b=L3Mm5IL+ZtTVZ/uU7c5fKQ4no5WxqPsBbluQvcbxWvSUjzDJbQyQOkBuyJVnzVxYLY7rXDwX+T40dnFSCuz/fKEDPeXIV4Fh4/RSeTRIZucQ/IuKBViKA6hYoCJxHPs5xU9hyGMDnM/uVsWbYqMX2kWrgdYZSmLtO4t/Ip5NAaR8uDu5eW2XuV5U/ULP5aBwZZ6Bp8YqDqM5mgvVkumjYr/8rhBmWPghZmjx1I8jjgjEgNrx0oOM0ERqOPBH/bUHOYw/hByjLhUSfXKoxLURbu1tNnei+pf3TiVyzUpdqviVaBHChLnvPpG3wAmfc7xqqs7Ymzy0H831mfnvh7jv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVPFdgjnG+VyASA1cE8NYCg0VQMKjJXIfxrzObMQ5IU=;
 b=IWNAuQKupS8ZJfaWsACEaAYOoBt5nvnuATCyLk8+zUR5MPaQxoDF41/TfLaI8E9el+G4nerGdEdO+qhzooOy7+16hWSglYX7kqO2P6aooAtOHIBV+JCJGgBt3b7X1cW5psfxgPz7S8FEhIW8w6GHuBPREHnXttapLrrcbC0RbVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:12:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 09:12:10 +0000
Message-ID: <e7cdf6e6-527d-45f0-8147-240dba078aa1@amd.com>
Date: Wed, 20 May 2026 11:12:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: add eviction fence tracepoints for userq
 profiling
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, pierre-eric.pelloux-prayer@amd.com
References: <20260520063859.15914-1-Prike.Liang@amd.com>
 <20260520063859.15914-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520063859.15914-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:52c::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 452d9917-aa6c-44fa-359d-08deb64fdf5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|18002099003|56012099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: BUxej0CBqgf5iullTiDFpINkeNgGC0Rr1zaxGrvPejS5Nuhj5/habdD0Uasvc9dbuqTeK/FYiyyM147SwyaLsln9XgFsWh16BFnEewVYCreU5hMR/O3hrh4a9zz6XckgYB2QxunJPIi8Awk1ejrmbkixWPXTYa6jJlbxVrShymad/tZtqd4xiroafK/8wb/i7954UqVmywct8fYjg82RBvJ9NdnV1EPodTjcqivLnXWA3kW7TwiS2e/03PK6ChjsyuxQ+3FwHI3uMXpj4Y4dibsaGhkIsXIQk5cBdN915vNNQGkL0hT67lIdGRLCclakXwOYWSDq9PCZTbIiz4p4qFP6/cpLQacjGc0jVHgZsKVXW+6cvfPGMxQw6hiKnASZmDNxEUaEYDzHT2LjZSVuWVAQ52fvJxztjGgMwWWge/6IQUZHmEULUtINlqwoK4HCYfnivAxcUtF3cGdSzIKtk4TQIJMp5psLrYQDWVwogkQDzKIk9DriDswHfbXgWmDGEnEryHSht6Zc2vKAT3ANAeT+c+T2WNCin6QzZRVM5X1m9zdg1KaFszLaXvVMW0zNhQfvcpE2wbehiB78iJXpVuS9wToB3ulom/oHdq0zecnyZI0k5gqFLkgCo/xEOhPfy6nVG0ps2HKYcgNh14YiDiVN1Uw+d8rfkcO5E6DrCsbMujpH5bjLmJ8OXjYRt/bm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(18002099003)(56012099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzhBT2RNZGdDaE5NRWI3NjNZVWtnaXNHbHh6U1pRYXMxK2lNVHJlNjExTlF6?=
 =?utf-8?B?UFV4bTMxbkpYbEYvTDNpdXV6elpsM2NuN2tyNllPb3RaWHRycU9ReGV0ZFor?=
 =?utf-8?B?VjdObERZd1ZRc0ZGUWZQbi9BYUIxQ1dLdnlKZ1NVVWJGQnBOWnpMWGxmUjhq?=
 =?utf-8?B?SzF3S3FxUjRBRFhOdDRaRUdyYWQxZm91a2YrQXVhN0pZZ3NBSTdhemU0cmRX?=
 =?utf-8?B?bm9qbHVXZUl0MkxaRXNnR0ZReFh3d2xOdWZOc05iSzVuL1ViYU9tZGQvWnVE?=
 =?utf-8?B?SVJ2Y05QeVVXS1pxQXpGMGJPVHZOMkdEbCt0RU5RTC93RVc5Ym4raTNZWnBp?=
 =?utf-8?B?OWxGOGZjS2JoaTJheEowRnFGeEdRbCtZU01kcGltTUROaExxYThncUZBWTRx?=
 =?utf-8?B?SUN5SGEvR2lXTUVFb1VlTEd2Vll1bk1PQU9aOFEvcGRxNzduOFUvVld3YnBt?=
 =?utf-8?B?cm9zcTJPdDVTTm1sU3pFaEFDVmsxREQ1Q2w3VkZHU3Q3S3owUzNkL2hzZDlw?=
 =?utf-8?B?U05jY0pXdlA0dmFuQlUxQnkzQytFK0ZWS2c5a25xQW9wbTQxYjNzbFdMR0Rt?=
 =?utf-8?B?cFl2RGQ0S3lrVTFkUTRHcG9FTUU4NEY4Z3lnOENNL1ZWckZ2NVJEWnZoV3RE?=
 =?utf-8?B?L0YxeS9UM3JmTUVHOS9za0xMSjV1U2RJVkxreHNRNXlHWkhEbGVjVDJnSUZO?=
 =?utf-8?B?b3hTUEd3eW45ZGtKYldNU0MvMDBqcXVtUVVWUmxpc0xSN1VEV2JxWXBIM2tv?=
 =?utf-8?B?RlRFOXV2T001NWU1bVozY1MwQTAvUFNhRXZ2Y0lKOTBVS2ZkZjZ1U1RjRGNK?=
 =?utf-8?B?Q2JhUjFqa1dzOFZGcWNhK1FJY3NuSlNVWjd2QXlCN3RXWmtLamlmaXZkWGRG?=
 =?utf-8?B?a2lXUyt0Ymhwc3JsWTFPTW5YZFdzTVdFKzlnRTBySzBUQ3cwUStiRHVGYzJT?=
 =?utf-8?B?b05BNzhpRC81Ny8rWXBHY05EWHNCUlFDSDVraFFiZUxjYW9PSTNvRnFGb2Q3?=
 =?utf-8?B?bFY5d1BiODZJbFYzSDRDU2VVUHRuZS9xQU1DaVJBWTZIVitpQWttUEprNnli?=
 =?utf-8?B?TDhNOVVja2tOcExlWnNMNmNNbldFUTUybHovSjN2TFZGVlYyS0V1MTU5VFB5?=
 =?utf-8?B?Q3M4blBhb0RMOGxUZG04ZnduSzI5Z1JOTzNQTFZQdk9vencrSGFVZFFoa0Rr?=
 =?utf-8?B?N2R4bW8zUjlXKzcwYk14K2xoQytlZk52bnp4ckw2VlMyUWF2MHNLM2VIRUNv?=
 =?utf-8?B?K3ZNWjlDcGpYOVJsb1AzRitqakxGcWZrSnQyWThHTjBaQUtzMk10TU5XS0FU?=
 =?utf-8?B?TEh5dkRVM2FnTzhleWJIRGFZdzlQYmlKZC82V3ZoZWE4QjhqVjBUQVVMR2ZO?=
 =?utf-8?B?TFBJdmVwWjZ1V3FUMFIxcWRkc0lybUxlMFlIQmxQOE81UTNROW9HUkRXSmVI?=
 =?utf-8?B?b2FzZ1llLzNDNFBkeVhoOVlnVVo1QS8yNGRSRjI0OUVhcWk2RlBPVWpBZG4z?=
 =?utf-8?B?bVZ1cXFBT0NmZzVHeW5XVEJBdWFZRG56aVBjMEdVSFpKcjU0OVV3OWNJM3FC?=
 =?utf-8?B?VTN1Mm1xTFloM3J6elpzNkZPY0lPRTMrd0hRR3hrdVk0ZWxRNGtRNVAzTUV2?=
 =?utf-8?B?YUpOZFJNVjBlYmVMYkNsWGxrU1c4cWQ4MldSRkNoL2VZRmZDc0UxQVZ0RFov?=
 =?utf-8?B?MTZiNm1qdDQrL1M5ODZQT0RrNDRpNWVGTU05WjZIK1JHQ0o5cHVQUThSVlVT?=
 =?utf-8?B?L1lZQnhYYndpY3g0T0QrRVZjWW9WL053Z2JWYXlMYjJiWXJZc1FvelpDc3h4?=
 =?utf-8?B?UWl1ZmIzS2E4eUU1TCttLzJQeVRRUVFHd0FYYkEvRUpXQXYrdXJFaUVoLzRQ?=
 =?utf-8?B?cS8yWWZNSmhDdThTOStsWldiTUtWWjFzTktGL1V5TGZib0NqeTR5S000dTJ0?=
 =?utf-8?B?aDRmMVZPRmVwZ0l3RFNRM0RwSDlNRkRLWUo3dkIzYVM3Ly91M0h0TFlCa09I?=
 =?utf-8?B?ZHpRVmQ5c0d2c3pnc1NMQmVwRms4dXZaUS9CSEluTEVWTlVzN3hTWmtKcG03?=
 =?utf-8?B?OC96UnhhUnpVR1dCN29JZ092U0VkTk40ZnltWTVPYkJSVjE1TXFqbWJRVkl5?=
 =?utf-8?B?ZnZUTk9RN2x4cVhkL24xN0RPM0lncS9qb0dXV2hPd0F6VmVua0Fvdmt0aWhC?=
 =?utf-8?B?YjNwbXh0L2N5bGQ4RUhqdnk2aVBjOTJUZHFaTTVtSUZFdnR1RE9IR0EyWFZ5?=
 =?utf-8?B?NmZZS09QMjl5WStVUHhLaWNpdk1xSW95Z08yakJYUWI1b2tXbU9Da2FFbG53?=
 =?utf-8?Q?ft/WxLrvOM8NZulDoY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452d9917-aa6c-44fa-359d-08deb64fdf5b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:12:10.0662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kIn9RCd2TMzXA46oyIdkMaPHGl0vRtNzXtgcLPsEYH6ZLzr6YsxtfQEJTOUzjbZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
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
> Add ftrace events for the userq eviction fence lifecycle.

Clear NAK, the dma_fence framework already has tracepoints for that.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  8 ++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 23 +++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 5ae477c49a53..9358f9b35914 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -24,6 +24,7 @@
>  #include <linux/sched.h>
>  #include <drm/drm_exec.h>
>  #include "amdgpu.h"
> +#include "amdgpu_trace.h"
>  
>  static const char *
>  amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
> @@ -44,6 +45,8 @@ static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
>  {
>  	struct amdgpu_eviction_fence *ev_fence = to_ev_fence(f);
>  
> +	trace_amdgpu_userq_eviction_fence_enable_signaling(f->context,
> +							   f->seqno);
>  	schedule_work(&ev_fence->evf_mgr->suspend_work);
>  	return true;
>  }
> @@ -84,6 +87,8 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	 * next fence.
>  	 */
>  	dma_fence_signal(ev_fence);
> +	trace_amdgpu_userq_eviction_fence_signal(ev_fence->context,
> +						 ev_fence->seqno);
>  	dma_fence_end_signalling(cookie);
>  	dma_fence_put(ev_fence);
>  
> @@ -138,7 +143,8 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  	/* Remember it for newly added BOs */
>  	dma_fence_put(evf_mgr->ev_fence);
>  	evf_mgr->ev_fence = &ev_fence->base;
> -
> +	trace_amdgpu_userq_eviction_fence_emit(ev_fence->base.context,
> +					       ev_fence->base.seqno);
>  	/* And add it to all existing BOs */
>  	drm_exec_for_each_locked_object(exec, index, obj) {
>  		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 5a01f63d1f32..4ff8a4d7bb8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -636,6 +636,29 @@ DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
>  	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>  	     TP_ARGS(queue, result));
>  
> +DECLARE_EVENT_CLASS(amdgpu_userq_eviction_fence,
> +	    TP_PROTO(u64 context, u64 seqno),
> +	    TP_ARGS(context, seqno),
> +	    TP_STRUCT__entry(
> +			     __field(u64, context)
> +			     __field(u64, seqno)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->context = context;
> +			   __entry->seqno = seqno;
> +			   ),
> +	    TP_printk("eviction fence=%llu:%llu",
> +		      __entry->context, __entry->seqno)
> +);
> +DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_emit,
> +	    TP_PROTO(u64 context, u64 seqno),
> +	    TP_ARGS(context, seqno));
> +DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_enable_signaling,
> +	    TP_PROTO(u64 context, u64 seqno),
> +	    TP_ARGS(context, seqno));
> +DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_signal,
> +	    TP_PROTO(u64 context, u64 seqno),
> +	    TP_ARGS(context, seqno));
>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>  #endif
>  

