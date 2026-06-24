Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA9BCDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 18:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039EF10E0EE;
	Wed, 24 Jun 2026 18:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t937Uq2c";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD61910E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 18:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtMny/EohYVxrwLN/lyLs0MMpBTzM0BnASjwbnF0iMCBERY0PfII8rkmJgNKWxqebXtj3sf+xKqUEdZ1jDEZJeVzoSMmKOcEVLjyHbV59QJHml6ivH7oq9dhQZBEXrFqA0W5j4vpW+dnz498Jzz/toaap77fOudlNqh2QurgHNYXS2Y8z8Las56VavWeCWgyQzMq9CND4OVRdFoMC8zTv6YGbLgcr8N+xXoixa6kKJ+htph4rh1tJjKGdMVGOF4lAlViTD4q10F6XWYQLiDldLDxoteeO1wPvIv/TOPP9DiBitMfJ/2SXUorYS2+w8VCC6Ma6tmC37lkphA5FO63xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQp8Bg0VIRr6S79M+GKJmJ/L1cqw65iOGr0wAmILqu0=;
 b=GgspfvZyXnWiREdwLRqCSSfqX2z0QGOF4ChpXRZJhU1YttMcXmM2+gCIhwTlELlkgwTfuSHbTYeO3UDc3z5H1YabCW3WccFeiDwGRIfSsaThKvsXj2Fz5bZ85up5mQpwYtYp2tkG7mbYBUAVhjqVInd64jQVQuEfvjmEZvLeFWeV5O7VtTRR9+/HcZ3tcGvef6/13UqkxLqznb4zCjUzsETz/1sBpuJlrnYfW5HLO/CCzqIt1943AKwCdCnOsK46hpuTOSIUxGNHnnfD+/BM557dSWWH+yiH7Uqqk6y0TAdEDLWNGv1DxQfplfDi5qHkXqQFYDsRkCDHt/7Een7dPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQp8Bg0VIRr6S79M+GKJmJ/L1cqw65iOGr0wAmILqu0=;
 b=t937Uq2cBs/EKnDjuY4Mm6Uy8jMsWdfc936MhckMi/uNXoe/e5tQgnfQ9pq/Dq6Jp2T8j7ZOtqVWNyHuxTlrKqdGuewFaJvH1A7tAJCYnsSsV/L6ZEzrm9/Km8DhopK+7fIZyxKbsx5kJMZdWLORmA0B7xsSWS0Ekqmgc6u0uSM=
Received: from MN0P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::23)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 18:34:21 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::6b) by MN0P223CA0022.outlook.office365.com
 (2603:10b6:208:52b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Wed,
 24 Jun 2026 18:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 24 Jun 2026 18:34:21 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:34:20 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <philip.yang@amd.com>, <Hawking.Zhang@amd.com>, <Bob.Zhou@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <jamesz@amd.com>, Vladimir Indic
 <vladimir.indic@amd.com>
Subject: [PATCH v3 1/2] drm/amdkfd: Add domain parameter to kernel BO mapping
 function
Date: Wed, 24 Jun 2026 14:34:08 -0400
Message-ID: <20260624183409.2038354-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: c2204a7c-8b3c-4cdd-64ea-08ded21f355f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: cHYCdsNTkVR69LbYiR4MKc85blGvUBDrXYj75AjmEv6p3SrysD1IgSsVCujwuwXmSghx5q89kUFRpiwbUPaSCf05eXO1SpcuRQT8cevY6jXFc2i/+bsMWLGYTYGobJGE9+yJuKr8dhdVKkDChY29XQr5R9ZNh/bKs4u3s2QZyIWYhiUkC4mwtpU4IaZs5Zx/yzzwl2dJgOC43KNpd8j4NI55ZMfuqUousTAD0pJ+O8uzG65lhcLV0zZVBkV0dJGBgT6n7O0pTJjdOfm0fk2WZ7nXnElIsA6WV+s8x/PrO0vIInqCzFzT43hhtAwahv6Ao5jDqjmH4peqc6V36yKza7CvbiNmM0GDN9zJEcr+X16gy2SDZG8iUEbVUmexBXFGXlqTQi2nFZnCcVfp6PdtD1i/QhTAhifEOmrwurZ5G8nVbLeeQIgE4VDvXHpywUV1Xe9EcUHNjqXn3bJsA6nYu/RSiUq82kwscoXn1KIzqsYRrQDy9PmyngFhVaE8shO3wyFwgowN7Qd7F8atEre4V67sFW/DReDp6nTCM7Kr7KIKuiBOkJqW3PSCHG9Tmzu1MgbDf5jxT+EZ82dXCNJ6iy/LAtACl/d9xNM9T8uYdrqkEnFR+hLR9E9cqEqD8QjvbZRspQFGppRetAiK1VAi+eyDvIxkzozGCIuWuiEnz126PLqE39Gcf1tv8Z+0e1vtA7ZEEPLKrf7tVQTs6u13ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MNcDX82jWP4U6NsTo+BBnFp9IET4KxSyqBpU1lBTWX5+gsQABiPlEhIMbTdLaUsH3T1BY384woo5qDCPtD9emD2p5t/fgeSwUPmLr4d8RkchoyIsdwKdAsgI0vqA4ZN6WuAPpBPCIElyy21j6rScmtyS9WC+y++GEYjth3wFa49cKzhaHdPypKyujC5sLEbWNPlezhD9kWcharf9dOBC741BvT+t+S1I4uy5/tqIe2xYhAhBFRN4efak4Nij9YjkNDnwC/TLs2rPggIDn8NiFJKo2Rub7byIOJVbbYGcQsO9RZbg97YLfKiJ6ddZGr60oy+y/Rtzc58ZuzTUUdwJ4AoldiNje0nJtlB/E/1btSWxQ8ZgumnjdPecM5XYKkzfbY/w7ZknsfhyYYFYmbG6fXktJZZhMAJIB5OLKjfWQA3KB9hsvau/BemM9X8A7pXZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:34:21.4084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2204a7c-8b3c-4cdd-64ea-08ded21f355f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
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

This change allows amdgpu_amdkfd_gpuvm_map_bo_to_kernel() to pin buffers
in either GTT or VRAM based on caller specification, providing flexibility
for different memory placement requirements across various kernel buffers.

The domain parameter accepts AMDGPU_GEM_DOMAIN_GTT, AMDGPU_GEM_DOMAIN_VRAM,
or their combination (GTT|VRAM) to let amdgpu_bo_pin() choose the optimal
placement via amdgpu_bo_get_preferred_domain(). This flexible validation
allows callers to specify their preference while delegating final placement
decisions to the driver when appropriate.

CPU visibility is automatically enforced by amdgpu_bo_pin() regardless of
the domain parameter (see amdgpu_bo_pin() line 975-976 which sets
AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED for kernel mappings).

-v3: update amdgpu_amdkfd_gpuvm_map_bo_to_kernel description

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Vladimir Indic <vladimir.indic@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  6 +++---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 +++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  5 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 11 +++++-----
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 5b49fa50a47d..338412a750ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -336,9 +336,9 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 int amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct kgd_mem *mem, void *drm_priv);
 int amdgpu_amdkfd_gpuvm_sync_memory(
 		struct amdgpu_device *adev, struct kgd_mem *mem, bool intr);
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
-					     void **kptr, uint64_t *size);
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
+int amdgpu_amdkfd_gpuvm_map_bo_to_kernel(struct kgd_mem *mem, void **kptr,
+					 u64 *size, u32 domain);
+void amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(struct kgd_mem *mem);
 
 int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo_gart);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 5bb3e28441a5..6186ac90abe1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2271,11 +2271,14 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo
 	return ret;
 }
 
-/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Map a GTT BO for kernel CPU access
+/** amdgpu_amdkfd_gpuvm_map_bo_to_kernel() - Map GTT or VRAM BO for kernel CPU access
  *
  * @mem: Buffer object to be mapped for CPU access
  * @kptr[out]: pointer in kernel CPU address space
  * @size[out]: size of the buffer
+ * @domain[IN]: domain for pinning (AMDGPU_GEM_DOMAIN_GTT, AMDGPU_GEM_DOMAIN_VRAM,
+ *              or their combination to let the driver choose). CPU visibility is
+ *              automatically enforced by amdgpu_bo_pin()
  *
  * Pins the BO and maps it for kernel CPU access. The eviction fence is removed
  * from the BO, since pinned BOs cannot be evicted. The bo must remain on the
@@ -2284,8 +2287,8 @@ int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_bo *bo, struct amdgpu_bo **bo
  *
  * Return: 0 on success, error code on failure
  */
-int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
-					     void **kptr, uint64_t *size)
+int amdgpu_amdkfd_gpuvm_map_bo_to_kernel(struct kgd_mem *mem, void **kptr,
+					 u64 *size, u32 domain)
 {
 	int ret;
 	struct amdgpu_bo *bo = mem->bo;
@@ -2295,6 +2298,11 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 		return -EINVAL;
 	}
 
+	if (!(domain & (AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM))) {
+		pr_debug("Invalid domain 0x%x for kernel mapping\n", domain);
+		return -EINVAL;
+	}
+
 	mutex_lock(&mem->process_info->lock);
 
 	ret = amdgpu_bo_reserve(bo, true);
@@ -2303,7 +2311,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 		goto bo_reserve_failed;
 	}
 
-	ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
+	ret = amdgpu_bo_pin(bo, domain);
 	if (ret) {
 		pr_err("Failed to pin bo. ret %d\n", ret);
 		goto pin_failed;
@@ -2336,7 +2344,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
 	return ret;
 }
 
-/** amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel() - Unmap a GTT BO for kernel CPU access
+/** amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel() - Unmap GTT or VRAM BO for kernel CPU access
  *
  * @mem: Buffer object to be unmapped for CPU access
  *
@@ -2344,7 +2352,7 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem *mem,
  * eviction fence, so this function should only be used for cleanup before the
  * BO is destroyed.
  */
-void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
+void amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(struct kgd_mem *mem)
 {
 	struct amdgpu_bo *bo = mem->bo;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 3ffe9a52f3e1..7319203e3541 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -314,7 +314,8 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 		return -EINVAL;
 	}
 
-	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(mem, &kern_addr, &size);
+	err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel(mem, &kern_addr, &size,
+						   AMDGPU_GEM_DOMAIN_GTT);
 	if (err) {
 		pr_err("Failed to map event page to kernel\n");
 		return err;
@@ -323,7 +324,7 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 	err = kfd_event_page_set(p, kern_addr, size, event_page_offset);
 	if (err) {
 		pr_err("Failed to set event page\n");
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
+		amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
 		return err;
 	}
 	return err;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 71b36a4613fa..08f6db864bf9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -736,7 +736,7 @@ static void kfd_process_free_gpuvm(struct kgd_mem *mem,
 	struct kfd_node *dev = pdd->dev;
 
 	if (kptr && *kptr) {
-		amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
+		amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
 		*kptr = NULL;
 	}
 
@@ -776,10 +776,11 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	}
 
 	if (kptr) {
-		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(
-				(struct kgd_mem *)*mem, kptr, NULL);
+		err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel((struct kgd_mem *)*mem,
+							   kptr, NULL,
+							   AMDGPU_GEM_DOMAIN_GTT);
 		if (err) {
-			pr_debug("Map GTT BO to kernel failed\n");
+			pr_debug("Map BO to kernel failed err %d\n", err);
 			goto sync_memory_failed;
 		}
 	}
@@ -1140,7 +1141,7 @@ static void kfd_process_kunmap_signal_bo(struct kfd_process *p)
 	if (!mem)
 		goto out;
 
-	amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(mem);
+	amdgpu_amdkfd_gpuvm_unmap_bo_from_kernel(mem);
 
 out:
 	mutex_unlock(&p->mutex);
-- 
2.43.0

