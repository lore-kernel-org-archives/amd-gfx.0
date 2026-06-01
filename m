Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A3BCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 14:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 583911133F2;
	Mon,  1 Jun 2026 14:20:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QPFa40bs";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FC8E1133F2
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 14:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOeq2dUiA5G/g6q30FowSepxXV1k1KZzgbfe2TSZDixkwiHr4Szj531BOHB17poWmE60QIxuZaaUe403gpEv2drrvsLRNy+d8rriMtFOl3VTxnz4RSLljkntR/cWsjIVUZLyCclfjmoZUocz4VTaBiGZ25rWb8UPW3bwa8isyRVdBqXg9qHlQFpzYy8LvkCYI3fGgZF8OpqQE41ERn1aLb2bYILtRXM2TmYa4PjSL2y8AMDOMXfwIg6AmfE+J+UnQAo34xXRxIkWXOcyds+UTkV7v9rgOAU4T0AuMWEVxZcMUM6t7zRxOD72AZ14R75/OGD+CmwZq5jlF62IzRUjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrzODqdGnwoa01Ydr/Ytzuw+GsPvz5Ge4Pztp5Ys/uU=;
 b=NWm8lL94iY9ze0cbyzgwdsf60jT8v6VI4uU8x9d12oNhiXqusApcFdtnSzTB23vA4WkTeSnIPyzYPLQ23Kgp7Z+MS52F6tIlbzqV6hSHAtN9/YA843INPbRGPryQo2K0YKfYVxRdKNf2GscoyEj5baveGpP4NymI5CWT2nSfc+ssSchmOixbH2D2wJQn8Ys+InvTCfoxmWNU9QSgrW7NHrx1ANjHZ90pbF6RJHwu9VBGmDD4ULHlmENKvPa9vFq6CZwWd6dDV9s6fe/49QMrK1n7fh29kTsgvrMy3rF30rrSUOcOkFPrM0bNO8Ka959RQATwtUodMf1jo/Gvpt2BAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrzODqdGnwoa01Ydr/Ytzuw+GsPvz5Ge4Pztp5Ys/uU=;
 b=QPFa40bsMXFDyONjKpUZmXGB1ILBzgYQ7flVc5YawoaoyLMCZ1+q73tbneYjFOxgitTeG54GXKr37vRoX+CI0yzLNr4o3LY2Ea230cpy2ItZu7zchh1bayiWvi6gjk/PN62IWEG6vOmTq3hwf2NeItD4Jj7+2tINLms58a/cmlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 14:20:38 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 14:20:38 +0000
Message-ID: <365bf4c3-9c6e-4fd4-99e0-32094cb37847@amd.com>
Date: Mon, 1 Jun 2026 09:20:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
To: "Huang, Honglei1" <honghuan@amd.com>, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Vitaly.Prosyak@amd.com,
 Jenny-Jing.Liu@amd.com
References: <20260529073544.614561-1-honghuan@amd.com>
 <5296dedf-df7f-43ca-9987-6e314fd90073@amd.com>
 <59558fba-db1f-4163-9e55-bd306112f0f2@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <59558fba-db1f-4163-9e55-bd306112f0f2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:610:b2::7) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: d8dabbf0-1629-4603-d532-08debfe8f3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: wps+PDsAZvu1SXJABbYL0rNJPzS+c3ZjzaS/vhQ2GT5OgR21pV49eC5CUtWCSuVSEVYIEdHfcof4r0EdubeGtXEpfjM7tP2us4aaJ5yLbKopLWB7jd1g4MozINLT42QJF4eYuQcsz+VIftEjGLbBnTPF0LNTjq0OWuGdhZidDdL94w1G7gHmFom7FXblmNaF1RAJkuqeyqN9uh+5eX5gLtUjhT+DUOArhexxWMJKI+IkIrHZsH9PC5L1zZGfetxgxZsnzlHYv0v2SkBbL1wzfHQ1pv+7bsGApPhJDI3Ky1tIKEaftzjELgZNF4PeYHClBnVR14b7RnPETPbsKS7Iiw6xqvwNOoLGO3ABXZQ15RtSSuO6SWCpmvokkMlTp3Perz71TtFfRss47r8u8vAVtQ08cxaU8uF50yA1MzMTrWSu7hADjvVSe1parEYLQw7JoeiRItHCVUBApcahH3R+hrap/cwvWR/nafBDUMWVAFZ+oMm7cP1yvv29zsEepg+lEhcL1NigTShk2OpbggfUkwOI/aiRXI292X38VekaCia0KP0ry6+h6ZFwtOj8AVWkUWxig8WDjWx07PvyDSOSV18TJu1PhhrCe9Qjn4OevkjYek8sgPeTgD1tV/iCbWvf/GqZtEjxnt/dNzje0W6dQQWidFk2guuBOk4PUyHFhfbPgt6vjI8PcVrcniDQ23d1i9mADzJ2zxsyOQYqzKFNBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmJYVzlGMVN0MGUzMkxzUTBML2gydUZaU0s4bWZnVzQzN0F0YTNxbmxIakZ3?=
 =?utf-8?B?Z2tjWnkxSmR4UVhQOWFjVmxDelg0ZEU4WDI3aWdIdUNSQlBlSStuVm9IR2xQ?=
 =?utf-8?B?TjFRcUlrdXRVa2JwQnJpd24vNUFEMlZiMUF2anhHQlNYRjBSUnlPSEVNT08x?=
 =?utf-8?B?WFVQakV0dml4TjVYYWpDdEY2QU1JSno0U2VwTlg1eGJSWlRiSnJpTEllemZz?=
 =?utf-8?B?UXpqd3RBZkZqcVVUUTBsRml1R2pJS2JRRkUrc2JuVS9zV2ltdVVqUUhCbDEx?=
 =?utf-8?B?R21WQURYVS91d1FnUGJlTjNabitOQkFLcWxJeThDOHd2eWVhbW1ZbzcwNnY5?=
 =?utf-8?B?OE95YVRxdFk2NGsyMGR2RnlSOXlLd2xWRUwyTGxrR1JvQlZoampWTXI3Y09o?=
 =?utf-8?B?VFFaSUNDcmtYRzE1OFNrUFJ3ZStCcUJsWnNnTnRDQ0pDaG96ZGlEcExVc3RE?=
 =?utf-8?B?YTN3Y21rc3loYjVCZzdpdDZ0cWp1ZXA3VWNoSUtybFo1elJOSnZ1bUhLRmh1?=
 =?utf-8?B?TU5wS25ObGRSOHpDK2VKY09VRHg1eEtuTUtjOXIzQmhNUXkyT09nZGtGSVk2?=
 =?utf-8?B?aUpubUhsbWlOU0ZidlN2RjNEcHpQQzZUdW95UVVaNldxc1NSZFNIUFl5QXlt?=
 =?utf-8?B?U2NFcHNCeVdQSWhpcVNvOStwdVIzUXBObjA3OXZBa1dvRW10MnFXY3A1TGtK?=
 =?utf-8?B?eFJ0RCs4c1RQb0JNY1lXaWxwYmJGcjNoMkNxMkNYbEZpNDVJTzEyUnJKQmda?=
 =?utf-8?B?SnNmSS83ekVMSHdOUy9tcVhnSmRIQ2RJMTZiWmJtZFRnOTRnaVhUSHRpdnRp?=
 =?utf-8?B?Z1Y2QWdzajFEZzhCT0lITFEzelg0NkVhN3lISjVaeHNjTVdWK2U4U05IaFpp?=
 =?utf-8?B?Rm1lVy9EMk01VlZYdXR1UDRXWjNpMGxkUnRCNDNTZDVaSGNpK3MrQXlxYWVa?=
 =?utf-8?B?OGJqdHJhWWNiUnJrVmpha2VlajRJamVuMENVUEhUeHNhaGRHK1pHdFRrTVBD?=
 =?utf-8?B?dW00QUR6TWo0aWg1MzV6dktlNU9DUCtwSU9aQnRLSy9DVkc3dDFLc3IrSSt4?=
 =?utf-8?B?YjdwV0tWSFkrSjFCcU8xenMra1YvaHR3MFRSc1BNVDNYd1g1WVlJb09zMmlJ?=
 =?utf-8?B?R0RLZEVzM2FPbU02OElEckFxcVoxc0FmRGJpSWt4dHJXWUZONzNVYmpxMklP?=
 =?utf-8?B?TTJnNmRVKy9scVVyMlM1ZDRpV3BySVloaUtsdzRQNk9ETEMwVVJUQkUwRkhB?=
 =?utf-8?B?ZHVOaWNOUTBVektKVCt4OUZBUVFnbGFnRCt6RlBKT3pwb1dQOHZLR0NoR01C?=
 =?utf-8?B?Yy9HemdoRk8yNmNVbllkejU5bW1QUTFjSDJUWWhJOGhWM2dnNnppTkdYL25x?=
 =?utf-8?B?RXllVWhZZi8rZlRWNU5VaEl1a0szeTl3eS83TEljYTRqUmpaMU4zaXFvU1Zt?=
 =?utf-8?B?YWZXU3dPZ3RyZFZJYTRGL0s5V0h6SFZaVGtMVk5OenZweEdrdk5LbEVXRU9a?=
 =?utf-8?B?RXMya3B4Q1JrUkxjT01YVjNoQnZzdHZCLy9lNUc0eHpSN0plaTdGTVYrTTF4?=
 =?utf-8?B?YWptSy9xUHdOa0ZUWkFTdlRRL0w3ZDNiZ1JOL3h3V2dqR0NlUzFoMmdseUJX?=
 =?utf-8?B?K0RHOVQvb0FObXM1MDZuWnpKY1NFUjdwQnJ5VUJ2bFRnWis1NUpMaXB4M092?=
 =?utf-8?B?TVdUWlZOZ2tzVW9ISkRWYjJUOVJNMGY3M1U4emJTMXJwQW9xOEJSRnFNY2Jv?=
 =?utf-8?B?c05hYml6RnRBSU1LM1h4VXZxVWFRUDZHRGk4MkxRUVEyb2ZoQlZTVVQ4cVNF?=
 =?utf-8?B?U2NYWUNPZEt0dCtmVE8rNUV5K1U0ekRNc042c0U3ZEN6UWIvYndkUmp1TU5p?=
 =?utf-8?B?K21lQkZCZGZ5S0R5ZUM5aG5DU0tyOEIwL1NhWFFwRktHTUtxVzJTcHBacVJD?=
 =?utf-8?B?bEJrRjhmaVdiVnlNZnVrOEFDV1FWMGxzUUw2aW8rUUZoaWNwZWk3eVVjTGxO?=
 =?utf-8?B?T1Y3cVhJUHNRVE5iamI5SnBndS8xdjluTDhzSXFFVFpXS2FLdTlZMXZqYVhX?=
 =?utf-8?B?OW9yYVJQcnVZeFBJZWZDckxzQWRLdVlrNzRodmxBaE5PbVg3WTBNWXRnVHB1?=
 =?utf-8?B?dWJ4UGZHUHFuNFNENC83WDhxaFc5SVZZbDlHNWVtakwyLzZpSDZ3aFdONXc3?=
 =?utf-8?B?cExNWGxZTktpSGwxRjJVdG4xemJmZ2pZc2QrYUZPOUtqNDU5QWU0ZDA4MWVN?=
 =?utf-8?B?c1ppS2JqT3hLcGZ4MzFVS2xhNE1pY2ZRRnNKS3lKVzY4TWlOR01QZEc4QXU2?=
 =?utf-8?Q?I6R5SzHLpLW4G/FLd9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dabbf0-1629-4603-d532-08debfe8f3fd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 14:20:38.1939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SevTS7FZ4Vd75qCMiXJbtk1AWbfeLThIU3qfp/8LivnitbjY0Oz2C7BCSYoGmKzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
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


On 5/31/2026 9:40 PM, Huang, Honglei1 wrote:
>
>
> On 5/30/2026 2:35 AM, Chen, Xiaogang wrote:
>>
>> On 5/29/2026 2:35 AM, Honglei Huang wrote:
>>> Since commit 144ba981783f ("drm/amdgpu: fix 
>>> amdgpu_hmm_range_get_pages")
>>> moved mmu_interval_read_begin() out of the per-chunk loop, the
>>> captured notifier_seq is no longer refreshed across retries. As a
>>> result, the existing -EBUSY retry path can never make progress:
>> "retry" should come with mmu_interval_read_begin. The commit 
>> 144ba981783f move mmu_interval_read_begin out of loop, then "retry" 
>> should also be moved out loop with mmu_interval_read_begin.
>>>    hmm_range_fault() returns -EBUSY only when
>>>    mmu_interval_check_retry(notifier, notifier_seq) reports that the
>>>    sequence is stale. Once the sequence has advanced, the stored seq
>>>    will never match again, so every subsequent call within the same
>>>    invocation returns -EBUSY immediately.
>>>
>>> The "goto retry" therefore degenerates into a busy spin that simply
>>> burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window before
>>> finally bailing out with -EAGAIN. This is pure latency with no chance
>>> of recovery, and it actively hurts the KFD userptr stack: the caller
>>> ends up blocked for a second while holding mmap_lock, only to return
>>> -EAGAIN to the restore worker (or to userspace) which would have
>>> re-driven the operation immediately anyway.
>>>
>>> Drop the retry/timeout entirely and let -EBUSY propagate straight to
>>> out_free_pfns, where it is already translated to -EAGAIN. Recovery is
>>> handled at a higher level: the KFD restore_userptr_worker reschedules
>>> itself, and the userptr ioctl path returns -EAGAIN to userspace.
>>>
>>> No functional regression: the previous behaviour on -EBUSY was already
>>> to fail with -EAGAIN after a 1s stall; we just skip the stall.
>>>
>>> Reviewed-by: Christian König<christian.koenig@amd.com>
>>> Signed-off-by: Honglei Huang<honghuan@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 9 +--------
>>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> index 5d72878c8..229c30867 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>> @@ -172,7 +172,6 @@ int amdgpu_hmm_range_get_pages(struct 
>>> mmu_interval_notifier *notifier,
>>>       const u64 max_bytes = SZ_2G;
>>>         struct hmm_range *hmm_range = &range->hmm_range;
>>> -    unsigned long timeout;
>>>       unsigned long *pfns;
>>>       unsigned long end;
>>>       int r;
>>> @@ -199,15 +198,9 @@ int amdgpu_hmm_range_get_pages(struct 
>>> mmu_interval_notifier *notifier,
>>>           pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>>>               hmm_range->start, hmm_range->end);
>>>   -        timeout = jiffies + 
>>> msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>>> -
>>> -retry:
>> If you remove "retry" here the callers including user space need to 
>> redo the thing. This function's work is memory validation. It should 
>> do that in its best before return to caller.
>>
>> If user space is the caller there would be a lot of user space 
>> from/to kernel space context switches. That will make the procedure 
>> even slower.
>>
>> I think we need keep "retry" inside this function, but move "retry" 
>> out of loop at mmu_interval_read_begin.
>
> This option has been discussed in 
> previous:https://lore.kernel.org/amd-gfx/a8ded005-e2d8-4163-be35-f1b018cefe74@amd.com/#:~:text=%3E%3E%20What%20probably%20needs%20to%20happen%20is%20that%20we%20need%20to%20move%20the%20retry%20label%20or%20just%20completely%20stop%20retrying%20at%20all.
>
> Why drop the retry here is because to keep the behavior unchanged, the 
> current code logic will always return -EBUSY when goto retry path 
> (pages change when get pages).
It is a regression introduced by  commit 144ba981783f. Why not do "the 
retry need to be moved to the start of do while loop, the entire fault 
path need to be done again"? It is same as I said here.
>
> And there is a scenario of extreme conditions where a huge system 
> buffer attempts to use this function, causing the function to retry 
> indefinitely, for example, with a space of 60G, it will always gets 
> retry again and again.

Having callers decide to do "retry" does not fix this problem. The 
callers have no idea what is going on inside low level code. This 
function(amdgpu_hmm_range_get_pages) knows more than callers, then 
better to let it make "retry" decision, ex: 
if amdgpu_hmm_range_get_pages has retried more than preset number of 
times or lasted more than preset time it can abort and return error.

If user space is the caller there will be a lot of user/kernel space 
context switches in the scenario you mentioned. That people want to avoid.

Removing "retry" from amdgpu_hmm_range_get_pages does not help since 
callers have to decide whether do "retry", but callers have no idea what 
happened, also it has performance penalty.

Regards

Xiaogang

>
> Maybe it is about the overall architecture, the set of hmm function in 
> amdgpu needs to be size limited or it needs to be cut into smaller 
> pieces if the interval specified by the user is too large.
>
> Regards,
> Honglei
>
>
>>
>> Regards
>> Xiaogang
>>
>>>           r = hmm_range_fault(hmm_range);
>>> -        if (unlikely(r)) {
>>> -            if (r == -EBUSY && !time_after(jiffies, timeout))
>>> -                goto retry;
>>> +        if (unlikely(r))
>>>               goto out_free_pfns;
>>> -        }
>>>             if (hmm_range->end == end)
>>>               break;
>
