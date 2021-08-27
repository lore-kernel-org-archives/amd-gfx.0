Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB22C4320A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71FA60E93
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E71FA60E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E6B6E9D5;
	Fri, 27 Aug 2021 20:45:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D08086E9D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:45:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqIzyUqzCONjY6MVoA4S+z5P3Bbdz2utrpV0yd5iFZEOfHsQwtQ/wb/esyaFIssm9kv8e8nzwM/w/1aSN7K1SP818aVEsjKZjmZvaFtEZvtIHYZdykEfi2zpR4CLNZ9cyX0NhchhaATB6exFKtg5KNHweJM4UliNjKYhvd3n+Jds9HGmIXMCxkFX9o0yKhJvH2Q+zjVAesRDAvEAG4aDa8ITi+dWWEBaRkHnj7qtzjRHTXSg7ckxWcEhUGRgMtFmSH+Xcj8RQwmdsCZ2mwViFT8uTcOJ02iEJTCw/kDzQry3/U5DWuFTrMwCstO03zyzduOvvUSnegAJaxfIHDvYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ogoQNc+/UhHzsmE25G/Cg81kR3V4VUrycB5u099638=;
 b=LtP4zQpfFnMiGeKy0/7UIE7qsee6+UF5Rtad2QoXV8TI/Tg/p5O4oLEC/tWkEGdJFYDR9fC6YWsJWruSOrPqdJK9PexyoaJXA2S/jVc0eVPJUgjv9ImcH7fnW+mUVhnJy3i7cVSVt48EZzl7HKXO/kGNCDHW22aAv/pKDxmUVbo6XtpvamjqKzvYMr1DWF3TOdgUwVu1QVmwLsOrWPsUNp9phvTY+PzOCvoQO0bohLrjVXI69pf9SYERml2Q4Uk0d5V7AaxPEqIQqq7vLtjxOX+fLJLvxzr+Wg1iFrFcyI/Pjg4az3aWf0/u5fYXsKA+r3hbsZ/mBJsmfIyKr2503Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ogoQNc+/UhHzsmE25G/Cg81kR3V4VUrycB5u099638=;
 b=5PvQFMKldYjiMQegyPki0K8HrqeI3iGuCWAvHsUFxZHTihu49dl0xlMCnRrsEYKWS3HgzJh9Mpzggk2QpHgJVoWdtLEQ6fCKGm1SsDWedlIBeEyAsbaCiyrN+wUCIGKX486d4S8T5DjgO3KZawgxNLa8K8chm5egpUAVcd14Ij8=
Received: from MW4PR03CA0142.namprd03.prod.outlook.com (2603:10b6:303:8c::27)
 by SJ0PR12MB5407.namprd12.prod.outlook.com (2603:10b6:a03:3ac::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Fri, 27 Aug
 2021 20:29:32 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::b0) by MW4PR03CA0142.outlook.office365.com
 (2603:10b6:303:8c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:32 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:31 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 08/19] drm/amd/display: Add option to defer works of hpd_rx_irq
Date: Fri, 27 Aug 2021 16:28:59 -0400
Message-ID: <20210827202910.20864-9-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83eab2ce-6562-45ea-0785-08d9699960f8
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5407:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB540727EB1EB0ED3965A13D91E4C89@SJ0PR12MB5407.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tXqpBzIEA+4KTIA1sM9gVEI2Py3SmR4UQYa2xLhfX2EUp2lqM6Dmjv9cuGEVQzKLZ7uTRVZ37MfVzWQzJ14Ly0PWjRLPDuEIK8xD+XjQddxRgfPbTJSGe8JLZ65Rw4oOYW+ehXuTrP4rGk9W2rLmmbwevQUz6rKtD/zt1rESFGLdu5p5IsaUB/ia/r4SWvz7AI7X+u2GmvsWWAy9zqbYMgs3IYsXWUTK+gQrq24lxz82k2dhAQdhobuFzPOgm8ZU8jDDVQ4YhkXk/agAB1q//i4iEJAUpPFJoM215t74qIGfCNzeULUpUjXAf7bk22qqirJWRcVNQslHXpPdTA3IBRfC/z70u1zsC0Ke396+rXiBJv2JWNnqF3dZ5KtFOoDXkIwJW5WiKxlkJA+tYwIoSlzJO0EebzyNWJJTXPq5y9QHabwqO1IBu0J8lPp5TkHNeDacVuA2K3Cqrh10YQRAFK76XBxGcp62bqUWrVTLCGSx/3ZmqGfYqtYL2jjdNj2WbZkxWRhdNxKlRNUTJ2Zuz8ldwfWFrAneX/PXdHIYA0lNCs9B/373h2pV3gnvkjbwznEyBlgSzgFp4UTON/DRJrRq6wksQVEubcCL3rsHxKbY8ubm2zkNdCQs9nsr7fpRzKnR+Bw9xoR7xQ8614JGn2yQKsA6lJDDwUIBxdwBSj/HebHmTFM0GXKki95CifDtEq1OYxDsLVcYO5AFvss+yb84u8GLjFsPt4fkLNLIqs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(8936002)(36860700001)(4326008)(82740400003)(1076003)(70206006)(356005)(70586007)(478600001)(54906003)(81166007)(83380400001)(316002)(44832011)(2906002)(6916009)(86362001)(2616005)(6666004)(82310400003)(47076005)(36756003)(5660300002)(26005)(16526019)(336012)(426003)(8676002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:32.5837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eab2ce-6562-45ea-0785-08d9699960f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5407
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
Due to some code flow constraints, we need to defer dc_lock needed works
from dc_link_handle_hpd_rx_irq(). Thus, do following changes:

* Change allow_hpd_rx_irq() from static to public
* Change handle_automated_test() from static to public
* Extract link lost handling flow out from dc_link_handle_hpd_rx_irq()
  and put those into a new function dc_link_dp_handle_link_loss()
* Add one option parameter to decide whether defer works within
  dc_link_handle_hpd_rx_irq()

Reviewed-by: Mikita Lipski <mikita.lipski@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 92 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +
 2 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 44d7826e7654..f6589dc7a370 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2746,7 +2746,7 @@ void decide_link_settings(struct dc_stream_state *stream,
 }
 
 /*************************Short Pulse IRQ***************************/
-static bool allow_hpd_rx_irq(const struct dc_link *link)
+bool dc_link_dp_allow_hpd_rx_irq(const struct dc_link *link)
 {
 	/*
 	 * Don't handle RX IRQ unless one of following is met:
@@ -3180,7 +3180,7 @@ static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video
 	}
 }
 
-static void handle_automated_test(struct dc_link *link)
+void dc_link_dp_handle_automated_test(struct dc_link *link)
 {
 	union test_request test_request;
 	union test_response test_response;
@@ -3229,17 +3229,50 @@ static void handle_automated_test(struct dc_link *link)
 			sizeof(test_response));
 }
 
-bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss)
+void dc_link_dp_handle_link_loss(struct dc_link *link)
+{
+	int i;
+	struct pipe_ctx *pipe_ctx;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link)
+			break;
+	}
+
+	if (pipe_ctx == NULL || pipe_ctx->stream == NULL)
+		return;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
+				pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe) {
+			core_link_disable_stream(pipe_ctx);
+		}
+	}
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
+				pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe) {
+			core_link_enable_stream(link->dc->current_state, pipe_ctx);
+		}
+	}
+}
+
+static bool handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss,
+							bool defer_handling, bool *has_left_work)
 {
 	union hpd_irq_data hpd_irq_dpcd_data = { { { {0} } } };
 	union device_service_irq device_service_clear = { { 0 } };
 	enum dc_status result;
 	bool status = false;
-	struct pipe_ctx *pipe_ctx;
-	int i;
 
 	if (out_link_loss)
 		*out_link_loss = false;
+
+	if (has_left_work)
+		*has_left_work = false;
 	/* For use cases related to down stream connection status change,
 	 * PSR and device auto test, refer to function handle_sst_hpd_irq
 	 * in DAL2.1*/
@@ -3271,11 +3304,14 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 			&device_service_clear.raw,
 			sizeof(device_service_clear.raw));
 		device_service_clear.raw = 0;
-		handle_automated_test(link);
+		if (defer_handling && has_left_work)
+			*has_left_work = true;
+		else
+			dc_link_dp_handle_automated_test(link);
 		return false;
 	}
 
-	if (!allow_hpd_rx_irq(link)) {
+	if (!dc_link_dp_allow_hpd_rx_irq(link)) {
 		DC_LOG_HW_HPD_IRQ("%s: skipping HPD handling on %d\n",
 			__func__, link->link_index);
 		return false;
@@ -3289,12 +3325,18 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 	 * so do not handle as a normal sink status change interrupt.
 	 */
 
-	if (hpd_irq_dpcd_data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY)
+	if (hpd_irq_dpcd_data.bytes.device_service_irq.bits.UP_REQ_MSG_RDY) {
+		if (defer_handling && has_left_work)
+			*has_left_work = true;
 		return true;
+	}
 
 	/* check if we have MST msg and return since we poll for it */
-	if (hpd_irq_dpcd_data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY)
+	if (hpd_irq_dpcd_data.bytes.device_service_irq.bits.DOWN_REP_MSG_RDY) {
+		if (defer_handling && has_left_work)
+			*has_left_work = true;
 		return false;
+	}
 
 	/* For now we only handle 'Downstream port status' case.
 	 * If we got sink count changed it means
@@ -3311,29 +3353,10 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 					sizeof(hpd_irq_dpcd_data),
 					"Status: ");
 
-		for (i = 0; i < MAX_PIPES; i++) {
-			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link)
-				break;
-		}
-
-		if (pipe_ctx == NULL || pipe_ctx->stream == NULL)
-			return false;
-
-
-		for (i = 0; i < MAX_PIPES; i++) {
-			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
-					pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe)
-				core_link_disable_stream(pipe_ctx);
-		}
-
-		for (i = 0; i < MAX_PIPES; i++) {
-			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-			if (pipe_ctx && pipe_ctx->stream && !pipe_ctx->stream->dpms_off &&
-					pipe_ctx->stream->link == link && !pipe_ctx->prev_odm_pipe)
-				core_link_enable_stream(link->dc->current_state, pipe_ctx);
-		}
+		if (defer_handling && has_left_work)
+			*has_left_work = true;
+		else
+			dc_link_dp_handle_link_loss(link);
 
 		status = false;
 		if (out_link_loss)
@@ -3359,6 +3382,11 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 	return status;
 }
 
+bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd_irq_dpcd_data, bool *out_link_loss)
+{
+	return handle_hpd_rx_irq(link, out_hpd_irq_dpcd_data, out_link_loss, false, NULL);
+}
+
 /*query dpcd for version and mst cap addresses*/
 bool is_mst_supported(struct dc_link *link)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 83845d006c54..0efa2bc8639b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -308,6 +308,9 @@ bool dc_link_wait_for_t12(struct dc_link *link);
 enum dc_status read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data);
+void dc_link_dp_handle_automated_test(struct dc_link *link);
+void dc_link_dp_handle_link_loss(struct dc_link *link);
+bool dc_link_dp_allow_hpd_rx_irq(const struct dc_link *link);
 
 struct dc_sink_init_data;
 
-- 
2.25.1

