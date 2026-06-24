Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70521CDB47F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF4110F09B;
	Wed, 24 Jun 2026 18:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fXJnOEY/";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12BC510F096
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:09:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFRHy0pdKztJLBdUaDAfY7uf0jHfrXG0ZQRi0hYpzoS7bCw/lA8kXdtSjW0G/8e+GRj053rs3T88F/xdsCyaPONsyKUR+hWKXoey1ILYojfVaaiSA2tkiAoM1f7cuJ6sfcwgsvdiNUaY4U0qeE4benKiGXTXRR8NUe/tQTeZbcuASR9d/K6fCRh+33/t4FHY6sqhTYazqtpEodXvclVEOh79RGY9UapUSpC3iiupTgROeDwcYeAgVHldhMcQaU/CnN1z6cvGJJr8rpWGjqXCCOPrFwmZQE3xyzxr9Uv4vAqCRzxZIkW+jGptSybADlbRgSWYxGep0F1epy1foc7+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne6XAXBuXpZ+VWd9DABCILhI9zhgLdNu3SgHP1WuSws=;
 b=fpPaLjN6bGEaktRziOYl4o1ixE2eNGMKNCzDbvesGY3n0xfnkwoOnhOeDtfsibNezW/dEafngn4ZPcYXvxm553kzSWaEuMaISOoZ1FegoUrtjEBidRPNUX7io9321Vg8A5NhdsgO3LDFdLbnK8KwlbVgZXQaWDgAEbzh/xZKY7c9RtQqiz/1vvYUqtp+o9IDx03j7xGxczmCLWmId4/TfoMqQWq7FtbIned+pnLDC8vBhrr9clgzo3Y/pkzu164JSmC2XAFNKeTT5q9FWTGO2zbIh9saXAOBLh/KrTCSwJjP1bU9lHHUnh4TQzOG9wLSrEHb41AnMAxWUQca46nCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne6XAXBuXpZ+VWd9DABCILhI9zhgLdNu3SgHP1WuSws=;
 b=fXJnOEY/ZnacOQ+v9D3tzVOR5yGFaoUV2yg8Hg9hYa+gA35v/j0hbhavXCxBOZPKMsEV+pxLGmlk0P9lhiW+1lY/yJw0r5/wUgwSFFrVM1iVsTbawf5xtbYP7XKzYHD+Cbq8stY7G60bWzCb8F3yII4OwZnsbhC6oZTLBxrqF6o=
Received: from SJ0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:33a::15)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 18:09:42 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::a9) by SJ0PR03CA0010.outlook.office365.com
 (2603:10b6:a03:33a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Wed,
 24 Jun 2026 18:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:42 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:33 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 21/28] drm/amd/display: Add KUnit tests for mst_types
Date: Wed, 24 Jun 2026 14:03:19 -0400
Message-ID: <20260624180829.4775-22-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 067840b0-efc4-403a-ab63-08ded21bc3ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: AU5VSfZ9hG/V0GXNKhGoETZQRb3nvUytAkhB/jdLp195fjUlUoA3vgUIQ4sneS6ZnlsQDxaKD0tVZiFpDNeF5XZs/o3QNnChJl/vKFrX5gytoFltzDNqxdF2PpWnu2Jm+9M339RwEltPNjd4++YLrvNAxIRQ5oTfkGQcF8MKYanYg4CexdRUcvrlLUWghKwbYpAKfxjFCQ0UAzMFtoyl43DaQyqNLVyTmjXFczxGqCgyqYReqeuQ0t+D2lEJGhhmB0tlSjDgiKTW4X5sowi26guOPzLZWdAKLIE2bjTTmNH14b8ynQxBscXRWXAWxWGk6KaBO9l8TEB1S9fppo9teuIU5qGs4U4mSE5ueLSBfiJg2n1ZtFKpAD1M0+Oo+tdZT9L23zDSoqeCo8eCG7RB34NiCO7fQvPDnckXHpL4Q4DjI+WD4d3A1hFBGASTAzCeTonEsmGd6yo7NiMqDhC9TZ3ncCq5MB8uh4zCPxra69Yv518XlCJbSoZKznOV+ab+UEe+3sHpkveRyJuk/YlR3llmCOejPbXx1MH3jnFQHEhCko+ANJAG65RZ90iMamVVyCz5KX/zIV8ouwKvljm+TxxbmB53tIsw5PFIksi8AIM+EkZBTjm5GCcwwQJILjtaAVhycB+nte8/CpofmFr4Xbo70RowTADJ5vAqZlQY/bDQtOfMBgXNITKqZ3lZ6APb9+CruvqsI6FZ+H8VqtAXgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 47PiDrjpDV3SEGPTaQrY/GMesEZVjqm5D/WGvuBEI+VIafMldVLBC99a2108qgliWzXBVHVs4xu2Ql7eIYSENvwD724/IQbmInmyWGT9GkkHPkrGHebjiysK28tbVLLAyKJS5UP6IXdqRPNM7oub6CKEhFHDI6z8E1SIWzihYPWTIsV36UKUp/ZEceWKO5SaoFXpYl4ra7hNmBalsjIEHCXzecLqvs2R3UenTYnX80BKFGyMO2ohp14SbAmKbvogebRgDQDwp38VOFyFp2JxC9ST2pnIC7Vu/bxCT7Pq8p/8ruJonbBkj/V0WpZ4r6w4GYCTIw4YVadSQIHEwLp/Pz1ymnZafZM+dl1nxOlI8c4jrL/3SvbDNjA5qPbiTUn9DjBB9y7cJHApP7ZgmKpG/XMfFXm5jwYpjlh8AElgawxF2273DCL+h5P+yiR0H1Am
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:42.4845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 067840b0-efc4-403a-ab63-08ded21bc3ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
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

Add KUnit coverage for the following MST functions:

- dm_dp_aux_transfer(): native read/write, partial write, error
  result remapping, and HPD disconnect quirk via fake DC link service
- dm_dp_aux_transfer_result(): error code translation
- dm_dp_aux_fill_payload_flags(): request flag decoding
- dm_mst_msg_ready_mask(): ESI mask selection
- dm_mst_select_esi_dpcd(): DPCD address/length selection
- dm_mst_atomic_best_encoder(): encoder selection by CRTC ID
- dm_dp_mst_detect(): unregistered connector early return
- dm_dp_mst_atomic_check(): no-old-CRTC early return
- dm_dp_create_fake_mst_encoders(): encoder init and CRTC mask
- dm_handle_mst_sideband_msg_ready_event(): idle no-ready-bits
- retrieve_branch_specific_data(): branch OUI parsing
- retrieve_downstream_port_device(): downstream port present
- needs_dsc_aux_workaround(): DSC workaround matching
- dm_mst_get_pbn_divider(): null link guard
- amdgpu_dm_mst_reset_mst_connector_setting(): field reset
- dm_dp_mst_is_port_support_mode(): FP-off fallback

Assisted-by: Copilot:GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   7 +
 .../tests/amdgpu_dm_mst_types_test.c          | 572 ++++++++++++++++++
 3 files changed, 592 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 83d0e1403e54..0392c71eab63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -99,8 +99,8 @@ EXPORT_IF_KUNIT(dm_dp_aux_fill_payload_flags);
 /*
  * This function handles both native AUX and I2C-Over-AUX transactions.
  */
-static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
-				  struct drm_dp_aux_msg *msg)
+STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
+					    struct drm_dp_aux_msg *msg)
 {
 	ssize_t result = 0;
 	struct aux_payload payload;
@@ -167,6 +167,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 
 	return result;
 }
+EXPORT_IF_KUNIT(dm_dp_aux_transfer);
 
 static void
 dm_dp_mst_connector_destroy(struct drm_connector *connector)
@@ -518,7 +519,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static struct drm_encoder *
+STATIC_IFN_KUNIT struct drm_encoder *
 dm_mst_atomic_best_encoder(struct drm_connector *connector,
 			   struct drm_atomic_state *state)
 {
@@ -529,8 +530,9 @@ dm_mst_atomic_best_encoder(struct drm_connector *connector,
 
 	return &adev->dm.mst_encoders[acrtc->crtc_id].base;
 }
+EXPORT_IF_KUNIT(dm_mst_atomic_best_encoder);
 
-static int
+STATIC_IFN_KUNIT int
 dm_dp_mst_detect(struct drm_connector *connector,
 		 struct drm_modeset_acquire_ctx *ctx, bool force)
 {
@@ -600,9 +602,10 @@ dm_dp_mst_detect(struct drm_connector *connector,
 
 	return connection_status;
 }
+EXPORT_IF_KUNIT(dm_dp_mst_detect);
 
-static int dm_dp_mst_atomic_check(struct drm_connector *connector,
-				  struct drm_atomic_state *state)
+STATIC_IFN_KUNIT int dm_dp_mst_atomic_check(struct drm_connector *connector,
+					    struct drm_atomic_state *state)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct drm_dp_mst_topology_mgr *mst_mgr = &aconnector->mst_root->mst_mgr;
@@ -610,6 +613,7 @@ static int dm_dp_mst_atomic_check(struct drm_connector *connector,
 
 	return drm_dp_atomic_release_time_slots(state, mst_mgr, mst_port);
 }
+EXPORT_IF_KUNIT(dm_dp_mst_atomic_check);
 
 static const struct drm_connector_helper_funcs dm_dp_mst_connector_helper_funcs = {
 	.get_modes = dm_dp_mst_get_modes,
@@ -650,6 +654,7 @@ dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev)
 		drm_encoder_helper_add(encoder, &amdgpu_dm_encoder_helper_funcs);
 	}
 }
+EXPORT_IF_KUNIT(dm_dp_create_fake_mst_encoders);
 
 static struct drm_connector *
 dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
@@ -855,6 +860,7 @@ void dm_handle_mst_sideband_msg_ready_event(
 	if (process_count == max_process_count)
 		DRM_DEBUG_DRIVER("Loop exceeded max iterations\n");
 }
+EXPORT_IF_KUNIT(dm_handle_mst_sideband_msg_ready_event);
 
 static void dm_handle_mst_down_rep_msg_ready(struct drm_dp_mst_topology_mgr *mgr)
 {
@@ -2108,3 +2114,4 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 #endif
 	return DC_OK;
 }
+EXPORT_IF_KUNIT(dm_dp_mst_is_port_support_mode);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 5e5190671923..f0887812ae60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -108,8 +108,15 @@ bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector);
 ssize_t dm_dp_aux_transfer_result(ssize_t result,
 				  enum aux_return_code_type operation_result);
 void dm_dp_aux_fill_payload_flags(u8 request, struct aux_payload *payload);
+ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg);
 u8 dm_mst_msg_ready_mask(enum mst_msg_ready_type msg_rdy_type);
 void dm_mst_select_esi_dpcd(u8 dpcd_rev, int *dpcd_addr, u8 *dpcd_bytes_to_read);
+struct drm_encoder *dm_mst_atomic_best_encoder(struct drm_connector *connector,
+						 struct drm_atomic_state *state);
+int dm_dp_mst_atomic_check(struct drm_connector *connector,
+				   struct drm_atomic_state *state);
+int dm_dp_mst_detect(struct drm_connector *connector,
+			     struct drm_modeset_acquire_ctx *ctx, bool force);
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index e3b171992be1..638e6fa97a11 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -7,6 +7,8 @@
 
 #include <kunit/test.h>
 
+#include <drm/drm_drv.h>
+#include <drm/drm_kunit_helpers.h>
 #include <drm/display/drm_dp.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
@@ -18,12 +20,67 @@
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_mst_types.h"
+#include "inc/link_service.h"
 
 /*
  * Minimal mock DPCD backing store and AUX transfer callback used to exercise
  * the DPCD read paths without real hardware.
  */
 static u8 dm_mst_test_dpcd[0x10];
+static u8 dm_mst_test_desc_dpcd[0x10];
+static struct aux_payload dm_mst_test_last_payload;
+static int dm_mst_test_aux_transfer_raw_result;
+static enum aux_return_code_type dm_mst_test_aux_transfer_raw_operation_result;
+
+static int dm_mst_test_aux_transfer_raw(struct ddc_service *ddc,
+						struct aux_payload *payload,
+						enum aux_return_code_type *operation_result)
+{
+	size_t i;
+
+	dm_mst_test_last_payload = *payload;
+	*operation_result = dm_mst_test_aux_transfer_raw_operation_result;
+
+	if (dm_mst_test_aux_transfer_raw_result)
+		return dm_mst_test_aux_transfer_raw_result;
+
+	if (payload->write)
+		return 0;
+
+	for (i = 0; i < payload->length; i++)
+		payload->data[i] = dm_mst_test_dpcd[(payload->address + i) & 0xf];
+
+	return payload->length;
+}
+
+static void dm_mst_test_setup_dm_aux(struct amdgpu_dm_dp_aux *dm_aux,
+					    struct ddc_service *ddc,
+					    struct dc_link *link,
+					    struct dc *dc,
+					    struct link_service *link_srv,
+					    struct dc_context *ctx,
+					    struct amdgpu_device *adev)
+{
+	memset(&dm_mst_test_last_payload, 0, sizeof(dm_mst_test_last_payload));
+	dm_mst_test_aux_transfer_raw_result = 0;
+	dm_mst_test_aux_transfer_raw_operation_result = AUX_RET_SUCCESS;
+	link_srv->aux_transfer_raw = dm_mst_test_aux_transfer_raw;
+	dc->link_srv = link_srv;
+	link->dc = dc;
+	ctx->driver_context = adev;
+	ddc->link = link;
+	ddc->ctx = ctx;
+	dm_aux->ddc_service = ddc;
+	dm_aux->aux.name = "dm_mst_test_dm_aux";
+	dm_aux->aux.transfer = dm_dp_aux_transfer;
+	drm_dp_aux_init(&dm_aux->aux);
+	drm_dp_dpcd_set_probe(&dm_aux->aux, false);
+}
+
+static const struct dc_link_status *dm_mst_test_get_status(const struct dc_link *link)
+{
+	return &link->link_status;
+}
 
 static ssize_t dm_mst_test_aux_transfer(struct drm_dp_aux *aux,
 					struct drm_dp_aux_msg *msg)
@@ -45,6 +102,21 @@ static ssize_t dm_mst_test_aux_transfer(struct drm_dp_aux *aux,
 	}
 }
 
+static ssize_t dm_mst_test_desc_aux_transfer(struct drm_dp_aux *aux,
+					     struct drm_dp_aux_msg *msg)
+{
+	size_t i;
+
+	if ((msg->request & ~DP_AUX_I2C_MOT) != DP_AUX_NATIVE_READ)
+		return -EINVAL;
+
+	for (i = 0; i < msg->size; i++)
+		((u8 *)msg->buffer)[i] = dm_mst_test_desc_dpcd[msg->address + i - DP_BRANCH_OUI];
+
+	msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+	return msg->size;
+}
+
 /* Tests for needs_dsc_aux_workaround */
 
 /**
@@ -285,6 +357,51 @@ static void dm_mst_test_retrieve_branch_no_parent(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, retrieve_branch_specific_data(aconnector));
 }
 
+/**
+ * dm_mst_test_retrieve_branch_reads_oui - Test branch OUI parsing
+ * @test: KUnit test context
+ *
+ * Verify that retrieve_branch_specific_data() reads the immediate upstream
+ * branch descriptor and caches its IEEE OUI value on the connector.
+ */
+static void dm_mst_test_retrieve_branch_reads_oui(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_topology_mgr *mgr;
+	struct drm_dp_mst_branch *branch;
+	struct drm_dp_mst_port *port;
+	struct drm_dp_aux *aux;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	mgr = kunit_kzalloc(test, sizeof(*mgr), GFP_KERNEL);
+	branch = kunit_kzalloc(test, sizeof(*branch), GFP_KERNEL);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	aux = kunit_kzalloc(test, sizeof(*aux), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, mgr);
+	KUNIT_ASSERT_NOT_NULL(test, branch);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+	KUNIT_ASSERT_NOT_NULL(test, aux);
+
+	memset(dm_mst_test_desc_dpcd, 0, sizeof(dm_mst_test_desc_dpcd));
+	dm_mst_test_desc_dpcd[0] = 0x12;
+	dm_mst_test_desc_dpcd[1] = 0x34;
+	dm_mst_test_desc_dpcd[2] = 0x56;
+
+	aux->name = "dm_mst_test_desc_aux";
+	aux->transfer = dm_mst_test_desc_aux_transfer;
+	drm_dp_aux_init(aux);
+	drm_dp_dpcd_set_probe(aux, false);
+	mgr->aux = aux;
+	port->parent = branch;
+	port->mgr = mgr;
+	port->aux.drm_dev = NULL;
+	aconnector->mst_output_port = port;
+
+	KUNIT_EXPECT_TRUE(test, retrieve_branch_specific_data(aconnector));
+	KUNIT_EXPECT_EQ(test, aconnector->branch_ieee_oui, 0x123456U);
+}
+
 /**
  * dm_mst_test_aux_result_success - AUX_RET_SUCCESS preserves the input result.
  * @test: KUnit test context.
@@ -340,6 +457,246 @@ static void dm_mst_test_aux_result_timeout(struct kunit *test)
 			(ssize_t)-ETIMEDOUT);
 }
 
+/**
+ * dm_mst_test_aux_transfer_native_read - native AUX read through DM callback.
+ * @test: KUnit test context.
+ *
+ * The DM AUX transfer callback should build a read payload, call the DC link
+ * service, and return the number of bytes provided by the fake backend.
+ */
+static void dm_mst_test_aux_transfer_native_read(struct kunit *test)
+{
+	struct amdgpu_dm_dp_aux *dm_aux;
+	struct amdgpu_device *adev;
+	struct ddc_service *ddc;
+	struct dc_link *link;
+	struct dc *dc;
+	struct link_service *link_srv;
+	struct dc_context *ctx;
+	u8 buffer[3] = { 0 };
+	ssize_t ret;
+
+	dm_aux = kunit_kzalloc(test, sizeof(*dm_aux), GFP_KERNEL);
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_aux);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	memset(dm_mst_test_dpcd, 0, sizeof(dm_mst_test_dpcd));
+	dm_mst_test_dpcd[4] = 0xaa;
+	dm_mst_test_dpcd[5] = 0xbb;
+	dm_mst_test_dpcd[6] = 0xcc;
+	dm_mst_test_setup_dm_aux(dm_aux, ddc, link, dc, link_srv, ctx, adev);
+
+	ret = drm_dp_dpcd_read(&dm_aux->aux, 4, buffer, sizeof(buffer));
+
+	KUNIT_EXPECT_EQ(test, ret, (ssize_t)sizeof(buffer));
+	KUNIT_EXPECT_EQ(test, buffer[0], (u8)0xaa);
+	KUNIT_EXPECT_EQ(test, buffer[1], (u8)0xbb);
+	KUNIT_EXPECT_EQ(test, buffer[2], (u8)0xcc);
+	KUNIT_EXPECT_FALSE(test, dm_mst_test_last_payload.write);
+	KUNIT_EXPECT_FALSE(test, dm_mst_test_last_payload.i2c_over_aux);
+	KUNIT_EXPECT_EQ(test, dm_mst_test_last_payload.address, 4U);
+}
+
+/**
+ * dm_mst_test_aux_transfer_native_write - native AUX write through DM callback.
+ * @test: KUnit test context.
+ *
+ * A successful write with an ACK reply should report the requested write size
+ * and pass a write payload into the fake DC link service.
+ */
+static void dm_mst_test_aux_transfer_native_write(struct kunit *test)
+{
+	struct amdgpu_dm_dp_aux *dm_aux;
+	struct amdgpu_device *adev;
+	struct ddc_service *ddc;
+	struct dc_link *link;
+	struct dc *dc;
+	struct link_service *link_srv;
+	struct dc_context *ctx;
+	u8 buffer[2] = { 0x11, 0x22 };
+	ssize_t ret;
+
+	dm_aux = kunit_kzalloc(test, sizeof(*dm_aux), GFP_KERNEL);
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_aux);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dm_mst_test_setup_dm_aux(dm_aux, ddc, link, dc, link_srv, ctx, adev);
+
+	ret = drm_dp_dpcd_write(&dm_aux->aux, 7, buffer, sizeof(buffer));
+
+	KUNIT_EXPECT_EQ(test, ret, (ssize_t)sizeof(buffer));
+	KUNIT_EXPECT_TRUE(test, dm_mst_test_last_payload.write);
+	KUNIT_EXPECT_FALSE(test, dm_mst_test_last_payload.i2c_over_aux);
+	KUNIT_EXPECT_EQ(test, dm_mst_test_last_payload.address, 7U);
+	KUNIT_EXPECT_EQ(test, dm_mst_test_last_payload.length,
+			(u32)sizeof(buffer));
+}
+
+/**
+ * dm_mst_test_aux_transfer_partial_write - partial write reports byte count.
+ * @test: KUnit test context.
+ *
+ * A positive write result from the DC link service should be interpreted as a
+ * partial write and replaced with the first payload byte.
+ */
+static void dm_mst_test_aux_transfer_partial_write(struct kunit *test)
+{
+	struct amdgpu_dm_dp_aux *dm_aux;
+	struct amdgpu_device *adev;
+	struct ddc_service *ddc;
+	struct dc_link *link;
+	struct dc *dc;
+	struct link_service *link_srv;
+	struct dc_context *ctx;
+	u8 buffer[2] = { 1, 0xaa };
+	struct drm_dp_aux_msg msg = {
+		.address = 7,
+		.request = DP_AUX_NATIVE_WRITE,
+		.buffer = buffer,
+		.size = sizeof(buffer),
+	};
+	ssize_t ret;
+
+	dm_aux = kunit_kzalloc(test, sizeof(*dm_aux), GFP_KERNEL);
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_aux);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dm_mst_test_setup_dm_aux(dm_aux, ddc, link, dc, link_srv, ctx, adev);
+	dm_mst_test_aux_transfer_raw_result = 1;
+
+	ret = dm_dp_aux_transfer(&dm_aux->aux, &msg);
+
+	KUNIT_EXPECT_EQ(test, ret, (ssize_t)buffer[0]);
+	KUNIT_EXPECT_TRUE(test, dm_mst_test_last_payload.write);
+	KUNIT_EXPECT_EQ(test, dm_mst_test_last_payload.address, 7U);
+}
+
+/**
+ * dm_mst_test_aux_transfer_error_result - transfer errors are remapped.
+ * @test: KUnit test context.
+ *
+ * A negative DC link service result should be converted through
+ * dm_dp_aux_transfer_result() using the returned AUX operation result.
+ */
+static void dm_mst_test_aux_transfer_error_result(struct kunit *test)
+{
+	struct amdgpu_dm_dp_aux *dm_aux;
+	struct amdgpu_device *adev;
+	struct ddc_service *ddc;
+	struct dc_link *link;
+	struct dc *dc;
+	struct link_service *link_srv;
+	struct dc_context *ctx;
+	u8 buffer[2] = { 0 };
+	ssize_t ret;
+
+	dm_aux = kunit_kzalloc(test, sizeof(*dm_aux), GFP_KERNEL);
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_aux);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dm_mst_test_setup_dm_aux(dm_aux, ddc, link, dc, link_srv, ctx, adev);
+	dm_mst_test_aux_transfer_raw_result = -EIO;
+	dm_mst_test_aux_transfer_raw_operation_result = AUX_RET_ERROR_TIMEOUT;
+
+	ret = drm_dp_dpcd_read(&dm_aux->aux, 4, buffer, sizeof(buffer));
+
+	KUNIT_EXPECT_EQ(test, ret, (ssize_t)-ETIMEDOUT);
+	KUNIT_EXPECT_FALSE(test, dm_mst_test_last_payload.write);
+	KUNIT_EXPECT_EQ(test, dm_mst_test_last_payload.address, 4U);
+}
+
+/**
+ * dm_mst_test_aux_transfer_hpd_discon_quirk - HPD disconnect quirk succeeds.
+ * @test: KUnit test context.
+ *
+ * AUX_RET_ERROR_HPD_DISCON on the sideband down request address should be
+ * treated as a successful transfer when the platform quirk is enabled.
+ */
+static void dm_mst_test_aux_transfer_hpd_discon_quirk(struct kunit *test)
+{
+	struct amdgpu_dm_dp_aux *dm_aux;
+	struct amdgpu_device *adev;
+	struct ddc_service *ddc;
+	struct dc_link *link;
+	struct dc *dc;
+	struct link_service *link_srv;
+	struct dc_context *ctx;
+	u8 buffer[2] = { 2, 0 };
+	ssize_t ret;
+
+	dm_aux = kunit_kzalloc(test, sizeof(*dm_aux), GFP_KERNEL);
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_aux);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dm_mst_test_setup_dm_aux(dm_aux, ddc, link, dc, link_srv, ctx, adev);
+	adev->dm.aux_hpd_discon_quirk = true;
+	dm_mst_test_aux_transfer_raw_result = -EIO;
+	dm_mst_test_aux_transfer_raw_operation_result = AUX_RET_ERROR_HPD_DISCON;
+
+	ret = drm_dp_dpcd_write(&dm_aux->aux, DP_SIDEBAND_MSG_DOWN_REQ_BASE,
+					 buffer, sizeof(buffer));
+
+	KUNIT_EXPECT_EQ(test, ret, (ssize_t)sizeof(buffer));
+	KUNIT_EXPECT_TRUE(test, dm_mst_test_last_payload.write);
+	KUNIT_EXPECT_EQ(test, dm_mst_test_last_payload.address,
+			DP_SIDEBAND_MSG_DOWN_REQ_BASE);
+}
+
 /**
  * dm_mst_test_fill_payload_flags_native_write - native write request decode.
  * @test: KUnit test context.
@@ -463,6 +820,203 @@ static void dm_mst_test_select_esi_dpcd_esi(struct kunit *test)
 			(int)(DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI));
 }
 
+/**
+ * dm_mst_test_sideband_msg_ready_no_ready_bits - Test idle sideband event
+ * @test: KUnit test context
+ *
+ * Verify that dm_handle_mst_sideband_msg_ready_event() returns cleanly when
+ * the ESI read succeeds but no DOWN_REP/UP_REQ ready bits are set.
+ */
+static void dm_mst_test_sideband_msg_ready_no_ready_bits(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct link_service *link_srv;
+	struct dc_link *link;
+	struct dc *dc;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+
+	mutex_init(&aconnector->handle_mst_msg_ready);
+	link_srv->get_status = dm_mst_test_get_status;
+	dc->link_srv = link_srv;
+	link->dc = dc;
+	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
+	link->link_status.dpcd_caps = &link->dpcd_caps;
+	aconnector->dc_link = link;
+	aconnector->dm_dp_aux.aux.name = "dm_mst_test_sideband_aux";
+	aconnector->dm_dp_aux.aux.transfer = dm_mst_test_aux_transfer;
+	drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
+	drm_dp_dpcd_set_probe(&aconnector->dm_dp_aux.aux, false);
+	memset(dm_mst_test_dpcd, 0, sizeof(dm_mst_test_dpcd));
+
+	dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr,
+					       DOWN_REP_MSG_RDY_EVENT);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_dpcd[1], (u8)0);
+}
+
+/**
+ * dm_mst_test_atomic_best_encoder - Test MST encoder selection
+ * @test: KUnit test context
+ *
+ * Verify that dm_mst_atomic_best_encoder() selects the MST encoder indexed by
+ * the CRTC ID in the connector's new atomic state. This uses structural DRM
+ * mocks only; registering connector/CRTC objects is unnecessary for this helper.
+ */
+static void dm_mst_test_atomic_best_encoder(struct kunit *test)
+{
+	struct drm_connector_state connector_state = { 0 };
+	struct drm_atomic_state state = { 0 };
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	unsigned int connector_index = 3;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+
+	aconnector->base.dev = &adev->ddev;
+	aconnector->base.index = connector_index;
+	acrtc->crtc_id = 2;
+	connector_state.connector = &aconnector->base;
+	connector_state.crtc = &acrtc->base;
+	state.num_connector = connector_index + 1;
+	state.connectors = kunit_kzalloc(test,
+					 sizeof(*state.connectors) * state.num_connector,
+					 GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state.connectors);
+	state.connectors[connector_index].ptr = &aconnector->base;
+	state.connectors[connector_index].new_state = &connector_state;
+
+	KUNIT_EXPECT_PTR_EQ(test, dm_mst_atomic_best_encoder(&aconnector->base, &state),
+			     &adev->dm.mst_encoders[2].base);
+}
+
+/**
+ * dm_mst_test_create_fake_mst_encoders - Test fake MST encoder setup
+ * @test: KUnit test context
+ *
+ * Verify that dm_dp_create_fake_mst_encoders() initializes the requested MST
+ * encoders as DPMST encoders with the CRTC mask derived from the device state.
+ */
+static void dm_mst_test_create_fake_mst_encoders(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct device *dev;
+	int i;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*adev),
+						   offsetof(struct amdgpu_device, ddev),
+						   DRIVER_MODESET | DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+	adev = drm_to_adev(drm);
+	adev->dm.display_indexes_num = 3;
+	adev->mode_info.num_crtc = 3;
+
+	dm_dp_create_fake_mst_encoders(adev);
+
+	for (i = 0; i < adev->dm.display_indexes_num; i++) {
+		struct drm_encoder *encoder = &adev->dm.mst_encoders[i].base;
+
+		KUNIT_EXPECT_PTR_EQ(test, encoder->dev, drm);
+		KUNIT_EXPECT_EQ(test, encoder->encoder_type, DRM_MODE_ENCODER_DPMST);
+		KUNIT_EXPECT_EQ(test, encoder->possible_crtcs, 0x7U);
+		KUNIT_EXPECT_TRUE(test, encoder->helper_private != NULL);
+	}
+}
+
+/**
+ * dm_mst_test_atomic_check_no_old_crtc - Test atomic check no-op path
+ * @test: KUnit test context
+ *
+ * Verify that dm_dp_mst_atomic_check() returns success when the MST port's old
+ * connector state has no CRTC, before MST topology state is required.
+ */
+static void dm_mst_test_atomic_check_no_old_crtc(struct kunit *test)
+{
+	struct drm_connector_state old_conn_state = { 0 };
+	struct drm_connector_state new_conn_state = { 0 };
+	struct drm_atomic_state state = { 0 };
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_dm_connector *root;
+	struct drm_dp_mst_port *port;
+	unsigned int connector_index = 2;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	root = kunit_kzalloc(test, sizeof(*root), GFP_KERNEL);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, root);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+
+	aconnector->base.index = connector_index;
+	aconnector->mst_root = root;
+	aconnector->mst_output_port = port;
+	port->connector = &aconnector->base;
+	old_conn_state.connector = &aconnector->base;
+	new_conn_state.connector = &aconnector->base;
+	state.num_connector = connector_index + 1;
+	state.connectors = kunit_kzalloc(test,
+					 sizeof(*state.connectors) * state.num_connector,
+					 GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state.connectors);
+	state.connectors[connector_index].ptr = &aconnector->base;
+	state.connectors[connector_index].old_state = &old_conn_state;
+	state.connectors[connector_index].new_state = &new_conn_state;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_atomic_check(&aconnector->base, &state), 0);
+}
+
+/**
+ * dm_mst_test_detect_unregistered - Test detect skips unregistered connector
+ * @test: KUnit test context
+ *
+ * Verify that dm_dp_mst_detect() returns disconnected for an unregistered
+ * connector before calling into the MST topology helper.
+ */
+static void dm_mst_test_detect_unregistered(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	aconnector->base.registration_state = DRM_CONNECTOR_UNREGISTERED;
+
+	KUNIT_EXPECT_EQ(test,
+			dm_dp_mst_detect(&aconnector->base, NULL, false),
+			(int)connector_status_disconnected);
+}
+
+/**
+ * dm_mst_test_fp_guarded_public_stubs - Test FP-off public fallbacks
+ * @test: KUnit test context
+ *
+ * When CONFIG_DRM_AMD_DC_FP is disabled, the public DSC validation helper
+ * has no FP body and must return DC_OK without touching its arguments.
+ */
+static void dm_mst_test_fp_guarded_public_stubs(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(NULL, NULL),
+			(enum dc_status)DC_OK);
+}
+
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -480,11 +1034,17 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_retrieve_downstream_present),
 	/* retrieve_branch_specific_data tests */
 	KUNIT_CASE(dm_mst_test_retrieve_branch_no_parent),
+	KUNIT_CASE(dm_mst_test_retrieve_branch_reads_oui),
 	/* dm_dp_aux_transfer_result tests */
 	KUNIT_CASE(dm_mst_test_aux_result_success),
 	KUNIT_CASE(dm_mst_test_aux_result_eio),
 	KUNIT_CASE(dm_mst_test_aux_result_ebusy),
 	KUNIT_CASE(dm_mst_test_aux_result_timeout),
+	KUNIT_CASE(dm_mst_test_aux_transfer_native_read),
+	KUNIT_CASE(dm_mst_test_aux_transfer_native_write),
+	KUNIT_CASE(dm_mst_test_aux_transfer_partial_write),
+	KUNIT_CASE(dm_mst_test_aux_transfer_error_result),
+	KUNIT_CASE(dm_mst_test_aux_transfer_hpd_discon_quirk),
 	/* dm_dp_aux_fill_payload_flags tests */
 	KUNIT_CASE(dm_mst_test_fill_payload_flags_native_write),
 	KUNIT_CASE(dm_mst_test_fill_payload_flags_native_read),
@@ -495,6 +1055,18 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	/* dm_mst_select_esi_dpcd tests */
 	KUNIT_CASE(dm_mst_test_select_esi_dpcd_legacy),
 	KUNIT_CASE(dm_mst_test_select_esi_dpcd_esi),
+	/* dm_handle_mst_sideband_msg_ready_event tests */
+	KUNIT_CASE(dm_mst_test_sideband_msg_ready_no_ready_bits),
+	/* dm_mst_atomic_best_encoder tests */
+	KUNIT_CASE(dm_mst_test_atomic_best_encoder),
+	/* dm_dp_create_fake_mst_encoders tests */
+	KUNIT_CASE(dm_mst_test_create_fake_mst_encoders),
+	/* dm_dp_mst_atomic_check tests */
+	KUNIT_CASE(dm_mst_test_atomic_check_no_old_crtc),
+	/* dm_dp_mst_detect tests */
+	KUNIT_CASE(dm_mst_test_detect_unregistered),
+	/* CONFIG_DRM_AMD_DC_FP disabled public paths */
+	KUNIT_CASE(dm_mst_test_fp_guarded_public_stubs),
 	{}
 };
 
-- 
2.53.0

