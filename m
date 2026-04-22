Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328AFF9EDC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 12:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74BB10E29C;
	Wed, 22 Apr 2026 12:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tUxhYpd9";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1163510E29C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 12:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHObxVQsqeaNa9kWssgl/TevWBqgqS8zIZRxuve1cm2UC6L2lpqVNYrKYo4ZBMQbgt1vQZcnXJWIyCy4tRvGyzDhLDEDkkn5vWpVcTxbjvCgmJij4ipBULvw6gc5Rwi1YTsuLv5o7g7yCdtBKg9DAYkWfypekHNgNxtRkNIRm1Lzo1x/arvp8yrHv4OLhfBUfYGDOeG9mLWizrMUpAAZCzWc6d0a30B5jfb1ttCGHiQYP5sbomuyjU1aqrXuqTi39l6EfoauGaVNN6zfr0xmHsZLtYMlQaZ5yN3PmB+SBBN+b31gAdR/pC0xsApr74muwLHEpFEiKtJJ8skQDMuYPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WXz6SkCc5VJD/MDaHILwyjed0pnvmJrxPrNJtPxrxE=;
 b=FlXwKY/GScasi+wvAHkrCtiz7x7HTW68w8ulxQjD4bjk9k1o+UEWLFuNpvFpo4hmc5aWJC6CRfln0Ncw7FVGJYRXmFYm5TPlBt7tZZVlmv+9JRdu1VcsAB5b9uljuGCeH/f8k4wRdGLpxLWqYg23wlhxxvC0pRmuJdOktGSkGpp37m0KOU58aRRbv69X612lKN6k2Gy0mv3ZXaTMHyGPQWbzHVNwh1Mc6ImIWLiz+9GY67erdXLw2ZsWLdol0mqZ2KUkPJPLkfxubDTXVfg/Tma1kWCiC2+20tSymMbLIuH9Sv0BZd4SemabJU80+pOx9VwLw9nb5CEBHdIzQzD4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WXz6SkCc5VJD/MDaHILwyjed0pnvmJrxPrNJtPxrxE=;
 b=tUxhYpd9fB/4AabZrIxPBMTEBI8SHnuSlbkH972mZJP1vv4Vf1pn31bSM4gNUi4GM9eDOvf8QbNUdyAW+kshSFZHKWXrM15eY7EUzPLeFl/96pdNt3mONeqCBm/s3MpkOJClBrq25PSrrPtHup3n7/+IMyRK8SrTCHtHtdWqehs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.37; Wed, 22 Apr
 2026 12:13:31 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9846.011; Wed, 22 Apr 2026
 12:13:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix missing fine-grained dpm table flag on
 aldebaran
Thread-Topic: [PATCH] drm/amd/pm: fix missing fine-grained dpm table flag on
 aldebaran
Thread-Index: AQHc0kWP2I7prNS3NUGOUvVKBz88gbXq/jug
Date: Wed, 22 Apr 2026 12:13:31 +0000
Message-ID: <BN9PR12MB525711C79704F256C6407561FC2D2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260422104809.1163843-1-kevinyang.wang@amd.com>
In-Reply-To: <20260422104809.1163843-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-22T12:13:11.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB6090:EE_
x-ms-office365-filtering-correlation-id: d1a9aa03-b23b-407a-e336-08dea06891e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: VtsrJySoahz2LwYVIbhUmtobxXnG+/07AGGXW7o0LQ33Plqf4VDSBPwd79Ze0ee2rydReApfSA0pwWgnYndH1H4qQWyIKpLPwLhOh/0g+YUpARd9qnpuJHvxv5je1MnZ5dgz7UaTok0+p7EEnYkemXI10kOippDh62Rrl1Q1Pi4LkXSgLlymKGV3k2x8IsCgCiQtcKwH4XhPBPvttH/qDJDOdv+tn3s/hfJcjTLKrE1n99/qS3pXsytyNAyozTKKwb3qzDn9iYcuyl9ECY5QK3Z+2+9MK586gRdPvrBc6wCOKLPZd2W41Bp03BucKmfnJZ4K2RMqCLNYa93faAeLbnBZP1277hmfm1Rv0pQAYiNy6S8AEyYpImzSXyAcc5NH0+drdwO6Td/IZ6Y7bbqFBKSg8s3aqWzpGupWGgEB9A2L10MTgdj4hvogMRp0Vj8k1MCH1209KfxpccK2GMTMvQ9cZaxpkR3rJQzjXFhI3SgmB0t8Q9eZl73AjM5D1dSeD8EQ54tXNXpgsTkk367L4PDQEyPv9NBvBdSzqAHVOVRf/ZBjvCSnm52PmYV+RYC0VZhsQF64Z2N1moU1KlAIjX71kMP9EpmoTBFu11hEx5x8XobeYKINHnMQEQRrvQo4CXo2R2oKzpUbebT7kp2sYHhuww7NdXGf904HrlkKE4hgY7ZyCqrIRfLYtukEFsC7XtswI9YTonwzytMlC0JRyWdo1Hf+WEOGb48ZsG314oWuy2hMguEgBOWqX4oV9y0Mfq7Mv5We7foL6oPL3vQZvvuFiqjacsgyUs5xjVwLqvE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BYhYAHHrhODAX5e62DmOKsrxjDWWD+VwjZ+yaI1pm+AdjZYKQYEtt6qGsmDC?=
 =?us-ascii?Q?/K2L4UcbRvshqoEl8WLVE2xpe6OgQsRXf7eM13V27L2LDqVKKXXJwN/bzXec?=
 =?us-ascii?Q?f2+vFxjig14yR3NMCfCgFBwDeGCmZPonRFq3PxAmI/2/SlfFiOXyBPTYc97E?=
 =?us-ascii?Q?mrwuEe33Lt7XEYYqB1SSOfGfxZOiVN05L9P6FP+3Xp8/yqiT8ELhcJI2Vgiq?=
 =?us-ascii?Q?5c03yZ5iGe14nEL8bCP+aJOHBbZXKAQEMMWlqosqodE0jyMMnAACwCpf5ZA4?=
 =?us-ascii?Q?OGr6eIjtN4nkA3SV8AFSoHG8BFlLDnA4IKpDFyf0L27Zv4CceMG1MRcWpAaz?=
 =?us-ascii?Q?8bk/3g74Q74Vc0mzmToS56o9RqZXxHDmTpxF1NNfTIu7XZZakvl3BEKGmfRY?=
 =?us-ascii?Q?edKc+fwv20mgufaI8bydywVhjhcRiA8XbrBYgycwlRUWQKir1I1SnrRu2D6n?=
 =?us-ascii?Q?0ySdwEoPihe2pqfh96aJ6Op6NESrbxqtnF8qXic1LQE3aDotny9DgQdEy6AT?=
 =?us-ascii?Q?Gt5aH5GoiS0yInQzYI6MFsVGBgHTqA8sr7aHyldY70QkRR5iQbIGdSOM8Mb5?=
 =?us-ascii?Q?9//ZG/dVGRF66u5HGjs+3CXl2bF/iG1LnKrFggYAuI+hi1Cidfveb8ztRC5M?=
 =?us-ascii?Q?msbfwIFpgsu+9uZAb+EJHpjv7Oxtw1Ep1Ad06Y/CgPhK4ibmQ1Wy0aFpfdT2?=
 =?us-ascii?Q?Y6C6LdLAUz90l1icXUiQAk9oSWqN7zEWHuZrEJEtUTApcevTR11MNSFKOcQp?=
 =?us-ascii?Q?PJFlvtqFDBvwFa8vfkWHdreeVa1VZeeGCCCGQHN/YtUIr0vnKqGY0yD9I2NA?=
 =?us-ascii?Q?NOfOMYyzsRGRdXtSa3F6j+biyAyBvcNLGarHTxU9JDwiX3GWMdBHFsBrVu8h?=
 =?us-ascii?Q?UCry//HmjpYfROm6f+qobKB/b8cCqeL1f378DGEkbqUW8wBN66bcqdWIXUsq?=
 =?us-ascii?Q?COdZ7Ec7YvkCwBN2/qjy2GP2DJaanvHWW4hzAje3Zup/sQrFFHH43V0SPrBZ?=
 =?us-ascii?Q?4VKmx6If/FLkdTBC1JhVJkCQU3+2ELx4C6eG/YxBkCEDKel4CXZahPSoGUr+?=
 =?us-ascii?Q?xMVOlQy7oEeTyAurOvSGMZOsztDmZ4+g7YR7rcR2cdAO951QbDqOyv2GWGhO?=
 =?us-ascii?Q?1MQSqmaWOh3b6Ec9XQYK37aocGNbrQNWVdT5iYilPPZjdV3iWPU9eeFRboAT?=
 =?us-ascii?Q?cmyHbKNYOliTQFKP5+0RPWP0vPECBIEzQF0KintXMobo7fqK3Z0fY3tUkkri?=
 =?us-ascii?Q?Ni7O91QFp2f6VpFJcaG0iCCLCqSR6YBx4sOmwtmiW227N5+HAoEpCldtuGwJ?=
 =?us-ascii?Q?T1SyoDQc6/tCRMk3QbTnksP0bT+TYNkYXyPZy05dbtr3zaFE8I0mdb0S9070?=
 =?us-ascii?Q?r5hQVL1bEOfrCz2itBlwTE0DRRyErIcUBaLfLlK07L0uInHSslvOZQjNzGO+?=
 =?us-ascii?Q?fe1nVvNXxXNIqdhgcPk3FNYhoFa0bphNlypoPzbvvtxWNWDupOsjKZ3ZZMds?=
 =?us-ascii?Q?Lk/QRuWof6f0qB+I+RGjWhbJqjAx0iY5759/yiO4o/wkZfC2ztEmEn1lv5He?=
 =?us-ascii?Q?jRouLGFuC1AJODBblrdaclZptcq9JoyqvjO68DC8CdAKbBetWJVozuX9iHLb?=
 =?us-ascii?Q?vuqWcJRxf9GKAyuleuMNzpqdmBXQrrYfhO870SRArrs15eb652zQSexo6u/1?=
 =?us-ascii?Q?a9bO76x+FrZIaPE5D8qphVPBejJVXmi/8vwZVUfdW4443CoF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a9aa03-b23b-407a-e336-08dea06891e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 12:13:31.7913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SqMhbYnDTof4AzPajqj1i+eoUvE2z3W/dA9v6fJ903r/WXwXA7YUuQyZ+cT8VUhtH4tex/zflhADN5sfuPzjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, April 22, 2026 6:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix missing fine-grained dpm table flag on ald=
ebaran

Add the missing SMU_DPM_TABLE_FINE_GRAINED flag to aldebaran DPM table.
This fixes the pp_dpm_sclk node issue caused by missing flag configuration.

Fixes: 7ea1c722fe1d ("drm/amd/pm: Use common helper for aldebaran dpm table=
")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index c340f19f7de6..754cad44269b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -426,6 +426,7 @@ static int aldebaran_set_default_dpm_table(struct smu_c=
ontext *smu)
                dpm_table->dpm_levels[0].enabled =3D true;
                dpm_table->dpm_levels[1].value =3D pptable->GfxclkFmax;
                dpm_table->dpm_levels[1].enabled =3D true;
+               dpm_table->flags |=3D SMU_DPM_TABLE_FINE_GRAINED;
        } else {
                dpm_table->count =3D 1;
                dpm_table->dpm_levels[0].value =3D smu->smu_table.boot_valu=
es.gfxclk / 100;
--
2.47.3

