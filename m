Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08699C52D7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 22:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B2910E555;
	Thu, 15 Aug 2024 22:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IGMndx3l";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F17910E53F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 22:45:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEgnJrYCeTTlXHJ/+K+QE2lVCuUHNFiAt7L33RTW2Lg4KCv2TkFwhT9atGBB/q6m7y4BrBRZ0H/XaX1SC8Y/+LKuvy1Y79rEEW2L8yt6ZMYIqFkP6R6DBSOnSI58qEkCrpIJcerYYUZms3CXKDuy/HavAz3ac32gqYa1nk+hP8QbrgKQOW1PdwWRg0NlvyhDemg4T6mZaLXNjgR1AjzgefXKq08HCOa7ZuzNVqOclALNMINKsX4ijSy5/n7s3LcpfSCtsS5QbfujuToVzjVatR79B35rwL41e2opM2n4/q9uYJAD+UDHI04bYPbYu3E8Qw1UiGWV89KxTduOpISvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuFqrCyxc3ozb732MA3V1TbKQNF8wAZBAnfw3cuQ48o=;
 b=EldmwcpMbM7w6NVV3CDsiDndN0ig1DF3S6GaqXbFTrk3AWgeULX/+iRj55WEXfJXv7Itjxx/XFGJ8RHRz9IMhguWmQMzQZRaZDNus1VkzuRFtYQDpRQ9QPXhVUx3JR2Agk2h/3fcgmyOYDZFJaIcXD1TVyZQBrU5wCouiTRKXqmwmhIDr/HOFeuqo/XH9iRuo/XHBj0kqE11kEH1pajlTifi4yKmJttikOfc+OKD6RRT1QBaEJLEFRcQIIy4cH1FVlTDrFb/DV4Abmri3g3nteGXTVQ07r1jtZEOVDZXVz0IpvUailhht6qQcO9IY3PPtiI1YAbai84Hfu5FD0IAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuFqrCyxc3ozb732MA3V1TbKQNF8wAZBAnfw3cuQ48o=;
 b=IGMndx3l7PTIx8T5XJAG+v2fWe8D8ZiRpH3EVulKS6Jcv80HvcGKWeEvfp/lSpS+0dPk0pM9LdDE4/HBCgB77Yt6PJtkwLJQc4knIF86Esk1f4fU7U4lENectOhXFvmncOvB9AyQ/pwPon/HEL9WL2jTE3VEi25DcWXwQpFQI7g=
Received: from BL1PR13CA0205.namprd13.prod.outlook.com (2603:10b6:208:2be::30)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.25; Thu, 15 Aug
 2024 22:45:36 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::ef) by BL1PR13CA0205.outlook.office365.com
 (2603:10b6:208:2be::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10 via Frontend
 Transport; Thu, 15 Aug 2024 22:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 22:45:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 17:45:34 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 Aug 2024 17:45:33 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Charlene Liu <charlene.liu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 02/13] drm/amd/display: Update HPO I/O When Handling Link
 Retrain Automation Request
Date: Thu, 15 Aug 2024 18:45:14 -0400
Message-ID: <20240815224525.3077505-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815224525.3077505-1-Roman.Li@amd.com>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cbc32d-88d0-4920-b19c-08dcbd7bfa43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DeF+2uRAVCaT8pbOMw5/bM0WniVBFXTVct0irsw3JqSumLPpWlV481WS3SRz?=
 =?us-ascii?Q?J79Mu0+V7Gf4AXdXv/238L4nBlG6LXAoeBNOnndE2dxVVMr0SCvs3W9TpHSh?=
 =?us-ascii?Q?3xrRdgF4+C+gxLctUE8fwGHNe0wLoqj3zjPLu7TghjlAxnPzzByjVD6fo+11?=
 =?us-ascii?Q?CVSZyNpcj2q9+4gPICkHp+DSM6H+F4gr3ith6TDsgLBcjJI+QF8A+HcyBzEN?=
 =?us-ascii?Q?X0iIHgjiqFsYvYSHwXJRxrZ6TwCtu99vkB/UJ87ENNl7yZ2bPzIucyi5skG4?=
 =?us-ascii?Q?h2exzQGje985YdxE47v9mlt/VMogx8VMNHAQgkRQpfHO5Al6bQTd5bivhc41?=
 =?us-ascii?Q?uHhMcYwfFRoaZS9FpZ8ZWswQBlrQLDh0tPIp/Y8SV2AxCGHro1Gmp+nC+Nce?=
 =?us-ascii?Q?IiNCPQUy5CSaBI+dYFU/D64eTDgr8br3GChN8zkyqEcG6hbViHSxj1GE1aCh?=
 =?us-ascii?Q?KOmhRzqIkcOXQYn8tg+hzVaCkuInIa95Deg8YgBktk/Z1eHNSDNFQratpfMG?=
 =?us-ascii?Q?eXdUb7JaqKuBpkiUStNGVZtoCAisBHJEGTJCQ8pIkYsePngwStEszlqYvbAk?=
 =?us-ascii?Q?QmBNwTWCZjNp3en+c/PxZRezudFVh6QBW26wsPhyX5kLHJ/4ZdOP4H9WuqyG?=
 =?us-ascii?Q?Om4DU36aQSviaanmwkZ8ETdvGvEEJiQuRZ8ATIDHRDJ0DU6+cBd7uRxFYtRg?=
 =?us-ascii?Q?CboX9cXdwQYG1UI4yTla/0hfRVEZ1uFzIBx395DQ9wYPIENk9ZMeQRqxIWrz?=
 =?us-ascii?Q?ecb3lGoharK879i5rvoIyXJFD2ze0MV/L7VQawPNVJbzaha6F/U4Tr/LOI2I?=
 =?us-ascii?Q?6beAMxMtfd/E87NWXdn7rpoS8bxaqnd9ML2vQ9lbnpMPozVtuGKwub/I08+a?=
 =?us-ascii?Q?CAAb7dI4Bg1JxLZn6a6LnhlO/Qu+ALC0UP+w2prRMXV7C2egYTsolnO1liST?=
 =?us-ascii?Q?Q0BPMOOAWVfHcLI10nThHsssXqyv6LsoQewaog3LV/SnmIR1u9gpTZR9YtNb?=
 =?us-ascii?Q?oeIXKpA/F65KAYAOFFMH7GrfICuexHNuYmpREG34Wam8slKJUAnNY93PB2zQ?=
 =?us-ascii?Q?YGnNBUJw4DBaR2UqtWgrwXQnFtHfUmUOk3x9jfak951XgrvQg9urikXmWfdD?=
 =?us-ascii?Q?LVRxJMm8FYjQ3iYSxf7W0Y53Do2Kpoof2lmvqzgvv5aiJ21PWhgEAOxfw210?=
 =?us-ascii?Q?WXDPA2zHPMmY/fhJV5f2awSOvnJDg7jL3aOfUOSCz1f9e28ztPqLeqdKl0J7?=
 =?us-ascii?Q?TZUKKXc6jYKkO5ZRwePqpJ5SKp4vWPXGddKl/49mqFYYTglkwyYSw6k7CkND?=
 =?us-ascii?Q?Fl7uZ/r4szoZa0WNPjaeBgQAltkd0vgVuqTUVbD6WRXmDR4E9RwyXZwIfcUO?=
 =?us-ascii?Q?drAEOLNwzuukcx8sTR/3o61JXp/DStk6Ny4KNvAZgGLMl+cBlz+J5giP59fV?=
 =?us-ascii?Q?J0h2xwcUALGXUGLUJY+kGPACNmJd01lv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 22:45:35.6510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cbc32d-88d0-4920-b19c-08dcbd7bfa43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Previous multi-display HPO fix moved where HPO I/O enable/disable is performed.
The codepath now taken to enable/disable HPO I/O is not used for compliance
test automation, meaning that if a compliance box being driven at a DP1 rate
requests retrain at UHBR, HPO I/O will remain off if it was previously off.

[HOW]
Explicitly update HPO I/O after allocating encoders for test request.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 13 ++++++++++++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 21 ++++---------------
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  2 ++
 .../display/dc/link/accessories/link_dp_cts.c |  8 +++++++
 8 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b38340c690c6..b6377efc6253 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5303,3 +5303,16 @@ int resource_calculate_det_for_stream(struct dc_state *state, struct pipe_ctx *o
 	}
 	return det_segments;
 }
+
+bool resource_is_hpo_acquired(struct dc_state *context)
+{
+	int i;
+
+	for (i = 0; i < MAX_HPO_DP2_ENCODERS; i++) {
+		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i]) {
+			return true;
+		}
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 217344ccf644..246fa300ee95 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -2350,19 +2350,6 @@ static void dce110_setup_audio_dto(
 	}
 }
 
-static bool dce110_is_hpo_enabled(struct dc_state *context)
-{
-	int i;
-
-	for (i = 0; i < MAX_HPO_DP2_ENCODERS; i++) {
-		if (context->res_ctx.is_hpo_dp_stream_enc_acquired[i]) {
-			return true;
-		}
-	}
-
-	return false;
-}
-
 enum dc_status dce110_apply_ctx_to_hw(
 		struct dc *dc,
 		struct dc_state *context)
@@ -2371,8 +2358,8 @@ enum dc_status dce110_apply_ctx_to_hw(
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 	enum dc_status status;
 	int i;
-	bool was_hpo_enabled = dce110_is_hpo_enabled(dc->current_state);
-	bool is_hpo_enabled = dce110_is_hpo_enabled(context);
+	bool was_hpo_acquired = resource_is_hpo_acquired(dc->current_state);
+	bool is_hpo_acquired = resource_is_hpo_acquired(context);
 
 	/* reset syncd pipes from disabled pipes */
 	if (dc->config.use_pipe_ctx_sync_logic)
@@ -2415,8 +2402,8 @@ enum dc_status dce110_apply_ctx_to_hw(
 
 	dce110_setup_audio_dto(dc, context);
 
-	if (dc->hwseq->funcs.setup_hpo_hw_control && was_hpo_enabled != is_hpo_enabled) {
-		dc->hwseq->funcs.setup_hpo_hw_control(dc->hwseq, is_hpo_enabled);
+	if (dc->hwseq->funcs.setup_hpo_hw_control && was_hpo_acquired != is_hpo_acquired) {
+		dc->hwseq->funcs.setup_hpo_hw_control(dc->hwseq, is_hpo_acquired);
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index b57dd45611f2..56f3c70d4b55 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -111,6 +111,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
+	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
 };
 
 static const struct hwseq_private_funcs dcn31_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index fe5495a8e7a2..68e6de6b5758 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -114,6 +114,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
 	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.calculate_pix_rate_divider = dcn314_calculate_pix_rate_divider,
+	.setup_hpo_hw_control = dcn31_setup_hpo_hw_control,
 };
 
 static const struct hwseq_private_funcs dcn314_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 5da3069fc1ab..d00822e8daa5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -123,6 +123,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.set_long_vtotal = dcn35_set_long_vblank,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
 	.program_outstanding_updates = dcn32_program_outstanding_updates,
+	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
 };
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 326854489802..ac9205625623 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -461,6 +461,7 @@ struct hw_sequencer_funcs {
 	void (*set_long_vtotal)(struct pipe_ctx **pipe_ctx, int num_pipes, uint32_t v_total_min, uint32_t v_total_max);
 	void (*program_outstanding_updates)(struct dc *dc,
 			struct dc_state *context);
+	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
 };
 
 void color_space_to_black_color(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 9cd80d3864c7..cd1157d225ab 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -644,4 +644,6 @@ void resource_init_common_dml2_callbacks(struct dc *dc, struct dml2_configuratio
  *Calculate total DET allocated for all pipes for a given OTG_MASTER pipe
  */
 int resource_calculate_det_for_stream(struct dc_state *state, struct pipe_ctx *otg_master);
+
+bool resource_is_hpo_acquired(struct dc_state *context);
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index df3781081da7..ff8fe1a94965 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -67,6 +67,8 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 {
 	struct pipe_ctx *pipes[MAX_PIPES];
 	struct dc_state *state = link->dc->current_state;
+	bool was_hpo_acquired = resource_is_hpo_acquired(link->dc->current_state);
+	bool is_hpo_acquired;
 	uint8_t count;
 	int i;
 
@@ -83,6 +85,12 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 				pipes[i]);
 	}
 
+	if (link->dc->hwss.setup_hpo_hw_control) {
+		is_hpo_acquired = resource_is_hpo_acquired(state);
+		if (was_hpo_acquired != is_hpo_acquired)
+			link->dc->hwss.setup_hpo_hw_control(link->dc->hwseq, is_hpo_acquired);
+	}
+
 	for (i = count-1; i >= 0; i--)
 		link_set_dpms_on(state, pipes[i]);
 }
-- 
2.34.1

