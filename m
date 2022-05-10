Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E84C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B0510EB49;
	Tue, 10 May 2022 20:46:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8426910EE6C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggus13Kcx22Hk3aX01xfUTCzVW37xhIXi8nWx4YXaq0uGM7mIkF/C/bfnEgOn1uuCZ3mmTnUR5fdzhgt5LcRo12b52mfCUCSQMPjicq6iF7NYuyMgMVXsj33sDF10EtEXDzjhZdkGuC9HfVm517h2Jo7B2O/rMxgBfVAYYwOY4YsiNaFz/EzmTloBqyPP9QBAj2GT27gMojJjYMzVmAClS0L8bHWShTV8vkVWfHrQOl4AyLaAtNddV7xeWAvRedDkXGjLFUpWTBdtJP2xcigSdzCzP7ETMVKGL4sPBZcWPApDtpU+kyOS4qjQ+G+uOtK93MG2IjMIgCANj7TSG8ZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s45grHFYrO03gJq62rUj94MNh1CNPycCUejevrVdVtg=;
 b=FGZOOlXwcP5ENUqIEbXONrufxM9obRV2qVtEKv3YkpwyzoMFVubA7DyyVALSPmBvBxZmk6malFk3DxV/8XtnshrmbOMprivpNICtmBCwo6iqTOUVL/jNoH6mhJUwTgDOZGbrCKaMmZ/ty8v0bapJz7WMyKU0N+AZCDCmEDzym/gYmelax95N0rGWS4TTPSSB8/LFTwNdU/l0ZQDpHL1MaBHhpw2vPIUCxX5tvSM2rUOr7AkkD0IiGu9dJKcs9VC5gK2KmcY8KtYib1tKrrIoy5iVL1ZWr4H6bSQ2fIpPr2nCpSwmcO0b+Q1esV+3Ex8IWwPtVbWvYKJ8UzpKx7lcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s45grHFYrO03gJq62rUj94MNh1CNPycCUejevrVdVtg=;
 b=HCQ9irN0RjTwhw75vhV/T+HIV9GwlsFuYJA6/QKrm73LPvGYA7lFSbf3ax2yrmRfZI4xFzHMSK+Ti11u3EpNGWCa7G6TAIfwtwk7D4EVqO5p+1/XNVeO2Rls7K0S2eV69/nSq53MhdMDhQB7HMqBRJoRvQQqR+TFUKE0x+kLriY=
Received: from MW4PR03CA0291.namprd03.prod.outlook.com (2603:10b6:303:b5::26)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 20:46:53 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::32) by MW4PR03CA0291.outlook.office365.com
 (2603:10b6:303:b5::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Tue, 10 May 2022 20:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 20:46:52 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:46:51 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:46:50 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 19/19] drm/amd/display: PSR-SU rate control support in DC
Date: Tue, 10 May 2022 16:45:08 -0400
Message-ID: <20220510204508.506089-20-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec8314f0-25bc-43b3-1386-08da32c636c9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4321:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4321ACB12E9DA388CDCF43498DC99@BY5PR12MB4321.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Us88Z/k9w6dIwVTJh2gtcMFXGuZO3D0CkLavwlr7mv7b1J3gz8JPD8RgZhgIv8GOdTxMx8NP95oaSFAUtbA9Ery9XyPS4RfvUGPu6HOFBKEzSahGSek0K+4IejoWj1uYadbF2WsPFNZyzZDjA+plz9wAJxxWsSjW8z265bW8pOc8DoVzf4oTXM8Tk1i7eaP0lhrHK4DVJ+RicCdqpUMRnW6qP6I+M8H4WMJjxQTPFB4O0EHftseS9uP264aIJegAct8kxBDxlumU9eYdZJi/4X+RmTsSytl/vpO8+rnSFhRckhgF5Jc2yLxbKWXc9RnidfEMEikX56yZB9dj4IhUoHgebGbIfe+4g2ewt98v2lIKfwvk0bNl4Pw7dzhOkH5PCGruuaellsAyPb3dkZtIGL6Gg5ExLBykXGzWjroRylP5Y+sUZCXzhlMjegfj2mHqEhN0XG/omjZhBphTeBQz2UCJ5N8ZFdopSvfV6VxcgmbZSm/jvNiEDlkierP6G6/RXZ4w3N7xlhkIBmpQXp55tzYfPeHyjPppVgoSpCcFrk0OtyGpv9bSadC1ul8Mt4yN7haNeWzMTnZ0W27jJCZQblHGt882s3lxoenK5sIyEvyTwVamWQG9ubnrVoQ7Sd4pTIm+dF9Gp6KBpjx7A+SXJrjNWyvlL5JYM6Aox8kiI4i+Waodtmh6D2N0utYNohmd+xHdLa3kRqp1EsG3TPQCSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(356005)(82310400005)(36756003)(26005)(5660300002)(83380400001)(8936002)(1076003)(70586007)(316002)(47076005)(6666004)(508600001)(70206006)(426003)(86362001)(8676002)(4326008)(54906003)(6916009)(336012)(81166007)(7696005)(186003)(36860700001)(2906002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:52.8532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8314f0-25bc-43b3-1386-08da32c636c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why & how]
We need to add the necessary DC codes to support PSR-SU rate
control (RC).

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 14 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 ++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 23 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  2 ++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  8 +++++++
 6 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 259745074ebb..08dedc16a9c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1765,6 +1765,7 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 	 */
 	program_hpd_filter(link);
 
+	link->psr_settings.psr_vtotal_control_support = false;
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
 	DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
@@ -3377,6 +3378,19 @@ void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency)
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
index 5e7f70840e1a..4e15e68375da 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -100,6 +100,7 @@ struct psr_settings {
 	bool psr_feature_enabled;		// PSR is supported by sink
 	bool psr_allow_active;			// PSR is currently active
 	enum dc_psr_version psr_version;		// Internal PSR version, determined based on DPCD
+	bool psr_vtotal_control_support;	// Vtotal control is supported by sink
 
 	/* These parameters are calculated in Driver,
 	 * based on display timing and Sink capabilities.
@@ -326,6 +327,8 @@ void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency);
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
index 66132f3cac42..c89643eaa0f4 100644
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
2.25.1

