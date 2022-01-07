Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C32FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 08:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9EA11AE9F;
	Fri,  7 Jan 2022 08:51:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4701411AEA2
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 08:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFIhKa6Yq1czikfjVLBetSGAPW9yoBawVcc59MfX5cf206F7mExwKa8tMOPfpZX503z8Sllxc8wixi5O6cChh8YzURRnwrmlDVs8Rmg+AgkJqGlNcdIisItitTgdcutO0jp3tUB1JSo2w7WBQVGow4wJEiiH7ELmVG0qRDQfIpyRnmvzx/kWOy1OtkzbcmjUvFNhDWzhFzxvvSOr7lKhnPgj1+WGVSEsxpOEq8a11/zTkgtPxJXjWSMuKO5ruZ7aGVG5BM9ndt6+to5blQWoh1iqgOMuqutOa42ZdBX/CtRKaBb7x7UI2MGvBhsUdKoBl3U2o+CDauD/aGIZlwIWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6geFC+pJe600f/eE6E1RUBloWc7Z7vwu8PV8pOpZWMg=;
 b=ohAF6c4wtvtzm9NKtDvC61PtLAaRvrsa9qgfqieclhs9aH18QGHsZJacrHzj/IH8jYfLH629PJH6jYBTnZJ1YBEHrRVfD1S7sY8yzMpvKVWDdNdga1SqYrwdqZi+O6umqJ2mcNM4UZEapsdoXf/iQ0AcDRcOEAUZmFDIP44Gr6ycrHkVFf7jw9duN+PUrB82KlbW2okW1MNh7ZO/cM9sgdFxByRnDpdxBNfJb+3r/Pacz0fBFroXl6XVxANDpeuq8fhrFkBx3t/k5/PA96opGk9JDScdsOoz5nrjXre0hYnYWORnXtt4sd0dhyZAo91zOLOhphitHf+SRjgp3tScjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6geFC+pJe600f/eE6E1RUBloWc7Z7vwu8PV8pOpZWMg=;
 b=WyFNQ9QO8wcbidh2wQM9UvvKthD9I2IKrghVKfKLI1/vcAWtdLvSICK+uE6Jeg997yBwU+VhIR6OEW3ny/uT5sITdYovyFDP7U1pz4axLux0ZkiEsrEFth5lTF0HK7xrUsOYaLfT1JV01gIwi7wHn4DeMJ/lpfi+ZsZRvjRKENY=
Received: from MWHPR17CA0084.namprd17.prod.outlook.com (2603:10b6:300:c2::22)
 by DM6PR12MB2826.namprd12.prod.outlook.com (2603:10b6:5:76::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 08:51:36 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::9d) by MWHPR17CA0084.outlook.office365.com
 (2603:10b6:300:c2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Fri, 7 Jan 2022 08:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 08:51:35 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 02:51:34 -0600
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH REBASED 1/4] drm/amdgpu: do not pass ttm_resource_manager to
 gtt_mgr
Date: Fri, 7 Jan 2022 09:51:12 +0100
Message-ID: <20220107085115.8820-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb7fe160-6a4b-4b2e-fc94-08d9d1bae970
X-MS-TrafficTypeDiagnostic: DM6PR12MB2826:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB28262144CE5C646E8388997A8B4D9@DM6PR12MB2826.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rIEMwlGyOsbx4W/xvuClzIzDt1Sz+7Uy7M4egTwiT5mzY9QR9IaGI2GzMqr6UkkaTaSpTTXIW6RNdBiBn+MDQvMk6K4eQKXV5HnBLyZTPw3kpmVuRqnwKdz5Ap7Xcw8QNT87QY8TyxKFzKCtwcvpLz0Ed+FYmINntYScwy3IyMNX6obdYDwXTHoAB0M8bMaEd5vs3/cw1thw2AMQIdRe9bOWAnZhi1JDm2CcHhHnW6L4f41aTSvXyowD0CX9nYCPEKvPWFNEQIHRZL9FoTQlfrYQTzyFDUVvXH/OzrEiGDmr9pIXxTDPO7tAa/Y/H7cR93A+K42nDBtAuzQse05yPYgS4DfxAavL2qGzg2iiNajqPnHVYfXQc8TQSbJ/dqk6bYFE3aCFleXE3qLMlhQiMnu7BiT0zdF+NI1Ugf8P5QGjfYD1GeUzgfryo4MbvtycuAlB8v6x4J8kaEBvBxVK0130pJFaYqxfd4x11v1mrFbwunZUpdQxi7JL8Y0OxSKR3gKSsWnFBqioCmyyOgMhNeqnzE/+poOktvRKQTrZswiFS0r8Psicq8DaoRe9OONz/12hE4LhVZyY5JqdwpQqnUO0qIMOIMZ8GN1SsCz3ubSFISgjqMWM2NbBJHwvHoumCqhr8Q1EvSN9lwPk+3l/m7GE4OlhTaA2I8TgNmWaS+8GamfkQcfLMV4NZnIDY1e8mTtjBnOecEuyBUtPU7UZbVD7aM/zjPIvU95OVEeNKq8uAr+kS1HzhGsscykydBVgD19pb9HDTiG56bmvbWGaQsQzofWrl5r/WKxuvQryqow=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(40460700001)(82310400004)(8676002)(16526019)(316002)(508600001)(47076005)(1076003)(6916009)(83380400001)(356005)(86362001)(54906003)(36860700001)(2906002)(70206006)(4326008)(81166007)(44832011)(36756003)(70586007)(8936002)(7696005)(2616005)(426003)(26005)(5660300002)(6666004)(186003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 08:51:35.8691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7fe160-6a4b-4b2e-fc94-08d9d1bae970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
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
Cc: andrey.grodzovsky@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
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

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 22 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 ++--
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3aab187520c6..58b9a5176082 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4357,7 +4357,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 
 	amdgpu_virt_init_data_exchange(adev);
 	/* we need recover gart prior to run SMC/CP/SDMA resume */
-	amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
+	amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
 
 	r = amdgpu_device_fw_loading(adev);
 	if (r)
@@ -4677,7 +4677,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
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
index 651c7abfde03..763de822afa1 100644
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
2.33.1

