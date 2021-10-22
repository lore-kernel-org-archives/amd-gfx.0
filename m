Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CDFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 10:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973E86108D
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 10:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 973E86108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED29489CB5;
	Fri, 22 Oct 2021 10:54:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4BB789CB5
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 10:54:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bulV6MZ+6qpqnwaUGnCm6hZePujLga8uTkr52KQKbfoEM93Ok6OjBkkVBYV75XxFOW0C9w7ieKcwipDqXIGqb40IZB6/vRMlsc3Thzgqp14OF/xg5at5n6hhHkA9ea3MTUVsrk0ZECvCRsNCbLukeSNHGA3jJDwJd9pwTCi1RnJP7qTEMMsmWtOWxL6efJh0QHKexAXBWJkc2baRe4oDjZhFf6+HuNmW2N8uw/6LxOl78AAaUI1UIlbIYR6rKCQ9qrKNA/AQi9ZYO4Su4/wQPaX26y48BZchXcvCQfLWgFNc2UYe+XJrjvXbf6uBF49trhIE6FyFqMbhXQZbQjbNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1oq7kAc40FgMzhQdcgegPWX/km2mWC5T4wZYoOJros=;
 b=RHHq1D8QQml5Wmik6KmvXy/cB8mtM30ibVUaLNDqDaIR4sgqkLpAKrKU9vmDQFnPF47OR596bw2j67zXPPldJ4A2QI4nJfZBj9CDRoHvKsQ1JmA9r5BzGQdpNuCAZsJw5akq0MQY9HXCeUrK8E4c2271b2jAnvZg9pKGeN7ApX5i4HXWwXpnLQ4jfnRDvRuw0ZzGhZJlGDjI0si68LINWdpQRxMOKocK+ZB8ukkPoTakQ36iSvJl+4cInP96rGXZUlw/QXejkiXe3fIaRIzKsh+0xnPUg6c9Fk/FJTaIPWTWh1h0QbcIodn291r6jvUbc+8M51Vc3kkHch56ZMDWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1oq7kAc40FgMzhQdcgegPWX/km2mWC5T4wZYoOJros=;
 b=vttiVwX0T+Mx0Is7jD1Y4Uwj6u+KjbVU7aFNae06SP8EWFEcdomiAW+MFCrPekcIn1Wu5VNmjpoXl22wUlPqLwiwFRODIL5nHQ9khOC94s5jaf6xlYI8ZrbU6SOSW/1m7anIU3d4IsH79kh1CGlDIe9xP2tQRLyQnlKDthVyKog=
Received: from DM6PR06CA0020.namprd06.prod.outlook.com (2603:10b6:5:120::33)
 by BL0PR12MB4753.namprd12.prod.outlook.com (2603:10b6:208:89::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 10:54:34 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::e8) by DM6PR06CA0020.outlook.office365.com
 (2603:10b6:5:120::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Fri, 22 Oct 2021 10:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 10:54:34 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 05:54:33 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>,
 <lijo.lazar@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH v4 1/3] drm/amdgpu: do not pass ttm_resource_manager to gtt_mgr
Date: Fri, 22 Oct 2021 12:54:21 +0200
Message-ID: <20211022105423.69769-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48fe79d7-78d6-40fe-8416-08d9954a55a2
X-MS-TrafficTypeDiagnostic: BL0PR12MB4753:
X-Microsoft-Antispam-PRVS: <BL0PR12MB47535B034EC7E70232DDC5B98B809@BL0PR12MB4753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AB5JEMhnUSbu/GbjeSszKuorHQ36NqPG1FUCX3Ekp2oryGC9DK/bEwCK4tchB78rx/UNQDbQ4lxxGqoCFptU1OG63QrjRL6yOJ9Gq+UwqXLW8aRtOBeMi/WBhe31TAL/NoPm43lMPmGdwhCa17HG5F9H7nCFTTeFRKt1MGGt7x1DtZ30w2F/+dFU9HghxOsag3gPdnuQifw2DW//OZ2PZ9pSNI/EL/DX1+xna5KhSvL0rMla/hHdHjsUFQl/R38sx3nb6HWJyQGPFcnR6/qpG+SkjD/t2tj9pLwz0iWdvyEPjWMmQtSk/hzPoavUXiXvRgnBg9xyZqwou3KCSe2L4wJwHt7qN+uLTzQu6jDwskk0j1PJJBvytXfJcgdMOwIfMe8/fEI6RShrstjjEn6qxEmiHa6wLJfJUO4H9sQVIseZNaWwT6ZaaxH9X+qmy5feeciIAgIbTGyQCHk1OARyV97cOUJGLTw2HEL2UwaNJHgH66IocI74FJBHCAofXMxH0NxX7ODDV24dStEzK0arURFKagUVvTafovh4GHVaUYiB00TqUcJQUy/XmZFHoJoraC9mmoW+fQTsSJ2909dEOtFtQtG71dP/bLoxZURNHoh5k1KjmaL+G82O73RZXTkrtjFTe7Qsls5r7SXjhAGzxKWosCWB2/gQ9QsmGJ4Mdzjs+J0tZQo+yZ7ER+IkiLv3zX1wp4r3RYkusS2jBGI8g5U0ZesiZ+ocV42dsF0skow=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(70206006)(81166007)(44832011)(2616005)(6916009)(36756003)(70586007)(6666004)(8936002)(8676002)(54906003)(47076005)(26005)(426003)(5660300002)(82310400003)(508600001)(4326008)(7696005)(316002)(36860700001)(1076003)(86362001)(336012)(2906002)(16526019)(186003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 10:54:34.5668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48fe79d7-78d6-40fe-8416-08d9954a55a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4753
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

v4: remove unused adev.
v3: upcast mgr from ttm resopurce manager instead of
getting it from adev.
v2: pass adev's gtt_mgr instead of adev.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 22 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 ++--
 4 files changed, 16 insertions(+), 18 deletions(-)

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
index c18f16b3be9c..9151950e0cc3 100644
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
@@ -267,7 +265,7 @@ static void amdgpu_gtt_mgr_debug(struct ttm_resource_manager *man,

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

