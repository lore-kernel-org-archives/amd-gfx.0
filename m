Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A279C77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C364C10EDC3;
	Fri, 14 Apr 2023 15:54:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4700110EDBD
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HORNW32z7FnacHTYHpXTze8YlyCqRYPXJN7NW2o5QwN84wIeaLoFrUwC1sL/280Ci7ivz2r1hQxIyBOiTDkH8wEP1uixWyJSzF14bQ49VLI46xX2Y4fil8QNTADaY/yZwtrYJOGnNTkk2OTYkfpuZIn5xwVeeLjmoW0wbTboDyJZgW76r8cMcuxqLR7B8/3PoHmVjYuICeRRYrZHQKnkoPFHqlQ/ELzviXqno0k582chjtmBBfNoAXy1umyd20YeSq443fvmv0TkzoHD/Gcx0mzFwq+umw2vNwddAvUmIbzEQAsw9yvpXQGEPcMjSs0JLFzz+XJJdKuprw/GMVPDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9k58SUjCnjYlkmV84Q7LLhebtc0cL9lKemgIOkeND0=;
 b=kEGNCNFtrq5yIxOjsjEhIzG/vDnEm1FVK3UaPYT2YN0j1KvbrB5skSE0zcVOwOt8bHuT7PSU52S3MUSOXX9CGbx6LLvx2zWGS4G3qyVnVPys4m+Q7wfv3XQgW+Io50ahRYGIkN7oIUqGlkpqMeWKQmcIsPiW6hu9F2X1RlrXKop9ayTz8Nb3IaiUc41+8+TBRH9JkrbN6if2YWmEKF/F0TvJgl90AefPTcRKMu66Z6XlXITSplktfqodN5nuMZEC1D6c5qHyR54X5gbjbFqpheu3Ia4i56qDag+I2K+ZQF3odFvwLdkFRqXngn/Q3bUIKbp7l7tJPqCzoCyIgGqkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9k58SUjCnjYlkmV84Q7LLhebtc0cL9lKemgIOkeND0=;
 b=Y0PlzPVNuSxiCVVDTsMg71OKeKzvYFktoK03+UamATLEYTHzBEpRJaif9WzYiUic+i8fJFrsM3QK+vWzL6s+EAW+MxJx4wFa4lcfGL2NVI6j/Fwp+jOK5bEZT75/QLDWCWh07D8AedWpWSzYayL/e318Imzvvy/uCHkTGk85RsA=
Received: from DS7PR03CA0096.namprd03.prod.outlook.com (2603:10b6:5:3b7::11)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:05 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::89) by DS7PR03CA0096.outlook.office365.com
 (2603:10b6:5:3b7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.32 via Frontend Transport; Fri, 14 Apr 2023 15:54:04 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:03 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/66] drm/amd/display: Add missing WA and MCLK validation
Date: Fri, 14 Apr 2023 11:52:36 -0400
Message-ID: <20230414155330.5215-13-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5ca570-6d20-4898-04e6-08db3d007975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHJd5jzwO8lX4SxZztT8y4K2X8PjbZSVTuFE6w51p2e2f4SfDmSOmf8yUq/qud88ziuw0/3DI6yf5AhyAttPlYL/GXvcAz34jPkuYN0vrh9dUEEPYjXeOApR0zIuC9A90/vXCzZY28xZGvygm4/OzUmoweBMKFWVRfo60boCS6gwWTXf7fbxg8GtuA64YmQjZB4NylF7xKTADKAZE3RB1gOIsO5c4SJd6QsxGei1O5p9ZD1BB/SKYLnuhf9yOdDm8rVFhVBt/tWkuEOE83X8W/VvtxUhJE4Sm58L/awsaDpxQYkvAHdMiljIvskCNy12dIsB0Tk7yt0LnwSsSHY5YVfFAMrOFc2S5TDheA2pzi5cxFKjAYGn7WuDlWbnsu0MXdw/Vh9Tdqyq0My8jt2IFmAP4wM8xtbL/ncmKdlr5El62zTEuLs0CKTJ4jYArj0c/jlj/xISV9l744AUAG5+AWZbkhyvUOo6O03iXhIAOyAJpOjGxnP0gD5ZW1odhNa7yFQWZh4usQ57cmCWWvZhjNs+m1lc0f4c8Gkt2XrYjc0KFAAM3MPxQ2imf82vsTyrLSQXRITPvkzEXiKc5i/vIFykX43WWbv+i6wKJT45/RoWYdyJLWzLaxisrMNv5OgLR9/THuH1NSsO7JH5Z+zKI05kE0O0VFOl7ngEEH1fa8/fP08U1mO6+5BXs5ZSoI7DUKQawu7jgyYu60x+Vgn5d4Rvw7zK2/gAfjK7ue2q/Ss=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(70586007)(8676002)(8936002)(70206006)(5660300002)(478600001)(41300700001)(40460700003)(316002)(83380400001)(426003)(82740400003)(36756003)(54906003)(336012)(6916009)(40480700001)(4326008)(26005)(86362001)(6666004)(186003)(1076003)(81166007)(16526019)(356005)(2616005)(36860700001)(82310400005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:04.9282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5ca570-6d20-4898-04e6-08db3d007975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

When the commit a983d2631869 (drm/amd/display: Don't set dram clock
change requirement for SubVP) was merged, we missed some parts
associated with the MCLK switch. This commit adds all the missing parts.

Fixes: a983d2631869 (drm/amd/display: Don't set dram clock change requirement for SubVP)
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c  |  2 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c   | 18 +++++++++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index db0974fe58ab..1f5ee5cde6e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -948,6 +948,7 @@ void dcn32_init_hw(struct dc *dc)
 	if (dc->ctx->dmub_srv) {
 		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
+		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 0beb11d95eb7..a876e6eb6cd8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2023,7 +2023,7 @@ int dcn32_populate_dml_pipes_from_context(
 	// In general cases we want to keep the dram clock change requirement
 	// (prefer configs that support MCLK switch). Only override to false
 	// for SubVP
-	if (subvp_in_use)
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || subvp_in_use)
 		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = false;
 	else
 		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index 80972ee5e55b..a352c703e258 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -368,7 +368,9 @@ void dcn30_fpu_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
 	dc_assert_fp_enabled();
 
 	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching ||
+				context->bw_ctx.dml.soc.dram_clock_change_latency_us == 0)
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
 		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
 	}
@@ -563,6 +565,20 @@ void dcn30_fpu_calculate_wm_and_dlg(
 		pipe_idx++;
 	}
 
+	// WA: restrict FPO to use first non-strobe mode (NV24 BW issue)
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching &&
+			dc->dml.soc.num_chans <= 4 &&
+			context->bw_ctx.dml.vba.DRAMSpeed <= 1700 &&
+			context->bw_ctx.dml.vba.DRAMSpeed >= 1500) {
+
+		for (i = 0; i < dc->dml.soc.num_states; i++) {
+			if (dc->dml.soc.clock_limits[i].dram_speed_mts > 1700) {
+				context->bw_ctx.dml.vba.DRAMSpeed = dc->dml.soc.clock_limits[i].dram_speed_mts;
+				break;
+			}
+		}
+	}
+
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
 	if (!pstate_en)
-- 
2.34.1

