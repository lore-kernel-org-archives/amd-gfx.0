Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CDDCAC5A7
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1439510E380;
	Mon, 22 Sep 2025 02:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YFeoiWHY";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011021.outbound.protection.outlook.com
 [40.93.194.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5BFA10E37F
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+5jSZdHnW5W9HuK0deaqswMUQL1sX7q9YDulkf7sGwjggMwF2nd7no9kCllDCV23ZISnr0koHl1obJXYRJoNYGwgUOA3sL66+8Xoo03n1wtt6F3OBw9FlKIYLOkmKbpEhj9RriF/nK/rTAQm+qzpWnpiU00LfsvzBHCA3KreMBDO2WZbbktNztF7PHlEbsrC0242eOL3mN7vw1GOPnQav/eINldGo0w03ENHEMY2c4uRGhObkpz7+uVbZJqva5OIZL0UgqRSYK+KRePhqOZMLZcZnWurMyk984JY7DFQCOh+7mDtgaOFV5c+JjAYz9qrxJEMI2jIldqc+qAzwUc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bzVe25yAD5Y1IrpZKMBT+WJaujEz5b8JUZoL9JUcQE=;
 b=chkv51GWeGs/Hgit4/hmncoizCBnothx7NN7rdqH0pHOjkrRW4JRAVv0HQ5OyvKZKreeKZWTSsZ29/tiYGEobsJ6ay/fbEIVLktmMX2LT2VETVGblZmwwW+OtfZzNdGXyPGa0AS207voh0mK/fujOVywl1pGbk8zRinvXpPmfYP7uHob2IRhObML/tomqyr9fqsa1oVnGcO+YeEqICahHqd4cCbT27qY6ZFInAxnYaHuzYeFsiQK04rbKmIra9zdcBCqjVczVz/1uRgtGOV+FpoB8g3cjdPvT2d6RfdHOq0oDIuMzNTVVRo4ztZEQ35cdICIUl0THTTd1vvK+K72Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bzVe25yAD5Y1IrpZKMBT+WJaujEz5b8JUZoL9JUcQE=;
 b=YFeoiWHY5kgZurajHftBnWMh4VucnIxPLm0c2m8OJeU+8M/DJQhs8QV80SQRCr1CtlVP9EuE3qgouS5g7K4ZaO938UGMrJdJwY/1davMRFwtmw8fyN2xwGF2SA5vvPcR814WIk7aagImV6fAw9AIwK+zszn/h4bjBIIXtcmSB44=
Received: from BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37) by
 PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:39:45 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::46) by BYAPR01CA0060.outlook.office365.com
 (2603:10b6:a03:94::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 02:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:44 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:42 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 11/20] drm/amd/ras: Add gfx common ras functions
Date: Mon, 22 Sep 2025 10:38:35 +0800
Message-ID: <20250922023844.3108065-11-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 11077737-3e9d-4f4d-3d87-08ddf9814a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hefslW9UVOkOKghYokxijPHiBA3hIpjphRzO2iJ4A70W4Jd/JX9P5UcYo3Ux?=
 =?us-ascii?Q?twSyTmJb7XCgMcQ8s8L7r4jqLNsxuT4ya0speaGpgkDG2ADUmp0a7BQ21SJ0?=
 =?us-ascii?Q?j9vSlZlZrSn3DX8EVHL0A+3c59CsQBjjuFfMPzEAUcb62kk1dudeG8eI+ObH?=
 =?us-ascii?Q?uaXnpgzowJf0v70WYgoSWVtcguq35L4cgSSXKfsE/LPQkQtXHYixXLJdqz6R?=
 =?us-ascii?Q?2SP2C1Ia3XqZn0cixd3v8ycbjptIyxRlfGpRtnHxkvYIZ3VjtIykL+wePXLS?=
 =?us-ascii?Q?DF0zIKz4C/UQfb5gGc7+WzoS85O3rwlOgF9sYhUxZoozNsZtk8VgZMEJ1OGr?=
 =?us-ascii?Q?18bCcL06WNF9Z2BosT0aIzgJJH0gfCfAddHRsMikWRKodG2FQO5yKeyAmyix?=
 =?us-ascii?Q?K3iFsEL16mTBvqP/e29okW+ks5UOOJzbPBrAkGm2arxy+hxcYmRKFefBA0+B?=
 =?us-ascii?Q?3jL1HHSTKec+wmjGdorWUm76NaleKPTUJHZQrR2lFt7F6connwPt1sOs/nRd?=
 =?us-ascii?Q?PbFQ3eCHguFvzP3DWMxe69NS+rIH/RxFyaHq1UucFVfAJybMYi015g6oKJ03?=
 =?us-ascii?Q?N3yTdPX+Un5Y6wkh1Az7NFE4QAXd30MDeYq95Jlv+VEhcPSUD+NC8nBJjJ+Z?=
 =?us-ascii?Q?xqUDeKG7/feMrcrM7povlJ3hp581Mh9tPrq5tQbehJEVAC0FxZuNy0V5tbUo?=
 =?us-ascii?Q?HWGvknV9xiSjQMu3yVALD8tDP2PhXeo/83zi+SPdrb7jGdhB/EpBI7Sscd2a?=
 =?us-ascii?Q?PPpdOUSq0QwN9ZB30/BiZe2OOndShU2+ybZp7jRVRI753ugH/qSoqhVK+DvR?=
 =?us-ascii?Q?cfySrDN+TqFtZ0d5WQA4PEUFaUN2thCCUMQ/3zOc58jCWcVMyEvhZemoeFnt?=
 =?us-ascii?Q?Pw5XtlmLw4PU8T5Oihgq0uGYp+VPzg3FIyuxshhJHozN1Ize9BNJ2i14v45X?=
 =?us-ascii?Q?38vAsqC/AhIG6B/V9NgtMdOOK3JTDKRo3BISndg6Qj2Rp8sOtyR94SEArEfw?=
 =?us-ascii?Q?bR03FW+Sjz5asTBOn9vPnFh9Y9c3454aTNNfAWVEN5jVTE6KTFnBFs9VhWit?=
 =?us-ascii?Q?4jikhH09EeO7fBaTS6wRMQXPDFK6I1mtqlF3Sqrb2sq/lfTv0AFVUMcX8/vE?=
 =?us-ascii?Q?5gGKhas+ifD/fTt5WMrdrun1fwNyr6/X4wH9ra66Mkb399MaphCrcRzo02Tp?=
 =?us-ascii?Q?f2dHlf5dtfQI+REWALpWkbDeKCk3bUAxcd8C6oXja+F9tNrE+zSR5FTmsBd0?=
 =?us-ascii?Q?s70YO4ZgvMcXYB9rJXUyN4vZAsHx6hLXbo8vnXTPKJn14oLksQa29n8UmX1X?=
 =?us-ascii?Q?ety7Lg+BkyFZUXpgsLEBUonky2p9NIJ/7yXnWwqZ8UP73Vlqa97+1MkRtaeJ?=
 =?us-ascii?Q?jBdTSGrWj4PK64+GV8iiOaCnyWbdRt/PXv/qbMWL3y8G8cwxWZqBPrrD5izU?=
 =?us-ascii?Q?y16b56P7NsbV/OjB+MSnsXUhDvxuUCU7SCtPh6qAtXOfNGdmA/70Z2mCO/Ju?=
 =?us-ascii?Q?/MfUYOjrIEONJfA1+9tcKM8tpwq/2YargW0h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:44.9841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11077737-3e9d-4f4d-3d87-08ddf9814a6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903
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
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
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

