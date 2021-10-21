Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2633C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C9E60ED5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81C9E60ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2593C6ECB1;
	Thu, 21 Oct 2021 14:32:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 061646ECB0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 14:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsy8q6ASAfEtykxOt0y7NHfdfW+nNofDKwurM8l0xMccrNiajLQaf5YhPXpbuyZpkyxexbfiNibv9NxwT5XlEZJ4LsJPM5kegnEU/3umbF//hId9qZldgtHxawVl3zy/Oxv8E+RWgObo8Tvi4bKZGVJ4qC+YMxVSAa5rKLuEaN1l4T5hU4w/N9kzKhQXrRFnh4LLnJewaTDBVZ0IuWe3TErhZQsn/fTQvzfM3HPt1hs7B5pbgR8Nh93u4D6bImsMd6D1NqGcVKodo0hXK6aoLCmT0cl9HGe+EAScpaIGVd3ypTHxtzJatO8BAzyqFgNm2G9hDFsqZyVwmtsVn9N+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRULaznZKNRWQs9ZTYVod5olK8xEnkr/UuSRHCAIznw=;
 b=Cu9AthUEOFMuOxbK4PjoGG0UXt4SifnsozrB8xQsDvmBoMP004pXwBtoLUu8MB22REEndE80Qim4D0lXGVWbkHOQa5n10yqCCI75lm/Dwa+c2phIOvlCZLAHxFFxsWbl7ApX1ieBo4xRzASvY5pl9BA6yFtWBcocG3AwoKMV+DFSBhofPXmAewhdmDHgHOIhwVYPpoOnr3Ph9MuX2ScsPuSe9waE1J5/9F8U8J2EnRTAg8dBrsA7FHfYFRzr/eQsuXQ60NuWu1pSFvsSn11L0k3Nykox3GMkb13X38ior3Na2+OzajLWOCyir7jWGwogbPYYzdKhg6v4QJXJ9+jSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRULaznZKNRWQs9ZTYVod5olK8xEnkr/UuSRHCAIznw=;
 b=Wg7zCd8nljCU+MAX3PX00B0qQRcNOyNOyhSL6FKtselBnJMdrX2MJMWkK4TC9cIOKpZslW42RLzXZ77M8NeWlluh/4OUagvpwt8fMVRbeBc8qPGz1ucTlBK+zF3aWCelBOam0MD4Len2nZXasZK5JcibZYqQgdsXalvczcNyO4g=
Received: from BN9PR03CA0120.namprd03.prod.outlook.com (2603:10b6:408:fd::35)
 by MN2PR12MB3421.namprd12.prod.outlook.com (2603:10b6:208:cd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 14:32:01 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::c) by BN9PR03CA0120.outlook.office365.com
 (2603:10b6:408:fd::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend
 Transport; Thu, 21 Oct 2021 14:32:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 14:32:01 +0000
Received: from linux.fritz.box.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 09:31:56 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <lijo.lazar@amd.com>,
 <andrey.grodzovsky@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: do not pass ttm_resource_manager to gtt_mgr
Date: Thu, 21 Oct 2021 16:31:40 +0200
Message-ID: <20211021143142.4900-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b8c4287-e1be-4843-742b-08d9949f8bcd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3421:
X-Microsoft-Antispam-PRVS: <MN2PR12MB342163D16911EFF9EE37D9FA8BBF9@MN2PR12MB3421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ij/q+VJUvpDIOTCD74FJWuJVQWCJC4IBgdBCWZG0nHqAl0CK4IlsIbqvsmAA+LQkNjQEdkpvdBCa1vw3VxvcSZ6Iv/fhq19TyBPj2LN46JrXYFmhA97iQbhCBTThDPKrlSdIl1aTJ9STEPAm0SKlzAnsy2Wr4qUcnC//WgPGoUCJk2wbTmdqEN80vVp3u//A7UJZk2yLcW4CWUQ2TZmWn5GF/AcYBPTJuDhVWMxjpr0ToPTrk2QZEqApdIndM1EsQ7jRKchcEamuNyQ7vFngIV2Hf8JlLt4qQJCFtAjvvEj0WYOAAy5U/IsHIeLtQYC/08CY0Whkh2yEJ1rK5wmfPBKKRojK3WVOdwXQNJ2dGXdVTdhN4VxxllBHAMhA7CMrSWoKHyEF7uISmORcHPXKoNXmyKqWvU7rAT/KN4jEmCD8b3XDBTwGDRAkS3mXInyGztnHwS/RoZoA8o+evgbAx7cCHnG37f6M21vTQjkz52ZS0HslZwmQSJKMH1FTyR0dIb7hMOeexgIUt2aE9ujNFibuV55Di6ZcLqLz6ypiiUurxYdIOfiZXQFSQxMfmQ01/CII8aTdnnWXDwZ3tC5oWP+/WjL2GTfp1f0DCatyIVwh0P4UoHRjpHj4vClntruHga4PbW1GnIUoBckMIWoEtXgZ/GbmA73ZaGLjWC3xaSgJDy0OVGltg3TJ9z1icwyzxDnl126fxhScqzEUJd7t9JGh1ZtFaL2KXei30ZL5I1A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(16526019)(356005)(426003)(5660300002)(86362001)(47076005)(336012)(186003)(26005)(44832011)(70586007)(6916009)(8676002)(8936002)(36860700001)(2616005)(70206006)(83380400001)(4326008)(316002)(6666004)(1076003)(82310400003)(2906002)(36756003)(54906003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 14:32:01.5414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8c4287-e1be-4843-742b-08d9949f8bcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3421
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
index c18f16b3be9c..e429f2df73be 100644
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
+		   amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr) >> 20);
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
2.31.1

