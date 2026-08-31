Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4985C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8667510EAAA;
	Mon, 31 Aug 2026 18:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W7Ea45g8";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010044.outbound.protection.outlook.com
 [52.101.193.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D09310EA89
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSGz7Zml5d0Mb5Jh5CPlql4DQ9aQuDIDn95PRFh35lG1gcx6fm9WxW8qOhxTrT52q9BEwgGuZOHHqHVgnr+8eh896VBcu/4CkrWONzoMuhYa6v1l6aKUVio2GcYjQ5hPA+/TTO+jnNNW1h6hKDSVhQk1mxAeRXg2sIozebUTqktYGe43TNc0a5wgD90/1b2JZiAmQbQmWMS/RQZeUEsyczTYREQA4NOViYQohNxgaBZSfzNdLA/D2KrCABBNMnvn6n7WwZop9pIcTeWYKN2TG8SyAbqPtvT1rzKneo086nga1CxmFrPSRU/i0GIAX/txjJKKlNGexiXD8YNQZnhzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUKEVojzc3Lj+l6StXxY3UV3AUt5Vk/vP57HoGEuPBY=;
 b=pOanR5Ek0b5h3mU8n04N8S5Ko/yep5tyFmLSUsOHl+ZvLD+XxsXYsbOHluVxieB4oHKqfvkQsrFmWShUGb5Boz9Ny0IskqAkyL0i8xEtm2/QrGtlHT/T6viCm5rGx9bzdGu/pfulPUXx09s8lHSOC0Lfmz9tF6gXtlLpeev6wTl4QfRBH+QA2MAS1Z+E5qBXwp449fm+e777G/nIFVOUgUkOojhdWNmhxDhetkkZsMZxwID1MVKkkBBt2boXdYc3ILMRN0VRJrkcDbrB/PYNf6im+ml/98efS8JvVGyKYmvp6UZ73BAwjsPBWFUJh8+ziy/FLWRsii+rtc+pZDsaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUKEVojzc3Lj+l6StXxY3UV3AUt5Vk/vP57HoGEuPBY=;
 b=W7Ea45g81uGqTSN6/QV8fsPSdX1vhBPt3pDGNvoMomRXCJmoEc79R9hWzDFayievaVZApK9aljlnHJGIseA3ObuswQCh4CYWpAOrCaBLKsQ8eS0jakdEsroDtFFU8bSLL9BWXKui3BpzUgypekv08fw4CxeAeZpiy+ROPLXF30M=
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by EAYPR12MB999131.namprd12.prod.outlook.com (2603:10b6:303:2be::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:17 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::7c) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 82/95] drm/amdgpu: Improve ualink state transitions
Date: Mon, 31 Aug 2026 14:27:41 -0400
Message-ID: <20260831182754.1089811-83-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|EAYPR12MB999131:EE_
X-MS-Office365-Filtering-Correlation-Id: 1470a064-d167-4440-6b1b-08df078dc40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NGVaUkLK861BRh+fbJ6Qt9BheM+rUl5cpw+pn8uGxBTUv+f9uAzXEXe3YbDKKscVtz7ff82mVDLA4Dok7a6miQzhM2lEERQ4lDJaH/ZhbBbf2wMHCsQNTSYgLoYw2diIOO1AdX4moBDbMVGe45MnWPr2+xl6R5pazHtgqFpLfwcjVKD/yHvVc/Mznsq69SYPwB1dkY4yRoWw+5uv+/OYOpDamET0/WH4FvKKrelpZuLWMc4y5iTK9ksRqnvWI0Y4U4TTaRHHlFgPrRW6NfYr4lXaNMkWb5VyB9YWTkPBt4t6Zx54cHXAfk99O6QxZu0nBnK7nFfFKIbnGcDkH5sBX+oAYr1Qnoh4fD3Gnf78dUFngDKwB7YQYSbO/QzMQhvvOuoPnppyKNAkyNTIzx+9gKs4dBR6Iz4GSQ7aNb7D/Ccq994QWzDYqY2Nh7YdQzhgWijqtaYxdr4LPrv50S/xgOxOwgQoxYJNw2TS9lFCYzClkCv4B8jFsVkPriiGFxSuYIilgFJqL/Qf7S99bwhzD99WV2r3YF4sqhcJYdA7JRCxS/pAIsvFeMT2dpIeWDKPYg5bkZeTosybLIPQQBIX9etlHoNJe3y+RZlOMw9xDTUl6PbrFkk/w5ZaXMOasL8+sQJasA38TIePYNdIVcBfmtsNelWELRvZD+o7AWA4QBpHPlXLDwWjs8yXrRpBhqAb4IOTESbu/RxEjo0SUs+n/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m1l14DQax+C83fiuTTtHcZ29hHZRBaPSs+mFxQCBN8Mpxa3lKpDW3taHLhHV7QzqQSk7cCNwg1M8iqFfwpevVEm62S2z5poIkcVlK1hdiP+XzJa7ns+ZvXRJPO9T7P31h8WwvrHpEsNYMYwOmDIwUJeRDZ1xOd0kWNwncv26XkplqT21uPG6G97iUjB++WZHxviSPoaui7WPzP6ijRTEypznll6N5IMCjHKGKLec1zUbAmCQMKEbgFtr23qIiQaNUKoeh7ST10dDaNEIrQyo1CVVE9WIzOEYzFjbO3QF12rXxil0vY+p99DNZmJmPRxnmP+zi6OUIAe2p+NrncXjPig1oBvEOr5inoRv7wwo3ggTmd8XbE5AHRL+9NOy8IYY+6m/Hmu0iOyykhBb45tm8IOr6f/nQJ4UnTsC2+8tYxvc2OV3Hj0P86FLhhnKP7P/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:17.0390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1470a064-d167-4440-6b1b-08df078dc40c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999131
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

From: Lijo Lazar <lijo.lazar@amd.com>

Keep state transitions under lock. Validate the ppod/vpod config or both
based on the state passed by ASP. When a config update is received, if
the GPU is already active on a vpod, local vpod gpu integrity check is
skipped to keep minimal disruption. A gpu removed from the vpod will get
the new vpod id as 0. A GPU is not expected to transition directly from a
valid/nonzero vpod id to another valid vpod id. It needs to be removed
from the existing vpod first.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 199 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |   3 +
 2 files changed, 148 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index de79b2ea1f99a..8604a87f48bfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -34,7 +34,7 @@
 #include <linux/sysfs.h>
 #include <linux/string.h>
 
-static void amdgpu_ualink_activate_vpod(struct amdgpu_device *adev);
+static void deactivate_accelerator(struct amdgpu_device *adev);
 static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 				u32 remote_accel_id, u32 dw0, u32 dw1,
 				u32 dw2, u32 dw3);
@@ -53,6 +53,7 @@ static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo);
 static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 					  u32 remote_accel_id, u64 addr,
 					  u32 size_in_pages, u32 flush_type);
+static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -156,78 +157,166 @@ amdgpu_ualink_info_set_accel_state(struct amdgpu_device *adev,
 				   struct amdgpu_ualink_info *info,
 				   enum psp_gfx_ual_config_state cfg_state)
 {
+	enum amdgpu_ualink_accel_state cur = info->accel_state;
+	enum amdgpu_ualink_accel_state target;
+	bool ppod_validated;
+	bool vpod_validated;
+
 	if (!info)
 		return;
 
+	ppod_validated = cur >= AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED &&
+			 cur <= AMDGPU_UALINK_ACCEL_STATE_ACTIVE;
+	vpod_validated = cur >= AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED &&
+			 cur <= AMDGPU_UALINK_ACCEL_STATE_ACTIVE;
+
 	switch (cfg_state) {
 	case UAL_CFG_IDLE:
-		break;
+		return;
 	case UAL_CFG_PPOD:
-		if (!__check_ppod_info(adev, info)) {
-			info->accel_state =
-				AMDGPU_UALINK_ACCEL_STATE_UNCONFIGURED;
-			break;
-		}
-		info->accel_state = AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED;
+		target = AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED;
 		break;
 	case UAL_CFG_VPOD:
 	case UAL_CFG_STATION:
-		if (!__check_vpod_info(adev, info)) {
-			info->accel_state = AMDGPU_UALINK_ACCEL_STATE_ERROR;
-			dev_err(adev->dev,
-				"vpod configuration is invalid, setting to error state");
-			break;
-		}
-		info->accel_state = AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED;
+		target = AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED;
 		break;
 	case UAL_CFG_COMPLETE:
-		info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
+		target = AMDGPU_UALINK_ACCEL_STATE_READY;
 		break;
 	default:
 		dev_dbg(adev->dev, "invalid configuration state %u", cfg_state);
-		break;
+		return;
 	}
-}
 
-static int amdgpu_ualink_query_info(struct amdgpu_device *adev)
-{
-	enum psp_gfx_ual_config_state cfg_state;
-	int r;
+	/* ppod stage: should be part of a ppod first */
+	if (!ppod_validated && !__check_ppod_info(adev, info)) {
+		if (target == AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED) {
+			info->accel_state =
+				AMDGPU_UALINK_ACCEL_STATE_UNCONFIGURED;
+		} else {
+			info->accel_state = AMDGPU_UALINK_ACCEL_STATE_ERROR;
+			dev_err(adev->dev,
+				"ppod configuration is invalid, setting to error state");
+		}
+		return;
+	}
+	if (target == AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED) {
+		if (!ppod_validated)
+			info->accel_state =
+				AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED;
+		return;
+	}
 
-	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
-			       adev->ualink.info, &cfg_state);
-	if (r)
-		return r;
+	/* A vpod_id of 0 means the GPU is not part of any vPod */
+	if (info->vpod.id == AMDGPU_UALINK_VPOD_ID_INVALID) {
+		info->accel_state = AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED;
+		return;
+	}
 
-	amdgpu_ualink_info_set_accel_state(adev, adev->ualink.info, cfg_state);
+	/* vpod stage: required to reach vpod_configured or ready */
+	if (!vpod_validated && !__check_vpod_info(adev, info)) {
+		info->accel_state = AMDGPU_UALINK_ACCEL_STATE_ERROR;
+		dev_err(adev->dev,
+			"vpod configuration is invalid, setting to error state");
+		return;
+	}
+	if (target == AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED) {
+		if (!vpod_validated)
+			info->accel_state =
+				AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED;
+		return;
+	}
+
+	/* complete stage: advance to ready unless already ready/active */
+	if (cur < AMDGPU_UALINK_ACCEL_STATE_READY ||
+	    cur > AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
+		info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
+}
 
+static int amdgpu_ualink_update_vpod_config(struct amdgpu_device *adev)
+{
+	/* TBD: Do updates/cleanup based on updated vpod configuration */
 	return 0;
 }
 
 int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
 {
-	int r;
-	u32 status = 0;
+	enum amdgpu_ualink_accel_state prev_state;
+	enum psp_gfx_ual_config_state cfg_state;
+	u32 prev_vpod_id;
+	int r, qerr;
 
 	/* TBD: Stop ASP interrupts if driver faced an issue */
 	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE) {
+		u32 status;
+
 		dev_dbg(adev->dev,
 			"UALink not initialized, skipping config update\n");
 		status = !!(adev->ualink.mgr_state == AMDGPU_UALINK_INIT_ERROR);
-		goto out;
+		return psp_ual_send_completion(
+			&adev->psp, adev->ualink.psp_if_ver,
+			PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID, status);
 	}
 
+	prev_state = adev->ualink.info->accel_state;
+	prev_vpod_id = adev->ualink.info->vpod.id;
+
+	qerr = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
+				  adev->ualink.info, &cfg_state);
+
 	/*TBD: find the right value of status to be sent to ASP*/
-	r = amdgpu_ualink_query_info(adev);
-	if (r) {
-		dev_info(adev->dev, "UALink config update failed %d\n", r);
-		status = 1;
+	r = psp_ual_send_completion(&adev->psp, adev->ualink.psp_if_ver,
+				    PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID, 0);
+	if (r || qerr)
+		goto err;
+
+	/* If the device is already active and its vpod_id is unchanged, the
+	 * update does not affect vpod membership. Skip the local vpod
+	 * integrity check and re-activation.
+	 */
+	if (prev_state == AMDGPU_UALINK_ACCEL_STATE_ACTIVE &&
+	    adev->ualink.info->vpod.id == prev_vpod_id) {
+		amdgpu_ualink_update_vpod_config(adev);
+		return 0;
 	}
 
-out:
-	return psp_ual_send_completion(&adev->psp, adev->ualink.psp_if_ver,
-				       PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID,
-				       status);
+	/* A new vpod_id of 0 means this GPU was removed from the vPod. */
+	if (adev->ualink.info->vpod.id == AMDGPU_UALINK_VPOD_ID_INVALID) {
+		amdgpu_ualink_update_vpod_config(adev);
+		scoped_guard(mutex, &mgpu_info.mutex)
+			deactivate_accelerator(adev);
+		return 0;
+	}
+
+	/* GPU joining a new vpod should be with invalid vpod id*/
+	scoped_guard(mutex, &mgpu_info.mutex) {
+		if (prev_vpod_id == AMDGPU_UALINK_VPOD_ID_INVALID) {
+			amdgpu_ualink_info_set_accel_state(
+				adev, adev->ualink.info, cfg_state);
+			__amdgpu_ualink_activate_vpod_locked(adev);
+		} else {
+			/* GPU should first get removal which will set invalid vpod_id
+			* and then join a new vpod
+			*/
+			dev_err(adev->dev,
+				"Invalid vpod transition from %u to %u\n",
+				prev_vpod_id, adev->ualink.info->vpod.id);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	scoped_guard(mutex, &mgpu_info.mutex) {
+		deactivate_accelerator(adev);
+		adev->ualink.info->accel_state =
+			AMDGPU_UALINK_ACCEL_STATE_ERROR;
+	}
+	dev_err(adev->dev,
+		"UALink config update failed, setting to error state");
+
+	return r;
 }
 
 int amdgpu_ualink_pause_handler(struct amdgpu_device *adev)
@@ -280,9 +369,6 @@ int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 	r = psp_ual_get_interface_version(&adev->psp, &adev->ualink.psp_if_ver);
 	if (r) {
 		adev->ualink.psp_if_ver = 0xffffffff;
-		dev_info(adev->dev,
-			 "UALink disabled, PSP interface version detection failed: %d\n",
-			 r);
 		goto disable;
 	}
 	dev_info(adev->dev, "Found UALink interface version 0x%x\n",
@@ -299,16 +385,22 @@ int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	enum psp_gfx_ual_config_state cfg_state;
 	int r;
 
 	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_HW)
 		return 0;
 
-	r = amdgpu_ualink_query_info(adev);
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
+			       adev->ualink.info, &cfg_state);
 	if (r)
 		return r;
 
-	amdgpu_ualink_activate_vpod(adev);
+	scoped_guard(mutex, &mgpu_info.mutex) {
+		amdgpu_ualink_info_set_accel_state(adev, adev->ualink.info,
+						   cfg_state);
+		__amdgpu_ualink_activate_vpod_locked(adev);
+	}
 
 	r = amdgpu_ualink_drm_client_create(adev);
 	if (r) {
@@ -661,8 +753,6 @@ static const struct kobj_type ualink_info_ktype = {
 };
 
 #ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
-static void deactivate_accelerator(struct amdgpu_device *adev);
-
 UALINK_VALUE_SHOW(ppod_setup, accel_id,  ppod.accel_id,  "%u");
 UALINK_VALUE_SHOW(ppod_setup, bandwidth, ppod.bandwidth, "%u");
 UALINK_VALUE_SHOW(ppod_setup, latency,   ppod.latency,   "%u");
@@ -831,7 +921,6 @@ static void activate_accelerator(struct amdgpu_device *adev)
 	adev->ualink.info->accel_state = AMDGPU_UALINK_ACCEL_STATE_ACTIVE;
 }
 
-#ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
 static void deactivate_accelerator(struct amdgpu_device *adev)
 {
 	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
@@ -847,7 +936,6 @@ static void deactivate_accelerator(struct amdgpu_device *adev)
 	amdgpu_ualink_sw_fini(adev);
 	amdgpu_ualink_manager_stop(adev);
 }
-#endif
 
 static void activate_local_vpod(struct amdgpu_device *adev)
 {
@@ -982,22 +1070,24 @@ static int __check_local_vpod_integrity(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void amdgpu_ualink_activate_vpod(struct amdgpu_device *adev)
+static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev)
 {
 	int ret;
 
-	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_READY)
+	if (adev->ualink.info->accel_state <
+		    AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED ||
+	    adev->ualink.info->accel_state ==
+		    AMDGPU_UALINK_ACCEL_STATE_ERROR)
 		return;
-	mutex_lock(&mgpu_info.mutex);
+
 	ret = __check_local_vpod_integrity(adev);
 	if (ret && ret != -EAGAIN) {
-		dev_err(adev->dev, "Local vpod integrity check failed: %d\n",
-			ret);
+		dev_err(adev->dev,
+			"Local vpod integrity check failed: %d\n", ret);
 		return;
 	}
 	if (!ret)
 		activate_local_vpod(adev);
-	mutex_unlock(&mgpu_info.mutex);
 }
 
 #ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
@@ -1242,7 +1332,7 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	info->ppod.accel_id = 0xffffffff;
 	info->ppod.bandwidth = 0xffffffff;
 	info->ppod.latency = 0xffffffff;
-	info->vpod.id = 0xffffffff;
+	info->vpod.id = AMDGPU_UALINK_VPOD_ID_INVALID;
 	info->vpod.addr_mode = AMDGPU_UALINK_ADDR_MODE_MAX;
 
 	/*
@@ -5684,3 +5774,4 @@ int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev)
 			      UALINK_IH_SOURCE_ID, &adev->ualink.irq);
 	return r;
 }
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index ce8b643811dfa..e23aaf8b313e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -35,6 +35,9 @@ struct amdgpu_device;
 #define AMDGPU_UALINK_LOCAL_ACCELS_MAX 8
 #define AMDGPU_UALINK_STATIONS_MAX 64
 
+/* A vpod_id of 0 is reserved and treated as invalid/no vPod */
+#define AMDGPU_UALINK_VPOD_ID_INVALID 0
+
 /* nHT firmware status */
 #define AMDGPU_NHT_FW_ST_PREINIT	0xA0
 #define AMDGPU_NHT_FW_ST_READY	0xA1
-- 
2.55.0

