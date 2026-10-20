Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38660A260C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RaoaUOGi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85F810EB9B;
	Tue, 20 Oct 2026 08:38:23 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB47110EB7C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 08:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOyix5wCvvN2MIuPhOuFKpFYdQ8AP6g+k+z5bF0X48JNl9LP0WiaG0TaEN9sPb5nRuUlcSpXp8b2j2DVxe9+bIJNseiY+ZwxtCgTrjzGGikl4RrFHIP4VSsEFTemQbEGCq7LOioCUFX4ZS6hHGAVtS3KS5sYDiXe8o5L8Rroxz1dr6h+w4C4bNntitcklDt6sJpOLEXUa5Bx292R2HUgDAjZHU6qp9rYUVvdBizfbxFNg+8XhTb9QtB5H5LJ6TGlYzd0BH/649HcVm8wSmzRovaKBpbgdIWEHjPaLx+YcMNUP8MHKjc9mWc22vr2gGy0kIS6XH7u4thUb+GNgfunvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JkdKsGcNa7hZTDZZeU1BCSNlLakmZxyl+lVBYEnblQ=;
 b=XOK8e7YFQe9r7Bpt2fEvoH8dLXnU38K1GHjKIjuR/Y9N/r65oXBQ7L//5/4vkXR22A24o1ccPEEjPBBdcockxAT2vilzmnzNjhyC83ha/AJA5eNgBLnSQwRT/4odrcrRuaL4gVU6PB9MsNIj3P+H610h3Rh9XkR7SYcqt3EfbgkkkxhORfJS8juJMg0kVjyem9HdgTc1qusdxvVgETYwOPYmaNAEnmIwbe1kVMjD2NOrZDkeVKyPUGgoaP3LJilqyhzgo1thfu2feJLgMcSzxg9xTh01r86pt6mU0DKkOlQPqOVuyZ4Q2zkd4m7Fnohs3YU1+tkq6NL6kBdMVx4tEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JkdKsGcNa7hZTDZZeU1BCSNlLakmZxyl+lVBYEnblQ=;
 b=RaoaUOGichEh3ZninHyf8ZAEHX6yI3xg7AkMB0ZvNB6tiayylE9HvaMOzvorB0CunKA8hEt4rl862ZtOtNhzSbyrH/yeuVGKFPrSdLVdRtHZYqIvgr/ABtSCvG3YwasT+bQER1q4riaQuqInpRS16kHrfhtVhG2iHJitSVEiWnY=
Received: from SJ0PR05CA0129.namprd05.prod.outlook.com (2603:10b6:a03:33d::14)
 by CHXPR12MB999243.namprd12.prod.outlook.com (2603:10b6:610:2fc::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 08:38:12 +0000
Received: from MWH0EPF000D894C.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::50) by SJ0PR05CA0129.outlook.office365.com
 (2603:10b6:a03:33d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 08:38:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D894C.mail.protection.outlook.com (10.167.249.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 08:38:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 03:38:11 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 03:38:10 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: don't wait for the SPM VMID's jobs under the
 VMID manager lock
Date: Tue, 20 Oct 2026 16:37:08 +0800
Message-ID: <20261020083804.2777099-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894C:EE_|CHXPR12MB999243:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a1dac6-850c-4657-100f-08df2e8579dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|18002099003|5023799004|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: vbGuZMKPxMRKiUUybMezALdzBk3S2RyWv483k7WSfgrEHVMA27Tx49M6u5Sbi+Aq1Xd+ysahsLnsVyK6V1uQdzdbcqQmHr3QpjVbOOaZx8C7/p1wN5P4GPNtMMo99LrojnR+P3K51snN5u1FW2BqQJaglVeFdNivmc6EUK4y3qzEtXxbNgznHFQ7kiXvOwePwLUQLPI4xz2MzG0A+oXIxNub7NFgKA6LgETPN3+sxc6XJ5FxnVZ9AfCUbdQpfI7P4VNzfO9999SSrfyb4XnT9BiS204ddmdYJ9vLyw9vtaWFqJVDRXujzbnDAni3IIYHca1cexXtRMG96gESfQ5LePitZVyxmkMoCf+kFq7VENLucS37ISrbhYi4/mBvmGhw8yv4rMEjtswgJc6f7BBj1q2yfdZHi6eD52PkE0FMq5eDaGrFsyL7CAhuVGbjceLEzsYjhci0RmDsW0Qu//FYJ3dvhDqAJQUBKk00zw5Agjw7VF3eSjjgw2LfdKR+lsS9r8iqVqctOCo/rKgg3iywhpUcTJ/HJeJ3qyX+rJkRZaGiBTlNgwy/B0s7JME58cgRCPW8aBzYgfGzEk5H9HqZJASUcDT7rdBFn5blGGKMgcapsyj2pkXu8J1ybCGJ2Dr2nHH+lgjLGrc5KeVXZwFw1lq6M/ZS4qG6tUNyudiPORWwuVwMjp1vD+JTT0DbxjpqFbWjH8/2KaI5osnf83MSDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(18002099003)(5023799004)(11063799006)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lFMnImwIBRvW7pMUSEC7KZJazsoaCssqOL12ytHvP8iMcXlTuT8SaT6aaY13rs2IqmZZD8yJYBIx6o7r953eRmSPBy9pb8Dzybz9BUJ9igVUyvLqGhOgUTpPyjDLdnT5kapoUnKwbGYPP+WQnn26huZQwgeFI9Z49ofmiWYj02igMxdgltIPEZz0T29/u/3LOAra+S2J6lX1OQa6WehdyCHTwFOEwp9qFNDrrZbY/gz1fMI+vrqZV4hGJv7pi6yg0mIjFwPWWo/LCnIkSTBPiusdRm4Yn/fTDSNFkHuxCovk3pxl5lAoHwJUuuNri0hKNVo/QyrrsVkZSYrv6nSFHHFsBK3dyJkx+bvg3u+rvEDiO/gEoxiRNk+F8rjKfJQg21niJu3uaMRtATF36xeeiVxlEnry+vNvlHrr5oZKyczzcqpPLNnusX757YzWfNYM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 08:38:11.8555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a1dac6-850c-4657-100f-08df2e8579dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999243
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_vmid_free_spm() waits for the jobs of the reserved VMID while
holding the VMID manager lock of the hub, which every VMID grab on the
hub takes as well. Freeing the reservation, by UNRESERVE_VMID or when
the VM is destroyed, so stalls the kernel queue submissions of every
process on the GFXHUB until those jobs completed, or until the job
timeout if one of them hangs. A full GPU reset even deadlocks, since
amdgpu_vmid_reset_all() needs the lock before the scheduler is started
again to signal the jobs.

On navi31, with a GFX job of the reserving process that waits for 1s,
an unrelated process' SDMA NOP takes 0.8s instead of no time when the
VMID gets unreserved meanwhile.

Nothing adds to the active fences of the VMID once it's no longer the
VM's reserved one, so drop the lock while waiting for them. Keep the
VMID reserved until then, so that nobody else can bind it before.

Fixes: 9b47649cabf4 ("drm/amdgpu: bind the SPM VMID's page table to the reserving VM")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 1482fc031d44..d19bbcf25765 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -645,17 +645,18 @@ void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	mutex_lock(&id_mgr->lock);
 	id = vm->reserved_vmid[vmhub];
-	if (id) {
-		vm->reserved_vmid[vmhub] = NULL;
-		id_mgr->reserved_vmid = false;
+	vm->reserved_vmid[vmhub] = NULL;
+	mutex_unlock(&id_mgr->lock);
+	if (!id)
+		return;
 
-		/* Only for kernel queues and kfd/userqueues by pass that */
-		amdgpu_sync_wait(&id->active, false);
+	amdgpu_sync_wait(&id->active, false);
 
-		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
-			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
-					     adev->vm_manager.spm_vmid, 0);
-	}
+	mutex_lock(&id_mgr->lock);
+	if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
+		amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
+				     adev->vm_manager.spm_vmid, 0);
+	id_mgr->reserved_vmid = false;
 	mutex_unlock(&id_mgr->lock);
 }
 
-- 
2.50.1

