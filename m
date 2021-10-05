Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920A7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DD6610FC
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 59DD6610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7EBF6EB33;
	Tue,  5 Oct 2021 07:52:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2AB36EB33
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnaPpr8PtW5WG6vkRVbxmipe62h5ww8kYhL8YgFMkhBlYoFFHPrMwBxQuq7xJappeSkxLDv8bF+FY+fPhqbScHFa0p1CqnQcEleRlzurOAKllRmATGH9Z8BOvRud+jZsKDOsUZzGUcimCfMgqLvQqR3lBdi32URA/U4NQ16lb3o89+dW21fFpXwgr67nL2XeX7+E1J2Bn7l8wQdDHkys9whj7e49DUl2PO7HTBMtjD2VfwK2SII1D+Ui1AvDhWpHXRENEwWdiQm5WqgxuB8B47wEM+udmH/O4Xw5iCtbUqzZgT3WC//HRQjTXrUtFxm8Us7hHfwjGBR24h/TowOEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usRmkwegPO1MKEWwEfi0eY7mCFK4O0xe6RIG1GgC6as=;
 b=Q3uiRDjiBxaDJt4nRLg80lb84VDyC9bdpqTv8M/vE5DtOHD8K9rGXX0mW1FW0RPe5qoNhKkdf+6/fz4Iy3wBf16oAMmY1ZH9JSOl72iBXlJWdbrUDOMSgiF/BAHRyNmAprfbVHlSLDUXdnF4ZnudBMpDmOHkKJpovOKVtREpxOeuPehd4XK2PM0WHZT/Ynljs8Zcovv0FAnsFy2is81w2AsXVWVysU751193Q/lOTKi42BvWdQl/0/lqPSGevxnLK98V8fp+cPhEfF3xbv/PP9FNe1Y6o/2Uq/6DHNc3aibFXnnWs/5uBSU+SmR8zdrLtUyNWcrZz0TAKsr+XeCjHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usRmkwegPO1MKEWwEfi0eY7mCFK4O0xe6RIG1GgC6as=;
 b=O8nLqikSZ2S5uRttizQTbubIg5CXyVlxb6hELEHidhnCfg+gxUbncj5huGD6K0Le+N64VctH22LTnisR2qA9pTvm+U2a43CSocR/1t1ZGOaTbg6x9W3VJdL2AN2GcMKu25gbB28ssflVuiZu3v6j+QlHP81ZJjNgAA8vF9FNlnM=
Received: from MWHPR15CA0032.namprd15.prod.outlook.com (2603:10b6:300:ad::18)
 by CY4PR12MB1749.namprd12.prod.outlook.com (2603:10b6:903:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 5 Oct
 2021 07:52:50 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::b9) by MWHPR15CA0032.outlook.office365.com
 (2603:10b6:300:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 5 Oct 2021 07:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:52:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:52:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:52:48 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:52:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH v2 02/23] drm/amd/display: USB4 DPIA enumeration and AUX
 Tunneling
Date: Tue, 5 Oct 2021 15:51:44 +0800
Message-ID: <20211005075205.3467938-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cc43f8a-ee3a-4985-206e-08d987d520ea
X-MS-TrafficTypeDiagnostic: CY4PR12MB1749:
X-Microsoft-Antispam-PRVS: <CY4PR12MB174976CBF4BF6205F0B668B5FCAF9@CY4PR12MB1749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZ+IuOXe4Vutt/yXdu6pnMhm8x7sbeYXBtKrqubrK1kXN3NcWBDJxv0MDffkoLFW/Z720O2dHdedJBcFs/tkL3eyo6SQGuAbMT/enwmdfXnzR9ugGJKbX5O5A9ac9gkLUjon+GTkLVRST5dOgr8+u2hwH0bhSUpGuoMkzrk2Bar/ie5GH8cpGNCo+gqTNStdC1CjeSTfCU3t7zyTJgBfgCUQUm4mD4h7abOY52y0DAM3qLfn2FuVZnWOOzYG725g5KX7VkgtlkVtMw3PmhgonJAIcaY+FVbB7kmujyjQXme1ytpnk+GWyDHzppWRyAnR6OjW/eKB8kF5poAF/IhL8HeSBxsVlQzMn4UfGU5A1rp9CyYhHMBAA/4D9ih7St4h99N5qiOjp3ggYnsLXglwmEjhTmDrydCdG/wtw+kUl0wHmj2O9epfOHDq1uehniRHBTvg4uVQ1r5fc+U7X8m+hUvHJatEMyAa6e135WWwAxftbIb7A7rS51xwP5siP01erM7K2qgdF71MlWeAOEOafJOx02jzo0wHVy9+xsHl3kUiZpaV+Cjp+xOAipwG8sU7hdFYSRQ3CfUX/hZvG94a/OBqVdgF73jwKyrZRGcUHS3uYo/0jA+avZO57tRTZAFSDkrRrU/JjbXFnfEPNjWaWYaPs7fl3vpCxcSMB/o4yzbRFmc2Ka08QKcEJaXp8unYQRpT26XPnTZtwwHRjQgQtCaOLFk4Gey9ve6Y62pPyuM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(2616005)(316002)(36860700001)(83380400001)(36756003)(426003)(30864003)(82310400003)(7696005)(6666004)(8936002)(336012)(2906002)(47076005)(54906003)(508600001)(81166007)(356005)(26005)(186003)(86362001)(70206006)(6916009)(70586007)(5660300002)(1076003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:52:49.8185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc43f8a-ee3a-4985-206e-08d987d520ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1749
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[WHY]
To enable dc links for USB4 DPIA ports and AUX command tunneling
for YELLOW_CARP_B0.

[HOW]
1) Created dc links for all USB4 DPIA ports in create_links().
   dc_link_construct() implementation is split for legacy DDC and DPIAs.
   As usb4 has no ddc, ddc->ddc_pin will be set to NULL for its dc link
   and this parameter will be used to identify the dc links as DPIA. The
   dc link for DPIA is further to be enhanced with implementation for link
   encoder and link initialization.
2) usb4_dpia_count in struct resource_pool will be initialized to 4 in
   dcn31_resource_construct() if the DCN is YELLOW_CARP_B0.
3) Enabled DMUB AUX via outbox for YELLOW_CARP_B0.

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 32 ++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 71 ++++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  3 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  6 ++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  6 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |  1 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |  5 +-
 8 files changed, 120 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 673fb0ef7a89..f4bb8ea4e83a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -231,6 +231,25 @@ static bool create_links(
 
 	DC_LOG_DC("BIOS object table - end");
 
+	/* Create a link for each usb4 dpia port */
+	for (i = 0; i < dc->res_pool->usb4_dpia_count; i++) {
+		struct link_init_data link_init_params = {0};
+		struct dc_link *link;
+
+		link_init_params.ctx = dc->ctx;
+		link_init_params.connector_index = i;
+		link_init_params.link_index = dc->link_count;
+		link_init_params.dc = dc;
+		link_init_params.is_dpia_link = true;
+
+		link = link_create(&link_init_params);
+		if (link) {
+			dc->links[dc->link_count] = link;
+			link->dc = dc;
+			++dc->link_count;
+		}
+	}
+
 	for (i = 0; i < num_virtual_links; i++) {
 		struct dc_link *link = kzalloc(sizeof(*link), GFP_KERNEL);
 		struct encoder_init_data enc_init = {0};
@@ -3559,6 +3578,12 @@ void dc_hardware_release(struct dc *dc)
  */
 bool dc_enable_dmub_notifications(struct dc *dc)
 {
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	/* YELLOW_CARP B0 USB4 DPIA needs dmub notifications for interrupts */
+	if (dc->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
+	    dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0)
+		return true;
+#endif
 	/* dmub aux needs dmub notifications to be enabled */
 	return dc->debug.enable_dmub_aux_for_legacy_ddc;
 }
@@ -3584,7 +3609,12 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 
 	cmd.dp_aux_access.header.type = DMUB_CMD__DP_AUX_ACCESS;
 	cmd.dp_aux_access.header.payload_bytes = 0;
-	cmd.dp_aux_access.aux_control.type = AUX_CHANNEL_LEGACY_DDC;
+	/* For dpia, ddc_pin is set to NULL */
+	if (!dc->links[link_index]->ddc->ddc_pin)
+		cmd.dp_aux_access.aux_control.type = AUX_CHANNEL_DPIA;
+	else
+		cmd.dp_aux_access.aux_control.type = AUX_CHANNEL_LEGACY_DDC;
+
 	cmd.dp_aux_access.aux_control.instance = dc->links[link_index]->ddc_hw_inst;
 	cmd.dp_aux_access.aux_control.sw_crc_enabled = 0;
 	cmd.dp_aux_access.aux_control.timeout = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 64b9c493dce2..20b4819b73e4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1425,8 +1425,8 @@ static enum transmitter translate_encoder_to_transmitter(struct graphics_object_
 	}
 }
 
-static bool dc_link_construct(struct dc_link *link,
-			      const struct link_init_data *init_params)
+static bool dc_link_construct_legacy(struct dc_link *link,
+				     const struct link_init_data *init_params)
 {
 	uint8_t i;
 	struct ddc_service_init_data ddc_service_init_data = { { 0 } };
@@ -1701,6 +1701,73 @@ static bool dc_link_construct(struct dc_link *link,
 	return false;
 }
 
+static bool dc_link_construct_dpia(struct dc_link *link,
+				   const struct link_init_data *init_params)
+{
+	struct ddc_service_init_data ddc_service_init_data = { { 0 } };
+	struct dc_context *dc_ctx = init_params->ctx;
+
+	DC_LOGGER_INIT(dc_ctx->logger);
+
+	/* Initialized dummy hpd and hpd rx */
+	link->irq_source_hpd = DC_IRQ_SOURCE_USB4_DMUB_HPD;
+	link->irq_source_hpd_rx = DC_IRQ_SOURCE_USB4_DMUB_HPDRX;
+	link->link_status.dpcd_caps = &link->dpcd_caps;
+
+	link->dc = init_params->dc;
+	link->ctx = dc_ctx;
+	link->link_index = init_params->link_index;
+
+	memset(&link->preferred_training_settings, 0,
+	       sizeof(struct dc_link_training_overrides));
+	memset(&link->preferred_link_setting, 0,
+	       sizeof(struct dc_link_settings));
+
+	/* Dummy Init for linkid */
+	link->link_id.type = OBJECT_TYPE_CONNECTOR;
+	link->link_id.id = CONNECTOR_ID_DISPLAY_PORT;
+	link->is_internal_display = false;
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	LINK_INFO("Connector[%d] description:signal %d\n",
+		  init_params->connector_index,
+		  link->connector_signal);
+
+	/* TODO: Initialize link : funcs->link_init */
+
+	ddc_service_init_data.ctx = link->ctx;
+	ddc_service_init_data.id = link->link_id;
+	ddc_service_init_data.link = link;
+	/* Set indicator for dpia link so that ddc won't be created */
+	ddc_service_init_data.is_dpia_link = true;
+
+	link->ddc = dal_ddc_service_create(&ddc_service_init_data);
+	if (!link->ddc) {
+		DC_ERROR("Failed to create ddc_service!\n");
+		goto ddc_create_fail;
+	}
+
+	/* Set dpia port index : 0 to number of dpia ports */
+	link->ddc_hw_inst = init_params->connector_index;
+
+	/* TODO: Create link encoder */
+
+	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
+
+	return true;
+
+ddc_create_fail:
+	return false;
+}
+
+static bool dc_link_construct(struct dc_link *link,
+			      const struct link_init_data *init_params)
+{
+	/* Handle dpia case */
+	if (init_params->is_dpia_link)
+		return dc_link_construct_dpia(link, init_params);
+	else
+		return dc_link_construct_legacy(link, init_params);
+}
 /*******************************************************************************
  * Public functions
  ******************************************************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index ba6b56f20269..dd6c473be072 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -196,7 +196,8 @@ static void ddc_service_construct(
 	ddc_service->link = init_data->link;
 	ddc_service->ctx = init_data->ctx;
 
-	if (BP_RESULT_OK != dcb->funcs->get_i2c_info(dcb, init_data->id, &i2c_info)) {
+	if (init_data->is_dpia_link ||
+	    dcb->funcs->get_i2c_info(dcb, init_data->id, &i2c_info) != BP_RESULT_OK) {
 		ddc_service->ddc_pin = NULL;
 	} else {
 		DC_LOGGER_INIT(ddc_service->ctx->logger);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 80f06ceccea8..18e33ef3d217 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -174,6 +174,10 @@ void dcn31_init_hw(struct dc *dc)
 		if (hws->funcs.dsc_pg_control != NULL)
 			hws->funcs.dsc_pg_control(hws, res_pool->dscs[i]->inst, false);
 
+	/* Enables outbox notifications for usb4 dpia */
+	if (dc->res_pool->usb4_dpia_count)
+		dmub_enable_outbox_notification(dc);
+
 	/* we want to turn off all dp displays before doing detection */
 	if (dc->config.power_down_display_on_boot)
 		blank_all_dp_displays(dc, true);
@@ -278,8 +282,10 @@ void dcn31_init_hw(struct dc *dc)
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
 		dc->res_pool->hubbub->funcs->force_pstate_change_control(
 				dc->res_pool->hubbub, false, false);
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (dc->res_pool->hubbub->funcs->init_crb)
 		dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
+#endif
 }
 
 void dcn31_dsc_pg_control(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index d5b58025f0cc..2e021f9345c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2427,6 +2427,12 @@ static bool dcn31_resource_construct(
 		pool->base.sw_i2cs[i] = NULL;
 	}
 
+	if (dc->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
+	    dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
+		/* YELLOW CARP B0 has 4 DPIA's */
+		pool->base.usb4_dpia_count = 4;
+	}
+
 	/* Audio, Stream Encoders including HPO and virtual, MPC 3D LUTs */
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
 			(!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment) ?
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index ed09af238911..6fc6488c54c0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -62,6 +62,7 @@ struct link_init_data {
 	uint32_t connector_index; /* this will be mapped to the HPD pins */
 	uint32_t link_index; /* this is mapped to DAL display_index
 				TODO: remove it when DC is complete. */
+	bool is_dpia_link;
 };
 
 struct dc_link *link_create(const struct link_init_data *init_params);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
index 4d7b271b6409..95fb61d62778 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
@@ -69,6 +69,7 @@ struct ddc_service_init_data {
 	struct graphics_object_id id;
 	struct dc_context *ctx;
 	struct dc_link *link;
+	bool is_dpia_link;
 };
 
 struct ddc_service *dal_ddc_service_create(
diff --git a/drivers/gpu/drm/amd/display/dc/irq_types.h b/drivers/gpu/drm/amd/display/dc/irq_types.h
index 530c2578db40..7a9f667d5edb 100644
--- a/drivers/gpu/drm/amd/display/dc/irq_types.h
+++ b/drivers/gpu/drm/amd/display/dc/irq_types.h
@@ -153,7 +153,10 @@ enum dc_irq_source {
 	DC_IRQ_SOURCE_DMCUB_OUTBOX,
 	DC_IRQ_SOURCE_DMCUB_OUTBOX0,
 	DC_IRQ_SOURCE_DMCUB_GENERAL_DATAOUT,
-	DAL_IRQ_SOURCES_NUMBER
+	DAL_IRQ_SOURCES_NUMBER,
+	/* Dummy interrupt source for USB4 HPD & HPD RX */
+	DC_IRQ_SOURCE_USB4_DMUB_HPD,
+	DC_IRQ_SOURCE_USB4_DMUB_HPDRX,
 };
 
 enum irq_type
-- 
2.25.1

