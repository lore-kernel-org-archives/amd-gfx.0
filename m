Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D383E748F6
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 16:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F6110E2E8;
	Mon,  2 Oct 2023 16:29:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 234D910E2E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 16:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuNDXb/okB67b1pqCT0ZPt5eVzL0+RS1hqLbE6FHZtxd10IpoN5Rjx9HafrG+I54u2lmFThh7eis6BtBJdJNTidthD/aIEqtYY155Y91GKuk12yooMVRLHjvnC/zopCsGsEQX/HxJneLJQKP9YuPmOIZJ6fQh34zoCHjIosV3TgjdGfVsDgLBoOSbtlh2mjum9xxrJKdTu5M0SjzThLYmmmMt37+lv80YQNoqxMw7uT9HshPt8glbPbB+UBVKk15pql99PCq3Dl7I0hBoC6qsZ3a1iYi80bqzwo1xffgnppgVxDCQiY4hgbvXVArSxafXFhKfJy+CrFI8tXltqrKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryapMWPLlCX7txU3x8pvUzfAW4ZpzNPjdBzhXwr0JPU=;
 b=a8oJZVj6HlnuRsiwYgaVk4dtp7qH55SUxepVFe9OnxvmE7a9aVeATqge+I5WatFgncCdBasLa3DSXJ6DLK2mUDB9DzEtkAfuArlO4xTzsWPkoq3YHEZc+SNIHf3m75m1lEz3q3JLuQ7e+lbR2xO32ZClNmj4afyDKgxRNJjzLk6V1/8fsZc04VcX/31r2wxpVmzkn5akKP7D6mSo7mNOtTQDJt4NcZ6ULoVRrFIB3YommxKfqLOWYCCF0ZJ/wy138XpnQWSMVVt5BRQaj700GVbbLzg34n2OUap3MfBlMpptnkrU7fPt+q/lVQ9jBiqM/cBHKx8d/tWjvYlu63K8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryapMWPLlCX7txU3x8pvUzfAW4ZpzNPjdBzhXwr0JPU=;
 b=hpj/5OprFHNTsoK8b+BOKtM+ZP/xinYBmYO7Py9x2WOPgADy1MWCyEGzTcgCW1BjcOq02CTg79YR53O/0udYDnuJJwnRSETpXO7eMJQpjvtQcOVw34oscO+Py+EL2//dC79z9oRqZBqiLHu69F1udfrx4reXvInfhNCq+KmxESw=
Received: from BL0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:91::35)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 16:29:48 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::2d) by BL0PR05CA0025.outlook.office365.com
 (2603:10b6:208:91::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.21 via Frontend
 Transport; Mon, 2 Oct 2023 16:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 16:29:48 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 11:29:47 -0500
From: <ivlipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/display: Enable Replay for static screen use
 cases"
Date: Mon, 2 Oct 2023 12:29:29 -0400
Message-ID: <20231002162929.196007-1-ivlipski@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: d409eda5-4f10-49f3-847b-08dbc364cba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dg95z2+HIZLSzDspNgoYKO7UU88lVoZEtoI9H+H/cBbNjKAWfUfsjBiC5wSKVHTMENA8XyObXl429Y+F60rQVxYn9/rx8fBhesy1+j9W60xSjnwwUIEAhyA8NRwCVYjCe4TYuKIDGprQ+SpggjB8HCaAgCYIZyOY8wq/Op0dZov86HWI8y6YDFVsa+tU+C4R6uEpq6iD4JdTZmf4ruI2lmXw3L3EKvp2aXVlRbNAhfnmKEBgcFQr15gjSBS4C9fJCq8P9aKAPFv3bdwFtWu4cMFVinUG5n3i8eHuAM7zMRbM/AkGMR0lOlT7qjQyE5eqTOam8iay89t3otLiz3VmlXy0Hh6n2ePa/mUHBdK18LUj4kq0p/ycW4bT5TscQOxCcFNZweML5wd0whwMYl5yiC4a3yp7oxYWcMUDgvhNh/lCnX5RhddFaQzfLdc/eybNOZr6nRMGE84I8pi4UxS5WYITwu5NMMyd8hAN4oKnzznLS0WFOHe8AGKnjDa6Khuzhr8Oz2juQrgKJN7KvMei23mkQrpxwbSeOhs8RgWqJkNa073ZQEcsQI61L78+mS4SWv10Dch0YTM1GGQCgIr7ucfSG5pmTGhFDI0EvsUDHmdqrkBiOOBwu4KDWOnZE/Nzw4wV0Hb6UThqwxb4RLu2b+CPVEP7i16GtpdhATF9971QAqjD9PoQls8jYevRidXV/bZBLWE5CAt3SA3eLSMqnbvm3xRU+RUiT21+r8LdwHX7AZ4wkXh4e2kCe/eKPbQBckQ2oNoXUQffGxwp5/TShQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(4326008)(8676002)(8936002)(70206006)(70586007)(5660300002)(41300700001)(54906003)(6916009)(2876002)(356005)(316002)(83380400001)(82740400003)(81166007)(6666004)(2906002)(336012)(26005)(16526019)(2616005)(1076003)(426003)(36860700001)(47076005)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 16:29:48.3159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d409eda5-4f10-49f3-847b-08dbc364cba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
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
Cc: Ivan Lipski <ivlipski@amd.com>, harry.wentland@amd.com,
 rodrigo.siqueira@amd.com, hamza.mahfooz@amd.com, alexander.deucher@amd.com,
 Bhawanpreet.Lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ivan Lipski <ivlipski@amd.com>

This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.

It fixes amd_psr on eDP panel without Replay support
(<=0x03 Sink support)

Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 -------------------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +-------
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
 3 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5372073a7472..b1245b732cc9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -65,7 +65,6 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
 #include "amdgpu_dm_psr.h"
-#include "amdgpu_dm_replay.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -4266,7 +4265,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 	bool psr_feature_enabled = false;
-	bool replay_feature_enabled = false;
 	int max_overlay = dm->dc->caps.max_slave_planes;
 
 	dm->display_indexes_num = dm->dc->caps.max_streams;
@@ -4376,20 +4374,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
-		switch (adev->ip_versions[DCE_HWIP][0]) {
-		case IP_VERSION(3, 1, 4):
-		case IP_VERSION(3, 1, 5):
-		case IP_VERSION(3, 1, 6):
-		case IP_VERSION(3, 2, 0):
-		case IP_VERSION(3, 2, 1):
-			replay_feature_enabled = true;
-			break;
-		default:
-			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
-			break;
-		}
-	}
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
@@ -4438,12 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 				amdgpu_dm_update_connector_after_detect(aconnector);
 				setup_backlight_device(dm, aconnector);
 
-				/*
-				 * Disable psr if replay can be enabled
-				 */
-				if (replay_feature_enabled && amdgpu_dm_setup_replay(link, aconnector))
-					psr_feature_enabled = false;
-
 				if (psr_feature_enabled)
 					amdgpu_dm_set_psr_caps(link);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index fb51ec4f8d31..440fc0869a34 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -29,7 +29,6 @@
 #include "dc.h"
 #include "amdgpu.h"
 #include "amdgpu_dm_psr.h"
-#include "amdgpu_dm_replay.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_trace.h"
@@ -124,12 +123,7 @@ static void vblank_control_worker(struct work_struct *work)
 	 * fill_dc_dirty_rects().
 	 */
 	if (vblank_work->stream && vblank_work->stream->link) {
-		/*
-		 * Prioritize replay, instead of psr
-		 */
-		if (vblank_work->stream->link->replay_settings.replay_feature_enabled)
-			amdgpu_dm_replay_enable(vblank_work->stream, false);
-		else if (vblank_work->enable) {
+		if (vblank_work->enable) {
 			if (vblank_work->stream->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 &&
 			    vblank_work->stream->link->psr_settings.psr_allow_active)
 				amdgpu_dm_psr_disable(vblank_work->stream);
@@ -138,7 +132,6 @@ static void vblank_control_worker(struct work_struct *work)
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 			   !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
 #endif
-			   vblank_work->stream->link->panel_config.psr.disallow_replay &&
 			   vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
 			amdgpu_dm_psr_enable(vblank_work->stream);
 		}
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 67d7b7ee8a2a..abe829bbd54a 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -240,7 +240,6 @@ enum DC_FEATURE_MASK {
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
 	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
 	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
-	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
 };
 
 enum DC_DEBUG_MASK {
@@ -251,7 +250,6 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_PSR = 0x10,
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
 	DC_DISABLE_MPO = 0x40,
-	DC_DISABLE_REPLAY = 0x50,
 	DC_ENABLE_DPIA_TRACE = 0x80,
 };
 
-- 
2.25.1

