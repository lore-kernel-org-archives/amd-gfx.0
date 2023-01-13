Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFBFC678DE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 06:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A6A10E99C;
	Fri, 13 Jan 2023 06:25:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A6710E1E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:25:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVyQwPzyQXTFvmnSsDBLW2E1cIuuqMCGZ2pX1T2aY4eZBNZEZtTFO+CngyzIB3a2S7lP6R/PjRZOIaeTx1yV2KjSDlqlJzTvwrU981xUuv4hVqGvw+Zu80TdPMXtDGQntw+JYbSY5jUhrczmDlw7RvJxIuSOXFwgAveL4+gTAhUmAC6imhP1qy0ZPjctpaoZN9HFYoNWmepkNyESgKYLrm11oqPw3Flx5mC9UxhJuMgqzG1JpIVL/QyKYaLUyRwqa9biPT0PI/d6eZGT+thcFJS6AnVXWuDdxyj/B9u1DhY7vdS0qE0VxfcQosTpXIRxNl9HL/1J9QqsfiS2roKCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEC9PAh08Hg+SlBRRrt4G1KDXKeVlAl0ehgPJwcyCNg=;
 b=RR11jnkzAXyYn8Tp2h9ixApi5m55T0Hd7AJ+QgA9zWJZISOEjJ3c/yfsyRLxSEmkSxmPl0GGQNRQeh2OYhE2TCszSLwlO528q9STnGRttqfO8hYMZ4Zr3JWg1mO8xiKUZhtE+iUZuxFdlzCijGARJomyW+xwctpCGIgKti4Kobm2ctnyl+BvyzTRGes1azogL6uW0gLUluD4ofUs9lPc75BUOo3dq3m38NYGEEFwdMSasyuqePdSHHnxZSEusyghI0f2LNhQqyFgRY9Dew8i0AEuuKAs/KqT/TI/Bz1+xGHqG48ZI/50kcyxc1S4tpxRQcTGJTHWD/YFfGCeVtUhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEC9PAh08Hg+SlBRRrt4G1KDXKeVlAl0ehgPJwcyCNg=;
 b=kJcJw8giDHnrCHgEtST6ulxEvNTwgpXNu0UFeXK2K3/ZfAJcfkPmkJ3KKLy4Nv5EU2xbymzjmN/rGQ83trup3MYNx4n5csI0SPzKNSthrLO43hs0Q/Wq9PhEBo6cl5R1zqBBVl8J9SNfccpv3ThRLWf1H3OtiDVKHJbzuNrl1S0=
Received: from DS7PR06CA0041.namprd06.prod.outlook.com (2603:10b6:8:54::10) by
 SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 06:25:02 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::11) by DS7PR06CA0041.outlook.office365.com
 (2603:10b6:8:54::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 06:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 06:25:01 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 00:24:58 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: Add gfx ras function on gfx v11_0_3
Date: Fri, 13 Jan 2023 14:23:54 +0800
Message-ID: <20230113062358.1727355-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT058:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9e8892-359a-4a08-1fd7-08daf52ee6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ic24NSgeeoKnQKHJCa3DwTRDRvdFRxtLbA48StzElSM4iJtbZc3HfSaorLtbdRJOkAz/efVPEEa+yqnoW3I2qpxlP93iyw4+t8ThaoyqEtn3LOrARV8Bdk9diZB2yWtGFFC23AhUhcJd7TO6GaWRtR84Y7N7XxeNCs2BD2ezK4GwWEZ/cwKKTfZNzuGbrRd8Vewaui5uIxOPpTRxRVLOMa7UqB21e8sKnDbQXdEwVBPuZhoq4ajubTBccdNcM5MtcUuX+0g4reJOSIxCCOkYOlwwCOwXSb4fkR7RyCnvz0hvZC3sECasqROuCVn8LINrSHBeOh5mMn0WpKViUmD25k0dn2nvhObCK2Tq/PF2G2+q6WP+IqWli/FJW8aUi1NknZk7HP6ZANmoioqHItH7qZdCBnjFBW83QtenMPcbNPnTsnNeCulB7LC1Z3FX3/fgxrz6hwT4tUjLGWyqJIXxvORdounEF8YFCJBxPfzqsDiTQdUSgrCKofs/dnshXt1nBgXZ/BjLUpHWFg2y3J/J6njsfejHLqY1ixKGJQ+C5+OPpyo8vxYuXSmqYM8jLLMpvmG33kLDYO6UyNIVRv5R2fLIKvlMz7IGcBFZNYx8EfvUp1Y+JGrD9l6OElqZrygTPRTuBvhM+XEuHryuhBIk/MXNCgF7E47r0xhVVO/5F1E89HLovAEPlP7y6eOlrCB5tBrJbcshEI5rCfhlOzNZNXGsm279rezuh4yyAwDU0ho=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(66899015)(2906002)(7696005)(6666004)(26005)(16526019)(478600001)(186003)(36756003)(54906003)(4326008)(8676002)(6916009)(70586007)(316002)(70206006)(336012)(2616005)(426003)(1076003)(40460700003)(41300700001)(36860700001)(82740400003)(5660300002)(83380400001)(8936002)(40480700001)(47076005)(86362001)(82310400005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 06:25:01.6707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9e8892-359a-4a08-1fd7-08daf52ee6e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking.Zhang@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Candice.Li@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add gfx ras function on gfx v11_0_3.

V2:
 1. Add separate source files for gfx v11_0_3.
 2. Create a common function to initialize gfx ras block.

V3:
 1. Rename amdgpu_gfx_ras_block_init to amdgpu_gfx_ras_sw_init.
 2. Adjust the calling position of amdgpu_gfx_ras_sw_init.
 3. Remove gfx_v11_0_3_ras_ops.

V4:
 Revert changes in amdgpu_ras_interrupt_poison_consumption_handler.

V5:
 1. Remove invalid include file in gfx_v11_0_3.c.
 2. Reduce the number of parameters of amdgpu_gfx_ras_sw_init.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 35 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 13 +++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c | 27 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.h | 29 ++++++++++++++++++++
 6 files changed, 106 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 332cf8bda7a2..5df603192cdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -137,6 +137,7 @@ amdgpu-y += \
 	gfx_v10_0.o \
 	imu_v11_0.o \
 	gfx_v11_0.o \
+	gfx_v11_0_3.o \
 	imu_v11_0_3.o
 
 # add async DMA block
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 42a939cd2eac..09c42c00e43c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -696,6 +696,41 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	return r;
 }
 
+int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err = 0;
+	struct amdgpu_gfx_ras *ras = NULL;
+
+	/* adev->gfx.ras is NULL, which means gfx does not
+	 * support ras function, then do nothing here.
+	 */
+	if (!adev->gfx.ras)
+		return 0;
+
+	ras = adev->gfx.ras;
+
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register gfx ras block!\n");
+		return err;
+	}
+
+	strcpy(ras->ras_block.ras_comm.name, "gfx");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__GFX;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+	adev->gfx.ras_if = &ras->ras_block.ras_comm;
+
+	/* If not define special ras_late_init function, use gfx default ras_late_init */
+	if (!ras->ras_block.ras_late_init)
+		ras->ras_block.ras_late_init = amdgpu_ras_block_late_init;
+
+	/* If not defined special ras_cb function, use default ras_cb */
+	if (!ras->ras_block.ras_cb)
+		ras->ras_block.ras_cb = amdgpu_gfx_process_ras_data_cb;
+
+	return 0;
+}
+
 int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
 		void *err_data,
 		struct amdgpu_iv_entry *entry)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index b3df4787877e..6b26597217ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -432,4 +432,5 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v);
 int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev);
 void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev, uint32_t ucode_id);
 
+int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 259ebf0356db..82beb46788cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -46,6 +46,7 @@
 #include "clearstate_gfx11.h"
 #include "v11_structs.h"
 #include "gfx_v11_0.h"
+#include "gfx_v11_0_3.h"
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
 
@@ -852,7 +853,14 @@ static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
+		adev->gfx.config.max_hw_contexts = 8;
+		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
+		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
+		adev->gfx.config.sc_hiz_tile_fifo_size = 0;
+		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
+		break;
 	case IP_VERSION(11, 0, 3):
+		adev->gfx.ras = &gfx_v11_0_3_ras;
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1422,6 +1430,11 @@ static int gfx_v11_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	if (amdgpu_gfx_ras_sw_init(adev)) {
+		dev_err(adev->dev, "Failed to initialize gfx ras block!\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
new file mode 100644
index 000000000000..5966d984a30a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -0,0 +1,27 @@
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
+#include "amdgpu.h"
+
+
+struct amdgpu_gfx_ras gfx_v11_0_3_ras;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.h b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.h
new file mode 100644
index 000000000000..7095abddcbc0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2023 dvanced Micro Devices, Inc.
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
+#ifndef __GFX_V11_0_3_H__
+#define __GFX_V11_0_3_H__
+
+extern struct amdgpu_gfx_ras gfx_v11_0_3_ras;
+
+#endif
-- 
2.25.1

