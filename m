Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9EEC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 06:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12D6B10F8AF;
	Mon, 29 Apr 2024 06:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LnAHuWEp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B94A10F4B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 06:44:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMOFOXx0JYl5SzF2tFJ4WT6o8CxYW+UwTFMcWsE0ejZ/1KR/NWnBUwSh67yTZznWzNqkFzI+Xn4CtFYdi4Z2TLMoDbW8znHmmscmYMQZTDrSCzSidRcVwYriyt+9Ty+sJOopfyfCwB/Bc9HesD0exHd1hAC5oDMvzu+BH12U7YGQrlPq1rZD9GJ4cbVYrnnKYbsj5mjo2dZumzj+aMxLoDW3VaGlU4yYFISpOm/uOVcfTuNSavaceCDhal9qwFbROKMPR4N5HygNlEaNlV3a9LHoejTuUSUB02cQBs+ErK37oxmwKBZZsKPkZ3cGa93cVqaoAlXAHvUjL7oPZEa6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfsyxkqDas/L5tUSzkS2vDlua9oflZqrjgebbcScXOA=;
 b=MEr5VtXSEt0lvSXaaCvwYRno7cCO+FyxeOoJl36mY629sYCgxs+gvxQjLGseD10PzxPehHkEOrH74Pb9B5hjrDLOgF87I7TDmXTELeBs/M6U8PM/IRA72ucAIvRRu0zVlCsJ/ijsRtG0+wLEFLfb7YWEdDZCz++q2psOz8mjDtFjGaFwF2xkggb+CnhvMdrWXt//POK8t+xIOhWGUGb8c89ZioyjHDJaEIjcYcOGaB0r1LDxPK7F6nr5i8YcFnZyxpn3lyaIb4Pn673gs3d5tBWwpCbn1JDmAWUoZlX3dBR7J2LYopO4ZZUZwXw9rGmvnP0SNLM5apCbVrzc8+zZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfsyxkqDas/L5tUSzkS2vDlua9oflZqrjgebbcScXOA=;
 b=LnAHuWEp5vA66YhFagwTo22hWNRQ1FB9J8PFrOD7LesvCek6Yg9frhx8xxBTOLnJAvSYc6OZbW55g3a4Vo9mZU/VDIqRUA+g3X0+02NDfoe0jjY5x6LQorK4AAPeeWKCRlAwGmDHtEBvBbiD99R4rq5EmZa8ppD/wx88DiO6MzU=
Received: from DS7PR03CA0180.namprd03.prod.outlook.com (2603:10b6:5:3b2::35)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 06:44:26 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::4) by DS7PR03CA0180.outlook.office365.com
 (2603:10b6:5:3b2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32 via Frontend
 Transport; Mon, 29 Apr 2024 06:44:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 29 Apr 2024 06:44:26 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 01:44:24 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v9 1/5] drm/amdgpu: Implement a new userqueue fence driver
Date: Mon, 29 Apr 2024 12:13:47 +0530
Message-ID: <20240429064351.626929-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba5511d-f7cb-4035-b588-08dc6817cfe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clNxUUNDTUJyK2RkZ2hscmRjYjZudi9FbmRkOTRWYTRRRVJrYjNaMERqMzVs?=
 =?utf-8?B?YWNobWsrS2lPQjg0NFBkcmhnUyt0S3lYVDB2T0ZKN3BmY2dWLy96eUpIbWRE?=
 =?utf-8?B?Q29CdW9GamhtZTYzSFgwb0VLY0hWMEc2RXpBYll3dEVsSFBscmxJT3FvSElC?=
 =?utf-8?B?MW1OQ0JCUGFsNUxaWGNyZUIybnVjL0Y3aStqMWpXWlBHamJMNy8yS2VuWjRE?=
 =?utf-8?B?dzA2S1l0VDU3QlBVeVdna0tlN3grNS9aL3dMRjg1VDhqSGNtZU9wOTF1RFR2?=
 =?utf-8?B?bDZTRFIzNkJ5QnNDN3I4MXlpdXdDUXdOYVo1b2U5dDhoWmVoTDZYbC9Md044?=
 =?utf-8?B?Z2FxOERHQTc2cVcwZklXYnl2cUNMYkFsLzNvc0gxK0RtVmxBaUkvTWRRdXdk?=
 =?utf-8?B?OWRCbW5XVFF6ZGVzTG1BeXdIcnF4dFNPbkRXWjRkc0V6Y014RFd6RVFzV1kv?=
 =?utf-8?B?YkRrWExXN0h1U0pWSEsxRitBdDJKNkhjNFRGaFJiL2dwc3AzTkFyalhwcmdT?=
 =?utf-8?B?MWxJVEVRSFV5QTVZbkNMaGRYdkYwQUsxdHV1bS8zSUlkODdHMkRHMk5vQWM5?=
 =?utf-8?B?akdZVXcwa1pBYk5KS0c3WTRJRUxzRW9Lby9kOEt5bG9pVkxDRWJiVU0zc0dp?=
 =?utf-8?B?d2ZoNW5xMHI5dVNUalZHNVV5QTFQZmxjV3BTa2ZiRkFyTzBqQUJCSFpzMkti?=
 =?utf-8?B?OUE4dlZ3VE1acllGam1YVHIyZWY5TWNaa3FhUWJMSDlBY1ZvMGF4d0U4bzB6?=
 =?utf-8?B?WTRKKzRTajQySmRRYWxTRnNSaklXVURGbE55Ykk3Z01Ea3JvaWdhUXJMa2lq?=
 =?utf-8?B?OGFJTU4yUDNReG02NnRPVzA3SUVzenFVWEU3M1JHZHRWMUh3V2lMYjdpVFlP?=
 =?utf-8?B?NlJvcnBJeWI2cjg5R1JJeUkvNUNvMnBHZE10VjFERkcxZnh2c2dwY29nR1Jn?=
 =?utf-8?B?OHJ4b0xOMEs1LzJGVGpIUndMSERzZDhrUWZtWCtra1lQNllIWmR1Z1pZWWtN?=
 =?utf-8?B?L1F1QkIzb3c3cFp6dWNUYXBpMXpzNGUrMmtVelkzNTlLMGc3VFA1bDBCd1Fu?=
 =?utf-8?B?aHliOWx5TzF1am5taWZOMnoyaWxIZnB0MnNSMTNkekZaSmlxMmQ1SVhWQ1VR?=
 =?utf-8?B?QzJBbUFVcXgzWW43M1ZwZnFNMWI1SFZWN3FlSmVkNWs2RVJMYUdPVy9YWGVZ?=
 =?utf-8?B?clhscGNQc1FnMkdLYWlCQjJZUXpXM1RnOWRrRXRZTDNCNnNodWdEN0h4eHc3?=
 =?utf-8?B?dENjRGp3bVNuTmU0WmRYRmlJUXJ6QStCSGZ0aGwybHNISXFlN1JPRjNmRlJx?=
 =?utf-8?B?N3dNVjAraG5XNnE4dnFMS3NTeDAvbG1iZlJtSFlteTlWTVgwUGcxWFRBNU01?=
 =?utf-8?B?RnZPMXRNZWFyLzNYLzcvUVdqQktKcXI5cTR3Q3ZJeHFLMytNWXI5S05UYkxU?=
 =?utf-8?B?eCs3cSsyM053UXVLbGxzT3pITDdLbkE1N1NWSlpreUxNbXdzR0ovanhuci85?=
 =?utf-8?B?anZDY0FyQWJSeUg4cVdYR28yZnp3NGJrZ1dOaUlLWGFEcUxXQ0NDN1QxdnFa?=
 =?utf-8?B?L3NlcmpCUmVSR2oyOVNMbktXWU83RCt6YmxMbzh2b1ZyYlBrMVFsRVBNSTFJ?=
 =?utf-8?B?eXdUMzRBN0hMNWZ5OTF2NlZQYzYyRFBnTDlRSFUyOElsdmRhQXk2NFVmamxE?=
 =?utf-8?B?c25uYzJYS0lCUExraHAzUG01SlRKOUQ1RFE4NFRZTUM5ekpENE5ES3ZtUjEw?=
 =?utf-8?B?TFN6bmVuY0JSSUQ5NkdjWmY1bS9aRUVlaW56dk5MU2hMVFpkWjI4ZmlWdThD?=
 =?utf-8?B?TUxGMnhQSG10SWoxTFRRRW5Femd3emFtNTdudGwrc1FueCt0MmRqT25IM1pQ?=
 =?utf-8?Q?mGdyk7fYnlXc9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:44:26.0355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba5511d-f7cb-4035-b588-08dc6817cfe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
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

Developed a userqueue fence driver for the userqueue process shared
BO synchronization.

Create a dma fence having write pointer as the seqno and allocate a
seq64 memory for each user queue process and feed this memory address
into the firmware/hardware, thus the firmware writes the read pointer
into the given address when the process completes it execution.
Compare wptr and rptr, if rptr >= wptr, signal the fences for the waiting
process to consume the buffers.

v2: Worked on review comments from Christian for the following
    modifications

    - Add wptr as sequence number into the fence
    - Add a reference count for the fence driver
    - Add dma_fence_put below the list_del as it might
      frees the userq fence.
    - Trim unnecessary code in interrupt handler.
    - Check dma fence signaled state in dma fence creation
      function for a potential problem of hardware completing
      the job processing beforehand.
    - Add necessary locks.
    - Create a list and process all the unsignaled fences.
    - clean up fences in destroy function.
    - implement .signaled callback function

v3: Worked on review comments from Christian
    - Modify naming convention for reference counted objects
    - Fix fence driver reference drop issue
    - Drop amdgpu_userq_fence_driver_process() function return value

v4: Worked on review comments from Christian
    - Moved fence driver allocation into amdgpu_userq_fence_driver_alloc()
    - Added detail doc mentioning the differences b/w
      two spinlocks declared.

v5: Worked on review comments from Christian
    - Check before upcast and remove local variable
    - Add error handling in fence_drv alloc function.
    - Move rptr read fn outside of the loop and remove WARN_ON in
      destroy function.

v6:
  - clear the seq64 memory in user fence driver(Christian)
  - fix for the wptr va bo mapping(Christian)
  - move the fence_drv xa entry erase code from the interrupt handler
    into user fence destroy function

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   6 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 257 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  69 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  12 +-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   5 +-
 6 files changed, 347 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index a640bfa468ad..f8dd808bd71c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -80,7 +80,8 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o
+	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o \
+	amdgpu_userq_fence.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index acee1c279abb..844f7b5f90db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -51,6 +51,7 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_xgmi.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
 
 /*
@@ -3012,6 +3013,10 @@ static int __init amdgpu_init(void)
 	if (r)
 		goto error_fence;
 
+	r = amdgpu_userq_fence_slab_init();
+	if (r)
+		goto error_fence;
+
 	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
@@ -3037,6 +3042,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_acpi_release();
 	amdgpu_sync_fini();
 	amdgpu_fence_slab_fini();
+	amdgpu_userq_fence_slab_fini();
 	mmu_notifier_synchronize();
 	amdgpu_xcp_drv_release();
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
new file mode 100644
index 000000000000..f7baea2c67ab
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -0,0 +1,257 @@
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
+#include <linux/kref.h>
+#include <linux/slab.h>
+
+#include <drm/drm_syncobj.h>
+
+#include "amdgpu.h"
+#include "amdgpu_userq_fence.h"
+
+static const struct dma_fence_ops amdgpu_userq_fence_ops;
+static struct kmem_cache *amdgpu_userq_fence_slab;
+
+int amdgpu_userq_fence_slab_init(void)
+{
+	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
+						    sizeof(struct amdgpu_userq_fence),
+						    0,
+						    SLAB_HWCACHE_ALIGN,
+						    NULL);
+	if (!amdgpu_userq_fence_slab)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void amdgpu_userq_fence_slab_fini(void)
+{
+	rcu_barrier();
+	kmem_cache_destroy(amdgpu_userq_fence_slab);
+}
+
+static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
+{
+	if (!f || f->ops != &amdgpu_userq_fence_ops)
+		return NULL;
+
+	return container_of(f, struct amdgpu_userq_fence, base);
+}
+
+static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	return le64_to_cpu(*fence_drv->cpu_addr);
+}
+
+int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
+				    struct amdgpu_usermode_queue *userq)
+{
+	struct amdgpu_userq_fence_driver *fence_drv;
+	int r;
+
+	fence_drv = kzalloc(sizeof(*fence_drv), GFP_KERNEL);
+	if (!fence_drv) {
+		DRM_ERROR("Failed to allocate memory for fence driver\n");
+		return -ENOMEM;
+	}
+
+	/* Acquire seq64 memory */
+	r = amdgpu_seq64_alloc(adev, &fence_drv->gpu_addr,
+			       &fence_drv->cpu_addr);
+	if (r) {
+		kfree(fence_drv);
+		return -ENOMEM;
+	}
+
+	memset(fence_drv->cpu_addr, 0, sizeof(u64));
+
+	kref_init(&fence_drv->refcount);
+	INIT_LIST_HEAD(&fence_drv->fences);
+	spin_lock_init(&fence_drv->fence_list_lock);
+
+	fence_drv->adev = adev;
+	fence_drv->context = dma_fence_context_alloc(1);
+	get_task_comm(fence_drv->timeline_name, current);
+
+	userq->fence_drv = fence_drv;
+
+	return 0;
+}
+
+void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	struct amdgpu_userq_fence *userq_fence, *tmp;
+	struct dma_fence *fence;
+	u64 rptr;
+
+	if (!fence_drv)
+		return;
+
+	rptr = amdgpu_userq_fence_read(fence_drv);
+
+	spin_lock(&fence_drv->fence_list_lock);
+	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
+		fence = &userq_fence->base;
+
+		if (rptr >= fence->seqno) {
+			dma_fence_signal(fence);
+			list_del(&userq_fence->link);
+
+			dma_fence_put(fence);
+		} else {
+			break;
+		}
+	}
+	spin_unlock(&fence_drv->fence_list_lock);
+}
+
+void amdgpu_userq_fence_driver_destroy(struct kref *ref)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
+					 struct amdgpu_userq_fence_driver,
+					 refcount);
+	struct amdgpu_device *adev = fence_drv->adev;
+	struct amdgpu_userq_fence *fence, *tmp;
+	struct dma_fence *f;
+
+	spin_lock(&fence_drv->fence_list_lock);
+	list_for_each_entry_safe(fence, tmp, &fence_drv->fences, link) {
+		f = &fence->base;
+
+		if (!dma_fence_is_signaled(f)) {
+			dma_fence_set_error(f, -ECANCELED);
+			dma_fence_signal(f);
+		}
+
+		list_del(&fence->link);
+		dma_fence_put(f);
+	}
+	spin_unlock(&fence_drv->fence_list_lock);
+
+	/* Free seq64 memory */
+	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
+	kfree(fence_drv);
+}
+
+void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	kref_get(&fence_drv->refcount);
+}
+
+void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
+{
+	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
+}
+
+int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
+			      u64 seq, struct dma_fence **f)
+{
+	struct amdgpu_userq_fence_driver *fence_drv;
+	struct amdgpu_userq_fence *userq_fence;
+	struct dma_fence *fence;
+
+	fence_drv = userq->fence_drv;
+	if (!fence_drv)
+		return -EINVAL;
+
+	userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
+	if (!userq_fence)
+		return -ENOMEM;
+
+	spin_lock_init(&userq_fence->lock);
+	INIT_LIST_HEAD(&userq_fence->link);
+	fence = &userq_fence->base;
+	userq_fence->fence_drv = fence_drv;
+
+	dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
+		       fence_drv->context, seq);
+
+	amdgpu_userq_fence_driver_get(fence_drv);
+	dma_fence_get(fence);
+
+	spin_lock(&fence_drv->fence_list_lock);
+	/* Check if hardware has already processed the job */
+	if (!dma_fence_is_signaled(fence))
+		list_add_tail(&userq_fence->link, &fence_drv->fences);
+	else
+		dma_fence_put(fence);
+
+	spin_unlock(&fence_drv->fence_list_lock);
+
+	*f = fence;
+
+	return 0;
+}
+
+static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
+{
+	return "amdgpu_userqueue_fence";
+}
+
+static const char *amdgpu_userq_fence_get_timeline_name(struct dma_fence *f)
+{
+	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+
+	return fence->fence_drv->timeline_name;
+}
+
+static bool amdgpu_userq_fence_signaled(struct dma_fence *f)
+{
+	struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	u64 rptr, wptr;
+
+	rptr = amdgpu_userq_fence_read(fence_drv);
+	wptr = fence->base.seqno;
+
+	if (rptr >= wptr)
+		return true;
+
+	return false;
+}
+
+static void amdgpu_userq_fence_free(struct rcu_head *rcu)
+{
+	struct dma_fence *fence = container_of(rcu, struct dma_fence, rcu);
+	struct amdgpu_userq_fence *userq_fence = to_amdgpu_userq_fence(fence);
+	struct amdgpu_userq_fence_driver *fence_drv = userq_fence->fence_drv;
+
+	/* Release the fence driver reference */
+	amdgpu_userq_fence_driver_put(fence_drv);
+	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
+}
+
+static void amdgpu_userq_fence_release(struct dma_fence *f)
+{
+	call_rcu(&f->rcu, amdgpu_userq_fence_free);
+}
+
+static const struct dma_fence_ops amdgpu_userq_fence_ops = {
+	.use_64bit_seqno = true,
+	.get_driver_name = amdgpu_userq_fence_get_driver_name,
+	.get_timeline_name = amdgpu_userq_fence_get_timeline_name,
+	.signaled = amdgpu_userq_fence_signaled,
+	.release = amdgpu_userq_fence_release,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
new file mode 100644
index 000000000000..c3e04cdbb9e7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -0,0 +1,69 @@
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
+#ifndef __AMDGPU_USERQ_FENCE_H__
+#define __AMDGPU_USERQ_FENCE_H__
+
+#include <linux/types.h>
+
+#include "amdgpu_userqueue.h"
+
+struct amdgpu_userq_fence {
+	struct dma_fence base;
+	/*
+	 * This lock is necessary to synchronize the
+	 * userqueue dma fence operations.
+	 */
+	spinlock_t lock;
+	struct list_head link;
+	struct amdgpu_userq_fence_driver *fence_drv;
+};
+
+struct amdgpu_userq_fence_driver {
+	struct kref refcount;
+	u64 gpu_addr;
+	u64 *cpu_addr;
+	u64 context;
+	/*
+	 * This lock is necesaary to synchronize the access
+	 * to the fences list by the fence driver.
+	 */
+	spinlock_t fence_list_lock;
+	struct list_head fences;
+	struct amdgpu_device *adev;
+	char timeline_name[TASK_COMM_LEN];
+};
+
+int amdgpu_userq_fence_slab_init(void);
+void amdgpu_userq_fence_slab_fini(void);
+int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
+			      u64 seq, struct dma_fence **f);
+void amdgpu_userq_fence_driver_get(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
+int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
+				    struct amdgpu_usermode_queue *userq);
+void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_destroy(struct kref *ref);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 98cd07a42623..73d225aa3e1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 
 static void
 amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
@@ -36,6 +37,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
+	amdgpu_userq_fence_driver_put(queue->fence_drv);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
 	kfree(queue);
 }
@@ -55,7 +57,7 @@ amdgpu_userqueue_fence_get_driver_name(struct dma_fence *fence)
 static const char *
 amdgpu_userqueue_fence_get_timeline_name(struct dma_fence *f)
 {
-	struct amdgpu_userq_fence *ef = container_of(f, struct amdgpu_userq_fence, base);
+	struct amdgpu_userq_ev_fence *ef = container_of(f, struct amdgpu_userq_ev_fence, base);
 
 	return ef->timeline_name;
 }
@@ -69,7 +71,7 @@ static const struct dma_fence_ops amdgpu_userqueue_eviction_fence_ops = {
 static void
 amdgpu_userqueue_init_eviction_fence(struct amdgpu_userq_mgr *uq_mgr)
 {
-	struct amdgpu_userq_fence *fence = &uq_mgr->eviction_fence;
+	struct amdgpu_userq_ev_fence *fence = &uq_mgr->eviction_fence;
 	atomic_t seq = ATOMIC_INIT(0);
 
 	spin_lock_init(&fence->lock);
@@ -403,6 +405,12 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 	queue->doorbell_index = index;
 
+	r = amdgpu_userq_fence_driver_alloc(adev, queue);
+	if (r) {
+		DRM_ERROR("Failed to alloc fence driver\n");
+		goto unlock;
+	}
+
 	r = uq_funcs->mqd_create(uq_mgr, &args->in, queue);
 	if (r) {
 		DRM_ERROR("Failed to create Queue\n");
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 5ba18374bfbb..d3738f645adc 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -48,6 +48,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
+	struct amdgpu_userq_fence_driver *fence_drv;
 };
 
 struct amdgpu_userq_funcs {
@@ -58,7 +59,7 @@ struct amdgpu_userq_funcs {
 			    struct amdgpu_usermode_queue *uq);
 };
 
-struct amdgpu_userq_fence {
+struct amdgpu_userq_ev_fence {
 	u64		 fence_ctx;
 	atomic_t	 seq;
 	spinlock_t	 lock;
@@ -71,7 +72,7 @@ struct amdgpu_userq_mgr {
 	struct idr			userq_idr;
 	struct mutex			userq_mutex;
 	struct amdgpu_device		*adev;
-	struct amdgpu_userq_fence	eviction_fence;
+	struct amdgpu_userq_ev_fence	eviction_fence;
 };
 
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
-- 
2.25.1

