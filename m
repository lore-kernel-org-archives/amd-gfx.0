Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB7CC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1BA11240B;
	Fri, 26 Apr 2024 13:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l5FJziQb";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5B1112409
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1YE6shjI8+tIl89EUbitzLAZVWAxhwEZj1B3c8krXjFjgyDDiUVc/Q+1R/Q/kP0vfbjt1D77CJTv2/nnr88RoMRTwtKzc+ghwYVw0prI96TRLlQM8bSP1LZUzcyRC3C21FsEww0yMr2i/yFqpPkOLsRG0C3wtYqBAmkUqg6dxmktWupVC5wTp2paEI2ZZiy4soG4OmxkbMP00QVE8yX62FBt8oIji7dwGGxgXhTz194LUeg2ZyHmxo4iM4JCTsMKdrSkltkSNJC4d5zt/314CAPwBUcfF/Q+XLRw/Pc0rr9SFPbdiWKSbKuW7kqAl6L9Lm31N4L45QLsGmPMS3d3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuwgTWk65g5HiKRKlYupjFVsDrJtPuptYz/uP0Ymz2A=;
 b=FcT7ZA67r+gd97jY3MjZYQa6Iu62ozoQuoi2HLa4gu6jpQ5VWCrfFR/hqr12i9tSZ6GXr2K+RBpWKH/8KVs3OL1j95pnIDuwP074eOyc13jipXpCdBBumMO1TXAPJoJ8BP6Yat0GDJ2JWOfI4NY+hA8Y71Fl8DUI2XjESksGBZfFl0j1iJuOpFV0Itdjj3sHstkurDk8Kh8/sZAvLPewYGKA6tE+pupAYPg2WCVyDbF/5PdESMQWe9QOGnPqJx5A5UliVJ+s/rtr7hx1w4fX93iv9/232McmWez6Y6YQ5Y8FIphBxljmVkj3E8bwMfM7FDzuzEe8SnYLSbvRRs1buQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuwgTWk65g5HiKRKlYupjFVsDrJtPuptYz/uP0Ymz2A=;
 b=l5FJziQbneFB6MxkUFQd9JgoZjV5nIEb0xdwW7dvEQDfkSL3WhehvCm8qSge+FdIk/0wNF/9JVnUhtDXfCct2uNU/Pd+G0crE1rOdkdIntNYmZbK2CiwH7jWVD6FT81O0v5U/USWlQmqQhPPhXUP7VNF/4326FBmn0pdQXOPaNE=
Received: from CH0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:610:cc::19)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 13:48:45 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::80) by CH0PR03CA0074.outlook.office365.com
 (2603:10b6:610:cc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.42 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:44 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:43 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v9 05/14] drm/amdgpu: create MES-V11 usermode queue for GFX
Date: Fri, 26 Apr 2024 15:48:01 +0200
Message-ID: <20240426134810.1250-6-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: cd3899e5-bdf4-4b29-a87a-08dc65f79752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400014|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y1NP/20xt00PrYdOmJVVQ6sE1x2KjvSGw9u+vVrRU4f6+ivKvBtDAf+ilk2p?=
 =?us-ascii?Q?6uGnVPieSPee6PVtltAbfvAVq/XED+4rc4bBbCGmkXnTTFJj8fLvGU78xXfV?=
 =?us-ascii?Q?xoZAevNYMfIMW20UyRPaHnk5gzoHbmnFF04xjqke8POz8Q4YnQku6M/d2229?=
 =?us-ascii?Q?+YAxrx2N/MTYSg29NmGy46eRW2F0HfzcUcZuodG/vuRfriI8OJ1QWV2Ruiw2?=
 =?us-ascii?Q?gb2ulI0AUk8OSOTQpAII0Un9hjDPZIDvOIQ6cM7Mcqz6Jq5idmQql6gA8r7T?=
 =?us-ascii?Q?HFro9f9u59KAle56No1Ngb1mY/K9aTZs5A2NrwS7zABaYlJDBwo15RbFX+SW?=
 =?us-ascii?Q?kP7yZ7Kksc3qbdqoxAO2qaaIVJ2TU/RF1/Ufk56WvxCKfixdVWs8/TwlwWwH?=
 =?us-ascii?Q?kJmPjq8OIdOK/rjV2QqNW1/e1RIOg02KPrUz0Fld7kDhm0KdCxlmbfUwAqIp?=
 =?us-ascii?Q?2WrVqZNIA6zXMVOO+ElBjXi6OW7sQUIqrKCZy2LB0wQljQw+yZv5D4Dc9dDN?=
 =?us-ascii?Q?q4UJ47+E7Iizh1GItU5ia0Sp8klhPWaoeI1/lE5brp2LF3Tf9LUkWWhEp7hj?=
 =?us-ascii?Q?YGsnwM/0djzYQUKR0C5sF2BdMfKlUzRzBrhBIhzS+mbFWHnILMMf91KbP16B?=
 =?us-ascii?Q?iAHqysqaA9mpAhd14Ilx5jBIumO3NSIXYiHNHrqJBV1FhHSy5e1clGsWZbwk?=
 =?us-ascii?Q?U8Bj0hfCCqGooOn2DFHuDVJ4/I/mOq+NuhaIBI5ycREUdeWwA28/7lNcKO94?=
 =?us-ascii?Q?EArco9nNxuSzxw54FPTnd8t1VNXDi47kPrl0my1os1Nn2Un7Bn9ihuQALNcY?=
 =?us-ascii?Q?We1NfERmmurzyOp/I9/EL2kwUDPlo/S6wZILarBVzcKq7dOYgASJFWA4+Id+?=
 =?us-ascii?Q?UDqnAU47RGWkI71ONk7S0a4LbK+eEkR3Va75tGvJJou9n+5/3KWKm9x8eByQ?=
 =?us-ascii?Q?sIo9OYzkazIK1UGJfayBLGmLVaFjoxMjkG7rpiCv+cwlDvpM2gqn3mINRrGb?=
 =?us-ascii?Q?M4nmvDu8zAsaqp/l+9K9MzeukVJHVBp9TYcjW3ovVwDKW/tqVrF2VsbEDnOj?=
 =?us-ascii?Q?11G0QuuT8K1/gWuQJBQGMVgG9hSVNrY2aZQmmHiYB+vJhivtl6PZ6E1/0vbt?=
 =?us-ascii?Q?WmZrCLF9d8fkGEXeLrks69F0XdketCH+dUy6GFHrpS/L0y6lsSczwFRiAb78?=
 =?us-ascii?Q?ZczPxAj3qsXI3CMSv0ANMQGc26Y0hO4uNRBZDcXxa2bespsa7iV9C0TPx9rI?=
 =?us-ascii?Q?8PltrVmgfqvcZGyhSncmbj4YKxKn3n+JI+azdgh+bC5f/RgcDJEeoTuupoX+?=
 =?us-ascii?Q?EeZwetRjUzdBqtLsoYGgu1kCqUfZnkioORa9tOxG5CmZRK2vUMJCkpE2zmjJ?=
 =?us-ascii?Q?jtDFhbLmhZDD3eYGrOUWma29P51t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:44.8622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3899e5-bdf4-4b29-a87a-08dc65f79752
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
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
- Adds new functions to create and destroy userqueue MQD for
  MES-V11 for GFX IP.

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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 110 ++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 05a2d1714070..a640bfa468ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -184,7 +184,8 @@ amdgpu-y += \
 amdgpu-y += \
 	amdgpu_mes.o \
 	mes_v10_1.o \
-	mes_v11_0.o
+	mes_v11_0.o \
+	mes_v11_0_userqueue.o
 
 # add UVD block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f7325b02a191..525bd0f4d3f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1331,6 +1331,8 @@ static int gfx_v11_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
+extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;
+
 static int gfx_v11_0_sw_init(void *handle)
 {
 	int i, j, k, r, ring_id = 0;
@@ -1347,6 +1349,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1358,6 +1361,7 @@ static int gfx_v11_0_sw_init(void *handle)
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 4;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		break;
 	default:
 		adev->gfx.me.num_me = 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
new file mode 100644
index 000000000000..9e7dee77d344
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -0,0 +1,110 @@
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
+#include "amdgpu_userqueue.h"
+
+static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
+				      struct drm_amdgpu_userq_in *args_in,
+				      struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+	struct drm_amdgpu_userq_mqd *mqd_user;
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
+	if (args_in->mqd_size != sizeof(struct drm_amdgpu_userq_mqd)) {
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
-- 
2.43.2

