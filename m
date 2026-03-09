Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267D7F41818
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 17:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B727410E570;
	Mon,  9 Mar 2026 17:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zc55OLiA";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1416310E570
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 17:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSmrHdUa94Hp+0uKEC34Y6S/M2RlYFS8lf9+ay92lhqrYnPCPPyt9JwkBAyDtIFHm6O6NHMCeLuDzy5dy9kQFVdJSxTrxHJ+99EsUKPXJzeUDW42GqHnHpke3eVLb/3vIsNyo1+qFyHtnM/5az39+2EOgumqVMmeTXSLEZqblp/wvl5j3ZBcS5v5KoCogTA4D2JUjsFpZ8g9KMs7rr5z4rmobDL6z0opIgQwsmqPrZbmKGs9+j/G6vC0vFHsfCWKuW5BBhNVdIWLPSn89udqkGfoXzcyr5ZwK2bpc6TAoxmNCfVIrB7BnAjpCGnZa7vOZtBAAEB+DGnrXeJExv+liQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3xvPqUjeY06mD53RQl1wB1GaUrBRBT0iDe8rjFzmQE=;
 b=GYVOn0cUFo92CneCP4vAiPh3O6CTh6RzBFAu+j1RsFKS3PVXbTKmXKZIS9fPrIrMK8HqpQMsd48rDXRssy1FogK5YbOOzTMXxaoXkKUhRiJy2xyrRPQbRkBC+/JTFUm++aQi6wIL7d6vg10aN0bZqHuuwyPhqYhUOAs+XeW0px+UZNKyLElMxucfFsxZ5UBcS3CGFLrvKr9QdiV/myYJZMnx+dfrNzOr1lEk0+0xitasoT2H6hXW97jnhHBU4sa4K0oTXOAgl+LZSQklEPrRkISQbMRZxqh6NHAbYnuT2V3C5aKM8RXVFiXjoiiz1vlSKIkyqoL3jM86iUlUbTTh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3xvPqUjeY06mD53RQl1wB1GaUrBRBT0iDe8rjFzmQE=;
 b=zc55OLiAc5xArnAghwdxps0kzBG4XpavD29lWXg0f179Cxx+pnxZ1I8puUTjCgypyeZetAgThXGdL4O5icQh/UYXHbn9Le87QzpGHHJqcHlkZGb26hxgjGge2Uh55eUm1b1AFQqQYe1+LhgeHyRHdFjXyQ2C1bSf/68hnKRjswE=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Mon, 9 Mar 2026 17:04:29 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f14:4646:fb11:829%3]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 17:04:28 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix xgmi max speed reporting
Thread-Topic: [PATCH] drm/amd/pm: Fix xgmi max speed reporting
Thread-Index: AQHcr6oPccupw+NuAEaAbI1xkvJYG7Wmbjmw
Date: Mon, 9 Mar 2026 17:04:28 +0000
Message-ID: <DS7PR12MB607129CF04AF86F6F7A516B78E79A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20260309094922.3486621-1-lijo.lazar@amd.com>
In-Reply-To: <20260309094922.3486621-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-09T17:04:22.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DM4PR12MB6398:EE_
x-ms-office365-filtering-correlation-id: cece1e2f-945a-44d7-c6ba-08de7dfdeccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: Q1U7EnN9p+WCvyhtq8M8BbndEpsttVutJGhQ5oQls6Rb2eQsNjeLDulVppj/xaIsRIptCT5oDpvU+RThE6ZfL2dcRRjo/zpGaw8GDrIAVq5hcQjHDNjwXhyZZ+n/3e2HhCEq9QZmk3P3gYvRPXezzE7rlNFMi0RwbKPsizy2PFZQy3M8ojvR9IwTyU7U0NpqQXex17zXrpPs/NbNbNIDMHYgCWBz4Y6HQGj/GKvGZ5rftuSvFU9vqFXCRywoiDy5U5bgfeEeBnpMDfSlIhfR7acOtTeYWkQ4np6XaSo51r3a+reop0t5vxKhFQVY8E9H477IHnaublAoRKTCqVJ40/3zPy36sJXgWqL75b39KLdF3GchilEwekdKN/VpSI0fFkRElRkp1a7yf6A671Zf5QHF9g2thXAY6LE4AKqRTpFmw2ARaztDz/u+1zv1mdTUl24/tvCNrtHyubeTEswDrXR6xzneuK9wVF0Y91zeKfM3vZ5WtEcxJcQ5QK8SqI47nKEHRiwJkG1xpIe2y6g3C0BPFOGvMaamFNG2blTz+ejQ/QDLxx4JSwWnXApD16fq9kuMPq5kOfCtKycXijFxdTcj7tUJfh0uYcGQaIkpyyDRZqlTvHe/BQ9MROeIO5zgyMOmd3VSdP3mvWjogIgXQfkdGbkE8cCyejHrfEoxvfj7Wu1u8/+/asqBO2WcVVa5K9OBO/qtdGXXZFZLN6O20E5RHdXALFgh74n5YLE/Z4m4Xf86/lnsuDT4UP7cUeilVKQ4C8djzHhFBSjX1u2YbkrGTEoFfQsyFSzVJyoE/ag=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1vX4Ht5mv4ze2g3+ySUECO4rRc5IiXi+txU8tx3N0+lC/qdwMlVfiQywKKtm?=
 =?us-ascii?Q?+Jhz1qLtZfz2kgh9LI14aXoxDR4i8vRx9z0i5WXmBwc52YShypfpI6EWV/bR?=
 =?us-ascii?Q?h6aj8N9QeGT37UHGO9YdYjMYKw/F+JccPhdoCzd7M+tfpgwBdKA+uxEwnHQ2?=
 =?us-ascii?Q?9+Kua8x3KJNK6iSyKHJnFTohzY0gfuhnGfRymQG5sdpo25OVxl+jIUHMMhH9?=
 =?us-ascii?Q?SGLs1xCzbTeEc0f5FAr5Rdr/tS8q43doSwW+7aMnbU02Ok4wk5CdiBiw8GIf?=
 =?us-ascii?Q?wux6qQSCxE8vzEgWPw/ygNZfubdZLdsHAwz0Ck/GlL4w6GR0w0c1DeG7HhwS?=
 =?us-ascii?Q?QCQhYbPSWJjEq0/mnnBkzYxkcMuSWbIcjoxsbI8xFZqgEtXN432YRdE0hZj4?=
 =?us-ascii?Q?0fr8TyilPvwiMQBCiL+d6yuI9V+wgyx3YlfS80UmFDeFRupYOZDcLG3XzZoh?=
 =?us-ascii?Q?LYqaOkUn1XNn30NEOqGwh3jjjqUxLvAStIUqOq6Ai8UCrDtPBU2icknoP1Hk?=
 =?us-ascii?Q?XsRmyAyPT2N2AffjG5nPLWNyT1J0662ZoxKh4Car7bZADa/acVO7m1JqQwRc?=
 =?us-ascii?Q?gSb743wIP+tjhhPJRE1dPe5JGfHaMcQJdOaqRu7aBKxzlhSd2SjAyfu5iu0y?=
 =?us-ascii?Q?/VoPgHPM8Io8CXpfK3ZlL2VhJdBMMAMzYGSnxp641l8NEHSSOKyKcIwh81tW?=
 =?us-ascii?Q?ccnl4dTjc8R6YKic0Hhcy7Ttc0u25R7AfQuzLARvXj9qHahN9T6cJCMs6EgU?=
 =?us-ascii?Q?EPLzYVkMVO2PtOAfAQRnAPofDcUXGjvMzFSkxNlugBZ/EAV9aAm7YfERTKpc?=
 =?us-ascii?Q?z+q7+qUIle7MnP5EXfqvOZIAR0iMHn7Xa21YffDp8IWZeG+QiYk3RWwCt5Lp?=
 =?us-ascii?Q?/WpxNDMBf72Q/gYxp7vXdjshdzJsBJmzbBwN03aVh3oBbnKcH2qfGASdxaCi?=
 =?us-ascii?Q?LxCfhavgDhEBfASHWShHTx3YeKEsCWRORst6vKTOCvyjdtnuj8eHqGl8F47M?=
 =?us-ascii?Q?NonE99BU7cJRKyKtq3I4vRFyGbVtPwrSBrPH+9PgoxwEUj5DgsQeZw+LUc1h?=
 =?us-ascii?Q?sGleTudS0P5lbqlXoBSrXDLL7zAmEOfqYNQaIPLmlcWsoa7y+bVUaoWM5wjM?=
 =?us-ascii?Q?QERSZwyCcy3hR9Zbrm4Ldpavl7/E1yxxqi+GXst73Pqj7wTzAv/+TL6XOXBD?=
 =?us-ascii?Q?luy4SnxgpDm/18yGSMkA19AUObbvhYViX6r4ZjQeWqDngTeEkaVKeKzBDURO?=
 =?us-ascii?Q?sSQZJccQjuxf0BY4nGRSyn6zWPpPuhOLfFI51VQ7aky4h/KULIF/Xvw+tZqy?=
 =?us-ascii?Q?TgKX3uUbhKZ3mOXvwucmwj+NrOL5njgmWX3BTYpRfTMq3FbJq6BgDE0/f9fb?=
 =?us-ascii?Q?JpNqM1QQ0K6EgLGazNKssBAUOK5zrVK9MrhGCBzaP/AsGueW/HOhUZk03gYS?=
 =?us-ascii?Q?jDAwn86gTXmSIM+UzOlZzXKMnA03zQzvbD7SvvGHauTMXo55rom5KmG1840/?=
 =?us-ascii?Q?UrhFtx3IbEeFhy2AFjhdOP1PoBwPMes2wNzrsCOJOG+dAWpAmJiGYLqAXLPc?=
 =?us-ascii?Q?bogkmxwdaOykiJ6mBvJTp5HAuugoS0Ej9/30rAV+vAzvK7itSdu2gUY+LJLR?=
 =?us-ascii?Q?opDB1ytOFdHgiDP7Bx3nSb2P1+DSforHRpHYtD/Ta1koJTuhQOpA46J8/2Cu?=
 =?us-ascii?Q?NrvA8jVAb62+5AUj/1yXeeqNUEkEYNdRtC8reJpDKyifXUOc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cece1e2f-945a-44d7-c6ba-08de7dfdeccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 17:04:28.5641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0u3b/OBizLpBPPXjI3dssYicTyBCexdMrF8syAGqhbDjVey34w9YsCeRlZmRwVTXplPHR+3iupjjQXBy7hbRlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, March 9, 2026 3:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Fix xgmi max speed reporting

Fix XGMI max bitrate/width reporting on SMUv13.0.12 SOCs. The data format g=
ot changed when moved to static table from dynamic metrics table.

Fixes: 1bec2f270766 ("drm/amd/pm: Fetch SMUv13.0.12 xgmi max speed/width")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driver=
s/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index f2a6ecb64c03..29cdb479770a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -262,8 +262,9 @@ static void smu_v13_0_12_init_xgmi_data(struct smu_cont=
ext *smu,
        int ret;

        if (smu_table->tables[SMU_TABLE_SMU_METRICS].version >=3D 0x13) {
-               max_width =3D (uint8_t)static_metrics->MaxXgmiWidth;
-               max_speed =3D (uint16_t)static_metrics->MaxXgmiBitrate;
+               max_width =3D (uint8_t)SMUQ10_ROUND(static_metrics->MaxXgmi=
Width);
+               max_speed =3D
+                       (uint16_t)SMUQ10_ROUND(static_metrics->MaxXgmiBitra=
te);
                ret =3D 0;
        } else {
                MetricsTable_t *metrics =3D (MetricsTable_t *)smu_table->me=
trics_table;
--
2.49.0

