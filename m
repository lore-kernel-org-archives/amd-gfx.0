Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E59BCD8CA4
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2026 19:48:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BD010F94F;
	Mon,  8 Jun 2026 19:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2QT3pnye";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB3A10F94D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 19:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFHE8F5AQryD9Lap3trhzm4Q/OjY0nTRzx9ksLat9G+BWxZbW4jWxSjZyFwSgO017y+n4K3vkWJJx221nLcLE+LALrLj610CuQGF0F3PqmCgCI8JtIOX/Brue25MXH7Qu8fwTGqbqnZBeOEn8d026mko2AGQaVX7zHFbY98SGxtzfAE8w1xve5InkyanEFzXRa/qMBcuz1RaBtBDrN4k44KvMgJjFeOgRPi0UPWS2sFdLCxrahhRztEq4nlLFwYUVawH9J+xADUT0pZLI3362GdMSVaeCHw3vjkJr7toRp4OwX6zvbPTOOxNXnHJ5+ln4A6p9O2pNYRKHBRl18bXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBzsBEipSuzlEp4q6Bb6oHy/hJFDyUeUkahchiyST2s=;
 b=K8oI4sZTRUv+Rp3CkltPPrGE5+Owsa487hkIpsWjNKspwnkqdvPBUY3rjKmW41XljtRuNJWVIsvkVtDbfo81UEx0swG0jhmocJ5fV19eWI4Ex9BgyCFgkFywnvPgepz0dDZ3+huk5BDrU+NXYdsKy8J7rJuVMe1R6T29No25MJjHQ1ViJi1JPDTPA+k7wFKxZ20P6nExTrnimOJ2jj9UPfTieDYS56VFGlXjzrdh/s8PangM8+0VB173c80U1fiahpdYCQ/NexNinXLfeWU/4vcvM5EpqV8/fElmKMFMvZPpsq+Nge0Nxb9toqAyNAhmwzG1qaVBnpsO9NUwNCtkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBzsBEipSuzlEp4q6Bb6oHy/hJFDyUeUkahchiyST2s=;
 b=2QT3pnyeG72Nw/2JIcGqIT9ZlF7lojwqiPFsigx1B5XMDi33w9zVft4sNlHuQNifx0P719qVl1bZtt+IJ72XX2XNk0GWnNXUs/yUH1e0WqGIDo8mvOI/LNkQQadFK4e2eB4eC8lSzmGcYgF2uXFoGGHUgMX9V940+XD8F37daxs=
Received: from PH8PR05CA0012.namprd05.prod.outlook.com (2603:10b6:510:2cc::11)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 8 Jun 2026
 19:48:02 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:2cc:cafe::af) by PH8PR05CA0012.outlook.office365.com
 (2603:10b6:510:2cc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.8 via Frontend Transport; Mon, 8
 Jun 2026 19:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 19:48:01 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 14:48:00 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alexander Deucher <alexander.deucher@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Shahyan Soltani <shahyan.soltani@amd.com>
Subject: [PATCH v2 01/11] drm/amdgpu: move struct amdgpu_sa from amdgpu.h into
 its own header file
Date: Mon, 8 Jun 2026 15:47:31 -0400
Message-ID: <20260608194741.1590055-2-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608194741.1590055-1-shahyan.soltani@amd.com>
References: <20260608194741.1590055-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 494e1f44-735b-4bfd-b124-08dec596d974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|22082099003|18002099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: tSG2VwMbPwBjvDTRb8j5qx8a+Ig3JUiWgoFrWmc59GXU+bRNM00b9+SkvZ6M6TxJpLDAH+qqUO0jNnSCT23/18lSlTHKQp6q3wjKBf5P1GK0/+/uHj6KyVdvai+bHGfRmlNqP0k5LXUWpuz+6XiTlcMvP4TWUOBuJpRAOYer60ExhLZ5TD0irt8vUHAIKv88XStenVonzvACjhBtCtytF4TbJGIvI0bw6x8UB3CUGDgDeMBrNBJbVd+VknUPntP3LBYJyjUwB1Zy7Nwkeuy8CnZfT5b0/4SbxRUHOoKt7yO7m06q5ESzKB8VER1hYVdXBTvRQmBX8AxD0feqfPcNNo3qcmjbKIwzzNY79+7Yroh9zI2fD2d+oAHgO7tawB9/Yr1rvycM6Iji1Lc9pwkqpHAPvuU/54VA4awMC6LhSdzAtDhheCNJQcX9+z+JNb2WOms7qTqcdspR/Z3CGz1hybGsJnlyYAkzh6YHQNO2xgj/8AwaqHwYA09qoJqFIguenR1s7gBH8IGJgUco3xP0f2JvygHKRKs8r4VQdyCcOOja+hrxZiNTi1c+YVbPEdMTE+Wdt3vhIZh7Y/K7GypI+iC5ganZpU6IuDZNjZEhDj2NFpgigE6hdiScsgKJJtEgt0MTD2R/7/ea9nbt7VrXQ86N2qASlOabYbUkZulMu+6afN0VPm/V7nXPu/Y4NkRvCbH2jWHMV1TRSFJQE9PUAlDwwxtKh/08kwYPA2Gpl00=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zwwrJlk2wPv+sc+dFfzs16LB1YwGgwkzZHjVf2pyz7DCGRPAL06IXIUtsV+ru1cGV+Aa/SDHpKCSC39AsTV3bCr1bGSonh+ReiKZacDD53xoU63tVdqn7PZ+uRmMgyW2sJpd+r+KHT/hkrpT/uwSFNzBUaOeilAFJ6Vc9CdQVefHLyvh2zeN2PqjfDdTgAxhOpTVRHlUnuj8YZO4SFW12AwTIppvguyBeyMwJfur+4piUojZ4AmiftUOtO+zwv7nNaNNDIOXE8cA1ue6qQlnxARTgOUG896pKPuAL4EyaNlA8L6Wdb6/+PESswLWNd6/pdn/RYcAq1ZoUynHQ2om6D+uf01c5cNzE7JhITCJL7twgJF9wMzx06xIMicrg6EVB318mk0lDsMJuEKgphVCA86ZfD0j4kcWMZzpkqMDiOrwMYSCelvf0WncUqV4vSz6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 19:48:01.6551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 494e1f44-735b-4bfd-b124-08dec596d974
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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

