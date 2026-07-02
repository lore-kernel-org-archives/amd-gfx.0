Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E32C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821C510F247;
	Thu,  2 Jul 2026 08:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DycHFjUC";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320BE10F246
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 08:40:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSpQyyI8w5SC3iHI9SM1PUHv0cUgUd0QRFxfKShznSRh7Si0B9L7bvKBf/bpHJ9n9FapulpvOiLxbFYlKQ36lVuSt2u8Q2FDkiQp/QpueEe2LE1NE2ZUOH2zdfw9Sk5blNTqNrikA3q106ecGCFq7cNXP86/qwty115kaFQqqa+k6JvVBe5B2UzQSKzjqCqM2prmzbW/N0PnNgSHpcMgAwyHcj/14SCpIIRIWVwQvX3eCLHkWngZi0fdjjpVoHXvdbx5crxNefNgTLpXZ3KhOqNW4Dd4dpGxxrpkYCnYruSdKi+JYsKU4XCXMI72DfOJu1fCEcJVKYkxyXgaKpfbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVgS9O8RCMwlMjtmxx8Mj/cu95J9WeoEbqlGyePWz5k=;
 b=icUINbfNY9gexilqDc7q32oWHE0/6jMt3l+30Z+Z0dukggMb28yzsHj7tO3ohMrNwTnB8/drersgLSusuWS7pUhvyQjtznylf2ln8lXdMBOvcd7/n8oaMTMxmTj3FoclkXIKevQ2tv9JG1GlIpX8jFrSwVvhD/VFbl/33jJv72HU7xL1+mswqH0bhsCPVr0dOjqGYmelhYpAntgs3UQW87CkGxrSkNSNt5cIoj2yeNqv5wOc0X/rR8EoqwTrKajQiMH5WaLhAswUzFKeB8zbJjkj7isSD0FohrOxPNBKO6/bB45g1yQEgwIhHYXIy5tHs20NH6Z9q4ISc3+OcVxJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVgS9O8RCMwlMjtmxx8Mj/cu95J9WeoEbqlGyePWz5k=;
 b=DycHFjUCKdw7VX5+dj005ZYy+MHRP4snU5+dQyiB3GVEebO/rv+12R48oqnsP6P2IZrUl0rEwV8NsAZXRmsPf+YluB1ZfQbb1+LF3JhuiVfhQPrC/oJXH7i1yRvtmLRYchwNaZxdaImF8eBb226T/8mGQrak2T3HrzPAqhex4KI=
Received: from BN1PR13CA0017.namprd13.prod.outlook.com (2603:10b6:408:e2::22)
 by DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 08:40:48 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::13) by BN1PR13CA0017.outlook.office365.com
 (2603:10b6:408:e2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 08:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 08:40:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Thu, 2 Jul 2026 03:40:46 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 3/4] drm/amdgpu: Resolve VM through DRM PASID ownership
Date: Thu, 2 Jul 2026 14:10:20 +0530
Message-ID: <20260702084021.3140071-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702084021.3140071-1-srinivasan.shanmugam@amd.com>
References: <20260702084021.3140071-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|DS7PR12MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 035407a4-abe8-418d-16fa-08ded8159dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6LYD4xEAa8yM4rD17H2Z+Ix4HnEUQyme53zZhlQyHSs8Hz/zMbFmtCU3wsGsg1zTXTqfNRYZao0ZnaOL5/E3gMbT/oht5U9fdVUnl1UEL85fZXi44R1qKdypgs+wVcJPqZbl1USnOIn8xbGXchNm3YO/16Rq5scp2+G8mDBYGHCn2285/C+1OmZ0+msIzzhUrdc+GWftIgsFui95YxIyEbn1PCkm555nEazEULamMdSFfF/nRz9uluC6skyQNIVOUlZIf67PSgWkpK0P4dHsaodhYYNCdkSfD3p3gkqu69qBcQxZDGyJdgMjn1Oq0Xw8ceaDXRkpnbUo15hKe0BpqGtvqhAOjHxV+osqm5gbaGaj9Uoz5Akmnax0Kl8Y398vMh8VVDECUfK91wBDkNzDp7Lv+rXvU9nMlihooJRmJDmjtloKKC2zUa1QAjfEluNHLCeQEWrz+7VsZzaLcSPhUsmNjdRVz5q5T/vTewSQSdi7FEHRcdYtELSYNf4wU6Vb2rnmqiKzBhjln81SnJMi/v4bcl08w4kzrMcZMEp1SBRKL+Mw69bScq5ZZIxvC/bKlUDsj4zqGR+1uZwS80ynkK7CL8Ln6OPBw8i76uzcxAv7AhDuXA/mSXDe5r9/JWA3dJ4oK7Fu30P7ge7Gdaa5jbziNubWq9nUcXd2j88WA5x7qTok2zz0MfXMunhIPQmyBMNwOTLtfpvbvteiw2ecjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0yznvdBOO3LPxae18MjH2x8D21RPvawRxvrI71N7RgguuO4y6bwBa3PsyTZg4uG/wvVM/2RvaU9O5iG/el2e0erdYTNINuL2KEL5+m1nO7CW5QDgeZpuMc0YlfR5N0wAOpYK18lDTdRoZGB7q3Kl4n+UkYiy1ig/3P2wpGIw+UOP64FVa5Fy8RTUZJIfqZyKbJRjWWW1fRe8tsb5CQup9CRndX/+ITmfFji8JPQEBdLsMIPoO/LGLykzilbW/WruqFvX42hxAqBVEaqvJid4ThmPYiolvU35sPZ+FFmLWgE9ithNAW6x+A7NgqC/dJQvJQTUQF/0qPoF3W9hBRVq3pg8v0no4uNCP0q3wJVARWWMF+s2g0AagCUfNURZr+4XuUyw6oIXS+SZdDmRHjuMIesm3NIbawODqIVms+ub15keQs+kLHv+s0rgYHyBZGd0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:40:48.6705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035407a4-abe8-418d-16fa-08ded8159dd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005
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
index 32719f31b6c9..462761259d5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2463,12 +2463,14 @@ static void amdgpu_vm_destroy_task_info(struct kref *kref)
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
@@ -2943,14 +2945,16 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
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
@@ -2962,11 +2966,13 @@ struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
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
@@ -3163,12 +3169,15 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
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
@@ -3201,7 +3210,8 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
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

