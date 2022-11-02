Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A25C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B94C310E4E6;
	Wed,  2 Nov 2022 16:03:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C333210E4E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiTsDawmaCOlSqlnlhZ9f3hru707VwFFrUk7STO+zhoi83G4+jASY3ZRJzyvTNteTefuqXoEeutkE2f8Xm2z1hjkv5IUvmwz2F1sDjQEWjFqbNQUa8DlV98ORVN9wn4sGNlOyiPgYF0pEumJ8uq8b9OqHfqXkYqrTN03poe8M35LLxLaqyfXbeRKbZNIHV3tuYXsy8cMMyGyKmrnREXh4dyh4jQe/6p0ie1SjxtqoupSNrDkHjDuPKWFH18UGqo47J2DlRcghM8NRn2rpvXtyo2QnqCgDtD7S11yf+CpqppZ83NDnonUB1Ej0EHmssT3UAmKEAx9+XW72yjvuZ+4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZhyZnIamru4zkzcnj5luKzDiWHdg8V1lGp865P3v5g=;
 b=Ethrj+m0oUq3egCL9/GaN3La9Y8tUPhI6XB1ap6zqLZ2563VS4EoGNKy7BKIkHg+SXhRWJxzUo7BZ/7euoDkvJzx4fxiczmxwyPGHdxF6hcyXBBtw1SQPvRJ3LEIob0P9AlSg1FGKzVSc6UjpjQ4/5zm0lbUS3tzgDPljdIy9SmqKuQFBX6+++JxzgbmOLXiSwfZI1J35w9ea8PglW1covDHtbZlkbaPb6SZXSHXAntNyUplXTlpr31SbTAzTPkhE2zk4QV+Cfhlx4UwJDl+fctXrwRyAGRBYeqCZWQlVqPpb/Vn6nD6ybD91jf5FHD6UwqQF7SdxM4+LnZiY9cn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZhyZnIamru4zkzcnj5luKzDiWHdg8V1lGp865P3v5g=;
 b=Ka9+/t4Ir7yekri27SeV8pk3iK8pqr4WFKoI3GallDSeoyueLSbWYvdUdEG8mMRkaEyoPJ5Kil7BCZY0aG4RSvFWD1G/BU5fBmO1HTE92inZs7Yv54LIozB3M0XOvMFeLvlVdE8TEc/Hup4rtMjUF+pjvD2eQ0maBS+anfuJXOc=
Received: from DM6PR06CA0005.namprd06.prod.outlook.com (2603:10b6:5:120::18)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 16:03:44 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::b7) by DM6PR06CA0005.outlook.office365.com
 (2603:10b6:5:120::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:42 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:38 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/22] drm/amd/display: Disable phantom OTG after enable for
 plane disable
Date: Thu, 3 Nov 2022 00:01:06 +0800
Message-ID: <20221102160117.506511-12-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|CH2PR12MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1b4ba3-0587-436d-3886-08dabcebd114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICqsnwbu9zpynX/Pqn4sG9XsWGzzv4NHSAGD0W60vTmIHZ4z24nEIMPHyYaARhl+/Lg4kHLKyReX2Sl+klFNF9SyROEoq/UuBEh0pI2lBuKDJzDwj+lpx56D+F1MM5hNJMe4P7MNg6JcIRBUGauMP9LfOE8ynoWUZwg81JzSsq/jsCS6jg6D5KlLA9/T64pZBpkHO2VANDQncq4L0B6abkVtfv/53W1FlTOAPnhnBSDK00C6oZBTk3cgOz5IHgbZWpuZryQz3kDKV4xeZP3iEu5IxRfS8+HBTfitnzYPQmse95ytOTrvgfDsQg8spPcPw5Mh3ZVlcSoOu6LSf+/nyVtMfocapW7vEsfFgWTxMIyQBHZ6eRDSYraMFCL0sWIpxJviG8RqOZxQ5Y2rD5YMFm5rAmXCZ9ujm1huWcopxbQRuMSHDnlrNlXevoDJpi3ZxrFLNfFc+/EzdFoXN8HYM6kz/jOte21Nr4lYNjV3If5oaZH5H70keSaklLcWR40ra2ydTF8qYzh99MaP1PKf86PXduQFuVbiXC/ykEt8Kx/YMP/xuWnoM0DnMgFuksoOxaFN4rYHDldBnJNCgVxYM26Yq7FNdBYUc7H9HOb9DjEx6ulwl02NPnhUAARr4a0UJLAq2XeK4zqJ1FejLyN9K2QLNKDOUiycHtG4I4/kaHIhenFezQRR7DpBrpP7rEFwbY310thdh9Tto9O7zMSFMMa1raLmTeTivouy4cx22zQv+fEtmjNibqyLNXQb1L2EWXkA0bcxQuS1aw6TxOq/aJ0yUgKi79qGVqh3vnrBLNBrPdHLX55lznLrwPWmgh9/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(336012)(47076005)(82740400003)(1076003)(426003)(186003)(5660300002)(2906002)(2616005)(40480700001)(26005)(8936002)(40460700003)(81166007)(41300700001)(82310400005)(356005)(36756003)(83380400001)(36860700001)(86362001)(6916009)(316002)(54906003)(7696005)(6666004)(70586007)(478600001)(8676002)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:43.6665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1b4ba3-0587-436d-3886-08dabcebd114
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Need to disable phantom OTG after it's enabled
  in order to restore it to it's original state.
- If it's enabled and then an MCLK switch comes in
  we may not prefetch the correct data since the phantom
  OTG could already be in the middle of the frame.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 14 +++++++++++++-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |  8 ++++++++
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index da808996e21d..9c3704c4d7e4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1055,6 +1055,7 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 	struct dc_state *dangling_context = dc_create_state(dc);
 	struct dc_state *current_ctx;
 	struct pipe_ctx *pipe;
+	struct timing_generator *tg;
 
 	if (dangling_context == NULL)
 		return;
@@ -1098,6 +1099,7 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 
 		if (should_disable && old_stream) {
 			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			tg = pipe->stream_res.tg;
 			/* When disabling plane for a phantom pipe, we must turn on the
 			 * phantom OTG so the disable programming gets the double buffer
 			 * update. Otherwise the pipe will be left in a partially disabled
@@ -1105,7 +1107,8 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			 * again for different use.
 			 */
 			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
-				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
+				if (tg->funcs->enable_crtc)
+					tg->funcs->enable_crtc(tg);
 			}
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
@@ -1122,6 +1125,15 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 				dc->hwss.interdependent_update_lock(dc, dc->current_state, false);
 				dc->hwss.post_unlock_program_front_end(dc, dangling_context);
 			}
+			/* We need to put the phantom OTG back into it's default (disabled) state or we
+			 * can get corruption when transition from one SubVP config to a different one.
+			 * The OTG is set to disable on falling edge of VUPDATE so the plane disable
+			 * will still get it's double buffer update.
+			 */
+			if (old_stream->mall_stream_config.type == SUBVP_PHANTOM) {
+				if (tg->funcs->disable_phantom_crtc)
+					tg->funcs->disable_phantom_crtc(tg);
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
index 2b33eeb213e2..2ee798965bc2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
@@ -167,6 +167,13 @@ static void optc32_phantom_crtc_post_enable(struct timing_generator *optc)
 	REG_WAIT(OTG_CLOCK_CONTROL, OTG_BUSY, 0, 1, 100000);
 }
 
+static void optc32_disable_phantom_otg(struct timing_generator *optc)
+{
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_UPDATE(OTG_CONTROL, OTG_MASTER_EN, 0);
+}
+
 static void optc32_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing)
 {
@@ -260,6 +267,7 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
 		.enable_crtc = optc32_enable_crtc,
 		.disable_crtc = optc32_disable_crtc,
 		.phantom_crtc_post_enable = optc32_phantom_crtc_post_enable,
+		.disable_phantom_crtc = optc32_disable_phantom_otg,
 		/* used by enable_timing_synchronization. Not need for FPGA */
 		.is_counter_moving = optc1_is_counter_moving,
 		.get_position = optc1_get_position,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index 65f18f9dad34..43eb61961e0f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -184,6 +184,7 @@ struct timing_generator_funcs {
 	bool (*disable_crtc)(struct timing_generator *tg);
 #ifdef CONFIG_DRM_AMD_DC_DCN
 	void (*phantom_crtc_post_enable)(struct timing_generator *tg);
+	void (*disable_phantom_crtc)(struct timing_generator *tg);
 #endif
 	bool (*immediate_disable_crtc)(struct timing_generator *tg);
 	bool (*is_counter_moving)(struct timing_generator *tg);
-- 
2.25.1

