Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4C3F364AB
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 18:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4781310E858;
	Thu,  9 Apr 2026 18:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AfngK5DF";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011052.outbound.protection.outlook.com
 [40.93.194.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7DE810E858
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 18:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byIdLs1ZfOKkQQDiC+1AsUHDM1HF726wpjLBtZmYXIAGaRrTL+yKazyfpFPleZuffw6nj5u3oLxAjOSNyBF6U+PPZSnbQGf6ZglqvCUrG1tyhAodJij8O9SUGRmhlGbtwfNEL2yxtT0dT5fNzA4kR3VBwN3awvQ8SCbdXB3Xns1Q/o1tjys2SvHqRXEVXsRWLgR7x099k8XQp4JSxnJnrG2zPsovBJ7U/vp2Y0+kChGq2Z5S+5YutjXvqG0o5fHquWWlJV/F8RGuiu8gd4UJdVpPy8KqnyUqyUZbUcvUX8RQHGzyIH98QxfcSppKNOpaugxApTXtga54GAwOTuNcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/tjHC5dKHgouhBAxstIjWfX3JraI4ggHkuEq/W/QtM=;
 b=aTjGXJyYTxLo3v7ky/GqCNH2dgO8c4rydEo+xxGx2U6xQxmDNi1NnFzPlsAR27rx8eZzajCnPPzru6d1zlGJ7cnUtuotwnZt581NnTgmWKMvbl0IYp+URpGGNP42Tm9O+rZlftk2M9AdEJiD0RVhJLBIwUY8akdn3mE/ioAoCgN8eM07p96GQHv+ZXPAoLiJb4f+nOPATgHp+dQ997JQGG4H++ElvA0D639yZMaHl0tRFeJIXsEDbr+HYP9ywQsVWbWd49Dhj3OKhE0Wl9LHvxbFc1/hKbWt4bhNXPWafrD4IV0pRtsKXh/ykkPTxrMWXlKzL5RJEuXd9mEbubA6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/tjHC5dKHgouhBAxstIjWfX3JraI4ggHkuEq/W/QtM=;
 b=AfngK5DFy7VGzqSc6wp36y+5E5tMtzxD8cpSZIZ9obsrSkb7lZd1zJuF3pyt97UAqv+FwpOiyGzF9uHVqcCuyFHSkTvWm7jIej0OC3QwE/ibnduWWKoXEB3BytAIR0jAh1wsX7wW/S+holnHFWGcc5LM4KsbmMVsTJHgNsc4sE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 18:12:25 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 18:12:25 +0000
Message-ID: <47306de6-cbf6-4b2d-847e-d1e5d933516d@amd.com>
Date: Thu, 9 Apr 2026 13:12:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: recover Thunderbolt PCIe link after MODE1 GPU
 reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Geramy Loveless <gloveless@jqluv.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
 <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0099.namprd06.prod.outlook.com
 (2603:10b6:5:336::32) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 614936d5-ec38-4298-b84b-08de96638d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: +IerLGFnWovbfPisW1Ev/0JsUvKM17+gG2ZGSfNvhxK27Iuvs7ymE7Ngba9URDsnMBR2Sn0QVtNWTvhDdkjWZHPDyzG7Bx9Ujk1WFQHYRnAsG+K0Mumhq+XKF2mNvp8rPupkkSCIz9tlBQOH6jGqxOum2rq0dFZ0E8WFhokFvPphiPJC6OOeaFiHmii/VDCyWKrmgaxh0VWE+irSSh458OWAkO/mtNNa38+H3V/n6D53jivOgTfX8DRHNGFdzLovUdBdg6FOy8RgaqhhGOmHGi/mTCwdJFmtvVEqzLLKMJR7HAcejcd1vPFfaQhmDQ+NGvzy1XYyaIKm6BlNU0TrYJB1X2rgr3J6W/WDjmhb7kw8HSJkyhf799CKfvESwSx3rDsjzJ73s7wsnMH7SSpwvj1Kl+bwx6kwiYWV9zq/IXsgj5gVEGYL1piGqVTI5woweRkJOohuIZZbjyPMCxKTYlnf1DBBXkPz5hb7fLCxwbOdYqUufczGJYbjGNJHvluszClhASely9NYJFQkiOntGTn97QyKgQKgHFWxVPGR8Xh3l/6iwu0zQE8aMYRJwn26TlKOqmJjQ/BeRSJ7HZHQFYL00NTAOeSyqHOhidEzFgWFwRCxeHyMWUg2Uy+g3KgybcSba3ByEOKG6zAFW1v3N+6TXju5qlyCXS6cLvjMYugLta8hfJ2+NplLmSggJy8a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGcyc1RSY1dRcjc3Ukp1dFVWaEE3d2h5RXNuSDYzUVEyRWtHWVhrYmwvbElP?=
 =?utf-8?B?bW1rT1JLUTBsVFBFUWJOOEh1WGRJZ0RlZWlFV2RtZ2svVWV5a1FNSmNiWUZx?=
 =?utf-8?B?R2VHZjhxRVl2S1NwZFIvZXhjbE43NjJzcC9MVmRVRDB1Tmtldmd5SWYzTEdv?=
 =?utf-8?B?MjdNdHpaQXhRZi9aMHNmM0xFb3Q3OUdVTVBMNGxrSG9xVW1NWXZFSEJSRE9w?=
 =?utf-8?B?RHd4K0hlRHl0c1dwNVNwZmpNdG00amIwbVJqUDFTWTFiYktUc0FWQlF3U29W?=
 =?utf-8?B?RHBxQTdCeHhGenV0akRScEN4eHZDdTBmcGlWK0ZXaDlTMnNmTGcxTFZ3YmRq?=
 =?utf-8?B?cU9WV0NtQnh3TTRWa2RPRGI0Rkx6VW1TV3NaUzZGNXdHNG0wMXJBeEpKdGh0?=
 =?utf-8?B?V3JqOGpSUGc1SEpvbjlERit1Q3Y4MzdtQmpPU0pQUVFIU2pRNW5HY2ZMTHRG?=
 =?utf-8?B?dnloL2MrV2hSeU9ScS9tcEtQV042TWdWTnBMNStzWFJLdU5DTFZnOVAvTkF5?=
 =?utf-8?B?NjF4YWpXY0V6ODNQRnQyMXNaaVhrSlNzUHlra1NwaEVlQmVHWEEyV1FuaTFD?=
 =?utf-8?B?bWZHbElQbVFZbHRkbUpiYTB5ZjVKVHNPMW8vWmJGQkc5UEZZYmtxRk5Xd1E1?=
 =?utf-8?B?aUJiUEp1UE00czd6ZkJBV0s5bDM1SCtjMWhJM1V3SjZGRzc1RUxXU3dhWXVh?=
 =?utf-8?B?dUhSMUJ2ajZsK09TWGlWMGFOTncvR0wyZTRkK0dWUHhheEtIanlYaWJxNmlo?=
 =?utf-8?B?NDhrWGk1MHFTOEJlZUo1bWNzYlg5c0xwLzJ2a1pmZjl0NGNueGpIMCtYQU9a?=
 =?utf-8?B?cFhJcHZvMHlPeEtITlo0Q200QVhxaTdjcDhUelJMSndtYjE4VlUvMWZZbGww?=
 =?utf-8?B?UWF1SWoxZ0k2Vk5MeElUNzNPUUVGMnRuSjdVMzk3S3JsdG56L0w5cC9mUk01?=
 =?utf-8?B?ZGk0Vjh0NDRPS1JCbmxqdDA4M0h0VXhOa0I1alNMSi9sTjhxK1FrcEtuWEYr?=
 =?utf-8?B?VEQ2VzE1eGIxeVViVXdRSGZLaHhFM2dUY0hLTFFkbmRtWEE1ZzBkQ3RKRG9P?=
 =?utf-8?B?QmxpSlY0bENSS3VMRXhFWlNNZVpwZk05QVd4TFpjcmF1c0Q0KzFnNm1seTJM?=
 =?utf-8?B?aUNFVnA2bXk5SS9aVncyaHBCTkRmdGdYelVvWFdSbm9NOUEydTJkb0ptUEhW?=
 =?utf-8?B?V2RaTW9TdWN1WTlnU2t1ME96VFQyQTczTFY5ODBzK21IRTJtODh1eVJhWStH?=
 =?utf-8?B?c1lMZFBac2g0bDZEb1NOQ1V0UDhtbGxUdHNoR3F1R2d1azFrWEcyaHVZV1hM?=
 =?utf-8?B?dVBMYTNEcmc5MVorOEtZdE5hSDM1Y0RVWkcyUGhLZkdLaFkrK2Y0OFY4S0x6?=
 =?utf-8?B?ZGphZVk2cnhrZzRwNkc3UWE4WE9Kcng1cUdUWFBoTitiYlJpenpFYm9YUTJm?=
 =?utf-8?B?aGNvL3A5Y00rMjcyWngraVoveU52aE82djBpUGhJZUp4bEJpZ1piUjZ5UllO?=
 =?utf-8?B?SitVNFhpQzdMNGt3OGNndXVHNTh3WmVEa282TWJsQXhJSExUL2svWHA1cDZa?=
 =?utf-8?B?OXZqN2dqd2pkbHBnRFlGekk5NFNSNkNpUWFRcnNIOWloblV5SDhhSGFDZW4v?=
 =?utf-8?B?VTBKZlFtN3pUVW9yK2JxazJPeTYzaUNPQ0Q1UFRCb3kzbGkvQ0dyRHQ2WjJQ?=
 =?utf-8?B?OEJhUk9hSFZpZHRQUWNhcUVRMWszS0pUTEhKb1dDL253bHVXSDM0S1crNVhI?=
 =?utf-8?B?NSsrWlVqQVdWTWk2SkRrSXNKR09wVTZrRzZuMXJiTktHQXpoT0tadlBnRmw1?=
 =?utf-8?B?WXhlNC82b051aEt1R0dTZ1plaTNjZXpIUlpLbG5BV3BtMGFITDNQeW9xTDJE?=
 =?utf-8?B?ekdRNDMyK1EzUDh4cWQxR2xVRnB2WUE3ZXM1RmtzRmplUHJ6MVJXWm0ySWV4?=
 =?utf-8?B?Qk5aTlRiV0JibVo0ZjZodys2a3MrK1kyQzk5M3VUaHYzYTdRc0pYRWRJTzZk?=
 =?utf-8?B?aTJjbVBHOTBtTk5RQkVTbDEramVFdlp1QlB1KzZ2dlNxcTcxTm1oNVpvM0x5?=
 =?utf-8?B?TFcxaHNDeDUyTENxdXBXSFZyTjZQS3JFeEJKcE9BVmRmRW9ITXRqUUR1YWdx?=
 =?utf-8?B?U1F3N1I2SXc3MnZrdTJJVUVGM2hWcXVaY1lVVU1hRlM3aTdzMER6Z3l3N3o3?=
 =?utf-8?B?R3FXOEI0R3FZRUswZmgwRCtadHlEMERXMFJHU1RMbmZjRlozeWxEMEhrRkFP?=
 =?utf-8?B?eFZtL2pVYTFQM1NtSG1UM2JiTGhQWldabkNuaHFkVDBmbzZOV1hCRS91cDNu?=
 =?utf-8?B?aTZydzFhWS93WVZabnNMUmo5L0FFVkp4a0oyVXVKY3RQNkxkNEt1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614936d5-ec38-4298-b84b-08de96638d91
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:12:25.5986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikOWUW4nDZAgAEmCIGdTaHtVN++PJZ/I+KBV8b/ElNVbUDeLv86zFXj8fqSsolhUU2Xi9sGAkDih4M3y658Hvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
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



On 4/9/26 06:42, Christian König wrote:
> On 4/9/26 02:05, Geramy Loveless wrote:
>> When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 on
>> Thunderbolt the TB driver receives no notification and the tunnel
>> stays up while the endpoint is unreachable.
> 
> IIRC a MODE1 reset should keep the bus active and so the endpoint should still be reachable.
> 
>> All subsequent PCIe
>> reads return 0xFFFFFFFF and MES firmware cannot reinitialize,
>> triggering an infinite reset loop that hangs the system.
> 
> That sounds more like the MODE1 reset failed.
> 
>> After MODE1 reset completes, check whether the PCIe endpoint is still
>> reachable using pci_device_is_present(). If the device is behind
>> Thunderbolt and the link is dead, walk up parent bridges calling
>> pci_bridge_secondary_bus_reset() to retrain the physical PCIe link
>> inside the dock.
> 
> Well that is then a bus reset.
> 
> I mean that is a reasonable mitigation when a MODE1 reset failed, but the question is rather why does the MODE1 reset fails in the first place?
> 
>> If recovery fails, return -ENODEV to prevent the
>> reset retry loop.
>>
>> This also causes the GPU fan to be at 100% and basically when it
>> happens and you are not there, you now have a GPU with fan at 100% and
>> cant reset it.
>> I wanted to notate some other things I am finding sometimes before
>> this adventure of patches to the kernel and amdgpu driver.
>> Sometimes a crash could happen in the drive and then the GPU fan speed
>> hits 100% and the air is hot coming out without any workload, other
>> times
>> I have seen it have barely any fan speed at all and heat up more than
>> it should at the fan level its curently operating at. These are things
>> I have seen with this gpu in a TB5 dock with the driver and
>> instability. I'm not sure exactly whats going on there but I figured
>> since im communicating with these patches I might as well bring you up
>> to speed and supermario has been great help throughout me trying to
>> get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB5 /
>> USB4v2 dock!
> 
> Adding Mario as well. That strongly sounds like you crashed the SMU which would also explain the failed MODE1 reset.
> 
> But all of that are only symptoms. Question is what is actually going on here? e.g. what is the root cause?

We don't spend a lot of time in recovery scenarios for when 💩 hits the 
fan.  I think in addition to finding and fixing the real root cause 
having a reproducible workload to cause the crash is a good opportunity 
to try to put in place better recovery too.

Generally speaking I like the idea of if a mode1 reset fails to do a 
harder reset.  At least in the path that we have GPU recovery 
(amdgpu.gpu_recovery module parameter) set, adding a fallback case to do 
a full device reset makes sense to me.

I think the placement is wrong though.  amdgpu_device_mode1_reset() has 
a bunch of callers, and if you end up with a mode1 reset doing a full 
reset that might be a surprise to those callers.

So I think a more logical place to put this would be explicitly in the 
GPU recovery path (amdgpu_device_gpu_recover).  Maybe as part of the 
mode1 reset failure you can:

set_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);

And then the GPU recovery path can jump right into a full reset?  Not 
sure if that jives with your stack trace though.

Furthermore; even though you reproduced this on Thunderbolt; I have no 
reason to believe it's specific to thunderbolt.  An SMU crash can happen 
in any hardware.  We may as well try full reset for recovery for any 
hardware.

> 
>>
>> It seems to be finally working with bar resizing after my kernel
>> patch. Which allows you to safely release a empty switch bridge at the
>> device end.
>> Then it rebuilds it afterwords with the increased bar. This was done
>> on Kernel 7.0-rc7 i believe it is and latest changes from pci/resource
>> branch with my patch here.
>>
>> https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u
> 
> Where is the MMIO register BAR before and after the rebuild?
> 
> Regards,
> Christian.
> 
>>
>> Thank you!
>>
>> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 ++++++++++++++++++++++
>> 1 file changed, 40 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 31a60173c..91d01d538 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>> /* ensure no_hw_access is updated before we access hw */
>> smp_mb();
>> + /*
>> + * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe
>> + * endpoint but the TB tunnel stays up unaware. Detect the
>> + * dead link and attempt recovery by resetting parent bridges
>> + * to retrain the physical PCIe link inside the dock.
>> + */
>> + if (!pci_device_is_present(adev->pdev) &&
>> + pci_is_thunderbolt_attached(adev->pdev)) {
>> + struct pci_dev *bridge;
>> + bool recovered = false;
>> +
>> + dev_info(adev->dev,
>> + "PCIe link lost after mode1 reset, attempting Thunderbolt recovery\n");
>> +
>> + bridge = pci_upstream_bridge(adev->pdev);
>> + while (bridge && !pci_is_root_bus(bridge->bus)) {
>> + dev_info(adev->dev,
>> + "attempting link recovery via %s\n",
>> + pci_name(bridge));
>> + pci_bridge_secondary_bus_reset(bridge);
>> + msleep(100);
>> + if (pci_device_is_present(adev->pdev)) {
>> + recovered = true;
>> + break;
>> + }
>> + bridge = pci_upstream_bridge(bridge);
>> + }
>> +
>> + if (!recovered) {
>> + dev_err(adev->dev,
>> + "Thunderbolt PCIe link recovery failed\n");
>> + ret = -ENODEV;
>> + goto mode1_reset_failed;
>> + }
>> +
>> + dev_info(adev->dev,
>> + "Thunderbolt PCIe link recovered via %s\n",
>> + pci_name(bridge));
>> + }
>> +
>> amdgpu_device_load_pci_state(adev->pdev);
>> ret = amdgpu_psp_wait_for_bootloader(adev);
>> if (ret)
>> --
>> 2.51.0
> 

