Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7017C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 19:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75276112D36;
	Thu,  2 Jun 2022 19:31:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2067.outbound.protection.outlook.com [40.107.212.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C36112D36
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 19:31:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/iKckyCMVskgSxX2CTlDgiPbrd7b9UcVP9sBgOOhp5csewOaxDWS7uDmo18K7Edll4D/28GjI6zwaoF1QWoAzAVeOn9UjffilzjPRxyJ23fCQvzKyGFbG/kRL6cfBdF6M5yM6jksfYZSXsnYyJ6BVLcLCTOglLkwpY7DL7q3slgcm3yNCKeguW3pd45a6aHim0ahox667ozoFR2j+O4CgnHwgfQcZZ08RHtyyXtHAffgR/uJbztwEYEx0SPnMgie819DbD9Xq0kdKjAOPbpEmCTXHK14z5ON77OEVPQKYnHlZgNAXumK3tgkUIllOzOFPAv5Hoyi842o7xc/YT+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvjInr3OSxqm226qkcqwZ7yneWZ1XQr03FUd1o/+3uI=;
 b=F40BoUWotZ2ZOcszH7f1nWds2sI1dgqrkrP6kDFxHnTr+r1I/ttR7wCbO8MF8hHXWNKNrxgELKYngSEbBJFC8FPERresZeF+nmQYFIJAgNAWZv0BJ8GMDkGIBomwCBM04FODXDbEM2Lgh+axuo6jp78WzwkZ9ws9Lf69t4u7vZj4NpDZNEhZs/IGFuyvy8rhKpbqckArCcke8X+F3FrqeiqvK8D317DvzqAUBpLXJBMwfeywaVSLkWuW5+37HnTshTH4DDwJLOjzQWFVKacJB2I2UiNjeUCQrYDvV4FG0gOt35btL8HQq1NiI8n2YHDa/+4XCQmxDmayzPu8fUzUGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvjInr3OSxqm226qkcqwZ7yneWZ1XQr03FUd1o/+3uI=;
 b=Uj613RlvIUQx4JO4/q4YJ2w71btmfCtIn8X2HO7w2B6Fuxd6EDyn9x0hxcep4vvTRB2zXfigrZNF5i6aTzNSYbraaR3qEKMX/E+KluouE/JfYaH4Hzu8QUyJiOajjkT25y73+Y7bkSWL3+7/1p0rIelwaFdYpF6dXzBiD66Mlhc=
Received: from DM6PR02CA0049.namprd02.prod.outlook.com (2603:10b6:5:177::26)
 by BN8PR12MB2849.namprd12.prod.outlook.com (2603:10b6:408:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 19:31:49 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::fb) by DM6PR02CA0049.outlook.office365.com
 (2603:10b6:5:177::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 19:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 19:31:48 +0000
Received: from leodev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 14:31:33 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amd/display: refactor dirty rect dmub command decision
Date: Thu, 2 Jun 2022 14:03:47 -0400
Message-ID: <20220602180347.754067-5-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220602180347.754067-1-sunpeng.li@amd.com>
References: <20220602180347.754067-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96d41811-24ce-4567-67ad-08da44ce8999
X-MS-TrafficTypeDiagnostic: BN8PR12MB2849:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2849EA429BA4A638A64FB28E82DE9@BN8PR12MB2849.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mW6YIEbzQLAqJUGRVsm3UnBg3/FZAz3zord3AO+H7GceRASUcjymsupZp5WMH+sfdnOyYesxRelvpJn16j17l+rJBzVPWG2YrjENukxRADW6QnxZSFXWeX+o4A/3T/NcotDEVOoY7EMFLFG95b+utXZxTBkHoYR2HTs4aOPYm+9wL9D+EtyBErjFvIlhB9Vqb5W8LDMy2eZxua/T9NWKylQqOtUmlUn0vxcXb6ljeu2A7HNcVw8Qkwttjf+6mhQ4gBrXC5B+VYR2f+XeRDaJLa00z6MVnNzMEi8lzL10xxmP/mHg+myt+KBPekG1qFxusUQe3prN5fS2au44Gai3f26nNPOLXiRqqGTDt+3CGatdF7fa9NJ40CRQbkSixUJwv/DwGTHyc51N+9xEeRvIPovOt2gtfgUcIQD9K+UuTLYfXHbUStawuaMCcsIGy0h9/ZIjGec91pRymOz01Iz3mZOKiMZj3QHJppaDNseVh6OH4IhR2hGjFyBJq4BXvH1OyimzkfWqtmtRZaJCetJ9RowsYU30pt1Cw8XH2Y6VhyS6z/0rfM/O6ToRdBsWfEZMaJD6FF4RzYC1C9ty8yzM84XEskrkku+fOQdGRBqKZrilim8/0CnGTnx3XgxWhttTBFjd/kbM7PqJ1Xq8XUGKTyR8ENCOF2KaKVVwUYGYNmhZrTO2msN4C/Y6OgiY3H/f+c9ZG+AMZqpcMowd91gTrcdWwz7mDVxwEI0djrLRV3s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(356005)(36860700001)(8936002)(47076005)(2906002)(83380400001)(426003)(2876002)(336012)(16526019)(186003)(82310400005)(6666004)(26005)(2616005)(40460700003)(1076003)(5660300002)(316002)(508600001)(70206006)(81166007)(4326008)(8676002)(54906003)(6916009)(7696005)(70586007)(86362001)(14143004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 19:31:48.7892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d41811-24ce-4567-67ad-08da44ce8999
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2849
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
Cc: dingchen.zhang@amd.com, Leo Li <sunpeng.li@amd.com>,
 Robin Chen <po-tchen@amd.com>, roman.li@amd.com, alexander.deucher@amd.com,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Chen <po-tchen@amd.com>

[Why]
To wrap the decision logic of sending dirty rect dmub command
for both frame update and cursor update path.

Signed-off-by: Robin Chen <po-tchen@amd.com>
Acked-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 14 ++++++++++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 24 ++++++++++++++-----
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 31d83297bcb5..645ec5bc3a7d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2827,6 +2827,18 @@ static void commit_planes_do_stream_update(struct dc *dc,
 	}
 }
 
+static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_state *stream)
+{
+	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+		return true;
+
+	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1 &&
+	    dc->debug.enable_sw_cntl_psr)
+		return true;
+
+	return false;
+}
+
 void dc_dmub_update_dirty_rect(struct dc *dc,
 			       int surface_count,
 			       struct dc_stream_state *stream,
@@ -2839,7 +2851,7 @@ void dc_dmub_update_dirty_rect(struct dc *dc,
 	unsigned int i, j;
 	unsigned int panel_inst = 0;
 
-	if (stream->link->psr_settings.psr_version != DC_PSR_VERSION_SU_1)
+	if (!dc_dmub_should_send_dirty_rect_cmd(dc, stream))
 		return;
 
 	if (!dc_get_edp_link_panel_inst(dc, stream->link, &panel_inst))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 7fe06a2c0c04..5b5e0dd13fd0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3325,6 +3325,23 @@ static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
 	return false;
 }
 
+static bool dcn10_dmub_should_update_cursor_data(
+		struct pipe_ctx *pipe_ctx,
+		struct dc_debug_options *debug)
+{
+	if (pipe_ctx->plane_state->address.type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
+		return false;
+
+	if (pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
+		return true;
+
+	if (pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_1 &&
+	    debug->enable_sw_cntl_psr)
+		return true;
+
+	return false;
+}
+
 static void dcn10_dmub_update_cursor_data(
 		struct pipe_ctx *pipe_ctx,
 		struct hubp *hubp,
@@ -3346,13 +3363,8 @@ static void dcn10_dmub_update_cursor_data(
 
 	struct dc_debug_options *debug = &hubp->ctx->dc->debug;
 
-	if (!debug->enable_sw_cntl_psr && pipe_ctx->stream->link->psr_settings.psr_version != DC_PSR_VERSION_SU_1)
+	if (!dcn10_dmub_should_update_cursor_data(pipe_ctx, debug))
 		return;
-
-	if (pipe_ctx->stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED ||
-		pipe_ctx->plane_state->address.type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
-		return;
-
 	/**
 	 * if cur_pos == NULL means the caller is from cursor_set_attribute
 	 * then driver use previous cursor position data
-- 
2.36.1

