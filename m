Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33EAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 11:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 697B36EB4A;
	Wed,  1 Dec 2021 11:29:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA4526EB30
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 11:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crAKcrQE9i/NUkBSR44YMF9dQhY9sOn2AcXl/oY+/E9265CDBEqJKvfrM9XDoFiu/iiKOGpXJ5iozpaMHKCod07i8hSEPhPWjLfj71K4KLAiK4p2jbBmW9idtFCD6PNm1xlJQiAMX6Vm7JBx8wwvMoJo7+Q4HJLlis4SUSYsNWT5lKCHb2ukIGgRkWDHcgkPwpPkiddP12oWF0ax7osplJtAueREpyX+1AhBIdE99Jl4RUOypbMbEpFht47iUKiU48yRZHgQ+RhrFMqoH/irGEJRoJbj5r0rYG4Eou6f418ulMONQQJc+j2/cqf4p1WGbzHsqrljFk3JVDhKU8r4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzoQXyLsL4+8KGnlg9CoV/LXmra8bJyo7YPBagE2hIc=;
 b=kwhrM9Hj/qRBppPjEJu3MjBUnSwLzCWKXP64SALwARgJsZjakENLsnp6pZG9wPvjd22FNcpegg5DQdJsa9dRaBF0Ky5FmUNquavstmqeii82vGIh10jJ7fMEnE4W6P59DqY8EybQ5hXCwqsYd/JR4GLlu/s7ZvL3JImPJXdgQzr8pFKrhSxhlwwjD3ES2BP16xaXeYyW+i9in/PSPz+fSdyyC+cHtRjTtXeM1o5T3xX2bMpaBR5PXO6kAM8y9xPB1moE4dxMKh+EZEv/zrqQZPT0drYbyB1P/ZE32C1GNHE90XG+t4KQ/BvHSvxl/h5oW25w9JBVmT5tY2fIEm2pug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzoQXyLsL4+8KGnlg9CoV/LXmra8bJyo7YPBagE2hIc=;
 b=a9JofZIS9Yz3dD3AuB+ePFkyCY7IYPn3/clKDuefQDfRLaknLbvhXmSptG1ELIDfKVfX54mH4c3eSR8TRX22Rj+ef6MJfG2EtgT6REls972anS1I91mWCWNEcWwvUE40JeHswyPMHZl/fLty2dIwM3ykZ5Tt+GOENpuxCcC8huk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1776.namprd12.prod.outlook.com
 (2603:10b6:300:113::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Wed, 1 Dec
 2021 11:29:32 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4713.027; Wed, 1 Dec 2021
 11:29:32 +0000
Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
To: "Yu, Lang" <Lang.Yu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211201092458.3348858-1-lang.yu@amd.com>
 <f7e0dfb0-cdb0-13f2-49e4-d13366a23e0f@amd.com>
 <DM6PR12MB4250974428DA6713B8BC4802FB689@DM6PR12MB4250.namprd12.prod.outlook.com>
 <0ee705b0-d9fe-4339-9381-9fe058dfbd3f@gmail.com>
 <DM6PR12MB42505899AFB96290F516C21BFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e3bdf34e-b18c-695b-fc58-73426760935b@amd.com>
Date: Wed, 1 Dec 2021 12:29:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM6PR12MB42505899AFB96290F516C21BFB689@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6P193CA0062.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::39) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (87.176.183.123) by
 AM6P193CA0062.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23 via Frontend Transport; Wed, 1 Dec 2021 11:29:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8879b9bd-5eb9-416a-eaf7-08d9b4bdd813
X-MS-TrafficTypeDiagnostic: MWHPR12MB1776:
X-Microsoft-Antispam-PRVS: <MWHPR12MB177674BA9F78A513D814519183689@MWHPR12MB1776.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njjlcx7+lgYwX0Y/7eEGXmaLffYTUQY+VkxiW82L+h5RRJBxYv3PuThvq0Di8JF9CoSguo998FMokC0V2hBF3Oosjdx0D8oRZaN522Ce09SiuRWfI3VZ926UaA17mzr5o4Oeb4GfRdH6AGlbXZcverCQeES3JPnMUcSfcmWwfqYlsq5sD+yM53s3uqiWdHhF+Nddgtq7/ZpcoVX0w2H3LxzEWoazsIH19Od+hfU7t/bg/yEri7GTQMWOnCiagIinN9VOqKSSAfRukU4dT5zW3jycyCKyEMVoy0Sat92Ohp/waY3g96czXeHssNmy10oU1yvziRqpfDBK+WkqI99Abremsy+QhpzIT5QOG3r6P6i1eHKJGh2LTLHPWq1yKlsBmrbg8H+gckdSErWAedAu1HRY9JBifnsUtHHRnbzJfF3f43O9mgvwz1lUEEg/riRd13p6GYNs+4RXJLLYBFr8KK4mRBrhjfcIkG2Hj/ILOTzwinxcNS/Chn9qfWHc0R2QahvlMyq9nrB6auSrhBhExjF95zEix7SS0EqsKFmjiJzhUYfLgny5IbfIC361QmjV1N4CgG6QJAlz5AEI1OSlldMVZycCPzSnJyLCP5wY3SCj5vFx8x0bZny8wk6EA6iv5bQeWZYxCEKj6nPsc9iRJYgusQL6diD3hZEyGnoid1ti4m5y+R1DrUZI2CIo9FCPXeNaqK8iykMOmtoKDLGGGasUS9HoeyS068Old2HObXN0FA2iKttexy7lrm31gGcj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(186003)(508600001)(6486002)(316002)(66574015)(83380400001)(16576012)(6666004)(54906003)(5660300002)(2906002)(31686004)(26005)(66556008)(66946007)(36756003)(38100700002)(110136005)(66476007)(4326008)(8936002)(86362001)(8676002)(53546011)(2616005)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnpvcnZHdHI1RkRsRkJIaHc2bnNCLzNBQ2tlU2cyOTNvOGVkcHFOZDgzeEZH?=
 =?utf-8?B?aHl4SnpkcSsyeUdpMzdhamxsUkpaTDJ0NXJLaDdxMk95a285dG82SUVDc0s0?=
 =?utf-8?B?TFVlcWdQZTA4aW5Xb1RkZXVFbnlGbDZsVXpGU2ZRYXFTSFRQYjRNRkozVDY0?=
 =?utf-8?B?OG9sbTNMMUFNSm9UL1JZRFdYcjZ0TXkrSm9OSmZIa1NmSXkraVlXY3RLLzJI?=
 =?utf-8?B?cUxhbHkrNE1NWkErMEVWY3JvU0VhNk5tdEZCdW1MY1RRWXUrS0t2QTByaTRY?=
 =?utf-8?B?ekErSkpCaSt0TkgxbFFxMXRSczR4cm44UVNqT1Q1SEcvSW5PNUNsNmhPT2xR?=
 =?utf-8?B?bHIxVE1GcEtVTkJzT2NQNXpvdE1kUkV0RVNCU0NnTU4vMTc2azRNeVJBSWVF?=
 =?utf-8?B?d1gwR1VrYU1ITkhrc3d3cFJIRkYxMXhhZHpHdkpDb0lZOFNOZ29XbFMremcv?=
 =?utf-8?B?aGM3VWF1WmpIa2dVZzBCNkdrUWlKVmNjNVozUzZ5V0tvUGxMTTF1R2g1S3JG?=
 =?utf-8?B?QlEwc05aZWkvN2h3UXQ5blduQVJQREVVSEJaalJaYTMxYmY3TTMydUUxSkZi?=
 =?utf-8?B?NVR0NVo5aUgwQ3hXTDFReE5ZbkptaHc2MmFZOWxnaE01WmJBcVZMczBYTHFQ?=
 =?utf-8?B?Y1ZoWnhRUjg4Z3RSd1E4WDNuNDUvMkJlVG1aMisyZXNVSEJyc1hqZzNteGkr?=
 =?utf-8?B?NklHNVhnOG5GK2tFak94OUJsYlU2N2ZITTNMMGo4OGxuMlJNN3AyS2ZSVC9L?=
 =?utf-8?B?cUtRSU14T25GVVpxWGdQcHMvNkVUK25oc0ZqU3FRcS85U1F4U215dmZhMWFV?=
 =?utf-8?B?V2NtUndOTWlidklsWUI2di9Qenc0VnFucHZjSVY2Y2haNGcza2NvclhQZ25E?=
 =?utf-8?B?N1RxQTl3eFNnZVE2ME96RWZmODhPU2lZMkR6K3BtM2R3N3FjWEJQU0Qwdk0x?=
 =?utf-8?B?OEFrUTk3M2IwWjZwYlFOTVFFakxqbFRobDVZd2xlQ1JmSFc4VzI3Y2VDV25C?=
 =?utf-8?B?R0U1QW1nQmhlaW91aytvYVVZWURtVGhzdmVBK0xHcUtkS0JJNW5qYVNTZ1pl?=
 =?utf-8?B?Ulk0MnlDeWw5U1M0TndvR2NtUmhxZXcrQVpId2NRckhYRWU5eFdOdkFiL09Y?=
 =?utf-8?B?aTNzTWoyRTJmeTgrZmdsNjhvM1RvTjBqWmIyaE9RbDdGS0FsTVRpNXgvNDhp?=
 =?utf-8?B?T1FYbGRGTzdlbEt0aEdDU3JEOTZEeDJkYkRtLzVkSFppRjdJTGZGSE9RbU82?=
 =?utf-8?B?bGc2YzdKUW95VFRZNkwwSjAwaGE2Nm5ER3BlcVgwem1aN1VuRUtoakNDME9j?=
 =?utf-8?B?UzRWQ3R3YUZ0dTFXR0thK1BzRWJ2YWtuYWVaUS9WRzFCMEVsdGxCckZxK291?=
 =?utf-8?B?NWlyM1ZwanVZUVF3M2VkcER3aFEvbDYxS0xGQkgzNzY2dTNkajNySjRySSsy?=
 =?utf-8?B?aThvVlhFS05RQW5kN050TjNPYk56Ym9WSlhYRURSWjNzSWwva0Z3T0g0Nm1E?=
 =?utf-8?B?Nmk0bzFadExxM1hLSkxzVjhiemRLekRZVC9pVkMybEFIQ3FnYVVBeURSdWtl?=
 =?utf-8?B?MGZkWnk4a25rTTQ0bTdJZEpSMlhDQXl2enRUR1VnWW1YOVVoTHJtSzJhNXRX?=
 =?utf-8?B?MnN0VURoL0g0b1pyYy9pZGt0NWxQMUtwcTNITk9UNGFXNXF6SFgyZGVzQWdL?=
 =?utf-8?B?eWRvNHBha2cwVXZQRHR5WmZLL2J0aUZSc3RpcEhxaUFWdmR5TlhaSnYyS1Bv?=
 =?utf-8?B?V1p2bjJnNmEyV01ITGJEZUNaOGZMQWQydGRFUVkwVFFaSnI5bkNhRWpzejNU?=
 =?utf-8?B?QnJVb2tRYzZUOHMwQUJvdVZFaTJZUFlWUTlJTk9jU2VtL1hUOFNKeko4N05x?=
 =?utf-8?B?dHVmWnFhWlA5UUFLekZVVFBKbnpYdW9RV2l3NitSdjdvbnQ5RDkvc0lwTlNo?=
 =?utf-8?B?Y1FmNTlrb1hXYkNJUnBPWmdHcXZ3Umh2ZzdsSWp1a1l5VDdMN2RrNkdqWWFv?=
 =?utf-8?B?QWlRSjM0SUk1QXl2YzlKaCs1dyt1MUd1cGgvRkZrbUg1QnRuUVFzNUFqdm9p?=
 =?utf-8?B?U3JQUkZObjRCZEh4cWdrdkJyVFlmTzZFUUVERFFZVkVNS2JGWU1BZ2ZTU3J4?=
 =?utf-8?Q?QV2c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8879b9bd-5eb9-416a-eaf7-08d9b4bdd813
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 11:29:31.9477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PXR4P+8T1pRCNhrrzo6/bvM6ese4GXclEThnW8dTEoY2t3zu3fYcmJ1p05GLoyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1776
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.12.21 um 12:20 schrieb Yu, Lang:
> [AMD Official Use Only]
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Wednesday, December 1, 2021 6:49 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
>>
>> Am 01.12.21 um 11:44 schrieb Yu, Lang:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Wednesday, December 1, 2021 5:30 PM
>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
>>>> <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: add support to SMU debug option
>>>>
>>>> Am 01.12.21 um 10:24 schrieb Lang Yu:
>>>>> To maintain system error state when SMU errors occurred, which will
>>>>> aid in debugging SMU firmware issues, add SMU debug option support.
>>>>>
>>>>> It can be enabled or disabled via amdgpu_smu_debug debugfs file.
>>>>> When enabled, it makes SMU errors fatal.
>>>>> It is disabled by default.
>>>>>
>>>>> == Command Guide ==
>>>>>
>>>>> 1, enable SMU debug option
>>>>>
>>>>>     # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>>>
>>>>> 2, disable SMU debug option
>>>>>
>>>>>     # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>>>
>>>>> v3:
>>>>>     - Use debugfs_create_bool().(Christian)
>>>>>     - Put variable into smu_context struct.
>>>>>     - Don't resend command when timeout.
>>>>>
>>>>> v2:
>>>>>     - Resend command when timeout.(Lijo)
>>>>>     - Use debugfs file instead of module parameter.
>>>>>
>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>> Well the debugfs part looks really nice and clean now, but one more
>>>> comment below.
>>>>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 3 +++
>>>>>     drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            | 5 +++++
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 ++
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             | 8 +++++++-
>>>>>     4 files changed, 17 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> index 164d6a9e9fbb..86cd888c7822 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct amdgpu_device
>>>> *adev)
>>>>>     	if (!debugfs_initialized())
>>>>>     		return 0;
>>>>>
>>>>> +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
>>>>> +				  &adev->smu.smu_debug_mode);
>>>>> +
>>>>>     	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>>>     				  &fops_ib_preempt);
>>>>>     	if (IS_ERR(ent)) {
>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> index f738f7dc20c9..50dbf5594a9d 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> @@ -569,6 +569,11 @@ struct smu_context
>>>>>     	struct smu_user_dpm_profile user_dpm_profile;
>>>>>
>>>>>     	struct stb_context stb_context;
>>>>> +	/*
>>>>> +	 * When enabled, it makes SMU errors fatal.
>>>>> +	 * (0 = disabled (default), 1 = enabled)
>>>>> +	 */
>>>>> +	bool smu_debug_mode;
>>>>>     };
>>>>>
>>>>>     struct i2c_adapter;
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> index 6e781cee8bb6..d3797a2d6451 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>>>>> @@ -1919,6 +1919,8 @@ static int aldebaran_mode2_reset(struct
>>>> smu_context *smu)
>>>>>     out:
>>>>>     	mutex_unlock(&smu->message_lock);
>>>>>
>>>>> +	BUG_ON(unlikely(smu->smu_debug_mode) && ret);
>>>>> +
>>>>>     	return ret;
>>>>>     }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> index 048ca1673863..9be005eb4241 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> @@ -349,15 +349,21 @@ int smu_cmn_send_smc_msg_with_param(struct
>>>> smu_context *smu,
>>>>>     		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>>>>     		goto Out;
>>>>>     	}
>>>>> +
>>>>>     	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>>>>>     	reg = __smu_cmn_poll_stat(smu);
>>>>>     	res = __smu_cmn_reg2errno(smu, reg);
>>>>> -	if (res != 0)
>>>>> +	if (res != 0) {
>>>>>     		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>>>> +		goto Out;
>>>>> +	}
>>>>>     	if (read_arg)
>>>>>     		smu_cmn_read_arg(smu, read_arg);
>>>>>     Out:
>>>>>     	mutex_unlock(&smu->message_lock);
>>>>> +
>>>>> +	BUG_ON(unlikely(smu->smu_debug_mode) && res);
>>>> BUG_ON() really crashes the kernel and is only allowed if we prevent
>>>> further data corruption with that.
>>>>
>>>> Most of the time WARN_ON() is more appropriate, but I can't fully
>>>> judge here since I don't know the SMU code well enough.
>>> This is what SMU FW guys want. They want "user-visible (potentially fatal)
>> errors", then a hang.
>>> They want to keep system state since the error occurred.
>> Well that is rather problematic.
>>
>> First of all we need to really justify that, crashing the kernel is not something
>> easily done.
>>
>> Then this isn't really effective here. What happens is that you crash the kernel
>> thread of the currently executing process, but it is perfectly possible that another
>> thread still tries to send messages to the SMU. You need to have the BUG_ON()
>> before dropping the lock to make sure that this really gets the driver stuck in the
>> current state.
> Thanks. I got it. I just thought it is a kenel panic.
> Could we use a panic() here?

Potentially, but that might reboot the system automatically which is 
probably not what you want either.

How does the SMU firmware team gather the necessary information when a 
problem occurs?

When they connect external hardware a BUG_ON() while holding the SMU 
lock might work, but if they want to SSH into the system you should 
probably rather set a flag that the hardware shouldn't be touched any 
more by the driver and continue.

Otherwise the box is most likely really unstable after this.

Regards,
Christian.

>
> Regards,
> Lang
>
>> Regards,
>> Christian.
>>
>>> Regards,
>>> Lang
>>>
>>>> Christian.
>>>>
>>>>> +
>>>>>     	return res;
>>>>>     }
>>>>>

