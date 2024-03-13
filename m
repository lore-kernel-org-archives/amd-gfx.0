Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA72C54E68
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 11:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017F510F354;
	Wed, 13 Mar 2024 11:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BHfBxw1o";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389D110F354
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 11:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBFYMw6Fc6LGq7/QMuesAQ71LJWuS5NGTAjSW7lkb8o8S2o+os3HhRDAXvkIVDJ60yLXTKWKSrFZjXMGdLoU9w7eCYkEO13bF61cd6LGVvTtqETRLNDfBjSGuvl7lX1e8ltzBZsoitmSUQS5qxHVuFjhzHS/QPhg461aV6XXC7KMzs+8NBRK6PuqeUMEAYRzkcBMtDQuS5yBtdZ9oioRJWFatA/RAttItq2CgjofzNJqTfxsxYqmDZ/LFqvLxJ1X8urjRno4PsuSKzLukue2qkwO7TFKAMAH8TpG4sOsrcEkr2wNNFkFdqocB+o+Q8cHWlGUUx7ghg5SDJP52gju1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGk8RJ1fm5sI6yLFxqmX8wc7TLhH3nlfKZnr5IRoUNc=;
 b=ogZIdkmF8Y/IoVneevcQp3KC/4lso0fWQPbAO14ZF+vaUlN3lRqiloKs0XkFtXTL56baypF1bMziyogBRFIq4zEF1ntTl0ROYuAYVxyC0hPmmM5jNY4Xmze3hcMIMMUeqePqW6JXGvTsYqPu9TRW7KLeZJRS9nK3+GtukMKuKPQ4K+2X1hfxGSeDWtQfrpEYUxsCXTe04QWWT181lwXT+GiamO9D2ixCQ459I9Duxglze0BJFao8cM/ENkLUDhgvFHOQYD1FopCXQ3tF/RGjIKS5P55nXeIt0Q07uB1DcQ29J5jUvTldD9Mem8LL/6Um28U7jLO02cjdVZ4+lAFqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGk8RJ1fm5sI6yLFxqmX8wc7TLhH3nlfKZnr5IRoUNc=;
 b=BHfBxw1oC+JOwy4HQlUk/yHcV82kxe26nKOvnUfZZFp8qf53qnjVk95XNoUsYqa8oAHmWSBehYVIfVXX5Hd+untbpbAESBay1EaHXMXZ/0QpR2+rzhQ56aGCthV1okBUEc6OB/0yoQl/kexqF8etk1VurnoGW4jHKdmFugsd5t4=
Received: from MN2PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:160::38)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 11:03:26 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::be) by MN2PR13CA0025.outlook.office365.com
 (2603:10b6:208:160::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 11:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 11:03:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 06:03:23 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH 3/9] drm/amd/pm: Add support to select pstate policy
Date: Wed, 13 Mar 2024 16:32:50 +0530
Message-ID: <20240313110256.669474-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313110256.669474-1-lijo.lazar@amd.com>
References: <20240313110256.669474-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: c6457967-118a-4e54-8c95-08dc434d34c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQy1ZpZnro+9d28zz22Vsfw9O3hkruEgDMewWVyPV02gxpcWhDIAPXJ4mGcY7jK//+eAZllxUMOEZMNG2cVN8TtzqUdlJj+98jhGiqLXp/iy1LcQG9Ep5o8sHctqNfjmD70aBaUZf+hQA285WD83Tgh9OA+gO78gI9oxBAWTZsu2q8kOzHGq9uy8Z9z9TpTSQj9D6zwH3AT0zwN3ozu+ZjsFnd04uJP/MifbDdmQjrW6NesFIlg4epAV9TN/ZfM4jC0hhSVu6jNNnZTyi5PTb+RZUmBMo6Oaj/1Trg+N51G1bztilrCxskT3MLSofXCaUBzqUIAyz6NjKPJCP6kDADcTXIEcImCXdJSCH2HlND0mJYy6gSuwd9s+N+0yB+hfD6aVkxd5Bv3bePhhAl0FwZ5IaaPHBd5GgylsC7dl23a27vbdp5o/+BiV0PjSBOqvWizvD9OyjnbTuWEYAGEvhXFrFapHgffZXxq/OAyz8T1yyH1UwqmYWdI9XtlIX+G9pT6YzD5qpSi1tDAU4uwa5feG6BdoaTO5DIdo7J+WAZkEm+rVKQN2SHZK0IyNC9po4yzWb3TGv8Bj6Pi7CaEghb5nYHmuuEA14stOWzVhScO4KV2dSamFM4dw9deQJICSCRqeKdoIWE0OwGezNmD9M7brvobf48BXIz+diIyzlr4QaDdyFwkF4RtsNNOig0wV2LMrjrqXRgXdsL1f/LOL+rKuWw6uVlEZ10maY0diPjdX0ER35r9NYGpvg2JQUzea
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:03:25.6400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6457967-118a-4e54-8c95-08dc434d34c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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

Add support to select pstate policy in SOCs with SMUv13.0.6

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 71 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 30 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  1 +
 4 files changed, 104 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 48170bb5112e..8a86c74f28e7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -530,10 +530,12 @@ int smu_v13_0_fini_smc_tables(struct smu_context *smu)
 	smu_table->watermarks_table = NULL;
 	smu_table->metrics_time = 0;
 
+	kfree(smu_dpm->dpm_policies);
 	kfree(smu_dpm->dpm_context);
 	kfree(smu_dpm->golden_dpm_context);
 	kfree(smu_dpm->dpm_current_power_state);
 	kfree(smu_dpm->dpm_request_power_state);
+	smu_dpm->dpm_policies = NULL;
 	smu_dpm->dpm_context = NULL;
 	smu_dpm->golden_dpm_context = NULL;
 	smu_dpm->dpm_context_size = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 744c84f3029f..f227f05100f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -173,6 +173,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 0),
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
 	MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBadPageThreshold,        0),
+	MSG_MAP(SelectPstatePolicy,                  PPSMC_MSG_SelectPstatePolicy,              0),
 };
 
 // clang-format on
@@ -368,6 +369,39 @@ static int smu_v13_0_6_tables_init(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v13_0_6_select_policy_soc_pstate(struct smu_context *smu,
+						int policy)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret, param;
+
+	switch (policy) {
+	case SOC_PSTATE_DEFAULT:
+		param = 0;
+		break;
+	case SOC_PSTATE_0:
+		param = 1;
+		break;
+	case SOC_PSTATE_1:
+		param = 2;
+		break;
+	case SOC_PSTATE_2:
+		param = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SelectPstatePolicy,
+					      param, NULL);
+
+	if (ret)
+		dev_err(adev->dev, "select soc pstate policy %d failed",
+			policy);
+
+	return ret;
+}
+
 static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
@@ -378,6 +412,24 @@ static int smu_v13_0_6_allocate_dpm_context(struct smu_context *smu)
 		return -ENOMEM;
 	smu_dpm->dpm_context_size = sizeof(struct smu_13_0_dpm_context);
 
+	if (!(smu->adev->flags & AMD_IS_APU)) {
+		struct smu_dpm_policy *policy;
+
+		smu_dpm->dpm_policies =
+			kzalloc(sizeof(struct smu_dpm_policy_ctxt), GFP_KERNEL);
+		policy = &(smu_dpm->dpm_policies->policies[0]);
+
+		policy->policy_type = PP_PM_POLICY_SOC_PSTATE;
+		policy->level_mask = BIT(SOC_PSTATE_DEFAULT) |
+				     BIT(SOC_PSTATE_0) | BIT(SOC_PSTATE_1) |
+				     BIT(SOC_PSTATE_2);
+		policy->current_level = SOC_PSTATE_DEFAULT;
+		policy->set_policy = smu_v13_0_6_select_policy_soc_pstate;
+		smu_cmn_generic_soc_policy_desc(policy);
+		smu_dpm->dpm_policies->policy_mask |=
+			BIT(PP_PM_POLICY_SOC_PSTATE);
+	}
+
 	return 0;
 }
 
@@ -636,6 +688,15 @@ static int smu_v13_0_6_get_dpm_level_count(struct smu_context *smu,
 	return ret;
 }
 
+static void smu_v13_0_6_pm_policy_init(struct smu_context *smu)
+{
+	struct smu_dpm_policy *policy;
+
+	policy = smu_get_pm_policy(smu, PP_PM_POLICY_SOC_PSTATE);
+	if (policy)
+		policy->current_level = SOC_PSTATE_DEFAULT;
+}
+
 static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
@@ -665,6 +726,16 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 
 	smu_v13_0_6_setup_driver_pptable(smu);
 
+	/* DPM policy not supported in older firmwares */
+	if (!(smu->adev->flags & AMD_IS_APU) &&
+	    (smu->smc_fw_version < 0x00556000)) {
+		struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
+
+		smu_dpm->dpm_policies->policy_mask &=
+			~BIT(PP_PM_POLICY_SOC_PSTATE);
+	}
+
+	smu_v13_0_6_pm_policy_init(smu);
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index b8dbd4e25348..ce14d94b9650 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1079,3 +1079,33 @@ bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
 
 	return snd_driver_loaded;
 }
+
+static char *smu_soc_policy_get_desc(struct smu_dpm_policy *policy, int level)
+{
+	if (level < 0 || !(policy->level_mask & BIT(level)))
+		return "Invalid";
+
+	switch (level) {
+	case SOC_PSTATE_DEFAULT:
+		return "soc_pstate_default";
+	case SOC_PSTATE_0:
+		return "soc_pstate_0";
+	case SOC_PSTATE_1:
+		return "soc_pstate_1";
+	case SOC_PSTATE_2:
+		return "soc_pstate_2";
+	}
+
+	return "Invalid";
+}
+
+static struct smu_dpm_policy_desc pstate_policy_desc = {
+	.name = "soc pstate",
+	.get_desc = smu_soc_policy_get_desc,
+};
+
+void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy)
+{
+	policy->desc = &pstate_policy_desc;
+}
+
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 81bfce1406e5..d135d984329e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -144,6 +144,7 @@ static inline void smu_cmn_get_sysfs_buf(char **buf, int *offset)
 }
 
 bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
+void smu_cmn_generic_soc_policy_desc(struct smu_dpm_policy *policy);
 
 #endif
 #endif
-- 
2.25.1

