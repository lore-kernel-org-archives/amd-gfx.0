Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63DBC33CA1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E35C2075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iBUrWrce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E35C2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA36D6E98B;
	Fri, 10 Jan 2020 00:43:51 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690082.outbound.protection.outlook.com [40.107.69.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC656E985
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 00:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWiGkWVZxNnc0DcZ31fTK402DDDpTO4Z2o8PEstzeYbUEGxwYC/0VZ4eaOLxYXjvu+PAwNAyFRApHdmU7+J8F+kfGEHT0bf26De8RGaHHUSjno5gZKmbl6gGHinnZTZygYzYo/LqB5phAA0DuOPLoPEIevU6/E5cA9HCDhTCVulZGT6c1hYCDc3c49Vor6D/Wv+JXJopynBw1oAH8FeAFifrLYp1yg8u9MXNrD+MrLu7EYAVsuaztA+JCsNMKPVFDzW5+qmf5GUeQe5S+6zDBzFK9GMuxvURdhqt4ZQViPNwBBMkTmpQzvDreLPqCeBTxOMfFjmPz/Lvgd5QUsdBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD2ajlbxBbDmAIZzEqNnJlwIcByGHXa2pUy9sKgMZLo=;
 b=nm0dJR7AMGehBGqW3apYdrtgBfkkOMoC7za0h4GgpPGzQCMO8FN5CfnjcQQZEn/5qSUB3KM0bHNjHRIH+GqGM9B0PxCOQtvtE2ZLQhff/crt6UaY3f85aOd2/uJOzGc6yNdG/obRkZnuUNdLejd4NtPCJqmOBDflPJ/BJSO9X0J9x1C+tF89F1Y06bRbpif8e27GKN/+pBRAacU/RFe1NgZIe9COH9ekd1dWOTrh3qhoNXR1EXTB4znACLoh+xCdAvwwnHhS2ql9gi7vsqjbCp2wA33YSJoOApoHZmY57CiojTi3OsvBn8Iku6HSpV2GGjYl2xjF8jHhRQ6hCLtgdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD2ajlbxBbDmAIZzEqNnJlwIcByGHXa2pUy9sKgMZLo=;
 b=iBUrWrceSezoDLOd/M8Pi9mRb+qTY+pHv0GrIDmJ+VHEtA2Q/Aff4odzLjQLeabs75GFtLAH9ZI81Mw+g2G1/Aa23QtfVDCnFnX8oq4fpv8JYIAnExsCvFUrdbKgTrfpsrp8uLbTsx5MXfHQ/C0o7qXZk6KLmQHvjn8mJPvL0Bk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2672.namprd12.prod.outlook.com (52.135.103.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 00:43:49 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 00:43:49 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu: kiq pm4 function implementation for gfx_v9
Date: Thu,  9 Jan 2020 18:43:32 -0600
Message-Id: <20200110004335.113095-5-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110004335.113095-1-alex.sierra@amd.com>
References: <20200110004335.113095-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:805:106::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.4 via Frontend
 Transport; Fri, 10 Jan 2020 00:43:49 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46f69558-1624-49bd-3dff-08d795662886
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:|SN6PR12MB2672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2672053D4F8CBA86D7736F0CFD380@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(8936002)(26005)(5660300002)(7696005)(316002)(86362001)(1076003)(186003)(2616005)(16526019)(956004)(44832011)(2906002)(36756003)(52116002)(66556008)(478600001)(66476007)(6916009)(6666004)(6486002)(66946007)(4326008)(81156014)(81166006)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2672;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZYgmfFmUM7G6jR019CU/HxtEeAvKPsukU4JP0AVw5N9DQWt+uvkcy7WiYzaWAOnk/iDmdpDQn7p8Dm811td74RL+FTMCBCuxO+yHBGzECQna+JGD58vXLkacU71BJIRLIjB1NH17quK8LIxOrtuqdktjx/GhzwB28dpCO2442G9b0kes0bSKKOmjMRo6Z+9Aq8A0Rp8URrqKN/rf+K6dOGXcPQm1sZGXXyUZIY/eUWIoHlBUV5JCHHogsUuhZaKhee+YLN00QN4y94ztupYGrybYhyQBQ0EPDjyNMBkwWnaimQf9Gm8BbbIoP3xlY9SaihP+jE0IbiS/YrI784mwL0m7qV5rf3ff1Xk5EjHEvDRz2ciXfooaBbrCspDKKfOy8t5xxmcZQwCiq9PXR2DPN9xLMXV/S5WzRp+OtY45v13XkKe7+CLxivcyRDlDnXd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f69558-1624-49bd-3dff-08d795662886
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 00:43:49.8162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXLlfYGYQoqt8t3BvwSaI6iz0g/uDpYjAjK3TmHMxYeGxmBe4PbA/lixdTSBF7iGPz60xfUDGxwgEhmiOQ/r6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Functions implemented from kiq_pm4_funcs struct members
for gfx_v9 version.

Change-Id: I8fd3e160c4bd58f19d35d29e39517db967063afe
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 115 ++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ce2b02dc7b64..d48bfae3e083 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -739,6 +739,120 @@ static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 				     void *inject_if);
 
+static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
+				uint64_t queue_mask)
+{
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
+	amdgpu_ring_write(kiq_ring,
+		PACKET3_SET_RESOURCES_VMID_MASK(0) |
+		/* vmid_mask:0* queue_type:0 (KIQ) */
+		PACKET3_SET_RESOURCES_QUEUE_TYPE(0));
+	amdgpu_ring_write(kiq_ring,
+			lower_32_bits(queue_mask));	/* queue mask lo */
+	amdgpu_ring_write(kiq_ring,
+			upper_32_bits(queue_mask));	/* queue mask hi */
+	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
+	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
+	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
+	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
+}
+
+static void gfx_v9_0_kiq_map_queues(struct amdgpu_ring *kiq_ring,
+				 struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = kiq_ring->adev;
+	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
+	uint64_t wptr_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
+	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
+	/* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
+	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+			 PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
+			 PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
+			 PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
+			 PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
+			 PACKET3_MAP_QUEUES_ME((ring->me == 1 ? 0 : 1)) |
+			 /*queue_type: normal compute queue */
+			 PACKET3_MAP_QUEUES_QUEUE_TYPE(0) |
+			 /* alloc format: all_on_one_pipe */
+			 PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) |
+			 PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
+			 /* num_queues: must be 1 */
+			 PACKET3_MAP_QUEUES_NUM_QUEUES(1));
+	amdgpu_ring_write(kiq_ring,
+			PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
+	amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
+	amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
+	amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
+	amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
+}
+
+static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
+				   struct amdgpu_ring *ring,
+				   enum amdgpu_unmap_queues_action action,
+				   u64 gpu_addr, u64 seq)
+{
+	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
+	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+			  PACKET3_UNMAP_QUEUES_ACTION(action) |
+			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
+			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(eng_sel) |
+			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
+	amdgpu_ring_write(kiq_ring,
+			PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
+
+	if (action == PREEMPT_QUEUES_NO_UNMAP) {
+		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
+		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
+		amdgpu_ring_write(kiq_ring, seq);
+	} else {
+		amdgpu_ring_write(kiq_ring, 0);
+		amdgpu_ring_write(kiq_ring, 0);
+		amdgpu_ring_write(kiq_ring, 0);
+	}
+}
+
+static void gfx_v9_0_kiq_query_status(struct amdgpu_ring *kiq_ring,
+				   struct amdgpu_ring *ring,
+				   u64 addr,
+				   u64 seq)
+{
+	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_QUERY_STATUS, 5));
+	amdgpu_ring_write(kiq_ring,
+			  PACKET3_QUERY_STATUS_CONTEXT_ID(0) |
+			  PACKET3_QUERY_STATUS_INTERRUPT_SEL(0) |
+			  PACKET3_QUERY_STATUS_COMMAND(2));
+	/* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+	amdgpu_ring_write(kiq_ring,
+			PACKET3_QUERY_STATUS_DOORBELL_OFFSET(ring->doorbell_index) |
+			PACKET3_QUERY_STATUS_ENG_SEL(eng_sel));
+	amdgpu_ring_write(kiq_ring, lower_32_bits(addr));
+	amdgpu_ring_write(kiq_ring, upper_32_bits(addr));
+	amdgpu_ring_write(kiq_ring, lower_32_bits(seq));
+	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
+}
+
+static const struct kiq_pm4_funcs gfx_v9_0_kiq_pm4_funcs = {
+	.kiq_set_resources = gfx_v9_0_kiq_set_resources,
+	.kiq_map_queues = gfx_v9_0_kiq_map_queues,
+	.kiq_unmap_queues = gfx_v9_0_kiq_unmap_queues,
+	.kiq_query_status = gfx_v9_0_kiq_query_status,
+	.set_resources_size = 8,
+	.map_queues_size = 7,
+	.unmap_queues_size = 6,
+	.query_status_size = 7,
+};
+
+static void gfx_v9_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.kiq.pmf = &gfx_v9_0_kiq_pm4_funcs;
+}
+
 static void gfx_v9_0_init_golden_registers(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
@@ -4241,6 +4355,7 @@ static int gfx_v9_0_early_init(void *handle)
 	else
 		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
 	adev->gfx.num_compute_rings = AMDGPU_MAX_COMPUTE_RINGS;
+	gfx_v9_0_set_kiq_pm4_funcs(adev);
 	gfx_v9_0_set_ring_funcs(adev);
 	gfx_v9_0_set_irq_funcs(adev);
 	gfx_v9_0_set_gds_init(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
