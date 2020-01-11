Return-Path: <SRS0=NqWJ=3A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C896C282DD
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB03620866
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O/+uCH3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB03620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB8889FF6;
	Sat, 11 Jan 2020 18:39:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7259189DDF
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 18:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOljLXo1YjFecIWbBAK/4h48S8g8fwz9wHkewKo/JP8kIEQn/9GsTYgnx7jkigp2agsfxxyv/BV7JtaIfYgNZFTDolDCJCJweu4Wmy21iGy/frBAtFeNUTOl0mJvtMS30TtMJqsqdZxaaZ+uDcalkCGU6bNC/QS78VM+45ai+U7vifogz1c0ZwSUWM/kVM1rZyGMRXfqKspj09UfSvfU9XcnE+fsyDVr3tKfl5KvTMGJbKOBVjHk08z6Z22c2OF2utUCmRxq1APjTUOMZi7rQvmhtqI4IkinH8Tc7IUZ9jKEO9GNLpI/5UFNFEhkYSv4dRDZRbO5IFWvqbelOg+UMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXHcubMwRMJGJSDNWLgsq10LFJakmDOWxu2bNybq6/Y=;
 b=F0so8xj2UPcBKp86THtaytDHYq028nlsQDO/1gJiRrz3WhwEuFeT20spLlzfzPX5cKPR7H3sXIyHB/3YgKDoX+upS1cS991m0tE0x++Bau/0r+8tRO6sh0MtinN+r2CO5lmHmnt1S+/9VYtVC7EWytxje26uj+t+TlFVWFHnIbKWSA4RvL6JJXuNn9BDQrDnXBSCSX6PoWYCQ5jnUygu1QK4LbGgTEgWU7O41mDT9ANTNm1R5QIikKRC16s/S1OiqByeuawMDRUKK3lkkxCcm9DJpYs/oD5XkpWneG7KdJUGntTjAYQCIgWdpWG0D9aTFVXnESq6Umxy/TICsj2Qnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXHcubMwRMJGJSDNWLgsq10LFJakmDOWxu2bNybq6/Y=;
 b=O/+uCH3BhQrgFaI3kSZ52J3jz3V9r1A9czU6cC9juBuOjq4dhR+44j/o5xXaBigc9xGNV1lxwQkFr/AJdhLkOrKRBeufhzw8SW0zmCeTy2Qhj9If2O9+KxuWF0pV98LIIk6+FgT0G1K9yvWUNGJg6boUcQs+TwKUYbxg9fUgwKA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.104.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Sat, 11 Jan 2020 18:39:53 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.014; Sat, 11 Jan 2020
 18:39:53 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm/amdgpu: kiq pm4 function implementation for gfx_v9
Date: Sat, 11 Jan 2020 12:39:33 -0600
Message-Id: <20200111183938.126310-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200111183938.126310-1-alex.sierra@amd.com>
References: <20200111183938.126310-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN6PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:805:ca::31) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR16CA0054.namprd16.prod.outlook.com (2603:10b6:805:ca::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13 via Frontend Transport; Sat, 11 Jan 2020 18:39:52 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c469e55-621c-4486-018c-08d796c5a54d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:|SN6PR12MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2814A171D7E59012BF5CC949FD3B0@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 0279B3DD0D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(66476007)(26005)(66556008)(66946007)(16526019)(186003)(7696005)(52116002)(6916009)(86362001)(478600001)(4326008)(36756003)(5660300002)(6486002)(8676002)(316002)(6666004)(956004)(8936002)(2906002)(81166006)(81156014)(1076003)(44832011)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2814;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: peFUB0xin8IyqilvvZg0G1MDcsBLKSgy0xnN108+/SfXZSus4EHQBaZOBVWkzyZLU1pthUcK/i1DdIhfWYd4I3bxbX2lZIir+zhL2NmljHtrV4LGfGp8puJDBs2d6wXOcJl4XZ46LC093LoHRF3SKguGv2AwDcI5VoFMTkxG4UaHlHog3hgiB96jP89u7XoNof8FgWozXBTLk81CpC9V/PmuvVGP/g9SIfPuGKLvXnAqiZryA6VAMkjeVYRTEOJ2+0vntRDzvexbY9B16mGm4BwRQln+41NFmooAD5tRCzqVLd4M9HVxiiIsZKiGmqGndxMMuEJit754Gu6VCnlkTxP9n4R/YDnKZebOJyv+QB0gt0H8EHsnAB3JIyIxvJsoQNHNuqaNrtAtWUs3lXqBbVfYkFmLZjPODg/D8s/Y/H8zWywPz0vm2vUeha6uRS6E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c469e55-621c-4486-018c-08d796c5a54d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2020 18:39:52.6283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCLsea22JND18AlN4B4BVpsrnZzXQIOt+r1iqCdoZv/W11ULCg6gAYw75UmyQAT8v7+WW0pVrotkV6eR2ZxALw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
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
index e3d466bd5c4e..ad0179ea2cc5 100644
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
@@ -4260,6 +4374,7 @@ static int gfx_v9_0_early_init(void *handle)
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
