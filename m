Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7843F1093168
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 14:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EF110E84F;
	Wed, 25 Mar 2026 14:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iKrMJbBd";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A242110E853
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 14:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnbhRo5rvu3icVtXM2e9F0HJNvnbUdeviQ+AEm62LRBUrnuMcEBudLKrtSxJjZoWL/9xKztklvX8av16N6Hlrs9UMgozXCtyKTpbdJsn9eNdGtWqoiuA0acWz7oQvgxqK4a2bnr+QPeIxHHDiFLY3y5GpddGrhkkTRXY7gLObupaTzjz22Yjb+aa21z+xuP/UCr+M9EAzZ6D2TEXcqlJVK2zx65XW7BuTFOFhMwHqjKcZAqy+ul1zankbctaddIOGzyfYw9D62ExQvMLooiBtytYxsiX6hJ1kugWvkGhbOrSNw0ThORD8Y6N6aihGxJKdgJOfp5eSMuWnsx0QNDhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai7F0MDxdLGIomyJQ4EOi0QE30r4tR2EOZUkX5qnYwU=;
 b=r4o6b1rDcRjuU0m/ZR7C3Z2KG8QPx3DF6CFzKaky4FWsCWz7RxB0QSSWQhmT3qNPRecIJ28sKxGx8v9XWl5695FJDRWAHJyeyge1Yf5yNIMCrwAtc3AbdZ+BUpMqnawpVXrFHn+VCFwAveMrA5WNBORudv6Ks9VZzbU9eKZamjwzcgHBuskQSl4twVDRROxrt6atxH/sifI0m5MrLV6JJlfF/wJM1rHdaUnDuQ7WtKi6bI6VXIh1jRAbP1QdEOs/JE+vvo9hWoKwwSpOUbfjS64JHqz0vGUZzG14Zt+G0QFw2MFT9S5bjKHxt42ZLJNAN2XEkbCVfXJjHTImuF3Vdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai7F0MDxdLGIomyJQ4EOi0QE30r4tR2EOZUkX5qnYwU=;
 b=iKrMJbBd7SpBWlo3/VTMDFP0Eb/TTT25rvt5KTepqzZm4mQYrEHDDpMq/ws4B+q7W+FnCXkDSm14Ac8y1+7po2OY+71/pyQGFGJ3PvFe7MJ1FB0YlD9gj8AfxSJh4n3xA9S+PgeJh2kd7VCImNmi4IU+Q6ZZ1ZVaQ7CHNJLmrqg=
Received: from SJ0PR03CA0385.namprd03.prod.outlook.com (2603:10b6:a03:3a1::30)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:13:13 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::c0) by SJ0PR03CA0385.outlook.office365.com
 (2603:10b6:a03:3a1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 14:13:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 09:13:03 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: Add memory training reserve-region
Date: Wed, 25 Mar 2026 19:42:26 +0530
Message-ID: <20260325141226.1173216-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260325141226.1173216-1-lijo.lazar@amd.com>
References: <20260325141226.1173216-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 726d5c9e-9b65-4fc6-d289-08de8a78a661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: g8dHub9gAO+4BItkzrC2kntMN0pW5VGkehKNx4RBoSbPFLgxs4zQf/Q+HG6BL6PY5V7CbVH3fAnGoAyA7ZeZ6UbIKFjhqTzzOW/BznNIIyIdW6YbPMe5976NneyC4viDUXwXl8JyHfVEtRhWz+V4AC08+np71AKaWZnK2WN1HChOzaCPt63w1S1R3ph1y0wywCvM2v+xGGSs8j5SPDgv9YL6RyX9HTAgdRML6fT73gojgLeV/HD2X43KJ4JXJFMUYTHZwICnFr0llpyj+3S8TSNl418DvgT1ZVykFDDsZB6p8WCpI662TKckQwO3XbDWr7/FnIXtbIicCCceck/3oNPFc76cLo287bfjDAJ7z7BGaHPE+eJVxIbDkU0WrNlmvjB0EzylumTdeE/RnraPkE75QErgpJHwyA3b26yOcKY8Fabtj7MrdZnpZzeh+8M/JMJ5V2DN1dbNcD+DgvgFsuSAcXThg0vCyd2ZM4MHzkey8TwIWNj2K6MDDZFE13tzEIXRZM+AhGtkQBzliKISYjKKG47mET41t6Uvxry3Wb/prVHt4Tr+746KbM4PoQeQtkQ05SkQoPH6QIl6EwV7NMUVw4DAtQ0k8KzPuxjqljlw4FI36hX55QQxmQ0DhFxqzSklFDxe6W+bi2jMDkjCK1fvfQWsLYHV5Rtp4OP/0ptbrIJcdKrk0Th/ehH+tjkco2y3Ro/U9gJLQ/w3nxDWOS2M6Jl3b9bGeyHW6YB3jS9BzogqiS1atwSEP0ckWYUDF8RHy57hm6wUULNRkF1FoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aF+DSy6SL3MnlzUyRXKx6bG3h/Mpl2xCzfqmbF8n+fa3IHTSkJ91XB+Zyx/iHxqJjbe7NwiiYZEP6xrRezoGRj/T42A5wVMoleXPFfhfe4azhzEAnIlol5ZcA+hgY1BGUfRw9cQmUJ+x4h2yByG9oR9bWMUVaJd6VuJdDKJdIPPpCLb3e6GY01+nFts2Qe+G3PhjpitdH7PvKS8VqHVcyuP5ia1KTO7DtFL3PM+oF9MH/hUHebapBpNF1qf3j+Ch482rKtkHJljMyoYsuVU/X2Z95/H895WpT9I2r7ZWYTc81lWQ3EtnEFwiRODwsI6LRbDELYsTKymZKG0uizYErStf1jP9DA85hcxcV789ZXpBMVhDOb9EDVXL6EwtGpyB1Stv3gYqQhfHPF33SWE8WTtWYLSMAUHoK/8GljUCT85+1OIHkAvPe9KSWv8AN+bg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:13:12.3889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726d5c9e-9b65-4fc6-d289-08de8a78a661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435
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

Use reserve region helpers for initializing/reserving memory training
region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 15 ++++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 79a49cba8d40..7e94ec11c57e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -277,7 +277,6 @@ struct psp_memory_training_context {
 
 	/*vram offset of the c2p training data*/
 	u64 c2p_train_data_offset;
-	struct amdgpu_bo *c2p_bo;
 
 	enum psp_memory_training_init_flag init;
 	u32 training_cnt;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e38296c84895..f58e4acad7a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1751,8 +1751,7 @@ static int amdgpu_ttm_training_reserve_vram_fini(struct amdgpu_device *adev)
 	struct psp_memory_training_context *ctx = &adev->psp.mem_train_ctx;
 
 	ctx->init = PSP_MEM_TRAIN_NOT_SUPPORT;
-	amdgpu_bo_free_kernel(&ctx->c2p_bo, NULL, NULL);
-	ctx->c2p_bo = NULL;
+	amdgpu_ttm_unreserve_vram(adev, AMDGPU_RESV_MEM_TRAIN);
 
 	return 0;
 }
@@ -1823,14 +1822,12 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	if (mem_train_support) {
 		/* reserve vram for mem train according to TMR location */
 		amdgpu_ttm_training_data_block_init(adev, reserve_size);
-		ret = amdgpu_bo_create_kernel_at(adev,
-						 ctx->c2p_train_data_offset,
-						 ctx->train_data_size,
-						 &ctx->c2p_bo,
-						 NULL);
+		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_MEM_TRAIN,
+					  ctx->c2p_train_data_offset,
+					  ctx->train_data_size, false);
+		ret = amdgpu_ttm_reserve_vram(adev, AMDGPU_RESV_MEM_TRAIN);
 		if (ret) {
-			dev_err(adev->dev, "alloc c2p_bo failed(%d)!\n", ret);
-			amdgpu_ttm_training_reserve_vram_fini(adev);
+			dev_err(adev->dev, "memory training region reservation failed(%d)!\n", ret);
 			return ret;
 		}
 		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
-- 
2.49.0

