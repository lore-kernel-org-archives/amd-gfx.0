Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D034CD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 10:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D0410EF8A;
	Wed, 17 Jun 2026 10:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hiI7NHa5";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFE610EF8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 10:31:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJTGYS4j1iR9MDyx30fxhgx3zjJDrsukvejAIaPYEM2gorAI7FGlCr7GJEAgsKO4tNolTJd5x7FHbzwoSaJPqae1HJzMmQLFqQe8SQ3+5MT8RzI6hyQGPjHO7K+4Op0Xz7gQ8LFBH+2vquHbeZYhcD3gVfipBRw2bS77GYBFkNKKcX/AghnCUJEK3Qz+Pn+CLtjYafBtcK4b2oc/C9E6YoTxvk7UNJ3n5N2zx5SUbohYdVpTwCNGNRMz1iyhEDwTQGd5d9QoKDxxr+aF8lye5SLhEp7mrn+qQPkDEUPU3JlUJm3WkkQDuwSULHEDOrZxMTi/94GLa2OQK8iaD9eYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j88eh/nYIZSYaXm7sx6KhGe6lJ0FGEmh9wucHkSWxr4=;
 b=yFxw6Gk2PtHO+ybaqUlafCt/xrXrSwAqwAsnoABCkBD+q43L84bW5KW7HhuWtSuhB5SWzov65IzKsnIiS7jBGU3u8JsL9eIG9mKRDZzQoSBkFVmYkqRRfjCq05t9n+nrod/ZcNPVh6MSfLTTYv3gPfVmwaE6uFPAs2aRK0H8MUfJlU0OfPl8JTBRmkyDN/9UDodNAXWhMroCG/2tNNmlfcyqa/8DkWqvV15MvaMPFy6l2BfgTbM3JsR2UCmHRfiwDtXhUD4ZWBaLJdtx4gu+ReJ+ZBznrKXnSB4Fwixd3xVnghMfQTfExbonY5EqTEdSfH1o4OCTO41ecRogG4KLfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j88eh/nYIZSYaXm7sx6KhGe6lJ0FGEmh9wucHkSWxr4=;
 b=hiI7NHa5BVUQEsCZqnAnz21ndA0br0ZWLC/XuTVdsrg30xeyHXibO7b5VWe9Ec7a/OsTVdzV6BOc13LmAPiYhTVA6w3wTcy310OVovRP4vlSsN6yE+uEWvArfEXye/DmEFzOiWOtn5VN7qzzf0jlwkPgKndJ+Cie+Z7O/EKYMqk=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Wed, 17 Jun
 2026 10:31:04 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0113.013; Wed, 17 Jun 2026
 10:31:04 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Guard reads in pcie state readout
Thread-Topic: [PATCH] drm/amdgpu: Guard reads in pcie state readout
Thread-Index: AQHc/jywAeJi6fCJa0epbW8c3vw/lLZCipmQ
Date: Wed, 17 Jun 2026 10:31:04 +0000
Message-ID: <DM6PR12MB2972C8561FA2EE6A75DD1A1982E42@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260617093518.753118-1-lijo.lazar@amd.com>
In-Reply-To: <20260617093518.753118-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-17T10:24:53.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|PH7PR12MB6954:EE_
x-ms-office365-filtering-correlation-id: 982a53ea-f6d8-4264-20da-08decc5b88ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: XOf+GUnpY3BPn5r0ypjx8otD5ZO5F+rTbnr33Wz2wnHUXPTMbs7wz5hd6+uMjBKbeCA4M0rqftVVocwtY4MWvELcCYf4cVsy79Lx24uoyPWtcN/6LCs1mq6HY+kwGbxMsmDKN9C5k/OVT1wGcRmgCQsaWWMqZeTPAVzPbvmDY79JGmRw8dCvCqu+z/Tht5PaUdOyzAE87sAsRrRp/dkgE2TFVH/iFrbHpchO7lsdmjIUwxl6LbgIXaT+7AP91Us3GIIfH7dlr92xfp5HVmIlIrLOquZv/iQLA/tZnpdqciwBZkpJirt1fe1Ajd1LmPIulnU8/+wsyxfisPzkpZ2OBQlXIkFmrZ+v63KsM7rwfU/LuyULShpjhvYN814faskT8Og+2NL5a6ok6c+P07NjuIg8htk7sBnXTn6lABX7n5olhRg6+wgRcXxo3AsDsigeMC2Av4hPHyfP2ymonOWbT12HAornQ4IWHKpEckjhY2U48n7AwFlExnAkBWNgIbZ03+CsitNxaGlfDdHNDHO22cblfy5ZmBZfG4GaDYHYDUaJ5gPVxaejEOi0QrCM8I4p8VGmaUBZEB86bvk6yS/LZe3Q0FWrJy22LM9lbtHFc5s9h/VQzRx0oq/2j01xQw6QVjPZ01MCfhxbW1zGyRdIOxvC32RF/ix3db6/KSmttEsTXbjELz2njwF6m/WIywwx8ehIkiuFf1NKKITNfJkV7JyzzpicvlBMaEObCH6VzMMqYAJ+zu3CpFaCP4vvSZdl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fKDRUn0oazYa78n0wfQBinf8t+hcKm1sEPOVNM/SEP2zM4yO0odZkV6qrBwA?=
 =?us-ascii?Q?EcY935VdDso+qM7/6x+ZWYIHBBQXMI4+23QdOBAxW/lCyNY/AMyVX0fQgcyS?=
 =?us-ascii?Q?suDSJPwiLRNIaJpEDA1O150cLs28kAiwbHBu4++/8+H/cuPpVI34ykAXMw2r?=
 =?us-ascii?Q?28/g6JmSQGuwyjviyGAP2Ylibz5UrsCuTMIJKgdBDsYuYKyk5bW+fNDEqWlm?=
 =?us-ascii?Q?zjFk4TtiH5t5jfP+DmIJD61KYj3JoLGdDF5e7uQOy2ESca6E+udU4Yd5smiy?=
 =?us-ascii?Q?De6IEUnJhNfXrBzUSgK2mpV9J+q9EvvJiM4sClhJDmxr14xuJcuTDoKoyYVZ?=
 =?us-ascii?Q?yjX7Jh99fy7msMfoiM5/D9HW/H+Y78n4S2VKI5q7u7JJuQ1dtzI1zpsGucox?=
 =?us-ascii?Q?4AteuHVFIdZndi6ojs/3e+kod+ScLpm+Ts2Gdd0M9KVQCkzCukxbss7FAonk?=
 =?us-ascii?Q?g5PJDESt5qmWjUZi6a7fbfdmpf1HIlt7mr3K6YhkrsH/O0WH7YgeyRzoe4vt?=
 =?us-ascii?Q?oi7b/zWhkZZeu79tMWth5/rpil5h9fVTrgPQgAZAFZOmpNuOmUoK1b+8AlkT?=
 =?us-ascii?Q?nogK03X7ue0XHydfBMioCPFlRK3lccyaPHjf/DDibXXxycPZw8aHKFk/FZHX?=
 =?us-ascii?Q?Bc6NTQilQ7RNq/r/DConA8uzI3asiWly7yEGWTZDeR2TpskZ/XDznyptNCTk?=
 =?us-ascii?Q?81npcCOJz/RpjVFdbaP7/GGJtJaXoMJqjC4Yy3RwW99l3ACfuKZn2GqRXDd3?=
 =?us-ascii?Q?VZjjZ7uuLU1A7T28x9R/hwqwKCe4brNc/u43YQyIuuJ3iyOxOOqFZz+/lPmJ?=
 =?us-ascii?Q?/TssZJLB6Wck7pCW/fvNFHdjE8lsHqLB7qU6pppkdGWCkvwCwXpa/4pYdXyS?=
 =?us-ascii?Q?ZuvRwpeyhMQmp9dfm7C/LY6RZZYaoZOXPedbbDdWmpwvTpZhOmNvD1PVECwA?=
 =?us-ascii?Q?a+T0aVrIMqLYliJ2ZhWSIq2VfJ4WkWhjyxbOMFHrD4bMMHN3ziS4jPOtnFwo?=
 =?us-ascii?Q?RaUcjIXmx3SpebS8g3YSWlJ7vTriWBZsabLDO7HUGWPxfoF4hc/AsDaUClbk?=
 =?us-ascii?Q?hGjOyvjKItufV/vv0GTH3Jwl5bEtS4Lp9N29p5hu+EjZmMALoWUXwiTXdIHt?=
 =?us-ascii?Q?Bx+yaUQAowDhbSMh5H5Li0ZHKjzM4vDON8NBI1PT17iAxoYTcUtg59mZ/V8H?=
 =?us-ascii?Q?RsfIYCnFv1eCO9kyde27hdDbl7QrBpfNmcpmpgFKF+n3wsqo5ysFXXETVBNf?=
 =?us-ascii?Q?FtadZh5VmDyhiJ+EZPLbjfsVrOI6YJF56F/FEsBuXv83r8ipEj7u0WcOi8JT?=
 =?us-ascii?Q?gMtAeahIONDy5HcgZ3ioiQFnPxhXZ2egpmYuOJPugwfeZFsSHvs3AQNkJu7R?=
 =?us-ascii?Q?m/aMlmfEoKvubFHJlQpAOHWoSfxeQDtQnMX9RP92gmVP+uYIHC1QW1NKm+Ei?=
 =?us-ascii?Q?qm/6dSERrjRxUja8fminDf46csBsi8+TerqAtUK8Xo9WQPMS1LCfkDqBbQhM?=
 =?us-ascii?Q?ZzPtDCRtuJ08HDxW0UuXGvRNGMCoYbKyked/SgggLh1mX6c88KOijkfMunUf?=
 =?us-ascii?Q?YjGodI3P2fhmZQZHIm5koNP6+WaN8v2ufyTy2kTz2OfWnuTKP5pzBpMCZ0Jw?=
 =?us-ascii?Q?eX72hTljsN8/5NOWv+xMTVt/6aMUCADGxsjJM2TIukW229ZxHS2PnY+kCaJE?=
 =?us-ascii?Q?IpdbUqV1b0fC6plNiG3lhhLfhzEYTCufpzVq3DIl+VRD17E2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982a53ea-f6d8-4264-20da-08decc5b88ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 10:31:04.4008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/6n2ELAv9Y4ToFVIZdP3Wjk5AvpBiMOofAE/GBKyeuwiyQBuxOdYpib7+B4IZ2l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954
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

AMD General

The original intent of this function is to collect the real hardware PCIe s=
tate from the AMD GPU's internal upstream/downstream switch ports.

However, under QEMU/VFIO passthrough, the guest-visible PCIe topology and P=
CI config space is virtualized.
QEMU/VFIO can intercept, emulate, or selectively forward PCI config accesse=
s, so the upstream bridge information seen by the guest does not necessaril=
y represent the real hardware topology or state.

Therefore, in a VFIO guest this function no longer has practical meaning fo=
r retrieving real HW PCIe state.
At most, it reads the virtual/emulated PCIe state exposed by QEMU/VFIO, whi=
ch may not reflect the physical device (which depend on the implementation =
of QEMU/VFIO & kernel VFIO Driver source code)

So, I suggest that it is better to hide these interfaces under PT or SRIOV =
mode.

Best Regards,
Kevin

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo L=
azar
> Sent: Wednesday, June 17, 2026 17:35
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: Guard reads in pcie state readout
>
> Internal US/DS switch may not be exposed in passthrough. Guard the upstre=
am port
> reads to avoid a NULL dereference.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 59 +++++++++++++++-------
>  1 file changed, 42 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 72ea37dbfea8..5f1389901504 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -589,6 +589,29 @@ static struct aqua_reg_list pcie_reg_addrs[] =3D {
>       { smreg_0x1A380088, 6, DW_ADDR_INCR },  };
>
> +/*
> + * Return the GPU's internal US switch port, or NULL if it is not
> +visible
> + * (e.g. passthrough) or the EP is parented under an unrelated bridge.
> + */
> +static struct pci_dev *aqua_vanjaram_get_us_pdev(struct amdgpu_device
> +*adev) {
> +     struct pci_dev *ds_pdev, *us_pdev;
> +
> +     ds_pdev =3D pci_upstream_bridge(adev->pdev);
> +     if (!ds_pdev || ds_pdev->vendor !=3D PCI_VENDOR_ID_ATI ||
> +         pci_pcie_type(ds_pdev) !=3D PCI_EXP_TYPE_DOWNSTREAM)
> +             return NULL;
> +
> +     us_pdev =3D pci_upstream_bridge(ds_pdev);
> +     if (!us_pdev ||
> +         (us_pdev->vendor !=3D PCI_VENDOR_ID_ATI &&
> +          us_pdev->vendor !=3D PCI_VENDOR_ID_AMD) ||
> +         pci_pcie_type(us_pdev) !=3D PCI_EXP_TYPE_UPSTREAM)
> +             return NULL;
> +
> +     return us_pdev;
> +}
> +
>  static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
>                                            void *buf, size_t max_size)
>  {
> @@ -596,7 +619,7 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct
> amdgpu_device *adev,
>       uint32_t start_addr, incrx, num_regs, szbuf;
>       struct amdgpu_regs_pcie_v1_0 *pcie_regs;
>       struct amdgpu_smn_reg_data *reg_data;
> -     struct pci_dev *us_pdev, *ds_pdev;
> +     struct pci_dev *us_pdev;
>       int aer_cap, r, n;
>
>       if (!buf || !max_size)
> @@ -628,25 +651,27 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct
> amdgpu_device *adev,
>               }
>       }
>
> -     ds_pdev =3D pci_upstream_bridge(adev->pdev);
> -     us_pdev =3D pci_upstream_bridge(ds_pdev);
> +     us_pdev =3D aqua_vanjaram_get_us_pdev(adev);
> +     if (us_pdev) {
> +             pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
> +                                       &pcie_regs->device_status);
> +             pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
> +                                       &pcie_regs->link_status);
> +
> +             aer_cap =3D pci_find_ext_capability(us_pdev,
> PCI_EXT_CAP_ID_ERR);
> +             if (aer_cap) {
> +                     pci_read_config_dword(us_pdev,
> +                                           aer_cap + PCI_ERR_COR_STATUS,
> +                                           &pcie_regs->pcie_corr_err_sta=
tus);
> +                     pci_read_config_dword(us_pdev,
> +                                           aer_cap + PCI_ERR_UNCOR_STATU=
S,
> +                                           &pcie_regs->pcie_uncorr_err_s=
tatus);
> +             }
>
> -     pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
> -                               &pcie_regs->device_status);
> -     pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
> -                               &pcie_regs->link_status);
> -
> -     aer_cap =3D pci_find_ext_capability(us_pdev, PCI_EXT_CAP_ID_ERR);
> -     if (aer_cap) {
> -             pci_read_config_dword(us_pdev, aer_cap +
> PCI_ERR_COR_STATUS,
> -                                   &pcie_regs->pcie_corr_err_status);
> -             pci_read_config_dword(us_pdev, aer_cap +
> PCI_ERR_UNCOR_STATUS,
> -                                   &pcie_regs->pcie_uncorr_err_status);
> +             pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
> +                                   &pcie_regs->sub_bus_number_latency);
>       }
>
> -     pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
> -                           &pcie_regs->sub_bus_number_latency);
> -
>       pcie_reg_state->common_header.structure_size =3D szbuf;
>       pcie_reg_state->common_header.format_revision =3D 1;
>       pcie_reg_state->common_header.content_revision =3D 0;
> --
> 2.49.0

