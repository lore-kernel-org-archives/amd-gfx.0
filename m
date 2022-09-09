Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274BAECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 18:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5675D10ED95;
	Fri,  9 Sep 2022 18:25:55 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4EB910ED95
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 18:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdtNSbmDncpdOoViayXd9rxNkKTfElp1Qy97oCR0uGYRS+Tcu7RoM8nKFbigsYe/yQX4vzjd1x+4j55Dix1gBmdmON809dOCIcJ9ZuQteePSDrUa3qrtzOU4iRDwqQknVvWtBLCmrKXcZ/ZlMk6Fb4Z/gxErbPf7vQ512v9SLEzcME5upBNMXds36n723XntqxdkKAcaczFkaY7Z2LiU69xRf+a4a5yYppFjMkKJrhlmBOk0sTWvJRJC0jspTfddprRHpZxGCFuy6IP6L4kLUgYCkM9Y/GUdjnnVdtaGi3MFaAwSHfbYSWPU0mhydFxJMKIK+q5EfIF9hhGTkT4dJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf1LfjC6HDqrtfLvsJBPQ1mZo4tEYV4BO3L8eSIqJac=;
 b=Kfd2DiUIVe0W5Nef93cH9QeGL9yYfcVwROOkTr+xoE5WGvOureKYByZ74tXElczjlL5cvbKhQTagvXuOMjrFeIP6fASOmJ7jih1NAbZq5BJlHnLkAtP67GbZqCtIP9yi7gUf52kRPSZqcuMCt3kWCJKt1cLKiVKSXoIG+Xjk4HVS269v7prljBaZFWilK/QFrEidzTOwsHPvQqC9Am89kj7PmWirgO8+fxxpy57Dc6AakE7EYBWUMQBBNKNbfNYZmVf91HuTGcmgdm5ji81wtmVMmPAiiY9nZ5P8hARgP2dT7vEs+a+588eC1YJQ1oXlkI65IE/Li4zKCqEFjfZfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf1LfjC6HDqrtfLvsJBPQ1mZo4tEYV4BO3L8eSIqJac=;
 b=mHVUT4WoIibTmZ5j7OUsXcbn6kObv+K+V8Pb3rUi5Kv5em0JzU/nje3J7nQd0owaf0oSVzZjXe9ggsLm/WhTvoLpwPhT3C+HQNcAqqVn7+fBhQO3HotJGifKZWD+L9EGLHkBNnhHn1X/TFxcQQ8mf0f98V0EF1dAfzJBJYm5WdI=
Received: from DM5PR06CA0093.namprd06.prod.outlook.com (2603:10b6:3:4::31) by
 DM4PR12MB5770.namprd12.prod.outlook.com (2603:10b6:8:61::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.18; Fri, 9 Sep 2022 18:25:49 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::f1) by DM5PR06CA0093.outlook.office365.com
 (2603:10b6:3:4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 18:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 18:25:48 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 13:25:47 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: fix amdgpu_vm_pt_free warning
Date: Fri, 9 Sep 2022 14:25:02 -0400
Message-ID: <20220909182502.13995-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|DM4PR12MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb99cf7-d07b-4c2f-8a1c-08da9290b830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9E8hOpRdZH1DFkfyrzCfzOfCfYMDRUDkl2LDBl+yZqbIRltrnNckYBXpSR6zC9AiDvvgcQwlFvkaqGlhpkR28svAXzsNp+ANjWAvbUBdmgC/ZOxFENhM4xyL2mjpnISmcn33qGyBsMOfXlni1C0eq/XXDafE/1WavbaqFiwkq5x0Kh1PYDmB0eSdkYTFo8TC4hgxZTwfCVXc35AfOeYCUSeGImvWobtF1YnBrXCgxw3y+kmyCVMBWXFVjz3ei0oyngSdsl7ME5c8/+MMlj4iBqWIQc+FOnDKxA6njc4kU4K9O2zGWgpaM+xsxMpukdbX4/iTBW2j49tw2oRlft0irxw2imFY1OeGHTwWIBVdDihOhia4lI/yKhnlbpEptMaTQ+zbjAknHbyNWuZ4XCtiut87XDv7noZut+w9Gc5COj9igvEVMKw4YYTwN1acU1npev+YXjXuzphQqnFtIpW9kJJ+PdQgtbrPJ7iN2Sdc7D09TfdNs9+VfhbtSm5r/82ehBkRzM4iFtL1cGr2gG+zWarjHYU7zAmnEReh+YoU8VpZh8U4N6TSPG9cC/NWDuoBAynmwIWqHgINVhEvceUB/GXGOwqKl6uXALo8HocO1VOQY252adcSuy8saRlcrcuwq9ppAxe3hHB4YcvEpLpdPoubm8e0x50Xs3eYC/NnQ3hK8nS3gRQ/iRv/fEKwVjonYPsK63t1W9wTr3MWBSjCSquiU+xUzivofLrzKwNaMBJXK7mP07OR7xG4cQWwNudZ55E9wqUydWV8QLR2kWpiLkGwCfFpGVN+pg14K/SAS8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(41300700001)(5660300002)(86362001)(54906003)(7696005)(6916009)(316002)(2906002)(40480700001)(26005)(47076005)(426003)(6666004)(36860700001)(186003)(81166007)(16526019)(70586007)(82310400005)(2616005)(40460700003)(82740400003)(4326008)(8676002)(336012)(8936002)(356005)(83380400001)(70206006)(478600001)(1076003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 18:25:48.8543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb99cf7-d07b-4c2f-8a1c-08da9290b830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5770
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Free page table BO from vm resv unlocked context generate below
warnings.

Add a free_work in vm_bo base of each page table BO, pass vm resv
unlock status from page table update caller, and schedule the
work if calling with vm resv unlocked.

 WARNING: CPU: 12 PID: 3238 at
 drivers/gpu/drm/ttm/ttm_bo.c:106 ttm_bo_set_bulk_move+0xa1/0xc0
 Call Trace:
  amdgpu_vm_pt_free+0x42/0xd0 [amdgpu]
  amdgpu_vm_pt_free_dfs+0xb3/0xf0 [amdgpu]
  amdgpu_vm_ptes_update+0x52d/0x850 [amdgpu]
  amdgpu_vm_update_range+0x2a6/0x640 [amdgpu]
  svm_range_unmap_from_gpus+0x110/0x300 [amdgpu]
  svm_range_cpu_invalidate_pagetables+0x535/0x600 [amdgpu]
 __mmu_notifier_invalidate_range_start+0x1cd/0x230
  unmap_vmas+0x9d/0x140
  unmap_region+0xa8/0x110

 WARNING: CPU: 0 PID: 1475 at
 drivers/dma-buf/dma-resv.c:483 dma_resv_iter_next
 Call Trace:
  dma_resv_iter_first+0x43/0xa0
  amdgpu_vm_sdma_update+0x69/0x2d0 [amdgpu]
  amdgpu_vm_ptes_update+0x29c/0x870 [amdgpu]
  amdgpu_vm_update_range+0x2f6/0x6c0 [amdgpu]
  svm_range_unmap_from_gpus+0x115/0x300 [amdgpu]
  svm_range_cpu_invalidate_pagetables+0x510/0x5e0 [amdgpu]
  __mmu_notifier_invalidate_range_start+0x1d3/0x230
  unmap_vmas+0x140/0x150
  unmap_region+0xa8/0x110

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 40 +++++++++++++++++++----
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9ecb7f663e19..ac7cd2c738e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -150,6 +150,9 @@ struct amdgpu_vm_bo_base {
 
 	/* protected by the BO being reserved */
 	bool				moved;
+
+	/* work to free pt bo if vm resv is not hold */
+	struct work_struct              free_work;
 };
 
 /* provided by hw blocks that can write ptes, e.g., sdma */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 88de9f0d4728..e6f6d7e6368f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -37,6 +37,8 @@ struct amdgpu_vm_pt_cursor {
 	unsigned int level;
 };
 
+static void amdgpu_vm_pt_free_work(struct work_struct *work);
+
 /**
  * amdgpu_vm_pt_level_shift - return the addr shift for each level
  *
@@ -607,6 +609,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
+	INIT_WORK(&entry->free_work, amdgpu_vm_pt_free_work);
 	r = amdgpu_vm_pt_clear(adev, vm, pt, immediate);
 	if (r)
 		goto error_free_pt;
@@ -624,23 +627,46 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
  *
  * @entry: PDE to free
  */
-static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
+static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry, bool unlocked)
 {
 	struct amdgpu_bo *shadow;
 
 	if (!entry->bo)
 		return;
+
+	if (unlocked) {
+		schedule_work(&entry->free_work);
+		return;
+	}
+
 	shadow = amdgpu_bo_shadowed(entry->bo);
 	if (shadow) {
 		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
 		amdgpu_bo_unref(&shadow);
 	}
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
+
 	entry->bo->vm_bo = NULL;
 	list_del(&entry->vm_status);
 	amdgpu_bo_unref(&entry->bo);
 }
 
+static void amdgpu_vm_pt_free_work(struct work_struct *work)
+{
+	struct amdgpu_vm_bo_base *entry;
+	struct amdgpu_bo *root;
+
+	entry = container_of(work, struct amdgpu_vm_bo_base, delayed_work);
+
+	root = amdgpu_bo_ref(entry->vm->root.bo);
+	amdgpu_bo_reserve(root, true);
+
+	amdgpu_vm_pt_free(entry, true);
+
+	amdgpu_bo_unreserve(root);
+	amdgpu_bo_unref(&root);
+}
+
 /**
  * amdgpu_vm_pt_free_dfs - free PD/PT levels
  *
@@ -652,16 +678,17 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
  */
 static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm,
-				  struct amdgpu_vm_pt_cursor *start)
+				  struct amdgpu_vm_pt_cursor *start,
+				  bool unlocked)
 {
 	struct amdgpu_vm_pt_cursor cursor;
 	struct amdgpu_vm_bo_base *entry;
 
 	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
-		amdgpu_vm_pt_free(entry);
+		amdgpu_vm_pt_free(entry, unlocked);
 
 	if (start)
-		amdgpu_vm_pt_free(start->entry);
+		amdgpu_vm_pt_free(start->entry, unlocked);
 }
 
 /**
@@ -673,7 +700,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL);
+	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
 }
 
 /**
@@ -966,7 +993,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 				if (cursor.entry->bo) {
 					params->table_freed = true;
 					amdgpu_vm_pt_free_dfs(adev, params->vm,
-							      &cursor);
+							      &cursor,
+							      params->unlocked);
 				}
 				amdgpu_vm_pt_next(adev, &cursor);
 			}
-- 
2.35.1

