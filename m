Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A84FCAC5AA
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10FC10E37B;
	Mon, 22 Sep 2025 02:39:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IYX/1yBx";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4AD410E37C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:39:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkobsH+KwYc8htWfKeCDIsWzvL772MszktkavuxMC6gYOGJzqRu3sGFDZLkORYBOkPuTeQzB9XbfSISe90M9IRXNtpGL6x6ftJyEiiiwvq4pYgRhhR3Kk5FKeh1FuxVxNjO/nwEESM9f4T7lMbyNUtT7Y+Mk348r6fxF3n9ThTo+oCFVUvswYEzMySZ//UkSgk9NbXLobpizmcXPy4+qtzTfXFA3IKhTqqpS5hczBkair+IecPTwG8yQd2RL5bm6X6xhPkW6llkwXltHaugGj/jw+eubLJaBi74EPuh8GMBA+2OHyJ4aRAxQmnW9jr374jPCalSOipTUwiqQOOGDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAiQB+YQ3bwMmMRk70I1IO/Ye7GpzKGXN239V/y7TJA=;
 b=tOlNLYHXEwTJgkzv3UTnhBNtzNP4vH15dUkmsDX6a41ouUFgCSN1Du2o3wqasIWRLXcQNPlUQNm/Hj39ywH/BC1lfW8ZIbaGurSWef9KVgveVjYN/gT3auF22KLDNvsyP0A3s0+lhPjSHErdwLvx4fmasB9QMj04pWwE3jBknVYFMnjX5HBGJvRyi230hB8OW3n3S2ydfeU7YyK1FycCU8TvKuvYbEAZuqGVY5g6c68ee+uaNCEJu7q0e8gJ39CL7y38qQZ8M1zqAXqNc67WPbnDW19hj0SPvjS1oKwV29I6hxxbqswiG0XZ3sou7X6uUnde5hOPvXoYHuO5bAMRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAiQB+YQ3bwMmMRk70I1IO/Ye7GpzKGXN239V/y7TJA=;
 b=IYX/1yBxJK8TaWuF7+AoBwo+DtewVlu6s6++VFg2RiYuZt0uxFwMccYi+Z7zNS06a/3f4U99vXdUmCiN2gO3paiFZPTKaSmjt+Adq+sq2WVSZ3p5dGYoPE/fLweBqAqv5NvSdiNuMzVe0qOaahjHI5nDB/5WInQ5C9Y+K3p92JM=
Received: from BYAPR08CA0006.namprd08.prod.outlook.com (2603:10b6:a03:100::19)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Mon, 22 Sep
 2025 02:39:32 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:100:cafe::28) by BYAPR08CA0006.outlook.office365.com
 (2603:10b6:a03:100::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 02:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:31 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:29 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 05/20] drm/amd/ras: Add mp1 common ras functions
Date: Mon, 22 Sep 2025 10:38:29 +0800
Message-ID: <20250922023844.3108065-5-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
References: <20250922023844.3108065-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 841bd94f-3513-46f5-3921-08ddf9814295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IH1iu+jPSyHrqy1zQteRvmCzH80HulqIIA5VPfWI+76MjKPXR1HlKLKP30b+?=
 =?us-ascii?Q?JfSa+rMzhmV6dOabeBSsFY6vi8jcv0VdmJPgb50EA2AoqLZ7kXk28oCTKLDv?=
 =?us-ascii?Q?mBxVjwTCcxdgrwiKkESJPdLQ32M5Pg0brkN+6Dtzolb9Rpf+mfcbSQuzeb5r?=
 =?us-ascii?Q?JQ6zOitcrWId99wWapS69f5LOPBW6vVwYOIG9srsjR2UbZq8ND0BMy4ulEFS?=
 =?us-ascii?Q?gtnAZ+DWPO6uNdeiHppcBNSojXml5WF3teTUiSvr/GKduozxhgONit585DvX?=
 =?us-ascii?Q?h2WDNr1lxefk/ODBELRn5dhhNFGodhyCCpqr+bqscO6SbWQFBwRZe+pFiHlC?=
 =?us-ascii?Q?Gj1PrQQPCz1yh1DRXi1B/uFhmGoXvuK3i4zi8Zl4ExpSDJXtUXmAScrxhaL2?=
 =?us-ascii?Q?PhqTCIDhuHzPmwRdNk3ta69326HEl095yWZ7WHlGdmTS4K7EoOwjJ1kU/vZ0?=
 =?us-ascii?Q?i6+UQFE5wwLBminbhdNEmf3alE1rdi86rs4z+QIH3SHz7b+AgV9+a1S5qm5z?=
 =?us-ascii?Q?ia9SAddZZIUH9//l1/3711pQ0lvm4xkNhajAGWQGh0cN//I8AnRHrpacDx3P?=
 =?us-ascii?Q?Y57k6hycIuZBzJRteHC5rb9N5nF6nryuQOqJU56gzsqW3yDJU0HW8T4pb/DV?=
 =?us-ascii?Q?22Bx0Rxg63nvtJQA9svX7NkmrASd10vtmssXipKw2/6FVK0D//yMUkcjhcPF?=
 =?us-ascii?Q?JFtjgY1JcfUPnGEu+IVVSa7BQAaVkRPVFfTqeCAyNsaaFRLDwPwCqF4O94Je?=
 =?us-ascii?Q?JPDGD98OR0fIGrrJMeJQ1+RQyatzKF+vQaY3cDOxnGg/+MHZ/671eGNQsysX?=
 =?us-ascii?Q?+BMvN7xyPQ6A12Jk0GYtwB2gQ8h+YZUkG3/MiLi+JLLDK3w2bAujzbpGPrrQ?=
 =?us-ascii?Q?oBPPWTDX/a84c7IBa6fNGSBKvuoksz3an8kxq5ycIzhmUyK+wiwf8u57wKrj?=
 =?us-ascii?Q?u0YIjDO2mtuV0UK+kvIzbIGgxSzojcLtJd55OObJpZY2KpuSEVVu9DTXb8PJ?=
 =?us-ascii?Q?zsgaszPtlZiKdij2zv3FO4xtRyDfUcdXuiCCJ8/kxJvDqA9ZnYzEPJ8mebE+?=
 =?us-ascii?Q?dA6OOZ6j4pprHgazY13gPPa6QdcdnO6PJVlARNTRyaaWnXSWSRketqqGeG/I?=
 =?us-ascii?Q?a9XGzs/rLeJ6xqVnbTYUmfcxXDt3VsP49NEnMnskNEECdSadmALyjg020+Wc?=
 =?us-ascii?Q?v4U1+Dy+d2tJwyPtYHn6u7VBAdVywd/RLYgEZgtv9qrMXGQWo9YvbstxprLx?=
 =?us-ascii?Q?o4ge6Nw9qeS4tHz1jFfVh6roYpsHXGI2j2LfAd60e4Zx+y3rH3Es5I9/OBp9?=
 =?us-ascii?Q?U0Y8Iqj/aSx1bJ2sAk+AJ/oP/K0UTjYOTRfG48Cu2+bL0UETq/zDeGX2vWXC?=
 =?us-ascii?Q?v1HkLOqkj83Y/FKczPJHgu8Gt0ol+hxNK2PHl37DAaMvedH6RxoktCG9vYKL?=
 =?us-ascii?Q?I1cCmXHK9ujGyfIF6HKQMVAoBfeDF4rllNiF2EH4+qjdo4JT1+PCsda9Rjoo?=
 =?us-ascii?Q?y1Is7vPMzXZ7DLyw5b3Fq+HVO66h1Mp77ec1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:31.8316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 841bd94f-3513-46f5-3921-08ddf9814295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
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

Add mp1 common ras functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.c | 81 +++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_mp1.h | 50 ++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_mp1.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
new file mode 100644
index 000000000000..92f250e2466d
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.c
@@ -0,0 +1,81 @@
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
+#include "ras_mp1.h"
+#include "ras_mp1_v13_0.h"
+
+static const struct ras_mp1_ip_func *ras_mp1_get_ip_funcs(
+				struct ras_core_context *ras_core, uint32_t ip_version)
+{
+	switch (ip_version) {
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 12):
+		return &mp1_ras_func_v13_0;
+	default:
+		RAS_DEV_ERR(ras_core->dev,
+			"MP1 ip version(0x%x) is not supported!\n", ip_version);
+		break;
+	}
+
+	return NULL;
+}
+
+int ras_mp1_get_bank_count(struct ras_core_context *ras_core,
+			    enum ras_err_type type, u32 *count)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+
+	return mp1->ip_func->get_valid_bank_count(ras_core, type, count);
+}
+
+int ras_mp1_dump_bank(struct ras_core_context *ras_core,
+		enum ras_err_type type, u32 idx, u32 reg_idx, u64 *val)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+
+	return mp1->ip_func->dump_valid_bank(ras_core, type, idx, reg_idx, val);
+}
+
+int ras_mp1_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+
+	mp1->mp1_ip_version = ras_core->config->mp1_ip_version;
+	mp1->sys_func = ras_core->config->mp1_cfg.mp1_sys_fn;
+	if (!mp1->sys_func) {
+		RAS_DEV_ERR(ras_core->dev, "RAS mp1 sys function not configured!\n");
+		return -EINVAL;
+	}
+
+	mp1->ip_func = ras_mp1_get_ip_funcs(ras_core, mp1->mp1_ip_version);
+
+	return mp1->ip_func ? RAS_CORE_OK : -EINVAL;
+}
+
+int ras_mp1_hw_fini(struct ras_core_context *ras_core)
+{
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
new file mode 100644
index 000000000000..de1d08286f41
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_mp1.h
@@ -0,0 +1,50 @@
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
+#ifndef __RAS_MP1_H__
+#define __RAS_MP1_H__
+#include "ras.h"
+
+enum ras_err_type;
+struct ras_mp1_ip_func {
+	int (*get_valid_bank_count)(struct ras_core_context *ras_core,
+			enum ras_err_type type, u32 *count);
+	int (*dump_valid_bank)(struct ras_core_context *ras_core,
+		enum ras_err_type type, u32 idx, u32 reg_idx, u64 *val);
+};
+
+struct ras_mp1 {
+	uint32_t mp1_ip_version;
+	const struct ras_mp1_ip_func *ip_func;
+	const struct ras_mp1_sys_func *sys_func;
+};
+
+int ras_mp1_hw_init(struct ras_core_context *ras_core);
+int ras_mp1_hw_fini(struct ras_core_context *ras_core);
+
+int ras_mp1_get_bank_count(struct ras_core_context *ras_core,
+			    enum ras_err_type type, u32 *count);
+
+int ras_mp1_dump_bank(struct ras_core_context *ras_core,
+		u32 ecc_type, u32 idx, u32 reg_idx, u64 *val);
+#endif
-- 
2.34.1

