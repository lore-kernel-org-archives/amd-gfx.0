Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8CAC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 00:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9EF10E2A8;
	Mon, 29 Jun 2026 00:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aA1NKzbM";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010027.outbound.protection.outlook.com
 [40.93.198.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEADC10E2A8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 00:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNeXXkoH5b9J0zbb0tEkeYw36C4AdouwxjDy52qDXo1S97DeyqebShOiYOqzKbsW4iS508Kx8WUIOHNkCellT5z4/y0Rxlp6OBft0mTVMlLoGoW94eh8l6+WK3ZjQ0mMghF77LLwd5+bkJH+bZ5zMmNJ/JvqzVNTKeZXMR1DCfJgvUZkDkAMAArmqeYCCIBwE7I1DSF2WD6EglmDhFGVWO9KTUQSrd2dpn7DengC/QruUpE3UfNTcyngLOEFS0WUQf8qq63hqB1pjoGEIkm2jpz6az1rSM+IPhtYk6FGk2FGY2vY9sJOYwqWlGZmuWZXPVHVeX3dMGPyjf5wH8xh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXJ0EH7e4EaMhfCSzGlcTAp9RVz+zrq6hYx5irLlpYY=;
 b=FGe/ZFuXyAXnr/kaYsYlfXKRJ2IL0/8Fj1CPEe9UYs0n1YDqhmt3EzdLPggC6wYqbfdXQmYgOeKdeu9cyy3MKsOOYHrIfiXjjWAibShwuFOw+k5Mbwx/VwKZEMdQxWpQe8Uka0LbVkLtkm72uVLFl5ntkVd7ZnI+6zAuRqHgSEotEWAy0KdM8E9XgGxrbiprTRiFKj/E1X22crv9iR+KUwcVtFNnEVM2iGu/9KoZU4hF63f4FIGdcpCOpSHW/v8HBiVV6nrlP48pQPemByG2IosdzydcEQlHH9OJ1ozk1DnzIiCkTxk1+n7NkX4Y+BmtVeSy2vzDAfsYQqce+MeIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXJ0EH7e4EaMhfCSzGlcTAp9RVz+zrq6hYx5irLlpYY=;
 b=aA1NKzbMKH1gMO9hkAlFkieKf0V84ZKqRhfnLmU/rDQlVMkZAzRKKLQD+1VtdT6TY1pIB4V7fcVQUSlVLQORobUSVQbmw6J4bXn31MSN+sfYz3Js0jkA9RzEDcnXwUt/mWVbwpPYbe4igKWxAjV367cyS6IQg1MgrRMl0yGRiW8=
Received: from CH5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:1f4::20)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 00:50:44 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::8c) by CH5PR04CA0002.outlook.office365.com
 (2603:10b6:610:1f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 00:50:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 00:50:43 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 19:50:42 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <Felix.kuehling@amd.com>,
 <Yifan1.Zhang@amd.com>, <philip.yang@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <Bob.Zhou@amd.com>, <jamesz@amd.com>,
 "Claude Opus 4 . 6" <noreply@anthropic.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: use iosys_map for CWSR buffer access
Date: Sun, 28 Jun 2026 20:50:28 -0400
Message-ID: <20260629005028.2907470-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb023e8-e41c-4b22-4c6b-08ded57872c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|11063799006|6123799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Us5WaI9rGep14QNwBEjZxWdw/gVbQ0YB8iBbQc+LdSUIwHNc8icW7c9fKo9gdV4M9+4n3RejznV3rkQ5mIclLlDHV2uEQqCUVjghTFRbJXAZggAA0RGyqtsGlZtwhU/utT5zV2S1wQ+afsEJple6RwSFNHn/m5r5Kd8wrMby8HfM5GdFV/WAqkQTaTqQlXkJEkIYSlxN1osxrV/ZwOd4m+Inupnd3YYnc6qNJ8PD/Eov8pddn7KbwnWPLlwyKTVb53EhOSgmn4xVzJ9r4ARTDdo75PZt1lSqQ1ObAAduj2gq/LFzUvyCcE8DLdvjgzO4rdpbl+W1VdO3eInald6QRapW+qrFDvfSqFskKYJU1PbqQNQ6GSU6iqKA9oJvFBoQ2rlJqjdPVRsaw3b6xqRbGmPKXjxUTX5uUE0dENfS/jd6/SqPV6v0ciopF/pOvD26WGfV5SMSGiSTQ11h6X9lOoo338zaZXrikbPhxSliGnmQxY7Qf16ogycjcoe6z1Aju8iKV7IJLa7n41Mip7amoqrUcYet/a1f6FvgcHTcRAq0Y6FIaqP2DNcI/6HIzX8ufYfUmLPO2hYEUi8xdtJU5FGfnE5OESCHgZklpWA7ewrIxoL1vYDpD/pAGpHpeUzOA3hSNLQbQILioZONGWjNNv9Vnp1THWMysQTd7ONlwbDJkjSlpFkHiXXaSrkW/9f4qlk2mDxw7O87kKHfkj0tLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(11063799006)(6123799006)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8DndOKlOD4Vwc8vI33uxTXpcteDvceSmQYypUEGEyAtkDaTtnyMoYOw74SFzyJRAziMlG7uPeloSemU1jYuXPWBV12w8Lya0LUJIe/fgGaJvbKV6oHYL6HIkP9d8C8p0G2W2IZsat9yXpTQiHaCXgwsxl/rqml1HreG8hSzpRlTw4y5QxaSZ0chF+KbddVzBAaqgKLRR5UPfTXa2RYK1UZIRCH6qpintIj5f7vDgowTEwuQHceekV8Q87eC91jVol5Zs1Gz5va75pNsPHah1AIU5ULpuj0lRQ9fzxM9RbiQP2pPXdqo7JhSMdHFXE5XyBgHcmM9i2Tr3HjiIozEICAbeiZ4m+rBsvrQjQ2u/kWk0Go9cgLWD98IfA9aCQPBlVYfWpWnskxIMFdoEhKETzVjpnTgN03mbyeZiToP8lYq8FHX7Y5IKbZl92pCP7YIB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 00:50:43.0368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb023e8-e41c-4b22-4c6b-08ded57872c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
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

After moving TBA/TMA from GTT to VRAM for GFX9.4.2+ in commit
5088a1ba6d6d, direct pointer dereferences to CWSR buffers became
unsafe because VRAM is accessed via MMIO (PCI BAR mappings).

Direct writes like 'tma[2] = enabled' and memcpy() can fail or
produce incorrect results on non-x86 architectures because:
- MMIO requires specific accessor functions (writeq/readq)
- Compiler optimizations may generate invalid instruction sequences
- No guarantee of proper memory barriers or atomic access

This patch converts CWSR buffer access to use struct iosys_map,
which automatically handles both system memory (GTT) and MMIO
(VRAM) correctly by:
- Using writeq/writel/memcpy_toio for MMIO regions
- Using WRITE_ONCE/memcpy for system memory
- Providing proper memory barriers and access guarantees

Changes:
- Replace void *cwsr_kaddr with struct iosys_map cwsr_map
- Detect MMIO vs system memory using TTM_BO_MAP_IOMEM_MASK
- Use iosys_map_wr() for writing trap handler addresses and flags
- Use iosys_map_memcpy_to() for copying CWSR ISA code

This ensures correct operation on all architectures while maintaining
backward compatibility with older GPUs and APUs that use GTT.

Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
Co-Authored-By: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 63 +++++++++++++++++-------
 2 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ad4897f094a2..6e559aab4009 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -32,6 +32,7 @@
 #include <linux/atomic.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
+#include <linux/iosys-map.h>
 #include <uapi/linux/kfd_ioctl.h>
 #include <linux/idr.h>
 #include <linux/kfifo.h>
@@ -710,7 +711,7 @@ struct qcm_process_device {
 
 	/* CWSR memory */
 	struct kgd_mem *cwsr_mem;
-	void *cwsr_kaddr;
+	struct iosys_map cwsr_map;
 	uint64_t cwsr_base;
 	uint64_t tba_addr;
 	uint64_t tma_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8e701dcda8ec..7fd65c31afa2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -33,6 +33,7 @@
 #include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/pm_runtime.h>
+#include <drm/ttm/ttm_bo.h>
 #include "amdgpu_amdkfd.h"
 #include "amdgpu.h"
 #include "amdgpu_reset.h"
@@ -745,6 +746,21 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
 					       NULL);
 }
 
+static void kfd_process_free_gpuvm_map(struct kgd_mem *mem,
+			struct kfd_process_device *pdd, struct iosys_map *map)
+{
+	struct kfd_node *dev = pdd->dev;
+
+	if (map && !iosys_map_is_null(map)) {
+		amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
+		iosys_map_clear(map);
+	}
+
+	amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(dev->adev, mem, pdd->drm_priv);
+	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, mem, pdd->drm_priv,
+					       NULL);
+}
+
 /* kfd_process_alloc_gpuvm - Allocate GPU VM for the KFD process
  *	This function should be only called right after the process
  *	is created and when kfd_processes_mutex is still being held
@@ -1192,8 +1208,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		if (pdd->drm_file)
 			fput(pdd->drm_file);
 
-		if (pdd->qpd.cwsr_kaddr && !pdd->qpd.cwsr_base)
-			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
+		if (!iosys_map_is_null(&pdd->qpd.cwsr_map) && !pdd->qpd.cwsr_base)
+			free_pages((unsigned long)pdd->qpd.cwsr_map.vaddr,
 				get_order(KFD_CWSR_TBA_TMA_SIZE));
 
 		idr_destroy(&pdd->alloc_idr);
@@ -1501,7 +1517,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	void *kaddr;
 	int ret;
 
-	if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || !qpd->cwsr_base)
+	if (!dev->kfd->cwsr_enabled || !iosys_map_is_null(&qpd->cwsr_map) || !qpd->cwsr_base)
 		return 0;
 
 	if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) && !dev->adev->apu_prefer_gtt)
@@ -1516,17 +1532,28 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 		return ret;
 
 	qpd->cwsr_mem = mem;
-	qpd->cwsr_kaddr = kaddr;
+
+	/* Set up iosys_map based on whether memory is MMIO or system memory */
+	if (mem->bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
+		iosys_map_set_vaddr_iomem(&qpd->cwsr_map, kaddr);
+	else
+		iosys_map_set_vaddr(&qpd->cwsr_map, kaddr);
+
 	qpd->tba_addr = qpd->cwsr_base;
 
-	memcpy(qpd->cwsr_kaddr, dev->kfd->cwsr_isa, dev->kfd->cwsr_isa_size);
+	/* Copy CWSR ISA to buffer using appropriate accessor */
+	iosys_map_memcpy_to(&qpd->cwsr_map, 0, dev->kfd->cwsr_isa,
+			    dev->kfd->cwsr_isa_size);
 
 	kfd_process_set_trap_debug_flag(&pdd->qpd,
 					pdd->process->debug_trap_enabled);
 
 	qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
-	pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
-		 qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
+	pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_map:%s at %p for pqm.\n",
+		 qpd->tba_addr, qpd->tma_addr,
+		 qpd->cwsr_map.is_iomem ? "iomem" : "system",
+		 qpd->cwsr_map.is_iomem ? (void *)qpd->cwsr_map.vaddr_iomem :
+					  qpd->cwsr_map.vaddr);
 
 	return 0;
 }
@@ -1536,24 +1563,24 @@ static void kfd_process_device_destroy_cwsr_dgpu(struct kfd_process_device *pdd)
 	struct kfd_node *dev = pdd->dev;
 	struct qcm_process_device *qpd = &pdd->qpd;
 
-	if (!dev->kfd->cwsr_enabled || !qpd->cwsr_kaddr || !qpd->cwsr_base)
+	if (!dev->kfd->cwsr_enabled || iosys_map_is_null(&qpd->cwsr_map) || !qpd->cwsr_base)
 		return;
 
-	kfd_process_free_gpuvm(qpd->cwsr_mem, pdd, &qpd->cwsr_kaddr);
+	kfd_process_free_gpuvm_map(qpd->cwsr_mem, pdd, &qpd->cwsr_map);
 }
 
 void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 				  uint64_t tba_addr,
 				  uint64_t tma_addr)
 {
-	if (qpd->cwsr_kaddr) {
+	if (!iosys_map_is_null(&qpd->cwsr_map)) {
 		/* KFD trap handler is bound, record as second-level TBA/TMA
 		 * in first-level TMA. First-level trap will jump to second.
 		 */
-		uint64_t *tma =
-			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
-		tma[0] = tba_addr;
-		tma[1] = tma_addr;
+		iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
+			     uint64_t, tba_addr);
+		iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
+			     uint64_t, tma_addr);
 	} else {
 		/* No trap handler bound, bind as first-level TBA/TMA. */
 		qpd->tba_addr = tba_addr;
@@ -1619,10 +1646,10 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 				     bool enabled)
 {
-	if (qpd->cwsr_kaddr) {
-		uint64_t *tma =
-			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
-		tma[2] = enabled;
+	if (!iosys_map_is_null(&qpd->cwsr_map)) {
+		iosys_map_wr(&qpd->cwsr_map,
+			     KFD_CWSR_TMA_OFFSET + 2 * sizeof(uint64_t),
+			     uint64_t, enabled);
 	}
 }
 
-- 
2.43.0

