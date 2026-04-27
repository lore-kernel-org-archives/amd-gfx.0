Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EA1FF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 214AD10E602;
	Mon, 27 Apr 2026 08:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SuZxaVin";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6BE10E292
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 08:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNHHmHNVPI03wdqducGbfMXUtOACPd7i7a3mq1kb83R2FlLCPF27eo21inZ/Tfup8Ctf5g6kTmOv30gUWSOetsP4TwCrNwtgv/eawyr3U6Lcme7uB0xWBC+XQDojbRLk4j4vC6DQg8C98jeJcUA4mG0i4bsJJv8Po+BHkYL760NeJY5cJz43dLIByd5NBzjMM81vNfO8xDWThTrTvcMg9mCoPuu/dnx3YIYgs383hyiZy6Q3a/3fjg34SDy5uVUBRqr6MSXuPqnJ8GsBP2G4qnL8dtysgUXEL9Z8ESLw6yRlHxyimDgxir5SniJvpb34gRvggOSz09SeVsK7XRF0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGKCPUQo4JU/O0Aw3oQ04BDkvMu4yX3zZFdorHNuThM=;
 b=MNU9jj3ZFS73hkplTJkkfP7cQcYPN2PlrpaE4wUcB5l6dZosNnwS57Q+4eLylgYBMDPPub7tq9x73XEI1wuwhsTiEdK86DfqNpaqL/U78CUf6uwailddl7Op8xuPkhTNSiRkN8/sbtUOY5ObS8ET2M6L+voGfXtOe3NlQjDlB/DMZe4vl8m+FW70JaLsnYKfjdyCKKYysv3nq1PIiy5e89XzroHuJkfgnaoT0rhc/rWxcsnLDFOxIj40L9qouQw/IU08E2Zs+dSuQin3I7grVS0MDJDA2RvkPi4aqPMB4Hqwbajmq2P9rPp9tr2/R5Z0AdcXg3k9hp3Dbhq//GplMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGKCPUQo4JU/O0Aw3oQ04BDkvMu4yX3zZFdorHNuThM=;
 b=SuZxaVinXx/tUTXrRxqSgWM0QvJbq72QNieqU2sGODL/tDpacMmp1xxl2a5Aib5JhUxn9A/iZO48vssDLj22OPW+48NiPk8mfyM0E+jSixgQ8PP9TzEkl/k7hXjaniYlebVC62iQvTxdqHRlOLAPA6HuGXBZ/udYN63iJrgy2y4=
Received: from CH5PR05CA0003.namprd05.prod.outlook.com (2603:10b6:610:1f0::16)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 08:35:46 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::81) by CH5PR05CA0003.outlook.office365.com
 (2603:10b6:610:1f0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 08:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 08:35:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 03:35:45 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 03:35:44 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 01/11] drm/amdgpu/sdma: add SDMA usermode-queue doorbell
 pool infra
Date: Mon, 27 Apr 2026 16:34:27 +0800
Message-ID: <20260427083543.1328533-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|MN2PR12MB4408:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa39f34-1d6d-4660-669c-08dea437fa3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: NYBTxdlldA0VdD+MJOVJNL9xdUjzzhikpWZcu4fL1VeFr+/ulnFQfwuJe0hP896XlylN9o10P8VrYix+lbknpiamMOQTFFx5pFG22fYocExJ9PCOUwQNbIQtidDWE7rEGCr/NJPZHMRNnJxRBMuDadksnsV/dn+EyqWV6WvZfdUF5c6PlVJavcNdWDzwpW+kpbzC5i+dPhOXZdinbt4OyJJ87v2Csc94MgmQqhoxruu71w84xjW4i9iUc4x6+9pCkSJNjw0N8vtVQPYNFgvNzUaJ5l69Xj2EH9SbmzjhcQdpNbjH+3zvQ7YCvQCC3T7lcJNT3Iioap9uA4C04NwesmI/yzJgNG2CsLTKu7POX02tN2nllwEiHU/Z7+yjsToXZ/xn6WMcYf0XpGK6MZr+p5N6DTNC12NnLaPgml3Aj2Q3PpP/1Il/JCjYKbbWUEPHABAIDIdAqjAzES+3MnleRP3YqLmDIiQSuRGzdkvXZoEx7ooA1snvnW53obMpgCyt227YIbMvWTdIB8YHkgQKUUt9tyAWlCMxZlfjT2HVpKDn4v7N9YjZOAhYrFOlEdr3Ts//0WlDNAo3SInuC8QZHK7bHhQ4m3vph2wyFGVNvIVprzRltFkdc4HECul0XVT2K77fs8FSjvwZML3vlCxUGAJWiOQP8DISBMAepUGEkTd2yOT0l8Hrlob49o92g6TMU8EsyM/alBjTUUPz8vetkOdYKMdu783a46Qheh6NjW9vVZT2Rl9/yvqACOwNw/QFLvdyVisjTnXyxVDoB18qQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uoZZYcpbxtwQ9SlmnEwY3LxqqL/zA02SqI+TPSS1Ec1HIPM/ZKq1PwPMEz/RfsWfGRaddu3BA4bebUIQoyMUJ6pMpsWRQ9TziRGiHaDSrCxILfv1ta6nspI66hEUz/F1xP42gJ4MrHyA09yj0FvsRnmh4Bl+gxvzFTFOe+yEVZI6dlEpD2Q/f8kjauSjqda/7x4/Evp8VR9C1Ds1wLWdeTqb8XLVN4UCHwTaspULmElmP0xRCmMEJal0OoXGJUd2O0x0GtwRqi236LdRaUGelUAPLpLEFUM0qvhnhQ5Ab33GiFPQ0x+diny6bKJkJStQ98+9Dr28H3sXD6hI1H2X9jboxtXMEysKnCTR+6KBMaGnyHElqoGaD8eT6P0gn7POerwmnrWbLscBxj72Kw8IaC9mL34GJ06mYGE5o7XBY5W53B/fVeyA9uFTuusaXH0/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:35:46.1183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa39f34-1d6d-4660-669c-08dea437fa3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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

Add a per-device qword-slot pool covering the firmware-managed NBIO
SDMA decode window (BAR dwords [sdma_engine[0],
sdma_engine[0] + sdma_doorbell_range * num_instances)) — the only
range whose writes are routed to the SDMA back-end.  Kernel SDMA ring
slots are pre-masked at init.

The window is exposed to userspace as a custom drm_gem_object: no TTM
backing, custom .mmap callback that does io_remap_pfn_range from the
SDMA decode window's BAR address.  Per-fpriv GEM handles for that BO
can be minted on demand via amdgpu_sdma_userq_doorbell_create_handle()
so userspace mmap()s through the standard drm_gem_mmap path — no
file_operations override and no fixed mmap pgoff sentinel.

Slots are allocated/freed via amdgpu_sdma_userq_doorbell_alloc/free.
The init/fini and the AMDGPU_INFO_USERQ_DOORBELL ioctl that uses
create_handle land in subsequent patches.

Suggested-by:Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 164 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  55 ++++++++
 2 files changed, 219 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 321310ba2c08..1c61761c0046 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -22,6 +22,8 @@
  */
 
 #include <linux/firmware.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_file.h>
 #include "amdgpu.h"
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
@@ -200,6 +202,168 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
 	       sizeof(struct amdgpu_sdma_instance) * AMDGPU_MAX_SDMA_INSTANCES);
 }
 
+static int amdgpu_sdma_userq_db_obj_mmap(struct drm_gem_object *obj,
+					 struct vm_area_struct *vma)
+{
+	struct amdgpu_sdma_userq_db_obj *db = to_amdgpu_sdma_userq_db(obj);
+
+	if (vma->vm_end - vma->vm_start > round_up(db->size, PAGE_SIZE))
+		return -EINVAL;
+
+	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
+		     VM_DONTDUMP | VM_PFNMAP);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return io_remap_pfn_range(vma, vma->vm_start,
+				  db->phys_base >> PAGE_SHIFT,
+				  vma->vm_end - vma->vm_start,
+				  vma->vm_page_prot);
+}
+
+static void amdgpu_sdma_userq_db_obj_free(struct drm_gem_object *obj)
+{
+	struct amdgpu_sdma_userq_db_obj *db = to_amdgpu_sdma_userq_db(obj);
+
+	drm_gem_object_release(obj);
+	kfree(db);
+}
+
+static const struct drm_gem_object_funcs amdgpu_sdma_userq_db_obj_funcs = {
+	.free = amdgpu_sdma_userq_db_obj_free,
+	.mmap = amdgpu_sdma_userq_db_obj_mmap,
+};
+
+int amdgpu_sdma_userq_doorbell_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_sdma_userq_db_obj *db;
+	u32 base_dw, size_dw, nslots, ring_dw;
+	int i, r;
+
+	if (!adev->userq_funcs[AMDGPU_HW_IP_DMA])
+		return 0;
+
+	base_dw = adev->doorbell_index.sdma_engine[0] << 1;
+	size_dw = adev->doorbell_index.sdma_doorbell_range *
+		  adev->sdma.num_instances;
+	nslots  = size_dw / 2;	/* qword slots */
+	if (!nslots)
+		return 0;
+
+	db = kzalloc(sizeof(*db), GFP_KERNEL);
+	if (!db)
+		return -ENOMEM;
+
+	db->phys_base = adev->doorbell.base +
+			(resource_size_t)base_dw * sizeof(u32);
+	db->size      = size_dw * sizeof(u32);
+	db->base.funcs = &amdgpu_sdma_userq_db_obj_funcs;
+
+	drm_gem_private_object_init(adev_to_drm(adev), &db->base,
+				    round_up(db->size, PAGE_SIZE));
+	r = drm_gem_create_mmap_offset(&db->base);
+	if (r) {
+		drm_gem_object_put(&db->base);
+		return r;
+	}
+
+	mutex_init(&adev->sdma.userq_db_mutex);
+	adev->sdma.userq_db_bitmap = bitmap_zalloc(nslots, GFP_KERNEL);
+	if (!adev->sdma.userq_db_bitmap) {
+		drm_gem_object_put(&db->base);
+		return -ENOMEM;
+	}
+
+	adev->sdma.userq_db_obj    = db;
+	adev->sdma.userq_db_nslots = nslots;
+
+	/*
+	 * Mask out the qword slots used by the kernel SDMA rings
+	 * (sdma_engine[i] << 1 in absolute BAR dwords ⇒ qword slot
+	 * (sdma_engine[i] - sdma_engine[0]) within this window).
+	 */
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		ring_dw = adev->doorbell_index.sdma_engine[i] << 1;
+		if (ring_dw >= base_dw && ring_dw < base_dw + size_dw)
+			set_bit((ring_dw - base_dw) / 2,
+				adev->sdma.userq_db_bitmap);
+	}
+
+	dev_info(adev->dev,
+		 "SDMA UMQ doorbell pool: %u qword slots in BAR dword [%u, %u)\n",
+		 nslots, base_dw, base_dw + size_dw);
+	return 0;
+}
+
+void amdgpu_sdma_userq_doorbell_fini(struct amdgpu_device *adev)
+{
+	if (!adev->sdma.userq_db_obj)
+		return;
+	bitmap_free(adev->sdma.userq_db_bitmap);
+	adev->sdma.userq_db_bitmap = NULL;
+	adev->sdma.userq_db_nslots = 0;
+	drm_gem_object_put(&adev->sdma.userq_db_obj->base);
+	adev->sdma.userq_db_obj = NULL;
+}
+
+/*
+ * Allocate one qword doorbell slot.  On success, *out_slot receives the
+ * slot id (also the qword index inside the userspace mmap of the window
+ * BO) which the caller passes back to free.
+ */
+int amdgpu_sdma_userq_doorbell_alloc(struct amdgpu_device *adev, u32 *out_slot)
+{
+	u32 slot;
+
+	if (!adev->sdma.userq_db_obj || !adev->sdma.userq_db_nslots)
+		return -ENODEV;
+
+	mutex_lock(&adev->sdma.userq_db_mutex);
+	slot = find_first_zero_bit(adev->sdma.userq_db_bitmap,
+				   adev->sdma.userq_db_nslots);
+	if (slot >= adev->sdma.userq_db_nslots) {
+		mutex_unlock(&adev->sdma.userq_db_mutex);
+		return -ENOSPC;
+	}
+	set_bit(slot, adev->sdma.userq_db_bitmap);
+	mutex_unlock(&adev->sdma.userq_db_mutex);
+
+	*out_slot = slot;
+	return 0;
+}
+
+void amdgpu_sdma_userq_doorbell_free(struct amdgpu_device *adev, u32 slot)
+{
+	if (!adev->sdma.userq_db_obj)
+		return;
+	if (slot >= adev->sdma.userq_db_nslots)
+		return;
+	mutex_lock(&adev->sdma.userq_db_mutex);
+	clear_bit(slot, adev->sdma.userq_db_bitmap);
+	mutex_unlock(&adev->sdma.userq_db_mutex);
+}
+
+/*
+ * Mint a per-fpriv GEM handle for the per-device SDMA UMQ doorbell BO.
+ * Userspace then uses standard GEM_MMAP / mmap() on /dev/dri/cardN to
+ * obtain a CPU pointer to the routable doorbell window.
+ */
+int amdgpu_sdma_userq_doorbell_create_handle(struct amdgpu_device *adev,
+					     struct drm_file *filp,
+					     u32 *handle, u32 *size_bytes)
+{
+	int r;
+
+	if (!adev->sdma.userq_db_obj)
+		return -ENODEV;
+
+	r = drm_gem_handle_create(filp, &adev->sdma.userq_db_obj->base, handle);
+	if (r)
+		return r;
+
+	*size_bytes = adev->sdma.userq_db_obj->size;
+	return 0;
+}
+
 int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 			       u32 instance, bool duplicate)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2bf365609775..93a7eb9746d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -146,6 +146,20 @@ struct amdgpu_sdma {
 	bool			disable_uq;
 	void (*get_csa_info)(struct amdgpu_device *adev,
 			     struct amdgpu_sdma_csa_info *csa_info);
+
+	/*
+	 * SDMA usermode-queue doorbell pool.  The window covers
+	 * BAR dwords [sdma_engine[0], sdma_engine[0] +
+	 * sdma_doorbell_range * num_instances) — the only range that NBIO
+	 * routes to the SDMA back-end.  Each bit in the bitmap represents
+	 * one qword slot; kernel SDMA ring slots are pre-masked at init.
+	 * The window is exposed to userspace as a custom drm_gem_object
+	 * (userq_db_obj) that is mmap'd via standard GEM_MMAP.
+	 */
+	struct amdgpu_sdma_userq_db_obj *userq_db_obj;
+	struct mutex		userq_db_mutex;
+	unsigned long		*userq_db_bitmap;
+	u32			userq_db_nslots;	/* qword slots */
 };
 
 /*
@@ -185,6 +199,38 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
+/*
+ * SDMA usermode-queue doorbell pool.
+ *
+ * The pool re-uses qword doorbell slots inside the firmware-managed NBIO
+ * SDMA decode window (BAR dwords [sdma_engine[0],
+ * sdma_engine[0] + sdma_doorbell_range * num_instances)) — that range is
+ * the only one whose writes are routed to the SDMA back-end.  The kernel
+ * SDMA ring slots are pre-marked so they keep working alongside any
+ * number of SDMA UMQs.
+ *
+ * The window is exposed to userspace via a per-device drm_gem_object that
+ * userspace mmap()s through the standard GEM_MMAP path; per-fpriv handles
+ * are minted on demand by the AMDGPU_INFO_SDMA_USERQ_DOORBELL ioctl.  No
+ * file_operations override and no fixed mmap pgoff sentinel.
+ *
+ * FIXME: KFD's SDMA queue doorbells (kgd_*_hqd_sdma_get_doorbell on chips
+ * with a non-stub implementation, e.g. gfx9.4.3) are computed
+ * from the same adev->doorbell_index.sdma_engine[] array and would
+ * overlap with this pool.  On gfx12 the kgd hook stubs to 0, so there is
+ * no immediate conflict.  A shared per-adev allocator that both
+ * KFD and amdgpu UMQ call into is the longer-term fix.
+ */
+
+struct amdgpu_sdma_userq_db_obj {
+	struct drm_gem_object	base;
+	resource_size_t		phys_base;	/* BAR phys addr of window start */
+	u32			size;		/* window size in bytes */
+};
+
+#define to_amdgpu_sdma_userq_db(_obj) \
+	container_of(_obj, struct amdgpu_sdma_userq_db_obj, base)
+
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 			     bool caller_handles_kernel_queues);
 
@@ -205,6 +251,15 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
 				      struct amdgpu_iv_entry *entry);
 int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
 			       bool duplicate);
+struct drm_file;
+struct amdgpu_sdma_userq_db_obj;
+int amdgpu_sdma_userq_doorbell_init(struct amdgpu_device *adev);
+void amdgpu_sdma_userq_doorbell_fini(struct amdgpu_device *adev);
+int amdgpu_sdma_userq_doorbell_alloc(struct amdgpu_device *adev, u32 *out_slot);
+void amdgpu_sdma_userq_doorbell_free(struct amdgpu_device *adev, u32 slot);
+int amdgpu_sdma_userq_doorbell_create_handle(struct amdgpu_device *adev,
+					     struct drm_file *filp,
+					     u32 *handle, u32 *size_bytes);
 void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
-- 
2.49.0

