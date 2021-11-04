Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530C0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A9260EB8
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14A9260EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406A2736AC;
	Thu,  4 Nov 2021 20:52:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1112372DF9
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blE2STc29M+siqzu5kQh52eITAPQCYq+0RlllwEW89q74UOvKPutXjcBfpMM0gOgL1EQRVsbta9/IZpE7Z4zpXrSfphBQ/AxQqjyMUVzWDJ6XAJmESN2Sn90/S+VfC7177gLzl/1KI1UARCWrmeQIcSD+FWI6sm9cMyPikuPdZK+BRhrGWmAeQ2ae18NDt7zjtHxecvOQxVcnXBXUX1Eyh1UoUT/MKO/Pa9WX3OjjB5q47PF5SW/bvCWDuoT5FHQ4TwIY+ZR3Ft0uXBxpyKbtm5tfEO8lQyVAVACo/t4P6ExCiBy38FIfreqrpzLSAoRYQgU3dvdkxPcB0Ee2so44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+B7N1uyu+AyZRcK4Wf0PIY2yFkLTZ5BR6xtMlMfTqXY=;
 b=DZEE+sf4VMgdR7Ys5c9lXG9nsY2wCzz+MbCpRXkD4eik0Jr16OVnb9QK8xPIRfpdJ+eAJBvSBnNMo4LgLUVD/mdkv9LDP/B9Q8U3dqXkagzwa9fc8xW0RZ1POZQDkddWcDhYh2xr2mfUUYtMtZhEoaba6YzAmA980ctB1iorr3tf/LkSqKPGLQ3+yF80W3wr6+TSoF4O5EjDnC/Xxm0EDj/Mx9+rgmM0caXM32PqFSA8VT/ShL2TKzg81SuW1ItNZfqjw+cCIdC+GTu2eJ/G4hEFI1GdK96HK+vadUq4RdGWpdzT15s0ZLZJZel3R+/dviiY2VyEmrzw4W1u6O/z3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+B7N1uyu+AyZRcK4Wf0PIY2yFkLTZ5BR6xtMlMfTqXY=;
 b=L6d6APHjE/faxbq3E7exd9Po+gsdojuFWOA74C+GqAbyGwvS7whq9RM9SHrbYN44aMCmM2qN6LcviF/8Hpb9Nq2xzdUCMqEMEtRV+10T6RbETmzOECiYQ8GHO/+D7WuK+5sQQQwvKI0iedVb3u/y+r/sD8BNfhE0V5FcHkzKV60=
Received: from DS7PR03CA0274.namprd03.prod.outlook.com (2603:10b6:5:3ad::9) by
 BN6PR12MB1860.namprd12.prod.outlook.com (2603:10b6:404:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 20:52:27 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::4c) by DS7PR03CA0274.outlook.office365.com
 (2603:10b6:5:3ad::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:20 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:19 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/22] drm/amd/display: Add helper for blanking all dp displays
Date: Thu, 4 Nov 2021 16:51:54 -0400
Message-ID: <20211104205215.1125899-2-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47180a50-1836-477e-2b31-08d99fd5028d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1860:
X-Microsoft-Antispam-PRVS: <BN6PR12MB18601EF9B195067D87333895EB8D9@BN6PR12MB1860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlzQl01zCR1+8iDTbnlGeU36PDYqNJE/oyDi8iok52uFgNgM5YJTSRM2wN4I2sKEmY1di0eLN3f+ZdlTqbmCSOoDkG2alQzyEHZlYZHMr0iNsqVrKklqaI4X2uoqdvaNzl3TuzJvMxTksPRFwkuh6EGRiT+PX64y5kebHhh41/4UN1OQCg76mc5nUZF4ATsJMyv1pYQeEBu8n4UKghr80bNUwa3+IcVaw31YLWwyHFIYBi+L/Z3P/HgrdXMym2jBlhJ46ZEicUNdiLtkBvx5jm6KAx25MUKbxQd3sir/iwoRYt8Jxpayc4cMLp+Iyz8BIl4+a5KugvgANpPStZigPmU5mvX5HVXnVzkWLJBi2PPYrHFvEsR/VgHv5kYfkem5nkwg1EdYDnfetkqrkjHm/bKReGRlMZNn1Ot8frgyfNMCAIPdeiHsx48zV0LuONG0nESAaN2opwHWoQmOtjo8UKWpSA377UjCLq6sgWIGFPdVwXNvk/ynDPolCJyZ4EFrhd399Sw9qD7Mo7tVf64X8HFwfs2m5TL07y0vQJEqMY9ywozJQ+e4qoCsv614ZvFaN7ceUrk1+dkLC5sXQshG9hxiP+dtUr+k8oysC+A4MIyNozv9Qa10mpD9slv8D0UK8p6dOYDr17yb1NFl8fTA99BFB51isAoOlYhL2kJYr81izaVzKOWg2pxROzgIl2/2b3dWbcMcOraw7YwZRxRm79PvsdGQSey3Qj3gQ//Cn1U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(54906003)(6916009)(186003)(82310400003)(83380400001)(81166007)(70206006)(336012)(36860700001)(70586007)(356005)(2906002)(86362001)(26005)(8936002)(30864003)(7696005)(508600001)(47076005)(8676002)(426003)(5660300002)(36756003)(316002)(2616005)(6666004)(1076003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:26.8462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47180a50-1836-477e-2b31-08d99fd5028d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1860
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why & How]
1. The code to blank all dp display have been called many times,
so add helpers in dc_link to make it more concise.
2. Add some check to fix the dmesg errors at boot and resume from S3
on dcn3.1 during DQE's promotion test.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 51 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  4 ++
 .../display/dc/dce110/dce110_hw_sequencer.c   | 22 +-------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 41 ++-------------
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 39 ++------------
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 38 ++------------
 6 files changed, 66 insertions(+), 129 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f14f71dd1aa9..fe2b4b1d80f9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1999,6 +1999,57 @@ static enum dc_status enable_link_dp_mst(
 	return enable_link_dp(state, pipe_ctx);
 }
 
+void dc_link_blank_all_dp_displays(struct dc *dc)
+{
+	unsigned int i;
+	uint8_t dpcd_power_state = '\0';
+	enum dc_status status = DC_ERROR_UNEXPECTED;
+
+	for (i = 0; i < dc->link_count; i++) {
+		if ((dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT) ||
+			(dc->links[i]->priv == NULL) || (dc->links[i]->local_sink == NULL))
+			continue;
+
+		/* DP 2.0 spec requires that we read LTTPR caps first */
+		dp_retrieve_lttpr_cap(dc->links[i]);
+		/* if any of the displays are lit up turn them off */
+		status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
+							&dpcd_power_state, sizeof(dpcd_power_state));
+
+		if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0)
+			dc_link_blank_dp_stream(dc->links[i], true);
+	}
+
+}
+
+void dc_link_blank_dp_stream(struct dc_link *link, bool hw_init)
+{
+	unsigned int j;
+	struct dc  *dc = link->ctx->dc;
+	enum signal_type signal = link->connector_signal;
+
+	if ((signal == SIGNAL_TYPE_EDP) ||
+		(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
+		if (link->ep_type == DISPLAY_ENDPOINT_PHY &&
+			link->link_enc->funcs->get_dig_frontend &&
+			link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
+			unsigned int fe = link->link_enc->funcs->get_dig_frontend(link->link_enc);
+
+			if (fe != ENGINE_ID_UNKNOWN)
+				for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+					if (fe == dc->res_pool->stream_enc[j]->id) {
+						dc->res_pool->stream_enc[j]->funcs->dp_blank(link,
+									dc->res_pool->stream_enc[j]);
+						break;
+					}
+				}
+		}
+
+		if ((!link->wa_flags.dp_keep_receiver_powered) || hw_init)
+			dp_receiver_power_ctrl(link, false);
+	}
+}
+
 static bool get_ext_hdmi_settings(struct pipe_ctx *pipe_ctx,
 		enum engine_id eng_id,
 		struct ext_hdmi_settings *settings)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 180ecd860296..669c162c0c02 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -287,6 +287,10 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
 
 void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency);
 
+void dc_link_blank_all_dp_displays(struct dc *dc);
+
+void dc_link_blank_dp_stream(struct dc_link *link, bool hw_init);
+
 /* Request DC to detect if there is a Panel connected.
  * boot - If this call is during initial boot.
  * Return false for any type of detection failure or MST detection
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 24e47df526f6..e7e2aa46218d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1655,30 +1655,12 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 
 static void power_down_encoders(struct dc *dc)
 {
-	int i, j;
+	int i;
 
 	for (i = 0; i < dc->link_count; i++) {
 		enum signal_type signal = dc->links[i]->connector_signal;
 
-		if ((signal == SIGNAL_TYPE_EDP) ||
-			(signal == SIGNAL_TYPE_DISPLAY_PORT)) {
-			if (dc->links[i]->link_enc->funcs->get_dig_frontend &&
-				dc->links[i]->link_enc->funcs->is_dig_enabled(dc->links[i]->link_enc)) {
-				unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
-									dc->links[i]->link_enc);
-
-				for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-					if (fe == dc->res_pool->stream_enc[j]->id) {
-						dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-									dc->res_pool->stream_enc[j]);
-						break;
-					}
-				}
-			}
-
-			if (!dc->links[i]->wa_flags.dp_keep_receiver_powered)
-				dp_receiver_power_ctrl(dc->links[i], false);
-		}
+		dc_link_blank_dp_stream(dc->links[i], false);
 
 		if (signal != SIGNAL_TYPE_EDP)
 			signal = SIGNAL_TYPE_NONE;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 0b788d794fb3..135e2b58cc73 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1366,7 +1366,7 @@ void dcn10_init_pipes(struct dc *dc, struct dc_state *context)
 
 void dcn10_init_hw(struct dc *dc)
 {
-	int i, j;
+	int i;
 	struct abm *abm = dc->res_pool->abm;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dce_hwseq *hws = dc->hwseq;
@@ -1468,43 +1468,8 @@ void dcn10_init_hw(struct dc *dc)
 		dmub_enable_outbox_notification(dc);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot) {
-		uint8_t dpcd_power_state = '\0';
-		enum dc_status status = DC_ERROR_UNEXPECTED;
-
-		for (i = 0; i < dc->link_count; i++) {
-			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
-				continue;
-
-			/* DP 2.0 requires that LTTPR Caps be read first */
-			dp_retrieve_lttpr_cap(dc->links[i]);
-
-			/*
-			 * If any of the displays are lit up turn them off.
-			 * The reason is that some MST hubs cannot be turned off
-			 * completely until we tell them to do so.
-			 * If not turned off, then displays connected to MST hub
-			 * won't light up.
-			 */
-			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-							&dpcd_power_state, sizeof(dpcd_power_state));
-			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
-				/* blank dp stream before power off receiver*/
-				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
-					unsigned int fe = dc->links[i]->link_enc->funcs->get_dig_frontend(dc->links[i]->link_enc);
-
-					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-										dc->res_pool->stream_enc[j]);
-							break;
-						}
-					}
-				}
-				dp_receiver_power_ctrl(dc->links[i], false);
-			}
-		}
-	}
+	if (dc->config.power_down_display_on_boot)
+		dc_link_blank_all_dp_displays(dc);
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index df2717116604..3e99bb9c70ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -437,7 +437,7 @@ void dcn30_init_hw(struct dc *dc)
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
-	int i, j;
+	int i;
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 
@@ -534,41 +534,8 @@ void dcn30_init_hw(struct dc *dc)
 			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot) {
-		uint8_t dpcd_power_state = '\0';
-		enum dc_status status = DC_ERROR_UNEXPECTED;
-
-		for (i = 0; i < dc->link_count; i++) {
-			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
-				continue;
-			/* DP 2.0 states that LTTPR regs must be read first */
-			dp_retrieve_lttpr_cap(dc->links[i]);
-
-			/* if any of the displays are lit up turn them off */
-			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-						     &dpcd_power_state, sizeof(dpcd_power_state));
-			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
-				/* blank dp stream before power off receiver*/
-				if (dc->links[i]->link_enc->funcs->get_dig_frontend) {
-					unsigned int fe;
-
-					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
-										dc->links[i]->link_enc);
-					if (fe == ENGINE_ID_UNKNOWN)
-						continue;
-
-					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-										dc->res_pool->stream_enc[j]);
-							break;
-						}
-					}
-				}
-				dp_receiver_power_ctrl(dc->links[i], false);
-			}
-		}
-	}
+	if (dc->config.power_down_display_on_boot)
+		dc_link_blank_all_dp_displays(dc);
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 5dd1ce9ddb53..bdaeb6ebdacb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -112,7 +112,7 @@ void dcn31_init_hw(struct dc *dc)
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	struct resource_pool *res_pool = dc->res_pool;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
-	int i, j;
+	int i;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
@@ -202,40 +202,8 @@ void dcn31_init_hw(struct dc *dc)
 		dmub_enable_outbox_notification(dc);
 
 	/* we want to turn off all dp displays before doing detection */
-	if (dc->config.power_down_display_on_boot) {
-		uint8_t dpcd_power_state = '\0';
-		enum dc_status status = DC_ERROR_UNEXPECTED;
-
-		for (i = 0; i < dc->link_count; i++) {
-			if (dc->links[i]->connector_signal != SIGNAL_TYPE_DISPLAY_PORT)
-				continue;
-
-			/* if any of the displays are lit up turn them off */
-			status = core_link_read_dpcd(dc->links[i], DP_SET_POWER,
-						     &dpcd_power_state, sizeof(dpcd_power_state));
-			if (status == DC_OK && dpcd_power_state == DP_POWER_STATE_D0) {
-				/* blank dp stream before power off receiver*/
-				if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY &&
-						dc->links[i]->link_enc->funcs->get_dig_frontend) {
-					unsigned int fe;
-
-					fe = dc->links[i]->link_enc->funcs->get_dig_frontend(
-										dc->links[i]->link_enc);
-					if (fe == ENGINE_ID_UNKNOWN)
-						continue;
-
-					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
-						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
-										dc->res_pool->stream_enc[j]);
-							break;
-						}
-					}
-				}
-				dp_receiver_power_ctrl(dc->links[i], false);
-			}
-		}
-	}
+	if (dc->config.power_down_display_on_boot)
+		dc_link_blank_all_dp_displays(dc);
 
 	/* If taking control over from VBIOS, we may want to optimize our first
 	 * mode set, so we need to skip powering down pipes until we know which
-- 
2.25.1

