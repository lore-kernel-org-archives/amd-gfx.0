Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93579C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 06:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51FD10EBD4;
	Mon, 29 Apr 2024 06:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TlMHrHj3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5297310F835
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 06:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ/1hiabyIUv0vsiE5RGuh+vy6uHG0Efx0lvJQdPFNztwAVWwKI7n3l39k0lqfgYb6Pv2cgivVISnNZBHBNKAOfuH23OMoF4KWCC2x4KxlN43pT8MfVFAOnnuK7erHb42NIkPTIKZxx+l9hYj2sAuHyYJEL7GKddE4XJbsZDgyAHivwaXeKMHibz9K9WWP7B8UTNaHH8EDxedhifj/JHP/fO/UIKo1WjwndRkPEcmvafXtanxEwsdRbPo0y9T85y9l26Q4lbsZe0idfHjvk2I6ARXImvs/qkqRyOhe05tixTsJV/mGAxL/9NzqiUD8H4n7tT8wLH5W+luvgfJfISCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13FyDJ8ChomlXoZQ50rnLax2hApYdIJ8WzivZz6nabg=;
 b=hXA2k4HZACEe27OwMZiuGUMDQN0HGKL64mxKeHS3XhAdEd5WN6edog7rfTgyTzQWq3iX2g730SAOotBrbKx6SJsC9OdnpXK/OW61E/M50+fBWNQD4yBleQgak1FQaIRgXZg4dzf/Z0cVM9bMDXeofan24iPTOuHj1S22B0TDc64CjIIhKS/O9qM13FZ+2dAEvYWmFndmDyXbgiW+cH3g+qROhabGjjWkrdM9VDeEWaElbaUZ7slGhjFoNdvnn5bg5hNBY8iaDXk/pnq/F6//+KUPdRBRAS5Hs0N+sRUj/JjbFnXXmBcA4Zgb1kvAIs1a8A3zRXuNtDeTD0D7GR2V6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13FyDJ8ChomlXoZQ50rnLax2hApYdIJ8WzivZz6nabg=;
 b=TlMHrHj3pJq4gq9nVlpvkpTfSNNL4Khj9z8vPzxQSeI9opX4Cp8YYGkb81P6CgZi0WTxNhPLblisvaEi1zsxpdvCHjo/MXDwS9X1xF3Oj2YvnVyEan6H7k6j7I8/NfdxLiNsr2o5qdZFr7KLVwVzt6OpxVGaMusNGwpMNNy8vd8=
Received: from CH2PR04CA0005.namprd04.prod.outlook.com (2603:10b6:610:52::15)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Mon, 29 Apr
 2024 06:55:15 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::a1) by CH2PR04CA0005.outlook.office365.com
 (2603:10b6:610:52::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 06:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 29 Apr 2024 06:55:14 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 01:55:09 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, "Qingqing
 Zhuo" <qingqing.zhuo@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Roman Li <roman.li@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Refactor construct_phy function in
 dc/link/link_factory.c
Date: Mon, 29 Apr 2024 12:24:51 +0530
Message-ID: <20240429065451.180745-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: a4613057-414c-4bd9-6ee7-08dc6819526a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0J0bzc5aGI5MHk0N2N4eXRpa3BDYmR3MFhtTXZCUjdXS0ZjUExzRDBsL1NT?=
 =?utf-8?B?N1BLWHR3NENtMi9jdGFROEk5SGdYZ2J4NUhKT2sxdnRwS2VaOVR3RWpzWG1o?=
 =?utf-8?B?eDJiV0hhNWZ0d2c4VlRvN0R4NVM3UnpOd0gvVkxXNzFycmthMnlLSWg0dWFL?=
 =?utf-8?B?bWtDaGduUEg4WDFqRlZQclJoZExGNFZvTlhPV0JWaE1QSUdELytEMzZEckxh?=
 =?utf-8?B?NG0yOE53bVRoblYvaGMrTWpMbkpqWkFxWWNBV0F0Wm4wNXA3Q2h6NXBidGZU?=
 =?utf-8?B?SHFqOFFMWWRpQkNRUENKZFpIakdPWEQ3Q3Jva3pMbTVuN2swdnZNTTNMSzQw?=
 =?utf-8?B?MG1EUFV5ZU5BZDdFR2F3RWlJQUpPOElwRERRS0p1YVkyVUl3UUVGb0pwU0Jz?=
 =?utf-8?B?RHJvb0lLd0JoS2VVdDZVb2pyeFRnVzJZSGhwOVJ4Znh6b0VmVXh3Sms0ZFpD?=
 =?utf-8?B?bjRnWWErd1ZGcHFJUnhPYmorZ2xuZGJ6QStweEFEdlhCbVdybUpDZzhwTEpX?=
 =?utf-8?B?Y3NteEY0RG42MHlzZ2pYaVpLUTdoQ1lSRXdhQ21tVW5jVEhGZXVBSExLdDZv?=
 =?utf-8?B?VmZKVTc4ajljc1RnYmpjMzR6N09RUENDblZmMHR0aGJFSS9DeXNxTzQ3cGV0?=
 =?utf-8?B?VERPd09wUkl4UFBjNXR1ZzYza2FxNW5TcG9CbXpCWVJ5M2hnM3VOSU9jWkI5?=
 =?utf-8?B?dytTVzNyOThtanV1dDEyUUlDeVlIWmJjSkgrMUkxZFpQYlh0RDlUUWM1bTlu?=
 =?utf-8?B?K1lBWDh2bEpZelNiYyt6ZGpYczNBQ0NTMlFZOWlCWkRiNlJKR21oU1E5UTIv?=
 =?utf-8?B?ZTFzdThhMi9OQWg2dnN1UitwRGtkYlc0a2pKOE9wbm9zZi9Xd2FpU1BSZGNG?=
 =?utf-8?B?aDREeElZRERsNlNoQzA2QVdyWk9TOEVneTczTHR5WWRxdXo1SlRPY2Qwd08x?=
 =?utf-8?B?Z0F4ejRmL2FxWFlpMFhodGMzNEthNENrbmoxRGdBWGFGTFhVRlcrS0x5c2hy?=
 =?utf-8?B?dEJGVEFTWWNqTitVVW9WSVhFditaVHFIcjU5UXo4V3gvQ0dONDJEcjNKYUxE?=
 =?utf-8?B?VThvczFCZmRrdDJJdHZ6RDNUdkVyQ1RnRHhnZmI3aTg3VmY4aFBGQUUvSE1L?=
 =?utf-8?B?T1VCOTNuNlQ1R3o0NnhuRk1hTnN0eEFqS0tmUmdBU0FCTzZHa0E0Sy9HVnM1?=
 =?utf-8?B?dnpZKytyYXhmbG1qSUlYQzdVLzVUQ0taT1hnczJVV2V1c1EyS3Rtcm03ZSt6?=
 =?utf-8?B?WlhlTExiTEJuY2drWUlvUmtkZGhETzZuVkNvdnQ3YnBQa2IxNjlBR1cyTXcw?=
 =?utf-8?B?QmRuS1pYV1hXTE93WTIxM1BaSk1Vd2Z3eDBjbEtyRVdvQnlmaVVscVI0alBR?=
 =?utf-8?B?R1JQYUNXYUNFWmtDSi8zUW95SHNwOHJGbWZKNW1qV1JDLzNnN1A3NnpEVU5y?=
 =?utf-8?B?NDNCbVRrOXVOMEw1TDFGdGxqSW1kblcrUDNaQVJ1TFBZTDhYSFNRdFFHWGIr?=
 =?utf-8?B?TEphbS9xMkkrUUh1OC8zcExTNUIxeHcrUk44SGkvTEtxaytxMlNiNGMwRXNw?=
 =?utf-8?B?SCtrUGxmOE1yMEZVakI4bnQyUC9jYWtrY3hTN1J4TURQQmlqMkpZTHFvcU9V?=
 =?utf-8?B?b21rKzY3dmd0b2dtcFh0eGZUYVVZTEJkd2RrMVQ2b3J4b1h2M1VMY2UwM1Bu?=
 =?utf-8?B?Zm83VVkyRVNTdHdORjQway9mVkFCWTdrY3BZT3NSNWxSNldPOTNlaVBzTjhq?=
 =?utf-8?B?LzZGVkx1UUFrajJmYlBoL3hIbm40YXpHWko0QlUvclpHVmZvdEJIaS92RWxy?=
 =?utf-8?B?endCN0prckkrZ1lGbHRIRUt3Nm1nYVlWcStVN1N5elN0a1BCbDcrSU1CakZ3?=
 =?utf-8?Q?ZQOgh9V+enBL3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:55:14.5320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4613057-414c-4bd9-6ee7-08dc6819526a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379
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

This commit refactors the construct_phy function. The original function
was large and complex.

The following functions were created:

- initialize_link: Handles the initial setup of the link object.
- handle_connector_type: Sets the connector_signal and irq_source_hpd_rx
  based on the link_id.id.
- initialize_ddc_service: Initializes the ddc_service for the link.
- initialize_link_encoder: Initializes the link_encoder for the link.

Additionally, the error handling code that was originally in
construct_phy has been moved to the new functions. Each function now
returns a boolean value indicating whether the operation was successful.
If an error occurs, the construct_phy function jumps to the appropriate
label for error handling.

This refactoring reduces the size of the stack frame for each individual
function, fixes about the frame size being larger than 1024 bytes.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c: In function ‘construct_phy’:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:743:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/link/link_factory.c    | 221 ++++++++++--------
 1 file changed, 122 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index cf22b8f28ba6..af373824db8c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -448,73 +448,74 @@ static enum channel_id get_ddc_line(struct dc_link *link)
 	return channel;
 }
 
-static bool construct_phy(struct dc_link *link,
-			      const struct link_init_data *init_params)
+static bool initialize_link_encoder(struct dc_link *link,
+				    struct dc_context *dc_ctx,
+				    const struct dc_vbios_funcs *bp_funcs)
 {
-	uint8_t i;
-	struct ddc_service_init_data ddc_service_init_data = { 0 };
-	struct dc_context *dc_ctx = init_params->ctx;
 	struct encoder_init_data enc_init_data = { 0 };
-	struct panel_cntl_init_data panel_cntl_init_data = { 0 };
-	struct integrated_info info = { 0 };
-	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
-	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
-	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
 
-	DC_LOGGER_INIT(dc_ctx->logger);
+	enc_init_data.ctx = dc_ctx;
+	bp_funcs->get_src_obj(dc_ctx->dc_bios, link->link_id, 0, &enc_init_data.encoder);
+	enc_init_data.connector = link->link_id;
+	enc_init_data.channel = get_ddc_line(link);
+	enc_init_data.hpd_source = get_hpd_line(link);
 
-	link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
-	link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
-	link->link_status.dpcd_caps = &link->dpcd_caps;
+	link->hpd_src = enc_init_data.hpd_source;
 
-	link->dc = init_params->dc;
-	link->ctx = dc_ctx;
-	link->link_index = init_params->link_index;
+	enc_init_data.transmitter = translate_encoder_to_transmitter(enc_init_data.encoder);
+	link->link_enc = link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
 
-	memset(&link->preferred_training_settings, 0,
-	       sizeof(struct dc_link_training_overrides));
-	memset(&link->preferred_link_setting, 0,
-	       sizeof(struct dc_link_settings));
-
-	link->link_id =
-		bios->funcs->get_connector_id(bios, init_params->connector_index);
+	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d",
+		  link->link_enc->features.flags.bits.DP_IS_USB_C);
+	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d",
+		  link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
 
-	link->ep_type = DISPLAY_ENDPOINT_PHY;
+	if (!link->link_enc) {
+		DC_ERROR("Failed to create link encoder!\n");
+		return false;
+	}
 
-	DC_LOG_DC("BIOS object table - link_id: %d", link->link_id.id);
+	/* Update link encoder tracking variables. These are used for the dynamic
+	 * assignment of link encoders to streams.
+	 */
+	link->eng_id = link->link_enc->preferred_engine;
+	link->dc->res_pool->link_encoders[link->eng_id - ENGINE_ID_DIGA] = link->link_enc;
+	link->dc->res_pool->dig_link_enc_count++;
 
-	if (bios->funcs->get_disp_connector_caps_info) {
-		bios->funcs->get_disp_connector_caps_info(bios, link->link_id, &disp_connect_caps_info);
-		link->is_internal_display = disp_connect_caps_info.INTERNAL_DISPLAY;
-		DC_LOG_DC("BIOS object table - is_internal_display: %d", link->is_internal_display);
-	}
+	link->link_enc_hw_inst = link->link_enc->transmitter;
 
-	if (link->link_id.type != OBJECT_TYPE_CONNECTOR) {
-		dm_output_to_console("%s: Invalid Connector ObjectID from Adapter Service for connector index:%d! type %d expected %d\n",
-				     __func__, init_params->connector_index,
-				     link->link_id.type, OBJECT_TYPE_CONNECTOR);
-		goto create_fail;
-	}
+	return true;
+}
 
-	if (link->dc->res_pool->funcs->link_init)
-		link->dc->res_pool->funcs->link_init(link);
+static bool initialize_ddc_service(struct dc_link *link, struct dc_context *dc_ctx)
+{
+	struct ddc_service_init_data ddc_service_init_data = { 0 };
 
-	link->hpd_gpio = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
-				      link->ctx->gpio_service);
+	ddc_service_init_data.ctx = link->ctx;
+	ddc_service_init_data.id = link->link_id;
+	ddc_service_init_data.link = link;
+	link->ddc = link_create_ddc_service(&ddc_service_init_data);
 
-	if (link->hpd_gpio) {
-		dal_gpio_open(link->hpd_gpio, GPIO_MODE_INTERRUPT);
-		dal_gpio_unlock_pin(link->hpd_gpio);
-		link->irq_source_hpd = dal_irq_get_source(link->hpd_gpio);
+	if (!link->ddc) {
+		DC_ERROR("Failed to create ddc_service!\n");
+		return false;
+	}
 
-		DC_LOG_DC("BIOS object table - hpd_gpio id: %d", link->hpd_gpio->id);
-		DC_LOG_DC("BIOS object table - hpd_gpio en: %d", link->hpd_gpio->en);
+	if (!link->ddc->ddc_pin) {
+		DC_ERROR("Failed to get I2C info for connector!\n");
+		return false;
 	}
 
+	link->ddc_hw_inst = dal_ddc_get_line(get_ddc_pin(link->ddc));
+
+	return true;
+}
+
+static void handle_connector_type(struct dc_link *link, struct dc_context *dc_ctx)
+{
 	switch (link->link_id.id) {
 	case CONNECTOR_ID_HDMI_TYPE_A:
 		link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
-
 		break;
 	case CONNECTOR_ID_SINGLE_LINK_DVID:
 	case CONNECTOR_ID_SINGLE_LINK_DVII:
@@ -527,23 +528,18 @@ static bool construct_phy(struct dc_link *link,
 	case CONNECTOR_ID_DISPLAY_PORT:
 	case CONNECTOR_ID_USBC:
 		link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
-
 		if (link->hpd_gpio)
-			link->irq_source_hpd_rx =
-					dal_irq_get_rx_source(link->hpd_gpio);
-
+			link->irq_source_hpd_rx = dal_irq_get_rx_source(link->hpd_gpio);
 		break;
 	case CONNECTOR_ID_EDP:
 		link->connector_signal = SIGNAL_TYPE_EDP;
-
 		if (link->hpd_gpio) {
 			if (!link->dc->config.allow_edp_hotplug_detection)
 				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
-
 			switch (link->dc->config.allow_edp_hotplug_detection) {
 			case HPD_EN_FOR_ALL_EDP:
 				link->irq_source_hpd_rx =
-						dal_irq_get_rx_source(link->hpd_gpio);
+					dal_irq_get_rx_source(link->hpd_gpio);
 				break;
 			case HPD_EN_FOR_PRIMARY_EDP_ONLY:
 				if (link->link_index == 0)
@@ -564,69 +560,97 @@ static bool construct_phy(struct dc_link *link,
 				break;
 			}
 		}
-
 		break;
 	case CONNECTOR_ID_LVDS:
 		link->connector_signal = SIGNAL_TYPE_LVDS;
 		break;
 	default:
-		DC_LOG_WARNING("Unsupported Connector type:%d!\n",
-			       link->link_id.id);
-		goto create_fail;
+		DC_LOG_WARNING("Unsupported Connector type:%d!\n", link->link_id.id);
+		break;
 	}
+}
 
-	LINK_INFO("Connector[%d] description: signal: %s\n",
-		  init_params->connector_index,
-		  signal_type_to_string(link->connector_signal));
+static void initialize_link(struct dc_link *link, const struct link_init_data *init_params)
+{
+	struct dc_context *dc_ctx = init_params->ctx;
+	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
 
-	ddc_service_init_data.ctx = link->ctx;
-	ddc_service_init_data.id = link->link_id;
-	ddc_service_init_data.link = link;
-	link->ddc = link_create_ddc_service(&ddc_service_init_data);
+	DC_LOGGER_INIT(dc_ctx->logger);
 
-	if (!link->ddc) {
-		DC_ERROR("Failed to create ddc_service!\n");
-		goto ddc_create_fail;
+	link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
+	link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
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
+	link->link_id =
+		bios->funcs->get_connector_id(bios, init_params->connector_index);
+
+	link->ep_type = DISPLAY_ENDPOINT_PHY;
+
+	DC_LOG_DC("BIOS object table - link_id: %d", link->link_id.id);
+}
+
+static bool construct_phy(struct dc_link *link,
+			  const struct link_init_data *init_params)
+{
+	u8 i;
+	struct dc_context *dc_ctx = init_params->ctx;
+	struct panel_cntl_init_data panel_cntl_init_data = { 0 };
+	struct integrated_info info = { 0 };
+	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
+	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
+	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
+
+	initialize_link(link, init_params);
+
+	if (bios->funcs->get_disp_connector_caps_info) {
+		bios->funcs->get_disp_connector_caps_info(bios,
+							  link->link_id, &disp_connect_caps_info);
+		link->is_internal_display = disp_connect_caps_info.INTERNAL_DISPLAY;
+		DC_LOG_DC("BIOS object table - is_internal_display: %d", link->is_internal_display);
 	}
 
-	if (!link->ddc->ddc_pin) {
-		DC_ERROR("Failed to get I2C info for connector!\n");
-		goto ddc_create_fail;
+	if (link->link_id.type != OBJECT_TYPE_CONNECTOR) {
+		dm_output_to_console("%s: Invalid Connector ObjectID from Adapter Service for connector index:%d! type %d expected %d\n",
+				     __func__, init_params->connector_index,
+				     link->link_id.type, OBJECT_TYPE_CONNECTOR);
+		goto create_fail;
 	}
 
-	link->ddc_hw_inst =
-		dal_ddc_get_line(get_ddc_pin(link->ddc));
+	if (link->dc->res_pool->funcs->link_init)
+		link->dc->res_pool->funcs->link_init(link);
 
-	enc_init_data.ctx = dc_ctx;
-	bp_funcs->get_src_obj(dc_ctx->dc_bios, link->link_id, 0,
-			      &enc_init_data.encoder);
-	enc_init_data.connector = link->link_id;
-	enc_init_data.channel = get_ddc_line(link);
-	enc_init_data.hpd_source = get_hpd_line(link);
+	link->hpd_gpio = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
+					   link->ctx->gpio_service);
 
-	link->hpd_src = enc_init_data.hpd_source;
+	if (link->hpd_gpio) {
+		dal_gpio_open(link->hpd_gpio, GPIO_MODE_INTERRUPT);
+		dal_gpio_unlock_pin(link->hpd_gpio);
+		link->irq_source_hpd = dal_irq_get_source(link->hpd_gpio);
 
-	enc_init_data.transmitter =
-		translate_encoder_to_transmitter(enc_init_data.encoder);
-	link->link_enc =
-		link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
+		DC_LOG_DC("BIOS object table - hpd_gpio id: %d", link->hpd_gpio->id);
+		DC_LOG_DC("BIOS object table - hpd_gpio en: %d", link->hpd_gpio->en);
+	}
 
-	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
-	DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
+	handle_connector_type(link, dc_ctx);
 
-	if (!link->link_enc) {
-		DC_ERROR("Failed to create link encoder!\n");
-		goto link_enc_create_fail;
-	}
+	LINK_INFO("Connector[%d] description: signal: %s\n",
+		  init_params->connector_index,
+		  signal_type_to_string(link->connector_signal));
 
-	/* Update link encoder tracking variables. These are used for the dynamic
-	 * assignment of link encoders to streams.
-	 */
-	link->eng_id = link->link_enc->preferred_engine;
-	link->dc->res_pool->link_encoders[link->eng_id - ENGINE_ID_DIGA] = link->link_enc;
-	link->dc->res_pool->dig_link_enc_count++;
+	if (!initialize_ddc_service(link, dc_ctx))
+		goto create_fail;
 
-	link->link_enc_hw_inst = link->link_enc->transmitter;
+	if (!initialize_link_encoder(link, dc_ctx, bp_funcs))
+		goto link_enc_create_fail;
 
 	if (link->dc->res_pool->funcs->panel_cntl_create &&
 		(link->link_id.id == CONNECTOR_ID_EDP ||
@@ -730,7 +754,6 @@ static bool construct_phy(struct dc_link *link,
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 panel_cntl_create_fail:
 	link_destroy_ddc_service(&link->ddc);
-ddc_create_fail:
 create_fail:
 
 	if (link->hpd_gpio) {
-- 
2.34.1

