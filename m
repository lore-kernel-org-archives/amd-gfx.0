Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFC8C7619A
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Apr 2023 02:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5269310E0B5;
	Mon,  3 Apr 2023 02:01:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A4810E044
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Apr 2023 02:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5gATf0Nlw0IUpLmdHwZuUwJuF9exdYNrqophf2IcgC11KS+6JApLNWKeVOcEp2dPCw+CcBkY0sZ8UsYbHkEyLwsYR2Yug9Gl7XY9pGAvs4OrtBMWPdv68lXKaOHIuYeunOHW95kyfHn7MzNex97VbGoPDFNVZXsdeRN5PzyWZ3QJHFqd10WKXXyxLXfgHgo57Ih9QbiQxFm9dpan7XWiVgmlpEbbD0f62hJI1whdm3cTbbPcwhCGlCXHdaACQH15OZrBOfXMFqc8vYxs5VY8T6QCj2cYA9CiPEFEyAe8RS39n0BTKCkj8JsJQ2WpQX/vF+33VoqYnJh31uRx+Mg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAHWQlH/igSxEbog+/Ow6EX9D/CIQSx65aJbVuhaI1k=;
 b=Sm1urDO3pA+S1tpRG8sBgK+NBnQQw6lInDwnB7Q4yy76jc+DY0EHuN2YGilY07uVmRGOC8LSvDm4jC4UlcolP6Honn13CwxBLi9IsQwHP9CkOmMGKudda9avT8ZqOm2pSBAAoK7XAHQH3kCt3eZUYhqHJ23HBRSnrLe0Azo6HfLj12Wd6EO33bhwSyeQGNumn5Em2A1JqVtjoWSFRG3zDuJu0PfgT1KkO0yzw1btzQQGOK6P8qo2FCZf/Wrrx2KyDnn+LqZH5ZFQ34WbydWBiK0/HJSyMekG3TCZzvrudyOzpcKjXE5sG2/1fBoSgHKvV3H8pNJ8yz6SpF0av+RNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAHWQlH/igSxEbog+/Ow6EX9D/CIQSx65aJbVuhaI1k=;
 b=fF2vuQAKOTv/eKQS03qYF3JqUA3VYsv6okFGerU9rxeceyv9iKk7jcYmYloZrdHgHxn28vPokMVbZjewuiJBCqCTE/7SW7rzOdZeXgvrBgxfzY/SW9PR+aozsx0Yys4GBW4L8R8HKdOhfEO9QNIsmnocbvcI4YqKGRQDzZXAY0Q=
Received: from BN9PR03CA0637.namprd03.prod.outlook.com (2603:10b6:408:13b::12)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 02:01:53 +0000
Received: from BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::b6) by BN9PR03CA0637.outlook.office365.com
 (2603:10b6:408:13b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.44 via Frontend
 Transport; Mon, 3 Apr 2023 02:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT100.mail.protection.outlook.com (10.13.177.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.18 via Frontend Transport; Mon, 3 Apr 2023 02:01:53 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 2 Apr
 2023 21:01:51 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: optimize redundant code in umc_v6_7
Date: Mon, 3 Apr 2023 09:59:30 +0800
Message-ID: <20230403015930.3426238-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403015930.3426238-1-YiPeng.Chai@amd.com>
References: <20230403015930.3426238-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT100:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 62df905f-e036-4759-8812-08db33e76550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSci0+ny5HJnfyfGdpGKVJbQzpeS+ob+aGKlfgKRMCp34x5Qpf9B3n5oiTWCGQBTF/Plk37YrO3n4J8YEYLU0/YQeDH/7I74fxq6iQMyNFrB6TvodyfPE08KzU9yGQ2/mqVc2jg+2WQirjkDpjSCjANxF8On162ldPX7fWh0kzemh+GWCWK4E20WbvKaZNPVzlq/h0CT8cEyQE7XuO6S9xTe/MwoO9qb876TXe3umG+uM+dlDubSsaQr2jkvpylRQDxJq9hwhmb/H8ApLZrnZc5luodZjSvejSob2TtEP2E5uo6GWLxV2KlpTUEazjnKDUbg2UsqZjd3RIUbmupQeRfdb3ya3ejaFqiY4nB6Yw+Sf1VgzggTvqVXFb+rLiLQtCEy4UzsiP3+BteSg3F6yJ9evzBRQbm2XYVDiDFXl0s65F5eD6PE1bwSnybIcWeJMQ30SfBfkRU2wdu3niba3IyrgHkqZu5487pFvlk3IWCMlY++Wq+0jn07s2TfmvgVU04ANI0U0kAVTq3L9/BgguZMlnIvnmiIxKGE6WbzNyKj8DNXkl6xWFkUd6EtEARa4L44E2RIR1p64CAOCVHhm2aysZx3XszQMvLqBCGiRrjatR3GFgGs1JcAiLbq6bLvNqMm7W5I2GkVyVNm6jx334bIXT7h7hVy4hhwb1jwFoHSld/EPBfCmINVIdPo1XiucPjjaueMwD09yQs685PBeCmdsG1eVbdpbmcWijQx85s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(4326008)(6916009)(8676002)(70586007)(70206006)(36860700001)(316002)(478600001)(54906003)(8936002)(5660300002)(356005)(41300700001)(81166007)(82740400003)(16526019)(186003)(47076005)(426003)(83380400001)(2616005)(7696005)(336012)(6666004)(1076003)(26005)(86362001)(36756003)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 02:01:53.2826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62df905f-e036-4759-8812-08db33e76550
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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

Optimize redundant code in umc_v6_7.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 162 +++++++++++---------------
 1 file changed, 71 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index e08e25a3a1a9..f360362ba5dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -160,24 +160,28 @@ static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_dev
 	}
 }
 
+static int umc_v6_7_ecc_info_querry_ecc_error_count(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
+
+	umc_v6_7_ecc_info_query_correctable_error_count(adev,
+		umc_inst, ch_inst,
+		&(err_data->ce_count));
+
+	umc_v6_7_ecc_info_querry_uncorrectable_error_count(adev,
+		umc_inst, ch_inst,
+		&(err_data->ue_count));
+
+	return 0;
+}
+
 static void umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
 					   void *ras_error_status)
 {
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
-
-	/*TODO: driver needs to toggle DF Cstate to ensure
-	 * safe access of UMC registers. Will add the protection */
-	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_v6_7_ecc_info_query_correctable_error_count(adev,
-						      umc_inst, ch_inst,
-						      &(err_data->ce_count));
-		umc_v6_7_ecc_info_querry_uncorrectable_error_count(adev,
-						      umc_inst, ch_inst,
-							  &(err_data->ue_count));
-	}
+	amdgpu_umc_scan_all_umc_channels(adev,
+		umc_v6_7_ecc_info_querry_ecc_error_count, ras_error_status);
 }
 
 void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
@@ -215,23 +219,23 @@ void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
 	}
 }
 
-static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
-					 struct ras_err_data *err_data,
-					 uint32_t ch_inst,
-					 uint32_t umc_inst)
+static int umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
 {
 	uint64_t mc_umc_status, err_addr;
 	uint32_t eccinfo_table_idx;
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
 
 	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
 	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
 
 	if (mc_umc_status == 0)
-		return;
+		return 0;
 
 	if (!err_data->err_addr)
-		return;
+		return 0;
 
 	/* calculate error address if ue error is detected */
 	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
@@ -243,25 +247,15 @@ static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
 		umc_v6_7_convert_error_address(adev, err_data, err_addr,
 					ch_inst, umc_inst);
 	}
+
+	return 0;
 }
 
 static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
-
-	/*TODO: driver needs to toggle DF Cstate to ensure
-	 * safe access of UMC resgisters. Will add the protection
-	 * when firmware interface is ready */
-	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_v6_7_ecc_info_query_error_address(adev,
-					     err_data,
-					     ch_inst,
-					     umc_inst);
-	}
+	amdgpu_umc_scan_all_umc_channels(adev,
+	    umc_v6_7_ecc_info_query_error_address, ras_error_status);
 }
 
 static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
@@ -364,11 +358,14 @@ static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev
 	}
 }
 
-static void umc_v6_7_reset_error_count_per_channel(struct amdgpu_device *adev,
-						   uint32_t umc_reg_offset)
+static int umc_v6_7_reset_error_count_per_channel(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
 {
 	uint32_t ecc_err_cnt_addr;
 	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
+	uint32_t umc_reg_offset =
+		get_umc_v6_7_reg_offset(adev, umc_inst, ch_inst);
 
 	ecc_err_cnt_sel_addr =
 		SOC15_REG_OFFSET(UMC, 0,
@@ -402,58 +399,54 @@ static void umc_v6_7_reset_error_count_per_channel(struct amdgpu_device *adev,
 	/* clear higher chip error count */
 	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
 			UMC_V6_7_CE_CNT_INIT);
+
+	return 0;
 }
 
 static void umc_v6_7_reset_error_count(struct amdgpu_device *adev)
 {
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
+	amdgpu_umc_scan_all_umc_channels(adev,
+		umc_v6_7_reset_error_count_per_channel, NULL);
+}
 
-	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
-							 umc_inst,
-							 ch_inst);
+static int umc_v6_7_query_ecc_error_count(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
+	uint32_t umc_reg_offset =
+		get_umc_v6_7_reg_offset(adev, umc_inst, ch_inst);
 
-		umc_v6_7_reset_error_count_per_channel(adev,
-						       umc_reg_offset);
-	}
+	umc_v6_7_query_correctable_error_count(adev,
+					umc_reg_offset,
+					&(err_data->ce_count),
+					ch_inst, umc_inst);
+
+	umc_v6_7_querry_uncorrectable_error_count(adev,
+					umc_reg_offset,
+					&(err_data->ue_count));
+
+	return 0;
 }
 
 static void umc_v6_7_query_ras_error_count(struct amdgpu_device *adev,
 					   void *ras_error_status)
 {
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
-
-	/*TODO: driver needs to toggle DF Cstate to ensure
-	 * safe access of UMC registers. Will add the protection */
-	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
-							 umc_inst,
-							 ch_inst);
-		umc_v6_7_query_correctable_error_count(adev,
-						       umc_reg_offset,
-						       &(err_data->ce_count),
-						       ch_inst, umc_inst);
-		umc_v6_7_querry_uncorrectable_error_count(adev,
-							  umc_reg_offset,
-							  &(err_data->ue_count));
-	}
+	amdgpu_umc_scan_all_umc_channels(adev,
+		umc_v6_7_query_ecc_error_count, ras_error_status);
 
 	umc_v6_7_reset_error_count(adev);
 }
 
-static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
-					 struct ras_err_data *err_data,
-					 uint32_t umc_reg_offset, uint32_t ch_inst,
-					 uint32_t umc_inst)
+static int umc_v6_7_query_error_address(struct amdgpu_device *adev,
+					uint32_t node_inst, uint32_t umc_inst,
+					uint32_t ch_inst, void *data)
 {
 	uint32_t mc_umc_status_addr;
 	uint64_t mc_umc_status = 0, mc_umc_addrt0, err_addr;
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
+	uint32_t umc_reg_offset =
+		get_umc_v6_7_reg_offset(adev, umc_inst, ch_inst);
 
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
@@ -463,12 +456,12 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
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
@@ -484,29 +477,16 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
 
 	/* clear umc status */
 	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
+
+	return 0;
 }
 
+
 static void umc_v6_7_query_ras_error_address(struct amdgpu_device *adev,
 					     void *ras_error_status)
 {
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-
-	uint32_t umc_inst        = 0;
-	uint32_t ch_inst         = 0;
-	uint32_t umc_reg_offset  = 0;
-
-	/*TODO: driver needs to toggle DF Cstate to ensure
-	 * safe access of UMC resgisters. Will add the protection
-	 * when firmware interface is ready */
-	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset = get_umc_v6_7_reg_offset(adev,
-							 umc_inst,
-							 ch_inst);
-		umc_v6_7_query_error_address(adev,
-					     err_data,
-					     umc_reg_offset, ch_inst,
-					     umc_inst);
-	}
+	amdgpu_umc_scan_all_umc_channels(adev,
+		umc_v6_7_query_error_address, ras_error_status);
 }
 
 static uint32_t umc_v6_7_query_ras_poison_mode_per_channel(
-- 
2.34.1

