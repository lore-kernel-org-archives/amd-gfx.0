Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BCB606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PyV3Du4w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BA610FF85;
	Wed, 18 Nov 2026 19:03:20 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092DB10FF85
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gw10aQxpJLmfLenI9n0nuh0N0dXY6gqIj4PXdEMmEyzN86r84YQegrfaPx53byo4UYq/EbUn4R9/IPSdf1mk5XB6oqfxRwBJFUgtWF5I57S7V6ADDWHOAxEbHQ9PKJVns6pNf9xQBYl0afgu0woF74oLTQ2EFmFo99aj8QFDJ3cHoV7rCkbFz6fDliHwTpTRQ326HqcxNFKaFYTEfEZpiGWZPZGr5dCHIyv9kbgkK8gkmd7TIczlYPTwoeZK+RXln5PdefLvjWD7robf112mP8DOqtr17yZKDSC1WaCBTsIdmLYsAM5Sfl+C+GnvCyk4x4UwgPb8Gmh+dY8CPKeREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF3IJYe6ocY/A0nCJ+xhYlWXySrNZHfLMQ5+e0bl8Fk=;
 b=gbwAZGPiAht+oexve0u5m6kYft4tpGVJZSKpfn8j9AM+rMPltlfmWWeb6P2+ljW3g5bbJ3OqJxBGODllQMEV6WfwxIKnINNy6bvNPSpTL29zXBroEgReU/rBWPZqPVRLcMWvk/IUMg5g39hOreLrb/yEiO2F8ywrHQpyDsSQ8H9oiOb9yZ7EvCNLif9VFV7oj3tUC5/Cw3fdyvVQbr6LtiJiwEPts/0hVEeEnBfmQvZYF5MFCNA92+2mfrNYYc1n2O+6bisE+et8His6glxFvjL3LiKzOGDKoyaHWetBBOjtKi4CerguW8u3b8dkF8yhnqtAdvET7hdahu/wY+x1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF3IJYe6ocY/A0nCJ+xhYlWXySrNZHfLMQ5+e0bl8Fk=;
 b=PyV3Du4wiRQ1qstvPFIDbiXjfhzYe/QFWN2gSGNnwASxlWFd0AJxsMRJJzt6zTWyDHaOiMtdxUp67OZhv82rqtFVkpMuJhSeRHf+Wy0l1Rl0GnXFLADf3CRFSbOWgCVXzF25/qlQYBEIHCVT5fHhEssHUxWrW1Hq3DI8bxgVF6I=
Received: from CH0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:610:e6::34)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:03:06 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::56) by CH0PR03CA0299.outlook.office365.com
 (2603:10b6:610:e6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 19:03:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:03:06 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:03:05 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Wed, 18 Nov 2026 13:03:00 -0600
Subject: [PATCH v2 2/3] drm/amdgpu: unwind bo_init on GMC sw_init failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261118-superm1-amdgpu-memory-leak-v2-2-38365f37bd5a@amd.com>
References: <20261118-superm1-amdgpu-memory-leak-v2-0-38365f37bd5a@amd.com>
In-Reply-To: <20261118-superm1-amdgpu-memory-leak-v2-0-38365f37bd5a@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 07435296-218e-46dc-9d6b-08df45a69435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|261026140227099003|11063799006|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261026121527099003|261102123227099003|261028144727099003|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: kIH73bccu1gXKVcFuOi3fVULITKif0HGGDKczDdnLvtANUS2sBJLKSVHO204xoEP4yQFCddWrlIopBRtsNcVzFgWSgetCfHjw9pMMSY115OXpaNoBR8raJ2f99rgp54vdld619rAlrNKpLSMmXSJMgMMDrkHkEa3SxiRlqV9Ga+vKZUuqd96wvl8Z8F3VIvGmvX4BIYpmelyOFaAwP61zIDtK5lqrJfv5CPMAkZWyI8o3WKU3WWnsE7qjUrAzeOInGKXQ0h93FWDv5Qi6sewwRCTwQks3eRFkApqPtSty/Vo3lWWmo23umohPTamff+thIoTiryq/Cz6RUBkjgJAL4KJPoKz0gRQTjFvsaIobrcLiFLXMKtJCd3AGSwvc3D4u7u1fVOOVICWNtw4LfQUg2nuBIHbs1gyTr+pHpFOzvXCG62tXA44i9cN2HSFaKao0R0TYFJ+Zmu1J67EtE6Z48V+I+Px8J1uYDiasOVqIm08aWH3xhAOaJeqI8deEsW5pV8dqs6gvdIez9AYQ+A0QU2jarob6lHMgcFVlHhwUs1ob3KrCBOFCHQ9mEn5llkf8irBhY+/dpnHTXpaXja3TSzxq6JnBws0DulNhh6UzE3lmfbvGc8ohvo984+ERmDqz6uc+Ou79gsSXtMFBC/11S7SVy5Gl6SpcVJf7jAwuoHnNbdw1GTKYWkkodYNDg9whRbNQ8oP4JkQ9fZniqkcPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(261026140227099003)(11063799006)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mEz6ZxYZyAhBwMyT6019f3X3AC0LcEhwsRMwi6nsnj9LF2Rp3NodqA88MGHwz45ZWar/g65ldpLtJJwuqUfYawTt/guV1YOYZozhT27tffiIKz1T0tICsMOE8qJadMX/Npl81fsbfDEOToWDjG94ynmTTaEIgJPB2gro2wOGfEps2Mso+zNCH9MTqpMxd4lL0YWTwVikTqHITSo/aokt/ekLlb5WYNX8aY87XqRdfs/wkhcmdEoC8wrGviIxadLm841aEGWnQfFhT/zd4QRnXDWjKT9VuOedpU746XG84Xckntlq1h9xtgxogTtp7JZb5WsC5ArvNOwy53MA+FGFkgh2/IyxVJhHM1Xhjzge5Gdjtz0e90vca5Jlztxq1tS1hE4c/9oZvvZxmLiFKXe4hhk2EdzM3cD8dOUag6IL9ovlY8k6oq+VIry0Nm26LmhT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:03:06.2947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07435296-218e-46dc-9d6b-08df45a69435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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

When gmc_v*_sw_init() fails after amdgpu_bo_init(), the GMC block's
status.sw stays false, so amdgpu_device_ip_fini() skips its sw_fini and
amdgpu_bo_fini() (and thus ttm_device_fini()) is never called. The
freed device is left on ttm_glob.device_list.

Unwind on the failure paths after amdgpu_bo_init(): GART init failures
call amdgpu_bo_fini(); later failures (RAS sw init on v9-v12,
vm_fault_info allocation on v7/v8) also call amdgpu_vm_manager_fini().

The GART table BO (and pdb0_bo on v9/v12) is pinned in VRAM by
gmc_v*_gart_init(), and pinned BOs can't be evicted during TTM teardown.
Free them before amdgpu_bo_fini(), as gmc_v*_sw_fini() does, otherwise
ttm_device_fini() warns and leaks the BOs and their backing allocations.
On v9 the GART table lives in system memory when there is no VRAM, so
use the matching RAM free helper there, guarded against gart_init()
failing before the BO was created.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 11 +++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 11 +++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 15 ++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 17 +++++++++++++++--
 7 files changed, 73 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 49f593fe2a876..61e4b535d0a30 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -861,7 +861,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v10_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	/*
 	 * number of VMs
@@ -880,9 +880,16 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_gmc_ras_sw_init(adev);
 	if (r)
-		return r;
+		goto err_vm_fini;
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	amdgpu_gart_table_vram_free(adev);
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index bc3b1ffb54886..3879e5a817e42 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -859,7 +859,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v11_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	/*
 	 * number of VMs
@@ -879,9 +879,16 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_gmc_ras_sw_init(adev);
 	if (r)
-		return r;
+		goto err_vm_fini;
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	amdgpu_gart_table_vram_free(adev);
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 3bb13cfed92fe..b4ed5783ed5fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -987,7 +987,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v12_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0))
 		gmc_v12_1_init_nps_details(adev);
@@ -1021,12 +1021,20 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_gmc_ras_sw_init(adev);
 	if (r)
-		return r;
+		goto err_vm_fini;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0))
 		amdgpu_gmc_sysfs_init(adev);
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	amdgpu_gart_table_vram_free(adev);
+	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index a7c353d1ac09d..135824824e53d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -817,7 +817,7 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v6_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	/*
 	 * number of VMs
@@ -840,6 +840,11 @@ static int gmc_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	return 0;
+
+err_bo_fini:
+	amdgpu_gart_table_vram_free(adev);
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 static int gmc_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index c09f5153679ea..565054d14d6db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -999,7 +999,7 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v7_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	/*
 	 * number of VMs
@@ -1026,11 +1026,20 @@ static int gmc_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->gmc.vm_fault_info = kmalloc_obj(struct kfd_vm_fault_info);
-	if (!adev->gmc.vm_fault_info)
-		return -ENOMEM;
+	if (!adev->gmc.vm_fault_info) {
+		r = -ENOMEM;
+		goto err_vm_fini;
+	}
 	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	amdgpu_gart_table_vram_free(adev);
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 static int gmc_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 15592027e7c0c..986ff114f06a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1114,7 +1114,7 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v8_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	/*
 	 * number of VMs
@@ -1141,11 +1141,20 @@ static int gmc_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	adev->gmc.vm_fault_info = kmalloc_obj(struct kfd_vm_fault_info);
-	if (!adev->gmc.vm_fault_info)
-		return -ENOMEM;
+	if (!adev->gmc.vm_fault_info) {
+		r = -ENOMEM;
+		goto err_vm_fini;
+	}
 	atomic_set_release(&adev->gmc.vm_fault_info_updated, 0);
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	amdgpu_gart_table_vram_free(adev);
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 static int gmc_v8_0_sw_fini(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index a705830ef436c..5d40e2020b4a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2026,7 +2026,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = gmc_v9_0_gart_init(adev);
 	if (r)
-		return r;
+		goto err_bo_fini;
 
 	gmc_v9_0_init_nps_details(adev);
 	/*
@@ -2066,12 +2066,25 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_gmc_ras_sw_init(adev);
 	if (r)
-		return r;
+		goto err_vm_fini;
 
 	if (amdgpu_is_multi_aid(adev))
 		amdgpu_gmc_sysfs_init(adev);
 
 	return 0;
+
+err_vm_fini:
+	amdgpu_vm_manager_fini(adev);
+err_bo_fini:
+	if (!adev->gmc.real_vram_size) {
+		/* GART bo may not exist if gart_init failed early */
+		if (adev->gart.bo)
+			amdgpu_gart_table_ram_free(adev);
+	} else
+		amdgpu_gart_table_vram_free(adev);
+	amdgpu_bo_free_kernel(&adev->gmc.pdb0_bo, NULL, &adev->gmc.ptr_pdb0);
+	amdgpu_bo_fini(adev);
+	return r;
 }
 
 static int gmc_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)

-- 
2.43.0

