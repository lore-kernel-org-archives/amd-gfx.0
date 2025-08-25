Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7788CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 19:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F8C10E546;
	Mon, 25 Aug 2025 19:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hjYPHMTd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12EBD10E545
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 19:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYm0cNZRQo+EpeQs8jOLASbtycCR6LslNbZSgfXGUCspUXqixC1Pcs6/zHenrAFuqezOM8vfGNyQxiHmMCzbPzTDQ+V6D7shc1VAZk/OhhqryYFe3yIAHjr/y/jZpJJtL7HRu44O1GqNvynEcUr7AykQx3f/NDMu6j7Dby0CjtJzaEiNqn/76vntFVctpBT9i2Zm132af3d3mC5nXnBhJKZRTZY7Ji+mNHxQPX4N5lIyFki5WL4sZAkEHluBTrulji0YYluhQVUMeEpakygWM4IR42QVVzPn9AHLtceb105mp4ejqcK11npuugBqaZJ6gXFqIT0KXVCZW5Jhq/WBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcvEgbTojtA1KcJbi4kVZYQ4D1GhgZb1sQnWTEiAsh0=;
 b=RLodCUPxzU3amYfuv5gFOnnsIz/+KZZ4USxSKSF8QDUY3xGWa7INi6gmZt4BjX0XUSPPcWaQ3aEtnhV0uJY7auL6mlwiJJuMlsduyZvauQ4jdE0eraGcRDxyc9BWU5/11O0ULUxX6BMqNZQjV0xYSbkzonFvnFWFX4SVriRRkbhoX86K4IOoz8G2herYyHy3dtPTRrXHefpJQZYwx6xRhsOiT7KRMtpYB0kRdU22gRn0fNY+XSdtf02GQ3LlZaxnUJ660UbFPKNcn1eXoASVhCxAF0k0JZ4zs7kzLlTEFSV481DVz9Pz3o4haX0oLqb5d4dLZg+7Hbr8ll2a7vWwcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcvEgbTojtA1KcJbi4kVZYQ4D1GhgZb1sQnWTEiAsh0=;
 b=hjYPHMTdq17sH7iZUz6n1gZbVuhU/56mqyOyy8PZnBfeNPOK/rKo+5UChmEBJ+sN2uKUCGJ17/30ZsCc7LYR0g/ZtZbRb7Ip3NHOj+7gOv6bOmd8Y9YGfjalwcXm0JT5ubLnVIwW0bF3VFs2HPwtxbZFbidO4KKn+WMDVU2NmGo=
Received: from BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49) by
 DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Mon, 25 Aug 2025 19:49:59 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::19) by BYAPR01CA0072.outlook.office365.com
 (2603:10b6:a03:94::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Mon,
 25 Aug 2025 19:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Mon, 25 Aug 2025 19:49:58 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 14:49:57 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <simona@ffwll.ch>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v16 3/4] drm/amdgpu: Add mapping info option for GEM_OP ioctl
Date: Mon, 25 Aug 2025 15:49:35 -0400
Message-ID: <20250825194936.899825-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825194936.899825-1-David.Francis@amd.com>
References: <20250825194936.899825-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 33491090-3cea-4976-a182-08dde41092a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eR6mP8u4rbGz0/ZCOuyrkcNBIXth3pS6EsyyVbMV5I3uQf5v3T4YsO2XVuYw?=
 =?us-ascii?Q?hM7pXVEibp/9yVLETsKGaU7+35njLgLc8tYUzXjcEkVl7LCGh59+2em6n07b?=
 =?us-ascii?Q?Mkw70O0f8v9xfMAyXlmvo6QA8L7MqgRmZNYfqHru/wvgrHMre8cI9aJRi8fD?=
 =?us-ascii?Q?s2XlPHJVV2fXaiChBN5k2qQrtpKaGxK53z6V5AnvmfFc0rQ/VDZZ5eF5bITF?=
 =?us-ascii?Q?2/B7keodRqoxr1IgDEuDNaWj+mXJdKPMSnhNGm/BYatVP+boOuBslUCn5EKp?=
 =?us-ascii?Q?M6As08drDbescUd5xUEY8hjl/iOnj+k9UxFHV8k6FUQgnBuMzpKiTM4FM36C?=
 =?us-ascii?Q?TP1VjNDLPrgCRa0zO1e3K0t88XrBWSGz7zWkZNcGy+A8eSqheUo21BzG3j6z?=
 =?us-ascii?Q?zXy315QMk+aVC1mfXBZxCaUfmhHL2PikzT0YF82wf+uqA59w7QgKYnAK87K9?=
 =?us-ascii?Q?6uxjWMEyAxqjv+uO3vQRiT/mJcqqSoBKRUruE+Zy+4+wsxdKw4TX966nVbLv?=
 =?us-ascii?Q?dqdB7zJauTzSguk8fy8GOZwIDQb+DdQOS7J8Chbw/cDpTWjejgRzh4LdFD2U?=
 =?us-ascii?Q?BFcZsxmnqpXGb3AHWuobuEabzSfpoHGVe/iLggNn23z0i6mm3aCsC8N2GVr4?=
 =?us-ascii?Q?Z+UMqNlHs9T1/Ix3FgdSvg9tfiB5yOPIuFPW4wPLGQ3S4va5CHKaWGyy/q/t?=
 =?us-ascii?Q?6Aa5z55lvuDbuw/nWQVYTlHXw2R7rzX/ESgwuQKXhedstmp+/37/b/SnGkyv?=
 =?us-ascii?Q?m0zaslFCVAXrTEM6kg3NxRakzjlAE6LCgDC/Bbg3kgGHgMxGmyImogQbowez?=
 =?us-ascii?Q?vcFctTtpG2rFw0bQ5BYLqJyuDXGAniIAT10fatfVSrGQu/1aGItyhiZqDH7x?=
 =?us-ascii?Q?aK4gjlREEZJsOY4FLW5MZE+jnSRu9c8RI510D2T0BqgLZvVOO5pm6XlFI4Iy?=
 =?us-ascii?Q?Bo4AiA2e2AD64nv3uSy5SwWUCNcJ70EIo+lSxAH7sCDozb2t186NNRFd8Vfo?=
 =?us-ascii?Q?c/fAEM6dZprK/YaPbw0ALjBzzUHd1gdWv9hTBnMVbczqvcWYEzW+uMz4shTx?=
 =?us-ascii?Q?QyRZfJjf/MG4d6rY1fmIop8gBFzPM9U4kUcymyj41vTKX0eO2KyIpUPZ5M89?=
 =?us-ascii?Q?R+wExRW3q6LlnN5A4BDLsskQL2aF/3kXAg62o4edZ9N6julyMbqur9Ekg6qJ?=
 =?us-ascii?Q?guuUB9MxBMj/My2jGyUU4W1KJjYhnNuZzeP9aKDibg7z/LBN+FhFxV2yAWOq?=
 =?us-ascii?Q?1n8Hf5UEcTTTtjCA9JTSTZQAS8UpPeaMFuMrkuq3jGKD9bTck5bnNDlc1rwc?=
 =?us-ascii?Q?j8xGo5UlTyhcV053PEvv/FjIxxdy5Fr8y2Ma66EHryHjcKwz0c8iGHCWxkIX?=
 =?us-ascii?Q?qoiGR2FlUXbt3kcTqv6VckUe5HB3G8V8LTCJu011V6G5rzg2aycsviBGn5fq?=
 =?us-ascii?Q?euWg9y1JOiSqJQohXy1RDquB39YQ77/S/XKaFf+GGWhAbN3icJqwSUH+qpcA?=
 =?us-ascii?Q?kEHCLkzkwI2w0EFI3gZSlxM7APSPUl0dig2L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:49:58.5813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33491090-3cea-4976-a182-08dde41092a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683
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

Add new GEM_OP_IOCTL option GET_MAPPING_INFO, which
returns a list of mappings associated with a given bo, along with
their positions and offsets.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 84 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
 include/uapi/drm/amdgpu_drm.h           | 21 ++++++-
 3 files changed, 100 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e6741d6c9a55..86d14f3542e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -955,17 +955,34 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
 	struct amdgpu_bo *robj;
+	struct drm_exec exec;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	int r;
 
+	if (args->padding)
+		return -EINVAL;
+
 	gobj = drm_gem_object_lookup(filp, args->handle);
 	if (!gobj)
 		return -ENOENT;
 
 	robj = gem_to_amdgpu_bo(gobj);
 
-	r = amdgpu_bo_reserve(robj, false);
-	if (unlikely(r))
-		goto out;
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
+			  DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_lock_obj(&exec, gobj);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto out_exec;
+
+		if (args->op == AMDGPU_GEM_OP_GET_MAPPING_INFO) {
+			r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
+			drm_exec_retry_on_contention(&exec);
+			if (r)
+				goto out_exec;
+		}
+	}
 
 	switch (args->op) {
 	case AMDGPU_GEM_OP_GET_GEM_CREATE_INFO: {
@@ -976,7 +993,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		info.alignment = robj->tbo.page_alignment << PAGE_SHIFT;
 		info.domains = robj->preferred_domains;
 		info.domain_flags = robj->flags;
-		amdgpu_bo_unreserve(robj);
+		drm_exec_fini(&exec);
 		if (copy_to_user(out, &info, sizeof(info)))
 			r = -EFAULT;
 		break;
@@ -985,19 +1002,19 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		if (drm_gem_is_imported(&robj->tbo.base) &&
 		    args->value & AMDGPU_GEM_DOMAIN_VRAM) {
 			r = -EINVAL;
-			amdgpu_bo_unreserve(robj);
+			drm_exec_fini(&exec);
 			break;
 		}
 		if (amdgpu_ttm_tt_get_usermm(robj->tbo.ttm)) {
 			r = -EPERM;
-			amdgpu_bo_unreserve(robj);
+			drm_exec_fini(&exec);
 			break;
 		}
 		for (base = robj->vm_bo; base; base = base->next)
 			if (amdgpu_xgmi_same_hive(amdgpu_ttm_adev(robj->tbo.bdev),
 				amdgpu_ttm_adev(base->vm->root.bo->tbo.bdev))) {
 				r = -EINVAL;
-				amdgpu_bo_unreserve(robj);
+				drm_exec_fini(&exec);
 				goto out;
 			}
 
@@ -1011,17 +1028,66 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
 		if (robj->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID)
 			amdgpu_vm_bo_invalidate(robj, true);
+		drm_exec_fini(&exec);
+		break;
+	case AMDGPU_GEM_OP_GET_MAPPING_INFO: {
+		struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(&fpriv->vm, robj);
+		struct drm_amdgpu_gem_vm_entry *vm_entries;
+		struct amdgpu_bo_va_mapping *mapping;
+		int num_mappings = 0;
+		/*
+		 * num_entries is set as an input to the size of the user-allocated array of
+		 * drm_amdgpu_gem_vm_entry stored at args->value.
+		 * num_entries is sent back as output as the number of mappings the bo has.
+		 * If that number is larger than the size of the array, the ioctl must
+		 * be retried.
+		 */
+		vm_entries = kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL);
+		if (!vm_entries)
+			return -ENOMEM;
+
+		amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
+			if (num_mappings < args->num_entries) {
+				vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
+				vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
+				vm_entries[num_mappings].offset = mapping->offset;
+				vm_entries[num_mappings].flags = mapping->flags;
+			}
+			num_mappings += 1;
+		}
+
+		amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
+			if (num_mappings < args->num_entries) {
+				vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
+				vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
+				vm_entries[num_mappings].offset = mapping->offset;
+				vm_entries[num_mappings].flags = mapping->flags;
+			}
+			num_mappings += 1;
+		}
 
-		amdgpu_bo_unreserve(robj);
+		drm_exec_fini(&exec);
+
+		if (num_mappings > 0 && num_mappings <= args->num_entries)
+			r = copy_to_user(u64_to_user_ptr(args->value), vm_entries, num_mappings * sizeof(*vm_entries));
+
+		args->num_entries = num_mappings;
+
+		kvfree(vm_entries);
 		break;
+	}
 	default:
-		amdgpu_bo_unreserve(robj);
+		drm_exec_fini(&exec);
 		r = -EINVAL;
 	}
 
 out:
 	drm_gem_object_put(gobj);
 	return r;
+out_exec:
+	drm_exec_fini(&exec);
+	drm_gem_object_put(gobj);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f9549f6b3d1f..5a63ae490b0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -668,4 +668,9 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
 				 struct amdgpu_vm *vm,
 				 struct dma_fence **fence);
 
+#define amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) \
+		list_for_each_entry(mapping, &bo_va->valids, list)
+#define amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
+		list_for_each_entry(mapping, &bo_va->invalids, list)
+
 #endif
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 902e30263fcc..9cebd072a042 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -802,6 +802,21 @@ union drm_amdgpu_wait_fences {
 
 #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
 #define AMDGPU_GEM_OP_SET_PLACEMENT		1
+#define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
+
+struct drm_amdgpu_gem_vm_entry {
+	/* Start of mapping (in bytes) */
+	__u64 addr;
+
+	/* Size of mapping (in bytes) */
+	__u64 size;
+
+	/* Mapping offset */
+	__u64 offset;
+
+	/* flags needed to recreate mapping */
+	__u64 flags;
+};
 
 /* Sets or returns a value associated with a buffer. */
 struct drm_amdgpu_gem_op {
@@ -809,8 +824,12 @@ struct drm_amdgpu_gem_op {
 	__u32	handle;
 	/** AMDGPU_GEM_OP_* */
 	__u32	op;
-	/** Input or return value */
+	/** Input or return value. For MAPPING_INFO op: pointer to array of struct drm_amdgpu_gem_vm_entry */
 	__u64	value;
+	/** For MAPPING_INFO op: number of mappings (in/out) */
+	__u32	num_entries;
+
+	__u32	padding;
 };
 
 #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
-- 
2.34.1

