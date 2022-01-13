Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF68C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 15:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 229A010E22B;
	Thu, 13 Jan 2022 15:43:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8A4410E22B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 15:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnarE7SPeyerDDA1bDkVXGRqbNnXkFUN3rLN0vPoxop+LfJX0kddr4SgEcUEKVloo6YjiwBVUh5/RaF8J0Bd74rdHLDIXRng5W/sE0dbdjAPTiDwyZnMZpMsQnAH/6HOhDQK+FBFc5qn/9fJqz7txvpELaQ76Y0RDsMTfel/X/OmuJHDG63pP6E2W0ks4HpNctn/KZ5/25uNdej3FXfk6xQqm/JCXmQHEZjOCHCmURoRRk8dWwHaFWOU2WpZgPd57TCNuVCWJA/J1okJbGNwxsgWim/fzHLOe49/M6ZA7MPGbZ3bT6ss9iW/yaarE/WwonVD9uKR8x902kHBkhuGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlFGDoJPLDO9JnDHEEf9Z6TrZlNRHFJY/+xAcqc8NdY=;
 b=AxjbM9T3uTpf9LNob9zhnpOxsuhv5EJXG1hieCQz/puVVRETFmxcEdoi2aC8NZQEIQz7tA+7QX6j6A1dbVA01lwrsejzZKAajMpKD8zwuesUt/RTNAKMgTRdWPHeDKMoUYDpUYxe+y83ZRqmgwKw7sVbFoEn1KTgWs4nkr7Kon874LnB248NTcnETipg7Sz7CJ9foWCmqqZicNyVPpP9/dEt3FaQ+wIzl0nyx/J5zEjiyAdD82kGBNnUpb2iS1R4M31XonuDbvJDzBEokpRwTscP4FAe3Ly4SlHdKNQ/02nhPQA10qOHjCQejpwiEg+ZpxR23UG9sjrLQVWas9LxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlFGDoJPLDO9JnDHEEf9Z6TrZlNRHFJY/+xAcqc8NdY=;
 b=pagTvTXnDrOW5gEMCNberJDAYbIclnz+SnZiM4qFlLcu4g6FZoSVqqvRKz9EhElNSn2LTKg3kvHDUcrXT3H10l3hQY0AxFTWHc8SbWy6QLtfsdYKP+vL1tVz4sFo67XPwboD/a3tGMaE007CMncMv5me9WWZmq6ginlXfA1K02U=
Received: from BN6PR1201CA0004.namprd12.prod.outlook.com
 (2603:10b6:405:4c::14) by SA0PR12MB4429.namprd12.prod.outlook.com
 (2603:10b6:806:73::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 15:43:01 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::90) by BN6PR1201CA0004.outlook.office365.com
 (2603:10b6:405:4c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Thu, 13 Jan 2022 15:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 15:43:00 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 09:42:59 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: use proper interrupt handling for gfx10
Date: Thu, 13 Jan 2022 10:42:50 -0500
Message-ID: <20220113154250.3088139-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a26f5b1-de44-4f96-4dbe-08d9d6ab6150
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB442920217F81872E9FCB4CAA85539@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8qkbXMW4u6R01n8bmaayYkBiaHHvOuZoITNjVqJd2UsUfExFSgy3INq2GptJLQhYZjqZnKqDJRS3XINn3CCJql8oMwAgct2LkQhGSMfD1jmpSILisT7psP8HOlH2pwbevFjnbjdlARXA9PBeAij4L9ONF2xN/NVhWA2ydHoJGeuuz79dAhr/KvDq62/FHnqJlPVis3dKS5EExWLqNMWwgkipayOOEz7BuMC5QrK0RfhB2ZtwO3gXTxp2HnXjpgdebhxow21LY3+lFVkZXWI9c/pe+WQIw+xIHgZgLDNn87p3tEZ4Hkwm1CgQ8Sz5sZyNnF851xpG6On9ry0Q8UK1P7uwFaZLPNO4MpBsiGquZMRg+OhHUG72rbrgFyxFl9GeNKCw/rp4bi663pmo5OC3hkyzftGLui7dO9YY65T1FCzKBxeW32L7XGHPl4+1bEi+Q+InX25evD6pP75e9NksgVhsxJzAnmZSnVyVdcKfA3yrGSfedKDdWJJngMvWrS3zagxC59O3s/Q657RTWRxiSyO7k1NFM6CnqOkomclQxLA3RNWrnV6kh5KmnD95plBVjvg9SGRWfUOPxWLfxzWzb+M9OvOQ7mLXlluQ7t09nMeK45r/D9luayhUwzuemJ249cDso3lMGM3bNeS9qoTKu9gaCFSvziK2fUAlnUiRMgioT1zPYlYz1NBkZChu7/Npv9/hMEunYFZbjmZcg+eP3enktbJE9T9giA4vx40GSX0daGNpYFv+NnEJGENY/mbCSK3PjGfThWTPIVoyvYo9guucxjKJVao4sUA9KALldpI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(186003)(5660300002)(26005)(7696005)(47076005)(16526019)(6666004)(70586007)(30864003)(8936002)(6916009)(86362001)(83380400001)(8676002)(356005)(81166007)(36756003)(508600001)(316002)(54906003)(82310400004)(426003)(2906002)(4326008)(70206006)(2616005)(40460700001)(36860700001)(44832011)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 15:43:00.9571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a26f5b1-de44-4f96-4dbe-08d9d6ab6150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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

v2: forgot to add Sienna Chichlid SDMA3 client as permissible

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile           |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 315 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
 4 files changed, 320 insertions(+), 1 deletion(-)
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
index 000000000000..b54719b9a808
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -0,0 +1,315 @@
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
+	    !(KFD_GC_VERSION(dev) == IP_VERSION(10, 3, 0) &&
+		client_id == SOC15_IH_CLIENTID_SDMA3_Sienna_Cichlid) &&
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
+		   (KFD_GC_VERSION(dev) == IP_VERSION(10, 3, 0) &&
+			client_id == SOC15_IH_CLIENTID_SDMA3_Sienna_Cichlid) ||
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

