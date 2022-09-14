Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B9EECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1370910E7FB;
	Wed, 14 Sep 2022 03:35:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8166A10E7FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb+kFyIMH1hD/DUGw5BKeIt33OSgT45jPTeVVnay3aXWB+3S6Feuq0hyELVQkOSrwNf/HbEg5rMVBtcBLcTcrIVgf0FGRjtTAuXD1Htg6TeJRuGK2r25qlL6TfuukbPLiybGdH+CMBKiiLAR0mH0ru9TwOiziIkiK58sbdnVMxHro8tA/32Igc0CE2527yURQmKjbITy9ALA+/GMxVdbzTZ3Z/aaDqsC1p7POdGpjE08DcC0cNZYi55zxfSWlN3OlhPlOt0X2/4s8eMFUUdAuBJZ9hpphQyJ3TY800v93SSY0ga+tX8dxATIz9VtR4j4e57fiG7l5cVJtFy+d6/Jjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOZJknLQl+4cf+IBEe5MrURoNA8WjbZuftP132R47Js=;
 b=cpjTk4juSEqMy19OjrQ/o1Sg/WZQtQ/fQgnSwfijL2qUnRuj7qM+2/nVMjikEnOqouXUgsH5w2oCc1NDoqMb9oX3eJNyo2K+4sKZBDTDUK9y+2Csu+Qh/5dyboZo70vcIBMsF5a2eCBk1VGLlCCq8M6BEQzat0NgtSjsqaT0z7vq7IExIbErod4n3sPTySIXTCAcu/MwprPvBPl7EUp0D6iJAtDFCQHVDuESGHhzKlYR4d6TOb57x5IXzoBKhCOYr4AMt1f4AVcel821zr0xeqUHJSAMlW721jLevTUQMa5aPHPYcVOPcn2s3k9mksO3lhaW3HGdCY4CvPfsN0ei+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOZJknLQl+4cf+IBEe5MrURoNA8WjbZuftP132R47Js=;
 b=NsrYyjwK7gR8FOnOGLxZnRgU9+tzGSPx5LGWCFGau4hseyw5SoDNE1ZSvNJGNDxCKV0FMN8q+StQO0RsLVtEwnHCk337/mBlDbcgnTwBG9Vrb2z4MypkCKO/DTLXkIgAw7+IkUPZRfvtvtwyepLysEZVUGNxpGwjeuUUc5xqDp8=
Received: from BN0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:408:141::18)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 14 Sep
 2022 03:34:59 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::c4) by BN0PR07CA0020.outlook.office365.com
 (2603:10b6:408:141::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:34:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:34:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:34:18 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:34:15 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/47] drm/amd/display: Update dummy P-state search to use
 DCN32 DML
Date: Wed, 14 Sep 2022 11:24:22 +0800
Message-ID: <20220914032441.1075031-29-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 16cf50c8-600d-47f5-95cc-08da9602194a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EyL6E20AFXYAffrT5R+xYtykMBSv22jV4938kfl4DFFxPX+noywHij1vtkGFTBuS4TUOxibimaUdcdF+tClWG5AeF/2TdqCuzvOg205fU6yAZJMnb058bcWzTj7R1lm7lNGlenXfv+/uNeMmLWILaeGxzHxphkMiQgC/qHnBYiLh4Y1bblI4Knt2+IaVfmXdWgRxzghBboeiW5ynZl77HrtGqHsvbUHIb7dmaOgmU9EIr+HtxhK0uXU/mCwuwz2dMSuJdV8rPOgrTxEGG6knOYyUKwd2nWzy1v1+DkuJsbqAJU+OrJmL2Hs+OBgCIsYEcWKNF6vJPJDy/yackF82TMZixcofx/pIxkXkXOVkmQtdvFS0RVEyr5OznybhZWRG8PJn5ExKKrIx1Aa5jznjXmfPOsgQp0lD1/trb1MJkceKReIb6kbCVn39rgb4wwU03KXZdo7rZxC5fHCmu4JJ1vrT/d6JoQVGF7sjQC1MZDm0f11qapVN694cVgUbpvWWiG+l6wx1ihPXDmKD/NbPXU5WZlDUAiC80zttSLHzt3ehKh/APVxkyGuKvw4kDS0u4bZW69stdoR1KbAq+49Ahh9XfbEqEZ8ILhna1+89486RWgc7EvqoObAgQg0NqfeSFcrSyux78qQm5haFHicFdttrxX3vmcD+XEch3/frPHD8KUxd3q7uoaLkEK+0GexCDUglOwWLvRBzQrVzAN8T4bCZ4UJy24DzlHIz2r6LjormEXUXjcF9ks8cIr2UWjgFbu1FS79lUjN1k1BJb9jVE7CBnnb8UuSRvtutoit6/RmuprHgssT1L1KJmNfcIt/Q
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(316002)(6916009)(40460700003)(186003)(36756003)(41300700001)(82310400005)(54906003)(2616005)(81166007)(70586007)(47076005)(26005)(7696005)(478600001)(8936002)(70206006)(36860700001)(6666004)(2906002)(426003)(15650500001)(82740400003)(5660300002)(336012)(86362001)(8676002)(4326008)(356005)(83380400001)(1076003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:34:58.4140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cf50c8-600d-47f5-95cc-08da9602194a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731
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
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
Current DCN3.2 logic for finding the dummy P-state index uses the
DCN3.0 DML validation function instead of DCN3.2 DML.

This can result in either unexpected DML VBA values, or unexpected
dummy P-state index to be used.

[How]
Update the dummy P-state logic to use DCN3.2 DML validation function.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 46 ++++++++++++++++++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  6 +++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b8d4547a885f..b573ab7b81ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -243,6 +243,50 @@ void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr)
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_uclk = 0xFFFF;
 }
 
+/**
+ * Finds dummy_latency_index when MCLK switching using firmware based
+ * vblank stretch is enabled. This function will iterate through the
+ * table of dummy pstate latencies until the lowest value that allows
+ * dm_allow_self_refresh_and_mclk_switch to happen is found
+ */
+int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
+							    struct dc_state *context,
+							    display_e2e_pipe_params_st *pipes,
+							    int pipe_cnt,
+							    int vlevel)
+{
+	const int max_latency_table_entries = 4;
+	const struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+	int dummy_latency_index = 0;
+
+	dc_assert_fp_enabled();
+
+	while (dummy_latency_index < max_latency_table_entries) {
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+				dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
+		dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
+
+		if (vlevel < context->bw_ctx.dml.vba.soc.num_states &&
+				vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] != dm_dram_clock_change_unsupported)
+			break;
+
+		dummy_latency_index++;
+	}
+
+	if (dummy_latency_index == max_latency_table_entries) {
+		ASSERT(dummy_latency_index != max_latency_table_entries);
+		/* If the execution gets here, it means dummy p_states are
+		 * not possible. This should never happen and would mean
+		 * something is severely wrong.
+		 * Here we reset dummy_latency_index to 3, because it is
+		 * better to have underflows than system crashes.
+		 */
+		dummy_latency_index = max_latency_table_entries - 1;
+	}
+
+	return dummy_latency_index;
+}
+
 /**
  * dcn32_helper_populate_phantom_dlg_params - Get DLG params for phantom pipes
  * and populate pipe_ctx with those params.
@@ -1723,7 +1767,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 			dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(dc, context);
 
 		if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
-			dummy_latency_index = dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(dc,
+			dummy_latency_index = dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(dc,
 				context, pipes, pipe_cnt, vlevel);
 
 			/* After calling dcn30_find_dummy_latency_index_for_fw_based_mclk_switch
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index ce4c33e64186..b43c45adb7d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -70,4 +70,10 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 
 void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params);
 
+int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
+							    struct dc_state *context,
+							    display_e2e_pipe_params_st *pipes,
+							    int pipe_cnt,
+							    int vlevel);
+
 #endif
-- 
2.37.3

