Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28E9CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F96C10EBB1;
	Tue, 16 Jun 2026 12:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XLbOVdI9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012003.outbound.protection.outlook.com
 [40.93.195.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928C010EBB1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 12:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjLYmAc8ev7v4D+Dr885MMDU5H/1Cmlo/Cles8Pj9egNT+vFnqO6gQYfueiLNU/c+Lys42TohAE8yOiN4xMccQ0HBLArTm33TUBdQPKJosdrkdroULAWh+azJ/LWEhfNMuP1Div07f5tzqsTYF4IMvTfuXjEbFqm/meep7dtBBv6n7qMKH9dbIO8H8+AQc25rWR4iemqknrAa36LqTUbeRwCFkn36OFn6gQ1G0XzqfJSp1WF45+SjyDCllOIP/O73YN4nTKlc0LNARiLVVhtDT/QERSd7ZlhH5UVPdaffMS76XGP8vtb/1fsGsCgGDzcPYYHT0Lo/oW4Pm6FUERWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCafTQUZi1Eok4EyvMKKaLwyMztH1SkbZl7yW/ySCTU=;
 b=cKxdgXPIuyL9njuL4APtN+hw45o0j7HiszoOcZDvv+0thVYtYbP292vFe71GLVOZ/gB2tCvsMv9xXfc86EU1/kJqqrnFoZC4Hpz+dlgAgwgVB9iHVJR44Yl2QQK+hNa7MCtZvLGPO5jwkHGNOfvkM3QZ7FRz4w/1p/5RTkSVRD9zEpijH+aJv5TbL+XSHGRsqQjnIjrcXB/tyudscAfzbCvVgVgzEljZvjSooq64tGNgxgBMBdB0J5KYHb8QZbrHUMlQqsGog2tbkwpD5diKNfZS2JIchbgnMfr6KvRDLAmUeSCPzNGcPVxU9Oo0j/kAfrrAtouP9Z15Q3fBcoe9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCafTQUZi1Eok4EyvMKKaLwyMztH1SkbZl7yW/ySCTU=;
 b=XLbOVdI99OVEeF0sU/68FiUvc1dyg2c1mE9xdl3xmdVqvZbunFDP++tw45J5goxESj4p2L0NCosfnJ3EB2AmsKemS3K56pyIm4JQqlQ9B4+tdSvM0W62VvG5QVlyUcb6XagXaxX/sdl13y+84aA7JHhRQIUY9cePUJQDDwTIDUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:57:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 12:57:03 +0000
Message-ID: <74ac6544-39ed-44a5-ac39-3a7c0026387c@amd.com>
Date: Tue, 16 Jun 2026 14:57:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amdgpu: add userq job and state transition
 trace events
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Pierre-eric.Pelloux-prayer@amd.com
References: <20260612064223.196556-1-Prike.Liang@amd.com>
 <20260612064223.196556-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260612064223.196556-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: a15063f9-83e1-498c-b743-08decba6c33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 3RSEOJdZTssDtE/i2r2zFQFGe5637b8YQbLi2lLFV/5CxVLvHfkiZexpn6lI8K02CEjxBLYwkUWSjOvxLksEXw+t/YswOkNKgu5MAdxLLXHsK7XgHJKu0IAxFi3sCYt8RfbXPY0dnxaoC2a7simWMjs2Po1EX8Ty7NHxzGuuPfyQAHP/zYp4Ee/UGCyR4c6r0SmRD6gohDlyR4fdfSaz3bvToAt/IugiPZNzXIY8AU8BHBfumAmaK5wgAet/KyTsq9GYMnt4kQ+yX5OCDdEa1DIpPTsbrcYHYGEcdVd7v5cokzgFvHI3kiK/3FDjOIHzgIeHrKpVteEJypKUCke1t82w29aNmcuk6hOSELeuWbK/B7jUv0U/VVLYxagfZu8tYB7qMXfCExEpCgheERKneQJnPcyWntqT62G6f2T6C04QkzC5urgiX6yr/ZEASXJa0gZpHLthtyjDTAreZTd/kPhUXCjM9q0rXWFMSK/Z9IWPbsL2jZFe9K90rNcRiJxllCrqMKDppo+WtYHNFlwTw1KDPxl1hcYIUt2tzl1GXzj2WdX4NwOQK/s7P0tmJDkK48XcpDa7qVba6fIfaDVM+7S4SoUg1z7xbJRYFVOfRVDdek/v8DjG4mrAF5Ik+0hArmewXMXrI84I8HdX1SlgVCJLRqZhV4ubHZWgoVHx6viHXHJ4YcWLVfE9CNv9Sd6K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTRqZDNFOGgwTDdRTlhMdjFrVkwxRlJuTzg1MUJXbFgyK0hjWUtxWnczVUQr?=
 =?utf-8?B?RHhPQ3FkaUFGK2FGVkw2T25BdUxCamUyQzZrT2xkUy9mU0ZLTm1adGZQZTZY?=
 =?utf-8?B?ZVlJSmxjN0lNVmw1R09DL3E3bmR1aVUrVkN5MHg2cEFLN3BhSjlvTHRhQ0JP?=
 =?utf-8?B?ME1BbGYyNEYzVHFEdVp0dEIxeG5mMnRqeVFmclVoZHNPb052Q3ViTHZ4cHZQ?=
 =?utf-8?B?SWNRczN6OWZlKzlFNUs4UUdBbTdqUkVqaFQwYXZLYmErMURwaWVZa2pwOElr?=
 =?utf-8?B?akx3MmJMdG13VjBFSmNIRUp5NXZiT2ZIUThQTDVaaE4wc3ZQckQyZzYzWkJQ?=
 =?utf-8?B?YS9uL3FVeXJOZjZtdmJmazQ5azB2dk1EYlZDTHBUYWVGajFOaHVnMGdTdW1P?=
 =?utf-8?B?eDNzeWVaK2VISVFlQTAwNmlCa3B2MXFGSzNWRDgzTVRVOHVTWXdyNHFBL1Rs?=
 =?utf-8?B?aHQ1QkxHK0RsbkplNmJLNWFhY29LWlJKYlg5clBsOFAvclNRa0d3OS8yMFNk?=
 =?utf-8?B?V0dyWWQ1aWkxRlBQeVdjUDZLYlZPRytoalJJcklNbEozU2JTbEV2M3pwclh5?=
 =?utf-8?B?NG9QYlZPQ1hVZEFUUCtBS1EvZ3l4ZDI5WE95aCtQVnNOWXVYYk9xSW15QU5y?=
 =?utf-8?B?KzZ1eDI3WHo4NHVKVWt2ZHdNbCt0bHdxWERCUTlNR0pLNzE0YjRjZXROOTBw?=
 =?utf-8?B?MHhwb0N4ZDFrV2x3T3hDeXVucTBXQWE2Wkl5OE0wTGRaREdKTmNlVFkwNktG?=
 =?utf-8?B?SjhtR0JodVFENjVSQmh4d1hvWE00RWhZNlNlV1ZJY0ZSenJnZ1VoWXZ5WDBY?=
 =?utf-8?B?dnUvR3Z3M1FXUlVBZzk1eE5qaWwvYjdiSFhZRFpiM0xzV1d5ampaOW5UTXV4?=
 =?utf-8?B?aUpSTDlVL0RDR2FBMVZOT1lINE84UnpwaFMydnpyRWRjeC9YaUR4ejhIMlNF?=
 =?utf-8?B?a1FTa3F0bzdYOStHOWJHTHp1SHhHeHRDUElqRlNvSVVVWis2dkUvd0l2aFJo?=
 =?utf-8?B?UFUvcjZDMzRYdldUdjhYdGRoekc5WXJzb2NRMHhnbXRSVTBJOUJLb1RxY1B1?=
 =?utf-8?B?bUVPWGxXbC9EeEkvcU1vcTZoV3ZyVGgyYTdIY1B4SzRXMVRFTnBNdC80L1VI?=
 =?utf-8?B?bzI0VTRteERUZmRMQ2FXL2dTUWdjREFtWEQ5Uk9VRll5WEZZUnkvYUpsQlla?=
 =?utf-8?B?aVhjYnlNc0dEUVo1WHV4K1VQK1NEWm8wZ2dkM1RtWUtEQ2djeWZDRWNReXZV?=
 =?utf-8?B?elVuTlFVUXpIanN4dWpPYVk2WjVkK25DZENzVFVpMThZeFdDV3lNbFBLRXJH?=
 =?utf-8?B?WXBWVFZtaThyL2ZLdTVDS2E0ZUJna0dra091Vy9YSEwrNlIwMkNsR09sMkhB?=
 =?utf-8?B?TDgrOVpQUTVZNzFkMGdNZFA0SWVDc0x6UWU4bGhiNzduYWFUdGM0NFVnMjlw?=
 =?utf-8?B?MnpxUStQa0ZibjZ5UWwrQU5wYktyRUxEeDJVSkRzdkJvcnNhUUJsNEEzd0hy?=
 =?utf-8?B?eEVGczFrT09McCtobTZTUzc4YXcvWk5Ja2RxWGR1Qk9FUG5qd0tpd2hWYXFU?=
 =?utf-8?B?UlJXZTlFSUhOQ3dZaGd3QzhCNkowcnB3M205MTcyMGF2R0huM3ZLOGVGemEz?=
 =?utf-8?B?aUpWeVVpSkFFM0F3c2wrS3l4eEVZSVhhcGY3ai9QYlZjd2Rvck1SaFh2emVL?=
 =?utf-8?B?NEN2K0c2WVNGU29EUTlLT3lXQi9wUWlHTmptMTdEMVZnd0g0NTFuMGhGQ2xQ?=
 =?utf-8?B?MG9aMnRla2lmS2hWNGRRend2c2w0NThudm5idXB4aS9lUGZxcjVmdG80bS9P?=
 =?utf-8?B?bmRGMHZzTHRHMlZuQjQvQ1BVTnNramR3eG51bVMzY1BIcWV3STdpVjJGazN0?=
 =?utf-8?B?NG1EZVNueURYOERXZkUvV3R0bkFObE9hdlVmeXNmSWxpWWJiYVhnWlAxOWha?=
 =?utf-8?B?bWdMWjJveFhZbXRiaXpVa29GcUFPdnRTYjBlTFF6RG5rMUxwMndrQURSOU5q?=
 =?utf-8?B?WVlDUlFac2hFUzdTOEZuZjNaTTNJem5QWjMxeFd0dnN1Y1lCZTJPa1RqblQ2?=
 =?utf-8?B?dXFzelZpYTgrdyt6TVl0bkYvYWdSNWlFTVNzcUh4RjVtSVZvSWVURUFNbFJJ?=
 =?utf-8?B?UENVajd5emF2SlRiOVEzRFptQVcvMEh0R3ZFcFVzNEgwTjI0dEhPbWYvYU01?=
 =?utf-8?B?UjZvVEhvZXhRTW10SlgyQjFyZisxNExBQW5xbnJBZ1dDdmNscFZKK2JDMjNP?=
 =?utf-8?B?V2JMSlYwMkIwbXc0SkhkMXpDblE4dDV5dHI5dVRsRW9GZVladVcrckJGK0JT?=
 =?utf-8?Q?IhJaLKFrKg2TqDzNKD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15063f9-83e1-498c-b743-08decba6c33c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:57:03.7437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkQv1dgP02giffe6f1ZLSLA2NcD8HhbEwE7z1Oc2Hz23NrKKIKqeYT2eGua+i/D8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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

On 6/12/26 08:42, Prike Liang wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Add ftrace events for tracking the userq fence emit, signal
> and queue state transition.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Co-developed-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 92 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 21 +++++
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 10 +-
>  3 files changed, 120 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index df98be22f1f5..fcd4cf2f4cd8 100644
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
> @@ -636,6 +638,96 @@ DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
>  	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
>  	     TP_ARGS(queue, result));
>  
> +TRACE_EVENT(amdgpu_userq_emit_fence,
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
> +TRACE_EVENT(amdgpu_userq_wait_deps,
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
> index c6b9e8fc6293..210d83b0aba5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -294,11 +294,15 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
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
> @@ -314,10 +318,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
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
> @@ -335,12 +343,15 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
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
> @@ -357,11 +368,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
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
> @@ -890,6 +905,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>  			drm_file_err(uq_mgr->file,
>  				     "trying restore queue without va mapping\n");
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
>  			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>  			continue;
>  		}
> @@ -1382,12 +1398,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
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
> @@ -1406,6 +1424,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>  
>  	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>  		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
> +			trace_amdgpu_userq_state_start(queue);
> +
>  			userq_funcs = adev->userq_funcs[queue->queue_type];
>  			/* Re-map queue */
>  			r = userq_funcs->map(queue);
> @@ -1413,6 +1433,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>  				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
>  				continue;
>  			}
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>  			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index c0d68863fa17..751535a7aef9 100644
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
> +	trace_amdgpu_userq_emit_fence(dev->dev, queue, fence);
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
>  				    u32 *syncobj_handles, u64 *timeline_points,
>  				    u32 *timeline_handles,
> @@ -869,6 +871,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>  
>  		amdgpu_userq_fence_driver_get(fence_drv);
>  
> +		trace_amdgpu_userq_wait_deps(dev->dev, waitq, userq_fence);
> +
>  		/* Store drm syncobj's gpu va address and value */
>  		fence_info[cnt].va = fence_drv->va;
>  		fence_info[cnt].value = fences[i]->seqno;
> @@ -969,7 +973,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  						   gobj_write,
>  						   gobj_read);
>  	} else {
> -		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
> +		r = amdgpu_userq_wait_return_fence_info(dev, filp, wait_info,
>  							syncobj_handles,
>  							timeline_points,
>  							timeline_handles,

