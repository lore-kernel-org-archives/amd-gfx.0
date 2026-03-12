Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27634FED2CC
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 06:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A975010E97D;
	Thu, 12 Mar 2026 06:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b+2In+CI";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04AAB10E97D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 06:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJe90IbPptPeLq1xG7o43ySWUBELJ+HpjeRoFPKAVfibF3I8zWfDhb9rG2WDJCgQU6uJGGbptbtY4QiltvD7APa2bDG46GYpNiMFMcpTGGiFpTp0rPCsNG7ctdgZITjPUiRV+i8Xr+RNueIqXJw9eBNV0S4nTvS2uHEfpoKzkQrJRA8jJKuNaZVzraeSNu3NF9WLtfVIu+IKcqDgsdwpKva89Zf5+GzKqGtmeh4TxVwlKOlx8BU9qudYjuj15IS+IUi4BZzNyQEWN2z9QRjejGsY4kxyV3mlwIPNADkt2Y9x9IZtS3MFMA/3yt5uukxQFExf5XQ3Y9IUuZkgQit6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2TmB/QU2kXcWiyuCA2qdHSdrU1C/U3I0UZB68vnQGc=;
 b=IERS5Vnk7qjA267+06lBQbHO8ATsDWWRm4935yi3OaAWeqVfO+H330mRR2gtVmAlcdgTmkdgFB1ui5RMgPVrE/+t7H9QwuGiG86I35+opoQ9Ik8k59PPbZ4tsQArjiJpc2Mko/FQ/o48lTW/B2IMyYIIVuscUQ67ygVYVyG0lEcgP0xK8u7+6l+9ZFcuoglEC95jYBqdmuzZcm8/EyJd1cGYKnlK59RM6ic2+Z2ZxDfDrBRDjq/GvQGm1TmPgwaAm4jRo8NV8V8C8ogDRxMpwzb2xnjv6cZR2K/OfbP/Og5URICNejvAlCMJep/WOqZSZ7vj0SwW6Ivue5VTwx4qew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2TmB/QU2kXcWiyuCA2qdHSdrU1C/U3I0UZB68vnQGc=;
 b=b+2In+CIfeRW1HF9S8Gf4orqixH74rbi4bOgYFIb+pypC2GPYMwX4x/gAyEzfrgT9ACysh+vRBe+nAUseBHigWjRdth5vLa9CmVq0H9O4R6WJjfpOQhSOMO4Dg0xugtyoIyWnSCOZI5i3xHgc+Wt0PKmj4iNc5PTl1dc02kqyNc=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 06:32:23 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 06:32:22 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update flip bit setting of RAS bad page
Thread-Topic: [PATCH] drm/amdgpu: update flip bit setting of RAS bad page
Thread-Index: AQHcsUXjWw/Pveritkq1ceFf2+uEbrWqcVzw
Date: Thu, 12 Mar 2026 06:32:22 +0000
Message-ID: <PH7PR12MB8796196F08EE75EC0750893FB044A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260311105724.477408-1-tao.zhou1@amd.com>
In-Reply-To: <20260311105724.477408-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-12T06:32:09.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB7526:EE_
x-ms-office365-filtering-correlation-id: ed5c3cc6-68d5-43e1-5a69-08de80011e8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: ORehuHUylMctwZlHs/c6NCMKIgN4y/YcnubgST3jqHHSg7UIbHt+Pai5j01R7Q4R30fU+ItbpWGvsKGukLN5nudII/BglwnvOeSApfYIKDSIrCU02izunbLJhlEl90gSpfeMsCIueqROFjYUXZloNlJ2/pVYH0ydB0mNdGo6RdKrdMeqtSQkpew/UELdifsdWb7ia6uv2grY/iVS4OYohvo4vLbJuj+aA/tSDKGayjR4jY/VSEbmRKS9HFm2/YrHYmpTokRUz1QFPcXcibRmV+LJ+hc/xiqYb+vbTuGTbOkUtAxDsxSa96COxTpjIoKpB2CHtvrzdJPkJIckmCZ/xgVb1MXn6f8KrSswCvqYTGlFOkiqSYQfsiu+e0DfhCYcq8zDvUrvz/nGJnHgnWbB7JuUFTYXM9lvP3EgcJjQr9HlSPma5Q+pesvQTWcA7TCb/SdPlactqxNiE8dBD1qhICBUwmUeVj4hWMgUKIYfHOr8vQYgyZNoJDhQPErDpffTqV4HMpCuqUyz8PGmLjsmpveaq6yX+DVAc9dgc16Acu7qbA3pwmbtNM54lkjTdCVfsqM0OVSj2PchhG0DpvOyMx+lvGaMVXvtMPPLBVJPtph416SfFfqDRLTdNTqJW/E/IVl++J/RAuZG5EbQYWd0KQ4t1z3Ll0//+mrP4b41VOluUx+9zTQKeycCH5YDwr3BTkIMLKZRvyaRzTHVPEvCC2S/PZMkbYb4DaEjtnULBWGn7yQepk3FsQcuTHwzFA00t4thjMWPKUWuBW8i4fP1yaExhjlRhYBebCX7Ie58fsM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ks526qeceq/PsLzDrWIVTDRoGUZ/AqqFsf7BSe/x2+JiBWTZVFCRdhQM/Nxx?=
 =?us-ascii?Q?OWrLMbmlmuZyjjxHHNak+raM4VibrvLtpUIEjQpHgAPR1zUVJU41WJR2S8FN?=
 =?us-ascii?Q?WOwGykriDhQePz1NTnUlmAUJHBAOXPLRFvYmWNAUqNVO59wrjnIEQpBAbBAD?=
 =?us-ascii?Q?U6i/PAKj8Yp49ijKsj6X6NhmgkzBNUfPkezd41LePiQyG+sQDYXQoKuuktzZ?=
 =?us-ascii?Q?hIbVxM5T4vQJKcattIs4xpm0y3pBAlJYOy+8/3m/dw8bqwo0ET2yrc1XTXvY?=
 =?us-ascii?Q?X9vffH/owueNqD1Egh+luaOAXAORXnqXJ3dGvOW7A+1lhsLk0v5Lfe5um1pq?=
 =?us-ascii?Q?Mqvn1GaCdNVnAMw6a8MP1rQVWe9NnCoIYxnEAIgs1rOGYkk9mWmk6ZVP/JxM?=
 =?us-ascii?Q?bkVCITUoPvma2wgkwvxvilbWCFXV5dktJlA/2NfCwESPWRPaygujKGqrFdap?=
 =?us-ascii?Q?M3WhEcKZlarpqtpAzrbIpdkBPPvHYNqQ9pbBC5BlTAei6mRk8gGoQIryfotT?=
 =?us-ascii?Q?uKKNl+6Scb9/iW70xP6m3Us+cwVpCXmaTWM/SWR8zpBIkE4W9EQlXyjHhIj/?=
 =?us-ascii?Q?TfLj3DMdbMruRO4+5iHRRD8sGYlmLSVc+5GQZB9dPeS4uvyI/kuYaz0XlnTt?=
 =?us-ascii?Q?KAm8watY26d4IpVTkkyvqVqwDI1akvAu/4cAbPayujZatkfsR+HsTTh64WXI?=
 =?us-ascii?Q?QBEpXuOKJB/IleFY9G6RHf3uHaCFQ2asDO81QfsZ9acc0jQuCd4jPchKIhCb?=
 =?us-ascii?Q?jXDdfia6/fKtYcDiy+BuWWJraYf7XzzgwTVpBKvHz06aYb+8zN9xJmQSld3I?=
 =?us-ascii?Q?n4/JETkIHrcLnlpL2pVlDH2DWg8QmopFc89OgU6JfvXCSg3mU1qOTC/yFvyB?=
 =?us-ascii?Q?iWPjoFkHY3sOxc/c4N1+FFEiTZyr79RlEe0iAXqJJDXhGDmFzlYvI7TponmC?=
 =?us-ascii?Q?FHI1DHygXC6RS4zfAGAlKGF+iWwLqLXxoQD7IVV2MCoP3geZierjqLifr2a3?=
 =?us-ascii?Q?0yAdX5ew1yXG7s9qZbjhg12pMWXg5b6v2Rvdb52qevF/bUDZxEje+gfdAuzR?=
 =?us-ascii?Q?SXDkTyU4SzHM6bqzlxssk97Q2+rXv+XNuz9GZ7sX9dBSdkRdIrE4mPjaiYxY?=
 =?us-ascii?Q?+JKyOwZxkGsJG1lcaM6iAUSxWksovaOxjqd8KvnYPolmAs2gkQgTPuoTlw89?=
 =?us-ascii?Q?Z4+kM6LeO5OmSmXqE1Lh/6ypLeZwf9UPHx4ze/Q5ytA/qfGpuL6XF/Uhqloz?=
 =?us-ascii?Q?Tl9SzbcLJESR9LuWWbehLG93Tln6VzNK/KsdW5XTeCkdyhIhmvzXClAZ57op?=
 =?us-ascii?Q?g3REj7wPx8SjGoIMUN4uarHYvAQ2OsWvOBk/AQySQAcIg0D3j7r+Zhc0LL7v?=
 =?us-ascii?Q?/ufolu2/KsrEhOXS0+8FfQxWBZTwxvX2Cdve6D9eyiXLEOyqKzJUYw+eWzBi?=
 =?us-ascii?Q?Z9KCtOU6yVP3OpZR/3hP1DImeRghug/YXBGZnuKvVc/byQiKACLL9xfSWx1/?=
 =?us-ascii?Q?+oxp8+fZSw4bPtPx/Ddg8jbaLWi0KEEj8phbAv+pSA/R1xXVcc7HDDI/qHzZ?=
 =?us-ascii?Q?sV+RPGfpYrWbHhEbUVTvjri9amLsjUXgn+laeVDcMm1pqS9v26KnVI8887YD?=
 =?us-ascii?Q?oIzoHLQL3LrEE5IVW+DcsGRsjn4POQmtIlWzKaBWFkkhxb22gPol28RBENC4?=
 =?us-ascii?Q?+VdSNdzzpLfs4DfVKUldnRcgsn1nB8YUeHH9/waoZuIAyC1r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5c3cc6-68d5-43e1-5a69-08de80011e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 06:32:22.8334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0SCDCOFHLYBFaXocsgqiz1rycHgCZEN33cm/SMZIYS+V4y4rrbhpWxTqIKkfGvp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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

[AMD Official Use Only - AMD Internal Distribution Only]

Ping...

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, March 11, 2026 6:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: update flip bit setting of RAS bad page
>
> The flip bit setting is different if umc number is half of original confi=
guration.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 109 +++++++++++++++++--------
>  1 file changed, 75 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index 0f5b1719fda5..3d34592e8ea1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -183,50 +183,91 @@ static void umc_v12_0_get_retire_flip_bits(struct
> amdgpu_device *adev)
>       if (adev->gmc.gmc_funcs->query_mem_partition_mode)
>               nps =3D adev->gmc.gmc_funcs->query_mem_partition_mode(adev)=
;
>
> -     /* default setting */
> -     flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_C2_BIT;
> -     flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C3_BIT;
> -     flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_C4_BIT;
> -     flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R13_BIT;
> -     flip_bits->flip_row_bit =3D 13;
> -     flip_bits->bit_num =3D 4;
> -     flip_bits->r13_in_pa =3D UMC_V12_0_PA_R13_BIT;
> -
> -     if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE) {
> +     if (adev->gmc.num_umc =3D=3D 16) {
> +             /* default setting */
> +             flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_C2_BIT;
> +             flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C3_BIT;
> +             flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_C4_BIT;
> +             flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R13_BIT;
> +             flip_bits->flip_row_bit =3D 13;
> +             flip_bits->bit_num =3D 4;
> +             flip_bits->r13_in_pa =3D UMC_V12_0_PA_R13_BIT;
> +
> +             if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE) {
> +                     flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH5_=
BIT;
> +                     flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C2_B=
IT;
> +                     flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B1_B=
IT;
> +                     flip_bits->r13_in_pa =3D UMC_V12_0_PA_R12_BIT;
> +             } else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE) {
> +                     flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH4_=
BIT;
> +                     flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_CH5_=
BIT;
> +                     flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B0_B=
IT;
> +                     flip_bits->r13_in_pa =3D UMC_V12_0_PA_R11_BIT;
> +             }
> +
> +             switch (vram_type) {
> +             case AMDGPU_VRAM_TYPE_HBM:
> +                     /* other nps modes are taken as nps1 */
> +                     if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
> +                             flip_bits->flip_bits_in_pa[3] =3D
> UMC_V12_0_PA_R12_BIT;
> +                     else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE)
> +                             flip_bits->flip_bits_in_pa[3] =3D
> UMC_V12_0_PA_R11_BIT;
> +
> +                     break;
> +             case AMDGPU_VRAM_TYPE_HBM3E:
> +                     flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R12_=
BIT;
> +                     flip_bits->flip_row_bit =3D 12;
> +
> +                     if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
> +                             flip_bits->flip_bits_in_pa[3] =3D
> UMC_V12_0_PA_R11_BIT;
> +                     else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE)
> +                             flip_bits->flip_bits_in_pa[3] =3D
> UMC_V12_0_PA_R10_BIT;
> +
> +                     break;
> +             default:
> +                     dev_warn(adev->dev,
> +                             "Unknown HBM type, set RAS retire flip bits=
 to the
> value in NPS1 mode.\n");
> +                     break;
> +             }
> +     } else if (adev->gmc.num_umc =3D=3D 8) {
> +             /* default setting */
>               flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH5_BIT;
>               flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_C2_BIT;
>               flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B1_BIT;
> +             flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R11_BIT;
> +             flip_bits->flip_row_bit =3D 12;
> +             flip_bits->bit_num =3D 4;
>               flip_bits->r13_in_pa =3D UMC_V12_0_PA_R12_BIT;
> -     } else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE) {
> -             flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH4_BIT;
> -             flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_CH5_BIT;
> -             flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B0_BIT;
> -             flip_bits->r13_in_pa =3D UMC_V12_0_PA_R11_BIT;
> -     }
>
> -     switch (vram_type) {
> -     case AMDGPU_VRAM_TYPE_HBM:
> -             /* other nps modes are taken as nps1 */
> -             if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
> +             if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE) {
> +                     flip_bits->flip_bits_in_pa[0] =3D UMC_V12_0_PA_CH4_=
BIT;
> +                     flip_bits->flip_bits_in_pa[1] =3D UMC_V12_0_PA_CH5_=
BIT;
> +                     flip_bits->flip_bits_in_pa[2] =3D UMC_V12_0_PA_B0_B=
IT;
> +                     flip_bits->r13_in_pa =3D UMC_V12_0_PA_R11_BIT;
> +             }
> +
> +             switch (vram_type) {
> +             case AMDGPU_VRAM_TYPE_HBM:
>                       flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R12_=
BIT;
> -             else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE)
> -                     flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R11_=
BIT;
>
> -             break;
> -     case AMDGPU_VRAM_TYPE_HBM3E:
> -             flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R12_BIT;
> -             flip_bits->flip_row_bit =3D 12;
> +                     /* other nps modes are taken as nps1 */
> +                     if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
> +                             flip_bits->flip_bits_in_pa[3] =3D
> UMC_V12_0_PA_R11_BIT;
>
> -             if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
> +                     break;
> +             case AMDGPU_VRAM_TYPE_HBM3E:
>                       flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R11_=
BIT;
> -             else if (nps =3D=3D AMDGPU_NPS4_PARTITION_MODE)
> -                     flip_bits->flip_bits_in_pa[3] =3D UMC_V12_0_PA_R10_=
BIT;
> +                     flip_bits->flip_row_bit =3D 12;
>
> -             break;
> -     default:
> -             dev_warn(adev->dev,
> -                     "Unknown HBM type, set RAS retire flip bits to the =
value in
> NPS1 mode.\n");
> -             break;
> +                     if (nps =3D=3D AMDGPU_NPS2_PARTITION_MODE)
> +                             flip_bits->flip_bits_in_pa[3] =3D
> UMC_V12_0_PA_R10_BIT;
> +
> +                     break;
> +             default:
> +                     dev_warn(adev->dev,
> +                             "Unknown HBM type, set RAS retire flip bits=
 to the
> value in NPS1 mode.\n");
> +                     break;
> +             }
>       }
>
>       adev->umc.retire_unit =3D 0x1 << flip_bits->bit_num;
> --
> 2.34.1

