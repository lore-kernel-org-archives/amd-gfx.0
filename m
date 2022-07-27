Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C31C04A68
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 19:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F61BA1A84;
	Wed, 27 Jul 2022 19:52:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73C592F64
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 19:52:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAFgVjDIuwMUwgbqjVjyxG1s7RABWe93aBFBKyJU+s/Qrklk8b+Dh6kEaeVsgTsUC2DZbt9Y9cOfpQwdKF8IiGK32j5YFqmEHnxznbRLDs1C6dYv/RGD7YjO5H4OmAea9kZGDKqv7yoobjBfTmd1yHo2sBtafvo7y45wXxmR55l+iGy7pQl9E6b4i0HKvHRNNVAeuZnmSVOxWj2Iovh8dzss4+QW3a6Yx/z9sbDp8l6BUC2dcT3SlG6j4e8wUdNGh+8SlGxxoFIMEXdiILaWi8TlKYD77QA9zlcBX+lbn0NregMjkQiyOprgOH5fEwXyQ0kClHqBDRqYuXXOrvGq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvzBfEDZ1TwwmYy1aSqcZY9cNMACl+bYNZjEDpIECow=;
 b=gnq1JaJPcuuIW6u6EWZSxsHFv5ruE5XchxQyWjOZ+qrEx/OISI5xxDTpmratrFMLx6OSq0197cCMmk5+MQmQBNwNe9sSYihxh/9v8+ErsWZbvdHgrZHeKx7huLtNVmym8+hBYDwsw52psKoTcjcR/DyhaAzxh8wMfLrZ1PShHXnjLgr0jwg2XVxe67kgZp7Pu6MKxWgFwokYqpfi4/DE98tzf6+VZ8ePFYPnJc11MOt4vCXr/JEY61SCNaVFAU66An1rSlTpCXSlikJq8z7RvyrchIdujSjMa3beKjUJJd+q9jWLwCh5C/0+VYrs2SsC131dIB3lGA3RbE64JwQblQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvzBfEDZ1TwwmYy1aSqcZY9cNMACl+bYNZjEDpIECow=;
 b=UozAAfd30i4JOEgzqmL40XF7shgbZLf/AFrIFVgbTfxaoKMLGqzSanxuLlfpQajR5jTNPViK9PpJn12efEkcP9oyMpHzb6E66YCwwOVKe0PILSz8IE9cT4zqOLYkJeKoGJFQonOsNP6aEcgV4EUJ8v9ztObHHt+bhOQvubO0zYc=
Received: from BN8PR07CA0004.namprd07.prod.outlook.com (2603:10b6:408:ac::17)
 by BN6PR12MB1556.namprd12.prod.outlook.com (2603:10b6:405:4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 19:52:04 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::b8) by BN8PR07CA0004.outlook.office365.com
 (2603:10b6:408:ac::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20 via Frontend
 Transport; Wed, 27 Jul 2022 19:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 19:52:04 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 27 Jul
 2022 14:52:03 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [Patch v2] drm/amdgpu: Avoid direct cast to amdgpu_ttm_tt
Date: Wed, 27 Jul 2022 15:51:49 -0400
Message-ID: <20220727195149.21235-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65c14715-fd54-4166-89e6-08da70097af3
X-MS-TrafficTypeDiagnostic: BN6PR12MB1556:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYMU8FUVqYXE4IaHVbDb2PKBasAAXhFOgajKM8NMxSrOWIPaEkM2UnpDuA9vczNroi/tcGaZDcaipSu9rbYZ8hZxZtQSe+ee/1tPO+oUk6V9REBkpmMmEb16BcdXg00JjdXsEldujHlXobnJk+NyIAKXN5mC3tASI830n0Q9KFAv5t83k3qkj8vjsCFmxYVKzu/mB/ma0EjGJR3hfetL5L0Bn2y56+hWij4r/78JKfjUNiEgkNmsZ3ZdRMmak3zcOeaZPJu1EZTr/fSSuieDH0WDfRps2UQ3gF3qQoUZrVxCZ7J+NFYCDBEXEd3uTZvzJCt5zAJPzS8PV1ee5chLekX0op/CKGwW4FxRYF6zipRoL5foGwfMl9H+KusCmK0lyLTqcHPuIoowWsUzey/YBfrdYRAJvorM4++bNKBcQp5FHNHmiRnf1a+WJTNgI3Ikh08nFAqqbTYFvW4xf1NBXRPF1jSEfUA41jYrfIUDTQ4Sy1JsEnGijiNQebFq5WCo/rizar5oX32hCl5dQJo4NSBzkITHemSb2kc/qopEiY3hde1kf0mWT3B7cKsvpADAfTacAUfJD9OCctjVDNDtEblBvCOcnEKX8uBALT4xEpzDCJwzjqzHmuXvliWm6fFgJigxwbScJhBrmtTDSRhal55dKwh0YaxreAPFMPDBirdvZfsFmuPTOjMmoiYoxnFxNlSiIao2iFQ+y4uCZKk/QfPoB/U/KJ+hCc2vj87rtkWhI09Ww2wa490yd/uXTQIDUM6g10Nqqj1bk+L4FhagHKE8LZOd5Rhl4ef6pRr4vEsX/iQM27CGPODedu+dTYW8DTTUA2EbC/VCtxdW8Q0WQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(40470700004)(46966006)(16526019)(186003)(82310400005)(1076003)(2616005)(54906003)(6916009)(316002)(36756003)(83380400001)(426003)(40460700003)(26005)(336012)(47076005)(7696005)(40480700001)(478600001)(82740400003)(8936002)(70586007)(70206006)(356005)(86362001)(8676002)(4326008)(2906002)(81166007)(6666004)(5660300002)(41300700001)(36860700001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 19:52:04.5519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c14715-fd54-4166-89e6-08da70097af3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1556
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For typesafety, use container_of() instead of implicit cast from struct
ttm_tt to struct amdgpu_ttm_tt.

Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
Changes in v2:
 * Fixed a bug that Felix pointed out in V1 by updating the macro
   definition

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 34 +++++++++++++------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index be0efaae79a9..8a6c8db31c00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -637,6 +637,8 @@ struct amdgpu_ttm_tt {
 #endif
 };
 
+#define ttm_to_amdgpu_ttm_tt(ptr)	container_of(ptr, struct amdgpu_ttm_tt, ttm)
+
 #ifdef CONFIG_DRM_AMDGPU_USERPTR
 /*
  * amdgpu_ttm_tt_get_user_pages - get device accessible pages that back user
@@ -648,7 +650,7 @@ struct amdgpu_ttm_tt {
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 {
 	struct ttm_tt *ttm = bo->tbo.ttm;
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	unsigned long start = gtt->userptr;
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
@@ -702,7 +704,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
  */
 bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	bool r = false;
 
 	if (!gtt || !gtt->userptr)
@@ -751,7 +753,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
 				     struct ttm_tt *ttm)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
 	enum dma_data_direction direction = write ?
 		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
@@ -788,7 +790,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
 					struct ttm_tt *ttm)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
 	enum dma_data_direction direction = write ?
 		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
@@ -822,7 +824,7 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(tbo);
 	struct ttm_tt *ttm = tbo->ttm;
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	if (amdgpu_bo_encrypted(abo))
 		flags |= AMDGPU_PTE_TMZ;
@@ -860,7 +862,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
 				   struct ttm_resource *bo_mem)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
-	struct amdgpu_ttm_tt *gtt = (void*)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	uint64_t flags;
 	int r;
 
@@ -927,7 +929,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct ttm_operation_ctx ctx = { false, false };
-	struct amdgpu_ttm_tt *gtt = (void *)bo->ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(bo->ttm);
 	struct ttm_placement placement;
 	struct ttm_place placements;
 	struct ttm_resource *tmp;
@@ -998,7 +1000,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
 				      struct ttm_tt *ttm)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	/* if the pages have userptr pinning then clear that first */
 	if (gtt->userptr) {
@@ -1025,7 +1027,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
 static void amdgpu_ttm_backend_destroy(struct ttm_device *bdev,
 				       struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	if (gtt->usertask)
 		put_task_struct(gtt->usertask);
@@ -1079,7 +1081,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
 				  struct ttm_operation_ctx *ctx)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	pgoff_t i;
 	int ret;
 
@@ -1113,7 +1115,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
 static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
 				     struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	struct amdgpu_device *adev;
 	pgoff_t i;
 
@@ -1182,7 +1184,7 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
 	/* Set TTM_TT_FLAG_EXTERNAL before populate but after create. */
 	bo->ttm->page_flags |= TTM_TT_FLAG_EXTERNAL;
 
-	gtt = (void *)bo->ttm;
+	gtt = ttm_to_amdgpu_ttm_tt(bo->ttm);
 	gtt->userptr = addr;
 	gtt->userflags = flags;
 
@@ -1199,7 +1201,7 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
  */
 struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	if (gtt == NULL)
 		return NULL;
@@ -1218,7 +1220,7 @@ struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm)
 bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 				  unsigned long end, unsigned long *userptr)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	unsigned long size;
 
 	if (gtt == NULL || !gtt->userptr)
@@ -1241,7 +1243,7 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
  */
 bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	if (gtt == NULL || !gtt->userptr)
 		return false;
@@ -1254,7 +1256,7 @@ bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
  */
 bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	if (gtt == NULL)
 		return false;
-- 
2.17.1

