Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EEBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jul 2022 16:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF30810EFC8;
	Mon,  4 Jul 2022 16:15:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4046310E00A
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jul 2022 06:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb52w0yH9qPNUI/hlxeBIa2o/ljDh81F/cmh00OgFr5X04wCdBaPAiZU648Ff48ngYAE5QGyq9K8DmPGUeHJbcc9L/ECFTawHxhkOqdHjdg9RJ6P1wKn9Qlr57KwYprV2eiTQg/liEPl5ok7HGpgaTwnIEz8ZOI7AxN1RxHwfxLEbGslX4SSIj52P71eTOfD1eODHSrU88IzMGfbp2zohsORHLAI4nFZcklyEw9jfWqPh103ISvxLcFIixEM+Jmbybzkwi4SNGVy6AM3AjMrA3O7lhE3QiwOECm62ciNqHxlbN+o7VyJ4LWybMZWVUYn1j/19HWZZo3QRHcfS9CGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkZEYwgmQqNWh8t/AXKAgFqjggV973RWwSIfN6sKuuM=;
 b=gsqF8TUyDBJS9O01u+EDtYIKmym4KCiXa7N4634Vj8Dntn0BeVKg1M/itESlYV9SSxVwT/7qir6wm1WH4iLYULgIP5Bh7yiYirQFYxhxadMTxM62bQqwskhAr301PK1gYPtqtR/jxKVgBd/c+Jx8jSLPqDGaAlEPOg+OuLoU0XEI3cy3c66h2A32ESCJIa9kUhi/ZoaHsrcIhWa9fxxtS0fu274ZPkvD4jX5TlgTWdWActrHAEfJkbeTwewl9yEXWJhT3dtJ4NcBA6U6dvd27sK8WgV8srtxE5hFwUoYu1nAU118jO5HeqMk12WUgctbCrBE9o1ttLtW3uzRrQdFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkZEYwgmQqNWh8t/AXKAgFqjggV973RWwSIfN6sKuuM=;
 b=IegBS6DyNzhgh5LOKOIaYzABlx//58uMA+SQvpYAGrpIgp05r4hjJgeXenv++UIdj8TmGo/nLdiVG8t6gkDrdrJV6jykXkudtqLmZWfGJf6E3btKUKCCAkv3JbibWSuhCfdOh8ZmQrL9Sh2HIqCvZ39EgiXO1H+uOxZqcIVUqgg=
Received: from DM6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:5:14c::29)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Mon, 4 Jul
 2022 06:06:06 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::df) by DM6PR11CA0052.outlook.office365.com
 (2603:10b6:5:14c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Mon, 4 Jul 2022 06:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 06:06:06 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 01:05:41 -0500
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add umc ras functions for navi31
Date: Mon, 4 Jul 2022 14:04:25 +0800
Message-ID: <20220704060425.3249965-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1286390-5a39-4f68-d0c0-08da5d83487e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rW0cFAhTSJjha2xtpOQ2hFOaDu4wikE7PjplV06a0+wv1F5I4+o4KX3A24U4+dE5cjzPmqsVg49mfbLHlJX2VLog4V2BPTgIFuj8bsKavQJcb2kBO/Aq12pFNV5cKunEM1I4JlRepYiqca4LMz/Pm0HB636KLgowiek4hNBrlcdXTGlPmd3S87x0Ntz8pemCpSFN16yVKr9obMtYpXjVsMyUTxnamj4qjx3AGhyVBBkH70MyISAdsgPuQCyn9UVSv5TvFGLi+135VGUWNjhrMEw+WNTGK6huShGLByPs5H7bjTtEX3VBzpI/HHEs8z0b6aZkRYsN0pS2ICvmw/+qKm9aGyj0mHs6t1xw62EYf3FIWLYG3oFavzkDSRup7A6iDhnjL2EvcIBNwiz7hTWvUkGSUVm0BUfCZWHlhjb0Bue0fAXvtAN1d+ONMPryz5tuHOJ42UPqeDlkqh2KlvDZEEm4eWiWZiUkTQPScZB3BMHEcbOZm9iH09rseokw/86iF00XwrdTTENyAHihPEDYL5NY6Rwzc6I6PlR8zDcoaasRidLNsTI/DIlEeInlVvONXYa0G8fxNp5FEpXbdsw/bed/V8NualAT8WyofEcVVwOaERwI2g8C/w9HRr1eJLHxvuKdLiqjYxp0C6pZLsggp8CNie1hWsgimyE5JNtsXN71sWFdMSBWwYdJ0IS9vhFNRxAalYaNaCYraU9qNnEvBL9Q7hs1W7T/ikB08F8TNlwRPmCy+Q0fz+p2pr02XjXULYnz6mFPs1QT5HRHKmd6myNu9MgRqVDkLO3Iv+Y9WAJH5f8ns+IOwN9PgEYHRbpwxhEAa9tL60LtbWOsK0zkB7CDK65vEtHG0UTt47TEGDpErETUO1H54KtKWFW9gQ4NnGE1P20WU/DbpsiIPT4Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(40470700004)(36840700001)(6916009)(54906003)(70206006)(70586007)(8676002)(19627235002)(316002)(6666004)(2906002)(41300700001)(36756003)(426003)(26005)(47076005)(336012)(7696005)(2616005)(4326008)(16526019)(186003)(1076003)(83380400001)(30864003)(81166007)(86362001)(356005)(82740400003)(40480700001)(34020700004)(40460700003)(5660300002)(8936002)(82310400005)(478600001)(36860700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 06:06:06.3622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1286390-5a39-4f68-d0c0-08da5d83487e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add umc ras functions for navi31:
1. Add driver and asic register for umc new ip.
2. Support query umc ras error counter.
3. Support ras umc ue error address remapping.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |   7 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  27 +-
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c        | 362 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.h        |  62 +++
 .../include/asic_reg/umc/umc_8_10_0_offset.h  |  33 ++
 .../include/asic_reg/umc/umc_8_10_0_sh_mask.h |  94 +++++
 7 files changed, 585 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h

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
index 2ec6698aa1fe..8cc4618bd7fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -41,6 +41,9 @@
 #define LOOP_UMC_CH_INST(ch_inst) for ((ch_inst) = 0; (ch_inst) < adev->umc.channel_inst_num; (ch_inst)++)
 #define LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) LOOP_UMC_INST((umc_inst)) LOOP_UMC_CH_INST((ch_inst))
 
+#define LOOP_UMC_MCD_INST(mcd_inst) \
+		for ((mcd_inst) = 0; (mcd_inst) < adev->umc.mcd_inst_num; (mcd_inst)++)
+
 struct amdgpu_umc_ras {
 	struct amdgpu_ras_block_object ras_block;
 	void (*err_cnt_init)(struct amdgpu_device *adev);
@@ -62,6 +65,10 @@ struct amdgpu_umc {
 	uint32_t channel_inst_num;
 	/* number of umc instance with memory map register access */
 	uint32_t umc_inst_num;
+
+	/*number of mcd instance with memory map register access*/
+	uint32_t mcd_inst_num;
+
 	/* UMC regiser per channel offset */
 	uint32_t channel_offs;
 	/* channel index table of interleaved memory */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index e098b69d6321..c2a745bce068 100644
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
@@ -586,11 +586,36 @@ static void gmc_v11_0_set_umc_funcs(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[UMC_HWIP][0]) {
 	case IP_VERSION(8, 10, 0):
+		adev->umc.max_ras_err_cnt_per_query = UMC_V8_10_TOTAL_CHANNEL_NUM;
+		adev->umc.channel_inst_num = UMC_V8_10_CHANNEL_INSTANCE_NUM;
+		adev->umc.mcd_inst_num = UMC_V8_10_MCD_INSTANCE_NUM;
+		adev->umc.umc_inst_num = UMC_V8_10_UMC_INSTANCE_NUM;
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
+		/* If not defined special ras_cb function, use default ras_cb */
+		if (!adev->umc.ras->ras_block.ras_cb)
+			adev->umc.ras->ras_block.ras_cb = amdgpu_umc_process_ras_data_cb;
+	}
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
new file mode 100644
index 000000000000..d412545a775e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -0,0 +1,362 @@
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
+#define UMC_8_MCD_DIST    0x800000
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
+	umc_v8_10_channel_idx_tbl[UMC_V8_10_MCD_INSTANCE_NUM]
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
+					    uint32_t mcd_inst,
+					    uint32_t umc_inst,
+					    uint32_t ch_inst)
+{
+	return adev->umc.channel_offs*ch_inst + UMC_8_INST_DIST*umc_inst + UMC_8_MCD_DIST*mcd_inst;
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
+	uint32_t mcd_inst        = 0;
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	LOOP_UMC_MCD_INST(mcd_inst)
+		LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+			umc_reg_offset = get_umc_v8_10_reg_offset(adev,
+							mcd_inst,
+							umc_inst,
+							ch_inst);
+
+			umc_v8_10_clear_error_count_per_channel(adev,
+							umc_reg_offset);
+		}
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
+static void umc_v8_10_querry_uncorrectable_error_count(struct amdgpu_device *adev,
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
+	uint32_t mcd_inst        = 0;
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	LOOP_UMC_MCD_INST(mcd_inst)
+		LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+			umc_reg_offset = get_umc_v8_10_reg_offset(adev,
+							mcd_inst,
+							umc_inst,
+							ch_inst);
+
+			umc_v8_10_query_correctable_error_count(adev,
+							umc_reg_offset,
+							&(err_data->ce_count));
+			umc_v8_10_querry_uncorrectable_error_count(adev,
+								umc_reg_offset,
+								&(err_data->ue_count));
+		}
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
+	return 0;
+}
+
+/*
+ * Mapping normal address to soc physical address in swizzle mode.
+ */
+static int umc_v8_10_swizzle_mode_na_to_pa(struct amdgpu_device *adev,
+					uint32_t channel_idx,
+					uint64_t na, uint64_t *soc_pa)
+{
+	uint32_t channel_num = UMC_V8_10_TOTAL_CHANNEL_NUM;
+	uint32_t col_bit = umc_v8_10_get_col_bit(channel_num);
+	uint64_t na_addr, tmp_addr, tmp_addr_hi, tmp_addr_mid, tmp_addr_low, pa_addr;
+	uint64_t low_bits_width;
+
+	if (!col_bit)
+		return -1;
+
+	na_addr = na;
+	low_bits_width = (0x1 << (col_bit - 8)) - 1;
+	tmp_addr = ((na_addr >> 10) * channel_num  +  channel_idx) << 10;
+	tmp_addr_hi = (tmp_addr >> (col_bit + 2)) << (col_bit + 2);
+	tmp_addr_mid = ((na_addr >> 8) & 0x3) << col_bit;
+	tmp_addr_low = ((tmp_addr >> 10) & low_bits_width) << 8;
+	pa_addr = tmp_addr_hi | tmp_addr_mid | tmp_addr_low | (na_addr & 0xFF);
+	*soc_pa = pa_addr;
+	return 0;
+}
+
+static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
+					 struct ras_err_data *err_data,
+					 uint32_t umc_reg_offset,
+					 uint32_t mcd_inst,
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
+		adev->umc.channel_idx_tbl[mcd_inst * adev->umc.umc_inst_num *
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
+
+		/* the lowest lsb bits should be ignored */
+		addr_lsb = REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrLsb);
+
+		err_addr &= ~((0x1ULL << addr_lsb) - 1);
+
+		/* we only save ue error information currently, ce is skipped */
+		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) {
+			uint64_t na_err_addr_base = err_addr & ~(0x3 << UMC_V8_10_NA_C5_BIT);
+			uint64_t na_err_addr, retired_page_addr;
+			uint32_t col = 0;
+			int ret = 0;
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
+	uint32_t mcd_inst        = 0;
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	LOOP_UMC_MCD_INST(mcd_inst)
+		LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+			umc_reg_offset = get_umc_v8_10_reg_offset(adev,
+							mcd_inst,
+							umc_inst,
+							ch_inst);
+
+			umc_v8_10_query_error_address(adev,
+						err_data,
+						umc_reg_offset,
+						mcd_inst,
+						ch_inst,
+						umc_inst);
+		}
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
+	uint32_t mcd_inst        = 0;
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+
+	LOOP_UMC_MCD_INST(mcd_inst)
+		LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+			umc_reg_offset = get_umc_v8_10_reg_offset(adev,
+							mcd_inst,
+							umc_inst,
+							ch_inst);
+
+			umc_v8_10_err_cnt_init_per_channel(adev, umc_reg_offset);
+		}
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
index 000000000000..6bb8de51687d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.h
@@ -0,0 +1,62 @@
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
+/* number of mcd instance with memory map register access */
+#define UMC_V8_10_MCD_INSTANCE_NUM		6
+
+/* total channel instances in one umc block */
+#define UMC_V8_10_TOTAL_CHANNEL_NUM \
+	(UMC_V8_10_CHANNEL_INSTANCE_NUM * UMC_V8_10_UMC_INSTANCE_NUM * UMC_V8_10_MCD_INSTANCE_NUM)
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
+extern struct amdgpu_umc_ras umc_v8_10_ras;
+extern const uint32_t
+	umc_v8_10_channel_idx_tbl[UMC_V8_10_MCD_INSTANCE_NUM]
+				[UMC_V8_10_UMC_INSTANCE_NUM]
+				[UMC_V8_10_CHANNEL_INSTANCE_NUM];
+
+#endif
+
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h
new file mode 100644
index 000000000000..b798cf5a2c39
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_offset.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2022  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _umc_8_10_0_OFFSET_HEADER
+#define _umc_8_10_0_OFFSET_HEADER
+
+#define regUMCCH0_0_GeccErrCntSel                0x0328
+#define regUMCCH0_0_GeccErrCntSel_BASE_IDX       2
+#define regUMCCH0_0_GeccErrCnt                   0x0329
+#define regUMCCH0_0_GeccErrCnt_BASE_IDX          2
+#define regMCA_UMC_UMC0_MCUMC_STATUST0           0x03c2
+#define regMCA_UMC_UMC0_MCUMC_STATUST0_BASE_IDX  2
+#define regMCA_UMC_UMC0_MCUMC_ADDRT0             0x03c4
+#define regMCA_UMC_UMC0_MCUMC_ADDRT0_BASE_IDX    2
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h
new file mode 100644
index 000000000000..bd99b431247f
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_8_10_0_sh_mask.h
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2022  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _umc_8_10_0_SH_MASK_HEADER
+#define _umc_8_10_0_SH_MASK_HEADER
+
+//UMCCH0_0_GeccErrCntSel
+#define UMCCH0_0_GeccErrCntSel__GeccErrInt__SHIFT    0xc
+#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn__SHIFT  0xf
+#define UMCCH0_0_GeccErrCntSel__PoisonCntEn__SHIFT   0x10
+#define UMCCH0_0_GeccErrCntSel__GeccErrInt_MASK      0x00003000L
+#define UMCCH0_0_GeccErrCntSel__GeccErrCntEn_MASK    0x00008000L
+#define UMCCH0_0_GeccErrCntSel__PoisonCntEn_MASK     0x00030000L
+//UMCCH0_0_GeccErrCnt
+#define UMCCH0_0_GeccErrCnt__GeccErrCnt__SHIFT       0x0
+#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt__SHIFT 0x10
+#define UMCCH0_0_GeccErrCnt__GeccErrCnt_MASK         0x0000FFFFL
+#define UMCCH0_0_GeccErrCnt__GeccUnCorrErrCnt_MASK   0xFFFF0000L
+//MCA_UMC_UMC0_MCUMC_STATUST0
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode__SHIFT      0x0
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt__SHIFT   0x10
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22__SHIFT       0x16
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb__SHIFT        0x18
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30__SHIFT       0x1e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId__SHIFT      0x20
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38__SHIFT       0x26
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub__SHIFT          0x28
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41__SHIFT       0x29
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison__SHIFT         0x2b
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred__SHIFT       0x2c
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC__SHIFT           0x2d
+#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC__SHIFT           0x2e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47__SHIFT       0x2f
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent__SHIFT    0x34
+#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV__SHIFT          0x35
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54__SHIFT       0x36
+#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC__SHIFT            0x37
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal__SHIFT   0x38
+#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC__SHIFT            0x39
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV__SHIFT          0x3a
+#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV__SHIFT          0x3b
+#define MCA_UMC_UMC0_MCUMC_STATUST0__En__SHIFT             0x3c
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UC__SHIFT             0x3d
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow__SHIFT       0x3e
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Val__SHIFT            0x3f
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCode_MASK        0x000000000000FFFFL
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrorCodeExt_MASK     0x00000000003F0000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV22_MASK         0x0000000000C00000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrLsb_MASK          0x000000003F000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV30_MASK         0x00000000C0000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreId_MASK        0x0000003F00000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV38_MASK         0x000000C000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Scrub_MASK            0x0000010000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV41_MASK         0x0000060000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Poison_MASK           0x0000080000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Deferred_MASK         0x0000100000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UECC_MASK             0x0000200000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__CECC_MASK             0x0000400000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV47_MASK         0x000F800000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Transparent_MASK      0x0010000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__SyndV_MASK            0x0020000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__RESERV54_MASK         0x0040000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__TCC_MASK              0x0080000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__ErrCoreIdVal_MASK     0x0100000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__PCC_MASK              0x0200000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__AddrV_MASK            0x0400000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__MiscV_MASK            0x0800000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__En_MASK               0x1000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__UC_MASK               0x2000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Overflow_MASK         0x4000000000000000L
+#define MCA_UMC_UMC0_MCUMC_STATUST0__Val_MASK              0x8000000000000000L
+//MCA_UMC_UMC0_MCUMC_ADDRT0
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr__SHIFT        0x0
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__Reserved__SHIFT         0x38
+#define MCA_UMC_UMC0_MCUMC_ADDRT0__ErrorAddr_MASK          0x00FFFFFFFFFFFFFFL
+
+#endif
-- 
2.25.1

