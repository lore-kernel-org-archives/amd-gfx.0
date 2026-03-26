Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E481A106F2E7
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8073F10E2CE;
	Thu, 26 Mar 2026 07:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JvpQIHrk";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9269610E99A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWmI2ILlqxy/qWTO+WqPh6yzMdLq+I98MWUizVSk7O43fKo9vr2ZY9Ajk1Ds3W73aUI3+QxDt5Rg83QjxaLEJc7QSkjk78T5KeYspZHbaMKWCXD+lP6a2UGd0H5B+tWGuS6eO98WDcY+Hh7IEkh/+XNvZsFKL854fbmJIFNlH4ZDXN6yKciUBOpsyl+04X/wIfCRRaLYH9GgRWWbm/LA+eONpLllwl7jCTfiiWbfLqWjXK3UN7Dp0IFDcKYLyxYOwbiCsQiv6DR8g6SaeJZIjYMgJLpTm6aNUVVYhfgStC0a/JVvP6JfQpw1nEYnK3gb1+ZYeO8tN0LM/S3nzDwn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWNI2bqPv3bVOTKI6BBVMUe7fCZlcwnlk9dnnRLZHJg=;
 b=vMJMRYUPxGVuGxgmqjNMyQfH5UY8o5mL4v/UNQWPCM/4f7iZigQs8hvUUMfVYfw4KHyyy3uZRQDZYsov4/mjM9dMvB4LACvkm05/OgXlx5yQkPycrJgYPeevg5pOYFu1qTZUyg0KE8k8bz/eQoVOdSAQYXcYWJ3ja4ITHGRoQw0l3SbZexYzYTXK6U7GUN5nI6GQl2jnAvT47E5+faszKZMpXUVgxqiWRv/YTP/tDaoK3Z2VAqZZmR4GGfp+PM9yYxhahR8h2E1ja/vqIFG9hxPugaDcYujwwb0SJ76SLQKOXaosEL0AxB86qI3qmhBxFTOByd4Q1DNIy577+cR+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWNI2bqPv3bVOTKI6BBVMUe7fCZlcwnlk9dnnRLZHJg=;
 b=JvpQIHrkvY/a1fGVnWHyD3JuCZ6ZjkDymZSlfahoyDBVukestVVpOMbWBB5G6L6cbNJLEIGEedjgOKRcas8hree6ifHATQtJWu1TPk1NvJbuNR4VBKDvzKJDdc3hjn6iUGUzLWgBSzN7B/n5kIE3Hdbk34VrGzg7Q6La6pb7beE=
Received: from BN1PR12CA0024.namprd12.prod.outlook.com (2603:10b6:408:e1::29)
 by IA0PPF6483BC7EA.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 26 Mar
 2026 07:55:14 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::9a) by BN1PR12CA0024.outlook.office365.com
 (2603:10b6:408:e1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 07:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:55:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:55:11 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 14/14] drm/amdgpu: Consolidate reserve region allocations
Date: Thu, 26 Mar 2026 13:15:35 +0530
Message-ID: <20260326075412.1378411-15-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|IA0PPF6483BC7EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c429e7e-59bd-4edd-6f08-08de8b0d0370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bnhIhIMEXG+meR/fpFm+hWyssWIo7aNlFcSFkbnxLWHDo9y7EgsSTMeLDn8HmckuRbohJA5OdmOUoAzDOJbTDQtIhtjwe61DT8OQEKU3ddOlmXZ6z+blUMIBT2nd7vj+6de2hMdrecXUibAdauuenjPgKVr+uQZdoJXltr9nH99FG2JnbIfmMdlUoKyRYWTpHxXijjOEAcG5mibskocr7xEZOmFggJs4eX0pwsf657PzBPy7BFQ6TYImSm8eNTEaQgz727AsKkTfnyxAO7lwYG+pC/OrFUPAQ1RveneBAZAd70Skg9dy+cJGdOJZIUwjtyvSqjWPiAAzIEfyfujhGWb6paumve2NCvRP/t4TY5D0ZefPzU5dEfqCg+Y540HzCTLUSPhGu++mRLJfX+sZk5TEHT3p/6PlnzwmDBUHaSty6rfP3M3wSWPJfn99klZ40ArrQATx2RyIP2rpy/u4qBEt+gK8AB/BL+XZZE6BHe/jrL98RWoIDIq9dxK6mv1ce8W4mcfoMu+dt643JpghF4pRaCoIwXemEViPdO3sx92ogIFNbKOzV0X/Xg8kfMYMXp4NaNzXoEjvn/VDdJzt6niegTTL8aanGDMNfkWD1Pr6X2e1+gtz7FUyoDeFtZYGymAVcOcvlolAI2x0fYvdhCkNpm1OU3dLkzoK0kVG5r6+FIISVo6sxmSgTPa09mcAu57SFPSIGSYW+vfFcKMFzOXLxmNK0Bdw5Ai4uiXfQ8i6K+OJFykoV/LKBnvC2FKkSNO8gYakAVJH5PzgMsb9AQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SzP24yYrYYnm/Xu7zarKgILJ9QFEFAcugBt98tC9F8F2eg/vUhDr0JS3FTIGsDyYja25PzCxN9glqYkJUQ/RMSDYo9adBsBcj4bIbvujxMTZkFjaDbN2M2pWXAED3l3NqUSGVVvKlHxyPVWvmkPnOyOw//u1lk9pyrkqBCg7JDBpey0dc8h8QUHwkCd3I/U892+hY60Du+3rBxgl/HhzL8DYv0Q10JByC2NoO3p9LCkBVK1nKUAVL+rrgLRSF4gnuA1rPIFTJL6rTHKtKCwvpFLB1sAM+AEHh/yYfKR25SQplkyXYhBu0I0uCQJvFtee9dY/XLC0G/z02Jynf8nB8Q29PEPuam53/fn+8o0UQTjYBf5g7F3kkxgOAGYmxt9lmjuaF+JskfXHc6l02vDF3mwLIjIwo8d/IXqjLhXxpdeKD8HrkLpZrpYBvLnuVaiV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:14.1316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c429e7e-59bd-4edd-6f08-08de8b0d0370
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6483BC7EA
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

Move marking reserve regions to a single function. It loops through all
the reserve region ids. The ones with non-zero size are reserved. There
are still some reservations which could happen later during runtime like
firmware extended reservation region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 89 ++++++++-----------------
 1 file changed, 26 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d88d75a1eaeb..dae9434c6a93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1789,7 +1789,8 @@ int amdgpu_ttm_mark_vram_reserved(struct amdgpu_device *adev,
 					 &resv->bo,
 					 resv->needs_cpu_map ? &resv->cpu_ptr : NULL);
 	if (ret) {
-		dev_dbg(adev->dev, "reserve vram failed: id=%d offset=0x%llx size=0x%llx ret=%d\n",
+		dev_err(adev->dev,
+			"reserve vram failed: id=%d offset=0x%llx size=0x%llx ret=%d\n",
 			id, resv->offset, resv->size, ret);
 		memset(resv, 0, sizeof(*resv));
 	}
@@ -1814,6 +1815,24 @@ void amdgpu_ttm_unmark_vram_reserved(struct amdgpu_device *adev,
 	memset(resv, 0, sizeof(*resv));
 }
 
+/*
+ * Reserve all regions with non-zero size. Regions whose info is not
+ * yet available (e.g., fw extended region) may still be reserved
+ * during runtime.
+ */
+static int amdgpu_ttm_alloc_vram_resv_regions(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < AMDGPU_RESV_MAX; i++) {
+		r = amdgpu_ttm_mark_vram_reserved(adev, i);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
 /*
  * Memoy training reservation functions
  */
@@ -1854,35 +1873,6 @@ static void amdgpu_ttm_training_data_block_init(struct amdgpu_device *adev)
 			ctx->c2p_train_data_offset);
 }
 
-/*
- * reserve TMR memory at the top of VRAM which holds
- * IP Discovery data and is protected by PSP.
- */
-static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
-{
-	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
-	int ret;
-
-	ret = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_MEM_TRAIN);
-	if (ret) {
-		dev_err(adev->dev, "memory training region reservation failed(%d)!\n", ret);
-		return ret;
-	}
-
-	if (adev->mman.resv_region[AMDGPU_RESV_MEM_TRAIN].size) {
-		amdgpu_ttm_training_data_block_init(adev);
-		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
-	}
-
-	ret = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_FW);
-	if (ret) {
-		dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int amdgpu_ttm_pools_init(struct amdgpu_device *adev)
 {
 	int i;
@@ -2133,45 +2123,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 
 	amdgpu_ttm_init_vram_resv_regions(adev);
 
-	/*
-	 *The reserved vram for firmware must be pinned to the specified
-	 *place on the VRAM, so reserve it early.
-	 */
-	r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USAGE);
+	r = amdgpu_ttm_alloc_vram_resv_regions(adev);
 	if (r)
 		return r;
 
-	/*
-	 * The reserved VRAM for the driver must be pinned to a specific
-	 * location in VRAM, so reserve it early.
-	 */
-	r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
-	if (r)
-		return r;
+	if (adev->mman.resv_region[AMDGPU_RESV_MEM_TRAIN].size) {
+		struct psp_memory_training_context *ctx =
+					&adev->psp.mem_train_ctx;
 
-	/*
-	 * only NAVI10 and later ASICs support IP discovery.
-	 * If IP discovery is enabled, a block of memory should be
-	 * reserved for it.
-	 */
-	if (adev->discovery.reserve_tmr) {
-		r = amdgpu_ttm_reserve_tmr(adev);
-		if (r)
-			return r;
+		amdgpu_ttm_training_data_block_init(adev);
+		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	}
 
-	r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_VGA);
-	if (r)
-		return r;
-
-	r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_EXTENDED);
-	if (r)
-		return r;
-
-	r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_RESERVED);
-	if (r)
-		return r;
-
 	dev_info(adev->dev, " %uM of VRAM memory ready\n",
 		 (unsigned int)(adev->gmc.real_vram_size / (1024 * 1024)));
 
-- 
2.49.0

