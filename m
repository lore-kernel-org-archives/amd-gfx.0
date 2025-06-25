Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5991C7EE31
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F7D10E7FF;
	Wed, 25 Jun 2025 21:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rtzd7P2w";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41FBF10E260
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u018a1R86hFtXZ/o/4r7WYAy2hhNE6O0aKcDS2TrI1l6cWDLindBNLsasL9qF2ltrmRxpwE5e9IWyULZ23C7TPJNtvzkg7IyNWIGqXEvv32rqinHb6EJd2ffON3Ha+hPGkXKFPRNSRACbbi1VKCSbWL7kMwrf5D5Vnnz79CfgtwUDRCXVWzCor7zu4pPm5I2vwx6qoPrt8vQ5bLCP+Ne3F6C5H8ZcujDiZULZwkXmj0xkVB9nPuDl2WgVaUSWtQ1dHpIq8SUAuyiYcP7x67MYLxMk7houIlnpvBf8+LnKXOpChUrQNSu1FHcHIvte5sGdJqA/EKaGRczOll8kVWriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR7EbpJz/UZJOLP1Lfz/FJo0bHrvLbcJpPFds4JMbg8=;
 b=Jo5lqMoLiNuKJTfF1DdhgCeTZXciURrpDL2pnlYs/D9cQ128eW59sDPHxCsEFvcllX/6XENjEUmrtJE0I94IV77+eclbBuUeg+CDCKgC5cVYVvxfI7b9QC+EVhshWv2IAl7XPgJFFME+HZxKs2IU5YYhLhJVpVWcUD2nvTXryUp398PytvBfEAWSEQrr0aJKwxoB6BO9oxOazOhvstKQzsWsrvT3I8eyoHDNF10EbPKKccr6Um56UyFKbWacwJ/00B0eQSwbQZSL5V+eXOwR/KJq2L+kAmFFYhHMcupVw6Wc4gPta4S2JMpvYb4mAXfacRFkt1jFRPh+TFJF13411w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR7EbpJz/UZJOLP1Lfz/FJo0bHrvLbcJpPFds4JMbg8=;
 b=Rtzd7P2wadmEEHvkyFN+qUtbfccnCf4q7b/KGEXknPswpGkPUbQ3EL8ryr6qMwqSytNrY9e/aUjgyuTTBlWCYl2yJw3qBCjT8WnIL3B8JPqg37BTW4t7AxFFL+fH7l/kuNoSZQm7zT9UluOICS+CrVZd6tpjrcCMXLJTujCFD6w=
Received: from SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::32)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Wed, 25 Jun
 2025 21:07:02 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::4) by SJ0P220CA0024.outlook.office365.com
 (2603:10b6:a03:41b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 21:07:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/30] drm/amdgpu/gfx12: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:20 -0400
Message-ID: <20250625210638.422479-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e530300-7fed-410d-bce4-08ddb42c3b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kk3q1qxAyguZE1T/MJO0lB0M53MHD/A0q3MuCzhKRZzyK22ndVwSVcyKnPMs?=
 =?us-ascii?Q?pG1QDz78E2F5/pQ9xcRsSocnkk6g3qZ5X/dDpNFXFkjXPMdZet94hfJ/274F?=
 =?us-ascii?Q?lz2mmfoFm4qcEzVmss9qYFoykVg/2FKcX8FUfe3WVJiw8jnut3iheTo5rOea?=
 =?us-ascii?Q?jshuGpqbvVpGHKczMHtDKjgCkiEcm54DVE48BiaXEzSWMZ6JMrnxIDcPmtsh?=
 =?us-ascii?Q?P1AjTuhlUfgSbaI1RLm8JoGsaq8xNwXQJPiPD2Evtsr0AsBOGx0iOgVtQnVd?=
 =?us-ascii?Q?+8LOg2odKIh/dilJFLwNbdb4eQK40v5zdqWgRPRbAZs3Pv83thX3GK7ZF62e?=
 =?us-ascii?Q?FUgEKQFthTIQ8qbD+5YQt30l3aSQ0eZRvL5e2WDIoW5WHgRajjf7EVE9+mdL?=
 =?us-ascii?Q?sxLDp/+rI52swZmaaFmBeP40j7KhHJZ3eXqennbi2/A316bS6L2HWDhXcyoF?=
 =?us-ascii?Q?FGHSWWf0xlrU7O8cB3pUSkqkloYHwYp2VDIsKfxCpgxjogjWb7UI/BVp/W0H?=
 =?us-ascii?Q?GmyAnPb7dOw82iS7dsPmc3NsXXwxG/YrqsgXXjjYfh4/3gG6fLZ/6si6MYUR?=
 =?us-ascii?Q?vCx6k3sB6j0B4GxGkuHY6gcTz3bylPnDvYh88+Kft5c/oyYIWBWgJlgwToMu?=
 =?us-ascii?Q?Jurei0bcrqWE5HfsdzS060P9oSTShdEKodw43u1hdbt+N1rJFxcw9lP4ntzP?=
 =?us-ascii?Q?Y7UT8IRlRVust5RExdpu5nkCcbI5MTzEAOvc1wMsLzICqkOwUmCxqAy7nvsv?=
 =?us-ascii?Q?zq+RCS0sHKTTAcWnc/kxC6N+0oYK14E4UjbO4XohWB4OAtAyl6ZsenMT5i3l?=
 =?us-ascii?Q?wAf1Erad/aueSmYPVeEIXdkQLDX2mQa2tKFGo5/SkaXjHtgyqoTlyTSdu7ff?=
 =?us-ascii?Q?Ga5jEPvYolHGfcubslK01HUGY4Y//amcRCXs51JqYqAS04w84VItJQYAFD02?=
 =?us-ascii?Q?pNNuexqfKOvu8/Uvc8f0WJB88G/FIXWPxRVF0VA/dbNP5cgfDJkOYTmYFjQk?=
 =?us-ascii?Q?3J9dkAWY6BAjK0G4Dydqhoposy3ZBxIif3bZfyp6RXXMWWtYED5Lt4SBYmhe?=
 =?us-ascii?Q?xGcqLPMJhKTPXy+aOFpcnNzNc2DAZ3TXH87NJK6bwoU+qe0PCcvt8J/6fTTQ?=
 =?us-ascii?Q?9jZOH71mcBRx5FjrgGU2CS0eOlR+4eujp7MVNXrcWwpnbwERV7PaYHDXWQ6A?=
 =?us-ascii?Q?QvrGVPDPzPzTcahRAZa3ABToM4ePwcrcxRi49nXH3CIE20k0UB79UL1+gkmP?=
 =?us-ascii?Q?Z7PM6GmjsPJY+/a11pNEQ+xr0CUAp1vSmwT86PfE0wkOISHZNBPwCa+MmBMn?=
 =?us-ascii?Q?CfG/Suul4rgvAymOJCHzR3NQfWmpBMGsfNJrCxnNFQ/HOA+oX++zkU2dR6ft?=
 =?us-ascii?Q?WssKmz42IhMBthypJ7iGqF32e5Ulg0KGbWFpYWiWiqSjOoetM+zSFlv61kEs?=
 =?us-ascii?Q?68XtWi4vLdCUvEmBpAAptWBrVq2Q1ip4MJ2UvhCyt+X0vijhfb3T/4LnZqQu?=
 =?us-ascii?Q?EB96K4M3gQWtXIWjEYBva+u8AixX5upYsGeJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:02.4676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e530300-7fed-410d-bce4-08ddb42c3b7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 35 +++-----------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index e4fc42470cf3e..a3be2b46177c3 100644
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
@@ -5317,7 +5302,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
@@ -5339,12 +5324,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
@@ -5440,7 +5420,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
@@ -5461,12 +5441,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
 		return r;
 	}
 
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v12_0_ring_begin_use(struct amdgpu_ring *ring)
@@ -5544,7 +5519,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kgq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
@@ -5583,7 +5557,6 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v12_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v12_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v12_0_emit_mem_sync,
 	.reset = gfx_v12_0_reset_kcq,
 	.emit_cleaner_shader = gfx_v12_0_ring_emit_cleaner_shader,
-- 
2.50.0

