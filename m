Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450D8C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1678F20720
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 09:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JQ4pYhRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1678F20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD69A6E1B2;
	Tue, 21 Jul 2020 09:01:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1896E1B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 09:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxZJTveB7Kzuk5/IU8UXTuquHQx6iuCeJaC7uoWCuLN8pT0mPEWAwGz8i9J7X5BD55zu2zp/ja82DYm7WKmhA48kjOUYGwFLho5vTGwQMf3kgwNRltlDX+PUOsc+mg3OQCNhv3qeU+4gBwPbaBZkm2MSi/QbT/vYCNxtENpL532ti6jhI324/a4xFMvMnAFQx+0AhGdVH8nVHFGaQks+cFQKsy24q7J82Vpu2AiWcjqXUkP4rLqFUymJMKAxmmZACAS9grxx0MXj6G1xZPifJXCZlu9il+jOuQpLqottdAwP5xLA+er20EAntDHLZlyS1aV++GgMzBmNTD6qpjeomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCDKqgXBxAXOOEadHdJpZkp6gCRpRTO3iBbB+iLdYjQ=;
 b=I1eL3A5XWQpe6cBldVOpkmSb5OiCxooMR5A+kDaTgBw3atVFM5R/LeRGIuQZKULkvtzOXe4lTOE4ubqV3+9iz1a9WwlMUgRV6Hd3VAPd5bxw3+5zKg8MqTQwOXphuAwMUJOyV9eXAzwr5bbMzd2TcRk0QdLAmyf3lMC54R6B662p48VMSLwJH35ShL+w3NGDQvmJeNslQGjT5y5tR5MEPOa21gTcjQltpWw9nMfL9h5XUw8tHPkxlu0SE1Vyc1rMgWA6IWeEVWrj3xr39B43uzD5hZoSIiDd+DW0mGV8n/yS0/HqHap5AyDb2UA84pyGXZi4G/3CheTT1zpP3cAceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCDKqgXBxAXOOEadHdJpZkp6gCRpRTO3iBbB+iLdYjQ=;
 b=JQ4pYhRomcu8FrBrsl86gwBx50KAaS4wHQEYUCxDR0ZkJUh4kWjqgTWan3qmdqVdHHoN5DjG0lqqA2vH4+aVu1AU2k+hc2KgMBSx7bdoyromzcNpPWqnQSsgZZ49Fx4+/0kszRPBeughQ/DP7Is54JiTYnoJYX9nvGz2wqa5tQo=
Received: from BN6PR13CA0019.namprd13.prod.outlook.com (2603:10b6:404:10a::29)
 by BY5PR12MB4035.namprd12.prod.outlook.com (2603:10b6:a03:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 21 Jul
 2020 09:01:23 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::28) by BN6PR13CA0019.outlook.office365.com
 (2603:10b6:404:10a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.17 via Frontend
 Transport; Tue, 21 Jul 2020 09:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 09:01:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Jul
 2020 04:01:22 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 21 Jul
 2020 04:01:22 -0500
Received: from jiansong-dev.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 21 Jul 2020 04:01:20 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/powerplay: retrieve VCN dpm table per instances
Date: Tue, 21 Jul 2020 17:01:09 +0800
Message-ID: <20200721090109.2733-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(46966005)(186003)(70586007)(6916009)(36756003)(47076004)(26005)(426003)(478600001)(336012)(70206006)(2616005)(82740400003)(83380400001)(6666004)(5660300002)(356005)(7696005)(82310400002)(8676002)(316002)(81166007)(1076003)(2906002)(4326008)(86362001)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4830b0b9-6668-45ac-96f6-08d82d54a43d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4035:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4035B2A258CE4139B07C94BDEA780@BY5PR12MB4035.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0mESuchv2SxXVLAyYFG4npsqZnhk5omxpfxULvDrht/kioOTVc1FKUlHgAnBwF5jq0uELV3TMzoEd4ICDpvAgCfiefnG4KnwNv6PNA+qbYX2zjhdgpupJOelTyszFpTmNT7OHgx83LEfG/bdeC6TqGgiLNQm5ESlcy1WrajOtC2ajDVbOXZ0BZr+jS46R3QQbi3rnI1xYK00P9Vfli8h45ZoOcMeR2aLm0tq94UJmvCXTKZ944eNYJawkduV1i+NTyDFcvOmX80r5r9dj8IdzA4QP0AVoUfSuAfgipLMvgiEj39BIb6PLUApKH3szSMgA3AY9aGLptAqO3YKpnVCbJ4q+QpL0ZEmylIDMDwAl5yrHb7NKsrnrbZK/yaxQFf+yb3faFpUW0hsbUKHrToxA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 09:01:22.8477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4830b0b9-6668-45ac-96f6-08d82d54a43d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4035
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
Cc: Tao.Zhou1@amd.com, kenneth.feng@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To accommodate VCN instances variance, otherwise it may trigger
smu response error for configuration with less instances.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I0bfe31f1f5638d539ac6ded3bffee8f57574bafa
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 68 +++++++++++--------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 87eedd7c28ec..c8b59a891f5d 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -525,6 +525,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
 	struct smu_11_0_dpm_table *dpm_table;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	/* socclk dpm table setup */
@@ -617,22 +618,26 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
+
 	/* vclk1 dpm table setup */
-	dpm_table = &dpm_context->dpm_tables.vclk1_table;
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-		ret = smu_v11_0_set_single_dpm_table(smu,
-						     SMU_VCLK1,
-						     dpm_table);
-		if (ret)
-			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_VCLK_1].SnapToDiscrete;
-	} else {
-		dpm_table->count = 1;
-		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
-		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
+	if (adev->vcn.num_vcn_inst > 1) {
+		dpm_table = &dpm_context->dpm_tables.vclk1_table;
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+			ret = smu_v11_0_set_single_dpm_table(smu,
+							     SMU_VCLK1,
+							     dpm_table);
+			if (ret)
+				return ret;
+			dpm_table->is_fine_grained =
+				!driver_ppt->DpmDescriptor[PPCLK_VCLK_1].SnapToDiscrete;
+		} else {
+			dpm_table->count = 1;
+			dpm_table->dpm_levels[0].value =
+				smu->smu_table.boot_values.vclk / 100;
+			dpm_table->dpm_levels[0].enabled = true;
+			dpm_table->min = dpm_table->dpm_levels[0].value;
+			dpm_table->max = dpm_table->dpm_levels[0].value;
+		}
 	}
 
 	/* dclk0 dpm table setup */
@@ -654,21 +659,24 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	}
 
 	/* dclk1 dpm table setup */
-	dpm_table = &dpm_context->dpm_tables.dclk1_table;
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-		ret = smu_v11_0_set_single_dpm_table(smu,
-						     SMU_DCLK1,
-						     dpm_table);
-		if (ret)
-			return ret;
-		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_DCLK_1].SnapToDiscrete;
-	} else {
-		dpm_table->count = 1;
-		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
-		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
+	if (adev->vcn.num_vcn_inst > 1) {
+		dpm_table = &dpm_context->dpm_tables.dclk1_table;
+		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+			ret = smu_v11_0_set_single_dpm_table(smu,
+							     SMU_DCLK1,
+							     dpm_table);
+			if (ret)
+				return ret;
+			dpm_table->is_fine_grained =
+				!driver_ppt->DpmDescriptor[PPCLK_DCLK_1].SnapToDiscrete;
+		} else {
+			dpm_table->count = 1;
+			dpm_table->dpm_levels[0].value =
+				smu->smu_table.boot_values.dclk / 100;
+			dpm_table->dpm_levels[0].enabled = true;
+			dpm_table->min = dpm_table->dpm_levels[0].value;
+			dpm_table->max = dpm_table->dpm_levels[0].value;
+		}
 	}
 
 	/* dcefclk dpm table setup */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
