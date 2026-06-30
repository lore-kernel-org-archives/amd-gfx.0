Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E61C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 13:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B331310E50F;
	Tue, 30 Jun 2026 13:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y7QawjHk";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013057.outbound.protection.outlook.com
 [40.107.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C02510E50F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 13:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0ToAGmdYkVhYQ5sKlvsttIAIoBi5oPFrlfE3hl6uVk7aWE58pfbq+7oRScL6FL+B6ljsA4KHV2WFtGknRxGBlw+auyEjtUNlS7EMlECYkuU8EX4CMMdup9A2UswvutmNWEzU/8elz8N25koLVP63RgBNU9CgPVnWi9NAHKvKcTYDxmCEtPeXOiWkjYj4H0YXbl970WXOeyBBadZpyACbK/RkaqpqVsOLpMeGVu7jWU0rEon0lXl8l3+OBQttb3Uv9uYAM0DVL3DJ5QpA4yS8jTgIcyn9iS92CuMfbKgxLpJ//+fegZtv2b/hoH9s2SOqIXQmC/WJBDz+BSg1UF9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpssNF+2rTaT+e8ZfipVkkrFPwI00PShbSSIUnAyI7Y=;
 b=OQO21SAalsW15f+AJWopHXqpFYgkrHS1T35wyrivJhTVR6CSaGRxqp3Wo74asTDV+kWw88XPfm0qeZBgcF7CMS+KhXfkUUhCDyl1G9PJZWrQNeKF57cM4iQaFoqH19flaFqpMZlKl4/pd7godDqNZsatx2yQrTaUH4Hw+CJlzNYnzO332wMLv5XOJO9lJrpPnsNYZ3Lb3+Aju6YGB5lRjIJnAf9fE/9Pl5sSOwj26ONyRwmPu6uzN8GTpOhSl8LdHp4y/L4NvLuIePhhSNoXYECi5ZJWw3+tBWwQpZ+JFvv/AH4auOfxUsh56qSaKmB8RndBqiGygOd5r1I90t/yDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpssNF+2rTaT+e8ZfipVkkrFPwI00PShbSSIUnAyI7Y=;
 b=Y7QawjHkvY/CUHCtc1lLIXaCELRPnDGCLAKw6OHZ48gWewvx+rWx5hgA0UR6lm5NXY0SwC3sjvzxpAHVkyq4LfLv+ds/aR+U7nafLT6s/bNGMQCp4f3T71XnEzKVsRCpJO0SStiYW8r7ev81s6tshoAmaaiKgB+1djjaUzcbKuM=
Received: from BL1PR13CA0251.namprd13.prod.outlook.com (2603:10b6:208:2ba::16)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:43:46 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::5d) by BL1PR13CA0251.outlook.office365.com
 (2603:10b6:208:2ba::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 13:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 13:43:45 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 30 Jun 2026 08:43:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 3/4] drm/amdgpu: Resolve VM through DRM PASID ownership
Date: Tue, 30 Jun 2026 19:13:23 +0530
Message-ID: <20260630134324.3118873-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630134324.3118873-1-srinivasan.shanmugam@amd.com>
References: <20260630134324.3118873-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: 030a487c-d6d8-4c7e-9434-08ded6ad9b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 70o6X5/JwQy1N7TgPrfSbPaRqm6KzJG58hO7F98xF465QilbAhwecSTVTPG5O6ltZHIZYM3AsI0eta5zUiKWYJ0OZlR4z5qSGJljb1gaXPbyJjLcNO+5e1gIb2Ip9KpbTkp0qR3YmYrXmDtibfyrt6I5XnUcnz5wqoWXzU5PeUTFLrQA1SB2pKp4xlqFs3i5c4KhoYcXwiRbbbnusiNxNldX47xQvd0sI/JHFKKimfu5VZLiU9lcZGzyTmoBbXPJj17ZQB+Pp/t8Rt16amq6BRu+xE/bP9RGpVtB/du90Ndb1wpqKJhvJuhooxJ9LBYSxTbFeRY1kFTUK9nVMXU1648aXrex6388fFNAqP16bJUxxDyDwdq26uiT0V8+3GSZlW56WWO6WzyeZ94w5q1D7tK8ZnQGI4nsUfoZmcFWDFGWswdK8bv2WmPfUc5Dmd8U+Jv+ikb/SXpqRXeO1BilarrVviKLCwfjW7wi+keKOI1Job7XhTFjKX1/xqkwJxxo9owOuEGM6DrgAaSQkYP87lPv8QuGnx+U6rwar1G8DYq/0b+Z0GDHitB9qPNvy5TOGbfdi+5WHLZbFAqkW2Iq0qYwTtRL9NLcvHTH13s5TEe4Jq71XHHPXv4TO9HxIZkg9UqdC3DLwyfXHPLo1YB2kwtv6pp/U1kZnQw4jXclwNdTiS+tx5H/bohYoDiiIYWdBWkZyPiN7vdu+pIlNLCrLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ux6x8WHuMqCjx7YHHkdlXnk6+0O023SBiZYvjhcAafjGmdhvn9Pyrdo+yyUq+33CED05ZJQSFktlvGy+au0n5zIhNZrNfTpIFcPM4hyenjrSp5n8OyOyzxtbycKS/V49wWFgv2q7gRhPh1/cHmXWo1Es8xalYfqB46H2PVWsWdZbcA/67tcJ8T/tqXcc4SCpKlMCkg1eCyIGSk5DMDuFAN19KW6qfoLmMo+p6jJE762YJ1f4206KjZjwiufI2b7fwOnH91W/DNAVz7RhiNKgk3HNmit9ZTqVBihsP2zwkr1DwGYC4a1fCaY4KZHa373IbEeQYG5yTdl6Miwq0J/Boh4dPXWq1XgnMxbYkLkb3zA17psi1ZR1eeYSUa7wU5C0yF5Zm1ErYGJAJHK3EKNwXF4kNZUSFHGvj5iXqWYoTLpP7CSxa3BkLno6zRn/RkLQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:43:45.9603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 030a487c-d6d8-4c7e-9434-08ded6ad9b84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
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

Convert VM lookup paths to:

	PASID -> fpriv -> vm

Preserve existing VM root BO reference and revalidation logic.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 34 +++++++++++++++++---------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 450bd9dc6bc0..ef7c1efff10e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2459,12 +2459,14 @@ static void amdgpu_vm_destroy_task_info(struct kref *kref)
 static inline struct amdgpu_vm *
 amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
 {
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+	amdgpu_pasid_lock(&flags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	vm = fpriv ? &fpriv->vm : NULL;
+	amdgpu_pasid_unlock(flags);
 
 	return vm;
 }
@@ -2939,14 +2941,16 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
 					  u32 pasid, struct drm_exec *exec)
 {
 	unsigned long irqflags;
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_bo *root;
 	struct amdgpu_vm *vm;
 	int r;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	amdgpu_pasid_lock(&irqflags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	vm = fpriv ? &fpriv->vm : NULL;
 	root = vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+	amdgpu_pasid_unlock(irqflags);
 
 	if (!root)
 		return NULL;
@@ -2958,11 +2962,13 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
 	}
 
 	/* Double check that the VM still exists */
-	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
+	amdgpu_pasid_lock(&irqflags);
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	vm = fpriv ? &fpriv->vm : NULL;
 	if (vm && vm->root.bo != root)
 		vm = NULL;
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
+	amdgpu_pasid_unlock(irqflags);
+
 	if (!vm) {
 		drm_exec_unlock_obj(exec, &root->tbo.base);
 		amdgpu_bo_unref(&root);
@@ -3159,12 +3165,15 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint32_t status,
 				  unsigned int vmhub)
 {
+	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
-	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+	amdgpu_pasid_lock(&flags);
+
+	fpriv = amdgpu_pasid_get_fpriv_locked(pasid);
+	vm = fpriv ? &fpriv->vm : NULL;
 
-	vm = xa_load(&adev->vm_manager.pasids, pasid);
 	/* Don't update the fault cache if status is 0.  In the multiple
 	 * fault case, subsequent faults will return a 0 status which is
 	 * useless for userspace and replaces the useful fault status, so
@@ -3197,7 +3206,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 			WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
 		}
 	}
-	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+
+	amdgpu_pasid_unlock(flags);
 }
 
 void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
-- 
2.34.1

