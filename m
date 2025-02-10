Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03297C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 07:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A820D10E4BD;
	Mon, 10 Feb 2025 07:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ea0Sx9Hr";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8178F10E4BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 07:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXbQcrUZvLz6V8LVFwHH6xi2KNDX2xAeGqfGnAxr2fkym3Cx4/NBvmg7spB9QXSG2ruPnvQtqk9zlnbh6q+wOie0m25pXL3HANRWaL6YqqhwHzOubRE6b1lemgjYmT38SLvfVDcHOMyNPye3b/FC0vmS27EkFCdMa91IPno83kasVQCV0kht+kEg+Y4rvQaRbaUFAKs7qm7cJ362d+5MAnje41xelbbLTdgMsyOSMQf+Vxrx41p+4277+1viMXbwpL4PN6RAN0D7qIPlTlO1lffG/eqK9KS0xoDqB4NpMC3ZQsE3LrsK+exkUzY+3DyWLGBgn065N4TLoqwjIdqn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djC1UeIYB6qPpdSU1Qm9w7zUBRfvZYtYyLY32a7qA5Y=;
 b=wRYlNXU7OmUN/YWYkpCiypFjXZWFL8p89R14gBgicLgiAjhZGs+621S2KXtdJ9TUQEGeBhY2NUpQGfj/xk9ZpJcgA6r2872TJTEi8NSET4Mxu6/Ji6k3jPW7gxTDX/qvs42YulTNwEv2zEY6szsD+ictdzLGTuIXS3jrv3V0M2MeYJKXF+Ycn9oui0GuwvNth9/yUv7xeoazm9dQrn/p7zr4aQ5jG3gkifzwBtI1O0gw326LH1KUWrNXNnqcY04xmxE8V4cCf3WAkQqBbPM2fPWLo/FxmV0ZmjAGPufopRB4STR1nejV+sSa7pMYcGnq9qyPVczvedXHGghlmhe6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djC1UeIYB6qPpdSU1Qm9w7zUBRfvZYtYyLY32a7qA5Y=;
 b=Ea0Sx9HrMHkmTkHEE0HObi6DHNJ5ukbKZ79wX3LXgIsVD9RIZfsbkPEQpDh33cCjNqQOnBr4N+nr7WYOKijnwLwRxuQ4y8ORCRfTZ6uYB2UUkVVjiKAOvdbe44ADcuyWUwXxPWTFlr/A4o0mODAK+x5QBmdD9oH7imKe4vLQMXI=
Received: from BYAPR05CA0089.namprd05.prod.outlook.com (2603:10b6:a03:e0::30)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 07:32:10 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::bd) by BYAPR05CA0089.outlook.office365.com
 (2603:10b6:a03:e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 10 Feb 2025 07:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 07:32:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 01:32:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 01:32:05 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 10 Feb 2025 01:31:58 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/sdma: Refactor SDMA reset functionality and
 add callback support
Date: Mon, 10 Feb 2025 15:31:43 +0800
Message-ID: <20250210073145.2681082-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210073145.2681082-1-jesse.zhang@amd.com>
References: <20250210073145.2681082-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c7a7b9-9cac-4e6a-1f76-08dd49a50793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AZwJWHH/zCdtZY4FF2VdS17OPUNAamnYIlZQPrIicXpX6gNBff0Vwduj0XVT?=
 =?us-ascii?Q?3f1BR7p5RVojzVS5sYqGdOhCUBgB+jxkK89jCQQNz4BodQujBvEHxmWHwffC?=
 =?us-ascii?Q?bTii8AiJl3B8qxeFbpA+b/vroT/uBu9ovfKKYVmzJ6vJBBxskJIJrG4i6soQ?=
 =?us-ascii?Q?jNW4Opk0Kcu4yZ9+9TsJNMfzElJfa/PfUnFxvE4hc8vW+OsrLps4NHc0hOF3?=
 =?us-ascii?Q?qKCd1khiW+RCFPcz1XDEdxOUZ6ds9Ka/+Cp2Ic1hjzRFPR5+kJcXCIqUUjGI?=
 =?us-ascii?Q?7S/tOifl6xqOC4h9x+C5uHMN1EIiV+ZfNhfUK8fXZ3LXCRD8EYGwgg/94vJm?=
 =?us-ascii?Q?E4j5BTVfvcWNbodGHsN7nK9sg9SLjlVrasz/zfxwMAsBzz7m0/jZRBp8O8pW?=
 =?us-ascii?Q?NTZ2SVBfJIOzP81qSkTFREViZ/mcILyY0cFUdp0864VnH6X722DVJRdOri/j?=
 =?us-ascii?Q?DYWqwM16H3Jf8Qq8dFFKO/TBfUv6Dy80NU7hjn7b1o+gJO9ivWo+DvFE6uYJ?=
 =?us-ascii?Q?uyS+v0xzEUrZsjinf1ZgVfQwUC1Rtwtta7gu/Bueonm+btZ+IMRLqsAeH7J7?=
 =?us-ascii?Q?B7prtfsVu+adj1/Dsnbyhf+T360l2BiRhSZTl/hFb6g+UGQ9BqSrgFGRBEsg?=
 =?us-ascii?Q?yVdQNRypk+uOqYyNYJUx74yNp4oEW41iZsEOhRKalD3GgE/7vlTaZTU48GEN?=
 =?us-ascii?Q?jxO7LxHKTfkDiYmyTM9TSFjU/MxA7HnLfF4MxYmKwUMcMUIJSbPJ4OH0Qr/X?=
 =?us-ascii?Q?JomV0S/Zu9h+Hv5yHMGJEEfmOcyEawyij9CA4cvT8P/J9OmdbPEVfw/73n0v?=
 =?us-ascii?Q?1bSHrAx7FSbX6Sm/pOASAIDd8VfkAcT/Yu81otIBZAVMyGf3AZJcpsvYEjTE?=
 =?us-ascii?Q?b4gZFFBq4H0uKBVRWnIQ7aFvKa6gyNLoRfyWH8FDaFi7ujcxOIMqf3uvCvdi?=
 =?us-ascii?Q?iWZ3Jtk87GTbHgEfQQCv6jD1GOSYgLcYDHZraPToJb/4viz9gdQJZ9lC++Pa?=
 =?us-ascii?Q?KDF1o5ZEf9+Rluv36tUsgbt9bZrC81TQ35wPf08eEscb1slWYTDsmCxPARND?=
 =?us-ascii?Q?kXjqpxw2K2cftzuMLMKuP8ty/j6tzHydqCpvgRclVdCPs7uQKX1FEjMfgs7T?=
 =?us-ascii?Q?7/0ztVbb8t2n2cVh4O+4aKaA8WDc+f9XKGAmQksSWdoXIPRHBim1Z5Rp+0XU?=
 =?us-ascii?Q?/ch7GfBayxtQZGOzSrFMxpSjp8bVh9yZMuCk5TYNi/csnBcdMIwMy/OtpGzY?=
 =?us-ascii?Q?Dz9QuDbqHctUQXJUyO4+w0aK6ZcDfCInWLShMuFOal74HLCRSov9fUpt/tzq?=
 =?us-ascii?Q?WjGIbylRqJio1iirFl8jmvbGo7aE3QZ+Iy8FREUs+MC326aGPeYoQUPCOG27?=
 =?us-ascii?Q?nnsa6MmyE5VSp15ok+Zj7kg5yTqLllyowmLsWG1oKwCrnVFg4GnKrbYqGD4D?=
 =?us-ascii?Q?/TPPvN6XSTptZsyRsuiQThN7Sl8UXrRjMrCVNzN+9GF1rs/viu/c5tKsnOe0?=
 =?us-ascii?Q?74NQfxDbJHvMjes=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 07:32:10.0273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c7a7b9-9cac-4e6a-1f76-08dd49a50793
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch refactors the SDMA reset functionality in the `sdma_v4_4_2` driver
to improve modularity and support shared usage between AMDGPU and KFD. The
changes include:

1. **Refactored SDMA Reset Logic**:
   - Split the `sdma_v4_4_2_reset_queue` function into two separate functions:
     - `sdma_v4_4_2_stop_queue`: Stops the SDMA queue before reset.
     - `sdma_v4_4_2_restore_queue`: Restores the SDMA queue after reset.
   - These functions are now used as callbacks for the shared reset mechanism.

2. **Added Callback Support**:
   - Introduced a new structure `sdma_v4_4_2_reset_funcs` to hold the stop and
     restore callbacks.
   - Added `sdma_v4_4_2_set_reset_funcs` to register these callbacks with the
     shared reset mechanism using `amdgpu_set_on_reset_callbacks`.

3. **Fixed Reset Queue Function**:
   - Modified `sdma_v4_4_2_reset_queue` to use the shared `amdgpu_sdma_reset_queue`
     function, ensuring consistency across the driver.

This patch ensures that SDMA reset functionality is more modular, reusable, and
aligned with the shared reset mechanism between AMDGPU and KFD.

Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 32 +++++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 64c163dd708f..3e60456b0db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -105,6 +105,7 @@ static void sdma_v4_4_2_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
+static void sdma_v4_4_2_set_reset_funcs(struct amdgpu_device *adev);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1330,6 +1331,7 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
 	sdma_v4_4_2_set_vm_pte_funcs(adev);
 	sdma_v4_4_2_set_irq_funcs(adev);
 	sdma_v4_4_2_set_ras_funcs(adev);
+	sdma_v4_4_2_set_reset_funcs(adev);
 
 	return 0;
 }
@@ -1605,8 +1607,14 @@ static int sdma_v4_4_2_soft_reset(struct amdgpu_ip_block *ip_block)
 static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int i, r;
+	u32 id = GET_INST(SDMA0, ring->me);
+	return amdgpu_sdma_reset_instance(adev, id);
+}
+
+static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t instance_id)
+{
 	u32 inst_mask;
+	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
@@ -1617,10 +1625,16 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	if (adev->sdma.has_page_queue)
 		sdma_v4_4_2_inst_page_stop(adev, inst_mask);
 
-	r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me));
-	if (r)
-		return r;
+	return 0;
+}
 
+static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_t instance_id)
+{
+	int i;
+	u32 inst_mask;
+	struct amdgpu_ring *ring = &adev->sdma.instance[instance_id].ring;
+
+	inst_mask = 1 << ring->me;
 	udelay(50);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -1638,6 +1652,16 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
 }
 
+static struct sdma_on_reset_funcs sdma_v4_4_2_reset_funcs = {
+	.pre_reset = sdma_v4_4_2_stop_queue,
+	.post_reset = sdma_v4_4_2_restore_queue,
+};
+
+static void sdma_v4_4_2_set_reset_funcs(struct amdgpu_device *adev)
+{
+	amdgpu_sdma_register_on_reset_callbacks(adev, &sdma_v4_4_2_reset_funcs);
+}
+
 static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
-- 
2.25.1

