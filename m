Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9966AE7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 18:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4145510E94B;
	Tue, 10 Dec 2024 18:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1GMtL1R0";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14EE710E94B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 18:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJwEnhtEhIui1u+6BfvslcsB2idwVNNaQCJ4/1dmRZhppZZN9tC6bHpQqNo2rWLF/owNNqNcJ0axuj7mD865zarA0hNcmdzIgtP0Z1xwyQMBAuxlb8GYho6xx/jA65z33FRI8fZA4Tu/TY3VQmzkqDSuUGRH1zLAOvwUGKCp5MH2ndJgqu0XVoe2OKibS15n5sJgK157W6WykhnR2uIUXt25dN4/d3IU6J60xisk0EPrBXqjKZEqGhOcLo49GQIoX6SNd3K4mjs+t8z1SoUtchPOkI5VH31DV1KLs22WCX5sXrfVWdLPpusiqrJoEWu/SOi+Y2DT9booqJh9WF0fMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jcH2x5Nfmk8R2UAXfCSwJmvm4bA967JqTEMIlFF1Ag=;
 b=qOckSQbYk61PYOcj9VxlzwjqSFeF6Bjl7xVU1IJrUY41kJ2/v2fGLiPyoB8XEs6mu3C7GWssfNl4EWCb1YLSHxEWli8ZwzMjDtYaG9fj556xEpgBRtkJ03PN+yOyBbW6UvWwjIfkdzh+VGTobWOJ5+yClsvyI++/1IvabO7x6OoOj1SaKkJzZu3KL7N2El0HkrtDi9A7i9wsbdYXns/e+3Rv6ISz+bKF3h6Q2lqrK0QRp5PCablt671r8UvLvLeNZLJLc7gDq7Pu7mCsCmVN0cVI1/nCH4BmEWsqZkeQFbKwDkAI27frqELeqsHShcl5t3okbIzs76+U4jq8K+Wrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jcH2x5Nfmk8R2UAXfCSwJmvm4bA967JqTEMIlFF1Ag=;
 b=1GMtL1R0e8ox6LEC1woBedmzUW+J9vhciWaz42T/jHARkOS2Wto9ccY3Y1JEOeJav9hhkyuPpsoKWysPkqrqvSUFgeb/ts3Uqr/OhIKTXqmW6gSNYL6aE3+kBOBTI+8QJPnlmURjPY9xZjU4jDtkKb4MGRGA4xXoUdWD2F4kgYE=
Received: from SJ0PR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:33f::35)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Tue, 10 Dec 2024 18:00:12 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::a9) by SJ0PR05CA0060.outlook.office365.com
 (2603:10b6:a03:33f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.10 via Frontend Transport; Tue,
 10 Dec 2024 18:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 18:00:12 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:00:06 -0600
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>
CC: <Alexander.Deucher@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v10 6/6] drm/amdgpu: track bo memory stats at runtime
Date: Tue, 10 Dec 2024 12:59:39 -0500
Message-ID: <20241210175939.2498-7-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210175939.2498-1-Yunxiang.Li@amd.com>
References: <20241210175939.2498-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc3423a-5690-4caf-2a6e-08dd19447e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pxIz6A/y+D8o4hMGH/0L7RarHONhdWgfAWjYRbEzK5VWkfYqnk26xw7KsTJ8?=
 =?us-ascii?Q?N3TTQ8AjurZJuSA5kh+RSOQqkQMJk/DOgKSIVgmRV+zrvtUOX6bUAgFxx5Uw?=
 =?us-ascii?Q?RXchaUkunR9k2Aiw5FuPR4RfLR1uZiJdBN2xryiYLZsL2A0/JHHzVex0nvS3?=
 =?us-ascii?Q?oyEFvEOSRXNrmXyHWgYarB6WIHRpwI4maWaEeAK4Aqn/TP4L9ZwXW/ld6tCi?=
 =?us-ascii?Q?RQ94/p97uB6jnC4/1TJPuV7JPTx67gHRsJ8BNHURZCs4Y18gcOB58ZM3PVn/?=
 =?us-ascii?Q?6Kzoj2vukws3zbrBndPR3+7oIiRTN/DV53vdZ/9QcpBmSSZlI13we6s6SVF4?=
 =?us-ascii?Q?thlWMUvCRjOB83XhV0ZcQcN7xlXk43JJ20FPg9r7NyGDCwJ2Wy9VZVippsL6?=
 =?us-ascii?Q?wIIywxeQXtOVekuwy6PcdBxge0iNL+fU1uHQsNk2UT6FVWYiDgOMb+ob/D4Z?=
 =?us-ascii?Q?MAJGYbCVrARSrXkoNh5Bi9OnjJO8sTjF+Ag33ZhbIpMXL75sbk1ON2uknh53?=
 =?us-ascii?Q?5cq5HyKN3k6zWCfFjpmN30XotiuwFKEJxOHVTH6leiZil/j2hJlLJh54mr7G?=
 =?us-ascii?Q?HfHrN6MWYb/iO3HahUNgRmj9IQ/vCZVJijkA9Zg8HwMB9jDHTUUOXArkrNTM?=
 =?us-ascii?Q?0JU8XhQbddG0tEnGcLCElHtrB3Reyauby4xKD8LkoCXKhThijhuTnijyokwW?=
 =?us-ascii?Q?KoMn2QJgX798NzpmQ06JP/lSvYLQTmv8RFi88nxLPSAuvkWuexxAof7re3CU?=
 =?us-ascii?Q?vfL4KotASZjAAVZc1p9JVdocZ5DhHsfRSR8xJZ83/DXEzF3YhFEaPCHZlSVy?=
 =?us-ascii?Q?hFHXP5x8rjWjrn6qHDrivsc2OqFtVfV77gCV8sBBtgoGKGDaVAKwMv6VXxzU?=
 =?us-ascii?Q?M9SVbc5mKl+oOqP19/ycqgg8IWKn3wxqlJbhIOLC1foaLtrnJXNydJg3cUrI?=
 =?us-ascii?Q?zFmDN/Fw/s3XVD3Jo0mIBkcD9upFwdV/LBlsUC9w29wtS+6ypa03VO2h/F+2?=
 =?us-ascii?Q?yE7PRHk/gSEoz4cXyjRWJK1WP7PTtTIttW+MBzrvOhxMw49wztKRFp3jH6Gd?=
 =?us-ascii?Q?AGL+JpiKCptAHed5pwka/0g713ce6hDoQqIE/Tt4K5IqRLVTRYimVKP1qFrz?=
 =?us-ascii?Q?xtXD+Jur03YxqOxwZv0jO+r0NgdejKHVhl3Ge4GYLkRQTsPHsCOLKaS38Ws2?=
 =?us-ascii?Q?ZavOiZRwqAxDCFuGGKlZ+T1l1g83wyWO0zxv0BeyQ/XtcBDKUpfDZSCbH9fu?=
 =?us-ascii?Q?xrgNRml0/kaHhZBPnaNkkVLvb8FiFsMRWVod3vaoMzuzevJYXEh3zNdnt4Mr?=
 =?us-ascii?Q?PgU5ngiohzc74FiIMXB21v3peWfd/jqhBPjiKlDq9yFKjNciie5mSnsAzLIi?=
 =?us-ascii?Q?dgCXm75Twx0FCttpD5rPRnroiLGBxQ+Bsrc4czSRoTYsxcqCWlJYxeonOQsf?=
 =?us-ascii?Q?Abf46ZQvVckTAsBWj/KVsY3HRlcJWP0n?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:00:12.1273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc3423a-5690-4caf-2a6e-08dd19447e41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

Before, every time fdinfo is queried we try to lock all the BOs in the
VM and calculate memory usage from scratch. This works okay if the
fdinfo is rarely read and the VMs don't have a ton of BOs. If either of
these conditions is not true, we get a massive performance hit.

In this new revision, we track the BOs as they change states. This way
when the fdinfo is queried we only need to take the status lock and copy
out the usage stats with minimal impact to the runtime performance. With
this new approach however, we would no longer be able to track active
buffers.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v10: Keep count of how many ways the buffer is shared so we don't update
the shared stats twice, in the future if buffers can get unshared within
their lifetime we can also use this count to undo the update. Add a
locked version of the normal stats helper so that when buffer moves we
don't drop the lock between the updates.

 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 110 +++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 192 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  23 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c  |   1 +
 8 files changed, 220 insertions(+), 139 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 7717e3e4f05b5..91d638098889d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -60,7 +60,7 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	struct amdgpu_fpriv *fpriv = file->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
 
-	struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST + 1] = { };
+	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
 	ktime_t usage[AMDGPU_HW_IP_NUM];
 	const char *pl_name[] = {
 		[TTM_PL_VRAM] = "vram",
@@ -72,15 +72,8 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 		[AMDGPU_PL_DOORBELL] = "doorbell",
 	};
 	unsigned int hw_ip, i;
-	int ret;
-
-	ret = amdgpu_bo_reserve(vm->root.bo, false);
-	if (ret)
-		return;
-
-	amdgpu_vm_get_memory(vm, stats, ARRAY_SIZE(stats));
-	amdgpu_bo_unreserve(vm->root.bo);
 
+	amdgpu_vm_get_memory(vm, stats);
 	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
 
 	/*
@@ -97,7 +90,6 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 
 		drm_print_memory_stats(p,
 				       &stats[i].drm,
-				       DRM_GEM_OBJECT_ACTIVE |
 				       DRM_GEM_OBJECT_RESIDENT |
 				       DRM_GEM_OBJECT_PURGEABLE,
 				       pl_name[i]);
@@ -115,9 +107,11 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
 		   stats[TTM_PL_VRAM].evicted/1024UL);
 	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
-		   stats[TTM_PL_VRAM].requested/1024UL);
+		   (stats[TTM_PL_VRAM].drm.shared +
+		    stats[TTM_PL_VRAM].drm.private) / 1024UL);
 	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
-		   stats[TTM_PL_TT].requested/1024UL);
+		   (stats[TTM_PL_TT].drm.shared +
+		    stats[TTM_PL_TT].drm.private) / 1024UL);
 
 	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
 		if (!usage[hw_ip])
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index fe7ae45500639..6e899130502f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -381,6 +381,12 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 	drm_exec_fini(&exec);
 }
 
+static void amdgpu_gem_object_shared(struct drm_gem_object *obj)
+{
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+	amdgpu_vm_bo_update_shared(bo);
+}
+
 static int amdgpu_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 {
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
@@ -407,6 +413,7 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.open = amdgpu_gem_object_open,
 	.close = amdgpu_gem_object_close,
 	.export = amdgpu_gem_prime_export,
+	.shared = amdgpu_gem_object_shared,
 	.vmap = drm_gem_ttm_vmap,
 	.vunmap = drm_gem_ttm_vunmap,
 	.mmap = amdgpu_gem_object_mmap,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 951b20e40fd35..96f4b8904e9a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1258,7 +1258,7 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 		return;
 
 	abo = ttm_to_amdgpu_bo(bo);
-	amdgpu_vm_bo_invalidate(abo, evict);
+	amdgpu_vm_bo_move(abo, new_mem, evict);
 
 	amdgpu_bo_kunmap(abo);
 
@@ -1271,75 +1271,6 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 			     old_mem ? old_mem->mem_type : -1);
 }
 
-void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
-			  struct amdgpu_mem_stats *stats,
-			  unsigned int sz)
-{
-	const unsigned int domain_to_pl[] = {
-		[ilog2(AMDGPU_GEM_DOMAIN_CPU)]	    = TTM_PL_SYSTEM,
-		[ilog2(AMDGPU_GEM_DOMAIN_GTT)]	    = TTM_PL_TT,
-		[ilog2(AMDGPU_GEM_DOMAIN_VRAM)]	    = TTM_PL_VRAM,
-		[ilog2(AMDGPU_GEM_DOMAIN_GDS)]	    = AMDGPU_PL_GDS,
-		[ilog2(AMDGPU_GEM_DOMAIN_GWS)]	    = AMDGPU_PL_GWS,
-		[ilog2(AMDGPU_GEM_DOMAIN_OA)]	    = AMDGPU_PL_OA,
-		[ilog2(AMDGPU_GEM_DOMAIN_DOORBELL)] = AMDGPU_PL_DOORBELL,
-	};
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	struct ttm_resource *res = bo->tbo.resource;
-	struct drm_gem_object *obj = &bo->tbo.base;
-	uint64_t size = amdgpu_bo_size(bo);
-	unsigned int type;
-
-	if (!res) {
-		/*
-		 * If no backing store use one of the preferred domain for basic
-		 * stats. We take the MSB since that should give a reasonable
-		 * view.
-		 */
-		BUILD_BUG_ON(TTM_PL_VRAM < TTM_PL_TT ||
-			     TTM_PL_VRAM < TTM_PL_SYSTEM);
-		type = fls(bo->preferred_domains & AMDGPU_GEM_DOMAIN_MASK);
-		if (!type)
-			return;
-		type--;
-		if (drm_WARN_ON_ONCE(&adev->ddev,
-				     type >= ARRAY_SIZE(domain_to_pl)))
-			return;
-		type = domain_to_pl[type];
-	} else {
-		type = res->mem_type;
-	}
-
-	if (drm_WARN_ON_ONCE(&adev->ddev, type >= sz))
-		return;
-
-	/* DRM stats common fields: */
-
-	if (drm_gem_object_is_shared_for_memory_stats(obj))
-		stats[type].drm.shared += size;
-	else
-		stats[type].drm.private += size;
-
-	if (res) {
-		stats[type].drm.resident += size;
-
-		if (!dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_BOOKKEEP))
-			stats[type].drm.active += size;
-		else if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
-			stats[type].drm.purgeable += size;
-	}
-
-	/* amdgpu specific stats: */
-
-	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
-		stats[TTM_PL_VRAM].requested += size;
-		if (type != TTM_PL_VRAM)
-			stats[TTM_PL_VRAM].evicted += size;
-	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
-		stats[TTM_PL_TT].requested += size;
-	}
-}
-
 /**
  * amdgpu_bo_release_notify - notification about a BO being released
  * @bo: pointer to a buffer object
@@ -1554,6 +1485,45 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
 	return amdgpu_gmc_sign_extend(offset);
 }
 
+/**
+ * amdgpu_bo_mem_stats_placement - bo placement for memory accounting
+ * @bo:	the buffer object we should look at
+ *
+ * BO can have multiple preferred placements, to avoid double counting we want
+ * to file it under a single placement for memory stats.
+ * Luckily, if we take the highest set bit in preferred_domains the result is
+ * quite sensible.
+ *
+ * Returns:
+ * Which of the placements should the BO be accounted under.
+ */
+uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo)
+{
+	uint32_t domain = bo->preferred_domains & AMDGPU_GEM_DOMAIN_MASK;
+
+	if (!domain)
+		return TTM_PL_SYSTEM;
+
+	switch (rounddown_pow_of_two(domain)) {
+	case AMDGPU_GEM_DOMAIN_CPU:
+		return TTM_PL_SYSTEM;
+	case AMDGPU_GEM_DOMAIN_GTT:
+		return TTM_PL_TT;
+	case AMDGPU_GEM_DOMAIN_VRAM:
+		return TTM_PL_VRAM;
+	case AMDGPU_GEM_DOMAIN_GDS:
+		return AMDGPU_PL_GDS;
+	case AMDGPU_GEM_DOMAIN_GWS:
+		return AMDGPU_PL_GWS;
+	case AMDGPU_GEM_DOMAIN_OA:
+		return AMDGPU_PL_OA;
+	case AMDGPU_GEM_DOMAIN_DOORBELL:
+		return AMDGPU_PL_DOORBELL;
+	default:
+		return TTM_PL_SYSTEM;
+	}
+}
+
 /**
  * amdgpu_bo_get_preferred_domain - get preferred domain
  * @adev: amdgpu device object
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index ce3314152d20f..bdc9a5bc4da46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -305,9 +305,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
-void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
-			  struct amdgpu_mem_stats *stats,
-			  unsigned int size);
+uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
 uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 					    uint32_t domain);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2852a6064c9ac..461fb8090ae04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -26,15 +26,15 @@
 
 #include <linux/dma-direction.h>
 #include <drm/gpu_scheduler.h>
+#include <drm/ttm/ttm_placement.h>
 #include "amdgpu_vram_mgr.h"
-#include "amdgpu.h"
 
 #define AMDGPU_PL_GDS		(TTM_PL_PRIV + 0)
 #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
 #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
 #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
-#define __AMDGPU_PL_LAST	(TTM_PL_PRIV + 4)
+#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 5)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 88173bd1f9a2c..955432d9f3e19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -36,6 +36,7 @@
 #include <drm/ttm/ttm_tt.h>
 #include <drm/drm_exec.h>
 #include "amdgpu.h"
+#include "amdgpu_vm.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gmc.h"
@@ -310,6 +311,88 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 	spin_unlock(&vm->status_lock);
 }
 
+/**
+ * amdgpu_vm_update_shared - when BO gets exported for sharing
+ * @base: base structure for tracking BO usage in a VM
+ *
+ * Takes the vm status_lock and updates the memory stat from private to shared.
+ */
+static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
+{
+	struct amdgpu_vm *vm = base->vm;
+	struct amdgpu_bo *bo = base->bo;
+	int64_t size = amdgpu_bo_size(bo);
+	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
+
+	spin_lock(&vm->status_lock);
+	if (base->share_count++ == 0) {
+		vm->stats[bo_memtype].drm.shared += size;
+		vm->stats[bo_memtype].drm.private -= size;
+	}
+	spin_unlock(&vm->status_lock);
+}
+
+/**
+ * amdgpu_vm_update_stats_locked - helper to update normal memory stat
+ * @base: base structure for tracking BO usage in a VM
+ * @res:  the ttm_resource to use for the purpose of accounting, may or may not
+ *        be bo->tbo.resource
+ * @sign: if we should add (+1) or subtract (-1) from the stat
+ *
+ * Caller need to have the vm status_lock held. Useful for when multiple update
+ * need to happen at the same time.
+ */
+static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *res, int sign)
+{
+	struct amdgpu_vm *vm = base->vm;
+	struct amdgpu_bo *bo = base->bo;
+	int64_t size = sign * amdgpu_bo_size(bo);
+	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
+	bool shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
+
+	/* For drm-total- and drm-shared-, BO are accounted by their preferred
+	 * placement, see also amdgpu_bo_mem_stats_placement.
+	 */
+	if (shared)
+		vm->stats[bo_memtype].drm.shared += size;
+	else
+		vm->stats[bo_memtype].drm.private += size;
+
+	if (res && res->mem_type < __AMDGPU_PL_NUM) {
+		uint32_t res_memtype = res->mem_type;
+
+		vm->stats[res_memtype].drm.resident += size;
+		/* BO only count as purgeable if it is resident,
+		 * since otherwise there's nothing to purge.
+		 */
+		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
+			vm->stats[res_memtype].drm.purgeable += size;
+		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
+			vm->stats[bo_memtype].evicted += size;
+	}
+}
+
+/**
+ * amdgpu_vm_update_stats - helper to update normal memory stat
+ * @base: base structure for tracking BO usage in a VM
+ * @res:  the ttm_resource to use for the purpose of accounting, may or may not
+ *        be bo->tbo.resource
+ * @sign: if we should add (+1) or subtract (-1) from the stat
+ *
+ * Takes the vm status_lock and updates the basic memory stat. If the buffer was
+ * exported amdgpu_vm_update_shared need to be called instead.
+ */
+void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *res, int sign)
+{
+	struct amdgpu_vm *vm = base->vm;
+
+	spin_lock(&vm->status_lock);
+	amdgpu_vm_update_stats_locked(base, res, sign);
+	spin_unlock(&vm->status_lock);
+}
+
 /**
  * amdgpu_vm_bo_base_init - Adds bo to the list of bos associated with the vm
  *
@@ -332,6 +415,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 		return;
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
+	amdgpu_vm_update_stats(base, bo->tbo.resource, +1);
 
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
@@ -1083,53 +1167,11 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
-static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
-				    struct amdgpu_mem_stats *stats,
-				    unsigned int size)
-{
-	struct amdgpu_vm *vm = bo_va->base.vm;
-	struct amdgpu_bo *bo = bo_va->base.bo;
-
-	if (!bo)
-		return;
-
-	/*
-	 * For now ignore BOs which are currently locked and potentially
-	 * changing their location.
-	 */
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
-	    !dma_resv_trylock(bo->tbo.base.resv))
-		return;
-
-	amdgpu_bo_get_memory(bo, stats, size);
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
-		dma_resv_unlock(bo->tbo.base.resv);
-}
-
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
-			  struct amdgpu_mem_stats *stats,
-			  unsigned int size)
+			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
 {
-	struct amdgpu_bo_va *bo_va, *tmp;
-
 	spin_lock(&vm->status_lock);
-	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
-
-	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats, size);
+	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
 	spin_unlock(&vm->status_lock);
 }
 
@@ -2076,6 +2118,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 			if (*base != &bo_va->base)
 				continue;
 
+			amdgpu_vm_update_stats(*base, bo->tbo.resource, -1);
 			*base = bo_va->base.next;
 			break;
 		}
@@ -2141,6 +2184,21 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
 	return true;
 }
 
+/**
+ * amdgpu_vm_bo_update_shared - called when bo gets shared
+ *
+ * @bo: amdgpu buffer object
+ *
+ * Update the per VM stats for all the vm
+ */
+void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
+{
+	struct amdgpu_vm_bo_base *bo_base;
+
+	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next)
+		amdgpu_vm_update_shared(bo_base);
+}
+
 /**
  * amdgpu_vm_bo_invalidate - mark the bo as invalid
  *
@@ -2174,6 +2232,32 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 	}
 }
 
+/**
+ * amdgpu_vm_bo_move - handle BO move
+ *
+ * @bo: amdgpu buffer object
+ * @new_mem: the new placement of the BO move
+ * @evicted: is the BO evicted
+ *
+ * Update the memory stats for the new placement and mark @bo as invalid.
+ */
+void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
+		       bool evicted)
+{
+	struct amdgpu_vm_bo_base *bo_base;
+
+	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
+		struct amdgpu_vm *vm = bo_base->vm;
+
+		spin_lock(&vm->status_lock);
+		amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
+		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
+		spin_unlock(&vm->status_lock);
+	}
+
+	amdgpu_vm_bo_invalidate(bo, evicted);
+}
+
 /**
  * amdgpu_vm_get_block_size - calculate VM page table size as power of two
  *
@@ -2590,6 +2674,16 @@ void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	vm->is_compute_context = false;
 }
 
+static int amdgpu_vm_stats_is_zero(struct amdgpu_vm *vm)
+{
+	for (int i = 0; i < __AMDGPU_PL_NUM; ++i) {
+		if (!(drm_memory_stats_is_zero(&vm->stats[i].drm) &&
+		      vm->stats[i].evicted == 0))
+			return false;
+	}
+	return true;
+}
+
 /**
  * amdgpu_vm_fini - tear down a vm instance
  *
@@ -2613,7 +2707,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
-	amdgpu_vm_put_task_info(vm->task_info);
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
@@ -2661,6 +2754,15 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		}
 	}
 
+	if (!amdgpu_vm_stats_is_zero(vm)) {
+		struct amdgpu_task_info *ti = vm->task_info;
+
+		dev_warn(adev->dev,
+			 "VM memory stats for proc %s(%d) task %s(%d) is non-zero when fini\n",
+			 ti->process_name, ti->pid, ti->task_name, ti->tgid);
+	}
+
+	amdgpu_vm_put_task_info(vm->task_info);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 6a1b344e15e1b..46c068ff3d5f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -35,6 +35,7 @@
 #include "amdgpu_sync.h"
 #include "amdgpu_ring.h"
 #include "amdgpu_ids.h"
+#include "amdgpu_ttm.h"
 
 struct drm_exec;
 
@@ -202,9 +203,13 @@ struct amdgpu_vm_bo_base {
 	/* protected by bo being reserved */
 	struct amdgpu_vm_bo_base	*next;
 
-	/* protected by spinlock */
+	/* protected by vm status_lock */
 	struct list_head		vm_status;
 
+	/* number of ways this bo is shared (e.g. flink, dma-buf)
+	 * protected by vm status_lock */
+	char 				share_count;
+
 	/* protected by the BO being reserved */
 	bool				moved;
 };
@@ -324,10 +329,7 @@ struct amdgpu_vm_fault_info {
 struct amdgpu_mem_stats {
 	struct drm_memory_stats drm;
 
-	/* buffers that requested this placement */
-	uint64_t requested;
-	/* buffers that requested this placement
-	 * but are currently evicted */
+	/* buffers that requested this placement but are currently evicted */
 	uint64_t evicted;
 };
 
@@ -345,6 +347,9 @@ struct amdgpu_vm {
 	/* Lock to protect vm_bo add/del/move on all lists of vm */
 	spinlock_t		status_lock;
 
+	/* Memory statistics for this vm, protected by status_lock */
+	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
+
 	/* Per-VM and PT BOs who needs a validation */
 	struct list_head	evicted;
 
@@ -525,6 +530,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
 void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted);
+void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
+			    struct ttm_resource *new_res, int sign);
+void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo);
+void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
+		       bool evicted);
 uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr);
 struct amdgpu_bo_va *amdgpu_vm_bo_find(struct amdgpu_vm *vm,
 				       struct amdgpu_bo *bo);
@@ -575,8 +585,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
-			  struct amdgpu_mem_stats *stats,
-			  unsigned int size);
+			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM]);
 
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct amdgpu_bo_vm *vmbo, bool immediate);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index f78a0434a48fa..b0bf216821152 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -537,6 +537,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	if (!entry->bo)
 		return;
 
+	amdgpu_vm_update_stats(entry, entry->bo->tbo.resource, -1);
 	entry->bo->vm_bo = NULL;
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 
-- 
2.34.1

