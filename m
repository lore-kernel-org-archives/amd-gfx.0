Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA6CC54E41
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 09:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92B3810FE92;
	Mon,  4 Mar 2024 09:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QzMx79z7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B464410FE92
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 09:16:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2XSzx8YDUsSdOnvy7xkYaDY+1I/vvUhTwiQrTcBPon+SbQGtNOx5qUPpC/jj21E2KNh3RRKRgYAMXE4O+4jgxxULvZF919Rhs3gvQU1nlFuzkfDs9nJmI7WtN+Xh+BNmEd7uhVMiAjO0E//o9c7jzCttWGZu7+WfeB8nme6T+62Mky18kKXR4KdXOaivBeHjy6xnBfnvJfzcEA7U9sRS/d2VSEaq+o3op0mzKSIkjwKsdspJu2dgFGEcIe2xIj1MZ/IT9YbCCzCD9WFwQlYIriakVEviO10r3zD9wmlRMsYWIYtXydeHgyLv3js37oea0LpbuBnCvWyz0VqMP0Ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIoJLuTLT6D7HZn0c7BcB82HWrPJoZCN0fc6pr0TLbk=;
 b=MBZP2bl0/OwOswF0jwSIWRlXl+4AUqvdnnDk07SBitkfi4oGheNsEqIeyG62qTWhlVX6iOT529fTPCO67/0xsY0jsQVnSzuh61dVwPR64V/Y7ufOttjoJV97bfxgsgsnfUYjLoXQyv04Mb3DYFwh+zPc9Y2+TvwWL6nYu2vyZlmxsD7k3y5l/4fKYDdcNDUW0gqusBzFRNJIRtlol1AOkJo/Pddf+nLebHzbNWF7HfRjKlCoBPeNZJU4b4DFUA1PWj2NLFArSZ/jll9+yOr9UYWwGJZDAlTlfMfNig2Yi8DJpGlnxTba7dlDdGggChJjA/93dU2SoM58P2THudTJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIoJLuTLT6D7HZn0c7BcB82HWrPJoZCN0fc6pr0TLbk=;
 b=QzMx79z79Uen05IJvapcUh3K/4OlQOQLvAdgh138uRh8DLuwdDtT2DjwHatrVUuStNfTqVf6lGYxpqUhaRbgyPzjpHXCIxLAb0XFJh/OOk20A/QbkBJfKD5vKiC8+ziAFQSSZKaA0MC10LoZjgGi5BAjOPLTIj/WYvUIhbjwICI=
Received: from DM5PR07CA0103.namprd07.prod.outlook.com (2603:10b6:4:ae::32) by
 CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 09:16:25 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::f5) by DM5PR07CA0103.outlook.office365.com
 (2603:10b6:4:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 09:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 09:16:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 4 Mar
 2024 03:16:24 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 4 Mar 2024 03:16:17 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <aaron.liu@amd.com>,
 <Felix.Kuehling@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu : remove unused code
Date: Mon, 4 Mar 2024 17:16:17 +0800
Message-ID: <20240304091617.534109-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d6b6b2-a4a3-4783-9706-08dc3c2bc434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k87HF7634voadvsJprhl4HVWYCxCBiyDsrCnlOwgz0nH+nDgN0nTwa9zsCk4fTS01bcaNmXQgtj4MBcDxgv1BRdBvc8Nm0K/jhA+yAm9oS2rqSK1uWtml6ES/KoCvKPoEcEUxVfKVQo8NBkPrpJqOtD22xvO0bf1Nn+bkAusHNVI4vt2sC/MZxTQz1FcWedaR13t24bNlvZhe92A3n7pdLFrgPMWHVe0620xglh/9KMbNJfPPAF5ON0k1OXakKSAp+ELF1hk6HAnRYLqUHol3LhuFjTAxSy3L59j1DzABbi5vZPadHxGjBTHMjpILHi6QpZazOubSsihKIPJHM7YadfnJFK9G55w4wa06qkSpbqDqLrO9Elpx8vLYEsfBT1NeXDXd+8wQHJbRad84uiFwc3VOzbJPT0uhkWZPWGcoc7UkNPXW3MmJB8uXVxy2Rhir3gjELaWhalXtS1ugjIUEFr7F9qCSmMzEt/LFnO98YfoxSE8G0WqasygOEYeoGlFv1lNTq73CvccXT5ElQ9k9Pc+olzYKdVxvXZdV27cbps+zC0I9kl4/rZukcNe3K0JfmCUbumNc/wrLMFwN99wSGPHUmvQ6qXlIAEmTgti+LakucBxeBbT8Z58eRlmMOwCMldHtIx2gSO8blf7tICYek4z32XopuQpBLfaOUBLjxVUvhZ9TRjLGjWyDl7iP+X7I6ex6ThpAU2Fovo5iFlXUapeg+DiYgpNpJ9rL6rCY4Q8Gys6zdjPVKEBXbfXPljW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 09:16:25.1871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d6b6b2-a4a3-4783-9706-08dc3c2bc434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522
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

From: Jesse Zhang <jesse.zhang@amd.com>

Remove the unused function - amdgpu_vm_pt_is_root_clean
and remove the impossible condition

v1: entries == 0 is not possible any more,
   so this condition could probably be removed (Felix)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 61 ++++++-----------------
 2 files changed, 16 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 7f95039bb37d..047ec1930d12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -537,8 +537,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
 			int32_t xcp_id);
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
-bool amdgpu_vm_pt_is_root_clean(struct amdgpu_device *adev,
-				struct amdgpu_vm *vm);
 
 int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 			 struct amdgpu_vm_bo_base *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 8bce4da67131..7ecddb77b3ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -367,6 +367,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_bo *bo = &vmbo->bo;
 	uint64_t addr;
 	int r, idx;
+	uint64_t value = 0, flags = 0;
 
 	/* Figure out our place in the hierarchy */
 	if (ancestor->parent) {
@@ -409,27 +410,24 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	addr = 0;
 
-	if (entries) {
-		uint64_t value = 0, flags = 0;
-
-		if (adev->asic_type >= CHIP_VEGA10) {
-			if (level != AMDGPU_VM_PTB) {
-				/* Handle leaf PDEs as PTEs */
-				flags |= AMDGPU_PDE_PTE;
-				amdgpu_gmc_get_vm_pde(adev, level,
-						      &value, &flags);
-			} else {
-				/* Workaround for fault priority problem on GMC9 */
-				flags = AMDGPU_PTE_EXECUTABLE;
-			}
-		}
 
-		r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
-					     value, flags);
-		if (r)
-			goto exit;
+	if (adev->asic_type >= CHIP_VEGA10) {
+		if (level != AMDGPU_VM_PTB) {
+			/* Handle leaf PDEs as PTEs */
+			flags |= AMDGPU_PDE_PTE;
+			amdgpu_gmc_get_vm_pde(adev, level,
+					      &value, &flags);
+		} else {
+			/* Workaround for fault priority problem on GMC9 */
+			flags = AMDGPU_PTE_EXECUTABLE;
+		}
 	}
 
+	r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
+				     value, flags);
+	if (r)
+		goto exit;
+
 	r = vm->update_funcs->commit(&params, NULL);
 exit:
 	drm_dev_exit(idx);
@@ -673,33 +671,6 @@ void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
 }
 
-/**
- * amdgpu_vm_pt_is_root_clean - check if a root PD is clean
- *
- * @adev: amdgpu_device pointer
- * @vm: the VM to check
- *
- * Check all entries of the root PD, if any subsequent PDs are allocated,
- * it means there are page table creating and filling, and is no a clean
- * VM
- *
- * Returns:
- *	0 if this VM is clean
- */
-bool amdgpu_vm_pt_is_root_clean(struct amdgpu_device *adev,
-				struct amdgpu_vm *vm)
-{
-	enum amdgpu_vm_level root = adev->vm_manager.root_level;
-	unsigned int entries = amdgpu_vm_pt_num_entries(adev, root);
-	unsigned int i = 0;
-
-	for (i = 0; i < entries; i++) {
-		if (to_amdgpu_bo_vm(vm->root.bo)->entries[i].bo)
-			return false;
-	}
-	return true;
-}
-
 /**
  * amdgpu_vm_pde_update - update a single level in the hierarchy
  *
-- 
2.25.1

