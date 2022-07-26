Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD43C00144
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 23:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB3AB371F;
	Tue, 26 Jul 2022 23:44:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD60B3660
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 23:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3UjsBvWWkCPRK+xepJXUNpxSgmj5Y1urmgbFA3WE7bAY/r5CzCCwybhWdVVIqJtf1ISU/JxavetkoniAvjSm1xUv3nmwfg6MKz90lCD53Snz8m8pkttOldXaMa3WKve2kjJEQgjnIWaQBTD63eUp1ucMjiVozBwqP+aEyL9p6NYyu4frX58x3YPcdTpbrKvjzvqWkmqwq6D51Xj8JReKkwpJAiTIzPsFekugj2yXdwshJ+vfM9W5U/lz0YbgPbdIUcuJaq4K1OPHeDfl0POZCZMvI2PVqGI67DS135JTxFh1xtSXgxVtCLUhooHpitEVtvnVd5STbX7wzOC+IL22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4fu8RE/gmj6Gj5/OmN8OtPeDyxhFOm3O7kaZleRPYs=;
 b=WOLl00IP+s/mXRY5A/44RPzSbsQX8WPZGEdrsBYrDIP+0hDeVqZeM1p7m0wa3pBtNpuGg64njbfxBlpVxtKYEdAC6rTxASV33GkIBuOozZeWOhh78ZcHDOiFHK9AeV4+stqrMdgD//K0KSBgNQaUEJ0ociWLIo3jY8gdLsuPRtMAQsx8mEEQziVDdt6a88GJ7/kL7GamARU/cjRwzBJcfcBGB/AgcSUoSzE4SjO4rWalaL2BFT58xyVG+0TelD3PKmFKoGoa7na/2T0be5qxoLLZe9q6t00vzselEViF9/jpiXdwvAHgjIkdR35O4nB9UIvctzjO118xR7a/lG270w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4fu8RE/gmj6Gj5/OmN8OtPeDyxhFOm3O7kaZleRPYs=;
 b=2ddIyxy6YRIfnpBkVjdA5C8WjLGPopmC8eub+UB67C2wjfGfSRkZaPAA9aYXxpohAHYQ2mNKw+l7bLl+cF3G+RbsFcTYyzbJjm7ioSQ1PzdemdlWlIrm2xF8JmCUNWaRYCBBnRiQke1sFCA7qjMJlLaDLA/FEpAgA5nJ/HpyGd8=
Received: from MW4PR03CA0102.namprd03.prod.outlook.com (2603:10b6:303:b7::17)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 26 Jul
 2022 23:44:06 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::20) by MW4PR03CA0102.outlook.office365.com
 (2603:10b6:303:b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Tue, 26 Jul 2022 23:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Tue, 26 Jul 2022 23:44:06 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 26 Jul
 2022 18:44:04 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Avoid direct cast to amdgpu_ttm_tt
Date: Tue, 26 Jul 2022 19:43:49 -0400
Message-ID: <20220726234349.21189-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dec53c7-c565-4183-d9c6-08da6f60ba9c
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6241:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kp+4hCC+86ATU+PKENY10mUII16EPngJxAsQ0nOYuu29zjXMsWG3r7hJ+LjBw4om4XewfgZ2B75zP9osFBxP4iw+RdSVbGfNN5jLTEPR3xtWIWOV+aTmlMlcP+9BrQmeIiyioTZ22hqh1PnsXr6Hnh2ExEr93EkFVxt3AFY8dTBzyjdZF97ViRawmPn7niMy+/gAcyJj8qqkwXqO8awx9Z3IP5en3Ea1/LQI4AtTEhYqEIOE+9UCojO7uLsTNst/N9aCflZPn4FZWwnPzOefH8y+ADjB3QbJQtW5ddZkmp73vpnHaOyGezSIxhBgeWQmQY/L84AVUxAfA+RDTniGlte5SIXQRcVkHTM8oPDIcklzr3vbdj4pyeBWrN/TnJCvZX2zA7nIQe8KHyj5jQS/MN2EFumThHXSgCQVn0Wp78oS7VllGPJ9iFlCiGPtlJsAJnWN9PbT28Digl56ttO0eXxWGyNpp0J5gi+Bo+CdRyS+c9WgKeB06eZ1ITmd+wkGaDwEGjCxv8jZSvDgEZpQiZDCzqpEslOmfXNm/tR8arcR1kjGPmY6kckpDaViN4CHc5YZEuh40LtIrdlOtOqkaqhQHi8bEC56YXOQgBz/QFOLI8lamBs5EiK4l5g7mT+1aj0B4m/aZQF12fLlzsSGWvC93K/HDr6Cs0FSLmHsMhtqwtorM9JHIKRHVwVun0D/+RYS9D2cTIxBZCmchxTu9bbXG+1bNzMOrGrin4go++uN6WmXCU0S5UaPOdEqKp+i+HNAJwk7nK7GlCC3akGRHrqpX24KZF+xooQ/xmtbUkBSsHl4JD4yMQ1f3OidssPW/lQEA0KiOjQyraD0+RWoPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(4326008)(6916009)(36756003)(316002)(82310400005)(47076005)(70586007)(36860700001)(86362001)(356005)(54906003)(336012)(478600001)(82740400003)(40480700001)(1076003)(6666004)(41300700001)(44832011)(83380400001)(186003)(81166007)(70206006)(8936002)(426003)(8676002)(7696005)(2616005)(2906002)(16526019)(5660300002)(40460700003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 23:44:06.2856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dec53c7-c565-4183-d9c6-08da6f60ba9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 44 ++++++++++++++-----------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index be0efaae79a9..cd6aa206a59e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -637,6 +637,8 @@ struct amdgpu_ttm_tt {
 #endif
 };
 
+#define ttm_to_amdgpu_ttm_tt(ttm)	container_of(ttm, struct amdgpu_ttm_tt, ttm)
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
 
@@ -927,7 +929,8 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct ttm_operation_ctx ctx = { false, false };
-	struct amdgpu_ttm_tt *gtt = (void *)bo->ttm;
+	struct ttm_tt *ttm = bo->ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	struct ttm_placement placement;
 	struct ttm_place placements;
 	struct ttm_resource *tmp;
@@ -998,7 +1001,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
 				      struct ttm_tt *ttm)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	/* if the pages have userptr pinning then clear that first */
 	if (gtt->userptr) {
@@ -1025,7 +1028,7 @@ static void amdgpu_ttm_backend_unbind(struct ttm_device *bdev,
 static void amdgpu_ttm_backend_destroy(struct ttm_device *bdev,
 				       struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	if (gtt->usertask)
 		put_task_struct(gtt->usertask);
@@ -1079,7 +1082,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
 				  struct ttm_operation_ctx *ctx)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	pgoff_t i;
 	int ret;
 
@@ -1113,7 +1116,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
 static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
 				     struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	struct amdgpu_device *adev;
 	pgoff_t i;
 
@@ -1171,18 +1174,19 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
 			      uint64_t addr, uint32_t flags)
 {
 	struct amdgpu_ttm_tt *gtt;
+	struct ttm_tt *ttm = bo->ttm;
 
-	if (!bo->ttm) {
+	if (!ttm) {
 		/* TODO: We want a separate TTM object type for userptrs */
-		bo->ttm = amdgpu_ttm_tt_create(bo, 0);
-		if (bo->ttm == NULL)
+		ttm = amdgpu_ttm_tt_create(bo, 0);
+		if (ttm == NULL)
 			return -ENOMEM;
 	}
 
 	/* Set TTM_TT_FLAG_EXTERNAL before populate but after create. */
-	bo->ttm->page_flags |= TTM_TT_FLAG_EXTERNAL;
+	ttm->page_flags |= TTM_TT_FLAG_EXTERNAL;
 
-	gtt = (void *)bo->ttm;
+	gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	gtt->userptr = addr;
 	gtt->userflags = flags;
 
@@ -1199,7 +1203,7 @@ int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
  */
 struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	if (gtt == NULL)
 		return NULL;
@@ -1218,7 +1222,7 @@ struct mm_struct *amdgpu_ttm_tt_get_usermm(struct ttm_tt *ttm)
 bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
 				  unsigned long end, unsigned long *userptr)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 	unsigned long size;
 
 	if (gtt == NULL || !gtt->userptr)
@@ -1241,7 +1245,7 @@ bool amdgpu_ttm_tt_affect_userptr(struct ttm_tt *ttm, unsigned long start,
  */
 bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	if (gtt == NULL || !gtt->userptr)
 		return false;
@@ -1254,7 +1258,7 @@ bool amdgpu_ttm_tt_is_userptr(struct ttm_tt *ttm)
  */
 bool amdgpu_ttm_tt_is_readonly(struct ttm_tt *ttm)
 {
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
+	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
 
 	if (gtt == NULL)
 		return false;
-- 
2.17.1

