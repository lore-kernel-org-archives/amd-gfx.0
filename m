Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D21CD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 09:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A1810E0E9;
	Wed, 20 May 2026 09:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GeAqFFjB";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B901610E0E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 09:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJdPCkWcAICbDIsqcEZqtzcqJj+M/Ab+eeB3kBZHv9EH87XO5Bi0MT2GazgeHrQc5h4YAHlyBTv3PCmnIKdpqpO6XRMLjBcEcIpHeOtjDb4kv5AWh7SKJ/o3uE4QPSwVY1qOYy16AW95EffrH3EqvupdhALWfqhGZiSXNSij3VX2uZ6rmS1Bwjctwwy+XRN0QzUjFI+H/jzJghrQf1Hy6q3zBoLQUY6LciP+zGNSbQu6Q6MUz6Sy/Jn818mr1dPHjdc7AjmNtQRcLw0xppuGlw0bx+Up+j4O0XsNW4Ow2wWoM5LUOjbnO3Y/1pomNkdwdwvPY4wn9kp/x59lAcT4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S61q1HX6DiTTb1lsyLcC+LOS88bcO+IDtEWVDMYDpRo=;
 b=L5mabXVNjfo2KHsFcjTZUCHhUpgFQS7DOKQZYPL6VID4s2VTRulRO6KSccs/sUWcCgopiDaJhczVOLrg5g1RG7qVDaWCLyjkr0z0DZGsB8varrNwpxNjFNJ2pQm+D2a+WXJkW+nf/RFqy29Ov0tloEIJ9L9G5k8JM4JTYf9mk5cnKiXLUlmL2swvXrQjGdws0H07y14yjLu4PcA9ZI9uMt4UrPtIvNVB7b2EDeeScPrYKJqfIWh30k2iJ+7uD+KPr4uyXnpQE1Ei0kl2seO5t+kuCOv3N98kCVHIlxfXFrSctQYZIElGI3JDs9ZJaMDp6YvpKUATL3HO+tZC3u9TcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S61q1HX6DiTTb1lsyLcC+LOS88bcO+IDtEWVDMYDpRo=;
 b=GeAqFFjBDGJhhMmls58OpO0PG92k3/won3IyjgQeVwonNvru4DvGqkzHNkOzPl4ZM6zdC4MLKsf+/w2haoi5jysa7zSIh2fYwkaWjDDG/pgMh9jmlZ5WD7NjjWSnV7WwkcX6E3V/DkmiHU0a2gIF/TRRZ/PNUxZsNSoBxF9ddQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 09:10:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 09:10:38 +0000
Message-ID: <9e333b39-554c-4064-996e-b1d31490c64c@amd.com>
Date: Wed, 20 May 2026 11:10:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: add userq create and destroy tracepoints
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, pierre-eric.pelloux-prayer@amd.com
References: <20260520063859.15914-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260520063859.15914-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:52c::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: e56ff393-d741-4071-0b03-08deb64fa894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: XD+kza5xXzsDHIAZhH77wiFBEHfJNZK5/nQelEos8sVvotmxOp67IbFeIXrg8lhmENr+VnruXZRM/dYxORV2MeJJvCPJ6I5MM9FON4YsoxZPebkXwKdDntxS6MoBQguhPEpB3L7KusDZcq6ZU9N3Dr6Xo98DGYnrf/uBD8SsGDJfnIq/KHI79qZ+bPYyX7/qeebg1rzK3+a4PCY5KTbmM1wAXKU1NTgauaTiutYnzL2jLolXfoo5BqQmoKuzcymONV9eIU/We2sPmkyUfkM7/6JHK3lh2p1rqR70CMhzgvkEUTg1dIlHIXEeRbsOqPHGrE0JHYihQORnnR1CD4pkYSF2nVqEMtNIQwrYw5EatkiY6hh9pgI2YBO1dRMph5YuzOFrZpWyl/ncGBd6XDTz7qYrbEAO5rSSviqCPn8u0o/4kgY9nGePk00DWsB94ockJJBmJGJy1yLfpNeSAs/LstVF5uchYcLXOkF3BGkVpRX0KAICEOHg8XeaZWzRMQAdxUcms2PFwPoRPHnSxo10VLzFtiQL+bcY1IS6K2pCXaQdK5UOP7B3JJEhK3hSp8GN4T7fXN5FAaSYWlVBScuB5fuzJv3YzwgMXvJ/XBNdICs1VOptHR1WHdZAyR9L68POxWEc4ZSrgSKh0NHSeL3cx7lauZPqXC1KfQnhknFHhjbEsd6W1pyb9kck10a1o2GL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clJZd1JqSG1GanVUS0VpNmczRzV2WGJuTTJDQS9LeEdmYkRxQkhKcll5Wldp?=
 =?utf-8?B?Nnp6OFpoS0pxV2FURXlpOFdxcEVFaVp6dFg5MWVlVVg5eDFlSUpIYjVjNVhj?=
 =?utf-8?B?Z3NIWVNuK0I4Z0tmVEtHcld1RHBwZ2tEVGFtOTRJdDh2RHFZRGk2cDh4YzVZ?=
 =?utf-8?B?U2YxWjE2UE5sTVE3ZFJJNHVpa000NzNPbk56eE1TOUs3RTBrbjdZdkNpOG9a?=
 =?utf-8?B?UzA0bWwzcVVxUVJpV1BZazFLaEhkTVk4Ums4Ny9aWFNCbm9BNk00U0RSOG8x?=
 =?utf-8?B?eWRyaEszbkpIekFDaFBvamJZMldtVEdiTE9yTlk5VW1mVGVmOXJoTHhiVlhx?=
 =?utf-8?B?dzhldEk4WlBoYmVRWUZqUDREYmJRR2M0QXh6U04vVDR3UW0xc2h5dnBmTHJK?=
 =?utf-8?B?a3d2S2I1MUlKekt2NVhhSGZqSy9nNWRBcGxxK2RHRTRGSWtYNzVtNlIvbStK?=
 =?utf-8?B?R2hEei8vbUEvUnlPNnJneExQRFZ2NXFOTFhoTGFJK3hsaFhkdk9ucE5ndHVS?=
 =?utf-8?B?SC91T3RwTG45cnF6TXJjTWVmRnJjMXZ5YmNabitaTWNFK1ZOTXpyaVJGUG5B?=
 =?utf-8?B?QUs0VkYweTB2VlBpUVhmUExkOTI3amEvNXB1TFhydHYzZEswUUQyTEdBZkFM?=
 =?utf-8?B?YnAvZnIzd0hadXhCUkZJZjhtSndrWXAzb2RlVUlwVndtaDBtTlRsR2RSbWlM?=
 =?utf-8?B?OU5kVG1hZlNaZmdWT2daQVVUNzJ4UHNhV3NmOWJMdVphd1E5NkFnTklhNXpN?=
 =?utf-8?B?ZjMrMk94eHNaeStUZWJQaXpYY055NmVjU1lLdTNFeWUwVmJ6U2YyaVMycjJ2?=
 =?utf-8?B?M3RmeEZtSUVZNlVlbE11NnorNExsOFJTbXNsd0xzblNKMlhKVC9NSUgwOEU5?=
 =?utf-8?B?WHVyWFZiTFdicHJDbGJXVlNmK0NDWGNSY3Bid1lPK2g1MEZwTkpDN016b3Fp?=
 =?utf-8?B?aUlBbmhhQ2tqNlVVVWF4THd2akdMQXhseEtCSXZqZEo3eWN0a1FJdzVWL3cy?=
 =?utf-8?B?ZGRwWGE0YkVIM1Q4SWpOMEE3Y0RoYmg1ck0rcmRYcFk0YXRZZXQ3RTM5bk5E?=
 =?utf-8?B?bllESXJxUmh6OVRES0NQTjV4cXJFbzZIU0lrTlV3UWNlWEg4aS9oa3lDNEhD?=
 =?utf-8?B?Nk9Rc0owM1h2cVZsTDRhUjI4b0FyU3p3b3JXOG5OQU14M09RT1BQRUJsNjVM?=
 =?utf-8?B?T0pBOUVIaHpYenBONkRKMU9jRHFwOElvMkpWZDNpYWk1V1Jnd2xoY05jSjNO?=
 =?utf-8?B?NENqK2JjM3FUQ3ZrbXFYT0trV2R2MVRMTEZVQlpVV0dUUzFEa2Jpc3lobnBF?=
 =?utf-8?B?dng1elV0T2tJRDN2bE9ycGYwZ01sc0RlZTRYZSsvUU9YeXk0bFVjUG1mQUox?=
 =?utf-8?B?U0ZsRU5MUUlPNjRzbzdRUUxLa1pjN29pT25SWGtiVVdRKzRCc3hwRXdrSEN5?=
 =?utf-8?B?SlovdVRUWXk2NTBFUWdxSFBxL1VmcjdjWmZxNkZWWGtSZEFhS0NxbURxUllZ?=
 =?utf-8?B?SWttRWczbThmSkNVVGc5VDhYWkFxckpjcUhQNFJ2VnVEblUydFloY0RBV1RP?=
 =?utf-8?B?cHZuaE9XWVArZDVGaVNuWE5MeVFqRFBLNzM2MGswMytWQUFKbFppUWFHanBJ?=
 =?utf-8?B?bXV5YVZUQUt3Q3F2anFnMitDN0dXYm5jMEwrZk1UejFLalhXS3pHL1JCOUsx?=
 =?utf-8?B?amRLc0xOb1Q3RGRiZFVVMHR1MXZOMy81TWxweGNCTW5kUTNZZ3Q4bmFJL1RM?=
 =?utf-8?B?Ti9BQzJ0V2o5S0xJWVlFVlBXMUNvWGU0MS9ncHlWZTNrL1RYd1VTTFZhcmhB?=
 =?utf-8?B?Yy9SU2NIVndvRWx6czcrRzBiTnBucGZTdDZqRkVTSW52VWxMcEJKMzY1OHFI?=
 =?utf-8?B?N2hucDd1dWt3RjZqVyt0OWtMVkdhM2poRm13bk9ra0lMMnlHN0hwdnZ6cnVU?=
 =?utf-8?B?cXlnaEo1N0FjUE4xcmZ5OHcxbmVWYVhsZDRNY01NODF0WXRSS2FWVDBUcDlw?=
 =?utf-8?B?bC9yZFFscXZHYTdhM3JoWTRSRU9nZUhHdWUvRUNXTTNxaDhES1ZSeURxRFV6?=
 =?utf-8?B?VFpsWEF4OVFXckk4RzVIZytzR21NUkhnVGZEYjV1L0xBVXQ2Q0hQWGptVkNk?=
 =?utf-8?B?UGdCOWtTU3Y5N2E2ZUxHSlZyY2I3dHR4L2didzZRRlpScXlpVzJkYUpzbVBl?=
 =?utf-8?B?c3Bzalg5b2pmNy9jMWQxWGhOc2R0U3Ixb3NTNFZOK3liNmN5MFQ2TkFWZ2tH?=
 =?utf-8?B?bUxVcHFrWnBtMVh6VzN0WVQ5bUVWNWR2MVZqa3A4Wm5ILzEwKzhldWhaK2U5?=
 =?utf-8?Q?9BRmu/P7mYCqLOmVIt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56ff393-d741-4071-0b03-08deb64fa894
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:10:38.2138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PN2LVrFl6u6rQwvX0mTRF7b51fEnb7AFDGzvJyLLn09pJZfo+2bmUlVfzwFmkT4R
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
> Add ftrace events around user queue creation and destruction to profile
> queue setup and teardown latency.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 58 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 +++++
>  2 files changed, 69 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d13e64a69e25..5a01f63d1f32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -578,6 +578,64 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
>  		      __entry->value)
>  );
>  
> +DECLARE_EVENT_CLASS(amdgpu_userq_queue,
> +	    TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	    TP_ARGS(queue),
> +	    TP_STRUCT__entry(
> +			     __field(struct amdgpu_usermode_queue *, queue)

Please don't add object pointers in trace points, those are usually already invalid when the printing happens.

If you really want the kernel pointer in the trace then use void* instead.

> +			     __field(u64, doorbell_index)
> +			     __field(int, queue_type)
> +			     __field(int, state)
> +			     __field(u32, xcp_id)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->queue = queue;
> +			   __entry->doorbell_index = queue ? queue->doorbell_index : 0;
> +			   __entry->queue_type = queue ? queue->queue_type : -1;
> +			   __entry->state = queue ? queue->state : -1;
> +			   __entry->xcp_id = queue ? queue->xcp_id : 0;

The queue is a mandatory parameter, please remove all the NULL checks.

> +			   ),
> +	    TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u",
> +		      __entry->queue, __entry->doorbell_index,
> +		      __entry->queue_type, __entry->state, __entry->xcp_id)
> +);
> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_create_start,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	     TP_ARGS(queue));
> +DEFINE_EVENT(amdgpu_userq_queue, amdgpu_userq_destroy_start,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	     TP_ARGS(queue));
> +DECLARE_EVENT_CLASS(amdgpu_userq_queue_result,
> +	    TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	    TP_ARGS(queue, result),
> +	    TP_STRUCT__entry(
> +			     __field(struct amdgpu_usermode_queue *, queue)

Dito.

> +			     __field(u64, doorbell_index)
> +			     __field(int, queue_type)
> +			     __field(int, state)
> +			     __field(u32, xcp_id)
> +			     __field(int, result)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->queue = queue;
> +			   __entry->doorbell_index = queue ? queue->doorbell_index : 0;
> +			   __entry->queue_type = queue ? queue->queue_type : -1;
> +			   __entry->state = queue ? queue->state : -1;
> +			   __entry->xcp_id = queue ? queue->xcp_id : 0;

Dito.

> +			   __entry->result = result;
> +			   ),
> +	    TP_printk("queue=%p, doorbell=%llu, type=%d, state=%d, xcp_id=%u, result=%d",
> +		      __entry->queue, __entry->doorbell_index,
> +		      __entry->queue_type, __entry->state,
> +		      __entry->xcp_id, __entry->result)
> +);
> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_create_end,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	     TP_ARGS(queue, result));
> +DEFINE_EVENT(amdgpu_userq_queue_result, amdgpu_userq_destroy_end,
> +	     TP_PROTO(struct amdgpu_usermode_queue *queue, int result),
> +	     TP_ARGS(queue, result));
> +
>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
>  #endif
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3bfb9ae2cb3a..e27f9a76f986 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -33,6 +33,7 @@
>  #include "amdgpu_userq.h"
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_trace.h"
>  
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
> @@ -613,6 +614,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  
>  	int r = 0;
>  
> +	trace_amdgpu_userq_destroy_start(queue);
> +
>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
>  
>  	/* Cancel any pending hang detection work and cleanup */
> @@ -621,6 +624,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	r = amdgpu_bo_reserve(vm->root.bo, false);

>  	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to reserve root bo during userqueue destroy\n");
> +		trace_amdgpu_userq_destroy_end(queue, r);
>  		return r;
>  	}

That error handling should be removed.

>  	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> @@ -646,6 +650,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	amdgpu_bo_unpin(queue->wptr_obj.obj);
>  	amdgpu_bo_unreserve(queue->wptr_obj.obj);
>  	amdgpu_bo_unref(&queue->wptr_obj.obj);
> +	trace_amdgpu_userq_destroy_end(queue, r);
>  	kfree(queue);
>  
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -748,6 +753,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	INIT_DELAYED_WORK(&queue->hang_detect_work,
>  			  amdgpu_userq_hang_detect_work);
>  
> +	trace_amdgpu_userq_create_start(queue);
>  	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>  	if (r)
>  		goto free_queue;
> @@ -807,6 +813,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		r = amdgpu_userq_map_helper(queue);
>  		if (r) {
>  			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> +			trace_amdgpu_userq_create_end(queue, r);
>  			mutex_unlock(&uq_mgr->userq_mutex);
>  			goto erase_doorbell;
>  		}
> @@ -823,11 +830,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  		 * This drops the last reference which should take care of
>  		 * all cleanup.
>  		 */
> +		trace_amdgpu_userq_create_end(queue, r);
>  		amdgpu_userq_put(queue);
>  		return r;
>  	}
>  
>  	amdgpu_debugfs_userq_init(filp, queue, qid);
> +	trace_amdgpu_userq_create_end(queue, 0);
>  	args->out.queue_id = qid;
>  	return 0;
>  
> @@ -847,6 +856,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  free_fence_drv:
>  	amdgpu_userq_fence_driver_free(queue);
>  free_queue:
> +	if (queue)

Please remove the NULL check.

Regards,
Christian.

> +		trace_amdgpu_userq_create_end(queue, r);
>  	kfree(queue);
>  err_pm_runtime:
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);

