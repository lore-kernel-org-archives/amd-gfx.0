Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86729C47074
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 098DD10E063;
	Tue,  2 Jan 2024 03:44:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1307A10E063
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN2rOyKTXmzcb8rlsBMno6Dx5AnoOarQKc+SoWcscJyHvHCmNOlzYgwn5+qnH23lO/xC66gv2Lrbb+57s5s6sJ6HCkvflztjxW1xheM1pfoBMcrbGjkjzRO4WRsacHjCESXcp5Lkg8csZMo5z7eR5AWm8C+aC3AaPRNqKFnvEvhOGrVTbKQJCVWTNDtrpijPYulmKTotXcf7Y9/nrSHTRrR/bzrEKUpDIPaJTh0+YYws0Y8tbGK75rwzOqghZIpxQL2qB/VVcS96r/Jp6RJYEtX9MNeI7y4AIY2HVMVq1IFRRl/PH5s1TRLAkVXP9kggGu2b+GqNdSlMl2LEivtgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjqOE/IIqHI0a/WUca552odTpY6wVZbUe1x37dlxNbY=;
 b=fqRxfRRI7y/UdxvymWcJBjq1/xUaZUlbh/jPR/MVKjGAcbXM6jxYiakWHwhunEWiKdFO4ZuVlM7HRA4RR8xTMcQAi1Q9yrfN7eX35/BRjswgqKwmgrjRJFFHnFOK/bbyUmjry3rpqHYwI7c94phDcXlkZ7FxB+Y3FklTfw9WGDnDvlE5rkw5LUEI3PsrE0oMoJrnVI/1EWG2kRAW0o0FTjYeovaYaivYBmP/xxJy2Qq0jkBy9e32kHN0tSIgOPShgxprh6NL+th5jGruigUUpm6wyh6qmxGOG4MSL/IhevhTvKj5Vr4EXd0PgcxWBPoVMzPOomM/hDRCin8v75CMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjqOE/IIqHI0a/WUca552odTpY6wVZbUe1x37dlxNbY=;
 b=ql7IZoF43QGrHc7dXnmiv0NDgvagIa+KhTcyP+hoONPIfs3as9Lds8iVWUhlV6b3yjG7G22d76I0dJurY6pEd1rOFZTeyWS6+scWj6fRp64MsmIEusljq4ysOy5hGcOT3OyDyoYF4PG+8Cg4UkG44YMCRHSe+xD0RBnI9tNaTcs=
Received: from DS7PR05CA0012.namprd05.prod.outlook.com (2603:10b6:5:3b9::17)
 by CH3PR12MB7521.namprd12.prod.outlook.com (2603:10b6:610:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 03:44:00 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::ee) by DS7PR05CA0012.outlook.office365.com
 (2603:10b6:5:3b9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.12 via Frontend
 Transport; Tue, 2 Jan 2024 03:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:44:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:43:59 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:43:59 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:43:56 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: drop psp v13 query_boot_status implementation
Date: Tue, 2 Jan 2024 11:43:37 +0800
Message-ID: <20240102034341.16321-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102034341.16321-1-Hawking.Zhang@amd.com>
References: <20240102034341.16321-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH3PR12MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe1aeb3-b4c7-4986-2652-08dc0b450e59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5+I16EojLeNLrbT8fdnNVxakzh9C9/7VBP62zO6DDaz6Qo65t4R11ulXK2AGKJSPQERdFPae+kIDgEyce0Z629xXVrUZ+CHKV4cqJoCGi/J8uWXaf/cPEcG+kK90tCVpFWNaA4iN2P4Z1CbHesXmaCUdj2BKfPE6DDPAsQmn6SnFKe0RyFO9ukr83gjp6f6J6g1ZSoMm+yjlyDYUV2eV73vRHbDBwC2seiG47o5Q3M84qdYO8L+dv0qXPIdaiz0jUVzo7uLo+XaWQDAqehZMEjR9lkPRF0zRry0ljg8T5LzxUuFFfrpuMYqHnZ5odhTRjfeW5v3Gmegy4O9W3B+b/Nu9Cm/479fcEg798bda7e9Kovv5JywLcIYQS4+guGpVVeGRz4bG9zit2b/Frv5EUDFoBtaarLNAFr4L/5KnfxL63OuI270+ftPWev4pkmhDyfZ4IY2dP7qtXggG/OllfuEVRk/2TWK4gjWXPOw0ADtdmJ74pNfTGosmUpOP7fMM0KEdXdSvEXURoxKUO6bQxbHZ5NnXSH2GHNu61kFY6YGqCZZDhbkTsg0+W/2XP8BvJWbzvHgYHjSfLINcrqKUFQl7T/DAqHhizDjOmMBSzl/6O4NLn30RnD9is/WdS/Ap+SV21LqeZ55mreEGU5IqPL0t+e0y4JFyzyKKYpqTDUZpxSJb5vpmX0nSj+4ZtqU15foIvNrPAEiorxTlDL4XYWG0CdOaK0TvoBvD+mNu+sWx+Ogh4DEoKStvubFH3fVmMMdJT9TZFmpEaERTsu6RQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(426003)(336012)(2616005)(26005)(1076003)(83380400001)(86362001)(81166007)(36756003)(356005)(82740400003)(47076005)(4326008)(5660300002)(7696005)(6666004)(36860700001)(70586007)(54906003)(70206006)(8936002)(8676002)(316002)(6636002)(110136005)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:44:00.0202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe1aeb3-b4c7-4986-2652-08dc0b450e59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7521
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Will replace it with new implementation to cover
boot fails in ip discovery phase.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 15 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  4 --
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c     | 78 ----------------------
 4 files changed, 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4b694696930e..001a35fa0f19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1218,8 +1218,6 @@ static int amdgpu_device_asic_init(struct amdgpu_device *adev)
 	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
 		amdgpu_psp_wait_for_bootloader(adev);
 		ret = amdgpu_atomfirmware_asic_init(adev, true);
-		/* TODO: check the return val and stop device initialization if boot fails */
-		amdgpu_psp_query_boot_status(adev);
 		return ret;
 	} else {
 		return amdgpu_atom_asic_init(adev->mode_info.atom_context);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1bf975b8d083..94b536e3cada 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2125,21 +2125,6 @@ int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev)
 	return ret;
 }
 
-int amdgpu_psp_query_boot_status(struct amdgpu_device *adev)
-{
-	struct psp_context *psp = &adev->psp;
-	int ret = 0;
-
-	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
-		return 0;
-
-	if (psp->funcs &&
-	    psp->funcs->query_boot_status)
-		ret = psp->funcs->query_boot_status(psp);
-
-	return ret;
-}
-
 static int psp_hw_start(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index c4d9cbde55b9..09d1f8f72a9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -134,7 +134,6 @@ struct psp_funcs {
 	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
 	int (*vbflash_stat)(struct psp_context *psp);
 	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
-	int (*query_boot_status)(struct psp_context *psp);
 };
 
 struct ta_funcs {
@@ -538,7 +537,4 @@ int psp_spatial_partition(struct psp_context *psp, int mode);
 int is_psp_fw_valid(struct psp_bin_desc bin);
 
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
-
-int amdgpu_psp_query_boot_status(struct amdgpu_device *adev);
-
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index df1844d0800f..6fad451a85be 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -763,83 +763,6 @@ static int psp_v13_0_fatal_error_recovery_quirk(struct psp_context *psp)
 	return 0;
 }
 
-
-static void psp_v13_0_boot_error_reporting(struct amdgpu_device *adev,
-					   uint32_t inst,
-					   uint32_t boot_error)
-{
-	uint32_t socket_id;
-	uint32_t aid_id;
-	uint32_t hbm_id;
-	uint32_t reg_data;
-
-	socket_id = REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, SOCKET_ID);
-	aid_id = REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, AID_ID);
-	hbm_id = REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, HBM_ID);
-
-	reg_data = RREG32_SOC15(MP0, inst, regMP0_SMN_C2PMSG_109);
-	dev_info(adev->dev, "socket: %d, aid: %d, firmware boot failed, fw status is 0x%x\n",
-		 socket_id, aid_id, reg_data);
-
-	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_MEM_TRAINING))
-		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, memory training failed\n",
-			 socket_id, aid_id, hbm_id);
-
-	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_FW_LOAD))
-		dev_info(adev->dev, "socket: %d, aid: %d, firmware load failed at boot time\n",
-			 socket_id, aid_id);
-
-	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_WAFL_LINK_TRAINING))
-		dev_info(adev->dev, "socket: %d, aid: %d, wafl link training failed\n",
-			 socket_id, aid_id);
-
-	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_XGMI_LINK_TRAINING))
-		dev_info(adev->dev, "socket: %d, aid: %d, xgmi link training failed\n",
-			 socket_id, aid_id);
-
-	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_USR_CP_LINK_TRAINING))
-		dev_info(adev->dev, "socket: %d, aid: %d, usr cp link training failed\n",
-			 socket_id, aid_id);
-
-	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_USR_DP_LINK_TRAINING))
-		dev_info(adev->dev, "socket: %d, aid: %d, usr dp link training failed\n",
-			 socket_id, aid_id);
-
-	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_HBM_MEM_TEST))
-		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm memory test failed\n",
-			 socket_id, aid_id, hbm_id);
-
-	if (REG_GET_FIELD(boot_error, MP0_SMN_C2PMSG_126, GPU_ERR_HBM_BIST_TEST))
-		dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm bist test failed\n",
-			 socket_id, aid_id, hbm_id);
-}
-
-static int psp_v13_0_query_boot_status(struct psp_context *psp)
-{
-	struct amdgpu_device *adev = psp->adev;
-	int inst_mask = adev->aid_mask;
-	uint32_t reg_data;
-	uint32_t i;
-	int ret = 0;
-
-	if (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6))
-		return 0;
-
-	if (RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_59) < 0x00a10109)
-		return 0;
-
-	for_each_inst(i, inst_mask) {
-		reg_data = RREG32_SOC15(MP0, i, regMP0_SMN_C2PMSG_126);
-		if (!REG_GET_FIELD(reg_data, MP0_SMN_C2PMSG_126, BOOT_STATUS)) {
-			psp_v13_0_boot_error_reporting(adev, i, reg_data);
-			ret = -EINVAL;
-			break;
-		}
-	}
-
-	return ret;
-}
-
 static const struct psp_funcs psp_v13_0_funcs = {
 	.init_microcode = psp_v13_0_init_microcode,
 	.wait_for_bootloader = psp_v13_0_wait_for_bootloader_steady_state,
@@ -862,7 +785,6 @@ static const struct psp_funcs psp_v13_0_funcs = {
 	.update_spirom = psp_v13_0_update_spirom,
 	.vbflash_stat = psp_v13_0_vbflash_status,
 	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
-	.query_boot_status = psp_v13_0_query_boot_status,
 };
 
 void psp_v13_0_set_psp_funcs(struct psp_context *psp)
-- 
2.17.1

