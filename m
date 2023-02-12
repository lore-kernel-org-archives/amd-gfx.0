Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71D5C64EC7
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E121110E3BC;
	Sun, 12 Feb 2023 17:00:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A07910E2ED
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOqW8G5y2J4tCtI62ryKhrWy1Y5LPv3q/Fv6ap2R4N7l5KoZx5rmyB7peNKcEQUB4QPLGcSmuQ5U3sFRlYqBtXRfXRvAYFF6YNL46iyfMZz5ACinS713m2hVNhVO8IE1vXlFwCnhcSKQBHLb3Yyk6HDZyGv4ryuxl8qeSLKPioz3gZDg+94mkdakMC9TrtQmf8V4+EfC8u0jONs1E+9nwzsIUPNlyqaP6DloZ94RuBljHAfjw4KIQE2OJjDmZj5xV/Wkav4RWJlgumDw4xmCSYZ+StLgV2GcgaqlxaReNWsJoCMt32jdTAdYUMfUTBMmdckJBgVh7mLIA96CqI/KZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN8pr1r23RBFHJ/PjAE1gQUylGYW+h11v36tqliL4ak=;
 b=MuL07FeKqjZHzYNnJXIvrt2UUekLn+gCjK/VKCzt6h4tsO68bRuPr4JpA2eow6UQZRAuQKfEk2sUu2F/YxIRe5IIprEEdO/zN3znoo4ruwQHYBsixvi4DZjoA30Mtgd1KU1UgAPmsiBPfge95qugheqBrFH2Yk/YSvcS49GnZo5Ht/XC7EA2z9tKKxPAODPuntcUYfo9CmuDsbF/zY995Y+/IQDM8M687/LTi7wCXat/s6Ft95oUUiqYoWx58ym799XogUQcVj34xNKJOVXlakwImdX+q4fjctsp5/wuDOqRocIw6vDJhFY+xYbK70ghz6CFqHQFkYiFAgdSNhONfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN8pr1r23RBFHJ/PjAE1gQUylGYW+h11v36tqliL4ak=;
 b=4AyrxHy0FSW5APMANJ8QgkCjq2yp8Dvru1GNHauSUo2Pgy9sVrkCpEcnzmvLGdCJxy4NJNU6IZ/Cw9QF/s+4tKSMDH1T1uTiDZgTLKre705brZL7trJBOp2fri44xF5aMtISSQD3iwFIcUU3cUI29GwfHIgeDqQ/zWCzoaNJcAM=
Received: from DS7PR05CA0063.namprd05.prod.outlook.com (2603:10b6:8:57::19) by
 MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sun, 12 Feb
 2023 17:00:50 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::c5) by DS7PR05CA0063.outlook.office365.com
 (2603:10b6:8:57::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:47 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:46 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/22] drm/amd/display: move public dc link function
 implementation to dc_link_exports
Date: Sun, 12 Feb 2023 11:59:50 -0500
Message-ID: <20230212165955.1993601-18-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 010646e4-9ee0-4d5a-c4e4-08db0d1ab170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7l/uYZMcdGTr0rB18tBm+5gkpNkw47a/LH0KVhqMCWMNAY86IwoV9Tn6VGogIPtxvzj4kxk63W5wilRFnafWYMSL1qPo0pqM0+yrrnDu3eAnBot/fQyr7S/PiMsbWdrhTGWs62nCJqUqnzRrpfGtiPIS6LtyaafCjWqF2kiA2SF+ZMOkfsyB6VenHXsH40leUrk0FeLCx2xcmfy5nNwEHAOvmiQsba/3WpSoLIv+7nWxPQI64n6uUVvASjZoXhLugAIGlk4ZLeP0cIUfwIc/IAYRK+3zd8a77yJST4imOHBWf6Q7ktCr6X1vZrTqtfnE4x3NeIuUvh606WblSArDjJCkT768AWWx5QFGZzJKrBT9s9Jq8ldFscoBIYpGJbIQDB9bCC2shsfgE48EQFANCfUndIW3DHtA1p9hv/JG3MWNLb+Xf//TfASFi5qHOQWltAdLO8Ia/UGm/1MlGtKpPEIo4N/1Hthnxh0Q5cWE5g15ziAQSCSGuXpozs3Kr9m33P/bzBqJZJp9bCfZlFL+NGuUC/5tg5COtqfvFq2/zWE3nCXOXcA1zYO8bEg8xjmID+wUd4ZZdKEG5r1ifF8OTgV5qVofX6jefnG9LdNmKAmlsnMoO/tDFgx16/Z16PLPuf4kIeS8L/+S8NLcieNIyaL9t9Kf3jk09kvdyD05mfxWDqH74cpXL1xvZBxMgTWLYc/zvNRQb/R0tuzWJdR2OUWTbPopqqHcx1QJasRnwo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(66899018)(36860700001)(2906002)(44832011)(86362001)(82310400005)(81166007)(82740400003)(30864003)(336012)(40460700003)(47076005)(16526019)(186003)(26005)(40480700001)(36756003)(356005)(54906003)(70206006)(70586007)(83380400001)(316002)(426003)(41300700001)(1076003)(8676002)(4326008)(478600001)(2616005)(6916009)(6666004)(5660300002)(8936002)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:49.9544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010646e4-9ee0-4d5a-c4e4-08db0d1ab170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Link is a subcomponent in dc. DM should be aware of dc link structure
as one of the abstracted objects maintained by dc. However it should
have no idea of the existence of a link component in dc dedicated to
maintain the states of dc link structure. As such we are moving link interfaces
out of dc_link.h and directly added to dc.h. We are grandually fading out
the explicit inclusion of dc_link header and eventually delete it.

On dc side, since link is a subcomponent behind dc interfaces, it is not
a good idea to implement dc interfaces in each individual subcomponent
of link which is already a subcomponent of dc. So we are decoupling it
by implementing a dc_link_exports in dc. This file will be a thin
translation layer that breaks the dependency so link is able to make
interface changes without breaking DM.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../drm/amd/display/dc/core/dc_link_exports.c | 103 +++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 208 ++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h |   3 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 136 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  47 +---
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 109 ++++-----
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  18 ++
 .../display/dc/link/accessories/link_dp_cts.c |   3 +-
 .../drm/amd/display/dc/link/link_detection.c  |  20 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   5 -
 .../drm/amd/display/dc/link/link_resource.c   |  41 +---
 .../drm/amd/display/dc/link/link_resource.h   |   2 +
 .../drm/amd/display/dc/link/link_validation.c |  14 +-
 14 files changed, 442 insertions(+), 269 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 29579e1baa93..94f156d57220 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -65,7 +65,7 @@ AMD_DC = $(addsuffix /Makefile, $(addprefix $(FULL_AMD_DISPLAY_PATH)/dc/,$(DC_LI
 include $(AMD_DC)
 
 DISPLAY_CORE = dc.o dc_stat.o dc_resource.o dc_hw_sequencer.o dc_sink.o \
-dc_surface.o dc_debug.o dc_stream.o dc_link_enc_cfg.o
+dc_surface.o dc_debug.o dc_stream.o dc_link_enc_cfg.o dc_link_exports.o
 
 DISPLAY_CORE += dc_vm_helper.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
new file mode 100644
index 000000000000..a951e10416ee
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -0,0 +1,103 @@
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
+/* FILE POLICY AND INTENDED USAGE:
+ * This file provides single entrance to link functionality declared in dc
+ * public headers. The file is intended to be used as a thin translation layer
+ * that directly calls link internal functions without adding new functional
+ * behavior.
+ *
+ * When exporting a new link related dc function, add function declaration in
+ * dc.h with detail interface documentation, then add function implementation
+ * in this file which calls link functions.
+ */
+#include "link.h"
+
+bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
+{
+	return link_detect(link, reason);
+}
+
+bool dc_link_detect_connection_type(struct dc_link *link,
+		enum dc_connection_type *type)
+{
+	return link_detect_connection_type(link, type);
+}
+
+const struct dc_link_status *dc_link_get_status(const struct dc_link *link)
+{
+	return link_get_status(link);
+}
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+
+/* return true if the connected receiver supports the hdcp version */
+bool dc_link_is_hdcp14(struct dc_link *link, enum signal_type signal)
+{
+	return link_is_hdcp14(link, signal);
+}
+
+bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal)
+{
+	return link_is_hdcp22(link, signal);
+}
+#endif
+
+void dc_link_clear_dprx_states(struct dc_link *link)
+{
+	link_clear_dprx_states(link);
+}
+
+bool dc_link_reset_cur_dp_mst_topology(struct dc_link *link)
+{
+	return link_reset_cur_dp_mst_topology(link);
+}
+
+uint32_t dc_link_bandwidth_kbps(
+	const struct dc_link *link,
+	const struct dc_link_settings *link_settings)
+{
+	return dp_link_bandwidth_kbps(link, link_settings);
+}
+
+uint32_t dc_bandwidth_in_kbps_from_timing(
+	const struct dc_crtc_timing *timing)
+{
+	return link_timing_bandwidth_kbps(timing);
+}
+
+void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map)
+{
+	link_get_cur_res_map(dc, map);
+}
+
+void dc_restore_link_res_map(const struct dc *dc, uint32_t *map)
+{
+	link_restore_res_map(dc, map);
+}
+
+bool dc_link_update_dsc_config(struct pipe_ctx *pipe_ctx)
+{
+	return link_update_dsc_config(pipe_ctx);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6e1c4b11150a..6d140b7c25a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -52,7 +52,6 @@ struct dmub_notification;
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
 #define MAX_STREAMS 6
-#define MAX_SINKS_PER_LINK 4
 #define MIN_VIEWPORT_SIZE 12
 #define MAX_NUM_EDP 2
 
@@ -1372,109 +1371,128 @@ struct dc_state *dc_copy_state(struct dc_state *src_ctx);
 void dc_retain_state(struct dc_state *context);
 void dc_release_state(struct dc_state *context);
 
+struct dc_plane_state *dc_get_surface_for_mpcc(struct dc *dc,
+		struct dc_stream_state *stream,
+		int mpcc_inst);
+
+
+uint32_t dc_get_opp_for_plane(struct dc *dc, struct dc_plane_state *plane);
+
 /* Link Interfaces */
+/* TODO: remove this after resolving external dependencies */
+#include "dc_link.h"
 
-struct dpcd_caps {
-	union dpcd_rev dpcd_rev;
-	union max_lane_count max_ln_count;
-	union max_down_spread max_down_spread;
-	union dprx_feature dprx_feature;
-
-	/* valid only for eDP v1.4 or higher*/
-	uint8_t edp_supported_link_rates_count;
-	enum dc_link_rate edp_supported_link_rates[8];
-
-	/* dongle type (DP converter, CV smart dongle) */
-	enum display_dongle_type dongle_type;
-	bool is_dongle_type_one;
-	/* branch device or sink device */
-	bool is_branch_dev;
-	/* Dongle's downstream count. */
-	union sink_count sink_count;
-	bool is_mst_capable;
-	/* If dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER,
-	indicates 'Frame Sequential-to-lllFrame Pack' conversion capability.*/
-	struct dc_dongle_caps dongle_caps;
-
-	uint32_t sink_dev_id;
-	int8_t sink_dev_id_str[6];
-	int8_t sink_hw_revision;
-	int8_t sink_fw_revision[2];
-
-	uint32_t branch_dev_id;
-	int8_t branch_dev_name[6];
-	int8_t branch_hw_revision;
-	int8_t branch_fw_revision[2];
-
-	bool allow_invalid_MSA_timing_param;
-	bool panel_mode_edp;
-	bool dpcd_display_control_capable;
-	bool ext_receiver_cap_field_present;
-	bool set_power_state_capable_edp;
-	bool dynamic_backlight_capable_edp;
-	union dpcd_fec_capability fec_cap;
-	struct dpcd_dsc_capabilities dsc_caps;
-	struct dc_lttpr_caps lttpr_caps;
-	struct adaptive_sync_caps adaptive_sync_caps;
-	struct dpcd_usb4_dp_tunneling_info usb4_dp_tun_info;
-
-	union dp_128b_132b_supported_link_rates dp_128b_132b_supported_link_rates;
-	union dp_main_line_channel_coding_cap channel_coding_cap;
-	union dp_sink_video_fallback_formats fallback_formats;
-	union dp_fec_capability1 fec_cap1;
-	union dp_cable_id cable_id;
-	uint8_t edp_rev;
-	union edp_alpm_caps alpm_caps;
-	struct edp_psr_info psr_info;
-};
-
-union dpcd_sink_ext_caps {
-	struct {
-		/* 0 - Sink supports backlight adjust via PWM during SDR/HDR mode
-		 * 1 - Sink supports backlight adjust via AUX during SDR/HDR mode.
-		 */
-		uint8_t sdr_aux_backlight_control : 1;
-		uint8_t hdr_aux_backlight_control : 1;
-		uint8_t reserved_1 : 2;
-		uint8_t oled : 1;
-		uint8_t reserved : 3;
-	} bits;
-	uint8_t raw;
-};
+/* The function initiates detection handshake over the given link. It first
+ * determines if there are display connections over the link. If so it initiates
+ * detection protocols supported by the connected receiver device. The function
+ * contains protocol specific handshake sequences which are sometimes mandatory
+ * to establish a proper connection between TX and RX. So it is always
+ * recommended to call this function as the first link operation upon HPD event
+ * or power up event. Upon completion, the function will update link structure
+ * in place based on latest RX capabilities. The function may also cause dpms
+ * to be reset to off for all currently enabled streams to the link. It is DM's
+ * responsibility to serialize detection and DPMS updates.
+ *
+ * @reason - Indicate which event triggers this detection. dc may customize
+ * detection flow depending on the triggering events.
+ * return false - if detection is not fully completed. This could happen when
+ * there is an unrecoverable error during detection or detection is partially
+ * completed (detection has been delegated to dm mst manager ie.
+ * link->connection_type == dc_connection_mst_branch when returning false).
+ * return true - detection is completed, link has been fully updated with latest
+ * detection result.
+ */
+bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason);
 
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
-union hdcp_rx_caps {
-	struct {
-		uint8_t version;
-		uint8_t reserved;
-		struct {
-			uint8_t repeater	: 1;
-			uint8_t hdcp_capable	: 1;
-			uint8_t reserved	: 6;
-		} byte0;
-	} fields;
-	uint8_t raw[3];
-};
+/* determine if there is a sink connected to the link
+ *
+ * @type - dc_connection_single if connected, dc_connection_none otherwise.
+ * return - false if an unexpected error occurs, true otherwise.
+ *
+ * NOTE: This function doesn't detect downstream sink connections i.e
+ * dc_connection_mst_branch, dc_connection_sst_branch. In this case, it will
+ * return dc_connection_single if the branch device is connected despite of
+ * downstream sink's connection status.
+ */
+bool dc_link_detect_connection_type(struct dc_link *link,
+		enum dc_connection_type *type);
 
-union hdcp_bcaps {
-	struct {
-		uint8_t HDCP_CAPABLE:1;
-		uint8_t REPEATER:1;
-		uint8_t RESERVED:6;
-	} bits;
-	uint8_t raw;
-};
+/* Getter for cached link status from given link */
+const struct dc_link_status *dc_link_get_status(const struct dc_link *link);
 
-struct hdcp_caps {
-	union hdcp_rx_caps rx_caps;
-	union hdcp_bcaps bcaps;
-};
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+/* return true if the connected receiver supports the hdcp version */
+bool dc_link_is_hdcp14(struct dc_link *link, enum signal_type signal);
+bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal);
 #endif
 
-#include "dc_link.h"
+/* The function clears recorded DP RX states in the link. DM should call this
+ * function when it is resuming from S3 power state to previously connected links.
+ *
+ * TODO - in the future we should consider to expand link resume interface to
+ * support clearing previous rx states. So we don't have to rely on dm to call
+ * this interface explicitly.
+ */
+void dc_link_clear_dprx_states(struct dc_link *link);
 
-uint32_t dc_get_opp_for_plane(struct dc *dc, struct dc_plane_state *plane);
+/* Destruct the mst topology of the link and reset the allocated payload table
+ *
+ * NOTE: this should only be called if DM chooses not to call dc_link_detect but
+ * still wants to reset MST topology on an unplug event */
+bool dc_link_reset_cur_dp_mst_topology(struct dc_link *link);
+
+/* The function calculates effective DP link bandwidth when a given link is
+ * using the given link settings.
+ *
+ * return - total effective link bandwidth in kbps.
+ */
+uint32_t dc_link_bandwidth_kbps(
+	const struct dc_link *link,
+	const struct dc_link_settings *link_setting);
+
+/* The function returns minimum bandwidth required to drive a given timing
+ * return - minimum required timing bandwidth in kbps.
+ */
+uint32_t dc_bandwidth_in_kbps_from_timing(
+	const struct dc_crtc_timing *timing);
 
+/* The function takes a snapshot of current link resource allocation state
+ * @dc: pointer to dc of the dm calling this
+ * @map: a dc link resource snapshot defined internally to dc.
+ *
+ * DM needs to capture a snapshot of current link resource allocation mapping
+ * and store it in its persistent storage.
+ *
+ * Some of the link resource is using first come first serve policy.
+ * The allocation mapping depends on original hotplug order. This information
+ * is lost after driver is loaded next time. The snapshot is used in order to
+ * restore link resource to its previous state so user will get consistent
+ * link capability allocation across reboot.
+ *
+ */
+void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map);
+
+/* This function restores link resource allocation state from a snapshot
+ * @dc: pointer to dc of the dm calling this
+ * @map: a dc link resource snapshot defined internally to dc.
+ *
+ * DM needs to call this function after initial link detection on boot and
+ * before first commit streams to restore link resource allocation state
+ * from previous boot session.
+ *
+ * Some of the link resource is using first come first serve policy.
+ * The allocation mapping depends on original hotplug order. This information
+ * is lost after driver is loaded next time. The snapshot is used in order to
+ * restore link resource to its previous state so user will get consistent
+ * link capability allocation across reboot.
+ *
+ */
+void dc_restore_link_res_map(const struct dc *dc, uint32_t *map);
+
+/* TODO: this is not meant to be exposed to DM. Should switch to stream update
+ * interface i.e stream_update->dsc_config
+ */
+bool dc_link_update_dsc_config(struct pipe_ctx *pipe_ctx);
 /* Sink Interfaces - A sink corresponds to a display output device */
 
 struct dc_container_id {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
index 7b036a772b0c..428e3a9ab65a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
@@ -178,6 +178,9 @@ enum display_dongle_type {
 	DISPLAY_DONGLE_DP_HDMI_MISMATCHED_DONGLE,
 };
 
+#define DC_MAX_EDID_BUFFER_SIZE 2048
+#define DC_EDID_BLOCK_SIZE 128
+
 struct ddc_service {
 	struct ddc *ddc_pin;
 	struct ddc_flags flags;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 184583807d45..809a1851f196 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -27,6 +27,7 @@
 #define DC_DP_TYPES_H
 
 #include "os_types.h"
+#include "dc_ddc_types.h"
 
 enum dc_lane_count {
 	LANE_COUNT_UNKNOWN = 0,
@@ -1125,4 +1126,139 @@ struct edp_psr_info {
 	uint8_t force_psrsu_cap;
 };
 
+struct dprx_states {
+	bool cable_id_written;
+};
+
+enum dpcd_downstream_port_max_bpc {
+	DOWN_STREAM_MAX_8BPC = 0,
+	DOWN_STREAM_MAX_10BPC,
+	DOWN_STREAM_MAX_12BPC,
+	DOWN_STREAM_MAX_16BPC
+};
+
+enum link_training_offset {
+	DPRX                = 0,
+	LTTPR_PHY_REPEATER1 = 1,
+	LTTPR_PHY_REPEATER2 = 2,
+	LTTPR_PHY_REPEATER3 = 3,
+	LTTPR_PHY_REPEATER4 = 4,
+	LTTPR_PHY_REPEATER5 = 5,
+	LTTPR_PHY_REPEATER6 = 6,
+	LTTPR_PHY_REPEATER7 = 7,
+	LTTPR_PHY_REPEATER8 = 8
+};
+
+#define MAX_REPEATER_CNT 8
+
+struct dc_lttpr_caps {
+	union dpcd_rev revision;
+	uint8_t mode;
+	uint8_t max_lane_count;
+	uint8_t max_link_rate;
+	uint8_t phy_repeater_cnt;
+	uint8_t max_ext_timeout;
+	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
+	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
+	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
+};
+
+struct dc_dongle_dfp_cap_ext {
+	bool supported;
+	uint16_t max_pixel_rate_in_mps;
+	uint16_t max_video_h_active_width;
+	uint16_t max_video_v_active_height;
+	struct dp_encoding_format_caps encoding_format_caps;
+	struct dp_color_depth_caps rgb_color_depth_caps;
+	struct dp_color_depth_caps ycbcr444_color_depth_caps;
+	struct dp_color_depth_caps ycbcr422_color_depth_caps;
+	struct dp_color_depth_caps ycbcr420_color_depth_caps;
+};
+
+struct dc_dongle_caps {
+	/* dongle type (DP converter, CV smart dongle) */
+	enum display_dongle_type dongle_type;
+	bool extendedCapValid;
+	/* If dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER,
+	indicates 'Frame Sequential-to-lllFrame Pack' conversion capability.*/
+	bool is_dp_hdmi_s3d_converter;
+	bool is_dp_hdmi_ycbcr422_pass_through;
+	bool is_dp_hdmi_ycbcr420_pass_through;
+	bool is_dp_hdmi_ycbcr422_converter;
+	bool is_dp_hdmi_ycbcr420_converter;
+	uint32_t dp_hdmi_max_bpc;
+	uint32_t dp_hdmi_max_pixel_clk_in_khz;
+	uint32_t dp_hdmi_frl_max_link_bw_in_kbps;
+	struct dc_dongle_dfp_cap_ext dfp_cap_ext;
+};
+
+struct dpcd_caps {
+	union dpcd_rev dpcd_rev;
+	union max_lane_count max_ln_count;
+	union max_down_spread max_down_spread;
+	union dprx_feature dprx_feature;
+
+	/* valid only for eDP v1.4 or higher*/
+	uint8_t edp_supported_link_rates_count;
+	enum dc_link_rate edp_supported_link_rates[8];
+
+	/* dongle type (DP converter, CV smart dongle) */
+	enum display_dongle_type dongle_type;
+	bool is_dongle_type_one;
+	/* branch device or sink device */
+	bool is_branch_dev;
+	/* Dongle's downstream count. */
+	union sink_count sink_count;
+	bool is_mst_capable;
+	/* If dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER,
+	indicates 'Frame Sequential-to-lllFrame Pack' conversion capability.*/
+	struct dc_dongle_caps dongle_caps;
+
+	uint32_t sink_dev_id;
+	int8_t sink_dev_id_str[6];
+	int8_t sink_hw_revision;
+	int8_t sink_fw_revision[2];
+
+	uint32_t branch_dev_id;
+	int8_t branch_dev_name[6];
+	int8_t branch_hw_revision;
+	int8_t branch_fw_revision[2];
+
+	bool allow_invalid_MSA_timing_param;
+	bool panel_mode_edp;
+	bool dpcd_display_control_capable;
+	bool ext_receiver_cap_field_present;
+	bool set_power_state_capable_edp;
+	bool dynamic_backlight_capable_edp;
+	union dpcd_fec_capability fec_cap;
+	struct dpcd_dsc_capabilities dsc_caps;
+	struct dc_lttpr_caps lttpr_caps;
+	struct adaptive_sync_caps adaptive_sync_caps;
+	struct dpcd_usb4_dp_tunneling_info usb4_dp_tun_info;
+
+	union dp_128b_132b_supported_link_rates dp_128b_132b_supported_link_rates;
+	union dp_main_line_channel_coding_cap channel_coding_cap;
+	union dp_sink_video_fallback_formats fallback_formats;
+	union dp_fec_capability1 fec_cap1;
+	union dp_cable_id cable_id;
+	uint8_t edp_rev;
+	union edp_alpm_caps alpm_caps;
+	struct edp_psr_info psr_info;
+};
+
+union dpcd_sink_ext_caps {
+	struct {
+		/* 0 - Sink supports backlight adjust via PWM during SDR/HDR mode
+		 * 1 - Sink supports backlight adjust via AUX during SDR/HDR mode.
+		 */
+		uint8_t sdr_aux_backlight_control : 1;
+		uint8_t hdr_aux_backlight_control : 1;
+		uint8_t reserved_1 : 2;
+		uint8_t oled : 1;
+		uint8_t reserved_2 : 1;
+		uint8_t miniled : 1;
+		uint8_t reserved : 1;
+	} bits;
+	uint8_t raw;
+};
 #endif /* DC_DP_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index ae51e4c1a98e..fcaf27a877ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -39,15 +39,6 @@ enum dc_link_fec_state {
 	dc_link_fec_enabled
 };
 
-struct dc_link_status {
-	bool link_active;
-	struct dpcd_caps *dpcd_caps;
-};
-
-struct dprx_states {
-	bool cable_id_written;
-};
-
 /* DP MST stream allocation (payload bandwidth number) */
 struct link_mst_stream_allocation {
 	/* DIG front */
@@ -167,6 +158,8 @@ struct dc_dpia_bw_alloc {
 	bool response_ready;   // Response ready from the CM side
 };
 
+#define MAX_SINKS_PER_LINK 4
+
 /*
  * A link contains one or more sinks and their connected status.
  * The currently active signal type (HDMI, DP-SST, DP-MST) is also reported.
@@ -302,7 +295,6 @@ struct dc_link {
 	struct phy_state phy_state;
 };
 
-const struct dc_link_status *dc_link_get_status(const struct dc_link *dc_link);
 
 /**
  * dc_get_link_at_index() - Return an enumerated dc_link.
@@ -385,23 +377,6 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
 		const struct dc_stream_state *stream, struct psr_config *psr_config,
 		struct psr_context *psr_context);
 
-/* Request DC to detect if there is a Panel connected.
- * boot - If this call is during initial boot.
- * Return false for any type of detection failure or MST detection
- * true otherwise. True meaning further action is required (status update
- * and OS notification).
- */
-enum dc_detect_reason {
-	DETECT_REASON_BOOT,
-	DETECT_REASON_RESUMEFROMS3S4,
-	DETECT_REASON_HPD,
-	DETECT_REASON_HPDRX,
-	DETECT_REASON_FALLBACK,
-	DETECT_REASON_RETRAIN,
-	DETECT_REASON_TDR,
-};
-
-bool dc_link_detect(struct dc_link *dc_link, enum dc_detect_reason reason);
 bool dc_link_get_hpd_state(struct dc_link *dc_link);
 
 /* Notify DC about DP RX Interrupt (aka Short Pulse Interrupt).
@@ -471,16 +446,10 @@ bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_
 void dc_link_enable_hpd_filter(struct dc_link *link, bool enable);
 
 bool dc_link_is_dp_sink_present(struct dc_link *link);
-
-bool dc_link_detect_connection_type(struct dc_link *link, enum dc_connection_type *type);
 /*
  * DPCD access interfaces
  */
 
-#ifdef CONFIG_DRM_AMD_DC_HDCP
-bool dc_link_is_hdcp14(struct dc_link *link, enum signal_type signal);
-bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal);
-#endif
 void dc_link_set_drive_settings(struct dc *dc,
 				struct link_training_settings *lt_settings,
 				const struct dc_link *link);
@@ -500,9 +469,6 @@ void dc_link_set_test_pattern(struct dc_link *link,
 			const struct link_training_settings *p_link_settings,
 			const unsigned char *p_custom_pattern,
 			unsigned int cust_pattern_size);
-uint32_t dc_link_bandwidth_kbps(
-	const struct dc_link *link,
-	const struct dc_link_settings *link_setting);
 
 const struct dc_link_settings *dc_link_get_link_cap(
 		const struct dc_link *link);
@@ -524,22 +490,16 @@ bool dc_submit_i2c_oem(
 		struct dc *dc,
 		struct i2c_command *cmd);
 
-uint32_t dc_bandwidth_in_kbps_from_timing(
-	const struct dc_crtc_timing *timing);
-
 bool dc_link_is_fec_supported(const struct dc_link *link);
 bool dc_link_should_enable_fec(const struct dc_link *link);
 
 uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw);
 enum dp_link_encoding dc_link_dp_mst_decide_link_encoding_format(const struct dc_link *link);
 
-void dc_link_get_cur_link_res(const struct dc_link *link,
-		struct link_resource *link_res);
 /* take a snapshot of current link resource allocation state */
 void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map);
 /* restore link resource allocation state from a snapshot */
 void dc_restore_link_res_map(const struct dc *dc, uint32_t *map);
-void dc_link_clear_dprx_states(struct dc_link *link);
 void dp_trace_reset(struct dc_link *link);
 bool dc_dp_trace_is_initialized(struct dc_link *link);
 unsigned long long dc_dp_trace_get_lt_end_timestamp(struct dc_link *link,
@@ -553,9 +513,6 @@ struct dp_trace_lt_counts *dc_dp_trace_get_lt_counts(struct dc_link *link,
 		bool in_detection);
 unsigned int dc_dp_trace_get_link_loss_count(struct dc_link *link);
 
-/* Destruct the mst topology of the link and reset the allocated payload table */
-bool dc_link_reset_cur_dp_mst_topology(struct dc_link *link);
-
 /* Attempt to transfer the given aux payload. This function does not perform
  * retries or handle error states. The reply is returned in the payload->reply
  * and the result through operation_result. Returns the number of bytes
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index f653eca09ba7..27d0242d6cbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -32,6 +32,7 @@
 #include "os_types.h"
 #include "fixed31_32.h"
 #include "irq_types.h"
+#include "dc_ddc_types.h"
 #include "dc_dp_types.h"
 #include "dc_hdmi_types.h"
 #include "dc_hw_types.h"
@@ -83,13 +84,8 @@ struct dc_perf_trace {
 	unsigned long last_entry_write;
 };
 
-#define DC_MAX_EDID_BUFFER_SIZE 2048
-#define DC_EDID_BLOCK_SIZE 128
 #define MAX_SURFACE_NUM 4
 #define NUM_PIXEL_FORMATS 10
-#define MAX_REPEATER_CNT 8
-
-#include "dc_ddc_types.h"
 
 enum tiling_mode {
 	TILING_MODE_INVALID,
@@ -375,66 +371,6 @@ struct dc_csc_adjustments {
 	struct fixed31_32 hue;
 };
 
-enum dpcd_downstream_port_max_bpc {
-	DOWN_STREAM_MAX_8BPC = 0,
-	DOWN_STREAM_MAX_10BPC,
-	DOWN_STREAM_MAX_12BPC,
-	DOWN_STREAM_MAX_16BPC
-};
-
-
-enum link_training_offset {
-	DPRX                = 0,
-	LTTPR_PHY_REPEATER1 = 1,
-	LTTPR_PHY_REPEATER2 = 2,
-	LTTPR_PHY_REPEATER3 = 3,
-	LTTPR_PHY_REPEATER4 = 4,
-	LTTPR_PHY_REPEATER5 = 5,
-	LTTPR_PHY_REPEATER6 = 6,
-	LTTPR_PHY_REPEATER7 = 7,
-	LTTPR_PHY_REPEATER8 = 8
-};
-
-struct dc_lttpr_caps {
-	union dpcd_rev revision;
-	uint8_t mode;
-	uint8_t max_lane_count;
-	uint8_t max_link_rate;
-	uint8_t phy_repeater_cnt;
-	uint8_t max_ext_timeout;
-	union dp_main_link_channel_coding_lttpr_cap main_link_channel_coding;
-	union dp_128b_132b_supported_lttpr_link_rates supported_128b_132b_rates;
-	uint8_t aux_rd_interval[MAX_REPEATER_CNT - 1];
-};
-
-struct dc_dongle_dfp_cap_ext {
-	bool supported;
-	uint16_t max_pixel_rate_in_mps;
-	uint16_t max_video_h_active_width;
-	uint16_t max_video_v_active_height;
-	struct dp_encoding_format_caps encoding_format_caps;
-	struct dp_color_depth_caps rgb_color_depth_caps;
-	struct dp_color_depth_caps ycbcr444_color_depth_caps;
-	struct dp_color_depth_caps ycbcr422_color_depth_caps;
-	struct dp_color_depth_caps ycbcr420_color_depth_caps;
-};
-
-struct dc_dongle_caps {
-	/* dongle type (DP converter, CV smart dongle) */
-	enum display_dongle_type dongle_type;
-	bool extendedCapValid;
-	/* If dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER,
-	indicates 'Frame Sequential-to-lllFrame Pack' conversion capability.*/
-	bool is_dp_hdmi_s3d_converter;
-	bool is_dp_hdmi_ycbcr422_pass_through;
-	bool is_dp_hdmi_ycbcr420_pass_through;
-	bool is_dp_hdmi_ycbcr422_converter;
-	bool is_dp_hdmi_ycbcr420_converter;
-	uint32_t dp_hdmi_max_bpc;
-	uint32_t dp_hdmi_max_pixel_clk_in_khz;
-	uint32_t dp_hdmi_frl_max_link_bw_in_kbps;
-	struct dc_dongle_dfp_cap_ext dfp_cap_ext;
-};
 /* Scaling format */
 enum scaling_transformation {
 	SCALING_TRANSFORMATION_UNINITIALIZED,
@@ -1003,4 +939,47 @@ struct otg_phy_mux {
 };
 #endif
 
+enum dc_detect_reason {
+	DETECT_REASON_BOOT,
+	DETECT_REASON_RESUMEFROMS3S4,
+	DETECT_REASON_HPD,
+	DETECT_REASON_HPDRX,
+	DETECT_REASON_FALLBACK,
+	DETECT_REASON_RETRAIN,
+	DETECT_REASON_TDR,
+};
+
+struct dc_link_status {
+	bool link_active;
+	struct dpcd_caps *dpcd_caps;
+};
+
+#if defined(CONFIG_DRM_AMD_DC_HDCP)
+union hdcp_rx_caps {
+	struct {
+		uint8_t version;
+		uint8_t reserved;
+		struct {
+			uint8_t repeater	: 1;
+			uint8_t hdcp_capable	: 1;
+			uint8_t reserved	: 6;
+		} byte0;
+	} fields;
+	uint8_t raw[3];
+};
+
+union hdcp_bcaps {
+	struct {
+		uint8_t HDCP_CAPABLE:1;
+		uint8_t REPEATER:1;
+		uint8_t RESERVED:6;
+	} bits;
+	uint8_t raw;
+};
+
+struct hdcp_caps {
+	union hdcp_rx_caps rx_caps;
+	union hdcp_bcaps bcaps;
+};
+#endif
 #endif /* DC_TYPES_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link.h b/drivers/gpu/drm/amd/display/dc/inc/link.h
index 5e8eb367eede..e70fa0059223 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link.h
@@ -136,4 +136,22 @@ enum dc_status link_validate_mode_timing(
 		const struct dc_stream_state *stream,
 		struct dc_link *link,
 		const struct dc_crtc_timing *timing);
+bool link_detect(struct dc_link *link, enum dc_detect_reason reason);
+bool link_detect_connection_type(struct dc_link *link,
+		enum dc_connection_type *type);
+const struct dc_link_status *link_get_status(const struct dc_link *link);
+#ifdef CONFIG_DRM_AMD_DC_HDCP
+/* return true if the connected receiver supports the hdcp version */
+bool link_is_hdcp14(struct dc_link *link, enum signal_type signal);
+bool link_is_hdcp22(struct dc_link *link, enum signal_type signal);
+#endif
+void link_clear_dprx_states(struct dc_link *link);
+bool link_reset_cur_dp_mst_topology(struct dc_link *link);
+uint32_t dp_link_bandwidth_kbps(
+	const struct dc_link *link,
+	const struct dc_link_settings *link_settings);
+uint32_t link_timing_bandwidth_kbps(const struct dc_crtc_timing *timing);
+void link_get_cur_res_map(const struct dc *dc, uint32_t *map);
+void link_restore_res_map(const struct dc *dc, uint32_t *map);
+
 #endif /* __DC_LINK_HPD_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index ee290ec247de..942300e0bd92 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -23,6 +23,7 @@
  *
  */
 #include "link_dp_cts.h"
+#include "link/link_resource.h"
 #include "link/protocols/link_dpcd.h"
 #include "link/protocols/link_dp_training.h"
 #include "link/protocols/link_dp_phy.h"
@@ -955,7 +956,7 @@ void dc_link_set_drive_settings(struct dc *dc,
 	if (i >= dc->link_count)
 		ASSERT_CRITICAL(false);
 
-	dc_link_get_cur_link_res(link, &link_res);
+	link_get_cur_link_res(link, &link_res);
 	dp_set_drive_settings(dc->links[i], &link_res, lt_settings);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 001a4ac9bfcf..c0a230161d30 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -714,7 +714,7 @@ static bool discover_dp_mst_topology(struct dc_link *link, enum dc_detect_reason
 	return link->type == dc_connection_mst_branch;
 }
 
-static bool reset_cur_dp_mst_topology(struct dc_link *link)
+bool link_reset_cur_dp_mst_topology(struct dc_link *link)
 {
 	DC_LOGGER_INIT(link->ctx->logger);
 
@@ -725,10 +725,6 @@ static bool reset_cur_dp_mst_topology(struct dc_link *link)
 	return dm_helpers_dp_mst_stop_top_mgr(link->ctx, link);
 }
 
-bool dc_link_reset_cur_dp_mst_topology(struct dc_link *link)
-{
-	return reset_cur_dp_mst_topology(link);
-}
 static bool should_prepare_phy_clocks_for_link_verification(const struct dc *dc,
 		enum dc_detect_reason reason)
 {
@@ -1201,7 +1197,7 @@ static bool detect_link_and_local_sink(struct dc_link *link,
  * Does not detect downstream devices, such as MST sinks
  * or display connected through active dongles
  */
-bool dc_link_detect_connection_type(struct dc_link *link, enum dc_connection_type *type)
+bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *type)
 {
 	uint32_t is_hpd_high = 0;
 
@@ -1244,7 +1240,7 @@ bool dc_link_detect_connection_type(struct dc_link *link, enum dc_connection_typ
 	return false;
 }
 
-bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
+bool link_detect(struct dc_link *link, enum dc_detect_reason reason)
 {
 	bool is_local_sink_detect_success;
 	bool is_delegated_to_mst_top_mgr = false;
@@ -1263,18 +1259,18 @@ bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
 	if (is_local_sink_detect_success &&
 			pre_link_type == dc_connection_mst_branch &&
 			link->type != dc_connection_mst_branch)
-		is_delegated_to_mst_top_mgr = reset_cur_dp_mst_topology(link);
+		is_delegated_to_mst_top_mgr = link_reset_cur_dp_mst_topology(link);
 
 	return is_local_sink_detect_success && !is_delegated_to_mst_top_mgr;
 }
 
-void dc_link_clear_dprx_states(struct dc_link *link)
+void link_clear_dprx_states(struct dc_link *link)
 {
 	memset(&link->dprx_states, 0, sizeof(link->dprx_states));
 }
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 
-bool dc_link_is_hdcp14(struct dc_link *link, enum signal_type signal)
+bool link_is_hdcp14(struct dc_link *link, enum signal_type signal)
 {
 	bool ret = false;
 
@@ -1298,7 +1294,7 @@ bool dc_link_is_hdcp14(struct dc_link *link, enum signal_type signal)
 	return ret;
 }
 
-bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal)
+bool link_is_hdcp22(struct dc_link *link, enum signal_type signal)
 {
 	bool ret = false;
 
@@ -1322,7 +1318,7 @@ bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal)
 }
 #endif // CONFIG_DRM_AMD_DC_HDCP
 
-const struct dc_link_status *dc_link_get_status(const struct dc_link *link)
+const struct dc_link_status *link_get_status(const struct dc_link *link)
 {
 	return &link->link_status;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 3ab7bab2fed9..5adab56403ae 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -959,11 +959,6 @@ bool link_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable)
 	return result;
 }
 
-bool dc_link_update_dsc_config(struct pipe_ctx *pipe_ctx)
-{
-	return link_update_dsc_config(pipe_ctx);
-}
-
 bool link_update_dsc_config(struct pipe_ctx *pipe_ctx)
 {
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_resource.c b/drivers/gpu/drm/amd/display/dc/link/link_resource.c
index 0027a7206073..bd42bb273c0c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_resource.c
@@ -29,7 +29,7 @@
 #include "link_resource.h"
 #include "protocols/link_dp_capability.h"
 
-void dc_link_get_cur_link_res(const struct dc_link *link,
+void link_get_cur_link_res(const struct dc_link *link,
 		struct link_resource *link_res)
 {
 	int i;
@@ -49,24 +49,7 @@ void dc_link_get_cur_link_res(const struct dc_link *link,
 
 }
 
-/**
- * dc_get_cur_link_res_map() - take a snapshot of current link resource allocation state
- * @dc: pointer to dc of the dm calling this
- * @map: a dc link resource snapshot defined internally to dc.
- *
- * DM needs to capture a snapshot of current link resource allocation mapping
- * and store it in its persistent storage.
- *
- * Some of the link resource is using first come first serve policy.
- * The allocation mapping depends on original hotplug order. This information
- * is lost after driver is loaded next time. The snapshot is used in order to
- * restore link resource to its previous state so user will get consistent
- * link capability allocation across reboot.
- *
- * Return: none (void function)
- *
- */
-void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map)
+void link_get_cur_res_map(const struct dc *dc, uint32_t *map)
 {
 	struct dc_link *link;
 	uint32_t i;
@@ -89,25 +72,7 @@ void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map)
 	}
 }
 
-/**
- * dc_restore_link_res_map() - restore link resource allocation state from a snapshot
- * @dc: pointer to dc of the dm calling this
- * @map: a dc link resource snapshot defined internally to dc.
- *
- * DM needs to call this function after initial link detection on boot and
- * before first commit streams to restore link resource allocation state
- * from previous boot session.
- *
- * Some of the link resource is using first come first serve policy.
- * The allocation mapping depends on original hotplug order. This information
- * is lost after driver is loaded next time. The snapshot is used in order to
- * restore link resource to its previous state so user will get consistent
- * link capability allocation across reboot.
- *
- * Return: none (void function)
- *
- */
-void dc_restore_link_res_map(const struct dc *dc, uint32_t *map)
+void link_restore_res_map(const struct dc *dc, uint32_t *map)
 {
 	struct dc_link *link;
 	uint32_t i;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_resource.h b/drivers/gpu/drm/amd/display/dc/link/link_resource.h
index fb01b3caf5a4..45554d30adf0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_resource.h
@@ -25,5 +25,7 @@
 #ifndef __LINK_RESOURCE_H__
 #define __LINK_RESOURCE_H__
 #include "link.h"
+void link_get_cur_link_res(const struct dc_link *link,
+		struct link_resource *link_res);
 
 #endif /* __LINK_RESOURCE_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_validation.c b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
index cd821d077d73..88ff7336f8cc 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_validation.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_validation.c
@@ -216,20 +216,20 @@ static bool dp_active_dongle_validate_timing(
 	return true;
 }
 
-uint32_t dc_link_bandwidth_kbps(
+uint32_t dp_link_bandwidth_kbps(
 	const struct dc_link *link,
-	const struct dc_link_settings *link_setting)
+	const struct dc_link_settings *link_settings)
 {
 	uint32_t total_data_bw_efficiency_x10000 = 0;
 	uint32_t link_rate_per_lane_kbps = 0;
 
-	switch (link_dp_get_encoding_format(link_setting)) {
+	switch (link_dp_get_encoding_format(link_settings)) {
 	case DP_8b_10b_ENCODING:
 		/* For 8b/10b encoding:
 		 * link rate is defined in the unit of LINK_RATE_REF_FREQ_IN_KHZ per DP byte per lane.
 		 * data bandwidth efficiency is 80% with additional 3% overhead if FEC is supported.
 		 */
-		link_rate_per_lane_kbps = link_setting->link_rate * LINK_RATE_REF_FREQ_IN_KHZ * BITS_PER_DP_BYTE;
+		link_rate_per_lane_kbps = link_settings->link_rate * LINK_RATE_REF_FREQ_IN_KHZ * BITS_PER_DP_BYTE;
 		total_data_bw_efficiency_x10000 = DATA_EFFICIENCY_8b_10b_x10000;
 		if (dc_link_should_enable_fec(link)) {
 			total_data_bw_efficiency_x10000 /= 100;
@@ -241,7 +241,7 @@ uint32_t dc_link_bandwidth_kbps(
 		 * link rate is defined in the unit of 10mbps per lane.
 		 * total data bandwidth efficiency is always 96.71%.
 		 */
-		link_rate_per_lane_kbps = link_setting->link_rate * 10000;
+		link_rate_per_lane_kbps = link_settings->link_rate * 10000;
 		total_data_bw_efficiency_x10000 = DATA_EFFICIENCY_128b_132b_x10000;
 		break;
 	default:
@@ -249,10 +249,10 @@ uint32_t dc_link_bandwidth_kbps(
 	}
 
 	/* overall effective link bandwidth = link rate per lane * lane count * total data bandwidth efficiency */
-	return link_rate_per_lane_kbps * link_setting->lane_count / 10000 * total_data_bw_efficiency_x10000;
+	return link_rate_per_lane_kbps * link_settings->lane_count / 10000 * total_data_bw_efficiency_x10000;
 }
 
-uint32_t dc_bandwidth_in_kbps_from_timing(
+uint32_t link_timing_bandwidth_kbps(
 	const struct dc_crtc_timing *timing)
 {
 	uint32_t bits_per_channel = 0;
-- 
2.25.1

