Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DC0C54E90
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 09:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5C810E709;
	Wed, 21 May 2025 09:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uuseY81D";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BE910E705
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 09:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzFMdjt34o29AF8DSsPHZhEzlrc1pA4Oe4IQw1bwOETqPEmeTOhO4oJOyj31AkZZUXEuJr1aDUbRGwNXuDWzw0YtMPw498dXpY1ZfAc2q+vXGGHz65LZOCt+9BSQJ77K5HBBb9nEdIBs0wN3aLQHYJOSskWaBL6AgS/+VEkn81krEykeAuvpeN/TrtW1OQ+0kwzPEsNUcM4b/kcZvpemUJs8NGVR9K85IYjJ2EYkSud6m5t2QziVMv/BPeQGPJXCu3v52qFs/P9D8azs3+/aRUXvedx2cAi2x86Wq+XLO6UeNXeXoNZx3rNzwGUgy+8/ZRMPWOC7b4J3T2mSDjh6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qeqxn4dTwEv+C5n6pg/T9JSB/jGg3ntMIPtZxVrp0Eg=;
 b=cro0vjLWsneS0JNhrgQZHu7VHC+owcnf+jp+OkeHlhN6gAtngar213g4/rwy62L95800sFMMQdZma7qQFfgk1cTKXZUiPbEteGh2IHWDATvLBTsHiYrHCEzoFOFAeqcBYbOo0wQ5AM7IvkxHUIahS3XFslDS0vsnHOmg+cc7oNLSr3nq4H/VZ0K3AFM1UQ/Qp4e+RkaRlYABmk10FqwZ9uUGLjwPr4QOuSI8o2m2SPvYHhq0IfgSYW/Rf/RVNK5BdQgkY+0RAnOdF2sjgsvL5Ety0sv9LVpd34NoqU7omyL8JQYaW945r+VQ0jACJwwssz5ZjhqBrR8kDgEdm7UhZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qeqxn4dTwEv+C5n6pg/T9JSB/jGg3ntMIPtZxVrp0Eg=;
 b=uuseY81D6IxXcP5wfB/YnWYqqaEa0ayOFX8jnFbYydKdlk2R4hkXnhuU5gSR+ovZv6fqeiJ0r4kgVpLZJt0V68z3ZIXI7VC0Zns4Mhi3K0MKh2wmoqutsAjg+rdWrJULqiEXTM5BSU2MSjudb2bUTdydWdog8824Bi0L8NwwRNo=
Received: from BL0PR0102CA0038.prod.exchangelabs.com (2603:10b6:208:25::15) by
 DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.26; Wed, 21 May 2025 09:51:09 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::6e) by BL0PR0102CA0038.outlook.office365.com
 (2603:10b6:208:25::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 21 May 2025 09:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 09:51:08 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 04:51:05 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 6/7] drm/amdgpu: add VA ranges to amdgpu_bo_print_info
 output
Date: Wed, 21 May 2025 11:49:08 +0200
Message-ID: <20250521094912.6714-6-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
References: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e95993-9270-4a32-41de-08dd984d0327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?scr+qfBKRJaf2FZgfWs/BhLIKftWPXG2/TG00svTRWa8ItwxdAOkAh4n9sWP?=
 =?us-ascii?Q?qsBG38ibkbPDGltZasxjCFhAqz0hhTEaUumdWKqocDVYW71KlYDImWdHRL8l?=
 =?us-ascii?Q?Q7PdmZ68PtfedGAua0CjGvJugOeZAc4I+xWU/lOraHVGDB8mEudLefaN2+4s?=
 =?us-ascii?Q?mveAKyIaY3HGwj0G2K/49+exFog1VnZHzi3wM0aUEY6cO/ikhUp4MwNthCN0?=
 =?us-ascii?Q?ly3yadtUfUwByfESpKxvhPU1RP+EgN4Jxp7Ls6JJt7GRAgU9eKyAm0EgKW8k?=
 =?us-ascii?Q?OaVeNQB14NLZ6X6axt9gYWrI3ILOH59cTXdOALzxN1P4myqfBpeUEptxHkzD?=
 =?us-ascii?Q?gxIkOmjM7aXXF3WpxkULZZgx6guCK/lV2ArfpPKQE6bxSx86BB+PX95alFaB?=
 =?us-ascii?Q?Wd7AYTr5vA/sui7nDYObgBZgpJl5+tVjfXCjx03y30g2NLjQwF5rMJD6ujxv?=
 =?us-ascii?Q?DkEqwQkBClYDE6FUimzqfZ6HgaoszOWvAKY/QNoFcYAzyo/Thn0Xkf+DoYvu?=
 =?us-ascii?Q?M67+P+nN6AdJ0TobdAagmRamwkfdXqdsqM51C6VLBykMpEq12s4gvF5j0N8s?=
 =?us-ascii?Q?smLoWBlYnVVjZ/OGoiElsVa38OeEiRWCAu1C0SCJWHJfWatsqRwpFfU/VqLb?=
 =?us-ascii?Q?soJRI5zfiKX6kArskiLsg7v9mF1QTdXdJAaS66qmIAhjrznTdj+aaAXj8+JX?=
 =?us-ascii?Q?7eoWXcZvzZhJRdoiN7qE2AJtP11gmlv2DorzfFu0CPJy6UyaQGQp7dcA6I8j?=
 =?us-ascii?Q?plxAtYdT3ms55s4S2uE/Ern0uhQzED3Deu+hYmP6IAe1rbNGqsdJ3GxG8Lpy?=
 =?us-ascii?Q?gK1AwcdmXQBo8ZdrVd0rk1QjLKS1OplhTsjyrScg4zU1nowxzYukwc0n0kBU?=
 =?us-ascii?Q?IgOrno268usmccw4n2bhdbMNnXFY+kEsxinFl35gA9CfuSBQmuiQxUu/3kLB?=
 =?us-ascii?Q?DXVJXF0HtTqM2Pr7qtIY1HVrvNT3zqO2BHKBn/GmQJ7mcP8ouA0aTRkOETNC?=
 =?us-ascii?Q?7mByH3e6TZL31H7E4oz8x60Njd8iX/4F+uaRV1dGKRuNOFwbzAZ3+wPqXQAz?=
 =?us-ascii?Q?opmOYjxBfwLS/fDTSKjcvBBEaI7jnNeFyNbiTwA8uCAS3CiJ4HM0iVUzH9bk?=
 =?us-ascii?Q?lgzx4qtnJubAKWPYk3qrdih2Pw0RMQlNfih5g7rIGLdOe6vHxH+m+vlwoUI+?=
 =?us-ascii?Q?B3WElLXY4IrGbwYNy/GXWnCGXIX1Gdq8wXjyRvcKeFUJHmzUkmgA8+uDqpCN?=
 =?us-ascii?Q?N2DAQoUzKWDM60N/YMj7g3Gjx6ODJIkhIsuHD+lMy4hcY8A2LhdHR7mE7joG?=
 =?us-ascii?Q?+jU24LHtFMFmyyfJHMZzi5W0XOMThLrroKdtzzDwQYfgZZRA6D7gRiHFX1dr?=
 =?us-ascii?Q?bLhjXNXyuUBXA0iNdLdMWOFh8RPyjNybvt4IrcgdmwtXnYHCexBAigbihyXq?=
 =?us-ascii?Q?Mi5wWVOUvA+1BzELgvTe2zev8/6/U56JZVNv3dJFw589az6dgfdwHjERBOv+?=
 =?us-ascii?Q?R3YiI/4wIWtb1GxWtqtR9JfqtWRG5H0ifrqF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:51:08.8795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e95993-9270-4a32-41de-08dd984d0327
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656
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

This information is useful when investigating page faults.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 25 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 12 +++++------
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 35457f44a089..e8ae93cc2cc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1173,7 +1173,7 @@ static int amdgpu_debugfs_gem_info_show(struct seq_file *m, void *unused)
 		idr_for_each_entry(&file->object_idr, gobj, id) {
 			struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
 
-			amdgpu_bo_print_info(id, bo, &p);
+			amdgpu_bo_print_info(id, bo, NULL, &p);
 		}
 		spin_unlock(&file->table_lock);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 568c2cd95703..fb581cd38998 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1565,6 +1565,7 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
  *
  * @id: Index or Id of the BO
  * @bo: Requested BO for printing info
+ * @bo_va: optional VA allocations for the BO
  * @p: drm_printer to use
  *
  * Print BO information in debugfs file
@@ -1572,7 +1573,8 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
  * Returns:
  * Size of the BO in bytes.
  */
-u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct drm_printer *p)
+u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct amdgpu_bo_va *bo_va,
+			 struct drm_printer *p)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_buf_attachment *attachment;
@@ -1645,6 +1647,27 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct drm_printer *p)
 	amdgpu_bo_print_flag(p, bo, VM_ALWAYS_VALID);
 	amdgpu_bo_print_flag(p, bo, EXPLICIT_SYNC);
 
+	if (dma_resv_trylock(bo->tbo.base.resv)) {
+		if (bo_va) {
+			struct amdgpu_bo_va_mapping *mapping;
+
+			drm_puts(p, " VA:[ ");
+			list_for_each_entry(mapping, &bo_va->valids, list) {
+				drm_printf(p, "0x%llx-0x%llx ",
+					   mapping->start * AMDGPU_GPU_PAGE_SIZE,
+					   (mapping->last + 1) * AMDGPU_GPU_PAGE_SIZE - 1);
+			}
+			list_for_each_entry(mapping, &bo_va->invalids, list) {
+				drm_printf(p, "0x%llx-0x%llx! ",
+					   mapping->start * AMDGPU_GPU_PAGE_SIZE,
+					   (mapping->last + 1) * AMDGPU_GPU_PAGE_SIZE - 1);
+			}
+			drm_puts(p, "]");
+		}
+
+		dma_resv_unlock(bo->tbo.base.resv);
+	}
+
 	drm_puts(p, "\n");
 
 	return size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index f411a8c3199c..1eb78ebfced0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -348,7 +348,8 @@ void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
 void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
 					 struct seq_file *m);
 #endif
-u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct drm_printer *p);
+u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct amdgpu_bo_va *bo_va,
+			 struct drm_printer *p);
 
 void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 327ce9e883cc..7e9d26805f9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3020,7 +3020,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct drm_printer *p)
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
+		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, bo_va, p);
 	}
 	total_idle_objs = id;
 	id = 0;
@@ -3029,7 +3029,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct drm_printer *p)
 	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
+		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, bo_va, p);
 	}
 	total_evicted_objs = id;
 	id = 0;
@@ -3038,7 +3038,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct drm_printer *p)
 	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
+		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, bo_va, p);
 	}
 	total_relocated_objs = id;
 	id = 0;
@@ -3047,7 +3047,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct drm_printer *p)
 	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
+		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, bo_va, p);
 	}
 	total_moved_objs = id;
 	id = 0;
@@ -3056,7 +3056,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct drm_printer *p)
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, p);
+		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, bo_va, p);
 	}
 	total_invalidated_objs = id;
 	id = 0;
@@ -3065,7 +3065,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct drm_printer *p)
 	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
-		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, p);
+		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, bo_va, p);
 	}
 	spin_unlock(&vm->status_lock);
 	total_done_objs = id;
-- 
2.43.0

