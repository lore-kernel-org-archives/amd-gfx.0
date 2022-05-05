Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D2FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 19:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E01B010F23C;
	Thu,  5 May 2022 19:49:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93DE110F238
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 19:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoqYsCnzarBKDAdSbs2uOLjyvfxyY9ncvnxZRhuLC8A5PsKq9OFGPO/7REiZ0zs2VrWh9v6Zsg9umEzY6xSPjtXGAZJu2Q0Ef+Ca6JXDKKSg2/XH4j+q8rG/T0sWKQwaZLXxscvH7HLukxKXF8EcpQpTCk5yGPz3M/ND4UT35ihs5TMiW+7uQ6je+7gcOf5i3IOubHv3seIGb2NH/Ce+FV28J/4jZkLhkwzzO8rH4RTWlSN6kY0OU+VfT+8xM83lj5Chi8646i6+9ANYuB37SKaWiRGmxzY86jRBtP7SnthULdNyYgedzhMd6VDZy5fdqPKHrUCd0WBuCobHjWM8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QYHI3Le+DyjvmMDJS0PpQqOxaLuscRqxJuOb19TZw0=;
 b=E0MTK93+gEkySUp0r7AXK/RhbSL2gmG+G89Oqk3LyEDLGx5LMc1XZ9KbdDkZYazPzTNKKcbtfN/vupstJyCbLwrKZ1cfgOLS5z86LjK3I4fHwF+sDQ0dif/G1QZD3orrfbByPfBa02M2XFFlcQJ1H86H5ClOYXcJZnyNGasI1Akm+hne5ffGhYbdSm8bTRXAzqtepGLX4pvKjxu0f48BfVRrcvoUbPZXTjTHiJVaEaR6hfaT7NUZspheEU7lL+hfLUQAYSSI7jGaBOYlA45Zo8bIU+fPJb/nnEHqtm7Pu6cZeHqgr5CmSNfbzhA8Wmo+gENVyi0M+4AwkaBZBYdXSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QYHI3Le+DyjvmMDJS0PpQqOxaLuscRqxJuOb19TZw0=;
 b=0ec+ccE5v/NZY982SxKLRT8dBjs/JnX4qg2Pt6x1H0dcyqZtu1rlTyDEJZOiiew9mD73bGvcbOiB66fLKZLvuuxUQ6tdRirXlzf/WE7yi2DIKc1tK/V/ilvqlpjw/C8GwfOPbK5Rzi41+bd5zOtabQCYUCCH/RV2xY0urNdE63Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MWHPR12MB1296.namprd12.prod.outlook.com (2603:10b6:300:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 19:49:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 19:49:53 +0000
Message-ID: <05a18be9-dcc3-9246-b572-e47ccf5e804b@amd.com>
Date: Thu, 5 May 2022 15:49:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <7e9f45be-41a0-0764-8f4d-2787319477fb@amd.com>
 <80f0a3d8-5b42-f1b3-5396-464c665361c7@amd.com>
 <aec08997-9565-a596-f143-eccf92653a84@amd.com>
 <8ea0a998-b056-8cbf-d666-5305fd124a5d@amd.com>
 <40baeccc-86c0-5fc2-c970-c0bf8b6b6943@amd.com>
 <384abcbc-c5e9-3732-7257-7f7bbf4c704b@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <384abcbc-c5e9-3732-7257-7f7bbf4c704b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 895ad501-49e6-41df-c191-08da2ed06c01
X-MS-TrafficTypeDiagnostic: MWHPR12MB1296:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1296375C0CF50F608059B53792C29@MWHPR12MB1296.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orLbWKQTDxfP6/q0CJiNjHn3sUILQkZZ2dZUzV+oQEvx2/E/B6V2g+NEAG+u+JSf/FVjRwdkMmmAvrRo6wvgztkeaW2Ovvd10Fsp87bbJjTqi04zJ1xgU3rYrjGHSg7P6c0b3A7s1CrtvELKW0RrCRDtZPv/66UUSDBD7o5aXfAf3tOnwCRhXmb5SGVv9urPlxqGZFd+RJ68KKzlYgbn2NMe3I/Ax0uNavZQhJOoj36yvNKIdhYVACvZgS9vvFDx/Oq0gBew9QQ8+NH8+vx0fNse2nQqf0JnKk8lBrEOUHGfsYIg5TOXWBRDfOBVTI3FOYGmTqj6AteNCe7bMy3iF4iow6OSV1d3Y/OBqE2eK8+CAXB0khahXQWJvc/m6z36eq9KScOSN6JwJEp+7KsthHBJfHbw3xD0MlGpX3YAIoLn4lxzheK622RRt94KC7NQruWxtGK7kQCInVVBZwkW1pieHHpW6hz80CI1xpw3W2/5eZRexKnnIBNQnSh+BzcldrWAr1Fw8X2C7YluoDrTgHvAQOA9lrIq6vBCweEmvOll+r41csTWx5YT9yii1alBueuoU61a3sLhwkrlhw6pBbyqOeVpB+v6QX9gk79yUoCwOBldB+2GZjsqvCeSiqI1lLNAnknK/KNhcLL7kbfjhY6hIcpV6hdj65V3EeTzRxKHwtj5IfRPIJpJFGVuotj7JWH69SnVYQ9rTM1Sao+nW7ahGvq/Z4+O1aYjXROI3gM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66946007)(38100700002)(8676002)(66476007)(66556008)(8936002)(44832011)(110136005)(5660300002)(30864003)(6486002)(508600001)(2906002)(86362001)(31696002)(316002)(66574015)(2616005)(83380400001)(36756003)(186003)(26005)(6506007)(53546011)(31686004)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzhtM1c0UXZheHJGNWtSbDZXK0xRU3lHTCs1MlloK0NTdStKanRwZGZHZVVD?=
 =?utf-8?B?UlBwMjZ3QzlWZjdJdEZqQWhxbTd3OWRjY0xPd2JXeUJaUkdERzJVT2VGaEIw?=
 =?utf-8?B?cGhkdHJQcVpCR05qY1lRaDd4a0p0eXdzKzhxNlRVZ1BPYkxIdHNUbmU5eWtv?=
 =?utf-8?B?cFdBQm5UbVFmenlDVFFNQkE3OVFpWGFiMFpubDdWOWZtd3ptanV6Z3RhTXc0?=
 =?utf-8?B?SkN4dDJSZGVueDJVN1lhOHB5V1EzSWVTQlVic3JUMzYxaDJyU2w0ZVMyejY3?=
 =?utf-8?B?aDA1OFZpTGsyNFMzanNJTG1BbUZUd09za1k2N3c3bEU5YVg4WHFXVFQ5NThs?=
 =?utf-8?B?TlBBSFRQNVhoRWpTY1I4SC9EWXZXNkVEdVpDZHpzSFdiNGhnT2tCTXlJeVBs?=
 =?utf-8?B?N2Zla0x1VlBpazRRM1QvWjJhQ3pCRGVKZnBKY2lnUlB4U2JFMEVWUm5ZTUk5?=
 =?utf-8?B?QXBGNFJhZDl1dnh5TTVyY2JXbU1UZUZkaGhxTUx4WXdxWm15VFF4Z1JjRlhN?=
 =?utf-8?B?OEUxclJXMGY4TjFISnI1MDJnQUpxYVpEcTBlb1dqZkVhU21qUTdTSHRuSU5x?=
 =?utf-8?B?Qkk5bi82TTRvSnpOR0djeVk3K2JGRk5Da3JSaWdZZG10NE0rSVJxeDN6VW9Z?=
 =?utf-8?B?bkhWU1lIK3hMWVdraEtjcnVXZjVqNnFKN2djakNQZlJHQml3WUQ5bkVUMXdX?=
 =?utf-8?B?cVozYUR1WGZoM1NvcnF4clJLSjllUS84RFdnNjFtdy9SeHlHdy9vM3pEYUFV?=
 =?utf-8?B?b1pCNnF3S0txZ2NpMmtqOC92ZDJlcHJyeHFHUEExbEhDNzdpa3BkM1YrMGdk?=
 =?utf-8?B?RkZIUEMzY1RxQ0cwcERzRlJycW5iNU15TkxwYkxsaW5YT3NFVk1SdzQvZGgy?=
 =?utf-8?B?d01hU25hYXdNbC91dDBiT0JjUktLbGF3YUpvQUVRajRjQUNEbmhRR2VLWXZy?=
 =?utf-8?B?ODhGS2JIQnpXY1d5WXdYZ3VTdlpVamw5S0NMNXJFK01XQ2c3Z25LUnE1Zkt3?=
 =?utf-8?B?RElFQ2FOVnNlOThNZFRoYmZRaWpaU0dVeEhqVVhhRWppN1B5UGp3a25iNjhF?=
 =?utf-8?B?dXpCWHM4a01GbE9HMUlUNW93UHpHdzZRNDdINDdlbVFqSnJxb3djdzRXYXRo?=
 =?utf-8?B?NjVHVHlCaU5LN1ZLelZ6eGlDbkczcTZsTjRxWDR6QjJSL0FKRCtQSnc5bG96?=
 =?utf-8?B?QnpiT3F2UGx1RzJpZVVPeUJPaXpVai9ubXhtT3p3cWtzZ0cwTGtkK3dnaUtl?=
 =?utf-8?B?YVI5NEVkMDA2WTQycDNZclFIVVBodys0T3BqTm1zV0pDYTE2dHNDT3JBUERh?=
 =?utf-8?B?R0xvSWkxdE9GU0UwUFRybEN3Z0VUazFzNW1mQzE4TVByajh2K2lIeDJ4NUNr?=
 =?utf-8?B?RWNGbUJJSDhuZzFONTRRSnhOOFRtMW80SWVDbW1hSVRTYnFaMG0xQUVOUjIx?=
 =?utf-8?B?d05qcjZTK09hSTRqVVNZMHdZRFdDQ2JObkVzMUFmakZyM3VIc1lXMmJRSkky?=
 =?utf-8?B?dmhhV0ttcldNaU9RN1R1eWtDY2ZEd3IwYW5hem0rTjBwMzZqSUxTbFVUNC9E?=
 =?utf-8?B?bEs4bmdwdVowODd3a0luOXhCL2JBVi9ORWtnYmFWVDBhcDA1TWZjSmQ3RDZO?=
 =?utf-8?B?MFZPekFrblloR2dwVTlWdVIwOGxVZy9vaFF0cWJwNWlzQXBnUGg0WWRUVHl4?=
 =?utf-8?B?KzA1bThRc29mWjkzbWc4Wk02OGRtRE5JN2tJeUFYWU5QWS9CM3hpUG1OeVVY?=
 =?utf-8?B?ZTIxZVgrK0luWWF3N29xb0p3dmJINXp1ZUJhZkRHb1dnaWlhTWhxaS9TS3hI?=
 =?utf-8?B?OGUzeG15RW5XamgzaFA4Z2UrSVFRa0VmbmRSbzBLRlpPa1p6TmZLZ0FFSnla?=
 =?utf-8?B?T3hsYUpYQndYMVlEdGFabXluRXJpQ2NVNmM2NDB4M1BadGlsem5LMS9WOTNO?=
 =?utf-8?B?UlNNV09CUTl6RlUvT3E2ZHptWU5DRXZGWm9iQ2s1RHNqZy9FbVVOUUcvSVM0?=
 =?utf-8?B?V0tUNVk0b2xVOUN3KytTeEV1Q214QXhjQUNSTS9pUG1KeVA5UHFPQnhnRzFN?=
 =?utf-8?B?M0pabE40eCs1Zlc3MWt2c0pBTmdhZ3hCSWJZL2x4TVEyUHc3dEttcStKTzV4?=
 =?utf-8?B?Rno5dGtjNzljOHRJRnMzQnlxSFI1RFFkbzllUHIyamlpQ09VU2JRWGRiamZM?=
 =?utf-8?B?R3dxZjdDc3BkQUNXclA0WktEblNmaTUvSG92MDJFZVZpTTdKM3lDbm1MNlBR?=
 =?utf-8?B?VFI5eXBveUJTYURFY3V4dEdqdnQwNVRXaWxZTlo3TTk4cTYxalVtTlVTQ2VC?=
 =?utf-8?B?cjV0V29zeE5GZnpReUV0NEU1WExjK0VuUUdqK2U4cDM4MThwUFRlUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895ad501-49e6-41df-c191-08da2ed06c01
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 19:49:52.8194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zq0a/xMd/KAy84P4OUMYwXXhMMkQLRHr2m1G0Nvy5IUVCT77ZbTFbyxG2BFIkGumMtIjJ9ZlDd372GS0lmrKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1296
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
Cc: Bai Zoy <Zoy.Bai@amd.com>, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-05-05 um 14:57 schrieb Andrey Grodzovsky:
>
> On 2022-05-05 11:06, Christian König wrote:
>> Am 05.05.22 um 15:54 schrieb Andrey Grodzovsky:
>>>
>>> On 2022-05-05 09:23, Christian König wrote:
>>>> Am 05.05.22 um 15:15 schrieb Andrey Grodzovsky:
>>>>> On 2022-05-05 06:09, Christian König wrote:
>>>>>
>>>>>> Am 04.05.22 um 18:18 schrieb Andrey Grodzovsky:
>>>>>>> Problem:
>>>>>>> During hive reset caused by command timing out on a ring
>>>>>>> extra resets are generated by triggered by KFD which is
>>>>>>> unable to accesses registers on the resetting ASIC.
>>>>>>>
>>>>>>> Fix: Rework GPU reset to use a list of pending reset jobs
>>>>>>> such that the first reset jobs that actaully resets the entire
>>>>>>> reset domain will cancel all those pending redundant resets.
>>>>>>>
>>>>>>> This is in line with what we already do for redundant TDRs
>>>>>>> in scheduler code.
>>>>>>
>>>>>> Mhm, why exactly do you need the extra linked list then?
>>>>>>
>>>>>> Let's talk about that on our call today.
>>>>>
>>>>>
>>>>> Going to miss it as you know, and also this is the place to 
>>>>> discuss technical questions anyway so -
>>>>
>>>> Good point.
>>>>
>>>>> It's needed because those other resets are not time out handlers 
>>>>> that are governed by the scheduler
>>>>> but rather external resets that are triggered by such clients as 
>>>>> KFD, RAS and sysfs. Scheduler has no
>>>>> knowledge of them (and should not have) but they are serialized 
>>>>> into same wq as the TO handlers
>>>>> from the scheduler. It just happens that TO triggered reset causes 
>>>>> in turn another reset (from KFD in
>>>>> this case) and we want to prevent this second reset from taking 
>>>>> place just as we want to avoid multiple
>>>>> TO resets to take place in scheduler code.
>>>>
>>>> Yeah, but why do you need multiple workers?
>>>>
>>>> You have a single worker for the GPU reset not triggered by the 
>>>> scheduler in you adev and cancel that at the end of the reset 
>>>> procedure.
>>>>
>>>> If anybody things it needs to trigger another reset while in reset 
>>>> (which is actually a small design bug separately) the reset will 
>>>> just be canceled in the same way we cancel the scheduler resets.
>>>>
>>>> Christian.
>>>
>>>
>>> Had this in mind at first but then I realized that each client (RAS, 
>>> KFD and sysfs) will want to fill his own data for the work (see 
>>> amdgpu_device_gpu_recover) - for XGMI hive each will want to set his 
>>> own adev (which is fine if you set a work per adev as you suggest) 
>>> but also each client might want (they all put NULL there but in 
>>> theory in the future) also set his own bad job value and here you 
>>> might have a collision.
>>
>> Yeah, but that is intentional. See when we have a job that needs to 
>> be consumed by the reset handler and not overwritten or something.
>
>
> I am not sure why this is a requirement, multiple clients can decide 
> concurrently to trigger a reset for some reason (possibly independent 
> reasons) hence they cannot share same work struct to pass to it their 
> data.

If those concurrent clients could detect that a reset was already in 
progress, you wouldn't need the complexity of multiple work structs 
being scheduled. You could simply return without triggering another reset.

I'd put the reset work struct into the reset_domain struct. That way 
you'd have exactly one worker for the reset domain. You could implement 
a lock-less scheme to decide whether you need to schedule a reset, e.g. 
using an atomic counter in the shared work struct that gets incremented 
when a client wants to trigger a reset (atomic_add_return). If that 
counter is exactly 1 after incrementing, you need to fill in the rest of 
the work struct and schedule the work. Otherwise, it's already scheduled 
(or another client is in the process of scheduling it) and you just 
return. When the worker finishes (after confirming a successful reset), 
it resets the counter to 0, so the next client requesting a reset will 
schedule the worker again.

Regards,
   Felix


>
>
>>
>>
>> Additional to that keep in mind that you can't allocate any memory 
>> before or during the GPU reset nor wait for the reset to complete (so 
>> you can't allocate anything on the stack either).
>
>
> There is no dynamic allocation here, regarding stack allocations - we 
> do it all the time when we call functions, even during GPU resets, how 
> on stack allocation of work struct in amdgpu_device_gpu_recover is 
> different from any other local variable we allocate in any function we 
> call ?
>
> I am also not sure why it's not allowed to wait for reset to complete 
> ? Also, see in amdgpu_ras_do_recovery and gpu_recover_get (debugfs) - 
> the caller expects the reset to complete before he returns. I can 
> probably work around it in RAS code by calling 
> atomic_set(&ras->in_recovery, 0)  from some callback within actual 
> reset function but regarding sysfs it actually expects a result 
> returned indicating whether the call was successful or not.
>
> Andrey
>
>
>>
>> I don't think that concept you try here will work.
>>
>> Regards,
>> Christian.
>>
>>> Also in general seems to me it's cleaner approach where this logic 
>>> (the work items) are held and handled in reset_domain and are not 
>>> split in each adev or any other entity. We might want in the future 
>>> to even move the scheduler handling into reset domain since reset 
>>> domain is supposed to be a generic things and not only or AMD.
>>>
>>> Andrey
>>>
>>>
>>>>
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>>> Tested-by: Bai Zoy <Zoy.Bai@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 11 +---
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++--
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  3 +
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 73 
>>>>>>> +++++++++++++++++++++-
>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  3 +-
>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  7 ++-
>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  7 ++-
>>>>>>>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  7 ++-
>>>>>>>   8 files changed, 104 insertions(+), 24 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> index 4264abc5604d..99efd8317547 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>>> @@ -109,6 +109,7 @@
>>>>>>>   #include "amdgpu_fdinfo.h"
>>>>>>>   #include "amdgpu_mca.h"
>>>>>>>   #include "amdgpu_ras.h"
>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>     #define MAX_GPU_INSTANCE        16
>>>>>>>   @@ -509,16 +510,6 @@ struct amdgpu_allowed_register_entry {
>>>>>>>       bool grbm_indexed;
>>>>>>>   };
>>>>>>>   -enum amd_reset_method {
>>>>>>> -    AMD_RESET_METHOD_NONE = -1,
>>>>>>> -    AMD_RESET_METHOD_LEGACY = 0,
>>>>>>> -    AMD_RESET_METHOD_MODE0,
>>>>>>> -    AMD_RESET_METHOD_MODE1,
>>>>>>> -    AMD_RESET_METHOD_MODE2,
>>>>>>> -    AMD_RESET_METHOD_BACO,
>>>>>>> -    AMD_RESET_METHOD_PCI,
>>>>>>> -};
>>>>>>> -
>>>>>>>   struct amdgpu_video_codec_info {
>>>>>>>       u32 codec_type;
>>>>>>>       u32 max_width;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index e582f1044c0f..7fa82269c30f 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -5201,6 +5201,12 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>>>>> amdgpu_device *adev,
>>>>>>>       }
>>>>>>>         tmp_vram_lost_counter = 
>>>>>>> atomic_read(&((adev)->vram_lost_counter));
>>>>>>> +
>>>>>>> +    /* Drop all pending resets since we will reset now anyway */
>>>>>>> +    tmp_adev = list_first_entry(device_list_handle, struct 
>>>>>>> amdgpu_device,
>>>>>>> +                        reset_list);
>>>>>>> + amdgpu_reset_pending_list(tmp_adev->reset_domain);
>>>>>>> +
>>>>>>>       /* Actual ASIC resets if needed.*/
>>>>>>>       /* Host driver will handle XGMI hive reset for SRIOV */
>>>>>>>       if (amdgpu_sriov_vf(adev)) {
>>>>>>> @@ -5296,7 +5302,7 @@ int amdgpu_device_gpu_recover_imp(struct 
>>>>>>> amdgpu_device *adev,
>>>>>>>   }
>>>>>>>     struct amdgpu_recover_work_struct {
>>>>>>> -    struct work_struct base;
>>>>>>> +    struct amdgpu_reset_work_struct base;
>>>>>>>       struct amdgpu_device *adev;
>>>>>>>       struct amdgpu_job *job;
>>>>>>>       int ret;
>>>>>>> @@ -5304,7 +5310,7 @@ struct amdgpu_recover_work_struct {
>>>>>>>     static void amdgpu_device_queue_gpu_recover_work(struct 
>>>>>>> work_struct *work)
>>>>>>>   {
>>>>>>> -    struct amdgpu_recover_work_struct *recover_work = 
>>>>>>> container_of(work, struct amdgpu_recover_work_struct, base);
>>>>>>> +    struct amdgpu_recover_work_struct *recover_work = 
>>>>>>> container_of(work, struct amdgpu_recover_work_struct, 
>>>>>>> base.base.work);
>>>>>>>         recover_work->ret = 
>>>>>>> amdgpu_device_gpu_recover_imp(recover_work->adev, 
>>>>>>> recover_work->job);
>>>>>>>   }
>>>>>>> @@ -5316,12 +5322,15 @@ int amdgpu_device_gpu_recover(struct 
>>>>>>> amdgpu_device *adev,
>>>>>>>   {
>>>>>>>       struct amdgpu_recover_work_struct work = {.adev = adev, 
>>>>>>> .job = job};
>>>>>>>   -    INIT_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
>>>>>>> +    INIT_DELAYED_WORK(&work.base.base, 
>>>>>>> amdgpu_device_queue_gpu_recover_work);
>>>>>>> +    INIT_LIST_HEAD(&work.base.node);
>>>>>>>         if (!amdgpu_reset_domain_schedule(adev->reset_domain, 
>>>>>>> &work.base))
>>>>>>>           return -EAGAIN;
>>>>>>>   -    flush_work(&work.base);
>>>>>>> +    flush_delayed_work(&work.base.base);
>>>>>>> +
>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>> &work.base);
>>>>>>>         return work.ret;
>>>>>>>   }
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>> index c80af0889773..ffddd419c351 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>>> @@ -134,6 +134,9 @@ struct amdgpu_reset_domain 
>>>>>>> *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>>>>>>>       atomic_set(&reset_domain->in_gpu_reset, 0);
>>>>>>>       init_rwsem(&reset_domain->sem);
>>>>>>>   + INIT_LIST_HEAD(&reset_domain->pending_works);
>>>>>>> +    mutex_init(&reset_domain->reset_lock);
>>>>>>> +
>>>>>>>       return reset_domain;
>>>>>>>   }
>>>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>> index 1949dbe28a86..863ec5720fc1 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>>>>>> @@ -24,7 +24,18 @@
>>>>>>>   #ifndef __AMDGPU_RESET_H__
>>>>>>>   #define __AMDGPU_RESET_H__
>>>>>>>   -#include "amdgpu.h"
>>>>>>> +
>>>>>>> +#include <linux/atomic.h>
>>>>>>> +#include <linux/mutex.h>
>>>>>>> +#include <linux/list.h>
>>>>>>> +#include <linux/kref.h>
>>>>>>> +#include <linux/rwsem.h>
>>>>>>> +#include <linux/workqueue.h>
>>>>>>> +
>>>>>>> +struct amdgpu_device;
>>>>>>> +struct amdgpu_job;
>>>>>>> +struct amdgpu_hive_info;
>>>>>>> +
>>>>>>>     enum AMDGPU_RESET_FLAGS {
>>>>>>>   @@ -32,6 +43,17 @@ enum AMDGPU_RESET_FLAGS {
>>>>>>>       AMDGPU_SKIP_HW_RESET = 1,
>>>>>>>   };
>>>>>>>   +
>>>>>>> +enum amd_reset_method {
>>>>>>> +    AMD_RESET_METHOD_NONE = -1,
>>>>>>> +    AMD_RESET_METHOD_LEGACY = 0,
>>>>>>> +    AMD_RESET_METHOD_MODE0,
>>>>>>> +    AMD_RESET_METHOD_MODE1,
>>>>>>> +    AMD_RESET_METHOD_MODE2,
>>>>>>> +    AMD_RESET_METHOD_BACO,
>>>>>>> +    AMD_RESET_METHOD_PCI,
>>>>>>> +};
>>>>>>> +
>>>>>>>   struct amdgpu_reset_context {
>>>>>>>       enum amd_reset_method method;
>>>>>>>       struct amdgpu_device *reset_req_dev;
>>>>>>> @@ -40,6 +62,8 @@ struct amdgpu_reset_context {
>>>>>>>       unsigned long flags;
>>>>>>>   };
>>>>>>>   +struct amdgpu_reset_control;
>>>>>>> +
>>>>>>>   struct amdgpu_reset_handler {
>>>>>>>       enum amd_reset_method reset_method;
>>>>>>>       struct list_head handler_list;
>>>>>>> @@ -76,12 +100,21 @@ enum amdgpu_reset_domain_type {
>>>>>>>       XGMI_HIVE
>>>>>>>   };
>>>>>>>   +
>>>>>>> +struct amdgpu_reset_work_struct {
>>>>>>> +    struct delayed_work base;
>>>>>>> +    struct list_head node;
>>>>>>> +};
>>>>>>> +
>>>>>>>   struct amdgpu_reset_domain {
>>>>>>>       struct kref refcount;
>>>>>>>       struct workqueue_struct *wq;
>>>>>>>       enum amdgpu_reset_domain_type type;
>>>>>>>       struct rw_semaphore sem;
>>>>>>>       atomic_t in_gpu_reset;
>>>>>>> +
>>>>>>> +    struct list_head pending_works;
>>>>>>> +    struct mutex reset_lock;
>>>>>>>   };
>>>>>>>     @@ -113,9 +146,43 @@ static inline void 
>>>>>>> amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
>>>>>>>   }
>>>>>>>     static inline bool amdgpu_reset_domain_schedule(struct 
>>>>>>> amdgpu_reset_domain *domain,
>>>>>>> -                        struct work_struct *work)
>>>>>>> +                        struct amdgpu_reset_work_struct *work)
>>>>>>>   {
>>>>>>> -    return queue_work(domain->wq, work);
>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>> +
>>>>>>> +    if (!queue_delayed_work(domain->wq, &work->base, 0)) {
>>>>>>> +        mutex_unlock(&domain->reset_lock);
>>>>>>> +        return false;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    list_add_tail(&work->node, &domain->pending_works);
>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>> +
>>>>>>> +    return true;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void amdgpu_reset_domain_del_pendning_work(struct 
>>>>>>> amdgpu_reset_domain *domain,
>>>>>>> +                  struct amdgpu_reset_work_struct *work)
>>>>>>> +{
>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>> +    list_del_init(&work->node);
>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void amdgpu_reset_pending_list(struct 
>>>>>>> amdgpu_reset_domain *domain)
>>>>>>> +{
>>>>>>> +    struct amdgpu_reset_work_struct *entry, *tmp;
>>>>>>> +
>>>>>>> +    mutex_lock(&domain->reset_lock);
>>>>>>> +    list_for_each_entry_safe(entry, tmp, 
>>>>>>> &domain->pending_works, node) {
>>>>>>> +
>>>>>>> +        list_del_init(&entry->node);
>>>>>>> +
>>>>>>> +        /* Stop any other related pending resets */
>>>>>>> +        cancel_delayed_work(&entry->base);
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    mutex_unlock(&domain->reset_lock);
>>>>>>>   }
>>>>>>>     void amdgpu_device_lock_reset_domain(struct 
>>>>>>> amdgpu_reset_domain *reset_domain);
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>> index 239f232f9c02..574e870d3064 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>>>>>>> @@ -25,6 +25,7 @@
>>>>>>>   #define AMDGPU_VIRT_H
>>>>>>>     #include "amdgv_sriovmsg.h"
>>>>>>> +#include "amdgpu_reset.h"
>>>>>>>     #define AMDGPU_SRIOV_CAPS_SRIOV_VBIOS  (1 << 0) /* vBIOS is 
>>>>>>> sr-iov ready */
>>>>>>>   #define AMDGPU_SRIOV_CAPS_ENABLE_IOV   (1 << 1) /* sr-iov is 
>>>>>>> enabled on this GPU */
>>>>>>> @@ -230,7 +231,7 @@ struct amdgpu_virt {
>>>>>>>       uint32_t            reg_val_offs;
>>>>>>>       struct amdgpu_irq_src        ack_irq;
>>>>>>>       struct amdgpu_irq_src        rcv_irq;
>>>>>>> -    struct work_struct        flr_work;
>>>>>>> +    struct amdgpu_reset_work_struct flr_work;
>>>>>>>       struct amdgpu_mm_table        mm_table;
>>>>>>>       const struct amdgpu_virt_ops    *ops;
>>>>>>>       struct amdgpu_vf_error_buffer    vf_errors;
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>> index b81acf59870c..f3d1c2be9292 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>> @@ -251,7 +251,7 @@ static int 
>>>>>>> xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>     static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>>>>>>>   {
>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>> amdgpu_virt, flr_work);
>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>> amdgpu_device, virt);
>>>>>>>       int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>   @@ -380,7 +380,8 @@ int xgpu_ai_mailbox_get_irq(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>           return r;
>>>>>>>       }
>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>> xgpu_ai_mailbox_flr_work);
>>>>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>         return 0;
>>>>>>>   }
>>>>>>> @@ -389,6 +390,8 @@ void xgpu_ai_mailbox_put_irq(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>   {
>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>> +
>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>> &adev->virt.flr_work);
>>>>>>>   }
>>>>>>>     static int xgpu_ai_request_init_data(struct amdgpu_device 
>>>>>>> *adev)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>> index 22c10b97ea81..927b3d5bb1d0 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>>>>>>> @@ -275,7 +275,7 @@ static int 
>>>>>>> xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>     static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>>>>>>>   {
>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>> amdgpu_virt, flr_work);
>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>> amdgpu_device, virt);
>>>>>>>       int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>>>>>>>   @@ -407,7 +407,8 @@ int xgpu_nv_mailbox_get_irq(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>           return r;
>>>>>>>       }
>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>> xgpu_nv_mailbox_flr_work);
>>>>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>         return 0;
>>>>>>>   }
>>>>>>> @@ -416,6 +417,8 @@ void xgpu_nv_mailbox_put_irq(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>   {
>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>> +
>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>> &adev->virt.flr_work);
>>>>>>>   }
>>>>>>>     const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c 
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>> index 7b63d30b9b79..1d4ef5c70730 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>>>>>>> @@ -512,7 +512,7 @@ static int 
>>>>>>> xgpu_vi_set_mailbox_ack_irq(struct amdgpu_device *adev,
>>>>>>>     static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>>>>>>>   {
>>>>>>> -    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>> amdgpu_virt, flr_work);
>>>>>>> +    struct amdgpu_virt *virt = container_of(work, struct 
>>>>>>> amdgpu_virt, flr_work.base.work);
>>>>>>>       struct amdgpu_device *adev = container_of(virt, struct 
>>>>>>> amdgpu_device, virt);
>>>>>>>         /* wait until RCV_MSG become 3 */
>>>>>>> @@ -610,7 +610,8 @@ int xgpu_vi_mailbox_get_irq(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>           return r;
>>>>>>>       }
>>>>>>>   -    INIT_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
>>>>>>> + INIT_DELAYED_WORK(&adev->virt.flr_work.base, 
>>>>>>> xgpu_vi_mailbox_flr_work);
>>>>>>> +    INIT_LIST_HEAD(&adev->virt.flr_work.node);
>>>>>>>         return 0;
>>>>>>>   }
>>>>>>> @@ -619,6 +620,8 @@ void xgpu_vi_mailbox_put_irq(struct 
>>>>>>> amdgpu_device *adev)
>>>>>>>   {
>>>>>>>       amdgpu_irq_put(adev, &adev->virt.ack_irq, 0);
>>>>>>>       amdgpu_irq_put(adev, &adev->virt.rcv_irq, 0);
>>>>>>> +
>>>>>>> + amdgpu_reset_domain_del_pendning_work(adev->reset_domain, 
>>>>>>> &adev->virt.flr_work);
>>>>>>>   }
>>>>>>>     const struct amdgpu_virt_ops xgpu_vi_virt_ops = {
>>>>>>
>>>>
>>
