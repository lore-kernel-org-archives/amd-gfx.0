Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C44EC00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF2919A639;
	Fri,  5 Aug 2022 18:01:05 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C218B05A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loOLeqOmJRMp0yf5kTwJAXx+1aY4unC1nJmc7IY3KggUdEIQX+48ln31fStDxPzrcU7YryFHUVE4PyJq7h84TVQeJHf0fMdSgFRLbNV1Ze5+Q5JstQx5ZEJ/BjhEG7PlG5BjDbh+jQrj+SIFDPOWmLrqmbFIO7OYohAovwodic20NOqMqermujhkxu6YwpkUOVusI1eBuKEt6qpWUvN96Cov7thaxA/uHL0daqe7GcUC9/pFspXGBGzCKN4gBXSD4o509P0uXDI+Ea8wJ0cR96Fk5XosJHOW9bU61Z/RXr6dZHlSCFBMZerKwYVL436UTuYRlx0DYEtI86henWbmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keqPfbqSKpAcYE8dtgMC6HjNKwBJ1Qq/8PXU+kiIinA=;
 b=MRcA8yxNvIKiMscCYdxq9AzyMuesSgnK6Z9BiD10K1C/O973RyRZQ5FzmOnkQeIX+oZC0zGL7XE/KUK8ydmw/4wAxfQZenYjNO8GNHEW4X/W0Rs6QKE0NIxBEMOqdVnkL38npQ1hKA+fW1Qj9TqcxwixJ0oTEuqS6hVBUb38sX66fcLhI1jQQ+nsaUq5wkzhglL0WvVr7Fnr2YaWGwKjerDdU05cBXsIu1DvUFXbDEWCfzpzFv9jn0pUH4giK93f1TmJmJTb9Cqns0T4pItgoomoFWZ+5PclfDFslBQzSUEOxQyL8uZfC0NKyn9a6NrjUDJriBf3mUdzRbEFYDEIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keqPfbqSKpAcYE8dtgMC6HjNKwBJ1Qq/8PXU+kiIinA=;
 b=l6+WVnO8ZnYJCGo2KJ8XX1fQytyasC7EpHfXmakB7Iwjjmncsis6XnT87MJBr7sGYz7UEwV4UzpzCIOG74CqIGDqap8bYRSBpEPfhF33xCok+BpdKGhIQB8Hd1yyiqPlcSTtyhLkFbNvvOmmN65V9wjXPyOhRgpRlFcIHNaeRGk=
Received: from MW4PR03CA0042.namprd03.prod.outlook.com (2603:10b6:303:8e::17)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Fri, 5 Aug
 2022 18:00:45 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::1b) by MW4PR03CA0042.outlook.office365.com
 (2603:10b6:303:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Fri, 5 Aug 2022 18:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:00:44 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:00:43 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:00:37 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/32] drm/amd/display: Allow alternate prefetch modes in DML
 for DCN32
Date: Sat, 6 Aug 2022 01:58:15 +0800
Message-ID: <20220805175826.2992171-22-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd05de9f-fe0a-430f-4d43-08da770c6b3d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbgYHNE9YZ8tL0ZMdDm4wSHHaakBPWDFrijJlOEdpykumHz/c0ebtv8425x9Rjg+t5I5iyK10B5APnGUbVOEujYq0uaQttfhldxYZ/ulB4sG2yn0V/5kUB0Zo3mFlR9mqbIIW4E5sCXbY6jfD2TwQ9qD8Yrdm5i4hhpjE88fnCQpjv0gsI5IQF4z46N0B0tHWiRGBxyEajhNgMK/HPbi7HYPbPOWVU4hKe3jx/NKD5PR3LpOnuiOb0q0DPHFkhwZYKLyx+2uV/tX//JNo74CjZd9qDPOUn4qevfPHnuQmFqFJqQEPZtFTNLXENdqw6j1XmfSITzxZPYljnJnVfU/BxEj1NT4tXddg0SU1k35mO2k7m6NU5wc4Dy6BO80W5ICgM7+ciykxbD4TMeEvtaCsJ9tgX69iJjLDDUMD4cQyjntECFstIN9UbUtRZ/PQoDoDbBK7f+Kl1EnhnD1QzG638MvITF3iFblD1DykTbcnoOmR0kgtPHLy/SrzOaVwl6X6QA6liW8LigWKPatNiE5NFHalTXyCysIvx+iPHB4T6i63WZlRDrrAKV8k++Sw8dDWqiZHhdhr9cSY2N4pktd37EXDCLom1v8oDfhckwxPRWfd6lh6yKJbU739HbhCGYxYulMEC2GGwQ7OLF6+kQ2KlPRW36X3WlWtswyMKCB9dKu91I7G+ZAjE2c/v1eUSo6aSYw/fUc/NxkcMtVbOH7qM2cevY7djuLSS0oKrv//I9rcQyxmMsUGrztm06eo3u6FOa2Cz6RODxGxMV+FvepqpHmN/hKQ6tUh4EH1KnRBd0wCwbIaeVdLxwVBaC4V8bsBtC/ONVmjF1SBN+a6iKpFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(40470700004)(5660300002)(8936002)(81166007)(2906002)(2616005)(4326008)(86362001)(70206006)(70586007)(82740400003)(8676002)(36756003)(40480700001)(82310400005)(40460700003)(54906003)(426003)(47076005)(83380400001)(6916009)(478600001)(316002)(336012)(356005)(26005)(6666004)(186003)(1076003)(7696005)(41300700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:00:44.6964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd05de9f-fe0a-430f-4d43-08da770c6b3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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
Cc: stylon.wang@amd.com, David Galiffi <David.Galiffi@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Galiffi <David.Galiffi@amd.com>

[Why]
Driver is restricting voltage levels if system cannot switch
in vblank.

[How]
Change allow_for_pstate_or_stutter_in_vblank_final from
dm_prefetch_support_uclk_fclk_and_stutter to
dm_prefetch_support_uclk_fclk_and_stutter_if_possible.
Add support for a new registry property,
DalDMLDisallowAlternatePrefetchModes, for easier debugging.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: David Galiffi <David.Galiffi@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 34 +++++++++++++------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 07feb8551436..86fe4b9f10c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -788,6 +788,7 @@ struct dc_debug_options {
 	uint32_t mst_start_top_delay;
 	uint8_t psr_power_use_phy_fsm;
 	enum dml_hostvm_override_opts dml_hostvm_override;
+	bool dml_disallow_alternate_prefetch_modes;
 	bool use_legacy_soc_bb_mechanism;
 	bool exit_idle_opt_for_cursor_updates;
 	bool enable_single_display_2to1_odm_policy;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 988e28a8e90e..85ecd94e2a4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -986,9 +986,15 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 	 * DML favors voltage over p-state, but we're more interested in
 	 * supporting p-state over voltage. We can't support p-state in
 	 * prefetch mode > 0 so try capping the prefetch mode to start.
+	 * Override present for testing.
 	 */
-	context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
+	if (dc->debug.dml_disallow_alternate_prefetch_modes)
+		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
 			dm_prefetch_support_uclk_fclk_and_stutter;
+	else
+		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
+			dm_prefetch_support_uclk_fclk_and_stutter_if_possible;
+
 	*vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, *pipe_cnt);
 	/* This may adjust vlevel and maxMpcComb */
 	if (*vlevel < context->bw_ctx.dml.soc.num_states)
@@ -1017,7 +1023,9 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 			 * will not allow for switch in VBLANK. The DRR display must have it's VBLANK stretched
 			 * enough to support MCLK switching.
 			 */
-			if (*vlevel == context->bw_ctx.dml.soc.num_states) {
+			if (*vlevel == context->bw_ctx.dml.soc.num_states &&
+				context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final ==
+					dm_prefetch_support_uclk_fclk_and_stutter) {
 				context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
 								dm_prefetch_support_stutter;
 				/* There are params (such as FabricClock) that need to be recalculated
@@ -1347,7 +1355,8 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 	int split[MAX_PIPES] = { 0 };
 	bool merge[MAX_PIPES] = { false };
 	bool newly_split[MAX_PIPES] = { false };
-	int pipe_cnt, i, pipe_idx, vlevel;
+	int pipe_cnt, i, pipe_idx;
+	int vlevel = context->bw_ctx.dml.soc.num_states;
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 
 	dc_assert_fp_enabled();
@@ -1376,17 +1385,22 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 		DC_FP_END();
 	}
 
-	if (fast_validate || vlevel == context->bw_ctx.dml.soc.num_states ||
-			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported) {
+	if (fast_validate ||
+			dc->debug.dml_disallow_alternate_prefetch_modes &&
+			(vlevel == context->bw_ctx.dml.soc.num_states ||
+				vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported)) {
 		/*
-		 * If mode is unsupported or there's still no p-state support then
-		 * fall back to favoring voltage.
+		 * If dml_disallow_alternate_prefetch_modes is false, then we have already
+		 * tried alternate prefetch modes during full validation.
+		 *
+		 * If mode is unsupported or there is no p-state support, then
+		 * fall back to favouring voltage.
 		 *
-		 * If Prefetch mode 0 failed for this config, or passed with Max UCLK, try if
-		 * supported with Prefetch mode 1 (dm_prefetch_support_fclk_and_stutter == 2)
+		 * If Prefetch mode 0 failed for this config, or passed with Max UCLK, then try
+		 * to support with Prefetch mode 1 (dm_prefetch_support_fclk_and_stutter == 2)
 		 */
 		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
-				dm_prefetch_support_fclk_and_stutter;
+			dm_prefetch_support_fclk_and_stutter;
 
 		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 
-- 
2.25.1

