Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5956CF46102
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 12:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11F910E3D3;
	Mon, 23 Mar 2026 12:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TPaq3J1h";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E56610E3D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8mSw1ENPs5wHbBCWRAw1mnkXYVSar7gDj8YeBijBWrdLIuyU2galLkpjT1xExPF1y6qVNtEdJv3ez1fWnorugSG/Wl2LCMTpWM987D+0Fs2vWXWXIKwQyvawkKcvaAuJljSBV58yEiKSE+WNFWmS4lSsdptSoR7o5U8RELLbzI1891K+lKs01EoOAdjdeWd69zVVWjGlG9YNxB8LI+PtN4HngFYQTzBXtGAdvDMnjhPYL3V23STEHJyUB91wl56Xx+mnT/F1qgwKXVabZg15mF9Ht4BkxncQDQj6qaGJxA3Cvzdj4AhKNkQ3uBXE73NHeXJS75W4Yd3QqqEkAAoeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZFlom9zNX4+gN7/WaxUd+fsjfYgrY+wAFWFkwnG1Cc=;
 b=h4fOrSF5v4mdZsBFg02tJ+VfL1COcwXVpRMmOlzKm9K65qoiV1K4YUBQC3g6RLokBgy5bfNgUFbiWARWgnQeCG4F99Wm/Rw9qmvsLLfTVAI3ybCHSkRQyIOVLZ87RwO2LwGyQcg0G0D7USTzyyVyjIf6feujnC7D2PNO5b/i1FCfonAx7pq+2AALdAq4DM0fKp+wAk7uqb/Ate3U9s0odZOsWln4EuAsRdk6N/YlklNK/rPL6UwVTY8OBLcw1rVcewuInsFviQBjXA+LudORgvUtUdFiQdFffyZ797wXLQuhkBHXPm2owaGoXHUkJ7g9958xOZNIiH2vis0hPZpyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZFlom9zNX4+gN7/WaxUd+fsjfYgrY+wAFWFkwnG1Cc=;
 b=TPaq3J1hPwkHv86Cbw+AC0fyktWnj76qfVO2TcNZYFviexiDwF5PMZSfPJw0znrvz5/Hst7FzyVIgT5udx3mss+VWypyfFxDOmQ8KCXXGb8zUluP3oIW8pf/fU1xfnc7ghdyPWfprbhhe6ofPVc8LmL0nKR/3Km0FxZs8oMw0zQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 12:57:02 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 12:57:02 +0000
Message-ID: <35726709-03f5-4e5f-8425-7a84ea406464@amd.com>
Date: Mon, 23 Mar 2026 07:56:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>, "Lin, Leo" <Leo.Lin@amd.com>,
 "Perry, David" <David.Perry@amd.com>
References: <20260319073250.147808-1-yifan1.zhang@amd.com>
 <80732b5f-27a9-4969-8afe-98f3156c725e@amd.com>
 <CY5PR12MB63693D88EBEAEE20CC4B6870C14CA@CY5PR12MB6369.namprd12.prod.outlook.com>
 <f388c29e-4d1c-4d04-9eca-ce3b74f00931@amd.com>
 <65c61436-f076-4308-b89f-d2bdb214e481@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <65c61436-f076-4308-b89f-d2bdb214e481@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:610:e5::12) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d98c4c4-aaf2-4035-5d51-08de88dbad18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: T6+BxBWHd/seXzPN28Y+ocGqVgol9tKFEOEaPeJhsRP62/QjWrhRHpwzVvO7X7qR+xE0d0frZQdXQEuisIHcepocYfT3bSI4kSqMG1ATRpGh8upuEuGVrD3aLGHtwJykJByD+1N6aJ41kst6fTNGlh9iKBqLAg5FVBr8B8kTgB7gug3Fh2m/J6EdnKcboz8k0kVENjGp9ZEX4xJuzjQg0BiIMM3LFUnHV/GD+38Pos5nwESoxvFHKgiGIetArzCkogUprGcwXL7+anPL32m1LmcxSPSfB/GwiUc4wDGKtSfdKHHeEewWEyyyHydidqG9XOdlbPimKvpiSfX14hj0mjwYSd0ozF9FxZ68x/GWw+lNt7O6qCsV1WoXGob/fBur9aFj7ajnRdAjJyykwUn00zqCbLsT1C2vRLQvBb72FXnWxhw2H61Pn8WQN+PyBOH0SjL+gQvo8O4U59UG47CZpi7klt+T+j606uaFYsgV+EsbOPHme7ODBKPrhHflWKW4wtIMFtY5j4J9VGe5boYMs/shSI7XoXBORUuXysFkGHOOriy/6Hw/tH7XTq54PWx8XWVDej2OVRr5GvyEPFO/0jHT0alcjDbXjgyl7GfAuhiG42AIQyCrhWn7JMw+82iy4VLqn2CMW09Z+zDgFJtN2uHwbQu6EjLp8PtkjV1gi6nkJ0k9vWMgtbDFSRVIAAMOzRfpX562J9h+mm9k7PVsbbR+Mz+POTcB3R9UnpceIrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1UL3hYcDAxWjVUSWlOdHRQK0NySXNVbE55MmhBVWZpQ0JGRk9hUGZtc2Jk?=
 =?utf-8?B?N0tTdGdLVU9MSXk1VlllSkpDLzhMVnRxSnhXZ1dyMDVJYVhGTGtsRDJhekdX?=
 =?utf-8?B?YXVDMDBGWTZXL2tMNHltcjdIM3VEK2ZWc0Q1b1dZVExmQjh6SGhNdnQwaitT?=
 =?utf-8?B?N04vU3FjeEJML05TQkRZOG5COVdVaDY3UnNyWVkvVXJ0MVZHTC9tZTBpdmRY?=
 =?utf-8?B?T25VcFNZYnF2QmRoM3J2NndoQ1hjZWxDdC9JdEtUOGFQVm1IZWI4MzFGbHB3?=
 =?utf-8?B?ZzlxeVFMczExc2cvR2JRZjJURFZEOWR5MUw1MEw3bWlIcnQvMGdUZkQxWG1M?=
 =?utf-8?B?ZXE5U1ZYZHRrM2NoZktxYjVESWpiV0hPQ1J1R2VDV2E5R1lsTEIzWXZnT1U2?=
 =?utf-8?B?b0o1ZkFlbzk5dlpmQ2VDTWppdXVBdGNIQWtEWm84OVV2Y0M1bWNLR1V2Uldm?=
 =?utf-8?B?Mm9hWDQ2VDBRTEtwNndBK3F6OHc5Z0N1L1JyQS9lVkpRSmJXeW5kZ3JXNGNW?=
 =?utf-8?B?bERhbXlZMDFrWHFGYURlMVZCczV4UzZVcTZBeXF1UUVVVSs2R3JjY0ZJNXIx?=
 =?utf-8?B?eXhLZG5oTkdST2l4NGlWRWIwNjlSVWZDZE8wNW9idFVLZUY2YllnQkJhSVVn?=
 =?utf-8?B?UFVVNmZ0SHVrSDRJYjZHY1lNSEpseVltU2ltTWxDRHp2NE9CUXVYaWNoM2Zq?=
 =?utf-8?B?WG1rRktGa0NNbXlreURJK0pmcVh6WWl2UEdMNXl0Tm1iM0NsbERiYWRxcit5?=
 =?utf-8?B?NEl1MUIwWmdnVE5uVlFaaC9aSFBySWlkd1lvSHNyU3Jwb2w1Mkd2ckJKNXMw?=
 =?utf-8?B?akdQL1ZHSXNOYm1zZWNJMWdWbGJEMEpqT05HenNwaFM5dVhPMUcyQUo1NmtS?=
 =?utf-8?B?YUZBZ3ByMm1TeEszU1BxKzFycmljSkRQTWdLYmtVakp6QWx2aDlZdExnakZQ?=
 =?utf-8?B?MWJHRkx3RkJWY2NEWlpJYmlTNmx2VUFWWWtVVmNKZWFQUmdRN201VDRBTGky?=
 =?utf-8?B?enNOQS82Q1hyWjVxZ0pJRThKMkhsYms2YjgvNzNMMDNTSkx3WkxiYWw2QTU4?=
 =?utf-8?B?Z3BIZ0M1L1ArWU1lZE1aR2xaNjFVeXh2TG9FOS94bjZndnNJRXY1WlFHYTgv?=
 =?utf-8?B?RHQ1YlF2OWVFcm1wWUlGaTR4bnh6WEd3Q0c2Q0k4L1U0d0tpeFh5RWJVYjZ3?=
 =?utf-8?B?cjh6c1NoTWFVUyt3d2hMNVdWSXY5dHZPY2UrY2k4VHdKNk1DSTNzRjJ4TWFG?=
 =?utf-8?B?VXJ5bzdkNFVGb0N6aE53WU4wQ29QYUNxc3N5RzVMd0JyNUdWaUkwVmcxRk0w?=
 =?utf-8?B?Ym5xZG04a1JvcWR3R1A4anJIN2ZHNEhralhOV1ZVWUNITEVVNlhHRG1EQmtr?=
 =?utf-8?B?RXhvSGdBUWtWZStacmI0eHd5TjYxNlMwUnYvNGdZeGpOTzhyT1lPdGh2WUFY?=
 =?utf-8?B?N1VxMEpMZmc0Nnl4SGdRK2xMek9QNFAySXBnRWllK3NGSmtXRzdQL1Bkdys3?=
 =?utf-8?B?VUZVMjg1UVhidjZYaTZ4VVpZRGhDOVdqTStyb215OEU0WXRobkNaTlV5UnFC?=
 =?utf-8?B?Wkt4ZWtKOU9MaXB3OXBHeGxkdGRSZTFWRG56dk9STHJUU2lwSTFNTXZ3Wi9j?=
 =?utf-8?B?bzVTbEVzalEyNXlMY1NDWmFHSGFYYStOd1BZRkhsQit0Qkdic2djU1gzeUNG?=
 =?utf-8?B?L1UxYUFsZkM3ZnpuT1huUW9qNTdIcTgramJpY0hrYWpER3Q4a3NQTnRkakdy?=
 =?utf-8?B?cE9tbW1NU1dTVmNWLytVaWYvUWx1UDVaYkxyNHFXaHB6b2UvdmpscHV2VFl0?=
 =?utf-8?B?WXpob1FhMlFjTFNmUFJ2RldNOEVqYzd2a3VlRldFa3E3TFplQ1ZRZGU5ck1u?=
 =?utf-8?B?TjR0djZJYkR0Tll3ekp2Qnd6Nm5zRTZLRXg0TGp4TFZWTmtMM1VteUJRaEJU?=
 =?utf-8?B?b3UyTVVTT05hVmtMRzJRWnJIenZITEZmbm50b2RIcWJwcmRVVXhpTjdEdE12?=
 =?utf-8?B?SGw4YmJHSUxqYWlRTW5iWDhpbkphQnIrbVloVVRqaTRHOTZBSDl0NmFQZGxz?=
 =?utf-8?B?TFUySlgzREFSdXhQZXVYS2VOYmZlTnZ5UlZaaFB5SmRGY2xvZVVWWkxhWDVk?=
 =?utf-8?B?YkVpU1ozM3lwY04yYVcvRVVnL28wZDE4OHBWUVR5STJsWW95TzRHdlJicUlU?=
 =?utf-8?B?VUdaKytuNko4WG5QVG5nVEMxL2U4ajdmV1dVN3lIM2FLMUpwS1h0bFJuek5o?=
 =?utf-8?B?MjQrTEpMbU4zQnlNUkd0NWlZaTJERHgvRjVqMm9pejRtSStWSlJKaWVNVDNC?=
 =?utf-8?B?bFgwclJwQmJCcks0TFRiSm1wOGlmL3haUnp2cE5nTXZiNGZaR0oxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d98c4c4-aaf2-4035-5d51-08de88dbad18
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:57:01.8526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWhgZVhQPzmRDFEeI0wlLlO+d86HBGgC3D8kZsf+FQ8VmPSCva5q5hmp6Ay+hVlD5/MIgrok1WAir4TbnnxV7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
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



On 3/23/2026 4:13 AM, Christian König wrote:
> Hi Mario,
> 
> first of all please loop me in on TTM changes as maintainer explicitely. I don't see everything which flys by on dri-devel.

Sure.  I was initially just looking for anyone comments on it, didn't 
think it was worth bubbling to top of your mailbox for an RFC.

> 
> Then changing the 50% limit is an absolutely NO-GO. It's completely irrelevant that AI wants to use more, HPC use cases complained about that for decades, but we simply can't do that reliable.

What does HPC do now when they need more?  Tell people to put page limit 
on the kernel command line?  This shouldn't be any different than status 
quo before - except that user intent can persist.

> 
> Regards,
> Christian.
> 
> On 3/20/26 15:34, Mario Limonciello wrote:
>> I think there is actually a very easy way to trigger it and it's not obvious that a user messed it up.
>>
>> Assume you're on a 128GB system with VRAM set to 512MB.
>> 1) Set TTM page limit corresponding to 96GB
>> 2) Use uma_carveout sysfs or BIOS to set VRAM to 96GB
>> 3) Reboot system
>> 4) Now VRAM is 96GB, but the page limit was a module parameter and will be wrong.
>>
>> I actually /think/ that the RFC [1] I proposed a few weeks ago could be a good way to prevent this.  By using EFI variable instead, TTM could sanity check anything it reads at startup and save sane values to EFI for the next reboot (if they're insane).
>>
>> https://lore.kernel.org/dri-devel/20260306055439.1822879-1-mario.limonciello@amd.com/ [1]
>>
>> On 3/20/2026 9:28 AM, Zhang, Yifan wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Yes, I agree. I’ve just been notified that this memory configuration is a mistake rather than a valid user case. So the fix is low priority for now.
>>>
>>> -----Original Message-----
>>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>>> Sent: Friday, March 20, 2026 11:14 AM
>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
>>> Subject: Re: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
>>>
>>>
>>>
>>> On 3/19/2026 2:32 AM, Yifan Zhang wrote:
>>>> Current apu_prefer_gtt setting only check gtt_size, which could be set
>>>> by user to a larger than system memory value (via ttm modules
>>>> parameter pages_limit). E.g. carveout vram 32GB, gtt_size 50GB (via
>>>> ttm modules parameter pages_limit), system memory 31GB. In that case,
>>>> apu_prefer_gtt will be set incorrectly. Take system memory into
>>>> account when set apu_prefer_gtt.
>>>>
>>>
>>> Wouldn't it be cleaner to do this in TTM?  IE test that a bad option was set by user pages_limit value and then show something like:
>>>
>>> if (user > possible) {
>>>        pr_warn("Requested invalid %d pages, limiting to %d pages", user, possible);
>>>        user = possible;
>>> }
>>>
>>> Then we can always trust what we get from TTM.
>>>
>>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>>> ---
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 2 --
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 4 ++--
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++--
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 7 ++++++-
>>>>     4 files changed, 12 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> index 3bfd79c89df3..a6ee9d9bfafb 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>> @@ -170,8 +170,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>>>>         int i;
>>>>         int last_valid_bit;
>>>>
>>>> -     amdgpu_amdkfd_gpuvm_init_mem_limits();
>>>> -
>>>>         if (adev->kfd.dev) {
>>>>                 struct kgd2kfd_shared_resources gpu_resources = {
>>>>                         .compute_vmid_bitmap =
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> index cdbab7f8cee8..13cada7da4a9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>> @@ -369,7 +369,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct
>>>> amdgpu_device *adev, int xcp_id);
>>>>
>>>>
>>>>     #if IS_ENABLED(CONFIG_HSA_AMD)
>>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>>>     void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>>>>                                 struct amdgpu_vm *vm);
>>>>
>>>> @@ -382,7 +382,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
>>>>     void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
>>>>     #else
>>>>     static inline
>>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>     {
>>>>     }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index 8a869fe41acd..4fba7d2f34a9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -109,13 +109,13 @@ static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_ad
>>>>      *  System (TTM + userptr) memory - 15/16th System RAM
>>>>      *  TTM memory - 3/8th System RAM
>>>>      */
>>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>     {
>>>>         struct sysinfo si;
>>>>         uint64_t mem;
>>>>
>>>>         if (kfd_mem_limit.max_system_mem_limit)
>>>> -             return;
>>>> +             return kfd_mem_limit.max_system_mem_limit;
>>>>
>>>>         si_meminfo(&si);
>>>>         mem = si.totalram - si.totalhigh;
>>>> @@ -132,6 +132,8 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>>         pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>>>>                 (kfd_mem_limit.max_system_mem_limit >> 20),
>>>>                 (kfd_mem_limit.max_ttm_mem_limit >> 20));
>>>> +
>>>> +     return kfd_mem_limit.max_system_mem_limit;
>>>>     }
>>>>
>>>>     void amdgpu_amdkfd_reserve_system_mem(uint64_t size) diff --git
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 714fd8d12ca5..df98ece071e1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -2071,6 +2071,7 @@ static void amdgpu_ttm_buffer_entity_fini(struct amdgpu_gtt_mgr *mgr,
>>>>     int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>     {
>>>>         uint64_t gtt_size;
>>>> +     uint64_t max_system_mem_limit;
>>>>         int r;
>>>>
>>>>         dma_set_max_seg_size(adev->dev, UINT_MAX); @@ -2210,8 +2211,12 @@
>>>> int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>>         dev_info(adev->dev, " %uM of GTT memory ready.\n",
>>>>                  (unsigned int)(gtt_size / (1024 * 1024)));
>>>>
>>>> +
>>>> +     max_system_mem_limit = amdgpu_amdkfd_gpuvm_init_mem_limits();
>>>> +
>>>>         if (adev->flags & AMD_IS_APU) {
>>>> -             if (adev->gmc.real_vram_size < gtt_size)
>>>> +             if (adev->gmc.real_vram_size < gtt_size &&
>>>> +                     adev->gmc.real_vram_size < max_system_mem_limit)
>>>>                         adev->apu_prefer_gtt = true;
>>>>         }
>>>>
>>>
>>
> 

