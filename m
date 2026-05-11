Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE9ACD37AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 14:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09FFA10E78B;
	Mon, 11 May 2026 14:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PnB9WX/r";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D547510E78B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 14:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BdPnU3Latj4FQxqxQ2zzQ67ctaJcUuVbImkNJEF3iz58Njs7fPDW9MDQ+5KCGpKs9B/4CCUl0zdJ4GUvz+4EWDeee815m9rabH+6KzwozQ5g0e8mHZKYZVrVXfSShedpJmaLaUwXu6FjIq5CzuPL2SsDxmgOHiG+m/Xa3vvx+IP4k2Jad87wv484Q3Gtu+4L81l7yRoTFfZnrGL+7/eHxEC99sXQnQjDQANfGBcap/DBQnVH9hhKVnSbhNIDI3tqJgb7457Y3oftqxCoGIvCe0a5+rImlVbFqaGQ6U4NDaMaZ0W9ifP0KwY8s48Y23VulqFus0A9KfmeLpEDxq9y7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Db5ZMRvlXPEjT1p/8Ma9V1ndpdOz0V/r8Cc2CnXqm7o=;
 b=KtnlwnIiq3gupZoOlzzFIoJJ0WN7SnL0t/LOCfHWYOzQ1EN/dpYWBtKDkrq5O7tZ+rxyIZJP2fEvccI15D7Sr3U+OBsIRciIA9CjfHHj3csEVjnFZ33DsYZmE644bX98iJi23DQ8M/JXfe5RB/FY0vOutWp1NCQ/n3hkvgC/5Y5xXuzAZrDwREGbEpKo3xBwxWRSwZisTpOcFXsP3cBLXtfAFXrktlxyzBuHwQe/nsUAci6Fnjh8rJg66uaJaxWG7nVc6052TA1anyfpIlE+PFs84GPASHGSTij2HyOwIkaUf65R5pjrbJNQXa4Bk1tzKst+BQif8Zgx7x7E2DGlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Db5ZMRvlXPEjT1p/8Ma9V1ndpdOz0V/r8Cc2CnXqm7o=;
 b=PnB9WX/rie22vcAtW/57hGYKVqIPnXyfDX7M/mM8OJs1ZEa8Y8ZSxW1uHCyaIKqcYlE/9zN+TO8owihGgS6GMF7lDk6YyyJo5VlstNjPWGwiEbCzpRAHh0MH367wG/uU6jmGJuI/7pVcCxzgS4CiS6ZtaysI0sabJZWejzZe/OQ=
Received: from SJ0PR03CA0199.namprd03.prod.outlook.com (2603:10b6:a03:2ef::24)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 14:23:21 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::f8) by SJ0PR03CA0199.outlook.office365.com
 (2603:10b6:a03:2ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 14:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 14:23:20 +0000
Received: from yifan.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 09:23:17 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Felix.Kuehling@amd.com>, <Perry.Yuan@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: unmap all user mappings of framebuffer and
 doorbell before mode1 reset
Date: Mon, 11 May 2026 22:22:59 +0800
Message-ID: <20260511142259.1424915-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: a3218224-dd29-41e9-5e83-08deaf68da01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: gHgk5DWY0nYGPDLV7BYijGB/PPn8B/gFgzzO70JQJN7Tkt3PMeswV2udNMBgi+ceVCBua2CbaISCNJQapeE7S+/oMLPerw5MA0ZRBoGf67JG57pb4E4oiEuD9h91AMhwF4Vklv85EO03HZ+lMoAdZRXtTkUQXNk5flTvaJqlZbnwXK2d/ij5ypVm5Oz74WZCafRGAgI+XgXV54Tta67nH4A1dzh9pfadHFQ27/bDYlZOTdcPvPvdqvisDmMqtTAvQM/ouZgdfpsokzEAxGoR4DF/4VgHdlFVVwcbRpSLSn1ZBd+inpZL6/jW/oAaULUhuXnbd5GYG9j3adkcig+41deWNRz7WGhYrJhzhnlHBLuzYJTuZ3Nh82zr73SMZnUD5c1CAMvnu1HfsSCC2/TsC5VDRLg5706u45c8hLJtFJYcapeJsrv4TqvJg30pyMQsX/uWkOseNN5FfhvWKnzRFvG5BoMl9sUcN1sP5zaCI4ObcubZP/Hcnm0P6LDbWlsSougpglHfWDa4NjMuWjiyuQQl2b6Q6YVLptGepwEii+oA7rS+rrv1rFKtR/i8O7+NF7cFPVTyoYFYO97vNByoh3PE5zoLa/LAQc1cv/7fHNhM8TesEpqgzDFWvzQptG7PxrAR+VodkwZ2oT9d9eBxywQotuuWY5BUujXViCaFUzbpMgNnZIp2OqMIoIX+3DJ/sxWpY9PXDcBVmaa4yQ5Al4loRFxuFtdZi3iuH9vOKzk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fx+XkaXNSv9VEGfYNT/AbvPH3EfCZ410Tpsx/9WonTbi52mGBMNJ+RRAcZyWWLvrBBcCmgoVJ3s3xehpqobwh34dSooK+QSz7YXBkwBW6eQMNlNbN51chHpTFWma/80XAxTE0zzeb0Log2mr49BdiGVLieoQPe5aY5mFitKYK3V0OGL84slAgv2QWvlGetjXOqj3cBleWjTGm46nslONSk/woLcdu2lU2Zw3JMTzGcdIsjU+dk9ICeRJj1kGBBJHPpjVQu7wFbroWqqgH1Du29Ii2tgyuRNZWaZrG6xl+msuI1/WnBAKT8ILUNL9txNRNCrDtnXYkB5vKmejX84zx3v9DC/TeC4S2EtBHryvJ26p+Fs58D1iLwNOHVmSk3Km147PKH34pJz93eclWKqTcbpTyr/Ey41bXy2LjANQJDzMSNlAY3ERXCtkxRzOKVoV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 14:23:20.1359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3218224-dd29-41e9-5e83-08deaf68da01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
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

During Mode 1 reset, the ASIC undergoes a reset cycle and becomes temporarily
inaccessible via PCIe. Any attempt to access framebuffer or MMIO registers during
this window can result in uncompleted PCIe transactions, leading to NMI panics or
system hangs.

To prevent this, Unmap all of the applications mappings of the framebuffer
and doorbell BARs before mode1 reset. Also prevent new mappings from coming in
during the reset process.

v2: remove inode in kfd_dev (Christian)
v3: correct unmap offset (Felix), remove prevent new mappings part to avoid deadlock (Christian)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 5 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7b10bbe28caf..d1dac3412a66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -36,6 +36,7 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_umc.h"
 #include "amdgpu_reset.h"
+#include "kfd_priv.h"
 
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -320,6 +321,27 @@ void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 		(void)amdgpu_reset_domain_schedule(adev->reset_domain, &adev->kfd.reset_work);
 }
 
+void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
+{
+	struct kfd_dev *kfd = adev->kfd.dev;
+	unsigned int i;
+
+	if (!kfd)
+		return;
+
+	for (i = 0; i < kfd->num_nodes; i++) {
+		struct kfd_node *node = kfd->nodes[i];
+
+		kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_DOORBELL |
+					    KFD_MMAP_GPU_ID(node->id),
+					    kfd_doorbell_process_slice(kfd));
+		kfd_dev_unmap_mapping_range(KFD_MMAP_TYPE_MMIO |
+					    KFD_MMAP_GPU_ID(node->id),
+					    PAGE_SIZE);
+	}
+}
+
+
 int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t size,
 				u32 domain, void **mem_obj, uint64_t *gpu_addr,
 				void **cpu_ptr, bool cp_mqd_gfx9)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 2bf6a31c194d..5333e052d56d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -360,6 +360,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
 void amdgpu_amdkfd_unreserve_mem_limit(struct amdgpu_device *adev,
 		uint64_t size, u32 alloc_flag, int8_t xcp_id);
+void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev);
 
 u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1202a72ff063..6760c9331f46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5844,6 +5844,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* We need to lock reset domain only once both for XGMI and single device */
 	amdgpu_device_recovery_get_reset_lock(adev, &device_list);
 
+	/* unmap all the mappings of doorbell and framebuffer to prevent user space from
+	 * accessing them
+	 */
+	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
+	amdgpu_amdkfd_clear_kfd_mapping(adev);
+
 	amdgpu_device_halt_activities(adev, job, reset_context, &device_list,
 				      hive, need_emergency_restart);
 	if (need_emergency_restart)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 84b9bde7f371..1be1b1dd2341 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -69,6 +69,21 @@ static const struct class kfd_class = {
 	.name = kfd_dev_name,
 };
 
+/*
+ * Cache the address space of the chardev on first open so that the reset
+ * path can drop all userspace mappings of doorbell and MMIO ranges via
+ * unmap_mapping_range().
+ */
+static struct address_space *kfd_dev_mapping;
+
+void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen)
+{
+	struct address_space *mapping = READ_ONCE(kfd_dev_mapping);
+
+	if (mapping)
+		unmap_mapping_range(mapping, holebegin, holelen, 1);
+}
+
 static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *p, __u32 gpu_id)
 {
 	struct kfd_process_device *pdd;
@@ -135,6 +150,13 @@ static int kfd_open(struct inode *inode, struct file *filep)
 	if (iminor(inode) != 0)
 		return -ENODEV;
 
+	/*
+	 * /dev/kfd is a single chardev so all opens share one inode. Cache
+	 * its address_space on the first open for use by the reset path.
+	 */
+	if (!READ_ONCE(kfd_dev_mapping))
+		cmpxchg(&kfd_dev_mapping, NULL, inode->i_mapping);
+
 	is_32bit_user_mode = in_compat_syscall();
 
 	if (is_32bit_user_mode) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a6ff1db477f9..f037062c33ea 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -399,6 +399,7 @@ enum kfd_mempool {
 /* Character device interface */
 int kfd_chardev_init(void);
 void kfd_chardev_exit(void);
+void kfd_dev_unmap_mapping_range(loff_t const holebegin, loff_t const holelen);
 
 /**
  * enum kfd_unmap_queues_filter - Enum for queue filters.
-- 
2.43.0

