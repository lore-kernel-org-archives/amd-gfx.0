Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320B4C636CC
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CEB610E89D;
	Fri,  3 Feb 2023 19:09:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E50B10E89C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnJMp4vYX+QAMXgm8Vstjur/UCT3p0w0ZF19RTxH2gVdGqpYEQwrasCMG3MwmFvIpWUbnOpNUF2vSL8Bk6W1TFFfjZul0/M2XPwQm64O1la+fuBvcXlSgcTwpxdHWsrsK2DE1n64iKV4O9xbpplAfv5fE+KaFSLzmZO4cUHmAmLLFQBDX1m4+b7qdqEUWCP4lPPrd5EAn8cYelWsxI0hw6L/gdyL80Rs4itbDCt30iK31QGM7pUwuBovTBVkOqa6QCvIDPuwBxEUG1eKOoNqpY6Zs4wRugbFGxsEsR4JTrNBJc7QiU5vu5STrAP334YevYc+JDD2/NzjJslwc6eYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aljnhdOpoTKL3Y445vZSenzAESTdB9rAusAlQTwGIE0=;
 b=oT4LHj9AYPC/QEVU+I3jhUEu2quO8tNf9WUNqMWyHz5cWoFm2jw9ygDO6+bfr/b9jsY7Cw5xv0l+O0dnjqalLTsvQjdDkSxAH5RZuhsH6ov/fDm82GiOz7ck06fulSfb77pWfHJB0KMQEo78XTugAg0FqcINCbUswiT2q/sJrJZ8iKOAvjBYbDC/sLiCAoVjQSM9wZeIVZ9Sve84j8yFNGOWA/A26Y0KxiJD7ACd7yOtwx9/V3k5ytySK+aUiNz7Gbf7158oDjNdJg14bCE4Qt5VKGKGimeAkPKjUw/svj6iSjhsPXZH0IYmmgQ4yAt25+WUEjXAmEQtNy2oUuMMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aljnhdOpoTKL3Y445vZSenzAESTdB9rAusAlQTwGIE0=;
 b=3NJRc+ZtsHuHSEu+ntOG+BrZjh0PivKRRv5Cu24weiq+y+CLxjhilGXs24SocVvC9fKDSgF2qoJHYJkHIRmCfxAkN/jJtipiBUSKWgNQt5E5AcdIH1zAX6Ul4SEYf0/tbbvhg74qwoa0JMc0Gm+X6yyIo6DqbIPLjnxajofMydE=
Received: from DM6PR12CA0016.namprd12.prod.outlook.com (2603:10b6:5:1c0::29)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Fri, 3 Feb
 2023 19:09:22 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::a6) by DM6PR12CA0016.outlook.office365.com
 (2603:10b6:5:1c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:22 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:20 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/13] drm/amdgpu: store doorbell info in gmc structure
Date: Fri, 3 Feb 2023 20:08:24 +0100
Message-ID: <20230203190836.1987-8-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203190836.1987-1-shashank.sharma@amd.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 729fbc07-f336-4cc7-dedf-08db061a289c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2elxRvhvcSFuRF4Y6DGXy/t9v121pEjIJzE+riCW7I0B4Yv9w87KID8e8QdcUfye8CplOPsYbaFgfbN12JrK/H/l4tJF4kJRx+dB6f4Lc8ZvI/XX634d9aDfr41PqI9ox1PFRWLsQCaV0X2smkBISquxu41x2d3O18aWeBVjeDFGB0lLwZR5dgUgcKlL+Il8D3U+h53K7XuiWxH0ZZm2AY1xET1VSuZS0jp6KKP06HIABWu+y1D8yjn0+r/Nl2BAr5p36sJ2hSV0XwSA1hElYw5V3slknGTplB7m0xT2QuEYb8HZ/tpBPmDVL03YAhDTBx4GG9Gjn4J6Iaka5eOGwbokSycOTyOfOjWkQPwMUCOuIYkJsEtHVdHvatVbOI9qVDM2Ks843rUHEwUGQSPlMundtUmM/NkkWYPUql2J4lz+2xzupgChwiWZHX/OSwK27yHealGW5EnyUlBsYnQLaqDygGQxwbGKIWo+M9fecDup4C9EjmmAkD4PjmGNDiKUYchYGgLVX7rw+VePhpeurZWc42+NedMORTIfbI0f2H6iR0X1IrIzfmqDcXT3KbPpN9vCHmDZutaTD2zZsX/I7PEK5ISSEcIQgAnDaj38ISEiWMuW44F8gXrwbRaIQn/oXY3vm3FEz4MhNhxJRawtKEALVWfxRG1pJK3FOevi4wu9zDjSXUr5r37V0XL2VrO/8uXSZj9iZGsE79uRp6AnHHuWO0Vhui+TExvD26NFbqs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(36756003)(82740400003)(26005)(7696005)(54906003)(70586007)(1076003)(478600001)(316002)(30864003)(2906002)(44832011)(8676002)(6916009)(70206006)(5660300002)(8936002)(41300700001)(4326008)(36860700001)(356005)(336012)(86362001)(81166007)(2616005)(40480700001)(47076005)(16526019)(186003)(426003)(82310400005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:22.2249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729fbc07-f336-4cc7-dedf-08db061a289c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch moves doorbell info into adev->gmc structure, to align
with vram info. This will prepare structures for proper ttm management
of the doorbell BAR.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h      |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c       |  4 ++--
 13 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 58689b2a2d1c..28076da2258f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -106,13 +106,13 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
 		 * not initialized as AMDGPU manages the whole
 		 * doorbell space.
 		 */
-		*aperture_base = adev->doorbell.base;
+		*aperture_base = adev->gmc.doorbell_aper_base;
 		*aperture_size = 0;
 		*start_offset = 0;
-	} else if (adev->doorbell.size > adev->doorbell.num_doorbells *
+	} else if (adev->gmc.doorbell_aper_size > adev->doorbell.num_doorbells *
 						sizeof(u32)) {
-		*aperture_base = adev->doorbell.base;
-		*aperture_size = adev->doorbell.size;
+		*aperture_base = adev->gmc.doorbell_aper_base;
+		*aperture_size = adev->gmc.doorbell_aper_size;
 		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
 	} else {
 		*aperture_base = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
index 3257da5c3a66..0656e5bb4f05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
@@ -209,7 +209,7 @@ static ssize_t amdgpu_mem_info_doorbell_total_show(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 
-	return sysfs_emit(buf, "%llu\n", adev->doorbell.size);
+	return sysfs_emit(buf, "%llu\n", adev->gmc.doorbell_aper_size);
 }
 
 /**
@@ -897,7 +897,7 @@ int amdgpu_bar_mgr_init(struct amdgpu_device *adev, u32 domain)
 		size = adev->gmc.real_vram_size;
 	} else if (domain == AMDGPU_PL_DOORBELL) {
 		mgr = &adev->mman.doorbell_mgr;
-		size = adev->doorbell.size;
+		size = adev->gmc.doorbell_aper_size;
 	} else {
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 45588b7919fe..16580d9580d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1035,8 +1035,8 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 
 	/* No doorbell on SI hardware generation */
 	if (adev->asic_type < CHIP_BONAIRE) {
-		adev->doorbell.base = 0;
-		adev->doorbell.size = 0;
+		adev->gmc.doorbell_aper_base = 0;
+		adev->gmc.doorbell_aper_size = 0;
 		adev->doorbell.num_doorbells = 0;
 		adev->doorbell.ptr = NULL;
 		return 0;
@@ -1048,15 +1048,15 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 	amdgpu_asic_init_doorbell_index(adev);
 
 	/* doorbell bar mapping */
-	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
-	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
+	adev->gmc.doorbell_aper_base = pci_resource_start(adev->pdev, 2);
+	adev->gmc.doorbell_aper_size = pci_resource_len(adev->pdev, 2);
 
 	if (adev->enable_mes) {
 		adev->doorbell.num_doorbells =
-			adev->doorbell.size / sizeof(u32);
+			adev->gmc.doorbell_aper_size / sizeof(u32);
 	} else {
 		adev->doorbell.num_doorbells =
-			min_t(u32, adev->doorbell.size / sizeof(u32),
+			min_t(u32, adev->gmc.doorbell_aper_size / sizeof(u32),
 			      adev->doorbell_index.max_assignment+1);
 		if (adev->doorbell.num_doorbells == 0)
 			return -EINVAL;
@@ -1071,7 +1071,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 			adev->doorbell.num_doorbells += 0x400;
 	}
 
-	adev->doorbell.ptr = ioremap(adev->doorbell.base,
+	adev->doorbell.ptr = ioremap(adev->gmc.doorbell_aper_base,
 				     adev->doorbell.num_doorbells *
 				     sizeof(u32));
 	if (adev->doorbell.ptr == NULL)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 7199b6b0be81..c6324970eb79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -25,9 +25,6 @@
  * GPU doorbell structures, functions & helpers
  */
 struct amdgpu_doorbell {
-	/* doorbell mmio */
-	resource_size_t		base;
-	resource_size_t		size;
 	u32 __iomem		*ptr;
 	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index bb7076ecbf01..2a6636a7f27b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -173,6 +173,13 @@ struct amdgpu_gmc {
 	 * about vram size near mc fb location */
 	u64			mc_vram_size;
 	u64			visible_vram_size;
+	/* DOORBELL's physical address in MMIO space (for CPU to
+	 * map DOORBELL). This is different compared to the agp/
+	 * gart/vram_start/end field as the later is from
+	 * GPU's view and aper_base is from CPU's view.
+	 */
+	resource_size_t		doorbell_aper_size;
+	resource_size_t		doorbell_aper_base;
 	/* AGP aperture start and end in MC address space
 	 * Driver find a hole in the MC address space
 	 * to place AGP by setting MC_VM_AGP_BOT/TOP registers
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0c546245793b..1e09c3267c8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -126,7 +126,7 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 		roundup(doorbell_start_offset,
 			amdgpu_mes_doorbell_process_slice(adev));
 
-	doorbell_aperture_size = adev->doorbell.size;
+	doorbell_aperture_size = adev->gmc.doorbell_aper_size;
 	doorbell_aperture_size =
 			rounddown(doorbell_aperture_size,
 				  amdgpu_mes_doorbell_process_slice(adev));
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f202b45c413c..ebc17884df1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3526,7 +3526,7 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 		 */
 		if (check_if_enlarge_doorbell_range(adev))
 			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
-					(adev->doorbell.size - 4));
+					(adev->gmc.doorbell_aper_size - 4));
 		else
 			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
 					(adev->doorbell_index.userqueue_end * 2) << 2);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index aa761ff3a5fa..5969c159d7a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -173,9 +173,9 @@ static void nbio_v2_3_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
 
 		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			     lower_32_bits(adev->doorbell.base));
+			     lower_32_bits(adev->gmc.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			     upper_32_bits(adev->doorbell.base));
+			     upper_32_bits(adev->gmc.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_CNTL,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index 15eb3658d70e..5ff12887ffab 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -169,9 +169,9 @@ static void nbio_v4_3_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
 
 		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			     lower_32_bits(adev->doorbell.base));
+			     lower_32_bits(adev->gmc.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			     upper_32_bits(adev->doorbell.base));
+			     upper_32_bits(adev->gmc.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index 37615a77287b..1465e74e9122 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -121,9 +121,9 @@ static void nbio_v6_1_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_SIZE, 0);
 
 		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			     lower_32_bits(adev->doorbell.base));
+			     lower_32_bits(adev->gmc.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			     upper_32_bits(adev->doorbell.base));
+			     upper_32_bits(adev->gmc.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, tmp);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index 31776b12e4c4..33bc23564870 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -175,10 +175,10 @@ static void nbio_v7_2_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 
 		WREG32_SOC15(NBIO, 0,
 			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			lower_32_bits(adev->doorbell.base));
+			lower_32_bits(adev->gmc.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0,
 			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			upper_32_bits(adev->doorbell.base));
+			upper_32_bits(adev->gmc.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 19455a725939..4ce9d78aee1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -223,9 +223,9 @@ static void nbio_v7_4_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 		      REG_SET_FIELD(tmp, DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_SIZE, 0);
 
 		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			     lower_32_bits(adev->doorbell.base));
+			     lower_32_bits(adev->gmc.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			     upper_32_bits(adev->doorbell.base));
+			     upper_32_bits(adev->gmc.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_CNTL, tmp);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index def89379b51a..1f1fa8cc4790 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -132,10 +132,10 @@ static void nbio_v7_7_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 
 		WREG32_SOC15(NBIO, 0,
 			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			lower_32_bits(adev->doorbell.base));
+			lower_32_bits(adev->gmc.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0,
 			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			upper_32_bits(adev->doorbell.base));
+			upper_32_bits(adev->gmc.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
-- 
2.34.1

