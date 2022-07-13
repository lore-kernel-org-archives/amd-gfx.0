Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D552EC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 03:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24232112CB0;
	Wed, 13 Jul 2022 03:25:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD45A112CB0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 03:25:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2BkNfHseJUn9iltq25W61u6k/YmnXZm8Bhgl/KQkIOYy35Bp7bTutZDSImzDDEE+B+mwJT6JOWLMGDDhNtxmevs54H+wlLNTWmtbqzbg60tYwnXkk7iD9xp2n414tBi9cZt9DWDHVP8WZahrJtRrzmgaXBESuFcDlW5WlgYkBS2DnMnqYO0n4ASONJF3e9okW8YbMPDtn6bxOrd0Cm6vhuYNnIdSY6z0kTj+Si3GHGDQ3Xfo5ekt3AD4g/m//A02X8v/agL961ozIOy5PW5DQFR909Wedn9ezArn+/N0B26toPgoi6HuUuqTXVhD3TQ5KiZqEYprw/qMZX4VGQR4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOEQWQChXamoJ9eKdxdG+juZjPzBq0fdN8BN2coZ9RA=;
 b=IKxpfZAbXTPuAJlfVrT07EGUd/CsVTr3lde2nDmRwjPU24w6WAYcnp+RgHQVpASkczGYuOYdPmCUUcFf/MslCfcBrLJ55gpdMDnvkgg/keBknUzI0TC9DRSBk0OBV7orN7Fo4deb0r3Va16MtSuzbVQR2r+BpEUjCY1jH0koOMQflABtIdnBVVebh7r30MiDioks4X7lQRI1jrZXXdlXctOxtuoSxKhHJemXAref21yZdKgfvbcuefw3EeRnoRJwGLZlWj+ihOQQKGkorurhDPDWnmJBFm/qWJKB8iWfbggI81ctPFUxiz26kpeq3F5uFa9lFCWoXaB9f+Flbeclrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOEQWQChXamoJ9eKdxdG+juZjPzBq0fdN8BN2coZ9RA=;
 b=lDaFG4OzJBqTk8x+gFHDiHd7FnpBXMzK+mR3ZPDD0CJvHjWOCSTiieGRGCzYcJ+nAr5faTn3iSFB9KXWDc2tKS4+uSwzivaNOmNh50Io72cNXNNRRr2JYW+iCco/aty49m7frRR/bYEyRfHlHhD3bdkuVzyDXC6xgJdPOFGAsO0=
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 03:25:50 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::2a) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Wed, 13 Jul 2022 03:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 03:25:49 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 22:25:46 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add umc ras functions for umc v8_10_0
Date: Wed, 13 Jul 2022 11:25:09 +0800
Message-ID: <20220713032509.293402-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713032509.293402-1-YiPeng.Chai@amd.com>
References: <20220713032509.293402-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7237c5b0-b07a-422c-1756-08da647f6267
X-MS-TrafficTypeDiagnostic: CY5PR12MB6156:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHvUJWAsEPsrfz39kd3Wy6aiAwKI/7i5GJ0QDEl1+2J0UsMEY2Jgg+TC8ZqDx4umA2oodSpMa0HGZYAyxH5iQBa4S6zbbbnlpWfO2GZuZsDc7LLAGw/A1JhLbPOQdO0bSzAbH1r8iyogkox55OWdu/rRLGS/1HPCf4WfhrBDQp6ojK/mqYJL2s2JYWTNxgISSqcBLH1RbRJWiumRuXe50vbQENNHCwtrbeumdWnNo7R/TAB1u/+BhUXyYZ1HExxgHOc8V2sn99h/f5AYGgTmw+IS0fbdWGsd2ZKTP0/ugzbMiSN4LJ9PAFXEpIR/7ktXTEAEYntr3e4+iutJOxhcqt8je4QJXMTJMqyx8af/ctK5+vHRZ8pOy81m/avl9HWpTrunSqWD5JKO0iy9UDQX4D2B3AGCOolKBgi7YwyVY1L/kP3uZWna94dlR/GwN2NR1K2zN/4xWRoweBMYJ135TIE8B1ZY4y0Mub5WDY+JE5tK5VunNAW6TagwdLNFiYX+VeehmYxNR9c+1sDV7FFDbwbuzLM+kFzdk+DYUFghGeGQN1/U0Atw2ZUSFQTKEkmdbSzRmC1HF39BmCQ1pptLiIqlSvVB3i9esazqTONANUd4JIN99Z/d6/LKdqkaKBvM6k7xiXr4dK0j2vS1RUPIyTGkJKJZiDkNWA1IUUaxlm+TKmaO4tPjJBrvdC4glkamGJt+MA8dAS76E6SfAymnQ2a85UWqo8Xnj7Zc4zs5+sLrkwHY+NMWurtmv1gEwvJfH1Flp+cBFakzhO6ryWyCDR/tG7qtievknuZBFzDa+qS68NROaVwhKlu5VqR64LjSietbAan7f5Oi74jJ5UCfD9SmbN3nHwZv5o3ywQL1f5o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(40470700004)(46966006)(36840700001)(30864003)(83380400001)(82740400003)(81166007)(356005)(186003)(16526019)(40480700001)(426003)(36860700001)(4326008)(54906003)(5660300002)(336012)(6916009)(70586007)(70206006)(36756003)(47076005)(8676002)(40460700003)(8936002)(86362001)(6666004)(26005)(316002)(7696005)(82310400005)(41300700001)(2906002)(1076003)(2616005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 03:25:49.9019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7237c5b0-b07a-422c-1756-08da647f6267
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
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
Cc: Tao
 Zhou <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, yipechai@amd.com,
 Alexander Deucher <Alexander.Deucher@amd.com>, Candice.Li@amd.com,
 John.Clements@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Support query umc ras error counter.
2. Support ras umc ue error address remapping.

v2:
  Use adev->gmc.num_umc to replace hardcoded definitions.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  10 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  27 +-
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c  | 357 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.h  |  70 +++++
 5 files changed, 464 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v8_10.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index a87e42c2c8dc..c7d0cd15b5ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -93,7 +93,7 @@ amdgpu-y += \
 
 # add UMC block
 amdgpu-y += \
-	umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o
+	umc_v6_0.o umc_v6_1.o umc_v6_7.o umc_v8_7.o umc_v8_10.o
 
 # add IH block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 2ec6698aa1fe..3629d8f292ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -41,6 +41,12 @@
 #define LOOP_UMC_CH_INST(ch_inst) for ((ch_inst) = 0; (ch_inst) < adev->umc.channel_inst_num; (ch_inst)++)
 #define LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) LOOP_UMC_INST((umc_inst)) LOOP_UMC_CH_INST((ch_inst))
 
+#define LOOP_UMC_NODE_INST(node_inst) \
+		for ((node_inst) = 0; (node_inst) < adev->umc.node_inst_num; (node_inst)++)
+
+#define LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) \
+		LOOP_UMC_NODE_INST((node_inst)) LOOP_UMC_INST_AND_CH((umc_inst), (ch_inst))
+
 struct amdgpu_umc_ras {
 	struct amdgpu_ras_block_object ras_block;
 	void (*err_cnt_init)(struct amdgpu_device *adev);
@@ -62,6 +68,10 @@ struct amdgpu_umc {
 	uint32_t channel_inst_num;
 	/* number of umc instance with memory map register access */
 	uint32_t umc_inst_num;
+
+	/*number of umc node instance with memory map register access*/
+	uint32_t node_inst_num;
+
 	/* UMC regiser per channel offset */
 	uint32_t channel_offs;
 	/* channel index table of interleaved memory */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index edbdc0b934ea..503e40a90319 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -25,7 +25,7 @@
 #include "amdgpu.h"
 #include "amdgpu_atomfirmware.h"
 #include "gmc_v11_0.h"
-#include "umc_v8_7.h"
+#include "umc_v8_10.h"
 #include "athub/athub_3_0_0_sh_mask.h"
 #include "athub/athub_3_0_0_offset.h"
 #include "oss/osssys_6_0_0_offset.h"
@@ -537,11 +537,36 @@ static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[UMC_HWIP][0]) {
 	case IP_VERSION(8, 10, 0):
+		adev->umc.channel_inst_num = UMC_V8_10_CHANNEL_INSTANCE_NUM;
+		adev->umc.umc_inst_num = UMC_V8_10_UMC_INSTANCE_NUM;
+		adev->umc.node_inst_num = adev->gmc.num_umc;
+		adev->umc.max_ras_err_cnt_per_query = UMC_V8_10_TOTAL_CHANNEL_NUM(adev);
+		adev->umc.channel_offs = UMC_V8_10_PER_CHANNEL_OFFSET;
+		adev->umc.channel_idx_tbl = &umc_v8_10_channel_idx_tbl[0][0][0];
+		adev->umc.ras = &umc_v8_10_ras;
+		break;
 	case IP_VERSION(8, 11, 0):
 		break;
 	default:
 		break;
 	}
+
+	if (adev->umc.ras) {
+		amdgpu_ras_register_ras_block(adev, &adev->umc.ras->ras_block);
+
+		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
+		adev->umc.ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__UMC;
+		adev->umc.ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+		adev->umc.ras_if = &adev->umc.ras->ras_block.ras_comm;
+
+		/* If don't define special ras_late_init function, use default ras_late_init */
+		if (!adev->umc.ras->ras_block.ras_late_init)
+			adev->umc.ras->ras_block.ras_late_init = amdgpu_umc_ras_late_init;
+
+		/* If not define special ras_cb function, use default ras_cb */
+		if (!adev->umc.ras->ras_block.ras_cb)
+			adev->umc.ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
+	}
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
new file mode 100644
index 000000000000..36a2053f2e8b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -0,0 +1,357 @@
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
+#include "umc_v8_10.h"
+#include "amdgpu_ras.h"
+#include "amdgpu_umc.h"
+#include "amdgpu.h"
+#include "umc/umc_8_10_0_offset.h"
+#include "umc/umc_8_10_0_sh_mask.h"
+
+#define UMC_8_NODE_DIST   0x800000
+#define UMC_8_INST_DIST   0x4000
+
+struct channelnum_map_colbit {
+	uint32_t channel_num;
+	uint32_t col_bit;
+};
+
+const struct channelnum_map_colbit umc_v8_10_channelnum_map_colbit_table[] = {
+	{24, 13},
+	{20, 13},
+	{16, 12},
+	{14, 12},
+	{12, 12},
+	{10, 12},
+	{6,  11},
+};
+
+const uint32_t
+	umc_v8_10_channel_idx_tbl[]
+				[UMC_V8_10_UMC_INSTANCE_NUM]
+				[UMC_V8_10_CHANNEL_INSTANCE_NUM] = {
+	   {{16, 18}, {17, 19}},
+	   {{15, 11}, {3,   7}},
+	   {{1,   5}, {13,  9}},
+	   {{23, 21}, {22, 20}},
+	   {{0,   4}, {12,  8}},
+	   {{14, 10}, {2,   6}}
+	};
+
+static inline uint32_t get_umc_v8_10_reg_offset(struct amdgpu_device *adev,
+					    uint32_t node_inst,
+					    uint32_t umc_inst,
+					    uint32_t ch_inst)
+{
+	return adev->umc.channel_offs * ch_inst + UMC_8_INST_DIST * umc_inst +
+		UMC_8_NODE_DIST * node_inst;
+}
+
+static void umc_v8_10_clear_error_count_per_channel(struct amdgpu_device *adev,
+					uint32_t umc_reg_offset)
+{
+	uint32_t ecc_err_cnt_addr;
+
+	ecc_err_cnt_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt);
+
+	/* clear error count */
+	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
+			UMC_V8_10_CE_CNT_INIT);
+}
+
+static void umc_v8_10_clear_error_count(struct amdgpu_device *adev)
+{
+	uint32_t node_inst       = 0;
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_v8_10_reg_offset(adev,
+						node_inst,
+						umc_inst,
+						ch_inst);
+
+		umc_v8_10_clear_error_count_per_channel(adev,
+						umc_reg_offset);
+	}
+}
+
+static void umc_v8_10_query_correctable_error_count(struct amdgpu_device *adev,
+						   uint32_t umc_reg_offset,
+						   unsigned long *error_count)
+{
+	uint32_t ecc_err_cnt, ecc_err_cnt_addr;
+	uint64_t mc_umc_status;
+	uint32_t mc_umc_status_addr;
+
+	/* UMC 8_10 registers */
+	ecc_err_cnt_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt);
+	mc_umc_status_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
+
+	ecc_err_cnt = RREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4);
+	*error_count +=
+		(REG_GET_FIELD(ecc_err_cnt, UMCCH0_0_GeccErrCnt, GeccErrCnt) -
+		 UMC_V8_10_CE_CNT_INIT);
+
+	/* Check for SRAM correctable error, MCUMC_STATUS is a 64 bit register */
+	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
+		*error_count += 1;
+}
+
+static void umc_v8_10_query_uncorrectable_error_count(struct amdgpu_device *adev,
+						      uint32_t umc_reg_offset,
+						      unsigned long *error_count)
+{
+	uint64_t mc_umc_status;
+	uint32_t mc_umc_status_addr;
+
+	mc_umc_status_addr = SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
+
+	/* Check the MCUMC_STATUS. */
+	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
+	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1))
+		*error_count += 1;
+}
+
+static void umc_v8_10_query_ras_error_count(struct amdgpu_device *adev,
+					   void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+
+	uint32_t node_inst       = 0;
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_v8_10_reg_offset(adev,
+						node_inst,
+						umc_inst,
+						ch_inst);
+
+		umc_v8_10_query_correctable_error_count(adev,
+						umc_reg_offset,
+						&(err_data->ce_count));
+		umc_v8_10_query_uncorrectable_error_count(adev,
+						umc_reg_offset,
+						&(err_data->ue_count));
+	}
+
+	umc_v8_10_clear_error_count(adev);
+}
+
+static uint32_t umc_v8_10_get_col_bit(uint32_t channel_num)
+{
+	uint32_t t = 0;
+
+	for (t = 0; t < ARRAY_SIZE(umc_v8_10_channelnum_map_colbit_table); t++)
+		if (channel_num == umc_v8_10_channelnum_map_colbit_table[t].channel_num)
+			return umc_v8_10_channelnum_map_colbit_table[t].col_bit;
+
+	/* Failed to get col_bit. */
+	return U32_MAX;
+}
+
+/*
+ * Mapping normal address to soc physical address in swizzle mode.
+ */
+static int umc_v8_10_swizzle_mode_na_to_pa(struct amdgpu_device *adev,
+					uint32_t channel_idx,
+					uint64_t na, uint64_t *soc_pa)
+{
+	uint32_t channel_num = UMC_V8_10_TOTAL_CHANNEL_NUM(adev);
+	uint32_t col_bit = umc_v8_10_get_col_bit(channel_num);
+	uint64_t tmp_addr;
+
+	if (col_bit == U32_MAX)
+		return -1;
+
+	tmp_addr = SWIZZLE_MODE_TMP_ADDR(na, channel_num, channel_idx);
+	*soc_pa = SWIZZLE_MODE_ADDR_HI(tmp_addr, col_bit) |
+		SWIZZLE_MODE_ADDR_MID(na, col_bit) |
+		SWIZZLE_MODE_ADDR_LOW(tmp_addr, col_bit) |
+		SWIZZLE_MODE_ADDR_LSB(na);
+
+	return 0;
+}
+
+static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
+					 struct ras_err_data *err_data,
+					 uint32_t umc_reg_offset,
+					 uint32_t node_inst,
+					 uint32_t ch_inst,
+					 uint32_t umc_inst)
+{
+	uint64_t mc_umc_status_addr;
+	uint64_t mc_umc_status, err_addr;
+	uint32_t channel_index;
+
+	mc_umc_status_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
+	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
+
+	if (mc_umc_status == 0)
+		return;
+
+	if (!err_data->err_addr) {
+		/* clear umc status */
+		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+		return;
+	}
+
+	channel_index =
+		adev->umc.channel_idx_tbl[node_inst * adev->umc.umc_inst_num *
+					adev->umc.channel_inst_num +
+					umc_inst * adev->umc.channel_inst_num +
+					ch_inst];
+
+	/* calculate error address if ue/ce error is detected */
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrV) == 1 &&
+	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
+	     REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
+		uint32_t addr_lsb;
+		uint64_t mc_umc_addrt0;
+
+		mc_umc_addrt0 = SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
+		err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
+		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+
+		/* the lowest lsb bits should be ignored */
+		addr_lsb = REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrLsb);
+
+		err_addr &= ~((0x1ULL << addr_lsb) - 1);
+
+		/* we only save ue error information currently, ce is skipped */
+		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) {
+			uint64_t na_err_addr_base = err_addr & ~(0x3ULL << UMC_V8_10_NA_C5_BIT);
+			uint64_t na_err_addr, retired_page_addr;
+			uint32_t col = 0;
+			int ret = 0;
+
+			/* loop for all possibilities of [C6 C5] in normal address. */
+			for (col = 0; col < UMC_V8_10_NA_COL_2BITS_POWER_OF_2_NUM; col++) {
+				na_err_addr = na_err_addr_base | (col << UMC_V8_10_NA_C5_BIT);
+
+				/* Mapping normal error address to retired soc physical address. */
+				ret = umc_v8_10_swizzle_mode_na_to_pa(adev, channel_index,
+								na_err_addr, &retired_page_addr);
+				if (ret) {
+					dev_err(adev->dev, "Failed to map pa from umc na.\n");
+					break;
+				}
+				dev_info(adev->dev, "Error Address(PA): 0x%llx\n",
+					retired_page_addr);
+				amdgpu_umc_fill_error_record(err_data, na_err_addr,
+						retired_page_addr, channel_index, umc_inst);
+			}
+		}
+	}
+
+	/* clear umc status */
+	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+}
+
+static void umc_v8_10_query_ras_error_address(struct amdgpu_device *adev,
+					     void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+	uint32_t node_inst       = 0;
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_v8_10_reg_offset(adev,
+						node_inst,
+						umc_inst,
+						ch_inst);
+
+		umc_v8_10_query_error_address(adev,
+					err_data,
+					umc_reg_offset,
+					node_inst,
+					ch_inst,
+					umc_inst);
+	}
+}
+
+static void umc_v8_10_err_cnt_init_per_channel(struct amdgpu_device *adev,
+					      uint32_t umc_reg_offset)
+{
+	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
+	uint32_t ecc_err_cnt_addr;
+
+	ecc_err_cnt_sel_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCntSel);
+	ecc_err_cnt_addr =
+		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt);
+
+	ecc_err_cnt_sel = RREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4);
+
+	/* set ce error interrupt type to APIC based interrupt */
+	ecc_err_cnt_sel = REG_SET_FIELD(ecc_err_cnt_sel, UMCCH0_0_GeccErrCntSel,
+					GeccErrInt, 0x1);
+	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4, ecc_err_cnt_sel);
+	/* set error count to initial value */
+	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4, UMC_V8_10_CE_CNT_INIT);
+}
+
+static void umc_v8_10_err_cnt_init(struct amdgpu_device *adev)
+{
+	uint32_t node_inst       = 0;
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_v8_10_reg_offset(adev,
+						node_inst,
+						umc_inst,
+						ch_inst);
+
+		umc_v8_10_err_cnt_init_per_channel(adev, umc_reg_offset);
+	}
+}
+
+const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops = {
+	.query_ras_error_count = umc_v8_10_query_ras_error_count,
+	.query_ras_error_address = umc_v8_10_query_ras_error_address,
+};
+
+struct amdgpu_umc_ras umc_v8_10_ras = {
+	.ras_block = {
+		.hw_ops = &umc_v8_10_ras_hw_ops,
+	},
+	.err_cnt_init = umc_v8_10_err_cnt_init,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
new file mode 100644
index 000000000000..849ede88e111
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
@@ -0,0 +1,70 @@
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
+#ifndef __UMC_V8_10_H__
+#define __UMC_V8_10_H__
+
+#include "soc15_common.h"
+#include "amdgpu.h"
+
+/* number of umc channel instance with memory map register access */
+#define UMC_V8_10_CHANNEL_INSTANCE_NUM		2
+/* number of umc instance with memory map register access */
+#define UMC_V8_10_UMC_INSTANCE_NUM		2
+
+/* Total channel instances for all umc nodes */
+#define UMC_V8_10_TOTAL_CHANNEL_NUM(adev) \
+	(UMC_V8_10_CHANNEL_INSTANCE_NUM * UMC_V8_10_UMC_INSTANCE_NUM * (adev)->umc.node_inst_num)
+
+/* UMC regiser per channel offset */
+#define UMC_V8_10_PER_CHANNEL_OFFSET	0x400
+
+/* EccErrCnt max value */
+#define UMC_V8_10_CE_CNT_MAX		0xffff
+/* umc ce interrupt threshold */
+#define UUMC_V8_10_CE_INT_THRESHOLD	0xffff
+/* umc ce count initial value */
+#define UMC_V8_10_CE_CNT_INIT	(UMC_V8_10_CE_CNT_MAX - UUMC_V8_10_CE_INT_THRESHOLD)
+
+#define UMC_V8_10_NA_COL_2BITS_POWER_OF_2_NUM	 4
+
+/* The C5 bit in NA  address */
+#define UMC_V8_10_NA_C5_BIT	14
+
+/* Map to swizzle mode address */
+#define SWIZZLE_MODE_TMP_ADDR(na, ch_num, ch_idx) \
+		((((na) >> 10) * (ch_num) + (ch_idx)) << 10)
+#define SWIZZLE_MODE_ADDR_HI(addr, col_bit)  \
+		(((addr) >> ((col_bit) + 2)) << ((col_bit) + 2))
+#define SWIZZLE_MODE_ADDR_MID(na, col_bit) ((((na) >> 8) & 0x3) << (col_bit))
+#define SWIZZLE_MODE_ADDR_LOW(addr, col_bit) \
+		((((addr) >> 10) & ((0x1ULL << (col_bit - 8)) - 1)) << 8)
+#define SWIZZLE_MODE_ADDR_LSB(na) ((na) & 0xFF)
+
+extern struct amdgpu_umc_ras umc_v8_10_ras;
+extern const uint32_t
+	umc_v8_10_channel_idx_tbl[]
+				[UMC_V8_10_UMC_INSTANCE_NUM]
+				[UMC_V8_10_CHANNEL_INSTANCE_NUM];
+
+#endif
+
-- 
2.25.1

