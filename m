Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECF1C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 13:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83FFC10EAD9;
	Thu,  9 Feb 2023 13:43:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD20210EAD9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 13:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbgxXLuRNZTy1NS8rJJI+UBd0nUrmN0+LuYtDGY6tbw2MJL0MbSQGjI0s19MqY7TOI3vojFY3VqZLl61OGRbWt6b93j3aKrH5NvaxSLuvVEG7MHFdIzimYg2qccueH61xbyFS1Kjc6Q1tt5TH4bVsxhmyXuR1S7RW54mkgnvV0rFrRqD0zq0kWn8QmAj7C8dvHGo4ZZvdgSzl7fSUETBxhaB9lgxQ/Xb7xX8CgAHcfR4tssblHxAScmW8ZB73o+Fv22KIf3YFaHH6NpDt4bU/O6CLLcZ25Ywy0OnP8e25n5gqEGZcOqUk6ccqbqlAoM2EnQn6V6buenjk+Ld+Xgirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTcfwm1U94D60Al+Ys6nq/5QsTTHIRJgqJJv9BalMUk=;
 b=UK6z8j0YxiVoG8FhZuGWsgHq7dc/jqhCGKIXgKyZ4V+7B6KCsZr/hRm3TaMhhFe40tkM+JkflGuGR0r2PFWP4Ufg2S0QtqfzYLGLeQSX+yNuZ/orTZZbvPglDVKnuMNd12LwCOsauxRzUdL2qWJYRRN7+gln1QnbLq+oAfjE+L8O0aGgI638b/M4f1NfwK6atZ0n+XlPU7VOgVbXzUe9PqnNPHATPeBsEiWPQ7fuwTBihWmjY33RkoyGIFBVVimcCJLyEMEQtZko2t+uy2iokrEwFlyy+u+tl55vQodtxiisiBwV8w5YH9h8rYj+4rlsFPwal5bz7UgweU8vgCiT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTcfwm1U94D60Al+Ys6nq/5QsTTHIRJgqJJv9BalMUk=;
 b=taprruLJKhFumrdC49WmTOuZQ8X9Z1oe7MqfDM2TRMmPsPcnp07JaHhEHVdA9NfhrIIy1zgSjEQ2xu82x2wJTZscPUdhCYFgddm8Al6ontbj5JKWoMN2WELhlMKuQQmSzX89/kftOA4zU8KJczkbMG45WU6c6DbdWMT3oRwTjBs=
Received: from DM6PR02CA0081.namprd02.prod.outlook.com (2603:10b6:5:1f4::22)
 by PH7PR12MB6906.namprd12.prod.outlook.com (2603:10b6:510:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 13:43:19 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::b9) by DM6PR02CA0081.outlook.office365.com
 (2603:10b6:5:1f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 13:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 13:43:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 07:43:16 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/gmc11: fix system aperture set when AGP is
 enabled
Date: Thu, 9 Feb 2023 08:42:58 -0500
Message-ID: <20230209134259.572460-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|PH7PR12MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 61915aa9-5c3d-4d72-5a8b-08db0aa39aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWiTGgEhJz3/LcY2IBmLM8BuodD/CDq1f+tN4JK+rSL8gh4kBZ9JtkdgXvOJ9LVjlxcK8KZSuW77V1OiPbZ5iFdljUOILy6RUUXkEg7P9cziUYDs2J68soSokXDY2DUn93Oiw6h51cJbi7auma4rcBuiLjQArkbJGG1Sw+TnTWKQgRB4wu3Pifb1X1s29z3PhWNitfzj3ElKRzpRcXr54pSCenvF6OzFzoJFJtr2YMuftqfz/FaWGbT4QUFTGzE1lnMqkmyZxKUXjjGyAFuzw/2BTAUEfaJO3b+1ElP3/PAxKx6xyITvUDWevym24sXnzKM2s3DrebmcyEBOrDj4RGld1ideRwboiRUYzgg3TTq67Ps7rNuyy5At38MHHzMCEQVMeEsEoCroQqP89IKXZzq1Bb5EzS5uBNnabSPg3RfLgmltP/DzgFJLj4z4aspQ3606vjOylhYldVc4kA4JqYMIL1z3TsE3WJkbAHNBRhNmYLjnp7MM2c6kjtDIaU3XPyykM3ghB8wk5CGAte53jW9gm8NDaRcYtEkMZ0T7clzWgRvxFBXzSlE/W3HyxzpHmyHRhuh/EO6Z4SbUu4uPVALk5Z3RcmD1XppFdPYx466PTqusnzvxoOfavGLJWZWyzYNzkCjIWHo0wmtyHptBnLzqJhcF+GkqoAJOUwRsMOp/XRRc3ISneBq2P6nr3QX98WzqHRhtaOMtcNkfaS9TTdELbsRJfo7xLBEeVLnqFO8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(36860700001)(82310400005)(36756003)(356005)(6666004)(1076003)(82740400003)(26005)(186003)(86362001)(16526019)(478600001)(40460700003)(40480700001)(47076005)(336012)(426003)(2616005)(83380400001)(81166007)(5660300002)(8936002)(4326008)(6916009)(41300700001)(2906002)(8676002)(7696005)(70206006)(316002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 13:43:19.2881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61915aa9-5c3d-4d72-5a8b-08db0aa39aa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6906
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Need to cover both FB and AGP apertures.

v2: fix missed gfxhub_v3_0_3.c

Fixes: c6eafee038ed ("Revert "Revert "drm/amdgpu/gmc11: enable AGP aperture""")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c  | 4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 7c069010ca9a..be0d0f47415e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -159,9 +159,9 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 
 	/* Program the system aperture low logical page number. */
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     adev->gmc.vram_start >> 18);
+		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     adev->gmc.vram_end >> 18);
+		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
 	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 3dc17a3deedb..6e0bd628c889 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -159,14 +159,14 @@ static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
 
 	/* Disable AGP. */
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, 0x00FFFFFF);
+	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
 
 	/* Program the system aperture low logical page number. */
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     adev->gmc.vram_start >> 18);
+		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     adev->gmc.vram_end >> 18);
+		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
 	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 923fc09bc8fc..164948c50ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -184,9 +184,9 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 
 	/* Program the system aperture low logical page number. */
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     adev->gmc.vram_start >> 18);
+		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     adev->gmc.vram_end >> 18);
+		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
 	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index c8d478f2afdc..26509b6b8c24 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -183,9 +183,9 @@ static void mmhub_v3_0_1_init_system_aperture_regs(struct amdgpu_device *adev)
 	 */
 	/* Program the system aperture low logical page number. */
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     adev->gmc.vram_start >> 18);
+		     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     adev->gmc.vram_end >> 18);
+		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
 	value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index 51580302ec42..26abbc6a47ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -175,9 +175,9 @@ static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
 		 */
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-			     adev->gmc.vram_start >> 18);
+			     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
 		WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-			     adev->gmc.vram_end >> 18);
+			     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 	}
 
 	/* Set default page address. */
-- 
2.39.1

