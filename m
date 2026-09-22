Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48CEC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 14:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7338B10E3FA;
	Tue, 22 Sep 2026 14:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZY7/+t1t";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B8710E3FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 14:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrsTFRtedfXIWwFr6BDiuHflN44bcIhpwsym8509T3jNDlE1kuoH8dzK/YcXzglf3l6yYdj36/TcBNiXXcAlCoM3sohgnmGm5zKquFVjuc4NO1fgAWFCZHIFW3NvGrURtexJmHPFsUrEqcfJqn0YPBrHpWpB8gi29pj/OGwmyqUappKJQAu0S9des0Rn81GeNpcrC4PuTXw0BYHFNhtRikkLY1ye1CZBo/85kC2SqsOD60aUoLRHQjJavwkuozHi/YFJc5mV+Zvz4VR0x69iSJyY5+S0SylmI5sByvC4W0bF0faai50aBewn3IFBYbLEMK03kQ8GEukaeFdu/5xq8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbgN/5hS7NQmQOM7PjTzLxQ2HMx8XjCy5aUkRp1GoVk=;
 b=RmpUtT/OaTmmmgF6UzgFjZWFEQ5Ix9aHbud85yVdq0ty9kLzUsyJKbOGTHQwyk1bB7VJCrGKg6skezIz2pnhRXEJaCI5hiRNeGFAE/nZfACxtBanIOlCHHAaimNgMAjvORW7UFkaETuwLtqtVCdyQPCGbbprFaNJUq6DzuZbSQKXapaeLnQ4uTT8E06Yyc52wybaP5KPafRPrFCAPIaM4lPh3i8mf/FQDJaioqAL4R5ApJJ8PHt6btBaoxOryxTe7835TS1L2xLJFe9TCUaydbindrxmxlX8woLhe+TmeBRPl4nRrM7HYu1X9EIbksoO5qFjoWgSwEJ0P6AmMPHH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbgN/5hS7NQmQOM7PjTzLxQ2HMx8XjCy5aUkRp1GoVk=;
 b=ZY7/+t1tRi0G2MFRhNCpbeJDCtb5Ok4QUybk1wg8V1ISJK+EFS4GbFrzPZyEOpRKysgd/xB8KwbwIVix6+x5rdfmAvU8IrCYcR6ENdjZ+spjYsjLFK5lsdvYpFEkErWA/11dBUrJ9PsR2ZQe6Up/V1HGZQyBMz2oJ3U7u1yPLd4=
Received: from CY5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:930:1e::20)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 14:57:08 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:930:1e:cafe::37) by CY5PR04CA0029.outlook.office365.com
 (2603:10b6:930:1e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 14:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 14:57:07 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 09:57:05 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Sashiko-bot
 <sashiko-bot@kernel.org>
Subject: [PATCH 3/3] drm/amdgpu: Fix race on ualink_handle_lo in UALink handle
 export
Date: Tue, 22 Sep 2026 10:56:53 -0400
Message-ID: <20260922145653.1207241-3-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922145653.1207241-1-mukul.joshi@amd.com>
References: <20260922145653.1207241-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: acb552a7-f58c-4e44-ba73-08df18b9c5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|30052699003|1800799024|82310400026|36860700016|23010399003|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pd7Duj59FBpARciYlkdyjvc/py7BKu8PPUPKnavSpRtd3wDPNFRuL3RA0JiGt4g5n+UaO/rORgC2CJpG1koSu4bM43ESYCwsvauk71B9E8J4dcoLHN+a+wq3s2nNlurt19WIraUA4+B/if87Rl+CwEZh23I2X5szfLplJYc/1Eio0CKwEPDOPQdoAecZb8V4fA5ihj6McAD04swsR9VdGE146AMn2zJlEEcNXeueGo8PBMPwwvZKKN6Jyz3ciC7cDSCDOxCxan2JIzIWx2NfBP5R5h+sjZ32DwkiWhSc1ywI1QMD5HPLCClQej5668l8SM56vOHGL8Bt70zPT9hG2x5xTC1oeA/pxiatewwKICW6h9tXU8WGIfVFIfkHvR17wl5enV/kvf3LEHJ6a5AhNYqJkuCn0fMtHVSfrmVK1KvGgQ86GWtWyiZjq0tgDVikBpQth34oQ/uLVrnN7YNmJBjUa9hDJNMy1mqL4XBSjAyPuWTwsxcyIb7qDknpb5FwsoOJdDGW71FRmxvRQCAb/p2c1MI8VJn74N2QXC//iaL+9gP8DhvrZWsj9p9NPnM7aSU4aKw94BucRw+ABG8W7vMZmG4oUWx9qHoBnDczL4DjqHb1OXmElRFrPP11AI1UV5/upSP+tLBvuRrlkM6XF01c9zOPYePfLxIgNHX7ftLoqJejw7qKReESb15UuPhx7c9FUjMrlaXRFPM8g0qc5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(30052699003)(1800799024)(82310400026)(36860700016)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TAr6Y2hWYnmOAxNeajgUNR1eK4i2BigAmK4w6euda6PFg9rauRRIZqYZrlHCEIH3AzR7ZJeI5OKud6TJ3dpyXIwBB8jaK41YcMSqkOA/WNPnTElSBbu9LAHv2EQux0EzGZvn47ezStghI6abRdYwIfBvGO9ekZsfTOdVwiurRX7dQxSHKgkTxs5IIWPTlOmN/9ldbE6fDimI4ctfmb0ebbU+o8QZmFZRb+xpVBAkEHQNqEG7QVkD8iK5OmY3m1XrYBjSQMzW2TKqSdk0ynwAgVb57MAuycAYPR04lgf5AHDQ/szvhWcsOGgVrS2W2tIIBRxIU9RIGOZ9xRcS/4Ac5+67+2redD+AhkhloOgK2TRTSnXLZ/5JVWYAVZWgYjDlLp1iaGGvcpvFpYP7LqpyLgIXl0nFCOhfbEfQS1roDYe/OsYgPvMpYf9l36uNSKsD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:57:07.7588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb552a7-f58c-4e44-ba73-08df18b9c5f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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

amdgpu_ualink_export_handle() tests robj->ualink_handle_lo and stores
the generated handle into it without any lock; xa_lock only covers
handle generation and the xarray insert.

Two threads can therefore both observe a zero handle for the same BO and
both allocate an exporter node, take an amdgpu_bo_ref() and insert into
exp_xa, with the last store to ualink_handle_lo winning. Teardown only
erases the handle recorded in the BO, so the losing node keeps its BO
reference and pinned VRAM until device teardown.

Serialize the check-generate-store sequence on a new per-device mutex.
The BO reservation lock cannot be used, since
drm_gem_prime_handle_to_dmabuf() reserves the BO itself via
ttm_bo_setup_export().

Fixes: 6b1a5ad90778 ("drm/amdgpu: Implement UALink handle export")
Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  5 +++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index a7ae9ffde1b5..32443bdfc594 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3991,6 +3991,8 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 		goto out;
 	}
 
+	mutex_lock(&adev->ualink.exp_lock);
+
 	if (!robj->ualink_handle_lo) {
 		/* If no ualink handle generated for BO, then generate one and
 		 * add it to the exporter Xarray.
@@ -3999,7 +4001,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 		if (!exp_xa_node) {
 			dev_err(adev->dev, "Failed to allocate exp_xa_node\n");
 			r = -ENOMEM;
-			goto out;
+			goto unlock;
 		}
 
 		amdgpu_bo_ref(robj);
@@ -4025,7 +4027,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 			dev_err(adev->dev, "Failed to generate DMABuf for the BO\n");
 			amdgpu_bo_unref(&robj);
 			kfree(exp_xa_node);
-			goto out;
+			goto unlock;
 		}
 
 		xa_lock(&adev->ualink.exp_xa);
@@ -4039,7 +4041,7 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 			dma_buf_put(exp_xa_node->dmabuf);
 			amdgpu_bo_unref(&robj);
 			kfree(exp_xa_node);
-			goto out;
+			goto unlock;
 		}
 
 		robj->ualink_handle_lo = handle.handle_lo;
@@ -4059,6 +4061,8 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 			handle_out->handle_hi = exp_xa_node->handle.handle_hi;
 	}
 
+unlock:
+	mutex_unlock(&adev->ualink.exp_lock);
 out:
 	drm_gem_object_put(gobj);
 	return r;
@@ -4139,6 +4143,7 @@ int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 	adev->mmhub.funcs->setup_vm_pt_regs(adev, adev->vm_manager.npa_vmid,
 			amdgpu_gmc_pd_addr(adev->ualink.npa_vm.root.bo));
 
+	mutex_init(&adev->ualink.exp_lock);
 	xa_init(&adev->ualink.exp_xa);
 	xa_init(&adev->ualink.imp_xa);
 	xa_init(&adev->ualink.handle_invalid_xa);
@@ -4272,6 +4277,7 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 	xa_destroy(&adev->ualink.exp_xa);
 	xa_destroy(&adev->ualink.imp_xa);
 	xa_destroy(&adev->ualink.handle_invalid_xa);
+	mutex_destroy(&adev->ualink.exp_lock);
 
 	for (i = 0; i < AMDGPU_UALINK_ACCEL_MAX; i++)
 		mutex_destroy(&adev->ualink.conn_state[i].lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 85c9a9634a4b..2a6be8b9d5b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -336,6 +336,11 @@ struct amdgpu_ualink_mgr {
 	/* handle irq from ualink client of remote GPUs */
 	struct amdgpu_irq_src irq;
 
+	/* Serializes handle allocation in amdgpu_ualink_export_handle() so
+	 * that a BO gets at most one exporter xarray node.
+	 */
+	struct mutex	exp_lock;
+
 	/* Xarray to store info about exported BOs */
 	struct xarray	exp_xa;
 
-- 
2.55.0

