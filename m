Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E372C5475B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 15:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B73210E4B3;
	Tue, 20 Feb 2024 15:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M526TRoB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0109210E4B3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 15:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFwtYBwt/mePXfabdhN822K1wsRo6qK2H9BgYcy+REWE1KrE8umcX/I3y92fF5eU6y+CkCnHjfoLR+wc78HHhaGH1RxKqprrPTUhJ7O0KjeeI+suiIiQfs75I1dsafwz2nDcJrrLZ6YAMdya5wvXm8oIbYL+owvclZZ4zotyRd1lQLzsT+q9AFgw4asmfih8tzSMzxOjtaCeysAK0yoSTvDFgaeYQjvQ5EdmYWUgvWdiGir7XWWpTmChHmcQBL89LUyO+JYRDoEz4jBZyVawsQ74R3QPHwNE0AK2cFeN59uj5RnWdwtmVmKf3pH+q/ZPy5lX7qGBIMppxB5ppbPSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Od+FQT2q9wvY5GlSdsbeRKJ0vW4Oi9SW5ApB+U5wbQ=;
 b=Eif7B9ft8v0CpcaN/D3NV7cCDei8XdliQufQ1bXskZfy8A72o425tWMMsrVee7Wz4cJ/PRjJi6jCSDflqWOVofieepPAdwNymCPsgpG4TKyHUX9ngzGe4/5r7reIzZPYEcvTQG0XkvZHh6gIab675qS5se2ryAdNU9GUwYV3hhrxU9W4r/azG/6hCTxhu82QMW7wMp4ZCpsdL9zF5xgb7fenZv1Fu/4Mkx4tY7AMLWW6qmULcBJ4PmiO3JK4AwopdvdczdIL2oZjYgAzeugvv/2H7g0XiHEatyhokFtlIRa7g134pdjm/Um9FeWGpSJqyfy4uEb+GucHY83RKyGbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Od+FQT2q9wvY5GlSdsbeRKJ0vW4Oi9SW5ApB+U5wbQ=;
 b=M526TRoBvWc+ADV+IZP8n40LUGhVdFpm4Sv24GdWkfLGRVUPjqCAyQ3lHV3VUrbc0Dio2L4ZaRpEQlBgDADBZgH0lkQ3ageVjHiHU/iEzkk1NeG4GJcN6GrvHR3Daqx18oBlfie9YXeGasufoSeq/ax/zacKxTBUid7YNH8Z/l4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 15:26:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 15:26:09 +0000
Message-ID: <c89aaae4-b27f-4ec5-9330-5eb104d966b4@amd.com>
Date: Tue, 20 Feb 2024 16:26:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel 6.7+ broke under-powering of my RX 6700XT. (Archlinux,
 mesa/amdgpu)
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Greg KH <gregkh@linuxfoundation.org>, Roman Benes <benes@riadoklan.sk.eu.org>
References: <ae64f04d-6e94-4da4-a740-78ea94e0552c@riadoklan.sk.eu.org>
 <2024021732-framing-tactful-833d@gregkh>
 <d369b45f-e1af-4117-83a5-3e429e3bfb23@leemhuis.info>
 <CADnq5_OgPBtYpxBQ+aBmA2t7ob7EFPFWrF9OYXNgm00eEayMNA@mail.gmail.com>
 <62bf771e-640a-45ab-a2de-3df459a9ed30@leemhuis.info>
 <CADnq5_M4Zwv0_B1DoU_a8aNpyPVJj_PpjDG_oi3JkrGC5-hNgg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_M4Zwv0_B1DoU_a8aNpyPVJj_PpjDG_oi3JkrGC5-hNgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bb2d64-3cf6-4e78-b193-08dc32284350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyNZz9xJdC0S8u54lWONr8jsrIF1O87qMkyoz+pLDPip+uzyHhea3dshqpgqDOOoWBevrMsqY77cz4HOPcaLFOXUzCY5Gw3DUmMymFt+YBLmVUOxGR7PUGtEbqEVjySioEHBZJ/N/z8OEALHXpCWKbnURZzbXJDxjRWVTCN4PKoiBv6XpYQizzov98DOAoKNiCCRRd3DUFfJ+z/UUBt53z3ZSBa6cqrhHm/LBcY0B81W8EXA67yNu0E3/1+YHuqs+VuVemyTe6olr6/1wb2Qkvbf2vkRTE7EFrorisObuBbnY69TpYcL5zBWhl0HvtafWB+SOmGSwijlgY7KrW0EsLTawGG1cZ4a8KxbvTcHjEcKgghVmdzyX2s0qMx2eaW/SOhP2ADjyZ9LtSrq6IIvLUTS1/lkbA6XWqBuWukrtHQjTc0QJ0RTW7tDbqpC69E4o/pz2azZ6pcE1qaxrncXcEG58SPmLelkrLpqetkbLIuk00EEOkdKG2URv8KLnxb02hEq/C0Bgk2u5rOwzKtBTnGvejFRUIPNRcSwvEnEZvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWR6bTBPZGY3dTlGVFZjekMvdHhic0JXS2dmYldvUlFRYnBwdEkrTlBjakx4?=
 =?utf-8?B?N2FqQ05rQ0VkUGN2SXAwNWUrZ1dqS01XTkZqcE1tbkNrUEgwQzRVbEd1anFP?=
 =?utf-8?B?UHQ5bUovdVNJa2dmVGJTWHp6SmlrUDgwdTdpMjM1YkJ1ZjJFREhUMFNTbHB1?=
 =?utf-8?B?UFVXOUs1TzU5NGZLUWVwbEtveERMcTFCaXhLbHk1ZzJxelU4VHlGQ2d0VWha?=
 =?utf-8?B?MzhiNndQQlpoN0xscWpvMTZ4MS9TaktPRHNrYXcyUVVlN0F0WUJ2NHM2M1o2?=
 =?utf-8?B?RGlPV21JcGZoTWlGZXNjd3FSODBUV2ZZZDRQUEdXaE9RbEVrZFZiMHAzM1ZK?=
 =?utf-8?B?WkVBNHprVmJvSDFiZCtNbllLdUZjWUdueWRGTmg2Z1pObjNTRDAyRVlZYS82?=
 =?utf-8?B?SDRwRXNiT1JYblk0dzNFNWp1dWRZQS9QeDczeUlNSjhCVkdwM0tRTGIzbER1?=
 =?utf-8?B?djgvdnJidXp5bWVHVk95ZGdVckduNFBYNERQVWNTcm5HbzNSN1ZVRUF4RHNi?=
 =?utf-8?B?UVY0RGtQcVFTS29HRWFpM3JkSkgwZUVpcTFUSXpRQU42UFllMkVDRWpCMHl5?=
 =?utf-8?B?Z2EyVG9RSUkwOEZ6ZWpHTUhRK1ZjaGo0RUFGSlV0MEFCMG0yUDEwNVF3cE1m?=
 =?utf-8?B?dVU1U2ttNTdCcFFXSkcySmxTRmJOT3YwUmg2bThycVBaSVY4QTh5RTFCWGpI?=
 =?utf-8?B?eVlJWE5JMVM0cWdaSDF1dWJNQkFocXBINDdDbWtMTVpZMnRyaTVhcnlCVzlG?=
 =?utf-8?B?NHpPR3NGYVhpVlhQekNLK2U0ME1xMldxaXJTbUh3cFZYY1h5SWQzQmlyNzIv?=
 =?utf-8?B?L2pmd0xYcnF4eThkdEJ0cTRJd1g5SFU0bXk1UnZ5WHhuSkJhUG51QVJvb2Np?=
 =?utf-8?B?V3ZRZUo4QXgyOXQ0UG9sSDJtVzNZd1ArdlNyekF0dnF1RDZ2UVcyUjJSM2NC?=
 =?utf-8?B?eUVrY25HRFpaTUF5b2J1N0k0anF2ZUdnM0ZGM1NWTVhTamU4elVxUStIVU1J?=
 =?utf-8?B?QU4xVVZXMWZrdVVlMWNJUjlBM243R3NMd1hHNTlFeGJyYitvc1JkaUd4Wkk3?=
 =?utf-8?B?aXF5d25sQmhoTEk2WE9jZTNtdXk4dXBpeWlUS0EwM09iRlRQWHdZY0k1NGlO?=
 =?utf-8?B?YWxnUU9LazN5UmZua0E2b2NrVmI1SThCb000VC8rNFdsNjRHelgwdlVSYVRx?=
 =?utf-8?B?NTRsV29GUTlHeXNPdlhUV0RqeGVuOHluMnVmR1JNM0tJcFQ0QWVDb05ud1dx?=
 =?utf-8?B?N2tLM3diME5NRHNxWVh4RnBsUXFDem85SGdjMSs0TWFYQzVzT3E5T2I4OGtX?=
 =?utf-8?B?azNmM0cyU0d3VE1LckFDVm5rWnJqc2tid2ZUcUoxVWhpMTVXcmgxS0hTSmRB?=
 =?utf-8?B?d252NHllN2NHMXVDY3lGYThSVVJTakxvZkRJd3RKMGRVTVNmVW1QbmxzbTdQ?=
 =?utf-8?B?dEdGeWJ3QzNjWnhPRmFuOXBZSU04N0J6L0lzSXV3dmU1dTQxcE5VUHNSVU4w?=
 =?utf-8?B?UzNsUjFPYnVhbTVVZlBEMVJZNzlndXFOeHZsc1E4cXFZclVIMDB5Ulp2RXZm?=
 =?utf-8?B?c2wwOTYwR2F5cllPTDJZQUhkMW45NENPNFBwaEI1TVRzSkZybFErSENJTVlW?=
 =?utf-8?B?MkdqZ3RHTHAzcW4xWVhNMUlUcGlsUTk3TW5VeG5EMUVYanBDMFJNa0JMRHFz?=
 =?utf-8?B?citQM3BzN0ljOE9tRXhvaXhuU1V1Nzl1T0RCeDg0MWIxdVR6T0ZjZzBYWjBT?=
 =?utf-8?B?dHVDVVNHSWMwdnFxRE5MOEo3dW9SKzdmZFlvTzBMdCtNekU0R1N4M0FCT1lx?=
 =?utf-8?B?My9BQ0twalVEbHM2Vy94WUZxWkRMMlY5QVpvUHREdE91Y3U3MnRxemY2RmRY?=
 =?utf-8?B?QjVqVmw1d2Z0dXc0ZlJXelRxUVJTdG54UmxJQnlURjFiY0JWQjQ2bENISHFR?=
 =?utf-8?B?UWd1WW91Q0hJWjd6eWF6d1JhVkFMem4wYWR6b3pCdElwV2NxRDFxQWZjenpF?=
 =?utf-8?B?SXJ5cmJ0Qm5CQngxV1NPYVAwQ21wMW9vazJIaDFhZ1VoVXNvRnNtK1BLaFNO?=
 =?utf-8?B?TjF4MFZZdTdKMUxVVmkwR3FTZ0UwRnkwbG5OVlhVRmwzYW9Pd0laT3Q5L3lo?=
 =?utf-8?Q?YO5hABFN1yslEWB0LPa3Gh4/t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bb2d64-3cf6-4e78-b193-08dc32284350
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 15:26:09.0988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1y8IH24BaOHidJwR2bFimle4lkN/Zh570gDorjjvO4U0EYLF5EGvZeXZxhUkHrU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
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

Am 20.02.24 um 16:15 schrieb Alex Deucher:
> On Tue, Feb 20, 2024 at 10:03 AM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>> On 20.02.24 15:45, Alex Deucher wrote:
>>> On Mon, Feb 19, 2024 at 9:47 AM Linux regression tracking (Thorsten
>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>> On 17.02.24 14:30, Greg KH wrote:
>>>>> On Sat, Feb 17, 2024 at 02:01:54PM +0100, Roman Benes wrote:
>>>>>> Minimum power limit on latest(6.7+) kernels is 190W for my GPU (RX 6700XT,
>>>>>> mesa, archlinux) and I cannot get power cap as low as before(to 115W),
>>>>>> neither with Corectrl, LACT or TuxClocker and /sys have a variable read-only
>>>>>> even for root. This is not of above apps issue but of the kernel, I read
>>>>>> similar issues from other bug reports of above apps. I downgraded to v6.6.10
>>>>>> kernel and my 115W(under power)cap work again as before.
>>>> For the record and everyone that lands here: the cause is known now
>>>> (it's 1958946858a62b ("drm/amd/pm: Support for getting power1_cap_min
>>>> value") [v6.7-rc1]) and the issue afaics tracked here:
>>>>
>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>>>>
>>>> Other mentions:
>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3137
>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/2992
>>>>
>>>> Haven't seen any statement from the amdgpu developers (now CCed) yet on
>>>> this there (but might have missed something!). From what I can see I
>>>> assume this will likely be somewhat tricky to handle, as a revert
>>>> overall might be a bad idea here. We'll see I guess.
>>> The change aligns the driver what has been validated on each board
>>> design.  Windows uses the same limits.  Using values lower than the
>>> validated range can lead to undefined behavior and could potentially
>>> damage your hardware.
>> Thx for the reply! Yeah, I was expecting something along those lines.
>>
>> Nevertheless it afaics still is a regression in the eyes of many users.
>> I'm not sure how Linus feels about this, but I wonder if we can find
>> some solution here so that users that really want to, can continue to do
>> what was possible out-of-the box before. Is that possible to realize or
>> even supported already?
>>
>> And sure, those users would be running their hardware outside of its
>> specifications. But is that different from overclocking (which the
>> driver allows, doesn't it? If not by all means please correct me!)?
> Sure.  The driver has always had upper bound limits for overclocking,
> this change adds lower bounds checking for underclocking as well.
> When the silicon validation teams set the bounding box for a device,
> they set a range of values where it's reasonable to operate based on
> the characteristics of the design.
>
> If we did want to allow extended underclocking, we need a big warning
> in the logs at the very least.

Yeah, I mean we had a similar outcry when we started to apply the limits 
for the display PLLs as well.

It's just that we have to stay inside certain parameters to be allowed 
as hardware vendor to sell the stuff in most countries because of public 
regulations.

I mean you can in theory program the ASIC so that it starts sucking more 
power than allowed through the PCIe lanes which could start a fire. 
Because of that certain settings are protected by signed firmware images.

Undervolting is not that problematic than overclocking or overvolting, 
but you can still do stuff which is outside the hardware specification 
with that.

Regards,
Christian.

>
> Alex
>
>> Ciao, Thorsten
>>
>>>> Roman posted something that apparently was meant to go to the list, so
>>>> let me put it here:
>>>>
>>>> """
>>>> UPDATE: User fililip already posted patch, but it need to be merged,
>>>> discussion is on gitlab link below.
>>>>
>>>> (PS: I hope I am replying correctly to "all" now? - using original addr.)
>>>>
>>>>
>>>>> it seems that commit was already found(see user's 'fililip' comment):
>>>>>
>>>>> https://gitlab.freedesktop.org/drm/amd/-/issues/3183
>>>>> commit 1958946858a62b6b5392ed075aa219d199bcae39
>>>>> Author: Ma Jun <Jun.Ma2@amd.com>
>>>>> Date:   Thu Oct 12 09:33:45 2023 +0800
>>>>>
>>>>>      drm/amd/pm: Support for getting power1_cap_min value
>>>>>
>>>>>      Support for getting power1_cap_min value on smu13 and smu11.
>>>>>      For other Asics, we still use 0 as the default value.
>>>>>
>>>>>      Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>>>>      Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>>>>>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>
>>>>> However, this is not good as it remove under-powering range too far. I
>>>> was getting only about 7% less performance but 90W(!) less consumption
>>>> when set to my 115W before. Also I wonder if we as a OS of options and
>>>> freedom have to stick to such very high reference for min values without
>>>> ability to override them through some sys ctrls. Commit was done by amd
>>>> guy and I wonder if because of maybe this post that I made few months
>>>> ago(business strategy?):
>>>>>
>>>> https://www.reddit.com/r/Amd/comments/183gye7/rx_6700xt_from_230w_to_capped_115w_at_only_10/
>>>>> This is not a dangerous OC upwards where I can understand desire to
>>>> protect HW, it is downward, having min cap at 190W when card pull on
>>>> 115W almost same speed is IMO crazy to deny. We don't talk about default
>>>> or reference values here either, just a move to lower the range of
>>>> options for whatever reason.
>>>>> I don't know how much power you guys have over them, but please
>>>> consider either reverting this change, or give us an option to set
>>>> min_cap through say /sys (right now param is readonly, even for root).
>>>>>
>>>>> Thank you in advance for looking into this, with regards:  Romano
>>>> """
>>>>
>>>> And while at it, let me add this issue to the tracking as well
>>>>
>>>> [TLDR: I'm adding this report to the list of tracked Linux kernel
>>>> regressions; the text you find below is based on a few templates
>>>> paragraphs you might have encountered already in similar form.
>>>> See link in footer if these mails annoy you.]
>>>>
>>>> Thanks for the report. To be sure the issue doesn't fall through the
>>>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>>>> tracking bot:
>>>>
>>>> #regzbot introduced 1958946858a62b /
>>>> #regzbot title drm: amdgpu: under-powering broke
>>>>
>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>>>> --
>>>> Everything you wanna know about Linux kernel regression tracking:
>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>> That page also explains what to do if mails like this annoy you.
>>>

