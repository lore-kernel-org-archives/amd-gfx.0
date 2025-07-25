Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AFEC87FCE
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 16:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE6C10E9EB;
	Fri, 25 Jul 2025 16:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="naxVOUKW";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B35E10E227
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 16:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icxUKleb97c5XaFD2wY1Q2J676DFlYkpdlX48sCyrFIE/5YigVL10zWpz4L3l1ipHpxSRTAc4twEyxRoZIkQA1sIkoQLVAvqfgLLjgoPwcHfCZvM+Vb9Pp9eE2Cbzxo5J/3/3U/UIgOrrzdZ8TzzpBjmOBxV7bzU+03pEyHdFz9GmoERa5vzvyieLPLkVJGUsDM9HVxdTw52A1NUUILikD14uAG9VznuKhMSsWMGDBHnkJmbFyugxSLyTphAxV8UKOiwKGCLnv+9LXGWeIcaSoCEUjc2ry0hR8nyXtFdRUG91Vi2fr/78Fsyd8J2dvVeS6b8VrGspZN9HQCQwFqpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep/qaWzJtX4WpUyCGVG4+NbWLec+7A72v0hWvoRZSIw=;
 b=eYcVAOMJ2hRp3nFjAleH4bylFObE1ecIkGUcKeq/7Zk7kJT6BNuWxH+8FGG2HAU9UcHssju6E1jQkjthqVD9GxbhwYViK0XOV5XkK2Jgg77v96eptu+2G+Y7wJHGrZjmt/TsUOca2ITtqxJTq4+zPLTxyTv6HqpNOHmfxLHi4Qu8gBO201riZGJ1qjWNhPXz5NZ1CVi4GYxM50PpYlaUIsqz0UmMV0O0pWmMs7V2ZatpHx3t6ra/4XKJopSji6QhOsx3YvZxAcAgtrGkk3rbk/tXs1zjRT5sT298bkQWnP+SzZ0VnfjMJnJU/q7IvT7EzuWrc5tBX/RI+9hAW6Ip1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep/qaWzJtX4WpUyCGVG4+NbWLec+7A72v0hWvoRZSIw=;
 b=naxVOUKW6japPQYXQs/4gpiTa/UDS00Kz+1pZM/+/sWG+OWnkX0DRQ6VPXL45fFU1SnD3u+ZCcsE88eNwF6Iii+YrsTIs2njHWB4DbjIHXVEopStsYgjdnJ0i4Ht8qFFr9xQmpabhKm2ecJfdvzcz/CUXC0nIIhdhQBN5jTrjPQ=
Received: from CH5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:1f1::19)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 16:08:15 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:1f1:cafe::5c) by CH5PR03CA0003.outlook.office365.com
 (2603:10b6:610:1f1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.24 via Frontend Transport; Fri,
 25 Jul 2025 16:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.0 via Frontend Transport; Fri, 25 Jul 2025 16:08:14 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 11:08:13 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <simona@ffwll.ch>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>,
 David Francis <David.Francis@amd.com>
Subject: [PATCH v9 1/3] drm/amdgpu: Add CRIU ioctl to get bo info
Date: Fri, 25 Jul 2025 12:07:55 -0400
Message-ID: <20250725160757.231780-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725160757.231780-1-David.Francis@amd.com>
References: <20250725160757.231780-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: ba434c6e-ace6-4406-beee-08ddcb9575d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xrnU3OlaGOpQW4qsUgXVUBTFQiuGdK9nwwIeYPP0hXCS99DGq9xzZXeHUlCF?=
 =?us-ascii?Q?11zFUL8xZtTorKQhJKUQBhM6iYh1X8J6iWlYJYk70FH63bgyuQPg2cj7pc0m?=
 =?us-ascii?Q?7Vy6i3RrkXeLb9KVKOy+ZyzOxL+wzdAduiLcCKN9CNHGF5TsHHMwHy6ed1nv?=
 =?us-ascii?Q?E3regPrR6vwvpV0TH4CuYB5lAAn+GSsjaidtvqShQMiNfCBYuwz9K7xuf3m9?=
 =?us-ascii?Q?FOom6omHyMPLM8PVkaEz61Jnt526vETjjXzfLRBI/J3E5a8NeToYmkXsmi84?=
 =?us-ascii?Q?62rwEBS3SQSpLXzzy8e5AHsdnTA4r2wdwdeeRyqsR8AoR+x08bHjm8Mx4z7j?=
 =?us-ascii?Q?ggdhsGgglC9zWNlIZwdwTLLKmxAHcCASYGPMAyDUcN0uE6xlmvu3IheNwZOK?=
 =?us-ascii?Q?e6JxXCLrdaqc2XEdzFQaWeyf2e2SVZKWTXssNopl7qIHTiT6Ale/jnwSpmxK?=
 =?us-ascii?Q?v/hAK5VN6vUbCftwUkH4Gt/7roV6762zzumz45UzukSM8/znmSUiGW1qEI4j?=
 =?us-ascii?Q?yUHnvecXdnbNGvvX/ssx2oTNDv1lv+OEpXBjeDgwLmULmMIfl/zLZvJ+xqCL?=
 =?us-ascii?Q?0eqq+wuUgbjkVVfhRmFWHnY0I4qdeoTvO8wUL0wTo5WFUkFfSB3HZeF8VUBI?=
 =?us-ascii?Q?37lKJIw5qHVKEVV7CpN80UcU75bPcgPHXiTKFOgy7KMw5kPRqcewrcpO1PsN?=
 =?us-ascii?Q?QuRcySOjIQk5cUQ5iqmp2miyQ6uQTAIylPI/NB4L+D8Ruy1bjksMUaU91GcW?=
 =?us-ascii?Q?vrHV7n0AalST8Z6xP5yZasKia9wia4q1EhWzAuH8JpqAHK1uYhlpXWsNCtjH?=
 =?us-ascii?Q?WkB/NJEP+G7zRZktBtZBYHyDV8q5E9kBf+5D5iE8DAm+s0NRefMrd7uBmMMC?=
 =?us-ascii?Q?oGttpFB0xoTt9GvtHFFt+gWJbDZOXV+WMW2BuohV6nNBvE8thtmzPAleudgR?=
 =?us-ascii?Q?jxyoZaBhqGLoP2jPo6X1t3AO8sGTpZX8qT7PTAnhQk1wtAPmOyUPnMOb/ztx?=
 =?us-ascii?Q?xq5zO9tLBeWcmb72G0C0F9ZcMxubIT4O84TeV037MhzMyWKzx264bOQ161/8?=
 =?us-ascii?Q?HtUpEwaRlpL4GlE8mFBMrJ1QRmMJN/eJ38tpGtmnKw6Zyp1i78rxRjY4h+Zq?=
 =?us-ascii?Q?yuDhzYR6OkIiXF7OvZyeOWdkFJAJxMz5/nDDoKFFqr0mqyvb8ILj7+aKsdfu?=
 =?us-ascii?Q?nBqsJ2Z9UoU8IUqfQO+AeFUc/2zpVpoXZHfSbxZYq52IPKdUPGF9WWXnj2g+?=
 =?us-ascii?Q?SEzo868EX3n/RWmA6iMxGa3spLYERlzcet9m1eS0IFr9ZKKQLGeVX2wZriK3?=
 =?us-ascii?Q?pZmmLTmDmTiuBC8499UPVrexC29pjFSIehrKXotiWJnPh/CuS4zldzjZXKbv?=
 =?us-ascii?Q?lW3ec9uzPSBmNBYky7mM9g/OpQuEUnp3w7/ji+qrM6KbsjvP6kDSIWybPQtG?=
 =?us-ascii?Q?0GO8S8dWpl0V5V7ZdyPtbq2vGeCEfNZhNRHtAgUp701wAPb15artiWue7XHJ?=
 =?us-ascii?Q?BmT7PS3zhlWYAaRleU3eNZdbfcpcIwthh2XK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:08:14.3371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba434c6e-ace6-4406-beee-08ddcb9575d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
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

Add new ioctl DRM_IOCTL_AMDGPU_CRIU_BO_INFO.

This ioctl returns a list of bos with their handles, sizes,
and flags and domains.

This ioctl is meant to be used during CRIU checkpoint and
provide information needed to reconstruct the bos
in CRIU restore.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c | 101 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h |  30 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   2 +
 include/uapi/drm/amdgpu_drm.h            |  33 ++++++++
 5 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 930de203d533..b545893cb1a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -63,7 +63,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
-	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
+	amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_criu.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
 	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
new file mode 100644
index 000000000000..8bfcb2234166
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <drm/amdgpu_drm.h>
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+
+#include "amdgpu_criu.h"
+#include "amdgpu.h"
+
+/**
+ * amdgpu_criu_bo_info_ioctl - get information about a process' buffer objects
+ *
+ * @dev: drm device pointer
+ * @data: drm_amdgpu_criu_bo_info_args
+ * @filp: drm file pointer
+ *
+ * num_bos is set as an input to the size of the bo_buckets array.
+ * num_bos is sent back as output as the number of bos in the process.
+ * If that number is larger than the size of the array, the ioctl must
+ * be retried.
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_criu_bo_info_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	struct drm_amdgpu_criu_bo_info_args *args = data;
+	struct drm_amdgpu_criu_bo_bucket *bo_buckets;
+	struct drm_gem_object *gobj;
+	int id, ret = 0;
+	int bo_index = 0;
+	int num_bos = 0;
+
+	spin_lock(&filp->table_lock);
+	idr_for_each_entry(&filp->object_idr, gobj, id)
+		num_bos += 1;
+	spin_unlock(&filp->table_lock);
+
+	if (args->num_bos < num_bos) {
+		args->num_bos = num_bos;
+		return 0;
+	}
+	args->num_bos = num_bos;
+	if (num_bos == 0)
+		return 0;
+
+	bo_buckets = kvcalloc(num_bos, sizeof(*bo_buckets), GFP_KERNEL);
+	if (!bo_buckets)
+		return -ENOMEM;
+
+	spin_lock(&filp->table_lock);
+	idr_for_each_entry(&filp->object_idr, gobj, id) {
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+		struct drm_amdgpu_criu_bo_bucket *bo_bucket;
+
+		bo_bucket = &bo_buckets[bo_index];
+
+		bo_bucket->size = amdgpu_bo_size(bo);
+		bo_bucket->alloc_flags = bo->flags & (~AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE);
+		bo_bucket->preferred_domains = bo->preferred_domains;
+		bo_bucket->gem_handle = id;
+
+		if (bo->tbo.base.import_attach)
+			bo_bucket->flags |= AMDGPU_CRIU_BO_FLAG_IS_IMPORT;
+
+		bo_index += 1;
+	}
+	spin_unlock(&filp->table_lock);
+
+	ret = copy_to_user((void __user *)args->bo_buckets, bo_buckets, num_bos * sizeof(*bo_buckets));
+	if (ret) {
+		pr_debug("Failed to copy BO information to user\n");
+		ret = -EFAULT;
+	}
+
+	kvfree(bo_buckets);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
new file mode 100644
index 000000000000..c991d08262c1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef __AMDGPU_CRIU_H__
+#define __AMDGPU_CRIU_H__
+
+int amdgpu_criu_bo_info_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3bb9b25cd121..28a057db4718 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -53,6 +53,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
+#include "amdgpu_criu.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
 /*
@@ -3027,6 +3028,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_CRIU_BO_INFO, amdgpu_criu_bo_info_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bdedbaccf776..460170fdb66e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -57,6 +57,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ		0x16
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
+#define DRM_AMDGPU_CRIU_BO_INFO		0x19
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -77,6 +78,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
+#define DRM_IOCTL_AMDGPU_CRIU_BO_INFO	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CRIU_BO_INFO, struct drm_amdgpu_criu_bo_info_args)
 
 /**
  * DOC: memory domains
@@ -1628,6 +1630,37 @@ struct drm_color_ctm_3x4 {
 	__u64 matrix[12];
 };
 
+#define AMDGPU_CRIU_BO_FLAG_IS_IMPORT	(1 << 0)
+
+struct drm_amdgpu_criu_bo_info_args {
+	/* User pointer to array of drm_amdgpu_criu_bo_bucket */
+	__u64   bo_buckets;
+
+	/* IN: Size of bo_buckets buffer. OUT: Number of bos in process (if larger than size of buffer, must retry) */
+	__u32   num_bos;
+
+	__u32 padding;
+};
+
+struct drm_amdgpu_criu_bo_bucket {
+	/* Size of bo */
+	__u64 size;
+
+	/* GEM_CREATE flags for re-creation of buffer */
+	__u64 alloc_flags;
+
+	/* Pending how to handle this; provides information needed to remake the buffer on restore */
+	__u32 preferred_domains;
+
+	/* Currently just one flag: IS_IMPORT */
+	__u32 flags;
+
+	/* gem handle of buffer object */
+	__u32 gem_handle;
+
+	__u32 padding;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1

