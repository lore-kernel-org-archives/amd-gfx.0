Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A190C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DD310E578;
	Wed,  9 Nov 2022 06:15:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2C6810E577
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJ6TvdVwZ4bPU/C0S9hzUN0g+/MERKaUUALWj4gBFfpyKeKhfBuAHylPPR1/973wm0dmVp8KzJxZQgBDxF/bKgWTCgp1JVTwckmbXp4YeKW7k7YB3lDurDMXU6Mfu+SI9UJ7M6HgshTTQSEsdTxJng0wTvPBmYYN4CoPmn2kB2D/CrHJOeXHlHlqsQykarCebNmfnXn69mcYAoGLCjERhDT+UuXgxMB8ra28lm8PTregtDM7GzsLM1CCNpk7aivD4lJpSIpV54jEoTTDs2qOzjy13n97YTi+R0PMBTMkOhv0mSBoNDSNOp+ElYbQOjubbwCht9/i2YwGbLoOM+fViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjjUAqRVlLFvDexTQzXSsi7bsmQhbg26vH+oiWbMmg0=;
 b=fkbPzsvWDtMoMjaPHtO9TuERE+lubZGcbKPr7ET3c6S5N+23I3r9TIpnKiCMy84FwxuR6xoHwnB7hqNPwiU9CRZ6T5L2jnhp7/Zw7MMMqHMQfmd8TUvaDOLwOPL/6Lxt779lLG6MooPhFhDRi2yC97lFfgYMBnIIFDAwM8cy2HaORQc2g32jN1drekokDX/hgAmppV9sDNTs3TQFYgBq3L3T71dzkPRJfkvhi7BGWQrc5xdvtDrvecHlaRDRjiq3OveVlKPBRnC4AzlgO+T2IsVqUVXbVDqrl7gHDQNDc8CAuR9WEOOGsMUQ7j0nbT/fTn64n7b9cHE7VkKpM03CyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjjUAqRVlLFvDexTQzXSsi7bsmQhbg26vH+oiWbMmg0=;
 b=JQpCWW8O6wDWaGJkx30Fsdg8s61GX30P1bfdrryssdymrI32B2uO6uwInIcJz4YSlk9yqxwfhbJ+TTxGc7pt27DT1k6/6hOrlA5NmyvRcIG3wZ7KXOsEB2Cs4Kem6090HSToRD6NeDhteZJ36hIk3nRGeES2CgKuSbx+6YEGPkc=
Received: from BN8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:ac::15)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:15:32 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::ce) by BN8PR07CA0002.outlook.office365.com
 (2603:10b6:408:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:15:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:15:29 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:15:29 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:15:24 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/29] drm/amd/display: use low clocks for no plane configs
Date: Wed, 9 Nov 2022 14:12:59 +0800
Message-ID: <20221109061319.2870943-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|BN9PR12MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4fe47f-46a4-48f2-c7fe-08dac219ceb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+Y7tk0kitg4h+J7ZLBvJaDm4wZZYe1cIZGiRMoKYLuF36OirefD+5nJFkf7VYdOHryAUxkMpktaVwWsBSEJKs9Jr6h6XCJTmZEKfA9xB0QH8MIgHEsn5Du0vBBCa0/cribkrP0cWvJqMLo0gWntuGCWVuFdkCjeFTr7dB7AviboVdHYmfjjL6zH/QQwNVQ2XmOprZwFhEJN5AEgbozdcsPyjPRvhT1uN5b5eYWjIrlNqbk4b+mVFK0MGteCpgWhK97f/RhQIbfP/7882kvsTza5uxErzYqCNUUs1gCWGaKHNwbQRqYUmPicyfMnsW3MfmAbtsLaKGEcTP49MiViO6ECWn+m3Pa/4t8F1Hf+ZkBaThR/ryOmzgpxa0yh4Jc6nERprgx1GGiHp4fgwmMIRemOuZTHLvhTK9AFuf+ss3H92nuNkUNRkUmRMYf/J2Tnp9L1OSK2TviUT+xY5yQthdy7Y1KgDWchKaKR2SXIQiwov5u/TiKUhUQLZz2buLwHOMLKtrkSIYk9rm7tRXSDKcVc0zBa0Knl7+0CSYCk9Gd53psDV9PmK55t8nT9oz1QWyb0/fWRjya8JwMrDNjk+L0pUt+3ZqzJuHEuqNaUkwooVA35+UhPWOnQPbNsp+HbWnWlcg5zRR8rE1CSi786XcVSTIsHyX8wXnNleSVSQgr9cus5kDM4VOm4jS+yjwyjfVqiisn7RUnRuyluRSEODZKWGpjyK+cmCN5v78OWe0FSJIeTjEVQbp4sy4ovGAHzM/jeTBLP63kYQEAy455eIQYKx9d1+ebwAYjZvpbuTi8+EVKG36op8UppxN65+cE2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(426003)(47076005)(83380400001)(26005)(2616005)(82740400003)(1076003)(8936002)(336012)(186003)(5660300002)(54906003)(2906002)(82310400005)(40460700003)(478600001)(7696005)(356005)(40480700001)(6666004)(70586007)(8676002)(41300700001)(4326008)(316002)(6916009)(86362001)(70206006)(81166007)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:15:32.3802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4fe47f-46a4-48f2-c7fe-08dac219ceb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Stream only configurations do not require DCFCLK, SOCCLK, DPPCLK
or FCLK. They also always allow pstate change.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c   | 18 ++++++++++++++----
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 14 +++++++++++++-
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 7dd0845d1bd9..4cdad8674b8e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -483,7 +483,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 		int pipe_cnt,
 		int vlevel)
 {
-	int i, pipe_idx, active_dpp_count = 0;
+	int i, pipe_idx, active_hubp_count = 0;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 
 	dc_assert_fp_enabled();
@@ -529,7 +529,7 @@ void dcn31_calculate_wm_and_dlg_fp(
 			continue;
 
 		if (context->res_ctx.pipe_ctx[i].plane_state)
-			active_dpp_count++;
+			active_hubp_count++;
 
 		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
 		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
@@ -547,9 +547,19 @@ void dcn31_calculate_wm_and_dlg_fp(
 	}
 
 	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
-	/* For 31x apu pstate change is only supported if possible in vactive or if there are no active dpps */
+	/* For 31x apu pstate change is only supported if possible in vactive*/
 	context->bw_ctx.bw.dcn.clk.p_state_change_support =
-			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_vactive || !active_dpp_count;
+			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_vactive;
+	/* If DCN isn't making memory requests we can allow pstate change and lower clocks */
+	if (!active_hubp_count) {
+		context->bw_ctx.bw.dcn.clk.socclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+	}
 }
 
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 853ffb704985..dadaac249836 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1228,7 +1228,7 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 				       display_e2e_pipe_params_st *pipes,
 				       int pipe_cnt, int vlevel)
 {
-	int i, pipe_idx;
+	int i, pipe_idx, active_hubp_count = 0;
 	bool usr_retraining_support = false;
 	bool unbounded_req_enabled = false;
 
@@ -1273,6 +1273,8 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
+		if (context->res_ctx.pipe_ctx[i].plane_state)
+			active_hubp_count++;
 		pipes[pipe_idx].pipe.dest.vstartup_start = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt,
 				pipe_idx);
 		pipes[pipe_idx].pipe.dest.vupdate_offset = get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt,
@@ -1298,6 +1300,16 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
 		pipe_idx++;
 	}
+	/* If DCN isn't making memory requests we can allow pstate change and lower clocks */
+	if (!active_hubp_count) {
+		context->bw_ctx.bw.dcn.clk.socclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+	}
 	/*save a original dppclock copy*/
 	context->bw_ctx.bw.dcn.clk.bw_dppclk_khz = context->bw_ctx.bw.dcn.clk.dppclk_khz;
 	context->bw_ctx.bw.dcn.clk.bw_dispclk_khz = context->bw_ctx.bw.dcn.clk.dispclk_khz;
-- 
2.25.1

