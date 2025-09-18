Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335A9CAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA74710E5FC;
	Thu, 18 Sep 2025 01:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pOq5IfyH";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38EE10E5FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f72VDbYRoVZ/auMIEOGBy/nVq2eXpW93OT8LLPiNdOpeSFq5CMpTV05jg5dcsjLWU2ByWaNNt+6qLdbm1QLmmPsp0ZjmEOvdGh2VWOPiTqmbyir+oeiqA+aWEMDsldiih0ejCQiTIx8/W04r5VhdUlLlcpRuIwN5/SiSfhTjKT0fOyU5UVNKFKdxhiubL9BMsasaPMQwKhe00O0n07lnD23FS07dfgohOfdiTy2LQw3U7kSKv+bP3UBVMtYms/bmVm14rTALUQFKO9euW4X4eBrjf+AXY5hQjpZPg1wDEGOi091ZXE1DUzezfnhR62R/URqgq8cuLxfGBqOHhaSQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBiuFqWvt2NiDPYexSXaBwIcD4AtE/H/J3e5KkNpMkU=;
 b=wKY3w+HFlltJFbNZ6YTV339+5iAhXLhOptcJWHuW7sRQ+Fuc+SoQg1+FqgutaFcTOvx+kUVO2+HEq8JWZdSh01z3UsrfBcl0IsP3m5FFgfuDp20AC/8riqJmiUxfcCG8zDm62lDHV155LZulbWnGACPbAil1qlwr5YRDjc2T9rNr94w3t2KZbNY3ZvDopwOs5I0q5J5dX7o/f6zdBdQwf8kVDTrkQG7XcXPfiSOcUBhGRAkvqDA+JqTIw7NZFzulUOIFzOiDla7RbH1zhFmNbMisqFxdSIFnMyoF0RCL5yZ5b1DDtwsMU5WywQZNHVxMqvqeuY8EQcQPpOiOGUwSxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBiuFqWvt2NiDPYexSXaBwIcD4AtE/H/J3e5KkNpMkU=;
 b=pOq5IfyHNj/jh8udR8fGgWw6PcjCd+ZDGI3/hYeAtFoSuAAkoxoXp9r4nNiKARjo48h2zPCfuEFS0OQFJdYmXNTYVByjBNwNEtdeuReFzNiCE/YiIzSCtnZ9+GVJXyGynjAU38dS4nRQmolLL3uVDvLWAkEMkeUCOyq4XkSUbhs=
Received: from MW4PR03CA0203.namprd03.prod.outlook.com (2603:10b6:303:b8::28)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:33:35 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::e7) by MW4PR03CA0203.outlook.office365.com
 (2603:10b6:303:b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 01:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:35 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:33 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 14/21] drm/amd/ras: Add psp v13_0 ras functions
Date: Thu, 18 Sep 2025 09:32:25 +0800
Message-ID: <20250918013232.2629215-14-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
References: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5d51ef-1b88-42d4-f86c-08ddf653629d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MTpJg9ukQ/qPQHyw+p16XQWj++6Ymb6KwgCOLJH7NrhtsCaO5eBvd69KN/C2?=
 =?us-ascii?Q?gqUtg/Alh+eyv/QFAYIYFd00sjoGHnMeBU5/q5fmIB4aWRti0DUxIT5gg+dU?=
 =?us-ascii?Q?j3DcB6MsNU+ac/B4bGo1ZsvUxPCp4mfSdOIvGHfypmhABf4mKexqiI35yIQL?=
 =?us-ascii?Q?sY2kQX4HLyPTx0b6mwATViDxJpUsmvOL4w+IQ9BjVwjqJE3LQTcdr+nfOjcy?=
 =?us-ascii?Q?LSJCRyNBvEZSqZ8jxzZojmzjmUU3NsML63f7kt2tEUsqCy2qmgzLppe/GkZj?=
 =?us-ascii?Q?Ooi7qR8iT62Ewc+mXsiy545OLMuV8uQ8V8x7EUoroAQWTBwQdg+GrtiuYTEd?=
 =?us-ascii?Q?hmZU2zWMMoE7Vy51oEG/uvA+uZqvbAEbMST3ANO+To1cNL1K6zGZusPmMohs?=
 =?us-ascii?Q?uDDwtGjDTcyDPWRqEbIAab8CDhxuJ+Ri37wd43GHEWixkv/4AZdkrbNXppyA?=
 =?us-ascii?Q?sLOcSAIokNtEC3nENQWTO7lKAArxKd0T8+sviSv9YLfRfSrYqMPyX3PrN/mu?=
 =?us-ascii?Q?8EWqcP6fNt/vUZy+Kecnj6fQL6+X7xff3X7Ga5KG/N+mBQ/HsRhBOT01f3cd?=
 =?us-ascii?Q?Ogz+cJd0hH/6KJMdsMcDWDm5E3ONv8rR+O12Ms11WynyHiveaKqTHnYPdj9V?=
 =?us-ascii?Q?Ty9iPPJh9dDyiiHnCxshkPWeflsEl/xh58Dm58eT8ixXHQ0umxhQlVrRQSAd?=
 =?us-ascii?Q?mIngwar/HQUD/7TbBYyrWcIs726AWCL9hmyhQrCk9PuEKRZaPLWAnxGMILF2?=
 =?us-ascii?Q?+nghGFXmN3Hu8sERVfWrQ1Wzq9N4MHfEmGQWvMSlqnKDDwljF64NLyf5reqK?=
 =?us-ascii?Q?F2bNgAGe4SqHjSTlWGp9d4XOFtu19Nah99GQfVI3Ww77jVD61YvMuBcBfEmz?=
 =?us-ascii?Q?R40wCnEisj+3eant/efeJ2BhxrN5abPF43Qhd4RNnPu4gnuGlN9rmmMI07E+?=
 =?us-ascii?Q?HWLpExr6ng5OBv38Zu2DuXtghZRmWDLhox4JopXBXTdO2c5rO3n4CgdAGatW?=
 =?us-ascii?Q?yBXONsULBnAr6ThieROHrhJJKi4hfp/3p79EJ4Z2Sxd1Zp+c/RuybdtIwbmI?=
 =?us-ascii?Q?6SowMgrJ6Ptl1O7aV8t5DEU/19C3ba7LaT6wNzXHY6TZVvuVDNSriASctvvR?=
 =?us-ascii?Q?wIbz+9vQItNLv/5djjau7qm6W5+YOb0z1MCp9CuD2rGuIquMxInZFW0s0fLo?=
 =?us-ascii?Q?uoxmEZDp2uL/gqPEhCG9M+fa09aHJRAt4VP4P7/C07NDgif4Z/1spVtuayrz?=
 =?us-ascii?Q?FJ3RTOc+ms7dAHTGzYMv2a8CMldvVLTVP1nLBZsQkxJp9Snq/fmwSvzLBS3u?=
 =?us-ascii?Q?JB38kcbnnrTMdmskguL3XcpG5SIymFzIZY/8yBd4VfxvtMlZOwuk9VvI+CGQ?=
 =?us-ascii?Q?zDPgkh9P3d0fQgxUD6ra1f4q/QMBfNPt2OKZITBRe7CTRfOVAikZFbR5ufrH?=
 =?us-ascii?Q?R/V1Fp6MD/ZJyAkkRijzmE+M78e+eOVBC6tXgbXQXBf2gusorcqqFyRVFpBe?=
 =?us-ascii?Q?Q5ruRwt6XJVNYqQWN4uyTFD8VzQsDhTb55IP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:35.2374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5d51ef-1b88-42d4-f86c-08ddf653629d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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

Add psp v13_0 ras functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_psp_v13_0.c   | 46 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_psp_v13_0.h   | 31 +++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.c
new file mode 100644
index 000000000000..626cf39b75ac
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: MIT
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
+
+#include "ras.h"
+#include "ras_psp_v13_0.h"
+
+#define regMP0_SMN_C2PMSG_67                           0x0083
+#define regMP0_SMN_C2PMSG_67_BASE_IDX                  0
+
+static uint32_t ras_psp_v13_0_ring_wptr_get(struct ras_core_context *ras_core)
+{
+	return RAS_DEV_RREG32_SOC15(ras_core->dev, MP0, 0, regMP0_SMN_C2PMSG_67);
+}
+
+static int ras_psp_v13_0_ring_wptr_set(struct ras_core_context *ras_core, uint32_t value)
+{
+	RAS_DEV_WREG32_SOC15(ras_core->dev, MP0, 0, regMP0_SMN_C2PMSG_67, value);
+
+	return 0;
+}
+
+const struct ras_psp_ip_func ras_psp_v13_0 = {
+	.psp_ras_ring_wptr_get = ras_psp_v13_0_ring_wptr_get,
+	.psp_ras_ring_wptr_set = ras_psp_v13_0_ring_wptr_set,
+};
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.h b/drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.h
new file mode 100644
index 000000000000..b705ffe38a12
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp_v13_0.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: MIT */
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
+
+#ifndef __RAS_PSP_V13_0_H__
+#define __RAS_PSP_V13_0_H__
+#include "ras_psp.h"
+
+extern const struct ras_psp_ip_func ras_psp_v13_0;
+
+#endif
-- 
2.34.1

