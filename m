Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5841CC624D3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC7510EEF8;
	Tue,  1 Sep 2026 20:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mb4lnhXJ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9C3710EEF8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLHDLxNuzdXPvHgAmfaNv/fxSbDT9TlCPsEYvoAXnQ7q3HOXjwKKl2g+VfFyJ3iL0KwMt3wodajqE3IBTS/Qz+9FQGn99cba+a+b+SShItfIjf2hfMj9RdouHAY4Wcnv1ryHci6nWC0z+JZL5FP8mw0upDvHLGhc9+tQwnIREqo67ftokw6Z1Gg00sHIvPqN3d9QgIxL0I28PNGj7uGzqUl68jiisSrapXlOk4wEOSt+GpOHRzQUdeW0DRiiLV23r96S92vgISdHxhjrriXjEKu6QVZ9wSO4HyLkFzi2y3/xBNUzkC4fkeddI7u7/8IbJ6e9rxzUIyJv/Q0LWJ1xAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1ChD12/AnHn9mw4BtrXoKaJhie0yfD/EH6kYkFbsw8=;
 b=zMtFIx3gN3Bbf6Hkf3TBlZT3h2iaGsG/cLzkKuLBf/UvyTO+ox44vgd6ngiPxINSRvugb/UYlNUuofTgKyKdTGIryNwpfUekEHQELcM7vBSf0viWPwXwk+1X1AB95RP9GXFz8KJrDDd3O3QsTqYAtwkBBIwNv75LAlEbyrDow0y1qU2X+C7v+fqni+30TaPljIHdUTSKXIWDngCEsWyliv0G7RbctRQaAJXG99Zpi6z/gyTknWrbTx/QG80B3KmyTXCjqUb9pw9ZvyOVpOBfT+tWGs2+ShsPxoqXgGRfedg9tOLKQ/lyVx5r+YNDUgmzjTRcASS2ygWrOd3jtEoItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1ChD12/AnHn9mw4BtrXoKaJhie0yfD/EH6kYkFbsw8=;
 b=Mb4lnhXJVsbAqdBQ/jqOl2I19o1Zpdobug2W3EOM+2Q8f3rJEgWdSisZ74xNwkYHEuSatfrXDd8UBrjjiKD4fpTeGm7bxv0VthTBhHTRYUS0QGMR5Ame50DxqF9zoTFFcLClfApXLvSgdaoD+xWrTvhP+IWoQIzcj+A5CVkYx6I=
Received: from CH0PR13CA0058.namprd13.prod.outlook.com (2603:10b6:610:b2::33)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 1 Sep 2026
 20:11:04 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::90) by CH0PR13CA0058.outlook.office365.com
 (2603:10b6:610:b2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 16/31] drm/amdgpu: simplify amdgpu_gmc_flush_gpu_tlb()
Date: Tue, 1 Sep 2026 16:10:19 -0400
Message-ID: <20260901201034.2960437-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 4456e3d2-1f85-4768-ca00-08df086526df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|56012099006|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: kqQ3FWp2YJ7J/EpOhgC2IVgeBk86d3RU+JksxDu8Sv/AoLzWgCYzZUb4sDLjv+KrcwZuEWmCO9eui99N1/0wYtTaFbPU84mU4UDzoemG7nN8+Do4bN3hSCN6GbvXYM5YJCuaXbdVSgQcF7oouEg7dc4AD9KUGxTtroTFlaXfr6GUbZMfvQYC2+1Zv4UNxxvot+rflSa41V/7i0L9+UP1a+zud3oe5B3bhp7Uos4DnzlyuV4qwmv36Alfif6wPndRmXzgIZtck3mpA+c7+1fkwNuCI1jA4VDZoWKoANn+YL3CRxtVLo9xpmyCJ6TGoQ0mNMDsauPfbmjLlHbHqNZ7pcYV/Y/M2+A0CanDaB39PaiIdP4FvgJEF3tURUE0RCLYMMzwbt9XWWyvr64EFkachGslfxUaWHnTHRXzDXPMoCktofL2A61N0GIHW4PBkW8zj2sCxHWcj9pX0ueZVN+bNhLTvWWPa9t8kFwyXEG9vf6QPiHAswwbLn+QbJlPSj46G15wBQ2RUpMk6sfl0hl9C0NHmY2ZLIicGseVjzGv5jvMmihfajsJqSfG47sZkZs6wDGCcvvqs+IdtDuLNC2gC6CRniKh6Ey+Z6EslZ8JhdCUaUyIRVXIPTxTqdrHDYcUjB7sUC/ClmcaVo7c9kX7yEGcpZWLDEH6af5XSkQrwd4PFtkGDzKa4cAAxhOdXyycRrJvhCHE7iZPsDF08aU+7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JZxPbFADjlrl2s9SgzyrkgheC8j8JE7MGf++74eER4v7zJrh2Ta64u2eqGjRkcnh809UwplYboaFesOrlsVh5V+VHHXvysesID8cAZ4A74pN1GOnIiQ3OhdJ7N/TYNRmhvB91BjH2fdcec0HNqG16eC1LyRoGM5INf9wdA4B14N0oC0NqKkoa+gtPcW6y9RezbsVTUOftF3y+jZuzlk3tADgxE4Hg1SxWhpZug1Glj8KpeRxtm9S5mBfrmmg0MMsnAm0vIg+jcsEHxglvwW+BHYHw/XNiovOXUHjDzkR57y3aNRXReheZOiQHqy6WuyyhMoWr53JLQlssyxg5OGpz694qceGtchqGCI3EuxBz4ET8RGZpBOoSzgtRyQiKqkOObR087qIh8lab1PFtdXXNur2ARE7x9PGzkcdhOolCIGpQDtpfHmNeC3JyXg1Qi41
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:04.6369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4456e3d2-1f85-4768-ca00-08df086526df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232
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

It's only used for GART TLB flushes so rename it and
remove additional parameters that are never used.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 16 ++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  4 ++--
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c4c21dbbbdbf8..0db997c8fa03a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -502,7 +502,7 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
 		up_read(&adev->reset_domain->sem);
 	}
 	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
-		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+		amdgpu_gmc_flush_gpu_tlb_gart(adev, i);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 2f6d20c00ce29..6af4ed2170b06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -714,8 +714,8 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 	return 0;
 }
 
-void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-			      uint32_t vmhub, uint32_t flush_type)
+void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
+				   uint32_t vmhub)
 {
 	struct amdgpu_ring *ring;
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
@@ -725,7 +725,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	ring = to_amdgpu_ring(adev->mman.buffer_funcs_scheds[0]);
 
-	if (!hub->sdma_invalidation_workaround || vmid ||
+	if (!hub->sdma_invalidation_workaround ||
 	    !adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
 	    !ring->sched.ready) {
 		/*
@@ -736,15 +736,11 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			return;
 
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
-			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid,
+			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0,
 							   vmhub, 2);
 
-		if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
-			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid,
-							   vmhub, 0);
-
-		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
-						   flush_type);
+		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, vmhub,
+						   0);
 		up_read(&adev->reset_domain->sem);
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index f8f4df37d5805..23954e3180a8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -441,8 +441,8 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 				  bool write_fault);
 int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
-void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-			      uint32_t vmhub, uint32_t flush_type);
+void amdgpu_gmc_flush_gpu_tlb_gart(struct amdgpu_device *adev,
+				   uint32_t vmhub);
 int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst);
-- 
2.55.0

