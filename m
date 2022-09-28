Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D0CC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F9BC10E9AC;
	Wed, 28 Sep 2022 19:40:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1958410E4D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAqgiNlZ4WzfRJzIOxvKSq4syUpTd96ljF4SWETmBtEj5H436e/a89oupLtKkQGm+SL9kug4umb9xnlZKVQz9JywL84vOHAQMmdG5/9+CKmg3z9Ry2Q3RA3BA0ajZdml2zowq2IoWFOuOej3Jj4EnrF8ra2Pz18aTOTvQKz5FDyF8SZxyKjOavjOixLMSNkvqm+JRu7ZPUfBlpehjBh2K3IfQhjcxo77ygEa6/Z/5rHoTZzVJf8WFxsHb3oG5o7AteMnLu5R/H0BHNMZ5Kvbkb2hLdpwDjcfk7nkO7quH6roYdA/kovAI4bCX2nDVrNWuFmkQhOGrSowo2p6UID+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/mxidcADwQsUYOrEM/l2sZgnfWXNO7c53JS+peC1LE=;
 b=CshytZisWxhrmDd/uWU95oHKlNaX77qcgfKl9Fe0zBPKCN4AJH0EVv4dIJ4woFxIpSM2QA+4GRwuXnKGrL0PBsaOaHD7eV48oW7JPOaj5rZYO71o10XTfTsAe0sK0GpyakscYcii5r7+cWqfgZYihDYCPfMZ8NHrZMgTswReuPGYSZuAqVhOENEhiBtv8BKtl93j3SqtovjEqbn5Mz35GUD5MpD/Q3Es2c3Q+ayZJY7H0dDiQbvvGsMz/Qoe9auYlJ/n0ZZaZxrkT9MDFoev7HJ4lTGfnHU4f0MVgrIA8vp8aKBv4gUW+ULnxNGaqUijJXW3z8NSy4tsIgMB4dUnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/mxidcADwQsUYOrEM/l2sZgnfWXNO7c53JS+peC1LE=;
 b=O+tpwkZcY8pZ0Y3EvMffFcmkI6jqRb7j3k58ize7Qv/0WQbyHUxUTmlWzGyF2Ye0QUligGb29REJ0xgQxNvJQvia1y25vCcJbKN4tmSr/mqLndwuTfUTvtHZ7jEAIZ9pDmrdEODIpY4f9ZxfHYLVDPaoABqxOI7XzzhOBaU/zzA=
Received: from BN8PR15CA0064.namprd15.prod.outlook.com (2603:10b6:408:80::41)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 19:40:49 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::96) by BN8PR15CA0064.outlook.office365.com
 (2603:10b6:408:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 19:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 19:40:48 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 14:40:46 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/36] drm/amd/display: add dummy pstate workaround to dcn315
Date: Wed, 28 Sep 2022 15:39:55 -0400
Message-ID: <20220928194028.144879-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220928194028.144879-1-hamza.mahfooz@amd.com>
References: <20220928194028.144879-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a7f281-5c74-4030-8e72-08daa1895821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kAoAvt1sebUU39dx6R+fKbYp+L/45ml3m9UZFP9LmJ5flHLf+0vDyXeAWmTZ2YV8NApAT+fMUX9Zg6g8IBtvscS7mkJGMKtP/lsPd3/Srf2z9EGCe+ehwoarin+0EFHj0rgSr98tIYMGy48vfRXN/7a2jZp7ztX/sdJg7DiLmbaYT5vSk0CbtvXTwmOf5ChaR4YAGAvYectHXb/lNdc9IO6JiN0/UlxKc43XxbHddgketIeISZuSmEExGqhQ/+/L107lyzRw+K3g1jm8gNvBDYSNfg0Oza1uqrN7F3yXs9EydYWi8goncI2wBQ1Cn4UWAQzuuYpThNT2SL+c9sKlD9RKLSqyiMOkph+dqSHr9Qu+lHe7HS7wD2a+FC0U3SOhTwm13OYIwQYRI34rPwKT7j5MI+Q1eVjH2ISXuhUTYV0CYOBPhCMCqQ+oxuZFaGv0V//QQvtM6TDpfbI0GSNAiU0Ine8nIfdjPJsC1GAfnmPDrOCklEGkG5qLUKTRxS0xUl8VWTqKuB6dWbOzLsdDCtpO+6XdanEZekUQ2Sfs6MTl3IErIYbRhuHN7G+RXFizlwWFpdfoG8DdPCGJ1pv4ZC9L3sPU41xSOk9T/6jCUMS1jvmJxHPQH5UlUdb5gdbQ+kIjGUVc7rQ/iQKEXqN/yDpchiPJwqi5nfkKHRxiO/5OkEzkEiIt2TaPYYCN2wQik5boNugmVwzkCqQO728gPNBoM8EaqYg5k/fex80wREbYx1fcSwVr28czhKw9XYrGHc2IO5QcqIk0L4hgoFgWOp89258fi7pOzao030YgNOgGeZpyziVi7vEU9mM5rKc89JXBJJ8IPhgZQaBQQyTqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(36756003)(478600001)(316002)(86362001)(40480700001)(7696005)(426003)(47076005)(83380400001)(8676002)(4326008)(6916009)(40460700003)(54906003)(70206006)(70586007)(82740400003)(41300700001)(36860700001)(82310400005)(81166007)(356005)(44832011)(8936002)(5660300002)(6666004)(2616005)(1076003)(30864003)(16526019)(186003)(2906002)(26005)(336012)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:40:48.6907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a7f281-5c74-4030-8e72-08daa1895821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Hamza
 Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

DCN315 has to always allow pstate change or SMU will hang. This
workaround achieves this by applying a low pstate change latency
to be used when pstate is calculated to be unsupported. This lower
latency only accounts for memory retraining; a previous change
handles locking in the highest available pstate allowing us to minimize
required latency hiding to only account for memory retraining.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  4 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |  2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 89 +++++--------------
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |  1 +
 4 files changed, 27 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 3a3b2ac791c7..020f512e9690 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1655,6 +1655,9 @@ noinline bool dcn30_internal_validate_bw(
 	if (!pipes)
 		return false;
 
+	context->bw_ctx.dml.vba.maxMpcComb = 0;
+	context->bw_ctx.dml.vba.VoltageLevel = 0;
+	context->bw_ctx.dml.vba.DRAMClockChangeSupport[0][0] = dm_dram_clock_change_vactive;
 	dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
 	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
 
@@ -1873,6 +1876,7 @@ noinline bool dcn30_internal_validate_bw(
 
 	if (repopulate_pipes)
 		pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
+	context->bw_ctx.dml.vba.VoltageLevel = vlevel;
 	*vlevel_out = vlevel;
 	*pipe_cnt_out = pipe_cnt;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index eebb42c9ddd6..07c59f8eefce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1721,7 +1721,7 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.panel_cntl_create = dcn31_panel_cntl_create,
 	.validate_bandwidth = dcn31_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn31_calculate_wm_and_dlg,
-	.update_soc_for_wm_a = dcn31_update_soc_for_wm_a,
+	.update_soc_for_wm_a = dcn315_update_soc_for_wm_a,
 	.populate_dml_pipes = dcn315_populate_dml_pipes_from_context,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index b6e99eefe869..5dbd363b275b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -292,6 +292,7 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
 	.num_chans = 4,
+	.dummy_pstate_latency_us = 10.0
 };
 
 struct _vcs_dpi_ip_params_st dcn3_16_ip = {
@@ -459,6 +460,23 @@ void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
 	}
 }
 
+void dcn315_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
+{
+	dc_assert_fp_enabled();
+
+	if (dc->clk_mgr->bw_params->wm_table.entries[WM_A].valid) {
+		/* For 315 pstate change is only supported if possible in vactive */
+		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[context->bw_ctx.dml.vba.VoltageLevel][context->bw_ctx.dml.vba.maxMpcComb] != dm_dram_clock_change_vactive)
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us = context->bw_ctx.dml.soc.dummy_pstate_latency_us;
+		else
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.entries[WM_A].pstate_latency_us;
+		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us =
+				dc->clk_mgr->bw_params->wm_table.entries[WM_A].sr_enter_plus_exit_time_us;
+		context->bw_ctx.dml.soc.sr_exit_time_us =
+				dc->clk_mgr->bw_params->wm_table.entries[WM_A].sr_exit_time_us;
+	}
+}
+
 void dcn31_calculate_wm_and_dlg_fp(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
@@ -486,72 +504,6 @@ void dcn31_calculate_wm_and_dlg_fp(
 	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
 	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel].socclk_mhz;
 
-#if 0 // TODO
-	/* Set B:
-	 * TODO
-	 */
-	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].valid) {
-		if (vlevel == 0) {
-			pipes[0].clks_cfg.voltage = 1;
-			pipes[0].clks_cfg.dcfclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dcfclk_mhz;
-		}
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.pstate_latency_us;
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_B].dml_input.sr_exit_time_us;
-	}
-	context->bw_ctx.bw.dcn.watermarks.b.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_enter_plus_exit_z8_ns = get_wm_z8_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.cstate_exit_z8_ns = get_wm_z8_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.b.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-
-	pipes[0].clks_cfg.voltage = vlevel;
-	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
-
-	/* Set C:
-	 * TODO
-	 */
-	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.pstate_latency_us;
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
-	}
-	context->bw_ctx.bw.dcn.watermarks.c.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_enter_plus_exit_z8_ns = get_wm_z8_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_exit_z8_ns = get_wm_z8_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-
-	/* Set D:
-	 * TODO
-	 */
-	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us;
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us;
-	}
-	context->bw_ctx.bw.dcn.watermarks.d.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_enter_plus_exit_z8_ns = get_wm_z8_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.cstate_pstate.cstate_exit_z8_ns = get_wm_z8_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.d.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-#endif
-
 	/* Set A:
 	 * All clocks min required
 	 *
@@ -568,11 +520,9 @@ void dcn31_calculate_wm_and_dlg_fp(
 	context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.a.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	/* TODO: remove: */
 	context->bw_ctx.bw.dcn.watermarks.b = context->bw_ctx.bw.dcn.watermarks.a;
 	context->bw_ctx.bw.dcn.watermarks.c = context->bw_ctx.bw.dcn.watermarks.a;
 	context->bw_ctx.bw.dcn.watermarks.d = context->bw_ctx.bw.dcn.watermarks.a;
-	/* end remove*/
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
@@ -594,6 +544,9 @@ void dcn31_calculate_wm_and_dlg_fp(
 	}
 
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
+	/* For 31x apu pstate change is only supported if possible in vactive */
+	context->bw_ctx.bw.dcn.clk.p_state_change_support =
+			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_vactive;
 }
 
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index 4372f17b55d4..fd58b2561ec9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -35,6 +35,7 @@ void dcn31_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
 				  int pipe_cnt);
 
 void dcn31_update_soc_for_wm_a(struct dc *dc, struct dc_state *context);
+void dcn315_update_soc_for_wm_a(struct dc *dc, struct dc_state *context);
 
 void dcn31_calculate_wm_and_dlg_fp(
 		struct dc *dc, struct dc_state *context,
-- 
2.37.2

