Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ECCC5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 06:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C041510E0D6;
	Fri, 14 Aug 2026 06:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xlx7g+ch";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FFF610E0D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 06:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUeltLF9MOxHypW5x9tweTyKl84cP4lwKYLm82s+dATNru3rdAmGmrNlh3uMM4Q8haCm+4B5NpaLa/iuAwB4OQdAkD80a3I/HKjGUBa6grfaNNNDJQ+6CoBriHKQa1JkBEsfl+/KQXccAOl6Vm+CVChDezLA1ikP8oNrEGzd0O1TAEH5Af3gzut/SY2GJ5FC1mi77j6Met5x6bGKB8HmLjiQdRELrRL1rWHJXcnA4owhJs5kWnCdq+b788NqrBGEHUVHlegjEm1HNPhRh8spelk7dbwBN8iHyRMEv46j+oNDYgj2TzHt8OUs/t2W0kqMm41KFLnzuplOB8q05Kkprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjxlAxUfa24bYIYk0YKdG98ay0FR8fENhmUfY2pIj+g=;
 b=Zj7VxBA4kXen6Fs/URRQR42g1N0BDBbK4ry09B1LBCXk2qqiVccl9Hgl8MLd8Dd2Tn3ow2YjPmkla1QQa9yc0FsQcWfEtK38ZIB+Jn8i/6fWR6jiOY/tOdslJIjxRUlrTZKU4kCOJGlzVLaYQs2cATtRwqbmNygz8E3xbtumaqemr8vOE2n3Rjhjyz73AaERZwNMN2zdQ7N2Nz4yydUnx17QeFHhVRG5kqIWY3DTCNN3v3D46I38v3LqAQqUVI1xvBoNQAtBL+jac0jZl64+gewQocUn6YKKcC4QPId0nlAzv3dCxcKgwqxkNdsirFdGTBwbBTP8k7xD7PJp2TL57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjxlAxUfa24bYIYk0YKdG98ay0FR8fENhmUfY2pIj+g=;
 b=xlx7g+chAC5A3CfA6r/9v9nL1DgSvoq+VEroH5mQ7bvkQTp/gYyEHl04FYZLGV9QPiQqR7ujmxeNALeO2RN6iZIzYNGYZXtVD+riRBgsrtm5G98uk9bOvTaHjehlNJZdXwZMK+N/tWqE9Aet2nrrgvwrHdAfwOZYMVw66kxaFF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 14 Aug
 2026 06:48:05 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 06:48:05 +0000
Content-Type: multipart/alternative;
 boundary="------------fKyvX0SKxG1xho1zYCVURQcP"
Message-ID: <4a94f469-1c79-4f46-a57d-bd2aa08ef162@amd.com>
Date: Fri, 14 Aug 2026 14:47:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdkfd: allow profiler process reenter
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260806084312.79422-1-lingshan.zhu@amd.com>
 <CH2PR12MB94573C6D5DD3480E33E6463F8CDC2@CH2PR12MB9457.namprd12.prod.outlook.com>
 <3f62daa5-7c4c-476b-b692-0cb544e3d2a3@amd.com>
 <be92ca16-443a-478d-96dc-c83318df3670@amd.com>
 <02e91cc3-a3b1-40b0-8027-ceef0f17a05a@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <02e91cc3-a3b1-40b0-8027-ceef0f17a05a@amd.com>
X-ClientProxiedBy: TPYP295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::19) To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 8670fc71-2778-4557-77f5-08def9cffe50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|4143699003|6133799003|5023799004|22082099003|56012099006|10067099003|11063799006|8096899003;
X-Microsoft-Antispam-Message-Info: F0WV4ZRberqZw8oT7rtKNDQk4HmI5s4vIXgLg6oLHIPYL+eGO3RUYVTbE5fOdfjcK1i3m7zS2hu9ZQz5aiMr8WstCdcdWcxiwXdGqU1dIlyRPnsO4J05ziST1OQY0ZbvZgGZl7yZTfftoM0C6Y7JtUjrOjwm1HQdO9D2gHhBvGE1n96LiHkADaxO5Kj3RsDk09C2UuNQZrvrshkaGzFlzRWsfOuYo3dl444Gc72sRpNuzZaXQxxUsCU8IkgRN6cEdQBRb4DSto5kxLvZXi64pBob0XSUEqFxLVYPpNzmliHiSWX+jq4FFXfxI01DrlI5l9DeeNOAlShpgcUizfBqrRhePTWOjqsfW3sKEb+L7SEsxLaFgEZkje3N0OofWiu+3FeK5q5BKSQW2ImEDm9zys9FTLj1kjfIf3vFcnMJb0hgNCL0vXsgFpXNxfaK1als5CdDa/Ci3xP8GmdE4QRULvpQNWDmqeHaKz/MlBBqCSaxY/nArk+CqTtOMwYCLkVOeiRMwwvFwnXvbjGQgCMGVATKDI6PAiZjBDgTJL8J6FseSZlgE43/2w1X2QSRT1aCaKePDWcNFNKp64uL7z2T8Ncr9g7o+R3ZLa3B1COgXOEvLSc2bxFqDJqY11joXXwb+5tw7d4X5dDU6uMPKQfiCr/J9O0eOemhimBTSJOEGpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(4143699003)(6133799003)(5023799004)(22082099003)(56012099006)(10067099003)(11063799006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHBRaDNLd1JSRlZBaUNScERkTWpDaW5qNGRiZmw2VkgvVG5MRlBOd1d5ZVlm?=
 =?utf-8?B?UDJrT0lxNEdYZkY5OXlFSmhMTE1mVUtYdmRWQW8vR00vWHZrcmFoK2IrUXFE?=
 =?utf-8?B?MW96a2U1eVlodnhaL0lsN2s5M0EwMVM1Z2cwZDZrcUN3MEtRZ3ZZMStZTTBn?=
 =?utf-8?B?T3ltdG43NW1qYzBMdWo4akhDa0JpQTZxRnlHVDQ4blpYOGJ2a2hSWWJEN20y?=
 =?utf-8?B?SytGc1JIZk9mdFU0OEF2UWpPZGlkZmdyS3d3bW4wODNyS09vU005b0I4RENv?=
 =?utf-8?B?bi9TM0VvdGZFZ3llYTJpNnlMUTZNeXI5Q0Zuc3VQZ0o0cEdtTmVCZDFwNXlE?=
 =?utf-8?B?Qmd2SVBSWkVLVTRvdys2NHZvNWhUWTJiV1hmZ2V4QkFDYmZGM3FzRDlMWWpk?=
 =?utf-8?B?K2J4YS9VVFE3enpEcG9lTkNKNURKWXAzM2l5Njc0SE5TNkY4bTdkZitXVVp2?=
 =?utf-8?B?cEpNK3h5aTh4MjhlR2YrYkVWWW1oV2xMNWZYVitBNUduVlBoOTBPblhhS2hJ?=
 =?utf-8?B?czdyZ1RnaUFYd2FnV2lYbzRaUytNTUswRWFzY3JMK2NKYmlxdThDbkFUbnE1?=
 =?utf-8?B?OUNFK24vUUZUUTVmRG9UMWFubER4UGVReE1JSlg3Um5VczQyN2g5QnE0bDBF?=
 =?utf-8?B?U0xzMTBLZjYwS01oQ0xucXhrdGFIZ1ZsYVZyUzNHSm9ld01MWVVFT3hKdVZB?=
 =?utf-8?B?QVZuSjNaSWNkOTh1SFRmMnd1NWRSNEY2MWtrSXE3d0tlNHpPTEY1N28zeXFL?=
 =?utf-8?B?cXJDKzY4Y3cyZkNyMWI3NUFvd054VkQzeHdoamEzNW15V1RFZzlaQ1diK3RF?=
 =?utf-8?B?ZnRaaFR2QkVuKzFiQTZlVHpmdVdOMVF6VFNmNGJTcVF1eUdqd0tiQmdLdVpV?=
 =?utf-8?B?aVpka2V0cFAycFhuTHZ6d1l1YjZxSndaSkYyWSthbG1Mc2RSQnZGV0JXTUhU?=
 =?utf-8?B?MExUQW4zR2g2OWlyaVNnNFB3QWprdm5xZ0poTWdFNEdNYXNjam0yWHphck9J?=
 =?utf-8?B?YXcweENvVUpsVUQ1YU55dCsxdTdFNFB2aDRhSkxqZVZqd3A5eGlMcms1c0Rp?=
 =?utf-8?B?TzRiZFJaVEdaTDByRDBMQlZMOXdYYXpHUG5sNEMvZXc1VTVmVHdUeldWMXd2?=
 =?utf-8?B?eWNNQ2NRR2szV3lVUCsrWkJuYms5S3VlMmRIUE43TUZIMXNSUk05akFqZnc0?=
 =?utf-8?B?QkVuZHNpQlhIanArNjdvcVVxcFpJeDFvMExRY2h6K1lMci9qUUs2QVIvUURW?=
 =?utf-8?B?N3hmTGhxU2pkajVUcWpSbVgvOGNKR2FlS2podEtIWnRsZm5FV0VRK2pSTHpN?=
 =?utf-8?B?QUVLd0hWcmxQODNkVG5qWkVIR2FZWEQ0QnlnM0JFazJDQmMwaHhlQk12a042?=
 =?utf-8?B?VS9WM3NPK1NSemNKcXY2VnFkakx0bitTSzFmM09Kd0F5d1BCQllXSnlUWHRn?=
 =?utf-8?B?MWloSUY0cFVFSS9ZbjNNUnVERDlqQW01M1pxbU02RE5FTERCZXkzMXpEUVBI?=
 =?utf-8?B?Y0oydnNBWGV6UkE2M1FPcm1zc3FFdm14SEo4dTRrSUVRaWdQMU1aL2JFbVpx?=
 =?utf-8?B?RDJRcmlzUVN3Wkp1bHBoWndIVGVybFdsZ3B5YngyTW1mN1VsSDhpVmZxMHZN?=
 =?utf-8?B?bWJ5ZXVWaWN1cjEzb015RFBMRDN5M0xZSU5rSHRjU0VoTEJZTi9Qclc5SnFu?=
 =?utf-8?B?VVprYVpRSytlTEJxejZNRlhBOVZKQ3UvSjE4cElyRVNrRlpKelBWaFAyM3lm?=
 =?utf-8?B?TVo3YW1ML2FZWWU1aTMxS1dDME9nVUdiNFFyTVF3emlxK0F1M2pWdjladFhk?=
 =?utf-8?B?WHVuVE9PaytRZnFVK0dqRXlwdFpKSFFuZGpRNDhjTW1SZ1NiWDE4aERLMkhm?=
 =?utf-8?B?ZTZpN1VtWnhIamMwRjNhQ0pKVE1OYzlPSU5NWGMyQUloOGhxbWk2eWN6eTQ3?=
 =?utf-8?B?dm80MDlpR294SG1ZQTYxMkRCWGpHdXpDdjVWcEk2QVJmV1RGOCtCZUxwMTJK?=
 =?utf-8?B?V2Eya2pkcDF1Y2tXalhsdDVVanhqR0IvUWhoRkhhZHBCa3Q1eU1tMDV5K1Zl?=
 =?utf-8?B?enNkaERzUnlkcy9uQTZKR1BBY3dPaHZtUS92bGxEVkZaOXBITVV4c3lTRFhy?=
 =?utf-8?B?UGlnZkE2RVhyM3JNb09pTmVyYW82ellDUmY1aGJrUFl3N2c5RmtvUitvWm5Q?=
 =?utf-8?B?dkZkK0tqMnI5cmJaZEJDZXQzVGorWHlITXEyUExGK3lMQk1Hb2xhVWtLdzZh?=
 =?utf-8?B?WTVRSTNNcWJxQ3ZtMjBkVkpSUm5zdExDUlJFb3hHUHNvdEVVMGdGUGh4SGEz?=
 =?utf-8?Q?iymabYkTHW0ZqDCeGC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8670fc71-2778-4557-77f5-08def9cffe50
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 06:48:05.6320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMjlkhklHy5BQHD/+rC8aMA1AAM3xVzLwVH+nyUWgdmW0NXQKZ7Dva1FnNOxsxO7b8pT6jaKHW4ONbxLpd7tRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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

--------------fKyvX0SKxG1xho1zYCVURQcP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/14/2026 12:05 AM, Kuehling, Felix wrote:

> On 2026-08-13 02:21, Zhu, Lingshan wrote:
>> Hello Felix,
>>
>> Yes I agree the user space may be buggy, and the kernel should be
>> robust.
>>
>> Even though it is named locking, it is actually a reservation, not
>> recursive locking.
>> The kfd_process that successfully invokes the ioctl reserves the
>> device as a profiler.
>> So when a user space locks the device multiple times, it does not
>> increase any reference counters, and doesn't need to unlock multiple
>> times.
>>
>> Multiple times lockings from the same kfd_process just keeps the
>> reservation, it still reserves the device successfully,
>> so IMHO kfd should return 0 other than -EALREADY, which is a negative
>> error code.
>
> That's exactly the problem. The API is apparently designed for user
> mode to "reserve" profiler access once, presumably to get exclusive
> access to some profiler resources. If user space reserves multiple
> times, you probably have multiple uncoordinated users of the profiler
> features in the same process. If they are not aware of each other,
> they will run into problems because they're expecting exclusive access
> to resources that are actually shared with someone else.
do you mean some pthreads in a process that own the same kfd_process?
>
> For example they will both independently call "unreserve" as well.
> When the first one calls "unreserve", the other one breaks. This may
> happen intermittently, depending on the order of operations. Or it may
> be noticed as a regression after seemingly harmless changes that
> affect the order of operations. This is much harder to debug than a
> clear error code returned when a double reservation first happens.
>
> By returning 0 here, you paper over the user mode bug. But chances
> are, you're going to run into other bugs later that have the same
> cause and are much more difficult to debug. Unless someone explains to
> me that I'm misunderstanding the intent of the reservation API, I will
> not approve this change.
>
>
>>
>> By the way, the function is declared to return uint32_t, which is
>> definitely wrong, because the function may return errors, for example
>> -EBUSY.
>
> I agree with this part.

I will send out a patch to fix this part.

Thanks
Lingshan

>
> Regards,
>   Felix
>
>
>>
>> Thanks
>> Lingshan
>> On 8/13/2026 12:27 AM, Kuehling, Felix wrote:
>>> I suspect this won't work correctly. If the profiler locks the
>>> device multiple times, it probably also unlocks it multiple times.
>>> But I see no reference counting being done, so this may result in a
>>> situation where user mode locks twice, and unlocks once. Now it's
>>> lost the lock but it was still expecting to have it from the first
>>> lock operation.
>>>
>>> I suspect that this is a user mode bug, and KFD is working as expected.
>>>
>>> Regards,
>>>   Felix
>>>
>>> On 2026-08-12 03:14, Zhu, Lingshan wrote:
>>>> AMD General
>>>>
>>>> Gentle Ping.
>>>>
>>>> Thanks
>>>> Lingshan
>>>>
>>>> -----Original Message-----
>>>> From: Zhu, Lingshan <Lingshan.Zhu@amd.com>
>>>> Sent: Thursday, August 6, 2026 4:43 PM
>>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
>>>> Christian <Christian.Koenig@amd.com>; Kuehling, Felix
>>>> <Felix.Kuehling@amd.com>
>>>> Cc: Huang, Ray <Ray.Huang@amd.com>; amd-gfx@lists.freedesktop.org;
>>>> Zhu, Lingshan <Lingshan.Zhu@amd.com>
>>>> Subject: [PATCH] amdkfd: allow profiler process reenter
>>>>
>>>> profile_lock_device() currently returns -EALREADY when the current
>>>> profiler process requests to lock the device again. However any
>>>> negtive values here are treated as failure, so this causes
>>>> rejecting a profiler operation even though the caller still owns
>>>> the device locking.
>>>>
>>>> This commit fixes this problem by returning 0 when the current
>>>> profiler process locking the device again.
>>>>
>>>> This commit also changes profile_lock_device() to return an int
>>>> value other than uint32_t, because it returns negative number when
>>>> fail.
>>>>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> index 309510e23315..9acd5c91e51c 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>> @@ -3329,8 +3329,8 @@ static int kfd_ioctl_create_process(struct
>>>> file *filep, struct kfd_process *p, v
>>>>          return 0;
>>>>   }
>>>>
>>>> -static inline uint32_t profile_lock_device(struct kfd_process *p,
>>>> -                                          uint32_t gpu_id,
>>>> uint32_t op)
>>>> +static inline int profile_lock_device(struct kfd_process *p,
>>>> +                                     uint32_t gpu_id, uint32_t op)
>>>>   {
>>>>          struct kfd_process_device *pdd;
>>>>          struct kfd_dev *kfd;
>>>> @@ -3365,7 +3365,7 @@ static inline uint32_t
>>>> profile_lock_device(struct kfd_process *p,
>>>>                          }
>>>>                          return status;
>>>>                  } else if (kfd->profiler_process == p) {
>>>> -                       status = -EALREADY;
>>>> +                       status = 0;
>>>>                  } else {
>>>>                          status = -EBUSY;
>>>>                  }
>>>> -- 
>>>> 2.53.0
>>>>
--------------fKyvX0SKxG1xho1zYCVURQcP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 8/14/2026 12:05 AM, Kuehling, Felix wrote:</pre>
    <blockquote type="cite" cite="mid:02e91cc3-a3b1-40b0-8027-ceef0f17a05a@amd.com">On
      2026-08-13 02:21, Zhu, Lingshan wrote:
      <br>
      <blockquote type="cite">Hello Felix,
        <br>
        <br>
        Yes I agree the user space may be buggy, and the kernel should
        be robust.
        <br>
        <br>
        Even though it is named locking, it is actually a reservation,
        not recursive locking.
        <br>
        The kfd_process that successfully invokes the ioctl reserves the
        device as a profiler.
        <br>
        So when a user space locks the device multiple times, it does
        not increase any reference counters, and doesn't need to unlock
        multiple times.
        <br>
        <br>
        Multiple times lockings from the same kfd_process just keeps the
        reservation, it still reserves the device successfully,
        <br>
        so IMHO kfd should return 0 other than -EALREADY, which is a
        negative error code.
        <br>
      </blockquote>
      <br>
      That's exactly the problem. The API is apparently designed for
      user mode to &quot;reserve&quot; profiler access once, presumably to get
      exclusive access to some profiler resources. If user space
      reserves multiple times, you probably have multiple uncoordinated
      users of the profiler features in the same process. If they are
      not aware of each other, they will run into problems because
      they're expecting exclusive access to resources that are actually
      shared with someone else.
      <br>
    </blockquote>
    do you mean some pthreads in a process that own the same
    kfd_process?
    <blockquote type="cite" cite="mid:02e91cc3-a3b1-40b0-8027-ceef0f17a05a@amd.com"><br>
      For example they will both independently call &quot;unreserve&quot; as well.
      When the first one calls &quot;unreserve&quot;, the other one breaks. This
      may happen intermittently, depending on the order of operations.
      Or it may be noticed as a regression after seemingly harmless
      changes that affect the order of operations. This is much harder
      to debug than a clear error code returned when a double
      reservation first happens.
      <br>
      <br>
      By returning 0 here, you paper over the user mode bug. But chances
      are, you're going to run into other bugs later that have the same
      cause and are much more difficult to debug. Unless someone
      explains to me that I'm misunderstanding the intent of the
      reservation API, I will not approve this change.
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        By the way, the function is declared to return uint32_t, which
        is definitely wrong, because the function may return errors, for
        example -EBUSY.
        <br>
      </blockquote>
      <br>
      I agree with this part.
      <br>
    </blockquote>
    <pre>I will send out a patch to fix this part.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:02e91cc3-a3b1-40b0-8027-ceef0f17a05a@amd.com"><br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Thanks
        <br>
        Lingshan
        <br>
        On 8/13/2026 12:27 AM, Kuehling, Felix wrote:
        <br>
        <blockquote type="cite">I suspect this won't work correctly. If
          the profiler locks the device multiple times, it probably also
          unlocks it multiple times. But I see no reference counting
          being done, so this may result in a situation where user mode
          locks twice, and unlocks once. Now it's lost the lock but it
          was still expecting to have it from the first lock operation.
          <br>
          <br>
          I suspect that this is a user mode bug, and KFD is working as
          expected.
          <br>
          <br>
          Regards,
          <br>
          &nbsp; Felix
          <br>
          <br>
          On 2026-08-12 03:14, Zhu, Lingshan wrote:
          <br>
          <blockquote type="cite">AMD General
            <br>
            <br>
            Gentle Ping.
            <br>
            <br>
            Thanks
            <br>
            Lingshan
            <br>
            <br>
            -----Original Message-----
            <br>
            From: Zhu, Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
            <br>
            Sent: Thursday, August 6, 2026 4:43 PM
            <br>
            To: Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>;
            Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
            Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
            <br>
            Cc: Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com">&lt;Ray.Huang@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Zhu, Lingshan
            <a class="moz-txt-link-rfc2396E" href="mailto:Lingshan.Zhu@amd.com">&lt;Lingshan.Zhu@amd.com&gt;</a>
            <br>
            Subject: [PATCH] amdkfd: allow profiler process reenter
            <br>
            <br>
            profile_lock_device() currently returns -EALREADY when the
            current profiler process requests to lock the device again.
            However any negtive values here are treated as failure, so
            this causes rejecting a profiler operation even though the
            caller still owns the device locking.
            <br>
            <br>
            This commit fixes this problem by returning 0 when the
            current profiler process locking the device again.
            <br>
            <br>
            This commit also changes profile_lock_device() to return an
            int value other than uint32_t, because it returns negative
            number when fail.
            <br>
            <br>
            Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
            <br>
            &nbsp; 1 file changed, 3 insertions(+), 3 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
            <br>
            index 309510e23315..9acd5c91e51c 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
            <br>
            @@ -3329,8 +3329,8 @@ static int
            kfd_ioctl_create_process(struct file *filep, struct
            kfd_process *p, v
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
            <br>
            &nbsp; }
            <br>
            <br>
            -static inline uint32_t profile_lock_device(struct
            kfd_process *p,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpu_id,
            uint32_t op)
            <br>
            +static inline int profile_lock_device(struct kfd_process
            *p,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gpu_id,
            uint32_t op)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *kfd;
            <br>
            @@ -3365,7 +3365,7 @@ static inline uint32_t
            profile_lock_device(struct kfd_process *p,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (kfd-&gt;profiler_process == p) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = -EALREADY;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = 0;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status = -EBUSY;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            --&nbsp;<br>
            2.53.0
            <br>
            <br>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------fKyvX0SKxG1xho1zYCVURQcP--
