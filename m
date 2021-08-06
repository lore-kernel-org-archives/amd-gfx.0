Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC70C4338F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E21661181
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E21661181
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B25016EB94;
	Fri,  6 Aug 2021 16:36:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB376E1BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhS8eLH0oiKY2vbGa/+3dXkA6A7D/Oo1DTSlsUVy+gW0MNiGKIGnfpIMxzNsfEhv+j+rKdxLnNTZ1QfA1DEjOKr+8tNvEQkgwdy8rhan6GQ6MXt4NjGhWDDhnl5SU+E6sZAkmPb+csc1Xn/wkIXEhiazE3w2B4LXSAL+8QcuBAd2Nqd0oMAjwESvzQkoqBW8pyKSgezAMOsuNtXwtHefdZXka1pm8Syo7M6jc32timmUF1KqQOmtFMxJvp5iQPCLtLJ/cVXmqQmVmlxA8LqgFP5uDvUa93y8CI+u/7QxR09b4sxDcrImKYo0Cyoe9tGZfU+VaT0Pvcs4aiRLE/nfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3Z30Gnl9g3NCSfcSfy9bsNCQ4Kpd+kWSkMLgcWiUk0=;
 b=I+cbA7dKqDdaVXMiXjoH8ps73KDAZl0fP62TPKZeVy8rPlNmDrD3/DUBgdK6Hs+GztFdztVnCkTLtm0IVQ1klSNjeovc8dvoA+aBVyZMlylp+uCFQDObxkM9cqHzrz6yTtucNbPqGQVOW+UPKCmrUfONH19jGqJe1+zJ7xdPZfSpJDQlfScRDylACCbfkIrJGrckiL/+fWNlwnQlx0004ToqB+NBb6kD5N6KClT6pz8elrsZP8rr6zkW5aTGsm4Bvhpfm4bTmYf8P10/aajQ8l8UjLEYhad0iXFLtqVM0GQ6w6Ui8MJWGzhyEFZZsZ/BMigwR39Ed+Bz53nUfiAQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3Z30Gnl9g3NCSfcSfy9bsNCQ4Kpd+kWSkMLgcWiUk0=;
 b=NK3dNJ5cBDqSfa1dq6ctaSSVEydAUN4CIIXXwcK/cxLULsO5E32GkWcSkDIlFkaTv+Fx+8GJIVI6SxTwBkskdwBbi2bQWi6kLySU7OS65jmARr2cyc28kQQGypN9fEdllnft7kQZBxf5rMPtXQgs8DzdfsHIBzISssdLfQzAnwE=
Received: from BN9PR03CA0368.namprd03.prod.outlook.com (2603:10b6:408:f7::13)
 by DM6PR12MB2700.namprd12.prod.outlook.com (2603:10b6:5:4d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 16:35:40 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::2d) by BN9PR03CA0368.outlook.office365.com
 (2603:10b6:408:f7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend
 Transport; Fri, 6 Aug 2021 16:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 16:35:39 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 11:35:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 09:35:39 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 11:35:36 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Eryk.Brol@amd.com>,
 <bindu.r@amd.com>, <Anson.Jacob@amd.com>, Roy Chan <roy.chan@amd.com>
Subject: [PATCH 04/13] drm/amd/display: refactor the cursor programing codes
Date: Fri, 6 Aug 2021 12:34:40 -0400
Message-ID: <20210806163449.349757-5-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806163449.349757-1-Anson.Jacob@amd.com>
References: <20210806163449.349757-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ee648af-5fad-43ba-5fdc-08d958f83a08
X-MS-TrafficTypeDiagnostic: DM6PR12MB2700:
X-Microsoft-Antispam-PRVS: <DM6PR12MB270099A2A0CE391C83E4C105EBF39@DM6PR12MB2700.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjYuEBfa/FX4f/5i4J8CePM69JEU19j9kpfOZ1SOef4PreO7m8chb2W89cD724q/R8Ch7hOA9QDHqVcGjiLnwi4AVuWJbQS5If5yiFduZ7/nwzhVa/P31w/jP1jnu/A1+CW2YGJGLokKbgUNYGPMp3JYyV1qzLdGYf4j2Ilm2av/D0ULKe2p4jZNm8RjHcr0C+v580glpkxucb1BMK5zwYTRxnTCF1LrWtZm8v/N79WcteVl6P0lnfv9OUSXTiYf4J36tPKQkdEvJkthwZJlv0TpNaYKNCEfUH7cqlNGNSumTbpbAdvts+Uu3bGtnVV+3BkRvRB4mjg7T4Lzi4AGjZUh8C/15YvsI49yuk2J/mOUmVKHlhdlCVQR+6vEjpdhgTZMww+RXBLbSqgQXySR2u81tybg3O5XGWMTDBDXe+v/Ormmk60X5p1AVmzR5vgDOLximqrXbttJXfx1EByOy/ultNVFYgCJy3TfIcBiiQWmPfohQQxktoMCvXmshNAU8E+a9DjZ8c7am0et/GNClMpgDbXTi2vwUs32zQmcfCO7lBIUE7kPRyGUQ8yvnWa+LCKO3OE9C6lbLSXUowQlx/Rdbj01/JaARlC/7K0wpCnxcxGFBjfXtnaD5ev132enndI1wozDz6PqNez76vFsemwqzN/qgd4YWKDwsFl7TD51ISeT1j1a968SXcVXT22VvUFqkCWLUOr3OraqjEPxC6ZeTWQhg7WdBwTzXNNx/Cw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(46966006)(36756003)(82310400003)(47076005)(70586007)(70206006)(36860700001)(2906002)(86362001)(83380400001)(82740400003)(81166007)(4326008)(316002)(8676002)(426003)(2616005)(8936002)(356005)(7696005)(336012)(54906003)(186003)(6666004)(26005)(6916009)(478600001)(1076003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 16:35:39.7957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee648af-5fad-43ba-5fdc-08d958f83a08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2700
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

From: Roy Chan <roy.chan@amd.com>

Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Roy Chan <roy.chan@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 106 +++++++++++-------
 1 file changed, 65 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 327fd1909c51..f0f54f4d3d9b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -246,6 +246,40 @@ struct dc_stream_status *dc_stream_get_status(
 	return dc_stream_get_status_from_state(dc->current_state, stream);
 }
 
+static void program_cursor_attributes(
+	struct dc *dc,
+	struct dc_stream_state *stream,
+	const struct dc_cursor_attributes *attributes)
+{
+	int i;
+	struct resource_context *res_ctx;
+	struct pipe_ctx *pipe_to_program = NULL;
+
+	if (!stream)
+		return;
+
+	res_ctx = &dc->current_state->res_ctx;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
+
+		if (pipe_ctx->stream != stream)
+			continue;
+
+		if (!pipe_to_program) {
+			pipe_to_program = pipe_ctx;
+			dc->hwss.cursor_lock(dc, pipe_to_program, true);
+		}
+
+		dc->hwss.set_cursor_attribute(pipe_ctx);
+		if (dc->hwss.set_cursor_sdr_white_level)
+			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
+	}
+
+	if (pipe_to_program)
+		dc->hwss.cursor_lock(dc, pipe_to_program, false);
+}
+
 #ifndef TRIM_FSFT
 /*
  * dc_optimize_timing_for_fsft() - dc to optimize timing
@@ -270,10 +304,7 @@ bool dc_stream_set_cursor_attributes(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_attributes *attributes)
 {
-	int i;
 	struct dc  *dc;
-	struct resource_context *res_ctx;
-	struct pipe_ctx *pipe_to_program = NULL;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool reset_idle_optimizations = false;
 #endif
@@ -293,7 +324,6 @@ bool dc_stream_set_cursor_attributes(
 	}
 
 	dc = stream->ctx->dc;
-	res_ctx = &dc->current_state->res_ctx;
 	stream->cursor_attributes = *attributes;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
@@ -305,11 +335,39 @@ bool dc_stream_set_cursor_attributes(
 	}
 
 #endif
+	program_cursor_attributes(dc, stream, attributes);
+
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	/* re-enable idle optimizations if necessary */
+	if (reset_idle_optimizations)
+		dc_allow_idle_optimizations(dc, true);
+
+#endif
+	return true;
+}
+
+static void program_cursor_position(
+	struct dc *dc,
+	struct dc_stream_state *stream,
+	const struct dc_cursor_position *position)
+{
+	int i;
+	struct resource_context *res_ctx;
+	struct pipe_ctx *pipe_to_program = NULL;
+
+	if (!stream)
+		return;
+
+	res_ctx = &dc->current_state->res_ctx;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
 
-		if (pipe_ctx->stream != stream)
+		if (pipe_ctx->stream != stream ||
+				(!pipe_ctx->plane_res.mi  && !pipe_ctx->plane_res.hubp) ||
+				!pipe_ctx->plane_state ||
+				(!pipe_ctx->plane_res.xfm && !pipe_ctx->plane_res.dpp) ||
+				(!pipe_ctx->plane_res.ipp && !pipe_ctx->plane_res.dpp))
 			continue;
 
 		if (!pipe_to_program) {
@@ -317,31 +375,18 @@ bool dc_stream_set_cursor_attributes(
 			dc->hwss.cursor_lock(dc, pipe_to_program, true);
 		}
 
-		dc->hwss.set_cursor_attribute(pipe_ctx);
-		if (dc->hwss.set_cursor_sdr_white_level)
-			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
+		dc->hwss.set_cursor_position(pipe_ctx);
 	}
 
 	if (pipe_to_program)
 		dc->hwss.cursor_lock(dc, pipe_to_program, false);
-
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	/* re-enable idle optimizations if necessary */
-	if (reset_idle_optimizations)
-		dc_allow_idle_optimizations(dc, true);
-
-#endif
-	return true;
 }
 
 bool dc_stream_set_cursor_position(
 	struct dc_stream_state *stream,
 	const struct dc_cursor_position *position)
 {
-	int i;
 	struct dc  *dc;
-	struct resource_context *res_ctx;
-	struct pipe_ctx *pipe_to_program = NULL;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool reset_idle_optimizations = false;
 #endif
@@ -357,7 +402,6 @@ bool dc_stream_set_cursor_position(
 	}
 
 	dc = stream->ctx->dc;
-	res_ctx = &dc->current_state->res_ctx;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	dc_z10_restore(dc);
 
@@ -370,27 +414,7 @@ bool dc_stream_set_cursor_position(
 #endif
 	stream->cursor_position = *position;
 
-	for (i = 0; i < MAX_PIPES; i++) {
-		struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
-
-		if (pipe_ctx->stream != stream ||
-				(!pipe_ctx->plane_res.mi  && !pipe_ctx->plane_res.hubp) ||
-				!pipe_ctx->plane_state ||
-				(!pipe_ctx->plane_res.xfm && !pipe_ctx->plane_res.dpp) ||
-				(!pipe_ctx->plane_res.ipp && !pipe_ctx->plane_res.dpp))
-			continue;
-
-		if (!pipe_to_program) {
-			pipe_to_program = pipe_ctx;
-			dc->hwss.cursor_lock(dc, pipe_to_program, true);
-		}
-
-		dc->hwss.set_cursor_position(pipe_ctx);
-	}
-
-	if (pipe_to_program)
-		dc->hwss.cursor_lock(dc, pipe_to_program, false);
-
+	program_cursor_position(dc, stream, position);
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* re-enable idle optimizations if necessary */
 	if (reset_idle_optimizations)
-- 
2.25.1

