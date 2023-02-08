Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3787C636D3
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 21:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B1ED10E03F;
	Wed,  8 Feb 2023 21:24:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF1D10E03F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 21:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l81dtqJkT7ucN/XZHHgIX3f1KrLuyzDiZmsvNcecEUJ1X1XiStzlxLcjhrEvpz+W492toN2WjZuZLHwqvvCb0i0YLfKucT0IUiRm/+kOGpHQYg1YFf0xwioteTts3a3MeBcEkGJJV4/+GHuQcWdzgh/mtVMShLtwVL3S5BTmLoq6SIrf56fDOx8SktW6TkjHsnnLp4eI+URrk91/VnW4UVnXIDIN6Diso/j+yfwiFFT7hldNCYdmMosd+F2ebED1HWiwuYjZMB2mw0XsQ/BTay8UBBLRvYVIfOgiS4oCbDOKgkenNjCN1N9FLjcAqgOP+BfoBrx9PCpAgMvpw8jZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/5m2fBMVuZEffTynbIO0BOVqcpOYJfC7I5GyCRoIFE=;
 b=Hd+QYuqnDzoysHMiwFoYtqARppwt+7glpazFw+/a0PeIU74ya+uWz8QIMHlVgREbPWHYpCdc+B4XtSCeT39O2HU7MEowglQpRiaMxCXM8AJJ9vPnNxCKLmfLZCWM15/GUHHolhGQnimQzC8H4N101ST5zFcOUJmf9EA9ti4Gu3/cpZSd4nfgJTDY4CsTFkDXqUO3BdYfLVc7ZA90YX53axOWBRy8qfupaV4NrQJyMEmPmYc2y1fEswGVc3zmzF3MJvh+CcvFRP+qujiM5MN3Y69Ck4ySAnooTmtcRdk43R6b/wG/DS19TtY5GGKYVehOrpoaT3ibRs624JsuwQJfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/5m2fBMVuZEffTynbIO0BOVqcpOYJfC7I5GyCRoIFE=;
 b=JO9g+SUy4InprHrM++j746ytr8JG0ljpjaWkUZPDKgUV6vKOAguopw/Q4vIZhaV+WilVsZ9kAwJLxvGEknGhqeYXazF0pNHi/MI9n2SGy4GYEds/6Ha2+8Rt+RfX8iVxXZawpgmudb2YVR87iSB/zR9pLncERHhgnVv2mlQf2Nw=
Received: from DS7PR05CA0104.namprd05.prod.outlook.com (2603:10b6:8:56::16) by
 DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17; Wed, 8 Feb 2023 21:24:21 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::89) by DS7PR05CA0104.outlook.office365.com
 (2603:10b6:8:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Wed, 8 Feb 2023 21:24:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 21:24:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 8 Feb
 2023 15:24:20 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc11: disable AGP aperture again
Date: Wed, 8 Feb 2023 16:24:04 -0500
Message-ID: <20230208212404.2656017-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|DM8PR12MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d231d3-9445-43d1-ad23-08db0a1ad800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UEGeyZspzc1OO3COiDS+IJt+EI0gQBGvUZLTpdXzsEeD5BeT/BTFpQoGaJUo/DuEsEHuVfmosV7/sQAApgk+yiJKhlp6GNRaTKFt6TkBz/FAArcN+ciphhyoer5DNw8IzoUP/BRPPAGXFCeGpADCDPNCKH93CRgFi6AgcI/jOdDtHkcttEtsP0Ixuel+cWpxOofePnvYtnu3/7tcpqyqrRXQcerhMagNNi1lNHZkl6uqgzxrFFGiVyafNWl2ZNlV55pXqMx89V0/rmHNqzWwY8ybSuOOsMuNZb4xl79KAtUSeE3KB68DknfXP1hwW+JcY0qMBj/D3YtaynHG7m2tDnrtLLzfpSQ9BdVD9DqBbBYIGy30jP0b8X9QyfFfvfx8wiuDU/VmD1jLTxdGzQDb3xlol3cRWb34chE8R0sJ37UvKYTNNwUAzEULrhJ9Faype3206fe2dBDpdKHkoeUzrVZ4RXRe87Ff3JiH1GYTRy63MvlYyMCHNRddzJcKsnG33r5rmTTtRNtHlgZR1Q7P/iDLqZUTwOscD5q7q+hM+/QSxAupSXPthsbBB73bYm3H8UeBJJjWm84WxyE/hZDwqChKq9OBqs5ubWq8HYCZrOZwEvi/Rs3T65kRkRsrhi/TO0/bUnplvFwp9UPsj28iBYZsIkU8nePs7DaujDS/tHPt9zn4jEGQSyS3AFpoYqoCaRPp3bLkrouawVeUF6ho5ybwExbpSFtyxzvWr2lw9Dk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(70586007)(70206006)(83380400001)(316002)(6916009)(8676002)(8936002)(5660300002)(4326008)(6666004)(41300700001)(478600001)(16526019)(186003)(26005)(336012)(426003)(1076003)(7696005)(2616005)(47076005)(356005)(36756003)(40480700001)(86362001)(82310400005)(2906002)(36860700001)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 21:24:21.1626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d231d3-9445-43d1-ad23-08db0a1ad800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
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

It seems not all of the issues with SDMA firmware have
been resolved leading to spurious GPU page faults on
some variants.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c  | 7 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 7 +++----
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c | 5 +++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 6 +++---
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 7c069010ca9a..fa42d1907dfa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -151,11 +151,10 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
-	/* Program the AGP BAR */
+	/* Disable AGP. */
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
+	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
+	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, 0x00FFFFFF);
 
 	/* Program the system aperture low logical page number. */
 	WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 0a31a341aa43..5e0018fe7e7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -673,7 +673,6 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc);
-	amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 923fc09bc8fc..ae9cd1a4cfee 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -177,11 +177,10 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	 * these regs, and they will be programed at host.
 	 * so skip programing these regs.
 	 */
-	/* Program the AGP BAR */
+	/* Disable AGP. */
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
 	/* Program the system aperture low logical page number. */
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 		     adev->gmc.vram_start >> 18);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index c8d478f2afdc..fb2f0eb72f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -173,8 +173,9 @@ static void mmhub_v3_0_1_init_system_aperture_regs(struct amdgpu_device *adev)
 
 	/* Program the AGP BAR */
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
+
 
 	/*
 	 * the new L1 policy will block SRIOV guest from writing
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index 51580302ec42..c30e40e52fb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -162,10 +162,10 @@ static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
 	uint64_t value;
 	uint32_t tmp;
 
-	/* Program the AGP BAR */
+	/* Disable AGP. */
 	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
+	WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/*
-- 
2.39.1

