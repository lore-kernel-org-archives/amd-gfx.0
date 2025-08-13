Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A5CCA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 18:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E98110E794;
	Wed, 13 Aug 2025 18:50:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aPdYRM2u";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2B110E792
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 18:50:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt4JTrksLZdg26HSt9+e3AlnlNW8G24SbExXgtHNSQja489aSeeGa0/rrXPQUWOwj5opX0XBQjgRjLFar6+0IESHpKD8yce4sr5yNn2+10p+almh4WVt4nsbzb7++F/zx68nIE8k5BAb/6p6XBCpJURo49QMkGkWVJbCrZ6U+wt0uxwy6l+NhuNJnV4pampUeMs9UBJquBJUNJmwIvcqk7/KAHgYZ1u/BFUqiwbu6LMdk+CDbvo/qqEbz1TYPjuaIDeQrRNeh4kD9klvNVfOpy19MUVI4aRkQWUqshu+wI8eQgpNfaojB9LHp0MCZucdiqLPCJKv52iLRbNAbeTE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TJO4hNx6dgqOxeDr6PQ8UoIsvT+P2npxdMv/nZbFy4=;
 b=NFW2STxns/Nh5YuwqIBag64fTqPK/OnL+w/3Q8dQOTuDAFLwGhccziCfxnCMcBRCW/Sp2qmJcpxsSFM2h0GPt8GdgY+h/j8AVsZhEt6CJt43Z2Nrqfx/7cfjG6NaWw0KjyqTRy9kf1oJmB2IClB3aRkxDDe8srdFHuGZOc4v4QctJHF6qnvn0Cd46ZC5OqXaM2ZQTt4yiOxCPSCAOFv0V5F4Wic9UPdw//N28OXMJZNlaI942VVScEurbbMaa/GIGXjMfC25RJTtkmJx4XDQm+mI2AIrCtsu9C3RCWkXlDOMA+Yg9c8cR229KCMzd4eJFd6GbBt1BiD43pQKKdcGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TJO4hNx6dgqOxeDr6PQ8UoIsvT+P2npxdMv/nZbFy4=;
 b=aPdYRM2uLOuusx4wuvvAnyRwMn0FC5N9I4N5yUB9Fkiv6q7VR2c9SOfOhVzyZJP2zNuynsl4mlQEkAx7Pff8JEVKqmlpvu2qcOpSfGtnUnxowAcXMoqImRrLzMucYEHCm5GHjRu9I2nDnNHkX4lqpF0I8GZStMEf5GsojK6OlZo=
Received: from SJ0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:a03:39c::9)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 18:50:13 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::3f) by SJ0PR03CA0334.outlook.office365.com
 (2603:10b6:a03:39c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 18:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 18:50:12 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 13:50:09 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v14 3/4] drm/amdgpu: Add mapping info option for GEM_OP ioctl
Date: Wed, 13 Aug 2025 14:49:52 -0400
Message-ID: <20250813184953.3666821-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813184953.3666821-1-David.Francis@amd.com>
References: <20250813184953.3666821-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: b81deac2-ac24-4cda-0f57-08ddda9a3c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Re12S81oJ6FnMP1mvvlGrP3VVBl5lweDNLH7jZOIC8KibbF/uGWJerD+oEDy?=
 =?us-ascii?Q?dwwrGSfuYtKXtaGJ/1DDUPU/lVqCxG6CZQHrbgG0DOS4oyQRujsQWRR/2gl/?=
 =?us-ascii?Q?ZLa5jyzv+tWgUeuNFfPvojVclNYoLGi+xStqeEYTnuG0xpRW2MhEWob+4Eqj?=
 =?us-ascii?Q?XbRTlR/Mwq6m0mYRpbYBkqfKNwq/K25dTOGf26UUg+FK87A7IbANLNewqCQK?=
 =?us-ascii?Q?kBjTl/mdagtzkfjlpVDp2NNL4BJtY3hElNuWAOhukhAqg8NF58rujMghsCp/?=
 =?us-ascii?Q?oi1Fnl4yhixxnWNlTzfSgC5EBZbUMZlpCPpf0+EWoW8vVidpqph8xa23Oa0z?=
 =?us-ascii?Q?aY9P6z5I5F1XJlY0nu9j+yx8vSUgtaGBaZHu2PIzdNpWkSM6eT8PAIXXqySD?=
 =?us-ascii?Q?ysPxrce/YaiYXL/9r16ehW1VLgA9kxdh/XFNP5j7OuYFGds/jrN/YuvSZ4LU?=
 =?us-ascii?Q?gE1NTtlIYUC8T8Y4RW0dzzb5U07droIcTahsWg8YEnW69Sc2j4Jp1yQZu6ZT?=
 =?us-ascii?Q?Zm3CCyR1uL30O6dcyPoTnnP6yk7e1l/D8UFRl9cuRoSw9kjcKVhNJlXaFKpo?=
 =?us-ascii?Q?aWhgyw5d2XDA7qXowGeGSIIXHkjAcVGiskn495vn2JZH+rbOEACoB8JzyMNo?=
 =?us-ascii?Q?lsdZqNN0qbbyxrSKWxdp/m3PxgNaMDaDdQasQoCyOLPMm7/jzOLPncgJlRF6?=
 =?us-ascii?Q?vUtGm3j/E36UJYC8LaxbPl3M5oW/tURnLEwAii6eIWhhKtCYwMZ9vIGfqSBs?=
 =?us-ascii?Q?FlqrFuQ9yOaJ3rKy618L2gyFMgnIjiZT0FyxOr+eJiM6GF2b2L87In0hEZ9K?=
 =?us-ascii?Q?kYQxLlSB5CY5ApTR/qe7adZhUJC4d028k9LGBI5aYSbdi/PosiAysc0LnsC6?=
 =?us-ascii?Q?IY7CcWNAgUI4xNI+ShI1WW11RZfBmEKf7ieeoPwKxrpTwdTCrE1YRRC1oXXH?=
 =?us-ascii?Q?MmpgmTBg7NrrIqLmXMZX8edVaLywDERyte4+A47nv2zlwlnQ50/7FT5AaLte?=
 =?us-ascii?Q?AdnhOxdfqx5rzYAGaHwzWKbFTsFb4crW3cmfngHlV3eK/Z5W+N8hjJGHBx0m?=
 =?us-ascii?Q?RRrsOISNpsXD73lOGG5imoePaGr89rv+8q9GDNxBt7S6mcSkTfMuKPPCxJ41?=
 =?us-ascii?Q?hg+KDdKZfMMKvcSKH3CpAOsPO0m96TXncJtzw9fDrJxByZM6IhYG1TCHh36d?=
 =?us-ascii?Q?dGo0FHRV5YcRif873QZX2r7rn3Hs/GIgwFTzaVt3tPOLWjdE2/UmhEW3IGCr?=
 =?us-ascii?Q?KlWkOE7jXLvFwe9ACfmeE2TFatlI54WE1XjNYD6HhzTcZtUAWxMpCkONT/7I?=
 =?us-ascii?Q?RDXATPIr9gCralwkFebYnImfClRvpt/b2259m3r29jEEFLdyndq9ia3vAusu?=
 =?us-ascii?Q?u0Pq6ZcXh3xSMYP9EYwV4K7j7tYj6jxPOMxD5i0+/AvjKaZYmL2yHqF/Dq+a?=
 =?us-ascii?Q?31r9+Qib83u4VSBZC7K+sEaqVi9Qpq2VZ+/rCIvTe6abn4ibRwN2T+KaOarL?=
 =?us-ascii?Q?f4BrziO+Pwsq7CJzOwGuykInyRF8uNac/L4K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:50:12.7360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81deac2-ac24-4cda-0f57-08ddda9a3c58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 87 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
 include/uapi/drm/amdgpu_drm.h           | 21 +++++-
 3 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d17cc7ba66d4..f66f6e1f1c52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -948,6 +948,89 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
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
+ * drm_amdgpu_gem_vm_entry stored at args->value.
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
+	struct drm_amdgpu_gem_vm_entry *vm_entries;
+	struct amdgpu_bo_va_mapping *mapping;
+	struct drm_exec exec;
+	int num_mappings = 0;
+	int ret;
+
+	if (args->padding)
+		return -EINVAL;
+
+	vm_entries = kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL);
+	if (!vm_entries)
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
+		ret = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (ret)
+			goto unlock_exec;
+	}
+
+	amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
+		if (num_mappings < args->num_entries) {
+			vm_entries[num_mappings].start = mapping->start;
+			vm_entries[num_mappings].last = mapping->last;
+			vm_entries[num_mappings].offset = mapping->offset;
+			vm_entries[num_mappings].flags = mapping->flags;
+		}
+		num_mappings += 1;
+	}
+
+	amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
+		if (num_mappings < args->num_entries) {
+			vm_entries[num_mappings].start = mapping->start;
+			vm_entries[num_mappings].last = mapping->last;
+			vm_entries[num_mappings].offset = mapping->offset;
+			vm_entries[num_mappings].flags = mapping->flags;
+		}
+		num_mappings += 1;
+	}
+
+	if (num_mappings > 0 && num_mappings <= args->num_entries)
+		ret = copy_to_user(u64_to_user_ptr(args->value), vm_entries, num_mappings * sizeof(*vm_entries));
+
+	args->num_entries = num_mappings;
+
+unlock_exec:
+	drm_exec_fini(&exec);
+	kvfree(vm_entries);
+
+	return ret;
+}
+
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
@@ -1014,6 +1097,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
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
index 59b423883e91..bc1e18c06ce4 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -802,6 +802,21 @@ union drm_amdgpu_wait_fences {
 
 #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
 #define AMDGPU_GEM_OP_SET_PLACEMENT		1
+#define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
+
+struct drm_amdgpu_gem_vm_entry {
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
@@ -809,8 +824,12 @@ struct drm_amdgpu_gem_op {
 	__u32	handle;
 	/** AMDGPU_GEM_OP_* */
 	__u32	op;
-	/** Input or return value */
+	/** Input or return value. For MAPPING_INFO op: pointer to array of struct drm_amdgpu_gem_vm_entry */
 	__u64	value;
+	/** For MAPPING_INFO op: number of mappings (in/out) */
+	__u32	num_entries;
+
+	__u32	padding;
 };
 
 #define AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT	(1 << 0)
-- 
2.34.1

