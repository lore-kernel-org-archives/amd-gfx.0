Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC794C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48BA610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A48BA610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC566E20F;
	Fri, 24 Sep 2021 19:09:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6FC6E210
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:09:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnQCwfMWRn1NNi6JR4lch8tI6W1b3LDx546tnnntu/7lA7mu0LVujZGGMyF5HfdCVU3dzRzmazlMaJBshCF1oR8p58DQmM17/Emw2sQK6PgRwEjT/KrmhVz4xtEDlXA1PnkG9uWEasdeIfQcs7Q1cPjiTUldNGt71BX4RNsZaNqRpqY6Pj7TpIB0E4LDSBZavALNEoVzdTzCBr82bglUyXMKqfCD6wC1leXkZvi1oojak0H0x0bOVMu6FmdY3B2zvmowt5lwGaJ/ZNoSjYwOR9z6vnjESE9qhaTLS8n1jUTDVOq0wLa/J5/geEtcgWG4opdh1Y3ovOhur1SHARjAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Ab88xKK37TioklC5SC5hD5t9y0Tl/DuW4RafbEFOjzQ=;
 b=ar+KcWi0Mk9UnYLWvwqc6vnc+tEnyV0VgnLeRS4c/L3rvpL3/wU0os3mnBiQEk91BaEmSgPqH7j4MkTo2hSqhoRnY3XtJ96XplKsOfbuzZJCFeWB6USJYn2IjS+yGQ4ip/WdBe+NfEnGHjO5lGFt1k8Y64Zjf0Tj1sD89tv46obx+ERp7Awy6jZiytClRneyW3OONX9xYSNQwkgTGmUT9KNfy7POKFCdjrnwuqcskbsMEmqFwQCW7WIKsg+HsAyex8Ze/PSmMl/DSGnoVo1frqGrEf74dwHwp4Gfs44ER1fFZP4cnuJuPyDTf6wWHkuJecJS8U4Xhtxs/Zzt2YxqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab88xKK37TioklC5SC5hD5t9y0Tl/DuW4RafbEFOjzQ=;
 b=fFs0C2YofLEhFkHfKYc55KweQ/NS45L5b9egHT1iau/zXcWvFdBkqUKHSPlQZ1qKCXj5e3Tj9bzFzoWumNq5LWr2RW5mAVykIz9XRQ92i7vLSoZSwcmSdtQRB7OmCvZCXScnc+Zajf3OFgEP8PNvUePcv/+iBFcM/d+sob2dL3M=
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by DM6PR12MB3244.namprd12.prod.outlook.com (2603:10b6:5:18c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 19:09:55 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::80) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18 via Frontend
 Transport; Fri, 24 Sep 2021 19:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:09:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:09:52 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:09:50 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Eric Yang
 <Eric.Yang2@amd.com>, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH 04/24] drm/amd/display: add vsync notify to dmub for abm pause
Date: Fri, 24 Sep 2021 15:09:14 -0400
Message-ID: <20210924190934.1193379-5-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 625613d0-5759-40f4-2ecb-08d97f8ee48d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3244:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3244CFD9CC5E3AAC91F02D9EEBA49@DM6PR12MB3244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xP28Ww3t8Y6+tcYo1gix35IzPFA59nk/sL61g0YsHC8G7SmtnGs2gGRtWW5MRde1ElCoJ18gcUUj3o1d09YBEhT9sNHYL5DgH0jfCEU07K1pFQ6qfwuFmkkgLpZO9B5+v5P6nM7w70G4hQjBv0wh0zqQ7Pc8B1qcJDVIT33lXWSnGf1T/61Uf+xPwMcFrE2eaZKrysh2hFzwA5gRjlJWfC9sGgY8Fl82c6fxr15HH11mS+8+KHW4Ge5LosqGNnSTMzkFsguMNu9vHBqkZhdAGtCCE/pPPJKHRpL5mlPOL8+P5X7qqt+BHjD3M65jHi2Cs/by/+RAq56RTGVdJRUk+IdpcJpA0qrUsJVdiEkiaHbamoE6UGkMcJo65a2uIBd1u4W8T8/vbE4xoyAhsphQdS7PE+upTjJhtDoTdtpBPXHSNlW301KNqdkSnYjZRLKIbq1AxbUxWmdU2lhytfZhcFwQ0HEpuuTcTdtXeDQJJP611l+o9Kzf2UwwxDXBIc/BxSGI7nEBZIPAKAD88DxvH4zksoLWya5ZmnnIjCRXLB6Rl4VtndeeunBzCjM6xF2Rnzh+nxn2VpqXxDebYAFYHBkY8c6JWQRV2Zu44y4AKiMT5SpHh4Jzlrbh9/W0mVaLrWMneD8Cece3vy+ZI6+SiBVRdmKJ4Ih6WyZqHg0CFQRK5tjHEcxYT5PsbdHdOHmgK2fzfMx9nv5jvgYzeC2jts8imBtjDE9hWi1OgQ9rszA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6916009)(70206006)(86362001)(83380400001)(356005)(508600001)(2616005)(82310400003)(8676002)(36756003)(81166007)(6666004)(70586007)(5660300002)(54906003)(8936002)(4326008)(47076005)(1076003)(186003)(2906002)(316002)(426003)(336012)(26005)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:09:54.4648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625613d0-5759-40f4-2ecb-08d97f8ee48d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3244
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

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
To prevent unnecessary wake up of DMCUB when ABM is enabled without PSR
enabled, driver will notify DMCUB to stop ABM's vertical interrupts
if vsync is disabled and steady state is reached.

[How]
Send inbox message to notify ABM pause based on vsync on/off

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 54 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 21 ++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 54 +++++++++++++++++++
 5 files changed, 132 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 331a7517176b..644005846433 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3536,3 +3536,57 @@ void dc_disable_accelerated_mode(struct dc *dc)
 {
 	bios_set_scratch_acc_mode_change(dc->ctx->dc_bios, 0);
 }
+
+
+/**
+ *****************************************************************************
+ *  dc_notify_vsync_int_state() - notifies vsync enable/disable state
+ *  @dc: dc structure
+ *	@stream: stream where vsync int state changed
+ *	@enable: whether vsync is enabled or disabled
+ *
+ *  Called when vsync is enabled/disabled
+ *	Will notify DMUB to start/stop ABM interrupts after steady state is reached
+ *
+ *****************************************************************************
+ */
+void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bool enable)
+{
+	int i;
+	int edp_num;
+	struct pipe_ctx *pipe = NULL;
+	struct dc_link *link = stream->sink->link;
+	struct dc_link *edp_links[MAX_NUM_EDP];
+
+
+	if (link->psr_settings.psr_feature_enabled)
+		return;
+
+	/*find primary pipe associated with stream*/
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream == stream && pipe->stream_res.tg)
+			break;
+	}
+
+	if (i == MAX_PIPES) {
+		ASSERT(0);
+		return;
+	}
+
+	get_edp_links(dc, edp_links, &edp_num);
+
+	/* Determine panel inst */
+	for (i = 0; i < edp_num; i++) {
+		if (edp_links[i] == link)
+			break;
+	}
+
+	if (i == edp_num) {
+		return;
+	}
+
+	if (pipe->stream_res.abm && pipe->stream_res.abm->funcs->set_abm_pause)
+		pipe->stream_res.abm->funcs->set_abm_pause(pipe->stream_res.abm, !enable, i, pipe->stream_res.tg->inst);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e5dcbee6e672..b194a2727bd8 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1313,6 +1313,8 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src);
 enum dc_irq_source dc_get_hpd_irq_source_at_index(
 		struct dc *dc, uint32_t link_index);
 
+void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bool enable);
+
 /*******************************************************************************
  * Power Interfaces
  ******************************************************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 54a1408c8015..fb0dec4ed3a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -203,12 +203,33 @@ static bool dmub_abm_init_config(struct abm *abm,
 	return true;
 }
 
+static bool dmub_abm_set_pause(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int stream_inst)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+	uint8_t panel_mask = 0x01 << panel_inst;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.abm_pause.header.type = DMUB_CMD__ABM;
+	cmd.abm_pause.header.sub_type = DMUB_CMD__ABM_PAUSE;
+	cmd.abm_pause.abm_pause_data.enable = pause;
+	cmd.abm_pause.abm_pause_data.panel_mask = panel_mask;
+	cmd.abm_set_level.header.payload_bytes = sizeof(struct dmub_cmd_abm_pause_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
+	return true;
+}
+
 static const struct abm_funcs abm_funcs = {
 	.abm_init = dmub_abm_init,
 	.set_abm_level = dmub_abm_set_level,
 	.get_current_backlight = dmub_abm_get_current_backlight,
 	.get_target_backlight = dmub_abm_get_target_backlight,
 	.init_abm_config = dmub_abm_init_config,
+	.set_abm_pause = dmub_abm_set_pause,
 };
 
 static void dmub_abm_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index 142753644377..ecb4191b6e64 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -54,6 +54,7 @@ struct abm_funcs {
 			const char *src,
 			unsigned int bytes,
 			unsigned int inst);
+	bool (*set_abm_pause)(struct abm *abm, bool pause, unsigned int panel_inst, unsigned int otg_inst);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 03110f59b50d..4a41549109dd 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1732,6 +1732,11 @@ enum dmub_cmd_abm_type {
 	 * Enable/disable fractional duty cycle for backlight PWM.
 	 */
 	DMUB_CMD__ABM_SET_PWM_FRAC	= 5,
+
+	/**
+	 * unregister vertical interrupt after steady state is reached
+	 */
+	DMUB_CMD__ABM_PAUSE	= 6,
 };
 
 /**
@@ -2087,6 +2092,50 @@ struct dmub_rb_cmd_abm_init_config {
 	struct dmub_cmd_abm_init_config_data abm_init_config_data;
 };
 
+/**
+ * Data passed from driver to FW in a DMUB_CMD__ABM_PAUSE command.
+ */
+
+struct dmub_cmd_abm_pause_data {
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * OTG hw instance
+	 */
+	uint8_t otg_inst;
+
+	/**
+	 * Enable or disable ABM pause
+	 */
+	uint8_t enable;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[1];
+};
+
+/**
+ * Definition of a DMUB_CMD__ABM_PAUSE command.
+ */
+struct dmub_rb_cmd_abm_pause {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__ABM_PAUSE command.
+	 */
+	struct dmub_cmd_abm_pause_data abm_pause_data;
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__QUERY_FEATURE_CAPS command.
  */
@@ -2365,6 +2414,11 @@ union dmub_rb_cmd {
 	 */
 	struct dmub_rb_cmd_abm_init_config abm_init_config;
 
+	/**
+	 * Definition of a DMUB_CMD__ABM_PAUSE command.
+	 */
+	struct dmub_rb_cmd_abm_pause abm_pause;
+
 	/**
 	 * Definition of a DMUB_CMD__DP_AUX_ACCESS command.
 	 */
-- 
2.25.1

