Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57CDC54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 044AD10E812;
	Wed,  7 Sep 2022 18:12:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C52510E80B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls+Fby/49+lnuulT7AzRhh99whn/ZazBCoW+m6aDh9gYM7uYHn4arXdMKk1p/fLXM6W2cEBv3c8lpV7SlzDpX/CbvtPjrAA1zs7YbDo7Kxx0zIXsKZq/0uPtOwunAs6oyONlShhIzLTKiKjrCsnrmquUy2JfiMM/u0JfJe1u16UXbgDfmLAZOu5cV8ZckfzhCEys0b4xX+Q/r3SapTUC11mKGH9wr7PpDXeXZV/25UoAWfHeFdDH4/6ZQoK2K16h90Imv1XrVPb0fSZ8CJwQPDn3ET2t1YgRdV1yl4t+NyadlAaEEcQtaz3pkMl9uNWYSXyKkAGr4wChR2lGstQiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEI+OpHjoE89Jy/GW4E+kXf3BfyZL2K45o72PJh13pE=;
 b=c6n1+LKuQcplOi5toSRyXTrKkTLNBVqF0m7S3KynJcjBg3mNfi/7+4X5EdlpxgfeGuzuXAodY2ywxS6pvVVO1BtkLt2gZvQ+HV6Gpk4tZTP1MfWBV7AMo5yWFq3WamhOoHFyFOF94ethdDLRLgjMkCYmBcrLjZO7eJzuW/d5dSL+veF0bWNhjk0jQytxrKK12jc2Wuw7ikzWXD+fSFQO+95MqhBI46gi9emNuk4EHr0mvCxQVSSUeKV+/zAGfE+Tsea4fLB5MKQFyx4i1Tc+GP9WLRRJEsVu2LtOpnT4BjjqokxAZDnZrv/NbyJp/kQsRwSfq8mCuX0ufXxasxlSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEI+OpHjoE89Jy/GW4E+kXf3BfyZL2K45o72PJh13pE=;
 b=bUQVSqShxhK+a/I4pQUnWQnyzF0AIM9SEzZNMJ816+L1xD3XWF7DjAVjvU8bvb9uNPRsVkTTkPtc/BBStzyQoBMK1NvAxhkvNokOsPa8Bkzun0XSI3n/3+BSVcBXwWfZCKTjBKz9NwOqOnrAyQXZkGi4PFNhdozjWm5CqkFfi2A=
Received: from DS7PR03CA0054.namprd03.prod.outlook.com (2603:10b6:5:3b5::29)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 18:12:32 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::fb) by DS7PR03CA0054.outlook.office365.com
 (2603:10b6:5:3b5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:29 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:27 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/21] drm/amd/display: Update viewport position for phantom
 pipes
Date: Wed, 7 Sep 2022 14:11:51 -0400
Message-ID: <20220907181200.54726-12-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|DM4PR12MB6328:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acbcbf5-a5ed-4e95-97c5-08da90fc86ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQb75uZG/wnutdD2u+YozlPaLjbo1t7TWR9QVcHIghXD7AOtu+og9hMoUnwwOa3KHtBshvaWN+1PBGEXk/MrU1V+HVKy4YkMtkga6HfGZ5QkGS509VBggKvoH+8jiCi37DBahoKOYVsRuAFmZVgWekBq74uohMO3YCroJ3N+Y1WhZqF0nsWuSrkqcQUr0I+K5LKwZxoaGdnhCnIghBtmh5UycRmdg4fJofWaLFaIW16xIV3rOM7XJxES5a3lLKnInlasXfqxQCnZbV3LSWgyswb47++RwckbL1Tcbqh1Hy6jShbCMoha6T1DNo0xtRrDnB3Ps1DRQJ8P7CZJQNcpr74/7ZFJADAncYTf0Redhc4W/CzjZYFzx6WTXPpP8xx2ZBUl3cWdR43hjnJCGlGzgQ3RhdiGTxtoVtu8KdqmXTyflWWlHu2z9Ys6a3+t8Y8OOy1PBWVEoJvzHvhoTTy0Gn8fEDPD6EpI2x2HPR/GQxchcvU1DAGke5Dt2RnWlOcwQMPIcv5MrPgX5BoYS8+g6S5dni8auLW5Yag0LxZu+2YD1xzUG+zzPpJcjrwUgWpjPVUAuSMrpj10smxZpImHRz9D/kvVjIC0JSsrx+WFteOAjyalWZNp8rJd03YihwZaQe0yk102YlaXEdgc+EPDdwIfClxvBeIrYVmSsLpjvrkJZGs77PJ0dUQWG2Y+7rvmmn9W0kj44V5AGrJBP63tiRTE55OYD/Mz1inpwK3b5ia2q9RwYk65S71XwXPraJcUrCuLcUDHQy9Y+/lwUr7YY6x8lYEK4Osh8zeTXlPb1AE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(40470700004)(46966006)(36860700001)(356005)(40460700003)(81166007)(82740400003)(316002)(6916009)(54906003)(15650500001)(5660300002)(44832011)(8936002)(70586007)(70206006)(8676002)(4326008)(2906002)(16526019)(336012)(186003)(2616005)(47076005)(426003)(41300700001)(40480700001)(83380400001)(1076003)(478600001)(6666004)(82310400005)(7696005)(86362001)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:29.6308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acbcbf5-a5ed-4e95-97c5-08da90fc86ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, "Lee,
 Alvin" <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lee, Alvin" <Alvin.Lee2@amd.com>

[Description]
In some cases the viewport position of the
main pipes can change without triggering a full update.
In this case the subvp phantom viewports must be updated accordingly.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  7 ++--
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 32 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  4 +++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  5 +++
 5 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 6271caca4d9a..6f8c344e321d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1898,8 +1898,11 @@ void dcn20_post_unlock_program_front_end(
 			 * can underflow due to HUBP_VTG_SEL programming if done in the regular front end
 			 * programming sequence).
 			 */
-			if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM)
-					dcn20_program_pipe(dc, pipe, context);
+			if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+				if (dc->hwss.update_phantom_vp_position)
+					dc->hwss.update_phantom_vp_position(dc, context, pipe);
+				dcn20_program_pipe(dc, pipe, context);
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index dbf2d7cc96c5..449459ca5a72 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1301,3 +1301,35 @@ void dcn32_update_phy_state(struct dc_state *state, struct pipe_ctx *pipe_ctx,
 	} else
 		BREAK_TO_DEBUGGER();
 }
+
+/* For SubVP the main pipe can have a viewport position change
+ * without a full update. In this case we must also update the
+ * viewport positions for the phantom pipe accordingly.
+ */
+void dcn32_update_phantom_vp_position(struct dc *dc,
+		struct dc_state *context,
+		struct pipe_ctx *phantom_pipe)
+{
+	uint8_t i;
+	struct dc_plane_state *phantom_plane = phantom_pipe->plane_state;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_MAIN &&
+				pipe->stream->mall_stream_config.paired_stream == phantom_pipe->stream) {
+			if (pipe->plane_state && pipe->plane_state->update_flags.bits.position_change) {
+
+				phantom_plane->src_rect.x = pipe->plane_state->src_rect.x;
+				phantom_plane->src_rect.y = pipe->plane_state->src_rect.y;
+				phantom_plane->clip_rect.x = pipe->plane_state->clip_rect.x;
+				phantom_plane->dst_rect.x = pipe->plane_state->dst_rect.x;
+				phantom_plane->dst_rect.y = pipe->plane_state->dst_rect.y;
+
+				phantom_pipe->plane_state->update_flags.bits.position_change = 1;
+				resource_build_scaling_params(phantom_pipe);
+				return;
+			}
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 221e31144d50..150d541f35b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -87,4 +87,8 @@ bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
 void dcn32_update_phy_state(struct dc_state *state, struct pipe_ctx *pipe_ctx,
 		enum phy_state target_state);
 
+void dcn32_update_phantom_vp_position(struct dc *dc,
+		struct dc_state *context,
+		struct pipe_ctx *phantom_pipe);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 28d220218133..c554929471af 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -105,6 +105,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.subvp_pipe_control_lock = dcn32_subvp_pipe_control_lock,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 	.update_phy_state = dcn32_update_phy_state,
+	.update_phantom_vp_position = dcn32_update_phantom_vp_position,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 52b4350c9cd8..d7a7b2790143 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -247,6 +247,11 @@ struct hw_sequencer_funcs {
 
 	void (*update_phy_state)(struct dc_state *state, struct pipe_ctx *pipe_ctx, enum phy_state target_state);
 
+
+	void (*update_phantom_vp_position)(struct dc *dc,
+			struct dc_state *context,
+			struct pipe_ctx *phantom_pipe);
+
 	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
 	void (*subvp_pipe_control_lock)(struct dc *dc,
 			struct dc_state *context,
-- 
2.34.1

