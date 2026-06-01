Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81323CD6E56
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 02:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C531B112D08;
	Mon,  1 Jun 2026 02:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VuVFYI5t";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B70112D08
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 02:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6NiAHwBNGdI5BG//4cFs5kdVHdOL/pQsgpJcIUHWPawy1dI3SmBaVq7KK0M7t1biehP4wMQ5jk+tfn8dGGLkHFrCROxgGPtDM31FCv1vb2mmu6phtbbkRkQP6v5uS+7NHFBN65CBI0OZ0e6F6g56uhdPC+TCXyGg9d0mipIA1caPBXRNUYr7D+TadhjUzrNWqYuTyAuO0h9Q8reB7RRvVG1q9/yNPDvMdIQ9mzEaIoaCSIHvRoEGEqVOeJ1uRhitLArOC1FgGWf74vuRleHoJG+2vIptezwfDZ0Kev3hYIoGs83eGXML6r01+mLdTCVWK0uQgJt1e4NDiXgffCirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXSK084ebICmdaHPxDOLY01krN3q+zfwEqvlEYVuJL8=;
 b=rCeJeD6UquiFBQFGQgisOlKUtBWazhUpQN6dqWvziCGJl1WO5dYjBeInypCLBDBnK6O3d+uw/zGM+y2EHV6hFoEGh6SawK9tqNaZCSYKJj5c6J9RZyYjBKn55ah9FEnV4q7fYl9UwgEGoVXCgepOzAsyqYL1eRgIfH78iuocYUp8BMjhI/r5KwsqoaQUx6rVtHJ5zvcDKQD4kk5smgQ2JFIY17tYAkeKW/h8pDUNjMLUZPe1QT45EcTIf9i7PBIafTa8YAPEjqk+uxSYTKCjDHk59nGHdaOKFHjAhTYW3kfE5OwLtVmW8bR9KkN+Z0NgVzudszNiz2rNQBWFVyyEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXSK084ebICmdaHPxDOLY01krN3q+zfwEqvlEYVuJL8=;
 b=VuVFYI5tilbR1a9srX74a2tS3Kf0tavAeyNeXEwLkmMFnCwaLOdpSAXcda9V7MTaOfdyWZ8IO6uP7sHlkwmF/lXE0KTsZ0piOAQ7aZ23aGnBuHQssIPC+x3bdmGD6UABxEss1GGReJbohIariGRJTlhXJ4IgE+fDOSypugmfKVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CH8PR12MB9813.namprd12.prod.outlook.com (2603:10b6:610:260::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:40:47 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 02:40:47 +0000
Message-ID: <59558fba-db1f-4163-9e55-bd306112f0f2@amd.com>
Date: Mon, 1 Jun 2026 10:40:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Vitaly.Prosyak@amd.com,
 Jenny-Jing.Liu@amd.com
References: <20260529073544.614561-1-honghuan@amd.com>
 <5296dedf-df7f-43ca-9987-6e314fd90073@amd.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <5296dedf-df7f-43ca-9987-6e314fd90073@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0028.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::17) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CH8PR12MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: dfae4ac4-f84d-41a3-783a-08debf872f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: DJBFVxLrQHPzyJfv8LvkEaBxKkb+IUf2JERuN0SGBhg/TjkSWHp0o3WSuvus6tjiGFkXNAw5bP5k3pj7z1ksvxHiThVhJVSTRQvBXs119kq5HWCtQYGJA0JU4CVxVJQ0uzybzkixZFQ4vhnbA1aqafsWR9y0GE1X4sVmov1YiN4tmnluaCNfl1WsYaxooVjTuBE95+OtMJlZ6MTz2r9FC5jmza45KjNT8ogP66HNUJys1qvLXtijIaljw2s5GI/3kldxEWDnD+XuFOILuKOrZ8sqXhXKWPqV2H1Xqa/4XrHXm3qsBn9NTmKvmFOrVMSfwmNPupN6CN5jczCgAY5OPmZByK278rZcFPkp1zVhNqt2AMfJ+jB74LxbXCxm4M1OrPUF2+PuVj4XhqRFTpO1UcnGJaNjLY8UDRktf2z5eVH2Z1iT9VyYs9xZ3LXlicUIerHPbXUxpQL31IrrtIVMhbFG7eXtvnQhh14nQCyBtzNkq8Z7fjDK6KwlKJ6nmfOPODNx0sR/033KRwr9PayzYS9JDvv20lUH+rPdVLpmFNEosCZnm+NWTk3FELrIQh9e4jQmgtMPVsc5l7x63HlkcHb8kraCi2AfNyKCNe+PkXT39g+YQeZeMm+W4xA4vVTTLU0R8H7RdhbuaDvOdz3OSfoQwlN5XO706ddNocZyJ2ePGWiEopCmC6Ic3v9mV9CP/e716dkWjm0dnIT2sD4nNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzc2bnkxUGRxcUQ1aFBUWVlwa1REQ2w1UGdYOTZaTGR5a3UreXFVRjc5aTF6?=
 =?utf-8?B?QmVPZHpKWHhrQndQWW1GK2tVTk9leHFST0kzSThGNUJjVWpKQlpCdmdrWVRW?=
 =?utf-8?B?ME5na1c1VDFOOThWUmpiRWhYN1g3QXlyaGdjcFMxZDE0MHdPMTQ1L2RweW5D?=
 =?utf-8?B?TDVMQ0duS0dFbTBESE84RzRaOXBXa1YyNnBocndsUGhLQmYrbGoyMGlLNWV0?=
 =?utf-8?B?U20rNHNqOFdMcUtMTGRSakh4dHpBQVV0UXZMT2xka01pZXV1UGRHaHp6dnpn?=
 =?utf-8?B?OExEZTUxZkRQNGpJTFRSNExpRmN2ZTQ3OVc5d0xmNGVRT0p4aGxTaCsvVXZW?=
 =?utf-8?B?d2E3VC9kRmJBTi94ek9adGRLSVV2UnNNZ3NKVDJoU1R6MC8xZ2dMZHU1YjFr?=
 =?utf-8?B?amF0NjZaV2lOZzR3ZkR4SzdxWWZBMksrMWRuMnZVaVVLcG90ZEpKb3ZxVk15?=
 =?utf-8?B?RDdQMlgwR0c3OVVQZnBSSkk3Y3EwM3R1Z2ovc2pJK214SE14eW45MWU2aGR0?=
 =?utf-8?B?bnJjVFRJQVViVFJ6ODJobkR1cE1uWlo2V29URHZqVXMvOWtQS3hEZzhRV0E1?=
 =?utf-8?B?WVUwaGc0YUVocnU4RVR6MHNrRkV5eWpwSExjdStqQ3JIT29MZndlZjlkUFdB?=
 =?utf-8?B?b3lROUp5N0VsSnEzMmxHRTFJVTlINFZvTzlVcFhOZFZkS3NsY08zaVZTSmw2?=
 =?utf-8?B?clltVzJVbklLelRKWGN5M0lGMEtWNEZBSHZwaGlqN2FKeDJ0SDhGOXNXSFd3?=
 =?utf-8?B?Q3VZS1gwYVJubjBNNXA3MjVmSjBYS01jeTZvMnYwb1QxSnVrM0IrZ1c5ajAz?=
 =?utf-8?B?WFd4Y3FwNDA4eE5XcXcvN01wRGlWVzdud2gwNEM3Z2tNR3lHL2plSjRXelVz?=
 =?utf-8?B?bGcwZTlpb1VMTm9qSmtyMHZXTUFQSmV0REs4TDlEblhKMVhUcExqOHplS3VU?=
 =?utf-8?B?TjE0cHlWYVhPMG1kNVg5cWZBS2pwM3ZqT09LRmU3azJ3WGFGRkJ1dVBBUnpE?=
 =?utf-8?B?ZWxqOHlUTk9hOW9kRnFRQWpPeWswM1RQV2REUmplQVl6T0pZSUYrYmwrRHFu?=
 =?utf-8?B?dlhpVmlRYVg0R0xReWQzVThCS3grUEV0dzhjMUFFWjNrSGs0cjJIdmhxeXJt?=
 =?utf-8?B?Mms0UWlvb3oxNXJCVmFORHZkSUs4b2Rmb0JuS043dzR1SUpiV2xUN3JsNk9J?=
 =?utf-8?B?UlBYTmlvcDhLN3Z3ZUx6R1I3M21rTTFCYTJIbDBwdU9GSG1RbFYvdUVmTlZl?=
 =?utf-8?B?TExUVW9sdVAyQVNNcjNCWlVlMmhZbndldjRreEVIQ3pSRnEyUnc2VHJLQTRV?=
 =?utf-8?B?K29kbTk4WXR2TUxzbVcrSUJIeGYzVUFNdzFOVFl3NGlYaWEvcTd0QWE1Q3NE?=
 =?utf-8?B?dmdEMWUvdmVsK245bnRtaGEyeHhqSTQ4SGtFNHJ4cFVyZzBacXpqK2pmeUdj?=
 =?utf-8?B?SkcvamhGdWZtdTFoMHlMTy9tSkZzTFZ1U2N3SXJhd1dLM1NDOWN0RnpZVVB6?=
 =?utf-8?B?U1o5YStSS0JzUDNwMlpZSjQ0clR6TU00YU4wUURncXVGVlJYU2NwM3N4SVh3?=
 =?utf-8?B?b1JDc01pcjY1Z0JWZnRrdkx1NkRiMjZIT29haU1TRmNFK2Q0UFh1dytFRk5m?=
 =?utf-8?B?YXNacVBLaHI4VUNkZVhUemFpRVU3cDRDTXZnUklJTDJtTlNjSHh2ZlYyN3A4?=
 =?utf-8?B?dEZzL2R6NUdyWHlqVngxMlNGSnFETmlJdmZJNWVpa1pxNExuRDhQQzgwTjd2?=
 =?utf-8?B?NmxZbFJwODJySDVrWk8wejVKWDJkbVEwbUtzczY4TUxlc242ZjROTUdmZjdS?=
 =?utf-8?B?M25QTTJBcHlCaTRJVkR6YzF1L2twNHhPZmkvLzR3QVVWa3Vic293SWhYVzVS?=
 =?utf-8?B?UlZMbis4MFhGb0pNNFBkU1dhUExHd0pKbkRpOWVwdzFPRUtkSnA2VTNqTnJo?=
 =?utf-8?B?V3BPSHp1S25mZVVRZjFnUTNHbjNiNzVCNE9WbUZCbHE5M29EUVNtRG05ZzBS?=
 =?utf-8?B?TjFZa3pQVWI2b3JNOGdGOXo4ZTFIekV3YWdVbnU4RURPbzc0cHJtd0kzTEJj?=
 =?utf-8?B?NE1nRW5rR254QnNPRHNaS0tRUm5xN2F0VlhwRnhuSFJINE9VbzZ1SGhiSmdo?=
 =?utf-8?B?bXk4Y0F1S3NQa1ZHMS9aM2hjSFJZbmszRzZqd3orVTcxZ09jOG9FV3V6OUhm?=
 =?utf-8?B?eWxhSXFmV3A1YmI2MUhncHZ0aUVLZkVEd0pvVGlzZFRJZzNKVDVVS0xzTWtD?=
 =?utf-8?B?UUtMTFdNcjZnZng3WW5jTGEzQk56ZWlmbERZOGlDSlZUUDhRYzBVOHBFUDVH?=
 =?utf-8?B?cU95azcwTmJUb2EvSTJFK2gzOVVrTE50NWdjK09GbmdRRndJdnFXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfae4ac4-f84d-41a3-783a-08debf872f49
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 02:40:46.9559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTxo4gM7jwUgWXkOlnXgx8yff1L5xMVoXAYv5cCs+vubkEaamN/lwy6x0LM1RPSgo6+x05+kywby2hS5nzCFZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9813
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



On 5/30/2026 2:35 AM, Chen, Xiaogang wrote:
> 
> On 5/29/2026 2:35 AM, Honglei Huang wrote:
>> Since commit 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
>> moved mmu_interval_read_begin() out of the per-chunk loop, the
>> captured notifier_seq is no longer refreshed across retries. As a
>> result, the existing -EBUSY retry path can never make progress:
> "retry" should come with mmu_interval_read_begin. The commit 
> 144ba981783f move mmu_interval_read_begin out of loop, then "retry" 
> should also be moved out loop with mmu_interval_read_begin.
>>    hmm_range_fault() returns -EBUSY only when
>>    mmu_interval_check_retry(notifier, notifier_seq) reports that the
>>    sequence is stale. Once the sequence has advanced, the stored seq
>>    will never match again, so every subsequent call within the same
>>    invocation returns -EBUSY immediately.
>>
>> The "goto retry" therefore degenerates into a busy spin that simply
>> burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window before
>> finally bailing out with -EAGAIN. This is pure latency with no chance
>> of recovery, and it actively hurts the KFD userptr stack: the caller
>> ends up blocked for a second while holding mmap_lock, only to return
>> -EAGAIN to the restore worker (or to userspace) which would have
>> re-driven the operation immediately anyway.
>>
>> Drop the retry/timeout entirely and let -EBUSY propagate straight to
>> out_free_pfns, where it is already translated to -EAGAIN. Recovery is
>> handled at a higher level: the KFD restore_userptr_worker reschedules
>> itself, and the userptr ioctl path returns -EAGAIN to userspace.
>>
>> No functional regression: the previous behaviour on -EBUSY was already
>> to fail with -EAGAIN after a 1s stall; we just skip the stall.
>>
>> Reviewed-by: Christian König<christian.koenig@amd.com>
>> Signed-off-by: Honglei Huang<honghuan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index 5d72878c8..229c30867 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -172,7 +172,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>   	const u64 max_bytes = SZ_2G;
>>   
>>   	struct hmm_range *hmm_range = &range->hmm_range;
>> -	unsigned long timeout;
>>   	unsigned long *pfns;
>>   	unsigned long end;
>>   	int r;
>> @@ -199,15 +198,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>   		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>>   			hmm_range->start, hmm_range->end);
>>   
>> -		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>> -
>> -retry:
> If you remove "retry" here the callers including user space need to redo 
> the thing. This function's work is memory validation. It should do that 
> in its best before return to caller.
> 
> If user space is the caller there would be a lot of user space from/to 
> kernel space context switches. That will make the procedure even slower.
> 
> I think we need keep "retry" inside this function, but move "retry" out 
> of loop at mmu_interval_read_begin.

This option has been discussed in 
previous:https://lore.kernel.org/amd-gfx/a8ded005-e2d8-4163-be35-f1b018cefe74@amd.com/#:~:text=%3E%3E%20What%20probably%20needs%20to%20happen%20is%20that%20we%20need%20to%20move%20the%20retry%20label%20or%20just%20completely%20stop%20retrying%20at%20all.

Why drop the retry here is because to keep the behavior unchanged, the 
current code logic will always return -EBUSY when goto retry path (pages 
change when get pages).

And there is a scenario of extreme conditions where a huge system buffer 
attempts to use this function, causing the function to retry 
indefinitely, for example, with a space of 60G, it will always gets 
retry again and again.

Maybe it is about the overall architecture, the set of hmm function in 
amdgpu needs to be size limited or it needs to be cut into smaller 
pieces if the interval specified by the user is too large.

Regards,
Honglei


> 
> Regards
> Xiaogang
> 
>>   		r = hmm_range_fault(hmm_range);
>> -		if (unlikely(r)) {
>> -			if (r == -EBUSY && !time_after(jiffies, timeout))
>> -				goto retry;
>> +		if (unlikely(r))
>>   			goto out_free_pfns;
>> -		}
>>   
>>   		if (hmm_range->end == end)
>>   			break;

