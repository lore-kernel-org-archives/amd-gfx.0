Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0729C87FCE
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 16:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5EA10E20E;
	Fri, 25 Jul 2025 16:08:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PzHsJidT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2999810E20E
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 16:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djdkmHnexE4p/vdgBKTw0YyIyyoGVk8sfA2GTmBZrat/4WEb8gAncIAYnVlZ+3PhdYKnhxpVinTw6+EcC1R9Z6rEwWHNnFnU3YGUxZh/C8yJLfTNmWtBKQnDyLSVxPlTi0ap2UnqBTJ5iIkoAbbMefJfjnpQMZHdeSVYOddHSDRBAXNHu4DxWadONb01CCDyfJ9Ghm+rvil60dtEE2BSeCnfKXGFKKGb526HAVijM4LYWNw9OdGm/suVODRKhKFG87I5oRzxsgUcasz+zG58vixVyMF/1p9u7sVRs2nThuReb6bNcQUUOX/nzzQSRW9cruwHDgVovV7Azf0r0jNYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njN5qPpTMbw8j6AMlws+w0DwvUtEhdUzmGjoYIVQVik=;
 b=ljtIbrgFVzQuKmf4hmz11ZYnnRn1Pv86sb9y1htKDyQrQWgyHJPDSTdrWHGdQXxrpRksis6bRkY6GWGqat79b5DXpwSCfycuFuTgIZ+6dAwc5UYTQiJVYGjYx+vV8hx7x8hJN7Z4AFBfvUlq3KuJLHx96r56s2Fg7AH94DxZBPIvmiSq9fCp3CEjS98DiVnhOLKXCTZr14DGqTEbXShnNWPx0tcD/yTXS1KP47sih020ZZRGyrU3M5e22trF1FnMdI64r0g6rVabkAK5c2/yOc40ZdIvXwE22Zod/C2KsUZUe0S60y7msYXxBendhBa3TpQIJgIy23oXcI3br3derQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njN5qPpTMbw8j6AMlws+w0DwvUtEhdUzmGjoYIVQVik=;
 b=PzHsJidT2xgUw5+GDU/if2zt8NDfFY05KUVJVB2lGhN0C2TT/9slV2qpda5dqhXeAcLda9Et/AoZhOdbVcVZ7p6gS/NhQzC8zl7SWJjEqOEHh+o/8tKzSkKPcCGGL5KP/fXLxo5+3Jq4i3ZMmJnDs9t/nPR6VpIswzDJm64EWg0=
Received: from CH5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:610:1f1::15)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 16:08:17 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:1f1:cafe::a9) by CH5PR03CA0021.outlook.office365.com
 (2603:10b6:610:1f1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 16:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.0 via Frontend Transport; Fri, 25 Jul 2025 16:08:17 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 11:08:14 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <simona@ffwll.ch>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>,
 David Francis <David.Francis@amd.com>
Subject: [PATCH v9 2/3] drm/amdgpu: Add CRIU mapping info ioctl
Date: Fri, 25 Jul 2025 12:07:56 -0400
Message-ID: <20250725160757.231780-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725160757.231780-1-David.Francis@amd.com>
References: <20250725160757.231780-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a786e6-e794-46f3-1318-08ddcb9577be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gKCN/VQud5H2qUOWbrJhUjWTZ3WN0B5lGKa1aQ39k4eYPd5Y3adjhbuEFEPt?=
 =?us-ascii?Q?EmE8b92GNVQEbhhF3MBxVzLINEudbMfqJ4rlwUS4/8HMU6Gh6I1enhb+q8Ac?=
 =?us-ascii?Q?DVj87fV5btJoy5+2+4KD2vorNTRr2ftXRkoqmDUfNHPhDexp1i8fM63IETy3?=
 =?us-ascii?Q?BfVnwKY5Dl8ZZhAWAF9Gj/xP415o3zp+1qqEeVbg4ovql4mW8rF1OaMYQeAE?=
 =?us-ascii?Q?j5Y6BlzFSaobNc12ABCdlcS/VJeQQYvnDnIZzHLVdtgw68m0/H68qBfsYkX9?=
 =?us-ascii?Q?Vzjcc/p65D2GC2fk/tWedVDCTHFfWwQw20vOToFncoi6cl2yU05UWEnPldcE?=
 =?us-ascii?Q?llgat5LG8Hi0CrN6J8hxXUGTVlPHzzjslelJf8NgqEoVLSc8wVx0PMEOiv8W?=
 =?us-ascii?Q?Uki0+/HSZGqINZvmjFwRVNNzPp+YhRTXd17zHCj8HVMLIVB8g7Nc3W9/ZMN9?=
 =?us-ascii?Q?qM5aTUAS4zEFLR6xHUwA7Z9IZig/h4o6HoFTabIG0GFbhdfeJ3bU2N7Uya8i?=
 =?us-ascii?Q?3EIORhSwm+ZaiutpDU5E61B3vSYuhI1CA7ycIJTrzKZ5u38uo0YJ9fe+hpsz?=
 =?us-ascii?Q?Rktv9t3veHsjs3PEiPaEJiB9BryfeKfvnQaQoEnp6X/Ji4j3e3e+e2CNR4Ei?=
 =?us-ascii?Q?TmqTV5Kd06+XZbe5u5x1SqCiEN47gkawgsAUyGEJBDptpRQZO2XyBMBsgHdQ?=
 =?us-ascii?Q?In1cA8z5p5Y/XWWsc5ZcFFT9C05zTHPpQuXlhtXVCUE4KBZGsPGk9jd5Y7xw?=
 =?us-ascii?Q?hWCZJOtYbiuLsClDK/o+m37daT4o7Ks+Wb949UKRIWbSh7GrJqVRVm7GxH/l?=
 =?us-ascii?Q?VseDOGAGG9Aavqj81VGEcHJ/Vs8SV9S3nbTUx6nTXiyd/IdrmByDcjFrwFFp?=
 =?us-ascii?Q?Or1ZCn45Kcav/D+BcygeyJCzTIDxQ6mZsAy+3kLoJlDNQ1yHo1zbqGhtQtZM?=
 =?us-ascii?Q?IziEDuG0KGimPEm2/LnmaO034Rg1As1K4q4YViCQD1zVSgnHNc366DcNGqjT?=
 =?us-ascii?Q?ErhFPxH20jfk7ZsGUJogf9ei+vUciZuczF1PrIyXAnJQyFtUQi0tPwNEAlL/?=
 =?us-ascii?Q?STsJllxbbJ3ugZpigycjKYINg8wROgcMKQqqghYWioxuJbvUVH5DM42eMkKI?=
 =?us-ascii?Q?RpTipqa5tALpak+k57e9cNmhvMsOnPNTJe0uyfAGYPw6Tg9QKOaCfVWyv1Mr?=
 =?us-ascii?Q?1ZJWkGIe0fC8Lhu6SaYEGwJSuJInY6V8W35edxpKeAE1ZB4ewbPddEIZhvP0?=
 =?us-ascii?Q?UT8IQwOXaF2JWRmcexvA01nJi+1j67GXkcmzfOb+RF88Bk6AWZP9jc67xvRT?=
 =?us-ascii?Q?aO+adfhHz/uAEF2qen+v2+7cfu6kZ9f081Dc65q7HsGVf77Xr7gGHTQHUyxO?=
 =?us-ascii?Q?rUqzAna7XdCSc/kwA2oY0gFbyGwNYi3ezsz8Dg3fDSww8Nx2jleEqGUBQ2BY?=
 =?us-ascii?Q?hjwPlf+5kH5kYBM/aSD8B1xWKmVmXDnuSMT5/bMAoDjDmyj0fdfN1OsChR5e?=
 =?us-ascii?Q?Nn7B8o8Zj+be3NPNAGE+PGIcU9Cv7RMkDCK4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:08:17.5294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a786e6-e794-46f3-1318-08ddcb9577be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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

Add new ioctl DRM_IOCTL_AMDGPU_CRIU_MAPPING_INFO, which
returns a list of mappings associated with a given bo, along with
their positions and offsets.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c | 97 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  5 ++
 include/uapi/drm/amdgpu_drm.h            | 27 +++++++
 5 files changed, 133 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
index 8bfcb2234166..176ea7c0ee3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.c
@@ -24,6 +24,7 @@
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
+#include <drm/drm_exec.h>
 
 #include "amdgpu_criu.h"
 #include "amdgpu.h"
@@ -99,3 +100,99 @@ int amdgpu_criu_bo_info_ioctl(struct drm_device *dev, void *data,
 
 	return ret;
 }
+
+/**
+ * amdgpu_criu_mapping_info_ioctl - get information about a buffer's mappings
+ *
+ * @dev: drm device pointer
+ * @data: drm_amdgpu_criu_mapping_info_args
+ * @filp: drm file pointer
+ *
+ * num_mappings is set as an input to the size of the vm_buckets array.
+ * num_mappings is sent back as output as the number of mappings the bo has.
+ * If that number is larger than the size of the array, the ioctl must
+ * be retried.
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_criu_mapping_info_ioctl(struct drm_device *dev, void *data,
+				   struct drm_file *filp)
+{
+	struct drm_amdgpu_criu_mapping_info_args *args = data;
+	struct drm_gem_object *gobj = idr_find(&filp->object_idr, args->gem_handle);
+	struct amdgpu_vm *avm = &((struct amdgpu_fpriv *)filp->driver_priv)->vm;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+	struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(avm, bo);
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct drm_amdgpu_criu_vm_bucket *vm_buckets;
+	struct amdgpu_bo_va_mapping *mapping;
+	struct drm_exec exec;
+	int num_mappings = 0;
+	int ret;
+
+	vm_buckets = kvcalloc(args->num_mappings, sizeof(*vm_buckets), GFP_KERNEL);
+	if (!vm_buckets) {
+		ret = -ENOMEM;
+		goto free_vms;
+	}
+
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
+			  DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&exec) {
+		if (gobj) {
+			ret = drm_exec_lock_obj(&exec, gobj);
+			drm_exec_retry_on_contention(&exec);
+			if (ret)
+				goto unlock_exec;
+		}
+
+		ret = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 2);
+		drm_exec_retry_on_contention(&exec);
+		if (ret)
+			goto unlock_exec;
+	}
+
+	amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
+		if (num_mappings < args->num_mappings) {
+			vm_buckets[num_mappings].start = mapping->start;
+			vm_buckets[num_mappings].last = mapping->last;
+			vm_buckets[num_mappings].offset = mapping->offset;
+			vm_buckets[num_mappings].flags = mapping->flags;
+		}
+		num_mappings += 1;
+	}
+
+	amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
+		if (num_mappings < args->num_mappings) {
+			vm_buckets[num_mappings].start = mapping->start;
+			vm_buckets[num_mappings].last = mapping->last;
+			vm_buckets[num_mappings].offset = mapping->offset;
+			vm_buckets[num_mappings].flags = mapping->flags;
+		}
+		num_mappings += 1;
+	}
+
+	drm_exec_fini(&exec);
+
+	if (num_mappings > 0) {
+		if (num_mappings <= args->num_mappings) {
+			ret = copy_to_user((void __user *)args->vm_buckets, vm_buckets, num_mappings * sizeof(*vm_buckets));
+			if (ret) {
+				pr_debug("Failed to copy BO information to user\n");
+				ret = -EFAULT;
+			}
+		}
+	}
+	args->num_mappings = num_mappings;
+
+	kvfree(vm_buckets);
+
+	return ret;
+unlock_exec:
+	drm_exec_fini(&exec);
+free_vms:
+	kvfree(vm_buckets);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
index c991d08262c1..d2edce3b75f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_criu.h
@@ -27,4 +27,7 @@
 int amdgpu_criu_bo_info_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
 
+int amdgpu_criu_mapping_info_ioctl(struct drm_device *dev, void *data,
+				   struct drm_file *filp);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 28a057db4718..cefa2661449a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3029,6 +3029,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_CRIU_BO_INFO, amdgpu_criu_bo_info_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_CRIU_MAPPING_INFO, amdgpu_criu_mapping_info_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f9549f6b3d1f..5a63ae490b0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -668,4 +668,9 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
 				 struct amdgpu_vm *vm,
 				 struct dma_fence **fence);
 
+#define amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) \
+		list_for_each_entry(mapping, &bo_va->valids, list)
+#define amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) \
+		list_for_each_entry(mapping, &bo_va->invalids, list)
+
 #endif
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 460170fdb66e..94fa5b6da550 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_CRIU_BO_INFO		0x19
+#define DRM_AMDGPU_CRIU_MAPPING_INFO    0x20
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_CRIU_BO_INFO	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CRIU_BO_INFO, struct drm_amdgpu_criu_bo_info_args)
+#define DRM_IOCTL_AMDGPU_CRIU_MAPPING_INFO  DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CRIU_MAPPING_INFO, struct drm_amdgpu_criu_mapping_info_args)
 
 /**
  * DOC: memory domains
@@ -1661,6 +1663,31 @@ struct drm_amdgpu_criu_bo_bucket {
 	__u32 padding;
 };
 
+struct drm_amdgpu_criu_mapping_info_args {
+	/* Handle of bo to get mappings of */
+	__u32   gem_handle;
+
+	/* IN: Size of vm_buckets buffer. OUT: Number of bos in process (if larger than size of buffer, must retry) */
+	__u32   num_mappings;
+
+	/* User pointer to array of drm_amdgpu_criu_vm_bucket */
+	__u64   vm_buckets;
+};
+
+struct drm_amdgpu_criu_vm_bucket {
+	/* Start of mapping (in number of pages) */
+	__u64 start;
+
+	/* End of mapping (in number of pages) */
+	__u64 last;
+
+	/* Mapping offset */
+	__u64 offset;
+
+	/* flags needed to recreate mapping */
+	__u64 flags;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1

