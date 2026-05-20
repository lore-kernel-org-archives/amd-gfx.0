Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C42DCD4F3D
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 13:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1AC10E136;
	Wed, 20 May 2026 13:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rfh/OIl2";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C230F10E136
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 13:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cb4f9e0O2RFWA7F+BKKuEf9mso3kVUCLQgzaB8cmBsRWjrHOyeyrybbGtIbUghaUpQdGS4/XikVTUa7Xwl1SEP+mmBIgVGgkpg7gCzj0pr1F9hsAOxpNIwOqBOBZ5fiWLmesLz/PwSSNM098d6Qq1gWwo/dUNL2qJd0m41MuYLHUHIHmvt56MJW77ElIr8820OpDhnbt1ZJvEmG+XU3kDxNKCOkeFdT4SIMf2kUHWG5m26RQTq6Uy0UPwZwPlGcPZ2Tc71+M7PqeCdiZNT7FtJNaCOMRv6MhFomYt+/GA+jdOa6VS+HT7AFUETOqISZxwgIRSMOfZ1AoEoy6gebmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZFEBX7nbEJmFfV+GdT/az3AqhZDaXTg7XeUEQagVXk=;
 b=fULno1Whd/W64d4zoaiNyxY32m001Jfthk7eq9YnxGFd1mUF17cg2FbA6j0U+MuhZww1YUYePo7WR66J/9/K1XZznXmAiM40gtj4VasPVypz+TW50juuNrgKGHLMUGYFHYUJ0oY/0BCfryeZkWMLwrc1qYT4NTirm0kvXXWCCywdNXc2+7M+VsGjjTQMrTWdCy3cOY3Nja/CnTX5vxyFrfEopevo1aqmb+NXQGOASVfv/i5XUU7/dAFCmIvycaumBRJnZW0Yy2mC57nyMb3kfcP1b4MTrXk87lj2G3mYBptvxz45WPwCKkJBU+jAx838qr19MsWmeKSGoZerIV2Jow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZFEBX7nbEJmFfV+GdT/az3AqhZDaXTg7XeUEQagVXk=;
 b=rfh/OIl2QJAsoF6z+QoEP3EIEN5s7UqhN8ycutiFdhjWnrTlFRLQDJw8CTmcYgL9bWKOiQKhtnzjGess8iFi8yosdHVV9ogQyX1va5aOzidicVUW3R2TT0wBOPNIQkngMh+JDVlYSBGFOpaJcCxmfm3g+hogmKGIrfyeoRVBfXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 13:44:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 13:44:31 +0000
Message-ID: <f9f79424-5bfb-485f-b96d-a4957341f518@amd.com>
Date: Wed, 20 May 2026 15:44:26 +0200
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
 <601a912f-29fe-4dc4-9773-2430e7528084@amd.com>
 <03a1b981-f6b5-4a6c-9038-b640a3c80e40@damsy.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <03a1b981-f6b5-4a6c-9038-b640a3c80e40@damsy.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: edc1759e-ff3c-4836-87d0-08deb675eb35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: YmhKUexTeRldf3ziIUnWPe+dS/DQYwvn5IsnZgG5TiTtPHPZWggn5RXeV7CIuZdLOPovbeZk2EO4obyInUCU8lC13xBQKlSOsxXGb5UnONztFV+iA6iHeW0yln7YxbeOES7ay9MwQ6yxKEnfQ1DoQ3cpNc8txf75sYD/6vp76uBVwwzAZF4rqlhtc4EBC6tVXtGdVDQjGrcHK/FEgywgH+YWyCQp0PJ+5tweYJr5ItEEM27elwoENmkYyxYBPXbqQ+JMA+AMffY7jIJdSpHj4hpUv0jA5Vhzhc9aeI21fknGwr2Uq6r2DHQ7datD+Ukh8+DynC+ryAMTJ5oQ8IP3737p9QwBJdm+feN/ZlShyWankvx6v7BjvTAtUG6i6FQAESg6M6BX4bDpRY1BVAre7ehnOaTSkleH/p0axSijXY0+TXn8+C+ve73F//4eZkBmQHlWfERu20J1My42Rh57DI73xXES++lPoMWMpj9EOaVKFS0wnUDEBaU4d41hVa6fqMYzUbgOS2Vr1gJ2XBmeGqN39PssPC3KJZoL6yLEy1pAdmrevcHDYCgEeuSiT5vgJQ0+Q6xKIhIn5q723A9F2iyCrPVB2HEaZ/fliKRqCAztwMpnCXjATIkrlKRzi9nRFZ2q64wbRL0CWQm7ie7P8whr3vYFuM2HaGLbXnMlLHV930nGoYE2Qtn42rnTA2kA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2daWlZVVUh0RGVQeHNjZmlrSGkvbFRKZXFsZkNXVjZLc3FYa3dhMVRYbHJS?=
 =?utf-8?B?ZHU3dW9lcXVjcGJKVTJLRHJGcXJlYkMyQ1daODQwcUNQdHppcm5rVVZXNjU4?=
 =?utf-8?B?d1h3cnQ1eVhEa0NTTEl3THpTNDh4bDIycmlWM0ZUK204TkdzOXNzbWJHRWdj?=
 =?utf-8?B?OFZXM3V6dVhCbGExQk1FT2ZaaGRDNTF3Zk1WYjVMdGRmMnNDdVJBSTIxaGZO?=
 =?utf-8?B?K3RweEZPQlFmb296UWlKWFZPcnp4bThvcklWbHpvWGZHYzM0ejNLbHpYVVdv?=
 =?utf-8?B?MFpJQWs1Z0lYMjV1RkkyYVM3eEJtVVUvNnQ5U1cvSjBSby85dHU4Ykg3WlVY?=
 =?utf-8?B?SkpMVG9hdGc2OU9TR2JpSTBUNFJ2N1BsOW5MaGVoUGJnZ2dNSW03ZU9pdS8v?=
 =?utf-8?B?cXdPaGpiOHpEQ2VZbDhuWDk5eVc1cVJaWWNIK2swZVArbTVKUmVWaFZqSE84?=
 =?utf-8?B?MkYrSWZuekJZdmEydkR2eUUzYldqd1VjcDFHaU1zUkQ1UW0xZHBKbmczekth?=
 =?utf-8?B?Qitqa2VWNy8wN21HVDN6d20wUHBiaWgzTFFHWWwwZWc3WVVlUkZRbEZONGFS?=
 =?utf-8?B?RVd4UzJsNkVESVUxaEorV2ZJSDlrOFQzMjI1VTdkeXBhc29OYnd4b2FLb1pO?=
 =?utf-8?B?ZWxpaUgvWmlJYVRUVHFObkVFWWZYVkdMcUVsREtHRTRQNWVSWUkxU00xcWxi?=
 =?utf-8?B?cXd6VS9kTklxQ2s2aVpPekFxQmhNTnhWZk1pcVpJT28zWjdTR0ZIS0FFcE1I?=
 =?utf-8?B?cE52ZmFKdW1jMGJDTGM0aU5VRFZYUElGd3Z1dmxzRHpON09xYTdnOFAyUHR2?=
 =?utf-8?B?QXpmWG1nb1h4c2RYb0VMU3RNSUtkZUpPbVltREQxNnEzb0o4YnEveXlHVmJr?=
 =?utf-8?B?NVlpRG9YbjhPN2FFTlNGSXZMc2JBK3hEazBreFl2WFFUeVR2c294WksrTjZq?=
 =?utf-8?B?RGJ0Yk4xaGRIOHVYVFB6RXM1enkrN25hZ3p5Tk9MbjZod3Nxc1NDa0J6cFRa?=
 =?utf-8?B?K1IwQWxYNzlyUCttWWVURTU0bm1rYUxEYXVwSk96a0dpWWhpZ3RreE5qd1dm?=
 =?utf-8?B?ZEtkamlaYmVka2xHQk1TOVZIejZ3ck90ZURBWFowWlRsTlR6Y2VzaWFXZ0xR?=
 =?utf-8?B?cjB1YnZ5RUJCUEVJNUc5RHd3REpVQXhnQ3d3NmNsRlVLVHVwNVJaaUFsNGFY?=
 =?utf-8?B?cllRLzYxYUlReXBSZGRJMk9hSUZJK01FL0xjdW9yV254b055a0J6TXpkVWR6?=
 =?utf-8?B?Y0YyZldzK01zK3c2bEZ4MUFvU0psaFR2N1d2RC9mbjBHdTFlcVdCaUt6Y0VI?=
 =?utf-8?B?UjNoZjZBbnhXU1ZydzRzOG1Ka2l5OGZXem1Ba1dmV1ZTdGRjTjdvQkU3aHIy?=
 =?utf-8?B?QXRoVXZ6cS9hd2hxdmUwdEY3S1I2UUs0UzRIMFUvZFhlcFhpYnBiMThrcjFi?=
 =?utf-8?B?Y1NSWEFsMHNPZmR2ZE0yL1NFYUNqOFlWdlN2T0xIWDB0YXlyejZTM2hYN1Y1?=
 =?utf-8?B?aTZHeTBHNVl1cTh5bnVBRFRvUGFVdXJucHFXZlh3VExHM2NnbGJBWWwwWFMy?=
 =?utf-8?B?elZEWTNyZkZEeUZBeE5XbnZuQXNsMDJzcXBucEk0WmY1N1g2TXdpVFhidG5H?=
 =?utf-8?B?SThOaFhJdHhVcXdjMmp0TWg1TXFuSkMza1RCZmk1c0h1VDBsQ3B1SGVrSXR1?=
 =?utf-8?B?ejJJRUIwWmI4ejlDYXRyM2RUMFdYNUppMDNvOVhYTDNYb1dLdUdpd3hyM1Vm?=
 =?utf-8?B?dUFNZjVKTzMvMVEyLzQvM0J3dU40bkx0ZklQeDV5cllLSzJYbnNKRU1XWGc1?=
 =?utf-8?B?MzNaa2ZQK2lkZWsvUkVaWmdIYnZPM3RVNG1aMEtNYmp4VFRody9zRnRSNk5C?=
 =?utf-8?B?bGxOOU95QjlxVFZKdjdGdHJ1cDdyekprcno5ZTZHMURCWGE3RWVYYkxPZXBl?=
 =?utf-8?B?RlNKUHJWWUI0eFRjejlNcEZjSkZsV1FSdW91MXAzUmkvSTdJYWVudTJ6S3RQ?=
 =?utf-8?B?WEZUQ3RoNUx6OGF4Rm5LWTMyQ1Rvam9DbmczOThsaXNyNFJrUFFWZGZzYTQ5?=
 =?utf-8?B?a2E4Y2I1SE8rbXUyVEU1dEdMWHRJRzFuYm9jai9mUnVzaEVwdWdnb2M2MlBP?=
 =?utf-8?B?OWRaaFpwWDZWZGRIa0Vma2E1TFVZcWVxVVVkZlNaNWZJR1RvZ3BLOXM0ME13?=
 =?utf-8?B?R0gvZXViN2NaVWt0UGRZS1V5TU9EMWhGc2FWbW1oN2kyQkt1aEEvU2dsTnhh?=
 =?utf-8?B?TUpoSTl0azJtTGhWem1vRkI4M1dIRS80T1hOSGVzSUJpclRaZ2dSQ3hFd3lx?=
 =?utf-8?Q?Qh9MxK9cbMX2Zzyuh5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc1759e-ff3c-4836-87d0-08deb675eb35
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 13:44:30.9215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2sYe9QqgUp/xzO4pYXvVCVV5g8mFCxOF0FxgwJisRGO7V9G9i2TCF4rfUhHp0Yz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790
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

On 5/20/26 15:28, Pierre-Eric Pelloux-Prayer wrote:
> Le 20/05/2026 à 14:33, Christian König a écrit :
>> On 5/20/26 14:25, Pierre-Eric Pelloux-Prayer wrote:
>>>
>>>
>>> Le 20/05/2026 à 11:14, Christian König a écrit :
>>>> On 5/20/26 08:38, Prike Liang wrote:
>>>>> From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>>>
>>>>> Add ftrace events for tracking the userq fence emit, signal
>>>>> and queue state transition.
>>>>
>>>> The queue trace points look good to me, but clear NAK to the fence trace points those just duplicates the common trace points in the dma_fence framework.
>>>
>>> The dma_fence trace points don't contain enough context to be usable from a tool (no device, no client id at the very least).
>>>
>>> The userqueue events are based on the gpu_scheduler traces and are what is required for UMR to implement its Activity view.
>>
>> In that case we should change umr to use the fence context instead of the client id and/or put the client/doorbell in the fence descripton. That's what this is good for.
> 
> It *is* using the fence context. Having the client_id helps associating with information available elsewhere (fdinfo for instance).
> 
>>
>> Creating new trace points to track userqueue usage and not using the standard dma_fence onces is an absolutely clear NO-GO from my side, do we also do that for the scheduler?
>>
> 
> Yes, the gpu_scheduler trace events do the same thing.

Crap I completely missed that, I though that the scheduler trace points would expose additional stuff and not superseet the dma_fence trace points.

Let's discuss tomorrow how to best handle that.

Thanks,
Christian.

> 
> More below.
> 
>> Regards,
>> Christian.
>>
>>>
>>> Pierre-Eric
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     | 129 ++++++++++++++++++
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  21 +++
>>>>>    .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  13 +-
>>>>>    3 files changed, 160 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> index 4ff8a4d7bb8b..32d8c36caaf3 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>>> @@ -28,6 +28,8 @@
>>>>>    #include <linux/types.h>
>>>>>    #include <linux/tracepoint.h>
>>>>>    +#include "amdgpu_userq_fence.h"
>>>>> +
>>>>>    #undef TRACE_SYSTEM
>>>>>    #define TRACE_SYSTEM amdgpu
>>>>>    #define TRACE_INCLUDE_FILE amdgpu_trace
>>>>> @@ -659,6 +661,133 @@ DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_enable_sig
>>>>>    DEFINE_EVENT(amdgpu_userq_eviction_fence, amdgpu_userq_eviction_fence_signal,
>>>>>            TP_PROTO(u64 context, u64 seqno),
>>>>>            TP_ARGS(context, seqno));
>>>>> +TRACE_EVENT(amdgpu_userq_job_run,
>>>>> +        TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *fence),
>>>>> +        TP_ARGS(device, queue, fence),
>>>>> +        TP_STRUCT__entry(
>>>>> +                 __field(u64, fence_context)
>>>>> +                 __field(u64, fence_seqno)
> 
> In the context of userq, these fields are similar to dma_fence_init.
> 
>>>>> +                 __string(dev, dev_name(device))
>>>>> +                 __field(u64, doorbell_index)
>>>>> +                 __field(u64, client_id)
>>>>> +                 __field(u32, queue_type)
> 
> These 4 are missing in dma_fence_init and useful for UMR. eg: neither dma_fence_init nor dma_fence_signalled trace the device. They only trace the timeline which is not unique on a system.
> 
>>>>> +                 ),
>>>>> +        TP_fast_assign(
>>>>> +               __entry->fence_context = fence->base.context;
>>>>> +               __entry->fence_seqno = fence->base.seqno;
>>>>> +               __assign_str(dev);
>>>>> +               __entry->doorbell_index = queue->doorbell_index;
>>>>> +               __entry->client_id = queue->userq_mgr->file->client_id;
>>>>> +               __entry->queue_type = queue->queue_type;
>>>>> +               ),
>>>>> +        TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, fence=%llu:%llu",
>>>>> +              __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index,
>>>>> +              __entry->fence_context,
>>>>> +              __entry->fence_seqno)
>>>>> +);
>>>>> +
>>>>> +TRACE_EVENT(amdgpu_userq_job_done,
>>>>> +        TP_PROTO(struct amdgpu_userq_fence *fence),
>>>>> +        TP_ARGS(fence),
>>>>> +        TP_STRUCT__entry(
>>>>> +                 __field(u64, fence_context)
>>>>> +                 __field(u64, fence_seqno)
>>>>> +                 ),
>>>>> +        TP_fast_assign(
>>>>> +               __entry->fence_context = fence->base.context;
>>>>> +               __entry->fence_seqno = fence->base.seqno;
>>>>> +               ),
>>>>> +        TP_printk("fence=%llu:%llu",
>>>>> +              __entry->fence_context,
>>>>> +              __entry->fence_seqno)
> 
> This one is indeed a duplicate of dma_fence_signaled.
> It exists so we have similar events as gpu_scheduler but we can get rid of it if you want.
> (the only caveat is that dma_fence_signaled traces context and seqno as 32bit integers).
> 
> The other events below have no dma_fence events equivalent so are they fine?
> 
> Pierre-Eric
> 
>>>>> +);
>>>>> +
>>>>> +TRACE_EVENT(amdgpu_userq_job_queue,
>>>>> +        TP_PROTO(struct device *device,
>>>>> +             struct amdgpu_usermode_queue *queue),
>>>>> +        TP_ARGS(device, queue),
>>>>> +        TP_STRUCT__entry(__field(u64, context)
>>>>> +                 __string(dev, dev_name(device))
>>>>> +                 __field(u64, doorbell_index)
>>>>> +                 __field(u64, client_id)
>>>>> +                 __field(u32, queue_type)
>>>>> +                 ),
>>>>> +        TP_fast_assign(__assign_str(dev);
>>>>> +               __entry->doorbell_index = queue->doorbell_index;
>>>>> +               __entry->queue_type = queue->queue_type;
>>>>> +               __entry->client_id = queue->userq_mgr->file->client_id;
>>>>> +               __entry->context = queue->fence_drv->context;
>>>>> +              ),
>>>>> +        TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu",
>>>>> +              __get_str(dev), __entry->client_id, __entry->queue_type,
>>>>> +              __entry->doorbell_index, __entry->context)
>>>>> +);
>>>>> +
>>>>> +TRACE_EVENT(amdgpu_userq_job_add_dep,
>>>>> +        TP_PROTO(struct device *device, struct amdgpu_usermode_queue *queue, struct amdgpu_userq_fence *dep),
>>>>> +        TP_ARGS(device, queue, dep),
>>>>> +        TP_STRUCT__entry(
>>>>> +                 __field(u64, context)
>>>>> +                 __field(u64, dep_context)
>>>>> +                 __field(u64, dep_seqno)
>>>>> +                 __string(dev, dev_name(device))
>>>>> +                 __field(u64, doorbell_index)
>>>>> +                 __field(u64, client_id)
>>>>> +                 __field(u32, queue_type)
>>>>> +                 ),
>>>>> +        TP_fast_assign(
>>>>> +               __assign_str(dev);
>>>>> +               __entry->doorbell_index = queue->doorbell_index;
>>>>> +               __entry->queue_type = queue->queue_type;
>>>>> +               __entry->client_id = queue->userq_mgr->file->client_id;
>>>>> +               __entry->context = queue->fence_drv->context;
>>>>> +               __entry->dep_context = dep->base.context;
>>>>> +               __entry->dep_seqno = dep->base.seqno;
>>>>> +               ),
>>>>> +        TP_printk("dev=%s, client_id=%llu, type=%u, doorbell=%llu, context=%llu depends on fence=%llu:%llu",
>>>>> +              __get_str(dev), __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->context,
>>>>> +              __entry->dep_context,
>>>>> +              __entry->dep_seqno)
>>>>> +);
>>>>> +
>>>>> +TRACE_EVENT(amdgpu_userq_state_start,
>>>>> +        TP_PROTO(struct amdgpu_usermode_queue *queue),
>>>>> +        TP_ARGS(queue),
>>>>> +        TP_STRUCT__entry(
>>>>> +                 __field(u64, doorbell_index)
>>>>> +                 __field(u64, client_id)
>>>>> +                 __field(u32, queue_type)
>>>>> +                 __field(u32, from)
>>>>> +                 ),
>>>>> +        TP_fast_assign(
>>>>> +               __entry->doorbell_index = queue->doorbell_index;
>>>>> +               __entry->queue_type = queue->queue_type;
>>>>> +               __entry->client_id = queue->userq_mgr->file->client_id;
>>>>> +               __entry->from = queue->state;
>>>>> +               ),
>>>>> +        TP_printk("client_id=%llu, type=%u, doorbell=%llu, from=%d",
>>>>> +              __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->from)
>>>>> +);
>>>>> +
>>>>> +TRACE_EVENT(amdgpu_userq_state_changed,
>>>>> +        TP_PROTO(struct amdgpu_usermode_queue *queue, enum amdgpu_userq_state new_state),
>>>>> +        TP_ARGS(queue, new_state),
>>>>> +        TP_STRUCT__entry(
>>>>> +                 __field(u64, doorbell_index)
>>>>> +                 __field(u64, client_id)
>>>>> +                 __field(u32, queue_type)
>>>>> +                 __field(u32, to)
>>>>> +                 ),
>>>>> +        TP_fast_assign(
>>>>> +               __entry->doorbell_index = queue->doorbell_index;
>>>>> +               __entry->queue_type = queue->queue_type;
>>>>> +               __entry->client_id = queue->userq_mgr->file->client_id;
>>>>> +               __entry->to = new_state;
>>>>> +               ),
>>>>> +        TP_printk("client_id=%llu, type=%u, doorbell=%llu, to=%d",
>>>>> +              __entry->client_id, __entry->queue_type, __entry->doorbell_index, __entry->to)
>>>>> +);
>>>>> +
>>>>>    #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>>    #endif
>>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> index e27f9a76f986..60d1186af286 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> @@ -329,11 +329,15 @@ static int amdgpu_userq_preempt_helper(struct amdgpu_usermode_queue *queue)
>>>>>        int r;
>>>>>          if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>>>>> +        trace_amdgpu_userq_state_start(queue);
>>>>> +
>>>>>            r = userq_funcs->preempt(queue);
>>>>>            if (r) {
>>>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>>>>                queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>>                return r;
>>>>>            } else {
>>>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_PREEMPTED);
>>>>>                queue->state = AMDGPU_USERQ_STATE_PREEMPTED;
>>>>>            }
>>>>>        }
>>>>> @@ -349,10 +353,14 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
>>>>>        int r = 0;
>>>>>          if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED) {
>>>>> +        trace_amdgpu_userq_state_start(queue);
>>>>> +
>>>>>            r = userq_funcs->restore(queue);
>>>>>            if (r) {
>>>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>>>>                queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>>            } else {
>>>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>>>>>                queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>>>>            }
>>>>>        }
>>>>> @@ -370,12 +378,15 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
>>>>>          if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
>>>>>            (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
>>>>> +        trace_amdgpu_userq_state_start(queue);
>>>>>              r = userq_funcs->unmap(queue);
>>>>>            if (r) {
>>>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>>>>                queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>>                return r;
>>>>>            } else {
>>>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
>>>>>                queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
>>>>>            }
>>>>>        }
>>>>> @@ -392,11 +403,15 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
>>>>>        int r;
>>>>>          if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
>>>>> +        trace_amdgpu_userq_state_start(queue);
>>>>> +
>>>>>            r = userq_funcs->map(queue);
>>>>>            if (r) {
>>>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>>>>                queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>>                return r;
>>>>>            } else {
>>>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>>>>>                queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>>>>            }
>>>>>        }
>>>>> @@ -1007,6 +1022,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
>>>>>            if (!amdgpu_userq_buffer_vas_mapped(queue)) {
>>>>>                drm_file_err(uq_mgr->file,
>>>>>                         "trying restore queue without va mapping\n");
>>>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_INVALID_VA);
>>>>>                queue->state = AMDGPU_USERQ_STATE_INVALID_VA;
>>>>>                continue;
>>>>>            }
>>>>> @@ -1502,12 +1518,14 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
>>>>>            if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
>>>>>                continue;
>>>>>    +        trace_amdgpu_userq_state_start(queue);
>>>>>            userq_funcs = adev->userq_funcs[queue->queue_type];
>>>>>            userq_funcs->unmap(queue);
>>>>>            /* just mark all queues as hung at this point.
>>>>>             * if unmap succeeds, we could map again
>>>>>             * in amdgpu_userq_post_reset() if vram is not lost
>>>>>             */
>>>>> +        trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>>>>>            queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>>            amdgpu_userq_fence_driver_force_completion(queue);
>>>>>        }
>>>>> @@ -1526,6 +1544,8 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>>>>>          xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>>>>            if (queue->state == AMDGPU_USERQ_STATE_HUNG && !vram_lost) {
>>>>> +            trace_amdgpu_userq_state_start(queue);
>>>>> +
>>>>>                userq_funcs = adev->userq_funcs[queue->queue_type];
>>>>>                /* Re-map queue */
>>>>>                r = userq_funcs->map(queue);
>>>>> @@ -1533,6 +1553,7 @@ int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
>>>>>                    dev_err(adev->dev, "Failed to remap queue %ld\n", queue_id);
>>>>>                    continue;
>>>>>                }
>>>>> +            trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_MAPPED);
>>>>>                queue->state = AMDGPU_USERQ_STATE_MAPPED;
>>>>>            }
>>>>>        }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> index 008330a0d852..00cc7194321c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>>> @@ -30,7 +30,7 @@
>>>>>    #include <drm/drm_syncobj.h>
>>>>>      #include "amdgpu.h"
>>>>> -#include "amdgpu_userq_fence.h"
>>>>> +#include "amdgpu_trace.h"
>>>>>      #define AMDGPU_USERQ_MAX_HANDLES    (1U << 16)
>>>>>    @@ -169,6 +169,7 @@ amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
>>>>>            fence = &userq_fence->base;
>>>>>            list_del_init(&userq_fence->link);
>>>>>            dma_fence_signal(fence);
>>>>> +        trace_amdgpu_userq_job_done(userq_fence);
>>>>>            /* Drop fence_drv_array outside fence_list_lock
>>>>>             * to avoid the recursion lock.
>>>>>             */
>>>>> @@ -528,6 +529,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>>>        /* Create the new fence */
>>>>>        amdgpu_userq_fence_init(queue, fence, wptr);
>>>>>    +    trace_amdgpu_userq_job_run(dev->dev, queue, fence);
>>>>> +
>>>>>        mutex_unlock(&userq_mgr->userq_mutex);
>>>>>          /*
>>>>> @@ -701,7 +704,7 @@ amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
>>>>>    }
>>>>>      static int
>>>>> -amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>> +amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *filp,
>>>>>                        struct drm_amdgpu_userq_wait *wait_info,
>>>>>                        u32 *syncobj_handles, u32 *timeline_points,
>>>>>                        u32 *timeline_handles,
>>>>> @@ -835,6 +838,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>>            goto free_fences;
>>>>>        }
>>>>>    +    trace_amdgpu_userq_job_queue(dev->dev, waitq);
>>>>> +
>>>>>        for (i = 0, cnt = 0; i < num_fences; i++) {
>>>>>            struct amdgpu_userq_fence_driver *fence_drv;
>>>>>            struct amdgpu_userq_fence *userq_fence;
>>>>> @@ -869,6 +874,8 @@ amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
>>>>>              amdgpu_userq_fence_driver_get(fence_drv);
>>>>>    +        trace_amdgpu_userq_job_add_dep(dev->dev, waitq, userq_fence);
>>>>> +
>>>>>            /* Store drm syncobj's gpu va address and value */
>>>>>            fence_info[cnt].va = fence_drv->va;
>>>>>            fence_info[cnt].value = fences[i]->seqno;
>>>>> @@ -968,7 +975,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>>>                               gobj_write,
>>>>>                               gobj_read);
>>>>>        } else {
>>>>> -        r = amdgpu_userq_wait_return_fence_info(filp, wait_info,
>>>>> +        r = amdgpu_userq_wait_return_fence_info(dev, filp, wait_info,
>>>>>                                syncobj_handles,
>>>>>                                timeline_points,
>>>>>                                timeline_handles,
>>

