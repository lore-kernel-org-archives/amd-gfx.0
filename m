Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB74C021B6
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Feb 2025 02:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15BB810E0B0;
	Sat, 22 Feb 2025 02:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cFPYKx2x";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F37B010E066
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Feb 2025 02:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+7vchqY82z07u39JJ/ITuPxJl/K7vhzeqWf+SmoFn9JESXXx6qNoniBFoDE4B6fXB2tpxRFXk0AxYnxeemxg99KEj3W51jBdZjsOnkG4YNdm6pmWEP2iPzJken7nbRwCnCFbBVdNSzvaulLbj5XbSgaG2iXEBS4RIhubf/Rji7rm24tUzLNRecZLumpt0ZZYo4EyvCavndbD76AaG/OMS/OgYvqZj/ogUMZ6nTodPA+BFrTdC0iDG+qyPIH74q29l5ZKnwuVUi5ZkFDgIj3bjcYuTRc2yJcim+6rzne6hvWiefarF8A1HhcrGq/f8amkiPjqgf0KnnIlHVM3MW1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY+fK7miCku7QaJtweB3/0QmgsevOI+LuVUbcJc18GY=;
 b=ZCT2W9ix7+OSmhotG6UXv3QlGkfPDIq6WopmHexcGIUugkd87uR+m+GFhZ++2ULbeNze0G+KERDrC5jZKQBjszhjgcPK843IfiLykdsPut4sNdArzIe9Ywj6tPdRVuW0SbGAlhRasmM+bjnPdFaYfRD9eFvmRzmfKGdKo0e0P0bAI7flWRrPzSadLDk+KFRIhe57bvZNqRQNPIOJd9t25wjlhKWShZKRz1jl3xYuwUg/Fj2dQeN23dPakH4/Mb5/kr05fR/PAD1+T8H6B+fBTE84faVqlEZm7rG3YdTxu34lBrG4oqP9JzOKcl6qUEHN1J9P74qgs5ezdFRJsWAaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY+fK7miCku7QaJtweB3/0QmgsevOI+LuVUbcJc18GY=;
 b=cFPYKx2x3AzS13Cr1prhTfZj6SGHjAeqZ4fNs+yBUVJ280Fm8em8OFygYnqPs1rsXubPT1kMbbIRX4EUytY0wcPP6uipBcX3VNye2WK/4w+3jKTye/6P1vr1EqzlbcixnBc6VyV99EwRfTaYDZ+8TOsJzSzoto6TxUaH7LM7098=
Received: from CH5PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:1ed::27)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sat, 22 Feb
 2025 02:05:47 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1ed:cafe::e9) by CH5PR02CA0013.outlook.office365.com
 (2603:10b6:610:1ed::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Sat,
 22 Feb 2025 02:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Sat, 22 Feb 2025 02:05:46 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 20:05:45 -0600
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Boyuan Zhang <boyuan.zhang@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn: send session ctx along with msg buffer
Date: Fri, 21 Feb 2025 21:05:30 -0500
Message-ID: <20250222020530.8194-2-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250222020530.8194-1-boyuan.zhang@amd.com>
References: <20250222020530.8194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f090b2-b073-4762-5bdf-08dd52e56bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eWNSSEBdu8ZJI3Hlah8znxSq0DaiDZ2tNtqORsoN1xkNzGijPQb9SwZiUMCJ?=
 =?us-ascii?Q?0rJVxRroP29OJfWvy2phnF1zwv4nZW6dvumkhOoxjEpVBsXhfUPetOrAzt1I?=
 =?us-ascii?Q?vXDewV2TqjZO2oXRMcrkahIj0WoUgmcVUSqQ/lnd9iCcVqCEBpXoAOSuFyzn?=
 =?us-ascii?Q?8hK0TKnQxec+K38Ab/4Nv1wXoSk4D3j25VRC82FSSzpLr+VK0iRz+qp4gvs0?=
 =?us-ascii?Q?1I205NHkbypFDHkIZ5urXGvJMDlU5sxvfAhqeFkZGlhpVJZk2VlcydQE+RX2?=
 =?us-ascii?Q?MIv5MHzI+UzMoLlFOBNAe6r02SYdj4M7zFTXbFTWgW9+hHkUWBjSmyvvGQDy?=
 =?us-ascii?Q?7vmch9uU2+q7Lj3y6/nQchRcWMwzPIjivaGRR0OpFm5bo1NBHzEyCNiztika?=
 =?us-ascii?Q?QHbPUx9POZS/Ry93pAGncxeKCTzVR3DT0s4oVTraEnMotds22WSmGX6Q3RUY?=
 =?us-ascii?Q?KE+j6xMqS4Mx4w1G2BTdrzKN7gC2Rjp0uGTdyk1evLLUMe1oZy8RoO62rLKA?=
 =?us-ascii?Q?Ct8h1rdsz8sR0TA15qRpOOsuF6Wgixlxxe8bs/Ieh2qhHxpkifPbIOWVZl+a?=
 =?us-ascii?Q?nOoUueOXdEf0OOr4ANXaboWAQkLf/zAh1IRLEAXGY44kmvZO2//jGpBvoLxR?=
 =?us-ascii?Q?tbZUYb7/fIhSV3SgQSbrsPg0FxFsT02y5QHKiO7TxyLdctnOPVR4SFn36Xjm?=
 =?us-ascii?Q?OOz50hEtRWJX6BHkqaVCLHsaPACki+vQDGJXXXwnNp6jOmB9s3zDEK5gFpJy?=
 =?us-ascii?Q?ujhgMm95nchgbip4rb7rGuKyXrcf34/UKLEeGBcNwgQ0ciK9/3ANfR7o8Duv?=
 =?us-ascii?Q?q2QLjbOk08+8OqlpowSN3JGuATznDB+hW470h5LZERlZ05oZlzJd0UhcyFhr?=
 =?us-ascii?Q?1RECvC9h5iZ4Ncuc2AegFWW0TdV6eb3sfr5YgA0qQ3/xsAgc5VBltgE8OiEn?=
 =?us-ascii?Q?wwNsGGAzzKOcvCziDQnNUSeYD3l1ECJGSApsHflGEzRJTMPOGLgZu7gOHtM9?=
 =?us-ascii?Q?sUuv/QPs9sBKsHdttbiV98Pi95+xELJy41GE5n53KW7KBCG8VGbbz5qLiu3i?=
 =?us-ascii?Q?SIp6pufX4quxbtuXNsI+HeDIRGI1WHbuRzfb18EeV27+vfL51T6iKLlmBax5?=
 =?us-ascii?Q?0pwFyFdIlvxnGy6cX3keY5WpqpFaCgVJjtqF6dE0l0HBubGzuWYwCQ9QcN4z?=
 =?us-ascii?Q?A3NpMpebdnQCEIeMuQ8N9T8AWB4hxPwP6b0KO4d2WMtSGG7+ZZNSaRsIQLSE?=
 =?us-ascii?Q?aFAmvCUh+LB3ibZ6cO1rPC6Qm5Ks8L9y/4Md0SdsQjH/c2OWaLoBikq1uTMU?=
 =?us-ascii?Q?zbWhIoFDFaDEhNeyriC4cJLkAj/s98drsrkZFItxS/eNpXt5teVqoYia4Vs+?=
 =?us-ascii?Q?zUU6Cy+15/qA43a25QI2yLxJd8cVSZiWx6QYLQavtAodoo1eLjnoBz2KK1g6?=
 =?us-ascii?Q?t1IEoDU7B6T+qdmLNExdAXbHUcmF4IsL9Y9egUBXXvpyI8cVARS/2N8cPltr?=
 =?us-ascii?Q?4OOUblcIoNqvLy4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 02:05:46.4978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f090b2-b073-4762-5bdf-08dd52e56bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Session context buffer is required to be sent along with message buffer

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Tested-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 43 ++++++++++++++++++-------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 83faf6e6788a..8d2cce3ea7af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -602,18 +602,29 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 }
 
 static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-		struct amdgpu_ib *ib)
+		struct amdgpu_ib *ib, struct amdgpu_ib *ctx)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t *msg;
 	int r, i;
 
-	memset(ib, 0, sizeof(*ib));
-	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
-			AMDGPU_IB_POOL_DIRECT,
-			ib);
-	if (r)
-		return r;
+	if (ctx) {
+		memset(ctx, 0, sizeof(*ctx));
+		r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 32,
+				AMDGPU_IB_POOL_DIRECT,
+				ctx);
+		if (r)
+			return r;
+	}
+
+	if (ib) {
+		memset(ib, 0, sizeof(*ib));
+		r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+				AMDGPU_IB_POOL_DIRECT,
+				ib);
+		if (r)
+			return r;
+	}
 
 	msg = (uint32_t *)AMDGPU_GPU_PAGE_ALIGN((unsigned long)ib->ptr);
 	msg[0] = cpu_to_le32(0x00000028);
@@ -669,7 +680,7 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct amdgpu_ib ib;
 	long r;
 
-	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
+	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib, NULL);
 	if (r)
 		goto error;
 
@@ -727,6 +738,7 @@ static void amdgpu_vcn_unified_ring_ib_checksum(uint32_t **ib_checksum,
 
 static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 				      struct amdgpu_ib *ib_msg,
+				      struct amdgpu_ib *ib_ctx,
 				      struct dma_fence **fence)
 {
 	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
@@ -735,6 +747,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
+	uint64_t addr_ctx = AMDGPU_GPU_PAGE_ALIGN(ib_ctx->gpu_addr);
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
@@ -765,6 +778,10 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
 	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
 
+	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER);
+	decode_buffer->session_ctx_buffer_address_hi = cpu_to_le32(addr_ctx >> 32);
+	decode_buffer->session_ctx_buffer_address_lo = cpu_to_le32(addr_ctx);
+
 	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
 	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
 	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
@@ -780,6 +797,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 		goto err_free;
 
 	amdgpu_ib_free(ib_msg, f);
+	amdgpu_ib_free(ib_ctx, f);
 
 	if (fence)
 		*fence = dma_fence_get(f);
@@ -791,27 +809,28 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	amdgpu_job_free(job);
 err:
 	amdgpu_ib_free(ib_msg, f);
+	amdgpu_ib_free(ib_ctx, f);
 	return r;
 }
 
 int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_ib ib;
+	struct amdgpu_ib ib, ctx;
 	long r;
 
-	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib);
+	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &ib, &ctx);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, NULL);
+	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &ctx, NULL);
 	if (r)
 		goto error;
 	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &ib);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &fence);
+	r = amdgpu_vcn_dec_sw_send_msg(ring, &ib, &ctx, &fence);
 	if (r)
 		goto error;
 
-- 
2.34.1

