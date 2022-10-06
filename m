Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114B2C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA0C210E8B1;
	Thu,  6 Oct 2022 21:27:53 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5E910E8B4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3DCUkPWIN0cCVdEA8bbCeSoN+lnxNF1nh+oGtszR9x3cPO4QPQSzDXxA5SO+8fo+SFVqxHuJJ+L4IoRwFl2o1gRUmz6mSHNV8EZ+iehA8+ec2LH83KJLU62GqRg01FxHUCqpdg9Y4LtwoiZttr98yDWoowHVijO7KnFqvnmB8xHmFvlnMYXW1YHlJN6hlOYWP052G6iSCR2GzpASCTiVO9ycBSFaFwKzL+tJm9bkniyo1Ch+RCZAW2shnCqIZQO8Y9C4ZOkrdgFKrxeAo5MI5klR/4GY8XdAZX9jO8Y65NseOciTxf63dHYeoK3syZoGt21r9Nlbyth0YBWbgdZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Hl/gGsHCo8ibWq+N4FtHK2z21iifvTAeGbGHPatbJQ=;
 b=g6mPqawOzYYFNVn6nhvSTuRhOWvF/Ds3cW0PdqM1bxqu/V9bTDeVXgcwFinxjycYD1aW86eXjvq1x0p/ZvcDJ77thQzMncgW7+Z1AOsj4vdZtMxIrAUI0qupvMn9G08J+V0Gd6MpBP1s9nqjnO6T0171rTWkYOLWv+GSB4vn4dCYY+4ytxV+fvVqPjd15UqpKh3t9SX9DN0anYeUCAxOWxiP7e83YDyGQFX9NNAPMi9Y0xy+5HEsbWyehIyCML7TeSDkG4RhMPk7bZFTXbgEhazzUnNQch2ho3uCvveB6SY9LhYHLe5Sk3RraIRiw6vzPPyvDEhI0GQjkEPNfwjz/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Hl/gGsHCo8ibWq+N4FtHK2z21iifvTAeGbGHPatbJQ=;
 b=GwhgBbkOC361cmBjglOyc+u5mbLRScUF+UsprxIXLiPKanpK+VhOjy9T+EtBd6kfewA7TTf7RjOWDb/2sbCSzgS5q6KxEEw6HDFD1UOqnzlSUrGWahiCPKx8sbKl2+sKUfauhihaoHuOd1MQaioleO0wsVDVkDZEP5+Q0tTJJqY=
Received: from BN8PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:94::29)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 6 Oct
 2022 21:27:40 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::80) by BN8PR03CA0016.outlook.office365.com
 (2603:10b6:408:94::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:40 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:38 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/23] drm/amd/display: Add a helper to map
 ODM/MPC/Multi-Plane resources
Date: Thu, 6 Oct 2022 17:26:36 -0400
Message-ID: <20221006212650.561923-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7ab56c-6f0b-4616-4375-08daa7e19924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIxWXbzAAiHIc5XK/97YJdc/kG4LxfQr4QNvCsJcPeJIUXdmf0Mzpj3B8h09DH33RrHVceR7XZXvEcT1L3pIgveLvPmWoa3CFzew4h0Uozv23NV2nSG9wgelujWRUUqXZxtfGOFy9jA1Fv4MKNBVQuSGieO3dqb3i7Q2pJiPFx+iAJIGEvUH2/J0z6j3ff3AzAahjr0uswSqdNX9PglLHNtNa0SykpXqJXpIukDoieCO5H3wM5ykukK7IxArNJlNPz4jX2eVr8G0rQ6HTUkf2LWF/y/DOi+PgNtSBr6yNoKIkjyD3R9USt5EAsEF5/sQOTXGT5l4yaKxLIiifJxzOM3Q0EoHqgYNLHWl9zyuboXGLzbiER0Oa1t1nxdNIldmZRfjwPPa5ZpWb82sR1QExp9iKnvG9PjXti/vC+AXfAYADP0aksieBub5hYS4+JUIX6vwPTKNafmlczxx0xO1OjawE6oaOjpVl7MnQd0OuAbGgupLiTMVzoy3b22yFMs3APuLpTkm9tCYDaxi9n6gwG2gmz4IGbB8uP21zri1QJxvFQ7FB2evhe9HVqHRS9Iv3XRjFp+ZmRHqYlsgIe8pi5FDA2pzR/ETgKmc0ECKILFbNLBhoNLvoUf7ejwkv/RCj2s+rmTTwrJSXEXB09cvy7aR757MtUQamcJ/6bDvdJ3ylwWD+Zq+rbNPxpt+JxiKRZfOGoCq9NUAPVzPccy+J5GwwmVirTjZ8zmzi/xGurZAUzC1a2RK5YsXuYnpduhtphBg15H6yzqyY6ZvrmVOZ3RvyiCA25W+sUP6RDOj8IZgvWVyl8Eh/ShW8e87pezZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(8676002)(6916009)(54906003)(82310400005)(4326008)(83380400001)(36860700001)(82740400003)(40480700001)(36756003)(81166007)(40460700003)(356005)(2906002)(336012)(478600001)(186003)(1076003)(26005)(41300700001)(70206006)(70586007)(316002)(16526019)(426003)(2616005)(47076005)(44832011)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:40.4336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7ab56c-6f0b-4616-4375-08daa7e19924
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <Jun.Lei@amd.com>

[Why & How]
Add a helper to map ODM/MPC/Multi-Plane
resources from DC

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Jun Lei <jun.lei@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 49 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  4 ++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  6 +++
 5 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 8ee0d946bb2f..4a6e867369b8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1747,7 +1747,6 @@ bool dc_remove_plane_from_context(
 
 	for (i = 0; i < stream_status->plane_count; i++) {
 		if (stream_status->plane_states[i] == plane_state) {
-
 			dc_plane_state_release(stream_status->plane_states[i]);
 			break;
 		}
@@ -3683,4 +3682,52 @@ bool is_h_timing_divisible_by_2(struct dc_stream_state *stream)
 				(stream->timing.h_sync_width % 2 == 0);
 	}
 	return divisible;
+}
+
+bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
+		const struct dc *dc,
+		struct dc_state *state,
+		struct pipe_ctx *pri_pipe,
+		struct pipe_ctx *sec_pipe,
+		bool odm)
+{
+	int pipe_idx = sec_pipe->pipe_idx;
+	struct pipe_ctx *sec_top, *sec_bottom, *sec_next, *sec_prev;
+	const struct resource_pool *pool = dc->res_pool;
+
+	sec_top = sec_pipe->top_pipe;
+	sec_bottom = sec_pipe->bottom_pipe;
+	sec_next = sec_pipe->next_odm_pipe;
+	sec_prev = sec_pipe->prev_odm_pipe;
+
+	*sec_pipe = *pri_pipe;
+
+	sec_pipe->top_pipe = sec_top;
+	sec_pipe->bottom_pipe = sec_bottom;
+	sec_pipe->next_odm_pipe = sec_next;
+	sec_pipe->prev_odm_pipe = sec_prev;
+
+	sec_pipe->pipe_idx = pipe_idx;
+	sec_pipe->plane_res.mi = pool->mis[pipe_idx];
+	sec_pipe->plane_res.hubp = pool->hubps[pipe_idx];
+	sec_pipe->plane_res.ipp = pool->ipps[pipe_idx];
+	sec_pipe->plane_res.xfm = pool->transforms[pipe_idx];
+	sec_pipe->plane_res.dpp = pool->dpps[pipe_idx];
+	sec_pipe->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
+	sec_pipe->stream_res.dsc = NULL;
+	if (odm) {
+		if (!sec_pipe->top_pipe)
+			sec_pipe->stream_res.opp = pool->opps[pipe_idx];
+		else
+			sec_pipe->stream_res.opp = sec_pipe->top_pipe->stream_res.opp;
+		if (sec_pipe->stream->timing.flags.DSC == 1) {
+			dcn20_acquire_dsc(dc, &state->res_ctx, &sec_pipe->stream_res.dsc, pipe_idx);
+			ASSERT(sec_pipe->stream_res.dsc);
+			if (sec_pipe->stream_res.dsc == NULL)
+				return false;
+		}
+		dcn20_build_mapped_resource(dc, state, sec_pipe->stream);
+	}
+
+	return true;
 }
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 66b7482d2e72..b0afcff94591 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1191,6 +1191,8 @@ struct dc_plane_state {
 	enum dc_irq_source irq_source;
 	struct kref refcount;
 	struct tg_color visual_confirm_color;
+
+	bool is_statically_allocated;
 };
 
 struct dc_plane_info {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 819de0f11012..2a3f5a485b2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1372,7 +1372,7 @@ static struct pipe_ctx *dcn32_find_split_pipe(
 	return pipe;
 }
 
-static bool dcn32_split_stream_for_mpc_or_odm(
+bool dcn32_split_stream_for_mpc_or_odm(
 		const struct dc *dc,
 		struct resource_context *res_ctx,
 		struct pipe_ctx *pri_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 1fd7ad853210..9498105c98ab 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -39,6 +39,8 @@
 #include "panel_cntl.h"
 
 #define MAX_CLOCK_SOURCES 7
+#define MAX_SVP_PHANTOM_STREAMS 2
+#define MAX_SVP_PHANTOM_PLANES 2
 
 void enable_surface_flip_reporting(struct dc_plane_state *plane_state,
 		uint32_t controller_id);
@@ -492,6 +494,8 @@ struct dcn_bw_output {
 	struct dcn_watermark_set watermarks;
 	struct dcn_bw_writeback bw_writeback;
 	int compbuf_size_kb;
+	unsigned int legacy_svp_drr_stream_index;
+	bool legacy_svp_drr_stream_index_valid;
 };
 
 union bw_output {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index c37d1141febe..5040836f404d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -230,4 +230,10 @@ const struct link_hwss *get_link_hwss(const struct dc_link *link,
 
 bool is_h_timing_divisible_by_2(struct dc_stream_state *stream);
 
+bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
+		const struct dc *dc,
+		struct dc_state *state,
+		struct pipe_ctx *pri_pipe,
+		struct pipe_ctx *sec_pipe,
+		bool odm);
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.25.1

