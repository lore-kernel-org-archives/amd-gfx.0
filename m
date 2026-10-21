Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244A606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DK/rk2Mw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C12810E2BC;
	Wed, 21 Oct 2026 05:10:48 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 371E810EA00
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 05:10:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFhpWZ6PwMuDMJSMdlUEhRlfyv0QX976OLYRPIOdzjygrV6mrAlImkN7tTRP4WRtQmZQLwILx9U50yLnzaJyxLDLw40dzh9E6qGIhetMInieH9y9wRVfJ3BtWNgZ2Jnp95KP+Mb6ZV0BlmrsGin+gn7whPVw8rKmft4cJlJLotJT6clxPPyln/EdM1cQ8+QNEPsB4B+vtX20jVFi8kNG7JbGCATRy+qNl8gtq64H3YE1ABSuaOkhehN+ii5Z72z+7Q7vI8HvhKJbcpxUhXvIIoCzcqMajWrH4FIzJA6e4rA2Y6/Oih1NUKbueTWNFvoFHhuSTDfFXoQEUoE22R+aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7bMez7Ot9ADf8iEeFhKA76fLL7wpIvi08jtMj9ZrLM=;
 b=wWr6KIqm6td9/s0aq0GryOW7yoHwW3qI4PLysidhP8rtWwe3sxCih/tY2IYyUXg0xWyrpIF2Bu/WQBT6X+Kx2VPaHgalqtf3VZx8LbR/n8CiF+0VF7VxmYyARCwAzspZkAxJdBoIsr4uhCmHnI45BKcBh+Ojg9Eyyxb6PaigCB7J0mzto67/1aaXktzswcSdMypbzEShH3ama4GZh1oq0/0UiOHW+rUZhPs8nN8wW+8L9OA6uIm0Gz7Ha04EGiKeKjLAkUeQbJvQjMywWOamv37fe69U0PIuvfH9VbEE9oEoQkAsGiwgYcUIU/Ufkrem5fnMVUnwx9Vplz3wn3LpGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7bMez7Ot9ADf8iEeFhKA76fLL7wpIvi08jtMj9ZrLM=;
 b=DK/rk2MwfbHoeMabPOqKIL7piiTzguwv3s1N4IbVYz3SOY24SiD++iOyxlvD3k3aKgpEWxcj41cyGvmpZ7WAXtCxtSKGO3bpxBPtkj01nJJyPYdTT0oSwr19tGWdp/CsmRkhesig8v3q4+46aXi7i2nLVlGQaqdVIbsn2QJaMds=
Received: from CYZPR11CA0001.namprd11.prod.outlook.com (2603:10b6:930:8d::28)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 05:10:37 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:930:8d:cafe::5e) by CYZPR11CA0001.outlook.office365.com
 (2603:10b6:930:8d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.24 via Frontend Transport; Wed,
 21 Oct 2026 05:10:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=temperror
 (sender IP is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 05:10:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 00:10:35 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 00:10:34 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH V2 1/3] drm/amdgpu: don't wait for the SPM VMID's jobs under
 the VMID manager lock
Date: Wed, 21 Oct 2026 13:09:57 +0800
Message-ID: <20261021051033.3287259-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: ad24af83-f579-4eec-54f5-08df2f31a438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: HTKRP15OTcppAVRc4RuVeOQgG7lJ2Eesn/s9DwWbO0TUyag+UK4nBLgMAuDb8RirZAqOgcc1sI0XhjEvtEGtuRTB84no9IQHY+bLYlyThoH5SEqmgFRboyJhZLUNrraB6cGD7D9culx1gtUnpuD2YizYEXASKzUt0LJXHzwU7R9bd8SvHg4OLP+BprrsfBKOfFEZB1BrI7Y46LDVY5Fhxv/zTGMhmA2HCrykXhD2E+LpPk9n7Fp55kR+ISIh2sfsFXaiGCH390eMh41abHzaSTz3nEmpgwaxuCM1u8C8UZAL1FolZl5HPFdm/tEtIjofEM/uY3TkdZ8AHplxEQvpsNgnXzelJQHv0FEFGKNdGFrHnlUVZIH87MGyFO6ZWhCsgxgZz6hloCdG1NrLDVmIjOjN2Ol1kR6qXranL+Jn2eSBxq39sbxdgiOGsb7aD2xyuaRcRB6H6BWwCsBPMlMrNonIEooSRoREwGhiMsOmHsN+Q4wePXOPnLpSoR3aRxOvd+gK8JipVDTz78rdu7hnM64Fjq7JhmaER8IM5Ch/gpKZ8AbYyPYJz/tAt4pzACn4FCUz2QnLpWOpGx+3OMYCBtCc7Dx0Tk+RKREX44EYSeCPd85jLiwQ71xAm5lEkpNL7I5fA0yZc6sj6n4F9WzevhgVkmAoH9UXWEWTm2vCgS1ew8AlUTqM2F6cnI8AYIIQi2OeMLWG37wWJs3m3DAK1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pyiBrOKRqXbzCzokSayRVpGGj7rz2xgNMUIgoCHn1v4ahBVCpYFGzZ0hE9pbn/bBR3NhZRqNzrMLjsKY2Irr9njL6bMUZV/Ccuu1md6B30d6yfVBLrJIeyDtKIRooKuEOh27OYix1xAy+E1swwaooq47SA1VgYZss35YC6brXpZkwejEJoYjQAAEPpr2UGOQ//uGAFtdzv0iFYa/Mb51eMIAddyUN+cABDvksW24AGZikisCSQJkPpb5jBVl2lrgByN8Gz61QiFpjHHV8Ex9PYOV2hHhcg13ExOA9MHIqcggPgXUg5WLhEdGDRs+vUnvnoPDF3qw4hwnk1drRYOl1/S84kvbxZPCl16bxXTshMho2T+BGhZtvSuB8T7jjv0XjZIqhs/Qvj+sFV9RRGfmiEHlf77PFxqiwsLUpxkbdMbVabZQedh3nSoThqNL8lJg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:10:36.4331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad24af83-f579-4eec-54f5-08df2f31a438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
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

Wait for the submissions of the VM in the callers instead, through the
fences of the root PD, before taking the lock. Use DMA_RESV_USAGE_READ,
which covers the command submissions but not the KFD eviction fence.
UNRESERVE_VMID keeps the root PD reserved while waiting and freeing the
VMID, so that no new submission can grab the VMID in between, and only
waits when the VM actually has the VMID reserved.

v2: wait for the root PD's reservation object in the callers instead of
    accessing id->active without the lock (Christian)

Fixes: 9b47649cabf4 ("drm/amdgpu: bind the SPM VMID's page table to the reserving VM")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 1482fc031d44..9c879ac68352 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -634,8 +634,9 @@ int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * @vm: the VM with the reserved ID
  * @vmhub: the VMHUB which should be used
  *
- * Waits for all work that used the reserved VMID to finish before unbinding
- * its page table, so submissions still in flight don't suddenly fault.
+ * The caller must wait for all work that used the reserved VMID to finish
+ * before, so submissions still in flight don't suddenly fault when its page
+ * table gets unbound.
  */
 void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			       unsigned vmhub)
@@ -649,9 +650,6 @@ void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		vm->reserved_vmid[vmhub] = NULL;
 		id_mgr->reserved_vmid = false;
 
-		/* Only for kernel queues and kfd/userqueues by pass that */
-		amdgpu_sync_wait(&id->active, false);
-
 		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
 			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
 					     adev->vm_manager.spm_vmid, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3f19d03fd7d8..c5643344a3f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2852,6 +2852,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
+	/* Wait for the jobs which might still use the reserved VMID */
+	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
+		dma_resv_wait_timeout(root->tbo.base.resv, DMA_RESV_USAGE_READ,
+				      false, MAX_SCHEDULE_TIMEOUT);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
 	dma_fence_wait(vm->last_tlb_flush, false);
@@ -3002,9 +3006,19 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		}
 		return r;
 	}
-	case AMDGPU_VM_OP_UNRESERVE_VMID:
+	case AMDGPU_VM_OP_UNRESERVE_VMID: {
+		struct amdgpu_bo *root = vm->root.bo;
+
+		amdgpu_bo_reserve(root, true);
+		/* Wait for the jobs which might still use the reserved VMID */
+		if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
+			dma_resv_wait_timeout(root->tbo.base.resv,
+					      DMA_RESV_USAGE_READ, false,
+					      MAX_SCHEDULE_TIMEOUT);
 		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
+		amdgpu_bo_unreserve(root);
 		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.50.1

