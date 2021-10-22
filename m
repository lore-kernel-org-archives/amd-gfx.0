Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973A6C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8A161073
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D8A161073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C874889F47;
	Fri, 22 Oct 2021 09:32:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247EC89F47
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 09:32:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJEZlH3eF5LNL8ohgi20L5hXb+397w0ZbtZ1V+XVh0vJ5EAbJq3nnnP7dRt9VBoPWFQk3OFtU77Hjo9FZQ1ZmkNf/rxFLnS4lA1oOWrQ7Ut4JDTv89khYog5exoxWWsK+w/Hpug8tKmmmWbuWhUqbcLZuGfOnRJDca9zChYlUZyupKtsGCX3eA5HDwhLqqBZNRLAelfnCvtLZvlnCgyTASn7X53O9K3fbfdk7aJH3UpbVLRNQNJKi6WIcffuZ9CVrv6ecPV2ifUKljj3A1rPSiVUe49tf8xssaLEmkPWVSenT+qHHwoaGzFA3MbkwJ6xedN8Qc5pZtIbLwJctxgvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKPH9Rcwic6kLDBJjKeNU66NHX6YGQp4tQ7NjfW+fes=;
 b=ko1C+R8LzLv0ksCMbLz1GajYzH2ZNHqki2Q8y4751zxAVz0lBPndwNfY54KxX435qCtruKzGEvnJ2ZwkyGnl+uXd/l4k4Wy7/jXMCUMjCJ4RM775AN+7CgpikVywm6DAEx7Ni+QNN3+OTFtplYCi8nfmMkEM5jKGEP3YT59zAsI1qfbgfEZVLUF+FM0VS+2a4a1ot10R+wlTWLQNuewOIJwCzb1QPx1lXFpMFXdif+zmqXUC4PJzIggGb+DmXqngvCshTGsQOB8YQS8IOayen6IFY5JoXFh+lZjzKQ7VnJ8D/KRxjZvitIvBpMQNRM/t9wTa9+tQt+3NIIbXyVk51g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKPH9Rcwic6kLDBJjKeNU66NHX6YGQp4tQ7NjfW+fes=;
 b=ocsaQIcl+0AAYS9L8zF+PNTOAvsVUYATrS6cQqY9we1qFe6CDC+V6Uak1ugfU/RaPNG9hv88JpxPBs9W1LdQ0R0upCmQ6FfJItFwrYAPLg8QLKgnvDna4+TcjP33YOjcOVrU1/JqTLfUnAYqFMkNvFkGERmf8GXwmFKPceBK3hQ=
Received: from DS7PR06CA0049.namprd06.prod.outlook.com (2603:10b6:8:54::35) by
 MN2PR12MB4502.namprd12.prod.outlook.com (2603:10b6:208:263::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Fri, 22 Oct
 2021 09:32:44 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::4a) by DS7PR06CA0049.outlook.office365.com
 (2603:10b6:8:54::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Fri, 22 Oct 2021 09:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 09:32:43 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 04:32:42 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>,
 <lijo.lazar@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu: do not pass ttm_resource_manager to gtt_mgr
Date: Fri, 22 Oct 2021 11:32:29 +0200
Message-ID: <20211022093231.7787-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d2ae12e-4edc-4969-942e-08d9953ee686
X-MS-TrafficTypeDiagnostic: MN2PR12MB4502:
X-Microsoft-Antispam-PRVS: <MN2PR12MB45024A57EC1913E22E2E8B4E8B809@MN2PR12MB4502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRfAz+1lLzZZVDzUJHa9yK5kRkHDm//08l+ovcbbBPJWGfm+mXfC+W32TPk3grrakdqPrSqtnsH/jNN6U4eDsjuPFp1ZMmKAIMLJ0MwuRIR9dorjzWr9TKOQZuX99omffLonpVGR/4FPxeO8Ap1QPIlvsVMQWJBQuzH3PlxLypk3DOm74DCoHFvvkbwlOyAHzHY/zkF/e+AuMiuCF9EONEvIKvJz+ESUwK+rm0CBvNnEDB+U9wWLlEkHdp/mGWQlUZCQnIDN3jDsxAnXJ2zDF/W+BkfDGGVcJgurf7ALt2BCLk30WhJhky6Mo/Ns3UpjSkETUvxFZdrFGA1ZPN2DegD2y014bUFsd5lfjryioy73DTIyN/zRMpIKC+FbuDQQx7y2jFTD6rlAk5GpX3sUdUqys+cPFbNMgZMQYuKJ5bv5BQoKoEKKDRisfN4jfqcyGrQmp+xCahbD08WTZ33gQB+VqNUOJLISmGSqJn/sS7X0jM88eImZ1Z/RxzfbDruaM2AeUjjNUfOOrhPaLT4WKVTsfC4263EaIs/729pGck+YE2tmCnLvashGLDbVLajh7z6Ie//8TOxtIelJARt9rDlDiuQ2INEjNDtJfD1q5AkEGk2vde2WRTB0XUex/n/6fBYuqqd7AMyP/n41L65teXoeMIN6RRlxHuHwoj/G2NznSylg9kliG0Y1hTbdr0JmsQFAlK6joN303W//GRdoyBTDDFC1hkhV4AhfLjQ5ZFQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(47076005)(1076003)(83380400001)(70586007)(316002)(2906002)(8936002)(70206006)(4326008)(356005)(36860700001)(5660300002)(54906003)(2616005)(7696005)(44832011)(81166007)(16526019)(186003)(6666004)(36756003)(6916009)(26005)(426003)(336012)(82310400003)(8676002)(86362001)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 09:32:43.6736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2ae12e-4edc-4969-942e-08d9953ee686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4502
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

Do not allow exported amdgpu_gtt_mgr_*() to accept
any ttm_resource_manager pointer. Also there is no need
to force other module to call a ttm function just to
eventually call gtt_mgr functions.

v3: upcast mgr from ttm resopurce manager instead of
getting it from adev.
v2: pass adev's gtt_mgr instead of adev

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 23 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 ++--
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 41ce86244144..2b53d86aebac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4287,7 +4287,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,

 	amdgpu_virt_init_data_exchange(adev);
 	/* we need recover gart prior to run SMC/CP/SDMA resume */
-	amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
+	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);

 	r = amdgpu_device_fw_loading(adev);
 	if (r)
@@ -4604,7 +4604,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 					amdgpu_inc_vram_lost(tmp_adev);
 				}

-				r = amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, TTM_PL_TT));
+				r = amdgpu_gtt_mgr_recover(&tmp_adev->mman.gtt_mgr);
 				if (r)
 					goto out;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index c18f16b3be9c..62e14efa61fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -77,10 +77,8 @@ static ssize_t amdgpu_mem_info_gtt_used_show(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	struct ttm_resource_manager *man;

-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
-	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
+	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr));
 }

 static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
@@ -206,14 +204,15 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
 /**
  * amdgpu_gtt_mgr_usage - return usage of GTT domain
  *
- * @man: TTM memory type manager
+ * @mgr: amdgpu_gtt_mgr pointer
  *
  * Return how many bytes are used in the GTT domain
  */
-uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
+uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr)
 {
-	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
-	s64 result = man->size - atomic64_read(&mgr->available);
+	s64 result;
+
+	result = mgr->manager.size - atomic64_read(&mgr->available);

 	return (result > 0 ? result : 0) * PAGE_SIZE;
 }
@@ -221,16 +220,15 @@ uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
 /**
  * amdgpu_gtt_mgr_recover - re-init gart
  *
- * @man: TTM memory type manager
+ * @mgr: amdgpu_gtt_mgr pointer
  *
  * Re-init the gart for each known BO in the GTT.
  */
-int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
+int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
 {
-	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
-	struct amdgpu_device *adev;
 	struct amdgpu_gtt_node *node;
 	struct drm_mm_node *mm_node;
+	struct amdgpu_device *adev;
 	int r = 0;

 	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
@@ -260,6 +258,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,
 				 struct drm_printer *printer)
 {
 	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
+	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);

 	spin_lock(&mgr->lock);
 	drm_mm_print(&mgr->mm, printer);
@@ -267,7 +266,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,

 	drm_printf(printer, "man size:%llu pages, gtt available:%lld pages, usage:%lluMB\n",
 		   man->size, (u64)atomic64_read(&mgr->available),
-		   amdgpu_gtt_mgr_usage(man) >> 20);
+		   amdgpu_gtt_mgr_usage(mgr) >> 20);
 }

 static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d2955ea4a62b..603ce32db5c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		ui64 = amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_GTT_USAGE:
-		ui64 = amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
+		ui64 = amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_GDS_CONFIG: {
 		struct drm_amdgpu_info_gds gds_info;
@@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
 			atomic64_read(&adev->gart_pin_size);
 		mem.gtt.heap_usage =
-			amdgpu_gtt_mgr_usage(gtt_man);
+			amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
 		mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;

 		return copy_to_user(out, &mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 91a087f9dc7c..af1c4e414979 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);

 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
-uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
-int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
+uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_gtt_mgr *mgr);
+int amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);

 uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);

--
2.32.0

