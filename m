Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC2EC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744C610E481;
	Wed, 14 Dec 2022 20:22:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5997410E47A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcVxhcjAPSJ9jYjk52/1U2xCyhY8ncrsqGf2VIqYYqOKfk1bkIobrHQlHRo30/B6zwojpZ4BOO1CvhEC2vvG07U8nXG58x+qSZTTypTMsirK2EQWDo3rRCuDRpr6o36grUKXzRm2lB+/L5mpTVY5fGDm6Mm8ZOFFPhdOXiGZlABEgcGjp8anZ3fsKs4Xj+MvQLKhtkh9zIFIngqtaL5clNDELrybk/IY8OVBR43eeiy98/tjuQtOSaReP9rbYoglzx3JtmqGa5k1zBc2tXpTerrcapatbAOnLKdqAqv4deM4yGuu/4rgftYwDlYWGtTswMeUvBR2DLCussSz2H4AEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oBC3Fwd+Xvd8KDX7RPeDbwQTS3YdjrZesYRtV0v+T4=;
 b=F6tGiHCS3FoJOsGX7UB+rOSHyENhK/4Km5BhRoMm8CaBSsT/cl31Ps6O7MGA4SRbmgNlF9zNivurFx8nt5pFnyH9ufjoQm9Eler2CCfUT4BS8yf6G0UtO0rqlBPAPYscD6WuncISO0HDYPPhd8Och4jt9+qm7YdTFm3pYH3oilv65KQ0sKpaptNiMRELpTqOCYGpAb/pGbWxaIIw5A77HKpc42ReRk1+txVrRDon9HjIamOCvKK4dXeghLGYFLJf21ME9eZpA23/zhWjPbi/bgXEvpVDeKxRgvA4Qtu5KCBfDgn9ETg2UVSrD3cflKv8RoDylmLs+ag2v67EgC+LRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oBC3Fwd+Xvd8KDX7RPeDbwQTS3YdjrZesYRtV0v+T4=;
 b=RW8HdxC/qAQkXMEtNXwOPBX5hkfgHuQHI+p0c+WlEMLmz7+xnLVn6UcB4LpRxEE8JWP6fRsxlIK2k4s47nhWrB8xwQcHBy6Nz2cjvKonuh0rIjoJitELSPvsuhlx0ko+NXh2plxLH92+vrcZl5PTi80SXdoexQYzWwyzRCqXd74=
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 20:22:11 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::29) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:22:09 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:22:03 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/18] drm/amd/display: Fix crash when setting ABM
 pipe/backlight
Date: Wed, 14 Dec 2022 15:21:37 -0500
Message-ID: <20221214202141.1721178-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e350de6-c530-4793-4fb8-08dade10e184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6KBDCQX5c7mn0NydXh3MDZ+DSXaw+kVtcgXUqiKdYEVDhxbedsypqjShPxTA0p/3eYZMrm408aDlM7r7BPw3l77Oio6DjAQelACRcDHd8lpfTh1avzRaQS0KZsHu3Ab8EMTjrCE8n1qdmOJLlShK7WAsJ/uWn8Y6zlXjkM2JgNhrVd5dpSMmyU5T2lLnw33ZEGsSHr284rvexbOOKlK9QEdkBTHGkmB3isJ2xR7a3e8+oCdTak7AbmGGG0PBoG0mOLKj0+beVkkVV+TixWrXEiTz92DL1x1cr7FwWm0EnpcEUay79A7oLRNLtZZnm0UOKkTAEmDGtzwgjfuVPLv9B0qdaQ12GulcbJ6IsWdjXYyH1Qy8KvUMBCAEOziQ4aH2q/zR83fzijnq3vPkAxwX7MC8s8wO4+CyqizfLsx3LcLpQaUQdPG12oX9MCf0nCbtpT5K6yj53qm6ie7bsvQL2OvsVOaGlbJ2c+4Uf5T5xr4f2Qwv2vL6UXIm6HiM1w50xmlCHQyOUfEB1tpWtBU5Vxr9fRnh5Td8qc33ePyRi792XB37aeRtSG678k3JF3j5N+qM2DC7IfLfoPMoBnb9PVt8I4mG3j14BuF8MfY33GZPsZAP+S/U8cV2GNM5v9svLec6W+FskAfogyhwuGHegmDyy3P5rn5ULarcE0CgFC51l8dQiZdWC/ZfIO8mMVKkL5XPpILLfpKBoUzUBDn6XMvXs84r7DgYPMvZ1l0A+7c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(86362001)(40480700001)(40460700003)(26005)(186003)(70206006)(8676002)(336012)(41300700001)(70586007)(1076003)(4326008)(2616005)(478600001)(54906003)(44832011)(7696005)(6916009)(316002)(6666004)(36860700001)(356005)(81166007)(82740400003)(2906002)(426003)(8936002)(47076005)(83380400001)(5660300002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:10.9171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e350de6-c530-4793-4fb8-08dade10e184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387
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
 Leon Huang <Leon.Huang1@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Chun-Liang Chang <chun-liang.chang@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leon Huang <leon.huang1@amd.com>

[Why] Setting ABM pipe/backlight crashes the system when abm callback
func pointers are NULL For some usecase, driver would like to control
PWM level before ABM resource is ready. But recent flow refactor of ABM
didn't consider that use case.

[How] Rollback flow that sending inbox command to dmub directly when ABM
function pointers aren't ready.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Reviewed-by: Chun-Liang Chang <chun-liang.chang@amd.com>
---
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    | 81 ++++++++++++++++---
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 69b2f277d41e..5d77f7586816 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -137,6 +137,47 @@ void dcn21_PLAT_58856_wa(struct dc_state *context, struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->dpms_off = true;
 }
 
+static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+	uint32_t ramping_boundary = 0xFFFF;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
+	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
+	cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
+	cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
+	cmd.abm_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pipe_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
+}
+
+static void dmub_abm_set_backlight(struct dc_context *dc, uint32_t backlight_pwm_u16_16,
+									uint32_t frame_ramp, uint32_t panel_inst)
+{
+	union dmub_rb_cmd cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_set_backlight.header.type = DMUB_CMD__ABM;
+	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
+	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = frame_ramp;
+	cmd.abm_set_backlight.abm_set_backlight_data.backlight_user_level = backlight_pwm_u16_16;
+	cmd.abm_set_backlight.abm_set_backlight_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
+	cmd.abm_set_backlight.abm_set_backlight_data.panel_mask = (0x01 << panel_inst);
+	cmd.abm_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_backlight_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+
 void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 {
 	struct abm *abm = pipe_ctx->stream_res.abm;
@@ -150,9 +191,13 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 		return;
 	}
 
-	if (abm && panel_cntl && abm->funcs->set_pipe_ex) {
-		abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
+	if (abm && panel_cntl) {
+		if (abm->funcs && abm->funcs->set_pipe_ex)
+			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
 			panel_cntl->inst);
+		else {
+				dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE, panel_cntl->inst);
+		}
 		panel_cntl->funcs->store_backlight_level(panel_cntl);
 	}
 }
@@ -169,9 +214,13 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 		return;
 	}
 
-	if (abm && panel_cntl && abm->funcs->set_pipe_ex)
-		abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
-
+	if (abm && panel_cntl) {
+		if (abm->funcs && abm->funcs->set_pipe_ex)
+			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+		else {
+				dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+		}
+	}
 }
 
 bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
@@ -180,23 +229,31 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 {
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+	struct abm *abm = pipe_ctx->stream_res.abm;
 
 	if (dc->dc->res_pool->dmcu) {
 		dce110_set_backlight_level(pipe_ctx, backlight_pwm_u16_16, frame_ramp);
 		return true;
 	}
 
-	if (pipe_ctx->stream_res.abm != NULL) {
-		struct abm *abm = pipe_ctx->stream_res.abm;
+	if (abm != NULL) {
+
 		uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 
-		if (abm && panel_cntl && abm->funcs->set_pipe_ex)
-			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+		if (abm && panel_cntl) {
+			if (abm->funcs && abm->funcs->set_pipe_ex)
+				abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+			else {
+					dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+			}
+		}
+	}
 
-		if (panel_cntl && abm->funcs->set_backlight_level_pwm)
-			abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
+	if (abm && abm->funcs && abm->funcs->set_backlight_level_pwm)
+		abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
 			frame_ramp, 0, panel_cntl->inst);
-	}
+	else
+		dmub_abm_set_backlight(dc, backlight_pwm_u16_16, frame_ramp, panel_cntl->inst);
 
 	return true;
 }
-- 
2.39.0

