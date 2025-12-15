Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C339D5B84C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A024010E61D;
	Mon, 15 Dec 2025 16:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AGtHut0U";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F0510E61D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:08:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J18MvsGjlgaY/L/PS3rbAUepIGr9ltIxziwPRyE3JVZHVYFsYUcnKAg5qoVN9jNshk/gAo2HRqimJx6oQhD1vjsmh5I1wflyUyqWTpGFS0VpOgp0p2nPXEu08YKExifFLrkR+d7H7a3jC0GHXdY18hsmizQpqbAnLj5ZjyEYYbCkjEmXVKmaIuT7RpJYArHh+ahQ7YMJcBOjhQVQZ3PeOWGGB3EEjn1BBQKJ7g9j8DzfI7NBYtjLtC3YYCseiiFAEY7Q0d7I0miDsanUrePdkGzY57LBJ5a2aFIu6Y3VeLSS7aXHB3zLT7uVibgxL4I/whcdm2exrZHEsq/hsCUvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E8fRiO2e+UN1zt34F11xN6f6lG5ufEBCGotGvQYJYs=;
 b=jMUxDrdC7qbTFMU8YE8fOGaiUksZ1RBFmqgmOYTy0EigjTGG9T2ayv2ASfzBJ2p/I5jxXUNDPcaNjrQDcqKyombpdmCFZMaYJYCmDvNOFTPGXHnaC9dxYbGSYILp9XsJsf9YVC2mzyXP3HvqFwDkNailayxjoghCmaH0mVSOXdQYcKyqS+hZRxHeZtlzhU7kz6w0W9k8Lbe3NPnAgXjyCihNMn/gt/I398hx9kyRbXU0//h0j4k2djJUOifIMmv3FPCLO/vdRT+/3oz/lrXzgqvnDIjhMgIPS3SBZowVxD50nQCvk1+FY/zQ+vI/HizvFRlngAQv2I6s64JVCM5I9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E8fRiO2e+UN1zt34F11xN6f6lG5ufEBCGotGvQYJYs=;
 b=AGtHut0U2+cYby8jaiAoLMxIK9o4liIfI9UNWxTa39LFETO/llU0/laS7aJReMLThweoaoo0WFuIHo2tX2NlcECnYztFzym9LCH4hXlnPne6oW6Xdnh9HtX43JNqrp20WESIEAZRaOhDbY9FcSLuTm3TaRaLwhXT/x/ADZZTq+s=
Received: from CY5PR15CA0060.namprd15.prod.outlook.com (2603:10b6:930:1b::6)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:08:44 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:1b:cafe::7d) by CY5PR15CA0060.outlook.office365.com
 (2603:10b6:930:1b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 16:08:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 16:08:43 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 10:08:33 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/gfx9: Implement KGQ ring reset
Date: Mon, 15 Dec 2025 11:07:11 -0500
Message-ID: <20251215160711.11832-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215160711.11832-1-alexander.deucher@amd.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f74eff-042a-449b-4777-08de3bf43865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wTqQh5yp1Lq4GWzRmwD1LyjqQ2uz60bxz1vSwGHJLBBMgLzpUaVM2K4Ooq6v?=
 =?us-ascii?Q?OsUcStcA4zGOKTWx3suhEabLe4JV5x9yfbd9ed6q9u1GkrXxHwnW6+Hx8zls?=
 =?us-ascii?Q?wxDr8LRXkJBylKNgcqsqNM9Roue+e9PHg8FR0M0Bpfrb81MCwLy/buye5h7j?=
 =?us-ascii?Q?jPtOJRxRfl+UgrVvFOBtKh+0WxSAuOzGiaqQdaH5r/ImOc5a7iiplvuo0e5k?=
 =?us-ascii?Q?fGmLnyGWk51Hd/EhSq4J0F5wxDhn7Qsi44J+XU9bc8V0Ive2wYB9KwOUbV60?=
 =?us-ascii?Q?ZVJ7EJ6FbuENB6wiiZp2gP0Cq6/QN2Wb2ekfdp43xRoSh/VU1F/2j9hEUToN?=
 =?us-ascii?Q?G9JSDQGuvqg2qh5RUOcogywywj3uKuySmHdqDOPploo3WXkAqNhGy6hT/QVi?=
 =?us-ascii?Q?lB8LI7Dtqm9Oa+7jamOKbfNN0hFsiWvkcxEplS/p1jvRuqXUP4h8Lx+sphFL?=
 =?us-ascii?Q?x1COlhQA22QQGgzSqHsB+R0DiSQeJbvYSBr0BE3YE+G4GHU8WCmaz1t9j5EB?=
 =?us-ascii?Q?yYadkH6oJpoZJ+ZEEDchNSqJZjI8750vVtOxrRws+gGp2FJenS3N3Edq0H5M?=
 =?us-ascii?Q?6gjXDe/EoK/57QL3CPJU0G7pDCPwDUCnMQpSwNmE8JHU6Cz/euHzl6Qd9hfb?=
 =?us-ascii?Q?b39i9fq50zYzezdsncsLW1gAcRffcz5p1E/35HFsRtCI762nJQoHvijn3OeW?=
 =?us-ascii?Q?NOUKeNg85d5xV19L7J2UqKGUnTZzDApL+JLV6qXQGPQpHumubqkffI9IEbrz?=
 =?us-ascii?Q?VxJq6oXdimyiEc0sMtuI5HRJseg9+MN6gl3Duyylw8NqZ+VTlAgEarq6JiTU?=
 =?us-ascii?Q?mQCZM/uhIHvxBBOHBzXPd8X/0sG6T7gVGHG/W3y8tVCy6IgccLkpWmYYb8WZ?=
 =?us-ascii?Q?y1IGwk6JdFhsOVRguYwJpAnbb4SDl9VlEOGC3FxVcSq1c0rjUHYY7CHBqFxE?=
 =?us-ascii?Q?4X5XxDxpEvaLGQMqTnXkJCA7oLlY2QFo/IjlNeyVA2M7P7ruOzeA0Ec052HH?=
 =?us-ascii?Q?60o5MADHp5dFzwY62wHnpDFnwvWJrq/zjJCHUXAL7cRAyCtXS5OSFwuj6Znf?=
 =?us-ascii?Q?+lNi6+IymCPLjtdceMUogzzDpbOf7x+X7NCrBNmfCADDG7gAssUl9Mfnzupf?=
 =?us-ascii?Q?Jm0wKIlvQQf9IEapS0O50LdXI5fkuQ4svYMesUy6c2lSvxwTd7mCFK62llXP?=
 =?us-ascii?Q?20elhLh9sd481y07ZR/wVNp/azgdHszHxx5yIOozEJWA0l3JYqYqU4/JiJ+z?=
 =?us-ascii?Q?NO5T1yr9FVLXuGzz8IxtUNLEPHPP5DzsIE3IzAAQ5FuI6ejAqe3dOSeGZmD7?=
 =?us-ascii?Q?4hedau5hJzCFH73FzIX2Xz6UfN+n+r0alYOHAaKK0VuoSgdlpCNgNkGYQg4G?=
 =?us-ascii?Q?DcAfTqyodF61/RbCJUfdP6shpv9RlNb+44QurAQbkfNoKPR9dHtSpXsHooN9?=
 =?us-ascii?Q?KxzKIfEz9uR8tJgVtmaRCyyKQKm674hlQ2kLzRfCayWsa30O4rsfJl41oZCt?=
 =?us-ascii?Q?qbF6/zocGLyd/phmExMT2CXwoZY70Sz3MtjrAidPt1vMfVjflaPv+xgWb8oq?=
 =?us-ascii?Q?0IpiERPVYKLKBXBFuXE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:08:43.6538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f74eff-042a-449b-4777-08de3bf43865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
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

However, because we have a pipeline sync between jobs,
the PFP is waiting on the fence from the bad job to signal so
it can't process any of the packets in the reset sequence
until that pipeline sync clears.  To unblock the PFP, we
use the KIQ to signal the fence after we reset the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 104 +++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index bb1465a98c7ca..9b7073650315e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2410,8 +2410,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
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
@@ -7163,6 +7165,103 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
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
+static void gfx_v9_0_ring_emit_event_write(struct amdgpu_ring *ring,
+					   uint32_t event_type,
+					   uint32_t event_index)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
+	amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
+			  EVENT_INDEX(event_index));
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
+	if (amdgpu_ring_alloc(kiq_ring, 5 + 5)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	/* send the reset - 5 */
+	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+	gfx_v9_0_ring_emit_wreg(kiq_ring,
+				SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET), tmp);
+	/* emit the fence to clear the pipeline sync - 5 */
+	gfx_v9_0_ring_emit_fence_kiq(kiq_ring, ring->fence_drv.gpu_addr,
+				     timedout_fence->base.seqno, 0);
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
@@ -7441,9 +7540,9 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
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
@@ -7542,7 +7641,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
-- 
2.52.0

