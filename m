Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B2BCAC5A7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B9510E115;
	Mon, 22 Sep 2025 02:39:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QqFGcYgP";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF1C10E37D
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxuC0SZiRuIhlbMQySNKbabANnUijbeWcvbkLc8ZUiEQ8X7GEJdUYuwUzvwEk2DBmo8h/0W+WvMfKDn13I3mHPvyvWJKWWcvxqyY+WV7l/AV134pxTeF8P2sx2yR5TM3UKM/vRXdyZmkh0o2D1EGtm4v7Ipd+CVtPL7cer6GLRQ1cpfbwMnd8AQH6LD7Ea5YlZiUM7cVjDYg9Qevda7sebEyW2SjQLdtySsYbrQBDTaNYu4t0hAt3KH01GVZ3LumdTiXpDWg3dSOKaCBeF6g9w15dy/3A0d1Q2ItRJdljxsZF8IIHh6ixkSRtp1cnHAIRxKRB9SbkmwFE7Vyxz2G2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7RqWUMuMEkEO3LKGqLAzGR1L1tRS2KMJeurynGpBV8=;
 b=BRbjxrwO8hC0uA2ZUy1xuPkOC0a3zmxfQmT4U7pqcopjY5LQoW8sUpXsw/+pZ/BsQNmFAaMrGOe7efKejsb57s6wZejE6OfrDXQmQS8PDEmb/aXrVTjgMLNvFVs4Mq5HoNwUaq3t7cY7S/uSXcrRV04jymnsl91mhO5HRJEz4OZ3kkY4utnjrxmPx2kPN/H/rJdcEc9XEtXn4ptC0IjDqSjrwgtzVMKu768j5IP06pZUmDfck2xThUKwmlQAW+0UgNslXoYLEu/AsoWtiPUvUzGSbfhmSwa5/CHzINKT1TCNO8NkFldfBYBngBOv/EAE+9lcnhIOSm0eJ8ozUd4uJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7RqWUMuMEkEO3LKGqLAzGR1L1tRS2KMJeurynGpBV8=;
 b=QqFGcYgPEkFd1BQP9FW7UKOyrXXJ2pMDWJybea/2QGUXzjHTEJ/EQGedmNlvJWjowxWaSXDZmkstQ9tFw2GxpaBNPPh4DhdxrEv2Qc+BOuaTTTIGX8T9PfxDXeaKcrhIGdlNCr0F/POYBg5I/23ocE+Q8ZGtywWu0PIzjIBAL6Y=
Received: from BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21) by
 IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:39:37 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::30) by BYAPR01CA0044.outlook.office365.com
 (2603:10b6:a03:94::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 02:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:36 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:34 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 07/20] drm/amd/ras: Add nbio common ras functions
Date: Mon, 22 Sep 2025 10:38:31 +0800
Message-ID: <20250922023844.3108065-7-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: fb103b10-4a0d-4189-0d37-08ddf981458e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tnlM88OCZ6r241ETIP2wN3rHlKCaSXmhc7m+J84ewYxaz4EB2IPRcTNgrPtc?=
 =?us-ascii?Q?2QygmRXh8fIQiVMSrpPuDvGoeWgOj4PxcvxoDDmWv2233uKe2iNz66DdbW9X?=
 =?us-ascii?Q?RHaTsgR9fULgMCS3FM5eLHzCmjZ0nxivKfCgca08CevI1zY+jzy3IxOVe/Qq?=
 =?us-ascii?Q?SmUF5Tj26XSE3HG5N6lxE/ly4nEgfH6Ev/6Le8X6n5vI9QzcpKp4NnqFMkz7?=
 =?us-ascii?Q?BR2n7C4Od4CcdyoqdX+ShDC4GgJRBvb9SbkaSp+hjxGrdUcUZhIh76xXq9oO?=
 =?us-ascii?Q?BTP4gpznN3HRSOK6WknPKefWAFih2aLGfonE8xvcmqjAcEtKfpZMT420iA1K?=
 =?us-ascii?Q?zhX1jvTAwud633/5w82qLg3JE8T4p3N3/KoXa/A1FdwaLIGqbjx6ZQw3zwwj?=
 =?us-ascii?Q?TDEauGmsIblyRqpZdj3D8EhlNtGQ9J4s/Rc4tDVsj/VcSHT729V6M6Pl7+ef?=
 =?us-ascii?Q?sA+fz/fVzfo4oNjtjyvi7U861RCMHw4XcNFTufjG9JsAa0YApM6CQGfQh6Lf?=
 =?us-ascii?Q?gRplHg9Up4p5CQu+8/K2jQCJekj9gF8s6oQmwWusrgiHGt12jt1o6IDsVS8m?=
 =?us-ascii?Q?k92CCeI+SRtWtLiHib7Nu9ihQNgwco6Z6KfARw498H4Ld5YMKrbnLT/cwneL?=
 =?us-ascii?Q?vuudJIbAjQRlTgvineDBAZVQ5HBCCO/OeL1xv/jpES7fzAsxX//gwoRF1Tf1?=
 =?us-ascii?Q?L87coXXsMZLGVCzXLTT+3Y8bSKDW0tiO/aa2q6Pq1qh53cY6nriMJ4DKGG7K?=
 =?us-ascii?Q?aKkHhUeRbiqX5Wo3AVYyX+8ZjjO1hSh0eV9PgzSW4eadLbM4XZjVcxCpo06s?=
 =?us-ascii?Q?Ppj1ep4POqdKy9szSqObNL4E1FU6JmmLwG7ZQG551qqw6PWyA/1vETU8AHaB?=
 =?us-ascii?Q?v2cptq73oQhd7t/1cZ4YwjKV0l9CtQs0X9q4zh4zSmTUhRmWRiZFFfybxMAd?=
 =?us-ascii?Q?LSU42t2T7hFbzlpHMqPGZwxasyhQshutvwN+OCtxWweeutyzJHeXQjDmNYzV?=
 =?us-ascii?Q?WLU7D8kc6wL0bXM+bqKFh2GHkDP/xK97pPGxvNQqu8yC1oqRi1ajQ+eW9Aa0?=
 =?us-ascii?Q?vJcZBHyq2b66mtkCxtasfJN3oRyGG3NJ5Kn+gdG2JnC3tOVOwHXLYFjZnZTL?=
 =?us-ascii?Q?GQGh4mBWXzt6dO0d7VI6460oI0vq2bY535eWIRVz2+NAFhNRUT2rPOkw7bU/?=
 =?us-ascii?Q?a5jUYDcgB7jVGpl5LEk7sPHz663RucO+iV2xHqccUgRvTYbqMULRJVLxFQiU?=
 =?us-ascii?Q?Chb6cKNz5iAT1DhigW97wf9TthlYEs6Cu69WgN5yCCRmrBzW39IpWXIXJzP3?=
 =?us-ascii?Q?A9I4mPBsbHi4dLN7B0Z118Ss0XL8a+GT3d636UX43ySr/ymCD/VN24fDwh5r?=
 =?us-ascii?Q?iGUszJahbYLk90Q3k/jUDKiFyML2u/ul7ktHDSjKv3i4aMVftEjjdbLHDrqC?=
 =?us-ascii?Q?mQmvIhy5jW3nZLYWtlL//foKM7udWfP6PoTCXNGrUTYARi2AX02B206w/A6J?=
 =?us-ascii?Q?XNdql5jWEveyfFckdllf8vSGyMlOHI4kFdZr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:36.8176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb103b10-4a0d-4189-0d37-08ddf981458e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
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

Add nbio common ras functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_nbio.c | 95 ++++++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_nbio.h | 46 +++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_nbio.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_nbio.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c b/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c
new file mode 100644
index 000000000000..8bf1f35d595e
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_nbio.c
@@ -0,0 +1,95 @@
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
+#include "ras_nbio.h"
+#include "ras_nbio_v7_9.h"
+
+static const struct ras_nbio_ip_func *ras_nbio_get_ip_funcs(
+				struct ras_core_context *ras_core, uint32_t ip_version)
+{
+	switch (ip_version) {
+	case IP_VERSION(7, 9, 0):
+		return &ras_nbio_v7_9;
+	default:
+		RAS_DEV_ERR(ras_core->dev,
+			"NBIO ip version(0x%x) is not supported!\n", ip_version);
+		break;
+	}
+
+	return NULL;
+}
+
+int ras_nbio_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_nbio *nbio = &ras_core->ras_nbio;
+
+	nbio->nbio_ip_version = ras_core->config->nbio_ip_version;
+	nbio->sys_func = ras_core->config->nbio_cfg.nbio_sys_fn;
+	if (!nbio->sys_func) {
+		RAS_DEV_ERR(ras_core->dev, "RAS nbio sys function not configured!\n");
+		return -EINVAL;
+	}
+
+	nbio->ip_func = ras_nbio_get_ip_funcs(ras_core, nbio->nbio_ip_version);
+	if (!nbio->ip_func)
+		return -EINVAL;
+
+	if (nbio->sys_func) {
+		if (nbio->sys_func->set_ras_controller_irq_state)
+			nbio->sys_func->set_ras_controller_irq_state(ras_core, true);
+		if (nbio->sys_func->set_ras_err_event_athub_irq_state)
+			nbio->sys_func->set_ras_err_event_athub_irq_state(ras_core, true);
+	}
+
+	return 0;
+}
+
+int ras_nbio_hw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_nbio *nbio = &ras_core->ras_nbio;
+
+	if (nbio->sys_func) {
+		if (nbio->sys_func->set_ras_controller_irq_state)
+			nbio->sys_func->set_ras_controller_irq_state(ras_core, false);
+		if (nbio->sys_func->set_ras_err_event_athub_irq_state)
+			nbio->sys_func->set_ras_err_event_athub_irq_state(ras_core, false);
+	}
+
+	return 0;
+}
+
+bool ras_nbio_handle_irq_error(struct ras_core_context *ras_core, void *data)
+{
+	struct ras_nbio *nbio = &ras_core->ras_nbio;
+
+	if (nbio->ip_func) {
+		if (nbio->ip_func->handle_ras_controller_intr_no_bifring)
+			nbio->ip_func->handle_ras_controller_intr_no_bifring(ras_core);
+		if (nbio->ip_func->handle_ras_err_event_athub_intr_no_bifring)
+			nbio->ip_func->handle_ras_err_event_athub_intr_no_bifring(ras_core);
+	}
+
+	return true;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio.h b/drivers/gpu/drm/amd/ras/rascore/ras_nbio.h
new file mode 100644
index 000000000000..0a1313e59a02
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_nbio.h
@@ -0,0 +1,46 @@
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
+#ifndef __RAS_NBIO_H__
+#define __RAS_NBIO_H__
+#include "ras.h"
+
+struct ras_core_context;
+
+struct ras_nbio_ip_func {
+	int (*handle_ras_controller_intr_no_bifring)(struct ras_core_context *ras_core);
+	int (*handle_ras_err_event_athub_intr_no_bifring)(struct ras_core_context *ras_core);
+	uint32_t (*get_memory_partition_mode)(struct ras_core_context *ras_core);
+};
+
+struct ras_nbio {
+	uint32_t nbio_ip_version;
+	const struct ras_nbio_ip_func *ip_func;
+	const struct ras_nbio_sys_func *sys_func;
+};
+
+int ras_nbio_hw_init(struct ras_core_context *ras_core);
+int ras_nbio_hw_fini(struct ras_core_context *ras_core);
+bool ras_nbio_handle_irq_error(struct ras_core_context *ras_core, void *data);
+#endif
-- 
2.34.1

