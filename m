Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1074AC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A264310ED09;
	Wed,  5 Aug 2026 06:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D+mjhYA5";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6EF10ED09
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLBOOODUI1fl6L81Ww4yC8gl6gH/1mNzPdugdLOVtt1yyoAcC9poBf/ZJRvThKCoRXqsKQJOdVNT6f0rP9NCT/cV4Qq/HD/jSQps1dWtSnCu6oYUiIHtsoz57Nuc/j2j3Uf3KCqZk853JlGmi4FFAbvSJRQMZFOGwRf0aOj8q90slAWRvWrN0pxP15k/IyJ/Uki2pb7ruwpK5D1+WRnFhXXIJ99UZlcMEa08WsM9UDh5d4SuWFIyCs1/dG9KT1PuxoniBpOR98vcy+pJwkGL1WrVn/Mp83j2Yh5GgTJnXgImsqYcgAg8KRSiAxuQ/hZTAYPd1nEoQwYH5FoU82OrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gg1tjnCQGLuX0n44ROjuUNbwQOVKMTwL7UWqdnDAcRU=;
 b=TaudpUBeKPnH+E7m2LmwPVWkC+NkP3sqFD4vK2HxCfaowWo+8cNOIjVxdqhS8e08h9NKtrLb5Jqk7IEGandWXI4chf9GqpbU6Z4rGwUdHnA5kk7nV6r11vvbngXEDAOcC0IonaHM+dmwEC+QaMRs++Pu796zVYTCn+IY31c+dEU1gs3vPZQyW9mafrspQxfw7+XDzEUyCBLDSE1IuM1fgwTbrXC3/TuceHPRwOC1122QNYI0z/Bst2v1C/C5T40geLrJj3SVRdnteSwPrjPnCTwR/RD0EQMH1qP4OxXY7UcQwRJ2hQhQEUoSZ0DcpBjq+FQoXRaJfuHDMyyaK2U2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gg1tjnCQGLuX0n44ROjuUNbwQOVKMTwL7UWqdnDAcRU=;
 b=D+mjhYA5n5Y6T/TD50Yspt/vs+MKm/Mzaaqw0x0QNu+Z3PogHgUWXzhvCAkHwhUK00MjBH+PEQxqVbJmVAocTX1l0cbmrgYe0P2LfHIQO6Hivlea3WP85+2be0pcPO5+z0KXVpFPw5T9zN45QDXL8mQliaTDmxSK7H/Oan5IEbg=
Received: from MN2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:208:23c::17)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 06:40:47 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::58) by MN2PR18CA0012.outlook.office365.com
 (2603:10b6:208:23c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 06:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:40:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:40:45 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:40:42 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Harry VanZyllDeJong <hvanzyll@amd.com>, Sreeja Golui
 <sreeja.golui@amd.com>
Subject: [PATCH 14/34] drm/amd/display: eDP panel polarity control and test
 support
Date: Wed, 5 Aug 2026 14:36:26 +0800
Message-ID: <20260805063937.2145774-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddc2f5f-71bc-4d9b-bc75-08def2bc7b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: rcUeVZRUrEkX69ScUTCk+NsOpAZrLNykGeMG6IWI3FrEay6FzHxvodRo8yN9L6LtJX11XgE85Cl/dQBvbh68Jg9wk03Qtt2GerruFlK8iWhC0tDBF5ZWPVn+ebHoBcDjFvYG6bWSEadVP9vWZMLxpQjgXRW/k6/DwTaj1OXZo+G6lrmpZuvtnQeY95ClMvEe575bRruDlBdZRckTy/Vp/qw2dHRzVXB7PY6KxCgzXz2wl3PwoMdQeVe2/u7VB5F8GQUarniEVT/QgcOekJCD2CuBf/vnT5b90GGU4zz11zNM4C2pUJWZH+066D6q9F2LVhu2y37HRivWYidGBUq/qtxYJjr06vxD4v/HjUbeuVs7n9xLtIWxbEMymS8+SGe8NF4q9Z4bWC6apQvva+ypVuKYJA6PaYhaJHdIztXT3GNTVFUzf4S+eCKln9zqNfKK8IDHPp3w/KoY3vRolLC2zALEF3pdNZ5YnaV4dOvbQ2wnp+qPLcJo2TmyW6n4EmmZ9HjJQqKn2HAbnKnf0AEoAiA8HXhHq3A4o7ez5pAxVn723BqLosZArTXnYtcpo9DGMrShUClxKdPq9nOMAAZdCPFFrS94WNeusgINTGJnL7n0oabB6YgsN/abPJoYzqryWmdp4tP273ZBJLCCuITGt98MwC4Bh/YiTMOsmwryRsHGkORkOBRJZUf+oejZAiXKmiI49bO4l+w42wViuHxRjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hXhm8gG41ZNF3KbV9RtqTgk2QyoN3JE+CcSfSabhPDUcBnAbOtpf/E+xCQVcGztNXBkcHgSTDVGNDFolDWx7F9UsrIGXReES2THES/uQyUXwF8JH/oruxyfkQRh4BmXvJCHTr6fOj0t9Q3K1xAMeHL5m0FXPy4qjZv4XxKk14x+UHEVEecWliN7mwEREk47+N1mphiPwJJpuZbNm8SMvSninAPLDhoxbMK1YFFi2JsvGjxjDECb8HSg7D4UPuuCEqFq0EKoA8qQL7L7PjA7fUIJOB38shfsIZ6VY6Ii/P1UxQuP45z4J6Oe5xbfjqrmxnVpWe1TxvAlw8Y6eXAgrekfM9zisUknmQBs5RNEunvz+B6aYzyhMVWdwJakSaHyA+7Q5aCAqsuBdybI5WopGZ+YFsLED+okidEEH5rolBN0lKldgvgVo7mhaMA833WUc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:40:46.6538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddc2f5f-71bc-4d9b-bc75-08def2bc7b24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852
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

From: Harry VanZyllDeJong <hvanzyll@amd.com>

eDP panels can require explicit polarity control during power transitions
to ensure correct signal behavior. Without this, panels that depend on
polarity state may behave incorrectly when combined with refresh rate drop
logic, since the two features previously had no coordination point.

To address this, a set/reset/query API is introduced and integrated into
the resource layer so polarity is managed as a first-class concern within
the existing power optimization flow. RamlessPowerOptimization is updated
to coordinate polarity state alongside refresh rate drop decisions,
preventing the two paths from conflicting during transitions.

Reviewed-by: Sreeja Golui <sreeja.golui@amd.com>
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_exports.c | 22 ++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  7 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 52 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  | 27 ++++++++++
 .../gpu/drm/amd/display/dc/inc/link_service.h |  5 +-
 .../drm/amd/display/dc/link/link_factory.c    |  4 ++
 .../link/protocols/link_edp_panel_control.c   | 30 +++++++++++
 .../link/protocols/link_edp_panel_control.h   |  4 ++
 8 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index 14fc4ef482f1..ba1b46d3a13e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -601,3 +601,25 @@ void dc_link_get_alpm_support(struct dc_link *link,
 {
 	link->dc->link_srv->edp_get_alpm_support(link, auxless_support, auxwake_support);
 }
+
+void dc_link_set_panel_polarity_enable(struct dc_link *link, bool enable)
+{
+	if (link->dc->link_srv->edp_set_panel_polarity_enabled)
+		link->dc->link_srv->edp_set_panel_polarity_enabled(link, enable);
+}
+
+void dc_link_panel_polarity_reset(struct dc_link *link)
+{
+	if (link->dc->link_srv->edp_panel_polarity_reset)
+		link->dc->link_srv->edp_panel_polarity_reset(link);
+}
+
+bool dc_link_get_panel_polarity(struct dc_link *link, int32_t *polarity)
+{
+	bool ret = false;
+
+	if (link->dc->link_srv->edp_get_panel_polarity)
+		ret = link->dc->link_srv->edp_get_panel_polarity(link, polarity);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6e45a484a9ad..34d4ede12e79 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -3897,4 +3897,11 @@ unsigned int dc_override_memory_bandwidth_request(
 		struct dc *dc,
 		unsigned int bw_mbps);
 
+/**
+ * Panel Polarity Control
+ */
+void dc_link_set_panel_polarity_enable(struct dc_link *link, bool enable);
+void dc_link_panel_polarity_reset(struct dc_link *link);
+bool dc_link_get_panel_polarity(struct dc_link *link, int32_t *polarity);
+
 #endif /* DC_INTERFACE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 47fa3d4265e0..b9fd375a3997 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2475,3 +2475,55 @@ void dc_dmub_srv_get_fams2_debug_meta(struct dc_dmub_srv *dc_dmub_srv)
 	dm_execute_dmub_cmd_list(dc_dmub_srv->ctx, 1, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 
 }
+
+void dc_dmub_srv_panel_polarity_set_enable(struct dc_dmub_srv *dc_dmub_srv, uint8_t panel_inst, bool enable)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *ctx = dc_dmub_srv->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.panel_polarity_enable.header.type = DMUB_CMD__PANEL_POLARITY;
+	cmd.panel_polarity_enable.header.sub_type = DMUB_CMD__PANEL_POLARITY_ENABLE;
+	cmd.panel_polarity_enable.header.payload_bytes = sizeof(cmd.panel_polarity_enable.data);
+	cmd.panel_polarity_enable.data.enable = enable ? 1 : 0;
+	cmd.panel_polarity_enable.data.otg_inst = panel_inst;
+
+	dc_wake_and_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
+}
+
+void dc_dmub_srv_panel_polarity_reset(struct dc_dmub_srv *dc_dmub_srv, uint8_t panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *ctx = dc_dmub_srv->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.panel_polarity_enable.header.type = DMUB_CMD__PANEL_POLARITY;
+	cmd.panel_polarity_enable.header.sub_type = DMUB_CMD__PANEL_POLARITY_RESET;
+	cmd.panel_polarity_enable.header.payload_bytes = sizeof(cmd.panel_polarity_enable.data);
+	cmd.panel_polarity_enable.data.otg_inst = panel_inst;
+
+	dc_wake_and_execute_dmub_cmd(ctx, &cmd, DM_DMUB_WAIT_TYPE_NO_WAIT);
+}
+
+bool dc_dmub_srv_panel_polarity_get_polarity(struct dc_dmub_srv *dc_dmub_srv, uint8_t panel_inst, int32_t *polarity)
+{
+	bool ret = false;
+	uint32_t raw_polarity = 0;
+	uint32_t retry_count = 0;
+	struct dc_context *ctx = dc_dmub_srv->ctx;
+
+	*polarity = 0;
+
+	do {
+		/* Send gpint command and wait for ack */
+		if (dc_wake_and_execute_gpint(ctx, DMUB_GPINT__PANEL_POLARITY_GET_BIAS, panel_inst, &raw_polarity,
+			DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY)) {
+			*polarity = (int32_t)raw_polarity;
+			ret = true;
+		}
+	} while (++retry_count <= 1000 && ret == false);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 6d15ed77c17d..ec5387aedf46 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -424,4 +424,31 @@ bool dc_dmub_srv_ihc_set_dig_hdcp_interrupt_dest(
  * @dc_dmub_srv - pointer to DMUB service object
  */
 void dc_dmub_srv_get_fams2_debug_meta(struct dc_dmub_srv *dc_dmub_srv);
+
+/**
+ * dc_dmub_srv_panel_polarity_set_enable() - Enables or disables panel polarity.
+ *
+ * @dc_dmub_srv: DMUB service handle
+ * @panel_inst: Panel instance
+ * @enable: true to enable, false to disable
+ */
+void dc_dmub_srv_panel_polarity_set_enable(struct dc_dmub_srv *dc_dmub_srv, uint8_t panel_inst, bool enable);
+
+/**
+ * dc_dmub_srv_panel_polarity_reset() - Resets panel polarity.
+ *
+ * @dc_dmub_srv: DMUB service handle
+ * @panel_inst: Panel instance
+ */
+void dc_dmub_srv_panel_polarity_reset(struct dc_dmub_srv *dc_dmub_srv, uint8_t panel_inst);
+
+/**
+ * dc_dmub_srv_panel_polarity_get_polarity() - Gets the current panel polarity.
+ *
+ * @dc_dmub_srv: DMUB service handle
+ * @panel_inst: Panel instance
+ * @polarity: Pointer to store the current polarity
+ */
+bool dc_dmub_srv_panel_polarity_get_polarity(struct dc_dmub_srv *dc_dmub_srv, uint8_t panel_inst, int32_t *polarity);
+
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index 026d28046eea..f87dfe63227d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -315,7 +315,9 @@ struct link_service {
 	bool (*dp_pr_set_general_cmd)(struct dc_link *link, struct dmub_cmd_pr_general_cmd_data *general_cmd_data);
 	bool (*dp_pr_get_state)(const struct dc_link *link, uint64_t *state);
 	void (*edp_set_panel_power)(struct dc_link *link, bool powerOn);
-
+	void (*edp_set_panel_polarity_enabled)(const struct dc_link *link, bool enable);
+	void (*edp_panel_polarity_reset)(struct dc_link *link);
+	bool (*edp_get_panel_polarity)(struct dc_link *link, int32_t *polarity);
 
 	/*************************** HDMI FRL *********************************/
 	bool (*hdmi_frl_poll_status_flag)(struct dc_link *link);
@@ -363,5 +365,6 @@ struct link_service {
 	uint64_t (*dp_trace_get_edp_poweroff_timestamp)(struct dc_link *link);
 	void (*dp_trace_source_sequence)(
 			struct dc_link *link, uint8_t dp_test_mode);
+
 };
 #endif /* __DC_LINK_HPD_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 89265b083935..8560ee727bfa 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -234,6 +234,10 @@ static void construct_link_service_edp_panel_control(struct link_service *link_s
 	link_srv->edp_receiver_ready_T7 = edp_receiver_ready_T7;
 	link_srv->edp_power_alpm_dpcd_enable = edp_power_alpm_dpcd_enable;
 	link_srv->edp_set_panel_power = edp_set_panel_power;
+
+	link_srv->edp_set_panel_polarity_enabled = edp_set_panel_polarity_enabled;
+	link_srv->edp_panel_polarity_reset = edp_panel_polarity_reset;
+	link_srv->edp_get_panel_polarity = edp_get_panel_polarity;
 }
 
 /* link dp panel replay implements DP panel replay functionality.
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 16951a9550f2..e3527b14686b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1301,3 +1301,33 @@ void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
 			*panel_mode = DP_PANEL_MODE_DEFAULT;
 	}
 }
+
+void edp_set_panel_polarity_enabled(const struct dc_link *link, bool enable)
+{
+	struct dc *dc = link->ctx->dc;
+	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
+
+	if (dc_dmub_srv)
+		dc_dmub_srv_panel_polarity_set_enable(dc_dmub_srv, 0, enable);
+}
+
+void edp_panel_polarity_reset(struct dc_link *link)
+{
+	struct dc *dc = link->ctx->dc;
+	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
+
+	if (dc_dmub_srv)
+		dc_dmub_srv_panel_polarity_reset(dc_dmub_srv, 0);
+}
+
+bool edp_get_panel_polarity(struct dc_link *link, int32_t *polarity)
+{
+	struct dc *dc = link->ctx->dc;
+	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
+	bool ret = false;
+
+	if (dc_dmub_srv)
+		ret = dc_dmub_srv_panel_polarity_get_polarity(dc_dmub_srv, 0, polarity);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
index 8fdb76d9953e..51de13e2387e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.h
@@ -77,4 +77,8 @@ bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_stat
 void edp_set_panel_power(struct dc_link *link, bool powerOn);
 void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
 		enum dp_panel_mode *panel_mode, bool enable);
+
+void edp_set_panel_polarity_enabled(const struct dc_link *link, bool enable);
+void edp_panel_polarity_reset(struct dc_link *link);
+bool edp_get_panel_polarity(struct dc_link *link, int32_t *polarity);
 #endif /* __DC_LINK_EDP_POWER_CONTROL_H__ */
-- 
2.43.0

