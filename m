Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6C6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 05:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D6A10EBEF;
	Mon, 17 Jan 2022 05:42:23 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7063210EBF8
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 05:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUrROy0jxC982KfDH5eDjBpHAZIjkPlh363Q3HAkzPyexCui5F8G2w7gZhSCS2Dgcler8SyN0gIvZQu2AFfDRsvWP50pKq+VbJp+76oK1hru22ytd4ET/CG0txeJGG5uyUNnY/WWkpTPAWidy0L2uN905KGRwDDuoB9seZgB/+GUuLFFETlGoBAiK63E4gxsVlB1U+W/aA39nPgZJsuYAkUTEupaGhhc0irD8Rfne1XXjESnwUPAL1OV/ManIe41J+cVQadac8pavVwilXKizy7r/GPujgUIpF4vvRR0KLHB3x09b6oNNA+gWiuoQ3kMIckTI7g5dWsohJabG9PahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsKCvDlBbSyNzdCrdvU+v21pQENGCi79Den+qsoH5GQ=;
 b=Hqib13yaFgET7n9Nq3MFERXMIoLTJ3oxl971crwgZs01v2bdznq5Ii8STMnCoaywG056e+CkqM8m7ATRzBnvZC40Anx7bldLnYOWQzE30+3Io6vwH4OnQZ/nqV8hjXlinACjKzqoZudvlr6SMIGYgBpB6+6eBrqveKjMZcnlbJZoPf/KaeWIF5xmJG2toiIqmC53/5G3nX6Ed8/WJ9dhxihzKGSUQxWD/9ZxkIZ7U97PPXbGsF2tT+dHGfoYYx1TlyPBG4J+EXZAypyFMRtWWXvYTOs8NYdrJQIklFFYUKCHvQoF8FcqdSlre5TuntWX/zkft0qdk5Vi+oq4YsNjJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsKCvDlBbSyNzdCrdvU+v21pQENGCi79Den+qsoH5GQ=;
 b=yIn6OeDviZBH/dOMtLqe22fQAE87wfetrzPEQVfVnlqI9CuiSbS9hPVj+kampAClNFA4bMmDmdcmI8AR71vSYUPGbQJ7cQj5NW19Pjn4QZ56HtLFYVgtmykUXpMTsnJXgdgaTse4XMVEhX7oGMl2nbnnN3lysZu5nB01nBq9lpg=
Received: from BN8PR12CA0017.namprd12.prod.outlook.com (2603:10b6:408:60::30)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 05:42:16 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::26) by BN8PR12CA0017.outlook.office365.com
 (2603:10b6:408:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Mon, 17 Jan 2022 05:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 05:42:15 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 16 Jan
 2022 23:42:13 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/7] drm/amd/pm: drop unneeded lock protection smu->mutex
Date: Mon, 17 Jan 2022 13:41:45 +0800
Message-ID: <20220117054151.124838-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77ccec9a-78ce-4160-23ce-08d9d97c1e61
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5110C0E3E04DA34C01FF0C33E4579@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NeSRIHK66AxCQPN+vdxvvVN1Bfp9qi18hIgyXjFtmEDZKrHQ30un0kOuug/XST0TSxJnm1Gm8XcQ9L3wayNca1OxnqMxKcmuI3gdsQat/tt2CzbBq6/yaNjtG/h73UHjFNz831SxGZUtYUVF3hTo3LomLm2NaqH9a6AsyJ5YVGFW+SrF0uRCuqhOmHK9dY8GwgrjN2qKLje+z8EBg9fhB8EkHg0HumUDzRT3bu2ZUgcKxATwDAeYvbpUYIB2m7/w8R8jpIxsRDn2rZOmqMEY04gbWp6K2L7QIUkPs45Bfkb9EBKqgbk3GF/5KOy8HFlYlQTJFkj4ftB1zjzDGz8cPTWfUdVOaxppfKNe3cza5uYFlrY+Zj+LfAeSrJJrCZAZwSM5k+lwKlYRcARDFADd49yk7gb9DFrVRpr6fMs8Iakhay5sT7JUtcKAdl78tUix+9MIVbfScvMjSI2s+OJfq0g3YlM12BEb1A9LJYkFDrBoGJC4LHxiUa5zJA2K53Us99R07Fl3ElhU1XJUNXD24AxC4kOw0liwneSqEAjCob+rSWB0PEKonSh5rBO4ihKUre69slNlLh9I7Yw7YR80jcSAemGz6q87Me5tpbeu7l/NXA2EalK4sUKvkpQ3ftOs7NK3t/5e4S0k/WVcTuGRKtq6aaDXzBKL6iEtUNPwneLF8s6RL4wYb4eHXhtB/qUTVHHALxfb5q4RM31WdcqaDli5/LYygfzL+YDtt7VGtwLB7M0wdWb5CEu7brZSTyNbsuCD1RlkFM5w/+IeRG2lVfWWSHCCyCfIZQTwyoxXf4i6eJMtRn9CsNx0mPjAIKF2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(30864003)(6666004)(508600001)(7696005)(356005)(8676002)(82310400004)(6916009)(5660300002)(44832011)(2616005)(83380400001)(86362001)(54906003)(316002)(8936002)(70206006)(70586007)(40460700001)(4326008)(36756003)(36860700001)(26005)(81166007)(16526019)(186003)(1076003)(426003)(2906002)(336012)(47076005)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 05:42:15.8021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ccec9a-78ce-4160-23ce-08d9d97c1e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
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
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As all those APIs are already protected either by adev->pm.mutex
or smu->message_lock.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I1db751fba9caabc5ca1314992961d3674212f9b0
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 315 ++----------------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 -
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   2 -
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   2 -
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   2 -
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |   2 -
 6 files changed, 25 insertions(+), 299 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 828cb932f6a9..411f03eb4523 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -55,8 +55,7 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 				   uint32_t mask);
 static int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
-			   enum amd_pp_task task_id,
-			   bool lock_needed);
+			   enum amd_pp_task task_id);
 static int smu_reset(struct smu_context *smu);
 static int smu_set_fan_speed_pwm(void *handle, u32 speed);
 static int smu_set_fan_control_mode(void *handle, u32 value);
@@ -68,36 +67,22 @@ static int smu_sys_get_pp_feature_mask(void *handle,
 				       char *buf)
 {
 	struct smu_context *smu = handle;
-	int size = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
-	size = smu_get_pp_feature_mask(smu, buf);
-
-	mutex_unlock(&smu->mutex);
-
-	return size;
+	return smu_get_pp_feature_mask(smu, buf);
 }
 
 static int smu_sys_set_pp_feature_mask(void *handle,
 				       uint64_t new_mask)
 {
 	struct smu_context *smu = handle;
-	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
-	ret = smu_set_pp_feature_mask(smu, new_mask);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_set_pp_feature_mask(smu, new_mask);
 }
 
 int smu_get_status_gfxoff(struct smu_context *smu, uint32_t *value)
@@ -117,16 +102,12 @@ int smu_set_soft_freq_range(struct smu_context *smu,
 {
 	int ret = 0;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->set_soft_freq_limited_range)
 		ret = smu->ppt_funcs->set_soft_freq_limited_range(smu,
 								  clk_type,
 								  min,
 								  max);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -140,16 +121,12 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	if (!min && !max)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_dpm_ultimate_freq)
 		ret = smu->ppt_funcs->get_dpm_ultimate_freq(smu,
 							    clk_type,
 							    min,
 							    max);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -482,7 +459,6 @@ static int smu_sys_get_pp_table(void *handle,
 {
 	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
-	uint32_t powerplay_table_size;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -490,18 +466,12 @@ static int smu_sys_get_pp_table(void *handle,
 	if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu_table->hardcode_pptable)
 		*table = smu_table->hardcode_pptable;
 	else
 		*table = smu_table->power_play_table;
 
-	powerplay_table_size = smu_table->power_play_table_size;
-
-	mutex_unlock(&smu->mutex);
-
-	return powerplay_table_size;
+	return smu_table->power_play_table_size;
 }
 
 static int smu_sys_set_pp_table(void *handle,
@@ -521,13 +491,10 @@ static int smu_sys_set_pp_table(void *handle,
 		return -EIO;
 	}
 
-	mutex_lock(&smu->mutex);
 	if (!smu_table->hardcode_pptable)
 		smu_table->hardcode_pptable = kzalloc(size, GFP_KERNEL);
-	if (!smu_table->hardcode_pptable) {
-		ret = -ENOMEM;
-		goto failed;
-	}
+	if (!smu_table->hardcode_pptable)
+		return -ENOMEM;
 
 	memcpy(smu_table->hardcode_pptable, buf, size);
 	smu_table->power_play_table = smu_table->hardcode_pptable;
@@ -545,8 +512,6 @@ static int smu_sys_set_pp_table(void *handle,
 
 	smu->uploading_custom_pp_table = false;
 
-failed:
-	mutex_unlock(&smu->mutex);
 	return ret;
 }
 
@@ -633,7 +598,6 @@ static int smu_early_init(void *handle)
 	smu->adev = adev;
 	smu->pm_enabled = !!amdgpu_dpm;
 	smu->is_apu = false;
-	mutex_init(&smu->mutex);
 	mutex_init(&smu->smu_baco.mutex);
 	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
@@ -736,8 +700,7 @@ static int smu_late_init(void *handle)
 
 	smu_handle_task(smu,
 			smu->smu_dpm.dpm_level,
-			AMD_PP_TASK_COMPLETE_INIT,
-			false);
+			AMD_PP_TASK_COMPLETE_INIT);
 
 	smu_restore_dpm_user_profile(smu);
 
@@ -1013,12 +976,8 @@ static void smu_interrupt_work_fn(struct work_struct *work)
 	struct smu_context *smu = container_of(work, struct smu_context,
 					       interrupt_work);
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->interrupt_work)
 		smu->ppt_funcs->interrupt_work(smu);
-
-	mutex_unlock(&smu->mutex);
 }
 
 static int smu_sw_init(void *handle)
@@ -1632,8 +1591,6 @@ static int smu_display_configuration_change(void *handle,
 	if (!display_config)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	smu_set_min_dcef_deep_sleep(smu,
 				    display_config->min_dcef_deep_sleep_set_clk / 100);
 
@@ -1642,8 +1599,6 @@ static int smu_display_configuration_change(void *handle,
 			num_of_active_display++;
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return 0;
 }
 
@@ -1766,22 +1721,18 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 
 static int smu_handle_task(struct smu_context *smu,
 			   enum amd_dpm_forced_level level,
-			   enum amd_pp_task task_id,
-			   bool lock_needed)
+			   enum amd_pp_task task_id)
 {
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (lock_needed)
-		mutex_lock(&smu->mutex);
-
 	switch (task_id) {
 	case AMD_PP_TASK_DISPLAY_CONFIG_CHANGE:
 		ret = smu_pre_display_config_changed(smu);
 		if (ret)
-			goto out;
+			return ret;
 		ret = smu_adjust_power_state_dynamic(smu, level, false);
 		break;
 	case AMD_PP_TASK_COMPLETE_INIT:
@@ -1792,10 +1743,6 @@ static int smu_handle_task(struct smu_context *smu,
 		break;
 	}
 
-out:
-	if (lock_needed)
-		mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -1806,7 +1753,7 @@ static int smu_handle_dpm_task(void *handle,
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
-	return smu_handle_task(smu, smu_dpm->dpm_level, task_id, true);
+	return smu_handle_task(smu, smu_dpm->dpm_level, task_id);
 
 }
 
@@ -1825,8 +1772,6 @@ static int smu_switch_power_profile(void *handle,
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	if (!en) {
 		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
 		index = fls(smu->workload_mask);
@@ -1843,8 +1788,6 @@ static int smu_switch_power_profile(void *handle,
 		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
 		smu_bump_power_profile_mode(smu, &workload, 0);
 
-	mutex_unlock(&smu->mutex);
-
 	return 0;
 }
 
@@ -1852,7 +1795,6 @@ static enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	enum amd_dpm_forced_level level;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -1860,11 +1802,7 @@ static enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
 
-	mutex_lock(&(smu->mutex));
-	level = smu_dpm_ctx->dpm_level;
-	mutex_unlock(&(smu->mutex));
-
-	return level;
+	return smu_dpm_ctx->dpm_level;
 }
 
 static int smu_force_performance_level(void *handle,
@@ -1880,19 +1818,12 @@ static int smu_force_performance_level(void *handle,
 	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	ret = smu_enable_umd_pstate(smu, &level);
-	if (ret) {
-		mutex_unlock(&smu->mutex);
+	if (ret)
 		return ret;
-	}
 
 	ret = smu_handle_task(smu, level,
-			      AMD_PP_TASK_READJUST_POWER_STATE,
-			      false);
-
-	mutex_unlock(&smu->mutex);
+			      AMD_PP_TASK_READJUST_POWER_STATE);
 
 	/* reset user dpm clock state */
 	if (!ret && smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
@@ -1906,16 +1837,11 @@ static int smu_force_performance_level(void *handle,
 static int smu_set_display_count(void *handle, uint32_t count)
 {
 	struct smu_context *smu = handle;
-	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-	ret = smu_init_display_count(smu, count);
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_init_display_count(smu, count);
 }
 
 static int smu_force_smuclk_levels(struct smu_context *smu,
@@ -1933,8 +1859,6 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels) {
 		ret = smu->ppt_funcs->force_clk_levels(smu, clk_type, mask);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
@@ -1943,8 +1867,6 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 		}
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2003,14 +1925,10 @@ static int smu_set_mp1_state(void *handle,
 	if (!smu->pm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs &&
 	    smu->ppt_funcs->set_mp1_state)
 		ret = smu->ppt_funcs->set_mp1_state(smu, mp1_state);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2026,14 +1944,10 @@ static int smu_set_df_cstate(void *handle,
 	if (!smu->ppt_funcs || !smu->ppt_funcs->set_df_cstate)
 		return 0;
 
-	mutex_lock(&smu->mutex);
-
 	ret = smu->ppt_funcs->set_df_cstate(smu, state);
 	if (ret)
 		dev_err(smu->adev->dev, "[SetDfCstate] failed!\n");
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2047,38 +1961,25 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bool en)
 	if (!smu->ppt_funcs || !smu->ppt_funcs->allow_xgmi_power_down)
 		return 0;
 
-	mutex_lock(&smu->mutex);
-
 	ret = smu->ppt_funcs->allow_xgmi_power_down(smu, en);
 	if (ret)
 		dev_err(smu->adev->dev, "[AllowXgmiPowerDown] failed!\n");
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
 int smu_write_watermarks_table(struct smu_context *smu)
 {
-	int ret = 0;
-
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
-	ret = smu_set_watermarks_table(smu, NULL);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_set_watermarks_table(smu, NULL);
 }
 
 static int smu_set_watermarks_for_clock_ranges(void *handle,
 					       struct pp_smu_wm_range_sets *clock_ranges)
 {
 	struct smu_context *smu = handle;
-	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -2086,13 +1987,7 @@ static int smu_set_watermarks_for_clock_ranges(void *handle,
 	if (smu->disable_watermark)
 		return 0;
 
-	mutex_lock(&smu->mutex);
-
-	ret = smu_set_watermarks_table(smu, clock_ranges);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_set_watermarks_table(smu, clock_ranges);
 }
 
 int smu_set_ac_dc(struct smu_context *smu)
@@ -2106,14 +2001,12 @@ int smu_set_ac_dc(struct smu_context *smu)
 	if (smu->dc_controlled_by_gpio)
 		return 0;
 
-	mutex_lock(&smu->mutex);
 	ret = smu_set_power_source(smu,
 				   smu->adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
 				   SMU_POWER_SOURCE_DC);
 	if (ret)
 		dev_err(smu->adev->dev, "Failed to switch to %s mode!\n",
 		       smu->adev->pm.ac_power ? "AC" : "DC");
-	mutex_unlock(&smu->mutex);
 
 	return ret;
 }
@@ -2200,13 +2093,9 @@ static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 {
 	int ret = 0;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->set_gfx_cgpg)
 		ret = smu->ppt_funcs->set_gfx_cgpg(smu, enabled);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2224,8 +2113,6 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	if (speed == U32_MAX)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
 	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
 		smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_RPM;
@@ -2236,8 +2123,6 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 		smu->user_dpm_profile.fan_speed_pwm = 0;
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2293,8 +2178,6 @@ int smu_get_power_limit(void *handle,
 		break;
 	}
 
-	mutex_lock(&smu->mutex);
-
 	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
 		if (smu->ppt_funcs->get_ppt_limit)
 			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
@@ -2328,8 +2211,6 @@ int smu_get_power_limit(void *handle,
 		}
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2342,21 +2223,16 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	limit &= (1<<24)-1;
 	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
-		if (smu->ppt_funcs->set_power_limit) {
-			ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
-			goto out;
-		}
+		if (smu->ppt_funcs->set_power_limit)
+			return smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
 
 	if (limit > smu->max_power_limit) {
 		dev_err(smu->adev->dev,
 			"New power limit (%d) is over the max allowed %d\n",
 			limit, smu->max_power_limit);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	if (!limit)
@@ -2368,9 +2244,6 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
 			smu->user_dpm_profile.power_limit = limit;
 	}
 
-out:
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2381,13 +2254,9 @@ static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type cl
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->print_clk_levels)
 		ret = smu->ppt_funcs->print_clk_levels(smu, clk_type, buf);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2444,14 +2313,10 @@ static int smu_od_edit_dpm_table(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->od_edit_dpm_table) {
 		ret = smu->ppt_funcs->od_edit_dpm_table(smu, type, input, size);
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2475,8 +2340,6 @@ static int smu_read_sensor(void *handle,
 	size_val = *size_arg;
 	size = &size_val;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->read_sensor)
 		if (!smu->ppt_funcs->read_sensor(smu, sensor, data, size))
 			goto unlock;
@@ -2517,8 +2380,6 @@ static int smu_read_sensor(void *handle,
 	}
 
 unlock:
-	mutex_unlock(&smu->mutex);
-
 	// assign uint32_t to int
 	*size_arg = size_val;
 
@@ -2528,7 +2389,6 @@ static int smu_read_sensor(void *handle,
 static int smu_get_power_profile_mode(void *handle, char *buf)
 {
 	struct smu_context *smu = handle;
-	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->get_power_profile_mode)
@@ -2536,13 +2396,7 @@ static int smu_get_power_profile_mode(void *handle, char *buf)
 	if (!buf)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
-	ret = smu->ppt_funcs->get_power_profile_mode(smu, buf);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu->ppt_funcs->get_power_profile_mode(smu, buf);
 }
 
 static int smu_set_power_profile_mode(void *handle,
@@ -2550,19 +2404,12 @@ static int smu_set_power_profile_mode(void *handle,
 				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
-	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->set_power_profile_mode)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
-	smu_bump_power_profile_mode(smu, param, param_size);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_bump_power_profile_mode(smu, param, param_size);
 }
 
 
@@ -2579,12 +2426,8 @@ static int smu_get_fan_control_mode(void *handle, u32 *fan_mode)
 	if (!fan_mode)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	*fan_mode = smu->ppt_funcs->get_fan_control_mode(smu);
 
-	mutex_unlock(&smu->mutex);
-
 	return 0;
 }
 
@@ -2602,8 +2445,6 @@ static int smu_set_fan_control_mode(void *handle, u32 value)
 	if (value == U32_MAX)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
 	if (ret)
 		goto out;
@@ -2620,8 +2461,6 @@ static int smu_set_fan_control_mode(void *handle, u32 value)
 	}
 
 out:
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2639,12 +2478,8 @@ static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
 	if (!speed)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2662,8 +2497,6 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
 	if (speed == U32_MAX)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
 	if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
 		smu->user_dpm_profile.flags |= SMU_CUSTOM_FAN_SPEED_PWM;
@@ -2674,8 +2507,6 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
 		smu->user_dpm_profile.fan_speed_rpm = 0;
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2693,30 +2524,19 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 	if (!speed)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	ret = smu->ppt_funcs->get_fan_speed_rpm(smu, speed);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
 static int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)
 {
 	struct smu_context *smu = handle;
-	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
-	ret = smu_set_min_dcef_deep_sleep(smu, clk);
-
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return smu_set_min_dcef_deep_sleep(smu, clk);
 }
 
 static int smu_get_clock_by_type_with_latency(void *handle,
@@ -2730,8 +2550,6 @@ static int smu_get_clock_by_type_with_latency(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_clock_by_type_with_latency) {
 		switch (type) {
 		case amd_pp_sys_clock:
@@ -2748,15 +2566,12 @@ static int smu_get_clock_by_type_with_latency(void *handle,
 			break;
 		default:
 			dev_err(smu->adev->dev, "Invalid clock type!\n");
-			mutex_unlock(&smu->mutex);
 			return -EINVAL;
 		}
 
 		ret = smu->ppt_funcs->get_clock_by_type_with_latency(smu, clk_type, clocks);
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2769,13 +2584,9 @@ static int smu_display_clock_voltage_request(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->display_clock_voltage_request)
 		ret = smu->ppt_funcs->display_clock_voltage_request(smu, clock_req);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2789,13 +2600,9 @@ static int smu_display_disable_memory_clock_switch(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->display_disable_memory_clock_switch)
 		ret = smu->ppt_funcs->display_disable_memory_clock_switch(smu, disable_memory_clock_switch);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2808,13 +2615,9 @@ static int smu_set_xgmi_pstate(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->set_xgmi_pstate)
 		ret = smu->ppt_funcs->set_xgmi_pstate(smu, pstate);
 
-	mutex_unlock(&smu->mutex);
-
 	if(ret)
 		dev_err(smu->adev->dev, "Failed to set XGMI pstate!\n");
 
@@ -2824,21 +2627,16 @@ static int smu_set_xgmi_pstate(void *handle,
 static int smu_get_baco_capability(void *handle, bool *cap)
 {
 	struct smu_context *smu = handle;
-	int ret = 0;
 
 	*cap = false;
 
 	if (!smu->pm_enabled)
 		return 0;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->baco_is_support)
 		*cap = smu->ppt_funcs->baco_is_support(smu);
 
-	mutex_unlock(&smu->mutex);
-
-	return ret;
+	return 0;
 }
 
 static int smu_baco_set_state(void *handle, int state)
@@ -2850,20 +2648,11 @@ static int smu_baco_set_state(void *handle, int state)
 		return -EOPNOTSUPP;
 
 	if (state == 0) {
-		mutex_lock(&smu->mutex);
-
 		if (smu->ppt_funcs->baco_exit)
 			ret = smu->ppt_funcs->baco_exit(smu);
-
-		mutex_unlock(&smu->mutex);
 	} else if (state == 1) {
-		mutex_lock(&smu->mutex);
-
 		if (smu->ppt_funcs->baco_enter)
 			ret = smu->ppt_funcs->baco_enter(smu);
-
-		mutex_unlock(&smu->mutex);
-
 	} else {
 		return -EINVAL;
 	}
@@ -2882,13 +2671,9 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)
 	if (!smu->pm_enabled)
 		return false;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->mode1_reset_is_support)
 		ret = smu->ppt_funcs->mode1_reset_is_support(smu);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2899,13 +2684,9 @@ bool smu_mode2_reset_is_support(struct smu_context *smu)
 	if (!smu->pm_enabled)
 		return false;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->mode2_reset_is_support)
 		ret = smu->ppt_funcs->mode2_reset_is_support(smu);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2916,13 +2697,9 @@ int smu_mode1_reset(struct smu_context *smu)
 	if (!smu->pm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->mode1_reset)
 		ret = smu->ppt_funcs->mode1_reset(smu);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2934,13 +2711,9 @@ static int smu_mode2_reset(void *handle)
 	if (!smu->pm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->mode2_reset)
 		ret = smu->ppt_funcs->mode2_reset(smu);
 
-	mutex_unlock(&smu->mutex);
-
 	if (ret)
 		dev_err(smu->adev->dev, "Mode2 reset failed!\n");
 
@@ -2956,13 +2729,9 @@ static int smu_get_max_sustainable_clocks_by_dc(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_max_sustainable_clocks_by_dc)
 		ret = smu->ppt_funcs->get_max_sustainable_clocks_by_dc(smu, max_clocks);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2976,13 +2745,9 @@ static int smu_get_uclk_dpm_states(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_uclk_dpm_states)
 		ret = smu->ppt_funcs->get_uclk_dpm_states(smu, clock_values_in_khz, num_states);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2994,13 +2759,9 @@ static enum amd_pm_state_type smu_get_current_power_state(void *handle)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_current_power_state)
 		pm_state = smu->ppt_funcs->get_current_power_state(smu);
 
-	mutex_unlock(&smu->mutex);
-
 	return pm_state;
 }
 
@@ -3013,20 +2774,15 @@ static int smu_get_dpm_clock_table(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_dpm_clock_table)
 		ret = smu->ppt_funcs->get_dpm_clock_table(smu, clock_table);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
 static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 {
 	struct smu_context *smu = handle;
-	ssize_t size;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -3034,13 +2790,7 @@ static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 	if (!smu->ppt_funcs->get_gpu_metrics)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
-	size = smu->ppt_funcs->get_gpu_metrics(smu, table);
-
-	mutex_unlock(&smu->mutex);
-
-	return size;
+	return smu->ppt_funcs->get_gpu_metrics(smu, table);
 }
 
 static int smu_enable_mgpu_fan_boost(void *handle)
@@ -3051,13 +2801,9 @@ static int smu_enable_mgpu_fan_boost(void *handle)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->enable_mgpu_fan_boost)
 		ret = smu->ppt_funcs->enable_mgpu_fan_boost(smu);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -3067,10 +2813,8 @@ static int smu_gfx_state_change_set(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	mutex_lock(&smu->mutex);
 	if (smu->ppt_funcs->gfx_state_change_set)
 		ret = smu->ppt_funcs->gfx_state_change_set(smu, state);
-	mutex_unlock(&smu->mutex);
 
 	return ret;
 }
@@ -3079,10 +2823,8 @@ int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)
 {
 	int ret = 0;
 
-	mutex_lock(&smu->mutex);
 	if (smu->ppt_funcs->smu_handle_passthrough_sbr)
 		ret = smu->ppt_funcs->smu_handle_passthrough_sbr(smu, enable);
-	mutex_unlock(&smu->mutex);
 
 	return ret;
 }
@@ -3091,11 +2833,9 @@ int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc)
 {
 	int ret = -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
 	if (smu->ppt_funcs &&
 		smu->ppt_funcs->get_ecc_info)
 		ret = smu->ppt_funcs->get_ecc_info(smu, umc_ecc);
-	mutex_unlock(&smu->mutex);
 
 	return ret;
 
@@ -3112,12 +2852,10 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 
 	*addr = NULL;
 	*size = 0;
-	mutex_lock(&smu->mutex);
 	if (memory_pool->bo) {
 		*addr = memory_pool->cpu_addr;
 		*size = memory_pool->size;
 	}
-	mutex_unlock(&smu->mutex);
 
 	return 0;
 }
@@ -3181,11 +2919,8 @@ int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
 {
 	int ret = -EINVAL;
 
-	if (smu->ppt_funcs->wait_for_event) {
-		mutex_lock(&smu->mutex);
+	if (smu->ppt_funcs->wait_for_event)
 		ret = smu->ppt_funcs->wait_for_event(smu, event, event_arg);
-		mutex_unlock(&smu->mutex);
-	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3fdab6a44901..00760f3c6da5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -488,7 +488,6 @@ struct smu_context
 	const struct cmn2asic_mapping	*table_map;
 	const struct cmn2asic_mapping	*pwr_src_map;
 	const struct cmn2asic_mapping	*workload_map;
-	struct mutex			mutex;
 	struct mutex			sensor_lock;
 	struct mutex			metrics_lock;
 	struct mutex			message_lock;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index d3963bfe5c89..addb0472d040 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2118,9 +2118,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
 	if (r)
 		goto fail;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 37e11716e919..fe17b3c1ece7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2826,9 +2826,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
 	if (r)
 		goto fail;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9766870987db..93caaf45a2db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3483,9 +3483,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
 	if (r)
 		goto fail;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index ac8ba5e0e697..2546f79c8511 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1521,9 +1521,7 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
 			}
 		}
 	}
-	mutex_lock(&smu->mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&smu->mutex);
 	if (r)
 		goto fail;
 
-- 
2.29.0

