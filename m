Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D836C98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 13:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F98410ECDA;
	Tue, 22 Sep 2026 13:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EaN0MdzV";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DDC10ECD9
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 13:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+hdjSqPMYc0qbXs5qIOySizbYIRfguih9Lo/hi8QD5EKi0YYYdtTqWZZDRq0MTEahaDaPwENLk+0+3j9GK+lghb56IUr5cZONeJl6PKHk8LDrKqV+nO1n+VNYODyJlZvBP04brh5+wPBjDFoUnf27voCK/yy5c6J6Vgtb/DoyvRC5ksPwjMIkGc4EX/E0tpYMCPfmbietYbG6JhMeKI6KlQJI+NuOY8Xoh3vbDyVMLB4MMDQwKIoh9ksKuJoG5ZbRF4eKXzevHcQ0sjtiujwaWOwKma4fUBDFkqZ6bDNX7qVZ2X7wRc6XN1lZlhZqobsvJwnjCvRqrODdqx9zv22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTw//6/gcJfnHpfO+b4WTP5E5epE6uzze7oBuIbiZ38=;
 b=ijvGo6/tN/CBalsQ8Hnt/q1vrfChYS5lZqJeW7a9YDS0wJ9xXax7xc05ToA30KwI673ppLzNoYhqG1m1o2g5aJpSVnU59OKc//XB8pB2RarBmbFTlf8A4e/HmwGGcEy4enG65YGdsjSj0bWhG/ELZ5lOXQzu2W4fvDS1fTA3PW20CkKZWh7b/hQM+5l7z41voCyovn5/fpEvB7duLtkKUXJ1CCUQtZsQ17+tr6Lu5ooQpEJc02UqSBLvX/iQhhi7h1VWGCASEqy7azG8/VSH4lgLJtsntqMB3+Jrbfgg8cIolufFliYQugbj3rh1kNFcZdcHpCA18NCm/w4cMpnUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTw//6/gcJfnHpfO+b4WTP5E5epE6uzze7oBuIbiZ38=;
 b=EaN0MdzV83Zh4kekZr0CUQV7da1yl0FmgmLIKpkanxR/GE3y2B1ticKjn0y/UDWbI1hfk3OlNXhKEau9Xn3+rj3Dc2SM/iVFuU7HZP9jwW2nkGgIHDaeW6fBYuQViR+zojNHd770Xcu3zUQ1A65n5WSgvk/gwv8uNUtsAQJsJOE=
Received: from CH2PR17CA0020.namprd17.prod.outlook.com (2603:10b6:610:53::30)
 by LV2PR12MB290147.namprd12.prod.outlook.com (2603:10b6:408:3a8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 13:44:21 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::1e) by CH2PR17CA0020.outlook.office365.com
 (2603:10b6:610:53::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Tue,
 22 Sep 2026 13:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 13:44:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:44:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 08:44:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Frank Min <Frank.Min@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add smuio v15_0_3 support
Date: Tue, 22 Sep 2026 09:44:00 -0400
Message-ID: <20260922134400.2145341-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922134400.2145341-1-alexander.deucher@amd.com>
References: <20260922134400.2145341-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|LV2PR12MB290147:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a891b2-4fbe-4aab-d23d-08df18af9b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|3023799007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /R8D3L7fPjRYUPVnxt0OTl9DmUcCpcoPoF6g/quMGGWBPL+t2cRp47/la8baujyqcJDv37lwVc+xoqF9d+bCHJu0vgg+VFZccwPEvv/UsGhSnhWJ9yT0pULEXQSCtl94ZTYnGzVxKIKnlINxN8+XjiTv8rtikPT9KivPfsAA4Yh6vlOyHv0oACARIQZzioayruKcOkWvj5sh7BEAJf4nlGe1FlODkx0fVOa0p8RJfpnKcjE1QemBIQibBC4YQM3bDqTATk/QojKCnndrY8vK3cNma5FinWMWNIJUftzg5p/qedQZZnnmkIsFZaHrUzJlWSCo3fSo0T1H3668vwdmMIUIRoUsfmZGlt67ozXMDSIjzRC2dDIKE/JO+Qwdf7okh+gCp70cIjl6+GLWOUP9/oI+WG+Vo0N9S2EZWH4TnTjEemco5KNfw3l6n137d9b2epnGm+HfYt3Ahn8iVJxphTj/Hr85FDWoxgL05xEh1N7Rtqbfa5ja63ceM5PZBdz5uL2AU5kxu5wajCdUtXjnRBvqjbzP6/VdZ6xCh5Li6k6gvo9GuKgHxiy7IwD6g9TJ9W/3mQ90AecZBzke5ydvk6wS27gmJnPBJK/0JeVGbZIhch/tRnnI93KMBZYhAMfzPPRNOrb6atFu+KxTEshrf3GeuV4wNuUSkdwqlCbTSam2uo7e0R4SIN3rVM1syi9EYcyWBByKSlELfbJv9EIxBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(3023799007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oQ4qFkNkc1C+/UaNYE9BABl5tdJDHNmlphRkUZp9q9EprAE7m4gPL7vn5EMCliGSiw/R48N1L1WLPPNeG5rTRqeTdLQOrKfsQLygNwgPO2Iqr/I4IOQzyG227ST7njRZaFloApcgx1vySl09IWG3c9Ymh22UT5WpfmYupsaaL7TF3lB8FE9bH0sUHuDVnAc8XsQe4/I/EE9ee+J1coNsHxYySZzCrjsX4/1pf4qLF3gXcX43OeV47hlFZN8pZFeS/BaWJeM59pL7lg9AmbM0b6SAB9YbANO5Zvq8Q7kLFipW/UXvPDiQ1q8+pEZHQUZIQauTOQy0/+t8LRsSy0+ETe7KJx2ZbALtv3rIDV/p3sFRt/sRoEqZ4rmcCAlcJ+XFHG65zDK0s/sRJFeHyL0f0eLortjLsQ4tHFRobOl4o4ETWdzeJPm3742CJryx9s4U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:44:20.8605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a891b2-4fbe-4aab-d23d-08df18af9b04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB290147
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add initial implementation for the new generation of smuio

v2: squash in clock counter changes

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 +
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.c    | 84 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.h    | 30 +++++++
 4 files changed, 119 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 27ab027271fa1..a8a1f65b46156 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -264,6 +264,7 @@ amdgpu-y += \
 	smuio_v13_0_6.o \
 	smuio_v14_0_2.o \
 	smuio_v15_0_0.o \
+	smuio_v15_0_3.o \
 	smuio_v15_0_8.o
 
 # add reset block
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 59294028f0690..a2c1960a8ad84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -115,6 +115,7 @@
 #include "smuio_v13_0_6.h"
 #include "smuio_v14_0_2.h"
 #include "smuio_v15_0_0.h"
+#include "smuio_v15_0_3.h"
 #include "smuio_v15_0_8.h"
 #include "vcn_v5_0_0.h"
 #include "vcn_v5_0_1.h"
@@ -3950,6 +3951,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(15, 0, 5):
 		adev->smuio.funcs = &smuio_v15_0_0_funcs;
 		break;
+	case IP_VERSION(15, 0, 3):
+		adev->smuio.funcs = &smuio_v15_0_3_funcs;
+		break;
 	case IP_VERSION(15, 0, 8):
 		adev->smuio.funcs = &smuio_v15_0_8_funcs;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.c b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.c
new file mode 100644
index 0000000000000..7bc41526128cb
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.c
@@ -0,0 +1,84 @@
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
+#include "smuio_v15_0_3.h"
+#include "soc15_common.h"
+#include "smuio/smuio_15_0_3_offset.h"
+#include "smuio/smuio_15_0_3_sh_mask.h"
+#include <linux/preempt.h>
+
+static u64 smuio_v15_0_3_get_gpu_clock_counter(struct amdgpu_device *adev)
+{
+	u32 clock_counter_lo, clock_counter_hi, clock_counter_hi_check;
+
+	preempt_disable();
+	do {
+		clock_counter_hi = RREG32_SOC15(SMUIO, 0, regCCD_GOLDEN_TSC_COUNT_UPPER);
+		clock_counter_lo = RREG32_SOC15(SMUIO, 0, regCCD_GOLDEN_TSC_COUNT_LOWER);
+		/* Retry if the counter rolled over while polling the registers. */
+		clock_counter_hi_check = RREG32_SOC15(SMUIO, 0, regCCD_GOLDEN_TSC_COUNT_UPPER);
+	} while (clock_counter_hi != clock_counter_hi_check);
+	preempt_enable();
+
+	return clock_counter_lo | ((u64)clock_counter_hi << 32ULL);
+}
+
+/**
+ * smuio_v15_0_3_get_die_id - query die id from FCH.
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns die id
+ */
+static u32 smuio_v15_0_3_get_die_id(struct amdgpu_device *adev)
+{
+	u32 data, die_id;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	die_id = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, DIE_ID);
+
+	return die_id;
+}
+
+/**
+ * smuio_v15_0_3_get_socket_id - query socket id from FCH
+ *
+ * @adev: amdgpu device pointer
+ *
+ * Returns socket id
+ */
+static u32 smuio_v15_0_3_get_socket_id(struct amdgpu_device *adev)
+{
+	u32 data, socket_id;
+
+	data = RREG32_SOC15(SMUIO, 0, regSMUIO_MCM_CONFIG);
+	socket_id = REG_GET_FIELD(data, SMUIO_MCM_CONFIG, SOCKET_ID);
+
+	return socket_id;
+}
+
+const struct amdgpu_smuio_funcs smuio_v15_0_3_funcs = {
+	.get_gpu_clock_counter = smuio_v15_0_3_get_gpu_clock_counter,
+	.get_die_id = smuio_v15_0_3_get_die_id,
+	.get_socket_id = smuio_v15_0_3_get_socket_id,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.h b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.h
new file mode 100644
index 0000000000000..dfbcd9d7f9277
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v15_0_3.h
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
+#ifndef __SMUIO_V15_0_3_H__
+#define __SMUIO_V15_0_3_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_smuio_funcs smuio_v15_0_3_funcs;
+
+#endif /* __SMUIO_V15_0_3_H__ */
-- 
2.55.0

