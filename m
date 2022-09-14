Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CE3C6FA8D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BD010E848;
	Wed, 14 Sep 2022 05:16:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BAD10E837
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9JWKTRgXLaJ9ibLG9ERQnik1OE2PbaIZJbMxDMX2s96yiz27S8wDZiZY3yJdXlQtu5fCVYvR3aohUteKYezDDjSgYsI1LupRiZnU43C1AJYakep+kQjr7hz9PzQD0hUM5ZZuIrhCyVM1Vt00Qitfd8toI+uSyyMbzZYQiekCTxtbraSbJg/B+6Hwc4ecbyUklm9mAdP07yJhLwQUYpYX/JcAz4I3LZcKcdvmCD6VOAKpCcHVzCZhTG6mMLTy7KyCEIPtIi1KOYV4QzZpodLhGrJrLwVzrxoGfqwWxuwo+IP1Y0JusovY6RwW9BdVNfGvR6oIV8MRuu4hXsAkukHmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOZJknLQl+4cf+IBEe5MrURoNA8WjbZuftP132R47Js=;
 b=A0l4G/F9DfGvRMSStis4g8fRrne3Mo2OcFAhfKkbVuhxkuhW8MFG1Hdt+9zE5BYGWgosyKQyiXJMVXrgl4f5vm4iBwgkBk2Tj8J2gF7esO07MB2IgP1lF6FSnqatnb+nGXgYXxQNsmCwsnB/EhaRTaRYamMGaKUcWe4rlt9PWh5bCWC5C0KgsjhgWzybxPN1ifxjwluLwNzi500fVZm5Xe3pxPFaLC+ypiM67QTHmLK82sqbQz6+r6M9XxzqwHJk0y7MUSoBDNOZ3VDOzNR/StmhS+o4vsrstX3sedPx7CaWk4vnx+wBCc8vpqFRdk0ar4HKmbVTCJynaJEeoNfa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOZJknLQl+4cf+IBEe5MrURoNA8WjbZuftP132R47Js=;
 b=FlPRJhanHGSYq+jpDHXiQRFlkdJndOOdpsM5k9g3Lpc/qop7kKrNyphDzcwUv8tAXD/sliDUd2ZiFR3AwbCjfgyRvBgQAkd9pmNVeuf+DmQWleF1MJCJcYz1A1F9jqN7nBvyP6KahEplCAU5JOr0ZJW9peIYStP6jur7StYG/vg=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 05:15:48 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::61) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:44 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:15:39 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 28/47] drm/amd/display: Update dummy P-state search to use
 DCN32 DML
Date: Wed, 14 Sep 2022 13:10:27 +0800
Message-ID: <20220914051046.1131186-29-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: bc235d5e-c268-4010-8d71-08da96102f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5JzrOR2P2hFcKs+d54w0qB1tyKYURDJRARlKgsQyoO98R+LaynN1i2xojAtuAi92dGNGRSV/i+GAAK56ffU6AYVEdhj+1DrTJfh1wFQRessr2B7ei+XWWeukxXsu4SLzqnEtQpUJTuxIQIWclGMbmHBSViUQHs+SXDf8xIwPg2pCAOwWuoY1SYb6hlhhFxkEVgriDapJ+fk7YAn+PNvXFh68dIKfFu5BR5WFeeHzUZS7P93ohqpPzZdwk/zL47pc4a/dqC7fl57WMy0TmpP1MnOrdwz2GjFnIiwfa+0hb9G8AiJ1bLNpviyGf0fe+5mRCYR6JUmONT5S/7KiQ1avtVW1kVy+ZhwGIR6WtbmYkEra1vzZjwdkm/FBcqncG8FeZ/8a94oDnlhwCnQUDRTmeuIvwrHCgYLseeA73+Lh88tmtdYz29Jq4j0ZjMFZUIgOGlyfqJIKF1y9n63ca/55gR7YdyRZIcAFqqxyq3wjsjAilUb4HI1rsdZOPUG2ZI1Jda9EWuIulzMdE0XFaxHvjJXKMWZ7ajobubcZqU6/XV0YfIehUGXgwzgKZDOvvnk/aaGOepSL47I06GYpFDz/oSbkw4fmKZuYA2zV0ZFnXpnCVQ6DwAjEUi46JKzlKC3DO9cuuTPgQmJEqQWVP/6yNWZGzib0BKzZ8atFK1swBf6/c78dzl+bNBWGdnXDD7H3J7725ScsTXTSwRdywCslb/OPx9xdAAmw9J7kQYgu/7vpRQQoovPElVKShsy3Flfwm2GUbpIrSf6alKh7CZ0j5pURZqoLyQS/3/5FctqPAik6qhSLatyzQcHuMneyrOZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(41300700001)(70206006)(26005)(15650500001)(4326008)(86362001)(2906002)(36756003)(82310400005)(47076005)(40480700001)(186003)(54906003)(82740400003)(2616005)(8676002)(356005)(40460700003)(6916009)(6666004)(36860700001)(316002)(70586007)(81166007)(1076003)(8936002)(83380400001)(336012)(426003)(7696005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:47.7179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc235d5e-c268-4010-8d71-08da96102f0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262
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

