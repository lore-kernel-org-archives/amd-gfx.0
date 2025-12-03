Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A14AD12D5C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 13:05:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1709610E794;
	Wed,  3 Dec 2025 13:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EdxxBVy+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F07810E794
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 13:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gV/0GcOvkXGI0ZmH+ZjH16MOQMatpO4fPoCyZYTQNIb+2RjW/OsdPHZyHwDu1frLxRknm6wJT8OHQENsM9elzBvSw2hm/b+hzXg4DD1TfXvzaKX5340g5Q5xVFFFvO3liyJoV2JOk/XGJlKYLoN1ioKc/TFh4NnQZAZIUc4UeFiH6OiCIzoqImzuaU6pP2qMLbhFofsDgNm8XrJo1XhRLUfbVoO2zkmCYH64/cNDxXseN7rI2Dz2bkm9MIrA53StV7lgO8O1njcfRMDKFpUOFOHcp2PzyfE1BLZKFnpGg3C246uIPlh7DvXppbLqR9iXaKy3rUhq4qQ+GW4avzX3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4X7LYoeJUXz/PGrTSZVL+2Y6oie1TeSVpIKZMQhxg2c=;
 b=y/2FrivJD7ZqPgEmic7984B2AeBaDhDNe8+qdlvfKg1sFwSbZ6TK2EBXsrr7yr6M8xgSG+chqLAaU/NxzslhKiemUtmhJvF97kR41fgqcuR3VfSQwsEQpnFtIAzWt1s4dAGqCw2jM+h+katOESOc9894hhBIFYlhldJd0SUSewrBC5/wnkZqtrN5QyUH/icsZG7kG+jz9gxfTb7CIIpm2pas2sbrlMLihOXQWocOcY1DMzSMBO5LypNnt8BRsP1KvQRe5mKDsjhCxiQ6Vn6yKOUT4XH58NdyW0AsNoit7ub+3qusy4YrZu8cAZ1KUhkt7D1lVMi1HQsDrI+K3A6iSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4X7LYoeJUXz/PGrTSZVL+2Y6oie1TeSVpIKZMQhxg2c=;
 b=EdxxBVy+vB7VAB5rPCh0cgCOkUx9ALm4AxW8zzRNE4mmSgouq4uGxDFao1VYMceOkxUgYHek069Eyvo8KWicBmsGZFKWXSI2TH182pyNyOV9iRnbRjIGxhwSbMSPzafze8qsEEXuYRe+Aq6dvpvU+nX5N5q4HRBxfbGefdmI1Hs=
Received: from BN9PR03CA0155.namprd03.prod.outlook.com (2603:10b6:408:f4::10)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 13:05:04 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f4:cafe::b3) by BN9PR03CA0155.outlook.office365.com
 (2603:10b6:408:f4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 13:05:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Wed, 3 Dec 2025 13:05:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 07:05:02 -0600
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 05:05:00 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [RFC PATCH v3 02/10] drm/amdgpu: Add cwsr functions
Date: Wed, 3 Dec 2025 18:24:53 +0530
Message-ID: <20251203130436.745633-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203130436.745633-1-lijo.lazar@amd.com>
References: <20251203130436.745633-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ed8ec1-a79f-4273-2a3b-08de326c9312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cHotlXZguk1Rg7BgnJAutEog7CiL8/HtC3Qko5j/OUrsm019y2qnVuAPFd19?=
 =?us-ascii?Q?rn9crSOKrUkDgwKKPVWsfQMRFa0ry+jPHq5y2sssHcPXJ/cMwVBNHzW3xpvE?=
 =?us-ascii?Q?gU13ChYEwrHrNB1nyOJcFAHZDWQFJWg8eMt2e6ChNuMS1uXIYlaSMmoBUh55?=
 =?us-ascii?Q?28iU8tkgUlqkYPRgqxp9ku+buqsjOGaDOtS6kZIju8Eo1wWkNhitvRYEe59G?=
 =?us-ascii?Q?BdcmK0+jWRJpe/NuOIfvevJNjCsTNqqp6KdkLZAate07QZt1jpQEK1jw3PF0?=
 =?us-ascii?Q?7fdAitHS9xS1VQKXQpd8cyZH/Dchm1v5JE8s8MsET6jOlUYgJehdOvT+CcX3?=
 =?us-ascii?Q?rUzPmFYMxQ8mVK7wm08XLKi2316mqY8Jn/uPBZhCJ4oA3b9djnbb2ml3CpRY?=
 =?us-ascii?Q?vyy7IRl/4nAeECh8yD/04/I2DCf7XWbUsmenZjNPDJG4y0T7iTS8Rxxu/uf6?=
 =?us-ascii?Q?F46FsnlTEdhQUbLsYzDJBAeCjgCs0RWxkOKYqOj5m7okcTloWGPtnkZWyraC?=
 =?us-ascii?Q?YxCddH6n2zkgpE528vJcCxgRODgsAG53fBK1rgbPxAORCT/fFzDxqMzN+MTV?=
 =?us-ascii?Q?CJQAWagYg1ziczVnT/8NlBW4lpM1R7AP9sPvVy7uX8bi5vvRyHaseafFPjT/?=
 =?us-ascii?Q?n7gPedo9tnWuv0A69zSB+c8UrhyF6VjqC6hnyHNv6Z10UzUHs+/IKUwWxBkH?=
 =?us-ascii?Q?uwB3Y8xNG9hvc00a2exBXkj4euDoukkNzHlEpq3BCgv1po6nDDMtKG+rrOH7?=
 =?us-ascii?Q?qyYgsj5RJt1Ds5UfiB1Fa5VLTFcUOe5KV+cL63SFe6TJbyUaJBnuLvqczUpG?=
 =?us-ascii?Q?HcMQtUZ2mlrEteKVbtmowg8JE6cEw2ENY2qoj+OgVtXVm0EUgvpVM09OcIqW?=
 =?us-ascii?Q?JmT/mxTW734khLfIitQiAqsvf73uBsGOlP8ZHUcCqpeQUtT6HJnj2H+dSp4v?=
 =?us-ascii?Q?dXUdWJ7FdGt1JRCKue78T2s3I+zTo6CwGHmdaEN6hyCh0p1uw9k7WiyL1cR6?=
 =?us-ascii?Q?t2+6lIisevqWiDRNr/XUzSzqKX07wZuehM1KWI5VcY+raE9tlbm19VnBAN62?=
 =?us-ascii?Q?Pjm5qAgi6RKCUyYCXA0cqOF4XXQGDTYlzTB+XaBSClhoSi5f+spunCruOcN4?=
 =?us-ascii?Q?2P+um1cMM/32Qp+uuqRD5lnlgMsHxn8U5b3Foi6fu3HLjCXpdf4wf8/QWlHu?=
 =?us-ascii?Q?60LrEqgg7ZIyCaJddczMkQLp8atsyPXrHqcrLyfLKo+ue9TUvk5Kw3QtoWtT?=
 =?us-ascii?Q?G0eGNnqqDcvo1x6an0rv07k+wUjlYNgbfuUGUfsfvkth+1aWKq/HVt5eU3ee?=
 =?us-ascii?Q?EA8LUu4GdSDjoOQ2l0vXYl5IszV3OEnJpj/cf+yTRiolLGIsSeX1gKn99JrM?=
 =?us-ascii?Q?0/t+vgFu+EEvru3OubCXT8TC9UUsj6yioK4l4RliP8SAyrZU1fnpjDTfbA33?=
 =?us-ascii?Q?w6Y8rVRYNbbUngU1vwhu3U63y0UdB9yGqP7mE/cVzyNd4rojcPviO21v4giq?=
 =?us-ascii?Q?uMH7TApEzjbWOGNNQ/8esiuJUHoSUazLYxOrvPnUQtRBnu+5vEaUHVcby7xf?=
 =?us-ascii?Q?Zp6sw/EyEYhVm0Zw/m4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:05:03.8069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ed8ec1-a79f-4273-2a3b-08de326c9312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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

Add functions related to cwsr handling inside amdgpu framework.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 346 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  67 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |   2 +-
 5 files changed, 418 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index f65021678fc0..a5feb674508a 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -67,7 +67,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
 	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
-	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
+	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o  amdgpu_cwsr.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fa71df36f4b3..b9920cab5d31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -331,6 +331,7 @@ struct kfd_vm_fault_info;
 struct amdgpu_hive_info;
 struct amdgpu_reset_context;
 struct amdgpu_reset_control;
+struct amdgpu_cwsr_isa;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -1325,6 +1326,8 @@ struct amdgpu_device {
 	 * Must be last --ends in a flexible-array member.
 	 */
 	struct amdgpu_kfd_dev		kfd;
+
+	struct amdgpu_cwsr_info *cwsr_info;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
new file mode 100644
index 000000000000..c0fc5a383071
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -0,0 +1,346 @@
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
+ */
+
+#include <drm/drm_exec.h>
+
+#include "amdgpu.h"
+#include "cwsr_trap_handler.h"
+#include "amdgpu_cwsr.h"
+
+extern int cwsr_enable;
+
+#define AMDGPU_CWSR_TBA_MAX_SIZE (2 * AMDGPU_GPU_PAGE_SIZE)
+#define AMDGPU_CWSR_TMA_MAX_SIZE (AMDGPU_GPU_PAGE_SIZE)
+#define AMDGPU_CWSR_TMA_OFFSET (AMDGPU_CWSR_TBA_MAX_SIZE)
+
+enum amdgpu_cwsr_region {
+	AMDGPU_CWSR_TBA,
+	AMDGPU_CWSR_TMA,
+};
+
+static inline uint64_t amdgpu_cwsr_tba_vaddr(struct amdgpu_device *adev)
+{
+	uint64_t addr = AMDGPU_VA_RESERVED_TRAP_START(adev);
+
+	addr = amdgpu_gmc_sign_extend(addr);
+
+	return addr;
+}
+
+static inline bool amdgpu_cwsr_is_supported(struct amdgpu_device *adev)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	if (!cwsr_enable || gc_ver < IP_VERSION(9, 0, 1))
+		return false;
+
+	return true;
+}
+
+static void amdgpu_cwsr_init_isa_details(struct amdgpu_device *adev,
+					 struct amdgpu_cwsr_info *cwsr_info)
+{
+	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	if (gc_ver < IP_VERSION(9, 0, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx8_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx8_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_arcturus_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_arcturus_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_arcturus_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 2)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_aldebaran_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_aldebaran_hex);
+	} else if (gc_ver == IP_VERSION(9, 4, 3) ||
+		   gc_ver == IP_VERSION(9, 4, 4)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_4_3_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx9_4_3_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_4_3_hex);
+	} else if (gc_ver == IP_VERSION(9, 5, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_5_0_hex) > PAGE_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx9_5_0_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_5_0_hex);
+	} else if (gc_ver < IP_VERSION(10, 1, 1)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx9_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx9_hex);
+	} else if (gc_ver < IP_VERSION(10, 3, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_nv1x_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_nv1x_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_nv1x_hex);
+	} else if (gc_ver < IP_VERSION(11, 0, 0)) {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx10_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx10_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx10_hex);
+	} else if (gc_ver < IP_VERSION(12, 0, 0)) {
+		/* The gfx11 cwsr trap handler must fit inside a single
+			   page. */
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx11_hex) > PAGE_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx11_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx11_hex);
+	} else {
+		BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) >
+			     AMDGPU_CWSR_TBA_MAX_SIZE);
+		cwsr_info->isa_buf = cwsr_trap_gfx12_hex;
+		cwsr_info->isa_sz = sizeof(cwsr_trap_gfx12_hex);
+	}
+}
+
+int amdgpu_cwsr_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_cwsr_info *cwsr_info __free(kfree) = NULL;
+	void *ptr;
+	int r;
+
+	if (!amdgpu_cwsr_is_supported(adev))
+		return -EOPNOTSUPP;
+
+	cwsr_info = kzalloc(sizeof(*cwsr_info), GFP_KERNEL);
+	if (!cwsr_info)
+		return -ENOMEM;
+	amdgpu_cwsr_init_isa_details(adev, cwsr_info);
+
+	if (!cwsr_info->isa_sz)
+		return -EOPNOTSUPP;
+
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TBA_MAX_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &cwsr_info->isa_bo,
+				    NULL, &ptr);
+	if (r)
+		return r;
+
+	memcpy(ptr, cwsr_info->isa_buf, cwsr_info->isa_sz);
+	adev->cwsr_info = no_free_ptr(cwsr_info);
+
+	return 0;
+}
+
+void amdgpu_cwsr_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return;
+
+	amdgpu_bo_free_kernel(&adev->cwsr_info->isa_bo, NULL, NULL);
+	kfree(adev->cwsr_info);
+	adev->cwsr_info = NULL;
+}
+
+/*
+ * amdgpu_map_cwsr_trap_handler should be called during amdgpu_vm_init
+ * it maps virtual address amdgpu_cwsr_trap_handler_vaddr() to this VM, and each
+ * compute queue can use this virtual address for wave save/restore
+ * operations to support compute preemption.
+ */
+static int amdgpu_cwsr_map_region(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm,
+				  struct amdgpu_cwsr_trap_obj *cwsr,
+				  enum amdgpu_cwsr_region region)
+{
+	uint64_t cwsr_addr, va_flags, va;
+	struct amdgpu_bo_va **bo_va;
+	struct amdgpu_bo *bo;
+	uint32_t size;
+	int r;
+
+	if (!cwsr || !vm)
+		return -EINVAL;
+
+	cwsr_addr = amdgpu_cwsr_tba_vaddr(adev);
+
+	if (region == AMDGPU_CWSR_TBA) {
+		size = AMDGPU_CWSR_TBA_MAX_SIZE;
+		bo_va = &cwsr->tba_va;
+		bo = adev->cwsr_info->isa_bo;
+		va = cwsr_addr;
+		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE |
+			    AMDGPU_VM_PAGE_EXECUTABLE);
+	} else {
+		size = AMDGPU_CWSR_TMA_MAX_SIZE;
+		bo_va = &cwsr->tma_va;
+		bo = cwsr->tma_bo;
+		va = cwsr_addr + AMDGPU_CWSR_TMA_OFFSET;
+		va_flags = (AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_PAGE_WRITEABLE);
+	}
+
+	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
+	if (!*bo_va)
+		return -ENOMEM;
+
+	va &= AMDGPU_GMC_HOLE_MASK;
+	r = amdgpu_vm_bo_map(adev, *bo_va, va, 0, size, va_flags);
+
+	if (r) {
+		dev_err(adev->dev, "failed to do bo_map on CWSR TBA, err=%d\n",
+			r);
+		amdgpu_vm_bo_del(adev, *bo_va);
+		*bo_va = NULL;
+	} else {
+		if (region == AMDGPU_CWSR_TBA)
+			cwsr->tba_gpu_va_addr = va;
+		else
+			cwsr->tma_gpu_va_addr = va;
+	}
+
+	return r;
+}
+
+static int amdgpu_cwsr_unmap_region(struct amdgpu_device *adev,
+				    struct amdgpu_cwsr_trap_obj *cwsr,
+				    enum amdgpu_cwsr_region region)
+{
+	struct amdgpu_bo_va **bo_va;
+	uint64_t va;
+	int r;
+
+	if (!cwsr)
+		return -EINVAL;
+
+	if (region == AMDGPU_CWSR_TBA) {
+		bo_va = &cwsr->tba_va;
+		va = cwsr->tba_gpu_va_addr;
+	} else {
+		bo_va = &cwsr->tma_va;
+		va = cwsr->tma_gpu_va_addr;
+	}
+
+	r = amdgpu_vm_bo_unmap(adev, *bo_va, va);
+	if (r) {
+		dev_err(adev->dev,
+			"failed to do bo_unmap on CWSR trap handler, err=%d\n",
+			r);
+		return r;
+	}
+
+	amdgpu_vm_bo_del(adev, *bo_va);
+	*bo_va = NULL;
+
+	return r;
+}
+
+/* TBD : Handle APU allocation */
+int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **trap_obj)
+{
+	struct amdgpu_cwsr_trap_obj *cwsr __free(kfree) = NULL;
+	struct amdgpu_bo *bo;
+	struct drm_exec exec;
+	int r;
+
+	if (!amdgpu_cwsr_is_enabled(adev))
+		return -EOPNOTSUPP;
+
+	cwsr = kzalloc(sizeof(*cwsr), GFP_KERNEL);
+	if (!cwsr)
+		return -ENOMEM;
+
+	bo = adev->cwsr_info->isa_bo;
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&exec)
+	{
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r)) {
+			dev_err(adev->dev,
+				"failed to reserve for CWSR allocs: err=%d\n",
+				r);
+			goto err;
+		}
+	}
+
+	r = amdgpu_bo_create_kernel(adev, AMDGPU_CWSR_TMA_MAX_SIZE, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &cwsr->tma_bo, NULL,
+				    &cwsr->tma_cpu_addr);
+	if (r)
+		goto err;
+
+	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TMA);
+	if (r)
+		goto err;
+	r = amdgpu_cwsr_map_region(adev, vm, cwsr, AMDGPU_CWSR_TBA);
+	if (r) {
+		amdgpu_cwsr_unmap_region(adev, cwsr, AMDGPU_CWSR_TMA);
+		goto err;
+	}
+
+	*trap_obj = no_free_ptr(cwsr);
+
+err:
+	drm_exec_fini(&exec);
+	if (r)
+		amdgpu_bo_free_kernel(&cwsr->tma_bo, NULL, NULL);
+
+	return r;
+}
+
+void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **trap_obj)
+{
+	struct amdgpu_bo *tba_bo;
+	struct amdgpu_bo *tma_bo;
+	struct drm_exec exec;
+	int r;
+
+	if (!trap_obj || !*trap_obj || !(*trap_obj)->tma_bo)
+		return;
+	tba_bo = adev->cwsr_info->isa_bo;
+	tma_bo = (*trap_obj)->tma_bo;
+
+	if (!tba_bo || !tma_bo)
+		return;
+
+	drm_exec_init(&exec, 0, 0);
+	drm_exec_until_all_locked(&exec)
+	{
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &tba_bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &tma_bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r)) {
+			dev_err(adev->dev,
+				"failed to reserve CWSR BOs: err=%d\n", r);
+			goto err;
+		}
+	}
+
+	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TBA);
+	amdgpu_cwsr_unmap_region(adev, *trap_obj, AMDGPU_CWSR_TMA);
+err:
+	drm_exec_fini(&exec);
+	amdgpu_bo_free_kernel(&(*trap_obj)->tma_bo, NULL, NULL);
+	kfree(*trap_obj);
+	*trap_obj = NULL;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
new file mode 100644
index 000000000000..26ed9308f70b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -0,0 +1,67 @@
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
+ */
+
+#ifndef AMDGPU_CWSR_H
+#define AMDGPU_CWSR_H
+
+#include <linux/types.h>
+
+struct amdgpu_bo;
+struct amdgpu_bo_va;
+struct amdgpu_device;
+struct amdgpu_vm;
+
+/**
+ * struct amdgpu_cwsr_obj - CWSR (Compute Wave Save Restore) buffer tracking
+ * @bo: Buffer object for CWSR area
+ * @bo_va: Buffer object virtual address mapping
+ */
+struct amdgpu_cwsr_trap_obj {
+	uint64_t tma_gpu_va_addr;
+	uint64_t tba_gpu_va_addr;
+
+	struct amdgpu_bo *tma_bo;
+	struct amdgpu_bo_va *tba_va;
+	struct amdgpu_bo_va *tma_va;
+	void *tma_cpu_addr;
+};
+
+struct amdgpu_cwsr_info {
+	/* cwsr isa */
+	struct amdgpu_bo *isa_bo;
+	const void *isa_buf;
+	uint32_t isa_sz;
+};
+
+int amdgpu_cwsr_init(struct amdgpu_device *adev);
+void amdgpu_cwsr_fini(struct amdgpu_device *adev);
+
+int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
+void amdgpu_cwsr_free(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		      struct amdgpu_cwsr_trap_obj **cwsr_obj);
+static inline bool amdgpu_cwsr_is_enabled(struct amdgpu_device *adev)
+{
+	return adev->cwsr_info != NULL;
+}
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..783ca2b8dfef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
 #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
 #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
 						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
-#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
+#define AMDGPU_VA_RESERVED_TRAP_SIZE		(3ULL << 12)
 #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
 						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
 #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
-- 
2.49.0

