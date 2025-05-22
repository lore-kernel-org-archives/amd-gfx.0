Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25A9C54F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BCD010E765;
	Thu, 22 May 2025 21:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="epVVswiI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EA910E70A
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iT1H2zA5oS6oQKPBYFHKwiCrjHudO6HkXvT08GjCpqdqmkWuTJ2klLhs6k1P/c+lSYInBGWO+7ZNdWPkGMtGK7FogSLzJ3yCKtnQXPGrXSxz/8ZCzeknXg/JbpkJ1WRQXRH9YHuk/JNCpXL2OGWtNwM9xbb1sBMFwq8F6c/lCVUPVgLZSxNyfoQDLVLS6xb/oV8/gjjIjsUf7umdE2C3ki9pLFODW9UF8/EXNC9PtHBqitNwgjngzAOtVVU3mMSlGQShoZfDGuYvmyRjxJJtce0SGAAzDJgSWc92EfrSeab7lEw8zBb61AVn9TGh4x28KIcJPDLki1Ov7qC3Ih62/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPaSKRURppt2HNEI1pCbDK+eChpJIXnhMbEkk5v88cU=;
 b=QktwPQfUDlVH3Tp6zE6rKQ4EsWsiQp4fDF5wsJtAXUbrYfMPUBR3Q0rbMXZojkwmv3fz0JE6DoKD5Qbn8vXH/ctIrvxFNMGngvWlImqaS8eQH6+motNSJ9v+/+vNT6k2mgsAbV2aP3TOFpEdRqhJ0MMgWThb7Y5rSPIb87uy4vIa+SSRL15ljk9RfO2XsC3DhbUpf10v6xL8aXZBp5q9DCXMtPkGfo6DtsYk02iLZHoQA4nTqEVNdFk578gukJUtsWKF88yQ7sjEWiGXslFxjPGfFyxo8shSzDNieJmn8baaMmqOdrJsLsLZmR90kFAp7ax8T7j1nYDKTZ9TXaPPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPaSKRURppt2HNEI1pCbDK+eChpJIXnhMbEkk5v88cU=;
 b=epVVswiIEsQmuzA94Rb+j47n1x8W79YgnVIVwjwvlmTRztJKJ2XNCMtOPpIzTbnFHwC8/mpUCUv+8nEEbq9OqRs32cQb7LSFNCPG6PvGOfQlAqFAiVzIORwqTtyXeChWIGo2JMVvWlYCbPZrIJCE5a/IksZpM1qtHz8A+K0yZXo=
Received: from MN0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:208:530::14)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 21:56:18 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::96) by MN0PR02CA0016.outlook.office365.com
 (2603:10b6:208:530::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 21:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:56:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:56:15 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 06/10] drm/amdgpu/gfx11: drop soft recovery
Date: Thu, 22 May 2025 17:55:55 -0400
Message-ID: <20250522215559.14677-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522215559.14677-1-alexander.deucher@amd.com>
References: <20250522215559.14677-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d70406-78f2-4c44-58d6-08dd997b7af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2n56eRZxuJUsMpKrfC+sxmEVDmRIxtf6BhFUa3pI7dk7gq5tHCvZEToHthRt?=
 =?us-ascii?Q?kqmSTAXdSJ6UY/CIHaZ0Vkfxa6a8cHmvA+yNes8mV5WmSDMs9hMvG4j2lezS?=
 =?us-ascii?Q?9QtqadI5tLgPg03MeGbsSB/SXf1b4JW40c4SULbP79OglOzN0m5sSO8ihipk?=
 =?us-ascii?Q?Y09v2KBYrrdKgmvD0+0BLG/VRLvYbuiiY/aze63Z3Y/vsuyCRCoRjmkC0a09?=
 =?us-ascii?Q?OP6tiDV2qsYXH86ixCGj+l55YwPbEHwzqO4UGYS47KaCjRil+zjIVkCts73X?=
 =?us-ascii?Q?r0Rb85hg5jrkk+CualnpeBvL+kXU1Xf4Psur/Bla8jFY2QHenvu9fa5KPVQu?=
 =?us-ascii?Q?gTYYAlriFCW5sze4AB0BJmsayir3ZdwCn+9Uxc8btf7Vjho1FLtXnxFo5e/4?=
 =?us-ascii?Q?qRJAwbc5N35MRHFOHbo5IIUcEBoYEzyySXaQgi4F74VYrBiQldUw6tvHghxB?=
 =?us-ascii?Q?y6WZaZwtWxWIvhIYgT72HDmD2xhFWM5UA58Kf8QwLXXVCYkyF0QVeqT2ba8x?=
 =?us-ascii?Q?Pu305KHphXGQCujr+M/fGnN/HHd+3XgWwNKksbEp55u4uhoxgyOCwZp9p4VF?=
 =?us-ascii?Q?RSRce6i+KnLbWhuZNr7xy+Iw+JA8BBxRrSxIxqVku5nxifRSwD/lvKyH9o9E?=
 =?us-ascii?Q?0CCpxtD5NIna9czn5S9bass0jCw5rl6ZnWqpe6QMfyMZqsPGijp0QUi+wN3F?=
 =?us-ascii?Q?ECTYUlx+TkmO8QyslOVGsn/3VG2SUGqi2oMHB3eoNXeGqI20r7sg3i9yPOb/?=
 =?us-ascii?Q?c2UnvvgXLVDJpf5vxu8t0tBWvl9FiAZfEMZlr+FSL5gx4gwujlhc0YD2Un4h?=
 =?us-ascii?Q?VqR8+S9ZIPgY5vB0bg3jWMlY8mByX4peYKG84N/y4CGH7ylg1r2Psslj/3nZ?=
 =?us-ascii?Q?KxDWFs46eTrR4p7bL9u3H+YYirXu6OZvCxFQi1zEVTXai2p3MOoo0uL9wEDO?=
 =?us-ascii?Q?HHMPVJnFoJaU/nHF5iuM9SFc57wkN6ItD1EGOcuA9lFHB/oQCcxRLqKy9oHm?=
 =?us-ascii?Q?mCANfgkxI6mgQl5y5BbfCKDP6HX5q9ZCx5PPQTidHI/Uwm8zfRffyXrqSUV8?=
 =?us-ascii?Q?aVbddeULz+kfW0m2TjMHZvOLsMq9BgTXThJKiI8h+ph3jMcx89qVLzpyTSO+?=
 =?us-ascii?Q?DzK79OouS+nIWV/M+o6GHwtgb5OR9dD45j0TwngY83LCn7Qw96xzff47HnZW?=
 =?us-ascii?Q?4julXVfKXPXM5HJw2DBN+5L83O2uw3M/T1iRQzzYVuwzRUPhfIlen7Ci/sSz?=
 =?us-ascii?Q?RII8cUaYUPi5pJuKNR+sT79cw7Iknoq7XffMMJE3XQXosa0YvKpUZBFMF/YW?=
 =?us-ascii?Q?NIvL8VDYEi6equbNrBteocTTV95i+2FMvO60QhWGmHw6ykb4Ot13sw4726bS?=
 =?us-ascii?Q?l5ZJ+QUyYjjMG7qrg196gAJpcq6OOXfnhAo2eid/kIioBSmQPoR6p6znwi9p?=
 =?us-ascii?Q?THOTaW8Fuctw3hETLjwC88ywKPTUYjj6sGXbe3+2ExzdCs6cjaKdSkmyLblq?=
 =?us-ascii?Q?S+hRPBdQxf8Ty+iKq+VDsUem14FZZ4Hey1/W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:56:17.9065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d70406-78f2-4c44-58d6-08dd997b7af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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

Drop wave vmid kill in favor of queue resets.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5d57dba08717c..188c38611553e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6280,21 +6280,6 @@ static void gfx_v11_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 			       ref, mask, 0x20);
 }
 
-static void gfx_v11_0_ring_soft_recovery(struct amdgpu_ring *ring,
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
 gfx_v11_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 				      uint32_t me, uint32_t pipe,
@@ -7233,7 +7218,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
@@ -7275,7 +7259,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v11_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v11_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v11_0_emit_mem_sync,
 	.reset = gfx_v11_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v11_0_ring_emit_cleaner_shader,
-- 
2.49.0

