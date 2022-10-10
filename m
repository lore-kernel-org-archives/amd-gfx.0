Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E87C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 03:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C8A10E449;
	Mon, 10 Oct 2022 03:12:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98E410E417
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 03:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXZSo4uZzTvJpzB40G8OX7kxdx6VzPemnjRZkbPhCnFBOW8osglMVcWOb/RCNrWtyQwDxZHDbeFOygLGyWqWyfowGSxll4ZXI683ZElcdqORDmoHcwLhX2W+yD+pV38dgG2WskoMkPbkdLSaaSwh4DbhXoEwPCF3hCswV3wMzOTQJXlasjUHpDiSMmv7wjuJiY9I/+Si5G55XTGuDDP3yYJ4ZMpixxs6NITSUHhfjmTCWugyc/deKKIT49+/HdOoSeAZ7ibJeETf0ql+FB736Zz75CVOd2VwpvTy9dY4esVEFla6jtGvAy0a1EOl4tf62hokqjDptlE7lKPTfk+RtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnqIrbY9dXsjn1zt+4jAkQI9gIgTdMY6JF9bt2jLxxY=;
 b=K8a34GpsRNnJbzCNoxAGcPIBlTJGA/asXwSPJFC3R5HfwZxjJyRxydEDVJtIw4Fd81E9p6pPYZW49MYEG50xy6LCenzsd6AY+V5pHw82njUPmKjbig4j8U+ntxt49Odz/9CkjSR+tF0skFtFQL7HrkgnIQpcUeNPAx8L1x3JNWLM4ons9o4/sW98GkEt1+wcES79dbbFb8GthG3c5nO4b+gxgm/YZU+MRn8QdrOXB9SIcrMHkdn7/uacZOy/e62q+Mad1KZRzNUV5EtszOeJ4CKQ2SJY4fkVskjabdJeCXIY98b/pTzrPO5BYqruoTplV5yQF60fTRildIPcx/ptrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnqIrbY9dXsjn1zt+4jAkQI9gIgTdMY6JF9bt2jLxxY=;
 b=LhAuedK1sPWRCIUJIc+8RS/dbQq3lL6gZUj6XbzOAAxcIRiRz9YQNJSrARZHx6VWAtI3i+dudAJ3KZpgvJs0VmlfsliKYmSs91syoT04QWT2PLE9nOFHh58N0AwOHhubG9WbkKeN678/mxnxB6jsvtzFO0p5dlTPCbuj5RbKdr0=
Received: from MW4P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::32)
 by CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Mon, 10 Oct
 2022 03:12:40 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::dd) by MW4P223CA0027.outlook.office365.com
 (2603:10b6:303:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 03:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 03:12:39 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 9 Oct
 2022 22:12:36 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: define RAS convert_error_address API
Date: Mon, 10 Oct 2022 11:12:11 +0800
Message-ID: <20221010031213.19258-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221010031213.19258-1-tao.zhou1@amd.com>
References: <20221010031213.19258-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|CH0PR12MB5346:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9482d2-39c9-4317-7727-08daaa6d4a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JYgxHScNpRkj83OIFv8+aj484CX09Mrgv9LQIebGSIQZt+rxi/7a6CZN+Wwt3R+5q7S9L9LFN9Xb75zbn+j8lqHIqgyZnACFHHFXkf/3argysn1Oo55un+LOL1TKVyHiVo9pVaMkrJxKPgW0I1eT20WJf8iTCbyCv8ntZs63OfvKfiwZ2penfjbH+o4k9jRLFyVAC4X7ab08Q51D2HkZXUpfG7C43bnwE/9JOSfLHCkbM5c6Kl2Dqs+KmaX0LmDp9IqAVBZGzJbakjb5Wri4X08dhJ3EiEZBWUMHRUHbmlZ4Wb6JcNCATKT7aATf+aUr6h391IiwJ4FrnfmLGmJxFPpcKhZBLKoyTqQ+wHkpNqwC2crhhXJMtZSdgio+FzZTOdhF+CDYCaF6+k0EWWYYAjSWNs/roWQYB8JiFf8AR0F2kvlAWsguhq99LSu1Dg3cULq9y0DpRj1hvWT79u5K8S7fvQKs2zT/ttAPCkSzLmikkeJI1Fyzw94ucWB48Df9R14D11kdOQkhGvzueVx93nVP/KtHxOSOYJ5Ltt9uwEHqUcLABrLOs11JaprO9mo+6KD8YLvo8DRdmxjWjI4fdY3OH9nMeCOfJQtg9rbmyK49Adh6tokIjIUH2eSDzI9zNs6/n/rJDQVNRrogaKCJvcuvXAPRkzdtNGsFIaiNiaySt8K5V79b7hjsPk0y9ZXAlvIt1fp19UG6gPnAHcAbJl6NPKzgBDBAx7AYyGI/mTNXG7pLJIigvhQVVRKTYgLVcJj7K3lyo/GKk7nlB6k2W6F4xCfrnGyIABA/8phxaieBdbG2Ydv/M+kcoSod42X
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(478600001)(6636002)(83380400001)(186003)(110136005)(2616005)(356005)(8676002)(6666004)(41300700001)(4326008)(8936002)(70586007)(70206006)(26005)(7696005)(5660300002)(36756003)(1076003)(40480700001)(86362001)(336012)(2906002)(16526019)(81166007)(36860700001)(40460700003)(47076005)(82740400003)(82310400005)(426003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 03:12:39.9859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9482d2-39c9-4317-7727-08daaa6d4a52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5346
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the code reusable and remove redundant code.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   7 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c   | 148 ++++++++++--------------
 3 files changed, 64 insertions(+), 93 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ccebd8e2a2d8..c2f9970e851c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2889,7 +2889,7 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	if (adev->umc.ras &&
 	    adev->umc.ras->convert_ras_error_address)
 		adev->umc.ras->convert_ras_error_address(adev,
-			&err_data, 0, ch_inst, umc_inst, m->addr);
+			&err_data, m->addr, ch_inst, umc_inst);
 
 	if (amdgpu_bad_page_threshold != 0) {
 		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 2fb4951a6433..e46439274f3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -22,8 +22,6 @@
 #define __AMDGPU_UMC_H__
 #include "amdgpu_ras.h"
 
-#define UMC_INVALID_ADDR 0x1ULL
-
 /*
  * (addr / 256) * 4096, the higher 26 bits in ErrorAddr
  * is the index of 4KB block
@@ -54,9 +52,8 @@ struct amdgpu_umc_ras {
 	void (*err_cnt_init)(struct amdgpu_device *adev);
 	bool (*query_ras_poison_mode)(struct amdgpu_device *adev);
 	void (*convert_ras_error_address)(struct amdgpu_device *adev,
-						 struct ras_err_data *err_data,
-						 uint32_t umc_reg_offset, uint32_t ch_inst,
-						 uint32_t umc_inst, uint64_t mca_addr);
+				struct ras_err_data *err_data, uint64_t err_addr,
+				uint32_t ch_inst, uint32_t umc_inst);
 	void (*ecc_info_query_ras_error_count)(struct amdgpu_device *adev,
 				      void *ras_error_status);
 	void (*ecc_info_query_ras_error_address)(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index 64d760eb92a3..5d5d031c9e7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -187,20 +187,51 @@ static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 	}
 }
 
+static void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
+					struct ras_err_data *err_data, uint64_t err_addr,
+					uint32_t ch_inst, uint32_t umc_inst)
+{
+	uint32_t channel_index;
+	uint64_t soc_pa, retired_page, column;
+
+	channel_index =
+		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
+	/* translate umc channel address to soc pa, 3 parts are included */
+	soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
+			ADDR_OF_256B_BLOCK(channel_index) |
+			OFFSET_IN_256B_BLOCK(err_addr);
+
+	/* The umc channel bits are not original values, they are hashed */
+	SET_CHANNEL_HASH(channel_index, soc_pa);
+
+	/* clear [C4 C3 C2] in soc physical address */
+	soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
+
+	/* loop for all possibilities of [C4 C3 C2] */
+	for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
+		retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
+		dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+		amdgpu_umc_fill_error_record(err_data, err_addr,
+			retired_page, channel_index, umc_inst);
+
+		/* shift R14 bit */
+		retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
+		dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+		amdgpu_umc_fill_error_record(err_data, err_addr,
+			retired_page, channel_index, umc_inst);
+	}
+}
+
 static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 					 struct ras_err_data *err_data,
 					 uint32_t ch_inst,
 					 uint32_t umc_inst)
 {
-	uint64_t mc_umc_status, err_addr, soc_pa, retired_page, column;
-	uint32_t channel_index;
+	uint64_t mc_umc_status, err_addr;
 	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
-	channel_index =
-		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
-
 	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 
 	if (mc_umc_status == 0)
@@ -216,30 +247,8 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 		err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 
-		/* translate umc channel address to soc pa, 3 parts are included */
-		soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
-				ADDR_OF_256B_BLOCK(channel_index) |
-				OFFSET_IN_256B_BLOCK(err_addr);
-
-		/* The umc channel bits are not original values, they are hashed */
-		SET_CHANNEL_HASH(channel_index, soc_pa);
-
-		/* clear [C4 C3 C2] in soc physical address */
-		soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
-
-		/* loop for all possibilities of [C4 C3 C2] */
-		for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
-			retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
-			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
-			amdgpu_umc_fill_error_record(err_data, err_addr,
-				retired_page, channel_index, umc_inst);
-
-			/* shift R14 bit */
-			retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
-			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
-			amdgpu_umc_fill_error_record(err_data, err_addr,
-				retired_page, channel_index, umc_inst);
-		}
+		umc_v6_7_convert_error_address(adev, err_data, err_addr,
+					ch_inst, umc_inst);
 	}
 }
 
@@ -448,75 +457,40 @@ static void umc_v6_7_query_ras_error_count(struct amdgpu_device *adev,
 static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 					 struct ras_err_data *err_data,
 					 uint32_t umc_reg_offset, uint32_t ch_inst,
-					 uint32_t umc_inst, uint64_t mca_addr)
+					 uint32_t umc_inst)
 {
 	uint32_t mc_umc_status_addr;
-	uint32_t channel_index;
-	uint64_t mc_umc_status = 0, mc_umc_addrt0;
-	uint64_t err_addr, soc_pa, retired_page, column;
+	uint64_t mc_umc_status = 0, mc_umc_addrt0, err_addr;
 
-	if (mca_addr == UMC_INVALID_ADDR) {
-		mc_umc_status_addr =
-			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
-		mc_umc_addrt0 =
-			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
+	mc_umc_status_addr =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
+	mc_umc_addrt0 =
+		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
 
-		mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
+	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
 
-		if (mc_umc_status == 0)
-			return;
+	if (mc_umc_status == 0)
+		return;
 
-		if (!err_data->err_addr) {
-			/* clear umc status */
-			WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
-			return;
-		}
+	if (!err_data->err_addr) {
+		/* clear umc status */
+		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+		return;
 	}
 
-	channel_index =
-		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
-
 	/* calculate error address if ue error is detected */
-	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) ||
-	    mca_addr != UMC_INVALID_ADDR) {
-		if (mca_addr == UMC_INVALID_ADDR) {
-			err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
-			err_addr =
-				REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
-		} else {
-			err_addr = mca_addr;
-		}
+	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) {
+		err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
+		err_addr =
+			REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 
-		/* translate umc channel address to soc pa, 3 parts are included */
-		soc_pa = ADDR_OF_8KB_BLOCK(err_addr) |
-				ADDR_OF_256B_BLOCK(channel_index) |
-				OFFSET_IN_256B_BLOCK(err_addr);
-
-		/* The umc channel bits are not original values, they are hashed */
-		SET_CHANNEL_HASH(channel_index, soc_pa);
-
-		/* clear [C4 C3 C2] in soc physical address */
-		soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
-
-		/* loop for all possibilities of [C4 C3 C2] */
-		for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
-			retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
-			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
-			amdgpu_umc_fill_error_record(err_data, err_addr,
-				retired_page, channel_index, umc_inst);
-
-			/* shift R14 bit */
-			retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
-			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
-			amdgpu_umc_fill_error_record(err_data, err_addr,
-				retired_page, channel_index, umc_inst);
-		}
+		umc_v6_7_convert_error_address(adev, err_data, err_addr,
+					ch_inst, umc_inst);
 	}
 
 	/* clear umc status */
-	if (mca_addr == UMC_INVALID_ADDR)
-		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
 }
 
 static void umc_v6_7_query_ras_error_address(struct amdgpu_device *adev,
@@ -538,7 +512,7 @@ static void umc_v6_7_query_ras_error_address(struct amdgpu_device *adev,
 		umc_v6_7_query_error_address(adev,
 					     err_data,
 					     umc_reg_offset, ch_inst,
-					     umc_inst, UMC_INVALID_ADDR);
+					     umc_inst);
 	}
 }
 
@@ -579,5 +553,5 @@ struct amdgpu_umc_ras umc_v6_7_ras = {
 	.query_ras_poison_mode = umc_v6_7_query_ras_poison_mode,
 	.ecc_info_query_ras_error_count = umc_v6_7_ecc_info_query_ras_error_count,
 	.ecc_info_query_ras_error_address = umc_v6_7_ecc_info_query_ras_error_address,
-	.convert_ras_error_address = umc_v6_7_query_error_address,
+	.convert_ras_error_address = umc_v6_7_convert_error_address,
 };
-- 
2.35.1

