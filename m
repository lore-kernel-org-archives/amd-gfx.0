Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38205C47074
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jan 2024 15:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F8DD10E0C3;
	Sun,  7 Jan 2024 15:40:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B7110E0C3
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Jan 2024 15:40:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik6P2IsU5eC05yPrQ/fuelyQ/I5HWqy5+v/a9lp4zWcIABkbihlDwzzMqV5AR7fDX86ShUjQXYchAj3VAc2uZYfu8ONMaO7OmZgMnOleLZeGCg8aF/J9D+1VGT0GwRHkxB20gZRw0Qie7PZUstmnICgMRN8/+BbQPDLPlWChagnSxqrm+M9awfQOOotpjuuXEeKXowRvbMs9j/PtgkZHn2UqWYL+1So7292sD4J/fQQd8xxJY97MLqwocTw/lhBrd+P72pW+9ccPXGhd+Q5+NlTRP/4LVF0oQllfgCM9aIruLflzPxmJk6ELLglmceI8hacZWS4arpRXXccYUErHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6gdHi5wERt048pvZZdTAL0BAzst+83wAUjLEsqgTBs=;
 b=CoeFudtRD0JCw1sgcPMlhRBFyshbqMbJqpnQoJUh3bcPKSGPkPA+WSQcPvkqTkN1YZ6ccM+lsYsbu4GD9P1uaO9GGdPKYjUsoCzFm91YY3g+x9ttUrGgEdvCjM/inRIuGGNelLkH85Iy2zF/CUW61zeMs/qWsmpnUSRPA1yvVSRCTGpgHWZZPZ/ku1+HYWk/EdvGj18L7XvEwjTyBb5bcE9cP/eMKKOWiFyME1+xHR5WNbLGKhAFIcRbVzWk2OMjSmqpJ07KsYEzIaD1/yCaXTASW6QaL15J0TvyxHryYUvZ3QORR0UUpmWHBXqbutAtBeG6HP2khq5NiBsHXqEbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6gdHi5wERt048pvZZdTAL0BAzst+83wAUjLEsqgTBs=;
 b=OFf5Vwqt9+Xf0NjePDSOV1tIQvoMMU1RysWUjoC22IwUU7tlrBvI8SKx8u5YBcKRTv+FuSomBZW+fjrKSc3m13KbSMkzZKH9Ao3m8oN2k+SctjynZmJKakibtbp6NEqQUQ+Yv+JBxGc35oRjGl+zDpEjEtakQMpgvC5wTXTPIjw=
Received: from DM5PR08CA0033.namprd08.prod.outlook.com (2603:10b6:4:60::22) by
 DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.21; Sun, 7 Jan 2024 15:40:24 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::e7) by DM5PR08CA0033.outlook.office365.com
 (2603:10b6:4:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Sun, 7 Jan 2024 15:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sun, 7 Jan 2024 15:40:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 7 Jan
 2024 09:40:23 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Sun, 7 Jan 2024 09:40:20 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: drop psp v13 query_boot_status implementation
Date: Sun, 7 Jan 2024 23:40:02 +0800
Message-ID: <20240107154011.12927-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3d1b6e-bd82-4ff6-eee0-08dc0f96f6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWnuxq/R8Ba5apHKNtVX7ODDc61Qbv2TN9dNI8DXhNOUSwkVdY4xvBoOsHUYwAe+S1ET4ikjUN8/1Ss0ouJ/JwaY0IAehO2OVGllSRaNBhfLWeKTTSwt9fqeJLQMR+i54t/BWXgKYt7qrKIFfibBc1jnCFv4DuktdaH2gOO6C70HinHTZ70BXjyHjdWdAINXFuMUxtd2oNBW+p4JTlmGSqqJtlj6awUbfAt7hurn8Box9zEGUkd6Lhz//uMfRs/kFH8abwlnu38TgkOpG31v8RgisVSkaLJkLzJTnN0xbMOm+6NpnzVmKS18fJKC7I1bjCpGl0q7fVBih3Lv/83DUN6lJLV2zgx+dXNCTOhuitYWNILSvhCQr44bvFePT1zTLfCuGtbhgTIoPzJtWfpn+SYtyNDBPzurEjTsGpKT3/pBfIGWsMAnbOYOhpt4uYDX66Uxo7oJN941B6Oxjw7R3qv4rW6L3h3Dy805EaMBPT2h11bX0PMOwQJFac/Kev9jM46WIg41h69LH3nobxPwC4KNCafeTlVR5GCGwjOYzhS1ViZny4Odn2UurnzkTaKyiZQNbzs5HgjpfVXhmfmLYfzk7TBYNoZB0t3mq3ruiXR7RgPUaWalAUGh8b+zwqSRxVOqGMHDvx2DZcjjvIxY0hEKXtjkcvFGmFtFqh9BQl9gIK7wmI7fkM0u7Xuz/Rw6NqMC2t/zp8Y9Nm5KfkDRA/BZqG367/vsvSrwEp6OJcXKtWZJfcYB47GCMlXAB/7Wg+42a0XswF1FQNIRvMlBzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(426003)(26005)(1076003)(2616005)(336012)(7696005)(6666004)(478600001)(82740400003)(36756003)(86362001)(81166007)(356005)(5660300002)(2906002)(41300700001)(36860700001)(47076005)(83380400001)(110136005)(70206006)(70586007)(6636002)(316002)(54906003)(4326008)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 15:40:23.9425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3d1b6e-bd82-4ff6-eee0-08dc0f96f6d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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
index a39c9fea55c4..abad5773714c 100644
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
index 2addbdf88394..90451cabb919 100644
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

