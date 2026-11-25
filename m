Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875BE606A338
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4GQzZx1A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28EE310F679;
	Wed, 25 Nov 2026 06:58:06 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F082C10F643
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfZuMhKqnQKRe+zF0sdm0a2+YtLxuIL5UJph+x3b4yVBP7qQLNBIiwqpS6aZvJ+qEhFmZCfB4EXE85F4elis5//2HN7RBakHtY77ockiGdM1P6tEXTBcElEKN7aKRWpGekg19IC9nPqpmZ/kBA/EYHN1anjEaXbc7DCL9QtOGSB+icpYhzmxLGXdgXgC+FTbk3g/PoTrA6OBhNQQBh4pIYu1cECpk5gnj6WIYuLWstf/9H3qn3dxlLPeee+NTu6z5+RzUwyIVSWqJeS2gIku0PXRPXuPvaDhNnhekKuB8LT71rwI3e0ycZnWaswHN40z/x9uyt3VKLNdtIaorlrbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2uy2D4hn+sTo01rgl+kl71dS1T+GMcweQEkSNWk9TA=;
 b=ThEJWcRCgZa0O/KEXm5Phf5VtzpLKPECd9wEdfOMoVux8RR8ho5Vv1FkFC8t45GaOD72rEVi0poP7J/ml2ihHYsNTAqQM6WL19ZoUEgLmeF/rewGVEpP7oXgledcgL0j96BZvNcCpw1eWPzwIHFsM7kPOmmItWrJtUQqkW3I6qFPNn4HSwO/Ylk4PE54PfJ1fyEuUYj6cv2YkyojALbHX48iRdfyONgbRWgjuv0lD4ETMdR3G6HSO2T5KRnA7hmHotVauzt4GuCQbiGmMzu+/VEs0PZ6erMNUXSJ4MsOALe58X9zdn4BMEbT0s3PO4o0p4C6xXySOfBtYytJRLXokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2uy2D4hn+sTo01rgl+kl71dS1T+GMcweQEkSNWk9TA=;
 b=4GQzZx1A0ltTEwTzRHsJ6mAJgXAReFnY3QgKWkCb0+O/TNlacgtIiQj68n4lW3U3Rl/wm7jmkAcXWSL+lTfFL+qyJnNSkZ/tAYnSYX0fC87q5GEJ5Wx3YC3Pa3OY1jNR8PO85wJ4oSReNHN/vD3VvCwnju2MiD8y6WXrsdMQ9yE=
Received: from SJ2P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::8)
 by SN7PR12MB6959.namprd12.prod.outlook.com (2603:10b6:806:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 06:57:51 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::40) by SJ2P220CA0009.outlook.office365.com
 (2603:10b6:a03:5da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:57:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:57:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:57:50 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:57:49 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:57:41 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dominik Kowalski <dominik.kowalski@amd.com>, "Wenjing
 Liu" <wenjing.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 17/27] drm/amd/display: Implement link_set_dpms_off_v2
Date: Wed, 25 Nov 2026 14:55:06 +0800
Message-ID: <20261125065631.3889665-18-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|SN7PR12MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c52028a-3957-4298-8cb3-08df4ac16be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|11063799006|261022075727099003|261022105027099003|261022113327099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: pWLci+HAUJ1jmD1LCW7BKQePnUAUHlNLGFYxRarI1cnDWmYKw0kNMSU8b/95nCXgJdlVe+eebx3E/oTz+HYP/ylQuXCpkbfzB6pgwRAqnIqGBdaTjyzhv0ZcF4/9rFImCisvt1LN4HLEWvG96vGpSgkB98nA1SOBydj4puOYBDjMuXKOL0+3XrmW2r/HlG8SyoMS6aw5nXMFVEfV3LGO9NmPDudyGOz6at//Ol0KpZi1PLV/VCCqMjOeXrmaILMQmmyaDRXj/66IOyE0MUswKXEusbwr8R0x9ZWwSEnYXSQs9Md1aZ2Ld2CAn5jnBHLoU1A08edJQJ9A9rNRRtK0wxDI4wQYHavHmgVAqOQmsePFmHhk8zIzObCZkk6E3XTjW0SWnV4x7sETshg6mWfzgsQRPZxFkHMSip391CUfX/ofeLrMjlg9QtyMCBdYnnh2trmW2yyGC0/jtzExxu4hvXMaazOSIDk02Rxl09x923rUopPnFoQTyxnF0sjsFkgR/3fYE8yMOue2JLbnGpuG8d6CxfYP8GPg/2QJxhmvZxjIqsKB3Q/3binDax64VwpwEm03ogBqIxRBSABus2e8INa/pu8uftpSkecFIwE8aXQ6VO4CWJzj+K4t1SssjXiVRrH8/+mU5aDlCOcsx3fQWrWjQSRT324Dgwo4lEKNRqaktu2Gg6giUoTMbIML6n6rCvMdY5L2DbCoMr3EpU2+rA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(261022075727099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vSA9+0TPJ8+371m6tyyoguuSKQMunA8OBlPS1HgBuTdnw9yvfeS+Zc6q8ztxlLNTBKFu5AglLrAI27OuMgWEDbm50kyqmXClu0z3sOVGOXBvZM8s5F6Zu2+sWsNy8K9OSgmYRFZki3lpkQcwq1xZZ1OcPqud2sw+LbtF36s/FLM9tyyv72JXxUaECpc7EFQXWTl/09FrTPIPbEUBuItPmCH3YnET2fopvXOOchzu2WnmW+j5bnlL2Mxbi8pSreUTyMejPudOVteso06A613sTn0/L318VqxQo0LvUI2t+haKQnViU8g1WPs7J4D7lZriQ++20cNrJAU+rwYApAdxA49nr7ABrTiybyh31+EVSV+BFDsiRzxCrllFQy8IHnE+PiI0wl2khNsWVabBk6ApAb8idLB6khp3shAyEBEkRh/B+ewpFemfedR/BFpnkZm5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:57:50.8180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c52028a-3957-4298-8cb3-08df4ac16be8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6959
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dominik Kowalski <dominik.kowalski@amd.com>

[Why & How]
Initial implementation of link_set_dpms_off_v2 in terms of new step
architecture, using temporarily exposed internals of v1. Will be
reworked in future work to remove use of pipe_ctx wherever possible.

Cc: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dominik Kowalski <dominik.kowalski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/link/link_dpms_v1.c    |  84 +++++++
 .../drm/amd/display/dc/link/link_dpms_v1.h    |  29 +++
 .../drm/amd/display/dc/link/link_dpms_v2.c    | 229 +++++++++++++++++-
 3 files changed, 337 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
index 1a6fe2e12c06..4677ad4a2cd0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
@@ -206,6 +206,12 @@ static bool is_master_pipe_for_link(const struct dc_link *link,
 			pipe->stream->link == link;
 }
 
+bool link_dpms_impl_is_master_pipe_for_link(const struct dc_link *link,
+		const struct pipe_ctx *pipe)
+{
+	return is_master_pipe_for_link(link, pipe);
+}
+
 /*
  * This function finds all master pipes feeding to a given link with dpms set to
  * on in given dc state.
@@ -329,6 +335,13 @@ static bool get_ext_hdmi_settings(
 	return true;
 }
 
+bool link_dpms_impl_get_ext_hdmi_settings(const struct integrated_info *info,
+					  enum engine_id eng_id,
+					  struct ext_hdmi_settings *settings)
+{
+	return get_ext_hdmi_settings(info, eng_id, settings);
+}
+
 static bool write_i2c(
 		const struct dc_link *link,
 		uint8_t address,
@@ -472,6 +485,14 @@ static bool write_i2c_retimer_setting(
 	return true;
 }
 
+bool link_dpms_impl_write_i2c_retimer_setting(
+	const struct dc_link *link, bool is_vga_mode, bool is_over_340mhz,
+	struct ext_hdmi_settings *settings)
+{
+	return write_i2c_retimer_setting(link, is_vga_mode, is_over_340mhz,
+					 settings);
+}
+
 static bool write_i2c_default_retimer_setting(
 		const struct dc_link *link,
 		bool is_vga_mode,
@@ -503,6 +524,13 @@ static bool write_i2c_default_retimer_setting(
 	return true;
 }
 
+bool link_dpms_impl_write_i2c_default_retimer_setting(
+	const struct dc_link *link, bool is_vga_mode, bool is_over_340mhz)
+{
+	return write_i2c_default_retimer_setting(link, is_vga_mode,
+						 is_over_340mhz);
+}
+
 static bool write_i2c_redriver_setting(
 		const struct dc_link *link,
 		bool is_over_340mhz)
@@ -528,6 +556,12 @@ static bool write_i2c_redriver_setting(
 	return success;
 }
 
+bool link_dpms_impl_write_i2c_redriver_setting(const struct dc_link *link,
+					       bool is_over_340mhz)
+{
+	return write_i2c_redriver_setting(link, is_over_340mhz);
+}
+
 static struct link_encoder *get_link_encoder(struct pipe_ctx *pipe_ctx)
 {
 	struct link_encoder *link_enc
@@ -611,6 +645,12 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 	cp_psp->funcs.update_stream_config(cp_psp->handle, &config);
 }
 
+void link_dpms_impl_update_psp_stream_config(struct pipe_ctx *pipe_ctx,
+					     bool dpms_off)
+{
+	update_psp_stream_config(pipe_ctx, dpms_off);
+}
+
 void link_wait_for_unlocked(struct dc_link *link)
 {
 	unsigned long long enter_timestamp;
@@ -656,6 +696,11 @@ static void set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 	dc->hwss.set_avmute(pipe_ctx, enable);
 }
 
+void link_dpms_impl_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
+{
+	set_avmute(pipe_ctx, enable);
+}
+
 static void enable_mst_on_sink(struct dc_link *link, bool enable)
 {
 	unsigned char mstmCntl = 0;
@@ -1387,6 +1432,11 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	return DC_OK;
 }
 
+enum dc_status link_dpms_impl_deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
+{
+	return deallocate_mst_payload(pipe_ctx);
+}
+
 /* convert link_mst_stream_alloc_table to dm dp_mst_stream_alloc_table
  * because stream_encoder is not exposed to dm
  */
@@ -1468,6 +1518,11 @@ static enum dc_status allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	return DC_OK;
 }
 
+enum dc_status link_dpms_impl_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
+{
+	return allocate_mst_payload(pipe_ctx);
+}
+
 struct fixed31_32 link_calculate_sst_avg_time_slots_per_mtp(
 		const struct dc_stream_state *stream,
 		const struct dc_link *link)
@@ -1679,6 +1734,12 @@ static enum dc_status update_sst_payload(struct pipe_ctx *pipe_ctx,
 	return DC_OK;
 }
 
+enum dc_status link_dpms_impl_update_sst_payload(struct pipe_ctx *pipe_ctx,
+						 bool allocate)
+{
+	return update_sst_payload(pipe_ctx, allocate);
+}
+
 enum dc_status link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw_in_kbps)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
@@ -1863,6 +1924,13 @@ static void disable_link(struct dc_link *link,
 	}
 }
 
+void link_dpms_impl_disable_link(struct dc_link *link,
+				 const struct link_resource *link_res,
+				 enum signal_type signal)
+{
+	disable_link(link, link_res, signal);
+}
+
 static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
@@ -2366,6 +2434,12 @@ static bool allocate_usb4_bandwidth_for_stream(struct dc_stream_state *stream, i
 	return true;
 }
 
+bool link_dpms_impl_allocate_usb4_bandwidth_for_stream(
+	struct dc_stream_state *stream, int stream_bw)
+{
+	return allocate_usb4_bandwidth_for_stream(stream, stream_bw);
+}
+
 static bool allocate_usb4_bandwidth(struct dc_stream_state *stream)
 {
 	ASSERT(stream->sink);
@@ -2393,6 +2467,11 @@ static bool deallocate_usb4_bandwidth(struct dc_stream_state *stream)
 	return ret;
 }
 
+bool link_dpms_impl_deallocate_usb4_bandwidth(struct dc_stream_state *stream)
+{
+	return deallocate_usb4_bandwidth(stream);
+}
+
 static struct vpg *get_vpg(struct pipe_ctx *pipe_ctx)
 {
 	if (dc_is_hdmi_frl_signal(pipe_ctx->stream->signal))
@@ -2403,6 +2482,11 @@ static struct vpg *get_vpg(struct pipe_ctx *pipe_ctx)
 		return pipe_ctx->stream_res.stream_enc->vpg;
 }
 
+struct vpg *link_dpms_impl_get_vpg(struct pipe_ctx *pipe_ctx)
+{
+	return get_vpg(pipe_ctx);
+}
+
 enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 {
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.h b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.h
index b170c9a8622d..439372484f79 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.h
@@ -51,4 +51,33 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
 bool link_set_dsc_enable(struct pipe_ctx *pipe_ctx, bool enable);
 bool link_update_dsc_config(struct pipe_ctx *pipe_ctx);
 void link_wait_for_unlocked(struct dc_link *link);
+
+// Temporarily exposed function during migration v1 -> v2, not public API
+enum dc_status link_dpms_impl_allocate_mst_payload(struct pipe_ctx *pipe_ctx);
+bool link_dpms_impl_allocate_usb4_bandwidth_for_stream(
+	struct dc_stream_state *stream, int stream_bw);
+enum dc_status link_dpms_impl_deallocate_mst_payload(struct pipe_ctx *pipe_ctx);
+bool link_dpms_impl_deallocate_usb4_bandwidth(struct dc_stream_state *stream);
+void link_dpms_impl_disable_link(struct dc_link *link,
+				 const struct link_resource *link_res,
+				 enum signal_type signal);
+bool link_dpms_impl_get_ext_hdmi_settings(const struct integrated_info *info,
+					  enum engine_id eng_id,
+					  struct ext_hdmi_settings *settings);
+struct vpg *link_dpms_impl_get_vpg(struct pipe_ctx *pipe_ctx);
+bool link_dpms_impl_is_master_pipe_for_link(const struct dc_link *link,
+					    const struct pipe_ctx *pipe);
+void link_dpms_impl_set_avmute(struct pipe_ctx *pipe_ctx, bool enable);
+void link_dpms_impl_update_psp_stream_config(struct pipe_ctx *pipe_ctx,
+					     bool dpms_off);
+enum dc_status link_dpms_impl_update_sst_payload(struct pipe_ctx *pipe_ctx,
+						 bool allocate);
+bool link_dpms_impl_write_i2c_default_retimer_setting(
+	const struct dc_link *link, bool is_vga_mode, bool is_over_340mhz);
+bool link_dpms_impl_write_i2c_redriver_setting(const struct dc_link *link,
+					       bool is_over_340mhz);
+bool link_dpms_impl_write_i2c_retimer_setting(
+	const struct dc_link *link, bool is_vga_mode, bool is_over_340mhz,
+	struct ext_hdmi_settings *settings);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c
index 14f5bf4f53b1..5bbd9316cba2 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v2.c
@@ -26,11 +26,19 @@
 #include "dc/link/link_dpms_v2.h"
 
 #include "dc/inc/core_types.h"
+#include "dc/inc/hw/vpg.h"
 #include "dc/inc/link_tx.h"
+#include "dc/link/link_dpms_v1.h"
+#include "dc/link/protocols/link_ddc.h"
+#include "dc/link/protocols/link_dp_capability.h"
+#include "dc/link/protocols/link_edp_panel_control.h"
+
+// Define required by logging framewok
+#define DC_LOGGER dc_logger
 
 // TODO: This should be moved to dc_update_state_prepare
 static void link_dpms_ctx_init(struct link_dpms_ctx *dpms_ctx,
-			  struct pipe_ctx *pipe_ctx)
+			       struct pipe_ctx *pipe_ctx)
 {
 	dpms_ctx->link_config = pipe_ctx->link_config;
 
@@ -40,15 +48,226 @@ static void link_dpms_ctx_init(struct link_dpms_ctx *dpms_ctx,
 	};
 }
 
+static bool
+link_legacy_set_dpms_off_step_check_skipped(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	struct dal_logger *DC_LOGGER = stream->ctx->logger;
+
+	ASSERT(link_dpms_impl_is_master_pipe_for_link(link, pipe_ctx));
+
+	if (dc_is_virtual_signal(stream->signal))
+		/* No real hardware to program for virtual signals. */
+		return true;
+
+	if (stream->sink && stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
+	    stream->sink->sink_signal != SIGNAL_TYPE_NONE)
+		DC_LOG_DC(
+			"%s pipe_ctx dispname=%s signal=%x link=%d sink_count=%d\n",
+			__func__, stream->sink->edid_caps.display_name,
+			stream->signal, link->link_index, link->sink_count);
+
+	return false;
+}
+
+static void
+link_legacy_set_dpms_off_step_wait_for_unlocked(struct pipe_ctx *pipe_ctx)
+{
+	link_wait_for_unlocked(pipe_ctx->stream->link);
+}
+
+static void link_legacy_set_dpms_off_step_set_avmute(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+
+	if (stream->sink && !stream->sink->edid_caps.panel_patch.skip_avmute &&
+	    dc_is_hdmi_signal(stream->signal))
+		link_dpms_impl_set_avmute(pipe_ctx, true);
+}
+
+static void
+link_legacy_set_dpms_off_step_disable_audio_stream(struct pipe_ctx *pipe_ctx)
+{
+	pipe_ctx->stream->ctx->dc->hwss.disable_audio_stream(pipe_ctx);
+}
+
+static void link_legacy_set_dpms_off_step_update_psp_stream_config(
+	struct pipe_ctx *pipe_ctx)
+{
+	link_dpms_impl_update_psp_stream_config(pipe_ctx, true);
+}
+
+static void
+link_legacy_set_dpms_off_step_blank_stream(struct pipe_ctx *pipe_ctx)
+{
+	pipe_ctx->stream->ctx->dc->hwss.blank_stream(pipe_ctx);
+}
+
+static void link_legacy_set_dpms_off_step_deallocate_usb4_bandwidth(
+	struct pipe_ctx *pipe_ctx)
+{
+	if (pipe_ctx->stream->sink &&
+	    pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation)
+		link_dpms_impl_deallocate_usb4_bandwidth(pipe_ctx->stream);
+}
+
+static void
+link_legacy_set_dpms_off_step_update_payloads(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+		link_dpms_impl_deallocate_mst_payload(pipe_ctx);
+	else if (dc_is_dp_sst_signal(stream->signal) &&
+		 dp_is_128b_132b_signal(pipe_ctx))
+		link_dpms_impl_update_sst_payload(pipe_ctx, false);
+}
+
+static void
+link_legacy_set_dpms_off_step_configure_hdmi(struct pipe_ctx *pipe_ctx)
+{
+	if (!dc_is_hdmi_signal(pipe_ctx->stream->signal))
+		return;
+
+	const uint32_t mhz_multiplier = 1000;
+	const uint32_t vbios_hdmi_freq = 165 * mhz_multiplier;
+
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	struct ext_hdmi_settings settings = { 0 };
+	const enum engine_id eng_id = pipe_ctx->stream_res.stream_enc->id;
+	const struct integrated_info *info =
+		stream->ctx->dc_bios->integrated_info;
+
+	write_scdc_data(link->ddc, vbios_hdmi_freq, false);
+
+	switch (link->chip_caps & AMD_EXT_DISPLAY_PATH_CAPS__EXT_CHIP_MASK) {
+	case AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_TISN65DP159RSBT:
+		if (link_dpms_impl_get_ext_hdmi_settings(info, eng_id,
+							 &settings))
+			link_dpms_impl_write_i2c_retimer_setting(
+				link, false, false, &settings);
+		else
+			link_dpms_impl_write_i2c_default_retimer_setting(
+				link, false, false);
+		break;
+	case AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_PI3EQX1204:
+		link_dpms_impl_write_i2c_redriver_setting(link, false);
+		break;
+	}
+}
+
+static void
+link_legacy_set_dpms_off_step_disable_link_and_stream(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	const struct hw_sequencer_funcs *hwss = &link->ctx->dc->hwss;
+
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
+	    !dp_is_128b_132b_signal(pipe_ctx)) {
+		/* In DP1.x SST mode, our encoder will go to TPS1
+		 * when link is on but stream is off.
+		 * Disabling link before stream will avoid exposing TPS1 pattern
+		 * during the disable sequence as it will confuse some receivers
+		 * state machine.
+		 * In DP2 or MST mode, our encoder will stay video active
+		 */
+		link_dpms_impl_disable_link(link, &pipe_ctx->link_res,
+					    stream->signal);
+		hwss->disable_stream(pipe_ctx);
+	} else {
+		hwss->disable_stream(pipe_ctx);
+		link_dpms_impl_disable_link(link, &pipe_ctx->link_res,
+					    stream->signal);
+	}
+}
+
+static void
+link_legacy_set_dpms_off_step_set_edp_panel_assr(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_link *link = pipe_ctx->stream->link;
+	enum dp_panel_mode panel_mode_dp = dp_get_panel_mode(link);
+
+	edp_set_panel_assr(link, pipe_ctx, &panel_mode_dp, false);
+}
+
+static void link_legacy_set_dpms_off_step_set_dsc(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+
+	if (!stream->timing.flags.DSC)
+		return;
+
+	if (dc_is_dp_signal(stream->signal))
+		link_set_dsc_enable(pipe_ctx, false);
+	else if (dc_is_hdmi_frl_signal(stream->signal))
+		link_set_dsc_on_stream(pipe_ctx, false);
+}
+
+static void link_legacy_set_dpms_off_step_set_out_mux(struct pipe_ctx *pipe_ctx)
+{
+	if (!dp_is_128b_132b_signal(pipe_ctx))
+		return;
+
+	const struct timing_generator_funcs *funcs =
+		pipe_ctx->stream_res.tg->funcs;
+
+	if (funcs->set_out_mux)
+		funcs->set_out_mux(pipe_ctx->stream_res.tg, OUT_MUX_DIO);
+}
+
+static void
+link_legacy_set_dpms_off_step_vpg_powerdown(struct pipe_ctx *pipe_ctx)
+{
+	struct vpg *vpg = link_dpms_impl_get_vpg(pipe_ctx);
+
+	if (vpg && vpg->funcs->vpg_powerdown)
+		vpg->funcs->vpg_powerdown(vpg);
+}
+
+static void
+link_legacy_set_dpms_off_step_panel_mode_workaround(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+
+	if (link->connector_signal != SIGNAL_TYPE_EDP ||
+	    !link->ctx->dc->debug.psp_disabled_wa)
+		return;
+
+	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
+
+	link->panel_mode = panel_mode;
+}
+
 enum dc_status link_set_dpms_off_v2(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_link *link = pipe_ctx->stream->link;
+	struct link_dpms_ctx *dpms_ctx = link->dpms_ctx;
 
-	link_dpms_ctx_init(link->dpms_ctx, pipe_ctx);
+	link_dpms_ctx_init(dpms_ctx, pipe_ctx);
 
-	// TODO: Implement
-	ASSERT(false);
-	return DC_ERROR_UNEXPECTED;
+	if (link_legacy_set_dpms_off_step_check_skipped(pipe_ctx))
+		return DC_DPMS_SKIPPED_HANDSHAKE;
+
+	link_legacy_set_dpms_off_step_wait_for_unlocked(pipe_ctx);
+	link_legacy_set_dpms_off_step_set_avmute(pipe_ctx);
+	link_legacy_set_dpms_off_step_disable_audio_stream(pipe_ctx);
+	link_legacy_set_dpms_off_step_update_psp_stream_config(pipe_ctx);
+	link_legacy_set_dpms_off_step_blank_stream(pipe_ctx);
+	link_legacy_set_dpms_off_step_deallocate_usb4_bandwidth(pipe_ctx);
+	link_legacy_set_dpms_off_step_update_payloads(pipe_ctx);
+	link_legacy_set_dpms_off_step_configure_hdmi(pipe_ctx);
+	link_legacy_set_dpms_off_step_disable_link_and_stream(pipe_ctx);
+	link_legacy_set_dpms_off_step_set_edp_panel_assr(pipe_ctx);
+	link_legacy_set_dpms_off_step_set_dsc(pipe_ctx);
+	link_legacy_set_dpms_off_step_set_out_mux(pipe_ctx);
+	link_legacy_set_dpms_off_step_vpg_powerdown(pipe_ctx);
+	link_legacy_set_dpms_off_step_panel_mode_workaround(pipe_ctx);
+
+	return DC_DPMS_SUCCESS;
 }
 
 enum dc_status link_set_dpms_on_v2(struct dc_state *state,
-- 
2.43.0

