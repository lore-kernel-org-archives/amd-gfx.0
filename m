Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F364CD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 10:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C879510E03C;
	Wed, 13 May 2026 10:47:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5OZZaL2J";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA09010E03C
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 10:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phE+ddl05ZSdlKTc9E+oOvmvWveXGIfnYPJgU1QugDPr1glrjGrb5aikH7FJBMDZP9Mf67JepIvzcJiENhDImkVRW436jSjEbDmLFZLfB/20yEO9FWZOLYGAwn+6JpxRKTJ7V9DLNHm97cXV/rmZrKjOcz8okJNBWJ9WE7yZhwp2Rwwo5B8X3D7LkD1paeNrbeQZrQok+h0ShYCsaeMHJam76uzmLF+4m68CTdSU4jtFChWSA6A+xIeo9Ty+gZiMD/L3rEbdDePbr9xX8ZzOknDufPaM90h13kn8HoR0C7wDLDcCvilQ9vW1QukSAc72ATvIxEKXfeIfv7Rhv+LOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSDjqtFMmI4Vi5KfJc3w1fOl2RKLtVUYT5SA2cLFmLQ=;
 b=QxxInCsKgDD8dGNDv4fIT5Lge3HjdfEJrNjiSlSZEUaXSYYzmnaysvHU3yNVc7vvVm6wguMimSzjj4lZRA0vKuPePL5n0QE/Ws9YFp6diwoSXlOWnSvMG7zzWxxNo6U7d7BocTI6qZ+DdbxHdyRvP4ft49N12nFKolHgX6XsXioXvtb3LMZzcZ8Z+PyVr457K3eg6n8cz64Ae7jLuOA84r90sCIsNqowBL7LLFg701lC1Ll+fJfQK2lYvL9i2fJuSSqgIPZI/6DMuMJxlUz5oQpL9I1NGY4kqg9NHkHS10rbFuTsJwZvYarD/rEQkvpJ4KpTE+gKb5TT6akDMJcqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSDjqtFMmI4Vi5KfJc3w1fOl2RKLtVUYT5SA2cLFmLQ=;
 b=5OZZaL2JgPEDRqY+RILawf7oYa6+R6cDgXG2jCZQMGUXnQC8bul9HqqQj503+8KkG1gf2oqJ4V9dmF1q6eihrokyIpYdDnKsofWvg2LF1Y7BQYFDiz+NZq83ed6Krt90fl5Gniq2/hMlM2UBFOCUvtFMTy1QniHUyfpw+91PRZQ=
Received: from BN9PR03CA0537.namprd03.prod.outlook.com (2603:10b6:408:131::32)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:47:24 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::54) by BN9PR03CA0537.outlook.office365.com
 (2603:10b6:408:131::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Wed,
 13 May 2026 10:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 10:47:23 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 05:47:21 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, David Rosca <david.rosca@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/userq: Fix reading timeline points in wait
 ioctl
Date: Wed, 13 May 2026 12:47:10 +0200
Message-ID: <20260513104710.9705-2-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 471c1504-85f0-4583-0af0-08deb0dd03e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: VQDt/B4IvXVW7I+BHEum1dkY/DxlqYEynmVO3f2sM6FJrwPQpOX+CEn6ZWBlFrCKPB3k4A1j78+vbvs0iNKzpe2a2sIPIOuBnp77o5zqReB81rL4dxhdXuvbSx53LGKkI5/bhqeC3jQ7feRrTsn4ofDfXNK6vNUEuVtxs6Gjo7K0GcYSsUr6fYyBv29u3cEgPGt999sUH2a4i7N3x51DrCBvHPw3lxcbTjSbDE/uK77CUVMLleOwu+6JVStZ0YDiIwREO3rmkuZxltvImU84zV351t+Ezone2CkgwirPWInVgJjlw/iOwEj+8WDm5L5mVl6vEjOTDx9gku+FzCkbZ1c9XGxDsDSVIq6BG8nWLEeUAC8hJouP4w/ym7o2d+ptQwu0o1cRfCK/7bq3Q7PPCHbeS1eSOMpW0Qa8gb1J2W/OztEqXBNstJvfg8t1WuZUg/y69AAwPVW8Isk8hNmpnWIIma8WZo7xN6FA7DI9Cy1ko79slW/L/BqaX9RL5bB3FucH67STovtGkE72k4UJhDE907pXGm7HiEafrsg6TduoE/tPZ+jygTVFfmWaFvFrqN0M69NkXP/WsCc75DKwgIhSsL1KD3k4nidEwU0nubeXl9QGyu71/8vzl1KUuBtFC9QgcTKTcJ7qBcfhf4AukXOuifN5jrAT1qg+gPrRtNWeyFkJBeP6Cz6y/mShNUmpbhvpeupco9gUGUUAwT+QGdLxhctUe8LGtF0kCeBwOTc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aecbclNWNzUJe/j1UffCv2qTWxryUzO/5mZpdHC1v9Ps4qkTuyB+i7lotRzePDxN2cYedwLFvr5ZWcvLg9l0qiPRssaBKCzctMko232TBpopwPiTleZtyvczgbGfpoMKh5xjf8v2xx30OA2BZULZZQ7kqgrPjD0cjJJtnlqgbjQoVeYDefOx3NfFyD5ql4Oag0Rdn+afaZI3XM0QZTvnzjwF60E3iMvDsm9HsX2Y1/ZFGSFmTEO4EkWhWYl/ORYJRgjath9L+qvxdu36j0kgtxvumwVW8V15tq+DDYl2AlgZoPsSu/lIFS9TVl/7AGgsW1RrjrJpFd+Ka1Nxx7EpliGagqV4jYO9Qwx1OrDnPpxqv1j0z/RBYn8UOZaqFUWVtcXKEz6071wNawImFxBp+mYKpqs8rxh5UoXwh/x+MvrLnyy0nh8h5D2WSmrrDUsA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:47:23.2053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471c1504-85f0-4583-0af0-08deb0dd03e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
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

Use correct u64 type.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 008330a0d852..c0d68863fa17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -593,7 +593,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 static int
 amdgpu_userq_wait_count_fences(struct drm_file *filp,
 			       struct drm_amdgpu_userq_wait *wait_info,
-			       u32 *syncobj_handles, u32 *timeline_points,
+			       u32 *syncobj_handles, u64 *timeline_points,
 			       u32 *timeline_handles,
 			       struct drm_gem_object **gobj_write,
 			       struct drm_gem_object **gobj_read)
@@ -703,7 +703,7 @@ amdgpu_userq_wait_add_fence(struct drm_amdgpu_userq_wait *wait_info,
 static int
 amdgpu_userq_wait_return_fence_info(struct drm_file *filp,
 				    struct drm_amdgpu_userq_wait *wait_info,
-				    u32 *syncobj_handles, u32 *timeline_points,
+				    u32 *syncobj_handles, u64 *timeline_points,
 				    u32 *timeline_handles,
 				    struct drm_gem_object **gobj_write,
 				    struct drm_gem_object **gobj_read)
@@ -906,7 +906,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
 	int num_points, num_syncobj, num_read_bo_handles, num_write_bo_handles;
-	u32 *syncobj_handles, *timeline_points, *timeline_handles;
+	u32 *syncobj_handles, *timeline_handles;
+	u64 *timeline_points;
 	struct drm_amdgpu_userq_wait *wait_info = data;
 	struct drm_gem_object **gobj_write;
 	struct drm_gem_object **gobj_read;
@@ -935,7 +936,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	}
 
 	ptr = u64_to_user_ptr(wait_info->syncobj_timeline_points);
-	timeline_points = memdup_array_user(ptr, num_points, sizeof(u32));
+	timeline_points = memdup_array_user(ptr, num_points, sizeof(u64));
 	if (IS_ERR(timeline_points)) {
 		r = PTR_ERR(timeline_points);
 		goto free_timeline_handles;
-- 
2.43.0

