Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3990C7619A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 10:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6955A10E15D;
	Tue, 11 Apr 2023 10:21:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8EC10E0D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 10:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEDniqnZ4BuCHsKkuL/pRTo8bsGzA6MBOS3iLJLIy7wW2EBrifsw8Es+wV8OB4TcB82ipaP+e3RKI3DdvBwos30RhFtjeoQIelXfX339fXf7c9vDg7rWWN74xHl/xPieGVGe0JSb0jsMn2MNrkGzQCJB8cNM370aH3c+BHJ7n+OOYpo15FSzrPzE3C9r1N9z5VpNcNYgxHV7zdPYEkPggOSpVodwWO9V9a738nZIaK+S5w/wjOT9xe1BfiRNrva0+DCoc0l2Fw7Xu2uZVUk3ZPuHzp5Id49f+c4BUq80sgQjKfCmAl211Mp5fnfpV3wbR28QHlFnJsOD7/0U8YdP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8fE95Nj0fKLJ04L+Zo46kHwuloJ9IHzrSwQ+TaeNLo=;
 b=S4rv8D/q36noKrLac7USeOPUWt6tVvel4ERq+08yiy5a9bcMFReW11k234Kr7wwhea+JMaT5KCPHHS6yHPl6Uio5lLowkea4vaUUiC/ibmmKZdULDOa2hNoml6NuYm64IImK6V6BUjdSz1zlPOH2/ZUkkdJ5ig+Ba+/o/WlzAoQOlSbb0jHMXd8X5ItCDoLQ6jRAq/8NqGP/ZIerFYGa4TaX6hGemMtkFrXdOA5WEivqKwg6W7RCZHrOGGA8Ac6jINLiXX0hSsD6Mo3iHXL1HmNwLqI5pTsrb70EPDQSGEhXt5iqF3g1/ssWk5Sf5h9NPXxYbUT//yElEJ21qtK4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8fE95Nj0fKLJ04L+Zo46kHwuloJ9IHzrSwQ+TaeNLo=;
 b=5M8nlRv89OpYHwSU5VtBgXgBVn/ME/+y5N+MtxSQhdQhTTBfZbr+w3GlsJ8O6HxE8DI5tzl0SxnzjRb+jF4FYrB6hl7Upn8D3q8ch/V3nxnVTgVrAJnkxrPp6pnVHHhvT9gd0nvZCfLMjtYCmv17cZjTa5UrUIDJPbe2jQqkJME=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 10:20:55 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::3f0f:783a:2620:4b1c]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::3f0f:783a:2620:4b1c%6]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 10:20:55 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: [PATCH Review V2 2/2] drm/amdgpu: correct ras enabled flag
Thread-Topic: [PATCH Review V2 2/2] drm/amdgpu: correct ras enabled flag
Thread-Index: AQHZbFiXJ9aKsxqjMEKBR+V6Nx5mK68l4meAgAADIyA=
Date: Tue, 11 Apr 2023 10:20:55 +0000
Message-ID: <BL1PR12MB5334D4073B98AAEBF3FC9B8E9A9A9@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230411093241.4644-1-Stanley.Yang@amd.com>
 <20230411093241.4644-2-Stanley.Yang@amd.com>
 <BYAPR12MB461415F709E73AC11316262B979A9@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB461415F709E73AC11316262B979A9@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T10:20:52Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=920c4e7b-a3f1-4c10-b7fe-fe3b91e14bf1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-11T10:20:52Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: ca6e3185-78da-48aa-b5e8-0c3014294378
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|IA1PR12MB7640:EE_
x-ms-office365-filtering-correlation-id: bcf94236-95c2-4602-ce61-08db3a766f6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Go1yQFIzN1K6Cjegk/9U0uxI6y6NEb35XAxItZBEug6Y+EuHHiGmmnotAPmSSfDXdvlYC1dCtOHMKAcc4ET8vAKww82bmTliISYp0DFjuj0sGnq32hVpw7wtJKFqc4KHyDu0GsCrFAz+qH0XfPuriBYqBPK9hsU/snCOmSwH1biJPqLcaM+GNhsKuDwVDDXzPolxrfstwW6FclAjcsVFdQvFj9yohR2rEhF0DuoSMP6mQlShj7/PTAh08nS9jThiJJTX955jKf0Volp9jB5zxTrsZCwG9Xja+X6fGBpV0xWEH4qW+gbsxhcBMd7Eo1E9f3+bcDxeoOCoVgM9eP45LikiED9bdNq3In8Yk+4CpkvzaTktgLGyBVYqz+sSnxLKdF5WNGyrxbDCRRhgrB5K2gDWbEfqpskcj/AZdC7mhMwde+ovEW+2xpN1Cesz01RXvrpAk1nNNVxR5QOaZInd7aVyDYVysVeIFkBHXUP0ERvgfexsCmCGx2wAtRexqbWr6TSjgvinQNENkzIidMQnoPq+XDVst+4/+0QwPRmBbBxt2VeK1lr+Vrw4kxDdzN1QRWI8FUy04JsU1jA1Fm3lx4ocYgKD4i7J8PQd4FDjc5yygmleOsBzXgdKppwJcECP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(55016003)(8936002)(52536014)(7696005)(5660300002)(86362001)(8676002)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(478600001)(33656002)(38100700002)(38070700005)(110136005)(316002)(6636002)(122000001)(53546011)(83380400001)(2906002)(9686003)(6506007)(71200400001)(186003)(41300700001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FSrxYpL36w3Yw0JfESAZxEuV9HdrpuatQfwmb0OjtjVlENmKxguG+CJNpr6u?=
 =?us-ascii?Q?JsC+hjHcQ58TTsNlNLp9th7TgCZ+wESStjS07L6ymfXIG9rH1mcYJJzL2NHf?=
 =?us-ascii?Q?07Qi8ptxDEsKFMIF9/rLKUnWXZAmHVhE4R6/GIlgDME4XktK2n+nuTUIrj7A?=
 =?us-ascii?Q?JYfUsv0VfjU21NgsjDsRTodM7il8bzdaPr4p4E2VUt8/4Dny+A1nTlQSvcWH?=
 =?us-ascii?Q?2ZA3d1D+lZ6YcYtslpOYsrp9Vmrr+SzRQboVML3qYdPBxmMhv2s770pWF9Of?=
 =?us-ascii?Q?RCsLaD+sN84HpNhTMh6EahXSt4DItcsJsv7ppGzO+EOo7muDaP1jNtiQRfa1?=
 =?us-ascii?Q?ED6mHlGM6PJJ8jSPYwSqMeeKhlfMPpYdZdr7cicklMeMtY3/xFwsoBdXHVYw?=
 =?us-ascii?Q?tKeOhiLAR2deu/d2p7CIXUGZ4O5nJHxWDwxeC00s6R6MOGeicbYrDq4u8D3D?=
 =?us-ascii?Q?peintazXHwJwoIJ6xEdHW0UC9uiBkoojvhqz9c3DtIRqUoVmw7ERllM+aXpU?=
 =?us-ascii?Q?8pLYGGiCle2tS+ZolOn1/Vw5XFHdZEI8WWv7EY3eNrfkn1978ar7XUEtTHNC?=
 =?us-ascii?Q?mhyzp+SDfL2S8G7ZUDBlx0Px44LDDa7WI2VpSqKSiw2Z4J9bUDnVjQ01zNJS?=
 =?us-ascii?Q?ncB4ER+o4uLhcZlHr1WFKd0RxxZyNiaKsjoO/dRQGxprDTP2Tx78ay8lL6pt?=
 =?us-ascii?Q?ubKj8cghYz+thyn6MbHi5a9UkKNloIErXmM3YluPVJ0fho6Vgo4UBg//k73+?=
 =?us-ascii?Q?Iq/AQjNrZI8DVyvHst0Rh01umekZLuryqFmBZofxwO+2Af5iiOC/M4C3cakU?=
 =?us-ascii?Q?xLgW8lf9+ix8v2p0Y0yJbJD/T4Ps5Hk+KYm2sG096iv0E1DWmF2YHGQ6XI21?=
 =?us-ascii?Q?HIJPubZlLuFOpwErDZxLeV8cGOYMo2U+Co4c8Wr9bl57lvHr4QefIffG3u1l?=
 =?us-ascii?Q?QEEVfFqWyzBr2HbqM1DgEqKs1dBTBnY5N3F5ClOxMisnfUbyqpuBJYgD8rcz?=
 =?us-ascii?Q?4hvNrMpoqrfcqTcSkKGUwsZG86W8ivKQQgv+EsE8xThoRfYLjQaL8Gkpgj3T?=
 =?us-ascii?Q?HYjbls0p5qVd6as33nNIA0pCe+BYjhwazEesbm5smZaxyf6Mbu6NsxcfsH5k?=
 =?us-ascii?Q?4ftJd446ehO63w78Rehh3jXgpTQttr4wMNaV3Tg+1a3Ou43S7SKmwFtxsv0D?=
 =?us-ascii?Q?4xetuaA/qXKC1JEJAfEW9I3dHm8HMUKE2bphsNnxWIupk4V2UbPuFmAq9LJR?=
 =?us-ascii?Q?p/KN+X0MRgZIkI4jQxhyxzoYo6rYSjFMmVFyFsHcrI1HQfoUeu4yIMiHHr3M?=
 =?us-ascii?Q?yM1+/4TEXGCjOG0EJQEY4oXA/R4MuWOjnpwsHKJyTvXYP1Ta00YQmbBX3nBt?=
 =?us-ascii?Q?8ErHTeVDtwNomSeZmC4I54ZpAqf3YT5Gw0+0K6b9gDcYjk1FZyCtUXEXiKR0?=
 =?us-ascii?Q?wB2symnJcm6yh4l1iOpiaLWWOqhbplawwDFczZOOYtHp+kDp8IPonoavBRm0?=
 =?us-ascii?Q?krgsqpyY/WashJVbxXDTUKuTewSlAoPCMw0D+QUaiDs3XLOqy3ZfGf3yK/b/?=
 =?us-ascii?Q?07Zp6eKASONsQsVzv9Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf94236-95c2-4602-ce61-08db3a766f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 10:20:55.2654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2N3a4M9abHq+fLGsickZhST64s8RB7bx4F6cYHuoayOdk+c32BshwPF4GwT4KquPdPlwOQ3wA/SSiuxjf1Pe0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640
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

Thanks, It's a typo, I have fixed it before be merged.

Regards,
Stanley
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, April 11, 2023 6:08 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org;
> Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH Review V2 2/2] drm/amdgpu: correct ras enabled flag
>=20
> [AMD Official Use Only - General]
>=20
> >  if (adev->gmc.xmgi.
>=20
> This looks like a typo. Should be gmc.xgmi
>=20
> Thanks,
> Lijo
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Tuesday, April 11, 2023 3:03 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chen,
> Guchun <Guchun.Chen@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review V2 2/2] drm/amdgpu: correct ras enabled flag
>=20
> XGMI RAS should be according to the gmc xgmi physical nodes number,
> XGMI RAS should not be enabled if xgmi num_physical_nodes is zero.
>=20
> Change-Id: Idf3600b30584b10b528e7237d103d84d5097b7e0
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 4069bce9479f..c2c4d978896c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2430,6 +2430,13 @@ static void amdgpu_ras_check_supported(struct
> amdgpu_device *adev)
>  			else
>  				adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__VCN |
>  							1 <<
> AMDGPU_RAS_BLOCK__JPEG);
> +
> +			/*
> +			 * XGMI RAS is not supported if xgmi num physical
> nodes
> +			 * is zero
> +			 */
> +			if (adev->gmc.xmgi.num_physical_nodes =3D=3D 0)
> +				adev->ras_hw_enabled &=3D ~(1 <<
> AMDGPU_RAS_BLOCK__XGMI_WAFL);
>  		} else {
>  			dev_info(adev->dev, "SRAM ECC is not
> presented.\n");
>  		}
> --
> 2.17.1
