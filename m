Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7BF606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EoqcLUh0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3565310F844;
	Wed, 21 Oct 2026 01:59:54 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE4010F860
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 01:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3EGBJrlttSQjlrrBl6tDYBs1rlQ8lmNYGESdnCXsp9FAZYv1x3na+EVeBdUpkedOnCVNPqOXnIsD2os2ujvRUVY7+cwUNNUK8ztmYhALq7V32pD7B/nN7rC/X8cEuQYKSWgcAva9OO4rD2wBGbsJ0A/j90iIleSXg/Q/FMU/oPC0a3Zd8nGhSsId/PIrwnyx5tTNgAWN89T2756GnkQmikqbGLmvjHdb75FQClLdGy+m9Z7CvV5re9MtyBZydEtHRaM2mRttsfg/FPyzJb+4EJBit/rMPhEJNJ4wNOc/O2ujPoBmrALFfipxKUPe0+lzNgjfEQjkGuf1Q62jl5VvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKg6PKrSBA+jt37hYMP92p+tVTq5OVrF4yxOMSPzFwY=;
 b=CIrYvKKVGuLhAZGFKc+cCwtsfzA4lzU8D3JaebWxKQKQSAxy9IqXkASm4VopQPEp1X4VumrUxoTiGMJOlCrE7aujbMoUqAMfwxZstvHA9P/dLQEbdZP3GbLcvPO/FDd21FrDKnLhw02Su0sYq2JXztkLDf1hQ2IYilY+5MnsQ0hDg7Us8I7libwW7Y8kQ4vhfuSZLJjyqB1T6yED7ztT6yATmNqX/yyVX7WF7/NzMImbLrzd4TMHAnxGqGLY8FBNb8VhONlw4ks69Jx0MKUKnugOeil7/Sl0TZO0yUEB9Fn1rRokj8XmzWaorI0ZnTD8Emo3ypntoytJmZhL+5GpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKg6PKrSBA+jt37hYMP92p+tVTq5OVrF4yxOMSPzFwY=;
 b=EoqcLUh0C2/bV0n8XYSpuAUOy2SAEIvWCqkmIBiPuuWYiLoYqZSRT62C3EjSJryU5kwfP6834mIZWiM+NQsEnLmLW9enVizu8vV7TawbEr9N7xjPP0zlnUSyh0J4ghX5WdeDrwgkwoLg9m6CdK6uPBgSpQEqD3AXo2WoTU5deuI=
Received: from SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::18)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 01:59:20 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::32) by SJ0P220CA0027.outlook.office365.com
 (2603:10b6:a03:41b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 01:59:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 01:59:20 +0000
Received: from danielhuang-HP-EliteBook-845-14-inch-G10-Notebook-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 20 Oct 2026 20:59:16 -0500
From: Daniel Huang <danielhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Daniel Huang <danielhu@amd.com>
Subject: [PATCH v4 1/2] drm/amdkfd: disable SVM when the GPUVM cannot cover
 CPU addresses
Date: Wed, 21 Oct 2026 17:59:05 +0800
Message-ID: <20261021095906.48630-2-danielhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021095906.48630-1-danielhu@amd.com>
References: <20261021095906.48630-1-danielhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 51372792-1e5c-41aa-2d0f-08df2f16ebc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003|3023799007|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: 8vjQOuXLnKeux84YrCEGmttxj8bD+ZOXna/PDQsOGiGegDQ3CXt+VWWua5s4QfBC1p2iDuNw8cHDsE0GoZqr5v3gkuqswfFHFrG60uyxuOJWH5eOd5C95l0HqTDd11D+v5bMlHK//WOHlAbn5scJIG+bIiWLmTz5pWyA0B0Q5P5rbr8WalqOM7f7ehLDKINoeMQ5E+h6DaZhwwXwzratBQowOQ+jrPL65xP39quOgzjli53ETAoH05RL2gPl4yojIuxh/0AMcvzJYVW2r4TxmkMfTzAI4Ug/RJU3qGUZtfNus8SE+emwldOWr7pHdw37yH+m0bgj/eEZ6XYRWnHET//vKOdNxhBMnTxzxXa2wb+h4mn5DqJ158ek0786avyDuZDUAn3IZ5auDv1a8kRO5FtwJnAsVGd39/IIcW3SjvvzQ7PeUKfu7bWgsmuo30sEUKQaU7ABtR3ewIiBmNqOQZnQANN7VOmv3B3oOUiQwWkzMMCZhTgV0RgKC+ztfwT9GTcp1Q0byV8v08g6mVliZ5FO+6WFo6R6szPdNea2akLr7jNssTkMFy59uE8Kd6ow8UsWyfYl7O9fzzIJUULPk5m6lH8lRT0ey/dihXWIoGyb3GDZfAL70NbqrCI644b64cU+on85fOlQruRT4tAPog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(3023799007)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hNZvR+juMvHoipt4p38bnheL5g4OgGk9a/Hho+n7cjhtJHeJa5x3NidMEz3qqFjzASQPAa0P1SiiduCNjOUoVK7O+3d/r+F6VbJXRowlqrCzPeNJS4xc5J8dDPLsNE0e3BhxgSmPJygUBzq6U5uJXVLhHtbbBdjabMQ9dR2XgpKskjGTFLHsJwaT6Nr3ScWZkIDPxr8SS4o23VCDeWyFjjIuLrAlZIyZ/yqSHyl8oHS/2pcWHRI1ZAefmHTMX7on3c20QX+eSWlWBr+y47Vey5xhMoZm+0RXB/8v3Ao9b0utkVmDTgP+FgQtStR9e0fsJ3xJYLovDx2SHVBcUk5G4kvDwA1U3rheD8b22Lc83uug6NGPmIiGG5e+W+Ga5TcrXitFnF2USBDkDMfULHC3Ux4rWy2b/mNiaTQuow8tAE0kGJgMLLBFWTXzedXOmVn3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 01:59:20.0280 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51372792-1e5c-41aa-2d0f-08df2f16ebc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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
X-Spam-Status: No, score=-22.1 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

KFD SVM maps memory in GPUVM at the same virtual address used by
the CPU. However, svm_range_map_to_gpu() passes the corresponding
PFNs to amdgpu_vm_update_range() without checking them against
vm_manager.max_pfn.

If the GPUVM address range is smaller than the CPU address range,
the page-table walker can index beyond the allocated root page-table
entries. Unlike the SVM path, the BO mapping path validates the
address range through amdgpu_vm_verify_parameters().

Only an explicit amdgpu.vm_size override configures a GPUVM smaller
than the driver would select on its own, and that parameter is meant
for driver testing rather than normal end-user configuration.

Reproduced on a Radeon 780M (gfx1103) with amdgpu.vm_size=64.
Repeated hipMallocManaged() allocations attempted to map CPU
address 0x74bd48000000, well beyond the 64 GiB GPUVM limit.
The out-of-bounds root entry contained SLUB poison with
slub_debug=FZPU and recycled heap data without it, resulting in
a general protection fault:

  RIP: 0010:amdgpu_vm_cpu_update+0x2f/0x140 [amdgpu]
   amdgpu_vm_pte_update_flags+0xfa/0x1e0 [amdgpu]
   amdgpu_vm_ptes_update+0x38b/0xa00 [amdgpu]
   amdgpu_vm_update_range+0x279/0x930 [amdgpu]
   svm_range_map_to_gpu+0x13d/0x400 [amdgpu]
   svm_range_validate_and_map+0x8d3/0xaa0 [amdgpu]
   svm_ioctl+0x66/0x80 [amdgpu]
   kfd_ioctl+0x40a/0x650 [amdgpu]

As discussed in [1], rejecting out-of-range PFNs in
amdgpu_vm_update_range() is too late. SVM must not be initialized
when the GPUVM cannot represent the required CPU addresses.

Prevent this by disabling KFD SVM support when the GPUVM address
range is smaller than AMDGPU_GMC_HOLE_START. This prevents
affected devices from advertising SVM support and excludes them
from SVM mappings. Warn from kfd_update_svm_support_properties(),
which runs after the device memory pgmap is registered, so that
only devices that would otherwise have advertised SVM report the
loss of the capability.

KFD SVM has never been supported before GFXv9: kgd2kfd_init_zone_device()
returns early for GC IP versions below 9.0.1, leaving kfd.pgmap.type at
zero, so KFD_IS_SVM_API_SUPPORTED() is already false and
HSA_CAP_SVMAPI_SUPPORTED is never advertised on GMC v6/v7/v8. The new
condition therefore cannot change behaviour on those generations.

The BO and userptr paths are unaffected. Their GPU virtual address is
chosen by user space independently of the CPU address and validated by
amdgpu_vm_verify_parameters() in amdgpu_vm_bo_map(), so an out of range
address is rejected at map time instead of reaching the page tables.
SVM is the only path whose address is dictated by the CPU mapping.

[1] https://lore.kernel.org/amd-gfx/da43b0e3-5bd9-4aa1-86d3-b733f3bad108@amd.com/

Closes: https://github.com/ROCm/TheRock/issues/9302
Assisted-by: Claude:claude-opus-5
Signed-off-by: Daniel Huang <danielhu@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h      | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 ++++++++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c7d7adae4476..f61030408f45 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -203,11 +203,22 @@ struct kfd_process_device *
 svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node);
 void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
 
+/* SVM uses CPU virtual addresses for GPU mappings. Disable SVM if the GPUVM
+ * address range cannot cover the required CPU address range. The parameter
+ * must be named adev, AMDGPU_GMC_HOLE_START dereferences it.
+ */
+static inline bool kfd_svm_vm_covers_user_va(struct amdgpu_device *adev)
+{
+	return (adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT) >=
+		AMDGPU_GMC_HOLE_START;
+}
+
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
  */
-#define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
-					((adev)->apu_prefer_gtt))
+#define KFD_IS_SVM_API_SUPPORTED(adev)					\
+	(((adev)->kfd.pgmap.type != 0 || (adev)->apu_prefer_gtt) &&	\
+	 kfd_svm_vm_covers_user_va(adev))
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 35b3abe57b80..5d12446b8ea8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2471,8 +2471,17 @@ void kfd_update_svm_support_properties(struct amdgpu_device *adev)
 				sys_props.generation_count++;
 			else
 				dev_err(adev->dev, "Failed to update SVM support properties. ret=%d\n", ret);
-		} else
+		} else {
+#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+			if ((adev->kfd.pgmap.type || adev->apu_prefer_gtt) &&
+			    !kfd_svm_vm_covers_user_va(adev))
+				dev_warn_once(adev->dev,
+					      "GPUVM size 0x%llx is too small for KFD SVM; SVM disabled (amdgpu.vm_size=%d)\n",
+					      adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
+					      amdgpu_vm_size);
+#endif
 			dev->node_props.capability &= ~HSA_CAP_SVMAPI_SUPPORTED;
+		}
 	}
 	up_write(&topology_lock);
 }
-- 
2.53.0

