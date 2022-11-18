Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8620FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CD510E783;
	Fri, 18 Nov 2022 16:59:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2228F10E77D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guIY88W1BKWIa/GFz3fqdl50gdRGUP5jV/RSbxlrXRwhly9Yqrmp5k2Vp+FCYH2Kt8TRYRVD1OCq1McXA1Ut5PmwbbNULgQib9/oWJlKMkqKQLixa08DglJY/4caV2TFHT33r56AS6amhc3FJQjYy6527LKMSbFOZimXlCDBUZ6MuTQlM7KJ64fJIMtQA6NVRUDKoF4sjJwB6ntS6lCKqt9JgWrwl0RjEJoqpykHC7uaMDWDSLxrYkCMc90jVua2+JMkV74B+MFvWKTbPQ+Ze38VkdmGumrA4CFe+8N67GC/NrLBU5W0pPeKlwyFKnxJTGfYqI9APKFcJCc7cnlnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW2kCxuHEx1e1ZMtAvHi+bGR0U/Wwy1NKWmGXG5MrHc=;
 b=IdTiAx/cTApak/Jx4R4QRNvCl4mEl6R8Bgm92HcAD90JvdljmyAr3vP3V0N5CWe9pwKlPpeN+f8hCZzoIPsej0+GthnfuRL/YKCN13zfhcDmKBRgouHTjBETY+6VSi7Kqtm3bIcBNNdDYq9pyanCG6ABbsv8a2jjeRgOAWkPNeEuUEtv5WpRoy+ictuhHp5L4EMuWo54bzJ1UZhFWytSJXb2Ws0G0T2Dei8p41MQWsUlUtRugqsl5mNxg+3VVHWWF8NfVTpfwdTDqTjq0zlqkgKJkI/ryRbc7ueQbUDi30+kqAW9gt6YABIcpf+Z6COHsVFQuSGDLv2KZPiY0gKwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW2kCxuHEx1e1ZMtAvHi+bGR0U/Wwy1NKWmGXG5MrHc=;
 b=yDXUym6Akx7bitXGkF9myoN+SnM3mu3ypfuAfwrdeaWi1YK0F43SskRQt9jqYNOByKeci6QUPrNw7YEsL84so3v2paM1Tlj688lRg4DocaGSKEtRCaDPuQImGbzxp/yr6e0hMoZXov3veVr54G43x/t1BvNvgQThePz7kLsglz0=
Received: from MW2PR16CA0043.namprd16.prod.outlook.com (2603:10b6:907:1::20)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Fri, 18 Nov
 2022 16:59:23 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::6d) by MW2PR16CA0043.outlook.office365.com
 (2603:10b6:907:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15 via Frontend
 Transport; Fri, 18 Nov 2022 16:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 16:59:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:21 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 10:59:21 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 10:59:17
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/22] drm/amd/display: Add margin on DRR vblank start for
 subvp
Date: Fri, 18 Nov 2022 20:59:15 +0800
Message-ID: <20221118125935.4013669-3-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|DS0PR12MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 35eb8b49-2884-4b61-92ba-08dac9863df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cIXNLD7BNWDw0r5VO4DchXpiYvGR1+ISpkS0bUYdi72YwcZhINjCfwq0pTcQojvfMIyHoNC2+gXtCFmXBrkiD/jtLtAdOLHNxeZImNLOXNVR5lqHKhzgpEiFnS+Ovnd87PYMNG0qZOwK+eYqcYC1VBSm+AWI/p9acjG2SS9G9771gcf4fLwrckKss/l9D3xwBMaF+pBZOyg5JeljmEtFuuNJYUdCzzeHNWGlWFDTpthWJSx1LFBnzcoxfIX17/p1lhBRX3QVvbEpKTDHT1svW1qzJbPpYwiapNd1/r4mhPSdxYDbyWGSy9i7Jm82UC4z6qwcLlg6Wh1x9gT6MYj079EhSs6QImTjoE/8KVLEK+/Wu8/ZxcPcovDPrt+WJQNNilzZigxIUcjEQd2l9+REFqQYsxX5K4kgcma1hAsgpM0D9VnK/YvXBjH3ivtKM8fx5JaJ+9e0U7M5Dm6BuMrlR2HuxO/dZzu0FFrdBLM6G72I8uK/Yibto7nKx9wD5w7wWhmFovZ5ThaFxRjTdbNwugrxNGmjD8kqUnoLUm5zbCE1P47fq0UdgiHCnN+HdUth67B84Bf9ygZqWdNvvR6iBtGd2T+E3yOdTtGHHBigalgSo3s52X9RzZSw40KuJe308Yjus+AcBklg6bYc/zXUgazLWJqdYsdpcEdhvKvml8qn5qI1wlFAUdOTzzsht4/kfCynEPVNNX7afd6/13bz4+INse+TSUmegABIHzq+aag9zV6qm4zuVizYzgfXAnKoO1x08V1Em2RbvCBJ+qwBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(8676002)(70586007)(36756003)(478600001)(82310400005)(81166007)(36860700001)(41300700001)(8936002)(4326008)(86362001)(70206006)(47076005)(7696005)(186003)(316002)(26005)(1076003)(2616005)(336012)(426003)(40460700003)(54906003)(83380400001)(6916009)(356005)(2906002)(5660300002)(40480700001)(82740400003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 16:59:22.7048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eb8b49-2884-4b61-92ba-08dac9863df2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, "Lee,
 Alvin" <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lee, Alvin" <Alvin.Lee2@amd.com>

[Description]
- Add margin for HUBP "jitter" for SubVp + DRR case
- Also do a min transition even if MPO is added on a
  non SubVP pipe (i.e. added on DRR pipe for SubVP + DRR)

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c       | 18 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h            |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c   |  1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h     |  2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c  |  1 +
 .../amd/display/dc/dcn321/dcn321_resource.c    |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  3 ++-
 7 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1c3de3a1671e..42840ce9bf4b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3740,6 +3740,8 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 
 	struct dc_stream_status *cur_stream_status = stream_get_status(dc->current_state, stream);
 	bool force_minimal_pipe_splitting = false;
+	bool subvp_active = false;
+	uint32_t i;
 
 	*is_plane_addition = false;
 
@@ -3771,11 +3773,25 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 		}
 	}
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream && pipe->stream->mall_stream_config.type != SUBVP_NONE) {
+			subvp_active = true;
+			break;
+		}
+	}
+
 	/* For SubVP when adding or removing planes we need to add a minimal transition
 	 * (even when disabling all planes). Whenever disabling a phantom pipe, we
 	 * must use the minimal transition path to disable the pipe correctly.
+	 *
+	 * We want to use the minimal transition whenever subvp is active, not only if
+	 * a plane is being added / removed from a subvp stream (MPO plane can be added
+	 * to a DRR pipe of SubVP + DRR config, in which case we still want to run through
+	 * a min transition to disable subvp.
 	 */
-	if (cur_stream_status && stream->mall_stream_config.type == SUBVP_MAIN) {
+	if (cur_stream_status && subvp_active) {
 		/* determine if minimal transition is required due to SubVP*/
 		if (cur_stream_status->plane_count > surface_count) {
 			force_minimal_pipe_splitting = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b02d1f3d3e7c..1f6dff9904f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -267,6 +267,7 @@ struct dc_caps {
 	uint16_t subvp_pstate_allow_width_us;
 	uint16_t subvp_vertical_int_margin_us;
 	bool seamless_odm;
+	uint8_t subvp_drr_vblank_start_margin_us;
 };
 
 struct dc_bug_wa {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 097556f7b32c..6ccf477d1c4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -493,6 +493,7 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 
 	pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported = min_vtotal_supported;
 	pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported = max_vtotal_supported;
+	pipe_data->pipe_config.vblank_data.drr_info.drr_vblank_start_margin = dc->caps.subvp_drr_vblank_start_margin_us;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index f4dfd3a49b68..e0cee9666c48 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -144,7 +144,7 @@ struct test_pattern {
 	unsigned int cust_pattern_size;
 };
 
-#define SUBVP_DRR_MARGIN_US 500 // 500us for DRR margin (SubVP + DRR)
+#define SUBVP_DRR_MARGIN_US 600 // 600us for DRR margin (SubVP + DRR)
 
 enum mall_stream_type {
 	SUBVP_NONE, // subvp not in use
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index cdeff6de725d..0c13fe0239d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2124,6 +2124,7 @@ static bool dcn32_resource_construct(
 	dc->caps.subvp_swath_height_margin_lines = 16;
 	dc->caps.subvp_pstate_allow_width_us = 20;
 	dc->caps.subvp_vertical_int_margin_us = 30;
+	dc->caps.subvp_drr_vblank_start_margin_us = 100; // 100us margin
 
 	dc->caps.max_slave_planes = 2;
 	dc->caps.max_slave_yuv_planes = 2;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 6c79a47b6336..d17d0f22be1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1711,6 +1711,7 @@ static bool dcn321_resource_construct(
 	dc->caps.subvp_swath_height_margin_lines = 16;
 	dc->caps.subvp_pstate_allow_width_us = 20;
 	dc->caps.subvp_vertical_int_margin_us = 30;
+	dc->caps.subvp_drr_vblank_start_margin_us = 100; // 100us margin
 	dc->caps.max_slave_planes = 1;
 	dc->caps.max_slave_yuv_planes = 1;
 	dc->caps.max_slave_rgb_planes = 1;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 795d8811af9a..33907feefebb 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1029,13 +1029,14 @@ struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 {
 			uint16_t vtotal;
 			uint16_t htotal;
 			uint8_t vblank_pipe_index;
-			uint8_t padding[2];
+			uint8_t padding[1];
 			struct {
 				uint8_t drr_in_use;
 				uint8_t drr_window_size_ms;	// Indicates largest VMIN/VMAX adjustment per frame
 				uint16_t min_vtotal_supported;	// Min VTOTAL that supports switching in VBLANK
 				uint16_t max_vtotal_supported;	// Max VTOTAL that can support SubVP static scheduling
 				uint8_t use_ramping;		// Use ramping or not
+				uint8_t drr_vblank_start_margin;
 			} drr_info;				// DRR considered as part of SubVP + VBLANK case
 		} vblank_data;
 	} pipe_config;
-- 
2.25.1

