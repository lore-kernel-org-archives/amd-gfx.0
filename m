Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EBCCD98C7
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 09:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99CC10E74E;
	Thu, 11 Jun 2026 09:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bk3trriN";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA3410E74E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 09:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XeezfjDDrAwnUKmyVOU+1aG1m+ydM7RBq438n8oMTF0hE77G3/dDFx74LIahRhIb9fusz0+TMl3WFKELjj6pejGAHrC3JTJs8VjWEcdt1AYdL1P791td7lHqQ53I/oYe2FT4PtgHR6Xe1c02dCyTtkcLbA8xaGHTTjJTJWxvYRES0cGAcIK0+9otHG9M1rOTh4BW3yzdzCSMIVd75iqTEXeliGYGi7uV6MhMtIFDhxuMkracYXr9CLNJ+/qlvqqJZMXXtPySr0PeVFXfH3c2w1z5UDUqIJwx7e9dcbwRS5n9OZaqKJPCOi2P3qQfEWfDyC1BUlXFHt1cRbtedVblqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUL5DtYz2WQOSxFjtW6PXYhh5wEFIsaa9G5yCPWZEUc=;
 b=eHy2Kctzz9L0lJ79munD2rdbEPBaZV4Evk7HgTDQ7iQtYtaYGr0XtWlLRMpGj8/mjBgSlT35T6XjW2i23+OCIgeWOLiULVo4t9MpDEd+N/MK/d0syLn9Q+XVWqxhhzDQwMACNykyQXOKqLhGwf5FDiXfztalajltAQH1hjwToQ2HhYUCSjYjYYfqgoDazxe1m587L4FTzrhepg5mV/o9k/eARTtmRn8FhpA8UnIrozWB3/NsTPPCKSzye3wnnAknlet6y1CyI9tRVSpuCq/qxx2QEBiS/MmC/46V7KB1fyBp/x0oPrV2rkxuK8N5pNqQcisfC1sMXcOGDlqWnva6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUL5DtYz2WQOSxFjtW6PXYhh5wEFIsaa9G5yCPWZEUc=;
 b=Bk3trriNsDL+cbDk7b1Ghgx/pGN7l0K4T4bTxVmZS1blHOzL85wYxIIWJmHxUj40WQSlChgb1qeKCXlITjBgFzRmGlLS/rreNBwolihCnPT7lQbFVTE1Bc4r5wwlavoImiiFtgEx4crxZyxnEr+sFn/54DmyAx4K7Qp++HbroKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA5PPF50009C446.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Thu, 11 Jun
 2026 09:38:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 09:38:53 +0000
Message-ID: <8290c672-f85f-4525-acac-094073e3d6a3@amd.com>
Date: Thu, 11 Jun 2026 11:38:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amdgpu: add userq job and state transition
 trace events
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Pierre-eric.Pelloux-prayer@amd.com
References: <20260611083311.191012-1-Prike.Liang@amd.com>
 <20260611083311.191012-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260611083311.191012-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0270.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA5PPF50009C446:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bb1692-1247-424c-84ec-08dec79d4015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: k0rLnAJSO1GzpHhXwTxeTvA4YWfZIDlZtc+GpPq+xT+1rI1lPyTmn2yGIoEMIOZ0ZKq06nfBd8MFxGQnpAMbWIsXiY9IM80i7Q+24hLZnDSFBM7Abj5IR5dNJ4btCQV1oso3nNVq4kijQX6osJcqRl4P8xBXRqkRSAbp06cL3JUi8CoBqg7L3vhTbk1H+KTECRcfSJsoBWVeowQ0oL5Ur23gTVJBIUgPDa8RZWf0w5OYoWjt1LMsK896NmqenyfnPgqkO97shAt2ssh5JxkBrfB/j0duKjKCCqRX47QGVhYFrTAaDInn2jcNhJTUyNBcNK5V2zf883H5DXpjBVgnKTbdZ2N5IT2K9eg8KferM1RVcy4FxZ4cGXT7KjWa+OdNrY8btyqjZIApaUlmGU02jJnj1/5VONhZ4HdSRxreLaJ6q7lyBr7LTN8DHJHcrxLNjp3EmiE084tmAcH0FnDwglYZ7sILYR8nts4vt2147Fcv+pIal/I2Hy0oer+/XBRuY9Pz6rxIVmGQZ6n4kpyIa+O7s2ZHKyVmkq4chtPwWhZNX/3/gllAlY504fxsxortyp+P3sfnZRozlIyxFYEa9hZGBxGzG+s+XXiK3KjeFBufaeOdgYMUqy0Benq13MsLWjOXbcg9j6utGkCV9YoY6dQ9EyAFOkUEE/VzGywgM4lhbMmflT5Vtvguu9ZSlRCJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWlTZVZXWGZKRWk4TTAyckVhb1MzNkJrY2ltWG9Vbkc1a21ibHRwN0FFSmNm?=
 =?utf-8?B?bWRNVmVXY0N4V01MSEpOaGFnaXpVdzZudi9BeVQrOWVidWdNSXdqd2ZZcHd0?=
 =?utf-8?B?M0dGdkhMUmR0TlFXVTdGNWtGUGdJQUlhc29NNWlRaWpUNE9UbWk4VWxjTDhX?=
 =?utf-8?B?bXRkUXdJQllXY1l6cHlBOEQwTHFJZitMNC9ocWRJemRZaStFUFNZcnhTZWZo?=
 =?utf-8?B?ZlJxajBNb3hDRVYxUXo2eFN0REdjY0t0Q2Z0S1B3cUEyMzdTY2NPNEUyNVU5?=
 =?utf-8?B?bk5KYWw1QXFZaGtwSHk2S1NNUGQ2Wk9tY3Z6eW9ndDZUdTZjTHJpV29NT3N6?=
 =?utf-8?B?WlFSRG15ZDVjTFVodytMWGY1VDBwTVNSY3lKeDRTbkN1K0dkM0o0TGR6YlFX?=
 =?utf-8?B?WEV3QmpNQ1gwdjJTYmNtcml4Qk9HSFZYRE5LQ1ZMVFVWVWpXZllsSE9ZN3Vv?=
 =?utf-8?B?VitIejVsbk9lbFYvS295MWFuajJqTXU3cG9sYVU5eGg1UFlLQ0NvejVmUUhL?=
 =?utf-8?B?dzNJeW5uenVkbVVLQjliWkZHaHRWeGY1L0xRd2VJZ0VCSERvZlJoMHpNLzFw?=
 =?utf-8?B?YTJhdk9xTHRVWmNqcEYyYmRLa1h2VjBOUWR3b3VSUkJHSDBCWjBodlZkLzdn?=
 =?utf-8?B?VG8zRVMrTC9mMG1rNEF4MUhTYnNvK0R4UURRTzNjcVJ3UGRiakNRekFzb0lG?=
 =?utf-8?B?dW9OWkoyaFF2WTlZS1hpcDBrblNoUlQwazdiWFF5TEN6Q3lxRlhIdXdKVFR3?=
 =?utf-8?B?WUZ1ZS9wUUtWOHJicXZuYTlSOWY0Z1RBNUIxcFZZREd4c3IwSmNHOE16MVV5?=
 =?utf-8?B?eDNUaEc1WDZYMGFISWhRREJRV1FEUExpWUlwVzF5SVI4U1AwQnJLR3JnM1VJ?=
 =?utf-8?B?YlpZTWZzTmxNbG5mT0tONmtTSDJ6YjVOY2xUaFEzODFib0VRSWhrN1VWWHVC?=
 =?utf-8?B?UTlkOEFhVFNzZ05LbVBqTzJFdkxseGdDVzFXRHZOZlBrNVd0Y2crWWZaWjFj?=
 =?utf-8?B?SGZ3LzFzZ3oxY2psc3JxR1AyZ2VvVElySUp6NTZxN0M2YjdUUVRLNE1lODJT?=
 =?utf-8?B?WmdTM3JlYjhBN3BDU0tsMWZCVnd6SUxwTElWS29vSFJzMnFGRXY1SGx4SnF6?=
 =?utf-8?B?ZUdQbHlURzhwVVVDeWlveWhJNmMxalR6Z0VuQzFUZHR3ZmJUdEUyRENsQ043?=
 =?utf-8?B?QUdsdW54aDBOWGtzM3J4UFhhU3RFNTNNbWFydTB1TFZlY3BYdWpFMHhxZmkw?=
 =?utf-8?B?MiswL3hSRVpHZTBhVTJJTmFudVJSVFh2a0RQMDViNXNXb2cxNXdmTURPODZr?=
 =?utf-8?B?V3pUUmxoMkRmbm8vbk83QTgzZEdqb2NnM1l0MEhqampVNERKQzZIVFJXVHJD?=
 =?utf-8?B?UGlqYkdXRmlwYlA0cWQ1MGg4VHZLTUVjODdUNVpoUlhJS1hlbE9Dc2ZocjdX?=
 =?utf-8?B?TklkSnpibE51cFBXcVdVUUlTS3FXY3ZqNjZJcXoyYnA4MVF4N1M3emp5dkhJ?=
 =?utf-8?B?aGx2Rmx3cjhqaGJ4MUFXM3lwZnppMHZKN2ZLZ3NGWHpMenphTmNkYUxvRWJn?=
 =?utf-8?B?TjVnb0Zwdm93OGJTOEtiTDY0VkRWVGE4UDU0cWFML2lUZkRFdnlFWjVsYStV?=
 =?utf-8?B?RWhMeWFPZzhNZWFwWkd6TmJ0RWowSzVsRUVjYkNuZU00MXQvTTJybjhkbk1w?=
 =?utf-8?B?eThnY1dCRzVlV3Eza0MrUW9EbW9abFVhaytzamY2dXZOVUhKMWVrNEVVNFNH?=
 =?utf-8?B?U2Y4WjNBbHJjUlFJMnBrTFhxQkdZVnBnLytyVFZQRk94a0xsQnFLMWZVTU1N?=
 =?utf-8?B?K0JEaFB2OHIxbWdTYy9xaU9nNC9KYnNvdmQvT2RmMWV0cjNma1RhVk1xSTdC?=
 =?utf-8?B?WXpGQmNyTTN2cHRuL0VBcGUxVnpON0pYTXFOUUJmdVgwVHp0NHNIcjRDbXo2?=
 =?utf-8?B?RVBLODEyamtHdi83QkxVc0JFWUtyKzVMN0VnREc3ZmZHTTlCNEFOV0VzdEZK?=
 =?utf-8?B?emR4UzFXTTNjcTU4cm50WlBFZlVBNG1ua25Kd3FBYXVDT2dONnNQaUJIcVdB?=
 =?utf-8?B?Nm9DbFNTMGNET2VtVEEwak9NZWw2SXVLTEFmWERCRmFiY0l3VTUrUHFJVGhV?=
 =?utf-8?B?eUI1SksyUEtDWEhjSGhPMEdPQjZvVUl4Y1FLQ2F3Y09KNmR4dWJieGh1WFJP?=
 =?utf-8?B?VHcvOU04cmxxSFBpOU1rVmpReG1FR2ZKaXZwY1h3dDlsYU1leTVzZVFUdGpz?=
 =?utf-8?B?ZzZrdk4vMi94eEg1aEJnaExVRU53b2xYL1IzZjFaTU5kRnJzUFM1VkFEYWFL?=
 =?utf-8?Q?u4mSOwO8NNH/wWdMhH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bb1692-1247-424c-84ec-08dec79d4015
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:38:53.3584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEYOgskxs0p25qWkpiTpeKAjwYLrCYKUFiwtWlVjtNOyC922r3jTqnkKx6iIm5BZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446
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



On 6/11/26 10:33, Prike Liang wrote:
> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Add ftrace events for tracking the userq fence emit, signal
> and queue state transition.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Co-developed-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 113 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 ++++
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  12 +-
>  3 files changed, 143 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index df98be22f1f5..9f8506f04e9e 100644
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
> +TRACE_EVENT(amdgpu_userq_run_queue,
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
> index 64b9127ef931..ede2263d8458 100644
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
> @@ -900,6 +915,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>  		if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>  			drm_file_err(uq_mgr->file,
>  				     "trying restore queue without va mapping\n");
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
>  			queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>  			continue;
>  		}
> @@ -1392,12 +1408,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
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
> @@ -1416,6 +1434,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>  
>  	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>  		if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
> +			trace_amdgpu_userq_state_start(queue);
> +
>  			userq_funcs = adev->userq_funcs[queue->queue_type];
>  			/* Re-map queue */
>  			r = userq_funcs->map(queue);
> @@ -1423,6 +1443,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>  				dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
>  				continue;
>  			}
> +			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>  			queue->state = AMDGPU_USERQ_STATE_MAPPED;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index c0d68863fa17..95ee133f749e 100644
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
> @@ -835,6 +837,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>  		goto free_fences;
>  	}
>  
> +	trace_amdgpu_userq_run_queue(dev->dev, waitq);

That one clearly needs a better name or we can maybe even completely drop it.

The queue doesn't run, what we do here is to start gathering the fences the queue need to wait for.

Apart from that looks good to me,
Christian.

> +
>  	for (i = 0, cnt = 0; i < num_fences; i++) {
>  		struct amdgpu_userq_fence_driver *fence_drv;
>  		struct amdgpu_userq_fence *userq_fence;
> @@ -869,6 +873,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>  
>  		amdgpu_userq_fence_driver_get(fence_drv);
>  
> +		trace_amdgpu_userq_wait_deps(dev->dev, waitq, userq_fence);
> +
>  		/* Store drm syncobj's gpu va address and value */
>  		fence_info[cnt].va = fence_drv->va;
>  		fence_info[cnt].value = fences[i]->seqno;
> @@ -969,7 +975,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  						   gobj_write,
>  						   gobj_read);
>  	} else {
> -		r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
> +		r = amdgpu_userq_wait_return_fence_info(dev, filp, wait_info,
>  							syncobj_handles,
>  							timeline_points,
>  							timeline_handles,

