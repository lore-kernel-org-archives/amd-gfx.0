Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045A5CD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 06:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E53610E94E;
	Wed, 17 Jun 2026 06:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q9fzB5rA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C9910E94E
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 06:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZnK7YExyyUND5SPuZVciCiBuSfSiIaO6eDa59mKfTTAtRuEyylyemNclXKoyIcz5VjBxx3W7NWarUECgQN8XVNNxddDUYmDEtskdhL8V7dEqKSll6pXUafD0jFUav2WViiX7iHt+jVOnG2cpXR8BT6y78k9ucMtoQ1cHTMrJR7D4GXHon37QyTH4cXvie32DWGANPq3K6qHggugePf1ZWWqY31HIi4sGpbz/qKLt9PONYtJWQCbqTLdGgul02evB13fzr2c8Q3xZHQ5IAR9amQmknDGP/5ZT3+vf4YHLUj/U8IxBBBs4zMWdg9CIfEoxRhClz6jHqTTodO253bTew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgL4nO/gGzxLPdyDJB6kClNsyoMQX0ApjfqyPhdvHIE=;
 b=VNMvbkLhOUrNn8IcNkbYpYxTBEycp2iWqSX4mvMjdDsmkQToR7mg1/VtiUWLRhZUiIcJXgGMOHxQTmUrew8e41spoQ+z6N9SEwxO3yrU/+JR4bVO0tzv7RhEH6W9Enhb5ziAoFTdyQnw6Kpq9+AKLVy9bpvlGXqxolmTz1sPGf/eUlqx3hxnbgdc0PDquULY0s42S+FDeZfnc0B+/F/gvFyZpUJjbn7KjWuGVjjozjECnvvCF1zgavz3IByVItfnxDopTiFPPNpXOLD9SY6nsPefz5mI+0MaEIIHiQDiF99sNCbf/6wvi+lyaPJEvWnf2oNcRNOcFSPuKSKsWOawGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgL4nO/gGzxLPdyDJB6kClNsyoMQX0ApjfqyPhdvHIE=;
 b=Q9fzB5rAbUXx4Pop4R+/wF1EXp+Sg2UbNjzNvKIA2i6guC+Pto53CJ9uUtXU2OOq8Lgl80HoJmcUL8a6NY1HoL6wsy+RiSxAuKXuPpzW0mY3zLr/GoGfIgXKqe5r7Vl9f46+KNtQB7pRd29GHXoIyPGnbde9ChohWTk9u4YF0t8=
Received: from MN0P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::23)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 06:55:07 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::98) by MN0P221CA0010.outlook.office365.com
 (2603:10b6:208:52a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Wed,
 17 Jun 2026 06:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 06:55:06 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 01:55:05 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Ray.Huang@amd.com>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] drm/amdgpu: split amdgpu_bo_create_reserved into create and
 map helpers
Date: Wed, 17 Jun 2026 14:54:42 +0800
Message-ID: <20260617065442.16432-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f485069-dfdb-4289-ecf9-08decc3d5d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: du5WdsNFCwh72tJ79kHRxYIrcIiXiYN5Pv7MfI+Rt/Yez7MZ9Dtz15DKEI7uD5aV9Pd2sfrRXgADNue98hAwsxO8wKosjPLYMFXQyPrcRynRZkq0MM0Uf5UbKphwI95jJfxeGEEEMu3lVJfef1CUtBdYnLroiJOh1QNetsFBu4AOqyUyUlMoKe89A3Luqm3xkSq4IpcUYd+DnTt9uJrZoLVkT3QAn/gqziimeCYu6hwcTMuD4E4vXO90U/F4cbODeBavwqVOHlrv63do8LT4oyPWXGzjU0sZ4njqKlyhW9XSdg//aWcccvQVx2RvLypVs4+UYkGiGCnNM8sOW3NAD0P/REmweEzNrc/cJnD9VdAe+x+K12zmCb9mQrZQ/CvmJfaLyNgi8sphO6MX1flmROmAjVFERXJxEUdz1LC0EAC7ZRpRfOWWSVn6aPa5yoCggJstUIbg4Bq3ihrFQP4j1C/LHdcXNVzbkbVSXODVP16KSHs4Ypd/1bn6AUFrYuKW+77h3E3DECLvVSwwg6ujskmzvVT/k3YpTLo5bLKam1r52q8q0N8T46HxzQ4Qwk7Y07xMj0Dq/oCCezYZZ2z3ZrGLf+QdqbfDjlESjBFubvaowFtiHIsUu1ZlkIMzfUICgg2Ahjil+SV/plveuqW5x+/oV1YVH27y5BHED61BEzGo6PXg/9u3go33VQPD+bGabRTVOfxV2JoD0md4xMRgqG3HXqJbLl2oMsFkhj/uAQc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T5xGMz1GNZOMTGae4Opb+aCSLsQG45g9+vDVUasQV3dYjfePDys8/q3Z1pzvjmD+qt3W5VuIeV7u6sruvf1t6YoBv5+kx2K6SFItvfyGgioUYIR4LV8GMR0ye98e8JWv9a1U0252Qi/K4PhLy8Yfs6jV7MQoDNIdGokemcx8steWzPXPVRnJBXTKxBV/Ch0Ct4b7Px5Ag+nAEXM8L0w58Ypb52PUv2SYSY4ZkO/VTbt6j3o+49/jVTqx8509P85lOYpt3JHyu2/1oFhmziOWPwwzl7X4P6GipBO4rcO04GLE0lHkM8yqhxY123SLmMIXx2iYOgpFSHaTMwGRgzOa2OUuQ0Oa0g9F6mKpxc4e4PMQQlRBjKAJTgYZnoXbFT3k69wzspNuDNiesZ2qebLSNqHMwOqEAY8VRdwNVQTahHr4KQm4BV6ZRVgzRu3Y9+9N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:55:06.8678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f485069-dfdb-4289-ecf9-08decc3d5d9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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

amdgpu_bo_create_reserved() only allocates a new BO when
*bo_ptr (struct amdgpu_bo **bo_ptr as input parameter) is
NULL, it simply skips creation when *bo_ptr is non-NULL.
But it unconditionally reserves, pins, gart allocates
and maps the BO afterwards.

When the same non-NULL BO pointer is passed in again,
for example firmware buffers that live in adev and are
re-loaded on every resume / cp_resume / start
under AMDGPU_FW_LOAD_DIRECT, amdgpu_bo_pin() just increases
pin_count unconditionally, however the matching teardown only unpins
once, so pin_count never drops to zero, so TTM is not able
to move, swap or evict a BO, causing BO leaks.

Ideally the BO should only be pinned once at creation. So this commit
splits current amdgpu_bo_create_reserved() into two helpers:

 - amdgpu_bo_create_pinned(): create + reserve + pin + alloc_gart and
   return the BO unreserved. It requires *bo_ptr == NULL on entry,
   so only pins the BO once.

 - amdgpu_bo_get_access(): reserve + map gpu/cpu addr + unreserve.
   This function is idempotent and is safe to call multiple times
   on an existing pinned BO, for example, on every resume path.

amdgpu_bo_create_reserved() now calls amdgpu_bo_create_pinned()
only when *bo_ptr is NULL, then calls amdgpu_bo_get_access() for
CPU/GPU address mapping, and reserves the BO before returning.
Repeated calls no longer take additional pin references.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 175 +++++++++++++++++----
 1 file changed, 143 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4dd7c712b8c3..dd0a59137028 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -217,57 +217,53 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 }
 
 /**
- * amdgpu_bo_create_reserved - create reserved BO for kernel use
+ * amdgpu_bo_create_pinned - create and pin a BO for kernel use
  *
  * @adev: amdgpu device object
  * @size: size for the new BO
  * @align: alignment for the new BO
  * @domain: where to place it
- * @bo_ptr: used to initialize BOs in structures
- * @gpu_addr: GPU addr of the pinned BO
- * @cpu_addr: optional CPU address mapping
+ * @bo_ptr: used to return the newly created BO, must point to NULL on entry
+ * @cpu_access: true if the BO needs to be CPU accessible
  *
- * Allocates and pins a BO for kernel internal use, and returns it still
- * reserved.
+ * Allocates and pins a BO for kernel internal use, and returns it unreserved
  *
- * Note: For bo_ptr new BO is only created if bo_ptr points to NULL.
+ * Note: *bo_ptr must be NULL on entry, this helper always creates
+ * a new BO and never reuses an existing one,
+ * so it never pins the same BO twice.
  *
  * Returns:
  * 0 on success, negative error code otherwise.
  */
-int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
-			      unsigned long size, int align,
-			      u32 domain, struct amdgpu_bo **bo_ptr,
-			      u64 *gpu_addr, void **cpu_addr)
+static int amdgpu_bo_create_pinned(struct amdgpu_device *adev,
+				   unsigned long size, int align,
+				   u32 domain, struct amdgpu_bo **bo_ptr,
+				   bool cpu_access)
 {
 	struct amdgpu_bo_param bp;
-	bool free = false;
 	int r;
 
-	if (!size) {
-		amdgpu_bo_unref(bo_ptr);
-		return 0;
-	}
+	if (WARN_ON(!bo_ptr || *bo_ptr))
+		return -EINVAL;
+
+	if (WARN_ON(!size))
+		return -EINVAL;
 
 	memset(&bp, 0, sizeof(bp));
 	bp.size = size;
 	bp.byte_align = align;
 	bp.domain = domain;
-	bp.flags = cpu_addr ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
+	bp.flags = cpu_access ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
 		: AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	bp.flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 
-	if (!*bo_ptr) {
-		r = amdgpu_bo_create(adev, &bp, bo_ptr);
-		if (r) {
-			dev_err(adev->dev, "(%d) failed to allocate kernel bo\n",
-				r);
-			return r;
-		}
-		free = true;
+	r = amdgpu_bo_create(adev, &bp, bo_ptr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to allocate kernel bo\n", r);
+		return r;
 	}
 
 	r = amdgpu_bo_reserve(*bo_ptr, false);
@@ -288,27 +284,142 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 		goto error_unpin;
 	}
 
+	amdgpu_bo_unreserve(*bo_ptr);
+	return 0;
+
+error_unpin:
+	amdgpu_bo_unpin(*bo_ptr);
+error_unreserve:
+	amdgpu_bo_unreserve(*bo_ptr);
+error_free:
+	amdgpu_bo_unref(bo_ptr);
+	return r;
+}
+
+/**
+ * amdgpu_bo_get_access - get CPU/GPU access to a BO
+ *
+ * @bo: the input BO, must be pinned
+ * @gpu_addr: optional, returns the GPU address of the BO
+ * @cpu_addr: optional, returns the CPU address of the BO
+ *
+ * Note: *bo must be already pinned!
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+static int amdgpu_bo_get_access(struct amdgpu_bo *bo, u64 *gpu_addr,
+				void **cpu_addr)
+{
+	struct amdgpu_device *adev;
+	int r;
+
+	if (WARN_ON(!bo))
+		return -EINVAL;
+
+	adev = amdgpu_ttm_adev(bo->tbo.bdev);
+
+	r = amdgpu_bo_reserve(bo, false);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to reserve kernel bo\n", r);
+		return r;
+	}
+
+	/*
+	 * The BO must already be pinned. A GPU or CPU address of an
+	 * unpinned BO would become meaningless because TTM
+	 * may then move or evict it at any time.
+	 */
+	if (WARN_ON_ONCE(!bo->tbo.pin_count)) {
+		r = -EINVAL;
+		goto error_unreserve;
+	}
+
 	if (gpu_addr)
-		*gpu_addr = amdgpu_bo_gpu_offset(*bo_ptr);
+		*gpu_addr = amdgpu_bo_gpu_offset(bo);
 
 	if (cpu_addr) {
-		r = amdgpu_bo_kmap(*bo_ptr, cpu_addr);
+		r = amdgpu_bo_kmap(bo, cpu_addr);
 		if (r) {
 			dev_err(adev->dev, "(%d) kernel bo map failed\n", r);
-			goto error_unpin;
+			goto error_unreserve;
 		}
 	}
 
+	amdgpu_bo_unreserve(bo);
 	return 0;
 
-error_unpin:
-	amdgpu_bo_unpin(*bo_ptr);
 error_unreserve:
-	amdgpu_bo_unreserve(*bo_ptr);
+	amdgpu_bo_unreserve(bo);
+	return r;
+}
+
+/**
+ * amdgpu_bo_create_reserved - create reserved BO for kernel use
+ *
+ * @adev: amdgpu device object
+ * @size: size for the new BO
+ * @align: alignment for the new BO
+ * @domain: where to place it
+ * @bo_ptr: used to initialize BOs in structures
+ * @gpu_addr: GPU addr of the pinned BO
+ * @cpu_addr: optional CPU address mapping
+ *
+ * Allocates and pins a BO for kernel internal use, and returns it still
+ * reserved.
+ *
+ * Note: For bo_ptr new BO is only created if bo_ptr points to NULL. An
+ * existing BO is only re-accessed (get CPU/GPU mapping) and not pinned again,
+ * so repeated calls with the same BO do not leak pin references.
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
+			      unsigned long size, int align,
+			      u32 domain, struct amdgpu_bo **bo_ptr,
+			      u64 *gpu_addr, void **cpu_addr)
+{
+	bool created = false;
+	int r;
+
+	if (WARN_ON(!bo_ptr))
+		return -EINVAL;
+
+	if (!size) {
+		amdgpu_bo_unref(bo_ptr);
+		return 0;
+	}
+
+	if (!*bo_ptr) {
+		r = amdgpu_bo_create_pinned(adev, size, align, domain, bo_ptr,
+					    !!cpu_addr);
+		if (r)
+			return r;
+		created = true;
+	}
+
+	r = amdgpu_bo_get_access(*bo_ptr, gpu_addr, cpu_addr);
+	if (r)
+		goto error_free;
+
+	r = amdgpu_bo_reserve(*bo_ptr, false);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to reserve kernel bo\n", r);
+		goto error_free;
+	}
+
+	return 0;
 
 error_free:
-	if (free)
+	if (created) {
+		if (amdgpu_bo_reserve(*bo_ptr, true) == 0) {
+			amdgpu_bo_kunmap(*bo_ptr);
+			amdgpu_bo_unpin(*bo_ptr);
+			amdgpu_bo_unreserve(*bo_ptr);
+		}
 		amdgpu_bo_unref(bo_ptr);
+	}
 
 	return r;
 }
-- 
2.54.0

