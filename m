Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B29CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Aug 2025 19:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E31410EBA0;
	Fri, 22 Aug 2025 19:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3CmS+Rsx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674ED10EB9B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Aug 2025 19:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wla6AfVCTpbl89uqOFajptxSHZ4xnhQJV1QHhJEUwi+Vo8u7ZW34hn4ZryxLpA3Uh/vCOJQgETitaBodRPWszgormQtTq84KDW0x9Yd5BRTVtFJVfHVOslTRzPFDcj2ly/yWqOJ6nGuRUNG18Urvok5kekEbxV/rsxyUuGh67omCv7UqgMT87U2AYBoRnlW58mJHja3Doje+loSbUjOYHEUgI1xNXsCrAyIjpfe+bTmQ9cXki9+PET8BX7VNMfxucWHyOpd6vhQVSqa+yzNkUOgDUwNMhj83AECpRx8X9NCZJ96SPNRUEbaVIAaqVZ2DEm0THMw7SgWNVWX7jwijzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bm5WnZFinIGg6ek+iGB0fWvwCvdNFSlt5nntMmC1I0w=;
 b=EV6nqSczAJgryNdk2eV7a1ppydER/10PTyZOvSfVLXFdcEmK7qi+t4nKij4Ixq43ICpnyOZs7is6ZhXBm/oii+gXGa4qfllRvEHhUqsHfxdCDdqa8sTbtub7BBT7g4ivZ8LQ4ORox/1OJDsXXY6HRQh3X1XETdSMhw9Xnvl5DxPUkxC+PTin7m5OHjYGP0KGoFNQZk6MqpGRPt+xZG2DrroljsPLnHMJk2pXU91VsiiM7DhxMSRXdSnCAAKVQm269y4YqmaO/LG5dBKKs8wQFGkjYsjPE/V5Xr6u+cXMuBfAy0RPCpxpsGjvKJw1m2Us9B5M+5FfjIslvtQl3+S2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bm5WnZFinIGg6ek+iGB0fWvwCvdNFSlt5nntMmC1I0w=;
 b=3CmS+Rsxl7M9WAvAMlxY1D4s0sCeNxGZB8G8pcLtCbsg+A3S0w7+WWxszrq426OTF0L4fDljgFAc4I4FZfiBp2VKadoNckytR5dyJq/CTexSIK6pTNDOhxaZrdYsW0fcNnzIhvSYROZ0J14EagO3YfA5Iw1BeR6DRPnXonw2TzI=
Received: from SJ0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:33b::26)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 22 Aug
 2025 19:48:15 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:33b:cafe::7f) by SJ0PR05CA0021.outlook.office365.com
 (2603:10b6:a03:33b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.8 via Frontend Transport; Fri,
 22 Aug 2025 19:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Fri, 22 Aug 2025 19:48:15 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:48:08 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH v15 3/4] drm/amdgpu: Add mapping info option for GEM_OP ioctl
Date: Fri, 22 Aug 2025 15:47:48 -0400
Message-ID: <20250822194749.362771-4-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822194749.362771-1-David.Francis@amd.com>
References: <20250822194749.362771-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: e2aed4fd-8626-4a8a-9427-08dde1b4d5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+jOVhLb48UqrrPw5wsNcdtMYViWSwBPbWqIrUE2GqCvUNP5OaOzu0Q9q8vBg?=
 =?us-ascii?Q?uU547MVrcsCWWsFVig+AAa6wcxUf8JTOPeNTCNDGy6rZTsVZMwyHQIpv/lXx?=
 =?us-ascii?Q?C6b10NrOUYhhzWUS+ebvFgk23BClyoq3+GuGtEhPoGlwZuh2OLgZ9azBC0yu?=
 =?us-ascii?Q?aYn1L3F7V3OHOxkJi4yWnwlNSyMuewtYqUDrBAFeh00XaDf3ZC7vioCNqMQX?=
 =?us-ascii?Q?WC5sIzj/IW5N/mFP8yHZmNzJ1VpVpyWcVrwDaOFQGJbQnlCQvqp1NuncXxaP?=
 =?us-ascii?Q?qpkPjMKqLuIsmKO8x4+qRWKIqRc9J2IzgG0kiKogRzTS9NyCo1xNvBvf3hjs?=
 =?us-ascii?Q?Kfz+aL+/5lngIeTMh0iR7YKoL0Z0DsI5B5IvgGx9AmqsszX8Z+56TOiuU6gv?=
 =?us-ascii?Q?5d6QN+gWEiNUSiGvTTbQ9zuv1TcYxdqpcz10vomH7QPRbUkhSsd8uGPSs9TX?=
 =?us-ascii?Q?qJYq2vn/7fY/v5pG0frQj4KlzgUFB/G+5DQ0glYdxcpWZvaI29NDFWAkUHvG?=
 =?us-ascii?Q?QmP1Bf8KclVKNzUFq+mhN83D3IYYrJsFVTY2qzEdEnsHHDHCqEuSk1YTD+uA?=
 =?us-ascii?Q?NCynuHBBFIU3M6b2AgAH7nxwe5vdiIgmpyTcI4B8bfZGQv31L9GrxmFwc7CN?=
 =?us-ascii?Q?hn/J0R8fJWLvC93sDUqFCPq0cipwptKlG8cn3XBuGSFNgrd3L485j2/4S/MO?=
 =?us-ascii?Q?uBIJ/Y8jj+OpTj3iC1rkix7IxvqbF0zEabj8OeRvqeDRq5j2c3quzr36eweI?=
 =?us-ascii?Q?Cj+2IxL6SyEscnh08dqcb9EsNCSr1g5g7m/Yj8JcoJniqx7n6tpujAKdkjrJ?=
 =?us-ascii?Q?RJL4+OE3nqvk4Hm51vf+cTRSgD4Ck+9+YKHE2wQp9DRtrH7APisCeRNmc4Iq?=
 =?us-ascii?Q?o3/UdTNqHQLoh49JHam34f8X42+S0sVeKGhPtt3k/OiYL2hoHtimjRJi9R0W?=
 =?us-ascii?Q?5dF7k66PQfLAnGeU2hgZ3V3wqB02l9MpZXP3R41AAKNWh/SEigPkYxBODcV6?=
 =?us-ascii?Q?vAIuNulcylhqogoETtR5AEW29vCC8I+vvbOYIwzLwTeTTKz3pLgqrgXUiDiQ?=
 =?us-ascii?Q?gvKEn7LEBTvNqPhM2zDaUkvIjr2G/ombtRZGGrlsqaB8vsEZKKsDrM6Sn4LB?=
 =?us-ascii?Q?hdL9ax7CDKOueJWYGPiDRvhk4QrlpYuBaf8LG6uCXsIXrsmNFonCHUTHkVNE?=
 =?us-ascii?Q?wqpAUu9Bq4YmxpEffFIZRJ71yWaa6i/DvTTCIedCFvUkCN/qI0jHfMXzebEZ?=
 =?us-ascii?Q?7AOESbZE24gBvhdgD0Rls1tX6NPhDJJOc5AMb7GIpu/jgSIBXH0L6WM1mQSt?=
 =?us-ascii?Q?XA2rc1yqaMLeU436UfqtWVyWJuxcjWe43dnqXplGoUusOf31ihczF40qFxQg?=
 =?us-ascii?Q?OaBdWHeD5xQZZphQXT3rRdAFSi2VIQQ6Lr9MBIuqUyTGAcbxywaSeLTnwe83?=
 =?us-ascii?Q?8MmYjdAP8OlIzSQBan2ulYbwSF9UGO8H056Pw34yUmSGoTOqv5UGByoobjg9?=
 =?us-ascii?Q?RbYMhKBmTCskzUY4OIAQfNX4RrfWljlupmpL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 19:48:15.2192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2aed4fd-8626-4a8a-9427-08dde1b4d5c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 98 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 ++
 include/uapi/drm/amdgpu_drm.h           | 21 +++++-
 3 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e6741d6c9a55..15d588f7acdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -948,6 +948,70 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
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
+	amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
+		if (num_mappings < args->num_entries) {
+			vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
+			vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
+			vm_entries[num_mappings].offset = mapping->offset;
+			vm_entries[num_mappings].flags = mapping->flags;
+		}
+		num_mappings += 1;
+	}
+
+	amdgpu_vm_bo_va_for_each_invalid_mapping(bo_va, mapping) {
+		if (num_mappings < args->num_entries) {
+			vm_entries[num_mappings].addr = mapping->start * AMDGPU_GPU_PAGE_SIZE;
+			vm_entries[num_mappings].size = (mapping->last - mapping->start + 1) * AMDGPU_GPU_PAGE_SIZE;
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
+	kvfree(vm_entries);
+
+	return ret;
+}
+
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
@@ -955,6 +1019,8 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
 	struct amdgpu_bo *robj;
+	struct drm_exec exec;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	int r;
 
 	gobj = drm_gem_object_lookup(filp, args->handle);
@@ -963,9 +1029,27 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
 	robj = gem_to_amdgpu_bo(gobj);
 
-	r = amdgpu_bo_reserve(robj, false);
-	if (unlikely(r))
-		goto out;
+	if (args->op == AMDGPU_GEM_OP_GET_MAPPING_INFO) {
+		drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
+				  DRM_EXEC_IGNORE_DUPLICATES, 0);
+		drm_exec_until_all_locked(&exec) {
+			if (gobj) {
+				r = drm_exec_lock_obj(&exec, gobj);
+				drm_exec_retry_on_contention(&exec);
+				if (r)
+					goto out_exec;
+			}
+
+			r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
+			drm_exec_retry_on_contention(&exec);
+			if (r)
+				goto out_exec;
+		}
+	} else {
+		r = amdgpu_bo_reserve(robj, false);
+		if (unlikely(r))
+			goto out;
+	}
 
 	switch (args->op) {
 	case AMDGPU_GEM_OP_GET_GEM_CREATE_INFO: {
@@ -1014,6 +1098,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 
 		amdgpu_bo_unreserve(robj);
 		break;
+	case AMDGPU_GEM_OP_GET_MAPPING_INFO:
+		r = amdgpu_gem_list_mappings(gobj, fpriv, args);
+		drm_exec_fini(&exec);
+		break;
 	default:
 		amdgpu_bo_unreserve(robj);
 		r = -EINVAL;
@@ -1022,6 +1110,10 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 out:
 	drm_gem_object_put(gobj);
 	return r;
+out_exec:
+	drm_exec_fini(&exec);
+	drm_gem_object_put(gobj);
+	return r;
 }
 
 /**
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
index e5d1c24cabcb..2e7a4e599e5b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -802,6 +802,21 @@ union drm_amdgpu_wait_fences {
 
 #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
 #define AMDGPU_GEM_OP_SET_PLACEMENT		1
+#define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
+
+struct drm_amdgpu_gem_vm_entry {
+	/* Start of mapping (in bytes) */
+	__u64 addr;
+
+	/* Size of mapping (in bytes) */
+	__u64 size;
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

