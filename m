Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957E2C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE04B9246;
	Fri,  5 Aug 2022 18:00:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1C3B92F2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRnVN/NJ6TSTGwdH4Qwpw/SgHRzRy3nPDIZMMNPwG/ycvR+YcA0eXYrghb7dmsPbwMeOMbGBa6f8fM8GkgOPpwrOK/d++P1WMxk9SJvTgnLVoWMjzEU0Y4aQXFj5cW1ZcNGW2bgffof0O86tdBUfqinuAcwtwl5VilL0ZjmcVlWHDZvJR22Uy6KsZtSzmlnMDTNuIhjlcj0i6I0LCovWGQbv8HC7gN5tbTFye0KfmZkGV5dpOWhd63Oi7dwFA2VAa15xciVK93kU1DEjjD91iiF95kTz6Xj6EH7km4OPorfM4txLt62Hy848KRGomIlpa4o2bg0yxYa/M0t2T4XmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgcIfzXk9ypcHYFShNvJTvFzcGdBENKuaJgaqoTnuRA=;
 b=ahoMt8zgb6KliemPwruXPD1czjJ3jeN+fW2nSDcBNSh7Q5+zTNUav2XjghU3zlp0YvXYaJMnJUYIOmSSJ+xjg3zL1D1i56kzy1H/yP/B5f+vvClZSows7KQZa0f+/ppQuRZJviblFkvrHjZcOw28Zm28QXahH7UZ30wYbyq2vztgPMauCf0gvgrI7rmv2rYpt0/rv6O68+YJeZ0Ga1YapiP3WgqRDI06WLCMEFY1vNHqbTOAo7yRyFblBPcnjA2Ro72pk74iGoVelSLXwWk1wztW2taeOO/IO+nASvdVNNxUV21nF6CLZFfoQviOKIIUvkrNsQhJ+ThGXnuqrMpWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgcIfzXk9ypcHYFShNvJTvFzcGdBENKuaJgaqoTnuRA=;
 b=2Vy7wqZ/OylA6Dof/6hA2D/ZWT/VdaPZVwS3ZebZj5m6SVt8LIknSDmi2WXyAmMz4BDFO6KXUJudOtAbr5IhlHUlYJSNJZLx6iCV95vBbPvKFS0toQfDie+QyFgYEVgGfBT9fCYCSCMgG6Yk9xYbvmtfFCPw+onAzsTNNo+LCLM=
Received: from MW4PR03CA0326.namprd03.prod.outlook.com (2603:10b6:303:dd::31)
 by CY4PR1201MB0231.namprd12.prod.outlook.com (2603:10b6:910:24::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 18:00:01 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::a6) by MW4PR03CA0326.outlook.office365.com
 (2603:10b6:303:dd::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Fri, 5 Aug 2022 18:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:00:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:59:59 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:59:54 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/32] drm/amd/display: Fix subvp calculations
Date: Sat, 6 Aug 2022 01:58:07 +0800
Message-ID: <20220805175826.2992171-14-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3980f943-c4e1-4161-b306-08da770c512c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0231:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cH0p0FtqC8FfVQpMf7gO/ptVOc62g34QPnO/6/LaPswE2n8xfTH+E3Hhb1j9+4nIhwWIuYoSDvwPxJKb0rNPopBweqGwMbvZblOuaG6EZBMR8pPH8wlxoHHa4ppcesBIcGrZ1919tNPEOGrUEUTj4tmMAp/boNg+tWaaa0A5ZTkrMvy4FmWZOCw27/2kUVDmgooUYOAK2wSc3iYddHPo9sKwlqfhCvL/JiQZiHfws2GoooZK4+8JmR1xZpVtWfj7pKZmCafrV4V9Wo/RZ72kEPycKQ9JUEdG7N1jhXG8oDm2u0Zl9ErkK7CxCVG8RDlXHlR1oZ8mYKVEbfB+kw7QkcnPfBT3Ss3swuViBdfAHwPE5VW8HcEljKjzcc8mqpP0zWPziacbXy+iJfR6+BsR/zd2e+3bnNiO99Ghj/bfdt2vT61tRS/rRd3W2/ev3U4dkuYIGghpaQ3kuQ+vqMOgoRtv0X7lVUkkey6siMB0dLXwY/MboLQV/P4BOXoe3uWNruP1bhwTQef9U/mLnJQsiB1GgxWVA5pOwnFxRGmr7OjuILT0tEt7OU6UVl579EmVFedBcAQTnotJGssVpaetb1zfmQy4B0mBoZe2C6JIY2QayYkGNIqBTYhBo+w6DoD8FQiusWA67cyHzsQkho9ETkCZXtUNN1oWoWEe8IiMuJ/PdlaB6+izKoTUW1otuKkOdryQ+OK1EfVf+et+cVH/KN0AFU7fvdLT0fnI2K8a5EqHg0xF8IgVMuB6VKVi6vu6SwZIQ+yEQC5IIhlayxT8ApClCd6sxZ9xX+Ybx7oauTjcaU1/WJm7xVGNsO39TKX/yaMpOKuNtJW5f7ObOE6Oug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(40470700004)(36840700001)(46966006)(8936002)(70206006)(70586007)(4326008)(8676002)(5660300002)(40480700001)(82310400005)(40460700003)(2906002)(82740400003)(36860700001)(86362001)(356005)(81166007)(41300700001)(478600001)(54906003)(6916009)(316002)(186003)(336012)(47076005)(1076003)(426003)(83380400001)(26005)(6666004)(2616005)(36756003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:00:00.9668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3980f943-c4e1-4161-b306-08da770c512c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0231
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Descriptions]
Missed some brackets in order of operations

Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 48 ++++++++++----------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 759d54843eff..62f7dd94f498 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -432,26 +432,26 @@ static void populate_subvp_cmd_drr_info(struct dc *dc,
 	pipe_data->pipe_config.vblank_data.drr_info.use_ramping = false; // for now don't use ramping
 	pipe_data->pipe_config.vblank_data.drr_info.drr_window_size_ms = 4; // hardcode 4ms DRR window for now
 
-	drr_frame_us = (uint64_t)drr_timing->v_total * drr_timing->h_total * 1000000 /
-			(uint64_t)(drr_timing->pix_clk_100hz * 100);
+	drr_frame_us = ((uint64_t)drr_timing->v_total * drr_timing->h_total * 1000000) /
+			(((uint64_t)drr_timing->pix_clk_100hz * 100));
 	// P-State allow width and FW delays already included phantom_timing->v_addressable
-	mall_region_us = (uint64_t)phantom_timing->v_addressable * phantom_timing->h_total * 1000000 /
-			(uint64_t)(phantom_timing->pix_clk_100hz * 100);
+	mall_region_us = ((uint64_t)phantom_timing->v_addressable * phantom_timing->h_total * 1000000) /
+			(((uint64_t)phantom_timing->pix_clk_100hz * 100));
 	min_drr_supported_us = drr_frame_us + mall_region_us + SUBVP_DRR_MARGIN_US;
-	min_vtotal_supported = (uint64_t)drr_timing->pix_clk_100hz * 100 * min_drr_supported_us /
-			(uint64_t)(drr_timing->h_total * 1000000);
-
-	prefetch_us = (uint64_t)(phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total * 1000000
-			/ (uint64_t)(phantom_timing->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us;
-	subvp_active_us = (uint64_t)main_timing->v_addressable * main_timing->h_total * 1000000 /
-			(uint64_t)(main_timing->pix_clk_100hz * 100);
-	drr_active_us = (uint64_t)drr_timing->v_addressable * drr_timing->h_total * 1000000 /
-			(uint64_t)(drr_timing->pix_clk_100hz * 100);
+	min_vtotal_supported = ((uint64_t)drr_timing->pix_clk_100hz * 100 * min_drr_supported_us) /
+			(((uint64_t)drr_timing->h_total * 1000000));
+
+	prefetch_us = ((uint64_t)(phantom_timing->v_total - phantom_timing->v_front_porch) * phantom_timing->h_total * 1000000)
+			/ (((uint64_t)phantom_timing->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us);
+	subvp_active_us = ((uint64_t)main_timing->v_addressable * main_timing->h_total * 1000000) /
+			(((uint64_t)main_timing->pix_clk_100hz * 100));
+	drr_active_us = ((uint64_t)drr_timing->v_addressable * drr_timing->h_total * 1000000) /
+			(((uint64_t)drr_timing->pix_clk_100hz * 100));
 	max_drr_vblank_us = (subvp_active_us - prefetch_us - drr_active_us) / 2 + drr_active_us;
 	max_drr_mallregion_us = subvp_active_us - prefetch_us - mall_region_us;
 	max_drr_supported_us = max_drr_vblank_us > max_drr_mallregion_us ? max_drr_vblank_us : max_drr_mallregion_us;
-	max_vtotal_supported = (uint64_t)drr_timing->pix_clk_100hz * 100 * max_drr_supported_us /
-			(uint64_t)(1000000 * drr_timing->h_total);
+	max_vtotal_supported = ((uint64_t)drr_timing->pix_clk_100hz * 100 * max_drr_supported_us) /
+			(((uint64_t)drr_timing->h_total * 1000000));
 
 	pipe_data->pipe_config.vblank_data.drr_info.min_vtotal_supported = min_vtotal_supported;
 	pipe_data->pipe_config.vblank_data.drr_info.max_vtotal_supported = max_vtotal_supported;
@@ -545,10 +545,12 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 	struct dc_crtc_timing *phantom_timing1 = &subvp_pipes[1]->stream->mall_stream_config.paired_stream->timing;
 	struct dmub_cmd_fw_assisted_mclk_switch_pipe_data_v2 *pipe_data = NULL;
 
-	subvp0_prefetch_us = (uint64_t)(phantom_timing0->v_total - phantom_timing0->v_front_porch) * phantom_timing0->h_total * 1000000 /
-			(uint64_t)(phantom_timing0->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us;
-	subvp1_prefetch_us = (uint64_t)(phantom_timing1->v_total - phantom_timing1->v_front_porch) * phantom_timing1->h_total * 1000000 /
-			(uint64_t)(phantom_timing1->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us;
+	subvp0_prefetch_us = ((uint64_t)(phantom_timing0->v_total - phantom_timing0->v_front_porch) *
+			(uint64_t)phantom_timing0->h_total * 1000000) /
+			(((uint64_t)phantom_timing0->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us);
+	subvp1_prefetch_us = ((uint64_t)(phantom_timing1->v_total - phantom_timing1->v_front_porch) *
+			(uint64_t)phantom_timing1->h_total * 1000000) /
+			(((uint64_t)phantom_timing1->pix_clk_100hz * 100) + dc->caps.subvp_prefetch_end_to_mall_start_us);
 
 	// Whichever SubVP PIPE has the smaller prefetch (including the prefetch end to mall start time)
 	// should increase it's prefetch time to match the other
@@ -557,7 +559,7 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 		prefetch_delta_us = subvp0_prefetch_us - subvp1_prefetch_us;
 		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
 				((uint64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) *
-					(phantom_timing1->pix_clk_100hz * 100) + ((uint64_t)phantom_timing1->h_total * 1000000 - 1)) /
+					((uint64_t)phantom_timing1->pix_clk_100hz * 100) + ((uint64_t)phantom_timing1->h_total * 1000000 - 1)) /
 					((uint64_t)phantom_timing1->h_total * 1000000);
 
 	} else if (subvp1_prefetch_us >  subvp0_prefetch_us) {
@@ -565,7 +567,7 @@ static void update_subvp_prefetch_end_to_mall_start(struct dc *dc,
 		prefetch_delta_us = subvp1_prefetch_us - subvp0_prefetch_us;
 		pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
 				((uint64_t)(dc->caps.subvp_prefetch_end_to_mall_start_us + prefetch_delta_us) *
-					(phantom_timing0->pix_clk_100hz * 100) + ((uint64_t)phantom_timing0->h_total * 1000000 - 1)) /
+					((uint64_t)phantom_timing0->pix_clk_100hz * 100) + ((uint64_t)phantom_timing0->h_total * 1000000 - 1)) /
 					((uint64_t)phantom_timing0->h_total * 1000000);
 	}
 }
@@ -618,10 +620,10 @@ static void populate_subvp_cmd_pipe_info(struct dc *dc,
 
 	// Round up
 	pipe_data->pipe_config.subvp_data.prefetch_to_mall_start_lines =
-			((uint64_t)dc->caps.subvp_prefetch_end_to_mall_start_us * (phantom_timing->pix_clk_100hz * 100) +
+			((uint64_t)dc->caps.subvp_prefetch_end_to_mall_start_us * ((uint64_t)phantom_timing->pix_clk_100hz * 100) +
 					((uint64_t)phantom_timing->h_total * 1000000 - 1)) / ((uint64_t)phantom_timing->h_total * 1000000);
 	pipe_data->pipe_config.subvp_data.processing_delay_lines =
-			((uint64_t)(dc->caps.subvp_fw_processing_delay_us) * (phantom_timing->pix_clk_100hz * 100) +
+			((uint64_t)(dc->caps.subvp_fw_processing_delay_us) * ((uint64_t)phantom_timing->pix_clk_100hz * 100) +
 					((uint64_t)phantom_timing->h_total * 1000000 - 1)) / ((uint64_t)phantom_timing->h_total * 1000000);
 	// Find phantom pipe index based on phantom stream
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
-- 
2.25.1

