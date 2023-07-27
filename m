Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88578EB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 03:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6E710E0D5;
	Thu, 27 Jul 2023 03:53:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E5310E0D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 03:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZWiebZShtuWrr+apBYFu2bWJXjYivV777HuREocmf+tvQqBPuZ21adrIBBdInqoLSAvIve1JPaKV9+pZ9N/oQb5FNH8IkKLiJ2BcJslLXPZkv8Eu4Wucb2LUxbBR8NjP/CmFLvs6eNXA+UvFjH6/cfoXKgYT1Jrkx6Y9+UsAk9kEo2HbRvkbZRKZ7FC+AD0U4uG5I+emMR0kH0/6hkjjynsDXEg4FTZYkQJmCdtoJcGI6+cJ1gMiPeeQb2IHC83R2CyCBKMuECERx0gXgtQos8DgrKtNEHCpfBMew8p+P6+nxuFHwzTP7y226+xX5RmiwduHQUR6npA0VC6mvMCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHFDW4aDgaDN6iNapMRsHnqi4Lq5D24f/BnVrm675MQ=;
 b=Z8osWVF3mfx/vWVMj9QLOkZ/V/bzlaVeoIN+UStSenHVzwP6p4QZDBv7g9UzUvDlbep4Hi6uqFnE0KeKXdeuV1jIpFPfIPAJQECWL1sebf5igKWpLkPA5DasvYj1SB47Z1FJ+6klNbrrucNMFiqxTyfuFZ5j86JQimaWbsgj+oHwLcuVVKogI2t7hG7A/p2nMx5zhD/4ilJRIecZH1DhPYg+4AHlrX6ZHcjDBV+rXHkjkBfm0ImlbkMVPgZdLTQcOw2LFia5qL32pNN59IshzFyfMA+9PnW3a7Ob5QBAxOiX1C1klFGIz4Do7z+7L2gd6SxxT00iXH6jZnR3whYodQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHFDW4aDgaDN6iNapMRsHnqi4Lq5D24f/BnVrm675MQ=;
 b=2Bc2jP7K+4Tx2W4dAcyLMU+GOG9UQu7WC3NYN6k6Ux3XXHK9rX4ED6iO4m1+JE3X4/6oF9yvUM88oeke0sFOcsGaiIASXZcIEU/ech2Lq1M6AhmoZdpsFhnFkH3wVyAfi38hFRYUYgB1/wJomCWvLECJDSG60218KyhCDTKU9nQ=
Received: from BN9PR03CA0758.namprd03.prod.outlook.com (2603:10b6:408:13a::13)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 03:53:32 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::87) by BN9PR03CA0758.outlook.office365.com
 (2603:10b6:408:13a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 03:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 03:53:32 +0000
Received: from pswarnak-Sharkstooth.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 22:53:30 -0500
From: Praful Swarnakar <Praful.Swarnakar@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Fix style issues in amdgpu_psp.c
Date: Thu, 27 Jul 2023 09:17:25 +0530
Message-ID: <20230727034725.2323611-1-Praful.Swarnakar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e8e236-9484-4ad0-7c05-08db8e550bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8/OTEgK88yFXXSAUnpyjmDbRnm//iqdmbgRzjVm+4otEBmaxY0D8I37+4Wa6YecugK2CkUek8u8DExdlfY0KiBnR9/3lBRJoYrKA4DeK7LmjRTOLmT4lKqMSsCISnXQZCjeYc1TZV7H7MJBrA0ombFcyDDbJK089yCXqozLIw0JsI3LCtI/9+mA75tp1FVEG+cG+ujNZfEXiqf2KKeO6lytQxDWSpIr5CX1HpooGn6zhlS9CK485Bvqddnj0YylgNp+FnYFIfc4t5n8lIcNC2sRX4uxpkS3AiPIdZ6DQ6V8J5FOrl4yTyODrpNDWl62ixnUiVVjxEVGhgLxZ+z3BLFyjszWM2zWByPwIBzxOdkCEucJP2d0dYL2p3iM541KvMeNp4mJKHJxczkD95jB6JBuycoeNP8IWiEvLpwZk90Qwq9q6/EbT5tkheQLxAyimcC2+HgbbhdPjBajg/9KiSYL7e9k06PheR/kCewMJ7qc6PBsgTZNesa1XpA2o8t2PSCxMEqbWkMZpV7SUSj/9IkJH3P/s2EBN/5HZH24NmipDLNi88qq8uEvwut6982IJbkAGHjZQFnE6nQ6GuJxAU9TiMh1HPegD2AJv4nngMi4A87YZFLe1+t0rJrnBYwffLWQ0krfOCVTzZZ4ezNGPeC3A0XZ3scVLzQWL9sXBRH//ZgjWzS41bwTtVl4inai/hojVpZ7h/6oy6fW5t2CPZpfQq/MXQF+HKZo5Qx9m8xz2eWjBev5GDr+GaiZESge9rq8wayI3oSzrsdNkIBNlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(54906003)(110136005)(6666004)(7696005)(26005)(36860700001)(83380400001)(478600001)(36756003)(40460700003)(86362001)(40480700001)(2906002)(356005)(2616005)(426003)(47076005)(66574015)(1076003)(16526019)(186003)(336012)(82740400003)(81166007)(4326008)(316002)(6636002)(70586007)(70206006)(41300700001)(8936002)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 03:53:32.2658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e8e236-9484-4ad0-7c05-08db8e550bb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
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
Cc: Praful Swarnakar <Praful.Swarnakar@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following to align to linux coding style:

WARNING: Block comments use a trailing */ on a separate line
WARNING: Block comments should align the * on each line

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Guchun Chen <guchun.chen@amd.com>
Signed-off-by: Praful Swarnakar <Praful.Swarnakar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 28 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4e428060a1fa..1d0516e904b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -438,14 +438,15 @@ static int psp_sw_init(void *handle)
 			/* If psp runtime database exists, then
 			 * only enable two stage memory training
 			 * when TWO_STAGE_DRAM_TRAINING bit is set
-			 * in runtime database */
+			 * in runtime database
+			 */
 			mem_training_ctx->enable_mem_training = true;
 		}
 
 	} else {
-		/* If psp runtime database doesn't exist or
-		 * is invalid, force enable two stage memory
-		 * training */
+		/* If psp runtime database doesn't exist or is
+		 * invalid, force enable two stage memory training
+		 */
 		mem_training_ctx->enable_mem_training = true;
 	}
 
@@ -797,7 +798,8 @@ static int psp_tmr_init(struct psp_context *psp)
 	tmr_size = PSP_TMR_SIZE(psp->adev);
 
 	/* For ASICs support RLC autoload, psp will parse the toc
-	 * and calculate the total size of TMR needed */
+	 * and calculate the total size of TMR needed
+	 */
 	if (!amdgpu_sriov_vf(psp->adev) &&
 	    psp->toc.start_addr &&
 	    psp->toc.size_bytes &&
@@ -1137,9 +1139,9 @@ int psp_ta_init_shared_buf(struct psp_context *psp,
 				  struct ta_mem_context *mem_ctx)
 {
 	/*
-	* Allocate 16k memory aligned to 4k from Frame Buffer (local
-	* physical) for ta to host memory
-	*/
+	 * Allocate 16k memory aligned to 4k from Frame Buffer (local
+	 * physical) for ta to host memory
+	 */
 	return amdgpu_bo_create_kernel(psp->adev, mem_ctx->shared_mem_size,
 				      PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM |
 				      AMDGPU_GEM_DOMAIN_GTT,
@@ -1728,7 +1730,8 @@ int psp_ras_trigger_error(struct psp_context *psp,
 		return -EINVAL;
 
 	/* If err_event_athub occurs error inject was successful, however
-	   return status from TA is no long reliable */
+	 *  return status from TA is no long reliable
+	 */
 	if (amdgpu_ras_intr_triggered())
 		return 0;
 
@@ -2577,7 +2580,8 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2 ||
 		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3))
 			/* PSP only receive one SDMA fw for sienna_cichlid,
-			 * as all four sdma fw are same */
+			 * as all four sdma fw are same
+			 */
 			continue;
 
 		psp_print_fw_hdr(psp, ucode);
@@ -2642,8 +2646,8 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		if (adev->gmc.xgmi.num_physical_nodes > 1) {
 			ret = psp_xgmi_initialize(psp, false, true);
 			/* Warning the XGMI seesion initialize failure
-			* Instead of stop driver initialization
-			*/
+			 * Instead of stop driver initialization
+			 */
 			if (ret)
 				dev_err(psp->adev->dev,
 					"XGMI: Failed to initialize XGMI session\n");
-- 
2.25.1

