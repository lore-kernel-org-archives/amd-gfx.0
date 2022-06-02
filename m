Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AE7C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 19:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D673112D8B;
	Thu,  2 Jun 2022 19:31:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78954112D9C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 19:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMlbm/WADni2VvZHTmOhrvTb8sGqWAU81xmrMcgjYXuS2S9MWUz0kA/+mYtTIW6KkI/716jcclzl55oOZE8c5EOksH/DtQywAbFLjRjix5arLdFeU1s+VaubUEM4mp8pv98vOMJl2NWWVCfMtD3iekouTJTGO7pCEmWrN7IkXDQXn41oNy47UqHN5m8wpSwtEpTtWn047Vpu9GM9tpJ7zARTp9mBFIiyYi7ozEKpLwvELQ9C9TCWTzY1IbokDi4qEbEmQr92sOAwtDnUrTZYtFG5hgYTeXHfQlFlW/INYHdKN38g3qRSH7FmgtB13f2XiCq4jaoOcHF9biut7G1a/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqKIEbkUZICS7idhjJx2zgNNmty98CPVm2LFb1K0E4c=;
 b=QVIZxljoaXg7MeLU44FMG0aaPBAmm2h8JDzKDEjzc+zyOH23oheZ7qFUgnpNixd+Eh8nSpfj1uSsEzvdKlQSW74k6k7FVehpa8x51ZoaoNcA1kgAunmwgTufrMLIE6sclbNOpdQw/xN3T1cLlnPjQlPVs1SuPv6OwLlLK+4D6ocjCq5d6vCQYVL34SbTPvRfw+3G1D3zsNqSTF2f+so9Mi8YAX8L8DwTx+sFd54YzZq82mu1G6r4fwlVQXPC37UZqIzxqmGoIgcg6ZcfV5JBtH0xsml8qFZ/4/f3IBM79Kd8OJ+Q9VOzgb9wN20yvVblJZcEbnsYHUgAw1HhCgsH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqKIEbkUZICS7idhjJx2zgNNmty98CPVm2LFb1K0E4c=;
 b=ErIO89FIVljhC8qZ8L073GSW+bvQutzYdqJErThn37LYC3kI0xNMSUr5wPpJRJ3XLt1mY9Bu/TAJg00K+DCnDxo2gJBZMOe5slLcqXRWlf2Pjy1f1RtSWRuX4+xN4e4jew5wHggAyQ+4G9LZ9gx5glfD5dn9QlhKi6EzjQ6Ao/Y=
Received: from DS7PR03CA0214.namprd03.prod.outlook.com (2603:10b6:5:3ba::9) by
 BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:63::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Thu, 2 Jun 2022 19:31:33 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::3f) by DS7PR03CA0214.outlook.office365.com
 (2603:10b6:5:3ba::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 2 Jun 2022 19:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 19:31:33 +0000
Received: from leodev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 14:31:32 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amd/display: Add PSR-SU-RC support in DC
Date: Thu, 2 Jun 2022 14:03:45 -0400
Message-ID: <20220602180347.754067-3-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220602180347.754067-1-sunpeng.li@amd.com>
References: <20220602180347.754067-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9705cc44-2a92-4284-ed74-08da44ce8049
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB26803E705516AC43B00C237A82DE9@BYAPR12MB2680.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUiISZdPHg30yeVFzFt3A3JOcByNtBS7nPNDjbkM8dZoyuU/Nl7jBXQdvfVL3uSA25qbgNyxYFMO+JrBwERMJH3GB96nGxo4QMGkN861CXFWHlZoobBmSuSHX0ZhisCxlDqGfudZhDQ6VOXKJm+ITqUO9akSJAmEzD0O2HQHhw63SEkY+oj+ybksrhEUMsYjL0tLYobvrgRoqCCuaHpmGYzP7wuOWT75JQh80+W0ZTyt/fdHiqHSWQfT65Cqfew9o+3XLaSLRuSGLunwPYflx2TvqkOSqy0SftmA/zZxv9UFfSA0MPAnI/oHCWnWbrOiiwhmrTgflX8iwi0JuFak2+GYaEpMdqPF19pG76yFQDdO6zk33Tyy64/wSlANTfeqJ2zwDQiuokcruHDuRYZFgHoumAERLu8aE+4ssn3jgc01rQiRSdrTbXE/nwjiQJk95uVyg45dhHmOrcZAosWazj7loThvIDEbspGAOXgqPinZUHya3bTN0KHgLFpuBfV/vxd2sN15knCssXScnuKzi2i1268GCTdNyjohO31MHzgvumO7VQoIhcOq+P+4e76RhmoXnVRoLHgxvr4G6t3Fn5DuEzeRM6pvIO0hN+mSaj7Dw3YY9pphHGkqNF61Qx3fcWUtBz1+wWLh5wpUZJaB4LAI0APoKli6uUm3z6NvMpJAFJvbWXLoVpXA4s7dhhbQ+D4T1LqIX+6MjPKnIJkHQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70206006)(40460700003)(7696005)(6666004)(2906002)(356005)(54906003)(70586007)(4326008)(2876002)(316002)(508600001)(81166007)(8936002)(5660300002)(86362001)(83380400001)(82310400005)(8676002)(47076005)(336012)(1076003)(186003)(426003)(26005)(2616005)(16526019)(6916009)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 19:31:33.1533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9705cc44-2a92-4284-ed74-08da44ce8049
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
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
Cc: alexander.deucher@amd.com, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com, dingchen.zhang@amd.com, roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Zhang <dingchen.zhang@amd.com>

[Why]

PSR-SU Rate Control - or PSR-SU-RC - enables PSR-SU panels to work with
variable refresh rate to allow for more power savings. Lowering the
refresh rate can increase PSR residency by expanding the eDP main link
shut down duration. It can also lower panel power consumption.

There is a complication with With PSR, since the eDP main link can be
shut down. Therefore, the timing controller (TCON) on the eDP sink nees
to be able to scan out its remote buffer independant of the main link.
To allow the eDP source to specify the sink's refresh rate while the
link is off, vendor-specific DPCD registers are used. This allows the
eDP source to then "Rate Control" the panel during PSR active.

[How]

Add DC support to communicate with PSR-SU-RC supported eDP sinks. The
sink will need to know the desired VTotal during PSR active.

This change only adds support to DC, support in amdgpu_dm is still pending to
enable this fully.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 22 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 23 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  2 ++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  8 +++++++
 6 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 31ffb961e18b..3d6dcaa6a483 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1795,6 +1795,7 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 	 */
 	program_hpd_filter(link);
 
+	link->psr_settings.psr_vtotal_control_support = false;
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
 	DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
@@ -3207,6 +3208,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 	/* updateSinkPsrDpcdConfig*/
 	union dpcd_psr_configuration psr_configuration;
 	union dpcd_alpm_configuration alpm_configuration;
+	union dpcd_sink_active_vtotal_control_mode vtotal_control = {0};
 
 	psr_context->controllerId = CONTROLLER_ID_UNDEFINED;
 
@@ -3276,6 +3278,13 @@ bool dc_link_setup_psr(struct dc_link *link,
 			psr_config->su_y_granularity;
 		psr_context->line_time_in_us =
 			psr_config->line_time_in_us;
+
+		if (link->psr_settings.psr_vtotal_control_support) {
+			psr_context->rate_control_caps = psr_config->rate_control_caps;
+			vtotal_control.bits.ENABLE = true;
+			core_link_write_dpcd(link, DP_SINK_PSR_ACTIVE_VTOTAL_CONTROL_MODE,
+							&vtotal_control.raw, sizeof(vtotal_control.raw));
+		}
 	}
 
 	psr_context->channel = link->ddc->ddc_pin->hw_info.ddc_channel;
@@ -3408,6 +3417,19 @@ void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency)
 		*residency = 0;
 }
 
+bool dc_link_set_sink_vtotal_in_psr_active(const struct dc_link *link, uint16_t psr_vtotal_idle, uint16_t psr_vtotal_su)
+{
+	struct dc *dc = link->ctx->dc;
+	struct dmub_psr *psr = dc->res_pool->psr;
+
+	if (psr == NULL || !link->psr_settings.psr_feature_enabled || !link->psr_settings.psr_vtotal_control_support)
+		return false;
+
+	psr->funcs->psr_set_sink_vtotal_in_psr_active(psr, psr_vtotal_idle, psr_vtotal_su);
+
+	return true;
+}
+
 const struct dc_link_status *dc_link_get_status(const struct dc_link *link)
 {
 	return &link->link_status;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 0bec986a6de8..3ec189dd73da 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -100,6 +100,7 @@ struct psr_settings {
 	bool psr_feature_enabled;		// PSR is supported by sink
 	bool psr_allow_active;			// PSR is currently active
 	enum dc_psr_version psr_version;		// Internal PSR version, determined based on DPCD
+	bool psr_vtotal_control_support;	// Vtotal control is supported by sink
 
 	/* These parameters are calculated in Driver,
 	 * based on display timing and Sink capabilities.
@@ -324,6 +325,8 @@ void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency);
 void dc_link_blank_all_dp_displays(struct dc *dc);
 
 void dc_link_blank_dp_stream(struct dc_link *link, bool hw_init);
+bool dc_link_set_sink_vtotal_in_psr_active(const struct dc_link *link,
+		uint16_t psr_vtotal_idle, uint16_t psr_vtotal_su);
 
 /* Request DC to detect if there is a Panel connected.
  * boot - If this call is during initial boot.
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 26b62f50ac4e..fa735d5f730f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -684,6 +684,7 @@ struct psr_config {
 	/* psr2 selective update y granularity capability */
 	uint8_t su_y_granularity;
 	unsigned int line_time_in_us;
+	uint8_t rate_control_caps;
 };
 
 union dmcu_psr_level {
@@ -794,6 +795,7 @@ struct psr_context {
 	/* psr2 selective update y granularity capability */
 	uint8_t su_y_granularity;
 	unsigned int line_time_in_us;
+	uint8_t rate_control_caps;
 };
 
 struct colorspace_transform {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 9ca0cbb0af9b..0df06740ec39 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -250,6 +250,27 @@ static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level, uint8_
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
 }
 
+/**
+ * Set PSR vtotal requirement for FreeSync PSR.
+ */
+static void dmub_psr_set_sink_vtotal_in_psr_active(struct dmub_psr *dmub,
+		uint16_t psr_vtotal_idle, uint16_t psr_vtotal_su)
+{
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = dmub->ctx;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.psr_set_vtotal.header.type = DMUB_CMD__PSR;
+	cmd.psr_set_vtotal.header.sub_type = DMUB_CMD__SET_SINK_VTOTAL_IN_PSR_ACTIVE;
+	cmd.psr_set_vtotal.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_vtotal_data);
+	cmd.psr_set_vtotal.psr_set_vtotal_data.psr_vtotal_idle = psr_vtotal_idle;
+	cmd.psr_set_vtotal.psr_set_vtotal_data.psr_vtotal_su = psr_vtotal_su;
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+}
+
 /*
  * Set PSR power optimization flags.
  */
@@ -358,6 +379,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 
 	copy_settings_data->line_capture_indication = 0;
 	copy_settings_data->line_time_in_us = psr_context->line_time_in_us;
+	copy_settings_data->rate_control_caps = psr_context->rate_control_caps;
 	copy_settings_data->fec_enable_status = (link->fec_state == dc_link_fec_enabled);
 	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
 	copy_settings_data->cmd_version =  DMUB_CMD_PSR_CONTROL_VERSION_1;
@@ -435,6 +457,7 @@ static const struct dmub_psr_funcs psr_funcs = {
 	.psr_set_level			= dmub_psr_set_level,
 	.psr_force_static		= dmub_psr_force_static,
 	.psr_get_residency		= dmub_psr_get_residency,
+	.psr_set_sink_vtotal_in_psr_active	= dmub_psr_set_sink_vtotal_in_psr_active,
 	.psr_set_power_opt		= dmub_psr_set_power_opt,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index 01acc01cc191..74005b9d352a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -46,6 +46,8 @@ struct dmub_psr_funcs {
 	void (*psr_force_static)(struct dmub_psr *dmub, uint8_t panel_inst);
 	void (*psr_get_residency)(struct dmub_psr *dmub, uint32_t *residency,
 	uint8_t panel_inst);
+	void (*psr_set_sink_vtotal_in_psr_active)(struct dmub_psr *dmub,
+	uint16_t psr_vtotal_idle, uint16_t psr_vtotal_su);
 	void (*psr_set_power_opt)(struct dmub_psr *dmub, unsigned int power_opt, uint8_t panel_inst);
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index 6e6bd007babc..ec572a9e4054 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -101,6 +101,14 @@ union dpcd_alpm_configuration {
 	unsigned char raw;
 };
 
+union dpcd_sink_active_vtotal_control_mode {
+	struct {
+		unsigned char ENABLE                    : 1;
+		unsigned char RESERVED                  : 7;
+	} bits;
+	unsigned char raw;
+};
+
 union psr_error_status {
 	struct {
 		unsigned char LINK_CRC_ERROR        :1;
-- 
2.36.1

