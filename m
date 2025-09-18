Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D52CAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA2910E5F7;
	Thu, 18 Sep 2025 01:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XGBqPJx9";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C7610E5F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAurAtrerLYDp3avLykAZjPS3f402NCs5Y7YsUuXA41WDmed1C5Q3SNSiUa0duPoYIReQt21ACASiN/6ZcPIBEADw1/8DdyUpj8Tj2zOsAZHYnUpoXbu42cr7xAtY0ELqzXyZRofezT6v73Ibjb0xJDucmK25gfx7XXL3rwRF5m9E74feGx4wq4SgIi/4mNo2c5gK6s4Z5F7jRGj6E8IgL2CPJ3ET4Pf8ds15aYn5wx4Eu0EhdkiEdkJ4CTgi1tiCUJCVFAfFv+yosxEMiJLa+ilPGfPZS0xR2AfALHzLknVxdTBrwFlEvVNvxz2PwM4bDM6xo0d0CJiyrSzPe+KxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7eXaIJX4puROELlvWcCU3rYXcuxX99RbpLVNdleoL4=;
 b=D7t/hvIaMVI4LRzw7x9SkT8i7ulJoijEqs5XhjuxwSJ5bTXFbuPM5K3sa8HOKBfXSpEn75rbLSG0XsIcQDQs0rnao3/7GPDWcf9M/Wzip8LXI5J8aKwQDHpqeewnPpoJsWazvDcH7oml4FOH3wKguB0B/HIopv6PHWmZe6jFgthPkHOAn1nHQ8GekGwUH987veXaTNXelGDfc5V85v4kaXIQ21Iyy9Z5A9EMyW9txDpdJ9lxzBq2Zuk0aHn0yr871UN5WLYQTstCnK86LwrKfNvEbVrmAxd+xhqh2JpATY+GP2edAZmv9uYwfPraiSPYYsDMWEjmLkE3qSCJCGL9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7eXaIJX4puROELlvWcCU3rYXcuxX99RbpLVNdleoL4=;
 b=XGBqPJx9bLds599mzE+pk/tZOdRigvdIXodGYhpP3zhab8B2t/0QjtsOf9fbTHTutLnw4RqFDHlfCT23HS+U3Mm5ahqC1+9TLYl5qOEyLrZbUDAL0MQKbO6dfhUB9J8+rPRCmltDJrAXFRaQqlOjPc7JNPUXpR6tEwHRsUHqELo=
Received: from MW4PR03CA0185.namprd03.prod.outlook.com (2603:10b6:303:b8::10)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:33:31 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::4b) by MW4PR03CA0185.outlook.office365.com
 (2603:10b6:303:b8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Thu,
 18 Sep 2025 01:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:30 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:28 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 12/21] drm/amd/ras: Add gfx common ras functions
Date: Thu, 18 Sep 2025 09:32:23 +0800
Message-ID: <20250918013232.2629215-12-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 787308e8-7057-45cc-438c-08ddf653600e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LJfaZTPiRK4F8IVAYvSrQA9x1iDsVAo/wojkEt5YILVlqeqWncPuJwky35pp?=
 =?us-ascii?Q?r8pD55WiFaBAoU3Sw/6/Bv6EtREuEHJtXdpra3uZAkQ+gSj0k+AYyGA4EtZg?=
 =?us-ascii?Q?qsF9nr5qrR4+xu5kr/zPfMSwNCWmvQ19NE1Qj5YqO11408r64tpMrp6VNf8T?=
 =?us-ascii?Q?FnFNOnrrWyKpIcQpS1E1Q/mHAKkLHs5v4xCPQmAKKET5HZvnRkc8wizO/eZN?=
 =?us-ascii?Q?4mCvPZVLdE7JPgLUHlL/hOysbmqdrb4Cm+X8ietH8Q7msff5nNZT6kTJrU7W?=
 =?us-ascii?Q?krS8fic7J4kmS0qr1kVYRU58v1pC8gtrWzImtduqsubJSB8bErkRHrRrX3n/?=
 =?us-ascii?Q?h0u5prkG3JHHx1Y1LWa8D4Bzb0yu7pVTpVd2D4qEV6/LaavC2DK15yCw7xt2?=
 =?us-ascii?Q?lfb1gsAzr7aVLN/jG8Qe+ju5r61HoizpitbgisUGaaEPTqfJX9eSOXdBONvg?=
 =?us-ascii?Q?Ru9n/lwPGF27TfIoKgeGUNEJfwmq9GKRixnwkUlqneEpQFfaI7ti9+Yh1H9E?=
 =?us-ascii?Q?cVxg5UDKwVZPVcFEyWKP83DibCrAFP1ccz7OcWwQLA3j5rx6y0vYCbdsfyyR?=
 =?us-ascii?Q?0ltYDzu4cyuYJ5DIvBc8HOmf/KuiBQ00LiChc+JUWZt7zixRED3AD49ocHtp?=
 =?us-ascii?Q?GjjF5Tz/jS95ffPyuMoMUU/BZ+XaaJtaazO8b/244BYFLpRJh1TVSZHiyANf?=
 =?us-ascii?Q?VDqpLpoiMTxAv/GrdmP+bgnFPeLZAc72GN4e2FXxnNng+wvYp+3cWWNyQhgo?=
 =?us-ascii?Q?Zvgs+lvqS3s2RvQMBJCqhOe+JkAj5iOyDFAzqD7si+aB41Wj3FDM5QyLV2V/?=
 =?us-ascii?Q?4KreC28GLmmp0jBJRNQ5xLf6+Xn5+byHMaLHg3wbatWBhZaO3tufd9H38j3d?=
 =?us-ascii?Q?5RhtOq+xx4qODmVdaPWamF07GDusInYoExfIHj9S2DnNAr0UMnQUlq8T20oa?=
 =?us-ascii?Q?L8Pwa1j8djLLYIlcOVDDdZ87pgHS8/RYbSuj+/PDpzXQGlXJl4BAU8lfZD5p?=
 =?us-ascii?Q?fvNSbQa1j883dLRYa9SheVZxIH4DphB4+qxmVVKJtcTkRb6ThQCo+NOuBcbD?=
 =?us-ascii?Q?d6wUuoFRnN74tB8Wl6FBPJaCgHNFy1h9f79AA2fZpKuyhoElr9b67B3FSxld?=
 =?us-ascii?Q?Kvf2ORD/PT5pd4DHeE9a3ZwPscm1tyfoyCY20i0h3VYmL/G/stMPG5qucUAg?=
 =?us-ascii?Q?4jFcH0arsy2CB8n02q2Tk8x7zXm5LtocGhKqxMZlgXoOSyv276sywSspcSLc?=
 =?us-ascii?Q?F9xBg07rQ6U8TkYMYZzosygIwXPLb7dxkft2iVg+dSXEC1OGoRUV/NWxcMx1?=
 =?us-ascii?Q?YI8VS7QZUqhFAUmVTWMyt3CX/VaMlKSkmHhgsOWlSl2fISPuNFzl4IYl/lqL?=
 =?us-ascii?Q?j8KcXfacTUbH7SnDStRWa75GVKfSYx8DdmXVhHV/H+GeXn4kK90MmGs1C060?=
 =?us-ascii?Q?FyUb698FoECBhYp/CsqMgGSNs1PjrnfYBaGLjiWrb/Rqp/k1fDeK31H+859a?=
 =?us-ascii?Q?jn7ogsN+EtE3sbKDsGtT0PpnKRdaGi8aksJQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:30.9405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 787308e8-7057-45cc-438c-08ddf653600e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
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

Add gfx common ras functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_gfx.c | 70 +++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_gfx.h | 43 ++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_gfx.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_gfx.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx.c b/drivers/gpu/drm/amd/ras/rascore/ras_gfx.c
new file mode 100644
index 000000000000..f5ce28777705
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_gfx.c
@@ -0,0 +1,70 @@
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
+#include "ras_gfx_v9_0.h"
+#include "ras_gfx.h"
+#include "ras_core_status.h"
+
+static const struct ras_gfx_ip_func *ras_gfx_get_ip_funcs(
+				struct ras_core_context *ras_core, uint32_t ip_version)
+{
+	switch (ip_version) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		return &gfx_ras_func_v9_0;
+	default:
+		RAS_DEV_ERR(ras_core->dev,
+			"GFX ip version(0x%x) is not supported!\n", ip_version);
+		break;
+	}
+
+	return NULL;
+}
+
+int ras_gfx_get_ta_subblock(struct ras_core_context *ras_core,
+		uint32_t error_type, uint32_t subblock, uint32_t *ta_subblock)
+{
+	struct ras_gfx *gfx = &ras_core->ras_gfx;
+
+	return gfx->ip_func->get_ta_subblock(ras_core,
+					error_type, subblock, ta_subblock);
+}
+
+int ras_gfx_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_gfx *gfx = &ras_core->ras_gfx;
+
+	gfx->gfx_ip_version = ras_core->config->gfx_ip_version;
+
+	gfx->ip_func = ras_gfx_get_ip_funcs(ras_core, gfx->gfx_ip_version);
+
+	return gfx->ip_func ? RAS_CORE_OK : -EINVAL;
+}
+
+int ras_gfx_hw_fini(struct ras_core_context *ras_core)
+{
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_gfx.h b/drivers/gpu/drm/amd/ras/rascore/ras_gfx.h
new file mode 100644
index 000000000000..8a42d69fb0ad
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_gfx.h
@@ -0,0 +1,43 @@
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
+#ifndef __RAS_GFX_H__
+#define __RAS_GFX_H__
+
+struct ras_gfx_ip_func {
+	int (*get_ta_subblock)(struct ras_core_context *ras_core,
+		uint32_t error_type, uint32_t subblock, uint32_t *ta_subblock);
+};
+
+struct ras_gfx {
+	uint32_t gfx_ip_version;
+	const struct ras_gfx_ip_func *ip_func;
+};
+
+int ras_gfx_hw_init(struct ras_core_context *ras_core);
+int ras_gfx_hw_fini(struct ras_core_context *ras_core);
+
+int ras_gfx_get_ta_subblock(struct ras_core_context *ras_core,
+		uint32_t error_type, uint32_t subblock, uint32_t *ta_subblock);
+
+#endif
-- 
2.34.1

