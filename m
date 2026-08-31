Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8B2C624D4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C785310EA7C;
	Mon, 31 Aug 2026 18:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HDKnSSQN";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EDAE10EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGgo2CRxRufWqYuhwr32/cenitUbj9j82wfv+KT+JtRvL9Wk07AFUt8kc+pKXN4kFS93EPgtJATFKni8H/sCfIdGcvGb0c58IiTW0fbD6SdHIch68Yx7spMz6VvlrfLKVMMqC0wlpqqIRWIevr/37Rhyu7/4gSH7WyuOV0Wazz3MjWYm04r5eOFxogG+In1Y79cjpi7LEFeVX1GtOxhkQa9YdgwrtjL1CrhFF/9z5nsmZY6uvZ2A6JgYWM7O2CRtH6Na76pCej5l316USvJTWjY/BWjuOKR3YPKfkvfH83oHl7gaUY1VErvPi/+6Z2JAiqp70gyjChSv8eM5zZI+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0aqru4YQvGVf3BRzY16Zm6EK9y5mhrJKW+r8v8rado=;
 b=QIY+1H8jKYvE2gfU571RzuMkYCwOgwY/pcQ6SPOyu5g1RsVKNqbL/0zIK3KG18w0W5hVdyNMidq8umD7WB5OSJPmB4kyMBSbKatWNoFoR6kQjh+cvTMfYT9R72ZrK64l41sSTb+uVNTU2id0bMCnEtD4fFje2UAnIET6cK5UIlblDiTp+5f/rqig8saWf7MfdMTz7CxDzI5Rw++jPkLnNQ/bOwkAfhPOR6WBCOckAispVVBCxHlQXfVV+Zu3ktX6AgPYVkXFRR6PKhH2CFn5p+HNiBCyTOLZfcJoU3whWwL3/ucQtv2TB5XeOBMYplfewTC16K5gZoNWrohQ5lKCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0aqru4YQvGVf3BRzY16Zm6EK9y5mhrJKW+r8v8rado=;
 b=HDKnSSQNBdBYSMG50LCyIzmyI6qvSr8+PWfnXz7c2fpSeJzUkO/8hY15Nvi3LXc5pD/tJjXJWriLYogbdPUYsxuBpvux/sjAvk63Vas9xeT+p4sn+knWKkJwD5qzsOoWf0Nlcewbj7h9YEU1neU1CzDrtQMqVMh2N1XZ+gLyfeA=
Received: from BN9PR03CA0679.namprd03.prod.outlook.com (2603:10b6:408:10e::24)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:09 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::64) by BN9PR03CA0679.outlook.office365.com
 (2603:10b6:408:10e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:09 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 83/95] drm/amdgpu: Use uniform logic for inband/sideband
Date: Mon, 31 Aug 2026 14:27:42 -0400
Message-ID: <20260831182754.1089811-84-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c6a113-24f7-4fbe-1cac-08df078dbf5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: bdnZmmxDzFplxs1gf6p0oFDlbzXvezEW2RmBST7FAbBnLJH5knBgvOMhfh2Pz5LctIbPhG2LQaqCCGYko5KzF+ttUXh1UDQQnqxY9b5jQWo8chJEyHbMXcNIiCYUga1ewavMe9XKQqyo+BqDIsm9T2YNwb2OsuELGTcaAmfgdq8SjZqxZTXONptgqYhL8L5VDTKuIsR9tKyN/I0kfamYNEw3kOcMIf2o/e7R5E1KDFs5lN5c25VU18MC8dqGfqwTS58SI7FErQkvlxpbzzqRlXd6ew8ZorhtROhTOjqKRF/aacsdIm2Wru2PhdQvjVJimEnhvRdci7JTw+AhvWOBt8gopmLu0TGFNCRP/WymutMNJZjuypHHgeH9yWPpYbmw0JQu9uyhfn20rg6ATuHdgn87lySC+QY+85tzr8MUBTXLMthBbCsx4qtWJce0EcPXon/hWjVFwbS8sfG0KLU1NMMkXScS55xfbA5EetPYNcNIWf9KrEbR3vuumUCueC0B2Bgv8pBDE3nDUpQ2lLeuh53x1AWXlET6Bx6yvCIZSPK1bAIs4lmW9lLYp80kNKxclClVSkqSj7vlXwmSiCKUFLP7HHfuTLy+nKtWBqYq8IlztgWBQxE206FO/EPp69UN/SuYGT0YR++TnhvLwOimdAaq5IWSz1Qr32zryVyIxddCUBeleWHwhiQecGXgriHhEimEs2x7n5c2FcrU1UUyfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bDFslotCXshzMF4JtGivuBWzHk2/bZH7qMW8vlY+xg7Bx1mjHLOoAug0fw3+pPw4luwLeXqKDsr3nfU9tOSqlo9KG4gwVA6tQ4ghMkvwCjGTKIMimf0hmdzC9k9AwosS+V2/aerj/bSB9swYoj8UcIinkJ8AczZMpGQCYoEM3Yc8NHX83PXb/lJnzjrBR6LZgejjZ1IlWiGiWGo/bBGXh1uBNSfh8YTltOAwfo7fmnSirLyD1TFGGFfwVQRZGTCfZJpBP+UF2MPzqvaJKBkAuIYm8SbOkIwuhAWA9dvI81hVxti3ETNTRWKKK0MKSTd+e0dT1LO0hjJ+LTgkhNgDkNP6YowfIqr/ga8DiNmp93JJkhnRVAq9FgqLUSMZPsrIvxgVbUGThSfUiKw2bEZZTx+YH1yuEQOvUK+uxEzrO6yJHflzcV1YhAdKxWd3icQX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:09.1750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c6a113-24f7-4fbe-1cac-08df078dbf5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076
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

For updating the vpod configuration, use similar logic in both sideband
and inband paths.

In inband path, force the vpod id as invalid when ppod configuration is
done. Remove the redundant query call after station configuration as it
station configuration doesn't affect vpod configuration.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 109 +++++++++++----------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8604a87f48bfa..73aa9e98202b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -239,37 +239,10 @@ static int amdgpu_ualink_update_vpod_config(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
+static int amdgpu_ualink_update_accel_state(
+	struct amdgpu_device *adev, enum amdgpu_ualink_accel_state prev_state,
+	u32 prev_vpod_id, enum psp_gfx_ual_config_state cfg_state)
 {
-	enum amdgpu_ualink_accel_state prev_state;
-	enum psp_gfx_ual_config_state cfg_state;
-	u32 prev_vpod_id;
-	int r, qerr;
-
-	/* TBD: Stop ASP interrupts if driver faced an issue */
-	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE) {
-		u32 status;
-
-		dev_dbg(adev->dev,
-			"UALink not initialized, skipping config update\n");
-		status = !!(adev->ualink.mgr_state == AMDGPU_UALINK_INIT_ERROR);
-		return psp_ual_send_completion(
-			&adev->psp, adev->ualink.psp_if_ver,
-			PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID, status);
-	}
-
-	prev_state = adev->ualink.info->accel_state;
-	prev_vpod_id = adev->ualink.info->vpod.id;
-
-	qerr = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
-				  adev->ualink.info, &cfg_state);
-
-	/*TBD: find the right value of status to be sent to ASP*/
-	r = psp_ual_send_completion(&adev->psp, adev->ualink.psp_if_ver,
-				    PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID, 0);
-	if (r || qerr)
-		goto err;
-
 	/* If the device is already active and its vpod_id is unchanged, the
 	 * update does not affect vpod membership. Skip the local vpod
 	 * integrity check and re-activation.
@@ -301,11 +274,50 @@ int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
 			dev_err(adev->dev,
 				"Invalid vpod transition from %u to %u\n",
 				prev_vpod_id, adev->ualink.info->vpod.id);
-			goto err;
+			return -EINVAL;
 		}
 	}
 
 	return 0;
+}
+
+int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
+{
+	enum amdgpu_ualink_accel_state prev_state;
+	enum psp_gfx_ual_config_state cfg_state;
+	u32 prev_vpod_id;
+	int r, qerr;
+
+	/* TBD: Stop ASP interrupts if driver faced an issue */
+	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_COMPLETE) {
+		u32 status;
+
+		dev_dbg(adev->dev,
+			"UALink not initialized, skipping config update\n");
+		status = !!(adev->ualink.mgr_state == AMDGPU_UALINK_INIT_ERROR);
+		return psp_ual_send_completion(
+			&adev->psp, adev->ualink.psp_if_ver,
+			PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID, status);
+	}
+
+	prev_state = adev->ualink.info->accel_state;
+	prev_vpod_id = adev->ualink.info->vpod.id;
+
+	qerr = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
+				  adev->ualink.info, &cfg_state);
+
+	/*TBD: find the right value of status to be sent to ASP*/
+	r = psp_ual_send_completion(&adev->psp, adev->ualink.psp_if_ver,
+				    PSP_GFX_INT_CTXT_UAL_CMD_CFG_UPDATE_ID, 0);
+	if (r || qerr)
+		goto err;
+
+	r = amdgpu_ualink_update_accel_state(adev, prev_state, prev_vpod_id,
+					     cfg_state);
+	if (r)
+		goto err;
+
+	return 0;
 
 err:
 	scoped_guard(mutex, &mgpu_info.mutex) {
@@ -816,8 +828,9 @@ static ssize_t ualink_ppod_setup_commit_store(struct kobject *kobj,
 	mutex_lock(&mgpu_info.mutex);
 	if (info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_READY)
 		deactivate_accelerator(adev);
-
 	info->accel_state = check_ppod_state(adev, setup);
+	/* PPOD is expected to be configured first */
+	info->vpod.id = AMDGPU_UALINK_VPOD_ID_INVALID;
 	mutex_unlock(&mgpu_info.mutex);
 
 	/* TODO: If accel_state was ACTIVE, reset all connections */
@@ -1111,6 +1124,8 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(info->kobj.parent);
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	enum amdgpu_ualink_accel_state prev_state;
+	u32 prev_vpod_id;
 	int r;
 
 	if (!sysfs_streq(buf, "true"))
@@ -1120,6 +1135,8 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 		return -EINVAL;
 	}
 
+	prev_state = info->accel_state;
+	prev_vpod_id = info->vpod.id;
 	r = psp_ual_set_vpod_config(&adev->psp, adev->ualink.psp_if_ver,
 				    config);
 	if (r)
@@ -1128,30 +1145,21 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 	if (r)
 		return r;
 
-	if (!__check_vpod_info(adev, info))
+	if (info->vpod.id != AMDGPU_UALINK_VPOD_ID_INVALID &&
+	    !__check_vpod_info(adev, info))
 		return -EINVAL;
 	/* The integrity check makes sure each new GPU is consistent with the
 	 * other GPUs already in the vPod. All known local GPUs can become
 	 * "ready" at the same time.
 	 *
 	 * Misconfiguration of one GPU does not reduce the state of other GPUs
-	 * already in the vPod.
-	 */
-	mutex_lock(&mgpu_info.mutex);
-	r = __check_local_vpod_integrity(adev);
-	if (!r)
-		activate_local_vpod(adev);
-	else if (info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED)
-		deactivate_accelerator(adev);
-	mutex_unlock(&mgpu_info.mutex);
-
-	/* TODO: Update KFD topology for in-domain link */
-
-	/* TODO: If state was ACTIVE:
-	 * - If addr_mode changed, reset all connections, reset state to READY
-	 * - If accelerators were removed, reset those links, but keep state ACTIVE
-	 * - If accelerators were added, keep state ACTIVE
+	 * already in the vPod. GPU is intentionally not put to ERROR state if
+	 * misconfiguration occurs.
 	 */
+	r = amdgpu_ualink_update_accel_state(adev, prev_state, prev_vpod_id,
+					     UAL_CFG_VPOD);
+	if (r)
+		return r;
 
 	return count;
 }
@@ -1271,9 +1279,6 @@ static ssize_t ualink_station_config_commit_store(struct kobject *kobj,
 		return -EINVAL;
 
 	r = psp_ual_set_station_config(&adev->psp, adev->ualink.psp_if_ver, stations);
-	if (r)
-		return r;
-	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info, NULL);
 	if (r)
 		return r;
 
-- 
2.55.0

