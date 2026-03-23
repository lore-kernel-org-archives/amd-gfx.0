Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74986EC01AA
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 09:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1151610E441;
	Mon, 23 Mar 2026 09:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xXfiAoLx";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D67210E441
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 09:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRd7oqYZMoNu5Gk9ay2P0yKWC8PRRvX3aw0xACaW7g4Kt0my3f1OBIYCM+yymtUQqh/8sIbb74XcrTusouZPSUKHIg1jBKijfrwTCUc5T1mDiM+2K3d4nWusQDaUxj2g/1Gfvgtv1Ma5JDcZHEitr3AwSlHEUvKaOXq+z24vQ6BwNEY7a9a1LqkO8Qdeutk3nSc2yhs9EEietPYIoYzysPNKW+6pqp2xL6AMOPKUMj+Q2kAcTbPdvaVPKKp1RwCoEj/wDpytOIf8zHVBVMLs+wPkSPLiRgbQxZfwQH/9HOJoY1JwxzxSHwf0q1we2XDP18jz3A1/T8wObFtDAo6kDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3sE8NKhb8Z8gFrPuQ8L1i1MLahKPCz04FY4n5gcrKM=;
 b=rOzlSoB/HZbUJMu+t3C4lIDUe3RN6UY9jKMHShMOJFLEcViS4YJG+tAxMQlay8jXrkdJdsDcFABmNmZ3m3xXFq3gWvI5bqNuUPAjOvj/8pR92lNEfowTVRyJopjhK6yyJ4Shz34+CIB+GNUNJiznYdZ5FSS2HqtGvQq6OvWHUlMCd/7igs67kgDyrgRFDa4R2QCWuGlBnTMpY+ZNibRgDr50V7UXXQe+s8i+rxXFfVuVcNU3lAqlu/OSedCKIfmNV0Q0lmoRpALZj4FNsXD751+mTS9DiAlo7sXFC1JLegItVV9dXyvQduenHWyM5ZbQzOI7WGx+cnqusKh+MHFNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3sE8NKhb8Z8gFrPuQ8L1i1MLahKPCz04FY4n5gcrKM=;
 b=xXfiAoLx5bNHW5PhjelrBAwiWIap90/nCPplyfcd3Sm05wYIgfUaGcNJDbqmic1pD1DGWmhEsTUUtMLvQ1b2R1C4qe8pSfjofMP9vl3TUb53rFVtyAnqFW1tSwU0dqdj4GnA4OS6uoGUgrxcHUEr3lD2Ai9CsC1gEC80D9g99+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7178.namprd12.prod.outlook.com (2603:10b6:806:2a6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 09:14:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 09:14:03 +0000
Message-ID: <65c61436-f076-4308-b89f-d2bdb214e481@amd.com>
Date: Mon, 23 Mar 2026 10:13:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>, "Lin, Leo" <Leo.Lin@amd.com>,
 "Perry, David" <David.Perry@amd.com>
References: <20260319073250.147808-1-yifan1.zhang@amd.com>
 <80732b5f-27a9-4969-8afe-98f3156c725e@amd.com>
 <CY5PR12MB63693D88EBEAEE20CC4B6870C14CA@CY5PR12MB6369.namprd12.prod.outlook.com>
 <f388c29e-4d1c-4d04-9eca-ce3b74f00931@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f388c29e-4d1c-4d04-9eca-ce3b74f00931@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: df355699-2df7-4aeb-15ba-08de88bc870d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: F7d11x+bh2phvAy9SbMNutdZKQ1QFQY97ng29YMr9tvEPBwaYsKr1pa5a/QAO3ntg8ptMY5KxxiVRt9wS/Uy3XzH19M3A/iZe84LIwstnMPv3sCIg9osN6X5keDEdzSbTrgrVG4oENFFhQXe/FItr/Ek0BWt+P7RHYvfxsMDp20om2v3DBeJa5/dfJ4yZWcEEjb6/v63rcITvQe0yHRJpUSN8l56WN75oWHRaidVh9Si1xt1L7GnYnqHPFscFNL+PIkB5UCdjedqtidywLbzn68n2j/epUufseFWwLS75xGWQa2ImlPfl2MXqg4tZP/GBO7GRqbE1ZOMgHQcQ/DW1RWlJFjhDA7yf/v5dHwRsE2A3cfurtpugKfFORfPfVX+R4bRn3u4L9ouT0ZR5O1CHUHT4JpDxsD9DryiYzPYtdAVeo1JPiziskgvGEfW/6KWc0X8pJJAsBOC9LbtbCVJvHY+9Tfv4+7ylwgYCheAKxmuQqn5toON60/lhJ7vNKVWA5TOzneykepkWytIoZbimKZCaNBG5CmKZWwye0gDLg+qnx4YpgDIxaH2wJ3teII9FbH38XBqRxUrK49zL6Kq+xwzWdbYKHBt5BQCTV6s6b0lhjqCKwnMKLHw21G1WLImIX409n9mStVV+IncZFwvl9KtSDKAieH3ex3Mo8OOvRSASXTpkYlm01cB63ZcF4Ouo66HFk5LhXLQP7uVH8HqpVpn9au+nHMHUG/UeDZoits=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmhtdU83N0czL2pIanV3V3NWVkdpZG1nU3Iwb2M2SWFwbHUvVHh2ZEtpd2RM?=
 =?utf-8?B?MDFheW8zUkVkZFh5dmQ2MEZBUEdpWWJyZWxCd3hxWm1XYk9Dd1NlWjVtcU5L?=
 =?utf-8?B?b2Q3c0R2TGtIbzlXV2VYTy9neHZNeEFDR29sdy9icUxYdjZyWHluNkppSTl2?=
 =?utf-8?B?U3FDN0U0Tm5Yeng4Lzk0ZWlNbXZkVmdtOWh5VlFVc0NKVGhaaHFQdXFzNEhz?=
 =?utf-8?B?YURJZUNXVGYzYnZzSDlTM2F4VU84akw5dkFjUHB2U1Z3MGVMai9wR2pvS2hh?=
 =?utf-8?B?YVVGTk94VzNaWThia2pVV3lWSENPM1JuOENDTWVlcXpMbS9kb1MxSXY0U2RS?=
 =?utf-8?B?VE5aNWg4UDR3VUViZzh0K3FvSjNWeWxzUDhpOGV0MjBvQXJVcTMvMWc0MVRj?=
 =?utf-8?B?b0pMbU5vZDE1cWRhQ3IwaG0yb1hLSWN5U293R3ljQzJaSDlKUm1naXptYWN4?=
 =?utf-8?B?cnNVeGFQMDJzZkFCUEJsTy9GVjJ4UXQ4aGoySjNvZEh2eDJwTHhMWjZ5WXpL?=
 =?utf-8?B?QXc2bDFSZU1uRW9UWmE2VHZReWNheWExNEMvOFpxdVhaSGZiK1ljZzFocXNH?=
 =?utf-8?B?MWJReEsvOGJPWmdxckZBVkZiT0NTd1FpcWhkVmNMKzZONXZ4ZTJkVGluRERp?=
 =?utf-8?B?VUM3dTg0Ym9JNU91N2xFN0pDL2FrQmJ6VnhvOExYTTd1bHB2SklPQVJPblRC?=
 =?utf-8?B?ditwSnRaR2pGK0YvWjljR0IxMWNDUndmRDBPUkU3SUhkWWNaT3RPNERZMFRx?=
 =?utf-8?B?cG9PK0plTXQxSlN1ZXptUDQvQWpETEptck04SVpFUk9Ra2ZHc0xiSjdmQ3pF?=
 =?utf-8?B?RGNuU3lxTUViRHMvMHp4b21IckxDdUNnT2dNMHJDZ1BMSkJ2elRNRFYrdjc5?=
 =?utf-8?B?RXB4bmdVQVR2SXhwUFRSZTk3b1RWVHFFbUxmZWh2MGdoM1RsaVVLd05YR3M4?=
 =?utf-8?B?WDk0WHk0cDRLUkh6NWhSTFF2TDVLUnNjeXNneGtGYzBxandvQ0RySmE1RDFt?=
 =?utf-8?B?MUNPdHVZNWpNUEFEUlUxSCt2YlFlTExrd3lDVVdwU1hvYldYYTRLWmdiaGUr?=
 =?utf-8?B?enlNbGoyZk0wdEVjL0ZyQjZaSEJhSGFXRFFES3JWQzBIa2c1bkNZc08xOVlo?=
 =?utf-8?B?SGhaUzUvOSttcUpSUTM0Q0N4UEZMeUN4dGlkcGQxWTRiR1E2SG5JT0NLc0tK?=
 =?utf-8?B?MWFhcnpWeG16ZWorZWZtUmw0aG04QUV3M2dmK3pXaldaRSsrQUZTZGhmb2Na?=
 =?utf-8?B?M1dGVlVnOS9ndGNnTHhiMVNHS056NmdUcjlTRm84RGZXbGRLSU5acllxdzBm?=
 =?utf-8?B?SmpIMzVmT29VSUVjdDB1d0FpbWxBU1lVU29teGNCMTAzVjhRZTBCOFRmMzJ1?=
 =?utf-8?B?SGw3K2dyZVd5eDBiT3dmRm12aDg3aTAyemh2Z2JRVW5ENzRWVDFZQWZ5UWc3?=
 =?utf-8?B?djdjTkpvNTlCUnBHT3VlVVFVamxVOFBVbVVmYlRsS1k0d3kzejhZejlvVGF6?=
 =?utf-8?B?YlpKak9xRjZzOFV2NlJ5bVUyTUlUS1pWQVhnVDk1dDlRL2c0WjlOVm5EYVVI?=
 =?utf-8?B?clIwbjJhWFc0S0d0eDVzVUNOemtObkxvVjdjWEdodHNNU0pDN0prSXY5M3Bj?=
 =?utf-8?B?ejZDYzM5MGpTbjJuWldUN3VIRzVnd2YrZkxEd2cycVZXN25hVkZ1TUJQKzVv?=
 =?utf-8?B?TU5wdzB5bE9seDNBd3pRNEhkVWNpc3RhMDBYRDlqQXlWMHBpNEdaa2VZWjFC?=
 =?utf-8?B?VUhLd25sRm9UK2xBUUt1cUtzck9SeFdMWDFITnVVZHpDOFR3SkhvMXcrajRY?=
 =?utf-8?B?Yk5tUmVqQWk1K1QwaWw1NFBUOEhIaHlpeE9wemNWQnhIMWFkZExPMkdsT012?=
 =?utf-8?B?dGRXYXBRNk1QOS9EMkdxTWlFME5TK0NzOEVIaWZpWkVYRkdSOWRtWnl5Q1Fx?=
 =?utf-8?B?dHl6Slk3ZVF0ZmFBSzFHblh6WGdsbTYxUXlvNjhNTlFrZ2ZlYnEyTE5ZZTNi?=
 =?utf-8?B?NmwwU25UajM1eDJQQ3A2bDdTYnBMcExlV1BKM0YyY0ZjYU5DWDJ3WnR1NHRT?=
 =?utf-8?B?ay9VRklSanRGQTBhWmdvczF6dGZrZzB5ckVzc284c2FGbGQwNjlJYnpOVTBr?=
 =?utf-8?B?dUNXNSsvRU9IOTQydGQ2WFl4MDNPZm15ak1tcXNjQWlkZTlIZWtkWTlaa1Uv?=
 =?utf-8?B?ekcyekpJTk1WMWVkbldFdUYrQkZ6STh3blpaTUdZMVYzSW9LclZQR05zMWti?=
 =?utf-8?B?ektWbVQ0TGdsUi83Zzdibnl1SVVhQitBS3lNT1puaGFSSWQ4bFlmODE2bERt?=
 =?utf-8?Q?yrh/PlvBsOgWgLs+PR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df355699-2df7-4aeb-15ba-08de88bc870d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:14:03.6612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGXcKiuqNhosOuE00D2Y9dJxuEo8adeZVVG/x9DHJqcYhBQgj6TUCE5UXsYZPpu9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7178
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

Hi Mario,

first of all please loop me in on TTM changes as maintainer explicitely. I don't see everything which flys by on dri-devel.

Then changing the 50% limit is an absolutely NO-GO. It's completely irrelevant that AI wants to use more, HPC use cases complained about that for decades, but we simply can't do that reliable.

Regards,
Christian.

On 3/20/26 15:34, Mario Limonciello wrote:
> I think there is actually a very easy way to trigger it and it's not obvious that a user messed it up.
> 
> Assume you're on a 128GB system with VRAM set to 512MB.
> 1) Set TTM page limit corresponding to 96GB
> 2) Use uma_carveout sysfs or BIOS to set VRAM to 96GB
> 3) Reboot system
> 4) Now VRAM is 96GB, but the page limit was a module parameter and will be wrong.
> 
> I actually /think/ that the RFC [1] I proposed a few weeks ago could be a good way to prevent this.  By using EFI variable instead, TTM could sanity check anything it reads at startup and save sane values to EFI for the next reboot (if they're insane).
> 
> https://lore.kernel.org/dri-devel/20260306055439.1822879-1-mario.limonciello@amd.com/ [1]
> 
> On 3/20/2026 9:28 AM, Zhang, Yifan wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Yes, I agree. I’ve just been notified that this memory configuration is a mistake rather than a valid user case. So the fix is low priority for now.
>>
>> -----Original Message-----
>> From: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Sent: Friday, March 20, 2026 11:14 AM
>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
>> Subject: Re: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
>>
>>
>>
>> On 3/19/2026 2:32 AM, Yifan Zhang wrote:
>>> Current apu_prefer_gtt setting only check gtt_size, which could be set
>>> by user to a larger than system memory value (via ttm modules
>>> parameter pages_limit). E.g. carveout vram 32GB, gtt_size 50GB (via
>>> ttm modules parameter pages_limit), system memory 31GB. In that case,
>>> apu_prefer_gtt will be set incorrectly. Take system memory into
>>> account when set apu_prefer_gtt.
>>>
>>
>> Wouldn't it be cleaner to do this in TTM?  IE test that a bad option was set by user pages_limit value and then show something like:
>>
>> if (user > possible) {
>>       pr_warn("Requested invalid %d pages, limiting to %d pages", user, possible);
>>       user = possible;
>> }
>>
>> Then we can always trust what we get from TTM.
>>
>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 2 --
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 4 ++--
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++--
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 7 ++++++-
>>>    4 files changed, 12 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 3bfd79c89df3..a6ee9d9bfafb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -170,8 +170,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>>>        int i;
>>>        int last_valid_bit;
>>>
>>> -     amdgpu_amdkfd_gpuvm_init_mem_limits();
>>> -
>>>        if (adev->kfd.dev) {
>>>                struct kgd2kfd_shared_resources gpu_resources = {
>>>                        .compute_vmid_bitmap =
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index cdbab7f8cee8..13cada7da4a9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -369,7 +369,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct
>>> amdgpu_device *adev, int xcp_id);
>>>
>>>
>>>    #if IS_ENABLED(CONFIG_HSA_AMD)
>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>>    void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>>>                                struct amdgpu_vm *vm);
>>>
>>> @@ -382,7 +382,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
>>>    void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
>>>    #else
>>>    static inline
>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>    {
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 8a869fe41acd..4fba7d2f34a9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -109,13 +109,13 @@ static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_ad
>>>     *  System (TTM + userptr) memory - 15/16th System RAM
>>>     *  TTM memory - 3/8th System RAM
>>>     */
>>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>    {
>>>        struct sysinfo si;
>>>        uint64_t mem;
>>>
>>>        if (kfd_mem_limit.max_system_mem_limit)
>>> -             return;
>>> +             return kfd_mem_limit.max_system_mem_limit;
>>>
>>>        si_meminfo(&si);
>>>        mem = si.totalram - si.totalhigh;
>>> @@ -132,6 +132,8 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>>        pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>>>                (kfd_mem_limit.max_system_mem_limit >> 20),
>>>                (kfd_mem_limit.max_ttm_mem_limit >> 20));
>>> +
>>> +     return kfd_mem_limit.max_system_mem_limit;
>>>    }
>>>
>>>    void amdgpu_amdkfd_reserve_system_mem(uint64_t size) diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 714fd8d12ca5..df98ece071e1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -2071,6 +2071,7 @@ static void amdgpu_ttm_buffer_entity_fini(struct amdgpu_gtt_mgr *mgr,
>>>    int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>    {
>>>        uint64_t gtt_size;
>>> +     uint64_t max_system_mem_limit;
>>>        int r;
>>>
>>>        dma_set_max_seg_size(adev->dev, UINT_MAX); @@ -2210,8 +2211,12 @@
>>> int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>        dev_info(adev->dev, " %uM of GTT memory ready.\n",
>>>                 (unsigned int)(gtt_size / (1024 * 1024)));
>>>
>>> +
>>> +     max_system_mem_limit = amdgpu_amdkfd_gpuvm_init_mem_limits();
>>> +
>>>        if (adev->flags & AMD_IS_APU) {
>>> -             if (adev->gmc.real_vram_size < gtt_size)
>>> +             if (adev->gmc.real_vram_size < gtt_size &&
>>> +                     adev->gmc.real_vram_size < max_system_mem_limit)
>>>                        adev->apu_prefer_gtt = true;
>>>        }
>>>
>>
> 

