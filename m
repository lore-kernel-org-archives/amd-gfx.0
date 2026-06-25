Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B470CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1AD10F180;
	Thu, 25 Jun 2026 08:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KHyXfzeh";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4273E10F180
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJiwouMGMBGK5pCvtvT7nWopWtpvEcgBRatJvUql7/Bz9O2i0lTGYaHhSNFB8Sck/kU5I0kzX/1DigaePpSWVsx3JAmzqH9zoZagxO5lHxil4+/0JpwG4xncX3RHzEUHFinSANdIU2Jv4qGw6Tw2Rv+WqgpS3wYcM2Ee2krQ1Ds4rJQ5m/FlVcGwcq06PBPjvqf3gjmPjOikGGU9+J69NEapxw9hiDCpPwrGIsWPDbuZuMnVFvZedMPBigJj04A/Z/rzVkFFMCVuLmRm4lDnggVP755++dDcQWpRfShPTBx0tAWNA7FVNtdo0y/cHobfQIXpMht/a/hulPZXGz8KJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdh4Erh5IbJ+PxPd0H8Z3iwDEqOQHItt9qSdZE09vYw=;
 b=VRAXkyYzkkzo4gwzpwx/UlLY7GSxjobAylWn7/xZhzrLqykolqI1B3ItExvyMveVb6HQ6rAKyu/6M563OJnVMwIBwrgv0Fb8JECRE0+kjI5I7AGNXGSB4/Iduf2+WEWAGWllu/GuyrJCnrZ/EEdTREVNtQxRpAgca6bBi9AcaJZQGxIZG5v6utsKAZeeHLSUuM/lyU7Et06wJ+6c1VAml7ZXlviD5H+FI/eqvcn4Kd3ZKnYx+TkYqC0Ku6tBJiX633ILGIbQs5393Rk0hK5Bjici15Itxdo2Sxe0k4eG5JZtgJJDk1mr3AA1ua0Y3FuNSCB6XckcsJh0UDA7htRV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdh4Erh5IbJ+PxPd0H8Z3iwDEqOQHItt9qSdZE09vYw=;
 b=KHyXfzehsc4/MY7422qNWABAzYBpPkAZv3BaMYhj4DPOnN3fV453Mokc3RL4DSE/nZE4IPgAPGpwHedRBU5XXGiNMrFWuHVorQK+XkaPVDI+L58iPHkYlIlXyQ9TBDUXNzpA1f4Cj23KBSkCnOgyPx3Xi+yJN4FtlS6P+zBT91g=
Received: from CYZPR14CA0023.namprd14.prod.outlook.com (2603:10b6:930:8f::20)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 08:20:56 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::34) by CYZPR14CA0023.outlook.office365.com
 (2603:10b6:930:8f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:20:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:20:56 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:20:53 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 23/44] drm/amdgpu: retire legacy RAS reset/query operations
 for umc v12.0
Date: Thu, 25 Jun 2026 16:19:16 +0800
Message-ID: <fdf05f4e9fa6b2ee91f126fc49222f830601f94a.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b00730-6349-4aed-3a65-08ded292ae29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XvKw2wuxK3N6nX3k2Ejf9NNUlANJuIzzy48CkgLOkeh9tIrpU4H+S1XvYNRS+Ww0SVGaRgnn45msppXrvkzRxHkzIE/4QTh587rqMqqVsF9Gevr0xUAJdPVtL++g03byuYHsMHpYX17KTXVD5rszmXnjOSSRVsCIgOtGY/3/xNjNjMCC1FjGDXAfLFHk4lfUDRJaP16qZCJlivze9BnG6u8DK3/CVw1iPmN+mDhEsy6Mhiz0VxZvSVjVKmw9HWjtl2F8/hu88VzJkQKWaeUPqrNDE61lVfysx8g3Q92ICS++4VT944rTplnDfEvD/V4qpC2qnSrARINX8RvyCaNlCD83Xle+uDhl8kVHZ0TbdvfO/RA9IZwpwyW9LoAM6FYwDIiFnOU6SyjYrIyx47u/1PH1Y4cQVCnwiaVczJx1pAyjBo8Tz+dqNsqoFpz3m0UYT2cYqA3h753QhCOfR6nDpMD1Wmp91jdnLL7eULs1toUeMeilUtweyjW94M7gYRDTHXsODNpcN4Vimtvdu1ya9GNwOPGJo9KTntRUAVfI6x0JQN9tq372TuO/9fXBdJQC3SZvuvyqMRLhBaRVupwV1TRIxitL6PRq5rVAQ2s8+teGT8dq27EhQQgDPYeLnahV6RYzB2/vvrHVzHfZveXa2o0BgLMJ57fZskUNl7xwuw7TAgrvP6O7aU6uXwZaApk9i4gedr1LJ1fn3a7ftT9KCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vOWXTsfV+5A/k2ChGXf4zx41wiWgso5QvwApHcVNFWlGVOU+I5G+EftNhbma27yNlCyz6R2/BQTNv460nLaRFCEklEnxE2VtV13eop8oZZE7Q/aunCuEa7GC/kM5OOIOriBta3rvNGV+AYdFtL1vkq+2PTKW2j84gQ8b2y0ShCy5sVJSjNBnsS4CXrd/sXILAmClbJDWbKomhWZhQY1DZQZ+FmRWfSwu9pU1FnDKdJpno/RXRcH6a5CYAeeFq5+HT0LTmDa3Kwca3H9q9i6VMmw6rAYlrVoHQkBxXnBfPgnJVgfu8YodA9p3dVk9NEUkAufVXz0HTo1HrlamuQxfq6YkEInbCBC0+4R7HdkLhuj0cdjv8az0g/FCj9cRFbkL8A+9SX2XYLWq3QIzsKcpRkStfLpoEvbLdupjR5crdA2U3xyD5niJlj5IsV4EbZBj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:20:56.1305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b00730-6349-4aed-3a65-08ded292ae29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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

