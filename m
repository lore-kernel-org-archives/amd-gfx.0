Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C04C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 14:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93F610E858;
	Thu,  7 Aug 2025 14:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IAglwzdo";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5788F10E856
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 14:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIkvqthVywoG0HWXFJP6dA7h0Yb/CMq3g7UAxHkFpz1/hgKLV9NteqcCHRGmH8tH+CZqggXGlvuGg8dF5FMC2FMtJi++Cjfr87kzLbBC0BJ8sE+SRQIn8/OXGHwZhDNFk07OywjIhuT02thkn91hVCoCOyl7sjRkuN6gLE4/kz19aCPuPBRylKgnyfUBBvUxTRtoHGCS4UOv8Si2ZqlZSKysqSpQvf3zRehuhirQO1fuazU2wZnV1YgtYlgZyutWpWSvIrl4/YzUjj0OseRKqgzWyxWGd94vTUUjkBiVpZHkz8Na1XsnXvTOmeByxWDAKIlMFfOXEpuTRNl0/g9M9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei3Ya1i8SwXriLguZdgxo/mXB4z/7Cibu8/hXikubz4=;
 b=lwV3VUYUH4J+xFoI7zGwK7UOPKH82UrA8119NZ96EHeyezdNl9vn0/m1Rxl21knWH4UiVzMNG8t7YuzxAg9kw0MS15GWrE/6BEJZIu2Yme+6EulwPqy1FM4DXHEOzQ809ZIwxX48DzSLYMfBHvrSGoAlru7VFT04mYBBBZCgSyHy9VOgG088G0LrbGv7KZtm0bcUXIHpOeVfp/029MYqGdsWoFpMYlz/WV0fMLjBo9vJ2/fqEyDae4MebTZ4dtWkjV2dGHGAAg3lOc3DUrJYjnFMsMfw66BvmmX5fijO+p+q2aqe+xT9nM7EyLrmSGWKjZzc7+ISHXW9p5/h4fLrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei3Ya1i8SwXriLguZdgxo/mXB4z/7Cibu8/hXikubz4=;
 b=IAglwzdo0BqGBJscUSQHgoYR7z1PXMWUvx/8WSreTfPi0/gq0ftdofNZY2zqCDtpPtSHPR2bUKmSPnyt2YkazsvQseVuJE5uKs7Z11RTlaGaeHdtY5VWxzAseTjJxjFpJq6+h9hZ1sKv//J+c+wETf75QGyyvOM3NhOgY2n4nAg=
Received: from BY3PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:39a::18)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 7 Aug
 2025 14:01:10 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::81) by BY3PR03CA0013.outlook.office365.com
 (2603:10b6:a03:39a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Thu,
 7 Aug 2025 14:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 14:01:10 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 09:01:09 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v10 2/3] drm/amdgpu: Add mapping info option for GEM_OP ioctl
Date: Thu, 7 Aug 2025 10:00:50 -0400
Message-ID: <20250807140051.2377470-3-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807140051.2377470-1-David.Francis@amd.com>
References: <20250807140051.2377470-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ac79fb-bba6-4578-0154-08ddd5badd22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1OnkceTE9SuzI46INVAy49NXhkCW4NeXZMumAGz2kvIC+zVR/b/OycKrfQ5u?=
 =?us-ascii?Q?mK6tjJBa/HgJEKWeinqe8yYlJM0/DOG+Lph5vyCgtdo1bhjYnJUdbfmPDv7v?=
 =?us-ascii?Q?s0m8jPJ6b8XwfsQq7huSfCw7wVY0dfRt4u1hQIhWLPqp6Y4a1VivtT9Rt6M6?=
 =?us-ascii?Q?1pbKMkGoQySmQLw9UwvAEz4SYDzb56RgT/OT9979b1rJAfzaG0G2zST7GXMC?=
 =?us-ascii?Q?b1z5qfwQdAn3G2GLmtDfkuipHieNBKd3I8iy8JM1bYHqS8Hj+2UulxNujr/J?=
 =?us-ascii?Q?xBMH74eQhfoEYnIDvgxI2FdLGWRCadZj9GUgsdKLiSBAhLkoWhlSmDomC29m?=
 =?us-ascii?Q?BuRPRMoLnCw/024Nz/PSZOx0kPZsDjy66zM+/pC0RpoQ8U3Wq7nZvhdBUTmz?=
 =?us-ascii?Q?cUuvWMHap41M/dEOlbYOkEVNwccvmiqP749AZS4RSoaD4scrxQNfbwPNK+dS?=
 =?us-ascii?Q?KL1PWr4M2A/HAkbUBS9H8DNodW7Ra7YKrrESc0B41YW88K+fjVn9ihj87/DL?=
 =?us-ascii?Q?S/FmOR2BZ92vYaqMwzRmWsOOTuEfZ+QdtDi5qzbd1vZTYVh9tOgWId63hQfK?=
 =?us-ascii?Q?9sr4qz5ZHTj1N97h6WJ8QA5O3aCNmekd0BYj2JteinXR1rt46lGzXqPlbK5h?=
 =?us-ascii?Q?7Ad6KXORvBd7MeqGVPxmE536hN0fwWlGsum0G6m3sN0QTULZ0g5atQ4KaPK9?=
 =?us-ascii?Q?QOnwS1YPRY8R7hmJ6VKPqRaOsxSBJhu/bET27tcikqUOYK4PzeRnHmu5iWdW?=
 =?us-ascii?Q?SI6WfREcnQTAgyoIiqeF+kXQgQtjXcbr/TEIrtpJPUmZwHYV48ttwMboFckh?=
 =?us-ascii?Q?41ox443wEQ0Dxgx4LFTY8RZMw8k6AvVzwwDqteomsJk0bk1uSmLRpLaKBUul?=
 =?us-ascii?Q?IXPNWA2pk2t4vLczeDetcC1niO8YQKztEuNpOHZC/1DDpgUXKqecaYz5d/N7?=
 =?us-ascii?Q?OidJe58iPuz4hNzWaN6pB0LIljZUbEBqaBfFDobIUiIqumTRwdIslMAvvJMj?=
 =?us-ascii?Q?XBigPsShJRsmb+Tu7JTz74/yWM5KhJ3An5L3YCoA8puVVyh7RMsKrMn/wYdl?=
 =?us-ascii?Q?9i9HGIJHSvdBlPcvGh31Qu4DMG0yI9XFY7TaUtv9Fx+gG41ynLCp9pYyldvd?=
 =?us-ascii?Q?40zXuuY2Ufrmh40V0Duay449XdmgLM7s3T5URg51OHtLY9bqKbAOLwYLm+ja?=
 =?us-ascii?Q?KT/fC8YylMGIu4KDmp3fF/6NAdmvCiDfh19Er/T3ogo3aikOfWvL/IYQZzgR?=
 =?us-ascii?Q?l5oKb4YlPnVKKnsDGe96NV8xPxNxq1OLkJhD+mjkO0diwRtOLLv+0pQpwZoO?=
 =?us-ascii?Q?FAL0xAvp9RYg/iZ7rzEh2xF7ti4niTc44TsONduDQgv9j/iWioBJAUvPfluT?=
 =?us-ascii?Q?+hBcwt03tNMwAFbSojdR1l6YO/hRtodHbrhbptPBKcCKPlMOWj27BunHNdtW?=
 =?us-ascii?Q?matfophZiPLe8Firm2dDxBKxBEajO0y4HFLz8cGDv7ZtNxMMOrZW63Bnwr3Y?=
 =?us-ascii?Q?m1blig7NzTERcYAV88N9Aw1n0bIHUN5J9wdo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 14:01:10.6218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ac79fb-bba6-4578-0154-08ddd5badd22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 97 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
 include/uapi/drm/amdgpu_drm.h           | 18 +++++
 3 files changed, 120 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index ec80b751e697..8bdb346f1761 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -956,6 +956,100 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+/**
+ * amdgpu_criu_mapping_info_ioctl - get information about a buffer's mappings
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
+	if (num_mappings > 0) {
+		if (num_mappings <= args->num_entries) {
+			ret = copy_to_user((void __user *)args->value, vm_buckets, num_mappings * sizeof(*vm_buckets));
+			if (ret) {
+				pr_debug("Failed to copy BO information to user\n");
+				ret = -EFAULT;
+			}
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
@@ -1022,6 +1116,9 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
 		amdgpu_bo_unreserve(robj);
 		break;
+	case AMDGPU_GEM_OP_GET_MAPPING_INFO:
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
index 1b3d2ba2f556..079e780dc20d 100644
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
 
 #define AMDGPU_GEM_BO_INFO_FLAG_IS_IMPORT	(1 << 0)
-- 
2.34.1

