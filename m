Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A79CFB44CA
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 08:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE30910E187;
	Fri, 24 Apr 2026 08:20:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sa3VhnKd";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CFF210E187
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 08:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koLxZwszGAzPC9ERgJ16vn2xwKCnLYijul+dZC1QXi68/M1FZGA7cIsmIeRQZk/F619FbSTvHq0bSRWaglmP7M3EqhbnwHi7QDIlN3jfkCXTuPnJob/h5SLb369erqAhU3z4AMctYXvrMK9osrM6c9CXhPXqeDRIZquY5hHztE1i17+Ja+Hl9m5q5583nWMDeFzUIp+Toi77zsoOPQYjQuVMggXzbUMhdno1dzCncpEcCTzsAahNJywpUtaVIrblPXORB/F4kkDRl0w3HZvx4wzIlmcfhScOkn2vP2yJGuKb/1QvKjYJqa44khmoPUvCJYKl9c9l5tdtuXPiVmme+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMyMhsm7Bd/LarKLKldFqV6lg4WBBdaYMZsh1enPwHE=;
 b=FN67lBOvOU7rCxOrHUysx4O/ABG7t0YFOXcHlgqLzIF9Zzvu/g5c5Q2Z5cNZTLzixCq6qHEZMC7fT4eAgFh9w9oyjMeQa5sPum2ilR2HRVU2z3Rr3HU5nXcLc/j8zkPSUT0Vk+sX3oZ98aNHZotJkorIVwolhAl2AaEGqYt+IlAaHsILsoC8BYJYWJhbMrqA/AC4jmoeT3VrfuHhSNNpFuEHrL3o8I/J+U737cSGMhAp5AqbyNoLR15YDd8PGnVmnO18d69lGss/NhAZwZ8U/uEj2mei5wzZuoiebBB16cQ6jmXYo0w4SRow3WOft9qCUvdmS8A2VCuaknY1/W0pXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMyMhsm7Bd/LarKLKldFqV6lg4WBBdaYMZsh1enPwHE=;
 b=Sa3VhnKd0fu5/XtN6nfJWo3CPa3AykvJrWVAUsjRjfFGhnW/vkmyS7lAD3KhupT7phGugVrLHYccFbsVJPF0TKXJDRYUTNA109BDcK0Bdev7yaIgQnlZK3LXVuKpYLLe89OHui1vKvhymEu3/EHSTomr+Z4q8jExmEPr7PDydcM=
Received: from SJ0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:a03:2ef::29)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:20:07 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a9) by SJ0PR03CA0204.outlook.office365.com
 (2603:10b6:a03:2ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Fri,
 24 Apr 2026 08:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 08:20:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 24 Apr
 2026 03:20:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 24 Apr
 2026 03:20:02 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 24 Apr 2026 03:19:56 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.zhang <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 01/10] drm/amdgpu/sdma: add SDMA usermode-queue doorbell pool
 infra
Date: Fri, 24 Apr 2026 16:18:46 +0800
Message-ID: <20260424081955.873090-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 48543f8c-3cf3-459b-7564-08dea1da4b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: +n/W15cQB5oejBhumx/FCNIRcB0S5HENhFHvZGwow0koe7PpRe2TdG9eAgeIFnEHnBaXBOWZIkwf6mJCjEZxDrN+JTORDFD9cU7RYREEFxs99ir+On2+BSPFMZIRsHU14T1K+GbwePo1rp0806YpH5Jgn7dVejk56JOZvAb8ZLg9X7ZWyqJaKwyhxGc4SEvwZCBS5hhtv2apLi/d4Htu/hiSIUNI70Lmg83BCTBcyPY6noch2v7adiayEL8TkWB9PEil+5I/Ih1wgIXvBMpGmfQI1gPFatc5ALri4MnB5srhBe97zxGo7YH13OgARxXv+eSOaH8a3Zqz6Rjunux+yY9sVzuKeRWjrLgsdrzYrrgj2zVgRzzhorTIDFuHkTYmlKV3ppczic7gMv0CZ199YDTXVQrxfJ+fsShHpg5Yfc/aCu+Xr44l8w3Gz42Iwo5YxKiDnsFqN3qK1DMVmiQeIjalg+55JRPG9BfxxrjVGJSQGMfNcEhpq8sYKf2dcPJg2T1STZA6GJMj7eyd4iq35e/LEr+HYQ3a1K5uQtNP/EguMgL1jhiJ89shP+RSkbqXs7SJn6L+RMS8RSC5KryIr6KhI+kkPf9S/8gWWTDbDP+OL3Er/9wBErXzuj+WmCZGbanhGTIlcaVfIPRWXHTH16WhC7TBsRzc+WSOXIPggARyjcEHfl9pmfW8inyPPI3JCpLo6l1dOdIOnYiy0ztPFVq0tRm95RalsRdjXB22hwzGzo2YUQqACujNwNCJxnQiph9kNN0oa1Q+5VXxPLVwlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iSXGfBL7bm5xEwlZPWaWY93ShFKaNO4jfuVbTZK27ENKSMnaDSB+hgld+8ZJyOnjbc6Vb8V3oAM7dVyMhs7o4D0tTk+rsJyatZPyA/3Or+QqufQupBXf9dDhrFe+H1CBWsg/XqZT4msM6ovK5SxVN/7s1+wBNNDijnq60PSGxUxs/dDe+ND1Unm45qGBtxTstVqyZ+8V7+2tbAEW5EpRlOB2ROVCnuod7tLzHZlczgZEXzx0t+PEcZy9X4sOUvZzOKl2ARHP8jRwD65JS2sIHzIfONsCxEXwVo9u/r6jry4qeUlfRbxZhzWxUG5woeEsPyUy6XBtxCKTn5AM1TFkXANZPDac6DWkRxalt+tG5fDAAYMjb79TpsHM5SQZkrzDpPNryWftWeOFX/fZIryg3tbzaPJJmXfRhZzfGmYkh7K2mPMawbdqXw5SJZB7Mxoz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 08:20:07.1911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48543f8c-3cf3-459b-7564-08dea1da4b68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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

From: "Jesse.zhang" <Jesse.zhang@amd.com>

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
The init/fini and the AMDGPU_INFO_SDMA_USERQ_DOORBELL ioctl that uses
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

