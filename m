Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1483C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 13:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F1D710E458;
	Tue,  9 Jan 2024 13:00:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 226DA10E457
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 13:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNo0HfTENEDKibHbHqAj/moStpxJg4MiwnIel+8eMy0Iog2/4TgqzmjF4NAx7K4Q7PqjSDt0yXjL4WLliLCIUL+/fGpt5SbrMNVnWEJ8WnTJX3lfO+37tZIDn8vboYKOXcoQhqdlwW+BROrLiXerBz7ZmszfMefBEtAkasY47S+/zgtr0A7ESC+tmWCmMMUOvVuz9HSZ0Zs/705vk3LpCuqjyHkcexG1gN/bddlo6w//f8FNb/J3Io6GU1YQknbW8bOZ7cKcuTZaLMSfrArH0MEOmRnBejxZBDW6+jV0rxKv+ZrZytgVorrDjHA8bCD42DcPEkcmqGtGq5YYTMDMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onnsUWyzmYr3XTuuBXuHNjpbpUeMj3dT2foyw18agBE=;
 b=jJZ2faFWu9P2x4P1Ex9Fg17jUzItGiTBjMeeSpq2QaCetrzsTJuEKoUDhzAIZP8mIhLIjaIw8xb+fP1vbXZZJkPKXKnJXZgeZTcc3ANe0Cr0k0hJDegCTYFAo0joQZn9lLskT01nLfqHkBWFzXxET3iyYBbPwHdumn2czy3Wh7fTGzI3O9fj4GmT4wfApXHRa1pMeqpuws/8EAMPfABw2iFrRFbyjzKQyEqispzlEEU5E3JCOnKs7ALoweTSCBOHAEuMazDnDC4zh0w7CNdxP6i5i05/OUCLqTnBSLldW5/7VaXoQUZNtM+AJraMG4cATfoF2qZbNsxx5st9zOz66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onnsUWyzmYr3XTuuBXuHNjpbpUeMj3dT2foyw18agBE=;
 b=UFz8SMrkcvgZk7ligwP6XCQ7xkw/WI7bwvLvFWYPwJyy1U3nyQHbEb9EnJ6E156rcjoFiytgaho+HW4+f+j2LxjG+DNa4le0Ue/+YzNQ3fTUPYNFNQF0T9Jw5HDORvupj2Jxqp2G2Ymo40rUskCVqIMRSXp9it8jzx2/Ktijy+k=
Received: from CY5PR18CA0008.namprd18.prod.outlook.com (2603:10b6:930:5::11)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 9 Jan
 2024 13:00:26 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::68) by CY5PR18CA0008.outlook.office365.com
 (2603:10b6:930:5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 13:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 13:00:25 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 07:00:20 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3 v2] drm/amdgpu: add debug flag to place fw bo on vram for
 frontdoor loading
Date: Tue, 9 Jan 2024 21:00:08 +0800
Message-ID: <20240109130008.30294-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 0834ad6a-549e-416d-e446-08dc1112f2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0daeYqpgjwjcyKo8nXHzd+CFPALGCT1CgbBCbpbYuqJw7mSTeUY/ZkbJWfyG9lGTXm3AVrKZ5me9d89UGziGGgw6p08HVRzvDiq6HI/3zozl04qJVvHj/JRb6aXYOuNUXO/qa6Vg8FfcmPH/t2XBiQABL9VP8Fjimq8BhUIe+WDOcmRKfin+fCuVGoQDuPxMUeksE6KokSzFcMcCTilULVv9xVhC9iYUaLbJXugUuee9Qg4HvOQSPNnkUtyYbcycm37KnvF3mAnZBjCr9sFEwL6anwTGSo58iFAOoQFBuwuYy+HTFMrDVXNsIcrY8URc5hjpQh31qbJyT3eGzMTkwwL5GiEs6fZTZFHewWVPnX/waERfOoyfhFduOy9WGryrpOycUrLsbRnFAhKK0/QdC2xj66WJ9UxrBlC65wrV4gMFkrEykDSV3GlMJLnTZ/HCXSG0fhqmpAiaXfwWAFbnpJi3PZKZEiSWU3DxUsWD0wLY72TTNxNn96Vy9LwOmbOiQfup5vZXyffgh2HpQ6zjHMexMZDxNdgo/nyjZUS/uZfSFBHda3RoO4MbYXedxzfwnJNcXoopLf38iwTzWhss19oMc+TVnHsBY6gZhBaQSIj4qyJ0UDEOs3rbWAh3HEit4oE1SFijb0nySTiJyZb6x2ESqiqjf4vjXP1YFm9yLqEspbRpo0xDJd8V0IMPi9ojS27l3hkWujYpsIUVMiLSkOzz0EwFiakuzOvP5STzj+fGcMTR5i+z2bjXAHowS70H2UBWIkjh3TX/fHba23G8rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(16526019)(83380400001)(26005)(426003)(336012)(1076003)(86362001)(36756003)(81166007)(356005)(47076005)(4326008)(44832011)(5660300002)(6666004)(7696005)(2616005)(82740400003)(36860700001)(6916009)(8936002)(8676002)(316002)(54906003)(70586007)(70206006)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 13:00:25.9271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0834ad6a-549e-416d-e446-08dc1112f2cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
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
Cc: Lijo.Lazar@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use debug_mask=0x8 param to help isolating data path issues
on new systems in early phase.

v2: rename the flag for explicitness (lijo)

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 3 ++-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 616b6c911767..3d8a48f46b01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1144,6 +1144,7 @@ struct amdgpu_device {
 	bool                            debug_vm;
 	bool                            debug_largebar;
 	bool                            debug_disable_soft_recovery;
+	bool                            debug_use_vram_fw_buf;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 880137774b4e..0776b0c5e4e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -128,6 +128,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_VM = BIT(0),
 	AMDGPU_DEBUG_LARGEBAR = BIT(1),
 	AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY = BIT(2),
+	AMDGPU_DEBUG_USE_VRAM_FW_BUF = BIT(3),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2117,6 +2118,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: soft reset for GPU recovery disabled\n");
 		adev->debug_disable_soft_recovery = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_USE_VRAM_FW_BUF) {
+		pr_info("debug: place fw in vram for frontdoor loading\n");
+		adev->debug_use_vram_fw_buf = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 51bfe3757c89..215994409ac1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -467,7 +467,7 @@ static int psp_sw_init(void *handle)
 	}
 
 	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-				      amdgpu_sriov_vf(adev) ?
+				      (amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
 				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 				      &psp->fw_pri_bo,
 				      &psp->fw_pri_mc_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 0efb2568cb65..3e12763e477a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1062,7 +1062,8 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 {
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
 		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
-			amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
+			(amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
+			AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 			&adev->firmware.fw_buf,
 			&adev->firmware.fw_buf_mc,
 			&adev->firmware.fw_buf_ptr);
-- 
2.38.1

