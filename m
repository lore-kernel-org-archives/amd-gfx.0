Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FE7C76196
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 02:01:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6980410E044;
	Mon,  3 Apr 2023 02:01:57 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FEE10E0B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 02:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItJ0KaqDP19kRE+uR4WLjdWcqyb2UDpenI6AuWhPhzKrml151ZiKNZ9mDgyxDaYtpALYHIwRIVKybJ73/yUtLukDarHuag3HxspryE92mK7feIvde1Nt0yhzRBr52FYIr2dDgvXkIvuGMdZiPn9+PCX+5XcOK7eXDlWgIr0N5HWKvuFaZWaqtDdDj4arp+LV+Ly8A8wxe1BQV6faXH3p0m0Ky3C1o/2HNxm7ARwXCOq5D62xtSy3rQgxRBLuXmGoL4+VUrYNIwKNPOnRMLHV7qopBZgiZW8XYQR3syIOT+bAqT+k/uApd0OA7oLbISpnoW6qngAR/wQAby3McHfWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN7cwxop/+SH6ngl5DZXlOjCyM94SvKq8spPHekO4vI=;
 b=XOZpFDaRGVkHObG+/EpZs8uCOB3H/C2mGrKL0O/V3PV6x9od89EoTFB5HdrO9HRskFq2D86JdWk7FUcVnxQhKIjSqZ4jhgH9SLxnSQS6ZPOiiIEeJYuIM1pfnKoKM9MmiMCYhF4JB/mmTn5Zb8JuhFnzZZCjtm54d7G062QUp1VCQjtGcS+4NGcxF0vcAMbojFwCT4Yp8vj6+4pY9+6AXYJgvjN9n5bco7h37w5g9Kd/IlJ38qy128LvsgsUrSOa0+GByDsreTT+L0+VcS9UBFXxx6Brn4BxNcaUJfjp+2xCSDAKL6ZmbNpDzcNvnDZgM72xGElHU5/lQqBFGb+Q7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN7cwxop/+SH6ngl5DZXlOjCyM94SvKq8spPHekO4vI=;
 b=wBp0GYZETdKOLo/0mdSQhJYedloKVB8xVJ3pBh75N8iBvafFGqjhYAv85JJvRJxUk/oT66QraOjLG54avoPVkot1jOva5A8/ifm0W13gwbKpAk/8dCuZSeEVC2644Wc0lRGam16N6Pc4raoSTFHl2e1ooOqYKJrMmMTv7WBoQRg=
Received: from BN9PR03CA0634.namprd03.prod.outlook.com (2603:10b6:408:13b::9)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 02:01:51 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::2e) by BN9PR03CA0634.outlook.office365.com
 (2603:10b6:408:13b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.44 via Frontend
 Transport; Mon, 3 Apr 2023 02:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.18 via Frontend Transport; Mon, 3 Apr 2023 02:01:51 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 2 Apr
 2023 21:01:48 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: optimize redundant code in umc_v8_10
Date: Mon, 3 Apr 2023 09:59:29 +0800
Message-ID: <20230403015930.3426238-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|MN2PR12MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: 5096382a-92d3-4a92-89c1-08db33e76407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXmXj/gKy/nAA1j0cMogH4x+ddR/4S+TCD0mL7zfeoe9wNEJRPUryVlsQ4ssPTH8C2xVrp25KQaM2qXIRuZrDxw57jYjK/pSgZdLW7BeBuBbyzrbK27yaD6/G7I1Jbe6emRlBZ6XHjATHPfG/elyvbKeyL1Ej6FbS5WuSDXDk61Vw0RsrWgsTFjxSQ7GPdMrkpjasHIeFHSZ3+MBWhOuC7Nsg/ByrQ+iGye+CYr9cICBSOgKEG2mduEktpKvA3nbMHVEE5PRYC1hMamDxuE7hhTGMSgDvC5+I5reI+8icSxa2J3I3XFYCCbs5HReTZqglkLiWn9iQJXmoDZ3hIfsfmSb+vE9MtXON48Kei8YYm+jKf3YO8eQjXNVjTW74KQYSLvvhYuQxGIAbIpml+mpj2b6vXUJXtKDoosfUNxaQ5DN4k8sAN+TLsiqdb70JRud6KmaoMBGvbZI7SSkKmf6hWkdDuwE8VH6RUcM8gtJ5hhf8v6iMmuQSo7PU1GW2y4VBGpkLom5oxu91P+4T+YmiYkxqZ1Z5DsEAIveOzldZEWBx0VGO8YHHCiamH7PJ1OyQKKGPFts0qJVTVn5EhjStApZSgGyyyB6aYFZqwYNCM6gsqwY1PHfIIAJOjrO7aru3uctUUHJcr6DTUa1fBCwj1U/2PXwknLgLe2U173HijN+2RZIzhtBeC/O3oQV2aS6op9NWWT1+OFJadmJmrp5h/MI/zH3471xHODpyxY9En0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(16526019)(82310400005)(186003)(6666004)(26005)(1076003)(47076005)(83380400001)(41300700001)(426003)(2616005)(336012)(70206006)(70586007)(54906003)(478600001)(6916009)(316002)(4326008)(8676002)(40460700003)(7696005)(82740400003)(356005)(81166007)(36756003)(86362001)(30864003)(8936002)(5660300002)(2906002)(36860700001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 02:01:51.1266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5096382a-92d3-4a92-89c1-08db33e76407
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Optimize redundant code in umc_v8_10

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c |  31 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   7 +
 drivers/gpu/drm/amd/amdgpu/umc_v8_10.c  | 197 +++++++++---------------
 3 files changed, 115 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 9e2e97207e53..734442315cf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -302,3 +302,34 @@ void amdgpu_umc_fill_error_record(struct ras_err_data *err_data,
 
 	err_data->err_addr_cnt++;
 }
+
+int amdgpu_umc_scan_all_umc_channels(struct amdgpu_device *adev,
+			umc_func func, void *data)
+{
+	uint32_t node_inst       = 0;
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	int ret = 0;
+
+	if (adev->umc.node_inst_num) {
+		LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
+			ret = func(adev, node_inst, umc_inst, ch_inst, data);
+			if (ret) {
+				dev_err(adev->dev, "Node %d umc %d ch %d func returns %d\n",
+					node_inst, umc_inst, ch_inst, ret);
+				return ret;
+			}
+		}
+	} else {
+		LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+			ret = func(adev, 0, umc_inst, ch_inst, data);
+			if (ret) {
+				dev_err(adev->dev, "Umc %d ch %d func returns %d\n",
+					umc_inst, ch_inst, ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index d7f1229ff11f..f279c8057f96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -47,6 +47,10 @@
 #define LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) \
 		LOOP_UMC_NODE_INST((node_inst)) LOOP_UMC_INST_AND_CH((umc_inst), (ch_inst))
 
+
+typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
+			uint32_t umc_inst, uint32_t ch_inst, void *data);
+
 struct amdgpu_umc_ras {
 	struct amdgpu_ras_block_object ras_block;
 	void (*err_cnt_init)(struct amdgpu_device *adev);
@@ -104,4 +108,7 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device *adev,
 		struct amdgpu_iv_entry *entry);
 int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
 			uint64_t err_addr, uint32_t ch_inst, uint32_t umc_inst);
+
+int amdgpu_umc_scan_all_umc_channels(struct amdgpu_device *adev,
+			umc_func func, void *data);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
index fb55e8cb9967..6dff313ac04c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
@@ -76,10 +76,13 @@ static inline uint32_t get_umc_v8_10_reg_offset(struct amdgpu_device *adev,
 		UMC_8_NODE_DIST * node_inst;
 }
 
-static void umc_v8_10_clear_error_count_per_channel(struct amdgpu_device *adev,
-					uint32_t umc_reg_offset)
+static int umc_v8_10_clear_error_count_per_channel(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
 {
 	uint32_t ecc_err_cnt_addr;
+	uint32_t umc_reg_offset =
+		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
 
 	ecc_err_cnt_addr =
 		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCnt);
@@ -87,24 +90,14 @@ static void umc_v8_10_clear_error_count_per_channel(struct amdgpu_device *adev,
 	/* clear error count */
 	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
 			UMC_V8_10_CE_CNT_INIT);
+
+	return 0;
 }
 
 static void umc_v8_10_clear_error_count(struct amdgpu_device *adev)
 {
-	uint32_t node_inst       = 0;
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
-
-	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v8_10_reg_offset(adev,
-						node_inst,
-						umc_inst,
-						ch_inst);
-
-		umc_v8_10_clear_error_count_per_channel(adev,
-						umc_reg_offset);
-	}
+	amdgpu_umc_scan_all_umc_channels(adev,
+		umc_v8_10_clear_error_count_per_channel, NULL);
 }
 
 static void umc_v8_10_query_correctable_error_count(struct amdgpu_device *adev,
@@ -147,29 +140,29 @@ static void umc_v8_10_query_uncorrectable_error_count(struct amdgpu_device *adev
 		*error_count += 1;
 }
 
+static int umc_v8_10_query_ecc_error_count(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
+	uint32_t umc_reg_offset =
+		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
+
+	umc_v8_10_query_correctable_error_count(adev,
+					umc_reg_offset,
+					&(err_data->ce_count));
+	umc_v8_10_query_uncorrectable_error_count(adev,
+					umc_reg_offset,
+					&(err_data->ue_count));
+
+	return 0;
+}
+
 static void umc_v8_10_query_ras_error_count(struct amdgpu_device *adev,
 					   void *ras_error_status)
 {
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-
-	uint32_t node_inst       = 0;
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
-
-	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v8_10_reg_offset(adev,
-						node_inst,
-						umc_inst,
-						ch_inst);
-
-		umc_v8_10_query_correctable_error_count(adev,
-						umc_reg_offset,
-						&(err_data->ce_count));
-		umc_v8_10_query_uncorrectable_error_count(adev,
-						umc_reg_offset,
-						&(err_data->ue_count));
-	}
+	amdgpu_umc_scan_all_umc_channels(adev,
+		umc_v8_10_query_ecc_error_count, ras_error_status);
 
 	umc_v8_10_clear_error_count(adev);
 }
@@ -248,28 +241,28 @@ static void umc_v8_10_convert_error_address(struct amdgpu_device *adev,
 	}
 }
 
-static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
-					 struct ras_err_data *err_data,
-					 uint32_t umc_reg_offset,
-					 uint32_t node_inst,
-					 uint32_t ch_inst,
-					 uint32_t umc_inst)
+static int umc_v8_10_query_error_address(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
 {
 	uint64_t mc_umc_status_addr;
 	uint64_t mc_umc_status, err_addr;
 	uint64_t mc_umc_addrt0;
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
+	uint32_t umc_reg_offset =
+		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
 
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
 	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
 
 	if (mc_umc_status == 0)
-		return;
+		return 0;
 
 	if (!err_data->err_addr) {
 		/* clear umc status */
 		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
-		return;
+		return 0;
 	}
 
 	/* calculate error address if ue error is detected */
@@ -287,37 +280,25 @@ static void umc_v8_10_query_error_address(struct amdgpu_device *adev,
 
 	/* clear umc status */
 	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+
+	return 0;
 }
 
 static void umc_v8_10_query_ras_error_address(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	uint32_t node_inst       = 0;
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
-
-	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v8_10_reg_offset(adev,
-						node_inst,
-						umc_inst,
-						ch_inst);
-
-		umc_v8_10_query_error_address(adev,
-					err_data,
-					umc_reg_offset,
-					node_inst,
-					ch_inst,
-					umc_inst);
-	}
+	amdgpu_umc_scan_all_umc_channels(adev,
+		umc_v8_10_query_error_address, ras_error_status);
 }
 
-static void umc_v8_10_err_cnt_init_per_channel(struct amdgpu_device *adev,
-					      uint32_t umc_reg_offset)
+static int umc_v8_10_err_cnt_init_per_channel(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
 {
 	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
 	uint32_t ecc_err_cnt_addr;
+	uint32_t umc_reg_offset =
+		get_umc_v8_10_reg_offset(adev, node_inst, umc_inst, ch_inst);
 
 	ecc_err_cnt_sel_addr =
 		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_0_GeccErrCntSel);
@@ -332,23 +313,14 @@ static void umc_v8_10_err_cnt_init_per_channel(struct amdgpu_device *adev,
 	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4, ecc_err_cnt_sel);
 	/* set error count to initial value */
 	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4, UMC_V8_10_CE_CNT_INIT);
+
+	return 0;
 }
 
 static void umc_v8_10_err_cnt_init(struct amdgpu_device *adev)
 {
-	uint32_t node_inst       = 0;
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
-
-	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v8_10_reg_offset(adev,
-						node_inst,
-						umc_inst,
-						ch_inst);
-
-		umc_v8_10_err_cnt_init_per_channel(adev, umc_reg_offset);
-	}
+	amdgpu_umc_scan_all_umc_channels(adev,
+		umc_v8_10_err_cnt_init_per_channel, NULL);
 }
 
 static bool umc_v8_10_query_ras_poison_mode(struct amdgpu_device *adev)
@@ -406,37 +378,35 @@ static void umc_v8_10_ecc_info_query_uncorrectable_error_count(struct amdgpu_dev
 	}
 }
 
+static int umc_v8_10_ecc_info_query_ecc_error_count(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
+
+	umc_v8_10_ecc_info_query_correctable_error_count(adev,
+					node_inst, umc_inst, ch_inst,
+					&(err_data->ce_count));
+	umc_v8_10_ecc_info_query_uncorrectable_error_count(adev,
+					node_inst, umc_inst, ch_inst,
+					&(err_data->ue_count));
+	return 0;
+}
+
 static void umc_v8_10_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 					void *ras_error_status)
 {
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-
-	uint32_t node_inst       = 0;
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
-
-	/* TODO: driver needs to toggle DF Cstate to ensure
-	 * safe access of UMC registers. Will add the protection
-	 */
-	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
-		umc_v8_10_ecc_info_query_correctable_error_count(adev,
-							node_inst, umc_inst, ch_inst,
-							&(err_data->ce_count));
-		umc_v8_10_ecc_info_query_uncorrectable_error_count(adev,
-							node_inst, umc_inst, ch_inst,
-							&(err_data->ue_count));
-	}
+	amdgpu_umc_scan_all_umc_channels(adev,
+		umc_v8_10_ecc_info_query_ecc_error_count, ras_error_status);
 }
 
-static void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
-					struct ras_err_data *err_data,
-					uint32_t ch_inst,
-					uint32_t umc_inst,
-					uint32_t node_inst)
+static int umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
 {
 	uint32_t eccinfo_table_idx;
 	uint64_t mc_umc_status, err_addr;
-
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	eccinfo_table_idx = node_inst * adev->umc.umc_inst_num *
@@ -447,10 +417,10 @@ static void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
 	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 
 	if (mc_umc_status == 0)
-		return;
+		return 0;
 
 	if (!err_data->err_addr)
-		return;
+		return 0;
 
 	/* calculate error address if ue error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
@@ -463,28 +433,15 @@ static void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
 		umc_v8_10_convert_error_address(adev, err_data, err_addr,
 					ch_inst, umc_inst, node_inst, mc_umc_status);
 	}
+
+	return 0;
 }
 
 static void umc_v8_10_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
 					void *ras_error_status)
 {
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-
-	uint32_t node_inst       = 0;
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
-
-	/* TODO: driver needs to toggle DF Cstate to ensure
-	 * safe access of UMC resgisters. Will add the protection
-	 * when firmware interface is ready
-	 */
-	LOOP_UMC_EACH_NODE_INST_AND_CH(node_inst, umc_inst, ch_inst) {
-		umc_v8_10_ecc_info_query_error_address(adev,
-						err_data,
-						ch_inst,
-						umc_inst,
-						node_inst);
-	}
+	amdgpu_umc_scan_all_umc_channels(adev,
+		umc_v8_10_ecc_info_query_error_address, ras_error_status);
 }
 
 const struct amdgpu_ras_block_hw_ops umc_v8_10_ras_hw_ops = {
-- 
2.34.1

