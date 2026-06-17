Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D20CD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 12:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7DA10E9EA;
	Wed, 17 Jun 2026 12:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bIRfCl3Q";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7685210E9EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diyBPLXHDtJHZ03rJD6lDEaZcfUQ+Sa8oDVxNpj2boF4koMHgBxpHxv172ty4B+6mXf1ZLm04Yz9z0ZxT2wSpFWMHgA56r6mtD0HXd2lYgZh3nsHEcJUgTBq2AGWI1ecKC9wNhp6QkVo5pSKVFV7YfzGrDtWHpTD9nvYilIL59U1vkCKh1qoPb8Ot1xIHW9x6Jzi0t5Gx1sw95XSDjAf8UJoB28xgiugP0sKVyrBITT//n0ll1lp1KCm32Sa8YXI6vtT8jZoiWaTyt80JfreXSjNweeXfMhxEK3QwIhkownIfk7/CFwjX4CV23sy6DoKJCpU2W0pe3OsTdhd1EmE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03VDeI4rFcWcoX9wiGF2mqukGLcrpdGbAALVqYis4NA=;
 b=Oz3RWmOUr/eT3GdW/pN/PyiSt6k6YqHn0KfYbGhyJSmTS4Z6Yp8a+pC+nU9U3MgkMfnKuPz2o8vKkY5n9y4wxcGDkFVm9KxKwroyhu1jwGvtHyMmkGcRLf0zQFWwjSWXeUc7TyM+O1qHdE5xWRqjQV0W5MmmTgKVEd2ewEOLjy0aHAxeQlSOaHTiXgYnTUKvgNf0gvOUz1cW3G8BzoFG8Xp0R6NeyV+IDcJdHOa4WXCihhPpgmOrsLPLdKAClyfjPbsgXgpe2ycF5d2ZbvjSKqVtDK22VlrkeR/imFVd2vMFw2FKyAw2ecphblPtlKYTl7O7TQjVWtSX2pDVeOo9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03VDeI4rFcWcoX9wiGF2mqukGLcrpdGbAALVqYis4NA=;
 b=bIRfCl3QuE8cSLWeUWsLz3KHXJHtIWpza8r/l4ylDS4XNc/USKzs31T6ppNDK6Xm9G6WrR5uaYghioSypEBSex4poFRU5Lvh12dCT34mkibacqNxt/Pgov0bR1wEit2qWOBG7tzmPMn5oLvcxoAZHJE17BJefYIHDZooyKLTUtw=
Received: from BY3PR03CA0013.namprd03.prod.outlook.com (2603:10b6:a03:39a::18)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 12:51:51 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::3) by BY3PR03CA0013.outlook.office365.com
 (2603:10b6:a03:39a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 12:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 12:51:50 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 07:51:48 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: allocate a per-process CSA to isolate
 scheduler state
Date: Wed, 17 Jun 2026 20:51:21 +0800
Message-ID: <20260617125121.1838486-4-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617125121.1838486-1-xiang.liu@amd.com>
References: <20260617125121.1838486-1-xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 763b7c69-7aed-410e-b7bb-08decc6f3346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ORnmMqc8ETwuJ3FT+/K+fIvo87yh/BJh6puDwExDwx999cqGljnRVUA2oogYBfx/ySb1cwI/s5CtNqXfI1CHc2cTd+42BuNe1DPiltbIfeltS1q9foOgvXwK3up7aFos7k8sKtLnkbgApFEE1GgYqjmGOOdM1mdnoXcNXd7/OOzsbUkcwMafzZ+1oFbCeLJQMPHO3vNNtpYFM+NIWoiPqmvh6M3jSWTKFotjVqCYMYhMHHFXN6bG6DwJ8ZkGVRvrK/FURxNTZVCoAxwtOAV9rdOlsYJ5W8n6DtRvbLc/CxL+GVVYyAPwDt8Q0FfbOv69fY8K8CWdEbP2tca4iJZ/Pb/taw/fyq1Iv8UlYyfZWZ8pr5IgWuOaCKVYJ+JY+HDbXaYrcgs18mxwhqGCOJMlv7A+QNKJPEcjXZnkWNPWNku9BiDCHwDaV0tO6HRq969GAqrc8Dwjl1b/5zWHfr6B+N35IyRuzQhLWWj1jxuMVQNoIeCuPLFnE8tlEWL+oLFHopnYbvn/H+JvPZpINdPUStnS2twUSHG2xJlNB9FrNtMIWyJz7gJs+KQCQhSAfyl3bQv50LN0BNv+btxazeonXxj8CJbFyCbhoRROCi5lToqnilb9MJy7GICbpy3J0lx7Dew6AlvI7ffmZ91Qi9PfDd7T0D+mGmghMSwpka28SXaAai9GkDHHk70JDqjkgRaZ1BhJoFqp+tZ65fhbKBVHZ7sWW+GzjdGiVAMxHAzpGSk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0V1uV3esXX3nTx+Q7kCFkHmptTlBSh4t5tWiGinfPQ1nqqL8bpk1fQ0UEOjIMZnbWJnaYcWt8kg8kbcAr+j/9AqmfB/WUdh03yGGYhBsRfuzCh4Qa8g3LfAxkX0YXLfnZ3FWSNhBOMr0t69zw3Mj6zsfVxMkd5P/2YzAPrRgULo4Qsck2Orc3VV/IA63fTe3fD/TpXUWtlxhDIX8vLOB3mQ6Pb8RVYyZGkMxSbtHe5dgxf7Uyz7gA2BFFB4Ov+3xKUTDU0diH/OcmmnrwS1WgVc2PNJ0YWkx/girmK+S7BxOCQGbHDUKooN/GFdZixr+4cJJW2TnmMJpymgffxBknMZNoKD+Rio7JIkrI/X9h4WUKM8NxslAu/blVOmEvSBwBeht7HxAwqz2R9ZsZ9fLueLyWoFT2pDpx8fAUZDqIEUpQORLTawGlpmTeGJM3DFx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 12:51:50.6095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 763b7c69-7aed-410e-b7bb-08decc6f3346
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158
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

A single device-global CSA (adev->virt.csa_obj) was mapped into every
render client's GPUVM at the same fixed virtual address. The CSA is
GPU-writeable and holds CP preemption/resume (CE/DE) metadata that the
kernel and CP firmware consume to save and restore gfx queue state, so a
shared buffer lets one client overwrite the scheduler state relied upon
for another client's queue. Under SR-IOV this is a cross-tenant
scheduler-state integrity issue.

Allocate a private CSA per amdgpu_fpriv in amdgpu_driver_open_kms() and
map that into the process GPUVM instead of the global object, and free
it in amdgpu_driver_postclose_kms(). Publish its kernel mapping through
vm->csa_cpu_addr so the preemption resume path reads back this process's
own saved state. One client can no longer observe or corrupt another
client's CSA.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 27 ++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 59670aee0fd6f..50ac52f2e0565 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -448,6 +448,8 @@ struct amdgpu_fpriv {
 	struct amdgpu_vm	vm;
 	struct amdgpu_bo_va	*prt_va;
 	struct amdgpu_bo_va	*csa_va;
+	struct amdgpu_bo	*csa_obj;
+	void			*csa_cpu_addr;
 	struct amdgpu_bo_va	*seq64_va;
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 2e1284b7887c3..e0fc16bc7ef23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1529,10 +1529,28 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (adev->gfx.mcbp) {
 		uint64_t csa_addr = amdgpu_csa_vaddr(adev) & AMDGPU_GMC_HOLE_MASK;
 
-		r = amdgpu_map_static_csa(adev, &fpriv->vm, adev->virt.csa_obj,
-						&fpriv->csa_va, csa_addr, AMDGPU_CSA_SIZE);
+		/* Allocate a per-process CSA. The CSA holds CP preemption/resume
+		 * (CE/DE) metadata that the kernel and CP firmware rely on. A
+		 * single device-global CSA mapped writable into every GPUVM would
+		 * let one client corrupt another client's (or the kernel's) saved
+		 * scheduler state, so give each process its own isolated copy.
+		 */
+		r = amdgpu_allocate_static_csa(adev, &fpriv->csa_obj,
+					       AMDGPU_GEM_DOMAIN_VRAM |
+					       AMDGPU_GEM_DOMAIN_GTT,
+					       AMDGPU_CSA_SIZE,
+					       &fpriv->csa_cpu_addr);
 		if (r)
 			goto error_vm;
+
+		r = amdgpu_map_static_csa(adev, &fpriv->vm, fpriv->csa_obj,
+						&fpriv->csa_va, csa_addr, AMDGPU_CSA_SIZE);
+		if (r) {
+			amdgpu_free_static_csa(&fpriv->csa_obj);
+			fpriv->csa_cpu_addr = NULL;
+			goto error_vm;
+		}
+		fpriv->vm.csa_cpu_addr = fpriv->csa_cpu_addr;
 	}
 
 	r = amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va);
@@ -1604,9 +1622,12 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (fpriv->csa_va) {
 		uint64_t csa_addr = amdgpu_csa_vaddr(adev) & AMDGPU_GMC_HOLE_MASK;
 
-		WARN_ON(amdgpu_unmap_static_csa(adev, &fpriv->vm, adev->virt.csa_obj,
+		WARN_ON(amdgpu_unmap_static_csa(adev, &fpriv->vm, fpriv->csa_obj,
 						fpriv->csa_va, csa_addr));
 		fpriv->csa_va = NULL;
+		fpriv->vm.csa_cpu_addr = NULL;
+		amdgpu_free_static_csa(&fpriv->csa_obj);
+		fpriv->csa_cpu_addr = NULL;
 	}
 
 	amdgpu_seq64_unmap(adev, fpriv);
-- 
2.34.1

