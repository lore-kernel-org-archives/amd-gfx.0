Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BDAC55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 03:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5486E10F138;
	Fri, 31 Jul 2026 03:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UkeiZeTu";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 999FA10F124
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 03:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuaYMrkdqhtoF1oUDM8ePPiaRSVddjF3+Fr0IQgL5TMoP7MIz/ZiJeOO0FiganwVHYcpGVjspltfi4zszxSx53H4pORxb3QLGT7WYEOf32cMiqP/l4VDb7fKDNDlDZG/n7aKlZBUxGoBU4IL1Yjw0lNYmWRv5wOnL/PBcViEIctZaWiC4T3jiTwGB9NiZaTAKKTRLWXIgT5iHQ0S3UnIBrRVdBcvVlxlVUtQqneAaYeeog9gq8RvOynELkk7tpzRef8NtC5Oe86mZfxg9KhrNJq5XggsJnmth7dLyA0kJzCDjwVWY20QGOMb8Umyz8SF+aNmuOx5jMxR8vVOvl1QNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIAuO3ICh4GHEW2YtfAnlMgdYo3eaC2W3HHqiOKGXVk=;
 b=GuzDsF3wgqSr2L+sbLhrNoh9SUueDm60Vespet0nXnzhPziadu309HcOK75AhzaI19gVPgnQRxU8mc299Sgho8V+iEijVL8Am9fjt7I6BnLwIsdCe0x/EVIfhV65QKikIvhpFYILLZblJ8vCG4iBgUBvIZS3fCKCVbGB1l4ptblz57W802ttx9Mfqo0XWUuSjgoiBmJf5xzsTSCgl8IJw/wt9hNrUW+Yrhx6wznbCv0vyagcP/sfA6w3jisTjnPVH30MRH7FDLjty7NrWHTPdP2fVk+AA8ZWc8LThd6r2veAPSl+p+Tnfg1FN7xvTJQP009pdE186yxN1QzpkaaNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIAuO3ICh4GHEW2YtfAnlMgdYo3eaC2W3HHqiOKGXVk=;
 b=UkeiZeTuwZ+tsASDM8SUXhJrw3o3Mxp4az4n33jSa2rdwLrz5lxzLSOhiadzZGdANCpZ8O631PZxkmcz13mc3+jJOivYkicr+gUlLahjQJ2r4ah0TlzpAYBgglj62c78+LQRPVrBFJV6kd1zp29aJCzYGFgDih5bHgCVZGbQtfE=
Received: from SJ0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:a03:39c::26)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 03:10:41 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::26) by SJ0PR03CA0351.outlook.office365.com
 (2603:10b6:a03:39c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 03:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 03:10:40 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 22:10:38 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: refactor user PPT policy save and restore
Date: Fri, 31 Jul 2026 11:10:21 +0800
Message-ID: <2a1bf8c187a6b6a67169fda0e6551a062af56c77.1785467079.git.kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785467079.git.kevinyang.wang@amd.com>
References: <cover.1785467079.git.kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d6a64e-9a30-45ec-b06b-08deeeb14d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pFz8MqXa7aQGU/Ary+IlN2kNPu+CcFudepytwHsqFCze+kd69JDdbIzNLgFFZaTixWl3K/uyfsYNWwPPOHVJd4QG/KROEFaXSMTQPHn6MtJMvgPCyXuYmfkjpUvLfuEex4njQvWj2xpAy30zG0REOCLBSCctJyovdj1BiBTgRsVzbnris9cbRtfmQIr9zAwenoLN3YlyVt7Zz324X5peilODdgxp+53XsY2HVqJ09QK457ISkKSHytcv+tU2z1j2Y3MNrr7BIt2+altvklc1ygQXB3UyRZct6EEPdNl+6BezSh1YpXL3MKMJMOkULGR+/SpUZwUoDdbTKOgMN+1hB5TlTBaNKjYaw2pZucslOBx+cDwFf3ikB82BscKE7jxiSc2iLQbPEeCaI44gGHcYsRsIk/u1DUrkns42FYeBty3guaW+1i30fuNsq4Qe5wQig20y8VCKcPOuwpSSbHfxtWWcRXK2PZ4Ov5tmxVbqL+bS9Ak/+9VnX2WvB8jdOqpkY+1Q0ky07N+vMf8qD9YannWH90Imt7cvQXG3OipK84ZZsT+IKMiigMa8yhjjZv0oaUAOUrDRUthUX4SALJubzTc8rbwbS4vDBbbtAejO2xECpzWvFJr3UPaYRXfON+rE/pqxqsULig1QskdtXybsgz4l+3WDy6+T6te6e6nDzsOy2LcW+RttCfmaPLJoXDxl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XaXJGBYuDSm2ZTiq4qySnrYdoSI9UaUXRT8PvCH1iT8XtsdUseP6eMLF1hJWEc55J610I54utcyLU6XjP+xtztrJ1iqaYHCZiy++Mmxlc3wu5o0IzCc9242aRMwqWSsSBbC/OcUIUnFu00N6r9aWkqGGeku7npm/huCYkESDVOTypuwPDSnngfO2KnSKrJsEhBo1fNCTaxQLLxCKJuds5LQa5yNo3H8wTNd1R9CL0jQ1GsaXtsMPmRmL63G0+K96op93PvWzCd0jZ748CWLB4q9hlb39qMRwqqPIaxrd/qrOf9iwQwjFWXydi08AYaTBM7349dnPnvX3xRrU5115wJuc3Xf5lHaOuvs60Wjej9D1NGt16gvy0WQHp4pL97bKJSMXnciiU9ZSBW1C6nuctd2dbovUAzLhmGCYYHts5FfjDPIKismMHrdQoxT48E3C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 03:10:40.9134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d6a64e-9a30-45ec-b06b-08deeeb14d86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
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

The existing user policy representation has three ambiguities:

- A numeric value cannot distinguish explicit zero from an unset policy.
- One value per controller cannot preserve independent AC and DC requests.
- Suspend-only restore misses runtime resume, GPU reset, and table reload.

Refactor policy storage and restore as follows:

- Store values and validity masks by power source and PPT controller.
- Save writes against the active source.
- Restore the active source after default SMU setup.
- Reapply the target policy after live AC/DC transitions.
- Use the target source default when no explicit request exists.

The late-init path now covers system resume, runtime resume, GPU reset,
and custom PPTable reload. Common code owns persistent policy; PMFW
continues to own effective current limits.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 89 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +-
 3 files changed, 68 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index c3688b3b12cc..ce526db4d24a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -508,7 +508,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
 			amdgpu_dpm_notify_ac_dc(adev);
 
 		if (is_support_sw_smu(adev))
-			smu_set_ac_dc(adev->powerplay.pp_handle);
+			smu_set_ac_dc(adev->powerplay.pp_handle, true);
 
 		mutex_unlock(&adev->pm.mutex);
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 99d42446cfc8..43d5dd7dce7e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -488,12 +488,52 @@ static void smu_set_user_clk_dependencies(struct smu_context *smu, enum smu_clk_
 		return;
 }
 
+static void smu_restore_ppt_limits(struct smu_context *smu,
+				   bool restore_defaults)
+{
+	enum smu_power_src_type power_source;
+	struct smu_ppt_limit_range *range;
+	uint32_t restore_mask;
+	uint32_t limit;
+	int i, ret;
+
+	power_source = smu->adev->pm.ac_power ?
+		SMU_POWER_SOURCE_AC : SMU_POWER_SOURCE_DC;
+	restore_mask = smu->user_dpm_profile.ppt_limit_user_mask[power_source] &
+		smu->ppt_limits.supported_mask;
+	if (!restore_mask && !restore_defaults)
+		return;
+
+	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
+
+	for (i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
+		if (!(smu->ppt_limits.supported_mask & BIT(i)))
+			continue;
+
+		if (restore_mask & BIT(i)) {
+			limit = smu->user_dpm_profile.ppt_limits[power_source][i];
+		} else if (restore_defaults) {
+			range = &smu->ppt_limits.range[power_source][i];
+			limit = range->default_value;
+		} else {
+			continue;
+		}
+
+		ret = smu_set_ppt_limit(smu, i, limit);
+		if (ret)
+			dev_err(smu->adev->dev,
+				"Failed to restore PPT%d limit: %d\n", i, ret);
+	}
+
+	smu->user_dpm_profile.flags &= ~SMU_DPM_USER_PROFILE_RESTORE;
+}
+
 /**
  * smu_restore_dpm_user_profile - reinstate user dpm profile
  *
  * @smu:	smu_context pointer
  *
- * Restore saved user power limits, clock frequencies and fan settings.
+ * Restore saved user clock frequencies and fan settings.
  */
 static void smu_restore_dpm_user_profile(struct smu_context *smu)
 {
@@ -509,17 +549,6 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 	/* Enable restore flag */
 	smu->user_dpm_profile.flags |= SMU_DPM_USER_PROFILE_RESTORE;
 
-	/* set the user dpm power limits */
-	for (int i = SMU_PPT_LIMIT_PPT0; i < SMU_LIMIT_TYPE_COUNT; i++) {
-		if (!smu->user_dpm_profile.ppt_limits[i])
-			continue;
-		ret = smu_set_ppt_limit(smu, i,
-					    smu->user_dpm_profile.ppt_limits[i]);
-		if (ret)
-			dev_err(smu->adev->dev,
-				"Failed to set %d PPT limit value\n", i);
-	}
-
 	/* set the user dpm clock configurations */
 	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
 		enum smu_clk_type clk_type;
@@ -932,7 +961,7 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 	 * is unnecessary.
 	 */
 	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
-	smu_set_ac_dc(smu);
+	smu_set_ac_dc(smu, false);
 
 	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
 	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
@@ -967,6 +996,8 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 		return ret;
 	}
 
+	if (adev->in_suspend)
+		smu_restore_ppt_limits(smu, false);
 	smu_restore_dpm_user_profile(smu);
 
 	return 0;
@@ -2746,7 +2777,7 @@ static int smu_set_watermarks_for_clock_ranges(void *handle,
 	return smu_set_watermarks_table(smu, clock_ranges);
 }
 
-int smu_set_ac_dc(struct smu_context *smu)
+int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
 {
 	int ret = 0;
 
@@ -2754,17 +2785,22 @@ int smu_set_ac_dc(struct smu_context *smu)
 		return -EOPNOTSUPP;
 
 	/* controlled by firmware */
-	if (smu->dc_controlled_by_gpio)
-		return 0;
+	if (!smu->dc_controlled_by_gpio) {
+		ret = smu_set_power_source(smu,
+					   smu->adev->pm.ac_power ?
+					   SMU_POWER_SOURCE_AC :
+					   SMU_POWER_SOURCE_DC);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to switch to %s mode!\n",
+				smu->adev->pm.ac_power ? "AC" : "DC");
+			return ret;
+		}
+	}
 
-	ret = smu_set_power_source(smu,
-				   smu->adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
-				   SMU_POWER_SOURCE_DC);
-	if (ret)
-		dev_err(smu->adev->dev, "Failed to switch to %s mode!\n",
-		       smu->adev->pm.ac_power ? "AC" : "DC");
+	if (restore_ppt_policy)
+		smu_restore_ppt_limits(smu, true);
 
-	return ret;
+	return 0;
 }
 
 const struct amd_ip_funcs smu_ip_funcs = {
@@ -3020,8 +3056,11 @@ static int smu_set_ppt_limit(void *handle, uint32_t limit_type, uint32_t limit)
 	ret = smu->ppt_funcs->set_ppt_limit(smu, limit_type, limit);
 	if (ret)
 		return ret;
-	if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
-		smu->user_dpm_profile.ppt_limits[limit_type] = limit;
+	if (!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
+		smu->user_dpm_profile.ppt_limits[power_source][limit_type] = limit;
+		smu->user_dpm_profile.ppt_limit_user_mask[power_source] |=
+			BIT(limit_type);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3d32ee723b8e..698197a285e3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -251,7 +251,8 @@ enum smu_memory_pool_size {
 
 struct smu_user_dpm_profile {
 	uint32_t fan_mode;
-	uint32_t ppt_limits[SMU_LIMIT_TYPE_COUNT];
+	uint32_t ppt_limits[SMU_POWER_SOURCE_COUNT][SMU_LIMIT_TYPE_COUNT];
+	uint32_t ppt_limit_user_mask[SMU_POWER_SOURCE_COUNT];
 	uint32_t fan_speed_pwm;
 	uint32_t fan_speed_rpm;
 	uint32_t flags;
@@ -1953,7 +1954,7 @@ int smu_set_soft_freq_range(struct smu_context *smu, enum pp_clock_type clk_type
 
 int smu_set_gfx_power_up_by_imu(struct smu_context *smu);
 
-int smu_set_ac_dc(struct smu_context *smu);
+int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy);
 
 int smu_set_xgmi_plpd_mode(struct smu_context *smu,
 			   enum pp_xgmi_plpd_mode mode);
-- 
2.54.0

