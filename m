Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB86C4167D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Nov 2023 04:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A0910E1B0;
	Thu,  9 Nov 2023 04:09:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C19810E1B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Nov 2023 04:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJr6OPhoYeEFXiY0vm+PF2GKJ36uPlnPj69wRdXbHU70a8QMm6t0qTeTcHnUrnXYFUxAir+9lBxp0Y2fJmxyE8BCFpmzyqaQ9aZlnPJERrL+eTIuNxnrBZJnrbs4DJiVVdtwSJkIZbyZqHu7p9KtS4/l/oFmOzUPR2fOeoqgwQ4yzfGYH9nKbjETZXSkM/INGDOgP10jDYPkkmbDICWRNOWt2P/1UUa4rpUSCPMtv1FFvE1GbME8y7iiWbfNsGFKk2VTj8rFbv1RG7Gl/RI2aqJ2u89SFdpcmyC6qWqiMbrIdEg/mQXqiDDHPjRi0+u54uaN6FwNOHPZlg+tlPGSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXgdo/6suAjZhats/ht+Vh0PlGUO9s8u9L9Mz7PEeCM=;
 b=K12WGkgROPmanzyB4mREfkSTT1IuZz3z6faaqHqAePHxDbL1Ycam/Z9NLMblZcptaFqDMXIWZKweLFgprCzx5oLRDMpxRn9BhuZ5xQAL+UbFdzLO0H1x9/3a6UaoZSTrVrMqFc1BfaOFXvXfzmAsxi8dz8OLIeiYgs2k00sZr2suZBeGhyx+wjXVZWrdWVmunwH+QNA0L/VvFKDmRLawvoVSv0nNeq2tmAngy9k8p1//Iv1c80GzmHz7ymxZLstUZOBdgAb5ZNiLdGguPtiVTT8ajwd3mM7yd+ZdVHq//TMocCPDFD4jN2iNwcCftHuoIPRm0jxcL6JnzHNG+xWkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXgdo/6suAjZhats/ht+Vh0PlGUO9s8u9L9Mz7PEeCM=;
 b=YKbOgp7VTPU7UzgJWQuJrk/exHzaLesC/TFbu6u77GoJwj/5IAJ///uebHrAEr1JBztFZwFoiUQrlHawrrRMbtR6x9uGBiGfnzaCHxLqArjQOIPVmd9h2uaePnOxfM5wE5eRVbu167tALRRP0RJfeq1zc+73Qf8riqeIgI8BbQg=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 04:08:57 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 04:08:57 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Make smu_v13_0_baco_set_armd3_sequence()
 static
Thread-Topic: [PATCH] drm/amd/pm: Make smu_v13_0_baco_set_armd3_sequence()
 static
Thread-Index: AQHaErI3eH/2I4uitE2/UbYsQOg/v7BxX3Yg
Date: Thu, 9 Nov 2023 04:08:57 +0000
Message-ID: <PH7PR12MB59972C838FB821B88B5F6AF582AFA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231109021221.4055378-1-Jun.Ma2@amd.com>
In-Reply-To: <20231109021221.4055378-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH8PR12MB6820:EE_
x-ms-office365-filtering-correlation-id: 4b2a16f9-a754-474a-cf2e-08dbe0d9986f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RTlfDaWyWYgzcwvsuePNcUdQm0L2ZoIlOCCnbA0/cdJtj1tV5Kn6s8zldj9E3zPnWi7Yneg7+zUg8uDiBGAerg91rvICNgMtn6IP5Ux+YMPxkCPaDkh0OycJPeqNrmLgGzguVqQa8aQ5hcRaK6YOVwPiKlegHoKRauCHDN+zRBpgP+eXXII1iQMWedhmqRI7iKdDTumB+gHb54lrU3XtvUeOmbvS/4Fx9x1ecXGSlActwSe64YMoyok840uVah3ysl3mTDQ4JYIMWl9DfJbXhApla9TU8BCCuNEfjoxRujW5MjVCNW6aPS8185XClF8RkuHby1CQt0j8KWodpBUi2uXGeybWuFa4hrBMI7zcx/W0nH1qoy/iLQYodTbyzWgYgWDSThSmEUuDtt0BfFO+Lkh9kPthFrmENIImxbuEVr7dvaqt/FFa1g9KSmOD22TY+IC4DjkHKAZj/nGo4IKBbnncYzHsG6rVitaK10jOgd4Noe5MxIDT511AFUUG0cHbjjoVd0xQpZA4y1q79R5RyZe88W9neu02W+YQPUKO0hXXMWEaTd4S29SS/aixOaTuMvs26yGv6iqJkpXYsuQvsN3x8IbFsOodMkQ9+pj4++03KllLRwsNIzaJ7ZwVa97a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(33656002)(41300700001)(66446008)(64756008)(76116006)(478600001)(66476007)(66556008)(6636002)(8676002)(38100700002)(8936002)(55016003)(52536014)(110136005)(66946007)(86362001)(5660300002)(7696005)(316002)(38070700009)(83380400001)(122000001)(53546011)(71200400001)(6506007)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T2rC623sC+MwiYZQ4pbYxdur8DW1C1QLbvXeGKi8GTi6PsOYzfML/gGKvuTx?=
 =?us-ascii?Q?TupBvdJpaTeX9JBnACMFSGZ42yPpBn5NNEU3IGFy13LcDumyBXSG+XXuePbw?=
 =?us-ascii?Q?FI8dqtKAAGH5AOpeZvxX4UK8d8W5kelkqTgPFFn5OW58VEWDes9kKDvUM/4d?=
 =?us-ascii?Q?dUfCxJHLug9+pFNFbVs8AcEX/GuHfio1ZSxlTLlYkQljurMkbn6c63v2p+0o?=
 =?us-ascii?Q?YIcnRYkp/Hqtljvd/JXp2gN6S6ECpWHuae8PHgcygTJc3I4PjfdzsXZ53Wdk?=
 =?us-ascii?Q?rqVxeoK7l1kWwviOfs8dDmAvKdfs4ZuLJPnn4FDV4CL8o7OlAhj8AhNRuSeu?=
 =?us-ascii?Q?evA4APWh1bA20M1JYbc4dUe2yhq3PloqnvnW7byAr8b3q6cRbRkjVa69X8OI?=
 =?us-ascii?Q?ofYLOO+7ZJ3aVvb5SgPaTEl7iWpFxG4NYi8L/pj6jkX0PRnyt0kgQ96zMgaa?=
 =?us-ascii?Q?NIkMBvZo/oFGX0Ca+82pKyfD55uneVUJVQTo5SxHHDriUGkR+IIP0YXY6YvG?=
 =?us-ascii?Q?usQ/8XiC2tY0sRS1JUdM5StM2X66cHC8ehciqqE/q2m2hpB8yA08pmUsFwzY?=
 =?us-ascii?Q?xITXX5VH4WzD+gJyTLQwDWubIKlQ8yfaCuVvZc1fKoV4mCa2hZagCILpbEPn?=
 =?us-ascii?Q?MzfJRp7/hGofEbJpePB2NKNjGPOsXZWKfYytbIPC882IXAJ1yuzGLrrFQQQ6?=
 =?us-ascii?Q?3fXXZvSnbxV9ADqF5qUcFlh7A39dzWbkEW32YKY5REiv322WKNDAlSyBOXRm?=
 =?us-ascii?Q?JNwEBofFs1k9kZMEZ5sG0F4iszQAS+u2uUymDC30umyN6QcE1KPraILmhiA6?=
 =?us-ascii?Q?xILvdYKuodhdj2z7ya5Q9tHx41YEWTPbuKXZ/t8XgOvj73i6q2Mar0RiwwMo?=
 =?us-ascii?Q?6Mf1Ib4EXxVrik/qeUiVXkOdRbNA4Ckwvd8gEI+3KhgkSQ4zqV3OjDWAq2N4?=
 =?us-ascii?Q?au7aPFe8Fd0er5CS6nJAWxaF91ip+UY6nobCkEcBETZtuRDvzuCSPJ8CNILV?=
 =?us-ascii?Q?V5D8LLyphMhJZbarVj9L2PVwkQXgibmD1oE5EOXCUxMVBFUa9x1bAsiDjWa6?=
 =?us-ascii?Q?Am5vhUv7NDudU8fNHC2S22NtRUkuKuto0EH2decD/i5PxzMftiIDybcy21To?=
 =?us-ascii?Q?I1Bi+YRUDx33YxdVNNvNit5wPyIfKktytY68BLD0M4W8d1tBcr212/WxiCPh?=
 =?us-ascii?Q?ConShABt1rFxZjxZexQf+QeDkBo5aI+zNTnnsj6PRyE73qxSSxN3Ey5lPFLa?=
 =?us-ascii?Q?D0eavW4OSoHXDDU9isHRrIaPUwiE8TJqX8R4Wkfm+wClyCyvc5ryfqIAbswt?=
 =?us-ascii?Q?N6mtSrM/AE3mmX00VSMcsjkFEfSu+o/iW4+2si2jonkLS+Sgf7RCj50aia5H?=
 =?us-ascii?Q?H94OEPS32FyYMgblK+Tnv92bdQbahvvczVIvn1uSuyhnvtl19afjVlp1HI4T?=
 =?us-ascii?Q?ijIyCVvcxrESvBtJHVJZZkWaXqkCWbqS3Oi53ahf/HJJHAH+QZLFQFrLh6tZ?=
 =?us-ascii?Q?to/f7DvdW0Xr80QjOxC9RapPD84mqwAwrlYKNi6DOEKW2zecXYLtcejpmjrj?=
 =?us-ascii?Q?jEjVG/9nd4mVVS6yX5Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2a16f9-a754-474a-cf2e-08dbe0d9986f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 04:08:57.2967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZIppVf3l8pJhUk3hhq6WaEQ3nDbgEHIXR+xagmLR6DyCtttlV+rDoV40fttTn1F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards
Kevin

-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>=20
Sent: Thursday, November 9, 2023 10:12 AM
To: amd-gfx@lists.freedesktop.org; Feng, Kenneth <Kenneth.Feng@amd.com>; De=
ucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.=
Wang@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amd/pm: Make smu_v13_0_baco_set_armd3_sequence() stati=
c

smu_v13_0_baco_set_armd3_sequence is not used by other files, so make it as=
 static type.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 3 ---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index f307a7965941..5e7b8f29fecc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -210,9 +210,6 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu=
);  int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
 					       struct pp_smu_nv_clock_table *max_clocks);
=20
-int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
-				      enum smu_baco_seq baco_seq);
-
 bool smu_v13_0_baco_is_support(struct smu_context *smu);
=20
 int smu_v13_0_baco_enter(struct smu_context *smu); diff --git a/drivers/gp=
u/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/s=
mu_v13_0.c
index 891c3fddd7b9..5e86d874cb89 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2198,7 +2198,7 @@ int smu_v13_0_gfx_ulv_control(struct smu_context *smu=
,
 	return ret;
 }
=20
-int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
+static int smu_v13_0_baco_set_armd3_sequence(struct smu_context *smu,
 				      enum smu_baco_seq baco_seq)
 {
 	struct smu_baco_context *smu_baco =3D &smu->smu_baco;
--
2.34.1

