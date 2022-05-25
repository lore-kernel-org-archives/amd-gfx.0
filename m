Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E266C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2152510F9F5;
	Wed, 25 May 2022 16:20:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82FF010F2D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfCNeq+sCVRgc6qrchPafBncAFhXeJYP7VkLwGC28pEhva99SjfhGOTXgdJRtujeLgUw7935Lrh8y3IdL6iawUFrykn/OzN+UVQRFRalFtrgDi1+4XhKSUYvuEkzubgvkxU7/QLBSXy8GJ2d6ssbWPE0U5dRbdZNiHnlBdqEeSKBYuP7DCrO4SXuW1FlzNZmHv/6Z+6FnHvi3DSBoHVkWMgFOBVO79TOHdx+Cq+CH5iwUUb4Ls8X4en6p0wMRByPFRVXsLSd4VkhQuE/ZMiHX0u9eYDdX+kfRiQCaxiedjRBakA+57cEjpAc3ja1gq9Fh9wIMHTr6pG3LmSxN5wnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZGJifFd+1WGddeFgQxwo2U9+K53cLyHtYEkRfbdRtU=;
 b=De7DgJXnTJQyRU7kL5dgihYC0wj3XpbqqOI++Ck0GSD8VZByp+wKyhV3YyU6+CtAVgeb+xNvxtRioyY0JIJGd0VwbAoGVEA+8aXT64VUHVUQnBHRLr9sHBGf5JVSJNgl/krO9rNn3vfDvxRRb+tfzVSHJM9xPhdpveuVw/fs+oX6wCulwmc9HaAldCndsJzPlJGsJPOMeVyfTVzGJjR6fhgAsh51LXC/lsKHP4uOCd3h0M2LTmcPyp9cVYYLo7hsOqd8xqkzFBCXJzkn5ScgL+ckfLTE+LEKtodB9UpGZv8mnwSjDK4o4s/kw3ib7XMdm1Rhi/eyjngK/sLntkJ1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZGJifFd+1WGddeFgQxwo2U9+K53cLyHtYEkRfbdRtU=;
 b=qUF+Q3zS47hkjRnjOKf/VcdyN1CYb3PVgxqVApnYytZc4VWbM7qGx6tBzMKwq5JSBDZVoDobYQgfcVUDNBTBy+9TeT10aw/dDdRmDfJyWM1+/BgHOohr1rYphSiADAsDOItuKuAvN1h6JStzkT+5xwj8EczIcJWW99ALTdooW24=
Received: from DM6PR06CA0078.namprd06.prod.outlook.com (2603:10b6:5:336::11)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Wed, 25 May
 2022 16:20:28 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::c8) by DM6PR06CA0078.outlook.office365.com
 (2603:10b6:5:336::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19 via Frontend
 Transport; Wed, 25 May 2022 16:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 41/43] drm/amd/display: Implement DTBCLK ref switching on dcn32
Date: Wed, 25 May 2022 12:19:39 -0400
Message-ID: <20220525161941.2544055-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d14dd25f-66e8-42a7-e328-08da3e6a7b6a
X-MS-TrafficTypeDiagnostic: PH0PR12MB5646:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5646FD671F59AD3ECE8F4234F7D69@PH0PR12MB5646.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LhbRZBke4AsMdD21R4tehq8WLSdEHa7eJpc3f8SBguvljCX9CYfmNuar33KAhVQR47pobF0Q92f9MIm+R1KFpIhPVgFtzALPw9xf86B/JQ/nq2Nhyy545OcQK/18V01suOi5vXweNzU6xQQ1epyAb2lwvQxxGUmMbtocwp+yehrdNddLXA9NuEK8jVwZPTUz72bPHYBbM7fm2klaA8pxVa8vNqaWzdR5CIA3TglEtiWVKVtSygTD8j9yvv5HAiaLNSOldV/KaSYSfr3f3/2AvkDDhvbSRn8sKuwx7yJdIPW/qghHc1X+85g/SkarEBsdL8tXMMPbrAeRADF6j4fPmWLkP5DtJLyMXM0IaMhS17wJKsDpBHTVJpRsZalvQbs1t9mw2Oa91ApV0OvRl3+bdO0enjqWd95bdwdROLMSHaRYjVdlV3aW7JMJS2oPzk3+Spr7dTG3IP2oSm1D3mm2iUthavxMeC6G2IFjpNN83lqFrkFfNz2FtRGmFju/hy5c2VgLOcr6MfyACLTMuhrrY0lIam3KsWmCJsCkcBVB2VpBrKuCJvH3yUq2WB6SYbLoep96inXU7I9mZu53V6lIcP92arJZ9HbhrQrhm/9r/V6cHLhciBIspB0OK6BqVPtBAYxWmfS6lQYUiRDrrjfk4REgAXx/FeHtxjbA5t7I7+3RW6Jzcx5eBHqp6mtBt3DzuSYgLaWXYA6qMZkTl3y9Nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(2616005)(82310400005)(83380400001)(2906002)(1076003)(356005)(26005)(6916009)(54906003)(47076005)(36756003)(316002)(426003)(336012)(36860700001)(30864003)(6666004)(4326008)(8936002)(186003)(16526019)(70206006)(7696005)(8676002)(40460700003)(70586007)(86362001)(508600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:28.3310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d14dd25f-66e8-42a7-e328-08da3e6a7b6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[WHY & HOW]
Implements DTB ref clock switching with reg key default to OFF.
Refactors dccg DTBCLK logic to not store redundant state information
dccg. Also removes duplicated functions that should be inherited from
other dcn versions.

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  8 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  |  2 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  5 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  3 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 87 +++++++++++++++----
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  | 18 ++++
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  |  1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  6 ++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 79 ++++++++---------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |  2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c | 52 +++++------
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 12 ++-
 .../amd/display/dc/dcn321/dcn321_resource.c   | 11 ++-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  | 21 +++--
 .../amd/display/dc/link/link_hwss_hpo_dp.c    | 19 ++--
 17 files changed, 221 insertions(+), 109 deletions(-)

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
index ff8f60f38b21..fb4ae800e919 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -578,6 +578,7 @@ static void dcn315_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 
 static struct clk_mgr_funcs dcn315_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 	.update_clocks = dcn315_update_clocks,
 	.init_clocks = dcn31_init_clocks,
 	.enable_pme_wa = dcn315_enable_pme_wa,
@@ -654,9 +655,9 @@ void dcn315_clk_mgr_construct(
 
 	clk_mgr->base.base.dprefclk_khz = 600000;
 	clk_mgr->base.base.dprefclk_khz = dcn315_smu_get_dpref_clk(&clk_mgr->base);
-	clk_mgr->base.dccg->ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
+	clk_mgr->base.base.clks.ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
 	dce_clock_read_ss_info(&clk_mgr->base);
-	clk_mgr->base.dccg->ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
+	clk_mgr->base.base.clks.ref_dtbclk_khz = dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);
 
 	clk_mgr->base.base.bw_params = &dcn315_bw_params;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index fc3af81ed6c6..e4bb9c6193b5 100644
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
+	clk_mgr->base.base.clks.ref_dtbclk_khz = clk_mgr->base.base.dprefclk_khz;
 	dce_clock_read_ss_info(&clk_mgr->base);
 	/*clk_mgr->base.dccg->ref_dtbclk_khz =
 	dce_adjust_dp_ref_freq_for_ss(&clk_mgr->base, clk_mgr->base.base.dprefclk_khz);*/
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 6a1d7c86e6b7..1db61029481b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -29,9 +29,11 @@
 #include "dcn32/dcn32_clk_mgr_smu_msg.h"
 #include "dcn20/dcn20_clk_mgr.h"
 #include "dce100/dce_clk_mgr.h"
+#include "dcn31/dcn31_clk_mgr.h"
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
+#include "dc_link_dp.h"
 
 #include "atomfirmware.h"
 #include "smu13_driver_if.h"
@@ -253,9 +255,10 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 					&clk_mgr_base->bw_params->clk_table.entries[0].socclk_mhz,
 					&num_levels);
 	/* DTBCLK */
-	dcn32_init_single_clock(clk_mgr, PPCLK_DTBCLK,
-			&clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz,
-			&num_levels);
+	if (!clk_mgr->base.ctx->dc->debug.disable_dtb_ref_clk_switch)
+		dcn32_init_single_clock(clk_mgr, PPCLK_DTBCLK,
+				&clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz,
+				&num_levels);
 
 	/* DISPCLK */
 	dcn32_init_single_clock(clk_mgr, PPCLK_DISPCLK,
@@ -270,6 +273,39 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	dcn32_build_wm_range_table(clk_mgr);
 }
 
+static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
+			struct dc_state *context,
+			int ref_dtbclk_khz)
+{
+	struct dccg *dccg = clk_mgr->dccg;
+	uint32_t tg_mask = 0;
+	int i;
+
+	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+		struct dtbclk_dto_params dto_params = {0};
+
+		/* use mask to program DTO once per tg */
+		if (pipe_ctx->stream_res.tg &&
+				!(tg_mask & (1 << pipe_ctx->stream_res.tg->inst))) {
+			tg_mask |= (1 << pipe_ctx->stream_res.tg->inst);
+
+			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
+			dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
+
+			if (is_dp_128b_132b_signal(pipe_ctx)) {
+				dto_params.pixclk_khz = pipe_ctx->stream->phy_pix_clk;
+
+				if (pipe_ctx->stream_res.audio != NULL)
+					dto_params.req_audio_dtbclk_khz = 24000;
+			}
+
+			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
+			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
+		}
+	}
+}
+
 static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -320,7 +356,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 
 		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 			clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
-			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCFCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
+			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCFCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
 		}
 
 		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
@@ -350,7 +386,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 
 			/* to disable P-State switching, set UCLK min = max */
 			if (!clk_mgr_base->clks.p_state_change_support)
-				dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 						clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
 		}
 
@@ -379,7 +415,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
 		if (clk_mgr_base->clks.p_state_change_support &&
 				(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support))
-			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 
 		if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 && clk_mgr_base->clks.fclk_p_state_change_support && update_fclk) {
 			/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
@@ -400,7 +436,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
 
 		if (clk_mgr->smu_present)
-			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
+			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
 
 		update_dppclk = true;
 	}
@@ -409,11 +445,25 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 
 		if (clk_mgr->smu_present)
-			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dispclk_khz));
+			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dispclk_khz));
 
 		update_dispclk = true;
 	}
 
+	if (!new_clocks->dtbclk_en) {
+		new_clocks->ref_dtbclk_khz = 0;
+	}
+
+	/* clock limits are received with MHz precision, divide by 1000 to prevent setting clocks at every call */
+	if (!dc->debug.disable_dtb_ref_clk_switch &&
+			should_set_clock(safe_to_lower, new_clocks->ref_dtbclk_khz / 1000, clk_mgr_base->clks.ref_dtbclk_khz / 1000)) {
+		/* DCCG requires KHz precision for DTBCLK */
+		clk_mgr_base->clks.ref_dtbclk_khz =
+				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DTBCLK, khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz));
+
+		dcn32_update_clocks_update_dtb_dto(clk_mgr, context, clk_mgr_base->clks.ref_dtbclk_khz);
+	}
+
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
 		if (dpp_clock_lowered) {
 			/* if clock is being lowered, increase DTO before lowering refclk */
@@ -502,13 +552,13 @@ static void dcn32_set_hard_min_memclk(struct clk_mgr *clk_mgr_base, bool current
 
 	if (current_mode) {
 		if (clk_mgr_base->clks.p_state_change_support)
-			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 					khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
 		else
-			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
 	} else {
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
 				clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz);
 	}
 }
@@ -584,7 +634,7 @@ static bool dcn32_is_smu_present(struct clk_mgr *clk_mgr_base)
 
 
 static struct clk_mgr_funcs dcn32_funcs = {
-		.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
+		.get_dp_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
 		.update_clocks = dcn32_update_clocks,
 		.init_clocks = dcn32_init_clocks,
 		.notify_wm_ranges = dcn32_notify_wm_ranges,
@@ -627,7 +677,13 @@ void dcn32_clk_mgr_construct(
 	 * dprefclk DID divider
 	 */
 	clk_mgr->base.dprefclk_khz = 716666;
-	clk_mgr->dccg->ref_dtbclk_khz = 268750;
+	if (ctx->dc->debug.disable_dtb_ref_clk_switch) {
+		//initialize DTB ref clock value if DPM disabled
+		if (ctx->dce_version == DCN_VERSION_3_21)
+			clk_mgr->base.clks.ref_dtbclk_khz = 477800;
+		else
+			clk_mgr->base.clks.ref_dtbclk_khz = 268750;
+	}
 
 	/* integer part is now VCO frequency in kHz */
 	clk_mgr->base.dentist_vco_freq_khz = 4300000;//dcn32_get_vco_frequency_from_reg(clk_mgr);
@@ -635,8 +691,9 @@ void dcn32_clk_mgr_construct(
 	if (clk_mgr->base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.dentist_vco_freq_khz = 4300000; /* Updated as per HW docs */
 
-	if (clk_mgr->dccg->ref_dtbclk_khz != clk_mgr->base.boot_snapshot.dtbclk) {
-		clk_mgr->dccg->ref_dtbclk_khz = clk_mgr->base.boot_snapshot.dtbclk;
+	if (ctx->dc->debug.disable_dtb_ref_clk_switch &&
+			clk_mgr->base.clks.ref_dtbclk_khz != clk_mgr->base.boot_snapshot.dtbclk) {
+		clk_mgr->base.clks.ref_dtbclk_khz = clk_mgr->base.boot_snapshot.dtbclk;
 	}
 
 	if (clk_mgr->base.boot_snapshot.dprefclk != 0) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
index 95ab268e9179..d7c99e9179be 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
@@ -114,3 +114,21 @@ void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr)
 	dcn32_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_TransferTableDram2Smu, TABLE_WATERMARKS, NULL);
 }
+
+/* Returns the actual frequency that was set in MHz, 0 on failure */
+unsigned int dcn32_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz)
+{
+	uint32_t response = 0;
+
+	/* bits 23:16 for clock type, lower 16 bits for frequency in MHz */
+	uint32_t param = (clk << 16) | freq_mhz;
+
+	smu_print("SMU Set hard min by freq: clk = %d, freq_mhz = %d MHz\n", clk, freq_mhz);
+
+	dcn32_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_SetHardMinByFreq, param, &response);
+
+	smu_print("SMU Frequency set = %d KHz\n", response);
+
+	return response;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
index 5f69cdcb9885..352435edbd79 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
@@ -41,5 +41,6 @@ dcn32_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool enable
 void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
 void dcn32_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsigned int num_ways);
 void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
+unsigned int dcn32_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz);
 
 #endif /* __DCN32_CLK_MGR_SMU_MSG_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e25e91bfe763..01e12b0b7c40 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -430,6 +430,7 @@ struct dc_clocks {
 	bool p_state_change_support;
 	enum dcn_zstate_support_state zstate_support;
 	bool dtbclk_en;
+	int ref_dtbclk_khz;
 	bool fclk_p_state_change_support;
 	enum dcn_pwr_state pwr_state;
 	/*
@@ -737,6 +738,8 @@ struct dc_debug_options {
 	bool force_disable_subvp;
 	bool force_subvp_mclk_switch;
 	bool force_usr_allow;
+	/* uses value at boot and disables switch */
+	bool disable_dtb_ref_clk_switch;
 	bool apply_vendor_specific_lttpr_wa;
 	bool extended_blank_optimization;
 	union aux_wake_wa_options aux_wake_wa;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 7eff7811769d..28a7be5d2370 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2181,6 +2181,8 @@ static void dce110_setup_audio_dto(
 			build_audio_output(context, pipe_ctx, &audio_output);
 
 			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
+				struct dtbclk_dto_params dto_params = {0};
+				dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
 				/* disable audio DTBCLK DTO */
 				dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
 					dc->res_pool->dccg, 0);
@@ -2190,6 +2192,10 @@ static void dce110_setup_audio_dto(
 						pipe_ctx->stream->signal,
 						&audio_output.crtc_info,
 						&audio_output.pll_info);
+
+				dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
+					dc->res_pool->dccg,
+					&dto_params);
 			} else
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 20f11fb8f5a6..8eeb3b69b5b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -512,13 +512,10 @@ void dccg31_set_physymclk(
 /* Controls the generation of pixel valid for OTG in (OTG -> HPO case) */
 static void dccg31_set_dtbclk_dto(
 		struct dccg *dccg,
-		int otg_inst,
-		int pixclk_khz,
-		int num_odm_segments,
-		const struct dc_crtc_timing *timing)
+		const struct dtbclk_dto_params *params)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
-	int req_dtbclk_khz = pixclk_khz;
+	int req_dtbclk_khz = params->pixclk_khz;
 	uint32_t dtbdto_div;
 
 	/* Mode	                DTBDTO Rate       DTBCLK_DTO<x>_DIV Register
@@ -529,73 +526,69 @@ static void dccg31_set_dtbclk_dto(
 	 * DSC native 4:2:2     pixel rate/2      4
 	 * Other modes          pixel rate        8
 	 */
-	if (num_odm_segments == 4) {
+	if (params->num_odm_segments == 4) {
 		dtbdto_div = 2;
-		req_dtbclk_khz = pixclk_khz / 4;
-	} else if ((num_odm_segments == 2) ||
-			(timing->pixel_encoding == PIXEL_ENCODING_YCBCR420) ||
-			(timing->flags.DSC && timing->pixel_encoding == PIXEL_ENCODING_YCBCR422
-					&& !timing->dsc_cfg.ycbcr422_simple)) {
+		req_dtbclk_khz = params->pixclk_khz / 4;
+	} else if ((params->num_odm_segments == 2) ||
+			(params->timing->pixel_encoding == PIXEL_ENCODING_YCBCR420) ||
+			(params->timing->flags.DSC && params->timing->pixel_encoding == PIXEL_ENCODING_YCBCR422
+					&& !params->timing->dsc_cfg.ycbcr422_simple)) {
 		dtbdto_div = 4;
-		req_dtbclk_khz = pixclk_khz / 2;
+		req_dtbclk_khz = params->pixclk_khz / 2;
 	} else
 		dtbdto_div = 8;
 
-	if (dccg->ref_dtbclk_khz && req_dtbclk_khz) {
+	if (params->ref_dtbclk_khz && req_dtbclk_khz) {
 		uint32_t modulo, phase;
 
 		// phase / modulo = dtbclk / dtbclk ref
-		modulo = dccg->ref_dtbclk_khz * 1000;
-		phase = div_u64((((unsigned long long)modulo * req_dtbclk_khz) + dccg->ref_dtbclk_khz - 1),
-			dccg->ref_dtbclk_khz);
+		modulo = params->ref_dtbclk_khz * 1000;
+		phase = div_u64((((unsigned long long)modulo * req_dtbclk_khz) + params->ref_dtbclk_khz - 1),
+				params->ref_dtbclk_khz);
 
-		REG_UPDATE(OTG_PIXEL_RATE_CNTL[otg_inst],
-				DTBCLK_DTO_DIV[otg_inst], dtbdto_div);
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_DIV[params->otg_inst], dtbdto_div);
 
-		REG_WRITE(DTBCLK_DTO_MODULO[otg_inst], modulo);
-		REG_WRITE(DTBCLK_DTO_PHASE[otg_inst], phase);
+		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], modulo);
+		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], phase);
 
-		REG_UPDATE(OTG_PIXEL_RATE_CNTL[otg_inst],
-				DTBCLK_DTO_ENABLE[otg_inst], 1);
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_ENABLE[params->otg_inst], 1);
 
-		REG_WAIT(OTG_PIXEL_RATE_CNTL[otg_inst],
-				DTBCLKDTO_ENABLE_STATUS[otg_inst], 1,
+		REG_WAIT(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLKDTO_ENABLE_STATUS[params->otg_inst], 1,
 				1, 100);
 
 		/* The recommended programming sequence to enable DTBCLK DTO to generate
 		 * valid pixel HPO DPSTREAM ENCODER, specifies that DTO source select should
 		 * be set only after DTO is enabled
 		 */
-		REG_UPDATE(OTG_PIXEL_RATE_CNTL[otg_inst],
-				PIPE_DTO_SRC_SEL[otg_inst], 1);
-
-		dccg->dtbclk_khz[otg_inst] = req_dtbclk_khz;
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				PIPE_DTO_SRC_SEL[params->otg_inst], 1);
 	} else {
-		REG_UPDATE_3(OTG_PIXEL_RATE_CNTL[otg_inst],
-				DTBCLK_DTO_ENABLE[otg_inst], 0,
-				PIPE_DTO_SRC_SEL[otg_inst], 0,
-				DTBCLK_DTO_DIV[otg_inst], dtbdto_div);
-
-		REG_WRITE(DTBCLK_DTO_MODULO[otg_inst], 0);
-		REG_WRITE(DTBCLK_DTO_PHASE[otg_inst], 0);
+		REG_UPDATE_3(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_ENABLE[params->otg_inst], 0,
+				PIPE_DTO_SRC_SEL[params->otg_inst], 0,
+				DTBCLK_DTO_DIV[params->otg_inst], dtbdto_div);
 
-		dccg->dtbclk_khz[otg_inst] = 0;
+		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
+		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
 	}
 }
 
 void dccg31_set_audio_dtbclk_dto(
 		struct dccg *dccg,
-		uint32_t req_audio_dtbclk_khz)
+		const struct dtbclk_dto_params *params)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (dccg->ref_dtbclk_khz && req_audio_dtbclk_khz) {
+	if (params->ref_dtbclk_khz && params->req_audio_dtbclk_khz) {
 		uint32_t modulo, phase;
 
 		// phase / modulo = dtbclk / dtbclk ref
-		modulo = dccg->ref_dtbclk_khz * 1000;
-		phase = div_u64((((unsigned long long)modulo * req_audio_dtbclk_khz) + dccg->ref_dtbclk_khz - 1),
-			dccg->ref_dtbclk_khz);
+		modulo = params->ref_dtbclk_khz * 1000;
+		phase = div_u64((((unsigned long long)modulo * params->req_audio_dtbclk_khz) + params->ref_dtbclk_khz - 1),
+			params->ref_dtbclk_khz);
 
 
 		REG_WRITE(DCCG_AUDIO_DTBCLK_DTO_MODULO, modulo);
@@ -606,16 +599,12 @@ void dccg31_set_audio_dtbclk_dto(
 
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
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
index f31cced5f441..80bd80707991 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h
@@ -192,6 +192,6 @@ void dccg31_set_physymclk(
 
 void dccg31_set_audio_dtbclk_dto(
 		struct dccg *dccg,
-		uint32_t req_audio_dtbclk_khz);
+		const struct dtbclk_dto_params *params);
 
 #endif //__DCN31_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 828a72c0720c..08232d05d894 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -135,61 +135,61 @@ static void dccg32_set_dtbclk_p_src(
 /* Controls the generation of pixel valid for OTG in (OTG -> HPO case) */
 void dccg32_set_dtbclk_dto(
 		struct dccg *dccg,
-		int otg_inst,
-		int pixclk_khz,
-		int num_odm_segments,
-		const struct dc_crtc_timing *timing)
+		const struct dtbclk_dto_params *params)
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 	/* DTO Output Rate / Pixel Rate = 1/4 */
-	int req_dtbclk_khz = pixclk_khz / 4;
+	int req_dtbclk_khz = params->pixclk_khz / 4;
 
-	if (dccg->ref_dtbclk_khz && req_dtbclk_khz) {
+	if (params->ref_dtbclk_khz && req_dtbclk_khz) {
 		uint32_t modulo, phase;
 
 		// phase / modulo = dtbclk / dtbclk ref
-		modulo = dccg->ref_dtbclk_khz * 1000;
+		modulo = params->ref_dtbclk_khz * 1000;
 		phase = req_dtbclk_khz * 1000;
 
-		REG_WRITE(DTBCLK_DTO_MODULO[otg_inst], modulo);
-		REG_WRITE(DTBCLK_DTO_PHASE[otg_inst], phase);
+		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], modulo);
+		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], phase);
 
-		REG_UPDATE(OTG_PIXEL_RATE_CNTL[otg_inst],
-				DTBCLK_DTO_ENABLE[otg_inst], 1);
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_ENABLE[params->otg_inst], 1);
 
-		REG_WAIT(OTG_PIXEL_RATE_CNTL[otg_inst],
-				DTBCLKDTO_ENABLE_STATUS[otg_inst], 1,
+		REG_WAIT(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLKDTO_ENABLE_STATUS[params->otg_inst], 1,
 				1, 100);
 
 		/* program OTG_PIXEL_RATE_DIV for DIVK1 and DIVK2 fields */
-		dccg32_set_pixel_rate_div(dccg, otg_inst, PIXEL_RATE_DIV_BY_1, PIXEL_RATE_DIV_BY_1);
+		dccg32_set_pixel_rate_div(dccg, params->otg_inst, PIXEL_RATE_DIV_BY_1, PIXEL_RATE_DIV_BY_1);
 
 		/* The recommended programming sequence to enable DTBCLK DTO to generate
 		 * valid pixel HPO DPSTREAM ENCODER, specifies that DTO source select should
 		 * be set only after DTO is enabled
 		 */
-		REG_UPDATE(OTG_PIXEL_RATE_CNTL[otg_inst],
-				PIPE_DTO_SRC_SEL[otg_inst], 2);
-
-		dccg->dtbclk_khz[otg_inst] = req_dtbclk_khz;
+		REG_UPDATE(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				PIPE_DTO_SRC_SEL[params->otg_inst], 2);
 	} else {
-		REG_UPDATE_2(OTG_PIXEL_RATE_CNTL[otg_inst],
-				DTBCLK_DTO_ENABLE[otg_inst], 0,
-				PIPE_DTO_SRC_SEL[otg_inst], 1);
-
-		REG_WRITE(DTBCLK_DTO_MODULO[otg_inst], 0);
-		REG_WRITE(DTBCLK_DTO_PHASE[otg_inst], 0);
+		REG_UPDATE_2(OTG_PIXEL_RATE_CNTL[params->otg_inst],
+				DTBCLK_DTO_ENABLE[params->otg_inst], 0,
+				PIPE_DTO_SRC_SEL[params->otg_inst], 1);
 
-		dccg->dtbclk_khz[otg_inst] = 0;
+		REG_WRITE(DTBCLK_DTO_MODULO[params->otg_inst], 0);
+		REG_WRITE(DTBCLK_DTO_PHASE[params->otg_inst], 0);
 	}
 }
 
 void dccg32_set_valid_pixel_rate(
 		struct dccg *dccg,
+		int ref_dtbclk_khz,
 		int otg_inst,
 		int pixclk_khz)
 {
-	dccg32_set_dtbclk_dto(dccg, otg_inst, pixclk_khz, 0, NULL);
+	struct dtbclk_dto_params dto_params = {0};
+
+	dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
+	dto_params.otg_inst = otg_inst;
+	dto_params.pixclk_khz = pixclk_khz;
+
+	dccg32_set_dtbclk_dto(dccg, &dto_params);
 }
 
 static void dccg32_get_dccg_ref_freq(struct dccg *dccg,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index b492eb424d19..1ea6d258a20d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -3306,6 +3306,7 @@ void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context, display
 	// context->bw_ctx.bw.dcn.clk.p_state_change_support |= context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching;
 	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
 	context->bw_ctx.bw.dcn.clk.dtbclk_en = is_dtbclk_required(dc, context);
+	context->bw_ctx.bw.dcn.clk.ref_dtbclk_khz = context->bw_ctx.dml.vba.DTBCLKPerState[vlevel] * 1000;
 	if (context->bw_ctx.dml.vba.FCLKChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_fclock_change_unsupported)
 		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = false;
 	else
@@ -3560,10 +3561,15 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 			dcn3_2_soc.clock_limits[i].dscclk_mhz  = max_dispclk_mhz / 3;
 
 			/* Populate from bw_params for DTBCLK, SOCCLK */
-			if (!bw_params->clk_table.entries[i].dtbclk_mhz && i > 0)
-				dcn3_2_soc.clock_limits[i].dtbclk_mhz  = dcn3_2_soc.clock_limits[i-1].dtbclk_mhz;
-			else
+			if (i > 0) {
+				if (!bw_params->clk_table.entries[i].dtbclk_mhz) {
+					dcn3_2_soc.clock_limits[i].dtbclk_mhz  = dcn3_2_soc.clock_limits[i-1].dtbclk_mhz;
+				} else {
+					dcn3_2_soc.clock_limits[i].dtbclk_mhz  = bw_params->clk_table.entries[i].dtbclk_mhz;
+				}
+			} else if (bw_params->clk_table.entries[i].dtbclk_mhz) {
 				dcn3_2_soc.clock_limits[i].dtbclk_mhz  = bw_params->clk_table.entries[i].dtbclk_mhz;
+			}
 
 			if (!bw_params->clk_table.entries[i].socclk_mhz && i > 0)
 				dcn3_2_soc.clock_limits[i].socclk_mhz = dcn3_2_soc.clock_limits[i-1].socclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 780409eb0e98..48af91affb0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1910,10 +1910,15 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 			dcn3_21_soc.clock_limits[i].dscclk_mhz  = max_dispclk_mhz / 3;
 
 			/* Populate from bw_params for DTBCLK, SOCCLK */
-			if (!bw_params->clk_table.entries[i].dtbclk_mhz && i > 0)
-				dcn3_21_soc.clock_limits[i].dtbclk_mhz  = dcn3_21_soc.clock_limits[i-1].dtbclk_mhz;
-			else
+			if (i > 0) {
+				if (!bw_params->clk_table.entries[i].dtbclk_mhz) {
+					dcn3_21_soc.clock_limits[i].dtbclk_mhz = dcn3_21_soc.clock_limits[i-1].dtbclk_mhz;
+				} else {
+					dcn3_21_soc.clock_limits[i].dtbclk_mhz = bw_params->clk_table.entries[i].dtbclk_mhz;
+				}
+			} else if (bw_params->clk_table.entries[i].dtbclk_mhz) {
 				dcn3_21_soc.clock_limits[i].dtbclk_mhz  = bw_params->clk_table.entries[i].dtbclk_mhz;
+			}
 
 			if (!bw_params->clk_table.entries[i].socclk_mhz && i > 0)
 				dcn3_21_soc.clock_limits[i].socclk_mhz = dcn3_21_soc.clock_limits[i-1].socclk_mhz;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index a89d219e712c..4dd461e6c14b 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -239,6 +239,7 @@ struct clk_mgr_funcs {
 			bool safe_to_lower);
 
 	int (*get_dp_ref_clk_frequency)(struct clk_mgr *clk_mgr);
+	int (*get_dtb_ref_clk_frequency)(struct clk_mgr *clk_mgr);
 
 	void (*set_low_power_state)(struct clk_mgr *clk_mgr);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index a06c8daed5ed..025169457cc8 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -68,8 +68,17 @@ struct dccg {
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
 
@@ -119,14 +128,11 @@ struct dccg_funcs {
 
 	void (*set_dtbclk_dto)(
 			struct dccg *dccg,
-			int otg_inst,
-			int pixclk_khz,
-			int num_odm_segments,
-			const struct dc_crtc_timing *timing);
+			const struct dtbclk_dto_params *params);
 
 	void (*set_audio_dtbclk_dto)(
 			struct dccg *dccg,
-			uint32_t req_audio_dtbclk_khz);
+			const struct dtbclk_dto_params *params);
 
 	void (*set_dispclk_change_mode)(
 			struct dccg *dccg,
@@ -148,6 +154,7 @@ void (*set_pixel_rate_div)(
 
 void (*set_valid_pixel_rate)(
         struct dccg *dccg,
+	int ref_dtbclk_khz,
         int otg_inst,
         int pixclk_khz);
 
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
2.35.3

