Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E711CC433E3
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDA0221E4
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 11:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BZmRJIWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDA0221E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E006E89D;
	Thu,  6 Aug 2020 09:05:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432D76E89D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 09:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=objEgyao8cKJug/lFHa/ydtYjog6IyM84le253eNU+65QS2CyJDz6fTqOuaJ9Is8P8PXmBFO7NSdINwsPLMjONDRYCuigDW9t79cHgry/xKAO35ypLrPqTFWMnAacZbjaW0bzmH0fTIBiJ+BicwgXDFezw4GNchxV9fR9M38vlnds6CwMlrSOlfnMEMyCnHl0o51T4RoP7rJ7H+q0OxDDGsB40HsdkC3sfvgmoeZSTRg1p+dgzC46qp3zVvT3j4y4IDrWyJQFzinGvKaCnBEK40B6ZxaKk1PXn3mB2QK5gpUuifJzoOGrxhxMeMtIsVl/Xh1t8Wy6NmmF42aVz0WJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gx5X2U9Yn1xAOAexhsi30rP07fonwwl2nRrkB2zXNs=;
 b=be6bR8qQQkTDcpllKJ+aJ5z6qZe6CH+r98AM1fvh/iTMK8Gy6cOxnd5WCbheW/Q6oilbTjcTQUGJlqm+0PDf490HaF9QjNi4Nk/mmMUSUxkzb/uTpy7OcBM5djGTOuium9Ak+uuEZM4V50kAiYBIgXdi27cEojWG1M10mEWC8QrkSlx1ANGmYZrhbIguGeoulWlBkfBinevEStUT2GfNqCnKtpIS7/3tbouAg9DIBbEHuXKuMa2mk/YYMWeKUhhiUa1DPdlJtNE0azvLpJUv2cZKl4EMIXKKdlZIPSE3RdjGKT5jp4muB8/d7/Ai3oeKm0r8zX9nIE66/ylafCZuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gx5X2U9Yn1xAOAexhsi30rP07fonwwl2nRrkB2zXNs=;
 b=BZmRJIWEt2bV/JBktiHebRw/5J0dsRp4t2lza7N3Qn72CBV2geVxeep/NQ/n8tgDnAksWps6f3i1NsGAuc3Hg8JbLL6fqpsKxU5tnNr72wSpvwRL/vrXYY+qqOHfjP024tG9BMtk7RW6W5BTWPgP7DFJG3HZapJpqg6JtD7Gb6c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1311.namprd12.prod.outlook.com (2603:10b6:300:13::20)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Thu, 6 Aug
 2020 09:05:10 +0000
Received: from MWHPR12MB1311.namprd12.prod.outlook.com
 ([fe80::d515:bc2c:c60c:349a]) by MWHPR12MB1311.namprd12.prod.outlook.com
 ([fe80::d515:bc2c:c60c:349a%6]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 09:05:10 +0000
From: Arunpravin <apaneers@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Enable P2P dmabuf over XGMI
Date: Thu,  6 Aug 2020 14:34:33 +0530
Message-Id: <20200806090433.148129-1-apaneers@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MAXPR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::36) To MWHPR12MB1311.namprd12.prod.outlook.com
 (2603:10b6:300:13::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arun-MS-7C37.amd.com (165.204.156.251) by
 MAXPR01CA0118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18 via Frontend Transport; Thu, 6 Aug 2020 09:05:08 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e37b32a3-ea4e-4161-4667-08d839e7d242
X-MS-TrafficTypeDiagnostic: MW3PR12MB4426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB44261DA988C9D48302A31423E4480@MW3PR12MB4426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6im0VvF+wz6Gt8Sj+fIZ7XjxWZ/ZMjL3ZpRd8v1rj8aVpdG57xDLCKxAsRLawcwlQEdjp1vWScAWYbEnSf6SPzcXd3MesZJcuOy7aTPTk4X7NoahucO6X6rfqLDL0WPI6cQaxAYu7vyltn62X12G8t5nYzKA1S1MOMS7Lph8Rj5H0mmT9A3CSl/NH6gD1MSURtKKk4xoYY8pDETZ/ytXAjtZyWZV+JYVBkYpOGPekvoEzNAL3x67TOaerV0mGltJ3kvB0kcv62EORqtavTiuN1p65AKPU1eR8smc0ed7nl+3SubUssMaj4uNuiFsO4+r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(2906002)(6486002)(186003)(52116002)(316002)(6916009)(16526019)(26005)(478600001)(36756003)(66946007)(7696005)(2616005)(956004)(1076003)(66556008)(66476007)(6666004)(5660300002)(4326008)(8676002)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 046TT7DPNvQelpKkqhrPTPVTwXgS0o2xMHmruG8CtzIC0lkwYI+OaHXs43WeiqBDX4kxaetScj+1Xkr2l17rH6jUcWzQljUVxpzD8qjik/W15Go+X7s1JQ2bb44CCwSrNyKZEOyuKNxd0VNum8z4jWvOKdcBKrAniElRSrdbdt4Ffii/kFGUMtZd8WtzuZ4eJG7oIlRlJLzDwOzazoyGIxdgJX2r3HzUtuHymCNORUy1+9tv/QixT1bi/8daVJvqy0cIf34g+7oH0MYiUejLPc3mUFtnNvrpxPWoHRbJXO/Bij3cIXGQ7AMmJWryLfaHUd9LJCsugUNG9xG6x2aboT/fyOWVYL+i29zOiQ9WWavYq5apeI4perShKHWKuEwmQ9CqTVfnhnk+ezgs5HIyg/UHDXQC1lAit9s88hZMCMxZc8lOIENhM3AA8pw9TZkU8w/zOFRVZw0QZXlb3PBhSt3zJ+XiVBnKXNgBVfv924Ch4jQHFPgeFuHiw2jKBlJ/DHesglqfxGh75+bEgl8yaE6+Kp5wXPQ/Gswn2lG+Z4g5VdaEtvNoriakCGlkLNWuwIlL4J1Zb2Ks79k6UUN/YVTLvJRaBWHehYF0kmvd263ThB/uGpS9eqsYLfDxPRkBfVnsoT/4ka0iXdLpYoPkYg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37b32a3-ea4e-4161-4667-08d839e7d242
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 09:05:10.2601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeO9WHqddY78+R+RofI+RxZDKuVNB8IPAq4k1WVSaWy+WL7xTn1hdpXMIcFIiUSQWvZd0yb28JLK0bo3SiXqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Arunpravin <apaneers@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Access the exported P2P dmabuf over XGMI, if available.
Otherwise, fall back to the existing PCIe method.

Signed-off-by: Arunpravin <apaneers@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 34 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 19 ++++++++++--
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index ffeb20f11c07..589d008f91df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -35,6 +35,7 @@
 #include "amdgpu_display.h"
 #include "amdgpu_gem.h"
 #include "amdgpu_dma_buf.h"
+#include "amdgpu_xgmi.h"
 #include <drm/amdgpu_drm.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
@@ -560,3 +561,36 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 	obj->import_attach = attach;
 	return obj;
 }
+
+/**
+ * amdgpu_dmabuf_is_xgmi_accessible - Check if xgmi available for P2P transfer
+ *
+ * @adev: amdgpu_device pointer of the importer
+ * @bo: amdgpu buffer object
+ *
+ * Returns:
+ * True if dmabuf accessible over xgmi, false otherwise.
+ */
+bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
+				      struct amdgpu_bo *bo)
+{
+	struct drm_gem_object *obj = &bo->tbo.base;
+	struct drm_gem_object *gobj;
+
+	if (obj->import_attach) {
+		struct dma_buf *dma_buf = obj->import_attach->dmabuf;
+
+		if (dma_buf->ops != &amdgpu_dmabuf_ops)
+			/* No XGMI with non AMD GPUs */
+			return false;
+
+		gobj = dma_buf->priv;
+		bo = gem_to_amdgpu_bo(gobj);
+	}
+
+	if (amdgpu_xgmi_same_hive(adev, amdgpu_ttm_adev(bo->tbo.bdev)) &&
+			(bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM))
+		return true;
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
index ec447a7b6b28..2c5c84a06bb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
@@ -29,6 +29,8 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
 					int flags);
 struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 					    struct dma_buf *dma_buf);
+bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
+				      struct amdgpu_bo *bo);
 void *amdgpu_gem_prime_vmap(struct drm_gem_object *obj);
 void amdgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 int amdgpu_gem_prime_mmap(struct drm_gem_object *obj,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 71e005cf2952..771c27478bb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -28,6 +28,7 @@
 #include <linux/dma-fence-array.h>
 #include <linux/interval_tree_generic.h>
 #include <linux/idr.h>
+#include <linux/dma-buf.h>
 
 #include <drm/amdgpu_drm.h>
 #include "amdgpu.h"
@@ -35,6 +36,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gmc.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_dma_buf.h"
 
 /**
  * DOC: GPUVM
@@ -1778,15 +1780,24 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		nodes = NULL;
 		resv = vm->root.base.bo->tbo.base.resv;
 	} else {
+		struct drm_gem_object *obj = &bo->tbo.base;
 		struct ttm_dma_tt *ttm;
 
+		resv = bo->tbo.base.resv;
+		if (obj->import_attach && bo_va->is_xgmi) {
+			struct dma_buf *dma_buf = obj->import_attach->dmabuf;
+			struct drm_gem_object *gobj = dma_buf->priv;
+			struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
+
+			if (abo->tbo.mem.mem_type == TTM_PL_VRAM)
+				bo = gem_to_amdgpu_bo(gobj);
+		}
 		mem = &bo->tbo.mem;
 		nodes = mem->mm_node;
 		if (mem->mem_type == TTM_PL_TT) {
 			ttm = container_of(bo->tbo.ttm, struct ttm_dma_tt, ttm);
 			pages_addr = ttm->dma_address;
 		}
-		resv = bo->tbo.base.resv;
 	}
 
 	if (bo) {
@@ -2132,8 +2143,10 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 	INIT_LIST_HEAD(&bo_va->valids);
 	INIT_LIST_HEAD(&bo_va->invalids);
 
-	if (bo && amdgpu_xgmi_same_hive(adev, amdgpu_ttm_adev(bo->tbo.bdev)) &&
-	    (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)) {
+	if (!bo)
+		return bo_va;
+
+	if (amdgpu_dmabuf_is_xgmi_accessible(adev, bo)) {
 		bo_va->is_xgmi = true;
 		/* Power up XGMI if it can be potentially used */
 		amdgpu_xgmi_set_pstate(adev, AMDGPU_XGMI_PSTATE_MAX_VEGA20);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
