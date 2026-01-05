Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA43CCF2C2
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 20:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 469FF10E0F5;
	Mon,  5 Jan 2026 20:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pyRVyYRv";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6177510E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 20:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBXnCb0AsxDVQ4QJcC4wUqmy6x18EFP+OUMLiFYqky1vOVqCaWI+85Q+xygGS4GTUOuM+DZvp0DIIiKE6J5ZRX1+hlpZMAbkVFkdyXczfHCY85HUpvQusDmIuOG2SjZIFGV1YstBvN2Pfiqq8U17iVTXH/EGT47JGQ4lsJ04wia5giWfTlaUeApW9UjoPmjNBj5PC23VKG/fidmH9Z65oHgkI9H7j26SBeddfFvZ/qe+8rMGbydgkqiQaaUQ0SZABZJjYTKhDRSTxpI89Fma5qkX0y1BseiwMHzk1I141o6OzqHIA9hdxmcDKTY2eRp6GIUj6tkFzg4k6uBPkx11eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZZdzn9cw3EnxgC/PbWjGS75mIU5w/j5LHFevReiI0Y=;
 b=jHfv5LoN1j9+7GsLKhGgqMAJ5KNU9i+cPslX6GtqSiKoMRv37rMhIaUCoPRlHGyjc01NFeDlvrcCye2XFZsc4MtxHq/c+3OSRwUdm11aYjV1KF7N3WgcNmt0CpDmrAtgX3VzbJc5RqjFnGqSJSMQgIaahhXW/otNRDPtS/9UHLqDON+z38CkUtHdg1D1HVAGzKwgSKHjdw7g+Wd/J3/azzb5fYvxHzR0tIenvoML32UuChmKSuj8HXbYTM0zhyKSoTZIizoOrhNCq9HAbzaxYNpJSqMOgmc2ghlTQ77p4oGIJQhWDENr4aRH+ebZpyW8eOb/EgkOTy3domy4nwxGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZZdzn9cw3EnxgC/PbWjGS75mIU5w/j5LHFevReiI0Y=;
 b=pyRVyYRvJPVWAv43w5DGXDD1PRAWXrCf+M8KZ59ZkSjI/uCT26e7H0VLpxEmtlJU6wznSnQIVCVZqg48kH0FY0qqK8JWqnd23Zir+6kF7bRqKuk3mEcgRYeHMexW505zm08z1WOfUg210yz/qVSAR6aA75s23flrZcHo13/7acE=
Received: from SJ0PR13CA0180.namprd13.prod.outlook.com (2603:10b6:a03:2c7::35)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 20:13:34 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::f4) by SJ0PR13CA0180.outlook.office365.com
 (2603:10b6:a03:2c7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Mon, 5
 Jan 2026 20:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 20:13:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 5 Jan
 2026 14:13:31 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 5 Jan 2026 14:13:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amd: Enable SMUIO 15_0_0 support
Date: Mon, 5 Jan 2026 15:13:16 -0500
Message-ID: <20260105201318.64865-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105201318.64865-1-alexander.deucher@amd.com>
References: <20260105201318.64865-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb05c37-49c9-4869-1a83-08de4c96e757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w3DH2IieHr9GacKsgWc4uUBtCQPQYYqkCpXnEOIepQ3PI+BTEMO2GEnV/lL6?=
 =?us-ascii?Q?2KVQ19eyXbPdw0vkLJFxirH5OiEiL1COS7GZ7sJ758yeTrrlAKh2Hm4XTQ3m?=
 =?us-ascii?Q?m+SYnGUE9UiNYVZG8u5mhprxI03mRo2QG9y6bznTdlEEHivYXSH30uVzJt5a?=
 =?us-ascii?Q?ZUib7NPdzoGRwS9B8IL9XO3jeoqD/me/DXAl3o7rjGvXd3o93T2Koj3MYQzE?=
 =?us-ascii?Q?nzLVyMJfYCjP90amL0H5lm93c5VL/T2TX5s0PUC+QAejXYpEIZtFsni/2hJZ?=
 =?us-ascii?Q?DAMtw780NuJBpUiRncWv0xZFuEaFp2EiTdeNfqLWu6zko/vvZMBKqXOYzIFi?=
 =?us-ascii?Q?yl5iyKvCtFx2zlkSLGNrmTZbvhoH4Q2JfHIjWOthDjhYl+VD2CczGM3yxgsM?=
 =?us-ascii?Q?7K5qgq5gzig8Lpmn3o9XHSUHc9nloCv2R+VVIsaVdtrt3uyH7ZLtyL0IGhZU?=
 =?us-ascii?Q?5g33jOBQp6kZbSe9Ndj7uiyvDM+I21h43zqDTPPi4JiAuPpzNN7BnMwidxxy?=
 =?us-ascii?Q?YYe6CGwg1fg3g+P2lPst62hchXVfWs4tXzg4s9Zb5z+C0Ijv4b9IIa4wQdNZ?=
 =?us-ascii?Q?/mi8vSKqHhf6HknvoUdu+BhhFP6HR3qaFwjzsvxKvAovCEJa7jRRqtXNVfg7?=
 =?us-ascii?Q?tj5E538ncT+MemsBVHxfVpv90pTnEJSJqsz9U+7gIwR2X07whYYUOcbdRCsH?=
 =?us-ascii?Q?INvD8DEQnGd+nEPRNV4RW1z+fCFi+aJ1uB2BnYwipfkuDoCtRYQ/unp1+eg8?=
 =?us-ascii?Q?bnVeLmxoLNzX00mLdsUqaY08c8QEX7k48VN3ow128dzToTrZnPwtlpiSePsd?=
 =?us-ascii?Q?Z6d2kO+C97Y+C36A2JZ4d7KD+IdcF+RjFo6FI4al3WoaDp9xSPbR4ZJza3+m?=
 =?us-ascii?Q?/IqCv4WgbBwfYzGYQpaZtTs/cv0wWqLj1WcQmy25xk/G5VFF2l0wD9iLhPM0?=
 =?us-ascii?Q?Z5EeBz6ujHvIVHfQOV1Phqi2fOZ+fWHK/O2ECGh85EoKTPMCX0PkO/wrHAVG?=
 =?us-ascii?Q?KJHrlighsQqoq8g6KgpdTEHRpbZym4gDev/n+XX2JhC8foMb2Cr/wfN+KchO?=
 =?us-ascii?Q?Uzx+n1sy+G4e0chFsnbBXeJPtyKeVjKQW3QitsTh4DA0+A5HPEvt5sa4S57N?=
 =?us-ascii?Q?TUjZeJm93we4M0PPZMuMJYxTy0unqlrAp91TunKG+647K+yztVVDutul6kKK?=
 =?us-ascii?Q?4T6pjhVQDZDeajwcWCICezehRBPZ7f63x3EzwGL87sS7EV9QfPW1b71eo42h?=
 =?us-ascii?Q?WbzTmuDq2EDQlUPK7ljBvREK/kLjPSklR5foFbx4aBX2DyebZGkefGjafza+?=
 =?us-ascii?Q?aexVJ7HwJ/Itbpz+QLF7k/vPS1z4qem9e0274fBuBdVNbDauU9f/iM174Jly?=
 =?us-ascii?Q?pNNAnTzW5ew5NmPNSxEgrXA3ak4CgaFRVKWH6SHDETXGrddSzYZu3NxDWp5y?=
 =?us-ascii?Q?YZwpUWW3asI7bvsW9UnICLWFVzhEACS6J+Hbkc4NJPHn5ZrFGE1R/j6fs4Va?=
 =?us-ascii?Q?MiZz4txiYZVYHZZvCZE4aDRTH20PZdvVn0MtvE23KYSJBb4nH+KgJeEJ2WfL?=
 =?us-ascii?Q?9QAkww08jzyBrwMVqTQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 20:13:34.1901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb05c37-49c9-4869-1a83-08de4c96e757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465
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

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Add SMUIO 15_0_0.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 ++
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_0.c    | 50 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_0.h    | 30 +++++++++++
 4 files changed, 85 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index bf4b5d429f008..8e22882b66aa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -253,6 +253,7 @@ amdgpu-y += \
 	smuio_v13_0_3.o \
 	smuio_v13_0_6.o \
 	smuio_v14_0_2.o \
+	smuio_v15_0_0.o \
 	smuio_v15_0_8.o
 
 # add reset block
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 43fde853a3989..1d91de35237ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -107,6 +107,7 @@
 #include "smuio_v13_0_3.h"
 #include "smuio_v13_0_6.h"
 #include "smuio_v14_0_2.h"
+#include "smuio_v15_0_0.h"
 #include "smuio_v15_0_8.h"
 #include "vcn_v5_0_0.h"
 #include "vcn_v5_0_1.h"
@@ -3192,6 +3193,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 2):
 		adev->smuio.funcs = &smuio_v14_0_2_funcs;
 		break;
+	case IP_VERSION(15, 0, 0):
+		adev->smuio.funcs = &smuio_v15_0_0_funcs;
+		break;
 	case IP_VERSION(15, 0, 8):
 		adev->smuio.funcs = &smuio_v15_0_8_funcs;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_0.c
new file mode 100644
index 0000000000000..eccc76650d82f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_0.c
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#include "smuio_v15_0_0.h"
+#include "smuio/smuio_15_0_0_offset.h"
+#include "smuio/smuio_15_0_0_sh_mask.h"
+#include <linux/preempt.h>
+
+static u64 smuio_v15_0_0_get_gpu_clock_counter(struct amdgpu_device *adev)
+{
+	u64 clock;
+	u64 clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
+
+	preempt_disable();
+	clock_counter_hi_pre = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+	clock_counter_lo = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+	/* the clock counter may be udpated during polling the counters */
+	clock_counter_hi_after = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
+	if (clock_counter_hi_pre != clock_counter_hi_after)
+		clock_counter_lo = (u64)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+	preempt_enable();
+
+	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
+
+	return clock;
+}
+
+const struct amdgpu_smuio_funcs smuio_v15_0_0_funcs = {
+	.get_gpu_clock_counter = smuio_v15_0_0_get_gpu_clock_counter,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_0.h b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_0.h
new file mode 100644
index 0000000000000..85e0f08283d93
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_0.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#ifndef __SMUIO_V15_0_0_H__
+#define __SMUIO_V15_0_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_smuio_funcs smuio_v15_0_0_funcs;
+
+#endif /* __SMUIO_V15_0_0_H__ */
-- 
2.52.0

