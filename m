Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E86CC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59088610CB
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 14:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59088610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1BAD6EB85;
	Fri, 16 Apr 2021 14:34:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8351D6EB85
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEZcfScR1Iv1PX0Vm68qha20rpc3z9SRbi3vONNPVRM1KBPxhIh014m5JqkDHiVFxOO3GfgDLgegt3DV8A5kdJ4ptEMAQGUp7se+KE5M+OVCVwxg9sKi3h64jPi7wp2hIVrdol6kNa6F10bUHSdXPj08fJLwvFfcFlIcLU+8D/rA+uHGkeqIxJsS9pWLLI6H8RHRgaswlwRYezQgGJRco7MotJESRbivaTu5vfpTZmOEIRRfzwnB3qyZ/gUwTdL9oLGhhWL6Ep9jMOJazbExyyQnnOFDtBJUAJKeOKidwtLzdDzzdpdFxnOTfG+SLzjZ2vGWKGtXFbVPju16SOV1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGYeaqL+zyCNa75bU9BxcU7Rb6I1v+qfij6eSoDnbMY=;
 b=Dev+RBmR79+zVxNnljM7LSownM/7WcZ213YJ5NQfOZxQlnPFZKWNvK/89HMjvklb6/8+1TFPKuKSnbkoW8J/FW34xjFWyXLWo+DDETtPLqyY0kbwYps9U38wDH+5vH7GHkSl9Mda3v5u2rwhvsgBUh6XpasemioIaHTiGkagyQyDnheliBPVAGGbnVESuM8IChHs85UN5P6iTXbwy1PoB/M38qn3E3KF33F+hbvmwBkMnFAWMAAH1gQ+//YVEPr8k4B0mKN15r+EF8K5AIGwDPerZoQNllKGCTJcV7qadbURHNNQ394r1gtFvNgfC+tnIiOjC23z1tv1bQF2KCV5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGYeaqL+zyCNa75bU9BxcU7Rb6I1v+qfij6eSoDnbMY=;
 b=ESQ2QlOd6yJ/mZ5lNSW/vtQtkzw153B/rFYCb9pj67bT52pRBHAIDPYlZ7HhNN5xWWeoZF2md3bGkqaDMSHVP9Qt1T8wPuO2NdRDgCKp1+dC6PRMh16hDVmZS/TNo3oYhIBsQGxfBBSvumCDJIvz/fGYHffWu4Kbe8V/LWqCKU8=
Received: from BN6PR20CA0065.namprd20.prod.outlook.com (2603:10b6:404:151::27)
 by CH2PR12MB3992.namprd12.prod.outlook.com (2603:10b6:610:29::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 16 Apr
 2021 14:34:29 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::ed) by BN6PR20CA0065.outlook.office365.com
 (2603:10b6:404:151::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Fri, 16 Apr 2021 14:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:34:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Apr
 2021 09:34:29 -0500
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via
 Frontend Transport; Fri, 16 Apr 2021 09:34:28 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/19] drm/amd/display: treat memory as a single-channel for
 asymmetric memory v2
Date: Fri, 16 Apr 2021 10:34:05 -0400
Message-ID: <20210416143417.611019-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210416143417.611019-1-aurabindo.pillai@amd.com>
References: <20210416143417.611019-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 394c41ab-dd0c-43aa-21c3-08d900e4be6d
X-MS-TrafficTypeDiagnostic: CH2PR12MB3992:
X-Microsoft-Antispam-PRVS: <CH2PR12MB39922A9EEFFB57CF941FA3AF8B4C9@CH2PR12MB3992.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wE2zby0aJFs3pSGcRlc7+Od8hPw5/QZ0hhLKw/7C+rJEzW0+myW+36/iEKC9LmQjxjCG22DAWavWO5VVXnY2ISUzHayjE9GmRGVyTb6+7lx9Qu4KIiq6l6NKrmeHPB+pK4NajaBRK6DNO+aLDrLVxdW6OAjkas5Nf34pDAqDuLALf12oY+SW5KE4r7y/a2VKY7jWrHD325PZLBuEZoFbMb2Br+LqKLpCkwqhTL8YWJ4Q/fxhMMRR3/V7hSeC38i5uLcFeVpOC4v7N2L9td0B1kuLsqHcGlXCitNQ0Dyl7nT0d6b9II2xA3sYxoLDezSjuhtmosGORkpODwPBQkfxxa4Wu55AoVA1lkIOJMrDTDuGw39MGL647qODOQEqWD90s2tJOCaidxSL99k++/PfW+vsjwwFNQWYStGjl7mt56JsiQK9V0LS9yYxtkmfHyxlHca5LVlV4oIYwomKXOn6SL/5C+peK9DHiMbizsG8ANNSneouzRdXXgAUcNo08mk7Km95qru+7zK9/iJ2G0ivl+yu8uyoZjqKn4DwN+kN2y/RVdT/ht7K7VDFBZFiIUAn2fSTwDwylrKyPZ1XYC6/whFYEI9nWvTPcGCdR7vxfTosHzJ/vWdFTgN4NnavCoqknakr6JWD2G4nWDScx7wAq4pjYQ5TGoHt1+7MDjwI9KbZfK6MPnbvgU4kQFqZasCJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(82740400003)(83380400001)(478600001)(186003)(316002)(7696005)(2616005)(6666004)(2906002)(82310400003)(81166007)(356005)(44832011)(70206006)(1076003)(426003)(336012)(70586007)(6916009)(5660300002)(86362001)(4326008)(36756003)(8936002)(54906003)(47076005)(36860700001)(8676002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:34:29.6552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 394c41ab-dd0c-43aa-21c3-08d900e4be6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3992
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
Cc: Sung Lee <Sung.Lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Hugo Hu <hugo.hu@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hugo Hu <hugo.hu@amd.com>

Previous change had been reverted since it caused hang.
Remake change to avoid defect.

[Why]
1. Driver use umachannelnumber to calculate watermarks for stutter.
In asymmetric memory config, the actual bandwidth is less than
dual-channel. The bandwidth should be the same as single-channel.
2. We found single rank dimm need additional delay time for stutter.

[How]
Get information from each DIMM. Treat memory config as a single-channel
for asymmetric memory in bandwidth calculating.
Add additional delay time for single rank dimm.

Fixes: 8a3e4b2516 ("drm/amd/display: System black screen hangs on driver load")
Signed-off-by: Hugo Hu <hugo.hu@amd.com>
Reviewed-by: Sung Lee <Sung.Lee@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 48 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 73e8878b03b6..a06e86853bb9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -769,6 +769,43 @@ static struct wm_table ddr4_wm_table_rn = {
 	}
 };
 
+static struct wm_table ddr4_1R_wm_table_rn = {
+	.entries = {
+		{
+			.wm_inst = WM_A,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 13.90,
+			.sr_enter_plus_exit_time_us = 14.80,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_B,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 13.90,
+			.sr_enter_plus_exit_time_us = 14.80,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_C,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 13.90,
+			.sr_enter_plus_exit_time_us = 14.80,
+			.valid = true,
+		},
+		{
+			.wm_inst = WM_D,
+			.wm_type = WM_TYPE_PSTATE_CHG,
+			.pstate_latency_us = 11.72,
+			.sr_exit_time_us = 13.90,
+			.sr_enter_plus_exit_time_us = 14.80,
+			.valid = true,
+		},
+	}
+};
+
 static struct wm_table lpddr4_wm_table_rn = {
 	.entries = {
 		{
@@ -953,8 +990,12 @@ void rn_clk_mgr_construct(
 		} else {
 			if (is_green_sardine)
 				rn_bw_params.wm_table = ddr4_wm_table_gs;
-			else
-				rn_bw_params.wm_table = ddr4_wm_table_rn;
+			else {
+				if (ctx->dc->config.is_single_rank_dimm)
+					rn_bw_params.wm_table = ddr4_1R_wm_table_rn;
+				else
+					rn_bw_params.wm_table = ddr4_wm_table_rn;
+			}
 		}
 		/* Saved clocks configured at boot for debug purposes */
 		rn_dump_clk_registers(&clk_mgr->base.boot_snapshot, &clk_mgr->base, &log_info);
@@ -972,6 +1013,9 @@ void rn_clk_mgr_construct(
 		if (status == PP_SMU_RESULT_OK &&
 		    ctx->dc_bios && ctx->dc_bios->integrated_info) {
 			rn_clk_mgr_helper_populate_bw_params (clk_mgr->base.bw_params, &clock_table, ctx->dc_bios->integrated_info);
+			/* treat memory config as single channel if memory is asymmetrics. */
+			if (ctx->dc->config.is_asymmetric_memory)
+				clk_mgr->base.bw_params->num_channels = 1;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 82a324a618db..870cd7c6a387 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -308,6 +308,8 @@ struct dc_config {
 #endif
 	uint64_t vblank_alignment_dto_params;
 	uint8_t  vblank_alignment_max_frame_time_diff;
+	bool is_asymmetric_memory;
+	bool is_single_rank_dimm;
 };
 
 enum visual_confirm {
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
