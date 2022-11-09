Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B875CC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B5F10E579;
	Wed,  9 Nov 2022 06:16:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B6710E579
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD77Clfqhu4hTHh3FfvfvHldRqAR0F4lu6pTSd1hBHu0pE2jTXClwlleFGzmNbJRdy1gfwsDs4yitM5NsdpuNt6GyuEGiDwWg9sGmakY1JIBH5cpb4j/k8FLCMayAEXH2Q1ujE22DMNFbgffUqQ6zQwseOw2LuFUdfR4qyGYYdX/g/INA57fXZXtFD7yWLv/eXyvAAP0lOIjw5rBgkw2RWzuzay1veYUDQaWK+aXzSsRaaSpgf5Xc9kmLyFsZCqrgP4/SJy/p6pB9Q0OJjkmOPmiolFysQwGoWcjvhanH1Twaj+tmePN2oyusoowd87mdZByRKQzMPrc/VlBB8L/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM/8iEuXBS5BahN2jFzmNS7ZiEeqUfSNPzVnZiNBlMI=;
 b=hkCW5yp1KCQudaWUcmDuuniGLancai07xKU2BiHa6X6xXPUAUCLAbeX8XvYBB7b7XAY9GW1f7S27b9uLUEpxdzk1RWTDqHJhy4Vw1CRN/IrXR3PQss0liejPaEyv+GpAtsflCgtrd3mPALA2kutelpZlBKbThbG0cFEAgi+dt+cRrWeC2tzT1EqZB4HJ6krXgDclwAJwyK3tEyk4gfxbtq5Vi3F5jzxLvV8sKSlH1/vFExAbQDMCZZAwcvoytR7r9KKZIOeVeMswaSV75CD2qasCL57PAvj/9+CwUuheaGbU/xmsxm4aOA9xMJUmrSnSnBp27YgPbiZ4bSfrWb8bDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM/8iEuXBS5BahN2jFzmNS7ZiEeqUfSNPzVnZiNBlMI=;
 b=2tOQ8KqBib3v4AdvL9XZEiJ3aop0K++WvILgAy4gOqCJ6qnWurteBE3gpdDskDCQC6MbJ0LpOZs78u26BrrOKM2gurlMAu3pTKAF/ZHcunMeEVuovIsnqISzMGXQ++FfrqsJ1y5RAdygI1dOmdlMNPNaatyiLx7L7Gzy5p5B5xo=
Received: from BN0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:408:ee::21)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:16:01 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::13) by BN0PR04CA0016.outlook.office365.com
 (2603:10b6:408:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:16:00 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:16:00 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:15:59 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:15:54 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/29] drm/amd/display: fix dcn3.1x mode validation on high
 bandwidth config
Date: Wed, 9 Nov 2022 14:13:03 +0800
Message-ID: <20221109061319.2870943-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: d9078edb-4fd8-414c-96fa-08dac219df64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3nBZ9qCTu485tyYYE5byvEOc70mVnrN4D1uv8NIA7GIC2dPsnq3N6fKLE9Bqk3dIpdMVqeRo5SDOGRmP4i62Xd59r8H4NPsccLBrw0xjPr1fXFpPqd2i0HkjVZI34NgHsxCfaDKi7H4SXhb9czj5VwsUs6RhPJGzw7plQgU46/oH42IyG3QZ2lHbJDGqiY5IVPt9PYYxTdcBNAnUecy3nVF96RMblwD/S3r4WnSGPNzwv1JiVjTRnX7mXLYhHrK4vp++jpFQ7BWYOhsNBNNkxI6SGJ7QE+tyYgqvzgV37cLkpFk4LrnqvLjVFm16GNkvXSiAjpmlmEWgYLymfaJaBCaD9ySmPPR57/korWlHlxciECPwXIgEJvel77xUPOxQG7Y1AUEd1n1DXrQcVU7rOXdyH9syvKum3Q8Y5JDSrIeX2T2I4HsghiAuJau2UggECreu1XkqSWhogiGDbuCZKAJk0nkMQpNxW3JYNKq2yUvWkly3swNqN/2/tyNKUrfkjLS6zE0dxEVrwF8GKRcxKfzY6q5RfawViAD37eNScjXTBua/r+XOqx3pkMvcIWzJ2zPiEV8O1W4FFFsL8K62u80cwjhgr1HMTON66Ter4W9hXn4ZDF+7nXN1QHw33kwuxoFS53dD1ptDsSht3liAPlPmSBMHEb1fHKVdRoyCLuYMxAPnoW65977JWgSJBi8i57MRFewWZT/cHHjDGVz9fd81i4L19snfqxFuPTzTRPBfcYDJPA7C//Exuhy5h/Yxe/JlTClM6fKSfnM05baNWMDIQ/udiMs0OyUuFu/UFly8GdVJ+B60dGUk2gQNbPjkaiItybWLbhq5JdXDZV/Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(30864003)(26005)(82740400003)(81166007)(478600001)(336012)(82310400005)(6666004)(54906003)(6916009)(19627235002)(356005)(316002)(36860700001)(7696005)(70586007)(8676002)(70206006)(4326008)(2616005)(5660300002)(1076003)(86362001)(186003)(83380400001)(426003)(2906002)(40480700001)(41300700001)(8936002)(47076005)(40460700003)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:16:00.3760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9078edb-4fd8-414c-96fa-08dac219df64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Tom
 Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
1. correct dram_channel_width (was hard coded to 4 for 32bit)
2. use dm's is_hvm_enable status flag for hostvm_en input for dml.
3. add a function to override to all dcn3.1x.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  4 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c | 33 +++++++++---
 .../amd/display/dc/dcn315/dcn315_resource.c   |  3 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |  3 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |  4 ++
 .../dc/dml/dcn31/display_mode_vba_31.c        | 54 ++++++++++++++++++-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |  5 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  2 -
 9 files changed, 90 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index c1eaf571407a..1c0569b1dc8f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -609,8 +609,10 @@ static void dcn31_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 	}
 
 	bw_params->vram_type = bios_info->memory_type;
-	bw_params->num_channels = bios_info->ma_channel_number;
 
+	bw_params->dram_channel_width_bytes = bios_info->memory_type == 0x22 ? 8 : 4;
+	//bw_params->dram_channel_width_bytes = dc->ctx->asic_id.vram_width;
+	bw_params->num_channels = bios_info->ma_channel_number ? bios_info->ma_channel_number : 4;
 	for (i = 0; i < WM_SET_COUNT; i++) {
 		bw_params->wm_table.entries[i].wm_inst = i;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 187f5b27fdc8..3edc81e2d417 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -553,6 +553,7 @@ static void dcn316_clk_mgr_helper_populate_bw_params(
 
 	bw_params->vram_type = bios_info->memory_type;
 	bw_params->num_channels = bios_info->ma_channel_number;
+	bw_params->dram_channel_width_bytes = bios_info->memory_type == 0x22 ? 8 : 4;
 
 	for (i = 0; i < WM_SET_COUNT; i++) {
 		bw_params->wm_table.entries[i].wm_inst = i;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 8f5e89cb9d3e..cc004acb2f47 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1638,6 +1638,31 @@ static bool is_dual_plane(enum surface_pixel_format format)
 	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
 }
 
+int dcn31x_populate_dml_pipes_from_context(struct dc *dc,
+					  struct dc_state *context,
+					  display_e2e_pipe_params_st *pipes,
+					  bool fast_validate)
+{
+	uint32_t pipe_cnt;
+	int i;
+
+	dc_assert_fp_enabled();
+
+	pipe_cnt = dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
+
+	for (i = 0; i < pipe_cnt; i++) {
+		pipes[i].pipe.src.gpuvm = 1;
+		if (dc->debug.dml_hostvm_override == DML_HOSTVM_NO_OVERRIDE) {
+			//pipes[pipe_cnt].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
+			pipes[i].pipe.src.hostvm = dc->vm_pa_config.is_hvm_enabled;
+		} else if (dc->debug.dml_hostvm_override == DML_HOSTVM_OVERRIDE_FALSE)
+			pipes[i].pipe.src.hostvm = false;
+		else if (dc->debug.dml_hostvm_override == DML_HOSTVM_OVERRIDE_TRUE)
+			pipes[i].pipe.src.hostvm = true;
+	}
+	return pipe_cnt;
+}
+
 int dcn31_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes,
@@ -1649,7 +1674,7 @@ int dcn31_populate_dml_pipes_from_context(
 	bool upscaled = false;
 
 	DC_FP_START();
-	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
+	dcn31x_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 	DC_FP_END();
 
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1679,12 +1704,6 @@ int dcn31_populate_dml_pipes_from_context(
 		dcn31_zero_pipe_dcc_fraction(pipes, pipe_cnt);
 		DC_FP_END();
 
-		if (dc->debug.dml_hostvm_override == DML_HOSTVM_NO_OVERRIDE)
-			pipes[pipe_cnt].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
-		else if (dc->debug.dml_hostvm_override == DML_HOSTVM_OVERRIDE_FALSE)
-			pipes[pipe_cnt].pipe.src.hostvm = false;
-		else if (dc->debug.dml_hostvm_override == DML_HOSTVM_OVERRIDE_TRUE)
-			pipes[pipe_cnt].pipe.src.hostvm = true;
 
 		if (pipes[pipe_cnt].dout.dsc_enable) {
 			switch (timing->display_color_depth) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 96a3d41febff..2a5227330513 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1647,7 +1647,7 @@ static int dcn315_populate_dml_pipes_from_context(
 	const int max_usable_det = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - DCN3_15_MIN_COMPBUF_SIZE_KB;
 
 	DC_FP_START();
-	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
+	dcn31x_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 	DC_FP_END();
 
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1666,7 +1666,6 @@ static int dcn315_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].pipe.src.immediate_flip = true;
 
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
-		pipes[pipe_cnt].pipe.src.gpuvm = true;
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
 		pipes[pipe_cnt].pipe.src.dcc_rate = 3;
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 2f643cdaf59f..9a82f8f66f28 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1650,7 +1650,7 @@ static int dcn316_populate_dml_pipes_from_context(
 	const int max_usable_det = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - DCN3_16_MIN_COMPBUF_SIZE_KB;
 
 	DC_FP_START();
-	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
+	dcn31x_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 	DC_FP_END();
 
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1669,7 +1669,6 @@ static int dcn316_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].pipe.src.immediate_flip = true;
 
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
-		pipes[pipe_cnt].pipe.src.gpuvm = true;
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
 		pipes[pipe_cnt].pipe.src.dcc_rate = 3;
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index fd58b2561ec9..b0b2ba9df57a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -47,4 +47,8 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 
+int dcn31x_populate_dml_pipes_from_context(struct dc *dc,
+					  struct dc_state *context,
+					  display_e2e_pipe_params_st *pipes,
+					  bool fast_validate);
 #endif /* __DCN31_FPU_H__*/
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 45ab0ce50860..4e45c6d9ecdc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -1056,14 +1056,12 @@ static bool CalculatePrefetchSchedule(
 	prefetch_bw_pr = dml_min(1, myPipe->VRatio) * prefetch_bw_pr;
 	max_Tsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime;
 	prefetch_sw_bytes = PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY + PrefetchSourceLinesC * swath_width_chroma_ub * myPipe->BytePerPixelC;
-	prefetch_bw_oto = dml_max(bytes_pp * myPipe->PixelClock / myPipe->DPPPerPlane, prefetch_sw_bytes / (dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime));
 	prefetch_bw_oto = dml_max(prefetch_bw_pr, prefetch_sw_bytes / max_Tsw);
 
 	min_Lsw = dml_max(1, dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) / max_vratio_pre);
 	Lsw_oto = dml_ceil(4 * dml_max(prefetch_sw_bytes / prefetch_bw_oto / LineTime, min_Lsw), 1) / 4;
 	Tsw_oto = Lsw_oto * LineTime;
 
-	prefetch_bw_oto = (PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY + PrefetchSourceLinesC * swath_width_chroma_ub * myPipe->BytePerPixelC) / Tsw_oto;
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML: HTotal: %d\n", myPipe->HTotal);
@@ -5362,6 +5360,58 @@ void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				v->ModeSupport[i][j] = true;
 			} else {
 				v->ModeSupport[i][j] = false;
+#ifdef __DML_VBA_DEBUG__
+				if (v->ScaleRatioAndTapsSupport == false)
+					dml_print("DML SUPPORT:     ScaleRatioAndTapsSupport failed");
+				if (v->SourceFormatPixelAndScanSupport == false)
+					dml_print("DML SUPPORT:     SourceFormatPixelAndScanSupport failed");
+				if (v->ViewportSizeSupport[i][j] == false)
+					dml_print("DML SUPPORT:     ViewportSizeSupport failed");
+				if (v->LinkCapacitySupport[i] == false)
+					dml_print("DML SUPPORT:     LinkCapacitySupport failed");
+				if (v->ODMCombine4To1SupportCheckOK[i] == false)
+					dml_print("DML SUPPORT:     DSC422NativeNotSupported failed");
+				if (v->NotEnoughDSCUnits[i] == true)
+					dml_print("DML SUPPORT:     NotEnoughDSCUnits");
+				if (v->DTBCLKRequiredMoreThanSupported[i] == true)
+					dml_print("DML SUPPORT:     DTBCLKRequiredMoreThanSupported");
+				if (v->ROBSupport[i][j] == false)
+					dml_print("DML SUPPORT:     ROBSupport failed");
+				if (v->DISPCLK_DPPCLK_Support[i][j] == false)
+					dml_print("DML SUPPORT:     DISPCLK_DPPCLK_Support failed");
+				if (v->TotalAvailablePipesSupport[i][j] == false)
+					dml_print("DML SUPPORT:     DSC422NativeNotSupported failed");
+				if (EnoughWritebackUnits == false)
+					dml_print("DML SUPPORT:     DSC422NativeNotSupported failed");
+				if (v->WritebackLatencySupport == false)
+					dml_print("DML SUPPORT:     WritebackLatencySupport failed");
+				if (v->WritebackScaleRatioAndTapsSupport == false)
+					dml_print("DML SUPPORT:     DSC422NativeNotSupported ");
+				if (v->CursorSupport == false)
+					dml_print("DML SUPPORT:     DSC422NativeNotSupported failed");
+				if (v->PitchSupport == false)
+					dml_print("DML SUPPORT:     PitchSupport failed");
+				if (ViewportExceedsSurface == true)
+					dml_print("DML SUPPORT:     ViewportExceedsSurface failed");
+				if (v->PrefetchSupported[i][j] == false)
+					dml_print("DML SUPPORT:     PrefetchSupported failed");
+				if (v->DynamicMetadataSupported[i][j] == false)
+					dml_print("DML SUPPORT:     DSC422NativeNotSupported failed");
+				if (v->TotalVerticalActiveBandwidthSupport[i][j] == false)
+					dml_print("DML SUPPORT:     TotalVerticalActiveBandwidthSupport failed");
+				if (v->VRatioInPrefetchSupported[i][j] == false)
+					dml_print("DML SUPPORT:     VRatioInPrefetchSupported failed");
+				if (v->PTEBufferSizeNotExceeded[i][j] == false)
+					dml_print("DML SUPPORT:     PTEBufferSizeNotExceeded failed");
+				if (v->NonsupportedDSCInputBPC == true)
+					dml_print("DML SUPPORT:     NonsupportedDSCInputBPC failed");
+				if (!((v->HostVMEnable == false
+					&& v->ImmediateFlipRequirement[0] != dm_immediate_flip_required)
+							|| v->ImmediateFlipSupportedForState[i][j] == true))
+					dml_print("DML SUPPORT:     ImmediateFlipRequirement failed");
+				if (FMTBufferExceeded == true)
+					dml_print("DML SUPPORT:     FMTBufferExceeded failed");
+#endif
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 796c9d19e671..1dd51c4b6804 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -29,6 +29,7 @@
 #include "dcn31/dcn31_hubbub.h"
 #include "dcn314_fpu.h"
 #include "dml/dcn20/dcn20_fpu.h"
+#include "dml/dcn31/dcn31_fpu.h"
 #include "dml/display_mode_vba.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
@@ -288,7 +289,7 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 
 	dc_assert_fp_enabled();
 
-	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
+	dcn31x_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 		struct dc_crtc_timing *timing;
@@ -315,8 +316,6 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipes[pipe_cnt].pipe.src.immediate_flip = true;
 
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
-		pipes[pipe_cnt].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
-		pipes[pipe_cnt].pipe.src.gpuvm = true;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 53e3e7364ec6..41f0b4c1c72f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -1078,14 +1078,12 @@ static bool CalculatePrefetchSchedule(
 	prefetch_bw_pr = dml_min(1, myPipe->VRatio) * prefetch_bw_pr;
 	max_Tsw = dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime;
 	prefetch_sw_bytes = PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY + PrefetchSourceLinesC * swath_width_chroma_ub * myPipe->BytePerPixelC;
-	prefetch_bw_oto = dml_max(bytes_pp * myPipe->PixelClock / myPipe->DPPPerPlane, prefetch_sw_bytes / (dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) * LineTime));
 	prefetch_bw_oto = dml_max(prefetch_bw_pr, prefetch_sw_bytes / max_Tsw);
 
 	min_Lsw = dml_max(1, dml_max(PrefetchSourceLinesY, PrefetchSourceLinesC) / max_vratio_pre);
 	Lsw_oto = dml_ceil(4 * dml_max(prefetch_sw_bytes / prefetch_bw_oto / LineTime, min_Lsw), 1) / 4;
 	Tsw_oto = Lsw_oto * LineTime;
 
-	prefetch_bw_oto = (PrefetchSourceLinesY * swath_width_luma_ub * myPipe->BytePerPixelY + PrefetchSourceLinesC * swath_width_chroma_ub * myPipe->BytePerPixelC) / Tsw_oto;
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML: HTotal: %d\n", myPipe->HTotal);
-- 
2.25.1

