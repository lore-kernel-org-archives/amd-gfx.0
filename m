Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69987C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B014010E89C;
	Fri,  3 Feb 2023 19:09:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150A510E89A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S22yA6Yvs3IwLCzacjEj3dnEux0XI0o2vi60tdIYLAXkrk+g4rkp1LLHEJUNEc1oAqsDjzG9HS9uXRBEyIAeQlRQQENIUDjzWq5aP3HRZpGWY4wuGlaW+yyMcMV+Go4opFqnFcCduBBYe9jixeA4OtdE6KgZftymUWxrHqRT4wzwVDaI749gvRUuE49dDkEAa9lhwgv+u+av9PrihDda+OIt8ABgBXjqOBluKNWKB+INcEWpA/BDZl0LH+h2mklQAp2MROCnznW6KHLgfB5z4Iq8kYy/mEc9USAKudxEnW3NLyYo17icqi3YyY3u9yUEw/B3yy3UHbjFigmXfAmWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=944AnlcZ/kn5wFm8aQZHhkOuqC+I3ajDWAhgrriO5bM=;
 b=bTy/KOj3Bd/dhiw3TbJj4KaBhLdIGOLeK2wu56+a480g35qO6Vd+bHcDiSJWXvjUxcEmseMHChUovHjXspR3ZURQm4TYGyDS8+TlrUFLhRLkNdjznOOrhSrk5/xhu3tf35DmDoUza/6MULD4RNpWe4L5KS4s+RDuS+e6DJCoBUWvdc0bAhjmAKbruk+4m20IEPYfwPFeVkf+UygoWHnh7HGo2KylFOkuohiGJqgBoKn8iVGWp80V7vH6W+Ucxzlb+Nqcx5n4+STZqhft7fwk3hFM6BQTpiS6jnTw1JnSMQB6zSfDLseHc6cqzTRInvKTMasPpFcaXTAZqVSF1tZasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=944AnlcZ/kn5wFm8aQZHhkOuqC+I3ajDWAhgrriO5bM=;
 b=mVKVooJB08feZ6pjQBOqFhR86OZOVa2WHUuJ7cV9cNLfw4ofHqcxOgXg11DrMhLXTCnera8tbhgW8wVgIn3g0niVnk2twHEq8WfvAb18F2QsGqW7ZkdC+g9U8HXwdMDIRer8sQmmiQJhtb9VV25tzRtKfTrgHh6F1P5s0LSr1Jo=
Received: from DM6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:5:80::28) by
 PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 19:09:20 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::94) by DM6PR08CA0015.outlook.office365.com
 (2603:10b6:5:80::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:20 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:17 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amdgpu: add doorbell support to amdgpu_bar_mgr
Date: Fri, 3 Feb 2023 20:08:22 +0100
Message-ID: <20230203190836.1987-6-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f12a25-48bf-4f1b-e789-08db061a2770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0lHShDWwXGj5bZ1VyLNhCsljv74855d83B/4XX0uqiQOtMNxzCc+8kXs7n2zi72eVLiNNtGbVz3OhKVH9q0Tax4ZzAT/RlUca3KOPWvvt7Y78+pa+J8MlXAnWEDv4iMjSP0wNiB40WiIHaEiNnZqxYsTcn4SVp7ZHeojp3jO/vUMjBBWn4eKOkmABdlLnNnkmbWpx7zhaek7RkKxdIfhDvhuwUEYq5WdcfxNWgja0i85kAmT1Q+tZieRP765t9kUqBHuOM++65Xb+oesTyWSiybt/hOcimAYGCrE9MpmCy8b/dU/FuK6lr8NPH5DLbSxzRx1FqffY3duTcqFEawFsjEKupQ6Z8tC0tMhGtncIkWOHba4XoFFUjAJIAcoU39BhGiJ3kZafY2JopFsCKyz+lQJgZmdNGsj4CU2iNOLEHWSIAUwcf+QdKl9cjwnzhRBOCg6bpHTOU7XhKZ35vS8inK5omAK5C0xskSMLnZyzrrpj1RsKy6nV/Ndrsjrq0KOsGBCTDf5X+9/NlqcJvOSOTykKg/PZo48SJw8ofeVZPKT1C+3tDEAq8NM4/jDQXe0DHWw5ZaCaNgCDgqSHihx+5bI8wV8lQVxgPIs5s1C4LGVoBqUP6qIoMKCILzMaFGOy3s5QL9bCKr4o4V9W5PPvi6HsSg70FkRbFXphXgvnU+BwS+5Etqqnl7eY2HaLePjDRar+ufZX6z9nCTsc5PujyI4pII75XErFe7ZHwroa0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(83380400001)(7696005)(40460700003)(36756003)(356005)(186003)(40480700001)(86362001)(82740400003)(81166007)(36860700001)(26005)(16526019)(336012)(2616005)(47076005)(41300700001)(426003)(478600001)(1076003)(54906003)(316002)(6666004)(8936002)(44832011)(70206006)(6916009)(4326008)(70586007)(8676002)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:20.2590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f12a25-48bf-4f1b-e789-08db061a2770
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537
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

Adjust the code to handle doorbell BARs as well as VRAM.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c | 101 ++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.h |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |   2 +
 3 files changed, 85 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
index 30d68e3a2469..0e0f212bd71c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.c
@@ -47,7 +47,10 @@ to_bar_mgr(struct ttm_resource_manager *man)
 static inline struct amdgpu_device *
 to_amdgpu_device(struct amdgpu_bar_mgr *mgr)
 {
-	return container_of(mgr, struct amdgpu_device, mman.vram_mgr);
+	if (mgr->domain == TTM_PL_VRAM)
+		return container_of(mgr, struct amdgpu_device, mman.vram_mgr);
+	else
+		return container_of(mgr, struct amdgpu_device, mman.doorbell_mgr);
 }
 
 static inline struct drm_buddy_block *
@@ -100,7 +103,7 @@ static ssize_t amdgpu_mem_info_vram_total_show(struct device *dev,
  * DOC: mem_info_vis_vram_total
  *
  * The amdgpu driver provides a sysfs API for reporting current total
- * visible BAR available on the device
+ * visible VRAM available on the device
  * The file mem_info_vis_vram_total is used for this and returns the total
  * amount of visible VRAM in bytes
  */
@@ -192,16 +195,56 @@ static ssize_t amdgpu_mem_info_vram_vendor(struct device *dev,
 	}
 }
 
+/**
+ * DOC: mem_info_doorbell_total
+ *
+ * The amdgpu driver provides a sysfs API for reporting current total DOORBELL
+ * available on the device
+ * The file mem_info_vram_total is used for this and returns the total
+ * amount of DOORBELL in bytes
+ */
+static ssize_t amdgpu_mem_info_doorbell_total_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%llu\n", adev->doorbell.size);
+}
+
+/**
+ * DOC: mem_info_doorbell_used
+ *
+ * The amdgpu driver provides a sysfs API for reporting current total DOORBELL
+ * available on the device
+ * The file mem_info_vram_used is used for this and returns the total
+ * amount of currently used DOORBELL in bytes
+ */
+static ssize_t amdgpu_mem_info_doorbell_used_show(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct ttm_resource_manager *man = &adev->mman.doorbell_mgr.manager;
+
+	return sysfs_emit(buf, "%llu\n", ttm_resource_manager_usage(man));
+}
+
 static DEVICE_ATTR(mem_info_vram_total, S_IRUGO,
 		   amdgpu_mem_info_vram_total_show, NULL);
 static DEVICE_ATTR(mem_info_vis_vram_total, S_IRUGO,
-		   amdgpu_mem_info_vis_vram_total_show,NULL);
+		   amdgpu_mem_info_vis_vram_total_show, NULL);
 static DEVICE_ATTR(mem_info_vram_used, S_IRUGO,
 		   amdgpu_mem_info_vram_used_show, NULL);
 static DEVICE_ATTR(mem_info_vis_vram_used, S_IRUGO,
 		   amdgpu_mem_info_vis_vram_used_show, NULL);
 static DEVICE_ATTR(mem_info_vram_vendor, S_IRUGO,
 		   amdgpu_mem_info_vram_vendor, NULL);
+static DEVICE_ATTR(mem_info_doorbell_total, S_IRUGO,
+		   amdgpu_mem_info_doorbell_total_show, NULL);
+static DEVICE_ATTR(mem_info_doorbell_used, S_IRUGO,
+		   amdgpu_mem_info_doorbell_used_show, NULL);
 
 static struct attribute *amdgpu_bar_mgr_attributes[] = {
 	&dev_attr_mem_info_vram_total.attr,
@@ -209,6 +252,8 @@ static struct attribute *amdgpu_bar_mgr_attributes[] = {
 	&dev_attr_mem_info_vram_used.attr,
 	&dev_attr_mem_info_vis_vram_used.attr,
 	&dev_attr_mem_info_vram_vendor.attr,
+	&dev_attr_mem_info_doorbell_total.attr,
+	&dev_attr_mem_info_doorbell_used.attr,
 	NULL
 };
 
@@ -265,7 +310,7 @@ u64 amdgpu_bar_mgr_bo_visible_size(struct amdgpu_bo *bo)
 	return usage;
 }
 
-/* Commit the reservation of VRAM pages */
+/* Commit the reservation of BAR pages */
 static void amdgpu_bar_mgr_do_reserve(struct ttm_resource_manager *man)
 {
 	struct amdgpu_bar_mgr *mgr = to_bar_mgr(man);
@@ -288,8 +333,10 @@ static void amdgpu_bar_mgr_do_reserve(struct ttm_resource_manager *man)
 		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
 			rsv->start, rsv->size);
 
-		vis_usage = amdgpu_bar_mgr_vis_size(adev, block);
-		atomic64_add(vis_usage, &mgr->vis_usage);
+		if (mgr->domain == TTM_PL_VRAM) {
+			vis_usage = amdgpu_bar_mgr_vis_size(adev, block);
+			atomic64_add(vis_usage, &mgr->vis_usage);
+		}
 		spin_lock(&man->bdev->lru_lock);
 		man->usage += rsv->size;
 		spin_unlock(&man->bdev->lru_lock);
@@ -539,7 +586,8 @@ static int amdgpu_bar_mgr_new(struct ttm_resource_manager *man,
 			start = 0;
 		vres->base.start = max(vres->base.start, start);
 
-		vis_usage += amdgpu_bar_mgr_vis_size(adev, block);
+		if (mgr->domain == TTM_PL_VRAM)
+			vis_usage += amdgpu_bar_mgr_vis_size(adev, block);
 	}
 
 	if (amdgpu_is_bar_mgr_blocks_contiguous(&vres->blocks))
@@ -550,7 +598,8 @@ static int amdgpu_bar_mgr_new(struct ttm_resource_manager *man,
 	else
 		vres->base.bus.caching = ttm_write_combined;
 
-	atomic64_add(vis_usage, &mgr->vis_usage);
+	if (mgr->domain == TTM_PL_VRAM)
+		atomic64_add(vis_usage, &mgr->vis_usage);
 	*res = &vres->base;
 	return 0;
 
@@ -583,15 +632,18 @@ static void amdgpu_bar_mgr_del(struct ttm_resource_manager *man,
 	uint64_t vis_usage = 0;
 
 	mutex_lock(&mgr->lock);
-	list_for_each_entry(block, &vres->blocks, link)
-		vis_usage += amdgpu_bar_mgr_vis_size(adev, block);
+	if (mgr->domain == TTM_PL_VRAM) {
+		list_for_each_entry(block, &vres->blocks, link)
+			vis_usage += amdgpu_bar_mgr_vis_size(adev, block);
+	}
 
 	amdgpu_bar_mgr_do_reserve(man);
 
 	drm_buddy_free_list(mm, &vres->blocks);
 	mutex_unlock(&mgr->lock);
 
-	atomic64_sub(vis_usage, &mgr->vis_usage);
+	if (mgr->domain == TTM_PL_VRAM)
+		atomic64_sub(vis_usage, &mgr->vis_usage);
 
 	ttm_resource_fini(man, res);
 	kfree(vres);
@@ -801,8 +853,9 @@ static void amdgpu_bar_mgr_debug(struct ttm_resource_manager *man,
 	struct drm_buddy *mm = &mgr->mm;
 	struct drm_buddy_block *block;
 
-	drm_printf(printer, "  vis usage:%llu\n",
-		   amdgpu_bar_mgr_vis_usage(mgr));
+	if (mgr->domain == TTM_PL_VRAM)
+		drm_printf(printer, "  vis usage:%llu\n",
+			   amdgpu_bar_mgr_vis_usage(mgr));
 
 	mutex_lock(&mgr->lock);
 	drm_printf(printer, "default_page_size: %lluKiB\n",
@@ -837,15 +890,22 @@ int amdgpu_bar_mgr_init(struct amdgpu_device *adev, u32 domain)
 	struct amdgpu_bar_mgr *mgr;
 	struct ttm_resource_manager *man;
 	int err;
+	u64 size;
 
-	if (domain != TTM_PL_VRAM)
+	if (domain == TTM_PL_VRAM) {
+		mgr = &adev->mman.vram_mgr;
+		size = adev->gmc.real_vram_size;
+	} else if (domain == AMDGPU_PL_DOORBELL) {
+		mgr = &adev->mman.doorbell_mgr;
+		size = adev->doorbell.size;
+	} else {
 		return -EINVAL;
+	}
 
-	mgr = &adev->mman.vram_mgr;
+	mgr->domain = domain;
 	man = &mgr->manager;
 
-	ttm_resource_manager_init(man, &adev->mman.bdev,
-				  adev->gmc.real_vram_size);
+	ttm_resource_manager_init(man, &adev->mman.bdev, size);
 
 	man->func = &amdgpu_bar_mgr_func;
 
@@ -879,10 +939,13 @@ void amdgpu_bar_mgr_fini(struct amdgpu_device *adev, u32 domain)
 	int ret;
 	struct amdgpu_bar_reservation *rsv, *temp;
 
-	if (domain != TTM_PL_VRAM)
+	if (domain == TTM_PL_VRAM)
+		mgr = &adev->mman.vram_mgr;
+	else if (domain == AMDGPU_PL_DOORBELL)
+		mgr = &adev->mman.doorbell_mgr;
+	else
 		return;
 
-	mgr = &adev->mman.vram_mgr;
 	man = &mgr->manager;
 
 	ttm_resource_manager_set_used(man, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.h
index 241faba5ae55..f989a6b918d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bar_mgr.h
@@ -35,6 +35,7 @@ struct amdgpu_bar_mgr {
 	struct list_head reserved_pages;
 	atomic64_t vis_usage;
 	u64 default_page_size;
+	u32 domain;
 };
 
 struct amdgpu_bar_mgr_resource {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 020ebba5a51a..ea53aae3ee0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -33,6 +33,7 @@
 #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
 #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
+#define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
@@ -64,6 +65,7 @@ struct amdgpu_mman {
 	struct amdgpu_bar_mgr vram_mgr;
 	struct amdgpu_gtt_mgr gtt_mgr;
 	struct ttm_resource_manager preempt_mgr;
+	struct amdgpu_bar_mgr doorbell_mgr;
 
 	uint64_t		stolen_vga_size;
 	struct amdgpu_bo	*stolen_vga_memory;
-- 
2.34.1

