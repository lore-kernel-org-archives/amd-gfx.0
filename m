Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D25C624D0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8D010EA5E;
	Mon, 31 Aug 2026 18:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VQEWIvEq";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A59E10E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIeqvmRpp4DN3S+/lDFxscjYhsBVVM5aXc1LjTCUqoN4pF08YRuA85fOJn6LbYPYbM8a4lEdZQF47jl6+yfxGBJlelB3XdVFEe/nYnLifBdq2O2lpCJir/3Rt3Gw1tXKbC+kbwfgV0paKrgsc46MRevkzjcsT9IFQ2xsn1VNTv0azFqjaZ54nvj/U51k2Z3M0u7HO7Q1KCNGs9dcSrpL1swMMQqKyTaPlpPGX5ZkUquMf/QDdJjyInR8y2hTMSw0fIDUSuMti3aQ6CofkupPRaFG6lKrn2I4N0UgcJmzzwW3rjX09HrhbOLQvcnRmIrz0TJR4r/pifbiSzX/M3z7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwubbbijW6nnNxoH04HqrrW64Sno0GksjyZZfEmHdHU=;
 b=Gy8s5n3QXmyc6EiQfkQE6KJCgp/nbEa7OhkA/S+d7ONTTmijhS+gn/BiNs7FttFmgSSvJMZ1YRN3eJfvfHi+XGUIxqnDLMXuu6iMRq/6L2HduChYTeqkFjfeOWVhtxzHGc+iAnaKWitiSJ2+QehbuXXrWhhgvquid3cmN7O6Ew93Aflh56wdRelUTzOUKfHyUci5qTJ+285XwdYsHlgRkILx7FS8WXpNdQpem7ClnJIOo9eqF3YETEPqkHb2EuzVcYzTd+TA19sajHAGG6YwC1aKewxhmoLe6o7W1lWaDqJD4b0dujIN2HejyuMXXeAxKLB45OvlxKlMG7pkAgef7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwubbbijW6nnNxoH04HqrrW64Sno0GksjyZZfEmHdHU=;
 b=VQEWIvEqr+AymN9R3QAzhe/+2MkkBLf4DNZngPou7Z7ne4YWxAoblrpRGtQoUKrbbODzomjfvHHw+iMxvslBhGw5CTX1tOmzoEIQRntSeM2K6nHgiupnyEYrGDaEJVwnV8B59tbTcWcSLItkxjGVlIoB/itFElHfpeqwEAz49TE=
Received: from BN9PR03CA0132.namprd03.prod.outlook.com (2603:10b6:408:fe::17)
 by PH7PR12MB6905.namprd12.prod.outlook.com (2603:10b6:510:1b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Mon, 31 Aug
 2026 18:28:38 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::82) by BN9PR03CA0132.outlook.office365.com
 (2603:10b6:408:fe::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:21 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 23/95] drm/amdgpu: Add a new NPA Address space
Date: Mon, 31 Aug 2026 14:26:42 -0400
Message-ID: <20260831182754.1089811-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|PH7PR12MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: ad327980-27c4-48e2-4f1c-08df078dab46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SuOAFLHoJdy7ZtcHU2E2RuJBQYQU1KorhARnsHK4SbnlUtu0RybUeZrsfJFOQNB1JgMf3Apn4tJDXer2HQvwYPdrYulfNkfd3BTJm/NSqELMC8uYo2YqzihdlLmgNE29NhnFTyfhkdiLDoddS7zoncCP0vWZNrwT6+DnpvCp05wqpIAYmL+IgUQS7ZSwKRPiPl6p/Dm1efkvJ+b8BJHjKtabXY/YQyNRJsJZ1a81bUjN71Ya62NKslMnmF3uDMaUFlhxC/TMJDqYXWp91Hbh6A/OeMDRtvrT9GXAjgqshjcoyJJ7gBu78kmJQxkj2X3iKaED3Du34eex08AN8fJo5vOxy2SbNhh+9qR+qzJpx+nTvNUE9HigLIBa0hlD455DiVtkSQNN1+Bl9W74pkfCEV5BxuGlvoY7LxUnORmn0mJjKlT/MltEOQW3w/bo71DBFt45mU8NM0S1k7rVDRlLujWE9/kfYMWHwrcXSzyIb+F6qdkFst5oqg6VvEmILn2t5SvwyWNCdCakWEmEQL2xk8Z8e0cEeuysMYrPo2aGplROXmMRLiUzVA89i+LBSibMGoxD0ETPQo+5LIqJmfqD0HsE+67t+oO2GRuvYFLNvqfuiPpi9/OVdbB2DcPOkuLwjCu9/MLTveYrqx+BuRWYSvBz1p2jr/NhzakFfJsyT5aDPU/ucj7w8SpzJD+lqYD2NwMeq5wiVU/k1TetFc/FuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gi/JBzS9iRRGhO5mfGMVRIzmHhmc+y+6Tsq8YxvJrMpNn5EaH9wIyP3Abzbf1BE3a/D1QR5y6XqXta/4yuCcavTtywOcbFElXxg+6B3mevKlU16QhNC16C8eEeJlDa1E1a8YFZPg4kUDabFvjb7f6cgBtq4PTAz8CwEjOLdA3eR5sW4dV9JY5nA0Rn1YeO8iNMMmOiBpmqMCEScfHohi2YW6OAZ2SxxSWfMy92sLiV+1rXFHoUXC42O4fFbLlwJLpiD3eRpUcbVjoyEtpEhZiTDJjUWcKk64uKRWnlhRJZfG8PwghC18jZNQSYt1gzbS4EjZMflmSp1CVq9zm8m7R0fyojm3GjydIKBEE195XNwixdAoTBM3I1OnISY/x92DDqVIO5zrK7odU5UG7cAeD25BjNa3JbL+mY0mvXYCAqciECj0LznzUV1qBKD5qZbc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:35.4771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad327980-27c4-48e2-4f1c-08df078dab46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6905
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add a new address space for NPA address management.
This is needed for sharing buffer objects across GPUs
with each running their own OS. The NPA address space
size can change across different HW generations so the
size is initialized during early init of the driver boot
up process.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     |  5 +++++
 include/drm/ttm/ttm_resource.h             |  2 +-
 include/uapi/drm/amdgpu_drm.h              |  6 ++++++
 8 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 5d9d137209b6f..fc6d3fa62d794 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -204,6 +204,14 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		c++;
 	}
 
+	if (domain & AMDGPU_GEM_DOMAIN_NPA) {
+		places[c].fpfn = 0;
+		places[c].lpfn = 0;
+		places[c].mem_type = AMDGPU_PL_NPA;
+		places[c].flags = 0;
+		c++;
+	}
+
 	if (!c) {
 		places[c].fpfn = 0;
 		places[c].lpfn = 0;
@@ -1663,6 +1671,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 			case AMDGPU_PL_MMIO_REMAP:
 				placement = "MMIO REMAP";
 				break;
+			case AMDGPU_PL_NPA:
+				placement = "NPA";
+				break;
 			case TTM_PL_SYSTEM:
 			default:
 				placement = "CPU";
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index ff11a09034997..b41767c7913ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -169,6 +169,8 @@ static inline unsigned amdgpu_mem_type_to_domain(u32 mem_type)
 		return AMDGPU_GEM_DOMAIN_OA;
 	case AMDGPU_PL_DOORBELL:
 		return AMDGPU_GEM_DOMAIN_DOORBELL;
+	case AMDGPU_PL_NPA:
+		return AMDGPU_GEM_DOMAIN_NPA;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7a46a26a5fd34..bf575b05a4124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -129,6 +129,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 	case AMDGPU_PL_OA:
 	case AMDGPU_PL_DOORBELL:
 	case AMDGPU_PL_MMIO_REMAP:
+	case AMDGPU_PL_NPA:
 		placement->num_placement = 0;
 		return;
 
@@ -580,11 +581,13 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 	    old_mem->mem_type == AMDGPU_PL_OA ||
 	    old_mem->mem_type == AMDGPU_PL_DOORBELL ||
 	    old_mem->mem_type == AMDGPU_PL_MMIO_REMAP ||
+	    old_mem->mem_type == AMDGPU_PL_NPA ||
 	    new_mem->mem_type == AMDGPU_PL_GDS ||
 	    new_mem->mem_type == AMDGPU_PL_GWS ||
 	    new_mem->mem_type == AMDGPU_PL_OA ||
 	    new_mem->mem_type == AMDGPU_PL_DOORBELL ||
-	    new_mem->mem_type == AMDGPU_PL_MMIO_REMAP) {
+	    new_mem->mem_type == AMDGPU_PL_MMIO_REMAP ||
+	    new_mem->mem_type == AMDGPU_PL_NPA) {
 		/* Nothing to save here */
 		amdgpu_bo_move_notify(bo, evict, new_mem);
 		ttm_bo_move_null(bo, new_mem);
@@ -2277,6 +2280,16 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		dev_err(adev->dev, "Failed initializing oa heap.\n");
 		return r;
 	}
+
+	if (adev->ualink.npa_size) {
+		r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_NPA,
+					    adev->ualink.npa_size);
+		if (r) {
+			dev_err(adev->dev, "Failed initializing NPA heap.\n");
+			return r;
+		}
+	}
+
 	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
 				AMDGPU_GEM_DOMAIN_GTT,
 				&adev->mman.sdma_access_bo, NULL,
@@ -2330,6 +2343,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
+	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_NPA);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
 	dev_info(adev->dev, " ttm finalized\n");
@@ -2712,6 +2726,7 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type)
 	case AMDGPU_PL_GWS:
 	case AMDGPU_PL_GDS:
 	case AMDGPU_PL_OA:
+	case AMDGPU_PL_NPA:
 		man = ttm_manager_type(&adev->mman.bdev, mem_type);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index af1e7fcc71756..adb6cfae50527 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -37,7 +37,9 @@
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
 #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
 #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
-#define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
+#define AMDGPU_PL_NPA		(TTM_PL_PRIV + 6)
+#define __AMDGPU_PL_NUM		(TTM_PL_PRIV + 7)
+
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	(1ULL << 22)
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 318e49ec0de4a..4b3e1f3af3333 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -133,6 +133,7 @@ struct amdgpu_ualink_connection {
 };
 
 struct amdgpu_ualink_mgr {
+	u64 npa_size;
 	u32 psp_if_ver;
 	struct amdgpu_ualink_info *info;
 	struct amdgpu_ualink_ppod_setup *setup;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 0c52eb5e8e288..73fc18ec94a20 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3197,6 +3197,11 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_init_rlc_reg_funcs(adev);
 
+	/* Set NPA address size here as its needed in amdgpu_ttm_init().
+	 * NPA address space is 52 bits or 2^40 pages long.
+	 */
+	adev->ualink.npa_size = 1ULL << 40;
+
 	return gfx_v12_1_init_microcode(adev);
 }
 
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index a5d386583fb6e..f5d1ad7a4efc7 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -35,7 +35,7 @@
 #include <drm/ttm/ttm_kmap_iter.h>
 
 #define TTM_MAX_BO_PRIORITY	4U
-#define TTM_NUM_MEM_TYPES 9
+#define TTM_NUM_MEM_TYPES 10
 
 struct dentry;
 struct dmem_cgroup_device;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0a113529bdcbc..d6d5402a1e789 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -115,6 +115,12 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
 #define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
+#define AMDGPU_GEM_DOMAIN_MMIO_REMAP	0x80
+#define AMDGPU_GEM_DOMAIN_NPA		0x100
+
+/* User-mode is not allowed to allocate NPA space. As a result,
+ * we don't add AMDGPU_GEM_DOMAIN_NPA in the DOMAIN_MASK below.
+ */
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
-- 
2.55.0

