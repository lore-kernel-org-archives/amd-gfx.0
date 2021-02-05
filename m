Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDCDC433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D276464EEC
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 22:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D276464EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 773406F501;
	Fri,  5 Feb 2021 22:03:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E33ED6F501
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 22:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogjNeyMpkbKbYCtzT5LED3RCxjbg6vqN4mKGReribEGAO/GlKrnlLxMyrHW6rAZZ9aGL62d3XgZP80a4noO6nnlZBm4d/fWSka9LCRhnI3tAr/gAT3KpEvXNoKSfip2cJB40vu+Us0coLGlyg0ttYhqE+jjqgiVW/4BQ2MP1zjEdZhi3Q2roVEdkU9LMgEPBli1kCwGwBk2//Xx0+YvolQlp5kYOu84MJVeGLZ5rulEMdZ7EE1OCWYkeavkbtkq9EZxCo4M1Zr6MFm/vJmocMhRwuKvTTkhtcUpuyMXP5j3Z6j3hiK50O6+3fnOE/n34HHX34VolIuH4KB+A1JFXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcIyuchzhvpjtnZas+lNWbYs8khWlC7RlEBFLkWX1k8=;
 b=G6YnHNnTMuZC0o5d6A8a6xYYESndmKn56Y2zzQS0rNwN7PWPgN1jVxf0EuNSbg1sIgy5DhSWWnrPEKjJNYhPelZtbM0kf+LRb9QV5cdm6CBOgSbRw74m23jZbGMMPVyMIZXyNTCrRyLTpdcWPVOvDvAK94Es0av7lOQZGcKfjFnYYMn79dAsSm2faItq/268QabCBPnACUja+HyXIC+0r9gLKDL478v4NflU7T5AcTju2em5iMvDDhIND36mnubTrc4kOUz5VTtwgR29uyg1wPbMCO2C9JhHUJKsYW05F5DjluA0CT432PhHORbT5qsq6aVInhIsMwjq6J+YXbocBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcIyuchzhvpjtnZas+lNWbYs8khWlC7RlEBFLkWX1k8=;
 b=U05JWUbvfrPHFSv1fhNqrj7lgiwYN2gCmtLOgEjRmHLFBGQuhsG1UULuLDSg+Zxvi4mG0MUGwFlvIDR96G7SQE+6rh5zG5vycYT63t38o1L73r3IAJ2vq9vsQYaBiXaALkg1XM6LDf3M5x5X6XpDhv5uI3WN16gQBH9+dWmmST8=
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by BN7PR12MB2610.namprd12.prod.outlook.com (2603:10b6:408:22::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Fri, 5 Feb
 2021 22:03:17 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::7f) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend
 Transport; Fri, 5 Feb 2021 22:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 5 Feb 2021 22:03:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:12 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 5 Feb 2021
 16:03:11 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 5 Feb 2021 16:03:11 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/11] drm/amd/display: Initialize dmub_rb_cmd unions to 0
Date: Fri, 5 Feb 2021 17:02:46 -0500
Message-ID: <20210205220250.1871069-8-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210205220250.1871069-1-Anson.Jacob@amd.com>
References: <20210205220250.1871069-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae176a40-5199-4053-3c28-08d8ca21d6bf
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:
X-Microsoft-Antispam-PRVS: <BN7PR12MB26102C046C0CF33D5FA32B7EEBB29@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mjhmUhvh6WJiepQLcjs5DTQR/hB1YvBWlmj/fri4UxGHi8ArPzGvV4b53CcEnYfvj4o3e5BeeZm7LhJ9oTx17IJTcd2EMG+fZOb/+h3LAimdBrL8lVrovPA5YqtZD2Yt0Jz1WlnmfCjourhYaXZzqS+RIgHJYPeZgO7iobM/JkndEDqp6PFMdT3uBd/rOalu0gCQnSGzFs55ot74sqlcIMndeqDVRt0YX+cMe/32Y0yWJPI9R33FfFGldubyuMU3xqUM+MGRKLArbtCAJofJxJAk5Ps0ph4JnE7qTxeZr6HmPhELJcR49yscpvu5zBz2QAK962lseQyY50UK3KLXFCy35qD76hJ3DqoTQeWJ8nylilpnDUc0G1m0lT6iCea2soRYCYxrP7Ayjj4sm0kTAbFOXrf75+btFKn+rHOHjV47G31VjKGrtnZuqvaT+VvsjZ65gP0/DCFCYFG6w7GRycfZfK3crpW2b8z7rf9XpxdL0hlaZa70Ik/LBzm9jLUDgEfN1k7MqU2Gpm9d6KzcrGQMw0dnxfmzjLwlDc8rqE/Hx+YS1XeRS63HPERzyLpBGVYXEFJ2YQElSKmiVA95XQMOfBlMs2txzl5w71mr/ynR1bAZpzhKCFExPmoqzx8HQR4VTCJfJ2x3OsAsx9Y5DRCIOzGUn+WHLwx1uSPRG0D/GI9G8nM+uRL6sjMd/dK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(82310400003)(8936002)(356005)(54906003)(7696005)(82740400003)(6916009)(70586007)(316002)(81166007)(70206006)(36756003)(26005)(47076005)(86362001)(426003)(186003)(478600001)(336012)(83380400001)(8676002)(4326008)(6666004)(1076003)(2906002)(2616005)(36860700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 22:03:15.6844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae176a40-5199-4053-3c28-08d8ca21d6bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
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
Cc: Josip Pavic <Josip.Pavic@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: multipart/mixed; boundary="===============0051559887=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0051559887==
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Since dmub_rb_cmds are not initialized to 0,
the header is filled with invalid data.
This is causing issues on the fw side.

[How]
Initialize dmub_rb_cmd unions to 0.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c         | 3 +++
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c | 3 ++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c         | 6 +++++-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c    | 4 +++-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 0cf130dc4e52..453aaa5757bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -57,6 +57,7 @@ static void dmub_abm_enable_fractional_pwm(struct dc_context *dc)
 	union dmub_rb_cmd cmd;
 	uint32_t fractional_pwm = (dc->dc->config.disable_fractional_pwm == false) ? 1 : 0;
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_pwm_frac.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pwm_frac.header.sub_type = DMUB_CMD__ABM_SET_PWM_FRAC;
 	cmd.abm_set_pwm_frac.abm_set_pwm_frac_data.fractional_pwm = fractional_pwm;
@@ -135,6 +136,7 @@ static bool dmub_abm_set_level(struct abm *abm, uint32_t level)
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = abm->ctx;
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_level.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_level.header.sub_type = DMUB_CMD__ABM_SET_LEVEL;
 	cmd.abm_set_level.abm_set_level_data.level = level;
@@ -160,6 +162,7 @@ static bool dmub_abm_init_config(struct abm *abm,
 	// Copy iramtable into cw7
 	memcpy(dc->dmub_srv->dmub->scratch_mem_fb.cpu_addr, (void *)src, bytes);
 
+	memset(&cmd, 0, sizeof(cmd));
 	// Fw will copy from cw7 to fw_state
 	cmd.abm_init_config.header.type = DMUB_CMD__ABM;
 	cmd.abm_init_config.header.sub_type = DMUB_CMD__ABM_INIT_CONFIG;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index d399270fd17e..c97ee5abc0ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -33,8 +33,9 @@ void dmub_hw_lock_mgr_cmd(struct dc_dmub_srv *dmub_srv,
 				union dmub_hw_lock_flags *hw_locks,
 				struct dmub_hw_lock_inst_flags *inst_flags)
 {
-	union dmub_rb_cmd cmd = { 0 };
+	union dmub_rb_cmd cmd;
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.lock_hw.header.type = DMUB_CMD__HW_LOCK;
 	cmd.lock_hw.header.sub_type = 0;
 	cmd.lock_hw.header.payload_bytes = sizeof(struct dmub_cmd_lock_hw_data);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 4228caa74119..69e34bef274c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -101,6 +101,7 @@ static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED)
 		return false;
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.psr_set_version.header.type = DMUB_CMD__PSR;
 	cmd.psr_set_version.header.sub_type = DMUB_CMD__PSR_SET_VERSION;
 	switch (stream->link->psr_settings.psr_version) {
@@ -131,7 +132,7 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait)
 	uint32_t retry_count;
 	enum dc_psr_state state = PSR_STATE0;
 
-
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.psr_enable.header.type = DMUB_CMD__PSR;
 
 	if (enable)
@@ -184,6 +185,7 @@ static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level)
 	if (state == PSR_STATE0)
 		return;
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.psr_set_level.header.type = DMUB_CMD__PSR;
 	cmd.psr_set_level.header.sub_type = DMUB_CMD__PSR_SET_LEVEL;
 	cmd.psr_set_level.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_level_data);
@@ -233,6 +235,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	link->link_enc->funcs->psr_program_secondary_packet(link->link_enc,
 			psr_context->sdpTransmitLineNumDeadline);
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.psr_copy_settings.header.type = DMUB_CMD__PSR;
 	cmd.psr_copy_settings.header.sub_type = DMUB_CMD__PSR_COPY_SETTINGS;
 	cmd.psr_copy_settings.header.payload_bytes = sizeof(struct dmub_cmd_psr_copy_settings_data);
@@ -285,6 +288,7 @@ static void dmub_psr_force_static(struct dmub_psr *dmub)
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.psr_force_static.header.type = DMUB_CMD__PSR;
 	cmd.psr_force_static.header.sub_type = DMUB_CMD__PSR_FORCE_STATIC;
 	cmd.psr_enable.header.payload_bytes = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
index 96ee0b82f458..d3b643089603 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
@@ -123,7 +123,7 @@ void dcn21_optimize_pwr_state(
  * PHY will hang on the next mode set attempt.
  * if enable PLL follow by disable PLL (without executing lane enable/disable),
  * RDPCS_PHY_DP_MPLLB_STATE remains 1,
- * which indicate that PLL disable attempt actually didn’t go through.
+ * which indicate that PLL disable attempt actually didn't go through.
  * As a workaround, insert PHY lane enable/disable before PLL disable.
  */
 void dcn21_PLAT_58856_wa(struct dc_state *context, struct pipe_ctx *pipe_ctx)
@@ -143,6 +143,7 @@ static bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t optio
 	struct dc_context *dc = abm->ctx;
 	uint32_t ramping_boundary = 0xFFFF;
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
 	cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
@@ -212,6 +213,7 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 	if (abm && panel_cntl)
 		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.abm_set_backlight.header.type = DMUB_CMD__ABM;
 	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
 	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = frame_ramp;
-- 
2.25.1


--===============0051559887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0051559887==--
