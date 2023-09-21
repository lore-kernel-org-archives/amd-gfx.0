Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0825E71072
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 14:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BDC710E096;
	Thu, 21 Sep 2023 14:13:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8524110E096
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 14:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFwT0lmZ03/0w8SV2Hy6oomYRegMfXwT9OXdwwq2wVJLy8oByUp+tPqlfr2LxU9WlWeKCmRMIA+DAk1DFDjzOiww1qszDGt6/PF0HjjNUFAuapmr4JVIkTbVfGAM4KbT1brJhCw8J7oMB8V9YRf2dQyROHFPuWkJ8dy4FF+AuXD20vRqKCT3EvbORYK8WB9NmPSmON4HQAnyVGUIGF/IkLk6OuXUOT32ZkerpHGokl7bfGZnvCbJAtMbSf5MZ4eh9J1E6jmhAMXnfO6XeKYgy5XxsRtIp0xcXE6A6eNYP9ERpTNIFax0+Dwzc51c/HqOwpx6fy22q/kUX1S5sTRSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4TT8Orug4fKVQIjL4qCUhLE8TCDOYctKqfYdN3aAm4=;
 b=cHguaKHgVXgmzvpvaHriHDbqYCuHwMzX+46wLdyyzZlyqean9PyuIBPjoCRPj4cHXsEnWED3Bo3C+vCQL8+Ey6yB31x81S/rgU+HPoQK5hBCB5/SSpJTTJoAaV97pLOB2ujkTQCakkHmlAzstGYyQZqVqWLGFdClMYQD89vH0OhyCAEC03gc3iypGLsfyH25vV995NSQ7vjNDzQSCs4S3mXFEcEubqXSSGfgUuKSEuVIu37wNeJbvdV+U31VsTP+R7QAAgv41BQHUEasomdng2S9S5o3E3OKYr35QLmVLvRrXCwT11paw+QzD3ekzQ8YL46MSloBrMMFyehpuHhK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4TT8Orug4fKVQIjL4qCUhLE8TCDOYctKqfYdN3aAm4=;
 b=b4cTWSMKG3Ifhe7KgKM3OWKQLKmnC+6zPdkwdalTwToHp04fcK6tbhEoOzL+U/y2GVxPGViUEIro0rsrWBTG0S2xWk9wXc2f2ljr/X/TJ1U2bosQgOmAFh8SNf6UcS+w5lpW0AHEJEQyX0oqgll+HmITdcWfzutWDdBZrRw3/Gg=
Received: from BY5PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:180::32)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 14:13:18 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::39) by BY5PR13CA0019.outlook.office365.com
 (2603:10b6:a03:180::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.11 via Frontend
 Transport; Thu, 21 Sep 2023 14:13:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 14:13:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 09:13:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/gmc: set a default disable value for AGP
Date: Thu, 21 Sep 2023 10:12:59 -0400
Message-ID: <20230921141300.415876-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921141300.415876-1-alexander.deucher@amd.com>
References: <20230921141300.415876-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 5974024a-9d29-4158-f2b5-08dbbaace6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WjWURrEK+2z7o00lubFHkDqtTUwA/p980NDRMQh5inxb/viZPElUuXcCAOOi13XnWQ3PGaGp+MkGNI2w0FvOwBdv4l6bz400tkk/9Pa8+NTHZtQhrKVca3CEmbMfJG5HjViWSe+NjpIbM00EDuWR6tdhXszg/WK6dyXos9EXhaL0Z4maG7eeABMoHNW0yncGVmmCL6VACNDufH4w/vtpdge7+KaBg830IzELjFVAVpdpwhJQU4+PKAGOec1cniXPfLD4sORDow7CgIEV8QrWMf9TP10Na7mkOVnLomDN8VwzR/zZ+ToVu8Y4WCnVKAOjrz7DPlATkXUSSjpCpAkVD4rai9c2A8r6HkwyWcBHedznk7pffRXaHgr1gqRnR1Lrx+2niTI417vK7gkaaXkZr2P1gfTR89XSiNpUvIadQFKeiONEYNHOiLsdmnjaBwqwyzdbYZeSZDZEvmodE2N1V2WcvyknkHqtbzZa2/Tm8aYtyJ6XYeTC0eEo7gBo2leRNb5GmBjcOEI58+NMf/RJHf9e6/YhsGQORU+JAz7Ppza1obcqHXavKmXo0EPYelhN9y1fqDuTLnPt5jO2621YRKl8Mp9BavAWWM1ZY4brLCHdkBN3ftx50cgs/E+XnVSHr4wF5GgaNbBwxKROd444nj5NUemYgmynhfYx91GCHrWuE5zxamEFkXzUQDSnd0vDxNfaf3Rbfhov06joHJHnQODBnG/3t4J2pAiLK0qGJkUZqV1P2LcCqhsQbRf5GxXgMG1XWYwF4svJRe2sGVW5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(16526019)(356005)(81166007)(26005)(82740400003)(2616005)(8936002)(8676002)(4326008)(1076003)(40460700003)(83380400001)(36860700001)(2906002)(336012)(36756003)(426003)(47076005)(40480700001)(86362001)(7696005)(6666004)(5660300002)(6916009)(316002)(478600001)(70206006)(70586007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 14:13:17.4325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5974024a-9d29-4158-f2b5-08dbbaace6ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391
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

To disable AGP, the start needs to be set to a higher
value than the end.  Set a default disable value for
the AGP aperture and allow the IP specific GMC code
to enable it selectively be calling amdgpu_gmc_agp_location().

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 27 +++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  3 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 10 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c7793db6d098..d0653f5ba8a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -315,14 +315,6 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 	const uint64_t sixteen_gb_mask = ~(sixteen_gb - 1);
 	u64 size_af, size_bf;
 
-	if (amdgpu_sriov_vf(adev)) {
-		mc->agp_start = 0xffffffffffff;
-		mc->agp_end = 0x0;
-		mc->agp_size = 0;
-
-		return;
-	}
-
 	if (mc->fb_start > mc->gart_start) {
 		size_bf = (mc->fb_start & sixteen_gb_mask) -
 			ALIGN(mc->gart_end + 1, sixteen_gb);
@@ -346,6 +338,25 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 			mc->agp_size >> 20, mc->agp_start, mc->agp_end);
 }
 
+/**
+ * amdgpu_gmc_set_agp_default - Set the default AGP aperture value.
+ * @adev: amdgpu device structure holding all necessary information
+ * @mc: memory controller structure holding memory information
+ *
+ * To disable the AGP aperture, you need to set the start to a larger
+ * value than the end.  This function sets the default value which
+ * can then be overridden using amdgpu_gmc_agp_location() if you want
+ * to enable the AGP aperture on a specific chip.
+ *
+ */
+void amdgpu_gmc_set_agp_default(struct amdgpu_device *adev,
+				struct amdgpu_gmc *mc)
+{
+	mc->agp_start = 0xffffffffffff;
+	mc->agp_end = 0;
+	mc->agp_size = 0;
+}
+
 /**
  * amdgpu_gmc_fault_key - get hask key from vm fault address and pasid
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index fdc25cd559b6..49a28379fc79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -392,6 +392,8 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev,
 			      struct amdgpu_gmc *mc);
 void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
 			     struct amdgpu_gmc *mc);
+void amdgpu_gmc_set_agp_default(struct amdgpu_device *adev,
+				struct amdgpu_gmc *mc);
 bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
 			      struct amdgpu_ih_ring *ih, uint64_t addr,
 			      uint16_t pasid, uint64_t timestamp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index cef920a93924..0dcb6c36b02c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1062,6 +1062,9 @@ static const char * const amdgpu_vram_names[] = {
  */
 int amdgpu_bo_init(struct amdgpu_device *adev)
 {
+	/* set the default AGP aperture state */
+	amdgpu_gmc_set_agp_default(adev, &adev->gmc);
+
 	/* On A+A platform, VRAM can be mapped as WB */
 	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
 		/* reserve PAT memory space to WC for VRAM */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e582073b57c8..e6f76cd19c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -780,7 +780,8 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc);
-	amdgpu_gmc_agp_location(adev, mc);
+	if (!amdgpu_sriov_vf(adev))
+		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
 	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 69f65e9c4f93..0bd7de1488f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -689,7 +689,8 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc);
-	amdgpu_gmc_agp_location(adev, mc);
+	if (!amdgpu_sriov_vf(adev))
+		amdgpu_gmc_agp_location(adev, mc);
 
 	/* base offset of vram pages */
 	if (amdgpu_sriov_vf(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 07579fa26fa3..3f31f268e0eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -253,8 +253,8 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
 	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0);
-	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
+	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 
 	if (gmc_v6_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index e77e5593e1ab..e5e64366a814 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -288,8 +288,8 @@ static void gmc_v7_0_mc_program(struct amdgpu_device *adev)
 	WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
 	       adev->mem_scratch.gpu_addr >> 12);
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0);
-	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
+	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 	if (gmc_v7_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 6acf649469dd..4be407bbb7c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -473,8 +473,8 @@ static void gmc_v8_0_mc_program(struct amdgpu_device *adev)
 	}
 
 	WREG32(mmMC_VM_AGP_BASE, 0);
-	WREG32(mmMC_VM_AGP_TOP, 0);
-	WREG32(mmMC_VM_AGP_BOT, 0x0FFFFFFF);
+	WREG32(mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 22);
+	WREG32(mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 22);
 	if (gmc_v8_0_wait_for_idle((void *)adev))
 		dev_warn(adev->dev, "Wait for MC idle timedout !\n");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2936a0fb7527..e5588408f4a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1696,7 +1696,8 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
 	} else {
 		amdgpu_gmc_vram_location(adev, mc, base);
 		amdgpu_gmc_gart_location(adev, mc);
-		amdgpu_gmc_agp_location(adev, mc);
+		if (!amdgpu_sriov_vf(adev))
+			amdgpu_gmc_agp_location(adev, mc);
 	}
 	/* base offset of vram pages */
 	adev->vm_manager.vram_base_offset = adev->gfxhub.funcs->get_mc_fb_offset(adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2e4a8bdbf50e..c2cb4b4cd2d7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1255,7 +1255,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	agp_top = adev->gmc.agp_end >> 24;
 
 	/* AGP aperture is disabled */
-	if (agp_bot == agp_top) {
+	if (agp_bot > agp_top) {
 		logical_addr_low = adev->gmc.fb_start >> 18;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2)
 			/*
-- 
2.41.0

