Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1679EC87FDA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 20:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEDF110E48F;
	Thu,  7 Aug 2025 20:23:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FWvEdQUl";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08E510E888
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 20:23:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njOW2zdKgWsYJYpDCjqkM9JAPA8N4VhdZ5lj09NoDakzjYqE8/AZ/4ONZyROiybOZSVOod2gqWotA4+jkqndPqeqIgVzhx1mFrbMXg3axqLISoJIafYjzv2Yhy1IeW35vwVI/Um8d0sfh0HaD4hd1U8jlaOoEeXpVCcF84MFemvTxIARn2KM0hqiytNX2es3EFuTqUpDXK1OBWJXhX3Ugvmwx+uhvn1jGjJLGrrnXk6+p6VXInPMpz/3ZFlBxysQZyhBsmJhIIUYKpwY5CIk323pkUpi95Qwyi0/BVz184ToKmAOpMaiuz1csJCmjqDCmKyd7Mdwa2HZy1LD6+m6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PptlYGaAHRyi/3NWZp94EO9Kp4ManP1OgD8+L1K0K4E=;
 b=HuKGuYA3gX6whKD8Sa/Uk4bd5ADwQEpcoiFxuDFvE9x3/pNEKBE7IejUXDbofR3KRIq95XU5dNbtxgiBt0G/7vqwFPAAmHkiwlp80eIgu1aoHG5l1yluFPFvGnBBgEisOBNeijUJqpx1nffYdkYJOapP4wz5XOKucnlAxbJvK7WpF4pkH5kCh8rwJk3QiB1gOLPULu4IjNTkXt4QY56OD/diRrQoykWyusPzYxbmK/6/DYJINxUz1i6EUTYu2wNdfgYPXYSZG5B5qDB9EWegI5cnkV9M3iUSF5GOFSyYWwpdgm1pwaMOXPFnOA0eXcTo22F6PIoUBaJxZsF70p0wGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PptlYGaAHRyi/3NWZp94EO9Kp4ManP1OgD8+L1K0K4E=;
 b=FWvEdQUlR3lAro8PcyJOmMgKTnRHkPMTtVAZ4udCdQHbDbln5qntAOkFq3Gr1Mjbl5wSKvlm0iQAkaSXZNvrNvI46C/7IjjllsenRg5oBDwkGvYnD3BjfxY9znvREBku3FqlSrMFPs/GnpJiG7rfv8hvIKaoNoXHlbyjlJql8Uo=
Received: from BL0PR01CA0016.prod.exchangelabs.com (2603:10b6:208:71::29) by
 LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 20:23:11 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::a9) by BL0PR01CA0016.outlook.office365.com
 (2603:10b6:208:71::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Thu,
 7 Aug 2025 20:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 20:23:11 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 15:23:10 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v11 2/3] drm/amdgpu: Add mapping info option for GEM_OP ioctl
Date: Thu, 7 Aug 2025 16:22:44 -0400
Message-ID: <20250807202245.2970262-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807202245.2970262-1-David.Francis@amd.com>
References: <20250807202245.2970262-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|LV5PR12MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: 972b3511-1f34-467e-0147-08ddd5f03b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/P7fAlbWhHvMc6lK5cszqjUYtL8OCCTDmShemEZFZIpeqWfkE5nWbPajuTU8?=
 =?us-ascii?Q?+c5P5fMNM4o7SPDknJrUFoIl9szqBNJeOKZDD6Pay9U83B65osuK3PzV7oZX?=
 =?us-ascii?Q?7GjjRDPEVuLlccfafcAVlR/Zmm97uMvQ2eykJ39nIyFpAXQPSPxQONoJKhYG?=
 =?us-ascii?Q?a4y1ls2oCrt0D7dmYO6DG7bl07VCocJZ1Md7fsuSO2w3bqGQqx0HdTnJpt1f?=
 =?us-ascii?Q?DOVmTKbUQ7hMXLLFZCReT+bB3zdY9u4bp/HGW0rRo9Y0QOQMNzLqDP5cBV7G?=
 =?us-ascii?Q?cWhs1USlRndBDov+aKK2xNTjcSU//ild5R17CIOo3zEhiobV3HDyqXiAKSH+?=
 =?us-ascii?Q?RPp+05Fd3ObVNlaoM1j1n+IjPN72bZ2ItorqrWY4L6evlCrVkmeW2zuApaiK?=
 =?us-ascii?Q?tZY6NhyOrlGEya3EAZ7ieDNc3x4VLBXpAaLei9+h4ytauG0MkY71TDPiA86J?=
 =?us-ascii?Q?IVaKziZXFHC7aCHna5KZJv8S0v2NXR+HsS/UQdqIaXuhCGiJNamzKIfWfq3h?=
 =?us-ascii?Q?jGGB/oz6CVS68KBrlGXOdDTSnPIHtodZtQ8rObxN+rBdQcLS6QX6dimImdbK?=
 =?us-ascii?Q?MkAcmubSjmVFPMuUUEa1S2ikIYulEqXeP04bKa+lKtsMXFZ4UDaQy9wkm3jl?=
 =?us-ascii?Q?wPa7vbXlxOm09sgmytC23tbV6ll2wslLx2EzLnP/8mpDW6JqueeYSvevh/EE?=
 =?us-ascii?Q?X0nCyeJ1UyIOlFbefduzDdxIWW68EixbItIW6b9m6Qg0dQrsQ2t1zInmEVom?=
 =?us-ascii?Q?5tK3UB676CyGqSBTJLvotx9KIi7zlgpvnUauRyVBh/Q9ylmYnllxKYXXxHw3?=
 =?us-ascii?Q?BLRgCktFRuV6WUgPPQsMxjNmTqTG6ON2wW24jtvnrbjLXfLe/+txvm1V0aCP?=
 =?us-ascii?Q?9Uh/JYRaO3wLsu8+eQe10oodLLiqOzNZGdinK5GizdvHPzu369yhdG1YbD1B?=
 =?us-ascii?Q?KbtanM9OBgyO3CVD1zph1AaLww4ucHYoOi9ND2POWUZDW5aQG9Ad6RfY3d+G?=
 =?us-ascii?Q?coxzSRIUgC13l1UYS46Za0HKy+YtOxD6iQGvbVgGjOYwI2L059/AO5BwlpaI?=
 =?us-ascii?Q?p3UeUstsdBxzpF9ubTUHvEVpHqSyQCugHhPPdxbNbxl3lbWa+hZ7cd6m4YAt?=
 =?us-ascii?Q?KDKTwJeDo+EIFLkABJ4bw9ER6lWKnSfVqYxFvd08k3iMM6s7VX/ca9nvTvHI?=
 =?us-ascii?Q?C/K+lo2uyN4JnOns5fXjJYHaamXy1b/fdES84rFXdDvM7ZzcKJ3/93lPY7Kc?=
 =?us-ascii?Q?WK11sbAhSMUNPFloD0ZJqxY/qCcrnP+Kb2Eesyzk7cWjZLOdbiY7JvXJX6YX?=
 =?us-ascii?Q?hDE6M9lUCxPIsURwRlJMxQFugRbceSxC26p2lE0rVivI7EwXyhyHzyPX+JhF?=
 =?us-ascii?Q?siEhSfDbDI4ieaMcRZo6NlX8G3iNf9srwbp5I7S8nLb+yddCgs6NAXCXkImj?=
 =?us-ascii?Q?PUOOzS/VWXWY5g6Rob37XADof86OzGBKSTES64ftqezkGgmybxKzDR3oIUnQ?=
 =?us-ascii?Q?smJS+T2X20Y8lwoythIjBmDBe9QhmibCS21W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:23:11.6868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 972b3511-1f34-467e-0147-08ddd5f03b20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753
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

Add new GEM_OP_IOCTL option GET_MAPPING_INFO, which
returns a list of mappings associated with a given bo, along with
their positions and offsets.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 96 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
 include/uapi/drm/amdgpu_drm.h           | 18 +++++
 3 files changed, 119 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 7f55e3b7d8a2..29ee1df37661 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -956,6 +956,98 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+/**
+ * amdgpu_gem_list_mappings - get information about a buffer's mappings
+ *
+ * @gobj: gem object
+ * @args: gem_op arguments
+ * @fpriv: drm file pointer
+ *
+ * num_entries is set as an input to the size of the user-allocated array of
+ * drm_amdgpu_gem_vm_bucket stored at args->value.
+ * num_entries is sent back as output as the number of mappings the bo has.
+ * If that number is larger than the size of the array, the ioctl must
+ * be retried.
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+static int amdgpu_gem_list_mappings(struct drm_gem_object *gobj, struct amdgpu_fpriv *fpriv,
+					  struct drm_amdgpu_gem_op *args)
+{
+	struct amdgpu_vm *avm = &fpriv->vm;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+	struct amdgpu_bo_va *bo_va = amdgpu_vm_bo_find(avm, bo);
+	struct drm_amdgpu_gem_vm_bucket *vm_buckets;
+	struct amdgpu_bo_va_mapping *mapping;
+	struct drm_exec exec;
+	int num_mappings = 0;
+	int ret;
+
+	vm_buckets = kvcalloc(args->num_entries, sizeof(*vm_buckets), GFP_KERNEL);
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
+		if (num_mappings < args->num_entries) {
+			vm_buckets[num_mappings].start = mapping->start;
+			vm_buckets[num_mappings].last = mapping->last;
+			vm_buckets[num_mappings].offset = mapping->offset;
+			vm_buckets[num_mappings].flags = mapping->flags;
+		}
+		num_mappings += 1;
+	}
+
+	amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
+		if (num_mappings < args->num_entries) {
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
+	if (num_mappings > 0 && num_mappings <= args->num_entries) {
+		ret = copy_to_user((void __user *)args->value, vm_buckets, num_mappings * sizeof(*vm_buckets));
+		if (ret) {
+			pr_debug("Failed to copy BO information to user\n");
+			ret = -EFAULT;
+		}
+	}
+	args->num_entries = num_mappings;
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
+
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
@@ -1022,6 +1114,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
 		amdgpu_bo_unreserve(robj);
 		break;
+	case AMDGPU_GEM_OP_GET_MAPPING_INFO:
+		amdgpu_bo_unreserve(robj);
+		r = amdgpu_gem_list_mappings(gobj, filp->driver_priv, args);
+		break;
 	default:
 		amdgpu_bo_unreserve(robj);
 		r = -EINVAL;
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
index 218a179818d4..6b857f528823 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -802,6 +802,21 @@ union drm_amdgpu_wait_fences {
 
 #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
 #define AMDGPU_GEM_OP_SET_PLACEMENT		1
+#define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
+
+struct drm_amdgpu_gem_vm_bucket {
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
 
 /* Sets or returns a value associated with a buffer. */
 struct drm_amdgpu_gem_op {
@@ -811,6 +826,9 @@ struct drm_amdgpu_gem_op {
 	__u32	op;
 	/** Input or return value */
 	__u64	value;
+	/** For MAPPING_INFO op: number of mappings (in/out) */
+	__u32	num_entries;
+	__u32	padding;
 };
 
 #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
-- 
2.34.1

