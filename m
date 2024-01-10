Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54794C4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21EE10E767;
	Wed, 10 Jan 2024 21:57:24 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7759810E767
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czaduhGXkirpuoyrg2Rsw/SR7sXkrToYGJVggJ9rsB/r2kDlxobaixd8tCj0U0YhiS7DzRRg6HsYWNWqwYkz/39XIWMJ4vMHWBV9HE0ZuQMdYiw9Igu5OcLmOdtnCRG1P8emATa4PvRO1FGBBQNJEqGT66OU4OQmwyzulAcuVKmzXuuZDOf6/PUdmeLSdPd65M53S1MlDBJoHXIJdY4+A2hZRU0Ldpdy4ZnwG4SvNj4l+B9GG6tO560t9/61vtl/2vhMHCpg6ahhZqgP1jyV69PsoRsYOWHNDCTpNpfdAKnr9nS9avCi/SYS+TUfCKu6ErHnL/A8p3Ky2TYfVgpfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMepapeakWnuXJpMkvgL1QdLAcmIYUzN8alfsNm02as=;
 b=Ii00KEWn/09RzhJKrcufnyEa4sJk8Bbebh1qZj6FXS8ZsXAvrqDif0jpZRhOJAIiddntP7agNRkYnHzXNi8eftv39FrlImb7DkxnGlWSqwxDxmXQBjuO4Zd+v0p82/Zv4vVwU+abTWhYOmdT6WKcQRrCgin3+gmBc+dGHjxrw4WQEcGxR8gBnb3ApRO0gkRoqnh4bl17NEquRNwEvEEiolYgNAQasN93YJaJ487NLmmDkVWfCHBX1CMzXHHv6SXAfpbPTQsFk5gAfV6BOBCu5uBYl8Umuod6uGgLJh+Fj63YsTNnzvl4XSVDf/GpAyzv2fZx4N9V74wFz1blAHQdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMepapeakWnuXJpMkvgL1QdLAcmIYUzN8alfsNm02as=;
 b=gEUQRCnupqdCjIN21gxC1fqv1B9pxrIDZ104HS32ZGW4A9M402C5IBsBHLrVvx+ZC/+fYxM2ZtWaSYdr54Z11VDfpn8AXmbDxsOF1mzURTy9u80XjmQc/5RaQoLutVX/idJNUnfTDQeoNksqSl0ttzVSczA8FmFDMY2Kiuoig/0=
Received: from DM6PR08CA0060.namprd08.prod.outlook.com (2603:10b6:5:1e0::34)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Wed, 10 Jan
 2024 21:57:20 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::ed) by DM6PR08CA0060.outlook.office365.com
 (2603:10b6:5:1e0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 21:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:57:20 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:57:17 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/19] drm/amd/display: Enable Panel Replay for static screen
 use case
Date: Wed, 10 Jan 2024 14:52:57 -0700
Message-ID: <20240110215302.2116049-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|BL0PR12MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3d3066-f04f-444f-9ca7-08dc12271e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gZRqEuCGr/gBAm952wFcZrAKBVIj4UWKv/TGqPoyPRhDGXA2Hep9Wv8FROeZ5SD6QuuJqxqUFB23k60TR7WBFigcbbG7jTd5w1gmQ3RS7A/mKU7xcvRezZRXcT9JhOmFcAOjUkmHNLTf6BionxOsG6xyYWAl3XSmYe/SzdHRJmq62thRrj2Pf9GEge8ElbgOWTit4GlloIwx25AzA7cmKl4TCnxNf50v0tnOzWp3UvJZntS1KqLvoPnNZI1BfylGClBSDUempaGQEGRjVLYh4/qpf61YvAxSP8nc6uGCDqCxKpPB8A7ckHR6LdZqM2XzkOkGcyHcr7v3HOSn9g4qKRBJYcEszxNJnwLXQBy4cqobf2W5uiuuHxw869b+WuTeHAo5iRAC2s5w7zQ8k3rc5cWeATVuSMc9qlgL3Ho7HPNQ/J5hHx/3zYkFjGw1PYzKMw0wdjishZNptrlLP/hvjXcwPnPcgftoLOlLFAVBYIqwUC+D1LEPQC7KY96ZC+6tVS4HKbF423nKKRuK85Zt51KjvVqE7H8aBrg9iddhT4U+EImVKkIa0KxIyaYDF9y2ruNWfd4SBw9JVsWU2FEDZZauuDjDWCcSDDyjF+1txw7Zotazhkq9tGWYmDLSAQOUua6Ykv2h8yYozmJrqZrkzgDJTXqF8P6TSXQ18sfvVoEb/Fg1xgCboEIBN6UNAVwmWIdK5FB1qxXu5o0MKNGE1WAOxWSkmb/mYq/6y2PrCqlj1hU9TLlALJPb1OX5jNPalMpa5qr2+Kkr2Bol+eOhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(2616005)(26005)(1076003)(16526019)(478600001)(6666004)(336012)(426003)(7696005)(36860700001)(5660300002)(83380400001)(47076005)(30864003)(2906002)(44832011)(70206006)(41300700001)(70586007)(8936002)(4326008)(8676002)(6916009)(316002)(54906003)(81166007)(356005)(82740400003)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:57:20.0479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3d3066-f04f-444f-9ca7-08dc12271e4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sun
 peng Li <sunpeng.li@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alex Hung <alex.hung@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
Enable the Panel Replay if eDP panel and ASIC support.
(prioritize Panel Replay over PSR)

[How]
- Setup the Panel Replay config during the device init
  (prioritize Panel Replay over PSR).
- Separate the Replay init function into two functions
  amdgpu_dm_link_setup_replay() and amdgpu_dm_set_replay_caps()
  to fix the issue in the earlier commit that cause PSR and Replay
  enabled at the same time.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  42 ++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  59 +++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 119 ++++++++++--------
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |   4 +-
 4 files changed, 156 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 95ff3800fc87..f9e41006ac87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -67,6 +67,7 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
 #include "amdgpu_dm_psr.h"
+#include "amdgpu_dm_replay.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -4393,6 +4394,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 	bool psr_feature_enabled = false;
+	bool replay_feature_enabled = false;
 	int max_overlay = dm->dc->caps.max_slave_planes;
 
 	dm->display_indexes_num = dm->dc->caps.max_streams;
@@ -4504,6 +4506,23 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 	}
 
+	/* Determine whether to enable Replay support by default. */
+	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
+		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
+		case IP_VERSION(3, 1, 4):
+		case IP_VERSION(3, 1, 5):
+		case IP_VERSION(3, 1, 6):
+		case IP_VERSION(3, 2, 0):
+		case IP_VERSION(3, 2, 1):
+		case IP_VERSION(3, 5, 0):
+			replay_feature_enabled = true;
+			break;
+		default:
+			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
+			break;
+		}
+	}
+
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
@@ -4572,6 +4591,11 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 				amdgpu_dm_update_connector_after_detect(aconnector);
 				setup_backlight_device(dm, aconnector);
 
+				/* Disable PSR if Replay can be enabled */
+				if (replay_feature_enabled)
+					if (amdgpu_dm_set_replay_caps(link, aconnector))
+						psr_feature_enabled = false;
+
 				if (psr_feature_enabled)
 					amdgpu_dm_set_psr_caps(link);
 
@@ -8521,10 +8545,17 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			dm_update_pflip_irq_state(drm_to_adev(dev),
 						  acrtc_attach);
 
-		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
-				acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
-				!acrtc_state->stream->link->psr_settings.psr_feature_enabled)
-			amdgpu_dm_link_setup_psr(acrtc_state->stream);
+		if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
+			if (acrtc_state->stream->link->replay_settings.config.replay_supported &&
+					!acrtc_state->stream->link->replay_settings.replay_feature_enabled) {
+				struct amdgpu_dm_connector *aconn =
+					(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
+				amdgpu_dm_link_setup_replay(acrtc_state->stream->link, aconn);
+			} else if (acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
+					!acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
+				amdgpu_dm_link_setup_psr(acrtc_state->stream);
+			}
+		}
 
 		/* Decrement skip count when PSR is enabled and we're doing fast updates. */
 		if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
@@ -8813,11 +8844,12 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 		}
 	} /* for_each_crtc_in_state() */
 
-	/* if there mode set or reset, disable eDP PSR */
+	/* if there mode set or reset, disable eDP PSR, Replay */
 	if (mode_set_reset_required) {
 		if (dm->vblank_control_workqueue)
 			flush_workqueue(dm->vblank_control_workqueue);
 
+		amdgpu_dm_replay_disable_all(dm);
 		amdgpu_dm_psr_disable_all(dm);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 6e715ef3a556..f64c5ffed234 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -29,6 +29,7 @@
 #include "dc.h"
 #include "amdgpu.h"
 #include "amdgpu_dm_psr.h"
+#include "amdgpu_dm_replay.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_trace.h"
@@ -95,6 +96,48 @@ bool amdgpu_dm_crtc_vrr_active(struct dm_crtc_state *dm_state)
 	       dm_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
 }
 
+/**
+ * The DRM vblank counter enable/disable action is used as the trigger to enable
+ * or disable various panel self-refresh features:
+ *
+ * Panel Replay and PSR SU
+ * - Enable when:
+ *      - vblank counter is disabled
+ *      - entry is allowed: usermode demonstrates an adequate number of fast
+ *        commits)
+ *     - CRC capture window isn't active
+ * - Keep enabled even when vblank counter gets enabled
+ *
+ * PSR1
+ * - Enable condition same as above
+ * - Disable when vblank counter is enabled
+ */
+static void amdgpu_dm_crtc_set_panel_sr_feature(
+	struct vblank_control_work *vblank_work,
+	bool vblank_enabled, bool allow_sr_entry)
+{
+	struct dc_link *link = vblank_work->stream->link;
+	bool is_sr_active = (link->replay_settings.replay_allow_active ||
+				 link->psr_settings.psr_allow_active);
+	bool is_crc_window_active = false;
+
+#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
+	is_crc_window_active =
+		amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base);
+#endif
+
+	if (link->replay_settings.replay_feature_enabled &&
+		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
+		amdgpu_dm_replay_enable(vblank_work->stream, true);
+	} else if (vblank_enabled) {
+		if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 && is_sr_active)
+			amdgpu_dm_psr_disable(vblank_work->stream);
+	} else if (link->psr_settings.psr_feature_enabled &&
+		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
+		amdgpu_dm_psr_enable(vblank_work->stream);
+	}
+}
+
 static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 {
 	struct vblank_control_work *vblank_work =
@@ -123,18 +166,10 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	 * fill_dc_dirty_rects().
 	 */
 	if (vblank_work->stream && vblank_work->stream->link) {
-		if (vblank_work->enable) {
-			if (vblank_work->stream->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 &&
-			    vblank_work->stream->link->psr_settings.psr_allow_active)
-				amdgpu_dm_psr_disable(vblank_work->stream);
-		} else if (vblank_work->stream->link->psr_settings.psr_feature_enabled &&
-			   !vblank_work->stream->link->psr_settings.psr_allow_active &&
-#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-			   !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
-#endif
-			   vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
-			amdgpu_dm_psr_enable(vblank_work->stream);
-		}
+		amdgpu_dm_crtc_set_panel_sr_feature(
+			vblank_work, vblank_work->enable,
+			vblank_work->acrtc->dm_irq_params.allow_psr_entry ||
+			vblank_work->stream->link->replay_settings.replay_feature_enabled);
 	}
 
 	mutex_unlock(&dm->dc_lock);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index 5ce542b1f860..738a58eebba7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -60,21 +60,26 @@ static bool link_supports_replay(struct dc_link *link, struct amdgpu_dm_connecto
 	if (!as_caps->dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT)
 		return false;
 
+	// Sink shall populate line deviation information
+	if (dpcd_caps->pr_info.pixel_deviation_per_line == 0 ||
+		dpcd_caps->pr_info.max_deviation_line == 0)
+		return false;
+
 	return true;
 }
 
 /*
- * amdgpu_dm_setup_replay() - setup replay configuration
+ * amdgpu_dm_set_replay_caps() - setup Replay capabilities
  * @link: link
  * @aconnector: aconnector
  *
  */
-bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
+bool amdgpu_dm_set_replay_caps(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
 {
-	struct replay_config pr_config;
+	struct replay_config pr_config = { 0 };
 	union replay_debug_flags *debug_flags = NULL;
 
-	// For eDP, if Replay is supported, return true to skip checks
+	// If Replay is already set to support, return true to skip checks
 	if (link->replay_settings.config.replay_supported)
 		return true;
 
@@ -87,27 +92,50 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *ac
 	if (!link_supports_replay(link, aconnector))
 		return false;
 
-	// Mark Replay is supported in link and update related attributes
+	// Mark Replay is supported in pr_config
 	pr_config.replay_supported = true;
-	pr_config.replay_power_opt_supported = 0;
-	pr_config.replay_enable_option |= pr_enable_option_static_screen;
-	pr_config.replay_timing_sync_supported = aconnector->max_vfreq >= 2 * aconnector->min_vfreq;
-
-	if (!pr_config.replay_timing_sync_supported)
-		pr_config.replay_enable_option &= ~pr_enable_option_general_ui;
 
 	debug_flags = (union replay_debug_flags *)&pr_config.debug_flags;
 	debug_flags->u32All = 0;
 	debug_flags->bitfields.visual_confirm =
 		link->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY;
 
-	link->replay_settings.replay_feature_enabled = true;
-
 	init_replay_config(link, &pr_config);
 
 	return true;
 }
 
+/*
+ * amdgpu_dm_link_setup_replay() - configure replay link
+ * @link: link
+ * @aconnector: aconnector
+ *
+ */
+bool amdgpu_dm_link_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
+{
+	struct replay_config *pr_config;
+
+	if (link == NULL || aconnector == NULL)
+		return false;
+
+	pr_config = &link->replay_settings.config;
+
+	if (!pr_config->replay_supported)
+		return false;
+
+	pr_config->replay_power_opt_supported = 0x11;
+	pr_config->replay_smu_opt_supported = false;
+	pr_config->replay_enable_option |= pr_enable_option_static_screen;
+	pr_config->replay_support_fast_resync_in_ultra_sleep_mode = aconnector->max_vfreq >= 2 * aconnector->min_vfreq;
+	pr_config->replay_timing_sync_supported = false;
+
+	if (!pr_config->replay_timing_sync_supported)
+		pr_config->replay_enable_option &= ~pr_enable_option_general_ui;
+
+	link->replay_settings.replay_feature_enabled = true;
+
+	return true;
+}
 
 /*
  * amdgpu_dm_replay_enable() - enable replay f/w
@@ -117,51 +145,23 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *ac
  */
 bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool wait)
 {
-	uint64_t state;
-	unsigned int retry_count;
 	bool replay_active = true;
-	const unsigned int max_retry = 1000;
-	bool force_static = true;
 	struct dc_link *link = NULL;
 
-
 	if (stream == NULL)
 		return false;
 
 	link = stream->link;
 
-	if (link == NULL)
-		return false;
-
-	link->dc->link_srv->edp_setup_replay(link, stream);
-
-	link->dc->link_srv->edp_set_replay_allow_active(link, NULL, false, false, NULL);
-
-	link->dc->link_srv->edp_set_replay_allow_active(link, &replay_active, false, true, NULL);
-
-	if (wait == true) {
-
-		for (retry_count = 0; retry_count <= max_retry; retry_count++) {
-			dc_link_get_replay_state(link, &state);
-			if (replay_active) {
-				if (state != REPLAY_STATE_0 &&
-					(!force_static || state == REPLAY_STATE_3))
-					break;
-			} else {
-				if (state == REPLAY_STATE_0)
-					break;
-			}
-			udelay(500);
-		}
-
-		/* assert if max retry hit */
-		if (retry_count >= max_retry)
-			ASSERT(0);
-	} else {
-		/* To-do: Add trace log */
+	if (link) {
+		link->dc->link_srv->edp_setup_replay(link, stream);
+		link->dc->link_srv->edp_set_coasting_vtotal(link, stream->timing.v_total);
+		DRM_DEBUG_DRIVER("Enabling replay...\n");
+		link->dc->link_srv->edp_set_replay_allow_active(link, &replay_active, wait, false, NULL);
+		return true;
 	}
 
-	return true;
+	return false;
 }
 
 /*
@@ -172,12 +172,31 @@ bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool wait)
  */
 bool amdgpu_dm_replay_disable(struct dc_stream_state *stream)
 {
+	bool replay_active = false;
+	struct dc_link *link = NULL;
 
-	if (stream->link) {
+	if (stream == NULL)
+		return false;
+
+	link = stream->link;
+
+	if (link) {
 		DRM_DEBUG_DRIVER("Disabling replay...\n");
-		stream->link->dc->link_srv->edp_set_replay_allow_active(stream->link, NULL, false, false, NULL);
+		link->dc->link_srv->edp_set_replay_allow_active(stream->link, &replay_active, true, false, NULL);
 		return true;
 	}
 
 	return false;
 }
+
+/*
+ * amdgpu_dm_replay_disable_all() - disable replay f/w
+ * if replay is enabled on any stream
+ *
+ * Return: true if success
+ */
+bool amdgpu_dm_replay_disable_all(struct amdgpu_display_manager *dm)
+{
+	DRM_DEBUG_DRIVER("Disabling replay if replay is enabled on any stream\n");
+	return dc_set_replay_allow_active(dm->dc, false);
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
index 01cba3cd6246..f0d30eb47312 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
@@ -40,7 +40,9 @@ enum replay_enable_option {
 
 
 bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool enable);
-bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
+bool amdgpu_dm_set_replay_caps(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
+bool amdgpu_dm_link_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
 bool amdgpu_dm_replay_disable(struct dc_stream_state *stream);
+bool amdgpu_dm_replay_disable_all(struct amdgpu_display_manager *dm);
 
 #endif /* AMDGPU_DM_AMDGPU_DM_REPLAY_H_ */
-- 
2.34.1

