Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AE4D711CC
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 22:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11DFF10EBDA;
	Thu, 18 Dec 2025 22:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="13R8r0Iu";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AFF10EBCC
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 22:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xjcbhnc5hh1gAokMQhbRNVaDio+6/kIC9r1THph6xn08hJfjmOAAEm9x3+XJGV/3mJEoFtZiSYlNAKJ2B3FCRNQEMPShQe2B4yF0a4OBaIFm3jWiVfoTwua1x1o9iCkXYAA0EkjmxEUoA7WLsMZ+hRben60Kjvj8IZBQ33Fl3yysL3oJ+I3sGXijnL4Yva/CQcAzNTfXKAc1Kc3eMmcXWI0Xm9UaICdWrEzxGf75JYxoRJEBf+VLOuwj3yJ/t3eboVQJ8Ea3vVuBO5Cyj/0tIOUAbcPWDnE5UV9JKm50vX5FUe6uLXU2OSAyl9eGmxkseuNn/s1Okzx/8ez1aWxOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9l3JLu24ZaDrvIQ2BDl510x9wq39cHj2iBTr6maeQ4=;
 b=oIq8G4u6W/VHrsziqlKZUIiW6IzlTVpas7hv4gynZXF6FAAPIFJoFFApJDySU1Pbo2Pz9h8z/Ppgkpe/pFCKjfxWKtBKgJUwtOydDnO+Pa5dBZ+SDHnVMa/u0yWk2B/bzzJrxm9B9wnKtxZ/G8dSaeYbJqHzBGBPtklAAJ0/S//ZoctPfHMY7sX250ni7SR/9wu/5HlXaLhQwKoVGy/iUyVmkPre3EvuhA1i7M/hOiH7S+OpXljT22lkEJuBkrHRRqnW6+NYdvZZfsbVCB/7XmSPmgVvo/uyARC0hXnOJi0VwCOldh5M8+5dMhyjj2YB5zcR9SrwKPh8B49CQbOvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9l3JLu24ZaDrvIQ2BDl510x9wq39cHj2iBTr6maeQ4=;
 b=13R8r0IuzFZb9rg8yhnfYj8m9uGThShf/XfVCEhiTAVeYZSrPNXFDfIfMO79lEMw+4rmbPyZEHyurbo9YoF7x+ICb1d1Eb+Al+rvkrHfQHqZZJACZ/jYsc2mmBZVBuURm5fIJxh9TWQWy4n1P7ugg+77pljZrI7qOoyaYWAazpw=
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 22:42:01 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::b) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 22:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 18 Dec 2025 22:42:01 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 16:41:56 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [PATCH 7/7] drm/amdgpu/gfx9: Implement KGQ ring reset
Date: Thu, 18 Dec 2025 17:41:41 -0500
Message-ID: <20251218224141.5841-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218224141.5841-1-alexander.deucher@amd.com>
References: <20251218224141.5841-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e7387f-f9aa-401f-f3fa-08de3e86a90f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cBb1TY+l7vLd7ck3n0AcjuiDCq3KyyLyiFE3ipQ1vUb58ht+DvDv0fF1Djex?=
 =?us-ascii?Q?KDRz84eB5uar1bOTkz6kCL95i1v4JM2nqGmTJEvnz76CRm+Jx8LUu2jeeUIt?=
 =?us-ascii?Q?N4DBEXjgzJAGrVXe5juOJZsE0H3KDIl2x2v3hVTOPXje84ehQUCLkxgKhkIT?=
 =?us-ascii?Q?g+ERGKnrMcm6JoHwdVUmugsuQi/wNqKmAJDOWpfk1ov3flu1X64Ci8a6V42j?=
 =?us-ascii?Q?1ulN7Ar7GcjhtnXn5hFVr0mZPqFQrziXTLXivNqiOh2PJ9z1PNuhtKtXnBYP?=
 =?us-ascii?Q?GBSMp3fw91are5YHDmd13Jg6DqheQRIS6jm+cicTkjvNY/F7W7xFm+mo8c96?=
 =?us-ascii?Q?gh2RMfubtTd3M59k7d/yqAihacSO/DhpIde5W4cfc1Fd35WShBf2KRH8bBGW?=
 =?us-ascii?Q?ovrjRPUXibTLiRnhIpAvmqNpyb1pA2TzhW6e3QYNP0LtNJyxYfrYM1sNAUzC?=
 =?us-ascii?Q?+Ch9Vt6D28k9sI/cA7/DDIuFlKotv2AzG630rABH4ztiDYbcnIbebe+bb12c?=
 =?us-ascii?Q?8nnmfpkozHuj22GA2ZQv5kg4Vr4BnoLSZnCf1gq/2IaePpnQxtphlc7Pcta3?=
 =?us-ascii?Q?V0IngJabV8d6puSU0Op9eXl9iVPLzunZH6WOXXVg3aZEXQB56vsb6iGkPeza?=
 =?us-ascii?Q?q4JiqZ+s2eWa3U8i4Ya1PyxpWs/O/G+Dld51N/TDITWJYTdyLBDGPIBVFHcu?=
 =?us-ascii?Q?bRjSuxNXqXw9AdyNvUWJ3nRi1/etzFmKxpXtWrMUglj0esD4GJDLjsn/DPLv?=
 =?us-ascii?Q?8dOhs1tn6Xdzbt1amtAFswGWxD/9s8C2e3K916CFEKEaXw26x4bQqt61Iaux?=
 =?us-ascii?Q?/rWozWYG/BRbUeJgmgG2RaiJC0DJI+BXzs0Pf4Ww+7QNExgtLEgLzGMxF8ps?=
 =?us-ascii?Q?RyyWzcUtEgLh24gjlLOZ4h90ToU67iCG9kTlPOgxgENETEHjtYvUXPuxdtNh?=
 =?us-ascii?Q?jlFfOpR3nceLzSeZM+izz/P98Dcfzuq7KvmYbTZRUIoi98FGbNTZMSl2i7lo?=
 =?us-ascii?Q?LTODdNfW8D7V8BDS3H9sjjXtRssyv7WLtdWJAp2hmLlYsNkaaDx8nzyyRGLA?=
 =?us-ascii?Q?9qzldZnFeijZRTt7nJ8Tw9MeS+GoZz7SqhH4PED9vD/RySIvx0XmhE5tndFh?=
 =?us-ascii?Q?F1zwaznmCD1bIdpkrU2bMwNn+IuBJFCK3vKr2vNiF2PWmu7LWxciPhw9Jai+?=
 =?us-ascii?Q?OCqtzAii3e+ukgyeMU/HmihCo29p37WTrHE+Yb8uEf0d9NKjorFos4fur8Wm?=
 =?us-ascii?Q?mQmwyWngB0I4tBGvnSZL/PJDSYydwUuPWIHrvs9HphfyR9gCbTdJGe9V/jXa?=
 =?us-ascii?Q?QQAUcKVD50dGTNM5XGNY/REQjpNJKSg9gA2HIs5dWXlnFEefb7N8MlEmkqCT?=
 =?us-ascii?Q?yXrJNKpyHjtZyPWigGEM7+plz7zyQnCN5ILKH49U0zdcrMgBjkqskh3rnLkK?=
 =?us-ascii?Q?914oEt6FxCI9tZyIhny4gYdkBvhVZWm8WgkYL+fqrXimXsilFW1Uu9NmjzgR?=
 =?us-ascii?Q?satgUJn315fPfkRuwMJgZO3O7p+OIiSeoM6ONJLpKcpV+9BSU9Hw8vSqUvo2?=
 =?us-ascii?Q?AFct9Bv6S07G6DXH510=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 22:42:01.4789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e7387f-f9aa-401f-f3fa-08de3e86a90f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
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

GFX ring resets work differently on pre-GFX10 hardware since
there is no MQD managed by the scheduler.
For ring reset, you need issue the reset via CP_VMID_RESET
via KIQ or MMIO and submit the following to the gfx ring to
complete the reset:
1. EOP packet with EXEC bit set
2. WAIT_REG_MEM to wait for the fence
3. Clear CP_VMID_RESET to 0
4. EVENT_WRITE ENABLE_LEGACY_PIPELINE
5. EOP packet with EXEC bit set
6. WAIT_REG_MEM to wait for the fence
Once those commands have completed the reset should
be complete and the ring can accept new packets.

Tested-by: Jiqian Chen <Jiqian.Chen@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 92 ++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d9dee3c11a05d..9ffd7c8adc57a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2411,8 +2411,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 	adev->gfx.compute_supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
-	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset)
+	if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset) {
 		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	}
 
 	r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
 	if (r) {
@@ -7175,6 +7177,91 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_insert_nop(ring, num_nop - 1);
 }
 
+static void gfx_v9_0_ring_emit_wreg_me(struct amdgpu_ring *ring,
+				       uint32_t reg,
+				       uint32_t val)
+{
+	uint32_t cmd = 0;
+
+	switch (ring->funcs->type) {
+	case AMDGPU_RING_TYPE_KIQ:
+		cmd = (1 << 16); /* no inc addr */
+		break;
+	default:
+		cmd = WR_CONFIRM;
+		break;
+	}
+	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
+	amdgpu_ring_write(ring, cmd);
+	amdgpu_ring_write(ring, reg);
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, val);
+}
+
+static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring,
+			      unsigned int vmid,
+			      struct amdgpu_fence *timedout_fence)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+	u32 tmp;
+	int r;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, 5)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	/* send the reset - 5 */
+	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+	gfx_v9_0_ring_emit_wreg(kiq_ring,
+				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
+	amdgpu_ring_commit(kiq_ring);
+	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+	if (r)
+		return r;
+
+	if (amdgpu_ring_alloc(ring, 8 + 7 + 5 + 2 + 8 + 7))
+		return -ENOMEM;
+	/* emit the fence to finish the reset - 8 */
+	ring->trail_seq++;
+	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
+				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
+	/* wait for the fence - 7 */
+	gfx_v9_0_wait_reg_mem(ring, 0, 1, 0,
+			      lower_32_bits(ring->trail_fence_gpu_addr),
+			      upper_32_bits(ring->trail_fence_gpu_addr),
+			      ring->trail_seq, 0xffffffff, 4);
+	/* clear mmCP_VMID_RESET - 5 */
+	gfx_v9_0_ring_emit_wreg_me(ring,
+				   SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), 0);
+	/* event write ENABLE_LEGACY_PIPELINE - 2 */
+	gfx_v9_0_ring_emit_event_write(ring, ENABLE_LEGACY_PIPELINE, 0);
+	/* emit a regular fence - 8 */
+	ring->trail_seq++;
+	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
+				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
+	/* wait for the fence - 7 */
+	gfx_v9_0_wait_reg_mem(ring, 1, 1, 0,
+			      lower_32_bits(ring->trail_fence_gpu_addr),
+			      upper_32_bits(ring->trail_fence_gpu_addr),
+			      ring->trail_seq, 0xffffffff, 4);
+	amdgpu_ring_commit(ring);
+	/* wait for the commands to complete */
+	r = amdgpu_ring_test_ring(ring);
+	if (r)
+		return r;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 			      unsigned int vmid,
 			      struct amdgpu_fence *timedout_fence)
@@ -7453,9 +7540,9 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
+	.reset = gfx_v9_0_reset_kgq,
 	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
 	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
 };
@@ -7554,7 +7641,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
-- 
2.52.0

