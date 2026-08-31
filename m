Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9FEC624D5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F8C10EA76;
	Mon, 31 Aug 2026 18:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JTWrVWem";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F41F10E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1AMkTqz/kuWWYLceogikkKaJ8lx+wNM6BfnpQF31EcL3nPY7lMBRVajOH60NeumTeUFokP3Zie5aJi9peVYMKpFtKF6mQOZsnAyD29bMaWMAaG4uD2VNIz7cofljU8E6++zPNPkLzCO0lgWZZ84jRmFsbU/Gi+Ng0jPL1GVaeLesd4KjXIx27GXsAQPxf0LR1V1XFx89r1tVh3xFHY3gxE2N0A4HAGIiCQbGVbB/Djr9PjfSgTN0Ol+5w4Vy0rwdYue8B8HOTHKl+IOx7rC6+1ecCW1TF6m0zvMnQO9r473qx+c3inP4PhlB/GQz5e3tRFF7txCgHFM7HOTFI67yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGJCKDRzwzePUKl06cd3bW3shDjHC1glm2b22NxHLIU=;
 b=jMpLgrgkXBMDXG9B2KZAAoYS/gjo+Dli0hvRnOeivkMPAHN0T2+9Du4ub1AfSZfFMRzEYyG4P5J36KpiFjVscrYvM6TeyfQf7upyLHRbeie0pA6AJi9O6FAAqTQNFAV4zOiy9oZMsYQeWhQz8m2eB3Mo/SM4Ga5s8Qkw0cVs6ou7esnUYdQQ0Uw8c9ebKZKFJSuZmphMIN9J5CFED1DGr+RQIAsl2eEoTShv9bVCGa279yJvNYMYg3QD3NhpaNqmew0+JqDbwtgQUKaH4EfN9xy/FfJpOBuLwqDgzO3zC/rYYfsTS0HipoUeqmvfzLR1tFih/0mWPE96HK+3f9YVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGJCKDRzwzePUKl06cd3bW3shDjHC1glm2b22NxHLIU=;
 b=JTWrVWem2iARKtwSooXGWzenoUvejOjLEDdQtocrWSt1HTPvticSIk6Ffc1lc+YTwCqIGYt04pLhllwrYj56BDdB9XGCXnLmKMYsFBxeqJmi+3s7dsMx0OMI3aAGmVR5MehfQ6DydOx7IfpiCKbzwmjp/1mvlWVBF6ngAG8pu7U=
Received: from CH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::11)
 by CH9PR12MB384484.namprd12.prod.outlook.com (2603:10b6:610:310::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:43 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::20) by CH5P220CA0009.outlook.office365.com
 (2603:10b6:610:1ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:31 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 39/95] drm/amdgpu: Add UALink firmware writeback address
 configuration
Date: Mon, 31 Aug 2026 14:26:58 -0400
Message-ID: <20260831182754.1089811-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|CH9PR12MB384484:EE_
X-MS-Office365-Filtering-Correlation-Id: acac8e9f-a18e-4331-da94-08df078dafe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: RjuAuMCz7BdSooA6KzoGAQYbTSU1K3Fbn8vkdC3ksMusErvPyLtss6Xvv190w7PW4yO96+ImpexshWnmz/VD2aXUwE0nk2O3xReGraTuKZseRYlXPSN1r+6Av8EqiHzS51t6FD2gVzX0TWYuxsegpB8pQvHG3yOahx3nLjvlB+d0uFerLEOQvG5MidyKqzmu0Ep0vCAOyocqhxSph5QHNu3jwT8JuGT71SgSnh8JVSYoGV1+XnBg6YjMDTeaFC6bINY5RVjSh4ntSmshGEsVGCgxdYtgTgjn9TnFTOPzSDXIyUwgNxtHAxYornG3twf1PJ84PWmCMJbF34ejw/gudfzbnkU2O7Okx7Off/Srh8KlMSth8z79mVgohUKAiYQx8bE15gMJ6pjPVbBB+4P8beyW95m9jNT96dJ8ei51D3wAurMzHFk8eOxRFh4+xG+VUPN9jlGfu0o7BAM0PkJ83FPBeB0c3yfn8rAtQg490Vv5e9KPqha6cQaX1lbat8iE/bJJpzaDFNZvijI8rAngSos/FiG6fd2OVLxRuoBD74uKZvh3c//GuuKAdwXLCNtznHs0/y6Ir1TTrQq1z6CWm5384oNZ3743mYfarsEnEou5GJ7y1BLahJNRLSqqzVx0IerubeYqtaYqufyDnGi3fKQNgrajlcZvmt+ZltjKDiQwj+PBGtvslBSgPu8ubFleW1yKEBEsd/VbBFAb4ijp+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kFzWDv38yiuXGDla176fc9kWuWpsy3ckZjuiLX3NzAt53N4dV6jQqatkrA1KIVI9gx1gsXLZOYn33zJlrEQvvNu+oP9/jjFmWRpdvh/Vrd7VgGYcuzFIGPnT1wAvcgRNo81aDf4ks6MlxrGPQPCEuVeM4MChLi2kI0uNcgmsHrH5XNbGHy1w+bkZe4Dj1CVOgfnaisKnM7wbJKqt0T7afv7d2T4hn/9WlvP3nnjdP9fVl5e2pl7rUGbY+gSBqoJHyxbDq9iQ5rIKWsvzULwvWu3wobYsPbLnqgaRNdeRvxFQ/EbIWW7LdllJGruYy3cqsBx8b598v8dHV9v6noVvrZPtjCEo0BTMkkFXGV9vQ29Pk21mGH6C1j2KUQXuruIVa0elhkGkOcabx2ETpGHrYNYSJDxXRjNp9hpadt+bXhn97VDKwI1HOWxBsv3f4t2d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:43.2519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acac8e9f-a18e-4331-da94-08df078dafe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB384484
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
index 58bb506785c27..831e8e8e45fbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1338,6 +1338,9 @@ struct amdgpu_ualink_ring {
 	struct drm_mm_node mm_node_wptr;
 	struct drm_mm_node mm_node_doorbell;
 
+	/* seq, complete status write back cpu address */
+	struct amdgpu_ualink_wb *wb_cpu;
+
 	/* true if fw write back address updated successfully */
 	bool ready;
 };
@@ -2699,3 +2702,70 @@ static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
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

