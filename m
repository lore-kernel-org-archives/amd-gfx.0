Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4CBC77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF9110EDC1;
	Fri, 14 Apr 2023 15:54:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3607A10EDB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTboNeSQhQV/zkLfCm21batmOG6l3zBUAnBa2hILOvdhhfszRcSo7BfTD4Za4q5N1AVphNLgDZeUmdvXvJiWyOrplbyTP8ieNuuefy74Sw3E1wuzoS+gxJHyetR7/WaTuVJPH7ul0HI86kh8xCF7NCrhtEtGZYDbQiekQQ3ROY45rYNtmMU/hUs81OByWeV5M7Gh4tWi7fYUnPr4lcqwG3ml+NBMUCHMegzWE9sObnuMdQnm9a5rLRlySKJryX/QAMCkE+LnY5S6nXMBnps07Eschp9tMtU3KUGc7Uc6/kk662UVP5Eg11uouvEFx3WC6xrQO1FJrbzoctahAnivqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUComBYWZZDrkq17O88JQgJnn2p1nPaQh/vkC/H5k8o=;
 b=czM6uZxNYsLJfytx228mPDAjL1WsZUIWQCU2Y6LiRhC7SBxEXHJ72cfND3pyZTvJN2uz0JWvBKUISjwN8Ome+JtPTw4mhPGRn7gfxcjuq1f+x0IJAhjCzPBaARl6eNPdnK6wSP2kax+Og9v7owkw7Nlv+1s2JqwUF9/r5QaAVcfzg+uhWxcVucDOFTlkeNpPYeW8YXAuK8b8tZu8SIsu+cmZKVDUOkd/ZiCIqFwZ2/zWe8wuqLg5us5BaIEKuigJEQ+7iX5Fp9X3b5m+XWN/FfYx8NDj/N4z8+RkWgWQwVagr+uDv8lZvejMlgTaaj4TcKabU65GiE3tHzbgbm0ZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUComBYWZZDrkq17O88JQgJnn2p1nPaQh/vkC/H5k8o=;
 b=UIr0ziPiMCf7srKc4XcbzjMs4YSUP9EqfmJ8ueBEshwTAk2aorWYe5xVVgEiFwLXFkglmZ7G8nDSoURVHAkASoNneY8BKFWF7IdgaGZsvtcblDHc1FD7iEMzYT/gdRTbBXZEGyS0j1geUif/dfdMdS2jFT6aLZs+dcn+4LwZFfA=
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:01 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::1) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:54:01 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:53:58 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/66] drm/amd/display: Fix ABM pipe/backlight issues when
 change backlight
Date: Fri, 14 Apr 2023 11:52:33 -0400
Message-ID: <20230414155330.5215-10-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ee1242-00a6-492b-e8da-08db3d007726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jl2DGu5fEQ931kQISQr5JeLJN78yXHPw7twMXoFKN+quNlVKMuELVrNyillkx6EJF8ABgkXZ9kESHxGo3VKnCPUGkO5januMAp65PwgSozUu/ecpAsFH897VEw15ql5e9+Qoks4AgAeHEk1b3PiNxkvWHV2Oyu1BLXfECUtumVmue0KxEswAED94plSFXFcHS7r5oV4fDWOSS8UHtB08lYRRrwAb6gM+p7XMGr5U1Fwq2oz8siBXfg/VQUAMEm7JHk10HCLjeK09QK1kde5Cdi7rt1s3GbSR6lFD8a67lvBArjiRL4tI4idp+VYucbbO8p3CgqsPM4ls5g6qVd5DVLs/SrINsX/GQ7N5zLeup0uiWp1RBgo+b3DGAO8BgLu262VUQJlZTIA5aPgwxo97h6Z0bJHfxoeUAgQ35QRbK1FtuPQuduAk0Qc84dhhi8GVsvFuR2aRSWOV39/ZoA/jTaXVfbW7ps2fZ1rwVkHng2ZtSgWBP8js8fp1krEdHqnTXj3gI6EncNDimV65Qfc92TnPTKuxXd8NKzHD92ijvLnEE0MGRE9Cr6KilsGs+w5RWdT5LjBKGFHk++Cfu5SCdFmBatRtmsFMsRVHcwP5OZa7tcS+iQ3tfXVlw7qptTDWurbxYX6MtOlRGOWL+Vqd0JDI+z+FWAlmKJIQ/RjU2+F9l36ymyBWbOTvRy1R4AFj+KZyQoWi/eKTaRwRm2agvN9zAIcwif3yTUhqLRI0HxM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(186003)(26005)(16526019)(1076003)(54906003)(40480700001)(478600001)(81166007)(356005)(2906002)(8676002)(8936002)(36860700001)(83380400001)(41300700001)(426003)(5660300002)(47076005)(2616005)(336012)(82310400005)(6916009)(4326008)(316002)(70206006)(70586007)(82740400003)(86362001)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:01.0765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ee1242-00a6-492b-e8da-08db3d007726
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leon Huang <Leon.Huang1@amd.com>

[Why]
set ABM pipe/backlight gets some issues when abm callback func pointers
are NULL. For some usecase, driver would like to control PWM level before
ABM resource is ready. However, recent flow refactor of ABM didn't
consider that use case.

[How]
Rollback flow that sending inbox command to dmub directly when ABM
function pointers aren't ready.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
---
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    | 64 ++++++++++++++-----
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 2a182c2f57d6..1c6477d73c8e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -159,6 +159,25 @@ static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t optio
 	return true;
 }
 
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
@@ -173,8 +192,12 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 	}
 
 	if (abm && panel_cntl) {
-		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
-				panel_cntl->inst);
+		if (abm->funcs && abm->funcs->set_pipe_ex) {
+			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE,
+			panel_cntl->inst);
+		} else {
+			dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_IMMEDIATELY_DISABLE, panel_cntl->inst);
+		}
 		panel_cntl->funcs->store_backlight_level(panel_cntl);
 	}
 }
@@ -191,8 +214,13 @@ void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 		return;
 	}
 
-	if (abm && panel_cntl)
-		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+	if (abm && panel_cntl) {
+		if (abm->funcs && abm->funcs->set_pipe_ex) {
+			abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+		} else {
+			dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+		}
+	}
 }
 
 bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
@@ -210,21 +238,23 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 		return true;
 	}
 
-	if (abm && panel_cntl)
-		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+	if (abm != NULL) {
+		uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
 
-	memset(&cmd, 0, sizeof(cmd));
-	cmd.abm_set_backlight.header.type = DMUB_CMD__ABM;
-	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
-	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = frame_ramp;
-	cmd.abm_set_backlight.abm_set_backlight_data.backlight_user_level = backlight_pwm_u16_16;
-	cmd.abm_set_backlight.abm_set_backlight_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
-	cmd.abm_set_backlight.abm_set_backlight_data.panel_mask = (0x01 << panel_cntl->inst);
-	cmd.abm_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_backlight_data);
+		if (abm && panel_cntl) {
+			if (abm->funcs && abm->funcs->set_pipe_ex) {
+				abm->funcs->set_pipe_ex(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+			} else {
+				dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
+			}
+		}
+	}
 
-	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
-	dc_dmub_srv_cmd_execute(dc->dmub_srv);
-	dc_dmub_srv_wait_idle(dc->dmub_srv);
+	if (abm && abm->funcs && abm->funcs->set_backlight_level_pwm)
+		abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
+			frame_ramp, 0, panel_cntl->inst);
+	else
+		dmub_abm_set_backlight(dc, backlight_pwm_u16_16, frame_ramp, panel_cntl->inst);
 
 	return true;
 }
-- 
2.34.1

