Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16468C636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 18:44:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6186710EB7E;
	Wed, 15 Feb 2023 18:44:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F86C10EB7B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 18:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0MC/LPqL5sVqIPWX3SDeXlxFXOeMhb1bS1LZbVAeLwbSW+at6YyGMLCKusP4RpEBeO7gq6s+z2uvx3u3kNTVHlpxzQ/i9o74G29SFKnUaXp4dK0wp2Jendy6wPr/Wc3IQ+t67ga4UE5sMuG21VacKLRwNaxmz07bthzBeICCaKbaPGDDSKHRNZPMD4NlQSO7F7I3n4Eqwh6WuZqsQqg4F3Kw9ILhWXugiE0Rh8HYaV6wr0gwAPitXd/cBcklfYpuDxICVsbJ2oS9pTbNUiTRv0t61pOvkbcRx3qU+/jgo1mnCV3bjMq3X4w3UPESvzVR3ZkW2+FoIt3aYrMA9YfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPXfIppUFrD5ya/McONaiO7iQTKA9pgMl9nr8HFQBrI=;
 b=NHvHYEQ70MohRAsOe6PtzOD/B1NKqxBklINncuLa5m1q8lkacYydkMPo1jr/cRODdswGRy+CeyFPHqdbEWdCMUTBe7nBEHiHH/BbFFX73Faep4Za8iL0VqH3Pr6Kpo3XJJfhE9y3GWpEBn1dclnjU7I0ogFxL7mN2rvHCXuO6QMKRWBjznxoTlib/n22PKMPmbR46+S9zyGpD2gJxOj1PwkYZ38HPSelFG2M+GY1X6KukHmqIimcsdDdgnBBNMi7D45ApNZKdwUFxiLe1bY02VfgInh7Nxj8bRl/wP4YppB3hzPtiqR1NVcPE8KrJ+DCZaIMciIwdReIFffHpSGTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPXfIppUFrD5ya/McONaiO7iQTKA9pgMl9nr8HFQBrI=;
 b=FSJ3wcv7/sWKQtxzabUg8mWeMegEcLlqNN5+GyqgaTLmTXGWYRO9YLSgg+gk/3Hpm8WRJYNJTXr+CEwZAqk8m/fE1X+QrXoCNVqWPIa9ve+x/wRqU1h6wa8cckGHpF0u7feWodOGV7OHXwUOZDtwBYSA7rDqsVJL3n64EqAIYcM=
Received: from DM6PR08CA0028.namprd08.prod.outlook.com (2603:10b6:5:80::41) by
 CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Wed, 15 Feb 2023 18:44:35 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::fd) by DM6PR08CA0028.outlook.office365.com
 (2603:10b6:5:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 18:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 18:44:35 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Feb
 2023 12:44:33 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/9] drm/amdgpu: create GFX-gen11 MQD for userqueue
Date: Wed, 15 Feb 2023 19:43:52 +0100
Message-ID: <20230215184356.2205-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230215184356.2205-1-shashank.sharma@amd.com>
References: <20230215184356.2205-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fa78e7-805b-41ac-70a7-08db0f84af31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2dS2N8hYMRhZ1H9mkCRKCwaQbzgO+SsCV2deShMVrr8lly4cnqYCGnCuqHmP5mDNL5iIocKWPHHLFCo2vxn4usFE/j+u5PhdRCu5rVodfut+NmVerNRwwwbzCuNgYbkHAo/UxdUwUOL7xFMZDSZBeopiS9oJiP1cEFDezwma7SFA68yp5ueXKW5jx6oTfX9n4s57LFYBFPiGVg06pUniMtTGD05nT0eitbZIaaLebr0/fkBe7cOdaMalELm3oPTOUhI3kX+24HUyjk7zXB0MRrUzkVjuZkxoxkMiqnFditblkmvVtbbo45hZ+47yqeWAfTsBlA0IETk/553kDM+pdMgfaV1MTCRUKNHswSYmO46MsAGBvjcoFLUhVUjICB+sJLT3yOKhl0VsQyUMXr4r59asX35XBAs3yFl0Uq5FiXla1NNKQhVeVNAxMZbn/nweyT/izX3WHDCYkTXL+YXZjD/ZjITDj3ROvHDCXaZFbP46w8+jM5egiua3sf17Y17Tsw6RApZGClKFCRLNAopla4AvbRZ5C6VpkNiifhnDtFPTphYjuBJssg6tOGegHKnQ4+hYI8LiVoUc4ANip+76pbDgYwHVl2aC87u0XG0m7RGVSsSYrKjxpFqZpN4Liwyr3Tq7a9EE2BYz70G1s8GIPm8Qya1Rz56MC8YHSBiI46+j3XiGVQHwPnpms+ij+a3NgGsPXz9S8zagQcBEuWVyYQ3QX9n84sRJdBFZs+lJg4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199018)(40470700004)(36840700001)(46966006)(47076005)(66899018)(26005)(7696005)(2616005)(16526019)(186003)(36756003)(82310400005)(86362001)(40460700003)(478600001)(426003)(41300700001)(336012)(83380400001)(2906002)(356005)(6666004)(36860700001)(44832011)(5660300002)(54906003)(316002)(82740400003)(1076003)(8936002)(4326008)(70586007)(81166007)(40480700001)(8676002)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 18:44:35.1628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fa78e7-805b-41ac-70a7-08db0f84af31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

A Memory queue descriptor (MQD) of a userqueue defines it in the harware's
context. As MQD format can vary between different graphics IPs, we need gfx
GEN specific handlers to create MQDs.

This patch:
- Introduces MQD hander functions for the usermode queues.
- Adds new functions to create and destroy MQD for GFX-GEN-11-IP

V1: Worked on review comments from Alex:
    - Make MQD functions GEN and IP specific

V2: Worked on review comments from Alex:
    - Reuse the existing adev->mqd[ip] for MQD creation
    - Formatting and arrangement of code

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>

Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 21 +++++
 .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 84 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
 4 files changed, 113 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 764801cc8203..0c825bdf12d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
 
 # add usermode queue
 amdgpu-y += amdgpu_userqueue.o
+amdgpu-y += amdgpu_userqueue_gfx_v11.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index ecf31d86f3de..963e38f654a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -82,6 +82,12 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
         goto free_queue;
     }
 
+    r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, queue);
+    if (r) {
+        DRM_ERROR("Failed to create/map userqueue MQD\n");
+        goto free_queue;
+    }
+
     args->out.queue_id = queue->queue_id;
     args->out.flags = 0;
     mutex_unlock(&uq_mgr->userq_mutex);
@@ -106,6 +112,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
     }
 
     mutex_lock(&uq_mgr->userq_mutex);
+    uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
     amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
     mutex_unlock(&uq_mgr->userq_mutex);
     kfree(queue);
@@ -136,6 +143,19 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
     return r;
 }
 
+extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
+
+static void
+amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
+{
+    int maj;
+    struct amdgpu_device *adev = uq_mgr->adev;
+    uint32_t version = adev->ip_versions[GC_HWIP][0];
+
+    maj = IP_VERSION_MAJ(version);
+    if (maj == 11)
+        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
+}
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
 {
@@ -143,6 +163,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
     idr_init_base(&userq_mgr->userq_idr, 1);
     userq_mgr->adev = adev;
 
+    amdgpu_userqueue_setup_ip_funcs(userq_mgr);
     return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
new file mode 100644
index 000000000000..12e1a785b65a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
@@ -0,0 +1,84 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#include "amdgpu.h"
+#include "amdgpu_userqueue.h"
+
+static int
+amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_device *adev = uq_mgr->adev;
+    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
+    struct amdgpu_mqd *gfx_v11_mqd = &adev->mqds[queue->queue_type];
+    int size = gfx_v11_mqd->mqd_size;
+    int r;
+
+    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
+                                AMDGPU_GEM_DOMAIN_GTT,
+                                &mqd->obj,
+                                &mqd->gpu_addr,
+                                &mqd->cpu_ptr);
+    if (r) {
+        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
+        return r;
+    }
+
+    memset(mqd->cpu_ptr, 0, size);
+    r = amdgpu_bo_reserve(mqd->obj, false);
+    if (unlikely(r != 0)) {
+        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
+        goto free_mqd;
+    }
+
+    queue->userq_prop.use_doorbell = true;
+    queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
+    r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->userq_prop);
+    amdgpu_bo_unreserve(mqd->obj);
+    if (r) {
+        DRM_ERROR("Failed to init MQD for queue\n");
+        goto free_mqd;
+    }
+
+    DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
+    return 0;
+
+free_mqd:
+    amdgpu_bo_free_kernel(&mqd->obj,
+			   &mqd->gpu_addr,
+			   &mqd->cpu_ptr);
+   return r;
+}
+
+static void
+amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
+
+    amdgpu_bo_free_kernel(&mqd->obj,
+			   &mqd->gpu_addr,
+			   &mqd->cpu_ptr);
+}
+
+const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
+    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
+    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
+};
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 7625a862b1fc..2911c88d0fed 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -27,6 +27,12 @@
 #include "amdgpu.h"
 #define AMDGPU_MAX_USERQ 512
 
+struct amdgpu_userq_ctx_space {
+	struct amdgpu_bo *obj;
+	uint64_t gpu_addr;
+	void *cpu_ptr;
+};
+
 struct amdgpu_usermode_queue {
 	int queue_id;
 	int queue_type;
@@ -35,6 +41,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_vm *vm;
 	struct amdgpu_userq_mgr *userq_mgr;
 	struct amdgpu_mqd_prop userq_prop;
+	struct amdgpu_userq_ctx_space mqd;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.34.1

