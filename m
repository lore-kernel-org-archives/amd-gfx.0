Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA15606A32A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=owCekvaE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE5B10E328;
	Mon,  9 Nov 2026 15:59:28 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B580C10E1CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 15:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JERBDuCGytP4T2IwznYNv77Fdnb40VA158AX+rhVaQ6icSZIWuJnFnyrF0P2VqFJT15GQBzQP3b8Wm3PpHTAYrD47kHc2deGGbe/jTzOfsRajje2cmc5FAUphMRczYO2LUB3RVomG5zj77E2kaZyRnChe7x4T/g4FBgDPsrpzhv6TjvPxrx66E6c8tx5Gx0q/nF6C/C78eSxjmlJj6KUABQVSu8YhwBQFkya9LeWauRY1l/zOikzQyL8J6MFw8GwoVNcvGg0UOOwRYgGI9AVc1XSs8FP1+ETZ/ECmjz7rG1bLlCQMq8tvwLRllqY6hA9RrpEt6YXm8n1FxvoowEwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSOT3opPPCAl7T/4tSWAJ4CjsXj6SO6f6z/T8U3xOrQ=;
 b=oeNjh68BocBGqsKk4rc1KGaUP+z4s0JY0PAD1N+oOfyt/hUPlVoxDV9MQS8ltVkDi+fBQm5CmB1klVu4t9V8yTsBKg9QSt1sD9yRzpiUl1OuFeMsZfwIEyeriGpfmglAU108U//k7RoEuAqmvCtzxIGa5g7H1/Ryow+GHqY0Hqx/9uZz4pcUYeq7UKNVlCLJpGVI+ywgKcGmPU8c3t/QhJGmNF5eREbhI2wOKiYuFvRRGiqaOoJy1e2VVzAsBCF/NOcyUbnNGpHVYBTUIf+XJnQkUcPLQPyRx7AQvM07fQ2PwgexZtKoroj6thzUoeBAo8ZtpaijNBU98leyPqOm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSOT3opPPCAl7T/4tSWAJ4CjsXj6SO6f6z/T8U3xOrQ=;
 b=owCekvaEHbs67kPxxfnPbMk8RiBISAkleqmkJIamAEFLIS7Tb+sx0vKWwtzYGbQSDInORHndc8taekmXBbrhtrkyrJnB1gx93i/Z9HEi8wzGNbFTfkK5+6q2bF/OkccOjmJBE6DesVTKVXefGBOBJ9TEmxsV2dFTE4aTAggj0ZU=
Received: from PH3PEPF000040AE.namprd05.prod.outlook.com (2603:10b6:518:1::59)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 9 Nov
 2026 15:59:18 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2a01:111:f403:c902::15) by PH3PEPF000040AE.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Mon, 9
 Nov 2026 15:59:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 15:59:17 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 9 Nov 2026 09:59:15 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix vm->stats leak from stale bo_memtype on
 preferred_domains change
Date: Mon, 9 Nov 2026 10:58:55 -0500
Message-ID: <20261109155855.20471-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109155855.20471-1-jinhuieric.huang@amd.com>
References: <20261109155855.20471-1-jinhuieric.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9d2be3-aa7f-43de-1e18-08df3e7a6927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|22082099003|10067099003|261102123227099003|18002099003|261022075727099003|261028144727099003|11063799006|56012099006|261021121427099003|261022105027099003|261009223027099003|261021123027099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 3lWm+sHh/iPPbBQ5lQXqqn/+xgnDuIPRe7k8R4mlA615iou4R8Ln6kSyUVGiqXryJKqvGMBjDgwYqmOLwEH5GZ9ijoy3RAuSiczL/CIgmKkoYWhYLZgprMMBNHKfwWVD9aH+MagN/6dhk8RYxf8uGt6WKmGWsOnrds7eViTSuYQkG8H0UOjndpx/d7eqPkFdfqmJ7p4t5k4UEHIN5JTK3+qIS5z5Nw4DGo93rosNEAFsRH6YHkZBaPi6TODTCIif024lVAnpp265diPes1XSCqO6rVsX7YlzqGgxSZZS/ngH3FVIJzlAb2csMsGPmR4WcH5fB/hUdbe6lYY02w+6CT/RWUBqd8YsT3biC//Tm5YJEjrf0AbtS4GzIW2nNOuLGM2tzNxUVAzb+gjt/iOnbwctFGX+mynRw53P2Hfehlp7B/MiKK5cpBr3AMaAXJD/t2YRWUydPhhb1WALdQ3ybPaY1tMC9LDJHmfQEN0R30TrVy9pgbeBPKKfN4Xdaa9eg86BcZXqvAKVZqwtgUnBJaRIOgINrhL9592sof/Vj5GRezsFrP0bHNJmnO1Xn0QPuHRwB491fn3dsDClgEPykS/QtlCp0ZBWaAOG44NcMDBZ1e6hlcZXnunHG9GLdFPk9Z2ulGZ2JfJwc7fd946z6FZC4lw3/UVjwv0fOA2fAJLc+iEoihNoMyliRaRod0XXrtAeHDGbDdIzXqxQ2bvr3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(22082099003)(10067099003)(261102123227099003)(18002099003)(261022075727099003)(261028144727099003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261021123027099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 34NoZDx5Pb0vce6Cb3sdLRTfs+cu8XozK8h1zMFuusV9JUGcchX//LAh3/HvWy0NqRm+K6LHdAC3f110u+zGocGd7fvIur6EnVheIcZIu9SO7tYjZ0szH4Ou1cvqzzWfpkQHVX/W5hP+9k6TFgri70TXTAgtAHEqFNlr8fFrVpCkMSJDQc0jOUvSZgsCJddNpr6Sqk68SAGHsG70T5+rDFVI/hgIfNkSApYhd8xWRxbFbTSXYvAUarV7n9opxjJO7tEJRCAp1rUIxlVkeVVAyDfelkbfE6YT5Hak5yQCkVJCdWsS+b6dyWQn7RJ3P2sSeXU4TOwIci123pvQvnt4cIAsIq0iMWfhrJni157qM3VXt0t65iH5oxsTixdEgP90ODm7PlQc4p7019of6+ZwieZKV1WTsZdgMXAGc8F7V2BF/F8rMRpHVSmHtXxPzg9b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 15:59:17.9733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9d2be3-aa7f-43de-1e18-08df3e7a6927
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_vm_update_stats_locked() recomputed the vm->stats[] bucket index
(bo_memtype) fresh from bo->preferred_domains on every call, for both
add and remove. bo->preferred_domains is a mutable property of the
shared amdgpu_bo, not of the individual amdgpu_vm_bo_base attachment,
so if it changes between when an attachment is added and when it is
later removed (e.g. amdgpu_amdkfd_gpuvm_pin_bo() pinning a BO into the
DOORBELL/MMIO_REMAP aperture after it was already attached as CPU),
the add credits one bucket and the matching remove debits a different
one. This permanently corrupts both buckets even though the aggregate
add/remove counts balance, and eventually trips the "VM memory stats
... is non-zero when fini" warning.

Cache the bucket on amdgpu_vm_bo_base at add time and reuse it on
removal instead of recomputing it, so an attachment's remove always
targets the same bucket its add credited. amdgpu_vm_bo_move()'s
remove-then-add pair for a relocated BO still works correctly: the
remove reuses the cache from the prior placement, and the add
recomputes and refreshes the cache for the new placement.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11 +++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 10 ++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 94b1cfe05e3e..45c25be72c6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -358,11 +358,18 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
 	struct amdgpu_vm *vm = base->vm;
 	struct amdgpu_bo *bo = base->bo;
 	int64_t size = sign * amdgpu_bo_size(bo);
-	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
+	uint32_t bo_memtype;
 
 	/* For drm-total- and drm-shared-, BO are accounted by their preferred
-	 * placement, see also amdgpu_bo_mem_stats_placement.
+	 * placement, see also amdgpu_bo_mem_stats_placement. Cache the bucket
+	 * on @base when adding so a later remove reuses the same bucket even
+	 * if bo->preferred_domains changed in the meantime, instead of
+	 * recomputing it and leaking vm->stats in two mismatched buckets.
 	 */
+	if (sign > 0)
+		base->bo_memtype = amdgpu_bo_mem_stats_placement(bo);
+	bo_memtype = base->bo_memtype;
+
 	if (base->shared)
 		vm->stats[bo_memtype].drm.shared += size;
 	else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 7a51ca284b99..e37fb238e3d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -221,6 +221,16 @@ struct amdgpu_vm_bo_base {
 	 * protected by vm BO being reserved */
 	bool				shared;
 
+	/* vm->stats[] bucket this base's size is currently counted under,
+	 * cached from bo->preferred_domains at the last amdgpu_vm_update_stats
+	 * add. bo->preferred_domains can change after a BO is attached (e.g.
+	 * KFD pinning a BO to the DOORBELL/MMIO aperture), so a later removal
+	 * must reuse this cached bucket instead of recomputing it, or the
+	 * add and the matching remove can land in different buckets and leak
+	 * vm->stats permanently.
+	 */
+	uint32_t			bo_memtype;
+
 	/* if the BO was moved and all mappings are invalid
 	 * protected by the BO being reserved */
 	bool				moved;
-- 
2.43.0

