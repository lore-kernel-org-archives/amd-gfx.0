Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3D7C61CE7
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B15910E9A2;
	Thu,  5 Jun 2025 01:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dbwURG2Z";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 094BB10E841
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFFC2OrDgkOyxAUeVgqAtDNadMoFf6agyPoXMMuXDNwidZeie+BsseJmjKXd5j0KuLVbcpGwKUpPGuVbp2K0k/BdizzjKYfHmCMjoVv1SL2mThdTfqciiO3ocYavtGzsNwdL3Iz4dMEEuYO3LuLuiDUlqPzrmLl8Az/f2u4XNOAQJyz6AvrUbL6t2/H4Fiaka2t5+FeJg8FvGlH/m+J4mVeRneLVGce6bfVAsxfAi4gFJ2wFSYdR6AMyU8teZqbLGcf3NOQKulZRr4o4PJpRQuVZQ5WKVvNbmMaW/FvJbohKqzSAlbolG+V5Zp5+UF6eIWtuF5rulJRj5pLyLowccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZueChBgAEReMu/LLDCWjln/QY/rTFazf/xQ/aWRGIs=;
 b=KhQfOLU84RDZz0x01vgd8pduSM2KctC/aytSRpHobtIo/if2tJ6KHJtMLUlJMnbfhJ7+sn7RRRJIsv6Vdk28uFNlKsRe2cF3Nm3YWTK6zx+YVJy9oSYcBbcNiANW6xAZ0NXTEw69JYE018k1Z/UJ5qTlZuzM4Z+ayCx7oNWVWDm+FSYB5SCP/Y2Tv7cpBwxTHAzWrAPyVCyhM2vyyFRDu0KJsuy2ejzlIeeYULtTj3rHj/xMkFY+uVX6F492njXyRnNxYImGnk9v/Xr7NDB5PNvUmDzTOyACbpJwDuA+6ya6JbqcPIR4nkFHLIGSfn3NIxfN3r3LxpgwOb35fHVNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZueChBgAEReMu/LLDCWjln/QY/rTFazf/xQ/aWRGIs=;
 b=dbwURG2ZhAT/LYrXTmCQLlmSX8qtuBS+MSvf66UPUW4FfZP6odRoCkV04K6tQVQrNz7Ek3V7TqvOQBbgjvZHhw8DK7PFjz4XELFnytp3PvpiTIM7qhHyoqa2GCbPfma6ixez5fbtXtXABhD8c4M22pSrMCqDKIwM3EY820qdGug=
Received: from SJ0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:a03:39e::23)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:28 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::15) by SJ0PR03CA0288.outlook.office365.com
 (2603:10b6:a03:39e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Thu,
 5 Jun 2025 01:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/31] drm/amdgpu/gfx12: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:42 -0400
Message-ID: <20250605014602.5915-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f2fb91-fe22-451c-72ed-08dda3d2c9c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1L6yot5bhTZIbcKZrpg3IbsVV2ZvVwmu2Zc5oDFwEIOkq1H9GLV94pNpW0Kk?=
 =?us-ascii?Q?CqMy8ZaYxOoyi5Ack7DFW4yHGGnPKQ4QRHZ62UfvJzxZJtsWVTRiqweTwaX5?=
 =?us-ascii?Q?Ai0nfNRdPqyzq5+gLZbZU+5mMg2qZgFaAIs4F21lfkSW7a5D0+9nvBwNKAw4?=
 =?us-ascii?Q?s1VAAkgpCfG/Yz4zszQAAz5evlxS1fRtVlA77ANBapn79etI3LEfEeC1hJJ6?=
 =?us-ascii?Q?7OMTeeNIsoXzFqrVaNevC26CEZ8wMf04GGMCyb/GSG2Xks9cfQ46Md00E0Bd?=
 =?us-ascii?Q?iBhnWS3jYubWAwgWxz7cK95+gco7EBEfI/yj2lTdk03A4nOvDH5+MmWB7Uz9?=
 =?us-ascii?Q?PRD6RonRfW4c1WQqbfVCbe8sdh9QgZ/Y0pPuPGXJ8NrmWv1YRsH+ywheesdn?=
 =?us-ascii?Q?nC7GpZYCf/G49tXLjwnS2PG7utYbgBMEN67XJJjZ4TadDBxrt6VJvaNGE7St?=
 =?us-ascii?Q?hLInU77mhv15FN4QJNVhismV3LEt9Jaj5BOugDCG593rZdvBevw1KtxPybDX?=
 =?us-ascii?Q?n3c+9CQW8aaAUhOEhc9P7wlP3ULJv7Y0IyqqTBXI5kgc+IXVyEMzYOCYNvzl?=
 =?us-ascii?Q?pV0Sc+XQOgUS6HbKjsjBd74J9hI4tgtsfyWVa8bt24qTHV0syfjex1AR4Y3O?=
 =?us-ascii?Q?+o5wFIcbuuZRkOCu1M5zCQkzUKC8cVvy2xAcGLJj5pv0T+PUcCrTo2Q76Fqz?=
 =?us-ascii?Q?rx5pMnV3DHlhvrWozZyOfSteYDS5D/NhoE4xn9CYi38CZDGnUPdyWGOL/HMx?=
 =?us-ascii?Q?Q86OaTKfxEP2EgG2KijlR8xSpcKjoh4EyMCba3DtCMkVjLZbupYwhResi5VG?=
 =?us-ascii?Q?xCVbsa9nsBFfZTdjhwPGErNdagf2WVk0bVSlT2pneP7dO4TtjVM20bGZ/V6G?=
 =?us-ascii?Q?drIM3d9tmphfpZ05EBzgBY7WxPqB/ENg9t7zSfQgsK6frD+VE1Yl3EpXLXlM?=
 =?us-ascii?Q?fQH7KmBXc+h56kT97hDW/QE7Ojxk9lExSNtA4+gLYYfftAxQo5Ntatv0oFWt?=
 =?us-ascii?Q?b7K1fBmdLPprHh3ZmQlw1aa2FVCK/A69icZLBF4e8knEZOa0Abq5NQt6mTrs?=
 =?us-ascii?Q?bSeonxIvudGeV5mwrus8tVYE472axh83BoWv6wzdhJP2KpttFjf+3r8YM3/f?=
 =?us-ascii?Q?X+/OMzlHq972fbbJmFMqBjSIXcarY2Z9Ds232NdDfwjuzfSQe1rEEIfpzT0g?=
 =?us-ascii?Q?ZVfD6YVleS3eghi81TfZtl0pUPze2Fw6I0UB7Epm6I3iEh3xlcZahebz8kKS?=
 =?us-ascii?Q?l2RKf4a4JWGRrVtdEQHrsx35og+3oPulBKhpb0tvCn8nFs+DqxWo59LX5GLK?=
 =?us-ascii?Q?LTz3OqiiZIhaEs8RxorxnEzPXljwOZuhTal9Hd+ESdxkpjxm7VTKwO8Al7w/?=
 =?us-ascii?Q?vHX5jNSBEG6mSX2JOpqxIfdl3Os1H9tATS/LBw062XiKvVcIa3TGmeUv1u33?=
 =?us-ascii?Q?XFgD9XweQOGUlrjWFuIxdagxcOfrJWUfKseu+hLEFpqXdbWZ4eVJ+/DEeytD?=
 =?us-ascii?Q?/7qkhO14Jgk99G4nJbpqlqBU+RCjpI08PMc2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:27.9478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f2fb91-fe22-451c-72ed-08dda3d2c9c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1234c8d64e20d..70abe13c774ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4690,21 +4690,6 @@ static void gfx_v12_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v12_0_ring_soft_recovery(struct amdgpu_ring *ring,
-					 unsigned vmid)
-{
-	struct amdgpu_device *adev = ring->adev;
-	uint32_t value = 0;
-
-	value = REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
-	value = REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
-	value = REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
-	value = REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
-	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-	WREG32_SOC15(GC, 0, regSQ_CMD, value);
-	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-}
-
 static void
 gfx_v12_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -5335,7 +5320,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5448,7 +5433,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 		return r;
 	}
 
-	return amdgpu_ring_test_ring(ring);
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
@@ -5526,7 +5511,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
@@ -5565,7 +5549,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.49.0

