Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35165CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7C810E6C3;
	Wed, 14 Oct 2026 12:27:20 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013023.outbound.protection.outlook.com
 [40.107.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 195DB10E6C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 12:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsrNa3bygrJbgjYxUtwl4ofKK1SBefqFvqNq6kRpvhfacu557BdHmfu8I83KLJuLkLebrB3StWc9j8NHyWDsZPwh1CJ6OcWoS4PqOtDUiIoRuaPq/1hVlO8Yt+OKiLltyvKrN7f2v7doC6rosqa7eRdPzm8sLCONKkhT0WNjT3ofPgxx11iibA8KAhxGXhKmvUaSLIrm6UMdtgLIH8qYWOKMGMWFV4eZL8g3e0T4iAf5JuwZSXtkq35exkpoLqg17iMSBEyEvEgbjxI2Nx8DZwHlRmuJT58UALwXuWjyrO+eEQQ3Fy3ez2BZ+X+kfbCzWKBOIHhSvYmwGHHHpcfJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3/EShJPgwIPnnE4dr8ayxn4U+QoH2ACafH1g5Au7Ws=;
 b=SESRBZ7ai81wwxbQX8zLkCVEVf8OdLEl9UpSLH6moYV+dU+pBfJf0XKLhKloOVs3KjWx36rdRCBjT9gV7Bo3PcLisvahttMyKHI8QGUlqF9Nyz/BFAtH8ZGSbD42zggJRSt4BYpwnO+h/jEGvcWmVLwENCRYwgA4KmptQmNHqpdf1jzWEWIjQOp1W98/7nixC3h43LKp8FsWRozSLcHPdTbf/nHkur8pO/JtcfmsnhcGr1wjjH6xC79D1P5GvbNF0f4PVZ6hPw3FOxmNbb8Ak2w9xzEPjJjPTiYNq/c/ctRYXJhYBEIdSPX45lLduxOVgGqE0/NbLlnX/1fSik9bfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3/EShJPgwIPnnE4dr8ayxn4U+QoH2ACafH1g5Au7Ws=;
 b=DOJcLZg5vCpXbYtSE40b2fXXkJC+ymfTPAONnNuKey9Ckx9bsHez6uGblSRp5W24QEtc2r0760TijPDlSN22McbtPGHOfDIAWhKsQcgyNw+Kj6FVqYF80aF67q3IjyaKpBRXGcu3VjVlzl8uqNWyJs+AvHmwTpe99y7L0ktnBd8=
Received: from DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) by
 DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.24; Wed, 14 Oct 2026 12:27:09 +0000
Received: from DS7PR12MB8324.namprd12.prod.outlook.com
 ([fe80::e392:f2c2:6088:170]) by DS7PR12MB8324.namprd12.prod.outlook.com
 ([fe80::e392:f2c2:6088:170%6]) with mapi id 15.21.0496.015; Wed, 14 Oct 2026
 12:27:08 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>,
 "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amd/ras: Fix APU platform ras block
 feature mask
Thread-Topic: [PATCH Review 1/1] drm/amd/ras: Fix APU platform ras block
 feature mask
Thread-Index: AQHdW9Csj6bOnYsJ+0GIVDFZGJFStbb88zMAgAADEpA=
Date: Wed, 14 Oct 2026 12:27:08 +0000
Message-ID: <DS7PR12MB8324B7C76E224BC7EDF2C10D9A9D2@DS7PR12MB8324.namprd12.prod.outlook.com>
References: <20261014113858.289753-1-Stanley.Yang@amd.com>
 <BN7PPFFF39339DDE681F375E351C9D0CAF6FC9D2@BN7PPFFF39339DD.namprd12.prod.outlook.com>
In-Reply-To: <BN7PPFFF39339DDE681F375E351C9D0CAF6FC9D2@BN7PPFFF39339DD.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-14T12:11:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8324:EE_|DS0PR12MB7948:EE_
x-ms-office365-filtering-correlation-id: ff43a829-d432-431a-4386-08df29ee7730
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: /NLu3/CqSKwsy77uwSDM0HBw0/a01J13Jh9n5KAunbMu27yqKtOvmHq2V1b+05OFV08G3TvvAVvknGN2afQWdGis9uvf5TvxW4lG0NIue6MIZHDsr718sN7nHM9K5nqTx0G7jmx9IWSz6lgtB4K1S65AfCBiRMUH3dI0YKkjNBHTR++E16g82dMPLNMR0DMg9/RAes+D1qbSqlH2zTkgQrpLmCj81LBE3U5ttymn7IDIwsLohKasNTj1o/uwhfAFALqbx2eKiviUlIaLxcF03pNE9n3nVrIYegVEI2Q0bMKAr70LtlFN89NkcUs67iX3pGTqOfSeTnafOp8kXiVpEFum5I57BNR07X0m+IdNvLePORWyhOVXE/xY8tWvSg1ucS9pSV2qjxNekdqFeW30Ux2plx1bo8GDnR9dT744J5uKAbqcNLTYbAhHRu1zSlyePAbrKFBD0MmgBX3CVu/s7F3sBsmx9oZPCgQZTS9RxHQJwsrd8x0ndzrg3HT82ZoqqTenPWTfI7e1D1gyAmozW4cQ1PEmuS0nJgOoatOWXWBBTMOK/jsDRJ+Vivz4Tgan/LzVIARP2FAW9NGtxlIUPehS++fBYlFye6Xa/SeNDklbsHd8yCSQADejKATE3sHoxWEZQeGBMS47scQLEtYEijGwGIkLA47QQ9OIf0cNhklBwD3ENmEl1yqU4DFAChCOekIBL7824NW/Jk0ZwL9+LmxfhE4zqnJaNkQ0jLWOL3M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB8324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vJJ2cZzM4SufwT7A9hpc3t+RmgF/PeQFJ9JBWZA+SUoCAafuEj+/hkfN5zna?=
 =?us-ascii?Q?SGaIkLR+Jvj3SsQY4pH/sg7OMiS2HHzzmTRg4edfkKMPCIx2OU2tzrdo5xCo?=
 =?us-ascii?Q?s4Zyei/9ymjxbo8Sc4r9htdq9mDx/auwGBPnLoN2iwKsAWkrXktpFWV4uvEH?=
 =?us-ascii?Q?7nBJ/yTueMJMNZnE0sikgGKnyrIXgmhJrBfAgVH1D+gRor8Znp+uB9XKzdaq?=
 =?us-ascii?Q?kOP0rako/k50cDQ2ES8jq6KDe7pR1M91yDl+q/7WowfeHcFVm5yRNk+TppS+?=
 =?us-ascii?Q?3oXsczqgNGMPsuTES8/sARULKEvVB7chEO4QvFGhvcE0S9UZiC/ksUJnZzO+?=
 =?us-ascii?Q?GgxFZhlWrf8u0vqKvTytxlAs7SHqsGZmJ+LSD8/9YDbxnMCSYUj7VwelAVhh?=
 =?us-ascii?Q?LeSCDDSbohSB7LerX875Gtc2XoDvK25NkY8O6WzLfPTrxMd23nRsczIzyitL?=
 =?us-ascii?Q?ymyffOUx9rjBmFg5BmozPDaFdMAUdmdxzCfimnonv1DCopOB71zTyFHJwUTM?=
 =?us-ascii?Q?/xo1VwPfRefzNPt98UImICjfUydhLz1tlDq2/wUzYpXi+gDotI6RxnInr+BH?=
 =?us-ascii?Q?APrCZoPnEElRwmxBEbdW33wESFz4JIVmceEQOPoyJFFJUmmGWz61vpbc5XjB?=
 =?us-ascii?Q?JMiNj1/csvcpFiLEGaF/EBb7IQ8t/6OG9+B09CpVa9iUKZstQDxRMFDrpyqb?=
 =?us-ascii?Q?Ct4zt/b7D6kYGOFmgjtTTkbra5gPwDa2Eitzx4hWeG11WnhgFQ4GA7d4+WDD?=
 =?us-ascii?Q?xgcUgcQMcaEq7AmguwF3PxYW+3P860fvz0f3H4mnHEDtM7K4nEDUx+VZeoYd?=
 =?us-ascii?Q?dpUNPCSYTRnnj2YovCdSxm/pId8KKTP7ZIIQNYhxtHrn8g5RWBVW0kMyMZqX?=
 =?us-ascii?Q?zYgrU4ReI+WmvakJ571bpW51MpSV//A0QuqKsOX2cJALnnr63XUjJk1FxaLt?=
 =?us-ascii?Q?HDrI0LiTxrHXV/XxMtWSOeyPi6cS5/9qtUARa/MCo8u5U36l8eqQEsOxnitX?=
 =?us-ascii?Q?szM82IHIWCYC2EzM1d/GLawt9saiffBfslXaqZnFjmvaDacu/KOA9/1pQf7W?=
 =?us-ascii?Q?COU217dDv6A6ZARCazWkD3IiLmSV2xUwQGEKgFVZ3V73IcCLebN8bLBnGUZI?=
 =?us-ascii?Q?5NcRQQPLMCf560rKCSiPAUkuavBDShdnpy8m/Jj6j3L9iWZ1JgHHN4HLCZwM?=
 =?us-ascii?Q?es+iA5Sz2cZQJoN4P9DwO5pMzOUVEi8Dg32QpqB6tNHAy5gzih3OMnrQbba4?=
 =?us-ascii?Q?y0kSnY4EGLgdcts1xDpr47A2GWDS9npmuEM1eiMOaKKlUuJnJD8Kk/OvLxSI?=
 =?us-ascii?Q?fU8DgxHdyGCU8NRnocaTBDiIdKH6/7nX7lQUnmT9qJ52zQ3v3jBbg+ZB1rdV?=
 =?us-ascii?Q?c6Nc49gxnciljb+hgOKfzlrZ2CD+tc0Tx3ahE5RM4e+kC6yeSzgkuwCRqW1C?=
 =?us-ascii?Q?L5f7DcnQfFFYpiETGRuzwrrVvhFVitkBXAOu6oBGI1Xvah2CJXwHOU8BeHA4?=
 =?us-ascii?Q?yY5Fd0FPOCg4Pgput+Vn4e+rvfoJPwjtSJkKcJus/E1xV23wkrrco+HD86dB?=
 =?us-ascii?Q?qf5gTkGlkHfmoBFjjDYxxC14uAYIC9L6bghryER1Z1VN7Da9U4/DsbYCeg03?=
 =?us-ascii?Q?pGWUvVJRdZQyCtyQCDIUDZ0DLlTwrKGiHcC+BRK0SEXWeAdgUaXT6XaA59RL?=
 =?us-ascii?Q?usq14D/pK5S7B39N+nEVaIN7/dr5I1OIcimymWr9KYJt7aNE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff43a829-d432-431a-4386-08df29ee7730
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 12:27:08.8135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHq65mD0wwfhXh7khegDykYpI3lXsbD/vefFPX9IxUIn+l3UYSGYmAfCvmNsMtmTqJbas2aaz0MDS/FTPULB1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Wednesday, October 14, 2026 8:13 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>; Liu,
> Xiang(Dean) <Xiang.Liu@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>;
> Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: RE: [PATCH Review 1/1] drm/amd/ras: Fix APU platform ras block
> feature mask
>
> AMD General
>
> In this case, we should check the is_app_apu flag explicitly rather than
> checking AMD_IS_APU.

[Stanley]: Checking AMD_IS_APU has been validated and can achieve the same =
effect, anyway, will send v2 by checking is_app_apu.

Regards,
Stanley
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Wednesday, October 14, 2026 7:39 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>; Sun,
> Ce(Overlord) <Ce.Sun@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amd/ras: Fix APU platform ras block featu=
re
> mask
>
> the register c2pmsg_127 design only applies to dGPU not APU platform, so
> hard code ras block feature mask on APU platform.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c | 14 ++++++++++++--
>  drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h    |  6 ++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
> b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
> index 49ba57f58878c..fe971cf19e493 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v13_0.c
> @@ -80,13 +80,23 @@ static int ras_psp_v13_0_get_ras_block_maps(struct
> ras_core_context *ras_core,  static int
> ras_psp_v13_0_get_ras_hw_caps(struct ras_core_context *ras_core,
>                                 struct ras_hw_caps *ras_cap)  {
> -       uint32_t ras_hw_cap, bit;
> +       uint32_t ras_hw_cap =3D 0, bit;
>         uint32_t i;
>
>         if (!ras_cap)
>                 return -EINVAL;
>
> -       ras_hw_cap =3D RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0,
> regMP0_SMN_C2PMSG_127);
> +       /*
> +        * driver only manages a few IP block RAS fearure
> +        * when GPU is connected CPU through XGMI
> +        */
> +       if (RAS_DEV_GET_DEVICE_FLAGS(ras_core->dev) & AMD_IS_APU) {
> +               ras_hw_cap |=3D (1 << AMDGPU_RAS_BLOCK__GFX |
> +                                          1 << AMDGPU_RAS_BLOCK__SDMA |
> +                                          1 << AMDGPU_RAS_BLOCK__MMHUB);
> +       } else {
> +               ras_hw_cap =3D RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0=
,
> regMP0_SMN_C2PMSG_127);
> +       }
>
>         ras_cap->poison_supported =3D true;
>         ras_cap->flex_mca_enabled =3D false; diff --git
> a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> index de3da5571ef82..fada8b1b41453 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h
> @@ -107,6 +107,12 @@
>                 adev->ip_map.logical_to_dev_mask(adev, ip##_HWIP, mask) :=
 mask);
> \
>  })
>
> +#define RAS_DEV_GET_DEVICE_FLAGS(dev) \ ({ \
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)dev; \
> +       adev->flags; \
> +})
> +
>  static inline void *ras_radix_tree_delete_iter(struct radix_tree_root *r=
oot, void
> *iter)  {
>         return radix_tree_delete(root, ((struct radix_tree_iter *)iter)->=
index);
> --
> 2.43.0
>

