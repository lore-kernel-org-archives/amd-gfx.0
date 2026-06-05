Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A59ECD6E79
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267FB10E638;
	Fri,  5 Jun 2026 13:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bmrvfOsN";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010058.outbound.protection.outlook.com
 [40.93.198.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686A110E4D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pnh9I6tjfoa8bivu7/SFE1mXmYhYzQ+WVUhiFooytPzybz1nG9qC4Rxh353Hjff5OkNhNkcM922c3On39vJrmaeLh9+1O3F97nn/DDWM4iN3k5XBXhN+p3w8rXxZSD8qPvNtSyTltRNMCmXIL0/aR9DdPm0orbeZQnVJEjVukhrQS803SP2aLrFUHZYsqWHynbf1uKtAtRepgVs1JyXKBThJcX1a+UNVIEMcs6tfyVSrtTxv5OSL8T68vzv7D9E1DNNgrY3KLzygGhv0u+7bZpALlB/MXpZSFuOjsFbxplHBh1yN+Lq6lqKF+Az8Ff0N9JVSgDtqq7urKRKHwOE4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBzsBEipSuzlEp4q6Bb6oHy/hJFDyUeUkahchiyST2s=;
 b=qeV/jngwDWPwymgq0tDLKty/IN2/5H6mLiCfahuq/VN624DwvxTSBj+U2aElVjyEwpK093bHYKh5UuTpI9ueGY90+1EyWgnl4c69+VEIphjMxu8qH6Qh4LrjTihGHMEnOIYF6DyM328mgDweZ6Rzgn8PxcqnXTGbddpS5S+wFFAi6clN87mwVQCV/ajwGXmt8w9xZRyWCPDYRaRaaa640UERAHPQYFRKSt0/Pl7RdE+ju3TQpY+hSVash8B7TRZqLRnnp1zOiXX+QqjjiJzFtE0S88zbgA0QaOLIst4GyY7DAI07ZBS67iVJnpBId1j/a+lPEZCrJ5weOQLfGjI/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBzsBEipSuzlEp4q6Bb6oHy/hJFDyUeUkahchiyST2s=;
 b=bmrvfOsNCo1oTFOwYTOhgfyZhPdluPE05yGDoF7hOrlv7l44oRp29aaesWxnxYyF5IbMokaJ5o9ee/uh5UUJsNVFlU8nb4VGZyYgzkiyHV+4rfXwL7lBmxlap52Oo64ahb+TtNrlEBJIqIos6VCcsshtVaSqas0QYNbG7KUGu2Y=
Received: from DS1P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::11) by
 SJ5PPF816B88375.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99b)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 13:44:17 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:454:cafe::65) by DS1P222CA0011.outlook.office365.com
 (2603:10b6:8:454::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 13:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 13:44:16 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 08:44:14 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH 01/11] drm/amdgpu: move struct amdgpu_sa from amdgpu.h into
 its own header file
Date: Fri, 5 Jun 2026 09:43:13 -0400
Message-ID: <20260605134400.956791-2-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605134400.956791-1-shahyan.soltani@amd.com>
References: <20260605134400.956791-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|SJ5PPF816B88375:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3f7b8e-3e8b-47d9-0918-08dec30889af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|3023799007|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iLo/OJdaGEAgBxMPCoemVBX+Z89KqP6ylawqxFE1TxKu96vo/DPuwKXbFNI6lt2yYlj08Cct7iE5EYabRp5+Jg/zVMti9isYEBF59fUFQgsh2JbQwGkuzDBnyxiBlPPLCF4OWXARglROmQ09Nf9oZgTp17qCohDDS5OpzjXcA4WnZnMtKTgu+MoJcJ4IxdNUK5YZtRECZVw/Ur1DKjwPuvsD0v5bdic4bygnzqLK89L4/OUp0k7mjVQubcDsguUK/1efzZjC2y9Aod6hbVnthSAxDGZ8zAZ2KaIEyA5Lr88onzE/WlYsfPL6ELc3pijLVw3txy+i/J9hI4LvcTWftQMf5eFhNDXZBmF2Yk1eyq0AcZZiA8HXBPUlK7GWPlqDxnLZZ8t4adDKHs8h1V9N/dO1Y8AX/yq76nBjo50iCMfTlTaDiaAFsCsSSJDsvbPDzz+ufc+nE+gyztY35Dsbs57EjzvEZwWEQdtiTLSHgKLpBmLDX/8mY0D72q+YBkNAejpzG8Fj/IUHZtFI4DYWFPE1JSr4jUOUxClrOUMQ2Qr5DS5gK0Rb+0mrpCi/pe2451llhf0ewoWhjrJxkS7059rjlFVuf87ZVyRY5H5tWnAUqUgPI8FTUdCWk+LhkrM+5AR9uaWaeMKU6Nk4EQfjmNSqM5Fxxwn5AJkuOHtAMVysNBYVaGLNct+0iyVyEvw3huWSlG80wM/bTPAxTsYl7TlP6KUrKIVXQHrSYvcRXDo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(3023799007)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qVM03PSGv4ASnaLP+HYpTyzmITW23E0vcJjvJZ3LTpSnHPb0u/zPQjYXD0TApZH81lF+UmQsCt3G3kw709i7hW7GoG23cGrvI+jXOPOkDbduqv1w3jcFe3jxnqHjGacD2A0TPEW7GM8rMyJVN2lLjIk+o84BLBjSzqAP7dRbbXoI72oYj4nVcoVyYMSmB0erQODS6P+Vnm/EhkCVKUErcuI0rS+KPVM48/ybbNPjbChx2wmI5n2RR2bC1Q+7ARWtcCZ/ScLXILhPIOBgdke65H7FsGn17IWz6Qhc9gznXYHJ2u87dK+zFX8aWLScgYALYq57RRaU53ag9+7Bsy+Rd2gRV0lUPEmsRpabSELH8Wyuu6v3/cgnbWJvMFvDt+F/CHoce32kOxGwhgSrXNyb2xVuihkVHI4/Wtpzu9eycCkZOQrTwztwbe0AwqUXipu7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:44:16.9470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3f7b8e-3e8b-47d9-0918-08dec30889af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF816B88375
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

Move struct amdgpu_sa_manager out of the monolithic header amdgpu.h into
its own dedicated header amdgpu_sa.h.

This is part of the ongoing effort to reduce the size of amdgpu.h into
their own respective separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 32 +-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h | 61 ++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 31 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d7bfa59424a..d7d8664854fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -111,6 +111,7 @@
 #include "amdgpu_reg_state.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_eviction_fence.h"
+#include "amdgpu_sa.h"
 #include "amdgpu_ip.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
@@ -386,37 +387,6 @@ struct amdgpu_clock {
 	uint32_t max_pixel_clock;
 };
 
-/* sub-allocation manager, it has to be protected by another lock.
- * By conception this is an helper for other part of the driver
- * like the indirect buffer or semaphore, which both have their
- * locking.
- *
- * Principe is simple, we keep a list of sub allocation in offset
- * order (first entry has offset == 0, last entry has the highest
- * offset).
- *
- * When allocating new object we first check if there is room at
- * the end total_size - (last_object_offset + last_object_size) >=
- * alloc_size. If so we allocate new object there.
- *
- * When there is not enough room at the end, we start waiting for
- * each sub object until we reach object_offset+object_size >=
- * alloc_size, this object then become the sub object we return.
- *
- * Alignment can't be bigger than page size.
- *
- * Hole are not considered for allocation to keep things simple.
- * Assumption is that there won't be hole (all object on same
- * alignment).
- */
-
-struct amdgpu_sa_manager {
-	struct drm_suballoc_manager	base;
-	struct amdgpu_bo		*bo;
-	uint64_t			gpu_addr;
-	void				*cpu_ptr;
-};
-
 /*
  * IRQS.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
new file mode 100644
index 000000000000..a878443c8c75
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT
+ *
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
+ */
+#ifndef __AMDGPU_SA_H__
+#define __AMDGPU_SA_H__
+
+#include <drm/drm_suballoc.h>
+#include <linux/types.h>
+
+struct amdgpu_bo;
+
+/* sub-allocation manager, it has to be protected by another lock.
+ * By conception this is an helper for other part of the driver
+ * like the indirect buffer or semaphore, which both have their
+ * locking.
+ *
+ * Principe is simple, we keep a list of sub allocation in offset
+ * order (first entry has offset == 0, last entry has the highest
+ * offset).
+ *
+ * When allocating new object we first check if there is room at
+ * the end total_size - (last_object_offset + last_object_size) >=
+ * alloc_size. If so we allocate new object there.
+ *
+ * When there is not enough room at the end, we start waiting for
+ * each sub object until we reach object_offset+object_size >=
+ * alloc_size, this object then become the sub object we return.
+ *
+ * Alignment can't be bigger than page size.
+ *
+ * Hole are not considered for allocation to keep things simple.
+ * Assumption is that there won't be hole (all object on same
+ * alignment).
+ */
+
+struct amdgpu_sa_manager {
+	struct drm_suballoc_manager	base;
+	struct amdgpu_bo		*bo;
+	uint64_t			gpu_addr;
+	void				*cpu_ptr;
+};
+#endif
-- 
2.54.0

