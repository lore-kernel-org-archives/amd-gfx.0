Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A121FD2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 06:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CDDB10E672;
	Wed, 10 Dec 2025 06:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sDEpet+Y";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8515310E671
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 06:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9l8NUh21hpjZMRQn0XS7R25M4MEktemKULdtCLdoXPtiHxRZMNdNy/mfPIOH0PWLIMhrFmB5AWi1b+YhB9X6WxRNI7XdnaNHm0RarT3dnnXnbTiEufNxRu8CMjT8CqbGF7OO9SIObXRyXoQzXOJw54Li0yVkOADp0HcvbMdMFOxfjT63zK3D/Gcu1klH3EnwqpajaGupvWehHvhkKAFJCo4fUQPJGGcP2IQ6zvRzO1l6HTLOQKDOJWnBEgsrFW86i58TU8L1WlEjv/r3kEns9NTYS8BeW5MfXD3B+SzlcyWhPSA4P8AoPk3pQb3eGM/XZEJbgUwuo+4oB7eXiG9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRoezXvvFRHPSl/FqpJepC3nSt1WXZ4sd6eJp5x+tgE=;
 b=k0jTWJ6A7jJ2hW0DF2Ue4MXWL5WfXkiJrKEgsQWG+yF2yjHfQF+nQMQcXrllVoeU9o5I1HKJXIPI/uyOiycWTDwZVlTBzWFpzTkPUG7SbQiObW3vrWCU2h49KL967d0luke3wBz6H+3YDC6pma2B5j4x5tYAVgZiAnlpt9+WC9PHql8WgnL9tU2+NpSN/PwkyPJqGV4N6V0tPt2Og55wkO69jHZUB2d1Q08Q4Jn8rffJ86wK/b/YAFEEQ/2b1LlxCFuVA1I7ne6Tr0HgK75jQPxnXj1hrvfSWp9xLTs3/9kmgC9YmVuIdICRzzCldf9tdCYLHJY6+oeTCIVIuKR58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRoezXvvFRHPSl/FqpJepC3nSt1WXZ4sd6eJp5x+tgE=;
 b=sDEpet+YDmUNFFxUfgP3n1vcDPbVif9U4RVyxzXtr8Rs34gfNKAolpg5VpeQ2wk6zLbjT3ef/wurlBc1baT0f6mUi1gsFm9PvX8jrsxfEUcEbo+MDVbjgQ1MOkKhjw61HejU5s/6B4aRGE6zH9nD0DWjlZeqG2xWmJlvPdtwogw=
Received: from CH5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:1f4::25)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 06:36:36 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::4a) by CH5PR04CA0008.outlook.office365.com
 (2603:10b6:610:1f4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 06:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 06:36:36 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 00:36:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/gfx9: Implement KGQ ring reset
Date: Wed, 10 Dec 2025 01:36:20 -0500
Message-ID: <20251210063620.5816-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210063620.5816-1-alexander.deucher@amd.com>
References: <20251210063620.5816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ee870c-feff-4371-025b-08de37b6779a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iTcjz15+V3LgC6/4JulW/m2rbJ7Gb/cRDprmndEbCQl7f3sRmzCnecN3ofWi?=
 =?us-ascii?Q?0n2BM8BFX7e3e35WY6zykpYebedCRDCT84LPthzg7rxmqZvtuHhibn+y6ovC?=
 =?us-ascii?Q?bsMI09caguKFOumwN50pLofwwgwxpcn90zq4A94i9Grx3asA6oMOoKlgtEv7?=
 =?us-ascii?Q?/qQ1a0NNcoLgO87Gq6r6KNL1ZqTD39+Z36sKhnyDhrIhqt+3drh5z10glopd?=
 =?us-ascii?Q?RsyD4FbyCDwkTuQ54y5B0vk654QVgUrt6la1MDTcVSnvf1MCZ5OHmUSFnq8r?=
 =?us-ascii?Q?mlqCElM347aSdt7HMpdu7/fpQKL8xb9cSYfmh/vJQO9Hrjf+Xd4Y4eIzaRGf?=
 =?us-ascii?Q?IqSuargPxeRR7Eg0W/invrSi5JsHi2+8REsYEhzgUIp23oprqFAB0hDM7/Jt?=
 =?us-ascii?Q?tut1UdE8Yk4bC5xUDygvl32PZ2jV5uYWsXQWl8poDZ5RMA8C7mAYCZ8XxZxT?=
 =?us-ascii?Q?DInE26+ek8sAOkWCdXkwDHdd6+x6N6ayma9FU3bPnMk7ynDxNjlENyXSKcHK?=
 =?us-ascii?Q?DxLzbmeN27yBHEyDor+p68dY+qna1q7PHTQ+sKeGhSobApnWooxHQIkjuCc8?=
 =?us-ascii?Q?FGh0YxpmMjgJdU5oOul6QdfSomUxGniQO8i0abNN7bhHk33iKlDtlILBhY84?=
 =?us-ascii?Q?gpZejeh6wLdHvCqvDmNiA2ukjwGzV/ZZ1u3W/K+z91BMnjhqZIxikp7NBAGL?=
 =?us-ascii?Q?qTVb0Zp8RwhVDSaevIxIGlTpc5PMQsw8OamtFLkXu4g5Y1JLC1F7LczwG6uu?=
 =?us-ascii?Q?dujxG7bb6gTvCnn09/B6+/flGR9NTM4+3dGSllkwWoibSm24nD8dcTFSf2Yt?=
 =?us-ascii?Q?zPG0nedlLb6aWVbRQNxjOk0sNvX4Gx3Z/lcSIdmWFyIJd3ghG/EotYrMr2m1?=
 =?us-ascii?Q?AT/qcO0J9Azh9zW7eHfwyqleAKjW7ETbSNisrXAfAlrGcOzI4bCeMg6TtC4t?=
 =?us-ascii?Q?evtNEYfQu5OgOIfWMdBJTRoyowzf63z5p31naMwc73UYGdUgIGOvuR6AkKXa?=
 =?us-ascii?Q?QdPwEOo6PzwAmeMHvxGsnOIcKqXMwGIXUI5ZeZuv5wyKjaBGbeCK81LEkxNK?=
 =?us-ascii?Q?Ji6Ed9GUf9ZwZo0PWMsIfztcABsBleVbi8QcrZmzWUke9zqygZz7S33If1wi?=
 =?us-ascii?Q?pM9rDlTrzXWvpIwZYwnDYMtT2t5oQzZXIRoulO6nisEk2+ATwCBcVPGMTG4n?=
 =?us-ascii?Q?wRo9xwlQ/0oM1thjL0r+VjCqVzR1ivdERbbeJM/erh/Mb9BWW2pYyMJVaXnG?=
 =?us-ascii?Q?Ljjfd8gQN1dOyIx0pJS7zg6XdX9NWo45uvi2LgYxHCoH6417YOYN76VK5cFQ?=
 =?us-ascii?Q?ceKNOE31qXzuID/mBpCGMvRgfuS3hxHUk9crOr1MskDsJr84BrAIOB0hqvRd?=
 =?us-ascii?Q?L8RHKax4hesLGAod5oIeWWmL5tmpjTnkIxg9visRhJb1mCa/F6zNIkibF7fh?=
 =?us-ascii?Q?pc8doIG5VNrArIYRxqVsUCcSCBsDKgK/VUNoYmWuma+AC09hq6XvHns656z0?=
 =?us-ascii?Q?If8UCPv0SiaUNNxFEKEtLwPKErbqZQ2xsnJ0noCw8Wrg6bPI++TpZEsFNJCz?=
 =?us-ascii?Q?dZBirIccpSolYRCVLnk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 06:36:36.2818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ee870c-feff-4371-025b-08de37b6779a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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
index e6187be27385a..158c8bdb213bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2409,8 +2409,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
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
@@ -7174,6 +7176,103 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
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
@@ -7452,9 +7551,9 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
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
@@ -7553,7 +7652,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_wreg = gfx_v9_0_ring_emit_wreg,
 	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
-	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
-- 
2.52.0

