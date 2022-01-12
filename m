Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250EBC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 22:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A026810E930;
	Wed, 12 Jan 2022 22:00:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEFF310E930
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 22:00:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jd81ETMp1vU2FyzHCynaeunHWcDTJI3xn9XnxfUjUy45dDKIUfnkFQGO8ea9Kx/vtkg/rr7Lj6OZ3YwKB6VRKt+C1YEZ0cEaLgnwys2R2lAwjOJskZrbfIXajXGC07rSX/Qa08qfEsQ8LYRrSClDloUQ9gk/vZfN3hjKSrHd4LnuaQd8LfvAms20kQ5tdn9GKgVRz4UVhkYy+fRYzUuz7HwhVhAWk60yf4dJpkCanJz+nJ7nQJQOZ1ekzDGpnA7v1RLLRphFSUqYYQ8ZHQxuj82pgJi5schaXv6TPZo923dO8Ku67tWqBUtlzsyca7yW0ulQ34qg8uCU7uKIXTxGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5syF0SZfpz5bKNNXwxV9e53rKCxY8YVoLcJcbuVAoJI=;
 b=hIBVTF4w0EN1Oc49CWbWQU9VN5DvNi1D03rSNkPYUjKdUn+4W4vYoGY/VXo48SEQ07wU+IOn35ULEwJR3wZivkQSrQc9qPbcEm9eBVkd7+chdDaC3YrCPEJ+4lUnOsPDxm2NvhfgR5t5Bw7jAEiKPBpuE34EZRNhY4fLq4smac9CHz3s/G8tr0BD2K3o43XRIJoVaeeLjaDKvljr5qtkyAIONMQbL/N+TyUlt0l01Ryrvj+FZ8lJlcVIM4hSWsqCw3yAg1t71zaG9hSTMx1wPRK4Rfznxh1SWUf7krP+jfHyW871VFDEELcbikqrQ8PHCl/VYoWkv4IHwFPZ7s2YfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5syF0SZfpz5bKNNXwxV9e53rKCxY8YVoLcJcbuVAoJI=;
 b=ZCA6EDxXOtdFJb8tvDEL1IWa8uS0DCyeI1jXT0dhxkguH1sIJeMJ3RoOAdStdlxOinMEplYqO7iZPmpekWuKFLICo27um3abPmPQJHwan1Q7JpdFJHpMWuVDuNnTSO+IGy7uySzQwF2IEpSrmVOQBpTO+i9+/OMcf818S3zHThw=
Received: from CO2PR04CA0139.namprd04.prod.outlook.com (2603:10b6:104::17) by
 SN6PR12MB4703.namprd12.prod.outlook.com (2603:10b6:805:ee::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Wed, 12 Jan 2022 21:59:58 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::bd) by CO2PR04CA0139.outlook.office365.com
 (2603:10b6:104::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 21:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 21:59:57 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 15:59:56 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: use proper interrupt handling for gfx10
Date: Wed, 12 Jan 2022 16:59:43 -0500
Message-ID: <20220112215943.3053567-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ad3fb8a-d38d-43d6-f431-08d9d616df92
X-MS-TrafficTypeDiagnostic: SN6PR12MB4703:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB4703671FEFED7A30E325370485529@SN6PR12MB4703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LX2Tdvcn0QNJpKa/8Nt0TiecOBpIndbcgrXgqEL1q/JHM6DQllEQOMEaO9QqoEj74bBFUszr8JbjQNXMX5DGyMw9RJhBjOuJ6EH5TxKBJ+9tXiSXJ4DGqBIhCNxdPJLiWlZEUHuAb96KFwExd+3KufaBdhdJ2tDZ99PFYN1RDq/tiMLFj4UIiqecOiOCyAScGDALGPT0g8L+s+QC4bCItmwCDTQoUUrgHyvmV/BuSHDFhOzCDb9N+u8a52qfcdVkAanECPnGU/EBjHAjRpFvQfnJ4w+0HjsF3Q+SGPvw8cxa+Ig2asX5gW8Vnlv1uj3ekysbiAh9CZ6sThzjwXe7Ewq1MmOewx+9t6sMv/sYaP7GNJQsPXkXYM9ea0hqXSnEiCJ83rmm8YQ+wY0vJdtTAus3qKmxuKaaT4fMtxqb/fc3jeN4Kx9qUj3OCwnzWt82shL5cxAAT0DARRToOzR9wASe66irxoorMk73ZToRHMIOdYVwvghrfcN++S3cf8nXSfM8Vs+EfvGDMkmB9mwgGrfMr0+an3yreKJibqVr9F7ImSEvcwoVRD8uuvj9QjqMcOyyBzzBOVYVeq37hGGj0KQX2W3zffDMz2Cmm48l0q/ATrOsJZICz5+0NwM9GP76DJX09XSl1847LSzhSBqsjHfI380zKjcNN6EYsRMzhzqdKs+xUM4VLIgxn6F/9H6tKFqUjnZZSC7DB5OcAmLWH89ww/ZKKDoVe2K75W7qA0ioLuTGddPeXFIwfzrsCQ6f+hstgDC31Hk7YTos4Q6jwj8fnlqyOFmk44habJLuxcc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(70206006)(70586007)(5660300002)(7696005)(2616005)(508600001)(4326008)(426003)(40460700001)(1076003)(356005)(83380400001)(8676002)(336012)(81166007)(30864003)(8936002)(316002)(36860700001)(44832011)(6916009)(82310400004)(2906002)(26005)(16526019)(86362001)(6666004)(47076005)(54906003)(186003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 21:59:57.6647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad3fb8a-d38d-43d6-f431-08d9d616df92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4703
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFX has the following changes when handling interrupts in the KFD:
- no pasid workaround required
- SQ interrupt auto has different events
- SQ interrupt word is continguous and only has 23-bit data.
Also SH is labelled as SA and workgroup id replaces CU id.
- SQ interrupt word is continguos and only has 23 bits for err type and
err details.
- Sienna Cichlid uses a different client ID for SDMA3
(see soc15_ih_clients).

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile           |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 313 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 4 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index c4f3aff11072..87851840e9bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -51,6 +51,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_events.o \
 		$(AMDKFD_PATH)/cik_event_interrupt.o \
 		$(AMDKFD_PATH)/kfd_int_process_v9.o \
+		$(AMDKFD_PATH)/kfd_int_process_v10.o \
 		$(AMDKFD_PATH)/kfd_dbgdev.o \
 		$(AMDKFD_PATH)/kfd_dbgmgr.o \
 		$(AMDKFD_PATH)/kfd_smi_events.o \
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 5a47f437b455..7926e3b5a3e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -107,6 +107,8 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(9, 4, 0): /* VEGA20 */
 	case IP_VERSION(9, 4, 1): /* ARCTURUS */
 	case IP_VERSION(9, 4, 2): /* ALDEBARAN */
+		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
+		break;
 	case IP_VERSION(10, 3, 1): /* VANGOGH */
 	case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
 	case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
@@ -117,7 +119,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
 	case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
 	case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
-		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
+		kfd->device_info.event_interrupt_class = &event_interrupt_class_v10;
 		break;
 	default:
 		dev_warn(kfd_device, "v9 event interrupt handler is set due to "
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
new file mode 100644
index 000000000000..c9475f07dddf
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -0,0 +1,313 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#include "kfd_smi_events.h"
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
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE__SHIFT 0
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__WLT__SHIFT 1
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_BUF0_FULL__SHIFT 2
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_BUF1_FULL__SHIFT 3
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_UTC_ERROR__SHIFT 7
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__SE_ID__SHIFT 36
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__ENCODING__SHIFT 38
+
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_MASK 0x00000001
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__WLT_MASK 0x00000002
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_BUF0_FULL_MASK 0x00000004
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_BUF1_FULL_MASK 0x00000008
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__THREAD_TRACE_UTC_ERROR_MASK 0x00000080
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__SE_ID_MASK 0x03000000000
+#define SQ_INTERRUPT_WORD_AUTO_CTXID__ENCODING_MASK 0x0c000000000
+
+/* SQ_INTERRUPT_WORD_WAVE_CTXID */
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__DATA__SHIFT 0
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SA_ID__SHIFT 23
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__PRIV__SHIFT 24
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__WAVE_ID__SHIFT 25
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SIMD_ID__SHIFT 30
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__WGP_ID__SHIFT 32
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SE_ID__SHIFT 36
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__ENCODING__SHIFT 38
+
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__DATA_MASK 0x000007fffff
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SA_ID_MASK 0x0000800000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__PRIV_MASK 0x00001000000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__WAVE_ID_MASK 0x0003e000000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SIMD_ID_MASK 0x000c0000000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__WGP_ID_MASK 0x00f00000000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__SE_ID_MASK 0x03000000000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID__ENCODING_MASK 0x0c000000000
+
+#define KFD_CONTEXT_ID_GET_SQ_INT_WORD(ctx0, ctx1)  ((ctx0) | (ctx1 << 32))
+
+#define KFD_SQ_INT_DATA__ERR_TYPE_MASK 0x780000
+#define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 19
+
+static void event_interrupt_poison_consumption(struct kfd_dev *dev,
+				uint16_t pasid, uint16_t source_id)
+{
+	int ret = -EINVAL;
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
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
+		if (dev->dqm->ops.reset_queues)
+			ret = dev->dqm->ops.reset_queues(dev->dqm, pasid);
+		break;
+	case SOC15_INTSRC_SDMA_ECC:
+	default:
+		break;
+	}
+
+	kfd_signal_poison_consumed_event(dev, pasid);
+
+	/* resetting queue passes, do page retirement without gpu reset
+	   resetting queue fails, fallback to gpu reset solution */
+	if (!ret)
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
+	else
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
+}
+
+static bool event_interrupt_isr_v10(struct kfd_dev *dev,
+					const uint32_t *ih_ring_entry,
+					uint32_t *patched_ihre,
+					bool *patched_flag)
+{
+	uint16_t source_id, client_id, pasid, vmid;
+	const uint32_t *data = ih_ring_entry;
+
+	/* Only handle interrupts from KFD VMIDs */
+	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
+	if (vmid < dev->vm_info.first_vmid_kfd ||
+	    vmid > dev->vm_info.last_vmid_kfd)
+		return false;
+
+	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
+	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
+
+	/* Only handle clients we care about */
+	if (client_id != SOC15_IH_CLIENTID_GRBM_CP &&
+	    client_id != SOC15_IH_CLIENTID_SDMA0 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA1 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA2 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA3 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA4 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA5 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA6 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA7 &&
+	    client_id != SOC15_IH_CLIENTID_VMC &&
+	    client_id != SOC15_IH_CLIENTID_VMC1 &&
+	    client_id != SOC15_IH_CLIENTID_UTCL2 &&
+	    client_id != SOC15_IH_CLIENTID_SE0SH &&
+	    client_id != SOC15_IH_CLIENTID_SE1SH &&
+	    client_id != SOC15_IH_CLIENTID_SE2SH &&
+	    client_id != SOC15_IH_CLIENTID_SE3SH)
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
+		source_id == SOC15_INTSRC_SDMA_TRAP ||
+		source_id == SOC15_INTSRC_SDMA_ECC ||
+		source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG ||
+		source_id == SOC15_INTSRC_CP_BAD_OPCODE ||
+		((client_id == SOC15_IH_CLIENTID_VMC ||
+		client_id == SOC15_IH_CLIENTID_VMC1 ||
+		client_id == SOC15_IH_CLIENTID_UTCL2) &&
+		!amdgpu_no_queue_eviction_on_vm_fault);
+}
+
+static void event_interrupt_wq_v10(struct kfd_dev *dev,
+					const uint32_t *ih_ring_entry)
+{
+	uint8_t sq_intr_err_type, encoding;
+	uint16_t source_id, client_id, pasid, vmid;
+	uint32_t context_id0, context_id1;
+	uint64_t sq_intr_word;
+
+	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
+	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
+	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
+	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
+	context_id1 = SOC15_CONTEXT_ID1_FROM_IH_ENTRY(ih_ring_entry);
+
+	if (client_id == SOC15_IH_CLIENTID_GRBM_CP ||
+	    client_id == SOC15_IH_CLIENTID_SE0SH ||
+	    client_id == SOC15_IH_CLIENTID_SE1SH ||
+	    client_id == SOC15_IH_CLIENTID_SE2SH ||
+	    client_id == SOC15_IH_CLIENTID_SE3SH) {
+		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
+			kfd_signal_event_interrupt(pasid, context_id0, 32);
+		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG) {
+			sq_intr_word = KFD_CONTEXT_ID_GET_SQ_INT_WORD(context_id0,
+								(uint64_t)context_id1);
+			encoding = REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+								ENCODING);
+			switch (encoding) {
+			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
+				pr_debug(
+					"sq_intr: auto, se %lld, ttrace %lld, wlt %lld, ttrac_buf0_full %lld, ttrac_buf1_full %lld, ttrace_utc_err %lld\n",
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_AUTO_CTXID,
+							SE_ID),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_AUTO_CTXID,
+							THREAD_TRACE),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_AUTO_CTXID,
+							WLT),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_AUTO_CTXID,
+							THREAD_TRACE_BUF0_FULL),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_AUTO_CTXID,
+							THREAD_TRACE_BUF1_FULL),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_AUTO_CTXID,
+							THREAD_TRACE_UTC_ERROR));
+				break;
+			case SQ_INTERRUPT_WORD_ENCODING_INST:
+				pr_debug("sq_intr: inst, se %lld, data 0x%llx, sa %lld, priv %lld, wave_id %lld, simd_id %lld, wgp_id %lld\n",
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							SE_ID),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							DATA),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							SA_ID),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							PRIV),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							WAVE_ID),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							SIMD_ID),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							WGP_ID));
+				break;
+			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
+				sq_intr_err_type = REG_GET_FIELD(sq_intr_word, KFD_SQ_INT_DATA,
+								ERR_TYPE);
+				pr_warn("sq_intr: error, se %lld, data 0x%llx, sa %lld, priv %lld, wave_id %lld, simd_id %lld, wgp_id %lld, err_type %d\n",
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							SE_ID),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							DATA),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							SA_ID),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							PRIV),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							WAVE_ID),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							SIMD_ID),
+					REG_GET_FIELD(sq_intr_word, SQ_INTERRUPT_WORD_WAVE_CTXID,
+							WGP_ID),
+					sq_intr_err_type);
+				if (sq_intr_err_type != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
+					sq_intr_err_type != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
+					event_interrupt_poison_consumption(dev, pasid, source_id);
+					return;
+				}
+				break;
+			default:
+				break;
+			}
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24);
+		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
+			kfd_signal_hw_exception_event(pasid);
+	} else if (client_id == SOC15_IH_CLIENTID_SDMA0 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA1 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA2 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA3 ||
+		   (client_id == SOC15_IH_CLIENTID_SDMA3_Sienna_Cichlid &&
+		    KFD_GC_VERSION(dev) == IP_VERSION(10, 3, 0)) ||
+		   client_id == SOC15_IH_CLIENTID_SDMA4 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA5 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA6 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA7) {
+		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
+		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
+			event_interrupt_poison_consumption(dev, pasid, source_id);
+			return;
+		}
+	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
+		   client_id == SOC15_IH_CLIENTID_VMC1 ||
+		   client_id == SOC15_IH_CLIENTID_UTCL2) {
+		struct kfd_vm_fault_info info = {0};
+		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
+
+		info.vmid = vmid;
+		info.mc_id = client_id;
+		info.page_addr = ih_ring_entry[4] |
+			(uint64_t)(ih_ring_entry[5] & 0xf) << 32;
+		info.prot_valid = ring_id & 0x08;
+		info.prot_read  = ring_id & 0x10;
+		info.prot_write = ring_id & 0x20;
+
+		kfd_smi_event_update_vmfault(dev, pasid);
+		kfd_process_vm_fault(dev->dqm, pasid);
+		kfd_signal_vm_fault_event(dev, pasid, &info);
+	}
+}
+
+const struct kfd_event_interrupt_class event_interrupt_class_v10 = {
+	.interrupt_isr = event_interrupt_isr_v10,
+	.interrupt_wq = event_interrupt_wq_v10,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ea68f3b3a4e9..3ee99ee6599c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1142,6 +1142,7 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd);
 /* Events */
 extern const struct kfd_event_interrupt_class event_interrupt_class_cik;
 extern const struct kfd_event_interrupt_class event_interrupt_class_v9;
+extern const struct kfd_event_interrupt_class event_interrupt_class_v10;
 
 extern const struct kfd_device_global_init_class device_global_init_class_cik;
 
-- 
2.25.1

