Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C073CAC59A
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDCF010E386;
	Mon, 22 Sep 2025 02:39:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lVZFRTKn";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5981510E386
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BifLMMMoBVuwdxNr1JN2vgYi6qIlR904PDHgiv2j7KKq/Cjlakg5FIdubLGWLjtjelhU1T2FxCLVWGg8miHeXJV8072cHNkyzZ4RaQVOoIL3ZMeblu2WZdHzXDdvd2MYSpuZxWHIHEFnt1lDCS64tptaVmZbS3J89y8ZrTG5TzsnYllFHfWPpVWlbEpr5zC2tT4TFnvlKRItmY2TEe5CiDhqh27gafN7Sf5UGyVw9IJe/ULO44sjuCemuXnPWZG2F+NEx7Q5lg6prptvCns2Drl3ZswSD/qyyZ9/s7b4Rq4Ytkm/Rvmwpc/07dDkzxLj2o90fBEaBZu0+3uf2B/2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyFdgmxGqgy2L+oB2pLnUzyf2muz8IhKKvBY+0szLd4=;
 b=gpk4cVcA/R54FVyFP5w06rjmigX3DaHJrWLPqcl/7/btdpJXwvvdaqRiq5m4qx7RNQt3bENbg6utExoe7ObWnLJ+8w1GCoKpEynmv+z1mHnMhE26fxezkxHEjre4WlrDH+IPJZbtTMVF0czeG94zcDZLK8LqPORKWpd/R5KQ5KKcDc56v8oMFJd+tZ1DDre+ofW6LNJxrUKMpvXFJr+0nXSIe2AjYXo5x+I9+Ge8dS177svDKtcCuuWB8Ofy/9cOWxUw/FU49o1LoyBW3dSZYRblNrBZOWyIBiC9pMwHUBhPhFLpeRkRcV9az+dROZIf+oW7nFnxeqfaCig/4+BgMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyFdgmxGqgy2L+oB2pLnUzyf2muz8IhKKvBY+0szLd4=;
 b=lVZFRTKncPuGgN74j7H8yyFgbC+8DRqdoS1QS4zxUU8FCgcyt1RlsLnNyCsXdqDqfuJqdbuLk+q/A74iQ9lUXqWyYJhaqRZ/CwM41CbgXlcrQPKqRM6qiEGvUeXmhxTovddoH1pVguXOqpIjfJDlx/BoLmJ/su2koqvHBy9ldfs=
Received: from BYAPR01CA0059.prod.exchangelabs.com (2603:10b6:a03:94::36) by
 IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:39:50 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::83) by BYAPR01CA0059.outlook.office365.com
 (2603:10b6:a03:94::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 02:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:50 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:47 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 13/20] drm/amd/ras: Add psp v13_0 ras functions
Date: Mon, 22 Sep 2025 10:38:37 +0800
Message-ID: <20250922023844.3108065-13-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9d41a4-3503-4214-84e8-08ddf9814d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p/hAeHIJWOguB3OeRNUWUvyP5tz+8Q4GzisKawyxcn/QzvTsh8U1Ga+gXPvA?=
 =?us-ascii?Q?GoRO4MVuEbJcjOFastPoE2e2IdKYOxpV+knfRNx7sFB/Slk+bCzR/DY6nNBQ?=
 =?us-ascii?Q?ql3zTrcOIySVOqNkJZaoeA0+6cMBpfLVMwLoNW06U6HIvbkjE9qDb9JYC6Ui?=
 =?us-ascii?Q?TEx3yegPddRUYZQkvo3bV61C9jo9u4FEerZ/tFzDAIt/B0eqKTQ9kEKoLWnj?=
 =?us-ascii?Q?lul49igFh2RPzzZEaX8QboZ+AW0hbGczO8nzNcHoU5eqmIAKPxIaDonce1Sn?=
 =?us-ascii?Q?YJR4b3YnpXikoniMH0Byf4fh7bJN14Zjqb96qjOz9SdwN738s0k3HstvaAj6?=
 =?us-ascii?Q?0Qfop2P34SlUeImP9vHJtDvEsVUzHYGYaXFQO45I7WFtbHBZfxAYzrZymdO1?=
 =?us-ascii?Q?qLRbyTVxikH/YV6awis2034NqFg4W/aNY+g4eFlj6zsDAkMNQ4X8fWTtF6Ri?=
 =?us-ascii?Q?8zAHFYC4AEijFrJs0Ci2b1ipSkRgdFT6CQI4uPzubiX9Nr2jqhIEUVBX1C+V?=
 =?us-ascii?Q?KOdeZHhF8d56+Wba2qAMFHsJmwuTFATbub0D6TXKJAUgVw4uQY22MDKxGe7N?=
 =?us-ascii?Q?q6upHk2JXuXKFhIHZ5Eu0A+wBXldq62TuUirpod3gMtOEme/TETfcsk/2/A3?=
 =?us-ascii?Q?MqLFl0rzoYr6ZKWpaTGIZEpy0Aoy6FKaYfuywSYqx4KZOO2C+Shbrh9NUHeQ?=
 =?us-ascii?Q?AjHkkCXOXh2OlyG7K+3v/fMsY9SObhjdFDSaWsqotYB8n9e3zPi4RtgliN6l?=
 =?us-ascii?Q?0VjRiiik/cz9KACMzyOSuiPBbc9n4JOFxBOL23ELR3/XW3P6sYt/pu77PfK8?=
 =?us-ascii?Q?BG3JnquyExUZZQzC+FoOo1bN3PRSa4iwGPXNgMlWtYIuH8sh17ESMo+4OYXL?=
 =?us-ascii?Q?4RsBLK6hx5NxfGxshU9IA0izHV9kHGoi1Q3ys0oKtlZ1n3nDcvnIU3i/KzXM?=
 =?us-ascii?Q?Hez6cxWBtBq85+gM6/iFRkJ2MPJ4VBdroKTVGDx4emFIutOnSep2AAZPoi9Y?=
 =?us-ascii?Q?Gqe88+8FitVUhknKC8Yc5b0nKobxqRAcMBizT3aD3lhrZgPv1vQDH/Ypm2A+?=
 =?us-ascii?Q?qJb/waPRPnThZATfK2hv2JQNBtspqqVt9O3mvNXODbfKYSIlxXN/gatQlFvN?=
 =?us-ascii?Q?kRYsSz5TNISAcjbDoi4AzLEb/XIvwHVYP2kcuJbqSFxl/t5nofBWfqyZCB83?=
 =?us-ascii?Q?bhI1X3PMHxUQMbrYkwiSjAQdQANiufIK3SgFK1xKi1ofKLmqGw5Oiyoqr5ah?=
 =?us-ascii?Q?cW7wTA3haQZ3m42R6c2owlYkbhYOwgA4wqQccRX9BmoDVbE+s4lUHLxwiJQk?=
 =?us-ascii?Q?sXa7UWWvTNJwwxST0E0MqJR/+6MH3OKsLUZHJhRYgCyCJLG1LZ1VticyClMi?=
 =?us-ascii?Q?lLqac248thHhVpFdxj6L4xEGBMA9aUfT1ElTlrOyThbphvFm2DxmACHUAyjK?=
 =?us-ascii?Q?7ftFxuvX5P0CIQoh8ApXDCHk2LJUP/o64aIANtNRPodsx2fwviaW9d3P7SD9?=
 =?us-ascii?Q?UTiOPmGgnMOBTzvp18fu7GocpxQRrdsGNu0Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:50.2812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9d41a4-3503-4214-84e8-08ddf9814d94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
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
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
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

