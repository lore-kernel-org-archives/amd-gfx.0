Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011ECC47074
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 03:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8102C10E115;
	Tue,  2 Jan 2024 03:45:53 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7537F10E115
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 03:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec7gOruatfWq4vb9+HCepugKObLZdyGwva9kYBNXO5kxWDvmYEH4lRBrsIeCtkjXNK7+mBHlfw3NRfz6uySKvQMjv8/E1iKVcPQePRnkB8EHnuQ8YLdQ0/k3TdwJAY7Q4goiwT3/2BDC5WEzN5pLWHIsTFXCByxf7VvcV6hZp6Yc0IEKNHeyd5jB+v6/YU9uY8AtSI5jBUDPiH5skWLzqS4D4a3PbbdWyT0BpjeLvvqmHshfJLmCxim6K+Wz4k6sx2wXB5jEetcw/JhIlePnCR14xXKsNO73Bv0RaewWbHUz7NnABlyk5bJUrgOJFGs1oVyrq1EtvoXc0CFgBBWr7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsxmi4ZVqBX8KImJkNwOcf9nGhtQbaNzY+U4SkLvuPQ=;
 b=KnOEUTFKsuI5uw79KR3R4/U52BMATixZC8r18Oip73CDONMRkPmNEtvqNjk6+4XD/UniyRBRJeJBbAxGxv5WbcHCOFP7vp/EAN80x5EQvps2hc3kS9eGP/11JDtJiLjSaOO5vuZWSBHcJ+nyGGM4ruJKadNYVC3WbF1NRnnBbKSPLZTUamxPvp99bngxqXHgqLDNVzB7e+67lyK6pcrvIy5cfzIM7uQ4hqlMxK539uvRYSmoSYlnGrsyiHaSfzUwxHBvb3q5uuP3xyWpE3KRETQxMTJk6m/7Qo14BB6mMnyuNesydyg1kuR0MdThz7fNkF+gA69CvyGhhhqAzomJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tsxmi4ZVqBX8KImJkNwOcf9nGhtQbaNzY+U4SkLvuPQ=;
 b=nxaU43U+syCS6I85Z7mEKOQwoq1lKvP2P0+f+jemiH2PaknsQuDpF1+cZFaTeu1G24Mp8AK+Cj4BHgAYUXePTlmciapU7kigv2gfoDpOcmSnH0IGHmv9UdUdfOA1KHYik/XNd3ULs0B8PYqDBjtskuGbHZLM7Hwa4mEVdMxolXk=
Received: from SJ0PR03CA0180.namprd03.prod.outlook.com (2603:10b6:a03:338::35)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 03:45:46 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::5d) by SJ0PR03CA0180.outlook.office365.com
 (2603:10b6:a03:338::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 03:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 03:45:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:45:43 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 1 Jan
 2024 21:45:21 -0600
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.34 via Frontend Transport; Mon, 1 Jan 2024 21:45:18 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, "Stanley
 Yang" <Stanley.Yang@amd.com>, Yang Wang <kevinyang.wang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Candice Li <Candice.Li@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Replace DRM_* with dev_* in amdgpu_psp.c
Date: Tue, 2 Jan 2024 11:45:08 +0800
Message-ID: <20240102034508.16426-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240102034508.16426-1-Hawking.Zhang@amd.com>
References: <20240102034508.16426-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dd3f72-ca8b-4bc1-4c98-08dc0b454dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwRyoRiXGCYayPgVddmAR8CCAzImzY1RViQNVouDEE0x3FVjmyrDP6B3SVuu+bLSM/BsbhGFo7G9Q9H9mdeEN7lc5RXZNyAiAkfelBRHthp+W+OWEkfz2DBmQbBaQ9BvvyU1s2A+Ftq+mxBzjjFWUU8ecPxLvnrv5hxGX+YnH9Yb53PeJNUcv5OVzUamF/ndMERmfrWiLDm3agv/Nt+xqEYAnaOfnZeOKjXbZ4D3fmubgo7bK+bQVVUtLaFnvUh08c5xal/RUx6xGfywza0Ugk06I8+FYqrTph0Q08gJWW0bzMAgUvj5BS2FB4uVv2Juk1WPPKvjOnYUlYMEhqkWCggGIm6n0qBjSbfaykE1h3FSuAOngqKfTCinoKIc7qHp76Y949CHsF856KRdnDcGEnamTTq+Ix+gOlcwEeXS/L4tu2iNi3APEnl5PFBvy9MMFBHcvm5qsnzMN+CueZEpgg8qv4/VlCPuMYipnmPTewqKa2gxAtX5KX3Eq3hUSRScvLyaOu+i9alOxe1AiKbtm648WtZ/iltQKb/+Gs3IM/JDyZ3u48ThPZR7InDQRDdEy/zehqxp/xFBsnBAT55q2U3qDgN4EaIfAewijQV602pXD4E2MMV3GWtRn4trGSrqRkXWZ0S2MfCv5fRaCCVDKQq5qjWv1Cf/qmOsEmAxOlhKGAhHUOBf5wH2trmsPn7lcE3nPeoR7oCx55NI65duim5ZMWgAHD4HTtGyAlB320Q42Si+LJ7KwL6pzXC5i7ZcTuKt0SG5H47B/+QSUd14e1LAN7DBYVPKZL1ICzRb1BLy+dTjOC2gqtubQtszRup9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230273577357003)(230922051799003)(230173577357003)(186009)(82310400011)(1800799012)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(30864003)(5660300002)(4326008)(8676002)(8936002)(316002)(36756003)(54906003)(6636002)(86362001)(478600001)(40460700003)(40480700001)(6666004)(41300700001)(7696005)(26005)(426003)(1076003)(336012)(2616005)(356005)(83380400001)(81166007)(47076005)(70206006)(70586007)(110136005)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 03:45:46.3680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dd3f72-ca8b-4bc1-4c98-08dc0b454dc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219
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

So kernel message has the device pcie bdf information,
which helps issue debugging especially in multiple GPU
system.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 144 ++++++++++++------------
 1 file changed, 75 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8a3847d3041f..0d871479ff34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -291,21 +291,22 @@ static int psp_memory_training_init(struct psp_context *psp)
 	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
 
 	if (ctx->init != PSP_MEM_TRAIN_RESERVE_SUCCESS) {
-		DRM_DEBUG("memory training is not supported!\n");
+		dev_dbg(psp->adev->dev, "memory training is not supported!\n");
 		return 0;
 	}
 
 	ctx->sys_cache = kzalloc(ctx->train_data_size, GFP_KERNEL);
 	if (ctx->sys_cache == NULL) {
-		DRM_ERROR("alloc mem_train_ctx.sys_cache failed!\n");
+		dev_err(psp->adev->dev, "alloc mem_train_ctx.sys_cache failed!\n");
 		ret = -ENOMEM;
 		goto Err_out;
 	}
 
-	DRM_DEBUG("train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
-		  ctx->train_data_size,
-		  ctx->p2c_train_data_offset,
-		  ctx->c2p_train_data_offset);
+	dev_dbg(psp->adev->dev,
+		"train_data_size:%llx,p2c_train_data_offset:%llx,c2p_train_data_offset:%llx.\n",
+		ctx->train_data_size,
+		ctx->p2c_train_data_offset,
+		ctx->c2p_train_data_offset);
 	ctx->init = PSP_MEM_TRAIN_INIT_SUCCESS;
 	return 0;
 
@@ -407,7 +408,7 @@ static int psp_sw_init(void *handle)
 
 	psp->cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!psp->cmd) {
-		DRM_ERROR("Failed to allocate memory to command buffer!\n");
+		dev_err(adev->dev, "Failed to allocate memory to command buffer!\n");
 		ret = -ENOMEM;
 	}
 
@@ -454,13 +455,13 @@ static int psp_sw_init(void *handle)
 	if (mem_training_ctx->enable_mem_training) {
 		ret = psp_memory_training_init(psp);
 		if (ret) {
-			DRM_ERROR("Failed to initialize memory training!\n");
+			dev_err(adev->dev, "Failed to initialize memory training!\n");
 			return ret;
 		}
 
 		ret = psp_mem_training(psp, PSP_MEM_TRAIN_COLD_BOOT);
 		if (ret) {
-			DRM_ERROR("Failed to process memory training!\n");
+			dev_err(adev->dev, "Failed to process memory training!\n");
 			return ret;
 		}
 	}
@@ -675,9 +676,11 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	 */
 	if (!skip_unsupport && (psp->cmd_buf_mem->resp.status || !timeout) && !ras_intr) {
 		if (ucode)
-			DRM_WARN("failed to load ucode %s(0x%X) ",
-				  amdgpu_ucode_name(ucode->ucode_id), ucode->ucode_id);
-		DRM_WARN("psp gfx command %s(0x%X) failed and response status is (0x%X)\n",
+			dev_warn(psp->adev->dev,
+				 "failed to load ucode %s(0x%X) ",
+				 amdgpu_ucode_name(ucode->ucode_id), ucode->ucode_id);
+		dev_warn(psp->adev->dev,
+			 "psp gfx command %s(0x%X) failed and response status is (0x%X)\n",
 			 psp_gfx_cmd_name(psp->cmd_buf_mem->cmd_id), psp->cmd_buf_mem->cmd_id,
 			 psp->cmd_buf_mem->resp.status);
 		/* If any firmware (including CAP) load fails under SRIOV, it should
@@ -807,7 +810,7 @@ static int psp_tmr_init(struct psp_context *psp)
 	    psp->fw_pri_buf) {
 		ret = psp_load_toc(psp, &tmr_size);
 		if (ret) {
-			DRM_ERROR("Failed to load toc\n");
+			dev_err(psp->adev->dev, "Failed to load toc\n");
 			return ret;
 		}
 	}
@@ -855,7 +858,7 @@ static int psp_tmr_load(struct psp_context *psp)
 
 	psp_prep_tmr_cmd_buf(psp, cmd, psp->tmr_mc_addr, psp->tmr_bo);
 	if (psp->tmr_bo)
-		DRM_INFO("reserve 0x%lx from 0x%llx for PSP TMR\n",
+		dev_info(psp->adev->dev, "reserve 0x%lx from 0x%llx for PSP TMR\n",
 			 amdgpu_bo_size(psp->tmr_bo), psp->tmr_mc_addr);
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd,
@@ -1113,7 +1116,7 @@ int psp_reg_program(struct psp_context *psp, enum psp_reg_prog_id reg,
 	psp_prep_reg_prog_cmd_buf(cmd, reg, value);
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 	if (ret)
-		DRM_ERROR("PSP failed to program reg id %d", reg);
+		dev_err(psp->adev->dev, "PSP failed to program reg id %d\n", reg);
 
 	release_psp_cmd_buf(psp);
 
@@ -1526,22 +1529,22 @@ static void psp_ras_ta_check_status(struct psp_context *psp)
 	switch (ras_cmd->ras_status) {
 	case TA_RAS_STATUS__ERROR_UNSUPPORTED_IP:
 		dev_warn(psp->adev->dev,
-				"RAS WARNING: cmd failed due to unsupported ip\n");
+			 "RAS WARNING: cmd failed due to unsupported ip\n");
 		break;
 	case TA_RAS_STATUS__ERROR_UNSUPPORTED_ERROR_INJ:
 		dev_warn(psp->adev->dev,
-				"RAS WARNING: cmd failed due to unsupported error injection\n");
+			 "RAS WARNING: cmd failed due to unsupported error injection\n");
 		break;
 	case TA_RAS_STATUS__SUCCESS:
 		break;
 	case TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED:
 		if (ras_cmd->cmd_id == TA_RAS_COMMAND__TRIGGER_ERROR)
 			dev_warn(psp->adev->dev,
-					"RAS WARNING: Inject error to critical region is not allowed\n");
+				 "RAS WARNING: Inject error to critical region is not allowed\n");
 		break;
 	default:
 		dev_warn(psp->adev->dev,
-				"RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
+			 "RAS WARNING: ras status = 0x%X\n", ras_cmd->ras_status);
 		break;
 	}
 }
@@ -1565,7 +1568,7 @@ int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 		return ret;
 
 	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER) {
-		DRM_WARN("RAS: Unsupported Interface");
+		dev_warn(psp->adev->dev, "RAS: Unsupported Interface\n");
 		return -EINVAL;
 	}
 
@@ -1715,7 +1718,7 @@ int psp_ras_initialize(struct psp_context *psp)
 		psp->ras_context.context.initialized = true;
 	else {
 		if (ras_cmd->ras_status)
-			dev_warn(psp->adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
+			dev_warn(adev->dev, "RAS Init Status: 0x%X\n", ras_cmd->ras_status);
 
 		/* fail to load RAS TA */
 		psp->ras_context.context.initialized = false;
@@ -2148,7 +2151,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_kdb != NULL)) {
 			ret = psp_bootloader_load_kdb(psp);
 			if (ret) {
-				DRM_ERROR("PSP load kdb failed!\n");
+				dev_err(adev->dev, "PSP load kdb failed!\n");
 				return ret;
 			}
 		}
@@ -2157,7 +2160,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_spl != NULL)) {
 			ret = psp_bootloader_load_spl(psp);
 			if (ret) {
-				DRM_ERROR("PSP load spl failed!\n");
+				dev_err(adev->dev, "PSP load spl failed!\n");
 				return ret;
 			}
 		}
@@ -2166,7 +2169,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_sysdrv != NULL)) {
 			ret = psp_bootloader_load_sysdrv(psp);
 			if (ret) {
-				DRM_ERROR("PSP load sys drv failed!\n");
+				dev_err(adev->dev, "PSP load sys drv failed!\n");
 				return ret;
 			}
 		}
@@ -2175,7 +2178,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_soc_drv != NULL)) {
 			ret = psp_bootloader_load_soc_drv(psp);
 			if (ret) {
-				DRM_ERROR("PSP load soc drv failed!\n");
+				dev_err(adev->dev, "PSP load soc drv failed!\n");
 				return ret;
 			}
 		}
@@ -2184,7 +2187,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_intf_drv != NULL)) {
 			ret = psp_bootloader_load_intf_drv(psp);
 			if (ret) {
-				DRM_ERROR("PSP load intf drv failed!\n");
+				dev_err(adev->dev, "PSP load intf drv failed!\n");
 				return ret;
 			}
 		}
@@ -2193,7 +2196,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_dbg_drv != NULL)) {
 			ret = psp_bootloader_load_dbg_drv(psp);
 			if (ret) {
-				DRM_ERROR("PSP load dbg drv failed!\n");
+				dev_err(adev->dev, "PSP load dbg drv failed!\n");
 				return ret;
 			}
 		}
@@ -2202,7 +2205,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_ras_drv != NULL)) {
 			ret = psp_bootloader_load_ras_drv(psp);
 			if (ret) {
-				DRM_ERROR("PSP load ras_drv failed!\n");
+				dev_err(adev->dev, "PSP load ras_drv failed!\n");
 				return ret;
 			}
 		}
@@ -2211,7 +2214,7 @@ static int psp_hw_start(struct psp_context *psp)
 		    (psp->funcs->bootloader_load_sos != NULL)) {
 			ret = psp_bootloader_load_sos(psp);
 			if (ret) {
-				DRM_ERROR("PSP load sos failed!\n");
+				dev_err(adev->dev, "PSP load sos failed!\n");
 				return ret;
 			}
 		}
@@ -2219,7 +2222,7 @@ static int psp_hw_start(struct psp_context *psp)
 
 	ret = psp_ring_create(psp, PSP_RING_TYPE__KM);
 	if (ret) {
-		DRM_ERROR("PSP create ring failed!\n");
+		dev_err(adev->dev, "PSP create ring failed!\n");
 		return ret;
 	}
 
@@ -2229,7 +2232,7 @@ static int psp_hw_start(struct psp_context *psp)
 	if (!psp_boottime_tmr(psp)) {
 		ret = psp_tmr_init(psp);
 		if (ret) {
-			DRM_ERROR("PSP tmr init failed!\n");
+			dev_err(adev->dev, "PSP tmr init failed!\n");
 			return ret;
 		}
 	}
@@ -2248,7 +2251,7 @@ static int psp_hw_start(struct psp_context *psp)
 
 	ret = psp_tmr_load(psp);
 	if (ret) {
-		DRM_ERROR("PSP load tmr failed!\n");
+		dev_err(adev->dev, "PSP load tmr failed!\n");
 		return ret;
 	}
 
@@ -2516,7 +2519,8 @@ static void psp_print_fw_hdr(struct psp_context *psp,
 	}
 }
 
-static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
+static int psp_prep_load_ip_fw_cmd_buf(struct psp_context *psp,
+				       struct amdgpu_firmware_info *ucode,
 				       struct psp_gfx_cmd_resp *cmd)
 {
 	int ret;
@@ -2529,7 +2533,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
 
 	ret = psp_get_fw_type(ucode, &cmd->cmd.cmd_load_ip_fw.fw_type);
 	if (ret)
-		DRM_ERROR("Unknown firmware type\n");
+		dev_err(psp->adev->dev, "Unknown firmware type\n");
 
 	return ret;
 }
@@ -2540,7 +2544,7 @@ int psp_execute_ip_fw_load(struct psp_context *psp,
 	int ret = 0;
 	struct psp_gfx_cmd_resp *cmd = acquire_psp_cmd_buf(psp);
 
-	ret = psp_prep_load_ip_fw_cmd_buf(ucode, cmd);
+	ret = psp_prep_load_ip_fw_cmd_buf(psp, ucode, cmd);
 	if (!ret) {
 		ret = psp_cmd_submit_buf(psp, ucode, cmd,
 					 psp->fence_buf_mc_addr);
@@ -2599,13 +2603,13 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	      amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(11, 0, 2)))) {
 		ret = amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);
 		if (ret)
-			DRM_WARN("Failed to set MP1 state prepare for reload\n");
+			dev_err(adev->dev, "Failed to set MP1 state prepare for reload\n");
 	}
 
 	ret = psp_execute_ip_fw_load(psp, ucode);
 
 	if (ret)
-		DRM_ERROR("PSP load smu failed!\n");
+		dev_err(adev->dev, "PSP load smu failed!\n");
 
 	return ret;
 }
@@ -2710,7 +2714,7 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 		    adev->virt.autoload_ucode_id : AMDGPU_UCODE_ID_RLC_G)) {
 			ret = psp_rlc_autoload_start(psp);
 			if (ret) {
-				DRM_ERROR("Failed to start rlc autoload\n");
+				dev_err(adev->dev, "Failed to start rlc autoload\n");
 				return ret;
 			}
 		}
@@ -2732,7 +2736,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 
 		ret = psp_ring_init(psp, PSP_RING_TYPE__KM);
 		if (ret) {
-			DRM_ERROR("PSP ring init failed!\n");
+			dev_err(adev->dev, "PSP ring init failed!\n");
 			goto failed;
 		}
 	}
@@ -2747,13 +2751,13 @@ static int psp_load_fw(struct amdgpu_device *adev)
 
 	ret = psp_asd_initialize(psp);
 	if (ret) {
-		DRM_ERROR("PSP load asd failed!\n");
+		dev_err(adev->dev, "PSP load asd failed!\n");
 		goto failed1;
 	}
 
 	ret = psp_rl_load(adev);
 	if (ret) {
-		DRM_ERROR("PSP load RL failed!\n");
+		dev_err(adev->dev, "PSP load RL failed!\n");
 		goto failed1;
 	}
 
@@ -2773,7 +2777,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		ret = psp_ras_initialize(psp);
 		if (ret)
 			dev_err(psp->adev->dev,
-					"RAS: Failed to initialize RAS\n");
+				"RAS: Failed to initialize RAS\n");
 
 		ret = psp_hdcp_initialize(psp);
 		if (ret)
@@ -2826,7 +2830,7 @@ static int psp_hw_init(void *handle)
 
 	ret = psp_load_fw(adev);
 	if (ret) {
-		DRM_ERROR("PSP firmware loading failed\n");
+		dev_err(adev->dev, "PSP firmware loading failed\n");
 		goto failed;
 	}
 
@@ -2873,7 +2877,7 @@ static int psp_suspend(void *handle)
 	    psp->xgmi_context.context.initialized) {
 		ret = psp_xgmi_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate xgmi ta\n");
+			dev_err(adev->dev, "Failed to terminate xgmi ta\n");
 			goto out;
 		}
 	}
@@ -2881,46 +2885,46 @@ static int psp_suspend(void *handle)
 	if (psp->ta_fw) {
 		ret = psp_ras_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate ras ta\n");
+			dev_err(adev->dev, "Failed to terminate ras ta\n");
 			goto out;
 		}
 		ret = psp_hdcp_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate hdcp ta\n");
+			dev_err(adev->dev, "Failed to terminate hdcp ta\n");
 			goto out;
 		}
 		ret = psp_dtm_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate dtm ta\n");
+			dev_err(adev->dev, "Failed to terminate dtm ta\n");
 			goto out;
 		}
 		ret = psp_rap_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate rap ta\n");
+			dev_err(adev->dev, "Failed to terminate rap ta\n");
 			goto out;
 		}
 		ret = psp_securedisplay_terminate(psp);
 		if (ret) {
-			DRM_ERROR("Failed to terminate securedisplay ta\n");
+			dev_err(adev->dev, "Failed to terminate securedisplay ta\n");
 			goto out;
 		}
 	}
 
 	ret = psp_asd_terminate(psp);
 	if (ret) {
-		DRM_ERROR("Failed to terminate asd\n");
+		dev_err(adev->dev, "Failed to terminate asd\n");
 		goto out;
 	}
 
 	ret = psp_tmr_terminate(psp);
 	if (ret) {
-		DRM_ERROR("Failed to terminate tmr\n");
+		dev_err(adev->dev, "Failed to terminate tmr\n");
 		goto out;
 	}
 
 	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
 	if (ret)
-		DRM_ERROR("PSP ring stop failed\n");
+		dev_err(adev->dev, "PSP ring stop failed\n");
 
 out:
 	return ret;
@@ -2932,12 +2936,12 @@ static int psp_resume(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
 
-	DRM_INFO("PSP is resuming...\n");
+	dev_info(adev->dev, "PSP is resuming...\n");
 
 	if (psp->mem_train_ctx.enable_mem_training) {
 		ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
 		if (ret) {
-			DRM_ERROR("Failed to process memory training!\n");
+			dev_err(adev->dev, "Failed to process memory training!\n");
 			return ret;
 		}
 	}
@@ -2954,7 +2958,7 @@ static int psp_resume(void *handle)
 
 	ret = psp_asd_initialize(psp);
 	if (ret) {
-		DRM_ERROR("PSP load asd failed!\n");
+		dev_err(adev->dev, "PSP load asd failed!\n");
 		goto failed;
 	}
 
@@ -2978,7 +2982,7 @@ static int psp_resume(void *handle)
 		ret = psp_ras_initialize(psp);
 		if (ret)
 			dev_err(psp->adev->dev,
-					"RAS: Failed to initialize RAS\n");
+				"RAS: Failed to initialize RAS\n");
 
 		ret = psp_hdcp_initialize(psp);
 		if (ret)
@@ -3006,7 +3010,7 @@ static int psp_resume(void *handle)
 	return 0;
 
 failed:
-	DRM_ERROR("PSP resume failed\n");
+	dev_err(adev->dev, "PSP resume failed\n");
 	mutex_unlock(&adev->firmware.mutex);
 	return ret;
 }
@@ -3067,9 +3071,11 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 		write_frame = ring_buffer_start + (psp_write_ptr_reg / rb_frame_size_dw);
 	/* Check invalid write_frame ptr address */
 	if ((write_frame < ring_buffer_start) || (ring_buffer_end < write_frame)) {
-		DRM_ERROR("ring_buffer_start = %p; ring_buffer_end = %p; write_frame = %p\n",
-			  ring_buffer_start, ring_buffer_end, write_frame);
-		DRM_ERROR("write_frame is pointing to address out of bounds\n");
+		dev_err(adev->dev,
+			"ring_buffer_start = %p; ring_buffer_end = %p; write_frame = %p\n",
+			ring_buffer_start, ring_buffer_end, write_frame);
+		dev_err(adev->dev,
+			"write_frame is pointing to address out of bounds\n");
 		return -EINVAL;
 	}
 
@@ -3595,7 +3601,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 	int ret;
 
 	if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
-		DRM_INFO("PSP block is not ready yet.");
+		dev_info(adev->dev, "PSP block is not ready yet\n.");
 		return -EBUSY;
 	}
 
@@ -3604,7 +3610,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 	mutex_unlock(&adev->psp.mutex);
 
 	if (ret) {
-		DRM_ERROR("Failed to read USBC PD FW, err = %d", ret);
+		dev_err(adev->dev, "Failed to read USBC PD FW, err = %d\n", ret);
 		return ret;
 	}
 
@@ -3626,7 +3632,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	void *fw_pri_cpu_addr;
 
 	if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
-		DRM_INFO("PSP block is not ready yet.");
+		dev_err(adev->dev, "PSP block is not ready yet.");
 		return -EBUSY;
 	}
 
@@ -3659,7 +3665,7 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	release_firmware(usbc_pd_fw);
 fail:
 	if (ret) {
-		DRM_ERROR("Failed to load USBC PD FW, err = %d", ret);
+		dev_err(adev->dev, "Failed to load USBC PD FW, err = %d", ret);
 		count = ret;
 	}
 
@@ -3706,7 +3712,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 
 	/* Safeguard against memory drain */
 	if (adev->psp.vbflash_image_size > AMD_VBIOS_FILE_MAX_SIZE_B) {
-		dev_err(adev->dev, "File size cannot exceed %u", AMD_VBIOS_FILE_MAX_SIZE_B);
+		dev_err(adev->dev, "File size cannot exceed %u\n", AMD_VBIOS_FILE_MAX_SIZE_B);
 		kvfree(adev->psp.vbflash_tmp_buf);
 		adev->psp.vbflash_tmp_buf = NULL;
 		adev->psp.vbflash_image_size = 0;
@@ -3725,7 +3731,7 @@ static ssize_t amdgpu_psp_vbflash_write(struct file *filp, struct kobject *kobj,
 	adev->psp.vbflash_image_size += count;
 	mutex_unlock(&adev->psp.mutex);
 
-	dev_dbg(adev->dev, "IFWI staged for update");
+	dev_dbg(adev->dev, "IFWI staged for update\n");
 
 	return count;
 }
@@ -3745,7 +3751,7 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	if (adev->psp.vbflash_image_size == 0)
 		return -EINVAL;
 
-	dev_dbg(adev->dev, "PSP IFWI flash process initiated");
+	dev_dbg(adev->dev, "PSP IFWI flash process initiated\n");
 
 	ret = amdgpu_bo_create_kernel(adev, adev->psp.vbflash_image_size,
 					AMDGPU_GPU_PAGE_SIZE,
@@ -3770,11 +3776,11 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	adev->psp.vbflash_image_size = 0;
 
 	if (ret) {
-		dev_err(adev->dev, "Failed to load IFWI, err = %d", ret);
+		dev_err(adev->dev, "Failed to load IFWI, err = %d\n", ret);
 		return ret;
 	}
 
-	dev_dbg(adev->dev, "PSP IFWI flash process done");
+	dev_dbg(adev->dev, "PSP IFWI flash process done\n");
 	return 0;
 }
 
-- 
2.17.1

