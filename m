Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCF9CD5BB3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 20:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2FE110F163;
	Wed, 20 May 2026 20:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35fC8nK8";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310F810F163
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 20:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXS753YZOrG6lTTM/KZAvx2YsPz5rC1xJKhUIhAnMvv+iYNNoarNo84lW7545/MhjZtQbPdtExRvR99DnkbOJc0Guv8oRisIO368y34Uxphe/I4ivwZSeigq4Vk/5yX5YhuUd4uIwUjD7OJdRbCKJJ+ZnD48vOOvfALLTP7Uh6jQZUPdWIR42SjE/He8PU9B5J37/XFJbrT1NXS9YlKhHEWCYRP2NawQdN3trT1iVjvg7yxbnIF9bvkfWCTkakl1K8AYBUMjB6nGnabpXfttOlY751ESAgX4JH7q/ifGb4+SPfRhDtBx7/5BA/+HJ5A+wmgX+N/IWiBi/X3GK/6sHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsggJ5Uwzfh8oVR0rA3YwDo0hYtIQZX5BOMz5CD+U84=;
 b=B2n5jq1cCgU1jwGvpsfOtCN10NeUNJvkQK3wqrVET5NWMfGI7V225kxlse4E8mwIkjH1m/yB/6Tj/hvj90xQxl50OVDKpTQEf+sSpErj5Y7P/1wUz3YCb1LKm2o/TNsEGONSh2+v2TggeSAGMzMdsoJqAsB52qENmOi+Y/P49txVbSxeu2eOXHTbHkRlbhFyzx5xShLOFjojd9djy94SykC/VCRzBLZkZJF81Z21kBdklCebKBIu0LZJCUIxHHBHTgyImWm/uKvwf3hcFFol6/zscr0dL+SjrL9rP5FuJqDv1SO8IJ6QX7fxuow9qDKPpiDuyIvLXuy38VAzDUis1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsggJ5Uwzfh8oVR0rA3YwDo0hYtIQZX5BOMz5CD+U84=;
 b=35fC8nK8+8btoyLKl43BNkx9cAA/T6pAMB2CnPpwFk7cvGcBtdKDaB71PIRgimQ/m5jOJHBAIzBgTORckXtGdl2T/63Yhqj2z1aGGu83xllmwjVVSMZw4w12tbWB1+UPr+KEn9VKiv40BGjy6gvTlPFqJo4FxjjY7e7oMsbsGic=
Received: from CH0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:610:76::34)
 by BN7PPFD3499E3E3.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 20 May
 2026 20:29:47 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::f9) by CH0PR04CA0029.outlook.office365.com
 (2603:10b6:610:76::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 20:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 20:29:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 20 May
 2026 15:29:43 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 15:29:43 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v6 15/15] drm/amd/display: Disable FRL and add module param to
 enable it
Date: Wed, 20 May 2026 16:29:28 -0400
Message-ID: <20260520202929.555119-16-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520202929.555119-1-harry.wentland@amd.com>
References: <20260520202929.555119-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|BN7PPFD3499E3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 488a5885-c733-48e8-2fb8-08deb6ae88d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 0CuiGYKba0vgCj2fg1/tFdYbhaZo/PBmOio0mZksLxVARJPI5twS+dY9l7ezvz3/DpR8JP5hYY0Ile4fKMAuLDNHQWMrI/tU4aBGGSlJy7b1tl6IRZw8K0UCebsgll96x8XXkaZfwdu9nF/FsuYSkVy+S/XNPruRL0uloUzwJGEj3rpeVtMsuJ8FY0egLl17M2XD2oUsoFC8ZnZ1koFihQjNETHGOfApp4IepfpfmA+BuoWA45qgImAdbpYw2N3+bPhYkMBRrcr3XN4ASGWGVnfq3BYd/KFj/+ZW8PEwV0jtkeT/vmqWo4u9KPDjpMNKmuxJy8vj3WjeN2ULM884pr9LokqSqZcZcs/YzA8K0FwSco4v7DOJohf7c8XXMUMxlGslXH+AK43AEpVoyNp75bT4pEnZdksYWwwTGjJoDw3BiEBTl3NrdwuNsx5XGtE+pEfQFcS91xkyL1ZU7I3zo0CGRbWa/3GwY4LckZkLwNIiyvbSx9hKzEP9EOk6xYg+KP/BbcUs/rhYTj3/52ouXlT0OpOjeLv1uOQT2wsmy7f4uptl9It6hZdyywBujIy0UiucQhICQWs4jaztyJzzUGbKaj8cscekDcqZqojk671VFdhBIZqTc0huCtpEFCFPQU+NOglihFAZ1B0+2NZkz+JMHuvjW7lRSIe5HlnMz8ICyh3l6qfP8P4OJJqW0UvBUmb1MhkxTLfwkvKlxzYH9IxZ7C5xo4/hJ2NJur0JdCg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o3rSNyNkaGGLmm5xMN2wF4oW72D7wkte/nmiV5oYKs7srm+W8xjKNuyfWoiIeKleXX2FeU3twMEbwD/73ArubdGsLHfuNBk06XR/E1vWjo19aLEHuDgCmAh3j7xUggpFryeiVsu5S4z/YirIR8R4V1HkJzXq/4xZPdpwFWx/cnZSaep/5AWPhQFQFogXoOqXw6IHEpbV3Qs2RrfflPyop7RDODfCseBrIIQ8BjUpfKu66c/NH6+ZepaFn29wR+H+hpMxk05G6IAhhw3OzOf5GslvrB4TYJCv82DSGAlhVTRaglAICqEIAH4w+V2kzztWJfGVnOo9nNXBXbn9LknuuJPSjjEtemq/RSkcDGY+1qpesPgpBP+ckGS7pmb7bXn2axikHfubxuBWQhfzYj1kbsZmgnr4Xy7vG0cl97Vonu9O9T09pzNhcrtDAQ0On4d2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 20:29:46.6395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 488a5885-c733-48e8-2fb8-08deb6ae88d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD3499E3E3
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

FRL links don't yet support VRR. If we enable it by default
users will see a functional regression when connected to an FRL
capable display as the driver will now default to FRL and not
allow VRR.

VRR support will come soon, so instead of making an elaborate
TMDS fallback mechanism simply default FRL to disabled, but
provide a dcfeaturemask of 0x400 to enable it if anyone wants
to already try it out.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 30 ++++++++++---------
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/include/amd_shared.h      |  4 +++
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 63fd63ea1310..15ebad9c9a76 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2081,6 +2081,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
 		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
 
+	if (amdgpu_dc_feature_mask & DC_FRL_MASK)
+		init_data.flags.enable_frl = true;
+
 	init_data.flags.seamless_boot_edp_requested = false;
 
 	if (amdgpu_device_seamless_boot_supported(adev)) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 5efbcf6eae86..7d37c1612131 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1116,7 +1116,7 @@ int amdgpu_dm_update_plane_color_mgmt(struct dm_crtc_state *crtc,
 void amdgpu_dm_update_connector_after_detect(
 		struct amdgpu_dm_connector *aconnector);
 
-void populate_hdmi_info_from_connector(struct drm_hdmi_info *info,
+void populate_hdmi_info_from_connector(bool enable_frl, struct drm_hdmi_info *info,
 				      struct dc_edid_caps *edid_caps);
 
 extern const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index f9ec006e08c4..af32202f8c10 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -179,7 +179,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
 	if (edid_caps->edid_hdmi) {
-		populate_hdmi_info_from_connector(&connector->display_info.hdmi, edid_caps);
+		populate_hdmi_info_from_connector(link->dc->config.enable_frl, &connector->display_info.hdmi, edid_caps);
 		drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] max_frl_rate %d\n", __func__, connector->name, edid_caps->max_frl_rate);
 		if (edid_caps->frl_dsc_support)
 			drm_dbg_driver(connector->dev, "%s: HDMI_FRL_DSC [%s] frl_dsc_10bpc %d, frl_dsc_12bpc %d, frl_dsc_all_bpp %d, frl_dsc_native_420 %d, frl_dsc_max_slices %d, frl_dsc_max_frl_rate %d, frl_dsc_total_chunk_kbytes %d\n",
@@ -1124,21 +1124,23 @@ static uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
 	return dsc_max_slices;
 }
 
-void populate_hdmi_info_from_connector(struct drm_hdmi_info *hdmi, struct dc_edid_caps *edid_caps)
+void populate_hdmi_info_from_connector(bool enable_frl, struct drm_hdmi_info *hdmi, struct dc_edid_caps *edid_caps)
 {
 	edid_caps->scdc_present = hdmi->scdc.supported;
-	edid_caps->max_frl_rate = get_max_frl_rate(hdmi->max_lanes, hdmi->max_frl_rate_per_lane);
-	edid_caps->frl_dsc_support = hdmi->dsc_cap.v_1p2;
-	if (edid_caps->frl_dsc_support) {
-		if (hdmi->dsc_cap.bpc_supported == 10)
-			edid_caps->frl_dsc_10bpc = true;
-		else if (hdmi->dsc_cap.bpc_supported == 12)
-			edid_caps->frl_dsc_12bpc = true;
-		edid_caps->frl_dsc_all_bpp = hdmi->dsc_cap.all_bpp;
-		edid_caps->frl_dsc_native_420 = hdmi->dsc_cap.native_420;
-		edid_caps->frl_dsc_max_slices = get_dsc_max_slices(hdmi->dsc_cap.max_slices, hdmi->dsc_cap.clk_per_slice);
-		edid_caps->frl_dsc_max_frl_rate = get_max_frl_rate(hdmi->dsc_cap.max_lanes, hdmi->dsc_cap.max_frl_rate_per_lane);
-		edid_caps->frl_dsc_total_chunk_kbytes = hdmi->dsc_cap.total_chunk_kbytes;
+	if (enable_frl) {
+		edid_caps->max_frl_rate = get_max_frl_rate(hdmi->max_lanes, hdmi->max_frl_rate_per_lane);
+		edid_caps->frl_dsc_support = hdmi->dsc_cap.v_1p2;
+		if (edid_caps->frl_dsc_support) {
+			if (hdmi->dsc_cap.bpc_supported == 10)
+				edid_caps->frl_dsc_10bpc = true;
+			else if (hdmi->dsc_cap.bpc_supported == 12)
+				edid_caps->frl_dsc_12bpc = true;
+			edid_caps->frl_dsc_all_bpp = hdmi->dsc_cap.all_bpp;
+			edid_caps->frl_dsc_native_420 = hdmi->dsc_cap.native_420;
+			edid_caps->frl_dsc_max_slices = get_dsc_max_slices(hdmi->dsc_cap.max_slices, hdmi->dsc_cap.clk_per_slice);
+			edid_caps->frl_dsc_max_frl_rate = get_max_frl_rate(hdmi->dsc_cap.max_lanes, hdmi->dsc_cap.max_frl_rate_per_lane);
+			edid_caps->frl_dsc_total_chunk_kbytes = hdmi->dsc_cap.total_chunk_kbytes;
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3273709bb8d..907757a44da2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -589,6 +589,7 @@ struct dc_config {
 	int smart_mux_version;
 	bool ignore_dpref_ss;
 	bool enable_mipi_converter_optimization;
+	bool enable_frl;
 	bool force_hdmi21_frl_enc_enable;
 	bool skip_frl_pretraining;
 	bool use_default_clock_table;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index ac2d3701e2bd..3fd38323a88b 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -286,6 +286,10 @@ enum DC_FEATURE_MASK {
 	 * @DC_REPLAY_MASK: (0x200) disabled by default for DCN < 3.1.4
 	 */
 	DC_REPLAY_MASK = (1 << 9),
+	/**
+	 * @DC_FRL_MASK: (0x400) disabled by default
+	 */
+	DC_FRL_MASK = (1 << 10),
 };
 
 /**
-- 
2.54.0

