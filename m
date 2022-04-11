Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CA7C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 07:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF5410F021;
	Mon, 11 Apr 2022 07:48:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73D910F038
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 07:48:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LII1Jqj9Z204bbUMBARZSbVIXFJRy5n5sK+24dahCw/+Gn2JxXIQkPJD4xmB9kuSbNXzbqsFJtVEMjJZb7h2zzXqWdrXrMuXMPhOVPR0KsPoB/jt76CSbr/YX3jgH/9XLLAAqRvU41+PKV6oAWmF+pd16htxBIgLAKGxXggaIjhqtHadAYsNxIPnNbBHylPJopXQZNzFfnimoyFKahHxCpTNqQVniJsutGeeRgSVOuByTpi7qTae7KpedVXwVw/1mzCQmm3Tl/qLve5jrp4ytSNPFGMOEWIONttMIbyJ/5vREqY/7RDzE4y3n1poKVt9kSVDhAUCltUeRmxzXB6r4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfcHZ3kfecQX/7LP1CSijYdszYGEJi5/+UgMRhyY0Ss=;
 b=mLOLFi4C29m1uAQMW5FWXDoOMEUWpFO+olZz6mJR/+TTeKY1nhBuS186O/HmEo8l6rPFEooHph7O0P1Suap3vpUeE3FPHB7NcdMvcDxLKoTIcWE8shBcIFGatuxvRbfVELcrSswRHuYYN/DzABd0q9kjNBtqy9IAaZzAxYUJZPVoT8BRDFs5mfdkKgsygyb6RAY/MdcsYcJQflFJhWG5sp3R8ahA09fuzgSSmNqMedoK2tGC69EnhHFvxw+uQg4jPJj837Klhepn/3YGQgSXQr0WWilq1gDIidlHTY0NtyYLShao6INvft4qnwO6zSkjQ61ANdhCBrXtcx0pX501MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfcHZ3kfecQX/7LP1CSijYdszYGEJi5/+UgMRhyY0Ss=;
 b=lVWS0Xziw425gRXFmK1UZL56FFT6vJgaDsbdizaIzEFnprgiWhx5x3UDqbggzq3KzUtbLCmEFWFWXCzSN2ao+Ke3kInbQxTDO4NgR1brP+Ggo9sW+fYcpZ8Z8JxAZj7QY4/SC2pH0BvQiDVxXSLu5cAtYYyyOsQMxFLzp0W9VR4=
Received: from MW4PR03CA0287.namprd03.prod.outlook.com (2603:10b6:303:b5::22)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Mon, 11 Apr
 2022 07:48:01 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::da) by MW4PR03CA0287.outlook.office365.com
 (2603:10b6:303:b5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 07:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 07:48:00 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 02:47:57 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix the deadlock issue observed on SI
Date: Mon, 11 Apr 2022 15:47:32 +0800
Message-ID: <20220411074732.36486-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22ee3018-925e-41a8-e2f7-08da1b8f99dc
X-MS-TrafficTypeDiagnostic: BY5PR12MB4049:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB404979CB78A39DC420E238C6E4EA9@BY5PR12MB4049.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHWWwgq/s4BhsF5gdgKDM10NE9qNKgK5CVedxdXU7RojDSOT9+G6SFJNSrhyz1bV+h7V041Ra1G29mFFZ1iyQ9nC8R1Lcej9Ich8t3Wcqn0pazEUq87RuTzYduJiGtbBNDAxKW4kd4xXt2rp/iJ/qVBnOC8tJhDEt9zorVaMUNvONG5awzzpg2ymcqA04+u8lKaiBUuSQcVaBVpqxC0LnAsna351EPzdGy31FeIgTf+YOWBkkbSjp98m+R7xbWuOJfGlMPwNxQv6sJwIqugoDPUo6G0kdwjhOPfPL9Ad3D5Bq+TWth/Vtq553gWq0pJcncZdyisa8j+cNA/oIyNNSwIuk3ntoyPPQPaZDa50eppg51WbsxK0xv9nKrRc2f4JkUWCtsbgzYWrsS/OSZYHK+fjJsHVkQCO3c6qrg8b29OgkVmZB04G/bdoIIFPjyXHIZbGkOoauBUQFkJ+dmFE/3t/ONY1H8vBrz+sUsrNMlwhpjCn+t2rx/zTBzhUGJfUj69X4oapvJcP5kAmSpCqplWnqUZh+vuXsP1J49pHhw7BPhh1repqqB3UtQT+fS50trG9CO0HVKgRzVN50QJMRGt0izRxGyLoWnBF4lNgxsFZeegXQ7XOt2do9P3hqRVhsOlZh1ZnSOUqLk/EanGSwgct39cphvRiTBQtat4/gzaT4mZPquaSRLCubz18Xh1CPmfHJfhEcqs3KQwl5CLfG9iJ61z1Fik4VfD213UzYRU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(5660300002)(8936002)(316002)(44832011)(2616005)(186003)(16526019)(1076003)(26005)(2906002)(336012)(426003)(356005)(81166007)(82310400005)(40460700003)(36756003)(86362001)(36860700001)(83380400001)(6916009)(54906003)(70206006)(6666004)(8676002)(4326008)(47076005)(70586007)(508600001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 07:48:00.0291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ee3018-925e-41a8-e2f7-08da1b8f99dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 arthur.marsh@internode.on.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By placing those unrelated code outside of adev->pm.mutex
protections or restructuring the call flow, we can eliminate
the deadlock issue. This comes with no real logics change.

Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I75de4350d9c2517aba0d6adc12e1bc69430fd800
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39 +++++++++++++++++++
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 10 -----
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 35 -----------------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 -----
 4 files changed, 39 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5504d81c77b7..72e7b5d40af6 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -427,6 +427,7 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int i;
 
 	if (!adev->pm.dpm_enabled)
 		return;
@@ -434,6 +435,15 @@ void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
 	if (!pp_funcs->pm_compute_clocks)
 		return;
 
+	if (adev->mode_info.num_crtc)
+		amdgpu_display_bandwidth_update(adev);
+
+	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
+		struct amdgpu_ring *ring = adev->rings[i];
+		if (ring && ring->sched.ready)
+			amdgpu_fence_wait_empty(ring);
+	}
+
 	mutex_lock(&adev->pm.mutex);
 	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
 	mutex_unlock(&adev->pm.mutex);
@@ -443,6 +453,20 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
+	if (adev->family == AMDGPU_FAMILY_SI) {
+		mutex_lock(&adev->pm.mutex);
+		if (enable) {
+			adev->pm.dpm.uvd_active = true;
+			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
+		} else {
+			adev->pm.dpm.uvd_active = false;
+		}
+		mutex_unlock(&adev->pm.mutex);
+
+		amdgpu_dpm_compute_clocks(adev);
+		return;
+	}
+
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
 	if (ret)
 		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
@@ -453,6 +477,21 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
+	if (adev->family == AMDGPU_FAMILY_SI) {
+		mutex_lock(&adev->pm.mutex);
+		if (enable) {
+			adev->pm.dpm.vce_active = true;
+			/* XXX select vce level based on ring/task */
+			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
+		} else {
+			adev->pm.dpm.vce_active = false;
+		}
+		mutex_unlock(&adev->pm.mutex);
+
+		amdgpu_dpm_compute_clocks(adev);
+		return;
+	}
+
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
 	if (ret)
 		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index 9613c6181c17..d3fe149d8476 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -1028,16 +1028,6 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 void amdgpu_legacy_dpm_compute_clocks(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int i = 0;
-
-	if (adev->mode_info.num_crtc)
-		amdgpu_display_bandwidth_update(adev);
-
-	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
-		struct amdgpu_ring *ring = adev->rings[i];
-		if (ring && ring->sched.ready)
-			amdgpu_fence_wait_empty(ring);
-	}
 
 	amdgpu_dpm_get_active_displays(adev);
 
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index caae54487f9c..633dab14f51c 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3892,40 +3892,6 @@ static int si_set_boot_state(struct amdgpu_device *adev)
 }
 #endif
 
-static int si_set_powergating_by_smu(void *handle,
-				     uint32_t block_type,
-				     bool gate)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	switch (block_type) {
-	case AMD_IP_BLOCK_TYPE_UVD:
-		if (!gate) {
-			adev->pm.dpm.uvd_active = true;
-			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
-		} else {
-			adev->pm.dpm.uvd_active = false;
-		}
-
-		amdgpu_legacy_dpm_compute_clocks(handle);
-		break;
-	case AMD_IP_BLOCK_TYPE_VCE:
-		if (!gate) {
-			adev->pm.dpm.vce_active = true;
-			/* XXX select vce level based on ring/task */
-			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
-		} else {
-			adev->pm.dpm.vce_active = false;
-		}
-
-		amdgpu_legacy_dpm_compute_clocks(handle);
-		break;
-	default:
-		break;
-	}
-	return 0;
-}
-
 static int si_set_sw_state(struct amdgpu_device *adev)
 {
 	return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_SwitchToSwState) == PPSMC_Result_OK) ?
@@ -8125,7 +8091,6 @@ static const struct amd_pm_funcs si_dpm_funcs = {
 	.print_power_state = &si_dpm_print_power_state,
 	.debugfs_print_current_performance_level = &si_dpm_debugfs_print_current_performance_level,
 	.force_performance_level = &si_dpm_force_performance_level,
-	.set_powergating_by_smu = &si_set_powergating_by_smu,
 	.vblank_too_short = &si_dpm_vblank_too_short,
 	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
 	.get_fan_control_mode = &si_dpm_get_fan_control_mode,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index dbed72c1e0c6..1eb4e613b27a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1503,16 +1503,6 @@ static void pp_pm_compute_clocks(void *handle)
 {
 	struct pp_hwmgr *hwmgr = handle;
 	struct amdgpu_device *adev = hwmgr->adev;
-	int i = 0;
-
-	if (adev->mode_info.num_crtc)
-		amdgpu_display_bandwidth_update(adev);
-
-	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
-		struct amdgpu_ring *ring = adev->rings[i];
-		if (ring && ring->sched.ready)
-			amdgpu_fence_wait_empty(ring);
-	}
 
 	if (!amdgpu_device_has_dc_support(adev)) {
 		amdgpu_dpm_get_active_displays(adev);
-- 
2.29.0

