Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B630DCAC5AA
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570F210E37D;
	Mon, 22 Sep 2025 02:39:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PFIOVJ7K";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52CD810E115
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiGbEJSlffoSy/GfxmSWGl+XDme5kuFtRoCGbaKdEGezTibLN0kI9e9hfozreR1+WewIrrKE6eVM45Zq/NmfwIR/EttrCHzIi4XvWB/WuXqIdr0tbAp+tczGBy5skB5Z4yTTMeFFCYvG8zzUWjG8nvVLmtcRlcWT5LdTIl9qZSTiOhlkbNHLuihne5u5eaHxosWNGUyPui+fQD//9euFHAOtsl7yv6ZuTLt3GxTj0DfcA0IXb0344lBaIf17Fuq1SKfr+qEuC0ckb6bA3VcJanyRfzKBQbu7ukewXxiaw1z4XoUs8NKpfg4SDwD1a8gkF3wphZeo5fwD/04yMplZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9sur8/bjxcJspKi/BlLx5mUTVsj1iSfzLdCq2Uwmw8=;
 b=tKFQ/eb81fbV71Sccfse9p9PO+rL/t+sBxy4wz792Pvor4txNNXVMjNddlgUI0SaGXpXuG0BApP2/75rfm/3Fm8DAZnhzWWikeklTzb0i1oEF5FcSAL/dcIe6jAgksspOyL3vtGlWyIbn4pR6Cmwoq/RC/Rtre+sXQyGWfJFgeDXROO4yuIOG5tsBIAEUE6k1LOHT9jQ7idgepiNC2lKzQJq0b/c9/X2Iw1m4UxTgbBRiO51HvBoKkju2HlDyBaklcdxgynlgY5gaiFbHZpvNp4YisGtDjnEkbZTBcb8uhgT7fKk3m8ynYtANo1kJa7E3VxIRfM2mxXXcwB5+HHFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9sur8/bjxcJspKi/BlLx5mUTVsj1iSfzLdCq2Uwmw8=;
 b=PFIOVJ7KiEV3ZMZaqMbu5fbtwpmjebxc9rOc7B91rp4PMI/fFaCe7wx444IwXeDi+Bj7lDYsV1T56RxP3xvd2qwNZ8h4XlOkyO3YBGX8JTCDW+4hpk16IioG1g0phCqwE6j287og0IkB22YSr37EP5GxQ9/JRHTmleljl7CYf+c=
Received: from BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25) by
 CH1PR12MB9672.namprd12.prod.outlook.com (2603:10b6:610:2b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:39:36 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::7e) by BYAPR01CA0048.outlook.office365.com
 (2603:10b6:a03:94::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 02:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:35 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:31 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 06/20] drm/amd/ras: Add nbio v7_9 ras functions
Date: Mon, 22 Sep 2025 10:38:30 +0800
Message-ID: <20250922023844.3108065-6-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|CH1PR12MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: 4457d0da-6468-4f28-8874-08ddf98144bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MR7yXy6BMaYly3aNvJHLXvI5oJ3dKpkkoFQtUGjWxfIXWgt4hETPx+fzT/wh?=
 =?us-ascii?Q?yrVuZd0rOxjr6uPDacB2p4OORB9mSU87KDo0qdszPScPfJq8hu6WlxH5oyPY?=
 =?us-ascii?Q?aKfB30FxUpqgmSMnmg25Kln4OTVRwgXaMeKo876W2RDyaiGrbsQjjpj/tpod?=
 =?us-ascii?Q?BzbbnNrjM956L/V/e69Zkh5jfrh7z100xfpER9LaSDwXiOV4IrabTpXdsB+4?=
 =?us-ascii?Q?XLO19KskOcr1014N12jkdNbxduT1neXkoq789uO+YfAnC4hJmsvLQWNZT7sj?=
 =?us-ascii?Q?WqNZUpgFZoXWbkTAXHFGpY9bS5DDILlt+udbYtcylKkPydaXN6AG23Wth4QV?=
 =?us-ascii?Q?k+dBGhN+laDByW2E0Iw9cOL679bDvsZ91WX4wEiypM1POYBbFwqxuY+DFOss?=
 =?us-ascii?Q?ZH8jAt1bQ/TkxXBsFLbXxLi1puTRPi7xBmz327kydQ5TjAPkhPfHchO3QVkW?=
 =?us-ascii?Q?5FQnTj0L6vVuRSxBwM5kRVOgC0L7D3nrP3UW36MAQVvVjeeJvOhz5ucaO4QU?=
 =?us-ascii?Q?41U5xagaO4pHug1YS7gj6CbTS7+gOKQg3N3We4vSjZm2zhuIf5p9aervkzzR?=
 =?us-ascii?Q?WaOMLxz95UOvgj5tORWyZhVlDmQVEjLqSYFjM5BxXQJvNayyuJyVwLKpCqqp?=
 =?us-ascii?Q?vlBX5+JTmiixPfDNgAVRiL0IQLXRIxW9bSn4AbVtPMCRcLYhhX1B7/t/5FFe?=
 =?us-ascii?Q?gGEhQfsiFM+l4Rux7vWpokzWJARU1N209AGP7xmsjS+y7SA7jbqN+LOzyMmK?=
 =?us-ascii?Q?24Xt15FRj/urmbmUFIf7nlcTV3ZEmNB65abapKMYqiHT+DKG62UJrnLCfJ7d?=
 =?us-ascii?Q?ZfZfDIgvDMZk4TXhaQtFaGR2NlmVD75l/kclJCkltf0dgQRs/DAi3goZ7Ak0?=
 =?us-ascii?Q?GPEgSXsEJaxPZMkkoFyhd31iegua0heiH0lA4LSs6wrVymzczpojXr7cnxeU?=
 =?us-ascii?Q?lQ3XkOa34NFBqKtZ/7IOkLAHHXYGvBBlKq+uDt1y4huonZN4YEJQ7xArGWpk?=
 =?us-ascii?Q?VQmHqtCc0yJa5uUbU2CfJTwlL2K1NhvRPGyTmmiidDX0XdoblrTRCAX3eSIE?=
 =?us-ascii?Q?3Im91zKViQNBYUcmOfc4t6sjkRv7LhNUbTMbfbwmDxEdE2WXHR9obIusau3i?=
 =?us-ascii?Q?STc9puFuuyw+VIxhfAjmUVBtpO6MZ7+/RnfgtYoUfUoyBOBEiTTWEn1N4Ain?=
 =?us-ascii?Q?eLa5RGRTmAWW3Rb2f+QnJpVwXM86TRtTm8lQAlLyHyxPSKTMvtYmUegRlZmf?=
 =?us-ascii?Q?AqZkqEcLwUnsmYO5DOFKgsOVGJkX2wxHmiFRGie2AsjsurwHKHOMeqpiGIN5?=
 =?us-ascii?Q?rjRdBKi47VmTFkaEpDRz0jLN4qoMp1JkRy4sAJTaPB80oXe3XgLUuWHteGmd?=
 =?us-ascii?Q?yoXADmKP/8KO1Kvx6nIqqGvbT0b+4Gv1Hx7SVT+0tjdh+tLtdzdZMPxg1XfW?=
 =?us-ascii?Q?KpibWF+JanLvii7Mtj1iBaXzhywfKqu60f1x1b8NP0Dxpf+t5OGf3OgjzEu+?=
 =?us-ascii?Q?JuySgT8DnnPTB6z9lUyQWE6q+MWm9G4o9AIF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:35.4432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4457d0da-6468-4f28-8874-08ddf98144bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9672
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

Add nbio v7_9 ras functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/ras/rascore/ras_nbio_v7_9.c   | 123 ++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_nbio_v7_9.h   |  31 +++++
 2 files changed, 154 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.c b/drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.c
new file mode 100644
index 000000000000..f17d708ec668
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.c
@@ -0,0 +1,123 @@
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
+#include "ras_nbio_v7_9.h"
+
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_ATHUB_ERR_EVENT_INTERRUPT_CLEAR__SHIFT      0x12
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_ATHUB_ERR_EVENT_INTERRUPT_CLEAR_MASK        0x00040000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS__SHIFT     0x2
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS_MASK       0x00000004L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_INTERRUPT_CLEAR__SHIFT                0x11
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_INTERRUPT_CLEAR_MASK                  0x00020000L
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_INTERRUPT_STATUS__SHIFT               0x1
+#define BIF_BX0_BIF_DOORBELL_INT_CNTL__RAS_CNTLR_INTERRUPT_STATUS_MASK                 0x00000002L
+
+#define regBIF_BX0_BIF_DOORBELL_INT_CNTL_BASE_IDX      2
+#define regBIF_BX0_BIF_DOORBELL_INT_CNTL               0x00fe
+
+#define regBIF_BX0_BIF_INTR_CNTL                                                       0x0101
+#define regBIF_BX0_BIF_INTR_CNTL_BASE_IDX                                              2
+
+/* BIF_BX0_BIF_INTR_CNTL */
+#define BIF_BX0_BIF_INTR_CNTL__RAS_INTR_VEC_SEL__SHIFT                                 0x0
+#define BIF_BX0_BIF_INTR_CNTL__RAS_INTR_VEC_SEL_MASK                                   0x00000001L
+
+#define regBIF_BX_PF0_PARTITION_MEM_STATUS                                             0x0164
+#define regBIF_BX_PF0_PARTITION_MEM_STATUS_BASE_IDX                                    2
+/* BIF_BX_PF0_PARTITION_MEM_STATUS */
+#define BIF_BX_PF0_PARTITION_MEM_STATUS__CHANGE_STATUE__SHIFT                          0x0
+#define BIF_BX_PF0_PARTITION_MEM_STATUS__NPS_MODE__SHIFT                               0x4
+#define BIF_BX_PF0_PARTITION_MEM_STATUS__CHANGE_STATUE_MASK                            0x0000000FL
+#define BIF_BX_PF0_PARTITION_MEM_STATUS__NPS_MODE_MASK                                 0x00000FF0L
+
+
+static int nbio_v7_9_handle_ras_controller_intr_no_bifring(struct ras_core_context *ras_core)
+{
+	uint32_t bif_doorbell_intr_cntl = 0;
+
+	bif_doorbell_intr_cntl =
+		RAS_DEV_RREG32_SOC15(ras_core->dev, NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL);
+
+	if (REG_GET_FIELD(bif_doorbell_intr_cntl,
+		BIF_BX0_BIF_DOORBELL_INT_CNTL, RAS_CNTLR_INTERRUPT_STATUS)) {
+		/* driver has to clear the interrupt status when bif ring is disabled */
+		bif_doorbell_intr_cntl = REG_SET_FIELD(bif_doorbell_intr_cntl,
+						BIF_BX0_BIF_DOORBELL_INT_CNTL,
+						RAS_CNTLR_INTERRUPT_CLEAR, 1);
+
+		RAS_DEV_WREG32_SOC15(ras_core->dev,
+			NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
+
+		/* TODO: handle ras controller interrupt */
+	}
+
+	return 0;
+}
+
+static int nbio_v7_9_handle_ras_err_event_athub_intr_no_bifring(struct ras_core_context *ras_core)
+{
+	uint32_t bif_doorbell_intr_cntl = 0;
+	int ret = 0;
+
+	bif_doorbell_intr_cntl =
+		RAS_DEV_RREG32_SOC15(ras_core->dev, NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL);
+
+	if (REG_GET_FIELD(bif_doorbell_intr_cntl,
+		BIF_BX0_BIF_DOORBELL_INT_CNTL, RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS)) {
+		/* driver has to clear the interrupt status when bif ring is disabled */
+		bif_doorbell_intr_cntl = REG_SET_FIELD(bif_doorbell_intr_cntl,
+						BIF_BX0_BIF_DOORBELL_INT_CNTL,
+						RAS_ATHUB_ERR_EVENT_INTERRUPT_CLEAR, 1);
+
+		RAS_DEV_WREG32_SOC15(ras_core->dev,
+			NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_intr_cntl);
+
+		ret = ras_core_handle_fatal_error(ras_core);
+	}
+
+	return ret;
+}
+
+static uint32_t nbio_v7_9_get_memory_partition_mode(struct ras_core_context *ras_core)
+{
+	uint32_t mem_status;
+	uint32_t mem_mode;
+
+	mem_status =
+		RAS_DEV_RREG32_SOC15(ras_core->dev, NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_STATUS);
+
+	/* Each bit represents a mode 1-8*/
+	mem_mode = REG_GET_FIELD(mem_status, BIF_BX_PF0_PARTITION_MEM_STATUS, NPS_MODE);
+
+	return ffs(mem_mode);
+}
+
+const struct ras_nbio_ip_func ras_nbio_v7_9 = {
+	.handle_ras_controller_intr_no_bifring =
+		nbio_v7_9_handle_ras_controller_intr_no_bifring,
+	.handle_ras_err_event_athub_intr_no_bifring =
+		nbio_v7_9_handle_ras_err_event_athub_intr_no_bifring,
+	.get_memory_partition_mode = nbio_v7_9_get_memory_partition_mode,
+};
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.h b/drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.h
new file mode 100644
index 000000000000..8711c82a927f
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_nbio_v7_9.h
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
+#ifndef __RAS_NBIO_V7_9_H__
+#define __RAS_NBIO_V7_9_H__
+#include "ras_nbio.h"
+
+extern const struct ras_nbio_ip_func ras_nbio_v7_9;
+
+#endif
-- 
2.34.1

