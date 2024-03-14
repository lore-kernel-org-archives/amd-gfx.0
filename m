Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13589C54E69
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 11:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF7310FABD;
	Thu, 14 Mar 2024 11:57:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YDRjBYYE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1377C10FAB7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 11:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgcR+IIJdpxmQ5LuQVWE0/XwmmMY8Ujb/BymbWvndP+NuqJ2HmlruH6+BIS3gbdgOjzG1U02Ei1VMsttlRh0TpzgKFGvHaaXfD+w3+hulAllMKgTRyJ+0L6QAWAaZ5JBreOQa+8VIu4OHhqX9StQHm90cBrRq6+hg+5l8ixxCk1kCQ8QYFBMpOmKePDn+wLSjWh3nZLyQvE0fNB2P87uY8Skw5sdvOEwImyD4dQENAFM+/ab4qF4G/B5f4nqcVGKiBu7/VlcTICrcjfiyDRQ79z/31bpcKuoPE4Hokg8XjSRoqRgc7/YIsxmWyPF48uD/5OaaJzgt7fW9FOOHnpypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGk8RJ1fm5sI6yLFxqmX8wc7TLhH3nlfKZnr5IRoUNc=;
 b=cO9EYtRK4WFqgMG10jqOkr9HMUbZl9I8iqAj9Qw4intVjwaC6Uc6X03uFY4mwaQ0bOVRFdf2zWBigqc+R1x8dnSpT2V7j/T4nrXOAV2o8/9xFHb4wqJ2Wu0fS9zViUlK+VymZqBk0L7udY8hmJdqvYwcRDsA2YbzdkJ75UlofI12cBNLYZ0T7gtRKHqZidVf3/AP8toSrMqjcb8H1F3O9d3hWnaS7zhyZ8yKg2SKoN7D4jvUuqhee0OmQR0Mq2OlRICiu9SCDNGIBZ6DSFDOUkDZu1xfm+ARaXgZySz35ImVIpXvfy5NwoCkXkHBgHd1tR6yfyovs6ZzA+M6yJnYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGk8RJ1fm5sI6yLFxqmX8wc7TLhH3nlfKZnr5IRoUNc=;
 b=YDRjBYYESVEtNKXeUSdz5K3aRD3pZGxFkGVl2tn9oStZ3iFAGKmmRH760RwrnFMbbKsftFuJSZ0i1axthKKFivoWp4jOjovzyWyZ1hAFIMnn5cLcFOiewBAqvVwU6uv4/2Y52SXysb805fdi128rG4eqqyk/NNQJNGQbnT/X0tU=
Received: from CH2PR05CA0071.namprd05.prod.outlook.com (2603:10b6:610:38::48)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 11:57:21 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::4f) by CH2PR05CA0071.outlook.office365.com
 (2603:10b6:610:38::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24 via Frontend
 Transport; Thu, 14 Mar 2024 11:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 11:57:21 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 06:57:19 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH v2 3/9] drm/amd/pm: Add support to select pstate policy
Date: Thu, 14 Mar 2024 17:26:24 +0530
Message-ID: <20240314115630.682937-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314115630.682937-1-lijo.lazar@amd.com>
References: <20240314115630.682937-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: e1073279-c7c5-4574-1f87-08dc441de812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mc8CJ5dMGGgpKkm5eWRumhDF55l+8VRYW273wSAQyr3vXqjSH5kwbJL0H84bVfXO96HklVWafxVJHJFfhSZQc+RtjTG0IVNI+IL+mHkFGhTqFLPheA2QQYbWW+Lzo+lDccuoqlabpZN6Mh+hBIUGVSQ04F8odJ3Hxm7lgAqseiH99kScTKptVX1G+irpGTZ2edMzCx/Dh2kWsXhff7TPaX+wsA/7Lyt7TrLBpvQ5fDNeaoBL6UnP/iEekXIYL2WmqXrwhZXMkgBx8B43QKoYKmGC9xS36uTypnwFgc++PSrraWUNofrmNQOY26nwanlGvkNwylorHCDViGpBPrRXNQeQCL1wm8nw5Gu+8E/MZ7FWkazsSgEx1Oc2edJPaH8doTKb5lHxOwqfgYXA8oBAHRxBFmsJm/V1nQsbuhYTXhnNoqhtGtFPZjWNOWOiPl7SspPJgFySKIISHXFrcDf0ZWZECsW3T1IChOztoSeEFihcvpdal7KqReaXsltF4xPTxj2F6mV/fMTU+Xzyl/YbSengLpeY0unBpLJw33IyQbMF2KytI/KIr/3+B/9PjhCvgMfRsttfeyk3Re/KypsEVid220KQUMjDRos0c4IoGg+eimRZkIEYMm8HRB3PK8vS0+NyW0/XRu12Yr4macGJ80qQcSahE5onUBhJXoJmY81GqekgKfk6249oKB9zCbx9AQTzNavDUT1a/vqUsGgnVRPu3HDNEJFa+Q00XJQXxXeNmwPtox+Sn68ty/13TCbz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 11:57:21.7542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1073279-c7c5-4574-1f87-08dc441de812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461
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

