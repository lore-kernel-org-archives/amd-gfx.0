Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED48C021B5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 13:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B9E10E39E;
	Mon, 24 Feb 2025 13:41:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgQtD3Q5";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8126310E11D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 02:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7PezxKKBpM3jLoqEz30i8VVLvWtbYxqWUgkPzOtk3gYLc7uKADqfwKrdsBMhiCPWPD0vNl3kq8AttlZGAJ+BZDV7q/lV8psYtLYCJVBYd4JvN//V46DPUp76LW6CYkmiCEAQvWYeV2lXaaRDOBMJw5SLuQaVt9qkQzcSuRkPLksFsDTPjP7KyBNtJZMby5pqmkmMDfwYmv5CNrOV9c/pC3EHRHOH0M2yeTCZatC/c/eCl53/VI/V6CNmu0ZWylKF7ZEDUYEvOMCQ15wyrX0n6SxwUyz7pnpelpAPnywLBrnhednm3VssCwg5wdyGUISj9920pjntUcOsCe3QZxp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+VPME39vSSycu/5CtBbe+CVkmIcVZt88wLiIZ867kE=;
 b=ckACs1Rh1PVvJx/Zeb4ENsmErfNEbltfX3vzj6QFIGTlt50KW4VFzLsdacSDkRzSnFFye2Fg9BN2WYNeM1j4lpD10DTk6CMPxQaKMnZTb922x+Ze7WmscAIOqEGGJwC27CO7eICO8UQlF/pSwHkfdeZdCVHRPobQM1RIf+m7193TzV7dkhySykrGq0Tw+mQTY1VrVoKQoJ0cMAiQ7ywGCQeGdL8v7EMlxWhZuOoXRjfmKN+aNK0BfnlDlO4KEX1tXuRhKZID2DrXEb4g3sispBSYkCYeY7f6ioZao1BiXqAO/6aMdCl0fdUEHaUg69K+EZh+vwr0pCzMlYCeLLAxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+VPME39vSSycu/5CtBbe+CVkmIcVZt88wLiIZ867kE=;
 b=lgQtD3Q5kLhh4ATwSKZqH4fxJf6dLFhJB2+WlZGCikmZ2Yw8yTgwhk0i6A74IxSe4Qe1XsL5cmDRsSzkeaDonhVIFpARjTWIZh8L3/4996exgotrQy88U6HpnCRd0ZWXrMUwBAX6izPadnJy7NSyBO3vNz0tikKZxVV8E4e6tiM=
Received: from MW4PR04CA0062.namprd04.prod.outlook.com (2603:10b6:303:6b::7)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 02:46:44 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::86) by MW4PR04CA0062.outlook.office365.com
 (2603:10b6:303:6b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Mon,
 24 Feb 2025 02:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 24 Feb 2025 02:46:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 23 Feb
 2025 20:46:42 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 23 Feb 2025 20:46:35 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Jiadong Zhu
 <Jiadong.Zhu@amd.com>, Tim Huang <tim.huang@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update SDMA sysfs reset mask in late_init
Date: Mon, 24 Feb 2025 10:46:35 +0800
Message-ID: <20250224024635.4101253-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a84fc8-02d5-46b2-de36-08dd547d7906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X6OTBMB5iTQY+jDAVQAbDDsKsV8AnMjYbUxAKEm7mzt4pmaeT3WjSbV9PWyN?=
 =?us-ascii?Q?Bhg7Itc1pghFicJ+fb45z077RrDLhQq5Z0vw7wGNkoOZIdf+kB05T3y+k0BE?=
 =?us-ascii?Q?N4DqTUPzOwHr8uJD37n+w8r1MZ5sWN70CewHUC+XEPPEjqBM/BAjbhoEHtMF?=
 =?us-ascii?Q?0ULM+7O8eEe0cEUNCa6JyzeXXmfMrShZtZ5tKggwENYljEOJX4Hs6YTQv9H6?=
 =?us-ascii?Q?GfLLgIx1ma+60veHaYQiAEo0rDYy8xEZFvpkIkTAryy6D1JqlBfn3eCzLucS?=
 =?us-ascii?Q?f9JNvwiBzNhOksTCpR8KFP247WLQBdrViyME9dOMkacHG9J7NbAxovocIglp?=
 =?us-ascii?Q?u/PP2W2Iwa8QrW5efpm/dQKKkxPw9/hKs+hYveRXbNUWpIqlDPIof8V/Tk+z?=
 =?us-ascii?Q?O7cumuj5BqGk4/fWcIFGd0WejV5UbdyHQ2RF1onym5VMDY/dpAZPEFCggK43?=
 =?us-ascii?Q?LiYAk36L+T6PGMJzIL9JOYX+RNS3PrZwVjS7UODF1clKqRg6lH/6RsOcNzQ0?=
 =?us-ascii?Q?iYtdsQD1KH9HkotXcjpkStofSUgEkttYPHZ8Vdp5/JMsycrPtbsGsrppiIvk?=
 =?us-ascii?Q?AV7QQ2IP2GBdWGrVfnHzZexFvUTA7zWroQAZmTskXCgzcuWaheU2RD9f+5V7?=
 =?us-ascii?Q?wX3Fh9cskk6n7uDlLWaykpGa9mOiHIdf44xQkeuDgNdJft7vJKkFPgUaFCue?=
 =?us-ascii?Q?wk0+IorKyiqMI/DB/qrJbxNpXRLvTBw6n6gqmaatRMQGF1apznjmJPVLr7RQ?=
 =?us-ascii?Q?TpFo2BvwSp77koFV/VBXBbOZE1gL98cpToLOyZfLhwA2eHM2rEP2VrA3un3Y?=
 =?us-ascii?Q?eUYyTOae6fZ032FPJyC2oe/IMoR8VX2vgrwESPA65lkx0HxIGmQHoBlWtRAh?=
 =?us-ascii?Q?A0vEmB2wpAONm3iywJJRZXZK+OrraMEH5uUEKVegGM0k0Vy42fRZUuKHDqOE?=
 =?us-ascii?Q?cIJIKBTfSDh1WqpMF3WN9hOruO7UxaKGl4PYAG2rl8gdQSdoYRbYKHUkAebB?=
 =?us-ascii?Q?cu27XjoYYfnSALbPQnBEhdvDoIZi8+uWQw+0YsLTfeo5zz5wm+beKU07uadm?=
 =?us-ascii?Q?AiQ0w/j/oy3OuciuIedMM4vLWXJYD8Rz2fAs88KTFhVEPREbT9E6S4J/AtDb?=
 =?us-ascii?Q?+GL3bJ6Qfjng6qT9fxqn8AcPwCoexbyc9GwbMMdOI16otIH5tuN4W3oS50uv?=
 =?us-ascii?Q?9kkn1uGWRo3lgB02/ynKQJcePSz3hGeQi5EGy38g8qbRE2SNc+ffM/gXuFIW?=
 =?us-ascii?Q?szQ7z+X6XDgwW4APVLGmiIVlm743vok6UJZLqm2iO4f4Qbb7OzltUtKbxVHz?=
 =?us-ascii?Q?rWpB4Cm1Et3rT9BqEELMXJUusWBexi0PvkC2aVAGCcqpzYu4OirhCDBsVnTF?=
 =?us-ascii?Q?O1IhhRVQFPafLtw5PDPdI5W7jFWS0bSn8j+IhXemp7v7y3iTXvLFIoRnOcLz?=
 =?us-ascii?Q?B1iiEkd7itLcX898/XroFTnVsArPLyljZmQoNptLdF1Bn0TJEQQy2g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 02:46:43.3054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a84fc8-02d5-46b2-de36-08dd547d7906
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

- Added `sdma_v4_4_2_update_reset_mask` function to update the reset mask.
- update the sysfs reset mask to the `late_init` stage to ensure that the SMU  initialization
     and capability setup are completed before checking the SDMA reset capability.
- For IP versions 9.4.3 and 9.4.4, enable per-queue reset if the MEC firmware version is at least 0xb0 and PMFW supports queue reset.
- Add a TODO comment for future support of per-queue reset for IP version 9.5.0.

This change ensures that per-queue reset is only enabled when the MEC and PMFW support it.

v2: fix ip version (9.5.4 -> 9.5.0)(Lijo)

Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 37 +++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 4fa688e00f5e..ba43c8f46f45 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -107,6 +107,7 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
+static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1374,6 +1375,12 @@ static int sdma_v4_4_2_late_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_persistent_edc_harvesting_supported(adev))
 		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__SDMA);
 
+	/* The initialization is done in the late_init stage to ensure that the SMU
+	 * initialization and capability setup are completed before we check the SDMA
+	 * reset capability
+	 */
+	sdma_v4_4_2_update_reset_mask(adev);
+
 	return 0;
 }
 
@@ -1481,7 +1488,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
 
@@ -2328,6 +2334,35 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev)
 	adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;
 }
 
+/**
+ * sdma_v4_4_2_update_reset_mask - update  reset mask for SDMA
+ * @adev: Pointer to the AMDGPU device structure
+ *
+ * This function update reset mask for SDMA and sets the supported
+ * reset types based on the IP version and firmware versions.
+ *
+ */
+static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev)
+{
+
+	/*
+	 * the user queue relies on MEC fw and pmfw when the sdma queue do reset.
+	 * it needs to check both of them at here to skip old mec and pmfw.
+	 */
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+		if ((adev->gfx.mec_fw_version >= 0xb0) && amdgpu_dpm_reset_sdma_is_supported(adev))
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	case IP_VERSION(9, 5, 0):
+		/*TODO: enable the queue reset flag until fw supported */
+	default:
+		break;
+	}
+
+}
+
 const struct amdgpu_ip_block_version sdma_v4_4_2_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_SDMA,
 	.major = 4,
-- 
2.25.1

