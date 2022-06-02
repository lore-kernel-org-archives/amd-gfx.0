Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24275C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 07:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9718610FE3D;
	Thu,  2 Jun 2022 07:53:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C2C910FE3D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 07:53:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7547vZ4CeTa3PtR9nhjdxhrV6V9Mg/MwKcakdER79AIaH2nFigQ3K32D3l0B/NhnEgcildCw82EwpV3raqZZQtuVCtrBYY1vsWCaZYcVQhagE728CtOjMp1dYQUbZ68tf7yTs2h4RIVG3jYKUGQDJZkLlz9D00bO3hfQ689C1KkEDbcY5DG5rJkLpjEoRX4zYLzhvUcilh4fsnClzEks2h/PLwfsXe6iZdtAu7pXdV+DLuCO0V2i29XqbDVEFPCvk03UpFfKIr/YUKpbDeAwyywJmcuAYKW1+hs/0K1Wk6m333nloQnoNHlfJILjeVEmZOBDyqQpy4/0r9s2OK55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woP4YTsox+d6qV/cOyGtlRXzL2k3F9hO5CIvBqNckNg=;
 b=cR2wyI9/O/c9GT5QLmo/m6FRwbKtQ0Ihs8gJ07k9mFuG12y9z7Jd7i6/PF0Y1bX0q9x8UxDMROMGaHUjlcsAmZIIEFLyC+P2/qr85E1kZ+BUBQWa6XACSzyIhW0pSEAXNPbnfs9pJFBOFlgddvlcVqQdeWAhzZGxPhzO+KTRHhTT9Jk3C8nztyEvGor+y9xLaFQ8ohboGzgOlo2DBiLJHLfRfPtMaruKH4SPmlxacSVwSFXNrW80QdiJHOE22abI+z7T5u1oCP1UzqwkWQmcQg11SyjUZH41bOmBSySeF1Y6t6OubRd83Ng+LBdtMIMNHJSPE2McMBB4hfeEndCmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woP4YTsox+d6qV/cOyGtlRXzL2k3F9hO5CIvBqNckNg=;
 b=VNtQrWHqmSunv99zAP6GJh/MgF6JbG2LSjl0oaHpWqX4W5UIiUBuCv9soGSxbTgRRdc2D7mO+ZLLiXQJfrUi1V/BLNlswTqTwlhx4Ew+6X8+Z/9wmB+TOIX7LOC2fRyw6a3q+eSYeevuDCGMOLleySPZOLQK4/1ZZHXkW9D1pxs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 07:53:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::88c1:1edb:1094:3889]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::88c1:1edb:1094:3889%3]) with mapi id 15.20.5293.019; Thu, 2 Jun 2022
 07:53:57 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix up comment in
 amdgpu_device_asic_has_dc_support()
Thread-Topic: [PATCH] drm/amdgpu: fix up comment in
 amdgpu_device_asic_has_dc_support()
Thread-Index: AQHYb9yHrUrFZluMkkaH1wFaBusDda07zBWA
Date: Thu, 2 Jun 2022 07:53:57 +0000
Message-ID: <DM6PR12MB2619FD1619B84CDE7C88152AE4DE9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
 <20220525020926.1951685-5-alexander.deucher@amd.com>
In-Reply-To: <20220525020926.1951685-5-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-02T07:53:54Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cd0f8618-3844-4e29-a47c-a5e5bd29e4b3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a0882af-761b-4b78-6d99-08da446d0c22
x-ms-traffictypediagnostic: BL0PR12MB4947:EE_
x-microsoft-antispam-prvs: <BL0PR12MB494718285C1D7731DC055210E4DE9@BL0PR12MB4947.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRyCq9m3JEsASWk1EJ0So0RETUzKW/2KhjjvzOcZSq1RY+Kyb3zlLNabUgv6IunPz5IZtQr92bFN2nojl4Rz/jfRyDYieJW3rDQO0R7jRP6v6GoOY3xFlevZ0ENQ+U+s9kRbwj3LI4TG/Ds6tAp3gA4P4WsS/l7cgm8nZXUGX401VINxSDj1ddh1QyEB5Ug2ICVehHoRy48KmZe/wmMtBlaRctaGgAlG9+/o6/+KWhjop0Pz6Ue0DO2WUh4cpCa5Q4DNa2H31hosDqpFs66vwIn4cNTJh65h65sf8+hM6zapgbnHekF6bYw2mhXhp1FN4HXkgFJbt9VIRO657tTZEBtZ0z6kvgu+f7XAqv3XDqqYyUFOloMEraLBgl71HU0CCBhBKDJ+lqkAM1sjOjayDbNy0AwlZsQgmaWTn+5+cGNFqb22a1249LAuSR98nXuW17qAQCGSdKwVfXB9HSx8Uvoyi0Cc+gLbKpfqoPrLlBUkxFO+vMZ/sL69qwNxG43ySYcSl6pN7iSVfR5hp+8gtZxHolpd+4zEp1+FGa4/b/4CZwNmLSydYC2PoCV1LxrKKdwMZs+K+a0msrz6HNKkCKrQsMKc5gNNej7/srjiOTSeQuHsjJ5NmSP/8XahhUOA/JKkYFxTr6z4lCLQewy5qFYAbLskzlnhnJzody/bQCEMO/vOesBiFa3kxklhz4yGH6E8l4V4ztWCusvbRczqOQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(52536014)(66556008)(64756008)(8936002)(8676002)(66946007)(76116006)(66446008)(66476007)(4326008)(55016003)(9686003)(71200400001)(86362001)(33656002)(83380400001)(186003)(2906002)(5660300002)(508600001)(38070700005)(316002)(110136005)(26005)(7696005)(6506007)(53546011)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PBnXazdjNNvhqsNjvjUZJ4lP3VT5YYKLNxHPzjI2k2rAVNcwbKUh0nl8B3Fz?=
 =?us-ascii?Q?Wm78eOouk95NiDE7L+zFjc1C00S3vheNz0IIa/UTFDWqYOZ6zSuABwMBdHMu?=
 =?us-ascii?Q?o2TKTDGqNp+qZ6l6sjGA+i6MxBHdu8PanRw4sELBnMjepV3jcy7C05DJRFsP?=
 =?us-ascii?Q?Zzik64BZBb2+Xkvw+doPTgj2cjEIXJLd6f78nDCE16VKY6atX2xNsueJnqqV?=
 =?us-ascii?Q?tGTwsB8bIF71J871/Du7KqFOrD9qk5jzW8PpQb9OdwX2tg3sl7scYM7/Y8dM?=
 =?us-ascii?Q?lWKTUQkialaeK4IqtQGbcEooRj61UlAwjIdipr+XnxpwOV+sIIB9uHjETAbk?=
 =?us-ascii?Q?+wXrLv9xcNKjyKtI9pG/QjLuPA053IaX+KsttsYbqocDIkjNIU5ZJCZcNYhZ?=
 =?us-ascii?Q?n2aWcePyvrIBKl6Gsm0VqK1/YbyGhv5Dbzagtlgl028tHUBBhJOLFflTksWv?=
 =?us-ascii?Q?r174MLJtClwkCuGW6IAbA5Dkpf5K8DHaf4G0ZJ7IQr9kJMj+1nVUZS+bZdo5?=
 =?us-ascii?Q?jOUnWa06WKh2CPFqNeJO3RV8dyN3MPZgxfQ3vB0PVop5UPBhsGQ0yuF6v0ls?=
 =?us-ascii?Q?vOHZ/QtkPQkhOH3MCuYPNd+VL62cshCMKuRAm7fyO7C1rPAc7qrqMMPhwpIB?=
 =?us-ascii?Q?xa+RLPY3uJAx8aG0IGSeKTiShfl5dxN/IQaiZlmbzM+L4ekxMRSAblvbUVSI?=
 =?us-ascii?Q?nEqX9IecUFoNUVFKScUQ8I4nHKB2UuSyF0pdJGQeP7m9Y6aPJBePM/3o56Vb?=
 =?us-ascii?Q?iamv/KYktmMyBT66QhudIrck+U+rQEYasPQYo89WlYs8pDuBDg+Quj/FLJMk?=
 =?us-ascii?Q?hxuUjI/A+ld2Xp7ctOr1OT2MBHBjBEujB49HHoUArlN2setK/6goP4skCyrd?=
 =?us-ascii?Q?AWmH/Q739mSL5M8nVCFd3MuYC2+3piOI+0AU0wiG6M2mre+Yt0+WR5H0A+DE?=
 =?us-ascii?Q?6nGIZVgMs57SgKQRDW1YqPPBQHd8lfEgGqgxocngCF9AloXBLPI+PDRUHMCA?=
 =?us-ascii?Q?cHO8kzXERYLzy63K4Sr88p7N7pVUGliVZ7J8NeG//S/a94/697HJJM9nguSN?=
 =?us-ascii?Q?oPQGaoRjM1SQ0m8+ApRjqa6uDH4Bl1OUneyUb8YGTxjaUOvj2xHsZYjP/HhL?=
 =?us-ascii?Q?HIcGrCKOloJB0tCXOSoGrDL5xJ9b7+kNXcY47dJhvjHwHzj5Er+VwPip7tfA?=
 =?us-ascii?Q?bk5Cpj1dtAsphfGhiBB4JEWJqLWnyyZ6hMA45Ro/v7O5mEZcA0t+sJaidUIu?=
 =?us-ascii?Q?4Rk5jUhTI0LsJ3M81MUd7z0ewYA6Cqx4dN3rpbxNAwMgs/4cdjSFQ66qmAJn?=
 =?us-ascii?Q?wJaVVER8HmLlzuXvFencdAWGv2Byt5bdLAzsCFPfkhkNRfxDDpaPZ/zveVgg?=
 =?us-ascii?Q?QKCRsX8k0YaOaMwKDvTXGkaqB3AFYJqkiwHtUJc2idg1pydTfCklkQN+sk+m?=
 =?us-ascii?Q?YSmI/x5jtpzPcqYyQc2J/PCcdupThZoxnclhFgEjHGXbO/3ucxp0d6ygtXuy?=
 =?us-ascii?Q?3Vot6fpPMHAuAwxOnCT2Uinqy9BszxZGGi+DsVjoudlG7DcEUNM7mYvvpJkC?=
 =?us-ascii?Q?eprh2yXcPTR4YUXIibREBMvg2WAKBF74XwSmSzJradM+cZkbrjEcMpGrQp9W?=
 =?us-ascii?Q?wOHxqN5paFYhAAOp8Lg8fJ39qkREBQIjN6xUPnGyxgN/NATPibubiSQHIZl4?=
 =?us-ascii?Q?/VisouAphGR1pAzUjah6KASiFtmYSlB36Aldp9HI1a4PQ+MV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0882af-761b-4b78-6d99-08da446d0c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 07:53:57.1428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJ+9e5oTJ/DJBIFSowxHoRhD5aBWOGzMjGwQ10pmU627Y7BPQpOHsDth2r5IFTZn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, May 25, 2022 10:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: fix up comment in
> amdgpu_device_asic_has_dc_support()
>=20
> LVDS support was implemented in DC a while ago.  Just DAC support is left=
 to
> do.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index dab0c59bfb1b..fa26e462e750 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3286,7 +3286,7 @@ bool amdgpu_device_asic_has_dc_support(enum
> amd_asic_type asic_type)
>  	case CHIP_MULLINS:
>  		/*
>  		 * We have systems in the wild with these ASICs that require
> -		 * LVDS and VGA support which is not supported with DC.
> +		 * VGA support which is not supported with DC.
>  		 *
>  		 * Fallback to the non-DC driver here by default so as not to
>  		 * cause regressions.
> --
> 2.35.3
