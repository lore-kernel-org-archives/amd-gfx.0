Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7C2CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 02:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A9910E2F6;
	Wed, 14 Oct 2026 02:21:31 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B9F10E2F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 02:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZD8u/uTdTehnV5iyU2qxtMySxfXL+jHD8qTsRuHFQDzA2XjUm0MkH5n+nVm/4/gq3m7p5Zmi9lBwtwRaeH1nrSZ0omBtebAt7MIL2dMuxMTmY5QKu+1WRBg21oKPtteYuP77k0RqsGACnnZEy0SEc8hKiIQyvTsttuZZVh28Q1U1D1Q5nvjaXytNOGfQ+V96Thric8hh9pGtZBSJndDXdjHpwiJuh5x5LY7VR4JdRgYalCGh7r2SygLCV6i2xmwevTHoxIXExBdVvAC4rDsoi9vcKMexVgdCu9HD6KeTYd5WxjqOiWZNq8fkjT0x9lWoxv0vLIRlNtDmVtwm2chN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Jwua0+zuHX7oI9+dCTvBctvUuAD2IGUMV1IaBHghgo=;
 b=TkFjH3aJA788SzAITKGOLJj/U+UQU46TI1/xWyHefmqdJ6aiTl160u4Jj1y1V7U5PU5VyIl1ynnx7gClwOtGJxOAtEkGwAUHX7mUqze2LW6VPrg0yUmDZB8uIPjpM2MLz7YFlQdVrpf2/UO6gU4jcQdl4oHAGtwGO0CXBsSZi0CjoReSMZZbWTywmVNErP7okf+2VQpTe+rnVNcY6mVLGWb1BE1ebfuiJIKIoRmsBlkYNMVdVVX84FJ+Fh3ZD0Q0K6xP3SiWlu9tUXCnK+w/hXPirqChfiwuWm54oPXXDxTbOuGPqJyULE0FrDTXq5soD04l0lxGb8WMWrO2W9Wa7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jwua0+zuHX7oI9+dCTvBctvUuAD2IGUMV1IaBHghgo=;
 b=Atzk3QbsUnTibpYWMeANYzpdpvTWZXWPr0C4Ei5loGDVHIEf24An0Exo+WPZlUxPKNZZR+pElGSyDELLlU5wUF3xNLlaPnH8RwLELJK9r//QjbIgbyjwROM+A8q4odUFZZUyFpdxGfg7zpTxzd+qdivFAtVEVkAmzfN+3SgNbEE=
Received: from DS7P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::10) by
 DS8PR12MB333896.namprd12.prod.outlook.com (2603:10b6:8:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 02:21:18 +0000
Received: from DM3PEPF000265C2.namprd03.prod.outlook.com
 (2603:10b6:8:223:cafe::51) by DS7P220CA0020.outlook.office365.com
 (2603:10b6:8:223::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 02:21:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C2.mail.protection.outlook.com (10.167.23.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 02:21:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 21:21:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 21:21:10 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 21:21:10 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Sunil Khatri <sunil.khatri@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>
Subject: [PATCH] drm/amdgpu: wait for tlb flush before freeing BO
Date: Tue, 13 Oct 2026 22:21:07 -0400
Message-ID: <20261014022107.2511834-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C2:EE_|DS8PR12MB333896:EE_
X-MS-Office365-Filtering-Correlation-Id: e06f9fc6-2f4b-4f44-b3db-08df2999d473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|6133799003|10067099003|18002099003|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: V0wjQeR3QLV3TmcCOUcI5RXSHrv5JI2tN5Zh8H3+HQGWhqH6a/oShdwx99NYtuo0ICSjPoxZRro7VB6ueyOg9b+8moUayqDU6hCLGXCDRmbW5j1nEfNPPT/CL32PRreK7eG71EVYqno6vUsd/8iVtyJuSF/Kh5w+L5mVOW11R2nDJRyE3sksIcVQTduFOkguFEVsW+wcldMOKS8zPtNODM5weaaNNa9pfDWIx5yUBoisYLRcmwKFavlZc750x/BZXCsgofTiE9Gz7tAM0gubMMY9OCYVviOX24wVpyarAe2nYEvjxlS9rJ8NeOE5Tde9l9TrH7jTOcfBRMXQ8yezXbN90PMndvYwPzGXAunoXxlDSE7yFvdhmi1K2CrDW/bszniimfsNC7UQkI3hclDHV3Whp0DOdEWVIWC42hLlZW+njwecC2C+mbh8FQmR5A1KEt6U+oiPLX90UAh80k6PJSebNPJz6eYu33AlhprdvuncgQZb9OoIG78FzJz6KdWODoPHCU0VBfYSafgTZgqY75+FF03ygo4erSV0SpvJQiN8BTP8f9okwoVOUVyOuX+84UjuanrF3U0jDg9mr3bkIkiKdOpYmWBJBLddWXtCZ+1NQjqtdpqswuySip8GtC328p481NFsbgPbjBrH+CNXYLUXtsBxVUJ2uGhOk1PKCPa2JOqLou2hmCOvczK6Mb1etYNnW3tcuunF3wPveZGMXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(6133799003)(10067099003)(18002099003)(11063799006)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FPoZvwG7C6jvsBLqWo/7IFbDF+HpzFRDRegNMPBJRQ691CdwwPBm+OM1ChzSjIE+P4zVjzQz1lNFAIXAy7cMZdc4en0+1fQOLl6ooOANg5XzqPsrlj59bcl0BV3ld5JytqPFlkC490+7txg+3CCMF6o3B7elktgULetg+EI47o2EtFb71AcwPwkE9d3TWANHsPhBoAj8rEZ/YZKImoT/GzMr5kzh13KUdoqtqUfQ8QXUph7o47LtZqwfsvRIgc1oO3AosgmzskQu/AaSZTX63V4OP2aR4l1fT+gcnKWcY+X2CfEJ5Kf7UJB1gf7eLt0ydPawKLKqg5BID2APSpBAylUmCBf3FFufYVE7jLJcmm1ZC7P28n5fIbtH9OSgqElcsr9C8GvXhMQsKqT+2QgQrBeJM4icpCmwyalxevWFOQzuxirtER2EogRNaqII1L8/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 02:21:18.0200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e06f9fc6-2f4b-4f44-b3db-08df2999d473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS8PR12MB333896
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

On gem object close, we previously only attached the fence of its own
clear_freed() call to the BO's resv. If an unmap of this BO happened
prior to the close call, clear_freed() would be invoked, leaving
vm->freed empty, and no meaningful fence to be attached to the resv on
close. Because of that the memory may be freed before the TLB flush is
complete, and give a running userq potential access to a stale
address translation.

Fix it by tracking the last TLB fence of each VM and attaching it to the
BO on close.

Fixes: a1d201e16940 ("drm/amdgpu: enable GFX-V11 userqueue support")
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8dbd7bb77305..7484c52e5850 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -360,6 +360,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 
 	amdgpu_vm_bo_del(adev, bo_va);
 	amdgpu_vm_bo_update_shared(bo);
+	if (!dma_fence_is_signaled(vm->last_tlb_flush_complete))
+		amdgpu_bo_fence(bo, vm->last_tlb_flush_complete, true);
 	if (!amdgpu_vm_ready(vm))
 		goto out_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7d3659ef11e5..c5411933a76c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1097,6 +1097,9 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	if (!params->unlocked && vm->need_tlb_fence) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
+		dma_fence_put(vm->last_tlb_flush_complete);
+		vm->last_tlb_flush_complete = dma_fence_get(*fence);
+
 		/* Makes sure no PD/PT is freed before the flush */
 		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
 				   DMA_RESV_USAGE_BOOKKEEP);
@@ -2648,6 +2651,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
+	vm->last_tlb_flush_complete = dma_fence_get_stub();
 	vm->generation = amdgpu_vm_generation(adev, NULL);
 
 	mutex_init(&vm->eviction_lock);
@@ -2693,6 +2697,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	dma_fence_put(vm->last_update);
 	dma_fence_put(vm->last_tlb_flush);
 	dma_fence_put(vm->last_unlocked);
+	dma_fence_put(vm->last_tlb_flush_complete);
 	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
 	amdgpu_vm_fini_entities(vm);
 
@@ -2839,6 +2844,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	dma_fence_lock_irqsave(vm->last_tlb_flush, flags);
 	dma_fence_unlock_irqrestore(vm->last_tlb_flush, flags);
 	dma_fence_put(vm->last_tlb_flush);
+	dma_fence_put(vm->last_tlb_flush_complete);
 
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
 		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ddcdc7256ef0..b9932c5e066f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -331,6 +331,7 @@ struct amdgpu_vm {
 	/* Last finished delayed update */
 	atomic64_t		tlb_seq;
 	struct dma_fence	*last_tlb_flush;
+	struct dma_fence	*last_tlb_flush_complete;
 	atomic64_t		kfd_last_flushed_seq;
 	uint64_t		tlb_fence_context;
 
-- 
2.55.0

