Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4D1ECE587
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18D6110E682;
	Mon,  9 Sep 2024 20:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wPIFDt0w";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E5F610E682
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQs7TXAzHvuu0rhj6zP/wtB8KTxp/QaQ66S2ueBMD7GqHbXU8Wuz2dcCJGF7nvNqoQc+sC2UXcDkT+bvYJ2UOmmLYDjOTlBLZJjHr696MUzL3HTtR5O5ZluV+1wUOfotkt9A+1fCvfos3dYzoxoS4BPg1Vt5BIkjl5f7+IIhJwxPYLAdr/hSb69nRxB13kUX76rZiI9TkJN72cnLUmaq6Lo50ciXKImhlR7cBIVUiPFwc1CGHv+n4F5S1BpP6U0XTT55mcm9gr8aHIKpjlSLF/blIuL/G6cHeUnbwG7ii4E/7kFMBxbBHsAGwCQzpm396BjcBp4PU7qvTQUJwm4TkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kd8GGhIXzlykbNTMZ7Mwio9EToO5wEXQxNviOEM9wus=;
 b=C7F4a4zBmclW7jsSGq6cxRQIjodkaoX+WgeSr4razobbM7TllBhd9nyQIF0nHKpOi8A/SC4iHz04F4xUAuvG4q1dD4iYeyF/Vhx0NKjSl2+863o2f63SutHQnaKdTxLE35A1YkVFvnRDUo3Rr6x6nzaBQyc0DRct6Ldj/CiimS+CMeIJKxHQl654vejs4/84kh8XE+cc7L5C/k6kCEI+pdI5aOdgtTE6ObNX6S/f6GW6F1M1mGP2fOz5QEtINXsCQh3ewvKscMYQncWI/aC+1xDYPekpGRiSEFUb+DNPNgZ4Dm77P+D3wZaNia1gDlFizbqGZ2tICpFWtTkMMmfmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd8GGhIXzlykbNTMZ7Mwio9EToO5wEXQxNviOEM9wus=;
 b=wPIFDt0wR9eYblTR6l5a9xYHJFMdDC6z7HzSJtzbaDUcUApG+7o1TIofjd9GEmbQtd6xDBPcCN1MFM3mFkG7HyelH6gqX3ELyysstiunW4dWLfKLQocJ4o6dnpNJnVPb/nfL3cKWb96aHqIeXZ29pYCBaXgbzxSLiOwxSKQoZHU=
Received: from PH7P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::33)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 9 Sep
 2024 20:07:04 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::4) by PH7P223CA0025.outlook.office365.com
 (2603:10b6:510:338::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 20:07:03 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:00 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v11 05/28] drm/amdgpu: create MES-V11 usermode queue for GFX
Date: Mon, 9 Sep 2024 22:05:56 +0200
Message-ID: <20240909200614.481-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ad19e7-41f9-43b9-1002-08dcd10af8f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x79sRgi4+nju2E4ENgvVvtsCEtvSSX9esmPhQUGEBNtsvcPcO5/F2bA0eVV9?=
 =?us-ascii?Q?xUEVtFiN7pzw4eBE2ATIfDepsjR2xea80zoMuix8fnbFtmlRzNn/9ghhfTlN?=
 =?us-ascii?Q?F2GiF/wd0a2ZiKCDDPRPP3xn2+45tndhzLg+JUkqi6lzROu/x4BOTunEtNBz?=
 =?us-ascii?Q?J+YcUVgxXFFd8jzKC1LWxtsDaxOt5uXlGEEdsUew//PHMRli0arDKoOkZS2H?=
 =?us-ascii?Q?mytQ7M5DLmkIWaV8rleTBhqZsrK2uwdfRTQZukIWafKBGNab5i6+UoQir5Jv?=
 =?us-ascii?Q?BSDfFk6jhmKVKGvqOTjXRc/nS8T2t/HFVEhoQtOuYSpZKEZoJYGKWYvQgYJk?=
 =?us-ascii?Q?S/cUsRFHi3Un9kVxAwr71ipbAv3yiLdunqqCwNXGdAeb2vBi3ZfhVjQwEbxk?=
 =?us-ascii?Q?lt37tFp8ox560Bo4Azf8oRHA/sfZzoyb3ViNJkR2XBS5yLqf5kha66csg83t?=
 =?us-ascii?Q?V7EROdFwREytnt3W6gGbngu2wQKVEvf45goDe+Z3NO3YlXx8Pybaf8mjDC9y?=
 =?us-ascii?Q?fYEcvTu9fr3QOPi9xQEEABFC6WpaMEsb90nMLA1w95OR9882OEd0UcWX59dU?=
 =?us-ascii?Q?mNWcG8IPtPziGFuXEz6HgBLOlP0zyqd3HfzRx2Nz7aZHeSFopWvvWoXuBQZP?=
 =?us-ascii?Q?euQNj/EfNBniyThcEpJNLJ8poIFlN3cIorWDaJYE+29h6XZaULAga/AlDz2S?=
 =?us-ascii?Q?/wiaeZFndWSe+f2nr0zU6ygsy4wc3jFDLwCz+Sb0OklDcO53h3McPpfCJfyq?=
 =?us-ascii?Q?NzC3+640/v7Urk+zqEWbi/EQVKyCtxNcWuGRor//P224YcyKHiCu7eOkuc+3?=
 =?us-ascii?Q?USQcsZHiHP7guUHjyVaP08ssV1nf1rS/csyrJHBK3WHul6R2thvQN/Ve3CQS?=
 =?us-ascii?Q?M11cYNHBjrQfFaRHfRQn22GUi6BJnclUc2vH/raFeprRXrxcvQNuyt7hyo/i?=
 =?us-ascii?Q?C+/wZHJ1F7vv3wxR0z1bdoVh1GvIW9+DNOgZgRmkrIMCl46IaJE3wKZy0LXp?=
 =?us-ascii?Q?NPAhLUIH/Sx6EGN417NVUHE6er9t8+z2hjj3HeZsPjNAc3tixQ2tLzDDBbDQ?=
 =?us-ascii?Q?rbUQqoNaafrJiVMdK8CQTb5SQwL/dXsaqIJi6uXzHYBuBkyC95t3/Ln9NNLL?=
 =?us-ascii?Q?qKiy/99gCd2Tw4fmryJEWO1+q7pac6dJdLayzeTVrxs1Idk7HGNOa6jqtROx?=
 =?us-ascii?Q?nIbzS+IjePdjAuenFSg3WI8JIxy2dfr6f2sMBPMFJzEFoCs5wOzLXBYHT0xU?=
 =?us-ascii?Q?ydHBkp72OqXKNtDHptdLaHzMLf+GEVyopW6JEBVVJV6BI91qvay/in7i9d+3?=
 =?us-ascii?Q?30Ry7H4rc/xbDd/Dm1qJfDZout6mN5e/7lTWuo+/UEZ6ETHlGx9GBJFwlwLJ?=
 =?us-ascii?Q?AwAwbX0EcPLE/VnfVB+DG+GRPkSML0aa6tusXkFDfBQnVmpuynVT/UkyLrgB?=
 =?us-ascii?Q?B+Hp3iBfKFUb3nPKPlzuj/sGXzeQZdDZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:03.5609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ad19e7-41f9-43b9-1002-08dcd10af8f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
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
Change-Id: I855f895a4822ef015957542bc17eabb166b792e6
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  3 +-
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 98 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h  | 30 ++++++
 3 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index dcf64b965bdf..d9bf70251eba 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -173,7 +173,8 @@ amdgpu-y += \
 amdgpu-y += \
 	amdgpu_mes.o \
 	mes_v11_0.o \
-	mes_v12_0.o
+	mes_v12_0.o \
+	mes_v11_0_userqueue.o
 
 # add UVD block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
new file mode 100644
index 000000000000..63fd48a5b8b0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -0,0 +1,98 @@
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
+	struct drm_amdgpu_userq_in *mqd_user = args_in;
+	struct amdgpu_mqd_prop *userq_props;
+	int r;
+
+	/* Structure to initialize MQD for userqueue using generic MQD init function */
+	userq_props = kzalloc(sizeof(struct amdgpu_mqd_prop), GFP_KERNEL);
+	if (!userq_props) {
+		DRM_ERROR("Failed to allocate memory for userq_props\n");
+		return -ENOMEM;
+	}
+
+	if (!mqd_user->wptr_va || !mqd_user->rptr_va ||
+	    !mqd_user->queue_va || mqd_user->queue_size == 0) {
+		DRM_ERROR("Invalid MQD parameters for userqueue\n");
+		r = -EINVAL;
+		goto free_props;
+	}
+
+	r = amdgpu_userqueue_create_object(uq_mgr, &queue->mqd, mqd_hw_default->mqd_size);
+	if (r) {
+		DRM_ERROR("Failed to create MQD object for userqueue\n");
+		goto free_props;
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
2.45.1

