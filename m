Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D97C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F1710E8A2;
	Fri,  3 Feb 2023 19:09:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FEE610E8A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZ62VCrnOMfhiFVf3f0NcT3vNou8od+4RQQ1HPJ5cDVh8Cue2VjO+A/iKJz5FC+ioO/4dwwo/XhOytpwTNa7wFd7HOBIwpV+oc9ArWp5qoE5Fx9GTHCa2ndCwd7cmdkTRX/INZ3SKBrngYFCbCQm5KaxANcwewihKb+esA26fB4LC+o5cZGC6YJ139t3hu0uuNPUh8W3FFtN1MFRLQIomo1lCHWEtImklMUfG1tMWBt2I8M8n62R8FWyOgqsvTECjH7zSgQgikwN+uMnRqlcTDVt2BjaoJb2AVDg9ND48cmIRTFm0J9wa/28uJfFhY8FuRLcHqg5D3xeglAgJWxfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlRecioMK97kAaSblmJwdsBUCr6igD2T9XP3WQGsEOQ=;
 b=XwjXRHGAuy97aloiZMORTfP/DC19B0ki2/YJwCyP//myCj7eqk2K41kRTGmvkuzG4JiFebWOVMBjMH8D+zvD5uvkgNcUI8TDt/MAyPy6q6vgah1VPIpjCslQAjZ3rgVa0H0k2a7QecBk/btf/vbOuRCnb140aHaGdDWJ1974euLtVZSRm3ELUGJG83spOC/MPTSrhA70/Gk7fUcx3QRpkdBwuuIP709jccJL2fzO5JFauKTbdCxT3+XJC9j84RpXLpdSHOXe8QmASLauAjfLIPptnNr2smPCfPS0n+hCJnd4UarvBXsLvU1O1al1eabeRvZmpl7gJgPY9uVNeqWEWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlRecioMK97kAaSblmJwdsBUCr6igD2T9XP3WQGsEOQ=;
 b=cngOAOjttC1p+9+lVClPt60pxsp5fICTBSaP5WLmN309nlP16VkRKTwZFbMcbZxkjXi1bQ03fSSXfFPvjlHdHRk4DB5nE4H/E1j2eqYjb06Xrl5qkvB0v3woKRNUeBq+eZfnXcywHtIAkk4gn9QEo+MrE9A/d/IvIgVG2mDYm1c=
Received: from DM6PR08CA0034.namprd08.prod.outlook.com (2603:10b6:5:80::47) by
 PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Fri, 3 Feb
 2023 19:09:22 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::87) by DM6PR08CA0034.outlook.office365.com
 (2603:10b6:5:80::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:21 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:19 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/13] drm/amdgpu: rename gmc.aper_base/size
Date: Fri, 3 Feb 2023 20:08:23 +0100
Message-ID: <20230203190836.1987-7-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d56de0c-b5fb-4c62-41b3-08db061a282d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzN05AJrt178rpbZqKm/8BlWxMoNL/anKcTD/Qq0peCfm5YQIyDa4G76zpe5w3rW5ne6W9XTy86E0KBcsqaVnZuRuf4nASj+ITUCL8yTUDZ9XDQ63tgQ0M5SJ7548XsU3bOuYcgCeCQ9sFodi3/r6mNNzzXw+esIlFzDmeEPZx8bdIFwF8+cqbKJOT6GZfIWQdIWTDxYYNLF6yH4DqWzDv1sGPk5IZaUxJBBbnIi1IpP0LyoKteLg2R9hHkxiUSJx9eETfqIGl4q7lflBWadylfgxPlfaAbALDTA6D8J2PICKC5JZXlg8ETn+JRK6A8PfpwV+JVPxnnNgIoQWFtlSwsLkJHRuEX4FGTxxNWFh5v5t52KPWwDEF8P/JDTSJJ38vpdTFLS0wkuigAgQAdUIhaf6UESUowmhSQlg7lqsYLTWwGnwhps10NBjDJ66/da3Abb4fe32L5heaxXuZiJakc4mcQQiDeJROQLeczzGeoukaTjwcWBp1nYZbT5usKr8G0ijhI4yGGFovLIXn78PT6n1rUbFTzWjGv/0abZ3TNs354B683ifv4PfH/ArHBumKWjJjuUZUH5XK3u18y7XtZkq/S+OG48IbGNc2u+Uz9rX8klawFVHWKm7ZfSHlP/z/Q7IrM/vMvKkImoWEe5lryBaz4v5WYZdlROHA3/XtQ5wS0MbCkoT37h/qW9P2SPDZPg2fgJXC2s+AuDG7nOz0gzgLRFKV+ITcGbqQffx1g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(36840700001)(46966006)(40470700004)(2616005)(6666004)(82310400005)(336012)(47076005)(316002)(426003)(83380400001)(54906003)(44832011)(36756003)(2906002)(82740400003)(30864003)(6916009)(5660300002)(70586007)(478600001)(7696005)(26005)(40460700003)(186003)(8676002)(356005)(8936002)(16526019)(36860700001)(41300700001)(81166007)(70206006)(1076003)(40480700001)(86362001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:21.4934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d56de0c-b5fb-4c62-41b3-08db061a282d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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

This patch renames aper_base and aper_size parameters (in adev->gmc),
to vram_aper_base and vram_aper_size, to differentiate it from the
doorbell BAR.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c       |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c       | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       | 10 +++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  4 ++--
 14 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index f99d4873bf22..58689b2a2d1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -438,7 +438,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 	mem_info->vram_width = adev->gmc.vram_width;
 
 	pr_debug("Address base: %pap public 0x%llx private 0x%llx\n",
-			&adev->gmc.aper_base,
+			&adev->gmc.vram_aper_base,
 			mem_info->local_mem_size_public,
 			mem_info->local_mem_size_private);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
index 0e0f212bd71c..3257da5c3a66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
@@ -701,7 +701,7 @@ int amdgpu_bar_mgr_alloc_sgt(struct amdgpu_device *adev,
 	 */
 	amdgpu_res_first(res, offset, length, &cursor);
 	for_each_sgtable_sg((*sgt), sg, i) {
-		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
+		phys_addr_t phys = cursor.start + adev->gmc.vram_aper_base;
 		size_t size = cursor.size;
 		dma_addr_t addr;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0b6a394e109b..45588b7919fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3961,7 +3961,7 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 	/* Memory manager related */
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		arch_phys_wc_del(adev->gmc.vram_mtrr);
-		arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
+		arch_io_free_memtype_wc(adev->gmc.vram_aper_base, adev->gmc.vram_aper_size);
 	}
 }
 
@@ -5562,14 +5562,14 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
 	uint64_t address_mask = peer_adev->dev->dma_mask ?
 		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
 	resource_size_t aper_limit =
-		adev->gmc.aper_base + adev->gmc.aper_size - 1;
+		adev->gmc.vram_aper_base + adev->gmc.vram_aper_size - 1;
 	bool p2p_access =
 		!adev->gmc.xgmi.connected_to_cpu &&
 		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
 
 	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
 		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
-		!(adev->gmc.aper_base & address_mask ||
+		!(adev->gmc.vram_aper_base & address_mask ||
 		  aper_limit & address_mask));
 #else
 	return false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 02a4c93673ce..c7e64e234de6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -775,7 +775,7 @@ uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo)
  */
 uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo)
 {
-	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
+	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.vram_aper_base;
 }
 
 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 0305b660cd17..bb7076ecbf01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -167,8 +167,8 @@ struct amdgpu_gmc {
 	 * gart/vram_start/end field as the later is from
 	 * GPU's view and aper_base is from CPU's view.
 	 */
-	resource_size_t		aper_size;
-	resource_size_t		aper_base;
+	resource_size_t		vram_aper_size;
+	resource_size_t		vram_aper_base;
 	/* for some chips with <= 32MB we need to lie
 	 * about vram size near mc fb location */
 	u64			mc_vram_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ca85d64a72c2..887fc53a7d16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1046,8 +1046,8 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
 	/* On A+A platform, VRAM can be mapped as WB */
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		/* reserve PAT memory space to WC for VRAM */
-		int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
-				adev->gmc.aper_size);
+		int r = arch_io_reserve_memtype_wc(adev->gmc.vram_aper_base,
+				adev->gmc.vram_aper_size);
 
 		if (r) {
 			DRM_ERROR("Unable to set WC memtype for the aperture base\n");
@@ -1055,13 +1055,13 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
 		}
 
 		/* Add an MTRR for the VRAM */
-		adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
-				adev->gmc.aper_size);
+		adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.vram_aper_base,
+				adev->gmc.vram_aper_size);
 	}
 
 	DRM_INFO("Detected VRAM RAM=%lluM, BAR=%lluM\n",
 		 adev->gmc.mc_vram_size >> 20,
-		 (unsigned long long)adev->gmc.aper_size >> 20);
+		 (unsigned long long)adev->gmc.vram_aper_size >> 20);
 	DRM_INFO("RAM width %dbits %s\n",
 		 adev->gmc.vram_width, amdgpu_vram_names[adev->gmc.vram_type]);
 	return amdgpu_ttm_init(adev);
@@ -1083,7 +1083,7 @@ void amdgpu_bo_fini(struct amdgpu_device *adev)
 
 		if (!adev->gmc.xgmi.connected_to_cpu) {
 			arch_phys_wc_del(adev->gmc.vram_mtrr);
-			arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
+			arch_io_free_memtype_wc(adev->gmc.vram_aper_base, adev->gmc.vram_aper_size);
 		}
 		drm_dev_exit(idx);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 196ba62ef721..bb2230d14ea6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -583,7 +583,7 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 			mem->bus.addr = (u8 *)adev->mman.vram_aper_base_kaddr +
 					mem->bus.offset;
 
-		mem->bus.offset += adev->gmc.aper_base;
+		mem->bus.offset += adev->gmc.vram_aper_base;
 		mem->bus.is_iomem = true;
 		break;
 	default:
@@ -600,7 +600,7 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
 
 	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
 			 &cursor);
-	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
+	return (adev->gmc.vram_aper_base + cursor.start) >> PAGE_SHIFT;
 }
 
 /**
@@ -1752,12 +1752,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 #ifdef CONFIG_64BIT
 #ifdef CONFIG_X86
 	if (adev->gmc.xgmi.connected_to_cpu)
-		adev->mman.vram_aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
+		adev->mman.vram_aper_base_kaddr = ioremap_cache(adev->gmc.vram_aper_base,
 				adev->gmc.visible_vram_size);
 
 	else
 #endif
-		adev->mman.vram_aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
+		adev->mman.vram_aper_base_kaddr = ioremap_wc(adev->gmc.vram_aper_base,
 				adev->gmc.visible_vram_size);
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 21e46817d82d..b2e4f4f06bdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -825,18 +825,18 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
+	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
-		adev->gmc.aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
-		adev->gmc.aper_size = adev->gmc.real_vram_size;
+		adev->gmc.vram_aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
+		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
 	}
 #endif
 
 	/* In case the PCI BAR is larger than the actual amount of vram */
-	adev->gmc.visible_vram_size = adev->gmc.aper_size;
+	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
 	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4326078689cd..f993ce264c3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -692,17 +692,17 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
+	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
-		adev->gmc.aper_base = adev->mmhub.funcs->get_mc_fb_offset(adev);
-		adev->gmc.aper_size = adev->gmc.real_vram_size;
+		adev->gmc.vram_aper_base = adev->mmhub.funcs->get_mc_fb_offset(adev);
+		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
 	}
 #endif
 	/* In case the PCI BAR is larger than the actual amount of vram */
-	adev->gmc.visible_vram_size = adev->gmc.aper_size;
+	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
 	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index ec291d28edff..cd159309e9e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -324,9 +324,9 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
-	adev->gmc.visible_vram_size = adev->gmc.aper_size;
+	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
+	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
 
 	/* set the gart size */
 	if (amdgpu_gart_size == -1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 979da6f510e8..8ee9731a0c8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -377,20 +377,20 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
+	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) &&
-	    adev->gmc.real_vram_size > adev->gmc.aper_size &&
+	    adev->gmc.real_vram_size > adev->gmc.vram_aper_size &&
 	    !amdgpu_passthrough(adev)) {
-		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
-		adev->gmc.aper_size = adev->gmc.real_vram_size;
+		adev->gmc.vram_aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
+		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
 	}
 #endif
 
 	/* In case the PCI BAR is larger than the actual amount of vram */
-	adev->gmc.visible_vram_size = adev->gmc.aper_size;
+	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
 	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 382dde1ce74c..259d797358f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -577,18 +577,18 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
+	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
 	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
-		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
-		adev->gmc.aper_size = adev->gmc.real_vram_size;
+		adev->gmc.vram_aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
+		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
 	}
 #endif
 
 	/* In case the PCI BAR is larger than the actual amount of vram */
-	adev->gmc.visible_vram_size = adev->gmc.aper_size;
+	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
 	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 08d6cf79fb15..a7074995d97e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1509,8 +1509,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 	}
-	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
-	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
+	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
+	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
 
 #ifdef CONFIG_X86_64
 	/*
@@ -1528,16 +1528,16 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
 	    (adev->gmc.xgmi.supported &&
 	     adev->gmc.xgmi.connected_to_cpu)) {
-		adev->gmc.aper_base =
+		adev->gmc.vram_aper_base =
 			adev->gfxhub.funcs->get_mc_fb_offset(adev) +
 			adev->gmc.xgmi.physical_node_id *
 			adev->gmc.xgmi.node_segment_size;
-		adev->gmc.aper_size = adev->gmc.real_vram_size;
+		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
 	}
 
 #endif
 	/* In case the PCI BAR is larger than the actual amount of vram */
-	adev->gmc.visible_vram_size = adev->gmc.aper_size;
+	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
 	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
 		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 10048ce16aea..c86c6705b470 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -1002,8 +1002,8 @@ int svm_migrate_init(struct amdgpu_device *adev)
 	 */
 	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
 	if (adev->gmc.xgmi.connected_to_cpu) {
-		pgmap->range.start = adev->gmc.aper_base;
-		pgmap->range.end = adev->gmc.aper_base + adev->gmc.aper_size - 1;
+		pgmap->range.start = adev->gmc.vram_aper_base;
+		pgmap->range.end = adev->gmc.vram_aper_base + adev->gmc.vram_aper_size - 1;
 		pgmap->type = MEMORY_DEVICE_COHERENT;
 	} else {
 		res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);
-- 
2.34.1

