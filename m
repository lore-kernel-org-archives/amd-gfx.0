Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39670C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 03:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC7810E10E;
	Thu, 25 Apr 2024 03:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2a54VZec";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89BF10E10E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 03:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBuD+3cSuqwHL00VKFf4UJfwFETt3qjP1QalGvDTH5eN5UXTc2bDViIjoxMqNDW7E7N16Arg0TPkD/HuYGvk7727GILTTPK05xxzEcLzmM2aZDV8uNAQclFpcsnf783MQEPniBrzNSqIhdJNyDRzd+JxbVHpxEx0D+K0Ks6xjGW00lmElidXWA+il5EHEHe4qVzdWAifNmhC761881sT+9ZID8YXLlv3aooGHY4ALh4PBe3luuCZVg/lLjaKNH87hjauaX8jOXunf9qcrrHHvZ19YekqmRCczn/pGIV3YObd6oudHtjOPwA/GAME/7IyrjghpvoiAGtQAq0RUjwPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN3sLl94UVNakM5M0YJ7nvo3kzrl4YgYDmLzBCXPlP0=;
 b=HNArP5j626em/x3Lyc/Ng+CFGp9TQ3ziTma+CZWDfTG8VI5YuEcarKPyVmOWRhpTlSnbjLRA/ocHMIwm2rnM0ehkPMSIzwFI3EF1W5V/SFEuOmsxxc2oGmV7Q/xosLX4R01Spsq9BBqKoYUMZrb67edAEYtOBmkrtkTJZEyFbkHSdwvK9oaix85ag67GaPHmiItqicnUEZWHWTJEnwSiWw8iAOCPp+CT+tNc1CZo51M+TjnLbtJktPOGYCANaJd+1itfBm0qj4Gext/KDoy3U2kX/z04Fb0GJv7oLIBYGhL2stQUIknBdgF9/sDXfjsKJO7NsrRbixyRogzGS8BzsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN3sLl94UVNakM5M0YJ7nvo3kzrl4YgYDmLzBCXPlP0=;
 b=2a54VZecBS36RuNSzOtRjy6renupoZC3mt6UHiwzjhvWOm0ftgfDfi9NJl/9a2Ux/ZAtbw17NAgPS4+OurXUs6InMu7e9y0zPBI6ZzKfQ35zDXSHwNMld4g/Hze+y2RtlMvpiJFeAzFA4xZsxIUa/26i55c/6qS12bkunTdbaJ8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 03:02:46 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%2]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 03:02:46 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 06/15] drm/amdgpu: umc v12_0 converts error address
Thread-Topic: [PATCH 06/15] drm/amdgpu: umc v12_0 converts error address
Thread-Index: AQHakTzE+oKU8vHgNUuI5vz29JNQFrF4Vz5w
Date: Thu, 25 Apr 2024 03:02:46 +0000
Message-ID: <BN9PR12MB5257D9C7AA4E63461DEC8166FC172@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-6-YiPeng.Chai@amd.com>
In-Reply-To: <20240418025836.170106-6-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8002210b-ec5f-4ac7-a188-2a36b0b117c2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T03:01:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB8193:EE_
x-ms-office365-filtering-correlation-id: 14302300-9cb8-4e57-cd16-08dc64d42f29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?/uYgluOXfduI349Mgr4DtngHbWutsDYDnvDQMNlM8EL8SgYtHXJqqLz45sfd?=
 =?us-ascii?Q?7AKEkpFeYqsrX+AkPx1uykEY0uehK/xYmRlsxhsUKrPKJPiDn6MKEKUk74ud?=
 =?us-ascii?Q?A4QpBkZ3c6siYxVhnwU3eCqMMVhsVpdic3EHsEWben7SFWjqgQ1IKDIJICPh?=
 =?us-ascii?Q?nPqoRY+bqecI0Q/ZTTf+NRHTmn2Kz97meFQROQrCOfC3r1jfeuiyajsDYrhR?=
 =?us-ascii?Q?fst7O5JZJbczTpHwwfgwse6UApBji9QbAK+yHeCPyPvHPYVjujq6ajSbefIn?=
 =?us-ascii?Q?zWijQvo+h9w6j1D0voyrautpmtF5aHL99slpylXNhIXlpapGpg6/Bi331GDR?=
 =?us-ascii?Q?bYhfKaBnHDMTBP4b2C8z3ERm0QiCFANzccitkyDHxXpOam/xVcr65IIoeDIg?=
 =?us-ascii?Q?3po2joKyA0kerBgMMTxS7NfcP/xppfYp3I1MoOvyIPDn2ZXsTmh8BCYDRF56?=
 =?us-ascii?Q?JESwn1UrKR6EFWxDxacuQ9ZLyTsqNhARa+H/ymjIz+fCC/vnvSWlRT2lMqU6?=
 =?us-ascii?Q?zdXG+NL9jxF9Ey0KPn2gqqj/qZgrEuUY27GBPNLGBQHN0zEKn49DzCjAr/HX?=
 =?us-ascii?Q?lWjJcyvZfb89GTxcSILdhZuK29Q6xdvU1SVpIeyqe7JZx4dVX7TFJyZkPP7N?=
 =?us-ascii?Q?g2vEkt+1V267lKuglgydo3KWhBewW/FEGuEF9dtnXYjUIN5404aZSdHk+SOe?=
 =?us-ascii?Q?enOFOxoKQPpLJBedjmB6WhUoupMDhPeSbM7fg0WnPO2Fb7cWydGl7qNpFctx?=
 =?us-ascii?Q?ue1On1faPTQcLcNw3j5Q5YrbHPf4h4TTqg+cGcqtFK9kB24Qbe0IfndgpwZC?=
 =?us-ascii?Q?C1k35HCss+ySK5Bq8Mi3yuhAA9Mzt1fis/pqwZgN3TbLr1RAwMZCzWGtZq2k?=
 =?us-ascii?Q?BYNpHEZ6AXEA8Ja8PiDZfwnZPDgDoauziLTRgZhndhGq17lRDEgQxlgJ05xH?=
 =?us-ascii?Q?2MavukoQAFD95HdyQ0BKvPbDUy8MXK4AnIOQpwCXESnXm8vJTo4irO+xAZiN?=
 =?us-ascii?Q?pQ6pCogSFfG9IDIqBY4r3bUKQeDVOMd8CgHWcoKq6IKvVvjE1HWidc/SJQPy?=
 =?us-ascii?Q?TsXdW/Q0z7uA/YShMeURqndZtM5otmGMiVZ3/8ArqsY2TgaMGN6HnteTf1Vk?=
 =?us-ascii?Q?KCL3JEmqBis2EUIKV8nDo2OQFyQoo0QtHWHdNekf/JuQqxh+/uBdffQsnq7f?=
 =?us-ascii?Q?/ycaQVSxY4+M6z7SG2DWyq5aSTnrlEM5Jr+8EoE0G1wurCdjHbiibOUlBO8T?=
 =?us-ascii?Q?U0F0yx0rcKoUG8qIBsEsSv0P6vTRdcOfPa63Q/GWThUh7KiPWq+AZFL7OBs/?=
 =?us-ascii?Q?L0NUAFHZCkDyT4e1Bct8YZvjaEAPr5wjnhPalewGyyUR5w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZKP9zGSLZ8JBcg/WuEVcxr+qT417wR2Zl+YC2t7Vi53Jhw0J+qF4GY2Vq2MW?=
 =?us-ascii?Q?4maoD8s8Sh7nrWbwUijIQ32zmkh0Ei4Z2TDAvDC1xHbRMgLVG3yhIWUG77CI?=
 =?us-ascii?Q?0Iym7OaVDj1Vt3g9CC7aNS5RpFgrQbgYKb0n6MtJW5RjnFOEIV2l+CcYzZLB?=
 =?us-ascii?Q?WBnly0kJH01eVuSsmDZfeR1Jd0OSUKSO0UGROnAF82U3sUUYKC5oT8Or0iy1?=
 =?us-ascii?Q?5BSK1NZkZ7Mh1OufEfuhYfOohiVIjfffMLWCvhKCMTsbsFryi1Bv+q1bRMrD?=
 =?us-ascii?Q?uhXNRHMSbKmbLsOaSaTzalPXR3nbaD/6bx4wBiYRkA9gjbFIFRogZUrloAzp?=
 =?us-ascii?Q?0qXQh2oMIkb9ChtvbRj5MEfGZfutRUi/261bj9N3mv6yPrPpof1845bbJQj8?=
 =?us-ascii?Q?0SQpZmEr/4tTRAfgfCYgHbHH+8NSgqoN8LPYgyM0Ig/KpZOLSZWmnRcg1R3n?=
 =?us-ascii?Q?ufgeO/Vn+rrBQEJcHvLAwaHQv+N4aFfgfAYbv9VNmDJB9DN8xw8WnRCAIGpp?=
 =?us-ascii?Q?Z+l4vwgMnwehBRqSNCCWsi6XTJ/ZDzhaCwg8yUUAxPMCXJP+VQD4wCbOAk3M?=
 =?us-ascii?Q?0XLBieJ6D6HzUaFV6QwYjRT22+oqGv/FpDI7icb0QP8Ui+YnuvSr0v5Ea9E2?=
 =?us-ascii?Q?VFRX8nDR5vy5qqVGLk9YUSLL41cQ9B1H+SgCqyv50L1oiDgvUqIU80kZs+dM?=
 =?us-ascii?Q?UIBvtTU2VSLmj/qN7pD8jRFEUyk4qV/xmRDx/bAXiazX4tuqN20FJLquh6YW?=
 =?us-ascii?Q?cnOKFyc3wMlhJRobHbyW041+6bGDH1XJkosqx2D6s57k71H/DvSFzES1kkgV?=
 =?us-ascii?Q?tVXzALe+yOJKAAJz95GlKuOeDLmcNOlCV8C//eUhjY7MGJGydy+Hkf96y1Bc?=
 =?us-ascii?Q?PTYIdsGvRsie6XxW7n4TgOX5KeaCsIfNy/ASQdc6mwoPUQDbnqE+8WR77O7u?=
 =?us-ascii?Q?W7HUwtbKmDAcng9UKSIq+GUy9AH9+cFaCSDuSvFC14mFNCDlvu4IbJB/ueyE?=
 =?us-ascii?Q?iC+kjK4ypohZ3CctE7oohdO+5EsTBY8ErkpgB4Cm621LPMPJAdZ3QXlE/TzD?=
 =?us-ascii?Q?SleEI8llyx6TydGgiDZexgkX+1cj7QJgU4LJu05Wtnj+xmi+hUS0ZOAQwy7T?=
 =?us-ascii?Q?e1E/jPRM1Nty4N1Fxe12gD9xJr/m0/zPK5isWjOuDvfa6RWTBV1pmqP0vMvK?=
 =?us-ascii?Q?JvlZ/zYHexDPXjgIhlJD6S2mjAHZKdCuGdWddn8xxDZ7+grY4WAZNf8PECHd?=
 =?us-ascii?Q?wi+kjXYinRzbKqa4iWPnLkFXZOMs06dymMgA304VF4kM9VeOKuFF7vVj09qU?=
 =?us-ascii?Q?epwdrCHr8fIqq8KLINlz8/H5qdnJCcgF3c46jGjr+vhZK2Mngs9qz4chAjHF?=
 =?us-ascii?Q?Cl/OzBg9Ai2Hqn6pJyTpeQ1odut4Y2lH9lX5YdfYymhlO848AYVkjFVm9+GG?=
 =?us-ascii?Q?3O38rsky7V2gMzpM9cGSbXuiO4cfPelMng1Do3s8FPiN+iPjdBCoNK3O/Pv7?=
 =?us-ascii?Q?iXEGNMuyYN27+8Iv8SdV374lFoOQYsgmQh6o1P4ofX8m5C0IgsjmJWq/DbIJ?=
 =?us-ascii?Q?c1uHP8NQCgoEDKsPsDPEkX6R/pnKylW4NA0poPdB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14302300-9cb8-4e57-cd16-08dc64d42f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 03:02:46.6330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGjrxbonf/AIODwW4k3FO8D5T+xQYtU5a179s2pv002kUrmo291ftn2toLe5R7ejEW4dgmX6jv9rvjiudk3l2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
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

I might lose some context here. Can you please elaborate why we don't lever=
age the existing umc_v12_0_convert_error_address implementation?

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, April 18, 2024 10:58
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 06/15] drm/amdgpu: umc v12_0 converts error address

Umc v12_0 converts error address.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 94 +++++++++++++++++++++++++-  dr=
ivers/gpu/drm/amd/amdgpu/umc_v12_0.h | 12 ++++
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 81435533c4a7..085dcfe16b5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -222,6 +222,66 @@ static void umc_v12_0_convert_error_address(struct amd=
gpu_device *adev,
        }
 }

+static int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
+                               struct ta_ras_query_address_input *addr_in,
+                               uint64_t *pfns, int len)
+{
+       uint32_t col, row, row_xor, bank, channel_index;
+       uint64_t soc_pa, retired_page, column, err_addr;
+       struct ta_ras_query_address_output addr_out;
+       uint32_t pos =3D 0;
+
+       err_addr =3D addr_in->ma.err_addr;
+       addr_in->addr_type =3D TA_RAS_MCA_TO_PA;
+       if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
+               dev_warn(adev->dev, "Failed to query RAS physical address f=
or 0x%llx",
+                       err_addr);
+               return 0;
+       }
+
+       soc_pa =3D addr_out.pa.pa;
+       bank =3D addr_out.pa.bank;
+       channel_index =3D addr_out.pa.channel_idx;
+
+       col =3D (err_addr >> 1) & 0x1fULL;
+       row =3D (err_addr >> 10) & 0x3fffULL;
+       row_xor =3D row ^ (0x1ULL << 13);
+       /* clear [C3 C2] in soc physical address */
+       soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
+       /* clear [C4] in soc physical address */
+       soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+
+       /* loop for all possibilities of [C4 C3 C2] */
+       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+               retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
+               retired_page |=3D (((column & 0x4) >> 2) << UMC_V12_0_PA_C4=
_BIT);
+
+               if (pos >=3D len)
+                       return 0;
+               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+
+               /* include column bit 0 and 1 */
+               col &=3D 0x3;
+               col |=3D (column << 2);
+               dev_info(adev->dev,
+                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
+                       retired_page, row, col, bank, channel_index);
+
+               /* shift R13 bit */
+               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
+
+               if (pos >=3D len)
+                       return 0;
+               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+
+               dev_info(adev->dev,
+                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
+                       retired_page, row_xor, col, bank, channel_index);
+       }
+
+       return pos;
+}
+
 static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
                                        uint32_t node_inst, uint32_t umc_in=
st,
                                        uint32_t ch_inst, void *data)
@@ -482,8 +542,12 @@ static int umc_v12_0_ras_late_init(struct amdgpu_devic=
e *adev, struct ras_common  static int umc_v12_0_update_ecc_status(struct a=
mdgpu_device *adev,
                        uint64_t status, uint64_t ipid, uint64_t addr)  {
-       uint16_t hwid, mcatype;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       uint16_t hwid, mcatype;
+       struct ta_ras_query_address_input addr_in;
+       uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
+       uint64_t err_addr;
+       int count;

        hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
        mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType); @@ -497,6 +=
561,34 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev=
,
        if (!umc_v12_0_is_deferred_error(adev, status))
                return 0;

+       err_addr =3D REG_GET_FIELD(addr,
+                               MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+
+       dev_info(adev->dev,
+               "UMC:IPID:0x%llx, socket:%llu, aid:%llu, inst:%llu, ch:%llu=
, err_addr:0x%llx\n",
+               ipid,
+               MCA_IPID_2_SOCKET_ID(ipid),
+               MCA_IPID_2_DIE_ID(ipid),
+               MCA_IPID_2_UMC_INST(ipid),
+               MCA_IPID_2_UMC_CH(ipid),
+               err_addr);
+
+       memset(page_pfn, 0, sizeof(page_pfn));
+
+       memset(&addr_in, 0, sizeof(addr_in));
+       addr_in.ma.err_addr =3D err_addr;
+       addr_in.ma.ch_inst =3D MCA_IPID_2_UMC_CH(ipid);
+       addr_in.ma.umc_inst =3D MCA_IPID_2_UMC_INST(ipid);
+       addr_in.ma.node_inst =3D MCA_IPID_2_DIE_ID(ipid);
+       addr_in.ma.socket_id =3D MCA_IPID_2_SOCKET_ID(ipid);
+
+       count =3D umc_v12_0_convert_err_addr(adev,
+                               &addr_in, page_pfn, ARRAY_SIZE(page_pfn));
+       if (count <=3D 0) {
+               dev_warn(adev->dev, "Fail to convert error address! count:%=
d\n", count);
+               return 0;
+       }
+
        con->umc_ecc_log.de_updated =3D true;

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.h
index 5c2d7e127608..b4974793850b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -69,6 +69,18 @@
                        (((_ipid_lo) >> 12) & 0xF))
 #define MCA_IPID_LO_2_UMC_INST(_ipid_lo) (((_ipid_lo) >> 21) & 0x7)

+#define MCA_IPID_2_DIE_ID(ipid)  ((REG_GET_FIELD(ipid, MCMP1_IPIDT0,
+InstanceIdHi) >> 2) & 0x03)
+
+#define MCA_IPID_2_UMC_CH(ipid) \
+       (MCA_IPID_LO_2_UMC_CH(REG_GET_FIELD(ipid, MCMP1_IPIDT0,
+InstanceIdLo)))
+
+#define MCA_IPID_2_UMC_INST(ipid) \
+       (MCA_IPID_LO_2_UMC_INST(REG_GET_FIELD(ipid, MCMP1_IPIDT0,
+InstanceIdLo)))
+
+#define MCA_IPID_2_SOCKET_ID(ipid) \
+       (((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) | \
+        (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
+
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_u=
mc_status);  bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *ad=
ev, uint64_t mc_umc_status);  bool umc_v12_0_is_correctable_error(struct am=
dgpu_device *adev, uint64_t mc_umc_status);
--
2.34.1

