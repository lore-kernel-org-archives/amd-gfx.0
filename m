Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601E5C04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 08:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02EA112B30;
	Mon, 29 Apr 2024 08:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v1nzNY5w";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C9F112B2E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 08:31:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In6HmWyJon464UwLKnf9Qj2MhM12jCCsJwqKGJhrohQivJL4NCZuB8LmiOQDFdVE0ikX6gtsjjJhPWnKfavclxbC6xUz5DQ1sN8sRBJeGvTR/FIE4RvJz5KV4YPwZkZNzEZruqWvR46+gN3CeWAf1m9qDdkBfv4ocaOxa960CeelQZdC43oS8Yej7RRrslsHr3RHG5GdlbTxz02ZLbUpFKe4KSQ6vL2CvPPLA8CN3KkyXdbnh6nzUZUIa1rjija8iOh+8ngjxO67InAlZyr/LcyffHRCsJgpEF7IuzTf9yzq6tzcz/uL7ljTGfmP/ZZCwDprE93hbDiWr7kLXhsZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWFv/UxqeoS2dt1YFw5tuE1em/h4d7HWFS1nwFxAGzs=;
 b=m8rRxQMxPCVhgZcUdaPA12yogc1pQVpEEbeJEuooqGlJk4zqL8SETu+aR7JlRNRIpw7t1Gu7qPLILtsJEACYt9QH9+VNE8VElN1zPCKWC1N4mFTzatW9wFNNZQ8BaKVmKD8yKx6Ua0iPtEbDXn7Xn+zUjqE53wYowNCXUAZXbNOv+FXOgIA4dI2NeICOPwqC0A+GcPc8Ce8AWZRTTCFu1AyWFHTpqoa5yJpktLm3Z3U1LVJdzs+LZfJ0BfhvzBbOFG+BUcWr5rAdsV78ruV1sEbm9uNHLjesLUO85nfasccWbHEnKTC6IBfveMKWjDWiy68gNGDj3vINoAjsVtjWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWFv/UxqeoS2dt1YFw5tuE1em/h4d7HWFS1nwFxAGzs=;
 b=v1nzNY5w2isRWsvVexpKZ40B5gW81aAg5zyD/seRs6qcdaQ94R/pJRKjj/hcvRk2GhtSgqYStJ9sCS01dO9Ry3TOkmpFnfMvwAbXPfImp2VaENqyXw8TrCPuW9Xsdj/yxd2wlq31LpDJj+zHyOkzlGcSEhxiaYEBfcTsnNMK/k0=
Received: from PH8PR20CA0016.namprd20.prod.outlook.com (2603:10b6:510:23c::20)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 08:31:10 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::d) by PH8PR20CA0016.outlook.office365.com
 (2603:10b6:510:23c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Mon, 29 Apr 2024 08:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 08:31:09 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 03:31:04 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, "Qingqing
 Zhuo" <qingqing.zhuo@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Roman Li <roman.li@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH v2] drm/amd/display: Refactor construct_phy function in
 dc/link/link_factory.c
Date: Mon, 29 Apr 2024 14:00:38 +0530
Message-ID: <20240429083038.232958-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065451.180745-1-srinivasan.shanmugam@amd.com>
References: <20240429065451.180745-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 49daa34b-dc45-4ddb-62e7-08dc6826b8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YS9iSGkzbWY5YjE5RkRTSzZOUjFDQUhUMjlqM0gycFBDMWhRSEpuWmVTWVli?=
 =?utf-8?B?RGZpcDU4QVhUVDVTekJqVGdDek1aWXY3Y2tPeXY4RGRxbmM1MmFhdFBPajJv?=
 =?utf-8?B?encrWFhPVDlZd2hySHo0UjhrengrVm9TMnZldmZManErSW5XUm5ONGFpcEsv?=
 =?utf-8?B?L2FObWRCRHBNbUE4ajJhNE5pWnJoVEhuVFUyS3lqWk5YSzhvbC95aDEwZkd0?=
 =?utf-8?B?bWFWZWZuWTZqU3RmS2R2TGpOaW9nN0FhRTdycVIvM1hQcUEwTXZyMTNiZjBm?=
 =?utf-8?B?TUtNaXFpTGhrVXJQWE4vM2Zyb21hM3NTUllYbTNtZEg3TjVpdjlDZDRMbmxP?=
 =?utf-8?B?KzJGV0cxY3VhanhGWnQ3a2NhY2JlVmZ0T2ZxYkVndU1WaWtqSmtaY29GcFRp?=
 =?utf-8?B?MXdiajk3cHVOUnlVSExLNjVlMm8rYjlSUmoyb1BIUEVRS0l0R2d0NW0vVXZS?=
 =?utf-8?B?Nmw0Ykt2bElSd2cveVVGdWM0SFdBOXFVTlJyNU9tSmdkVzFtQ1kwcGovWFNG?=
 =?utf-8?B?RXdQS2lxVVowUlYrL09tcnE1VWZOQjZReGlEZDJRS3NjUmN5cUk3eFNUTUFK?=
 =?utf-8?B?M2lYcEFhZ252QVB3SkpSTGhlZitTUmNZUTlROUsvTzVRcTZSSEhTdkJZL09o?=
 =?utf-8?B?T2NuZWt5QnQyczZmYlBscCtCQ09LbjFZVUVzMkxkU1RyYm9MN3QrY0lzejAx?=
 =?utf-8?B?WGYrb2lZdXNkeW0zRnJuYUFSM3pLeGpNVHk2aCt3UGZndkh0aURQOWNFR3pW?=
 =?utf-8?B?V2lhR1U4bGtLbFdvd1ZUMW1oYnZPYi9WdEk2QVMydmxDU21aSjd2QXhTa0N5?=
 =?utf-8?B?dXYzbDVpYlhLMTJKMHdFbFkrTWNnUm02RGN6TUdLN0RURE1CS3p5Q1JWRHgw?=
 =?utf-8?B?enlSbWIyMEZqSG5ON0ptTlpEZi8xaVgvbXdvcS9KU3g2SGxJUjVRbjA2NDVT?=
 =?utf-8?B?TDZIMytmMFM2dW9HNUU5cFovSS90T0RXU09OS2FtSHNvaEJsdmZMSENCNUwz?=
 =?utf-8?B?OGpUZ0FXTVhHaUZqcHlHeUQvOFcxWXpZc3hMaXI2UXVVc25vN3JzSGNJcGFO?=
 =?utf-8?B?MGI2TGtVekZmZWxXQVRFNWwzbUM5WTJXaVNPanJTZC9pQTVVQ3loWldrdWZu?=
 =?utf-8?B?K1BCczEyekl3KzhGUlJPYUNtS29FcmhRM3BWVktOem5VZHcrTkdoUyswelRS?=
 =?utf-8?B?MmtLZlJCMkh0WS9BQklpZFA3N0dCTlpzYWtabDM4RzdXZFE4c1g2eW5vajJ3?=
 =?utf-8?B?TFgxa3FsbTNWekJFcU53bmNKVGRzT0Z5WVhMaC9CWlBRSXlCRm5jSUpLS1Jr?=
 =?utf-8?B?RnNheUdHbG5XT2tqbUpoRUdLL2NnSnp3bnQ4YjZEU0tZamJFbGlQSmFyck9I?=
 =?utf-8?B?Q1pMcnE1amV1VWZSVm1CaUlPclZxcWJDL0J4eEwrMUF3NjViZU5tY2UvWWIz?=
 =?utf-8?B?aVdPdTA3blE5djc4Z3lUYTlNWnpmbE13SVNtcU9PMTFONmJHRElqZXZKaWZF?=
 =?utf-8?B?VHorSklSMllRdmxXR05TZmhYMVRBZUUyVFlpbDBkamtiTXdVSXk4MTkxTHI2?=
 =?utf-8?B?dVNDRnVaNmtKWjlFcCtuL0l6a043aFYzUEFkY0toTjkxQ1Y4ODlBZFZXTENB?=
 =?utf-8?B?ZEVQaHRJb09uYnkvQjJlaWZZT1ZoRmJpODV3NHhqSjRpYjF6WDFaVTlXN2tq?=
 =?utf-8?B?Szk3Q0hLNFMzSk5nbmo3Y0xEOGlGWUJsWTZMZ3VMMVVIQXJGYm9mdksrMFdY?=
 =?utf-8?B?NGpwRTlrVjYxYnYyUU1HZjVzeVFlT2ExY3d0K1BKczVNYUZ6WHdxN0V3Zk9W?=
 =?utf-8?B?QnRTYngxV1dhRWdaM3NtYUZ6ZEtYOGZtN3J1WXQybkpkZ0E4SHh0V3BXdzVE?=
 =?utf-8?Q?1w9WKX449dVOQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 08:31:09.6870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49daa34b-dc45-4ddb-62e7-08dc6826b8c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
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
v2:
 - "The handle_connector_type function is called within the
    construct_phy function. If it encounters an unsupported connector
    type, it returns false, maintained same as original logic before
    refactoring"

 .../drm/amd/display/dc/link/link_factory.c    | 223 ++++++++++--------
 1 file changed, 124 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index cf22b8f28ba6..4ed8e170ebc5 100644
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
+static bool handle_connector_type(struct dc_link *link, struct dc_context *dc_ctx)
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
@@ -564,69 +560,99 @@ static bool construct_phy(struct dc_link *link,
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
+		return false;
 	}
+	return true;
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
+	if (!handle_connector_type(link, dc_ctx))
+		goto create_fail;
 
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
@@ -730,7 +756,6 @@ static bool construct_phy(struct dc_link *link,
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 panel_cntl_create_fail:
 	link_destroy_ddc_service(&link->ddc);
-ddc_create_fail:
 create_fail:
 
 	if (link->hpd_gpio) {
-- 
2.34.1

