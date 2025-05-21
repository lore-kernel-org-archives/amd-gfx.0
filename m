Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1B3C54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 09:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D876510E701;
	Wed, 21 May 2025 09:51:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QKUXPaBi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D04B10E6E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 09:51:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nydd+EJUg7aWo84m3RNGaAEvlLO6TBpRxtg12tu3IN67kydqh3Gb8NwR1JlOSz65CFRdwl5iWCxRJgg4DS4mRmzjm3w0meGofbHBERkgoG0J6T5qm7iIvAkJJcmkhPi/nz7Rfe/WkMpEUVZzkZl8p7RM1Mxl6Nd3swKbTDFNovu+J+pWoQnzNV2AjrLB7yENlm2qOPbVJv3qZnml8Hpoxf4CVnFbUVyWnI92p1vJE6DTSz9/38DZvtka+B4uppy3fInecnHwLJbCA5yaoV8d71UV6RDIRomtJMIBryNh9a12jzkLvmcJzEO3BKUjsWHd+CmOJkgsoacykZLuZ1hF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyeZsEMbHjcZxIMrur4vVZ9DYKKdgj8nx9u/GT8+esg=;
 b=nGC2ZVKPFLTf6RZvdJ6+o7Pg1sxXF/7OoC8fN/Lr5vV5MZsZvafikCTPvOSYpJxmzA7NFzcMDsTbk2j+nedHWKYBkf0rB7ruHQKMuRYLWu6+kh9AOKkZ6R7eNvTUb9+n8kEsQbCndppjdIw7gVev+EyhZKbDH5pbBt9oEPFgvNiBHsV/mc1O1GX0MPnwwM8w7F+we52rN7lV/c1pcvm1F6H4yy67rk/pifggsUa/2wYMSYb3976TammGMz0I+19f3MOl82ptAASUSin1thWOTWEm60prWprPcPyXZG6C3o7En7w80TX0uGo/LLiy2u1xv19C2rvYpz6TsBz9DNP77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyeZsEMbHjcZxIMrur4vVZ9DYKKdgj8nx9u/GT8+esg=;
 b=QKUXPaBihdp1LzCv0sUsR6qqENdw64U5B2/cjc/ZjrB2IWTfYdHFgIHHVqAssFImSIdksT5gE+WSUB/HY1bJtcSA8guNTdeW65WEu3Zyp5lf7U7s8LrlX9jRXw+5keOh+LkAxGz2Dg804S3ZTBXxKGOt9XbAR2agh1EfBmUcWbA=
Received: from BLAP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::17)
 by SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 09:51:05 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::dd) by BLAP220CA0012.outlook.office365.com
 (2603:10b6:208:32c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 21 May 2025 09:51:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 09:51:05 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 04:51:02 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 5/7] drm/amdgpu: port some debugfs function to drm_printer
Date: Wed, 21 May 2025 11:49:07 +0200
Message-ID: <20250521094912.6714-5-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
References: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SJ0PR12MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf1dad9-47b9-4697-7f55-08dd984d00ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yHhoV0fVTA2meUbYsFlWmQCIkc9dqAuBC7vqRuoLQN78XaCxdpCNnwzpMm18?=
 =?us-ascii?Q?QgQgyV1vgOca9UedaqgfO3pQSC30P7mFGltm5k8wT1JDY8EyxBXbtByPWyUE?=
 =?us-ascii?Q?PhTI/TWYU1qRxJMqAanuRlEgoDNNMpdgi/aU3TnY8U2gGvkxCmqx5Fm3imCD?=
 =?us-ascii?Q?sseRs1ndy5WXpiv2qOO/Df6/pFRHHNKI34qFrl/46wztEU9LlzPd7FQ2MGVr?=
 =?us-ascii?Q?R9/c/VnWFc7vfYrZmM8Dwmn4GqXTS26duAAFw/xdPiw0T+gWFHSEzwLZV9bn?=
 =?us-ascii?Q?55RNMspOMYQkPNrrV1k7UKHf4R2eXYPya5nzvj/jraDEJZFI9Il6nrmfHTDY?=
 =?us-ascii?Q?BjnV5hXTWDiPAFlAty4llfGD87F+jt9TGqF+ES9hflt04xr0iANa/tQQ+VsY?=
 =?us-ascii?Q?rM+BqD6CsvBYqd2d8DSkBJWZ99BhFqTsIQMRJsQ3csYN+WuCvH5k9ii3bKua?=
 =?us-ascii?Q?vZcWwz0Yz4CIAB8I/ObN69Yj/BeKxM5QwLiUXZqw+f9VEyKBgcPdryJlGHNN?=
 =?us-ascii?Q?QTO4a36IptOyOeCW3EfbUu5l43gpT21Nxw7rqaT4Xf78dLOjlt9E3/h3bkKD?=
 =?us-ascii?Q?SIGmE9AgjpCxETDXx3WliCQGqGQTaKbDQJniBhO07T9hOE55yJ6be/ppdrbw?=
 =?us-ascii?Q?Io5DVLsr/wV1UvPFVUmJBJTf5/5IZBpLr3zPQ9F/755pk28DETdQ7WLY337d?=
 =?us-ascii?Q?5rrU/93ufagL2NaTao5qzJ6YehI+9zWpFSGbUEjoXK/I2sW1Y49Ik3BBX7xv?=
 =?us-ascii?Q?ma4ViNAQxGIYGoHcQcU9tIbR0g6208Hilg5SWAhmrQ6PWuPWTjjlAhycDrt9?=
 =?us-ascii?Q?BEXNk12mToa6UKAVdutJVdbwP1uC2G0qN4GLCn7BQyDv9wRXjcpUW5+dJI3F?=
 =?us-ascii?Q?QeXqcsT2fpjHAW3aQllebZxo5+FxV8I2oDNyMpIpSzwC3s/dOG4abKjUjpDs?=
 =?us-ascii?Q?ajufdYjv1EAdgP8cMx9c90X2oK0KWGqBVypc9fhvzEkIswN1KVr8UZ1L5gxx?=
 =?us-ascii?Q?GL7OOhRAQzOmmSpMWyj/aEyDCCFcPy5FAdR0zYNxQJ2mgFjENBUbjpj20MgS?=
 =?us-ascii?Q?qMrafkofyulBdX3YP18GqBKOYMmN0iF+UC5YocpEcAIoVLNtQhtwlNI6Tw5L?=
 =?us-ascii?Q?s565CA5PVFOkxGq5d/yrBxtYXnZcZPKrKp1oSxWz0KQ18B7ZGlf70ctVVb+i?=
 =?us-ascii?Q?+CcrEKlMRdJJAYM1cn2VaSJkL8Etnr4Hcdju/QHl0gOpeeWrNqH2jV1IxDEl?=
 =?us-ascii?Q?78dfpmecWEg0E75Rd02Pyte+IlgsDWOXnS66Eria5ZWPy0EB0v3EhBAcfjZJ?=
 =?us-ascii?Q?Oyrbu1xCsx+YVS7yFa0HhF2sPsdorwZv6hiZnoHhhN0Of3NH4M21nFJXofBs?=
 =?us-ascii?Q?1CHwBh6mb02f5qlqtTBIRPv+2ezccFWf0SXVepFfVkuSjcDy4/l421jdqPUM?=
 =?us-ascii?Q?wTnI4gD5G8n7JMbs6Mxo73sCB8WryjfbKcpP5hqCcqLCV+yQrTs1pf12d6Gr?=
 =?us-ascii?Q?S9caq4bLXE7r9Pw1iTpTGM3NFD7HY3tsrRfl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:51:05.1585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf1dad9-47b9-4697-7f55-08dd984d00ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065
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

Using the drm_printer interface will allow us to use these functions
when generating the coredump.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 38 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 42 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  5 +--
 6 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 8e626f50b362..15ccb0eeb78e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1773,12 +1773,15 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 	struct amdgpu_device *adev = m->private;
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_file *file;
+	struct drm_printer p;
 	int r;
 
 	r = mutex_lock_interruptible(&dev->filelist_mutex);
 	if (r)
 		return r;
 
+	p = drm_seq_file_printer(m);
+
 	list_for_each_entry(file, &dev->filelist, lhead) {
 		struct amdgpu_fpriv *fpriv = file->driver_priv;
 		struct amdgpu_vm *vm = &fpriv->vm;
@@ -1793,7 +1796,7 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 		r = amdgpu_bo_reserve(vm->root.bo, true);
 		if (r)
 			break;
-		amdgpu_debugfs_vm_bo_info(vm, m);
+		amdgpu_debugfs_vm_bo_info(vm, &p);
 		amdgpu_bo_unreserve(vm->root.bo);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 2c68118fe9fd..35457f44a089 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1141,12 +1141,15 @@ static int amdgpu_debugfs_gem_info_show(struct seq_file *m, void *unused)
 	struct amdgpu_device *adev = m->private;
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_file *file;
+	struct drm_printer p;
 	int r;
 
 	r = mutex_lock_interruptible(&dev->filelist_mutex);
 	if (r)
 		return r;
 
+	p = drm_seq_file_printer(m);
+
 	list_for_each_entry(file, &dev->filelist, lhead) {
 		struct task_struct *task;
 		struct drm_gem_object *gobj;
@@ -1170,7 +1173,7 @@ static int amdgpu_debugfs_gem_info_show(struct seq_file *m, void *unused)
 		idr_for_each_entry(&file->object_idr, gobj, id) {
 			struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
 
-			amdgpu_bo_print_info(id, bo, m);
+			amdgpu_bo_print_info(id, bo, &p);
 		}
 		spin_unlock(&file->table_lock);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 3339703f40b7..568c2cd95703 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1553,27 +1553,26 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 	return domain;
 }
 
-#if defined(CONFIG_DEBUG_FS)
-#define amdgpu_bo_print_flag(m, bo, flag)		        \
+#define amdgpu_bo_print_flag(p, bo, flag)		        \
 	do {							\
 		if (bo->flags & (AMDGPU_GEM_CREATE_ ## flag)) {	\
-			seq_printf((m), " " #flag);		\
+			drm_printf((p), " " #flag);		\
 		}						\
 	} while (0)
 
 /**
- * amdgpu_bo_print_info - print BO info in debugfs file
+ * amdgpu_bo_print_info - print BO info in printer
  *
  * @id: Index or Id of the BO
  * @bo: Requested BO for printing info
- * @m: debugfs file
+ * @p: drm_printer to use
  *
  * Print BO information in debugfs file
  *
  * Returns:
  * Size of the BO in bytes.
  */
-u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
+u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct drm_printer *p)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_buf_attachment *attachment;
@@ -1623,31 +1622,30 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	}
 
 	size = amdgpu_bo_size(bo);
-	seq_printf(m, "\t\t0x%08x: %12lld byte %s",
-			id, size, placement);
+	drm_printf(p, "\t\t0x%08x: %12lld byte %s",
+		   id, size, placement);
 
 	pin_count = READ_ONCE(bo->tbo.pin_count);
 	if (pin_count)
-		seq_printf(m, " pin count %d", pin_count);
+		drm_printf(p, " pin count %d", pin_count);
 
 	dma_buf = READ_ONCE(bo->tbo.base.dma_buf);
 	attachment = READ_ONCE(bo->tbo.base.import_attach);
 
 	if (attachment)
-		seq_printf(m, " imported from ino:%lu", file_inode(dma_buf->file)->i_ino);
+		drm_printf(p, " imported from ino:%lu", file_inode(dma_buf->file)->i_ino);
 	else if (dma_buf)
-		seq_printf(m, " exported as ino:%lu", file_inode(dma_buf->file)->i_ino);
+		drm_printf(p, " exported as ino:%lu", file_inode(dma_buf->file)->i_ino);
 
-	amdgpu_bo_print_flag(m, bo, CPU_ACCESS_REQUIRED);
-	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);
-	amdgpu_bo_print_flag(m, bo, CPU_GTT_USWC);
-	amdgpu_bo_print_flag(m, bo, VRAM_CLEARED);
-	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
-	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
-	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
+	amdgpu_bo_print_flag(p, bo, CPU_ACCESS_REQUIRED);
+	amdgpu_bo_print_flag(p, bo, NO_CPU_ACCESS);
+	amdgpu_bo_print_flag(p, bo, CPU_GTT_USWC);
+	amdgpu_bo_print_flag(p, bo, VRAM_CLEARED);
+	amdgpu_bo_print_flag(p, bo, VRAM_CONTIGUOUS);
+	amdgpu_bo_print_flag(p, bo, VM_ALWAYS_VALID);
+	amdgpu_bo_print_flag(p, bo, EXPLICIT_SYNC);
 
-	seq_puts(m, "\n");
+	drm_puts(p, "\n");
 
 	return size;
 }
-#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 375448627f7b..f411a8c3199c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -139,6 +139,8 @@ struct amdgpu_bo_vm {
 	struct amdgpu_vm_bo_base        entries[];
 };
 
+struct drm_printer;
+
 static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
 {
 	return container_of(tbo, struct amdgpu_bo, tbo);
@@ -345,8 +347,9 @@ void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
 					 struct seq_file *m);
-u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m);
 #endif
+u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct drm_printer *p);
+
 void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
 
 bool amdgpu_bo_support_uswc(u64 bo_flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3911c78f8282..327ce9e883cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2990,16 +2990,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	return false;
 }
 
-#if defined(CONFIG_DEBUG_FS)
 /**
  * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
  *
  * @vm: Requested VM for printing BO info
- * @m: debugfs file
+ * @p: the drm_printer to use
  *
  * Print BO information in debugfs file for the VM
  */
-void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
+void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct drm_printer *p)
 {
 	struct amdgpu_bo_va *bo_va, *tmp;
 	u64 total_idle = 0;
@@ -3017,74 +3016,73 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	unsigned int id = 0;
 
 	spin_lock(&vm->status_lock);
-	seq_puts(m, "\tIdle BOs:\n");
+	drm_puts(p, "\tIdle BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
 	}
 	total_idle_objs = id;
 	id = 0;
 
-	seq_puts(m, "\tEvicted BOs:\n");
+	drm_puts(p, "\tEvicted BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
 	}
 	total_evicted_objs = id;
 	id = 0;
 
-	seq_puts(m, "\tRelocated BOs:\n");
+	drm_puts(p, "\tRelocated BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
 	}
 	total_relocated_objs = id;
 	id = 0;
 
-	seq_puts(m, "\tMoved BOs:\n");
+	drm_puts(p, "\tMoved BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
 	}
 	total_moved_objs = id;
 	id = 0;
 
-	seq_puts(m, "\tInvalidated BOs:\n");
+	drm_puts(p, "\tInvalidated BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
+		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, p);
 	}
 	total_invalidated_objs = id;
 	id = 0;
 
-	seq_puts(m, "\tDone BOs:\n");
+	drm_puts(p, "\tDone BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
 	}
 	spin_unlock(&vm->status_lock);
 	total_done_objs = id;
 
-	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
+	drm_printf(p, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
 		   total_idle_objs);
-	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
+	drm_printf(p, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
 		   total_evicted_objs);
-	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
+	drm_printf(p, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
 		   total_relocated_objs);
-	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
+	drm_printf(p, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
 		   total_moved_objs);
-	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
+	drm_printf(p, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
 		   total_invalidated_objs);
-	seq_printf(m, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_done,
+	drm_printf(p, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_done,
 		   total_done_objs);
 }
-#endif
 
 /**
  * amdgpu_vm_update_fault_cache - update cached fault into.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f3ad687125ad..0bf9ea018eb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -43,6 +43,7 @@ struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
 struct amdgpu_bo_vm;
+struct drm_printer;
 
 /*
  * GPUVM handling
@@ -598,9 +599,7 @@ void amdgpu_vm_pt_free_work(struct work_struct *work);
 void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params);
 
-#if defined(CONFIG_DEBUG_FS)
-void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
-#endif
+void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct drm_printer *p);
 
 int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 
-- 
2.43.0

