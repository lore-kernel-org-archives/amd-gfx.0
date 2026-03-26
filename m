Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF74106F2E8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74AEA10E94A;
	Thu, 26 Mar 2026 07:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gbRKL7Oo";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010045.outbound.protection.outlook.com
 [40.93.198.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D8A10E8F2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x403j7u2J3LlKFPWF31cqhmp+PlM99k2Y5Wb46wtJ2UoJnUlRc7iJZEM0J21dTbwKh/RvLuew2HKJZn3Rz0noSIXEMuA9Z9W/YG8ca02ylI8A3tfZuyjdzNvOXo99hQgkH16MUCwk690RRwO9TQnNXTm4DGoln2Nwn+FGn4CdO6SBLJSMTGWfl+4yKxitux1W1KI/dsE0PkvHQK2uQgOY9OCXKEpkBUpN6Tgl8pTtu23N9vqUEA09R5+NZ3fGmjn4ilo8uoOhNMYLqwRwbEKK7IpoWuWnIQTC1kpAFpeAoTE8Bcxd8tKZmJ8w6e+jPwNeikqJ2iv8zdQpPzASJD0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQTaQuZW2gDP1ii8dJjRnQ1lPtTjKNX5ixRxUs7BsDA=;
 b=TdAD6AaUuWlxoCyHgDDR8o9VKWPE1Ty1ABm0tNzG3uw1jc+yOsn7hTTGAWP+1a73aSRQFYkemGOd5luLI/TXcmwvK45eYnwPWCEvjbkzOwIhYnZOAS1Bu2fjv0cRbaNz/9JwECMxpXATpIbty+7rbaeBi6uhYP7b9Gk7Aqk0tFkJwskyfxeI0H6nRR/avCp2X0XQUWm0dyNCekLF8DmpWHiDg9/MwFAt6HCtzjrbBMp3+4AyySIGJ650qZUtG7lTgGB5r7PObSF69QHcRhyBkK+sCGoIwFWHItCfCFsZlPgpfG7rAveki4uHf4A9f3AefRJdhBaLxwTCs5aHg5V//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQTaQuZW2gDP1ii8dJjRnQ1lPtTjKNX5ixRxUs7BsDA=;
 b=gbRKL7OoF0fEdqcMGJbubgOY9FDYTijktnFRbquWU/3O6/LuC2FGw3/0owRyUOSVlKxv+mBqnEGasFaBC5o/qmEkFceiauKusS59Ypw+Ykcsr3nqHolaLI+uUhNxA/jDLUHWKY7BYQY5zy0vWm2ev6jMuMwNO57HNpTrJYrC0MI=
Received: from CH5P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::6)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 07:55:01 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::35) by CH5P223CA0019.outlook.office365.com
 (2603:10b6:610:1f3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 07:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Thu, 26 Mar 2026 07:55:01 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:54:46 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 03/14] drm/amdgpu: Add extended stolen vga reserve-region
Date: Thu, 26 Mar 2026 13:15:24 +0530
Message-ID: <20260326075412.1378411-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee2858b-4c65-44e3-54bb-08de8b0cfbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AR3pTmB8KKHMCb7dX9yWm5tje/RcXmzNx2FbXPUjj34Sgx15hxf7sVn+s5TqkphXc71r0J6moVkS34zVLy0YevUixK3zi6+0nzsjFiXD8R+mm0SVVg85tb8k3U+pJyoxOXD5Jr6TUskCTtfwJFz9w9f5rHjbME+kt4oBUUHgoxO5OkEuKXNV1UXGfp0N/dIsDACdfZwQlcd369ytrVGg5hJib/cXzhovRRgC8XSdpX5I4Khxmm/uTyXIe0aIVft06qV7QZgtd1Xe1lrhYmOYIaqXID52ICULDHsxYigEGnZUMRvuXGxmt2MCFIP9/Q36sjvh1pteIstzocGvk2M2IZ82kf9AY2g4D/iLzo0IWVMx/PPw/Zp2Hp6I4yVHGBxDGBMtVOX9q/69Ko6Hbjn5LtkW9CoeDWQ7k9EFIYy9ZjC31fXX1pmA/io6/ZyAjiK5l/x1CgqiTejBMuB9GpZy8phDGgU5j2tkZTO1jw7wqHUz5P6ksLM965RzodYZoSu8IMIfTxAE3J3BmDpKnC1ZNxg1cNl/3PQQ1T/brF2aP957QIf0EF8dAfpA1MGjyig/WXpUUwqojbEp4lqPdqm4SjQsARNxOzopYLWHHOhOlNi76xSLxa93Tmuv3bkPDRv5NR1Ckl2PNm3QnemuntwTWN/NekuwmAFyJWSQt4mFGf5QryiMQI4CnXxgC8suLjYNvZ1T+bIlynNZQQc/Mz7hKaLvc2ASO1780yFO+onSbvEM9veKYmgeO0vUbSVB118yZa5s+LeX5/CpGhlDDR1qqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dJMOINeV+fk46MIuO6UAPhhqsrXZDXjA2kcXzAUXA2hcOm4g/ieXWOgvVl1vablHsyrACLSDF2sUxbwghsipoULG4BeZ/KT4W+IoNSOhnQVp/v2L0+4ouJwAiDj8DZzjTTY0GA7kGSzAN6B1lLHl0qjEhF9XPMh3Qyg5jV+nB+1zc2DQhNn4Wdr6ajF1BhpcsNj8B3mi6JI0YD0Et0w2POKtTvkIBNSeHru1uJ1mWjb7bnqwHPa4jLghrOK/0eugcAGSkPwbcnnkYbbxJTGDQxnmFaY/uzbpxUE7P5PpbmPzjKn1qS9gg6dPQHAYXzhSmKw/Fotdy5gK9vE2UuH5lKUcXHWm9yrRM2/8pu0OAJyr/7GxyrGdj0tuiU1S1Uj3YiVDKncGnpzLJn20gGP+nDo8OU4Lp6WqkoCfIQKWGGaWL5sQ4rFjBwfk1A4PxM/S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:01.1922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee2858b-4c65-44e3-54bb-08de8b0cfbbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627
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

Use reserve region helpers for initializing/reserving extended stolen
vga region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c           | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c           | 9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h           | 2 --
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c40ae1073017..61e8d71dfed5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1100,11 +1100,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	if (size > AMDGPU_VBIOS_VGA_ALLOCATION) {
 		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_VGA,
 					  0, AMDGPU_VBIOS_VGA_ALLOCATION, false);
-		adev->mman.stolen_extended_size = size - AMDGPU_VBIOS_VGA_ALLOCATION;
+		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_EXTENDED,
+					  AMDGPU_VBIOS_VGA_ALLOCATION,
+					  size - AMDGPU_VBIOS_VGA_ALLOCATION, false);
 	} else {
 		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_VGA,
 					  0, size, false);
-		adev->mman.stolen_extended_size = 0;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4d344f6bb812..7c6d07c570a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2217,12 +2217,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 
-		r = amdgpu_bo_create_kernel_at(adev,
-					       adev->mman.resv_region[AMDGPU_RESV_STOLEN_VGA].size,
-					       adev->mman.stolen_extended_size,
-					       &adev->mman.stolen_extended_memory,
-					       NULL);
-
+		r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_EXTENDED);
 		if (r)
 			return r;
 
@@ -2348,7 +2343,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	/* return the stolen vga memory back to VRAM */
 	if (!adev->gmc.is_app_apu) {
 		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_VGA);
-		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
+		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_EXTENDED);
 		/* return the FW reserved memory back to VRAM */
 		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
 				      NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 639daed8c984..587ca3fdab2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -99,8 +99,6 @@ struct amdgpu_mman {
 	struct amdgpu_gtt_mgr gtt_mgr;
 	struct ttm_resource_manager preempt_mgr;
 
-	uint64_t		stolen_extended_size;
-	struct amdgpu_bo	*stolen_extended_memory;
 	bool			keep_stolen_vga_memory;
 
 	struct amdgpu_bo	*stolen_reserved_memory;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a56d612da7e1..bdfba0585614 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11154,7 +11154,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		/* return the stolen vga memory back to VRAM */
 		if (!adev->mman.keep_stolen_vga_memory)
 			amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_VGA);
-		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
+		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_EXTENDED);
 	}
 
 	/*
-- 
2.49.0

