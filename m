Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CD5CD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 10:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27B9C88C11;
	Tue, 16 Jun 2026 10:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oYrZtgb3";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C2C88C11
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 10:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkut7Rp4iGUDDwmurRhNpFhCLBl437obzGuYf4EUGpX9FQuItlVUG249D8yXCa00TVN0aYqiLuXuF+iZAsTwtreQLSQYBrletwd2Y2gqv7jrKDleqdS2dTqAjAD5Qt50vffQUA7VNEZ/Iggsca7pt/nDVtWxAkEGW+THSwj552f4Hi21LoQvplA30vfH+Y7fYbqoDbN/QE8H45udctKiow9Qcze2eQOV+tFMKLa71UO7saKzJZ9tXJLRYhjqY5Mlk+6vkVBQNhKRGC5HKE9pC0radExkARQwQrZjsRHmcfSYDsxR0Dlr8AVdaE09Vv2fQvILoJbLfmMZ23w5DvEhOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhrxoeNE4QhqEJXFRdAnaH6gXhrDzANLgFMrTjN1jl0=;
 b=hZjCyC31TOaMK5S/72H91FD4zRFtvBeDfFkIND2w1Pu9Ol9w65KvAjrdNVZyu4NQlvSIMDFxdS0GAI9LRgv8yPjQtjrKlFxJOiqG54m2UB5Sy/gW1gCeJCUAxn2hIi5OtQhE4oZTJQJ6dfW7mqPULq6saA+4Nv9bE0F70I8aRh/YwEAbbMeOP2AQYauuB+Gj76Km6cTymjttSC7FlSU9kpkTwxKcZdMnhJovBmd3QfE5mjJ7lI9zBTW5atFmoZ+EWLLGOziaCEdNZ09SK9gQqVZmX1p/FFH60dJ6aURlU4tGRDkzakZj9NhWLVypvDexPg7ekQ8zyxvAcYZHf4wQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhrxoeNE4QhqEJXFRdAnaH6gXhrDzANLgFMrTjN1jl0=;
 b=oYrZtgb3/AKg1ulXwFRrkT7cnOXFn7X+guaejg95zW27vfWNgLlCASt0miuRb8t7KRO/j5tsGmhQyB0vKa5KbN+lzdZg+iO/bAl/m7mrg6WjGC4CdtuUHNCW4575KLecdkPlsV/KMUss4z0oIf3yVDhgd5IDk9hc/YR+SBFkvwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 10:15:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 10:15:17 +0000
Message-ID: <eb84897e-f4b3-4638-b7e7-e8a9dc787297@amd.com>
Date: Tue, 16 Jun 2026 12:15:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/amdgpu/gmc: Don't compare page fault timestamps
 with other interrupts
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
 <2805750.vuYhMxLoTh@timur-hyperion>
 <0b18193b-9f2d-4ea9-8db3-08579325ab0c@ursulin.net>
 <10078559.eNJFYEL58v@timur-hyperion>
 <c3f7ba5b-ce84-4626-b772-1e7d656aac93@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <c3f7ba5b-ce84-4626-b772-1e7d656aac93@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a98b90f-cf6e-4efe-3681-08decb9029fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kg3SuRd/mFeqf4v/txgy7zLvfENiTn8rZ9CusU9y5SBdnXM1i03cYx3uadKzXSEobdPXYGzKw4Lmm6L+N529X0CGME+b7r+A5WoufYefYHPOeOJzc2VJGNuxZK8wBl1PYo689aI6RaDkOhanLgoAwiFmvD1LdOxSWoy45agakLeEFSdhVQEg9Ky+MTPtEa6al1NkaVBAvZujWtDOkBCkmVESDwvnOFwAnWV0JyPfcsrDJn2zEM/wJAhVK5ciCs/y8foKlFGnm7IbB/DVN+lxD4RSRqtEB8zVpDtVHHVGBk+lZ2/eDD4vo9/ac521U8uLlK7xa1WRBidH/MV77mG97uYT+cyk58i97SjmUJfI31R2hMMXB264CZfN1kBgl0rq/E579OAg04WTlVOEsHnsgR8WcLlY3m6cfkX/pDddAo5e+GzQpcK7bHUpJxmYEbd3TuwBjUmScm6VUgXD6Ot2jCIYl4HSVeeG09Ray1meVu/CCGFrsLsoQzwKFiK5fw5nfKy81Q8bqOdugOkIP8gCKHJEhK/xPCCNPxzvm3rEohN2RERaKk1/sV4oqn8P/P1It/l2zB6Wz0RaUB/mpezD3xtDKN9gfx56RTMlCi+VP/fYmt3vs5rD+jlvXRyuOeBXio1+LpdzhzbN3qP/TDbzkaDOh8KYNfjwXqYUSdWUGXTS4zxsX6zi4V9Gfzs5r/Rm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3MvbnlERzBLWFFBeVUvZ1FFMWMvdVQrQkJka0w4UlQ5VUxsMktLdzFmeW9m?=
 =?utf-8?B?dkE1b1hFeStvQit5NitNS3JNYS9LeXRhUEY5enJkcEVKaGE4NXl3NmlleFpl?=
 =?utf-8?B?UCt4QjFtTUxUN0xsdGxYVTBRV29lQjdJWWZocUpoZFhOL2F0TlhGaXArcFZu?=
 =?utf-8?B?T2hPcmI2b1BIRmQzRjBRbmV4TmY5T29rbUN2dHl0Y2loL3drakxLMmZCOHVB?=
 =?utf-8?B?MitCNlhOK1BFSWVjSStaYzNsbjZ1S2tKTGpSdlY0N1dLOUVjaDBkVmRjbTVD?=
 =?utf-8?B?OU9yVHVYbmZmU0RkOXBQRlZmcU5aYWJxcEE0c3dOdTJPMXBWMVdwSkFWdnR1?=
 =?utf-8?B?QnFyYU90VW5oZFhFNlpDTnRXSzBKb01mMXJIVG5pZE9HMUkzVC9YWFZFcUN2?=
 =?utf-8?B?aCs2cGxDYXkrWmdscEljbGhzdjM1a1UwOTFQT1hQWEs0bDdGeHRWRWtVSGw4?=
 =?utf-8?B?L3dzUThnWVNEdU9ObDNUVXJLSFFMUUNJTldUTnI5T0RNM1A5Y2lWbkxUL1RG?=
 =?utf-8?B?RlZzUGdZVUI4MTU0bGs5SFoxRTNNSGd1SXp6VGZtQmw5ZWdRdmw0UFZKL0xk?=
 =?utf-8?B?cDhzTDZabE82VENZajRlOTlEZTJobHBUalBmaGJwMWRvTDVGY0hvb2pBNldD?=
 =?utf-8?B?SGUxS1o2N0pjd3dzRUJVQmlrNFZLMnZSSHdXeGF4eDI2Z0pDTm1hYXdEbXJS?=
 =?utf-8?B?ZkpKcXZLWWdiTHNRcy9teFhWbVFTdTB2UDRscHlTWEcvcC9SazJPdHNCUTVj?=
 =?utf-8?B?aVdUbHRMSTh3bWRFZG81eWpCYUNOR1cxcFd5TUNLWmFETUFudVlTUWc2Y0lR?=
 =?utf-8?B?VGN3NlVGQXpUOENWZkVGSGNPMlNVbTdVODV1UjV1S3pJcUo3RFN6WTV3dERO?=
 =?utf-8?B?UHJvY2M0YXJReFpDTmZIeXFVZ3JDbnIzNkRiNzU3OCtHaUdjMmZzS0JNalh0?=
 =?utf-8?B?K2drU1d6QWozdjBmNXoyV1B5V0hXNWZmSjZseEd4K2ZhQkFKdjNzR1p1R1RT?=
 =?utf-8?B?bTJCOWl5blVmQlRUS1lZVVdEQTBYeGJVMDNjQzFjYWZaTUp1OStJSWI0VlBt?=
 =?utf-8?B?VW9sVkl0MlZvVkZOWXpCTEpvMlRQOXhqOTRHVDFLTnVSTkdJRHg0N2VXN3I0?=
 =?utf-8?B?K2dWTFJpQktQRnNER0VwamlNV2o5Uk5HSUhFMWJzYUVNb2NLM08vVld1WENk?=
 =?utf-8?B?RTlIOUtaMkQyL2FwckVQYzVMQXBoYlVaOUtpejFObTBvaHd1NFFJdTRBek5w?=
 =?utf-8?B?aXhLR1VHcFN5bVhPRUdoejY0c25Jc3BKSTNEeDhzVUxQdzFoZ3p4Rm9ZSG5C?=
 =?utf-8?B?dXI2REcrUHhkbTZNaEVmeEFZU3dua3VKcTNWTmMwajc3TzdYbUNMOXpoYTgz?=
 =?utf-8?B?Zm15blRWMnJlR255dXBnZGlCdXQ4NWdKU3phV1J0Q1NaRmswTUEyU0U3WFd5?=
 =?utf-8?B?ckZnOU1LdDdhbUkydUhhZkpWanB3cEIxM2luMjgzWFdVVGl0RmVueG1FODk2?=
 =?utf-8?B?dWlXa2U5RGg2dE5qQWZ0WGdRT2ZYMUpRbXZycUFBTUdtMlVveUErUzRTVmdr?=
 =?utf-8?B?aVN2U0t5bERvRWk4OGZHODZseGlSS0JocmlrK1UwSlNOVU5OSlA2U2JwQ2dq?=
 =?utf-8?B?TEQ4SFpQY2tya05QZVVDZGFOYm5mMldQbXFtbTBDOUhPRHI4THVkdTZoZGx6?=
 =?utf-8?B?R2VKQ0RUTWhjQWcvSU82NW9jMjdGbi81RTdxM2dtWi9qeHF3bjhsaWt4VWF2?=
 =?utf-8?B?OTh4TzNIYVJGelI0cCtWd3JsVk1lbndNdkNDeWtEWXJWQmFlVFhzSlJpMnZa?=
 =?utf-8?B?M1FOZ0JIUUNybUVtRmJrWk5kK2tZNUpEV0RJTFllSWpVMDRFTU5XaG5JYnFu?=
 =?utf-8?B?U3FBSWJMUURiNEI0NDl3S1BOUEpSQ2dKME1jK0xrN1lmVUExQTZ0clpzd1l2?=
 =?utf-8?B?ZVNHS2ZvYjJleVdJRS9laTdTUzkvc1lMSHNLTlBtRDdDV3dPZmRiNjEzMkVJ?=
 =?utf-8?B?RTBvUVZiVG1nalhaQ3VTWEVpd1ZucnFDN00rTyszQlJyUFpxYUhXTzlRWTFY?=
 =?utf-8?B?NjZZOUNENGFyd2lFc1crSWhzWWZjMHQxRGRQUDk0c1ZSRUtBV08vU3FIdGNv?=
 =?utf-8?B?VS84eko2aGNpS29FZERSc2EvbVdMQ0lCN3RTd1hIcUsvSnoyT1ZoTkpXMVFy?=
 =?utf-8?B?d0dDOWU3aUdhYk4xQnE3SGtjY3dBMVRPNy93dWNscXk5bE1oNVhYbnlUenky?=
 =?utf-8?B?K2NJbzRIdkh2QzkzZG1tSmtYampTVDZRTCtvMHg4Zy9zZ3laamNFTXFkVG1O?=
 =?utf-8?Q?alc72S/8wm66Rl6U2B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a98b90f-cf6e-4efe-3681-08decb9029fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 10:15:17.4808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoKSJwXrVdTG4KuHdslimayabCC1kYJGsRma1n9id2dUj1hePG5VPLpkWDS9GamB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533
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

A bit late to the discussion, sorry. Trying to answer questions now.

On 6/15/26 17:48, Tvrtko Ursulin wrote:
> On 15/06/2026 16:32, Timur Kristóf wrote:
>> On Monday, June 15, 2026 5:23:52 PM Central European Summer Time Tvrtko
>> Ursulin wrote:
>>> On 15/06/2026 15:52, Timur Kristóf wrote:
>>>> On Monday, June 15, 2026 4:32:23 PM Central European Summer Time Tvrtko
>>>>
>>>> Ursulin wrote:
>>>>> On 25/05/2026 12:45, Timur Kristóf wrote:
>>>>>> Different interrupts may have different timestamp sources,
>>>>>> which shouldn't be compared.
>>>>>>
>>>>>> If we compare the timestamps of retry faults to timestamps
>>>>>> of other interrupts, it may result in all retry fault
>>>>>> interrupts being filtered out, because of the different
>>>>>> time stamp source.
>>>>>>
>>>>>> This issue was observed on Strix Halo.
>>>>>> Solved by storing the timestamp of the last page fault interrupt.
>>>>
>>>> Hi,
>>>>
>>>>> This one may require access to AMD docs to review. For example I am
>>>>> immediately curious as to how many different clock sources on a single
>>>>> IH there are
>>>>
>>>> As far as I know there are various timestamp sources in the GPU and some
>>>> interrupts use different ones. I am not aware of any documentation on this
>>>> topic, unfortunately.
>>>>
>>>>> how does that relate to the timestamp_src field

The timestamp_src bit indicates if the timestamp came from the IH block which wrote the IV to memory or the original IP block which signaled the IH that an interrupt happened.

>>>>
>>>> The timestamp_src field is set differently when the timestamp source is
>>>> different. So, it could happen that we accidentally filter out all page
>>>> faults when we shouldn't.
>>>>
>>>>> and if there are indeed multiple clock domains should the patch perhaps
>>>>> be
>>>>> generalized to something like
>>>>> ih->processed_timestamp[entry->timestamp_src] or something?
>>>>
>>>> For the context of this patch, I think it doesn't matter how many
>>>> different
>>>> kinds of time stamps there are. What's important is that we just shouldn't
>>>> compare timestamps of page faults with time stamps of other interrupts.
>>>
>>> True, thank you!

Yeah, completely agree.

>>>
>>> Another question is why the backward timestamp check is needed only for
>>> fault interrupts? I do not see it elsewhere.
>>
>> Correct, this is only used for retry fault interrupts and only when they are
>> dispatched to the soft IH ring.
>>
>> The reason this was added is because when retry faults are enabled and the GPU
>> hits a VM fault, it keeps spamming the CPU with many interrupts for the same
>> fault until the fault is resolved. The CPU needs to filter out the faults which
>> it is already handling, otherwise we would end up handling the same fault
>> multiple times.
> 
> Got it, thank you!
> 
>> (As a side note, I should also probably look into how to reduce the frequency
>> of how often these interrupts are repeated.)
>>
>>>
>>> Let me also ask two more things below.
>>>
>>>> As far as I see the timestamp doesn't really matter for other interrupts
>>>> as we only use it to filter out page faults and nothing else.
>>>>
>>>> Hope this helps,
>>>> Timur
>>>>
>>>>>> ---
>>>>>>
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++++-
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 1 +
>>>>>>     2 files changed, 5 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
>>>>>> 13bec8461cde..52258f1341c2 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>>>>> @@ -437,9 +437,12 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device
>>>>>> *adev,>
>>>>>>
>>>>>>         uint32_t hash;
>>>>>>        
>>>>>>         /* Stale retry fault if timestamp goes backward */
>>>>>>
>>>>>> -    if (amdgpu_ih_ts_after(timestamp, ih->processed_timestamp))
>>>>>> +    if (timestamp == adev->gmc.processed_fault_timestamp ||
>>>>>> +        amdgpu_ih_ts_after(timestamp, adev-
>>>>>
>>>>> gmc.processed_fault_timestamp))
>>>
>>> First thing is whether you are confident the equality check is either
>>> safe or required?
>>
>> I don't see why it wouldn't be safe. But maybe it isn't required.
>> What do you suggest instead?
> 
> Safe as is whether it has potential to swallow a legitimate unseen faults.
> 
> Looking at amdgpu_gmc_filter_faults() a bit lower down, it does appear to filter out repeated faults on the same address. Would it be safe to rely on that instead of the timestamp equality check?

Yes.

The check was added with patch to make retry page faults more resilent to IH ring buffer overflow:
commit 3c2d6ea27955cfac8590884d207353eece8c2cee
Author: Philip Yang <Philip.Yang@amd.com>
Date:   Thu Nov 18 15:24:55 2021 -0500

    drm/amdgpu: handle IH ring1 overflow
    
    IH ring1 is used to process GPU retry fault, overflow is enabled to
    drain retry fault because we want receive other interrupts while
    handling retry fault to recover range. There is no overflow flag set
    when wptr pass rptr. Use timestamp of rptr and wptr to handle overflow
    and drain retry fault.
    
    If fault timestamp goes backward, the fault is filtered and should not
    be processed. Drain fault is finished if processed_timestamp is equal to
    or larger than checkpoint timestamp.
    
    Add amdgpu_ih_functions interface decode_iv_ts for different chips to
    get timestamp from IV entry with different iv size and timestamp offset.
    amdgpu_ih_decode_iv_ts_helper is used for vega10, vega20, navi10.
    
    Signed-off-by: Philip Yang <Philip.Yang@amd.com>
    Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
    Acked-by: Christian König <christian.koenig@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

But as far as I can see the whole idea is completely broken. The timestamp can also go backward in case of a reset for example.

So having this check like this is clearly a bad idea.

What we could do in amdgpu_gmc_filter_faults() is to check some range for the timestamp, e.g. last seen timestamp (in amdgpu_gmc_filter_faults(), e.g. only faults) - value X is considered a duplicate caused by ring buffer wrap around.

Regards,
Christian.


> 
> I appreciate that may cause a transient interrupt handling storm if the clock granularity is poor, but maybe that is better than losing a fault.
> 
>>> For example can two blocks fault with the same timestamp on different
>>> addresses?
>>
>> They might. But keep in mind that the GFX block just keeps spamming the
>> interrupts until the fault is handled. So, if we filter one out by mistake, we
>> know we will just receive the same fault again very soon.
>>
>>> Or from a different angle, is the clock granularity good enough to not
>>> coalesce two separate faults to a single timestamp?
>>
>> I am not sure about that.
> 
> I guess if the equality filter can be removed then this concern also goes away.
> 
> Regards,
> 
> Tvrtko
> 
>>>
>>>>>>             return true;
>>>>>>
>>>>>> +    adev->gmc.processed_fault_timestamp = MAX(timestamp,
>>>>>> adev->gmc.processed_fault_timestamp); +
>>>
>>> Doesn't a plain assign work here? The if above has already verified new
>>> timestamp is larger than the old.
>>>
>>> Regards,
>>>
>>> Tvrtko
>>>
>>>>>>         /* If we don't have space left in the ring buffer return
>>>>
>>>> immediately */
>>>>
>>>>>>         stamp = max(timestamp, AMDGPU_GMC_FAULT_TIMEOUT + 1) -
>>>>>>        
>>>>>>             AMDGPU_GMC_FAULT_TIMEOUT;
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h index
>>>>>> 676e3aaa1f27..77eb15380284 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>>>> @@ -361,6 +361,7 @@ struct amdgpu_gmc {
>>>>>>
>>>>>>         u64 noretry_flags;
>>>>>>         u64 init_pte_flags;
>>>>>>
>>>>>> +    u64 processed_fault_timestamp;
>>>>>>
>>>>>>         bool flush_tlb_needs_extra_type_0;
>>>>>>         bool flush_tlb_needs_extra_type_2;
>>
>>
>>
>>
> 

