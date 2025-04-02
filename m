Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9128C36018
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 03:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C51310E6A7;
	Wed,  2 Apr 2025 03:03:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5GV3Fb99";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2CC10E6A7
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 03:03:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/AuKj2geTz6BzM55IgtiC0p53j1vei//+u4OzaN6AJvjdVPof9MsyCG0wQ73BbBZ+1A3ibha24OVa619yHf5mNMtySXCJTCYX+cexk0nynYd3pEYYBI6kJo9P+UQsKMxW8KlOgbdTkkQARWXy7vW6UMeqX1Aw+N3wrjnYQZCNFFNar4bj0/wmY85mEt5mP6o69vujd/15a+Rq39jRVTGMvjdqdKbzM6L6KbQ92zR3juEn2IbYWuFZXhRvOtEeRL1tc+NYoZPYk9SWyKDUGwAgL9aHsdPo8DPqKExNRkM5IsshK14oTzLl1RG6F8b2QSNRitFGzuVXkPQpgblo360A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJAO5qwp0kXvVzRzDuiyjntoQw5Vxrql20c7VO98cas=;
 b=BO19B2a97WGnUfUrL6TplWgyScdke1nfDPGagovV8TMMSh8AOuS6Xsqa0wzkQQQNHnYG3hrxj8MA2NduMrkx/6MCHKiua5Jo9xu1fir7A789whMnKBwT5+jrAiFQjwWG6k2zawwSs4vdORGFv9heDXigf7KFRAe3NL+x3cajtUVUX1bI51NSPKrkrNZSi4VKMb/KOCu6JdfQohv0P8C6bIkTLtjfPXSs2zhqdU77m8zjnbzUlld9LnLwySdBz6eWqWuNoddBCzxlTflmaEz50bfBGJ/qLSF0CEYdMIWFDHw6j8rRx5ABP47WWhwO76R0NOzZ/rf11s7KQBof6CboWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJAO5qwp0kXvVzRzDuiyjntoQw5Vxrql20c7VO98cas=;
 b=5GV3Fb995NxYYhzRsXnWS1ABUe7D8XjwUuT8TV47RR2C0j0beR6x5QzUPtzWAGFoT/zYLfHSHoXms891KMDotfu3eKzEaf7sZRUxaz51cIa0GrzBLtdbKqxR+pvcgmQVDgRTa3cHhah4abIJQ8VCoQaQMIkvfTnYklW+ct1K6mc=
Received: from MN0P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::30)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 03:02:56 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::f9) by MN0P222CA0028.outlook.office365.com
 (2603:10b6:208:531::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Wed,
 2 Apr 2025 03:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 03:02:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 22:02:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 22:02:54 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 1 Apr 2025 22:02:47 -0500
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/7 V2] drm/amd/amdgpu: Refactor SDMA v5.0 reset logic into
 stop_queue and restore_queue functions
Date: Wed, 2 Apr 2025 11:02:12 +0800
Message-ID: <20250402030215.1074975-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250402030215.1074975-1-jesse.zhang@amd.com>
References: <20250402030215.1074975-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|PH7PR12MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d700987-05e1-4275-daa6-08dd7192dde2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4IgquwEr7xNlgmnGbOz57CsezDgPoppzjMx/y3If7Pn181IwZyemMX7mDVfT?=
 =?us-ascii?Q?zUb/zawHTlpXIMQycMYj4wwyNBR94wICIT/mUhs+uiOBrawVttArzVswoP6r?=
 =?us-ascii?Q?MkwODS+RXZTVWz8V0Y46roo1QgVZ8ph6hKxLPJUIaaM8FyNb6KVr1pr56Llc?=
 =?us-ascii?Q?UXbIMZ6NnunNzwo1poomuHkFCFhKxEB+ErGKzWvoLZC69+IOt5bXVeDcGJof?=
 =?us-ascii?Q?tyUNByK5P11QSwTybaxuTWyAV5LrNG5eqH6s0y/NZZk0bVybCAC7H42wMiRG?=
 =?us-ascii?Q?wkqkhKKZBYnvMEo+3ddinHkZtG9oLBDMnt6DaqfssU2qU0mtkVt5Uj+xbYU2?=
 =?us-ascii?Q?G4X+2dCqF6yzrVJ18SEsIRRmpLhR9JvuMBCw/FP/DgdP/e6g9OwlBsJNCrHL?=
 =?us-ascii?Q?eNS6TTWnwrHlSiAvwfUl7LBEt4VbcthzxtCMkpCoiRwZaIhDyjk0clUhy4eo?=
 =?us-ascii?Q?xiP6TM83ai6UonoJhGpRjst8AJyn6P2jQgPvoMtwEBqIJZhsdde7n2+YTz/H?=
 =?us-ascii?Q?r7KPRwrM1jpFUsX3dqu7JU+/Pxvrgy38Q+U570ilVUqjDevhiLUhqYwVz6Mw?=
 =?us-ascii?Q?QuHTEn26PBFBQ3kahult5VTeOFdyif1Zsw2IAhCeLdtczhI+0n08TXY5gMfR?=
 =?us-ascii?Q?H4WvnODbIdyx5d+hAbwk6jQwQHdjrOxbJgc5ES4xni2pNcvXmvirph8HX1Q2?=
 =?us-ascii?Q?s293lBvxDwmdxDBBGd4S/7hxaebt2N1iJfO/sKNdy/oApZl6OmFLF0TCXAlf?=
 =?us-ascii?Q?LQ0WF0fuhnHSCw7H8Eh5vq1L5bEIRU+A+s/ubHFCnJxUnHLm/ofNdZFb7CJi?=
 =?us-ascii?Q?wDUJq/zW+d/pHS1UC2+RiSgGNytNmjWXyMDltL6oFWOumhTa+Yh4zg0ztAX2?=
 =?us-ascii?Q?NSYqBnoJUPxsiGrxkzdW5jZIJedzOGjjuTrMgcUTgCdDU18LmHmP+HSw/FZ4?=
 =?us-ascii?Q?h6IHWLtwPvWdZGuTophA6nf7kgXf1ZEU0h8+1X/mTqnqF1XYYUIstDmRI7cI?=
 =?us-ascii?Q?YxwePm090LENS2e9vNbMMWCltuTcWIfaC+xQOBDPptrbhC2bTXgrBA9F4Gm8?=
 =?us-ascii?Q?2bOa8wINzhRf6SjeYdb98R/wWPJeOKaaOigtXAlCw31VFkXsh2SyukfVWpWr?=
 =?us-ascii?Q?1IkrDHz/ov6V6D4m/KGOk9vJ6VK8F8osiXdEECrPoO/XcR2EV0LqNAmRgfqR?=
 =?us-ascii?Q?9k0Pa60Ch4uu7BseGIzRZKfQm6UgRRbzcyxVoj9YxS23F+cOMZ/6m6pWlV1Z?=
 =?us-ascii?Q?aD9SnVOOcyhHVBB/mRR0WblDA0Z0u00qMKv7yO6mChj005X18zsHQmbN01O1?=
 =?us-ascii?Q?JP+rRA70Y+DwkYLpuwNb3rDN39+mesLnF5BMRBr2teLLeXf9KLB8IlktmKLt?=
 =?us-ascii?Q?wzIyEqoP5q8JI4w+fQPPFYWa59MKvaO0jfGp5wRpmA4Sudiu6bKbmbP55iAd?=
 =?us-ascii?Q?4f0Hkx6jd12DRGmE06FF89QNLwJl3O/zHCxoM1z7FRS/8H2iID1dkFxNBQgU?=
 =?us-ascii?Q?E5GMFgopQkWxleM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 03:02:55.7805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d700987-05e1-4275-daa6-08dd7192dde2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780
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

This patch refactors the SDMA v5.0 reset logic by splitting the `sdma_v5_0_reset_queue` function into two separate functions: `sdma_v5_0_stop_queue` and `sdma_v5_0_restore_queue`.
This change aligns with the new SDMA reset mechanism, where the reset process is divided into stopping the queue, performing the reset, and restoring the queue.

1. **Split `sdma_v5_0_reset_queue`**:
       - Extracted the queue stopping logic into `sdma_v5_0_stop_queue`.
       - Extracted the queue restoration logic into `sdma_v5_0_restore_queue`.
       - The soft reset step is now handled by the caller (`amdgpu_sdma_reset_engine`).

2. **Update Ring Functions**:
     - Added `stop_queue` and `start_queue` to the `sdma_v5_0_ring_funcs` structure to support the new reset mechanism.

v2: remove the suspend_user_queues param when calling amdgpu_sdma_reset_engine()

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 37 +++++++++++++++-----------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 9501652f903d..df77bf2639cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1508,17 +1508,23 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
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
+static int sdma_v5_0_stop_queue(struct amdgpu_device *adev, uint32_t inst_id)
+{
+	int j, r = 0;
+	u32 f32_cntl, freeze, cntl, preempt, stat1_reg;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EINVAL;
-	inst_id = ring->me;
+
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	/* stop queue */
-	sdma_v5_0_gfx_stop(adev, 1 << ring->me);
+	sdma_v5_0_gfx_stop(adev, inst_id);
 
 	/* engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
 	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
@@ -1554,17 +1560,17 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 	preempt = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT));
 	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
 	WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMPT), preempt);
+err0:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
 
-	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
-	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id;
-
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
-
-	udelay(50);
-
-	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << inst_id);
-	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+static int sdma_v5_0_restore_queue(struct amdgpu_device *adev, uint32_t inst_id)
+{
+	int r;
+	u32 freeze;
 
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	/* unfreeze*/
 	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE));
 	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
@@ -1572,7 +1578,6 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 
-err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return r;
 }
@@ -1919,6 +1924,8 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_0_ring_preempt_ib,
 	.reset = sdma_v5_0_reset_queue,
+	.stop_queue = sdma_v5_0_stop_queue,
+	.start_queue = sdma_v5_0_restore_queue,
 };
 
 static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

