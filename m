Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8696C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 01:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE6A10E31B;
	Thu,  4 Jul 2024 01:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O/xW9gHf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7520910E31B
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 01:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoEyUZFIYdYcfNrjmLCI5JyByIQnYBsphsYVxLMgIl4PG1L1xOG2I7Bes5fHb38awN9Pzuq/ysT507ji7wV3ehryOOuvmbLJiLroX1sUgmPjqJ1i1gccKUHjwMmfcChdcThvwP7H0C/VrE0ap4HzUUcET0W6eJN40wuUBQkrdygKNYb5yvBW36Crrly2U9Zy55njfy230AgE+2oduK3lOx87Hhtm6wW/Qew2LLMirG2ADWcNPJmN1PwScY/I5tmKGeAWuCb92xhobRGB+P3sxN8Ho7IPetd5PkPcUIRymW+14BERLw6LcCLXr90PwaVjr7TUCtEA/CD0SV3JPH3IEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfOxHFMLS2yGc2Y18K2lHyCHr5LZk6mpYdWFMdThtVc=;
 b=AcqZxPMhbjcJrghprOT2lc1sl6+F0u8yOTj2+nH+h0C6+mtj+GFc1kZo7Adn0ZUINV6LjJsn41v9uEpHqOf3vX3nv2SbETSc33ziCYsow8REfwf+x3ieSJImf0NT5m2K0giXcnRRWmhcmbcWOzwEGmREIwMvsj76YArOGF1nhsq4XLtD0Xhu/xoIl85YozsISH5eIh71uoWBEPzR768TdLcH3Cu6vxLHZUWMkyeHNqUcaniHjezyaY9UFc4vA8/Yl5dxKEcMg3vHeaGUjqgEFNgZWkZeRS0fGFST418l3uFkAcZr5yn5LPda7X2Oaj4EscQ7mNUWKr6ve1yvzT9SNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfOxHFMLS2yGc2Y18K2lHyCHr5LZk6mpYdWFMdThtVc=;
 b=O/xW9gHfub3FZO57MVvinQW2Hi31Hi9od15XBxI3ORTiiQZ/dUDEf4vBpbykZ6FyIixpErPksMulH72Gwll3GiXLoIT3Esubb0smXQDcw1fK+axm6TQsveZfVGu4TtiU2OOdBHvXcq2n7jvjGRKvr8NIwJubEd0qAjRE2m6or9E=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.33; Thu, 4 Jul 2024 01:59:36 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 01:59:36 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] amdgpu/pm: support gpu_metrics sysfs interface for smu
 v14.0.2/3
Thread-Topic: [PATCH] amdgpu/pm: support gpu_metrics sysfs interface for smu
 v14.0.2/3
Thread-Index: AQHazaeGz4ASjoy0lEeIuJDisyoizrHlz/2Q
Date: Thu, 4 Jul 2024 01:59:36 +0000
Message-ID: <DM4PR12MB60124EE4B2977B740A69634D82DE2@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <20240704001659.36563-1-kenneth.feng@amd.com>
In-Reply-To: <20240704001659.36563-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d65b6599-aed0-4d2e-9b09-54d7a636f79e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-04T01:58:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|MW4PR12MB6975:EE_
x-ms-office365-filtering-correlation-id: 40cd51e7-e275-4986-e689-08dc9bccf4fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IHVbr9VWm/mAmGz/kt81WswVel9SPbLN0V9X986DqsKi+5Ooty0UlaVT33Fx?=
 =?us-ascii?Q?3QKimLm3wd/9gMaExJXVMf/8eO4iwnzKWZlqrmdGnKGwpD2ibEFZoLYIuyYu?=
 =?us-ascii?Q?mxKGFWbUlDOzPt+V1g95PDDnBqAmIZBNPqR5uDVdU8LWKAAHChlcMKD3kQlm?=
 =?us-ascii?Q?qD4b4CdEW8dcJfi+udw4oWk9Imxsh9HWKcQHG7qWPT/qQKPAhLHAkAt6Cgzh?=
 =?us-ascii?Q?eVNIgQvlYPP9q13X2hSR/3/LRINHleez5OwcD8doDzIa9vGhw9JBbOOZqrsI?=
 =?us-ascii?Q?ga+Y89I+2MGT+c9TQ6BC8jRwvQQrdsoJDrsrOrBTdnNZuaeJlBmLZw7ta7qa?=
 =?us-ascii?Q?uU3dzaihTFpLIPbYi410VAOcF+GmORt4v9uictmvUJW3e4w0qRwywvYUsJqo?=
 =?us-ascii?Q?/lq4tZu8SQW9pOFiGsudvszSYLkoYnzno2KDcmsO25c1JuYqwFUlyjX7exS4?=
 =?us-ascii?Q?bxRPxAI93irWbNnsVI25D0MAbLi2XU5ZWeXAN+z5R1oPPVM6GBtEn7uGk727?=
 =?us-ascii?Q?Ko8W3KgYFArKnTxNOjPjHHA/dGBsoBAdc6aJslf222tBMbQtTK5+jmaZbqVc?=
 =?us-ascii?Q?DOaEklbMhmXNK0VszR1Lh8Y1M3/yXsGHZOpmIRm3uHoIKQ5Hgsj4vTTJXocp?=
 =?us-ascii?Q?z3gMScBSABBgWUr5nImcZ+ktdNjH/DLMG6xu7y6G+SwVl+NA4SL3KLgjfli+?=
 =?us-ascii?Q?IQ6AwhtMbLR95fYCH57SwxkaCo0FiNQvgMrazMF/ftDp9KwAQrZX5VZ29f5t?=
 =?us-ascii?Q?C+zXkdbTcBhqBW6eMZ+lm7Da/BwVKOlA3uXqgXNL1fnUa32hDaMISRdLgCbt?=
 =?us-ascii?Q?01s+8/PFEFfoUuAE+gQ3BUGcxLMwF5CKPtu79OgsY4T4Vov4PopJ6t/pkfwy?=
 =?us-ascii?Q?xChssL3GCYUZHmUeG9vdjgnmmjBwko4ld462cvSthyxAktNr7bbxiRVJ/LIZ?=
 =?us-ascii?Q?U1cRMSMPIef1c1STLYVpENCrnc9Sz/+IjPilUg05oKk6CPOwjlcsg481NfaY?=
 =?us-ascii?Q?M6qiE6MH76jga+MeboGxlas8v69Ijsngs2lJ0nUlw8MJeQxYvxpfSnZJKpz8?=
 =?us-ascii?Q?EHvvvszqOQC6sZ6wkJ2tyOFw32zX6IV1Aab2MD6IMMe5Damt1znAOzprA01+?=
 =?us-ascii?Q?wTUKnzFT0Z+9IvRG478YTcunY9r9IUbqQKqVhV30KRvyHl7qlGPpgbnfN6Zd?=
 =?us-ascii?Q?uOECSPnZAi+H16tqCN3fPUEm5Yk+4yMTSaRPVh5P5/zP+prTLvFplGP8Ciay?=
 =?us-ascii?Q?hKrKGaW0YCsQe2i8kUoExDBUEplNJJ22XWD3HPD2uSwOYFopEAGMEnGlJrIL?=
 =?us-ascii?Q?/Q/Vi/IuOVMgLV/nY3NCzl0YcLE9h9aimFvH+l1V6af27za4g5x1TKHBkJGT?=
 =?us-ascii?Q?tMWjUqfeUrMgsgeTZj5eaV15RzUK4rpeIH29TrYZyZKY1t9i4w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CHnOjuy5FM30Ls794+wQcRV1L02Y2XYXqZlQzbR1VuaFuMvoMWSHgSzsPgcp?=
 =?us-ascii?Q?Sojnww8x1PqCGX8hqvfV80ULQ32vZjcX48ghnWcRV9h8Vr3WvzzCgLzmK7ZC?=
 =?us-ascii?Q?3k15v4M/lLLF+V0hVVclw/gZHien5nUBlsvfTLZtM7pwcX7iIt4NB0nA9UBp?=
 =?us-ascii?Q?8bEw13llzm3TyPsGTEwSpVK/mISN/sNxmYsvzvyDX3ZgvzgC8ZSAobizcp0L?=
 =?us-ascii?Q?dTnjKv/NqvrXdl5yAJWlYmbNnPyEF8sH6N/o8r39LjCcPQCqxQ/q4zIMDs0Y?=
 =?us-ascii?Q?DH2XxCTftPYzwZnGkDXNHo1aXcHNBolJ3DbZoDLcHq28jyC72lpss34lYNyG?=
 =?us-ascii?Q?Mis75v2EaXBievJ75hfW9DTxDiQ90EbYtuM/wE6A6ttxbmrJBRnhI29IcfEg?=
 =?us-ascii?Q?LbcFoJPGoSC49heufgFRnziWWLSv/5Dlb9SbTYrueb+WkidteQ+QPHBBAt3P?=
 =?us-ascii?Q?2iJF/O6t6JTVHu36f5QkWGz/7SFP5RHAtqVLRZ3IoZwzH6sNFrNuKwIv6XCy?=
 =?us-ascii?Q?FyQCWdJHOQUyDm+KeZ1wM7eqhWsmHuLzvylkpqHmzovoIXF1qWVpSEYGK+UN?=
 =?us-ascii?Q?Br67sfiXcGvzun1uIk3preMrFA/7jmvU+9m2Nn1g8Vi2Lrn/gXwmJgJv50lU?=
 =?us-ascii?Q?7iTlMro79/79XY2l3URa4xzqbn/fqC6tdJ2Mm6inmjkj0mRpxa61U7chvu0g?=
 =?us-ascii?Q?3C9beEoLTlhM6S/NJ3rsNc5EDdnd9wpp9yLtoWMYwoYMb2as+3ih4Z9LzwjH?=
 =?us-ascii?Q?K4auVjh2K0j5ISwjz6xbBqUrHW4Zi2fSbd7b4TpbRHz9LweouESbhjyV+yCZ?=
 =?us-ascii?Q?0aZoHYjmicuvslZb46u3mVGeI2eH00Vm/hsR4a5T9Iw0SAERv88fpOcRiFJg?=
 =?us-ascii?Q?pPsWpADNiP8Zkol1dJWD3KcGwjxFW+u7T+T2db39XHZ5C37P57UJE3MmTetM?=
 =?us-ascii?Q?9MhfgJfGruH+B4vcujxO3dbh+0zvkIaCRYdOqCvrDfgRfFf0XJd92x5tbbe6?=
 =?us-ascii?Q?KOQsKjw+FZxnpz5x0mqp0zrukxniDKwyE3zR0zbN2xLL5YfMz2XKPtuXHhDe?=
 =?us-ascii?Q?GLKWz8BuX3uj2gndpj5IKNLPXBURTIAjzO1CECmDsXGa2FVsO8/gL3Rp6SqJ?=
 =?us-ascii?Q?+YToDsXgm/PizaA9e/rL58zsK+59VyyaoBEoTjLAcYqHku8Za7LUNoI4hlkM?=
 =?us-ascii?Q?vHat/uE95F6Wi2+hf2bIj/+QE/PRmTaJUYsd7Dkb8afhAGXkCpssFMsC+9Ox?=
 =?us-ascii?Q?NWS62Bui7G6JIIcVezJrDTjXWLIea5+YbQSP7eFkDcvU/Hfnx15hhlK/CrCL?=
 =?us-ascii?Q?24Cv8xA/heUPfzFhd7Ephd5B+gR6BAZabLEI5Ry7hVWaA8KgghWnZXxpUC6w?=
 =?us-ascii?Q?oiYCD8YICovgv2mrbjd/itIBbue5C9VeKwkvnAwaFg3EmX5730qqa0mJ7Fd1?=
 =?us-ascii?Q?xm5Z65xDJDS/8ZUKVJcUmteGmf1PF3sPIst25f9/WKWSh0KcGJ3G84vh3Df9?=
 =?us-ascii?Q?djD9kpSlLFp5qESbBlolonyKpg9dnNrLhgTXodFBra7V8pq07f7fJuz6ShSd?=
 =?us-ascii?Q?84MFogQ6ReC+eY/xLSw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cd51e7-e275-4986-e689-08dc9bccf4fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 01:59:36.5407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAg/z5Ee5VOsNDUutRZd2tIMkqe1nFkvo+sfoiC1EkHo7DJjnEAHdZ982sSFh8ce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

It is better to change the patch tile prefix to 'drm/amd/pm' .

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Thursday, July 4, 2024 8:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] amdgpu/pm: support gpu_metrics sysfs interface for smu v14=
.0.2/3

support gpu_metrics sysfs interface for smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 86 ++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 98ea58d792ca..e1a27903c80a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -66,6 +66,7 @@

 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE  0x4000
 #define DEBUGSMC_MSG_Mode1Reset        2
+#define LINK_SPEED_MAX                                 3

 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COU=
NT] =3D {
        MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,     =
            1),
@@ -221,7 +222,6 @@ static struct cmn2asic_mapping smu_v14_0_2_workload_map=
[PP_SMC_POWER_PROFILE_COU
        WORKLOAD_MAP(PP_SMC_POWER_PROFILE_WINDOW3D,             WORKLOAD_PP=
LIB_WINDOW_3D_BIT),
 };

-#if 0
 static const uint8_t smu_v14_0_2_throttler_map[] =3D {
        [THROTTLER_PPT0_BIT]            =3D (SMU_THROTTLER_PPT0_BIT),
        [THROTTLER_PPT1_BIT]            =3D (SMU_THROTTLER_PPT1_BIT),
@@ -241,7 +241,6 @@ static const uint8_t smu_v14_0_2_throttler_map[] =3D {
        [THROTTLER_GFX_APCC_PLUS_BIT]   =3D (SMU_THROTTLER_APCC_BIT),
        [THROTTLER_FIT_BIT]             =3D (SMU_THROTTLER_FIT_BIT),
 };
-#endif

 static int
 smu_v14_0_2_get_allowed_feature_mask(struct smu_context *smu, @@ -1869,6 +=
1868,88 @@ static ssize_t smu_v14_0_2_get_ecc_info(struct smu_context *smu,
        return ret;
 }

+static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
+                                          void **table)
+{
+       struct smu_table_context *smu_table =3D &smu->smu_table;
+       struct gpu_metrics_v1_3 *gpu_metrics =3D
+               (struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+       SmuMetricsExternal_t metrics_ext;
+       SmuMetrics_t *metrics =3D &metrics_ext.SmuMetrics;
+       int ret =3D 0;
+
+       ret =3D smu_cmn_get_metrics_table(smu,
+                                       &metrics_ext,
+                                       true);
+       if (ret)
+               return ret;
+
+       smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
+
+       gpu_metrics->temperature_edge =3D metrics->AvgTemperature[TEMP_EDGE=
];
+       gpu_metrics->temperature_hotspot =3D metrics->AvgTemperature[TEMP_H=
OTSPOT];
+       gpu_metrics->temperature_mem =3D metrics->AvgTemperature[TEMP_MEM];
+       gpu_metrics->temperature_vrgfx =3D metrics->AvgTemperature[TEMP_VR_=
GFX];
+       gpu_metrics->temperature_vrsoc =3D metrics->AvgTemperature[TEMP_VR_=
SOC];
+       gpu_metrics->temperature_vrmem =3D max(metrics->AvgTemperature[TEMP=
_VR_MEM0],
+                                            metrics->AvgTemperature[TEMP_V=
R_MEM1]);
+
+       gpu_metrics->average_gfx_activity =3D metrics->AverageGfxActivity;
+       gpu_metrics->average_umc_activity =3D metrics->AverageUclkActivity;
+       gpu_metrics->average_mm_activity =3D max(metrics->Vcn0ActivityPerce=
ntage,
+                                              metrics->Vcn1ActivityPercent=
age);
+
+       gpu_metrics->average_socket_power =3D metrics->AverageSocketPower;
+       gpu_metrics->energy_accumulator =3D metrics->EnergyAccumulator;
+
+       if (metrics->AverageGfxActivity <=3D SMU_14_0_2_BUSY_THRESHOLD)
+               gpu_metrics->average_gfxclk_frequency =3D metrics->AverageG=
fxclkFrequencyPostDs;
+       else
+               gpu_metrics->average_gfxclk_frequency =3D
+metrics->AverageGfxclkFrequencyPreDs;
+
+       if (metrics->AverageUclkActivity <=3D SMU_14_0_2_BUSY_THRESHOLD)
+               gpu_metrics->average_uclk_frequency =3D metrics->AverageMem=
clkFrequencyPostDs;
+       else
+               gpu_metrics->average_uclk_frequency =3D
+metrics->AverageMemclkFrequencyPreDs;
+
+       gpu_metrics->average_vclk0_frequency =3D metrics->AverageVclk0Frequ=
ency;
+       gpu_metrics->average_dclk0_frequency =3D metrics->AverageDclk0Frequ=
ency;
+       gpu_metrics->average_vclk1_frequency =3D metrics->AverageVclk1Frequ=
ency;
+       gpu_metrics->average_dclk1_frequency =3D metrics->AverageDclk1Frequ=
ency;
+
+       gpu_metrics->current_gfxclk =3D gpu_metrics->average_gfxclk_frequen=
cy;
+       gpu_metrics->current_socclk =3D metrics->CurrClock[PPCLK_SOCCLK];
+       gpu_metrics->current_uclk =3D metrics->CurrClock[PPCLK_UCLK];
+       gpu_metrics->current_vclk0 =3D metrics->CurrClock[PPCLK_VCLK_0];
+       gpu_metrics->current_dclk0 =3D metrics->CurrClock[PPCLK_DCLK_0];
+       gpu_metrics->current_vclk1 =3D metrics->CurrClock[PPCLK_VCLK_0];
+       gpu_metrics->current_dclk1 =3D metrics->CurrClock[PPCLK_DCLK_0];
+
+       gpu_metrics->throttle_status =3D
+                       smu_v14_0_2_get_throttler_status(metrics);
+       gpu_metrics->indep_throttle_status =3D
+                       smu_cmn_get_indep_throttler_status(gpu_metrics->thr=
ottle_status,
+                                                          smu_v14_0_2_thro=
ttler_map);
+
+       gpu_metrics->current_fan_speed =3D metrics->AvgFanRpm;
+
+       gpu_metrics->pcie_link_width =3D metrics->PcieWidth;
+       if ((metrics->PcieRate - 1) > LINK_SPEED_MAX)
+               gpu_metrics->pcie_link_speed =3D pcie_gen_to_speed(1);
+       else
+               gpu_metrics->pcie_link_speed =3D pcie_gen_to_speed(metrics-=
>PcieRate);
+
+       gpu_metrics->system_clock_counter =3D ktime_get_boottime_ns();
+
+       gpu_metrics->voltage_gfx =3D metrics->AvgVoltage[SVI_PLANE_VDD_GFX]=
;
+       gpu_metrics->voltage_soc =3D metrics->AvgVoltage[SVI_PLANE_VDD_SOC]=
;
+       gpu_metrics->voltage_mem =3D metrics->AvgVoltage[SVI_PLANE_VDDIO_ME=
M];
+
+       *table =3D (void *)gpu_metrics;
+
+       return sizeof(struct gpu_metrics_v1_3); }
+
 static const struct pptable_funcs smu_v14_0_2_ppt_funcs =3D {
        .get_allowed_feature_mask =3D smu_v14_0_2_get_allowed_feature_mask,
        .set_default_dpm_table =3D smu_v14_0_2_set_default_dpm_table,
@@ -1905,6 +1986,7 @@ static const struct pptable_funcs smu_v14_0_2_ppt_fun=
cs =3D {
        .enable_thermal_alert =3D smu_v14_0_enable_thermal_alert,
        .disable_thermal_alert =3D smu_v14_0_disable_thermal_alert,
        .notify_memory_pool_location =3D smu_v14_0_notify_memory_pool_locat=
ion,
+       .get_gpu_metrics =3D smu_v14_0_2_get_gpu_metrics,
        .set_soft_freq_limited_range =3D smu_v14_0_set_soft_freq_limited_ra=
nge,
        .init_pptable_microcode =3D smu_v14_0_init_pptable_microcode,
        .populate_umd_state_clk =3D smu_v14_0_2_populate_umd_state_clk,
--
2.34.1

