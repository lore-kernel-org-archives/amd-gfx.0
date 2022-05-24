Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86609C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 17:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE60210F251;
	Tue, 24 May 2022 17:57:53 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D22610F251
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 17:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYWWyIl42/0IktpcuHyYgJNPIwM7dXAaUwU2puHeFOy5/5jx4K6/jRN1kigvX7w52MaFF9geTXQmjOjAPIbRhyfRZxar4Aco76HPWytYu5sXx+94wt2zg6bRUkIjwScLqwzyQxryFcppqEr8OiNvVtYiaGmZ3O1sJ7GVGV68QAO/OTLEhAHwugml+KKhI35UeGvcAjHb6o+bxcViMI4wF6LQsoIyDctIg+Nu0TbqtQUV3FKvxP702hzF4UlGIQSvZrdBMBH3PviXLNEANmU770G55wpT5qrjKuS3oVk1VWXu3inD3ykpuqn4swF+OWr2EirzsnyNjEId8RfTNCJnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2C12ldpMg39sgiVAnC9B+ViBEiBp4vEDjYwlgeGJyE=;
 b=R6RVRTJrc6s6oIuPcKBQUbLs6a+OkiAvdVbRLAabPA2isFbc8ZEYg7NsSkRlvuHspKkPxTt5VYQtR+qh8XAxE/J0qQcPnsUuMbj6TMRvYdtIBAtfAtnsocYna/tUxUKgGY2JoEYJb2DXmFElvEzoM9ayIs9jMpatbe/n6H22G+3HzS3MrgbSKT5PF2chr83QB27ECoBMCGS4A2saAfyjNdOFgeIqpxPV1mmCF1C3bRyrulfHsO3cxfZcO7YpsRKyNXUGjjnbAvKa7IdsQshnzFNoQCnu13WDPt3Ht5nMCqJDHjpyJOvdcNwwfp802q5tsKmAbR+7989O6TvdoOz66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2C12ldpMg39sgiVAnC9B+ViBEiBp4vEDjYwlgeGJyE=;
 b=vnPfoxTCVj99kAo6hRVBDsrxgVLZMCpZBKIKFLPasBRzZ819rOjOykysliNebvtmOUQBKJV53OvscoOsDPa/U7kJ+ginW1sqgOr7ySfEDSR+1N8u0vR6ZOhkyiJCM0Vqu+biC56IoZwRnAVcEBWuEO1nfABITCmW3EdpebnH8Tc=
Received: from BN6PR2001CA0005.namprd20.prod.outlook.com
 (2603:10b6:404:b4::15) by MWHPR12MB1215.namprd12.prod.outlook.com
 (2603:10b6:300:d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 17:57:49 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::a2) by BN6PR2001CA0005.outlook.office365.com
 (2603:10b6:404:b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23 via Frontend
 Transport; Tue, 24 May 2022 17:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:57:49 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 12:57:44 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amd/display: revert Blank eDP on disable/enable drv
Date: Tue, 24 May 2022 13:57:17 -0400
Message-ID: <20220524175724.126380-2-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524175724.126380-1-jdhillon@amd.com>
References: <20220524175724.126380-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40774d8a-d995-47d9-e4a2-08da3daeea86
X-MS-TrafficTypeDiagnostic: MWHPR12MB1215:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB121563EBE70920B6EA01A3D7FBD79@MWHPR12MB1215.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0szDW83klp7Rcs61PT3fHP8+7BEObitfc6qmdffrhJj8ZWq734N/S8QaxjrbH6jNgQsrKWXcomd+7wONrqIO2uU4YLpOOw5EJakAwTWYxAAgpAQLAmYKJKjxJB2eKNbQr40eVMNGlB1bFWfToBKw06d/UOMiUzQCKGz1wUL65j2iqosobRRyidTUZB2JdG1IYvhd1J79GwkecpP+Uajb9yAERxONpcDvX2TDRnmv8kV+r4pZXaYaElKrJqo7dxV/W2a+W0mKDdt81sGH2hxWi/x1h7X3hgsvphGwuGV/+LURLGBSrXmQeMHK7rWikB1fz8qG6TTZbWpMqkOdf3FSsToCRCAYkC8KQfg3+N8Av/BkhSokAFd/uC+PkF+39Tvsg0yO5LK2z7U+wGvcOembNbf9PrkRjDV1U+k1Mkbz3FztexBgFLFOCBqS/8OvZxN8VkoMUKfg6y8JBGErsYiTS4npzILdDWzsgm4IHO7qew0aEWId0NY2wUsiSS0MZW2JOE12OKVmJ8Bo+wT9VV8kRe5ywQFk17p0wE0GAkKzq7uPG81IwKzuTErCIubyO8Oyv9oRgtS3ljD5ODx/B1arAHsFFW+Dt0q24SLoKXsgijbehQRNv0/Ppvfd5rLAn1i3j+WCTFlXMrO9XfzwKN8YE9GBSsegURY3SKB90W0KxYXoNrtC2X/1E2UT0XRQuwLFNNjKWohqor0RDQ/x2xnyFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(81166007)(6916009)(36756003)(82310400005)(508600001)(356005)(83380400001)(40460700003)(36860700001)(316002)(16526019)(336012)(26005)(2616005)(1076003)(426003)(186003)(47076005)(6666004)(4326008)(8936002)(8676002)(70206006)(70586007)(5660300002)(30864003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:57:49.4034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40774d8a-d995-47d9-e4a2-08da3daeea86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1215
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
Cc: stylon.wang@amd.com, George Shen <George.Shen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

why and how:
This reverts commit 8e848b1b4ee585cbe25808b4458a74e739586034.
Was causing a black screen with certain blocks

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  8 +++++++-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  |  2 ++
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  5 +++--
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  4 ----
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  | 18 ++++++++++++------
 .../amd/display/dc/link/link_hwss_hpo_dp.c    | 19 ++++++++++++++-----
 9 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index ceb34376decb..051322580014 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -638,8 +638,14 @@ static void dcn31_set_low_power_state(struct clk_mgr *clk_mgr_base)
 	}
 }
 
+int dcn31_get_dtb_ref_freq_khz(struct clk_mgr *clk_mgr_base)
+{
+	return clk_mgr_base->clks.ref_dtbclk_khz;
+}
+
 static struct clk_mgr_funcs dcn31_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn31_update_clocks,
 	.init_clocks = dcn31_init_clocks,
 	.enable_pme_wa = dcn31_enable_pme_wa,
@@ -719,7 +725,7 @@ void dcn31_clk_mgr_construct(
 	}
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
-	clk_mgr->base.dccg->ref_dtbclk_khz = 600000;
+	clk_mgr->base.base.clks.ref_dtbclk_khz = 600000;
 	dce_clock_read_ss_info(&clk_mgr->base);
 	/*if bios enabled SS, driver needs to adjust dtb clock, only enable with correct bios*/
 	//clk_mgr->base.dccg->ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(clk_mgr_internal, clk_mgr->base.base.dprefclk_khz);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h
index 961b10a49486..be06fdbd0c22 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h
@@ -51,6 +51,8 @@ void dcn31_clk_mgr_construct(struct dc_context *ctx,
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg);
 
+int dcn31_get_dtb_ref_freq_khz(struct clk_mgr *clk_mgr_base);
+
 void dcn31_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int);
 
 #endif //__DCN31_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index a2ade6e93f5e..29a3bf57b157 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -580,6 +580,7 @@ static void dcn315_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 
 static struct clk_mgr_funcs dcn315_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn315_update_clocks,
 	.init_clocks = dcn31_init_clocks,
 	.enable_pme_wa = dcn315_enable_pme_wa,
@@ -656,9 +657,9 @@ void dcn315_clk_mgr_construct(
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.dprefclk_khz = dcn315_smu_get_dpref_clk(&clk_mgr->base);
-	clk_mgr->base.dccg->ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
+	clk_mgr->base.base.clks.ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
 	dce_clock_read_ss_info(&clk_mgr->base);
-	clk_mgr->base.dccg->ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
+	clk_mgr->base.base.clks.ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn315_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index fc3af81ed6c6..ab0f772ae25d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -571,6 +571,7 @@ static void dcn316_clk_mgr_helper_populate_bw_params(
 static struct clk_mgr_funcs dcn316_funcs = {
 	.enable_pme_wa = dcn316_enable_pme_wa,
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn316_update_clocks,
 	.init_clocks = dcn31_init_clocks,
 	.are_clock_states_equal = dcn31_are_clock_states_equal,
@@ -685,7 +686,7 @@ void dcn316_clk_mgr_construct(
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.dprefclk_khz = dcn316_smu_get_dpref_clk(&clk_mgr->base);
- 	clk_mgr->base.dccg->ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
+ 	clk_mgr->base.base.clks.ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
 	dce_clock_read_ss_info(&clk_mgr->base);
 	/*clk_mgr->base.dccg->ref_dtbclk_khz =
 	dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);*/
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a31ea3644ec2..1c54628de0ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -416,6 +416,7 @@ struct dc_clocks {
 	bool p_state_change_support;
 	enum dcn_zstate_support_state zstate_support;
 	bool dtbclk_en;
+	int ref_dtbclk_khz;
 	enum dcn_pwr_state pwr_state;
 	/*
 	 * Elements below are not compared for the purposes of
@@ -719,6 +720,8 @@ struct dc_debug_options {
 	bool apply_vendor_specific_lttpr_wa;
 	bool extended_blank_optimization;
 	union aux_wake_wa_options aux_wake_wa;
+	/* uses value at boot and disables switch */
+	bool disable_dtb_ref_clk_switch;
 	uint8_t psr_power_use_phy_fsm;
 	enum dml_hostvm_override_opts dml_hostvm_override;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 287a1066b547..616013c618a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -606,16 +606,12 @@ void dccg31_set_audio_dtbclk_dto(
 
 		REG_UPDATE(DCCG_AUDIO_DTO_SOURCE,
 				DCCG_AUDIO_DTO_SEL, 4);  //  04 - DCCG_AUDIO_DTO_SEL_AUDIO_DTO_DTBCLK
-
-		dccg->audio_dtbclk_khz = req_audio_dtbclk_khz;
 	} else {
 		REG_WRITE(DCCG_AUDIO_DTBCLK_DTO_PHASE, 0);
 		REG_WRITE(DCCG_AUDIO_DTBCLK_DTO_MODULO, 0);
 
 		REG_UPDATE(DCCG_AUDIO_DTO_SOURCE,
 				DCCG_AUDIO_DTO_SEL, 3);  //  03 - DCCG_AUDIO_DTO_SEL_NO_AUDIO_DTO
-
-		dccg->audio_dtbclk_khz = 0;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index 46ce5a0ee4ec..b5570aa8e39d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -237,6 +237,7 @@ struct clk_mgr_funcs {
 			bool safe_to_lower);
 
 	int (*get_dp_ref_clk_frequency)(struct clk_mgr *clk_mgr);
+	int (*get_dtb_ref_clk_frequency)(struct clk_mgr *clk_mgr);
 
 	void (*set_low_power_state)(struct clk_mgr *clk_mgr);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index b2fa4de47734..cc358a5ba537 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -60,8 +60,17 @@ struct dccg {
 	const struct dccg_funcs *funcs;
 	int pipe_dppclk_khz[MAX_PIPES];
 	int ref_dppclk;
-	int dtbclk_khz[MAX_PIPES];
-	int audio_dtbclk_khz;
+	//int dtbclk_khz[MAX_PIPES];/* TODO needs to be removed */
+	//int audio_dtbclk_khz;/* TODO needs to be removed */
+	//int ref_dtbclk_khz;/* TODO needs to be removed */
+};
+
+struct dtbclk_dto_params {
+	const struct dc_crtc_timing *timing;
+	int otg_inst;
+	int pixclk_khz;
+	int req_audio_dtbclk_khz;
+	int num_odm_segments;
 	int ref_dtbclk_khz;
 };
 
@@ -111,10 +120,7 @@ struct dccg_funcs {
 
 	void (*set_dtbclk_dto)(
 			struct dccg *dccg,
-			int dtbclk_inst,
-			int req_dtbclk_khz,
-			int num_odm_segments,
-			const struct dc_crtc_timing *timing);
+			const struct dtbclk_dto_params *params);
 
 	void (*set_audio_dtbclk_dto)(
 			struct dccg *dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
index 87972dc8443d..ea6cf8bfce30 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
@@ -27,6 +27,7 @@
 #include "core_types.h"
 #include "dccg.h"
 #include "dc_link_dp.h"
+#include "clk_mgr.h"
 
 static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
 {
@@ -106,14 +107,18 @@ static void setup_hpo_dp_stream_encoder(struct pipe_ctx *pipe_ctx)
 	struct hpo_dp_link_encoder *link_enc = pipe_ctx->link_res.hpo_dp_link_enc;
 	struct dccg *dccg = dc->res_pool->dccg;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
-	int odm_segment_count = get_odm_segment_count(pipe_ctx);
+	struct dtbclk_dto_params dto_params = {0};
 	enum phyd32clk_clock_source phyd32clk = get_phyd32clk_src(pipe_ctx->stream->link);
 
+	dto_params.otg_inst = tg->inst;
+	dto_params.pixclk_khz = pipe_ctx->stream->phy_pix_clk;
+	dto_params.num_odm_segments = get_odm_segment_count(pipe_ctx);
+	dto_params.timing = &pipe_ctx->stream->timing;
+	dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
+
 	dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst);
 	dccg->funcs->enable_symclk32_se(dccg, stream_enc->inst, phyd32clk);
-	dccg->funcs->set_dtbclk_dto(dccg, tg->inst, pipe_ctx->stream->phy_pix_clk,
-			odm_segment_count,
-			&pipe_ctx->stream->timing);
+	dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 	stream_enc->funcs->enable_stream(stream_enc);
 	stream_enc->funcs->map_stream_to_link(stream_enc, stream_enc->inst, link_enc->inst);
 }
@@ -124,9 +129,13 @@ static void reset_hpo_dp_stream_encoder(struct pipe_ctx *pipe_ctx)
 	struct hpo_dp_stream_encoder *stream_enc = pipe_ctx->stream_res.hpo_dp_stream_enc;
 	struct dccg *dccg = dc->res_pool->dccg;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+	struct dtbclk_dto_params dto_params = {0};
+
+	dto_params.otg_inst = tg->inst;
+	dto_params.timing = &pipe_ctx->stream->timing;
 
 	stream_enc->funcs->disable(stream_enc);
-	dccg->funcs->set_dtbclk_dto(dccg, tg->inst, 0, 0, &pipe_ctx->stream->timing);
+	dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 	dccg->funcs->disable_symclk32_se(dccg, stream_enc->inst);
 	dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst);
 }
-- 
2.25.1

