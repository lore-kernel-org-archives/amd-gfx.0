Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F35C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 16:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6867110EB80;
	Wed, 29 Mar 2023 16:05:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C29F10EB82
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 16:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN/ulxFTHPYkIYw3Hr/Ern23H/HGFTl79WlBgaVRtghuX3WQVSmyyRjvtXdIRvfH9ISq4MKCbPaTLPpjEXRc+zE8yDniAXY6UX8QrlqBt3UlY+dK5yirP18lPUpmuYPHiEt80QMN8fPc88/tE9AT+SFyyvEU35mr+9fBvohHVJ8GqUEgvvyZO+NqZNqojdrgOlh8qZ14mQXQN4ufyWxaN1++HfZqnYupyuBDCAonRziPl1dbaedXNe3r9I4maFlSOxThJ535JK8liJvTt7xccOh+G7NZnegwtgJTMKq3ZT6Pt1Bp/x9W5m3hXCJ+bbpG9H4a6Ef7vfoVjTHz5jqzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFIJKjyrjTpxFm0dkLrqS/GYOAdyaAC+CmV2y8Sg7NU=;
 b=EToU9R9XwCYInuMArOhjM1DtlUIgopPfts4wt+Zo5RKbUYxJ9EKJizh57mP8Zmb0uYR/5DLR5WEMJRrLKQrGjLgBX187xm19afDxXA5K3yxNYCbhRTUa2xdlKQL3WMpxSY3HCyhdiQxE5nG9IH7nT/coWP9Eg8/Pi5rmntZ/6yEPlUnLG+2YnRtpBj3IuE3oQh/b0Msz9yeGPmGQhf/56/hcYthtHMGus+Rw4+e6Y8rf9RHuh6yoCV3PN6XMHxZWGgY8b2QKaY4Qb4GrYxdjp4eCadVrmn3NeOAMd90FjScnjYfKNtkySRwtoaD5PfEVGSf6SA/eZ7jVNXQTnttBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFIJKjyrjTpxFm0dkLrqS/GYOAdyaAC+CmV2y8Sg7NU=;
 b=uLRfkp026Zf7Qa4EuYHWRIgSzzyBDVHZj2OP603rgCXNThKFG3rTL0YlaSvVhhdhU/1/OR2g7Sh44r076bxWncglrdxt9TIMiRkRHNbYuU1t4w1a/7klPE0zvs2vf12wvk/PgjzEvsSBkzdWlV6/dHiSdaj/EQNTRcsraX6YDzs=
Received: from MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::21)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 16:05:15 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::e5) by MW4P222CA0016.outlook.office365.com
 (2603:10b6:303:114::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 16:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 16:05:14 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 11:05:10 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/9] drm/amdgpu: create GFX-gen11 MQD for userqueue
Date: Wed, 29 Mar 2023 18:04:40 +0200
Message-ID: <20230329160445.1300-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329160445.1300-1-shashank.sharma@amd.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d519f41-1f3a-4f12-7eca-08db306f6228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEqDRoVsQV2hapcBBbVvEP181oRId8eznNsKMJDo+bYNeVVErT4ocv9lO3RHgULXzWthKZSsU18Cn6OcUz2GacoI7fneEfM7Gw1DO5VzREWxxiRaxijmoZQ7cZSh8bEaH+fj56AMXWdhAO54G/0TxiItOXfaCt0l3Ni/7lxOBQR/o0p7Vb6J+1oWZamG0sgBdSfWwFBPUHw6kGNM25MHJ9/7nM8KECxWsQEqVfUNLWFaKx6YeB/uwLyjaxzYg6NdCSXyIJSU8DaP5PFHubnm1qb44oiae4jSIPRKbwcPW5gRVWKCJxRVIOVLZ/6l1eBt/n1CJNaV6KM/kNj1+U0QnctG66wCdZ+OC8vcrY2nufT6GBBM7BGdCrXFqUHQcFORXTjuhucPno1PPfrPB0RdSdp6X7CClSEwf/B51eblp2b5sSLpBCoEW9jiqM2VX7Si34txZLRDx+b3K8ttFheMRHkMc32e/jnXTtaTQKtIAzKWUpEHlKE3/7d2hgPWA/Dp0ukDB1HYv7Tn3oEWbb8rkufP/ykP1iP+FBtN++LvKOLMI0yFbN8+0MFe8FpCzIJTW07ycGXJmZUizV0amS6J/bXVhjn6ZPGWJ7GwmwDgdsUD0JOmjf6kmbPFsHwyEI4t40KEqV7Dqe/2t9tEvyI8CPB08i7nbDOtuzHTFIexHoBlVw2h83zGkriPGBF1oLWMlAJm6ANwh/jIIFIFv7kv2HPUIT/4oVifhdlX9JTgomw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(316002)(40460700003)(36860700001)(478600001)(54906003)(82740400003)(356005)(81166007)(86362001)(8936002)(82310400005)(36756003)(5660300002)(70586007)(44832011)(4326008)(70206006)(2906002)(8676002)(6916009)(40480700001)(41300700001)(426003)(1076003)(186003)(6666004)(16526019)(26005)(2616005)(336012)(83380400001)(47076005)(66899021)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 16:05:14.7818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d519f41-1f3a-4f12-7eca-08db306f6228
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
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

V3:
    - Integration with doorbell manager

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
index 2d90ba618e5d..2cc7897de7e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
 
 # add usermode queue
 amdgpu-y += amdgpu_userqueue.o
+amdgpu-y += amdgpu_userqueue_gfx_v11.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 353f57c5a772..052c2c1e8aed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -81,6 +81,12 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
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
@@ -105,6 +111,7 @@ static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
     }
 
     mutex_lock(&uq_mgr->userq_mutex);
+    uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
     amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
     mutex_unlock(&uq_mgr->userq_mutex);
     kfree(queue);
@@ -135,6 +142,19 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
@@ -142,6 +162,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
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
2.40.0

