Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D97C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C33BE10E415;
	Wed, 22 Feb 2023 06:43:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C0410E4BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoLqkx9sT5Pb+07BuZECRwaJXsY5yZpuWrC6hcgfyLmZD2wGLJbgoRo2eB34FlFsCglt7/0Z0WyZhka4suHvxAA5dsxPe69jm5jEmxjnJQOjh+o1CoIDiiD3R4f/O5+LV9QpKVwfjCZQfmuHoZvTqjMDiUEfJcv+4UzB6yJPKQDlVK1n9dZdzrAlKa58cIYoChr3w05T17FU8CDaORy+HUDBmGXJu69V9HAN8vHuYMdb7Y1lzsaP7fHqMYvVjQQZCVSIk5nDWzQdd4PcdhCD2oYGihNZ/hb/8GthjQkB9mXpL42T6ovfG28uv62f6+lQy8/EXPV7rTzCMyTfY96cBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Avp+spYJc7csnHplXlrXhmsULlJySlOTuZclraFPu0=;
 b=RU2F6zQgwyNUCyKZwY8YAM1b+K3goL0NlRCSRy+cIazXzhXz8mei7R7rKHd7JINri3a2SFq5K6T+O3Ew4Gw8IGqax4hqrgsvGg79jRk5JYKTUbRfm9sy4ifyxw9hBtuucYr5oFA6OFoOiY2ruxXUC5SnLrwr1fBr1TQ8SFwDUmXSuZx9JVWnnDXy4LdGnBHyBEqn8Er2IT5GawxPIxxJLMDXonoGsIGASNr69wRUJzi/29k+dwoVCd0DmbMxyZkpmXWHWdXqDdhXliVyeucwZiSq8F7+ybrbK7KkjCkpZoojuo/7A6JHDUEnUg19icWUufS92WwkDqdP5mlYPpyZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Avp+spYJc7csnHplXlrXhmsULlJySlOTuZclraFPu0=;
 b=DNPyQEJ8BRHoji16t79+LgqicYyerrEPY5MJJ9WYzQmKVPED2Illnu/gwqAA0GbOf9m8pqiawCrw4qjKv5pkT98RX4kLaGKuLhoFzuobE6vw/YhIrG5qYMkKjRXfZILVjl4ITWYrbgNU41oKkKNqapV13wefGeGLoTjLL3BgHo4=
Received: from DS7PR03CA0264.namprd03.prod.outlook.com (2603:10b6:5:3b3::29)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 06:43:19 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::b2) by DS7PR03CA0264.outlook.office365.com
 (2603:10b6:5:3b3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19 via Frontend
 Transport; Wed, 22 Feb 2023 06:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.18 via Frontend Transport; Wed, 22 Feb 2023 06:43:18 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:43:11 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/20] drm/amd/display: enable DPG when disabling plane for
 phantom pipe
Date: Wed, 22 Feb 2023 01:40:39 -0500
Message-ID: <20230222064041.2824-19-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 87151aea-3105-48a1-d66b-08db14a0157a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgqcm+0Lot7NdlxJBUeFljeD+nZmiCSH9oHJXYF5fw+/Xv698mkESnyHsbkMmWCrOZVh28C3bs3BBYmJEKT1XItZAATWz6KKZz2mHB/JBUIBtQd7vrrCA+gcd2pxh5RbPikzAXqmIlDjgdAawzmZ7bIsXRr6MNxgFr0huf+MlQ4LrjgAb9AmBKFNL1YsK6wV7Y2ORQFIJUALj9b1kD/CNP6nYlGXhYB7u4KAMzoJ8rEAyYNtNh2KhzJcapHtPO8wl+5tuzlnsuZzKXXN9XcbjYv3LWM8iu2Q/Ck9yktNQivDwKVuocyYFZH+TSgy58SZ+1US4f2j6OEf3UYMqAblYt4H/X5T37dTfuhyeYtviCehlCCH3ijt4E+/wT6tPAzQElO4U00l+XjQCXwJLc+6D/UiyglutChz91egr/uQ6b0E8AY7TC7KcgXWvrw8eErDZWzEJqNxRVItrvx5D42kyn4AC5Y7T05YioJYFW+YBSIiw3OKCcRwh5c6c5Z+2ea8Vu2rQNDwuQuQ9iapZD9Clh9EtTfzRYKYv0xEfhdly1tdsKCHnrECUE3LCuVbWj9mahTavIQzdkMfXTMCJBVgxCSeeKTGzyLy1Sphx2JfCmgRXWwte7Xy8EHFF88LoMxtgKyG4Qh/W5xJ1wqJDG48Eb98ylGhRVLZ/ExTUZHHZeehniU0fcDSdL5BHZXKALjoWBW+zwyzaVajDfKoXrr+jq87oysSYzIdLQwilAfhRFg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(82310400005)(36860700001)(1076003)(47076005)(426003)(83380400001)(36756003)(40460700003)(356005)(316002)(82740400003)(81166007)(54906003)(2616005)(40480700001)(478600001)(16526019)(6666004)(186003)(26005)(336012)(8936002)(2906002)(5660300002)(6916009)(41300700001)(4326008)(8676002)(44832011)(70586007)(86362001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:43:18.9970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87151aea-3105-48a1-d66b-08db14a0157a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
In disable_dangling_plane, for phantom pipes, we enable OTG so
disable programming gets the double buffer update.  But this
causes an underflow to occur.

[How]
Enable DPG prior to enabling OTG.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 47 +++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ca048e38c4d4..8d7b2e5516b0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -73,6 +73,8 @@
 
 #include "dc_trace.h"
 
+#include "hw_sequencer_private.h"
+
 #include "dce/dmub_outbox.h"
 
 #define CTX \
@@ -1063,6 +1065,44 @@ static void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *contex
 	}
 }
 
+static void phantom_pipe_blank(
+		struct dc *dc,
+		struct timing_generator *tg,
+		int width,
+		int height)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	enum dc_color_space color_space;
+	struct tg_color black_color = {0};
+	struct output_pixel_processor *opp = NULL;
+	uint32_t num_opps, opp_id_src0, opp_id_src1;
+	uint32_t otg_active_width, otg_active_height;
+
+	/* program opp dpg blank color */
+	color_space = COLOR_SPACE_SRGB;
+	color_space_to_black_color(dc, color_space, &black_color);
+
+	otg_active_width = width;
+	otg_active_height = height;
+
+	/* get the OPTC source */
+	tg->funcs->get_optc_source(tg, &num_opps, &opp_id_src0, &opp_id_src1);
+	ASSERT(opp_id_src0 < dc->res_pool->res_cap->num_opp);
+	opp = dc->res_pool->opps[opp_id_src0];
+
+	opp->funcs->opp_set_disp_pattern_generator(
+			opp,
+			CONTROLLER_DP_TEST_PATTERN_SOLID_COLOR,
+			CONTROLLER_DP_COLOR_SPACE_UDEFINED,
+			COLOR_DEPTH_UNDEFINED,
+			&black_color,
+			otg_active_width,
+			otg_active_height,
+			0);
+
+	hws->funcs.wait_for_blank_complete(opp);
+}
+
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 {
 	int i, j;
@@ -1121,8 +1161,13 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			 * again for different use.
 			 */
 			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
-				if (tg->funcs->enable_crtc)
+				if (tg->funcs->enable_crtc) {
+					int main_pipe_width, main_pipe_height;
+					main_pipe_width = old_stream->mall_stream_config.paired_stream->dst.width;
+					main_pipe_height = old_stream->mall_stream_config.paired_stream->dst.height;
+					phantom_pipe_blank(dc, tg, main_pipe_width, main_pipe_height);
 					tg->funcs->enable_crtc(tg);
+				}
 			}
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
-- 
2.34.1

