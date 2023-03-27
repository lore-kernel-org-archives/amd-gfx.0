Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EDAC77B6C
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5EF10E735;
	Mon, 27 Mar 2023 19:36:58 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB3210E72C
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+yK9BGSFFdjO4yJOyMRagfq7BnQy79ndYV5VAvW/OdpAPXVpVf5wufHTB6a11s1XrihkUI88ncJxuPDOfVuU1d7uLwKGzkqigaCm6hwALuVatTbR1xKekfcqQTQpHtvr1Xmfr40kXfsLufwE1QLtIneLXdIm40Yahlr4sFTja+hRlVTsX/YCuKOVgCVj4UfsfrYK9qNtTN3hT7PbTSyosNFgT/7SLPyAh0DNqGcU2RvIJ8L7mZ+eH8OYee7a6bhvhnUR+aT3VGaWawoOHHqSdTaZoUaZPqS5OyHODF+Kg1uV3pyultrGHfqkmofR7igKLxBbmUqgj0im6w/ZsDjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/NGVgNYlQnPIw2IZbgyffIsxU/o071gj1qRiIX3FzA=;
 b=e/8oyCbJyIVeLujdD3fH9E2m8to4aG5W8c/8t6tJ5iUNSg4gmfopbSQ+pAAFtwYoCAXZ9o+3ics2xfnlN6wICcDlMzMUNdobHnSUE4IbynCE0KeG99ydJetloTMfb4Wu1zrAWwUDWyz6QoXPh536LoWQGND/Tu7YtaD3+QtMPs+msmEeb4rPvNErnrWJeUn6QZqkIu/7UBMA7e3WUHMbA9PLgnkpEKxi51JlHvUXXdOBB82KTbkPbgVbUAeRt4/BKrV9miQaFsfI8aBhE7cCvGzCs9bEXmGEpxM55yjZgcQE8CwsC5VJzMUovk+hcEmdmptrMlSvrH1V/x1/wC+NRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/NGVgNYlQnPIw2IZbgyffIsxU/o071gj1qRiIX3FzA=;
 b=SStB4XUuhW/IaoDDb4C51EBzRn8mFlLRCyMhfjlatbARCmOod0UBXOCqaVS891NfOdozZ3M05BSqAmJIQ34R7is4QEb16z51T1OeE5h/9BDnJD+CyY1kyfxXHm13pTA8EvWG4PYcD9kpRtKNj9+sqUh2RnG6QeExZIM8Lv5zWbw=
Received: from BL1PR13CA0379.namprd13.prod.outlook.com (2603:10b6:208:2c0::24)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 19:36:38 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::92) by BL1PR13CA0379.outlook.office365.com
 (2603:10b6:208:2c0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.17 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/28] drm/amdgpu: Add kgd2kfd for GC 9.4.3
Date: Mon, 27 Mar 2023 15:36:00 -0400
Message-ID: <20230327193602.7901-26-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbb355f-0399-4c74-e3b1-08db2efa9542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0hoDmIuyGgvIqRQ0O5X+MQ9MNLZlJaKZpyU3WyUoeiG02DsMivOLj89m1DDHRXQOh33pilmV92afN6hwIiLiRGDBk1MQz+6pvi0vOzhTfSJJ0oG/Jk9eKM3RKB8zvunbYwC2FkMSRhRHR2DHQkK4xZvk7KjaDd06XZBf4HnsEtWbuw9E6aMPwvpWRNH0WGUelvJbRYWH/n6JLZzTYaToi0tRW4Qri2tOsU5Tp464zat10mN0PO97p4rZXbVHa2mJpAgD6osk0ZAP1+gQsVEgWBFUKOoNDzSonjNRNRtlXU72wO78p64EOstU+9Y5EQT4kzO98/ChG/dtNjbZRdso1HTC59jbsEsdtXxEfoPGuGhNp8/CGAMyjTDGX6q9paeaePvly5c2FO0UOsldfODdcVJxpydURqHcTk8KjfBqGXq3Pkg5Kii7+EouG9TXE09ESLddUfueHMvhoObQ37QeDqHkMc639cUWxS6unloWJ2qM3p0m0CyMG4CGz/Oz91Ufptm13+mTHL1RmPITPmOzpv4XqxBdYPq2LLoYVtCzRwqN0EwucMK+ventdD0cLBpX286tY1G6EE4kOcxTfbwYGpr8Xbsyoyq3aMaLgZ8x0l5DQMbK1TMHsxX2OxeiCXBeHd/yl+X1NW0lh/Nk3IBV7zXKZ+0+0uqHcAIya/HRve2J1Xi5QbyvPgJt9wtPhYz1sYqyKN98kXssIWARMN+xHgHrRESv6pr5yipnM4s6WQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(16526019)(26005)(426003)(1076003)(40480700001)(41300700001)(186003)(6666004)(66899021)(7696005)(83380400001)(336012)(2616005)(47076005)(478600001)(54906003)(316002)(36860700001)(40460700003)(4326008)(70206006)(2906002)(30864003)(70586007)(8676002)(6916009)(81166007)(82740400003)(356005)(36756003)(82310400005)(86362001)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:38.3478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbb355f-0399-4c74-e3b1-08db2efa9542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181
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
Cc: Amber Lin <Amber.Lin@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amber Lin <Amber.Lin@amd.com>

New GC (v9.4.3) and ATHUB (v1.8.0) versions
are used. Add kgd_gfx_v9_4_3_*
functions if registers in use of kgd_gfx_v9_*
functions are changed or have different offset.

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 183 ++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  30 +--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   5 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   3 +-
 5 files changed, 206 insertions(+), 16 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 415a7fa395c4..7fb09000efc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -228,6 +228,7 @@ amdgpu-y += \
 	amdgpu_amdkfd_gfx_v9.o \
 	amdgpu_amdkfd_arcturus.o \
 	amdgpu_amdkfd_aldebaran.o \
+	amdgpu_amdkfd_gc_9_4_3.o \
 	amdgpu_amdkfd_gfx_v10.o \
 	amdgpu_amdkfd_gfx_v10_3.o \
 	amdgpu_amdkfd_gfx_v11.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
new file mode 100644
index 000000000000..562e1a04160f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -0,0 +1,183 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#include "amdgpu.h"
+#include "amdgpu_amdkfd.h"
+#include "amdgpu_amdkfd_arcturus.h"
+#include "amdgpu_amdkfd_gfx_v9.h"
+#include "gc/gc_9_4_3_offset.h"
+#include "gc/gc_9_4_3_sh_mask.h"
+#include "athub/athub_1_8_0_offset.h"
+#include "athub/athub_1_8_0_sh_mask.h"
+#include "oss/osssys_4_0_offset.h"
+#include "oss/osssys_4_0_sh_mask.h"
+#include "v9_structs.h"
+#include "soc15.h"
+
+static int kgd_gfx_v9_4_3_set_pasid_vmid_mapping(struct amdgpu_device *adev,
+				u32 pasid, unsigned int vmid)
+{
+	unsigned long timeout;
+
+	/*
+	 * We have to assume that there is no outstanding mapping.
+	 * The ATC_VMID_PASID_MAPPING_UPDATE_STATUS bit could be 0 because
+	 * a mapping is in progress or because a mapping finished
+	 * and the SW cleared it.
+	 * So the protocol is to always wait & clear.
+	 */
+	uint32_t pasid_mapping = (pasid == 0) ? 0 : (uint32_t)pasid |
+			ATC_VMID0_PASID_MAPPING__VALID_MASK;
+
+	WREG32(SOC15_REG_OFFSET(ATHUB, 0,
+		regATC_VMID0_PASID_MAPPING) + vmid, pasid_mapping);
+
+	timeout = jiffies + msecs_to_jiffies(10);
+	while (!(RREG32(SOC15_REG_OFFSET(ATHUB, 0,
+			regATC_VMID_PASID_MAPPING_UPDATE_STATUS)) &
+			(1U << vmid))) {
+		if (time_after(jiffies, timeout)) {
+			pr_err("Fail to program VMID-PASID mapping\n");
+			return -ETIME;
+		}
+		cpu_relax();
+	}
+
+	WREG32(SOC15_REG_OFFSET(ATHUB, 0,
+		regATC_VMID_PASID_MAPPING_UPDATE_STATUS),
+		1U << vmid);
+
+	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT) + vmid,
+		pasid_mapping);
+	WREG32(SOC15_REG_OFFSET(OSSSYS, 0, mmIH_VMID_0_LUT_MM) + vmid,
+		pasid_mapping);
+
+	return 0;
+}
+
+static inline struct v9_mqd *get_mqd(void *mqd)
+{
+	return (struct v9_mqd *)mqd;
+}
+
+static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
+			uint32_t pipe_id, uint32_t queue_id,
+			uint32_t __user *wptr, uint32_t wptr_shift,
+			uint32_t wptr_mask, struct mm_struct *mm)
+{
+	struct v9_mqd *m;
+	uint32_t *mqd_hqd;
+	uint32_t reg, hqd_base, hqd_end, data;
+
+	m = get_mqd(mqd);
+
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
+
+	/* HQD registers extend to CP_HQD_AQL_DISPATCH_ID_HI */
+	mqd_hqd = &m->cp_mqd_base_addr_lo;
+	hqd_base = SOC15_REG_OFFSET(GC, 0, regCP_MQD_BASE_ADDR);
+	hqd_end = SOC15_REG_OFFSET(GC, 0, regCP_HQD_AQL_DISPATCH_ID_HI);
+
+	for (reg = hqd_base; reg <= hqd_end; reg++)
+		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+
+
+	/* Activate doorbell logic before triggering WPTR poll. */
+	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
+			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
+				data);
+
+	if (wptr) {
+		/* Don't read wptr with get_user because the user
+		 * context may not be accessible (if this function
+		 * runs in a work queue). Instead trigger a one-shot
+		 * polling read from memory in the CP. This assumes
+		 * that wptr is GPU-accessible in the queue's VMID via
+		 * ATC or SVM. WPTR==RPTR before starting the poll so
+		 * the CP starts fetching new commands from the right
+		 * place.
+		 *
+		 * Guessing a 64-bit WPTR from a 32-bit RPTR is a bit
+		 * tricky. Assume that the queue didn't overflow. The
+		 * number of valid bits in the 32-bit RPTR depends on
+		 * the queue size. The remaining bits are taken from
+		 * the saved 64-bit WPTR. If the WPTR wrapped, add the
+		 * queue size.
+		 */
+		uint32_t queue_size =
+			2 << REG_GET_FIELD(m->cp_hqd_pq_control,
+					   CP_HQD_PQ_CONTROL, QUEUE_SIZE);
+		uint64_t guessed_wptr = m->cp_hqd_pq_rptr & (queue_size - 1);
+
+		if ((m->cp_hqd_pq_wptr_lo & (queue_size - 1)) < guessed_wptr)
+			guessed_wptr += queue_size;
+		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
+		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
+
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_PQ_WPTR_LO),
+		       lower_32_bits(guessed_wptr));
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_PQ_WPTR_HI),
+		       upper_32_bits(guessed_wptr));
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
+		       lower_32_bits((uintptr_t)wptr));
+		WREG32_RLC(SOC15_REG_OFFSET(GC, 0,
+			regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+			upper_32_bits((uintptr_t)wptr));
+		WREG32(SOC15_REG_OFFSET(GC, 0, regCP_PQ_WPTR_POLL_CNTL1),
+		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id,
+			       queue_id));
+	}
+
+	/* Start the EOP fetcher */
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_EOP_RPTR),
+	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
+			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
+
+	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, regCP_HQD_ACTIVE), data);
+
+	kgd_gfx_v9_release_queue(adev);
+
+	return 0;
+}
+
+const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
+	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
+	.set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
+	.init_interrupts = kgd_gfx_v9_init_interrupts,
+	.hqd_load = kgd_gfx_v9_4_3_hqd_load,
+	.hiq_mqd_load = kgd_gfx_v9_hiq_mqd_load,
+	.hqd_sdma_load = kgd_arcturus_hqd_sdma_load,
+	.hqd_dump = kgd_gfx_v9_hqd_dump,
+	.hqd_sdma_dump = kgd_arcturus_hqd_sdma_dump,
+	.hqd_is_occupied = kgd_gfx_v9_hqd_is_occupied,
+	.hqd_sdma_is_occupied = kgd_arcturus_hqd_sdma_is_occupied,
+	.hqd_destroy = kgd_gfx_v9_hqd_destroy,
+	.hqd_sdma_destroy = kgd_arcturus_hqd_sdma_destroy,
+	.wave_control_execute = kgd_gfx_v9_wave_control_execute,
+	.get_atc_vmid_pasid_mapping_info =
+				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
+	.set_vm_context_page_table_base =
+				kgd_gfx_v9_set_vm_context_page_table_base,
+	.program_trap_handler_settings =
+				kgd_gfx_v9_program_trap_handler_settings
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index ae06d1f2af93..d36219ecd3dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -59,7 +59,7 @@ static void unlock_srbm(struct amdgpu_device *adev)
 	mutex_unlock(&adev->srbm_mutex);
 }
 
-static void acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
+void kgd_gfx_v9_acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
 				uint32_t queue_id)
 {
 	uint32_t mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
@@ -68,7 +68,7 @@ static void acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
 	lock_srbm(adev, mec, pipe, queue_id, 0);
 }
 
-static uint64_t get_queue_mask(struct amdgpu_device *adev,
+uint64_t kgd_gfx_v9_get_queue_mask(struct amdgpu_device *adev,
 			       uint32_t pipe_id, uint32_t queue_id)
 {
 	unsigned int bit = pipe_id * adev->gfx.mec.num_queue_per_pipe +
@@ -77,7 +77,7 @@ static uint64_t get_queue_mask(struct amdgpu_device *adev,
 	return 1ull << bit;
 }
 
-static void release_queue(struct amdgpu_device *adev)
+void kgd_gfx_v9_release_queue(struct amdgpu_device *adev)
 {
 	unlock_srbm(adev);
 }
@@ -228,7 +228,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	m = get_mqd(mqd);
 
-	acquire_queue(adev, pipe_id, queue_id);
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
 
 	/* HQD registers extend from CP_MQD_BASE_ADDR to CP_HQD_EOP_WPTR_MEM. */
 	mqd_hqd = &m->cp_mqd_base_addr_lo;
@@ -280,7 +280,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 		WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
 		       upper_32_bits((uintptr_t)wptr));
 		WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,
-		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
+		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
@@ -291,7 +291,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
 	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
 
-	release_queue(adev);
+	kgd_gfx_v9_release_queue(adev);
 
 	return 0;
 }
@@ -307,7 +307,7 @@ int kgd_gfx_v9_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 
 	m = get_mqd(mqd);
 
-	acquire_queue(adev, pipe_id, queue_id);
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
 
 	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
 	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
@@ -343,7 +343,7 @@ int kgd_gfx_v9_hiq_mqd_load(struct amdgpu_device *adev, void *mqd,
 
 out_unlock:
 	spin_unlock(&adev->gfx.kiq[0].ring_lock);
-	release_queue(adev);
+	kgd_gfx_v9_release_queue(adev);
 
 	return r;
 }
@@ -365,13 +365,13 @@ int kgd_gfx_v9_hqd_dump(struct amdgpu_device *adev,
 	if (*dump == NULL)
 		return -ENOMEM;
 
-	acquire_queue(adev, pipe_id, queue_id);
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
 
 	for (reg = SOC15_REG_OFFSET(GC, 0, mmCP_MQD_BASE_ADDR);
 	     reg <= SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI); reg++)
 		DUMP_REG(reg);
 
-	release_queue(adev);
+	kgd_gfx_v9_release_queue(adev);
 
 	WARN_ON_ONCE(i != HQD_N_REGS);
 	*n_regs = i;
@@ -487,7 +487,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device *adev,
 	bool retval = false;
 	uint32_t low, high;
 
-	acquire_queue(adev, pipe_id, queue_id);
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
 	act = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
 	if (act) {
 		low = lower_32_bits(queue_address >> 8);
@@ -497,7 +497,7 @@ bool kgd_gfx_v9_hqd_is_occupied(struct amdgpu_device *adev,
 		   high == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI))
 			retval = true;
 	}
-	release_queue(adev);
+	kgd_gfx_v9_release_queue(adev);
 	return retval;
 }
 
@@ -532,7 +532,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 	if (amdgpu_in_reset(adev))
 		return -EIO;
 
-	acquire_queue(adev, pipe_id, queue_id);
+	kgd_gfx_v9_acquire_queue(adev, pipe_id, queue_id);
 
 	if (m->cp_hqd_vmid == 0)
 		WREG32_FIELD15_RLC(GC, 0, RLC_CP_SCHEDULERS, scheduler1, 0);
@@ -561,13 +561,13 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 			break;
 		if (time_after(jiffies, end_jiffies)) {
 			pr_err("cp queue preemption time out.\n");
-			release_queue(adev);
+			kgd_gfx_v9_release_queue(adev);
 			return -ETIME;
 		}
 		usleep_range(500, 1000);
 	}
 
-	release_queue(adev);
+	kgd_gfx_v9_release_queue(adev);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index c7ed3bc9053c..491273a02e30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -58,3 +58,8 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 		int *pasid_wave_cnt, int *max_waves_per_cu);
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
 		uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr);
+void kgd_gfx_v9_acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
+				uint32_t queue_id);
+uint64_t kgd_gfx_v9_get_queue_mask(struct amdgpu_device *adev,
+				uint32_t pipe_id, uint32_t queue_id);
+void kgd_gfx_v9_release_queue(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 21598ab9c520..0ba5ce005380 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -51,6 +51,7 @@ extern const struct kfd2kgd_calls gfx_v8_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v9_kfd2kgd;
 extern const struct kfd2kgd_calls arcturus_kfd2kgd;
 extern const struct kfd2kgd_calls aldebaran_kfd2kgd;
+extern const struct kfd2kgd_calls gc_9_4_3_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v11_kfd2kgd;
@@ -320,7 +321,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			break;
 		case IP_VERSION(9, 4, 3):
 			gfx_target_version = 90400;
-			f2g = &aldebaran_kfd2kgd;
+			f2g = &gc_9_4_3_kfd2kgd;
 			break;
 		/* Navi10 */
 		case IP_VERSION(10, 1, 10):
-- 
2.39.2

