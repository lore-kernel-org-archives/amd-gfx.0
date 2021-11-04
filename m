Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515ECC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1753961207
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1753961207
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B248073782;
	Thu,  4 Nov 2021 20:52:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4154B73620
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwzdWz/wsehIGd9oNr5G08tvKlpJfhe+0SRtEECK9pZIZagaChwBqa3q86y/WyrZNAfAoT4xUNrFslrRm2JH6wBoOn9Clj/JP6+wkyyb/nCN2rXTJGDa2sjoYoVydvUPSKlReqqcXl4Buncn3bBrlWLFAM0gp53jFBaoRxrudneilF8nKfZ5EmLeQLIzn31rcPgcVtS7ofGWxEufRABTKLIWarWetbEoDKGdADlQfmmabRBA6peeF/HHFLw74O49YxKxyFgJpZV8aoha36nTL7s2yUYKJCwTMetpkHMFSRE2Oe83V5n5HDeVFKBz/Rch24SAgPdTfetu+jg2/dmsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAE2GnGDZBT9gWotuNO8YozrrJwSg1fNT+zlFcy5KjA=;
 b=cwQX8b6sLxcWUq1sFATQneMh0VNay6cJByjuVxKxNumfyfkUVLdHdKUJQbQ2jOF1dmPt7EnQ91Dgd6kiVGLH3XL3HivmibsKKAxDI9/NvfJ9sFog+G2W6OWtmbe8LSTbME4KHefAKt1v+eWeqafCXkomNMW9JbcXOqM3QmXyi8KX3zPIJANM5O382Uql8jjz8Z9lV7NVuX9MjdM0fJlUhOoRZWni8lK4K4U+FNUGjz0owxL2URS+oUY9xKqXy1nRE2I3g5iPGcAkou17v642QWaJKqVnpugfWOp98qYDYaIIjjhRBQX4KHi1CnoKwX1W94s52CPgHEPbhxrLJSF8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAE2GnGDZBT9gWotuNO8YozrrJwSg1fNT+zlFcy5KjA=;
 b=QcLWUbpjkkPzioGKnV0rOdL7GeUrU86uilgfnpT7qRMfsBuBVEzgbeD3q9GmwquSZtH5fHQ3ubfLUoD5eYyYxKQMUhkmmfHKoaxm81GYxyA5mecaK7EHZFbjkr9FkFunRfHEgK/XQBx1kjiK1u9PgPEeHijlgine2nnxzFfD/Eo=
Received: from DS7PR03CA0298.namprd03.prod.outlook.com (2603:10b6:5:3ad::33)
 by DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 20:52:30 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::6) by DS7PR03CA0298.outlook.office365.com
 (2603:10b6:5:3ad::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:30 +0000
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
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:26 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:25 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/22] drm/amd/display: Use link_enc_cfg API for queries.
Date: Thu, 4 Nov 2021 16:51:59 -0400
Message-ID: <20211104205215.1125899-7-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55aa5462-9696-47e7-ebb0-08d99fd50490
X-MS-TrafficTypeDiagnostic: DM4PR12MB5326:
X-Microsoft-Antispam-PRVS: <DM4PR12MB532680DF1E4D15EE7E9723F3EB8D9@DM4PR12MB5326.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lk/sMKSooTGzfo/judQkQKcLJnlZy4UkCJq2DZGqXlVtRWnlV9cT95Dozeh8AV3gkVaeTk2HmJmV9N+Iwwo5OXmHHytSj5BV+UH9VqgVTvjfgprhnc+YZdo3GbkwUA0ceoEST34zQJEyJP1dfwQyTd+L7cYHLkNNLh8Ob6LqgKeMOn5NG0HeyaYTDe0xoHSYKIy3mGpctf1OQqvDLb92gUg6H4ErIH1cPVkdbNHk9wIOCizimM9HNhElbshTv9U4hakUphONlU0p5SekCqPKCJv3c3Ly8U/k+muP3rTrObtfpMtorieGygPsMG+U1ZTYh4CD4AGtoKNmNS82+x15DG2CsUizXGpkQUQ82bqbeyFjuMwWeXl6tHRQHaK19MJSkpYUajtN7WFvg1ti8yvG6HcA/pOBaBeyrj0pX7dZJdiwysaZVEtyYY5au+yEocHm8GkeTSsD6dtbzQ5OrcWPkCA6sM/b7ZcOHYuOPLY6awYyunduPPeQ9ubuitdbLutYPwMMaIBYgmBQWo/aA1T8pB8gZnPRCxt2QKK16b4s7trcBWIvJB+C4z0nD0UqeSGRA4iyrMURlu9TTbJ2Ga+gjAfssHWA6hIf51MM5gR7yyRh9Onz3rOhZmho7b++seAUNrNIBrcaik0VNmv6YIndewWwIOSNKM7siEI9f9YKG/z0qKl7Swfpww8gmicKNz7BvrccFsZQw4VsjPEMaSRTkmU07TzhyxmE204KagMFjN0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(1076003)(186003)(36756003)(508600001)(8936002)(82310400003)(70586007)(54906003)(8676002)(83380400001)(26005)(70206006)(316002)(6916009)(36860700001)(336012)(4326008)(5660300002)(426003)(86362001)(356005)(2616005)(81166007)(2906002)(7696005)(6666004)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:30.2273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55aa5462-9696-47e7-ebb0-08d99fd50490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
The link_enc_cfg API operates in one of two modes depending on
the stage of application of dc_state to hardware. The API is the
safest way to query link encoder assignments.

[How]
Use results of link encoder assignment query using link_enc_cfg
API.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index d856f08491de..c4944ba59ec6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3964,9 +3964,6 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 	struct cp_psp *cp_psp = &pipe_ctx->stream->ctx->cp_psp;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct link_encoder *link_enc = NULL;
-	struct dc_state *state = pipe_ctx->stream->ctx->dc->current_state;
-	struct link_enc_assignment link_enc_assign;
-	int i;
 #endif
 
 	if (cp_psp && cp_psp->funcs.update_stream_config) {
@@ -3994,18 +3991,14 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 							pipe_ctx->stream->ctx->dc,
 							pipe_ctx->stream);
 			}
+			ASSERT(link_enc);
+
 			// Initialize PHY ID with ABCDE - 01234 mapping except when it is B0
 			config.phy_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 
-			//look up the link_enc_assignment for the current pipe_ctx
-			for (i = 0; i < state->stream_count; i++) {
-				if (pipe_ctx->stream == state->streams[i]) {
-					link_enc_assign = state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i];
-				}
-			}
 			// Add flag to guard new A0 DIG mapping
 			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0 == true) {
-				config.dig_be = link_enc_assign.eng_id;
+				config.dig_be = link_enc->preferred_engine;
 				config.dio_output_type = pipe_ctx->stream->link->ep_type;
 				config.dio_output_idx = link_enc->transmitter - TRANSMITTER_UNIPHY_A;
 			} else {
@@ -4017,10 +4010,8 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 			if (pipe_ctx->stream->ctx->dc->enable_c20_dtm_b0 == true &&
 					link_enc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
 				if (pipe_ctx->stream->link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA) {
-					link_enc = link_enc_assign.stream->link_enc;
-
 					// enum ID 1-4 maps to DPIA PHY ID 0-3
-					config.phy_idx = link_enc_assign.ep_id.link_id.enum_id - ENUM_ID_1;
+					config.phy_idx = pipe_ctx->stream->link->link_id.enum_id - ENUM_ID_1;
 				} else {  // for non DPIA mode over B0, ABCDE maps to 01564
 
 					switch (link_enc->transmitter) {
-- 
2.25.1

