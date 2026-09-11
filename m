Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A1EC88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6508910F4B9;
	Fri, 11 Sep 2026 17:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UwQZTJKW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF3210EED9
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEjRFCp4J3CKjKLhZzsEqwxJYV+OKzCZWFhFe4vFJEkXk44Iut06FrCue+zRjAoWc20ecSAkjlYcK99lt8uf22kwrLuFpl5bWpd+X6wENxHHzJ3uFZBFbD3CrkU5HW8tq21NQsiDiP3HSaO2xnyUtbTCDgr0d6aV7y9FGweWS87nQfw1fdFjaxRoJKEhe/d8UHSBAgTY+H9/ScxqGwb/xj58s7a5MRgS+ryLyFZq3bcxAJ+7ytcIltpwW1cKXiWkmOAXlYOnKuOXPysZAA17Wm0WaDrHkIbP2MOMw2UPCb4wolH5erY8q5MQRRc6DNe6WDJsbgp7k9oRUcrKJVz9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJiaWeG6v5dCbRZn/BS5qYjvc6BpTpwVmO638njr8KQ=;
 b=uIaf3dHTjhqKplvIuCOtNHjJY3ngwpk/9SprAHkof0tKtg/F0Rl2S/8JN3PRYZGWUl85U5FBCroty7FyWqRKlloPHcj+dKD6FfJsAs9DJmW5P3pkxsgUSHxACHD/IEY0iOibbG4wNVpSzK57rq5uoxV17UlXPNea+W+cs/uA9mwkww7ETQ85SO/0cpVxQo0lyaCJJozf/AaEPk3vNZJROzZ46PrLVIKXF5FXOONM6Y3B+gUMTCBfzOgL4dhH6LtvCeeKBnlGUspT2ZBnpOCD6hu5CSjdwtTMn4udd3fIQMPDmT80USicVFdlfuw6Tz1ciZRqUs97ZaoSeJ4FiPiMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJiaWeG6v5dCbRZn/BS5qYjvc6BpTpwVmO638njr8KQ=;
 b=UwQZTJKWdEyMbTtg/AsinTembMqC5M0mJwC+zNWj1YPgPNkdFaJPtN8HtZXMAmDPpjVOAArJK3+hRNjTZth9RIWGopV9hh2R1oYenxz5XIZCUE8Mpr7KtYkKICX48AsxSNsbMZIIz78ZN4lrViwO+7/mcUAKz2e418EExRrZC0M=
Received: from BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::7)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:11 +0000
Received: from BN1PEPF0001806E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::26) by BLAP220CA0002.outlook.office365.com
 (2603:10b6:208:32c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Fri, 11
 Sep 2026 17:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001806E.mail.protection.outlook.com (10.167.245.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:56:03 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:56:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/23] drm/amdgpu: add a gmc callback for the inv semaphore
Date: Fri, 11 Sep 2026 13:55:36 -0400
Message-ID: <20260911175544.1314467-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001806E:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: fdde7d59-37c3-40b8-80ce-08df102df6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: jkDz74u9mDFPnJL1dMaivaMGJX3rVhYpjkXVHHqCSOUf8ZvLgQVyJ+8kj4CwF8f9q9pVlxfU9R3FgyjWFoVmKdeNtLTX50QH3ftQj9DhzrJL3EpHGnh2hFGJNiD8CuBFswBL4RtNANqtOULaL9IWOPghlNQlEKfADyWF2qkkHarYVN5XhLfEQHGWFnuD2pDcYSkFslhXuwPLjHo8k4j4rEN9+MapGOwLCYjJscUob61sEFF8wkvrEBppBcdLzZxVxFvxxK6j99xOYXKW/5BqulOEPmiNg/mSR81zmjt+Wud9X16SB3F/mIGGh7x4EBJC3IndviUEslfFLFRHTngA1WajbTMB88g9y/Q847qcRG0ALak8AhCbYvyYXvTOVsehu6YsxPkgYkP4LFVYS+m5P/e28bum/lr6uUeaVH7laIr4qn3RH66k4L94GLH/1q7o7wDAvXDYSebP+KsxmgceSfjzLAzRmGDfDEv2H8HwzBe5uNdUN/fDExE+5k6wMqfPJO4uqAEcW0USX8yvjsvdYMa5grdxkyL/zUTEebPgx7c4D88zzXfqv3ZvnKhf/YIx/Tg33NGGkeT4f/kqPEIWCZzD8F43mQXk2+q1ykJdLVtPQrR7A9SF7+jVxptkh2nc7nbmLuyJ4i4bcZAytaWT3KRj1XBKLsRbC5JJtPu72CyLYvC8nm038SSCYpP5yyg6dLR+WvaHxrdu56c7A610UQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vmDuIIE1SnY4GvVou3DjVNQrhA/L9TImbWzrMkqJ40AV7Xu34LOjn7hBrZUWFweihiNQNWYW8gyyty1EpwiD2e/R4Qz8TerY5elouz3TbKwcfPVPKbIkyFTf4zud1Y7u8D4cVuxEcnkAtvWRgvnfxAWr5JAxQJxMITzfw+25R7g5NZN5XrscAwAZvdrwP6TL0sH0ntrlh6WJfnb+I7LEVhsW5/VxqoPclBZPe404W473725V33+Hk6kmfhiDtM6av6FrSTExCkDZIAHU8SUM21o8IR5MUzJTyu7ckTPeOtUOs9GdcsJ2uZ9KeB1ubfH4/55zLZiHZL8VEVdBl/cXFunh3lVblIB/Lk1XNCvR7FOoRQ37EsxUNT6RE9feGQNWsijbMzaGhRMYZtHLTwjbSoVhknUVc1d6a+BlEe7n5BWUxspd2Chk+mS2i8YbGhQT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:10.7745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdde7d59-37c3-40b8-80ce-08df102df6af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001806E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795
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
index bbd52028a775f..772f829c5f1ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -178,6 +178,9 @@ struct amdgpu_gmc_funcs {
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
index d1fdebaad488f..4b3303ab4bff9 100644
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
index 715fe442ccee3..2d7ef1e1fd8cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -551,6 +551,7 @@ static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
 	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v11_0_get_vmid_pasid_mapping_info,
+	.use_invalidate_semaphore = gmc_v11_0_use_invalidate_semaphore,
 	.get_vm_pde = gmc_v11_0_get_vm_pde,
 	.get_vm_pte = gmc_v11_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v11_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 17766b7ce8c45..1da76d19eb3c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -586,6 +586,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_0_gmc_funcs = {
 	.emit_flush_gpu_tlb = gmc_v12_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v12_0_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v12_0_get_vmid_pasid_mapping_info,
+	.use_invalidate_semaphore = gmc_v12_0_use_invalidate_semaphore,
 	.get_vm_pde = gmc_v12_0_get_vm_pde,
 	.get_vm_pte = gmc_v12_0_get_vm_pte,
 	.get_vbios_fb_size = gmc_v12_0_get_vbios_fb_size,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index efb8e0c15c968..1c0d0121ad8ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -758,6 +758,7 @@ static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
 	.emit_flush_gpu_tlb = gmc_v12_1_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v12_1_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v12_1_get_vmid_pasid_mapping_info,
+	.use_invalidate_semaphore = gmc_v12_1_use_invalidate_semaphore,
 	.get_vm_pde = gmc_v12_1_get_vm_pde,
 	.get_vm_pte = gmc_v12_1_get_vm_pte,
 	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 9367282d7a5ee..8e2b89c36a4da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1304,6 +1304,7 @@ static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
 	.get_vmid_pasid_mapping_info = gmc_v9_0_get_atc_vmid_pasid_mapping_info,
+	.use_invalidate_semaphore = gmc_v9_0_use_invalidate_semaphore,
 	.get_vm_pde = gmc_v9_0_get_vm_pde,
 	.get_vm_pte = gmc_v9_0_get_vm_pte,
 	.override_vm_pte_flags = gmc_v9_0_override_vm_pte_flags,
-- 
2.55.0

