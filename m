Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A65C56208
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 11:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A7F10E27F;
	Thu,  6 Aug 2026 11:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qmSOxvqm";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50FC610E27F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 11:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmFvjWl96FBahr5c6eK/LqZqtwvYltuG4vYHuA+eMgeu/bXdsyBZssnKWGHGcVwYbThySgP4IEyPNsAy7CXiTxRyyeUKX7bBm4zlhqK+4QqEq6fktjR2qWug6R4WESue1eqszkQJaPCKkr+HyUz1MV2G879CXm+D1Ja1bbXvAicnIU32RN5Yg4sJyUdmv5Nuq1KTtcW/EQAZWy29hplbmaOez5mcC7uMShyEWxNpdgPu0Oj8VLyPo8e/bcpYXo4S5niuI3X5o6ayHSJvyya35ydlO1YYJ7JY4aZ6Og7tSaDnpyfXyp+eCOvp31Mz5o7vRrSVMaoLJbWsSnAPnpqXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wli58sIjsEWzGy0Tkm3IpjWdv1/B1yRff8mUy7pU8g=;
 b=KpDdWcfG11GkCGgPMqMGRrh4Gbywuc7bjBd+dzmU/+g4nNwZp18eY327Gsmu+CPhKccD2cnoVfxy/a51m+BssGfhUSQlgAq38J6JVEUSuS2mjmanl0+2aRoNW5DqT8qf4tFysQtMcA0tGm+7VbL1Mylz3xiwO69lVER65QFy7SlPCMYfWo9MDJO/CeGth8TR2AMo1Uw/UzGHnvi/ArNeZ5pN5HVJv/Pzk92p8xypNoB+zlGveTeDwHCUQq4qkhs7MOO6koqyvgYHYhAj3KDCDwnNSRiwzoxt4MvN4IUnS+LZwGmayWm7yFhjzFgolx7wnBP5WXvQxEb7rlIcEYVfBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wli58sIjsEWzGy0Tkm3IpjWdv1/B1yRff8mUy7pU8g=;
 b=qmSOxvqmd+83bCk9vh7B9La5wmNp+SoYhRQDUSrEaW/ahi9KWPuhrGnSCttVSe6EAHstw2gnclzjo4SxiSwugG+aCd6B22gJ2kWNA5/tks6cezIuA8592wYWXxUeueVA0q/M3oATsYYWsNS5XX6bEVodmZjZFokTkO62FNEXS1Q=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by CY3PR12MB9605.namprd12.prod.outlook.com (2603:10b6:930:103::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 11:30:15 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 11:30:15 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kamal, Asad" <Asad.Kamal@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: check ASPM on the dGPU host link
Thread-Topic: [PATCH] drm/amdgpu: check ASPM on the dGPU host link
Thread-Index: AQHdJWcQfqlQJtWq1kGQERYbQb6ls7aQ300AgAADBzA=
Date: Thu, 6 Aug 2026 11:30:15 +0000
Message-ID: <BN9PR12MB5211DE7BDF028DF3441F97FA82D22@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260806054705.1580442-1-kevinyang.wang@amd.com>
 <MW4PR12MB68034831F1DE57DB42EAD0C98ED22@MW4PR12MB6803.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB68034831F1DE57DB42EAD0C98ED22@MW4PR12MB6803.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-06T11:14:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|CY3PR12MB9605:EE_
x-ms-office365-filtering-correlation-id: 885cd631-e8ff-4b20-6f44-08def3ae1621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: EX63QLT5zPGgtdZkz0/TtKlWOdeBNc25pAectrGswQzhuuNuEn804ze09P8dDsPxiU0XBeRGXtyjl/6N/CgTp7DlZ/9sQHI8C9ALQRg8gNnRCgbV2jhDIu6Ra61jO0wM9YNFn5MFhgPHMOfRBysGBxPWfP/huHhxejuqCa6O1LHFSFuil3CbTIHKb2RQUqVo6c+F6f0iC54dDLO8xSI9WZY2MPZZ3rCDD+g6Vlh0udtVzRRI4Td+J/huYGLEEMy7iElaPQ9GLYcBixXGdlPZ7jT5Hlug7L/PidUebpv/J0DzbQcyAl+BrOsk7oc9+JrX98nMXa+15uKKd/wezp7MRpBUdyXzjfvY6ucIyIIAeVGrenJ8D1DWCuYMI/+NlXD+Yh6b4Ie5VvNUsCFhmNWCj5hw07bOE1CxbvDeWhVrGQPFk+t9Uvd2reO9ETW0J5BmxjoBOR28ez2oqEgKaJZJ/I6k+0uyj10MQ/FqVps087PMkFgdQ9INyrI5UUXbI204FFAReZfZihYCTcbssGh8+VgymNCzMEDMNgTCofZPF57zGr3VAvE3dm7lmaJwu7TWdBk3O+o0cukTyKCC385xBe88TBOWYYPvneX2whgQbvqrSiLlD6w8/rv/4GhvuYgW3vG9mhdxmSlg6BhXxzr+r+rMiY3lNpVBMudYRC3fXNLNUx8fe0xt/hnoyVQNyUbmZxWztinDvVdh1kKxkRnVvkFtS5I/gepihC2b8paPx3c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3PvdbB6CCJeecUojKmbai8HNLKZsrfjXg+11PjkbByt3A7mNXlzSFUgPA/9J?=
 =?us-ascii?Q?rFWhxRMuavJ0b/ax+6vtPkOhhq8D+hrDadd/EZWFrR5XLX0q7+tCSWh1NWIv?=
 =?us-ascii?Q?C+l4GhoJ+C5a5CCOjpkzmk8M/pQjAXc0+lkOhd0DhvI0WEKKliCLBtaOqXQR?=
 =?us-ascii?Q?fOUitzgpVSrqxPTd7EYQ2eYlYg9xa/Z6qH8mMWMXrqNaYgn0M8Ky1jl4rT4Z?=
 =?us-ascii?Q?dTx7MbDxDfYdPyeXdTWownsBt0Fy1WafjT85ttY+dEzpFflKDc3pEefEWtsR?=
 =?us-ascii?Q?AiULcfva55Y/VPW3fEZW6lUGZmqsdhKop48gomMMT6JZ2Nam90XmOL8ySV3x?=
 =?us-ascii?Q?YYs/LxlETTi7bsZPU4tjw2FA9AH+UZW5Z7An1kCCqUxK96CSak8SsVcd7u44?=
 =?us-ascii?Q?Te0qf5DvxQCxKIJ+YUs3QFRFTD2eB8cl+mHcgHAxT4gI604CzaFyKqO2Yza0?=
 =?us-ascii?Q?sHbRaKQdjsOxbBO6nhrPKSuxUFjJBlUcyPmM2pD8VcPYWcldzNOw9MnEb6Jf?=
 =?us-ascii?Q?OXCnOafnBxuY3RRRWJmAKwFYyY/2qN8Ex66gaG5FztCgm9snjh1lbpRvukca?=
 =?us-ascii?Q?V2b9rnqKHBSRbCrRgyoboJZ3d1eSpOVF6AygBJkghIPJ/8qRB5qU5Uzw0Msv?=
 =?us-ascii?Q?qtskToWzfl0Urc5cD8RTEIMPq5iR4QUP+6eNnqE+U1wZp4hF1+mzG/d4QsW5?=
 =?us-ascii?Q?zEyeI1ZImX8c86XFVV2wku2+V4Uivpje5jj1V9a0zkgA2AtUnFgoY5I/xvSD?=
 =?us-ascii?Q?KmVyTFSkGbB2SrOW0G7bl6u26H9Zytr4eCCPmKObpiKnttOjHNx561E3zshO?=
 =?us-ascii?Q?egUYQtpVLbT13b1Kd+LbCPhah8/FDw+YVNbY7PXhnDtgzx0TLcebRiP5Yae3?=
 =?us-ascii?Q?LR5LNSI8bGqI/yYFrE4Y++s2/fqPfPY5+NouB3K2eLXF0+rQQTzmUwrXfToq?=
 =?us-ascii?Q?F881sdLyC98ZR5CnTlsDwwP/ukuzxbDopsUXSnSI3A2Jhu5NKLmrrc36g2zI?=
 =?us-ascii?Q?zyJ5v0qEye3KCh2o61jOfi1t0xmwv5+dOaj+6d+LceN1sDEib2ZirtEKzQ5v?=
 =?us-ascii?Q?xqlanf9AVRmXVeSxSG3YD7qfcMggpP8cg4CK4BLoP+QZcWGKEYJp639U1qfn?=
 =?us-ascii?Q?J2oMeZnF08ew/zOYUWPfT+JoGRobksIzlPPZVrTnaWhV0XE2aoThrjaazzJn?=
 =?us-ascii?Q?xVDE4OhcoHROhdpOSEL+mATzFpcizKKCqmvSEldluKnezrwJTpEoMh+s1pO9?=
 =?us-ascii?Q?cYhOGiwGoNmEngDG3/AZPOEEgLxjxYNns1PxsZ6wOVj9UnL1+w2dadqk+Spc?=
 =?us-ascii?Q?gmpEZv8PkiDyjozt2riDPF4qTaTWckZ6PWTvyQpLcporMi32SOPy3fOY7Fax?=
 =?us-ascii?Q?pvLpEdxbTjKtmdJP01JPpnkeLyF6MWCZA5kfeAQlyJoepfkd84PSiNXgfXpa?=
 =?us-ascii?Q?9dORtivoWQx2fr/TWsvxbrkLdomiy1YEcWWTqQJ+6BlYdsJVqPisOFNmlbjZ?=
 =?us-ascii?Q?tq7UuAEp8QnZcNckH7EuKixwTkg0T/7O6s/avCK1WcCJ7qVOhTxAQg56xXEJ?=
 =?us-ascii?Q?/PXN3cC6S196DWU6DN6LTayikPYmSY3DIVVt8hoqEF9wY+5MW5ATfx4+b6xb?=
 =?us-ascii?Q?KlNB6LpK9N8NKHF3tDWXS6tdbJ6la77m/Qmx52M/B+6J6fuwjPOtS2nSCohf?=
 =?us-ascii?Q?KB/A35731/musy7rr8Rucmhz8Hf0YgNJTaNS4NGUKDptzc0l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885cd631-e8ff-4b20-6f44-08def3ae1621
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 11:30:15.4188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/5Xc/bIufbHf6IfpTDE9Gmrqy8+XHs8RaEow7fnU/sH0sGtiA4JAcfnUgebDwwv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9605
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

> -----Original Message-----
> From: Feng, Kenneth <Kenneth.Feng@amd.com>
> Sent: Thursday, August 6, 2026 7:17 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: check ASPM on the dGPU host link
>
> AMD General
>
> dev_info() could flood dmesg, better to use dev_dbg().
> Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

Thanks, will refine it before submitting. (and Asad raised the same suggest=
ion during our offline talk)

Best Regards,
Kevin
>
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Thursday, August 6, 2026 1:47 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amdgpu: check ASPM on the dGPU host link
>
> dGPUs with an internal PCIe switch expose graphics functions below the
> switch downstream port. The automatic ASPM check uses the display
> endpoint and evaluates the internal link instead of the host link.
>
> Use the switch upstream port for the check and report the selected link.
>
> Fixes: 0ab5d711ec74 ("drm/amd: Refactor `amdgpu_aspm` to be evaluated
> per device")
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50
> +++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2b9799033174..e68a5ddcae69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1344,6 +1344,31 @@ static bool
> amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)  #endif  }
>
> +/*
> + * Some dGPUs expose their display endpoint below an internal PCIe switc=
h.
> + * Use the switch upstream port to query the host-facing link.
> + */
> +static struct pci_dev *amdgpu_device_get_aspm_pdev(struct
> amdgpu_device
> +*adev) {
> +       struct pci_dev *swds, *swus;
> +
> +       swds =3D pci_upstream_bridge(adev->pdev);
> +       if (!swds ||
> +           (swds->vendor !=3D PCI_VENDOR_ID_ATI &&
> +            swds->vendor !=3D PCI_VENDOR_ID_AMD) ||
> +           pci_pcie_type(swds) !=3D PCI_EXP_TYPE_DOWNSTREAM)
> +               return adev->pdev;
> +
> +       swus =3D pci_upstream_bridge(swds);
> +       if (!swus ||
> +           (swus->vendor !=3D PCI_VENDOR_ID_ATI &&
> +            swus->vendor !=3D PCI_VENDOR_ID_AMD) ||
> +           pci_pcie_type(swus) !=3D PCI_EXP_TYPE_UPSTREAM)
> +               return adev->pdev;
> +
> +       return swus;
> +}
> +
>  /**
>   * amdgpu_device_should_use_aspm - check if the device should program
> ASPM
>   *
> @@ -1356,6 +1381,9 @@ static bool
> amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
>   */
>  bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)  {
> +       struct pci_dev *aspm_pdev, *parent;
> +       bool enabled;
> +
>         switch (amdgpu_aspm) {
>         case -1:
>                 break;
> @@ -1370,7 +1398,27 @@ bool amdgpu_device_should_use_aspm(struct
> amdgpu_device *adev)
>                 return false;
>         if (amdgpu_device_aspm_support_quirk(adev))
>                 return false;
> -       return pcie_aspm_enabled(adev->pdev);
> +
> +       /*
> +        * pcie_aspm_enabled() checks the link between its argument and
> +        * the immediate upstream bridge. Use SWUS for dGPUs with an
> +        * internal switch so that this is the host-facing link.
> +        */
> +       aspm_pdev =3D amdgpu_device_get_aspm_pdev(adev);
> +       parent =3D pci_upstream_bridge(aspm_pdev);
> +       if (!parent) {
> +               dev_info(adev->dev, "ASPM: no upstream PCIe link for %s\n=
",
> +                        pci_name(aspm_pdev));
> +               return false;
> +       }
> +
> +       enabled =3D pcie_aspm_enabled(aspm_pdev);
> +       /* Report the exact link used for the automatic ASPM decision. */
> +       dev_info(adev->dev, "ASPM: link %s <-> %s is %s\n",
> +                pci_name(parent), pci_name(aspm_pdev),
> +                enabled ? "enabled" : "disabled");
> +
> +       return enabled;
>  }
>
>  /* if we get transitioned to only one device, take VGA back */
> --
> 2.54.0
>

