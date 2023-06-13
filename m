Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93363C7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 03:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E1A10E136;
	Tue, 13 Jun 2023 03:53:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB7510E136
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 03:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vnw2702JRCSWlTgHSjG9Djk/44KqSXSfU7tbfL9MFY9/2t4e3OsEkMHTe81esNn+upjUoDUc+uJiI5wXTbuJV65UFJBVpVnkRsQLTSE8Ah6EqtMAGWM9W7VubvQ3+Vv4o+VeaKaz2YWbK5tGgxtRzPa9XIYPk2fZfWktfnAwMCH+3RYRM98KFrR3EGYU5BgL8/bL6ohE0C/z/KiHywewJ2DdreZgTlhZcEEqHnagTZ1siTF6Q9mA3XVRlMrZESLlSVnD7chnwM0XPQr3x5rTvYb4qgr5AuooE4wRUm75AhWBsjmmGKhzSH0SFcR1UVfbQ2Ou6KfWF6a78KpVT1s64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TW+vFjFLHg4/odBoVZS+3pa272iLE4Rlbx2RaPK9VGY=;
 b=IOCdvp4+Sjbr053F+p2Id232K12H98b4eofeYJqh7Fm2rES4YyoSVrAJLLONHvxyy7ZXwWLmK4QnbRS9Nd0xS8sSyJ27wKttP++0GCh85QctcnUuKB+nzAvol/galX7fKKoy82lUelDXyoyw2p6WRpBB00PZ/QIFFur4reQa/pmk5S2E8JofChMVlrvVTOtlIuOINLmsEUyVSvGL8kAK0fzLJBE2LHvv1c/NqB+6c0IMYPSQptvGMsYhjNZwnWsKn7awcne1YRdfWfqQlN4xoea1d+6FmdvR/6X1ZeCmmufdYoPDbNNVRq1lGOPbnkyaCQZThq2Gy5B8x+qvuuAPCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW+vFjFLHg4/odBoVZS+3pa272iLE4Rlbx2RaPK9VGY=;
 b=j0uogCnp3ZXN+VNnn9MnYaWToj25C7dgf65ZuBO1Hfjaf3YamENPmewZLm06lBvk5SKTv9DpQiDou15VSRSDpqpT8Z0FeoVAQ8mvxoO7+fsN0CM8qpNVBetmcR+afguNE8ZvaCTHgsgLNqJTDzvz5PXTXcw8t7tUNpKDCVNRARo=
Received: from MW4P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::15)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 03:53:27 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::21) by MW4P223CA0010.outlook.office365.com
 (2603:10b6:303:80::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Tue, 13 Jun 2023 03:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Tue, 13 Jun 2023 03:53:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 22:53:21 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 12 Jun 2023 22:53:20 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>
Subject: [PATCH Review 1/2] drm/amdgpu: Optimze checking ras supported
Date: Tue, 13 Jun 2023 11:53:17 +0800
Message-ID: <20230613035318.10613-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: fc76d5d3-ec9a-4c3b-6ac4-08db6bc1bde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M54ZRNF2q78GhCwCrhUeIGh2SLc+xfreR+Xqjd444mQSBUdme0e5chK1Q1t3x9ahUEQP20fEy9O73IPlttZBlPN5NHD1QfHx5KcStZrN8TWC8qCiAIN9rO3qkbfCLiTm7mcc8k0FOkLERA540iQovvulwaoIcIhUQufd5m7bpXYfpv21VHI42mmdXdDR1tN9uV3h5y6VvhcXBSXTBhWNr0IUQW7nSg7UrKsyTk8Em2ZY/f0dKtSCIyM9doLOg5MErF8nA0ccYGe6JhwTPI3BJT8xuC4t3PTC3M8hxkJSIBNzQ/McLSIxXlWuZl6GwZUCBo42tn0IaYOpJCtHdKVd+CuV8am7HcGM7pZLdxQbPE1Lgvb06hGsftveT4SOL+NvEcPQU8a4G9OIUnSH0b6zROCYpkbxy6qAp91K4ApQv5nEmb0OwRkHtmvvsQ9vrd1qH3SC4fLjAfWpXdJjoZrZreze6m2YU+RDWeeYPWK1UpQFzjApuHxiS4uE9ZYETXMutbpdnncosvc/7s07F/RwAvOaCLExDZ4s5NUueenoX00415i7DOnaGYEL1fYM7H+YSQkvN/FnZvykBknM8vkAVJFL+UhZKihpOm5awOOo/zRmbWh2an4f32Zim7WV9X5aBEGG3Wuzyo8Q7iSgkO4nJ5mj9/NT0VC+14oaTSPxsIntB8eDQo5EX6kSK5XrP4YZEGacJMU5o6KoehHX+iYOGDcL9CzfdS3akSa3F6wZLO2OwCgaOVge24JUuTShykk0BX+g3kW+xlNXijkLhNCHog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(316002)(7696005)(40460700003)(41300700001)(426003)(336012)(2616005)(86362001)(82310400005)(26005)(186003)(1076003)(47076005)(36860700001)(83380400001)(2906002)(81166007)(82740400003)(356005)(40480700001)(36756003)(5660300002)(8936002)(8676002)(70206006)(70586007)(4326008)(478600001)(110136005)(6636002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 03:53:26.0440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc76d5d3-ec9a-4c3b-6ac4-08db6bc1bde5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Using "is_app_apu" to identify device in the native
APU mode or carveout mode.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  8 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 34 ++++++++++++++-----------
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 78bacea951a9..352e958b190a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1653,7 +1653,7 @@ int psp_ras_initialize(struct psp_context *psp)
 
 	if (amdgpu_ras_is_poison_mode_supported(adev))
 		ras_cmd->ras_in_message.init_flags.poison_mode_en = 1;
-	if (!adev->gmc.xgmi.connected_to_cpu)
+	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
 		ras_cmd->ras_in_message.init_flags.dgpu_mode = 1;
 	ras_cmd->ras_in_message.init_flags.xcc_mask =
 		adev->gfx.xcc_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7a0924469e4f..56bb0db207b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1689,8 +1689,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 		}
 	}
 
-	if (!adev->gmc.xgmi.connected_to_cpu)
-		amdgpu_umc_poison_handler(adev, false);
+	amdgpu_umc_poison_handler(adev, false);
 
 	if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumption)
 		poison_stat = block_obj->hw_ops->handle_poison_consumption(adev);
@@ -2458,11 +2457,10 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 {
 	adev->ras_hw_enabled = adev->ras_enabled = 0;
 
-	if (!adev->is_atom_fw ||
-	    !amdgpu_ras_asic_supported(adev))
+	if (!amdgpu_ras_asic_supported(adev))
 		return;
 
-	if (!adev->gmc.xgmi.connected_to_cpu) {
+	if (!adev->gmc.xgmi.connected_to_cpu &&	!adev->gmc.is_app_apu) {
 		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
 			dev_info(adev->dev, "MEM ECC is active.\n");
 			adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__UMC |
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 1edf8e6aeb16..db0d94ca4ffc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -169,27 +169,31 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset)
 {
 	int ret = AMDGPU_RAS_SUCCESS;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		if (!adev->gmc.xgmi.connected_to_cpu) {
-			struct ras_err_data err_data = {0, 0, 0, NULL};
-			struct ras_common_if head = {
-				.block = AMDGPU_RAS_BLOCK__UMC,
-			};
-			struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
-
-			ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
-
-			if (ret == AMDGPU_RAS_SUCCESS && obj) {
-				obj->err_data.ue_count += err_data.ue_count;
-				obj->err_data.ce_count += err_data.ce_count;
-			}
-		} else if (reset) {
+	if (adev->gmc.xgmi.connected_to_cpu ||
+		adev->gmc.is_app_apu) {
+		if (reset) {
 			/* MCA poison handler is only responsible for GPU reset,
 			 * let MCA notifier do page retirement.
 			 */
 			kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
 			amdgpu_ras_reset_gpu(adev);
 		}
+		return ret;
+	}
+
+	if (!amdgpu_sriov_vf(adev)) {
+		struct ras_err_data err_data = {0, 0, 0, NULL};
+		struct ras_common_if head = {
+			.block = AMDGPU_RAS_BLOCK__UMC,
+		};
+		struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+
+		ret = amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
+
+		if (ret == AMDGPU_RAS_SUCCESS && obj) {
+			obj->err_data.ue_count += err_data.ue_count;
+			obj->err_data.ce_count += err_data.ce_count;
+		}
 	} else {
 		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
 			adev->virt.ops->ras_poison_handler(adev);
-- 
2.17.1

