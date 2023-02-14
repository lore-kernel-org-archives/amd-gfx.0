Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4839BC61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 16:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE98910E91D;
	Tue, 14 Feb 2023 16:15:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559D210E91D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 16:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGXCjAhRiqSGcQoV6gncbJT/9cjobGhHFRQPUBh6eU6VXQnFp+6UdJP7NZJ3eZj+tQI9pjKLG33X6J0N5tUT2Iya5q570G+wJsW/b5f8bjGOLmB2HrxelR3ksCpmgzMBifSrONNgccMRwd5BfBjvD8fCkQsefWZ+Fa/5wIwVApXVHyOn0ZAWQ8IFCfpf4e8UTMij77UyytK4D6pmdlTPWPNg2mzXklFQdiYfmTuz9To+mQqqcUPU4WEj6AC24uMXdBXypKFdvrdGoEAmU37RaJxEEcfUaxKley1uktTWH0N0ritNrHwSaYAOdOQ8fDod232pbRDWTMfh3sQh4w/zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpkxIMrA786spOckbBi3qQwmorL0gUl+C+9KiGM4DI4=;
 b=HdUoNrKNnJ/V5+Cg8rs4WqDMLWzX+MgUU/3wNTev85i35LB1l6894qf05uHEVpl8nmCXkFMJrIEs0HVaDAI3sGlzolrZ66ikOW+X0Wr4X42D2qJ3yuyOZ9pAY5l5ckotao9MIt9O2gDwGEHVrrNaivSuKONXgWalrX8bDg1IrVx4hUr9E96t8M4rXJuWAQ4gANimMQiGyRe/OBbYRb0SvzvcDSKTld12gtY+jmg3+7tPBBhPsDIA0I24rdR7XLMCp7VAlL6vJ7eXwDHwj7ULdFb1KfiqgK9HHxFCRKa78JIfbWsZiwJoic7xMgeOhjVnoPqLM9h2uX3jCqBKr0yYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpkxIMrA786spOckbBi3qQwmorL0gUl+C+9KiGM4DI4=;
 b=d7OqEeksFiwoQKlPISnMSr9mjMnfz8iBGL9iZTJFM8uehd+dLjfbP2eSKIZtGEJVQV0NYqnQgrm8YSDPhZ503cx0UjADwOK6sYqDsZdTn9+Su9tLFe6u9GxzlHYSBoHuIdtlNPTxR6bVcjQ75WrRXKWqCcK8W3en7wFVHn8Skmw=
Received: from MW2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:907:1::15)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Tue, 14 Feb
 2023 16:15:48 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::f3) by MW2PR16CA0038.outlook.office365.com
 (2603:10b6:907:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Tue, 14 Feb 2023 16:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 16:15:47 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 10:15:45 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/8] drm/amdgpu: replace aper_base_kaddr with
 vram_aper_base_kaddr
Date: Tue, 14 Feb 2023 17:15:04 +0100
Message-ID: <20230214161510.2153-3-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230214161510.2153-1-shashank.sharma@amd.com>
References: <20230214161510.2153-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba0f068-d608-46a0-1246-08db0ea6bbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cr2IQIi3mogjMKxI2dQCMbvwswZCy4MHYrEpXwq78zysQ45mXSZEfZL1eKuf7ml1FXqJxJSOrg++1AylRg9wptLk7xCirY+xzvqvIYb05oMg4//lX/NTQin0WctV2YSQMzJDflywXcUp2CdoX/9Ik5zUQ3qfONMrUAAuZHpevTPvpJ05/U/WMrPtFSvprXbOmePx7Mixro2daWwO8JJtl+KwsSffuNAJ8ICp/cFHy12+3JwjWtynhkmioOIZA/pLpCROo3XQ5bRKTFE+gZASEdpyx1laV1f7kpluxzgk1tRcKvGuRB5+D3x7I/CjmZ3HvO4E9f69/WpInmWStNc52qC8ThCskKtnAV4Vg7rLiXHciHbdk718UF73OobSgLYDA8Mjdaw3rDJpcJYqxiptohEpSPH3qCozeJXuKv3AEc3MVKct+4mdBAeUt06znEoNuIWMhPMOQl9ybai6V4na0hSMIW3lc+z+w8LWbMvSUHduLewB/ZNC2dx8UvzI1i/WukV5yIjrN++ECEfaf+OnUFW16mG+ekV/Z1Owge/gxYVMt+laopsWVghlrHKqJ+/mkp7lci8lGiCDsen3UtOVdyO2FE+j/SfCnBYNl40tbPzbyyahoZlD9Mk2+sFT3bSTtW8h5aT71TdT1WdLsX5Gp2TtV/jzBU0EzzGTNQ1SWRIcv+3l5yKZ47Loq26pOJ2fvAsW6icZrqMb4nHVT8VbPD29j+/CSRL6nXp0wnumd4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(46966006)(40470700004)(36840700001)(8676002)(70206006)(8936002)(70586007)(5660300002)(41300700001)(6916009)(44832011)(4326008)(316002)(54906003)(478600001)(6666004)(7696005)(36756003)(1076003)(16526019)(2616005)(186003)(336012)(26005)(426003)(83380400001)(47076005)(82740400003)(2906002)(40460700003)(82310400005)(356005)(40480700001)(81166007)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:15:47.9265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba0f068-d608-46a0-1246-08db0ea6bbc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
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
Cc: alexander.deucher@amd.com, Christian Koenig <christian.koenig@amid.com>,
 christian.koenig@amd.com, Arvind.Yadav@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

To differentiate it from the doorbell BAR.

V2: Added Christian's A-B

Acked-by: Christian Koenig <christian.koenig@amid.com>

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c     | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c     | 10 +++++-----
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f28a8c02f64..0b6a394e109b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -354,12 +354,12 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
 	size_t count = 0;
 	uint64_t last;
 
-	if (!adev->mman.aper_base_kaddr)
+	if (!adev->mman.vram_aper_base_kaddr)
 		return 0;
 
 	last = min(pos + size, adev->gmc.visible_vram_size);
 	if (last > pos) {
-		addr = adev->mman.aper_base_kaddr + pos;
+		addr = adev->mman.vram_aper_base_kaddr + pos;
 		count = last - pos;
 
 		if (write) {
@@ -3954,9 +3954,9 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
 
 	iounmap(adev->rmmio);
 	adev->rmmio = NULL;
-	if (adev->mman.aper_base_kaddr)
-		iounmap(adev->mman.aper_base_kaddr);
-	adev->mman.aper_base_kaddr = NULL;
+	if (adev->mman.vram_aper_base_kaddr)
+		iounmap(adev->mman.vram_aper_base_kaddr);
+	adev->mman.vram_aper_base_kaddr = NULL;
 
 	/* Memory manager related */
 	if (!adev->gmc.xgmi.connected_to_cpu) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 55e0284b2bdd..73b831b47892 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -578,9 +578,9 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
 		if ((mem->bus.offset + bus_size) > adev->gmc.visible_vram_size)
 			return -EINVAL;
 
-		if (adev->mman.aper_base_kaddr &&
+		if (adev->mman.vram_aper_base_kaddr &&
 		    mem->placement & TTM_PL_FLAG_CONTIGUOUS)
-			mem->bus.addr = (u8 *)adev->mman.aper_base_kaddr +
+			mem->bus.addr = (u8 *)adev->mman.vram_aper_base_kaddr +
 					mem->bus.offset;
 
 		mem->bus.offset += adev->gmc.aper_base;
@@ -1752,12 +1752,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 #ifdef CONFIG_64BIT
 #ifdef CONFIG_X86
 	if (adev->gmc.xgmi.connected_to_cpu)
-		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
+		adev->mman.vram_aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
 				adev->gmc.visible_vram_size);
 
 	else
 #endif
-		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
+		adev->mman.vram_aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
 				adev->gmc.visible_vram_size);
 #endif
 
@@ -1904,9 +1904,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 
-		if (adev->mman.aper_base_kaddr)
-			iounmap(adev->mman.aper_base_kaddr);
-		adev->mman.aper_base_kaddr = NULL;
+		if (adev->mman.vram_aper_base_kaddr)
+			iounmap(adev->mman.vram_aper_base_kaddr);
+		adev->mman.vram_aper_base_kaddr = NULL;
 
 		drm_dev_exit(idx);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e2cd5894afc9..929bc8abac28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -50,7 +50,7 @@ struct amdgpu_gtt_mgr {
 struct amdgpu_mman {
 	struct ttm_device		bdev;
 	bool				initialized;
-	void __iomem			*aper_base_kaddr;
+	void __iomem			*vram_aper_base_kaddr;
 
 	/* buffer handling */
 	const struct amdgpu_buffer_funcs	*buffer_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index bd3e3e23a939..f39d4f593a2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -611,10 +611,10 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		 */
 		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
 
-		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
-			DRM_ERROR("visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
+		if (adev->gmc.visible_vram_size < sz || !adev->mman.vram_aper_base_kaddr) {
+			DRM_ERROR("visible_vram_size %llx or vram_aper_base_kaddr %p is not initialized.\n",
 				  adev->gmc.visible_vram_size,
-				  adev->mman.aper_base_kaddr);
+				  adev->mman.vram_aper_base_kaddr);
 			return -EINVAL;
 		}
 
@@ -625,7 +625,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		}
 
 		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
+			memcpy_fromio(buf, adev->mman.vram_aper_base_kaddr, sz);
 			ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 			if (ret) {
 				DRM_ERROR("Send long training msg failed.\n");
@@ -634,7 +634,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 				return ret;
 			}
 
-			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
+			memcpy_toio(adev->mman.vram_aper_base_kaddr, buf, sz);
 			adev->hdp.funcs->flush_hdp(adev, NULL);
 			vfree(buf);
 			drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index e6a26a7e5e5e..9605c0971c11 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -510,10 +510,10 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 		 */
 		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
 
-		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
-			dev_err(adev->dev, "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
+		if (adev->gmc.visible_vram_size < sz || !adev->mman.vram_aper_base_kaddr) {
+			dev_err(adev->dev, "visible_vram_size %llx or vram_aper_base_kaddr %p is not initialized.\n",
 				  adev->gmc.visible_vram_size,
-				  adev->mman.aper_base_kaddr);
+				  adev->mman.vram_aper_base_kaddr);
 			return -EINVAL;
 		}
 
@@ -524,7 +524,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 		}
 
 		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
+			memcpy_fromio(buf, adev->mman.vram_aper_base_kaddr, sz);
 			ret = psp_v13_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
 			if (ret) {
 				DRM_ERROR("Send long training msg failed.\n");
@@ -533,7 +533,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
 				return ret;
 			}
 
-			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
+			memcpy_toio(adev->mman.vram_aper_base_kaddr, buf, sz);
 			adev->hdp.funcs->flush_hdp(adev, NULL);
 			vfree(buf);
 			drm_dev_exit(idx);
-- 
2.34.1

