Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E28C5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 846D310F3C5;
	Fri, 21 Aug 2026 19:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O2P1bqZS";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFE410F3BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgrhFDxFZ8rc932qhCIGhPmkuBUTCbGCS/LmaAw0wBkJl43hol53b1bC38gErZzrG+xLChXlO3i+8z5JyhyC6O95DQFZukFIBKHj+vZVUxrFN4UHwMRl7WNLfretNuH1F1HXPuJ7vj27tNPCeSKNyzi/7vVgi52cZQiKmwQ1P8zvrPhqgywHHAxBWFJ/ITMO1XApWo2XXEdM01KaE0k+t3iYdn3z26lxgPvZ9h6k1b2jw9OqCdXrGltwESap3VJjPTdZWy8HVVz7ACqU+K65eLbDO4DXzpXWqpWqpe67iud4/njgwakaYoG0Fp/XeSxTDTYRIqRUkaWNhFenmpv8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzHDGCa4bXd6w41X3A53qbWduy4fNR2DJ/GtxslJ0og=;
 b=ckzAD3bpwXoMUiJtgSOIfwlMhytinKj3dAEPYltxlEqu0c2jzh9qwmF085TOvmIl7AFBecHVH1B7/o6+2FQUR5hgPI1ABS+D+cc4dpWhjOO9NxEVFqcDto/7N1ENLYnj6gqw6ZyYlP49XoEVvdTIs1uFLJea3vfvL60poGFWEtmXOKq/V/q3vbz+DOhXR/UK7MaMuh7uWrTWndzmlbRHK9Ptv4owOGL3YJiwtTcJN+mPL+je68WEcm0yZSsgnImkkkiV3bErv87on5JJDaDQ34+9qD4T934khkH97gukZVkBw7drhOLMcHmRCs9gKr9FElDiW7DIo3BRm5zftyerXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzHDGCa4bXd6w41X3A53qbWduy4fNR2DJ/GtxslJ0og=;
 b=O2P1bqZScLxwTu2DXYDd3RGTUgtF5CqhUF9SpgzV5QFr4dhz968n+1zZjwyBKCzlTRh9eP0zyAxv2nCt7gfo2rdFAj+zgraLSyanC1MJ+5kGRhMZ/D9h/8UvhRNFIIgEGncbL0+2uafSEe4uKuBRP6qzw9PZ15wn2pGizP3RyPQ=
Received: from CH5PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:1ed::7)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:44 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::56) by CH5PR02CA0005.outlook.office365.com
 (2603:10b6:610:1ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:35 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 39/95] drm/amdgpu: Add UALink firmware writeback address
 configuration
Date: Fri, 21 Aug 2026 15:34:02 -0400
Message-ID: <20260821193458.808626-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ba20ce-9f4d-4072-92c2-08deffbb641b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 2vYnFvT8L8QRSxRCduQGM86ZCUxCsVgljIcxjXJhkn3g8jKbnn/aKEziNTajjOwF34ulXHAYjE2z2Lp2aoOduyo7AhN9Ji3S/EMP6w8U/Z4yhBD0jTrUQ45RCfWf5Ya4LFx1Japllo1S9Flsjzht1J7tlcQlRAD8GpFtl/8sBAsPRh4UI6k3rcbhNX6b2HWBHv2c6mEL5fK8VVO+H6I1N+kzyKcBhYpImpFbqA6VGd8FN42GI/27Iv63f1E/GcRA11S/nP4aHeym7+jWhhvXGGHmSg85WzSvl1nHG5BdfOfkTA6YCTsmNS++jNf26Lk2aiAlYZ2UVqTDtMJQ9Zz12eSSj8MUDUvZjBzEsm2sToYSHUB1C2BjFXFhscpNjI+yA0iMh6UiBfP+ZdqvElazsFWImbWGuu91/t9La3Hxll8w+ute5C6xYFRRygJYt3Z8+qIrBCPA+JFM/5LJvivaUjsPx+NKQtCAahDZSns/O7pea57GGycIarR0Z3g/jrlAUUf6ixzvM/uQm7GCNjt0QSp+wEu3ySxSpe4GJ3buH4fkOR6KlGb8pk1KgscWa+pyy4WoX5I8jhNgqcDvUMr+xHUhETl1GzBhrVXy4BFBAgNg3DDcaA5RQ2t7pJ9Oyvf/zp+R69NLLQPoP/KxqVTxIVMrz9gnET80sRA72/Ml8ChcM/rNXFTV4iNoTBXLIb4IoNJwhvRcp79AVc4KAO8AMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Qvvz/iFxvc6SNLM1oILxVjswbdrrPXLIJsNSYiwuzFLPHYBNyPRP9aLpkZtU02W1U+dnkpG/1x4Hvo6wR3r8M4qVXZAfDbIwloRmhLfekoPe/OCY5GZaUFIjZpKCcnu1AaJXtDvJ22MAq0QZ6eiR4FNAqEEPAqGbSnTpt05y0JmBXEGDVdNwTWOvmL2Qu3fMBukbGUvpXrIWCwK7QcPgcEIHeuVE60EQcued3atMLGx/eXlQbMl1mPlck/PhqKoH3eH+HXnKO2/Fjs4N+6wwj8Ycu4Sx6rgh52JTuDm8xFzhlwV5nuFQm14dONWln0RDasSZU45Dixnsn49qq7H+1cxkJyvynzgd+FlwXH95IVmjXJvak2J60SfuSFi3SD9/Igcs0KBnVvylxfbCq1OJxSsQgJN2cUEzyFzC+wlAWWeCwdvbQeNnzyjcJIORgz7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:43.6144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ba20ce-9f4d-4072-92c2-08deffbb641b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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

From: Philip Yang <Philip.Yang@amd.com>

Compute the writeback buffer addresses for a ring, send a configuration
command to firmware, and mark the ring ready on acknowledgement.
Configuration is deferred to first use.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 913d53fe91fc1..dd95e13570d1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1292,6 +1292,9 @@ struct amdgpu_ualink_ring {
 	struct drm_mm_node mm_node_wptr;
 	struct drm_mm_node mm_node_doorbell;
 
+	/* seq, complete status write back cpu address */
+	struct amdgpu_ualink_wb *wb_cpu;
+
 	/* true if fw write back address updated successfully */
 	bool ready;
 };
@@ -2651,3 +2654,70 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
 	return r;
 }
 
+static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
+				      u32 remote_accel_id,
+				      struct amdgpu_ualink_wb **wb_cpu,
+				      u64 *wb_npa, u32 type)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	u32 accel_id = ualink_accel_id(adev);
+	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
+	u64 wb, npa;
+	u32 offset = 0;
+
+	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
+		wb = (u64)remote->rb_cpu_addr + rb_size * remote->num_accel;
+		npa = amdgpu_ualink_npa_addr(adev, RB_TYPE_TAILPTR,
+					     remote_accel_id, accel_id);
+	} else {
+		wb = (u64)remote->rptr_cpu_addr;
+		npa = remote->rptr_npa;
+		npa |= (u64)accel_id << AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT;
+	}
+
+	if (type == RB_TYPE_TLB_INV)
+		offset = ualink_tlb_wb_offset(adev, remote_accel_id);
+	else if (type == RB_TYPE_REMOTE_INTERRUPT)
+		offset = ualink_wb_offset(adev, remote_accel_id);
+
+	*wb_cpu = (struct amdgpu_ualink_wb *)(wb + offset);
+	if (wb_npa)
+		*wb_npa = npa + offset;
+
+	dev_dbg(adev->dev, "source %d remote %d wb npa 0x%llx\n", accel_id,
+		remote_accel_id, npa + offset);
+}
+
+static int amdgpu_ualink_update_wb_address(struct amdgpu_device *adev,
+					   u32 remote_accel_id, u32 ring_type)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct amdgpu_ualink_peer *peer;
+	struct amdgpu_ualink_ring *ring;
+	struct amdgpu_ualink_wb *wb_cpu;
+	u64 wb_npa;
+	int r;
+
+	peer = &remote->peer[remote_accel_id];
+	if (ring_type == RB_TYPE_REMOTE_INTERRUPT)
+		ring = &peer->interrupt;
+	else if (ring_type == RB_TYPE_TLB_INV)
+		ring = &peer->shootdown;
+	else
+		return -EINVAL;
+
+	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &wb_cpu, &wb_npa,
+				  ring_type);
+
+	r = amdgpu_ualink_send_command(adev, remote_accel_id, ring, wb_cpu,
+				       amdgpu_ualink_emit_update_wb_addr,
+				       upper_32_bits(wb_npa),
+				       lower_32_bits(wb_npa),
+				       0, 0);
+	if (!r) {
+		ring->wb_cpu = wb_cpu;
+		ring->ready = true;
+	}
+	return r;
+}
+
-- 
2.55.0

