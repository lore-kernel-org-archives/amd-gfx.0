Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC01C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FFC61437
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FFC61437
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBA76EB27;
	Fri, 23 Apr 2021 02:40:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F19466EB27
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxcS+1jMuJmLjm1G3VMoo3YNX+90Y/nfTDPLc1Ex1PX4us5nI6FAOThRE0VynGPT857hi0iYSJnZ5s4hOJMW9M73sHeaogOFBSQ9oNrTo+p0QVqEoXEH33JBH1P5FF3sDfvdJcMeC9sF8zY1vlSMnbRoDB9QugsZEdF2A97D8PZJNA54SAQI9qIx+SyFBLQwlqJAvDuc0FoX5Nynz9EI303YHaaYcgJfEfXMEqjq6Z01shZj7f/yLHDzjehkv6cI2oHWIQcm6Eb58DcBAyTcDfCkHSbWBQ5lr8L7Z+975IMtas/8T5aDJq5fhaTyh1ctR4lr8pb/IaYNONaGOZmzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp8YRRSt3HhldzcMWUb0qKv7Ma1e9HQY2/4b2cFNV+o=;
 b=MxCMzixdt4RVSlMdJeNVRgsGKsf3/6FqtracbQwXL1S5bjYwYuNKSS+fB19wAfHQi8Rm1AHGL1+PL9TsKNcvFdxuU8PYI3p69T5iQW7axhL79mL25zNIXQ7GO5AVi824y4rDOmWHVxJYYOu6NcB5qsTlcfQHvHTfg+7CR/TOBc8PIxYB8JkrNRNEKCXMjsGc0fhp1dQ5wfLg0fNnMsHoE9cruf3Y8vuoSaQLrKt0NlbuUXFHE5BQToT775Y+OX/QS1dYF/D/99YRrhVuo0bv5vg8hM3loXitVTdzyiLPtzr6P23pJeFMzivexqKCeywSvnyTWFh2vNIuDAbw+4+CQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp8YRRSt3HhldzcMWUb0qKv7Ma1e9HQY2/4b2cFNV+o=;
 b=2j8h4NssD5WVGYf8lAlZyv3H36XQV8S5jxlfNyqWL6DEr8W6Fpzau4vAY3snk2IUEL19uEq5ePaV1f+mANN5cdMRMDW/WnjWzlafLnqass7oaoJZFB/sxnwy2zjySiDT7/JZe7LXuX0z5D5pL7EPNmyILudkn/0bIlbgKwrQhlk=
Received: from MWHPR20CA0038.namprd20.prod.outlook.com (2603:10b6:300:ed::24)
 by BN7PR12MB2627.namprd12.prod.outlook.com (2603:10b6:408:25::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 23 Apr
 2021 02:40:16 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::41) by MWHPR20CA0038.outlook.office365.com
 (2603:10b6:300:ed::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Fri, 23 Apr 2021 02:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 02:40:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 21:40:14 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 22 Apr 2021 21:40:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Added multi instance support for ABM
Date: Fri, 23 Apr 2021 10:37:05 +0800
Message-ID: <20210423023714.22044-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423023714.22044-1-Wayne.Lin@amd.com>
References: <20210423023714.22044-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b184ca2-e3ed-42dc-0fe3-08d9060120a3
X-MS-TrafficTypeDiagnostic: BN7PR12MB2627:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2627F18809ED457916DD6F76FC459@BN7PR12MB2627.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1OmGGfKXFX9Kk1spx85Mk+tzhaGRb+Qi0n++7h4JULrlZWsSW01mzf2sd6fE+hoKjsx1op5uT+CVzBi+qU0Evg9MCZDVS34OlQFE1G1t2w5KBRfHXyy/69fTUhJi9e84YTgysCMHTi+y2b2mU8KHU5wD79oA694s1WEDiKP4Irtv17TuFxTLg0nOv/9pwQT1hpb+oE90XhMdqNaVxokCePXRFvzoMJlwKaPSirjr+0lCwhEATC3GUiKg0zHp7li/r6hloQU3l6nGhL27ygv5Fn/LHBMfzob8UnhmXg0TGgqTCSj59QcfpyLLnTmQIaKet0JJhUavbezprtdRB/x+uayEPWY4TcXR6KAiB97nLCHwAR939Jfh2iG5chYJAV1Y25bMzWSUImxnt8+5LzZ5DexHgUo41g8NM3TLBuUTsPaMRTkdY7AqdB1YbzTvy/PRB5NEzFymCK+2l5IgS0sCdYUyOVXZXEveVkANQpx9f2QlCYYmZDQjx3cj3deQS7Oe4QqnWIn0NK1FnvovWKPjx4trB0MGgAZd2kX4Rfbzb8SRVx0SnHSzQxcwKidcAR3HWiH163+pN9RdpjewjvVNJXvs6NvqpIGfN7vamAW+oSsflL7iJx4e0kImOAGFmsDuQCfOw+kZ/26zwgTyb4TWxsXbj0RZvOiD3czLVMXhf2OQhMsBBCdzIw+MTJTGAvS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(70206006)(26005)(47076005)(6916009)(2616005)(36756003)(6666004)(8676002)(1076003)(336012)(82310400003)(8936002)(186003)(70586007)(36860700001)(4326008)(356005)(81166007)(5660300002)(82740400003)(7696005)(2906002)(54906003)(316002)(426003)(83380400001)(478600001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:40:16.0388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b184ca2-e3ed-42dc-0fe3-08d9060120a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2627
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
Cc: Eryk.Brol@amd.com, Jake Wang <haonan.wang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jake Wang <haonan.wang2@amd.com>

[WHY & HOW]
ABM assumes only 1 eDP is connected. Refactored existing
ABM interface to support multiple instances.

Signed-off-by: Jake Wang <haonan.wang2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 30 +++++++
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 79 +++++++++++++++++--
 3 files changed, 105 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index eb1698d54a48..6939ca2e8212 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -56,11 +56,19 @@ static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
 {
 	union dmub_rb_cmd cmd;
 	uint32_t fractional_pwm = (dc->dc->config.disable_fractional_pwm == false) ? 1 : 0;
+	uint32_t edp_id_count = dc->dc_edp_id_count;
+	int i;
+	uint8_t panel_mask = 0;
+
+	for (i = 0; i < edp_id_count; i++)
+		panel_mask |= 0x01 << i;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_pwm_frac.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pwm_frac.header.sub_type = DMUB_CMD__ABM_SET_PWM_FRAC;
 	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.fractional_pwm = fractional_pwm;
+	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
+	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.panel_mask = panel_mask;
 	cmd.abm_set_pwm_frac.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pwm_frac_data);
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
@@ -135,11 +143,24 @@ static bool dmub_abm_set_level(struct abm *abm, uint32_t level)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
+	struct dc_link *edp_links[MAX_NUM_EDP];
+	int i;
+	int edp_num;
+	uint8_t panel_mask = 0;
+
+	get_edp_links(dc->dc, edp_links, &edp_num);
+
+	for (i = 0; i < edp_num; i++) {
+		if (edp_links[i]->link_status.link_active)
+			panel_mask |= (0x01 << i);
+	}
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_level.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_level.header.sub_type = DMUB_CMD__ABM_SET_LEVEL;
 	cmd.abm_set_level.abm_set_level_data.level = level;
+	cmd.abm_set_level.abm_set_level_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
+	cmd.abm_set_level.abm_set_level_data.panel_mask = panel_mask;
 	cmd.abm_set_level.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_level_data);
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
@@ -155,6 +176,12 @@ static bool dmub_abm_init_config(struct abm *abm,
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
+	uint32_t edp_id_count = dc->dc_edp_id_count;
+	int i;
+	uint8_t panel_mask = 0;
+
+	for (i = 0; i < edp_id_count; i++)
+		panel_mask |= 0x01 << i;
 
 	// TODO: Optimize by only reading back final 4 bytes
 	dmub_flush_buffer_mem(&dc->dmub_srv->dmub->scratch_mem_fb);
@@ -168,6 +195,9 @@ static bool dmub_abm_init_config(struct abm *abm,
 	cmd.abm_init_config.header.sub_type = DMUB_CMD__ABM_INIT_CONFIG;
 	cmd.abm_init_config.abm_init_config_data.src.quad_part = dc->dmub_srv->dmub->scratch_mem_fb.gpu_addr;
 	cmd.abm_init_config.abm_init_config_data.bytes = bytes;
+	cmd.abm_init_config.abm_init_config_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
+	cmd.abm_init_config.abm_init_config_data.panel_mask = panel_mask;
+
 	cmd.abm_init_config.header.payload_bytes = sizeof(struct dmub_cmd_abm_init_config_data);
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 8fccee5a3036..69cc192a7e71 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -218,7 +218,7 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
 	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = frame_ramp;
 	cmd.abm_set_backlight.abm_set_backlight_data.backlight_user_level = backlight_pwm_u16_16;
-	cmd.abm_set_backlight.abm_set_backlight_data.version = DMUB_CMD_ABM_SET_BACKLIGHT_VERSION_1;
+	cmd.abm_set_backlight.abm_set_backlight_data.version = DMUB_CMD_ABM_CONTROL_VERSION_1;
 	cmd.abm_set_backlight.abm_set_backlight_data.panel_mask = (0x01 << panel_cntl->inst);
 	cmd.abm_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_backlight_data);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 4195ff10c514..82c6e8a8a7c9 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -121,14 +121,14 @@
 #define TRACE_BUFFER_ENTRY_OFFSET  16
 
 /**
- * ABM backlight control version legacy
+ * ABM control version legacy
  */
-#define DMUB_CMD_ABM_SET_BACKLIGHT_VERSION_UNKNOWN 0x0
+#define DMUB_CMD_ABM_CONTROL_VERSION_UNKNOWN 0x0
 
 /**
- * ABM backlight control version with multi edp support
+ * ABM control version with multi edp support
  */
-#define DMUB_CMD_ABM_SET_BACKLIGHT_VERSION_1 0x1
+#define DMUB_CMD_ABM_CONTROL_VERSION_1 0x1
 
 /**
  * Physical framebuffer address location, 64-bit.
@@ -1637,7 +1637,7 @@ struct dmub_cmd_abm_set_backlight_data {
 	uint32_t backlight_user_level;
 
 	/**
-	 * Backlight data version.
+	 * ABM control version.
 	 */
 	uint8_t version;
 
@@ -1677,6 +1677,23 @@ struct dmub_cmd_abm_set_level_data {
 	 * Set current ABM operating/aggression level.
 	 */
 	uint32_t level;
+
+	/**
+	 * ABM control version.
+	 */
+	uint8_t version;
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
@@ -1702,6 +1719,23 @@ struct dmub_cmd_abm_set_ambient_level_data {
 	 * Ambient light sensor reading from OS.
 	 */
 	uint32_t ambient_lux;
+
+	/**
+	 * ABM control version.
+	 */
+	uint8_t version;
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
@@ -1728,6 +1762,23 @@ struct dmub_cmd_abm_set_pwm_frac_data {
 	 * TODO: Convert to uint8_t.
 	 */
 	uint32_t fractional_pwm;
+
+	/**
+	 * ABM control version.
+	 */
+	uint8_t version;
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
@@ -1758,6 +1809,24 @@ struct dmub_cmd_abm_init_config_data {
 	 * Indirect buffer length.
 	 */
 	uint16_t bytes;
+
+
+	/**
+	 * ABM control version.
+	 */
+	uint8_t version;
+
+	/**
+	 * Panel Control HW instance mask.
+	 * Bit 0 is Panel Control HW instance 0.
+	 * Bit 1 is Panel Control HW instance 1.
+	 */
+	uint8_t panel_mask;
+
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
