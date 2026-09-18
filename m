Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73232C88E75
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 03:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 032D710F165;
	Fri, 18 Sep 2026 03:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AnrXJFxa";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013034.outbound.protection.outlook.com
 [40.107.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C832C10F165
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 03:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3cqoCT8kLSm2aVMOyu4w3LJsuYuUb7eZ7pvzKf5TqFMPx6oJQqF4nh8u05jNP2rWNBM/SNIIlet2K7vlgw7g753aEILLe3VGzARSrOJx7nAgi+ZGBa70WVu1YSeab2GzdPs6YiI0oKsrxzcnyt08Sk8v9FvzTMmj8PIAfUuSRDems3oOuedM3BZ5Vh50dbdveqPJOORFHU+rzww+8wS5nPRLO3YDiodI4ES1zaR8VKef0ZXKEM2XjFT0Zy9HpBrEQ1sBS6zAgEvPhvjHaCZ9T3pFeKIQhy6mav8UFu91j4U0Cbhr0uk7FvigeOIhL5qEP/eGlmzZvcfAH5fsPScXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eBJLeO2AeaBFWYoqjiC3FXLK8IT9umsNsR3ovxNj/E=;
 b=ljdkmM/SXGiNBDeXLo4IMKy4VYvtC9z6xs1wY9xlJcfUI7sAkDckVGBf1tnpTPnMafgfMl1i5w+EGQOBMMJRenHz+ji4+0RiFJxP774GLlJ1JmigkgzNpgbSbaK7wsP/pcl8jS/NdzDhBMl1zHiRnD1uW1adeMV1cHQGyOGT9SCODPcwkO1urlA/Zdzt7wnHGLty/i/24zbiXtcrlp1oH7ayHTW+SgzQcv3p45Tfptm3N9GuHLWZsRwv+9FIxMdah3Eg8esepoqWWPPFygr/5c7MKjRtu8bn+Tq6nGOWlETHV/3X+zTrUHa06hBkIbVLXjW2EnpnY9Ub/jmmyrbayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eBJLeO2AeaBFWYoqjiC3FXLK8IT9umsNsR3ovxNj/E=;
 b=AnrXJFxaRtBnAdJpfk/+/4ZH4SmNP9wgza4cLEA5yfwRDmx8cG+cp1KA0JXK9zgnrLG0WP2xJQOKrrkE7Se6EgbvJ9wJakjRtCC9kw+T3tdgtMPP17q1SDfBihgtW7FIq7dMGwxo2ceUCsViLKi2kwPyv2hDzFEC+EA6vrDdZmg=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 03:46:16 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 03:46:16 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: report smu energy accumulator updates
Thread-Topic: [PATCH] drm/amd/pm: report smu energy accumulator updates
Thread-Index: AQHdRx6R4dfLLb1f0kmHAkNm/2eaYLbTshcA
Date: Fri, 18 Sep 2026 03:46:16 +0000
Message-ID: <MW4PR12MB68039FFCACE0D352A85522768E872@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260918033345.419596-1-kevin.wang@amd.com>
In-Reply-To: <20260918033345.419596-1-kevin.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-18T03:45:36.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|SN7PR12MB7977:EE_
x-ms-office365-filtering-correlation-id: 86dee523-7693-42a8-0557-08df15376491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: xRLlQZA4Hkj+MqX21aRW5ytoYnD/xxUPqLs2IVRsNYYPbfpxizKdSupc9Xr8ucT/Z+xU4RKG6NnDs3S1XFdc9Q5RtoYqG6UhIgZ67yzxQVOsWdBds37OfYFq3TYv8IyEBPergwqx5ApgQUogy9Nzz/6HbQjubPDIma3EJZpl0ga2VK5/ql7osAqJErQKYQJ8jOTA2SMhaASGLyr1En4qT7Do8crwzyd+Yyzg+7cn5EItIkLvJuL2MWi9nxwHBcns6joIy6RWTHn7hvGnrhz8S3JzL069py0DqFnKwyyAWmAzsHkdlkLodl5Qj7mAUm1cdXKJJlO+HPjARP1m96CJhYD+Hxqi49u/ybNfr8FXX+B1H0+WyJi7DcLiYkv40hdoAb80KSkfhn8OgdWWlN5wxq8EHI2dqhnYNGMwSvC81vg69LL4HX46dKzvI1TQlh4+3kBPT/2lNJUcgH6k+fRG/QMsBevp5CS5jsJi4nhTpDXyy9ZdWSJ2WQThrijt8lirQnkQrh6NGcCMNYRWmvxvDussNn9rerYVwZS7cwY6b9FcS9pXzMwqIZld8sQNWS98pklM3Srs6ZLGLBMQQY4+4ccX9z0YiZhGTDSPP4ExvRQIVDltDdwY7fj/V3HsoT6SHFPPHlL3wWxUnSSAouAdmZKNyaxXPjUFEH6ADjizjnVLJPU8WqKtLnPt7UO4DkOozZxsGyc5Km0vYCfcXWnTfy4m+L7zCYeW63x4IOLFc2M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?71OcVUyuHYZ/JMZSY3I6MRBqWJMF/EhuAJx0wK85tky2PAt3Cj3FLLbeoE9V?=
 =?us-ascii?Q?fnMQyQhBJMS0pko+oRjG271NyPOGMnz3QFqQs33V/7TBRc8F9SUosC818KYH?=
 =?us-ascii?Q?ILti5s0M4MGa3jCLyF9nKA7iXj4cXUrKfuuVVLQeCoUdrceX5gDniAaiz8wP?=
 =?us-ascii?Q?roDikly+PFIfhyObVAVg04PY/AN6DOaYKSIOt9HoWyIw8AuFw+Mc7qecVynV?=
 =?us-ascii?Q?siDbp9IegpSvLxK15DlgF5TsMs9DUS6GbhR4OJIMHfZKvJCx1vfihXO/4PSq?=
 =?us-ascii?Q?vDJibXl4hZLYMurrq6us9LtSYoekWfxVfdeOe3zxr7xTQu77M47daEnSXXk0?=
 =?us-ascii?Q?Eve4ZswX2H+33g9UqrubaAS5igBTbi7oYrCnXZO8JhXYgUkajqhvWYLIOCLI?=
 =?us-ascii?Q?yUu1VsJiWAHBi1FSfKeShSe50mg1EjdiSnx3icZZ3IZxocG2Vex4Gf55ovHb?=
 =?us-ascii?Q?XHbE0qfVwn8ANLjocDQZrPZvh6wI8pvwN/wbR3faDQ6pRHVHY7ljyu+9A9kt?=
 =?us-ascii?Q?FzOVPdzGbAMPNFq2wcopIykIXF+D0XEtlzlZcOllQZEH+X4VIkARcWpTBTqI?=
 =?us-ascii?Q?LLvwS3jR75/gql7tHyNOiK5SDMo0SG/jCTKxBBOAUAl83plCAwU4wQ3oTgbM?=
 =?us-ascii?Q?nBXJDPV1nzZ2viFockrDd2eA+tXeuRFRb3ATEcR1UZ4IS/wJs6rZm7WsxO0S?=
 =?us-ascii?Q?y2s8AmmBGgOG6gYgYU/he+62B/Ja1P60RZyO8IBL06WUZ/qfAEQT28ORZBjS?=
 =?us-ascii?Q?GNPdfIFUbSQzm1wAQTcUrvDjmdoLSq4JKSohWRLlenm/MXX38pzYVnpiVz21?=
 =?us-ascii?Q?GHoG71SkYR4GQolfB8NAWTOAR8I+bS82l0cZPE+twV8pjH8OWCzaBS/0Zh+X?=
 =?us-ascii?Q?N+9nSm+tUu7vdY/aj0RN6wCY4YWzYx0VX2XhgMQMTxRJMZ+cRpVRe7sJ2KIQ?=
 =?us-ascii?Q?m4JPmUB1S0V2I+ySEb0orxPIinaNGHunykMHdy80rpdQ7TZbQ2VQWG8mCbYP?=
 =?us-ascii?Q?7TcQgsKHgRg7pddzxylNFQ2kpHA+ze7HWcA+mOaxkh8xqOBjflP2xH63rAlB?=
 =?us-ascii?Q?ubugCrs67kRk+N1D3mwQu+H9bW5IPhR0GJmNl8yD1YAumyKKShQdCcxkX18l?=
 =?us-ascii?Q?6HyrxI85GG0RvQ6twdARjRjlNCJdHzSjH9pZ+/kw7RXdSmy7AbHBYLr91xHp?=
 =?us-ascii?Q?YhfqrMj6NRQO/055HeCtDcZG+MqfG5OKA4QGXeVPumc4pIblFaZiN22JnW6s?=
 =?us-ascii?Q?G17SbyrkL5hhU1A17RVtoB/JVlOLdhfEmUY4XUD7bpa/iZY45+eXZK7UuY+L?=
 =?us-ascii?Q?NmlEhZRX3b/9MvJDgtXj7JtFqqNRnee90KOcrq0lRGnrTqoR4nYP5q31Pfo7?=
 =?us-ascii?Q?/b1H3w1mAW6ALV1hego4q2bxz+xf+zvZ0gOzvfSgLR6wAqI4BtM/J49BPRVl?=
 =?us-ascii?Q?C4XAQ634Tgn7pjDhXQhU+aU11DOZv+aRtnm0pv/gTHYsYZmbsF0IJ4iaAM7M?=
 =?us-ascii?Q?iE+Vr6kNtn352Ue8w319ZliqIYmw7JJ8SaWL4hQDf2ejqe8Lc5Pwqv7GEdK5?=
 =?us-ascii?Q?3zJY7J/nWqZs5xjmEwNzRXh8+HUqkK4pOvJ1Go3x1fZH7YUIWVVwwYu6XXXm?=
 =?us-ascii?Q?6SJ+LyHRn9TRuvLsSk8pXZoYALDv6CcvqyIRzpmQJWbag8r8C+M5omBD3l51?=
 =?us-ascii?Q?c3DPFA7k0ujPm2RqLshyvWcShLtPba0nWxohOur9+OQQ629T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dee523-7693-42a8-0557-08df15376491
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 03:46:16.3775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVtX4uJztcKKOEDZu1qWegEPyw+7XjTn0lylFaOi2I6V6JuWHUkNLFLxPw4KBsXK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Kevin <Kevin.Wang@amd.com>
Sent: Friday, September 18, 2026 11:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: report smu energy accumulator updates

the energy accumulator becomes valid again after an unsupported firmware ra=
nge. add gpu metrics gates for:

- SMU 13.0.10: 80.93.0
- SMU 13.0.7: 82.98.0
- SMU 14.0.2: 102.72.0

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 ++++--  drivers/g=
pu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 ++-  drivers/gpu/drm/amd/pm=
/swsmu/smu14/smu_v14_0_2_ppt.c | 7 +++++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e868bfe1f0e1..6eb829d0edb0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2093,9 +2093,11 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct sm=
u_context *smu,
        gpu_metrics->average_socket_power =3D metrics->AverageSocketPower;

        if ((mp1_ver =3D=3D IP_VERSION(13, 0, 0) &&
-            (smu->smc_fw_version <=3D 0x004e1e00 || smu->smc_fw_version >=
=3D 0x004e8600)) ||
+            (smu->smc_fw_version <=3D 0x004e1e00 ||
+             smu->smc_fw_version >=3D 0x004e8600)) ||
            (mp1_ver =3D=3D IP_VERSION(13, 0, 10) &&
-            smu->smc_fw_version <=3D 0x00500800))
+            (smu->smc_fw_version <=3D 0x00500800 ||
+             smu->smc_fw_version >=3D 0x00505d00)))
                gpu_metrics->energy_accumulator =3D metrics->EnergyAccumula=
tor;

        if (metrics->AverageGfxActivity <=3D SMU_13_0_0_BUSY_THRESHOLD) dif=
f --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b0399dd49639..64590965fe56 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2097,7 +2097,8 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu=
_context *smu,
                                               metrics->Vcn1ActivityPercent=
age);

        gpu_metrics->average_socket_power =3D metrics->AverageSocketPower;
-       if (smu->smc_fw_version <=3D 0x00521400)
+       if (smu->smc_fw_version <=3D 0x00521400 ||
+           smu->smc_fw_version >=3D 0x00526200)
                gpu_metrics->energy_accumulator =3D metrics->EnergyAccumula=
tor;

        if (metrics->AverageGfxActivity <=3D SMU_13_0_7_BUSY_THRESHOLD) dif=
f --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index d91bfa8998d4..20abf342a30c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2172,8 +2172,11 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct sm=
u_context *smu,
                                               metrics->Vcn1ActivityPercent=
age);

        gpu_metrics->average_socket_power =3D metrics->AverageSocketPower;
-       if (mp1_ver =3D=3D IP_VERSION(14, 0, 3) && smu->smc_fw_version >=3D=
 0x00685000)
-           gpu_metrics->energy_accumulator =3D metrics->EnergyAccumulator;
+       if ((mp1_ver =3D=3D IP_VERSION(14, 0, 2) &&
+            smu->smc_fw_version >=3D 0x00664800) ||
+           (mp1_ver =3D=3D IP_VERSION(14, 0, 3) &&
+            smu->smc_fw_version >=3D 0x00685000))
+               gpu_metrics->energy_accumulator =3D metrics->EnergyAccumula=
tor;

        if (metrics->AverageGfxActivity <=3D SMU_14_0_2_BUSY_THRESHOLD)
                gpu_metrics->average_gfxclk_frequency =3D metrics->AverageG=
fxclkFrequencyPostDs;
--
2.55.0

