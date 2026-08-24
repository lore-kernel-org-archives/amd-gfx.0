Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B79C61DB4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C648D10E86E;
	Mon, 24 Aug 2026 22:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rWE7Kcpa";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BCBF10E86B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHac8MXVOlc+CamtAA7yVL06ZVEaIRwOVhx9NAkdt1zMbLAxPsAKrVLVKyq8Jymwwf75w8yPtUs3JZDeI6m14mhy13LMVjaNlsHp4bxL2PUm9JoxTANacZPyBkvQooMNDUjNzTKY+Am/KwnR+epN2Eq/bHYJN4QLmaPdKJcCwchRj65N+C+ulGNcCAnqkwdYnqHVJUt3EsAPJ54tK/B319UnK0h0KvoqBT5RlVtI97sNY94nyiU92ZQuG5E4fVlrAlk6E8nUYNpMmfXXkQiIJwu108P2U92/PW4ywDpc3ZGOuS+GRS61EmgEfpFybRAfRTotBZqlLrjcsssG7EBg0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ldhClu9cPEzcm8Oic67LIO1InLHvbD+nY8AR3lPtCM=;
 b=EiUhJF9jV7RXP+ljQuxqshBKsgln852oedJJMm3rJVEuYhTYAbnZ/BPKrh3U/dOzacXAW+C2yGFV/4LyM768qMjoJaA2stHmilzsL/fR6rMG5x2vjzROd8cHh6mQ0ReIapvLh7JxqQwGQhWZnlGrCWkM8TE2DCJPmo8mpY0B5u/rntkRWhf3ua7usXDJpOiDDZzzVJgPwJK4jw4nrlxljtvH/iR5UBz9uFOedXHtYT2U1x5ihR9Yv2LOH4XVNWPLn/7dbF+S4FSRoB2dIUGgOE3ka81bG8hvpJE9suKXg3ArZIXH6q3K+IbTAgWcLSvRCNkq8dzev0E4/3etP6vs1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ldhClu9cPEzcm8Oic67LIO1InLHvbD+nY8AR3lPtCM=;
 b=rWE7KcpajV5ufY4/riZor54x/39HqUNRyT1w8Dz90fWp+qi2Ey4PVf2IZ9evuQ+qRG12LflMmGvSZU6UFxNwanWwGYLk3OXwTfooj4Ij4DHNRg0Xu+WU3MCH+Y6ZHkeMkQ7yzDA7J2T8okugOVkN6ay0tb1pac6HNQL5TyiVuko=
Received: from MN2PR16CA0046.namprd16.prod.outlook.com (2603:10b6:208:234::15)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:16 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::27) by MN2PR16CA0046.outlook.office365.com
 (2603:10b6:208:234::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 20/30] drm/amdgpu: add a gmc callback for the inv semaphore
Date: Mon, 24 Aug 2026 18:13:42 -0400
Message-ID: <20260824221352.1793542-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 4337f54d-b09d-4f8a-3e9a-08df022d0970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|56012099006|11063799006|3023799007|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X9hBhuEX86pPe2dKLKu4P4weuB6NJf4QrbQAhMeWm2bjnrnARER5T39Zwjht0nANV7A6IXxYu5Vxp8tniomBU61Zu7OwAsdY0EckKLt7INBGovKPsCrThxx3XPNwfRjWVQ1lw+In79AGwaR3KXdjMiOCHZXAaV8mldQ1KZuz78GhrOD7NeR58oI/faOIi1eQgc45UbPuJgCte22Kz18DF75GvMSyHMPsgitlRemk+3r3vp295EUBLauPdP5EWffndNS+YeH8kij320jiPDt+2/BZtoSe6qQtcbPsuYzRqLcrjMJwhO9NIk2+8SlNV+EXyfRwnqdK4XbBSy7ivskATh3aAEPOiSORle+IPVOmoICJPeiaucfp3CEWzTkVLEdxD6wpIShvlebkafsCCoSC0phoct7+47XiVJFy/7yPgbuaRIw35F9/FBwInMWKO6D6SQcNFDzJ54SKYcXH2hE2MROHpJR5DxcnfAjrbzPKsGfXa5bkJwpBeoOdWg+eWqeQD85+Jp91zwgFcqCx/5O7WPrgt4w0HoR70dybvuyHeSHyzbpwRz/2CuP6QuDVLEFcMTnSye0wEVUwXDpITlHDOLFetFwkzjHNDkRxcnO49GrLXTMb6ir6oUJY63KLbSj9Z8N04O9CLd4NrAgUg3sHPwGYa1ar9UKHaNAifNvGnVDD+C8lcYADT5qkzAfSXGs45U8g6ZZF7pfaotBzVjcRng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(3023799007)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zc6pGNssUx2Az/4K6OE6t1GgRJQaTmG2gHbqexCdEdF9k2wsk1WVxX+2/0bCu26C+az8CtGXaWF8hM1U7+YXADnY4B6imRsFqJjS0ugqfxtI/NZnX6c2b2iEf5oO5PbCjDLPmaNu6wfSehBEHkX5n9BPCJmGXSe3dBS0DzS3TktPLJoL/DGrtgTV5PdfX0Ub8AHP6gYOXsgVx+qTN4Rb9679HwzG/lMyzo0T2u1i/mZtIb8ZCDx5O2MizZfsSImCWlvOb1O4mv6zjNKSfwQHh7One9RLCgS8ceMGqkUAB1A8dHFZ/89PUMups8u+cfFg3lSFMu7jXAyY9i84dKRm0PE4vVb5CI4HIRSXQZhCMAQ8ebhw5uRvA0vuTWclb/jqhrgmapbvzs4HM3Qzh4nAke+wrNiI09CsbZNr1U633uNsCP6Q+fiQnlDFWLsuZcli
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:16.4606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4337f54d-b09d-4f8a-3e9a-08df022d0970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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

Used to determine whether or not to use the invalidation
semaphore for a particular hub.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 1 +
 6 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 27785b1b38ccd..f20f08630408e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -175,6 +175,9 @@ struct amdgpu_gmc_funcs {
 	bool (*get_vmid_pasid_mapping_info)(struct amdgpu_device *adev,
 					    uint8_t vmid, uint8_t inst,
 					    uint16_t *p_pasid);
+	/* determine whether or not to use the inv semaphore */
+	bool (*use_invalidate_semaphore)(struct amdgpu_device *adev,
+					 uint32_t vmhub);
 	/* enable/disable PRT support */
 	void (*set_prt)(struct amdgpu_device *adev, bool enable);
 	/* get the pde for a given mc addr */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 0028639448956..4bb10a89ce582 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -557,6 +557,7 @@ static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
 	.emit_flush_gpu_tlb = gmc_v10_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v10_0_get_atc_vmid_pasid_mapping_info,
+	.use_invalidate_semaphore = gmc_v10_0_use_invalidate_semaphore,
 	.get_vm_pde = gmc_v10_0_get_vm_pde,
 	.get_vm_pte = gmc_v10_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v10_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index b34bd7881726d..acab9f4180da6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -548,6 +548,7 @@ static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
 	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v11_0_get_vmid_pasid_mapping_info,
+	.use_invalidate_semaphore = gmc_v11_0_use_invalidate_semaphore,
 	.get_vm_pde = gmc_v11_0_get_vm_pde,
 	.get_vm_pte = gmc_v11_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v11_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 9179dc0787f13..889c0005fec3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -583,6 +583,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
 	.emit_flush_gpu_tlb = gmc_v12_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v12_0_get_vmid_pasid_mapping_info,
+	.use_invalidate_semaphore = gmc_v12_0_use_invalidate_semaphore,
 	.get_vm_pde = gmc_v12_0_get_vm_pde,
 	.get_vm_pte = gmc_v12_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 3fa1ec3dca273..d6be7c092a22d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -669,6 +669,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
 	.emit_flush_gpu_tlb = gmc_v12_1_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v12_1_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v12_1_get_vmid_pasid_mapping_info,
+	.use_invalidate_semaphore = gmc_v12_1_use_invalidate_semaphore,
 	.get_vm_pde = gmc_v12_1_get_vm_pde,
 	.get_vm_pte = gmc_v12_1_get_vm_pte,
 	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 19a10acedc6ce..13423258d33ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1323,6 +1323,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v9_0_get_atc_vmid_pasid_mapping_info,
+	.use_invalidate_semaphore = gmc_v9_0_use_invalidate_semaphore,
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
-- 
2.55.0

