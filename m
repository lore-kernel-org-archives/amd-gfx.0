Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AE2C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 14:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570FA10E1F6;
	Tue, 15 Sep 2026 14:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rcb7GF+L";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 396B910E1F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 14:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubCEzEDbqfr3kcqYsYu3AYpEYjS3yWofKWbPXrWFvV/5lTnTKGiDNPem69CSLybM9o/ZJWBdXEnx7XoqQuFjemhvJdTuubX5rJCItFo4G+KQTBB3L9sP0DSf3Bz6Dg0PHl8wguvx6kUQpvkD924V5DNadoOxTQ6gmHzHxCEKQVyKF53TZX5UHlipyFA7s+4H/LgZkGrs8PjatexfJTwJtnORLyoyZ7r685P4OaGWcgzPWtAvttNypBi+5do9Ab3XaxqyiTsnIOhVzOgMj0MBmJWM8ajKx49oaVGHWeBCwfZ+aAuCy+3kdVA/7IxUV3jJpJZ3PTJ5CfzDw74nnaiCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmVysf9G051PS8Li26/J8+kfabmTyvoyOoi6OZbvCsk=;
 b=KccEiUQgtzMlRe+ppat9bdPyq4qNXcFHEwatJsLY+R+LzpjzyLX92l7fYSFk0QoK1tNqHeI/75u7xbY6P4Eo70gIQelpmw8uQ1LthWMWEJLcWHz/r3h3r6uYVvBCFH6Dtn2tcbSTiRwVzPak+Y//4XchhHcMajeo4PHMlJLYol0NnVGWgtrnQ1HZpl5+Joxb02o0R+W1AVvUqEjKXC9QjhORZ+Qoqar1u2QtR9rwAK7oqe2IoyfdXJXpWaPMmGHjLrrzOJGZMKw86yipyWUlcNXqTCSujvGbntXu5bXre4Nx7qI01o1G9idfH+i5o/8KOYtdEEs9Mtf04AW+vcXHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmVysf9G051PS8Li26/J8+kfabmTyvoyOoi6OZbvCsk=;
 b=rcb7GF+LJ864IPQkQ/GfAECWnCY7BlnCXFQTeKGr0GX8bZjw8GXoGKmjwKDqbKFXRrxyM0qqy3qCyzrz6QtWgYKihzO0bb7n1UGhDaLmIIukFdZLVy57fePM/jDswr4Btb9Xw9wTrW4oEqhMDGgYdopWGw8gtEvB7PgU4a6UsEU=
Received: from MW4PR04CA0116.namprd04.prod.outlook.com (2603:10b6:303:83::31)
 by DS3PR12MB999218.namprd12.prod.outlook.com (2603:10b6:8:38e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Tue, 15 Sep
 2026 14:59:00 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::7e) by MW4PR04CA0116.outlook.office365.com
 (2603:10b6:303:83::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 14:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 14:58:59 +0000
Received: from galena-46d0-host.dal-spse (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 09:58:59 -0500
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <philip.yang@amd.com>, Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH] drm/amdkfd: don't widen the validate GPU set past one page
 owner
Date: Tue, 15 Sep 2026 14:58:33 +0000
Message-ID: <20260915145833.601947-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DS3PR12MB999218:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4a318c-070e-48e1-0120-08df1339dfd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|56012099006|10067099003|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: +S5RFxTjRhDnEywmZEThvQulln4VSRUAeWz1qbE2VNyAwph4qnT0RonmYQBc4HjhFqTJ+Eiy11zrRA7nYn99rSC0Ru1JkLwLcJqjv80iW0XrM3K+doWd6fK0nRMtwyHab3e8r9USGKWR7rBhZ3eo2VFfXgIiseFxrZJntGE1/GPKqbxf0QGBTR8sj1gD+1AtoX3d7Gl9fO0VoyEzPWj75TbJF3mm7uTrpUdg25WWWGDHTREh6ObKGNZoNavxT8ktvXwH/r1FVEEYpkUg6VbB8Pa58OKTRKMIvMtR+5LxA4j18g8Rgc36BXRUpXBEfsK4l3jaaI6jxPTZKcsx4hbQhC7RPoQCiaI0u1Vs2ydQi6KOPV+ce1+Cry8qxMIYg5lyaW9cCbWAKTIw0NJXZ7bZ+5dYaAVTYLViWjtsWbU7XT52RtMA5J/wrU3aWMSzK/X9ZgaKVxgYcMtu/KIA3E7nYt1P9EJTq5XXPj7XAiAWcbpC7xvXE6nyhL3VAczqKLX7UNLC5IClW2iPs6kU/hQxLaIjyNUexcQcnkFWRwZeUt4l3PvP6HDDdb1DHfyKs0FjZ292kGNbeIZegAhnyQ94el2KIfCeczAbJ4u7DWbvFv4mbWY2VpChWJ61r30TPeYIQtNysGLzYGH+CDb3ubiQ2XGvrXQr5d2tPmgo2E/ZCSuHjkZTI0UstHn3iXy/XNLUodg/BULEAovAZ+tQNulBqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sNtq5gtyz+o+rboh8YDCoObgq2Fy+OPvBZdjrs29sfpnylrvRqwBuB1b3D6s9crGeiTyxlyYwDCqNLTfea44sum2PMfKIwJilvNuIQudgLacm60zTWmBwUrN91c3k6QkOCD8PbW4x9zYKufOU0jIJdtJ+ufOHh8mVC8vlCKVydIxPcn8rv+9GVzksgzoTNcoiHlPAWz53j/vbrqj49s3FUvR4pO2q4TLtdD8kDp3qxKmQyFQrPBiaLD0GF71eO5G8lPncxXQ3PmbVVCFsO78RelYL8Zoi45Jj7lwlpIL12K/i7jqkY0KrRRafXHnrWl15QVom2IFh5Wf/zxlGkb0JApP4eAF4vuG+Y8n+7kLKHky2uF5j32qaa5KzPytlWdi0oWx58dxTm6KRLXtPIas1H+24zBiLBZYRFo6wKjsQStjoyR3c15xvi5rRngHY6gR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 14:58:59.8473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4a318c-070e-48e1-0120-08df1339dfd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999218
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

Commit 6b2969831f7e ("drm/amdkfd: Unmap svm range from GPU set to
no-access") made svm_range_validate_and_map() OR bitmap_access into
ctx->bitmap unconditionally for a range carrying
KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED.  Previously that only happened when
ctx->bitmap was still empty:

	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
		if (prange->mapped_to_gpu ||
		    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
			bitmap_copy(ctx->bitmap, prange->bitmap_access,
				    MAX_GPU_INSTANCE);
	}

The block just above already sets the bit for prange->actual_loc when the
range has been migrated to VRAM, so under the old code ctx->bitmap was
left holding that single GPU and the OR was skipped.  Without the guard
it now also picks up every other GPU with the ACCESS attribute.

That matters because ctx->bitmap is not only the set of GPUs to map.  It
also selects the HMM owner: owner is taken from the first set bit and
reset to NULL as soon as two set bits disagree.  On a two GPU system with
ACCESS on both, owner becomes NULL, and amdgpu_hmm_range_get_pages() then
no longer recognises the process's own device-private pages.  HMM calls
migrate_to_ram on each of them, svm_migrate_to_ram() sees
p->svms.faulting_task == current and returns 0 without migrating, and
hmm_range_fault() retries the same page forever.

Which GPUs disagree depends on the interconnect.  SVM_ADEV_PGMAP_OWNER()
is the XGMI hive when the device has one and the adev otherwise, so GPUs
sharing a hive also share an owner and never trip this.  It takes two or
more GPUs with ACCESS that are not in a common hive, which is why this
only shows up on multi-GPU machines with no XGMI link between the cards.

On a 2x Instinct MI350P (gfx950) this hangs

  HSA_XNACK=1 hipblaslt-test \
    --gtest_filter=aux_handle_test.set_sm_count_target_default_is_zero

The application never completes and burns 100% of a CPU in the kernel.
/proc/<pid>/stat shows utime frozen while stime climbs and minflt advances
at roughly 12 million faults per second, reaching billions; majflt stays
at 0 and the GPU sits at 0% busy.  perf on the stuck task is 24%
svm_migrate_to_ram, 23% __handle_mm_fault, 5% do_swap_page.  The process
cannot be killed and the machine has to be rebooted.

Restore the bitmap_empty() guard.  The rest of that commit is kept: the
bitmap_mapped tracking, bitmap_needs_unmap, mapping_done and the unmap of
ranges set to no-access are all unaffected, and bitmap_mapped is still
ORed in at the top of the branch, so a range already mapped on a GPU
still has its mapping updated there.

The instrumentation, the hardware testing and this changelog were done
with the assistance of an AI coding agent; the resulting change has been
reviewed by hand.

Fixes: 6b2969831f7e ("drm/amdkfd: Unmap svm range from GPU set to no-access")
Signed-off-by: Andrew Martin <andrew.martin@amd.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c521ec07bf3c..75e25f075da3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1758,9 +1758,14 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 		/*
 		 * If prange with always mapped flag, update mapping on GPUs with
-		 * ACCESS attribute
+		 * ACCESS attribute.  Only widen the set when nothing else has
+		 * selected a GPU: ctx->bitmap also picks the owner passed to
+		 * amdgpu_hmm_range_get_pages() below, and spanning GPUs with
+		 * different page owners forces that owner to NULL, which makes
+		 * HMM fault on the process's own migrated pages.
 		 */
-		if (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
+		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE) &&
+		    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
 			bitmap_or(ctx->bitmap, ctx->bitmap, prange->bitmap_access,
 				  MAX_GPU_INSTANCE);
 	} else {
-- 
2.43.0

