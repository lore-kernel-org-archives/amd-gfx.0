Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89461C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 21:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 280B310E56B;
	Fri, 24 Mar 2023 21:51:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D071310E55F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 21:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bp+dEw2qO6UE9WfxvZGo/THt8vgUYagoLegD06wmVLFaDh+3zpwNUyuMNWUQX5bfmufMWGniAO1VWyK6TNOAsNKiNGil3o5Ei3Fw7VXzbAoHDHE4BCmR5Fd3MJgVdR6mvy+chCffwKDi+Kl1uM9ddSbMDdlHY2WL5Sov4UsUsjVZmIEcnopnuDfFkUd616dF9r87SjGbw36bfEiW6Ezk/8IvN6nkMYV+c0G9gaSEQNlRB+LsN57LVEeccQ1Xwxg40QatS+BAO4YQ+xH9fdl7sR5fqGLyHPJGBZ93v22RWMaXfCc6VdwhfQ9slFFYGqqRJIa24OrCb6/wvVUSvd0VTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X72jUSsFVrcT+sMtIsW5t4ZbwH+/HSllKUvB0ZFLu6Y=;
 b=jqWFz1GyjV2GHFPAi5uMVF/zzIgxTvFpsokm6CH7ieaSpk3f0MMl62/h8KTztfrktlAAKlgrCzj8FJdsddldiMjoF4bg/Ptfc5GY1UWLLAREMGDed6eqGk7/zXQCPHLsEtrc0XZ5a8Q8d1AtKntSOWEYBs8yYqOZT/8u3xcJOuEdApwR4g+Pfz5Zs6QQspPN0Gt8wqz4+PriE7YpH7AK/G+98zfAmTJZhFCMA/c+aifgxOhhVgt/51E6MyS9izqLRHuwjFFRCVtpLGuRUcDmvC+dUCc17EFbaEp20igGhJmkOcubTOJIjUGuo5pstDcMwny9W6VAVdkgKfDQM7x6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X72jUSsFVrcT+sMtIsW5t4ZbwH+/HSllKUvB0ZFLu6Y=;
 b=qRxLaNhgN+lRQY28xqu74mVBOxzwe7qPPOJTn9v/XbJVaQJXQ2WBR4BxtZ1RkfT5u5NlzbtottvPV8gcjh5CdFsVvah/IBmRM8BAmgxrxCRT7Ypfo9eNfPUfWaAQKnjdX8zshlRiSq2ZRcI+II8lTV0Sns5Qi08K6u8TC+dMn6w=
Received: from MWH0EPF00056D19.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:1a) by CH2PR12MB4278.namprd12.prod.outlook.com
 (2603:10b6:610:ab::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39; Fri, 24 Mar
 2023 21:51:51 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::205) by MWH0EPF00056D19.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.4 via Frontend
 Transport; Fri, 24 Mar 2023 21:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 21:51:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 16:51:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add nbio v7_9 support
Date: Fri, 24 Mar 2023 17:51:12 -0400
Message-ID: <20230324215113.2560000-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324215113.2560000-1-alexander.deucher@amd.com>
References: <20230324215113.2560000-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|CH2PR12MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea9ddf0-0a7b-4cac-fe54-08db2cb1f981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmlkVPsU0vqcy3EAT6Si35Fq9A1sYL77CU83RXj5SWcD44GMEqKQxwXU3m9uipkkKc3yuaMfoGZIsyUr8T47SeIOL+GFnlizBWqs+E/7gdzUiLdKOP9gG0pwA1r9yaEq+1kEuHDxu1lMct/fEDiHB+bNVKaFIPZekA8AqEzxBBM8SqVPGumoOOlvNrB6diaSSTOEBMO5N13NxkQv7IOC4ngSlwiesATuNjouk9LSmuWkn+n9xHeLcUpinwWje94u3a6z2ArEPeahabGqa2XVkCNyuXvXoGWjyieHQDta1zI944GKAMP1RYo9xqx0IARPn5ioRNqH7wZF2TxIcvfS+pYbU1ZH9OJM+K/X+xJhisaID2yZIGvvbaMABYmTVSmi1BNfdArjPiqUKqOXzUJIgpdp8c3VaHvY4O4aRwrZUkOa/8YpG3C5I74bbNz7LB2Gxt8kxM0mSZ4YiOg9z92xw0/9nnS6h871FufczU7Yf1e+fNbPbbc0R03Xlv1IDpRNRr9MGHsKYkUUPHJ1611DlDu/uudIE1CZh1yry26MhRhqBxQZPju8v5+JpkGSX/I3eCkEK++Ny2qJzHKijVBh7SALj+zROg9GgTN/Dcj17bUAEgJASp3O27NGgCUTsreQ+OjOPJMdK7bBuzcVM5ROo2RWQ+k+gJZ1+slEcyObqgYgFiwEVYRkSfYkj8xKHpKhmBxp6Hj7ueTexvPgbEh5m2qopjI+WPHVSsYiU6yBtFs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(66899021)(82740400003)(2906002)(6666004)(54906003)(47076005)(81166007)(4326008)(6916009)(41300700001)(70206006)(70586007)(356005)(2616005)(426003)(336012)(82310400005)(26005)(1076003)(86362001)(30864003)(7696005)(40480700001)(478600001)(316002)(8676002)(36860700001)(8936002)(16526019)(186003)(5660300002)(36756003)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 21:51:50.8374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea9ddf0-0a7b-4cac-fe54-08db2cb1f981
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4278
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

v7_9 is a new nbio generation ip.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   3 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 369 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h |  32 +++
 3 files changed, 403 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 5f9ac1bcb6bc..f2e4dfe8884f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -77,7 +77,8 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
-	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o
+	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
+	nbio_v7_9.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
new file mode 100644
index 000000000000..24d12075ca3a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -0,0 +1,369 @@
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
+#include "amdgpu.h"
+#include "amdgpu_atombios.h"
+#include "nbio_v7_9.h"
+#include "amdgpu_ras.h"
+
+#include "nbio/nbio_7_9_0_offset.h"
+#include "nbio/nbio_7_9_0_sh_mask.h"
+#include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void nbio_v7_9_remap_hdp_registers(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+}
+
+static u32 nbio_v7_9_get_rev_id(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+	tmp = REG_GET_FIELD(tmp, RCC_STRAP0_RCC_DEV0_EPF0_STRAP0, STRAP_ATI_REV_ID_DEV0_F0);
+
+	return tmp;
+}
+
+static void nbio_v7_9_mc_access_enable(struct amdgpu_device *adev, bool enable)
+{
+	if (enable)
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
+			BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK | BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
+}
+
+static u32 nbio_v7_9_get_memsize(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
+}
+
+static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instance,
+			bool use_doorbell, int doorbell_index, int doorbell_size)
+{
+	u32 doorbell_range = 0, doorbell_ctrl = 0;
+
+	doorbell_range =
+		REG_SET_FIELD(doorbell_range, DOORBELL0_CTRL_ENTRY_0,
+			BIF_DOORBELL0_RANGE_OFFSET_ENTRY, doorbell_index);
+	doorbell_range =
+		REG_SET_FIELD(doorbell_range, DOORBELL0_CTRL_ENTRY_0,
+			BIF_DOORBELL0_RANGE_SIZE_ENTRY, doorbell_size);
+	doorbell_ctrl =
+		REG_SET_FIELD(doorbell_ctrl, S2A_DOORBELL_ENTRY_1_CTRL,
+			S2A_DOORBELL_PORT1_ENABLE, 1);
+	doorbell_ctrl =
+		REG_SET_FIELD(doorbell_ctrl, S2A_DOORBELL_ENTRY_1_CTRL,
+			S2A_DOORBELL_PORT1_RANGE_SIZE, doorbell_size);
+
+	switch (instance) {
+	case 0:
+		WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_1, doorbell_range);
+
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_AWID, 0xe);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_RANGE_OFFSET, 0xe);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
+					0x1);
+		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_1_CTRL, doorbell_ctrl);
+		break;
+	case 1:
+		WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_2, doorbell_range);
+
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_AWID, 0x8);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_RANGE_OFFSET, 0x8);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
+					0x2);
+		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_2_CTRL, doorbell_ctrl);
+		break;
+	case 2:
+		WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_3, doorbell_range);
+
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_AWID, 0x9);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_RANGE_OFFSET, 0x9);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
+					0x8);
+		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_5_CTRL, doorbell_ctrl);
+		break;
+	case 3:
+		WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_4, doorbell_range);
+
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_AWID, 0xa);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_RANGE_OFFSET, 0xa);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+					S2A_DOORBELL_ENTRY_1_CTRL,
+					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
+					0x9);
+		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_6_CTRL, doorbell_ctrl);
+		break;
+	default:
+		break;
+	};
+
+	return;
+}
+
+static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_doorbell,
+					 int doorbell_index, int instance)
+{
+	u32 doorbell_range = 0, doorbell_ctrl = 0;
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+				DOORBELL0_CTRL_ENTRY_0,
+				BIF_DOORBELL0_RANGE_OFFSET_ENTRY,
+				doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+				DOORBELL0_CTRL_ENTRY_0,
+				BIF_DOORBELL0_RANGE_SIZE_ENTRY,
+				0x8);
+
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_ENABLE, 1);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_AWID, 0x4);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_RANGE_OFFSET, 0x4);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_RANGE_SIZE, 0x8);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE, 0x4);
+	} else {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+				DOORBELL0_CTRL_ENTRY_0,
+				BIF_DOORBELL0_RANGE_SIZE_ENTRY, 0);
+		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_RANGE_SIZE, 0);
+	}
+
+	WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17, doorbell_range);
+	WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL, doorbell_ctrl);
+}
+
+static void nbio_v7_9_enable_doorbell_aperture(struct amdgpu_device *adev,
+					       bool enable)
+{
+	/* Enable to allow doorbell pass thru on pre-silicon bare-metal */
+	WREG32_SOC15(NBIO, 0, regBIFC_DOORBELL_ACCESS_EN_PF, 0xfffff);
+	WREG32_FIELD15_PREREG(NBIO, 0, RCC_DEV0_EPF0_RCC_DOORBELL_APER_EN,
+			BIF_DOORBELL_APER_EN, enable ? 1 : 0);
+}
+
+static void nbio_v7_9_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
+							bool enable)
+{
+	u32 tmp = 0;
+
+	if (enable) {
+		tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_EN, 1) |
+		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_MODE, 1) |
+		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
+
+		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
+			     lower_32_bits(adev->doorbell.base));
+		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
+			     upper_32_bits(adev->doorbell.base));
+	}
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, tmp);
+}
+
+static void nbio_v7_9_ih_doorbell_range(struct amdgpu_device *adev,
+					bool use_doorbell, int doorbell_index)
+{
+	u32 ih_doorbell_range = 0, ih_doorbell_ctrl = 0;
+
+	if (use_doorbell) {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+				DOORBELL0_CTRL_ENTRY_0,
+				BIF_DOORBELL0_RANGE_OFFSET_ENTRY,
+				doorbell_index);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+				DOORBELL0_CTRL_ENTRY_0,
+				BIF_DOORBELL0_RANGE_SIZE_ENTRY,
+				0x4);
+
+		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_ENABLE, 1);
+		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_AWID, 0);
+		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_RANGE_OFFSET, 0);
+		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_RANGE_SIZE, 0x4);
+		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE, 0);
+	} else {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+				DOORBELL0_CTRL_ENTRY_0,
+				BIF_DOORBELL0_RANGE_SIZE_ENTRY, 0);
+		ih_doorbell_ctrl = REG_SET_FIELD(ih_doorbell_ctrl,
+				S2A_DOORBELL_ENTRY_1_CTRL,
+				S2A_DOORBELL_PORT1_RANGE_SIZE, 0);
+	}
+
+	WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_0, ih_doorbell_range);
+	WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_3_CTRL, ih_doorbell_ctrl);
+}
+
+
+static void nbio_v7_9_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						       bool enable)
+{
+}
+
+static void nbio_v7_9_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+						      bool enable)
+{
+}
+
+static void nbio_v7_9_get_clockgating_state(struct amdgpu_device *adev,
+					    u64 *flags)
+{
+}
+
+static void nbio_v7_9_ih_control(struct amdgpu_device *adev)
+{
+	u32 interrupt_cntl;
+
+	/* setup interrupt control */
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_page_addr >> 8);
+	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL);
+	/* INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=0 - dummy read disabled with msi, enabled without msi
+	 * INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=1 - dummy read controlled by IH_DUMMY_RD_EN
+	 */
+	interrupt_cntl =
+		REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL, IH_DUMMY_RD_OVERRIDE, 0);
+	/* INTERRUPT_CNTL__IH_REQ_NONSNOOP_EN_MASK=1 if ring is in non-cacheable memory, e.g., vram */
+	interrupt_cntl =
+		REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL, IH_REQ_NONSNOOP_EN, 0);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
+}
+
+static u32 nbio_v7_9_get_hdp_flush_req_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
+}
+
+static u32 nbio_v7_9_get_hdp_flush_done_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
+}
+
+static u32 nbio_v7_9_get_pcie_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX2);
+}
+
+static u32 nbio_v7_9_get_pcie_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA2);
+}
+
+const struct nbio_hdp_flush_reg nbio_v7_9_hdp_flush_reg = {
+	.ref_and_mask_cp0 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP0_MASK,
+	.ref_and_mask_cp1 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP1_MASK,
+	.ref_and_mask_cp2 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP2_MASK,
+	.ref_and_mask_cp3 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP3_MASK,
+	.ref_and_mask_cp4 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP4_MASK,
+	.ref_and_mask_cp5 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP5_MASK,
+	.ref_and_mask_cp6 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP6_MASK,
+	.ref_and_mask_cp7 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP7_MASK,
+	.ref_and_mask_cp8 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP8_MASK,
+	.ref_and_mask_cp9 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP9_MASK,
+	.ref_and_mask_sdma0 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA0_MASK,
+	.ref_and_mask_sdma1 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
+	.ref_and_mask_sdma2 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG0_MASK,
+	.ref_and_mask_sdma3 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
+	.ref_and_mask_sdma4 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
+	.ref_and_mask_sdma5 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
+	.ref_and_mask_sdma6 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
+	.ref_and_mask_sdma7 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
+};
+
+static void nbio_v7_9_enable_doorbell_interrupt(struct amdgpu_device *adev,
+						bool enable)
+{
+	WREG32_FIELD15_PREREG(NBIO, 0, BIF_BX0_BIF_DOORBELL_INT_CNTL,
+			      DOORBELL_INTERRUPT_DISABLE, enable ? 0 : 1);
+}
+
+const struct amdgpu_nbio_funcs nbio_v7_9_funcs = {
+	.get_hdp_flush_req_offset = nbio_v7_9_get_hdp_flush_req_offset,
+	.get_hdp_flush_done_offset = nbio_v7_9_get_hdp_flush_done_offset,
+	.get_pcie_index_offset = nbio_v7_9_get_pcie_index_offset,
+	.get_pcie_data_offset = nbio_v7_9_get_pcie_data_offset,
+	.get_rev_id = nbio_v7_9_get_rev_id,
+	.mc_access_enable = nbio_v7_9_mc_access_enable,
+	.get_memsize = nbio_v7_9_get_memsize,
+	.sdma_doorbell_range = nbio_v7_9_sdma_doorbell_range,
+	.vcn_doorbell_range = nbio_v7_9_vcn_doorbell_range,
+	.enable_doorbell_aperture = nbio_v7_9_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbio_v7_9_enable_doorbell_selfring_aperture,
+	.ih_doorbell_range = nbio_v7_9_ih_doorbell_range,
+	.enable_doorbell_interrupt = nbio_v7_9_enable_doorbell_interrupt,
+	.update_medium_grain_clock_gating = nbio_v7_9_update_medium_grain_clock_gating,
+	.update_medium_grain_light_sleep = nbio_v7_9_update_medium_grain_light_sleep,
+	.get_clockgating_state = nbio_v7_9_get_clockgating_state,
+	.ih_control = nbio_v7_9_ih_control,
+	.remap_hdp_registers = nbio_v7_9_remap_hdp_registers,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h
new file mode 100644
index 000000000000..8e04eb484328
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h
@@ -0,0 +1,32 @@
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
+#ifndef __NBIO_V7_9_H__
+#define __NBIO_V7_9_H__
+
+#include "soc15_common.h"
+
+extern const struct nbio_hdp_flush_reg nbio_v7_9_hdp_flush_reg;
+extern const struct amdgpu_nbio_funcs nbio_v7_9_funcs;
+
+#endif
-- 
2.39.2

