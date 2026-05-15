Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23649CD343F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 17:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B117810E437;
	Fri, 15 May 2026 17:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yyb95an8";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6762910E437
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 17:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1BIybiqLVydoz+LhNJcMqO5/c+X01W4NHX7uYzTGvOQI2IGt3lAe29/NKp1apOeb6bIv+yJcbKuEwWDaNxD0Uvi8adhM9FR9gTYXnp2XzUWLCF+I/oEyLLWY+F0NSQcb73yQC+MZrgx8DU+4HXb9BEtHRmfND1vgfF2NtEivqd0UC0UFSS0hsAa0Fkup2G5FN6s3TS5QR9c5wBY4Eowr79sYIh0HTNeeDk2ZivoqnkAI0v59c2dX6hR8hIvainnuyFwPB3xXawBZ2XS7nrK043QPYsk3P7p9B4NRTXBo7jjhVmV02rjoCw9pqe6Y2Gyz7da8553cHET1heJ+aDGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsQvXIPDXy8/YlurRGfxM/bfNoNTDrPwZ+1eOGQrtgs=;
 b=PDqqp+kRzfhIg2i4vl0+TwcYb1cORL/I4Q366UJq/AomIuER0vIb9vjr8GxORowPle7J0BbY64vu3MhjhJsiXifT0N/sPaWaB2EXg89fIJuI4kphBOYuXvFmFGwrxlKs0vcIbHI8FaM6lHISN8f3QkhCKFBGEIDXVe5R44UqwzJ5QN5YfHKf1+7+Qpw0yNFGe0TxzQyGzMhXyPJ7yjwJmRIgVPwY94UWWqyvaL8qd+AMno5OYYBrr8VC/gW3QF56AHNBMGlA5MgVUfp6rW3rTnbBNZAIsUHWkl/5rSehVdHhBVv4O0xZfriL5wYh9bC3fTIRI2IoSQzahry73hjh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsQvXIPDXy8/YlurRGfxM/bfNoNTDrPwZ+1eOGQrtgs=;
 b=yyb95an8bj/cMAMiTl352Iy8/Kd5FQ94i0gSJ6CxPhU/9UrnFg+KRcwn3N15k8owRveiwUWIsyjdrZE3mhUBeA6h7K4y0GxKLmcbGQ0E6As9Ybi2SIqV8YOSRm502DB5iOKORaoAumWPJT1rT2S8ETHfz8wF50034TeLGYWUyBU=
Received: from PH7P220CA0123.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::26)
 by DS0PR12MB7948.namprd12.prod.outlook.com (2603:10b6:8:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 17:20:45 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:327:cafe::dc) by PH7P220CA0123.outlook.office365.com
 (2603:10b6:510:327::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.20 via Frontend Transport; Fri, 15
 May 2026 17:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Fri, 15 May 2026 17:20:44 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 15 May
 2026 12:20:43 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Bing.Ma@amd.com>, <Chris.Freehill@amd.com>, 
 <jamesz@amd.com>
Subject: [PATCH v2 1/2] amdgpu: amdgpu: Add profiler IOCTL interface for
 performance monitoring
Date: Fri, 15 May 2026 13:20:31 -0400
Message-ID: <20260515172031.3709388-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413192947.3145878-1-James.Zhu@amd.com>
References: <20260413192947.3145878-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|DS0PR12MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 8480e5ed-f704-4e24-3236-08deb2a64c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|11063799003|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: twQsd71rnOzCEUIHjKesHh2dGjQ/ZbvSSCs+alwPaVTJU1xj68caYtEUPHmrGb0gLXLi+jblrQqj/w6RF3dXpLA0AEtMz7iDzM96iatX13c9VNwNmY/kaJgZqy9MWjMIw032gr3diZ1bWYETD1x2KMOYOUUZxEVMiPvRFhuQT4BcURiLn4aWHaeAtgxSY0UOQZQujok+sPsSfnAv7CZXx5ped+R6Cqx4qT9MYnK5aPTeOIWW5HXshdZ0nbTC36+Cd/8o2rIHd1FebMpq4SUJjxGn0rHRWGTPNOuRxQBBlAk6d9CZyUiWOSctnUVusIufchjg/lheHvHZUSKnGHC5Z16EDaCT6sWMdVVrLqB+0j6V2ZB1tiNWoy1/LHtosW+jFA/81pLRVwPtDPQDK8wJ13fLhb+LP7H4BluoTVfJB/oq7QivBPy7eNyPdxQPaykRNN1Zey2N9blR3QHCum/ccvb2To6NMY71MZWPoVvlFLvM9ptEcS37WmS24OskNkqShKBNa2d9eJFDF+NVoINBbTBsQtGNFO0B1qFcEGw/w+4V8xAJzkrU8p/E9iRpemy0pJvzBi3wbjYrQTlx6P0/QS5xtvBy91/ZrPm1IL/vaTzdCOwPmqKndYbNDnurGGyj3A25XIb5X8/fgSYcQTUgN18iYKxS1lPK27T9ZaVB9U4vd1KEDEYsKWH6DZnNOk+U
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(11063799003)(3023799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: luvZEfFlq/MvUrY7C5ir/O1PXv2Qetr4CKSjvs7wCu1+6Nid5Suiol8Yp+nzPCAPcMrkIJCD9/HWhacSekeQCLDy73hzDIdS6CpJaUmblEtoqB4mAC/NbFs+pfA7K3ZeXnnMPVrZ9DhPZF7F/zvADhYPcpEayV5qgmtDz/tBIVb1hGiS6I3jEs8u/HRxJrLxCnxNRGSAQsFzMz+C48Jpld1bld4hDKkVXlLc/T2jPdnl5RAz7Lhb4QBfyEFT9zWcJMMq4Zl3VlCqzQyrpRvf0mjsl75futzoEVc7pVI6QZ7Jza13ag3IAygAzO1B16mlr1Q3W0CsQL1qL8vZiHH4ZaSlUTiN8wvNSw46TEsGI3/DWwupbstHoBobS2tKvEz46y5SH+5hq0PcFjEhdkbzi513iLVLgATZ08QvbTRaheYPLuAyyXHj1GdlZdaODtat
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:20:44.3111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8480e5ed-f704-4e24-3236-08deb2a64c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7948
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
Reviewed-by: Bing Ma <Bing.Ma@amd.com>
---
 amdgpu/amdgpu-symbols.txt |  1 +
 amdgpu/amdgpu.h           | 10 ++++++++
 amdgpu/amdgpu_profiler.c  | 49 +++++++++++++++++++++++++++++++++++++++
 amdgpu/meson.build        |  2 +-
 include/drm/amdgpu_drm.h  | 19 +++++++++++++++
 5 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 amdgpu/amdgpu_profiler.c

diff --git a/amdgpu/amdgpu-symbols.txt b/amdgpu/amdgpu-symbols.txt
index 8cd5559c..69840193 100644
--- a/amdgpu/amdgpu-symbols.txt
+++ b/amdgpu/amdgpu-symbols.txt
@@ -88,3 +88,4 @@ amdgpu_create_userqueue
 amdgpu_free_userqueue
 amdgpu_userq_signal
 amdgpu_userq_wait
+amdgpu_profiler_version
diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
index 53144f59..1519fe4c 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -2120,6 +2120,16 @@ int amdgpu_userq_wait(amdgpu_device_handle dev,
 int amdgpu_cwsr_set_l2_trap_handler(amdgpu_device_handle dev,
 				    uint64_t tba_addr, uint64_t tba_size,
 				    uint64_t tma_addr, uint64_t tma_size);
+
+/**
+ * Acquire profiler version
+ * \param   dev         - \c [in]  device handle
+ * \param   version     - \c [out] Pointer to to the "version" return value
+ *
+ * \return  0 on success otherwise POSIX Error code
+ */
+int amdgpu_profiler_version(amdgpu_device_handle dev, uint32_t *version);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/amdgpu/amdgpu_profiler.c b/amdgpu/amdgpu_profiler.c
new file mode 100644
index 00000000..b3d119bc
--- /dev/null
+++ b/amdgpu/amdgpu_profiler.c
@@ -0,0 +1,49 @@
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
+amdgpu_profiler_version(amdgpu_device_handle dev, uint32_t *version)
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
+	if (ret)
+		*version = user_arg.version;
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

