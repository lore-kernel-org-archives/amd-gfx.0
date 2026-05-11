Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D273CD484A
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 13:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B555910E771;
	Mon, 11 May 2026 13:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tjAt5D1M";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011004.outbound.protection.outlook.com
 [40.93.194.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC7110E771
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 13:57:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ngo9Ghr9SYWKThTHyLrj80TLdqRcrICpOqZH9EhYfZER2yHuXB5HmgM4qTos5YU6pAAt/2plbh02/ZLZ/y3CQEnazUjJiLJERWrDHT0RApN3AnR5WeA5ylMseIiMIaMyQ7DXDu0jcUhB+GUC4NCyKrwSY62BSvhZ6AgriunWFS7PxXeS302HXUasxLT4zPC2iLEfcVjmch4TGPsJQeFPIWdGGF0q+nSP6TeLEDf7qZJOTKVUbrkQeB+ny6UE+y26vHR1FszSmChgD//WkNw6dZhV5zPjfWETTSunyaFyxZ4jtOhdtzaWQQ/CXDS7283j7hbdIPyWlY6uT7RZ6viQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmopSIgfkN0KxWlzGRs/jXk3mvosZXDeHCrqKsfBm4M=;
 b=ZZL34it2rVxg4YShErAiv7Hsj3/0G5tdVlZ2qE44RIWQqY7Z3Z5wN0QWOvwdpU0Bju5utz4HBGxBThordO6zYuJQQrqBX7B9eW/jhzM3DdValKILj1RvD4hv1VxetULcHIGezvBfPwWJorVnaZLuZj2QDHsFC8f0zL8ELSMjd08xia6O73zz4La8AT9NF6ylNcUjGrGFX4GWdPAD3jzUj842dnmPwIr5hUPfFgWopgmyzVCJnzw1tmOrhmUVmOSyrPrPJxUriGYXC6GhtlL7KvMEKFW7Zj9UnsG2Lc5NMAdsjXpWZpTyc3WcQZoz3lPf1Lfta39ZIPlRAZIvPmdlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmopSIgfkN0KxWlzGRs/jXk3mvosZXDeHCrqKsfBm4M=;
 b=tjAt5D1MYCR2m6u88Do24Gx1b8I3XAShhWFmvWatMEjQMg5yiUHDPiq5fpJi9RgqOFFiH8miGLMmlU7wq+zzNIUAD7kzYMSNJBKfjuzbSRzzMDoanQ3itc6yYYne1HU6k1pe+xjsvZZQ4hhGX85T3BHTGimpsTnpz428Shb09Kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 11 May
 2026 13:57:21 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:57:21 +0000
Message-ID: <c4c71c7d-01f0-4249-9f8b-c10662f16b64@amd.com>
Date: Mon, 11 May 2026 19:27:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: add userq create and destroy tracepoints
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 "Pelloux-prayer, Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>
References: <20260511135435.3818345-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260511135435.3818345-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0170.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::7) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf58da6-e81b-4341-67cb-08deaf653877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6y6MQW1GYigDbWdr6XhFNPTbdyQ6u20/7oqMIIBSCrDX42BR5zc0ulPYFXrqjWBQK46U9ACQZ3Tm36Nf5KM1r+hWYXA9TfLVUhSeRdWHgRjCe4ubXAhg6a8AnFZ+bk6r9yVxxURvJCIjfNdfQNKL6MWXcUtXrqrYc/GeMFKOhSNziwhqVO9G1/yqvpJO18KcXItBdibi5a6eGcHIDhFsy/CpA4xsr3DBvXyagxNHc6j1KAGehkp2uQLSXHre0aLuu6gQqsINefiEg9HOLUUK63WeKtPu7XgzU147ZK2rkvP2Le3VESXRzdzuVL116b11XskfZNVym/Qke1beN6fzA1bvYpFFGwqoKYQUhcxYGEfwzMuL7AFWUd1R29mV+qSbehdnW2DCHhV2I/OF7/nKE4bpiBYkqVlxVPplrjY85fhfq9nk+CkWotGpccjEDSu4JQj+Kn9GZ4PU3nJr3H4sRhDPDBeb93cJkJvlqzfAUyqGYTp+ErhihdBKhqmiaT4yyWYiDomA67th27ZZ6mPTsbO+j3oC+TuTVo/crhueJiHE+ruRfCOF7hGvcVncMTsgp1nRjxBqrMLTd5zeyyFYGQpGC9rYUzHqdwEZ1fmn+8KgIg/OHZjC908mhngeBQ2jX21nN7vzDkOI0fq/3bi0zGu1cmT8sH0PalwdoYIYWJZvMGImaJKdwxBI7L1sjL+Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1lQVmZ6VnlRekxtM3JqdGRjTUVJU2h1QkM3YWZqSW1TVjd2azFtNFhKaHpr?=
 =?utf-8?B?TkF0UmcvNWhaNXAvYlNtb1Y2S2wwQjN1RHlqWkNSelVWQ0tzOTFYeC8vUWRP?=
 =?utf-8?B?cVV0K1czTmJnMEtwMnFEenhzTTRsLzZCNWJDSlVnR1J2c0JraFpNL3RiQXNI?=
 =?utf-8?B?TkJ3alhlU2RNTzZVOUpOK1pRbFBMa0ptclRORlYrVmhrOFIxNC96S1pkQjZz?=
 =?utf-8?B?RnVNcHJrOXVzemM0WGZsNnZ2cFJUWXhGTzRRQzIwR0I2aStqWWJmK3dzSmwz?=
 =?utf-8?B?d0tJUDJINFBSTVU0QkRLRk9KZG82cUtCWk8xYlArZENuU29EZDViTWIyNUR0?=
 =?utf-8?B?UFRYYVJtWHBYOWQ4NXAzNmVEeWQvNVlGRVd1UjNHRWRyNWNJYTlBVG1DKzJ3?=
 =?utf-8?B?Y0RnUlNUalptbzJidjV6Z2piRUJ5eTU3Y3ZMK1RnRWJ1Q2srTGl4RVJVUW9v?=
 =?utf-8?B?N1V6K1o1TDhvamxVME5hOTV5SEt4SU1SRFdtMCswL1hIc255TGEzckk2Y2hX?=
 =?utf-8?B?MktLNyt2ZFpzY0g2OWp4QW9xZVJONnIwMkN3KzFsdTJ6Q1RCdlN5NUV6a1Zk?=
 =?utf-8?B?R3ZNVkdxRFlueUZiOXhFUUc0cGJjekh2RWhha0FoL3YvL2RJelg4Z2VMb3VI?=
 =?utf-8?B?d3A4eWp5ZlpSRWpZb3hPUmZIc3BNN1Y5UjJacnB2VEJkYm93OFp0dHlGdGhs?=
 =?utf-8?B?blFzaFFTejQxeWVidyticyszODJvNytnZGRCa2pyTzQ4UUZzc1FrTVg3OGJZ?=
 =?utf-8?B?V3U4bEtjVUZ6WmZyVHA4RWczeFFkeTVqY2V3RWc2emNPNWUxYmh1bHUwWG5l?=
 =?utf-8?B?cXJFNUZqVS9nZnB0WEJQV1ZWYkU0MWM4K3NxejgwYlNTUFEwSXVLNkRPMCtX?=
 =?utf-8?B?RzFzUW02SHdSYURsUWpDaVZnSXgyd3dHZU5wajRRL0hBd2g5WlNiZGFOUVRo?=
 =?utf-8?B?bWlGeGZGZnpnVmNZclRVK3FLanhjamhKZWhsUFYzRC85YW9sNW5UeTJ1aU1D?=
 =?utf-8?B?clJPMWVmMFArRkVtaU5Pd0Zpa2pDalhQcXRWZTBTVytodmRVZ2xMS2VleGZo?=
 =?utf-8?B?ejNOZVZQaUFRN1kyQU9FQlVuOUpzeGlOVk1USE9XcmFnN2hwV3ZOMy95MEVq?=
 =?utf-8?B?N3llSG1zTktNMEtmcGZFRC9MOFg4dy9NRHRFSUR6TFlRVjU4c2J0RmNYTXNo?=
 =?utf-8?B?K3FHSjJNVzlvWDVNMTJFUTdhYS8rWXJkTTN1R0JLVDFrWmtIWFlTbUhVSkE2?=
 =?utf-8?B?blgzWmh3MUlGd25wK2ptVWgxZHpsSVkzR052RzVsTVNydXlReWR6WTFGUWpN?=
 =?utf-8?B?R1J6ekJScWlGMVhOdmF2MGkySGxIeG1kWUVzQkloQXZJbWorRjFTMHdMRUhs?=
 =?utf-8?B?ZnZRZHNyR1AwdG1ENzgrVGduOWJOU2tvTWgySjhmdnlxNWNnd3hianZ2VUJZ?=
 =?utf-8?B?NmRlVUxIM1gveDdUWWFWSStlaDZ1QjdzTFRESHkwMVpaTFFuZFc0cVZzSTQ5?=
 =?utf-8?B?L0I0UVg5cnNvVUw1RmUydlNtUmVMejhzRWVXVkd4WXRESzlvOFVxcld4RXlm?=
 =?utf-8?B?NTRXVEFQMFpiNFlPSVU0SDJYWHVycjNPMGwvNGRhSG9qVXkvQUxaZkgySyt6?=
 =?utf-8?B?R1RIcFFDTEF1RGpkK0JkMG5CVkdoZEhHeGFwZGRpUmlXdTdYeVdpbWlzTjFM?=
 =?utf-8?B?Q0pBcVFEN2JCMllVcWJvc1U3ZGFHejhkdXEyUUkwZzRvSGlSek9kckR5OUhx?=
 =?utf-8?B?a0VoS3J0TWg2VFBuWnpKbmFQZEs3QkxHWnBncGxqT1ZaOUVuNWY2M1JhUmlX?=
 =?utf-8?B?ZHF5bWZlcEJFMEFTcElFNXFLMjZ3YlFUOGZXNUN0QkRVY09yTzZRNGVMZnE5?=
 =?utf-8?B?RmgxTVE3ZnhuaWpKVVQ1emQ1dkhvUzBPaElIcVlRRld6R205dUF1UHJmTkFj?=
 =?utf-8?B?TnZjQ3IvWDRUeGp5MlBmelBEWlpaeHhmNllQamRDeUNvSXhOTzR5MWJiNStz?=
 =?utf-8?B?aE40eXFrUXBKMDFkbldDU0pLY3hySGY0bkw0ZzBZUXVmdytCTjIrdFhPVnhk?=
 =?utf-8?B?NEE0dHVLVTNTYUQ2eFN6MVJZbktjYkVNdjJ4SDlXci9WUVFNYXh1S0Z6S1lu?=
 =?utf-8?B?blNqRng5VGlyUThlT0FvZGhBUTJMdE9rYWM2b1FCTmVSbzUxaWxYanhLNmFv?=
 =?utf-8?B?QkJsc0VrelpLc3BPTFF4MFBEczM3V3dsNFVPYVE4VWl5SHdOUVRhUG1lRlgv?=
 =?utf-8?B?a1RidmRjSWV1TThuNzV5ejYwUE5BTzNJV3VvM0NtU3NYemJKanZUNERzNlNv?=
 =?utf-8?B?bWVDM1FEcUo4TElacVBYL2haWkJKdnkveEVZT1VWbFV5V0JqWUxTZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf58da6-e81b-4341-67cb-08deaf653877
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:57:20.9929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkEnXwbtMvvUUv8IRViEZUvQcbudf8FY1zvIo7b4L2eIEGjs2D+zCRIdDhBGC4CONazjd8iqE7s0To9WxorQdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
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

If i am not wrong Pierre eric did work on the traces for user queues. I 
have dropped my patches for the same reason but not sure if the traces 
patches are merged. Could you check with him once ?

On 11-05-2026 07:24 pm, Prike Liang wrote:
> Add ftrace events around user queue creation and destruction to profile
> queue setup and teardown latency.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 58 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 +++++
>   2 files changed, 69 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d13e64a69e25..5a01f63d1f32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -578,6 +578,64 @@ TRACE_EVENT(amdgpu_reset_reg_dumps,
>   		      __entry->value)
>   );
>   
> +DECLARE_EVENT_CLASS(amdgpu_userq_queue,
> +	    TP_PROTO(struct amdgpu_usermode_queue *queue),
> +	    TP_ARGS(queue),
> +	    TP_STRUCT__entry(
> +			     __field(struct amdgpu_usermode_queue *, queue)
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
>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3077ca4e27a0..50c46d31fbae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -33,6 +33,7 @@
>   #include "amdgpu_userq.h"
>   #include "amdgpu_hmm.h"
>   #include "amdgpu_userq_fence.h"
> +#include "amdgpu_trace.h"
>   
>   u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>   {
> @@ -617,6 +618,8 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   
>   	int r = 0;
>   
> +	trace_amdgpu_userq_destroy_start(queue);
> +
>   	cancel_delayed_work_sync(&uq_mgr->resume_work);
>   
>   	/* Cancel any pending hang detection work and cleanup */
> @@ -625,6 +628,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   	r = amdgpu_bo_reserve(vm->root.bo, false);
>   	if (r) {
>   		drm_file_err(uq_mgr->file, "Failed to reserve root bo during userqueue destroy\n");
> +		trace_amdgpu_userq_destroy_end(queue, r);
>   		return r;
>   	}
>   	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> @@ -650,6 +654,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>   	amdgpu_bo_unpin(queue->wptr_obj.obj);
>   	amdgpu_bo_unreserve(queue->wptr_obj.obj);
>   	amdgpu_bo_unref(&queue->wptr_obj.obj);
> +	trace_amdgpu_userq_destroy_end(queue, r);
>   	kfree(queue);
>   
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -754,6 +759,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   
>   	mutex_init(&queue->fence_drv_lock);
>   	xa_init_flags(&queue->fence_drv_xa, XA_FLAGS_ALLOC);
> +	trace_amdgpu_userq_create_start(queue);
>   	r = amdgpu_userq_fence_driver_alloc(adev, &queue->fence_drv);
>   	if (r)
>   		goto free_queue;
> @@ -809,6 +815,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		 * This drops the extra and last reference which should take
>   		 * care of all cleanup.
>   		 */
> +		trace_amdgpu_userq_create_end(queue, r);
>   		amdgpu_userq_put(queue);
>   		amdgpu_userq_put(queue);
>   		return r;
> @@ -826,6 +833,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		r = amdgpu_userq_map_helper(queue);
>   		if (r) {
>   			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
> +			trace_amdgpu_userq_create_end(queue, r);
>   			mutex_unlock(&uq_mgr->userq_mutex);
>   			/* Prevent racing with close */
>   			if (xa_erase(&uq_mgr->userq_xa, qid) == queue)
> @@ -839,6 +847,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
>   
>   	amdgpu_debugfs_userq_init(filp, queue, qid);
> +	trace_amdgpu_userq_create_end(queue, 0);
>   	amdgpu_userq_put(queue);
>   	args->out.queue_id = qid;
>   	return 0;
> @@ -853,6 +862,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   free_fence_drv:
>   	amdgpu_userq_fence_driver_free(queue);
>   free_queue:
> +	if (queue)
> +		trace_amdgpu_userq_create_end(queue, r);
>   	kfree(queue);
>   err_pm_runtime:
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
