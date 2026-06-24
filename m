Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814FDCDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDD310F082;
	Wed, 24 Jun 2026 18:09:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G9xFmr7m";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55DE10F082
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYcJEibotq2EOHZO7JO2VcwFdiCBejc/hJmKZHee44uISQJQIX3/2jDMEAoCBcmbmeZwUo51jJFLHLCvs31O8W4h9C/7uvE8A33TVcNfkziKmQPXUnxnlpdopo/RWnOKypImhIGZ2lfABfhG44tBUWT3hCBmXBbl4Vxss2WRlVOaS2SnFmy5kbk//le4dyW8QBnISUnR38Epr8I6dadcGhY8NWRsVFHGuP5LXrsvdhetfZUBfvepkmKR42ToaYaxx+CguSdWMkr/r8ojJhVeWARHV/Q8pmGhkkLtE+nSWJBsAjkO8PyXZ7P6Gv+ghKTv7lPO7z+mX2YXzTwUQojzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCmFaj+mxzGxFBViJlSL8K9sXE+MzZLeJregcGzc3aQ=;
 b=NlrQgDaZoCuWRppVygn++39mPR8ZEno2jD9cerKxzddJBK9pfJSbgItX75NmpgqKScRZy71lRIt/TesjsiZ1wULMYY8jSVQU0+qreSKrrIbdRLZcOZZkgQoZ6xF7DMyyp5dGCGcMM+HX8AxQK5rLSxDQHJuN66BQbzX0QIrjNE8ogjpBXkzEVu4s/CTlCzeZAi3KFG7NJV7TCdd1c/7WMcbj6jaA5WkqARILcd+sDs+0uuJ26e1wch1O5/mlhbKJ/svKlbOATjL9hBBcZnCDpmvblimrmzQoqZgnWxnCBsLCqUE8z9EAKuWYD1DJkrQ4+D/wa5h0mRVMrtaFq8rCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCmFaj+mxzGxFBViJlSL8K9sXE+MzZLeJregcGzc3aQ=;
 b=G9xFmr7mvIDALwOW5ZTjO8GoOZ5TKdxJh4uZUhz3P9iAcI3IdZj1PHibbauVP5PfiO4h/r5zHl/HojuY+yQ7Ke/0fNK7eGdg8Lnq5b4JF5braUx3yniT6GMbSF0PddA1GOU40XEPfw9FeEbnuS8HYgm0fPMOSgsmef9oDtwqyiQ=
Received: from SJ0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:a03:33e::10)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Wed, 24 Jun
 2026 18:09:07 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::3) by SJ0PR03CA0035.outlook.office365.com
 (2603:10b6:a03:33e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 18:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:06 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:04 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Nevenko Stupar
 <nevenko.stupar@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 02/28] drm/amd/display: Replace repeated no-native-i2c checks
 with force_i2c_over_aux field
Date: Wed, 24 Jun 2026 14:03:00 -0400
Message-ID: <20260624180829.4775-3-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: 856f0c95-b1f6-44e6-5748-08ded21bae94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: NYmf02Z0S7pAT/7TimWKvp3ENPQCSPVqwv0ZMjODqQRUKUkbgq3aYMYMsn+HPONAkoy+dnmB2LHaZbN2OHi6frS8UGIenR2XrcPwq5ck7WcaQuEvAU2jydWVL3qOuevNbuYL0RgqD7aC6DOcnSJe+LvxqlYBZ4F5DV54O1v4H3/75LhhhFDCeZHkxouG7TR3rDXo4EcRccFb8l1nCu3oGxFYS/CaXcJQTBS/mp55QVDfV+EnD4VdtRiOSyMXdw+kVYgHhDojHXfMcmudnCKTL6Y6O24jkzKm40ps0fGlq0+XKl3X/QnVMuT8gna+23sepomcEgPAHkKm4OP4MDeEsUbYDrq1yibUoopiRPHFjJ/vH197OLut73Lp0/dg6oOE3IsNpxv9WQgc82/k8UIkYRwRXBRYAUWxGwTXccPBEoC16I1UE5/cLu1+pyaT1Nmf4dEvpBxK4gm7ncgyELQ/aT+wX1KPzvqtIV/PKkJzBibebGLSW5GNI+4IZd7IV6j2SRKgMvPzFiKCuw7fFkxiCMCWzXlgVaV/2woqakZ43gyvWD5f5Y7WgMNrJhaAms3RoIdRnAEYBNG6dWSn4lJUmQPewLIIuyBGhfwo2eT5bSBUUlEb8URCRB8v3EYWjU4EKSMvpcOs350ZINjIcL2xnUovCXFyXeeKKZmVafZ8QUYHOSH5/CTnvTiRHjjpM/VifjpzG7/he79vgw3Xs/JJkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nk+EkLnCdGAChCaGtChoXopCw1FVS8mfsZLSYKuIjWwr3iv3rQ2lEmM3TCux3jxTEqb+a54yFaCgfQ2XQG0xoAJWsJssP98/Kjz4kBK4Vu+mSwuuDfr8Cwf9f0srdj9NwHPHGuc0i9KydPaclv33yKI0Ih2jrkotR4Vp4N+Cx2qJklDemBTbBo/JDWXqpbMT7FtIHSTh1m7Huhk6bjvhq0OcE2TIzoM9PgTh2Mj2xfBKxZ/+szLDNVsY7RMbKkqqLs6j80MNCSsrjsC3v1h0+JJIxTzJEL6Y/kd2uq0JSrsxk+mmm9NIAQS+42xPgr1N+M/qhqh5wOLOf0bgtHQ+Ym/9f7VMT7dSAcQ2TUGb6w7b4CVK+y3bxQYdboHIcrvjuocUauo+YzpfHjNSEKKej2H3aKh1jaFoBl5iWPwTbIgtTUkYhqn/UjsT+adF/YxP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:06.6993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856f0c95-b1f6-44e6-5748-08ded21bae94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
The compound condition checking dp_connector_no_native_i2c
and no_ddc_pin was duplicated across many files, obscuring
intent at every call site.

[How]
Add bool force_i2c_over_aux to struct dc_link, initialized
once during link creation. Add link_get_ddc_aux_inst()
helper to select the correct aux instance. Wire into
link_service via construct_link_service_ddc(). Replace all
duplicated condition checks and aux instance selection
blocks with the new field and helper. No functional change.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 ++++
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  8 ++++----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  2 +-
 .../gpu/drm/amd/display/dc/inc/link_service.h |  1 +
 .../drm/amd/display/dc/link/link_factory.c    |  7 +++++--
 .../amd/display/dc/link/protocols/link_ddc.c  | 20 ++++++++++++++++---
 .../amd/display/dc/link/protocols/link_ddc.h  |  2 ++
 .../dc/link/protocols/link_dp_capability.c    |  2 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |  7 ++-----
 .../link/protocols/link_edp_panel_control.c   | 13 +++---------
 .../gpu/drm/amd/display/modules/power/power.c |  7 +------
 .../drm/amd/display/modules/power/power_abm.c | 14 ++-----------
 12 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0e115b1aac5f..b323f7826451 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1845,6 +1845,10 @@ struct dc_scratch_space {
 	 * of ddc_pin to know which aux instance is associated with link.
 	 */
 	bool no_ddc_pin;
+	/** When set, forces all native I2C communication on this DP connector
+	 *  to use the I2C-over-AUX protocol instead of native I2C signaling.
+	 */
+	bool force_to_use_aux;
 	enum gpio_ddc_line aux_hw_inst;
 
 	enum gpio_ddc_line ddc_hw_inst;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 72ad3ee3d6a5..fa0d63de1aa4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -529,7 +529,7 @@ static uint32_t dce_aux_configure_timeout(struct ddc_service *ddc,
 	uint32_t prev_timeout_val = 0;
 	struct ddc *ddc_pin = ddc->ddc_pin;
 
-	if (ddc->ctx->dc->config.dp_connector_no_native_i2c && ddc->link->no_ddc_pin)
+	if (ddc->link->force_to_use_aux)
 		return dce_aux_configure_timeout_without_ddc_pin(ddc, timeout_in_us);
 
 	struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
@@ -652,7 +652,7 @@ int dce_aux_transfer_raw(struct ddc_service *ddc,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
 {
-	if (ddc->ctx->dc->config.dp_connector_no_native_i2c && ddc->link->no_ddc_pin) {
+	if (ddc->link->force_to_use_aux) {
 		/* Check whether aux to be processed via dmub or dcn directly */
 		if (ddc->ctx->dc->debug.enable_dmub_aux_for_legacy_ddc) {
 			return dce_aux_transfer_dmub_raw(ddc, payload, operation_result);
@@ -795,7 +795,7 @@ int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
 		release_engine(aux_engine);
 	}
 
-	if (ddc->ctx->dc->config.dp_connector_no_native_i2c && ddc->link->no_ddc_pin) {
+	if (ddc->link->force_to_use_aux) {
 		struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst];
 
 		if (!acquire_aux_engine_without_ddc_pin(aux_engine, ddc_pin)) {
@@ -893,7 +893,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 		aux110 = FROM_AUX_ENGINE(aux_engine);
 	}
 
-	if (ddc->ctx->dc->config.dp_connector_no_native_i2c && ddc->link->no_ddc_pin) {
+	if (ddc->link->force_to_use_aux) {
 		aux_engine = ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst];
 		aux110 = FROM_AUX_ENGINE(aux_engine);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 6d3bcc02af1a..b708881222e8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -321,7 +321,7 @@ void dcn401_init_hw(struct dc *dc)
 			user_level = link->panel_cntl->stored_backlight_registers.USER_LEVEL;
 		}
 
-		if (link->ctx->dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
+		if (link->force_to_use_aux) {
 			struct graphics_object_i2c_info i2c_info;
 			struct ddc *ddc_pin;
 			struct gpio_ddc_hw_info hw_info;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_service.h b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
index 23202c2114bb..addeb3e3b25a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_service.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_service.h
@@ -193,6 +193,7 @@ struct link_service {
 			struct aux_payload *payload);
 	bool (*is_in_aux_transaction_mode)(struct ddc_service *ddc);
 	uint32_t (*get_aux_defer_delay)(struct ddc_service *ddc);
+	uint8_t (*get_ddc_aux_inst)(const struct dc_link *link);
 
 
 	/*************************** DP Capability ****************************/
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 5753b0437c6a..2e90b4e8aa43 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -143,6 +143,7 @@ static void construct_link_service_ddc(struct link_service *link_srv)
 			link_aux_transfer_with_retries_no_mutex;
 	link_srv->is_in_aux_transaction_mode = link_is_in_aux_transaction_mode;
 	link_srv->get_aux_defer_delay = link_get_aux_defer_delay;
+	link_srv->get_ddc_aux_inst = link_get_ddc_aux_inst;
 }
 
 /* link dp capability implements dp specific link capability retrieval sequence.
@@ -441,7 +442,7 @@ static enum channel_id get_ddc_line(struct dc_link *link)
 
 	channel = CHANNEL_ID_UNKNOWN;
 
-	if (link->ctx->dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
+	if (link->force_to_use_aux) {
 		channel = link->aux_hw_inst + 1;
 	} else {
 		ddc = get_ddc_pin(link->ddc);
@@ -576,6 +577,8 @@ static bool construct_phy(struct dc_link *link,
 		link->is_internal_display = (disp_connect_caps_info.INTERNAL_DISPLAY != 0);
 		DC_LOG_DC("BIOS object table - is_internal_display: %d", link->is_internal_display);
 		link->no_ddc_pin = disp_connect_caps_info.NO_DDC_PIN != 0;
+		link->force_to_use_aux = link->dc->config.dp_connector_no_native_i2c
+				&& link->no_ddc_pin;
 	}
 
 	if (link->link_id.type != OBJECT_TYPE_CONNECTOR) {
@@ -598,7 +601,7 @@ static bool construct_phy(struct dc_link *link,
 		goto ddc_create_fail;
 	}
 
-	if (link->ctx->dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
+	if (link->force_to_use_aux) {
 		link->ddc_hw_inst = link->aux_hw_inst;
 	} else {
 		/* Embedded display connectors such as LVDS may not have DDC. */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index cf8a154a7197..c7053542d581 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -120,8 +120,7 @@ static void ddc_service_construct(
 	ddc_service->link = init_data->link;
 	ddc_service->ctx = init_data->ctx;
 
-	if (ddc_service->link && ddc_service->ctx->dc->config.dp_connector_no_native_i2c &&
-		ddc_service->link->no_ddc_pin) {
+	if (ddc_service->link && ddc_service->link->force_to_use_aux) {
 		// Obtain aux instance info from i2c_info without GPIO DDC pin info
 		if (dcb->funcs->get_connector_aux_info(dcb, init_data->id, &i2c_info) == BP_RESULT_OK)
 			ddc_service->link->aux_hw_inst = (uint8_t)i2c_info.i2c_line;
@@ -252,6 +251,21 @@ static uint32_t defer_delay_converter_wa(
 
 #define DP_TRANSLATOR_DELAY 5
 
+/**
+ * link_get_ddc_aux_inst - Return the AUX/DDC hardware instance for a link.
+ * @link: the link to query
+ *
+ * Return: aux_hw_inst when I2C is forced over AUX, otherwise the DDC pin
+ * channel index.
+ */
+uint8_t link_get_ddc_aux_inst(const struct dc_link *link)
+{
+	if (link->force_to_use_aux)
+		return link->aux_hw_inst;
+	ASSERT(link->ddc->ddc_pin->hw_info.ddc_channel <= 0xFF);
+	return (uint8_t)link->ddc->ddc_pin->hw_info.ddc_channel;
+}
+
 uint32_t link_get_aux_defer_delay(struct ddc_service *ddc)
 {
 	uint32_t defer_delay = 0;
@@ -526,7 +540,7 @@ bool try_to_configure_aux_timeout(struct ddc_service *ddc,
 	if (ddc->link->ep_type != DISPLAY_ENDPOINT_PHY)
 		return true;
 
-	if (ddc->ctx->dc->config.dp_connector_no_native_i2c && ddc->link->no_ddc_pin) {
+	if (ddc->link->force_to_use_aux) {
 		if (ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs->configure_timeout) {
 			ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs->configure_timeout(ddc, timeout);
 			result = true;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
index f2a80e12494b..fdd8a3dce97f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
@@ -46,6 +46,8 @@ void set_ddc_transaction_type(
 		struct ddc_service *ddc,
 		enum ddc_transaction_type type);
 
+uint8_t link_get_ddc_aux_inst(const struct dc_link *link);
+
 uint32_t link_get_aux_defer_delay(struct ddc_service *ddc);
 
 bool link_is_in_aux_transaction_mode(struct ddc_service *ddc);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 3f185ba2846f..d2329714408a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2583,7 +2583,7 @@ bool dp_is_sink_present(struct dc_link *link)
 	/* We can't perform the step below for ASICs with no Native
 	 * I2C signaling support on DP connectors, so skip it.
 	 */
-	if (link->ctx->dc->config.dp_connector_no_native_i2c && link->no_ddc_pin)
+	if (link->force_to_use_aux)
 		return present;
 
 	ddc = get_ddc_pin(link->ddc);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index 465b9e53d311..0d4f88ff844d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -25,6 +25,7 @@
 
 #include "link_dp_panel_replay.h"
 #include "link_edp_panel_control.h"
+#include "link_ddc.h"
 #include "link_dpcd.h"
 #include "dm_helpers.h"
 #include "dc/dc_dmub_srv.h"
@@ -119,11 +120,7 @@ static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_s
 	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
-	if (dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
-		replay_context.aux_inst = (enum channel_id) link->aux_hw_inst;
-	} else {
-		replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
-	}
+	replay_context.aux_inst = (enum channel_id) link_get_ddc_aux_inst(link);
 	replay_context.digbe_inst = link->link_enc->transmitter;
 	replay_context.digfe_inst = link->link_enc->preferred_engine;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 1fda6e226e23..baf57692bbb5 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -29,6 +29,7 @@
  */
 
 #include "link_edp_panel_control.h"
+#include "link_ddc.h"
 #include "link_dpcd.h"
 #include "link_dp_capability.h"
 #include "dm_helpers.h"
@@ -788,11 +789,7 @@ bool edp_setup_psr(struct dc_link *link,
 		}
 	}
 
-	if (dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
-		psr_context->channel = (enum channel_id)link->aux_hw_inst;
-	} else {
-		psr_context->channel = link->ddc->ddc_pin->hw_info.ddc_channel;
-	}
+	psr_context->channel = link_get_ddc_aux_inst(link);
 	psr_context->transmitterId = link->link_enc->transmitter;
 	psr_context->engineId = link->link_enc->preferred_engine;
 
@@ -1025,11 +1022,7 @@ bool edp_setup_freesync_replay(struct dc_link *link, const struct dc_stream_stat
 	if (!dp_pr_get_panel_inst(dc, link, &panel_inst))
 		return false;
 
-	if (dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
-		replay_context.aux_inst = (enum channel_id) link->aux_hw_inst;
-	} else {
-		replay_context.aux_inst = link->ddc->ddc_pin->hw_info.ddc_channel;
-	}
+	replay_context.aux_inst = link_get_ddc_aux_inst(link);
 	replay_context.digbe_inst = link->link_enc->transmitter;
 	replay_context.digfe_inst = link->link_enc->preferred_engine;
 
diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gpu/drm/amd/display/modules/power/power.c
index af6b162a337d..db101fdb11f0 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power.c
@@ -483,12 +483,7 @@ bool mod_power_notify_mode_change(struct mod_power *mod_power,
 	link = dc_stream_get_link(stream);
 
 	if (link != NULL && dc_get_edp_link_panel_inst(dc, link, &panel_inst)) {
-		if (link->ctx->dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
-			aux_inst = (uint8_t)link->aux_hw_inst;
-		} else {
-			ASSERT(link->ddc->ddc_pin->hw_info.ddc_channel <= 0xFF);
-			aux_inst = (uint8_t)link->ddc->ddc_pin->hw_info.ddc_channel;
-		}
+		aux_inst = link->dc->link_srv->get_ddc_aux_inst(link);
 
 		mod_power_update_backlight_on_mode_change(core_power, link, panel_inst, aux_inst, is_hdr);
 
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
index a1a0563598b5..b9447cb7485b 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
@@ -849,12 +849,7 @@ bool mod_power_set_backlight_nits(struct mod_power *mod_power,
 	core_power = MOD_POWER_TO_CORE(mod_power);
 	link = dc_stream_get_link(stream);
 
-	if (link->ctx->dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
-		aux_inst = (uint8_t)link->aux_hw_inst;
-	} else {
-		ASSERT(link->ddc->ddc_pin->hw_info.ddc_channel <= 0xFF);
-		aux_inst = (uint8_t)link->ddc->ddc_pin->hw_info.ddc_channel;
-	}
+	aux_inst = link->dc->link_srv->get_ddc_aux_inst(link);
 
 	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &panel_inst))
 		return false;
@@ -941,12 +936,7 @@ bool mod_power_set_backlight_percent(struct mod_power *mod_power,
 
 	core_power = MOD_POWER_TO_CORE(mod_power);
 	link = dc_stream_get_link(stream);
-	if (link->ctx->dc->config.dp_connector_no_native_i2c && link->no_ddc_pin) {
-		aux_inst = (uint8_t)link->aux_hw_inst;
-	} else {
-		ASSERT(link->ddc->ddc_pin->hw_info.ddc_channel <= 0xFF);
-		aux_inst = (uint8_t)link->ddc->ddc_pin->hw_info.ddc_channel;
-	}
+	aux_inst = link->dc->link_srv->get_ddc_aux_inst(link);
 
 	if (!dc_get_edp_link_panel_inst(core_power->dc, stream->link, &panel_inst))
 		return false;
-- 
2.53.0

