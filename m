Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C82C54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 03:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62CC610E2D9;
	Thu, 21 Mar 2024 03:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="agwRyUBe";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A892010E2D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 03:30:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnYWFMHdxTLENpCseyMkXvhDktH03PWvEShFwKInc450Uqh+2XgH9U4Q8Ylsy4p6OBxKobjJKH3wZqCTC79+MeXNvfVeHoYJrAm3e+59wdZgRhc0yT3NMkFkBdC5c2auL+BOPdc62/N4oy+leueeg2Ol9OH43FDs+AvtSKOeRhtaNPwaK8CkGpoLRjclyabGCxgXf+dx0qKX5yJnPK3ma8Cm7y+pKohTeGmxj8iTP2SolA1fIPNTjeu+TCbrjGz7kAxXbRX3NbPUSw2Zz2x/mcf6TDPGg3PIDMmKEMlz+F+1BrSsbTEt6gRBl7vvVM/AiuMfE7k4k/2FFrsVX7T00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnqXz27Vru/2JfmcDoLTpwdErEEg8fA9QsLOhrU71qc=;
 b=MK/5kJpxhhGfMDby9g1AaITp/9Sr+/BZNNCIwZehnAhCWzMk/NeEjBifAbW1QqzzzClksjsW0Qs1NCpbmHlbGVswHLuiGXjpONI2OrswKxLUb9CTO55gFHRTNOHWQtv4549xURMrVe9OC5eWieBc55YW4AKTiNbKApmpL4NozW/KNAFsEIUbXW2C7IcyyNHXx058KxpPAv7VWJJVC/BWAHMiHJCrlf07OTebIIrY+Pxr6k2HMB6cp61qQOvk/judoT+IKNrxX22SV7pG756osBHur6kMj3InL3f8RvHL+9bVrcQnSkzLBu59p+KIwE0LnEMvuiIX4oSTPjxRiHryKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnqXz27Vru/2JfmcDoLTpwdErEEg8fA9QsLOhrU71qc=;
 b=agwRyUBeuBY9tOUuMgAooTerL/vM3TMgVD6vzCLh6fpPob7mQLHj0by0Xm7J07uvrT9vyvgBFtlOWYfyQ1KvlmSqPXc2ZG0FULPod9oyXdiBCROmcc+Gq6euJy7e28KniWmBdt1RbyWep3gYQcOcDxV3ieBHLQzydldbGmUnxv0=
Received: from BN9PR03CA0260.namprd03.prod.outlook.com (2603:10b6:408:ff::25)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Thu, 21 Mar
 2024 03:30:33 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::f8) by BN9PR03CA0260.outlook.office365.com
 (2603:10b6:408:ff::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Thu, 21 Mar 2024 03:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7430.0 via Frontend Transport; Thu, 21 Mar 2024 03:30:33 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 22:30:30 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: simplify convert_error_address interface for
 UMC v12
Date: Thu, 21 Mar 2024 11:30:07 +0800
Message-ID: <20240321033007.358505-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321033007.358505-1-tao.zhou1@amd.com>
References: <20240321033007.358505-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b17e46-30c2-484e-a85a-08dc49574470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lh/DTGf8v9WhGkx9iky8TfuD1AviGPJ6FtLnCDiSPNKNEY34/t7ulA7hanFe63UzWMfTZxsaFmMgzeEq48aN4g44l7ppN89iv1OeHDZM2Qi2MqYFudflmPnOrM4CstPIiwVwFYRkcC8/Qv2d63e1Nd7AiMXylcoieslkOQqbeXMLcPyt64LwGr8N73mrh7RGlrKfVqewG+6k+Bp/PFxk/UzkLjyI7Yl4klxkVe6xXDQlr6hmMzJ8K+byWznxcbDh4J3CQockrqNfQY6FGhppxWzo0MVBjoKQO7MAfa3mlHYBHVpq6KztquKD4XG6cExWYMTtajwmUP8/nVVjJCC51bH/QP119XKQ93mcJZxnQQzBZ4Y8DDmTWLGydZYookjepY5QIalZkaBEnqg831TCkY0iqS8kWF5jlIdTQTlvIPn/IZpFXFbuH+zqZZBt4deD/GbqgVqDXs+AxsimoCgAAwjPR4QjCW0KkpFHtPpBqXgPOGdbKxNgDecCl2tl6bsP84rorNJSU+OvYo9ESOpcHYuo1zOvSvNQkUtWfLWX60RBZK7isryEHJzH3f/h59FhRUcWzWbqYemawXSPn/SCfMe5XkpckG4p0wpsoNGd1PrEehWokSeR+rhNn0gYhk6NjVQu5Fp7z7xuW62+2tPHvpNsTTGiUfiDzEWm1MzASHbgG1rG5Gq2uXRtEkARre29IB8O7YpQptH6ku7zePsYQ1j8sDNnu4mxPcPDKu59jc/aBM4ugwALn4QxzUpMtkts
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 03:30:33.8359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b17e46-30c2-484e-a85a-08dc49574470
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
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

Replace separate parameters with struct ta_ras_query_address_input.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 57 ++++++++++++++------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 0a9cc87e98d0..d0fcfcb3404f 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -266,26 +266,19 @@ static void umc_v12_0_mca_addr_to_pa(struct amdgpu_device *adev,
 }
 
 static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
-					    struct ras_err_data *err_data, uint64_t err_addr,
-					    uint32_t ch_inst, uint32_t umc_inst,
-					    uint32_t node_inst, uint32_t socket_id)
+					struct ras_err_data *err_data,
+					struct ta_ras_query_address_input *addr_in)
 {
 	uint32_t col, row, row_xor, bank, channel_index;
-	uint64_t soc_pa, retired_page, column;
-	struct ta_ras_query_address_input addr_in;
+	uint64_t soc_pa, retired_page, column, err_addr;
 	struct ta_ras_query_address_output addr_out;
 
-	addr_in.addr_type = TA_RAS_MCA_TO_PA;
-	addr_in.ma.err_addr = err_addr;
-	addr_in.ma.ch_inst = ch_inst;
-	addr_in.ma.umc_inst = umc_inst;
-	addr_in.ma.node_inst = node_inst;
-	addr_in.ma.socket_id = socket_id;
-
-	if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out))
+	err_addr = addr_in->ma.err_addr;
+	addr_in->addr_type = TA_RAS_MCA_TO_PA;
+	if (psp_ras_query_address(&adev->psp, addr_in, &addr_out))
 		/* fallback to old path if fail to get pa from psp */
-		umc_v12_0_mca_addr_to_pa(adev, err_addr, ch_inst, umc_inst,
-				node_inst, &addr_out);
+		umc_v12_0_mca_addr_to_pa(adev, err_addr, addr_in->ma.ch_inst,
+				addr_in->ma.umc_inst, addr_in->ma.node_inst, &addr_out);
 
 	soc_pa = addr_out.pa.pa;
 	bank = addr_out.pa.bank;
@@ -310,7 +303,7 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
 			retired_page, row, col, bank, channel_index);
 		amdgpu_umc_fill_error_record(err_data, err_addr,
-			retired_page, channel_index, umc_inst);
+			retired_page, channel_index, addr_in->ma.umc_inst);
 
 		/* shift R13 bit */
 		retired_page ^= (0x1ULL << UMC_V12_0_PA_R13_BIT);
@@ -318,7 +311,7 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 			"Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x Bank:0x%x Channel:0x%x\n",
 			retired_page, row_xor, col, bank, channel_index);
 		amdgpu_umc_fill_error_record(err_data, err_addr,
-			retired_page, channel_index, umc_inst);
+			retired_page, channel_index, addr_in->ma.umc_inst);
 	}
 }
 
@@ -326,13 +319,13 @@ static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 					uint32_t node_inst, uint32_t umc_inst,
 					uint32_t ch_inst, void *data)
 {
+	struct ras_err_data *err_data = (struct ras_err_data *)data;
+	struct ta_ras_query_address_input addr_in;
 	uint64_t mc_umc_status_addr;
 	uint64_t mc_umc_status, err_addr;
 	uint64_t mc_umc_addrt0;
-	struct ras_err_data *err_data = (struct ras_err_data *)data;
 	uint64_t umc_reg_offset =
 		get_umc_v12_0_reg_offset(adev, node_inst, umc_inst, ch_inst);
-	uint32_t socket_id = 0;
 
 	mc_umc_status_addr =
 		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
@@ -362,10 +355,16 @@ static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 		if (!adev->aid_mask &&
 		    adev->smuio.funcs &&
 		    adev->smuio.funcs->get_socket_id)
-			socket_id = adev->smuio.funcs->get_socket_id(adev);
+			addr_in.ma.socket_id = adev->smuio.funcs->get_socket_id(adev);
+		else
+			addr_in.ma.socket_id = 0;
+
+		addr_in.ma.err_addr = err_addr;
+		addr_in.ma.ch_inst = ch_inst;
+		addr_in.ma.umc_inst = umc_inst;
+		addr_in.ma.node_inst = node_inst;
 
-		umc_v12_0_convert_error_address(adev, err_data, err_addr,
-					ch_inst, umc_inst, node_inst, socket_id);
+		umc_v12_0_convert_error_address(adev, err_data, &addr_in);
 	}
 
 	/* clear umc status */
@@ -425,12 +424,16 @@ static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *ade
 	struct ras_err_info *err_info;
 	struct ras_err_addr *mca_err_addr, *tmp;
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+	struct ta_ras_query_address_input addr_in;
 
 	for_each_ras_error(err_node, err_data) {
 		err_info = &err_node->err_info;
 		if (list_empty(&err_info->err_addr_list))
 			continue;
 
+		addr_in.ma.node_inst = err_info->mcm_info.die_id;
+		addr_in.ma.socket_id = err_info->mcm_info.socket_id;
+
 		list_for_each_entry_safe(mca_err_addr, tmp, &err_info->err_addr_list, node) {
 			mc_umc_status = mca_err_addr->err_status;
 			if (mc_umc_status &&
@@ -446,6 +449,10 @@ static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *ade
 							MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
 				InstanceIdLo = REG_GET_FIELD(mca_ipid, MCMP1_IPIDT0, InstanceIdLo);
 
+				addr_in.ma.err_addr = err_addr;
+				addr_in.ma.ch_inst = MCA_IPID_LO_2_UMC_CH(InstanceIdLo);
+				addr_in.ma.umc_inst = MCA_IPID_LO_2_UMC_INST(InstanceIdLo);
+
 				dev_info(adev->dev, "UMC:IPID:0x%llx, aid:%d, inst:%d, ch:%d, err_addr:0x%llx\n",
 					mca_ipid,
 					err_info->mcm_info.die_id,
@@ -454,11 +461,7 @@ static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *ade
 					err_addr);
 
 				umc_v12_0_convert_error_address(adev,
-					err_data, err_addr,
-					MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
-					MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
-					err_info->mcm_info.die_id,
-					err_info->mcm_info.socket_id);
+					err_data, &addr_in);
 			}
 
 			/* Delete error address node from list and free memory */
-- 
2.34.1

