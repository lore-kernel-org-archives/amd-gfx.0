Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C918FCD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F9C10E892;
	Wed, 10 Jun 2026 09:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QvPyK3+K";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5C7510E895
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0mVUi5lmcnFA4onAcg8E+lNmudSMi1EEZbF7a53bnHlBKrUceRt9oOOoRIx8RvKBapLcmll+VSOL17iu0fOLt+F2R7gzAY032FldX6WhRxC6EmQLylihdK5rOTQdSPGDGHmgkEJXk4dhwoR1cc8t9e2fig/8jmoLgiMajrbAg5nm4s86tcFBMcJQs/TXd1bcAoziSqA7a784/LDLf/W7/u/ybPii+oD4vwotl8/mg0Zyfw1KpzwMbx4Kn2IfxfIRN7c3Iy6gcB4gYIMLKr1pnH6nTYjXsyDEWSqY5RaD8t3KGPuIoJypkzb277C8pC+5w/DLxkaoM2ughIrAa7jHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbX761lJElaDjc6LjjBazZdPwqsPQysjHTMOJOF3O84=;
 b=l4tHkpICi9LDNwpL98zFg+IkOWCMTcfGHlpCbSoVtOA3AZCPiU9YALD8g8ClmA7mrsuxywKTn9i7guaKRegUC030qwxvfm+hrSNWI3DME7lRFhZiHrVY64gVUBQxsDxV6jt6yhKuZ412rDp336OGYN/TYl5iONtG7EOp+8MK9JwphEwugM8dDID2EAh5rAet73n6Bq35ne9kbDturu4ZA3Y9ynR6W1uEGacbBlBG1q41D/3qsWWNiAI6lBtwxMIh0HzikOlFbNqTCJh9htIcrmD7SLCadc3meGFQXw+w7qrHf+PpM1J2VPnf2SjpEeSIUYPxBRcCKClArPWfVYZifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbX761lJElaDjc6LjjBazZdPwqsPQysjHTMOJOF3O84=;
 b=QvPyK3+KAFwGZ8uBmYkoTY7HpeCdQgqQGVt3VTcRrseN6eBijhhx1X7V2teAV4yKuX66fRsz6lWPLgSdMzrbYOAE3g5sEzd7/J/VcSVWuFf+GfyyxkXblwcb2RF6MiAasnvgXA6FrXoG1JeUIucgmaJ52UFmjWnHb7RDLsN8vt8=
Received: from PH7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::27)
 by SA5PPFB1A5CE29A.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8dc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 09:52:16 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::6a) by PH7P222CA0022.outlook.office365.com
 (2603:10b6:510:33a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:52:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:52:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:52:15 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:52:06 -0500
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
Subject: [PATCH 28/32] drm/amd/display: Add more KUnit tests for
 amdgpu_dm_mst_types
Date: Wed, 10 Jun 2026 17:45:12 +0800
Message-ID: <20260610094639.1965367-29-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA5PPFB1A5CE29A:EE_
X-MS-Office365-Filtering-Correlation-Id: f38bfb66-442c-401a-10af-08dec6d5f42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: M5IvHhnA7mI847J8dGMxHZpAFtxlGyMHXdCFA4BlD3eo2iueeXyYDgokDpU35mjgeI1bbDkWLEJogCZ865utsB5yZwhKEc4nVYRhtAL43uN48dfzj90/9ALh8S60hoRO/Hk+o1yL43NIZarbWE0kMs0sHr0G22qxP3gGPx+YlPi/ZXDB7KIm2YGnmYCmUxFwYQvrUnXTsCTJLy+hakSfKHrN6s4uBjLfoCMX/bNULgi10qky85P0YBbH8Kwtq51SYYmPw5oxVnyUnfk0kKu+TeIIHLEK/DsPlAx7/9heLkzqcvSnVfG/qi6fd5Bk8Kojhm/b63LhPOe+aTcKTsWNb3IraCmjIgxrHByfFu3IiHDPupGFC12Z/JLnuOJ62gEmbAyPDpLpMX9mKfyC5hatxpYzHn5AUVkC8ahZ7KcDmRxObig9rYZpjcbRE36fw4nx3tydqwUkQFTQbtlCumJWB6H+qyS78S6/gqVGME0yIthKAuHk42e/8T8PwvhKRUJlflBBUw6vljj61PCLIUrNFFt8EfQN8neC6fldnqFawxVV/cOuyeesvwyzs+8X08DHSrRqnr2fiPitZMSoxDUKXNv1LH5QIeI4LX7xMz7794X3w0XSL5zYPpv3VSEVc3Ajr8nGjcm0K65z0crLaCSCwK6NS4crsUw1Vdx4nFquTaLN5bksiiNbpmpJcYhrWEsuRHCiszg4dC0oa1PAO5xPGHGbSHkygT5sxva41F/7TGU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: udYQNRKylOzkRY9dn5a/GKKeuyaK0rlkUKAvQfjvHvSJnBCzr/BJQXZJ9u6THHX73hR7bnzlOUP0C30qKXKxtzR8w1X/jsI2peQb04gQRs2UfXryyKP2unbQ5YHlKBShLLuy8g1MdfMpKMvJbl13D+zrvSK85IQt/t2Q0vbQNkfEJah8X8bwWQLNbl15TYlB4+/BatWkBNMe3/L9IVfpgwwIC5mRZl/vlEvlxciVUP2pt0pw+GdkhDxOgtEzVKN+NNHRyMn/VwxpotZebTbSTJQ1+CLxpvpr8imQAXpopwLFHfsgGA7ABWV5O7nY+aJnQXXRPGvKFj9uHmWOfX3/hW6PIZ2ZTSqMyBRrQ3ed2MtFUiKM8ALziyjO0b4YJGY2tyz9WhMhaxeNkmii3pUEHPc9N4K79wc8VAuBKD8+j5wCYu9zxpGDkNoWK4EiVKE+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:52:15.9495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f38bfb66-442c-401a-10af-08dec6d5f42d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB1A5CE29A
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

The following existing functions are also exported for the test module:

- needs_dsc_aux_workaround: detect branches needing the DSC AUX workaround
- dm_mst_get_pbn_divider: compute the PBN divider from link bandwidth
- amdgpu_dm_mst_reset_mst_connector_setting: reset per-connector MST state
- retrieve_downstream_port_device: read downstream port presence from DPCD
- retrieve_branch_specific_data: read branch OUI from the upstream device

Several self-contained pieces of logic are extracted from larger functions
into small testable helpers.

- dm_dp_aux_transfer_result: AUX return-code to errno mapping
- dm_dp_aux_fill_payload_flags: AUX request bit decode
- dm_mst_msg_ready_mask: MST sideband ESI mask selection
- dm_mst_select_esi_dpcd: DPCD ESI address/length selection

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 143 ++++---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  12 +
 .../tests/amdgpu_dm_mst_types_test.c          | 385 ++++++++++++++++++
 3 files changed, 491 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 09a6a1deb5db..83d0e1403e54 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -34,6 +34,7 @@
 #include "dm_services.h"
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
+#include "dmub_cmd.h"
 #include "amdgpu_dm_mst_types.h"
 #include "amdgpu_dm_hdcp.h"
 
@@ -44,7 +45,6 @@
 #include "ddc_service_types.h"
 #include "dpcd_defs.h"
 
-#include "dmub_cmd.h"
 #if defined(CONFIG_DEBUG_FS)
 #include "amdgpu_dm_debugfs.h"
 #endif
@@ -53,6 +53,49 @@
 
 #define PEAK_FACTOR_X1000 1006
 
+/*
+ * Translate a failed AUX transaction's operation result into an errno-style
+ * return value. @result is returned unchanged for AUX_RET_SUCCESS.
+ */
+STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer_result(ssize_t result,
+						   enum aux_return_code_type operation_result)
+{
+	switch (operation_result) {
+	case AUX_RET_SUCCESS:
+		break;
+	case AUX_RET_ERROR_HPD_DISCON:
+	case AUX_RET_ERROR_UNKNOWN:
+	case AUX_RET_ERROR_INVALID_OPERATION:
+	case AUX_RET_ERROR_PROTOCOL_ERROR:
+		result = -EIO;
+		break;
+	case AUX_RET_ERROR_INVALID_REPLY:
+	case AUX_RET_ERROR_ENGINE_ACQUIRE:
+		result = -EBUSY;
+		break;
+	case AUX_RET_ERROR_TIMEOUT:
+		result = -ETIMEDOUT;
+		break;
+	}
+
+	return result;
+}
+EXPORT_IF_KUNIT(dm_dp_aux_transfer_result);
+
+/*
+ * Derive the AUX payload transaction flags from a DP AUX request field.
+ */
+STATIC_IFN_KUNIT void dm_dp_aux_fill_payload_flags(u8 request,
+						   struct aux_payload *payload)
+{
+	payload->i2c_over_aux = (request & DP_AUX_NATIVE_WRITE) == 0;
+	payload->write = (request & DP_AUX_I2C_READ) == 0;
+	payload->mot = (request & DP_AUX_I2C_MOT) != 0;
+	payload->write_status_update =
+			(request & DP_AUX_I2C_WRITE_STATUS_UPDATE) != 0;
+}
+EXPORT_IF_KUNIT(dm_dp_aux_fill_payload_flags);
+
 /*
  * This function handles both native AUX and I2C-Over-AUX transactions.
  */
@@ -73,11 +116,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	payload.data = msg->buffer;
 	payload.length = msg->size;
 	payload.reply = &msg->reply;
-	payload.i2c_over_aux = (msg->request & DP_AUX_NATIVE_WRITE) == 0;
-	payload.write = (msg->request & DP_AUX_I2C_READ) == 0;
-	payload.mot = (msg->request & DP_AUX_I2C_MOT) != 0;
-	payload.write_status_update =
-			(msg->request & DP_AUX_I2C_WRITE_STATUS_UPDATE) != 0;
+	dm_dp_aux_fill_payload_flags(msg->request, &payload);
 	payload.defer_delay = 0;
 
 	if (payload.write) {
@@ -117,23 +156,7 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	}
 
 	if (result < 0) {
-		switch (operation_result) {
-		case AUX_RET_SUCCESS:
-			break;
-		case AUX_RET_ERROR_HPD_DISCON:
-		case AUX_RET_ERROR_UNKNOWN:
-		case AUX_RET_ERROR_INVALID_OPERATION:
-		case AUX_RET_ERROR_PROTOCOL_ERROR:
-			result = -EIO;
-			break;
-		case AUX_RET_ERROR_INVALID_REPLY:
-		case AUX_RET_ERROR_ENGINE_ACQUIRE:
-			result = -EBUSY;
-			break;
-		case AUX_RET_ERROR_TIMEOUT:
-			result = -ETIMEDOUT;
-			break;
-		}
+		result = dm_dp_aux_transfer_result(result, operation_result);
 
 		drm_dbg_dp(adev_to_drm(adev), "DP AUX transfer fail:%d\n", operation_result);
 	}
@@ -184,7 +207,7 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 }
 
 
-static inline void
+STATIC_IFN_KUNIT void
 amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector)
 {
 	aconnector->drm_edid = NULL;
@@ -193,6 +216,7 @@ amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector
 	aconnector->mst_local_bw = 0;
 	aconnector->vc_full_pbn = 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_mst_reset_mst_connector_setting);
 
 static void
 amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
@@ -313,7 +337,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 }
 #endif
 
-static bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
 {
 	union dp_downstream_port_present ds_port_present;
 
@@ -331,8 +355,9 @@ static bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnect
 
 	return true;
 }
+EXPORT_IF_KUNIT(retrieve_downstream_port_device);
 
-static bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_dp_mst_port *port = aconnector->mst_output_port;
@@ -359,6 +384,7 @@ static bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector
 
 	return true;
 }
+EXPORT_IF_KUNIT(retrieve_branch_specific_data);
 
 static int dm_dp_mst_get_modes(struct drm_connector *connector)
 {
@@ -708,6 +734,44 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	return connector;
 }
 
+/*
+ * Select the ESI[1] mask used to filter the MST sideband ready bits for a
+ * given message-ready event type.
+ */
+STATIC_IFN_KUNIT u8 dm_mst_msg_ready_mask(enum mst_msg_ready_type msg_rdy_type)
+{
+	switch (msg_rdy_type) {
+	case DOWN_REP_MSG_RDY_EVENT:
+		/* Only handle DOWN_REP_MSG_RDY case*/
+		return DP_DOWN_REP_MSG_RDY;
+	case UP_REQ_MSG_RDY_EVENT:
+		/* Only handle UP_REQ_MSG_RDY case*/
+		return DP_UP_REQ_MSG_RDY;
+	default:
+		/* Handle both cases*/
+		return DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY;
+	}
+}
+EXPORT_IF_KUNIT(dm_mst_msg_ready_mask);
+
+/*
+ * Select the DPCD ESI address and read length based on the DPCD revision.
+ */
+STATIC_IFN_KUNIT void dm_mst_select_esi_dpcd(u8 dpcd_rev, int *dpcd_addr,
+					     u8 *dpcd_bytes_to_read)
+{
+	if (dpcd_rev < 0x12) {
+		*dpcd_bytes_to_read = DP_LANE0_1_STATUS - DP_SINK_COUNT;
+		/* DPCD 0x200 - 0x201 for downstream IRQ */
+		*dpcd_addr = DP_SINK_COUNT;
+	} else {
+		*dpcd_bytes_to_read = DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI;
+		/* DPCD 0x2002 - 0x2005 for downstream IRQ */
+		*dpcd_addr = DP_SINK_COUNT_ESI;
+	}
+}
+EXPORT_IF_KUNIT(dm_mst_select_esi_dpcd);
+
 void dm_handle_mst_sideband_msg_ready_event(
 	struct drm_dp_mst_topology_mgr *mgr,
 	enum mst_msg_ready_type msg_rdy_type)
@@ -726,15 +790,8 @@ void dm_handle_mst_sideband_msg_ready_event(
 
 	const struct dc_link_status *link_status = dc_link_get_status(aconnector->dc_link);
 
-	if (link_status->dpcd_caps->dpcd_rev.raw < 0x12) {
-		dpcd_bytes_to_read = DP_LANE0_1_STATUS - DP_SINK_COUNT;
-		/* DPCD 0x200 - 0x201 for downstream IRQ */
-		dpcd_addr = DP_SINK_COUNT;
-	} else {
-		dpcd_bytes_to_read = DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI;
-		/* DPCD 0x2002 - 0x2005 for downstream IRQ */
-		dpcd_addr = DP_SINK_COUNT_ESI;
-	}
+	dm_mst_select_esi_dpcd(link_status->dpcd_caps->dpcd_rev.raw, &dpcd_addr,
+			       &dpcd_bytes_to_read);
 
 	mutex_lock(&aconnector->handle_mst_msg_ready);
 
@@ -756,20 +813,7 @@ void dm_handle_mst_sideband_msg_ready_event(
 
 		DRM_DEBUG_DRIVER("ESI %02x %02x %02x\n", esi[0], esi[1], esi[2]);
 
-		switch (msg_rdy_type) {
-		case DOWN_REP_MSG_RDY_EVENT:
-			/* Only handle DOWN_REP_MSG_RDY case*/
-			esi[1] &= DP_DOWN_REP_MSG_RDY;
-			break;
-		case UP_REQ_MSG_RDY_EVENT:
-			/* Only handle UP_REQ_MSG_RDY case*/
-			esi[1] &= DP_UP_REQ_MSG_RDY;
-			break;
-		default:
-			/* Handle both cases*/
-			esi[1] &= (DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY);
-			break;
-		}
+		esi[1] &= dm_mst_msg_ready_mask(msg_rdy_type);
 
 		if (!esi[1])
 			break;
@@ -866,6 +910,7 @@ uint32_t dm_mst_get_pbn_divider(struct dc_link *link)
 
 	return dfixed_const(pbn_div_x100) / 100;
 }
+EXPORT_IF_KUNIT(dm_mst_get_pbn_divider);
 
 struct dsc_mst_fairness_params {
 	struct dc_crtc_timing *timing;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 5a7065e53645..5e5190671923 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -60,6 +60,7 @@ enum mst_msg_ready_type {
 struct amdgpu_device;
 struct amdgpu_display_manager;
 struct amdgpu_dm_connector;
+struct aux_payload;
 struct dc_state;
 struct dc_stream_state;
 struct dm_atomic_state;
@@ -100,4 +101,15 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 	struct amdgpu_dm_connector *aconnector,
 	struct dc_stream_state *stream);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+void amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector);
+bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector);
+bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector);
+ssize_t dm_dp_aux_transfer_result(ssize_t result,
+				  enum aux_return_code_type operation_result);
+void dm_dp_aux_fill_payload_flags(u8 request, struct aux_payload *payload);
+u8 dm_mst_msg_ready_mask(enum mst_msg_ready_type msg_rdy_type);
+void dm_mst_select_esi_dpcd(u8 dpcd_rev, int *dpcd_addr, u8 *dpcd_bytes_to_read);
+#endif
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index e21386819ea1..e3b171992be1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -7,10 +7,44 @@
 
 #include <kunit/test.h>
 
+#include <drm/display/drm_dp.h>
+#include <drm/display/drm_dp_helper.h>
+#include <drm/display/drm_dp_mst_helper.h>
+
 #include "dc.h"
 #include "dpcd_defs.h"
+#include "dmub_cmd.h"
+#include "amdgpu.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
 #include "amdgpu_dm_mst_types.h"
 
+/*
+ * Minimal mock DPCD backing store and AUX transfer callback used to exercise
+ * the DPCD read paths without real hardware.
+ */
+static u8 dm_mst_test_dpcd[0x10];
+
+static ssize_t dm_mst_test_aux_transfer(struct drm_dp_aux *aux,
+					struct drm_dp_aux_msg *msg)
+{
+	size_t i;
+
+	switch (msg->request & ~DP_AUX_I2C_MOT) {
+	case DP_AUX_NATIVE_READ:
+		for (i = 0; i < msg->size; i++)
+			((u8 *)msg->buffer)[i] =
+				dm_mst_test_dpcd[(msg->address + i) & 0xf];
+		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+		return msg->size;
+	case DP_AUX_NATIVE_WRITE:
+		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+		return msg->size;
+	default:
+		return -EINVAL;
+	}
+}
+
 /* Tests for needs_dsc_aux_workaround */
 
 /**
@@ -103,6 +137,332 @@ static void dm_mst_test_needs_dsc_aux_workaround_low_sink_count(struct kunit *te
 	KUNIT_EXPECT_FALSE(test, needs_dsc_aux_workaround(&link));
 }
 
+/**
+ * dm_mst_test_needs_dsc_aux_workaround_zero_sink_count - Test workaround skipped for zero sinks
+ * @test: KUnit test context
+ *
+ * Verify that needs_dsc_aux_workaround() returns false when the sink
+ * count is zero, even if device ID and DPCD rev match.
+ */
+static void dm_mst_test_needs_dsc_aux_workaround_zero_sink_count(struct kunit *test)
+{
+	struct dc_link link = {0};
+
+	link.dpcd_caps.branch_dev_id = DP_BRANCH_DEVICE_ID_90CC24;
+	link.dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
+	link.dpcd_caps.sink_count.bits.SINK_COUNT = 0;
+
+	KUNIT_EXPECT_FALSE(test, needs_dsc_aux_workaround(&link));
+}
+
+/* Tests for dm_mst_get_pbn_divider */
+
+/**
+ * dm_mst_test_pbn_divider_null_link - Test pbn_divider with NULL link
+ * @test: KUnit test context
+ *
+ * Verify that dm_mst_get_pbn_divider() returns 0 when passed a NULL
+ * link pointer without crashing.
+ */
+static void dm_mst_test_pbn_divider_null_link(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, dm_mst_get_pbn_divider(NULL), 0U);
+}
+
+/* Tests for amdgpu_dm_mst_reset_mst_connector_setting */
+
+/**
+ * dm_mst_test_reset_connector_setting - Test MST connector setting reset
+ * @test: KUnit test context
+ *
+ * Verify that amdgpu_dm_mst_reset_mst_connector_setting() clears the cached
+ * EDID, DSC AUX, passthrough AUX, local bandwidth, and VC PBN state.
+ */
+static void dm_mst_test_reset_connector_setting(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_port *port;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+
+	aconnector->drm_edid = (const struct drm_edid *)test;
+	aconnector->dsc_aux = (struct drm_dp_aux *)test;
+	aconnector->mst_output_port = port;
+	aconnector->mst_output_port->passthrough_aux = (struct drm_dp_aux *)test;
+	aconnector->mst_local_bw = 12345;
+	aconnector->vc_full_pbn = 678;
+
+	amdgpu_dm_mst_reset_mst_connector_setting(aconnector);
+
+	KUNIT_EXPECT_TRUE(test, aconnector->drm_edid == NULL);
+	KUNIT_EXPECT_TRUE(test, aconnector->dsc_aux == NULL);
+	KUNIT_EXPECT_TRUE(test, aconnector->mst_output_port->passthrough_aux == NULL);
+	KUNIT_EXPECT_EQ(test, aconnector->mst_local_bw, 0U);
+	KUNIT_EXPECT_EQ(test, aconnector->vc_full_pbn, 0U);
+}
+
+/* Tests for retrieve_downstream_port_device */
+
+/**
+ * dm_mst_test_retrieve_downstream_no_aux - Test retrieval bails out without AUX
+ * @test: KUnit test context
+ *
+ * Verify that retrieve_downstream_port_device() returns false when the
+ * connector has no DSC AUX channel and therefore cannot read DPCD.
+ */
+static void dm_mst_test_retrieve_downstream_no_aux(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	aconnector->dsc_aux = NULL;
+
+	KUNIT_EXPECT_FALSE(test, retrieve_downstream_port_device(aconnector));
+}
+
+/**
+ * dm_mst_test_retrieve_downstream_present - Test retrieval parses DPCD 0x05
+ * @test: KUnit test context
+ *
+ * Verify that retrieve_downstream_port_device() reads DP_DOWNSTREAMPORT_PRESENT
+ * over a mock AUX channel and caches the parsed downstream port fields.
+ */
+static void dm_mst_test_retrieve_downstream_present(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_aux *aux;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	aux = kunit_kzalloc(test, sizeof(*aux), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, aux);
+
+	memset(dm_mst_test_dpcd, 0, sizeof(dm_mst_test_dpcd));
+	/* PORT_PRESENT = 1, PORT_TYPE = 2 (0b101) */
+	dm_mst_test_dpcd[DP_DOWNSTREAMPORT_PRESENT] = 0x05;
+
+	aux->name = "dm_mst_test_aux";
+	aux->transfer = dm_mst_test_aux_transfer;
+	drm_dp_aux_init(aux);
+	drm_dp_dpcd_set_probe(aux, false);
+	aconnector->dsc_aux = aux;
+
+	KUNIT_EXPECT_TRUE(test, retrieve_downstream_port_device(aconnector));
+	KUNIT_EXPECT_EQ(test,
+			(int)aconnector->mst_downstream_port_present.fields.PORT_PRESENT, 1);
+	KUNIT_EXPECT_EQ(test,
+			(int)aconnector->mst_downstream_port_present.fields.PORT_TYPE, 2);
+}
+
+/* Tests for retrieve_branch_specific_data */
+
+/**
+ * dm_mst_test_retrieve_branch_no_parent - Test branch lookup needs a parent port
+ * @test: KUnit test context
+ *
+ * Verify that retrieve_branch_specific_data() returns false when the MST
+ * output port has no parent branch device to query.
+ */
+static void dm_mst_test_retrieve_branch_no_parent(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_port *port;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+
+	port->parent = NULL;
+	aconnector->mst_output_port = port;
+
+	KUNIT_EXPECT_FALSE(test, retrieve_branch_specific_data(aconnector));
+}
+
+/**
+ * dm_mst_test_aux_result_success - AUX_RET_SUCCESS preserves the input result.
+ * @test: KUnit test context.
+ *
+ * On success the original (negative) transfer result must be returned unchanged.
+ */
+static void dm_mst_test_aux_result_success(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, dm_dp_aux_transfer_result(-5, AUX_RET_SUCCESS), (ssize_t)-5);
+	KUNIT_EXPECT_EQ(test, dm_dp_aux_transfer_result(3, AUX_RET_SUCCESS), (ssize_t)3);
+}
+
+/**
+ * dm_mst_test_aux_result_eio - HPD/unknown/protocol errors map to -EIO.
+ * @test: KUnit test context.
+ *
+ * AUX_RET_ERROR_HPD_DISCON, AUX_RET_ERROR_UNKNOWN,
+ * AUX_RET_ERROR_INVALID_OPERATION and AUX_RET_ERROR_PROTOCOL_ERROR all map to -EIO.
+ */
+static void dm_mst_test_aux_result_eio(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, dm_dp_aux_transfer_result(-1, AUX_RET_ERROR_HPD_DISCON),
+			(ssize_t)-EIO);
+	KUNIT_EXPECT_EQ(test, dm_dp_aux_transfer_result(-1, AUX_RET_ERROR_UNKNOWN),
+			(ssize_t)-EIO);
+	KUNIT_EXPECT_EQ(test, dm_dp_aux_transfer_result(-1, AUX_RET_ERROR_INVALID_OPERATION),
+			(ssize_t)-EIO);
+	KUNIT_EXPECT_EQ(test, dm_dp_aux_transfer_result(-1, AUX_RET_ERROR_PROTOCOL_ERROR),
+			(ssize_t)-EIO);
+}
+
+/**
+ * dm_mst_test_aux_result_ebusy - invalid reply / engine acquire map to -EBUSY.
+ * @test: KUnit test context.
+ *
+ * AUX_RET_ERROR_INVALID_REPLY and AUX_RET_ERROR_ENGINE_ACQUIRE map to -EBUSY.
+ */
+static void dm_mst_test_aux_result_ebusy(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, dm_dp_aux_transfer_result(-1, AUX_RET_ERROR_INVALID_REPLY),
+			(ssize_t)-EBUSY);
+	KUNIT_EXPECT_EQ(test, dm_dp_aux_transfer_result(-1, AUX_RET_ERROR_ENGINE_ACQUIRE),
+			(ssize_t)-EBUSY);
+}
+
+/**
+ * dm_mst_test_aux_result_timeout - AUX_RET_ERROR_TIMEOUT maps to -ETIMEDOUT.
+ * @test: KUnit test context.
+ */
+static void dm_mst_test_aux_result_timeout(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, dm_dp_aux_transfer_result(-1, AUX_RET_ERROR_TIMEOUT),
+			(ssize_t)-ETIMEDOUT);
+}
+
+/**
+ * dm_mst_test_fill_payload_flags_native_write - native write request decode.
+ * @test: KUnit test context.
+ *
+ * DP_AUX_NATIVE_WRITE clears i2c_over_aux and sets write; no I2C bits set.
+ */
+static void dm_mst_test_fill_payload_flags_native_write(struct kunit *test)
+{
+	struct aux_payload payload = { 0 };
+
+	dm_dp_aux_fill_payload_flags(DP_AUX_NATIVE_WRITE, &payload);
+
+	KUNIT_EXPECT_FALSE(test, payload.i2c_over_aux);
+	KUNIT_EXPECT_TRUE(test, payload.write);
+	KUNIT_EXPECT_FALSE(test, payload.mot);
+	KUNIT_EXPECT_FALSE(test, payload.write_status_update);
+}
+
+/**
+ * dm_mst_test_fill_payload_flags_native_read - native read request decode.
+ * @test: KUnit test context.
+ *
+ * DP_AUX_NATIVE_READ keeps i2c_over_aux clear; the I2C_READ bit clears write.
+ */
+static void dm_mst_test_fill_payload_flags_native_read(struct kunit *test)
+{
+	struct aux_payload payload = { 0 };
+
+	dm_dp_aux_fill_payload_flags(DP_AUX_NATIVE_READ, &payload);
+
+	KUNIT_EXPECT_FALSE(test, payload.i2c_over_aux);
+	KUNIT_EXPECT_FALSE(test, payload.write);
+	KUNIT_EXPECT_FALSE(test, payload.mot);
+}
+
+/**
+ * dm_mst_test_fill_payload_flags_i2c_read_mot - I2C read with MOT request decode.
+ * @test: KUnit test context.
+ *
+ * DP_AUX_I2C_READ sets i2c_over_aux and clears write; DP_AUX_I2C_MOT sets mot.
+ */
+static void dm_mst_test_fill_payload_flags_i2c_read_mot(struct kunit *test)
+{
+	struct aux_payload payload = { 0 };
+
+	dm_dp_aux_fill_payload_flags(DP_AUX_I2C_READ | DP_AUX_I2C_MOT, &payload);
+
+	KUNIT_EXPECT_TRUE(test, payload.i2c_over_aux);
+	KUNIT_EXPECT_FALSE(test, payload.write);
+	KUNIT_EXPECT_TRUE(test, payload.mot);
+}
+
+/**
+ * dm_mst_test_fill_payload_flags_write_status - write status update decode.
+ * @test: KUnit test context.
+ *
+ * DP_AUX_I2C_WRITE_STATUS_UPDATE sets write_status_update.
+ */
+static void dm_mst_test_fill_payload_flags_write_status(struct kunit *test)
+{
+	struct aux_payload payload = { 0 };
+
+	dm_dp_aux_fill_payload_flags(DP_AUX_I2C_WRITE | DP_AUX_I2C_WRITE_STATUS_UPDATE,
+				     &payload);
+
+	KUNIT_EXPECT_TRUE(test, payload.i2c_over_aux);
+	KUNIT_EXPECT_TRUE(test, payload.write_status_update);
+}
+
+/**
+ * dm_mst_test_msg_ready_mask - ESI mask selection per message-ready type.
+ * @test: KUnit test context.
+ *
+ * DOWN_REP and UP_REQ each select their single bit; other types select both.
+ */
+static void dm_mst_test_msg_ready_mask(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, dm_mst_msg_ready_mask(DOWN_REP_MSG_RDY_EVENT),
+			(u8)DP_DOWN_REP_MSG_RDY);
+	KUNIT_EXPECT_EQ(test, dm_mst_msg_ready_mask(UP_REQ_MSG_RDY_EVENT),
+			(u8)DP_UP_REQ_MSG_RDY);
+	KUNIT_EXPECT_EQ(test, dm_mst_msg_ready_mask(DOWN_OR_UP_MSG_RDY_EVENT),
+			(u8)(DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY));
+	KUNIT_EXPECT_EQ(test, dm_mst_msg_ready_mask(NONE_MSG_RDY_EVENT),
+			(u8)(DP_DOWN_REP_MSG_RDY | DP_UP_REQ_MSG_RDY));
+}
+
+/**
+ * dm_mst_test_select_esi_dpcd_legacy - pre-1.2 DPCD ESI address/length.
+ * @test: KUnit test context.
+ *
+ * For DPCD rev < 0x12 the legacy DP_SINK_COUNT address/length pair is selected.
+ */
+static void dm_mst_test_select_esi_dpcd_legacy(struct kunit *test)
+{
+	int dpcd_addr = -1;
+	u8 dpcd_bytes_to_read = 0;
+
+	dm_mst_select_esi_dpcd(0x11, &dpcd_addr, &dpcd_bytes_to_read);
+
+	KUNIT_EXPECT_EQ(test, dpcd_addr, DP_SINK_COUNT);
+	KUNIT_EXPECT_EQ(test, (int)dpcd_bytes_to_read,
+			(int)(DP_LANE0_1_STATUS - DP_SINK_COUNT));
+}
+
+/**
+ * dm_mst_test_select_esi_dpcd_esi - 1.2+ DPCD ESI address/length.
+ * @test: KUnit test context.
+ *
+ * For DPCD rev >= 0x12 the ESI DP_SINK_COUNT_ESI address/length pair is selected.
+ */
+static void dm_mst_test_select_esi_dpcd_esi(struct kunit *test)
+{
+	int dpcd_addr = -1;
+	u8 dpcd_bytes_to_read = 0;
+
+	dm_mst_select_esi_dpcd(0x14, &dpcd_addr, &dpcd_bytes_to_read);
+
+	KUNIT_EXPECT_EQ(test, dpcd_addr, DP_SINK_COUNT_ESI);
+	KUNIT_EXPECT_EQ(test, (int)dpcd_bytes_to_read,
+			(int)(DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI));
+}
+
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -110,6 +470,31 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_wrong_dev_id),
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_wrong_rev),
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_low_sink_count),
+	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_zero_sink_count),
+	/* dm_mst_get_pbn_divider tests */
+	KUNIT_CASE(dm_mst_test_pbn_divider_null_link),
+	/* amdgpu_dm_mst_reset_mst_connector_setting tests */
+	KUNIT_CASE(dm_mst_test_reset_connector_setting),
+	/* retrieve_downstream_port_device tests */
+	KUNIT_CASE(dm_mst_test_retrieve_downstream_no_aux),
+	KUNIT_CASE(dm_mst_test_retrieve_downstream_present),
+	/* retrieve_branch_specific_data tests */
+	KUNIT_CASE(dm_mst_test_retrieve_branch_no_parent),
+	/* dm_dp_aux_transfer_result tests */
+	KUNIT_CASE(dm_mst_test_aux_result_success),
+	KUNIT_CASE(dm_mst_test_aux_result_eio),
+	KUNIT_CASE(dm_mst_test_aux_result_ebusy),
+	KUNIT_CASE(dm_mst_test_aux_result_timeout),
+	/* dm_dp_aux_fill_payload_flags tests */
+	KUNIT_CASE(dm_mst_test_fill_payload_flags_native_write),
+	KUNIT_CASE(dm_mst_test_fill_payload_flags_native_read),
+	KUNIT_CASE(dm_mst_test_fill_payload_flags_i2c_read_mot),
+	KUNIT_CASE(dm_mst_test_fill_payload_flags_write_status),
+	/* dm_mst_msg_ready_mask tests */
+	KUNIT_CASE(dm_mst_test_msg_ready_mask),
+	/* dm_mst_select_esi_dpcd tests */
+	KUNIT_CASE(dm_mst_test_select_esi_dpcd_legacy),
+	KUNIT_CASE(dm_mst_test_select_esi_dpcd_esi),
 	{}
 };
 
-- 
2.43.0

