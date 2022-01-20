Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F326C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 03:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C188A10E1AC;
	Thu, 20 Jan 2022 03:08:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B7C910E1AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 03:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXKdPAvCz1PHfPGjBvRhcBHJl4YBs7N9A+rRJQlhc4GtAMf09bPxiUWfoMlZQ0oofWErJQEGKws0XarIJkQCDJKgUI4dy4bV/Fpu/GCaKpNVI9EnT5kaP+filDY6zHqmAicD2gWKBqRjeO6hxpWR5zopMUOmnzgaOy4BOKLlkK+u/A4hhiYThD/GxOyenlXvOND8gPWhdoMyC5R/50fjt8v7666l4lIFdMDXUIUIkQ+jTSLJaVyY4TzwjR4Npys8PsioasP4j8gamjPgts3hn/FnTLmyA4ysgOnnNjxJXCfmumIJpRDA4g+M/uRUFVJzDykLaL6oOByF4G9seNhq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8roTgIPHr4n1cGMF1pUWtBUlCqfyKQKIUzro20LivnE=;
 b=MsH67nxub8C7cI6QuqOw3Xf6ZQ/6t4E6fxIAsHjOYjbL/b5IBWTa4Qz1niNlzncawGmG3slGze7OY5TYoh2K1hV5aHJ/60ZBzDBhbDI6TT86ST+6sUHD6MJsr7xeT+amYCLJa221i7XqYzqUE5zE6tjDcTyR/ky01WxVZZkf3kR/bH6R+m+MAqNm6WouoPdmmq47lALd4vxWL8brmnu7YLIk9Facjhi8pFgqLTxOT4TswaupidgWHbOjqKYhk2bgi0wBTTc129P74LPKBxaEES7Umm7pq/OZFY9J7tOYeNOpbcC710byRSLdri3U8e2OgkhhPcs+7INngciuEkpB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8roTgIPHr4n1cGMF1pUWtBUlCqfyKQKIUzro20LivnE=;
 b=ilfdOCTM0RjH4IDYci0+E9xu63e8ULHxJ0ZSwGuvu6Ar9jLF2OlnvZemrOmYpe8KF+SBm0VGKzI7IYe5ZBkaSM4+oqS/AMHwvZwLa7C5XsT0OMLwKy9VqvPjN90Na0q0x7IekeFPD9JdH9RF8Vm+l6LiIala0tDCCTwf7vEpGyw=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 03:08:44 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4888.014; Thu, 20 Jan
 2022 03:08:43 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: fix convert bad page retiremt
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: fix convert bad page retiremt
Thread-Index: AQHYDVGt9p7PI5hBckmFE0cwCAFdVKxrOwLQ
Date: Thu, 20 Jan 2022 03:08:43 +0000
Message-ID: <DM5PR12MB17706494E096534E744A9300B05A9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220119162856.30286-1-Stanley.Yang@amd.com>
In-Reply-To: <20220119162856.30286-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T03:08:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fbf9648d-598e-4127-be77-f9638b4bce7e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-20T03:08:40Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: db0473c6-8758-43f6-9d7e-cc4c3a6ca4f1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5df8809e-b33b-46b0-3f41-08d9dbc22adf
x-ms-traffictypediagnostic: MN2PR12MB3949:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3949172A7468ACECFF23F059B05A9@MN2PR12MB3949.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jcX4A+3HQQNCnO7UDUi3Aw8A2dGt4s/mEZkgRYxWzQqzTrtc4Z/g0J0GQcmN8pBqPAmD5/XHfU0cIjYF9fyaZn6rX2+fSY2KHH0/RmDcyx7XI9xpMSH/ZzRWVFjBCKLjIVtemDkP6ikflLyDcrIk2AmeWiT0eod3pUo6ynJLZshsjokrwnDszYewJWMUvNE052BULCm2JhPH2+ir0D0/AJoIRXd/KH+PLa1/U4QLEKznFJ9lPK4WIvlGKEr7bDNlJ5NILmGxzR4WK7/HEaTmsFLoGBxTJKzrBJD7Ba29PysRD41V0rfwlN8TxQYAdEYH9uZV619EXBq9nyO+IkL2CY8y3L0o9Y1cRmcSwPGB3xqeq9PDMJFMVgj1Qbt2rJAqjGib5UTpCcebucB4o+meV1fwvGvvbfDwEFOz4dgU4JVJ3pR9Ril04B6hqBxYDMreIgwm5HDTQlC5pzEZGubEO5C8aY+ICQDiE/7wAJvioVO9d5e5nVvVy8jZU3DxFjJKCTXIhU3daH92CNkoGnTI48oZeMFCAHKT+WowX8qIt1Yl0dlrsiXd3UpYHBj3xZSjLv2TImjJp7bepE+eB5I79isEotcMm5RyxmGrCW3s49/MnnFAnRLOBHaTzRBGW2dFICBcvXL9YYe0K/MYCLcG3nf0Z5/vNhmzkxa1gxWjEuXooHy+fofJFMAxqp/TJHYE7rivFx+TvlvpX5A0UcoBZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(86362001)(33656002)(66446008)(64756008)(66556008)(8936002)(38100700002)(122000001)(2906002)(8676002)(38070700005)(7696005)(186003)(66476007)(26005)(508600001)(76116006)(71200400001)(55016003)(66946007)(54906003)(6506007)(110136005)(4326008)(316002)(83380400001)(53546011)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7RjZOJ34Z1nxEZL5EBZw86bmDkqyEuCfIvVQjth8xcS/s3kHl8QUI6uz+RY+?=
 =?us-ascii?Q?T7L2VSrYTD3HTM+1Ix9rLWJCQ6EjpP/aC3BD/5JXvIUfSGRKy9u8VwaZ37jm?=
 =?us-ascii?Q?QwopQNXibUioBCHbTc7dEvIflvsApAu7JsVWo8eI4Ad3r1vx1trwh+caG3jP?=
 =?us-ascii?Q?cxVnmajA7GfqRif6IFKPhWACIHjJC+cYK3fl3S9uO4lhQbM/xEN9qo4I9u1i?=
 =?us-ascii?Q?YO2YH71ItEKU5Zq1nKymofXHNbK5B9RgWl3SOZ2A5iHCOZIee+pO/kXnVfh1?=
 =?us-ascii?Q?MU79ZHtObfC+rHqwpNUajrRCVWTnEX56twNRQe/35vy0eq73W/5xVfsGIQFx?=
 =?us-ascii?Q?7J/DNnY7LRaDKMQ/Pv511LvkusZNuOPTCXjovjAY0NC7aqLn8evunkYrpwsy?=
 =?us-ascii?Q?THNJULd4dntQ8bOsEM0Ozk5pZEGGqTRuTnhW+oeajA6qWj3AzTBSQrcmxvsI?=
 =?us-ascii?Q?n/vhpss1J6h/VAKvA9N0Oo9kvK4PCd5Zbxn8+3Tim3jCD4qKn4+jD7Q/41cJ?=
 =?us-ascii?Q?wAejLjkLDju9pWTzQ73eZcF8Ht3JlRjRwMnVkL/IlBH0/tYwqNMIM98exUMu?=
 =?us-ascii?Q?5tvIvoZfLXp2KQCjaw4bCKaftYM7+wyyd/cS8Vgt+lFyXM9SVWma6S5ftmwt?=
 =?us-ascii?Q?wgS5F505Y5x2ZKUtHhdndMUW4qAlCccN0enThyTF6xUET7BFsYblONOAHNq0?=
 =?us-ascii?Q?+i/bqNmRNTr6/4IOg1Ye/danEPHn16P+/12SNQjPqVpgY0DL+O4sVVt5Om/t?=
 =?us-ascii?Q?FnnHb7+XNZAZqeAv67uz09pLd/d+r6OQ5meODF6IoayfpkNF90y3fNsZEItg?=
 =?us-ascii?Q?o4/AldMXVXlP4FKHrsfrsda3KETEtJiZtQEk/fGU6vlKzYfvOr/V7iTTO6u+?=
 =?us-ascii?Q?FYQ1I3qZAl/+8nLS2mONTM781WsKUU9dEc6euOC1cF+XLQg/rRpS6H8nT2e1?=
 =?us-ascii?Q?IDNlVVPFqnr+iXqyhLyDqsEExnYNXhGakovJy+cCKSec3griqovJ0MZwOaq/?=
 =?us-ascii?Q?WQVV1rhcZHAMtcxrop+840/ou4ZIfMIZzUNP4TXkyLYjEz5AW1Y+fFVPwjGd?=
 =?us-ascii?Q?OXek/SuBtx/+zW6Xgi8izTDm/QHXzGx+tNCYnPAJCZmOO2doA7HYXRTj2Xqb?=
 =?us-ascii?Q?UCB3OOcNrDuUxNcmjb2NQqxzpClcMpzHXD8If4TPp0dn0/r5cUq7wgK7AVsG?=
 =?us-ascii?Q?ZL54AAzGGXIZ2V4Zy9/oj0w/QKCTur7pLlUobF3vSqMCEsfD8FBmKGaLzO+T?=
 =?us-ascii?Q?JN52J16JfaOP2/G2AqbX9z1OyG9IpOkbn/yu4+8/dTdQyGeeEab6/zUEjmS7?=
 =?us-ascii?Q?kdcYZSHyixxsQOounntrQnAlx4E97M3Mbh+Z0GVpeZjmouGh3ycScblYmXr6?=
 =?us-ascii?Q?1HI+Fbyu1JvjVoyLie3SowyXBJnw5qP8bHec0DL8lUYHnv0cQsNSQARa5H0B?=
 =?us-ascii?Q?dqvtzv0OnkaeStlb8LJ/W5EqbukvbPhg670aA4g2cKTYEAHFY155MFp+GCLP?=
 =?us-ascii?Q?WeYwR930hBidyZuS8NgEWGqDO2PCZWtrRw4cg4GFiGeK+5xNXw1xruMpmBYm?=
 =?us-ascii?Q?rQ2oDPhGAcZGM4HsZ3k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df8809e-b33b-46b0-3f41-08d9dbc22adf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 03:08:43.4985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjpiKd/TjtP922KTpGRWc9j/omxmJy7KKiX4Ijky5QyHmZqxL2pY1f8If8ZPGPJa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
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
Cc: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Thursday, January 20, 2022 12:29 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Ziya,
> Mohammad zafar <Mohammadzafar.Ziya@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: fix convert bad page retiremt
>=20
> Pmfw read ecc info registers and store values in eccinfo_table in the fol=
lowing
> order
>=20
> umc0 ch_inst 0, 1, 2 ... 7
> umc1 ch_inst 0, 1, 2 ... 7
> ...
> umc3 ch_inst 0, 1, 2 ... 7
>=20
> Driver should convert eccinfo_table_idx into channel_index according to
> channel_idx_tbe.
[Tao]: typo, channel_idx_tbe -> channel_idx_tbl

The patch is OK for me, do we also need to apply the update to umc_v8_7.c?

>=20
> Change-Id: Icafe93e458912b729d2e30d655fd68be0e12124d
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index 526de1ca9b8d..f5a1ba7db75a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -58,29 +58,33 @@ static inline uint32_t
> get_umc_v6_7_channel_index(struct amdgpu_device *adev,  }
>=20
>  static void umc_v6_7_ecc_info_query_correctable_error_count(struct
> amdgpu_device *adev,
> -						   uint32_t channel_index,
> +						   uint32_t umc_inst, uint32_t
> ch_inst,
>  						   unsigned long *error_count)
>  {
>  	uint64_t mc_umc_status;
> +	uint32_t eccinfo_table_idx;
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>=20
> +	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
>  	/* check for SRAM correctable error
>  	  MCUMC_STATUS is a 64 bit register */
> -	mc_umc_status =3D ras->umc_ecc.ecc[channel_index].mca_umc_status;
> +	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>  	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
>  	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)
>  		*error_count +=3D 1;
>  }
>=20
>  static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct
> amdgpu_device *adev,
> -						      uint32_t channel_index,
> +							  uint32_t umc_inst,
> uint32_t ch_inst,
>  						      unsigned long *error_count)
> {
>  	uint64_t mc_umc_status;
> +	uint32_t eccinfo_table_idx;
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>=20
> +	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
>  	/* check the MCUMC_STATUS */
> -	mc_umc_status =3D ras->umc_ecc.ecc[channel_index].mca_umc_status;
> +	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>  	if ((REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1) &&
>  	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =3D=3D 1 ||
>  	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 || @@ -97,19 +101,15 @@
> static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device
> *adev,
>=20
>  	uint32_t umc_inst        =3D 0;
>  	uint32_t ch_inst         =3D 0;
> -	uint32_t channel_index	 =3D 0;
>=20
>  	/*TODO: driver needs to toggle DF Cstate to ensure
>  	 * safe access of UMC registers. Will add the protection */
>  	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
> -		channel_index =3D get_umc_v6_7_channel_index(adev,
> -							 umc_inst,
> -							 ch_inst);
>  		umc_v6_7_ecc_info_query_correctable_error_count(adev,
> -						      channel_index,
> +						      umc_inst, ch_inst,
>  						      &(err_data->ce_count));
>  		umc_v6_7_ecc_info_querry_uncorrectable_error_count(adev,
> -							  channel_index,
> +						      umc_inst, ch_inst,
>  							  &(err_data-
> >ue_count));
>  	}
>  }
> @@ -122,12 +122,14 @@ static void
> umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
>  	uint64_t mc_umc_status, err_addr, retired_page;
>  	struct eeprom_table_record *err_rec;
>  	uint32_t channel_index;
> +	uint32_t eccinfo_table_idx;
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>=20
> +	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
>  	channel_index =3D
>  		adev->umc.channel_idx_tbl[umc_inst * adev-
> >umc.channel_inst_num + ch_inst];
>=20
> -	mc_umc_status =3D ras->umc_ecc.ecc[channel_index].mca_umc_status;
> +	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>=20
>  	if (mc_umc_status =3D=3D 0)
>  		return;
> @@ -142,7 +144,7 @@ static void
> umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
>  	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 ||
>  	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)) {
>=20
> -		err_addr =3D ras->umc_ecc.ecc[channel_index].mca_umc_addr;
> +		err_addr =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
>  		err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
>=20
>  		/* translate umc channel address to soc pa, 3 parts are included
> */
> --
> 2.17.1
