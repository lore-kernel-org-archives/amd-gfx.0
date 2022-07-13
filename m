Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEEAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 16:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430519B9EC;
	Wed, 13 Jul 2022 16:01:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE6FF9B9E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 16:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkSo8LR6R6VAVjhZ0NycPLBgK419sqEV5Kg9KlQqxUQ1H5sV7M6M/sz1K19gCczc/H3a/YzUwIU1Hm1+OwOq7JDjQp1ycxEFbKNcHDoJfDepHutuJLteHJn7s4DdD5EP6Zt7IdfQ9y3nbKc8Wl6kd/7YWwBak9f/6gmNCsqn0mMCdrkNLwIf/FQImS1uRDcbdJxS5AdvsTR/J3Hu4gQdYs4Y35bOzKPqr305A2iSX9KezWCqXEDMJ1eT/pT50bqk//4iGdDcqKHMok5DY45UiCs0lGMwxBgEOrxklOuLxNGZcnkUJcWR6m+MtwnB0ZWvr+Q2LeHfU9NWL2FLHPZ/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbynR0tebidZiBQTH8sV5HdjQNJIYhaIVWHLQnR1ptg=;
 b=cwpFiiMJeYxTfRc4X0//aoaTz0sDxaplOjivH1d2ryMHhRcwQyxJ09afWf+ZMvv9+6jZ2m5ClJ6bYuvHVAmBzeThYeZ5H2yjvTA0EOHzuy8rhS8vkuH2d6aBuQnXmN/QGCINnXFdEut1l5NsQ9pdnazzivgkdd2IfxRYC2Ztp1rS2fo6txAKGcTG1W0eHpaF+TFBtkAA697yKeVsoqLcR2/3TaKXLOI/g90kDNd5Te3NFh/BLcuHFj86C/A/enfXvpqzrcRG7Ac63hJhsdIF9zxnnRRPdYOD9ehfzsE9E6UKAl2u0fz3rX0p5RdR1nrNi6SvcpVgRKxQyyHbVQYcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbynR0tebidZiBQTH8sV5HdjQNJIYhaIVWHLQnR1ptg=;
 b=ZOXXbs4M/9X9hkxZ0O81E6nQgcEpwhS9946+1EZ7rbZ42bCYsNQNSjAGZMSmOUXByrIyh3bGI0EUczFMjErTJZqeQsdoBbCggcPYp+p4qGZ3ZnjN7c+CyrBuZYCOZf7kT65BYWOd+0S8EmoaMQYsXfOASrg1xPJn49UAzq0Bkvg=
Received: from BN9P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::9)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 16:01:13 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::6d) by BN9P222CA0004.outlook.office365.com
 (2603:10b6:408:10c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Wed, 13 Jul 2022 16:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 16:01:12 +0000
Received: from sonny-TP67XE.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 11:00:20 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: limiting AV1 to first instance on VCN4 decode
Date: Wed, 13 Jul 2022 11:59:55 -0400
Message-ID: <20220713155955.4328-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55d403d5-1cb6-47c9-cb1c-08da64e8e8ce
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZMGAY+2KysnEzqDNB4PsJQ/H30yMjpM/OniD6grtqFixHcuoKIYC4yCE5E6OiEKZhdzbN5ff5X2sDMO0yT5HzT1OZfphqSD2MenluNzrbwmFplAjOSH5oxVKnafcwAEfqfcx9Anldsdn0ZimWxkOqNuff77HhCYcOGxqne7SgmNXj7npNBqDmSrTiGa7bNimGoZqI4466CZVcM62SH4gOLHlnJrRSUxec8jFB4tLnbe/gj8P+l6ZozV7BD8zBHVwlVUUgRpBp5RzP5VndjEpxtjP03jv1FUdNBikFgkc+LHZSqFfyII7nIZC5MoMPHyfhMNOOq2FimumDvPOhb7yDdUCTfuA08KRWPTtqbF4ltodDntBzlmvyhuK1RM0VtfDw7CKA8MTpfd4tz1/H4rmIyMizaMmDbGOvwnqhfqgiq0O6mwiPZBpwS4LhKpPTq2Dr2yYfcH0u94+fP0NrCsfSNFm+jwn50HBoJBU8OS5IM4r7B+RNdekj0k2X7fe5cbevyhX+wbSZTKGptgAfqzRaX4RcpRvqNdT8kEVewrvRGr/rXny/Bs4mW3shzrV5gkUo60cuxfh+GmRGdt0M7CMdJwybmc7r/Ux71BudbykjE1ApMt57D962dDOkMCVR+IDbX6uKYCvgGqjQEsL6CZTX43QzAf8CtLqySicP5uLPuBxTuHwi4B/atVRO8V8wxnh85n7JZecbHhBgskKsSnOmqA1qdw6uTDag7wqNCgCFJJYNb+TqG+b/IYJpzcVVal7VgOJlygasB5qojNK4pni/NeKYT77fVAa2GqH7ubBD0q3dD7n1JeUsnjVF4g0pgIUVwxdOcv8/Euq1aTpPhD1YQIoB2sc/jzxIhnxts4xz/FRO6gL7aVom/PN/zW8q6Uu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(40470700004)(336012)(7696005)(26005)(5660300002)(6916009)(40460700003)(47076005)(6666004)(8936002)(40480700001)(2906002)(426003)(82310400005)(86362001)(41300700001)(44832011)(478600001)(83380400001)(82740400003)(81166007)(4326008)(8676002)(356005)(70206006)(36860700001)(186003)(1076003)(2616005)(70586007)(16526019)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 16:01:12.6778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d403d5-1cb6-47c9-cb1c-08da64e8e8ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AV1 is only supported on first instance.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 131 ++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 84ac2401895a..a91ffbf902d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -25,6 +25,7 @@
 #include "amdgpu.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
+#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
@@ -44,6 +45,9 @@
 #define VCN_VID_SOC_ADDRESS_2_0							0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0						0x48300
 
+#define RDECODE_MSG_CREATE							0x00000000
+#define RDECODE_MESSAGE_CREATE							0x00000001
+
 static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN,
 	SOC15_IH_CLIENTID_VCN1
@@ -1323,6 +1327,132 @@ static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p)
+{
+	struct drm_gpu_scheduler **scheds;
+
+	/* The create msg must be in the first IB submitted */
+	if (atomic_read(&p->entity->fence_seq))
+		return -EINVAL;
+
+	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
+		[AMDGPU_RING_PRIO_0].sched;
+	drm_sched_entity_modify_sched(p->entity, scheds, 1);
+	return 0;
+}
+
+static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
+{
+	struct ttm_operation_ctx ctx = { false, false };
+	struct amdgpu_bo_va_mapping *map;
+	uint32_t *msg, num_buffers;
+	struct amdgpu_bo *bo;
+	uint64_t start, end;
+	unsigned int i;
+	void *ptr;
+	int r;
+
+	addr &= AMDGPU_GMC_HOLE_MASK;
+	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
+	if (r) {
+		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
+		return r;
+	}
+
+	start = map->start * AMDGPU_GPU_PAGE_SIZE;
+	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
+	if (addr & 0x7) {
+		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
+		return -EINVAL;
+	}
+
+	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	if (r) {
+		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
+		return r;
+	}
+
+	r = amdgpu_bo_kmap(bo, &ptr);
+	if (r) {
+		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
+		return r;
+	}
+
+	msg = ptr + addr - start;
+
+	/* Check length */
+	if (msg[1] > end - addr) {
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (msg[3] != RDECODE_MSG_CREATE)
+		goto out;
+
+	num_buffers = msg[2];
+	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
+		uint32_t offset, size, *create;
+
+		if (msg[0] != RDECODE_MESSAGE_CREATE)
+			continue;
+
+		offset = msg[1];
+		size = msg[2];
+
+		if (offset + size > end) {
+			r = -EINVAL;
+			goto out;
+		}
+
+		create = ptr + addr + offset - start;
+
+		/* H246, HEVC and VP9 can run on any instance */
+		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
+			continue;
+
+		r = vcn_v4_0_limit_sched(p);
+		if (r)
+			goto out;
+	}
+
+out:
+	amdgpu_bo_kunmap(bo);
+	return r;
+}
+
+#define RADEON_VCN_ENGINE_TYPE_DECODE                                 (0x00000003)
+
+static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
+				struct amdgpu_job *job,
+				struct amdgpu_ib *ib)
+{
+	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
+	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
+	uint32_t val;
+	int r = 0;
+
+	/* The first instance can decode anything */
+	if (!ring->me)
+		return r;
+
+	/* unified queue ib header has 8 double words. */
+	if (ib->length_dw < 8)
+		return r;
+
+	val = amdgpu_ib_get_value(ib, 6); //RADEON_VCN_ENGINE_TYPE
+
+	if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
+		decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[10];
+
+		if (decode_buffer->valid_buf_flag  & 0x1)
+			r = vcn_v4_0_dec_msg(p, ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
+						decode_buffer->msg_buffer_address_lo);
+	}
+	return r;
+}
+
 static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_ENC,
 	.align_mask = 0x3f,
@@ -1331,6 +1461,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
 	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
 	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
 	.set_wptr = vcn_v4_0_unified_ring_set_wptr,
+	.patch_cs_in_place = vcn_v4_0_ring_patch_cs_in_place,
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-- 
2.36.1

