Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C73606D368
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GSSCaUPO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D4110FFBA;
	Wed, 18 Nov 2026 19:30:07 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0947710FFD6
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p55g/aNjG0gMMvtstOnQk4iUKEBhMIXc4BxoTunyqgQC+V9oicsu9QnQZp/u2qBcUWBxFYQV20fOM1Vy2OlCZWi8FBaq3Vx6nazjXuNeMIOKVTWmHRfSbKmpHywK3KZDBPwKnEyWkeNVovL0CVcvl0lXaVXZOQccE9KskJ593kl28AZZa3Z01UdQINxH4d6zoxhusOaljVMocG65tr2Nbw+2TreCQkGwleY46d2bFA+a/ngkkVjn2huFtHvpiz1+S4rgWLB4cprjQI6+i4P0vA7YuIQCfssK+IrADv2LbtVv+zAePq+DxzIacTZC2/dYKmfYnGlslBaRfBFxlc9ZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5arwOm69Upy1AukGjJYic5HJBv0C+mZ33CList2nNq0=;
 b=QfdQyWypb4esPGsB7CN4OPED73mo7MVXZA49xtYMYeoAjEHtE9Wn9vp7ubk4pLcQSBo3xRBBJsQt3sESlvTUcCkWemSp9rEKAVGAe8YxPQBZzR7w7JQoHtjPLpyKFYBFMAzuD4ssF9A8g3/yAVwhz0zonPP6LAfp2/YjdyuSxTxKeIVI3KA8CO1Z/nCBCIbdgyHx4q84RZPh1+LUdJp4vaKbFegc6pHH3QGtGsNiWiNQZ+ogu3SC4zHtSVW0gEl6gkqO0F7aNruhd2oLr884bRp65jq4UB4bFaktQG8g0SZasGqBNPp8jD5Db/Do8YFSC4HIBWJ2i3EBVR/tgpvIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5arwOm69Upy1AukGjJYic5HJBv0C+mZ33CList2nNq0=;
 b=GSSCaUPO8i6G0lYRZbePZuSd0pGp0jWcs560WBFy09pW6xmgeDUojsUGqtLBcyOsqtNVZqU8goKj8kOkJpSkiXRC5Rn4Auc3kf2mbaBGxFwSap7UOiz/ioyQlwaMY0jYQdjRgdochuo3W3YOr9nUs14G79IYiNs48Xp3V/KwHHI=
Received: from CH0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:610:74::30)
 by SA3PR12MB208015.namprd12.prod.outlook.com (2603:10b6:806:517::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:29:57 +0000
Received: from BN3PEPF00022BBD.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::1a) by CH0PR04CA0085.outlook.office365.com
 (2603:10b6:610:74::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 19:29:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBD.mail.protection.outlook.com (10.167.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:29:56 +0000
Received: from krussell.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:29:56 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <mukul.joshi@amd.com>, <philip.yang@amd.com>, Kent Russell
 <kent.russell@amd.com>
Subject: [PATCH v4] drm/amdgpu: Disable XNACK retry on GFX12.1
Date: Wed, 18 Nov 2026 14:29:46 -0500
Message-ID: <20261118192946.228131-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBD:EE_|SA3PR12MB208015:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af4e90e-1fed-449d-e409-08df45aa5431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|18002099003|261009223027099003|11063799006|56012099006|261021123027099003|261021121427099003|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: hCemp7w3AYTy6W0eVhIidI+OG+RKVwENKWY1G1puyCclVe6Y+9uZDlQFR6x5haJFLa3HEtNytHbGTYQqn3idC+fMPlYs8Z+jF+epfWQR4GtNc8snXvB10+f+ChE+ONSiHANGY+T0KE8ApSiVpl8Fllwpo0Bp+S5rBboyzKa/AyCza7CF/sfaCNPKKz8LNMxM/uxU1zlv3fxPU1nj1pJijqpzCA0Tx9lqNvgJY5/M8r00EeXNOxV0bFZfNX7WwyIA7dq8b/TzvB4/sg+BOlKSrnVWoiFxCVWfq/wBS7iHRsjYsby4MVabobqGn2MrMRlFhsyfNHW3Q9wpBD74SB/+3yOUb7ueyBYrxF2p1qIiWq34o9VwuCf9gVuVRnT3Nw7rv03+5H9PGvDoeUemZNtiQacFFdk3aF81K7Tt+f4cs04T7oFenCVBj5vpPUd2q+a83VfWtt1bHjB/kX9Sp7CL11vKxG9P2sa4cRQZmSl7zrvQUEiQOrCFzpgch3k8bEC3xHsBmtIxnfBHYp7ivv27thMcsxgQQGawqABnF3Wc7s6RzjPIk/hyRr571amBKfu3TNqHYLx1Y9lyzwmcND86cmIQwnVqLq7ejBNPmOF6E8Aax+JweXtmAgKgIbqQplXtbxmg93g0PVzrx3xxmBOaTysWXkT9FFafTed9wUuuaYG/v7wrGFDrD93WH+SeFxIynz8mPUgNS58aMdIxAzkoDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pq9Vd6u3fo2uAQL+1R2kNCmYpdn1ind5CW/YqjPOJl5Bq99sZd8fYMDxtoynK7RnxUrLnc9QZNss9yN88KWkI7xfS/YF1HT4GE6pAIFqQA8lmJtqtp2xY8SAxbDtthfkWxNaeGUGtp3Dr7X0bm04vobox/06/P9eqf2u7bCEm8ChMixtHk3hr427b0pk4XLtFq+JXI70xkf9ijgWZk4be2ZJYMzCUntTcF1jtlTh42QyBibSByLsJFWjQE/KoxGKbEBtP+m/1n2+mNoKbKkafFvSDZUD8n0IDOYCLvMOcnR4LM1aaaLB1smhl5fkaKQXc38AeGCXxAdn0hQO3ZEndR9MnYSDj7ZnCcs1bn9mfn/VGuziOP5BD4KAv5boY/0FGuDXVNo9h1k1iRmUTLFfIadKNrNNLKG2eCbWtaZCNXayOXT8oeIlCzb7PaKdVXhd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:29:56.8777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af4e90e-1fed-449d-e409-08df45aa5431
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB208015
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This feature cannot be properly supported, so disable it both on the
amdgpu side and the amdkfd side.

v2: Remove dead code (thanks Sashiko-bot)
v3: Remove unneeded extra check (thanks Mukul/Philip)
v4: Remove dead code (thanks Mukul)

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c         | 17 +++++++----------
 .../amdkfd/kfd_device_queue_manager_v12_1.c    | 18 ++++--------------
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 08d3ff61edcc..d0ede277aa85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 		gmc->noretry = 1;
 	else
 		gmc->noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
+
+	/* XNACK cannot be enabled on GFX12.1, so keep noretry=1 */
+	if (gc_ver == IP_VERSION(12, 1, 0)) {
+		if (amdgpu_noretry == 0)
+			dev_warn(adev->dev, "Unable to set noretry = 0 on GFX12.1. Keeping noretry = 1");
+		gmc->noretry = 1;
+	}
 }
 
 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 56439c9f8e17..9761c84da943 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_device *adev)
 {
 	u32 sh_mem_config = DEFAULT_SH_MEM_CONFIG;
 
-	/* GC 12.1.0 A0 requires RETRY_DISABLE in SH_MEM_CONFIG. */
-	if (SOC_V1_0_DIE_REV_XCD(adev->rev_id) == 0)
-		sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+	/* XNACK cannot be enabled for GFX12.1 */
+	sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
 
 	return sh_mem_config;
 }
@@ -1567,14 +1566,12 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 
 static void gfx_v12_1_xcc_xnack_set_chicken_bits(struct amdgpu_device *adev, int xcc_id)
 {
-	/* NOTE: COMPRESSION_ENABLE is used a chicken bit to enable/disable xcc xnack */
+	/* NOTE: COMPRESSION_ENABLE is used a chicken bit to enable/disable xcc xnack
+	 * Since xnack is disabled for GFX12.1, set it to 0 unconditionally
+	 */
 	mutex_lock(&adev->srbm_mutex);
-	if (!adev->gmc.noretry) {
-		WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id),
-				      TCP_PERFCOUNTER_FILTER, COMPRESSION_ENABLE, 0x1);
-	} else
-		WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id),
-				      TCP_PERFCOUNTER_FILTER, COMPRESSION_ENABLE, 0x0);
+	WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id),
+			      TCP_PERFCOUNTER_FILTER, COMPRESSION_ENABLE, 0x0);
 	mutex_unlock(&adev->srbm_mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
index 525989371378..63ba13a60b98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
@@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 	struct kfd_process_device *pdd;
 	struct amdgpu_device *adev = dqm->dev->adev;
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	bool xnack_enabled;
 
 	pdd = qpd_to_pdd(qpd);
 	qpd->vm_cntx_cntl = hub->vm_cntx_cntl;
@@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
 		qpd->sh_mem_ape1_base = 0;
 	}
 
-	xnack_enabled = KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev) ?
-			pdd->process->xnack_enabled :
-			!pdd->dev->kfd->noretry;
-
-	if (!xnack_enabled) {
-		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
-		qpd->vm_cntx_cntl &=
-			~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
-	} else {
-		qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
-		qpd->vm_cntx_cntl |=
-			(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
-	}
+	/* XNACK cannot be enabled for gfx12.1 */
+	qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+	qpd->vm_cntx_cntl &=
+		~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
 
 	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
 
-- 
2.43.0

