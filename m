Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8CFCAC59A
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Sep 2025 02:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0464610E383;
	Mon, 22 Sep 2025 02:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I/QESNdr";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD2710E383
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Sep 2025 02:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycCNkZ+Vmyfli45dUfZnDnUJxkZXgcVGkYSmJRW5XS7Swoi4Iq0tKw6U2J5zm47hftFtjY55bKv1symdtw0akAH/1m60Aei84LziHOquF28ga5GWPA3hCAal/WD6G8237q7Tn+NqKCvqkb+gPBqHuqaQx6rTJuwO9P5Gt3/t13rp5QGJ2+88sGcOOXK+diV5Wu2ggI+FtQEQww5Ppr3R4cdHNIUPJNZ3Z+6HtnFEwuzK02oEdVVA4Ig6o40IrmdkIgMndBjpXZj30b6vraI058lBM9G7EH1ThpBkZbRLiGBatl4j6LZUKJxZ0xOqaAej73FWtzGqlgcf81DaXovfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0sFTpZRE3ZlFZ0uYnNdksagq+pklEnXmrqPpNoytMA=;
 b=ZqwXJu8gNmkByHi11b/YpD/zWezr/Bjqv9IPuvhQq5kK+P0XxyNHUYs/ZNs8pq1zr0GN8QA3KZsHjTdP+zMMYsUkT5z4EzlIt6xqQFw3YW60MWydy0KzhN7pQU4kap3Ffd23F/kXTaacjLJCdWXIIQG5Vj3B9ZtWGojayci8oqNJpKARAZ0o8YVCHy8KH8CjwLlfB6QB9wVcnZ9MU+V2yg8II8xTzQEnZhZN/7LpbwkH0EfGEQtT0kPWakGvRfmKXl65Qyb/47412N3g7/Vfd9DvBxEdpfoi/DUdgqmEp7DpfzryMk+KCnz8n8QZ75fIbH/sQKsoHWuLdAVIt9B8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0sFTpZRE3ZlFZ0uYnNdksagq+pklEnXmrqPpNoytMA=;
 b=I/QESNdr5AvyaL+uZ6/0Y3Sagjm2Vp6xjs07RHnBh/ZqXsWcp8NXXNfiVTOltm4WCdYcpp+AmzdOfmje7kKy1VhrG73mj9ilqAXSxluHsh433H5n+m1MGXT8wCgPYRzKZoKb7OaLL/7F2sliTPsNmrSS1TdL8c9Biw6h9KYG3CY=
Received: from BYAPR01CA0044.prod.exchangelabs.com (2603:10b6:a03:94::21) by
 BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:39:58 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:a03:94:cafe::75) by BYAPR01CA0044.outlook.office365.com
 (2603:10b6:a03:94::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 02:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.0 via Frontend Transport; Mon, 22 Sep 2025 02:39:56 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 19:39:53 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH V5 16/20] drm/amd/ras: Add thread to handle ras events
Date: Mon, 22 Sep 2025 10:38:40 +0800
Message-ID: <20250922023844.3108065-16-YiPeng.Chai@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e580b4-fc0d-4e9c-ddd8-08ddf9815175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vH/WIMlQjJyQRRgC8Zxmxi9xxx36U2+8b6WelKaxZO+8YwVW5JWNc+6keYaH?=
 =?us-ascii?Q?0CbHFyWAfjkJ2L39wolvOn48AKPHX8hnNHutzfo6nY9cngKlt4Nl7+npHU8Z?=
 =?us-ascii?Q?G9G9w7P41PGSt8iamzIZjmHQIGisl0620S8drulFa+hg2cjTnuYoFLVY/Rb5?=
 =?us-ascii?Q?C6P5o9AEY9ZFNK1hbVVLcHK8j5SmBZXvTXemYOUUz7/OhJooOOG75criifFo?=
 =?us-ascii?Q?GXhhBB3Swg788fkJZsOtj0iNLtpZHhNw8bSQWcDiYA6KGZFebIAN/bgLchNA?=
 =?us-ascii?Q?yOmCVoOeJGVJqOQpqXxwFKFOSKNARugp7v9S4WyAbO7fYbQc+OfzEnVuNMru?=
 =?us-ascii?Q?r+ku6FIsLj3yvSfSQSlHf3UilqmDYOIQh7R/wbyAB82oZU/q5nHCjN+gbYVX?=
 =?us-ascii?Q?R/pXQCvRBy8NhNshVljwWeEo0bncsGarVFiO/lgVBlKmVVwefM2EX5XzSpKf?=
 =?us-ascii?Q?EeO0ZWHTXELcR7r7htOTbiMuyuMNskO6/jh0x730AxON5ojkvsy1Awc64BPo?=
 =?us-ascii?Q?FIfC3en7vyRRpxIVQ16ofoxkCR1yCN/DrXrcoPTduISxW+0nqNzQ4MctPZ6z?=
 =?us-ascii?Q?MddF5h+SX0XB45y4ZngoOpE/CoIRrDbbRBQAefr+iPL6qTE/qxnxVzfSkq2U?=
 =?us-ascii?Q?DW8fXB+84nD0GEQH0tHCE8pD5nEaRQiUiLNM2tnL9AYylU1XIWVf9FJ7sWZ/?=
 =?us-ascii?Q?rTM69BERA5Cuh6U34f0FqK2tqk0l5KsstgUbPjhX+aoGtd/R4MmlX7klar33?=
 =?us-ascii?Q?aDA/8zWYJ2CTOEqBq+RRTDB8UZv24e+w7pDv+slwq0gttcfUTfJNlhbO8iN3?=
 =?us-ascii?Q?PxPsIciF6Lkm8wkrlOCF68pw8m8Na/AXHTBUjQpLr1XzOxRAumQBxLVLKKKs?=
 =?us-ascii?Q?UQ0oQwCuSsSGey7vI7w5yOuR2fRZwEjoEraIn/xDXlg9spPf0llMK9ncq349?=
 =?us-ascii?Q?XDG9jEHDXIJ9NNsuLsLGabYPGwnrJb/UEqxkYMfww+dG9mPh2anrcTY/Yckq?=
 =?us-ascii?Q?P9cSdD06B60fWbQxc16bBRwS4S+lQp57R7sc4/NNLG0viWUd5dZyNeO2A0q6?=
 =?us-ascii?Q?gPcizFbDL2oxMXlLyFwj0cX768gzu7dGzXsM6TIb4wXLpr9gsq+kFoS3WFL/?=
 =?us-ascii?Q?9bWe1fFvlBIcRKBCLPxFmt7HibgNXIEWqeFLcxEGY/PLTShiSYfn34rCbxG0?=
 =?us-ascii?Q?YWgGBRenOJX4/eknSbmRZ4CDKrWx9KyiTR72hZ7NRYQ7BG6EKqU/jzARVPc4?=
 =?us-ascii?Q?l0IdTJ9z3/Ug0AnnBDejx3NtKdgqsppcCwOF/pjKiciLOje44xcEIUsPs5T8?=
 =?us-ascii?Q?+BYPb83XHOVH7BK797LrYlmkPOPHDYsvvagUXVfB95WLoFqYkW9bMYjGwFEb?=
 =?us-ascii?Q?Pxk+Vamb/7gJVqRj+FlESTPc6ievBLCCGJ9YzpgpU8caF2d5UO8PeZG19ydX?=
 =?us-ascii?Q?Mu2bTmAhPBYp9QBG/6ztSNJL5fTqCB1Z4hUZshmj4Nmgl8NAdmF7VVAHG3Hc?=
 =?us-ascii?Q?OC+pnk64z+Q1sUw1ktXV9W2oaUk1B2JOMyay?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:39:56.7924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e580b4-fc0d-4e9c-ddd8-08ddf9815175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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

Add thread to handle ras events.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_process.c | 315 ++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras_process.h |  53 +++
 2 files changed, 368 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_process.c
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/ras_process.h

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
new file mode 100644
index 000000000000..02f0657f78a3
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
@@ -0,0 +1,315 @@
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
+#include "ras_process.h"
+
+#define RAS_EVENT_FIFO_SIZE (128 * sizeof(struct ras_event_req))
+
+#define RAS_POLLING_ECC_TIMEOUT  300
+
+static int ras_process_put_event(struct ras_core_context *ras_core,
+		struct ras_event_req *req)
+{
+	struct ras_process *ras_proc = &ras_core->ras_proc;
+	int ret;
+
+	ret = kfifo_in_spinlocked(&ras_proc->event_fifo,
+			req, sizeof(*req), &ras_proc->fifo_spinlock);
+	if (!ret) {
+		RAS_DEV_ERR(ras_core->dev, "Poison message fifo is full!\n");
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
+static int ras_process_add_reset_gpu_event(struct ras_core_context *ras_core,
+			uint32_t reset_cause)
+{
+	struct ras_event_req req = {0};
+
+	req.reset = reset_cause;
+
+	return ras_process_put_event(ras_core, &req);
+}
+
+static int ras_process_get_event(struct ras_core_context *ras_core,
+		struct ras_event_req *req)
+{
+	struct ras_process *ras_proc = &ras_core->ras_proc;
+
+	return kfifo_out_spinlocked(&ras_proc->event_fifo,
+				req, sizeof(*req), &ras_proc->fifo_spinlock);
+}
+
+static void ras_process_clear_event_fifo(struct ras_core_context *ras_core)
+{
+	struct ras_event_req req;
+	int ret;
+
+	do {
+		ret = ras_process_get_event(ras_core, &req);
+	} while (ret);
+}
+
+#define AMDGPU_RAS_WAITING_DATA_READY  200
+static int ras_process_umc_event(struct ras_core_context *ras_core,
+				uint32_t event_count)
+{
+	struct ras_ecc_count ecc_data;
+	int ret = 0;
+	uint32_t timeout = 0;
+	uint32_t detected_de_count = 0;
+
+	do {
+		memset(&ecc_data, 0, sizeof(ecc_data));
+		ret = ras_core_update_ecc_info(ras_core);
+		if (ret)
+			return ret;
+
+		ret = ras_core_query_block_ecc_data(ras_core, RAS_BLOCK_ID__UMC, &ecc_data);
+		if (ret)
+			return ret;
+
+		if (ecc_data.new_de_count) {
+			detected_de_count += ecc_data.new_de_count;
+			timeout = 0;
+		} else {
+			if (!timeout && event_count)
+				timeout = AMDGPU_RAS_WAITING_DATA_READY;
+
+			if (timeout) {
+				if (!--timeout)
+					break;
+
+				msleep(1);
+			}
+		}
+	} while (detected_de_count < event_count);
+
+	if (detected_de_count && ras_core_gpu_is_rma(ras_core))
+		ras_process_add_reset_gpu_event(ras_core, GPU_RESET_CAUSE_RMA);
+
+	return 0;
+}
+
+static int ras_process_non_umc_event(struct ras_core_context *ras_core)
+{
+	struct ras_process *ras_proc = &ras_core->ras_proc;
+	struct ras_event_req req;
+	uint32_t event_count = kfifo_len(&ras_proc->event_fifo);
+	uint32_t reset_flags = 0;
+	int ret = 0, i;
+
+	for (i = 0; i < event_count; i++) {
+		memset(&req, 0, sizeof(req));
+		ret = ras_process_get_event(ras_core, &req);
+		if (!ret)
+			continue;
+
+		ras_core_event_notify(ras_core,
+			RAS_EVENT_ID__POISON_CONSUMPTION, &req);
+
+		reset_flags |= req.reset;
+
+		if (req.reset == GPU_RESET_CAUSE_RMA)
+			continue;
+
+		if (req.reset)
+			RAS_DEV_INFO(ras_core->dev,
+				"{%llu} GPU reset for %s RAS poison consumption is issued!\n",
+				req.seqno, ras_core_get_ras_block_name(req.block));
+		else
+			RAS_DEV_INFO(ras_core->dev,
+				"{%llu} %s RAS poison consumption is issued!\n",
+				req.seqno, ras_core_get_ras_block_name(req.block));
+	}
+
+	if (reset_flags) {
+		ret = ras_core_event_notify(ras_core,
+				RAS_EVENT_ID__RESET_GPU, &reset_flags);
+		if (!ret && (reset_flags & GPU_RESET_CAUSE_RMA))
+			return -RAS_CORE_GPU_IN_MODE1_RESET;
+	}
+
+	return ret;
+}
+
+int ras_process_handle_ras_event(struct ras_core_context *ras_core)
+{
+	struct ras_process *ras_proc = &ras_core->ras_proc;
+	uint32_t umc_event_count;
+	int ret;
+
+	ras_aca_clear_fatal_flag(ras_core);
+	ras_umc_log_pending_bad_bank(ras_core);
+
+	do {
+		umc_event_count = atomic_read(&ras_proc->umc_interrupt_count);
+		ret = ras_process_umc_event(ras_core, umc_event_count);
+		if (ret == -RAS_CORE_GPU_IN_MODE1_RESET)
+			break;
+
+		if (umc_event_count)
+			atomic_sub(umc_event_count, &ras_proc->umc_interrupt_count);
+	} while (atomic_read(&ras_proc->umc_interrupt_count));
+
+	if ((ret != -RAS_CORE_GPU_IN_MODE1_RESET) &&
+			(kfifo_len(&ras_proc->event_fifo)))
+		ret = ras_process_non_umc_event(ras_core);
+
+	if (ret == -RAS_CORE_GPU_IN_MODE1_RESET) {
+		/* Clear poison fifo */
+		ras_process_clear_event_fifo(ras_core);
+		atomic_set(&ras_proc->umc_interrupt_count, 0);
+	}
+
+	return ret;
+}
+
+static int thread_wait_condition(void *param)
+{
+	struct ras_process *ras_proc = (struct ras_process *)param;
+
+	return (kthread_should_stop() ||
+		atomic_read(&ras_proc->ras_interrupt_req));
+}
+
+static int ras_process_thread(void *context)
+{
+	struct ras_core_context *ras_core = (struct ras_core_context *)context;
+	struct ras_process *ras_proc = &ras_core->ras_proc;
+
+	while (!kthread_should_stop()) {
+		ras_wait_event_interruptible_timeout(&ras_proc->ras_process_wq,
+			thread_wait_condition, ras_proc,
+			msecs_to_jiffies(RAS_POLLING_ECC_TIMEOUT));
+
+		if (kthread_should_stop())
+			break;
+
+		if (!ras_core->is_initialized)
+			continue;
+
+		atomic_set(&ras_proc->ras_interrupt_req, 0);
+
+		if (ras_core_gpu_in_reset(ras_core))
+			continue;
+
+		if (ras_core->sys_fn && ras_core->sys_fn->async_handle_ras_event)
+			ras_core->sys_fn->async_handle_ras_event(ras_core, NULL);
+		else
+			ras_process_handle_ras_event(ras_core);
+	}
+
+	return 0;
+}
+
+int ras_process_init(struct ras_core_context *ras_core)
+{
+	struct ras_process *ras_proc = &ras_core->ras_proc;
+	int ret;
+
+	ret = kfifo_alloc(&ras_proc->event_fifo, RAS_EVENT_FIFO_SIZE, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&ras_proc->fifo_spinlock);
+
+	init_waitqueue_head(&ras_proc->ras_process_wq);
+
+	ras_proc->ras_process_thread = kthread_run(ras_process_thread,
+							(void *)ras_core, "ras_process_thread");
+	if (!ras_proc->ras_process_thread) {
+		RAS_DEV_ERR(ras_core->dev, "Failed to create ras_process_thread.\n");
+		ret =  -ENOMEM;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	ras_process_fini(ras_core);
+	return ret;
+}
+
+int ras_process_fini(struct ras_core_context *ras_core)
+{
+	struct ras_process *ras_proc = &ras_core->ras_proc;
+
+	if (ras_proc->ras_process_thread) {
+		kthread_stop(ras_proc->ras_process_thread);
+		ras_proc->ras_process_thread = NULL;
+	}
+
+	kfifo_free(&ras_proc->event_fifo);
+
+	return 0;
+}
+
+static int ras_process_add_umc_interrupt_req(struct ras_core_context *ras_core,
+			struct ras_event_req *req)
+{
+	struct ras_process *ras_proc = &ras_core->ras_proc;
+
+	atomic_inc(&ras_proc->umc_interrupt_count);
+	atomic_inc(&ras_proc->ras_interrupt_req);
+
+	wake_up(&ras_proc->ras_process_wq);
+	return 0;
+}
+
+static int ras_process_add_non_umc_interrupt_req(struct ras_core_context *ras_core,
+		struct ras_event_req *req)
+{
+	struct ras_process *ras_proc = &ras_core->ras_proc;
+	int ret;
+
+	ret = ras_process_put_event(ras_core, req);
+	if (!ret) {
+		atomic_inc(&ras_proc->ras_interrupt_req);
+		wake_up(&ras_proc->ras_process_wq);
+	}
+
+	return ret;
+}
+
+int ras_process_add_interrupt_req(struct ras_core_context *ras_core,
+	struct ras_event_req *req, bool is_umc)
+{
+	int ret;
+
+	if (!ras_core)
+		return -EINVAL;
+
+	if (!ras_core->is_initialized)
+		return -EPERM;
+
+	if (is_umc)
+		ret = ras_process_add_umc_interrupt_req(ras_core, req);
+	else
+		ret = ras_process_add_non_umc_interrupt_req(ras_core, req);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.h b/drivers/gpu/drm/amd/ras/rascore/ras_process.h
new file mode 100644
index 000000000000..28458b50510e
--- /dev/null
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.h
@@ -0,0 +1,53 @@
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
+#ifndef __RAS_PROCESS_H__
+#define __RAS_PROCESS_H__
+
+struct ras_event_req {
+	uint64_t seqno;
+	uint32_t idx_vf;
+	uint32_t block;
+	uint16_t pasid;
+	uint32_t reset;
+	void *pasid_fn;
+	void *data;
+};
+
+struct ras_process {
+	void *dev;
+	void *ras_process_thread;
+	wait_queue_head_t ras_process_wq;
+	atomic_t ras_interrupt_req;
+	atomic_t umc_interrupt_count;
+	struct kfifo event_fifo;
+	spinlock_t fifo_spinlock;
+};
+
+struct ras_core_context;
+int ras_process_init(struct ras_core_context *ras_core);
+int ras_process_fini(struct ras_core_context *ras_core);
+int ras_process_handle_ras_event(struct ras_core_context *ras_core);
+int ras_process_add_interrupt_req(struct ras_core_context *ras_core,
+		struct ras_event_req *req, bool is_umc);
+#endif
-- 
2.34.1

