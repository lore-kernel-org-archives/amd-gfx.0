Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A66D3EE74
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 15:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9371A10E9E0;
	Thu, 22 Jan 2026 15:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rwEaCCEl";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69A610E9DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 15:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWoPbT/4y19cGuO+scuFqxCYqMnlDJVe19pbH35juEvpvkYhzD0/XbOgqSnZKhzknbYhDKP2MC5KEH3MSQE461xcqo5q6d9mkp51rZnlNJEnhQezmg3e0hhOIBvqzCLkCXer22SU4fcUidJ+aQhQHp0f2dsgCM0+/CX/7M420DICCOfte2i10Cfav512UlnZ6M90mRW+HNX2XuixSJh0j0lJdB5I7b6Jr0JmuToFdk+VwWcaMOcrlwNt8f6sfygyGbkej3L+px2RkAB1TRdkLC4Pw0RVpDe6Ko/CvkpFAbmytpZk4YB/MGGLtYRjnyol48q+akV8lZJzgvfytZVaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuqydsZ1iqKH/gdJgRlLmBZEn3iXh8xj98decSS4HSs=;
 b=ddR3nR00f3V7QHX4KtHkNJiCE2eaqnWDAeNcLN2afJDkY+u30Iy7KDys5EXXyrvAjkZ0xxJ/bi7ILQ+yyr8GlLJS2iZhSIPoBBc1C7iukW4OvA7kkLbKgjPuXmDkzBBucWUGN7gB0/ScvHJcb4b9fYQOCi/PBCPtw4VbXnKQgUmkZWcDrgePQPw0IImC9ivOMsKRTeK5cq4rOIpr6eTulL/uK6UmVQcYi6vt0Pn913RfusnHX14Jvy70eWqsjwoQTENdBgtNiG6+LH6rAsyY5MZl53B7FlCk4CNotF7bWLz8Tabj2fP/lyKyD4FQ/W9MQWLImo+udRoWPAHGT+WuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuqydsZ1iqKH/gdJgRlLmBZEn3iXh8xj98decSS4HSs=;
 b=rwEaCCElo5EOF6XFnqKt0b95C9XbrunPJpypjjf90doVFFajGLbHTe8fLmXZU5EDhhkoGynEqFmiDuqsC6vBtjOI2JHbGpjTEgn6U+v4y7sFzAmDYJYsX1p71OoPCYtOy2AmjMc7EUABBLEQ/btaXsyyeTqt4xTiPbrlypGseWs=
Received: from SJ0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:a03:3a1::8)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 15:11:21 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::8e) by SJ0PR03CA0363.outlook.office365.com
 (2603:10b6:a03:3a1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 15:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 22 Jan 2026 15:11:20 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 09:11:19 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <david.belanger@amd.com>, <chris.freehill@amd.com>,
 <harish.kasiviswanathan@amd.com>, <jamesz@amd.com>
Subject: [PATCH v2] amdgpu: Add amdgpu profiler IOCTL functions
Date: Thu, 22 Jan 2026 10:11:10 -0500
Message-ID: <20260122151110.3072843-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d85d6d-74eb-444f-c011-08de59c87fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2hnZWWXlStp3jcTZpEE7oXXomg+geWa779Lt6+MlP1zDf6Gv65olkNZPkyUa?=
 =?us-ascii?Q?PCA7KoDG3YbfV0bHBe9KTtEjUXbt2JXeQ+sCQo0Yyk1Pqzy6+TWM2UrLnbei?=
 =?us-ascii?Q?FxVEWen4WGqtTRS/8P+Mg0BKswfM0/9kAzHMA0c7JIK2McdX7gcVeQEbQ6wr?=
 =?us-ascii?Q?/veWjJmYXq9h0U6Zl/TcRn4f68YcUznPYAPpsPgcru3rypy/PgAZEi3ZLei9?=
 =?us-ascii?Q?zCoVmUXGGKktQkuTz2pqcivu/rTSM31iP9nMPHKhOzXAiLsPdFHqn+TK563Y?=
 =?us-ascii?Q?K6n9RzT7ceCEv7IPQL6AOdTnlnE23T8NhgGWmGsmdcBEYLjLGNAP2LPABuHy?=
 =?us-ascii?Q?brCubWLSwI0qaujYsmn9WeGe3/X3sfjkCSRfWNfkd/Wxm8G8tBjJR6XjAUjR?=
 =?us-ascii?Q?7qcLVp7jReSAf9Cj5bJxWf6fvxMSU1m2Gr0JWqpE2n7VbTGxzfPsUcpih9uc?=
 =?us-ascii?Q?i5yLLnR7MIEiHwzEsDQRROns9jDMPzBphMbmfjaAcUsx2eRnjrQ6cFz95n4P?=
 =?us-ascii?Q?v26rQZMjCGBHY2D3iVYRP0/MSfUJadMxTkFkzQehTkmYlNieWxi7amjpubu+?=
 =?us-ascii?Q?dQ/zxGsEbvPt75aw/FkqfxT+F7OtOfN8+gGZYRDwbSeA8p5znLmvoltPy29+?=
 =?us-ascii?Q?K4KsemK5doVcAZX8qowGDotf6JqioKkJSFOqEq62vb7BNb/gbWCAVx4k22Df?=
 =?us-ascii?Q?BdOdL0O6n/NOsV76ennIeLNGY4cyH4L2tV4vi34F815M+7UQ4cIe8L7rBH4P?=
 =?us-ascii?Q?fUj1yr63k6eWg36aB9UigS+MQZaliPymyQ+1vL92YQNBetvlTwS6WQ2Vs/qb?=
 =?us-ascii?Q?u+dye/UftSnk5WM1aQdTs9x+2C5Uq08uKkYOuIEMI9KP9WrpZD9dGui5O9JP?=
 =?us-ascii?Q?dFyUoOXxZYASdA6X2YldDXvOyqD5JSMCk79HJqnFtaAJC14V9x8kNdPZpwsd?=
 =?us-ascii?Q?C+JQqg6z4B08k3UGOP4o4OCh/rSliKjuGMIzI6+fq/hOPOtZV0TPi0I65enb?=
 =?us-ascii?Q?bqvkKuqrd+rax4k4ET4qiVQjJvzjyJ+r5ETVXvwLofb099TZCeNrUTu4Si98?=
 =?us-ascii?Q?TQ49msAx77/9gKiZOWByMoLZSny3dPwUUS6CwXlCEgFDgh92o5aUckiG1IVJ?=
 =?us-ascii?Q?PieT99JoDGdFb5AQaoQM4qzmj/7LV78XN6LnYZPwGuTy/jDBL2ZVwPcyaMU+?=
 =?us-ascii?Q?+BjBxD9I6gYf09C1+ZY4Qjpc4UahwJz4te0pOBs7blIdco9ejPn/GgG7zbwm?=
 =?us-ascii?Q?bMpWP/mQjNbMfGF+lgkrMSBfOHPUWXh+61Z4pCPUlQRW/wb/RI9c1D+cMG88?=
 =?us-ascii?Q?mhKQAtF14MjS2GdNZlgpYf7hCuaFu01syXC1cdo8nyU0PiKDXT9X+gqx8qgR?=
 =?us-ascii?Q?5USIQLqLOO7VRe+QETw014PXCuAYXrE5FcnZ2uC0d5aIxKEBo4vmx5NtY8zI?=
 =?us-ascii?Q?2ZG4dDyECO+FvJKDN9BtXXsv7K9yJwbrHM5Ahylq+J4jFXOkM33jfEwDWT9y?=
 =?us-ascii?Q?S6uo0pyHhS4MZP+Dh3Bd8C4EsvXp2R4vDbDttJMqszhJ4kpq70sknwXRyO3H?=
 =?us-ascii?Q?zfF9EPSUnady+KlDtc8ybYI81tumQRzVAUKBewcmGojwTQ/8ORvJBIBvf3OU?=
 =?us-ascii?Q?KQPqB3uP3MN7Fgoh+fg6UC5ygSWKzx7WtUI0RN/j+ptC4AZeeyizktKZneef?=
 =?us-ascii?Q?68OP8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:11:20.3444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d85d6d-74eb-444f-c011-08de59c87fbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118
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
 amdgpu/amdgpu.h          |  8 +++++++
 amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++++
 amdgpu/meson.build       |  2 +-
 include/drm/amdgpu_drm.h | 19 +++++++++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 amdgpu/amdgpu_profiler.c

diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
index 39b61539..87eec030 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -2072,6 +2072,14 @@ int amdgpu_userq_signal(amdgpu_device_handle dev,
 int amdgpu_userq_wait(amdgpu_device_handle dev,
 		      struct drm_amdgpu_userq_wait *wait_data);
 
+/**
+ * Acquire profiler version
+ * \param   dev               - \c [in]     device handle
+ *
+ * \return  0 on success otherwise POSIX Error code
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

