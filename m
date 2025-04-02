Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E63C36018
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 03:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CBC10E6AC;
	Wed,  2 Apr 2025 03:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="shYU+cws";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F177710E6AC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 03:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILssuh/xYUZ4DhYPRfxguzlPPGgjZvufvu1be2wQwTMg9Tt0QD6ogiLZ76E/uaTM527yiFWz/Yt6A4lMNOAYZuEco3zzwetBNEhTD8Ns31nGcnjByW7wiCMjON48CM8q7OCvvQupj1iGZil+D0BXh80D770Er77g9bGVBAOVFmvO02e9ToueFRf7DGhyuf1squ+zeL3q+kriwqStIUIADq0XQgKQDWrWZ4rcvtc6d8URwVlJFWSb7hXw+/DwfJ9rJZICYsvqq1J2bQfhZeijYHihWspSEY5atuj4I4gb5F+AxE9MHaW8u5JacagUyC7Z178Aa5AfsF6APoI/kdrJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG1b33uqL0lh/uFgZLtOr1di8U/XnWY2A7DXZg/dOrg=;
 b=wR/mIJ/WHt/NYEvcru7kXt3j0fmDdnCmgUxbJr9VFmLuqoPnFfBe2f1WKBRUwEAhY+lBRHxdxDA1+tJoGWj4INNdg62RQAVu73L409mZGw8SUeMtBZ5+JCp9eMJt12xJit5c2GuRaDcqSb/ieS0led/DHt/C56wuZIV9scaq7OOrjO/cMiSoYkdFBfJrY6faIYPVnBy5krXRnTSiaFlXyTplsmu0PwaXnmrCwqrSJD7RECTnc9dq7hEeNKGEQ4fOQN0yxmRC1hUAZw1koSGM41yR1LWBS0Kg5nYJ0FBb9/6nhNxtC+xBcII1BZhIwGAq/osJc+R8l1O4TgFGUy9HBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG1b33uqL0lh/uFgZLtOr1di8U/XnWY2A7DXZg/dOrg=;
 b=shYU+cwsk3lddEd1M0+mclin0oeD/JJNdXDDhXlwP2k6iUkFwysERV4LsNVhtIJGwY0Vizs5/r98K0fczcHKMskBgLtccML0AtWawbdzqPeFzL7VOdiBbE+GubrqjBQrpmET4dmcM5Xdk/xPVXwLCF6+v2RUKZIkLeF/8qskhPs=
Received: from MN0P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::10)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Wed, 2 Apr
 2025 03:03:09 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::1f) by MN0P222CA0009.outlook.office365.com
 (2603:10b6:208:531::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.42 via Frontend Transport; Wed,
 2 Apr 2025 03:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 03:03:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 22:03:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 22:03:09 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 1 Apr 2025 22:03:02 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 6/7 V2] drm/amd/amdgpu: Refactor SDMA v5.2 reset logic into
 stop_queue and restore_queue functions
Date: Wed, 2 Apr 2025 11:02:14 +0800
Message-ID: <20250402030215.1074975-6-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402030215.1074975-1-jesse.zhang@amd.com>
References: <20250402030215.1074975-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: 6285ea4a-3576-460d-a4fc-08dd7192e644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AzhZLZ11OOnNZhrVg7joW/VvY4hBqA0I0KGS0YUb5Ch/GGxZPV91RmKCaigK?=
 =?us-ascii?Q?Ea21iNl1Bjp6Z/OzABOqBoo1HVks6A28zDMGkiziS2XEjqjBrT1SlckTnFJO?=
 =?us-ascii?Q?7kllmzToD04UgvgZ0RNPBbF3cdPhsN3N0ZsZgSsBMc5jG88mvWawjokcTN1w?=
 =?us-ascii?Q?hbqWd7UmB2VPd8r7R1SKlPwS4qo5cO4CAJf3NnIOB1/umXgfLvls7K+wdwKl?=
 =?us-ascii?Q?C+sSsawmYhZBXxdp8Xhp7B1PZtjoaZoFG4q+iHlStBVQyfHREl/mNfv5HWFd?=
 =?us-ascii?Q?qOIJV6poea/cIjPhN90FpUdS83j9+cgiq8sdZaTD/XwiFIgDqbDQo9O8yfHH?=
 =?us-ascii?Q?ODFCNpHwVFM3MqW8SahbyRH1zYLARjVSsaKQ35lWQj/IUriU32uRHjTVSr5p?=
 =?us-ascii?Q?vpaacJpb9jHhMfCh8skFiIvSHeYDBBkJshrCiw4hgFMbI+4cd0/xdQ6VyEFq?=
 =?us-ascii?Q?KgF/GKOVz/QCir+wuM71Q5xmWENKfJTwbbwNHSU22qj7acAhgXZ4TEyYlPSZ?=
 =?us-ascii?Q?MZYqRUzOM6+FWhD5KnEp40Wy9S/aUtvpV920e4TY2Uekg0GR5Fje4ziBBzOu?=
 =?us-ascii?Q?pTD4hyVqEAaZkjNGV2V4ejSba9oZpSAoXabnMXF1SQ+1XfpStQ0ySNHNbKCj?=
 =?us-ascii?Q?kjG0N04/tzpxEUcnWIVYVS4fgHOZK5uVZs4BfjJbytbbWiKkZQHeR2cA+4EA?=
 =?us-ascii?Q?7xo3CjezT3sJxVKxMvbdbPIO3LxnXxku2XuKBylI8H0vxy7uW+2aF5FzZuZz?=
 =?us-ascii?Q?20xkWhjxaA4Ns2Cyc/YIXI02b94Ag/521QD1oL6sP/VhoM6FzV288Epr3jqu?=
 =?us-ascii?Q?ri3qepoU4TcGUztmiKcPB5aPX9cfaM7S8vDZ3+1ey0N7r9ipk89fM2HkV9Ri?=
 =?us-ascii?Q?sCh5Rc3ScOQlp97oC4OmCc0l/sEEE/lCEavVuREbrujc8k05gwrhbwNQMhJI?=
 =?us-ascii?Q?D0Ht0aCpLMl0VA/iVprRexO5X/LgTX6hKRUj0qf0ONYC8kaSdCKZ4KVQ6+MP?=
 =?us-ascii?Q?+dn/negHOmRLvi3ftZQafNXbcdiXdVUY5s5A/OAXX6PElMYT4BKNy6ZDWgXd?=
 =?us-ascii?Q?RqTL0/MMUWymzq1IBdkB710BVYHGgfBT77Dxn/hEUEKbXGDmyLHyr/HZq5BV?=
 =?us-ascii?Q?geM+zprN3S5gaOYaM7F2dm18QP7wjvWj28eyt1xztaOnbwvrp8kHVyzImXRq?=
 =?us-ascii?Q?H1C+9TUaZ10J0XQeUD6+/VoNgpmdldC6CIxWb2VNld3g2G1aWIARoUiKiTd4?=
 =?us-ascii?Q?oi+CA4lcMc/nldxnA2PEFEKmNpIYkMx3FtNrKChtOCucgD3OXtTraYEuCGDU?=
 =?us-ascii?Q?FlNgu4OmsMlReTc1HqPc2WbxSEdnXBOBylkf6KXY0FbLQ9MecobiRNEx2oH0?=
 =?us-ascii?Q?05QPH5Q1vZOclHkeAFl+VFRTXTvFOH38kTQ2MOy+t+UST1ilb+W4IZNWxEQq?=
 =?us-ascii?Q?QhSascWVE2pSOL4I/TnsMxsKaaC9W6DxQku/patZZ2Q521PeMItPisvteYb2?=
 =?us-ascii?Q?yopZb386yHl1Qqc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 03:03:09.8431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6285ea4a-3576-460d-a4fc-08dd7192e644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
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

This patch refactors the SDMA v5.2 reset logic by splitting the `sdma_v5_2_reset_queue` function into two separate functions: `sdma_v5_2_stop_queue` and `sdma_v5_2_restore_queue`.
This change aligns with the new SDMA reset mechanism, where the reset process is divided into stopping the queue, performing the reset, and restoring the queue.

1. **Split `sdma_v5_2_reset_queue`**:
	- Extracted the queue stopping logic into `sdma_v5_2_stop_queue`.
	- Extracted the queue restoration logic into `sdma_v5_2_restore_queue`.
	- The soft reset step is now handled by the caller (`amdgpu_sdma_reset_engine`).

2. **Update Ring Functions**:
	- Added `stop_queue` and `start_queue` to the `sdma_v5_2_ring_funcs` structure to support the new reset mechanism.

v2: remove the suspend_user_queues param when calling amdgpu_sdma_reset_engine()

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 38 ++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 96b02c3e4993..67b7d84c15dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1439,18 +1439,22 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int j, r;
-	u32 f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
-	u32 inst_id;
+	u32 inst_id = ring->me;
+
+	return amdgpu_sdma_reset_engine(adev, inst_id);
+}
+
+static int sdma_v5_2_stop_queue(struct amdgpu_device *adev, uint32_t inst_id)
+{
+	int j, r = 0;
+	u32 f32_cntl, freeze, cntl, preempt, stat1_reg;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
 
-	inst_id = ring->me;
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-
 	/* stop queue */
-	sdma_v5_2_gfx_stop(adev, 1 << ring->me);
+	sdma_v5_2_gfx_stop(adev, 1 << inst_id);
 
 	/*engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
 	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
@@ -1488,18 +1492,17 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
 	WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT), preempt);
 
-	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id;
-
-
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
-
-	udelay(50);
-
-	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id);
+err0:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
 
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+static int sdma_v5_2_restore_queue(struct amdgpu_device *adev, uint32_t inst_id)
+{
+	u32 freeze;
+	int r;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	/* unfreeze and unhalt */
 	freeze = RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
@@ -1507,7 +1510,6 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
 
-err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return r;
 }
@@ -1947,6 +1949,8 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.init_cond_exec = sdma_v5_2_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_2_ring_preempt_ib,
 	.reset = sdma_v5_2_reset_queue,
+	.stop_queue = sdma_v5_2_stop_queue,
+	.start_queue = sdma_v5_2_restore_queue,
 };
 
 static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

