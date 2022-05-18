Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ACEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 15:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E582C10F3BB;
	Wed, 18 May 2022 15:44:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CCD10F381
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 15:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5gQiRXm00SZG8V+auN4jKd2r3ZI6oR98s4E86pG+owOpY50rzPO4U9tg5GISfkLZFxRPV+ByfPGAMiC/4He+GllibfMqeqhaf36pCY8ICDWkC1ftuaBZ2nhqE02QZYK2kqVYseP07+WlzlQa92KB0Wti1LNPOnG61X/DcB1N/DzSGjpU6GaixPg77QIeSD78yiMznHBInzA+pPqKnZgNVNQR54331Jp8zZfBMRMrYUrm5+YcMx+LXiK8O+gZ7u/PR6/34tXbZtheJCVo3hsRz3XGimecOUveKQ2NZtnezk7zmNtJQLWQQToQ1OoDb5coMvWruFbIf1Ty9p+KmSTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw9UN/aLDf0Og3sp5kE+shSPy7UfDHaLQ3L3yt7XP04=;
 b=LB0gevhDI6dJmbt/14fxPuprriwqbCun8EStQ38XHyPcPhFzDsN4FOvwnp0CPY2qkCGRFGyQEQGfQ25n6capfpB3uGecSEjiSmFErk09jBRwrxzmkEY2Qzu5AYFwMWXsCScO3JgQt84arzVIpcUwQcoySnO/ZizOcG4z1A8wlHy3+reNTklIv4qBHZoTb2avB20YfgQaXYNEK7jJxaXOcKVcR0z5RiJi64zl/dLk45CrRGkFB+MIJYGwKEMTtorxt5jJH1NlT1YoqppMbAZt81m3Ha7TFjL1QbFpFM9vWjlHkjh57B/hrGi6hp0fxu7sWoeElnKqrtmitbvRGJEXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw9UN/aLDf0Og3sp5kE+shSPy7UfDHaLQ3L3yt7XP04=;
 b=nb4dbYS0DEFLErIIravapl5c7e7Q9Gb2xL9OVmH9jmw9EfvnBFoWDsgaiKnz1qb2sGOUZWpmmTpya71mflGu0Rz3o77YgYfC1bYfX9E66Sc5YKwCHM+mDg7QWxv/VJ2Je5K6EUE2CEpVTpg7p+l2HEqkgj4qt9FjeneoFABxgqg=
Received: from DS7PR03CA0193.namprd03.prod.outlook.com (2603:10b6:5:3b6::18)
 by MWHPR12MB1696.namprd12.prod.outlook.com (2603:10b6:301:8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 15:44:34 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::be) by DS7PR03CA0193.outlook.office365.com
 (2603:10b6:5:3b6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Wed, 18 May 2022 15:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 15:44:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 10:44:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 08:44:31 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 18 May 2022 10:44:30 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <tao.zhou1@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: support ras on SRIOV
Date: Wed, 18 May 2022 23:44:28 +0800
Message-ID: <20220518154428.9069-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b838f66e-c51a-4199-abee-08da38e54d98
X-MS-TrafficTypeDiagnostic: MWHPR12MB1696:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB16967633881BE0ADB33A6C649AD19@MWHPR12MB1696.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mi7gbPcMFfxHbhzpUgBzgwtsyfl6ufhZQuF6H0/B5ZvDic/fo9Iff6NDjN/JZNim16gnCjHyRKzCc1LuGGfdDFUmuz0RWIePwqsb44QgPt168t7RzuafltX4E1Dfsyid1NqqMf94N6nEGpE39LgGHk9YIOZOsmMWXNOdJKayId1AS6W/UtnZTZ4V3RVuCdICGztQSEYaZJj4x56RMups5V9kQ0cUWYBxVbLZjXQ0FNEt9J34rp9kn1xHs2kAZc36mH4UmlXS3QaIbuuA45J5YQXe1hef9WEvRy8LYp7uQxDJwIVCKMALawMa9a/3YVEYjq1fuaqzFdcMpFDXvSaBrr5lxt8TXaanftQyWth1H+YjWPXA9M7/MZ9BG0GUAVKrELTKfYFxBpnXAUTR6GdAFe6QDu7ZhD28jivbhqG9APzn9Q/E4fAez1sACJmR23/VBJiQdiBLz0b4pteeHeaWVoS0g7R2wCqRNMYnGxu7t31drgM3yWZWRGjp8vV4emLCKBWnxB262WgwIsftCmhPL9vcHlZh1KarJwYawyOA/5Fz6cFYfM877xya9CdMLw2vup176cWiITV57tYlzvq7y9YTBJ6lSRXRTt6vC1V3WQpyJIuwhbez3HH0BAAQ4cdhXY2h65e8JsdXD7YVyeBvNsUWiMQ9GHUMZEsPpGqrqnSgD+wF+hU1/G+o6+OiDu+IxZPzrJD1SnN1XpCoetKDLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(316002)(8936002)(47076005)(7696005)(40460700003)(2906002)(6636002)(426003)(4326008)(8676002)(2616005)(336012)(110136005)(186003)(1076003)(83380400001)(70586007)(82310400005)(36756003)(26005)(36860700001)(356005)(81166007)(86362001)(70206006)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 15:44:32.5613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b838f66e-c51a-4199-abee-08da38e54d98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1696
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

support umc/gfx/sdma ras on guest side

Changed from V1:
    move sriov judgment in amdgpu_ras_interrupt_fatal_error_handler

Change-Id: Ic7dda45d8f8cf2d5f1abc7705abc153d558da8a1
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 42 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   |  4 +++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c     |  9 +++--
 4 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b583026dc893..ba7990d0dc0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5218,6 +5218,10 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 		r = amdgpu_device_reset_sriov(adev, job ? false : true);
 		if (r)
 			adev->asic_reset_res = r;
+
+		/* Aldebaran supports ras in SRIOV, so need resume ras during reset */
+		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
+			amdgpu_ras_resume(adev);
 	} else {
 		r = amdgpu_do_asic_reset(device_list_handle, &reset_context);
 		if (r && r == -EAGAIN)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a653cf3b3d13..2b28210c4994 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -726,7 +726,9 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 	/* Do not enable if it is not allowed. */
 	WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
 
-	if (!amdgpu_ras_intr_triggered()) {
+	/* Only enable ras feature operation handle on host side */
+	if (!amdgpu_sriov_vf(adev) &&
+		!amdgpu_ras_intr_triggered()) {
 		ret = psp_ras_enable_features(&adev->psp, info, enable);
 		if (ret) {
 			dev_err(adev->dev, "ras %s %s failed poison:%d ret:%d\n",
@@ -1523,6 +1525,10 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
  */
 void amdgpu_ras_interrupt_fatal_error_handler(struct amdgpu_device *adev)
 {
+	/* Fatal error events are handled on host side */
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__PCIE_BIF))
 		return;
 
@@ -2270,10 +2276,14 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 {
 	adev->ras_hw_enabled = adev->ras_enabled = 0;
 
-	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
+	if (!adev->is_atom_fw ||
 	    !amdgpu_ras_asic_supported(adev))
 		return;
 
+	if (!(amdgpu_sriov_vf(adev) &&
+		(adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2))))
+		return;
+
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
 			dev_info(adev->dev, "MEM ECC is active.\n");
@@ -2285,15 +2295,21 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 
 		if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
 			dev_info(adev->dev, "SRAM ECC is active.\n");
-			adev->ras_hw_enabled |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
-						    1 << AMDGPU_RAS_BLOCK__DF);
-
-			if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(2, 6, 0))
-				adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__VCN |
-						1 << AMDGPU_RAS_BLOCK__JPEG);
-			else
-				adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__VCN |
-						1 << AMDGPU_RAS_BLOCK__JPEG);
+			if (!amdgpu_sriov_vf(adev)) {
+				adev->ras_hw_enabled |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
+							    1 << AMDGPU_RAS_BLOCK__DF);
+
+				if (adev->ip_versions[VCN_HWIP][0] == IP_VERSION(2, 6, 0))
+					adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__VCN |
+							1 << AMDGPU_RAS_BLOCK__JPEG);
+				else
+					adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__VCN |
+							1 << AMDGPU_RAS_BLOCK__JPEG);
+			} else {
+				adev->ras_hw_enabled |= (1 << AMDGPU_RAS_BLOCK__PCIE_BIF |
+								1 << AMDGPU_RAS_BLOCK__SDMA |
+								1 << AMDGPU_RAS_BLOCK__GFX);
+			}
 		} else {
 			dev_info(adev->dev, "SRAM ECC is not presented.\n");
 		}
@@ -2637,6 +2653,10 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 	struct amdgpu_ras_block_object *obj;
 	int r;
 
+	/* Guest side doesn't need init ras feature */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
 		if (!node->ras_obj) {
 			dev_warn(adev->dev, "Warning: abnormal ras list node.\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 8e221a1ba937..42c1f050542f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -124,6 +124,10 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
 		struct amdgpu_iv_entry *entry)
 {
 	kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+
+	if (amdgpu_sriov_vf(adev))
+		return AMDGPU_RAS_SUCCESS;
+
 	amdgpu_ras_reset_gpu(adev);
 
 	return AMDGPU_RAS_SUCCESS;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index d6d79e97def9..18014ed0e853 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -85,9 +85,12 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
-		err = psp_init_ta_microcode(&adev->psp, chip_name);
-		if (err)
-			return err;
+		/* It's not necessary to load ras ta on Guest side */
+		if (!amdgpu_sriov_vf(adev)) {
+			err = psp_init_ta_microcode(&adev->psp, chip_name);
+			if (err)
+				return err;
+		}
 		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
-- 
2.17.1

