Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4F2FF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B49310EAEE;
	Tue, 28 Apr 2026 10:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YlttsxCD";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04D410EAF5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIawGaR8u4Kzp3MkNvaMuEm1gEAULPlEmbCHKC/lcNgGkEEPQ/gcOoDEEG9fg6czQWfU1l9bCeAnK1w6pnVm4OH7O8sbOIZdSWF6DP6dG9o4bAGI43v1Nz5/QqOQtCtrUmwB6wR8dIPjMWPRQ1Ptb/g3a65UZG3tE1HrxBpo4zC5Yw3HJQnPV81J+yG3DW1mLQ3A5kIcd0tO89wxe/dMz9DZdSPrtMsr7DnAdinZPHcK6ga3RK0BWEl2GOnbiMWwGgqEPm8+9lV21uVs4pD/IIStAh7dL5WA+QpwWq/7m14RiQWNpWc3LNlayuPaQjxobbDQHJdRw+C8ivGvmjwKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcHQ5I6kJzgN0hiicGY201nhbqcRifHyKPszI69XUuM=;
 b=WmbFj/dNfbnQYlQoG8lJyH95P+3GPv+23bRqzLkRROsZvU1ex0I2jQ+TAushoSJ6EXXypUhWvx3NBTCQbWeVWbm2QsGuJA9mj+h98cg+f828CiEcMcK1bhKBEos5vxorWbULZ0N7Th0fDnR0HraC7juQqk4EXg6IPl6+hh9Hx06I7X86yjHdGJOW8NbMZ+p0i7gMJs/IcrR5UaXScnjqiFRWmGfVcLTbGQfVKFFA4og0V5HcP6KkU8gRP39xi/TlKTcT7JCAAUlV4ki2vWWVI1yA55AF7SKOSuVRWjet5lyiYZt8dxpl+ZyApbHQpxR3C8Cj8iPwpJlkTu0wkx14/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcHQ5I6kJzgN0hiicGY201nhbqcRifHyKPszI69XUuM=;
 b=YlttsxCDAZgIFzRY2SGmp5pO63ogNQzxWPXRkXfVPji/uIYHz0iGuHInPUQx9G4O2o//pDqzsUx1LQ+5OuOTq/G/FT5fR34Nkm5zpBNo4XAkz2KT/NO+0pzPcDLFvXbMmOI6VdDp4Gks3P1WXzSDyN8gpBvHqfwdiLTOiWfhYfA=
Received: from DS7PR05CA0025.namprd05.prod.outlook.com (2603:10b6:5:3b9::30)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 10:02:43 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::e2) by DS7PR05CA0025.outlook.office365.com
 (2603:10b6:5:3b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 10:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:02:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 05:02:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 03:02:41 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 05:02:40 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v3 01/11] drm/amdgpu/sdma: add SDMA usermode-queue doorbell
 pool infra
Date: Tue, 28 Apr 2026 17:58:42 +0800
Message-ID: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc1e921-beb1-45ec-74d1-08dea50d4a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ADusZLWT/AdyrOSIwaKg3caIryZOHQpC/gNzJ09MS4s35X6hcPnLFeTTJn5NuRswxSB3i9VlwK0KOHWRRdJkBjkt+nApcqT/hq5S4vnfybzaZYOsQC9vPdHc5pauonHpRffV48HnjZtBDwcEexcpmBH7gA0wB1tzUCsHepSfPDrn1waLdadBMwZhAzQyLhTzPPMi8x33Pg3US6xp7Vx5eX62aux2EUWE7Cuk2My8hImz/IfG8n1az8SgFoFpCtEWnQM8RRVd9GZuw+DjU2ELviXaYIcXnUHckFdYCUfgcAJulhSvnt+jhyJmZjON8E6nUDC6B0Rmoncng/6a47uD591kDce2usiYCTRqC8toILB4hV63TvHW9dLDUVICaKPZD2eEUP5RWxP27mxQpy/8Wo/EiLe8NQkPOseLeMV59GZ9wZfoHqCowyEzTlH9xx6HykFUiu3wUbaah38CDxEgSW6FD8uPB2owR7ZSCuHoI60o3el46JgnJqLi4iNmTa4QYEBEZTxjRGSIBdb1Bt1nWzzvbYHNcJk4HdN2KAp8pY/yOoYz2kiHlxf5j13DBYhl7weN3HI8wcyXyzjLMK99uj4FEjF1+5XwkOLpEnJchYkR60rvUV5xIm59YHAAh2tJcTzMqeqXBOVfYheRdo5i2OhpGSGQqehPSqOzhI9WY+iQNkRLG2OmsBy5YRLZEkZCmSGvLPwdokfNkFQr05N0LHuhCB6btET6JiXKjccptSFRLOCvbK7qyEiwOEh8fUzYVdtk62nPMJ/kJpoh8KTOgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MZUra3whDe2hgGkiCnInbIrijmZ8V7lIOk7YeK/Z2amCOi/urvOEvLil1zMcWa+ac4kWclx9yC1R85zxpMYLvnQ4MQKMwSRC6YWlEltuuxnyiPjRcrwXms9RgnOFmw3sOzKItA1lotaaFInwlswNllZwLU7G5WMWp7o8ATfhcJEi5okYzdgIht2NEy/1bVE/tO+jV/XpVaPLDiIbt57H4gJy/zK/n3g3p0jPScP1pOUMU1S4eiqcVcMHR8cToyCXMnbYzdxT6gOHTLBBxX3/oHG/SSQn88dVM0Xohw6uGy156HHdHUjAnm50R+vvAqLo/zedd7WtIzYtdVPE7VIX+4uBWavqylo9Agw7fSY5o+Ln5nmB7xEMjWSjdbr1xWU4Zxd91tjFe4+vQyYgRFcXrTcrfH5U923oCCpHk3S9PI3+J6zawK4NnvZ8NZB5g/W3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:02:43.0463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc1e921-beb1-45ec-74d1-08dea50d4a30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
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

Exposed to userspace via a fixed mmap pgoff sentinel
(AMDGPU_USERQ_DOORBELL_MMAP_OFFSET, bit 56 of the offset, well above
DRM's vma_offset_manager range so it can never collide with a real GEM
mmap offset).  amdgpu_sdma_userq_doorbell_mmap() does
io_remap_pfn_range() straight into the SDMA decode window.  The
pgoff-sentinel dispatcher in amdgpu_drm_mmap() and the
AMDGPU_INFO_USERQ_DOORBELL ioctl that hands the offset to userspace
land in subsequent patches.  Same general pattern as KFD's
KFD_MMAP_TYPE_* .

Slots are allocated/freed via amdgpu_sdma_userq_doorbell_alloc/free.
The init/fini hooks land in the per-engine sdma6/sdma7 patches.

Suggested-by: Prike Liang <Prike.Liang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 154 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  61 +++++++++
 2 files changed, 215 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 321310ba2c08..be7e9de0630e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -22,6 +22,8 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/mm.h>
 #include "amdgpu.h"
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
@@ -200,6 +202,158 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
 	       sizeof(struct amdgpu_sdma_instance) * AMDGPU_MAX_SDMA_INSTANCES);
 }
 
+int amdgpu_sdma_userq_doorbell_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_sdma_userq_db *db;
+	u32 base_dw, size_dw, nslots, ring_dw;
+	int i;
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
+
+	mutex_init(&adev->sdma.userq_db_mutex);
+	adev->sdma.userq_db_bitmap = bitmap_zalloc(nslots, GFP_KERNEL);
+	if (!adev->sdma.userq_db_bitmap) {
+		kfree(db);
+		return -ENOMEM;
+	}
+
+	adev->sdma.userq_db        = db;
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
+	if (!adev->sdma.userq_db)
+		return;
+	bitmap_free(adev->sdma.userq_db_bitmap);
+	adev->sdma.userq_db_bitmap = NULL;
+	adev->sdma.userq_db_nslots = 0;
+	kfree(adev->sdma.userq_db);
+	adev->sdma.userq_db = NULL;
+}
+
+/*
+ * Allocate one qword doorbell slot.  On success, *out_slot receives the
+ * slot id (also the qword index inside the userspace mmap of the window)
+ * which the caller passes back to free.
+ */
+int amdgpu_sdma_userq_doorbell_alloc(struct amdgpu_device *adev, u32 *out_slot)
+{
+	u32 slot;
+
+	if (!adev->sdma.userq_db || !adev->sdma.userq_db_nslots)
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
+	if (!adev->sdma.userq_db)
+		return;
+	if (slot >= adev->sdma.userq_db_nslots)
+		return;
+	mutex_lock(&adev->sdma.userq_db_mutex);
+	clear_bit(slot, adev->sdma.userq_db_bitmap);
+	mutex_unlock(&adev->sdma.userq_db_mutex);
+}
+
+/*
+ * Report the fake mmap offset/size for the SDMA UMQ doorbell window.
+ *
+ * No drm_gem_object, no GEM handle.  Userspace passes the returned offset
+ * directly to mmap(drm_fd, ...); amdgpu_drm_mmap() recognises the
+ * sentinel pgoff and routes the call to amdgpu_sdma_userq_doorbell_mmap()
+ * below, which io_remap_pfn_range()s the routable SDMA doorbell BAR window.
+ *
+ * Same pattern KFD uses for KFD_MMAP_TYPE_DOORBELL — the doorbell window
+ * is unreachable from any drm_gem_object_lookup() / gem_to_amdgpu_bo()
+ * code path because it never enters the GEM object space at all.
+ */
+int amdgpu_sdma_userq_doorbell_get_mmap(struct amdgpu_device *adev,
+					u64 *mmap_offset, u64 *mmap_size)
+{
+	if (!adev->sdma.userq_db)
+		return -ENODEV;
+
+	*mmap_offset = AMDGPU_USERQ_DOORBELL_MMAP_OFFSET;
+	*mmap_size   = adev->sdma.userq_db->size;
+	return 0;
+}
+
+bool amdgpu_sdma_userq_doorbell_is_our_pgoff(unsigned long pgoff)
+{
+	return pgoff == (AMDGPU_USERQ_DOORBELL_MMAP_OFFSET >> PAGE_SHIFT);
+}
+
+int amdgpu_sdma_userq_doorbell_mmap(struct file *filp,
+				    struct vm_area_struct *vma)
+{
+	struct drm_file *file_priv = filp->private_data;
+	struct drm_device *dev = file_priv->minor->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_sdma_userq_db *db = adev->sdma.userq_db;
+
+	if (!db)
+		return -ENODEV;
+
+	if (vma->vm_end - vma->vm_start > round_up(db->size, PAGE_SIZE))
+		return -EINVAL;
+
+	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
+			  VM_DONTDUMP | VM_PFNMAP);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return io_remap_pfn_range(vma, vma->vm_start,
+				  db->phys_base >> PAGE_SHIFT,
+				  vma->vm_end - vma->vm_start,
+				  vma->vm_page_prot);
+}
+
 int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 			       u32 instance, bool duplicate)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2bf365609775..a308d5e6ee54 100644
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
+	 * Exposed to userspace via a fixed mmap pgoff sentinel handled by
+	 * amdgpu_drm_mmap() — see AMDGPU_USERQ_DOORBELL_MMAP_OFFSET below.
+	 */
+	struct amdgpu_sdma_userq_db *userq_db;
+	struct mutex		userq_db_mutex;
+	unsigned long		*userq_db_bitmap;
+	u32			userq_db_nslots;	/* qword slots */
 };
 
 /*
@@ -185,6 +199,42 @@ struct amdgpu_buffer_funcs {
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
+ * Exposed to userspace via a fixed mmap pgoff sentinel
+ * (AMDGPU_USERQ_DOORBELL_MMAP_OFFSET) handled in amdgpu_drm_mmap()'s
+ * dispatcher — same pattern KFD uses for KFD_MMAP_TYPE_DOORBELL.  No
+ * drm_gem_object, no GEM handle, no GEM consumer can ever look this
+ * up via drm_gem_object_lookup() / gem_to_amdgpu_bo().
+ */
+
+struct amdgpu_sdma_userq_db {
+	resource_size_t		phys_base;	/* BAR phys addr of window start */
+	u32			size;		/* window size in bytes */
+};
+
+/*
+ * Fake mmap offsets returned to userspace for amdgpu private mmap regions.
+ *
+ * The high bits (>= bit 56) form a "type" field that amdgpu_drm_mmap()
+ * uses to dispatch to a private handler instead of drm_gem_mmap().  Lives
+ * well above DRM's vma_offset_manager range so any sentinel can never
+ * collide with a real GEM mmap offset.  Internal-only — userspace MUST
+ * get the value via AMDGPU_INFO_USERQ_DOORBELL.  Same general pattern
+ * as KFD's KFD_MMAP_TYPE_* (kfd_priv.h).
+ */
+#define AMDGPU_USERQ_MMAP_TYPE_MASK		(0xFULL << 56)
+#define AMDGPU_USERQ_MMAP_TYPE_SDMA_DOORBELL	(0x1ULL << 56)
+#define AMDGPU_USERQ_DOORBELL_MMAP_OFFSET	AMDGPU_USERQ_MMAP_TYPE_SDMA_DOORBELL
+
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 			     bool caller_handles_kernel_queues);
 
@@ -205,6 +255,17 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
 				      struct amdgpu_iv_entry *entry);
 int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
 			       bool duplicate);
+struct file;
+struct vm_area_struct;
+int amdgpu_sdma_userq_doorbell_init(struct amdgpu_device *adev);
+void amdgpu_sdma_userq_doorbell_fini(struct amdgpu_device *adev);
+int amdgpu_sdma_userq_doorbell_alloc(struct amdgpu_device *adev, u32 *out_slot);
+void amdgpu_sdma_userq_doorbell_free(struct amdgpu_device *adev, u32 slot);
+int amdgpu_sdma_userq_doorbell_get_mmap(struct amdgpu_device *adev,
+					u64 *mmap_offset, u64 *mmap_size);
+bool amdgpu_sdma_userq_doorbell_is_our_pgoff(unsigned long pgoff);
+int  amdgpu_sdma_userq_doorbell_mmap(struct file *filp,
+				     struct vm_area_struct *vma);
 void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
-- 
2.49.0

