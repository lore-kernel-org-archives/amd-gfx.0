Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2554C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 21:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5CD61359
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 21:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE5CD61359
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F1F6E4CA;
	Thu, 21 Oct 2021 21:51:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D7B6E4CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 21:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzoZj/tlLOBiroo4EfgVEeNdj6eCGNEBGbm3qN66JJDAmqrVW9QdvXZX990J2Etrplr6xvmiR13YIH0w0gBoSCCyll7jR530X4B4jVuiWsBKkXjc6EzBUbwRXmZUgIRDdFYtl8HHmJDiq6eJZd2GkhCJcxN+AEDVTaK2zzTgjEw1D/QawdV/dI21YqDJikU8WJ/vXUkE6Sym4HyeEuZ5bSQLYIr3/48IETnHOcMJWHksN04iwTEsNjGZzev/iWhqAbQcd+4HX7u4LO8mUjWKisPbpxcAhbwAMCASdnfaRqfesbMmdf4wDx7zPfEuT1q/L6dKj6qQtwlSPWY9Crj8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2UpgYCJXHNk6ooSyseJb8GWwMiO7aQu8vpBJD2vuf0=;
 b=cQN9uF6Djfls0mU+14UTra1c+gg9eEuJnnSJEqwqQ3IwyAcE1Tg2RoS1bWqf8s/KO2MhD+wJmAuzamggV82uIZj5KwgjZR8+V7ir4NH6FV49jcAWUfigQhJUgBLWKhmRLXYPjKrnwXrToxYp9Bb2QlCk6F8b1pbaeJSyDoxNu2zVUG+2UGC+Mhisr/QGHz4B04CL1qStgTd8PGPuTaGdy3TQ+03hz+t0rBT6GLGqh6uegT6++OQz+METc26G4Huk7xoISZmzp7ozxPDeZItw9qZa/qOcrbWo1AHHaPcLR/FE8KTtbaMbM1KXvrP80gzPrlb1hvbmvEPGEqcr/zt5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2UpgYCJXHNk6ooSyseJb8GWwMiO7aQu8vpBJD2vuf0=;
 b=YoZnpp06DKDViWmnuxt7sVKPzN+FRwrnhmr0dJygkef4TYYXkDrpXS0hc+xP1IcmplkJSD+2RK30mwWFwa+PZhx/J96XltAl07rvDxGe1+ia30sfqbdl8YwLE++hhLX3Cwb3P92N04njHC6VWFwwVyBqEvOz0ipIa545Be472nQ=
Received: from MW4PR04CA0207.namprd04.prod.outlook.com (2603:10b6:303:86::32)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 21:51:47 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::a4) by MW4PR04CA0207.outlook.office365.com
 (2603:10b6:303:86::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 21:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 21:51:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 16:51:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/swsmu: handle VCN harvesting for VCN SMU setup
Date: Thu, 21 Oct 2021 17:51:34 -0400
Message-ID: <20211021215134.224476-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021215134.224476-1-alexander.deucher@amd.com>
References: <20211021215134.224476-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6282a16-ced8-4560-74c3-08d994dcfb32
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4415869745067A19CC43E77CF7BF9@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: um4Dc5E8ZaMag3fn398pYk5oz6tjAm7ruiiDQrcdK3KA9DVPB4U8Bj3Gbz0f01Vxgh5INQJCGcl8G1Rm8eWchFYQKWMp1GXjBqCMyF6EoMp1gytUNR5xe0+kzwbmek9kJx5BOdjTHwZRbJMhq8eNXkybpeCPgy9HIE1DGmeX1XbbCaqaQII/n7qRz6e3D9HaUPAJhL6dAjcLwukFDqufZZgTzUpi+P9N9JBl9UArYniR6fTqr1FjZjMcScHG34/Sqmf2OJwN8hk0pdN8qwldadZm+3y9/Qzb0iNB0Ue4+tuyU4nRRh8feIman61eBuQCwUdG6DmQj0rCHU/qMcum8wrarbFdiW7LluEV1uHejpkSeR26PdeRKWgQP79WBM8RwzmKj+4PSwvcvhSP9DBKC+9EedCAQkq9C/Rtbd6z0aCF5RREFZeNUm/8iqIHQEd/z8vzIMHlZ+7qh7+VxS4M/Yb5yyDwPfIWnsBBMbFFjIdHViPSiRkKWWSJurgp49KnHAxE8peh1N3r+rPzYaDx8RRbqJNdCE5GCMtMLMRlgvRwgQP32ahBoUqI3ptaS+YTEAfRAKhOskTz06T8QEBVfREgIIJz9H2Lc+SUMuKOXp4YIfYh+KxkiEY/wThOlniMHMlvOydIPvyGCTx4qeJpXAw9v8hsUKBVl8DLy/XBn7fEyHzESSF0GVk4KDAFdmQ5pMe6Z7jktSMZXy4LufAPLtbkYkiAkzpIaeyTMv2HR2c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(8676002)(6916009)(36756003)(8936002)(4326008)(426003)(508600001)(6666004)(186003)(16526019)(966005)(7696005)(356005)(336012)(2616005)(86362001)(70586007)(2906002)(36860700001)(5660300002)(83380400001)(81166007)(1076003)(47076005)(316002)(70206006)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 21:51:47.6190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6282a16-ced8-4560-74c3-08d994dcfb32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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

Check if VCN instances are harvested when controlling
VCN power gating and setting up VCN clocks.

Fixes: 1b592d00b4ac83 ("drm/amdgpu/vcn: remove manual instance setting")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1743
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 95 +++++--------------
 1 file changed, 24 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 15e66e1912de..a4108025fe29 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -670,7 +670,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
 	struct smu_11_0_dpm_table *dpm_table;
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
+	int i, ret = 0;
 	DpmDescriptor_t *table_member;
 
 	/* socclk dpm table setup */
@@ -746,78 +746,45 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		dpm_table->max = dpm_table->dpm_levels[0].value;
 	}
 
-	/* vclk0 dpm table setup */
-	dpm_table = &dpm_context->dpm_tables.vclk_table;
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-		ret = smu_v11_0_set_single_dpm_table(smu,
-						     SMU_VCLK,
-						     dpm_table);
-		if (ret)
-			return ret;
-		dpm_table->is_fine_grained =
-			!table_member[PPCLK_VCLK_0].SnapToDiscrete;
-	} else {
-		dpm_table->count = 1;
-		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
-		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
-	}
+	/* vclk0/1 dpm table setup */
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
 
-	/* vclk1 dpm table setup */
-	if (adev->vcn.num_vcn_inst > 1) {
-		dpm_table = &dpm_context->dpm_tables.vclk1_table;
+		dpm_table = &dpm_context->dpm_tables.vclk_table;
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_v11_0_set_single_dpm_table(smu,
-							     SMU_VCLK1,
+							     i ? SMU_VCLK1 : SMU_VCLK,
 							     dpm_table);
 			if (ret)
 				return ret;
 			dpm_table->is_fine_grained =
-				!table_member[PPCLK_VCLK_1].SnapToDiscrete;
+				!table_member[i ? PPCLK_VCLK_1 : PPCLK_VCLK_0].SnapToDiscrete;
 		} else {
 			dpm_table->count = 1;
-			dpm_table->dpm_levels[0].value =
-				smu->smu_table.boot_values.vclk / 100;
+			dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
 			dpm_table->dpm_levels[0].enabled = true;
 			dpm_table->min = dpm_table->dpm_levels[0].value;
 			dpm_table->max = dpm_table->dpm_levels[0].value;
 		}
 	}
 
-	/* dclk0 dpm table setup */
-	dpm_table = &dpm_context->dpm_tables.dclk_table;
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-		ret = smu_v11_0_set_single_dpm_table(smu,
-						     SMU_DCLK,
-						     dpm_table);
-		if (ret)
-			return ret;
-		dpm_table->is_fine_grained =
-			!table_member[PPCLK_DCLK_0].SnapToDiscrete;
-	} else {
-		dpm_table->count = 1;
-		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
-		dpm_table->dpm_levels[0].enabled = true;
-		dpm_table->min = dpm_table->dpm_levels[0].value;
-		dpm_table->max = dpm_table->dpm_levels[0].value;
-	}
-
-	/* dclk1 dpm table setup */
-	if (adev->vcn.num_vcn_inst > 1) {
-		dpm_table = &dpm_context->dpm_tables.dclk1_table;
+	/* dclk0/1 dpm table setup */
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+		dpm_table = &dpm_context->dpm_tables.dclk_table;
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
 			ret = smu_v11_0_set_single_dpm_table(smu,
-							     SMU_DCLK1,
+							     i ? SMU_DCLK1 : SMU_DCLK,
 							     dpm_table);
 			if (ret)
 				return ret;
 			dpm_table->is_fine_grained =
-				!table_member[PPCLK_DCLK_1].SnapToDiscrete;
+				!table_member[i ? PPCLK_DCLK_1 : PPCLK_DCLK_0].SnapToDiscrete;
 		} else {
 			dpm_table->count = 1;
-			dpm_table->dpm_levels[0].value =
-				smu->smu_table.boot_values.dclk / 100;
+			dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
 			dpm_table->dpm_levels[0].enabled = true;
 			dpm_table->min = dpm_table->dpm_levels[0].value;
 			dpm_table->max = dpm_table->dpm_levels[0].value;
@@ -902,32 +869,18 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
+	int i, ret = 0;
 
-	if (enable) {
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
 		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
+			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+							      0x10000 * i, NULL);
 			if (ret)
 				return ret;
-			if (adev->vcn.num_vcn_inst > 1) {
-				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn,
-								  0x10000, NULL);
-				if (ret)
-					return ret;
-			}
-		}
-	} else {
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
-			if (ret)
-				return ret;
-			if (adev->vcn.num_vcn_inst > 1) {
-				ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn,
-								  0x10000, NULL);
-				if (ret)
-					return ret;
-			}
 		}
 	}
 
-- 
2.31.1

