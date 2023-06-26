Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB86EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 14:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F8C10E21C;
	Mon, 26 Jun 2023 14:51:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DCC910E219
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 14:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyvXoi7I3MgIUr1m2JYM5rIceBsMgpINELY9L51KV3wShTar/i65ioM/vzgLs0o5yPpffos6bbSw22khBfoMdrE2jLvgW/Tmct7uT4XwifFeKMcPNOQpcDvNraz/yAJYx1TYK2VOqFs93l3TcVMjxNHc5udbptLLVuFxcqOz22vHBQbnv0rMjuQOQSUDElHbwhNlkXUUiTpBiPCZPAfeuNdsH8zF0TOoJS5ofBeoFqWMVTOmFGPgvNg2qUwYn6jirJ3xSO95XNZnpGhrxUGc3GjgjvO2cf8J6H5muwzyO/kV3hdNeB5g2R59b/Li5gp6qx7SVhzBvPj5gzXyFQooOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAIx+CAKn3jgd6YcVBwT4LgekBQjxM6e1r1RZeU2kj4=;
 b=CbqtqjfZW4wm2p1vF5+FR6Jql1CTC+dOF/01lNmNJZM5GCXgUdODotsokOS9Qj0vjaEr2dp5CgRUHBox7Cd1R+hyb3h4NYkfKqTAVVNpW3IoL078SICVtj1GmJTgbj6/wICE+kw4XGExKnuPMw8ZRxIWkEGyblCrRrfg/kVrSRCx92rKpgIBHNsGip0woFTFpsHVtswRpDMIlBnheu9ckXZalgAD2eYnZl4I74OrsSAcJ+HDZE0ateTvTa1ovfZp/wM3AVso6zCnaA7cHJlxpA/0tw1UkxLBPYzC0JIfNYRy9uDiup5D8iWxpIV9uqf+bWj9PlU0ppedwkChZ1ZJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAIx+CAKn3jgd6YcVBwT4LgekBQjxM6e1r1RZeU2kj4=;
 b=RWC375sQ7HEsW7DG6biYG5YBl2x0nkRuMTJH29DfWVMnIixs9zoYr2zSKBP96KcSowQGCx5GdDwVxOI8pFpQIH4etDC/5c754TniVUjLG5OoxB8DXjudHqJMn2sQwoV0H22yNrv6yk0BB/z3yyS70SCfdGF5fhwQKf6/I7PzY2g=
Received: from MW4PR03CA0102.namprd03.prod.outlook.com (2603:10b6:303:b7::17)
 by BN9PR12MB5382.namprd12.prod.outlook.com (2603:10b6:408:103::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 14:51:36 +0000
Received: from CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::d8) by MW4PR03CA0102.outlook.office365.com
 (2603:10b6:303:b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Mon, 26 Jun 2023 14:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT073.mail.protection.outlook.com (10.13.174.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 14:51:35 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 26 Jun 2023 09:51:33 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <leo.liu@amd.com>, <veerabadhran.gopalakrishnan@amd.com>,
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/2] drm/amdgpu:update kernel vcn ring test
Date: Mon, 26 Jun 2023 20:20:59 +0530
Message-ID: <20230626145059.2238696-2-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626145059.2238696-1-saleemkhan.jamadar@amd.com>
References: <20230626145059.2238696-1-saleemkhan.jamadar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|BN9PR12MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e56738-007e-4d37-5e5f-08db7654d6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XASKDbeGdiB9BAh+i1gHjoTvwZ548txHyBJt4HuRE6tL9QUWtVp3x2l2ylfxaTKe845O/l4lrJd+tGZiEF3zS9jgcm2Rgv+Y6mHPvo7utiQp9QO/Eeif8sub+Z5HZfxg9jkEt8tLfZyY1Anl81uZMdLHexI/FJ976BxIKzg8jSbvZDfwJWGI2psOvd3D5cNqHFoQgOdT8jqRrYtCbfjl/BOAM30Vty+uqa5AvMMDc3dIL+c81SeH8ANFOlfmFwjLWd7V7EbfUaAPLlAminAiKPTweyGamAq6LOA1prJvWIkL3AvX1iCuCgqOgjiTUsfhpS+oGgkGH4i36UAgY03ykmsO5C4FJzSpgH11MIj/hG3AoUaa9hvZHBcApopOPXOQbdjk0YkyjT+Mc/LOXfDxs0t0kvhtfANVxaleNTTEVO6RzZba/FhU95yQsvEjMiwGEr8suG2EnJ5jLrKKLhPs+f6hRtr/+qIhruuzoy4rW9FWESZSK9PycjEO/pM2THpkEan8+hgMatcZKPQFnj7UETFYOtZMmUl5yUerIvOyQN/vxGm9v0y+jE5LNEm9a3Vp0ZvCtWIjfkVQ+MQRNwoKoSxLSkOHxCm+McFEJ4Pw2NPOv4g1uuLkOFWHlatQrPOu4qNTxgPREXd4dxB6jcMZO/1My9op86G9B66ZU7j/AFvwJKY3uGRrtVjtZLW2iHFS5mf+1w+oNtWhE+Rf/Ly2apWgljI6V2x1A1GRFaZAdF9llghcPYzVab/k4qoKbo7g3aKt8niXDZYiJMmoFjR0hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(36860700001)(47076005)(6666004)(2616005)(7696005)(83380400001)(336012)(426003)(110136005)(26005)(1076003)(186003)(16526019)(2906002)(478600001)(5660300002)(356005)(44832011)(36756003)(40460700003)(70206006)(81166007)(70586007)(82740400003)(40480700001)(4326008)(316002)(6636002)(8936002)(8676002)(41300700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 14:51:35.7688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e56738-007e-4d37-5e5f-08db7654d6fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5382
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
Cc: srinath.rao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add session context buffer to decoder ring test fro vcn v1 to v3.

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 43 ++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 04daaaf6ab34..3e9c023e6c42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -518,9 +518,11 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
 
 static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 				   struct amdgpu_ib *ib_msg,
-				   struct dma_fence **fence)
+				   struct dma_fence **fence,
+				   uint64_t session_ctx_buf_gaddr)
 {
 	u64 addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
+        struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
@@ -534,6 +536,22 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
+	ib->length_dw = 0;
+        ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
+        ib->ptr[ib->length_dw++] = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
+        decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib->ptr[ib->length_dw]);
+        ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
+        memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
+
+        if (session_ctx_buf_gaddr) {
+                decode_buffer->valid_buf_flag |=
+                                        cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER);
+                decode_buffer->session_context_buffer_address_hi =
+                                                        cpu_to_le32(session_ctx_buf_gaddr >> 32);
+                decode_buffer->session_context_buffer_address_lo =
+                                                        cpu_to_le32(session_ctx_buf_gaddr);
+        }
+
 	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
 	ib->ptr[1] = addr;
 	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
@@ -544,7 +562,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		ib->ptr[i] = PACKET0(adev->vcn.internal.nop, 0);
 		ib->ptr[i+1] = 0;
 	}
-	ib->length_dw = 16;
+	ib->length_dw += 16;
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r)
@@ -631,20 +649,34 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
 	struct amdgpu_ib ib;
+	struct amdgpu_bo *session_ctx_buf = NULL;
+        void *cpu_addr = NULL;
+        uint64_t gpu_addr = 0;
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
 
-	r = amdgpu_vcn_dec_send_msg(ring, &ib, NULL);
+	r = amdgpu_vcn_dec_send_msg(ring, &ib, NULL, gpu_addr);
 	if (r)
 		goto error;
 	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_send_msg(ring, &ib, &fence);
+	r = amdgpu_vcn_dec_send_msg(ring, &ib, &fence, gpu_addr);
 	if (r)
 		goto error;
 
@@ -656,6 +688,7 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	dma_fence_put(fence);
 error:
+	amdgpu_bo_free_kernel(&session_ctx_buf, &gpu_addr, &cpu_addr);
 	return r;
 }
 
@@ -692,7 +725,7 @@ static void amdgpu_vcn_unified_ring_ib_checksum(uint32_t **ib_checksum,
 static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 				      struct amdgpu_ib *ib_msg,
 				      struct dma_fence **fence,
-					  uint64_t session_ctx_buf_gaddr)
+				      uint64_t session_ctx_buf_gaddr)
 {
 	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
 	unsigned int ib_size_dw = 64;
-- 
2.25.1

