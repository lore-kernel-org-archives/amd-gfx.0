Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4340C001DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 19:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6312410E2EC;
	Mon, 10 Jul 2023 19:27:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12B1D89D7C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 19:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ougt35Ir/aB4VGS7iMZ6eB+VG/Xcovw72B5f+5BFoG+f7JGHEGkG3vRQCjfeZK1VMS+HuVThpa8AC7JsvC6dTkBNabA7fYi0fZyCrXv+PGJmulVLIwYVkCP0JTBag71+dIqPwSlEztWBcDVYn5KAUGrbBNyw/TxdnbP1nrWnO7nEapj5uFCjn/klizsUZi4e5ywth1ci5xC8YXKW3PnUKaR7uB0XIZDT65BzkrOpsOIygXho6tmeBG80RUfy+Rh70x4eTdqrk6vJEeYR/Wx4Drj8T/BJK6xfkYlC+dc183/rscLtoD8df69Gn7xggCVR7+mqDan//R68+hyk+lpihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MM8GIU2fZCuaFNY2xyNW7js81Kse150DMxwgACH5R3o=;
 b=ju+6pb2M4ntv+2EhYUWob2JiSZHhw4rJuwO0odmgUfQIIDqgHW8c1MNelcY/O85Re8nSECnm3GNhzFO9z2lnz6lXyOBREDBHKhwHNKJjSsOroCthetrNdqhqmDfoxw/N+wvnjjn6U/Y9XdHNtmTsF5oJAFSp1HEviLhCxKIZhrkbZuzL7gL0PeUyu3lAXS6B1Ga5uJ2ivdf2ptvyLPWszpjgFLsHlxEFwnZ5oYJURKIMrx0WpIkaayNAshPQrFJPxLX4SRFXbgkcDRE7AQG7e8750ZaVH+IG5uHO7OufLEBbXCcrFsFIHpStSG2qkU8H1vtFF4u61ZLrGp0WRaMwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MM8GIU2fZCuaFNY2xyNW7js81Kse150DMxwgACH5R3o=;
 b=Uupq3gYycaRSQbcfKdGlC3iY2uRFcEPFMwkQ7ixFD78HSJ9L/ysYkSeX67uTVg1GBdFR19auVP2J8RtdephH4C/DGgZCT/bGaaYhEvQUQYZ5P4NdvkwbjvwVg1ywJ9Oifg6poUj6XochMxz302GzrvrDQAF5I/F6c0mDQL07AKw=
Received: from DS7PR03CA0144.namprd03.prod.outlook.com (2603:10b6:5:3b4::29)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 19:27:38 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::1b) by DS7PR03CA0144.outlook.office365.com
 (2603:10b6:5:3b4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 19:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 19:27:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:37 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 14:27:37 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 03/10] drm/amd/display: Add Freesync Panel DM code
Date: Mon, 10 Jul 2023 15:27:26 -0400
Message-ID: <20230710192733.1344403-4-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d5c65b-60ac-423c-3786-08db817bb896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMCVY2K4W2Za4lYqG4bG9vzNvFptaKGfQXaJUbl5MMX4mrDoXn4MSj7Bkp44PNHXOnM+9HTEo3v3gP/QENPIdQmEmHSgktK89j45w6XjfGup9jzu91GC2wpg1mvTuMkw18PWlYoHjDDXQhTkbxw5HOHma+sxxcA8CJ3n+pCKeHzgcBK7a4+zd8Pq0tfcC92CtmpVVhz7UKRX3dp8WNVbU6QARsXQjHHNjnvP8d4rJEpp3DFwUOakBBDqATU2/XPjCcaiJlfZ/aKOlnQXUIUxEEB3dk62AzSeuWZEvNQIHZoTDT31Lq7uOsNvGK1izbxyEcXLlZgnrQrrUmEJthfnSrl+wOU6jsKgA5XSrIX2ta46QlMZyyrQf9CGV6920+Z/pW9zzLGg2BQD2OJsnVyIXdiIqtv77kSsK8Do1Hb4WOTCQjWxND5zz9vZ7HaY7XoKRK8Q4/rDNcizl3BSZG6ioPTck7SJTl6cgxXuA65/MQ94hZbNs/dJKlYZV04z7SHQcBVyWXm7g7ca0Rh862TB/fyYRpwYE3o0TZ9q4IsNXZlfVnM03a7czvNfKXvEkuej278k1oEahVjdVnB+ucNNNVOxLwtUuRppF4sMrAO6Hk7gC6lzEFXjnxOfk8/P0kb1xfUk/UzdcT46x794/nAJxzxWga6pwz8A69p0zIWPhvbvdTDaMkYPxjm5UM0VJE6FPqVkF0ExFMw4ivlc1d8ENB/pSywas0GEGV9WbWKoxo2KFCHqGjUkYTcoeLYOLac9hKnLtb52H91rfDpHaMZxRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(186003)(26005)(2616005)(1076003)(36860700001)(336012)(83380400001)(47076005)(426003)(41300700001)(4326008)(30864003)(6636002)(316002)(2906002)(5660300002)(8676002)(8936002)(478600001)(7696005)(6666004)(70586007)(70206006)(110136005)(40480700001)(36756003)(356005)(81166007)(82740400003)(86362001)(82310400005)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:27:38.0088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d5c65b-60ac-423c-3786-08db817bb896
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492
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

We need certain conditions for replay to be enabled, so create an
interface in DM to enable/disable replay.

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  | 176 ++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |  46 +++++
 .../drm/amd/display/dc/core/dc_link_exports.c |   5 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
 .../amd/display/modules/power/power_helpers.c |   5 +
 .../amd/display/modules/power/power_helpers.h |   2 +
 7 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 249b073f6a23..8bf94920d23e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -38,7 +38,7 @@ AMDGPUDM += dc_fpu.o
 endif
 
 ifneq ($(CONFIG_DRM_AMD_DC),)
-AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o amdgpu_dm_psr.o
+AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o amdgpu_dm_psr.o amdgpu_dm_replay.o
 endif
 
 AMDGPUDM += amdgpu_dm_hdcp.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
new file mode 100644
index 000000000000..b3e14997b470
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -0,0 +1,176 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "amdgpu_dm_replay.h"
+#include "dc.h"
+#include "dm_helpers.h"
+#include "amdgpu_dm.h"
+#include "modules/power/power_helpers.h"
+#include "dmub/inc/dmub_cmd.h"
+#include "dc/inc/link.h"
+
+/*
+ * link_supports_replay() - check if the link supports replay
+ * @link: link
+ * @aconnector: aconnector
+ *
+ */
+static bool link_supports_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
+{
+	struct dm_connector_state *state = to_dm_connector_state(aconnector->base.state);
+	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
+	struct adaptive_sync_caps *as_caps = &link->dpcd_caps.adaptive_sync_caps;
+
+	if (!state->freesync_capable)
+		return false;
+
+	// Check the eDP version
+	if (dpcd_caps->edp_rev < EDP_REVISION_13)
+		return false;
+
+	if (!dpcd_caps->alpm_caps.bits.AUX_WAKE_ALPM_CAP)
+		return false;
+
+	// Check adaptive sync support cap
+	if (!as_caps->dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT)
+		return false;
+
+	return true;
+}
+
+/*
+ * amdgpu_dm_setup_replay() - setup replay configuration
+ * @link: link
+ * @aconnector: aconnector
+ *
+ */
+bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
+{
+	struct replay_config pr_config;
+	union replay_debug_flags *debug_flags = NULL;
+
+	if (!dc_is_embedded_signal(link->connector_signal))
+		return false;
+
+	if (link->panel_config.psr.disallow_replay)
+		return false;
+
+	if (!link_supports_replay(link, aconnector))
+		return false;
+
+	// Mark Replay is supported in link and update related attributes
+	pr_config.replay_supported = true;
+	pr_config.replay_power_opt_supported = 0;
+	pr_config.replay_enable_option |= pr_enable_option_static_screen;
+	pr_config.replay_timing_sync_supported = aconnector->max_vfreq >= 2 * aconnector->min_vfreq ? true : false;
+
+	if (!pr_config.replay_timing_sync_supported)
+		pr_config.replay_enable_option &= ~pr_enable_option_general_ui;
+
+	debug_flags = (union replay_debug_flags *)&pr_config.debug_flags;
+	debug_flags->u32All = 0;
+	debug_flags->bitfields.visual_confirm =
+		link->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY ? true : false;
+
+	link->replay_settings.replay_feature_enabled = true;
+
+	init_replay_config(link, &pr_config);
+
+	return true;
+}
+
+
+/*
+ * amdgpu_dm_replay_enable() - enable replay f/w
+ * @stream: stream state
+ *
+ * Return: true if success
+ */
+bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool wait)
+{
+	uint64_t state;
+	unsigned int retry_count;
+	bool replay_active = true;
+	const unsigned int max_retry = 1000;
+	bool force_static = true;
+	struct dc_link *link = NULL;
+
+
+	if (stream == NULL)
+		return false;
+
+	link = stream->link;
+
+	if (link == NULL)
+		return false;
+
+	link->dc->link_srv->edp_setup_replay(link, stream);
+
+	link->dc->link_srv->edp_set_replay_allow_active(link, NULL, false, false, NULL);
+
+	link->dc->link_srv->edp_set_replay_allow_active(link, &replay_active, false, true, NULL);
+
+	if (wait == true) {
+
+		for (retry_count = 0; retry_count <= max_retry; retry_count++) {
+			dc_link_get_replay_state(link, &state);
+			if (replay_active) {
+				if (state != REPLAY_STATE_0 &&
+					(!force_static || state == REPLAY_STATE_3))
+					break;
+			} else {
+				if (state == REPLAY_STATE_0)
+					break;
+			}
+			udelay(500);
+		}
+
+		/* assert if max retry hit */
+		if (retry_count >= max_retry)
+			ASSERT(0);
+	} else {
+		/* To-do: Add trace log */
+	}
+
+	return true;
+}
+
+/*
+ * amdgpu_dm_replay_disable() - disable replay f/w
+ * @stream:  stream state
+ *
+ * Return: true if success
+ */
+bool amdgpu_dm_replay_disable(struct dc_stream_state *stream)
+{
+
+	if (stream->link) {
+		DRM_DEBUG_DRIVER("Disabling replay...\n");
+		stream->link->dc->link_srv->edp_set_replay_allow_active(stream->link, NULL, false, false, NULL);
+		return true;
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
new file mode 100644
index 000000000000..01cba3cd6246
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef AMDGPU_DM_AMDGPU_DM_REPLAY_H_
+#define AMDGPU_DM_AMDGPU_DM_REPLAY_H_
+
+#include "amdgpu.h"
+
+enum replay_enable_option {
+	pr_enable_option_static_screen = 0x1,
+	pr_enable_option_mpo_video = 0x2,
+	pr_enable_option_full_screen_video = 0x4,
+	pr_enable_option_general_ui = 0x8,
+	pr_enable_option_static_screen_coasting = 0x10000,
+	pr_enable_option_mpo_video_coasting = 0x20000,
+	pr_enable_option_full_screen_video_coasting = 0x40000,
+};
+
+
+bool amdgpu_dm_replay_enable(struct dc_stream_state *stream, bool enable);
+bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *aconnector);
+bool amdgpu_dm_replay_disable(struct dc_stream_state *stream);
+
+#endif /* AMDGPU_DM_AMDGPU_DM_REPLAY_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 18e098568cb4..d531f980896d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -449,6 +449,11 @@ bool dc_link_setup_psr(struct dc_link *link,
 	return link->dc->link_srv->edp_setup_psr(link, stream, psr_config, psr_context);
 }
 
+bool dc_link_get_replay_state(const struct dc_link *link, uint64_t *state)
+{
+	return link->dc->link_srv->edp_get_replay_state(link, state);
+}
+
 bool dc_link_wait_for_t12(struct dc_link *link)
 {
 	return link->dc->link_srv->edp_wait_for_t12(link);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3a7208a86541..044b7bef56fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1975,6 +1975,8 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
 		const struct dc_stream_state *stream, struct psr_config *psr_config,
 		struct psr_context *psr_context);
 
+bool dc_link_get_replay_state(const struct dc_link *dc_link, uint64_t *state);
+
 /* On eDP links this function call will stall until T12 has elapsed.
  * If the panel is not in power off state, this function will return
  * immediately.
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 30349881a283..73a2b37fbbd7 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -926,6 +926,11 @@ void mod_power_calc_psr_configs(struct psr_config *psr_config,
 		!link->dpcd_caps.psr_info.psr_dpcd_caps.bits.LINK_TRAINING_ON_EXIT_NOT_REQUIRED;
 }
 
+void init_replay_config(struct dc_link *link, struct replay_config *pr_config)
+{
+	link->replay_settings.config = *pr_config;
+}
+
 bool mod_power_only_edp(const struct dc_state *context, const struct dc_stream_state *stream)
 {
 	return context && context->stream_count == 1 && dc_is_embedded_signal(stream->signal);
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index ffc924c9991b..d9e0d67d67f7 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -53,6 +53,8 @@ bool dmub_init_abm_config(struct resource_pool *res_pool,
 		struct dmcu_iram_parameters params,
 		unsigned int inst);
 
+void init_replay_config(struct dc_link *link, struct replay_config *pr_config);
+
 bool is_psr_su_specific_panel(struct dc_link *link);
 void mod_power_calc_psr_configs(struct psr_config *psr_config,
 		struct dc_link *link,
-- 
2.25.1

