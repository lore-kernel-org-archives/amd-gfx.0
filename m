Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B93C07E9D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 03:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF43961279
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 03:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF43961279
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 312696E9FA;
	Thu, 22 Jul 2021 03:21:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 228C96E9FA
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 03:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWjzc3N7k0lO8TBXi7jbEyezX1ixE58vccmCrs/be/H5RTG5MK6c2IZmxY/dTJR7H7Jf2jW+M5SIG/Ex9/IHOh3DT6JZpd26pg9JGbLbMN/CYgVXXNYoKkzDTsFfaaT6FyqN3SF3bBxfGEgOetYnPfOa2BoLUBXb6SRMf29EWhghyXfR6VZ+jFoSYOOw4uXFvoIcjJ8XbnOhg8AWY9qMqvTZQjnYlOWBE/+ijHwpQoF5ksPfhNjO+ttLnC9TVqkLDpn/EiHmcyLBCwUuBQsyXHyW3ReczoRhpUqcFv5ZzmkD6sCrR7Tp30+eH1S26GefJKsqu5akm+fGxTvHKOMbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYMIQ4jNhOJq6PaeBpkUywdW0MoGEKDCrzij7G4PxDw=;
 b=NQRl/orn48n+zTqBO6wpOKxXfcqLyeCPl5yml+OFs887RiRF4XjOEKy+DillUTE+ihNEaUTfXhfTeXjcFCl0VPFYLSvxAcfJjFJ3p4liEmEJpbgH3eNNQf0+XUx77hCi9AWJNxtu7cqy4Df22IrBZJKk0F20gtm9T/KaGhRo46V3loldsWiItZzAqHOTYLPHHu3L0DKOgeemEZKeeJThH2crvBYr/KVx2TT7RkHzQ6sb3MrWEWfF4eIBkY1ipuCZ6QwaX/GqbfDocHVy7nI4kUZMOADjw0SWnELxYLV3HH9sf+zvWTFy2g43Bk/XONMuR2yC1gBn6BKLeHekPyII5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYMIQ4jNhOJq6PaeBpkUywdW0MoGEKDCrzij7G4PxDw=;
 b=aq3J6ZUU78jMMnsbSIJymyZf+7M6bY80K5LO5LxpqSBBJz+gLZ5zjvqmURASkc1Rg0g7+JqQsC0KX0KdtD4asbn3YXylZG6nXPU7ucLVLZAp3hgFbHn1GqDlwrzrJAptRnJUXT/w1/C/WLC21o+HWsa97cjXVZ25fCItbVSTNo8=
Received: from BN6PR16CA0045.namprd16.prod.outlook.com (2603:10b6:405:14::31)
 by BN8PR12MB3297.namprd12.prod.outlook.com (2603:10b6:408:9f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Thu, 22 Jul
 2021 03:21:10 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::98) by BN6PR16CA0045.outlook.office365.com
 (2603:10b6:405:14::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Thu, 22 Jul 2021 03:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 03:21:10 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Jul
 2021 22:21:09 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: restore user customized OD settings properly
 for NV1x
Date: Thu, 22 Jul 2021 11:20:45 +0800
Message-ID: <20210722032046.767094-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92213775-fdc3-4deb-b31a-08d94cbfc0cf
X-MS-TrafficTypeDiagnostic: BN8PR12MB3297:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3297EAAD0FC2E2DCF1472FE2E4E49@BN8PR12MB3297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86oYVkRkFKPPCZLdPFHS/I0vZsdA5vsIrse/2ZN9AsiOojYO0U9DTF+qfpZDsPw0cuWdFB4yGC7AchVsRHgn+byT2bcVAp6wrKpoWGdSV9Wdd+UiIxpmOb4Azu3aDeJvgrPcyzvmGyEoXSgZNaBplaxbnL6uyqDyzyrffs5ZZ+ei4FUmp/Igd/5um6W/3Zt4auOMJxTerzJxoGexDJfZ+uW3OIO7YPDm2PncJqpU0UCLjSmhkSM0qbvXrO0XALWjBr6vkWtguIP3Z1DO/womhanfY13mirwQvp0Wqyv6qDYUok8WUvyd4qeLCKuf9ofgGqnV0bg0M78NYnhJHpK7MJt47vHNuMHNdsTf9TMsWV3fSTIqX0Pd+yrQ5huG8zFrqnnVVhReYCWGKowN7BFRGTbYGs0mf4VYA4AMpQ+A9W9mwda2+W1R7LfgCJoJF05QxY6SrHdC6KTidlLYOKegUwi2D/NOW5XfSheUjKzHTjplAjYYgjNwrHdyIXSQ1mCuSDEntZMlfrydqbCvqHpPONGTbnwLdHK18WATjG+yHTdFchI6Zp9qZ3U1PMfJEr6WWZ+FFhKERTjlpHFgQwHBxtfumvWOkNN/j6dkTNb6yoTHsumASbH3cK6vGCDJLl6w0Z0OOdMI34QyBF2wkXyIdmB1PGcsqhyTMMPcuv7HcXxza4K5WdLEaiSifW0di7j03pvGTcAJUHUidJmdUlVXaaJgabGcsF0XSkK/2hE4qe1shJFfiHX1g+7k8RCNplS7tkBibS5DL3IMIpltjcnd3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(70586007)(82310400003)(44832011)(81166007)(1076003)(82740400003)(8936002)(426003)(86362001)(70206006)(6916009)(47076005)(316002)(7696005)(16526019)(83380400001)(5660300002)(66574015)(6666004)(478600001)(336012)(2616005)(356005)(186003)(8676002)(4326008)(26005)(36860700001)(54906003)(36756003)(2906002)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 03:21:10.6397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92213775-fdc3-4deb-b31a-08d94cbfc0cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3297
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The customized OD settings can be divided into two parts: those
committed ones and non-committed ones.
  - For those changes which had been fed to SMU before S3/S4/Runpm
    suspend kicked, they are committed changes. They should be properly
    restored and fed to SMU on S3/S4/Runpm resume.
  - For those non-committed changes, they are restored only without feeding
    to SMU.

Change-Id: Iea7cf7908dfcd919a4d0205e10bff91b1149a440
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 52 ++++++++++++++-----
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 12 +++++
 4 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 3e89852e4820..8ba53f16d2d9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
 	uint32_t power_limit;
 	uint32_t fan_speed_percent;
 	uint32_t flags;
+	uint32_t committed_od;
 
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
@@ -352,6 +353,7 @@ struct smu_table_context
 
 	void				*overdrive_table;
 	void                            *boot_overdrive_table;
+	void				*committed_overdrive_table;
 
 	uint32_t			gpu_metrics_table_size;
 	void				*gpu_metrics_table;
@@ -623,6 +625,12 @@ struct pptable_funcs {
 				 enum PP_OD_DPM_TABLE_COMMAND type,
 				 long *input, uint32_t size);
 
+	/**
+	 * @restore_committed_od_settings: Restore the customized and committed
+	 *                                 OD settings on S3/S4/Runpm resume.
+	 */
+	int (*restore_committed_od_settings)(struct smu_context *smu);
+
 	/**
 	 * @get_clock_by_type_with_latency: Get the speed and latency of a clock
 	 *                                  domain.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ebe672142808..5f7d98e99f76 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 		}
 	}
 
+	/* Restore customized and committed OD settings */
+	if (smu->user_dpm_profile.committed_od) {
+		if (smu->ppt_funcs->restore_committed_od_settings) {
+			ret = smu->ppt_funcs->restore_committed_od_settings(smu);
+			if (ret)
+				dev_err(smu->adev->dev, "Failed to upload customized OD settings\n");
+		}
+	}
+
 	/* Disable restore flag */
 	smu->user_dpm_profile.flags &= ~SMU_DPM_USER_PROFILE_RESTORE;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 59ea59acfb00..4752299d7f91 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2296,39 +2296,45 @@ static int navi10_set_default_od_settings(struct smu_context *smu)
 		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
 	int ret = 0;
 
-	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, false);
+	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)boot_od_table, false);
 	if (ret) {
 		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
 		return ret;
 	}
 
-	if (!od_table->GfxclkVolt1) {
+	if (!boot_od_table->GfxclkVolt1) {
 		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
-								&od_table->GfxclkVolt1,
-								od_table->GfxclkFreq1);
+								&boot_od_table->GfxclkVolt1,
+								boot_od_table->GfxclkFreq1);
 		if (ret)
 			return ret;
 	}
 
-	if (!od_table->GfxclkVolt2) {
+	if (!boot_od_table->GfxclkVolt2) {
 		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
-								&od_table->GfxclkVolt2,
-								od_table->GfxclkFreq2);
+								&boot_od_table->GfxclkVolt2,
+								boot_od_table->GfxclkFreq2);
 		if (ret)
 			return ret;
 	}
 
-	if (!od_table->GfxclkVolt3) {
+	if (!boot_od_table->GfxclkVolt3) {
 		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
-								&od_table->GfxclkVolt3,
-								od_table->GfxclkFreq3);
+								&boot_od_table->GfxclkVolt3,
+								boot_od_table->GfxclkFreq3);
 		if (ret)
 			return ret;
 	}
 
-	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
+	navi10_dump_od_table(smu, boot_od_table);
 
-	navi10_dump_od_table(smu, od_table);
+	/*
+	 * For S3/S4/Runpm, no need to install boot od table to overdrive_table as
+	 *   - either they already share the same OD settings on bootup
+	 *   - or they have user customized OD settings
+	 */
+	if (!smu->adev->in_suspend)
+		memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
 
 	return 0;
 }
@@ -2435,6 +2441,14 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 			dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
 			return ret;
 		}
+		if (memcmp(table_context->overdrive_table, table_context->boot_overdrive_table,
+			sizeof(OverDriveTable_t))) {
+			smu->user_dpm_profile.committed_od = true;
+			memcpy(table_context->committed_overdrive_table, table_context->overdrive_table,
+					sizeof(OverDriveTable_t));
+		} else {
+			smu->user_dpm_profile.committed_od = false;
+		}
 		break;
 	case PP_OD_EDIT_VDDC_CURVE:
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
@@ -2499,6 +2513,19 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 	return ret;
 }
 
+static int navi10_restore_committed_od_settings(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	void *od_table = table_context->committed_overdrive_table;
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
+
+	return ret;
+}
+
 static int navi10_run_btc(struct smu_context *smu)
 {
 	int ret = 0;
@@ -3262,6 +3289,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_default_od_settings = navi10_set_default_od_settings,
 	.od_edit_dpm_table = navi10_od_edit_dpm_table,
+	.restore_committed_od_settings = navi10_restore_committed_od_settings,
 	.run_btc = navi10_run_btc,
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 0a5d46ac9ccd..28fc3f17c1b1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct smu_context *smu)
 			ret = -ENOMEM;
 			goto err3_out;
 		}
+
+		smu_table->committed_overdrive_table =
+			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
+		if (!smu_table->committed_overdrive_table) {
+			ret = -ENOMEM;
+			goto err4_out;
+		}
+
 	}
 
 	return 0;
 
+err4_out:
+	kfree(smu_table->boot_overdrive_table);
 err3_out:
 	kfree(smu_table->overdrive_table);
 err2_out:
@@ -442,12 +452,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
 	kfree(smu_table->gpu_metrics_table);
+	kfree(smu_table->committed_overdrive_table);
 	kfree(smu_table->boot_overdrive_table);
 	kfree(smu_table->overdrive_table);
 	kfree(smu_table->max_sustainable_clocks);
 	kfree(smu_table->driver_pptable);
 	kfree(smu_table->clocks_table);
 	smu_table->gpu_metrics_table = NULL;
+	smu_table->committed_overdrive_table = NULL;
 	smu_table->boot_overdrive_table = NULL;
 	smu_table->overdrive_table = NULL;
 	smu_table->max_sustainable_clocks = NULL;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
