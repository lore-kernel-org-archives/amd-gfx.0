Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1ECC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD7E60E77
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CBD7E60E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C480B6E1C0;
	Wed,  8 Sep 2021 14:54:43 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602296E19C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foFa5VX4f3P44SK+oHE/DSGXSa0s0h408mho/A45uES017jHGp4Gni6dXGWzmhc7KUW1EJcfM/du1D3mUcn1pp7pixGjEy6FgyR7gvZ0ArHkTmCZSOhsfSZCqNsXoaoe+CMHn3qSRwglzWKnb551SV2dQJ7T88sBAs05UU3RvIdv+8MMqUjNvkQn2AZocmEks7OWzOGeG4phCe/FcOFYT4kbdy3k0XMAgm/+9YTnbH1gtVVU3hX3zCF4qd5k29XFchzumugxJcKgtvGdV7W9raz92P4nhc+KLZeueI0wfaJGbS828s+qSWP/0QyXmYNanDwhPP/xzY9Gu1QZs9BZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ke/BMJclhw/pxT3yAa6cRr03YK2lCCB/nAo1vZnCkwQ=;
 b=nLDTclj+d+JKgpLIZ4hwOx0GGoUMkZo6vedNot0ZmXviiT20zcFUTzTy4eOkgRME6CrOVKaUwIk78Igvn/hKqPT5ryaNtaNRJTqpbPWpNe/9ImXU1NI8ymA+EBaHULA2rt2QH9kwLBVIcyuIj91BwOUcMWjVnzzeMpeOjmZptHMG3GUqe+BBqGBfVnvM8yESORot5u/9ze728FJWfuBqA+zoIdvCa+TSLYEhMzZq/I3RSqQ80lE/boSJlFGmYfkULYmvKnqG4eNRiX/PiG46wt5lvxHXrwFnWQQL67MtB6vOSHHgdH0DAwg0rYfUAR1YKNSs5IC9iZc55EtThCqyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke/BMJclhw/pxT3yAa6cRr03YK2lCCB/nAo1vZnCkwQ=;
 b=FAch5PajSKApqLkRDwEKQTGkZxtiNXCxGDrbO1ZUB/Rt9zcbt01n8SYOTFCyABjVmn1feIxin9zduAbxmxVlO/kU3R0sM0HJqp0QG37JjZbrCgS8gG2fvRqh+jaHzIEZVNxJsiafVjpMpIKbuSC1wrDUujOaQMZbe3Jp4BFzcvw=
Received: from DM6PR13CA0022.namprd13.prod.outlook.com (2603:10b6:5:bc::35) by
 DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Wed, 8 Sep 2021 14:54:40 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::e7) by DM6PR13CA0022.outlook.office365.com
 (2603:10b6:5:bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:40 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:38 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 05/33] drm/amd/display: Add option to defer works of hpd_rx_irq
Date: Wed, 8 Sep 2021 10:53:56 -0400
Message-ID: <20210908145424.3311-6-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee09c1cc-6af7-4b4b-926d-08d972d895db
X-MS-TrafficTypeDiagnostic: DM8PR12MB5493:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54939846905BCD9C370E558BE4D49@DM8PR12MB5493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPR/FgpJXJfJk8qoUDMDPiSevtbQ0RLhmwoPF3HkHXMIju45Y5ND1/DeFHEmP2TKDDtTsYKls3m6sXdvlCYhVxhOVamWtPb/WPv1l+VsBJIorxZYm8EumepRlSQbOxmrUy+oC041cOUsv4a0TWqfzghcIdEPpd+lbBrc4lfQKtyUDI3q6GELDyAjQkZY9LCodbDSW0c2u2wC5K/38PCtrz8vtZabPNkR1M3Qjvfk3mzIWkrccliib7chwCgQEL5ZXNsWfJWdyvckarjocoqViqkc2ZbJBp+R/mIGVHQMZ+dAIOSnKiuDI0AFHlxFmkcGMHR4ByhGIvpOxOnEjFe8fi/mEFqVGcTIZhxz/z0kp68LE8AXu9pxGdjEz8s2JOQ5lhxXju7VAUFnr5bW6gcanOxaLOtZW/cbOOqnDbcf86OiigexwXvypgKeZT5wTx9LBbauCpWmJL53S6H7bPlXkQsZXq45/pCI44N2Muixxs85ipFOnKqM0r2C/0ePPGJ3Icyp081aMKkI0Sv8lQARmAbPv1jk+dTYcU2mWCI2CeQW0sI/bDxI0WFwEPXo6bSp9meoIDged/5PFiqNE2NxQLtV/CwkilAr7WrNL4pewIgilSslKWdf1T8WAEUh1Gn0I3VRMz//Wli1guPhQrIRotvpKvm+XEkTxdtRgcxrx70CUFQttK+GE5c861ghw2aopdUKPUxvg8JRsq3McpvYee9cmhvGGdcR46oEUHAQ5K4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966006)(36840700001)(478600001)(44832011)(54906003)(316002)(47076005)(5660300002)(336012)(186003)(26005)(4326008)(36756003)(70206006)(82740400003)(2616005)(8936002)(2906002)(6666004)(86362001)(6916009)(70586007)(36860700001)(356005)(81166007)(16526019)(83380400001)(426003)(1076003)(8676002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:40.1343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee09c1cc-6af7-4b4b-926d-08d972d895db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
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

Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 92 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +
 2 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 53c3c9c1a79d..22455113ba9d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3432,7 +3432,7 @@ void decide_link_settings(struct dc_stream_state *stream,
 }
 
 /*************************Short Pulse IRQ***************************/
-static bool allow_hpd_rx_irq(const struct dc_link *link)
+bool dc_link_dp_allow_hpd_rx_irq(const struct dc_link *link)
 {
 	/*
 	 * Don't handle RX IRQ unless one of following is met:
@@ -3941,7 +3941,7 @@ static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video
 	}
 }
 
-static void handle_automated_test(struct dc_link *link)
+void dc_link_dp_handle_automated_test(struct dc_link *link)
 {
 	union test_request test_request;
 	union test_response test_response;
@@ -3990,17 +3990,50 @@ static void handle_automated_test(struct dc_link *link)
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
@@ -4032,11 +4065,14 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
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
@@ -4050,12 +4086,18 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
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
@@ -4072,29 +4114,10 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
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
@@ -4120,6 +4143,11 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
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
index 4fdb24ba24af..bb515d640965 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -315,6 +315,9 @@ bool dc_link_wait_for_t12(struct dc_link *link);
 enum dc_status read_hpd_rx_irq_data(
 	struct dc_link *link,
 	union hpd_irq_data *irq_data);
+void dc_link_dp_handle_automated_test(struct dc_link *link);
+void dc_link_dp_handle_link_loss(struct dc_link *link);
+bool dc_link_dp_allow_hpd_rx_irq(const struct dc_link *link);
 
 struct dc_sink_init_data;
 
-- 
2.25.1

