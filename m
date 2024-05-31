Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5ADC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A23A810E57F;
	Fri, 31 May 2024 16:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e3YOBJiw";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 907F910E5A6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2xCS8VAbf2Wfi3/w2QJCUqe+GopUo0QrAmNYUDAouQV/KO3ZCUeXFGuNYAynTb7dM7W7AyQYUlIaCcYg6+W8qnm0TdXUuK7N+gvqAqqtylzRJjmVdm8yKnvxtl/FEbgHSTAgYJ655a/+A7hNaGZFMgDXg+1fZv8n87uDdbojWD0HEzRZIm83s/Dn8dt6DCGIW8XKe4ox0Y2DxJc1DeKxt7bZp5pfBeNk4SEWW8wUyvq01IK6ACk6mxm3CIRC5Sm/DlDqLWJC9bxghumVsPjaCs25SG8lApWm/FRw59D9Z9uZl4FYD0vuoIRxt7RfcAN0PqrYwrt1oVUf58zfaZJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhgZPVI4gCUkpOpjep9n18fi9Ipg7yneuFcgwA85UpA=;
 b=Nl//4PYh/gU2R0i7frZKqCws8VgbhI0cayC9cA9WUAwvrLM+oL3aAErEjedC60BZfEBvSvPKymmenJ3r3WlQbr4OcL1S51ukdm2akbvRrxFL3YB2xNG6VGEtQ6rr5HSjh+KC5jtGMyISuVaHXM+1ylqOs+pvVgoDkKUhrY5qexZDxTlALGwELFHCL1B48926lcZqijFi9eMQIImpzaPOd3eB4S2MsSM9B3iy3DQhHkrOpgwkSlaLiJVSS0PRxNUKbrKmj4jdzO+cqEa3abTcnY87ACzHh/5O6N2nLJEcuDQ/+ViALxn1ij3qFFpcE1PSXAVLg3pZPLD5mPhi9l1tJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhgZPVI4gCUkpOpjep9n18fi9Ipg7yneuFcgwA85UpA=;
 b=e3YOBJiw6de7NiaH74DapkY+ElAEHW45CZmjT1/wkRhnnSMDXLB1iWXp75NlSs9jnj6xETjjiwGKbH00JH+rh26jZ19vTeWyKkNK6Ra8JYX7ghy9plWZOb9MuZxWwon4skcZM21Kwt95iO9bRv0qwjMnY4IIn0c75g3q5EutbgA=
Received: from PH7PR10CA0002.namprd10.prod.outlook.com (2603:10b6:510:23d::28)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 16:52:37 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::43) by PH7PR10CA0002.outlook.office365.com
 (2603:10b6:510:23d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 16:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:36 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:31 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Samson Tam
 <samson.tam@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 11/32] drm/amd/display: Move fpo_in_use to stream_status
Date: Fri, 31 May 2024 12:51:24 -0400
Message-ID: <20240531165145.1874966-12-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7ea911-4c52-4a35-bc3a-08dc81921338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VdfWwYTshvzBxZK4NbTQYVdB9VZRXZZs0nvgk8UbduxrNI7lKxAA6sFdXMAd?=
 =?us-ascii?Q?yKnyCWt5jvJwamJNSaPGi541kvRrFEZuXTgic2VkTsBkREj5axtasyj8gbtm?=
 =?us-ascii?Q?DPknI+vtkBAvI/GXD380zO5Z42fCMYV+7WGbWt8lefzSk9skLyQj6wwl6Yvw?=
 =?us-ascii?Q?VZhs7Ku/LUinylI8RhRoMx/uXeUtbGUEL1DKsPHfwpX5iJqOwTHWHjCApIRs?=
 =?us-ascii?Q?SapIV4CcSKIHPwhQHNS/irDabY7Ng9CaOSkuSZ570kqrNPBXt6uf6doQ6vTY?=
 =?us-ascii?Q?YhmNs+nlL/Plk3T2Pflp/mZP9o9f60FoiLm0hsOPmqXfma+ZS8996K9sakKJ?=
 =?us-ascii?Q?EOZBFs9T2i19ym2IsnlBvGMlz+5E6X988QwMiYJ+WsDTubCnzEds3KyJ8BzG?=
 =?us-ascii?Q?sK4NKNuZHJOjvUOrJDjj7+GT3cjx8XDEb/2xSlDqLbfV2JdLMciuWVvQwyTU?=
 =?us-ascii?Q?3sMq9g3tsz+xxItoMwno1EE7DieXEaiFWBFExZtG8xBW5FjphUftzwZ7W0p6?=
 =?us-ascii?Q?9AfpgCrLRu7argrzHkz7j8WMAiG6oIW9TEgE1b3d6woxLhA0VA9Z60mngZpc?=
 =?us-ascii?Q?9QYaOZR6j15xJmgMZkAXlX2zaw1ijHLqJcbTmHjmygTegnbOhIBtJ7oulQsh?=
 =?us-ascii?Q?7/PjRNZn27QNRTKzR9WJmlj1MOaz3HjqwshtXOWwnK3WB0ryXCqxICJfU3uX?=
 =?us-ascii?Q?wr3YiBEykmS0I7kUUL2vZ7R+9AQnPfqeyVh2i77Eb6ngUPa5A6fZhzUZQG0f?=
 =?us-ascii?Q?xVpjUZCVTqgwmU145odMPYcABy8dw1uVaHPIl43K0HhazYMXz15kraZ+Ayj9?=
 =?us-ascii?Q?9yR5ObbMq40E9GuHSx2mVOd0Ppw0pGejhHy9iHJMq0EyzevI/vTwPOSVcgBb?=
 =?us-ascii?Q?xWwoAMt8qa08QDKi98rVDg2U6V7NZW3uq9gkRr0g2G0CwcchanX84izGSmE8?=
 =?us-ascii?Q?FoczcdE1CwM2lBHhmg0vAajKYeOWccH6lvKqj6W73jXS7ldFznvHf9NrOYZG?=
 =?us-ascii?Q?wov5OBsNb95nLus5giAtneetQxyuupvIgbFWv7h/+XL93eDDwnf4RMwnpwjv?=
 =?us-ascii?Q?35GRGj0b8ejeW2OUFe7mamXATqg0RxuhLBgotsw4ZFYybVsYasv1i2WbLkUP?=
 =?us-ascii?Q?+VRUQg60LlT/mVZPkm4xQIzhNm0UAc9QK4JTYj5eBNyv7zPCIxpBEvFRPg4S?=
 =?us-ascii?Q?MGdYJgH4+jsfuhlrI+gWYZ+WnoxaNyHN93+I9fwQXDFflb7mY622lyoyt0Bq?=
 =?us-ascii?Q?ZsSbq9VuOc0wXoBPg5/vle72o8Hp1iCI5sI7P0BxxmZjddgTz5KhrboXw6CB?=
 =?us-ascii?Q?YHuptZcsLB7PGu2KIqvMctzfRdj3rqKnDnEVOj/nqW8Cw1POjtVqn7516Aq5?=
 =?us-ascii?Q?Qng/KiG2/4YgbRNXp/MQlDWNTs0Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:36.6367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7ea911-4c52-4a35-bc3a-08dc81921338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Refactor code and move fpo_in_use into stream_status to avoid
unexpected changes to previous dc_state (i.e., current_state).
Since stream pointers are shared between current and new dc_states,
updating parameters of one stream will update the other as well
which causes unexpected behaviors (i.e., checking that fpo_in_use
isn't set in previous state and set in the new state is invalid).
To avoid incorrect updates to current_state, move the fpo_in_use flag
into dc_stream_status since stream_status is owned by dc and are not
shared between different dc_states.

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 12 +++++++++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  6 +++++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 15 +++++++++++---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 20 ++++++++++++++-----
 .../dc/resource/dcn30/dcn30_resource.c        |  8 +++++++-
 6 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 364ef9ae32f1..0e70b95573ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -427,6 +427,7 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
 	uint8_t visual_confirm_enabled;
 	int pipe_idx = 0;
+	struct dc_stream_status *stream_status = NULL;
 
 	if (dc == NULL)
 		return false;
@@ -443,6 +444,7 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
+			stream_status = NULL;
 			if (!pipe->stream)
 				continue;
 
@@ -450,7 +452,8 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 			 * that does not use FAMS, we are in an FPO + VActive scenario.
 			 * Assign vactive stretch margin in this case.
 			 */
-			if (!pipe->stream->fpo_in_use) {
+			stream_status = dc_state_get_stream_status(context, pipe->stream);
+			if (stream_status && !stream_status->fpo_in_use) {
 				cmd.fw_assisted_mclk_switch.config_data.vactive_stretch_margin_us = dc->debug.fpo_vactive_margin_us;
 				break;
 			}
@@ -461,7 +464,12 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	for (i = 0, k = 0; context && i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		if (resource_is_pipe_type(pipe, OTG_MASTER) && pipe->stream->fpo_in_use) {
+		stream_status = NULL;
+		if (!resource_is_pipe_type(pipe, OTG_MASTER))
+			continue;
+
+		stream_status = dc_state_get_stream_status(context, pipe->stream);
+		if (stream_status && stream_status->fpo_in_use) {
 			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 			uint8_t min_refresh_in_hz = (pipe->stream->timing.min_refresh_in_uhz + 999999) / 1000000;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 1469a20f2511..8ebd7e9e776e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -59,6 +59,7 @@ struct dc_stream_status {
 	struct dc_plane_state *plane_states[MAX_SURFACE_NUM];
 	bool is_abm_supported;
 	struct mall_stream_config mall_stream_config;
+	bool fpo_in_use;
 };
 
 enum hubp_dmdata_mode {
@@ -296,7 +297,6 @@ struct dc_stream_state {
 
 	bool has_non_synchronizable_pclk;
 	bool vblank_synchronized;
-	bool fpo_in_use;
 	bool is_phantom;
 
 	struct luminance_data lumin_data;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 81f7b90849ce..cf908958a06b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -387,13 +387,17 @@ void dcn30_fpu_calculate_wm_and_dlg(
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][maxMpcComb];
 	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] != dm_dram_clock_change_unsupported;
 	unsigned int dummy_latency_index = 0;
+	struct dc_stream_status *stream_status = NULL;
 
 	dc_assert_fp_enabled();
 
 	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
     for (i = 0; i < context->stream_count; i++) {
+	    	stream_status = NULL;
 		if (context->streams[i])
-			context->streams[i]->fpo_in_use = false;
+			stream_status = dc_state_get_stream_status(context, context->streams[i]);
+		if (stream_status)
+			stream_status->fpo_in_use = false;
 	}
 
 	if (!pstate_en) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 7aba7112c8f8..194422dd979d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2309,6 +2309,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	bool need_fclk_lat_as_dummy = false;
 	bool is_subvp_p_drr = false;
 	struct dc_stream_state *fpo_candidate_stream = NULL;
+	struct dc_stream_status *stream_status = NULL;
 
 	dc_assert_fp_enabled();
 
@@ -2343,8 +2344,11 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 
 	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
 	for (i = 0; i < context->stream_count; i++) {
+		stream_status = NULL;
 		if (context->streams[i])
-			context->streams[i]->fpo_in_use = false;
+			stream_status = dc_state_get_stream_status(context, context->streams[i]);
+		if (stream_status)
+			stream_status->fpo_in_use = false;
 	}
 
 	if (!pstate_en || (!dc->debug.disable_fpo_optimizations &&
@@ -2352,7 +2356,9 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 		/* only when the mclk switch can not be natural, is the fw based vblank stretch attempted */
 		fpo_candidate_stream = dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch(dc, context);
 		if (fpo_candidate_stream) {
-			fpo_candidate_stream->fpo_in_use = true;
+			stream_status = dc_state_get_stream_status(context, fpo_candidate_stream);
+			if (stream_status)
+				stream_status->fpo_in_use = true;
 			context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = true;
 		}
 
@@ -2389,8 +2395,11 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				 */
 				context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
 				for (i = 0; i < context->stream_count; i++) {
+					stream_status = NULL;
 					if (context->streams[i])
-						context->streams[i]->fpo_in_use = false;
+						stream_status = dc_state_get_stream_status(context, context->streams[i]);
+					if (stream_status)
+						stream_status->fpo_in_use = false;
 				}
 				context->bw_ctx.dml.soc.fclk_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.fclk_change_latency_us;
 				dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 2626ef8f3292..25c9a407779b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -601,9 +601,13 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 		struct hubp *hubp = pipe->plane_res.hubp;
+		struct dc_stream_status *stream_status = NULL;
+
+		if (pipe->stream)
+			stream_status = dc_state_get_stream_status(context, pipe->stream);
 
 		if (!pipe->stream || !(dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN ||
-		    pipe->stream->fpo_in_use)) {
+		    (stream_status && stream_status->fpo_in_use))) {
 			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
 				hubp->funcs->hubp_update_force_pstate_disallow(hubp, false);
 			if (hubp && hubp->funcs->hubp_update_force_cursor_pstate_disallow)
@@ -617,6 +621,8 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 		struct hubp *hubp = pipe->plane_res.hubp;
+		struct dc_stream_status *stream_status = NULL;
+		struct dc_stream_status *old_stream_status = NULL;
 
 		/* Today for MED update type we do not call update clocks. However, for FPO
 		 * the assumption is that update clocks should be called to disable P-State
@@ -630,11 +636,15 @@ void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
 		 * time SubVP / FPO was enabled, so there's no need to update / reset it if the
 		 * pipe config has never exited SubVP / FPO.
 		 */
+		if (pipe->stream)
+			stream_status = dc_state_get_stream_status(context, pipe->stream);
+		if (old_pipe->stream)
+			old_stream_status = dc_state_get_stream_status(dc->current_state, old_pipe->stream);
+
 		if (pipe->stream && (dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_MAIN ||
-				pipe->stream->fpo_in_use) &&
-				(!old_pipe->stream ||
-				(dc_state_get_pipe_subvp_type(context, old_pipe) != SUBVP_MAIN &&
-				!old_pipe->stream->fpo_in_use))) {
+				(stream_status && stream_status->fpo_in_use)) &&
+				(!old_pipe->stream || (dc_state_get_pipe_subvp_type(context, old_pipe) != SUBVP_MAIN &&
+				(old_stream_status && !old_stream_status->fpo_in_use)))) {
 			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
 				hubp->funcs->hubp_update_force_pstate_disallow(hubp, true);
 			if (hubp && hubp->funcs->hubp_update_force_cursor_pstate_disallow)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 1ce727351c39..0cb2cc56d973 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -1966,6 +1966,7 @@ bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc,
 {
 	int refresh_rate = 0;
 	const int minimum_refreshrate_supported = 120;
+	struct dc_stream_status *stream_status = NULL;
 
 	if (context == NULL || context->streams[0] == NULL)
 		return false;
@@ -1999,7 +2000,12 @@ bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc,
 	if (context->streams[0]->vrr_active_variable && (dc->debug.disable_fams_gaming == INGAME_FAMS_DISABLE))
 		return false;
 
-	context->streams[0]->fpo_in_use = true;
+	stream_status = dc_state_get_stream_status(context, context->streams[0]);
+
+	if (!stream_status)
+		return false;
+
+	stream_status->fpo_in_use = true;
 
 	return true;
 }
-- 
2.34.1

