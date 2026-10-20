Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E124606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 05:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R31ROa4b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB26C10EB71;
	Tue, 20 Oct 2026 05:29:28 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229FE10E7C7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 05:29:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQYlaP09uW4jC7o400QltO/i6fJDro/FgX6RcTVmkanBmBwSuOpgKvI2ybUILp6c3C4AJYee1u3fs2MflUkNNfLZB3QgexQA7Nmn2UHpqcWDh7qBJL34x1psqjKTF3XJKF5dUEd+j8I7Hg2soy+A38TCtxq0SuZpFjbFq+v4lt49EAALJJHZKfnfSc9waTH1YJJ6/RE82RfXTNXvSEHCNGAbL1lX/HMqVCx7T9BpjKVo06aEWzyMQFrtXzyzM+D1CqbR1y3ynlv3GBuC89iK+mmTQ06i0sIPsNa3Gqi4IVADCKmjM6ArrMoPfvQ2MWKmbwdajmKkPK0eDbhjAMEFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=860UXQDCQBgiH2YVRs/X7KIpzpmlYhCh06VPXrQxv1s=;
 b=eOhFEZrHPLZADLKPhkJqV6z29q++U6GLUVRVHJwkN7U2DuSyh5l1CEdL+9xrY0DUqZfmvnDKpvtHS9MrpMQtIEj8FgfJiO66jwZ7cSExv1Vt7IuVAg7kwjdFZgqcizJu5g2uH+P0bLWVQzM749/xAQBgvChEj0l8N2ZAfDXtLS5BK+MIbV+J+srm80b8IdXCyGQpnTO8t0er3CJxVag8ZfNGAIXiX1jRXq5LuKCpOyKs2I5B+s2Knc5DqiNs6TLHxAT9up3zo5Pb+wkc92/6veeYyAyhfZyblkmMShEcoroViZIVNq4j2Z4RuZ8t+xttiNgeJXg5wFOgPv2gq7zhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=860UXQDCQBgiH2YVRs/X7KIpzpmlYhCh06VPXrQxv1s=;
 b=R31ROa4bg1uPFURc8beRKUhuIv2MOZm5InjRkDy7zd/Uv9geLdRR6a/hrsipjgIL+YsKk68X+z1hLVwmy++E6eiQNO2TtmvzHwxPx67OjbUu+eWzjcvvWZ0Icc5DwEjYAKLorzKTyJ0T3Spc8b6TLiBWoq03aaMnVZ0H0Nh3uuE=
Received: from BLAPR03CA0147.namprd03.prod.outlook.com (2603:10b6:208:32e::32)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:29:17 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:208:32e:cafe::84) by BLAPR03CA0147.outlook.office365.com
 (2603:10b6:208:32e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 20
 Oct 2026 05:29:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Tue, 20 Oct 2026 05:29:17 +0000
Received: from danielhuang-HP-EliteBook-845-14-inch-G10-Notebook-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Tue, 20 Oct 2026 00:29:15 -0500
From: Daniel Huang <danielhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Daniel Huang <danielhu@amd.com>
Subject: [PATCH v3 1/2] drm/amdkfd: disable SVM when the GPUVM cannot cover
 CPU addresses
Date: Tue, 20 Oct 2026 21:29:00 +0800
Message-ID: <20261020132901.23157-2-danielhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020132901.23157-1-danielhu@amd.com>
References: <20261020132901.23157-1-danielhu@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: a53dc96e-0500-4d6a-0223-08df2e6b15bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|13003099007|11063799006|261009223027099003|10067099003|22082099003|56012099006|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: ShghVItyr6S0hcuroko7eW9iiwnBxKkg5Lh5/xjVa6xVUS/EH06E6jvRT373eIkJ8U3guG5GbvUYJyWIn7TH8DK4VfLnsYCYGjnzKYIIWLrTQzyWjQhx0NZJ1hPNqdmfsU5/A8/2y6ZJUMx9QU/qIiL9pO6Ob6Yawj7wSME9ugmDGth4BYXL1pii5ppNHz31oxEXKiSLq/jXNe9is1wYSNHBQ5wyczcjDw8dHC+FplALiMb+QhS/Cr/PTKnkGmSHnwQ15oHdQhuo2N/QVvENW8vRTu/LZzPUx7J5adLmqfEJDiTU6HAxJ10O0Al+hIWl8v5Dy5MV2MdebOjR8MagmfItrTZBhSYnqIrqTUBjgcQnz4A8tDYCaMT4zRt3D8lnM9yOdeqFQrM1bsYaXoFgwtPhyHN4wsMA8CMwGqb5DggLZZ4+IvryxI+24tfWKZf1eOiOK4CkXwKaSr1r5q3ZUOd5sA5ZYI+hFqx69+oUF62aCG3B4G4jjmvs9r6YVBQ399Wb5pSJN0VUj7ecY092+kFd5hWeJLBikmNoI6LkdebksBSdr6KWbjc7ZYkon1gFOodd7zY68WLA96pLiNeHE3E/R3FOGCPKuF2irVVzyr5gwkeqazKVOjpiJoWxrLlP0kSmt/lm4SMGIKGf8t3WwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(13003099007)(11063799006)(261009223027099003)(10067099003)(22082099003)(56012099006)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VAWu/nrSpEilyDwRpId5QxAISZ7jLkfQqlkkZxFhGUPh/qQStnCFOGGy8l3my2ELXmY0fO3jDLecYBEp8fVq/cRRsuBl8jOgy7w5DVqswYTHlJFtqKP3jUi3+6SPob1VfbXtNUZp+FwLC1CQSkQjNqBITC3aXG4z9f+IMckIc/egwPgLVnQ6N4ajTNC2AU3AEB0sLTID+Vo+wfOqJq48IANU1Ib6ZDebJAphycXLq2tCQX5aa+VofmrPaLgcU72sk3glStJskUAaH85Ykr18In1JDw1m5jxrVM0w9NeK+4vMxPn83WbF0aXyiiZoPef0ym2wyKV2kSf9mNHzumN/ff9C0sweK7f1bAjkGedzj0Dznto6T8aviakqWkzAR3fqibC5JGJxFdjh97rNi87kVDwHf7E5Omd/5oQ7wFYElDcBcRaaLjCvSksIBfmMGtKc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:29:17.0403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a53dc96e-0500-4d6a-0223-08df2e6b15bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
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

