Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F37C7EE43
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BDE10E5DC;
	Thu, 24 Aug 2023 21:53:24 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A9210E5CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgXWJxO4T/mI/+hz8i1mosXlI8LhEdZFkZWplqkQrfzEf1VK7u8S9nf8TzukQ1HOF3CkaqpLqge9yh31alqBVpIJe4SOeN5HzJoU08c5LE7cx1q2uFZAp27Awp8fVD5qCIt7LghvWf559eKZhiUCefSNMepKTUC2NXX1y3smk/mrrnmvcqIduplnUAqJGxUWJXoTJ8lrIAfhEgVl9qt0HgZ+tLkHOy5DoKBoXP0Vsb0RQtEHn0hJnFPXKQ7XGnssSqnLoPkTEi/MiAO1RVXwOifR3iHI4HBjylRsANbmxhP2iu9W3zfurDV8+KwnXMwRg78SO4fliORvEnNw73FUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+vfKP+hEmZM4FEbD/uYmNArfRqfDJyCJU9vQ88qlwc=;
 b=k0H7bxxdzX8PeJ5UOLQ0vUvQORr2mJ6RGI/4ckZ7FMkzgLRQh+fDWizSdTxQ1Cy/i4VqbNx8N4/vMu0UP3Hgqv+h22t2Mqe8M1qUKHFMeX+lDKOQA8WyCutGqp0tZ+4G+tgohrx25vCyvyDSK34v+cP2j3iclPJWJuxm2T+VNUet+dJLSMVLPaH8VL0eSQngYjmkxPjWQJykn78Hw5MNWi0KrutcLiULDNNhEDCDroRlOU+PXu6VCnn1pe7qKGOJzUz9kehevFifK+0sKmfGW/1ShgUkAtnsh3fdB4ucX2akSjH0kfKV06HpnUtph/qs6eRk0bKzkp4lJ7f2Q1OEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+vfKP+hEmZM4FEbD/uYmNArfRqfDJyCJU9vQ88qlwc=;
 b=KQQ1A+2t57hn7iClNdKQuosGJb60+LRhEkDubccJU/VPNm8/fZK9hek4GfxJhtc2sWRYr+fAKKnba+riCX5KJx8yQnEduLjj4L7HSmZ9DGurFEpPTohWv1iOdmPI2Mq8g3CtIPCdpJDHrYBknO96e8VvbuodtDRvPT+dtCKP/Qw=
Received: from CYXPR02CA0048.namprd02.prod.outlook.com (2603:10b6:930:cc::26)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:53:18 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::bf) by CYXPR02CA0048.outlook.office365.com
 (2603:10b6:930:cc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:53:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:53:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/9] drm/amdgpu:update kernel vcn ring test
Date: Thu, 24 Aug 2023 17:53:00 -0400
Message-ID: <20230824215301.2739707-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215301.2739707-1-alexander.deucher@amd.com>
References: <20230824215301.2739707-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d37b78-54c8-439d-4656-08dba4ec86ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3e9xVqnGLO2gJXiXjcbpaLZgzvCPwxTfLqp80Rt5EsPBprbUKBwyB2LO4rCBanQbdup5JKZ1DUrrFoC0z1ysAVzw6mSUSGfH8ZDmR2+/wEy4H738yk+H+W+HFoIVEX2OMZFQpMJ4bK3YEMSAdUXrEhz774Qcok+LBaKBCF/gw/pD0H5nroAENSxLhNPORT/KEZXly5+EjXCk8+OVHkZNSx1z8qjlPk7Mc3fpm+8p1qu3LxekCxNSaIDf+5A9Ytvd7S/PSzbQ6zYRILyI/D8WJ34GHYVjMeB9HkBEAkNUoteUNzTMwotk2lIkPBSOsnVVJUyqWodAYKo6pT0yxO51v7Sanabh5YSj6Mb6OWZZTE/O8nr3vsfGBassZZy6pBzB8iLtBTpJSuN8APMXqH8u0xXPaNbiXHn1zoHVSmt9EManewiNYpkoai3jv8tn33PBwp6ltNikMM2CT7p+5vYrezfC+NFzHkPmsCrLBhUnD4lsD1TRrt6Zcv2g35922XgQ2vwccZNkWc0S7vgAa4QecbsbIw/QB2Q7wtf8rLewDU5l3NMi9Zs6kvvF8qOijC3E29vzoyzyHkfqtsxHGtFBdVlmPYMSf35dH72M7FzbODp7I+BdihQoE//WRhggwtpzu2FzFSwqSjI0CoLEI6Xea4eHTtWB8VDEH9h9ydUQ9oKWChfDzOTq7sSZZvNd5ythGJVgwsBKXnEl7fyA106xcYp61aRmnwd4F9z292woQWrT3wmeCo1Y+wiL2jlny/0pZgQ4OQ9kRTtZIQEldqlSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(70206006)(70586007)(316002)(6916009)(81166007)(478600001)(40480700001)(16526019)(26005)(6666004)(82740400003)(41300700001)(7696005)(86362001)(2906002)(356005)(4326008)(8676002)(8936002)(83380400001)(2616005)(40460700003)(5660300002)(47076005)(1076003)(426003)(336012)(36756003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:53:18.4831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d37b78-54c8-439d-4656-08dba4ec86ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

add session context buffer to decoder ring test.

v2 - put the buffer at the end of the IB (Christian)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 30 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index f5793ec4b7c4..b30616b747b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -693,7 +693,8 @@ static void amdgpu_vcn_unified_ring_ib_checksum(uint32_t **ib_checksum,
 
 static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 				      struct amdgpu_ib *ib_msg,
-				      struct dma_fence **fence)
+				      struct dma_fence **fence,
+					  uint64_t session_ctx_buf_gaddr)
 {
 	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
 	unsigned int ib_size_dw = 64;
@@ -732,6 +733,14 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
 	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
 
+	if (session_ctx_buf_gaddr) {
+		decode_buffer->valid_buf_flag |=
+					cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER);
+		decode_buffer->session_context_buffer_address_hi =
+							cpu_to_le32(session_ctx_buf_gaddr >> 32);
+		decode_buffer->session_context_buffer_address_lo =
+							cpu_to_le32(session_ctx_buf_gaddr);
+	}
 	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
 	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
 	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
@@ -765,20 +774,34 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
 	struct amdgpu_ib ib;
+	struct amdgpu_bo *session_ctx_buf = NULL;
+	void *cpu_addr = NULL;
+	uint64_t gpu_addr = 0;
 	long r;
 
+	r = amdgpu_bo_create_kernel(ring->adev, 128*1024, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM |
+				    AMDGPU_GEM_DOMAIN_GTT,
+				    &session_ctx_buf,
+				    &gpu_addr,
+				    &cpu_addr);
+	if (r) {
+		dev_err(ring->adev->dev, "VCN ib test:%ld failed to allocate session ctx bo\n", r);
+		return r;
+	}
+
 	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL);
+	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL, gpu_addr);
 	if (r)
 		goto error;
 	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence);
+	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence, gpu_addr);
 	if (r)
 		goto error;
 
@@ -790,6 +813,7 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	dma_fence_put(fence);
 error:
+	amdgpu_bo_free_kernel(&session_ctx_buf, &gpu_addr, &cpu_addr);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index a3eed90b6af0..22b0f5e797c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -172,6 +172,7 @@
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
+#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER	0x00100000
 
 #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
 #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
@@ -375,6 +376,8 @@ struct amdgpu_vcn_decode_buffer {
 	uint32_t valid_buf_flag;
 	uint32_t msg_buffer_address_hi;
 	uint32_t msg_buffer_address_lo;
+	unsigned int session_context_buffer_address_hi;
+	unsigned int session_context_buffer_address_lo;
 	uint32_t pad[30];
 };
 
-- 
2.41.0

