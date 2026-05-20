Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CFDCD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 12:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9110410E607;
	Wed, 20 May 2026 12:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tz+j6BkF";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC85310EBE2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 12:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdCjtc4hO8/GxcK/VfK2+q/1eDZtEx3siUGPMzum+IY47IhwhCKHSuHhHPN8hc+F87ZYieXHRskiU4uiq1mIqTqJowi4UMmPLafKXSKcoDL72u8qWBE6/MHp8OS/ljrUltqtFbcOi/5Qbj+NbMHPX4y388oNl2ms3IiBxJrHtL3UvVPLtmB5ZF3KY7PIGFnTAp0YeqXScX7/AeONI+hxqj86bouPBP2URI/0wHVPTR2v+cMtgkqFDhXhv4/TkIoiCa5T3X0haJ6y5caffOhoUjqwywqipRlojx9nn1n4/zyKUFUkHWhVH8IIH1NsOf1fFQDkx2R+A0PxDT7RsRgKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkYYR02s2HG0mlYSIulYx+Sq4+m6d2JjmHQ9u6480lM=;
 b=VsaH2fnOvQNh4oUx5zthxUQzug8YI+0TpG6M9p4I2tdD/eFiU7dHzGJrLLDuurQeHzmh3M+9WvQN9liuyF2RcjwQKu0O16u7TkKzoiEzp8NbV5hbv74NBN9ufjC9n/awQf1TeV7CVbNhztMBQ1rCmmEowvimZ/hJBwbuUMuEEo1NcxOheGlSfSHLJ5z1OydgbIgaoMr0mqA+i/jIpvTGwiWm+1BKA1B0IgzsWyVlSn8r3HKc/mbkYjyK7c6wWUuLSbnDMIkIxZZpwhXsshsy0o06XW81c1lXkkvN1+rEHks5JKxeSPobhF1iJd8Gk3P+8ipxpScFrkIn5gugQtpNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkYYR02s2HG0mlYSIulYx+Sq4+m6d2JjmHQ9u6480lM=;
 b=tz+j6BkFCle4yEXOlNcl2BM6cHE+NeZsIkF4CMkeVZgf9c5agT5e9iKo86/zTu09OHQMAQ2kiwnQBdA/fo0/wI2TYxXkp7uBH4Vw8ASlwD+P2ocffzElnGbueoDP5WCOS8avT6thoV/07vZ781Nk0PfSu08BnDiV+5SQ1mM5vuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 12:33:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 12:33:45 +0000
Message-ID: <601a912f-29fe-4dc4-9773-2430e7528084@amd.com>
Date: Wed, 20 May 2026 14:33:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: add userq job and state transition trace
 events
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, pierre-eric.pelloux-prayer@amd.com
References: <20260520063859.15914-1-Prike.Liang@amd.com>
 <20260520063859.15914-3-Prike.Liang@amd.com>
 <15b6482a-e102-430f-ad91-36d1024766df@amd.com>
 <53182667-ec08-4c88-a191-53b526b8a457@damsy.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <53182667-ec08-4c88-a191-53b526b8a457@damsy.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LV3P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: a62f2b68-d66c-44e8-9f0f-08deb66c0887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4143699003|11063799006|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: SLiTQX9ex4f3UDMnUY0J2zpqagVSQSidDIpa7AIuEADZ1YmbFTYqwc4jfoh+jG/i/zcSzFpTbCZBxdN8DE5uJkRF34q8DAKHlG3HxsT5pBvAvgnZXU4dMHvVmaQEfokv69YT4OpyE3UwFcID1ofjo1i4vRCgrKcfp2s9cS24UQ5c3TPPNQI4KBZcMlP7pqs5/RYE/kLupVxASpi+LcB0jGqgBXyXEV+VDUyblC7AXJxhITE/bE8sL2pQ60NVJSPEy+VKsyxyRXYHNXnlNRXEDa64WZbuKYjhg8Tv34kWhwdnzVjJbvuBW1X25hflEuGvrlnCuiorkyDLbWQGK9yPac+Un3CdpnYoaZWgHMyHnd87pq25owtrO3ryD2u+0K/fNe3NdKWCmh2U+mrPWTiemV03/ouVSZFeuEBsFEHUIw2FFWB7K9w3z+0FJIJSssaJb4wGg9GvHIyNyuArN1PUVjDJCcn7PjhEY5bvgWpy4QiviCv6ybGLO1fd8q4S3uCwYYrBmtgKhmO4C7TWwu+6GiuD6AFznoiKgzhDDTEWl/eVGUhix0bDiAZ2OwVz/5QcMvXIJlI0/h+Zfnrc+9y1BQavUK9BFFegaIYZsj0igXmoSkWtLInP7+elnrNal9mInO3mPF9OBFAEjbCYXAZ2QVKpm0CqfvrOQA/rLMrgWnMtjWNYvFUA17aAVbrPe+AC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(11063799006)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGo3MVlqRUFvc2ZhVnRyU2RzdDNWSVA4eEp4M3lMbkZMMCs2bWpINCtCblNF?=
 =?utf-8?B?Q1VlMFpRMFdRV0duTGJ1eE44YXNZVHNvRnpjblVHalBKVmJLWEhYUXhaQS8x?=
 =?utf-8?B?bHJvWk9qMmM3Wm1QSkQ0RzVVNHFLd1piTkZmNGVYQWEyM0NkM2RZZjlySE8y?=
 =?utf-8?B?Ulo2OVd2UDBDTG1qL0lFM3JoaTlWZDNJVzM3Zk5LczBQNDVNNTRDbWFmN1kx?=
 =?utf-8?B?RVliL0NFUmtBRURabU1UWjArazk4dVRmVEJSUXNJeWFHbzQxVWpxUXIrclRr?=
 =?utf-8?B?SjdvR1NQZ2Z0RjN6bUVrTDFRTTNDOVNrVmtsM1BieGI5SkZRZU9mM1NIRzhC?=
 =?utf-8?B?U1hTNnhDcjdEV2ZaLzZ5YnpIU3hwaE5jMllHWmZmMHBOSkxVWWlramJSTkxy?=
 =?utf-8?B?YjFOMmwzNFpNVXpJMnptNHB4RXVhOE9waG16SmpRNVFWd2lNb1g5TWJqcTRp?=
 =?utf-8?B?M3BIODRrUDZIVWxnWFZSUlZNakhyaVMzaWQyOUhtdkJHQTJWN3lMVnAzVDRL?=
 =?utf-8?B?ZENXcmx3bE9FdWRTS0hKZE93bkFqME0xRUF1ODdJb0xxYU1zc3BUdFRFbkk2?=
 =?utf-8?B?bXRkR2RNcHUrWjdsd3pGc2E3elVzVUxHeUY0ek5DRVJtMFF1bEw0a2NnQVdz?=
 =?utf-8?B?eTUxaWhJWnUrK2hES2gyQ2cxU3ByYVpQb1FkTkZsNGQrVU9WenFKYy8vUzNM?=
 =?utf-8?B?TVBVbmpYY0cvZlZMRlVlNDlCcVJMWHA4d3VIYUJjRGtMekpNNGpIcGVnSSta?=
 =?utf-8?B?ajJiNEs0Y3lRMFJCd3pEa3ladVBtNHUxMHZSMzNqazRSbW8ySVdBb0J2UWNo?=
 =?utf-8?B?UjQvVDJyTEIvWk90UHpOZTBia3Q4OXVnT0JKV1RkMnJsazhSOXJQbDdpaXdt?=
 =?utf-8?B?aDlZWWliZ3BlenYrQmhPVHFKTkVJNzNXOGoyMER6L2pRb3J6cmlMSWRQMEFj?=
 =?utf-8?B?R2xmcjdPbm5IY1hRMmE1ZGJYa1NCNDFUNlNibXJyQk51ZW1FeXptQU5yaVdz?=
 =?utf-8?B?cHp0ZnlMMnNPMmNHQ0F5bzM1U1NOMW91eFpyOFVnNHNkak05dUtZR2JIMmJj?=
 =?utf-8?B?MkpncThHcmVmdCtqWkE5Y1NCZkNseHFXdHhtTXlwUlpzVFNVeFV1NXNqbG5l?=
 =?utf-8?B?RXI3aHZYVHd1U2Npc0FhdkZkcGhyTWVQb3RNNjg3eTV6c3U3cyswMVY3M08z?=
 =?utf-8?B?QXdqZm5UelFMRGRMb0twL0hpZUtOMXpiWHQybGZ2QXczc1k0WG1Mb1Zabm8y?=
 =?utf-8?B?eGVDc284RE04M1hhM1lySTVLRHUvWjdOVzRwMXZpSkdFSCtyRVB1TGpJSmRU?=
 =?utf-8?B?akd1ZjJzbWZkajhQZ09rbEpKbzBFaTJ3cVRXcVdIRklyUUd2cG44Nm9rSi83?=
 =?utf-8?B?cUtyQ2pielNCYUltKzJxOC9WNDhoWithQ3p3bzZyOU9adjBUL1p6bmI1VmI5?=
 =?utf-8?B?TTdmSnEvZzhlL205ZmVnYWU3Zmg4NjMzNWh5cDhuaHAzUEdDZnFCKy93dy9J?=
 =?utf-8?B?MlpodFJrelRrQS8vTU4rRWpoL2pHZ080bGp0QnIzK050eitKdHBacFBaL05U?=
 =?utf-8?B?dUp2aGdNRlFseHhFMnNVbDNOWWh0bHllWmFVQWlNSE5NT0Q4Ky9BaFhoUmhO?=
 =?utf-8?B?eGUxVzkvNkJzRm5PV1h6UGpLRG81c0ROeC9QdER4SXFIcitwQkJMVjZYb1NR?=
 =?utf-8?B?dk1GanJFQzNCSFVRck01ZVZOUFN3Qm1xOG9OUmtXVXRwUDJGcExhWmdDQW5Z?=
 =?utf-8?B?bmxkUUlId1RBZVBTLzRQUkVqL0xzUUZwcFhBQy9rM0VJdys1Nk83a0dLcTBE?=
 =?utf-8?B?bUl6eWpTTHR6Q05ZSkRMODVFdVI0U25BVEhielR5YURvSngxcVJicU92bklG?=
 =?utf-8?B?dFQwdTVCRjkzT3JLeXY0ck85Z1lsY1ZmazBJQmpKY25hOFVRYVI5R0xieDdK?=
 =?utf-8?B?dldaTyt0UVJpQ3FwaWN6SngrNjFRZGpNbmhyc3IxaHdxa0hDUHJqUjZNZzJH?=
 =?utf-8?B?OXZSNUlLWVNEQXpoekNUWWxVQjR3ZGg1MEllM0hFOFpiOU96YnJ5bWRNbkti?=
 =?utf-8?B?WDJUQmE1Nmdjbk9oQWFIdGVDdmRwZEpSMGVpaWkweUlMQllrSVNveXptU1hw?=
 =?utf-8?B?bU1jRHJ6Tnl4Q202aU9zNFhVek4yalVGa0JqMk9ZMjd2eHgyYWpGNDh3WXRU?=
 =?utf-8?B?anppWHJPa3U0REU2NmJ2QkxUWmpjZVl1eGVYTVgvRmFTU3MzWDFJVzQ3SUVm?=
 =?utf-8?B?d24xMnp2Y3FpbkdkclRUZXBRM2hvZE56VnFCdmdvL0xUTEFIK0F1amNDekla?=
 =?utf-8?Q?dA0tOvWrlvKQ/F/VeG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62f2b68-d66c-44e8-9f0f-08deb66c0887
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 12:33:45.1076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmQX6a2EzU/ouuuxeRlvq9sAQ+lYBrsXv4/HpWkfupSyf0YkQge1umnChTtp89IM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218
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

On 5/20/26 14:25, Pierre-Eric Pelloux-Prayer wrote:
> 
> 
> Le 20/05/2026 à 11:14, Christian König a écrit :
>> On 5/20/26 08:38, Prike Liang wrote:
>>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>
>>> Add ftrace events for tracking the userq fence emit, signal
>>> and queue state transition.
>>
>> The queue trace points look good to me, but clear NAK to the fence trace points those just duplicates the common trace points in the dma_fence framework.
> 
> The dma_fence trace points don't contain enough context to be usable from a tool (no device, no client id at the very least).
> 
> The userqueue events are based on the gpu_scheduler traces and are what is required for UMR to implement its Activity view.

In that case we should change umr to use the fence context instead of the client id and/or put the client/doorbell in the fence descripton. That's what this is good for.

Creating new trace points to track userqueue usage and not using the standard dma_fence onces is an absolutely clear NO-GO from my side, do we also do that for the scheduler?

Regards,
Christian.

> 
> Pierre-Eric
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 129 ++++++++++++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 +++
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  13 +-
>>>   3 files changed, 160 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> index 4ff8a4d7bb8b..32d8c36caaf3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>> @@ -28,6 +28,8 @@
>>>   #include <linux/types.h>
>>>   #include <linux/tracepoint.h>
>>>   +#include "amdgpu_userq_fence.h"
>>> +
>>>   #undef TRACE_SYSTEM
>>>   #define TRACE_SYSTEM amdgpu
>>>   #define TRACE_INCLUDE_FILE amdgpu_trace
>>> @@ -659,6 +661,133 @@ DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_enable_sig
>>>   DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_signal,
>>>           TP_PROTO(u64 context, u64 seqno),
>>>           TP_ARGS(context, seqno));
>>> +TRACE_EVENT(amdgpu_userq_job_run,
>>> +        TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *fence),
>>> +        TP_ARGS(device, queue, fence),
>>> +        TP_STRUCT__entry(
>>> +                 __field(u64, fence_context)
>>> +                 __field(u64, fence_seqno)
>>> +                 __string(dev, dev_name(device))
>>> +                 __field(u64, doorbell_index)
>>> +                 __field(u64, client_id)
>>> +                 __field(u32, queue_type)
>>> +                 ),
>>> +        TP_fast_assign(
>>> +               __entry->fence_context = fence->base.context;
>>> +               __entry->fence_seqno = fence->base.seqno;
>>> +               __assign_str(dev);
>>> +               __entry->doorbell_index = queue->doorbell_index;
>>> +               __entry->client_id = queue->userq_mgr->file->client_id;
>>> +               __entry->queue_type = queue->queue_type;
>>> +               ),
>>> +        TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, fence=%llu:%llu",
>>> +              __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index,
>>> +              __entry->fence_context,
>>> +              __entry->fence_seqno)
>>> +);
>>> +
>>> +TRACE_EVENT(amdgpu_userq_job_done,
>>> +        TP_PROTO(struct amdgpu_userq_fence *fence),
>>> +        TP_ARGS(fence),
>>> +        TP_STRUCT__entry(
>>> +                 __field(u64, fence_context)
>>> +                 __field(u64, fence_seqno)
>>> +                 ),
>>> +        TP_fast_assign(
>>> +               __entry->fence_context = fence->base.context;
>>> +               __entry->fence_seqno = fence->base.seqno;
>>> +               ),
>>> +        TP_printk("fence=%llu:%llu",
>>> +              __entry->fence_context,
>>> +              __entry->fence_seqno)
>>> +);
>>> +
>>> +TRACE_EVENT(amdgpu_userq_job_queue,
>>> +        TP_PROTO(struct device *device,
>>> +             struct amdgpu_usermode_queue *queue),
>>> +        TP_ARGS(device, queue),
>>> +        TP_STRUCT__entry(__field(u64, context)
>>> +                 __string(dev, dev_name(device))
>>> +                 __field(u64, doorbell_index)
>>> +                 __field(u64, client_id)
>>> +                 __field(u32, queue_type)
>>> +                 ),
>>> +        TP_fast_assign(__assign_str(dev);
>>> +               __entry->doorbell_index = queue->doorbell_index;
>>> +               __entry->queue_type = queue->queue_type;
>>> +               __entry->client_id = queue->userq_mgr->file->client_id;
>>> +               __entry->context = queue->fence_drv->context;
>>> +              ),
>>> +        TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu",
>>> +              __get_str(dev), __entry->client_id, __entry->queue_type,
>>> +              __entry->doorbell_index, __entry->context)
>>> +);
>>> +
>>> +TRACE_EVENT(amdgpu_userq_job_add_dep,
>>> +        TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *dep),
>>> +        TP_ARGS(device, queue, dep),
>>> +        TP_STRUCT__entry(
>>> +                 __field(u64, context)
>>> +                 __field(u64, dep_context)
>>> +                 __field(u64, dep_seqno)
>>> +                 __string(dev, dev_name(device))
>>> +                 __field(u64, doorbell_index)
>>> +                 __field(u64, client_id)
>>> +                 __field(u32, queue_type)
>>> +                 ),
>>> +        TP_fast_assign(
>>> +               __assign_str(dev);
>>> +               __entry->doorbell_index = queue->doorbell_index;
>>> +               __entry->queue_type = queue->queue_type;
>>> +               __entry->client_id = queue->userq_mgr->file->client_id;
>>> +               __entry->context = queue->fence_drv->context;
>>> +               __entry->dep_context = dep->base.context;
>>> +               __entry->dep_seqno = dep->base.seqno;
>>> +               ),
>>> +        TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu depends on fence=%llu:%llu",
>>> +              __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->context,
>>> +              __entry->dep_context,
>>> +              __entry->dep_seqno)
>>> +);
>>> +
>>> +TRACE_EVENT(amdgpu_userq_state_start,
>>> +        TP_PROTO(struct amdgpu_usermode_queue *queue),
>>> +        TP_ARGS(queue),
>>> +        TP_STRUCT__entry(
>>> +                 __field(u64, doorbell_index)
>>> +                 __field(u64, client_id)
>>> +                 __field(u32, queue_type)
>>> +                 __field(u32, from)
>>> +                 ),
>>> +        TP_fast_assign(
>>> +               __entry->doorbell_index = queue->doorbell_index;
>>> +               __entry->queue_type = queue->queue_type;
>>> +               __entry->client_id = queue->userq_mgr->file->client_id;
>>> +               __entry->from = queue->state;
>>> +               ),
>>> +        TP_printk("client_id=%llu, type=%u, doorbell=%llu, from=%d",
>>> +              __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->from)
>>> +);
>>> +
>>> +TRACE_EVENT(amdgpu_userq_state_changed,
>>> +        TP_PROTO(struct amdgpu_usermode_queue *queue, enum amdgpu_userq_state new_state),
>>> +        TP_ARGS(queue, new_state),
>>> +        TP_STRUCT__entry(
>>> +                 __field(u64, doorbell_index)
>>> +                 __field(u64, client_id)
>>> +                 __field(u32, queue_type)
>>> +                 __field(u32, to)
>>> +                 ),
>>> +        TP_fast_assign(
>>> +               __entry->doorbell_index = queue->doorbell_index;
>>> +               __entry->queue_type = queue->queue_type;
>>> +               __entry->client_id = queue->userq_mgr->file->client_id;
>>> +               __entry->to = new_state;
>>> +               ),
>>> +        TP_printk("client_id=%llu, type=%u, doorbell=%llu, to=%d",
>>> +              __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
>>> +);
>>> +
>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>   #endif
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index e27f9a76f986..60d1186af286 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -329,11 +329,15 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
>>>       int r;
>>>         if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>>> +        trace_amdgpu_userq_state_start(queue);
>>> +
>>>           r = userq_funcs->preempt(queue);
>>>           if (r) {
>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>>               queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>               return r;
>>>           } else {
>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_PREEMPTED);
>>>               queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
>>>           }
>>>       }
>>> @@ -349,10 +353,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
>>>       int r = 0;
>>>         if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
>>> +        trace_amdgpu_userq_state_start(queue);
>>> +
>>>           r = userq_funcs->restore(queue);
>>>           if (r) {
>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>>               queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>           } else {
>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>>>               queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>>           }
>>>       }
>>> @@ -370,12 +378,15 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
>>>         if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
>>>           (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
>>> +        trace_amdgpu_userq_state_start(queue);
>>>             r = userq_funcs->unmap(queue);
>>>           if (r) {
>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>>               queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>               return r;
>>>           } else {
>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
>>>               queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
>>>           }
>>>       }
>>> @@ -392,11 +403,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
>>>       int r;
>>>         if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
>>> +        trace_amdgpu_userq_state_start(queue);
>>> +
>>>           r = userq_funcs->map(queue);
>>>           if (r) {
>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>>               queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>               return r;
>>>           } else {
>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>>>               queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>>           }
>>>       }
>>> @@ -1007,6 +1022,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>           if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>>>               drm_file_err(uq_mgr->file,
>>>                        "trying restore queue without va mapping\n");
>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
>>>               queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>>>               continue;
>>>           }
>>> @@ -1502,12 +1518,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
>>>           if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
>>>               continue;
>>>   +        trace_amdgpu_userq_state_start(queue);
>>>           userq_funcs = adev->userq_funcs[queue->queue_type];
>>>           userq_funcs->unmap(queue);
>>>           /* just mark all queues as hung at this point.
>>>            * if unmap succeeds, we could map again
>>>            * in amdgpu_userq_post_reset() if vram is not lost
>>>            */
>>> +        trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>>           queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>           amdgpu_userq_fence_driver_force_completion(queue);
>>>       }
>>> @@ -1526,6 +1544,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>>>         xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>>           if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
>>> +            trace_amdgpu_userq_state_start(queue);
>>> +
>>>               userq_funcs = adev->userq_funcs[queue->queue_type];
>>>               /* Re-map queue */
>>>               r = userq_funcs->map(queue);
>>> @@ -1533,6 +1553,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>>>                   dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
>>>                   continue;
>>>               }
>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>>>               queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>>           }
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 008330a0d852..00cc7194321c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -30,7 +30,7 @@
>>>   #include <drm/drm_syncobj.h>
>>>     #include "amdgpu.h"
>>> -#include "amdgpu_userq_fence.h"
>>> +#include "amdgpu_trace.h"
>>>     #define AMDGPU_USERQ_MAX_HANDLES    (1U << 16)
>>>   @@ -169,6 +169,7 @@ amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>>>           fence = &userq_fence->base;
>>>           list_del_init(&userq_fence->link);
>>>           dma_fence_signal(fence);
>>> +        trace_amdgpu_userq_job_done(userq_fence);
>>>           /* Drop fence_drv_array outside fence_list_lock
>>>            * to avoid the recursion lock.
>>>            */
>>> @@ -528,6 +529,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>       /* Create the new fence */
>>>       amdgpu_userq_fence_init(queue, fence, wptr);
>>>   +    trace_amdgpu_userq_job_run(dev->dev, queue, fence);
>>> +
>>>       mutex_unlock(&userq_mgr->userq_mutex);
>>>         /*
>>> @@ -701,7 +704,7 @@ amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
>>>   }
>>>     static int
>>> -amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>> +amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *filp,
>>>                       struct drm_amdgpu_userq_wait *wait_info,
>>>                       u32 *syncobj_handles, u32 *timeline_points,
>>>                       u32 *timeline_handles,
>>> @@ -835,6 +838,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>           goto free_fences;
>>>       }
>>>   +    trace_amdgpu_userq_job_queue(dev->dev, waitq);
>>> +
>>>       for (i = 0, cnt = 0; i < num_fences; i++) {
>>>           struct amdgpu_userq_fence_driver *fence_drv;
>>>           struct amdgpu_userq_fence *userq_fence;
>>> @@ -869,6 +874,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>             amdgpu_userq_fence_driver_get(fence_drv);
>>>   +        trace_amdgpu_userq_job_add_dep(dev->dev, waitq, userq_fence);
>>> +
>>>           /* Store drm syncobj's gpu va address and value */
>>>           fence_info[cnt].va = fence_drv->va;
>>>           fence_info[cnt].value = fences[i]->seqno;
>>> @@ -968,7 +975,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>                              gobj_write,
>>>                              gobj_read);
>>>       } else {
>>> -        r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
>>> +        r = amdgpu_userq_wait_return_fence_info(dev, filp, wait_info,
>>>                               syncobj_handles,
>>>                               timeline_points,
>>>                               timeline_handles,

