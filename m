Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAA0E74902
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 17:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDA7A10E05A;
	Mon,  2 Oct 2023 17:48:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99FA910E05A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 17:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxmszYFSIbMe3qFD2eewYVKi7vj7YMKLIQvmVDqSvQ4icVyNCPatBnndrPv8updFQHHAZTckm2ZwS1Qt4yRULBewwR4a/jyDe1DsQ8lATRoy5//25S0XG4uI9i8WfzOlyBZYM15TPBjgSlDt7N28B/vZChX7j4opDOcQzLaOfYa5BVyZYWGV16TinxUAs2wWQ5kA+hp+9ofieR/L3rVzg/bjOy9+gHtZp2teSjRqlIx+YMxDakjFmw6kEkS2re3V5Xb4n1yKbp2rUKNHc38GvyUjNNE3+D3aFAqQ/pG7UaHokQbdswpB39XZh1gYd2d5dKy98B2nfzfnDA1eJ1+zLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/n2VC+c7jltETj7IGlI0MuG4jLt3vbNyHSbfKKwyGU=;
 b=X222APgy4TTzgvegSY7BmqCtrUMeXl1rEmnKFcaUBpTvKvdVo9puRGJLtV7btcdXoSlgR9+ZkpKolqOvL8JGXaSWxkatPknLixntmGxHAVaUIOMou1UJVfRJCmCK0vEH4wd+5v2Jd0NaiKRhYZn8QTEoKNjgcMRzZX8xvSwi2ggng8aY3Wac8IB2GcpQdmijdBM/QWD9bmDpocOHsf5x77YtVgMdWZRG6l8DBnLkBFUTKvUVyPQ/fdE66T+BbmO0l74sxWMxqQv0FxiIC6S6J2/AplADhKneZPZj5Qa5PzmexXd/lleHvJJ1l9qH2dWacxrSelWqVOBGTB4KdEZUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/n2VC+c7jltETj7IGlI0MuG4jLt3vbNyHSbfKKwyGU=;
 b=kmUUMK4Uhr9+2qSV8DQ0+/vW17G845TnQXyuZocJxRyK1m3Z7Sg2z7UNvq66j/hBXS7tuOaLUNLMpJIXJ7JiPQZh1Pk0q02IiFMhANoiZna3Q79E563wh+mKK6fGbuzclwFyBL8Jc56/gdAKvIXA6vxs8uxPVCFS7OUOVfRTXIw=
Received: from SJ0PR13CA0108.namprd13.prod.outlook.com (2603:10b6:a03:2c5::23)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Mon, 2 Oct
 2023 17:48:16 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::52) by SJ0PR13CA0108.outlook.office365.com
 (2603:10b6:a03:2c5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.21 via Frontend
 Transport; Mon, 2 Oct 2023 17:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6863.9 via Frontend Transport; Mon, 2 Oct 2023 17:48:16 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 12:48:14 -0500
From: <ivlipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] Revert "drm/amd/display: Enable Replay for static screen
 use cases"
Date: Mon, 2 Oct 2023 13:47:54 -0400
Message-ID: <20231002174754.1596197-1-ivlipski@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: d949ff88-d9f0-4208-4898-08dbc36fc1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tirRK2M+7oF6sFf5S5YNhHFuWH8dmdmq9UW9d12gj+PToumhm2wx/7y4s4bvV5poxdyHWKiIEg1cYTglahqc4rZ7BjhQG+ZZJOnWUrWa8DLxHRneB/mbEXk+v+gZzgeRCevwVUDx29E2g3suaEy/xuHAa/Z4CxBKhJ+pMx6upaU10Lvx16ZUoPhxhdwQMLccDaqP1hxx8EnzfqY9qc9HMO/lRhZPuY20sXMbrStMDiu+/P2zKJcaOw+elE/4MR+Gx+2eTX8SMOJOZ3wej0Z3tDCcVOBWFPXbUk5FBXMufVSgdQiz9fjzHw3JFpZ1ZQWdNRJLCAD5A3T1Mmu4MabrIsxEIoGqHJBpGItwLaImIXl4XgAg72lFs0ZPJOznOCzx/ElDRQbY9Z786qicGFwY6kyiJ0wku117463hIeAOQZZz0wLk/Ar8Fw8M3z3ZYuHxllT30y4O+IPyMoSnXiV6lVWcbIotpmlhcdIb8HB4tH/H3bgoeYQ7fA8hovQ4r96sjbabrmf3msceOKuv6LbO6jdtl1YAmkXetBQmUSHh/9AQ7b4QLFOith5LFzZiYONbQ8hq1429yxhSf7WGxTiCjbUr1jt/R4dJuqLLfmaQitsSRja054Sf5R4lDnTXYMCEPCza6ESfeLsYF52mddQnXhhRnaSFoppNaOfCygrepYwZvu1i5Y2jBhOmJFU2M18R5V+ERusHq+MucW/ZUViRDSNRH5pjkpvsVo3raGkV9KrWVrmlKFrTmRD/bJqYqKq2ew7DYyfygRWmqfyk9TOV5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(2876002)(1076003)(2616005)(356005)(478600001)(6666004)(54906003)(6916009)(47076005)(82740400003)(83380400001)(36860700001)(81166007)(26005)(16526019)(426003)(336012)(40480700001)(70206006)(5660300002)(36756003)(8936002)(316002)(70586007)(41300700001)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:48:16.3469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d949ff88-d9f0-4208-4898-08dbc36fc1f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
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
Cc: Ivan Lipski <ivlipskI@amd.com>, chiahsuan.chung@amd.com, sunpeng.li@amd.com,
 harry.wentland@amd.com, rodrigo.siqueira@amd.com, hamza.mahfooz@amd.com,
 alexander.deucher@amd.com, Bhawanpreet.Lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ivan Lipski <ivlipski@amd.com>

This reverts commit a92da5bc33ea99a861f6c422192af6072c145d2d.

V2: Reword commit message

[WHY]
This commit caused regression in which eDP's with PSR support,
but no Replay support (Sink support <= 0x03), failed enabling PSR
and all IGT amd_psr tests.

[HOW]
Reverted the patch.

Signed-off-by: Ivan Lipski <ivlipskI@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 -------------------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +-------
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 --
 3 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 32156609fbcf..f69b2e9ecd98 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -66,7 +66,6 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
 #include "amdgpu_dm_psr.h"
-#include "amdgpu_dm_replay.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -4423,7 +4422,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 	bool psr_feature_enabled = false;
-	bool replay_feature_enabled = false;
 	int max_overlay = dm->dc->caps.max_slave_planes;
 
 	dm->display_indexes_num = dm->dc->caps.max_streams;
@@ -4535,21 +4533,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
-		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
-		case IP_VERSION(3, 1, 4):
-		case IP_VERSION(3, 1, 5):
-		case IP_VERSION(3, 1, 6):
-		case IP_VERSION(3, 2, 0):
-		case IP_VERSION(3, 2, 1):
-		case IP_VERSION(3, 5, 0):
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
@@ -4618,12 +4601,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
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
index 314fd44ec018..ce75351204bb 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -244,7 +244,6 @@ enum DC_FEATURE_MASK {
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
 	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
 	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
-	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
 };
 
 enum DC_DEBUG_MASK {
@@ -255,7 +254,6 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_PSR = 0x10,
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
 	DC_DISABLE_MPO = 0x40,
-	DC_DISABLE_REPLAY = 0x50,
 	DC_ENABLE_DPIA_TRACE = 0x80,
 };
 
-- 
2.34.1

