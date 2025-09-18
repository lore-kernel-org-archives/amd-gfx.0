Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DD4CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2794310E5F1;
	Thu, 18 Sep 2025 01:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uf2sGsQ+";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012034.outbound.protection.outlook.com
 [40.93.195.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB8C510E5F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmc4ZL9SjeX5FRWVc5VagdZePfISq1M1ZWt4DyEERzKBENhu+6tbdOtUcccEMlIIHKrU20gP+q1cYjpl/Jr1Mgj1mri9sjr/r5zOXw07qyyKHOwPK6/c2xkTR8q4ZRuhwuzVl7OQ9Hw3aE/5NrpzTOMAJNez2W9IGkPAmKrDg6aOaL68ZkIgHB2dx3Z8tspzWnowbw+AAPgzDIYC6nZKMJ07iRwqkkRPgelXuF87dW00ImsUXmeAt16oFv27zr0FRJb6HWtuav4iEnu3KB/1U2rGXGIs/7NuGQNQePBFDy7JaT1JZoQZQAx69DwvVPlZn4csInY1ygpSUbvw6DibPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6f+707ieeAiQL5CBgrWffz6quIEbMuKE5+84JLg9hQ=;
 b=pSwGesLb2pdVtXA/4NXu2U/O8y20cJ0q2rpm67TmmkzqujmTOYfVSdmt163ktaz7maE3eJ+hs2kxQjIpLhwGEroKgqf/kgHjTEPJaZtYpIQMvW1AjJd7J+v6/Tvk9hhBqiXGzJmw8Mr54u6PL952BF4OedHSGUBsk9bO/eiQejNV0JILuoVjE1yO4yK2DDE0cIr+1VnYjz0qtzJL4KyJD4xsAWT7+looE2x9apsfpDGssmXpgSpC2iWZVfy2kpdTzjY1bYmTrOpJNN3IBQT6hZeASPOcJl19lDqsnkK6L/SQvJq6bbQKgj6tUszVT0t/pY6H4+4ljERhuxCxiWy5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6f+707ieeAiQL5CBgrWffz6quIEbMuKE5+84JLg9hQ=;
 b=Uf2sGsQ+Qc2uue8SKUW5I+zujMXhYR8Hf2uJD9Cmn5LQQJJQtpG7yIBr1wg8Wt9UQH+dg8ChU/dThh1Uzmzqt5EVrjtkrU8RjtXHLlUQbGZYeOE4SwOR722f2pSp3N0IFRuptjObJWri5KdfobvxhtkumFbkq26Nn8NgVFSWI30=
Received: from MW4PR03CA0203.namprd03.prod.outlook.com (2603:10b6:303:b8::28)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:33:37 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::e7) by MW4PR03CA0203.outlook.office365.com
 (2603:10b6:303:b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 01:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:37 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:35 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 15/21] drm/amd/ras: Add psp ras common functions
Date: Thu, 18 Sep 2025 09:32:26 +0800
Message-ID: <20250918013232.2629215-15-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: dd50ea55-b25c-4fec-8876-08ddf6536408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p5axdnf4Sp/+9kjk0nnGKqlqI1Isxdn7/WWZfN0rSydGbnDDE5rmdhRtYV4y?=
 =?us-ascii?Q?SE7i2HUSUjf/0FbgPjIRu3To8kOsneNK3QibvTE5/Xakw99CHbDZ2XOicMRT?=
 =?us-ascii?Q?1aZ1UmnxIw2IugBdmz8X9jsIzdpdN6jpGumvicNlosBLn9I48eb3DZKaBV5G?=
 =?us-ascii?Q?1Yt4WoeI/SAj9cgTciPCbxZdeZjZA+t5CtKFxmuytO2+lNi/kpaBXP95zsj1?=
 =?us-ascii?Q?W5tmcw4c9O2QkHRaR7m5JID2D/yOwlR608c0hTcUJmgKB8nELzDB0KtRMImo?=
 =?us-ascii?Q?lqictVl2CxSwAZvplnXhUJUVlMqsQWHh97fgEmnE6sCvv9FhxIo/FiG8IaY8?=
 =?us-ascii?Q?bD/QUdnE00qvDhPl870MS3hRwsWBB3uWvQ5gInasBFgREUt+8vQ1tqxTq7wM?=
 =?us-ascii?Q?LAafsJn6j+wuud8l/RA/kBtS2tK5N6gqknjM00ab8JVqEuwmeT3jUZ605aeU?=
 =?us-ascii?Q?ttpmKnIP8VonmsQOXJ2nBDnlZV765qiR7Inf4RHdGehIzLFShBfCjtd7zlZM?=
 =?us-ascii?Q?57QiqwfB/00TLS4hF/vI9mQz1bm6OfuMBavtKPgeys7fT5r58F3CT4af5W1a?=
 =?us-ascii?Q?KY/lZ62tvGKkFTZ/2Y/PS7tKfuVq79op/rcMN4meyxeY+YZRkrSg8oBp7Gbk?=
 =?us-ascii?Q?4+X8gKndLNx5ibQJYFSWrDaClAPTmQCMFmit5yL7nmggpo+bHWY1fXlYAkNl?=
 =?us-ascii?Q?tc2bMp0Ilu3naa/9D7BtK87TgGmyHzLsxp1zzzXo4JC9YOG1MROhbagHPkEH?=
 =?us-ascii?Q?FUjcUDPFdJRHMwOCH9SKtUKEmHIoqXsdPVkK91GdeAwFNtxZA9bJkWwFkTzL?=
 =?us-ascii?Q?BYvAqfEidbFgMngLTqd/BIXmc3bpLTxDlCXdut0iCI4iOoIem4+do8wcAkHW?=
 =?us-ascii?Q?WjpgxZxhQEvMh2s+GXKa1/ycZuNV7SB7qJf0+KMGibsEs3S64v/yoRvmMzc2?=
 =?us-ascii?Q?lNKNijWIvgnGdoAOEldT3248fWbwLH6ASAivT7qc0Vtl2Qxk84Y9CPhTML1Z?=
 =?us-ascii?Q?Q8bYChwFJqnhY3+7hZgz6wIbHD9aah44J6AAymqpVEM5/icuMjIaafZtddjG?=
 =?us-ascii?Q?EcWF2RBP356CMKJJ6ozO3X1y6+2S8od/lnfAWriRnBlJrhqq5h3GxM9EPqNw?=
 =?us-ascii?Q?GrZbg7/ZXYW0L/ahyiRz54FKgeD0zt1aML8spm6SdRXqrVNoHl7gjWcCo74W?=
 =?us-ascii?Q?tICM9HJ6v0HlJjXBUbMWQidZl+FqstR32sZF1fMl/iChz6LgYWjd2YTMK1vV?=
 =?us-ascii?Q?iPOUFDiIMR5ZBNuSVo55oKxzPi+PhQ7XDcdBdy8WZ2m9n3wOv9Ow5pIhBnce?=
 =?us-ascii?Q?L0PGpmxOeU7gWb+0pLQjAGj6SseMjyyc5+rkC1eaFXT7L/3pQ2ZcQ07tyhG+?=
 =?us-ascii?Q?FWBsTCgaN3WcXMbZOPeHFKbBVGkLPTrC/cxl7pAARlL8bY8BRWuOYg6G3QMF?=
 =?us-ascii?Q?qxIGSXcbPafBSrLWpLjr2MUASCBqjLDqCX7JAi94Zy9QKIkQqr3Fs8B8tkG3?=
 =?us-ascii?Q?PtS1Rl4a/NNX9wDV7aeKqm1Fdk782MYLyDwQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:37.6124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd50ea55-b25c-4fec-8876-08ddf6536408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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

Add psp ras common functions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_psp.c   | 750 ++++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_psp.h   | 145 ++++
 drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h | 231 ++++++
 3 files changed, 1126 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_psp.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_psp.h
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
new file mode 100644
index 000000000000..c94effd4b114
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
@@ -0,0 +1,750 @@
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
+#include "ras.h"
+#include "ras_ta_if.h"
+#include "ras_psp.h"
+#include "ras_psp_v13_0.h"
+
+/* position of instance value in sub_block_index of
+ * ta_ras_trigger_error_input, the sub block uses lower 12 bits
+ */
+#define RAS_TA_INST_MASK 0xfffff000
+#define RAS_TA_INST_SHIFT 0xc
+
+static const struct ras_psp_ip_func *ras_psp_get_ip_funcs(
+			struct ras_core_context *ras_core, uint32_t ip_version)
+{
+	switch (ip_version) {
+	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 12):
+		return &ras_psp_v13_0;
+	default:
+		RAS_DEV_ERR(ras_core->dev,
+			"psp ip version(0x%x) is not supported!\n", ip_version);
+		break;
+	}
+
+	return NULL;
+}
+
+static int ras_psp_sync_system_ras_psp_status(struct ras_core_context *ras_core)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+	struct ras_psp_ctx *psp_ctx = &ras_core->ras_psp.psp_ctx;
+	struct ras_psp_sys_status status = {0};
+	int ret;
+
+	if (psp->sys_func && psp->sys_func->get_ras_psp_system_status) {
+		ret = psp->sys_func->get_ras_psp_system_status(ras_core, &status);
+		if (ret)
+			return ret;
+
+		if (status.initialized) {
+			ta_ctx->preload_ras_ta_enabled = true;
+			ta_ctx->ras_ta_initialized = status.initialized;
+			ta_ctx->session_id = status.session_id;
+		}
+
+		psp_ctx->external_mutex = status.psp_cmd_mutex;
+	}
+
+	return 0;
+}
+
+static int ras_psp_get_ras_ta_init_param(struct ras_core_context *ras_core,
+	struct ras_ta_init_param *ras_ta_param)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+
+	if (psp->sys_func && psp->sys_func->get_ras_ta_init_param)
+		return psp->sys_func->get_ras_ta_init_param(ras_core, ras_ta_param);
+
+	RAS_DEV_ERR(ras_core->dev, "Not config get_ras_ta_init_param API!!\n");
+	return -EACCES;
+}
+
+static struct gpu_mem_block *ras_psp_get_gpu_mem(struct ras_core_context *ras_core,
+			enum gpu_mem_type mem_type)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+	struct gpu_mem_block *gpu_mem = NULL;
+	int ret;
+
+	switch (mem_type) {
+	case GPU_MEM_TYPE_RAS_PSP_RING:
+		gpu_mem = &psp->psp_ring.ras_ring_gpu_mem;
+		break;
+	case GPU_MEM_TYPE_RAS_PSP_CMD:
+		gpu_mem = &psp->psp_ctx.psp_cmd_gpu_mem;
+		break;
+	case GPU_MEM_TYPE_RAS_PSP_FENCE:
+		gpu_mem = &psp->psp_ctx.out_fence_gpu_mem;
+		break;
+	case GPU_MEM_TYPE_RAS_TA_FW:
+		gpu_mem = &psp->ta_ctx.fw_gpu_mem;
+		break;
+	case GPU_MEM_TYPE_RAS_TA_CMD:
+		gpu_mem = &psp->ta_ctx.cmd_gpu_mem;
+		break;
+	default:
+		return NULL;
+	}
+
+	if (!gpu_mem->ref_count) {
+		ret = ras_core_get_gpu_mem(ras_core, mem_type, gpu_mem);
+		if (ret)
+			return NULL;
+		gpu_mem->mem_type = mem_type;
+	}
+
+	gpu_mem->ref_count++;
+
+	return gpu_mem;
+}
+
+static int ras_psp_put_gpu_mem(struct ras_core_context *ras_core,
+			struct gpu_mem_block *gpu_mem)
+{
+	if (!gpu_mem)
+		return 0;
+
+	gpu_mem->ref_count--;
+
+	if (gpu_mem->ref_count > 0) {
+		return 0;
+	} else if (gpu_mem->ref_count < 0) {
+		RAS_DEV_WARN(ras_core->dev,
+			"Duplicate free gpu memory %u\n", gpu_mem->mem_type);
+	} else {
+		ras_core_put_gpu_mem(ras_core, gpu_mem->mem_type, gpu_mem);
+		memset(gpu_mem, 0, sizeof(*gpu_mem));
+	}
+
+	return 0;
+}
+
+static void __acquire_psp_cmd_lock(struct ras_core_context *ras_core)
+{
+	struct ras_psp_ctx *psp_ctx = &ras_core->ras_psp.psp_ctx;
+
+	if (psp_ctx->external_mutex)
+		mutex_lock(psp_ctx->external_mutex);
+	else
+		mutex_lock(&psp_ctx->internal_mutex);
+}
+
+static void __release_psp_cmd_lock(struct ras_core_context *ras_core)
+{
+	struct ras_psp_ctx *psp_ctx = &ras_core->ras_psp.psp_ctx;
+
+	if (psp_ctx->external_mutex)
+		mutex_unlock(psp_ctx->external_mutex);
+	else
+		mutex_unlock(&psp_ctx->internal_mutex);
+}
+
+static uint32_t __get_ring_frame_slot(struct ras_core_context *ras_core)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+	uint32_t ras_ring_wptr_dw;
+
+	ras_ring_wptr_dw = psp->ip_func->psp_ras_ring_wptr_get(ras_core);
+
+	return (ras_ring_wptr_dw << 2) / sizeof(struct psp_gfx_rb_frame);
+}
+
+static int __set_ring_frame_slot(struct ras_core_context *ras_core,
+			uint32_t slot)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+
+	return psp->ip_func->psp_ras_ring_wptr_set(ras_core,
+				(slot * sizeof(struct psp_gfx_rb_frame)) >> 2);
+}
+
+static int write_frame_to_ras_psp_ring(struct ras_core_context *ras_core,
+		struct psp_gfx_rb_frame *frame)
+{
+	struct gpu_mem_block *ring_mem;
+	struct psp_gfx_rb_frame *rb_frame;
+	uint32_t max_frame_slot;
+	uint32_t slot_idx;
+	uint32_t write_flush_read_back = 0;
+	int ret = 0;
+
+	ring_mem = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_PSP_RING);
+	if (!ring_mem)
+		return -ENOMEM;
+
+	max_frame_slot =
+		ring_mem->mem_size / sizeof(struct psp_gfx_rb_frame);
+
+	rb_frame =
+		(struct psp_gfx_rb_frame *)ring_mem->mem_cpu_addr;
+
+	slot_idx = __get_ring_frame_slot(ras_core);
+	if (slot_idx >= max_frame_slot)
+		slot_idx = 0;
+
+	memcpy(&rb_frame[slot_idx], frame, sizeof(*frame));
+
+	/* Do a read to force the write of the frame before writing
+	 * write pointer.
+	 */
+	write_flush_read_back = rb_frame[slot_idx].fence_value;
+	if (write_flush_read_back != frame->fence_value) {
+		RAS_DEV_ERR(ras_core->dev,
+		"Failed to submit ring cmd! cmd:0x%x:0x%x, fence:0x%x:0x%x value:%u, expected:%u\n",
+			rb_frame[slot_idx].cmd_buf_addr_hi,
+			rb_frame[slot_idx].cmd_buf_addr_lo,
+			rb_frame[slot_idx].fence_addr_hi,
+			rb_frame[slot_idx].fence_addr_lo,
+			write_flush_read_back, frame->fence_value);
+		ret = -EACCES;
+		goto err;
+	}
+
+	slot_idx++;
+
+	if (slot_idx >= max_frame_slot)
+		slot_idx = 0;
+
+	__set_ring_frame_slot(ras_core, slot_idx);
+
+err:
+	ras_psp_put_gpu_mem(ras_core, ring_mem);
+	return ret;
+}
+
+static int send_psp_cmd(struct ras_core_context *ras_core,
+		enum psp_gfx_cmd_id gfx_cmd_id, void *cmd_data,
+		uint32_t cmd_size, struct psp_cmd_resp *resp)
+{
+	struct ras_psp_ctx *psp_ctx = &ras_core->ras_psp.psp_ctx;
+	struct gpu_mem_block *psp_cmd_buf = NULL;
+	struct gpu_mem_block *psp_fence_buf = NULL;
+	struct psp_gfx_cmd_resp *gfx_cmd;
+	struct psp_gfx_rb_frame rb_frame;
+	int ret = 0;
+	int timeout = 1000;
+
+	if (!cmd_data || (cmd_size > sizeof(union psp_gfx_commands)) || !resp) {
+		RAS_DEV_ERR(ras_core->dev, "Invalid RAS PSP command, id: %u\n", gfx_cmd_id);
+		return -EINVAL;
+	}
+
+	__acquire_psp_cmd_lock(ras_core);
+
+	psp_cmd_buf = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_PSP_CMD);
+	if (!psp_cmd_buf) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	psp_fence_buf = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_PSP_FENCE);
+	if (!psp_fence_buf) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	gfx_cmd = (struct psp_gfx_cmd_resp *)psp_cmd_buf->mem_cpu_addr;
+	memset(gfx_cmd, 0, sizeof(*gfx_cmd));
+	gfx_cmd->cmd_id = gfx_cmd_id;
+	memcpy(&gfx_cmd->cmd, cmd_data, cmd_size);
+
+	psp_ctx->in_fence_value++;
+
+	memset(&rb_frame, 0, sizeof(rb_frame));
+	rb_frame.cmd_buf_addr_hi = upper_32_bits(psp_cmd_buf->mem_mc_addr);
+	rb_frame.cmd_buf_addr_lo = lower_32_bits(psp_cmd_buf->mem_mc_addr);
+	rb_frame.fence_addr_hi = upper_32_bits(psp_fence_buf->mem_mc_addr);
+	rb_frame.fence_addr_lo = lower_32_bits(psp_fence_buf->mem_mc_addr);
+	rb_frame.fence_value = psp_ctx->in_fence_value;
+
+	ret = write_frame_to_ras_psp_ring(ras_core, &rb_frame);
+	if (ret) {
+		psp_ctx->in_fence_value--;
+		goto exit;
+	}
+
+	while (*((uint64_t *)psp_fence_buf->mem_cpu_addr) !=
+		   psp_ctx->in_fence_value) {
+		if (--timeout == 0)
+			break;
+		/*
+		 * Shouldn't wait for timeout when err_event_athub occurs,
+		 * because gpu reset thread triggered and lock resource should
+		 * be released for psp resume sequence.
+		 */
+		if (ras_core_ras_interrupt_detected(ras_core))
+			break;
+
+		msleep(2);
+	}
+
+	resp->status = gfx_cmd->resp.status;
+	resp->session_id = gfx_cmd->resp.session_id;
+
+exit:
+	ras_psp_put_gpu_mem(ras_core, psp_cmd_buf);
+	ras_psp_put_gpu_mem(ras_core, psp_fence_buf);
+
+	__release_psp_cmd_lock(ras_core);
+
+	return ret;
+}
+
+static void __check_ras_ta_cmd_resp(struct ras_core_context *ras_core,
+			struct ras_ta_cmd *ras_cmd)
+{
+
+	if (ras_cmd->ras_out_message.flags.err_inject_switch_disable_flag) {
+		RAS_DEV_WARN(ras_core->dev, "ECC switch disabled\n");
+		ras_cmd->ras_status = RAS_TA_STATUS__ERROR_RAS_NOT_AVAILABLE;
+	} else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
+		RAS_DEV_WARN(ras_core->dev, "RAS internal register access blocked\n");
+
+	switch (ras_cmd->ras_status) {
+	case RAS_TA_STATUS__ERROR_UNSUPPORTED_IP:
+		RAS_DEV_WARN(ras_core->dev,
+			 "RAS WARNING: cmd failed due to unsupported ip\n");
+		break;
+	case RAS_TA_STATUS__ERROR_UNSUPPORTED_ERROR_INJ:
+		RAS_DEV_WARN(ras_core->dev,
+			 "RAS WARNING: cmd failed due to unsupported error injection\n");
+		break;
+	case RAS_TA_STATUS__SUCCESS:
+		break;
+	case RAS_TA_STATUS__TEE_ERROR_ACCESS_DENIED:
+		if (ras_cmd->cmd_id == RAS_TA_CMD_ID__TRIGGER_ERROR)
+			RAS_DEV_WARN(ras_core->dev,
+				 "RAS WARNING: Inject error to critical region is not allowed\n");
+		break;
+	default:
+		RAS_DEV_WARN(ras_core->dev,
+			 "RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
+		break;
+	}
+}
+
+static int send_ras_ta_runtime_cmd(struct ras_core_context *ras_core,
+			enum ras_ta_cmd_id cmd_id, void *in, uint32_t in_size,
+			void *out, uint32_t out_size)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+	struct gpu_mem_block *cmd_mem;
+	struct ras_ta_cmd *ras_cmd;
+	struct psp_gfx_cmd_invoke_cmd invoke_cmd = {0};
+	struct psp_cmd_resp resp = {0};
+	int ret = 0;
+
+	if (!in || (in_size > sizeof(union ras_ta_cmd_input)) ||
+		(cmd_id >= MAX_RAS_TA_CMD_ID)) {
+		RAS_DEV_ERR(ras_core->dev, "Invalid RAS TA command, id: %u\n", cmd_id);
+		return -EINVAL;
+	}
+
+	ras_psp_sync_system_ras_psp_status(ras_core);
+
+	cmd_mem = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_TA_CMD);
+	if (!cmd_mem)
+		return -ENOMEM;
+
+	if (!ras_core_down_trylock_gpu_reset_lock(ras_core)) {
+		ret = -EACCES;
+		goto out;
+	}
+
+	ras_cmd = (struct ras_ta_cmd *)cmd_mem->mem_cpu_addr;
+
+	mutex_lock(&ta_ctx->ta_mutex);
+
+	memset(ras_cmd, 0, sizeof(*ras_cmd));
+	ras_cmd->cmd_id = cmd_id;
+	memcpy(&ras_cmd->ras_in_message, in, in_size);
+
+	invoke_cmd.ta_cmd_id = cmd_id;
+	invoke_cmd.session_id = ta_ctx->session_id;
+
+	ret = send_psp_cmd(ras_core, GFX_CMD_ID_INVOKE_CMD,
+			&invoke_cmd, sizeof(invoke_cmd), &resp);
+
+	/* If err_event_athub occurs error inject was successful, however
+	 *  return status from TA is no long reliable
+	 */
+	if (ras_core_ras_interrupt_detected(ras_core)) {
+		ret = 0;
+		goto unlock;
+	}
+
+	if (ret || resp.status) {
+		RAS_DEV_ERR(ras_core->dev,
+			"RAS: Failed to send psp cmd! ret:%d, status:%u\n",
+			ret, resp.status);
+		ret = -ESTRPIPE;
+		goto unlock;
+	}
+
+	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER) {
+		RAS_DEV_WARN(ras_core->dev, "RAS: Unsupported Interface\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (!ras_cmd->ras_status && out && out_size)
+		memcpy(out, &ras_cmd->ras_out_message, out_size);
+
+	__check_ras_ta_cmd_resp(ras_core, ras_cmd);
+
+unlock:
+	mutex_unlock(&ta_ctx->ta_mutex);
+	ras_core_up_gpu_reset_lock(ras_core);
+out:
+	ras_psp_put_gpu_mem(ras_core, cmd_mem);
+	return ret;
+}
+
+static int trigger_ras_ta_error(struct ras_core_context *ras_core,
+	struct ras_ta_trigger_error_input *info, uint32_t instance_mask)
+{
+	uint32_t dev_mask = 0;
+
+	switch (info->block_id) {
+	case RAS_TA_BLOCK__GFX:
+		if (ras_gfx_get_ta_subblock(ras_core, info->inject_error_type,
+				info->sub_block_index, &info->sub_block_index))
+			return -EINVAL;
+
+		dev_mask = RAS_GET_MASK(ras_core->dev, GC, instance_mask);
+		break;
+	case RAS_TA_BLOCK__SDMA:
+		dev_mask = RAS_GET_MASK(ras_core->dev, SDMA0, instance_mask);
+		break;
+	case RAS_TA_BLOCK__VCN:
+	case RAS_TA_BLOCK__JPEG:
+		dev_mask = RAS_GET_MASK(ras_core->dev, VCN, instance_mask);
+		break;
+	default:
+		dev_mask = instance_mask;
+		break;
+	}
+
+	/* reuse sub_block_index for backward compatibility */
+	dev_mask <<= RAS_TA_INST_SHIFT;
+	dev_mask &= RAS_TA_INST_MASK;
+	info->sub_block_index |= dev_mask;
+
+	return send_ras_ta_runtime_cmd(ras_core, RAS_TA_CMD_ID__TRIGGER_ERROR,
+				info, sizeof(*info), NULL, 0);
+}
+
+static int send_load_ta_fw_cmd(struct ras_core_context *ras_core,
+				struct ras_ta_ctx *ta_ctx)
+{
+	struct ras_ta_fw_bin  *fw_bin = &ta_ctx->fw_bin;
+	struct gpu_mem_block *fw_mem;
+	struct gpu_mem_block *cmd_mem;
+	struct ras_ta_cmd *ta_cmd;
+	struct ras_ta_init_flags *ta_init_flags;
+	struct psp_gfx_cmd_load_ta  psp_load_ta_cmd;
+	struct psp_cmd_resp resp = {0};
+	struct ras_ta_image_header *fw_hdr = NULL;
+	int ret;
+
+	fw_mem = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_TA_FW);
+	if (!fw_mem)
+		return -ENOMEM;
+
+	cmd_mem = ras_psp_get_gpu_mem(ras_core, GPU_MEM_TYPE_RAS_TA_CMD);
+	if (!cmd_mem) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = ras_psp_get_ras_ta_init_param(ras_core, &ta_ctx->init_param);
+	if (ret)
+		goto err;
+
+	if (!ras_core_down_trylock_gpu_reset_lock(ras_core)) {
+		ret = -EACCES;
+		goto err;
+	}
+
+	/* copy ras ta binary to shared gpu memory */
+	memcpy(fw_mem->mem_cpu_addr, fw_bin->bin_addr, fw_bin->bin_size);
+	fw_mem->mem_size = fw_bin->bin_size;
+
+	/* Initialize ras ta startup parameter */
+	ta_cmd = (struct ras_ta_cmd *)cmd_mem->mem_cpu_addr;
+	ta_init_flags = &ta_cmd->ras_in_message.init_flags;
+
+	ta_init_flags->poison_mode_en = ta_ctx->init_param.poison_mode_en;
+	ta_init_flags->dgpu_mode = ta_ctx->init_param.dgpu_mode;
+	ta_init_flags->xcc_mask = ta_ctx->init_param.xcc_mask;
+	ta_init_flags->channel_dis_num = ta_ctx->init_param.channel_dis_num;
+	ta_init_flags->nps_mode = ta_ctx->init_param.nps_mode;
+	ta_init_flags->active_umc_mask = ta_ctx->init_param.active_umc_mask;
+
+	/* Setup load ras ta command */
+	memset(&psp_load_ta_cmd, 0, sizeof(psp_load_ta_cmd));
+	psp_load_ta_cmd.app_phy_addr_lo	= lower_32_bits(fw_mem->mem_mc_addr);
+	psp_load_ta_cmd.app_phy_addr_hi	= upper_32_bits(fw_mem->mem_mc_addr);
+	psp_load_ta_cmd.app_len		= fw_mem->mem_size;
+	psp_load_ta_cmd.cmd_buf_phy_addr_lo = lower_32_bits(cmd_mem->mem_mc_addr);
+	psp_load_ta_cmd.cmd_buf_phy_addr_hi = upper_32_bits(cmd_mem->mem_mc_addr);
+	psp_load_ta_cmd.cmd_buf_len = cmd_mem->mem_size;
+
+	ret = send_psp_cmd(ras_core, GFX_CMD_ID_LOAD_TA,
+			&psp_load_ta_cmd, sizeof(psp_load_ta_cmd), &resp);
+	if (!ret && !resp.status) {
+		/* Read TA version at FW offset 0x60 if TA version not found*/
+		fw_hdr = (struct ras_ta_image_header *)fw_bin->bin_addr;
+		RAS_DEV_INFO(ras_core->dev, "PSP: RAS TA(version:%X.%X.%X.%X) is loaded.\n",
+			(fw_hdr->image_version >> 24) & 0xFF, (fw_hdr->image_version >> 16) & 0xFF,
+			(fw_hdr->image_version >> 8) & 0xFF, fw_hdr->image_version & 0xFF);
+		ta_ctx->ta_version = fw_hdr->image_version;
+		ta_ctx->session_id = resp.session_id;
+		ta_ctx->ras_ta_initialized = true;
+	} else {
+		RAS_DEV_ERR(ras_core->dev,
+			"Failed to load RAS TA! ret:%d, status:%d\n", ret, resp.status);
+	}
+
+	ras_core_up_gpu_reset_lock(ras_core);
+
+err:
+	ras_psp_put_gpu_mem(ras_core, fw_mem);
+	ras_psp_put_gpu_mem(ras_core, cmd_mem);
+	return ret;
+}
+
+static int load_ras_ta_firmware(struct ras_core_context *ras_core,
+		struct ras_psp_ta_load *ras_ta_load)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+	struct ras_ta_fw_bin  *fw_bin = &ta_ctx->fw_bin;
+	int ret;
+
+	fw_bin->bin_addr = ras_ta_load->bin_addr;
+	fw_bin->bin_size = ras_ta_load->bin_size;
+	fw_bin->fw_version = ras_ta_load->fw_version;
+	fw_bin->feature_version = ras_ta_load->feature_version;
+
+	ret = send_load_ta_fw_cmd(ras_core, ta_ctx);
+	if (!ret) {
+		ras_ta_load->out_session_id = ta_ctx->session_id;
+		ras_ta_load->out_loaded_ta_version = ta_ctx->ta_version;
+	}
+
+	return ret;
+}
+
+static int unload_ras_ta_firmware(struct ras_core_context *ras_core,
+		struct ras_psp_ta_unload *ras_ta_unload)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+	struct psp_gfx_cmd_unload_ta  cmd_unload_ta = {0};
+	struct psp_cmd_resp resp = {0};
+	int ret;
+
+	if (!ras_core_down_trylock_gpu_reset_lock(ras_core))
+		return -EACCES;
+
+	cmd_unload_ta.session_id = ta_ctx->session_id;
+	ret = send_psp_cmd(ras_core, GFX_CMD_ID_UNLOAD_TA,
+		&cmd_unload_ta, sizeof(cmd_unload_ta), &resp);
+	if (ret || resp.status) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Failed to unload RAS TA! ret:%d, status:%u\n",
+			ret, resp.status);
+		goto unlock;
+	}
+
+	kfree(ta_ctx->fw_bin.bin_addr);
+	memset(&ta_ctx->fw_bin, 0, sizeof(ta_ctx->fw_bin));
+	ta_ctx->ta_version = 0;
+	ta_ctx->ras_ta_initialized = false;
+	ta_ctx->session_id = 0;
+
+unlock:
+	ras_core_up_gpu_reset_lock(ras_core);
+
+	return ret;
+}
+
+int ras_psp_load_firmware(struct ras_core_context *ras_core,
+	struct ras_psp_ta_load *ras_ta_load)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+	struct ras_psp_ta_unload ras_ta_unload = {0};
+	int ret;
+
+	if (ta_ctx->preload_ras_ta_enabled)
+		return 0;
+
+	if (!ras_ta_load)
+		return -EINVAL;
+
+	if (ta_ctx->ras_ta_initialized) {
+		ras_ta_unload.ras_session_id = ta_ctx->session_id;
+		ret = unload_ras_ta_firmware(ras_core, &ras_ta_unload);
+		if (ret)
+			return ret;
+	}
+
+	return load_ras_ta_firmware(ras_core, ras_ta_load);
+}
+
+int ras_psp_unload_firmware(struct ras_core_context *ras_core,
+	struct ras_psp_ta_unload *ras_ta_unload)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+
+	if (ta_ctx->preload_ras_ta_enabled)
+		return 0;
+
+	if ((!ras_ta_unload) ||
+	    (ras_ta_unload->ras_session_id != ta_ctx->session_id))
+		return -EINVAL;
+
+	return unload_ras_ta_firmware(ras_core, ras_ta_unload);
+}
+
+int ras_psp_trigger_error(struct ras_core_context *ras_core,
+	struct ras_ta_trigger_error_input *info, uint32_t instance_mask)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+
+	if (!ta_ctx->preload_ras_ta_enabled && !ta_ctx->ras_ta_initialized) {
+		RAS_DEV_ERR(ras_core->dev, "RAS: ras firmware not initialized!");
+		return -ENOEXEC;
+	}
+
+	if (!info)
+		return -EINVAL;
+
+	return trigger_ras_ta_error(ras_core, info, instance_mask);
+}
+
+int ras_psp_query_address(struct ras_core_context *ras_core,
+		struct ras_ta_query_address_input *addr_in,
+		struct ras_ta_query_address_output *addr_out)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+
+	if (!ta_ctx->preload_ras_ta_enabled &&
+	    !ta_ctx->ras_ta_initialized) {
+		RAS_DEV_ERR(ras_core->dev, "RAS: ras firmware not initialized!");
+		return -ENOEXEC;
+	}
+
+	if (!addr_in || !addr_out)
+		return -EINVAL;
+
+	return send_ras_ta_runtime_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRESS,
+		addr_in, sizeof(*addr_in), addr_out, sizeof(*addr_out));
+}
+
+int ras_psp_sw_init(struct ras_core_context *ras_core)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+
+	memset(psp, 0, sizeof(*psp));
+
+	psp->sys_func = ras_core->config->psp_cfg.psp_sys_fn;
+	if (!psp->sys_func) {
+		RAS_DEV_ERR(ras_core->dev, "RAS psp sys function not configured!\n");
+		return -EINVAL;
+	}
+
+	mutex_init(&psp->psp_ctx.internal_mutex);
+	mutex_init(&psp->ta_ctx.ta_mutex);
+
+	return 0;
+}
+
+int ras_psp_sw_fini(struct ras_core_context *ras_core)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+
+	mutex_destroy(&psp->psp_ctx.internal_mutex);
+	mutex_destroy(&psp->ta_ctx.ta_mutex);
+
+	memset(psp, 0, sizeof(*psp));
+
+	return 0;
+}
+
+int ras_psp_hw_init(struct ras_core_context *ras_core)
+{
+	struct ras_psp *psp = &ras_core->ras_psp;
+
+	psp->psp_ip_version = ras_core->config->psp_ip_version;
+
+	psp->ip_func = ras_psp_get_ip_funcs(ras_core, psp->psp_ip_version);
+	if (!psp->ip_func)
+		return -EINVAL;
+
+	/* After GPU reset, the system RAS PSP status may change.
+	 * therefore, it is necessary to synchronize the system status again.
+	 */
+	ras_psp_sync_system_ras_psp_status(ras_core);
+
+	return 0;
+}
+
+int ras_psp_hw_fini(struct ras_core_context *ras_core)
+{
+	return 0;
+}
+
+bool ras_psp_check_supported_cmd(struct ras_core_context *ras_core,
+		enum ras_ta_cmd_id cmd_id)
+{
+	struct ras_ta_ctx *ta_ctx = &ras_core->ras_psp.ta_ctx;
+	bool ret = false;
+
+	if (!ta_ctx->preload_ras_ta_enabled && !ta_ctx->ras_ta_initialized)
+		return false;
+
+	switch (cmd_id) {
+	case RAS_TA_CMD_ID__QUERY_ADDRESS:
+		/* Currently, querying the address from RAS TA is only supported
+		 * when the RAS TA firmware is loaded during driver installation.
+		 */
+		if (ta_ctx->preload_ras_ta_enabled)
+			ret = true;
+		break;
+	case RAS_TA_CMD_ID__TRIGGER_ERROR:
+		ret = true;
+		break;
+	default:
+		ret = false;
+		break;
+	}
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.h b/drivers/gpu/drm/amd/ras/rascore/ras_psp.h
new file mode 100644
index 000000000000..71776fecfd66
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.h
@@ -0,0 +1,145 @@
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
+#ifndef __RAS_PSP_H__
+#define __RAS_PSP_H__
+#include "ras.h"
+#include "ras_ta_if.h"
+
+struct ras_core_context;
+struct ras_ta_trigger_error_input;
+struct ras_ta_query_address_input;
+struct ras_ta_query_address_output;
+enum ras_ta_cmd_id;
+
+struct ras_ta_image_header {
+	uint32_t reserved1[24];
+	uint32_t image_version; /* [0x60] Off Chip Firmware Version */
+	uint32_t reserved2[39];
+};
+
+struct ras_psp_sys_status {
+	bool  initialized;
+	uint32_t session_id;
+	void *psp_cmd_mutex;
+};
+
+struct ras_ta_init_param {
+	uint8_t poison_mode_en;
+	uint8_t dgpu_mode;
+	uint16_t xcc_mask;
+	uint8_t channel_dis_num;
+	uint8_t nps_mode;
+	uint32_t active_umc_mask;
+};
+
+struct gpu_mem_block {
+	uint32_t mem_type;
+	void *mem_bo;
+	uint64_t mem_mc_addr;
+	void *mem_cpu_addr;
+	uint32_t mem_size;
+	int ref_count;
+	void *private;
+};
+
+struct ras_psp_ip_func {
+	uint32_t (*psp_ras_ring_wptr_get)(struct ras_core_context *ras_core);
+	int (*psp_ras_ring_wptr_set)(struct ras_core_context *ras_core, uint32_t wptr);
+};
+
+struct ras_psp_ring {
+	struct gpu_mem_block ras_ring_gpu_mem;
+};
+
+struct psp_cmd_resp {
+	uint32_t status;
+	uint32_t session_id;
+};
+
+struct ras_psp_ctx {
+	void *external_mutex;
+	struct mutex internal_mutex;
+	uint64_t in_fence_value;
+	struct gpu_mem_block psp_cmd_gpu_mem;
+	struct gpu_mem_block out_fence_gpu_mem;
+};
+
+struct ras_ta_fw_bin {
+	uint32_t fw_version;
+	uint32_t feature_version;
+	uint32_t bin_size;
+	uint8_t *bin_addr;
+};
+
+struct ras_ta_ctx {
+	bool  preload_ras_ta_enabled;
+	bool  ras_ta_initialized;
+	uint32_t  session_id;
+	uint32_t  resp_status;
+	uint32_t  ta_version;
+	struct mutex ta_mutex;
+	struct ras_ta_fw_bin fw_bin;
+	struct ras_ta_init_param init_param;
+	struct gpu_mem_block fw_gpu_mem;
+	struct gpu_mem_block cmd_gpu_mem;
+};
+
+struct ras_psp {
+	uint32_t psp_ip_version;
+	struct ras_psp_ring psp_ring;
+	struct ras_psp_ctx  psp_ctx;
+	struct ras_ta_ctx   ta_ctx;
+	const struct ras_psp_ip_func *ip_func;
+	const struct ras_psp_sys_func *sys_func;
+};
+
+struct ras_psp_ta_load {
+	uint32_t fw_version;
+	uint32_t feature_version;
+	uint32_t bin_size;
+	uint8_t *bin_addr;
+	uint64_t out_session_id;
+	uint32_t out_loaded_ta_version;
+};
+
+struct ras_psp_ta_unload {
+	uint64_t ras_session_id;
+};
+
+int ras_psp_sw_init(struct ras_core_context *ras_core);
+int ras_psp_sw_fini(struct ras_core_context *ras_core);
+int ras_psp_hw_init(struct ras_core_context *ras_core);
+int ras_psp_hw_fini(struct ras_core_context *ras_core);
+int ras_psp_load_firmware(struct ras_core_context *ras_core,
+		struct ras_psp_ta_load *ras_ta_load);
+int ras_psp_unload_firmware(struct ras_core_context *ras_core,
+		struct ras_psp_ta_unload *ras_ta_unload);
+int ras_psp_trigger_error(struct ras_core_context *ras_core,
+	struct ras_ta_trigger_error_input *info, uint32_t instance_mask);
+int ras_psp_query_address(struct ras_core_context *ras_core,
+		struct ras_ta_query_address_input *addr_in,
+		struct ras_ta_query_address_output *addr_out);
+bool ras_psp_check_supported_cmd(struct ras_core_context *ras_core,
+		enum ras_ta_cmd_id cmd_id);
+#endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h b/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h
new file mode 100644
index 000000000000..0921e36d3274
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h
@@ -0,0 +1,231 @@
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
+#ifndef _RAS_TA_IF_H
+#define _RAS_TA_IF_H
+#include "ras.h"
+
+#define RAS_TA_HOST_IF_VER	0
+
+/* Responses have bit 31 set */
+#define RSP_ID_MASK (1U << 31)
+#define RSP_ID(cmdId) (((uint32_t)(cmdId)) | RSP_ID_MASK)
+
+/* invalid node instance value */
+#define RAS_TA_INV_NODE 0xffff
+
+/* RAS related enumerations */
+/**********************************************************/
+enum ras_ta_cmd_id {
+	RAS_TA_CMD_ID__ENABLE_FEATURES = 0,
+	RAS_TA_CMD_ID__DISABLE_FEATURES,
+	RAS_TA_CMD_ID__TRIGGER_ERROR,
+	RAS_TA_CMD_ID__QUERY_BLOCK_INFO,
+	RAS_TA_CMD_ID__QUERY_SUB_BLOCK_INFO,
+	RAS_TA_CMD_ID__QUERY_ADDRESS,
+	MAX_RAS_TA_CMD_ID
+};
+
+enum ras_ta_status {
+	RAS_TA_STATUS__SUCCESS                          = 0x0000,
+	RAS_TA_STATUS__RESET_NEEDED                     = 0xA001,
+	RAS_TA_STATUS__ERROR_INVALID_PARAMETER          = 0xA002,
+	RAS_TA_STATUS__ERROR_RAS_NOT_AVAILABLE          = 0xA003,
+	RAS_TA_STATUS__ERROR_RAS_DUPLICATE_CMD          = 0xA004,
+	RAS_TA_STATUS__ERROR_INJECTION_FAILED           = 0xA005,
+	RAS_TA_STATUS__ERROR_ASD_READ_WRITE             = 0xA006,
+	RAS_TA_STATUS__ERROR_TOGGLE_DF_CSTATE           = 0xA007,
+	RAS_TA_STATUS__ERROR_TIMEOUT                    = 0xA008,
+	RAS_TA_STATUS__ERROR_BLOCK_DISABLED             = 0XA009,
+	RAS_TA_STATUS__ERROR_GENERIC                    = 0xA00A,
+	RAS_TA_STATUS__ERROR_RAS_MMHUB_INIT             = 0xA00B,
+	RAS_TA_STATUS__ERROR_GET_DEV_INFO               = 0xA00C,
+	RAS_TA_STATUS__ERROR_UNSUPPORTED_DEV            = 0xA00D,
+	RAS_TA_STATUS__ERROR_NOT_INITIALIZED            = 0xA00E,
+	RAS_TA_STATUS__ERROR_TEE_INTERNAL               = 0xA00F,
+	RAS_TA_STATUS__ERROR_UNSUPPORTED_FUNCTION       = 0xA010,
+	RAS_TA_STATUS__ERROR_SYS_DRV_REG_ACCESS         = 0xA011,
+	RAS_TA_STATUS__ERROR_RAS_READ_WRITE             = 0xA012,
+	RAS_TA_STATUS__ERROR_NULL_PTR                   = 0xA013,
+	RAS_TA_STATUS__ERROR_UNSUPPORTED_IP             = 0xA014,
+	RAS_TA_STATUS__ERROR_PCS_STATE_QUIET            = 0xA015,
+	RAS_TA_STATUS__ERROR_PCS_STATE_ERROR            = 0xA016,
+	RAS_TA_STATUS__ERROR_PCS_STATE_HANG             = 0xA017,
+	RAS_TA_STATUS__ERROR_PCS_STATE_UNKNOWN          = 0xA018,
+	RAS_TA_STATUS__ERROR_UNSUPPORTED_ERROR_INJ      = 0xA019,
+	RAS_TA_STATUS__TEE_ERROR_ACCESS_DENIED          = 0xA01A
+};
+
+enum ras_ta_block {
+	RAS_TA_BLOCK__UMC = 0,
+	RAS_TA_BLOCK__SDMA,
+	RAS_TA_BLOCK__GFX,
+	RAS_TA_BLOCK__MMHUB,
+	RAS_TA_BLOCK__ATHUB,
+	RAS_TA_BLOCK__PCIE_BIF,
+	RAS_TA_BLOCK__HDP,
+	RAS_TA_BLOCK__XGMI_WAFL,
+	RAS_TA_BLOCK__DF,
+	RAS_TA_BLOCK__SMN,
+	RAS_TA_BLOCK__SEM,
+	RAS_TA_BLOCK__MP0,
+	RAS_TA_BLOCK__MP1,
+	RAS_TA_BLOCK__FUSE,
+	RAS_TA_BLOCK__MCA,
+	RAS_TA_BLOCK__VCN,
+	RAS_TA_BLOCK__JPEG,
+	RAS_TA_BLOCK__IH,
+	RAS_TA_BLOCK__MPIO,
+	RAS_TA_BLOCK__MMSCH,
+	RAS_TA_NUM_BLOCK_MAX
+};
+
+enum ras_ta_mca_block {
+	RAS_TA_MCA_BLOCK__MP0   = 0,
+	RAS_TA_MCA_BLOCK__MP1   = 1,
+	RAS_TA_MCA_BLOCK__MPIO  = 2,
+	RAS_TA_MCA_BLOCK__IOHC  = 3,
+	RAS_TA_MCA_NUM_BLOCK_MAX
+};
+
+enum ras_ta_error_type {
+	RAS_TA_ERROR__NONE			= 0,
+	RAS_TA_ERROR__PARITY			= 1,
+	RAS_TA_ERROR__SINGLE_CORRECTABLE	= 2,
+	RAS_TA_ERROR__MULTI_UNCORRECTABLE	= 4,
+	RAS_TA_ERROR__POISON			= 8,
+};
+
+enum ras_ta_address_type {
+	RAS_TA_MCA_TO_PA,
+	RAS_TA_PA_TO_MCA,
+};
+
+enum ras_ta_nps_mode {
+	RAS_TA_UNKNOWN_MODE = 0,
+	RAS_TA_NPS1_MODE = 1,
+	RAS_TA_NPS2_MODE = 2,
+	RAS_TA_NPS4_MODE = 4,
+	RAS_TA_NPS8_MODE = 8,
+};
+
+/* Input/output structures for RAS commands */
+/**********************************************************/
+
+struct ras_ta_enable_features_input {
+	enum ras_ta_block	block_id;
+	enum ras_ta_error_type	error_type;
+};
+
+struct ras_ta_disable_features_input {
+	enum ras_ta_block	block_id;
+	enum ras_ta_error_type	error_type;
+};
+
+struct ras_ta_trigger_error_input {
+	/* ras-block. i.e. umc, gfx */
+	enum ras_ta_block block_id;
+
+	/* type of error. i.e. single_correctable */
+	enum ras_ta_error_type inject_error_type;
+
+	/* mem block. i.e. hbm, sram etc. */
+	uint32_t sub_block_index;
+
+	/* explicit address of error */
+	uint64_t address;
+
+	/* method if error injection. i.e persistent, coherent etc. */
+	uint64_t value;
+};
+
+struct ras_ta_init_flags {
+	uint8_t poison_mode_en;
+	uint8_t dgpu_mode;
+	uint16_t xcc_mask;
+	uint8_t channel_dis_num;
+	uint8_t nps_mode;
+	uint32_t active_umc_mask;
+};
+
+struct ras_ta_mca_addr {
+	uint64_t err_addr;
+	uint32_t ch_inst;
+	uint32_t umc_inst;
+	uint32_t node_inst;
+	uint32_t socket_id;
+};
+
+struct ras_ta_phy_addr {
+	uint64_t pa;
+	uint32_t bank;
+	uint32_t channel_idx;
+};
+
+struct ras_ta_query_address_input {
+	enum ras_ta_address_type addr_type;
+	struct ras_ta_mca_addr ma;
+	struct ras_ta_phy_addr pa;
+};
+
+struct ras_ta_output_flags {
+	uint8_t ras_init_success_flag;
+	uint8_t err_inject_switch_disable_flag;
+	uint8_t reg_access_failure_flag;
+};
+
+struct ras_ta_query_address_output {
+	/* don't use the flags here */
+	struct ras_ta_output_flags flags;
+	struct ras_ta_mca_addr ma;
+	struct ras_ta_phy_addr pa;
+};
+
+/* Common input structure for RAS callbacks */
+/**********************************************************/
+union ras_ta_cmd_input {
+	struct ras_ta_init_flags		init_flags;
+	struct ras_ta_enable_features_input	enable_features;
+	struct ras_ta_disable_features_input	disable_features;
+	struct ras_ta_trigger_error_input	trigger_error;
+	struct ras_ta_query_address_input	address;
+	uint32_t reserve_pad[256];
+};
+
+union ras_ta_cmd_output {
+	struct ras_ta_output_flags flags;
+	struct ras_ta_query_address_output address;
+	uint32_t reserve_pad[256];
+};
+
+struct ras_ta_cmd {
+	uint32_t  cmd_id;
+	uint32_t  resp_id;
+	uint32_t  ras_status;
+	uint32_t  if_version;
+	union ras_ta_cmd_input  ras_in_message;
+	union ras_ta_cmd_output ras_out_message;
+};
+
+#endif
-- 
2.34.1

