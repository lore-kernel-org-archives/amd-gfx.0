Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB960C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 21:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0029710E926;
	Fri,  3 Feb 2023 21:54:55 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8657810E91C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 21:54:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEDehHrADpjznB9dampo2xnzBiOHJNXWiRh2++uYJwuAEtigP4UiyM1Gm4f3Ngh0ZeqKZa+u5yNB7hDb6LuuaY08xoEb0mxuqw1eTxYoY19c9w0utpP1gIVvnWi6GSTWlhE5RGGpXojsvyCfLr9aj8ZHkdjVVwQsm5gUJVesN8iwLjIEnHH9dlcB+q42zfIN+oG8ggrzyvFSqYOx8I2ee/ppwAuZ4JUO/+981tmitweABR3+Tk47HlS+Bi7U3ggWKgdtQ1juoJ0mxKwq54Xa6VJ1GokxLf1tEOlCju/1rG8VsuTKY1FVNKaLbtPRNtPcmK2gl+oSq5rnrkG7vATwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQALXoEL9otqkW0Q2fdHNvNBND+yDo5z2Wj1jHShlg4=;
 b=buDyq7guAU174mglcjDOyqnnOapNBqQR6hWb2jjAQUlHI77VI14aChxA0+4lWlcclyOkJjgLXuT7TgYG7XJJSz49Q9kKahLE9+doT02z+I89JroNJuYY2oAt8AsDtrCy3n/ZCZ4pDf1PK4PeuP5ecZ0TqJe3Zl0p4Lsnu7pVpIQsdYF9VvkXcFQRH9r0+oj7a/anTz5nVFvgd99iqfvbcXQb93619K3FEhvgIXnqegram472JLsRWQsnwB0LOZYzRXJxALPWNO++4XhHQ2f8A4hSCClCgMAgoVgD0hpJno/kqYdCIzkoVaDnp+Bw36she2C8gZYPS4lYlfNd0gH1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQALXoEL9otqkW0Q2fdHNvNBND+yDo5z2Wj1jHShlg4=;
 b=h56ndVh/wg9JoxEdhwtfZMCyuzc8SF9OXFRs5j1APDnEX/lU4HUZRe/8kpZzG8Z3AGcEi4ZKrnIqzUbltPoZCpVWu7kD+FkTUm7n8eOxcQV+u06oN0b6YdGSzDzSFAE40Zx7zfGwmtxF0RpSO+gzzHXlBnwsTduIoR5OOzF3wKs=
Received: from CY5PR19CA0112.namprd19.prod.outlook.com (2603:10b6:930:64::12)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Fri, 3 Feb
 2023 21:54:43 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::bb) by CY5PR19CA0112.outlook.office365.com
 (2603:10b6:930:64::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 21:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.18 via Frontend Transport; Fri, 3 Feb 2023 21:54:43 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 15:54:38 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amdgpu: Add V11 graphics MQD functions
Date: Fri, 3 Feb 2023 22:54:05 +0100
Message-ID: <20230203215409.2021-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203215409.2021-1-shashank.sharma@amd.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|PH7PR12MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 4181ffe5-6aca-4f5a-1561-08db063141e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAPk6CYQuBuY1q1DGRRq8pP49Roq4/X9MAkGQ20X/0NlHfPCRWsU5WL3TqamHbsWdIFo+61urHAVtomX5I8cnLrQl9+GSNRnazqqz6kdpcTX3mQzTowmbbrkLNyvu6pr+Ewtx0uZpb7lFAm9H4SqT3Kzwfj8XzoOxBSz7z1rbB3x+iBS2fCgP/unmH1b8YTthX9YKsXz/enblMaDYsTiSfU9DuKy4awjXXoCWAzG/6tUKBn/8F3mZR2hDif+R0C9u+IMVcpYHP6CWkZsFsPi/WwtxRBZrOmV2eui1Pn6FvUiamY5Kjl8s9C4Iy19TiWa3xZdWFRLo3rCn39yCjVhr0ID8gGwhyWSK8V9Q5++jG6Wrixc7gWAKanfhiKfWelyICAFMBEhxw9vasWgWHr3uYHi7vc9h+jvvweG7Ak+ghewJiZiCySttsumFsKohD9fWObABdlYErhaZSGw0oq0vndYbq6hu0POuTNkutRX/qMpAdfAns/SWXFvvU70B4aQdWrG6adrRTTHIvmFYEHxViP9PiARIliQU5XPfYIbjJBVpVInnIiZnBBcHhDtDITrGKsfitEjUAd1XlWNQ+d1Ty7Rf3D9xlX6DMBCXYSiH2dH/4awxZVVkcMKTalvFQsB5Ar4RGv4VYyRsIkJlXshhmbKbOY10UiIzJZULw81W6DOj8nC6yqbFMINdTzIVRQWCMYSA0qGmKyVuC6TKFEU3eBCzUOa8KHjfqJyH01F1Lc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(4326008)(2616005)(426003)(47076005)(16526019)(83380400001)(5660300002)(36756003)(2906002)(186003)(478600001)(40460700003)(6666004)(6916009)(70206006)(70586007)(86362001)(44832011)(8936002)(82310400005)(1076003)(66899018)(81166007)(356005)(8676002)(36860700001)(7696005)(336012)(26005)(40480700001)(41300700001)(54906003)(82740400003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 21:54:43.0332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4181ffe5-6aca-4f5a-1561-08db063141e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 Arvind Yadav <arvind.yadav@amd.com>, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

MQD describes the properies of a user queue to the HW, and allows it to
accurately configure the queue while mapping it in GPU HW. This patch
adds:
- A new header file which contains the userqueue MQD definition for
  V11 graphics engine.
- A new function which fills it with userqueue data and prepares MQD
- A function which sets-up the MQD function ptrs in the generic userqueue
  creation code.

V1: Addressed review comments from RFC patch series
    - Reuse the existing MQD structure instead of creating a new one
    - MQD format and creation can be IP specific, keep it like that

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  28 ++++
 .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 132 ++++++++++++++++++
 drivers/gpu/drm/amd/include/v11_structs.h     |  16 +--
 4 files changed, 169 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 764801cc8203..6ae9d5792791 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
 
 # add usermode queue
 amdgpu-y += amdgpu_userqueue.o
+amdgpu-y += amdgpu_userqueue_mqd_gfx_v11.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 625c2fe1e84a..9f3490a91776 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -202,13 +202,41 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
     return r;
 }
 
+extern const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs;
+
+static int
+amdgpu_userqueue_setup_mqd_funcs(struct amdgpu_userq_mgr *uq_mgr)
+{
+    int maj;
+    struct amdgpu_device *adev = uq_mgr->adev;
+    uint32_t version = adev->ip_versions[GC_HWIP][0];
+
+    maj = IP_VERSION_MAJ(version);
+    if (maj == 11) {
+        uq_mgr->userq_mqd_funcs = &userq_gfx_v11_mqd_funcs;
+    } else {
+        DRM_WARN("This IP doesn't support usermode queues\n");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
 {
+    int r;
+
     mutex_init(&userq_mgr->userq_mutex);
     idr_init_base(&userq_mgr->userq_idr, 1);
     INIT_LIST_HEAD(&userq_mgr->userq_list);
     userq_mgr->adev = adev;
 
+    r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
+    if (r) {
+        DRM_ERROR("Failed to setup MQD functions for usermode queue\n");
+        return r;
+    }
+
     return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
new file mode 100644
index 000000000000..57889729d635
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
@@ -0,0 +1,132 @@
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
+#include "v11_structs.h"
+#include "amdgpu_mes.h"
+#include "gc/gc_11_0_0_offset.h"
+#include "gc/gc_11_0_0_sh_mask.h"
+
+static int
+amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+    uint32_t tmp, rb_bufsz;
+    uint64_t hqd_gpu_addr, wb_gpu_addr;
+    struct v11_gfx_mqd *mqd = queue->mqd_cpu_ptr;
+    struct amdgpu_device *adev = uq_mgr->adev;
+
+    /* set up gfx hqd wptr */
+    mqd->cp_gfx_hqd_wptr = 0;
+    mqd->cp_gfx_hqd_wptr_hi = 0;
+
+    /* set the pointer to the MQD */
+    mqd->cp_mqd_base_addr = queue->mqd_gpu_addr & 0xfffffffc;
+    mqd->cp_mqd_base_addr_hi = upper_32_bits(queue->mqd_gpu_addr);
+
+    /* set up mqd control */
+    tmp = RREG32_SOC15(GC, 0, regCP_GFX_MQD_CONTROL);
+    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
+    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
+    tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
+    mqd->cp_gfx_mqd_control = tmp;
+
+    /* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
+    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
+    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
+    mqd->cp_gfx_hqd_vmid = 0;
+
+    /* set up default queue priority level
+    * 0x0 = low priority, 0x1 = high priority */
+    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY);
+    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
+    mqd->cp_gfx_hqd_queue_priority = tmp;
+
+    /* set up time quantum */
+    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_QUANTUM);
+    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
+    mqd->cp_gfx_hqd_quantum = tmp;
+
+    /* set up gfx hqd base. this is similar as CP_RB_BASE */
+    hqd_gpu_addr = queue->queue_gpu_addr >> 8;
+    mqd->cp_gfx_hqd_base = hqd_gpu_addr;
+    mqd->cp_gfx_hqd_base_hi = upper_32_bits(hqd_gpu_addr);
+
+    /* set up hqd_rptr_addr/_hi, similar as CP_RB_RPTR */
+    wb_gpu_addr = queue->rptr_gpu_addr;
+    mqd->cp_gfx_hqd_rptr_addr = wb_gpu_addr & 0xfffffffc;
+    mqd->cp_gfx_hqd_rptr_addr_hi =
+    upper_32_bits(wb_gpu_addr) & 0xffff;
+
+    /* set up rb_wptr_poll addr */
+    wb_gpu_addr = queue->wptr_gpu_addr;
+    mqd->cp_rb_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
+    mqd->cp_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
+
+    /* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
+    rb_bufsz = order_base_2(queue->queue_size / 4) - 1;
+    tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
+    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
+    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
+#ifdef __BIG_ENDIAN
+    tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
+#endif
+    mqd->cp_gfx_hqd_cntl = tmp;
+
+    /* set up cp_doorbell_control */
+    tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
+    if (queue->use_doorbell) {
+        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
+                    DOORBELL_OFFSET, queue->doorbell_index);
+        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
+                    DOORBELL_EN, 1);
+    } else {
+        tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
+                    DOORBELL_EN, 0);
+    }
+    mqd->cp_rb_doorbell_control = tmp;
+
+    /* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
+    mqd->cp_gfx_hqd_rptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_RPTR);
+
+    /* activate the queue */
+    mqd->cp_gfx_hqd_active = 1;
+
+    return 0;
+}
+
+static void
+amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
+{
+
+}
+
+static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr *uq_mgr)
+{
+    return sizeof(struct v11_gfx_mqd);
+}
+
+const struct amdgpu_userq_mqd_funcs userq_gfx_v11_mqd_funcs = {
+    .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
+    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
+    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
+};
diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
index b8ff7456ae0b..f8008270f813 100644
--- a/drivers/gpu/drm/amd/include/v11_structs.h
+++ b/drivers/gpu/drm/amd/include/v11_structs.h
@@ -25,14 +25,14 @@
 #define V11_STRUCTS_H_
 
 struct v11_gfx_mqd {
-	uint32_t reserved_0; // offset: 0  (0x0)
-	uint32_t reserved_1; // offset: 1  (0x1)
-	uint32_t reserved_2; // offset: 2  (0x2)
-	uint32_t reserved_3; // offset: 3  (0x3)
-	uint32_t reserved_4; // offset: 4  (0x4)
-	uint32_t reserved_5; // offset: 5  (0x5)
-	uint32_t reserved_6; // offset: 6  (0x6)
-	uint32_t reserved_7; // offset: 7  (0x7)
+	uint32_t shadow_base_lo; // offset: 0  (0x0)
+	uint32_t shadow_base_hi; // offset: 1  (0x1)
+	uint32_t gds_bkup_base_lo; // offset: 2  (0x2)
+	uint32_t gds_bkup_base_hi; // offset: 3  (0x3)
+	uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
+	uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
+	uint32_t shadow_initialized; // offset: 6  (0x6)
+	uint32_t ib_vmid; // offset: 7  (0x7)
 	uint32_t reserved_8; // offset: 8  (0x8)
 	uint32_t reserved_9; // offset: 9  (0x9)
 	uint32_t reserved_10; // offset: 10  (0xA)
-- 
2.34.1

