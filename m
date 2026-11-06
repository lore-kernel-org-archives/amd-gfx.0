Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAF606A31B
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wn+f6GqM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1D710E23C;
	Fri,  6 Nov 2026 04:51:36 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E23A10E27B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 04:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5X0IqtkSJhcKfvsO9lUgvp07w1pHElf2hxdTvjzf9jVtS+E5YvzUE5ZTf5bZlW8+ilBBMfB2BVGl4N1HThIanKLQb1ZK+OD8N3SDS/3q2dUzS5k/B0+AnP2X78YZ4Wi6vA8AcswiCnqsbkqFkVOFRbb4xt2D6IiDJkSDOuOjZHZiCX1XmmNgYiDzDE6UQevcJYfGCFrf+gL83+oHElKf/Fu3xvtCLW+MSkeRtckrmuZsHeqidgqsQoCWa9dvHv6ZzoPR7ZqKDmFg8g0V6hQvh9qHReGOu0ZmPcyV1cQpFalEe47Pd5ufNPPBgM2VMAqMaNvVZI3GDeOOso6M1O/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT9Q/wKQ7YsQtW3dheRB0zLbzLEBQBKN9mJTi1LdL0Y=;
 b=bpx3C/QpWxxJ2oH98jcXtQM9rntIcqkIhJRMLZNmBiZbJY9Wlig2GOvDZXNvyLo15SMg5Y2oPeVinBxgQ1iCVedLW60ux0f7lHykxLZ0/HtGsnJwhR5SM8MTqzfLd5QUqFDgK36wPTaN8J6VVxfypp7ksQd4ttu8YKjf++JDSn0UkoxLC0qOqFCAkoXdICGmV2Fo5Zoww5taTzS73TvbPbwrpzkgusbMcYn6hW/NaxfnHTKUbL/WQiGiAMDqz7nmzlLqsICYCzISXT0wMUCLVZFkIHQmv05I9zqN+BL6tBbc9fs1+LpkopTX5jTDit6Fc3dBtmGTUa7Clxw4L0nlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT9Q/wKQ7YsQtW3dheRB0zLbzLEBQBKN9mJTi1LdL0Y=;
 b=Wn+f6GqMSoQK6TTjR3czX5ysJbMdcaEH1RaoqDWQ33I3Lw0DcAu1bY4rCMEYvN5+kBTd2t2RcYd0QMawFfklPspJ+QrnpSXVZRSBXwdtqguG7/NkQGoLXSKdRB6i3lCO4/JSeONzsQ0h5Jk+96Hcj7DD0SzS0OrgwT5vQy5EfdI=
Received: from CH0PR04CA0053.namprd04.prod.outlook.com (2603:10b6:610:77::28)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:51:23 +0000
Received: from CH01EPF000BE945.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::71) by CH0PR04CA0053.outlook.office365.com
 (2603:10b6:610:77::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:51:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE945.mail.protection.outlook.com (10.167.244.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:51:22 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 5 Nov 2026 22:51:20 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Lijo Lazar <lijo.lazar@amd.com>, "James
 Zhu" <James.Zhu@amd.com>
Subject: [PATCH v4 2/7] drm/amdgpu: Integrate CWSR with user queues
Date: Fri, 6 Nov 2026 10:20:56 +0530
Message-ID: <20261106045101.1562366-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106045101.1562366-1-srinivasan.shanmugam@amd.com>
References: <20261106045101.1562366-1-srinivasan.shanmugam@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE945:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2bb840-e219-4b66-9968-08df3bc19b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|261022105027099003|56012099006|261021123027099003|261028144727099003|261102123227099003|261021121427099003|261009223027099003|261022075727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: CP8huq6+K8CQGXQFhD3GRTp0yGk6XbiEj1CwF97DRu99F0ng01Ajnls24z1fbB8YlTawWg47gM6CSXe3of0bvsM3KkfMZNRS16Gcl31iqZ/RJAwRNfYcfo8TFw1G3JF8xDBqHwPJ6/psIBgLX6Wdpd5pUXn+P+A4VL3ivXKOHESXnrpT+G+HL6kZNpNF8vHoojmXpQfQc2PdXHvO/ntg6hvhxFp1S8q87rntT0Nn+mFCTEBYKgzAp/Z+RlS3ABgTZnlipKw8qI+MY5qO+ppPfkl5bx8hBXmfPosQYh/+fC0ekJHiz+5wqXRX84n8hbkb9yO37EQD+rZdl3zK1HwJ/t7fA534HTouAzjT/GuuMMPC+bJjxvqWItCLFHk9e1GmK5X+zjcDZ2Q3V8yiHctjKyrf9esqVeVbwqFh55Zo50ThhhUkUoUcVvSSDhudGlp4vy4JOZoUIZBZuf5aeZ07V6w+UFU2ZVrLDXJLi2PKfTtrz4NvrcIX9Uw88duY5WVfuR05s7V4uWD5TP3FJdcQ4RwEDPgEq9JWEjew/h8zzyptp7Wc8cotfMuTxbRWPCIs3HnYAjjrkANh+3mZ0U7lfu8IGv4lU80Ao5Z/4pwQWYVsGcoOV7Pg0CBjZv/Mrcn5EOVsUM+51nfDKc8lOBj9nftgeFZUx9q8dzEP8tNkQNdd5T8/4LtlI5/+JLxNYVVgcvsiumCb+g/ZLISYmPWKBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(261022105027099003)(56012099006)(261021123027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003)(261022075727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lP8bFU370n04TGrfeOo5b05juEGCY0seYE4bKgQlDwsHOS1uCS7AANQ/HXnajjH0VuJAOaA+PGDMg5rxWHAFemr01EZOM5VYvj/rT0n3sOBgaQfrmdfseiKECtp+VH0xnmsSFbqwthBHOhBmUjztvXz3wyRze30rBSj8OqOSwMgBt5EHWlSN3YbRXuc2z/KlLlBd2NMmBApooZqnJNF3/HKY/wXkvdZo1YCzEavQhRnsDlMJoswMNewZ2IPLpEc04c6xFQZFUMLnu6cIks15APVk375nV55+ZHB3Ujc1K/eZNtcvYfo679+1P1QmaMi7F06YFUpwkNaKjFQUz/6QaosYL5JaUtRtqfGXtYZ3nfjAHj5QuGP+RMadhlghHqBGTtZXKsdHd63/ZvCuVjJxAPFEkFyKEEeJ1DEhmNb/oF4MMRsAqsAQON99tRkwSWLI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:51:22.7194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2bb840-e219-4b66-9968-08df3bc19b28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE945.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lijo Lazar <lijo.lazar@amd.com>

Initialize the CWSR handler during device initialization and release
the associated resources during device teardown.

Add a per-file CWSR trap object for render-node user queues and map the
first-level CWSR trap handler into the GPUVM associated with the file.
Use the mapped TBA and TMA addresses when programming user queues.

Add user save area parameters to the MQD properties for compute queue
creation and validate the parameters before using them for MQD
initialization.

The CWSR parameter validation walks the VM mapping tree and updates the
user queue VA mapping state. Reserve the VM root BO around the
validation so the required VM reservation is held while accessing the
mapping tree.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c   |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h   |   6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  10 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  25 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  14 +++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 102 +++++++++++++++++----
 10 files changed, 172 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ff8610aa2184..a444f0e091f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -332,6 +332,7 @@ struct amdgpu_reset_control;
 struct amdgpu_coredump_info;
 struct amdgpu_video_codecs;
 struct amdgpu_cwsr_isa;
+struct amdgpu_cwsr_trap_obj;
 
 enum amdgpu_cp_irq {
 	AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP = 0,
@@ -420,6 +421,7 @@ struct amdgpu_fpriv {
 	struct xarray		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
 	struct amdgpu_userq_mgr	userq_mgr;
+	struct amdgpu_cwsr_trap_obj *cwsr_trap;
 
 	/* Eviction fence infra */
 	struct amdgpu_eviction_fence_mgr evf_mgr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
index 345d7bcddea3..daca0a1ac990 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
@@ -395,6 +395,7 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	if (!amdgpu_cwsr_is_enabled(adev))
 		return -EOPNOTSUPP;
+
 	if (!vm || !trap_obj)
 		return -EINVAL;
 
@@ -403,12 +404,15 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -ENOMEM;
 
 	bo = adev->cwsr_info->isa_bo;
+
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
 			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
+
 		drm_exec_retry_on_contention(&exec);
+
 		if (unlikely(r)) {
 			dev_err(adev->dev,
 				"failed to reserve for CWSR allocs: err=%d\n",
@@ -455,17 +459,21 @@ int amdgpu_cwsr_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	drm_exec_fini(&exec);
+
 	*trap_obj = cwsr;
 	return 0;
 
 err_kmap:
 	amdgpu_bo_kunmap(cwsr->tma_bo);
+
 err_tma:
 	amdgpu_bo_unref(&cwsr->tma_bo);
+
 err_exec:
 	drm_exec_fini(&exec);
 	kfree(cwsr);
 	*trap_obj = NULL;
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
index 297a4ff04730..65a0d2852fb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
@@ -79,4 +79,10 @@ uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int num_xcc);
 int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
 				struct amdgpu_cwsr_params *cwsr_params,
 				int num_xcc);
+static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
+{
+	u32 gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+
+	return gc_ver >= IP_VERSION(11, 0, 0) && gc_ver <= IP_VERSION(11, 0, 3);
+}
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9326f811c500..75f7d50da62a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -81,6 +81,7 @@
 #include "amdgpu_reset.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_dev_coredump.h"
+#include "amdgpu_cwsr.h"
 
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
@@ -2547,6 +2548,14 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	amdgpu_fru_get_product_info(adev);
 
 	r = amdgpu_cper_init(adev);
+	if (r)
+		goto init_failed;
+
+	r = amdgpu_cwsr_init(adev);
+	if (r == -EOPNOTSUPP)
+		r = 0;
+	else if (r)
+		goto init_failed;
 
 init_failed:
 
@@ -2951,6 +2960,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 {
 	int i, r;
 
+	amdgpu_cwsr_fini(adev);
 	amdgpu_cper_fini(adev);
 
 	if (amdgpu_sriov_vf(adev) && adev->virt.ras_init_done)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 14a72a406d37..fe5e505c6f2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -49,6 +49,8 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_video_codecs.h"
 #include "amdgpu_ras_mgr.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_cwsr.h"
 
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
@@ -1580,6 +1582,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			 r);
 
 	amdgpu_evf_mgr_init(&fpriv->evf_mgr);
+
+	r = amdgpu_cwsr_alloc(adev, &fpriv->vm,
+			      &fpriv->cwsr_trap);
+	if (r == -EOPNOTSUPP)
+		r = 0;
+
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
@@ -1649,6 +1657,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	}
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
+	amdgpu_cwsr_free(adev, &fpriv->vm, &fpriv->cwsr_trap);
 
 	if (pasid)
 		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 652cd0950453..2dc918c0bd74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -552,6 +552,14 @@ struct amdgpu_mqd_prop {
 	uint32_t cu_mask_count;
 	uint32_t cu_flags;
 	bool is_user_cu_masked;
+	bool aql_queue;
+	u32 queue_percentage;
+	/* used in gfx9 and gfx12.1 */
+	u32 pm4_target_xcc;
+	/* cwsr params */
+	u64 ctx_save_area_addr;
+	u32 ctx_save_area_size;
+	u32 ctl_stack_size;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ccf0ff490ac2..39673164ce7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -35,6 +35,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_userq_fence.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_cwsr.h"
 
 u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 {
@@ -265,6 +266,30 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 	return -EINVAL;
 }
 
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params)
+{
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(queue->userq_mgr);
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	u32 cwsr_size;
+	int num_xcc;
+	int r;
+
+	num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr, fpriv->xcp_id);
+	r = amdgpu_cwsr_validate_params(queue->userq_mgr->adev, cwsr_params,
+					num_xcc);
+	if (r)
+		return r;
+	cwsr_size = amdgpu_cwsr_size_needed(queue->userq_mgr->adev, num_xcc);
+	if (!cwsr_size)
+		return -EOPNOTSUPP;
+
+	return amdgpu_userq_input_va_validate(
+		adev, queue, cwsr_params->ctx_save_area_address, cwsr_size,
+		&queue->userq_vas.va.cwsr);
+}
+
 static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
 {
 	struct amdgpu_bo_va_mapping *mapping;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..727f60c40bbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -41,6 +41,7 @@ enum amdgpu_userq_state {
 };
 
 struct amdgpu_mqd_prop;
+struct amdgpu_cwsr_params;
 
 struct amdgpu_userq_obj {
 	void		 *cpu_ptr;
@@ -97,8 +98,9 @@ struct amdgpu_usermode_queue {
 			u64 eop;
 			u64 shadow;
 			u64 csa;
+			u64 cwsr;
 		} va;
-		u64 va_array[6];
+		u64 va_array[7];
 	} userq_vas;
 
 	uint32_t	gang_ctx_array_index;
@@ -200,4 +202,8 @@ int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 
 void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
 					struct amdgpu_bo_va_mapping *mapping);
+int amdgpu_userq_input_cwsr_params_validate(
+	struct amdgpu_usermode_queue *queue,
+	struct amdgpu_cwsr_params *cwsr_params);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index cb15dad0e57b..914bba4a553a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3233,6 +3233,20 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set CU mask */
 	gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 
+	/* If non-zero, assume cwsr is enabled */
+	if (prop->ctx_save_area_addr) {
+		mqd->cp_hqd_persistent_state |=
+			(1 << CP_HQD_PERSISTENT_STATE__QSWITCH_MODE__SHIFT);
+		mqd->cp_hqd_ctx_save_base_addr_lo =
+			lower_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_base_addr_hi =
+			upper_32_bits(prop->ctx_save_area_addr);
+		mqd->cp_hqd_ctx_save_size = prop->ctx_save_area_size;
+		mqd->cp_hqd_cntl_stack_size = prop->ctl_stack_size;
+		mqd->cp_hqd_cntl_stack_offset = prop->ctl_stack_size;
+		mqd->cp_hqd_wg_state_offset = prop->ctl_stack_size;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59..108dced28f97 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -27,6 +27,7 @@
 #include "mes_userqueue.h"
 #include "amdgpu_userq_fence.h"
 #include "amdgpu_trace.h"
+#include "amdgpu_cwsr.h"
 
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
@@ -120,6 +121,7 @@ static int convert_to_mes_priority(int priority)
 static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
 	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
@@ -151,24 +153,37 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
 	queue_input.wptr_mc_addr = queue->wptr_obj.gpu_addr;
 
+	if (fpriv->cwsr_trap) {
+		queue_input.tba_addr = fpriv->cwsr_trap->tba_gpu_va_addr;
+		queue_input.tma_addr = fpriv->cwsr_trap->tma_gpu_va_addr;
+		queue_input.trap_en = !amdgpu_cwsr_has_dbg_wa(adev);
+	}
+
 	if (mes->use_rs64mem) {
 		if (!uq_mgr->proc_ctx_allocated) {
-			r = amdgpu_mes_alloc_proc_ctx_index(mes, &uq_mgr->proc_ctx_array_index);
+			r = amdgpu_mes_alloc_proc_ctx_index(mes,
+							    &uq_mgr->proc_ctx_array_index);
 			if (r) {
-				DRM_ERROR("Failed to allocate userq process index err:%d\n", r);
+				DRM_ERROR("Failed to allocate userq process index err:%d\n",
+					  r);
 				return r;
 			}
 			uq_mgr->proc_ctx_allocated = true;
 		}
 
-		r = amdgpu_mes_alloc_gang_ctx_index(mes, &queue->gang_ctx_array_index);
+		r = amdgpu_mes_alloc_gang_ctx_index(mes,
+						    &queue->gang_ctx_array_index);
 		if (r) {
 			DRM_ERROR("Failed to allocate userq gang index err:%d\n", r);
 			return r;
 		}
-		queue_input.process_context_array_index = uq_mgr->proc_ctx_array_index;
-		queue_input.gang_context_array_index = queue->gang_ctx_array_index;
+
+		queue_input.process_context_array_index =
+			uq_mgr->proc_ctx_array_index;
+		queue_input.gang_context_array_index =
+			queue->gang_ctx_array_index;
 	}
+
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
@@ -179,7 +194,9 @@ static int mes_userq_map(struct amdgpu_usermode_queue *queue)
 
 	amdgpu_mes_userq_queue_mapped(adev);
 
-	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
+	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n",
+			 userq_props->doorbell_index);
+
 	return 0;
 }
 
@@ -403,6 +420,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
 		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
+		struct amdgpu_cwsr_params cwsr_params;
 
 		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
 			DRM_ERROR("Invalid compute IP MQD size\n");
@@ -410,7 +428,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
-		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					  mqd_user->mqd_size);
 		if (IS_ERR(compute_mqd)) {
 			r = PTR_ERR(compute_mqd);
 			goto free_mqd;
@@ -421,6 +440,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(compute_mqd);
 			goto free_mqd;
 		}
+
 		r = amdgpu_userq_input_va_validate(adev, queue,
 						   compute_mqd->eop_va, 2048,
 						   &queue->userq_vas.va.eop);
@@ -432,29 +452,63 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
 		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
-		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
+		userq_props->hqd_queue_priority =
+			AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
 		userq_props->hqd_active = false;
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
+
+		if (amdgpu_cwsr_is_enabled(adev)) {
+			struct amdgpu_fpriv *fpriv =
+				uq_mgr_to_fpriv(queue->userq_mgr);
+			int num_xcc;
+
+			num_xcc = amdgpu_xcp_get_num_xcc(adev->xcp_mgr,
+							 fpriv->xcp_id);
+			cwsr_params.ctx_save_area_address =
+				userq_props->ctx_save_area_addr;
+			cwsr_params.cwsr_sz =
+				userq_props->ctx_save_area_size;
+			userq_props->ctl_stack_size =
+				adev->cwsr_info->xcc_ctl_stack_sz * num_xcc;
+
+			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
+
+			r = amdgpu_userq_input_cwsr_params_validate(
+				queue, &cwsr_params);
+			amdgpu_bo_unreserve(queue->vm->root.bo);
+			if (r) {
+				kfree(compute_mqd);
+				goto free_mqd;
+			}
+		}
+
 		kfree(compute_mqd);
 	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
 		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
 		struct amdgpu_gfx_shadow_info shadow_info;
 
 		if (adev->gfx.funcs->get_gfx_shadow_info) {
-			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
+			adev->gfx.funcs->get_gfx_shadow_info(adev,
+							     &shadow_info, true);
 		} else {
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
+		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) ||
+		    !mqd_user->mqd) {
 			DRM_ERROR("Invalid GFX MQD\n");
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					  mqd_user->mqd_size);
 		if (IS_ERR(mqd_gfx_v11)) {
 			r = PTR_ERR(mqd_gfx_v11);
 			goto free_mqd;
@@ -470,7 +524,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(mqd_gfx_v11);
 			goto free_mqd;
 		}
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
+
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_gfx_v11->shadow_va,
 						   shadow_info.shadow_size,
 						   &queue->userq_vas.va.shadow);
 		if (r) {
@@ -479,7 +535,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			goto free_mqd;
 		}
 
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_gfx_v11->csa_va,
 						   shadow_info.csa_size,
 						   &queue->userq_vas.va.csa);
 		amdgpu_bo_unreserve(queue->vm->root.bo);
@@ -492,13 +549,15 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
 		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
 
-		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
+		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) ||
+		    !mqd_user->mqd) {
 			DRM_ERROR("Invalid SDMA MQD\n");
 			r = -EINVAL;
 			goto free_mqd;
 		}
 
-		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
+		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd),
+					   mqd_user->mqd_size);
 		if (IS_ERR(mqd_sdma_v11)) {
 			r = PTR_ERR(mqd_sdma_v11);
 			goto free_mqd;
@@ -509,7 +568,9 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 			kfree(mqd_sdma_v11);
 			goto free_mqd;
 		}
-		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
+
+		r = amdgpu_userq_input_va_validate(adev, queue,
+						   mqd_sdma_v11->csa_va,
 						   32,
 						   &queue->userq_vas.va.csa);
 		amdgpu_bo_unreserve(queue->vm->root.bo);
@@ -524,7 +585,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 
 	queue->userq_prop = userq_props;
 
-	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+	r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr,
+				     userq_props);
 	if (r) {
 		DRM_ERROR("Failed to initialize MQD for userqueue\n");
 		goto free_mqd;
@@ -533,7 +595,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	/* Create per-process MES process context BO */
 	r = mes_userq_create_proc_ctx_space(uq_mgr);
 	if (r) {
-		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n", r);
+		DRM_ERROR("Failed to allocate MES process context space bo, error: %d\n",
+			  r);
 		goto free_mqd;
 	}
 
@@ -545,7 +608,8 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	}
 
 	/* FW expects WPTR BOs to be mapped into GART */
-	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue, userq_props->wptr_gpu_addr);
+	r = mes_userq_create_wptr_mapping(adev, uq_mgr, queue,
+					  userq_props->wptr_gpu_addr);
 	if (r) {
 		DRM_ERROR("Failed to create WPTR mapping\n");
 		goto free_ctx;
-- 
2.34.1

