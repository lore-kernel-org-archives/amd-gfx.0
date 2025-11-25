Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6754ED0E6F9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111B610E435;
	Tue, 25 Nov 2025 15:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KVBjPaRK";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEBAE10E42D
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oi82Q2dp0XACqXEVIsnrsg2AH5Kbti7E44V1/wUWTRavT/lnbEI/tNyqchydMmjF11gSBEiVknUu+7NhLuO8cKLmG19MxYf1OepdFRZUGD+o5CkLKvN5ac4d+Lw0Pwnv6a+tr1uqxhW1MLamBntiWZ3vX8F0EicSf+qLArPAHlenbIkdkl3XV9iGPPawdIyxlpH/9d7hz8V4Hr/G3aM/GEraoAju3k7ClL9O9FV2LePQVfGgHDwVMs2DnzVWGCSee2pjNyKXQnlYFdciIbql2LeOQ60LbTW6maRymeg0P71xb9L8F8y6KWl7ehe7HhAE8JXC3UYGq5sNF/jmA4Q69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ixqt12kCrC5WW5p5MFQ8DKSwzWFoaL1eu1apR0WBMRQ=;
 b=R18wMaKMNS026S4wGgrvQW/ucUmfFd7TI+Z5JV6a+VzyILPZi7+emoXeoq17BCY1oJ8joM5BB0Z48qjLs/kqADUaZwR1F9TIft7e93kcmOWhuDDW25OXg//jUHr/4hzDPdynE7VoHzSiCJfEqG/TxFLnkiyah2kU7FDFxhznQww7QYr5oCpIgpHZF0M5mfXn1MA4Cn3n3hgfyEwlDOZPcXjxe0FiiZioAWfdKXNCTNt4xZPvE+ac38dFzq/dA8KJIjHL4UjU3d9OFdI5SP8mj1xRNjdE/TMQvtHARVKW82xuPejlfzYo6GOCugtEi2TLE4/wX4NdrZ4XmTNCPUr7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixqt12kCrC5WW5p5MFQ8DKSwzWFoaL1eu1apR0WBMRQ=;
 b=KVBjPaRKBfnkFLGOX6InOMvdroTASm4njeN5vnqdbEsF8ARukI0RSzq35/G5DLpBr/bg1okC5/OaIWh6cGFHwG0MBZwJoVJkRY0AiFLtsOsOyPECQE5WRt9jKZLozMPzrUuSmjyOBOqHHgiQ8lNHg3n0FGj7Q/zThStSOkeRu6g=
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 15:08:33 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::61) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 15:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 15:08:33 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 09:08:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Add interrupt handling for GFX 12.1.0
Date: Tue, 25 Nov 2025 10:08:12 -0500
Message-ID: <20251125150812.2046438-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125150812.2046438-1-alexander.deucher@amd.com>
References: <20251125150812.2046438-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 65037695-92ac-4bc6-e1bd-08de2c348076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eaQUW4jxv22O/PuT2QlHEL2h45W6q64su4cGxlL4N8pNyxzO7QCFhtQ8NXo5?=
 =?us-ascii?Q?F1ezQixi0PDGzNK2KbgIZX8z0gZvIyug79qqyi/3BNfuJV7JP4G+Rl6WA5hn?=
 =?us-ascii?Q?SWbuzcXkB/ocV6GaDz5HCzPud3dOrnkfzEiE9YoSFKR/z1VAaXkYE3FRHh3j?=
 =?us-ascii?Q?JrF11U9o4KZ3KB64fy87gPGf/uKJu8FjB3PW6NU113eJkzUtU+HcCcuaaQAD?=
 =?us-ascii?Q?ORH3/lyNSFbaVyoCtEJ0DwhJrDRptP+JmYsKo81Muk8F6lWmtPnMBpWW5ZlE?=
 =?us-ascii?Q?gxxY8i/5Z4enaczqO+8rzM5EuDBnTKmNfcRVg0gubTPiorymhBaCiuCBsfU7?=
 =?us-ascii?Q?JqEMkAsHYSEuUd+YCrIWhlXmYcVGwCIHt6tlHTI8Kqb2/l08iZG1TPlq7S5Q?=
 =?us-ascii?Q?/GkJDnAsj1HWwuHNnGKAf1Nyomp2TQXl9HPbtD5bwyE2LF7KTqYULDP/bAVC?=
 =?us-ascii?Q?MzHAByqUl9J/RCNnXomLH1UbEeo6BYI/Eo8te6P82jjFMLPLkakPBzudOhDE?=
 =?us-ascii?Q?kISwHHRRJdYrxMiI6CmdoSKaOK/rw96g7JqrC38YQURt7pa+JspOtnzSWU4A?=
 =?us-ascii?Q?eh+mghTzMp1I7kEd386X+KpzVQW905cDljfj51H7OlDld4b3VntsxKJyFyga?=
 =?us-ascii?Q?Oz07Id/C/Kd9G1pkHRyYxkbZhfGHWvz63C+WZN4e41WHjyowXGaJcome4gf4?=
 =?us-ascii?Q?Z+69J4R0vkkBwU97Cd4WdaE16bx/YMFLm/WUb1Tq03cbBcvhklXWXYHY/otL?=
 =?us-ascii?Q?Y/KINQNBM/eEBvxRXXThcdUAkN9V6u9MRHoHeNcML3tP7NN+uaOqdOYT2oQ0?=
 =?us-ascii?Q?PldVgMqfBEEE80WZTqfWibqufSA8OESAEK3tW+fbhlyEMSJEGv77lJ12ZADi?=
 =?us-ascii?Q?VRb9CVizWlIN3whmMNgk9Ls6QeM3+1951LmLbiy9UrcEZnS1AXsBbzw56dre?=
 =?us-ascii?Q?/9iKhTzDkbPUd1OEO7P5h8tUeXQh9Pib2k9Gy8k+GT7dNtpeYN91r2Mlm1fV?=
 =?us-ascii?Q?a39quz39itj7y2Bh3qLUqTiJScVHzNnSW0BrOFN5JHygQ2TQns0Bxo3R1cTo?=
 =?us-ascii?Q?h0ZUHuJjZXBB9qEiIGge0YsNAk0kUTde/dEECQT/fLSMgSSnS6t2ka+bL0Kr?=
 =?us-ascii?Q?zx53RG9XOEEQxn9OLIDjx2AoYFwWs3NEB+lYt0mci2jxJ43l2Qd27qXdzNC4?=
 =?us-ascii?Q?a7SkFLlvn4IMONOWYyTBJVSqNvscNZAQ97O9kzI/jqjK+4OedDoZjsW+EjMn?=
 =?us-ascii?Q?k9eRqn+3JeO9t1fL3y8ajJh+9665MR1dR8eEgLDYHEzC1IfonekyHVRPo9Zh?=
 =?us-ascii?Q?HN/+kaVBquJ6ynwwS6OPH3CargX9+XswlDF6RkW65kY2UgR0l9xVWaPg3Gm+?=
 =?us-ascii?Q?LUHPd1wfniSmMs9cRAEFpVVpHYs3I6hNDzlMUimlQcB/3zNJXum9WgBLkN1O?=
 =?us-ascii?Q?g3FlB9gCmA25IXe2aBzT6DS7ckUO7htFm9o55U4Y/UB/h/WmfAIlKf8FqNmF?=
 =?us-ascii?Q?HvEVgHbcw5y4beDh59lwuzqKMm5ynl3Hn5pkPWZ6ssTvCiUQ9H4AmyxR3iHD?=
 =?us-ascii?Q?FLUn/CjM5PCtOvp57/g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:08:33.7961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65037695-92ac-4bc6-e1bd-08de2c348076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add interrupt handling for GFX 12.1.0 similar to what is done
for GFX 9.4.3.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile           |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  24 +-
 .../drm/amd/amdkfd/kfd_int_process_v12_1.c    | 391 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   3 +-
 5 files changed, 416 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index 382121e4a3e3d..85fc67d521e53 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -58,6 +58,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_int_process_v9.o \
 		$(AMDKFD_PATH)/kfd_int_process_v10.o \
 		$(AMDKFD_PATH)/kfd_int_process_v11.o \
+		$(AMDKFD_PATH)/kfd_int_process_v12_1.o \
 		$(AMDKFD_PATH)/kfd_smi_events.o \
 		$(AMDKFD_PATH)/kfd_crat.o \
 		$(AMDKFD_PATH)/kfd_debug.o
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 759b3cc814f95..c507a958196bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -171,6 +171,10 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 		/* GFX12_TODO: Change to v12 version. */
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
+	case IP_VERSION(12, 1, 0):
+		kfd->device_info.event_interrupt_class =
+						&event_interrupt_class_v12_1;
+		break;
 	default:
 		dev_warn(kfd_device, "v9 event interrupt handler is set due to "
 			"mismatch of gc ip block(GC_HWIP:0x%x).\n", gc_version);
@@ -667,6 +671,7 @@ static void kfd_setup_interrupt_bitmap(struct kfd_node *node,
 	struct amdgpu_device *adev = node->adev;
 	uint32_t xcc_mask = node->xcc_mask;
 	uint32_t xcc, mapped_xcc;
+	uint32_t bitmap;
 	/*
 	 * Interrupt bitmap is setup for processing interrupts from
 	 * different XCDs and AIDs.
@@ -688,9 +693,22 @@ static void kfd_setup_interrupt_bitmap(struct kfd_node *node,
 	 * - AND VMID reported in the interrupt lies within the
 	 *   VMID range of the node.
 	 */
-	for_each_inst(xcc, xcc_mask) {
-		mapped_xcc = GET_INST(GC, xcc);
-		node->interrupt_bitmap |= (mapped_xcc % 2 ? 5 : 3) << (4 * (mapped_xcc / 2));
+	switch (KFD_GC_VERSION(node)) {
+	case IP_VERSION(12, 1, 0):
+		for_each_inst(xcc, xcc_mask) {
+			mapped_xcc = GET_INST(GC, xcc);
+			bitmap = 0x2 | (0x4 << (mapped_xcc % 4));
+			if (mapped_xcc/4)
+				bitmap = bitmap << 8;
+			node->interrupt_bitmap |= bitmap;
+		}
+		break;
+	default:
+		for_each_inst(xcc, xcc_mask) {
+			mapped_xcc = GET_INST(GC, xcc);
+			node->interrupt_bitmap |= (mapped_xcc % 2 ? 5 : 3) << (4 * (mapped_xcc / 2));
+		}
+		break;
 	}
 	dev_info(kfd_device, "Node: %d, interrupt_bitmap: %x\n", kfd_node_idx,
 							node->interrupt_bitmap);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
new file mode 100644
index 0000000000000..230e57dbcec58
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v12_1.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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
+ */
+
+#include "kfd_priv.h"
+#include "kfd_events.h"
+#include "soc15_int.h"
+#include "kfd_device_queue_manager.h"
+#include "ivsrcid/vmc/irqsrcs_vmc_1_0.h"
+#include "kfd_smi_events.h"
+#include "kfd_debug.h"
+
+/*
+ * GFX12.1 SQ Interrupts
+ *
+ * There are 3 encoding types of interrupts sourced from SQ sent as a 44-bit
+ * packet to the Interrupt Handler:
+ * Auto - Generated by the SQG (various cmd overflows, timestamps etc)
+ * Wave - Generated by S_SENDMSG through a shader program
+ * Error - HW generated errors (Illegal instructions, Memviols, EDC etc)
+ *
+ * The 44-bit packet is mapped as {context_id1[7:0],context_id0[31:0]} plus
+ * 4-bits for VMID (SOC15_VMID_FROM_IH_ENTRY) as such:
+ *
+ * - context_id1[7:6]
+ * Encoding type (0 = Auto, 1 = Wave, 2 = Error)
+ *
+ * - context_id0[26]
+ * PRIV bit indicates that Wave S_SEND or error occurred within trap
+ *
+ * - context_id0[24:0]
+ * 25-bit data with the following layout per encoding type:
+ * Auto - only context_id0[8:0] is used, which reports various interrupts
+ * generated by SQG.  The rest is 0.
+ * Wave - user data sent from m0 via S_SENDMSG (context_id0[23:0])
+ * Error - Error Type (context_id0[24:21]), Error Details (context_id0[20:0])
+ *
+ * The other context_id bits show coordinates (SE/SH/CU/SIMD/WGP) for wave
+ * S_SENDMSG and Errors.  These are 0 for Auto.
+ */
+
+enum SQ_INTERRUPT_WORD_ENCODING {
+	SQ_INTERRUPT_WORD_ENCODING_AUTO = 0x0,
+	SQ_INTERRUPT_WORD_ENCODING_INST,
+	SQ_INTERRUPT_WORD_ENCODING_ERROR,
+};
+
+enum SQ_INTERRUPT_ERROR_TYPE {
+	SQ_INTERRUPT_ERROR_TYPE_EDC_FUE = 0x0,
+	SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST,
+	SQ_INTERRUPT_ERROR_TYPE_MEMVIOL,
+	SQ_INTERRUPT_ERROR_TYPE_EDC_FED,
+};
+
+/* SQ_INTERRUPT_WORD_AUTO_CTXID */
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE__SHIFT		0
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__WLT__SHIFT			1
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF0_FULL__SHIFT	2
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF1_FULL__SHIFT	3
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_UTC_ERROR__SHIFT	8
+#define SQ_INTERRUPT_WORD_AUTO_CTXID1__ENCODING__SHIFT			6
+
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_MASK		0x00000001
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__WLT_MASK				0x00000002
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF0_FULL_MASK	0x00000004
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF1_FULL_MASK	0x00000008
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_UTC_ERROR_MASK	0x00000100
+#define SQ_INTERRUPT_WORD_AUTO_CTXID1__ENCODING_MASK			0x000000c0
+
+/* SQ_INTERRUPT_WORD_WAVE_CTXID */
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__DATA__SHIFT	0
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__SA_ID__SHIFT	25
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__PRIV__SHIFT	26
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__WAVE_ID__SHIFT	27
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__SIMD_ID__SHIFT	0
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__WGP_ID__SHIFT	2
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__ENCODING__SHIFT	6
+
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__DATA_MASK	0x00ffffff /* [23:0] */
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__SA_ID_MASK	0x02000000 /* [25] */
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__PRIV_MASK	0x04000000 /* [26] */
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__WAVE_ID_MASK	0xf8000000 /* [31:27] */
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__SIMD_ID_MASK	0x00000003 /* [33:32] */
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__WGP_ID_MASK	0x0000003c /* [37:34] */
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__ENCODING_MASK	0x000000c0 /* [39:38] */
+
+/* SQ_INTERRUPT_WORD_ERROR_CTXID */
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__DETAIL__SHIFT	0
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__MEM_VIOL__SHIFT	19
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__TYPE__SHIFT	21
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__SA_ID__SHIFT	25
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__PRIV__SHIFT	26
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__WAVE_ID__SHIFT	27
+#define SQ_INTERRUPT_WORD_ERROR_CTXID1__SIMD_ID__SHIFT	0
+#define SQ_INTERRUPT_WORD_ERROR_CTXID1__WGP_ID__SHIFT	2
+#define SQ_INTERRUPT_WORD_ERROR_CTXID1__ENCODING__SHIFT	6
+
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__DETAIL_MASK	0x0007ffff /* [18:0] */
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__MEM_VIOL_MASK	0x00180000 /* [20:19] */
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__TYPE_MASK	0x01e00000 /* [24:21] */
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__SA_ID_MASK	0x02000000 /* [25] */
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__PRIV_MASK	0x04000000 /* [26] */
+#define SQ_INTERRUPT_WORD_ERROR_CTXID0__WAVE_ID_MASK	0xf8000000 /* [31:27] */
+#define SQ_INTERRUPT_WORD_ERROR_CTXID1__SIMD_ID_MASK	0x00000003 /* [33:32] */
+#define SQ_INTERRUPT_WORD_ERROR_CTXID1__WGP_ID_MASK	0x0000003c /* [37:34] */
+#define SQ_INTERRUPT_WORD_ERROR_CTXID1__ENCODING_MASK	0x000000c0 /* [39:38] */
+
+/*
+ * The debugger will send user data(m0) with PRIV=1 to indicate it requires
+ * notification from the KFD with the following queue id (DOORBELL_ID) and
+ * trap code (TRAP_CODE).
+ */
+#define KFD_CTXID0_TRAP_CODE_SHIFT	10
+#define KFD_CTXID0_TRAP_CODE_MASK	0xfffc00
+#define KFD_CTXID0_CP_BAD_OP_ECODE_MASK	0x3ffffff
+#define KFD_CTXID0_DOORBELL_ID_MASK	0x0003ff
+
+#define KFD_CTXID0_TRAP_CODE(ctxid0)		(((ctxid0) &  \
+				KFD_CTXID0_TRAP_CODE_MASK) >> \
+				KFD_CTXID0_TRAP_CODE_SHIFT)
+#define KFD_CTXID0_CP_BAD_OP_ECODE(ctxid0)	(((ctxid0) &        \
+				KFD_CTXID0_CP_BAD_OP_ECODE_MASK) >> \
+				KFD_CTXID0_TRAP_CODE_SHIFT)
+#define KFD_CTXID0_DOORBELL_ID(ctxid0)		((ctxid0) & \
+				KFD_CTXID0_DOORBELL_ID_MASK)
+
+static void print_sq_intr_info_auto(uint32_t context_id0, uint32_t context_id1)
+{
+	pr_debug_ratelimited(
+		"sq_intr: auto, ttrace %d, wlt %d, ttrace_buf0_full %d, ttrace_buf1_full %d ttrace_utc_err %d\n",
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, THREAD_TRACE),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, WLT),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, THREAD_TRACE_BUF0_FULL),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, THREAD_TRACE_BUF1_FULL),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0, THREAD_TRACE_UTC_ERROR));
+}
+
+static void print_sq_intr_info_inst(uint32_t context_id0, uint32_t context_id1)
+{
+	pr_debug_ratelimited(
+		"sq_intr: inst, data 0x%08x, sh %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, DATA),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, SA_ID),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0, WAVE_ID),
+		REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1, SIMD_ID),
+		REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1, WGP_ID));
+}
+
+static void print_sq_intr_info_error(uint32_t context_id0, uint32_t context_id1)
+{
+	pr_debug_ratelimited(
+		"sq_intr: error, detail 0x%08x, type %d, sh %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, DETAIL),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, TYPE),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, SA_ID),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, PRIV),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID0, WAVE_ID),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1, SIMD_ID),
+		REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_ERROR_CTXID1, WGP_ID));
+}
+
+static void event_interrupt_poison_consumption_v12_1(struct kfd_node *node,
+				uint16_t pasid, uint16_t source_id)
+{
+	enum amdgpu_ras_block block = 0;
+	int ret = -EINVAL;
+	uint32_t reset = 0;
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
+
+	if (!p)
+		return;
+
+	/* all queues of a process will be unmapped in one time */
+	if (atomic_read(&p->poison)) {
+		kfd_unref_process(p);
+		return;
+	}
+
+	atomic_set(&p->poison, 1);
+	kfd_unref_process(p);
+
+	switch (source_id) {
+	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
+		if (node->dqm->ops.reset_queues)
+			ret = node->dqm->ops.reset_queues(node->dqm, pasid);
+		block = AMDGPU_RAS_BLOCK__GFX;
+		if (ret)
+			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		break;
+	case SOC21_INTSRC_SDMA_ECC:
+	default:
+		block = AMDGPU_RAS_BLOCK__GFX;
+		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		break;
+	}
+
+	kfd_signal_poison_consumed_event(node, pasid);
+
+	/*
+	 * resetting queue passes, do page retirement without gpu reset
+	 * resetting queue fails, fallback to gpu reset solution
+	 */
+	amdgpu_amdkfd_ras_poison_consumption_handler(node->adev, block, reset);
+}
+
+static bool event_interrupt_isr_v12_1(struct kfd_node *node,
+					const uint32_t *ih_ring_entry,
+					uint32_t *patched_ihre,
+					bool *patched_flag)
+{
+	uint16_t source_id, client_id, pasid, vmid, node_id;
+	const uint32_t *data = ih_ring_entry;
+	uint32_t context_id0;
+
+	node_id = SOC15_NODEID_FROM_IH_ENTRY(ih_ring_entry);
+	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
+
+	if (!kfd_irq_is_from_node(node, node_id, vmid)) {
+		pr_debug("Interrupt not for Node, node_id: %d, vmid: %d\n", node_id, vmid);
+		return false;
+	}
+
+	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
+
+	/* Only handle interrupts from KFD VMIDs */
+	if (!KFD_IRQ_IS_FENCE(client_id, source_id) &&
+	    (vmid < node->vm_info.first_vmid_kfd ||
+	    vmid > node->vm_info.last_vmid_kfd))
+		return false;
+
+	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
+	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
+
+	if ((source_id == SOC15_INTSRC_CP_END_OF_PIPE) &&
+	    (context_id0 & AMDGPU_FENCE_MES_QUEUE_FLAG))
+		return false;
+
+	pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
+		 client_id, source_id, vmid, pasid);
+	pr_debug("%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
+		 data[0], data[1], data[2], data[3],
+		 data[4], data[5], data[6], data[7]);
+
+	/* If there is no valid PASID, it's likely a bug */
+	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
+		return false;
+
+	/* Interrupt types we care about: various signals and faults.
+	 * They will be forwarded to a work queue (see below).
+	 */
+	return source_id == SOC15_INTSRC_CP_END_OF_PIPE ||
+		source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG ||
+		source_id == SOC15_INTSRC_CP_BAD_OPCODE ||
+		source_id == SOC21_INTSRC_SDMA_TRAP ||
+		KFD_IRQ_IS_FENCE(client_id, source_id) ||
+		((client_id == SOC21_IH_CLIENTID_VMC ||
+		 client_id == SOC21_IH_CLIENTID_UTCL2) &&
+		  !amdgpu_no_queue_eviction_on_vm_fault);
+}
+
+static void event_interrupt_wq_v12_1(struct kfd_node *node,
+					const uint32_t *ih_ring_entry)
+{
+	uint16_t source_id, client_id, ring_id, pasid, vmid;
+	uint32_t context_id0, context_id1;
+	uint8_t sq_int_enc, sq_int_priv, sq_int_errtype;
+	struct kfd_vm_fault_info info = {0};
+	struct kfd_hsa_memory_exception_data exception_data;
+
+	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
+	ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
+	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
+	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
+	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
+	context_id1 = SOC15_CONTEXT_ID1_FROM_IH_ENTRY(ih_ring_entry);
+
+	/* VMC, UTCL2 */
+	if (client_id == SOC21_IH_CLIENTID_VMC ||
+	    client_id == SOC21_IH_CLIENTID_UTCL2) {
+		info.vmid = vmid;
+		info.mc_id = client_id;
+		info.page_addr = ih_ring_entry[4] |
+			(uint64_t)(ih_ring_entry[5] & 0xf) << 32;
+		info.prot_valid = ring_id & 0x08;
+		info.prot_read  = ring_id & 0x10;
+		info.prot_write = ring_id & 0x20;
+
+		memset(&exception_data, 0, sizeof(exception_data));
+		exception_data.gpu_id = node->id;
+		exception_data.va = (info.page_addr) << PAGE_SHIFT;
+		exception_data.failure.NotPresent = info.prot_valid ? 1 : 0;
+		exception_data.failure.NoExecute = info.prot_exec ? 1 : 0;
+		exception_data.failure.ReadOnly = info.prot_write ? 1 : 0;
+		exception_data.failure.imprecise = 0;
+
+		kfd_set_dbg_ev_from_interrupt(node, pasid, -1,
+					      KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION),
+					      &exception_data, sizeof(exception_data));
+		kfd_smi_event_update_vmfault(node, pasid);
+
+	/* GRBM, SDMA, SE, PMM */
+	} else if (client_id == SOC21_IH_CLIENTID_GRBM_CP ||
+		   client_id == SOC21_IH_CLIENTID_GFX) {
+
+		/* CP */
+		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
+			kfd_signal_event_interrupt(pasid, context_id0, 32);
+		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
+			 KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0))) {
+			u32 doorbell_id = KFD_CTXID0_DOORBELL_ID(context_id0);
+
+			kfd_set_dbg_ev_from_interrupt(node, pasid, doorbell_id,
+				KFD_EC_MASK(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)),
+				NULL, 0);
+			kfd_dqm_suspend_bad_queue_mes(node, pasid, doorbell_id);
+		}
+
+		/* SDMA */
+		else if (source_id == SOC21_INTSRC_SDMA_TRAP)
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
+		else if (source_id == SOC21_INTSRC_SDMA_ECC) {
+			event_interrupt_poison_consumption_v12_1(node, pasid, source_id);
+			return;
+		}
+
+		/* SQ */
+		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG) {
+			sq_int_enc = REG_GET_FIELD(context_id1,
+					SQ_INTERRUPT_WORD_WAVE_CTXID1, ENCODING);
+			switch (sq_int_enc) {
+			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
+				print_sq_intr_info_auto(context_id0, context_id1);
+				break;
+			case SQ_INTERRUPT_WORD_ENCODING_INST:
+				print_sq_intr_info_inst(context_id0, context_id1);
+				sq_int_priv = REG_GET_FIELD(context_id0,
+						SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
+				if (sq_int_priv && (kfd_set_dbg_ev_from_interrupt(node, pasid,
+						KFD_CTXID0_DOORBELL_ID(context_id0),
+						KFD_CTXID0_TRAP_CODE(context_id0),
+						NULL, 0)))
+					return;
+				break;
+			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
+				print_sq_intr_info_error(context_id0, context_id1);
+				sq_int_errtype = REG_GET_FIELD(context_id0,
+						SQ_INTERRUPT_WORD_ERROR_CTXID0, TYPE);
+				if (sq_int_errtype != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
+				    sq_int_errtype != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
+					event_interrupt_poison_consumption_v12_1(
+							node, pasid, source_id);
+					return;
+				}
+				break;
+			default:
+				break;
+			}
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24);
+		}
+
+	} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
+		kfd_process_close_interrupt_drain(pasid);
+	}
+}
+
+const struct kfd_event_interrupt_class event_interrupt_class_v12_1 = {
+	.interrupt_isr = event_interrupt_isr_v12_1,
+	.interrupt_wq = event_interrupt_wq_v12_1,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ee54f1ea1516d..0e3bae6ac356d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1497,6 +1497,7 @@ extern const struct kfd_event_interrupt_class event_interrupt_class_v9;
 extern const struct kfd_event_interrupt_class event_interrupt_class_v9_4_3;
 extern const struct kfd_event_interrupt_class event_interrupt_class_v10;
 extern const struct kfd_event_interrupt_class event_interrupt_class_v11;
+extern const struct kfd_event_interrupt_class event_interrupt_class_v12_1;
 
 extern const struct kfd_device_global_init_class device_global_init_class_cik;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f5d173f1ca3b5..578c5a4937a7c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2180,7 +2180,8 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 	 */
 	if (KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 4, 3) ||
 	    KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 4, 4) ||
-	    KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 5, 0)) {
+	    KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(9, 5, 0) ||
+	    KFD_GC_VERSION(pdd->dev->kfd) == IP_VERSION(12, 1, 0)) {
 		node_id = ffs(pdd->dev->interrupt_bitmap) - 1;
 		irq_drain_fence[3] |= node_id << 16;
 	}
-- 
2.51.1

