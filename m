Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14EEC4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 16:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D6C10E73A;
	Wed,  1 Nov 2023 16:26:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BB0610E73A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 16:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrZx/mCABmM4cYBPMxjzX2F8KTOyL6iFVDQfSLtQFlICibY6/+/gJ+1AzCnY5dsEYF7cVkkSXlNxAHuw+45chpLjAUlqcf4DQ/OMyL4bRKZZL6eoPzGvch2xtLWtsbSORIy+m1xhCectowWDV/kd3VwUojJ0dw62k4LGlkfyGACS89Phyo8e4vDugm7lkB+dIUQK0+v+4O330/msoDH50+60UMEjqSwywS26putLhF/5PdH0O1pj24BTiEgQQRzz2LakJ+V0Rf7C7Iecqq/2PsPU1Othsa41ow+EY0iWZogHFMbQbFzF7zT9iCqk/zDAAR04OM0TA3VJ7O2HK69Nmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1aXSPJIKDV0L4YXMjVBK64n5RTZdV90Fzi1zFteDxA=;
 b=CtPJsoLronvsetdCw5yogadm+7HmI1WxYpNnKvmQ14yDrAF9FTM1h8rCvGAbCYIMM6Z/Ve+ZVnrxvTuqfM9tZ4WodXPOGd6I0YSVD9yLPFiAROmK+9NQcgUzH44WWEQYKRPNEeeo9RhZv2viCvyI7Qzar41N5pmEqU0FhcTc2aDB/VgZrGSf6DBZ/2JhOYREyAFtuPpqL0SgwleusjCBgg5sY9sMRm22uc7GIsjPRDJ2v3DCU9gkAv1Xbp+AK6oPetpkPQnzMmCVm1uM41jIX7Q599wAejssl5GhAJz/DQ05jeCUtiaZwNFW4sAfyP7wWEDieiJIfSb/EICeE8xJgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1aXSPJIKDV0L4YXMjVBK64n5RTZdV90Fzi1zFteDxA=;
 b=dPW/+AMtodqFER7Fu+4hU4w7cOY7OO/v3M7UBlZIn85z0fxAo+WAFQrW8mf144VL8tTFvuGQGhP7sFb+TQnExMYZvSsW7Rqqz/+AAWTspM7DIvVInxPxAnDoldPn5AObgCoxoWFUY2dOma+URQqP+cgGvjCEAWAbRWI9BT/y/fg=
Received: from MN2PR15CA0019.namprd15.prod.outlook.com (2603:10b6:208:1b4::32)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 16:26:53 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::5c) by MN2PR15CA0019.outlook.office365.com
 (2603:10b6:208:1b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 16:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 16:26:53 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 1 Nov 2023 11:26:50 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Use drm_exec for seq64 bo lock
Date: Wed, 1 Nov 2023 09:26:02 -0700
Message-ID: <20231101162602.4122-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101162602.4122-1-Arunpravin.PaneerSelvam@amd.com>
References: <20231101162602.4122-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fef7183-23d5-40d5-dd5d-08dbdaf75bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hcrJ/kyKpU6yyAtKcndOCZsvfP8qd4myfA38pTah4iDXulcKo4MU+c/DlFw/2CUIT8fbWJY7/yaho2koCXXfMjqBUWqRQ1XQDCpQE3OFCSo1dnR7+v7/KYH2PXNUMl8vDyTdgMy6Cl2FjtavHRa8RcxbTLUG8XzoM3xsljeVQZS01khhhxsnIR8K+HtSRgSLxmqWL6vQ70LQMorTgqhZNtucujEwaT3jHSM6RKJ+Wn9299glqCNaRZdgQb4GwHqoULCsbeVkOy2Cwsv5ksf9co2DlpZHX5DmiuvLJ803bEp8wcj2GWAnPxr+dtrabe5bU5Ye66q3Lw+xfDNiKM1QYi5/4npcajaqoSFrQODNh4xcBRPmSggQJX/snmLu0nP8XnGh5coFedWOM43hRHZkgUuLAzYUR4GNqi9WzTd3gd/5Vpf1i4qRJTvGqlQLORS8IAvJSdUvESSQy4N/Vkp83WocvPHtmKpQClDrIyU2CqI4KtD+SuJRjasajdH9lIKE/Z8kwunrkakdg+3mSBVUZ/mciz7IIC58GyL4LNB2/I3zBeN+n13yPQ8uNFOy7UhQjYNYYHE7MZo4xtVYOzeqwEt2odLUJJPbLWL8lQfuuAm5khknGEnVlZSVii2+yLo9lnLYslzOja+H2nptp0Te/U1jlZow7OKthJqbk8B1Rod8K8L6cxXQ516anO0a0VYu1K+NWAHsFwFtE6uK4gm55AvIaWpbNhkMFc0trw8SZrpCjgE/gasx7Qy3P6T+VxAPeZWa7NzaMbxcR28joasNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(40460700003)(26005)(1076003)(336012)(47076005)(36860700001)(7696005)(6666004)(2906002)(83380400001)(8936002)(5660300002)(70586007)(70206006)(6916009)(2616005)(4326008)(8676002)(426003)(41300700001)(316002)(54906003)(356005)(36756003)(81166007)(82740400003)(478600001)(86362001)(40480700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 16:26:53.5173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fef7183-23d5-40d5-dd5d-08dbdaf75bd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace seq64 bo lock sequences with drm_exec.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 73 ++++++++++-------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 63d8b68023be..810f7637096e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -25,6 +25,8 @@
 #include "amdgpu.h"
 #include "amdgpu_seq64.h"
 
+#include <drm/drm_exec.h>
+
 /**
  * DOC: amdgpu_seq64
  *
@@ -68,11 +70,8 @@ static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
 int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_bo_va **bo_va)
 {
-	struct ttm_validate_buffer seq64_tv;
-	struct amdgpu_bo_list_entry pd;
-	struct ww_acquire_ctx ticket;
-	struct list_head list;
 	struct amdgpu_bo *bo;
+	struct drm_exec exec;
 	u64 seq64_addr;
 	int r;
 
@@ -80,23 +79,20 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (!bo)
 		return -EINVAL;
 
-	INIT_LIST_HEAD(&list);
-	INIT_LIST_HEAD(&seq64_tv.head);
-
-	seq64_tv.bo = &bo->tbo;
-	seq64_tv.num_shared = 1;
-
-	list_add(&seq64_tv.head, &list);
-	amdgpu_vm_get_pd_bo(vm, &list, &pd);
-
-	r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
-	if (r)
-		return r;
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_until_all_locked(&exec) {
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto error;
+	}
 
 	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
 	if (!*bo_va) {
 		r = -ENOMEM;
-		goto error_vm;
+		goto error;
 	}
 
 	seq64_addr = amdgpu_seq64_get_va_base(adev);
@@ -104,23 +100,19 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			     AMDGPU_PTE_READABLE);
 	if (r) {
 		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
-		goto error_map;
+		amdgpu_vm_bo_del(adev, *bo_va);
+		goto error;
 	}
 
 	r = amdgpu_vm_bo_update(adev, *bo_va, false);
 	if (r) {
 		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
-		goto error_map;
+		amdgpu_vm_bo_del(adev, *bo_va);
+		goto error;
 	}
 
-	ttm_eu_backoff_reservation(&ticket, &list);
-
-	return 0;
-
-error_map:
-	amdgpu_vm_bo_del(adev, *bo_va);
-error_vm:
-	ttm_eu_backoff_reservation(&ticket, &list);
+error:
+	drm_exec_fini(&exec);
 	return r;
 }
 
@@ -134,12 +126,10 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  */
 void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
 {
-	struct ttm_validate_buffer seq64_tv;
-	struct amdgpu_bo_list_entry pd;
-	struct ww_acquire_ctx ticket;
-	struct list_head list;
 	struct amdgpu_vm *vm;
 	struct amdgpu_bo *bo;
+	struct drm_exec exec;
+	int r;
 
 	if (!fpriv->seq64_va)
 		return;
@@ -149,20 +139,23 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
 		return;
 
 	vm = &fpriv->vm;
-	INIT_LIST_HEAD(&list);
-	INIT_LIST_HEAD(&seq64_tv.head);
 
-	seq64_tv.bo = &bo->tbo;
-	seq64_tv.num_shared = 1;
-
-	list_add(&seq64_tv.head, &list);
-	amdgpu_vm_get_pd_bo(vm, &list, &pd);
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_until_all_locked(&exec) {
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		if (likely(!r))
+			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto error;
+	}
 
-	ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
 	amdgpu_vm_bo_del(adev, fpriv->seq64_va);
-	ttm_eu_backoff_reservation(&ticket, &list);
 
 	fpriv->seq64_va = NULL;
+
+error:
+	drm_exec_fini(&exec);
 }
 
 /**
-- 
2.25.1

