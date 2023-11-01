Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B00C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 11:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE3BF10E6C9;
	Wed,  1 Nov 2023 11:22:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A83B10E6C7
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 11:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcJiDoVLRKuhNgBdaPVcQ+Uk3g3yD2OznG73bS/HOznd+P4j3robf2r7wqDxumPQB9N+H5EgFQP/heJXJYFt00+KzXzUakOS1tuWdSWC1fSAEWIGw9IbUIopD3efIQnCgr530eucbpeE2E5QRf15AUg0hO244WHLhdpC48vagoHPneXKA0VTHjPyNv00bhnKW/UxKJ2PW8iHYj+ghE2c3df+eayW2k2XCiKnSYttsjGVs13AAI3B8wno3z8ULNJ6RmFeisMg4nDs3TGI6RcfxPpHnAIL+Ou4OxvE21tY1B4JHyjp/978awmEXlqMVptIpWRzRrjWRms5quM690xVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMoord91RK/gwyOjoTHnLH6FVTbOrsMCrdetuulwvzo=;
 b=ISz7Q66lsH66GqsSaDkqHc2VDeACZ7XmddlJdj8u3/pBZQHkYCu0/JNJmrwAHKgaCpBUlfZkS+wVNJE0fYC5XdfDYDyIjW2JhH0KAD7twFxHYGOx4iXwLMvQuhY5LMmRmrcehb7duNomo6KZXepp3wXI1eXMwahsZJvMJGb4zemY4fvt4NXyOkamMdF8gNYQajGPu4iGuL+udPZ9yWgEpDBYqYLR48jOT00n3ywKcQ47PbqRg+T3fPsNZURyXWBz2nyLb00BJD5Et+LMtxE1IcmhLYj9CnqUn/TJkacl63OD55xUB6EDK+4ksKVH5riLeWutX1uYxasimJAYKQmYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMoord91RK/gwyOjoTHnLH6FVTbOrsMCrdetuulwvzo=;
 b=UgV+pzv5LP70XttI575NPzdMDt+nKd1cdja4Gz4aAMeg5eWoO/+3Gh25gLhaQLveMLtAPPn/mirf5yfothyHZhdQnh/DHz5JeP3N8D1ZFkKsRBc33Dj7j3Um79E5sfEIYZClLNOk2rtdGNXjWu5W3JFt/yD0wDjB/YsoxZChlW0=
Received: from MW3PR06CA0007.namprd06.prod.outlook.com (2603:10b6:303:2a::12)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 11:22:34 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::6f) by MW3PR06CA0007.outlook.office365.com
 (2603:10b6:303:2a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 11:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 11:22:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 06:22:32 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.32 via Frontend Transport; Wed, 1 Nov 2023 06:22:32 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Add psp v13 function to query boot status
Date: Wed, 1 Nov 2023 19:22:24 +0800
Message-ID: <20231101112225.5731-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231101112225.5731-1-Hawking.Zhang@amd.com>
References: <20231101112225.5731-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|BL1PR12MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: cafbcb24-fc13-4643-cc77-08dbdaccd8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cq27i1NgaUYor7Rz88DxFrm27kBeW03Jrhq0ymUMWgaC9TqUHhxqgOLq0Ggac0n9WZdWmX0hPbl9NiueBAJdOxdM3RFDI8l1Yma8+/oIIzy3N1J0f221u09sVt1aFt0gN2+kH5DLURmz9tr+GVFAAhaAoapItb4X82C9c1w6PclKrMyu2MXpzq+EeU6wGiuD2QWiTeHoO0LYjQOSlSB0IzsbDeqG3VBjDHGb+cM9LxNLCeY3rt05miiLlSFXA4hHoKH62XkI0DRupAeYfYIR5OHIqBNtGVY9Zzllov5s5GkanFZuOY6rGL81t0Fm1AyrC/3TeRN0g0DhrWIdJDlGYOonjr/HkdR+SejJP9LBXz/2pmwObwnUcH/UMRGRlyZc9QyY1s/hk2QX5pFyeTxBvDlgL3Qz4VDr3pbqTdXYPgXSJVMOycCA69XovxIhD8UpjSMuijWVeUYTubPHc1A4xUMwoDfS34i9DpZuXxcdBlXoEkwsbCpjZ3l4/ZVKXeG4fSTnPOIKdbDreQvyMlt8dDIfbKLL2Mqp6ZICiCfvyIGrPy+0RAInQ8+mUGb1sdHlrxqM/KrNlgRjShn12TySRkrgn7tssrYItQl9KUxuGm9vKQfYywKo3SASL7wkF6VPfnsQXCGejeV0jFPjJjI1Y8mTwd/ufdP2gqih5imTV92foMDawpRIxMfFn9SLTrLkFFJ6Epw/17VF3o1RhFBcdH3+OyqUbSwJPZOnJhYWYyGDf4W1pd9yH8hcbNmhQ9FplgXbnvMjVC5FLLeTrdct+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(40470700004)(36840700001)(316002)(6916009)(70206006)(70586007)(40460700003)(40480700001)(36756003)(6666004)(7696005)(356005)(336012)(426003)(26005)(2616005)(1076003)(82740400003)(81166007)(83380400001)(47076005)(86362001)(36860700001)(478600001)(8936002)(4326008)(8676002)(5660300002)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 11:22:34.5537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cafbcb24-fc13-4643-cc77-08dbdaccd8b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add psp v13 function to query boot status.

v2: limit the use case to dGPU only (Lijo)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 15 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 78 +++++++++++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e6dc3cfbac0e..66d9c189af29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2120,6 +2120,21 @@ int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev)
 	return ret;
 }
 
+int amdgpu_psp_query_boot_status(struct amdgpu_device *adev)
+{
+	struct psp_context *psp = &adev->psp;
+	int ret;
+
+	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
+		return 0;
+
+	if (psp->funcs &&
+	    psp->funcs->query_boot_status)
+		ret = psp->funcs->query_boot_status(psp);
+
+	return ret;
+}
+
 static int psp_hw_start(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 7111dd32e66f..5d36ad3f48c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -134,6 +134,7 @@ struct psp_funcs {
 	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*vbflash_stat)(struct psp_context *psp);
 	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
+	int (*query_boot_status)(struct psp_context *psp);
 };
 
 struct ta_funcs {
@@ -537,4 +538,6 @@ int is_psp_fw_valid(struct psp_bin_desc bin);
 
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
 
+int amdgpu_psp_query_boot_status(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 4142e2fcd866..3cf4684d0d3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -759,6 +759,83 @@ static int psp_v13_0_fatal_error_recovery_quirk(struct psp_context *psp)
 	return 0;
 }
 
+
+static void psp_v13_0_boot_error_reporting(struct amdgpu_device *adev,
+					   uint32_t inst,
+					   uint32_t boot_error)
+{
+	uint32_t socket_id;
+	uint32_t aid_id;
+	uint32_t hbm_id;
+	uint32_t reg_data;
+
+	socket_id = REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, SOCKET_ID);
+	aid_id = REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, AID_ID);
+	hbm_id = REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, HBM_ID);
+
+	reg_data = RREG32_SOC15(MP0, inst, regMP0_SMN_C2PMSG_109);
+	dev_info(adev->dev, "socket: %d, aid: %d, firmware boot failed, fw status is 0x%x\n",
+		 socket_id, aid_id, reg_data);
+
+	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_MEM_TRAINING))
+		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, memory training failed\n",
+			 socket_id, aid_id, hbm_id);
+
+	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_FW_LOAD))
+		dev_info(adev->dev, "socket: %d, aid: %d, firmware load failed at boot time\n",
+			 socket_id, aid_id);
+
+	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_WAFL_LINK_TRAINING))
+		dev_info(adev->dev, "socket: %d, aid: %d, wafl link training failed\n",
+			 socket_id, aid_id);
+
+	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_XGMI_LINK_TRAINING))
+		dev_info(adev->dev, "socket: %d, aid: %d, xgmi link training failed\n",
+			 socket_id, aid_id);
+
+	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_USR_CP_LINK_TRAINING))
+		dev_info(adev->dev, "socket: %d, aid: %d, usr cp link training failed\n",
+			 socket_id, aid_id);
+
+	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_USR_DP_LINK_TRAINING))
+		dev_info(adev->dev, "socket: %d, aid: %d, usr dp link training failed\n",
+			 socket_id, aid_id);
+
+	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_HBM_MEM_TEST))
+		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm memory test failed\n",
+			 socket_id, aid_id, hbm_id);
+
+	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_HBM_BIST_TEST))
+		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm bist test failed\n",
+			 socket_id, aid_id, hbm_id);
+}
+
+static int psp_v13_0_query_boot_status(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int inst_mask = adev->aid_mask;
+	uint32_t reg_data;
+	uint32_t i;
+	int ret = 0;
+
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6))
+		return 0;
+
+	if (RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_59) < 0x00a10007)
+		return 0;
+
+	for_each_inst(i, inst_mask) {
+		reg_data = RREG32_SOC15(MP0, i, regMP0_SMN_C2PMSG_126);
+		if (!REG_GET_FIELD(reg_data, MP0_SMN_C2PMSG_126, BOOT_STATUS)) {
+			psp_v13_0_boot_error_reporting(adev, i, reg_data);
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.wait_for_bootloader = psp_v13_0_wait_for_bootloader_steady_state,
@@ -781,6 +858,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.update_spirom = psp_v13_0_update_spirom,
 	.vbflash_stat = psp_v13_0_vbflash_status,
 	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
+	.query_boot_status = psp_v13_0_query_boot_status,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.17.1

