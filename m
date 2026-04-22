Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FE7F94CD9
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 07:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B6F110E248;
	Wed, 22 Apr 2026 07:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SyW01GQm";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC2810E248
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 07:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVkVHjiWJEih5LXpJUZN8PrQipDjlqHSphxusp7N7R4pdj+bIZV6lp5RciUK0wSldeif0yBshvlv5Xx+TkCYch4aqK073EwIMeaEk6+dDozwhMnuyy+IRE5NGpbvDF4BO4qaZRu0FcKHdaLEpsCsr8FrpZqvdU/JlemKUJ24K97PtJ33z9ldJ7KVwzOec87WEPvNhVXWeZsCffFRNCbVXNgKRhp15ElK3zyv5ALsxslHRmO33zHH6TgtB7nYOICUaxhN39Nm6Sp6LsCMHL+BAR46lJE1ZD5BKhceVONch+WxDYe6aU3mNYYsR7o2SKeuTqCyMKZ/o+Fgi+pJLKUnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTgt7sPTmFMqpMjcR4h0PojZz41P7cqUnGGj1CtlX1A=;
 b=XUwlNRbA317Y8T0ncrOVwg44GAbzouMYeSP0LoiUUkpXGBung2PAvB4EYiW7OVa5zBDZsFHS6K21CIaWW+/u0DBKhJmMEJh3Yij/1WRBt2CmoB1lFKLS/cGiEPTEj8Bfm7gIN1Mp3dW1YLtMu2VSGV0rk79oZDjzDvlyAak4taZ2bq4yuAnxCLkeGV91TjS7+e7Pdyq6XI38/LYeYAGx15MjlMDFRR4Z/W4TqTL7n9nkcM7l9ZDA+BA/t5jI0jkn02nFEVHUZBXeaFDmNQSas7yF6+5TzlqMwG2Qjzm+20bff3ydqT3FrvhH48EQQlA+0hz2m+8tItp71BN7areYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTgt7sPTmFMqpMjcR4h0PojZz41P7cqUnGGj1CtlX1A=;
 b=SyW01GQmOxQIUskr3UoQOoQYtlgR+EIGsN/bUHvD8bhESp1Xgor7zkLehp6+RCINWsNKTPardi0/cQjPps/UBEkvd6y4IVsTgR3Gel4MTgg8DcBmvcuiU6Hr9dk/Z0Y8EeFmSxLlUSB+ceGpD7ZOrUz1Qu90Urv/Rem29+kZeMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 07:29:13 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 07:29:13 +0000
Message-ID: <5ac8b3ba-347e-4f51-b8be-eb0348615c38@amd.com>
Date: Wed, 22 Apr 2026 12:59:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] drm/amdgpu: remove deadlocks from
 amdgpu_userq_pre_reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-2-christian.koenig@amd.com>
 <e0761bb4-6cb5-40ec-b5f4-f57c6ef636e2@amd.com>
 <e70355c6-778b-46d9-bf29-cbbb4adc9d0f@amd.com>
 <ed622c66-3d8d-4bd0-8b61-21dc17255162@amd.com>
 <e0a6c051-8acb-435c-9344-7a4f96aca2f1@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <e0a6c051-8acb-435c-9344-7a4f96aca2f1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::15) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: e765c0c3-643e-4b9c-34c6-08dea040d9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11006099003;
X-Microsoft-Antispam-Message-Info: zjUhdyZNpRHVZ9G+zslzwDMxAhQ7iJqEfgcZJAn0QYLU9um0wl3Yi3NEa7ICZhRFd7PGTkCcMSfuoAyoHQ6hG19U0B3NRwHgN/53Xi910mAvyXqE6zpLNzWnkRHcYoXWc/Mq0TGbabWx19jHQ5gaRf0I1M/kMXh/y3pNS0q+kOB5fJE0wN0HE57+vboWlnkcl6KwKkH2O9s97Jgl6m2738MjKOeZMeMZzuqMgqoIWpaTGEz+CnoahWg9ynRlDprthvtUk3NUFX+g9G+NnjzfFo07LibX/r7IN4nx28BaMY8B+m2Rh2GwmKIvbPjJgxY+pZfQY8jRxca0fE8N2JnAXh3K6+Fpes4I8G3NKO72v7sWteCCOFdYn6Pb8Joto/liRuKa7VNCjHhKu87vXlEvy5TL9c5et6yMYsHcdTmiIUqigISPFOof9wryBlcW4M0Ax3GDBEVWgaQOqVwYgpk48d5o9LIKagkHZQlCnK/vKAt+4yLXWmVdtwMlN2oPxJ6hBA1DtKDCM6JTcm+xoUGzLWo4OnawXR4kdIBxJReb5tgUdWME1cNZzU5cAfZB/zSYxqO61rciEof9cvq4DYcfuOxsUVHD4TXTickmvx+Tgp+gkCuc4R8GDWf6t8YBg4N407RyLKeEPa6dPW8mS/ZMr/0JT2pfGUgKOadPq6ysfmidjsmMb3iDvuzajaKk8/XIaqMv3d3tvHqaRBJC+Y5CE9j3DcQl9JJiGT4teeIkPVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11006099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czlWaHdUQUxQTDBPWDdxdVE0b2cwVXN4cW9ZUlZBWEcyWXdwQUZMbU1SbWh4?=
 =?utf-8?B?bHdqSWNXWmwwYmhMR1YwNWF5YVFKUUNaRWpvSUd5cTAzQjZxek02OTVxaURq?=
 =?utf-8?B?aGRic0J2eUJHV2NlK2QvMjVBL090NE1EdzBiQUFTNm5CSy9oS2xuclVJS0dW?=
 =?utf-8?B?MWpUNHJMOFpoMjlxRGEzb3JYbmpDc0N4WFU1cEI3R1dEblJJUEFvajJFZ3RU?=
 =?utf-8?B?aE5zQllzV0N0dXhqN2tGZnNoV0VWSnhBaW0rR3orMEkxY282RlhsTFBsWVNO?=
 =?utf-8?B?cW4yWFZOa0UzYkNrdi9KdlNMalhQTGVIZW5kSkNTUDJKWVVqQUU2cFhlTXQ3?=
 =?utf-8?B?b2hrSGw4MHZOWVpsRXIwR1g3YksxaGN0MFE1V2x2Y2VmNVJBZ0VLTmh2Tzlt?=
 =?utf-8?B?N3VmdU5FUVdHbFVIZU4wNmVnSXFRSWU3S2FnMHl3N2RNN1I5RDY3bXg1L0Nq?=
 =?utf-8?B?SWdWYkZqN3BWQnNkclhQYUFXQUFQeVBmQVp6MTE2R29vSk51Zmg5TXhoaC9R?=
 =?utf-8?B?Z1ZjK3R2MHZURHRpMW9NYml5SWpvcEFMYllScjZuRlBXa0pBVkpIZVM3NFlM?=
 =?utf-8?B?dkN1aHZtdnFXY3BEZ3U3SzhFdVRmZ3MzUkhyeXFvcWZQK1hUTFhmM1hoT3Zz?=
 =?utf-8?B?bHRMbmY4bDhHTXdROE1GL3ROcnNGZEVrNzR4b1FxNjArMzZtcXhvNnV6QVpO?=
 =?utf-8?B?OGUzR1psek9peEZialF1RlVkbGtVZlNDQW9SUU9oTWxLNHpMK1pYdjlDU0dW?=
 =?utf-8?B?Z24zTWNSanpGV0NTTFEwZXpyZ29GbmY0ZXdrVkhwV3E2clNwV2dkMHZ6T2hZ?=
 =?utf-8?B?a0FTS0NsbHpXWWkwQmZmMy85QlNNbkZLNC9wZ1d6SEdla0lGNDl3V3E3RXU4?=
 =?utf-8?B?SllrMmFxVkMrZ3EvMi95Q1NTcW1uQlhlZEgxY29zYUU3QlB4WWM4MDV1dWlp?=
 =?utf-8?B?dENRZ2lQN3dPaEZNRiswYkcvQ0kxS1lnZlFzL3NkalZCbHRTeGJXYUVJTVlL?=
 =?utf-8?B?UC9SRjRxUWo4dnFXQkZsNm81YUkvdHBwSDJSUDhEdGZLd3J1bEtVMzhsQ3kr?=
 =?utf-8?B?em9GT2FZME5hSWdSV3hpa2VYN2lzUGpVblRURFBpV1MvTG9TOXl6ekRmdGN6?=
 =?utf-8?B?c0syK0srdnFjWXFlaXBwNFg4UlQ3Q2s4WTlzKzRkZTRqU08rVlFLUG9STWI3?=
 =?utf-8?B?N205U2JRdTQrbUJNS2FJd0Mrb0Fod1c2YjJpT0xKenR5NWgzWFVlN081NUhs?=
 =?utf-8?B?Y2RrSjlaeWxBWE5SU0kwRkx3ZUdjVXBablBkSHRTUzB1TXNWQjRYRzhJQk5a?=
 =?utf-8?B?alhJN3NLTGxNL1hFMHoyUUhvL0hDS29hSUNlOFhoQkdZWndQNHlLaldaSEVH?=
 =?utf-8?B?SzdDVEg3QVBsdWt4VFFKaWRRZWdWQ2JEN1hYN09PeHpTNVBQaTRJV3JmY21x?=
 =?utf-8?B?WVNjdWFXWmpSL1R2a0tKdUJiRUljWGc3ODdJMis2a256Q3I1OG9sa1REZXNT?=
 =?utf-8?B?a0g0eE5pdUkveU5GZXVaalZEenc2M3FWTlIzUys5UTJLbTBsWDkwS09KSEdT?=
 =?utf-8?B?VkRtM1BOT3hmYlEyK0JpRlNWZmZIVEVzUmhVbFJIYVIxalVTQitpMkxLam1M?=
 =?utf-8?B?RkJjZ2VHVzFLclJoSTlBOVVTREU5aFhBVG5FNXpYaitmYlBoaWJidm5aTjU0?=
 =?utf-8?B?S0NTaVZGUWs5ZW9waTdObnlsdGhuTFZvWXVBb0xxYjhnNExVeXVlaTJYSmky?=
 =?utf-8?B?aEFZNUczUXhSaFJsSTlVMVNpbHhBZzRtMDRUd1F6d3gvRDgvK2FrSjlBWEZK?=
 =?utf-8?B?dzhaZnZPVVVhRVA2eURZMU5wRU9FY3g4ZFoycFpFQU1OVFZpcmk4UHBsWUpX?=
 =?utf-8?B?Nks1WGZUMkFPNnpYbzk0WGdJZjJlYUpvUDZyWlcwTzU2K2FFSUJ6Vi9lY3hH?=
 =?utf-8?B?dHFVbTIvcHhoK0JFZW81dVltclNYclFWeHZFa1JWa1l4MmJ6bUZSWi8zK3BP?=
 =?utf-8?B?bzYrSGxyV1pwYThQaUZaTEpzZ3JSeXZmMG03N0VNbkJuekxDcmtxTk9id2hh?=
 =?utf-8?B?QkZTeUFaQURoRnNNUnNlWWR0UnZFYk4wR3hXdFFWZHorQW5qOFRKWVBnclpr?=
 =?utf-8?B?eGlHaXl1U0FFZVVoeXc2UHhXTXZpVWp3ai9ldGVEczNjeWsydjF6TVJrajBS?=
 =?utf-8?B?TFZ3Rm1IV29uVHJ5dURFM2ZTR2VlV0FFMHh5UzhjazkyZTJydTk0TlluUDNw?=
 =?utf-8?B?bkJkU1A3c0dLdVlFTVZJeWx4RnVIMTQ3SUJwTy9VWGw4SDVvakxWQ2NZTUdM?=
 =?utf-8?B?RjUvNXI3Uk5IVmdiV3ovVVZPTHhMUy9wcUVQb0N3dGhvc1Irc0ZxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e765c0c3-643e-4b9c-34c6-08dea040d9ee
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 07:29:13.1315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRqGwtR50mmrzixr4zXRYjlfD7IAcEHwdWbFYhKziwV7H+LUDZCaiTQOt0rd7vpAc6FwUa6cxBH3cYXufvulfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
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


On 22-04-2026 12:54 pm, Christian König wrote:
> On 4/22/26 09:19, Khatri, Sunil wrote:
>> On 22-04-2026 12:43 pm, Christian König wrote:
>>> On 4/22/26 06:53, Khatri, Sunil wrote:
>>>> On 21-04-2026 06:25 pm, Christian König wrote:
>>>>> The purpose of a GPU reset is to make sure that fence can be signaled
>>>>> again and the signal and resume workers can make progress again.
>>>>>
>>>>> So waiting for the resume worker or any fence in the GPU reset path is
>>>>> just utterly nonsense.
>>>>>
>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++++------------
>>>>>   1 file changed, 12 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> index 8f48520cb822..b632bc3c952b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>>>> @@ -1496,23 +1496,21 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
>>>>>   {
>>>>>   	const struct amdgpu_userq_funcs *userq_funcs;
>>>>>   	struct amdgpu_usermode_queue *queue;
>>>>> -	struct amdgpu_userq_mgr *uqm;
>>>>>   	unsigned long queue_id;
>>>>>   
>>>>> +	/* TODO: We probably need a new lock for the queue state */
>>>>>   	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>>>> -		uqm = queue->userq_mgr;
>>>>> -		cancel_delayed_work_sync(&uqm->resume_work);
>>>>> -		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>>>>> -			amdgpu_userq_wait_for_last_fence(queue);
>>>>> -			userq_funcs = adev->userq_funcs[queue->queue_type];
>>>>> -			userq_funcs->unmap(queue);
>>>>> -			/* just mark all queues as hung at this point.
>>>>> -			 * if unmap succeeds, we could map again
>>>>> -			 * in amdgpu_userq_post_reset() if vram is not lost
>>>>> -			 */
>>>>> -			queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>> -			amdgpu_userq_fence_driver_force_completion(queue);
>>>>> -		}
>>>>> +		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
>>>>> +			continue;
>>>> If the queue is in prempt state and if at that time we are in this function we should still be doing force completion for work in those queue else the waiters will keep waiting.
>>>>
>>>>> +
>>>>> +		userq_funcs = adev->userq_funcs[queue->queue_type];
>>>>> +		userq_funcs->unmap(queue);
>>>> GPU is already hung if we are here and observation is we are unable to unmap as we have tried to reset via the fw and that failed to atleast thats what i have seen. Could we skip unmap ???
>>>>> +		/* just mark all queues as hung at this point.
>>>>> +		 * if unmap succeeds, we could map again
>>>>> +		 * in amdgpu_userq_post_reset() if vram is not lost
>>>>> +		 */
>>>>> +		queue->state = AMDGPU_USERQ_STATE_HUNG;
>>>>> +		amdgpu_userq_fence_driver_force_completion(queue);
>>>> we should be calling completion irrespective of queue state here. The GPU atleast the queue is hung and fw has failed to reset. We have to release the fences by foce completion.
>>> Yeah, I agree completely with those require comments I has similar thoughts while going over this.
>>>
>>> I'm only driven by bugs here and my goal with the patch was to remove the obvious deadlock in the function.
>>>
>>> Somebody needs to sit down and go over the whole handling for GPU resets and make sure it plays nicely with user queues.
>>>
>>> Regards,
>>> Christian.
>> For now this is what i think we could do.
>> In the loop: If a queue is mapped -> try unmap
>>
>> Irrespective of the queue state:
>> Set queue to HUNG and call amdgpu_userq_fence_driver_force_completion
> How do we protect the queue state? We don't have a lock for that and in a GPU reset you can't grab things like the userq_lock.

It would be best and i thought of this too earlier to have a per queue 
or per queue manager lock and which is for setting up the state of 
queue...That will help a lot too in the all the hw function like prempt 
resume etc that we call as many times lock is only needed for state 
change than anything else... If you want i can look into that later once 
these patches land up or you decide if you want to fix it now.

Regards
Sunil Khatri

>
> Could we call unmap while holding the doorbell XA lock or would that clash with something?
>
> Regards,
> Christian.
>
>> Regards
>> Sunil Khatri
>>>> Regards
>>>> Sunil Khatri
>>>>
>>>>>   	}
>>>>>   }
>>>>>   
