Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84BFC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 04:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 358A610E569;
	Wed, 24 May 2023 04:35:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3998110E569
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 04:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ0KbUrfR/dL/yWzGqwg1OiatmswiMZYQTHdDJjCyb0/B+LnsY3xBIJd6cxZlvsBP4i1tReZq61dvTytqpP3XF3PPnvMgIJZOP1uq3yG226Q76ufQ2OTzAylHfiiuaOpIvZwcpB823nN3wDklPtxHt9ERboLc7dnI5Mi8e2DQdNY5zrebHRNKgqtoZdoHd033bOexzrSWQqrYEV+slaHZ7ls7UTcVqP5Bl5CQKOfc+cVGdRtXQ39bdTvmlvQCZLxdcUh4chpqC1LhRKKX3103ecmqcO9M2aqPlGuX4RGns7MCBom+PZbhvUjKNYKzzOKR0pnO2XIxzuU38rXBWMFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWY6aUb6jKSsUfpTdyEIgjf2wuA+BW1P04ThPxNisM8=;
 b=gLGaPwHzI+5CBPiIDKWdqehJCnBKD43vu3U56nWXduTHn58NvUfFqN4I+bD8GkAPXu/zWcT7QQRq5R36khlJF7p+iDbFQCk3t8ZSbu5iENSF7Sxf6xbsy625hcNWFoou3cP3NrVnpMcSyj+Za0CI/aqx1NzLk48BIN54/mdWtExYmzFPOxocXNhwlOgzoHvnAtGNgqB0z41Ok4+C+lbQlAxMHiV0Iy0VN18apmKhMS3CMpm50l9igLjnM7EtxaByPlqaQBzs6LdejKzfxLDzx5K16VxZaAnsr2XW3iYiFfVKkxrXEsO04MBWKkt9/2EtLezp/Vs6l2pbglLypex3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWY6aUb6jKSsUfpTdyEIgjf2wuA+BW1P04ThPxNisM8=;
 b=K17Sh/YrlbUAi5poJRu9+NorTUsvPeA29335SpvGcuSUAIgVwZSvbWFrCnV3bwf50K1sHtG8m8FhqWab6jUKHLFtZu0m+2L76kW+WV7FhjDij12yzDftH7hPsVYak2Yh2b2KDtJXuBODIPjTvzsQulQlPVokHJhS5GUwZ9HTK7E=
Received: from BN9PR03CA0722.namprd03.prod.outlook.com (2603:10b6:408:110::7)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 04:35:48 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::bc) by BN9PR03CA0722.outlook.office365.com
 (2603:10b6:408:110::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Wed, 24 May 2023 04:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Wed, 24 May 2023 04:35:47 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 23 May 2023 23:35:46 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Reset CP_VMID_PREEMPT after trailing fence
 signaled
Date: Wed, 24 May 2023 12:35:27 +0800
Message-ID: <20230524043527.2807962-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|SJ0PR12MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a547695-1797-4cad-d693-08db5c1058aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1qylK0nNnmgIKCnyI+LJudZ16nCuD9VUwj6e7TJYh0ZqeOM5/QjAUUCpaC0SGrkpfYPtc6zSxeM8K7Zv6vgw8MpDBY5VxLhbzYXBrcdOyySwC77m12l6IJJrnm4L5toh8MiaRTWbUNJgf4E/AYzKgSEqDz9kxCYGxRyg3tvYMM+XvvizfFpmOrj6Sc++ae5ON2Vv1qZC4AmI6/NP9/4/rZWMnKpI9nJ07+hAXB2mCe7tc6nDBoDCxqBKlklxrvURdeYCoN3mVyQMU+d8efiS/D9oRCIhS9zm2fnxjWMV1mXWNLVGw9CL1EVoR26lDWiyZNnMjpP+PVHDU7+pMk5XvrbAwDG7R+MAuIAqr3ZEtCdbSAxzbYYEUr/FtYjNbPxhPk82sGNEPFqoqeyIrF9x9QX2SypSqiU9BZk236H7npD19EvYUCSDLy4r4sEfaSOGN6whJemf1p184fqkhn6Hr2rlz7XpHwDjRU75IWRcACQOkpu3lZPAGSBh40kZoq8zjoBkFXEO2mOT2Sio5UV0X8p0Y/c2pddzMO8G1nnFI02ph6fmHupnkfOD/sl+eoCnA/VWQyudF76aoFAp7r+gSKS9Yh1nYJ1g9jubr60J9zuh+MbwdQGrhykvaYCn/FAgHvu0/hjDL/9oOfJi9l0wwmyTMSuxKNuIk30ye0uS8y6xyisdCWIyhPnvg+tOQd3eL+OmlKlcE7SwjIRhKf7mT+rB7yVoy/pmf+QZx4PI3ckCJpgNXrvdzoLCL35jY1sPWZ8DOaElpXR/bydp0SDwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(356005)(81166007)(186003)(26005)(1076003)(40460700003)(82740400003)(426003)(47076005)(2616005)(36756003)(36860700001)(83380400001)(336012)(16526019)(2906002)(40480700001)(2876002)(7696005)(316002)(41300700001)(6666004)(82310400005)(478600001)(86362001)(70586007)(6916009)(4326008)(70206006)(5660300002)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 04:35:47.9411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a547695-1797-4cad-d693-08db5c1058aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

When MEC executes unmap_queue for mid command buffer preemption, it will
kick the write pointer of the gfx ring, set CP_VMID_PREEMPT to trigger the
preemption and wait for CP_VMID_PREEMPT becomes zero after the preemption
done. There is a race condition that PFP may excute the resetting command
before MEC set CP_VMID_PREEMPT. As a result, hang happens as
CP_VMID_PREEMPT is always 0xffff.

To avoid this, we send resetting CP_VMID_PREEMPT command after the trailing
fence is siganled and update gfx write pointer explicitly.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 8bf95a6b0767..cbdd9918b3e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5402,10 +5402,6 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	amdgpu_ring_alloc(ring, 13);
 	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
 				 ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC | AMDGPU_FENCE_FLAG_INT);
-	/*reset the CP_VMID_PREEMPT after trailing fence*/
-	amdgpu_ring_emit_wreg(ring,
-			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
-			      0x0);
 
 	/* assert IB preemption, emit the trailing fence */
 	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
@@ -5428,6 +5424,10 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
 		DRM_WARN("ring %d timeout to preempt ib\n", ring->idx);
 	}
 
+	/*reset the CP_VMID_PREEMPT after trailing fence*/
+	amdgpu_ring_emit_wreg(ring,
+			      SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
+			      0x0);
 	amdgpu_ring_commit(ring);
 
 	/* deassert preemption condition */
-- 
2.25.1

