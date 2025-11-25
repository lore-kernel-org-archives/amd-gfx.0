Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7E7D0E6EC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 15:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD5B10E42F;
	Tue, 25 Nov 2025 15:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XqL6ECuT";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB56210E42A
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 15:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhzXvkZgl7McJqy0O1fgKSsmJJPpd2AJl4Nk67S2MYTAs7D8Vybn/DO5NVkOC6AldCr5KkgbPLbd2X7TDuLiTc7veBNOhCy7mYx7gB+Kp1M9CWeIjVE4UhJO/bDYPVEWhRgajzsCJs74pAZt+mAZKGSa8wrvGbn4NFrzzZ5oMHmqKObJ+ec7KqZd5ccJxJv78L2g7TAyAjloC2Z7PRj3ZbqzBppfbmEOjMeS7iTb6h4S3bmFHol7c4Iy71MUorZZbu60LMGP2sobCcTEu3IpsVASR4wKo81SE/qK8+9fL2p19opmtUloNdHMyRFTBHe9ZZBnU9Grc5pE/ktnFYg/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+01PwGw9XZwur8t/dHI1I2JzB6mY+J+pYBICW0vpru4=;
 b=JNvd/YETGR7Dtv3WbKpVie+U0oJo+X42Xk2gksqlgGkeWWunxCkh/5S/CCeiwMa0RTgbbZSbIKe1CRLz6QFEbq2xXX+7QI+pS7/3p7ufXaW+oPvmFisuFBaV6oLrKxyaLA5wFnJdJzMgqKDe83CO7bFlOQRFC6ar/7JXDYEICsrfkUYqBLfqT2A/LKv9TdymZvpAt17+3xRe9PtlXB+SaJk7OEVt0zIJFEOYLCKt4HpuCrcNOwhwAh0t9FE70+gGXXbTbtoYPx6UXGBRRPrdJoZajAmClidrOtBOWW2pMOC7/73i2QwU4FT8kGhkb8aRez/4IO/foApAhTSNbOistg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+01PwGw9XZwur8t/dHI1I2JzB6mY+J+pYBICW0vpru4=;
 b=XqL6ECuTSWS5QF58pNGcbjDNqSHD9H02HVjjcGyl0smPTNUbquarJVmvQVrxX81OEQKJsvRMhLy1sggBZZeg9vxZ8nYkpDlzOc4c7IBZBzJFEi4mFyNuvC/Vw6fmZyrGbHc5J9mVx6yVXw0+BYl3hgZcAx2kGQETNfqs85p8buM=
Received: from BN1PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:e0::6)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 15:08:33 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::70) by BN1PR10CA0001.outlook.office365.com
 (2603:10b6:408:e0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 15:07:57 +0000
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
 2025 09:08:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Sierra <alex.sierra@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Add MQD manager for GFX 12.1.0
Date: Tue, 25 Nov 2025 10:08:11 -0500
Message-ID: <20251125150812.2046438-7-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: 35546405-fe87-43a8-b70c-08de2c34802d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c90D5fmWVgFjwJAD0S1diSacxaVR3OswClOIhT1dEEC43YZWBCIbUmILvD0Q?=
 =?us-ascii?Q?GEBiF6TT5F1DI3vfC9SC3Xl7DM9usYHDgZ2Neh68fTxL5PyPvh/lrhrESxbW?=
 =?us-ascii?Q?tLuaKHc2e7WZQvjT5+obK6J35uZwtImPhGOGp7bbftWEWmHQIO4ufbXiDuRI?=
 =?us-ascii?Q?AC9fthQvnH5mlT6OhlMTTxx44TaVw9IIOK8u/lccasKt5FpAxUask/pzbu/z?=
 =?us-ascii?Q?vYIGVDfQ80ubmH9XbouS/DTV60vLiZVETt0INBF6stTc2Cg4RM5mn89HsuYR?=
 =?us-ascii?Q?He42wGTO/T9WrOjisL3DtjmVyaRfTK2nkBsgcoIddNfZI84x8ZOxGXami+7K?=
 =?us-ascii?Q?9jf3Hik2YEiVH03RE6fJgqU3yIg6bK4KcKSGrzi7SmBKtSnM39OUms9L6Qzr?=
 =?us-ascii?Q?YfYFBtb+HSSvZNlstZDXmzHGpZ1M5/uhL9sUUUNdCkNByVfBRYdE4s6KNEQR?=
 =?us-ascii?Q?1bMdaQawwnp0UQ/fG7231gNecdRwq4zka2TkRummDuyX3KBpSWnsGgvS8Vap?=
 =?us-ascii?Q?Y+hFFo0C/y/+SVoywnFt611OoGQUcFnZTbfObWjnpmMiYRkF707IOc7hnzP1?=
 =?us-ascii?Q?xPZWTzvD6tKdbzjGCWJUUNHgGyIYecXnb6OTTV+RUaFXaO9VqIzHSr4ZFHsW?=
 =?us-ascii?Q?eIti5Pzp6v+uvVG+jo0H+S+y4SOiyuPdrDdXKLjbPlExIu7WdAHWvVZJksU9?=
 =?us-ascii?Q?/OGeT4DeFk3Z9GGzgw/3B/6MbfXNY85FpupHknd1YZJWE4lzmpiNannFAD4T?=
 =?us-ascii?Q?3ohvS3+4mB/GqScztrxtZGeG4E1JjmqsSRqOgemLRxbkYJBT/53uCdhTV4qR?=
 =?us-ascii?Q?8irPW6Bzq7PNnD9K7YXKcIIzCepG50b64AaV4qqCze1c4m61fpqHdcLI/zpY?=
 =?us-ascii?Q?oqxalmV1aWVb8ok75prBl5ZQ6UXzDGRgrmpnJTi2JeSIvtc2gLP1phU/2UhI?=
 =?us-ascii?Q?bb8IViShhf1FmaAg7JRF0yEHD3E9wDFdpgFxj9U4gGMC/SY9Vc7EKRmQhxjE?=
 =?us-ascii?Q?wnFnYo3eZwZWADEF/HX6UefGi0AJWx2J0XRfjOwCnVkI2kBQTlMW5PrqjKWJ?=
 =?us-ascii?Q?lWx6VazCCwbZ8Duw0KEMSjyzXoRjypMd2uQAHpwcNfYXk2uSJTtqEFBvfDJi?=
 =?us-ascii?Q?Kz+AGkvJo/h+FxqBzWKYmrV6pbcl+vFWVLSw5RpeeCdRknif3MnNwEYj71vG?=
 =?us-ascii?Q?p1HaPjeVfOCplQp7alqpYWEB/bXFxdMryD4KL5JAB0Dk7WLa40THkwPZ3hHO?=
 =?us-ascii?Q?lQfmCCxym5ORorMgsiJoY/H3yuEdUYrhwzb6V60KrgTESgM+TfSvMZTMd2Zo?=
 =?us-ascii?Q?u/8J3PDb9OliTmbLqu3XZiwF7UpXc1q8S5G/HGhVz5N4u8OnBTZHQBfSIWfF?=
 =?us-ascii?Q?L3cKqezqh2QDDFcG8uaTfxad0iKQYY71I0uNWUlNHSrUi+WbtGBnlxV1YVS4?=
 =?us-ascii?Q?JBig1FLWB+uE2TyQD2QDLwZlCX73efh1M25obT1QJ40CA9DtZS411UhWQSVq?=
 =?us-ascii?Q?EVIyFnAbay1Ml3CZGOXIEyjoIu3gM56kcmiHRiV67Uu7nXTxJZpRzJR++vHW?=
 =?us-ascii?Q?PfQO6yymGaRPx8BzuiU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 15:08:33.3160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35546405-fe87-43a8-b70c-08de2c34802d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
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

This patch adds the following functionality for GFX 12.1.0:
1. Add a new MQD manager for GFX v12.1.0.
2. Add a new 12.1.0 specific device queue manager file.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Sierra <alex.sierra@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile           |   2 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   4 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   2 +
 .../amdkfd/kfd_device_queue_manager_v12_1.c   |  90 +++
 .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 657 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +
 6 files changed, 756 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index 0ce08113c9f0b..382121e4a3e3d 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -38,6 +38,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_mqd_manager_v10.o \
 		$(AMDKFD_PATH)/kfd_mqd_manager_v11.o \
 		$(AMDKFD_PATH)/kfd_mqd_manager_v12.o \
+		$(AMDKFD_PATH)/kfd_mqd_manager_v12_1.o \
 		$(AMDKFD_PATH)/kfd_kernel_queue.o \
 		$(AMDKFD_PATH)/kfd_packet_manager.o \
 		$(AMDKFD_PATH)/kfd_packet_manager_vi.o \
@@ -50,6 +51,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_device_queue_manager_v10.o \
 		$(AMDKFD_PATH)/kfd_device_queue_manager_v11.o \
 		$(AMDKFD_PATH)/kfd_device_queue_manager_v12.o \
+		$(AMDKFD_PATH)/kfd_device_queue_manager_v12_1.o \
 		$(AMDKFD_PATH)/kfd_interrupt.o \
 		$(AMDKFD_PATH)/kfd_events.o \
 		$(AMDKFD_PATH)/cik_event_interrupt.o \
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d701c66179cfc..2f29163f90d68 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3009,7 +3009,9 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		break;
 
 	default:
-		if (KFD_GC_VERSION(dev) >= IP_VERSION(12, 0, 0))
+		if (KFD_GC_VERSION(dev) >= IP_VERSION(12, 1, 0))
+			device_queue_manager_init_v12_1(&dqm->asic_ops);
+		else if (KFD_GC_VERSION(dev) >= IP_VERSION(12, 0, 0))
 			device_queue_manager_init_v12(&dqm->asic_ops);
 		else if (KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0))
 			device_queue_manager_init_v11(&dqm->asic_ops);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 74a61b5b2f0b4..ef07e44916f80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -299,6 +299,8 @@ void device_queue_manager_init_v11(
 		struct device_queue_manager_asic_ops *asic_ops);
 void device_queue_manager_init_v12(
 		struct device_queue_manager_asic_ops *asic_ops);
+void device_queue_manager_init_v12_1(
+		struct device_queue_manager_asic_ops *asic_ops);
 void program_sh_mem_settings(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd);
 unsigned int get_cp_queues_num(struct device_queue_manager *dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
new file mode 100644
index 0000000000000..db7675c1498de
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
@@ -0,0 +1,90 @@
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
+ *
+ */
+
+#include "kfd_device_queue_manager.h"
+#include "gc/gc_12_1_0_sh_mask.h"
+#include "soc24_enum.h"
+
+static int update_qpd_v12_1(struct device_queue_manager *dqm,
+			 struct qcm_process_device *qpd);
+static void init_sdma_vm_v12_1(struct device_queue_manager *dqm, struct queue *q,
+			    struct qcm_process_device *qpd);
+
+void device_queue_manager_init_v12_1(
+	struct device_queue_manager_asic_ops *asic_ops)
+{
+	asic_ops->update_qpd = update_qpd_v12_1;
+	asic_ops->init_sdma_vm = init_sdma_vm_v12_1;
+	asic_ops->mqd_manager_init = mqd_manager_init_v12_1;
+}
+
+static uint32_t compute_sh_mem_bases_64bit(struct kfd_process_device *pdd)
+{
+	uint32_t shared_base = pdd->lds_base >> 48;
+	uint32_t private_base = pdd->scratch_base >> 58;
+
+	return (shared_base << SH_MEM_BASES__SHARED_BASE__SHIFT) |
+		(private_base << SH_MEM_BASES__PRIVATE_BASE__SHIFT);
+}
+
+static int update_qpd_v12_1(struct device_queue_manager *dqm,
+			 struct qcm_process_device *qpd)
+{
+	struct kfd_process_device *pdd;
+
+	pdd = qpd_to_pdd(qpd);
+
+	/* check if sh_mem_config register already configured */
+	if (qpd->sh_mem_config == 0) {
+		qpd->sh_mem_config =
+			(SH_MEM_ALIGNMENT_MODE_UNALIGNED <<
+				SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) |
+			(3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT);
+
+		qpd->sh_mem_config |=
+			(1 << SH_MEM_CONFIG__F8_MODE__SHIFT);
+		qpd->sh_mem_ape1_limit = 0;
+		qpd->sh_mem_ape1_base = 0;
+	}
+
+	if (KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev)) {
+		if (!pdd->process->xnack_enabled)
+			qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+		else
+			qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
+	}
+
+	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
+
+	pr_debug("sh_mem_bases 0x%X\n", qpd->sh_mem_bases);
+
+	return 0;
+}
+
+static void init_sdma_vm_v12_1(struct device_queue_manager *dqm, struct queue *q,
+			    struct qcm_process_device *qpd)
+{
+	/* Not needed on SDMAv4 onwards any more */
+	q->properties.sdma_vm_addr = 0;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
new file mode 100644
index 0000000000000..06ecc86fcb4c3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -0,0 +1,657 @@
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
+ *
+ */
+
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include "kfd_priv.h"
+#include "kfd_mqd_manager.h"
+#include "v12_structs.h"
+#include "gc/gc_12_1_0_sh_mask.h"
+#include "amdgpu_amdkfd.h"
+#include "kfd_device_queue_manager.h"
+
+#define MQD_SIZE	(2 * PAGE_SIZE)
+
+static uint64_t mqd_stride_v12_1(struct mqd_manager *mm,
+				struct queue_properties *q)
+{
+	if (q->type == KFD_QUEUE_TYPE_COMPUTE)
+		return MQD_SIZE;
+	else
+		return PAGE_SIZE;
+}
+
+static inline struct v12_1_compute_mqd *get_mqd(void *mqd)
+{
+	return (struct v12_1_compute_mqd *)mqd;
+}
+
+static inline struct v12_sdma_mqd *get_sdma_mqd(void *mqd)
+{
+	return (struct v12_sdma_mqd *)mqd;
+}
+
+static void update_cu_mask(struct mqd_manager *mm, void *mqd,
+			   struct mqd_update_info *minfo, uint32_t inst)
+{
+	struct v12_1_compute_mqd *m;
+	uint32_t se_mask[KFD_MAX_NUM_SE] = {0};
+
+	if (!minfo || !minfo->cu_mask.ptr)
+		return;
+
+	mqd_symmetrically_map_cu_mask(mm,
+		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, inst);
+
+	m = get_mqd(mqd);
+	m->compute_static_thread_mgmt_se0 = se_mask[0];
+	m->compute_static_thread_mgmt_se1 = se_mask[1];
+	m->compute_static_thread_mgmt_se2 = se_mask[2];
+	m->compute_static_thread_mgmt_se3 = se_mask[3];
+	m->compute_static_thread_mgmt_se4 = se_mask[4];
+	m->compute_static_thread_mgmt_se5 = se_mask[5];
+	m->compute_static_thread_mgmt_se6 = se_mask[6];
+	m->compute_static_thread_mgmt_se7 = se_mask[7];
+
+	pr_debug("update cu mask to %#x %#x %#x %#x %#x %#x %#x %#x\n",
+		m->compute_static_thread_mgmt_se0,
+		m->compute_static_thread_mgmt_se1,
+		m->compute_static_thread_mgmt_se2,
+		m->compute_static_thread_mgmt_se3,
+		m->compute_static_thread_mgmt_se4,
+		m->compute_static_thread_mgmt_se5,
+		m->compute_static_thread_mgmt_se6,
+		m->compute_static_thread_mgmt_se7);
+}
+
+static void set_priority(struct v12_1_compute_mqd *m, struct queue_properties *q)
+{
+	m->cp_hqd_pipe_priority = pipe_priority_map[q->priority];
+	m->cp_hqd_queue_priority = q->priority;
+}
+
+static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
+		struct queue_properties *q)
+{
+	struct kfd_mem_obj *mqd_mem_obj;
+	unsigned int size;
+
+	/*
+	 * Allocate two PAGE_SIZE memory for Compute MQD as MES writes to areas beyond
+	 * struct MQD size. Size of the Compute MQD is 1 PAGE_SIZE.
+	 * For SDMA MQD, we allocate 1 Page_size.
+	 */
+	if (q->type == KFD_QUEUE_TYPE_COMPUTE)
+		size = MQD_SIZE * NUM_XCC(node->xcc_mask);
+	else
+		size = PAGE_SIZE;
+
+	if (kfd_gtt_sa_allocate(node, size, &mqd_mem_obj))
+		return NULL;
+
+	return mqd_mem_obj;
+}
+
+static void init_mqd(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *q)
+{
+	uint64_t addr;
+	struct v12_1_compute_mqd *m;
+
+	m = (struct v12_1_compute_mqd *) mqd_mem_obj->cpu_ptr;
+	addr = mqd_mem_obj->gpu_addr;
+
+	memset(m, 0, MQD_SIZE);
+
+	m->header = 0xC0310800;
+	m->compute_pipelinestat_enable = 1;
+	m->compute_static_thread_mgmt_se0 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se1 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se2 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se3 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se4 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se5 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se6 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se7 = 0xFFFFFFFF;
+	m->compute_static_thread_mgmt_se8 = 0xFFFFFFFF;
+
+	m->cp_hqd_persistent_state = CP_HQD_PERSISTENT_STATE__PRELOAD_REQ_MASK |
+			0x63 << CP_HQD_PERSISTENT_STATE__PRELOAD_SIZE__SHIFT;
+
+	m->cp_mqd_control = 1 << CP_MQD_CONTROL__PRIV_STATE__SHIFT;
+
+	m->cp_mqd_base_addr_lo	= lower_32_bits(addr);
+	m->cp_mqd_base_addr_hi	= upper_32_bits(addr);
+
+	m->cp_hqd_quantum = 1 << CP_HQD_QUANTUM__QUANTUM_EN__SHIFT |
+			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
+			1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
+
+	/* Set cp_hqd_hq_status0.c_queue_debug_en to 1 to have the CP set up the
+	 * DISPATCH_PTR.  This is required for the kfd debugger
+	 */
+	m->cp_hqd_hq_status0 = 1 << 14;
+
+	if (amdgpu_amdkfd_have_atomics_support(mm->dev->adev))
+		m->cp_hqd_hq_status0 |= 1 << 29;
+
+	if (q->format == KFD_QUEUE_FORMAT_AQL) {
+		m->cp_hqd_aql_control =
+			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
+	}
+
+	if (mm->dev->kfd->cwsr_enabled) {
+		m->cp_hqd_persistent_state |=
+			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
+		m->cp_hqd_ctx_save_base_addr_lo =
+			lower_32_bits(q->ctx_save_restore_area_address);
+		m->cp_hqd_ctx_save_base_addr_hi =
+			upper_32_bits(q->ctx_save_restore_area_address);
+		m->cp_hqd_ctx_save_size = q->ctx_save_restore_area_size;
+		m->cp_hqd_cntl_stack_size = q->ctl_stack_size;
+		m->cp_hqd_cntl_stack_offset = q->ctl_stack_size;
+		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
+	}
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = addr;
+	mm->update_mqd(mm, m, q, NULL);
+}
+
+static int load_mqd(struct mqd_manager *mm, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			struct queue_properties *p, struct mm_struct *mms)
+{
+	int r = 0;
+	/* AQL write pointer counts in 64B packets, PM4/CP counts in dwords. */
+	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
+
+	r = mm->dev->kfd2kgd->hqd_load(mm->dev->adev, mqd, pipe_id, queue_id,
+					  (uint32_t __user *)p->write_ptr,
+					  wptr_shift, 0, mms, 0);
+	return r;
+}
+
+static void update_mqd(struct mqd_manager *mm, void *mqd,
+		       struct queue_properties *q,
+		       struct mqd_update_info *minfo)
+{
+	struct v12_1_compute_mqd *m;
+
+	m = get_mqd(mqd);
+
+	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
+	m->cp_hqd_pq_control |=
+			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
+	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
+
+	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
+	m->cp_hqd_pq_base_hi = upper_32_bits((uint64_t)q->queue_address >> 8);
+
+	m->cp_hqd_pq_rptr_report_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
+	m->cp_hqd_pq_rptr_report_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
+	m->cp_hqd_pq_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
+	m->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
+
+	m->cp_hqd_pq_doorbell_control =
+		q->doorbell_off <<
+			CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+	pr_debug("cp_hqd_pq_doorbell_control 0x%x\n",
+			m->cp_hqd_pq_doorbell_control);
+
+	m->cp_hqd_ib_control = 1 << CP_HQD_IB_CONTROL__MIN_IB_AVAIL_SIZE__SHIFT;
+
+	/*
+	 * HW does not clamp this field correctly. Maximum EOP queue size
+	 * is constrained by per-SE EOP done signal count, which is 8-bit.
+	 * Limit is 0xFF EOP entries (= 0x7F8 dwords). CP will not submit
+	 * more than (EOP entry count - 1) so a queue size of 0x800 dwords
+	 * is safe, giving a maximum field value of 0xA.
+	 */
+	m->cp_hqd_eop_control = min(0xA,
+		ffs(q->eop_ring_buffer_size / sizeof(unsigned int)) - 1 - 1);
+	m->cp_hqd_eop_base_addr_lo =
+			lower_32_bits(q->eop_ring_buffer_address >> 8);
+	m->cp_hqd_eop_base_addr_hi =
+			upper_32_bits(q->eop_ring_buffer_address >> 8);
+
+	m->cp_hqd_iq_timer = 0;
+
+	m->cp_hqd_vmid = q->vmid;
+
+	if (q->format == KFD_QUEUE_FORMAT_AQL) {
+		/* GC 10 removed WPP_CLAMP from PQ Control */
+		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
+				2 << CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
+				1 << CP_HQD_PQ_CONTROL__QUEUE_FULL_EN__SHIFT;
+		m->cp_hqd_pq_doorbell_control |=
+			1 << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_BIF_DROP__SHIFT;
+	}
+	if (mm->dev->kfd->cwsr_enabled)
+		m->cp_hqd_ctx_save_control = 0;
+
+	set_priority(m, q);
+
+	q->is_active = QUEUE_IS_ACTIVE(*q);
+}
+
+static bool check_preemption_failed(struct mqd_manager *mm, void *mqd)
+{
+	return false;
+}
+
+static int get_wave_state(struct mqd_manager *mm, void *mqd,
+			  struct queue_properties *q,
+			  void __user *ctl_stack,
+			  u32 *ctl_stack_used_size,
+			  u32 *save_area_used_size)
+{
+	struct v12_1_compute_mqd *m;
+	struct mqd_user_context_save_area_header header;
+
+	m = get_mqd(mqd);
+
+	/* Control stack is written backwards, while workgroup context data
+	 * is written forwards. Both starts from m->cp_hqd_cntl_stack_size.
+	 * Current position is at m->cp_hqd_cntl_stack_offset and
+	 * m->cp_hqd_wg_state_offset, respectively.
+	 */
+	*ctl_stack_used_size = m->cp_hqd_cntl_stack_size -
+		m->cp_hqd_cntl_stack_offset;
+	*save_area_used_size = m->cp_hqd_wg_state_offset -
+		m->cp_hqd_cntl_stack_size;
+
+	/* Control stack is not copied to user mode for GFXv12 because
+	 * it's part of the context save area that is already
+	 * accessible to user mode
+	 */
+	header.control_stack_size = *ctl_stack_used_size;
+	header.wave_state_size = *save_area_used_size;
+
+	header.wave_state_offset = m->cp_hqd_wg_state_offset;
+	header.control_stack_offset = m->cp_hqd_cntl_stack_offset;
+
+	if (copy_to_user(ctl_stack, &header, sizeof(header)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static void init_mqd_hiq(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *q)
+{
+	struct v12_1_compute_mqd *m;
+
+	init_mqd(mm, mqd, mqd_mem_obj, gart_addr, q);
+
+	m = get_mqd(*mqd);
+
+	m->cp_hqd_pq_control |= 1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
+			1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
+}
+
+static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
+		struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+		struct queue_properties *q)
+{
+	struct v12_sdma_mqd *m;
+
+	m = (struct v12_sdma_mqd *) mqd_mem_obj->cpu_ptr;
+
+	memset(m, 0, PAGE_SIZE);
+
+	*mqd = m;
+	if (gart_addr)
+		*gart_addr = mqd_mem_obj->gpu_addr;
+
+	mm->update_mqd(mm, m, q, NULL);
+}
+
+#define SDMA_RLC_DUMMY_DEFAULT 0xf
+
+static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
+		struct queue_properties *q,
+		struct mqd_update_info *minfo)
+{
+	struct v12_sdma_mqd *m;
+
+	m = get_sdma_mqd(mqd);
+	m->sdmax_rlcx_rb_cntl = (ffs(q->queue_size / sizeof(unsigned int)) - 1)
+		<< SDMA0_SDMA_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
+		q->vmid << SDMA0_SDMA_QUEUE0_RB_CNTL__RB_VMID__SHIFT |
+		1 << SDMA0_SDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
+		6 << SDMA0_SDMA_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
+		1 << SDMA0_SDMA_QUEUE0_RB_CNTL__MCU_WPTR_POLL_ENABLE__SHIFT;
+
+	m->sdmax_rlcx_rb_base = lower_32_bits(q->queue_address >> 8);
+	m->sdmax_rlcx_rb_base_hi = upper_32_bits(q->queue_address >> 8);
+	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits((uint64_t)q->read_ptr);
+	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits((uint64_t)q->read_ptr);
+	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits((uint64_t)q->write_ptr);
+	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits((uint64_t)q->write_ptr);
+	m->sdmax_rlcx_doorbell_offset =
+		q->doorbell_off << SDMA0_SDMA_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
+
+	m->sdma_engine_id = q->sdma_engine_id;
+	m->sdma_queue_id = q->sdma_queue_id;
+
+	m->sdmax_rlcx_dummy_reg = SDMA_RLC_DUMMY_DEFAULT;
+
+	q->is_active = QUEUE_IS_ACTIVE(*q);
+}
+
+static void get_xcc_mqd(struct kfd_mem_obj *mqd_mem_obj,
+			       struct kfd_mem_obj *xcc_mqd_mem_obj,
+			       uint64_t offset)
+{
+	xcc_mqd_mem_obj->gtt_mem = (offset == 0) ?
+					mqd_mem_obj->gtt_mem : NULL;
+	xcc_mqd_mem_obj->gpu_addr = mqd_mem_obj->gpu_addr + offset;
+	xcc_mqd_mem_obj->cpu_ptr = (uint32_t *)((uintptr_t)mqd_mem_obj->cpu_ptr
+						+ offset);
+}
+
+static void init_mqd_v12_1(struct mqd_manager *mm, void **mqd,
+			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
+			struct queue_properties *q)
+{
+	struct v12_1_compute_mqd *m;
+	int xcc = 0;
+	struct kfd_mem_obj xcc_mqd_mem_obj;
+	uint64_t xcc_gart_addr = 0;
+	uint64_t xcc_ctx_save_restore_area_address;
+	uint64_t offset = mm->mqd_stride(mm, q);
+	uint32_t local_xcc_start = mm->dev->dqm->current_logical_xcc_start++;
+
+	memset(&xcc_mqd_mem_obj, 0x0, sizeof(struct kfd_mem_obj));
+	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
+		get_xcc_mqd(mqd_mem_obj, &xcc_mqd_mem_obj, offset*xcc);
+
+		init_mqd(mm, (void **)&m, &xcc_mqd_mem_obj, &xcc_gart_addr, q);
+
+		m->cp_mqd_stride_size = offset;
+
+		/*
+		 * Update the CWSR address for each XCC if CWSR is enabled
+		 * and CWSR area is allocated in thunk
+		 */
+		if (mm->dev->kfd->cwsr_enabled &&
+		    q->ctx_save_restore_area_address) {
+			xcc_ctx_save_restore_area_address =
+				q->ctx_save_restore_area_address +
+				(xcc * q->ctx_save_restore_area_size);
+
+			m->cp_hqd_ctx_save_base_addr_lo =
+				lower_32_bits(xcc_ctx_save_restore_area_address);
+			m->cp_hqd_ctx_save_base_addr_hi =
+				upper_32_bits(xcc_ctx_save_restore_area_address);
+		}
+
+		if (q->format == KFD_QUEUE_FORMAT_AQL) {
+			m->compute_tg_chunk_size = 1;
+			m->compute_current_logical_xcc_id =
+					(local_xcc_start + xcc) %
+					NUM_XCC(mm->dev->xcc_mask);
+		} else {
+			/* PM4 Queue */
+			m->compute_current_logical_xcc_id = 0;
+			m->compute_tg_chunk_size = 0;
+			m->pm4_target_xcc_in_xcp = q->pm4_target_xcc;
+		}
+
+		if (xcc == 0) {
+			/* Set the MQD pointer and gart address to XCC0 MQD */
+			*mqd = m;
+			*gart_addr = xcc_gart_addr;
+		}
+	}
+}
+
+static void update_mqd_v12_1(struct mqd_manager *mm, void *mqd,
+		      struct queue_properties *q, struct mqd_update_info *minfo)
+{
+	struct v12_1_compute_mqd *m;
+	int xcc = 0;
+	uint64_t size = mm->mqd_stride(mm, q);
+
+	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
+		m = get_mqd(mqd + size * xcc);
+		update_mqd(mm, m, q, minfo);
+
+		update_cu_mask(mm, m, minfo, xcc);
+
+		if (q->format == KFD_QUEUE_FORMAT_AQL) {
+			m->compute_tg_chunk_size = 1;
+		} else {
+			/* PM4 Queue */
+			m->compute_current_logical_xcc_id = 0;
+			m->compute_tg_chunk_size = 0;
+			m->pm4_target_xcc_in_xcp = q->pm4_target_xcc;
+		}
+	}
+}
+
+static int destroy_mqd_v12_1(struct mqd_manager *mm, void *mqd,
+		   enum kfd_preempt_type type, unsigned int timeout,
+		   uint32_t pipe_id, uint32_t queue_id)
+{
+	uint32_t xcc_mask = mm->dev->xcc_mask;
+	int xcc_id, err, inst = 0;
+	void *xcc_mqd;
+	struct v12_1_compute_mqd *m;
+	uint64_t mqd_offset;
+
+	m = get_mqd(mqd);
+	mqd_offset = m->cp_mqd_stride_size;
+
+	for_each_inst(xcc_id, xcc_mask) {
+		xcc_mqd = mqd + mqd_offset * inst;
+		err = mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, xcc_mqd,
+						    type, timeout, pipe_id,
+						    queue_id, xcc_id);
+		if (err) {
+			pr_debug("Destroy MQD failed for xcc: %d\n", inst);
+			break;
+		}
+		++inst;
+	}
+
+	return err;
+}
+
+static int load_mqd_v12_1(struct mqd_manager *mm, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			struct queue_properties *p, struct mm_struct *mms)
+{
+	/* AQL write pointer counts in 64B packets, PM4/CP counts in dwords. */
+	uint32_t wptr_shift = (p->format == KFD_QUEUE_FORMAT_AQL ? 4 : 0);
+	uint32_t xcc_mask = mm->dev->xcc_mask;
+	int xcc_id, err, inst = 0;
+	void *xcc_mqd;
+	uint64_t mqd_stride_size = mm->mqd_stride(mm, p);
+
+	for_each_inst(xcc_id, xcc_mask) {
+		xcc_mqd = mqd + mqd_stride_size * inst;
+		err = mm->dev->kfd2kgd->hqd_load(
+			mm->dev->adev, xcc_mqd, pipe_id, queue_id,
+			(uint32_t __user *)p->write_ptr, wptr_shift, 0, mms,
+			xcc_id);
+		if (err) {
+			pr_debug("Load MQD failed for xcc: %d\n", inst);
+			break;
+		}
+		++inst;
+	}
+
+	return err;
+}
+
+static int get_wave_state_v12_1(struct mqd_manager *mm, void *mqd,
+				 struct queue_properties *q,
+				 void __user *ctl_stack,
+				 u32 *ctl_stack_used_size,
+				 u32 *save_area_used_size)
+{
+	int xcc, err = 0;
+	void *xcc_mqd;
+	void __user *xcc_ctl_stack;
+	uint64_t mqd_stride_size = mm->mqd_stride(mm, q);
+	u32 tmp_ctl_stack_used_size = 0, tmp_save_area_used_size = 0;
+
+	for (xcc = 0; xcc < NUM_XCC(mm->dev->xcc_mask); xcc++) {
+		xcc_mqd = mqd + mqd_stride_size * xcc;
+		xcc_ctl_stack = (void __user *)((uintptr_t)ctl_stack +
+					q->ctx_save_restore_area_size * xcc);
+
+		err = get_wave_state(mm, xcc_mqd, q, xcc_ctl_stack,
+				     &tmp_ctl_stack_used_size,
+				     &tmp_save_area_used_size);
+		if (err)
+			break;
+
+		/*
+		 * Set the ctl_stack_used_size and save_area_used_size to
+		 * ctl_stack_used_size and save_area_used_size of XCC 0 when
+		 * passing the info to user-space.
+		 * For multi XCC, user-space would have to look at the header
+		 * info of each Control stack area to determine the control
+		 * stack size and save area used.
+		 */
+		if (xcc == 0) {
+			*ctl_stack_used_size = tmp_ctl_stack_used_size;
+			*save_area_used_size = tmp_save_area_used_size;
+		}
+	}
+
+	return err;
+}
+
+#if defined(CONFIG_DEBUG_FS)
+
+static int debugfs_show_mqd(struct seq_file *m, void *data)
+{
+	seq_hex_dump(m, "    ", DUMP_PREFIX_OFFSET, 32, 4,
+		     data, sizeof(struct v12_1_compute_mqd), false);
+	return 0;
+}
+
+static int debugfs_show_mqd_sdma(struct seq_file *m, void *data)
+{
+	seq_hex_dump(m, "    ", DUMP_PREFIX_OFFSET, 32, 4,
+		     data, sizeof(struct v12_sdma_mqd), false);
+	return 0;
+}
+
+#endif
+
+struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
+		struct kfd_node *dev)
+{
+	struct mqd_manager *mqd;
+
+	if (WARN_ON(type >= KFD_MQD_TYPE_MAX))
+		return NULL;
+
+	mqd = kzalloc(sizeof(*mqd), GFP_KERNEL);
+	if (!mqd)
+		return NULL;
+
+	mqd->dev = dev;
+
+	switch (type) {
+	case KFD_MQD_TYPE_CP:
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		mqd->allocate_mqd = allocate_mqd;
+		mqd->init_mqd = init_mqd_v12_1;
+		mqd->free_mqd = kfd_free_mqd_cp;
+		mqd->load_mqd = load_mqd_v12_1;
+		mqd->update_mqd = update_mqd_v12_1;
+		mqd->destroy_mqd = destroy_mqd_v12_1;
+		mqd->is_occupied = kfd_is_occupied_cp;
+		mqd->mqd_size = sizeof(struct v12_1_compute_mqd);
+		mqd->get_wave_state = get_wave_state_v12_1;
+		mqd->mqd_stride = mqd_stride_v12_1;
+#if defined(CONFIG_DEBUG_FS)
+		mqd->debugfs_show_mqd = debugfs_show_mqd;
+#endif
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		break;
+	case KFD_MQD_TYPE_HIQ:
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		mqd->allocate_mqd = allocate_hiq_mqd;
+		mqd->init_mqd = init_mqd_hiq;
+		mqd->free_mqd = free_mqd_hiq_sdma;
+		mqd->load_mqd = kfd_hiq_load_mqd_kiq;
+		mqd->update_mqd = update_mqd;
+		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->is_occupied = kfd_is_occupied_cp;
+		mqd->mqd_size = sizeof(struct v12_1_compute_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
+#if defined(CONFIG_DEBUG_FS)
+		mqd->debugfs_show_mqd = debugfs_show_mqd;
+#endif
+		mqd->check_preemption_failed = check_preemption_failed;
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		break;
+	case KFD_MQD_TYPE_DIQ:
+		mqd->allocate_mqd = allocate_mqd;
+		mqd->init_mqd = init_mqd_hiq;
+		mqd->free_mqd = kfd_free_mqd_cp;
+		mqd->load_mqd = load_mqd;
+		mqd->update_mqd = update_mqd;
+		mqd->destroy_mqd = kfd_destroy_mqd_cp;
+		mqd->is_occupied = kfd_is_occupied_cp;
+		mqd->mqd_size = sizeof(struct v12_1_compute_mqd);
+#if defined(CONFIG_DEBUG_FS)
+		mqd->debugfs_show_mqd = debugfs_show_mqd;
+#endif
+		break;
+	case KFD_MQD_TYPE_SDMA:
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		mqd->allocate_mqd = allocate_mqd;
+		mqd->init_mqd = init_mqd_sdma;
+		mqd->free_mqd = kfd_free_mqd_cp;
+		mqd->load_mqd = kfd_load_mqd_sdma;
+		mqd->update_mqd = update_mqd_sdma;
+		mqd->destroy_mqd = kfd_destroy_mqd_sdma;
+		mqd->is_occupied = kfd_is_occupied_sdma;
+		mqd->mqd_size = sizeof(struct v12_sdma_mqd);
+		mqd->mqd_stride = kfd_mqd_stride;
+#if defined(CONFIG_DEBUG_FS)
+		mqd->debugfs_show_mqd = debugfs_show_mqd_sdma;
+#endif
+		pr_debug("%s@%i\n", __func__, __LINE__);
+		break;
+	default:
+		kfree(mqd);
+		return NULL;
+	}
+
+	return mqd;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 76842bb8e78ba..ee54f1ea1516d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1342,6 +1342,8 @@ struct mqd_manager *mqd_manager_init_v11(enum KFD_MQD_TYPE type,
 		struct kfd_node *dev);
 struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
 		struct kfd_node *dev);
+struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
+		struct kfd_node *dev);
 struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev);
 void device_queue_manager_uninit(struct device_queue_manager *dqm);
 struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
-- 
2.51.1

