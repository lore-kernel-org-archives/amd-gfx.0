Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7BEC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 10:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE13061248
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 10:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE13061248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C4D76F3D5;
	Thu,  7 Oct 2021 10:00:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3678D6F3D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 10:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hft7qJmkqWIppw7TifhioLm66STbV/aOtB3BCH/0AIeg86PRUJzuSmeQFXaPxd23/aM6V9AK03eYBrx6b1ch0YZHTWihtb7ZQaMmNEerIf/mycLkOk1EB2/sSWgZiTKYtohqJf3lO87YBqysV2xfh6lafj3P6S0aduxyiCB00WpOMsXthSmqkcBvzrKwBg4yMUKwgSKDit6WIE5910+gvC35XdHQmbCzcbiS1hxpVj1F3jkbJzJ3yCtN5cTMUkQCy/Y7qUepKavjUpTsAjiKR0UCbXe3XvOtKf9D6DXaLVRxn2NfWY7A7Hoim42SpMH71S361JYFLqko7kGsS2iEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNJ+hdZ0DSEz3DWTtJY5SPhKIF8ahidGZaM/ypeIyX0=;
 b=lu4EqP5c2LJaeaTxgNQhTyarFNnpY/mYDcXYz8LWdRJP13bvZU6lqq34xnpFT27ZF3M57J0M9/ikT7MA8aVwJn+64OD/YqmkMIiGlIEvaJiNaORGHJchlOqR3zOlOWgpJ6Hc5rY5lYqQcM+UW6HafUXYgr5xfeXOtb6KscXpClhtTSnJYgl10tOXd+SW7W0/gQ4shr8Gd3MLCuaznBx0DbuuIMX+LS/6C1WOrv1M0v96UAk+UYvd5uS5jw7waeFqF3g4NC5qUDJZcpICjqD07mOqil7ZdGXdcfoOJPw60TUJJHDt6goPFPRzCVg+E6QiTDfwdyJrA3v5EjJKdQuyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNJ+hdZ0DSEz3DWTtJY5SPhKIF8ahidGZaM/ypeIyX0=;
 b=UiTI2wFQPOYEkanWgq32fyj497im3da17n0DVI+hwq2XEA8XmT8E8YTsv//nsb15Vkj3jbRfmbp5XN+xRaMbMQq0L9o3Lq6iCpz76SHJCNDgWYGJ6TAAak/w6IqMDPBghDKNkOaPDdXSyNBQ/0S1SPt5TVVEfI1hTO9YiUu5iP4=
Received: from MW4PR03CA0070.namprd03.prod.outlook.com (2603:10b6:303:b6::15)
 by DM5PR12MB1785.namprd12.prod.outlook.com (2603:10b6:3:10a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 10:00:46 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::17) by MW4PR03CA0070.outlook.office365.com
 (2603:10b6:303:b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Thu, 7 Oct 2021 10:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 10:00:45 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 7 Oct 2021
 05:00:43 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: unify BO evicting method in amdgpu_ttm
Date: Thu, 7 Oct 2021 12:00:32 +0200
Message-ID: <20211007100032.8140-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 353a7843-7d09-4d96-8b7e-08d9897954f1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1785:
X-Microsoft-Antispam-PRVS: <DM5PR12MB178559724A899EB15D4FA6008BB19@DM5PR12MB1785.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK8HCRvvvaVLAVJFI69asQiOnR1HpTTbKErbtoYcOgyshryKMSBX6m70yWKq47Tu60/X0SN85Bk4NKCVRLBviQwNyv5a6HcYh91rtrjA0OZEKEtQWTgsRI1ObnL2+Auz8GH3NbtVbOvsy9i0FqC5JCWQr9+JK1mcoQYLWOo/a2r2pU0cM80jixrlfBCMRu1DgnK1jThKdqsZB01Fuxl4e7sC0/4z/iyX6kfec6RvKzycAN6Ckt745XZCkn9IVFJxjFihUR5h56E2ETpPxrD0+DsbEMnP2ooRF+p4axbmBe0RgMpJYJTLpoPgna398pOhFXW5HYnl7hmVu/1ed2MIFNt1uFw2eWnxtG8PoBmAzqhacnhZ+3R9FdJl0QCbF5KxvixwJsOsK9rXC7fcnvWNAnAtUx0JpPjXeTh4q5Q/xGzqYpBN86K0f3D9jS6mKSXNAroDS6v96a0YC2ZcdBf0oe9i69ptnAyOJA5MOKvcD3O++/6uCn2L/HtwFOHWgissSgfSibrjpToChvDi/GPl2K2I9IZFLqW9+ioQflbWu2BsaInjAJGe18b4Bh5SFyyLg4T3NMHXfiQDzCLpYgeSz2oE9jD6IuMN91wZ2MjDerg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(4326008)(8676002)(81166007)(6666004)(70586007)(26005)(36860700001)(336012)(70206006)(186003)(8936002)(86362001)(426003)(16526019)(44832011)(47076005)(2906002)(1076003)(6916009)(2616005)(7696005)(508600001)(82310400003)(54906003)(316002)(83380400001)(5660300002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 10:00:45.6863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353a7843-7d09-4d96-8b7e-08d9897954f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1785
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unify BO evicting functionality for possible memory
types in amdgpu_ttm.c.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  8 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 30 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 23 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 30 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
 6 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 5497e2d31d1a..164d6a9e9fbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1328,7 +1328,7 @@ static int amdgpu_debugfs_evict_vram(void *data, u64 *val)
 		return r;
 	}
 
-	*val = amdgpu_bo_evict_vram(adev);
+	*val = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
@@ -1341,17 +1341,15 @@ static int amdgpu_debugfs_evict_gtt(void *data, u64 *val)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
 	struct drm_device *dev = adev_to_drm(adev);
-	struct ttm_resource_manager *man;
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0) {
-		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
 	}
 
-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
-	*val = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
+	*val = amdgpu_ttm_evict_resources(adev, TTM_PL_TT);
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 57638fe9cfc2..032deca4cea2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3880,6 +3880,25 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 
 }
 
+/**
+ * amdgpu_device_evict_resources - evict device resources
+ * @adev: amdgpu device object
+ *
+ * Evicts all ttm device resources(vram BOs, gart table) from the lru list
+ * of the vram memory type. Mainly used for evicting device resources
+ * at suspend time.
+ *
+ */
+void amdgpu_device_evict_resources(struct amdgpu_device *adev)
+{
+	/* No need to evict vram on APUs for suspend to ram */
+	if (adev->in_s3 && (adev->flags & AMD_IS_APU))
+		return;
+
+	if (amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM))
+		DRM_WARN("evicting device resources failed\n");
+
+}
 
 /*
  * Suspend & resume.
@@ -3920,17 +3939,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (!adev->in_s0ix)
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
 
-	/* evict vram memory */
-	amdgpu_bo_evict_vram(adev);
+	/* First evict vram memory */
+	amdgpu_device_evict_resources(adev);
 
 	amdgpu_fence_driver_hw_fini(adev);
 
 	amdgpu_device_ip_suspend_phase2(adev);
-	/* evict remaining vram memory
-	 * This second call to evict vram is to evict the gart page table
-	 * using the CPU.
+	/* This second call to evict device resources is to evict
+	 * the gart page table using the CPU.
 	 */
-	amdgpu_bo_evict_vram(adev);
+	amdgpu_device_evict_resources(adev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4ec904f36ceb..073ba2af0b9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1004,29 +1004,6 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
 	}
 }
 
-/**
- * amdgpu_bo_evict_vram - evict VRAM buffers
- * @adev: amdgpu device object
- *
- * Evicts all VRAM buffers on the lru list of the memory type.
- * Mainly used for evicting vram at suspend time.
- *
- * Returns:
- * 0 for success or a negative error code on failure.
- */
-int amdgpu_bo_evict_vram(struct amdgpu_device *adev)
-{
-	struct ttm_resource_manager *man;
-
-	if (adev->in_s3 && (adev->flags & AMD_IS_APU)) {
-		/* No need to evict vram on APUs for suspend to ram */
-		return 0;
-	}
-
-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
-}
-
 static const char *amdgpu_vram_names[] = {
 	"UNKNOWN",
 	"GDDR1",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 8ff61bad4138..d787e0e89e0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -305,7 +305,6 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain);
 int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 			     u64 min_offset, u64 max_offset);
 void amdgpu_bo_unpin(struct amdgpu_bo *bo);
-int amdgpu_bo_evict_vram(struct amdgpu_device *adev);
 int amdgpu_bo_init(struct amdgpu_device *adev);
 void amdgpu_bo_fini(struct amdgpu_device *adev);
 int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e2896ac2c9ce..bd5dda8066fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2034,6 +2034,36 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 	return r;
 }
 
+/**
+ * amdgpu_ttm_evict_resources - evict memory buffers
+ * @adev: amdgpu device object
+ * @mem_type: evicted BO's memory type
+ *
+ * Evicts all @mem_type buffers on the lru list of the memory type.
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
+{
+	struct ttm_resource_manager *man;
+
+	switch (mem_type) {
+	case TTM_PL_VRAM:
+	case TTM_PL_TT:
+	case AMDGPU_PL_GWS:
+	case AMDGPU_PL_GDS:
+	case AMDGPU_PL_OA:
+		man = ttm_manager_type(&adev->mman.bdev, mem_type);
+		break;
+	default:
+		DRM_ERROR("Trying to evict invalid memory type\n");
+		return -EINVAL;
+	}
+
+	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 static int amdgpu_mm_vram_table_show(struct seq_file *m, void *unused)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e69f3e8e06e5..ba5c864b8de1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -190,6 +190,7 @@ bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm);
 uint64_t amdgpu_ttm_tt_pde_flags(struct ttm_tt *ttm, struct ttm_resource *mem);
 uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
 				 struct ttm_resource *mem);
+int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type);
 
 void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
 
-- 
2.32.0

