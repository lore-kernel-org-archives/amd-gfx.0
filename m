Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBA7C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 14:08:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 608DA10E11E;
	Tue,  2 Jan 2024 14:08:02 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB66B10E11E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 14:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtP8dy0m2qTJ8AsuuBMGscZQEe/EbWPA7gdEwdRTOfTJtoGfg4HO8Gzr/K7wxN+PUTY2/YAM2xnEvKnq7RoHRTJyFi/l5c/OC76C5cliLkQbxhIHNwVElyQtOv//ntq/VsO5HJxx/ejtNi3gPMyfwDVTd7oa/lqi/KSZ7YP9L2HlGlQu7q8hCgB++i5U1E6Iu5tb/XK6Lg4ozXwN2XbWGQbP3Fx+rjhJ/l++TjnKdvN1dJsxe5MWU3v7r2l70DGHVVh0BhaZ0f8sMySrbvfAmalsaWA0zN8TuxMik0gxrzCXHXDE+LiyMpVy0JmrH7+ZTeAczLMfBc4CzgnG9hZJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPcWp0cl63A5ARzQSPN5U8/A4E2zeqSXVqnp8FOry0c=;
 b=Nh7l6Hw9h7ihNHE3lUEFVrIi55U4hpwUf+y0io3ITteLc1tYsyNAPz78qv5/9u4c4aRBt3YbcY/LZMd/2SM+hshcenLerTh5Meb4iNrRh3EqvoTDt2SQb5iD/Nz2UB6DDerLHGJJG17PHW58Q5+jo0SAh94ZXn3jI21xfMXXxbCZaUw4i0HRODGFsiSXA3J0thfl3TuCan28wRqO5X+3qcnBiGkveLYqUZhlIhjC1o93IhprYQ0n+3mLOsSsQHnRFXMSNuqYV6l3grDGBIG85vljMSCAZkhk1HsfKRJeSYcy+3mTRa+bKgdKPhuq7iJt2FvT/+l3DkMRNQrWNIxvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPcWp0cl63A5ARzQSPN5U8/A4E2zeqSXVqnp8FOry0c=;
 b=KjQpPQTrGQ7Dm4e1/XlWEPPUzusvi/YMUQRGvz6EJhqo7AA9ElWXMTC2tFLrfLt3kipPgvruRnJyQwMVgFDGwoXKMpexejG3DElFDd3K4JWoLMAcq8y7omJbvg8N/qdKYxlbNXRn1qeyYO1Ru1tKy9/OvKEsFeVFJ1VLQmphvlU=
Received: from SJ0PR03CA0286.namprd03.prod.outlook.com (2603:10b6:a03:39e::21)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 14:07:56 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::66) by SJ0PR03CA0286.outlook.office365.com
 (2603:10b6:a03:39e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 14:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 14:07:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:07:55 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 08:07:55 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Tue, 2 Jan 2024 08:07:52 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: drop psp v13 query_boot_status implementation
Date: Tue, 2 Jan 2024 22:07:33 +0800
Message-ID: <20240102140742.23917-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a807cdf-ddf3-46f3-0516-08dc0b9c380c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJiT//fEhdBkpkixrwo60von/VOHBpCJbVn6vyr0raAkSA7VgdnEzDEUso6N/geppcS81328PUpycfKOpLA9Xo8xSaxknnwyYSCCsz5erR31CTa/sJQEcd5hs4aAjCypmoWE1cH8Cbw9f30uKZJAjcpMaq6d5O2YEtJ4yhTvo/Ur73f9rtCA6rQ2E2yflSO/HB4irtRDm9z0ilMKGBi3kpH0ikgJk19EV1vF+H1qvRw5cj/98Bu5xZOqTY85eIOWz3nVt1J3z01OWlcLAWj+BRpUOCfSCldLC0bqRRVw5N2ASiLGRVjWU+h7ZRmddF1qouvFER6lhQDXBiy1cYBONjk3ZmQSpNhIc9iZcQ7f8niGL4/8EcaaqDeo0ne652Xz51uOTjHZ33nL2Huh4bZziV7NrMq2IujTy/LjUzc/fLhohAnLeeKkkg0RFctQXXLaPX/Y4IXzJMjxFOYOhJNxxFu4kg0H+YVHFM/rWmR7Yf7bEz+sDEvVLVx9oU3gsYd85S+JnWO5cve2vtJ6fkw1NAFIGdQkX22i4Zr4p609YXTsHxKxFGpLDE7as4kiHFXRaJIRfT5b7ZZU+uMrJ7/9O/z0vTJy8AqG5aCY5j7RHoiAUjYEGOfDlG5XtNkUsItksgAVd0V5lR/oiILX/gC7gjHoUD1qY0tTIvIa1o84K09Qj4KsmXiJi9ceM+igldEblOLmIqISZG9g9dB3PgQcXHlY2KRyejS4Bug9uDYhEh83h2Idcq0y9Rnw6Jo5AUv1ItvOHLnezySFCJA8gq8/BQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(426003)(1076003)(2616005)(336012)(26005)(36860700001)(83380400001)(81166007)(356005)(82740400003)(110136005)(70586007)(70206006)(47076005)(36756003)(316002)(54906003)(6636002)(478600001)(86362001)(5660300002)(2906002)(8936002)(8676002)(4326008)(40480700001)(40460700003)(6666004)(7696005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:07:56.1320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a807cdf-ddf3-46f3-0516-08dc0b9c380c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
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
index 51bfe3757c89..0dc8686e54f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2128,21 +2128,6 @@ int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev)
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

