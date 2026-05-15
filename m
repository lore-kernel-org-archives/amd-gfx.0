Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD29CD343F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 17:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A43210E0E2;
	Fri, 15 May 2026 17:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zx0/JO2+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D9CA10E0E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 17:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSrfLA1nH14cZKnYNFtmOptg7RctHWXQJffMyTkacQiXyQn/ceBT4ViPWCUL/tfNNh5cd9hLiPTBz9ieaHgY36B5namhnSr6k/uEXeoqp0CILQCVnzfPbQ6dJr4ejeXBOhUeagES4btx7IJv9JMUudCCa+6qCr6AFdYIMt3oApkB9H08/bQpWkv5tiy+JYqVpnTdrDXa7uLN/TVHEJDv2RLN33/RVFzUYJqaFP7Tv5p+GYzZBIFLc/Yv+geqlHuUSJJCDNAbF5YDFaGb3F/p55zKJpyFUJAbZbtZLBf0zattjAtc11cFBE0Yrs9IC7kt9xwiMZF3I2y6Kl1y/lYOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjumSl1MOB6Ro2X8CTGyOyaU33ja6bDAup2fByb7bi0=;
 b=RoXLtXhW9V7w9x5Bwc5rKwJtH8AYz66WK7XPNGkAY2ww8dwabmnfPn5ymhzPU0hzc7HjmAj4vmyDbpWqk0h75IAXLV9e5qEfhqG+dma5wfWkWoo4j2oF5pTOOTbInVI878tt1faQG8pa7bbf4sDkAlaCSbyhaB2WAO7BZz67iji/x0mpY76Gowm7indUK1WY+XtZDq6NAzujx7n+lyhS35R8Fk5T1WqRw5xg/x98H2ZGCWzMUV7xiwIosKLCPQIpC3qd8liYpmX9qNVsqsY7arnnjND5eAJCxwPJeJaGrru0KHyFgtagozaLTrRdHegrOu3vp3XX/7d4PINzKc73FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjumSl1MOB6Ro2X8CTGyOyaU33ja6bDAup2fByb7bi0=;
 b=zx0/JO2+6dsc6hzCLxF8EwM2FAJ4DJF1lATfNqqLywPvuCm16KueN4xJnUxr+Sm2Vw94EIE3zsl52da2yExo+9mOj/lGzeKRfOSDeKS/cC2tITijwB7gwklNC1ZxH2c73yar09oaQ9mV7nKRN9ABZ6FIWU77aZPwuNR8b/d0phM=
Received: from SN7PR04CA0194.namprd04.prod.outlook.com (2603:10b6:806:126::19)
 by CH8PR12MB9814.namprd12.prod.outlook.com (2603:10b6:610:26b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 15 May
 2026 17:13:53 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::86) by SN7PR04CA0194.outlook.office365.com
 (2603:10b6:806:126::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Fri, 15
 May 2026 17:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 17:13:53 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 12:13:52 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <Chris.Freehill@amd.com>, 
 <jamesz@amd.com>
Subject: [PATCH v2 1/2] amdgpu: Add profiler IOCTL interface for performance
 monitoring
Date: Fri, 15 May 2026 13:13:41 -0400
Message-ID: <20260515171341.3703839-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413192947.3145878-1-James.Zhu@amd.com>
References: <20260413192947.3145878-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|CH8PR12MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e9b1e1-ce6d-4288-eec2-08deb2a5570d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|11063799003|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: RFaX8kEtbMEuEtZnPrJKduY76DfAN7nhiLsLFZc6PxuOmU619P3XO5SqGcTCkoj5z3b4iKN5G3OlpsYLRoSj4R/1lCprHZ6M9QH87GYe4Y83Au3GwNc5Sni858M8fTBz/B3IOhXZn5dz1oSAvO/n5PYuuTKQgeI2D9dBKvnFydhA5JqBGWczxyWBawuydKNJSlPRd5SsFGUv2i/dLD55IG2rH9UD1I5zPg5adFu7mn5pRWShL8J9PVGj/LIw6oY74I4Qcvlh2sGJb6nwigHgDR5RjLTc3bCotzWPid7BAeEI2fByjE/jwwQ9v1IyMcHQ9RUiW5kXJET5CC0jHFMfsUQdGtkihUmCFOsFQ7uVHKVgJTD9TbczeExOCoLkM1NM1dqmcTQL9hBmIJcf5+mMoDaeOWukk0fcjU5HVCbswHVi6qqITrcdj5er5im/gcGI5Yc1w4H5vFkgtxMQNp1l6XJxyE4TX2zPyrg9gskZihco92PHVYjwxwMPbGqeMQDBFKRGTHNEf2AdVLhc9woDpnk0QxGeSeecuxKjoQo1BUE6/PvvUuMvRaiYalkQFl9nj91MXflfwkVz70FodeEQgvc/6Yh8YMb9IcgAVoGt5ljvcBJonSucAVgM0My84swHhfgSPipQjf2w2DxaXcp3gr0vFPmFjJfehw0va+5HLsU++AoBjCujpEBtiaoIr5z6L06ATlBrcMYrQjMzxz9+9CEC4qaIOIFYhbyDlvK9Adk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(11063799003)(18002099003)(56012099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HL41Zw7hF6DBD8UmwDYLSu0dtMxQbhlxjXS7SD3YdnMTsV7tE+S6nhEeczoOSi7AxrigWLOYTZ/MIQvAxE7TSyvBw3YMIaKgKkBSzZ+JjRhmumDU4hSCxAwMMWJ65d0bq3DwKPz9y8gbmwjS2gUCYGDvKxSyaZy7u6P85VbM5ee1N+wil/GeOuG/Nkei7ENntE4zoqI7o9bMPeypDaImUEzWMQ/q1j575cAUorL05cLviZZ3VjXOEurNGeGsWr8tMz9zcuBIYFitxO4gW4S23F8vgW9UYIA61by1TwG+eF889xBiOq5Iw461k0EQMraqs1bO/8Qdyy/yvGarwUiirdkqPED6VMHM2HQiRyn9aiTBmJ+HwxgirNTcnGZ6T2U73Kmku5zJ2Nv5cE0yoMnWDznGnkeHFTXf3838k9pMzW6ZHEdLkj8mL+iF6X4fLJEX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:13:53.2438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e9b1e1-ce6d-4288-eec2-08deb2a5570d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9814
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

