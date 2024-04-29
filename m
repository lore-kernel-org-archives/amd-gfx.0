Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CBEC04FFE
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C1D10E3D5;
	Mon, 29 Apr 2024 14:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgloZiOR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F8810F908
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixlFJUncLq4m6KyA8LUPxm/UgPOGm1QhOG7e3zzkJ4pxodYt6GwKxOMpy3T48/slLsTagqMEu8PkQstk2HshOBq20MX14mp4uFzFX7PGqmmpMaVgSJ/Z4KJajJ7FbycGDD/6AdACulN+7ZemnTZEpmzEI4waY8AU8yXmqr6PzmENvw2KRfag8699cpZp8pIkS+/nzaqiUIc4zECCQkBURL41u9IqErixhGsQQpoufIz73sqBSP1SqqxGWS+eoBl6n+uPyNSd+ZM+MfWqupDdiHl4P/YVb8jOsPUaV9m8wKWukoNF0DxkJZZchb/30WeNZHH4uLslQQR/of//EwJjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3y7CvUfmnNwd074PR8sx3ZxvPWHgnrI3c4CIgs9M7I=;
 b=A+IqXseY5dpDYOvasnbtzZU5x6tOAVD389cM8/ZGH2z3Rk1nlA0qRg62o408coFfDvsND4WDYBd+ZGF8P36rYApkBQgDFUYi9ln9YVgm8gmYNxnG+uKtlt9OO3/sN+6pXCnNm8TaWiTCu4JZucqW+8s5LcoK81OQKiwduP61ecNz5MnyCO1UoP/2ZQQHh5uK7aueqQD1G7hutBBgI8M8imELl/fw5P2EUPJj3BaqNF0VckcJsJLn5mxr2GK4EZ2+gtxYJoaUvEmW9NTJugDUDxJ4nWkyhSxLZRUsaDJAdJueHiPOhZ52PLDU203TWqFnobKs4/osHH/IxHYpoXKuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3y7CvUfmnNwd074PR8sx3ZxvPWHgnrI3c4CIgs9M7I=;
 b=sgloZiOR66jnKIW5vgx0gUn+n8gGHhtJqd0H6HI0mI+yPFB3xSMc395cJt+XwFB5hFDvr28P/KeskIctCh5QENjmCs9tYt6kC1mIj5h7d8rgbjQpL1KDaxXQXJONgu9olETlS5o+t1HlXDyWUD6dQCN6dGZppbigLQE/KKTICiA=
Received: from BY5PR13CA0018.namprd13.prod.outlook.com (2603:10b6:a03:180::31)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:57:46 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::99) by BY5PR13CA0018.outlook.office365.com
 (2603:10b6:a03:180::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.22 via Frontend
 Transport; Mon, 29 Apr 2024 14:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:57:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:57:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Belanger <david.belanger@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/14] drm/amdkfd: Added device queue manager files for GFX12.
Date: Mon, 29 Apr 2024 10:57:13 -0400
Message-ID: <20240429145726.3459450-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1c40cb-914e-48da-f199-08dc685cbad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IYTjoa3PR83C+UyY5WR/WmnnAZgkzpAAgth4mREcBX0TQXQwtqnDVqXGoK+c?=
 =?us-ascii?Q?znmz7lsY7GVAu/dgX6B0V48z+BrSOQk14EC5UVsAlWW1ocn919v1mRf1kBGa?=
 =?us-ascii?Q?ZhNA+B0mvhJn1t7vO2k3tzzbTV0VeqhQnylHZgQA7vSmAlSdZrDXraDsyogq?=
 =?us-ascii?Q?F+c6tMm0W6EEldS59kOOsjbiFyXb453tgYnZ/Xlvb7G/y1bD0k27e4izY82v?=
 =?us-ascii?Q?dMNYkUHXmqVki1KBRQ+zEoH/SYTJoGd34Pjk7yG1OFtg5eFL4j0/vqGsxdqz?=
 =?us-ascii?Q?G7MwDuhVJWKzFR++owT2/B1tsqAsMF6poZ9uxt5mC6UuOwseXj7JvF7dtKzw?=
 =?us-ascii?Q?O48gXnOZ9oZ3flIqMwGiqSVJRXt7OYrmNh5FXOAvhoww95V2//e/HUFtpxpB?=
 =?us-ascii?Q?o4B3iQHxegnPxfa0UP2UztU6M5KZsY1gtTg7jjhoq3ft9u+pNz1WXtOm7z+O?=
 =?us-ascii?Q?ctLoIqXZrAEtuo2M9I3hVlSbTV/Lk6T+CIvJrkZujV2KlohXA25WFVx0clkg?=
 =?us-ascii?Q?STSo2WOVd08UvVnKtQ8pSFeOxMgsFGDy4pXqHNdej7r59R3Mb4LYqAe/aPvC?=
 =?us-ascii?Q?PMrqaPV1Z/8E89NHzSwF+AAVaJAnmNyMMh/L/SUDzfxbLVctq2mCwivCxmvC?=
 =?us-ascii?Q?jo4LwtL5wGN7LWfE8x5VhDI/BalUrYfrZoJSNh1DXpky8p1P/4s9Jocw2RHm?=
 =?us-ascii?Q?+aHfspXjFccXxz7GcW7RBTOafiHLShaGbH9Iat/ObHSMHhi64dgYdkn2ZV5I?=
 =?us-ascii?Q?X40khmlaLJ7S3EapLVoEEBls3gvCcQbUCwahb21ZVLCGgxhd26islNJbqSxg?=
 =?us-ascii?Q?8/8y0yLt0IEOwn0CXIBaJhruX0/uN3eRD0gxKEVNTEinFcTdSxBT2SVAUB7U?=
 =?us-ascii?Q?8ZjjF7X3dXJp0D5GEqTU5wER+VyLPHCJnc3f6Efr51WqwQHlevAZfNU9wjfs?=
 =?us-ascii?Q?WbtgaiJY9cGzO70FIVq1iWt3cnp5M5s0Wsib+BU7gXVrQGdlMbXlR5YTNqb3?=
 =?us-ascii?Q?ZTRUTjheQ7qymd88XJ8xo1nsP5r3L47YWZBVdy69TRxDeRGLPGNRkfgar5NF?=
 =?us-ascii?Q?G2sTsNNHub2wMex0C+WSulz4D6mrOvZln6OUxNoMI5vLT+ezRoeKr8BDKv6Q?=
 =?us-ascii?Q?2e0IYtpZOZXj32gE5wU5dquDyH5O/DQ7eruuX3/A7Bhu7KhWtmlXXVYndC3J?=
 =?us-ascii?Q?FpBnrDKuEX9A9pNYtSgA9UytkP61NkQkOy9h2E4qbRiWPid1GysR22GhCe78?=
 =?us-ascii?Q?DwTS5Aeyt91AUwzePV8FUHC/5abcoKLxaI62lJ67LIg7gUMyVXcHel0TaxdA?=
 =?us-ascii?Q?5lrXeZVJctSc2pzxAZi8Kn0Ig9D7UcnFmrSL634gGD3HtkQ0NKLP8GUuX2Ul?=
 =?us-ascii?Q?AQlVMuQ/oeX7LVKGxg6SqZP/nQ9S?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:57:45.9018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1c40cb-914e-48da-f199-08dc685cbad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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

From: David Belanger <david.belanger@amd.com>

Initial implementation, based on GFX11.

v2: squash in include fix from David (Alex)

Signed-off-by: David Belanger <david.belanger@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile           |  1 +
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  4 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +
 .../amd/amdkfd/kfd_device_queue_manager_v12.c | 81 +++++++++++++++++++
 4 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index f0d9eebf242b6..0d3d8972240da 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -50,6 +50,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_device_queue_manager_v9.o \
 		$(AMDKFD_PATH)/kfd_device_queue_manager_v10.o \
 		$(AMDKFD_PATH)/kfd_device_queue_manager_v11.o \
+		$(AMDKFD_PATH)/kfd_device_queue_manager_v12.o \
 		$(AMDKFD_PATH)/kfd_interrupt.o \
 		$(AMDKFD_PATH)/kfd_events.o \
 		$(AMDKFD_PATH)/cik_event_interrupt.o \
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c08b6ee252898..4721b2fccd068 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2597,7 +2597,9 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
 		break;
 
 	default:
-		if (KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0))
+		if (KFD_GC_VERSION(dev) >= IP_VERSION(12, 0, 0))
+			device_queue_manager_init_v12(&dqm->asic_ops);
+		else if (KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0))
 			device_queue_manager_init_v11(&dqm->asic_ops);
 		else if (KFD_GC_VERSION(dev) >= IP_VERSION(10, 1, 1))
 			device_queue_manager_init_v10(&dqm->asic_ops);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index cf7e182588f80..fcc0ee67f5441 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -277,6 +277,8 @@ void device_queue_manager_init_v10(
 		struct device_queue_manager_asic_ops *asic_ops);
 void device_queue_manager_init_v11(
 		struct device_queue_manager_asic_ops *asic_ops);
+void device_queue_manager_init_v12(
+		struct device_queue_manager_asic_ops *asic_ops);
 void program_sh_mem_settings(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd);
 unsigned int get_cp_queues_num(struct device_queue_manager *dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c
new file mode 100644
index 0000000000000..4f3295b29dfb1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#include "gc/gc_12_0_0_sh_mask.h"
+#include "soc24_enum.h"
+
+static int update_qpd_v12(struct device_queue_manager *dqm,
+			 struct qcm_process_device *qpd);
+static void init_sdma_vm_v12(struct device_queue_manager *dqm, struct queue *q,
+			    struct qcm_process_device *qpd);
+
+void device_queue_manager_init_v12(
+	struct device_queue_manager_asic_ops *asic_ops)
+{
+	asic_ops->update_qpd = update_qpd_v12;
+	asic_ops->init_sdma_vm = init_sdma_vm_v12;
+	asic_ops->mqd_manager_init = mqd_manager_init_v12;
+}
+
+static uint32_t compute_sh_mem_bases_64bit(struct kfd_process_device *pdd)
+{
+	uint32_t shared_base = pdd->lds_base >> 48;
+	uint32_t private_base = pdd->scratch_base >> 48;
+
+	return (shared_base << SH_MEM_BASES__SHARED_BASE__SHIFT) |
+		private_base;
+}
+
+static int update_qpd_v12(struct device_queue_manager *dqm,
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
+		qpd->sh_mem_ape1_limit = 0;
+		qpd->sh_mem_ape1_base = 0;
+	}
+
+	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
+
+	pr_debug("sh_mem_bases 0x%X\n", qpd->sh_mem_bases);
+
+	return 0;
+}
+
+static void init_sdma_vm_v12(struct device_queue_manager *dqm, struct queue *q,
+			    struct qcm_process_device *qpd)
+{
+	/* Not needed on SDMAv4 onwards any more */
+	q->properties.sdma_vm_addr = 0;
+}
-- 
2.44.0

