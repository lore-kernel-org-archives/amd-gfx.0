Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0C1C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E048F61213
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E048F61213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E8626EAC8;
	Fri, 12 Nov 2021 00:55:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 206666EAAC
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW6uvvVOSwIY5Lz7B5RHY1XVkedwtQYzg8DZXwtzC6eyZwzkx2QCkuhPToJAvXsTKMRlrpflJSjY+cDu4jzkM9zGt+XFZ6YxSwIo9zmWYhmfQZfZZEuF0CwXUYPabRrm1OuEok8SL1yCrFzI7UPl13gPUd8r/vcIDAK4oMK/N3fcJ1mQyk+QH0JJlElauZBF4B8TchgiwWwfVC/QoQcGf/0hXZ+rDQMJPUUOgsGGYFVjcHp2hEsX53ip791UJXU9i+yA46r9wpppy0D+IAq9rrzdO4b+eYCismV3JvOcUje1GBnhw9BjTt4QSaCmd4UbpazQpd9jHQ3na7gPwG3qYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRAyIOHBPdHZoHFaAhjhuuM+ML3TQewl7bTxlgYv8Ok=;
 b=R3TVoC9dSdrZW/fG2rtkMopPTpnQQV0C4qGlZLQG0a24ZZPtDeTiTlD7V0f2JUHBDEo2sTDq5laibYHazom5jmivv8+Zib9kcie4suyzNjyYRI/JHRm64DuexZ1Y0Occ5pLjh2MG18TVDtcxHluagnoypElg22JnnBvD1EtyakvXYm4WEGDEsrT5K3ACtAS1knLm3/r8SNc4SRT0K9mSdLMVPMrevx0dmwEez2L07v4ShRiRQpTw+OvAznppNxRHEU4PdFuzvfWD34CY25sZTaqdNpyPbnxwWdKW8vps72x2bpAOHx15vu9rwoK8wWAin3Lt43J7/sAM33zp1M9mzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRAyIOHBPdHZoHFaAhjhuuM+ML3TQewl7bTxlgYv8Ok=;
 b=KIprGFOndtO6ZoOyr0kezajISSp8A8M3H5QkE3oClFADIp0EiuoLlAHT6XDm8n4VaxNnfkj5qVVWB/nhUL1+CTRQEwX24/9rN8Uc41LOoFcTWvfA/69XqSLcVl51EmARF6pStF0+oWWGS2/l4sdTRbPOAWe96oZ1nLJ+f/+lIo0=
Received: from MWHPR1701CA0011.namprd17.prod.outlook.com
 (2603:10b6:301:14::21) by MW3PR12MB4394.namprd12.prod.outlook.com
 (2603:10b6:303:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 12 Nov
 2021 00:55:28 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::37) by MWHPR1701CA0011.outlook.office365.com
 (2603:10b6:301:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17 via Frontend
 Transport; Fri, 12 Nov 2021 00:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:55:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:26 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:25 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:55:22 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amd/display: Reset fifo after enable otg
Date: Fri, 12 Nov 2021 08:54:30 +0800
Message-ID: <20211112005438.5505-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 840443a9-6100-4d53-2fd2-08d9a5771e75
X-MS-TrafficTypeDiagnostic: MW3PR12MB4394:
X-Microsoft-Antispam-PRVS: <MW3PR12MB43942CA3950DD110951C7809FC959@MW3PR12MB4394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Urw+8GT/6v1op/QpZYRlI6gHECyxJ1oSjoeUYUMakuFWBLvk8GrjFK26NbhMYErCBsJaYPzLOlbJDac9FO4QQowFEFhsmM+HJ7m2xtjrQjZsiNK9yf3f6sxSBjofuA+/gG6LnV31EabCb9oARMABOo8s4UCUjVm8loPYCujq7wNLwMsUB6ooehQ782MaG4yANzukl6tXXUCh9iGFqq4UYGbzpf4YwyYCBXR6geJ/OZ7Pj/m3/Rb6YNwsAnECzyJFhNNN7SWz6DCiDCTr8LWTr29ir2wFhaYYQqpc+G95EYa9V4JFwbSm7ib1hhoRuRDWE2d2DMcEk5Kk5zA0f2V2usPLKNrP9mmq95s6VOdzn1v212RG2+GW5wN9VVDGAsKDQXRxfA5H/4q2WC692p6KIcHy6hPjtjWZbSmnSBugwCeSJi24ZhKFCsVwcDB7DwfridswvqFm2IkVx6zOyXp281dNdJfPComF+TItr/jndMjLmI4UUI/NbIuJeq74xWJ+u9QtfUM0b8qqqR6k97nUPjm1zPVET7oY9HbxfETBOa5i8oYdIaocVrdb2GuKkAs+24T9CdYe9CT/8SYyHrAifouz7M9FMmrz9y758hca7MUH/jcZNORjgqtZLzlW7mNkkWCi+PrHGAgPefm+GdmJt9/KFJZdbkjLr9XO6CKIPXLRivML98y0btMGWZ6nibm1yhxwgODX0tdefGUJDVfUdOKW3TudY/u8mIbP86SXY+M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(426003)(81166007)(4326008)(36860700001)(1076003)(508600001)(2616005)(8676002)(356005)(70586007)(8936002)(5660300002)(6916009)(47076005)(186003)(316002)(6666004)(70206006)(7696005)(86362001)(36756003)(26005)(82310400003)(2906002)(54906003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:55:27.8714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 840443a9-6100-4d53-2fd2-08d9a5771e75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, "Xu, Jinze" <JinZe.Xu@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Xu, Jinze" <JinZe.Xu@amd.com>

[Why]
In fast boot sequence, when change dispclk, otg is disabled but digfe
is enabled. This may cause dig fifo error.

[How]
Reset dig fifo after enable otg.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: JinZe.Xu <JinZe.Xu@amd.com>
---
 .../amd/display/dc/dce110/dce110_hw_sequencer.c   |  5 +++++
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c   | 15 +++++++++++++++
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h   |  3 +++
 .../amd/display/dc/dcn20/dcn20_stream_encoder.c   |  2 ++
 .../display/dc/dcn30/dcn30_dio_stream_encoder.c   |  2 ++
 .../drm/amd/display/dc/inc/hw/stream_encoder.h    |  4 ++++
 6 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index e7e2aa46218d..665cf58b0724 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1602,6 +1602,11 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 			pipe_ctx->stream_res.stream_enc,
 			pipe_ctx->stream_res.tg->inst);
 
+	if (dc_is_dp_signal(pipe_ctx->stream->signal) &&
+		pipe_ctx->stream_res.stream_enc->funcs->reset_fifo)
+		pipe_ctx->stream_res.stream_enc->funcs->reset_fifo(
+			pipe_ctx->stream_res.stream_enc);
+
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_OTG);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index b0c08ee6bc2c..bf4436d7aaab 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -902,6 +902,19 @@ void enc1_stream_encoder_stop_dp_info_packets(
 
 }
 
+void enc1_stream_encoder_reset_fifo(
+	struct stream_encoder *enc)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	/* set DIG_START to 0x1 to reset FIFO */
+	REG_UPDATE(DIG_FE_CNTL, DIG_START, 1);
+	udelay(100);
+
+	/* write 0 to take the FIFO out of reset */
+	REG_UPDATE(DIG_FE_CNTL, DIG_START, 0);
+}
+
 void enc1_stream_encoder_dp_blank(
 	struct dc_link *link,
 	struct stream_encoder *enc)
@@ -1587,6 +1600,8 @@ static const struct stream_encoder_funcs dcn10_str_enc_funcs = {
 		enc1_stream_encoder_send_immediate_sdp_message,
 	.stop_dp_info_packets =
 		enc1_stream_encoder_stop_dp_info_packets,
+	.reset_fifo =
+		enc1_stream_encoder_reset_fifo,
 	.dp_blank =
 		enc1_stream_encoder_dp_blank,
 	.dp_unblank =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index 687d7e4bf7ca..a146a41f68e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -626,6 +626,9 @@ void enc1_stream_encoder_send_immediate_sdp_message(
 void enc1_stream_encoder_stop_dp_info_packets(
 	struct stream_encoder *enc);
 
+void enc1_stream_encoder_reset_fifo(
+	struct stream_encoder *enc);
+
 void enc1_stream_encoder_dp_blank(
 	struct dc_link *link,
 	struct stream_encoder *enc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index aab25ca8343a..8a70f92795c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -593,6 +593,8 @@ static const struct stream_encoder_funcs dcn20_str_enc_funcs = {
 		enc1_stream_encoder_send_immediate_sdp_message,
 	.stop_dp_info_packets =
 		enc1_stream_encoder_stop_dp_info_packets,
+	.reset_fifo =
+		enc1_stream_encoder_reset_fifo,
 	.dp_blank =
 		enc1_stream_encoder_dp_blank,
 	.dp_unblank =
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index ebd9c35c914f..7aa9aaf5db4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -805,6 +805,8 @@ static const struct stream_encoder_funcs dcn30_str_enc_funcs = {
 		enc3_stream_encoder_update_dp_info_packets,
 	.stop_dp_info_packets =
 		enc1_stream_encoder_stop_dp_info_packets,
+	.reset_fifo =
+		enc1_stream_encoder_reset_fifo,
 	.dp_blank =
 		enc1_stream_encoder_dp_blank,
 	.dp_unblank =
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index c88e113b94d1..073f8b667eff 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -164,6 +164,10 @@ struct stream_encoder_funcs {
 	void (*stop_dp_info_packets)(
 		struct stream_encoder *enc);
 
+	void (*reset_fifo)(
+		struct stream_encoder *enc
+	);
+
 	void (*dp_blank)(
 		struct dc_link *link,
 		struct stream_encoder *enc);
-- 
2.25.1

