Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC46C2BA1B
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 08:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E640010E73B;
	Wed, 12 Mar 2025 08:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JgCRl3gO";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7FBA10E73B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chnzC87SOSJh2izNAMAi6hifLa/Liux1UML+LQePuDCW+gtmYyGltfdjYSfMVfc3FnIk2mKCLJeywPSmdclhfxdaHveHgP/C0Fi5ZpN668pGHKZPI+kjOr2Mdi/nDq1jY1jTcGew+TuJzF95plfhH1f6/S7ZfnmuoEiwkBYgI2IC47zfsE8A8rprALxBaFPbQ+vAvA3VaOBEwtSX8cFW+D4zktB5CwVzODQTHwgfkUpaHu8QCE3wUKH29aMw6ZnDHUkwopB/fFWXnJigkLcHhWHGDXhQqMq0Ocmiz/OLorSR+XPIcjziGGCTvzZbOc0MhSdVUlJ1PVbV75/Hq1Lnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzkPvBXALHFOAKZ3fbHl81qx1VkXjnwTgJWg4uxCt+o=;
 b=miLxMrQ2w7ogWVMfSOIWIvQ6RmTpl5r88nJ4LgOJQ2rd7ShRSZQfHb5KcNo1ttZoYJbAk7tOxdZhAFDHL48rpnLBZgxKL0YEay41YpHOFlYgbiZWYO8wXCe0x9b03DMQbkwCiHK7xf0l9+OgC/SxViMzi0NUcL5IVPXi7MIRH9q7QqMzyt5ngyZxX5Yd2emNnHc3EIy2s4tbgCiCx48YsC+S+YjTrhqDZny9+2wWArpjMzecaJbj+D0fVDxOLrCNqP+fsDVZtysAvCwo5kV6o2Z3wGGorJSa5AO6iWrkddUUOyIGbpeQN0d0DfTZaytYeI6l3Nf0TTaXQncsfFIgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzkPvBXALHFOAKZ3fbHl81qx1VkXjnwTgJWg4uxCt+o=;
 b=JgCRl3gO3ilDFXOgPJziA+A+ZZ6GqrJlXMk3hqOjZoyli+zmQfNXV/qtxN1rY0gd/WATsmTcl6YvVulpbbDwNUqvgQAFfzsICBRQm6MFtFrq/6m7qHgmb4UxTJvyH1gl6c5Jw5wiFVyUA2Il6LmqUijYAYjbCBZoaH8TIdgsh5w=
Received: from DS7PR07CA0014.namprd07.prod.outlook.com (2603:10b6:5:3af::17)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:00:44 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::d9) by DS7PR07CA0014.outlook.office365.com
 (2603:10b6:5:3af::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.23 via Frontend Transport; Wed,
 12 Mar 2025 08:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 08:00:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:00:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:00:42 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Mar 2025 03:00:35 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 4/7] drm/amd/amdgpu: Refactor SDMA v5.0 reset logic into
 stop_queue and restore_queue functions
Date: Wed, 12 Mar 2025 16:00:00 +0800
Message-ID: <20250312080003.3224976-4-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312080003.3224976-1-jesse.zhang@amd.com>
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 17986ae1-6581-4db2-2e77-08dd613bfd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xs8UagtH+FtURbiPSWCK26kuWTp8Pkn2Ojuo+o08/h5tpHtHUZ8dpDQnpCqk?=
 =?us-ascii?Q?pnqSOPAzDnugegbTH+xG0BCBcfW1hJEbTM1PMSDAZgUkIBKZ5UxGQYmk4SrD?=
 =?us-ascii?Q?x0pj3uQbOcp9ca+qtQTqHuaWgy67xbl0Vt2H87l6sKy6iwxTIku3sr7gKXtO?=
 =?us-ascii?Q?0zRIis1zrFxoCs1hPsath9VIBsE0c+sdvDq+RmeyLPDKWReMb6BsUATxhtBG?=
 =?us-ascii?Q?oqvn9n5+vwMlvaNxFaLeKsALiNik2tTtI9n5YQEOaRuFKVzxH0pqEhklGt9x?=
 =?us-ascii?Q?+vbbGafF+Qw0KK2Vs3WiB50+W4erpwlYn1KcoBx/XvKZa70IiydYaFGrqeTJ?=
 =?us-ascii?Q?x00isx7HcImVkty0JOwO96uskL4ymkFK0IKd8T9clFeKfq7XmOfMBsYllA0O?=
 =?us-ascii?Q?/1g+AIZrkflg0l70mQeE8p2ngXoF7fCTLGHlk8gzSbCZiR1LJVwEyZdjPNxE?=
 =?us-ascii?Q?JmyDDtBZ+GY2T/tFSgLY+RA2WfJH1EKHpWRlTR7zTSs1CTPrCafmV3sIaB62?=
 =?us-ascii?Q?EvEX6nKte+yBQ8As389u7X/hBq6eT32HWYOR3qhIki0n+Hs37R/X78MozTDT?=
 =?us-ascii?Q?/fg6qHxupHJRf1X0ZXE/C+8qedEytD4Uu7y/fzDZGsbXJilHE4EkdcxsGWJe?=
 =?us-ascii?Q?BAaQKIwe787Q+EtSXphhg8sV4GTtkFKaDo3aMKKFbqx9jqSRoL7M6UtJ7dAF?=
 =?us-ascii?Q?qSg7cT4PgqBB2lTP6oqEHOg11Hm0piEVYB7r3G5vN40aRrQ3dAsKm6M+tWm3?=
 =?us-ascii?Q?GwbMyI+jsoyQ6XG/Iq76wNbmDc4jV4jVfxmlL05K/Am3QnQUS6UsECqurROf?=
 =?us-ascii?Q?DGuxhEFRiJdGpg5mzqmAxmvLIetlLAjPa3mCM2OgNdQFcln71Bt2c2C8l4D+?=
 =?us-ascii?Q?Rkxz+FaqiDzD0cg0M4tEA+lhjyfrdJ80Ll0yflQKw9tkRiQEWAIOY+TN05cH?=
 =?us-ascii?Q?iYZCfafjYK29RlGDTCwG/7BBsAFw89zvjk/eHiOIkuOr5KwpBi0bsnIh/pen?=
 =?us-ascii?Q?0xT1bcNe78n8hZVutMUR1TwdTunOMAxnwNPquHUtPlSVc2VTP6bK9DvEWHxO?=
 =?us-ascii?Q?2vFe8maZ0zTyY3JVxq3g5MmpWPODN6ka1k73t+nTY8sqW+v8cJ4i3f3l/P2K?=
 =?us-ascii?Q?w0kW8uBaA6rao3NxnYAp0CcvEDcDW++8y6NHPE516AVlBS8jfbrOhilHCdmq?=
 =?us-ascii?Q?QZ/8njuha3iN38HkXpP7R1yMY5lUzjJljsf8DJSydKwFm8UGSt0Z1EbYKk/S?=
 =?us-ascii?Q?pv3603wRNZ5QXoJXi/3BHpFLdpv2o9o7yR+bVSUh2bPlsOSlLPWoKvb/tqtc?=
 =?us-ascii?Q?qiFzT+6knnUORcBfi26DJ810RcytJrU8QYsrYr0jgOc9U7FQOIAwnVZIwsrg?=
 =?us-ascii?Q?g4shZfJos2IGDDxn8TYc8W5kbTplEcmZM+AkXtECKljN7VBUg3+VfCrCKUbP?=
 =?us-ascii?Q?myZ1qZ3qEtU02a7ZSQ4Tln6lEwya4td9n7HMGN5siS6qJgERm7JGPkLOwA08?=
 =?us-ascii?Q?TTgxMLISmHZBvdA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:00:44.0267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17986ae1-6581-4db2-2e77-08dd613bfd97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 37 +++++++++++++++-----------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 387a626936b3..9458d95a4795 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1574,17 +1574,23 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
-	int j, r;
-	u32 f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
-	u32 inst_id;
+	u32 inst_id = ring->me;
+
+	return amdgpu_sdma_reset_engine(adev, inst_id, true);
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
@@ -1620,17 +1626,17 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
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
@@ -1638,7 +1644,6 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 
-err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return r;
 }
@@ -1985,6 +1990,8 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_0_ring_preempt_ib,
 	.reset = sdma_v5_0_reset_queue,
+	.stop_queue = sdma_v5_0_stop_queue,
+	.start_queue = sdma_v5_0_restore_queue,
 };
 
 static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

