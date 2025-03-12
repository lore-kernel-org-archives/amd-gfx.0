Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE49C2BA1B
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 08:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CB110E743;
	Wed, 12 Mar 2025 08:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OpsGzCuS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3331E10E73D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:01:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPP9BP7PdGeO2IhzEaiKzxOODU33+sTSqhUe/P6RC+9b85wYcPDa/vegR8zY1V8sSeOlhd5HUnWbXgS9jalSM0WqHDEHwGAzT9pTLfHBcL5yrkaSmSqLzTkP8UyGGQWk5FyQozOPEnojclLkfEmVQQACznnYvkh8ZJZZDAPIcleQyHLfXy3EOFrnmklmPa/zk6dACm2W7AFKoFoBTbBcFEaBkQ9Geykw82d3HsrgvJb12SKqcic0u4Y7fqN93HyJ5ouFz2I/DUa1zlxNDVGAyP2KT6S5hY0sKo9CXiKK+wzeSOBRR4hI9Z1ktnBv6O5Yoxh6UWv2eukhiCM2/UA2HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+0jmF7HfFXICQ7jWC+RN0cT+ExivP5A//vvq86HK7k=;
 b=GOYTzvq+Ul9CHShuYYMuaTv5kLmP4MgfGL/cSnloLtYpp13KBOkAMemgbvvMJRcB3P8SOwMPAmMpJ8xsoRE68s+LrG1ostNnovtj1EpCMcOqjj+CtD4AVvXIcQn31BoOev1olp9042KR5ZnW5S5zyaUvrGuW7BlZm0XGAaLEsxCk2L33QnpgFS3W4PqwtyXAO5FDIeoo04+FLo3OBsuecdC5GfXidH3v1hbfYVsBQcL579AqLJvrW2al7ZonPWptbzdX2P6UeVBYKzvbVewjM0X8QO/pgpqo+9AKnKK0w4uJKk+i4VqXIFkMhO14PaeqBXSFQsYw9btTzwajVPxyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+0jmF7HfFXICQ7jWC+RN0cT+ExivP5A//vvq86HK7k=;
 b=OpsGzCuSdlT8ovhScEypvLDASIiT3pd+4/o2mt0z38qCp849dttJYJ53SDKuaxo6V+VW0wrcUnM2LYanMUryq1HxiFrercJBczWiuc/YaxSss9VnaPvtpNCBiCH6Kj+3p92p0al6ypB3YZR3QX3GzoSCKZoovIaYcxXgdMyQhqU=
Received: from SN4PR0501CA0002.namprd05.prod.outlook.com
 (2603:10b6:803:40::15) by MN0PR12MB6246.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:00:58 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:803:40:cafe::1b) by SN4PR0501CA0002.outlook.office365.com
 (2603:10b6:803:40::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via Frontend Transport; Wed,
 12 Mar 2025 08:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 08:00:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:00:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:00:57 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Mar 2025 03:00:50 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 6/7] drm/amd/amdgpu: Refactor SDMA v5.2 reset logic into
 stop_queue and restore_queue functions
Date: Wed, 12 Mar 2025 16:00:02 +0800
Message-ID: <20250312080003.3224976-6-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312080003.3224976-1-jesse.zhang@amd.com>
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 08699d1e-860a-4e1d-d128-08dd613c05ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jIzRPSCiLQFmjwSRoWcEUKtRnA/wPl9FvIlpBqKWb5dhRNyVbTaxIzQkY5kO?=
 =?us-ascii?Q?h0RekthQAmzS7xjrdsnTNQ3EgdUYVWfNiMevLriFhNbTk1qPfBqDS/oCkCkJ?=
 =?us-ascii?Q?wWtps9W4HcWTvWkm/Yz8+RpaqIumWH3JwMeN3A0jO38ji+KNUeCQoaCZxIV3?=
 =?us-ascii?Q?FS20JJLvnf5/dox2nI+aSqC45Lm0JDVlnnZwTFUZLpm5kzFN0oOJ4avt9DF0?=
 =?us-ascii?Q?THIPB+tkPW7P/fFSld30QwaqAuxr5PMF2Z6ju6PxCMnqLx+wizPomBZfekIO?=
 =?us-ascii?Q?oLt6M48+S8lkhG/EcAGJDveAEFCHNO/WcgdxskiE7Xr2udpQNPlZIRzTNCQF?=
 =?us-ascii?Q?dPi6mk4UvwNnTA/+QAhiEi+Au8l8FdcP+16HH1cyU0mgLHQQciFRnNbmPBsY?=
 =?us-ascii?Q?vsrKVMN415Glo0fpVT8VCebbrUyu+ekNJu5Skf8Jyb81iNkFXINy6C8rImnj?=
 =?us-ascii?Q?QWMd+cPifk6bidaXb6XW12gvVYqxtMPI1fN/k2HW62iPm9cx4EjCRlo3XSiQ?=
 =?us-ascii?Q?d6eIPTFweXPVqbY/F//JtR/EFpSJgk6iCo5Emogmvpu7zigdzpUMEuQ2ULYA?=
 =?us-ascii?Q?UWtWDAKbCksijYHObwPIH2sO/9I0PpXhmngmdNDD+hNcY1NKeFdyIAm6yBc/?=
 =?us-ascii?Q?88LNOiWE3p8hB3VdOkSmbOxj0GCjrpZybfmA5fqU0b/Gt3ZptNLcfM2Ed6Yg?=
 =?us-ascii?Q?hf4Q+QzgSTPloXyngECX6mcKZ5IB10hSifMmzM/3G3f7YB+gjNnUEcIpbrZC?=
 =?us-ascii?Q?13XrEwWR0t33mi1K0MG8HeeSOVISMsImNO3OzPuPBEPiGZa3s7eJ2/1wyidt?=
 =?us-ascii?Q?GxWjtgQdd7BobkhNV+O9hn1/4KqcPzxsRkZHMG+JGS9qv0/rOu/e3BZQijTd?=
 =?us-ascii?Q?IoD09vgj+uaNow4xyC6b627o54YbzRbxb12L9uLA1bpNif96GN9KQTpjRjXk?=
 =?us-ascii?Q?cnHNda/LaTcqIOuaes4yXrhhazCHgpInp6BcoT/K4SRr78crcAQOyLl1Y01d?=
 =?us-ascii?Q?+HuA/oRnt3WjTC9YONB/HfGyujm+lomkAOf4fX6LKYci+H7ygTDMmzNO4odD?=
 =?us-ascii?Q?AuQ9CZ7hK14hn28nhVAafKvG2DLO2K0GQ49dSLOg9x/pf4OvZAIBgqmClezq?=
 =?us-ascii?Q?7hXK4gxc5pUdUGIV/RdoVpjRDRy+tOZEbZ+UFp98/xa0QK19kYbo9T7Zck9I?=
 =?us-ascii?Q?n/B/1dxwV01O6QUHMjRIoXwmtLN4iabQr7fv6+iSeZYEXy9FlTQpSx5yLTz1?=
 =?us-ascii?Q?ACG5NkAqv3PdL1DIddQuJ1Y1utMC88a4YyhD4O/wiP/XcNcZKQ4XCNeFGqoU?=
 =?us-ascii?Q?Ql6QDzZhDIx/S7IBR6DersYA3//xmUzvxkaik49aa3fobdciEmI6CCy2Ko4o?=
 =?us-ascii?Q?S7D7gmxEKt6BPr90iVGlKr2knYZhb/5FR8fN3/MJln3GyY52Tl7U2Gm6Y4bG?=
 =?us-ascii?Q?aMDZz78t3FU62EtuHIQahsdinFFHjlp6if0KNLxG5mY2ghgPxBixdD10k2EI?=
 =?us-ascii?Q?YO0wUxAUXBl+dfM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:00:57.8913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08699d1e-860a-4e1d-d128-08dd613c05ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
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

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 38 ++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 267110725b2f..faccac68a27c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1474,18 +1474,22 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
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
@@ -1523,18 +1527,17 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
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
@@ -1542,7 +1545,6 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
 
-err0:
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
 	return r;
 }
@@ -1982,6 +1984,8 @@ static const struct amdgpu_ring_funcs sdma_v5_2_ring_funcs = {
 	.init_cond_exec = sdma_v5_2_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_2_ring_preempt_ib,
 	.reset = sdma_v5_2_reset_queue,
+	.stop_queue = sdma_v5_2_stop_queue,
+	.start_queue = sdma_v5_2_restore_queue,
 };
 
 static void sdma_v5_2_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

