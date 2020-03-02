Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B48C3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 07:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D6224695
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 07:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nut56lX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D6224695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB136E0AC;
	Mon,  2 Mar 2020 07:08:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 912126E0AC
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 07:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOqB8qbPH3xc0nPgQM6HcDrcIyNwiV4rVp/1YEOv6W1pkvzwhTMeskuUoItLS0ZfD/Q8oO+tOzSEm3PzwOEOlIjFIcpyvqpg1gTjtvCYdj4DTzXMHkrhd/BVrfR7HfJVEZ8UOmvsJa7Xr/hQl0j2knwXUbtqDtOLHdtIy7HAM/BLCc1MZZPFXhmUXLn5MJVARzXqsV6ce6MwflrX3sPuM3Tax9sclPU9fmsXFNrx7l8Bvxruv35cJqHOJcucbxWfRON1PXBCDQKeAsVNUBs9Rt4liChE8ig3pSHWgSd7jDVI19Sd8HcxtOUVkuUo5JNeXc192E66bCC1bzJlxsx76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB7xu4QHRUrUwypilsjKXcO16hZoVOF6qUIavpGXqdo=;
 b=JdX7lmQ01qRFuW3NSAos6j2Nue2yZEMJoQKz/IxrwU0HG5ckC3p+EqbpvTt2V6wfOP0WZcjpn7u8ou1X5XnVMuMnGocS+S3QPyRPyF+9zu0LlRAL2GGgRIOXogHx3iosdCcZ/ukB68qmMJSLjZf7s2RQUpz3nw67fsLi3lqXHeKNijVvJp6tgtyktnrRfNUiefawP8kBRh3s6rWkJ4quuj/hBn6pxqRPpfwpSV9Foq1xPncfCJT8BBDH3PCMqr/d4sc6qCk+bbS2TBRgwwedvkA/nWJFZSI+j8x6VkX0D5c76Y9BMM/tnKDx9WBKZrLMvgpA3CwzETMD4GEBcJ775Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB7xu4QHRUrUwypilsjKXcO16hZoVOF6qUIavpGXqdo=;
 b=Nut56lX5p5Qp4YdjciiHAspsK/WNKLvc4KLvD25NQ/R/76jrzL9zQu62e7lnirGUM1v5I4xhaPQJOOMTCGRNgXAVF1W+7eFWXDZe3RumC0ZoKKx2uFiwur9M+h7uSwQEy3eIQBHeyte4p13N4V+FePNHQbvi3IL7VnXtoBkEr+8=
Received: from DM6PR14CA0050.namprd14.prod.outlook.com (2603:10b6:5:18f::27)
 by DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 07:08:26 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::5c) by DM6PR14CA0050.outlook.office365.com
 (2603:10b6:5:18f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Mon, 2 Mar 2020 07:08:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 07:08:25 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 01:08:25 -0600
Received: from gamma.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 01:08:24 -0600
From: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov: skip programing some regs with new L1 policy
Date: Mon, 2 Mar 2020 15:08:06 +0800
Message-ID: <20200302070806.32034-1-Tiecheng.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(428003)(199004)(189003)(2616005)(36756003)(8676002)(81156014)(2906002)(8936002)(81166006)(4326008)(336012)(1076003)(478600001)(7696005)(186003)(316002)(26005)(6916009)(70206006)(6666004)(70586007)(426003)(86362001)(5660300002)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2376; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d74835f-6c98-498b-c42b-08d7be7880a4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2376:
X-Microsoft-Antispam-PRVS: <DM5PR12MB23764D01321EFAD166B0A1A5E4E70@DM5PR12MB2376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBamhWQHlzKIEB+/8UociJ3Zh1k6J/bQ8iysN6F5MynylxFrPmN6GSjPmr9EgLWOxpehx0IuwbhkzXH5/naXj6DvlA3I836RYwp9uSoORImUXqQHhLvkLtrfAOpdCBOC/Lm49722uHuIwoyJIsGTbYZDjbDjzxHW9XNpneiKkuWaGKYq2iB2X0HG6aODPiRZoJFMHHa9Ayg3pOjST0ioIHZUC+EOK398t7jQ9Axwjnewz6woSFmZcIaA7h9rbdYrMfxZ2Z/3zFTpHpRQqnBUtWimplEJbCWPwJrkwEgBvK94WZzaZK5wUSytJKRgRKgnxVohjCTqyoPoJGhFLCng8MBPMBkubpL0xJ5gHBbILF9YyoxZ/svS32Gyj1hlBaI3dt6hirxG5Gyy4SR4nWgDjVTNckZCnYSLnEQlloqOpNiXvOvUZqTefy75wAaWR9ZR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 07:08:25.8899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d74835f-6c98-498b-c42b-08d7be7880a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2376
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
Cc: Tiecheng.Zhou@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With new L1 policy, some regs are blocked at guest and they are
programed at host side. So skip programing the regs under sriov.

the regs are:
GCMC_VM_FB_LOCATION_TOP
GCMC_VM_FB_LOCATION_BASE
MMMC_VM_FB_LOCATION_TOP
MMMC_VM_FB_LOCATION_BASE
GCMC_VM_SYSTEM_APERTURE_HIGH_ADDR
GCMC_VM_SYSTEM_APERTURE_LOW_ADDR
MMMC_VM_SYSTEM_APERTURE_HIGH_ADDR
MMMC_VM_SYSTEM_APERTURE_LOW_ADDR
HDP_NONSURFACE_BASE
HDP_NONSURFACE_BASE_HI
GCMC_VM_AGP_TOP
GCMC_VM_AGP_BOT
GCMC_VM_AGP_BASE

Signed-off-by: Tiecheng Zhou <Tiecheng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 55 +++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 29 ++++++-------
 2 files changed, 37 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index e0654a216ab5..cc866c367939 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -81,24 +81,31 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
-	/* Disable AGP. */
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
-
-	/* Program the system aperture low logical page number. */
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     adev->gmc.vram_start >> 18);
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     adev->gmc.vram_end >> 18);
-
-	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-		     (u32)(value >> 12));
-	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
-		     (u32)(value >> 44));
+	if (!amdgpu_sriov_vf(adev)) {
+		/*
+		 * the new L1 policy will block SRIOV guest from writing
+		 * these regs, and they will be programed at host.
+		 * so skip programing these regs.
+		 */
+		/* Disable AGP. */
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BASE, 0);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_AGP_BOT, 0x00FFFFFF);
+
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+			     adev->gmc.vram_start >> 18);
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+			     adev->gmc.vram_end >> 18);
+
+		/* Set default page address. */
+		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
+			+ adev->vm_manager.vram_base_offset;
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
+			     (u32)(value >> 12));
+		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
+			     (u32)(value >> 44));
+	}
 
 	/* Program "protection fault". */
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_LO32,
@@ -260,18 +267,6 @@ static void gfxhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 
 int gfxhub_v2_0_gart_enable(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	gfxhub_v2_0_init_gart_aperture_regs(adev);
 	gfxhub_v2_0_init_system_aperture_regs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index bde189680521..fb3f228458e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -72,11 +72,18 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, 0);
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, 0x00FFFFFF);
 
-	/* Program the system aperture low logical page number. */
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-		     adev->gmc.vram_start >> 18);
-	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-		     adev->gmc.vram_end >> 18);
+	if (!amdgpu_sriov_vf(adev)) {
+		/*
+		 * the new L1 policy will block SRIOV guest from writing
+		 * these regs, and they will be programed at host.
+		 * so skip programing these regs.
+		 */
+		/* Program the system aperture low logical page number. */
+		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
+			     adev->gmc.vram_start >> 18);
+		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
+			     adev->gmc.vram_end >> 18);
+	}
 
 	/* Set default page address. */
 	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
@@ -247,18 +254,6 @@ static void mmhub_v2_0_program_invalidation(struct amdgpu_device *adev)
 
 int mmhub_v2_0_gart_enable(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * MMMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(MMHUB, 0, mmMMMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	mmhub_v2_0_init_gart_aperture_regs(adev);
 	mmhub_v2_0_init_system_aperture_regs(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
