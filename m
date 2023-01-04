Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3F7C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 15:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE0810E51D;
	Wed,  4 Jan 2023 15:33:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 139DB10E51D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 15:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hicsIMbj/TxmEmdGJ/4PD0WQi6yCaEswGuMjNOpXicyib13K+LAXfjLqmvJcRh049rfgglumaAOQxEioMlYmoQF7S3LVcLI/VyKIBtNDmZjLMJu7h+OM0N5Za4AvwLqQZ7v+ClHX3vBva4mJlhSZUV6zN4HI2JKbL9WqoPOTMmCl89LU6crbeIVrsVeHEgtw/i/4UnQacESM9foASXX+rjIE0fgs+vcMTal7LXYfuIs62nDz0o7C0dybaskDK7uEWnHCEMZk0RCLAH7WHEoS77qOS94I4ChgACwERDxEfdkGsTtbS7vifadDA0rtx9mAGzWBEzKlexls6TNYzsS0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHDvmO0lw+vcTNti6OlB2+zc9uXEefGFngEe+ACqdB0=;
 b=F2DNpV7OnrFYykbeaGeMn8Et50qOxsizIdnR9aM0uuWxtlld8sKBgGEi6c+/SGoi/GCV9oesFwunyGlUar5CCdvBVPM7g7h+DgYDH3fkxKNLWoiPEUzglWFI1imqYMSHCTlYLnylfJ1Sp/YJdu6uS8ys6/8LntSd9wmkcpMXdfMBWej5vH7rg7L6/r71mU1k+4k+a2+e6NfjaeNUg4hG/2nVTh+/ySGh2HFzGP+CXvPdgRcNq9nKcTYr6ziP//C7cXfJMrXexGtZ8wH027oP15EOqeJPfPsQq7SK/ZO3qLm5SiDHriIvTFTl/XYTyqQyfxkB951r0GHab0kVEwGynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHDvmO0lw+vcTNti6OlB2+zc9uXEefGFngEe+ACqdB0=;
 b=HoonNGjXhUBl10dum2i+R+vfetCsl3uocJb3nqER3PKtcEcGb/c/+SadeAqQf+Ia4Y/G83teT9lNoGhWwB07PEbMYTOuc6IPoWwrgNTjKjc1kEUjTLmnwk7k8T76UuZU/yONNzqin5dkA0Js4gK6LJ7P6pxdD+Wjl/s/vaD0xp4=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 15:33:30 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::457b:5c58:8ad2:40fa%6]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 15:33:30 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: =?Windows-1252?Q?Marek_Ol=9A=E1k?= <maraeo@gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
Thread-Topic: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
Thread-Index: AQHZHJtWPM16i7xpP0emRdK+37HfTK6LS7wAgAAh4YCAAPS2AIAA7ZWAgADcRACAACgWgIAAAXuAgAAORgCAAAZNKA==
Date: Wed, 4 Jan 2023 15:33:30 +0000
Message-ID: <BYAPR12MB461473D2083BC8B9FB012AC297F59@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
 <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
 <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
 <CAAxE2A7PJdiPORP-X+7kFmix9pCo63PqeamP20BZJx4GDfJdEQ@mail.gmail.com>
 <8ec2b238-fa8b-a693-b9d9-3a590cc05664@amd.com>
 <CAAxE2A7G_gjvuGNNtZ6J-4R25Ykx8ziz1B2f0Dc3KuC4KeYdzA@mail.gmail.com>
In-Reply-To: <CAAxE2A7G_gjvuGNNtZ6J-4R25Ykx8ziz1B2f0Dc3KuC4KeYdzA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-04T15:32:32.5064224Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|CH3PR12MB8187:EE_
x-ms-office365-filtering-correlation-id: fd246728-1fd7-4ea0-2415-08daee69085d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PILubJ8w3HrdtYYZnUwPYSLJ1XyXE9U5HueeKjZpI7TE5pa20ZF2RawH+zVtfd9g8rKoazsn8ade5P7nqDGfylHmbdjRswQ3wVde9vRNsZJlXZrXqb1Bw99wj2RkRFhU8CoJ3E34FCwqrSxaIc+BaWnReSwPUkdB7uzm1AZPD48Mx+Ffs0ajyfj84I9zLeM4aJA18zG5Uf/9h4erg9YcYXblnotoYq1a4PMrmydf1KPQBcA3YO8mBkwKHVYpM7JLXtZj/HvH3Ir7eHvmRe0RJOd5jSFP0CYemBBQi1ueH3t5vz7eXrg8boCynnVPcBZG22l/rpYUnLmH6JJtFoNlbwbV5FuK3SDnsGMLztYcc/IKs/9AuCDWefBVZOcBy822tSr560fAfnM8bsXrtLmOtCW+B315frXt1C73uH7w+edCG6fG6F40HUe1asw5qmIYiErIwgjsO/X8/apCQzy1Tx881pyF0KsJdO58LAAPvXShQ9ioJccwewEEkwj8kpD3a8lY6YOEKzAx2uUKV32Kfyqyui1ZhWIYSlwHMB/pBug4ZVjd1QUT8PUaat9toG+mEGpotxAqVdivthN3CBMybOg2nmBHlyFeoOhSg5WdVYGkYnfkYH6fciQD2y1Mpto3r7ifSmSUsIbdzPdeQmz+PGJ5FyNdoHVJIImmfhQZmztcDhCmI+7MWSKtvp3BqkIp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(83380400001)(55016003)(86362001)(122000001)(33656002)(38070700005)(316002)(38100700002)(6916009)(2906002)(66946007)(8936002)(4326008)(52536014)(41300700001)(66556008)(76116006)(66446008)(64756008)(91956017)(8676002)(5660300002)(66476007)(26005)(53546011)(186003)(9686003)(478600001)(71200400001)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?iNb0tHmI2x6wmeNj6jQc5U8w5VQtrPsm65FTp0UoODWXjOESlzTesuxf?=
 =?Windows-1252?Q?W0o+YsU50gh03zDGIXB49dljd5EIFnvDnipR4gScRxjpOrzhG/i9m2AZ?=
 =?Windows-1252?Q?E45K/xZ2hVmEveq7Meme4V+WxcsOXgjDHFSvJ8LsXxQddR2MaNsczbKg?=
 =?Windows-1252?Q?TQdIRGke9m4M5ZfmHdO6zowswTo788ZqHIYI2cRNsnOa/buU/dL0XFXk?=
 =?Windows-1252?Q?LSgXBSXG5kX1yX8iYQArHKxru7pI9JmOCWyKzhP+Nwf/8P44IeOMSTie?=
 =?Windows-1252?Q?knpvUC9ZYXrmM297Cnl9l/kdUeBkaCDqXuN21jejC/qymzVkusaYErGj?=
 =?Windows-1252?Q?AjbLzig3Ypw3n36kkq3wSKz0TuaU4XRuQzTdP8sQAJvDlZqQ81/CwljA?=
 =?Windows-1252?Q?UjlJdKqP8u7i2B1JET93K4mepers2Z1NAXkZpLLz+tvDHwqYnKLC7utV?=
 =?Windows-1252?Q?Zh7yMadRSR7MI224RF7uCYR8DfPGXNYgrPZ1aw5GrCzYCuUF1CyDhSiD?=
 =?Windows-1252?Q?mKw2/zw5xVLHz0ifNk5zHKj2MIOMkvTuLArJU7C09WZCemG2QmTpQ0/X?=
 =?Windows-1252?Q?wyFoqp1TSzxecLroQUrgpPfdYN2Kb6wxJAZ3B8/LEIPHXBlkJWuUrE3b?=
 =?Windows-1252?Q?KUsEWvUXusa2S4pyVgwG7BltrYZxTJYM76vEssICTVIiHX8CU+MyQYDX?=
 =?Windows-1252?Q?ZYnknHQ2RMTPujFTHaai3WtL8rB0m7vUrNsOnnJsUSaZkJzvKRbmsSmc?=
 =?Windows-1252?Q?q9k6PZ9d6bMXOJkt8CaFOmAIpqWrHYQ85zEq2/xJ0DAvsC5LY7bTItUQ?=
 =?Windows-1252?Q?tcKb3PvS0fn+3AlUsg3PdtNeoSwoO4hpXrv/duXWBZFjd0UfVEtZ2RDn?=
 =?Windows-1252?Q?4bMv35WHJs/Yn5Px2aLZOMnjXig5hUpx1qHDFNPXCTV2P4pv/iWkUY2p?=
 =?Windows-1252?Q?NeyGdFZsm4Cl8Chsm+BshMr/nfHa+KyPj+LW1fn5HCEuoqzYNjX1NCCk?=
 =?Windows-1252?Q?WeDMVKpfim0xSWACrt82WAbmmzn+PNiYF5eP1p65liSDOX9EfIYguM9n?=
 =?Windows-1252?Q?iP+5XiZOYWLjsw0K+ZFkwgi+KdUlati8ofMceu5o5Li2cMMUP8VEhNmr?=
 =?Windows-1252?Q?C8lgxxEJbTYY+Spk0dTv6rLzYbL9fJkqtDTLBFNCMcRrrEtRRIePGVqU?=
 =?Windows-1252?Q?IynEjvX2a9b161qfPkqVuI9ByWQpkuu+i8tWmygGGMTVOiBsniXphyaQ?=
 =?Windows-1252?Q?T8lILOH1fXpmvvxMjMgcN9yUMf0yWZEhYKnOjTlesUbZvmMLRydJ8s4C?=
 =?Windows-1252?Q?cLte2VAC1HktEw4n/6cCXTgVQGns+0BbU+neGvPEjZaNhUVeSWdGzbZt?=
 =?Windows-1252?Q?EmvZIxYEnP8OXrzVPXBgR8J02U77NFAbdmWirwMtokzIKvuZPmcwk3Ve?=
 =?Windows-1252?Q?YAp4+u+mMsl23H2zIMoRVp95Jwc8MHIrVmJMgQfN6qlNFVx1OCx6E6CM?=
 =?Windows-1252?Q?1QtrURT31V1K1m1adYFDrPGwvFxPTw2jd8fWoVS3zifl4v6SJhO6mENM?=
 =?Windows-1252?Q?1sXxc5n8F/hfZdJObOCTefQkttktYXJBsrehZSl27vJ0qAv9ePLCXunY?=
 =?Windows-1252?Q?CEiEQjg+O8/MhwnK+SVuAGBpheZHRaisdCIOSyGsM9wC3gl2kiGDiy5d?=
 =?Windows-1252?Q?Zdr3GKmTbBBHVakYqvzLwW82vCmwh69I?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB461473D2083BC8B9FB012AC297F59BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd246728-1fd7-4ea0-2415-08daee69085d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 15:33:30.5488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s9lbHHS1x9cebB7KFxqvR1tU9ACZft5y/U1logEN23LS87QwoMv5f+7dUuxrvUJe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB461473D2083BC8B9FB012AC297F59BYAPR12MB4614namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

To clarify, with DPM in place, the current bandwidth will be changing based=
 on the load.

If apps/umd already has a way to know the current bandwidth utilisation, th=
en possible maximum also could be part of the same API. Otherwise, this onl=
y looks like duplicate information. We have the same information in sysfs D=
PM nodes.

BTW, I don't know to what extent app/umd really makes use of this. Take tha=
t memory frequency as an example (I'm reading it as 16GHz). It only looks l=
ike a spec sheet.

Thanks,
Lijo
________________________________
From: Marek Ol=9A=E1k <maraeo@gmail.com>
Sent: Wednesday, January 4, 2023 8:40:00 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the=
 INFO

On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo <lijo.lazar@amd.com<mailto:lijo.=
lazar@amd.com>> wrote:


On 1/4/2023 7:43 PM, Marek Ol=9A=E1k wrote:
> On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com<mailto:lij=
o.lazar@amd.com>
> <mailto:lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>>> wrote:
>
>
>
>     On 1/4/2023 4:11 AM, Marek Ol=9A=E1k wrote:
>      > I see. Well, those sysfs files are not usable, and I don't think i=
t
>      > would be important even if they were usable, but for completeness:
>      >
>      > The ioctl returns:
>      >      pcie_gen =3D 1
>      >      pcie_num_lanes =3D 16
>      >
>      > Theoretical bandwidth from those values: 4.0 GB/s
>      > My DMA test shows this write bandwidth: 3.5 GB/s
>      > It matches the expectation.
>      >
>      > Let's see the devices (there is only 1 GPU Navi21 in the system):
>      > $ lspci |egrep '(PCI|VGA).*Navi'
>      > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
>     10 XL
>      > Upstream Port of PCI Express Switch (rev c3)
>      > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
>     10 XL
>      > Downstream Port of PCI Express Switch
>      > 0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>      > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)
>      >
>      > Let's read sysfs:
>      >
>      > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width
>      > 16
>      > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width
>      > 16
>      > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width
>      > 16
>      > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
>      > 2.5 GT/s PCIe
>      > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
>      > 16.0 GT/s PCIe
>      > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
>      > 16.0 GT/s PCIe
>      >
>      > Problem 1: None of the speed numbers match 4 GB/s.
>
>     US bridge =3D 2.5GT/s means operating at PCIe Gen 1 speed. Total
>     theoretical bandwidth is then derived based on encoding and total
>     number
>     of lanes.
>
>      > Problem 2: Userspace doesn't know the bus index of the bridges,
>     and it's
>      > not clear which bridge should be used.
>
>     In general, modern ones have this arch=3D US->DS->EP. US is the one
>     connected to physical link.
>
>      > Problem 3: The PCIe gen number is missing.
>
>     Current link speed is based on whether it's Gen1/2/3/4/5.
>
>     BTW, your patch makes use of capabilities flags which gives the maxim=
um
>     supported speed/width by the device. It may not necessarily reflect t=
he
>     current speed/width negotiated. I guess in NV, this info is already
>     obtained from PMFW and made available through metrics table.
>
>
> It computes the minimum of the device PCIe gen and the motherboard/slot
> PCIe gen to get the final value. These 2 lines do that. The low 16 bits
> of the mask contain the device PCIe gen mask. The high 16 bits of the
> mask contain the slot PCIe gen mask.
> + pcie_gen_mask =3D adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_mask >> 1=
6);
> + dev_info->pcie_gen =3D fls(pcie_gen_mask);
>

With DPM in place on some ASICs, how much does this static info help for
upper level apps?

It helps UMDs make better decisions if they know the maximum achievable ban=
dwidth. UMDs also compute the maximum memory bandwidth and compute performa=
nce (FLOPS). Right now it's printed by Mesa to give users detailed informat=
ion about their GPU. For example:

$ AMD_DEBUG=3Dinfo glxgears
Device info:
    name =3D NAVI21
    marketing_name =3D AMD Radeon RX 6800
    num_se =3D 3
    num_rb =3D 12
    num_cu =3D 60
    max_gpu_freq =3D 2475 MHz
    max_gflops =3D 19008 GFLOPS
    l0_cache_size =3D 16 KB
    l1_cache_size =3D 128 KB
    l2_cache_size =3D 4096 KB
    l3_cache_size =3D 128 MB
    memory_channels =3D 16 (TCC blocks)
    memory_size =3D 16 GB (16384 MB)
    memory_freq =3D 16 GHz
    memory_bus_width =3D 256 bits
    memory_bandwidth =3D 512 GB/s
    pcie_gen =3D 1
    pcie_num_lanes =3D 16
    pcie_bandwidth =3D 4.0 GB/s

Marek

--_000_BYAPR12MB461473D2083BC8B9FB012AC297F59BYAPR12MB4614namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span dir=3D"auto" style=3D"font-size: 16px; background-color: rgb(255, 255=
, 255); color: rgb(33, 33, 33);">To clarify, with DPM in place, the current=
 bandwidth will be changing based on the load.&nbsp;<span></span></span>
<div dir=3D"auto" style=3D"font-size: 16px; background-color: rgb(255, 255,=
 255); color: rgb(33, 33, 33);">
<br>
</div>
<div dir=3D"auto" style=3D"font-size: 16px; background-color: rgb(255, 255,=
 255); color: rgb(33, 33, 33);">
If apps/umd already has a way to know the current bandwidth utilisation, th=
en possible maximum also could be part of the same API. Otherwise, this onl=
y looks like duplicate info<span>rmation. We have the same information in s=
ysfs DPM nodes.</span></div>
<div dir=3D"auto" style=3D"font-size: 16px; background-color: rgb(255, 255,=
 255); color: rgb(33, 33, 33);">
<span><br>
</span></div>
<div dir=3D"auto" style=3D"font-size: 16px; background-color: rgb(255, 255,=
 255); color: rgb(33, 33, 33);">
<span>BTW, I don't know to what extent app/umd really makes use of this. Ta=
ke that memory frequency as an example (I'm reading it as 16GHz). It only l=
ooks like a spec sheet.</span></div>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Marek Ol=9A=E1k &lt;m=
araeo@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, January 4, 2023 8:40:00 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes f=
rom the INFO</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">On Wed, Jan 4, 2023 at 9:19 AM Laza=
r, Lijo &lt;<a href=3D"mailto:lijo.lazar@amd.com">lijo.lazar@amd.com</a>&gt=
; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; bord=
er-left:1px solid rgb(204,204,204); padding-left:1ex">
<br>
<br>
On 1/4/2023 7:43 PM, Marek Ol=9A=E1k wrote:<br>
&gt; On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo &lt;<a href=3D"mailto:lijo.=
lazar@amd.com" target=3D"_blank">lijo.lazar@amd.com</a>
<br>
&gt; &lt;mailto:<a href=3D"mailto:lijo.lazar@amd.com" target=3D"_blank">lij=
o.lazar@amd.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt;&nbsp; &nbsp; &nbsp;On 1/4/2023 4:11 AM, Marek Ol=9A=E1k wrote:<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; I see. Well, those sysfs files are not usable=
, and I don't think it<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; would be important even if they were usable, =
but for completeness:<br>
&gt;&nbsp; &nbsp; &nbsp; &gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; The ioctl returns:<br>
&gt;&nbsp; &nbsp; &nbsp; &gt;&nbsp; &nbsp; &nbsp; pcie_gen =3D 1<br>
&gt;&nbsp; &nbsp; &nbsp; &gt;&nbsp; &nbsp; &nbsp; pcie_num_lanes =3D 16<br>
&gt;&nbsp; &nbsp; &nbsp; &gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; Theoretical bandwidth from those values: 4.0 =
GB/s<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; My DMA test shows this write bandwidth: 3.5 G=
B/s<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; It matches the expectation.<br>
&gt;&nbsp; &nbsp; &nbsp; &gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; Let's see the devices (there is only 1 GPU Na=
vi21 in the system):<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; $ lspci |egrep '(PCI|VGA).*Navi'<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; 0a:00.0 PCI bridge: Advanced Micro Devices, I=
nc. [AMD/ATI] Navi<br>
&gt;&nbsp; &nbsp; &nbsp;10 XL<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; Upstream Port of PCI Express Switch (rev c3)<=
br>
&gt;&nbsp; &nbsp; &nbsp; &gt; 0b:00.0 PCI bridge: Advanced Micro Devices, I=
nc. [AMD/ATI] Navi<br>
&gt;&nbsp; &nbsp; &nbsp;10 XL<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; Downstream Port of PCI Express Switch<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; 0c:00.0 VGA compatible controller: Advanced M=
icro Devices, Inc.<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6=
900 XT] (rev c3)<br>
&gt;&nbsp; &nbsp; &nbsp; &gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; Let's read sysfs:<br>
&gt;&nbsp; &nbsp; &nbsp; &gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; $ cat /sys/bus/pci/devices/0000:0a:00.0/curre=
nt_link_width<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; 16<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; $ cat /sys/bus/pci/devices/0000:0b:00.0/curre=
nt_link_width<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; 16<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; $ cat /sys/bus/pci/devices/0000:0c:00.0/curre=
nt_link_width<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; 16<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; $ cat /sys/bus/pci/devices/0000:0a:00.0/curre=
nt_link_speed<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; 2.5 GT/s PCIe<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; $ cat /sys/bus/pci/devices/0000:0b:00.0/curre=
nt_link_speed<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; 16.0 GT/s PCIe<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; $ cat /sys/bus/pci/devices/0000:0c:00.0/curre=
nt_link_speed<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; 16.0 GT/s PCIe<br>
&gt;&nbsp; &nbsp; &nbsp; &gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; Problem 1: None of the speed numbers match 4 =
GB/s.<br>
&gt; <br>
&gt;&nbsp; &nbsp; &nbsp;US bridge =3D 2.5GT/s means operating at PCIe Gen 1=
 speed. Total<br>
&gt;&nbsp; &nbsp; &nbsp;theoretical bandwidth is then derived based on enco=
ding and total<br>
&gt;&nbsp; &nbsp; &nbsp;number<br>
&gt;&nbsp; &nbsp; &nbsp;of lanes.<br>
&gt; <br>
&gt;&nbsp; &nbsp; &nbsp; &gt; Problem 2: Userspace doesn't know the bus ind=
ex of the bridges,<br>
&gt;&nbsp; &nbsp; &nbsp;and it's<br>
&gt;&nbsp; &nbsp; &nbsp; &gt; not clear which bridge should be used.<br>
&gt; <br>
&gt;&nbsp; &nbsp; &nbsp;In general, modern ones have this arch=3D US-&gt;DS=
-&gt;EP. US is the one<br>
&gt;&nbsp; &nbsp; &nbsp;connected to physical link.<br>
&gt; <br>
&gt;&nbsp; &nbsp; &nbsp; &gt; Problem 3: The PCIe gen number is missing.<br=
>
&gt; <br>
&gt;&nbsp; &nbsp; &nbsp;Current link speed is based on whether it's Gen1/2/=
3/4/5.<br>
&gt; <br>
&gt;&nbsp; &nbsp; &nbsp;BTW, your patch makes use of capabilities flags whi=
ch gives the maximum<br>
&gt;&nbsp; &nbsp; &nbsp;supported speed/width by the device. It may not nec=
essarily reflect the<br>
&gt;&nbsp; &nbsp; &nbsp;current speed/width negotiated. I guess in NV, this=
 info is already<br>
&gt;&nbsp; &nbsp; &nbsp;obtained from PMFW and made available through metri=
cs table.<br>
&gt; <br>
&gt; <br>
&gt; It computes the minimum of the device PCIe gen and the motherboard/slo=
t <br>
&gt; PCIe gen to get the final value. These 2 lines do that. The low 16 bit=
s <br>
&gt; of the mask contain the device PCIe gen mask. The high 16 bits of the =
<br>
&gt; mask contain the slot PCIe gen mask.<br>
&gt; + pcie_gen_mask =3D adev-&gt;pm.pcie_gen_mask &amp; (adev-&gt;pm.pcie_=
gen_mask &gt;&gt; 16);<br>
&gt; + dev_info-&gt;pcie_gen =3D fls(pcie_gen_mask);<br>
&gt; <br>
<br>
With DPM in place on some ASICs, how much does this static info help for <b=
r>
upper level apps?<br>
</blockquote>
<div><br>
</div>
It helps UMDs make better decisions if they know the maximum achievable ban=
dwidth. UMDs also compute the maximum memory bandwidth and compute performa=
nce (FLOPS). Right now it's printed by Mesa to give users detailed informat=
ion about their GPU. For example:<br>
</div>
<div class=3D"x_gmail_quote"><br>
</div>
<div class=3D"x_gmail_quote">$ AMD_DEBUG=3Dinfo glxgears<br>
Device info:<br>
&nbsp; &nbsp; name =3D NAVI21<br>
&nbsp; &nbsp; marketing_name =3D AMD Radeon RX 6800<br>
&nbsp; &nbsp; num_se =3D 3<br>
&nbsp; &nbsp; num_rb =3D 12<br>
&nbsp; &nbsp; num_cu =3D 60<br>
&nbsp; &nbsp; max_gpu_freq =3D 2475 MHz<br>
&nbsp; &nbsp; max_gflops =3D 19008 GFLOPS<br>
&nbsp; &nbsp; l0_cache_size =3D 16 KB<br>
&nbsp; &nbsp; l1_cache_size =3D 128 KB<br>
&nbsp; &nbsp; l2_cache_size =3D 4096 KB<br>
&nbsp; &nbsp; l3_cache_size =3D 128 MB<br>
&nbsp; &nbsp; memory_channels =3D 16 (TCC blocks)<br>
&nbsp; &nbsp; memory_size =3D 16 GB (16384 MB)<br>
&nbsp; &nbsp; memory_freq =3D 16 GHz<br>
&nbsp; &nbsp; memory_bus_width =3D 256 bits<br>
&nbsp; &nbsp; memory_bandwidth =3D 512 GB/s<br>
&nbsp; &nbsp; pcie_gen =3D 1<br>
&nbsp; &nbsp; pcie_num_lanes =3D 16<br>
&nbsp; &nbsp; pcie_bandwidth =3D 4.0 GB/s</div>
<div class=3D"x_gmail_quote"><br>
</div>
<div class=3D"x_gmail_quote">Marek<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB461473D2083BC8B9FB012AC297F59BYAPR12MB4614namp_--
