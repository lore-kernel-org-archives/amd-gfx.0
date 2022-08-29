Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2516ECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 21:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C7110F3F9;
	Mon, 29 Aug 2022 21:18:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB59810EFC0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 21:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxygRkq0d7+P6z1ftHgcHrkKkHsdL+YLM7jzlpLiif9vEIKIop2lqejl91MMn1ll8tgSzwzyyeVutyra/wueGORowYOYGmQ8CmYbqoKbeoDInuZDxroQjFn892mXinCVD9kobCFJ+oZV4qj4FbYgyQwq8FBJvX+th/tVNlVDL/+S2LTsuxBcTCQF+StSsm0aDomxq1eKoEye+Fdz4l3wlZbzPkMhbDPEMw0z3IGWrk5LN0Y5BLcY6pDxxfFKqFpm+X31xfv53ywEqn2ekmwQbJemEkphJkMMEH9qjgpmGI3h9uwpQJgoAKdjMKvmikv9m70MGFG4ySpxDEDHCgdQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqPIsu8ZUy0YLGlGburWOgF4C+KABCJz467GcBfQJl4=;
 b=Ye3txGBANB685hKwwlIcmvokECx5QtuD1msrJ4ZkPTZIzS7du9eWEyYzXk8jfNMcO5X0eiMGyhOiLiX6Pz/AEQ+KzbwZn7PFjaeIpf2oZAIgsKI3OfD7iJx/wi7Ned95lJ3rYJkT381jxlmce4bGjRF/dcM+bTSrgzPBZ5/qGSGBvzMPckOjKQM5smPf/cSW1fPgC+JqNjbcQHpTw9na0FwTWcUc4CRwh1sBZTtkGZ79+bJVcVC13+EoQ/XoV7qyxWGyzvyLhqMBu+JdsAzK7dsN7Kso3tOFCRuzut2IxNA19dBGn3+751GcdRCzpSwHMMRu+NmcvPAvZ0qhSwJbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqPIsu8ZUy0YLGlGburWOgF4C+KABCJz467GcBfQJl4=;
 b=KlGMDj4+rYqr/7juUHEfnkNia1jJoojlvqYBr4/+BPm7XcHTSUYYsnI/IvN0NJvz0XUYvvrg3+4yalSYXlq0n5EGl9fclCg45zKn/xCJm/9eLC4TKUjwheeLOr7ujjyMXFtvyBgmTLdwEpz+Vx373Z+bGOICk7IzpqSujK8OW1w=
Received: from DS7PR05CA0075.namprd05.prod.outlook.com (2603:10b6:8:57::16) by
 DM5PR12MB1324.namprd12.prod.outlook.com (2603:10b6:3:76::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Mon, 29 Aug 2022 21:18:27 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::e8) by DS7PR05CA0075.outlook.office365.com
 (2603:10b6:8:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Mon, 29 Aug 2022 21:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 21:18:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 16:18:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu: enable imu_rlc_ram programming for v11_0_3
Date: Mon, 29 Aug 2022 17:17:53 -0400
Message-ID: <20220829211756.1152505-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829211756.1152505-1-alexander.deucher@amd.com>
References: <20220829211756.1152505-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4a534fd-c4dd-4968-6675-08da8a040406
X-MS-TrafficTypeDiagnostic: DM5PR12MB1324:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcFJJFj1+aT+muBD6fyo5S31buo4ukOEIVUrDAfBg6YxHj7Xe5COzlP4HaxwvC3OmEwEyFltEjL6QWpGvW2OFlJnK71c9Cc8EZ2/tu/YhAO7AV5uLaiA/DZ5EUk2RVnTTVkMz897yaqan/g+nAFqc3pkumLfI4KofceuOcLe1WOuwo48Qv7lw5DQJJ5qq33nolQACnahiMM6ga2mUP7rEr1xVn2m+2XiYjYuzBMv9Ub+gzzbzVKoxk7/BokTDyFySnNp8UwJJGjLRaCY6gtyYdqjuV8Y0lN0m/tB89dWg3d62YY9r3fPXYegQVaZ7+/e4Yfuof1w4kSPIPZRI+qv+IeSKY64pFHmtafIifuENEy6yP7FwwxYEmLmAjsia2yLY5UWwexQeFh7AXhkM7weNXXgyFEdogaTm9vLROhF/oABvO/Tgt9b4Rip7RuKCqgrn6arHEPM+OzPUWYmmUIVJ5TwpPQ0RLCXp/Wzr0wGbvNO5axPFWCRaZb+dRXMKFjHdkr74IZvvzyuJdV1B/BL8+Q0pZa6JQaenYB46iGG2HkX0efav/4SDWzbA4GBqCm0e3+skq4tNt4UjLYYEuY8iWiIlwvrGWcFZxhwHvsffrjbYVi/zIeBvjNA8NmiBHZR0kNt4eBvKsl7JgQbxis1C/4jkBNqvNDv4Ot/8vEyLohu4NFdMRDNr4/RvzpUutML+sYIT8cKrfbFYeM8pRtG5hoHk7h15DeYg1I43PXSpqojEMZYTFz1D5XcBkfG08H80x7pq1dZ+onu3S67tjGfTWi4fEVEqgo1aX4jU3ETS0E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(40470700004)(46966006)(36840700001)(86362001)(26005)(82310400005)(41300700001)(6666004)(478600001)(7696005)(186003)(40480700001)(82740400003)(40460700003)(81166007)(83380400001)(336012)(16526019)(356005)(47076005)(426003)(36860700001)(6916009)(70206006)(2906002)(54906003)(4326008)(5660300002)(8936002)(8676002)(36756003)(316002)(30864003)(1076003)(2616005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 21:18:27.7283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a534fd-c4dd-4968-6675-08da8a040406
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1324
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Yang Wang <KevinYang.Wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

All gc v11_0_3 registers in gcvml2 range have different
register offset from the ones in gc v11_0_0. v11_0_3
imu_rlc_ram programming has to be separated from v11_0_0
implementation

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c   |   6 +
 drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c | 144 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.h |  29 +++++
 4 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 59f354f043fc..6ad39cf71bdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -134,7 +134,8 @@ amdgpu-y += \
 	gfx_v9_4_2.o \
 	gfx_v10_0.o \
 	imu_v11_0.o \
-	gfx_v11_0.o
+	gfx_v11_0.o \
+	imu_v11_0_3.o
 
 # add async DMA block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index 76383baa3929..95548c512f4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -26,12 +26,15 @@
 #include "amdgpu_imu.h"
 #include "amdgpu_dpm.h"
 
+#include "imu_v11_0_3.h"
+
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_imu.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_imu.bin");
 
 static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 {
@@ -360,6 +363,9 @@ static void imu_v11_0_program_rlc_ram(struct amdgpu_device *adev)
 		program_imu_rlc_ram(adev, imu_rlc_ram_golden_11_0_2,
 				(const u32)ARRAY_SIZE(imu_rlc_ram_golden_11_0_2));
 		break;
+	case IP_VERSION(11, 0, 3):
+		imu_v11_0_3_program_rlc_ram(adev);
+		break;
 	default:
 		BUG();
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c
new file mode 100644
index 000000000000..70dd72511b3f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c
@@ -0,0 +1,144 @@
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
+#include "amdgpu_imu.h"
+
+#include "gc/gc_11_0_3_offset.h"
+#include "gc/gc_11_0_3_sh_mask.h"
+
+static const struct imu_rlc_ram_golden imu_rlc_ram_golden_11_0_3[] = {
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_IO_RD_COMBINE_FLUSH , 0x00055555, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_IO_WR_COMBINE_FLUSH , 0x00055555, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_DRAM_COMBINE_FLUSH , 0x00555555, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_MISC2 , 0x00001ffe, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_CREDITS , 0x003f3fff, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_TAG_RESERVE1 , 0x00000000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCC_RESERVE0 , 0x00041000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCC_RESERVE1 , 0x00000000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCD_RESERVE0 , 0x00040000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCD_RESERVE1 , 0x00000000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_MISC , 0x00000017, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_ENABLE , 0x00000001, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_CREDITS , 0x003f3fbf, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_TAG_RESERVE0 , 0x10200800, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_TAG_RESERVE1 , 0x00000088, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_VCC_RESERVE0 , 0x1d041040, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_VCC_RESERVE1 , 0x80000000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_IO_PRIORITY , 0x88888888, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_MAM_CTRL , 0x0000d800, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_ARB_FINAL , 0x000007ff, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_DRAM_PAGE_BURST , 0x20080200, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_ENABLE , 0x00000001, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2 , 0x00020000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_APT_CNTL , 0x0000000c, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_CACHEABLE_DRAM_ADDRESS_END , 0x000fffff, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_MISC , 0x0c48bff0, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SA_UNIT_DISABLE , 0x00fffc01, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_PRIM_CONFIG , 0x000fffe1, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_RB_BACKEND_DISABLE , 0xffffff01, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SHADER_ARRAY_CONFIG , 0xfffe0001, 0x40000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SHADER_ARRAY_CONFIG , 0xfffe0001, 0x42000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SHADER_ARRAY_CONFIG , 0xffff0001, 0x44000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SHADER_ARRAY_CONFIG , 0xffff0001, 0x46000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SHADER_ARRAY_CONFIG , 0xffff0001, 0x48000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SHADER_ARRAY_CONFIG , 0xffff0001, 0x4A000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCGTS_TCC_DISABLE, 0x00000001, 0x00000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SHADER_RATE_CONFIG, 0x00000001, 0x00000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_EDC_CONFIG, 0x00000001, 0x00000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL , 0x00000500, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR , 0x00000001, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR , 0x00000000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_START , 0x00000000, 0xe0000000 ),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_END , 0x000005ff, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_FB_LOCATION_BASE , 0x00006000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_FB_LOCATION_TOP , 0x000065ff, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT0_CNTL , 0x00000000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT1_CNTL , 0x00000000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_TOP_OF_DRAM_SLOT1 , 0xff800000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_LOWER_TOP_OF_DRAM2 , 0x00000001, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_UPPER_TOP_OF_DRAM2 , 0x00000fff, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL , 0x00001ffc, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL , 0x00000551, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL , 0x00080603, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL2 , 0x00000003, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL3 , 0x00100003, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL5 , 0x00003fe0, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT0_CNTL , 0x00000001, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CONTEXT0_PER_PFVF_PTE_CACHE_FRAGMENT_SIZES , 0x00000c00, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT1_CNTL , 0x00000001, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CONTEXT1_PER_PFVF_PTE_CACHE_FRAGMENT_SIZES , 0x00000c00, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG , 0x00000444, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2_PIPE_STEER_0 , 0x54105410, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2_PIPE_STEER_2 , 0x76323276, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG , 0x00000244, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCUTCL2_HARVEST_BYPASS_GROUPS , 0x00000006, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_APT_CNTL , 0x0000000c, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_BASE , 0x00000000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_BOT , 0x00000002, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_TOP , 0x00000000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2 , 0x00020000, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regSDMA0_UCODE_SELFLOAD_CONTROL, 0x00000210, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regSDMA1_UCODE_SELFLOAD_CONTROL, 0x00000210, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCPC_PSP_DEBUG, CPC_PSP_DEBUG__GPA_OVERRIDE_MASK, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCPG_PSP_DEBUG, CPG_PSP_DEBUG__GPA_OVERRIDE_MASK, 0xe0000000),
+};
+
+static void program_rlc_ram_register_setting(struct amdgpu_device *adev,
+					     const struct imu_rlc_ram_golden *regs,
+					     const u32 array_size)
+{
+	const struct imu_rlc_ram_golden *entry;
+	u32 reg, data;
+	int i;
+
+	for (i = 0; i < array_size; ++i) {
+		entry = &regs[i];
+		reg =  adev->reg_offset[entry->hwip][entry->instance][entry->segment] + entry->reg;
+		reg |= entry->addr_mask;
+
+		data = entry->data;
+		if (entry->reg == regGCMC_VM_AGP_BASE)
+			data = 0x00ffffff;
+		else if (entry->reg == regGCMC_VM_AGP_TOP)
+			data = 0x0;
+		else if (entry->reg == regGCMC_VM_FB_LOCATION_BASE)
+			data = adev->gmc.vram_start >> 24;
+		else if (entry->reg == regGCMC_VM_FB_LOCATION_TOP)
+			data = adev->gmc.vram_end >> 24;
+
+		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, 0);
+		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, reg);
+		WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, data);
+	}
+	//Indicate the latest entry
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_HIGH, 0);
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_ADDR_LOW, 0);
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_DATA, 0);
+}
+
+void imu_v11_0_3_program_rlc_ram(struct amdgpu_device *adev)
+{
+	program_rlc_ram_register_setting(adev,
+					 imu_rlc_ram_golden_11_0_3,
+					 (const u32)ARRAY_SIZE(imu_rlc_ram_golden_11_0_3));
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.h b/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.h
new file mode 100644
index 000000000000..702be568f26b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.h
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
+#ifndef __IMU_V11_0_3_H__
+#define __IMU_V11_0_3_H__
+
+void imu_v11_0_3_program_rlc_ram(struct amdgpu_device *adev);
+
+#endif
-- 
2.37.1

