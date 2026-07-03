Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3099BC43458
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2026 09:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE9410F741;
	Fri,  3 Jul 2026 09:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0J94DNrP";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013043.outbound.protection.outlook.com
 [40.93.196.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8732210F741
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2026 09:57:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oj72yKAH2EaSPHp/OlxpcdP5kCAegzzwqWeMf3S6G8v8r8NQi5/H+w7gHDDMBzM0D16a/EpO+TYO+d0W0bnks7wRZQxEyOSoAXouE04JThKx0CpXxFKmt4/Pm5R/qGCf1P0bg/9zO2xBt4ta1G8IePX89vYkXKFvwz3zo85120Zepavw9l2Ivd5nx4eNpp4Uq3j4t47cZCTM3ZutndJtl/EFt/APmo9qeFpyjUfVa8L+/GzXkW4s56nq2j2ODr2qtN8HlmKAPciboCCQI69fH9u5w4sSwHFIM7WEMEDTaOKGRlKMiskvrCHP8Q+LXZgWY146Zb951JUWv/rozHX4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgbCTcQ12EstTYOJi147i87J1NYqEq+XzI1KfBI4Xag=;
 b=OIQv4v7opwB8KfRZEYJJh2opeEVzyZqzUXXAQqpiWOiqj9THVemQTUeQEVJFsCX5+DNuXFH9oTmMwoNfsjCy1Ahph4L8IzPutcp6c211vET6cBTlRedRtUU4bDLTSY00JNseCT9sUCGDAmzZBtX0OHRy15CYB1CL3YTJuhtl3CraVfghQ1vKBY5cGFwu7XzogBB7Lw3X8izu437DMv5AgHoZ5dqAfAzzrRAdRGsYQXvuojZmYEQfq6pt+2v4gTothJBXhRd6l3+xVLVrk+pApuj7F9SD+BHgvwvASN0lIDNc57sa6Ub1d9skIIFu+1VlXtfO+NWcDfwa0bWOksj91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgbCTcQ12EstTYOJi147i87J1NYqEq+XzI1KfBI4Xag=;
 b=0J94DNrP5i0y5COo06ehsi7FOd3HnvoWz/Vpcoj/gSz1lv2eEeDBp58+cwUqbwAwkclTUUJQvq+eCuTAYuzZd2W9K8heEAXlS9ZgPtg+JxMix3jznSeV3aeEBCvKhQMr6WOz4LuALAI/x7h387pYQQ3PQWlq2VvFnusRd5xdOGc=
Received: from SA1PR03CA0006.namprd03.prod.outlook.com (2603:10b6:806:2d3::19)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 09:57:01 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::74) by SA1PR03CA0006.outlook.office365.com
 (2603:10b6:806:2d3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 09:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 09:57:00 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 3 Jul 2026 04:56:58 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/mes12: Remove MES self test
Date: Fri, 3 Jul 2026 15:26:45 +0530
Message-ID: <20260703095645.3173463-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 660744c5-c490-4755-9433-08ded8e96d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: zEzl+xYtM8J/vvo483mSk6Gkves9DVOv0Ypd/MY8tY8mD0e/DDhq9IRMEsSO5OgKWFx5wNYW/s9mdlNY2RTE4QkkSVumvWJOgs7Kor3BmqVR6T9sKg21uyi4CLptZBG6Q1UgOHvWOPyME9tS+7TF8LFfZCHBu3jq/H9sFZ9+29DH696oEfBRpMQIe5tIaYvS6ID3j0SihIYj4DrQ6jdFXaEnutIj3iMgzcTmT1WqvUzOHYSoGQYE5RkmNysUA9pFQ1aM6Kiyxx5ggvXVF8IPmGGw5/06mwbVX04r2Ppsw7QFySi+oYWxaKmw/f3/SSJ5gI12i2/SaRHQlSbQRTkmZv1bxA9ugXLXuzXn7OdyBFOml2FcjMOYG1TII8cJqwKSgjfBLqWgyGGUZOqQRfkvzIfYjzT1lS2r6FR2ehnT6Y7RVOaDmuc6ynrwDpIutL+l+VhxYHgBbGYTyBv2MdySEffd0KbwHpTLOyJuDXNtK2cMR8eITOqKXfMFtn3DfC7Avq3V+JAiSK0tyDgcJub5Nypz7VDgSsW9/cEPm6G3gPVW0W6fkC4rxty7aymNBeIUhZblkIJQGGeUOrO9WffmhtygNa2+eaaJ6YOlIfA9en1X4N8DSJ8NiVaHGlepgpptv51kTNk1IA6eDRMxVRuWWQm8r+YL1IfKQi4gPt71xJWpLRI6kanvfahus/AkME7uolbC22OZQEdSqDZ4DsKf1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OnB79+h508mrOR3hvUMkqsNIvgA6GFNmQggfu1ZuK8pPz1BDZkB8QWktkC93sd72+mQUJOspfEcfDV8jIZbTti3XOcaOSohiVMZCqwQ8n5XO3XUYhZe3zIOU2/j6bVRi2x6NRMEeZ2ijglc0HBhxNhYcpxGaDN1EIkItkmmeRKp8ftNPcft3hRFL72JUIDTULvA7hyMzhFnkIVkmEOCK/1Xwi/WDi18qLBGi2iyZUMJk0SzVh2mPyrG70bxuM19vQhMa70GNmL6Ct1Euv8aTmKQpPBqXzwBZ8rsCcLD02/ocHm9kxzgPHtXNOkSDyw1wfy2Tkwd2s4bCsUPYNzxJQDnNsHbi1tx1GoVtXPdhDXMtG9ciuSfa/6ZUZ6ZrdF6i7av69Ua509Mk2m4rTZbkzTjJJgrnV2hg8Oecv1/AymgLAEo9EgOEVS6qFb6MxfjG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:57:00.8240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 660744c5-c490-4755-9433-08ded8e96d75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
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

The MES self test is no longer needed. Other MES versions already
dropped their self tests since IGT now covers this functionality.

Remove the MES v12 self test as well.

Cc: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 334 +------------------------
 1 file changed, 1 insertion(+), 333 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 65b824144a2f..e7d7160f8fc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -43,7 +43,6 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc_id);
 static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block);
 static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
 static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
-static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id);
 static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_id);
 
 #define MES_EOP_SIZE   2048
@@ -1994,31 +1993,10 @@ static int mes_v12_1_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int mes_v12_1_late_init(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int xcc_id, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-
-	/* TODO: remove it if issue fixed. */
-	if (adev->mes.enable_coop_mode)
-		return 0;
-
-	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
-		/* for COOP mode, only test master xcc. */
-		if (adev->mes.enable_coop_mode &&
-		    adev->mes.master_xcc_ids[xcc_id] != xcc_id)
-			continue;
-
-		mes_v12_1_self_test(adev, xcc_id);
-	}
-
-	return 0;
-}
-
 static const struct amd_ip_funcs mes_v12_1_ip_funcs = {
 	.name = "mes_v12_1",
 	.early_init = mes_v12_1_early_init,
-	.late_init = mes_v12_1_late_init,
+	.late_init = NULL,
 	.sw_init = mes_v12_1_sw_init,
 	.sw_fini = mes_v12_1_sw_fini,
 	.hw_init = mes_v12_1_hw_init,
@@ -2034,313 +2012,3 @@ const struct amdgpu_ip_block_version mes_v12_1_ip_block = {
 	.rev = 0,
 	.funcs = &mes_v12_1_ip_funcs,
 };
-
-static int mes_v12_1_alloc_test_buf(struct amdgpu_device *adev,
-				    struct amdgpu_bo **bo, uint64_t *addr,
-				    void **ptr, int size)
-{
-	amdgpu_bo_create_kernel(adev, size, PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
-				bo, addr, ptr);
-	if (!*bo) {
-		dev_err(adev->dev, "failed to allocate test buffer bo\n");
-		return -ENOMEM;
-	}
-	memset(*ptr, 0, size);
-	return 0;
-}
-
-static int mes_v12_1_map_test_bo(struct amdgpu_device *adev,
-				 struct amdgpu_bo *bo, struct amdgpu_vm *vm,
-				 struct amdgpu_bo_va **bo_va, u64 va, int size)
-{
-	struct amdgpu_sync sync;
-	int r;
-
-	r = amdgpu_map_static_csa(adev, vm, bo, bo_va, va, size);
-	if (r)
-		return r;
-
-	amdgpu_sync_create(&sync);
-
-	r = amdgpu_vm_bo_update(adev, *bo_va, false);
-	if (r) {
-		dev_err(adev->dev, "failed to do vm_bo_update on meta data\n");
-		goto error;
-	}
-	amdgpu_sync_fence(&sync, (*bo_va)->last_pt_update, GFP_KERNEL);
-
-	r = amdgpu_vm_update_pdes(adev, vm, false);
-	if (r) {
-		dev_err(adev->dev, "failed to update pdes on meta data\n");
-		goto error;
-	}
-	amdgpu_sync_fence(&sync, vm->last_update, GFP_KERNEL);
-	amdgpu_sync_wait(&sync, false);
-
-error:
-	amdgpu_sync_free(&sync);
-	return r;
-}
-
-static int mes_v12_1_test_ring(struct amdgpu_device *adev, int xcc_id,
-			       u32 *queue_ptr, u64 fence_gpu_addr,
-			       void *fence_cpu_ptr, void *wptr_cpu_addr,
-			       u64 doorbell_idx, int queue_type)
-{
-	volatile uint32_t *cpu_ptr = fence_cpu_ptr;
-	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	int sdma_ring_align = 0x10, compute_ring_align = 0x100;
-	uint32_t tmp, xcc_offset;
-	int r = 0, i, j, wptr = 0;
-
-	if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
-		if (!adev->mes.enable_coop_mode) {
-			WREG32_SOC15(GC, GET_INST(GC, xcc_id),
-				     regSCRATCH_REG0, 0xCAFEDEAD);
-		} else {
-			for (i = 0; i < num_xcc; i++) {
-				if (adev->mes.master_xcc_ids[i] == xcc_id)
-					WREG32_SOC15(GC, GET_INST(GC, i),
-					       regSCRATCH_REG0, 0xCAFEDEAD);
-			}
-		}
-
-		xcc_offset = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
-		queue_ptr[wptr++] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
-		queue_ptr[wptr++] = xcc_offset - PACKET3_SET_UCONFIG_REG_START;
-		queue_ptr[wptr++] = 0xDEADBEEF;
-
-		for (i = wptr; i < compute_ring_align; i++)
-			queue_ptr[wptr++] = PACKET3(PACKET3_NOP, 0x3FFF);
-
-	}  else if (queue_type == AMDGPU_RING_TYPE_SDMA) {
-		*cpu_ptr = 0xCAFEDEAD;
-
-		queue_ptr[wptr++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
-			SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
-		queue_ptr[wptr++] = lower_32_bits(fence_gpu_addr);
-		queue_ptr[wptr++] = upper_32_bits(fence_gpu_addr);
-		queue_ptr[wptr++] = SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
-		queue_ptr[wptr++] = 0xDEADBEEF;
-
-		for (i = wptr; i < sdma_ring_align; i++)
-			queue_ptr[wptr++] = SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
-
-		wptr <<= 2;
-	}
-
-	atomic64_set((atomic64_t *)wptr_cpu_addr, wptr);
-	WDOORBELL64(doorbell_idx, wptr);
-
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (queue_type == AMDGPU_RING_TYPE_SDMA) {
-			tmp = le32_to_cpu(*cpu_ptr);
-		} else {
-			if (!adev->mes.enable_coop_mode) {
-				tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id),
-						   regSCRATCH_REG0);
-			} else {
-				for (j = 0; j < num_xcc; j++) {
-					if (xcc_id != adev->mes.master_xcc_ids[j])
-						continue;
-
-					tmp = RREG32_SOC15(GC, GET_INST(GC, j),
-							   regSCRATCH_REG0);
-					if (tmp != 0xDEADBEEF)
-						break;
-				}
-			}
-		}
-
-		if (tmp == 0xDEADBEEF)
-			break;
-
-		if (amdgpu_emu_mode == 1)
-			msleep(1);
-		else
-			udelay(1);
-	}
-
-	if (i >= adev->usec_timeout) {
-		dev_err(adev->dev, "xcc%d: mes self test (%s) failed\n", xcc_id,
-		      queue_type == AMDGPU_RING_TYPE_SDMA ? "sdma" : "compute");
-
-		while (halt_if_hws_hang)
-			schedule();
-
-		r = -ETIMEDOUT;
-	} else {
-		dev_info(adev->dev, "xcc%d: mes self test (%s) pass\n", xcc_id,
-		      queue_type == AMDGPU_RING_TYPE_SDMA ? "sdma" : "compute");
-	}
-
-	return r;
-}
-
-#define USER_CTX_SIZE (PAGE_SIZE * 2)
-#define USER_CTX_VA AMDGPU_VA_RESERVED_BOTTOM
-#define RING_OFFSET(addr) ((addr))
-#define EOP_OFFSET(addr)  ((addr) + PAGE_SIZE)
-#define WPTR_OFFSET(addr) ((addr) + USER_CTX_SIZE - sizeof(u64))
-#define RPTR_OFFSET(addr) ((addr) + USER_CTX_SIZE - sizeof(u64) * 2)
-#define FENCE_OFFSET(addr) ((addr) + USER_CTX_SIZE - sizeof(u64) * 3)
-
-static int mes_v12_1_test_queue(struct amdgpu_device *adev, int xcc_id,
-		     int pasid, struct amdgpu_vm *vm, u64 meta_gpu_addr,
-		     u64 queue_gpu_addr, void *ctx_ptr, int queue_type)
-{
-	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	struct amdgpu_mqd *mqd_mgr = &adev->mqds[queue_type];
-	struct amdgpu_mqd_prop mqd_prop = {0};
-	struct mes_add_queue_input add_queue = {0};
-	struct mes_remove_queue_input remove_queue = {0};
-	struct amdgpu_bo *mqd_bo = NULL;
-	int num_xcc = NUM_XCC(adev->gfx.xcc_mask);
-	int i, r, off, mqd_size, mqd_count = 1;
-	void *mqd_ptr = NULL;
-	u64 mqd_gpu_addr, doorbell_idx;
-
-	/* extra one page size padding for mes fw */
-	mqd_size = mqd_mgr->mqd_size + PAGE_SIZE;
-
-	if (queue_type == AMDGPU_RING_TYPE_SDMA) {
-		doorbell_idx = adev->mes.db_start_dw_offset +	\
-			adev->doorbell_index.sdma_engine[0];
-	} else {
-		doorbell_idx = adev->mes.db_start_dw_offset + \
-			adev->doorbell_index.userqueue_start;
-	}
-
-	if (adev->mes.enable_coop_mode &&
-	    queue_type == AMDGPU_RING_TYPE_COMPUTE) {
-		for (i = 0, mqd_count = 0; i < num_xcc; i++) {
-			if (adev->mes.master_xcc_ids[i] == xcc_id)
-				mqd_count++;
-		}
-		mqd_size *= mqd_count;
-	}
-
-	r = mes_v12_1_alloc_test_buf(adev, &mqd_bo, &mqd_gpu_addr,
-				     &mqd_ptr, mqd_size * mqd_count);
-	if (r < 0)
-		return r;
-
-	mqd_prop.mqd_gpu_addr = mqd_gpu_addr;
-	mqd_prop.hqd_base_gpu_addr = RING_OFFSET(USER_CTX_VA);
-	mqd_prop.eop_gpu_addr = EOP_OFFSET(USER_CTX_VA);
-	mqd_prop.wptr_gpu_addr = WPTR_OFFSET(USER_CTX_VA);
-	mqd_prop.rptr_gpu_addr = RPTR_OFFSET(USER_CTX_VA);
-	mqd_prop.doorbell_index = doorbell_idx;
-	mqd_prop.queue_size = PAGE_SIZE;
-	mqd_prop.mqd_stride_size = mqd_size;
-	mqd_prop.use_doorbell = true;
-	mqd_prop.hqd_active = false;
-
-	mqd_mgr->init_mqd(adev, mqd_ptr, &mqd_prop);
-	if (mqd_count > 1) {
-		for (i = 1; i < mqd_count; i++) {
-			off = mqd_size * i;
-			mqd_prop.mqd_gpu_addr = mqd_gpu_addr + off;
-			mqd_mgr->init_mqd(adev, (char *)mqd_ptr + off,
-					  &mqd_prop);
-		}
-	}
-
-	add_queue.xcc_id = xcc_id;
-	add_queue.process_id = pasid;
-	add_queue.page_table_base_addr = adev->vm_manager.vram_base_offset +
-		amdgpu_bo_gpu_offset(vm->root.bo) - adev->gmc.vram_start;
-	add_queue.process_va_start = 0;
-	add_queue.process_va_end = adev->vm_manager.max_pfn - 1;
-	add_queue.process_context_addr = meta_gpu_addr;
-	add_queue.gang_context_addr = meta_gpu_addr + AMDGPU_MES_PROC_CTX_SIZE;
-	add_queue.doorbell_offset = doorbell_idx;
-	add_queue.mqd_addr = mqd_gpu_addr;
-	add_queue.wptr_addr = mqd_prop.wptr_gpu_addr;
-	add_queue.wptr_mc_addr = WPTR_OFFSET(queue_gpu_addr);
-	add_queue.queue_type = queue_type;
-	add_queue.vm_cntx_cntl = hub->vm_cntx_cntl;
-
-	r = mes_v12_1_add_hw_queue(&adev->mes, &add_queue);
-	if (r)
-		goto error;
-
-	mes_v12_1_test_ring(adev, xcc_id, (u32 *)RING_OFFSET((char *)ctx_ptr),
-			    FENCE_OFFSET(USER_CTX_VA),
-			    FENCE_OFFSET((char *)ctx_ptr),
-			    WPTR_OFFSET((char *)ctx_ptr),
-			    doorbell_idx, queue_type);
-
-	remove_queue.xcc_id = xcc_id;
-	remove_queue.doorbell_offset = doorbell_idx;
-	remove_queue.gang_context_addr = add_queue.gang_context_addr;
-	remove_queue.queue_type = queue_type;
-	r = mes_v12_1_remove_hw_queue(&adev->mes, &remove_queue);
-
-error:
-	amdgpu_bo_free_kernel(&mqd_bo, &mqd_gpu_addr, &mqd_ptr);
-	return r;
-}
-
-static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id)
-{
-	int queue_types[] = { AMDGPU_RING_TYPE_COMPUTE,
-		              /* AMDGPU_RING_TYPE_SDMA */ };
-	struct amdgpu_bo_va *bo_va = NULL;
-	struct amdgpu_vm *vm = NULL;
-	struct amdgpu_bo *meta_bo = NULL, *ctx_bo = NULL;
-	void *meta_ptr = NULL, *ctx_ptr = NULL;
-	u64 meta_gpu_addr, ctx_gpu_addr;
-	int size, i, r, pasid;
-
-	pasid = amdgpu_pasid_alloc(16, NULL);
-	if (pasid < 0)
-		pasid = 0;
-
-	size = AMDGPU_MES_PROC_CTX_SIZE + AMDGPU_MES_GANG_CTX_SIZE;
-	r = mes_v12_1_alloc_test_buf(adev, &meta_bo, &meta_gpu_addr,
-				     &meta_ptr, size);
-	if (r < 0)
-		goto err2;
-
-	r = mes_v12_1_alloc_test_buf(adev, &ctx_bo, &ctx_gpu_addr,
-				     &ctx_ptr, USER_CTX_SIZE);
-	if (r < 0)
-		goto err2;
-
-	vm = kzalloc(sizeof(*vm), GFP_KERNEL);
-	if (!vm) {
-		r = -ENOMEM;
-		goto err2;
-	}
-
-	r = amdgpu_vm_init(adev, vm, -1, pasid);
-	if (r)
-		goto err1;
-
-	r = mes_v12_1_map_test_bo(adev, ctx_bo, vm, &bo_va,
-				  USER_CTX_VA, USER_CTX_SIZE);
-	if (r)
-		goto err0;
-
-	for (i = 0; i < ARRAY_SIZE(queue_types); i++) {
-		memset(ctx_ptr, 0, USER_CTX_SIZE);
-
-		r = mes_v12_1_test_queue(adev, xcc_id, pasid, vm, meta_gpu_addr,
-					 ctx_gpu_addr, ctx_ptr, queue_types[i]);
-		if (r)
-			break;
-	}
-
-	amdgpu_unmap_static_csa(adev, vm, ctx_bo, bo_va, USER_CTX_VA);
-err0:
-	amdgpu_vm_fini(adev, vm);
-err1:
-	kfree(vm);
-err2:
-	amdgpu_bo_free_kernel(&meta_bo, &meta_gpu_addr, &meta_ptr);
-	amdgpu_bo_free_kernel(&ctx_bo, &ctx_gpu_addr, &ctx_ptr);
-	amdgpu_pasid_free(pasid);
-	return r;
-}
-
-- 
2.34.1

