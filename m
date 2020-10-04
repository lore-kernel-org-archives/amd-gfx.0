Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB47C4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22FB206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QOV43OrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22FB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666D589E03;
	Sun,  4 Oct 2020 17:19:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD66A89E03
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:19:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKFznELhXVO+7XDhwdMMwdNBJWQVsAc7LvCNMH4kqrbBTTHiLgCXMzRGQCxWakjaN7iMi6xO8S9uMVsBIbuYl4tSB0ZSZxQ9LLxYpbjNDz/JEpD1t3706isVt8hEcihZ2STpu1ZKTeoR7f/WbKUGi57LetUDOZ26CRkos+faGHKvpbtpkilMeqk977MUC8J28XcmCa6IuF7MUBXXC9yGuQw2AMDp1Lnmo+8QC/UjC7mO+Pq51JExPMIjcMcr4IWi2X/PWfMzSO6FfZGzAX37scDYUyL8IcME6E1y4k7HOhCZC27rUEImVuubWm6CM6AX1mdF7W4PNqarch3taL+OgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6exoDmSTADGdvhdrHz8a1DdMyEjxtcoSbB+y+Ohh30M=;
 b=cKmcQMwKoI5/TUySRHSCVbp5/yEV20EaOTRpngTlJyqevhzvqPuH7j766dvTdomVGIS2E2nRQHAh6vvNMLQaEV0jN2c3p3F40sjpPmA9xuJFw3FDu+QbLyhLtH+lnSmU3AYiLWx3cdlOd3q6ydOoad297SdN+Oq9C+fsvAwVSWSxatknmRwxROGGtiAm9ZGyAD9SCmXCcoTpdaIGpIntkgnzQSjfZ1c6cKw50kcZ15kui4/8V781h6SCzkjfGzqJTrOJSP1HMLyi0vp+J1LMtJfiWl2MPOQ1MAg6Nzy1JoMl+DcznIg5RcWovgPcaLp1bsJ0uYyJf+nLyPUna2fhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6exoDmSTADGdvhdrHz8a1DdMyEjxtcoSbB+y+Ohh30M=;
 b=QOV43OrQtUu62yKwALOi50izVW1L0y3kht1UE3R0A4eYmrC4+y3YCkMFQVWFVrLsYweqM07864lRwq/Ln1PP4XshOcmp6f1u5cip5C8NIOMIH1tL4TZmi6tyFNfYvovDXC1Vab0UO7Tl4oPyg6LfncBa9vPlHqk4E7ny2LfsfD0=
Received: from MWHPR1201CA0023.namprd12.prod.outlook.com
 (2603:10b6:301:4a::33) by CH2PR12MB3767.namprd12.prod.outlook.com
 (2603:10b6:610:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Sun, 4 Oct
 2020 17:19:25 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::7c) by MWHPR1201CA0023.outlook.office365.com
 (2603:10b6:301:4a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Sun, 4 Oct 2020 17:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:19:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:23 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:23 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:19:17 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/18] drm/amd/display: Force enable pstate on driver unload
Date: Sun, 4 Oct 2020 13:18:01 -0400
Message-ID: <20201004171813.7819-7-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 223cf71a-ce71-4736-c84b-08d86889a426
X-MS-TrafficTypeDiagnostic: CH2PR12MB3767:
X-Microsoft-Antispam-PRVS: <CH2PR12MB376706447D10AAA0B316C726E50F0@CH2PR12MB3767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4tj260rYn6IUVRiFDgWnJdG0D1QivXStwGqp+sYRJR1LzYU087FX8RMsrz9fQRJ2grD5C5DnRWZ6Tng0AQZcftHFBqvusbHuyqSyUgM46DtBAmqrfTqa/MgP55/twMQxnWYIMXMs7bQ1pHSnGisP+uWXJ/d/vDt6obP3mtRRc96QJjP1v01riNViG8xMBnIukvGHdep4LOuhLKW0XgkgbIfMcWdNcm7RhxMjCmdKswyxjVExGNyw92j0tvBPI3Pgyg3ZYKPzqVlk74Jy3PtHL5DCQT2MYEKtpK06u4zl/5tQ1+ljLQ9G3w2plZlX8NQUaZnrrUy+NzzqO2Rbvbup6ylL2dXZNAWH1DPaP1RlSrRfe/K926wIY0/mBX06kAM71GrqFzZGH/T54N+5GAdkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(376002)(136003)(396003)(46966005)(82310400003)(5660300002)(6666004)(2906002)(4326008)(86362001)(54906003)(356005)(316002)(70206006)(1076003)(336012)(70586007)(82740400003)(47076004)(426003)(2616005)(36756003)(478600001)(83380400001)(8936002)(26005)(186003)(8676002)(6916009)(44832011)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:19:24.4929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223cf71a-ce71-4736-c84b-08d86889a426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3767
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Eryk
 Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
During driver unload, it is expected that p-state switching is supported.
If it's not supported, PMFW will hang due to a forced p-state switch. Even
if the current timing does not support p-state normally, we still want to
force allow because the worst that can happen is underflow. This will
match Navi10 behaviour.

[How]
 - new hubbub func to control the force pstate register
 - force allow when releasing display ownership
   - registers are inaccessible after due to m_cgs.hwNotAvailable
 - explicitly disable force signal during hw_init
   - if driver is disabled and re-enabled, register not cleared otherwise

Also, remove DCN3 part of dcn10_init_hw, we will not be going back to it.

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c            |  7 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h                 |  3 +++
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c   |  6 ------
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h |  3 +++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c  | 13 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h  |  2 ++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h    |  4 ++++
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h   |  3 +++
 10 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 014d7571474e..8d96ef157987 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3097,4 +3097,11 @@ bool dc_is_plane_eligible_for_idle_optimizaitons(struct dc *dc,
 {
 	return false;
 }
+
+/* cleanup on driver unload */
+void dc_hardware_release(struct dc *dc)
+{
+	if (dc->hwss.hardware_release)
+		dc->hwss.hardware_release(dc);
+}
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3ea4be40050d..d893211977ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1267,6 +1267,9 @@ void dc_unlock_memory_clock_frequency(struct dc *dc);
  */
 void dc_lock_memory_clock_frequency(struct dc *dc);
 
+/* cleanup on driver unload */
+void dc_hardware_release(struct dc *dc);
+
 #endif
 
 bool dc_set_psr_allow_active(struct dc *dc, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 256185a22800..86a0d46ff2e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1434,12 +1434,6 @@ void dcn10_init_hw(struct dc *dc)
 
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
-
-#ifdef CONFIG_DRM_AMD_DC_DCN3_0
-	if (dc->clk_mgr->funcs->set_hard_max_memclk)
-		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
-#endif
-
 }
 
 /* In headless boot cases, DIG may be turned
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
index 982732dec133..2c68a246fa83 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
@@ -384,6 +384,16 @@ void hubbub3_force_wm_propagate_to_pipes(struct hubbub *hubbub)
 			DCHUBBUB_ARB_VM_ROW_URGENCY_WATERMARK_A, prog_wm_value);
 }
 
+void hubbub3_force_pstate_change_control(struct hubbub *hubbub,
+		bool force, bool allow)
+{
+	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+
+	REG_UPDATE_2(DCHUBBUB_ARB_DRAM_STATE_CNTL,
+			DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_VALUE, allow,
+			DCHUBBUB_ARB_ALLOW_PSTATE_CHANGE_FORCE_ENABLE, force);
+}
+
 static const struct hubbub_funcs hubbub30_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub3_init_dchub_sys_ctx,
@@ -397,6 +407,7 @@ static const struct hubbub_funcs hubbub30_funcs = {
 	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
 	.force_wm_propagate_to_pipes = hubbub3_force_wm_propagate_to_pipes,
+	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 };
 
 void hubbub3_construct(struct dcn20_hubbub *hubbub3,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
index 790baa00672b..38f1d2fd939b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
@@ -116,4 +116,7 @@ bool hubbub3_program_watermarks(
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 
+void hubbub3_force_pstate_change_control(struct hubbub *hubbub,
+		bool force, bool allow);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 204773ffc376..2ace13878aaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -622,6 +622,10 @@ void dcn30_init_hw(struct dc *dc)
 
 	if (dc->clk_mgr->funcs->set_hard_max_memclk)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
+
+	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
+		dc->res_pool->hubbub->funcs->force_pstate_change_control(
+				dc->res_pool->hubbub, false, false);
 }
 
 void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
@@ -711,3 +715,12 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 
 	return true;
 }
+
+void dcn30_hardware_release(struct dc *dc)
+{
+	/* if pstate unsupported, force it supported */
+	if (!dc->clk_mgr->clks.p_state_change_support &&
+			dc->res_pool->hubbub->funcs->force_pstate_change_control)
+		dc->res_pool->hubbub->funcs->force_pstate_change_control(
+				dc->res_pool->hubbub, true, true);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index a4989f5ac4e9..0ae047221afe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -67,4 +67,6 @@ void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx);
 
 bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable);
 
+void dcn30_hardware_release(struct dc *dc);
+
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 7c90c2222506..ae7a789bf6e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -93,6 +93,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.apply_idle_power_optimizations = dcn30_apply_idle_power_optimizations,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
+	.hardware_release = dcn30_hardware_release,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 65f182c8bf14..371da657c8a4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -152,6 +152,10 @@ struct hubbub_funcs {
 	void (*apply_DEDCN21_147_wa)(struct hubbub *hubbub);
 
 	void (*force_wm_propagate_to_pipes)(struct hubbub *hubbub);
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+
+	void (*force_pstate_change_control)(struct hubbub *hubbub, bool force, bool allow);
+#endif
 };
 
 struct hubbub {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index f48ee24d42f9..55c642950e91 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -50,6 +50,9 @@ struct dpp;
 struct dce_hwseq;
 
 struct hw_sequencer_funcs {
+#ifdef CONFIG_DRM_AMD_DC_DCN3_0
+	void (*hardware_release)(struct dc *dc);
+#endif
 	/* Embedded Display Related */
 	void (*edp_power_control)(struct dc_link *link, bool enable);
 	void (*edp_wait_for_hpd_ready)(struct dc_link *link, bool power_up);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
