Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E283E106F2E8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D1C610E2EA;
	Thu, 26 Mar 2026 07:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3mE6zcHg";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33A810E2EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDtGMRM6w+JEicvJ5bx71YINfPGWidMr66KGfnvV8q0BmsvZzgKowtmlP+Gl6y40a9zwZVjaFBXR6SaIMghSLL39RkhL1bqOi2dJYxuu3M+17KzywGXRyHIQQh3WUYHts8V3U6y/xPVhglzb+l7gUmGLelZ8ouSGMBClogGlBCxuYWr1BrVogB5wAMou8hTWOgvWHeRoxwh7lTOZGJjEqcej6VlWBzmUwE0XvmbC7YviYHwUdrgsiCXP49RAVdQkvc3QZ8vJlmKL1kPq8bGaGCrmzqrOL72skMN6S/zSLUOfD70E8ohEnZDQZ6ueXOWpq9VIar5G8qnFymntBp7gPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ4LLXO5tiBHkBCRyqjkG1xlygL8ZKTs6ypv+eSg9+o=;
 b=UH/7lJsxgpPG7YputOlmEVh5Z3ryIcIOxonnfmSdQSJG4mFlXDeI8F7L8S/nx0GqXr8k8JZTPnLNd1dkWsMYzpdOKEMPK0grJiF4uFNyjrQtASh9K/0ybX68dsf6b47zG9p4aRTL0Y0Ic7WSikuwVm9XjN9wLUBWNntcfP6jjtb5iXW2eiquRpKm++g0Ndq65ToEgSX9APm5AmEltnLuNlA4MWwfYIx8G+lmEDPW4+8SeF/7ntOnS4tOuMc8HrRr0g4J+j1wDPtrEZwVc8hTH7HhANxcs6Or3s2TrV0bx/97Z53Wz5A1Bb0YzoCBxTmGTGZdJrUa/jnWk3zPnG43vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ4LLXO5tiBHkBCRyqjkG1xlygL8ZKTs6ypv+eSg9+o=;
 b=3mE6zcHg4vDKw5IdiOOSDHsFuEmB7shCLgNyi1nPV4WOZ/5cQ9J/pmTO4N/kr3SveNGn2VY0Vs5QtYJFZuUH7OAVoV2q+cd+j8+d44LvLZ07pPewTysZMh+84NP/MXDl9i2pqlWFs94Qee7tgtWRAnKgByrcJJaPjQImfyDftmI=
Received: from CH5P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::8)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 07:55:00 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::dd) by CH5P223CA0013.outlook.office365.com
 (2603:10b6:610:1f3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
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
 15.20.9769.0 via Frontend Transport; Thu, 26 Mar 2026 07:55:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:54:44 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 02/14] drm/amdgpu: Add stolen vga reserve-region
Date: Thu, 26 Mar 2026 13:15:23 +0530
Message-ID: <20260326075412.1378411-3-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: e77a5b1c-c8b1-4d64-9ac8-08de8b0cfb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: fHTgML/HgaKy10wfFIStewxG6n/ENiqurpUxSdoB+Bq/WPo07oqrPXMmRRD8g6WOTs5nDpJvktL5OFsvfJWO/PjEyTzgtlYaPLQKBCOe2EeFILXsMEsCcQs3lYn4fVKOLZk8e6XZom3Ck4RlLWT5gLSQPl9+q64I+L7yagWs7uQmwgeVovI8x5yudFEsfNkEwcvvbHG5dwvOwDFIFiTpy35lmX4O5IVYpZIrZV5PQoydK3TvgGcTdJVnssQbec8WsM92XhkSHm5cCoWIws7NQXnW24/87FYEK15wVQ9xqFvuRgny+pd4KmA80uapKqkIgXMWQKz8xydzqQW6qmNXNwxNZ2gvxmQUA7xN30OqP/I3flUOgzaX3cYtYtfLcphHd2yfR/ddglH7239dUhHkjOwVUJGDmVD6ZSCIdJd57I6l5afoQzhBOHtdgHr1HFH+Dbv5GIcpFrmftmqhcVtQJQxNdKJCoIIA9JdxaVTzbhWFd9YbjOYvaLf0wl5ODcZEWdaY+z6nDDGRayY00Jl5qzYlFDYYGpWUQAh2KSTybnmoEYPKH4xNJ7swh9YujqA5S9oMuYhJJzypZwVlpjrTq9uP+0H3uTJ1aNA8HNMDSIg3mLE3riJCjoa5jVMC0wJ1umBKyNexaPFBby0JusfjkVjN5sVeAnjbqSNq5kPsLIy8b21UJdH5MQAV5csColeuHNp/ES5Le9VfoV/G3tjtfCOq1+mXh7LW3XA/00qJk8scaLq4jRakb6Jh/q/+F8NO4uzRvnD/JHQO8Bt9lkTTmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uAHElOt0/gshD/HeAmPhgaxaLRxgybleJR6doh3evXSXDaCs0FQjkjYF5p1AKlq8h+2HhXCQ7B59JdniRS/lxfj99q0D0SmCVWF79jt2RAQD8dJM5ZcShhUvAaKsJLw9PY3XDJQVgJPkFBXWvmUKmYCAeaOCuN7lRsjiXByeYtZmHGuemky4Dc8vzequ0Ectm3mxubKJXc2cuZaQOhlMwVqTaGA4XQq/npFMW/HDtE2OKZJeCXihY5KCF1XY7oWy17TwCWmaD7a8V9GzRdF8xXDvJYKeIedbEm5atYriRa39ou4o+XuC9s/GQ4xv2+tOJbsTr9kqpsXzBfwCiIel2voz+glaJE3/GUoqxvpKsCoYnSrDzk8MBX8cPuxiqHZ+BULRoTSx69dSRjMgyjY3oI5jfxIOMEPEq4seRZKoVVdAGmEBr/ykif9gagpVthzH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:00.2378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77a5b1c-c8b1-4d64-9ac8-08de8b0cfb26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
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

Use reserve region helpers for initializing/reserving stolen vga region.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c           |  8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c           | 10 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h           |  2 --
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f165d4e401e8..c40ae1073017 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1098,10 +1098,12 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		size = 0;
 
 	if (size > AMDGPU_VBIOS_VGA_ALLOCATION) {
-		adev->mman.stolen_vga_size = AMDGPU_VBIOS_VGA_ALLOCATION;
-		adev->mman.stolen_extended_size = size - adev->mman.stolen_vga_size;
+		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_VGA,
+					  0, AMDGPU_VBIOS_VGA_ALLOCATION, false);
+		adev->mman.stolen_extended_size = size - AMDGPU_VBIOS_VGA_ALLOCATION;
 	} else {
-		adev->mman.stolen_vga_size = size;
+		amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_STOLEN_VGA,
+					  0, size, false);
 		adev->mman.stolen_extended_size = 0;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 45011176d4cf..4d344f6bb812 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2213,14 +2213,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * and driver.
 	 */
 	if (!adev->gmc.is_app_apu) {
-		r = amdgpu_bo_create_kernel_at(adev, 0,
-					       adev->mman.stolen_vga_size,
-					       &adev->mman.stolen_vga_memory,
-					       NULL);
+		r = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_VGA);
 		if (r)
 			return r;
 
-		r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
+		r = amdgpu_bo_create_kernel_at(adev,
+					       adev->mman.resv_region[AMDGPU_RESV_STOLEN_VGA].size,
 					       adev->mman.stolen_extended_size,
 					       &adev->mman.stolen_extended_memory,
 					       NULL);
@@ -2349,7 +2347,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_ttm_training_reserve_vram_fini(adev);
 	/* return the stolen vga memory back to VRAM */
 	if (!adev->gmc.is_app_apu) {
-		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
+		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_VGA);
 		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
 		/* return the FW reserved memory back to VRAM */
 		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e8fe34751bbd..639daed8c984 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -99,8 +99,6 @@ struct amdgpu_mman {
 	struct amdgpu_gtt_mgr gtt_mgr;
 	struct ttm_resource_manager preempt_mgr;
 
-	uint64_t		stolen_vga_size;
-	struct amdgpu_bo	*stolen_vga_memory;
 	uint64_t		stolen_extended_size;
 	struct amdgpu_bo	*stolen_extended_memory;
 	bool			keep_stolen_vga_memory;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d73095ac3ab1..a56d612da7e1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11153,7 +11153,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	if (!adev->in_suspend) {
 		/* return the stolen vga memory back to VRAM */
 		if (!adev->mman.keep_stolen_vga_memory)
-			amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
+			amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_VGA);
 		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
 	}
 
-- 
2.49.0

