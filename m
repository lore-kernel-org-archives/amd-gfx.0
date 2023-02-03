Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9F2C636D6
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BBDB10E89A;
	Fri,  3 Feb 2023 19:09:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D32E10E89C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsL5HFOXsyCDucyUty+4lzomy8HAaeGp++6kdAHGRUSKS7ET3mdg9A/+H74+VjW6UQlWuPD2pLZZ42CLOJLE6KJYEDCVRU4zlJKAXzL+SJzCjNax+JQQIEQtjmIrS1wP1Dd4rgUP2xELTt3iB22oArv0iIL+H51791prruSgs4hyPwPuqdxvAj1G6fckgcfzZcGFwrumRwsmh2HsshIwPHnpl583VOOFFB8H+JF/5OPt6r3FqnYyDvSWObbtFPvQDw9Admu0YwMD+WGhJOFMOi2mYw2+f6U+b7+taGpjtQUhkTFmqynn2RY4mBOUTicJ/7ClEvXEpp0WNHR062R7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRwMdMMM9AWo0ZLa0HnHZSNV0xBkIu0L+WY3E9Nrlrw=;
 b=eXmlC++WzhF6u0RsYqVmFgyKJXJXWZsTLHsgZHEhCjJvVM3qQ7yc8u3ME144Au0YHLmjPfXdk3Ptz5uAHnkBUAufBV2YhTIio0CWBFChC9QhnmtD01+5Q4AdxXr3ixGZWg0nD1EDgiqGwxXo7NqFyRd7MdAJyFh5jhv1sZL3GgtEux8gl7XsuuLH3hU95uoBkx6dPWA6nJSbAXj6xNnTsV/fFKaDTPi55OV2F2BUXwjzlTDd83EC74lwLk3wSkUut7UyjaCS4/l/LrUaD/W7XK46abPABi3jo1waWKljRKDr1vmJI/0i+pe3lGiWqX5ohVNm9uLZ/nLXTk1DKBQ24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRwMdMMM9AWo0ZLa0HnHZSNV0xBkIu0L+WY3E9Nrlrw=;
 b=xI/xF2OSBTloZsO1bWFRsenReXyqJm3gV7VDCEEQHLyPUBiIQSEmhegXGn4qxMTt8AjdN2S8K/lcxSETcGWQmoi+kLOc5bQjhgntRzmmW/Lo17C/s7ptuu8V9mq/hItHOo1Mt6B0Qm65g0QDI4WJWXWzGvjHHR77XgmJ45RDJDU=
Received: from DM6PR12CA0008.namprd12.prod.outlook.com (2603:10b6:5:1c0::21)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 19:09:19 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::32) by DM6PR12CA0008.outlook.office365.com
 (2603:10b6:5:1c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:18 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:16 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/13] drm/amdgpu: replace aper_base_kaddr with
 vram_aper_base_kaddr
Date: Fri, 3 Feb 2023 20:08:21 +0100
Message-ID: <20230203190836.1987-5-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf04ef0-e391-4775-4f70-08db061a2620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5eFjcMDOYhuvJfApGzB+eHWoX1vXkWtk3Cn5CE1HsczjMXlbEUC7zmbwMdmOCef8T8S4MpivkYnNNsZislym8kiQNA+JWQ8wdNKTyeCqaGDubYQNhTp8IPUooDZ4x4Md9hAMAI+1pTzCuYxkbCCNlXvf6f4R6UqrW+yIlHglqaFDO09NfohnkNpiVljpl4rYTWNostwqliVybKBAnhwCVBJeXJ5Jp4P+jwFyXV6Fmn/D97LQvx4RRpxlW/dRGsJ5ABcE4Xk8SRrcA1WCQ87LSBXKzF3MLlwDTyETzI9a8cjsconyH6bV9BHh208fXTKEDakuvqzvPPxqQfwRluPxE3EmIhROiMj3FMWwKfX2A/x3Oag0mryYCMuzASdFT2cWYVNIT6OsWztIFCZ5qEONuFaN+VcNaS29k9JvuTpa4ePSwua1SiYT6HABdeYHckxCVGe6/QpP6erlQN97FZ3spjuXo16w1nA833us+SnvPyDmDTq/dyozZvcVJW3ULBsAI5uzaxJqwGg4XptU1RIG0mwHY4vwmWSyUWXcCvuEMCDGJ3DrIGeBwm4Fr1utZyxg9tPNhKWIzq1Q1kvdqVAMUvQAfc1Fh5NQ9K+7glqI4zjRt5iIspmzRr7kiqlTVE56FednTEiM0vRBMOnDVGTSDvt+HrQ9no+9+vNhtRhnmeA3kCDAB435/y4ZAdRucBPYn6LkoBzgBd9xN7s9A7NvhZUS4SddXZedtyN17k/y9o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(40470700004)(36840700001)(46966006)(356005)(81166007)(40480700001)(336012)(47076005)(2616005)(426003)(83380400001)(82740400003)(40460700003)(36860700001)(8676002)(70586007)(6916009)(70206006)(44832011)(8936002)(41300700001)(86362001)(5660300002)(2906002)(4326008)(7696005)(478600001)(26005)(54906003)(6666004)(82310400005)(316002)(186003)(1076003)(36756003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:18.0531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf04ef0-e391-4775-4f70-08db061a2620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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

To differentiate it from the doorbell BAR.

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
index 668826653591..196ba62ef721 100644
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
index 1061447befc6..020ebba5a51a 100644
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

