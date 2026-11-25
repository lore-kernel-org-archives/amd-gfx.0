Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630A606A68B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mfbkpEGy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D0F10E1D0;
	Wed, 25 Nov 2026 07:37:25 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E304110E1D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 07:37:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1xBo0LoDkGc1LPAjE2O9aXhxIUQETUqk4VQ7JSk3v2FqZ6/6/0ol0gzZoym7Ktn8oUpVZaVz2waYA2w8fH3ECX33BlW5Mvrd9fgG3FS30yAL9aYtcsA0t0dC72b54V/9pesnMFvqaiFG4CaoIr6Mg5BCsq1P8jId3YvNZP37CpN7gljZuz9pJZtKRrSmcWOV8nNK4T3HoFLap1s7M3y/lukm+DwrWRsMKUEPFhOQHehCoiclgPosWbFZBnxCcdcw1zQKzfAWYisqEYCF0IHqLVOp1mVM0uXciHMk1f82o1jDsOORDk/iWpwoIFfcm8S+W7JVgKtCsdXkyYLB6En9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0kT7moWp3JPwjekTphUsxMgfarmOmP20nAWQjwGQPg=;
 b=PSuVxp7vuzaiI011Ri55btILduw6zzg8ksaSaShig2PGJjMrNPKfFvKlgvPonzRlT2525GiGqOagFkisnjkdcYfw4OVbPMkheOwM0wzh7LL4sa8dnAD5fGOe/Daj2e0+RItUDc89fSBGzYJaq/G3uAQuuPMZGe+VJ2941AHmIe/UF1xbPQEgQkObMeqCqDwPP2xd+7lMD6r+/9VNLtBIxYIhtsl/ghqd8XQJLttZwL2o1WQoFSjvOdJgqmetQen6VjEESbS1G2+n41r17Ob63jMICQYwjnm+MelVAmR51Y9vTNwYbuFNj1kAasON89RxQrk2XVLYM97fsVKjmU7v8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0kT7moWp3JPwjekTphUsxMgfarmOmP20nAWQjwGQPg=;
 b=mfbkpEGynuA78CuGJptHkzMVyJ4P6kG2Ot9eaziTmXf1aj1LnxEL+pjgn/j/MK4GHnsY4V6afdzyetDGOMrOroCv9YaK0pgQ7wWSZ1PBW+lTAh/P2WzqMw91JOiAzbfF0PrxCnEolubEmicHT3ayXEUngloYzbMWOJ50pTdOD9w=
Received: from CH2PR14CA0050.namprd14.prod.outlook.com (2603:10b6:610:56::30)
 by LV1PR12MB861631.namprd12.prod.outlook.com (2603:10b6:408:515::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 07:35:13 +0000
Received: from CH1PEPF0005BD62.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::b) by CH2PR14CA0050.outlook.office365.com
 (2603:10b6:610:56::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 07:35:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0005BD62.mail.protection.outlook.com (10.167.244.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 07:35:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 01:35:04 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 01:35:04 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 01:35:03 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: unlink userptr bo_vas under the notifier_lock
Date: Wed, 25 Nov 2026 15:34:30 +0800
Message-ID: <20261125073502.3144422-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0005BD62:EE_|LV1PR12MB861631:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5d3c9c-13ec-483a-fe8e-08df4ac6a43d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|6133799003|11063799006|261021121427099003|56012099006|261102123227099003|261026121527099003|261009223027099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: OfMf8q3P/DSo2S4Jsm52srHYzUpieSoCtHYUAj9lXlJR9zfmxVrgOVTSACaMHCHcEXMgoyq2DVKrD5F8hut2f8oqLn+SxiwmZz8vKdQlViGBUt44ELx/TQOkvKrfDhyEzcEDktRNwl/912VPnxz0pOY/c228FGZo0VWgZK8gVKQ7Ehx2N7hfK1S5qNpG8VLDHji8yIE9OPX4ibcRklBoNqIpizXsQTTY5cGlADWf3DvuIWTlnQlSVKXbiRP+uM9vSbnki6UGva976K1qj0zOE2I0QWMDGg9hDeuKhVByvwOpnGHps2FOeyMN3JcncpJGxGHllzfsuHZcqdQtAXA1DNG7hOdgUASpYNXCHjJjH7zUp4WheiuINsDiiTOkceTe/XNeH2+at+pFWV1eWJlRWdXYDKw+mOBgC9jkv+R9Tq8ogn9GhVdVhj0nmkZ5nPsiwi8FB2aIHdCZQjTzGLCWxSkgIbMIOhZDKgyyhpIfWGLjxuwHIF/fdUXjMdEh1WCSQ5DwL32xdxr2fVjs02ddLjgimnC7A79tZr2RwbpdeDO6KMukKQmTeK4F9TDFBowRZgV6rMztl5TJtx3CviU+6i4DtZAk0Pm7qPl4OAGuNVnq5Xx6dZlvZunHUFLp2GPfBZg4772wLsaJPjh6QXu0YRDqC9MzCFNPsLmhwAfynmf1C5mDvZBoe/CQoU8fvzY5QImA2ioykfNSIAONqLBykQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(6133799003)(11063799006)(261021121427099003)(56012099006)(261102123227099003)(261026121527099003)(261009223027099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UDj9J6A5CpRNb10GRscEAVDeQQrYu0jtyoxjxjTmpsI7nWwVtcAPi3hVnCmV5WyVZSSx93wZ1ojS4EJyB0s3qoXVq2gk6Qf8d7qW1wxLzmO2ZRoij9PzeTfCsVqe3NgnZj+ITRjxc3zeciilxKpFlL3DEPUqaSvOSJ0b4UANuNvvE/kuLhBSONhF0hWeWEgyM2mZXZ8VEHD++gs7MjaZLRhSC6EZFQoMKsODp3bTMY+3BmkD7tmu3nB5u1yB28De2yRDsZxafGz1tFqYSRurELIhqZ6xsQWpQ2ANHRsC+1v+X/mECEA5GVLDDzwGW3xQAEyUocXFKEV/lACb+mEjfCTuXtaV/6ces3oTN6DMDQB0v7fP9PkBNY022CWuyFw/SHj5GpBeai8VPZwcMS85ovXzPnO1jpjqmeD/KN7NisByDJWL8HDH5Xx/LVg6QlOx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:35:12.9079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5d3c9c-13ec-483a-fe8e-08df4ac6a43d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0005BD62.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB861631
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

The userptr MMU notifier walks bo->vm_bo under notifier_lock, but
amdgpu_vm_bo_del() removes and frees entries with only the BO and VM
reservations held. Concurrent invalidation can access a freed bo_va.

On Navi48, racing userptr BO close with MADV_DONTNEED triggers:

  BUG: KASAN: slab-use-after-free in amdgpu_vm_bo_needs_update
   amdgpu_vm_bo_invalidate
   amdgpu_hmm_invalidate_gfx
   __mmu_notifier_invalidate_range_start
   zap_vma_range_batched
   madvise_vma_behavior

  Freed by:
   kfree
   amdgpu_vm_bo_del
   amdgpu_gem_object_close
   drm_gem_close_ioctl

Take notifier_lock when unlinking userptr bo_vas to serialize with
the notifier.

Fixes: 1c824497d8ac ("drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_invalidate_gfx")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ea8672451d98..87b06daff892 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2279,10 +2279,18 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 
 	if (bo) {
+		/*
+		 * The MMU notifier of a userptr walks bo->vm_bo under the
+		 * notifier_lock, it can't take the BO reservation.
+		 */
+		bool userptr = amdgpu_ttm_tt_is_userptr(bo->tbo.ttm);
+
 		dma_resv_assert_held(bo->tbo.base.resv);
 		if (amdgpu_vm_is_bo_always_valid(vm, bo))
 			ttm_bo_set_bulk_move(&bo->tbo, NULL);
 
+		if (userptr)
+			mutex_lock(&adev->notifier_lock);
 		for (base = &bo_va->base.bo->vm_bo; *base;
 		     base = &(*base)->next) {
 			if (*base != &bo_va->base)
@@ -2292,6 +2300,8 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 			*base = bo_va->base.next;
 			break;
 		}
+		if (userptr)
+			mutex_unlock(&adev->notifier_lock);
 	}
 
 	spin_lock(&vm->individual_lock);
-- 
2.50.1

