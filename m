Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF09CCAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671C710E5F2;
	Thu, 18 Sep 2025 01:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xhgqbn1s";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3CF10E5F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vps/cJV+FSAQdXoKN3Pv61dMtoCC3lLFJ2qqxOl73nQ6QnBWugwE10wR3dKaNJzvlNEushk7EFKWxQf5A7HHK1VUVN/4sb06TWHdKf2agXmbbfH/ebN4kOVqi7/XW5cMq5MMTXBH5PYuiI7+cWzvOxGa2UcOTsEJJBh/sMmt6P9r321PSRGbjLgcVD2eGJahhQNUJtm2n/hIl8UW55FH/VhtDlTkoJ2PqapoP79zBcKwDglknmbRAAB/luroLxrdogk/xXLKKqZelJZ4bXYccXTIrRNLJ0eCmPv57GuTpdxEo433TjUuXMqS786UxGwTWAQAFNsJtS6EAq+iUgL3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtFwSCRiTxog1xs/6yT3ET9JqLW0AkpsnR/ToDxlRkI=;
 b=fV8bWXg1Nmlt6BYBEKpTq5VL46lsbE3AXdqr6kAIxvbQiFojlSUIfWFr8SsAyIB/XcPgwWyuI9jVkSp1YF1+iEn1+G8HMBEWHU8CSmSAaQ8p3j2Yr1LA1TVVBnC/mPHgQXCNpE2RCBZA2k14mBA4QIk6ZTVKWaP/Lsq2jp04fwf0RVgqmDjI+wU0UvABYJnxMBpcZPXhOGQJGg+akOZu3xCvPzBXN6hoc8P6dEVqUwef50lHnQU2WkNcqbpcqGrNS6EK79TzFLdVmid5orxyK7meHBdNcoeUg4rPyCMciRNCJW6eLi4AB1yFlquv0B9h2Rj6/Q3Vd7ugYRGN2SeadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtFwSCRiTxog1xs/6yT3ET9JqLW0AkpsnR/ToDxlRkI=;
 b=xhgqbn1sMwg0MYWZjvZxhzapv1PklRiinHw6Iur5+vpsEdOt4OhYnxL6goJXPTsYLGiO+SvTlAzPtTgqYq2YPF9mD2weS0XoZeFn3Rsy0Z/MZYcDv6J5a6vKMdp/KQPtBhNrx7Xo6DDhv/CWjMJlI5J3OgHDGvzHniZrr6AgpgE=
Received: from BYAPR07CA0090.namprd07.prod.outlook.com (2603:10b6:a03:12b::31)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 01:33:20 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::bd) by BYAPR07CA0090.outlook.office365.com
 (2603:10b6:a03:12b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 01:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:20 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:17 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 07/21] drm/amd/ras: Add nbio v7_9 ras functions
Date: Thu, 18 Sep 2025 09:32:18 +0800
Message-ID: <20250918013232.2629215-7-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW6PR12MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 23615e40-ad23-43ae-5dba-08ddf65359a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zIG9mr6H1fRZZ0Tl0c6euKWz/8ompHXZIoyth/US3Y8MRIi5jpoUXaWBWDeP?=
 =?us-ascii?Q?UXWArgYZxIs4AmCBBUS7iyK8xOQlaLAXb/r05OSOKqSRrrWwq2EzMWP1/Y/0?=
 =?us-ascii?Q?19BeRJ+RnFkHV9RJixDaNHFynTUDs6NgIENDbrVJ1Cbuy62ni7MJuSlQNpFr?=
 =?us-ascii?Q?8dO69ku8pmy2GFEcTtXQrsEUDialNJ2zexWCBCoA8IH2igyZWA+fVZWtuhPk?=
 =?us-ascii?Q?r42v61j8KzQ2eL5sGNsdOOGmXbq4jbOFMzKhIlb4KMWdUDSsFHKT1F+Cva3t?=
 =?us-ascii?Q?DkT7orLd/vsQTOFTDUFfuyMefPNJYDdsnoqFDprsfy98cYajLMwZaKf4A1j+?=
 =?us-ascii?Q?qusidFlWloFDV4iSqtSnXta8lqsIEJoK0hSkXrmVHrAOkAteLMtg/3+dRT6X?=
 =?us-ascii?Q?Ag1asYm1nvW7czcpMHG/plBHMmCJnMRGr4+GNPmhLIPON/VZVTdONfWXjSsU?=
 =?us-ascii?Q?BJP2QadpgzZHl1QcVWqAYVvxMC+gmWKB7TqltMj4gdVId/wJRia525xphl2X?=
 =?us-ascii?Q?BwAcOSaeYE3ARlPMMDfYSVz1Oo5a2TlK6c7WEBiAzPEt2w4snp6rV4g1pFBL?=
 =?us-ascii?Q?CE0Z6v+K7aAXHbTcU0wtYZBUacEn3wifTjWXe+tg03GCa4tjboKhCIQNYN4l?=
 =?us-ascii?Q?j/ZCrGP4hChzGxZNuY1H0bXwvTStE5o7cTJzl8khpaAxvC5Xhv06XoUKiHH6?=
 =?us-ascii?Q?6Ngj0J16v0SjDwPv61WzP/Nk7DcqL9y1UDYIWaK6pbXqoAxZ4OYsS2PkWgHZ?=
 =?us-ascii?Q?qh4gJbNLUfN7I7Epc2BVC9jJSkn0jJRDm6qmkDy1sBm3LZauSOq4E0cD3ia/?=
 =?us-ascii?Q?N8T88Dw+Uj06BFW5G33L3ddUW7KzR8ifc/S+VLofkkfgczre1f17o3pKxuWH?=
 =?us-ascii?Q?V+LcpggpPHOQBJ5oojakTvWHCFugWSJTH+Rx2tOSzCRCQdqdy5beZiM4bfW1?=
 =?us-ascii?Q?5WFsfQjJVDfx3fjV14QDpD6csvn7FkuIdZl7fYKA0WHTEDvKu2gUtGvXszzD?=
 =?us-ascii?Q?hFLnrXLMoPdjz7BEY/n6LOL7xnJoj52fV/UhXpU/5umUxjXZOncPyOuOTnTQ?=
 =?us-ascii?Q?UHPK7ueYa6h0i+LvH+Eg8IOkw3UOwUQSQQsrnT905/gyPgPx6cbki2542URz?=
 =?us-ascii?Q?7oU+EpRqDmm3xHLtPLaJLOV17GN7nm4PRSKq8a3IyGTrZivDo0/1kwKiXJ0y?=
 =?us-ascii?Q?mFjRcGd4vIcUzwQ/lmVnPUpOGSKA+uPTQnEwfKFyUli0q0nhr1oeZgQ+QmXD?=
 =?us-ascii?Q?tb6ISEoSPDWwHd0P35bSknUXHH4nFNUiCmKgLM68iz640C/5ApWz7VuTAFRv?=
 =?us-ascii?Q?wUuk87HVeS7+JoF2pMFlFbNXXFiGBGR7VusL6xXouNo8D8YNdenlOtI5ZHBk?=
 =?us-ascii?Q?wrOFoBLzFUeJMq2bUPrKroDNZm2Ow9sk75b+sMrXFmImGdPCKKmAo+hMwVkx?=
 =?us-ascii?Q?IF4P7pbQLDH1stcF9Gugt1Ts97vsgBjQw7/gMyOhv8I27O87SkVaye0mEShF?=
 =?us-ascii?Q?pcK4G4Pyu+7F7atwsN3LVFZXKuy6SrpNvZLa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:20.2124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23615e40-ad23-43ae-5dba-08ddf65359a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086
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

