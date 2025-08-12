Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D131ECA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 19:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3322410E62C;
	Tue, 12 Aug 2025 19:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IF1t4z/U";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 560D510E3D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 19:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPY4ceDGNqUr6KqzRCgjP3v0wm1v41OyLi5hdjgYUrJWG4PHGrMOtfOitFAlsblTI9KB/hG8Y/313Ap2T4Dz2vbHR2s3NWCs/vQkAdgDqG/9WMf/+8LW0le8u+kfCdff2gUNgWKt6JxBOK8YILPHBZgIi48Qop0J70j12KFIT9DbbRa8fdLgy3zBBYhkDpof1nkCIucRDVxq+kdsDxmyZCjoAtZO2jAmn1Hnj0o2wHXGUyZmastThatNqN3ywot9etzwof2mRvk4RTVhKzULiNEcn4neoFHpGb8blK+npSrdOmvIMGNm5GFzH92cq8U4vAxLWZ73wOmg0J8HG+077Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDNp5DSAPjO6krJz7hIfqA6Ovklzd3ioO/04YqNY138=;
 b=Cnz8JeqTOj/l8MgrvJ6Cm65abA8zP8olUuTVClAQuoUWGJPd3bdjsh6nYjadupRHkd5oXPS6OwQF8+wIWhYKV2ESdi9ysBc5LdaesqRvCoRXc6Mq/TOsGjngTSCewCxdxiNTCL12rai4W5O7gagu/drepsN10jME+ie9/AKxWfdLCfmxeVFIjyHu4IZptZLbzIFPzuu8NjgjJOC7ge4KLJnOK1TUv5K4M+v5jmvcIcGkjN4+gRfuaW42auVl0+pdol4EVdsYKJmUBpZBtcI2kTn2ErhAkIzwZlBryDAtkiuPGwLz3SNp8W/bXOlFoGZUVPYkfjuY0E8FxFzQOx57sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDNp5DSAPjO6krJz7hIfqA6Ovklzd3ioO/04YqNY138=;
 b=IF1t4z/UE0wcpmMqOgx86ko7iLrzVHMdUS4x/Wujl2T1jh+8vbtvL55aTaAbIRELEfPeEi/psQggFuaSdZ/WshZYSJ95OiRvFLkpKuTyTcdJL/cedBrYb0pTN8VbtIdR2c2RCH5Sr3/n4GBULBaVynYgyFGI1XSu97YXPhOvK+g=
Received: from SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 19:12:54 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a3) by SJ0PR05CA0030.outlook.office365.com
 (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 19:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 19:12:53 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 14:12:52 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v13 3/4] drm/amdgpu: Add mapping info option for GEM_OP ioctl
Date: Tue, 12 Aug 2025 15:12:30 -0400
Message-ID: <20250812191231.3534982-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812191231.3534982-1-David.Francis@amd.com>
References: <20250812191231.3534982-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: d11f7883-2847-46ad-b48d-08ddd9d43d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z/hei6vJj2IxpUfES3HT0zt8Ic9lH96ko8TZqR84+dtCQTKNMM81hBOxkv7G?=
 =?us-ascii?Q?PjrHhUpwAcRUsiVjyxZAuk1RlFB4k5XI2XoKT/VIIXZGnztAQqN4OmW6v5F7?=
 =?us-ascii?Q?+my4k+OcoG6955vXzw0TmDKWqbtHmSWWqiM5omOs4gkEjeO7ApH+/icxByNh?=
 =?us-ascii?Q?Dy4MyN7q126I6XUGYII9zPZO6z6voMtMsrAqjXnHs1jFMb+Ppo6IqQtyF6TM?=
 =?us-ascii?Q?sh/ohm/Sel8hi4iKBZ+lrhKi5mRLuWQ3+1/MrRXeYhvrbHzZq9vpMy01JY+w?=
 =?us-ascii?Q?CrVb/DUkwbcNDUxQ6G167hJCPHtIOB1gfk9mphZOh7xlCCTBV74e/g4X9vUX?=
 =?us-ascii?Q?NNr+yMzzz9PNfrIqCHVSpu16yZiXqwBbUxlzyLL7dBASvWGbM+AM96Ab3TLX?=
 =?us-ascii?Q?jNo+YXk0gRmFEX+UzXxl95zOn3E2AaHz+Dl2zwFWMTGJxu43gY9xYw5hYPSt?=
 =?us-ascii?Q?f9MS6yCg1l3k8iVKqZan+R60w18EqqhzG+4f+0Pb/vfirBkTwxBxa4kP0XKF?=
 =?us-ascii?Q?AxwumIITEaWE/RuaATO4W7Zmd+O5doFd62uNof2B2iyW0Ps8zCbyI94q0RgL?=
 =?us-ascii?Q?OUQEiUTciaDYtgFWn6PMulZNz10ZKcu+dxMOeJGm/RXK5ZLwtQbevslkVrKa?=
 =?us-ascii?Q?Sw1fBiHGgxXp+Sq2EOzwRikcUXz85I9af0G211TJIXQX4C8/Qo6aKqwrnoQp?=
 =?us-ascii?Q?ffXQlxvuNKkhcD/PsoBcZaiBFnh+xb4nwtjKDiBQob96NDdhHcd103I8BaJ/?=
 =?us-ascii?Q?KsbE+nshQbo7nhmGqyfFzHV+TElyaadU0MVZOy/z1lERCHGvm1Z12P/6WD7t?=
 =?us-ascii?Q?U71/3v0J3rbggrbqktxa0bID1ydxkefdC9e62CMxU9xuOtWV3+0Y7IylobKH?=
 =?us-ascii?Q?rtvy3DzOBUd7Uyk/i3ctyBsHz085bKkUtWS87YW1yhw+4n4hT6ww36g1ru/8?=
 =?us-ascii?Q?HXzQCTXVEpqNmwzvSpJwKNg7bnnWVhG1mVpJg5ezb1SwBTNx2l0jG4OHspdc?=
 =?us-ascii?Q?zk2eheEbxJjQO1Qhw9JRFXG7otO9rQOvkksoU5oS9gqwseNosQ0dnWBHnd/G?=
 =?us-ascii?Q?GMnmbAO15V/i5Axugrc3gHIWCcc8k4X0SyhuGKtITbu7CfzrUmvfRsqFIYa5?=
 =?us-ascii?Q?PbM/wolc6U+xfOtpobEbFTxZh6dPYq1UMaU1o6LQ00v5IlkArntnI0ZPEwKJ?=
 =?us-ascii?Q?EEUW9csYo81pQ7M0/2wdMCAYij4J3sqEyeVtRZvPiu9ijR9dL0K8ZpfJsO+G?=
 =?us-ascii?Q?iswPn+GQDV7TT6qSyO+PRRwls9t4sXHu5mpJei0jCKEfHDWJX7C5zbnzrKyD?=
 =?us-ascii?Q?YQvzDxHu+D0aE0UUBCpOCfpeoDLwtriW930a3Kv/7r5z0D06bQk5+M18BQ9R?=
 =?us-ascii?Q?Vf0xFVLarH9dCViFmNGbhFeHDUup2ckUP6UiFjf9ClGw1bNJu8YOBCo4l1LC?=
 =?us-ascii?Q?e4UH/exMHekbxZ6BAitp5NMNfHyzO1GE2E2TY4R9q9jrd2BWOnOeGW4aa+2e?=
 =?us-ascii?Q?eBqzWQHp5mW4WT6jr4KSNnrWXrD5V2vcoRnA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:12:53.5094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11f7883-2847-46ad-b48d-08ddd9d43d03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 84 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
 include/uapi/drm/amdgpu_drm.h           | 18 ++++++
 3 files changed, 107 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8b44d10a8b57..23a0545a0400 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -948,6 +948,86 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
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
+		ret = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
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
@@ -1014,6 +1094,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
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

