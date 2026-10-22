Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D0606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=On87HMAZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4415E10E242;
	Thu, 22 Oct 2026 02:44:01 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013036.outbound.protection.outlook.com
 [40.93.196.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7967410E242
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 02:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE4rXxN57aqvgx6a+zAAToxBuud+S5J6tfe4avA4QYIPT383RGJ7sCsBdK8ZnH5bFN1/77mY7O0wN2mKTdUY5T7VTASI37Jn5Vpq/mef6pZBjRt+kyan3Eyuoc8LguqC0DmUcydXEjjxeZSzbwPGnxGUocjEkMPx9SL/0kL5aeMm47H6+ZDbC3lnF8a77CKHDZ1wK+RnHtK2OYifUALjr3BP7ELAoAjY8Rrfv8ov/4n1iul9Dg0oHIhWasWc6jqdtG5sBgWtx33/5nomL+S0snb/gsa7wclxGOf3achKLdERAJIwRqtmsZCVIcU4H7GHB5OGYXFP4hUuXG5+1oeWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ish5T4CmZM+zycvn+ZiHFBNPzjcUW8dtfOJb0Mp+oFw=;
 b=NmRPMNNvFWwhgiE2KXGpuPzqPUzRh69WU1o6+nR49BpH40+Ku7k7jKcr4DwhyxG9iku4KgkVxRhTErIPUZx+sV4qRxSoAWN1etVOQTOeLHxrZHXrgqRBTQOXQIcB59RvDXuHvmsU/c44KDOn/lwbbgNIWsPJzhXk+Vbrp/rz8Ny/h/iYzuueqJZey2xTq1QsmYbIGcpf1kpgQCEifx+H8HGKFbELhx9/amHB0AkqWpftDZsC4CvDJ9KjzqDI0S+s2smF68ldYis341ZtUEOvknTJRUOavpmV0Mv8fYoUQlEDilmI0tpM5+YiCGOhuLqBBhmwgk0z+qfyv6FYLRmPlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ish5T4CmZM+zycvn+ZiHFBNPzjcUW8dtfOJb0Mp+oFw=;
 b=On87HMAZJGjHxwqUfHqllNr46oB6s/aZ3/bBMMsZ6NJ6Z2ZQF6QNSD2pWgbuwt33Tmz5LuNvQ5JWhcvEXxiK/9Ug/PpGX4xe8hE6aefvpQW204Isrvxi0AGS7cexRklR8QoAHV04nbHmCmRu+WmjRLCrgvVUl+RVusN7WIISwvc=
Received: from BN0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:408:ee::16)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 02:43:51 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:ee:cafe::76) by BN0PR04CA0011.outlook.office365.com
 (2603:10b6:408:ee::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 02:43:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 02:43:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 21:43:50 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 21:43:49 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 1/3] drm/amdgpu: don't wait for the SPM VMID's jobs under
 the VMID manager lock
Date: Thu, 22 Oct 2026 10:43:24 +0800
Message-ID: <20261022024343.4187095-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f0a902-0447-408c-d029-08df2fe64df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261021123027099003|56012099006|11063799006|261009223027099003|10067099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: UbB/Rqml9KDLz/eM5trHkCSRIFR4EbZSL8skWFpZaZef/9RBfteuArGyGMUu6kaI1yC+Lmwqjm61tV5fEK+8GcQr3u1xmqG2o1sIkwjo/CSUEb7O0HE3KlSY0THNC905wH7KSikwQaXj6iPxSE/3L0wO8O/qZV6q+U0p4piruzCRGKSd1X+TnmFh2KSstptUBwXS4OyzDDnJ0NPx+Sgy6XF1epC1A0JUstECsF7Q82YtiuB62tWzD19YeL78eQnRjSJnpNbbr/WwRKXHL5gBVG77tTcQEYZeTGOQUr3TKYNHUvTmW6/5ZBoUkk/hzlenVYU+mHYZWTm7NfoKQ3RbHI2SBNLlzYJc9ON3JT20WynR7LXkEo//bP0tBII8qH2+kbjUN2P/qYPW8Kmvr4UWto8Z2vE+U0XAdwThcCJGXFTLGtSB1lwq9vTWwOmvF5+53FaT6tQU7GlhyYATPLdXfBmR3RB4g8uTN5B3Yiam0fW/wgKAzSrjZm4inBJD5GimY5gkSWclg48kTCM/P5iHwj5fZpPkUemIvPM47CEiiNEGxGR5RPaYskPJuUe9a60IbH1uvnq/tr5lWgVvX2adn2MPopCt7PF5oZnT+zqa3tiY+LB76BT5UPJ7TDxIRBf2dT9UpP04lsriYW8F7EQzmV6mWfvoPO/aXpsBy85ePc2m0KmMB5kN126dtNb/Itb7Yu/I4WAcNm85wsapkvDn2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261021123027099003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eMm7uZ867N9unutXgF3MJHAVaJmyy1LLnUtesYjWeGojdODc/J3nxYAHVDdTj05BWDlIXmzhTAiyqIVusi1BKeRcKMLfOWD/QSZEjQfk6LM3ObK2ehyfHom2w/KZ0W88UL+5i55RVhr39q8ecfhqUbK24lrcr/eZpryq46hymBbinnLCxUM6ogYHMT2WRyicIXa91BvuZzWqYEpasPifFpapR8zVkaHx0J6RSS27GCqI9q0YdBXuJSAimogl7+TYpo3fus6lBgAXoydi+wZKgfdZanvtGEMMbg34iec46D6M+MwDVKM293a6CnIPRuUjI0mzU2X2lmJV8wgMqUyzXw/QmMPld6kJUg5yQucimVAO2a/V0IaVtZawZf1t8p7LshCD/LIXck47TKk/RKN/436/9mIgbrSlaPYrPxxeP9DYyLm2hjLPR3+isW4XEQFA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 02:43:50.6598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f0a902-0447-408c-d029-08df2fe64df8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
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
Reviewed-by: Christian König <christian.koenig@amd.com>
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

