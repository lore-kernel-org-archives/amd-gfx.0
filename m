Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F876C64ED6
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Feb 2023 16:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E4710E128;
	Sun, 26 Feb 2023 16:55:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4296810E128
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Feb 2023 16:55:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIDNViEqANXpeLIm70Ug4YkMn29DrPq99bB/i9MBM6lnypANmuGh2YP4xQWDUcj615cmxk9PvftC8NGyF7ti8GkRScYRRauwHnklWJI6xT+T3ljtyKDAZGXzaSNUzo7157nvc5rgD7Hy+6yh12oQ19K9ODzMWHLodbrxYRt8hBiB6JW28wyjJZHRo/CqQ1wehM9t0JdjahtPGilzz2nyaKbLi4PI4sKzauEiHAWaFqHd/84gphnlX7eXCvJE371FcDjzY4ksXS+UhAuIYnmqczOcL+6uSIjkbppyfuulgLCX2MfO0Qnc/YqB0USJXOTT+8IkTyd/l0tsPObI0ffsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gquWX7a69QbtgmxtKzl1MZV7ep0WFIMoSpmlsCvWZU8=;
 b=grhAkycS2ZuF0LGOFptPOw5ey9XAf6C/LaEbarUhBFJ2v+cAUjR2V0Q7brHK1q1sgPJJWlZbdZjSSNvQmC3Yq4Ulpu7WOPd6zlwVLQovH1V0hy5Mlxgo14DcGJAdErquDtlim5ivOlaCQutxp9equppJyC35rKR0lKELZBZxwDNZj+qhQS631eZAKA7Ba7JpA0PUUajNe1tWGC1rQaEuHjYLcBjFNEgruI9+tXJStavijfNauqtecJELfpjgR4W3FxqUvLY7f4ZnQF8INnhG4C2ZtCaJRKzd713xclWg4hYWp8iqBfvC1tJLx3gpRcF3SerYZaO0Q7mbLzTJgWveDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gquWX7a69QbtgmxtKzl1MZV7ep0WFIMoSpmlsCvWZU8=;
 b=lLWyHNOpneThXID6hh5bCp3R2Vjy8xkjhMlfDd91QXilkZLZQbLBahATJQXAs65CyFIFM75eqqv/NCDgiYz2Bwxk1pzMwZo7FtDhsI4KsfiQ3vHtsJrPUr0x2htSM8krMh6bB3K0tC2yNKPEEmETSO2izGS0n+rWsNyD9TuzYrA=
Received: from BN9PR03CA0947.namprd03.prod.outlook.com (2603:10b6:408:108::22)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sun, 26 Feb
 2023 16:55:13 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::11) by BN9PR03CA0947.outlook.office365.com
 (2603:10b6:408:108::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.28 via Frontend
 Transport; Sun, 26 Feb 2023 16:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Sun, 26 Feb 2023 16:55:12 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 26 Feb 2023 10:55:10 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdgpu: Implement a new 64bit sequence memory driver
Date: Sun, 26 Feb 2023 08:54:30 -0800
Message-ID: <20230226165435.41641-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: cb955656-f36e-44cd-257d-08db181a3a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Ehhxp0hNbH9n6FcAte7L5n21DNhlu7PEGP1LgYDcBlIUMn6mDIKvyufvjmtvLsiqSBI/dlJOplS1/Va46sfgn4kKaj6HNICjwW4c7dbhlE1Fz6TyUDJ2QUJPlDba4+IsIQ76EQSgHqgahIy/7lOVDJ7fNCAyIGq/ihikLtcSm5lnI3YlgM7iGmZ9A597ol35m6d4fdBBXWnTYCWabVP2IOsT3vJ/HcqDDWIyCslcas6H9ugLypvAn8JfKSXYNGBkMU580q8ZxjZUlbSKrwPY1W+2WaeWpz85Y6CbswSz9OoX4GOsJN8QT8l2O/UBUb0eWtwrip3PFJReGVcHlVbLkoi51r0fd7QQPN/X4n1RkT9DU1tEZREvZAZQJpdn0MWs+rWary+VNdMqIlSUjGx1YO9l66MVwO8jdrYRHQjC4JUKrlFajurl2lu/H8lZ7z7+k2HIjt/PfcZNCjxRenEX4oNjJKyMUBnQ1ZuSBPetFSrufePV/n3RqLnSLh5CFcB8t4j33YdoB+AUizwQDfYFOHs4dgzJao+435mHOXsB5buYM+fXqlfJWztJyNoQVgcqCHQuxbc3jaRTZq/faR7ZOYB0jXcSmwfgCHmMw1iricMFsA7LlV6SotCI8MbafJPmozQYLV8V47V6c0EAIaDF3FPfzMxz8BbXi9l5vc8sxxlwJr80irG3BOkkx+tqydLJ2W52cn7MLot8CazvBF76VC3fbvqssKjIlkprvhe3tw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(41300700001)(8936002)(30864003)(66899018)(2906002)(6916009)(4326008)(5660300002)(70586007)(70206006)(8676002)(83380400001)(54906003)(316002)(478600001)(40480700001)(1076003)(36756003)(40460700003)(186003)(16526019)(6666004)(26005)(426003)(47076005)(2616005)(81166007)(82740400003)(336012)(36860700001)(7696005)(86362001)(82310400005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 16:55:12.5203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb955656-f36e-44cd-257d-08db181a3a14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Developed a new driver which allocates a 64bit memory on
each request in sequence order. At the moment, user queue
fence memory is the main consumer of this seq64 driver.

v2: Worked on review comments from Christian for the following
    modifications

    - Move driver name from "semaphore" to "seq64"
    - Remove unnecessary PT/PD mapping
    - Move enable_mes check into init/fini functions.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  13 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c  | 158 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h  |  48 +++++++
 6 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6ae9d5792791..a239533a895f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-	amdgpu_ring_mux.o
+	amdgpu_ring_mux.o amdgpu_seq64.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 0625d6bdadf4..1c3eba2d0390 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -110,6 +110,7 @@
 #include "amdgpu_mca.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_seq64.h"
 
 #define MAX_GPU_INSTANCE		16
 
@@ -480,6 +481,7 @@ struct amdgpu_fpriv {
 	struct amdgpu_vm	vm;
 	struct amdgpu_bo_va	*prt_va;
 	struct amdgpu_bo_va	*csa_va;
+	struct amdgpu_bo_va	*seq64_va;
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
@@ -944,6 +946,9 @@ struct amdgpu_device {
 	/* GDS */
 	struct amdgpu_gds		gds;
 
+	/* for userq and VM fences */
+	struct amdgpu_seq64		seq64;
+
 	/* KFD */
 	struct amdgpu_kfd_dev		kfd;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index afe6af9c0138..88097d12ced3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2417,6 +2417,12 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 					goto init_failed;
 				}
 			}
+
+			r = amdgpu_seq64_init(adev);
+			if (r) {
+				DRM_ERROR("allocate seq64 failed %d\n", r);
+				goto init_failed;
+			}
 		}
 	}
 
@@ -2873,6 +2879,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 			amdgpu_device_wb_fini(adev);
 			amdgpu_device_vram_scratch_fini(adev);
 			amdgpu_ib_pool_fini(adev);
+			amdgpu_seq64_fini(adev);
 		}
 
 		r = adev->ip_blocks[i].version->funcs->sw_fini((void *)adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 52e61e339a88..d1198ca5aa7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1182,6 +1182,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			goto error_vm;
 	}
 
+	r = amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va,
+			     AMDGPU_SEQ64_VADDR_START,
+			     AMDGPU_SEQ64_SIZE);
+	if (r)
+		goto error_vm;
+
 	mutex_init(&fpriv->bo_list_lock);
 	idr_init_base(&fpriv->bo_list_handles, 1);
 
@@ -1249,6 +1255,13 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_bo_unreserve(adev->virt.csa_obj);
 	}
 
+	if (fpriv->seq64_va) {
+		WARN_ON(amdgpu_bo_reserve(adev->seq64.sbo, true));
+		amdgpu_vm_bo_del(adev, fpriv->seq64_va);
+		fpriv->seq64_va = NULL;
+		amdgpu_bo_unreserve(adev->seq64.sbo);
+	}
+
 	pasid = fpriv->vm.pasid;
 	pd = amdgpu_bo_ref(fpriv->vm.root.bo);
 	if (!WARN_ON(amdgpu_bo_reserve(pd, true))) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
new file mode 100644
index 000000000000..bf43856cebbc
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_seq64.h"
+
+void amdgpu_seq64_fini(struct amdgpu_device *adev)
+{
+	if (!adev->enable_mes)
+		return;
+
+	amdgpu_bo_free_kernel(&adev->seq64.sbo,
+			      NULL,
+			      (void **)&adev->seq64.cpu_base_addr);
+}
+
+int amdgpu_seq64_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	if (!adev->enable_mes)
+		return -EINVAL; 
+
+	if (adev->seq64.sbo)
+		return 0;
+	
+	/*
+	 * AMDGPU_MAX_SEQ64_SLOTS * sizeof(u64) * 8 = AMDGPU_MAX_SEQ64_SLOTS
+	 * 64bit slots
+	 */
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_SEQ64_SIZE,
+				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
+				    &adev->seq64.sbo, NULL,
+				    (void **)&adev->seq64.cpu_base_addr);
+	if (r) {
+		dev_warn(adev->dev, "(%d) create seq64 failed\n", r);
+		return r;
+	}
+	
+	memset(adev->seq64.cpu_base_addr, 0, AMDGPU_SEQ64_SIZE);
+	
+	adev->seq64.num_sem = AMDGPU_MAX_SEQ64_SLOTS;
+	memset(&adev->seq64.used, 0, sizeof(adev->seq64.used));
+	
+	return 0;
+}
+
+int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		     struct amdgpu_bo_va **bo_va, u64 seq64_addr,
+		     uint32_t size)
+{
+	struct ttm_validate_buffer seq64_tv;
+	struct amdgpu_bo_list_entry pd;
+	struct ww_acquire_ctx ticket;
+	struct list_head list;
+	struct amdgpu_bo *bo;
+	int r;
+
+	bo = adev->seq64.sbo;
+	if (!bo)
+		return -EINVAL;
+
+	INIT_LIST_HEAD(&list);
+	INIT_LIST_HEAD(&seq64_tv.head);
+
+	seq64_tv.bo = &bo->tbo;
+	seq64_tv.num_shared = 1;
+
+	list_add(&seq64_tv.head, &list);
+	amdgpu_vm_get_pd_bo(vm, &list, &pd);
+
+	r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
+	if (r)
+		return r;
+
+	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
+	if (!*bo_va) {
+		r = -ENOMEM;
+		goto error_vm;
+	}
+
+	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, size,
+			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
+			     AMDGPU_PTE_EXECUTABLE);
+	if (r) {
+		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
+		goto error_map;
+	}
+
+	r = amdgpu_vm_bo_update(adev, *bo_va, false);
+	if (r) {
+		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
+		goto error_map;
+	}
+
+	ttm_eu_backoff_reservation(&ticket, &list);
+
+	return 0;
+
+error_map:
+	amdgpu_vm_bo_del(adev, *bo_va);
+error_vm:
+	ttm_eu_backoff_reservation(&ticket, &list);
+	return r;
+}
+
+int amdgpu_seq64_get(struct amdgpu_device *adev, u64 *gpu_addr,
+		     u64 **cpu_addr)
+{
+	unsigned long bit_pos;
+	u32 offset;
+
+	bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
+
+	if (bit_pos < adev->seq64.num_sem) {
+		__set_bit(bit_pos, adev->seq64.used);
+		offset = bit_pos << 6; /* convert to qw offset */
+	} else {
+		return -EINVAL;
+	}
+
+	*gpu_addr = offset + AMDGPU_SEQ64_VADDR_START;
+	*cpu_addr = offset + adev->seq64.cpu_base_addr;
+
+	return 0;
+}
+
+void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr)
+{
+	u32 offset;
+
+	offset = gpu_addr - AMDGPU_SEQ64_VADDR_START;
+
+	offset >>= 6;
+	if (offset < adev->seq64.num_sem)
+		__clear_bit(offset, adev->seq64.used);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
new file mode 100644
index 000000000000..e9b0afa9c5aa
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#ifndef __AMDGPU_SEQ64_H__
+#define __AMDGPU_SEQ64_H__
+
+#define AMDGPU_SEQ64_SIZE		(2ULL << 20)
+#define AMDGPU_MAX_SEQ64_SLOTS		(AMDGPU_SEQ64_SIZE / (sizeof(u64) * 8))
+#define AMDGPU_SEQ64_VADDR_OFFSET	0x50000
+#define AMDGPU_SEQ64_VADDR_START	(AMDGPU_VA_RESERVED_SIZE + AMDGPU_SEQ64_VADDR_OFFSET)
+
+struct amdgpu_seq64 {
+	struct amdgpu_bo *sbo;
+	u32 num_sem;
+	u64 *cpu_base_addr;
+	unsigned long used[DIV_ROUND_UP(AMDGPU_MAX_SEQ64_SLOTS, BITS_PER_LONG)];
+};
+
+void amdgpu_seq64_fini(struct amdgpu_device *adev);
+int amdgpu_seq64_init(struct amdgpu_device *adev);
+int amdgpu_seq64_get(struct amdgpu_device *adev, u64 *gpu_addr, u64 **cpu_addr);
+void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
+int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		     struct amdgpu_bo_va **bo_va, u64 seq64_addr, uint32_t size);
+
+#endif
+
-- 
2.25.1

