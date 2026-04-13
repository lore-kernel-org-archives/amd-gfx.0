Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02647F531C9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 19:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798E710E523;
	Mon, 13 Apr 2026 19:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pMr0RMfZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9EF10E521
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 19:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmkQcAtcUQWLBBsT35EfqaiKs/n2H75H4r1GmdCJpAEWW0OmR0QbmbDuRLUCWy46XV9qX0EEr8tea/YdyovHq76WFEfQ2VYsI0IXPGHFInDixOekNotix9GjcHgtqaDv6uzG1x0x+ukUMRS/cFk10Ip2F9h5e+hDKZkJKk9otenC8ZshJbytvi3T3tDkgJtdAkUBxiLOsFFXlCr2adGeLGIdFHwwHbSA7jNtE8owhAXC8kxW4FiqF31AQw72XLRIHeLdrTX5HDVVXPeoccVRtaQN1SsSsMmDTfJ+VhF96ZdIDjCDhgkrgSr8EqxIJyk/rSuADTsEAwiJI9eM/JLUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjumSl1MOB6Ro2X8CTGyOyaU33ja6bDAup2fByb7bi0=;
 b=T2Um302ffLkAEoui81BSTodlQt6DoNf7C2IpTmZoohmvTKS5xXL1RLSEfH15xWMjHcCVx6QyVqTz9O4V5IfFYet4xJD/0joW4XBMeVJBVykqzzWz0r9RpIfP1Pk+5A6v7si+vkWEcDgGTc/Mdx/K7mbKI7JMOiiqXwz84Q0VqO9odl27KSPYkQ2EoJ6hG9pd3btE2uCBuzsAxFKp1Ilkr61frwgCJ0dg43D5PWLRBmBGYYY4Is46wd3QWTHWH1IKEUgy+mRewt5oNSKgx+K6ELdKzIidw0PgsvYqhslzgxfTjQqFaKRqvPTna8y9P6i7Ly2zVLx1aITUYjRrj6UjuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjumSl1MOB6Ro2X8CTGyOyaU33ja6bDAup2fByb7bi0=;
 b=pMr0RMfZPii1HccK2qQJNmSnC+tsQilIz1RcJ/c87J0J2sn5NFB0pYIORwwpG4WcQBmo/pB/xjE1H08AeOmxDvBS6TH/mvEdAtLMZuEOav1uoQs8AWVMOQbprX4m6gqIwvM7qV6m8EL2RJPgXA2o8Vw/N09IZqzp/rWByjNAR5s=
Received: from DS7P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::18) by
 DS7PR12MB5816.namprd12.prod.outlook.com (2603:10b6:8:78::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Mon, 13 Apr 2026 19:29:57 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::dc) by DS7P222CA0011.outlook.office365.com
 (2603:10b6:8:2e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 19:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 19:29:57 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 14:29:56 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <Bing.Ma@amd.com>, <David.Francis@amd.com>
CC: <Jesse.Zhang@amd.com>, <Jenny-Jing.Liu@amd.com>, <jamesz@amd.com>
Subject: [PATCH 1/2] amdgpu: Add profiler IOCTL interface for performance
 monitoring
Date: Mon, 13 Apr 2026 15:29:46 -0400
Message-ID: <20260413192947.3145878-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: de56305a-6655-47a0-5d87-08de99930c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18096099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: bRN9MHdMW0kNpbnj99w6BMRrZa2GcU4v3+Nd7eR5URy02y4cor16IbG3jrHtYLKBHRPJ8mOCJBzZsiDoBT0v+3oIUZ/CKHlBPFDkCKhLnbW8TOKp2b/ei02ghaHqY6ypEqHyqO8HuFTmxOYhFMs5hHQiaiCR9yAW7+fuz3o6SGWkRnC/Yz94bRJs1fse5Ggxev9RrqLhkgAJ8dOgpPts/jUF8TYV6oyNgEfkdiwZHyBF5beKH1OdVFHX8xxrW5mtCNQlNCSbpLIfUoEGxaQNO2x5cDUNL/xaBI+jSbkvRbPNwy/9bjGVbpb5mJpmQpZNVrIJu6SSXXPez6kGEFOjuxxUHb7SJszzdvbqylP13pgLfaR6XVWaoTJ3bAYG5f9ZxhFkXy3kRKuSALtdFYa0uDJOAKbXgeVP7R4tW32cCIUWwUMtZUTmCbN+TYxKA4Ggnn5Tyy83DoLVzsKItUPk/EmsHyKYlXiLOxnH7F0yogXEkkvmSXlaaDPoRPHzMxpm0IqFEZWLQuSMgPBUZBqe/K8gJKaDSTH8qQVdvTspQUiFufnFw7xFOMd+va5ZcPSLI60RvvbZ9VDBKpOyeANa5Y9g4o8M1Jg2xSCxcJmP/S8IhRaqazn1N3bKhDH4A/N00qw8WxxVc0ocrJ/KAsrMaNerjVtjy1NiELXaNCPv1Tl5X21TStFC1zULMw0R2YL2WiLVYb3x2Ntbc5/EJbkC1AEIKtQwQ5Bg6dJkchtrUfqL9WiyvhskJEWNlNgSyK99+1v7lCCeX5cdgGseywKL/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18096099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4gNFj7oszp9ZgdVQMXqTOSOz8YyPdDb7A5wm4ztVz3GsySwpGdyo6h26HPT2SN5SaR9KUUQSgZVlOZEqhRZNmrUTk9rObpf7/lI/QnfhH96BPsB3RoTqMTWPAzN4dTlQbao7GtBRKcZ8cOD+NffzBoSn92/T9vjWa4Z2bS37cEi8pMnNS7ScdFzdYK9sfHFWuyYdHcMcZfGdvJIXovfJRD8FtxLCVx7aJbvDxEhYzZtbKHhtTbTzI9ymptNOgrXUN9JGKECPMf1ExrUeB838r0p5v1dPFB6ejJLD5AwgPgafa7rphb11P/kENS4F5H0z7M3bpWM+yRpxJA7O/olldSTzkHlOU4qI4hMr9vW9AgrRAfKllMrMbKqywZmISWyGoU4KF5iKACNoTrkNdp7cnmyWAPa2bNolbRr77j+QRp7zjDQgKUHkyGRFqi663ohJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 19:29:57.4000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de56305a-6655-47a0-5d87-08de99930c0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
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

This patch introduces the foundational profiler infrastructure for AMD GPUs,
enabling userspace access to performance monitoring capabilities including:
- Performance Monitoring Counters (PMC)
- Performance Counter Sampling (PC Sampling)
- Streaming Performance Monitor (SPM)

The implementation includes:
- New DRM_AMDGPU_PROFILER IOCTL interface with version query support
- amdgpu_profiler_version() wrapper function for userspace
- Profiler operation enumeration and argument structures in the kernel API
- Build system integration for the new profiler module

The version query operation allows userspace to determine profiler capability
and compatibility before attempting to use advanced profiling features. Future
patches will extend this with additional profiler operations (acquire, release,
configure sampling buffers, etc.).

This foundation enables profiling tools and performance analysis frameworks to
access GPU performance data directly from userspace, supporting performance
debugging and optimization workflows.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 amdgpu/amdgpu.h          |  9 ++++++++
 amdgpu/amdgpu_profiler.c | 46 ++++++++++++++++++++++++++++++++++++++++
 amdgpu/meson.build       |  2 +-
 include/drm/amdgpu_drm.h | 19 +++++++++++++++++
 4 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 amdgpu/amdgpu_profiler.c

diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
index 53144f59..4ec1f6b6 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -2120,6 +2120,15 @@ int amdgpu_userq_wait(amdgpu_device_handle dev,
 int amdgpu_cwsr_set_l2_trap_handler(amdgpu_device_handle dev,
 				    uint64_t tba_addr, uint64_t tba_size,
 				    uint64_t tma_addr, uint64_t tma_size);
+
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
index ef12e725..307242ac 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_CWSR			0x20
+#define DRM_AMDGPU_PROFILER			0x21
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_CWSR		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CWSR, union drm_amdgpu_cwsr)
+#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
 
 /**
  * DOC: memory domains
@@ -1695,6 +1697,23 @@ struct drm_amdgpu_info_gpuvm_fault {
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

