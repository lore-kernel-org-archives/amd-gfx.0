Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CED7C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671A010F409;
	Fri, 21 Aug 2026 19:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3gpIBj7b";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012058.outbound.protection.outlook.com
 [40.93.195.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 751EA10F409
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:40:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQ1ePllBTHj3fD08NB8L7fbepP+7L9eOlSMc66/F14adl32MVbUN4iu1ZLmD4huS4vih2gCv8DXJYQ8jGTV7e8L3/HbnGk4CylxS38wXv+AjJBe6bO7ee4hCe5JD9jcQKZkEz6XxhXxCh/eP7O+aWkdoAescKdDtsKOtNg+Kwn3z2ThddsiJgZmEUCZxak984NIEbsjEhpq1f/0dVg0tlYD6vAJg77AbYuQW1X0rRmCmPV8Dsgh9D5Ts9UVoYF/ehF8Zc6ijQvyYW2OzjZt5rP3pU7z7o/8YYBU+mJFCVV8e49vvuy1+B2PllIE8PcQAOAsYqpnqFwG95xIOZQ6/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMk4WjfZ/zX/ghWp9w14DR/4NzODA5lm2sw0oQJ4E08=;
 b=Uh24mcR46Ygj/4UH5zj/92Q9xWWK9Qku868HEPq9njq36b6Y7VHtwklDYWLiNMSAiUu49g/qg/UTMCmIlZ1JGxLhaKmvHXyOqjV5HpMqUxkjo29MsBQ/nQGrn3VT89amWjjlqr0g5O9tp0Qd/D4G+8krwrpskI1h5AxY2XL1QtMphLs0rnIEm3v9BRTaLlX6vrMNtdO4SDmgsEphPq9NR/4w3/ZQB2o4LRLuEulJRsG+m+Llow6UeHnhNtCi/KHOnuS06U4ZY1X6Q+1cTljmOo4zqCWCTuSW9UcqZCss2b0L19fKKXk3cd43aEwPUEVStbxMcu8AaJ1WTrgbkw+H+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMk4WjfZ/zX/ghWp9w14DR/4NzODA5lm2sw0oQJ4E08=;
 b=3gpIBj7bla7Z4kI7H0JOQdnhX2V7/LnJTkf+mdnYyD13htju5YvJm+MtkO9VEYqfU9dmvc40SKMvSm8f7o3YUtLV2Oiu/tjZGKK1WrV7RbT/SElVwM/nLtQZ1ewwZhm6YVeCCFjqdnHN3QD5MnoW3+hVcU+yDosPkNNevmdzGdU=
Received: from CH5PR02CA0015.namprd02.prod.outlook.com (2603:10b6:610:1ed::9)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:36:06 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::30) by CH5PR02CA0015.outlook.office365.com
 (2603:10b6:610:1ed::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 83/95] drm/amdgpu: Use uniform logic for inband/sideband
Date: Fri, 21 Aug 2026 15:34:46 -0400
Message-ID: <20260821193458.808626-84-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 493dd179-85d0-4d10-d805-08deffbb71aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|10067099003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X9pLRgbNjfL9BCRbriDk2YlGfMidJ1ypVsIFS9Y6iG5RXTF16kyd62N/bRu+77w8T6KZFESBN/GdvmuyazPyW+I84rCvVCI6cSMswRpqfI5llM7kyzJJnGiwpGLgAI5/3AE0K4cz0rQNlYKysLPYD8vtlfTZf6EqGGJSN30IH1y5LzDt20OKnEnCna4sxILXe54VIKc+tw2Xa6tF0hPJD3NqMhzrIAEd3TnFrHZzy3PQR4FXGPPk8RKdvXLghLl2SkiEDxg6bH/+MhuI3vaz7xOq6rK8OlzK/S9hGr2F2y645G+PUZkNZkTN7F5s2/05atPcIqz5HnLlcwVAyA/xldyA9EMS/AKaV462YvwIKtWRJjN+/Cp9yilXePFGJhD64twy+aRpD5Ty+irVnbuJA0Frb3gu3hFu5YImqV7ZBqqlP+3I1Cx7ezQcL6ffHUERT4kq+NQJ71vRQm2VsKURd5dacQkdFNydO6De0qEtL00MeK8R1wDeM+uL1jYzrKbmCvMD04aYXEiU0ykCa26iDPOV9ontHxo3WFROPQlwEKGL/yZ9kwqQcK8b5aNy8r9t2E1bwYZYTk7lS77CeCQyBsvAB2l7KWI9M5XyO6sJuRb9sVRcyxXwt62VYnZ4amsknpJvC007An0dcbf88oeWuMB8iwn+bFmtMSLdNz6wrdWwFRSsjbt/uzmVw4qN7Mt9gmY9RQC8cbCWC9mN3WLOnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2uHmE33P+06JoBsKtsYvoFZitdWB9iFTL4I0c46qsXitsp1fN3R1vAGDYezJ/soy02j5ErLzTC4b/UZLXTw1MsIy9yjttKKCge7TeBMDYtGw1DaWpHu5x28Jp5yPQFeCla/UKkIMj2kNPwxZKZSGqMZnvW+k4cWMl9tB/AYNwrEjCfvUCEdP4UXtJkwSFABpyd0WY9GIypLKQ4T9r0Zzwvx5RxXlzs1zC7juZ8Ik30rbE2mQaCiSppmRiu14lFRcWoyezl3R7FJ4ixJesdNGpOkx0wcg/xU3p/2xHteXoimob8FHj4lD034kAjt/d2iRphW/ifX9gox9qVViTM3gJIjdOHH21bsMcqFGAWSiOG57W8xXTySlGZSR1pkYduLpiG9DsNQRHrNQ7DHwrC9FLOr2BOJp3PB+SBStS/n63Y+J/se2b5Z4bl43Yb6yBypt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:06.3640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493dd179-85d0-4d10-d805-08deffbb71aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515
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
index 7573ed19693e1..a70327383f5a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -238,37 +238,10 @@ static int amdgpu_ualink_update_vpod_config(struct amdgpu_device *adev)
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
@@ -300,11 +273,50 @@ int amdgpu_ualink_config_update_handler(struct amdgpu_device *adev)
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
@@ -793,8 +805,9 @@ static ssize_t ualink_ppod_setup_commit_store(struct kobject *kobj,
 	mutex_lock(&mgpu_info.mutex);
 	if (info->accel_state >= AMDGPU_UALINK_ACCEL_STATE_READY)
 		deactivate_accelerator(adev);
-
 	info->accel_state = check_ppod_state(adev, setup);
+	/* PPOD is expected to be configured first */
+	info->vpod.id = AMDGPU_UALINK_VPOD_ID_INVALID;
 	mutex_unlock(&mgpu_info.mutex);
 
 	/* TODO: If accel_state was ACTIVE, reset all connections */
@@ -1086,6 +1099,8 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(info->kobj.parent);
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	enum amdgpu_ualink_accel_state prev_state;
+	u32 prev_vpod_id;
 	int r;
 
 	if (!sysfs_streq(buf, "true"))
@@ -1095,6 +1110,8 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 		return -EINVAL;
 	}
 
+	prev_state = info->accel_state;
+	prev_vpod_id = info->vpod.id;
 	r = psp_ual_set_vpod_config(&adev->psp, adev->ualink.psp_if_ver,
 				    config);
 	if (r)
@@ -1103,30 +1120,21 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
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
@@ -1244,9 +1252,6 @@ static ssize_t ualink_station_config_commit_store(struct kobject *kobj,
 		return -EINVAL;
 
 	r = psp_ual_set_station_config(&adev->psp, adev->ualink.psp_if_ver, stations);
-	if (r)
-		return r;
-	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info, NULL);
 	if (r)
 		return r;
 
-- 
2.55.0

