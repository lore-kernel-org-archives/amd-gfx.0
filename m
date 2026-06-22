Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FD9CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 04:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA0010E479;
	Mon, 22 Jun 2026 04:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m7MngY8d";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD31D10E479
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 04:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kazGV29ouchf9gex8pA96wIIXHhzY5iIEL86MPWBmqU7olbkoSgQmpPuUVzI4IQEQVB+Nm49DEX2UIllb4hwbfj6MNMjh++/KtTxQM6URt006Zjz9/19oFJeWDh7CYWdcmEAaGsqxIBFS3NaDhvWeNGB9Ani2GpikTFxwtsWln2TCeslRhMteTYe5dCRUxnL44TX3X92Kv8XlVOz9dgBXkTYbmJCZyAEEWncvLAHyPvyPssc2+UgYo2AjYjyoi3pt/Vujbm2cx9nTk/bd1ydZCHPLcKEEr/I4wk1W5WTWUUGqZ30nMLlpk/tBE9dlVa2nAdnxGKXO2Z4tggS3elHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdh4Erh5IbJ+PxPd0H8Z3iwDEqOQHItt9qSdZE09vYw=;
 b=SRUxSBKo/K/Ntt6ytZCDWmpll6KplkrlCljh5oUaqYsNmlpVAAktxFi0XY4QgMDYjdQzYUbm4aYlIZM8wopa0jd651K6jSLpYusuVFVVQv7TVnaVrjx5pL8TXIloEZILey8QQ2+uZJRB1sY2TAVD0Ttll+Qm54x5vPnI2lD0Vdb7h0z7Ya466iDWw0QA23clObrIbW0kube29yaKly6QWOYPM/YVslKkvpUjwkIU/KB3oEfA1CsVwc92Or/FX6wEVtNee8NM8GKOYErKbUzzbhDBe54RKq09gSwYoTjay/Xr5pruFSkLa8zT9yUDvzUQb7kaQQ4rBRPMstutkqAgPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdh4Erh5IbJ+PxPd0H8Z3iwDEqOQHItt9qSdZE09vYw=;
 b=m7MngY8dcTkh1uVEy2h5wajKlqDdfXlqpkMD8NjoRoOJVeVbnP6pfxvw/DxmoxX/4u1KQa7DA71ua1Kavh6Vp5IMs67biKnC+u937cULusbGGCEs9IH1bNDOjZOqVa5Z3jE5xbE0esi4BZYs4V7Ny+I3xzqGDrCCWj6rbr+L+eE=
Received: from BL1PR13CA0397.namprd13.prod.outlook.com (2603:10b6:208:2c2::12)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 04:42:49 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::4a) by BL1PR13CA0397.outlook.office365.com
 (2603:10b6:208:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Mon,
 22 Jun 2026 04:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 04:42:49 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 21 Jun
 2026 23:42:47 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v1 25/48] drm/amdgpu: retire legacy RAS reset/query operations
 for umc v12.0
Date: Mon, 22 Jun 2026 12:40:14 +0800
Message-ID: <38ba143576164f3b0b1b587432c1295cc339e430.1782103074.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1782103073.git.cesun102@amd.com>
References: <cover.1782103073.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: b328a639-7dc2-4669-cc68-08ded018b68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0NGZY97C0OFiACziwjdQjIVRR0SAS8LuRC7HXSYkcyRJ/QHG2FYgN+qVqE9tH/oD1aeLLDt9vR2Aq/mmMOeEzDPVWgp86eYVR0IbaCzjvTeYB5L2OoJOPIgYXQmus0i9RrEyiKT/tr4zs/lBSBfBvLA8pm6B566e/jWQ6PAGjXZ2jVD9vtUfJa/Wvs1fkKQvdN4kkPqqHTXbppkADmJXBsvYqAIalqsmtEauwQ8hWJ4xcMnBkztxFro5pFErfgiN+A3pw6AnP6j3nob7+gHT1f9oWmmEILAWNwx3cP+dMlirgK54ukhI1c1rRKEwpApV7daBIPfhggbaeOKUGJN9zlGsi0Utf8YjiPfSMKEZYYK7caMy9o+LoSL83UeX5qfuKtMCUXk5784zQrTMU5E9M7el3bjEfDHN9LanumN8GfjEqFEppua0YJyu+/kR6vBZf9KsCUo7RwbyZsW7ch9HkNtso2NPWfM6gV+KiwnkDr3IMOdf/t3WHCthMrrA09FjmTlcix1gqAs+SqYsxnly3SW8lCIMw5u8NtAhwdjvZNM82mD5bndYDodXNWH5TeVRrQHzvuGl4oWhnQFpiA2pTPXO4puY49sy6kVKDoWtdwGWjKFJ/I7gpiNCZsuN+MTbXPkp4uMkcYrrOkKa7PpHSff3BXFXdoiT8j8grEOZroBmx/jlk1tgJG7Qj2CY1Gj6tppjbhPpPxnvkMMHellOUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q9uduKZk7idX7iHvy4XE3lJbIOx/mEZ3WRfS0bqtorm2zAvvriNgG3Flxu+fNq3erHrcba/ycVYiPg84qGmk4eRDbkCQ0PnO50F5XYrdjTNYdIt5mQx80aqbicwG53A+JMkVMr6ZXAuO1Ljd13Wipnk0pWsSyPd/XOMe2tnn4iiz4yjvNruRax/iWu2n9mrzr/tGAKthSrdEhhJiclUC5Rip/UhrITBqR4lq2VUAFGaFUqD/IfCcPDHdoM0NWbIYIzMBdOH1Vhot9R0wp6uU3/AN+1Jx0QUw3J+6aOUGKqSu7fjLjyUk+3a9yS/FWZkm5C6X+prpjKCpWh6eXVFWFIKtinwR12rBUHU0/S3YvM+pwpMSXKhC7L1CAlbk/F9ia2e0hRF52H4sC/ox+4NN5Yhl6Rksl8ZkQML+YjSIvd3Lq6NbeLQZ7gLldxz1CWR3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:42:49.3502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b328a639-7dc2-4669-cc68-08ded018b68f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

retire legacy RAS reset/query operations for umc v12.0

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   3 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 214 +------------------------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  25 ---
 3 files changed, 3 insertions(+), 239 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 5166055c6692..1fcc0594fd0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -57,6 +57,7 @@
 #include "umc_v6_0.h"
 #include "umc_v6_7.h"
 #include "umc_v12_0.h"
+#include "ras_umc_v12_0.h"
 #include "hdp_v4_0.h"
 #include "mca_v3_0.h"
 
@@ -1382,7 +1383,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 5, 0):
 		adev->umc.max_ras_err_cnt_per_query =
-			UMC_V12_0_TOTAL_CHANNEL_NUM(adev) * UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
+			UMC_V12_0_TOTAL_CHANNEL_NUM * UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
 		adev->umc.channel_inst_num = UMC_V12_0_CHANNEL_INSTANCE_NUM;
 		adev->umc.umc_inst_num = UMC_V12_0_UMC_INSTANCE_NUM;
 		adev->umc.node_inst_num /= UMC_V12_0_UMC_INSTANCE_NUM;
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 328dd2e8d328..b74275800795 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -31,45 +31,6 @@
 #define MAX_ECC_NUM_PER_RETIREMENT  32
 #define DELAYED_TIME_FOR_GPU_RESET  1000  //ms
 
-static inline uint64_t get_umc_v12_0_reg_offset(struct amdgpu_device *adev,
-					    uint32_t node_inst,
-					    uint32_t umc_inst,
-					    uint32_t ch_inst)
-{
-	uint32_t index = umc_inst * adev->umc.channel_inst_num + ch_inst;
-	uint64_t cross_node_offset = (node_inst == 0) ? 0 : UMC_V12_0_CROSS_NODE_OFFSET;
-
-	umc_inst = index / 4;
-	ch_inst = index % 4;
-
-	return adev->umc.channel_offs * ch_inst + UMC_V12_0_INST_DIST * umc_inst +
-		UMC_V12_0_NODE_DIST * node_inst + cross_node_offset;
-}
-
-static int umc_v12_0_reset_error_count_per_channel(struct amdgpu_device *adev,
-					uint32_t node_inst, uint32_t umc_inst,
-					uint32_t ch_inst, void *data)
-{
-	uint64_t odecc_err_cnt_addr;
-	uint64_t umc_reg_offset =
-		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
-
-	odecc_err_cnt_addr =
-		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_OdEccErrCnt);
-
-	/* clear error count */
-	WREG32_PCIE_EXT((odecc_err_cnt_addr + umc_reg_offset) * 4,
-			UMC_V12_0_CE_CNT_INIT);
-
-	return 0;
-}
-
-static void umc_v12_0_reset_error_count(struct amdgpu_device *adev)
-{
-	amdgpu_umc_loop_channels(adev,
-		umc_v12_0_reset_error_count_per_channel, NULL);
-}
-
 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_umc_status)
 {
 	dev_dbg(adev->dev,
@@ -115,65 +76,6 @@ bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_
 		!(umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)))));
 }
 
-static void umc_v12_0_query_error_count_per_type(struct amdgpu_device *adev,
-						   uint64_t umc_reg_offset,
-						   unsigned long *error_count,
-						   check_error_type_func error_type_func)
-{
-	uint64_t mc_umc_status;
-	uint64_t mc_umc_status_addr;
-
-	mc_umc_status_addr =
-		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
-
-	/* Check MCUMC_STATUS */
-	mc_umc_status =
-		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
-
-	if (error_type_func(adev, mc_umc_status))
-		*error_count += 1;
-}
-
-static int umc_v12_0_query_error_count(struct amdgpu_device *adev,
-					uint32_t node_inst, uint32_t umc_inst,
-					uint32_t ch_inst, void *data)
-{
-	struct ras_err_data *err_data = (struct ras_err_data *)data;
-	unsigned long ue_count = 0, ce_count = 0, de_count = 0;
-
-	/* NOTE: node_inst is converted by adev->umc.active_mask and the range is [0-3],
-	 * which can be used as die ID directly */
-	struct amdgpu_smuio_mcm_config_info mcm_info = {
-		.socket_id = adev->smuio.funcs->get_socket_id(adev),
-		.die_id = node_inst,
-	};
-
-	uint64_t umc_reg_offset =
-		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
-
-	umc_v12_0_query_error_count_per_type(adev, umc_reg_offset,
-					    &ce_count, umc_v12_0_is_correctable_error);
-	umc_v12_0_query_error_count_per_type(adev, umc_reg_offset,
-					    &ue_count, umc_v12_0_is_uncorrectable_error);
-	umc_v12_0_query_error_count_per_type(adev, umc_reg_offset,
-					    &de_count, umc_v12_0_is_deferred_error);
-
-	amdgpu_ras_error_statistic_ue_count(err_data, &mcm_info, ue_count);
-	amdgpu_ras_error_statistic_ce_count(err_data, &mcm_info, ce_count);
-	amdgpu_ras_error_statistic_de_count(err_data, &mcm_info, de_count);
-
-	return 0;
-}
-
-static void umc_v12_0_query_ras_error_count(struct amdgpu_device *adev,
-					   void *ras_error_status)
-{
-	amdgpu_umc_loop_channels(adev,
-		umc_v12_0_query_error_count, ras_error_status);
-
-	umc_v12_0_reset_error_count(adev);
-}
-
 static void umc_v12_0_get_retire_flip_bits(struct amdgpu_device *adev)
 {
 	enum amdgpu_memory_partition nps = AMDGPU_NPS1_PARTITION_MODE;
@@ -371,98 +273,6 @@ static int umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	return ret;
 }
 
-static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
-					uint32_t node_inst, uint32_t umc_inst,
-					uint32_t ch_inst, void *data)
-{
-	struct ras_err_data *err_data = (struct ras_err_data *)data;
-	struct ta_ras_query_address_input addr_in;
-	uint64_t mc_umc_status_addr;
-	uint64_t mc_umc_status, err_addr;
-	uint64_t mc_umc_addrt0;
-	uint64_t umc_reg_offset =
-		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
-
-	mc_umc_status_addr =
-		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
-
-	mc_umc_status = RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
-
-	if (mc_umc_status == 0)
-		return 0;
-
-	if (!err_data->err_addr) {
-		/* clear umc status */
-		WREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
-
-		return 0;
-	}
-
-	/* calculate error address if ue error is detected */
-	if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status) ||
-	    umc_v12_0_is_deferred_error(adev, mc_umc_status)) {
-		mc_umc_addrt0 =
-			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDRT0);
-
-		err_addr = RREG64_PCIE_EXT((mc_umc_addrt0 + umc_reg_offset) * 4);
-
-		err_addr = REG_GET_FIELD(err_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
-
-		if (!adev->aid_mask &&
-		    adev->smuio.funcs &&
-		    adev->smuio.funcs->get_socket_id)
-			addr_in.ma.socket_id = adev->smuio.funcs->get_socket_id(adev);
-		else
-			addr_in.ma.socket_id = 0;
-
-		addr_in.ma.err_addr = err_addr;
-		addr_in.ma.ch_inst = ch_inst;
-		addr_in.ma.umc_inst = umc_inst;
-		addr_in.ma.node_inst = node_inst;
-
-		umc_v12_0_convert_error_address(adev, err_data, &addr_in, NULL, true);
-	}
-
-	/* clear umc status */
-	WREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
-
-	return 0;
-}
-
-static void umc_v12_0_query_ras_error_address(struct amdgpu_device *adev,
-					     void *ras_error_status)
-{
-	amdgpu_umc_loop_channels(adev,
-		umc_v12_0_query_error_address, ras_error_status);
-}
-
-static int umc_v12_0_err_cnt_init_per_channel(struct amdgpu_device *adev,
-					uint32_t node_inst, uint32_t umc_inst,
-					uint32_t ch_inst, void *data)
-{
-	uint32_t odecc_cnt_sel;
-	uint64_t odecc_cnt_sel_addr, odecc_err_cnt_addr;
-	uint64_t umc_reg_offset =
-		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
-
-	odecc_cnt_sel_addr =
-		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_OdEccCntSel);
-	odecc_err_cnt_addr =
-		SOC15_REG_OFFSET(UMC, 0, regUMCCH0_OdEccErrCnt);
-
-	odecc_cnt_sel = RREG32_PCIE_EXT((odecc_cnt_sel_addr + umc_reg_offset) * 4);
-
-	/* set ce error interrupt type to APIC based interrupt */
-	odecc_cnt_sel = REG_SET_FIELD(odecc_cnt_sel, UMCCH0_OdEccCntSel,
-					OdEccErrInt, 0x1);
-	WREG32_PCIE_EXT((odecc_cnt_sel_addr + umc_reg_offset) * 4, odecc_cnt_sel);
-
-	/* set error count to initial value */
-	WREG32_PCIE_EXT((odecc_err_cnt_addr + umc_reg_offset) * 4, UMC_V12_0_CE_CNT_INIT);
-
-	return 0;
-}
-
 static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
 			enum amdgpu_mca_error_type type, void *ras_error_status)
 {
@@ -482,26 +292,6 @@ static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
 	return false;
 }
 
-static void umc_v12_0_err_cnt_init(struct amdgpu_device *adev)
-{
-	amdgpu_umc_loop_channels(adev,
-		umc_v12_0_err_cnt_init_per_channel, NULL);
-}
-
-static bool umc_v12_0_query_ras_poison_mode(struct amdgpu_device *adev)
-{
-	/*
-	 * Force return true, because regUMCCH0_EccCtrl
-	 * is not accessible from host side
-	 */
-	return true;
-}
-
-const struct amdgpu_ras_block_hw_ops umc_v12_0_ras_hw_ops = {
-	.query_ras_error_count = umc_v12_0_query_ras_error_count,
-	.query_ras_error_address = umc_v12_0_query_ras_error_address,
-};
-
 static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 			uint64_t status, uint64_t ipid, uint64_t addr)
 {
@@ -690,10 +480,8 @@ static void umc_v12_0_mca_ipid_parse(struct amdgpu_device *adev, uint64_t ipid,
 
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
-		.hw_ops = &umc_v12_0_ras_hw_ops,
+		.hw_ops = NULL,
 	},
-	.err_cnt_init = umc_v12_0_err_cnt_init,
-	.query_ras_poison_mode = umc_v12_0_query_ras_poison_mode,
 	.ecc_info_query_ras_error_address = umc_v12_0_query_ras_ecc_err_addr,
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 	.update_ecc_status = umc_v12_0_update_ecc_status,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 63b7e7254526..d470775be308 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -26,31 +26,6 @@
 #include "soc15_common.h"
 #include "amdgpu.h"
 
-#define UMC_V12_0_NODE_DIST		0x40000000
-#define UMC_V12_0_INST_DIST		0x40000
-
-/* UMC register per channel offset */
-#define UMC_V12_0_PER_CHANNEL_OFFSET	0x400
-
-/* UMC cross node offset */
-#define UMC_V12_0_CROSS_NODE_OFFSET		0x100000000
-
-/* OdEccErrCnt max value */
-#define UMC_V12_0_CE_CNT_MAX		0xffff
-/* umc ce interrupt threshold */
-#define UMC_V12_0_CE_INT_THRESHOLD	0xffff
-/* umc ce count initial value */
-#define UMC_V12_0_CE_CNT_INIT	(UMC_V12_0_CE_CNT_MAX - UMC_V12_0_CE_INT_THRESHOLD)
-
-/* number of umc channel instance with memory map register access */
-#define UMC_V12_0_CHANNEL_INSTANCE_NUM		8
-/* number of umc instance with memory map register access */
-#define UMC_V12_0_UMC_INSTANCE_NUM		4
-
-/* Total channel instances for all available umc nodes */
-#define UMC_V12_0_TOTAL_CHANNEL_NUM(adev) \
-	(UMC_V12_0_CHANNEL_INSTANCE_NUM * (adev)->gmc.num_umc)
-
 /* one piece of normalized address is mapped to 8 pieces of physical address */
 #define UMC_V12_0_NA_MAP_PA_NUM        8
 /* R13 bit shift should be considered, double the number */
-- 
2.34.1

