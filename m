Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586F5C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 09:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3E060ED4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 09:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D3E060ED4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F7B6F597;
	Fri, 23 Jul 2021 09:09:55 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC81A6F597
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 09:09:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbOTKGT4nOLQQtwxkxsiVCkfv8QMNI9yHEJRxi9sDRA8LHXG19Tk+9xfJLZRt5nxEazTp8yq8LIwyAsmF5RwCulzQasj6UN5M0JSwc9sA7xGtJCKy3kRLUVBj/1+fh0Sxr7gyPYpE1rgPYNT5waRLgodTuV76L6uDvo0Sjq/Osed9Fq6O63bEc/Vv44p4pFo/gCr6yuPdC9WRTC6PQUY2/+V5pFcxc/lyM+qLSbPj5hIixVF94PqGm1gV0VVSiM/JxW2VZxkbJWayrrAr8/h4VWrmcI1SwZJVR5aSADgGZHWMQhE5bgxz1NgOqtPy97lo3u/TdfS8NaHrh2Teu+e/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRY9LQYJnK5dB6I5NREmqmrKX4YH92mla0zluVH6D+E=;
 b=JxmZuQwHAbPx091dP1zEO3n0y0wcDOfofZD53E5GjiR0ER8MeebKszDJgJG7jigCcFsKvsaBQBJjOVVBw6C1gWRwR4JBc9c6qcXXVMSkB52D5+RhYjjR4SAeisxTdpyDoQ7nxhumQ2MKbjgvPxsiIZOqol7GLgi4Isr7hgNaYS8UTb8meOK8pVoIm5NvxCy380nTanwMEF/F0kq+uTW6PHFBeBRwxNNg68Q7jXgmjqHU3XWxlJN9K/yzERPCl3NRP+DrGFiBEvlrmhDhrp3Cr3QjgleesaN20oMyS1h6C3ZSadFpd75wj9gGRsk71PWo5h5vppRZITtpT/bP6Bu/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRY9LQYJnK5dB6I5NREmqmrKX4YH92mla0zluVH6D+E=;
 b=YvtZIUjA10Y0NyR1aW4FEih6n0PCkUHKJkB35U7G6YLkXldvkNrRfPkz9nlIAElyyebhsSb5Dj3dUanrezI5H0KVdDpDdYfcgn3Mbbs0/Qx9nSxr0cGL5d6SVaAaxDji3KnThngFrgGhBFHgBVKyfJtyDLOQoPO1fO9OFVeniqQ=
Received: from DM6PR17CA0036.namprd17.prod.outlook.com (2603:10b6:5:1b3::49)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Fri, 23 Jul
 2021 09:09:52 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::1e) by DM6PR17CA0036.outlook.office365.com
 (2603:10b6:5:1b3::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend
 Transport; Fri, 23 Jul 2021 09:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Fri, 23 Jul 2021 09:09:52 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 04:09:50 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/2] drm/amd/pm: restore user customized OD settings
 properly for NV1x
Date: Fri, 23 Jul 2021 17:09:32 +0800
Message-ID: <20210723090933.806633-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c9bf543-e259-4b6f-ddab-08d94db9a1c0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4222:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42229F031F62F86D9BD5CD43E4E59@MN2PR12MB4222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCphNwIWauQL3DNIPgFyrJUfKce4aBs1RlL1JlzLSwGO8/wKMhVMBc9/+NjwBSxHYRKXOXWJxWxVr1Pfa04naohbIBeMygpmFJDa/25VOQQ/58tKBWuNU8ki14FahfM73J820evLtXhi0uf1Ry2dYtGTbMfenDt+hMuAZlORAEXGyLFau/berT5azWKBnqD+1QpGZH27yVMz0Fo1wzI/vInB/mYW+ULkuzEIdILANrad20K2csNpK6g1deKEQkdAeuNBaY9Aj28r/P0xE66ah/XUOb1f9uwDgkdqMoHIgTTAvPmv/b2fflLjyOjMCli/xtKfVH+TPXsffEgyOEOB4I8QiaTnjXxPlLjCAWD72V6Xt9dCwWHHXYsxu1S+1QbYf8SXxCe2pX55LaksGbaljnvhsecj4NaoFxDl0Z00k/6UsANgE+AIP/EhX/f/7KqiMf9DOcqkvRJfcVJVNW4eCnWbpJ9u5HAbMeBoqyvCQJ80TJODpxpFpqkrLIctgBeTNCRe595evZaILKxQZLRxNFhP3uoaYfewK8fWsRipXqOdIBWuCSkEdJqIWJPzMV+ga9BaccgBxljn19V7dUUv/2lSZ8reiVBUOe/4PE7Bh9+7fEBN6lPZgo2Glcx08Xo8Bu8Sg3B5s+73hJ4nu3BtiV2E36gDs3vB9meqtaYCme3Mw1rHPqpWXzvP3Y8EGNVQnXOvzSRP0pI+2C+HFNZNze+73rpcQZ2XXBORH2jd9PlldgD7x6PuQx3CQScA6OpDmAWQlTz7EHB4ImfXk2aSCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(1076003)(36756003)(66574015)(7696005)(44832011)(2616005)(70206006)(4326008)(82310400003)(186003)(16526019)(426003)(81166007)(478600001)(54906003)(8936002)(2906002)(26005)(8676002)(316002)(47076005)(6916009)(6666004)(70586007)(336012)(83380400001)(5660300002)(82740400003)(36860700001)(356005)(86362001)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 09:09:52.6726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9bf543-e259-4b6f-ddab-08d94db9a1c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
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
--
v1->v2
  - better naming and logic revised for checking OD setting update(Lijo)
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  8 +++
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 +++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 55 +++++++++++++------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 25 +++++++++
 5 files changed, 82 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 3e89852e4820..c2c201b8e3cf 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -231,6 +231,7 @@ struct smu_user_dpm_profile {
 	uint32_t power_limit;
 	uint32_t fan_speed_percent;
 	uint32_t flags;
+	uint32_t user_od;
 
 	/* user clock state information */
 	uint32_t clk_mask[SMU_CLK_COUNT];
@@ -352,6 +353,7 @@ struct smu_table_context
 
 	void				*overdrive_table;
 	void                            *boot_overdrive_table;
+	void				*user_overdrive_table;
 
 	uint32_t			gpu_metrics_table_size;
 	void				*gpu_metrics_table;
@@ -623,6 +625,12 @@ struct pptable_funcs {
 				 enum PP_OD_DPM_TABLE_COMMAND type,
 				 long *input, uint32_t size);
 
+	/**
+	 * @restore_user_od_settings: Restore the user customized
+	 *                            OD settings on S3/S4/Runpm resume.
+	 */
+	int (*restore_user_od_settings)(struct smu_context *smu);
+
 	/**
 	 * @get_clock_by_type_with_latency: Get the speed and latency of a clock
 	 *                                  domain.
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 385b2ea5379c..1e42aafbb9fd 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -302,5 +302,7 @@ void smu_v11_0_interrupt_work(struct smu_context *smu);
 
 int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
 
+int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ebe672142808..8ca7337ea5fc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -416,6 +416,15 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 		}
 	}
 
+	/* Restore user customized OD settings */
+	if (smu->user_dpm_profile.user_od) {
+		if (smu->ppt_funcs->restore_user_od_settings) {
+			ret = smu->ppt_funcs->restore_user_od_settings(smu);
+			if (ret)
+				dev_err(smu->adev->dev, "Failed to upload customized OD settings\n");
+		}
+	}
+
 	/* Disable restore flag */
 	smu->user_dpm_profile.flags &= ~SMU_DPM_USER_PROFILE_RESTORE;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 59ea59acfb00..d7722c229ddd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2294,41 +2294,52 @@ static int navi10_set_default_od_settings(struct smu_context *smu)
 		(OverDriveTable_t *)smu->smu_table.overdrive_table;
 	OverDriveTable_t *boot_od_table =
 		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
+	OverDriveTable_t *user_od_table =
+		(OverDriveTable_t *)smu->smu_table.user_overdrive_table;
 	int ret = 0;
 
-	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, false);
+	/*
+	 * For S3/S4/Runpm resume, no need to setup those overdrive tables again as
+	 *   - either they already have the default OD settings got during cold bootup
+	 *   - or they have some user customized OD settings which cannot be overwritten
+	 */
+	if (smu->adev->in_suspend)
+		return 0;
+
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
+	memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
+	memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
 
 	return 0;
 }
@@ -2429,11 +2440,20 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
 		memcpy(table_context->overdrive_table, table_context->boot_overdrive_table, sizeof(OverDriveTable_t));
 		break;
 	case PP_OD_COMMIT_DPM_TABLE:
-		navi10_dump_od_table(smu, od_table);
-		ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
-		if (ret) {
-			dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
-			return ret;
+		if (memcmp(od_table, table_context->user_overdrive_table, sizeof(OverDriveTable_t))) {
+			navi10_dump_od_table(smu, od_table);
+			ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, true);
+			if (ret) {
+				dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
+				return ret;
+			}
+			memcpy(table_context->user_overdrive_table, od_table, sizeof(OverDriveTable_t));
+			smu->user_dpm_profile.user_od = true;
+
+			if (!memcmp(table_context->user_overdrive_table,
+				    table_context->boot_overdrive_table,
+				    sizeof(OverDriveTable_t)))
+				smu->user_dpm_profile.user_od = false;
 		}
 		break;
 	case PP_OD_EDIT_VDDC_CURVE:
@@ -3262,6 +3282,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.set_default_od_settings = navi10_set_default_od_settings,
 	.od_edit_dpm_table = navi10_od_edit_dpm_table,
+	.restore_user_od_settings = smu_v11_0_restore_user_od_settings,
 	.run_btc = navi10_run_btc,
 	.set_power_source = smu_v11_0_set_power_source,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 0a5d46ac9ccd..7aa47dbba8d8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -422,10 +422,20 @@ int smu_v11_0_init_smc_tables(struct smu_context *smu)
 			ret = -ENOMEM;
 			goto err3_out;
 		}
+
+		smu_table->user_overdrive_table =
+			kzalloc(tables[SMU_TABLE_OVERDRIVE].size, GFP_KERNEL);
+		if (!smu_table->user_overdrive_table) {
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
+	kfree(smu_table->user_overdrive_table);
 	kfree(smu_table->boot_overdrive_table);
 	kfree(smu_table->overdrive_table);
 	kfree(smu_table->max_sustainable_clocks);
 	kfree(smu_table->driver_pptable);
 	kfree(smu_table->clocks_table);
 	smu_table->gpu_metrics_table = NULL;
+	smu_table->user_overdrive_table = NULL;
 	smu_table->boot_overdrive_table = NULL;
 	smu_table->overdrive_table = NULL;
 	smu_table->max_sustainable_clocks = NULL;
@@ -2101,3 +2113,16 @@ int smu_v11_0_deep_sleep_control(struct smu_context *smu,
 
 	return ret;
 }
+
+int smu_v11_0_restore_user_od_settings(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	void *user_od_table = table_context->user_overdrive_table;
+	int ret = 0;
+
+	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)user_od_table, true);
+	if (ret)
+		dev_err(smu->adev->dev, "Failed to import overdrive table!\n");
+
+	return ret;
+}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
