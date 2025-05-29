Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDB4C5B554
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8561C10E763;
	Thu, 29 May 2025 20:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JWjwUd5d";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C04AC10E755
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqHAjHE0Fm4rQbNulnMMqsBNiyoQuOLXvV7zqLW9GT33eGzLZ4ywdtn/kKppIC1WVVH89ECrBKx4zjeo6tlt0XGCQlPxfjaCpVXN9jECf74bcTVBzl1zApH9CJYe8hj7ARfYGHYBth9RGYcI+Mcl7al8zFMLEM1kcG5XWbFMhjpEJZNUGe1R3FczFnulLyJKha1RXlcf1FrMn2Udr9c2V1bMFEy1tKFIbY4Fe0tz1ZbbOVyVhym8CzUjr/nyPj2IZy1+XdqNn3tFZwCRkUHiZ9X7N9OtzptDA63uvC1sp1t/Zm5XffrwoDkFhUKaTPl29y1VcKzRW3Is9Rs40NoPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnMzzMwwAC4eriUtOfxS1fRgUIDBXUQ+9Z1KOtck528=;
 b=bmq/DD0LzGQyzv7k/DHkvVkSnkOXsf6undtuxfi7tI8jH4Arl00Vjmr1iAxeaopIOa55t/5tcE6OBQN7FKcW9IDm9iUTh8PSNBcfP8rwvyGjMM0Ua/M7wWHLQS/4jWdNOzHbeDQbOQJfmG48JUDOYL3L3eAUjt8JftFHjWsbBruEjzydBRRdkdZxoSgrDYzZYBxPU6mM8YWEFopdC7OP8RBVDFr4LePzla1KyfCpD8yelajNro/WfZWMKnf9WmnunRnLfppysS/+JjZSQJFc79xiOlTpG5KuMKM3/uQb7cGB6I81WVUCywGLdgAuaGghYno7VCNy3fuXDR7nrp1eQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnMzzMwwAC4eriUtOfxS1fRgUIDBXUQ+9Z1KOtck528=;
 b=JWjwUd5d59pDh17VvGzeXyqK8ATHAgrSTStu/OWQmZOZu2XQxcEwtOqNFk8Gb5Fw6fcZDXhlVfaVHwCtJIFiMeaax3KLlamFadsaD2vnTPb/10705ZyGTxE3ClO2KNJkRl4QOAZk937cHv3TAUCqWeIzWRlojmrYKE/BHtKZSAM=
Received: from MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::26)
 by CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Thu, 29 May
 2025 20:08:24 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::f2) by MW4P220CA0021.outlook.office365.com
 (2603:10b6:303:115::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Thu,
 29 May 2025 20:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/28] drm/amdgpu/gfx10: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:38 -0400
Message-ID: <20250529200758.6326-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|CH3PR12MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 227d7a8c-5521-4ceb-688a-08dd9eec9153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GvjSznnVPsU2jhOqQjJgM5aFE9vWxA0E1sqD+/Sq1oEb5dKsYMD3j2arE1PM?=
 =?us-ascii?Q?XeDVMLEBQKCRNWGlw/l0ErBlQpNKn55smUF8WrT1Z4rrluzQNwZdoX6tfIm2?=
 =?us-ascii?Q?/2i7y8o1GuZ1Ch9UCbAdv8yzx3bLLLfQbHN8akr6MmMkdG4HjRWSn1gTwmCV?=
 =?us-ascii?Q?Ambfw1vTSWKDtjmBS9w0zAfGsJfsN1lxeCVxzqZP81ho+YNyRnAr5MTQgrYz?=
 =?us-ascii?Q?Wztn5FbaBKXGZYNr5iTqJyL5IQXgu29jewC1y73LHVKyrc3Eb44M7EmQ68/u?=
 =?us-ascii?Q?ymbC/V2FQ7E+KBob/vXBjLd7mZ/Jql7wPJyrRZnckrVuJZicL7MI2S+iIqqm?=
 =?us-ascii?Q?dPDJ8Wz1D4jJMeBYnYnC5+pKJZ2GitmI4XcyzY9qJGvTqHaP0eOYNfn+tpI/?=
 =?us-ascii?Q?dmE0cqU1nclwlgO//ViDxlgN/jhN/eIqEZX9NP4czkNxzE/GnQFwU6GM1VJ1?=
 =?us-ascii?Q?0izJv/UxkJi1LELuTlWzRacrpAjwXqNuJedTOLkpV+ehtqdNHjzb2XRL6dEp?=
 =?us-ascii?Q?YSWiea+E4pN3Ouu5lMwUGNwUGWNXxZrNJTJDKKvQGvrVg4mlp6op9FKvBGw7?=
 =?us-ascii?Q?6tdNIi0l0vGdjDAkjRC4i/VF8ZxeNqeKSYjsAmTnAYle1cOH/S+Ji3/a/OdN?=
 =?us-ascii?Q?ZZCYHr9gKGCNHloZswWKMsqdqihKxQsB1dG5tFP90kJHQm5lSBzD+LGkfmdg?=
 =?us-ascii?Q?0gPxS/4auMZ0LZ09RWcNccfhTA/nC7s/NPVYaIYnDKWJDgKOEVxGuimeHDtV?=
 =?us-ascii?Q?zBVEPpKwae8GUk1igC253fvOWA25qq7JSRIjayasM5NbjmmKhIw7fCRCjASE?=
 =?us-ascii?Q?l4q5vjnTLWEvs6v2D1HfjM8r+m32YX1vXFJxqIUHl8YomssGg3r3RhUAJ/So?=
 =?us-ascii?Q?W/wpwAK+dii8HLbGMfQBLkrW3f4Un/yi0cPwWqCrSGhR0ZMyXnmCUcTWbx6C?=
 =?us-ascii?Q?f6A8T3ZryD7p8b6eaxUKCkEdyHpUOk7CdG7SFpaDnXhEoBeo7rQs165IcbIe?=
 =?us-ascii?Q?XKkptfeBHkDBDF45yhtdVlmiv4ro+9NZrQyi+EE9LcaU1SoyuimIS4O+1QKb?=
 =?us-ascii?Q?gS/ekgoeibEgm27WIsu0o7JrKibogeXNRKENaX81C/YFoKqPdDDKgnCphrYS?=
 =?us-ascii?Q?YdF7ZinHjfkEicXqqoWzY/gXGeCk0/fridzQwOfzeAFCOY5IyM4hJc994tOT?=
 =?us-ascii?Q?8oK6UGuAPcRVp9RF/55gaP+IoYcClMT81FrLgk5Owe6cN0SAGgO5mgKrp2Rh?=
 =?us-ascii?Q?gQxo11icwm4NeGpLdqCNpKrO8tHqrQO4Uqeq0DAAezv9MGip9YuPMVLuz6Fy?=
 =?us-ascii?Q?3k387yEt6+9pVIOBM1ByIr50+BCCFWhmEBK7/bUELgPMg7c/ctWzoHzhmrDL?=
 =?us-ascii?Q?0tDvbcBWV2cqzfw2nrAQGIxCM7q19qtfYYgKxd/ecF7xkJ1kSzYaHc2qY+73?=
 =?us-ascii?Q?wKd1VoORWIwcwwg6oNbHLAJuAv29TVfTBFp2JZNqlclfF7PDX3d/swheVEbX?=
 =?us-ascii?Q?6RLAFTT27sqgHexpb5r2+jfVsVRqTLLm9l0d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:24.2854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 227d7a8c-5521-4ceb-688a-08dd9eec9153
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8308
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 31 +++++---------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb5..18ca21d719d2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9046,21 +9046,6 @@ static void gfx_v10_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 							   ref, mask);
 }
 
-static void gfx_v10_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned int vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, mmSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v10_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -9562,10 +9547,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 				     SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0, 0xffffffff);
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9575,7 +9558,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
@@ -9603,9 +9586,8 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, RESET_QUEUES,
 				   0, 0);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
@@ -9641,13 +9623,12 @@ static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
-
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r)
 		return r;
 
-	return amdgpu_ring_test_ring(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static void gfx_v10_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
@@ -9882,7 +9863,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
@@ -9923,7 +9903,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v10_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v10_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v10_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v10_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v10_0_emit_mem_sync,
 	.reset = gfx_v10_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v10_0_ring_emit_cleaner_shader,
-- 
2.49.0

