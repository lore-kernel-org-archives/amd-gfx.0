Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA06FFD530D
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 07:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2044E10E152;
	Fri, 27 Feb 2026 07:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bQx6mZkI";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E94C010E152
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 07:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMxSuCbcPY0bcwP4oxu20W0fv7B2fA92BdPIDOdcsK4zYtOfJrqqkZVoDoLFk5dfWAgvF4UKr9tRd/J10fcS7gEHj6AurZ2SBN54GWD8Q24Brv6P0r56eOlxbQxPkwfOyblng31SUFe2WRdUUt8RKMCJbzWnuoU4+vljdsN7pC38rG1ZzAcy/SX07upeL5N1SQqP9CkbSYDKod4vKHse45glEu/RdwbBKPVDRkBboKk2sgnO+D0LTJqAxC5YzcqbZOL3PJi/G0HDko5UqPrhLTxw2HmhlTTo9CW0Wvw+U32vCbUNPERUlYhjj7a5hcMGZvSDxnk5BAImOyrVkHEirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dmue274Ollyh4MjWvltp4dT6B4yZaJH4SOd9V/IW7Y=;
 b=GLaHbuZc0SbR3x3re5c8FGIhRRxrwo9YL8S1a1ferdT/sC8duXQgFo2u2NhAVKmXiev1ZkhmhB2uAlMC92OFdbhOgavOmZCECMn6NtrVCXpCL+sWOmhxHmprwgTIlG1tuF9VzzbG7+imQpCVCvXUC8dQ6EvlhkLIhE5bVdOzRxgdR9dHYOkldu6gk53WZQQvuCX7tiZGxFH7P6zj6j8+U4zGrFWzxZ6gTZsSMWRKbkB6FEAt1ybv6HimXYZKFNGJaZjz44EuyDKt+YUDLtzurnDrYadbA0ljkf6ArLKjeDZieH+9N/9CrMU/GBWXhgX2yDm71a7+sqynx3KfGi5nPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dmue274Ollyh4MjWvltp4dT6B4yZaJH4SOd9V/IW7Y=;
 b=bQx6mZkIk+shT6FLY6yDIBn4feaTyV8AE1ylIfnAq0A2yu4IN3Ij9yG995nV8hoCrxaKPn3cCClkSXQmLR86I8Cr55e0HkKQQ62rfMbTT5HGZRQiPNFLrEFz+YtIIIHE57z51aJ57DXl4LsScPrrFpUIIGW5FgDVhL+JOuvLijk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SAWPR12MB999139.namprd12.prod.outlook.com (2603:10b6:806:4e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 07:54:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 07:54:59 +0000
Message-ID: <5e1692a3-40f1-4adb-9a7f-7db064a0b11c@amd.com>
Date: Fri, 27 Feb 2026 13:24:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <20260225093406.498727-1-kevinyang.wang@amd.com>
 <96885b73-a1fc-4b3f-a35e-0177a415a331@amd.com>
 <CADnq5_O4u+v9f5XNFipKHPa1qC6tEr0k4ppZXX0tUqrAjY8PXQ@mail.gmail.com>
 <DM6PR12MB2972FEFE85BC8F6C684E25068273A@DM6PR12MB2972.namprd12.prod.outlook.com>
 <5accd44a-5795-43cc-acf1-a8467038b7a2@amd.com>
 <DM6PR12MB29725599B2FE50BD48D442238273A@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB29725599B2FE50BD48D442238273A@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SAWPR12MB999139:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f313fe-fd22-45ed-e120-08de75d58182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: bf0nPDOakT2AqSCptPU0wJhPkeTeDVBWmjyagkRZT/uTtMPIH4YGY4vPCLZ+T08zNPR5798FchGxyXiHNxUl1VXWositfx8VVn3ZQZraNjgjkT1N+Aa5npmRX0ByaC1HbuVKuoUXXYAw8oDsk0c0kdlF4zPhZTY2zROx6s4eWhO49V9uHZhaPPpA/fwtLlo9aGxecduX9sSy661aI9qqq3mE3eLR/NmYygOlyWSW7byFoVrcYaUAuNA8OzoJ1EuPM2Ck1d+UAMBjKpvMzq84iHTdpKsrkuTLwzMa+9AepF5XcGcS9UFJL9YnGfEJRa1txE11GPJYjQKp0FGqDVzqwojuq6V0V+F59i7bLSLm/L0iF5Ihft/zSvvMQQ5JCgG60jz+C1i1OHyRVpSQdiNfEixsYDgMeZNwOaPMmYwWwytRAmpiyrTlBdrwc/pQuxXIbnuepjkep6Hq+E22PbLbKfF5asTNgaZ0C6cLSengPoWYvKX7LRtoNrPsTVYXoXglmfrsdXVqz6F4S7YNQiaiHZVk8R+d7RxojOdUQwF0Kcub+0o2F3Jx52E/kIUUd214Giaiviqtw67/zFX2O6oMz9SVS21u1tdYuF3IRGppAwleXGLmSCUu9v48xxeRCqhBizkJ4AV41MALujYygrIvgbLAhAwsdU5M3SMjsu9Z6L1FndcK5ezjsz72pr0bFdGH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3JSekxaMlBGR3prOGl0T2pVc0tSUlp3czVuR0FPNTFoT3dGUTlaSTV6dGRo?=
 =?utf-8?B?bG9yLzg3SnBLYXUyZ2Njdlp6cktWSU1kVWQ0T3JMby9rWFcxdGVnQnFtWDVr?=
 =?utf-8?B?TnoweVdzL1FxT1Z0LzZndlU2THRsc2tjKzlJeEgyZVA5elVHaDgvK3NEeUY1?=
 =?utf-8?B?WW1ZR005Rm9IZVdmV21YNnZXS09vc3dQUEpFMk85TFRkMm5hMGI0eEpSMU1p?=
 =?utf-8?B?OU9CTEFhNXJ0ZHI3YytJTmJnVHZxQWJXdmlyamhCcmZPcG9obnJLNzRocE5Q?=
 =?utf-8?B?QWhVSlJpUFJpayt2VlMwL2R2aUZVUFZ1S2hTMUdGRkNaRkZTZFk0ZW1JQVlJ?=
 =?utf-8?B?NitRQk13TWI2MElURUdMZTlZdUNSRCtDNnEvdVdRN0xFOXkwZktTTU8yRFFt?=
 =?utf-8?B?R283cCtENVptak0xTXd3bVJKdkUzYzhhQnR1d0l0YXp0QTJRdE8yUzJnL1hu?=
 =?utf-8?B?RVFUczhRTHNzdWZJMS9BcmFLVkgxTlZ2NDhVTlZlbktEdVNsVmhzNGhkOE9N?=
 =?utf-8?B?ZldHUWtPRFpVaHJMa1hDSVMwOERGTG9kTmswUXF0YU8rT1Z4ekw2QTd6b0VJ?=
 =?utf-8?B?ajVISXJFM1g4c1dOM1dQMXlOc2hkbE1UVEdIR1dSWjZzU3BCT3R5NU5DTXdU?=
 =?utf-8?B?NExuTjJPWnllVXVLd3I2ZmtNQ1I3MnpLRUdGa1ZIaGV6YWlRYWV6UUpuNVJB?=
 =?utf-8?B?MnFTTWJCQTJxc1JxVG5sZ2FHKzUzbFkzS0d6OFg1RFNqTXdHQUNLbFI0NkE5?=
 =?utf-8?B?QitFU1dkVThxWnVxcDdkdG1LY2hqK3BJbTJRbkdiT0owSjRjT1BuQ2g2bXpM?=
 =?utf-8?B?Qk9hNER6bDJDWkdkK2ExQXYwcGVCenB2aGdrNDhvZmN0c2xsN0M0Qkl4YnhE?=
 =?utf-8?B?aUN3WXpramlZcG4vd2hzL0N5czlJczN2VEVPcVVGc3FTUlBUcGhDYW0wQVNT?=
 =?utf-8?B?Z3dvZ1hrMElUYXYwaWhlRXpaQkdibmdtY1Z2b1R1c0xKdUhnSlM2ZWNRQlhZ?=
 =?utf-8?B?Nnl1ZitTakgxWUFJemc0ZTZ3LzByQVVuNEtaVkowNE9sMmowa0pRcHd3cjRX?=
 =?utf-8?B?dlA4cXNVSStVdDhJNTR5QVVSRjlzbGJxWDU0Y0svVEVGRjBVcW5IQ2Y3TFNm?=
 =?utf-8?B?NnlRM0hSVjBIa21GL3dVYnR5eExTR2dKUEJ6Sk9YeGNXY1BHSkdMSmVRMGFw?=
 =?utf-8?B?djRzRlVWZXhjNWI4b1NCRUcrVlF4MHBERXY0T1RUZjRmQVowbURhNmtVSzdS?=
 =?utf-8?B?LzZNNHJvNGVqT000cThHU2F4MDMxcmd6Qnlxd3c2RWVSRG5QTlFGNmdmQm5I?=
 =?utf-8?B?a09yZkVZc1NPdXNCaUNDdHpWeWY3RkdVL0VRR0Z0N0Y0V3VNRkoxTHprN2F3?=
 =?utf-8?B?ZzlFUlprV2o0N2xMM3NYNGdneFJqK3lIbUpIWWRsOUFrMWljV3IwcDJsM2U0?=
 =?utf-8?B?aEs1WjN0MDQvaStwZGhkOHBzSzFXRzJUTEhPLzhpYnMzc2hGMVNIOVk1cUdl?=
 =?utf-8?B?MyticDBRNTJINGpSZGRCYWZvdW1oN0oxa1VVRXRITW5VOEh1WlFIYTZta1Q4?=
 =?utf-8?B?bGdRTW1yUWp2TFNDN0FMd0U0Y3dPM1dRaUNwZ0t3UktjS3I5b3BQN05NZ3R4?=
 =?utf-8?B?RzloNmUzOXJuQnd5WGtmMkhiU0hZcWROdHVjNEhSZys0QWJkbE8wdHorck9R?=
 =?utf-8?B?MHRJazBhRUxmM2FtUGlvMWhaOStIZDVndWszL0VIK1BFUjdyemRBd2ZSUlBO?=
 =?utf-8?B?R0VrSmlsS2NmdHcyMllhcGQzOTBnTmxLTFFsckxmMTZnTW44RHR6TGRndDIy?=
 =?utf-8?B?d01rZ2lmRDJhQllHOTBmRXo1eHBoN0U3MjNCdXdtaXdQTWlBQ0NqMHd5T3hI?=
 =?utf-8?B?VHNQYm9Pd1Y3TlcwTHIrUXIxUXdXQXR4d0dSZkNlL1RrbmtzYkp5OVdRUVBq?=
 =?utf-8?B?a0xwSTVHOU50SkVMenpaVndWU2JBTXBvalQ1Skd4NFVCdHZGZEp4VlNkU21Y?=
 =?utf-8?B?cFg0eGM0Skk3cmlhbkJGNjliT29mS0pVNUhndkh6cUpablVSWTl4cTR6SHNi?=
 =?utf-8?B?a2h0WDlqU1N4S0w3aVJJZDNTbzFUN2lBeERXV2ZoYzVNdVJPSUlGYW1wU09C?=
 =?utf-8?B?NnZIVml0NUhpeGJ1cWs2aXZpeGxKN3liQmNtVG1wODF6dDc5SjB0Ri9qclFV?=
 =?utf-8?B?S1c5R3d5SVhsaHR3MmprU0s0TFpHV2x2c08zb0lYZkZQVGlKTzFNOEhrQ3hN?=
 =?utf-8?B?ZlduMnBockR1VEFaRmJ0em1uVDZFdHBBWHdjcFl5Y2kyOU5kMVhyT2dHOWsw?=
 =?utf-8?B?QWlTbUZtdnA0Zk9oWS94QXdjeFBZd1Zwa0NZNU9IN1NyVE1xQk1Pdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f313fe-fd22-45ed-e120-08de75d58182
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 07:54:59.7900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGazpwwkuIE9AOUS3nwwzE2roVrHQ+1ewefAAr404Rhi3UAkKl9gyUQK29MIPH/C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999139
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



On 27-Feb-26 1:15 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> This is not a workaround; you have misunderstood the intent of this patch.
> All ASIC load sensors must be constrained to the 0–100 range.
> In other words, the KMD driver must not blindly trust the value returned by the firmware without validation.
> For example, invalid values may arise from issues such as memory corruption.
> 

We have many users who really care about the validity of the utilization 
values. If firmware returns any garbage like 65535 and driver clamping 
to show as 100% utilization is not the value. We don't want to chase 
ghost utilization bugs with this. If there are issues with corruption, 
fix it in the right place, but keep the integrity of utilization values.

Thanks,
Lijo

> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, February 27, 2026 13:40
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
> 
> 
> On 27-Feb-26 10:14 AM, Wang, Yang(Kevin) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Ping...
>>
> 
> Please restrict this workaround to the affected SOC. Otherwise, if there are bogus values, we will fix it at the right place.
> 
> Thanks,
> Lijo
> 
>> Best Regards,
>> Kevin
>>
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Wednesday, February 25, 2026 10:24 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
>> amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
>> Feng, Kenneth <Kenneth.Feng@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
>>
>> On Wed, Feb 25, 2026 at 7:14 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>
>>>
>>>
>>> On 25-Feb-26 3:04 PM, Yang Wang wrote:
>>>> Limit GPU/MEM/VCN load sensor values to 0-100 range via clamp_t to
>>>> ensure validity.
>>>>
>>>
>>> Is this a workaround? If it's not within range, it indicates some
>>> underlying issue.
>>
>> Likely for:
>> https://gitlab.freedesktop.org/drm/amd/-/issues/4905
>>
>> Alex
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>>>> ---
>>>>     drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 +++++++++++++++++++++++----
>>>>     1 file changed, 23 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>> index 938361ecae05..86ef1ffbf1dd 100644
>>>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>>>> @@ -1414,20 +1414,39 @@ static ssize_t
>>>> amdgpu_set_pp_power_profile_mode(struct device *dev,
>>>>
>>>>     static int amdgpu_pm_get_sensor_generic(struct amdgpu_device *adev,
>>>>                                         enum amd_pp_sensors sensor,
>>>> -                                     void *query)
>>>> +                                     uint32_t *val)
>>>>     {
>>>> -     int r, size = sizeof(uint32_t);
>>>> +     uint32_t tmp = UINT_MAX, size = sizeof(tmp);
>>>> +     int r;
>>>> +
>>>> +     if (!val)
>>>> +             return -EINVAL;
>>>>
>>>>         r = amdgpu_pm_get_access_if_active(adev);
>>>>         if (r)
>>>>                 return r;
>>>>
>>>>         /* get the sensor value */
>>>> -     r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
>>>> +     r = amdgpu_dpm_read_sensor(adev, sensor, (void *)&tmp, &size);
>>>>
>>>>         amdgpu_pm_put_access(adev);
>>>>
>>>> -     return r;
>>>> +     if (r)
>>>> +             return r;
>>>> +
>>>> +     switch (sensor) {
>>>> +     case AMDGPU_PP_SENSOR_GPU_LOAD:
>>>> +     case AMDGPU_PP_SENSOR_MEM_LOAD:
>>>> +     case AMDGPU_PP_SENSOR_VCN_LOAD:
>>>> +             tmp = clamp_t(uint32_t, tmp, 0, 100);
>>>> +             break;
>>>> +     default:
>>>> +             break;
>>>> +     }
>>>> +
>>>> +     *val = tmp;
>>>> +
>>>> +     return 0;
>>>>     }
>>>>
>>>>     /**
>>>
> 

