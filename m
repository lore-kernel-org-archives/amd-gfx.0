Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE1CECE588
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA30810E68D;
	Mon,  9 Sep 2024 20:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M5yfKiF0";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8763E10E68D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mdrr88k8SUv2U7upcTR2KLZqdHJAnK7SPyBjvieblxtJusZ8pPaB0B0DogyXBzIwr1PBzn5v+w5/vr01ms869IwLHlpyxuJsg5AFdEfKRpfFtwL+u1g80YGI9mpAOO7qtJoBWS1aG/9P6ZnhFOIzyhq1twBfduXejEpXqHNWTBwSnCTihCSsydPHdYQrtgOM9ktoU0cBgQ59rI9I1BO6VA7JC3mV890srQrarE1iphktnKIewDt+98SARQPdfaC3SoAIxMg9ikf+QhW4y4TT3HlAlMmqfEQ2FmN6iJQKVOLWb94/9nU7EYxe6GVunorXFzhTvkL7cDhsnkD+WEl88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da0onUGW9ysdZMtzE/wTS+kccTycNE7B60gC5sEE8os=;
 b=eCyjJIiB5Myy661msvlyCUbSQdw2xXr24pxqQl+dLW9rnE7qAtMEPPerRowBo0vrqGwN5WFd1pVqPhjue+0PuUyduXwOD8l27CzkSsjukNtOGnj432pJ9aLsYtfrY31q9wXKiCyJ8foRdBbKa+dHmjRSLBoZA1+GdpEcpfrS/3nmW1f6bIhBKY7zbyLSJewLb/VtviSIM76OjO2YwzDdoUokKpPgYFUcGD3fJW1tId39zHIxLCFk/og5IgCMRqT1UwMTr61nzLVNb6TpGpYQNF2rtjrpeoKcWnU+gJ4DxZ4ImU6UXZjaPs6eSHLF4gU7OUBSisr0W82qJO6W+g0Rtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da0onUGW9ysdZMtzE/wTS+kccTycNE7B60gC5sEE8os=;
 b=M5yfKiF0rr+rKb9/3YAe/++fHH7nK+FYBURr58C+8zPdwQofqblg3C+V8+kK2SNpMERSmRd0KToH4uj0ZszUxgp9N5D8aTDDr5++bQl4owDSRyJF0q30d+qkrXIKD2JP5RBCyRTRv7OhoyTxUB78c1gMyy6HGqr+K+/rK/x6b2c=
Received: from SA0PR11CA0058.namprd11.prod.outlook.com (2603:10b6:806:d0::33)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 20:07:16 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::1c) by SA0PR11CA0058.outlook.office365.com
 (2603:10b6:806:d0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:16 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:14 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v11 14/28] drm/amdgpu: update userqueue BOs and PDs
Date: Mon, 9 Sep 2024 22:06:05 +0200
Message-ID: <20240909200614.481-15-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eda2cae-7ef2-4f6c-f10f-08dcd10b0071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?263iLHcl9YFDup8uRJrMl1gk4i1CrevIwsuEzVt39StQj8PAAI27P4M/vc+m?=
 =?us-ascii?Q?Hkq4+VZgiUN83ELc2NJt+8upt+Rpm80utSgXRbMGl/tS37eiMN9JfX3m9Lpl?=
 =?us-ascii?Q?mjqGtb+oBRvbryLwds3KgNpcwsF2JRRNtCMqGqT2zZvi/n5DSgXSihhjMhUu?=
 =?us-ascii?Q?tAVcPK3HyItOVFqXkTuDWpFlY9o85TB+NUpXbcTxrxFnyV+fO/iIVVMG5Q6X?=
 =?us-ascii?Q?OalIh/c2A24+zPxOD2vkUJUHvSJe7RL+D4JUGzJa/2KwSzR624HYqs9X9jE8?=
 =?us-ascii?Q?hNHSoxvnMV87f3zXZ5zjhAx8qmNTzlwncIFPp2ddClfT9xIuK6Ihw1+gA81M?=
 =?us-ascii?Q?Nx0Ky3wbl6P2N8zQIv5Po+uEF8rNDCGo6sNM/41ZWT5BNSLxJ4em3yybzwDH?=
 =?us-ascii?Q?MdTt74LtqU0VQO8n3jX9i/TPnKf6YR+KW/saqvllvTz7jm1K9798bJTtvfb5?=
 =?us-ascii?Q?9elquy021hW+gsmsRgMR7ciun2G+4jy38rY9nun4jcCT7rqPsMCHaH2+vJec?=
 =?us-ascii?Q?xEanVUD1nt/xnRDkGTNjGcDML+C1LDaLVADtjoYmsciExck73WRKegstASw5?=
 =?us-ascii?Q?hNmcOU8U8Cdr08WGztE4XJ5hK4y0OCZ975UYij025HvSOcLdSum2/8IuJ3Xb?=
 =?us-ascii?Q?Qe63iqKxqdQqJMsqjVXkhlDkiF8fgQsuhB7KurM7NMa3iI87hDnTzJAaQ/++?=
 =?us-ascii?Q?o/OkWUzLY1WDbBXleBoraMvbK5zdfQRjftjCl5PHjnxg6a1GwZyVtYnqwfT1?=
 =?us-ascii?Q?Qg22dD6LeRZvM7/e9RgURab3RKXW1dKzcA8kOqZmZhdEiC4HecZEMtIHoPaB?=
 =?us-ascii?Q?Cu7Rm2E16NxxVuVc6wW6meEV7OnOTUKEXoXJLeBwSQ19ygF2MbGyU9EN7fMW?=
 =?us-ascii?Q?VtkaTWCgZJ95jCGYqGMjjvxCEMP+zMAFS+DJQsaH1f7+9GfNN9pwkxokQNBj?=
 =?us-ascii?Q?KI4LkoXDOGvwgYYY0oQzV8tjSV0SKkuxtDUzaGbxWbeWFwe9yBA2vF4D86Ck?=
 =?us-ascii?Q?5vg8Gvq5wfGei3mvUVUnD3vnLPwHSfFIKZHJv9TQtZ+Fxa/QUNHWjZWIcXAA?=
 =?us-ascii?Q?MD7hj65o4ytjc89Z+jT22PPHsWKHqwISQtOU/N9QIIsfi2R/MArQdw0/UNMY?=
 =?us-ascii?Q?NCTI7RQj9QKnvV6kuZW3H1gZfhpK6Ukj2CaQ4L9pQVfxzV10MAWk8eDBEsKw?=
 =?us-ascii?Q?VJs/r0WD0/JAAn/xV9goprjZmUhIs3Mrv2u+8y+AVqK+S+f+72+R5UMrrUQ3?=
 =?us-ascii?Q?EZ/LA05nEtphcXV/ig/8i4p1WibYUsIksbEjo3c6QD7iw+cUjLwdZU3NVTa0?=
 =?us-ascii?Q?ejPGcpBeh5treV//HH0wTBbNTpqv1bZfxQD3I4Lugle3UuRFtIKmf0e9SknV?=
 =?us-ascii?Q?y7E6IRzVopqHhEFMnhw6ztRUhw6az53OopzmUX6ydGrwvs5JQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:16.1143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eda2cae-7ef2-4f6c-f10f-08dcd10b0071
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509
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

This patch updates the VM_IOCTL to allow userspace to synchronize
the mapping/unmapping of a BO in the page table.

The major changes are:
- it adds a drm_timeline object as an input parameter to the VM IOCTL.
- this object is used by the kernel to sync the update of the BO in
  the page table during the mapping of the object.
- the kernel also synchronizes the tlb flush of the page table entry of
  this object during the unmapping (Added in this series:
  https://patchwork.freedesktop.org/series/131276/ and
  https://patchwork.freedesktop.org/patch/584182/)
- the userspace can wait on this timeline, and then the BO is ready to
  be consumed by the GPU.

V2:
 - remove the eviction fence coupling

V3:
 - added the drm timeline support instead of input/output fence
   (Christian)

V4:
 - made timeline 64-bit (Christian)
 - bug fix (Arvind)

V5: GLCTS bug fix (Arvind)
V6: Rename syncobj_handle -> timeline_syncobj_out
    Rename point -> timeline_point_in (Marek)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Change-Id: I0942942641e095408a95d4ab6e2e9d813f0f78db
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 89 ++++++++++++++++++-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  3 +
 include/uapi/drm/amdgpu_drm.h                 |  4 +
 4 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ebb3f87ef4f6..f4529f2fad97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -647,7 +647,7 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 	if (!amdgpu_vm_ready(vm))
 		return;
 
-	r = amdgpu_vm_clear_freed(adev, vm, NULL);
+	r = amdgpu_vm_clear_freed(adev, vm, &vm->last_update);
 	if (r)
 		goto error;
 
@@ -825,10 +825,20 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	default:
 		break;
 	}
-	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm)
+	if (!r && !(args->flags & AMDGPU_VM_DELAY_UPDATE) && !adev->debug_vm) {
 		amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
 					args->operation);
 
+		if (args->timeline_syncobj_out && args->timeline_point_in) {
+			r = amdgpu_userqueue_update_bo_mapping(filp, bo_va, args->operation,
+							       args->timeline_syncobj_out,
+							       args->timeline_point_in);
+			if (r) {
+				DRM_ERROR("Failed to update userqueue mapping (%u)\n", r);
+			}
+		}
+	}
+
 error:
 	drm_exec_fini(&exec);
 	drm_gem_object_put(gobj);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 5173718c3848..c9cc935caabd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -21,7 +21,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-
+#include <drm/drm_syncobj.h>
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
@@ -154,6 +154,87 @@ amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
+static int
+amdgpu_userqueue_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
+{
+	struct ttm_operation_ctx ctx = { false, false };
+	int ret;
+
+	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+
+	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	if (ret)
+		DRM_ERROR("Fail to validate\n");
+
+	return ret;
+}
+
+int amdgpu_userqueue_update_bo_mapping(struct drm_file *filp, struct amdgpu_bo_va *bo_va,
+				       uint32_t operation, uint32_t syncobj_handle,
+				       uint64_t point)
+{
+	struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct drm_syncobj *syncobj;
+	struct dma_fence_chain *chain;
+	struct dma_fence *last_update;
+
+	/*  Find the sync object */
+	syncobj = drm_syncobj_find(filp, syncobj_handle);
+	if (!syncobj)
+		return -ENOENT;
+
+	/* Allocate the chain node */
+	chain = dma_fence_chain_alloc();
+	if (!chain) {
+		drm_syncobj_put(syncobj);
+		return -ENOMEM;
+	}
+
+	/*  Determine the last update fence */
+	if ((bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)) ||
+	    (operation == AMDGPU_VA_OP_UNMAP) ||
+	    (operation == AMDGPU_VA_OP_CLEAR))
+		last_update = vm->last_update;
+	else
+		last_update = bo_va->last_pt_update;
+
+	/* Add given point to timeline */
+	drm_syncobj_add_point(syncobj, chain, last_update, point);
+	return 0;
+}
+
+static int
+amdgpu_userqueue_update_vm(struct amdgpu_userq_mgr *uq_mgr,
+			   struct amdgpu_vm *vm)
+{
+	int ret;
+
+	ret = amdgpu_bo_reserve(vm->root.bo, true);
+	if (ret) {
+		DRM_ERROR("Reserve failed\n");
+		return ret;
+	}
+
+	/* Validate page directory of the vm */
+	ret = amdgpu_userqueue_validate_vm_bo(NULL, vm->root.bo);
+	if (ret) {
+		DRM_ERROR("Failed to validate PT BOs\n");
+		goto unresv;
+	}
+
+	ret = amdgpu_bo_sync_wait(vm->root.bo, AMDGPU_FENCE_OWNER_VM, false);
+	if (ret) {
+		DRM_ERROR("Sync failed\n");
+		goto unresv;
+	}
+
+unresv:
+	amdgpu_bo_unreserve(vm->root.bo);
+	return ret;
+}
+
 static int
 amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
 {
@@ -222,6 +303,12 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->flags = args->in.flags;
 	queue->vm = &fpriv->vm;
 
+	r = amdgpu_userqueue_update_vm(uq_mgr, queue->vm);
+	if (r) {
+		DRM_ERROR("Failed to update vm\n");
+		goto unlock;
+	}
+
 	/* Convert relative doorbell offset into absolute doorbell index */
 	index = amdgpu_userqueue_get_doorbell_index(uq_mgr, queue, filp, args->in.doorbell_offset);
 	if (index == (uint64_t)-EINVAL) {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index a653e31350c5..d31e43404640 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -76,4 +76,7 @@ int amdgpu_userqueue_create_object(struct amdgpu_userq_mgr *uq_mgr,
 
 void amdgpu_userqueue_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 				     struct amdgpu_userq_obj *userq_obj);
+int amdgpu_userqueue_update_bo_mapping(struct drm_file *filp, struct amdgpu_bo_va *bo_va,
+				       uint32_t operation, uint32_t syncobj_handle,
+				       uint64_t point);
 #endif
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 6eac46e0f3fd..7367e72a38e9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -721,6 +721,10 @@ struct drm_amdgpu_gem_va {
 	__u64 offset_in_bo;
 	/** Specify mapping size. Must be correctly aligned. */
 	__u64 map_size;
+	/** Sync object handle to wait for userqueue sync */
+	__u32 timeline_syncobj_out;
+	/** Timeline point */
+	__u64 timeline_point_in;
 };
 
 #define AMDGPU_HW_IP_GFX          0
-- 
2.45.1

