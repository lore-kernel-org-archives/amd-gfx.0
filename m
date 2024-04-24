Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92B0C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 18:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EFA5113D24;
	Wed, 24 Apr 2024 18:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="26pqsgTl";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE20113D24
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 18:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0ooxESfZ6XmfK54YVSgezz4AlXzwPqMXmhOwEVvygshCy7AvgyPt45m2CIlg/Hg4lP7zQCzlhyUW9b54yIRNEFF+q3fo93G8zn5AkUPIrf22yjBZYs7+ofmr1kr7DM+Elenug53eSkKXYbW3+2rX2QQoPDjsW0/gw973ErRWy53UIYsDIXUEVeUZWUUxgOAvhzuinyFJzxfky1oAQc9je518SBYWGXJAF0tooBsWGdDhLf5kJ17nG8dUH/g9EFW2cKdfQninLliutXFJKrXbzqSX9e/I52Q73xFCR3Qf9sF+0uaOndw6ZRZG/7DcnHp1B2aI2I1pogvtl+iFA/VcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyOGQkKxt+4dxMiHfjR/byjMuSFluux35BKBlCtnyF8=;
 b=Sn6rTBx6L2gCx/We9LV2f/N4rxVfYb6NyqZ/f37BE3DqOeTBpe9Vvl1U83yXh4IqaL1cWCh6YgR17LSN2Zf3VWiUFg7Nol01G2gbbyPDF17tTrBJdBu8y59cf60T6ks3iF6bQHtd4TEtLitCdWN4jpjVJ+jnp0h7AsBwmtFSTz0ER0CG+lK7ZR0EI4xpbyQ2CMxM3zR1Ld3IyHiiMu3N/Y8W9V6p95A1uRb7t8rM2GH5Ad1CdygL+0qbs+lUULrXEX/tKw20S9aF7COaUtyituuZ9sO3Vaz82kkDKaxcAs4uJLV3wTc0gtFLyl9kE3cap0BTG32CyMYv1lPBP4eaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyOGQkKxt+4dxMiHfjR/byjMuSFluux35BKBlCtnyF8=;
 b=26pqsgTlF3vmmUeIcYI9cYQzuvsQukTqcplXxzdUDE4NdzWeflx0kLtPSdy7wOVUL7N13iebwYc2Esxq44JVWbJV6Qz7puBV4iW4z+k/CFOzEUTQ8jVYWWPGF6F4pf8wE+Wxt+BKXZor/tjb1tzv6hCDXAZA/xBkw4H7lgf6GXM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 18:21:25 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 18:21:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Fix the uninitialized variable warning
Thread-Topic: [PATCH 3/3] drm/amdgpu: Fix the uninitialized variable warning
Thread-Index: AQHali69DFCmUAFGM0mSkJ2JLWnRO7F3u3fQ
Date: Wed, 24 Apr 2024 18:21:24 +0000
Message-ID: <BL1PR12MB514461A75D55F8E8C089606AF7102@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240424100343.608218-1-Jun.Ma2@amd.com>
 <20240424100343.608218-3-Jun.Ma2@amd.com>
In-Reply-To: <20240424100343.608218-3-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4fb0d7bf-36c6-4638-994b-1432b78d68a8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-24T18:19:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB8454:EE_
x-ms-office365-filtering-correlation-id: bee9fa3f-5994-4cb7-6692-08dc648b5978
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?1pg/0WT9cMpl/WtWJMjfhCasiGOm01hO5aZ1qMmMcfLKpXOyEn2rwjymKFvS?=
 =?us-ascii?Q?MPDT4z5QFQuMQeIcOw6wblqfr52HxvBnDnxWkfhXTT48aBLohhJ6Yk2crlpo?=
 =?us-ascii?Q?XQJw7+unmSgm+PjSajYLhGNTGME0YgoQC9NuIBiLNCtsWZ2LtSNvQjIIfQTe?=
 =?us-ascii?Q?vGt5b0CA5apwYomoPIVPyk0tHZW1hT2TJXh8dx7MEX3+q5OoD+wmWe5TbIYA?=
 =?us-ascii?Q?KvDXxsDX7URGGHR37QoUEK+nCkPi7bCiOokvucrrVOoB29j4r/CsU69OtyPq?=
 =?us-ascii?Q?PCLzvOxrZYIullBjPC9w0sRE25qK8kBDqL0U49sVaAHHheMaWQafs79VVJB2?=
 =?us-ascii?Q?+RyyWgD5phU4c5XgyO6n4qtCpBwAiridPbJ4krkZNDt7Jmii0eC7XSldfyC/?=
 =?us-ascii?Q?yh2Ske3B0WU5OZIrXAmoe/U70GLCAV6rjzb/J5MQhT2s32j5IWDN/rMoBjbY?=
 =?us-ascii?Q?wY7djmKlr2OMdA5FDYlf5UTUqvik0feS9V57BYHW1394HDeql3qHTuf0lQjf?=
 =?us-ascii?Q?F05qyRxhub44Hndt93gID+ORLFDMN/DNAYWeLTd798fil2cmGjH8yQhjUMsR?=
 =?us-ascii?Q?J49n50icFioYSI0IQstVbpd+iZQ0nZ7Fldx0dFslb5E4Byb+jG/I2QJmRelb?=
 =?us-ascii?Q?uN/UbwK5sspy41OpkwM++cuyZs5VhZ7kIGLFC74cpCOpth28LjafkCaprHtN?=
 =?us-ascii?Q?lQKs5xTFYEBUR/oyEF+z+ypZBM/c2Qq4eaYLv6kxGPhgwg5iNje7q70nRMee?=
 =?us-ascii?Q?/3t6lFlgOJqhjF/gC2odkJLvPEWKGQq4A6gPNzSWICqVT9VFWDOEt2eZ2wI+?=
 =?us-ascii?Q?zHoRBvIH7rP1yWJJ3E1x7ns+RbcyN/xntQAaGNbOaIVurp8N0IPBetHAHOKF?=
 =?us-ascii?Q?pDeCPkyPkhg2rQBjoGSqgkEivBNCFvt3Il/9/0/N8jtiISodAFf/9avmIeRl?=
 =?us-ascii?Q?ffJMo7JcuV3hPZs/ZozSX8tC0iiNyXd97BSkJn1SwNtcIzyzLb2nLHy/OfyJ?=
 =?us-ascii?Q?oMOxDi3cOkl/TLJdjdQPq/Fe+PunEdgoIiqeKESYxtfkQHWU/CphgHHLOJmX?=
 =?us-ascii?Q?qWVjr/zdMIF+bgEMzlbQDnz0DtiBpilrTyOODFmX6bUlfyc30mFuZrN6W0KL?=
 =?us-ascii?Q?XITPXdb4Y1l52mCF1W0Ux+gk/KoDX6w/HNoSAUIdKimS0jEAkb/gQ1OWSOON?=
 =?us-ascii?Q?ICGE7iX8JiLbE6EPNoBZc/TJZ+h/4UfBCuNMKFG4rPeeTrdpy54gHxxRM33Q?=
 =?us-ascii?Q?sHfxEhjCj2zawG2d98EvdQEQhAa7hEgDO7T1zCLtD3U+senjXWaRTVDp5yHZ?=
 =?us-ascii?Q?jfoSIr1/HEe78RWhtTkt1Ijgz4ZPIjldFWBSAqQvnqQDDw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GXHmq49wexmRTOMyBWun9IJa7GSHbsKry4vM3g5d4vXvhAc9hUzeCKht+eGm?=
 =?us-ascii?Q?z3wFdNYiB0/Ys31fPm7nAKYMXuIHCIe5AUQCYdq4/0oyIMRv2/KDmL7lyY7J?=
 =?us-ascii?Q?YeWyb/zKHLlvgoDLae252Kjb/DCft+iDv+bMk5YpkxHvOK5CU7cY+AKv/Nva?=
 =?us-ascii?Q?bkL+yVZh0xKvpgOp1Q9CkSYlUA08KwVJmbiA70Cj9eh3l5bBP7/RJIRxiKsG?=
 =?us-ascii?Q?M9Slc7W3i+fl23jj7jTHQrk6KLQKQP8FOMLgMKeMDlgxSU66I1lcTAsnI+LT?=
 =?us-ascii?Q?km9J6E0C0GUD0JyEdXlccEfRKgHI3ySrNZrc7tlHKm3vB9BbkE3TSCzrc7mi?=
 =?us-ascii?Q?zPaeMeBQ4RwkypiVlIY1Wf6k/fBEZLvNMqcJr6nh9qJOyIAO4vaWubI8i5UU?=
 =?us-ascii?Q?NESz6ww7BCl79iP3A5WaTh+gvjs/KRsBLBBG5Q5UqIZCZ47z/YIK/CgcHIo4?=
 =?us-ascii?Q?gCLxmXKZLDnJbq4JkcDLobCdbF0fud/nzV+7ABZKMBlLGw2938aU1TDp5xtO?=
 =?us-ascii?Q?acS5kspbVJ4vbKi2nYBZnvmaq4YDa1ZQQ1PUATkSGUamI0cspcYWY9PQBoV6?=
 =?us-ascii?Q?cCfzEgsPtZMOtvMHaW1t8mWsowX8pQFlu7bTdxdTsYgw2XU/m1CVp0Xw0gCB?=
 =?us-ascii?Q?1vUlzL9NOoKRaxSx4iuk3GpCncEcKdlL+YDMTbZA7aj4GjJgTC336OQJZK+N?=
 =?us-ascii?Q?2r/TsneV3C8D5GgMV6jUsCtPFxnoLT638RamS5aj1/Vn/B1B6lIEqzxZJtA3?=
 =?us-ascii?Q?Vy+qo90p5DadLGEEMz8januGEUuVltUw6HNr06Km1hfvTXgbCRNVWOiKwOlQ?=
 =?us-ascii?Q?rrUSq/DsRqTnM6FbpeZAkNwmmC/amDaYvjRRvB+v1od2syxZ58MZHfmBsWDg?=
 =?us-ascii?Q?h9yJwueoh96QJu738cFO/OJfo9GnV6g2BQaqv62jDPWJhHxoqGWyov8q63h2?=
 =?us-ascii?Q?pfUlz4AJOubfquwI+ALWeaxz1rQVUrfhFUMUFdu5wACGhw8RmxdjINrTOp32?=
 =?us-ascii?Q?ajjMtQefVuP21g1vBvYVmluSPX/Obt6zxXWj9bDgrbcNkx4TfRTc6+9odMTB?=
 =?us-ascii?Q?TO8fNdBXZ9ZDHCACBq+3JE/PkoJv/0r4EzElx+wcfia963R/a6tkQ6L7LHvs?=
 =?us-ascii?Q?GyFpVA7KUIhPqcPpZNJ4/FFDDCVB8T2Mk38l3JpMVEAS+gpoA5S7PtUl+rMV?=
 =?us-ascii?Q?qukjFzZiVwgecuveT5rJOCGBiKf1sW33JvSbVv+xAWcpTbJPdqxyqHYUwyrV?=
 =?us-ascii?Q?AdC9U4bn91PrfDpPjR/EWqn4PgTmcG/ChxQgRDeiZeTTrBSEFvj8Jobn6TKB?=
 =?us-ascii?Q?Niwjml1eMB47mEK0lGz1u9SSZ5S8GtAMccR2OTu1QzsSaRnU7wakhBuV7ly7?=
 =?us-ascii?Q?mOY5imnyGT96hopZqnSup3frgxQ/nXrI5DsV0w6f7AndWnuuTi13Yd7SEnF8?=
 =?us-ascii?Q?v5dZmXoEndQfshwFaXbBGYlp7jYUv+yzLvSRrA3A4i5PtGKckEa5RHeeDgGX?=
 =?us-ascii?Q?7hA7mRr16U3wqYbBREfsAOfJj/CJFmbSHuvYoNulXSpSJVPkI99USUiWZHu9?=
 =?us-ascii?Q?kKJ1gO+ojQV7hqr2VLU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bee9fa3f-5994-4cb7-6692-08dc648b5978
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 18:21:24.3935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGsxu3PFk3iNXrXIOlebdEzaEPryhG/Ce9iDowLzKQNxBivyxljFM7iEh2EAPDF/4BqlV6wFlgrH6KnMp7jFQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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

> -----Original Message-----
> From: Ma, Jun <Jun.Ma2@amd.com>
> Sent: Wednesday, April 24, 2024 6:04 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: Ma, Jun <Jun.Ma2@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Fix the uninitialized variable warning
>
> Initialize the phy_id to 0 to fix the warning of "Using uninitialized val=
ue phy_id"
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 8ed0e073656f..df81078aa26d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -95,7 +95,7 @@ static ssize_t
> amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>       struct psp_context *psp =3D &adev->psp;
>       struct ta_securedisplay_cmd *securedisplay_cmd;
>       struct drm_device *dev =3D adev_to_drm(adev);
> -     uint32_t phy_id;
> +     uint32_t phy_id =3D 0;

Would be better to return an error in case 2: below if size < 3.  Otherwise=
 we are just blindly using 0 for phy id.

Alex

>       uint32_t op;
>       char str[64];
>       int ret;
> --
> 2.34.1

