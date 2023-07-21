Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279E8EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 08:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B2B10E637;
	Fri, 21 Jul 2023 08:37:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DA1010E637
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 08:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMhn2nO/KvDzpQrHlaFigVDvLLckZ+HVBtOz4ps882cmH/u6y3uFY6GB9K1hSeydonYqmZD2hJN3sNJMaevDzLai32LlrvwTNN+7n/BydFGVKA8dhly9r1wD8TfVCc9H23V7rPSkhbAEjb7ZnV1CTRN0a/V40f5QjafBJkXSG6GrkbdOz+uih5AsnLGle5cm4UhtejmkgriLt+RzwMOC1M713kaU+6h3xqEfRbUtViXelGwNX2yVsS5K8UWDci3fRudPVxWOWOz3pKKbknydbpYozybRD+ilcK6l+3MgrRRPU9bWX5aZvjZNcs8lv8bIqoJ/uunvePNF92ZMZqaJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr7KnruRt58RUi9MpE1injKVyEWQxIRxUHMqHx06PgQ=;
 b=QRn4iN/isbV82XJ+wMgeGjx8qun2JlkUphPPpGZuiPLGY+ETjDcIrc69tgenIi6T9qB/+mv2e/u2YcO0opGk1OqBx0htogMIlW8rIDv1mN2a8WuDpqNzx5WNiQPvuapFGhyzcULja8P45B898tjIOU2vIGTDCLfEAn5uBqRpT2tw72mVqVt2wJA6TFmrz3Tr0XJmrEES0Glw8Y6tG9qCRIjXol0jFQ/T39eV4NLSCUR97hci3N82ne0oKyXc/9cZc9IHmTdyzzsitZN3Cr93xEXG3x7I73gIRentlEAgYQ2pW5mS3SGRjjLbHGBEVoR27/TFNejjBZS5XgoNI88P7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr7KnruRt58RUi9MpE1injKVyEWQxIRxUHMqHx06PgQ=;
 b=KOe5+5RLvzsi8i8IN7UqPfJtY4wNeOqFx2EGqHLHug+RgQF2D3Zm/E/Nlj0zyHA1V3R3BTmAYtKBH8P9Pi64mVvNQKMQPijzsJWCuhzApr1zxhfayaZ+oRD8/9FQCk5M19Jjt9KHq/rtZtRoBEn7ZOcYiDB/emkKdCGUBJy9u+Q=
Received: from BYAPR08CA0026.namprd08.prod.outlook.com (2603:10b6:a03:100::39)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 08:37:15 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:100:cafe::ad) by BYAPR08CA0026.outlook.office365.com
 (2603:10b6:a03:100::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Fri, 21 Jul 2023 08:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 08:37:14 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 21 Jul
 2023 03:37:12 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix style issues in amdgpu_gem.c
Date: Fri, 21 Jul 2023 14:06:52 +0530
Message-ID: <20230721083652.1427903-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT028:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2ff125-85f8-4e8e-037e-08db89c5af3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Afi1Vn4cUQ6YVfwFLq/WlGDtLV3AtksQpHePnhAtl6JjIbNp9kruCyY57F2KjjmJVTb2Ge/hWG5Ek/Z5Vaak7pyVEOCm1c1wvU+ptRsdS9LtXQSomLCaoW9wwqn9XuCR7kKLQHmUA8WOFOdUr6R/Hb35AiLMWvIt8z6uLZ8aiRshpFliwqLa/WUOkSKGIkcMcIc0FDo+LiPu1WPyek5qW+UDcQTvOfiLCM/8hvFgntQeq4lyaMkNNhZYcXXDFZt6jnB/buBG2LNe6lq0lLs8hXJmdQuEKBYNT0i8XlyEUyMfhZ6YnKAYV3mhJimMychC1qKr+n0D82J2CxcmiiidyPLQAJUHXgoPKEqM12hm9DFDkTDwPZs2BtnhBdmt0yUE+w5ENDkN1iqbIYGYZ6ewyjbV/SEo4HGYK0T3RBquMlmpaY+/2OtodshwBSEwAhIBFRZZbf4i6m7voHMdjXltUMAXnqrWwNASDQdEbI5SJsccnKPz/pHgRLz8ENVYT5zkSUCD+cKoPkG2iU0PH4batFV2dQLtJl4Z2QfmF9RgFfxMyzyM5r8+ySltQyccTyBZWyzwUSt2G28s2F95x3guZ0tKh+wZz1dyTEx1yjVnPMSEyjLqFJlo2r+NkgsM3IiS0WfUES5eOaDxO29jyuqoGKeLFhQ/F9Gj7GnoHBozMrA8gDopEupjFvneJFPMFmvjaqu7q1fkn7kUUg4B8wiv9hFt/xZWyAU8PJrCeNJa044sTHNcF1XAThcgDReHyj24qFkFU7OAOVil7ux5PkYDqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(316002)(40460700003)(70206006)(70586007)(6636002)(4326008)(81166007)(356005)(6666004)(7696005)(40480700001)(86362001)(110136005)(54906003)(44832011)(478600001)(2906002)(82740400003)(36756003)(426003)(2616005)(41300700001)(66574015)(47076005)(5660300002)(8936002)(8676002)(186003)(336012)(1076003)(16526019)(26005)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 08:37:14.4071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2ff125-85f8-4e8e-037e-08db89c5af3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following to align to linux coding style:

WARNING: braces {} are not necessary for any arm of this statement
WARNING: Missing a blank line after declarations
ERROR: space prohibited before that close parenthesis ')'
WARNING: unnecessary whitespace before a quoted newline
WARNING: %LX is non-standard C, use %llX

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 38 ++++++++++++-------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 4f9de9a0e2ec..1718d7d75eaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -181,11 +181,10 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 		return r;
 
 	bo_va = amdgpu_vm_bo_find(vm, abo);
-	if (!bo_va) {
+	if (!bo_va)
 		bo_va = amdgpu_vm_bo_add(adev, vm, abo);
-	} else {
+	else
 		++bo_va->ref_count;
-	}
 	amdgpu_bo_unreserve(abo);
 	return 0;
 }
@@ -217,8 +216,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 
 	r = ttm_eu_reserve_buffers(&ticket, &list, false, &duplicates);
 	if (r) {
-		dev_err(adev->dev, "leaking bo va because "
-			"we fail to reserve bo (%ld)\n", r);
+		dev_err(adev->dev, "leaking bo va because we fail to reserve bo (%ld)\n",
+			r);
 		return;
 	}
 	bo_va = amdgpu_vm_bo_find(vm, bo);
@@ -238,8 +237,8 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 
 out_unlock:
 	if (unlikely(r < 0))
-		dev_err(adev->dev, "failed to clear page "
-			"tables on GEM object close (%ld)\n", r);
+		dev_err(adev->dev, "failed to clear page tables on GEM object close (%ld)\n",
+			r);
 	ttm_eu_backoff_reservation(&ticket, &list);
 }
 
@@ -463,9 +462,9 @@ int amdgpu_mode_dumb_mmap(struct drm_file *filp,
 	struct amdgpu_bo *robj;
 
 	gobj = drm_gem_object_lookup(filp, handle);
-	if (gobj == NULL) {
+	if (!gobj)
 		return -ENOENT;
-	}
+
 	robj = gem_to_amdgpu_bo(gobj);
 	if (amdgpu_ttm_tt_get_usermm(robj->tbo.ttm) ||
 	    (robj->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
@@ -482,6 +481,7 @@ int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
 {
 	union drm_amdgpu_gem_mmap *args = data;
 	uint32_t handle = args->in.handle;
+
 	memset(args, 0, sizeof(*args));
 	return amdgpu_mode_dumb_mmap(filp, dev, handle, &args->out.addr_ptr);
 }
@@ -508,7 +508,7 @@ unsigned long amdgpu_gem_timeout(uint64_t timeout_ns)
 
 	timeout_jiffies = nsecs_to_jiffies(ktime_to_ns(timeout));
 	/*  clamp timeout to avoid unsigned-> signed overflow */
-	if (timeout_jiffies > MAX_SCHEDULE_TIMEOUT )
+	if (timeout_jiffies > MAX_SCHEDULE_TIMEOUT)
 		return MAX_SCHEDULE_TIMEOUT - 1;
 
 	return timeout_jiffies;
@@ -526,9 +526,9 @@ int amdgpu_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
 	long ret;
 
 	gobj = drm_gem_object_lookup(filp, handle);
-	if (gobj == NULL) {
+	if (!gobj)
 		return -ENOENT;
-	}
+
 	robj = gem_to_amdgpu_bo(gobj);
 	ret = dma_resv_wait_timeout(robj->tbo.base.resv, DMA_RESV_USAGE_READ,
 				    true, timeout);
@@ -555,7 +555,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 	struct amdgpu_bo *robj;
 	int r = -1;
 
-	DRM_DEBUG("%d \n", args->handle);
+	DRM_DEBUG("%d\n", args->handle);
 	gobj = drm_gem_object_lookup(filp, args->handle);
 	if (gobj == NULL)
 		return -ENOENT;
@@ -685,7 +685,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 
 	if (args->va_address < AMDGPU_VA_RESERVED_SIZE) {
 		dev_dbg(dev->dev,
-			"va_address 0x%LX is in reserved area 0x%LX\n",
+			"va_address 0x%llx is in reserved area 0x%llx\n",
 			args->va_address, AMDGPU_VA_RESERVED_SIZE);
 		return -EINVAL;
 	}
@@ -693,7 +693,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	if (args->va_address >= AMDGPU_GMC_HOLE_START &&
 	    args->va_address < AMDGPU_GMC_HOLE_END) {
 		dev_dbg(dev->dev,
-			"va_address 0x%LX is in VA hole 0x%LX-0x%LX\n",
+			"va_address 0x%llx is in VA hole 0x%llx-0x%llx\n",
 			args->va_address, AMDGPU_GMC_HOLE_START,
 			AMDGPU_GMC_HOLE_END);
 		return -EINVAL;
@@ -813,9 +813,9 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	int r;
 
 	gobj = drm_gem_object_lookup(filp, args->handle);
-	if (gobj == NULL) {
+	if (!gobj)
 		return -ENOENT;
-	}
+
 	robj = gem_to_amdgpu_bo(gobj);
 
 	r = amdgpu_bo_reserve(robj, false);
@@ -941,9 +941,9 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 	r = drm_gem_handle_create(file_priv, gobj, &handle);
 	/* drop reference from allocate - handle holds it now */
 	drm_gem_object_put(gobj);
-	if (r) {
+	if (r)
 		return r;
-	}
+
 	args->handle = handle;
 	return 0;
 }
-- 
2.25.1

