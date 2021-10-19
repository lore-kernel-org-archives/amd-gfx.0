Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C24C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05F960ED3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D05F960ED3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9ABD6E593;
	Tue, 19 Oct 2021 18:15:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C366E2C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 18:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw31YCXubGpgIdjThWcg5i98LfO9v3E3xGeC5Q1gFBiqEPf4fneyhc/aztR/qgHyeyQkIkxnVEVOQuFfAYEmRLVnYWPPOcFt/kg+q82CsFj+VIhOascaO65jLew27KAk3R4HXQjbfrrAx7dp4B0PuPnzl4rrUutEyr9LSk5HkaYRnTnARlODJxpfnX7PK8ybpJUNSYmDYox2KBPq7jfoc4r15cu7eNoqtNZZGEw35rqKi7hIreaLkNrzn1BI24Zq+tlVL56vJVmkD9YJS4GFRaGINuWswOf1e6deIC0czU1Dc/N/fwEYnBdWMvwqLRpjMFMmdEhHv5EojrBSIQhXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4aAv/gtfiVHpU9alFU9S5XX4kOxAm6XNIOTNl0OQrs=;
 b=UjSzdCbwStVUnlA5rL2QMlOBQR6EmnToxsi5BXGfk/F3YVPVnAekvtUwe4yBRPt9BGMVrsaxOyQU1p+5Ruibi10dyauOs8lQxSSsN2wZD9i5lo8MdOPooiAu+nRIPAlVD7KWjs6W1Few46X+CqESabYQSooQbABCk4MJLErBnbCkJRiBQa5DWOeYA9TWee6RjylAgeXuWz4Qsf8v7h1o2PyDD0KZRBE72xz8uZl0b3YleYtp+Kq4FzE9zKL1MlbUitap7tcw1aNo8a2tkj8MYKxSLLclSCjlL/ZY9s9v4n8SUoIMJ+WJ7UixyDRYPqKPf67coDtyzK8CohF3F1FHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4aAv/gtfiVHpU9alFU9S5XX4kOxAm6XNIOTNl0OQrs=;
 b=zkxhE+WDfG0SA7viEOanZzwB8uP6Yos9Zp0bW5osABvCukJ0S/g9vtGIG0jhnxiPXHsjGRgUdR8ErUIhrVKCLJ9Iq137o8XQr92n23tiDuDJZkj526wlMF8A9wdeFiHEX0VzodKZNQpkccBI29S7c/FRSmxvScPsYNgf5X1bPr4=
Received: from BN9PR03CA0916.namprd03.prod.outlook.com (2603:10b6:408:107::21)
 by MN2PR12MB3054.namprd12.prod.outlook.com (2603:10b6:208:d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 18:15:10 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::4) by BN9PR03CA0916.outlook.office365.com
 (2603:10b6:408:107::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 18:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=temperror
 action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 18:15:08 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 13:15:04 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>, Nirmoy Das
 <nirmoy.das@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: do not pass ttm_resource_manager to gtt_mgr
Date: Tue, 19 Oct 2021 20:14:47 +0200
Message-ID: <20211019181449.12356-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52a31690-59bf-43af-95bf-08d9932c624c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3054:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3054C865BEF7C4FBAB691EE48BBD9@MN2PR12MB3054.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRWREAdIvUUzJ1TnQfGxHKJEN6oGoFh2jXgnStKGRYYy5ZWUGIJvxHfr8pypqU76bhtx+XJpHULkMSuB1rrWZ3QAj6je78Tyen45zSv699/UEAkgY996RAt1umuWkaHhLnl9OYwI1WtOtfC1w02x7vZ4o9rrcvkgXsJ5qF2D1LQCaZHoUDurdG4ZVZBkUlDJfPhULTTrL9Or8XexO9MTGHzfP3EdvrPSCyjXOnPX39lJ33k9p3TDyLqGopr+erXLs3naSV0Awe4uFzN/Q8aiRA20FPngx1DNBMl/wSfcDU4GxZVPZoayZhGjMDHdnWwy0ixIpuHKSHgUZxj5PD4w/BicJ6fexJSzq9yXPoP/pCKkADdB3nDLDmDkt6GF9TiiKdAPrqhZRMXl0kh2KizVJpP0Rnmam2O5QcSHritL25DiLE5ym8yMStRl3JF1owtMgSwpwgthE+S3VtsTgg/V7E5OdyphxJxyeVq5li7PdnIkrlGLQXJXD1a7Jqru3UBisL5lgVrGdoetbIq5fPfNg83s3EOXgqmExvjJ4GAvjlz1d7ithMxdFZbYLxHsNAedtNdsjKT98z+iPz6Ap6FmPPymimvNar8yBeiYO8v5dKi8xXxEXBQ5zpjBHji5bmJ2KQJv+onm19H8a8z7zYGGQxxb03T6MeK6LYarSfVoYFGK04kp+fvqqQY6JHUUZT8MBimQ2dXugsDGwgOfKb0VgXf83Avmm7R8NjJLw00V7Rg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(63370400001)(7696005)(2616005)(508600001)(426003)(6666004)(63350400001)(5660300002)(8936002)(1076003)(70206006)(81166007)(83380400001)(316002)(36756003)(356005)(86362001)(44832011)(16526019)(4326008)(47076005)(8676002)(36860700001)(54906003)(336012)(26005)(6916009)(82310400003)(186003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 18:15:08.6241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a31690-59bf-43af-95bf-08d9932c624c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3054
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

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 31 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 +--
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 41ce86244144..5807df52031c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4287,7 +4287,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 
 	amdgpu_virt_init_data_exchange(adev);
 	/* we need recover gart prior to run SMC/CP/SDMA resume */
-	amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
+	amdgpu_gtt_mgr_recover(adev);
 
 	r = amdgpu_device_fw_loading(adev);
 	if (r)
@@ -4604,7 +4604,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 					amdgpu_inc_vram_lost(tmp_adev);
 				}
 
-				r = amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, TTM_PL_TT));
+				r = amdgpu_gtt_mgr_recover(tmp_adev);
 				if (r)
 					goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index c18f16b3be9c..5e41f8ef743a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -77,10 +77,8 @@ static ssize_t amdgpu_mem_info_gtt_used_show(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	struct ttm_resource_manager *man;
 
-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
-	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
+	return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(adev));
 }
 
 static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
@@ -206,14 +204,19 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
 /**
  * amdgpu_gtt_mgr_usage - return usage of GTT domain
  *
- * @man: TTM memory type manager
+ * @adev: amdgpu_device pointer
  *
  * Return how many bytes are used in the GTT domain
  */
-uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
+uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev)
 {
-	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
-	s64 result = man->size - atomic64_read(&mgr->available);
+	struct ttm_resource_manager *man;
+	struct amdgpu_gtt_mgr *mgr;
+	s64 result;
+
+	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
+	mgr = to_gtt_mgr(man);
+	result = man->size - atomic64_read(&mgr->available);
 
 	return (result > 0 ? result : 0) * PAGE_SIZE;
 }
@@ -221,19 +224,20 @@ uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
 /**
  * amdgpu_gtt_mgr_recover - re-init gart
  *
- * @man: TTM memory type manager
+ * @adev: amdgpu_device pointer
  *
  * Re-init the gart for each known BO in the GTT.
  */
-int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
+int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev)
 {
-	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
-	struct amdgpu_device *adev;
+	struct ttm_resource_manager *man;
+	struct amdgpu_gtt_mgr *mgr;
 	struct amdgpu_gtt_node *node;
 	struct drm_mm_node *mm_node;
 	int r = 0;
 
-	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
+	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
+	mgr = to_gtt_mgr(man);
 	spin_lock(&mgr->lock);
 	drm_mm_for_each_node(mm_node, &mgr->mm) {
 		node = container_of(mm_node, typeof(*node), base.mm_nodes[0]);
@@ -260,6 +264,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,
 				 struct drm_printer *printer)
 {
 	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
+	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
 
 	spin_lock(&mgr->lock);
 	drm_mm_print(&mgr->mm, printer);
@@ -267,7 +272,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,
 
 	drm_printf(printer, "man size:%llu pages, gtt available:%lld pages, usage:%lluMB\n",
 		   man->size, (u64)atomic64_read(&mgr->available),
-		   amdgpu_gtt_mgr_usage(man) >> 20);
+		   amdgpu_gtt_mgr_usage(adev) >> 20);
 }
 
 static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d2955ea4a62b..b9b38f70e416 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		ui64 = amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_GTT_USAGE:
-		ui64 = amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
+		ui64 = amdgpu_gtt_mgr_usage(adev);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_GDS_CONFIG: {
 		struct drm_amdgpu_info_gds gds_info;
@@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
 			atomic64_read(&adev->gart_pin_size);
 		mem.gtt.heap_usage =
-			amdgpu_gtt_mgr_usage(gtt_man);
+			amdgpu_gtt_mgr_usage(adev);
 		mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;
 
 		return copy_to_user(out, &mem,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 91a087f9dc7c..6e337cacef51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
 
 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
-uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
-int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
+uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev);
+int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev);
 
 uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
 
-- 
2.32.0

