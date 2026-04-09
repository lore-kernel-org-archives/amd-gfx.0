Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB97EA3C59
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 12:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9C110E7EC;
	Thu,  9 Apr 2026 12:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Llp4z6iG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013016.outbound.protection.outlook.com
 [40.93.201.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF7B10E7EC
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 12:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3PiyZAuBIgc+GGcQ3sXnXYH2Loah1p/utgpcc1rWkGWRntyETApsOGfZg73Wb8xP6/hglHzTkBhEFks9EF8Pe86zqnqp+27mfmebEpnJi++lFHKcZcc1RqKoggw70aTLeL4PlV2FCP5ATK4dl96FpvRDmUcRy3ALjkae4CkLCprjDB8Nlv3ddLrUhN3wRyoUt+HQR91uS2In9pXIOfvkj58lw2qbE01fTrLtFAZL4Whf14W4ITjuHph89SK6OTOr99bpgGlXqkocgm03QR8dfa8u5Is6wkeOc18uKhTkmXQQODRbZHKEW60yh62ILG2+w2hdBn26JK48QFo9I5KaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDWNSP4E0Z7J7C3C+K0AEeLWxxUhPm6bt3a0QQ2bwa8=;
 b=yCYGu7gL+sO9TG18wB/0NjaGkPA9xaov0P16Ytcyge5rN6GabCEAk8SH9Tco9LWQ6fsjAKGU3DU+QDhfMJV1oNjMANfEiSET38KLX0+7bE87AwSLCobEEhZ7G+svOb8b9QDP+P3j9Juyh5d+7hNgcTWkNpLxk8vLD+F1fqaGv1CZ0Fzv8oysvip6iaW8wrzrjng07Vq4hOkYg4ZjnfXmskPoGKPq2cumpuZzjhYa78l4JrJsJQRRNCLRSnl6p1gHdp2F5BAAi9JRcHHC4oV0BJxQWct7snsB12p8W8oRIqCBDMAxRBQR7HZkFdhqRBxgXTEZyIgWyxkyM1C/LBgOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDWNSP4E0Z7J7C3C+K0AEeLWxxUhPm6bt3a0QQ2bwa8=;
 b=Llp4z6iGtA8liRUmrzubZH7lQL2kipcCbHR4K4mBmzfESc2q+eNFgLir33AJK12EvCKztSOZgt2ONE1Kcps8b8nP0019CMI3uuOf7ck8+IT+iK5m3T1qIIELdk6Wg5UIulIqig1wJpCJomokWoYFpiEJrCEDQE4wzmPsc+06c5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 9 Apr
 2026 12:57:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 12:57:46 +0000
Message-ID: <b92192ad-0a49-4234-927d-71e2c5441947@amd.com>
Date: Thu, 9 Apr 2026 14:57:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: recover Thunderbolt PCIe link after MODE1 GPU
 reset
To: Geramy Loveless <gloveless@jqluv.com>
Cc: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>, alexander.deucher@amd.com
References: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
 <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
 <CAGpo2mcLFMrkduCx1MuQnR3EZUxtEo+jT8PAXGgXbGDm2_1Now@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAGpo2mcLFMrkduCx1MuQnR3EZUxtEo+jT8PAXGgXbGDm2_1Now@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0306.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: b7014487-ab77-42a9-d1f4-08de96379887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|13003099007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: zG7q8/4FnJBu7xJwH0aDvKSn/b06dKKt8QnxtgOaETUTIs5M9vLcjm9lDDSsjgB2sta3f4MVziEkLSArB0zSs+qL74e/4EVTrAq7BIjpF2HsFpCjPfnte7goXLavQtWMPNptALU5Qe3/siKJ9DQzQmL+l+2hgAdogFqt8QugCCtbYbicRud2EH/cbsWbzA2l4vooXsPlXnBO5geiXFe4CixTxrzLVwREkmymwFTtIkhwp4TFWTip7UGAQtufqrP9c0oSivTZBiOhqkUgmbiW8y1qeJUejwrXkoSHy3BXUn9G1LAoVGLxCXBASm9DwqlCQw5+2XW09CW4HSqfpp0ElN3dfbFkisKs9JT5KCiAG2ngqbvH3LQUEN4C66HxSw+y1vafaBrIsZ537+RbzRDo+h2Lhpx29KBTVzw9hMkrBYHQDd4hOl6VrBeoN5tf82QOshc2R5Dtm8D/BASBdxYQMDXMAMZPGq3/OS+rEqpjo5AVqrRVSVVqjnr/2PeF0I/GeIZHCGENlCRD4MXH2icdhOctQnT2wFN8QizgUo3m4kF2M02dEiiSj35IWHAce3U8c9w/xCN76AEck3tnAm72ojyGbHJnVvFL+NGF/odCU88xfmQk0lp5a2f5AwFScC/jwPtqpICJ5G+r5xrny85kKBlWG61DSWGhB+vEQjB01QGBnA93wKIQN3uTyJiATWSu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(13003099007)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzZRR1JRYlJOR3diVFo5R0JBbTNEcGpTWVRndWdEcys2RWNIQ0hkMHRGWFV3?=
 =?utf-8?B?MTV3T2RBUmNkMlREWWZmSjRDUFNoaUJ1bTZKdmkxQ2U1QzUxNnA2SUVYdTI1?=
 =?utf-8?B?YmpqaFlwK0QwMjZEZVVWZXZzanFFalIzdDdpbG1YYUJOMlRZcDM2ZWZyYnFF?=
 =?utf-8?B?OGMzVUYvamQ3SVlNR1p3NlN2djd3MlhXMlArZzVOYlBzYXFDR1p1dzFlM3J4?=
 =?utf-8?B?Y3c2aDNvUk5KSjNRU2R3ZlZKeTk3d3NFQ1dVdE5pUnM4dnRzY3dib2NkdDlr?=
 =?utf-8?B?NE91VkxSVFpSS1BQQmJSVnprVkhlNHNVbk1GL0lXZDJ1WHFGV3FSQ3kxR3ln?=
 =?utf-8?B?S1NPNXg5cjM4WC9jdFVMSUhVdjJubjZzR0N2THhSL2pXZTZrRFd2RXM2RWNr?=
 =?utf-8?B?M2VtcFBGVkJ1dHRxQytOY0c2N2V6QUdXcEpUalBuNUVpN3ZoUFNoRTJDeHBi?=
 =?utf-8?B?a1ZxQWVBTTlRMjJBaDN4UWtPU1ZBcUJhUGxCR2dXdVA4aGZnMWp6NGE4c0gx?=
 =?utf-8?B?U1ZiYzlHaHllMU96M0FXa3k5MnF2Wm9NSVZTOFpnS3FURVFVVGRvNDh2Zzhp?=
 =?utf-8?B?UzZ1eDIvNmZNRDFRclRyMUwwLy9HbWJYNzR0ZGgwSTB5OTVYdTFlS0hPdFd3?=
 =?utf-8?B?cEVEVHVtTE1VUm1iWjB1bUJRSDVTUzM3Y09ITzd5aWtLYkYrN1NUaVBUU3Uy?=
 =?utf-8?B?aER1bHptNEU4V3BSR0FuZVBmRzBJVCtub3B5ZGo1dEJNeWZrSmNRdnBGa25Y?=
 =?utf-8?B?M0pQTllWQXo4NWdJYjk2dzB5MXgrd2ZYQ0F6WmhXMXRhVXRiMFBqWmVrZXhZ?=
 =?utf-8?B?NWsvNEIyTUFRRGp2dGhMSUNIdFVRLzJyZlgvVVovRktDNVVaaVdwMXFoSG52?=
 =?utf-8?B?MlpudVBBSHE4OGgrdFowUElieU1NK2IyWm9IbVJlYVcrUG1LNFhzd0JkMk9M?=
 =?utf-8?B?aitOYVdpa3FONG5mb1JyTXVrYjliSDJnSHZqMEg1MnBvQU5GNEdxbnB2T0Iv?=
 =?utf-8?B?S1lRbmxXdXhZeXl1RXh4VUdSNXQ0c0tLVEVRa0xsTGtxUmwvUVdIYWlhVXFu?=
 =?utf-8?B?VlpQSWFnV2pWWkdYazdMZ1pwN3JMMDJBNnVMM2NJQ09mVktBZzVIN3lrRGp0?=
 =?utf-8?B?VUNwUUNhMDZ1blFPUXp0eXRmUlo5VU9lYS9qTzFwd2FzN0Z5MTBCNFlTWno5?=
 =?utf-8?B?RWtkd240dDFKaVdNZ1Z1UHBZT3BBUUVLYmc4L1NZcTRMS2FmdHdMNktvMFYv?=
 =?utf-8?B?cWhkZzFUTGdPZVJSSzE4S3lzUHArTHJzNmlIT0E0WnVlbktiRVR0T2JNWFl3?=
 =?utf-8?B?WTRPTmtDdUlMd2JTcHJ5aS9EWXA3TCtMZjR1TUNMSXlZRUZKVDlhakpTMlBk?=
 =?utf-8?B?VVZUWlRUNzdnTUpIODVOQVQrM0RlU1pBOGJ3SGs0YXpzeVZ0RGV4RVYzbWtI?=
 =?utf-8?B?eUdYUUV2R3NyZ1dqVk4wMHdzUmZPeDVUZDRvTjRFRk9GS3hQSGxtSDhWc1Va?=
 =?utf-8?B?RFlHakdiMnhKa0lNNHN1VWUrREprT0dGRWR1VG14QXA0NGwzSUVGZFJ6blVw?=
 =?utf-8?B?UEJ6QzliMnpMK0tSZGQxUUw3UE4vSDJQbDZ2TG1mQjdoUndWcG4vQ09tUFFy?=
 =?utf-8?B?V2ZzaUpKVC9aMGVaeThXRE9wb0JtbnZnWDNRMnhBQS9UK2YrTm9zc1phcW5Q?=
 =?utf-8?B?K1FIVExxb0ZFdzFqU05nSXp2VHlXODA2UnA2SnJhU0paaWZjQzZDaUxBZlJa?=
 =?utf-8?B?WVJFZXdQMW05VEZzWExDeDRzeFBLU1hsbk54ejQxY09YU01jejVZY21ZZmdy?=
 =?utf-8?B?L3N0aGtKN2I5OVI1dVNTenVTK2JzSXJMb0JHU0pFY3Z4SHArSUxYMkxXQVFq?=
 =?utf-8?B?dkZBOFF6NHJVa2dodFI4VUx5bFM3VzRTUG9XeEdXVmRJTFRmOUxuTGppOE1U?=
 =?utf-8?B?Rm9Uc1h5K0xYcWxXZXFHQ0k5cG5id2lxcFVEYU0ybDhFaHpFRkl2aGszMlhR?=
 =?utf-8?B?ZUFQb1piUEQ1dmRuaFdLYjJsQ0NMaVV2dE9iRWQyYWIxMXk3aTZncEpyOXJo?=
 =?utf-8?B?bXVNUmpubGtzcHRZNy9rWXgvd3Y2Y0dzaUR0cHI1ZytxdGZMVURueWFMRFdK?=
 =?utf-8?B?MkRNclNtNWJyc3JxcTdZamZWMzhQOFRoZEhoM09VWVVLUFdXUUNaNE1WWm1y?=
 =?utf-8?B?QU91VTJBeFg2OWFscDQ0NFBNN2c3Wk9YWm8yVUFRa3IwNmJqWC9YK2FBa2FC?=
 =?utf-8?B?bUs3QkhJbDZKcVdzUDI4Tm9DamlNZnlyRkM5UmwraTZPVENabUNJbjE3a1RW?=
 =?utf-8?Q?tr1KjP7faNSt9eG3qd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7014487-ab77-42a9-d1f4-08de96379887
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:57:46.1919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cz31uy/h5mgtYEJdHnnQEU8hYEvjDgO2g0lZrETXFlcDGTU1iFNF8wWvioC8R7zY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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

On 4/9/26 14:13, Geramy Loveless wrote:
> Hi Christian,
> 
> I appreciate the speedy response,
> What your saying makes sense they are basically wrapping symptoms that could at least from what I seen now at this point only continue and eventually create a web of useless code to try to catch all code paths it hits during crashing. Let me investigate the real reason as to why it’s crashing more rather then where.

To just give you a bit background on what happens here:

AMD GPUs have an embedded micro controller called SMU which takes care of things like voltages, clocks, temperature, fan speed etc.. and reset.

So when the kernel driver detects that it needs to do a reset it sends a MODE1 reset command to the SMU. But instead of the SMU coming back a short time later noting that the reset was done the device just drops off the bus (e.g. all reads return 0xffffffff).

The cause of that can be anything, e.g. from power fluctuations to a dirty fan which doesn't starts to rotate again after it was stopped.

I would try to narrow it down step by step, e.g. if it work on older kernels, if yes what feature/patch broke the behavior. You can also try to disable certain power management features like ASPM (try amdgpu.aspm=0 on the kernel command line).

Hope that helps,
Christian.

> 
> 
> On Thu, Apr 9, 2026 at 4:42 AM Christian König <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
> 
>     On 4/9/26 02:05, Geramy Loveless wrote:
>     > When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 on
>     > Thunderbolt the TB driver receives no notification and the tunnel
>     > stays up while the endpoint is unreachable.
> 
>     IIRC a MODE1 reset should keep the bus active and so the endpoint should still be reachable.
> 
>     > All subsequent PCIe
>     > reads return 0xFFFFFFFF and MES firmware cannot reinitialize,
>     > triggering an infinite reset loop that hangs the system.
> 
>     That sounds more like the MODE1 reset failed.
> 
>     > After MODE1 reset completes, check whether the PCIe endpoint is still
>     > reachable using pci_device_is_present(). If the device is behind
>     > Thunderbolt and the link is dead, walk up parent bridges calling
>     > pci_bridge_secondary_bus_reset() to retrain the physical PCIe link
>     > inside the dock.
> 
>     Well that is then a bus reset.
> 
>     I mean that is a reasonable mitigation when a MODE1 reset failed, but the question is rather why does the MODE1 reset fails in the first place?
> 
>     > If recovery fails, return -ENODEV to prevent the
>     > reset retry loop.
>     >
>     > This also causes the GPU fan to be at 100% and basically when it
>     > happens and you are not there, you now have a GPU with fan at 100% and
>     > cant reset it.
>     > I wanted to notate some other things I am finding sometimes before
>     > this adventure of patches to the kernel and amdgpu driver.
>     > Sometimes a crash could happen in the drive and then the GPU fan speed
>     > hits 100% and the air is hot coming out without any workload, other
>     > times
>     > I have seen it have barely any fan speed at all and heat up more than
>     > it should at the fan level its curently operating at. These are things
>     > I have seen with this gpu in a TB5 dock with the driver and
>     > instability. I'm not sure exactly whats going on there but I figured
>     > since im communicating with these patches I might as well bring you up
>     > to speed and supermario has been great help throughout me trying to
>     > get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB5 /
>     > USB4v2 dock!
> 
>     Adding Mario as well. That strongly sounds like you crashed the SMU which would also explain the failed MODE1 reset.
> 
>     But all of that are only symptoms. Question is what is actually going on here? e.g. what is the root cause?
> 
>     >
>     > It seems to be finally working with bar resizing after my kernel
>     > patch. Which allows you to safely release a empty switch bridge at the
>     > device end.
>     > Then it rebuilds it afterwords with the increased bar. This was done
>     > on Kernel 7.0-rc7 i believe it is and latest changes from pci/resource
>     > branch with my patch here.
>     >
>     > https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u <https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u>
> 
>     Where is the MMIO register BAR before and after the rebuild?
> 
>     Regards,
>     Christian.
> 
>     >
>     > Thank you!
>     >
>     > Signed-off-by: Geramy Loveless <gloveless@jqluv.com <mailto:gloveless@jqluv.com>>
>     > ---
>     > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 ++++++++++++++++++++++
>     > 1 file changed, 40 insertions(+)
>     >
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > index 31a60173c..91d01d538 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>     > /* ensure no_hw_access is updated before we access hw */
>     > smp_mb();
>     > + /*
>     > + * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe
>     > + * endpoint but the TB tunnel stays up unaware. Detect the
>     > + * dead link and attempt recovery by resetting parent bridges
>     > + * to retrain the physical PCIe link inside the dock.
>     > + */
>     > + if (!pci_device_is_present(adev->pdev) &&
>     > + pci_is_thunderbolt_attached(adev->pdev)) {
>     > + struct pci_dev *bridge;
>     > + bool recovered = false;
>     > +
>     > + dev_info(adev->dev,
>     > + "PCIe link lost after mode1 reset, attempting Thunderbolt recovery\n");
>     > +
>     > + bridge = pci_upstream_bridge(adev->pdev);
>     > + while (bridge && !pci_is_root_bus(bridge->bus)) {
>     > + dev_info(adev->dev,
>     > + "attempting link recovery via %s\n",
>     > + pci_name(bridge));
>     > + pci_bridge_secondary_bus_reset(bridge);
>     > + msleep(100);
>     > + if (pci_device_is_present(adev->pdev)) {
>     > + recovered = true;
>     > + break;
>     > + }
>     > + bridge = pci_upstream_bridge(bridge);
>     > + }
>     > +
>     > + if (!recovered) {
>     > + dev_err(adev->dev,
>     > + "Thunderbolt PCIe link recovery failed\n");
>     > + ret = -ENODEV;
>     > + goto mode1_reset_failed;
>     > + }
>     > +
>     > + dev_info(adev->dev,
>     > + "Thunderbolt PCIe link recovered via %s\n",
>     > + pci_name(bridge));
>     > + }
>     > +
>     > amdgpu_device_load_pci_state(adev->pdev);
>     > ret = amdgpu_psp_wait_for_bootloader(adev);
>     > if (ret)
>     > --
>     > 2.51.0
> 

