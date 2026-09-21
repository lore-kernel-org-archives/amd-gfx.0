Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5639EC982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 19:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FCC10E47B;
	Mon, 21 Sep 2026 19:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Zdv1JRd";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213E910E228
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 19:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3q1fTE1j4zFpvf6fPCwYxOnFHKOxUEELodwoH7HX03hmdnjsYn6jvY/2cF0Si07djLbago1ixf/Z+FMkgnAxP4FygeulTx4PbH/q0XI1gVepAGlEhynbObuW8XVpCE9qERhM6IY840RBe8lKsb2OLEejlA7l1J/V+W3lKOa5TLao8wjqbKXftLXwi+NaL+jtyI1kZp+jMfgNylw04jcccn16VgZBpwm6tK7FAviuQLlyhbnvO/NXwowlgVlXeNGyxdwIGw0uXqdS08101tBys9epunvdZYvjQjJsZjO1VAb9FELqlv66s4vVehNpmNEfUMwMkVwx+k2YFMLb8TU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KV9IodopM/C3ds4W3Y0nh0Oszn5iG+zPFvH0rQHu7s=;
 b=tEsRoOji1UEiUjqdQCKzOx0mIlMGEtguLugQ5tMyUmDp00LD9PgybEUgqNIK2+b/80vMGwrua8yzfGfO3tf8j+ChiiWk37SCwUxbatlpg1Ilppdml1I2fPdTLtiVahshyCUNxg8JV1v9HhBeaiuaggAbn9nBSZbCIkvBlXePZH8e2U2ycD6T15vkmZXV0qquACkEovp4If9Mlka/PF0zxC//SOhXsHD9Fd1a3kceog7M/zDIpZ0sxWaxpLoj4AGDVXwXEjkfNBNRR1P4eOreVrAJnEdg/3gZblDSyqV5JU3TH0Nkg3yD4y/G+3EDC5rTOUEy2g7I2YV0fEZOTmZttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KV9IodopM/C3ds4W3Y0nh0Oszn5iG+zPFvH0rQHu7s=;
 b=5Zdv1JRdi1g5CA7pYqJxqw2SfUlSmT+doQ52RBduYzs1jE+4ujfXXlWN0YKTgy84DTYle0T5sXLxM0WBiy/0sC8TsA5AOnP0yM+OzzF6PSt+/4NoKCikwVIsbHRoBQ6jZNT3LTrI2aqHqQ50dM6bao37o/fv4VSB4a/ITy+U0Rc=
Received: from SJ0PR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:332::28)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 19:22:51 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::83) by SJ0PR05CA0083.outlook.office365.com
 (2603:10b6:a03:332::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Mon, 21
 Sep 2026 19:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 19:22:51 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 14:22:48 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <David.YatSin@amd.com>, David Francis
 <David.Francis@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Don't assert vm locked during svm unmap
Date: Mon, 21 Sep 2026 15:22:32 -0400
Message-ID: <20260921192232.665113-2-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921192232.665113-1-David.Francis@amd.com>
References: <20260921192232.665113-1-David.Francis@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f168fd-da4a-4ba9-5436-08df1815babf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: vcta2zTk4/PoyqmCEni9a2Uaa4ttD2sm4oLlsb3XG/SzMxfcYFcl7F+R5oZLhu4dcjr4LQLgmhlPaOPd9VAQKDqmjdWXrQX6KSJ6W5l3cAQXCCFzujz8FKIYUshZB2lMZeaO8B/87UVsdrtxw1QJ4kEF7lzGuT/XBALa98/zZdBBh05eGV/Lfj86BfOx8BAcssRCG7pL/c+OMA5b9KA3gug6AjTEdsJ+KAuzDBFLtxvVd99B0/xgMsUU7i9TR9ZeILqNrKuyqcZg+QZzpe8YS/TNBYmleOb+oXywz/eFCHQQupOIOEC9RICeCYrGFWSILWZx0I9nksQZfpg4psebnXW5B2ghDDeqffwONknykUvjJsCzqr7lyqISMIK4v8anddzL2TaCtn92nSPzZUkSNxRb0ymFQaPKBQkjibhjFKWtZiy3yY6Ujy5xrWYzAmZvEG6PrB+TmOHC2UGp1en2BF7iEEmfukCcghrCIiq36xqgfwcrMGDJRnTQs/sxjXPsGUbrUi9OYFMfNFsaUnZ7Iecl67fgo/yJbpRvE9DnUZTt8IHwyiAPnj7elHfkxJkaaL+nIyGiMdwS4qG5TkGafmYHvA4DY/fxwnp92BgJToQ0EbZT8e/3ZdYDcAGqnoXVQ1VViDdF405J2MX534P31IK8VqGqdiOcpoXZSQf+OVFc+sLut+xm8FS6d+I0uB6oUGnq7ehUEYw+jVFu0tbJSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YkIDEe2+tyO8CkH3gIcFbJ/r7aK2/TJ+qMuix/8Tkbgow55h1mGhF7GwvIiNiIMpzSe61d9Ey+3/k35tbS8DtooGdA4LF/24m4x2rYI17FC8oEfKo9QQ2wF6mYiUi83IJbhPzSXKneXPWbVkaaCRVinEE+pKpIiSNATIUTQnktG6idXjApp/rqyXzYJllscBRl7w99I4iYUP5a52JlQBhdhjOILqvq9nWpbZERZWvChgU737oVqmYNK1TDnZvV9QMWDQgFiOymcusc5o/Yyfv89UO4Rx5G0byIgaNOuPXt24HlF5R91gWpLa8GxOq6yP7SHU7gUltl74o+WlOSt2oYnxAeFnJJsNaDD0mFltLg/vUK7l3BqX/niNQooKOsAs5qie00DAVA7IPeYBO4MYFTuoRBAXgOgJzmS4TOLSyAQPzvJMJFs+ZwChJ60RLf/+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:22:51.5100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f168fd-da4a-4ba9-5436-08df1815babf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
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

During kfd_criu_resume_svm(), the driver puts in place every
checkpointed svm range, including explicitly setting
KFD_IOCTL_SVM_ATTR_NO_ACCESS on every range where that was previously true.

This leads to an unmap without the vm lock held. This isn't an error
but it does trip an assert.

Make an alternate amdgpu_vm_ready for svm_unmap that lacks the assert.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 32 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   |  2 +-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f07b7fb0c5db..ee68ffb0dc8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -696,6 +696,38 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	return ret;
 }
 
+/**
+ * amdgpu_vm_ready_for_unmap - check VM is ready for unmap
+ *
+ * @vm: VM to check
+ *
+ * Check if all VM PDs/PTs are ready for unmap
+ * Doesn't require the vm be locked
+ *
+ * Returns:
+ * True if VM is not evicting and all VM entities are not stopped
+ */
+bool amdgpu_vm_ready_for_unmap(struct amdgpu_vm *vm)
+{
+	bool ret;
+
+	amdgpu_vm_eviction_lock(vm);
+	ret = !vm->evicting;
+	amdgpu_vm_eviction_unlock(vm);
+
+	ret &= list_empty(&vm->kernel.evicted);
+
+	spin_lock(&vm->immediate.lock);
+	ret &= !vm->immediate.stopped;
+	spin_unlock(&vm->immediate.lock);
+
+	spin_lock(&vm->delayed.lock);
+	ret &= !vm->delayed.stopped;
+	spin_unlock(&vm->delayed.lock);
+
+	return ret;
+}
+
 /**
  * amdgpu_vm_check_compute_bug - check whether asic has compute vm bug
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 0f6634b74974..8a2639be28fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -438,6 +438,7 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
 			      unsigned int num_fences);
 bool amdgpu_vm_ready(struct amdgpu_vm *vm);
+bool amdgpu_vm_ready_for_unmap(struct amdgpu_vm *vm);
 uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct ww_acquire_ctx *ticket,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c521ec07bf3c..68e51367e714 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1406,7 +1406,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	pr_debug("CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n", start, last,
 		gpu_start, gpu_end);
 
-	if (!amdgpu_vm_ready(vm)) {
+	if (!amdgpu_vm_ready_for_unmap(vm)) {
 		pr_debug("VM not ready, canceling unmap\n");
 		return -EINVAL;
 	}
-- 
2.34.1

