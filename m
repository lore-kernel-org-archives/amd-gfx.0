Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A974BD637B5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961F010E890;
	Tue, 16 Dec 2025 21:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E18Dyvxk";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6825110E883
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAi2NXqIbzH7gS/gXuSa4cDzRejHBvKlLfy9Pq0JEDThzjAz+5Rzf95j75ofIjyOvrvR6qn6aG/L4BENh8QpUslg3Ltk777p45R+C/xe5QVjtKYnOInljX2tck/DDoZqnEmewCAzA7EevWu4hjqB9RAIhHEbXuBNZEXsRkXfAeQw4hr0f+5/I3QdJPHEqxcsbkyfUlN98X/8HYbcBVacq3LbRijD6MbdKj1ne5Fh1UMlQ1gvheW/R9e7hSwnhqIHiZKnwSC142dCAJ+a/v4OW14SnZjXaoNbcIScId3NkJjRHz4UhcHx71oHe4XpSO714hyd9Q6Q63+ZIoMmIum5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y6YMLv1xrzjav65vSQ/n9DhfNuXnv5WFkOO3mimGOQ=;
 b=Bmkk9ddBzzhe+0thSHY/3C9bHMK+0Y05xoSFV2IDPVOBU3xdEIJ2nMTblNjEuHPE6dw5UPsWcR+EL574z8vLdf9H1agOVnYzVt9vDxTpSGBNVvMHYyUv2z/ARG/iuHhrHAk28CkOiw+cUa8bVuMn+iQUpMlcV//kivx0t1hgv/h3Zsr0dJwUx0hCQcLehuFPx4ovN5OWlv5cBMNkvMEg46Bq54DLMIkfhEJUmBzxtx1+LNOYmwCm05Atxv30qOnJFHHaPFXgLgVryUpsQJTrqkcnoyYEYu0DTTNqmrS6+7UBcZs7MUJI4AxpKqt7CWifd5cynuaZ0kfzBPi8W8171g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y6YMLv1xrzjav65vSQ/n9DhfNuXnv5WFkOO3mimGOQ=;
 b=E18DyvxkbW1vQrGvS0OQF2aQTKh6mTw4xEPCV6KoyBRMOMfsPM+T6FpCALfGJOkNSMsbsGNFDc8epU7eeyw0Ih4rNu26YoXF3jbEGcq7KMSOxvnLsUOgbhUOOeZ3Oa+fZGYrNjyHhWDuyMyAFfyNZnCri5yuoWx/Up3Se+kE63g=
Received: from BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::16)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:05 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::e6) by BL1P223CA0011.outlook.office365.com
 (2603:10b6:208:2c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 21:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:05 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Add gfx_v12_1_kfd2kgd interface for GFX12_1
Date: Tue, 16 Dec 2025 16:03:31 -0500
Message-ID: <20251216210349.1963466-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d23a6f0-711e-4d69-0cc6-08de3ce6a5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UfpcK2IfWLKir+3aaQf1zU3hvKJMSDpPVgrVM6+4FG6cPQytvKA9+vr3lHr+?=
 =?us-ascii?Q?TMGWxSBSQixssMbgqNRvUC4MedCLIJ3vEOe+7KyUBOqwTHA2Q0z+Du0tbG2W?=
 =?us-ascii?Q?kMrdGcjjWPBKbmaT5ZlJ+XvtbrE1dvQ64Z5ai2zQTGZGboDL2aUGI/4F0qKd?=
 =?us-ascii?Q?IDO6WyoC+uJxObimlBnsEsoTQb1gtOFORveq2qVC2ecwigqks/cnDxWU7V0U?=
 =?us-ascii?Q?mvZptDebe0nqlk5SEo5kiNDyeFIqiCyvGZyIqmb9tpYlG/AIfovooe+WukGi?=
 =?us-ascii?Q?6KdeUBNAjygGu2ctGYf2bS9aBKy8oHHKRL2nphKEuV1R1Pv4UA4jjO2Raogq?=
 =?us-ascii?Q?0cihljmfdtsz/Bc0AgiF2MwlIDDsQq06yMUrug6AfShuO1mmFmvIcz810hfL?=
 =?us-ascii?Q?qpqbM3oNmCCT9WGvphNMEgz/ZLlvkjcGuRa/LGDjiG46PCVVe4IoGt7GwRSu?=
 =?us-ascii?Q?DR5keUFLa5qx6MLSqDCr+3ppUJ2tGUt1HXuhos4sM8joKtiDWQ1JR0ryUfDY?=
 =?us-ascii?Q?UwQ7pJ1bikn+S9QvGkygUEs3KMGvBjgRO1IShrpI5yrsm/Y6BlRltbylAQQM?=
 =?us-ascii?Q?u/snruQOvwsQ2zCdQVKnbU87KEl0GobCgixiqQK04WCjHWdchXqOigdB0QSr?=
 =?us-ascii?Q?xbXg0TN5zAZ7+3FTHocbNpOxoqxLo5O/o2jDkMh8LCh02Fg1U/Rp1XyuHej2?=
 =?us-ascii?Q?mnF8Umh9vPQ9ULwD/tMO6/F7OlNQwc0iYNlSLFN0xykvsvLfpFN6pXswBlCP?=
 =?us-ascii?Q?jF5wi2EKF1b99F0QJzVBUnv3eUCjZH4cbHUboIhxS01K2FLhSrSBrvt6dWY1?=
 =?us-ascii?Q?b/DItoegHmjY61j3LiIIL39rTElbdNhg2aL13D2DQT1PFAfxNYkwZ2U/jfy0?=
 =?us-ascii?Q?hnJXYqbHEju8GwoQZBnn1VhmoXwVrk3O5TtpkNBV1gl28T1GZbUHbooAskvo?=
 =?us-ascii?Q?nwlkmpPixs4x5hIiqtKED3p4RUd0cNSdo3fxnZ4AhPfkNb6gNMr3C4WASnnH?=
 =?us-ascii?Q?w4FQhjQhscybKgcYKMzn3dJlKp/N7HWbJQ/9gzudyXp8iZVQUw0uFz1A9po/?=
 =?us-ascii?Q?XmROsvREgzyIorFaXiy8GjQ15VZ7RrcstEdEvgtzmZsGU58GIWuJVth31pnr?=
 =?us-ascii?Q?arMoBSyvJZFX21S5vMuAHyYv2606gHN5xaSgnIRNaDtKoH4D4pJeRryZ8xnm?=
 =?us-ascii?Q?xtk42BdBGHzkmTsza6jgMtn2AHF8SiayOY/Wf1qY2w96tkSzPPQi0LMAe1LZ?=
 =?us-ascii?Q?TDTjEzU8XiymKnCiStHw4eIQNWsn3FPTz8SJ4GZ6wAoTTR76hQr1G5wtfGp8?=
 =?us-ascii?Q?PoCtu1ODk9EnvK5wvGHV6bCw+P25xhnsdTMNncSVb4IXW9NW9nPL4vFxlm/l?=
 =?us-ascii?Q?j5JHFErXSvl//Om+n8a5jjmT6QFa+c7P1PTE68aHdDpSAo5d5dsiI6kHfbKY?=
 =?us-ascii?Q?zxWVdMU8+/+/nFzr5mRn5LP6hoUOPH3qEWerVQLiokpdiL6n+JF6X8BHeX6U?=
 =?us-ascii?Q?6CE+pQqrWawWcMaQv2wgG1JhA/Xn3cTwInOWx3JtFd50vXm9NetL4YMbynUW?=
 =?us-ascii?Q?vortD53LAWM2vXAav/k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:05.4516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d23a6f0-711e-4d69-0cc6-08de3ce6a5cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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

From: Likun Gao <Likun.Gao@amd.com>

Create new kfd2kgd interface for gfx v12_1, based on gfx v12.
Support register program accoding to xcc id.
V2: Fix SDMA register address for muti-xcc.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c  | 387 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   3 +-
 3 files changed, 391 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index d0c506a445695..fc85622187f52 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -282,7 +282,8 @@ amdgpu-y += \
 	amdgpu_amdkfd_gfx_v10.o \
 	amdgpu_amdkfd_gfx_v10_3.o \
 	amdgpu_amdkfd_gfx_v11.o \
-	amdgpu_amdkfd_gfx_v12.o
+	amdgpu_amdkfd_gfx_v12.o \
+	amdgpu_amdkfd_gfx_v12_1.o
 
 ifneq ($(CONFIG_DRM_AMDGPU_CIK),)
 amdgpu-y += amdgpu_amdkfd_gfx_v7.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
new file mode 100644
index 0000000000000..14e4c60b9d79e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
@@ -0,0 +1,387 @@
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
+#include "amdgpu.h"
+#include "amdgpu_amdkfd.h"
+#include "gc/gc_12_1_0_offset.h"
+#include "gc/gc_12_1_0_sh_mask.h"
+#include "soc_v1_0.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void lock_srbm(struct amdgpu_device *adev, uint32_t mec, uint32_t pipe,
+			uint32_t queue, uint32_t vmid, uint32_t inst)
+{
+	mutex_lock(&adev->srbm_mutex);
+	amdgpu_gfx_select_me_pipe_q(adev, mec, pipe, queue, vmid, inst);
+}
+
+static void unlock_srbm(struct amdgpu_device *adev, uint32_t inst)
+{
+	amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, inst);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+static void acquire_queue(struct amdgpu_device *adev, uint32_t pipe_id,
+				uint32_t queue_id, uint32_t inst)
+{
+	uint32_t mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
+	uint32_t pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
+
+	lock_srbm(adev, mec, pipe, queue_id, 0, inst);
+}
+
+static void release_queue(struct amdgpu_device *adev, uint32_t inst)
+{
+	unlock_srbm(adev, inst);
+}
+
+static int init_interrupts_v12_1(struct amdgpu_device *adev, uint32_t pipe_id, uint32_t inst)
+{
+	uint32_t mec;
+	uint32_t pipe;
+
+	mec = (pipe_id / adev->gfx.mec.num_pipe_per_mec) + 1;
+	pipe = (pipe_id % adev->gfx.mec.num_pipe_per_mec);
+
+	lock_srbm(adev, mec, pipe, 0, 0, inst);
+
+	WREG32_SOC15(GC, GET_INST(GC, inst), regCPC_INT_CNTL,
+		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
+		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
+
+	unlock_srbm(adev, inst);
+
+	return 0;
+}
+
+static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
+				unsigned int engine_id,
+				unsigned int queue_id)
+{
+	uint32_t sdma_engine_reg_base = 0;
+	uint32_t sdma_rlc_reg_offset;
+	uint32_t dev_inst = GET_INST(SDMA0, engine_id);
+
+	switch (dev_inst % adev->sdma.num_inst_per_xcc) {
+	case 0:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0,
+				dev_inst / adev->sdma.num_inst_per_xcc,
+				regSDMA0_SDMA_QUEUE0_RB_CNTL) - regSDMA0_SDMA_QUEUE0_RB_CNTL;
+		break;
+	case 1:
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA1,
+				dev_inst / adev->sdma.num_inst_per_xcc,
+				regSDMA1_SDMA_QUEUE0_RB_CNTL) - regSDMA0_SDMA_QUEUE0_RB_CNTL;
+		break;
+	default:
+		BUG();
+	}
+
+	sdma_rlc_reg_offset = sdma_engine_reg_base
+		+ queue_id * (regSDMA0_SDMA_QUEUE1_RB_CNTL - regSDMA0_SDMA_QUEUE0_RB_CNTL);
+
+	pr_debug("RLC register offset for SDMA%d RLC%d: 0x%x\n", engine_id,
+			queue_id, sdma_rlc_reg_offset);
+
+	return sdma_rlc_reg_offset;
+}
+
+static int hqd_dump_v12_1(struct amdgpu_device *adev,
+			uint32_t pipe_id, uint32_t queue_id,
+			uint32_t (**dump)[2], uint32_t *n_regs, uint32_t inst)
+{
+	uint32_t i = 0, reg;
+#define HQD_N_REGS 56
+#define DUMP_REG(addr) do {				\
+		if (WARN_ON_ONCE(i >= HQD_N_REGS))	\
+			break;				\
+		(*dump)[i][0] = (addr) << 2;		\
+		(*dump)[i++][1] = RREG32(addr);		\
+	} while (0)
+
+	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	if (*dump == NULL)
+		return -ENOMEM;
+
+	acquire_queue(adev, pipe_id, queue_id, inst);
+
+	for (reg = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_MQD_BASE_ADDR);
+	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_HI); reg++)
+		DUMP_REG(reg);
+
+	release_queue(adev, inst);
+
+	WARN_ON_ONCE(i != HQD_N_REGS);
+	*n_regs = i;
+
+	return 0;
+}
+
+static int hqd_sdma_dump_v12_1(struct amdgpu_device *adev,
+			     uint32_t engine_id, uint32_t queue_id,
+			     uint32_t (**dump)[2], uint32_t *n_regs)
+{
+	uint32_t sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
+			engine_id, queue_id);
+	uint32_t i = 0, reg;
+
+	const uint32_t first_reg = regSDMA0_SDMA_QUEUE0_RB_CNTL;
+	const uint32_t last_reg = regSDMA0_SDMA_QUEUE0_CONTEXT_STATUS;
+#undef HQD_N_REGS
+#define HQD_N_REGS (last_reg - first_reg + 1)
+
+	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	if (*dump == NULL)
+		return -ENOMEM;
+
+	for (reg = first_reg;
+	     reg <= last_reg; reg++)
+		DUMP_REG(sdma_rlc_reg_offset + reg);
+
+	WARN_ON_ONCE(i != HQD_N_REGS);
+	*n_regs = i;
+
+	return 0;
+}
+
+static int wave_control_execute_v12_1(struct amdgpu_device *adev,
+					uint32_t gfx_index_val,
+					uint32_t sq_cmd, uint32_t inst)
+{
+	uint32_t data = 0;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+
+	WREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regGRBM_GFX_INDEX), gfx_index_val);
+	WREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regSQ_CMD), sq_cmd);
+
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+		INSTANCE_BROADCAST_WRITES, 1);
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+		SA_BROADCAST_WRITES, 1);
+	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
+		SE_BROADCAST_WRITES, 1);
+
+	WREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regGRBM_GFX_INDEX), data);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	return 0;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v12_1_enable_debug_trap(struct amdgpu_device *adev,
+					    bool restore_dbg_registers,
+					    uint32_t vmid)
+{
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
+
+	return data;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v12_1_disable_debug_trap(struct amdgpu_device *adev,
+						bool keep_trap_enabled,
+						uint32_t vmid)
+{
+	uint32_t data = 0;
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, 0);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, 0);
+
+	return data;
+}
+
+static int kgd_gfx_v12_1_validate_trap_override_request(struct amdgpu_device *adev,
+							uint32_t trap_override,
+							uint32_t *trap_mask_supported)
+{
+	*trap_mask_supported &= KFD_DBG_TRAP_MASK_FP_INVALID |
+				KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+				KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+				KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+				KFD_DBG_TRAP_MASK_FP_INEXACT |
+				KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+				KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION |
+				KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START |
+				KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
+
+	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR &&
+			trap_override != KFD_DBG_TRAP_OVERRIDE_REPLACE)
+		return -EPERM;
+
+	return 0;
+}
+
+static uint32_t trap_mask_map_sw_to_hw(uint32_t mask)
+{
+	uint32_t trap_on_start = (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START) ? 1 : 0;
+	uint32_t trap_on_end = (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END) ? 1 : 0;
+	uint32_t excp_en = mask & (KFD_DBG_TRAP_MASK_FP_INVALID |
+			KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+			KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+			KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+			KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+			KFD_DBG_TRAP_MASK_FP_INEXACT |
+			KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+			KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+			KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION);
+	uint32_t ret;
+
+	ret = REG_SET_FIELD(0, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, excp_en);
+	ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START, trap_on_start);
+	ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END, trap_on_end);
+
+	return ret;
+}
+
+static uint32_t trap_mask_map_hw_to_sw(uint32_t mask)
+{
+	uint32_t ret = REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, EXCP_EN);
+
+	if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START))
+		ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START;
+
+	if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END))
+		ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
+	return ret;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v12_1_set_wave_launch_trap_override(struct amdgpu_device *adev,
+					uint32_t vmid,
+					uint32_t trap_override,
+					uint32_t trap_mask_bits,
+					uint32_t trap_mask_request,
+					uint32_t *trap_mask_prev,
+					uint32_t kfd_dbg_trap_cntl_prev)
+
+{
+	uint32_t data = 0;
+
+	*trap_mask_prev = trap_mask_map_hw_to_sw(kfd_dbg_trap_cntl_prev);
+
+	data = (trap_mask_bits & trap_mask_request) | (*trap_mask_prev & ~trap_mask_request);
+	data = trap_mask_map_sw_to_hw(data);
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, trap_override);
+
+	return data;
+}
+
+/* returns STALL_VMID or LAUNCH_MODE. */
+static uint32_t kgd_gfx_v12_1_set_wave_launch_mode(struct amdgpu_device *adev,
+					uint8_t wave_launch_mode,
+					uint32_t vmid)
+{
+	uint32_t data = 0;
+	bool is_stall_mode = wave_launch_mode == 4;
+
+	if (is_stall_mode)
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, STALL_VMID,
+									1);
+	else
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, LAUNCH_MODE,
+							wave_launch_mode);
+
+	return data;
+}
+
+#define TCP_WATCH_STRIDE (regTCP_WATCH1_ADDR_H - regTCP_WATCH0_ADDR_H)
+static uint32_t kgd_gfx_v12_1_set_address_watch(struct amdgpu_device *adev,
+					uint64_t watch_address,
+					uint32_t watch_address_mask,
+					uint32_t watch_id,
+					uint32_t watch_mode,
+					uint32_t debug_vmid,
+					uint32_t inst)
+{
+	uint32_t watch_address_high;
+	uint32_t watch_address_low;
+	uint32_t watch_address_cntl;
+
+	watch_address_cntl = 0;
+	watch_address_low = lower_32_bits(watch_address);
+	watch_address_high = upper_32_bits(watch_address) & 0xffff;
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MODE,
+			watch_mode);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MASK,
+			watch_address_mask >> 7);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VALID,
+			1);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regTCP_WATCH0_ADDR_H) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_high);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regTCP_WATCH0_ADDR_L) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_low);
+
+	return watch_address_cntl;
+}
+
+static uint32_t kgd_gfx_v12_1_clear_address_watch(struct amdgpu_device *adev,
+					uint32_t watch_id)
+{
+	return 0;
+}
+
+static uint32_t kgd_gfx_v12_1_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
+						 int engine, int queue)
+{
+	return 0;
+}
+
+const struct kfd2kgd_calls gfx_v12_1_kfd2kgd = {
+	.init_interrupts = init_interrupts_v12_1,
+	.hqd_dump = hqd_dump_v12_1,
+	.hqd_sdma_dump = hqd_sdma_dump_v12_1,
+	.wave_control_execute = wave_control_execute_v12_1,
+	.get_atc_vmid_pasid_mapping_info = NULL,
+	.enable_debug_trap = kgd_gfx_v12_1_enable_debug_trap,
+	.disable_debug_trap = kgd_gfx_v12_1_disable_debug_trap,
+	.validate_trap_override_request = kgd_gfx_v12_1_validate_trap_override_request,
+	.set_wave_launch_trap_override = kgd_gfx_v12_1_set_wave_launch_trap_override,
+	.set_wave_launch_mode = kgd_gfx_v12_1_set_wave_launch_mode,
+	.set_address_watch = kgd_gfx_v12_1_set_address_watch,
+	.clear_address_watch = kgd_gfx_v12_1_clear_address_watch,
+	.hqd_sdma_get_doorbell = kgd_gfx_v12_1_hqd_sdma_get_doorbell
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 6d0b370b1644b..91fe4832d5ab9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -57,6 +57,7 @@ extern const struct kfd2kgd_calls gfx_v10_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v10_3_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v11_kfd2kgd;
 extern const struct kfd2kgd_calls gfx_v12_kfd2kgd;
+extern const struct kfd2kgd_calls gfx_v12_1_kfd2kgd;
 
 static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 				unsigned int chunk_size);
@@ -451,7 +452,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			break;
 		case IP_VERSION(12, 1, 0):
 			gfx_target_version = 120500;
-			f2g = &gfx_v12_kfd2kgd;
+			f2g = &gfx_v12_1_kfd2kgd;
 			break;
 		default:
 			break;
-- 
2.52.0

