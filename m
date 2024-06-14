Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DF2C27C6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jun 2024 21:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B3AE10E292;
	Fri, 14 Jun 2024 21:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lH+rYCdo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7C610E292
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jun 2024 21:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Edun1Ypwr7zyjsJ9QxF+6vC6qYKb6W6MnVpaNihwZvhbYvH+tkstbrq5BIGreF+0fL7LhoArBm7GIm5YXpTsRP4mvQsctKF+qEsU643rVpn0BLsx80KK52WbRpguhE9m5cv3l3z+z+f88q/9KK2razWiSpiU20vptuaKe8zu3TJmSBPOrsSVFqH14FcgHZawiaIPs3/h3Xq3qZUeZp5ibFk5PInEdzAU4QVc7q6/jv37hxB3jratrUxJ6nSxa8kbnKVjiS8pf9vJ+m5myoBDpTYMD2nEOqGfv0LBC+W4oy0NyuulG2k7pNpFQcDDRbs4JmlADbrBOMOoOCvsMaSjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KF+PNeGAooYQWO/r8FKdLJU2IpkYldR6csenwQxCJRc=;
 b=I2rgFO48Z0OnopwwC4R57SkEw6evI/U7n76KcR/zrqO5JJuKYIBSzEc0W4kwUSuTj5Q+ww8MKdZizfikx3zN9J+uGRrxT4AjVT/LJiyJ5h0JJN00UyBkrkUo0eHBqprc3KxSG/hLHnSfBqtW8bZiYA6IABH/i1pFlGaqQlk0zQD3YyX9QJkfkId3bVMiIype+lUgSSutvKKiql4JFibjN9k9VSippuwNGrvJvMCwMCpPw2V6Ye19P094qRm6IWB45MGAOcRRqRqbze2T91eXJCsqoUurN7QWd3EP3slihx7LhPm3zWiW/xbl+ZkWUey5XP0ZOZwSfjDw4kdWLBbjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF+PNeGAooYQWO/r8FKdLJU2IpkYldR6csenwQxCJRc=;
 b=lH+rYCdot/QN9xG1qX8fFbcUCmohiLMg91Y23E025bhke3PwNEq7I6F2wi42iFj88sdyNpaYeTen0YBz94fzBZpLkzoE6/18YtiDT3IvD2rVyzA7KunQRilZvZdfVmy3+T038e9es4eDF1oZYPD87rA8FE+KkV/4cYdyDIW9+dI=
Received: from MN2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:208:23b::26)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 14 Jun
 2024 21:25:46 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::8b) by MN2PR11CA0021.outlook.office365.com
 (2603:10b6:208:23b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 21:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 21:25:45 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 16:25:44 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Add missing locking for MES API calls"
Date: Fri, 14 Jun 2024 17:25:31 -0400
Message-ID: <20240614212531.195093-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb9ac29-aa02-49c6-572d-08dc8cb88dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cm8ppIkWIaxNghQTh5wEbLHCU5YR58zkBM9V1nGHgWFg5lvmqnJwXYvEmYRR?=
 =?us-ascii?Q?JzjLUFbXFUSYtmuAwiyTnRedC3EUxNBsffPZJ4Rh8WX/bZHiCC23iV0ptO0j?=
 =?us-ascii?Q?6h5IanzuP6tnFu8l1mOPEvoMWvzxkFVz+Ce2w6qUQ1xP2vcBcZK6skaDAA7x?=
 =?us-ascii?Q?KfsrNhaHRZaHxt+RtuKpa48w76gwz9ydIvNvlZXwoaEzRLWFGil52XIv3kF/?=
 =?us-ascii?Q?9Qn36yxB/O++3dy4AEgLNt1aWaTgM5eD+ysPro5VGY3nCo23lwZzq7KXDcsn?=
 =?us-ascii?Q?0ai+Fupc29QVcb2OAnXzsAvuCcawcOm+DQOVJbwSlcVycVPR8QwUIIjbHUzt?=
 =?us-ascii?Q?rgIi8JtZNU1jY3CWEnCm2oZ0VpyjjMOuSXcx/vzq+iaJt5W/ZMNaq9iCBTom?=
 =?us-ascii?Q?tXehfj7y8tfI/B32nGHjMV3HAbpIVZaPQ/Ng7S7UsVXBaXfRCKtLN84XjeRp?=
 =?us-ascii?Q?QAg0wKzVZZx5t54Qm0I+x+OvnVRVKt78HlUk8wLu9aKtoUIvUpcQtAgd/6w4?=
 =?us-ascii?Q?fTdBuh7ICwyCmTkg3Ebi+StZupStqdW689ZLgHNcTM/fM5Xx31gDiXUW7zsR?=
 =?us-ascii?Q?74FMfPeL74h6B5xUA1JNXPnn+vdehmdWsskr1SDs5g+vhdeHFB6ZxJPCdxFL?=
 =?us-ascii?Q?6WmQElud4H0moATX3n+lemli6zj6ur9atOv5psbSkOYmWfBP2+K7SujaKNwe?=
 =?us-ascii?Q?wr1dTwDigPdvuUhcXKukKqjGRkv8Pp/RDlOQEnWmeYciVVaNeJWFWQeKC2CI?=
 =?us-ascii?Q?4WDeAzog/yLbxbKh9MPswtvESWLkzn5RXEUe7VaETDwiBp2fL42eim98gJh8?=
 =?us-ascii?Q?Lw45qsrdqD6MiKULt33r7WTZXHnRpq1qDMCT0jzbxjw3BoUIBGY7Jc/36g5o?=
 =?us-ascii?Q?uYjZfqcrVVYjtg9D3R3OQjmsD17I1p+VVMelcTZaq2KOiMLNpe5zhlovIzp4?=
 =?us-ascii?Q?vEQIs0h5tkT7YShFfYUdv+9bJXOpqY7vQiud+3wedxruVU8iHOEdW85OekIU?=
 =?us-ascii?Q?JMfKq/CFmyvAIwcq4a6rR93cQlgrITNNIBocOyJiNZOR9bHxxvWhm0auhMlm?=
 =?us-ascii?Q?6EIqOHeNzEVZaF7iXls3ST5+E8q4ImPUlJgB2bkRuyDYxXcdHhw1EW7QQzik?=
 =?us-ascii?Q?/aHzJSVlkBLBfSO36BebZQVYpyc1fEtzGIGy4zJOrcy8d+xLR8pES4VFy/7g?=
 =?us-ascii?Q?P377nFqDvH/HVMVetXH6W5AxDAZIbuBy3hUNBvoRzhxqPz9Nba8dPvXk0UV9?=
 =?us-ascii?Q?Q+L0mGy9ooAa8Zt7W+5CsNB8ZqDcCocsRtCqkEbSnXOm/si91/WOyZNDCxPP?=
 =?us-ascii?Q?jAnUezTHjl89UwQBiNejr8FY1j8gsVn37lW2LyVw7tf7mlq9Qxtyh8aeovkQ?=
 =?us-ascii?Q?XeqlIMfnRm9bOc3iLz5dB6TIrf2RYC4DoEGRAmRtO4iFAAfDSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 21:25:45.9242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb9ac29-aa02-49c6-572d-08dc8cb88dd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

This reverts commit aa68f57443c5aed125079ae66fef0e9fd7008b33.

This is causing a BUG message during suspend.

[   61.603542] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:283
[   61.603550] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2028, name: kworker/u64:14
[   61.603553] preempt_count: 1, expected: 0
[   61.603555] RCU nest depth: 0, expected: 0
[   61.603557] Preemption disabled at:
[   61.603559] [<ffffffffc08a3261>] amdgpu_gfx_disable_kgq+0x61/0x160 [amdgpu]
[   61.603789] CPU: 9 PID: 2028 Comm: kworker/u64:14 Tainted: G        W          6.8.0+ #7
[   61.603795] Workqueue: events_unbound async_run_entry_fn
[   61.603801] Call Trace:
[   61.603803]  <TASK>
[   61.603806]  dump_stack_lvl+0x37/0x50
[   61.603811]  ? amdgpu_gfx_disable_kgq+0x61/0x160 [amdgpu]
[   61.604007]  dump_stack+0x10/0x20
[   61.604010]  __might_resched+0x16f/0x1d0
[   61.604016]  __might_sleep+0x43/0x70
[   61.604020]  mutex_lock+0x1f/0x60
[   61.604024]  amdgpu_mes_unmap_legacy_queue+0x6d/0x100 [amdgpu]
[   61.604226]  gfx11_kiq_unmap_queues+0x3dc/0x430 [amdgpu]
[   61.604422]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.604429]  amdgpu_gfx_disable_kgq+0x122/0x160 [amdgpu]
[   61.604621]  gfx_v11_0_hw_fini+0xda/0x100 [amdgpu]
[   61.604814]  gfx_v11_0_suspend+0xe/0x20 [amdgpu]
[   61.605008]  amdgpu_device_ip_suspend_phase2+0x135/0x1d0 [amdgpu]
[   61.605175]  amdgpu_device_suspend+0xec/0x180 [amdgpu]

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 1a65ced60e68..48a5b0713fed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -801,9 +801,7 @@ int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
 	queue_input.mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
 	queue_input.wptr_addr = ring->wptr_gpu_addr;
 
-	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
-	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to map legacy queue\n");
 
@@ -826,9 +824,7 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 	queue_input.trail_fence_addr = gpu_addr;
 	queue_input.trail_fence_data = seq;
 
-	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->unmap_legacy_queue(&adev->mes, &queue_input);
-	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to unmap legacy queue\n");
 
@@ -849,13 +845,11 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg)
 		goto error;
 	}
 
-	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
 	if (r)
 		DRM_ERROR("failed to read reg (0x%x)\n", reg);
 	else
 		val = *(adev->mes.read_val_ptr);
-	amdgpu_mes_unlock(&adev->mes);
 
 error:
 	return val;
@@ -877,9 +871,7 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
 		goto error;
 	}
 
-	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
-	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to write reg (0x%x)\n", reg);
 
@@ -906,9 +898,7 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 		goto error;
 	}
 
-	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
-	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to reg_write_reg_wait\n");
 
@@ -933,9 +923,7 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
 		goto error;
 	}
 
-	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
-	amdgpu_mes_unlock(&adev->mes);
 	if (r)
 		DRM_ERROR("failed to reg_write_reg_wait\n");
 
-- 
2.35.1

