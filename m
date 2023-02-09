Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8B8C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 04:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25B010E901;
	Thu,  9 Feb 2023 04:46:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A869A10E900
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 04:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQTF58jB3lphFw0noNRmFFh6u9BLz+w8dBFUpubKp62Lgatce2biuD3OeF2OLGgp3qZxrxtwf7UYMH6veZWVBSyEpFrQ3sIhlHxfAxoc2c8zYBudWxXE589zDuAG+iO19Xfs76WYnfOGx31oiWe3xT55KdnKHSza4kpOT6zFbJ9FurdomkpHKvormwGfX96GtAn6Yyub7v2RXMJuZf3PhRXAo0ttUq6/fatLOu505rDbXtY4mHwse53epg0mpLf247ZZ/f3ApGyXuZMt41YCKY7emNVhkAYEto9wqDFD3DRjYRu6U4P042+k4Cz2xN2dqCzOLjJ3L1lkk31XTL95Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqZf2CBxBllGQsgOB5Byx62QXiGrLAN60iNgTrqnf9Q=;
 b=LtgU1WaaxRomposviL6PJIWimPXkJAhJmOgI+svS+oD4EoatKZKO5tqzD17xSsE6a29aOMSYXQ78O+ojxzEkPZqDsAzRJqPxOdyggJXS8EBig1cPWKZSDlF5tKL+kM7jElanBPDCfcpKgAy2/roXVACyWNQTqdod2cCNUXvXnjdDkvBJKgLuE9bjVrmJIUUp9ystGaRauKyxuC4g3nlWgeeHhSjToxqJRT3P0zS+cgi7ySn8/Y9NCmZ9a+rioDz1gFEGrcqQKfAG+nOol57zyYfgdIoxXlsNZw4piu0xLhn+gyOz1OxRDR6quOlALpJQD3tkPKwq1oyRJcuauQKZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqZf2CBxBllGQsgOB5Byx62QXiGrLAN60iNgTrqnf9Q=;
 b=2B+lsIjafz8a81YFiURWorM83pdMATsP7TlHbEsfoQIihYNYERCZ33PPDBdCl97V/RqNg3MO7tPa00qV0ByhlVUhU9JuOrYby4ssC4fgYh+TBYuZEloOfiE7FpX6i1RgWfeJszE+9QF1Oqz5CmomXK5DDXycbaEpI7YLHH0Zxs4=
Received: from MN2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:208:1b4::34)
 by MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 04:46:36 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::a4) by MN2PR15CA0021.outlook.office365.com
 (2603:10b6:208:1b4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Thu, 9 Feb 2023 04:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.16 via Frontend Transport; Thu, 9 Feb 2023 04:46:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 22:46:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/gmc11: fix system aperture set when AGP is
 enabled
Date: Wed, 8 Feb 2023 23:46:15 -0500
Message-ID: <20230209044616.560657-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|MW3PR12MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5dd5b5-ddeb-4cde-0d56-08db0a589ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dq6Jmb5L5QZt2/R2odetFk91EKexGmahgWdP20fCsyHhIBUdWnM1OgdCJplZedeHiAKTKskfHWqUT7twpGc9uN/CJrCGSmxfXUVrcom7cvdQK5afZstTa++Zb0+M/jktNTpLmjFRc5jPRYQ+d705Zt2z+n/xsGqQTfLT0NtnQlucp8pcu6s3DGRfXbeWsQ/XsqiKCr4nKanUFFuV50KeASMV4vxbG9xonXimZCfRkjcPgEeP1EfSDnM0ilT+sqy8Th2NCr3ppHO3QZwvcsvKDwXr5takibn8ulzGRCp7qAjFWlnmmfHC3EyNeG6sOtHohXhDztQuAFeiclIVjHa6NVA0Ml44X9lfqof7woOIHZBfyU4SxhpSkRTSwoVntqGPoHvVFrRpnbk93JFIE3QdsSzm9nru+YQEYTQj+HHEdGax18oRg27MYQYrHoUCyjjMZFAlxUudy3npVbjANWG1Wqyco81RrVLhaLTfUYoAdAhWdmR5MAkke7Qw6VdoFXYh15yxDkg4+wanJ54lDzJF1JrCJGkNP1+yS2nV7yIHQQ2OLpHTfbreobr1Jb6XOKG/IIiYRhZHrj1BEeb99oTDDk6ytSCiCwUUL4Trj2ZsZZTdj7wxXf/mCnjTIRkP8DCiPJFutnfpPzwdfZ19sDwe8RlBjvA+gEOeJYSPhQ7lI2kYFiPLTgxLHxVvFP6UMg0Luu82Q0pRBUwwMbFShL69f4b+qqmUmoMlzeBIwANmUyQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(336012)(70206006)(83380400001)(316002)(70586007)(5660300002)(8936002)(6916009)(8676002)(4326008)(1076003)(478600001)(6666004)(41300700001)(2616005)(26005)(16526019)(186003)(47076005)(7696005)(426003)(356005)(36756003)(40480700001)(86362001)(82310400005)(2906002)(36860700001)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 04:46:36.0084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5dd5b5-ddeb-4cde-0d56-08db0a589ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4554
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

Fixes: c6eafee038ed ("Revert "Revert "drm/amdgpu/gmc11: enable AGP aperture""")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

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

