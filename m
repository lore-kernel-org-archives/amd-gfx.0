Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6992FCD8C83
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 13:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 000AF10E4D2;
	Fri,  5 Jun 2026 13:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VAc8VXwA";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012045.outbound.protection.outlook.com
 [40.107.200.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D285310E4D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 13:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7rOiubZ8Je8Wzb3GidPBt9fmn8Q4R/o91XNg0+hdwTkxT407AKoWTudi0dWB+MTKt1D7REJzoEgwwolmdqDj/wF9bXFpn1xQwaZAhL1ZoTf0rDCLUCaFjnV1XwxpZIWGGkbbwqGqj6dovXzJ5X5oyas+MWznSlMH+rTcPosvjsLIeoEG0ixYZlSX5bW0ruzVTyYHqMjVe0hvUuc/MKH+PUSfaZyQhtu0gfmCxXLslyft7gYioLnGu41cDmzstOqrQ1bRMQdkLaS5eX9bJQw8LKIO96hVO9PK6AYJ1eVbnO5awv11FPskXEvmZN/movsNNNGuLbBDtPgHncX2svDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9JaID9znL7f9z4EqI3vVeZleqbbXoKkCY/jHUclKag=;
 b=XsGoi8JxMPaCurz9alStlXwlUIolWV8yTdfY7tmpBbQf7+9x4itDPOWlPiTsOW32YmwvtqikvBJ31ZFZc/MgtrrvjYGyo4IsZKEWLo3h902wtBFVO4Ya5VDQV5paM7rHuIsHB3FEmKyPg0Rc+cUuaE5DDkSxVq7HmglS8OqZ1uC9T6JQMnOZ7IWyOuPyzdCCYkMa0h3PwFwDcM63zipdtTpASpoH5/ERZdmWh3R6F5ZI77KD2neP+9zyhozsq3+X4nyaeJj5x8auws7jR9+VfFtNULOVz2g5xmuyqqdo11IUEJH8fVnE72/ZwjAKGfoJ/EDZoj1/7rrbdwFI4Ap3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9JaID9znL7f9z4EqI3vVeZleqbbXoKkCY/jHUclKag=;
 b=VAc8VXwA/ML0K9qMAyw8O6CisLvuSMxHo0fqlnTM9HmI4eYNBs5d6NBoX3scdsyJYH6oE4k+6VDzzH/fCRbRm3caHJeZ0+Mm7Jc3aAdiyBtCkTc03eYh3jBTdF0sxKzRu90eIxWCv7KJjVAA9/AW6z1jfFfJgXod3o+pLjVhF1w=
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 13:44:18 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::e) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 13:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 13:44:18 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 08:44:14 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH 02/11] drm/amdgpu: move struct amdgpu_wb and helpers into
 separate header file
Date: Fri, 5 Jun 2026 09:43:14 -0400
Message-ID: <20260605134400.956791-3-shahyan.soltani@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0bbd41-d19f-4ce3-ebf7-08dec3088a51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rr3lzORA+V/BD6C2M7SliFaGbWBkojGu1o08E8EVi3I4bcUqqI3CNpdNTbRilk+X0+epYN5hEML+RgbvmG1maR0LCXvYcTu3cAKFuuAuNjGp3ZyY0xZJLPIeIv69L2ISgLYjLEJZciyeo6ItcWfEYyd6v/j18Yt4LBPVQU0HBKL37R+aTY1AGuo7rFyK8cqChjDo+rAF24UHn+M1jdUsBJ6dTijJRtlcaStzBOp+5gh+DwKbeWNzHZ3n6qnwaf7Flwv+Zmk4OxOt7CuWq/dstjuzo1kXZG+pAMtMkXw6/SML6E/JiC+dd9PkSOCkFHfghBwVCJSdXgTvI2O9qhmujX42EewPCsAQg8BuLk8oh7LNFnUBjSs96/HAxgC/DCybQnnfasegdZ9gsbD6xYRhAowH6fqbR9rwZ+ENmtzbg9PQsuC+vrrfiZnb/uQP96KkZ/ptCKAxbhUnJk0ui7i8YuVYRih9KuXGi6nwNm74cBvxUB0X/WoqFGNMdt1KaePRCfuR9BDFWgMLKVOVljQl7RPkq7tDJxP+QY2fZijt/+YP0tgDSFLxNxPtBH5ji2A4X9JebXETD6RRWEyVeddgtLAZ7PCsCeqaerQm6ifKy5LKcuMrAoDijtwRQsB+QZ3xRMkXpHwbYS4PLIAKTk7XIktw+cPXydj56M6eGizRscRoqNpC4JpjToMzNSyVarnQACYW6VX8ODb8HiGFphA20oevaNkWTMy2azNUxipgSos=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XAhF9+kxrf65HQJuVHbcRN+dE2W+guoNGaHWVnk2vEFIwKQU4bGPRTfAm+Rl20gQdfU1jeWfCEmSyfrXWbGHNWd66wAEWW8kjs8Fj1W4/UIobKOIsIdDMXvoRpWqq3y2FTfNpBJYunDciPTzNr0K648iFKRXuKaEHSFqOgdEJRmH91cKQJGrptV2rHC5AtzaHehyBkOf8uAgVgdCeydPh4gBrj3AvXtIweJGhyHiVR1IXi0FxAJJzzPYqSDSV546L9i3zVdskU/2Vh3ffP4oSf1HxayMlvKiiRlXzgVxPBM3lDDUzQvqXExq3LiA9FtJ0/kgQ8higHOPPRBiBrxjce+qVGsnAz47UrL5izkgyVW15H7VG3ddUOyvdrjfOtntB8ylk4no5D4rS2i/6otCU7As/0dZIha6N11r1VAdePxGfukbW+y8dpysNSElLvgm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 13:44:18.0450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0bbd41-d19f-4ce3-ebf7-08dec3088a51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
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

Move struct amdgpu_wb and helpers out of the monolithic header amdgpu.h
into its own dedicated header amdgpu_wb.h.

This is part of the ongoing effort to reduce the size of amdgpu.h into
their own respective separate headers.

Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h    |  68 +----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h | 100 +++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 67 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d7d8664854fd..9a714b4b59bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -112,6 +112,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_eviction_fence.h"
 #include "amdgpu_sa.h"
+#include "amdgpu_wb.h"
 #include "amdgpu_ip.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
@@ -429,73 +430,6 @@ struct amdgpu_fpriv {
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
-/*
- * Writeback
- */
-#define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
-
-/**
- * struct amdgpu_wb - This struct is used for small GPU memory allocation.
- *
- * This struct is used to allocate a small amount of GPU memory that can be
- * used to shadow certain states into the memory. This is especially useful for
- * providing easy CPU access to some states without requiring register access
- * (e.g., if some block is power gated, reading register may be problematic).
- *
- * Note: the term writeback was initially used because many of the amdgpu
- * components had some level of writeback memory, and this struct initially
- * described those components.
- */
-struct amdgpu_wb {
-
-	/**
-	 * @wb_obj:
-	 *
-	 * Buffer Object used for the writeback memory.
-	 */
-	struct amdgpu_bo	*wb_obj;
-
-	/**
-	 * @wb:
-	 *
-	 * Pointer to the first writeback slot. In terms of CPU address
-	 * this value can be accessed directly by using the offset as an index.
-	 * For the GPU address, it is necessary to use gpu_addr and the offset.
-	 */
-	uint32_t		*wb;
-
-	/**
-	 * @gpu_addr:
-	 *
-	 * Writeback base address in the GPU.
-	 */
-	uint64_t		gpu_addr;
-
-	/**
-	 * @num_wb:
-	 *
-	 * Number of writeback slots reserved for amdgpu.
-	 */
-	u32			num_wb;
-
-	/**
-	 * @used:
-	 *
-	 * Track the writeback slot already used.
-	 */
-	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
-
-	/**
-	 * @lock:
-	 *
-	 * Protects read and write of the used field array.
-	 */
-	spinlock_t		lock;
-};
-
-int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
-void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
-
 /*
  * Benchmarking
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
new file mode 100644
index 000000000000..dac9fc3f0004
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
@@ -0,0 +1,100 @@
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
+#ifndef __AMDGPU_WB_H__
+#define __AMDGPU_WB_H__
+
+#include <linux/types.h>
+#include <linux/spinlock_types.h>
+#include <linux/math.h>
+
+/*
+ * Writeback
+ */
+#define AMDGPU_MAX_WB 1024	/* Reserve at most 1024 WB slots for amdgpu-owned rings. */
+
+/**
+ * struct amdgpu_wb - This struct is used for small GPU memory allocation.
+ *
+ * This struct is used to allocate a small amount of GPU memory that can be
+ * used to shadow certain states into the memory. This is especially useful for
+ * providing easy CPU access to some states without requiring register access
+ * (e.g., if some block is power gated, reading register may be problematic).
+ *
+ * Note: the term writeback was initially used because many of the amdgpu
+ * components had some level of writeback memory, and this struct initially
+ * described those components.
+ */
+
+struct amdgpu_bo;
+struct amdgpu_device;
+
+struct amdgpu_wb {
+
+	/**
+	 * @wb_obj:
+	 *
+	 * Buffer Object used for the writeback memory.
+	 */
+	struct amdgpu_bo	*wb_obj;
+
+	/**
+	 * @wb:
+	 *
+	 * Pointer to the first writeback slot. In terms of CPU address
+	 * this value can be accessed directly by using the offset as an index.
+	 * For the GPU address, it is necessary to use gpu_addr and the offset.
+	 */
+	uint32_t		*wb;
+
+	/**
+	 * @gpu_addr:
+	 *
+	 * Writeback base address in the GPU.
+	 */
+	uint64_t		gpu_addr;
+
+	/**
+	 * @num_wb:
+	 *
+	 * Number of writeback slots reserved for amdgpu.
+	 */
+	u32			num_wb;
+
+	/**
+	 * @used:
+	 *
+	 * Track the writeback slot already used.
+	 */
+	unsigned long		used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
+
+	/**
+	 * @lock:
+	 *
+	 * Protects read and write of the used field array.
+	 */
+	spinlock_t		lock;
+};
+
+int amdgpu_device_wb_get(struct amdgpu_device *adev, u32 *wb);
+void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb);
+#endif
-- 
2.54.0

