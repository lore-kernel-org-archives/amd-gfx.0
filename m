Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05644C88E50
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 15:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE7410F69B;
	Fri, 11 Sep 2026 15:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QAAbEXHH";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010060.outbound.protection.outlook.com
 [52.101.193.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A03210F69A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 15:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOsxQaMAJOkBK1zetnQ2ZzxjKxdai67l0qM0+hzLBEpldXnQnDihtXQF/Hn+xi3zQoyyg5vh7oTb7WwRj1V+z8yZwf5h5AZw1X0+cTaaltOwJC5Gdd7N1hpNBNcApgTdSW46S5GjPFw14wjZFA0PZgQPgqCCPALTks90mkLHEftmbHF0KYjDjTJpVa+aPMj8/v8BA6lj1ZPqfvb8aT+kzDiYpWFInNjiS7Ffa+ndTOZCelOz48pV79xHmiIieMIzfBVR4R0nVQ6lcBCEHpGzq285+vqNVmpc1FYLAtlk1Jsdh1U9PYJQR8cy0jYyZWrH4L/W8Y8JKXxArFemXqB3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7t0JWBsadNL8+KwKO//ywBgkx2E63yprSwYN4XE978=;
 b=HaTzvoBdw1iedmIqTR7ivMXeJWDWiwJsnPegn1Va/YfD0OKCEAar58W1d6cqPWbAbvyB1f0IfcqhZScucvuEUoDipYm+iAY0CQYYHNVTSpiGBoWisDPXBvohWMvT3q7UGad+wqaBjkC7MJVB/w56sQJP4I0ozDCAFJHrSZtwJD5A/etJhuihZNfYfkB8tSdNaiVTSwexKZSGJS97Hld7R5F1rvintb12PcmT4Vh7pkEdjcNaLh7gvBEkpKTtYwNxd3B54Bj6gdgaj0DOR/EgiZymZxT3Duiyzkf4DhZH2m8ZA0EEyNEMLcJs+p1+XgDbns78KPSHsFfAU5zN+1QOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7t0JWBsadNL8+KwKO//ywBgkx2E63yprSwYN4XE978=;
 b=QAAbEXHHHcNp8yzaIwZ8GHa03xosVpS6uE1GWAgPN2WYHY0JmVi5hK53bexh1bUsQQmS/5qbKEwtvbnoyfMc/DhpW7Rl7LJJTRJUbZR32/hJ1Cru6EOV6NUXA3Au1YW2kmwabkie4ypXOrlXh/EOStkNV7bW3kdDt2fUKO+e+Gs=
Received: from CH2PR07CA0064.namprd07.prod.outlook.com (2603:10b6:610:5b::38)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 15:42:24 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::6e) by CH2PR07CA0064.outlook.office365.com
 (2603:10b6:610:5b::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 15:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 15:42:23 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 10:42:22 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: use pm_runtime_resume_and_get
 amdgpu_gem_create_ioctl
Date: Fri, 11 Sep 2026 11:42:04 -0400
Message-ID: <20260911154212.591213-2-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911154212.591213-1-shahyan.soltani@amd.com>
References: <20260911154212.591213-1-shahyan.soltani@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5aa035-4dc9-4bfa-786f-08df101b4623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: E9c2jGPhc+OrK5TlaxgDNrWxza02WE1Zls0gNaQHcjFzbKBSUj58AI3rqtj/2R+I7F/l0gF3TtFsv4Qa9+DV/TFoLliI+Qyy+6QVWj56amg5lPf/6OcYQbJ6QqW1qJOfCPeVUSvjxrUGtKi/KA7FdKFcwqqH2b/ir3vL52/aNc+gspaiqduPMYb19bsvMeN8mEwR617ekPXfE5KDqmH5KF5HTVUhBaZIr0EnuQvkRlsPGF2UAFT8bVyGxF/1CsIV25YsrMJtcN2NxlERk+5DrF9f5mTVb559M4kkIbgQNr1CA982ky9JcjCCRFGPcthiEY0FDlWgzyDlqiQu2ypw5vkjW1YmiaNzpZnstLdE3hNdoXMsLfpCukV5A5WpQv6VBaLywVKBJOVL+wwW6bzwrNkvWIJ0Lanr1vmUyBWJs3+jR/+48O6vJ+T5JULkQkngepUlYAMcyUVd2yy+qFS6ZFZ53wKDzkbywtjTj5vEGl5uHRi3rC64BnDXJl4cHngzimoQSOIGJjxr7eeKXK4XQYAN51jgpDWWo24tU55aEyc7Me8cDLiJSmHSv/HgXxR478SZ2X2WQBVULzNV/m9C7y9hdGtztcmwAdreVeE095taAAAOgt7cCm2v4k4r4umPnu20t0Jc77J2+0A09vwjhtFFoVBhj8BQ+xTn7hdCrnqYnxt6q4EraoaZItQT6BLwL7JYG8fFWW/UggUmck9Gpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pDdg/Jz5pvVJnSdLSN23ECxPK9crWt/u1NlWSf4oT0YG1tq6Cbe5pz0eVkXzg6qahm1YBmehI9DJ86y8SBr2Q1ndtV1uucqwslQGSO9I/gCCcau8ttknNDKp5eXCev3GA8Jof3HDwMh1Es2T1E8CWuMzNiJFgnZkKJyfADM4NStoRrqqYEDrUOlJjX6ueW4MXlPLE3qqqQf9scyNnmAyByFUUm/ooSbosgsek+/42Dr4/6J04bQXS6kqkNtI+BJGwRVinB93BIzn2nItQ1CuOY4CIme/ZH5+N3++fA/mTiAeNvoggmJRiMBHRAkMxlX9L30hqBs+Ufv3AS6yhwBOXItX+FPutTuNyeEuqNOZDm3Shhm6h2uRzOnqI6IOpPob/K2Pr6Qzse+3/vpLvEnz8T2I3F228+zg8V1kTGJfi475HM7rudxT168ZLYGb9LIb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 15:42:23.6341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5aa035-4dc9-4bfa-786f-08df101b4623
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

This ioctl might trigger GPU work through ttm so make sure the GPU
is awake.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
[shahyan.soltani@amd.com: Applied the same logic to
!amdgpu_gem_are_domains_valid(args->in.domains)]
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 43 ++++++++++++++++++-------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0d579517c03c..7b92e7b9fbb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -33,6 +33,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-unwrap.h>
 #include <linux/uaccess.h>
+#include <linux/pm_runtime.h>
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_drv.h>
@@ -442,19 +443,31 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle, initial_domain;
 	int r;
 
+	r = pm_runtime_resume_and_get(dev->dev);
+	if (r < 0)
+		return r;
+
 	/* reject invalid gem flags */
-	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK)
-		return -EINVAL;
+	if (flags & ~AMDGPU_GEM_CREATE_SETTABLE_MASK) {
+		r = -EINVAL;
+		goto pm_out;
+	}
 
 	/* reject invalid gem domains */
-	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
-		return -EINVAL;
-	if (!amdgpu_gem_are_domains_valid(args->in.domains))
-		return -EINVAL;
+	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK) {
+		r = -EINVAL;
+		goto pm_out;
+	}
+
+	if (!amdgpu_gem_are_domains_valid(args->in.domains)) {
+		r = -EINVAL;
+		goto pm_out;
+	}
 
 	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
 		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");
-		return -EINVAL;
+		r = -EINVAL;
+		goto pm_out;
 	}
 
 	/* always clear VRAM */
@@ -468,7 +481,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 			 * passed to bo list
 			 */
 			DRM_ERROR("GDS bo cannot be per-vm-bo\n");
-			return -EINVAL;
+			r = -EINVAL;
+			goto pm_out;
 		}
 		flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	}
@@ -476,7 +490,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
 		r = amdgpu_bo_reserve(vm->root.bo, false);
 		if (r)
-			return r;
+			goto pm_out;
 
 		resv = vm->root.bo->tbo.base.resv;
 	}
@@ -509,17 +523,22 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 		amdgpu_bo_unreserve(vm->root.bo);
 	}
 	if (r)
-		return r;
+		goto pm_out;
 
 	r = drm_gem_handle_create(filp, gobj, &handle);
 	/* drop reference from allocate - handle holds it now */
 	drm_gem_object_put(gobj);
 	if (r)
-		return r;
+		goto pm_out;
 
+	r = 0;
 	memset(args, 0, sizeof(*args));
 	args->out.handle = handle;
-	return 0;
+
+pm_out:
+	pm_runtime_put_autosuspend(dev->dev);
+
+	return r;
 }
 
 int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
-- 
2.55.0

