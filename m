Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEB5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 21:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5483D10E232;
	Mon, 14 Mar 2022 21:10:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0663210E232
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 21:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjqWnkV8sKKEKiqpVeGiCVnHkjBR82DOzdBSqWon8C0OXXRABSGU++5tV8QbJd0VLhivsgXZavVARaoA0qIGpXNHUolJuxZLnP8Nhc/dCyaSlzH6BpFAw8t5gVT/HabYJFZTsQ8xxbCbwPX685K/MVp9CEJai4optuRIc1FV/G8/g6OhAr8G8I2aLIV/irB290whCEYjKIdiYyJbMYiglo+Zn5UoK4rtSxz7rVvrY1Ps4I2ZuIPNofeuzlvF+JcU5KoUCQVQGqAan8exDDd2xYppH9fwVeim0naKQjIKQn7iKn1k4tGgYJec1uJgsFLlFvpKeen8BCm6ad7bNcFSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kei39YUMaWYB4yFTFW55VaC1POPXa5oWhYkFeBbo1Zg=;
 b=nnRg5uULm5ojAM0ro3ov05eAUIJ4e1LUsyw74WFGmKXCPR+OFX9CxARWu5+11bSz/t9mV4/IuhDaYFZT0wDIGvy8Ys9UfJti4f0SRItKfeXK8Vefciuiy7KEyMsdD5xC0WOGh3ZMUne98xtu8ldK/i+bB0UTeHxrAvskEweVr2dBfzEbqcQ8WIrFpSmYmlCndftKpw034shSLW/lgcEQ3ONM5FoXEPY4K1PNPJEygK1d6MTPTsw2Vii1Yj4I3qtDvqVfbRWPRbxg60/V6ixtdyffVfoGXXK58gB5TDgZaqWHOeyeGr7qs4U0vuuGR7vTgJ34n4nDIMzSiYIKxzYJ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kei39YUMaWYB4yFTFW55VaC1POPXa5oWhYkFeBbo1Zg=;
 b=hOU6gg0gcx4pWsknKr/Fz+7wP+Z3ylBq3EZllXBeozFEuyvB7CozxgJow9F4UKkzBupnFzIj1sSYtXT03eG53N4lWrSw3ULZ6TQBJd47AUpGdTeBS6MYAd6OeB+CQvfwqm9y0fMn7LgqhbeKIvHflE7zZqnMtnDeQ+axR0Bg8T4=
Received: from DM5PR10CA0003.namprd10.prod.outlook.com (2603:10b6:4:2::13) by
 MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 21:10:49 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::62) by DM5PR10CA0003.outlook.office365.com
 (2603:10b6:4:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Mon, 14 Mar 2022 21:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 21:10:48 +0000
Received: from yonsun-linux-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 16:10:48 -0500
From: Yongqiang Sun <yongqiang.sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add stolen reserved memory for MI25 SRIOV.
Date: Mon, 14 Mar 2022 17:10:35 -0400
Message-ID: <20220314211035.142938-1-yongqiang.sun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04eb0e2e-773f-406f-505d-08da05ff1d22
X-MS-TrafficTypeDiagnostic: MN2PR12MB4319:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4319EFA106E70FF2634A050BF40F9@MN2PR12MB4319.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmd2pWUnmf+jirssQOzoqogdSW8HmPB+TKBxmERHIdEjYF46KUJL/b2QcgxTFDJq4BKXzcne9FQYawkx7YRuijQXDf9aVqY0CA5L2s5nKFEQRMCS6WGgye39mfqR22kbJ8SbUXDZq+d30/J9BCy+skta3p117wmsha8D2Yt33F46ughOEXNVdKho4kycDxME9XWSz5IvH1z9coh60tO9y7sOmoASImrYj54Y/ed5fjt01UgU3KCcfpRAseUN8gCUFS6EV6MbyPQhP9t1zWVop0Yy3p9o48sL9ATSSVbJ98YISzWvoTGbWJKmVs2yE+Jx2G3qVxsNHDncG6IIFSsmYpGvEXMdvOYGXLzh/7Ud2S9e6w6UDxju+caKE9J5Mi4YLouqgdcDI+8hU6ZT9R2D88dM88piSaWqZXYy0gYZw47WVHEoqIjk3efgDBcFyp6vWcuUloJk5qzncKzgWAS8D5E1R2WmlqE8sLiLbhcrLU2QOi2M0/UVydt7X2crLP+f58uMj270+NoXGefeRbYYS2SIaAQmDTZ9vjod/BqTjpsFPEZPkImzjZCtdL93wDtrKGCX8PpDzQR9rVcav/xv06bz7Hxlk5OVGgNaXfzsVNzH72k4EQ7qssBsmSamyoSULG8Ej5V4wlnf/UDEkwVy6o35j+oihwJ297W5zYoC1rvwtonnbdxOY+QwK5FpOpsV3LXxUC/GF2M15bsA6nhyNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7696005)(16526019)(83380400001)(44832011)(36756003)(26005)(54906003)(47076005)(5660300002)(40460700003)(6916009)(6666004)(186003)(86362001)(8936002)(2906002)(2616005)(316002)(426003)(82310400004)(356005)(36860700001)(81166007)(336012)(1076003)(508600001)(70586007)(4326008)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 21:10:48.8996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04eb0e2e-773f-406f-505d-08da05ff1d22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
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
Cc: alexander.deucher@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MI25 SRIOV guest driver loading failed due to allocate
memory overlaps with private memory area.
Add below change to fix the issue:
1. Allocate stolen reserved memory for MI25 SRIOV specifically to avoid
the memory overlap.
2. Move allocate reserve allocation to vbios allocation since both the
two functions are doing similar asic type check and no need to have
separate functions.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Change-Id: I142127513047a3e81573eb983c510d763b548a24
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 38 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  1 -
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 7c2a9555b7cc..7e4d298e8df8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -626,6 +626,13 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 {
 	unsigned size;
 
+	/*
+	 * Some ASICs need to reserve a region of video memory to avoid access
+	 * from driver
+	 */
+	adev->mman.stolen_reserved_offset = 0;
+	adev->mman.stolen_reserved_size = 0;
+
 	/*
 	 * TODO:
 	 * Currently there is a bug where some memory client outside
@@ -636,10 +643,22 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	 */
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
+		adev->mman.keep_stolen_vga_memory = true;
+		if (amdgpu_sriov_vf(adev)) {
+			adev->mman.stolen_reserved_offset = 0x100000;
+			adev->mman.stolen_reserved_size = 0x600000;
+		}
+		break;
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 		adev->mman.keep_stolen_vga_memory = true;
 		break;
+	case CHIP_YELLOW_CARP:
+		if (amdgpu_discovery == 0) {
+			adev->mman.stolen_reserved_offset = 0x1ffb0000;
+			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
+		}
+		break;
 	default:
 		adev->mman.keep_stolen_vga_memory = false;
 		break;
@@ -760,25 +779,6 @@ uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo
 	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
 }
 
-void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
-{
-	/* Some ASICs need to reserve a region of video memory to avoid access
-	 * from driver */
-	adev->mman.stolen_reserved_offset = 0;
-	adev->mman.stolen_reserved_size = 0;
-
-	switch (adev->asic_type) {
-	case CHIP_YELLOW_CARP:
-		if (amdgpu_discovery == 0) {
-			adev->mman.stolen_reserved_offset = 0x1ffb0000;
-			adev->mman.stolen_reserved_size = 64 * PAGE_SIZE;
-		}
-		break;
-	default:
-		break;
-	}
-}
-
 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 {
 	struct amdgpu_bo *vram_bo = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 93505bb0a36c..032b0313f277 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -331,7 +331,6 @@ amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 			      bool enable);
 
 void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
-void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev);
 
 void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
 uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f60b7bd4dbf5..3c1d440824a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -948,7 +948,6 @@ static int gmc_v10_0_sw_init(void *handle)
 		return r;
 
 	amdgpu_gmc_get_vbios_allocations(adev);
-	amdgpu_gmc_get_reserved_allocation(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
-- 
2.25.1

