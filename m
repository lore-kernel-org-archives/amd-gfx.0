Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B232BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 02:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E49D6E082;
	Wed,  8 Dec 2021 02:37:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC27C6E082
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 02:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnaeH2JSqn2dLovOWvqumWyLIvNRSRIWKCGlrDq1EWQzf4ipUnAUQpBk1fPuLmCb3MetK+mlfjHnJi9F9Aewt1KaYl/Dvz8ZLJq0iXAsu75rItFcyTCCJ1y0cLGg14Bt2e0VRHaOXOSA3RZEWzVI4sZVujozZOhU6q2BXF0l9/7zWbG+5JAYwlXCqUot8P3bBgMJdzxduS5m/4vdrukrakvbeoL3W8dI5++xBiZ26puhTHzJrSQEQC9AJ4z4EbWvSl7PybYl6RGkfRn+8eRh1YuUqctHlJAD1dEwhGPv7NfEhQwyERTv/MTFnjOVit6O/EBf7jj2pf3+3eU1sDtL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YfKqg5K72XwDiGnyDcFCdp5OICoTlw6Cl+WEVhXGlA=;
 b=RlBSucF+UhxtGiZjVDKI9He5ans5d+8nqCODa7TbOS3vXANbDFN7x5SzgzuOSUNY+tBkW26xphw/PVH+AqM5/r8ZxQiA9QDGod6gU0TZo4d6AGdDyyGagR/Z0OhGF6MyetfzMFZdtmG2OpyVJuM46AIRRZMfPpeLay9N23txZFMrk+zfJh5s89gmT0LyukKW/a3DQb8xxcF5zsHQ5bgnEYhPcYgbXlepK7cxWU7vxqtKefQ28FUJAbUWOsUVSJ7lbN93vvhNpYLdLipukqhG9Czp/SCBaK7v53Gsnnx0g13DeqZuttdMY3zkN0g+3oEuHfufZXOHa2FtzPp73rqbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YfKqg5K72XwDiGnyDcFCdp5OICoTlw6Cl+WEVhXGlA=;
 b=KzZQ4lUk+CCCV9A2n10LSsTCtaSLu1xSnu6OogRYRYsVKfoq7IiJnVyFNCVvvCHcisUsrprKs+NCTlHQCKWbzBjdwIUbkIELJN1Aj611zSyVs8g+FENqo8sp3edoI4TGMr1+bA+5JZVl7Yje7a48Ck3sZFPjmejyu2Qv7GPkPcg=
Received: from MW4PR03CA0208.namprd03.prod.outlook.com (2603:10b6:303:b8::33)
 by MWHPR12MB1632.namprd12.prod.outlook.com (2603:10b6:301:10::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 02:37:33 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::3) by MW4PR03CA0208.outlook.office365.com
 (2603:10b6:303:b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Wed, 8 Dec 2021 02:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 02:37:33 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 20:37:30 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/7] drm/amd/pm: drop unneeded lock protection smu->mutex
Date: Wed, 8 Dec 2021 10:37:01 +0800
Message-ID: <20211208023707.1814122-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211208023707.1814122-1-evan.quan@amd.com>
References: <20211208023707.1814122-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb5a088-f374-45ad-8f80-08d9b9f3b067
X-MS-TrafficTypeDiagnostic: MWHPR12MB1632:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1632D889688A087D65C992C5E46F9@MWHPR12MB1632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxGdjo/PLjQojt7+M7Ns0jNVjuQrcEKJU+9zEXNr1wSpr6N9w24Ijjmohb5w3lz7ghWlzyiahdRGLYx8dEH1NZeuS34RJy14GK5Yyb+n4PUC5ykpZoxWncaMhTEEkAd0QcDv0Sd6vPUbW2UONzZCRc8dMiVmCOcTh/m60joPn3LanJwgH2dBrATEU8iJdCFCrs4s42ZlQfBzw3k0NP3FQUf75tL5E9syEv33uqLv7v3Cb1WWG1jp6HUG9sSepMUKmFktOwyxbcm4MR1V33+fuNQj4RpniJNiL3HeupqrlRDK9U43+FSKS3X3ZPLGMLZaNRBom9VdwJS+ymsRNqUlrsbtHaeeNIv+6qWWQ/2UhwepenbclKv4d3BL/1cCZztvigw9jZ+dyCFcBDYWrMzqdmvYFZjThIzuXdD36wiMP0SmVY4oPwZvIgNtgowDtj5mUDb33wVQWwk9XIeLu95r4lQzP7+W5Im7lotju4Gc9uNB4vAwdHRlY52drDsJZOpXn9Zr+mUk1d8hzyrKyqEWXsFXboqR0nO52h1Y7ahc2mOEUPdss1LwTjCUgl7wfQtHYMNnAkxRLAWYEeRdn5BSCi5eYmrh+FLrond3h4twZQIMXy/MUTUxeolgJapbjFyWKhaTslChfxQ0//rbgtikWBbcknFqBznde3ECU8KZuwZsOP2EdBzrW6/6okmhjpCC5HDmwbzR25NS56WflLmj7308ZUnPeCbEc1XlLa/h674F5Bkx7lVMY0osyjKKZR9UHrd/3jOqIPIxoJuK8SOUx/NoBytEUbF2Nc9red3x003HCYazjWq6DnsWsmmuxjXgQCCy1EDLJmc5H/zY6weF0A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(86362001)(36860700001)(47076005)(40460700001)(83380400001)(81166007)(82310400004)(5660300002)(356005)(30864003)(2616005)(16526019)(44832011)(8936002)(426003)(6666004)(54906003)(8676002)(316002)(70586007)(508600001)(70206006)(4326008)(336012)(6916009)(2906002)(1076003)(26005)(7696005)(36756003)(186003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 02:37:33.5685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb5a088-f374-45ad-8f80-08d9b9f3b067
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1632
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
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
index b06229adee6f..a4de15c0dbe4 100644
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
 static int smu_set_fan_control_mode(struct smu_context *smu, int value);
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
@@ -1634,8 +1593,6 @@ static int smu_display_configuration_change(void *handle,
 	if (!display_config)
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	smu_set_min_dcef_deep_sleep(smu,
 				    display_config->min_dcef_deep_sleep_set_clk / 100);
 
@@ -1644,8 +1601,6 @@ static int smu_display_configuration_change(void *handle,
 			num_of_active_display++;
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return 0;
 }
 
@@ -1768,22 +1723,18 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 
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
@@ -1794,10 +1745,6 @@ static int smu_handle_task(struct smu_context *smu,
 		break;
 	}
 
-out:
-	if (lock_needed)
-		mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -1808,7 +1755,7 @@ static int smu_handle_dpm_task(void *handle,
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 
-	return smu_handle_task(smu, smu_dpm->dpm_level, task_id, true);
+	return smu_handle_task(smu, smu_dpm->dpm_level, task_id);
 
 }
 
@@ -1827,8 +1774,6 @@ static int smu_switch_power_profile(void *handle,
 	if (!(type < PP_SMC_POWER_PROFILE_CUSTOM))
 		return -EINVAL;
 
-	mutex_lock(&smu->mutex);
-
 	if (!en) {
 		smu->workload_mask &= ~(1 << smu->workload_prority[type]);
 		index = fls(smu->workload_mask);
@@ -1845,8 +1790,6 @@ static int smu_switch_power_profile(void *handle,
 		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
 		smu_bump_power_profile_mode(smu, &workload, 0);
 
-	mutex_unlock(&smu->mutex);
-
 	return 0;
 }
 
@@ -1854,7 +1797,6 @@ static enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
-	enum amd_dpm_forced_level level;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
@@ -1862,11 +1804,7 @@ static enum amd_dpm_forced_level smu_get_performance_level(void *handle)
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
@@ -1882,19 +1820,12 @@ static int smu_force_performance_level(void *handle,
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
@@ -1908,16 +1839,11 @@ static int smu_force_performance_level(void *handle,
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
@@ -1935,8 +1861,6 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 		return -EINVAL;
 	}
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels) {
 		ret = smu->ppt_funcs->force_clk_levels(smu, clk_type, mask);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
@@ -1945,8 +1869,6 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 		}
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2005,14 +1927,10 @@ static int smu_set_mp1_state(void *handle,
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
 
@@ -2028,14 +1946,10 @@ static int smu_set_df_cstate(void *handle,
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
 
@@ -2049,38 +1963,25 @@ int smu_allow_xgmi_power_down(struct smu_context *smu, bool en)
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
@@ -2088,13 +1989,7 @@ static int smu_set_watermarks_for_clock_ranges(void *handle,
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
@@ -2108,14 +2003,12 @@ int smu_set_ac_dc(struct smu_context *smu)
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
@@ -2202,13 +2095,9 @@ static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
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
 
@@ -2220,8 +2109,6 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->set_fan_speed_rpm) {
 		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
@@ -2234,8 +2121,6 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 		}
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2291,8 +2176,6 @@ int smu_get_power_limit(void *handle,
 		break;
 	}
 
-	mutex_lock(&smu->mutex);
-
 	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
 		if (smu->ppt_funcs->get_ppt_limit)
 			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
@@ -2326,8 +2209,6 @@ int smu_get_power_limit(void *handle,
 		}
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2340,21 +2221,16 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
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
@@ -2366,9 +2242,6 @@ static int smu_set_power_limit(void *handle, uint32_t limit)
 			smu->user_dpm_profile.power_limit = limit;
 	}
 
-out:
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2379,13 +2252,9 @@ static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type cl
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
 
@@ -2442,14 +2311,10 @@ static int smu_od_edit_dpm_table(void *handle,
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
 
@@ -2473,8 +2338,6 @@ static int smu_read_sensor(void *handle,
 	size_val = *size_arg;
 	size = &size_val;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->read_sensor)
 		if (!smu->ppt_funcs->read_sensor(smu, sensor, data, size))
 			goto unlock;
@@ -2515,8 +2378,6 @@ static int smu_read_sensor(void *handle,
 	}
 
 unlock:
-	mutex_unlock(&smu->mutex);
-
 	// assign uint32_t to int
 	*size_arg = size_val;
 
@@ -2526,7 +2387,6 @@ static int smu_read_sensor(void *handle,
 static int smu_get_power_profile_mode(void *handle, char *buf)
 {
 	struct smu_context *smu = handle;
-	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
 	    !smu->ppt_funcs->get_power_profile_mode)
@@ -2534,13 +2394,7 @@ static int smu_get_power_profile_mode(void *handle, char *buf)
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
@@ -2548,19 +2402,12 @@ static int smu_set_power_profile_mode(void *handle,
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
 
 
@@ -2572,13 +2419,9 @@ static u32 smu_get_fan_control_mode(void *handle)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return AMD_FAN_CTRL_NONE;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_fan_control_mode)
 		ret = smu->ppt_funcs->get_fan_control_mode(smu);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2589,16 +2432,12 @@ static int smu_set_fan_control_mode(struct smu_context *smu, int value)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return  -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->set_fan_control_mode) {
 		ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
 			smu->user_dpm_profile.fan_mode = value;
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	/* reset user dpm fan speed */
 	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
 			!(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
@@ -2626,13 +2465,9 @@ static int smu_get_fan_speed_pwm(void *handle, u32 *speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_fan_speed_pwm)
 		ret = smu->ppt_funcs->get_fan_speed_pwm(smu, speed);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2644,8 +2479,6 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->set_fan_speed_pwm) {
 		ret = smu->ppt_funcs->set_fan_speed_pwm(smu, speed);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE)) {
@@ -2658,8 +2491,6 @@ static int smu_set_fan_speed_pwm(void *handle, u32 speed)
 		}
 	}
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
@@ -2671,31 +2502,20 @@ static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_fan_speed_rpm)
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
@@ -2709,8 +2529,6 @@ static int smu_get_clock_by_type_with_latency(void *handle,
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->get_clock_by_type_with_latency) {
 		switch (type) {
 		case amd_pp_sys_clock:
@@ -2727,15 +2545,12 @@ static int smu_get_clock_by_type_with_latency(void *handle,
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
 
@@ -2748,13 +2563,9 @@ static int smu_display_clock_voltage_request(void *handle,
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
 
@@ -2768,13 +2579,9 @@ static int smu_display_disable_memory_clock_switch(void *handle,
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
 
@@ -2787,13 +2594,9 @@ static int smu_set_xgmi_pstate(void *handle,
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
 
@@ -2803,21 +2606,16 @@ static int smu_set_xgmi_pstate(void *handle,
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
@@ -2829,20 +2627,11 @@ static int smu_baco_set_state(void *handle, int state)
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
@@ -2861,13 +2650,9 @@ bool smu_mode1_reset_is_support(struct smu_context *smu)
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
 
@@ -2878,13 +2663,9 @@ bool smu_mode2_reset_is_support(struct smu_context *smu)
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
 
@@ -2895,13 +2676,9 @@ int smu_mode1_reset(struct smu_context *smu)
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
 
@@ -2913,13 +2690,9 @@ static int smu_mode2_reset(void *handle)
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
 
@@ -2935,13 +2708,9 @@ static int smu_get_max_sustainable_clocks_by_dc(void *handle,
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
 
@@ -2955,13 +2724,9 @@ static int smu_get_uclk_dpm_states(void *handle,
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
 
@@ -2973,13 +2738,9 @@ static enum amd_pm_state_type smu_get_current_power_state(void *handle)
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
 
@@ -2992,20 +2753,15 @@ static int smu_get_dpm_clock_table(void *handle,
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
@@ -3013,13 +2769,7 @@ static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
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
@@ -3030,13 +2780,9 @@ static int smu_enable_mgpu_fan_boost(void *handle)
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
 
@@ -3046,10 +2792,8 @@ static int smu_gfx_state_change_set(void *handle,
 	struct smu_context *smu = handle;
 	int ret = 0;
 
-	mutex_lock(&smu->mutex);
 	if (smu->ppt_funcs->gfx_state_change_set)
 		ret = smu->ppt_funcs->gfx_state_change_set(smu, state);
-	mutex_unlock(&smu->mutex);
 
 	return ret;
 }
@@ -3058,10 +2802,8 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable)
 {
 	int ret = 0;
 
-	mutex_lock(&smu->mutex);
 	if (smu->ppt_funcs->set_light_sbr)
 		ret = smu->ppt_funcs->set_light_sbr(smu, enable);
-	mutex_unlock(&smu->mutex);
 
 	return ret;
 }
@@ -3070,11 +2812,9 @@ int smu_get_ecc_info(struct smu_context *smu, void *umc_ecc)
 {
 	int ret = -EOPNOTSUPP;
 
-	mutex_lock(&smu->mutex);
 	if (smu->ppt_funcs &&
 		smu->ppt_funcs->get_ecc_info)
 		ret = smu->ppt_funcs->get_ecc_info(smu, umc_ecc);
-	mutex_unlock(&smu->mutex);
 
 	return ret;
 
@@ -3091,12 +2831,10 @@ static int smu_get_prv_buffer_details(void *handle, void **addr, size_t *size)
 
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
@@ -3160,11 +2898,8 @@ int smu_wait_for_event(struct smu_context *smu, enum smu_event_type event,
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
index b36f18546f8f..19b60a578144 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -487,7 +487,6 @@ struct smu_context
 	const struct cmn2asic_mapping	*table_map;
 	const struct cmn2asic_mapping	*pwr_src_map;
 	const struct cmn2asic_mapping	*workload_map;
-	struct mutex			mutex;
 	struct mutex			sensor_lock;
 	struct mutex			metrics_lock;
 	struct mutex			message_lock;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1e6d76657bbb..8eb8bb934d4a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2128,9 +2128,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
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
index cc502a35f9ef..a938977fdae8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1530,9 +1530,7 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
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

