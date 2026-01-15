Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FF8D44C56
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 14:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6853610E76D;
	Thu, 15 Jan 2026 14:27:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OTE4iVdN";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562AD10E0AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 14:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbDLS/Nxc2yu1xPgEW0QdjNRTGupGijJ8ccCtlqC2DOU07XjfdiQ5cpB5d30YLE71tTu62gMCkdmCb23Y3uO2+FhHTCPlZzFFBdjRQVtkQjPK44yZCSmVSgpvU8OhY6qYqxku2ne+4PWbuKsCg5DsVRcYjoqTelVwlO76p3JF/s+Q7K2K9wImjyCn9d79PVbc3HqZsdcYgHNVoyX7NbZq3fQeu5raA0aGta6X2nFMb4Q5P6Gb3y7QcECE+9DgcxymQ0kEbMglQVikkEzwbYb4PpMhKmnUhQNC3IZvM11ct9Hl5opsvhsgNf5Yw4cOjVXYcfAq2rpcs0maVNqRHRRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXoKvqJ3V5HwSuMd/0oIyUBt5DiMbSX4ot8OKV50x6Y=;
 b=sJXIWIyZs9CDbvG7tBSQexY770u0sr8zg4W3qHoFMkz+kUW4JB5otaMhRjDw15DHvR4BUXOti1lBuwRe6xMF0O3/jUQ9cbzvpe9cJ1mH89NhvzHJ/QRcijUrw4N3/s5mxkkbG+NGOvkJ3OP0ENzX59eqqlWq5PghO2fozJAas1JFc/Wz8+kvgenOwduYk+oXsIcac5in8zt8Fa8+7vcHs2Tb4+ublYXrd9cr55PclTwFIvfzv3vtb6dPUMnx8//Tw+NVrary3FlqEG9wXMFFfR+0qDLbN5Yg+zmTu8AKOhss6P/Fvk7PY6xJwinbYpZamQhgzrUN8yg0uqvsc8vwcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXoKvqJ3V5HwSuMd/0oIyUBt5DiMbSX4ot8OKV50x6Y=;
 b=OTE4iVdNn9mH6DRGil0JDW26h4kvf6lXEei3UgU9OZC1eZlkJBnkzn7UgW9jWFQkgF/KQ7BB2FrJQO9BGKFtpKaxK7THdrcXCQrTeso6u0UsFTfeS5X4rwJJe8MAHvLjqn5NciVyX8V1sxs8J3EtCY6iQH6nAFQmfC24UdwatOA=
Received: from SN1PR12CA0106.namprd12.prod.outlook.com (2603:10b6:802:21::41)
 by DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 14:27:34 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::b8) by SN1PR12CA0106.outlook.office365.com
 (2603:10b6:802:21::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Thu,
 15 Jan 2026 14:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 14:27:33 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 08:27:31 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <david.belanger@amd.com>, <chris.freehill@amd.com>,
 <harish.kasiviswanathan@amd.com>, <jamesz@amd.com>
Subject: [PATCH] amdgpu: Add amdgpu profiler IOCTL functions
Date: Thu, 15 Jan 2026 09:26:51 -0500
Message-ID: <20260115142651.111180-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS4PR12MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e85d065-91b0-484e-6dd5-08de54423931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TlerTDDeFz3k5Kp9cpr/77uo65fAMaqaRnaqzwG9+0TdDIXXE2n0VLXdCK89?=
 =?us-ascii?Q?cjGFOcsoAGFzJqqwkViJ7utFRSk2/jUB6fy8YWs5Ux8MIy5iXH2qxkzJkpn7?=
 =?us-ascii?Q?p93RlN4kDrxUQwBiKSW0Zwl162mKEI2gOuo+l559lHHiBqVxFoalj5GcQF+v?=
 =?us-ascii?Q?7c3xwCmME5B31UN9bCQEEiz2BAlcLjzbh3Zdg7n4DrE6O75TCf2Wrkh9dqVl?=
 =?us-ascii?Q?9B97LKTnvZkMk7o2X+cqTmNIJkPBzArYDtUzn+s9weCzqxi0dsLywMtvmI/M?=
 =?us-ascii?Q?2ho7wp1Mxeah5k1RZrUR4jiUGbVVzHPFtUF1pvuzvnfwRzMJgUfmxBN/ZNZ0?=
 =?us-ascii?Q?hxdhx2+tCHkXn0sZg3c6g+o2hLHxBW/gScQ0penIg3kAmmM806AhIyQG2d5T?=
 =?us-ascii?Q?L0hyCHdgmC0jnTHj3EXA853/ETqGu4mA8teYc9lRjbH54OgOQKcdn9KBpyaR?=
 =?us-ascii?Q?ynOIHvPkJ7/E8zmzmcd7QOlnFrS2gaf0Uve9BX9qS9mbNqDzNG5UCWs67Ovg?=
 =?us-ascii?Q?7ahIvxxly7D36Q33XlgaOyEtHBJQLWGiZAOOXrbqLWJBOs2hFo5mDQAGstnH?=
 =?us-ascii?Q?NaM5rDeC1e+mDfhZE1fsXXC+2UcFSUcyqJWWHqC6nFlzQMkwxAzLcVJspi0u?=
 =?us-ascii?Q?loqnjEknhbTIHhnN4jmihUN0imVZXEj1nzZfvzv5jZyUKMVcliyTLjwUb4dd?=
 =?us-ascii?Q?iUpxOVsCvkfk4LO3MdFWwNzakfEniXyzedThN7AaeYjwAR6xtZ2+TZgsufgx?=
 =?us-ascii?Q?gUsdgZjkshmlGf7hWw99l7nd/Ny1Thbm92ls64KEuEGeNlwuudoUf2Wugs02?=
 =?us-ascii?Q?w+TY4W6FwS5QrVxYCN9DvPmQ+3RcbRZQkplR55CLmGlhyrMjuNZaLn90LAiA?=
 =?us-ascii?Q?JeDTYw5yd4SwUMqyQd6QfNeby8GMP2ft+cEP3HyD48iUYtW3hvXBAj0fgAME?=
 =?us-ascii?Q?DE+zC51pT72iL8uXXSr8NNDh+6tHCB3H03ySHurY30B+yCimgPJgH95TRcx3?=
 =?us-ascii?Q?Tg7u8Wqg9rc1DBTo3XMwgBCIOb1WJskqOoX/S47pWe5QQp+GVb9LkXV/t8oO?=
 =?us-ascii?Q?5ExWvxmiiovMeFtDEAMHg7exscUozBarIuLYaENdffvlPEFSoylx2J9L0KNv?=
 =?us-ascii?Q?IiwiQi266U00Fa118ro3IlECDBJ+jwmvIR7GNpPvJWqWi5umBRowy13i5dM0?=
 =?us-ascii?Q?YWxpq4K2RS8NvKpf9XEt5cZHn2HIwbwLwok0exTEhA1D2TFMSaubN3QEKvNW?=
 =?us-ascii?Q?VzMm6Kk8t+V2pHNl0iUIqoTXY+E3MbTlE7izV8yWIdgg11JqUhvMq/X1Nc1S?=
 =?us-ascii?Q?vAOYjyb2Th5kNon82H3TkMMGFF6w36NMKrF2fnx0wFtZKxDvyLtd5rFfTaU1?=
 =?us-ascii?Q?yFsmRr1/9EEcnlH7gD2KrMDhOUYSnjfR+qDQzACMqtR0o5AS6a8+DR2ZSjMC?=
 =?us-ascii?Q?b6pbnNfMZ2sN4Zn8A/828grOzrMMeZBsYzDf3sGiAZpLTre3t2JxKvlmPByi?=
 =?us-ascii?Q?zVa46pvXQFPIcqvC/hK3orsuiCoi4Y8GNSw79NTFJFheJYCzWsSp0eI5E9Jv?=
 =?us-ascii?Q?hY/OVyquQy+IaC8s8/r4lsBrmisZJgjken9jvI/wQNxdxGfgZmUOg9rmBLS0?=
 =?us-ascii?Q?m9WuS+3ATte2C9fz0zSxaIOD9MfAGRmU01Kp56Dv7mbyp/ptghLgCd9qYSko?=
 =?us-ascii?Q?ZDSopQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 14:27:33.6698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e85d065-91b0-484e-6dd5-08de54423931
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586
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

to support PMC, PCSampling, SPM etc.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 amdgpu/amdgpu.h          |  6 ++++++
 amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++++
 amdgpu/meson.build       |  2 +-
 include/drm/amdgpu_drm.h | 19 +++++++++++++++++
 4 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 amdgpu/amdgpu_profiler.c

diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
index 39b61539..3f8ab844 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -2072,6 +2072,12 @@ int amdgpu_userq_signal(amdgpu_device_handle dev,
 int amdgpu_userq_wait(amdgpu_device_handle dev,
 		      struct drm_amdgpu_userq_wait *wait_data);
 
+/**
+ * Acquire profiler version
+ * \param   dev               - \c [in]     device handle
+ */
+int amdgpu_profiler_version(amdgpu_device_handle dev);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c
new file mode 100644
index 00000000..8d4dffe4
--- /dev/null
+++ b/amdgpu/amdgpu_profiler.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#include <string.h>
+#include <errno.h>
+#include "xf86drm.h"
+#include "amdgpu_drm.h"
+#include "amdgpu_internal.h"
+
+drm_public int
+amdgpu_profiler_version(amdgpu_device_handle dev)
+{
+	int ret;
+	struct drm_amdgpu_profiler_args user_arg;
+
+	if (!dev)
+		return -EINVAL;
+
+	memset(&user_arg, 0, sizeof(user_arg));
+	user_arg.op = AMDGPU_PROFILER_VERSION;
+
+	ret = drmCommandWriteRead(dev->fd, DRM_AMDGPU_PROFILER,
+				  &user_arg, sizeof(user_arg));
+
+	return ret;
+}
diff --git a/amdgpu/meson.build b/amdgpu/meson.build
index 3962d32c..d781f2e9 100644
--- a/amdgpu/meson.build
+++ b/amdgpu/meson.build
@@ -27,7 +27,7 @@ libdrm_amdgpu = library(
     files(
       'amdgpu_asic_id.c', 'amdgpu_bo.c', 'amdgpu_cs.c', 'amdgpu_device.c',
       'amdgpu_gpu_info.c', 'amdgpu_vamgr.c', 'amdgpu_vm.c', 'handle_table.c',
-      'amdgpu_userq.c',
+      'amdgpu_userq.c', 'amdgpu_profiler.c',
     ),
     config_file,
   ],
diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
index 947bf261..107d2b69 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -57,6 +57,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ		0x16
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
+#define DRM_AMDGPU_PROFILER			0x20
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -77,6 +78,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
+#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
 
 /**
  * DOC: memory domains
@@ -1616,6 +1618,23 @@ struct drm_amdgpu_info_gpuvm_fault {
 #define AMDGPU_FAMILY_GC_11_5_0			150 /* GC 11.5.0 */
 #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
 
+/*
+ * Supported Profiler Operations
+ */
+enum drm_amdgpu_profiler_ops {
+	AMDGPU_PROFILER_VERSION = 0,
+};
+
+struct drm_amdgpu_profiler_args {
+	__u32 op;                        /* amdgpu_profiler_op */
+	union {
+	    __u32 version;               /* AMDGPU_PROFILER_VERSION_NUM
+	                                  * lower 16 bit: minor
+	                                  * higher 16 bit: major
+	                                  */
+	};
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1

