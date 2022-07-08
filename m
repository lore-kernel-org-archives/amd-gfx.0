Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01068C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 05:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23E1210E242;
	Fri,  8 Jul 2022 05:27:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1228410E242
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 05:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg68t0zQmGGuyKwh11c3E7WrqfvW9i/khGKfPUZPF7qdnsFE1W6h1HVHhEOx7oGNP9qLU0q8pV8si8Krghx7r6n7N0uCvdj4UcJYlMYOq7GyI9kFGzITNKHCz5uEIMW+e2kIL8CWdbVLKuOS3JUMvEAOAJZfTvloaNXTgMRJs2HmSP1OW6veF7fhC2F2LZDZByWGoRLFdrl1Y51HFUISkqooIK4bxw6HV3hD6RyEFtHDiBOOQ4YzcYR9MJfbxo2CiEhibp4k8zTeJy1O6tKtGRscDCuOKA318wmHBnyq+wlcooGLIA7yEy99TVr23nkMwp9zx5mihSwOATC459zGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3ROxEadywKlSJy/1O4NgYb6RxBVNgaw7nPKzpsK+V8=;
 b=lc6TE95w4G8z7NjNmWcyFt/Sh3TSPq19AuVlK8X6xgrd9O1NbgVbrmu1HjeuU13omCopvQcBpMCVEZsqG2uvEw3tuDC1JvmwyncaI2IAKYAaMQSZVCHPGH6O1lbT6j87dZLhjn3BNF5eAE5v+8LuNm9iU40FVAP/tNAK6eaoMe4p1sfeucraJxE+8yZ3yEbl3uR9YdbyfU/7Q0segdWoTpzwLcEn8yfFBl0Fqn2/hXdKMNgdWDJnkY1cAYW5Cq18olevHZ74V+J9sYZua1iOsIzOrIlD7QjA0nNDXocs8RhSEPmor4LoFKX2BE3ad0hlcIbZSBqT2RRZEyQorIwbtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3ROxEadywKlSJy/1O4NgYb6RxBVNgaw7nPKzpsK+V8=;
 b=fBhgNjl75ovEEJXI8ONp6AbolnMTyDJvTN/iHj1CpXrxwKVTuvi5Ia53o2cx0SwdMIurR/xalS9KfqXwZQkK2OYyISs5Al7IHAKL5C4yRvkkmuw3Ewbu1ymRz9etvUboTLj5pXJuJXyQgp6aC8yfgTbiWhHsX2Gl04OgbDcGqyM=
Received: from BN6PR19CA0100.namprd19.prod.outlook.com (2603:10b6:404:a0::14)
 by CY4PR12MB1336.namprd12.prod.outlook.com (2603:10b6:903:40::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 05:27:08 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::e2) by BN6PR19CA0100.outlook.office365.com
 (2603:10b6:404:a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 8 Jul 2022 05:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 05:27:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 00:27:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix 32 bit compilation errors in
 dc_dmub_srv.c
Date: Fri, 8 Jul 2022 01:26:50 -0400
Message-ID: <20220708052650.1029150-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7a01532-5618-4ceb-ca5c-08da60a2807f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1336:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zIN/yAZiJZpBaSIbjQ69xQBL/Krs54b13jjpORIly9B4TcUKnvhr2LgSiylyJVsjHd7nSzN4UYhGR94TZ9GNrVh55Fc/r5PSB/yMMj/pBy3jTYs/NQLxODafZuIM9SCd8J3hyuFbWz6Alh3VpZHMDx/9LTbzx16rSCVneY7gHxZUQwUteaaqX7LebyO0yrzJh+e2JR0aoJs/7FQHD8QNiYx+3iLYjBWxb4i2IpNHYjrXEBmQ6naZEXvBMbj5bubA/hDaPKxhTs2sQEPVjqO2w3sNij+ujZU12fDrTMqfQLH0Jk49OtpkSGmJPxWu79IdpGE2REEZdZr4jwIW35Si1HvG3XMNiJUqhM+2jrftA/WLom5jLa8bXyhaorJh+UWrt9JswX+bvy79/UbsE0dvXg35A4vgJSy+7g0GJwof5zfZ5zXp6iExgYwAtvHweNh9wGwftu2/dT4vsgQLOcj2Dq/xLGkA+0tM+oqVn89yZGLwv5p2hN7iNS48UK2os2Tn6LRNHREQfr6Oqobn+O024B4AkZcIIiyE2bj0IDdz50g707pr5XwhDG1LNu9wiuHo54P+WR61K5QoHyaiU3tbqQaNd0pkOMClIQL9pwBpt2Mijbvcdn0+kJRplM9GPOLjVI50PDXJGAxGJ8F8rKiatkD6PZd1ygvwVPvOU3ZCTq4H2JvZ+heFIsWytRgapfgHATTP+9PIQBdUE7laFl3SZmXz5oc/W0Qdx30kyeyoygzHm48rT+8bT62s1qL8Ttfk3WZy1uSRuLRWpJpyKVZXBQzxL6ZleEFmLXOM8whXrPmOf876l5+2a7oKDTlQmDov8lKc3q3vPjkF/oEMUrlmjKV1qn+wsyvEHoyPoO3JnRSLKOLG+W3DSso+Tp+gzWCA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(40470700004)(36840700001)(46966006)(186003)(426003)(16526019)(47076005)(40480700001)(7696005)(70206006)(70586007)(4326008)(8676002)(36756003)(2616005)(26005)(336012)(1076003)(6916009)(83380400001)(5660300002)(40460700003)(36860700001)(6666004)(82310400005)(86362001)(478600001)(316002)(356005)(82740400003)(34020700004)(41300700001)(81166007)(8936002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 05:27:08.2548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a01532-5618-4ceb-ca5c-08da60a2807f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1336
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are several things wrong here.  First, none of these
numbers are FP, so there is no need to cast to double.  Next
make sure to use proper 64 bit division helpers.

Fixes: 85f4bc0c333c ("drm/amd/display: Add SubVP required code")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile      | 26 --------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 67 ++++++++++----------
 2 files changed, 34 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index dfe82bcdd17d..64f40b10c163 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,31 +22,6 @@
 #
 # Makefile for Display Core (dc) component.
 
-ifdef CONFIG_X86
-dmub_ccflags := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-dmub_ccflags := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-dmub_ccflags += -mpreferred-stack-boundary=4
-else
-dmub_ccflags += -msse2
-endif
-endif
-
 DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual
 
 ifdef CONFIG_DRM_AMD_DC_DCN
@@ -99,7 +74,6 @@ AMD_DISPLAY_FILES += $(AMD_DISPLAY_CORE)
 AMD_DISPLAY_FILES += $(AMD_DM_REG_UPDATE)
 
 DC_DMUB += dc_dmub_srv.o
-CFLAGS_$(AMDDALPATH)/dc/dc_dmub_srv.o := $(dmub_ccflags)
 DC_EDID += dc_edid_parser.o
 AMD_DISPLAY_DMUB = $(addprefix $(AMDDALPATH)/dc/,$(DC_DMUB))
 AMD_DISPLAY_EDID = $(addprefix $(AMDDALPATH)/dc/,$(DC_EDID))
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 6b446ae9e91f..832f7a4deb03 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -416,27 +416,28 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 	pipe_data->pipe_config.vblank_data.drr_info.use_ramping = false; // for now don't use ramping
 	pipe_data->pipe_config.vblank_data.drr_info.drr_window_size_ms = 4; // hardcode 4ms DRR window for now
 
-	drr_frame_us = drr_timing->v_total * drr_timing->h_total /
-			(double)(drr_timing->pix_clk_100hz * 100) * 1000000;
+	drr_frame_us = div64_s64(drr_timing->v_total * drr_timing->h_total,
+				 (int64_t)(drr_timing->pix_clk_100hz * 100) * 1000000);
 	// P-State allow width and FW delays already included phantom_timing->v_addressable
-	mall_region_us = phantom_timing->v_addressable * phantom_timing->h_total /
-			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000;
+	mall_region_us = div64_s64(phantom_timing->v_addressable * phantom_timing->h_total,
+				   (int64_t)(phantom_timing->pix_clk_100hz * 100) * 1000000);
 	min_drr_supported_us = drr_frame_us + mall_region_us + SUBVP_DRR_MARGIN_US;
-	min_vtotal_supported = drr_timing->pix_clk_100hz * 100 * ((double)min_drr_supported_us / 1000000) /
-			(double)drr_timing->h_total;
-
-	prefetch_us = (phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total /
-			(double)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
-			dc->caps.subvp_prefetch_end_to_mall_start_us;
-	subvp_active_us = main_timing->v_addressable * main_timing->h_total /
-			(double)(main_timing->pix_clk_100hz * 100) * 1000000;
-	drr_active_us = drr_timing->v_addressable * drr_timing->h_total /
-			(double)(drr_timing->pix_clk_100hz * 100) * 1000000;
-	max_drr_vblank_us = (double)(subvp_active_us - prefetch_us - drr_active_us) / 2 + drr_active_us;
+	min_vtotal_supported = div64_s64(drr_timing->pix_clk_100hz * 100 *
+					 (div64_s64((int64_t)min_drr_supported_us, 1000000)),
+					 (int64_t)drr_timing->h_total);
+
+	prefetch_us = div64_s64((phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total,
+				(int64_t)(phantom_timing->pix_clk_100hz * 100) * 1000000 +
+				dc->caps.subvp_prefetch_end_to_mall_start_us);
+	subvp_active_us = div64_s64(main_timing->v_addressable * main_timing->h_total,
+				    (int64_t)(main_timing->pix_clk_100hz * 100) * 1000000);
+	drr_active_us = div64_s64(drr_timing->v_addressable * drr_timing->h_total,
+				  (int64_t)(drr_timing->pix_clk_100hz * 100) * 1000000);
+	max_drr_vblank_us = div64_s64((int64_t)(subvp_active_us - prefetch_us - drr_active_us), 2) + drr_active_us;
 	max_drr_mallregion_us = subvp_active_us - prefetch_us - mall_region_us;
 	max_drr_supported_us = max_drr_vblank_us > max_drr_mallregion_us ? max_drr_vblank_us : max_drr_mallregion_us;
-	max_vtotal_supported = drr_timing->pix_clk_100hz * 100 * ((double)max_drr_supported_us / 1000000) /
-			(double)drr_timing->h_total;
+	max_vtotal_supported = div64_s64(drr_timing->pix_clk_100hz * 100 * (div64_s64((int64_t)max_drr_supported_us, 1000000)),
+					 (int64_t)drr_timing->h_total);
 
 	pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported = min_vtotal_supported;
 	pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported = max_vtotal_supported;
@@ -530,10 +531,10 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 	struct dc_crtc_timing *phantom_timing1 = &subvp_pipes[1]->stream->mall_stream_config.paired_stream->timing;
 	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data = NULL;
 
-	subvp0_prefetch_us = (phantom_timing0->v_total - phantom_timing0->v_front_porch) * phantom_timing0->h_total /
-				(double)(phantom_timing0->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us;
-	subvp1_prefetch_us = (phantom_timing1->v_total - phantom_timing1->v_front_porch) * phantom_timing1->h_total /
-					(double)(phantom_timing1->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us;
+	subvp0_prefetch_us = div64_s64((phantom_timing0->v_total - phantom_timing0->v_front_porch) * phantom_timing0->h_total,
+				       (int64_t)(phantom_timing0->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us);
+	subvp1_prefetch_us = div64_s64((phantom_timing1->v_total - phantom_timing1->v_front_porch) * phantom_timing1->h_total,
+				       (int64_t)(phantom_timing1->pix_clk_100hz * 100) * 1000000 + dc->caps.subvp_prefetch_end_to_mall_start_us);
 
 	// Whichever SubVP PIPE has the smaller prefetch (including the prefetch end to mall start time)
 	// should increase it's prefetch time to match the other
@@ -541,16 +542,16 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[1];
 		prefetch_delta_us = subvp0_prefetch_us - subvp1_prefetch_us;
 		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-					(((double)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) / 1000000) *
-					(phantom_timing1->pix_clk_100hz * 100) + phantom_timing1->h_total - 1) /
-					(double)phantom_timing1->h_total;
+			div64_s64(((div64_s64((int64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us), 1000000)) *
+				   (phantom_timing1->pix_clk_100hz * 100) + phantom_timing1->h_total - 1),
+				  (int64_t)phantom_timing1->h_total);
 	} else if (subvp1_prefetch_us >  subvp0_prefetch_us) {
 		pipe_data = &cmd->fw_assisted_mclk_switch_v2.config_data.pipe_data[0];
 		prefetch_delta_us = subvp1_prefetch_us - subvp0_prefetch_us;
 		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-					(((double)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) / 1000000) *
-					(phantom_timing0->pix_clk_100hz * 100) + phantom_timing0->h_total - 1) /
-					(double)phantom_timing0->h_total;
+			div64_s64(((div64_s64((int64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us), 1000000)) *
+				   (phantom_timing0->pix_clk_100hz * 100) + phantom_timing0->h_total - 1),
+				  (int64_t)phantom_timing0->h_total);
 	}
 }
 
@@ -601,13 +602,13 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 
 	// Round up
 	pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-			(((double)dc->caps.subvp_prefetch_end_to_mall_start_us / 1000000) *
-			(phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
-			(double)phantom_timing->h_total;
+		div64_s64(((div64_s64((int64_t)dc->caps.subvp_prefetch_end_to_mall_start_us, 1000000)) *
+			   (phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1),
+			  (int64_t)phantom_timing->h_total);
 	pipe_data->pipe_config.subvp_data.processing_delay_lines =
-			(((double)dc->caps.subvp_fw_processing_delay_us / 1000000) *
-			(phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1) /
-			(double)phantom_timing->h_total;
+		div64_s64(((div64_s64((int64_t)dc->caps.subvp_fw_processing_delay_us, 1000000)) *
+			   (phantom_timing->pix_clk_100hz * 100) + phantom_timing->h_total - 1),
+			  (int64_t)phantom_timing->h_total);
 	// Find phantom pipe index based on phantom stream
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *phantom_pipe = &context->res_ctx.pipe_ctx[j];
-- 
2.35.3

