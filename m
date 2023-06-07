Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC68C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 10:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B4D10E4AF;
	Wed,  7 Jun 2023 10:58:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9DB10E0DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 10:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3pcRSlOD+o4i2lAuf9MS4zG6MXJRdPn3PuSU8uFXmyLWMA4yvIQn2MWqaFd5ERevlsu54Ndt5dtpjCxYXSlt6SzJnWV5t3cKhcQofVajxALUl9QPbSXvquFTkvrb2YayNMj9Y0Vt7Oaen1Keoxvo0b6BhK+auLCed0QN7rU9BOHd8zBXANADXJx6ZoJ52wApqqTfLgb4GCwwPQEQJbunXZUzyERM9EbQKS8RWY+WIRK8mYTyMJK2q6lXR9Q71BFVKFOkQHlaI6WHysk/jPM7K3Oh5UE7+qVVZEMdLpG55I+QMa1/KmkWZUxNzzbZFuK4DZTwGr5CTEy+HQ75v797g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpFsClLynxy1wNthGpcPZA3vbJ9a5WR98NuqgflVDAc=;
 b=ceM0vEbECUN5mK3KM+Pd3c6E8AJONZF4KggCLheE8oAFcnXm1UoCZr4YJn+/4hpEtzDE6mvYWt7tqjnf98MFiZgMaKgz3BQv4c4dq4uKbnGuL1RrpYRT+ARe+xjaOKY+EGJNC9eFi/pW6PKyzzDVyqmjUY4KtIcNFFSP4um97u4b8I4TB8VHSyjc/ZamjbRW+FOS1QtObiC/6SAUCdz9UH5FCnqhffR/ZCQiolO44WIFtAJhntTNlFN2MPFnZzCi5IOrPAdv+/vqCpkickTDMVHq8K+HxFpDkocudo+WY4SnPTHa1mF/lFzyhci9rQFjST2rvGcxYC1nVxK3CRui+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpFsClLynxy1wNthGpcPZA3vbJ9a5WR98NuqgflVDAc=;
 b=FT4CwZjvjmjcKIY8c3oKyXFAGahGVFB9Uuhl1J626oK/RtQwHDQqxI/blza+29xonb4Pk4Xi9yvvThnYdv9b8saOOSnBK9GW8AlsFkkTuTCd5RzugHDVQjXcyBqC5T0NapR+yUjN+BbbYJRKDw0XWBD8G+y/jVrlNfoqt3zgwsk=
Received: from SJ0PR05CA0187.namprd05.prod.outlook.com (2603:10b6:a03:330::12)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 10:58:04 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:330:cafe::f7) by SJ0PR05CA0187.outlook.office365.com
 (2603:10b6:a03:330::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 10:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.35 via Frontend Transport; Wed, 7 Jun 2023 10:58:04 +0000
Received: from bare-server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 05:58:02 -0500
From: Chong Li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 06/07] drm/amdgpu: add option params to enforce process
 isolation between graphics and compute
Date: Wed, 7 Jun 2023 18:57:52 +0800
Message-ID: <20230607105752.3905380-1-chongli2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 029d0208-ba26-42fa-4be6-08db67461180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/HfWWvu/xRhFgQKBkFGzl2WOguAGhzxgmmLSqexE/k9AkYHz3UAru2AX3ufb0svDUZn6nyXXuJRuvbnArbxdi6y82aKgcGxi+jepcRx9D2eHGU7gZ2jzR1XgFftAm5MxWkb1hVf1ukUSATveRIJxAosUg3PUWzEQkOa/OamFZyIaNZtSFkMJCQrLXrmEB+9E/zjPP7TrUXbpLW1X2HJn4q4tRzfl40NgBwILu2yPgbt/uJE917+o9X5t4bKsKMWKOJ4DgxaJroWjnzfuYYv3a1/zKHocfbxph/kbpwB4P+Z2Wyj6dJUHNLK5N8K6nqN1fREE1lgsyjq2CR2AOfTJvq28d3JG61VE0XTtQWO3pQ9OMbVdPXCVtefk8ThdIHIZIYF98Nms/0b6g8cQU6ECwxq6ml8zC/izJyCNrtE2TtkuilDxLD5OYiU17eix95AQsSbQwYlsjMkNGocJa47MqDoONrd/wY28M+Ag2pbTjiQUdlumeZ/55pQdIExgcQ2kURv0rT/Fqnnx3yaP0B9jJ0TkWYzT2uXlkyrYPRdjoyp1OeWKyrW/z4QQaoQLraS42aGbYKRn0InXB3RONb3LWNL5LWhjd79nQUv4DQXU9kQ5rVy7suxrrXh6NYG2aH1IGdoEBkT0+k0ECsD4NwqVk479LNvl77YfKNVwi6Gno9ktRYl3FFC90okvvbOPdj6vKBhs6Bj8CduA/zhuRC5Icqy2ifX/Yig1kP8oc9s9yRPYOujYi3SYM07ap2Ge+GZJ/SfFzIx23GyvBf6IopY6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(16526019)(186003)(82740400003)(81166007)(2616005)(1076003)(26005)(47076005)(426003)(336012)(83380400001)(82310400005)(36860700001)(36756003)(5660300002)(40460700003)(478600001)(54906003)(7696005)(8676002)(41300700001)(316002)(8936002)(4326008)(356005)(6666004)(6916009)(70586007)(70206006)(40480700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:58:04.1268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 029d0208-ba26-42fa-4be6-08db67461180
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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
Cc: Chong Li <chongli2@amd.com>, christian.koenig@amd.com, zhengyin@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enforce process isolation between graphics and compute via using the same reserved vmid.

v2: remove params "struct amdgpu_vm *vm" from
    amdgpu_vmid_alloc_reserved and amdgpu_vmid_free_reserved.

Signed-off-by: Chong Li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 17 +++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 22 +++++++++++++++++-----
 5 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ce196badf42d..ef098a7287d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -215,6 +215,7 @@ extern int amdgpu_force_asic_type;
 extern int amdgpu_smartshift_bias;
 extern int amdgpu_use_xgmi_p2p;
 extern int amdgpu_mtype_local;
+extern bool enforce_isolation;
 #ifdef CONFIG_HSA_AMD
 extern int sched_policy;
 extern bool debug_evictions;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3d91e123f9bd..fdb6fb8229ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -153,7 +153,7 @@ uint amdgpu_pg_mask = 0xffffffff;
 uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
-
+bool enforce_isolation;
 /*
  * OverDrive(bit 14) disabled by default
  * GFX DCS(bit 19) disabled by default
@@ -973,6 +973,14 @@ MODULE_PARM_DESC(
 						4 = AMDGPU_CPX_PARTITION_MODE)");
 module_param_named(user_partt_mode, amdgpu_user_partt_mode, uint, 0444);
 
+
+/**
+ * DOC: enforce_isolation (bool)
+ * enforce process isolation between graphics and compute via using the same reserved vmid.
+ */
+module_param(enforce_isolation, bool, 0444);
+MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics and compute . enforce_isolation = on");
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index c991ca0b7a1c..ff1ea99292fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -409,7 +409,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 	if (r || !idle)
 		goto error;
 
-	if (vm->reserved_vmid[vmhub]) {
+	if (vm->reserved_vmid[vmhub] || (enforce_isolation && (vmhub == AMDGPU_GFXHUB(0)))) {
 		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
 		if (r || !id)
 			goto error;
@@ -460,14 +460,11 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 }
 
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
-			       struct amdgpu_vm *vm,
 			       unsigned vmhub)
 {
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 
 	mutex_lock(&id_mgr->lock);
-	if (vm->reserved_vmid[vmhub])
-		goto unlock;
 
 	++id_mgr->reserved_use_count;
 	if (!id_mgr->reserved) {
@@ -479,27 +476,23 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
 		list_del_init(&id->list);
 		id_mgr->reserved = id;
 	}
-	vm->reserved_vmid[vmhub] = true;
 
-unlock:
 	mutex_unlock(&id_mgr->lock);
 	return 0;
 }
 
 void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
-			       struct amdgpu_vm *vm,
 			       unsigned vmhub)
 {
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 
 	mutex_lock(&id_mgr->lock);
-	if (vm->reserved_vmid[vmhub] &&
-	    !--id_mgr->reserved_use_count) {
+	if (!--id_mgr->reserved_use_count) {
 		/* give the reserved ID back to normal round robin */
 		list_add(&id_mgr->reserved->list, &id_mgr->ids_lru);
 		id_mgr->reserved = NULL;
 	}
-	vm->reserved_vmid[vmhub] = false;
+
 	mutex_unlock(&id_mgr->lock);
 }
 
@@ -578,6 +571,10 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
 		}
 	}
+	/* alloc a default reserved vmid to enforce isolation */
+	if (enforce_isolation)
+		amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(0));
+
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
index d1cc09b45da4..68add23dc87c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
@@ -79,11 +79,9 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 			       struct amdgpu_vmid *id);
 int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev,
-			       struct amdgpu_vm *vm,
-			       unsigned vmhub);
+					unsigned vmhub);
 void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
-			       struct amdgpu_vm *vm,
-			       unsigned vmhub);
+					unsigned vmhub);
 int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 		     struct amdgpu_job *job, struct dma_fence **fence);
 void amdgpu_vmid_reset(struct amdgpu_device *adev, unsigned vmhub,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ea3d0be152fc..73900ab545c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2358,8 +2358,14 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	}
 
 	dma_fence_put(vm->last_update);
-	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
-		amdgpu_vmid_free_reserved(adev, vm, i);
+
+	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
+		if (vm->reserved_vmid[i]) {
+			amdgpu_vmid_free_reserved(adev, i);
+			vm->reserved_vmid[i] = false;
+		}
+	}
+
 }
 
 /**
@@ -2447,13 +2453,19 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	switch (args->in.op) {
 	case AMDGPU_VM_OP_RESERVE_VMID:
 		/* We only have requirement to reserve vmid from gfxhub */
-		r = amdgpu_vmid_alloc_reserved(adev, &fpriv->vm,
-					       AMDGPU_GFXHUB(0));
+		if (!fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
+			r = amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(0));
+			fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)] = true;
+		}
+
 		if (r)
 			return r;
 		break;
 	case AMDGPU_VM_OP_UNRESERVE_VMID:
-		amdgpu_vmid_free_reserved(adev, &fpriv->vm, AMDGPU_GFXHUB(0));
+		if (fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)]) {
+			amdgpu_vmid_free_reserved(adev, AMDGPU_GFXHUB(0));
+			fpriv->vm.reserved_vmid[AMDGPU_GFXHUB(0)] = false;
+		}
 		break;
 	default:
 		return -EINVAL;
-- 
2.34.1

