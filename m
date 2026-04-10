Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDB9E9905C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 09:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB8010E8F9;
	Fri, 10 Apr 2026 09:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fs2EBW3r";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010036.outbound.protection.outlook.com
 [40.93.198.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D3710E8F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 09:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkGHEM2Gnd+Qk5RSXH58/H1px5zpWW9mc6gY0lyT8fcQ+JevwMmCVV1m4PY5uh7lztt+vE1UOQOTTLP0KXGVcciXe/US5k63s8HVwoV9FfjkaDxvrOw+AYDusc9oqcfbk9SbP7M7GYkUXMl/H0AfvPa0IHIei9HKsEvx6oLD/J5nu2fk/kJKYFoT1ZflsXvSUs6j+NBlmDkXqiSo/GJRG/CI2S2KsNGzjlzPiDw8aoP62diGzgiD54UFkP42JMuUaat+e6AUw7PYGB4JzNJf89tMCD+DIxepOSLajziu1jCxV3CZSnsuq/HuEVilnfbIf+umQbKBOrO3dBng+6Feow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/z7gxX+h43Dkmh4sFERmHxHI19fR3PnNKOdJnXm2WA=;
 b=kdZ1JvysrgESq7bRPldM3h5o0iMOVElK9eWFSKEcy6IynHk55LUJD8EuCvFPEfT1ANUeXiWwbUz4pgqPH+pTySqQD4Ql5X4p8qBSeGmGx0gDlUhYWeACzMBTBIuc9HpzCBZDPLgsI0mc7nGevNiPAblSawQHALG99pGEEmGf3miuugROjngm/nswRTotDxgPFw54U3ve8JFQYjWkFcL2dZ3Uv2SxNPQyjBIat2nzmNmepZs/ADU07fH1t3She9E/Zy21mioSb722+njxI/RYyTmOosr5jelphq/xl925vFAO8hnZ+Om+UZrJBEPC5mHOMFRW3zlqkrGLBlsIRTYRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/z7gxX+h43Dkmh4sFERmHxHI19fR3PnNKOdJnXm2WA=;
 b=Fs2EBW3rmJXYliR2wnn9xPQdL5Mkz0VrdeNw6yKMVJxv3DTGVM9TkGPyaLm/dxdgQIKNfJGjM72vB9x7/Lb5E9X49f8iqBd0VgeXEKzYqFsimQft/yqo9/6qhrZKcb/E++06YVDlxDj9o6q1X7Hg0f/CGm2JD41wg6xg/CgVz14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Fri, 10 Apr
 2026 09:13:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 09:13:17 +0000
Message-ID: <cd093c11-df4f-472a-93df-1d875f479745@amd.com>
Date: Fri, 10 Apr 2026 11:13:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: recover Thunderbolt PCIe link after MODE1 GPU
 reset
To: Mario Limonciello <mario.limonciello@amd.com>,
 Geramy Loveless <gloveless@jqluv.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
References: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
 <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
 <47306de6-cbf6-4b2d-847e-d1e5d933516d@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <47306de6-cbf6-4b2d-847e-d1e5d933516d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3ec22b-1cd5-4330-e157-08de96e166de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: iEwHzkLAjZzWyQsWYJR9Bdv0CZYsPR4oqi6w5OpGSsnHSmOQNX0YrOmRWJrOiV8HIceK4bFS3rikfRHWz+T7qW97ZCFXBFwGJzP8TPBC1jgMk4Ojzs80rxxOG81y80yE8gY4LqRJAueawZAlBASqIUhWE0rtBHyBm70YGlIxS7tWIt7ykfDCMPAQhiNyKnnbCtYowbum8bAjMDpN74Cj2cJkh4Pl5NXfasFyRz2MMZlgrU7B4lfya+6qoQktUr/79msUSKfI0pqWch8OKByATM5XHqGBZe6s9M7x+jJNg8br025JNc47j8fhvq9m9VarYzYqSjJaM+40QU7vRgiMq+AOcat3Ytu8z6eHSuHUu5bPaYvhn54LOmuvySz8KDyM2NYUKZdmHZRYzwSszI9/KtW+gAMxrQIQZ6h4LT6x5mwCEKDJiYuGrVeJHpPXDiNOEvJwB7enKK8BHQlVdGZUrlKpLSTxfPslx98tee2XNUUzI9yt3NP2FsZ4xVTHQfF3bwnqvFo5X7WCo2FqelEQyXptv8wN41E97M8dSg7+kYUl9dzCVsdll73ug5WPmAWYzx6j6lp3lfgbI6vZnweiMQFtjrznMZC50Z124BhCpBQ83rdYvpvJOvAqL9gFlxikNh4yH1SvXw5Gnx2FL+2eJSHx+mVEKsxsc2077MeyrParSz/345nfbM+BzhpNQVFa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVVJY1pZN0xWc0F6QkhiSjJremphN1lWWGJSTjVoYmpGMEFoNlJ5WE9ERmpu?=
 =?utf-8?B?bW1nMVZpeG1PQkpVNzFhWHJKOHp0WkI5Rzd5UVp3SzdKYTBxbUw2RUlkemdF?=
 =?utf-8?B?bjRuK1ZMbDNmMWgxcTVtUXRpVkpTQzQvYTU4aDVERGJXL0lOVGdWSFlKbG9V?=
 =?utf-8?B?Rk9pYkc0YWJETlB2YnNFdjAwY3BPdllOZ0RONWpyRkI5Uk5DSmdxcHpXQWRW?=
 =?utf-8?B?UWdqeisxV010emtncWlaQU5ScHptRGVCc2twRG9yV0U5TFUxMGtFRm5hZWpv?=
 =?utf-8?B?Um1tK01RWmNNRnliTk5Vc2M0Mk1zd2hoZDUvVWN2d1RYZVI3UHo0WlJFajNW?=
 =?utf-8?B?d2JrUzR6bVA3OVlrSm9oVUs2MzRjZ3B0cEtJd0RFVWFmeFBqaE5kcm9aM3B3?=
 =?utf-8?B?bVJLclR0WkM4b3dhd0dCMENJd1plUnB1dDhLRjdzNVA3WlJ3UllGbDBMKzNs?=
 =?utf-8?B?ZGZ5N1drdHg5ekFHM0RPY2RBVW53QWR6SU5NZjFMbEl4V0twSVlNMFc0Vzhr?=
 =?utf-8?B?cWMveExWZ01xUEhvcDZLaktsRVVrVW02bWt1VDNUQndlVnVacHRLT3gyUFlW?=
 =?utf-8?B?QkR4UHd4WkJtM3E2U2N4VkZsbERndy9tYlBUc29TeW96VnptTUptUG5xdUVI?=
 =?utf-8?B?eWxkNDY5SGNrWEdHUzJxZzVDcFFDazEwK1QxYXhvSE5lZ2dod0swU3VvU0tX?=
 =?utf-8?B?TTNPbmxxdkswdlJtTjNDZHoxZXFxek41OWxHUG1sS3l4ck4rcUtmbTdZRnAx?=
 =?utf-8?B?Lzk0U0RWLytJTjlyakwzampVTEZRT0F3L0wydzBKOUpCZ3ZwYnFoa2JPbzkx?=
 =?utf-8?B?ckFodDdEelNrelo2YTJ4Rk0wcVVkSkd5VHhHWlV0aGJaWk1EM092N0xISXhO?=
 =?utf-8?B?T1V3cEVXYkI2L3dZdHArRFdkWCtaV2h2VEZoYXRaODc1RHZTZzdWNGh3Umxi?=
 =?utf-8?B?U0FtTHpQeTRIZVJCRWdDM05HeUhvOGxwb1NaK2h2aVh3NVVJRVl5dGJGOTVR?=
 =?utf-8?B?RUxLS3E4Mzh2UTQwWktrNEtvWFlKNEVsWlFQamh1Yk1TKzhDWTV5QzQxYmc3?=
 =?utf-8?B?Ny9RNUZsUmQySjY1WmJZMjBqUEpwYmE5N05SODBLbGo0bEhsWUl5b1VHTmRI?=
 =?utf-8?B?aFJNT1UycnNIdW0vOE94SDMyOFdWQ1E1ODN6aGUrSXdOK1ErNDMveXF1aEN6?=
 =?utf-8?B?d1lLd2grckt6RlBaSVpmdkRwTlFyMWNXRFRhYVBTdjJ6cm1WV003MzM5eWEy?=
 =?utf-8?B?L3U3a1JZZ1ZYZnYyZFNGYmc2MFNrblJUUGphbnVIZnhzVVdZemhXWjVOZWFz?=
 =?utf-8?B?QUJHSE9jV0VFcFpDVDdxdm1ybkpxVndCNnVrZjhaSnJNOHNFYkNJdEpkd1I2?=
 =?utf-8?B?bm5PWVpmTFZON3B6SEpQVERaU2lpQVF3U0N1ZjNZYzUvSjVKU3ZoZGRaRk1Y?=
 =?utf-8?B?eFNDV0QyQXZyb1picVNYVUhqWWdMQThBeERPRjI4ZlJxaUxxR0w3cTNOZS93?=
 =?utf-8?B?MmhiOFpoM3FtUmhUWUZZaWJIU3dlMFdRZFQrWGxFeFFwaFNLQ1NHUGtnTE5V?=
 =?utf-8?B?NWs0WHRmdk5ad3ZteWswY3lkSlRuRDVBRWw5UXN4SWdkQnV1b0NNVWRlKzRK?=
 =?utf-8?B?a2NPSlhzQTliR2hIaUo0MjlYczNDKzNNSU0rdEZ0bFE4NGc1eGxkaWRYUFJS?=
 =?utf-8?B?YVl5U3A2VHJyMFI4ZVNXc04ybE5vRERHREFQZzFFRnhnVXFkVGZ3NEY2RVZ6?=
 =?utf-8?B?dkdsY0FBOWU4eFJRRnN2N2diM0lFMVIxbmY0RXpObWZRMkc5UGdkUDZPdE0x?=
 =?utf-8?B?UUMrWnVUQ1JuY0hycHh2dWZvK3VLZjNVbCt3YVY0UzBhblpXTEY5WnVWK3hi?=
 =?utf-8?B?dlR6bjFDOTN3SmZoTjJyWmhYZHUyNk9GTGJmcVhuTHhFcWFzQnkzVDkvQkYr?=
 =?utf-8?B?Sm1FaXNMdkVtQU9JUXU2cWFrZ2xXcDk5SEpOclNab2tIbnptSVExaGU2VWlR?=
 =?utf-8?B?b0RWc2d0RGRpaXdTa0JXMkdERE03MUoya0R6cjBqbGoxWjNmWGV0RjVhQTV4?=
 =?utf-8?B?RDA2bE4ySlg1Sm1aYmNuOFMwS0hqMmZKbXVKa2o1azVyeEJMNmlxODZyRFBU?=
 =?utf-8?B?ZFlONFUrYWx1L2o2QzQ4Q0N5UE9oOXJkWDFuNzg3VmYvTUpUYWZMcmk2UW1T?=
 =?utf-8?B?NTFHdm9JVkc0TEFpYmtIMkZ0S3lnb21FTEJRSVYxa2FiNy92a0tNdWhzUU5T?=
 =?utf-8?B?cVlBZWQ0TjljNXRFTFF5R2ZPM1RzWWJUaFBGajFHbWprQ0ZqSWV2eVNRWW50?=
 =?utf-8?Q?qKtUHPlG5Th7+MKOOV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3ec22b-1cd5-4330-e157-08de96e166de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 09:13:17.2432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW4dwHBg++TSxUW/cTj4ktTXEiCwhoaIIVtf274AVBngacFSCIUFad/BBtCCFUCj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
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

On 4/9/26 20:12, Mario Limonciello wrote:
> 
> 
> On 4/9/26 06:42, Christian König wrote:
>> On 4/9/26 02:05, Geramy Loveless wrote:
>>> When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 on
>>> Thunderbolt the TB driver receives no notification and the tunnel
>>> stays up while the endpoint is unreachable.
>>
>> IIRC a MODE1 reset should keep the bus active and so the endpoint should still be reachable.
>>
>>> All subsequent PCIe
>>> reads return 0xFFFFFFFF and MES firmware cannot reinitialize,
>>> triggering an infinite reset loop that hangs the system.
>>
>> That sounds more like the MODE1 reset failed.
>>
>>> After MODE1 reset completes, check whether the PCIe endpoint is still
>>> reachable using pci_device_is_present(). If the device is behind
>>> Thunderbolt and the link is dead, walk up parent bridges calling
>>> pci_bridge_secondary_bus_reset() to retrain the physical PCIe link
>>> inside the dock.
>>
>> Well that is then a bus reset.
>>
>> I mean that is a reasonable mitigation when a MODE1 reset failed, but the question is rather why does the MODE1 reset fails in the first place?
>>
>>> If recovery fails, return -ENODEV to prevent the
>>> reset retry loop.
>>>
>>> This also causes the GPU fan to be at 100% and basically when it
>>> happens and you are not there, you now have a GPU with fan at 100% and
>>> cant reset it.
>>> I wanted to notate some other things I am finding sometimes before
>>> this adventure of patches to the kernel and amdgpu driver.
>>> Sometimes a crash could happen in the drive and then the GPU fan speed
>>> hits 100% and the air is hot coming out without any workload, other
>>> times
>>> I have seen it have barely any fan speed at all and heat up more than
>>> it should at the fan level its curently operating at. These are things
>>> I have seen with this gpu in a TB5 dock with the driver and
>>> instability. I'm not sure exactly whats going on there but I figured
>>> since im communicating with these patches I might as well bring you up
>>> to speed and supermario has been great help throughout me trying to
>>> get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB5 /
>>> USB4v2 dock!
>>
>> Adding Mario as well. That strongly sounds like you crashed the SMU which would also explain the failed MODE1 reset.
>>
>> But all of that are only symptoms. Question is what is actually going on here? e.g. what is the root cause?
> 
> We don't spend a lot of time in recovery scenarios for when 💩 hits the fan.  I think in addition to finding and fixing the real root cause having a reproducible workload to cause the crash is a good opportunity to try to put in place better recovery too.
> 
> Generally speaking I like the idea of if a mode1 reset fails to do a harder reset.  At least in the path that we have GPU recovery (amdgpu.gpu_recovery module parameter) set, adding a fallback case to do a full device reset makes sense to me.

Well I just realized that Pierre-Eric is already working on that and I've forgotten to add him to the mail thread.

But the general idea is that when you can't recover the GPU that the driver send a WEDGE udev event noting that a GPU recovery didn't worked and it basically needs a bus reset.

> I think the placement is wrong though.  amdgpu_device_mode1_reset() has a bunch of callers, and if you end up with a mode1 reset doing a full reset that might be a surprise to those callers.
> 
> So I think a more logical place to put this would be explicitly in the GPU recovery path (amdgpu_device_gpu_recover).  Maybe as part of the mode1 reset failure you can:
> 
> set_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> 
> And then the GPU recovery path can jump right into a full reset?  Not sure if that jives with your stack trace though.

The MODE1 reset is already the full reset in this case.

> Furthermore; even though you reproduced this on Thunderbolt; I have no reason to believe it's specific to thunderbolt.  An SMU crash can happen in any hardware.  We may as well try full reset for recovery for any hardware.

Yeah agree, we need some more general WEDGE event handling. E.g. basically what Pierre-Eric is already working on.

Regards,
Christian.

> 
>>
>>>
>>> It seems to be finally working with bar resizing after my kernel
>>> patch. Which allows you to safely release a empty switch bridge at the
>>> device end.
>>> Then it rebuilds it afterwords with the increased bar. This was done
>>> on Kernel 7.0-rc7 i believe it is and latest changes from pci/resource
>>> branch with my patch here.
>>>
>>> https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u
>>
>> Where is the MMIO register BAR before and after the rebuild?
>>
>> Regards,
>> Christian.
>>
>>>
>>> Thank you!
>>>
>>> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
>>> ---
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 ++++++++++++++++++++++
>>> 1 file changed, 40 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 31a60173c..91d01d538 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>>> /* ensure no_hw_access is updated before we access hw */
>>> smp_mb();
>>> + /*
>>> + * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe
>>> + * endpoint but the TB tunnel stays up unaware. Detect the
>>> + * dead link and attempt recovery by resetting parent bridges
>>> + * to retrain the physical PCIe link inside the dock.
>>> + */
>>> + if (!pci_device_is_present(adev->pdev) &&
>>> + pci_is_thunderbolt_attached(adev->pdev)) {
>>> + struct pci_dev *bridge;
>>> + bool recovered = false;
>>> +
>>> + dev_info(adev->dev,
>>> + "PCIe link lost after mode1 reset, attempting Thunderbolt recovery\n");
>>> +
>>> + bridge = pci_upstream_bridge(adev->pdev);
>>> + while (bridge && !pci_is_root_bus(bridge->bus)) {
>>> + dev_info(adev->dev,
>>> + "attempting link recovery via %s\n",
>>> + pci_name(bridge));
>>> + pci_bridge_secondary_bus_reset(bridge);
>>> + msleep(100);
>>> + if (pci_device_is_present(adev->pdev)) {
>>> + recovered = true;
>>> + break;
>>> + }
>>> + bridge = pci_upstream_bridge(bridge);
>>> + }
>>> +
>>> + if (!recovered) {
>>> + dev_err(adev->dev,
>>> + "Thunderbolt PCIe link recovery failed\n");
>>> + ret = -ENODEV;
>>> + goto mode1_reset_failed;
>>> + }
>>> +
>>> + dev_info(adev->dev,
>>> + "Thunderbolt PCIe link recovered via %s\n",
>>> + pci_name(bridge));
>>> + }
>>> +
>>> amdgpu_device_load_pci_state(adev->pdev);
>>> ret = amdgpu_psp_wait_for_bootloader(adev);
>>> if (ret)
>>> -- 
>>> 2.51.0
>>
> 

