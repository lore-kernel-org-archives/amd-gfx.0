Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A826CA600C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 20:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D45FA10E734;
	Thu,  8 Oct 2026 20:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SIlTmW2N";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA90810E734
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 20:29:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEDY4JjoTjJs7xpadPk3OEZ4hmWONuaysBaSNn7+zv9u0rBkEN6eKHKRim/ySHg1MVxhIezoBxiY0bKgcvesdYeAcPPm4+pl/lyThuUVOq4OHDYBbPEvDdktNbRrFN2aDZU/XDqakCVrkE6u9NDBQqlWIAIlKbzRfPh08SsWnLWLeAU9QJRLEHPhfEsnrUZoPitO+DFB5DsfTjtt6ka9J6Ch+gcR2GWMyuLP3FY2Ifyz3StHlC9k9AKboL+FAMus/+wpYyxx6RPM83LOBV/yVXnzEUxxWyVS6WxueqMHN9ICc17Eg2050WFJSnrLJKBjyiV/U7RWcpl6E8l4bsXTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygY5vgS2dqHvAC2LyRq1fvUn+W8hiacOu6XXIxGmYsY=;
 b=IAEVVg5CTpsZC8AXkeHB0ycoIP4sYQh8ffZ9puHr4kEYV4cOjA9wfdR+g8rz5X2PANjb303Kr/HxgHe1RamilpFBdqdXziMFUYrP7UT6x1xr7EWJQk7siWzMrkbq0VDrdsiYxvEkKZuMrsFKDanDeUi7XQb+bgr3/b61DPLpY1dSOGpKD0DDv13v4wvb5FezMxqHC+tTyztrka4dFDgrty63dWvHJIF0CE4faliabip7CCEJyO4ifsjUefaGvGos53zU1EsDZa6lxRk5+69u4hoOUvEj6xbNDxqobcaXr00WYuXv/SpGIJ2m8tTWMQNwuT84/Ft7E3XHBfgHZz3HAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygY5vgS2dqHvAC2LyRq1fvUn+W8hiacOu6XXIxGmYsY=;
 b=SIlTmW2NvCJmDb8FK0RAn+y5b793NyClBmhmLRoqftPXFQQHjywZDtiBd6HgDHNoubZjB7FblzZLypIYAf9e31JF0/G1sU0Y9xUc/B04n/lbrTaG0+BIqsU71gcaucXnz4y2XubNkrGidXScGqevRN+D2RA6/CNezz2B+ngbOe8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SA1PR12MB9547.namprd12.prod.outlook.com (2603:10b6:806:45a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 20:29:07 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 20:29:05 +0000
Message-ID: <099e68cc-8afe-4acd-982c-e2f9433db4e1@amd.com>
Date: Thu, 8 Oct 2026 15:29:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/uvd3.1: Fix checking whether UVD firmware
 keyselect was already set
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, David Rosca <david.rosca@amd.com>
References: <20261006211607.75407-1-timur.kristof@gmail.com>
 <deb0ff06-fcb5-4d0d-9cdd-ade4e5b83f2a@amd.com>
 <qL_HOE9OSUS1vue796-bIQ@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <qL_HOE9OSUS1vue796-bIQ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:610:58::33) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SA1PR12MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: d54241f2-5ee4-47ba-9af4-08df257acc20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: BU19vjWBU+CA5f4ic+eqxs0GxGd2MMVP29p3V4wbM1+vBrMtHOMJkJ+qsmphLR6WELxKu79RqkjDJqb4QXSTXkVVpN1/V3Q+IZCWUpS5x36rQKQhl2UYoRgsoPodffzugDFKP0gFwmi9orrWQLKBoxEXbCAHSlvz5HVwWYAJDpk6NF9HUR1jAeSMW3Nnt9XlslYFKh+T0NRTb/IkpWFnvRITbn1rWPYYz3v4V/Oh5AxdnqWSiRNUW/ebmnCCLSbye5/e4V3Dg0fJd3OVGm/gOE8Fie8/asnFnE6qFG1HzCK8moUNjL/LJ/FuL5EGO70GhyAM/GRGo06W10aCTt9oii5k4qel2UlJy9U6YBI3ordej22CiQdGQC77BL2uCcxoOyTEjL0dcwMflAKOzDqUlwUK6DHx1LqN0X92jc5fcJMSqJDmS6gP6IUpKlUeo07ZgpAcNRFOSqxzEUy8R+VHKLOxtstFW4V1Bf/K3KO1RU6LOsZRzvy+AZMosICGL/QMAz0Il6yl0k6tRhvPdM3pOe4VW4PLo2NtauUfO6T5BidDihHeLMOMhiGnkwsJGEuYFIhKrvoexJrYFpfSsmxnJa4X7kuQy8CRXaF0Y8bDOiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzdLU2JIY1dsQW9CZmdoWXR5SGJ3YnEvWHpBSTFwR283R3ZhMDlYenBXTFJU?=
 =?utf-8?B?ZzdhSlJleUVsWlJNakhMdVVXTHpMNHZsU2tUZmRiZ01pd1BZbFBwaGtyMjR3?=
 =?utf-8?B?dHl0c1ZYdThpU0tyWDhxakVEdFpHMVpMM0FDanFoaFAreHBTanEyb05TUHZi?=
 =?utf-8?B?OHFtcGpKNi9PeXdRVlZmTVJ3WU00ekZGRmhnTVgzZXVXZDB1VnpVSGUxM0Fo?=
 =?utf-8?B?UGNucmxJdStlZ2M0dzFQaDN6djA4RGU4d1JNOGZtaXZkQzl3Qk01VkpSUEd4?=
 =?utf-8?B?Zlc5b2lqK2NzWFZVRUg3Z3ZZL0d4QWxXcmNkUlU2aWxZTVFMS3VVWDh2TEow?=
 =?utf-8?B?V1pLaDl0cXFyOTFocHlnUUhhZUNGUnV3RXU2TUozZW9kak9HN3BOeVl3b3F4?=
 =?utf-8?B?Mk1ZRW1YNGFXd2VzN3RMNDNyQ1dGWSs1WjV6aFVRb0QzUWd4ZVdJOTRPZUR1?=
 =?utf-8?B?UVZkcld2b2lJMWtoODV3M245Qm0wODlhcWlSUVpCRXgzdStGc3hMZnRCWUxP?=
 =?utf-8?B?N2U3cjdOMHFQL3RhL00yY0lycG8vU29hSXlzNEx4MTdqRk9WRkVKVFU5TE5Z?=
 =?utf-8?B?Z2t0cnJROVFHSTNyNDZidmlSQ01IRVgvQXRKaldaZXloMVNrQU5FWkFDQUZx?=
 =?utf-8?B?cWR2aWhxU1lzTitsQVF1MHZRQ3FzdWVIZ05BNWpLU25OT0xNaHRWN2puWUgy?=
 =?utf-8?B?SjZwL3hOVi90ekp6M3ZPTHpZYnpBbUpPNHMyS2J1ZzUzc25WcE91LzhkTXRs?=
 =?utf-8?B?YmNlMWMwMklGOS91TWxSVmtKTEw4TGJ6SXlYWmFaUDJPZVloYjBzTnVncWli?=
 =?utf-8?B?WjIyOTlIMUNWUlgvUW5ybzRNYS9JbTk1SmhXR0ViWFZ1Y29yVWx3TG80c2dT?=
 =?utf-8?B?OWZ2N0VmdTZaRUdWYkc2anRERTN4bmFIZTZFVVhMTUQ2Uzl1aFBqUENNNE9Y?=
 =?utf-8?B?UkNmQ2VHQVZQWmVWUXdWQVBQRjlxeU9mZzRvV1o3QkdHRFg2NTdSNGpzODNx?=
 =?utf-8?B?M3lRcHhidUQ3VFNqWnhHSlQ5dVZyb21lQ3RIL0t5MENiWXgvTTZKS1k4SkVQ?=
 =?utf-8?B?U04xQXFtV2lZODU1RG5uM1dLVU8xbnk5T2h5NWQ0WWRKU0Q0MlFFeWRCeDNU?=
 =?utf-8?B?THNwWFJwb0EvNmNIMnRQNGRkRUtIUHRNRmRpdDRnTWJrZzhYTnJ6M0hIS3U4?=
 =?utf-8?B?SFNTNTVZNmRJQjNuaFVnMDg1dVFhUWx4azhlNmd4UW1iWUJkUG4vVnJwU2Zx?=
 =?utf-8?B?bW9ua09VYVZRTUpvUmFNdC91SVFUT3R5LzgxeXBhbmo0MW8zaTVURlRVTDlY?=
 =?utf-8?B?Smpub2ExNjJ3d1JjMG9GeXdUSU1abkZ6UzVTM3ZFaE1tTDBNdkljenhhbzlT?=
 =?utf-8?B?MzMyMVFmbGZaZS9Da3RuZUQ0aFA5TFdwSkN6THo5UGxwZEc1aVo3eWVTVlpQ?=
 =?utf-8?B?ei9KZWl2KzQxT2dEb1g3Z3dUQVI1emVkSmU3bVd3U2hHc1FUZnErdXRNVXM3?=
 =?utf-8?B?ZldXLzZsUU54OXMrcFg3RjFaS2pvUlBuOHZHdlBqN3VyMUkvT2JNVkRvWWx1?=
 =?utf-8?B?bnphUkdyK1F5TzR4cVpDY2VuamppQVlZTVV3ZUFlbmVZMWNBRXVHSzZsVFVW?=
 =?utf-8?B?SnFieFBjcUpCL3lyWGc3LzQ5OW80b3VYTU10WjJxT3VnUTdtWUVVMUdOU21s?=
 =?utf-8?B?d3dETXJNMEhTRXI1dE4vUmFQRUpJVGU1WFI4ZXBCd3R2L1QyQ084Nktma3pv?=
 =?utf-8?B?aFNLeW1iODdQQ3NwM3dOYjhEU0czNHM2KzE3TnNDSm9xeVpCdVRONjZBYmFT?=
 =?utf-8?B?QXpUbFd5dFRqN2U2dDlOcWh0OUJ3WTFCcUFreGxaU2xUS2JWUTRVWC90bGE5?=
 =?utf-8?B?ZjZPaGlmb0RCV28xTjRkTy9Zc3hndEZtN1IzL2xJYTJVYnhQeGk0SGF4ZEpK?=
 =?utf-8?B?RlZMNmdzaEZ2RkViSkYvRWlmaUVhNkk0dE8zakI1T281Vzg1Z1ROUGpIQk96?=
 =?utf-8?B?aGZIZFJjQ3FzVzNtT0wraCtNWHUyenZzaHBHQUR2OStpWnNqSmZvU1k5N0hT?=
 =?utf-8?B?dzBNSW5OeHUvWGlDcG1vbHAzM2dnY2pWMGxtL3hVbVNRZCtTMjFKVU1NcnRJ?=
 =?utf-8?B?VWVGdndTVGNSVnBGQVZLNk0weWhkWm5rVU1uY0pRV0trT0oxcDdWa21FNnY4?=
 =?utf-8?B?K1djMzA0Zk13enJMK3FGb2ZFVnMzMGNNSWpic25JeDV4RERzYmJFOUtLVG1r?=
 =?utf-8?B?NXhuWndlNHFuUWVmKzd2QmtpM2xKc3dBUmdKSmNub0tvUTExTXNOSkZVMEVK?=
 =?utf-8?B?UEtuY3lVaVI4Zm5BVlVZamVSZ2h2T2xxMzNYZmJ0enJaaGMvcm5PZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54241f2-5ee4-47ba-9af4-08df257acc20
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 20:29:05.5174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5HYhe+5/ssXG+1yNYl9TN4NYpN0Kyh3ftuXEoZ7feGsTTvegLRdD/O6fhGqstWJTU0CBn39BHGCc5Jeem/NrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9547
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



On 10/8/26 15:21, Timur Kristóf wrote:
> On 2026. október 7., szerda 7:50:29 középső államokbeli zónaidő Mario
> Limonciello wrote:
>> On 10/6/26 16:16, Timur Kristóf wrote:
>>> The PASS_MASK is for a different register not for UVD_FW_START.
>>> It was a mistake to check this flag. It should be enough to check
>>> that the register is non-zero.
>>>
>>> Fixes: 13e4cf116dbf ("drm/amdgpu/uvd3.1: Don't validate the firmware when
>>> already validated") Signed-off-by: Timur Kristóf
>>> <timur.kristof@gmail.com>
>>
>> Can you have a look at the Sashiko feedback:
>>
>> https://sashiko.dev/#/patchset/20261006211607.75407-1-timur.kristof%40gmail.
>> com
> 
> Hi Mario,
> 
> This patch simply fixes a typo in my previous patch that I referenced in the
> Fixes tag above. The PASS_MASK field doesn't belong to the UVD_FW_START
> register, it was simply a mistake on my part.
> 
> All in all, I'm not sure what to do with this feedback, as the patch is just
> fixing a typo and doesn't introduce any of the issues that the bot is
> complaining about. 

Right; understood.  I personally don't think that we *need* to fix any 
of the feedback in this patch.

I mostly wanted to make sure you got a chance to look it over and agree 
to that.

I'll queue the patch up to ASDN.

> In general, it might be a good idea to do something when
> the firmware validation fails (though it's out of scope for this patch). For
> example we could ignore the UVD block and move forward without it. We
> discussed this briefly some time ago with Alex, and the conclusion was the we
> prefer not to support "degraded" functionality in amdgpu. We could try to
> reset the GPU and try the firmware validation again, but then there is no
> reason to assume it has any chance of success if it had already failed before.
> 
> I'll try to respond to some points from the bot's feedback below:
> 
>> Does this check falsely succeed if a previous validation attempt
>> timed out or failed?
> 
> According to my current understanding, the FW validator always fails on the
> second attempt (even if the first attempt was successful).
> If firmware validation fails or times out, then the driver simply fails to
> initialize and won't retry again AFAIK. The purpose of checking the register
> is to prevent trying to validate again because the second attempt always
> fails, which can leave the GPU in a bad state after a suspend/resume cycle (on
> systems where suspend doesn't completely power off the GPU).
> 
>> If uvd_v3_1_fw_validate() times out or fails after writing
>> to mmUVD_FW_START, the register remains non-zero.
> 
> Yes. If uvd_v3_1_fw_validate() fails, then amdgpu just fails to initialize (or
> fails to resume from suspend) and will never recover. This is how it always
> was and my patch doesn't change that.
> 
>> Upon initialization failure, amdgpu_device_ip_fini()
>> skips hw_fini for the UVD block. [...]
> 
> As far as I see amdgpu_device_ip_fini() doesn't call hw_fini() at all for any
> block, so this argument doesn't make sense to me.
> 
>> Furthermore, for SI ASICs (the only users of UVD 3.1),
>> si_need_reset_on_init() unconditionally returns false,
>> meaning the ASIC is not automatically reset on a subsequent driver reload.
>> [...]
>> Consequently, upon driver reload, this check will see the leftover non-zero
>> value and immediately return 0. The driver will then incorrectly assume
>> validation succeeded and use the uninitialized UVD block, which can lead to
>> ring test failures or GPU hangs.
> 
> This is true, though isn't changed or affected in any way by this patch.
> 
>> If validation fails later in this function, does this leak the
>> UVD DPM clocks? [...]
>> As a result, the UVD clocks enabled before calling uvd_v3_1_fw_validate()
>> are never disabled on failure.
> 
> Again, if uvd_v3_1_fw_validate() fails then the driver just fails to
> initialize and the GPU isn't recovered. This isn't changed or affected in any
> way by this patch (or the previous one). So it doesn't matter what we do with
> the clocks.

