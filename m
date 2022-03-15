Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBE9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 18:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D77910E267;
	Tue, 15 Mar 2022 18:13:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD26410E267
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 18:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEfA2qSB6tAE6E89aUinP3bmSaJlq44cca69qq8/c55NrJPbXoYemPx5SyGo658LGTVT0iOvFBO6xXfqucJX3Eak3AoJgsPITCEq/s6yIvuVP2TH4vCrb+9X8s/Ho4FcFj5eQbpqXwCd8rBTdFOg5M6aJLRgTVej2TQ/YAqhIvG6XMRgZ+TxanXT18raA9/z2ku49Sns3+zkCT2ZMV+ndK1b9XARI3Aic+j4nc1AHgKP0VCpedMGev/Zk+9utck+tA1P+sJq0GYh10HP2pM786p47KCqJ2/jlQFm5b560Q7YsYzCKkl8eDJmD9XutZC7iXGe2v/MUCkd2qqwbiYkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpiig9JOxAeN7yhJYqcoRyv5XczfBqekbjWPLqN74CM=;
 b=ePRAQUrlpFsd+8rD0f+DKwQTFcpnLKSuyfoqA0+40Dow/GuC/1NMc8EbZ1p1EBsRtmf7hdh/Am/ujsIIdN9/ZQ5C6YHq+QDBdYJNMWlokui5WZ78ozpkQ0GdR5rsOlxx/lTrPDSluuN+v9YkuzgzQvu/uDqH01uSPPdxHbpWA1oTdu7VV2c40P1bOfIpATixeiv91sMH+8fC7+dXg1yPIcPUkZxQlZvYgsyWuUPP4qJzvP5QzpqrKAAQfdm66IqG7B3leHHur5R76y3hoZDSwNVH9VM/xMbrDIZTP2gmuhQTs5JiFwvjzmraniy9EekoQOBBX0m2LEZORSJZo0c6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpiig9JOxAeN7yhJYqcoRyv5XczfBqekbjWPLqN74CM=;
 b=4N5lve92yUWDmRgGPINHu8X4j5TLW6CkZQAGPfanVbEj0UtPGiThCoCG5hfdErXa7FLVvEV4H4x/fVuzvYglQiaE7yiz6SbM3/1yFsT+NTAgQZwoZ+/+ttsOwsDogUm0NnqUHP4AFnhJ2WMb8A6RDEhpjVtEJ+nphVffSfgi6UI=
Received: from DM5PR12CA0055.namprd12.prod.outlook.com (2603:10b6:3:103::17)
 by MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 18:13:15 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:103:cafe::8) by DM5PR12CA0055.outlook.office365.com
 (2603:10b6:3:103::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Tue, 15 Mar 2022 18:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 15 Mar 2022 18:13:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 15 Mar
 2022 13:13:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
Date: Tue, 15 Mar 2022 14:13:00 -0400
Message-ID: <20220315181300.2808453-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d5a6bff-2b6c-4b91-eb26-08da06af78f5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB300840FE8C4563229098B9CEF7109@MN2PR12MB3008.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fW3yJhMSzBf6pO729ihCBYRsuJG4uSLRZoBDSmCEUbGAjlm8OQun4YUJD81btgmhkVsDVFPbZbXwDGkbfAa2/ya4ciKAN7keEdKIkqazOTVW/4Km0gv134b+ZJnWFrs0aezTOkGtoHRlIpvmu/lA5UMLl6A3Q9cPuP3rWd+yEbJQDIOT6ESnQhwZo3u5T4PmCf7mlArh9+IR1fZGjIe2rhTrk//RV/5YtttNvrzta9KFZCoM1Qf41Ji0pdoU7cD38VhpfKFdHBZ/aI9rmwbo4yX1jl2Q0gl7Sxfaale/rTBKVfTSOsdrpJhF1rCvdjq+5eRsmxc7X8pn18fh5r8B2xlQ4igBR+PmWrCcW/j7UrGho/z5DLhkUj/sFCM/x74XAxh0NZ5gdwewTFuq5dPj5K4+M/KebkX5v+Ptx9q5z78ZnXQ68VAO8FUQ0nA85Xsw+aAXIsshS9NdUzHxX+RJKDr/U6EQVuc9KFLc+WhkByde4fTLUfwgCjlEnEIHnuYfi7wZPstsAm49XZr41831tvaXQBqjnT5quDCbJ0LbHwSrQdyXGPb0OIVPyWnms3Rl+3yWML2A70NhBb8sXJJ3co7aA+MSdLPmDwiGRbjUnVq517sGHlKhVmGK5KiSanGmQvt5LizcjFbGpc8n3/+SlqtXyhMg3f3bf73kPwEhj/HMRw+UgsOf1tFTwm6Z0eY5xRkFKNpuTMeq7hfRcmXdYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(4326008)(6916009)(86362001)(82310400004)(5660300002)(8936002)(70206006)(70586007)(8676002)(316002)(83380400001)(336012)(426003)(40460700003)(2616005)(47076005)(36860700001)(7696005)(81166007)(356005)(6666004)(1076003)(16526019)(186003)(26005)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 18:13:14.3834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5a6bff-2b6c-4b91-eb26-08da06af78f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3008
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

If the GPU is passed through to a guest VM, use the PCI
BAR for CPU FB access rather than the physical address of
carve out.  The physical address is not valid in a guest.

v2: Fix HDP handing as suggested by Michel

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1b313a95c7e5..eb902654f35d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5733,7 +5733,7 @@ void amdgpu_device_flush_hdp(struct amdgpu_device *adev,
 		struct amdgpu_ring *ring)
 {
 #ifdef CONFIG_X86_64
-	if (adev->flags & AMD_IS_APU)
+	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
 		return;
 #endif
 	if (adev->gmc.xgmi.connected_to_cpu)
@@ -5749,7 +5749,7 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
 		struct amdgpu_ring *ring)
 {
 #ifdef CONFIG_X86_64
-	if (adev->flags & AMD_IS_APU)
+	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
 		return;
 #endif
 	if (adev->gmc.xgmi.connected_to_cpu)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f60b7bd4dbf5..9887a60e8eae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -814,7 +814,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
-	if (adev->flags & AMD_IS_APU) {
+	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
 		adev->gmc.aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
 		adev->gmc.aper_size = adev->gmc.real_vram_size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 344d819b4c1b..979da6f510e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -381,8 +381,9 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
-	if (adev->flags & AMD_IS_APU &&
-	    adev->gmc.real_vram_size > adev->gmc.aper_size) {
+	if ((adev->flags & AMD_IS_APU) &&
+	    adev->gmc.real_vram_size > adev->gmc.aper_size &&
+	    !amdgpu_passthrough(adev)) {
 		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
 		adev->gmc.aper_size = adev->gmc.real_vram_size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index ca9841d5669f..1932a3e4af7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -581,7 +581,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
-	if (adev->flags & AMD_IS_APU) {
+	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
 		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
 		adev->gmc.aper_size = adev->gmc.real_vram_size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 431742eb7811..5fa613d41799 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1456,7 +1456,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	 */
 
 	/* check whether both host-gpu and gpu-gpu xgmi links exist */
-	if ((adev->flags & AMD_IS_APU) ||
+	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
 	    (adev->gmc.xgmi.supported &&
 	     adev->gmc.xgmi.connected_to_cpu)) {
 		adev->gmc.aper_base =
-- 
2.35.1

