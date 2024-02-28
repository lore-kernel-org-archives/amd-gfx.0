Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DC5C54E4A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 09:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B34510E4D1;
	Wed, 28 Feb 2024 09:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2HOPVj+k";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0327510E4D1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 09:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hg0D/8y4EMacno7+u25Lv2Ra8DFrg6drG/V0XKlc89bfJAcE5n5NZ9o2hISVtCtfhWaXzMqX3aOEbckp+Smiztf2/whYDTM5S22vbBrEkX9/+kgzfLs4zkyo+F78xna77Dvwxl3G2KN7MpV5rd+L2lz1NiAZcgWtc5UjK1aP2gr476D9M2sGknP+mYWWtuv0E7SvF7CiEVw9ZMFhLkxJgDboKaV2hEoMVQaeFF0iucIn30SMsksbwRyKRLpUCsX++iUHXbjOJmfbBTXZ/YWIukKhQNUX076LJ456Vo7UXcL9YE52NrwfKHfvWZ6M/u/g/tjnjeXSVCNS9PW1OASKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikyh4yqztaPcraF+KlfMdxVWb+2Y9IqgFCzqGdQSpGQ=;
 b=QBATTFonnz2ReapX0pK0z9eitb64mi+sV/iCkFDYBh2LtM3/bd+gC2VdAdBwKmmUkguUKe+AzC65IaRGKIejqawO2MyRVJLdXo/xQHDxgT7rwwk+GmegKMt9mSrkYTNAPxMe+8pvf/cK49bzTGV13q16BcvxfiY3qxwxlb5xM9qhJ8DxLVcww2vFLG+DBiRUy79GsVegHckfAclCUaRsPmN+Z6z9Bxh7pjTe7DIjoTh0bRdmhT/e2h+FGrJ1XB4cED88Qs+hLC3RCalfDkj4nnJiAeZnVKqBJTYfJN4B6j95D67DG6DojiptSW/t+La7brdrzcUIasO7SG97oEzyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikyh4yqztaPcraF+KlfMdxVWb+2Y9IqgFCzqGdQSpGQ=;
 b=2HOPVj+kMr2klIHVqQVSRcSqK5nM9Ooe1S52vkzY47uvyFg/xwjlsoBkLNATIlpXLRAqIhfa4RyPoJ7SUT9QY9znPB9G7wOyjJknv26/D6CWXlzIytXf9gkq2WZq6KX1IDpuvvG1qDerAhJD6T8apVYI2r0DwkwS04lcD9JVVLs=
Received: from DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) by
 MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 09:22:54 +0000
Received: from DM8PR12MB5398.namprd12.prod.outlook.com
 ([fe80::49b7:55c7:c5:b995]) by DM8PR12MB5398.namprd12.prod.outlook.com
 ([fe80::49b7:55c7:c5:b995%5]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 09:22:54 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix esm reg mask use to get pcie speed
Thread-Topic: [PATCH] drm/amd/pm: Fix esm reg mask use to get pcie speed
Thread-Index: AQHaahKggh7L4W4UTUicHIW+64RO/rEfezXg
Date: Wed, 28 Feb 2024 09:22:54 +0000
Message-ID: <DM8PR12MB5398E3866242A09D9F2D387BF6582@DM8PR12MB5398.namprd12.prod.outlook.com>
References: <20240228065143.2103613-1-asad.kamal@amd.com>
In-Reply-To: <20240228065143.2103613-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f9972774-f8ed-4e7e-b552-2af8263c98db;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-28T09:22:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5398:EE_|MN0PR12MB5786:EE_
x-ms-office365-filtering-correlation-id: fcb035b2-f0da-44d4-bd61-08dc383ed811
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/lWkdRIUO7pausy+979s6+KtQVnv6xR0o0PLU+S9hjlsYg/YXGhzL3dv6TL3uflPlMrTi1/pGgL+XtXiHkBylb8m2yXuuH20KffEgXPcqpsVY20/s7O6W/oUmXokWA7z6by+csJ6NpgTZ7Yo/9Nn7a0RWeXv3l4u45/PK9QhW5q41brtDIfKJq0gQAmEwRE9XHNR0K+dQ6tc/RMZ59ZPj+dWfDSV4q4hs5FOmnwfnboPrhfgbrXHWtM9DxgKNANuvAHGbEk8wl498nc91aHgb3YHIqFIjeoIb4/V5qlV9wnwYC0hIHo8ngvkpTVnNuPcZ5dZ+48U596OzWKWebAi1UW0AxFocr0erlz2UBUlFGVXywEAW26UN4g3yQYliOY9mW8X8BTtrJKMIZW/KwoVkCiMVsE0nUF5uQHu+lnj5q2qwDDkqJO3YGn99f8ykU+0YGW6USqwu6Io6OSBp8W/QflHQPfiP/CBoUI2MmAy7CyN8QTKIbNxKZ2wRqOy+LQSHKjqZgh4loN/BGzVJPyqw3v9kUsqjl86NAggWkd5LXcgknBHyjHoaaOQdnuxL5Jnd0iyeaZEqTi93jBWnefgX+QiwTNG7f1pnhnIQ4CvEUhAav4qM9MlmlWecFWvfKMmDur+MEtA77VHb29W6tNiCs5ritysIPtMwOSEcsjxZpbGs8l+p1nFzbTZTe3y4jkpuAVXBiS70SHi1cDm5UQ9WU5mnZHwtu9Kzlyk10jznY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5398.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5PbVg+EVa9x1bjZ3I7H/k4mxIn0oxf8uJUc/Tsm2G+Q31ZkBcb9DjTnVAahQ?=
 =?us-ascii?Q?73vybkqcXojymiFhCsf5SAz1Z2I65a7g2eapw4n9tAqiS+y3JW13ck7GBuhd?=
 =?us-ascii?Q?SRU1uWckbyfzv8qn2EVTVxoNi5cQDRciA9YOnGhLMwxV6R6KB8MA9+YREkTq?=
 =?us-ascii?Q?a2LwD/ET+1CZ9eUDk2Sh2+dc/8MPIa8C/qzuoHuxuZ+YZK48GozOkPlFtITg?=
 =?us-ascii?Q?ALEWp4rf/yCSyorF/LWSo8368sv4UzCjYQOa/I0P5GWnMIZM/evrI5FVMnwX?=
 =?us-ascii?Q?JwfCG/YKiJKThr4a439hhNy/0LsI8Bu9Egv+ustsxpfLy8eTBNSFaGKXhQ/H?=
 =?us-ascii?Q?B1RzJRL+1JsQ91ebJB65UNztszCd21dE39qvm5+PgLuTueuEeFLbirXamcKj?=
 =?us-ascii?Q?cnL4LGfq36NLW/Hgof3ods+eeXTuE/OXDXO1jzNNyXy62gWFPEXnUsdlLeTF?=
 =?us-ascii?Q?3Q/GTmmRopoFvg62pppQHwFsAxBm4+lBM9ClmZVXSD9ScAEt7nd9/oOfdXF+?=
 =?us-ascii?Q?6yZfxPbV9hSyPphcHmkPUJYFyBh4c9fSPk/e0qpb5AzikWIZDPyRNObEhBzw?=
 =?us-ascii?Q?H39eDElaaCdNVAK/KwvFJEqB6IIu7B33ZPCFbrpxsSKq/nIrmomc0hzMzPh3?=
 =?us-ascii?Q?0wvoYdhgHHBPphywPALGefG7UMeRi67aHJC8JwfOYY82INIktOXyhzrmfa8o?=
 =?us-ascii?Q?4IM1p72ngdj2xmrzueg15yWeg7X2CCEFcIZ2UWI7hDcE+H0eGNVbNXCXVUcj?=
 =?us-ascii?Q?clskgtiYe2P3XKbrpYix+8l/U/S65yLYKYd4dXN7s12SOhJUBO5rh1Cbjpvv?=
 =?us-ascii?Q?IwjBWUWFStaUXJy8IL5w/Rd0gV63CmJXahdZEEr9C6sWBeGa0k/5ZbDKGQUz?=
 =?us-ascii?Q?bpRDeQWlluVmWErn+5ZHWBk6w9MUFw8JEwqXSueLz9TVbZKSRdNK1zCQ+15J?=
 =?us-ascii?Q?s4MlXbv/y4S6FHrf6tV9y5W19DB/iPkb0a9mrCzf6gUc8C/xQf6dZeVQerMm?=
 =?us-ascii?Q?R4ogyLvQ5WdDXgsuwP1cbIhDywBiONG/J9dA3ykujD8fShukTOZ7deNaB0ts?=
 =?us-ascii?Q?H+FQoUVA2mZPMYCmWkXhf7lsI8fzv+C/ba2ZzZhx5NjFmyaKu8BFfs8OXpMd?=
 =?us-ascii?Q?/nGdu/dSsZ4yjffIjKlnJyyw8TIMKRQt3dv8kD03YXw/mdtlfZSk+GDmYCQ6?=
 =?us-ascii?Q?es40olcKANDkMZOH7+eJBtubkNa5XGCt1hhzhgUZyMkdAyRALjI4qakSjexq?=
 =?us-ascii?Q?DESJ0oFurVAyZQh5wSyGqSWqcdyp4qZ77NgdIUV57wlFEPbIlBk1cYsVAbV9?=
 =?us-ascii?Q?oNvwT+hOig00wzJGWcr1LbONz+xT2nSUXeaX1I7cX3Zt+zLtQ2HSJrv4YeVS?=
 =?us-ascii?Q?2fsoplCqDNIHlK2B4jKB91S1Z13kH0OwhZmTztCJu4dUsjxzGPyBI3WSebZH?=
 =?us-ascii?Q?ZR2A082OvX3RBlU1spruZuf9SCNBI3hRP8Y3OUXMUr63iO7j9jJq260loPGS?=
 =?us-ascii?Q?H0f7KGvhijJlkBF7Gj+o0vEcLDvMdx3u2Cs1JxFuQP5keyWgMGXnJn7Stpew?=
 =?us-ascii?Q?qRsSva+CCTKr7cVSito=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5398.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb035b2-f0da-44d4-bd61-08dc383ed811
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 09:22:54.3409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zIkdOA6BK3GYHcvb/qAQGQrs4q7mChdhspH/w+U3s6uHGD7U1lbrWCooW3QwTZo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
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

[AMD Official Use Only - General]

Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: Kamal, Asad <Asad.Kamal@amd.com>
> Sent: Wednesday, February 28, 2024 2:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris
> <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: [PATCH] drm/amd/pm: Fix esm reg mask use to get pcie speed
>
> Fix mask used for esm ctrl register to get pcie link speed on smu_v11_0_3=
,
> smu_v13_0_2 & smu_v13_0_6
>
> Fixes: 511a95552ec8 ("drm/amd/pm: Add SMU 13.0.6 support")
> Fixes: c05d1c401572 ("drm/amd/swsmu: add aldebaran smu13 ip support (v3)"=
)
> Fixes: f1c378593153 ("drm/amd/powerplay: add Arcturus support for gpu
> metrics export")
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index bcad42534da4..1d96eb274d72 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2272,8 +2272,8 @@ static uint16_t
> arcturus_get_current_pcie_link_speed(struct smu_context *smu)
>
>       /* TODO: confirm this on real target */
>       esm_ctrl =3D RREG32_PCIE(smnPCIE_ESM_CTRL);
> -     if ((esm_ctrl >> 15) & 0x1FFFF)
> -             return (uint16_t)(((esm_ctrl >> 8) & 0x3F) + 128);
> +     if ((esm_ctrl >> 15) & 0x1)
> +             return (uint16_t)(((esm_ctrl >> 8) & 0x7F) + 128);
>
>       return smu_v11_0_get_current_pcie_link_speed(smu);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index f122ef49106c..0467864a1aa8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1683,8 +1683,8 @@ static int
> aldebaran_get_current_pcie_link_speed(struct smu_context *smu)
>
>       /* TODO: confirm this on real target */
>       esm_ctrl =3D RREG32_PCIE(smnPCIE_ESM_CTRL);
> -     if ((esm_ctrl >> 15) & 0x1FFFF)
> -             return (((esm_ctrl >> 8) & 0x3F) + 128);
> +     if ((esm_ctrl >> 15) & 0x1)
> +             return (((esm_ctrl >> 8) & 0x7F) + 128);
>
>       return smu_v13_0_get_current_pcie_link_speed(smu);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 69c64bc6e2dc..744c84f3029f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2148,8 +2148,8 @@ static int
> smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>
>       /* TODO: confirm this on real target */
>       esm_ctrl =3D RREG32_PCIE(smnPCIE_ESM_CTRL);
> -     if ((esm_ctrl >> 15) & 0x1FFFF)
> -             return (((esm_ctrl >> 8) & 0x3F) + 128);
> +     if ((esm_ctrl >> 15) & 0x1)
> +             return (((esm_ctrl >> 8) & 0x7F) + 128);
>
>       speed_level =3D (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
>               PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
> --
> 2.42.0

