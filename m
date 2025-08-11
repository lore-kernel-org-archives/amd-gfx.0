Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31084C87FD2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 15:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B562D10E480;
	Mon, 11 Aug 2025 15:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kJ1/kF6L";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC7A10E4F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 15:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHSHghhwwNTJfYMxAFjR/5G8zsnqhQo6cC8Z9tJt9M54iiMmG7VNkRNf/nkfB77eOIHepoBVEV/FAaKyD4apaEtIXrRA6t0kx/O/PqS/1EcpUu/z3eSt8zeu1XdzqfmuvXURFrgG1LZeFbf957oenVRhg9N4KfVQF6hz3HeKj+1OAcdsjIZDcCLUljINxrLUqfhmExRxMRUlq/HJyoZwPq2T2Xj/vx6DCFpAmRjxE/VL5rv9RdHSXtqga32FZr+4CN1cP7lnity/oF2I4vK2z2kHeZlJOZRfs1E9g9ORi95b31PKeQid1LynoOH+C7+LLLlxGZ2f80B8AYLygUsG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epu/aHVb+7Kic4Uas/7AebD+eeCp26AD66w+l53MapQ=;
 b=yqWtxjmNI80zyrQMgC3a+qMQ7gC3GqYwMO8pJT87eJcExMJohqe4pArTomuWR5Hx4Cy/3uOuMYpaMTUOSDBnOVkfVrzs0Pk8hV/kOPLzUs1VCjmYhjXVtfBj/tC0SZf4Y0yxJWvtzEQr+0SRtApUTrqDhYnPvnW2GllapywwFJqeeJVeRJfGwtp7OM9Tuwz5RJD5eJmrvSFaN5UbGCqVbwb68C0wAffXzO7eJV14G8dVOpFHnG2jWX+BjHSujRRU3x6OQvB/KO5YujW4wSiTym5VvaAa0MHPMmOhAUjLecUdGqGVElYXftOLBZSKOfVKWw3L6PJ2FoH1C9Tw1cKHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epu/aHVb+7Kic4Uas/7AebD+eeCp26AD66w+l53MapQ=;
 b=kJ1/kF6LGzfvrAoPIOYqMoZ0OUuHpQ3uiwT0XiplSvIqZMFyu/vjNM31dAnR0k2HKBMel7USjXtpcRDUji1VXN6alChsbInXWn3Y6EJa0/8WoPWRdiz61KLw9sHAPkHTzrXiOwlInzac4hGPpR/qGeTHhfavs+E+1kRNYKZ891s=
Received: from SJ0PR03CA0134.namprd03.prod.outlook.com (2603:10b6:a03:33c::19)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 15:05:54 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::39) by SJ0PR03CA0134.outlook.office365.com
 (2603:10b6:a03:33c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 15:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 15:05:53 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 10:05:52 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v12 2/3] drm/amdgpu: Add mapping info option for GEM_OP ioctl
Date: Mon, 11 Aug 2025 11:05:35 -0400
Message-ID: <20250811150536.3394262-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811150536.3394262-1-David.Francis@amd.com>
References: <20250811150536.3394262-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e910fe3-d248-4aa0-67f4-08ddd8e89123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6yBxE7W8E0Oj7xVcelo5nKk7SGbY4yvKBItv405OcpNoCOL5VtBneZG7vtx/?=
 =?us-ascii?Q?Xvr4bIVXI5joaGsbHWc97DD4P5CNzrZ0HOBHksOUPrnLW5BMub4mP204xaA+?=
 =?us-ascii?Q?1ZpEKh1uItRK9A45uvIQwii6ehEQ6Eqs7Dm+lh8gXy1z+hThqachEvespKpi?=
 =?us-ascii?Q?RK7l38PLdwl6xu65wNVA+r8JHWopT6lNG4GppsOul4pasXUMtp2m0VP9u6D6?=
 =?us-ascii?Q?g1TkJUqNk6lqmOj4hk3HyNC4HWiXpAK/h9gvvtPopGfrOx+AhhYyr5TzZoSC?=
 =?us-ascii?Q?b6jolRmRijterSrMCsmc5K10NlnHDQhcNDsju5z6HHY3T1hEnOIsg4PYB7vo?=
 =?us-ascii?Q?RAMnh1gOyl6Z0WTCABuH0SHHnWMlG0cyOGQlaItt864kVvQxBedL/m6pQkwn?=
 =?us-ascii?Q?F8c27WUWuPb+P2+/gx8UfC8IKx7zHKRLy0B0Tem6Lbg47ZOMZU/cpv6u53VL?=
 =?us-ascii?Q?bOhq7KdiO2FIXkFCY3UXh3hq+msqShzkk6MC4MgVoMgf0cxjgY9jSZ/SyEFB?=
 =?us-ascii?Q?r+CDsP3nSt6KNt1wusBt/zF8US7hm4Q0YKtBTlPoIaT0h3IPPPpLv7o6Vb7T?=
 =?us-ascii?Q?Yj3Na4u5SNOPBfzZKuIx2huo4c5eILe0zpitTxLSB7GdO2hdoVSb0z0T5rDN?=
 =?us-ascii?Q?pNcZ0t8sB4/zMXP3OPQdWHtl1uUbJLZltW1DQhUdiPrVXDr4i0/ygdFz7vHg?=
 =?us-ascii?Q?p9Mi8T23N4i9sKDucwVjnErDFFyVJ3UDyi1auclLf+BNJ/3k6fQtwUfPMnse?=
 =?us-ascii?Q?1ASTz/zkTg/IVH0iTfZ884d1y5V3qiaBz2M8SpJvbAWUoXYPNo/ujrfUY/Tn?=
 =?us-ascii?Q?B6wMHmGvgu7mTMoWLNnt6Hzwi10UHBFkPKnoLron5JOyHuUvjfP0mGmJReCS?=
 =?us-ascii?Q?VZxHievYbPtwbaiOM5b2IWvoHKVbI07CfwqI/S9nzCinAw1PXyYLVOo2WbsM?=
 =?us-ascii?Q?QZhgSIirKV4XeacidaOg7YVqMWXJaoL3E8s0nIdu/br0y9VtaVY///rSLQUW?=
 =?us-ascii?Q?U8wm8HEOGLDpUFv2Mtx7bg1y7dUYkDZs6LJ9T1k2GlrieETbO4IQR2OSlo/i?=
 =?us-ascii?Q?52HgG/JpyViA/SEvuy2hwLFWM97owv2eVT3HckqAFFv/cG/3Jpu4kbhrkHWw?=
 =?us-ascii?Q?8/zPMEb8STH8FthMFJadk5HA8OgEdurEN+eyX42S73Tyx8LWYBViTb0EmhyA?=
 =?us-ascii?Q?2yhisILXfCEhTGOtE0nY1fuVUbE9SriUW1KK5WwqNW76skv4J3zo1MIfwhHt?=
 =?us-ascii?Q?zTVG1wGKwTgFCgXlevGOjAEEIGIUkZz+S5KbdSymGNb4TZptja6OS0eIBNu9?=
 =?us-ascii?Q?C4UxrM93EAWoNRajx/po9n0yQY1m7v/7N56bxH4TWJQJW3xHZdAl+LGaESXL?=
 =?us-ascii?Q?QFKz+Fw4OxIxwhIrdKw99/V7kSJpujL8YIbWB33y2TMNHfovmnpsLSiaD0jV?=
 =?us-ascii?Q?S2erwMDEI+QA+cqnfs/mH/AC8wpJfjSFTPEC17TSl6vnL9AWcK83CTlFVXBe?=
 =?us-ascii?Q?wqCPGsMyt/UVnteAMHS4MufNlCnlJKGlaUEN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:05:53.4785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e910fe3-d248-4aa0-67f4-08ddd8e89123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 86 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
 include/uapi/drm/amdgpu_drm.h           | 18 ++++++
 3 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 3873d2c19b4b..1632460623b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -885,7 +885,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 				goto error;
 		}
 
-		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 2);
+		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r))
 			goto error;
@@ -956,6 +956,86 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
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
+	if (!vm_buckets)
+		return -ENOMEM;
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
+	if (num_mappings > 0 && num_mappings <= args->num_entries)
+		ret = copy_to_user(u64_to_user_ptr(args->value), vm_buckets, num_mappings * sizeof(*vm_buckets));
+
+	args->num_entries = num_mappings;
+
+unlock_exec:
+	drm_exec_fini(&exec);
+	kvfree(vm_buckets);
+
+	return ret;
+}
+
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
@@ -1022,6 +1102,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
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
index 59b423883e91..7072959103e6 100644
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

