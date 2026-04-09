Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721A7EA3C4E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 11:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE5310E804;
	Thu,  9 Apr 2026 11:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5arwaKGE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5329910E804
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 11:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCLUdl3u0/UeeS3sqTBaXbUNqnErU3cJZsEMfMVZ8FqP/PALFnBS0jiXG9wIVK2LuSUfO4a/cU54RKI7vqfZjrRG2WnZ/XO6H/VhHB5ZYY1tuSg8NSEa06ZRAs2Sm9wNc45w4mdxhwrTeADdCouJB3DlVnkg8EwMXIDj5kK4sdtY6WAQAf7Rs9hnyd1405m/1J16ZdO52HmWvWffgQBPrBkGqAINkNnlWapS7H8QwiiP45d9t8zfNbFJfLXHF/1h2w0P5JWq1SwFt7URr65r40tSp5CAv+iiOM32+UyjnmjuVQkn1vbenGoKxBgvXMLtar495PAbvXf+98tk65Yv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tksGBHIlSeiEIeGrpUFP6RdoSw/2ySCY34G6OB9MfXU=;
 b=D1v4QOWouZc7MNwUKxpeoJv33d1fydeq7ZCzPcz/2xZFLEohLblGbAkMmVxHYmeeIHrhNKKsjdO+b3EYKgeWWduItp7xv5Qma1wjHshStYA4kx4nDXjVOTKkIhi8UVtjDjsOPU49QOhwsX8sSqJePZPuFYK8f4g4ag4WDgKqbv03LsVLmQvkgzzYsDAo/mBavwAgeJKwbgkKgPLcFW8j51qxldKxvxhC3wsp8yLUd3dw1QHEMQ3Mu8sPTLVGJ/FsMhoSxs5LikExGqia7hxdK3ttmq5rlzKt+PM0NWveIYXaQRIgwTyTdzLPJ+XtF/bdqZobTz+mpHTx2/r5UJW97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tksGBHIlSeiEIeGrpUFP6RdoSw/2ySCY34G6OB9MfXU=;
 b=5arwaKGEtt4ZKqXuUmRG0QXwJEQrPRNYvNchVO/xgbD2b54RoCc+Jv2kgxsBtPFGRjR3KKPjsmE6ixr4sd7PbI+5uKfQWrfL3eX5Cd6vZR7soVVl1+4MadkIdWCme9StJdGvTbr7GK+AXVbR/WxipE08qPEWRnaWvcnM45nm5xI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 11:42:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 11:42:40 +0000
Message-ID: <243af06e-912b-4915-bc64-5aa16dad7db0@amd.com>
Date: Thu, 9 Apr 2026 13:42:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: recover Thunderbolt PCIe link after MODE1 GPU
 reset
To: Geramy Loveless <gloveless@jqluv.com>, amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: alexander.deucher@amd.com
References: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAGpo2mebCaP4vFuTnn6jgu6OjjE_ssS7i8ENepuUjwwHXddCHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:408:e1::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4ab74d-815e-4784-411e-08de962d1ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: jaXF4R2eRazJctwNUyN2VIkmAD5sEA3VmR2QtUMUrVldA9I2UiezHlRlN/jkDGFwAR/Q06JUSsHEP+tjIBK/Bm72hZmW3JF9apzsEkZa+uepGW/PAtN2m6PTXWG5ahIVq0WJLHIj6qI8iswVPFYw/lcTOxSqUCEhZRg6j2D2K2nZJX9frtkvXN0e8yRvj2I88W+DPZXOT+FDtso12pSALzECLk7AD/A34AxR1ETdQx3FIiUD19UhyQak3/ZTSDKWDclgKpjlZ4rGkB/iilORvGnTPA8Vr9Xnx7mqF7qwjq2w9Ua2VdFy9Yrqq52qipZewWU5POKH+raGF9zVHIPjj0bVqS3DSU3IBRW3d7jPp+wRpfC1xRZYmWwLtkghuzQYjA6QikB2kXLqNfOhjVWxreFlVCXS3atwvQ/j2kB8JRvC+0jQqUYrRtcFK91sOeAjVAg0YT27kxuEk/V80h+XnS/aYWqZaf0PY79uM0qCN1t+gic+kVBg7WiAHIDfDRnRKGGV24W0ss0P3KOaXrFt8Zps30MUYY9bEoXAybhU19DYd8JHl6M+MMHhBSilEOuh3uFOQ2Bsqm5qkWu6mCCZ42/I8eoVaqGshmXV/dW/uKqHt4BfA6i1hS5ZhhP4tj+o1MwYnt3gKef69aVsLjQ8dL8XHNrZ9XBoMfwpd1fj2TZ8dVr5zKPKIMmW/w/Frzeh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGlsRTYzQUxxMXI3OWU5bmM4QjdRSXRmMnZmWjFxbzQyNEE3SmdCa1A0N2FB?=
 =?utf-8?B?RGdtLzBKN3lSVXJ3c04wcE1TeGJKOVZBOVNvckVKMmx2WWhSanp2aElJcTRV?=
 =?utf-8?B?ZVNTVnFFam0wUWpVKzZzSXpYVUl4VXgyMEZQZVk1L0tydW1DZUhiRFlKc0F1?=
 =?utf-8?B?aFNvNXJLQWdjMHhnb3NEWlJCTW90T2F5TFRJR0dXYXEySzExVjFJU0tuWUUw?=
 =?utf-8?B?d0pkcGx1VW15dlUyMFN2THFLeHF1SzhBMmk2SnJIVktjSkU1VlBTcUVBR2V2?=
 =?utf-8?B?RmYvNHBYQm42b0pKbVdVUS90cHcvNFlFSmpZa1BGOG5xNExvRHBnSEtPU2dQ?=
 =?utf-8?B?U0VabjY0aGNoS1J2akw0T1Mxam5FdW9IcDNZMzd3QVVGMzVIK1RjSFFIRzVX?=
 =?utf-8?B?RFJxdHRMSHgyREx0TTBNUVBOTUtNRThnUGJBWUp6VVVrSFd2eHN3Ym9ZNjBZ?=
 =?utf-8?B?ZWFOajhRZCt5a05Lc1gwdHpoQWhQdHdqZWxGMHNteEZHOGxRZ2pkK0w3Wjla?=
 =?utf-8?B?Rk9FVjdwdkU5Ui9WRDgrcUlYTVIreVVnRDdyV2VpRGVwQ0RiNEZ4dTBvUVpa?=
 =?utf-8?B?Z2J6QWxnUVNXUCsvRDRlR3QyQVp4ZHlNTXdEWFpuNnVqZXpRdSttcXdWZGlZ?=
 =?utf-8?B?dzRyRVp0MTluM2xWYW55YjNFMXUzenBjd3EvS2pIMG1QWnZnTkExZkxISTlQ?=
 =?utf-8?B?YnVJVTl0Q0UvSEE4MGYvcHlwbU5OTUd0MGxxZzJ1czNnazA4SlNDUEZkdElP?=
 =?utf-8?B?YjFQZFE2UFlGbFhTQzYvNjBQUTVSZExRaW5TT1dXWmZPK2FxRjlIcm1ZSCtH?=
 =?utf-8?B?QUNXeHQzZEx4TTFTdzF4NUFMNXVzZC9xR2JSRmV2QWFPYWhsYlJzYjQ1L2g3?=
 =?utf-8?B?T0oxR3NVNVA5Vm40dUloc0loSFVrRHI2eTY3bmVJUm92QmZ3ZjBwVWZWYTY0?=
 =?utf-8?B?M3Ywc0c0MVMxZlR2blZaSXBuYkJIRHhuMUlQQlhiVlA3aWZyOTg4a0xMYmZi?=
 =?utf-8?B?RVdBNXJBNjRoTStYR0ZUZ1hsYzdsMG1HMXVSZkRkTzdKdW5MdzFVaUdDM1VJ?=
 =?utf-8?B?bWNsSnFWTTB1clNIS2Z5TVVCMGczQi9rT0FDb2NzUU9kTmlXRm93VXMycE5F?=
 =?utf-8?B?VTkyYWhDZFQ4bHdHUDFMdm1acGY3bXhLclkyL0hRQ1dscDNoSjhjMHRwaWwy?=
 =?utf-8?B?S0U3N0M4ZGRFcFlrWlRaZi9QZEdEbkt4THZwQjc0V1VNNFd4VjVVTURWZmY3?=
 =?utf-8?B?Nkh6WjdlQTFaYVFGNUZvNjQ4em5aZnlCS3A0cUpRSjRFL3pqeitOYnJZSFJ6?=
 =?utf-8?B?QW1jdEVHNW9HZXNUcEh4L2lkeU9NU1JNSG8rY3ZlMCsvTUpaV0lzeC9ST0Rl?=
 =?utf-8?B?eCs5ZXZpOVVOdjRKSExKS0I5aEd3UmgwTHFwN1owNFBiRFVCaTVMMmdZYjU5?=
 =?utf-8?B?eCtRMndsM2dRc2FZNE1KK1NBcExqVEt2aE55OGNqWW1TVTRuVWwzWU1SZW8w?=
 =?utf-8?B?SHgwWTJ6OWJMWnlrcytqaSs5ekd0MFJGSiszbWdjOWZZTjMzekJ6WHRNTTJM?=
 =?utf-8?B?RlI2Y1c1UWJRb2pVLzBJTk1DSVRnRzVBWkd6WHVicll0bEszU1I5aDlFZjJF?=
 =?utf-8?B?UzFidVQzbURXNEp1Z2ppWUppd3duVDM3YkNVQUpGYzYrVzRka2pUR3VUWjZn?=
 =?utf-8?B?dWlXODFNZVBGR2pTa1llR0RBaHBVRmRJYnl4V0ZiK2pINlRmNUxLTFdtVWRL?=
 =?utf-8?B?d0ZQbmdDaytPRWdTT280VktDUVYxQUVRRnJFSWVJTGJJOXVTZFFjUTFxa2Q4?=
 =?utf-8?B?UldiYlNON0grbkhQaTQ5VnYyQ1V0MlFnbUFXSi9vNVdtM3V1b2VyUDlHWlkx?=
 =?utf-8?B?WFZHZjkrNlY3RmJERHp4eVoxNVJ3NzVjdHBzNGtCM2dhUHo5R0xJRmxuVnlG?=
 =?utf-8?B?bVA3WUx3bkNYcjdjK0owUWpqemdjSFdLZERPc28rVTBtV3ZYdVlyOGdVenNa?=
 =?utf-8?B?T0RVQWxHWElEckVQNmNwMTFpbHE0SUhOVVljVEQ0RnlER3htb1dkNHByWVlB?=
 =?utf-8?B?NkNBSzFZOTAzVkFsaUlBQkR2MUp6SlFGQ3dNV043bUJuY1h6K2dTVS9GNmYx?=
 =?utf-8?B?NDhJWFBrTXMvcXV5THBGZlVxZldnSFM0YjRoOTQ1eXVwSnJpbkRoR1p3MERh?=
 =?utf-8?B?SDdaL2U3NGprdXcrSmtNMVJtdisrU2Y3TTFqUDgvNUtlUndLSXdyM0ZPdmtS?=
 =?utf-8?B?Q2Z1MVNhT29YVUFxRUI5c1BwZDVmbFBadDBWT0Q4NU03enREbHJ6dkE5cWlD?=
 =?utf-8?Q?K3w1/ceWX7FW2DfAwC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4ab74d-815e-4784-411e-08de962d1ae7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:42:40.4486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUY/E0WHcT+Rb/KkrE1gBBx05gLH6ObROEnOE2+Xe8WBdw+wvYb1w0i4fy97UQbk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9708
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

On 4/9/26 02:05, Geramy Loveless wrote:
> When an AMD GPU behind a Thunderbolt PCIe tunnel undergoes a MODE1 on
> Thunderbolt the TB driver receives no notification and the tunnel
> stays up while the endpoint is unreachable.

IIRC a MODE1 reset should keep the bus active and so the endpoint should still be reachable.

> All subsequent PCIe
> reads return 0xFFFFFFFF and MES firmware cannot reinitialize,
> triggering an infinite reset loop that hangs the system.

That sounds more like the MODE1 reset failed.

> After MODE1 reset completes, check whether the PCIe endpoint is still
> reachable using pci_device_is_present(). If the device is behind
> Thunderbolt and the link is dead, walk up parent bridges calling
> pci_bridge_secondary_bus_reset() to retrain the physical PCIe link
> inside the dock.

Well that is then a bus reset.

I mean that is a reasonable mitigation when a MODE1 reset failed, but the question is rather why does the MODE1 reset fails in the first place?

> If recovery fails, return -ENODEV to prevent the
> reset retry loop.
> 
> This also causes the GPU fan to be at 100% and basically when it
> happens and you are not there, you now have a GPU with fan at 100% and
> cant reset it.
> I wanted to notate some other things I am finding sometimes before
> this adventure of patches to the kernel and amdgpu driver.
> Sometimes a crash could happen in the drive and then the GPU fan speed
> hits 100% and the air is hot coming out without any workload, other
> times
> I have seen it have barely any fan speed at all and heat up more than
> it should at the fan level its curently operating at. These are things
> I have seen with this gpu in a TB5 dock with the driver and
> instability. I'm not sure exactly whats going on there but I figured
> since im communicating with these patches I might as well bring you up
> to speed and supermario has been great help throughout me trying to
> get the AMD AI R9700 Pro working on my MS-S1 Halo Strix with a TB5 /
> USB4v2 dock!

Adding Mario as well. That strongly sounds like you crashed the SMU which would also explain the failed MODE1 reset.

But all of that are only symptoms. Question is what is actually going on here? e.g. what is the root cause?

> 
> It seems to be finally working with bar resizing after my kernel
> patch. Which allows you to safely release a empty switch bridge at the
> device end.
> Then it rebuilds it afterwords with the increased bar. This was done
> on Kernel 7.0-rc7 i believe it is and latest changes from pci/resource
> branch with my patch here.
> 
> https://lore.kernel.org/linux-pci/CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com/T/#u

Where is the MMIO register BAR before and after the rebuild?

Regards,
Christian.

> 
> Thank you!
> 
> Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
> ---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 40 ++++++++++++++++++++++
> 1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 31a60173c..91d01d538 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5770,6 +5770,46 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
> /* ensure no_hw_access is updated before we access hw */
> smp_mb();
> + /*
> + * On Thunderbolt-attached GPUs, MODE1 reset kills the PCIe
> + * endpoint but the TB tunnel stays up unaware. Detect the
> + * dead link and attempt recovery by resetting parent bridges
> + * to retrain the physical PCIe link inside the dock.
> + */
> + if (!pci_device_is_present(adev->pdev) &&
> + pci_is_thunderbolt_attached(adev->pdev)) {
> + struct pci_dev *bridge;
> + bool recovered = false;
> +
> + dev_info(adev->dev,
> + "PCIe link lost after mode1 reset, attempting Thunderbolt recovery\n");
> +
> + bridge = pci_upstream_bridge(adev->pdev);
> + while (bridge && !pci_is_root_bus(bridge->bus)) {
> + dev_info(adev->dev,
> + "attempting link recovery via %s\n",
> + pci_name(bridge));
> + pci_bridge_secondary_bus_reset(bridge);
> + msleep(100);
> + if (pci_device_is_present(adev->pdev)) {
> + recovered = true;
> + break;
> + }
> + bridge = pci_upstream_bridge(bridge);
> + }
> +
> + if (!recovered) {
> + dev_err(adev->dev,
> + "Thunderbolt PCIe link recovery failed\n");
> + ret = -ENODEV;
> + goto mode1_reset_failed;
> + }
> +
> + dev_info(adev->dev,
> + "Thunderbolt PCIe link recovered via %s\n",
> + pci_name(bridge));
> + }
> +
> amdgpu_device_load_pci_state(adev->pdev);
> ret = amdgpu_psp_wait_for_bootloader(adev);
> if (ret)
> --
> 2.51.0

