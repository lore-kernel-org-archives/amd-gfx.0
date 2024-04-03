Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCE0CD1294
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818EA112E79;
	Wed,  3 Apr 2024 19:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nUogHIyW";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FC9112E76
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJE70W1TlIHfrEYkORJ+ae9/O0klwxdZEUnw0fyHp0MlX/PIpgAO6zuELh5oiz1JuAx+MFzy0HxXZPBiUEP8vuOa1qzMLdPa2hsCGz7R8irwylB27z+ArXordI2ETcpJsJVlvcOAqCM9/1gwAz39Z1q7EYr6CqAeVTL1mJevb2K/oDM84VTI/xUPURTTzYyQVOGzLr+xgqquC9X8fUgA1eFbZFZnFVgo8l3Jkf2bG3zPzHdmjRAOWRpg5x4iPQ8kcYAlAxJDYRfD18iJdbEua5lPK79hSYBfvScsfVzjlJBCO+3nfM4S6hav69NjeoH1PiYXhJcQCWq8yMwOzyGj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQEa6/kqG3IV7vLj2iJiGC0FROCbOGnzzWpeCrg3HVI=;
 b=dh3zslvPZNlKu26ZAOCnp6i6RwrVMCqEWNn5a8fxoEa37NOZCQyUWdgWdqtL5DRxdG3PBERyi7gzBvTM+F4eDUMyhb95X2e5YxT42KnoGEHFqhlOOPqTCozB+grZIicM0mD96fddL6CLneFZTDmdCDuItTZp5tePAotBJNHnivsV6dG9/a4csOO2FH/c1rmiC1mmMP/S7bifZeJGxJUv9rgdn9C+5csgPDK4WnDmlV8kzJg8FPsB2H7L6/nPR6GtrAbkBOrC1WMR+abL/Ia4oqe0teKYRVTnfXNgFIbvQdvVd4/GDGZI3yVhXweNSnvDn09sYmU8FvCGuZ0y8tgYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQEa6/kqG3IV7vLj2iJiGC0FROCbOGnzzWpeCrg3HVI=;
 b=nUogHIyWEtseBL2eeMHT9MkHJERTb7FEnjCY5yoMfWnzl7YIKRCPUVBR4t4DpYzc8QHRPwz8LdU7N1QG82LoPTJ/hFZLZrF02viMzjPdIiOBhcZG5zyBrcrOtK7JE8YBz2WMaIfSpuJoR8ErgQjgiqhGY4M5yn7URx29xAMmuQ4=
Received: from CH0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:610:74::17)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:36 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::a0) by CH0PR04CA0072.outlook.office365.com
 (2603:10b6:610:74::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:35 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:34 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 05/28] drm/amd/display: Add driver support for future FAMS
 versions
Date: Wed, 3 Apr 2024 15:48:55 -0400
Message-ID: <20240403195116.25221-6-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: e771d796-7fbb-4f2b-cf81-08dc54177862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejl/SmJrKNU0I1IB8PFzZqPbscySl5zsRD3YxF/TFAtHztsJ3PH+1PBdBmZlA0Kgm6T6uUxBkl1+c4lTcXJ/DgaGJytuIq81xE9DGm9H527/iI76PN9BV8mV3UFdfPmDf6C96eo4t3xTFXPZ2K1KhF0W4msb/O+yssL7Ee5H5r+76RsDMIf38ZvO4/iyhOcg1fp23lkbyQk7GUXrbexVref1J97IIcb7doV6JSb5GULS6k3SA390jxp0qWzAswlsmRzi9gLfYUPWZPZr1gQBFLD+EW5fsenLo/G5eV1E3CSY9BUeqDE+WDgeQ7lvHMKN+rRQcGcjsy21qHkgSzCk04ssfZ8dwvp7XAULA7tvLV4RuRzPW/FiSgUYqz8/h3iT99KSZj1UMEXo2smpvjv/GrSAhH5/ArWtmPLql8LxjMDBVgh4zsAsj56s/6w7ZskchQuah4R4kD4PPmQ8aUVjj4XsIt5n3XT1cXYdK2vuFn9jt2KKNTlIJvBGaCk7XSVgBEogibuucczS2hmek0JjdqZq3XXXL6aHODofRythFMjRAJdxG1Zelf+dhSRe9yisyW3vq/Ow4J6lMWo1nfXk8pie//Wk2ZDAAtOonvAtaZX/7F4VBW1Luv3sVRoa9IRVDPdLG66vQCYrTwlwzzEaksVI7x9iL7UrCD9V06Nm4Esfoo82zDAzniPAiPwmTvyzzKNNsJPC6VakGsI0nGMQ2vA+QWdUgSbSTjysBRoQZU0NhLWpYLnA16YAzPYeEvmK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:35.9709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e771d796-7fbb-4f2b-cf81-08dc54177862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Changes to support future versions of FAMS.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  2 --
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 ++++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  3 ++-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  1 +
 .../gpu/drm/amd/display/dc/core/dc_surface.c  | 20 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  2 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  1 +
 .../gpu/drm/amd/display/dc/dc_plane_priv.h    |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  3 ++-
 11 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 645a8991a830..bc16db69a663 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -44,8 +44,6 @@
 
 #include "bios_parser_common.h"
 
-#include "dc.h"
-
 #define THREE_PERCENT_OF_10000 300
 
 #define LAST_RECORD_TYPE 0xff
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5a93278fa246..213a9b823c0c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -36,6 +36,7 @@
 #include "resource.h"
 #include "dc_state.h"
 #include "dc_state_priv.h"
+#include "dc_plane_priv.h"
 
 #include "gpio_service_interface.h"
 #include "clk_mgr.h"
@@ -3562,6 +3563,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	struct dc_stream_status *stream_status = NULL;
+
 	dc_exit_ips_for_hw_access(dc);
 
 	dc_z10_restore(dc);
@@ -3619,7 +3621,8 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 			context->block_sequence,
 			&(context->block_sequence_steps),
 			top_pipe_to_program,
-			stream_status);
+			stream_status,
+			context);
 	hwss_execute_sequence(dc,
 			context->block_sequence,
 			context->block_sequence_steps);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index df0f23afc8bb..5c1d3017aefd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -560,7 +560,8 @@ void hwss_build_fast_sequence(struct dc *dc,
 		struct block_sequence block_sequence[],
 		unsigned int *num_steps,
 		struct pipe_ctx *pipe_ctx,
-		struct dc_stream_status *stream_status)
+		struct dc_stream_status *stream_status,
+		struct dc_state *context)
 {
 	struct dc_plane_state *plane = pipe_ctx->plane_state;
 	struct dc_stream_state *stream = pipe_ctx->stream;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 4f9ef07d29ec..bf889bdd3925 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -915,3 +915,4 @@ struct dc_stream_state *dc_state_get_stream_from_id(const struct dc_state *state
 
 	return stream;
 }
+
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index ea624e000ec0..067f6555cfdf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -60,6 +60,26 @@ void dc_plane_destruct(struct dc_plane_state *plane_state)
 	// no more pointers to free within dc_plane_state
 }
 
+
+/* dc_state is passed in separately since it may differ from the current dc state accessible from plane_state e.g.
+ * if the driver is doing an update from an old context to a new one and the caller wants the pipe mask for the new
+ * context rather than the existing one
+ */
+uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_state, const struct dc_plane_state *plane_state)
+{
+	uint8_t pipe_mask = 0;
+	int i;
+
+	for (i = 0; i < plane_state->ctx->dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &dc_state->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->plane_state == plane_state && pipe_ctx->plane_res.hubp)
+			pipe_mask |= 1 << pipe_ctx->plane_res.hubp->inst;
+	}
+
+	return pipe_mask;
+}
+
 /*******************************************************************************
  * Public functions
  ******************************************************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index db87f9cdd567..54534df73e83 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -44,6 +44,8 @@
 
 #include "dml2/dml2_wrapper.h"
 
+#include "dmub/inc/dmub_cmd.h"
+
 struct abm_save_restore;
 
 /* forward declaration */
@@ -219,6 +221,7 @@ struct dc_dmub_caps {
 	bool mclk_sw;
 	bool subvp_psr;
 	bool gecc_enable;
+	uint8_t fams_ver;
 };
 
 struct dc_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4c98cd066b8f..2293a92df3be 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -35,6 +35,7 @@
 #include "resource.h"
 #include "clk_mgr.h"
 #include "dc_state_priv.h"
+#include "dc_plane_priv.h"
 
 #define CTX dc_dmub_srv->ctx
 #define DC_LOGGER CTX->logger
@@ -1593,3 +1594,4 @@ bool dc_wake_and_execute_gpint(const struct dc_context *ctx, enum dmub_gpint_com
 
 	return result;
 }
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index c0a512a12531..2c5866211f60 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -35,6 +35,7 @@ struct pipe_ctx;
 struct dc_crtc_timing_adjust;
 struct dc_crtc_timing;
 struct dc_state;
+struct dc_surface_update;
 
 struct dc_reg_helper_state {
 	bool gather_in_progress;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_plane_priv.h b/drivers/gpu/drm/amd/display/dc/dc_plane_priv.h
index 9ee184c1df00..ab13335f1d01 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_plane_priv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_plane_priv.h
@@ -30,5 +30,6 @@
 
 void dc_plane_construct(struct dc_context *ctx, struct dc_plane_state *plane_state);
 void dc_plane_destruct(struct dc_plane_state *plane_state);
+uint8_t dc_plane_get_pipe_mask(struct dc_state *dc_state, const struct dc_plane_state *plane_state);
 
 #endif /* _DC_PLANE_PRIV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 9aea4a088652..9f1a86ddadb5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -956,7 +956,7 @@ void dcn32_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
 
 		if (dc->ctx->dmub_srv->dmub->fw_version <
-		    DMUB_FW_VERSION(7, 0, 35)) {
+				DMUB_FW_VERSION(7, 0, 35)) {
 			dc->debug.force_disable_subvp = true;
 			dc->debug.disable_fpo_optimizations = true;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 659ce11ad446..7c339e7e7117 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -482,7 +482,8 @@ void hwss_build_fast_sequence(struct dc *dc,
 		struct block_sequence block_sequence[],
 		unsigned int *num_steps,
 		struct pipe_ctx *pipe_ctx,
-		struct dc_stream_status *stream_status);
+		struct dc_stream_status *stream_status,
+		struct dc_state *context);
 
 void hwss_send_dmcub_cmd(union block_sequence_params *params);
 
-- 
2.44.0

