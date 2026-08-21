Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A50C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CEA10F420;
	Fri, 21 Aug 2026 19:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SZ2oBLZh";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41A5F10F41A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYYj6ZhDL5dUTTy7QkMxsRGDs5P8EZedM5dgOUzjKkXMoASwNk4Aucd6EViugXIa5hxXvZcaBsdet3UZ4v/P+WQfFViUKkDt17FtJ0ql49I+k54jikK6hadgz45BE+OSuWopqs6G44N5eFI5p2M80t6JGledQ99kjgbOAP9eX0+qHRzphDodlX9s1UHXJLGBC67bftig+yRC/ENmWHR3OgBzyji8Qs5p3/uKvyhAptKg7boQpQSIKu3y2XVkeCEL2rrTfCJqz9KiTKgLw4uhuegEm6CWRQX5baV/v64LcjPuAGK/1gp/RhywAy54r9IsGZ3eNvcjRSSj2qpJrxJ6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7roP/QK5oN1d5Ji8D7rdDW73i3Aq1vagUMajeGUihQ=;
 b=kYanUE3JjeAvqiK+P50Dc9YnQMpGHNZnBS3GqGRBKMOTgmCKfut2JvHOkpG9SfC+ijcnQq7yv8tE7ymOMCkzF1fluLlDEQAfMV5HYNOqJpqKn7tZgH9DiDlokQYos7MAEbQ8+VGgbGzBatYYa24TJu7rM4HGVANffMyWBOzTUxh9RefXiMECz9xTaYf+vsooeCeGLxh2OxGXU6sBwVcqEQLPlyFdb8ESJqiCxmWTjv+ft29zk4BMOVR5A/NYq6GSKEXOQ38ceoh+KqyBhPnAYzGUJbMczfAICIwniOxzpIWjUCS4xNcLyzEAL3hF3ifAAGm4UzlMRYEoc6eMwtcNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7roP/QK5oN1d5Ji8D7rdDW73i3Aq1vagUMajeGUihQ=;
 b=SZ2oBLZh2/wWucLG1dFU0Xh8ECa0lb42R4FHiV8JROWcHlwxWlzKVJr18qeS8pnF042wT/MJQPbx+wIOBih0JlQDQhvDacuLoCNEcoOSni7cTebJJht/tgg3VKjeU5SqAQJXM+wiPLVMznCYKuhqliM7XhQxXxzutxGp+HKJNM0=
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by IA1PR12MB8406.namprd12.prod.outlook.com (2603:10b6:208:3da::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:36:07 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::26) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:36:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 82/95] drm/amdgpu: Improve ualink state transitions
Date: Fri, 21 Aug 2026 15:34:45 -0400
Message-ID: <20260821193458.808626-83-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|IA1PR12MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3089f8-cc97-43f3-f588-08deffbb7212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yavSPnuMNolEzS816jHwCXqH8d33G9etaIcX3lunZ0bXs8t0g6kND0slCAa/PXbWPPcYV2CV9u4+KguZWM291saow0B6kIyHj096/uqjCN0HGj+7XQA9ikydkPYelmLuDZIo00dZcu8YSgdDJfpNmBGn8Jj0vF6y57G+w7Dv0C8an6BOiv4q7iZ8YH9PuUHifB9t4zFlRbKzLuk1wRn354CCl8UzPqiYCs8wws2RpcCETtrBr0iZ3Sgyju0lUnnMChQO+nUpvHXP0RWa+oLtDCPJQNFAbJmvP9Kt7BEF/qAEixXWV7HQiXdZL6Nxco7DedAssSRvrjuOzRRJN4ZEjpZXlQwUIQ91jWoG8MepkeQ260f/HyTbfekEOD2+hcxSR/8D3zb2PANonxfxDcOCHAF5kD2Jw6W3Q670/5mJwg3LK5RaBMcECrGJkU+XiQaalp6g5iKN92zquBIEJINsupjmCebDXFKjC0Wjeo3+3Jvm60kcpPscsR7jWDSQ/4198nLO45y2781upC9yWFr++K+uegSbElbvNQjWgBajAiDfVlM0+oXIHoPH7WnAKKjWzj69JUpbgLtaALmOOAHDTcHsclVcOkWCKxTWhGrTvBiREyuzkqRwhOie5tUeJHRtlnj4qG2CRSvO7/68kqdvqcxcUTYEv5afPuMtH7Jo5a8Z3BcEqss2BHuFAi3ncv4Dm4oWe3lRSaO0TvMSAQ4Tbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WA7wl+QTXE3xoci8trq3X1yIhLp0R4i/0o2F4vj/q63qQ57QC2FfFaT8q7pu0YgWZHBNXpMRyF78QBCs8Jk2vEEpYUVFrGI1ME/FTlrwl6BfCcqleGKNFaSs7NjrPugxVzThoNsu5SDFRJy5zFNAM7gmlfWxDUw5Rw/O8E5DgzUFl39Y3IjI4/NUAvbuC9JmCgd4WKaWz17eftD9uYVkNBuxFvIinOBCiQfe73tghToAB4ET/rWzB5WGGYXiuqDa/mR8wVZn/m29OUWo1q8ztHO3QBiNL00Z0Er+UFzcalht/6pVOL8nZhJcP461QtXc62aw+7W59bFv4KOYFg8FGaca0puAVcCjuUqduLUYd9lPU7K8vnAah+EG5pGUU8MjcgfAgcFZ1HeEVRd+MKqfMP+eDHbcEoeajnv8ECfunCL2te8QmmvTu1UFJPNj8EQs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:07.0465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3089f8-cc97-43f3-f588-08deffbb7212
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8406
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 194 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |   3 +
 2 files changed, 147 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8b3aff3dc31f0..7573ed19693e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -34,7 +34,6 @@
 #include <linux/string.h>
 
 static void deactivate_accelerator(struct amdgpu_device *adev);
-static void amdgpu_ualink_activate_vpod(struct amdgpu_device *adev);
 static int amdgpu_ualink_remote_interrupt(struct amdgpu_device *adev,
 				u32 remote_accel_id, u32 dw0, u32 dw1,
 				u32 dw2, u32 dw3);
@@ -53,6 +52,7 @@ static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo);
 static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 					  u32 remote_accel_id, u64 addr,
 					  u32 size_in_pages, u32 flush_type);
+static void __amdgpu_ualink_activate_vpod_locked(struct amdgpu_device *adev);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -156,78 +156,166 @@ amdgpu_ualink_info_set_accel_state(struct amdgpu_device *adev,
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
 
+	/* complete stage: advance to ready unless already ready/active */
+	if (cur < AMDGPU_UALINK_ACCEL_STATE_READY ||
+	    cur > AMDGPU_UALINK_ACCEL_STATE_ACTIVE)
+		info->accel_state = AMDGPU_UALINK_ACCEL_STATE_READY;
+}
+
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
@@ -280,9 +368,6 @@ int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 	r = psp_ual_get_interface_version(&adev->psp, &adev->ualink.psp_if_ver);
 	if (r) {
 		adev->ualink.psp_if_ver = 0xffffffff;
-		dev_info(adev->dev,
-			 "UALink disabled, PSP interface version detection failed: %d\n",
-			 r);
 		goto disable;
 	}
 	dev_info(adev->dev, "Found UALink interface version 0x%x\n",
@@ -299,16 +384,22 @@ int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
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
@@ -966,22 +1057,24 @@ static int __check_local_vpod_integrity(struct amdgpu_device *adev)
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
 
 static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
@@ -1211,7 +1304,7 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	info->ppod.accel_id = 0xffffffff;
 	info->ppod.bandwidth = 0xffffffff;
 	info->ppod.latency = 0xffffffff;
-	info->vpod.id = 0xffffffff;
+	info->vpod.id = AMDGPU_UALINK_VPOD_ID_INVALID;
 	info->vpod.addr_mode = AMDGPU_UALINK_ADDR_MODE_MAX;
 
 	/*
@@ -5633,3 +5726,4 @@ int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev)
 			      UALINK_IH_SOURCE_ID, &adev->ualink.irq);
 	return r;
 }
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index d7bde8ab77d77..97fe263a481db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -31,6 +31,9 @@
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

