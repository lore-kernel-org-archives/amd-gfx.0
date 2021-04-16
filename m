Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E591C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D469B610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D469B610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35E56EB86;
	Fri, 16 Apr 2021 14:34:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C456E084
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfeiA+uw7l6i6LskpC3c9Gl6ANPtwDELuCepiM9t/0eJ9yE9xGLBqWmJkopa8mhXUicdUdSbyYQKKY5uk2nMGv1mC0LpHEo1vc6fFPg/eZkrnCFgxrOuBt1a8z+6IlhiS6uJJ7Oy/4KMHbRXpDPB5vfxS2hmVrKyJTglTMVJEjUAkNZRm0hzTMmrlVSfUdwRsQmI4qzDpe1ShuoTGGNGENhcT8P+l+lgAhvUi84P4t2gfrURu3WZlLNnxPCQgeHEUeNH0hDFy0fpTpcSpeMgbe+vncVzcN1v9ED0oBTXmgJmA9T/CW03/zkqlW47WgQTKQh2TLSzU1NInU6MIr5x3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4sFDezJsAwTc8I1L4DAkXc0cyEEZspD/GAlTWOxwro=;
 b=j2feFbGbk6gXLwKl+4KwbuaL3LEwylenCRKDstfz11Tj1KjBCgMpM8J1jcaI6yCJKO/txllEMSLA6Ik+4oR/TpnrAoS5qGyuGzy8+OCq4OYB98EtmiuJGug29l+9RILdOHMf8QuIpMeJ9liSEhMb2HY5PT8bSqdJSYOVzPIVLBYGwjpmIxqSp1StdCEeL/jHE2jPkkcOCXLRTPj/3ZiJx44WqwwwQkBpeX8FnrVX9M+bimQQYp5WsDASbsDvgu4zq5owL8ByrFYqFNfhHnhKzK1QHs97+a0no6L7zA2KSbO66pYPq+f7oO0cquBFnrZu8Qvs0Y+Q4cPOH/8yhhLbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4sFDezJsAwTc8I1L4DAkXc0cyEEZspD/GAlTWOxwro=;
 b=zvTmeYiFRbXTa0DlLYvBByejkRBqjFsHzKuSt0BY06DqehaPPWSRO3MysB3Fll0hS4hyo6vsUxWWPbCkpkksHY0Y+ZZd0/hNpkFqIyWxDM1iUa4C96KLwT13jmeJXN3ntb3IJSgdzUM1kiStYgnYtF+IE5gpq4meBlY8u4+xkek=
Received: from BN9PR03CA0544.namprd03.prod.outlook.com (2603:10b6:408:138::9)
 by BYAPR12MB4773.namprd12.prod.outlook.com (2603:10b6:a03:109::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 14:34:28 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::28) by BN9PR03CA0544.outlook.office365.com
 (2603:10b6:408:138::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:28 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:27 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/19] drm/amd/display: removed unused function
 dc_link_reallocate_mst_payload.
Date: Fri, 16 Apr 2021 10:34:04 -0400
Message-ID: <20210416143417.611019-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aae37b4-b495-48cf-951d-08d900e4bdde
X-MS-TrafficTypeDiagnostic: BYAPR12MB4773:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4773B6D8B336688157FB2D2F8B4C9@BYAPR12MB4773.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9BI3sb33PkXODxP9Brtp8DKeBZ2NVwUX5s6VBCaMhf7XLsG9ZYCydO5L2eDQmlggqPKqeEeqju1LE1N9DEFXThNRSnAudij/DhNRqaAtJJeElUH6dMm6iVycx02EKNpso8zgyTZJQRz1OXBlYd77OxUSIecLdxUR8rXsEVK9RpZzQegprvwaxYKfP/hGwCtc4JipPIiajOHQu/8TgAOlhkB9tijUdKjAR/by9yNC3yTJpE7hKaqDmDEnFC9pNb+KtfevQVYDdkfYCImVT17zWVsnUrXgZnPUxzhffA0edjEFMPBTlJPiEQPffDR+jBmP0hBT6Y2bc55dSRxJ1PJjJSq53WCzTufiMOfBzVGAIjJy4HJiYzQX2PDmKXjM7VHcZ/FF7wdPUCl9+fC07yhNjz606srBorIlKxb2rj+dKo7V+8dU2H8sKFvZq1F5c08JNDwxWp+04HaIrj6Ut1mRQxFDptcVYOME+8UZdGp71rPMRuUhTKH+1X4ZE8JBq1Px9Znbepl6HXS6KAvHnuGoNIqdZ3OhvzkLl125YEdPqtQeVyu8uHgjYtZmgRT/Iy18zcWYlPp/3thJqA6L5CnxZPGDU1qm5PwDHvVT3wpdCF3m+16NbnH2JkN2nCfql3gEjGDOmRjkjGZUhWP/5ta6lwOa3NJTRkB/y8cKn+IEcoIjg6PWOufmidZSmqukODm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(6916009)(82740400003)(8936002)(1076003)(478600001)(47076005)(356005)(70206006)(81166007)(70586007)(44832011)(8676002)(6666004)(2616005)(86362001)(5660300002)(36756003)(83380400001)(4326008)(336012)(316002)(2906002)(82310400003)(426003)(7696005)(26005)(36860700001)(186003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:28.7210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aae37b4-b495-48cf-951d-08d900e4bdde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4773
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
Cc: Robin Singh <robin.singh@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Singh <robin.singh@amd.com>

[Why]
Found that dc_link_reallocate_mst_payload is not used anymore
in any of the use case scenario.

[How]
removed dc_link_reallocate_mst_payload function definition
and declaration.

Signed-off-by: Robin Singh <robin.singh@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 44 -------------------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 -
 2 files changed, 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 9507b08567b4..fa384923cfc1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3136,50 +3136,6 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	return DC_OK;
 }
 
-enum dc_status dc_link_reallocate_mst_payload(struct dc_link *link)
-{
-	int i;
-	struct pipe_ctx *pipe_ctx;
-
-	// Clear all of MST payload then reallocate
-	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-
-		/* driver enable split pipe for external monitors
-		 * we have to check pipe_ctx is split pipe or not
-		 * If it's split pipe, driver using top pipe to
-		 * reaallocate.
-		 */
-		if (!pipe_ctx || pipe_ctx->top_pipe)
-			continue;
-
-		if (pipe_ctx->stream && pipe_ctx->stream->link == link &&
-				pipe_ctx->stream->dpms_off == false &&
-				pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-			deallocate_mst_payload(pipe_ctx);
-		}
-	}
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
-
-		if (!pipe_ctx || pipe_ctx->top_pipe)
-			continue;
-
-		if (pipe_ctx->stream && pipe_ctx->stream->link == link &&
-				pipe_ctx->stream->dpms_off == false &&
-				pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-			/* enable/disable PHY will clear connection between BE and FE
-			 * need to restore it.
-			 */
-			link->link_enc->funcs->connect_dig_be_to_fe(link->link_enc,
-									pipe_ctx->stream_res.stream_enc->id, true);
-			dc_link_allocate_mst_payload(pipe_ctx);
-		}
-	}
-
-	return DC_OK;
-}
 
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
 static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index b0013e674864..054bab45ee17 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -276,7 +276,6 @@ enum dc_detect_reason {
 bool dc_link_detect(struct dc_link *dc_link, enum dc_detect_reason reason);
 bool dc_link_get_hpd_state(struct dc_link *dc_link);
 enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx);
-enum dc_status dc_link_reallocate_mst_payload(struct dc_link *link);
 
 /* Notify DC about DP RX Interrupt (aka Short Pulse Interrupt).
  * Return:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
