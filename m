Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07D9C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 03:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6239310E417;
	Mon, 10 Oct 2022 03:12:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFAE10E417
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 03:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ltt2SB9IA11QBxyA+mX/2bWbPpEDOFGttPVY8qAI+gD/k2Ih3sW7nSWYASsc2DVH20+h1NO7lxjqNHwf0blJv9cQgRGw7HM9zqqQyRnmOQgEwr5DDX2GZWXskhRC4YGvM5betqnMopzqad+1mkXT4XI4OT0dZAbwRbWWfFzN5u/lh83XoH8QjwxH6j2zfEUiEK+a7uEsd4Q/Ge8Fgs4yeQcspVYWsNaiUAhJiQV9x/uf+IvKn6ITcnK7tCh8OFbghizhPfbzjD6CUFW2ICNl3Fgr82H6H7rd6dfQmUjbEk8eniM8c0kdx6FN26v7MkPQUpjLpxxfO2rz7J6rsc5rzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh/+dYREB0sqOVUJML6176YyTQvMmWko79HVpkePHe4=;
 b=hx0hpaZyQiNNGkLY/7qvv13WecaS1NNValbzebhLxUn7IzQ3D52mZPoJbXWzgI1g8pugRAipYrXbGpS7JHmKrTWrzAXs36iL+zc4fHGnO0XW0KuMc7Anlfk/X6+SRcuYw87wTU8nhuhB6UGj6ezM2vjXY3bien1N55AE4GCeYVWCWdmTpprJY2P9MviK7FffRIr7W176xPIOokoozDbSfed3yoLjoE+1ddGrdNSwwVEzUY893VFJR5tXYa4MCDge6i2YYBsWkudyPUqHFQg6UiV5E6Agj0NaQIav2Kqnqk7j0ekcVKJhNJTM7PphOqO0aoJpfdM+DU76pZuw6bpbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh/+dYREB0sqOVUJML6176YyTQvMmWko79HVpkePHe4=;
 b=S4stmzNetp2YGMEhLH9ZleHUOFoTdY3nwfx7hyoWp8J7Q+w8QwNMDrEWMI1jz3+KySHTm7CuFXUEN6v+ILW9/5rnt7NHV9SfQzVWYKfkZXEGaYtrInGUKxncxigJX8Ow1/7mpzHkDCJvp6u4IySkWqgcclF7C91y+Ba5bfDg/2o=
Received: from MW4PR04CA0088.namprd04.prod.outlook.com (2603:10b6:303:6b::33)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 10 Oct
 2022 03:12:37 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::41) by MW4PR04CA0088.outlook.office365.com
 (2603:10b6:303:6b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Mon, 10 Oct 2022 03:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 03:12:37 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 9 Oct
 2022 22:12:34 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: remove check for CE in RAS error address query
Date: Mon, 10 Oct 2022 11:12:10 +0800
Message-ID: <20221010031213.19258-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e176417-a926-4da6-711a-08daaa6d48b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwH+J+F28o/DTVgew7hl8SymNk/tEylYvzYUksBytpCv5PD82iTquM2ZqwdtRi1AiMg38tZzh86UrzObNAIAaQ2mDWM85uUoazl3V4JIc9N0U6GVaQiqw1FNh+Ole23aQ4nqxyjf7wHvS/PCVAtcmzCKjmKLrO3LN/c+fkpDRixpeDTuXY3aIEH2C//SGDVKEum73os72klXoGiK6u5zKW0YYG55M3+vgI2FrIb/AvzWCf5PE5zYYh8BfPHgRKifVjXoTQAWacEuodYQ7St2yFyXlj4DG0FUJMULYHrBwA0KNtaeXYbZkhDHWO6EBbR49DHdctPdmrdkPUtD1n1/8YJlx3Y4ntKaba7L+nYbX5HO4oapTT2azioIdQm2XkJ0+g0dRaedqJSiAluEKvekBzy64ZXETVrhRf1cOxRgVaLKO8x6W6Jx8IcY5EpntrpJd0cTCiAsWWTur5ULEcxYyJxCEFg1F3+y8xRMwpMpmKvpw9n0v4RyWINI+5nF+2vaSRfTQpn8zp7/caM03NGocpNxeuCYrfI5aoFotbo0awueBO9GvYhD4Hc7/Vszl3vnG1jt7Z4DVIazxjqeyHRB/z0PCnbLeM9X3wH0RUvDYXjLzmXijX4VNTX3jDeffj4Kx0tDf/W69BEf+lpxk9GYIjp3WaJqDRZYed9GfbLb5VVSw2yVzirLLtoV8npRnuRoKzrrveOBFhMRTFT4LLrY7fUcNMNPI6JCquYpxnhd1+4OU3Qg70VD+MebEoXkFl42ALhydD+A0APvY1/YukKwHxfnFG1P+ppeev4ykUlaVdU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(8676002)(478600001)(110136005)(6636002)(316002)(16526019)(70586007)(4326008)(70206006)(82740400003)(2616005)(30864003)(6666004)(26005)(36756003)(5660300002)(86362001)(2906002)(356005)(36860700001)(8936002)(40480700001)(83380400001)(47076005)(1076003)(426003)(7696005)(41300700001)(40460700003)(81166007)(336012)(82310400005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 03:12:37.2504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e176417-a926-4da6-711a-08daaa6d48b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011
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

Only RAS UE error address is queried currently, no need to check CE status.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c  | 10 ++--
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c  | 67 +++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 52 +++++++++-----------
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c  | 20 +++-----
 4 files changed, 59 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 939cb203f7ad..f17d297b594b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -327,10 +327,9 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
 		return;
 	}
 
-	/* calculate error address if ue/ce error is detected */
+	/* calculate error address if ue error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) {
 
 		err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
 		/* the lowest lsb bits should be ignored */
@@ -343,10 +342,7 @@ static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
 				ADDR_OF_256B_BLOCK(channel_index) |
 				OFFSET_IN_256B_BLOCK(err_addr);
 
-		/* we only save ue error information currently, ce is skipped */
-		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1)
-			amdgpu_umc_fill_error_record(err_data, err_addr,
+		amdgpu_umc_fill_error_record(err_data, err_addr,
 					retired_page, channel_index, umc_inst);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index a0d19b768346..64d760eb92a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -209,10 +209,9 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 	if (!err_data->err_addr)
 		return;
 
-	/* calculate error address if ue/ce error is detected */
+	/* calculate error address if ue error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) {
 
 		err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
@@ -228,22 +227,18 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 		/* clear [C4 C3 C2] in soc physical address */
 		soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
 
-		/* we only save ue error information currently, ce is skipped */
-		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1) {
-			/* loop for all possibilities of [C4 C3 C2] */
-			for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
-				retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
-				dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
-				amdgpu_umc_fill_error_record(err_data, err_addr,
-					retired_page, channel_index, umc_inst);
-
-				/* shift R14 bit */
-				retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
-				dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
-				amdgpu_umc_fill_error_record(err_data, err_addr,
-					retired_page, channel_index, umc_inst);
-			}
+		/* loop for all possibilities of [C4 C3 C2] */
+		for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
+			retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
+			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+			amdgpu_umc_fill_error_record(err_data, err_addr,
+				retired_page, channel_index, umc_inst);
+
+			/* shift R14 bit */
+			retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
+			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+			amdgpu_umc_fill_error_record(err_data, err_addr,
+				retired_page, channel_index, umc_inst);
 		}
 	}
 }
@@ -481,10 +476,9 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 	channel_index =
 		adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
 
-	/* calculate error address if ue/ce error is detected */
+	/* calculate error address if ue error is detected */
 	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) ||
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) ||
 	    mca_addr != UMC_INVALID_ADDR) {
 		if (mca_addr == UMC_INVALID_ADDR) {
 			err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
@@ -505,23 +499,18 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 		/* clear [C4 C3 C2] in soc physical address */
 		soc_pa &= ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
 
-		/* we only save ue error information currently, ce is skipped */
-		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1 ||
-		    mca_addr != UMC_INVALID_ADDR) {
-			/* loop for all possibilities of [C4 C3 C2] */
-			for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
-				retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
-				dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
-				amdgpu_umc_fill_error_record(err_data, err_addr,
-					retired_page, channel_index, umc_inst);
-
-				/* shift R14 bit */
-				retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
-				dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
-				amdgpu_umc_fill_error_record(err_data, err_addr,
-					retired_page, channel_index, umc_inst);
-			}
+		/* loop for all possibilities of [C4 C3 C2] */
+		for (column = 0; column < UMC_V6_7_NA_MAP_PA_NUM; column++) {
+			retired_page = soc_pa | (column << UMC_V6_7_PA_C2_BIT);
+			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+			amdgpu_umc_fill_error_record(err_data, err_addr,
+				retired_page, channel_index, umc_inst);
+
+			/* shift R14 bit */
+			retired_page ^= (0x1ULL << UMC_V6_7_PA_R14_BIT);
+			dev_info(adev->dev, "Error Address(PA): 0x%llx\n", retired_page);
+			amdgpu_umc_fill_error_record(err_data, err_addr,
+				retired_page, channel_index, umc_inst);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index a8cbda81828d..38f9e29990cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -208,7 +208,10 @@ static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
 {
 	uint64_t mc_umc_status_addr;
 	uint64_t mc_umc_status, err_addr;
-	uint32_t channel_index;
+	uint64_t mc_umc_addrt0, na_err_addr_base;
+	uint64_t na_err_addr, retired_page_addr;
+	uint32_t channel_index, addr_lsb, col = 0;
+	int ret = 0;
 
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
@@ -229,13 +232,10 @@ static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
 					umc_inst * adev->umc.channel_inst_num +
 					ch_inst];
 
-	/* calculate error address if ue/ce error is detected */
+	/* calculate error address if ue error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
 	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrV) == 1 &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
-	     REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
-		uint32_t addr_lsb;
-		uint64_t mc_umc_addrt0;
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) {
 
 		mc_umc_addrt0 = SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
 		err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
@@ -243,32 +243,24 @@ static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
 
 		/* the lowest lsb bits should be ignored */
 		addr_lsb = REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrLsb);
-
 		err_addr &= ~((0x1ULL << addr_lsb) - 1);
-
-		/* we only save ue error information currently, ce is skipped */
-		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) {
-			uint64_t na_err_addr_base = err_addr & ~(0x3ULL << UMC_V8_10_NA_C5_BIT);
-			uint64_t na_err_addr, retired_page_addr;
-			uint32_t col = 0;
-			int ret = 0;
-
-			/* loop for all possibilities of [C6 C5] in normal address. */
-			for (col = 0; col < UMC_V8_10_NA_COL_2BITS_POWER_OF_2_NUM; col++) {
-				na_err_addr = na_err_addr_base | (col << UMC_V8_10_NA_C5_BIT);
-
-				/* Mapping normal error address to retired soc physical address. */
-				ret = umc_v8_10_swizzle_mode_na_to_pa(adev, channel_index,
-								na_err_addr, &retired_page_addr);
-				if (ret) {
-					dev_err(adev->dev, "Failed to map pa from umc na.\n");
-					break;
-				}
-				dev_info(adev->dev, "Error Address(PA): 0x%llx\n",
-					retired_page_addr);
-				amdgpu_umc_fill_error_record(err_data, na_err_addr,
-						retired_page_addr, channel_index, umc_inst);
+		na_err_addr_base = err_addr & ~(0x3ULL << UMC_V8_10_NA_C5_BIT);
+
+		/* loop for all possibilities of [C6 C5] in normal address. */
+		for (col = 0; col < UMC_V8_10_NA_COL_2BITS_POWER_OF_2_NUM; col++) {
+			na_err_addr = na_err_addr_base | (col << UMC_V8_10_NA_C5_BIT);
+
+			/* Mapping normal error address to retired soc physical address. */
+			ret = umc_v8_10_swizzle_mode_na_to_pa(adev, channel_index,
+							na_err_addr, &retired_page_addr);
+			if (ret) {
+				dev_err(adev->dev, "Failed to map pa from umc na.\n");
+				break;
 			}
+			dev_info(adev->dev, "Error Address(PA): 0x%llx\n",
+				retired_page_addr);
+			amdgpu_umc_fill_error_record(err_data, na_err_addr,
+					retired_page_addr, channel_index, umc_inst);
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
index f35253e0eaa6..e2623685cb44 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
@@ -130,10 +130,9 @@ static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 	if (!err_data->err_addr)
 		return;
 
-	/* calculate error address if ue/ce error is detected */
+	/* calculate error address if ue error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) {
 
 		err_addr = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
 		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
@@ -143,10 +142,7 @@ static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 				ADDR_OF_256B_BLOCK(channel_index) |
 				OFFSET_IN_256B_BLOCK(err_addr);
 
-		/* we only save ue error information currently, ce is skipped */
-		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1)
-			amdgpu_umc_fill_error_record(err_data, err_addr,
+		amdgpu_umc_fill_error_record(err_data, err_addr,
 					retired_page, channel_index, umc_inst);
 	}
 }
@@ -343,10 +339,9 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 		return;
 	}
 
-	/* calculate error address if ue/ce error is detected */
+	/* calculate error address if ue error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)) {
+	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1) {
 
 		err_addr = RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
 		/* the lowest lsb bits should be ignored */
@@ -359,10 +354,7 @@ static void umc_v8_7_query_error_address(struct amdgpu_device *adev,
 				ADDR_OF_256B_BLOCK(channel_index) |
 				OFFSET_IN_256B_BLOCK(err_addr);
 
-		/* we only save ue error information currently, ce is skipped */
-		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
-				== 1)
-			amdgpu_umc_fill_error_record(err_data, err_addr,
+		amdgpu_umc_fill_error_record(err_data, err_addr,
 					retired_page, channel_index, umc_inst);
 	}
 
-- 
2.35.1

