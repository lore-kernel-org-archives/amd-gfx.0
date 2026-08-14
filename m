Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47166C5DF6A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DDE310F6EE;
	Fri, 14 Aug 2026 21:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ifJ3x5g";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAFA510F6E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgMF7x7YZP2A2I4im7HagV0811S5VbwEagPxlITVQamNCNkQXcSv1XW8vS2A6SuP4JKny7hcLHMPO0Pi4ZMwxKWxCTcpuJ8sAXjkACcm08lVT7qHQb3GFoJJV1cMpdrKMCVgejcqOStwXZHieN+k4U146OunA1PnfdHYGt9nOk2ElG8z5w5gdBtbSbzFVQLPUChr3i5/2AXdVys0SCw4Cq0qQb1ZV8kqrW7wEr4Hw2K4WaI4s+ZRyJFNr/8hZHw0rKywLntoOSleBWd8hOSJ85IfDx9YZUxAW1ICoBOwKKhP2oTV+pNT5A6HHNINucgAuiS2DZ6n3uomhLTufAiUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E50tdX4nA3rX1BSwnZsk9BtVm6utxFU2Tm4z4TlIZo=;
 b=QQ+Ou0iPQDWBTj4SV3rYbffwdsjKM0t9Ov6eLJdjgsunE9Cwjl5MnRHP28BWTx8zudWMkyodWZ08+jrAfvoNlsIRdGqS/Nz9QW1wZmcK8tdC7gtKdodajc6t/ovU5JHAM81qmm9qRrVdZgR5i2ShCgujVL0zmoJ6tnO6GTg9YMdi4mqRIy7/O6lVbRfOFq3N0a8JH/yvRsgVpZAyIxz/CuraB7AU+tAqiKTlQV4ozqmsxlfnchHZDXrjou56ckKn3U5J2LIzRquynNW0ggNYKeVlI/MhpjoEGz3wObV4mzdSFtElZ4fQvcvRKfFefuGSbybsrw3d90xvBn31EvpIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E50tdX4nA3rX1BSwnZsk9BtVm6utxFU2Tm4z4TlIZo=;
 b=0ifJ3x5g+MQeu8oGDypWRiJ1hpN1qtJtEvSrSy17ZP+Nv/ODvJLJ210BmWDYdlKfIxvak+pemqMQ4SqN+vcgTPZOoQhOg7+ZfrNw2P0oZlkDQ4b5387ScMWBd0mbRX5KU7lwTkzqyT99aBp1ofqhEs8Kz0TKoLjskiKOBLtfZsQ=
Received: from CH2PR10CA0010.namprd10.prod.outlook.com (2603:10b6:610:4c::20)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:15 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::31) by CH2PR10CA0010.outlook.office365.com
 (2603:10b6:610:4c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 021/109] drm/amd/ras: Add ras_psp v15_0 for A + A
Date: Fri, 14 Aug 2026 17:01:18 -0400
Message-ID: <20260814210246.3067612-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SA1PR12MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 32254de7-effb-4e89-7afb-08defa4775a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|56012099006|3023799007|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 0hg/M4uLzj84qLHpsjxQJQZDIdl82U4Cd6400RkmkeWUI9F6WieY5YdQc1JPz/tPZ8VAptV2Dn6vHjCgzLUeeuZDEXK6ZotEMnyjnzYlH7QB0bmssx1WnFU9sYAbXDO7ddLiFENAXRFCcyJjufdHe9sbW86kqk4AmFztVXu7OVLmyFB3ii+Me2PfNRIuT6vaaBQxhgD6PNy3E7zbfeMSo7eQ11ZrtFPpI35q2/6ebtqddSj+a+sBJ3ugJApViFuCJqfwNYtgeV3fU7x2T2TYJRVSM2I2syYc9eG/tQhwxQ5+Rh5/ity8/DcR3G4jOyqswTxLmR3y3ZNuvzlPff4ZBInGX1hTdLS3QmaNIxq3RPZuoGgQbYBLS9KF4P9JojSK3NEKQMbTkKPson4vJ1c514Lr3jkv0xIhXrzqvBkZjnePzMyXdhyN3DMzgDYu8mjJF0P3aObOaHpVpdERn4+D9lYP+SkBPdIeiq2B9VH5VHAZFMcmJQbpheBuup7QyoBiFNyEd9+qXvGSHkch1/XUcrZrILqdlLnw5p5EnppVyyFUmda+pSAF3+snyARhehTf/g0u3VGsAaaP5Z5QR2OXqNwg4gef+BjYwYrpUelo/UMIMC8dxUVtq8DjT4mOApqR15rTTL2KkakxjqB3tOZ4yD4OjTxNxAFxQ1lyYhNl0Nk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(6133799003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rr2nitQRkC7zuGx5sdkCLDgcubrEUVsqhbHw1uJ0CjUkriK7M99h/akb8NGDv48jWXEnOS6sODs34ciqCBdJlSxbXPvY5J8ZNLImQpucjJT2U5z1fsxJ21EgFK74EkvTRdKjg9H/Rp6pg67Ui3Xx/bTBTzDWLjgvjW88eQ9bOl1Nw2zdkgv8pVVmWwsoBQLQYi4nodhHErE7B96x6fV7i9ZqvOCpm7ObSyuv+dGf7+Tmqs+NY+gS+FybLW7vL7XW+6hTmJVc1eINFFnCj/Wf8BlgvpFbg2JsUN91gHc9U0BelAz9LWL22bQTarh+Zzs9KCwENltJCDew2WFX6MhdeuZeO6COti7kJGwUgEhL4fqmHOrUm9LUUF0VzsFA32bT9Zm78N/l1wlHGBtmsPdHjYbeoxjSoRURPyNDU0tVJxZOncbKYc5Swd4hVDsU5EIH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:15.6172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32254de7-effb-4e89-7afb-08defa4775a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add ras_psp v15_0 for A + A.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/Makefile        |  1 +
 drivers/gpu/drm/amd/ras/core/ras_psp.c       |  3 ++
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c | 46 ++++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.h | 31 +++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.h

diff --git a/drivers/gpu/drm/amd/ras/core/Makefile b/drivers/gpu/drm/amd/ras/core/Makefile
index 81f148c76d8d3..2dfb1f96b072f 100644
--- a/drivers/gpu/drm/amd/ras/core/Makefile
+++ b/drivers/gpu/drm/amd/ras/core/Makefile
@@ -38,6 +38,7 @@ RAS_CORE_FILES = core.o \
 			ras_cper.o \
 			ras_psp.o \
 			ras_psp_v13_0.o \
+			ras_psp_v15_0.o \
 			eeprom_fw.o \
 			ras_mce.o
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp.c b/drivers/gpu/drm/amd/ras/core/ras_psp.c
index 9bf20201649f9..0f4ced7ddfbec 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_psp.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp.c
@@ -25,6 +25,7 @@
 #include "ta_if.h"
 #include "ras_psp.h"
 #include "ras_psp_v13_0.h"
+#include "ras_psp_v15_0.h"
 
 /* position of instance value in sub_block_index of
  * ta_ras_trigger_error_input, the sub block uses lower 12 bits
@@ -40,6 +41,8 @@ static const struct ras_psp_ip_func *ras_psp_get_ip_funcs(
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
 		return &ras_psp_v13_0;
+	case IP_VERSION(15, 0, 8):
+		return &ras_psp_v15_0;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"psp ip version(0x%x) is not supported!\n", ip_version);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
new file mode 100644
index 0000000000000..4f4b323c7032b
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: MIT
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
+#include "ras.h"
+#include "ras_psp_v15_0.h"
+
+#define regMPASP_SMN_C2PMSG_67                           0x0083
+#define regMPASP_SMN_C2PMSG_67_BASE_IDX                  1
+
+static uint32_t ras_psp_v15_0_ring_wptr_get(struct ras_core_context *ras_core)
+{
+	return RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0, regMPASP_SMN_C2PMSG_67);
+}
+
+static int ras_psp_v15_0_ring_wptr_set(struct ras_core_context *ras_core, uint32_t value)
+{
+	RAS_DEV_WREG32_SOC15(ras_core->dev, MP0, 0, regMPASP_SMN_C2PMSG_67, value);
+
+	return 0;
+}
+
+const struct ras_psp_ip_func ras_psp_v15_0 = {
+	.psp_ras_ring_wptr_get = ras_psp_v15_0_ring_wptr_get,
+	.psp_ras_ring_wptr_set = ras_psp_v15_0_ring_wptr_set,
+};
diff --git a/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.h b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.h
new file mode 100644
index 0000000000000..4149fda38a374
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/core/ras_psp_v15_0.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: MIT */
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
+#ifndef __RAS_PSP_V15_0_H__
+#define __RAS_PSP_V15_0_H__
+#include "ras_psp.h"
+
+extern const struct ras_psp_ip_func ras_psp_v15_0;
+
+#endif
-- 
2.55.0

