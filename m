Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F9CC624D8
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2652010EF0B;
	Tue,  1 Sep 2026 20:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WJR9G5Sr";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7313610EEF8
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPO2TqZCt1qLhDnPuvRb8koCwzXaGJFf7A+PqGrr1gdRfY10Jgk2s0IoFBupPJdnVF1cCls7BphOXcoHoUokv18A3++p4yjZ7on0KpGolRKX2bMybjFO5qirGF4DQApJt9T1hbJyEkGWgH5pHc4/l9HA2zLuNMz4ppl7Oq/dmw0O/0l8G4vKhpNFHNed+A9VPC7oVXTSGs44q/xjpAElzxi8lsn1RdJaTITRughHDacuH8XR34VYkjev/Ume7pTfAp510bfBCKLi/a4BaA45RHipOJCRKb19h6s9BZFBwasUt1kwA3eyEDjifaCs6Xt49FQj+FjY4+gubuUxlC+kmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j5fn7PeMf7CcAsJwxp9r3/RW9CN70h1csjzandCaQk=;
 b=aNVUz5eflb3Af8/+h38bVNHBGjVTMTsyKSoCOEzX82IbpFBOtTRR2E1tEC43ATWeoereWx6I6ze7+YCiPWR6Hk6rOcSLI3PHpMPYciB+DKyfaBiw+nJI94Srjym+WphlILZSUQqEOpx/WVcT21OiUM4xHE8KESsd6lSbBdY7X2A5yG4+52eCiFeThFf75STtAs5mS5HOI5x8ANytPNN1e0beTGiCRE5F8NU9IE/6VuRo2YTUYC8PvS7oHWwj8zDxNePL7lEp4V5voeoQitHS8lnzpe0YFWsScw/PH58MqsmudOwpoBJTxnWixw+4naRMCKUM254zyQvlHXGtSxic8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j5fn7PeMf7CcAsJwxp9r3/RW9CN70h1csjzandCaQk=;
 b=WJR9G5Sr1zuo5Y6eqFYAFZl/nnOqUW/xL0ym78pGCl9BYc48Gunsoqo6GLcM7ppGYDPfplQ+5Qi8cLkDRkYL5jHr3qxH5lKC9GcySaOfbB8lfmsvBiXz0Stf8GuyGPO2eIt/EkTTLxka1GTWoorU31h+xvbiem0dWSmCHhs+2Zs=
Received: from PH7PR02CA0002.namprd02.prod.outlook.com (2603:10b6:510:33d::33)
 by MN0PR12MB6032.namprd12.prod.outlook.com (2603:10b6:208:3cc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 20:11:01 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::97) by PH7PR02CA0002.outlook.office365.com
 (2603:10b6:510:33d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 21/31] drm/amdgpu: add a gmc callback for the inv semaphore
Date: Tue, 1 Sep 2026 16:10:24 -0400
Message-ID: <20260901201034.2960437-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MN0PR12MB6032:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f37105-8474-41c8-8f32-08df08652455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: +RPDT0GfLAUpMureo/RDvnSGMKIBlWr+rFvjEzy3N/qfMEznSVhtmshAGLdDvqrYQ8w4lwoIusqW2FPp+Carxu8VrKVNq6QdpeB/Ly0xEBZR8GRZ+lDp7d1kwOQHYO+iTrCjVTymC/0BndTF3iHyv4F2PlxP/NTS++l74GezfQXtYmM9zU0hJh+B1CwUfPgpNBD8FpyY8mtR+sL4ksTOA404Aw8PVIY3hyjLBjpQiSgSh4KVpA/feyZ8HM6vUOH727hmjWDKUDuPoffrtb/Y8QLuFoKPap+QfPsU+aZdzpKdpXNO+fk0qCB/IBx15/4x8t6mrDpDkHzg7kcDBhB10S9vREk8ExDRw4GUpWpylf3/iXSR9nBVg+/45/WpU0C4F2Gj8+fZDrftjdkQnJu6ZE5hWmSp5ayc2Pyolbnq2/oJTmy2VOJH2qUwUTnxhsw1U2uOQZRK5/PoOB5XTopNBuNxLLgzpCgN5aldG+TissI+qsSSKzLO/b5b0xW/aIb+8stgBn4Gxvr00dNSd2KOQAb+rojkzJlCTX2GBSjycvyNrmGiifq6M+9FLJgu6wVyi+enLmVKbyRZkeJEeC12//3OKBSLqhzf+WNbGTWO4pUXWKU+UiS7mmljJj38sNnGzbKM4xfr4wemXj8Zp2hUA/GtZpsFsMfWuZ0BW3gikj0rYbKQZ+tPXJCcTH0FWQl4tzLdURImHf/tJaRxbntylA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x0noiE3DRyktAOJAQ8VSabWpwleGMDZAqYjapAIi+xdXQkezDAVqthJoyuBfhDkj5s0GaaLBvPHIqLBU42LRlC6sXIgLkO0L2nmJVcx4R4hQ0GJoip1Q9qGqCHV8xm7WrF+DmqDZwdYFjGmDxbHWcY0rslh8qfDSjjrfHfth5ablzPq2RsIMvSy83Wywa7ImD5NteCneQ6iSOJkATEfKss9gZFZWNa779n90oa15e3K4iLFTU/pHozbnuIJLh4xBA4NHZii26aTI7YdEclX3CYX2ru3BcL2dxVLnp4YsVAOogmAFipGhdwWGNSmRuVPS7TAIFpf9KRy2/Qb/KnmUAK+3tmj8BdYqfXinilrvZgw7qifObUh7GF0dRhrHCtaGWz8xol5CPxNv0eruyat/wmXp3OM97l7j9GYD237ds7IyRMLYrg3jXqqm+Wgy1pyn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:00.3326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f37105-8474-41c8-8f32-08df08652455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6032
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
index 0019706b0b2a9..3c13a6920171a 100644
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

