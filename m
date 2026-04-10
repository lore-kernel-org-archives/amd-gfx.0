Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA50AF44840
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 11:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9271310E937;
	Fri, 10 Apr 2026 11:25:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fPG3B7r+";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E459710E937
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 11:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Omz9i0X611+R9OPUTQDUXfxeig7HJnYmBRjdSArLC8M/IFNwmWEPpIyJKfbKpwphAliJgwxQsMIPhmU/7ZFld1FO62ITNx23YfxqgMr4tp6exIpW4Sh/XQb4IJ33jmKVuFbMypB/i35tpqDyvl2FE+NJ41HLggp/5vW6QFDYFscqlv5FlW0EW5CR6X9ZdhkOa7UIeShMVpIe19RwQ8+QPiGZnfAq4huBXvQVHToVk8JeCpaK4dSgfaZY8Xri51b6SSbnKp6MFswU+3XjtQMSiT5f/qCCjD5/RlHoghC0ePtz1k6cSkPOKfDO43iAHkoLMl5Oq/7mzVFbt02sgAhILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOFAEMSb/AAmDRdJ79hYI+rufUZviDAxokD6PSAx9EA=;
 b=WSXBYfc4wxE+qpDtWmHo/haQNrd3C3xZeqVO8U4GQh0vDbOBRJPJBOPTfMwpjEW5O15pnm/3zcahW9wB8MLD4QK42GNyq5xqpBc1xLnb6ZFrdFG6udwmutHbrgJOukmiycOp4xZbh3DN3YEoGnQWFvS4CnWEjGstpMwLvh5dU2xaKBnaM6zM5ZzPF2narnxwkSJ0dAc2yJIqejm94bhBQD6mlx0/sCdWv0hs2xfMkEhk8XfSKAzwtOdmhQCdfnnMomyJ4+hUW/84PS2hDRWYJLIUw0LFvTBO024zF2Cvjea9P2PZ78INFP18JX7yZR7liiYRBai7wHKfiyR1r2HBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOFAEMSb/AAmDRdJ79hYI+rufUZviDAxokD6PSAx9EA=;
 b=fPG3B7r+e+OsOwd86ElNhTU/hEy1yLPZY+jYRQnqQlLjigtQWLJLkZP6C2wuJMgavHBunPTWrOI/n05Bq8p761jytEdSNiWmanuHiJpd7y7QF3Ve8yvL4nYRP1c8O6u5sSpmrRWD5JSXI4VgaVr4r2COyzOQQpaxQ1zx3lnbE3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Fri, 10 Apr
 2026 11:25:37 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 11:25:37 +0000
Message-ID: <053100e2-fe23-4b9b-9b20-be5f0a49c22d@amd.com>
Date: Fri, 10 Apr 2026 16:55:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: recover Thunderbolt PCIe link after MODE1 GPU
 reset
To: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Geramy Loveless <gloveless@jqluv.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
 <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
 <47306de6-cbf6-4b2d-847e-d1e5d933516d@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <47306de6-cbf6-4b2d-847e-d1e5d933516d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0057.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b47167-06b3-46db-ab7f-08de96f3e31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: ymsqn3zlDW0xDyVddytFTaCHeEn2qQJJi9HFCtLiF4hgM1/MEDwm6q4YoeTQzNva+BKd0/OliEb6t3LuBUljGhzsbk7IsSW7gkgslhWJEW9paeWIQXAH/id4zflwnTfgOo6Muf4+tb3+FndeA9+MODOTUc5tU1LWJH38LpstRNkJaaXq8nlAeLeWVllHfiOd5pkBeMOtrlXHiYibP6O6DVOPt7fMes0prbhNiT2oByXmMnrBP8idRCjSomOKp4Ac5EH2Sj4kV4LHJ9rnbCt6oAR5tUqHcujJmBDiJy0C80BaagXNY9+QSDMHQvkbWDlB4kDOhDZ2NXCdA6BCze2OJ2V7FJv0oIoMPGtOfUWMKrPzIeLOQV0JnVc8hrbPSrJM+Av2PfqRaMk4/oeL+XHXJpmyvgmm1VMd9uW0jmSInLgTCgE2YyI1ScyQFZ0y/r+q3+G6tMZhwaHu5uiaewuxLzDAo3wkLOdh6IYi6MTSF6i95zIF5rCOcre7CPTzMq4XqH6V7rimuFILUT6j+FBmzkhZ7F6c0Nu/R83tbV+j5KDlymEInjrfueaWD0BSl0fxkdPA4+BI2SJhbhSl9BjzGEysdwAqWLnGsShz80VrJ3kkYic+WyCKvSLPPgEoS2R4iBcLAXQ3iAXNkzcwuQMlgIS0A1rEw8p8TesNutOqfdqsOcDaGvaZ7TFIkAAaqZf6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGdaMWJvdFFlTVE4UmYwSkhIRlRRNTh3bExYd1RoNUNNZnBLUGVGN1RlVC9M?=
 =?utf-8?B?TEdOMkhZRlowMGtuUU5rZUN0TCtDeWpuWlpJVFdTTkJNYlU2M2tVaEw0VENO?=
 =?utf-8?B?cjNUZFVUY0hmVzhEU2I3QVZNbDg1OFlFaXgyc1JqRWMyWFhYRHU4RFZJVXky?=
 =?utf-8?B?MDZHYTQ0OXBnc3pRUEpSMk1XUzZxaFd1ZzloSlhvV3lKZVRvdkJ4OWpRYUI0?=
 =?utf-8?B?RGlUS3FJUk9Sb3E2VGRIRHFlaXIweHdIeDBBcmJaZ1hMd1N6L2hyam5DRUln?=
 =?utf-8?B?NU9aVXIyUVZnNkhQWjhicWdFRXFHWS91T0lURng5MDRIWldmSERiVlhpNDNl?=
 =?utf-8?B?UU5LT1FEQzh1Ymo0NnY5Q1ZVZWI3L0grbVNZdFlacGg0QzlBS3dPSXFzSWQ5?=
 =?utf-8?B?aGpsVXN3Z0dIYlEyYlVvQUg5cWtGdnNDL2VDZ0JRTHN0bEVPdVVLTyt1dkE0?=
 =?utf-8?B?dUVLVEFDTVFIWFh0amZEdnhBOG1WTWJyT0tpOWQyZi95dDd1N1kzTWtFcXRB?=
 =?utf-8?B?QVRIcHBXZFUxL3dFcm1JYVliTmVuOFpBNHhtai93NXROemdrWDdVQkhDakVR?=
 =?utf-8?B?ZGRrSVNYUS9XM2JGSUpOQVQvNE9LckF1S0R4NVQ4Z2xuZVJsajJJdjVRWmpK?=
 =?utf-8?B?YWdqc09qT1QzT0Q0aG55K28rYVV1VC8rVXNnT2dzNkM4REtPNDN0SkMzcEZ5?=
 =?utf-8?B?QnIzQytTQWNRQndjZC91byszUUR6TmRFOUV5aWJXT2ZoT1V0dDlpWWhGdDdk?=
 =?utf-8?B?NGxGZS9wdVZuMTk4WHpYemNnZXBzUjRSaEM2RFdLZzhCeTBIYnVlaWdta2ZF?=
 =?utf-8?B?aGl5MnNPTGhPQ3VEdUdkNzhlR01Pc251cXM1d2dBWUxDV0ZjRVl5bHpoaGtl?=
 =?utf-8?B?WWdLNXptR2JQRjVFbCtpcWhHZjR5enhzY0QrTkowNDg5Ykl2dU1OOUI2d1Zl?=
 =?utf-8?B?SmRlRUNjUWRIYnZjem1MbVllZWdEdms3OW5zME50TWhEbmZsTmVYa1ZnWFd2?=
 =?utf-8?B?WUF4Sll2V1BEdGlMYkE3SUtCbUhLeVc3cEpSbCtFT2h3eUNPYU1QNGw1U05n?=
 =?utf-8?B?OWxWb2VKd3pEeGllVGZOY1F6VnBDbHliWmNIOGQ4d2lLUWlJQlNtZUJPeEFo?=
 =?utf-8?B?TzA1TW5ibjF0NFRXNUgrRHF4SGlkSFdTVDJxN3cyeXRFem1ONmpzMWNIMWZO?=
 =?utf-8?B?eFZGcEg5dGZkY3BLMGpING50OXZMNGdxUm1yL0wycjIyTVBpZlFRSEZxS1V5?=
 =?utf-8?B?WDZZbUF1QVRiOWZ4NjNUNUprWTlwK0lYTDA2VGEzSVIrNk9nV2YrVzMwSzg4?=
 =?utf-8?B?a2JZZXdDYlZxVjFMcWNMTlBqOGlzaURpMUJKMExxZllSQUI4YnpVa3JERG5B?=
 =?utf-8?B?SVMreitSb1RIRnFDODRtMnd2Mk9RSEJ2Zm9lMWNaTE9rdWxUODhTSWx1ZDJT?=
 =?utf-8?B?Sm92NCt1M3poWElWUm1YSWNaWFgvNlBVNzE0Q080cHBjLzNYNWhnYnQ3dzhC?=
 =?utf-8?B?V2p6dGk3SGN3dzVOTFlKMVl1N2RVWThjRzZucFBEd3c3OThMRWtXZ2xRMmxX?=
 =?utf-8?B?LzgvRkxubyt0Uk9XRXdkcmRNMW5LT20yUlRhM0YzWUJNU08wY2FOK1g0WXMr?=
 =?utf-8?B?U2JyNVVVZ0FLZHFCWEk0amlzOEttOWovTUMyZS8vK2NhbHhOZ0RqV1pXUzBO?=
 =?utf-8?B?THZxZFIzNTVkdHFJeVpuVEpKQTNMWkdNbkhtam0yVzNsdlNDcE1CRUU5YW1G?=
 =?utf-8?B?RllrRWxXSkgwV1NoQUhHMG9IeUpRT1Y5MzBBLzNHbGlCTGJva0dzVFNGSzU1?=
 =?utf-8?B?RE5JYjZiZFJ6dVR5clYwZVhIc1kxUnhRQW5ZWFB4b3F3U3RVRnBJV05kVkN2?=
 =?utf-8?B?S2NVSitkUityeUJ1cnM5d2lwQTBXMm0rMXBTNmNiT1U4bWwxV2VxeWpaeW1X?=
 =?utf-8?B?bnpqVTZuU3doQk1Dd1o5WWp0WlZHVUVlazhTaTNTV3RpR1ozK09RN25Eb3Bo?=
 =?utf-8?B?NXorYjZIUndWU1N3UTU5U21yYVg0YThJMmxhSllOOWVldmVGa202Ry83RG9o?=
 =?utf-8?B?SUVub2p5THBrdTNWYVE3SGF5TnR6UzNvdFlodUJSU05hWGdDQnUvVTRUSk5u?=
 =?utf-8?B?TnQwZ1J0REZlVCtnNjNIWVZwZmV6Qm95ckpPZUtNWmVvcFkyN1pDalRjbGpl?=
 =?utf-8?B?SllVL1U1MlBWWThVK2ZhQVh0M0RNdlk0dU5YWDloVDNvVEl1a0V0VGQ1Z0Mx?=
 =?utf-8?B?Z1I1UWVHSmpvamlQZDVESE1wQTYwSFlGRGlJbUQxYkFaemRrV3kvS25yVFdO?=
 =?utf-8?B?N3lmbElrejVYV2JKV1liaFViWHhQWUF6TmVBNmdRV0FQek85MEVPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b47167-06b3-46db-ab7f-08de96f3e31c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:25:36.8086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhVx+eiiwkTZbZFFl2eVm03uvxD5KLdp2wbDpQFRfaDu86E9lGCpLvuBx4r4lRhm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
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



On 09-Apr-26 11:42 PM, Mario Limonciello wrote:
> 
> 
> On 4/9/26 06:42, Christian König wrote:
>> On 4/9/26 02:05, Geramy Loveless wrote:
>>> When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 on
>>> Thunderbolt the TB driver receives no notification and the tunnel
>>> stays up while the endpoint is unreachable.
>>
>> IIRC a MODE1 reset should keep the bus active and so the endpoint 
>> should still be reachable.
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
>> I mean that is a reasonable mitigation when a MODE1 reset failed, but 
>> the question is rather why does the MODE1 reset fails in the first place?
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
>> Adding Mario as well. That strongly sounds like you crashed the SMU 
>> which would also explain the failed MODE1 reset.
>>
>> But all of that are only symptoms. Question is what is actually going 
>> on here? e.g. what is the root cause?
> 
> We don't spend a lot of time in recovery scenarios for when 💩 hits the 
> fan.  I think in addition to finding and fixing the real root cause 
> having a reproducible workload to cause the crash is a good opportunity 
> to try to put in place better recovery too.
> 
> Generally speaking I like the idea of if a mode1 reset fails to do a 
> harder reset.  At least in the path that we have GPU recovery 
> (amdgpu.gpu_recovery module parameter) set, adding a fallback case to do 
> a full device reset makes sense to me.
> 
> I think the placement is wrong though.  amdgpu_device_mode1_reset() has 
> a bunch of callers, and if you end up with a mode1 reset doing a full 
> reset that might be a surprise to those callers.
> 
> So I think a more logical place to put this would be explicitly in the 
> GPU recovery path (amdgpu_device_gpu_recover).  Maybe as part of the 
> mode1 reset failure you can:
> 
> set_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> 
> And then the GPU recovery path can jump right into a full reset?  Not 
> sure if that jives with your stack trace though.
> 
> Furthermore; even though you reproduced this on Thunderbolt; I have no 
> reason to believe it's specific to thunderbolt.  An SMU crash can happen 
> in any hardware.  We may as well try full reset for recovery for any 
> hardware.

FWIW, if SMU crashes then SBR also shouldn't work since SBR handling 
needs some firmware support as well.

A kernel module triggering chain-reset by going one level up and 
resetting all devices under the bridge (in a while loop) also doesn't 
look like an acceptable solution.

Thanks,
Lijo

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
>>> https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF- 
>>> tmThxOvk2XUDpEzw@mail.gmail.com/T/#u
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
>>> @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct 
>>> amdgpu_device *adev)
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
>>> + "PCIe link lost after mode1 reset, attempting Thunderbolt 
>>> recovery\n");
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

