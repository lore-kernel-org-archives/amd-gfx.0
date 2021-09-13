Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C4AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 21:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F5F60EE5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 21:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0F5F60EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 638CA6E252;
	Mon, 13 Sep 2021 21:23:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E9F6E252
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 21:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cItw2Y8U5VNLQ9w/Vmguk2B86fMu0SFpfSWilCJAl/mP/PyJoGeZNEoCt4PFwnbMP1UU66Wjl0UuAzG1KavIZw7/CsMIk8FPBRj8nYTipHWBFwYOP1w+spWRl8YwTaw0oMESNIpb/Ze7dBl3ehqLxkUjG5kr6PYLM5el/xQ+pt+Uz3CTm4Zqs2nLmBI4TMt+/qwoR+t/VrLUbjB9ojAtHzIJ+7b6XmI4PjWZGTzxBwhgcngV0FYnpDXtQypgqyuaVlJ/P77OHbn54/AexyOpIT70RJ32HTHDS4X2uwA8hdi6iiGRVv2wPr6g5EEv+AHjyDVBFuKS3WHqjFcJ1JGOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ORCach15bMHSMgjymSbfzEpyVhFtr+AeKrCUeFPI9cY=;
 b=dsqOSwfK2fuiJniwas9DkP5sLMK79k3mXYz+VeHGNVuZtXQ3P7KK7MfOqYAKna5OMxdbGWFiQz1sWMIUTkg5O7LMOrnHMYVIBfmKvyGJNwQFgTDlpFXEdcBUI0QbX/Umbq/GbYuA/fKgEOUwaBqynmyt+gzdaE0lgZwLB8TXg92Hs6vMk//3C5klprMGTVRwqmHgtjNou999erA8F4fyh2+Lc5trS3GRmnO4LVWmDKVaJBz6luK7APtgSIilaK8fxYFNcGlw9lqCMbQpqwXMZqsAG7nzAm+UDyW+PFSZLjOjqJEa3jwxEcyrOOFXNHJxL5tyJthqeJfYbaQKo/iFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORCach15bMHSMgjymSbfzEpyVhFtr+AeKrCUeFPI9cY=;
 b=LeZ2UFSo6YXfuCIKSzKQt55Mxa2WhsBz1bXcVjf5z7tAOqejmlz5SCTFkx4ESeZW1N8oMNzIhZ5kHDoqK6o4CpddYFUbqMYfZq+FCXUPAevr4GghPkw360De8pJjKvcVtw2uKDYuZ2HIm0OGXPpqc73IiUG1YC8lwQKbJbJtESM=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by BYAPR12MB3574.namprd12.prod.outlook.com (2603:10b6:a03:ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 21:23:32 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::ae) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 21:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 21:23:32 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 16:23:31 -0500
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/1] drm/amdkfd: Add sysfs bitfields and enums to uAPI
Date: Mon, 13 Sep 2021 17:23:20 -0400
Message-ID: <20210913212320.2470858-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dedc00d9-044e-4f20-1211-08d976fcbcd7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3574:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3574208905B486E11825291F92D99@BYAPR12MB3574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LMzhlRatUN1RjATu6RJVG/SM6AQtUMgSJD21r6ILIW/jQHN5FEb8P6tcZc0jsktdVozE4RBsJ4yn50qL53EsVrTqzM9JiJoAHTuVN8BK5vnn/+MrnxLFlMGDShr6XpxMXXPqz1F7sl6wo1AtXrRsPeYQyg0DNyye4BAX2QVI1LYoCE+hK0jtbAZAO+tNyKkD/FlWmbju3VPIqmIwE/YjcjMEzFY/wGXEQIiNESX9F8CA9XsewQvhi5QI3COquXBHVGLr1pfYOS77DRIF4mmTDm70BInGrHclkbzqt7pyS56wKEwwqItMRuE/1EkZAJrv8tvf28VfkhpuZ3dF5hyhWfFETxeCOHbxC04FUd4YvPbYtRvKtVWWMdZ6VXXI0Zi7TLvjpf4ylZZvI6cTlUlJBMOWiYpW4QdDCAHrNXsa68bQAzV4eLUzEy+LkVxb8fJs2zAdMr5niey42R+GwRPcdmZ85VtEjmaq2WwGqr6okOTyJiIgwBDzjAO/r7r0ChilymifBjZ6zF9QTIyKyrp9prFc2UIGOZZqYmTuheFi3zJLCGGhDFKDr+7VF21tWD9yf2oGVyn6gKFSZy9oQmcxQZKM3/7fb6YS/BNICT/IDFgxRtuz5hhvD2bb6XfJnxF8rF7RqxboCRypLUhPBJexow1VeQEQNcEPc5K2Bwhzya7jUn3lvjdABMazzlxB4MFkaBf6Hs51GilPiLmiYaRG6yFLSQ99LzHf6vOF84+aLVoODtV2ORlC9Lfyiri8+RV1TkmAjUX+pezyl4XMA8e5/G2oIT9r7kmF5YwFRWzPhq69SnKQmZqL+hGePmadFtm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(82310400003)(478600001)(5660300002)(70586007)(8936002)(47076005)(356005)(81166007)(966005)(36860700001)(16526019)(6666004)(186003)(2616005)(70206006)(2906002)(336012)(426003)(8676002)(7696005)(83380400001)(86362001)(1076003)(26005)(6916009)(36756003)(82740400003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 21:23:32.1259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dedc00d9-044e-4f20-1211-08d976fcbcd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3574
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

These bits are de-facto part of the uAPI, so declare them in a uAPI header.

The corresponding bit-fields and enums in user mode are defined in
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/blob/master/include/hsakmttypes.h

HSA_CAP_...           -> HSA_CAPABILITY
HSA_MEM_HEAP_TYPE_... -> HSA_HEAPTYPE
HSA_MEM_FLAGS_...     -> HSA_MEMORYPROPERTY
HSA_CACHE_TYPE_...    -> HsaCacheType
HSA_IOLINK_TYPE_...   -> HSA_IOLINKTYPE
HSA_IOLINK_FLAGS_...  -> HSA_LINKPROPERTY

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 MAINTAINERS                               |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  46 +--------
 include/uapi/linux/kfd_sysfs.h            | 108 ++++++++++++++++++++++
 3 files changed, 110 insertions(+), 45 deletions(-)
 create mode 100644 include/uapi/linux/kfd_sysfs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 84cd16694640..7554ec928ee2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -930,6 +930,7 @@ F:	drivers/gpu/drm/amd/include/kgd_kfd_interface.h
 F:	drivers/gpu/drm/amd/include/v9_structs.h
 F:	drivers/gpu/drm/amd/include/vi_structs.h
 F:	include/uapi/linux/kfd_ioctl.h
+F:	include/uapi/linux/kfd_sysfs.h
 
 AMD SPI DRIVER
 M:	Sanjay R Mehta <sanju.mehta@amd.com>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index a8db017c9b8e..f0cc59d2fd5d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -25,38 +25,11 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/kfd_sysfs.h>
 #include "kfd_crat.h"
 
 #define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 32
 
-#define HSA_CAP_HOT_PLUGGABLE			0x00000001
-#define HSA_CAP_ATS_PRESENT			0x00000002
-#define HSA_CAP_SHARED_WITH_GRAPHICS		0x00000004
-#define HSA_CAP_QUEUE_SIZE_POW2			0x00000008
-#define HSA_CAP_QUEUE_SIZE_32BIT		0x00000010
-#define HSA_CAP_QUEUE_IDLE_EVENT		0x00000020
-#define HSA_CAP_VA_LIMIT			0x00000040
-#define HSA_CAP_WATCH_POINTS_SUPPORTED		0x00000080
-#define HSA_CAP_WATCH_POINTS_TOTALBITS_MASK	0x00000f00
-#define HSA_CAP_WATCH_POINTS_TOTALBITS_SHIFT	8
-#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK	0x00003000
-#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT	12
-
-#define HSA_CAP_DOORBELL_TYPE_PRE_1_0		0x0
-#define HSA_CAP_DOORBELL_TYPE_1_0		0x1
-#define HSA_CAP_DOORBELL_TYPE_2_0		0x2
-#define HSA_CAP_AQL_QUEUE_DOUBLE_MAP		0x00004000
-
-#define HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED	0x00080000 /* Old buggy user mode depends on this being 0 */
-#define HSA_CAP_MEM_EDCSUPPORTED		0x00100000
-#define HSA_CAP_RASEVENTNOTIFY			0x00200000
-#define HSA_CAP_ASIC_REVISION_MASK		0x03c00000
-#define HSA_CAP_ASIC_REVISION_SHIFT		22
-#define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
-#define HSA_CAP_SVMAPI_SUPPORTED		0x08000000
-#define HSA_CAP_FLAGS_COHERENTHOSTACCESS	0x10000000
-#define HSA_CAP_RESERVED			0xe00f8000
-
 struct kfd_node_properties {
 	uint64_t hive_id;
 	uint32_t cpu_cores_count;
@@ -93,17 +66,6 @@ struct kfd_node_properties {
 	char name[KFD_TOPOLOGY_PUBLIC_NAME_SIZE];
 };
 
-#define HSA_MEM_HEAP_TYPE_SYSTEM	0
-#define HSA_MEM_HEAP_TYPE_FB_PUBLIC	1
-#define HSA_MEM_HEAP_TYPE_FB_PRIVATE	2
-#define HSA_MEM_HEAP_TYPE_GPU_GDS	3
-#define HSA_MEM_HEAP_TYPE_GPU_LDS	4
-#define HSA_MEM_HEAP_TYPE_GPU_SCRATCH	5
-
-#define HSA_MEM_FLAGS_HOT_PLUGGABLE		0x00000001
-#define HSA_MEM_FLAGS_NON_VOLATILE		0x00000002
-#define HSA_MEM_FLAGS_RESERVED			0xfffffffc
-
 struct kfd_mem_properties {
 	struct list_head	list;
 	uint32_t		heap_type;
@@ -116,12 +78,6 @@ struct kfd_mem_properties {
 	struct attribute	attr;
 };
 
-#define HSA_CACHE_TYPE_DATA		0x00000001
-#define HSA_CACHE_TYPE_INSTRUCTION	0x00000002
-#define HSA_CACHE_TYPE_CPU		0x00000004
-#define HSA_CACHE_TYPE_HSACU		0x00000008
-#define HSA_CACHE_TYPE_RESERVED		0xfffffff0
-
 struct kfd_cache_properties {
 	struct list_head	list;
 	uint32_t		processor_id_low;
diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
new file mode 100644
index 000000000000..e1fb78b4bf09
--- /dev/null
+++ b/include/uapi/linux/kfd_sysfs.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT WITH Linux-syscall-note */
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+ */
+
+#ifndef KFD_SYSFS_H_INCLUDED
+#define KFD_SYSFS_H_INCLUDED
+
+/* Capability bits in node properties */
+#define HSA_CAP_HOT_PLUGGABLE			0x00000001
+#define HSA_CAP_ATS_PRESENT			0x00000002
+#define HSA_CAP_SHARED_WITH_GRAPHICS		0x00000004
+#define HSA_CAP_QUEUE_SIZE_POW2			0x00000008
+#define HSA_CAP_QUEUE_SIZE_32BIT		0x00000010
+#define HSA_CAP_QUEUE_IDLE_EVENT		0x00000020
+#define HSA_CAP_VA_LIMIT			0x00000040
+#define HSA_CAP_WATCH_POINTS_SUPPORTED		0x00000080
+#define HSA_CAP_WATCH_POINTS_TOTALBITS_MASK	0x00000f00
+#define HSA_CAP_WATCH_POINTS_TOTALBITS_SHIFT	8
+#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK	0x00003000
+#define HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT	12
+
+#define HSA_CAP_DOORBELL_TYPE_PRE_1_0		0x0
+#define HSA_CAP_DOORBELL_TYPE_1_0		0x1
+#define HSA_CAP_DOORBELL_TYPE_2_0		0x2
+#define HSA_CAP_AQL_QUEUE_DOUBLE_MAP		0x00004000
+
+/* Old buggy user mode depends on this being 0 */
+#define HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED	0x00080000
+
+#define HSA_CAP_MEM_EDCSUPPORTED		0x00100000
+#define HSA_CAP_RASEVENTNOTIFY			0x00200000
+#define HSA_CAP_ASIC_REVISION_MASK		0x03c00000
+#define HSA_CAP_ASIC_REVISION_SHIFT		22
+#define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
+#define HSA_CAP_SVMAPI_SUPPORTED		0x08000000
+#define HSA_CAP_FLAGS_COHERENTHOSTACCESS	0x10000000
+#define HSA_CAP_RESERVED			0xe00f8000
+
+/* Heap types in memory properties */
+#define HSA_MEM_HEAP_TYPE_SYSTEM	0
+#define HSA_MEM_HEAP_TYPE_FB_PUBLIC	1
+#define HSA_MEM_HEAP_TYPE_FB_PRIVATE	2
+#define HSA_MEM_HEAP_TYPE_GPU_GDS	3
+#define HSA_MEM_HEAP_TYPE_GPU_LDS	4
+#define HSA_MEM_HEAP_TYPE_GPU_SCRATCH	5
+
+/* Flag bits in memory properties */
+#define HSA_MEM_FLAGS_HOT_PLUGGABLE		0x00000001
+#define HSA_MEM_FLAGS_NON_VOLATILE		0x00000002
+#define HSA_MEM_FLAGS_RESERVED			0xfffffffc
+
+/* Cache types in cache properties */
+#define HSA_CACHE_TYPE_DATA		0x00000001
+#define HSA_CACHE_TYPE_INSTRUCTION	0x00000002
+#define HSA_CACHE_TYPE_CPU		0x00000004
+#define HSA_CACHE_TYPE_HSACU		0x00000008
+#define HSA_CACHE_TYPE_RESERVED		0xfffffff0
+
+/* Link types in IO link properties (matches CRAT link types) */
+#define HSA_IOLINK_TYPE_UNDEFINED	0
+#define HSA_IOLINK_TYPE_HYPERTRANSPORT	1
+#define HSA_IOLINK_TYPE_PCIEXPRESS	2
+#define HSA_IOLINK_TYPE_AMBA		3
+#define HSA_IOLINK_TYPE_MIPI		4
+#define HSA_IOLINK_TYPE_QPI_1_1	5
+#define HSA_IOLINK_TYPE_RESERVED1	6
+#define HSA_IOLINK_TYPE_RESERVED2	7
+#define HSA_IOLINK_TYPE_RAPID_IO	8
+#define HSA_IOLINK_TYPE_INFINIBAND	9
+#define HSA_IOLINK_TYPE_RESERVED3	10
+#define HSA_IOLINK_TYPE_XGMI		11
+#define HSA_IOLINK_TYPE_XGOP		12
+#define HSA_IOLINK_TYPE_GZ		13
+#define HSA_IOLINK_TYPE_ETHERNET_RDMA	14
+#define HSA_IOLINK_TYPE_RDMA_OTHER	15
+#define HSA_IOLINK_TYPE_OTHER		16
+
+/* Flag bits in IO link properties (matches CRAT flags, excluding the
+ * bi-directional flag, which is not offially part of the CRAT spec, and
+ * only used internally in KFD)
+ */
+#define HSA_IOLINK_FLAGS_ENABLED		(1 << 0)
+#define HSA_IOLINK_FLAGS_NON_COHERENT		(1 << 1)
+#define HSA_IOLINK_FLAGS_NO_ATOMICS_32_BIT	(1 << 2)
+#define HSA_IOLINK_FLAGS_NO_ATOMICS_64_BIT	(1 << 3)
+#define HSA_IOLINK_FLAGS_NO_PEER_TO_PEER_DMA	(1 << 4)
+#define HSA_IOLINK_FLAGS_RESERVED		0xffffffe0
+
+#endif
-- 
2.32.0

