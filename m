Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B835EA3C59
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 13:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF70C10E7C3;
	Thu,  9 Apr 2026 13:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0NYj6i4A";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0993D10E7F9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 13:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeIH6916daF0GXUocKGhZGPOYeiOcNDLAMuE3Snh2ngMi4Wv4c3JdXmYZq5jJ5wgPo8z+0BCrKyL0KMP0J+QSybBo417VCfdZi2jkssdn3D4HVWAGlwbfygWCr6fv5QxSjghsiRvgL+TWsC1a9yBKZHjJWtGYQKJGmJU0aGvg46chPdb7k/4u5qpqQXkslc5uahTm9apcbtuVjAAdGpraaUYHuPmBTl0FcThNyQTp2Y7n2Kbh9NEJS79NKCgVTCCl6Do42f/JeH4FHGK7nHE8KADwTT4D71yWU2z2cjo2RUbojrJismdoXGjqwRBi5ICDSW+hSBmTmvX5kMzMTfQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUoj26TkC9GdZS0OPFMfYdkg7O5FeiUL9CZtViZzn5Y=;
 b=cf0dpsjVcef80RCnAca2HTU+qPo5DPzV8Ybg5uQ9jLh1yJjOSHVmYWvki5q4MzSTHrIt6Y+iAu4Sb8POALtrOFzUiU2WjcydDzKPayLH7qUh1LAIdqz3KUI5lQSzhVIto6Hg4rr2Oe8Hu5WrOlxPxGm+DgZ6QM3o9MDg1n5IjTsqHN1kt836sFAzOGLz9yOoSCa9PHuJi+eMy9CZgmRVbtagNXZ1S87yE6fsi3oc5GYF7Otc+yZvN0tsjswetSpudF2ZDqyOhy170zAk10qyT6/uRtfPBywAKQ2Lqbq2OAMaf3uu9XYatxGhsDxe9o+bhuhkUcB1ciZ0OyHU8XYLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUoj26TkC9GdZS0OPFMfYdkg7O5FeiUL9CZtViZzn5Y=;
 b=0NYj6i4A2maYdQkI3OYVtA7y4aVTsqytiSMxSUJ+8LNccF0LBGgerlVF8uqG4OSW1Z/vlYu5UhruVc58STPdX2NZ/Ty+NnbsXEOahq2gadNBMI8qWtVBvIEvb0YyijMK7IlsTxrVeadmb+WFU+bKV1oYLRpk04E5kGyLh4lQoWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 13:45:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 13:45:31 +0000
Message-ID: <e8df8591-9014-4da7-b499-2d0d028ffc76@amd.com>
Date: Thu, 9 Apr 2026 15:45:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: recover Thunderbolt PCIe link after MODE1 GPU
 reset
To: Geramy Loveless <gloveless@jqluv.com>
Cc: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>, alexander.deucher@amd.com
References: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
 <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
 <CAGpo2mcLFMrkduCx1MuQnR3EZUxtEo+jT8PAXGgXbGDm2_1Now@mail.gmail.com>
 <b92192ad-0a49-4234-927d-71e2c5441947@amd.com>
 <CAGpo2mdWGmDFVh_398=mBM4Zgt2fWXyBtYwFy4nH5VbxxbAmdQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAGpo2mdWGmDFVh_398=mBM4Zgt2fWXyBtYwFy4nH5VbxxbAmdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:256::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: e7215144-971b-42bc-0d4c-08de963e440f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: MOs8JMpj1o9s25Rswcz2oDRg9WwN03aXL3OsxIikNqmbh/1hZ0lmczodSnr6+QW6Aq/BSeLfTAPxBDHwrRgAyk/rJcsplkWCTEiG1BJDpKZyZvjexeviryKPCe4qW+MLm7Eb8GsS1DPjDEfga8pU+hPfu3/6eSmXP8Ah7WlLETQZPEXbGrbO9gaQOZ8znFQ71bghlW251aX4f/MMlSajEaYoYSA52kuVJyb0/oNGDLFG2YtioV5GPWBz8w3Sd0pWGdS+dw43SxvH0FDTI6H8LSdEmKTIkZB1UpSICd5bonx9JZlFD1Vabdu9hQG5H5DIvH0N2HF+3oO9pDHTnRLtg8jkygs4Ekhwc0KsLGPd2d8VWaTc6Xy9Y0Tt82ND5H02JMDlzqx8r5rCdx9pmsNX8lO4zYEwELKLknj7k+u7fuAq9grDkaZyYy9mJHsHcF6HyovRh0J1r9I53n1DGFwoqavdd6Sk2Kfi3fTaW1D/4Sh09eu08axWXqKwVbZ6jzGOMCGy+dsTqmlZOAQgG2ZeqDROjsAdqer9O3eerxDP9eNw8jhJuriXrfuU0yUgKVayHkdzrMUMyJPRRMywrQdF+fgPvZEp+qRrs1VG4n6qdm8puSusdi4AIpzCCcpNKWpMBO+nDPOXgoSXp21u7KVIOW1OchbTEnW0MsIZCe6QKRQwWoFioI3DQZmIwNTDr0Ir
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZXWU9KU1lNTWQrWUdFZElDNVBJeVJVUEFVNFhPTjROZk5waS9UcWFkV05O?=
 =?utf-8?B?MzloVlpWZ1FwYTArN0srTzh1S2xwcXY3bWpscTJWOUkyc2ViYVFiRG9NMSsw?=
 =?utf-8?B?aUVLVmlzSWZOT2t2eWg1N1FKSWlqdGt6MkI2VEZCVjRqQTNaV1ViNzdCdzJS?=
 =?utf-8?B?eHZyb2pYM1l5NlFDZzlEYVkyZkQ5ckNNQm1LSDdVQkpxemtOUkpGRUhoVWM0?=
 =?utf-8?B?NWh5ZS83a2ZuVWh6bmR2L2VqZVdTcm84dUZXNytXZmYrY3dqUXVpemhzMGwy?=
 =?utf-8?B?U1M3VnZvSnozeERQWnNqb1pBUkVVRmhKQ0Fwc2VoeTZFa1dDWUJOVEI2bzZP?=
 =?utf-8?B?V0w3S1Z0aG52SEtsTHVzSHBlTklFaWlFb0wzaHdCOXk1a3lYSGVMTlFwRWcz?=
 =?utf-8?B?UVpCWDRPN0RuQ0VZSFgvVkw3djI5cTBKbkp4Tm52cDQ1WlI4R2hpK04zM1ZO?=
 =?utf-8?B?V3NzNTNUZTdNdGI2L1BDczkyNGdCVjVlOG5jOWEraWNla254RHkxaW1abVp5?=
 =?utf-8?B?WmY1eFRqTHo1UEs3ZUZhaFR3RzI5OUw4VTF2dU1BQmFleDU2MjExZ1JFZldU?=
 =?utf-8?B?VGxYNW1aOVlSQ0cvM3BRWWwvenpGcEVpNkRlQWhmSGhTcXZHcWxRbXU1Q0l5?=
 =?utf-8?B?dnREeVRqMWdTckVST0NjbXFLQzBYRW5WaWNSWmh1cmY0Z0ltT0RySnBldjZx?=
 =?utf-8?B?R2lkZ1VEVVlCRFZ0c3paZlBSZzYzOXFjNnJVdmhKWHlYd2x1NHl6ZHFFT0cr?=
 =?utf-8?B?cFFVWjA1czFtNUxqUktEb2pleHFuTWErRG9oQUJYaXhQZkJBTTBmNklYWWxl?=
 =?utf-8?B?Qkt0VlcwRFYrNFhDSXNXeHhGajdQTk9oWUkrV1cxMWE2ekppc0VINm5FT1lD?=
 =?utf-8?B?S1pCb2dmVEwyUkF4UXZnMmxldnc4UW1EQ1k3N1ZFNkNNcFBxTiszUFIwNnc0?=
 =?utf-8?B?dEFGaDRJSGJ0ZGorcllvbkp4V29GS25XN01hUFZIWXdmeC93NmFMb0x3ZWF5?=
 =?utf-8?B?TjdmWlBoTUhpRTc1eHJDWjZRajJZZDUxcTQrd0p3b0dITnRFQWlSNVZ4eU1I?=
 =?utf-8?B?d2xyVzVWNTRRVVplU1hsWWczK2JIZGtCd0QyZVJ5bWlnb21QVE1KOUdudTlM?=
 =?utf-8?B?ZzdoSzZZbkdHMFVuOXFrRU9kQnhkM2xwWHR3K2U0QUt6cXpKaXo1dWFFbWhj?=
 =?utf-8?B?L3lEM3FDanJrODM4bzJuUkNEWUR0dDE1TFNaT282WWJEMzMvU1FtdkxJeDdT?=
 =?utf-8?B?YWRNR2x1OGdBK09sZytCMUdpYU1RT1N1TkozRkYxVXJOK1B3ZFB5eGRVZU5L?=
 =?utf-8?B?TW5SS05mOGNPc1dvNEVncGJlaFo4M3FuWG91d3YwNytZd2dvU1A5L09QRXVp?=
 =?utf-8?B?OXY1SVpWNVVpb2xnZy96VS8vUitDNWg4c0J1d3U0YjN1UEU4V01ibE02TWxY?=
 =?utf-8?B?QXJIRDB0K3BmaW42TzJ0T1IzMXBGcFJVK0w0S3pWTnpBNXV5elhnMS8rak9M?=
 =?utf-8?B?aWMxeGh0QkJqMXdYZVE3enBuTWFKRENCZzZ3TDlCckR2N2JZSG9YSkp2WEs1?=
 =?utf-8?B?MFBqYytXRU5OZjFOSkZud2hNVXFIQ1hJdmRadWtRNlYvMWVWVmpaSmtFQVQ1?=
 =?utf-8?B?Qnd6YXJPaGF0cU1XbjVFZUd0akRrMTNJNmlxSjd4QVhhbzRPRTg0SThhMkFp?=
 =?utf-8?B?SzJXK0I3U0VnRkZzQmtVYWhDU29Vd0tDSkxZUGNhOWY1dS9NUWNZcm9ZRkdI?=
 =?utf-8?B?TnlaM3ZxMmMvd21tcUVSV2JFLzVnVTl0NWw0aHphSjkxWGE4d1JJN0F4RnI4?=
 =?utf-8?B?Q0pSaEQ2U0xvRGVSMksxNWV3eVFpbVRtUWxxcEkxWDdhSUJiZTY0SS85Y21q?=
 =?utf-8?B?SzV6eVhWRTBkQ2Y1V3dtVjMxdWtGWFdqWGtJdGJ0T2x1aThCb3N3VE0yMnFX?=
 =?utf-8?B?NmphUUY4VWF4NEFhQWRQTVpRanYyNGNEbjg2MHVSdk5KYWh2ODhrSHZOU0dZ?=
 =?utf-8?B?TlduSmZUa1dxWHhZUUZreENEaDhIM0FzcG5BY2Z0YVc1TUYzVTFKejFnd2pL?=
 =?utf-8?B?K3F5aXdDTEhiczZqeWZHWnFyQ1h4Rm85OHl3SGg1MWlRa1lYbXVGV3RyODdt?=
 =?utf-8?B?SnpHNjM4OURrNlFxTTdSVVAyTEEzQ3RrV3JBcDBtaTlkMTI2OVZYYlZNNzJp?=
 =?utf-8?B?a3RIUkRLL2NtSXlwbjhEbFFUVEp1SHh1cS9FQ1RuTXJ6QUJ6c1hqY0lhaGNL?=
 =?utf-8?B?Yi8vbmhZRnVJcDMyQVpMSkFabmIrNHBqQzQ5OHVZaVEwbkF2Y0paZFFNbnYr?=
 =?utf-8?Q?RZFPctUQWG68tk2rCi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7215144-971b-42bc-0d4c-08de963e440f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 13:45:30.9906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26i/9anG/mfdGFWwwrQzVHaClrbQc+VqaYlLTHjmeanDrXn1ZiX9aLMKOeki6Bu5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
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

Hi Geramy,

On 4/9/26 15:12, Geramy Loveless wrote:
>  Christian,
> 
> This is going to be very interesting.
> So the AMD Radeon AI R9700 Pro is running over USB4v2 into a Razor Dock on a 650W power supply I have two of these setups cards provided by AMD for some project testing on tb5 rocm ai broadcast messages for testing two machines connected over tb5 with rdma sorry if I loose you here.

Just as a site note 650W for two Radeon AI R9700 Pro is a bit tight. IIRC each of those GPUs can consume a maximum of 300W. Our test benches with two of those usually have 750W power supplies.

But I don't think that this is the issue here, power supply problems usually look different. Is the whole box provided by AMD? Who is your contact person anyway?

> What I am seeing or finding in my opinion is thunderbolt is not very well flushed out on Linux in terms of stability and accessible feature sets.

Yeah agree, thunderbolt setups is also not something we usually have in our production testing. So it can work but absolutely no guarantee for that.

> After my kernel pci patch I have gotten it to work which we went over already.

Your patch looks valid of hand. But you need to be super careful which resources to release on BAR resize.

For example AMD GPUs usually have two resizable 64bit BARs and one 32bit BAR, *don't* release the 32bit BAR or you most likely run into trouble.

So it would be helpful if you provide an lspci -vvvv -s $bdf of the two devices with and without your patch.

> 
> I have one machine running Qwen3.5 27B A3B on the GPU with llamacpp / lemonade successfully but yesterday after attempting to load the model which it did into vram it crashed which ten minutes prior was running a prompt 73k tokens at 40tps. A side note The power management on Thunderbolt seems to clash with the power management on the GPU. What I was seeing is when the GPU doesn’t detect a display it “suspends” which may be correct or not but it doesn’t matter either way in this scenario.

That behavior is perfectly correct but the message is a bit misleading. The GPU suspends when there is nothing displayed nor any software client connected.

So every time all applications stop the GPU is powered down and every time any application starts it is power up again. This of course exercises all the drivers and firmware involved, so there is a lot which can go wrong and I'm not surprised that you have seen problems with that.

> The Thunderbolt fabric I believe shuts down also and kills the link. I got passed this by disabling all PM systems.

How did you do that? E.g. which parameter did you use?

> So I’m not 100% sure what’s going on and how to find the actual problem yet maybe if I spend more time and brain power on this I’ll find where in power management it’s having the problem or if that’s the real problem. Let me know if you can offer anymore guidance into where I should dig. I appreciate the help this far and the SMU information helps get more context.

I'm here to help.

Cheers,
Christian.

> 
> On Thu, Apr 9, 2026 at 5:57 AM Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
> 
>     Hi Geramy,
> 
>     On 4/9/26 14:13, Geramy Loveless wrote:
>     > Hi Christian,
>     >
>     > I appreciate the speedy response,
>     > What your saying makes sense they are basically wrapping symptoms that could at least from what I seen now at this point only continue and eventually create a web of useless code to try to catch all code paths it hits during crashing. Let me investigate the real reason as to why it’s crashing more rather then where.
> 
>     To just give you a bit background on what happens here:
> 
>     AMD GPUs have an embedded micro controller called SMU which takes care of things like voltages, clocks, temperature, fan speed etc.. and reset.
> 
>     So when the kernel driver detects that it needs to do a reset it sends a MODE1 reset command to the SMU. But instead of the SMU coming back a short time later noting that the reset was done the device just drops off the bus (e.g. all reads return 0xffffffff).
> 
>     The cause of that can be anything, e.g. from power fluctuations to a dirty fan which doesn't starts to rotate again after it was stopped.
> 
>     I would try to narrow it down step by step, e.g. if it work on older kernels, if yes what feature/patch broke the behavior. You can also try to disable certain power management features like ASPM (try amdgpu.aspm=0 on the kernel command line).
> 
>     Hope that helps,
>     Christian.
> 
>     >
>     >
>     > On Thu, Apr 9, 2026 at 4:42 AM Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com> <mailto:christian.koenig@amd.com <mailto:christian.koenig@amd.com>>> wrote:
>     >
>     >     On 4/9/26 02:05, Geramy Loveless wrote:
>     >     > When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 on
>     >     > Thunderbolt the TB driver receives no notification and the tunnel
>     >     > stays up while the endpoint is unreachable.
>     >
>     >     IIRC a MODE1 reset should keep the bus active and so the endpoint should still be reachable.
>     >
>     >     > All subsequent PCIe
>     >     > reads return 0xFFFFFFFF and MES firmware cannot reinitialize,
>     >     > triggering an infinite reset loop that hangs the system.
>     >
>     >     That sounds more like the MODE1 reset failed.
>     >
>     >     > After MODE1 reset completes, check whether the PCIe endpoint is still
>     >     > reachable using pci_device_is_present(). If the device is behind
>     >     > Thunderbolt and the link is dead, walk up parent bridges calling
>     >     > pci_bridge_secondary_bus_reset() to retrain the physical PCIe link
>     >     > inside the dock.
>     >
>     >     Well that is then a bus reset.
>     >
>     >     I mean that is a reasonable mitigation when a MODE1 reset failed, but the question is rather why does the MODE1 reset fails in the first place?
>     >
>     >     > If recovery fails, return -ENODEV to prevent the
>     >     > reset retry loop.
>     >     >
>     >     > This also causes the GPU fan to be at 100% and basically when it
>     >     > happens and you are not there, you now have a GPU with fan at 100% and
>     >     > cant reset it.
>     >     > I wanted to notate some other things I am finding sometimes before
>     >     > this adventure of patches to the kernel and amdgpu driver.
>     >     > Sometimes a crash could happen in the drive and then the GPU fan speed
>     >     > hits 100% and the air is hot coming out without any workload, other
>     >     > times
>     >     > I have seen it have barely any fan speed at all and heat up more than
>     >     > it should at the fan level its curently operating at. These are things
>     >     > I have seen with this gpu in a TB5 dock with the driver and
>     >     > instability. I'm not sure exactly whats going on there but I figured
>     >     > since im communicating with these patches I might as well bring you up
>     >     > to speed and supermario has been great help throughout me trying to
>     >     > get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB5 /
>     >     > USB4v2 dock!
>     >
>     >     Adding Mario as well. That strongly sounds like you crashed the SMU which would also explain the failed MODE1 reset.
>     >
>     >     But all of that are only symptoms. Question is what is actually going on here? e.g. what is the root cause?
>     >
>     >     >
>     >     > It seems to be finally working with bar resizing after my kernel
>     >     > patch. Which allows you to safely release a empty switch bridge at the
>     >     > device end.
>     >     > Then it rebuilds it afterwords with the increased bar. This was done
>     >     > on Kernel 7.0-rc7 i believe it is and latest changes from pci/resource
>     >     > branch with my patch here.
>     >     >
>     >     > https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u <https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u> <https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u <https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u>>
>     >
>     >     Where is the MMIO register BAR before and after the rebuild?
>     >
>     >     Regards,
>     >     Christian.
>     >
>     >     >
>     >     > Thank you!
>     >     >
>     >     > Signed-off-by: Geramy Loveless <gloveless@jqluv.com <mailto:gloveless@jqluv.com> <mailto:gloveless@jqluv.com <mailto:gloveless@jqluv.com>>>
>     >     > ---
>     >     > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 ++++++++++++++++++++++
>     >     > 1 file changed, 40 insertions(+)
>     >     >
>     >     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     >     > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     >     > index 31a60173c..91d01d538 100644
>     >     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     >     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     >     > @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>     >     > /* ensure no_hw_access is updated before we access hw */
>     >     > smp_mb();
>     >     > + /*
>     >     > + * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe
>     >     > + * endpoint but the TB tunnel stays up unaware. Detect the
>     >     > + * dead link and attempt recovery by resetting parent bridges
>     >     > + * to retrain the physical PCIe link inside the dock.
>     >     > + */
>     >     > + if (!pci_device_is_present(adev->pdev) &&
>     >     > + pci_is_thunderbolt_attached(adev->pdev)) {
>     >     > + struct pci_dev *bridge;
>     >     > + bool recovered = false;
>     >     > +
>     >     > + dev_info(adev->dev,
>     >     > + "PCIe link lost after mode1 reset, attempting Thunderbolt recovery\n");
>     >     > +
>     >     > + bridge = pci_upstream_bridge(adev->pdev);
>     >     > + while (bridge && !pci_is_root_bus(bridge->bus)) {
>     >     > + dev_info(adev->dev,
>     >     > + "attempting link recovery via %s\n",
>     >     > + pci_name(bridge));
>     >     > + pci_bridge_secondary_bus_reset(bridge);
>     >     > + msleep(100);
>     >     > + if (pci_device_is_present(adev->pdev)) {
>     >     > + recovered = true;
>     >     > + break;
>     >     > + }
>     >     > + bridge = pci_upstream_bridge(bridge);
>     >     > + }
>     >     > +
>     >     > + if (!recovered) {
>     >     > + dev_err(adev->dev,
>     >     > + "Thunderbolt PCIe link recovery failed\n");
>     >     > + ret = -ENODEV;
>     >     > + goto mode1_reset_failed;
>     >     > + }
>     >     > +
>     >     > + dev_info(adev->dev,
>     >     > + "Thunderbolt PCIe link recovered via %s\n",
>     >     > + pci_name(bridge));
>     >     > + }
>     >     > +
>     >     > amdgpu_device_load_pci_state(adev->pdev);
>     >     > ret = amdgpu_psp_wait_for_bootloader(adev);
>     >     > if (ret)
>     >     > --
>     >     > 2.51.0
>     >
> 

