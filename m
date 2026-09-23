Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1621DC98311
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C01310E2B9;
	Wed, 23 Sep 2026 15:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GTrSG2gg";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6DB10E210
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJtzoLh3LVjuxypj1eQhSgUp1MnbnEL+Ny8PbDc0Ga9Kl86Cr/6l3eMbUOwWNVKe8b5sZQeLr2wKaJS0UUjG1NJ0XdCf2IJkqfJbJrDVRjLymmKSz0hZWdvjQtTAR9xAmHWAd+Pr8zvBzJ3qjWJOJwMMvn0c13sCSnCy99dNLunS6QN+j0L41shksdZ9KOkIj1BPbg1pkabzVcluiNd2iH8Ua3O3IQjwV6x9r+Un/Lfgzrx/G8fa/ilHaK7u9GfUlUvUCKnZa468NGNzQ3+/9hfWsnVZZQhLisZ6N3PYp2wuYhRQXnNXT8Hpcv6aeVLPS8O64VkeTr1VLt2SAQMGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyQYtDQaRmbLVJFOpkFpo4/5uleNKfcB9ASfz0JKWC0=;
 b=vvlf0+Ke1iLb49+Gh5McR62bd64nivrqvFi3hQGKor0AD3J8ZkeOndt/pvviWJpkUn3G2R7R/nEQLZzmP40R5MqhOuBNxj7Wo+83TDx+e52apnIXV4E6sVKzxAyI6OIt64FWmnThXetPP1FhiTWTcL3nv9WHpsfQ1qLF94CS2uzgiE9VNDKlA3SSsW2EQumKWlvYww7CczyovFAYKl40qxTp1LWStvqMcRJL28hJHLX9Bw+7Ik2JD2TtJbqK/cXfymAUM8Cw+dqERFqDQlVrJuJGF83UbBh0v5N9dwB3JMMhpdCBP6sNnERF5AqwC9mesdevwQptmq34r5q6qTcT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyQYtDQaRmbLVJFOpkFpo4/5uleNKfcB9ASfz0JKWC0=;
 b=GTrSG2ggJx/boP19q4gO6rhLcIrR5m+Yd5clesICx9Pca8XcoT80yXim201mQxtuOsCi2kkKGAU5tRJGCPeSppP8e0yRrrmW1ZyR93jbTAxb9Gn2mRA0pDI+mSQlQLvsf1D5wBmb2Gq8DcT1GPcwAwXruHHcIcQVoYsD0tvFfWE=
Received: from MW4PR03CA0198.namprd03.prod.outlook.com (2603:10b6:303:b8::23)
 by DSVPR12MB827618.namprd12.prod.outlook.com (2603:10b6:8:3e5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:12:38 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::22) by MW4PR03CA0198.outlook.office365.com
 (2603:10b6:303:b8::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 15:12:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:12:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/12] drm/amdgpu: Add firmware type retrieval in PSP v15.0.3
Date: Wed, 23 Sep 2026 11:12:17 -0400
Message-ID: <20260923151226.2778589-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923151226.2778589-1-alexander.deucher@amd.com>
References: <20260923151226.2778589-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DSVPR12MB827618:EE_
X-MS-Office365-Filtering-Correlation-Id: 007c1e92-6f59-42f7-4bee-08df19851adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 6JO490Szvv7t367RGO6hqFsXK3JqJsxxRgKObe34Ypv6rsvSwrwCRob6S6VwFBceNU8/pFHC2qwSzDywCX3TSmsrdKwEL1aMBy21ugGcyK42rswWaibgTot9dQNVHLpkLXBHfYvl9mJykhUexwbFM7x7BItQHzPQj9eHSA6RS+iCyR/LYD9Lfeb0UGDp51RmFmi0RRawOYcV/Q9If9L1oLCmbJSj2atBHN9EaJIlhB0CXwsITJFmrl+cUDfcxJvAAV4Yp++Z0/sJAg8HRV/4/WSDi6UPOQYXZSG6IOSgqZK/RddTTlkX9C96cZd0eXBGyMOK0fDWbiaxTtaoSWrlfUL1JvDYMbmaNmdHls107LZdX7isCHmUKGgcSb/nh1+7fag3TU4WrlL+RU2qRSa+qY3MYHqyk0P67zEeyJfFVto0LPQ1yRMwlQ6tcITC/xs128UXwyHL03nzxntIgAImKrblI7q05B9mnwYivvxiAi4PIIoPAj67iwtcGaXxVb0DR+cR8CxX1APqri4FubTicLp/6GwTSoKhVXY0euPZ6owkzalRtuNCrz3hr43uysVJGIyKGlx9M12FF91X6EcnJL3ugaCf+zQgeArPAAXld3sm7+YVTgXTbCxPAT1ejsVx1l2nj9S2YWNSTIA0+OHQlrgddXHrHSFJuUW3HTUCGCfkSihXhIevf/EEtoGvFhD4RXnJKVzPWZe7cF3ryKA3TA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GiHDh4ic4/jD/d4rl9P6M87kdUOuTBAwWJOrisKtfxKAfcA9HEiqwqRo2z1tF04KdPQIctvKhcynnJOssaMQJUos/QTjgohQ5NesI195YtHR81t2q96Pri+DPdhpVC1zWufOO1jZfdsAF1YQOURlblbMHF833r4bFov3ucT6DFVlqamM34LnjHTX1tnwSDD/wwZgw0J4LPhOlqgXOMKY0e/1YUjn4e/jAFW2Xcxg5jQCz6je2vE56MXDhE6A2s4A49XYy1NhIXejJEOiFdH98iaZt5YkMOWQ8rVfgg1F2D6tmjQU2bZvgg6EiAjm95KlCikqIzK+hf/iW9gzFwvEUQQm0C5EuxLW54YAtL7DnavXeWTGAp2QKfi0G06L3EM3gbDgoo33/S+Lbvi3Lw22T9+L3DtlVjYWArzpZ1qkpI6K8Fb8KUH2hErLJgJrFtuR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:12:38.0540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 007c1e92-6f59-42f7-4bee-08df19851adc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB827618
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

From: Frank Min <Frank.Min@amd.com>

Add firmware type retrieval in PSP v15.0.3 to adapt psp fw updates

Signed-off-by: Frank Min <Frank.Min@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c | 123 ++++++++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
index fd9b35492fcbe..d07588e8efb3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
@@ -653,6 +653,126 @@ static int psp_v15_0_3_vbflash_status(struct psp_context *psp)
 	return RREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115);
 }
 
+static int psp_v15_0_3_get_fw_type(struct amdgpu_firmware_info *ucode,
+			   enum psp_gfx_fw_type *type)
+{
+	switch (ucode->ucode_id) {
+	case AMDGPU_UCODE_ID_CAP:
+		*type = GFX_FW_TYPE_CAP;
+		break;
+	case AMDGPU_UCODE_ID_SDMA_RS64:
+		*type = GFX_FW_TYPE_SDMA0;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES:
+		*type = GFX_FW_TYPE_CP_MES;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES_DATA:
+		*type = GFX_FW_TYPE_MES_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES1:
+		*type = GFX_FW_TYPE_CP_MES_KIQ;
+		break;
+	case AMDGPU_UCODE_ID_CP_MES1_DATA:
+		*type = GFX_FW_TYPE_MES_KIQ_STACK;
+		break;
+	case AMDGPU_UCODE_ID_RLC_V:
+		*type = GFX_FW_TYPE_RLC_V;
+		break;
+	case AMDGPU_UCODE_ID_RLC_G:
+		*type = GFX_FW_TYPE_RLC_G;
+		break;
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL:
+		*type = GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_CNTL;
+		break;
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM:
+		*type = GFX_FW_TYPE_RLC_RESTORE_LIST_GPM_MEM;
+		break;
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM:
+		*type = GFX_FW_TYPE_RLC_RESTORE_LIST_SRM_MEM;
+		break;
+	case AMDGPU_UCODE_ID_RLC_IRAM:
+		*type = GFX_FW_TYPE_RLC_IRAM;
+		break;
+	case AMDGPU_UCODE_ID_RLC_DRAM:
+		*type = GFX_FW_TYPE_RLC_DRAM_BOOT;
+		break;
+	case AMDGPU_UCODE_ID_SMC:
+		*type = GFX_FW_TYPE_SMU;
+		break;
+	case AMDGPU_UCODE_ID_PPTABLE:
+		*type = GFX_FW_TYPE_PPTABLE;
+		break;
+	case AMDGPU_UCODE_ID_DMCUB:
+		*type = GFX_FW_TYPE_DMUB;
+		break;
+	case AMDGPU_UCODE_ID_IMU_I:
+		*type = GFX_FW_TYPE_IMU_I;
+		break;
+	case AMDGPU_UCODE_ID_IMU_D:
+		*type = GFX_FW_TYPE_IMU_D;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_PFP:
+		*type = GFX_FW_TYPE_RS64_PFP;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_ME:
+		*type = GFX_FW_TYPE_RS64_ME;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC:
+		*type = GFX_FW_TYPE_RS64_MEC;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK:
+		*type = GFX_FW_TYPE_RS64_PFP_P0_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_PFP_P1_STACK:
+		*type = GFX_FW_TYPE_RS64_PFP_P1_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_ME_P0_STACK:
+		*type = GFX_FW_TYPE_RS64_ME_P0_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_ME_P1_STACK:
+		*type = GFX_FW_TYPE_RS64_ME_P1_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P0_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P0_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P1_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P2_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P3_STACK;
+		break;
+	case AMDGPU_UCODE_ID_VPE_CTX:
+		*type = GFX_FW_TYPE_VPEC_FW1;
+		break;
+	case AMDGPU_UCODE_ID_VPE_CTL:
+		*type = GFX_FW_TYPE_VPEC_FW2;
+		break;
+	case AMDGPU_UCODE_ID_VPE:
+		*type = GFX_FW_TYPE_VPE;
+		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_UCODE:
+		*type = GFX_FW_TYPE_UMSCH_UCODE;
+		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_DATA:
+		*type = GFX_FW_TYPE_UMSCH_DATA;
+		break;
+	case AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER:
+		*type = GFX_FW_TYPE_UMSCH_CMD_BUFFER;
+		break;
+	case AMDGPU_UCODE_ID_MP5:
+		*type = GFX_FW_TYPE_MP5;
+		break;
+	case AMDGPU_UCODE_ID_MAXIMUM:
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct psp_funcs psp_v15_0_3_funcs = {
 	.init_microcode = psp_v15_0_3_init_microcode,
 	.bootloader_load_kdb = psp_v15_0_3_bootloader_load_kdb,
@@ -673,7 +793,8 @@ static const struct psp_funcs psp_v15_0_3_funcs = {
 	.load_usbc_pd_fw = psp_v15_0_3_load_usbc_pd_fw,
 	.read_usbc_pd_fw = psp_v15_0_3_read_usbc_pd_fw,
 	.update_spirom = psp_v15_0_3_update_spirom,
-	.vbflash_stat = psp_v15_0_3_vbflash_status
+	.vbflash_stat = psp_v15_0_3_vbflash_status,
+	.get_fw_type = psp_v15_0_3_get_fw_type,
 };
 
 void psp_v15_0_3_set_psp_funcs(struct psp_context *psp)
-- 
2.55.0

