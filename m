Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299F0C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 19:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB40A10E5B5;
	Thu,  1 Jun 2023 19:32:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C993F10E5AF
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 19:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw/A9PrZM/4lfNxUw27cTPBt1PC86kHPC8cm5HLwMp3RKP3s9najnDEjCqRjkT73epeFZ9ueQpWDRttpJ3LIEcTkGUdaHbMFpjaQu78MgS6JNv4hRDCAuaPkLDW8Z2r73IK9iUv3fMpCDeFVHUx/eMTHM/bz1e89YrJRudC5E/SWpLQj6FQfDhu4O7aFzJ1t4NMxNKwjQz2/4AdxkjebhRhVL723VOnuSVwut9XjWH5m6hVOEYLspdBoCLRn2GuabxtiubXzy1aMnWNLnYLUjp4cdhkrk1FhevF6dZHseboLWy2dtk16mETDvgT1U7UtgIcW65GwY82um95THZOpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l5N+TYzuMZ+mBi2kle7l7fVQ8mwwaVgKtdRmrkyg2c=;
 b=hDt9TLjIqupITuP5OH5WM9MVs9ARMiDNLuvcUKoLT9pPbAVbLdYlg1Omgp8rc+kcVjldYpYFhR1Q4m1osFY7SlMHbP49Z3+VtzDkcNchD++qH/CP5xATz1QU478rLir2Q7cTSuvWjvuGKA0jN/jDbh3DodA9bmrfFibkvoupqoeUokUc71/Lw+5FRqpBhUx1quqLrpUQ5OUYvtqQUUpywS5PozgQovjW9xwL1sA/KYXDoBwe0Cz+4Zxs3a/Y8d02O2vc2GkDvtRCKP9pc2KhU9AxsttSi53tMAHibC1HcyhAQxZkD8aIB3EbcmHfCw9uw7yyGSBRX6XFnijyo8CStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l5N+TYzuMZ+mBi2kle7l7fVQ8mwwaVgKtdRmrkyg2c=;
 b=ox9W4gATlLGvut87Bm/o6GrQvSceVMG2JvYi28Xr/kcomgTp5DTsAc/9+42ICD9ImDTlH5wy3FSfVl+a3JmFS/B/Oieu3wvjfkBGlC4BqIqXVmlqRTjArlbAXiCdZp4u+tE9lRv1l59SMvfwY7+nrWBmiCptgL4VXhaWSArIo2o=
Received: from MW4PR04CA0241.namprd04.prod.outlook.com (2603:10b6:303:88::6)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 19:32:26 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::9f) by MW4PR04CA0241.outlook.office365.com
 (2603:10b6:303:88::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28 via Frontend
 Transport; Thu, 1 Jun 2023 19:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 19:32:25 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 14:32:24 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Add fence to the freed page table BOs
Date: Thu, 1 Jun 2023 15:31:17 -0400
Message-ID: <20230601193117.13143-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230601193117.13143-1-Philip.Yang@amd.com>
References: <20230601193117.13143-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffb8aeb-100e-458e-32ce-08db62d6ee2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wb2YmFZJl5/q9Sa4SkK3zso4uIuurWJ9SUBOaMy0qVGiyuqnq1na1ot59kMsNdx/+khavan6AeCoIYqFKBtE8FQpWQM9d0ypkONV3CPuAO6tfwTlv5vSY9Hv1NuhKfBFXN2qS/xVgoXt3HzOpwj3ygOitmYhXzD6XCXoKzsTnkE3OLwOKm9ufIkrZCfmsGLt5sFmdiv2gtl3hH9JJ0ocQ9Vvjg3WLrjNkpydMAiHWlCzdZfLR5UVdHJaEVvWmFGJBIxOO4Aq+TIRpd9CiU0VvO5SdTkF2pW9KcsbBsCVBcLpbt1zKv3EwhuIzt18Soj2USKe+rwYP3DsLgd3bO3cGaf9G+rA3tIBIkW0RaQStdrleK9HRQlHbseT0drzAPrZ/7Be5e/ZjJpuTTVVl/TMugg07nM+vt+ZG7HFpfE7m2owSj49DkLuvH6VvbCDGGlfYadHx0vYIUU9C+k+xkqRvrqiSRC4f5TbLKAK7UPy4bKVDvclWM0sqEWzqOJJoyky1jiXC5hTb2IZ9r76MBeGBuN1ukm90yNqw9jxSFCrzgB6yvsynWIeMhCZpI9nrLhGNX5G1fbNhzm59HNZ8GyvHs4yhmczx7gSuKzL5Vq1Gn5suCNJ1eD0Wo5TLEU5nqBMcB6QaDCb2usn3FRMOBcr8vHUgj4oI4Sw2ntOC4qxC/XoSC9Jg1BbyiEWfK0CzncVWvthSWmkT5ObuqDmpwF5afnDb6Rund6HydnXtGYPciKVg13GffGHy6ki/uwzYuDOZTjAnl9e/qFllZmKXxj9xQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(186003)(426003)(336012)(36756003)(4326008)(81166007)(70206006)(47076005)(6916009)(16526019)(70586007)(356005)(82740400003)(83380400001)(86362001)(36860700001)(2616005)(1076003)(2906002)(41300700001)(26005)(8936002)(40460700003)(82310400005)(5660300002)(7696005)(478600001)(6666004)(316002)(40480700001)(8676002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:32:25.9982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffb8aeb-100e-458e-32ce-08db62d6ee2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If updating page table free the page table BOs, add fence to the BOs to
ensure the page table BOs are not freed and reused before TLB is
flushed.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 33 +++++++++++++++--------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index dea1a64be44d..16eb9472d469 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -633,8 +633,10 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
  * amdgpu_vm_pt_free - free one PD/PT
  *
  * @entry: PDE to free
+ * @fence: fence added the freed page table BO
  */
-static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
+static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry,
+			      struct dma_fence *fence)
 {
 	struct amdgpu_bo *shadow;
 
@@ -643,6 +645,9 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	shadow = amdgpu_bo_shadowed(entry->bo);
 	if (shadow) {
 		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
+		if (fence && !dma_resv_reserve_fences(shadow->tbo.base.resv, 1))
+			dma_resv_add_fence(shadow->tbo.base.resv, fence,
+					   DMA_RESV_USAGE_BOOKKEEP);
 		amdgpu_bo_unref(&shadow);
 	}
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
@@ -651,6 +656,9 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	spin_lock(&entry->vm->status_lock);
 	list_del(&entry->vm_status);
 	spin_unlock(&entry->vm->status_lock);
+	if (fence && !dma_resv_reserve_fences(entry->bo->tbo.base.resv, 1))
+		dma_resv_add_fence(entry->bo->tbo.base.resv, fence,
+				   DMA_RESV_USAGE_BOOKKEEP);
 	amdgpu_bo_unref(&entry->bo);
 }
 
@@ -670,7 +678,7 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
 	amdgpu_bo_reserve(vm->root.bo, true);
 
 	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
-		amdgpu_vm_pt_free(entry);
+		amdgpu_vm_pt_free(entry, NULL);
 
 	amdgpu_bo_unreserve(vm->root.bo);
 }
@@ -682,13 +690,15 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
  * @vm: amdgpu vm structure
  * @start: optional cursor where to start freeing PDs/PTs
  * @unlocked: vm resv unlock status
+ * @fence: page table fence added to the freed BOs
  *
  * Free the page directory or page table level and all sub levels.
  */
 static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm,
 				  struct amdgpu_vm_pt_cursor *start,
-				  bool unlocked)
+				  bool unlocked,
+				  struct dma_fence *fence)
 {
 	struct amdgpu_vm_pt_cursor cursor;
 	struct amdgpu_vm_bo_base *entry;
@@ -706,10 +716,10 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 	}
 
 	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
-		amdgpu_vm_pt_free(entry);
+		amdgpu_vm_pt_free(entry, fence);
 
 	if (start)
-		amdgpu_vm_pt_free(start->entry);
+		amdgpu_vm_pt_free(start->entry, fence);
 }
 
 /**
@@ -721,7 +731,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
+	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false, NULL);
 }
 
 /**
@@ -905,6 +915,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 	struct amdgpu_device *adev = params->adev;
 	struct amdgpu_vm_pt_cursor cursor;
 	uint64_t frag_start = start, frag_end;
+	struct amdgpu_vm *vm = params->vm;
 	unsigned int frag;
 	int r;
 
@@ -913,7 +924,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			       &frag_end);
 
 	/* walk over the address space and update the PTs */
-	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
+	amdgpu_vm_pt_start(adev, vm, start, &cursor);
 	while (cursor.pfn < end) {
 		unsigned int shift, parent_shift, mask;
 		uint64_t incr, entry_end, pe_start;
@@ -923,7 +934,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			/* make sure that the page tables covering the
 			 * address range are actually allocated
 			 */
-			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
+			r = amdgpu_vm_pt_alloc(params->adev, vm,
 					       &cursor, params->immediate);
 			if (r)
 				return r;
@@ -986,7 +997,6 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		entry_end = min(entry_end, end);
 
 		do {
-			struct amdgpu_vm *vm = params->vm;
 			uint64_t upd_end = min(entry_end, frag_end);
 			unsigned int nptes = (upd_end - frag_start) >> shift;
 			uint64_t upd_flags = flags | AMDGPU_PTE_FRAG(frag);
@@ -1029,9 +1039,10 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 				/* Make sure previous mapping is freed */
 				if (cursor.entry->bo) {
 					params->table_freed = true;
-					amdgpu_vm_pt_free_dfs(adev, params->vm,
+					amdgpu_vm_pt_free_dfs(adev, vm,
 							      &cursor,
-							      params->unlocked);
+							      params->unlocked,
+							      vm->pt_fence);
 				}
 				amdgpu_vm_pt_next(adev, &cursor);
 			}
-- 
2.35.1

