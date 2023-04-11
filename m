Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24FBC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 07:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9FCC10E114;
	Tue, 11 Apr 2023 07:17:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA46110E114
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 07:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvFrgApzsqVHE6KC+8jL6ekbNyojlW+3czcyULV+d5XfN26bnBqfpEamer/ZaLk30d/yZCNYgVFC5lPbKyCGsVrowPoi/TnvGePW50nwBUccwPM4wBy2MVM3OmvwcRXYtvkOKEu2nVD5Rgtr1ndF0TjijpJvbnbo9qzzaHsQB9td65I+MszTeQC5s//U9bzwaNpaMoEpI0W98NoFD/oFMMOIgvb/zlPW43wgOzgIxb7JDRM7bjsjplwoUuEKG1WVQ4aNt/zm/X4NESbGqRCWF+foX0WlhSp366607t+/kOzryN2bl0eAIffnzII4sFneNlmONAoVIBfI70uSU8KRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SB0cCoym8/2IYKbWXzWj6tec9ShI0i0FSB8cigTQOtk=;
 b=F89a3p1J+4qSUlBdMQ8gAyRn28ISyYEWr3Awg0bwFz9GIliB53rJ5ryzyVnBY8SQxB5+pH7IWYrQamjRAygEyLHhWRzfh33xWyVQBCgWFzTa1rNQCuQIrgLj3xuh1R5VzYbZ3NboiJiDzMjZWvRJcNGsJAMlRkELnD+L5/oa3352GpsAtbooREjo0+kMpF4tQ7JTQkEIg/qz39nknyfn8Ih+u3JrctHqtGr6Al/jjLJ1PsICXDKgljPdpqQUlvcZh0jfNEPHMfmYAzQMgFdBZYKzxC9Tfe1lXd6GM+rgrYBUtAwEvxmnBs/4sgs17pnCbYzIphgsgHT0QmeuTzoEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SB0cCoym8/2IYKbWXzWj6tec9ShI0i0FSB8cigTQOtk=;
 b=3mM8Wh2gOd+EFpnEEfNGEerysdkvyrYD7Vjzvcwz72bqtAAb2h2rms8RX5JU9AdLTCvm4uvCeQ6aoF1bitCqE0zKns3Xk/bSe3EUC7kM15I60s0R5pXtapDo4XM4OTCDeRYY8HJMo/j0PUef+qKVsdbFGY2SeOCSEze5hnrcpIA=
Received: from DS7PR03CA0317.namprd03.prod.outlook.com (2603:10b6:8:2b::20) by
 MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Tue, 11 Apr
 2023 07:17:50 +0000
Received: from DS1PEPF0000B074.namprd05.prod.outlook.com
 (2603:10b6:8:2b:cafe::a6) by DS7PR03CA0317.outlook.office365.com
 (2603:10b6:8:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Tue, 11 Apr 2023 07:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B074.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Tue, 11 Apr 2023 07:17:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 11 Apr
 2023 02:17:49 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 11 Apr 2023 02:17:46 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: use sdma_v6 single packet invalidation
Date: Tue, 11 Apr 2023 15:16:40 +0800
Message-ID: <20230411071638.279795-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B074:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c6985e-a2b9-4483-edde-08db3a5cdb8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stY2adudJYZWWrBXL0oXPV+bOc96ofeShi2Fpv5HIUGspOi4LjMk+TDFYcYdGTt/WYt49P1sOhy3JhLy4YMMRfeuFAA8tYT/SBSQx7uBpu//NSC8XX4nbqyZF4txZ2kelEag3JlJ3PDqupoKB9AsuMgvVLOkGqHjAVu4Lp5G+YyytU1YutKiKn86UdXpnJ7TUwdQ/ofcb4/T9cv2Pc7P8Ol8Jyd32CXPGAH1t2yG7xQnSeaaVD8FObSKFiTSuHaWSCrVscc206M/ZZTDaaFgyQZsf8Fbh16sTp/IIugAp6HW/JxtCsTZwAoY94xUdv6i/YrrJa8x04edkuVmz+kOHnbM9ohMGXnNFfqT+Hb1oGz5nUXeqdbgB1nbFw4xfvi/DecCIIE1/UEJOFu0gXxmAX5g2cE48tjH1x5qXTfLlmwoD0Q6ekxb9akPWnKm6QdHVAlzWK+rd70x28mdwi4jASXDagz0QLjWuBa38CRB+qEUQyp8C74j1fmq3wqI4iLRTkK9VbnlQyscqj6vZJPC9uMs4J8y1hBTE/FKxYA7gHJHveB1OdgSmpyyou5XWR52jkgiYllmtkKrrwdpURvLSeyc6mAnCL4USx/8umbQBWzakSQxHlULftHeIxzvalfhcTEmkhLeqzUXUYLww5oWU3VKULTxtrzmIlwQDnPejz5TQfadoCThw01uM4ySZ2TaNf1dUx0snmF0r5+YppDanytkV8wTrtfxsnIGOPLaodg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(2906002)(356005)(6916009)(40460700003)(5660300002)(4326008)(81166007)(82310400005)(8936002)(41300700001)(70206006)(70586007)(86362001)(426003)(2616005)(336012)(47076005)(82740400003)(36860700001)(83380400001)(26005)(36756003)(1076003)(186003)(6666004)(316002)(8676002)(54906003)(478600001)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 07:17:49.6993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c6985e-a2b9-4483-edde-08db3a5cdb8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B074.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Send this patch on behalf of Pierre-Eric.

This achieves the same result as the sequence used in emit_flush_gpu_tlb
but the invalidation is now a single packet instead of the 3 packets
required to implement reg_write_reg_wait.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 3d36329be384..8d0c8f2cac06 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1175,7 +1175,28 @@ static void sdma_v6_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 static void sdma_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 					 unsigned vmid, uint64_t pd_addr)
 {
-	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+
+	/* Update the PD address for this VMID. */
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
+			      lower_32_bits(pd_addr));
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
+			      upper_32_bits(pd_addr));
+
+	/* Trigger invalidation. */
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(ring->vm_inv_eng) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(0x1f));
+	amdgpu_ring_write(ring, req);
+	amdgpu_ring_write(ring, 0xFFFFFFFF);
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
 }
 
 static void sdma_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
-- 
2.40.0

