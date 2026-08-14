Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455ACC5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CC410F75D;
	Fri, 14 Aug 2026 21:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h41y++cs";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013060.outbound.protection.outlook.com
 [40.107.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBE710F75D
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oa7G96JjppIbs/43MkV/KDEY2dmJVyFdiB5gjWJ0mE/HC8jIykTEQhUR4VysIYkQDFGgslsLR8Njv07aftFAuGptAKGlDV/fRLACjs/7KsPXBKdCVvrOsR/mYcq3qbQe2/2tHQz1iSaHTjS8hWliLf9SWcvX0qShyakyXPtjXVo2aap6aJBTlUTcrzCMwi4GfQdqcYGRggC3Harw0qS2rnaK8W58E5tPD4JuEq5YfQAsVN7T4DEY9nXjeQb50En2rHanJ7OA5vZ/M7Dx5nPyuo/+c4Q+xnExHfY+7KfYBaYXdMBy6OsaHE0B+p9xV+1c3d3o/zzwU1qgj5MjP3QRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqHT0t9En4da8vr/jNR67uXaBWhV0PvDJ1RzaQedyHQ=;
 b=urAbEbcjCJJ5UZt82meJv7xgembS7rjUyoMNDM/ZayWUv2MV6lZv53aMzj6paQjx09cEsEBNMa+LqVWtErRK9a+EknhK4mjVA2+DpAr6orwEet3Yn9s2uDdouhp9LauTLPcXkhM9/bPD8mee00M/+GtF9MjEYEAOeuWJKXL7NP9XJNMmA7g9JJ6G2/jmQk9V0Dw7yKFpsQaD/hmv3+gZGWjdSGWYPwhS8mo0c/wy9dzrt6y0snbrmPRaRVmPxV00mCIJlVQz6xM5DIWznOWaFiCnWI1hMeOSaVPD1fANPT3SdzEplW13jizQ6Yw35qFBCbnr9bDJSCPZcLtYWrFTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqHT0t9En4da8vr/jNR67uXaBWhV0PvDJ1RzaQedyHQ=;
 b=h41y++cs6V5kcJzKkuZqsta4VsrVrhORzpMY1b5/TZ1RDQp7iT0x+CXNTIHstfHOm680ByEJyxLyLG+3/sumfOg/LIf8n7wL3oS/auV5IrjD2P/zTbnqxtusq0p/SU/lAaYMCz9IN7vAbc0xnZw4EM2Jk1bpC1xKDoQ5ttwLWcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by CH2PR12MB4213.namprd12.prod.outlook.com
 (2603:10b6:610:a4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:20:19 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 21:20:19 +0000
Content-Type: multipart/alternative;
 boundary="------------KL07kNuUU9OH9ZJxhbDb9SpT"
Message-ID: <3c09d100-d0a0-4ac9-9285-ae212f51f07f@amd.com>
Date: Fri, 14 Aug 2026 17:20:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: allow profiler process reenter
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260806084312.79422-1-lingshan.zhu@amd.com>
 <CH2PR12MB94573C6D5DD3480E33E6463F8CDC2@CH2PR12MB9457.namprd12.prod.outlook.com>
 <3f62daa5-7c4c-476b-b692-0cb544e3d2a3@amd.com>
 <be92ca16-443a-478d-96dc-c83318df3670@amd.com>
 <02e91cc3-a3b1-40b0-8027-ceef0f17a05a@amd.com>
 <4a94f469-1c79-4f46-a57d-bd2aa08ef162@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <4a94f469-1c79-4f46-a57d-bd2aa08ef162@amd.com>
X-ClientProxiedBy: BLAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:208:32b::33) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: e59227c6-7af3-49cb-1d3e-08defa49d7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|6133799003|8096899003|10067099003|11063799006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UzkudX9LxD6lrWwGQx8deW01q+2x8qTKqRXOpa1tMVLrxuhk8Y8HpXtq3u8TYT2s3VJr8kfsVLG4csAItQomv7qU7ri0Qv/DDg6xtiaoE2TCsnLlxlld7FKZyIISYtCe7zALCWx5ANBEWbSfrCfM3jQuwLdyWlT+/poHpVNBKi/755V1+PEgl9YnHvd+ZrqicovbhsyZV+E9o6QCKCcS8vcCV8Dx7Ve0Aopa78siSB4+EXdTsXpJ+sisEXPa82K6qNyLuPODnccpT6emPxQuXYYZbMSJGlnuz4qYe56txSKu2ZTQAuWQJ+g2ay99rLUy0hkf66omRvscS7DCLc2WAh8YjZ+kO9QqPJk0VNaYwcMI1NUB+pI23yDQa6MJ2NZbpy0GNDKemyGph4quFU9dYDq4IzjYDoVIwsvHRq2GhbyoXi/rMVcldRXXfptm3FKDBrjk6Whi52hxvYQicMhQXS9STQrnFQGvpyFhw5qPrJRUYnyf9Z/vnZGe3rS0pSH7UoggjxEJ7EkovrHaiiGtFWfkZh3Mxhq+8tYb1Txt8hXkEQ8bIznYyejk7pM8mD735n2ppbcNsNNbu6WduJ6VfRrLh91SeazBIdaseUzaqpSWjx3p5ReP24FDwAQ0d6zDXSTz6gABStw4vJZ3PTVkvodzdlkGYhFL3O/OWGjf2P0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(6133799003)(8096899003)(10067099003)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGViWXlNT1JCR1lzNGd4b2c2YXU3UzlIMHNXZ2c4VkNmdUJnRUxaY3hvSXBk?=
 =?utf-8?B?MU16RWp0M1NJcFdremtCM01tNW5CVVp2ZitmS0JEWDBWK3o0WUU0dXovQ2NF?=
 =?utf-8?B?T3pCWGlGQklkeFZyQ0ErRnJSbzN1SzBNRHFKdUxySjk1Q2JyQ1p4QU5sRUl0?=
 =?utf-8?B?bk14bitOWkF6aFFuWFQ1c2lSNG1zbG5mNy80QmlMY2I4ckNWa1paZFhhanVK?=
 =?utf-8?B?ZjY1YmxvN20xNU9KOXhyL3RSSEQzaVRMVzVjelhUaENJaXlwYXJPQXZsbWg2?=
 =?utf-8?B?Z0tzWHF1SlQ5ZE93QUdaNEI5NENtck04TEErNW8zQVJnems3Q2xrVG5pbFVa?=
 =?utf-8?B?d3MyNVU1VEFVSnJQQzFmR0ZoNzR6dGNtUVBGTWE1bENXWEtuNkJnbUZLc252?=
 =?utf-8?B?UzF1WWRCdElKbkVKTEtobU5PNnBveTREYnREZHpQUGp5dVMxb2xSaXkzZTVk?=
 =?utf-8?B?MWlxM28yeWlzTW9WYkM3M1o0YW5kTGQ1RXdZUFlSamFGZ0lRUjA5SjZLUlJJ?=
 =?utf-8?B?VzJqNFhYZ2wxZFUvSnVXQjVRMWtBNlZkTmJ2Nm9IT1lNRlV2UVd1dy93VGdz?=
 =?utf-8?B?RDk2ZmtkSVpPVUpIQkNyNkJKSU1MdTBlL3N4eUh3WDZwUWlFaVhmV2lWditB?=
 =?utf-8?B?UWpmYkJCM0oxMmpzMXVMcFVHRGhBbE9mdWs1N3pCS3A0dTZZYXNCQTRKcDB6?=
 =?utf-8?B?UDhIdDFkcmV0b0xUVVBHNHY0dUFxcTNrNTdZUW5GaGs5NkNhWGlQTjkrdG9P?=
 =?utf-8?B?b1orYnNyMm1uQmJ0TXlERmtySHZ6Z244YzNHOW5qNjZWeWlJd2l3YjhmWFF1?=
 =?utf-8?B?WEJLZi8waFJ6cUhvMFlya0pYVHVjZzhySS9rV1RBVjRWUXA4S1ZpQVlTNmVO?=
 =?utf-8?B?WDdtclR0eUpIay9kV1M1NUtXbDE0SU0xYlBSZncyT2RUSVJLcGdHVWxHaWJD?=
 =?utf-8?B?ZWkvTDVZY0hpV0Noamp0ejJIWDBHNXJWK1REL1BFZ3R6bWJ6MGNBZ0poYVFY?=
 =?utf-8?B?SVB2RE1CdkgzRmFoYmZxS0ZlMlIxS0NDdU5TOVYxeTVITGN0eUZqT3h4bXJh?=
 =?utf-8?B?WHRMOGVxNE5aR09mOTBoWGsxbHNBL0paSjZ5cGxtb3N4ZG44aUlOQzhUWUZt?=
 =?utf-8?B?VXFLZENLUCt2TG40N0Jpcm5pRUdsTmZ1MzI2QlRyZnpDdGRxazhsVGM4Rmpi?=
 =?utf-8?B?OWtmRTFMYTROUlZjTVRXY0hqRUFIZ2dsL2dmNHRCTlo2bXBEWFAvV3RLRU5s?=
 =?utf-8?B?bUxpOWNNUFlWTUJ2YlIwckpKcE9YQVc2bW9WbjRWOHJnOUlhcWpjUFZGQWFW?=
 =?utf-8?B?bzhJNk94bXV0WTNucDQwaUlRMG0yT0RLbVBLeEZuRUNaTGZncnBqVW5iS3N4?=
 =?utf-8?B?M1VaZkJndkVpOVhKNTh1YzVPSVlKOTd1SUU1dFo2YU54eSs0R3IrYTBTcVVu?=
 =?utf-8?B?YUpheTNyVlJKcGxCaUVGblh5L3dMbjR1ZVV0SlNmd3ZLMGV5TjJ2eHZYQmEw?=
 =?utf-8?B?L3R4TEVnWnMyY01iMWhpQzhrWDl3eFNIaFlqZTZmQmlMZ2VsK3ExQUtaYWhI?=
 =?utf-8?B?a2FsQjJOZWJ3enhJTnJLUXNReW1mZWYrZG1qSnZZcUU2YWhDZXJiUGxYcUZE?=
 =?utf-8?B?bjlqYTZwYWlmb3pId3Z6VVpyQm11amtOZi9wZFFMeFdFenZDQk1acm84bUIx?=
 =?utf-8?B?Q1VwdTJXdUE5cmYwaEU2cDVhenIvamZ5cGRsdTd1UmZ1T2JBK1MxQVg3V0dh?=
 =?utf-8?B?RHZ1dkI3eVlaQi9Zd0ZlcldWd29TNXg2N0VrUUIxZzd3cCtXNjJxeGlpZnBy?=
 =?utf-8?B?N0p5RkZxMVJJaTV0LzlZRVA1dGR6SU9aRVNNeUhUUTlIVXlhaEhDNERDMEJM?=
 =?utf-8?B?L3FkTm53SzNFSldKQ3BTVWJzTFh5TDBLaFZzQlJrbU52dXd6eWxBd3hTdzVn?=
 =?utf-8?B?VUdWUjZQWjFIa1NvZG04YlJNUGxXbzNBbmNrcXBwVW5YaDFNVXdUWGtXQklp?=
 =?utf-8?B?SE1zTHBQNFNhb3FXeElVMEc4N0tRRis3eFVJcTFjbXFBREVoN2M4UjJoK1RM?=
 =?utf-8?B?YnhHelh1TDFRbjdhOTBrZFZCZUpqRXk2S2o3K3NScTd2N2o2ZGR0MXl0OUY3?=
 =?utf-8?B?QzJzVjlwbnF4ekFDU1JWbmU0dTYwdXo5TkNhSHBFSDVnOWNBSFRMaHRkeFhk?=
 =?utf-8?B?VjFlZGlHb1REOUE2TW0rK3BXTy80UENoWGJwL0VyeE9DeXllT0dlMXJqZVZO?=
 =?utf-8?B?clpxdlViUHF0NUhxWVhtSzJoVlRoVExEYmMxb3RNblpBaHZKZlhXemh4UHRy?=
 =?utf-8?B?SkEvRXJCNy80ZitPSWZlc1kvenVaalg5NUlRaG5wNFlVUnA0Uk1NUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59227c6-7af3-49cb-1d3e-08defa49d7c8
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:20:19.4801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zovH26IISk1/nUhNvmidP6aP7LKf7unV/i3TNPY9RHmBwjJhSQBuyxPaXGLyBgz1H6UDAEvPpAFdfpOap4goUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
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

--------------KL07kNuUU9OH9ZJxhbDb9SpT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-08-14 02:47, Zhu, Lingshan wrote:
> On 8/14/2026 12:05 AM, Kuehling, Felix wrote:
>> On 2026-08-13 02:21, Zhu, Lingshan wrote:
>>> Hello Felix,
>>>
>>> Yes I agree the user space may be buggy, and the kernel should be 
>>> robust.
>>>
>>> Even though it is named locking, it is actually a reservation, not 
>>> recursive locking.
>>> The kfd_process that successfully invokes the ioctl reserves the 
>>> device as a profiler.
>>> So when a user space locks the device multiple times, it does not 
>>> increase any reference counters, and doesn't need to unlock multiple 
>>> times.
>>>
>>> Multiple times lockings from the same kfd_process just keeps the 
>>> reservation, it still reserves the device successfully,
>>> so IMHO kfd should return 0 other than -EALREADY, which is a 
>>> negative error code.
>>
>> That's exactly the problem. The API is apparently designed for user 
>> mode to "reserve" profiler access once, presumably to get exclusive 
>> access to some profiler resources. If user space reserves multiple 
>> times, you probably have multiple uncoordinated users of the profiler 
>> features in the same process. If they are not aware of each other, 
>> they will run into problems because they're expecting exclusive 
>> access to resources that are actually shared with someone else.
> do you mean some pthreads in a process that own the same kfd_process?

I'm thinking of situations where you may have multiple libraries or 
modules linked into the same binary that all want to use the profiler 
feature. It doesn't matter whether they run on the same thread or 
different threads.

Regards,
   Felix


>>
>> For example they will both independently call "unreserve" as well. 
>> When the first one calls "unreserve", the other one breaks. This may 
>> happen intermittently, depending on the order of operations. Or it 
>> may be noticed as a regression after seemingly harmless changes that 
>> affect the order of operations. This is much harder to debug than a 
>> clear error code returned when a double reservation first happens.
>>
>> By returning 0 here, you paper over the user mode bug. But chances 
>> are, you're going to run into other bugs later that have the same 
>> cause and are much more difficult to debug. Unless someone explains 
>> to me that I'm misunderstanding the intent of the reservation API, I 
>> will not approve this change.
>>
>>
>>>
>>> By the way, the function is declared to return uint32_t, which is 
>>> definitely wrong, because the function may return errors, for 
>>> example -EBUSY.
>>
>> I agree with this part.
> I will send out a patch to fix this part.
>
> Thanks
> Lingshan
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Thanks
>>> Lingshan
>>> On 8/13/2026 12:27 AM, Kuehling, Felix wrote:
>>>> I suspect this won't work correctly. If the profiler locks the 
>>>> device multiple times, it probably also unlocks it multiple times. 
>>>> But I see no reference counting being done, so this may result in a 
>>>> situation where user mode locks twice, and unlocks once. Now it's 
>>>> lost the lock but it was still expecting to have it from the first 
>>>> lock operation.
>>>>
>>>> I suspect that this is a user mode bug, and KFD is working as 
>>>> expected.
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>> On 2026-08-12 03:14, Zhu, Lingshan wrote:
>>>>> AMD General
>>>>>
>>>>> Gentle Ping.
>>>>>
>>>>> Thanks
>>>>> Lingshan
>>>>>
>>>>> -----Original Message-----
>>>>> From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
>>>>> Sent: Thursday, August 6, 2026 4:43 PM
>>>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
>>>>> Christian <Christian.Koenig@amd.com>; Kuehling, Felix 
>>>>> <Felix.Kuehling@amd.com>
>>>>> Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org; 
>>>>> Zhu, Lingshan <Lingshan.Zhu@amd.com>
>>>>> Subject: [PATCH] amdkfd: allow profiler process reenter
>>>>>
>>>>> profile_lock_device() currently returns -EALREADY when the current 
>>>>> profiler process requests to lock the device again. However any 
>>>>> negtive values here are treated as failure, so this causes 
>>>>> rejecting a profiler operation even though the caller still owns 
>>>>> the device locking.
>>>>>
>>>>> This commit fixes this problem by returning 0 when the current 
>>>>> profiler process locking the device again.
>>>>>
>>>>> This commit also changes profile_lock_device() to return an int 
>>>>> value other than uint32_t, because it returns negative number when 
>>>>> fail.
>>>>>
>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
>>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> index 309510e23315..9acd5c91e51c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> @@ -3329,8 +3329,8 @@ static int kfd_ioctl_create_process(struct 
>>>>> file *filep, struct kfd_process *p, v
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> -static inline uint32_t profile_lock_device(struct kfd_process *p,
>>>>> -                                          uint32_t gpu_id, 
>>>>> uint32_t op)
>>>>> +static inline int profile_lock_device(struct kfd_process *p,
>>>>> +                                     uint32_t gpu_id, uint32_t op)
>>>>>   {
>>>>>          struct kfd_process_device *pdd;
>>>>>          struct kfd_dev *kfd;
>>>>> @@ -3365,7 +3365,7 @@ static inline uint32_t 
>>>>> profile_lock_device(struct kfd_process *p,
>>>>>                          }
>>>>>                          return status;
>>>>>                  } else if (kfd->profiler_process == p) {
>>>>> -                       status = -EALREADY;
>>>>> +                       status = 0;
>>>>>                  } else {
>>>>>                          status = -EBUSY;
>>>>>                  }
>>>>> -- 
>>>>> 2.53.0
>>>>>
--------------KL07kNuUU9OH9ZJxhbDb9SpT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-08-14 02:47, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:4a94f469-1c79-4f46-a57d-bd2aa08ef162@amd.com">
      
      <pre>On 8/14/2026 12:05 AM, Kuehling, Felix wrote:</pre>
      <blockquote type="cite" cite="mid:02e91cc3-a3b1-40b0-8027-ceef0f17a05a@amd.com">On
        2026-08-13 02:21, Zhu, Lingshan wrote: <br>
        <blockquote type="cite">Hello Felix, <br>
          <br>
          Yes I agree the user space may be buggy, and the kernel should
          be robust. <br>
          <br>
          Even though it is named locking, it is actually a reservation,
          not recursive locking. <br>
          The kfd_process that successfully invokes the ioctl reserves
          the device as a profiler. <br>
          So when a user space locks the device multiple times, it does
          not increase any reference counters, and doesn't need to
          unlock multiple times. <br>
          <br>
          Multiple times lockings from the same kfd_process just keeps
          the reservation, it still reserves the device successfully, <br>
          so IMHO kfd should return 0 other than -EALREADY, which is a
          negative error code. <br>
        </blockquote>
        <br>
        That's exactly the problem. The API is apparently designed for
        user mode to &quot;reserve&quot; profiler access once, presumably to get
        exclusive access to some profiler resources. If user space
        reserves multiple times, you probably have multiple
        uncoordinated users of the profiler features in the same
        process. If they are not aware of each other, they will run into
        problems because they're expecting exclusive access to resources
        that are actually shared with someone else. <br>
      </blockquote>
      do you mean some pthreads in a process that own the same
      kfd_process?</blockquote>
    <p>I'm thinking of situations where you may have multiple libraries
      or modules linked into the same binary that all want to use the
      profiler feature. It doesn't matter whether they run on the same
      thread or different threads.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:4a94f469-1c79-4f46-a57d-bd2aa08ef162@amd.com">
      <blockquote type="cite" cite="mid:02e91cc3-a3b1-40b0-8027-ceef0f17a05a@amd.com"><br>
        For example they will both independently call &quot;unreserve&quot; as
        well. When the first one calls &quot;unreserve&quot;, the other one
        breaks. This may happen intermittently, depending on the order
        of operations. Or it may be noticed as a regression after
        seemingly harmless changes that affect the order of operations.
        This is much harder to debug than a clear error code returned
        when a double reservation first happens. <br>
        <br>
        By returning 0 here, you paper over the user mode bug. But
        chances are, you're going to run into other bugs later that have
        the same cause and are much more difficult to debug. Unless
        someone explains to me that I'm misunderstanding the intent of
        the reservation API, I will not approve this change. <br>
        <br>
        <br>
        <blockquote type="cite"> <br>
          By the way, the function is declared to return uint32_t, which
          is definitely wrong, because the function may return errors,
          for example -EBUSY. <br>
        </blockquote>
        <br>
        I agree with this part. <br>
      </blockquote>
      <pre>I will send out a patch to fix this part.

Thanks
Lingshan</pre>
      <blockquote type="cite" cite="mid:02e91cc3-a3b1-40b0-8027-ceef0f17a05a@amd.com"><br>
        Regards, <br>
        &nbsp; Felix <br>
        <br>
        <br>
        <blockquote type="cite"> <br>
          Thanks <br>
          Lingshan <br>
          On 8/13/2026 12:27 AM, Kuehling, Felix wrote: <br>
          <blockquote type="cite">I suspect this won't work correctly.
            If the profiler locks the device multiple times, it probably
            also unlocks it multiple times. But I see no reference
            counting being done, so this may result in a situation where
            user mode locks twice, and unlocks once. Now it's lost the
            lock but it was still expecting to have it from the first
            lock operation. <br>
            <br>
            I suspect that this is a user mode bug, and KFD is working
            as expected. <br>
            <br>
            Regards, <br>
            &nbsp; Felix <br>
            <br>
            On 2026-08-12 03:14, Zhu, Lingshan wrote: <br>
            <blockquote type="cite">AMD General <br>
              <br>
              Gentle Ping. <br>
              <br>
              Thanks <br>
              Lingshan <br>
              <br>
              -----Original Message----- <br>
              From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com" moz-do-not-send="true">&lt;Lingshan.Zhu@amd.com&gt;</a>
              <br>
              Sent: Thursday, August 6, 2026 4:43 PM <br>
              To: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a>;
              Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
              Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>
              <br>
              Cc: Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com" moz-do-not-send="true">&lt;Ray.Huang@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>;
              Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com" moz-do-not-send="true">&lt;Lingshan.Zhu@amd.com&gt;</a>
              <br>
              Subject: [PATCH] amdkfd: allow profiler process reenter <br>
              <br>
              profile_lock_device() currently returns -EALREADY when the
              current profiler process requests to lock the device
              again. However any negtive values here are treated as
              failure, so this causes rejecting a profiler operation
              even though the caller still owns the device locking. <br>
              <br>
              This commit fixes this problem by returning 0 when the
              current profiler process locking the device again. <br>
              <br>
              This commit also changes profile_lock_device() to return
              an int value other than uint32_t, because it returns
              negative number when fail. <br>
              <br>
              Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com" moz-do-not-send="true">&lt;lingshan.zhu@amd.com&gt;</a>
              <br>
              --- <br>
              &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++--- <br>
              &nbsp; 1 file changed, 3 insertions(+), 3 deletions(-) <br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
              index 309510e23315..9acd5c91e51c 100644 <br>
              --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
              +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
              @@ -3329,8 +3329,8 @@ static int
              kfd_ioctl_create_process(struct file *filep, struct
              kfd_process *p, v <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; <br>
              &nbsp; } <br>
              <br>
              -static inline uint32_t profile_lock_device(struct
              kfd_process *p, <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t
              gpu_id, uint32_t op) <br>
              +static inline int profile_lock_device(struct kfd_process
              *p, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpu_id,
              uint32_t op) <br>
              &nbsp; { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd; <br>
              @@ -3365,7 +3365,7 @@ static inline uint32_t
              profile_lock_device(struct kfd_process *p, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (kfd-&gt;profiler_process == p)
              { <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = -EALREADY; <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = 0; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = -EBUSY; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <br>
              --&nbsp;<br>
              2.53.0 <br>
              <br>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------KL07kNuUU9OH9ZJxhbDb9SpT--
