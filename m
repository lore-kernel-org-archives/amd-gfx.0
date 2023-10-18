Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23073CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 13:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF6410E3EE;
	Wed, 18 Oct 2023 13:13:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3A510E3E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 13:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oo6Lu2XQqNIwkHEEhNt5Yw7tyWBigb//16yPYVmoB/jow5K9hei5Tn89VGBTECYoGrVYJCYsqDayHhVi5+S0gQhP/+tY98OyKZ1GZlGjPbpXZzvHKs6t0GGoetMFHsMhNuv3OzDPqGSANxZHWpvRwzzZ3Vnjftdvcx3rF4AbJDGFwaWyrptlY1Uf7+WFMXekQvTC16SWzArI6CNtmDMyk8zSxJXmnFW0cuZugJjPJtSesWh9GiIA2ONXjfrLXIZOJQGAMbqeDxSGAx7Oth1987mg6PRleECxqlZ9EEWqUFLuO52szi9T53PH+EMzJydTwg/LHzcm4hW9C/+FxDZKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTUsRlrlHlBtLaWXXiLuXEzWLMWrADutyryBYN9DS0I=;
 b=Wr949TkZwIXDyh9I6w4hx4ikqD108DBuszOqbxAtEGP+4mDmeSYsOBwWHc/8bqg5zIO5uHxm64h1HLZ3VYWQKOJ2bLKVMj3LWyMrPR9XyUKbSUvb10Ii64nZbozeo4YQafVVMwltaamYvx5J8sfZ9LCN1HFx/Y3y2P0p1pssUck/ZUW5zS+emtcFMHovetP9zjQCOGm++e9nVfcT0S6tP1fDdXtIJNxecqekV9wedpMOdfNETX2VFVkF2j6FqgA9yRglt0P+VtM6/J6TO5iK15CuIMJ3IWT2NdB1l40XC/sDbNEfclKFNB88Kllg7VA4AA5HuoTDrpNHOFl5vvqQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTUsRlrlHlBtLaWXXiLuXEzWLMWrADutyryBYN9DS0I=;
 b=RXqOT233YiHY/K0KI+pq4u4bTBdzbeQCiEk2XyU5wgIf6seAghN5Yak6dOzf0p4Y3rAvjX/aAWYY8JHMyXA3vQMs0cWBTkg2DPeFKXIV4XuDpv8SHGAJKhqLIQv1PzxYsYhH78RHFUx7NLtsRIUWmGLs8t34nvmWpM3FgvwodKE=
Received: from BYAPR02CA0023.namprd02.prod.outlook.com (2603:10b6:a02:ee::36)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Wed, 18 Oct 2023 13:13:29 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::df) by BYAPR02CA0023.outlook.office365.com
 (2603:10b6:a02:ee::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 13:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 13:13:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 08:13:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: don't use pci_is_thunderbolt_attached()
Date: Wed, 18 Oct 2023 09:13:09 -0400
Message-ID: <20231018131309.2306113-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018131309.2306113-1-alexander.deucher@amd.com>
References: <20231018131309.2306113-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6e74e8-85b0-428d-db6a-08dbcfdc0556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YurenJWay0i4DipdnAhVdGYPuYtjoz4MwdOWJV+KFdiPbsvXverfbuDNyttVNadp+PsZwiJ+Kelux1/TpUHc7oVNpM9E/SKdB3eruwpIXxj0h/wBraxE2wWppFpl7zXrLS0aNZRlNbu3WGlRuSN8K7hz+WlOUhfJfRLXW8aL7a7k/GSNYZU8tFSB/yt3dLjwrurM0LzbTekq/AyIBO7U4JJ4A98FGDyMBA8P5dOwNoFps8xA0HuUEYKJ9TjQV/MXNi0OkWzkzkQeYfV1bq4WaN9rg36lfPvZP9O2PPFfIEIIrtitf0LPx8jhtzRfoJlZLGlyDEGA3EvoLo9cAxs46diMk4lX8rISlEbP4a+eHSOQzkdEC+FsrZZW+iFeo3fE8wU86OpZqSrMsW2FCGIbl/hEn1vP1BjUxFLuFa2OHRueYT25loI1UBFgIxlSL8hXcI+LDctAaSExot/80fIrKuqzRlu9EvuHbiMBzVm9x/2UvywIqFNN8v/xgb0kBg01G5uQ6BodvepUVh+/LDW2kyq60Atg/y79ahmxTtvjo5mAm+OJYj6sm18j/Gbs64PHK/dKfD/9xWlDnVtY/lBXVoZiLXlsqwL2WSBotIttvC8xcbEmPSfuxRK53GWYbt4Ul70/QwESlfFAWMde3Mbm4zMlb3+musAAMOGf9jlwiY+xzmvWKL8/Cajc+1mk0xMYHoeJhUJWh55AtoHJVYbtddnJ+SN3Mm+GSQdFM3gSNISbFW+eegLM4HJkG474hoIu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(83380400001)(426003)(336012)(16526019)(26005)(36756003)(1076003)(5660300002)(8936002)(4326008)(8676002)(41300700001)(2616005)(40460700003)(86362001)(40480700001)(356005)(82740400003)(6666004)(47076005)(36860700001)(966005)(2906002)(7696005)(70206006)(316002)(6916009)(70586007)(81166007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 13:13:29.1609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6e74e8-85b0-428d-db6a-08dbcfdc0556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
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

It's only valid on Intel systems with the Intel VSEC.
Use dev_is_removable() instead.  This should do the right
thing regardless of the platform.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c     | 5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0f98f720d9ca..679b4b714c04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -43,6 +43,7 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/amdgpu_drm.h>
+#include <linux/device.h>
 #include <linux/vgaarb.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/efi.h>
@@ -2232,7 +2233,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
  */
 static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
-	struct drm_device *dev = adev_to_drm(adev);
 	struct pci_dev *parent;
 	int i, r;
 	bool total;
@@ -2303,7 +2303,7 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	    (amdgpu_is_atpx_hybrid() ||
 	     amdgpu_has_atpx_dgpu_power_cntl()) &&
 	    ((adev->flags & AMD_IS_APU) == 0) &&
-	    !pci_is_thunderbolt_attached(to_pci_dev(dev->dev)))
+	    !dev_is_removable(&adev->pdev->dev))
 		adev->flags |= AMD_IS_PX;
 
 	if (!(adev->flags & AMD_IS_APU)) {
@@ -4132,7 +4132,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	px = amdgpu_device_supports_px(ddev);
 
-	if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
+	if (px || (!dev_is_removable(&adev->pdev->dev) &&
 				apple_gmux_detect(NULL, NULL)))
 		vga_switcheroo_register_client(adev->pdev,
 					       &amdgpu_switcheroo_ops, px);
@@ -4280,7 +4280,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 	px = amdgpu_device_supports_px(adev_to_drm(adev));
 
-	if (px || (!pci_is_thunderbolt_attached(adev->pdev) &&
+	if (px || (!dev_is_removable(&adev->pdev->dev) &&
 				apple_gmux_detect(NULL, NULL)))
 		vga_switcheroo_unregister_client(adev->pdev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index e523627cfe25..df218d5ca775 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -28,6 +28,7 @@
 #include "nbio/nbio_2_3_offset.h"
 #include "nbio/nbio_2_3_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
+#include <linux/device.h>
 #include <linux/pci.h>
 
 #define smnPCIE_CONFIG_CNTL	0x11180044
@@ -361,7 +362,7 @@ static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
 
 		data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
 
-		if (pci_is_thunderbolt_attached(adev->pdev))
+		if (dev_is_removable(&adev->pdev->dev))
 			data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
 		else
 			data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
@@ -480,7 +481,7 @@ static void nbio_v2_3_program_aspm(struct amdgpu_device *adev)
 
 	def = data = RREG32_PCIE(smnPCIE_LC_CNTL);
 	data |= NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
-	if (pci_is_thunderbolt_attached(adev->pdev))
+	if (dev_is_removable(&adev->pdev->dev))
 		data |= NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT  << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
 	else
 		data |= NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
-- 
2.41.0

