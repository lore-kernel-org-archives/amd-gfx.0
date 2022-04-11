Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8037DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 08:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2822710EFA2;
	Mon, 11 Apr 2022 08:55:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7582310EEA7
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 08:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTxnrDaCTmv7OlvcouCgSRIibLsPtF1zZRQsvwG9YkHmvM68Mhb0skrvvUpkwu32yEQZV3HgesGTdnlhFVxorqwzsjP/07DcmokAbfq/qrpYe3bW7JbE3yxnPKvPwLvU4gQWFQMdrFhFGKJPELrSdQguv6DLzFPb60IL1+hjSKwdua2sdj0a9y0CpC8MiGKAuTPJCIXboP47/+YNPnOlB7OmjtpUZyC0IMinReqt1HZVlsAE9no9gvWTiVyXiVu6DcF6BC666XU+zy8EYvd4mzZhlkJI8ld26bmt0gc9tTL57af0cfUjIIj9KI+Pip44KjjEVhsFJqqy22m27wwq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vdZnjc0/DSwVMytK4qKCdVdemNszo/QOB2gf/cbOBo=;
 b=XxuaU8NXDqNT//LfMGHkQM0Yud5Ss1JeZSNIb6bibKJgzm+iRp/Xez8scTgeTNgspf1pJpcfs2N572bmdzWFWLE6Yi6kMu5AgDJxZbRs5XM2NMx9Py8EddCQwTkfNghYNe1SUpsAfgSDimgry3aao5hQdcHxpgKJ79p3Hp4QWE5oNwjalla7FSeFUDcG3pr2ujXvO1UIa9EjK2FjvcTQux/vEkTC+1C2GmCx7PNXpPtyYQGNAq4PLAqgTHe1Bwaot3VI5gqvVahz6iPxG95zepZW6Djes5UBLWxJmFLZj5uNjux8nuxJJAVw6Crn5ZlC22ycAWk9nlQUHe8jf+kdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vdZnjc0/DSwVMytK4qKCdVdemNszo/QOB2gf/cbOBo=;
 b=4QmnbWLHFsvtrsWYBrQ2aeWVavALcWHj9WLF1PweHgQn8ECJuai19n+2V7xojXQTz9Gcqax2vMHVQ0XpPYh3fn659loCOjK89HpNUIGski08g8LUA0Atm6gT5+WCJFvSeYJDQq2qTJ9fRAuumvKd0quSiHUM02B3NE6JXL/tyoo=
Received: from BN1PR12CA0027.namprd12.prod.outlook.com (2603:10b6:408:e1::32)
 by BN6PR12MB1522.namprd12.prod.outlook.com (2603:10b6:405:11::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 08:55:19 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::89) by BN1PR12CA0027.outlook.office365.com
 (2603:10b6:408:e1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 08:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 08:55:18 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 03:55:15 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amd/pm: fix the deadlock issue observed on SI
Date: Mon, 11 Apr 2022 16:54:53 +0800
Message-ID: <20220411085453.38063-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9ee6784-2aec-4a7d-bcc4-08da1b9900f6
X-MS-TrafficTypeDiagnostic: BN6PR12MB1522:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB15222BE4914B805EA73839E6E4EA9@BN6PR12MB1522.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCBF9MUrWwzqeXuaYGjOPP7crO062AaEVzUC0zykogZeRWSUIM4H5EqhNqdoYuSm/fKG1wd4Su15thf4CS7hZyRuL5HFGd1fvKN6BUVfzJMfV2HGnPsbahsYddFtCe2tKQ50elPkIafZYDX6s82+XWr/IgLiDWQAwJr0zWBmIdS2AtpMI3mMSrEaqYCvZaVzlLW629ljbj64f1SVVGdwd69XODb5zMzcC8sD97ZHb4h7fsR2unZofB1QpNDM2N6RiHr6sydUhYYR6mypjr5UMowlNxIQz2XAM9HFKAE8MzLPqFdWowfYq1Ubg26uL++6Qqzt3oNyod7hwGuJZfVnihng+n3Ysjqn1QhlEEneSnOJFp/DM2mFUdLmu9FvnB59oZs/3NPzlBTlbNDQp5KVZldSEeKZtFQmuE9vBiJlOB1+hLUL1hTU1L5IKZDRC6cLmooHYoxp1fwASzIniTZm8qwcepMPV9afuyWmRPb8DtKCMEQm5Rj31181Ii7aN/VdWQXWKpUdOYmbdVrx/2kXZ3lSH2yP1DMyrpMWGOAemH+yFNuqmXUlPHDW8LT3E/2JxqH5J9kO6F1T9FoWe11yqIgdxCmj1gA/oICcqoZqDUVxnfXcN8LucT2bivWAWf7zOc6/Unz/Lf4b2DQ3mlztLw1BWWNcWN+rbTswY4REH3AVTc/6gC0WDsF1HJFbTJbvq/LcxPElzqn7Ms/8wj47uWSmGLULAFndVEhShKNZAJc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(8936002)(86362001)(186003)(426003)(26005)(40460700003)(2906002)(356005)(5660300002)(316002)(7696005)(1076003)(6916009)(508600001)(36756003)(2616005)(16526019)(82310400005)(6666004)(44832011)(54906003)(36860700001)(47076005)(70206006)(70586007)(4326008)(8676002)(83380400001)(336012)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 08:55:18.5525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ee6784-2aec-4a7d-bcc4-08da1b9900f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1522
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
Cc: Alexander.Deucher@amd.com, pmenzel@molgen.mpg.de,
 Evan Quan <evan.quan@amd.com>, arthur.marsh@internode.on.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The adev->pm.mutx is already held at the beginning of
amdgpu_dpm_compute_clocks/amdgpu_dpm_enable_uvd/amdgpu_dpm_enable_vce.
But on their calling path, amdgpu_display_bandwidth_update will be
called and thus its sub functions amdgpu_dpm_get_sclk/mclk. They
will then try to acquire the same adev->pm.mutex and deadlock will
occur.

By placing amdgpu_display_bandwidth_update outside of adev->pm.mutex
protection(considering logically they do not need such protection) and
restructuring the call flow accordingly, we can eliminate the deadlock
issue. This comes with no real logics change.

Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
Link: https: //lore.kernel.org/all/9e689fea-6c69-f4b0-8dee-32c4cf7d8f9c@molgen.mpg.de/
BugLink: https: //gitlab.freedesktop.org/drm/amd/-/issues/1957
Signed-off-by: Evan Quan <evan.quan@amd.com>
--
v1->v2:
  - rich the commit messages(Paul)
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

