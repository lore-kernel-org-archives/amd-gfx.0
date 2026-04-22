Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE91F94CD8
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 07:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2AB3112CD7;
	Wed, 22 Apr 2026 07:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZOkZi/CP";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D631E112CD5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 07:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e56ToK6d0ujtcmjQhyvS2cQqMgfOYnhy77w9DTKbpiCe1napQXEqDauUY6y8XpPP9nvRslnMAEMubNLjVgC8O1Wzk0482R9a+r/R+4QUZfVwcCADp8uMPDAMdlou+rdAWkYbeZ2ngkIi/XCetsx5ZIsatfxMMroR1prR1nnXB0Bmkz4KWyQMFiWod7vSN/KtG8Z9+/8207XBofT4Ebt8FQDqU1b/8WAWMARKISnrvXZKeDWuGhtTGv+7Pk7HlsXFBp7YDGooA+rKizRjmVw+a+YXaqKPAHqmkbcknuOS5US2zzetqVLQAwnpu4pIGp/IVi72VsrHXVceta2tGi6OoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nlnh38YCe1EKIMnw494wuPpq0m8aa1ArH6XLmGCfmk=;
 b=wrjqdtomjowpjiI3iMOXp9IW3O4kkHBWUb28YZef8T5J31XsjClFN/zfttn3GYA4R5PeZkZ96zc1AZDePXkv/hhocTPW6L4t9yrPa39eVMZIhD20w1MO0tXkVkLXNyzyaQJUO72BIc/nvGBY1uCYs9qP6V76+Pma8BMunpZIcBqQEFSgkWYt6gsnZ2XeGffGtazNvbed7nh2K00oXTayDU3qt/1DVxQFPUskYvoqpAqtTSTiRgEfdsj7SnA0JZliIxp9Lwj8QFALLk8DPb/h6qYMPCtwy3hNfQbDzR/cYMxbVFslpn/opix6OxGczWz4RIAqa+6GfvBO5axAvyLBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nlnh38YCe1EKIMnw494wuPpq0m8aa1ArH6XLmGCfmk=;
 b=ZOkZi/CP6OVczWT7g6fgEAF13QJ+q0H1i0hDDnRU/6W7MlAx2AIYK/hGHkHOOzA62SPD+raajmagfSNigLH7uyyXfLeTr7j34mbWVeGIVQkkmzgEH45ztbd/GUob+jU7UidQa+7bHqc/3ri+GwVMAf3ojWYSdfppx/5I+ECmSwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 07:19:50 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Wed, 22 Apr 2026
 07:19:50 +0000
Content-Type: multipart/alternative;
 boundary="------------bAnFseepRqlTxUlTBcZYgNCc"
Message-ID: <ed622c66-3d8d-4bd0-8b61-21dc17255162@amd.com>
Date: Wed, 22 Apr 2026 12:49:45 +0530
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
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <e70355c6-778b-46d9-bf29-cbbb4adc9d0f@amd.com>
X-ClientProxiedBy: BM1PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::35) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aadb087-3e6a-4280-49f3-08dea03f8aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11006099003|22082099003|18002099003|56012099003|8096899003;
X-Microsoft-Antispam-Message-Info: Ax89nQKMdZht9N3ZI6os7VmXxJ7/EDhZ9Fh5KDf4crRabDJKpUaJxVMDbA0xC8BOjNHKFvhKpVg3iEPwT/HQuc9I9H2XFQgqzan3wOk16k3cHYvFsCb3UJoagkQydz2XK57Sqsz7NjaY1WvTfstw7UXFoIUY47SngCO1gyLR7cVBeZyMNAUuWATSVXZHf+h/UtCbk7IU/8nIP5L7q7PxBKz7ZZ8UeWd/Z4ci6gugE3OIu6II1HOivgzHlciA6cwjECfcD533RCaMbN8ps9bD8M4RnGNfmNd81RmaobR4t6PdsfGjQg8TXV+QW5pZQ4Sy1vc1bRVHzIYbgJEaUsScw6HcOmroTLjfuLokOqGxicXW6OhEKjj6VKfOQ6sdkJH7ZKZSX20xbBWgeSg1Vxbbnze735FnEoh8Z/3CHKZFAZEzBUtEH4zJ/TijS//zPWjusK3gXq1o37qfkXXUjZIuZj/CN8raMRdgriMgFrNxnpfS4PHi68ebJhIut9HLTuzj9kGl3T9banJCma9VdyyLJnWlcT6llM3Bh/SX5d7iYPE/clAeINE4pCQG5MZKWib7UqyN3pEvybhQoUoK864K5rvp7H8KOlMvy0U0qgcT7VetRrYdwq6LHHmuUIj0eFtk2S4dy//r1Vj1y+N4TCCl9u9uMI4idt2DhZ2mUyLnJJneIbetRTyjWm+0sYSPdnj6WgJnq/9TaVL1aW9/yhJkolH3mkF/yktaD85cZm77TwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11006099003)(22082099003)(18002099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFM2QkNxRnNCYm9FcVhnVzZpSEJpcllRVUFsYkVwSDcxV0tKRjZqWXFPY1Ji?=
 =?utf-8?B?SHVCZ1JFd0tYUE4xMGNSdVlvR0NrZ2pRckpvTzc4SlkwcWMrQnRWRDc3cFFZ?=
 =?utf-8?B?Mld0Njc0SDUwRXZ5SFlHd1dJSWRUTjJmSVRXV0tnOGplYyt1TEhzUnZzaDB3?=
 =?utf-8?B?ZDBWeDFjL2RTUEdiSURlRHhyWnFrSVNQZnhFblRrMTJZdnJ1bjc0Mkx4MXNE?=
 =?utf-8?B?ZnpLNi8wSlhiMnlXZlpzNHA1OFdhejczaW8yLzBKdkh5bGpzSmtXeDJ3d0R4?=
 =?utf-8?B?S2grdTNSUFpLWkVHbGQ4YmV3THNXRVRoajkreUxNZXRTa0lNeDRFM1FQc0hU?=
 =?utf-8?B?dVF1TGhQQjg5MFNJdEtoVTVJeDZSTXgxVmZoYkxQWWF1ZUFqSHhzTUwzQ3c0?=
 =?utf-8?B?ZzIzWVRvd2Q2Tzk2WHZVZVozUktqT0lWUFZCczVBbGZLazQ0YkZ4Ukhmd0NU?=
 =?utf-8?B?VjE1OXUzeHozdUZwcXhaTHZZZ2l0Y3dtZnlsUE52bEc0cGRScUZNT1dCaUly?=
 =?utf-8?B?RVI2K2NrTnphQ1pybW1Ja1B2MU1hYk9oQVZqdlR4M1B2QXh5Njk3TWNrYmJu?=
 =?utf-8?B?eDBiSklCSjFwdWxJcGpHL3l5VXVVQVVITjZ5MUszMFdzWDVRUlgxSWR4UmxX?=
 =?utf-8?B?VlBFTSt6SSs1UVp3ZnlKcHV3NlZHL0RrZ3NSZWdlVkRwN3JCS3I3cVo4QzV3?=
 =?utf-8?B?akEyeGZFVHVEaHg3em1UUnRZSmlnU0h3SDJpeWVXTVlrZjYxOVBhUi9iK2k5?=
 =?utf-8?B?cWhDVUFOSkJ3NkVROUQrWnlnN3Z0ZTFzWlZOZ0xaSnQzUFlHMnFkZG9yNWpF?=
 =?utf-8?B?ODFWV2gyNTRWYWxidGJhVDlsUUFwQU1kRmU3TWNFZ3ZTVHd1WFlTLzd2cnVO?=
 =?utf-8?B?dWNCbHQwanlEZGJkM0ZQWFZzVTdCcTlrY01sN2czU1Jic3l5ZUhacXJ0eEZQ?=
 =?utf-8?B?WndNVmUxQ0M3Y3BQTUViRTNJWk1IUzM3azZpandTV3pTbWQ2dFhkVWNDdy85?=
 =?utf-8?B?UmE5akYwZWU3TVZ2cUYwUGJZOENnUHNCdVBYakxGOG9uemxxUlBkSmpNSFA0?=
 =?utf-8?B?K3JuOUJrT04rQkRpM1EzMlViMksyUU1XYnZ3MkNGNVhyOG5UWVFoZEwwNmlV?=
 =?utf-8?B?Q3NmY0hic2NnOUpVVVhJWnBQcUpvdXJWWHlzTy9zRVdBUS9XazJDMTZ3ZGVE?=
 =?utf-8?B?QllFR3pPVFR1OWxoUjNic2Q5MzI3Y1ZRc2NreXJBckF6aGxKVGh6SGtYcEQ2?=
 =?utf-8?B?djhmSk1DRTNRbmJ4TFp5Q3BrWFMrYzZVK1cvN2ZDcmc5WlhENXNlRTdjNkl2?=
 =?utf-8?B?Qkdaamdmd0ZhYzUrM0Rmd3VSVzZBMytHcWRlNXpRd3ZIcmwzNzBxbDJHNytD?=
 =?utf-8?B?ZkZndWNTdHFwWDVsRk00eVlRTWplK3lJWStFUFBVRVBoSDQ4VU5wbzBndWk1?=
 =?utf-8?B?Y3YrMUl2QUZUTlNydUowVnlRS05DZmQ2SFdnSE9SMHVydkN0UUNmT3MveDh3?=
 =?utf-8?B?MHlsRk5ocTJNYmh6NTdsaGNtNHdIV1pWR1NZcGtWYXVUa2VXQWVnNGtEUmhJ?=
 =?utf-8?B?bHdKM1REaDdsSGd1U3hSWjcyMXBuTVVHeU4xQmpKdkJGWk1HWm05R211TWhO?=
 =?utf-8?B?UjZRd1I2UVpvMmxyQ0EvNFprY3BxdThVOGoxait1ZHBqUm9oVHFaRElzOXpZ?=
 =?utf-8?B?SGhoYmZtODIwNTEvU1phTlk2SktwOTIwQVNaeDlCaE43Z2x3RVRlRjZ5MmZR?=
 =?utf-8?B?MUxpcTlvQks3SnJEemFXaEllR1gyV0RjUVhTMThseGs4dG1IY1ZJVjI4MDZi?=
 =?utf-8?B?YlVQQ0ZUK2h0S2JHZEJWejZjUFB4TThYZGZnYzVnTnArd1VtTkswajBTOEhn?=
 =?utf-8?B?SXZIdithM0YyWlJvVmdJRnVmYXpxZjZBdmlmeDB6azJnOU9Lbk1WaEVEQS9s?=
 =?utf-8?B?blMvZ0thWG5SKy9ZSUZSVFdDR0RaeFlTTnRDeDNWbkp1L0lSVno1SnU4Umdn?=
 =?utf-8?B?MU5YYUZjT0JpSkhUZE0yM256NVB2OHpXL0dPeXB5dWxHUVRtK3dDLzdkL29q?=
 =?utf-8?B?bHF4bVFqbEpKbkhOb3EwK3RNREdoRmZISmJTdTdzTWF4TjUwZS8zU09NQksx?=
 =?utf-8?B?YVFRRVhVcDdVWForcjJKM24wUDhXczd5Z3lqdzFMREprZ2gzK01ueE15cjNV?=
 =?utf-8?B?U09Pa25YWG1JUTBsc3cvQ0QwVUhUaVRJaS9sWlZOckV5Q2xyKzI1a2Fsd01X?=
 =?utf-8?B?ZGp5UGpENlRNcU5VblRGb3NCaFZKZVhsV0VNRE1ONDZWQnlieXF6b09ZUWtv?=
 =?utf-8?B?N2pGQlpveW81Zk5vb2FtSU42T21GZjlFYkJoZjNwUDVIY2UwYzR0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aadb087-3e6a-4280-49f3-08dea03f8aa2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 07:19:50.5368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE0n36Nbw+N7HdxIIuW7FJjFiFHIWVUK9imPdgxyYukT0NvjuEoqjM1aZ/5ChjJ5D4yZoKJqf+SpMmbQR9wtvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073
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

--------------bAnFseepRqlTxUlTBcZYgNCc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 22-04-2026 12:43 pm, Christian König wrote:
> On 4/22/26 06:53, Khatri, Sunil wrote:
>> On 21-04-2026 06:25 pm, Christian König wrote:
>>> The purpose of a GPU reset is to make sure that fence can be signaled
>>> again and the signal and resume workers can make progress again.
>>>
>>> So waiting for the resume worker or any fence in the GPU reset path is
>>> just utterly nonsense.
>>>
>>> Signed-off-by: Christian König<christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++++------------
>>>   1 file changed, 12 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 8f48520cb822..b632bc3c952b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -1496,23 +1496,21 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
>>>   {
>>>   	const struct amdgpu_userq_funcs *userq_funcs;
>>>   	struct amdgpu_usermode_queue *queue;
>>> -	struct amdgpu_userq_mgr *uqm;
>>>   	unsigned long queue_id;
>>>   
>>> +	/* TODO: We probably need a new lock for the queue state */
>>>   	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
>>> -		uqm = queue->userq_mgr;
>>> -		cancel_delayed_work_sync(&uqm->resume_work);
>>> -		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
>>> -			amdgpu_userq_wait_for_last_fence(queue);
>>> -			userq_funcs = adev->userq_funcs[queue->queue_type];
>>> -			userq_funcs->unmap(queue);
>>> -			/* just mark all queues as hung at this point.
>>> -			 * if unmap succeeds, we could map again
>>> -			 * in amdgpu_userq_post_reset() if vram is not lost
>>> -			 */
>>> -			queue->state = AMDGPU_USERQ_STATE_HUNG;
>>> -			amdgpu_userq_fence_driver_force_completion(queue);
>>> -		}
>>> +		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
>>> +			continue;
>> If the queue is in prempt state and if at that time we are in this function we should still be doing force completion for work in those queue else the waiters will keep waiting.
>>
>>> +
>>> +		userq_funcs = adev->userq_funcs[queue->queue_type];
>>> +		userq_funcs->unmap(queue);
>> GPU is already hung if we are here and observation is we are unable to unmap as we have tried to reset via the fw and that failed to atleast thats what i have seen. Could we skip unmap ???
>>> +		/* just mark all queues as hung at this point.
>>> +		 * if unmap succeeds, we could map again
>>> +		 * in amdgpu_userq_post_reset() if vram is not lost
>>> +		 */
>>> +		queue->state = AMDGPU_USERQ_STATE_HUNG;
>>> +		amdgpu_userq_fence_driver_force_completion(queue);
>> we should be calling completion irrespective of queue state here. The GPU atleast the queue is hung and fw has failed to reset. We have to release the fences by foce completion.
> Yeah, I agree completely with those require comments I has similar thoughts while going over this.
>
> I'm only driven by bugs here and my goal with the patch was to remove the obvious deadlock in the function.
>
> Somebody needs to sit down and go over the whole handling for GPU resets and make sure it plays nicely with user queues.
>
> Regards,
> Christian.
For now this is what i think we could do.
In the loop: If a queue is mapped -> try unmap

Irrespective of the queue state:
Set queue to HUNG and call amdgpu_userq_fence_driver_force_completion

Regards
Sunil Khatri
>
>> Regards
>> Sunil Khatri
>>
>>>   	}
>>>   }
>>>   
--------------bAnFseepRqlTxUlTBcZYgNCc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 22-04-2026 12:43 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:e70355c6-778b-46d9-bf29-cbbb4adc9d0f@amd.com">
      <pre wrap="" class="moz-quote-pre">On 4/22/26 06:53, Khatri, Sunil wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 21-04-2026 06:25 pm, Christian König wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">The purpose of a GPU reset is to make sure that fence can be signaled
again and the signal and resume workers can make progress again.

So waiting for the resume worker or any fence in the GPU reset path is
just utterly nonsense.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++++------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8f48520cb822..b632bc3c952b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1496,23 +1496,21 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 {
 	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm;
 	unsigned long queue_id;
 
+	/* TODO: We probably need a new lock for the queue state */
 	xa_for_each(&amp;adev-&gt;userq_doorbell_xa, queue_id, queue) {
-		uqm = queue-&gt;userq_mgr;
-		cancel_delayed_work_sync(&amp;uqm-&gt;resume_work);
-		if (queue-&gt;state == AMDGPU_USERQ_STATE_MAPPED) {
-			amdgpu_userq_wait_for_last_fence(queue);
-			userq_funcs = adev-&gt;userq_funcs[queue-&gt;queue_type];
-			userq_funcs-&gt;unmap(queue);
-			/* just mark all queues as hung at this point.
-			 * if unmap succeeds, we could map again
-			 * in amdgpu_userq_post_reset() if vram is not lost
-			 */
-			queue-&gt;state = AMDGPU_USERQ_STATE_HUNG;
-			amdgpu_userq_fence_driver_force_completion(queue);
-		}
+		if (queue-&gt;state != AMDGPU_USERQ_STATE_MAPPED)
+			continue;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
If the queue is in prempt state and if at that time we are in this function we should still be doing force completion for work in those queue else the waiters will keep waiting.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">+
+		userq_funcs = adev-&gt;userq_funcs[queue-&gt;queue_type];
+		userq_funcs-&gt;unmap(queue);
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">GPU is already hung if we are here and observation is we are unable to unmap as we have tried to reset via the fw and that failed to atleast thats what i have seen. Could we skip unmap ???
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">+		/* just mark all queues as hung at this point.
+		 * if unmap succeeds, we could map again
+		 * in amdgpu_userq_post_reset() if vram is not lost
+		 */
+		queue-&gt;state = AMDGPU_USERQ_STATE_HUNG;
+		amdgpu_userq_fence_driver_force_completion(queue);
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
we should be calling completion irrespective of queue state here. The GPU atleast the queue is hung and fw has failed to reset. We have to release the fences by foce completion.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Yeah, I agree completely with those require comments I has similar thoughts while going over this.

I'm only driven by bugs here and my goal with the patch was to remove the obvious deadlock in the function.

Somebody needs to sit down and go over the whole handling for GPU resets and make sure it plays nicely with user queues.

Regards,
Christian.</pre>
    </blockquote>
    For now this is what i think we could do.<br>
    In the loop: If a queue is mapped -&gt; try unmap<br>
    <br>
    Irrespective of the queue state:<br>
    Set queue to HUNG and call&nbsp;<span style="color: rgb(220, 220, 170); white-space: pre;">amdgpu_userq_fence_driver_force_completion</span><br>
    <br>
    Regards<br>
    Sunil Khatri&nbsp;
    <blockquote type="cite" cite="mid:e70355c6-778b-46d9-bf29-cbbb4adc9d0f@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Regards
Sunil Khatri

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre"> 	}
 }
 
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------bAnFseepRqlTxUlTBcZYgNCc--
