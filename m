Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B83C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 10:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A132061428
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 10:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A132061428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E926E3EC;
	Thu, 22 Apr 2021 10:50:15 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED5E6E3EC
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 10:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfrYtVLKxsLNBAbYerojp0R1fa+nvLcKIWiYEMgT4U8mVbd+FEJzTplUYH5RNx3FVh2R+W6a2lsy7vQtkkbF3fHHpSdmNMLRV0i/3Om+RiR1xrjSbRtz1+Q794Qh6io/K3jGN6C66Bgafq1/bd4+JvCXKHFNk+t6WToCueQD/eN6plnKpARXRL21xOtfV/eWeU7AII81PR1JrLnBjw47R9kjZ0VJZsnKXXjr9KBkdZG+UrBZ23JYS1OZC/1yam5WMmenOUWRujSpK9xHXxyONredsx50fU/r4sjevPA9ZgWRNFwsvY3QRvGYfbkbFdOqK3mZuadpNM0yygwhaC8kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQuI+X/JS/iBel6bZTrZCsu4kZfmxIytnPuf8IvoNWw=;
 b=FNYyAm6M/kt7RDfLJa+JVZdqPJxzYzgXsxXpC0YlB5Zp4/rmtH5p8HI1a0E6MWPaqWX4Rcpi17GVDcqiL1nuH/lETmgE1NSEiXP6IMFQg1GBwEjbwztFIiyKEqg8LL5OJ55NEpeaZJdHgETCrRCdCgXEcHOGF3SPMnFwj6MFCu+O/YRQjCjspouGp7idR8ARgppt4FAfqWAUyanNkMi0i3LZdB6trB5t3cdzw5nDjVrr9bXAAiGZ/ypBl9TSoSPaEwWhF7slj7G/I3yjMGC+TG8KQpBUO4Qt5ZUuec7FULUvyRhzfYsI6U76WYtXKPVtqP0YH4QGYY2iXs2AdE7LXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQuI+X/JS/iBel6bZTrZCsu4kZfmxIytnPuf8IvoNWw=;
 b=JLG1ZvukuIRhD9TWh2FB5ACvOhCTM3BJ6QJ78bKCXIKy/s/Rnpf5xqPuBUSHUL5QdnjcFWq1bP2aykKSvtxToosMlZp4Jd6pzerzPdm3zbpBpkRVPDvk50pgU8TP9F+lxHh9+loOZVaKGOW8vZsMYz780OHsfoCm/sR0F4JivB0=
Received: from MWHPR01CA0033.prod.exchangelabs.com (2603:10b6:300:101::19) by
 BYAPR12MB4629.namprd12.prod.outlook.com (2603:10b6:a03:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 22 Apr
 2021 10:50:11 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::81) by MWHPR01CA0033.outlook.office365.com
 (2603:10b6:300:101::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 10:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 10:50:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 05:50:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 05:50:10 -0500
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Apr 2021 05:50:09 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <emily.deng@amd.com>
Subject: [PATCH] drm/amdgpu: Add sdma single packet invalidation
Date: Thu, 22 Apr 2021 18:49:50 +0800
Message-ID: <20210422104950.72339-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6c32584-4ffc-45c0-fd50-08d9057c6710
X-MS-TrafficTypeDiagnostic: BYAPR12MB4629:
X-Microsoft-Antispam-PRVS: <BYAPR12MB4629178639D8D72E0AAE5848FA469@BYAPR12MB4629.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2W6nqNDawqSKmxBJTuBbqxsuxqbUQZdViPB9UVcqpR1e/Alf1kbn39c1XIrQoqvoPsGmbH2+8scTQhtOaJimxDltpMN6fkpSzNTvYKUlMrfiT5Fx1lg8L2/cnLkGvnrpK/tHRxufVJiqtI2p8ekwM14p+Se5CKJaNxq7wbRrppUdA6Q3WDZIg+3VbmHffxiuCwqddi+AKKbpKtzg5MPEqWKuG10EDSz4YPrCPXQkeeCtcESPFlbN/cxVM0Am19f78Kps0CbLayGTX07QDCDcenqCpJZWLQfTaGONeW8qEoShK2zj0cHcsiB2GtarqUym3KPAl6JgHmwK2cv7bOc6ZY0ToG/7zmrGTQexUHYFWh0gkM5FhRSRUb2CIC8/kq8QlpH20lg4aV5GmwF3uuCwDAoN/wVG8qPd66aI43w8iTF5WmvKeVCnAgpN0qYEHnFDGCvc+xQUz9Q8E4qDns4BLFSNOX1mRo6pwFpFOXyg64LxMiSijBmTVmEwiLuJMzKh9dhX7QuogyHlH/YdI955UgDpZpcrd+HiPGGHGRK/23WSJnAi3Szimwih6r6e/MpyTXg+qv6SCo3O+BwG8NIvGLfXHPXzrPTlfxp5Rh2/F9gdOX1ut5R2sRLxKe+TNJe5Zuhe3hj3ibDUcRcDhJWae3wHQD/4veEXRcdDMkBNfFgtg3yRPepWLkQvfylEWl/H
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(36840700001)(1076003)(356005)(81166007)(82740400003)(316002)(426003)(82310400003)(36860700001)(86362001)(83380400001)(2616005)(2906002)(5660300002)(6666004)(478600001)(336012)(36756003)(47076005)(7696005)(8676002)(8936002)(186003)(26005)(4326008)(70586007)(110136005)(70206006)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 10:50:11.1246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c32584-4ffc-45c0-fd50-08d9057c6710
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4629
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
Cc: Victor Zhao <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add sdma single packet invalidation

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 14 +++++++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 12 ++++++++++++
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c39ed9eb0987..b2cf0e00ce38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -435,13 +435,13 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 
 	/*
 	 * The latest engine allocation on gfx9/10 is:
-	 * Engine 2, 3: firmware
-	 * Engine 0, 1, 4~16: amdgpu ring,
+	 * Engine 1, 2, 3, 4: firmware
+	 * Engine 0, 5~16: amdgpu ring,
 	 *                    subject to change when ring number changes
 	 * Engine 17: Gart flushes
 	 */
-#define GFXHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
-#define MMHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
+#define GFXHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFE1
+#define MMHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFE1
 
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index ca1622835296..fb3de16321ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -192,6 +192,9 @@ struct amdgpu_ring_funcs {
 	void (*emit_reg_write_reg_wait)(struct amdgpu_ring *ring,
 					uint32_t reg0, uint32_t reg1,
 					uint32_t ref, uint32_t mask);
+	void (*vm_invalidate)(struct amdgpu_ring *ring,
+				uint32_t reg0, uint32_t reg1,
+				uint32_t req, uint32_t mask, uint32_t hub);
 	void (*emit_frame_cntl)(struct amdgpu_ring *ring, bool start,
 				bool secure);
 	/* Try to soft recover the ring to make the fence signal */
@@ -270,6 +273,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_emit_wreg(r, d, v) (r)->funcs->emit_wreg((r), (d), (v))
 #define amdgpu_ring_emit_reg_wait(r, d, v, m) (r)->funcs->emit_reg_wait((r), (d), (v), (m))
 #define amdgpu_ring_emit_reg_write_reg_wait(r, d0, d1, v, m) (r)->funcs->emit_reg_write_reg_wait((r), (d0), (d1), (v), (m))
+#define amdgpu_ring_vm_invalidate(r, d0, d1, v, m, h) ((r)->funcs->vm_invalidate((r), (d0), (d1), (v), (m), (h)))
 #define amdgpu_ring_emit_frame_cntl(r, b, s) (r)->funcs->emit_frame_cntl((r), (b), (s))
 #define amdgpu_ring_pad_ib(r, ib) ((r)->funcs->pad_ib((r), (ib)))
 #define amdgpu_ring_init_cond_exec(r) (r)->funcs->init_cond_exec((r))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 498b28a35f5b..0fdf60a7c53d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -481,11 +481,15 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 			      (hub->ctx_addr_distance * vmid),
 			      upper_32_bits(pd_addr));
 
-	amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
-					    hub->eng_distance * eng,
-					    hub->vm_inv_eng0_ack +
-					    hub->eng_distance * eng,
-					    req, 1 << vmid);
+	if ((!strcmp("sdma0", ring->name)) || (!strcmp("sdma1", ring->name)))
+		amdgpu_ring_vm_invalidate(ring, 0xffffffff, 0x1f,
+					  req, 1 << vmid, 1 << ring->funcs->vmhub);
+	else
+		amdgpu_ring_emit_reg_write_reg_wait(ring, hub->vm_inv_eng0_req +
+						    hub->eng_distance * eng,
+						    hub->vm_inv_eng0_ack +
+						    hub->eng_distance * eng,
+						    req, 1 << vmid);
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
 	if (use_semaphore)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 920fc6d4a127..fd7df9194f05 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1219,6 +1219,17 @@ static void sdma_v5_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 	amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
 }
 
+static void sdma_v5_0_ring_vm_invalidate(struct amdgpu_ring *ring,
+		uint32_t reg0, uint32_t reg1,
+		uint32_t req, uint32_t mask, uint32_t hub)
+{
+	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+			SDMA_PKT_POLL_REGMEM_HEADER_SUB_OP(4));
+	amdgpu_ring_write(ring, req);
+	amdgpu_ring_write(ring, reg0);
+	amdgpu_ring_write(ring, ((reg1 & 0x1f) << 16) | (mask & 0xffff) | (hub << 21)); /* reference */
+}
+
 static int sdma_v5_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1654,6 +1665,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.emit_wreg = sdma_v5_0_ring_emit_wreg,
 	.emit_reg_wait = sdma_v5_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = sdma_v5_0_ring_emit_reg_write_reg_wait,
+	.vm_invalidate = sdma_v5_0_ring_vm_invalidate,
 	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
 	.patch_cond_exec = sdma_v5_0_ring_patch_cond_exec,
 	.preempt_ib = sdma_v5_0_ring_preempt_ib,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
