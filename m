Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEFDCD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53BBC10E88D;
	Wed, 10 Jun 2026 09:51:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dMajEPg8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2109710E88D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=invK229M9tv21/uGSswZdivyuh89hQUPnPbuyxGMFfEGjTEgqSyJjDFoPpk844zEoWOG/3yCPS9PAVR40A1EfRxAbQ7zOq6GIod4Ub+JcMJ1+jaMEOI8KTuTskNeihm3F92gOGscS46yzMFlJOVL8axM5b6ZVnjApsqB73i6atiVk/j3Bxu3+EXGqhks3KV1W8BTzENA7c0O5g1K2nR30g9HNYkU0z6TERZAX1opYlFP2NOslxji6YOlvuOOmgCo7NdVrUTuXKQnQZPTCXZ++MFeifepWFQITcrdjGq+l7NNzcgccNFXIY1QGDmpFCvHl7tG0vgX1ZG3aE59ehCPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnLjzoDanYEGHqoQTQl6t5g9FSM6hXWzgauCNLnc7jE=;
 b=d0q4ZcDjBZkFUPNnzS+dv6a8oiuBeWPlT0f648RAsPzqXF8a1zEh+iNKmC1ZaECpWbFIx+9wSRzKuFejcCADNp6Mb5WUDtCQ+vaHvlqHHhIWFPW3xtC8vUNmowXy2PVCgohqTi0Z7sgRARdLExeTh4xlLhSYi3Rk4tOHuNIOcfVmdgsKcbNGe0QbPiuqIVPcgZfmCevqaWphzmdDJ0AA0oXW9ZSbTDiTdTqidhcd3hxBO8pRU35oCki1KQtlUm8a03o2Lbmc9Y0yM9zuOKKoY5iBbhXP0mMkjyzWCiDzgu0gHA70lAmTbHGJxfe7UG17HB1e2lgKo3VL+l2g3bY1Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnLjzoDanYEGHqoQTQl6t5g9FSM6hXWzgauCNLnc7jE=;
 b=dMajEPg8JQFEyM8IF0lKlqdU7Zy9IYA4ecGufJCVIiiCoAs5J67MYtMIbRzmtT8bT/pPWeqrvMgsZVZsD/bUymLu3G6lBjyUNXIabZ/Pzpja9lQu/kxTCHWHJe/qjSthMZ1vA/XXUWe8iCQW21pJqWQ+Qk1Pgpm1WMWlOLdEzh0=
Received: from PH7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::19)
 by SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:51:49 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::10) by PH7P222CA0025.outlook.office365.com
 (2603:10b6:510:33a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:51:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:51:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:51:48 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:51:39 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 25/32] drm/amd/display: Add KUnit tests for amdgpu_dm_helpers
Date: Wed, 10 Jun 2026 17:45:09 +0800
Message-ID: <20260610094639.1965367-26-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: c84eee40-4bb3-440d-d5d9-08dec6d5e453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|3023799007|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2Zi/W1mG7TkQXkz8X48Q3yOMPA48TZTW/0SAayYVxj7lAaxmPr0xBMCdProZ/ecINmhIfpCltP9iVg3U9NTsHIPhIofp8ADf0Y7yDLjuBrc3pcd74E4s/0t/wdF230iRQ7GsjfNIgCvt95uIBXN6LRxGl1nSTcW0HQWDeVL6p7e39sXt86K7j3Z5qsTMN60BWR1EKxQ8qth+sgp8hvnbmrKi9XOUC+zkxTE30Vv3b1vMEBhpzS96Iq9Iq+lQNcCYuqdR3AbTmzxfItzuRfZc6f5tbr79shI/Hu9AkqyDUvznzDky/tfEt3jxMjJaNLL6CzmlOnCbhwINfON8vWb+N+OU6fBGijUN16hzlbEaD6NHntmiOaedXu5on9H0R8u+r8J80k01jzSXFxi/mwmP9gz4UOM/Z+vpwE80ukRIgsoeREcPRZgeNUxsNpjqBWOjlPV81D61xDGXhSBTn4+JjjITWX63GAPTVt+bozZ6C8A3t2oD2Q4M0BwIWQA4XH2HMdDoU8scmT73JqYFd+/sqriqui+idl70N/gIG9/Xg2+tuwcQhfq0kFzxfbdHWl6kEsUm6M/zE2tzVSHxiF/xRRaxBb5w4Y4JWsU/uxB/qqCkRRoLnIB8BxY9Z5mPR5QarwrxyV+/hq96gzje9amBEAM1gzoX3o5FM6aNadtXQWQA2Rd8L5W+RmTpegeNHvR5ngwi/MmU1nLgyNW1GMyojyY4h4bkx7B+sFv+G8HMGxc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(3023799007)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jE+XYWAIveNPb5O0fqXRxMPgJH+svqDyUykDIClXqDopLrISJhNGTLq0ZvokUOiie1wEqhSnDdBSLm93EnEFkKTWUvv0YBW8f/WX1UGYhx9A/I9AuPsUlprlFbRJ9vuWyhVJWjSPTuIyC6ebSep4lQjfY8IRrtkfbo+QEjxK4dTrH6xQpOEkg9DKfLm6+lsjvu0IYflOUf1VfUI3SDvLz6FR+9T/7o1H8X6sOVgVpANGDGa3LGgUjN0E97XSQPo4jEzZrdy79iN16nmC0BXBOvxRy7vFPZ1h0pEv6c967qkajvJtMZRA6G40K0GnNijR7dGOIC655Ack18ANtl0sPNHP9Khzn/jz/ploh4pEaFg2CEwdwyG7AewTRK4Yx1WwoqLSHfFhufJ+V6mDe8nIf7l9I0aO4BPGoVYba/58HOaI+pWphqTYuaSkFc3YUXTW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:51:49.3561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84eee40-4bb3-440d-d5d9-08dec6d5e453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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

From: Alex Hung <alex.hung@amd.com>

Add amdgpu_dm_helpers_test.c with 32 KUnit test cases covering the
following functions in amdgpu_dm_helpers.c:

- edid_extract_panel_id(): basic extraction with known mfg_id and
  prod_code; zero inputs produce zero output.
- dm_is_freesync_pcon_whitelist(): every entry in the whitelist
  table returns true; an unknown ID and a zero ID return false.
- populate_hdmi_info_from_connector(): scdc_present is copied from
  hdmi->scdc.supported for both true and false; FRL DSC fields map
  10bpc and 12bpc correctly and ignore unknown values.
- dm_get_adaptive_sync_support_type(): five cases covering the
  default non-converter path, HDMI converter without conditions,
  partial conditions, all conditions met with a whitelist device
  (FREESYNC_TYPE_PCON_IN_WHITELIST), and all conditions met with a
  non-whitelisted device.
- dm_helpers_is_fullscreen() / dm_helpers_is_hdr_on(): stubs always
  return false.
- get_max_frl_rate(): all six valid lane/rate combinations plus the
  unknown combination returning 0.
- dm_dtn_log_begin()/dm_dtn_log_append_v()/dm_dtn_log_end(): buffer
  accumulation and NULL-context handling without crashing.
- dm_helpers_dp_read_dpcd()/dm_helpers_dp_write_dpcd(): NULL link
  private data returns false.
- dm_helpers_dp_mst_start_top_mgr()/dm_helpers_dp_mst_stop_top_mgr():
  NULL link private data and the boot path.
- dm_helpers_dp_write_hblank_reduction(): stub returns false.

Assisted-by: Copilot:Claude-Opus-4.8

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  58 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.h |  20 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 645 ++++++++++++++++++
 4 files changed, 707 insertions(+), 17 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6350212b9a66..9c4e0a4e251c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -48,6 +48,8 @@
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
 #include "clk_mgr.h"
+#include "amdgpu_dm_kunit_helpers.h"
+#include "amdgpu_dm_helpers.h"
 
 #define MCCS_DEST_ADDR (0x6E >> 1)
 #define MCCS_SRC_ADDR	0x51
@@ -88,12 +90,13 @@ union vcp_reply {
 	unsigned char raw[11];
 };
 
-static u32 edid_extract_panel_id(struct edid *edid)
+STATIC_IFN_KUNIT u32 edid_extract_panel_id(struct edid *edid)
 {
 	return (u32)edid->mfg_id[0] << 24   |
 	       (u32)edid->mfg_id[1] << 16   |
 	       (u32)EDID_PRODUCT_ID(edid);
 }
+EXPORT_IF_KUNIT(edid_extract_panel_id);
 
 static void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 			      struct dc_edid_caps *edid_caps)
@@ -495,6 +498,7 @@ void dm_dtn_log_begin(struct dc_context *ctx,
 
 	dm_dtn_log_append_v(ctx, log_ctx, "%s", msg);
 }
+EXPORT_IF_KUNIT(dm_dtn_log_begin);
 
 __printf(3, 4)
 void dm_dtn_log_append_v(struct dc_context *ctx,
@@ -557,6 +561,7 @@ void dm_dtn_log_append_v(struct dc_context *ctx,
 	if (n > 0)
 		log_ctx->pos += n;
 }
+EXPORT_IF_KUNIT(dm_dtn_log_append_v);
 
 void dm_dtn_log_end(struct dc_context *ctx,
 	struct dc_log_buffer_ctx *log_ctx)
@@ -570,6 +575,7 @@ void dm_dtn_log_end(struct dc_context *ctx,
 
 	dm_dtn_log_append_v(ctx, log_ctx, "%s", msg);
 }
+EXPORT_IF_KUNIT(dm_dtn_log_end);
 
 bool dm_helpers_dp_mst_start_top_mgr(
 		struct dc_context *ctx,
@@ -604,6 +610,7 @@ bool dm_helpers_dp_mst_start_top_mgr(
 
 	return true;
 }
+EXPORT_IF_KUNIT(dm_helpers_dp_mst_start_top_mgr);
 
 bool dm_helpers_dp_mst_stop_top_mgr(
 		struct dc_context *ctx,
@@ -626,6 +633,7 @@ bool dm_helpers_dp_mst_stop_top_mgr(
 
 	return false;
 }
+EXPORT_IF_KUNIT(dm_helpers_dp_mst_stop_top_mgr);
 
 bool dm_helpers_dp_read_dpcd(
 		struct dc_context *ctx,
@@ -643,6 +651,7 @@ bool dm_helpers_dp_read_dpcd(
 	return drm_dp_dpcd_read(&aconnector->dm_dp_aux.aux, address, data,
 				size) == size;
 }
+EXPORT_IF_KUNIT(dm_helpers_dp_read_dpcd);
 
 bool dm_helpers_dp_write_dpcd(
 		struct dc_context *ctx,
@@ -659,6 +668,7 @@ bool dm_helpers_dp_write_dpcd(
 	return drm_dp_dpcd_write(&aconnector->dm_dp_aux.aux,
 			address, (uint8_t *)data, size) > 0;
 }
+EXPORT_IF_KUNIT(dm_helpers_dp_write_dpcd);
 
 bool dm_helpers_submit_i2c(
 		struct dc_context *ctx,
@@ -974,6 +984,7 @@ bool dm_helpers_dp_write_hblank_reduction(struct dc_context *ctx, const struct d
 	// TODO
 	return false;
 }
+EXPORT_IF_KUNIT(dm_helpers_dp_write_hblank_reduction);
 
 bool dm_helpers_is_dp_sink_present(struct dc_link *link)
 {
@@ -1091,7 +1102,7 @@ dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link, struct amdgpu_dm_conn
 	return edid;
 }
 
-static uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
+STATIC_IFN_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
 {
 	uint8_t max_frl_rate;
 
@@ -1112,6 +1123,7 @@ static uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
 
 	return max_frl_rate;
 }
+EXPORT_IF_KUNIT(get_max_frl_rate);
 
 static uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
 {
@@ -1156,6 +1168,7 @@ void populate_hdmi_info_from_connector(bool enable_frl, struct drm_hdmi_info *hd
 		}
 	}
 }
+EXPORT_IF_KUNIT(populate_hdmi_info_from_connector);
 
 enum dc_edid_status dm_helpers_read_local_edid(
 		struct dc_context *ctx,
@@ -1556,24 +1569,32 @@ void dm_helpers_dp_mst_update_branch_bandwidth(
 	// TODO
 }
 
-static bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
+STATIC_IFN_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
+	DP_BRANCH_DEVICE_ID_0060AD,
+	DP_BRANCH_DEVICE_ID_00E04C,
+	DP_BRANCH_DEVICE_ID_90CC24,
+	DP_BRANCH_DEVICE_ID_001CF8,
+	DP_BRANCH_DEVICE_ID_001FF2,
+};
+EXPORT_IF_KUNIT(dm_freesync_pcon_whitelist);
+
+STATIC_IFN_KUNIT uint32_t dm_freesync_pcon_whitelist_count(void)
 {
-	bool ret_val = false;
-
-	switch (branch_dev_id) {
-	case DP_BRANCH_DEVICE_ID_0060AD:
-	case DP_BRANCH_DEVICE_ID_00E04C:
-	case DP_BRANCH_DEVICE_ID_90CC24:
-	case DP_BRANCH_DEVICE_ID_001CF8:
-	case DP_BRANCH_DEVICE_ID_001FF2:
-		ret_val = true;
-		break;
-	default:
-		break;
-	}
+	return ARRAY_SIZE(dm_freesync_pcon_whitelist);
+}
+EXPORT_IF_KUNIT(dm_freesync_pcon_whitelist_count);
+
+STATIC_IFN_KUNIT bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
+{
+	u32 i;
 
-	return ret_val;
+	for (i = 0; i < dm_freesync_pcon_whitelist_count(); i++)
+		if (dm_freesync_pcon_whitelist[i] == branch_dev_id)
+			return true;
+
+	return false;
 }
+EXPORT_IF_KUNIT(dm_is_freesync_pcon_whitelist);
 
 enum adaptive_sync_type dm_get_adaptive_sync_support_type(struct dc_link *link)
 {
@@ -1593,18 +1614,21 @@ enum adaptive_sync_type dm_get_adaptive_sync_support_type(struct dc_link *link)
 
 	return as_type;
 }
+EXPORT_IF_KUNIT(dm_get_adaptive_sync_support_type);
 
 bool dm_helpers_is_fullscreen(struct dc_context *ctx, struct dc_stream_state *stream)
 {
 	// TODO
 	return false;
 }
+EXPORT_IF_KUNIT(dm_helpers_is_fullscreen);
 
 bool dm_helpers_is_hdr_on(struct dc_context *ctx, struct dc_stream_state *stream)
 {
 	// TODO
 	return false;
 }
+EXPORT_IF_KUNIT(dm_helpers_is_hdr_on);
 
 static int mccs_operation_vcp_request(unsigned int vcp_code, struct dc_link *link,
 				union vcp_reply *reply)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
new file mode 100644
index 000000000000..2ac9762895ec
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef __AMDGPU_DM_HELPERS_H__
+#define __AMDGPU_DM_HELPERS_H__
+
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#include <drm/drm_edid.h>
+
+/* Exported for KUnit testing */
+u32 edid_extract_panel_id(struct edid *edid);
+uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane);
+bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id);
+extern const uint32_t dm_freesync_pcon_whitelist[];
+uint32_t dm_freesync_pcon_whitelist_count(void);
+#endif /* CONFIG_DRM_AMD_DC_KUNIT_TEST */
+
+#endif /* __AMDGPU_DM_HELPERS_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 364b4f3c783f..a067332f9f41 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_pp_smu_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crtc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_services_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_helpers_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
new file mode 100644
index 000000000000..14004ff87c9b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -0,0 +1,645 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_helpers.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_kunit_helpers.h>
+
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+#include "dm_helpers.h"
+#include "ddc_service_types.h"
+#include "amdgpu_dm_helpers.h"
+
+/* Tests for edid_extract_panel_id() */
+
+/**
+ * dm_test_edid_extract_panel_id_basic - Test Edid extract panel id basic
+ * @test: The KUnit test context
+ */
+static void dm_test_edid_extract_panel_id_basic(struct kunit *test)
+{
+	struct edid *edid;
+	u32 panel_id;
+
+	edid = kunit_kzalloc(test, sizeof(*edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, edid);
+
+	edid->mfg_id[0] = 0x12;
+	edid->mfg_id[1] = 0x34;
+	edid->prod_code[0] = 0xAB;
+	edid->prod_code[1] = 0xCD;
+
+	panel_id = edid_extract_panel_id(edid);
+
+	/*
+	 * Expected: (0x12 << 24) | (0x34 << 16) | EDID_PRODUCT_ID(edid)
+	 * EDID_PRODUCT_ID = prod_code[0] | (prod_code[1] << 8) = 0xAB | 0xCD00 = 0xCDAB
+	 * Result: 0x12340000 | 0x0000CDAB = 0x1234CDAB
+	 */
+	KUNIT_EXPECT_EQ(test, panel_id, (u32)0x1234CDAB);
+}
+
+/**
+ * dm_test_edid_extract_panel_id_zeros - Test Edid extract panel id zeros
+ * @test: The KUnit test context
+ */
+static void dm_test_edid_extract_panel_id_zeros(struct kunit *test)
+{
+	struct edid *edid;
+
+	edid = kunit_kzalloc(test, sizeof(*edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, edid);
+
+	KUNIT_EXPECT_EQ(test, edid_extract_panel_id(edid), 0U);
+}
+
+/* Tests for dm_is_freesync_pcon_whitelist() */
+
+/**
+ * dm_test_freesync_pcon_whitelist_all_known - Test all known Freesync Pcon whitelist entries
+ * @test: The KUnit test context
+ *
+ * Iterates over the driver's whitelist table directly so that any ID added
+ * to dm_freesync_pcon_whitelist[] is automatically covered by this test.
+ */
+static void dm_test_freesync_pcon_whitelist_all_known(struct kunit *test)
+{
+	u32 i;
+
+	for (i = 0; i < dm_freesync_pcon_whitelist_count(); i++)
+		KUNIT_EXPECT_TRUE(test,
+				  dm_is_freesync_pcon_whitelist(dm_freesync_pcon_whitelist[i]));
+}
+
+/**
+ * dm_test_freesync_pcon_whitelist_not_in_list - Test Freesync pcon whitelist not in list
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_pcon_whitelist_not_in_list(struct kunit *test)
+{
+	/* 0xFFFFFF is not a known whitelist device */
+	KUNIT_EXPECT_FALSE(test, dm_is_freesync_pcon_whitelist(0xFFFFFF));
+}
+
+/**
+ * dm_test_freesync_pcon_whitelist_zero - Test Freesync pcon whitelist zero
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_pcon_whitelist_zero(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test, dm_is_freesync_pcon_whitelist(0));
+}
+
+/* Tests for populate_hdmi_info_from_connector() */
+
+/**
+ * dm_test_populate_hdmi_scdc_present_true - Test Populate hdmi scdc present true
+ * @test: The KUnit test context
+ */
+static void dm_test_populate_hdmi_scdc_present_true(struct kunit *test)
+{
+	struct drm_hdmi_info *hdmi;
+	struct dc_edid_caps *caps;
+
+	hdmi = kunit_kzalloc(test, sizeof(*hdmi), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, hdmi);
+	caps = kunit_kzalloc(test, sizeof(*caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, caps);
+
+	hdmi->scdc.supported = true;
+
+	populate_hdmi_info_from_connector(true, hdmi, caps);
+
+	KUNIT_EXPECT_TRUE(test, caps->scdc_present);
+}
+
+/**
+ * dm_test_populate_hdmi_scdc_present_false - Test Populate hdmi scdc present false
+ * @test: The KUnit test context
+ */
+static void dm_test_populate_hdmi_scdc_present_false(struct kunit *test)
+{
+	struct drm_hdmi_info *hdmi;
+	struct dc_edid_caps *caps;
+
+	hdmi = kunit_kzalloc(test, sizeof(*hdmi), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, hdmi);
+	caps = kunit_kzalloc(test, sizeof(*caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, caps);
+
+	hdmi->scdc.supported = false;
+	caps->scdc_present = true; /* pre-set to confirm it gets cleared */
+
+	populate_hdmi_info_from_connector(true, hdmi, caps);
+
+	KUNIT_EXPECT_FALSE(test, caps->scdc_present);
+}
+
+/**
+ * dm_test_populate_hdmi_frl_dsc_10bpc - Test HDMI FRL DSC 10 bpc caps
+ * @test: The KUnit test context
+ */
+static void dm_test_populate_hdmi_frl_dsc_10bpc(struct kunit *test)
+{
+	struct drm_hdmi_info *hdmi;
+	struct dc_edid_caps *caps;
+
+	hdmi = kunit_kzalloc(test, sizeof(*hdmi), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, hdmi);
+	caps = kunit_kzalloc(test, sizeof(*caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, caps);
+
+	hdmi->max_lanes = 4;
+	hdmi->max_frl_rate_per_lane = 12;
+	hdmi->dsc_cap.v_1p2 = true;
+	hdmi->dsc_cap.bpc_supported = 10;
+	hdmi->dsc_cap.all_bpp = true;
+	hdmi->dsc_cap.native_420 = true;
+	hdmi->dsc_cap.max_slices = 8;
+	hdmi->dsc_cap.clk_per_slice = 400;
+	hdmi->dsc_cap.max_lanes = 4;
+	hdmi->dsc_cap.max_frl_rate_per_lane = 10;
+	hdmi->dsc_cap.total_chunk_kbytes = 7;
+
+	populate_hdmi_info_from_connector(true, hdmi, caps);
+
+	KUNIT_EXPECT_EQ(test, caps->max_frl_rate, 6);
+	KUNIT_EXPECT_TRUE(test, caps->frl_dsc_support);
+	KUNIT_EXPECT_TRUE(test, caps->frl_dsc_10bpc);
+	KUNIT_EXPECT_FALSE(test, caps->frl_dsc_12bpc);
+	KUNIT_EXPECT_TRUE(test, caps->frl_dsc_all_bpp);
+	KUNIT_EXPECT_TRUE(test, caps->frl_dsc_native_420);
+	KUNIT_EXPECT_EQ(test, caps->frl_dsc_max_slices, 5);
+	KUNIT_EXPECT_EQ(test, caps->frl_dsc_max_frl_rate, 5);
+	KUNIT_EXPECT_EQ(test, caps->frl_dsc_total_chunk_kbytes, 7);
+}
+
+/**
+ * dm_test_populate_hdmi_frl_dsc_12bpc - Test HDMI FRL DSC 12 bpc caps
+ * @test: The KUnit test context
+ */
+static void dm_test_populate_hdmi_frl_dsc_12bpc(struct kunit *test)
+{
+	struct drm_hdmi_info *hdmi;
+	struct dc_edid_caps *caps;
+
+	hdmi = kunit_kzalloc(test, sizeof(*hdmi), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, hdmi);
+	caps = kunit_kzalloc(test, sizeof(*caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, caps);
+
+	hdmi->max_lanes = 3;
+	hdmi->max_frl_rate_per_lane = 6;
+	hdmi->dsc_cap.v_1p2 = true;
+	hdmi->dsc_cap.bpc_supported = 12;
+	hdmi->dsc_cap.max_slices = 16;
+	hdmi->dsc_cap.clk_per_slice = 400;
+	hdmi->dsc_cap.max_lanes = 3;
+	hdmi->dsc_cap.max_frl_rate_per_lane = 3;
+
+	populate_hdmi_info_from_connector(true, hdmi, caps);
+
+	KUNIT_EXPECT_EQ(test, caps->max_frl_rate, 2);
+	KUNIT_EXPECT_TRUE(test, caps->frl_dsc_support);
+	KUNIT_EXPECT_FALSE(test, caps->frl_dsc_10bpc);
+	KUNIT_EXPECT_TRUE(test, caps->frl_dsc_12bpc);
+	KUNIT_EXPECT_EQ(test, caps->frl_dsc_max_slices, 7);
+	KUNIT_EXPECT_EQ(test, caps->frl_dsc_max_frl_rate, 1);
+}
+
+/**
+ * dm_test_populate_hdmi_frl_dsc_unknown_values - Test HDMI FRL DSC unknown values
+ * @test: The KUnit test context
+ */
+static void dm_test_populate_hdmi_frl_dsc_unknown_values(struct kunit *test)
+{
+	struct drm_hdmi_info *hdmi;
+	struct dc_edid_caps *caps;
+
+	hdmi = kunit_kzalloc(test, sizeof(*hdmi), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, hdmi);
+	caps = kunit_kzalloc(test, sizeof(*caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, caps);
+
+	hdmi->max_lanes = 2;
+	hdmi->max_frl_rate_per_lane = 3;
+	hdmi->dsc_cap.v_1p2 = true;
+	hdmi->dsc_cap.bpc_supported = 8;
+	hdmi->dsc_cap.max_slices = 3;
+	hdmi->dsc_cap.clk_per_slice = 340;
+	hdmi->dsc_cap.max_lanes = 2;
+	hdmi->dsc_cap.max_frl_rate_per_lane = 12;
+
+	populate_hdmi_info_from_connector(true, hdmi, caps);
+
+	KUNIT_EXPECT_EQ(test, caps->max_frl_rate, 0);
+	KUNIT_EXPECT_TRUE(test, caps->frl_dsc_support);
+	KUNIT_EXPECT_FALSE(test, caps->frl_dsc_10bpc);
+	KUNIT_EXPECT_FALSE(test, caps->frl_dsc_12bpc);
+	KUNIT_EXPECT_EQ(test, caps->frl_dsc_max_slices, 0);
+	KUNIT_EXPECT_EQ(test, caps->frl_dsc_max_frl_rate, 0);
+}
+
+/* Tests for dm_get_adaptive_sync_support_type() */
+
+/**
+ * dm_test_adaptive_sync_type_none_default - Test Adaptive sync type none default
+ * @test: The KUnit test context
+ */
+static void dm_test_adaptive_sync_type_none_default(struct kunit *test)
+{
+	struct dc_link *link;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* dongle_type = 0 (DISPLAY_DONGLE_NONE) → default case → TYPE_NONE */
+	KUNIT_EXPECT_EQ(test,
+			(int)dm_get_adaptive_sync_support_type(link),
+			(int)ADAPTIVE_SYNC_TYPE_NONE);
+}
+
+/**
+ * dm_test_adaptive_sync_type_converter_no_conditions - Converter without caps
+ * @test: The KUnit test context
+ */
+static void dm_test_adaptive_sync_type_converter_no_conditions(struct kunit *test)
+{
+	struct dc_link *link;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* HDMI converter but no adaptive sync cap → still NONE */
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)dm_get_adaptive_sync_support_type(link),
+			(int)ADAPTIVE_SYNC_TYPE_NONE);
+}
+
+/**
+ * dm_test_adaptive_sync_type_converter_partial_conditions - Partial caps
+ * @test: The KUnit test context
+ */
+static void dm_test_adaptive_sync_type_converter_partial_conditions(struct kunit *test)
+{
+	struct dc_link *link;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* Cap set and whitelist ID, but allow_invalid_MSA_timing_param = false */
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+	link->dpcd_caps.adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT = 1;
+	link->dpcd_caps.allow_invalid_MSA_timing_param = false;
+	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_0060AD;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)dm_get_adaptive_sync_support_type(link),
+			(int)ADAPTIVE_SYNC_TYPE_NONE);
+}
+
+/**
+ * dm_test_adaptive_sync_type_pcon_whitelist - Test Adaptive sync type pcon whitelist
+ * @test: The KUnit test context
+ */
+static void dm_test_adaptive_sync_type_pcon_whitelist(struct kunit *test)
+{
+	struct dc_link *link;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* All conditions met → FREESYNC_TYPE_PCON_IN_WHITELIST */
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+	link->dpcd_caps.adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT = 1;
+	link->dpcd_caps.allow_invalid_MSA_timing_param = true;
+	link->dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_0060AD;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)dm_get_adaptive_sync_support_type(link),
+			(int)FREESYNC_TYPE_PCON_IN_WHITELIST);
+}
+
+/**
+ * dm_test_adaptive_sync_type_converter_nonwhitelist - Converter not whitelisted
+ * @test: The KUnit test context
+ */
+static void dm_test_adaptive_sync_type_converter_nonwhitelist(struct kunit *test)
+{
+	struct dc_link *link;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* All conditions met but branch_dev_id not in whitelist → NONE */
+	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
+	link->dpcd_caps.adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT = 1;
+	link->dpcd_caps.allow_invalid_MSA_timing_param = true;
+	link->dpcd_caps.branch_dev_id = 0xFFFFFF;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)dm_get_adaptive_sync_support_type(link),
+			(int)ADAPTIVE_SYNC_TYPE_NONE);
+}
+
+/* Tests for dm_helpers_is_fullscreen() and dm_helpers_is_hdr_on() */
+
+/**
+ * dm_test_helpers_is_fullscreen_returns_false - Test Helpers is fullscreen returns false
+ * @test: The KUnit test context
+ */
+static void dm_test_helpers_is_fullscreen_returns_false(struct kunit *test)
+{
+	/* Stub — always returns false */
+	KUNIT_EXPECT_FALSE(test, dm_helpers_is_fullscreen(NULL, NULL));
+}
+
+/**
+ * dm_test_helpers_is_hdr_on_returns_false - Test Helpers is hdr on returns false
+ * @test: The KUnit test context
+ */
+static void dm_test_helpers_is_hdr_on_returns_false(struct kunit *test)
+{
+	/* Stub — always returns false */
+	KUNIT_EXPECT_FALSE(test, dm_helpers_is_hdr_on(NULL, NULL));
+}
+
+/* Tests for get_max_frl_rate() */
+
+/**
+ * dm_test_get_max_frl_rate_3lanes_3gbps - Test Get max frl rate 3lanes 3gbps
+ * @test: The KUnit test context
+ */
+static void dm_test_get_max_frl_rate_3lanes_3gbps(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_max_frl_rate(3, 3), 1);
+}
+
+/**
+ * dm_test_get_max_frl_rate_3lanes_6gbps - Test Get max frl rate 3lanes 6gbps
+ * @test: The KUnit test context
+ */
+static void dm_test_get_max_frl_rate_3lanes_6gbps(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_max_frl_rate(3, 6), 2);
+}
+
+/**
+ * dm_test_get_max_frl_rate_4lanes_6gbps - Test Get max frl rate 4lanes 6gbps
+ * @test: The KUnit test context
+ */
+static void dm_test_get_max_frl_rate_4lanes_6gbps(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_max_frl_rate(4, 6), 3);
+}
+
+/**
+ * dm_test_get_max_frl_rate_4lanes_8gbps - Test Get max frl rate 4lanes 8gbps
+ * @test: The KUnit test context
+ */
+static void dm_test_get_max_frl_rate_4lanes_8gbps(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_max_frl_rate(4, 8), 4);
+}
+
+/**
+ * dm_test_get_max_frl_rate_4lanes_10gbps - Test Get max frl rate 4lanes 10gbps
+ * @test: The KUnit test context
+ */
+static void dm_test_get_max_frl_rate_4lanes_10gbps(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_max_frl_rate(4, 10), 5);
+}
+
+/**
+ * dm_test_get_max_frl_rate_4lanes_12gbps - Test Get max frl rate 4lanes 12gbps
+ * @test: The KUnit test context
+ */
+static void dm_test_get_max_frl_rate_4lanes_12gbps(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, get_max_frl_rate(4, 12), 6);
+}
+
+/**
+ * dm_test_get_max_frl_rate_unknown - Test Get max frl rate unknown
+ * @test: The KUnit test context
+ */
+static void dm_test_get_max_frl_rate_unknown(struct kunit *test)
+{
+	/* Unknown lane/rate combination → 0 */
+	KUNIT_EXPECT_EQ(test, get_max_frl_rate(2, 3), 0);
+}
+
+/* Tests for dm_dtn_log_begin() / dm_dtn_log_append_v() / dm_dtn_log_end() */
+
+/**
+ * dm_test_dtn_log_buffer_accumulates - Test DTN log buffer accumulation
+ * @test: The KUnit test context
+ */
+static void dm_test_dtn_log_buffer_accumulates(struct kunit *test)
+{
+	struct dc_log_buffer_ctx log_ctx = {0};
+
+	dm_dtn_log_begin(NULL, &log_ctx);
+	dm_dtn_log_append_v(NULL, &log_ctx, "x=%d\n", 7);
+	dm_dtn_log_end(NULL, &log_ctx);
+
+	KUNIT_ASSERT_NOT_NULL(test, log_ctx.buf);
+	KUNIT_EXPECT_STREQ(test, log_ctx.buf, "[dtn begin]\nx=7\n[dtn end]\n");
+	KUNIT_EXPECT_EQ(test, log_ctx.pos, strlen("[dtn begin]\nx=7\n[dtn end]\n"));
+
+	kvfree(log_ctx.buf);
+}
+
+/**
+ * dm_test_dtn_log_null_ctx_no_crash - Test DTN log helpers with NULL log buffer
+ * @test: The KUnit test context
+ */
+static void dm_test_dtn_log_null_ctx_no_crash(struct kunit *test)
+{
+	/* NULL log_ctx redirects to dmesg and must not dereference a buffer */
+	dm_dtn_log_begin(NULL, NULL);
+	dm_dtn_log_append_v(NULL, NULL, "value %d\n", 1);
+	dm_dtn_log_end(NULL, NULL);
+
+	KUNIT_EXPECT_TRUE(test, true);
+}
+
+/* Tests for dm_helpers_dp_read_dpcd() / dm_helpers_dp_write_dpcd() */
+
+/**
+ * dm_test_dp_read_dpcd_null_priv - Test DPCD read returns false without connector
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_read_dpcd_null_priv(struct kunit *test)
+{
+	struct dc_link *link;
+	uint8_t data = 0;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* link->priv (aconnector) is NULL → early return false */
+	KUNIT_EXPECT_FALSE(test,
+			   dm_helpers_dp_read_dpcd(NULL, link, 0, &data, sizeof(data)));
+}
+
+/**
+ * dm_test_dp_write_dpcd_null_priv - Test DPCD write returns false without connector
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dpcd_null_priv(struct kunit *test)
+{
+	struct dc_link *link;
+	uint8_t data = 0;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* link->priv (aconnector) is NULL → early return false */
+	KUNIT_EXPECT_FALSE(test,
+			   dm_helpers_dp_write_dpcd(NULL, link, 0, &data, sizeof(data)));
+}
+
+/* Tests for dm_helpers_dp_mst_start_top_mgr() / dm_helpers_dp_mst_stop_top_mgr() */
+
+/**
+ * dm_test_mst_start_top_mgr_null_priv - Test MST start returns false without connector
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_start_top_mgr_null_priv(struct kunit *test)
+{
+	struct dc_link *link;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	KUNIT_EXPECT_FALSE(test, dm_helpers_dp_mst_start_top_mgr(NULL, link, false));
+}
+
+/**
+ * dm_test_mst_stop_top_mgr_null_priv - Test MST stop returns false without connector
+ * @test: The KUnit test context
+ */
+static void dm_test_mst_stop_top_mgr_null_priv(struct kunit *test)
+{
+	struct dc_link *link;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	KUNIT_EXPECT_FALSE(test, dm_helpers_dp_mst_stop_top_mgr(NULL, link));
+}
+
+/**
+ * dm_test_mst_start_top_mgr_boot - Test MST start boot path on a connector-backed link
+ * @test: The KUnit test context
+ *
+ * Uses the DRM KUnit mock device to back the connector so the link is a
+ * realistic connector-backed link. The boot path short-circuits and returns
+ * true without touching the MST topology manager.
+ */
+static void dm_test_mst_start_top_mgr_boot(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct device *dev;
+	struct dc_link *link;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						  sizeof(*adev),
+						  offsetof(struct amdgpu_device, ddev),
+						  DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	adev = drm_to_adev(drm);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	aconnector->base.dev = drm;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	link->priv = aconnector;
+
+	KUNIT_EXPECT_TRUE(test, dm_helpers_dp_mst_start_top_mgr(NULL, link, true));
+}
+
+/* Tests for dm_helpers_dp_write_hblank_reduction() */
+
+/**
+ * dm_test_dp_write_hblank_reduction_false - Test hblank reduction stub returns false
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_hblank_reduction_false(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test, dm_helpers_dp_write_hblank_reduction(NULL, NULL));
+}
+
+static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
+	/* edid_extract_panel_id */
+	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
+	KUNIT_CASE(dm_test_edid_extract_panel_id_zeros),
+	/* dm_is_freesync_pcon_whitelist */
+	KUNIT_CASE(dm_test_freesync_pcon_whitelist_all_known),
+	KUNIT_CASE(dm_test_freesync_pcon_whitelist_not_in_list),
+	KUNIT_CASE(dm_test_freesync_pcon_whitelist_zero),
+	/* populate_hdmi_info_from_connector */
+	KUNIT_CASE(dm_test_populate_hdmi_scdc_present_true),
+	KUNIT_CASE(dm_test_populate_hdmi_scdc_present_false),
+	KUNIT_CASE(dm_test_populate_hdmi_frl_dsc_10bpc),
+	KUNIT_CASE(dm_test_populate_hdmi_frl_dsc_12bpc),
+	KUNIT_CASE(dm_test_populate_hdmi_frl_dsc_unknown_values),
+	/* dm_get_adaptive_sync_support_type */
+	KUNIT_CASE(dm_test_adaptive_sync_type_none_default),
+	KUNIT_CASE(dm_test_adaptive_sync_type_converter_no_conditions),
+	KUNIT_CASE(dm_test_adaptive_sync_type_converter_partial_conditions),
+	KUNIT_CASE(dm_test_adaptive_sync_type_pcon_whitelist),
+	KUNIT_CASE(dm_test_adaptive_sync_type_converter_nonwhitelist),
+	/* dm_helpers_is_fullscreen / dm_helpers_is_hdr_on */
+	KUNIT_CASE(dm_test_helpers_is_fullscreen_returns_false),
+	KUNIT_CASE(dm_test_helpers_is_hdr_on_returns_false),
+	/* get_max_frl_rate */
+	KUNIT_CASE(dm_test_get_max_frl_rate_3lanes_3gbps),
+	KUNIT_CASE(dm_test_get_max_frl_rate_3lanes_6gbps),
+	KUNIT_CASE(dm_test_get_max_frl_rate_4lanes_6gbps),
+	KUNIT_CASE(dm_test_get_max_frl_rate_4lanes_8gbps),
+	KUNIT_CASE(dm_test_get_max_frl_rate_4lanes_10gbps),
+	KUNIT_CASE(dm_test_get_max_frl_rate_4lanes_12gbps),
+	KUNIT_CASE(dm_test_get_max_frl_rate_unknown),
+	/* dm_dtn_log_begin / dm_dtn_log_append_v / dm_dtn_log_end */
+	KUNIT_CASE(dm_test_dtn_log_buffer_accumulates),
+	KUNIT_CASE(dm_test_dtn_log_null_ctx_no_crash),
+	/* dm_helpers_dp_read_dpcd / dm_helpers_dp_write_dpcd */
+	KUNIT_CASE(dm_test_dp_read_dpcd_null_priv),
+	KUNIT_CASE(dm_test_dp_write_dpcd_null_priv),
+	/* dm_helpers_dp_mst_start_top_mgr / dm_helpers_dp_mst_stop_top_mgr */
+	KUNIT_CASE(dm_test_mst_start_top_mgr_null_priv),
+	KUNIT_CASE(dm_test_mst_stop_top_mgr_null_priv),
+	KUNIT_CASE(dm_test_mst_start_top_mgr_boot),
+	/* dm_helpers_dp_write_hblank_reduction */
+	KUNIT_CASE(dm_test_dp_write_hblank_reduction_false),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_helpers_test_suite = {
+	.name = "amdgpu_dm_helpers",
+	.test_cases = amdgpu_dm_helpers_test_cases,
+};
+
+kunit_test_suite(amdgpu_dm_helpers_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_helpers");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.43.0

