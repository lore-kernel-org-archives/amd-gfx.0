Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4613C61037
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4613C61037
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD2E6E3B7;
	Fri, 15 Oct 2021 18:39:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8FE6E3AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkD7gfzUmCKlznVifjVMIJjQBJ9sZTtXQSGkGZofZDaQSHl8vR8pUQe4XK7u1sNFWhiDxr5OWnSwewEsYHDgqMQAfGtXy9uKB46LSJE+LdA1jPEXQu7uMdsKpnorF722WAs4pmZI8rP8aF/KbpOw3vmx2OhqXYK4amyWZSJi0+dhQP39v8fjXtJWHFxXJx7v3mu3sbsu2QX/UxDJQo92NDwVChkzijpnlDaxr2rJq7Pc02ZVsCQXQldR7zc23yBdsltMx3lz4e7l7m4d1ecXXS/4YSHUCw/RC1Qw66aMBhjGxtYndIHBh4ITDTV1sZ1/FA8kCVRChL9Ex/Yb9r6s/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FPLs9nw97/vKUc44dV/mgm4NL3fBch5u8yfKimy8gs=;
 b=I5UvoEdGTnaqpF8VRxhhVeGhw+96/HlaHQPbk+AgNO8k0lB9siHaOwL90YdHD7hoNvPUTNoqOxp7GVzr+Xoz4ERV01DX9EWwvwDDcX7fWgXzGPW2C4Yt1kagZ8Nc3aSDPqe1dPpvYGJEKfa0ITnn7+24MTKVM79m6nl7Qe0UrySRinoHXC1pot1A7FqN+g5RoPtI3gqJcBpzPOqt2D7GgrqSE0tl2Ir0CW5kQD0z2yIiwRAbwN2Y9EP6D/xitXLYQaa5RVCymdtkzAArt57rUtLeoXXYWr5vrk5Xi5kSZ9Np1rjXeU8iQtgbY8V4WI0w6w7N7cs2bwPUhipTIcBOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FPLs9nw97/vKUc44dV/mgm4NL3fBch5u8yfKimy8gs=;
 b=r0JNFXWc2ZvxG4L4vdjM2/XIUX1z1+bdeznIqLDdTCTV8R0yoHRKdIqpJQCRxs0rdE+G9k/9/usYngIyHQqDofRZrLB4kK/SaZdqCySMO/ZxVATRH/Bf8IYVfrs/mXByPUdUPCmLcTAPv20er8Nn5OSZCCellVZpHJqMG4nS4PU=
Received: from MW4PR04CA0226.namprd04.prod.outlook.com (2603:10b6:303:87::21)
 by BYAPR12MB3111.namprd12.prod.outlook.com (2603:10b6:a03:dd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 18:39:15 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::7d) by MW4PR04CA0226.outlook.office365.com
 (2603:10b6:303:87::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 18:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:39:14 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:39:11 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Michael Strauss <michael.strauss@amd.com>, "Eric
 Yang" <eric.yang2@amd.com>
Subject: [PATCH 05/27] drm/amd/display: Clean Up VPG Low Mem Power
Date: Fri, 15 Oct 2021 14:38:23 -0400
Message-ID: <20211015183845.220831-6-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015183845.220831-1-agustin.gutierrez@amd.com>
References: <20211015183845.220831-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c584432-87d6-48ea-a585-08d9900b1685
X-MS-TrafficTypeDiagnostic: BYAPR12MB3111:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3111348928F8102CDEC7B172F5B99@BYAPR12MB3111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3Kj7u4+LvAQKe2XzGtkfK+JeLa+GijwM2PQobPBue8OyAYRbZrK7QMTpO9nsjCF5G9tryqkGZyUKc/T5We05kKzvNVQBWHCkApatgswalbnmu28+33klDnPJj8/JxS7G7fwxUmqKJm0ArCYmTwvY8CU6ymdftv+c3W7LseYgSKLZCm2CXaxOhMv82nPrT4KYbLyvjuuUCi8a+tas8owVIsRLrDlDgPu92cp+sq86RQrsU5KJVIEqtPg5bkCYed1ytv8SBYdWokC+jUHJYxY/mHbI0fIt5d+f8QngM4Vi0PZzljfnb4xk6/88Mwk4f5YzzGmram7qSbwxVopO4ZTwVhcj9qS6WtuaXKSWo9x4i2Xv4uebQAL++GYFp8hYHCS7lZdTbOHARflMbSPG9GzXZpHzm8Kyt19+mwCsjCW2IgNQgmtfNa7do6NyInjcwagvXgIB+17oMwUCoPMBbvuw3DeRUR9s8davt4dQvz0kLFTo8iDWpbAEBfEeaZ2S6QbgwIYi1IJyDhWCgFVGMeVh+6jQC+3H/UNRGOdsnFDJs6k7vjAAW90AmD0LPnigNfLaW8xnfEUvlE7CR4UO7gH/idplnx7BWSnc5SGfMZuBXR1uQBy6AteWObnnGDsZ47VcZj/WV0sN2ZTT7n6zrXSzKIwqM+/xukSIiTtKjUXv45rc56lOCOymZEt0TvxBzpFOLyVhOXi+dbVRULKr6zQw58WmWalIQqzJuFXZ3X4GCc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6666004)(316002)(426003)(2906002)(54906003)(36756003)(1076003)(336012)(8676002)(86362001)(70206006)(2616005)(8936002)(70586007)(5660300002)(4326008)(44832011)(508600001)(6916009)(82310400003)(26005)(81166007)(16526019)(356005)(47076005)(36860700001)(83380400001)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:39:14.4896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c584432-87d6-48ea-a585-08d9900b1685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3111
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHAT]
One of the current VPG power on calls is unnecessary

Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c            | 10 ----------
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c  | 13 +++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   |  4 ----
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f9876e429f26..8be04be19124 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -71,8 +71,6 @@
 
 #include "dmub/dmub_srv.h"
 
-#include "dcn30/dcn30_vpg.h"
-
 #include "i2caux_interface.h"
 #include "dce/dmub_hw_lock_mgr.h"
 
@@ -2674,9 +2672,6 @@ static void commit_planes_do_stream_update(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	struct vpg *vpg;
-#endif
 	int j;
 
 	// Stream updates
@@ -2697,11 +2692,6 @@ static void commit_planes_do_stream_update(struct dc *dc,
 					stream_update->vrr_infopacket ||
 					stream_update->vsc_infopacket ||
 					stream_update->vsp_infopacket) {
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-				vpg = pipe_ctx->stream_res.stream_enc->vpg;
-				if (vpg && vpg->funcs->vpg_poweron)
-					vpg->funcs->vpg_poweron(vpg);
-#endif
 				resource_build_info_frame(pipe_ctx);
 				dc->hwss.update_info_frame(pipe_ctx);
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 18e33ef3d217..968b8825dec7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -49,6 +49,7 @@
 #include "inc/link_dpcd.h"
 #include "dcn10/dcn10_hw_sequencer.h"
 #include "inc/link_enc_cfg.h"
+#include "dcn30/dcn30_vpg.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -126,6 +127,18 @@ void dcn31_init_hw(struct dc *dc)
 		REG_UPDATE(MMHUBBUB_MEM_PWR_CNTL, VGA_MEM_PWR_FORCE, 1);
 	}
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (dc->debug.enable_mem_low_power.bits.vpg && dc->res_pool->stream_enc[0]->vpg->funcs->vpg_powerdown) {
+		// Power down VPGs
+		for (i = 0; i < dc->res_pool->stream_enc_count; i++)
+			dc->res_pool->stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->stream_enc[i]->vpg);
+#if defined(CONFIG_DRM_AMD_DC_DP2_0)
+		for (i = 0; i < dc->res_pool->hpo_dp_stream_enc_count; i++)
+			dc->res_pool->hpo_dp_stream_enc[i]->vpg->funcs->vpg_powerdown(dc->res_pool->hpo_dp_stream_enc[i]->vpg);
+#endif
+	}
+#endif
+
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 7cb7604a35eb..20b4202bda13 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1312,10 +1312,6 @@ static struct vpg *dcn31_vpg_create(
 			&vpg_shift,
 			&vpg_mask);
 
-	// Will re-enable hw block when we enable stream
-	// Check for enabled stream before powering down?
-	vpg31_powerdown(&vpg31->base);
-
 	return &vpg31->base;
 }
 
-- 
2.25.1

