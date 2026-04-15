Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E0BFA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A49410E69C;
	Wed, 15 Apr 2026 07:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZUOfbDVS";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3B710E69A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9UXeLXQFoDgnUAuqM+RCm96XXe/gjGq4KReIvnplVWLC+3Z9ertDlA6TAdGaDgkEVYE7B542MUL1lLeKCGSa4XpfGYqCFa8Z6CmprUcJfhUHuexsAuL0lRXfDH3SziQaXjhaJ40qoo+8kZsHxNWL8yyFL+ZVJamfLVmoYBsGMRGVqjFIrimzY7EhG9/9duTmEbcOWM8OWjQbwPkOCDJXXPJiu0RhFeYrhAaI9SVwRu8tnVP7dZjohad+sa/k3Y1kx90DAMhD6NpL1Rds4pbLs0smde8KN0MfEle1AOabdGFgtbvnf8fXQthvlrkMNyWeZuvJgARx18KZKG3ESHQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPJsgKjG3W1up4+SUHoiMUtXwZOPg0GZnf0H+NdLCXQ=;
 b=MskiKFiKLfK3DBNm6A35A61IFzL5WLihwvUK0ikD06+SYl0bXGHUkC/89ykOYSmZUQI5JRH/C6NRozPnuPzt3NO/JCTAY7aJIinfwqgXSe7reMn8Qi8daInDZ87S9U6+0ILMYCE/PfJcrvX7qlVe3k4ahV5hZ+qEzp+oJ75y39E3qTxDJwIHMhRcr9eate7R8ncr++NKNPvrKmSw7JcFyHqAk+ndjiFZ/4n6SfZqBCzZVjv4xJAuNzfn4hLTjMRt5x82U+yqkFT6iM9E24MjAV+UKLvvqJjC4Mn9iFk+OEl3gKgcE+T2/ZFGWzCsOOoRBpxMvkUJokjv6dS8FNikOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPJsgKjG3W1up4+SUHoiMUtXwZOPg0GZnf0H+NdLCXQ=;
 b=ZUOfbDVSDYI2L5PVP+6/K87KC/SajOwWuazAjmTxhu/bs2dURo46+Rkhu6DQZwELM5x+2DgOSxzN7QPhRF0LPJBYhA7Of3+NGAxFFthO1OLo18a7misdyZc28S4fVNqr4iUYOSPACi/73FDk1VGrkDg6lE/duMix7EFJfC8iiF8=
Received: from DM6PR03CA0058.namprd03.prod.outlook.com (2603:10b6:5:100::35)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Wed, 15 Apr 2026 07:43:39 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::4b) by DM6PR03CA0058.outlook.office365.com
 (2603:10b6:5:100::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:43:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:43:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:43:38 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:43:30 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Ray Wu
 <ray.wu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 09/19] drm/amd/display: Add power module on Linux
Date: Wed, 15 Apr 2026 15:39:48 +0800
Message-ID: <20260415074223.34848-10-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: d57d480c-9836-4993-4b25-08de9ac2b5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qABJxOuJuKU9UTRp2weCiwyCFsIZ5lO1FDrs3fbEruo2PLQ5DRTwVTU5qyIcUY2fJK73z15JXBi13fqK3V31yE5ACIat12X+W/6HPekG583urCvpq0fIqSepRSMfqnzm2WziJnkmQZAUEbAiUChd5REuu6hINHokReAyiGHMIc+YHNvtf4C6E6F1NS2q015dHUJ4OdJ0pMpv7A6z9uUqbLP9OwafIM/Z0lhilHYmZ3L9BXxfzXTzF+vUMWeoJ5We76oPX5K9/N4ZxGvB5o/ohGsFHUSd0ua71q87CaXV2G9twJVn7cFCdGQKNcFOLxlvN7bfQNAAmwIt6T40cgmKTQDQjQcgS3MR3lWHoCgMxnUCpMEYjX1dm968uDDvSzRBtxQ8MVgIuNL9F+QXnLHKEZkcLQi2o/2RWakkUlgnMxEMzGLUoHOUp38REkqjl4o95vSICsqgadRh3uv6dgpeS7ky8UUgSEdEaseqqlNwDliGfeGVSB5MUdWqERXWFjbPhxnaBDPHpDlQjfUKRE1x5aJOjMFjHkM1l0xd/W392J12nytCV5hl+aTeKMqoegcsJSn0iU4eHATCleoHYiIsCUjGAazw13d1yCmcHZOLjLPbdmwnGnHFk2nE++gHySL3UoovCXIct8qakJpZMZ9rpG4XqaNMaTCedoFfdyiTOyS+Mr3ZkSsl4uPlz2Fv+ntZrL0YGDjvcTrXWvZzEcbDQ5vcjGuT56EOer2FR2yjvz8v5W5JIXnOWjRhMa75ynOG3fDnd24lylYVuNBMM/yIkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S4CkA4X8jNI6Iod0yLZspHyYhXokrWAPCNGW3zRq5900aL+YgNColqT6+sLnIAYfia1dL7dgI42Ge6ysdRF7n7DIwVL+cedRQIMUo6FTYX5Q/mHhfHl/aLHxySmAdWUB8K6e1wsfFqHK4mTQ7+iDgpqFxbvZvmZ+lDfkgjJfCFEnhYJazGyO3jAXU7vT6jrN2yihpWbhASziwcAgalKQ1uQFj7EaAPqZrEQgBuTwj5FMfltkEVruOLmb0bYr8IeBwcFXrE3u8L510asTWp5ZvnzI/TgKo6RKOuAWnZYY/Yl8ZIlccm2R91C7v34h+ROESRjzKSlIwlwttFxRG2DjhByZstOu6BxHQnNro2WBouohvy+dfB5qUy1IiDi1yWg5pBtYSclUV3qbvop2WRB3vx9XrwDINls5vJhOz0BAxUrClP++pd/hYvR7tzcUt0pv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:43:39.4220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d57d480c-9836-4993-4b25-08de9ac2b5a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
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

From: Ray Wu <ray.wu@amd.com>

[Why & How]
Refactors dm to utilize the power module for managing
replay, PSR, and backlight control functionalities.

Key changes:
- Introduced replay / PSR events to enable / disable replay / PSR.
- Implemented replay rate control and power option
- Refactored backlight control by using the power module.
- Enhanced handling of VRR within replay and PSR logic.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 344 ++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  10 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  36 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  74 +---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  60 ++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |  26 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 242 ++++--------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |  13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 143 ++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |  28 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |  30 +-
 12 files changed, 566 insertions(+), 445 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 09121152b980..5b5a6f66f8e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -104,6 +104,7 @@
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
 #include "modules/inc/mod_freesync.h"
+#include "modules/inc/mod_power.h"
 #include "modules/power/power_helpers.h"
 
 static_assert(AMDGPU_DMUB_NOTIFICATION_MAX == DMUB_NOTIFICATION_MAX, "AMDGPU_DMUB_NOTIFICATION_MAX mismatch");
@@ -1878,6 +1879,70 @@ static enum dmub_ips_disable_type dm_get_default_ips_mode(
 	return ret;
 }
 
+static int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
+{
+	struct mod_power_init_params init_data[MAX_NUM_EDP];
+
+	if (dm->num_of_edps == 0) {
+		drm_dbg_driver(
+			dm->ddev,
+			"amdgpu: No eDP detected, skip initializing power module\n");
+		return 0;
+	}
+
+	/* Initialize all the power module parameters */
+	for (int i = 0; i < dm->num_of_edps; i++) {
+		init_data[i].allow_psr_smu_optimizations =
+			!!(amdgpu_dc_feature_mask & DC_PSR_ALLOW_SMU_OPT);
+		init_data[i].allow_psr_multi_disp_optimizations =
+			!!(amdgpu_dc_feature_mask & DC_PSR_ALLOW_MULTI_DISP_OPT);
+		/* See dm_late_init */
+		init_data[i].backlight_ramping_override = false;
+		init_data[i].backlight_ramping_start = 0xCCCC;
+		init_data[i].backlight_ramping_reduction = 0xCCCCCCCC;
+		init_data[i].def_varibright_level = 0;
+		init_data[i].abm_config_setting = 0;
+		init_data[i].num_backlight_levels = 101;
+		init_data[i].use_nits_based_brightness = false;
+		init_data[i].panel_max_millinits = 0;
+		init_data[i].panel_min_millinits = 0;
+		init_data[i].disable_fractional_pwm =
+			!(amdgpu_dc_feature_mask & DC_DISABLE_FRACTIONAL_PWM_MASK);
+		init_data[i].use_custom_backlight_caps = false;
+		init_data[i].custom_backlight_caps_config_no = 0;
+		init_data[i].use_linear_backlight_curve = false;
+		init_data[i].def_varibright_enable = 0;
+		init_data[i].varibright_level = 0;
+		/*
+		 * Power module uses 16-bit backlight levels (0xFFFF max) rather
+		 * than 8-bit(0XFF max)
+		 */
+		init_data[i].min_backlight_pwm =
+			dm->backlight_caps[i].min_input_signal * 0x101;
+		init_data[i].max_backlight_pwm =
+			dm->backlight_caps[i].max_input_signal * 0x101;
+		init_data[i].min_abm_backlight =
+			dm->backlight_caps[i].min_input_signal * 0x101;
+
+		/* Min backlight level after ABM reduction,  Don't allow below 1%
+		 * 0xFFFF x 0.01 = 0x28F
+		 */
+		init_data[i].min_abm_backlight = (init_data[i].min_abm_backlight < 0x28F) ?
+			0x28F : init_data[i].min_abm_backlight;
+	}
+
+	dm->power_module = mod_power_create(dm->dc, init_data, dm->num_of_edps);
+	if (!dm->power_module) {
+		drm_err(dm->ddev, "amdgpu: Error allocating memory for power module\n");
+		return -ENOMEM;
+	}
+
+	mod_power_hw_init(dm->power_module);
+	drm_dbg_driver(dm->ddev, "amdgpu: Power module init done\n");
+
+	return 0;
+}
+
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
@@ -1895,6 +1960,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	mutex_init(&adev->dm.dc_lock);
 	mutex_init(&adev->dm.audio_lock);
 
+	spin_lock_init(&adev->dm.dmub_lock);
+
 	if (amdgpu_dm_irq_init(adev)) {
 		drm_err(adev_to_drm(adev), "failed to initialize DM IRQ support.\n");
 		goto error;
@@ -2191,6 +2258,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		goto error;
 	}
 
+	if (amdgpu_dm_init_power_module(&adev->dm))
+		goto error;
+
 	/* create fake encoders for MST */
 	dm_dp_create_fake_mst_encoders(adev);
 
@@ -2332,6 +2402,10 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.freesync_module = NULL;
 	}
 
+	if (adev->dm.power_module) {
+		mod_power_destroy(adev->dm.power_module);
+		adev->dm.power_module = NULL;
+	}
 	mutex_destroy(&adev->dm.audio_lock);
 	mutex_destroy(&adev->dm.dc_lock);
 	mutex_destroy(&adev->dm.dpia_aux_lock);
@@ -5051,8 +5125,8 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 #define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
 #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
 
-static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
-					    int bl_idx)
+void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
+				     int bl_idx)
 {
 	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[bl_idx];
 
@@ -5214,15 +5288,34 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
 				 max - min);
 }
 
+static struct dc_stream_state *dm_find_stream_with_link(
+	struct amdgpu_display_manager *dm,
+	struct dc_link *link)
+{
+	struct dc_state *cur_dc_state = dm->dc->current_state;
+	struct dc_stream_state *stream = NULL;
+	int i;
+
+	for (i = 0; i < cur_dc_state->stream_count; i++) {
+		stream = cur_dc_state->streams[i];
+		if (stream->link == link)
+			return stream;
+	}
+
+	return NULL;
+}
+
 static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 					 int bl_idx,
 					 u32 user_brightness)
 {
 	struct amdgpu_dm_backlight_caps *caps;
 	struct dc_link *link;
-	u32 brightness;
-	bool rc, reallow_idle = false;
+	u32 brightness = 0;
+	bool rc = false, reallow_idle = false;
 	struct drm_connector *connector;
+	struct dc_stream_state *stream;
+	unsigned int min, max;
 
 	list_for_each_entry(connector, &dm->ddev->mode_config.connector_list, head) {
 		struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
@@ -5252,13 +5345,6 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	if (caps->brightness_mask)
 		brightness |= caps->brightness_mask;
 
-	/* Change brightness based on AUX property */
-	mutex_lock(&dm->dc_lock);
-	if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
-		dc_allow_idle_optimizations(dm->dc, false);
-		reallow_idle = true;
-	}
-
 	if (trace_amdgpu_dm_brightness_enabled()) {
 		trace_amdgpu_dm_brightness(__builtin_return_address(0),
 					   user_brightness,
@@ -5267,22 +5353,45 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 					   power_supply_is_system_supplied() > 0);
 	}
 
-	if (caps->aux_support) {
-		rc = dc_link_set_backlight_level_nits(link, true, brightness,
-						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
-		if (!rc)
-			DRM_DEBUG("DM: Failed to update backlight via AUX on eDP[%d]\n", bl_idx);
-	} else {
-		struct set_backlight_level_params backlight_level_params = { 0 };
+	stream = dm_find_stream_with_link(dm, link);
+	if (!stream)
+		return;
 
-		backlight_level_params.backlight_pwm_u16_16 = brightness;
-		backlight_level_params.transition_time_in_ms = 0;
+	mutex_lock(&dm->dc_lock);
+	if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
+		dc_allow_idle_optimizations(dm->dc, false);
+		reallow_idle = true;
+	}
 
-		rc = dc_link_set_backlight_level(link, &backlight_level_params);
-		if (!rc)
-			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
+	if (caps->aux_support) {
+		rc = mod_power_set_backlight_nits(dm->power_module, stream, brightness,
+			AUX_BL_DEFAULT_TRANSITION_TIME_MS, false, true);
+	} else {
+		/* power module uses millipercent */
+		get_brightness_range(caps, &min, &max);
+		brightness = DIV_ROUND_CLOSEST(brightness * 100, (max - min)) * 1000;
+		rc = mod_power_set_backlight_percent(dm->power_module, stream,
+						     brightness, 0, false);
 	}
 
+	/*
+	 * Some kms clients create a ramped backlight transition effect
+	 * by rapidly changing the backlight. Yet we must wait on dmcub
+	 * fw to exit psr/replay before programming backlight. To
+	 * prevent lag, keep disable psr/replay and let the next atomic
+	 * flip clear the event.
+	 *
+	 * ToDo: use ISM to handle rapidly backlight change
+	 *
+	 * Rapidly backlight change is similar to rapidly cursor events,
+	 * which is now handled by ISM. ISM can delay the event until system
+	 * is really idle, so we may use ISM to handle backlight change as well.
+	 */
+	amdgpu_dm_psr_set_event(dm, stream, true,
+		psr_event_hw_programming, true);
+	amdgpu_dm_replay_set_event(dm, stream, true,
+		replay_event_hw_programming, true);
+
 	if (dm->dc->caps.ips_support && reallow_idle)
 		dc_allow_idle_optimizations(dm->dc, true);
 
@@ -5500,6 +5609,8 @@ static void setup_backlight_device(struct amdgpu_display_manager *dm,
 
 static void amdgpu_set_panel_orientation(struct drm_connector *connector);
 
+
+
 /*
  * In this architecture, the association
  * connector -> encoder -> crtc
@@ -5741,7 +5852,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 						psr_feature_enabled = false;
 
 				if (psr_feature_enabled) {
-					amdgpu_dm_set_psr_caps(link);
+					amdgpu_dm_set_psr_caps(link, aconnector);
 					drm_info(adev_to_drm(adev), "%s: PSR support %d, DC PSR ver %d, sink PSR ver %d DPCD caps 0x%x su_y_granularity %d\n",
 						 aconnector->base.name,
 						 link->psr_settings.psr_feature_enabled,
@@ -9793,7 +9904,8 @@ static void update_stream_irq_parameters(
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 }
 
-static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
+static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
+					    struct dm_crtc_state *old_state,
 					    struct dm_crtc_state *new_state)
 {
 	bool old_vrr_active = amdgpu_dm_crtc_vrr_active(old_state);
@@ -9812,6 +9924,13 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
 		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
 		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR off->on: Get vblank ref\n",
 				 __func__, new_state->base.crtc->base.id);
+
+		scoped_guard(mutex, &dm->dc_lock) {
+			amdgpu_dm_psr_set_event(dm, new_state->stream, true,
+				psr_event_vrr_transition, true);
+			amdgpu_dm_replay_set_event(dm, new_state->stream, true,
+				replay_event_vrr, true);
+		}
 	} else if (old_vrr_active && !new_vrr_active) {
 		/* Transition VRR active -> inactive:
 		 * Allow vblank irq disable again for fixed refresh rate.
@@ -9820,6 +9939,13 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
 		drm_crtc_vblank_put(new_state->base.crtc);
 		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR on->off: Drop vblank ref\n",
 				 __func__, new_state->base.crtc->base.id);
+
+		scoped_guard(mutex, &dm->dc_lock) {
+			amdgpu_dm_psr_set_event(dm, new_state->stream, false,
+				psr_event_vrr_transition, false);
+			amdgpu_dm_replay_set_event(dm, new_state->stream, false,
+				replay_event_vrr, false);
+		}
 	}
 }
 
@@ -9917,7 +10043,8 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
 	}
 }
 
-static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
+static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
+					  struct amdgpu_crtc *acrtc_attach,
 					  const struct dm_crtc_state *acrtc_state,
 					  const u64 current_ts)
 {
@@ -9925,20 +10052,10 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 	struct replay_settings *pr = &acrtc_state->stream->link->replay_settings;
 	struct amdgpu_dm_connector *aconn =
 		(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
-	bool vrr_active = amdgpu_dm_crtc_vrr_active(acrtc_state);
-
-	if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
-		if (pr->config.replay_supported && !pr->replay_feature_enabled)
-			amdgpu_dm_link_setup_replay(acrtc_state->stream->link, aconn);
-		else if (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED &&
-			     !psr->psr_feature_enabled)
-			if (!aconn->disallow_edp_enter_psr)
-				amdgpu_dm_link_setup_psr(acrtc_state->stream);
-	}
 
 	/* Decrement skip count when SR is enabled and we're doing fast updates. */
 	if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
-	    (psr->psr_feature_enabled || pr->config.replay_supported)) {
+	    (psr->psr_feature_enabled || pr->replay_feature_enabled)) {
 		if (aconn->sr_skip_count > 0)
 			aconn->sr_skip_count--;
 
@@ -9953,17 +10070,15 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
 		 * of update events.
 		 * See `amdgpu_dm_crtc_vblank_control_worker()`.
 		 */
-		if (!vrr_active &&
-		    acrtc_attach->dm_irq_params.allow_sr_entry &&
-#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-		    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
-#endif
-		    (current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000) {
-			if (pr->replay_feature_enabled && !pr->replay_allow_active)
-				amdgpu_dm_replay_enable(acrtc_state->stream, true);
-			if (psr->psr_version == DC_PSR_VERSION_SU_1 &&
-			    !psr->psr_allow_active && !aconn->disallow_edp_enter_psr)
-				amdgpu_dm_psr_enable(acrtc_state->stream);
+		if (acrtc_attach->dm_irq_params.allow_sr_entry &&
+			(current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000) {
+			amdgpu_dm_psr_set_event(dm, acrtc_state->stream, false,
+				psr_event_hw_programming, false);
+
+			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, true,
+				replay_event_general_ui, true);
+			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, false,
+				replay_event_hw_programming, false);
 		}
 	} else {
 		acrtc_attach->dm_irq_params.allow_sr_entry = false;
@@ -10125,15 +10240,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			 */
 			if (acrtc_state->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
 			    acrtc_attach->dm_irq_params.allow_sr_entry &&
-#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-			    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
-#endif
 			    dirty_rects_changed) {
 				mutex_lock(&dm->dc_lock);
 				acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns =
 				timestamp_ns;
-				if (acrtc_state->stream->link->psr_settings.psr_allow_active)
-					amdgpu_dm_psr_disable(acrtc_state->stream, true);
+				amdgpu_dm_psr_set_event(dm, acrtc_state->stream, true,
+					psr_event_hw_programming, true);
 				mutex_unlock(&dm->dc_lock);
 			}
 		}
@@ -10298,15 +10410,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		if (acrtc_state->abm_level != dm_old_crtc_state->abm_level)
 			bundle->stream_update.abm_level = &acrtc_state->abm_level;
 
-		mutex_lock(&dm->dc_lock);
-		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) || vrr_active) {
-			if (acrtc_state->stream->link->replay_settings.replay_allow_active)
-				amdgpu_dm_replay_disable(acrtc_state->stream);
-			if (acrtc_state->stream->link->psr_settings.psr_allow_active)
-				amdgpu_dm_psr_disable(acrtc_state->stream, true);
-		}
-		mutex_unlock(&dm->dc_lock);
-
 		/*
 		 * If FreeSync state on the stream has changed then we need to
 		 * re-adjust the min/max bounds now that DC doesn't handle this
@@ -10344,8 +10447,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		if (dm_old_crtc_state->active_planes != acrtc_state->active_planes)
 			dm_update_pflip_irq_state(drm_to_adev(dev),
 						  acrtc_attach);
-
-		amdgpu_dm_enable_self_refresh(acrtc_attach, acrtc_state, timestamp_ns);
+		amdgpu_dm_enable_self_refresh(dm, acrtc_attach, acrtc_state,
+					      timestamp_ns);
 		mutex_unlock(&dm->dc_lock);
 	}
 
@@ -10464,6 +10567,102 @@ static void dm_clear_writeback(struct amdgpu_display_manager *dm,
 	dc_stream_remove_writeback(dm->dc, crtc_state->stream, 0);
 }
 
+/**
+ * amdgpu_dm_mod_power_update_streams - update mod_power stream state on modeset
+ * @state: the drm atomic state
+ * @dm: the display manager to update mod_power on
+ *
+ * Notify mod_power of stream changes on modeset events, and disable PSR/Replay
+ * in preparation for hardware programming. See also
+ * amdgpu_dm_mod_power_setup_streams() for post-modeset mod_power setup.
+ */
+static void amdgpu_dm_mod_power_update_streams(struct drm_atomic_state *state,
+					       struct amdgpu_display_manager *dm)
+{
+	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_crtc *crtc;
+	int i = 0;
+
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
+		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+
+		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
+			continue;
+
+		/*
+		 * Update mod_power on modeset event in preparation for hw
+		 * programming. Always use the old stream, since it would have
+		 * been previously added to mod_power. If old stream is null (on
+		 * crtc enable, for example), mod_power will no-op, which is the
+		 * desried behavior.
+		 */
+		if (old_crtc_state->active) {
+			scoped_guard(mutex, &dm->dc_lock) {
+				amdgpu_dm_psr_set_event(dm, dm_old_crtc_state->stream, true,
+					psr_event_hw_programming, true);
+				amdgpu_dm_replay_set_event(dm, dm_old_crtc_state->stream, true,
+					replay_event_hw_programming, true);
+			}
+		}
+
+		if (new_crtc_state->active) {
+			aconnector = (struct amdgpu_dm_connector *)
+				dm_new_crtc_state->stream->dm_stream_context;
+			if (old_crtc_state->active) {
+				mod_power_replace_stream(dm->power_module,
+					dm_old_crtc_state->stream,
+					dm_new_crtc_state->stream,
+					&aconnector->psr_caps);
+			} else {
+				mod_power_add_stream(dm->power_module,
+					dm_new_crtc_state->stream,
+					&aconnector->psr_caps);
+			}
+		} else if (old_crtc_state->active) {
+			mod_power_remove_stream(dm->power_module,
+				dm_old_crtc_state->stream);
+		}
+	}
+}
+
+/**
+ * amdgpu_dm_mod_power_setup_streams - setup mod_power stream state post modeset
+ * @state: the drm atomic state
+ * @dm: the display manager to update mod_power on
+ *
+ * Notify mod_power of mode_change. This needs to be done after dc_stream
+ * updates have been committed, and VRR parameters have been updated.
+ */
+static void amdgpu_dm_mod_power_setup_streams(struct drm_atomic_state *state,
+					      struct amdgpu_display_manager *dm)
+{
+	struct dm_crtc_state *dm_new_crtc_state;
+	struct drm_crtc_state *new_crtc_state;
+	struct amdgpu_crtc *acrtc;
+	struct drm_crtc *crtc;
+	int i = 0;
+
+	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
+		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
+		acrtc = to_amdgpu_crtc(crtc);
+
+		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
+			continue;
+
+		if (new_crtc_state->active) {
+			amdgpu_dm_link_setup_replay(dm_new_crtc_state->stream,
+					&acrtc->dm_irq_params.vrr_params);
+			mod_power_notify_mode_change(dm->power_module,
+						dm_new_crtc_state->stream,
+						false);
+		}
+	}
+
+}
+
 static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 					struct dc_state *dc_state)
 {
@@ -10507,6 +10706,8 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 		acrtc->wb_enabled = false;
 	}
 
+	amdgpu_dm_mod_power_update_streams(state, dm);
+
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
 				      new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
@@ -10611,13 +10812,10 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 		}
 	} /* for_each_crtc_in_state() */
 
-	/* if there mode set or reset, disable eDP PSR, Replay */
+	/* if there mode set or reset, flush vblank work queue */
 	if (mode_set_reset_required) {
 		if (dm->vblank_control_workqueue)
 			flush_workqueue(dm->vblank_control_workqueue);
-
-		amdgpu_dm_replay_disable_all(dm);
-		amdgpu_dm_psr_disable_all(dm);
 	}
 
 	dm_enable_per_frame_crtc_master_sync(dc_state);
@@ -11090,7 +11288,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			manage_dm_interrupts(adev, acrtc, dm_new_crtc_state);
 		}
 		/* Handle vrr on->off / off->on transitions */
-		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);
+		amdgpu_dm_handle_vrr_transition(dm, dm_old_crtc_state, dm_new_crtc_state);
 
 #ifdef CONFIG_DEBUG_FS
 		if (new_crtc_state->active &&
@@ -11128,6 +11326,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 #endif
 	}
 
+	amdgpu_dm_mod_power_setup_streams(state, dm);
+
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
 		if (new_crtc_state->async_flip)
 			wait_for_vblank = false;
@@ -13686,11 +13886,17 @@ int amdgpu_dm_process_dmub_set_config_sync(
 
 bool dm_execute_dmub_cmd(const struct dc_context *ctx, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type)
 {
+	struct amdgpu_device *adev = ctx->driver_context;
+
+	guard(spinlock_irqsave)(&adev->dm.dmub_lock);
 	return dc_dmub_srv_cmd_run(ctx->dmub_srv, cmd, wait_type);
 }
 
 bool dm_execute_dmub_cmd_list(const struct dc_context *ctx, unsigned int count, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type)
 {
+	struct amdgpu_device *adev = ctx->driver_context;
+
+	guard(spinlock_irqsave)(&adev->dm.dmub_lock);
 	return dc_dmub_srv_cmd_run_list(ctx->dmub_srv, count, cmd, wait_type);
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 74a8fe1a1999..1e0ccf58cdb8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -463,6 +463,13 @@ struct amdgpu_display_manager {
 	 */
 	struct mutex dc_lock;
 
+	/**
+	 * @dmub_lock:
+	 *
+	 * Guards access to DMUB command submission.
+	 */
+	spinlock_t dmub_lock;
+
 	/**
 	 * @audio_lock:
 	 *
@@ -568,6 +575,7 @@ struct amdgpu_display_manager {
 	struct amdgpu_dm_backlight_caps backlight_caps[AMDGPU_DM_MAX_NUM_EDP];
 
 	struct mod_freesync *freesync_module;
+	struct mod_power *power_module;
 	struct hdcp_workqueue *hdcp_workqueue;
 
 	/**
@@ -835,6 +843,7 @@ struct amdgpu_dm_connector {
 	bool force_yuv420_output;
 	bool force_yuv422_output;
 	struct dsc_preferred_settings dsc_settings;
+	struct psr_caps psr_caps;
 	union dp_downstream_port_present mst_downstream_port_present;
 	/* Cached display modes */
 	struct drm_display_mode freesync_vid_base;
@@ -1149,4 +1158,5 @@ int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector);
 
 void retrieve_dmi_info(struct amdgpu_display_manager *dm);
 
+void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm, int bl_idx);
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index dd79866df1fd..2663593aa35c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -503,7 +503,6 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 {
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dc_stream_state *stream_state = dm_crtc_state->stream;
-	struct amdgpu_dm_connector *aconnector = NULL;
 	bool enable = amdgpu_dm_is_valid_crc_source(source);
 	int ret = 0;
 	enum crc_poly_mode crc_poly_mode = CRC_POLY_MODE_16;
@@ -512,21 +511,17 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 	if (!stream_state)
 		return -EINVAL;
 
-	/* Get connector from stream */
-	aconnector = (struct amdgpu_dm_connector *)stream_state->dm_stream_context;
-
 	mutex_lock(&adev->dm.dc_lock);
 
-
+	/* Notify power module about CRC window active to disable PSR/Replay
+	 * Power module will check caps internally and skip if not supported
+	 */
 	if (enable) {
-		/* For PSR1, check that the panel has exited PSR */
-		if (stream_state->link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
-			amdgpu_dm_psr_wait_disable(stream_state);
+		amdgpu_dm_psr_set_event(&adev->dm, stream_state, true,
+			psr_event_crc_window_active, true);
 
-		/* Set flag to disallow enter replay when CRC source is enabled */
-		if (aconnector)
-			aconnector->disallow_edp_enter_replay = true;
-		amdgpu_dm_replay_disable(stream_state);
+		amdgpu_dm_replay_set_event(&adev->dm, stream_state, true,
+			replay_event_crc_window_active, true);
 	}
 
 	/* CRC polynomial selection only support for DCN3.6+ except DCN4.0.1 */
@@ -559,11 +554,15 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 	}
 
 	if (!enable) {
-		/* Clear flag to allow enter replay when CRC source is disabled */
-		if (aconnector)
-			aconnector->disallow_edp_enter_replay = false;
-	}
+		/* Notify power module about CRC window inactive to re-enable PSR/Replay
+		 * Power module will check caps internally and skip if not supported
+		 */
+		amdgpu_dm_psr_set_event(&adev->dm, stream_state, false,
+			psr_event_crc_window_active, false);
 
+		amdgpu_dm_replay_set_event(&adev->dm, stream_state, false,
+			replay_event_crc_window_active, false);
+	}
 unlock:
 	mutex_unlock(&adev->dm.dc_lock);
 
@@ -760,10 +759,13 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc)
 	uint32_t crcs[3];
 	unsigned long flags;
 
-	if (crtc == NULL)
+	if (!crtc || !crtc->state || !crtc->dev)
 		return;
 
 	crtc_state = to_dm_crtc_state(crtc->state);
+	if (!crtc_state->stream)
+		return;
+
 	stream_state = crtc_state->stream;
 	acrtc = to_amdgpu_crtc(crtc);
 	drm_dev = crtc->dev;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 40c5f74dbe2b..efb19f675b0c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -34,6 +34,7 @@
 #include "amdgpu_dm_plane.h"
 #include "amdgpu_dm_trace.h"
 #include "amdgpu_dm_debugfs.h"
+#include "modules/inc/mod_power.h"
 
 #define HPD_DETECTION_PERIOD_uS 2000000
 #define HPD_DETECTION_TIME_uS 100000
@@ -100,68 +101,33 @@ bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state)
 }
 
 /**
- * amdgpu_dm_crtc_set_panel_sr_feature() - Manage panel self-refresh features.
- * @dm: amdgpu display manager instance.
- * @acrtc: CRTC whose panel self-refresh state is being updated.
- * @stream: DC stream associated with @acrtc.
- * @vblank_enabled: Whether the DRM vblank counter is currently enabled.
- * @allow_sr_entry: Whether entry into self-refresh mode is allowed.
+ * amdgpu_dm_crtc_set_static_screen_optimze() - Toggle static screen optimizations.
  *
- * The DRM vblank counter enable/disable action is used as the trigger to enable
- * or disable various panel self-refresh features:
+ * @dm: display manager
+ * @stream: DC stream state
+ * @sso_enable: desired static screen optimization state
+ * @allow_sr_entry: whether entry into self-refresh mode is allowed
  *
- * Panel Replay and PSR SU
- * - Enable when:
- *   - VRR is disabled
- *   - vblank counter is disabled
- *   - entry is allowed: usermode demonstrates an adequate number of fast
- *     commits
- *   - CRC capture window isn't active
- * - Keep enabled even when vblank counter gets enabled
- *
- * PSR1
- * - Enable condition same as above
- * - Disable when vblank counter is enabled
+ * This function uses the static-screen optimization state as the trigger to
+ * set/clear the Replay and PSR vsync-related events.
  */
-void amdgpu_dm_crtc_set_panel_sr_feature(
+void amdgpu_dm_crtc_set_static_screen_optimze(
 	struct amdgpu_display_manager *dm,
-	struct amdgpu_crtc *acrtc,
 	struct dc_stream_state *stream,
-	bool vblank_enabled, bool allow_sr_entry)
+	bool sso_enable, bool allow_sr_entry)
 {
 	struct dc_link *link = stream->link;
-	bool is_sr_active = (link->replay_settings.replay_allow_active ||
-				 link->psr_settings.psr_allow_active);
-	bool is_crc_window_active = false;
-	bool vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
-
-#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-	is_crc_window_active =
-		amdgpu_dm_crc_window_is_activated(&acrtc->base);
-#endif
+	bool set_vsync_event = !sso_enable;
 
-	if (link->replay_settings.replay_feature_enabled && !vrr_active &&
-		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
-		amdgpu_dm_replay_enable(stream, true);
-	} else if (vblank_enabled) {
-		if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1 && is_sr_active)
-			amdgpu_dm_psr_disable(stream, false);
-	} else if (link->psr_settings.psr_feature_enabled && !vrr_active &&
-		allow_sr_entry && !is_sr_active && !is_crc_window_active) {
-
-		struct amdgpu_dm_connector *aconn =
-			(struct amdgpu_dm_connector *) stream->dm_stream_context;
-
-		if (!aconn->disallow_edp_enter_psr) {
-			amdgpu_dm_psr_enable(stream);
-			if (dm->idle_workqueue &&
-			    (dm->dc->config.disable_ips == DMUB_IPS_ENABLE) &&
-			    dm->dc->idle_optimizations_allowed &&
-			    dm->idle_workqueue->enable &&
-			    !dm->idle_workqueue->running)
-				schedule_work(&dm->idle_workqueue->work);
-		}
-	}
+	if (!allow_sr_entry)
+		return;
+
+	amdgpu_dm_replay_set_event(dm, stream,
+		set_vsync_event, replay_event_vsync, set_vsync_event);
+
+	if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
+		amdgpu_dm_psr_set_event(dm, stream,
+			set_vsync_event, psr_event_vsync, set_vsync_event);
 }
 
 bool amdgpu_dm_is_headless(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index 3a8094013a5d..e9fb52f0e66d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -27,11 +27,10 @@
 #ifndef __AMDGPU_DM_CRTC_H__
 #define __AMDGPU_DM_CRTC_H__
 
-void amdgpu_dm_crtc_set_panel_sr_feature(
+void amdgpu_dm_crtc_set_static_screen_optimze(
 	struct amdgpu_display_manager *dm,
-	struct amdgpu_crtc *acrtc,
 	struct dc_stream_state *stream,
-	bool vblank_enabled, bool allow_sr_entry);
+	bool sso_enable, bool allow_sr_entry);
 
 void amdgpu_dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 7c6deb2764aa..49226d6d0311 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -33,6 +33,7 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_debugfs.h"
 #include "amdgpu_dm_replay.h"
+#include "amdgpu_dm_psr.h"
 #include "dm_helpers.h"
 #include "dmub/dmub_srv.h"
 #include "resource.h"
@@ -3300,11 +3301,26 @@ static int disallow_edp_enter_psr_get(void *data, u64 *val)
 static int disallow_edp_enter_psr_set(void *data, u64 val)
 {
 	struct amdgpu_dm_connector *aconnector = data;
+	struct dc_link *link = aconnector->dc_link;
+
+	aconnector->disallow_edp_enter_psr = (val != 0);
 
-	aconnector->disallow_edp_enter_psr = val ? true : false;
+	/* eDP PSR enable / disable is happened during mode change in power module.
+	 * Only psr_settings.psr_version is used to decide whether PSR is enabled or not.
+	 * So here we only update psr_version based on debugfs setting.
+	 * If disallow_edp_enter_psr is true, set psr_version to unsupported;
+	 * if disallow_edp_enter_psr is false, set psr_version based on sink capability.
+	 */
+	if (aconnector->disallow_edp_enter_psr)
+		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
+	else if (aconnector->psr_caps.psr_version == 1)
+		link->psr_settings.psr_version = DC_PSR_VERSION_1;
+	else if (aconnector->psr_caps.psr_version == 2)
+		link->psr_settings.psr_version = DC_PSR_VERSION_SU_1;
 	return 0;
 }
 
+
 /* check if kernel disallow eDP enter replay state
  * cat /sys/kernel/debug/dri/0/eDP-X/disallow_edp_enter_replay
  * 0: allow edp enter replay; 1: disallow
@@ -3346,11 +3362,27 @@ static int disallow_edp_enter_replay_get(void *data, u64 *val)
 static int disallow_edp_enter_replay_set(void *data, u64 val)
 {
 	struct amdgpu_dm_connector *aconnector = data;
+	struct dc_link *link = aconnector->dc_link;
+
+	aconnector->disallow_edp_enter_replay = (val != 0);
 
-	aconnector->disallow_edp_enter_replay = val ? true : false;
+	/* eDP replay enable / disable is happened during mode change in power module.
+	 * Only replay_settings.config.replay_supported is used to decide whether
+	 * replay is enabled or not. So here we only update replay_supported based on
+	 * debugfs setting.
+	 * If disallow_edp_enter_replay is true, set replay_supported to false.
+	 * if disallow_edp_enter_replay is false, set replay_supported back based on
+	 * sink replay capability.
+	 */
+	if (aconnector->disallow_edp_enter_replay)
+		link->replay_settings.config.replay_supported = false;
+	else
+		link->replay_settings.config.replay_supported =
+			link->replay_settings.config.replay_cap_support;
 	return 0;
 }
 
+
 static int dmub_trace_mask_set(void *data, u64 val)
 {
 	struct amdgpu_device *adev = data;
@@ -3485,6 +3517,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(disallow_edp_enter_replay_fops,
 
 DEFINE_DEBUGFS_ATTRIBUTE(ips_residency_cntl_fops, ips_residency_cntl_get,
 			   ips_residency_cntl_set, "%llu\n");
+
 DEFINE_SHOW_ATTRIBUTE(current_backlight);
 DEFINE_SHOW_ATTRIBUTE(target_backlight);
 DEFINE_SHOW_ATTRIBUTE(ips_status);
@@ -3855,28 +3888,35 @@ DEFINE_DEBUGFS_ATTRIBUTE(crc_win_y_end_fops, crc_win_y_end_get,
 static int crc_win_update_set(void *data, u64 val)
 {
 	struct drm_crtc *crtc = data;
-	struct amdgpu_crtc *acrtc;
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 
 	if (val) {
-		acrtc = to_amdgpu_crtc(crtc);
 		mutex_lock(&adev->dm.dc_lock);
-		/* PSR may write to OTG CRC window control register,
-		 * so close it before starting secure_display.
+		/* PSR Replay may write to OTG CRC window control register,
+		 * so inactive it before starting secure_display by sending disable event.
 		 */
-		amdgpu_dm_psr_disable(acrtc->dm_irq_params.stream, true);
+		amdgpu_dm_psr_set_event(&adev->dm, acrtc->dm_irq_params.stream, true,
+			psr_event_crc_window_active, true);
+		amdgpu_dm_replay_set_event(&adev->dm, acrtc->dm_irq_params.stream, true,
+			replay_event_crc_window_active, true);
 
 		spin_lock_irq(&adev_to_drm(adev)->event_lock);
-
 		acrtc->dm_irq_params.window_param[0].enable = true;
 		acrtc->dm_irq_params.window_param[0].update_win = true;
 		acrtc->dm_irq_params.window_param[0].skip_frame_cnt = 0;
 		acrtc->dm_irq_params.crc_window_activated = true;
-
 		spin_unlock_irq(&adev_to_drm(adev)->event_lock);
 		mutex_unlock(&adev->dm.dc_lock);
+	} else {
+		/* Clear disable events to allow PSR/Replay to active */
+		mutex_lock(&adev->dm.dc_lock);
+		amdgpu_dm_psr_set_event(&adev->dm, acrtc->dm_irq_params.stream, false,
+			psr_event_crc_window_active, false);
+		amdgpu_dm_replay_set_event(&adev->dm, acrtc->dm_irq_params.stream, false,
+			replay_event_crc_window_active, false);
+		mutex_unlock(&adev->dm.dc_lock);
 	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index a3ccb6fdc372..f2f6c7936e58 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -292,24 +292,16 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
 	 */
 	if (stream && stream->link) {
 		/*
-		 * If allow_panel_sso is true when disabling vblank, allow
-		 * deeper panel sleep states such as PSR1 and Replay static
-		 * screen optimization.
-		 */
-		if (!vblank_enabled && allow_panel_sso) {
-			amdgpu_dm_crtc_set_panel_sr_feature(
-				dm, acrtc, stream, false,
-				acrtc->dm_irq_params.allow_sr_entry);
-		} else if (vblank_enabled) {
-			/* Make sure to exit SSO on vblank enable */
-			amdgpu_dm_crtc_set_panel_sr_feature(
-				dm, acrtc, stream, true,
-				acrtc->dm_irq_params.allow_sr_entry);
-		}
-		/*
-		 * Else, vblank_enabled == false and allow_panel_sso == false;
-		 * do nothing here.
+		 * If the OS requires vblank events (or vblank is otherwise enabled),
+		 * do not allow static screen optimizations.
+		 *
+		 * Keep ism->allow_static_screen_optimizations unchanged so the
+		 * hysteresis-based decision can be reused once vblank is disabled.
 		 */
+		allow_panel_sso = allow_panel_sso && !vblank_enabled;
+		amdgpu_dm_crtc_set_static_screen_optimze(
+			dm, stream, allow_panel_sso,
+			acrtc->dm_irq_params.allow_sr_entry);
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 99d6d6c93561..dc5913a6456e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -58,171 +58,76 @@ static bool link_supports_psrsu(struct dc_link *link)
 	return false;
 }
 
-/*
- * amdgpu_dm_set_psr_caps() - set link psr capabilities
- * @link: link
- *
- */
-void amdgpu_dm_set_psr_caps(struct dc_link *link)
+static void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps)
 {
-	if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
-		link->psr_settings.psr_feature_enabled = false;
-		return;
-	}
-
-	if (link->type == dc_connection_none) {
-		link->psr_settings.psr_feature_enabled = false;
-		return;
-	}
-
-	if (link->dpcd_caps.psr_info.psr_version == 0) {
-		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
-		link->psr_settings.psr_feature_enabled = false;
-
-	} else {
-		unsigned int panel_inst = 0;
-
-		if (link_supports_psrsu(link))
-			link->psr_settings.psr_version = DC_PSR_VERSION_SU_1;
-		else
-			link->psr_settings.psr_version = DC_PSR_VERSION_1;
-
-		link->psr_settings.psr_feature_enabled = true;
-
-		/*disable allow psr/psrsu/replay on eDP1*/
-		if (dc_get_edp_link_panel_inst(link->ctx->dc, link, &panel_inst) && panel_inst == 1) {
-			link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
-			link->psr_settings.psr_feature_enabled = false;
-		}
-	}
+	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
+	unsigned int power_opts = 0;
+
+	if (amdgpu_dc_feature_mask & DC_PSR_ALLOW_SMU_OPT)
+		power_opts |= psr_power_opt_smu_opt_static_screen;
+	power_opts |= psr_power_opt_z10_static_screen;
+
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_1)
+		caps->psr_version = 1;
+	else if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+		caps->psr_version = 2;
+
+	caps->psr_rfb_setup_time = (6 - dpcd_caps->psr_info.psr_dpcd_caps.bits.PSR_SETUP_TIME) * 55;
+	caps->psr_exit_link_training_required =
+		!dpcd_caps->psr_info.psr_dpcd_caps.bits.LINK_TRAINING_ON_EXIT_NOT_REQUIRED;
+	caps->edp_revision = dpcd_caps->edp_rev;
+	caps->support_ver = dpcd_caps->psr_info.psr_version;
+	caps->su_granularity_required =
+		dpcd_caps->psr_info.psr_dpcd_caps.bits.SU_GRANULARITY_REQUIRED;
+	caps->y_coordinate_required = dpcd_caps->psr_info.psr_dpcd_caps.bits.Y_COORDINATE_REQUIRED;
+	caps->su_y_granularity = dpcd_caps->psr_info.psr2_su_y_granularity_cap;
+	caps->alpm_cap = dpcd_caps->alpm_caps.bits.AUX_WAKE_ALPM_CAP;
+	caps->standby_support = dpcd_caps->alpm_caps.bits.PM_STATE_2A_SUPPORT;
+	caps->rate_control_caps = 0; /* TODO: read in rc caps from aux */
+	caps->psr_power_opt_flag = power_opts;
 }
 
 /*
- * amdgpu_dm_link_setup_psr() - configure psr link
- * @stream: stream state
- *
- * Return: true if success
+ * amdgpu_dm_set_psr_caps() - set link psr capabilities
+ * @link: link
+ * @aconnector: amdgpu_dm_connector
  */
-bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
+bool amdgpu_dm_set_psr_caps(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
 {
-	struct dc_link *link = NULL;
-	struct psr_config psr_config = {0};
-	struct psr_context psr_context = {0};
-	struct dc *dc = NULL;
-	bool ret = false;
+	struct dc *dc;
+	unsigned int panel_inst = 0;
 
-	if (stream == NULL)
+	if (!link || !aconnector)
 		return false;
 
-	link = stream->link;
 	dc = link->ctx->dc;
 
-	if (link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED) {
-		mod_power_calc_psr_configs(&psr_config, link, stream);
-
-		/* linux DM specific updating for psr config fields */
-		psr_config.allow_smu_optimizations =
-			(amdgpu_dc_feature_mask & DC_PSR_ALLOW_SMU_OPT) &&
-			mod_power_only_edp(dc->current_state, stream);
-		psr_config.allow_multi_disp_optimizations =
-			(amdgpu_dc_feature_mask & DC_PSR_ALLOW_MULTI_DISP_OPT);
-
-		if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) {
-			if (!psr_su_set_dsc_slice_height(dc, link, stream, &psr_config))
-				return false;
-		}
-
-		ret = dc_link_setup_psr(link, stream, &psr_config, &psr_context);
-
-	}
-	DRM_DEBUG_DRIVER("PSR link: %d\n",	link->psr_settings.psr_feature_enabled);
-
-	return ret;
-}
-
-/*
- * amdgpu_dm_psr_enable() - enable psr f/w
- * @stream: stream state
- *
- */
-void amdgpu_dm_psr_enable(struct dc_stream_state *stream)
-{
-	struct dc_link *link = stream->link;
-	unsigned int vsync_rate_hz = 0;
-	struct dc_static_screen_params params = {0};
-	/* Calculate number of static frames before generating interrupt to
-	 * enter PSR.
-	 */
-	// Init fail safe of 2 frames static
-	unsigned int num_frames_static = 2;
-	unsigned int power_opt = 0;
-	bool psr_enable = true;
-
-	DRM_DEBUG_DRIVER("Enabling psr...\n");
-
-	vsync_rate_hz = div64_u64(div64_u64((
-			stream->timing.pix_clk_100hz * (uint64_t)100),
-			stream->timing.v_total),
-			stream->timing.h_total);
-
-	/* Round up
-	 * Calculate number of frames such that at least 30 ms of time has
-	 * passed.
-	 */
-	if (vsync_rate_hz != 0) {
-		unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
-
-		num_frames_static = (30000 / frame_time_microsec) + 1;
-	}
-
-	params.triggers.cursor_update = true;
-	params.triggers.overlay_update = true;
-	params.triggers.surface_update = true;
-	params.num_frames = num_frames_static;
+	/* Reset psr version first */
+	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
-	dc_stream_set_static_screen_params(link->ctx->dc,
-					   &stream, 1,
-					   &params);
+	if (!dc->caps.dmub_caps.psr)
+		return false;
 
-	/*
-	 * Only enable static-screen optimizations for PSR1. For PSR SU, this
-	 * causes vstartup interrupt issues, used by amdgpu_dm to send vblank
-	 * events.
-	 */
-	if (link->psr_settings.psr_version < DC_PSR_VERSION_SU_1)
-		power_opt |= psr_power_opt_z10_static_screen;
+	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
+		return false;
 
-	dc_link_set_psr_allow_active(link, &psr_enable, false, false, &power_opt);
+	if (link->type == dc_connection_none)
+		return false;
 
-	if (link->ctx->dc->caps.ips_support)
-		dc_allow_idle_optimizations(link->ctx->dc, true);
-}
+	if (link->dpcd_caps.psr_info.psr_version == 0)
+		return false;
 
-/*
- * amdgpu_dm_psr_disable() - disable psr f/w
- * @stream:  stream state
- *
- * Return: true if success
- */
-bool amdgpu_dm_psr_disable(struct dc_stream_state *stream, bool wait)
-{
-	bool psr_enable = false;
+	/*disable allow psr/psrsu/replay on eDP1*/
+	if (dc_get_edp_link_panel_inst(link->ctx->dc, link, &panel_inst) && panel_inst == 1)
+		return false;
 
-	DRM_DEBUG_DRIVER("Disabling psr...\n");
+	if (link_supports_psrsu(link))
+		link->psr_settings.psr_version = DC_PSR_VERSION_SU_1;
+	else
+		link->psr_settings.psr_version = DC_PSR_VERSION_1;
 
-	return dc_link_set_psr_allow_active(stream->link, &psr_enable, wait, false, NULL);
-}
-
-/*
- * amdgpu_dm_psr_disable_all() - disable psr f/w for all streams
- * if psr is enabled on any stream
- *
- * Return: true if success
- */
-bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm)
-{
-	DRM_DEBUG_DRIVER("Disabling psr if psr is enabled on any stream\n");
-	return dc_set_psr_allow_active(dm->dc, false);
+	amdgpu_dm_psr_fill_caps(link, &aconnector->psr_caps);
+	return true;
 }
 
 /*
@@ -250,36 +155,37 @@ bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm)
 			break;
 		}
 	}
-
 	return allow_active;
 }
 
-/**
- * amdgpu_dm_psr_wait_disable() - Wait for eDP panel to exit PSR
- * @stream: stream state attached to the eDP link
- *
- * Waits for a max of 500ms for the eDP panel to exit PSR.
+/*
+ * amdgpu_dm_psr_set_event() - set or clear PSR event for stream
+ * @dm: pointer to amdgpu_display_manager
+ * @stream: pointer to dc_stream_state
+ * @set_event: true to set event, false to clear event
+ * @event: PSR event type
+ * @wait_for_disable: whether to wait for PSR to be disabled
  *
- * Return: true if panel exited PSR, false otherwise.
+ * Return: true if successful, false otherwise
  */
-bool amdgpu_dm_psr_wait_disable(struct dc_stream_state *stream)
+bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm, struct dc_stream_state *stream,
+		bool set_event, enum psr_event event, bool wait_for_disable)
 {
-	enum dc_psr_state psr_state = PSR_STATE0;
-	struct dc_link *link = stream->link;
-	int retry_count;
+	unsigned int psr_events;
 
-	if (link == NULL)
+	/* Validate all required parameters */
+	if (!stream || !stream->link ||
+		!stream->link->psr_settings.psr_feature_enabled)
 		return false;
 
-	for (retry_count = 0; retry_count <= 1000; retry_count++) {
-		dc_link_get_psr_state(link, &psr_state);
-		if (psr_state == PSR_STATE0)
-			break;
-		udelay(500);
-	}
-
-	if (retry_count == 1000)
+	/* Get current psr events */
+	if (!mod_power_get_psr_event(dm->power_module, stream, &psr_events))
 		return false;
 
-	return true;
+	/* If all events already in desired state, return true. */
+	if ((psr_events & event) == (set_event ? event : 0))
+		return true;
+
+	return mod_power_set_psr_event(dm->power_module, stream,
+				       set_event, event, wait_for_disable);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index 4fb8626913cf..16d535806ad6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -28,16 +28,15 @@
 #define AMDGPU_DM_AMDGPU_DM_PSR_H_
 
 #include "amdgpu.h"
+#include "dc.h"
+#include "modules/inc/mod_power.h"
 
 /* the number of pageflips before enabling psr */
 #define AMDGPU_DM_PSR_ENTRY_DELAY 5
 
-void amdgpu_dm_set_psr_caps(struct dc_link *link);
-void amdgpu_dm_psr_enable(struct dc_stream_state *stream);
-bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream);
-bool amdgpu_dm_psr_disable(struct dc_stream_state *stream, bool wait);
-bool amdgpu_dm_psr_disable_all(struct amdgpu_display_manager *dm);
+bool amdgpu_dm_set_psr_caps(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
 bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm);
-bool amdgpu_dm_psr_wait_disable(struct dc_stream_state *stream);
-
+bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm,
+		struct dc_stream_state *stream, bool set_event,	enum psr_event event,
+		bool wait_for_disable);
 #endif /* AMDGPU_DM_AMDGPU_DM_PSR_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index 8c150b001105..297125d1db70 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -27,7 +27,6 @@
 #include "amdgpu_dm_replay.h"
 #include "dc_dmub_srv.h"
 #include "dc.h"
-#include "dm_helpers.h"
 #include "amdgpu_dm.h"
 #include "modules/power/power_helpers.h"
 #include "dmub/inc/dmub_cmd.h"
@@ -99,13 +98,29 @@ bool amdgpu_dm_set_replay_caps(struct dc_link *link, struct amdgpu_dm_connector
 		!dc->ctx->dmub_srv->dmub->feature_caps.replay_supported)
 		return false;
 
+	/* Mark Replay is supported in link and update related attributes
+	 * This flag presents DPCD caps & amd_vsdb caps satisfy replay requirement.
+	 */
+	pr_config.replay_cap_support = true;
+
 	// Mark Replay is supported in pr_config
 	pr_config.replay_supported = true;
 
+	pr_config.replay_enable_option = pr_enable_option_general_ui |
+					 pr_enable_option_static_screen	|
+					 pr_enable_option_static_screen_coasting;
+	pr_config.replay_power_opt_supported = replay_power_opt_smu_opt_static_screen |
+					       replay_power_opt_z10_static_screen;
+	pr_config.replay_smu_opt_supported = false;
+	pr_config.replay_support_fast_resync_in_ultra_sleep_mode =
+		aconnector->max_vfreq >= 2 * aconnector->min_vfreq;
+	pr_config.force_disable_desync_error_check = false;
+
 	debug_flags = (union replay_debug_flags *)&pr_config.debug_flags;
 	debug_flags->u32All = 0;
 	debug_flags->bitfields.visual_confirm =
 		link->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY;
+	debug_flags->bitfields.skip_crtc_disabled = dc->debug.replay_skip_crtc_disabled;
 
 	init_replay_config(link, &pr_config);
 
@@ -113,104 +128,80 @@ bool amdgpu_dm_set_replay_caps(struct dc_link *link, struct amdgpu_dm_connector
 }
 
 /*
- * amdgpu_dm_link_setup_replay() - configure replay link
- * @link: link
- * @aconnector: aconnector
+ * amdgpu_dm_link_setup_replay() - config replay settings
+ * @stream: pointer to dc_stream_state structure
+ * @vrr_params: pointer to mod_vrr_params structure containing VRR parameters
  *
+ * config replay link settings including coasting vtotal calculations.
+ *
+ * Return: true if successful, false if any parameter is invalid or replay not supported
  */
-bool amdgpu_dm_link_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
+bool amdgpu_dm_link_setup_replay(struct dc_stream_state *stream,
+		struct mod_vrr_params *vrr_params)
 {
-	struct replay_config *pr_config;
+	struct dc_link *link;
+	unsigned int static_coasting_vtotal;
+	unsigned int nom_coasting_vtotal;
 
-	if (link == NULL || aconnector == NULL)
+	if (!stream || !stream->link || !vrr_params)
 		return false;
 
-	pr_config = &link->replay_settings.config;
-
-	if (!pr_config->replay_supported)
+	link = stream->link;
+	if (!link->replay_settings.config.replay_supported)
 		return false;
 
-	pr_config->replay_power_opt_supported = 0x11;
-	pr_config->replay_smu_opt_supported = false;
-	pr_config->replay_enable_option |= pr_enable_option_static_screen;
-	pr_config->replay_support_fast_resync_in_ultra_sleep_mode = aconnector->max_vfreq >= 2 * aconnector->min_vfreq;
-	pr_config->replay_timing_sync_supported = false;
+	if (link->replay_settings.replay_feature_enabled)
+		return true;
 
-	if (!pr_config->replay_timing_sync_supported)
-		pr_config->replay_enable_option &= ~pr_enable_option_general_ui;
+	calculate_replay_link_off_frame_count(link, stream->timing.v_total,
+			stream->timing.h_total);
 
-	link->replay_settings.replay_feature_enabled = true;
+	nom_coasting_vtotal = stream->timing.v_total;
+	static_coasting_vtotal = mod_freesync_calc_v_total_from_refresh(stream,
+			vrr_params->min_refresh_in_uhz);
 
+	set_replay_coasting_vtotal(link, PR_COASTING_TYPE_NOM,
+			nom_coasting_vtotal);
+	set_replay_coasting_vtotal(link, PR_COASTING_TYPE_STATIC,
+			static_coasting_vtotal);
 	return true;
 }
 
 /*
- * amdgpu_dm_replay_enable() - enable replay f/w
- * @stream: stream state
+ * amdgpu_dm_replay_set_event() - set or clear replay event for a stream
+ * @dm: pointer to amdgpu_display_manager
+ * @stream: pointer to dc_stream_state
+ * @set_event: true to set event, false to clear event
+ * @event: replay event type to set or clear
+ * @wait_for_disable: whether to wait for replay to be disabled before returning
  *
- * Return: true if success
- */
-bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool wait)
-{
-	bool replay_active = true;
-	struct dc_link *link = NULL;
-	struct amdgpu_dm_connector *aconnector = NULL;
-
-	if (stream == NULL)
-		return false;
-
-	/* Check if replay is disabled by connector flag */
-	aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
-	if (!aconnector || aconnector->disallow_edp_enter_replay) {
-		return false;
-	}
-
-	link = stream->link;
-
-	if (link) {
-		link->dc->link_srv->dp_setup_replay(link, stream);
-		link->dc->link_srv->edp_set_coasting_vtotal(link, stream->timing.v_total, 0);
-		DRM_DEBUG_DRIVER("Enabling replay...\n");
-		link->dc->link_srv->edp_set_replay_allow_active(link, &replay_active, wait, false, NULL);
-		return true;
-	}
-
-	return false;
-}
-
-/*
- * amdgpu_dm_replay_disable() - disable replay f/w
- * @stream:  stream state
+ * This function sets or clears a specific replay event for the given stream.
+ * It temporarily disables idle optimizations during the operation to ensure
+ * hardware access is available.
  *
- * Return: true if success
+ * Return: true if successful, false if any parameter is invalid or operation fails
  */
-bool amdgpu_dm_replay_disable(struct dc_stream_state *stream)
+bool amdgpu_dm_replay_set_event(struct amdgpu_display_manager *dm,
+		struct dc_stream_state *stream,
+		bool set_event,
+		enum replay_event event,
+		bool wait_for_disable)
 {
-	bool replay_active = false;
-	struct dc_link *link = NULL;
+	unsigned int replay_events;
 
-	if (stream == NULL)
+	/* Validate all required parameters */
+	if (!stream || !stream->link ||
+		!stream->link->replay_settings.replay_feature_enabled)
 		return false;
 
-	link = stream->link;
+	/* Get current replay events */
+	if (!mod_power_get_replay_event(dm->power_module, stream, &replay_events))
+		return false;
 
-	if (link) {
-		DRM_DEBUG_DRIVER("Disabling replay...\n");
-		link->dc->link_srv->edp_set_replay_allow_active(stream->link, &replay_active, true, false, NULL);
+	/* If all events already in desired state, return true. */
+	if ((replay_events & event) == (set_event ? event : 0))
 		return true;
-	}
-
-	return false;
-}
 
-/*
- * amdgpu_dm_replay_disable_all() - disable replay f/w
- * if replay is enabled on any stream
- *
- * Return: true if success
- */
-bool amdgpu_dm_replay_disable_all(struct amdgpu_display_manager *dm)
-{
-	DRM_DEBUG_DRIVER("Disabling replay if replay is enabled on any stream\n");
-	return dc_set_replay_allow_active(dm->dc, false);
+	return mod_power_set_replay_event(dm->power_module, stream,
+					 set_event, event, wait_for_disable);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
index 73b6c67ae5e7..021bf0255516 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
@@ -28,22 +28,16 @@
 #define AMDGPU_DM_AMDGPU_DM_REPLAY_H_
 
 #include "amdgpu.h"
+#include "dc.h"
+#include "modules/inc/mod_power.h"
 
-enum replay_enable_option {
-	pr_enable_option_static_screen = 0x1,
-	pr_enable_option_mpo_video = 0x2,
-	pr_enable_option_full_screen_video = 0x4,
-	pr_enable_option_general_ui = 0x8,
-	pr_enable_option_static_screen_coasting = 0x10000,
-	pr_enable_option_mpo_video_coasting = 0x20000,
-	pr_enable_option_full_screen_video_coasting = 0x40000,
-};
-
-bool amdgpu_dm_link_supports_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
-bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool enable);
-bool amdgpu_dm_set_replay_caps(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
-bool amdgpu_dm_link_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
-bool amdgpu_dm_replay_disable(struct dc_stream_state *stream);
-bool amdgpu_dm_replay_disable_all(struct amdgpu_display_manager *dm);
-
+bool amdgpu_dm_link_supports_replay(struct dc_link *link,
+		struct amdgpu_dm_connector *aconnector);
+bool amdgpu_dm_set_replay_caps(struct dc_link *link,
+		struct amdgpu_dm_connector *aconnector);
+bool amdgpu_dm_link_setup_replay(struct dc_stream_state *stream,
+		struct mod_vrr_params *vrr_params);
+bool amdgpu_dm_replay_set_event(struct amdgpu_display_manager *dm,
+		struct dc_stream_state *stream, bool set_event,
+		enum replay_event event, bool wait_for_disable);
 #endif /* AMDGPU_DM_AMDGPU_DM_REPLAY_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 0ef7435ffda9..84dcb573d98f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -64,12 +64,28 @@ void dm_trace_smu_exit(bool success, uint32_t response, struct dc_context *ctx)
 /**** power component interfaces ****/
 
 bool dm_query_extended_brightness_caps(struct dc_context *ctx,
-	enum dm_acpi_display_type display,
-	struct dm_acpi_atif_backlight_caps *pCaps)
+	enum dm_acpi_display_type display, struct dm_acpi_atif_backlight_caps *pCaps)
 {
-	/*
-	 * TODO: Implement query for extended backlight caps.
-	 * Some plumbing required, see amdgpu_atif_query_backlight_caps()
-	 */
-	return false;
+	struct amdgpu_device *adev;
+	struct amdgpu_display_manager *dm;
+	int bl_index = (display == AcpiDisplayType_LCD1) ? 0 : 1;
+
+	if (!ctx || !pCaps || !ctx->driver_context)
+		return false;
+
+	adev = (struct amdgpu_device *)ctx->driver_context;
+	dm = &adev->dm;
+
+	amdgpu_dm_update_backlight_caps(dm, bl_index);
+
+	pCaps->num_data_points = dm->backlight_caps[bl_index].data_points;
+	pCaps->max_input_signal = dm->backlight_caps[bl_index].max_input_signal;
+	pCaps->min_input_signal = dm->backlight_caps[bl_index].min_input_signal;
+	pCaps->ac_level_percentage = dm->backlight_caps[bl_index].ac_level;
+	pCaps->dc_level_percentage = dm->backlight_caps[bl_index].dc_level;
+
+	if (pCaps->num_data_points > 0)
+		memcpy(pCaps->data_points, dm->backlight_caps[bl_index].luminance_data,
+			sizeof(struct dm_bl_data_point) * pCaps->num_data_points);
+	return true;
 }
-- 
2.43.0

