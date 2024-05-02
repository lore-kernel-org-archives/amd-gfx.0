Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E66C25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 16:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857B6112571;
	Thu,  2 May 2024 16:32:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="49QJ0pxR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DEC2112583
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 16:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWdjCrXWnwSYmTmsbG61VhRp2kINKPy0lHZyg3PNno7HeMqDKeLUnI+rI1BpUoDKqUF+ORgNV9i/sMGMDK/aTKitRvXFS2IuK5Tjwa4tKjt9gjMRosIhx6CJeGzE4RvfCJTT7Esjx+OTiXyBbNJD9MfG0QuJZssQgVUHlZXEkOVZOO3hPZIoB9+aq5KgXXNfK/mrUybg6J5uQmL03qA1T1REgd8Cg3gTTzxCDm7aSqjmcmODN3LYErfzIxl1rHcszlunH92o3UhQh8x+Rs8lYaoaTedIZByr4IEstLcE0yZlMOvfN/ygPJny13J7Izdv9sXupiKa4vkf3j/q2XD3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYz2kd8RKOyrJnePrESFtMRUuze+yZ2VDjxckAB+a9U=;
 b=hkvuk3mRB1IU/lm67ODcqmww5kUWiEp7QS3mFkgALCt9praudBoecUvhcu6ZKq9B9N8LarszWUQvdYgZX3KVckMwZkETNp8EcZ8xaRCULB2lHtGrMJV0OPeuuRLIlDjYEd3H2nLEbkMJGfwbVYLa9BlFtqMCTui7AEn06TJZP195tGYSUnJfv0t9ydhDEPWPAIq8x/B+6PfnEA+DY3aSG3LiZj61/MXL6FBNxGHRzUF2khqu4B+/BqE0kaj1aXazOvdkLWv/3tvUrPkSNTzGnjqF+gdFApLnPvT8dlSuo/tkYV+CDT0HD+/zlZ1hqKs0BV25BVS2lcYzK/yxf3j08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYz2kd8RKOyrJnePrESFtMRUuze+yZ2VDjxckAB+a9U=;
 b=49QJ0pxRrmElzxpPopOw9KQ+8eEp8+NkZXrgezJ/3vQZTwOdw9Wb+B5jeiJjyCf9mdPGcCegzN6P6+Nl0IvV/wA0O3a+XqebxUURHg50p5YReKlx92Adh9wbMM4Ft1LaUXTOGrKmPlQG6yWqecK0ZDHKgiVTZOrL8Xwi3XhHLSc=
Received: from CH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:610:32::20)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 16:32:35 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::5f) by CH0PR07CA0015.outlook.office365.com
 (2603:10b6:610:32::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 16:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 16:32:34 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 11:32:27 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v10 05/14] drm/amdgpu: create MES-V11 usermode queue for GFX
Date: Thu, 2 May 2024 18:31:42 +0200
Message-ID: <20240502163152.1382-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240502163152.1382-1-shashank.sharma@amd.com>
References: <20240502163152.1382-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: a2825c40-8b23-4bc6-9201-08dc6ac578be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gxLZ24eDFbYErI4f+vqj+haIk5ye7TonaFDDqxEUN1SPZ0DcGQG0QlHVXi/s?=
 =?us-ascii?Q?nT4ojt8QGERorECIM5xm3sbsZ8/H5I1j6t9bCAZ2jLz9EK0QwrJfzwsSKGFm?=
 =?us-ascii?Q?bc8sJb8CCio9dZesvjUrjO39zi4PKAzyteXkEF2385IeHxz9BSDnaFZCIWjT?=
 =?us-ascii?Q?QyciUJgL2JAgaOd59RwBWRF/KPW0be5POFB2Q5LFtqpAE1+UXTgF4dVJZVXo?=
 =?us-ascii?Q?cOtwne5sLFfogkgNtfGUqpHwTDQVj629E+ujaC+PAbTfLP3Tuo1XZIujy7V2?=
 =?us-ascii?Q?UtZXmiEmF9MT/Mp1NlSvPvJofus6iWZJh0f+cg4FZ7/+RiEZs0nAug8xe+gj?=
 =?us-ascii?Q?93mu/UbVqmsgAzL9r6MKKxNaDfFjHLU9DXmv0Z4goLKSBL56p7Z3DnSPkwT7?=
 =?us-ascii?Q?Eg7CoCz7tpOR8YmjlMQLuHjY2Bq6AKdUgXr+vOy1L3qp5WTP3QmqwVW3ZJJL?=
 =?us-ascii?Q?maSzK01Q1Dt/euJdzChJrNy3xD4ehBD8xGs6qjPlykU5vYbqV4kYMkLk12MM?=
 =?us-ascii?Q?Hy1tuKHUIkd80UGFH33iJA2fif/BZNXMwBTygTvOOTRMwsMYztl+NUha8mHL?=
 =?us-ascii?Q?89LQjW0PCPZBx7uHDQb1Q18TLlmMhwE787btqkg7uOQqZy9HpfXuVSczpaZC?=
 =?us-ascii?Q?oCqjZe3jA4PcjETiESP2+eOTgXF//4IRFWSOfcpo9CURtBMqP7A8P05y9HT9?=
 =?us-ascii?Q?U3mWA7BHQAX5IR2ZDdiQimnQKNeYIDWJVol7LCT9w1i4Umta98lwrRu4aOKX?=
 =?us-ascii?Q?Uej+jyB3jhqzewrlyPvlyPrsVFBEa6AWP3MikYHfCF7QVLGNrr/cz+RBKSHC?=
 =?us-ascii?Q?tw9JbdBC0ciF7aYpqih1TM2u3HvPYSrqQgXdRJTTb17adgKVGSWa5DfByoNP?=
 =?us-ascii?Q?GZlLlyo/kkAyAkdhHS9kd7IdaG2TasYf8U4eFNMMnOk6ugJ4oHWCzVg/9gMq?=
 =?us-ascii?Q?1txRhoJ7ECYmO5xTiDDV2KjM2YURflOWHpsI39l/dW2KtvVCrDWQa87OpJQF?=
 =?us-ascii?Q?TIlRZf4ilfog+uE+Jno/lojTM4dHDPXJRsYMHZJT3SkUHIh6gu7RhxzacWYC?=
 =?us-ascii?Q?5yI+657pRHiHjXTmT0Pg2AynSanbCkTcPlP5E8kuOmEjDOw4yOSkdqiHG5dI?=
 =?us-ascii?Q?6V9zf1hEQxiVDp+19yKou9ugVO5fuVP4/+pzAFUb3xprL/QRhs5/L41cf5Yo?=
 =?us-ascii?Q?o8y8iaY5UM2RqwlprAnRq88dQCXaON8CTAAKC+8KVheM9Eh98c9OPrbg2Xr+?=
 =?us-ascii?Q?x425eojbd+nts6qy8dpLQyHFwGN7YFPxoETjzX901mpLAq2EsmFwmLkkURkT?=
 =?us-ascii?Q?Ton/rP3WpuMOri/dqrJ7LssSEMZbI4fXEsiDYybm7kvpgT0gBDjJnOTbQAnw?=
 =?us-ascii?Q?k02bvc5A9a71smj9+D/ozIn2icQ1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:32:34.4905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2825c40-8b23-4bc6-9201-08dc6ac578be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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

A Memory queue descriptor (MQD) of a userqueue defines it in
the hw's context. As MQD format can vary between different
graphics IPs, we need gfx GEN specific handlers to create MQDs.

This patch:
- Adds a new file which will be used for MES based userqueue
  functions targeting GFX and SDMA IP.
- Introduces MQD handler functions for the usermode queues.

V1: Worked on review comments from Alex:
    - Make MQD functions GEN and IP specific

V2: Worked on review comments from Alex:
    - Reuse the existing adev->mqd[ip] for MQD creation
    - Formatting and arrangement of code

V3:
    - Integration with doorbell manager

V4: Review comments addressed:
    - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
    - Align name of structure members (Luben)
    - Don't break up the Cc tag list and the Sob tag list in commit
      message (Luben)
V5:
   - No need to reserve the bo for MQD (Christian).
   - Some more changes to support IP specific MQD creation.

V6:
   - Add a comment reminding us to replace the amdgpu_bo_create_kernel()
     calls while creating MQD object to amdgpu_bo_create() once eviction
     fences are ready (Christian).

V7:
   - Re-arrange userqueue functions in adev instead of uq_mgr (Alex)
   - Use memdup_user instead of copy_from_user (Christian)

V9:
   - Moved userqueue code from gfx_v11_0.c to new file mes_v11_0.c so
     that it can be reused for SDMA userqueues as well (Shashank, Alex)

V10: Addressed review comments from Alex
   - Making this patch independent of IP engine(GFX/SDMA/Compute) and
     specific to MES V11 only, using the generic MQD structure.
   - Splitting a spearate patch to enabling GFX support from here.
   - Verify mqd va address to be non-NULL.
   - Add a separate header file.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 117 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h  |  30 +++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 2d421f17626d..987fabb2b2c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -189,6 +189,7 @@ amdgpu-y += \
 	amdgpu_mes.o \
 	mes_v10_1.o \
 	mes_v11_0.o \
+	mes_v11_0_userqueue.o \
 	mes_v12_0.o
 
 # add UVD block
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
new file mode 100644
index 000000000000..75d7c58418c8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
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
+#include "amdgpu_gfx.h"
+#include "v11_structs.h"
+#include "mes_v11_0.h"
+#include "mes_v11_0_userqueue.h"
+
+static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
+				      struct drm_amdgpu_userq_in *args_in,
+				      struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_in *mqd_user;
+	struct amdgpu_mqd_prop *userq_props;
+	int r;
+
+	/* Incoming MQD parameters from userspace to be saved here */
+	memset(&mqd_user, 0, sizeof(mqd_user));
+
+	/* Structure to initialize MQD for userqueue using generic MQD init function */
+	userq_props = kzalloc(sizeof(struct amdgpu_mqd_prop), GFP_KERNEL);
+	if (!userq_props) {
+		DRM_ERROR("Failed to allocate memory for userq_props\n");
+		return -ENOMEM;
+	}
+
+	if (args_in->mqd_size != sizeof(struct drm_amdgpu_userq_in)) {
+		DRM_ERROR("MQD size mismatch\n");
+		r = -EINVAL;
+		goto free_props;
+	}
+
+	mqd_user = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
+	if (IS_ERR(mqd_user)) {
+		DRM_ERROR("Failed to read user MQD\n");
+		r = -EFAULT;
+		goto free_props;
+	}
+
+	if (!mqd_user->wptr_va || !mqd_user->rptr_va ||
+	    !mqd_user->queue_va || mqd_user->queue_size == 0) {
+		DRM_ERROR("Invalid MQD parameters for userqueue\n");
+		r = -EINVAL;
+		goto free_mqd_user;
+	}
+
+	r = amdgpu_userqueue_create_object(uq_mgr, &queue->mqd, mqd_hw_default->mqd_size);
+	if (r) {
+		DRM_ERROR("Failed to create MQD object for userqueue\n");
+		goto free_mqd_user;
+	}
+
+	/* Initialize the MQD BO with user given values */
+	userq_props->wptr_gpu_addr = mqd_user->wptr_va;
+	userq_props->rptr_gpu_addr = mqd_user->rptr_va;
+	userq_props->queue_size = mqd_user->queue_size;
+	userq_props->hqd_base_gpu_addr = mqd_user->queue_va;
+	userq_props->mqd_gpu_addr = queue->mqd.gpu_addr;
+	userq_props->use_doorbell = true;
+
+	queue->userq_prop = userq_props;
+
+	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+	if (r) {
+		DRM_ERROR("Failed to initialize MQD for userqueue\n");
+		goto free_mqd;
+	}
+
+	return 0;
+
+free_mqd:
+	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
+
+free_mqd_user:
+	kfree(mqd_user);
+
+free_props:
+	kfree(userq_props);
+
+	return r;
+}
+
+static void
+mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
+			    struct amdgpu_usermode_queue *queue)
+{
+	kfree(queue->userq_prop);
+	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
+}
+
+const struct amdgpu_userq_funcs userq_mes_v11_0_funcs = {
+	.mqd_create = mes_v11_0_userq_mqd_create,
+	.mqd_destroy = mes_v11_0_userq_mqd_destroy,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h
new file mode 100644
index 000000000000..2c102361ca82
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
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
+#ifndef MES_V11_0_USERQ_H
+#define MES_V11_0_USERQ_H
+#include "amdgpu_userqueue.h"
+
+extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;
+#endif
-- 
2.43.2

