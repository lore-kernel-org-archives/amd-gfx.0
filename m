Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0715C77B60
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E1910E6FF;
	Mon, 27 Mar 2023 19:30:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65CE010E3EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwjohVNfjhBzVLRDeL05H8zAeGTiHm2cWgeUf4bdbq+YgS/PIXFZh1/k9iaJztqTeg6qnU5HBjKgEPgMrEVr9pPI8fT9E6mWmXk2UJ31JwVuX1qsChJQZqfmmUM2KKVKzgON8Xo1XhZQjksFgOktlAeYf3Zp0BRWpEGxuQ7LLmP57kS302B+FRf6mL/H7RLHvulyyFfbi8NXxDqi7qKiJGLCsBIbmlZs0iJ5qobRD2FNxtqm8n7djwJpCeiO+Bj+jASEOTorAHT+6DKtRH//3BLpYh8BPoKxEYIMSg6ADOG2W/Exhu4zJgXnhHmTKra8MZ4a7McVfPUDFmoqrxt0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxrtIpwE5PlPxmH2E7B65uQ64QAv40CBZdDV7+8o9+I=;
 b=LKlNLuElXnrCJxKi3WC7yhyUXFSg3eaW53YI6d+5h2eW6g6ypkBtehXjWBHHAuKe2u1ldtgisgCwPcxaeMTfi0+kO6xTj48xDijuR6jnlAQJu5RmBewjtiT1sOVW8esz5zBF5cq6+YfU42yFpXa1wB/CqBggFGQcXNnlpQBX27dhJqAMfyync+5H5t5Gv0L4oAGbBGcpfUdJHafQd6wmcXB+UJMqO+cHdbGgAr9xaOb5OzXc+yG6yOFbYjdklqxC4yvUXjOyksrz5jl3dhoJPtu7mEhCaA6E6Yto0xs1SgqbtiKz50DmCKX08vON3Y/bzZCZ9ewddHm9mX/SqKXViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxrtIpwE5PlPxmH2E7B65uQ64QAv40CBZdDV7+8o9+I=;
 b=HVTBQXcknvaQpwsb99qphhupNwV44m9YNyVQOP+DEJJQXlOccFaqRbLzvso+1eHRf2TdZ+VEBH0fLHpR9iRXK9A7gB87d/Z4Q/xD0BEFz+9hpqstOlIcQXU5b+C2Vp5AA/7XpoVJYCrnHkl3uddnF584RQO5SFEf17+QlCXFU9s=
Received: from DS7PR05CA0002.namprd05.prod.outlook.com (2603:10b6:5:3b9::7) by
 PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:30:19 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::fa) by DS7PR05CA0002.outlook.office365.com
 (2603:10b6:5:3b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.32 via Frontend Transport; Mon, 27 Mar 2023 19:30:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:30:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/10] drm/amdgpu: add gc v9_4_3 rlc_funcs implementation
Date: Mon, 27 Mar 2023 15:29:48 -0400
Message-ID: <20230327192953.7756-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327192953.7756-1-alexander.deucher@amd.com>
References: <20230327192953.7756-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a93dfa5-adfa-499f-b4e8-08db2ef9b30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zzo3gRYsr19CUPdON2zfU018v9JgO6W9bhvVELujp11ITagf71DEnRFGOSW1LhnjV4t2v9LFQwFh2L37z4nlZ66mASjsfEuP2Tq+V+RmJ7Pu19il93fk+HMzOcoXiwPHderi00PG8VQjeyzuGSyeUX8bEZwCekH2ZSBb/ptnTqYi0fFHZT6shO40pNHQXB7xkfZuvmCTSdm2bj8atZXR7iwAn3/JPfsDNzPnEEWAs2AXqbgZiOopiYwbigx5cXdKkLvjnZ3DIPN8OTZs0J5HvR1/MoNejc/J7RGcnGpxg+zzeRzvILB/8AI2b9UXc9ANs17AC3byS0MBpH96edhIOXGjQmJNAhhWKMlyfFBuva1S0xJOMsp4Hoh7LW26XxH+ZCMeLPzjbRG+acBodH6KG1JeX7qBlLnD1o4aV/uS6NMAna6RAahUP/qyTRbtTb8lL/Xb9o2XT7/zutkUHcnil1tAfiUyXF4+/IpktB/aOCFVFbNmy7meMu0VM0+EoV3V96uGPCjKtoRsYEwwKtNcPZHnF5elPZjOh8XA4/7qtmowe5+gUoAH6JGaMQLTXAs/oL706FnqyMSspc+w6acQwd7yTA5yzbjqsusQII1TdPefCCFcLK+jAEOqS2anZSAoE4uhiI9AIN1zTRqjd17sjIN5V2Gs0/dCm7tpJv153oPsm6mKvOhoylSn75PGop8lzGR9/m6ZdybQeR0qiXGXidFp9r7hal3xay7chi/7RSw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(47076005)(2906002)(426003)(83380400001)(30864003)(336012)(5660300002)(8936002)(82740400003)(356005)(36756003)(40480700001)(81166007)(86362001)(82310400005)(40460700003)(36860700001)(26005)(316002)(1076003)(54906003)(6916009)(8676002)(4326008)(70206006)(70586007)(186003)(16526019)(7696005)(6666004)(478600001)(41300700001)(2616005)(66899021)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:30:18.7521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a93dfa5-adfa-499f-b4e8-08db2ef9b30a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

all the gc v9_4_3 registers fall in gc_rlcpdec address range
have different relative offsets and base_idx from the ones
defined in gc v9_0 ip headers. gc_v9_0_rlc_funcs can not be
reused anymore for gc v9_4_3

v2: drop unused handshake function (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 334 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h |  29 ++
 3 files changed, 364 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index dd8bc53411bd..415a7fa395c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -136,6 +136,7 @@ amdgpu-y += \
 	gfx_v9_0.o \
 	gfx_v9_4.o \
 	gfx_v9_4_2.o \
+	gfx_v9_4_3.o \
 	gfx_v10_0.o \
 	imu_v11_0.o \
 	gfx_v11_0.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
new file mode 100644
index 000000000000..b7536ba3f265
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -0,0 +1,334 @@
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
+ *
+ */
+#include <linux/firmware.h>
+
+#include "amdgpu.h"
+#include "amdgpu_gfx.h"
+#include "soc15.h"
+#include "soc15_common.h"
+
+#include "gc/gc_9_4_3_offset.h"
+#include "gc/gc_9_4_3_sh_mask.h"
+
+#include "gfx_v9_4_3.h"
+
+#define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
+
+static bool gfx_v9_4_3_is_rlc_enabled(struct amdgpu_device *adev)
+{
+	uint32_t rlc_setting;
+
+	/* if RLC is not enabled, do nothing */
+	rlc_setting = RREG32_SOC15(GC, 0, regRLC_CNTL);
+	if (!(rlc_setting & RLC_CNTL__RLC_ENABLE_F32_MASK))
+		return false;
+
+	return true;
+}
+
+static void gfx_v9_4_3_set_safe_mode(struct amdgpu_device *adev)
+{
+	uint32_t data;
+	unsigned i;
+
+	data = RLC_SAFE_MODE__CMD_MASK;
+	data |= (1 << RLC_SAFE_MODE__MESSAGE__SHIFT);
+	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, data);
+
+	/* wait for RLC_SAFE_MODE */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!REG_GET_FIELD(RREG32_SOC15(GC, 0, regRLC_SAFE_MODE), RLC_SAFE_MODE, CMD))
+			break;
+		udelay(1);
+	}
+}
+
+static void gfx_v9_4_3_unset_safe_mode(struct amdgpu_device *adev)
+{
+	uint32_t data;
+
+	data = RLC_SAFE_MODE__CMD_MASK;
+	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, data);
+}
+
+static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
+{
+	/* init spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+
+	return 0;
+}
+
+static void gfx_v9_4_3_select_se_sh(struct amdgpu_device *adev,
+				    u32 se_num,
+				    u32 sh_num,
+				    u32 instance)
+{
+	u32 data;
+
+	if (instance == 0xffffffff)
+		data = REG_SET_FIELD(0, GRBM_GFX_INDEX,
+				     INSTANCE_BROADCAST_WRITES, 1);
+	else
+		data = REG_SET_FIELD(0, GRBM_GFX_INDEX, INSTANCE_INDEX,
+				     instance);
+
+	if (se_num == 0xffffffff)
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES,
+				     1);
+	else
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se_num);
+
+	if (sh_num == 0xffffffff)
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_BROADCAST_WRITES,
+				     1);
+	else
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SH_INDEX, sh_num);
+
+	WREG32_SOC15_RLC_SHADOW_EX(reg, GC, 0, regGRBM_GFX_INDEX, data);
+}
+
+static void gfx_v9_4_3_wait_for_rlc_serdes(struct amdgpu_device *adev)
+{
+	u32 i, j, k;
+	u32 mask;
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
+		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
+			gfx_v9_4_3_select_se_sh(adev, i, j, 0xffffffff);
+			for (k = 0; k < adev->usec_timeout; k++) {
+				if (RREG32_SOC15(GC, 0, regRLC_SERDES_CU_MASTER_BUSY) == 0)
+					break;
+				udelay(1);
+			}
+			if (k == adev->usec_timeout) {
+				gfx_v9_4_3_select_se_sh(adev, 0xffffffff,
+						      0xffffffff, 0xffffffff);
+				mutex_unlock(&adev->grbm_idx_mutex);
+				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
+					 i, j);
+				return;
+			}
+		}
+	}
+	gfx_v9_4_3_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	mask = RLC_SERDES_NONCU_MASTER_BUSY__SE_MASTER_BUSY_MASK |
+		RLC_SERDES_NONCU_MASTER_BUSY__GC_MASTER_BUSY_MASK |
+		RLC_SERDES_NONCU_MASTER_BUSY__TC0_MASTER_BUSY_MASK |
+		RLC_SERDES_NONCU_MASTER_BUSY__TC1_MASTER_BUSY_MASK;
+	for (k = 0; k < adev->usec_timeout; k++) {
+		if ((RREG32_SOC15(GC, 0, regRLC_SERDES_NONCU_MASTER_BUSY) & mask) == 0)
+			break;
+		udelay(1);
+	}
+}
+
+static void gfx_v9_4_3_enable_gui_idle_interrupt(struct amdgpu_device *adev,
+					       bool enable)
+{
+	u32 tmp;
+
+	/* These interrupts should be enabled to drive DS clock */
+
+	tmp= RREG32_SOC15(GC, 0, regCP_INT_CNTL_RING0);
+
+	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, enable ? 1 : 0);
+	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
+	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE, enable ? 1 : 0);
+	if(adev->gfx.num_gfx_rings)
+		tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE, enable ? 1 : 0);
+
+	WREG32_SOC15(GC, 0, regCP_INT_CNTL_RING0, tmp);
+}
+
+static void gfx_v9_4_3_rlc_stop(struct amdgpu_device *adev)
+{
+	WREG32_FIELD15_PREREG(GC, 0, RLC_CNTL, RLC_ENABLE_F32, 0);
+	gfx_v9_4_3_enable_gui_idle_interrupt(adev, false);
+	gfx_v9_4_3_wait_for_rlc_serdes(adev);
+}
+
+static void gfx_v9_4_3_rlc_reset(struct amdgpu_device *adev)
+{
+	WREG32_FIELD15_PREREG(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
+	udelay(50);
+	WREG32_FIELD15_PREREG(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);
+	udelay(50);
+}
+
+static void gfx_v9_4_3_rlc_start(struct amdgpu_device *adev)
+{
+#ifdef AMDGPU_RLC_DEBUG_RETRY
+	u32 rlc_ucode_ver;
+#endif
+
+	WREG32_FIELD15_PREREG(GC, 0, RLC_CNTL, RLC_ENABLE_F32, 1);
+	udelay(50);
+
+	/* carrizo do enable cp interrupt after cp inited */
+	if (!(adev->flags & AMD_IS_APU)) {
+		gfx_v9_4_3_enable_gui_idle_interrupt(adev, true);
+		udelay(50);
+	}
+
+#ifdef AMDGPU_RLC_DEBUG_RETRY
+	/* RLC_GPM_GENERAL_6 : RLC Ucode version */
+	rlc_ucode_ver = RREG32_SOC15(GC, 0, regRLC_GPM_GENERAL_6);
+	if(rlc_ucode_ver == 0x108) {
+		dev_info(adev->dev,
+			 "Using rlc debug ucode. regRLC_GPM_GENERAL_6 ==0x08%x / fw_ver == %i \n",
+			 rlc_ucode_ver, adev->gfx.rlc_fw_version);
+		/* RLC_GPM_TIMER_INT_3 : Timer interval in RefCLK cycles,
+		 * default is 0x9C4 to create a 100us interval */
+		WREG32_SOC15(GC, 0, regRLC_GPM_TIMER_INT_3, 0x9C4);
+		/* RLC_GPM_GENERAL_12 : Minimum gap between wptr and rptr
+		 * to disable the page fault retry interrupts, default is
+		 * 0x100 (256) */
+		WREG32_SOC15(GC, 0, regRLC_GPM_GENERAL_12, 0x100);
+	}
+#endif
+}
+
+static int gfx_v9_4_3_rlc_load_microcode(struct amdgpu_device *adev)
+{
+	const struct rlc_firmware_header_v2_0 *hdr;
+	const __le32 *fw_data;
+	unsigned i, fw_size;
+
+	if (!adev->gfx.rlc_fw)
+		return -EINVAL;
+
+	hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
+	amdgpu_ucode_print_rlc_hdr(&hdr->header);
+
+	fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
+			   le32_to_cpu(hdr->header.ucode_array_offset_bytes));
+	fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
+
+	WREG32_SOC15(GC, 0, regRLC_GPM_UCODE_ADDR,
+			RLCG_UCODE_LOADING_START_ADDRESS);
+	for (i = 0; i < fw_size; i++) {
+		if (amdgpu_emu_mode == 1 && i % 100 == 0) {
+			dev_info(adev->dev, "Write RLC ucode data %u DWs\n", i);
+			msleep(1);
+		}
+		WREG32_SOC15(GC, 0, regRLC_GPM_UCODE_DATA, le32_to_cpup(fw_data++));
+	}
+	WREG32_SOC15(GC, 0, regRLC_GPM_UCODE_ADDR, adev->gfx.rlc_fw_version);
+
+	return 0;
+}
+
+static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
+{
+	int r;
+
+	adev->gfx.rlc.funcs->stop(adev);
+
+	/* disable CG */
+	WREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL, 0);
+
+	/* TODO: revisit pg function */
+	/* gfx_v9_4_3_init_pg(adev);*/
+
+	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
+		/* legacy rlc firmware loading */
+		r = gfx_v9_4_3_rlc_load_microcode(adev);
+		if (r)
+			return r;
+	}
+
+	adev->gfx.rlc.funcs->start(adev);
+
+	return 0;
+}
+
+static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
+{
+	u32 reg, data;
+
+	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
+	if (amdgpu_sriov_is_pp_one_vf(adev))
+		data = RREG32_NO_KIQ(reg);
+	else
+		data = RREG32(reg);
+
+	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
+	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+
+	if (amdgpu_sriov_is_pp_one_vf(adev))
+		WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
+	else
+		WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
+}
+
+static const struct soc15_reg_rlcg rlcg_access_gc_9_4_3[] = {
+	{SOC15_REG_ENTRY(GC, 0, regGRBM_GFX_INDEX)},
+	{SOC15_REG_ENTRY(GC, 0, regSQ_IND_INDEX)},
+};
+
+static bool gfx_v9_4_3_check_rlcg_range(struct amdgpu_device *adev,
+					uint32_t offset,
+					struct soc15_reg_rlcg *entries, int arr_size)
+{
+	int i;
+	uint32_t reg;
+
+	if (!entries)
+		return false;
+
+	for (i = 0; i < arr_size; i++) {
+		const struct soc15_reg_rlcg *entry;
+
+		entry = &entries[i];
+		reg = adev->reg_offset[entry->hwip][entry->instance][entry->segment] + entry->reg;
+		if (offset == reg)
+			return true;
+	}
+
+	return false;
+}
+
+static bool gfx_v9_4_3_is_rlcg_access_range(struct amdgpu_device *adev, u32 offset)
+{
+	return gfx_v9_4_3_check_rlcg_range(adev, offset,
+					(void *)rlcg_access_gc_9_4_3,
+					ARRAY_SIZE(rlcg_access_gc_9_4_3));
+}
+
+const struct amdgpu_rlc_funcs gfx_v9_4_3_rlc_funcs = {
+	.is_rlc_enabled = gfx_v9_4_3_is_rlc_enabled,
+	.set_safe_mode = gfx_v9_4_3_set_safe_mode,
+	.unset_safe_mode = gfx_v9_4_3_unset_safe_mode,
+	.init = gfx_v9_4_3_rlc_init,
+	.resume = gfx_v9_4_3_rlc_resume,
+	.stop = gfx_v9_4_3_rlc_stop,
+	.reset = gfx_v9_4_3_rlc_reset,
+	.start = gfx_v9_4_3_rlc_start,
+	.update_spm_vmid = gfx_v9_4_3_update_spm_vmid,
+	.is_rlcg_access_range = gfx_v9_4_3_is_rlcg_access_range,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h
new file mode 100644
index 000000000000..d21ea9ebf146
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h
@@ -0,0 +1,29 @@
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
+ *
+ */
+
+#ifndef __GFX_V9_4_3_H__
+#define __GFX_V9_4_3_H__
+
+extern const struct amdgpu_rlc_funcs gfx_v9_4_3_rlc_funcs;
+
+#endif /* __GFX_V9_4_3_H__ */
-- 
2.39.2

