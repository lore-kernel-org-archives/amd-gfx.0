Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400A6C6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF18D10E4D3;
	Fri, 24 Mar 2023 06:51:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCB110E4D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWYctmDB+vf3b3gbNK4j7MFr/vEMh5CfuUt/wvqEV/99uie9MTkC3Ue7d904dkS2f+yUVAchxp9lpg0gC1PQrQwhrlzUvJJgGfAWGbYzJe7Giy0sjDEgq/mXpnkEE3uACen+R+j7BCGHKpoBUS9MQE5Vu7uiXUDGExxpRLu8m7znk41ritMM7NWZTo1ODEhQnsQVUT4UAwedehE4LsIH9Y8M/Dy8HdD2P2sPLPsqlaDyVcJX5tmyPQ4M8VL7+HiDgR5NtVt9Ya37HIFxm0cx2CianLMSDhORG79NZtpCtgHZ4eRMbPcmZJ32PC9aMKvXnLY9NzulNxSdD1NGwXardA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjfBGZuO7lTJlXSqeoZm7FP0VCwbVMuvd4+SV/UXkmI=;
 b=TGmtXGbNci7ETGhoGxWhAMuTOjtgBmHF2tJ71yTvNA0vDOzx25D2+GvpmgTYJFYsuGqgowJMKs24W1yQSF5lf2Wyv3FReiF9Wgna+AW4VOAru5dXikuNy/bKVk/LZ5wz1N54rU7oO4JW1t4/lnTiKxCdMzJ4EKfTLjKjEpPZ0ij3qm+0JWawhg6JzkqIi4dtp3CVvo+9sIk07VFxYJjqiiysAkYIx9O/ts6g2++jqsfXbFxGtPO2j311CYqXRHIB+dFgcXWAIbTQXVlnviBcLrEOFne4RLwssUaFxLzo3zwcwqNDTiMySQCm3xnU9g1iHWZJk1oZXJL0dscK+msb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjfBGZuO7lTJlXSqeoZm7FP0VCwbVMuvd4+SV/UXkmI=;
 b=CVtpd8TdmPpmWXmnKRAo9wWEf6WE/+2kwlC2tVyGazYEYtsjyKcaSUUs7i1kwtLS548o57wI4n/Q8K2yMCTH46tqulTgUBwUBbp7ivLsGhJbL6vw7R21yGVSF02cwNsbywMlqPmWFRwjecaSpX5DmqWOhrgGMUZgB1kxCmiKTcY=
Received: from MW4PR03CA0086.namprd03.prod.outlook.com (2603:10b6:303:b6::31)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:51:55 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::a0) by MW4PR03CA0086.outlook.office365.com
 (2603:10b6:303:b6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Fri, 24 Mar 2023 06:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 06:51:55 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:51:49 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/19] drm/amd/display: Enable FPO for configs that could
 reduce vlevel
Date: Fri, 24 Mar 2023 02:50:54 -0400
Message-ID: <20230324065111.2782-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: f5aea86a-0996-4a6e-33ac-08db2c3441cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRZ/9Cs0Uo1ErVC+XIAdxIoHMSNqpnr4kmz9Br9x9yjDl7fnVDsTauVkvmKKU0Oazi6dQO6xvzdjygvytUXRif17Phq4OmyMrUIgo2yg5rxi+fpnFFd+R3XWp7/0GdA9fKiC1Ozf/JSz9WwTcTb6lEdPMGjhDVPBxwQEP/6+SxwhYlyV2JbIZojlANX4vzv/e9oloJyxVvD/mIVG4K/cqptR2RphGjNVgOgsqepmRIITzVhYWUEoWOJ9mf6KDiN1oVwHLmvpF1/nv0YHYBMHWgF/sJuUTAQU1AEJexqrnf1rhxJ/M++8xqXKWEQsMHf0wzpMU0+B94ewj5L5lcqnn5F5MxNmq1jbt1wvzlZruMmU1e7Q7mOcKy/mt8MjlSmapDMIZK9GEZchV5qgJkzoZ7/FyKV7SNlkuquID2HqLr81a0FNv7blXwX0otcbkZtPnGcssHCI3vjZk1dwiE201W+oFKPInsrWxjuKUOXQKgPDaQucN8rn79bFHmMyJeTPawC+D1uFtQ1bH3im5Lx1ehVIiCsDWZrYe7olF8aVhAgwj+13VmcqRi8LWaSVWpZyG/DBU2SXyYakcn9NmyUUxnHkFfqdErAnrNOCbjIBxocjUXxWAuZ21SOIvGw/miNb9gQNHAt9c8vbwj0Ra+PE7+7XV29LefWcKh/pfY/0Cg3gINA1tsAm39+wbpUrAIiqcwIoHyZdCz1E53VybfG1b5g95sr2ZURre/V5cr6GIPQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(86362001)(36756003)(8676002)(6916009)(41300700001)(44832011)(4326008)(5660300002)(478600001)(8936002)(54906003)(70206006)(70586007)(316002)(2906002)(82310400005)(36860700001)(81166007)(82740400003)(40480700001)(1076003)(26005)(356005)(16526019)(83380400001)(47076005)(426003)(2616005)(336012)(186003)(6666004)(66899018)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:51:55.5252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5aea86a-0996-4a6e-33ac-08db2c3441cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- On high refresh rate DRR displays that support VBLANK naturally,
  UCLK could be idling at DPM1 instead of DPM0 since it doesn't use
  FPO
- To achieve DPM0, enable FPO on these configs even though it can
  support P-State without FPO
- Default disable for now, have debug option to enable

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  1 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 23 ++++++++++++++-----
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 475128db02bb..2d2621abf012 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -873,6 +873,7 @@ struct dc_debug_options {
 	bool dig_fifo_off_in_blank;
 	bool temp_mst_deallocation_sequence;
 	bool override_dispclk_programming;
+	bool disable_fpo_optimizations;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 1715909b1225..b8c1de357e5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -725,6 +725,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_prefetch_in_strobe_ns = 60000, // 60us
 	.disable_unbounded_requesting = false,
 	.override_dispclk_programming = true,
+	.disable_fpo_optimizations = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index c6a0e84885a2..5e0b1484dc18 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -723,6 +723,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.min_prefetch_in_strobe_ns = 60000, // 60us
 	.disable_unbounded_requesting = false,
 	.override_dispclk_programming = true,
+	.disable_fpo_optimizations = true,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 6b29d3a9520f..4e17f2c8d2b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1961,7 +1961,8 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 
 	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
 
-	if (!pstate_en) {
+	if (!pstate_en || (!dc->debug.disable_fpo_optimizations &&
+			pstate_en && vlevel != 0)) {
 		/* only when the mclk switch can not be natural, is the fw based vblank stretch attempted */
 		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching =
 			dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(dc, context);
@@ -1985,11 +1986,21 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				context->bw_ctx.dml.soc.fclk_change_latency_us =
 						dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
 			}
-			dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
-			maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
-			dcfclk_from_fw_based_mclk_switching = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
-			pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] !=
-					dm_dram_clock_change_unsupported;
+			dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel_temp, false);
+			if (vlevel_temp < vlevel) {
+				vlevel = vlevel_temp;
+				maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
+				dcfclk_from_fw_based_mclk_switching = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+				pstate_en = true;
+			} else {
+				/* Restore FCLK latency and re-run validation to go back to original validation
+				 * output if we find that enabling FPO does not give us any benefit (i.e. lower
+				 * voltage level)
+				 */
+				context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
+				context->bw_ctx.dml.soc.fclk_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.fclk_change_latency_us;
+				dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
+			}
 		}
 	}
 
-- 
2.34.1

