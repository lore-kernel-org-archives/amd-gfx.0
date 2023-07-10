Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9066CEB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 19:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B1C10E2C3;
	Mon, 10 Jul 2023 19:27:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99E810E2C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 19:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOMJKpTPJ0a71HH+U+7FzHWCCcu0+axFKRcLBT6GbF+Z+BdcahqReeGNEgorNUz7UUYd0GjRR3KlOpOgLXGg0QLjqTCQM6JGogVq+tgEu4j9QJ+/5jct6usEyn6TdRs+utgWLHp1ssS2VPV0p08hfVr1bYoIrqup1amiMFc0piC5KjUgDMqym8hQO6Gj9cPOt6Ubx0QWppzOgtqg8+FpNieldjVPruceX/d2sriewCLG3PkJhXc5f+AmoFDK+NObmFrHsvx9WtVIrwuCKFVYs71VgFwalHD6jJhwIO5qcZXBNWTr7fReIe0g/4woNt3/SOBDVVFbJKrqQ9EfmJNhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqR4nuwZ17zjK/p26+zOeZk4PRaox8R4poz9f5DlcMU=;
 b=WK56xd+TKHxG8Um5tz71U5ntB6DGPpEIEATe8X2q1r3eZntrw+TY+1GK4yx5ItSJF7Kx/XCrogGch665j6kdIhhh2YFlQk33vpFfCAaXzIZYnC/gdDrVbttIq1oXLABLxuTrx1hujKy16yCC4BpH/uErGKNQDw7IhMiQAYlAeJ66XZeG6BXlx4E0azpmatL5QLfmNxXZBN/kNYjpu+FUgyIsABT8VteOVz9U42IUHGGXti7HzIpX9x4uN08DIEi64DBjVPLzngADC4KN22k5BcjK2ObFBMN0pqw94pg8pjDFBA9PDIQQkBseDal1NCFHijAlNb1ThpPs2tA0HPclhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqR4nuwZ17zjK/p26+zOeZk4PRaox8R4poz9f5DlcMU=;
 b=f9BgqWDme/8RBwspEqVn4WzCozGT4x++PvZ/ffyXzmGQjJYxdcH+L1ChpjdNbgYNfuVe7WSB4A2GXcj1svA8UXndhWlvtRRvNkxY2VvQpfvDssFN4w8N1Uo5uNNoBKxg37XW60OWJOP2TFc0t1IczyFewrjxCSNLdRq74X6hwCU=
Received: from BN9PR03CA0420.namprd03.prod.outlook.com (2603:10b6:408:111::35)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 19:27:42 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::b9) by BN9PR03CA0420.outlook.office365.com
 (2603:10b6:408:111::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 19:27:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 19:27:42 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 12:27:40 -0700
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 14:27:40 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 10/10] drm/amd/display: Enable Replay for static screen use
 cases
Date: Mon, 10 Jul 2023 15:27:33 -0400
Message-ID: <20230710192733.1344403-11-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: e958e86b-95b3-4d8e-b349-08db817bbb08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYxKNPwB+gQuTxWx4iUCrYMGrGmWSwyt6RTxjiWvx6EgzCQ7qa1In/dMPyESSp8hx26G5mocVZ+CFZFTgS7W5oI0YMVlsPdS9QlhCrQgPsmhlIRPEdbfTjvd3PkGKoZ4XKLHCHTeL5yC8Ea7hifYNO3liTFTAtT0pbv6sZfcgLha8VuTb0EML4KoZ8xVx3Ng1+3PrfBi+dQPGNsgSAFjOfxEEICc94lMHr8/+kSXlq/aELgGG2/uxhGv5sNe3ECGoHn0tWaHQVXIsLGA6GvQ8f8D4q27Vhxr4xdamBkavYmyYjffkQQFlFWc3kXRyIFqn4WJI0PhiElVn/7V2q/vEQzYDZzMrzKj6lux+qZJbJlU68zroPl4CYduZvyU78QLBl034lO3jFwGm7Oqpp58Dg1OJGmcMkJsISbY99oKYbIDYnODcRLvwSxJtf9qLS6zXC7lcXCl3sgh1px4Vu7vTbmYl5BWDd88pma9cl/U3lsFQIpZwUdNXdsPtBYXRf+gMIZJeCB1FiJXnKQDsdJDRvejh/N38iOFSIuTNiRcPe7CtFQg0tm8PNcguntysYkQYSYO8bZWmeIWgtsE6Z4Jkssa1ZgEj0FY3NN2r9GVA2inreEZ4hHtGoNg7at/yDrS9ivC3dbCaptGDsSOL+yk3ViZiEv5n5q/S38mjO6DBZJKarUbiNleYoRQSBC2d+3l3BvP6ODj33Stbv7byF03a2MSgipE1DTW03QlcgAcccV/n5v2deFKz3+c0rSZn3y7ZAY+tRSEDW/cPoUyQlDHzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(356005)(81166007)(47076005)(83380400001)(26005)(1076003)(186003)(2616005)(336012)(426003)(40480700001)(36860700001)(2906002)(40460700003)(5660300002)(8936002)(8676002)(36756003)(70206006)(6666004)(478600001)(7696005)(6636002)(4326008)(41300700001)(70586007)(110136005)(316002)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:27:42.1458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e958e86b-95b3-4d8e-b349-08db817bbb08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Setup replay config on device init.
- Enable replay if feature is enabled (prioritize replay over PSR, since
it can be enabled in more usecases)
- Add debug masks to enable replay on supported ASICs

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  9 +++++++-
 drivers/gpu/drm/amd/include/amd_shared.h      |  2 ++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 90bc32a29356..b5aeae693417 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -65,6 +65,7 @@
 #include "amdgpu_dm_debugfs.h"
 #endif
 #include "amdgpu_dm_psr.h"
+#include "amdgpu_dm_replay.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -4315,6 +4316,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const struct dc_plane_cap *plane;
 	bool psr_feature_enabled = false;
+	bool replay_feature_enabled = false;
 	int max_overlay = dm->dc->caps.max_slave_planes;
 
 	dm->display_indexes_num = dm->dc->caps.max_streams;
@@ -4424,6 +4426,20 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 	}
 
+	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
+		switch (adev->ip_versions[DCE_HWIP][0]) {
+		case IP_VERSION(3, 1, 4):
+		case IP_VERSION(3, 1, 5):
+		case IP_VERSION(3, 1, 6):
+		case IP_VERSION(3, 2, 0):
+		case IP_VERSION(3, 2, 1):
+			replay_feature_enabled = true;
+			break;
+		default:
+			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
+			break;
+		}
+	}
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
@@ -4472,6 +4488,12 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 				amdgpu_dm_update_connector_after_detect(aconnector);
 				setup_backlight_device(dm, aconnector);
 
+				/*
+				 * Disable psr if replay can be enabled
+				 */
+				if (replay_feature_enabled && amdgpu_dm_setup_replay(link, aconnector))
+					psr_feature_enabled = false;
+
 				if (psr_feature_enabled)
 					amdgpu_dm_set_psr_caps(link);
 
@@ -4480,6 +4502,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 				 */
 				if (link->psr_settings.psr_feature_enabled)
 					adev_to_drm(adev)->vblank_disable_immediate = false;
+
 			}
 		}
 		amdgpu_set_panel_orientation(&aconnector->base);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 440fc0869a34..fb51ec4f8d31 100644
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
@@ -123,7 +124,12 @@ static void vblank_control_worker(struct work_struct *work)
 	 * fill_dc_dirty_rects().
 	 */
 	if (vblank_work->stream && vblank_work->stream->link) {
-		if (vblank_work->enable) {
+		/*
+		 * Prioritize replay, instead of psr
+		 */
+		if (vblank_work->stream->link->replay_settings.replay_feature_enabled)
+			amdgpu_dm_replay_enable(vblank_work->stream, false);
+		else if (vblank_work->enable) {
 			if (vblank_work->stream->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 &&
 			    vblank_work->stream->link->psr_settings.psr_allow_active)
 				amdgpu_dm_psr_disable(vblank_work->stream);
@@ -132,6 +138,7 @@ static void vblank_control_worker(struct work_struct *work)
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 			   !amdgpu_dm_crc_window_is_activated(&vblank_work->acrtc->base) &&
 #endif
+			   vblank_work->stream->link->panel_config.psr.disallow_replay &&
 			   vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
 			amdgpu_dm_psr_enable(vblank_work->stream);
 		}
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index f175e65b853a..c6d4cca646c2 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -240,6 +240,7 @@ enum DC_FEATURE_MASK {
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
 	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
 	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
+	DC_REPLAY_MASK = (1 << 9), //0x200, disabled by default for dcn < 3.1.4
 };
 
 enum DC_DEBUG_MASK {
@@ -250,6 +251,7 @@ enum DC_DEBUG_MASK {
 	DC_DISABLE_PSR = 0x10,
 	DC_FORCE_SUBVP_MCLK_SWITCH = 0x20,
 	DC_DISABLE_MPO = 0x40,
+	DC_DISABLE_REPLAY = 0x50,
 };
 
 enum amd_dpm_forced_level;
-- 
2.25.1

