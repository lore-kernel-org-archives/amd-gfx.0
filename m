Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865A8EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 14:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C0510E215;
	Mon, 26 Jun 2023 14:51:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED83610E215
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 14:51:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZrTpvgvwpKzRfj5bytbyGDNP7enb8+ScYuBwtSj/k1uqj56jcmSf5kGo9RSfYP8COfzu9TtdJSxR06esNcEcLFCzR7uN4uOnYXnLnmrms05sqyTDAc9/RqHL5aHy81l/eki5nTp6cPFwwn+bBPcOiMU1NF60JDA91S8LQ0/hLKDx3U3hJLDvTwEanhfXvJQHqAk6o63IVj2KL0JwGIPgsTg3b/+EyfLyoLYrQHYT+2quL7QNXsgcQLLtJbkxgWjvIYpEAAZ6pF+2+gox3EVaUpsPjl7XXrbIqG2z8g1W5E3iAlza/1cLjM9yPzHFnulqlflasyyluPLNQ01QCrcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojIrUQ2Lm336kbUX7L+G86LPFazpbB+xtle7eZ4JyP8=;
 b=nSNyMrEVkPANlsD7scOPj1ObfNcA39NdfIn1PD+/zMXPwScaYCLT6DOT85wCyfLkafeXnMPviGwePi/30BG7j/fTyrTxUkWEsZn93KVxoT8FT+S8Y0DGzVzcfJedZLj7sNmEnDjvm9uPPHqwk1FxmGZazaQwPzjHm/uckVDmgNWldDqpnS1JRknI6D6qq9+6qom4bYVzdOjtjhewPY89pXypq7RTK5G0U0T5b92FdaII/JXc++memFPt2nRgh1xiqipzG0hojSwe+OO4oaIBuES8BRa/wcYigzhZSbm3b8VCDf2nJi6A96WJoHzLwCD9TSDq0+oJoWpsrsaD9sJExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojIrUQ2Lm336kbUX7L+G86LPFazpbB+xtle7eZ4JyP8=;
 b=hcPhNXQcu2Qd8kURWTNNm9W+sLAJCg6WZEyBrqbuUbfrdhSnxdmrJw2oJNQ8YD4GWzKJGxFqlmgp/SuEzmZgKhSa4iCL/1mVjz9epOKA7OEGKJ6Co4Wp0qOZcdrxmaWk/YP/1+iH65O8EzVbCcbIaH4oheixLCD0ac2FDCL3U0M=
Received: from MW4PR04CA0067.namprd04.prod.outlook.com (2603:10b6:303:6b::12)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 14:51:20 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::54) by MW4PR04CA0067.outlook.office365.com
 (2603:10b6:303:6b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 14:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 14:51:20 +0000
Received: from x570-ryzen9-5900x.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 26 Jun 2023 09:51:17 -0500
From: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
To: <saleemkhan.jamadar@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <leo.liu@amd.com>, <veerabadhran.gopalakrishnan@amd.com>,
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 1/2] drm/amdgpu:update kernel vcn ring test
Date: Mon, 26 Jun 2023 20:20:58 +0530
Message-ID: <20230626145059.2238696-1-saleemkhan.jamadar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 586a183b-8e56-43b6-2567-08db7654cd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AR8irfvfcTc1vqKjKceN2eI50md8/LRMEBdCVbFmyvQUf41a/g4kFw8ubfTVkURYvYew8kL/yvXSZJcXj/GJ79m4wgHk0PQU+5EbDf4O8SvrV9Kn+1pNg7h7dU1KuFhz3gHXX/LSG7GdeBT6eUL6c2rKyWQt1TRYST1YQp7SQK8mCiBEUikzMxoaXbfCNJ7uL4uVXST8ilBX9sMYeMn7XKJTdFrYx2bMxLDJE6nZC3+QdqAZnZXoc4L4KzFc/gl0SPqf4xysWi7UiL80I2yYj7Bmmo61/7We0+IIgEQpoTXOuOVVPAe+e4cb7tZeyVu0zZG6/aeheoMF+oKtKC4hoRmIHnzGrCvzNAVqVViEcau4Rm8by1e64HboBm7BanITvy4rmbZ8Of+6+A9hute2XVqZhhaqELehReTg0ofxM49RNMMb9mkhdTY0Kd3ETi5oMmrPzsoA9aPdiG/ZOtR5/TvGqKselIKFEPhUV7Six9l+adbNC3+2VxyvHAVXmuNexxfX7NB3zJBzPmzaOdHielKd6sd3GQy9K6LEBl0DaVQi0KW93EUwxlqQrZCLdeynI5lTnO0xVx0ElCX9cC1lqOmj93qSjsniQYoZpuxkMvFa7z6xPWbLlJi6gy23KlrNqG8RgXuXIcOk+ArKBOmiKgbGPRGySLQYK32H8CogPwUQSOxPANbyuMrdH+YTJXYkidexqSTULBW1N68cIYMbbnhqgxiHwQqQ7bFO0YRXpVpIMhz6u9dvrQLDiqohlhr/ZZM6SQSeKRZKhDrnTNh77g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(8676002)(41300700001)(8936002)(2906002)(70586007)(110136005)(478600001)(70206006)(44832011)(5660300002)(316002)(4326008)(6636002)(336012)(426003)(36860700001)(2616005)(83380400001)(47076005)(81166007)(356005)(82740400003)(82310400005)(40460700003)(36756003)(16526019)(40480700001)(6666004)(7696005)(26005)(186003)(1076003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 14:51:20.0191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586a183b-8e56-43b6-2567-08db7654cd99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
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

add session context buffer to decoder ring test.

v2 - put the buffer at the end of the IB (Christian)

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 30 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2d94f1b63bd6..04daaaf6ab34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -691,7 +691,8 @@ static void amdgpu_vcn_unified_ring_ib_checksum(uint32_t **ib_checksum,
 
 static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 				      struct amdgpu_ib *ib_msg,
-				      struct dma_fence **fence)
+				      struct dma_fence **fence,
+					  uint64_t session_ctx_buf_gaddr)
 {
 	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
 	unsigned int ib_size_dw = 64;
@@ -730,6 +731,14 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
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
@@ -763,20 +772,34 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
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
 
@@ -788,6 +811,7 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	dma_fence_put(fence);
 error:
+	amdgpu_bo_free_kernel(&session_ctx_buf, &gpu_addr, &cpu_addr);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f1397ef66fd7..06f9ee91a1e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -166,6 +166,7 @@
 
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
 #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
+#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER	0x00100000
 
 #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
 #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
@@ -357,6 +358,8 @@ struct amdgpu_vcn_decode_buffer {
 	uint32_t valid_buf_flag;
 	uint32_t msg_buffer_address_hi;
 	uint32_t msg_buffer_address_lo;
+	unsigned int session_context_buffer_address_hi;
+	unsigned int session_context_buffer_address_lo;
 	uint32_t pad[30];
 };
 
-- 
2.25.1

