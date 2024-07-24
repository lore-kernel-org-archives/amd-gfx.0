Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F09C3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 07:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D2F310E199;
	Wed, 24 Jul 2024 07:07:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yVT1h7+w";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC0F10E199
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 07:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHDhE1Eq+P/1qPHfTI3xXD6/pBM3qV46ovIEbfa9bINkl9AE3FgN1YXVbSvMBlw3QgEvbDuQYh/Typ06g9q6IZ/G5G3kUaFDqa/Ij8DdsItJrtopso8MRaItxfUpOemTq6wyc5mfmpWCSsCmdm2zbInXvenVMhu4KR5hJ5lfXAXjrtemVApPb3hwfSHbsGfmlXzCdkHstviZLpXQIxUXW4o+wenjaF4jbI1YJMl/riCsHUXpj7maw8NNuvwG4RsEIfYx8iEbATd8b0TPGD83qXCyGSwqnwtCdvw8UyWh7wzHjMAuXD6MUVHofEw6mj7cpLFMDTZq+iCi6drXnkH29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K04FqSwaaJ6K47l8v1GGeitmpHGZZgBtHhaV4xzp6fE=;
 b=xR4YCrgk7L/no+LMyKs2FwhOfQWtH2qOTWwnc1gp0r5W4XvmpeJSyOM1aoGRqzDbzFq3HYLYPqbAFtlcMpxYSyKLQCMUPkMB6qsHXOFDuxgXCaf+GmpKr+qmKgeJal4VD8miQXG0cgGyQ3bjf6ybAQlguYlRPVQ2S/7cuEmpZrZXz0HMZkM1x2F7WTYD0SdlXUJZACQ8bOmn3XFAYiM35hUUiqJW3Jtq1y9vWS7d17kb/89z9NCk65JaXz+WlWI4IhJT17DwALvzYMbOez+wWtLxQIgWY3JEXDnhcUK+99V2ndXOdSGbITkXbcwHYqwBn0HNZkqRqs8Q/8TwZcxr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K04FqSwaaJ6K47l8v1GGeitmpHGZZgBtHhaV4xzp6fE=;
 b=yVT1h7+wVFB3fEer+qIu5u+S2sg0rs/xUwR9jYSAlyPpgqsyVUm/0Co7Ie1hc75Oxh0IhRFL9RfnEAHdDHP5KS6rguthDMPstD4vB2ZFkHn3mTEQ9v9RfuMtC6MxfTVAY0YnarVBxYxmf5nyF1lU/dmwvaso9ApeRe6x3AGN93k=
Received: from BL6PEPF0001640E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:15) by SJ0PR12MB6734.namprd12.prod.outlook.com
 (2603:10b6:a03:478::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 24 Jul
 2024 07:07:48 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2a01:111:f403:f901::) by BL6PEPF0001640E.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Wed, 24 Jul 2024 07:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 07:07:48 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 02:07:45 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <tim.huang@amd.com>
Subject: [PATCH] drm/amdgpu: fix Coverity explicit null dereferenced warnings
Date: Wed, 24 Jul 2024 15:06:55 +0800
Message-ID: <20240724070655.366937-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: e106963d-1f7a-4fd1-7b2b-08dcabaf5348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sOH2mUJQFPKr+oEg/kV+btxPZndoTM2u0OW3PAXDY9mlIZ1GfgWM6rTt1kda?=
 =?us-ascii?Q?/uw3Ud79JYWMIgJ0YAtHj6AmNf1PGtesH1nQxnE1WvuJ6Nlr6Jqo1cvUShX6?=
 =?us-ascii?Q?KdkFytjT95t0zJo7hmeQ4d7T5hqFV4NHkd9z0Imx5dbteDWxtR7BsEm90tsd?=
 =?us-ascii?Q?o4PvmQLLbyghCp90LgPBJnqo6o5LQaeQJ9AlzwUlEn0olrvJvlEa9rIvCBcK?=
 =?us-ascii?Q?5DIz6OSGYXaasxE2NVFbk3XTK6FC3YsR5JM8oDmIOiWAjwB1lAPNEOu9UMro?=
 =?us-ascii?Q?UEDEwdSfAu62QpPW4nt5Jn+FQG8yxwNnKyRaNGKQiDtXySMSb95yYosP6W8/?=
 =?us-ascii?Q?fCYaSpqpbWFgQrOrhxCNu/52XCe5GGbenQazJXtV1L5L8eHCTN1u4aVwdjh0?=
 =?us-ascii?Q?J/EJ9yvOz1xFhtP7ITtMm9d0eHGBnuy6pLhAzOZOPPPv8bbXhT7mXPa7Lszz?=
 =?us-ascii?Q?QCLrAuXmi1+mtjOIl1VcZ5aqEQVLQqPMCbHvDXHfo2QPlGqH9df0cJTtZ8kD?=
 =?us-ascii?Q?bSzN71+nRWCCYgF3NRS77M7fhywseTtV0VDpocnrWi2jUJR3CxkscBaNF2Hw?=
 =?us-ascii?Q?7iBF/Gz9sCEGSeYbRmQ8ekDHqkhBtKtLkWmoBczc2hgmPFRCXUflcMhj2Z3/?=
 =?us-ascii?Q?hiRo9A+eAPw+WEWcL7IPlGoxYhdaVDNAKmeRe6jLVtpFTePschVFz3T+DPbl?=
 =?us-ascii?Q?ILK0bZfuBtxg3lG8eZR9vY2b5qGXO49NOcZep9qEl9f6QnK/yjTi1wErIIXJ?=
 =?us-ascii?Q?Z9TVT1Dn/CMNwgEUT5ZUBLTc+mdmJuYffwjMXpFWwoDBw/lO03mQBrnSbhmC?=
 =?us-ascii?Q?imOz83YFsyf1HPgFsAPu3UAKItqtySr64ZfCaXBXzkI6mMFNsIIuKa7Y7nVX?=
 =?us-ascii?Q?d+dy+RRSSzlakrWtiJsZ8W0Vcu/hyjOLzM5hRT0/jqVv0x96D9+GLmJPIDoi?=
 =?us-ascii?Q?fYCvcDsjT7IAzM6Cvt+NlOFBmQURWgESJHPttpfhLLn6lDf15Mgxp/eRFZiG?=
 =?us-ascii?Q?c0gxIkQMbSSSENwqmI1EdgUN1vgMC0cXcmAFcYO27l9gaDKh8eVLk9+eXzhO?=
 =?us-ascii?Q?12r8I2CiYdiVEHsSEWYCRxY9cvhzjUXk09XqCMKcLgG2GGKyqoAk0Y7xkSbN?=
 =?us-ascii?Q?fIzg/dWEDX48ZDiqT1C0E8KQrF65xUkPqPEsaLjCWwlUeStcPkeYXaNPvy4i?=
 =?us-ascii?Q?ZsFdYOAjZdufpRlTnbaVcn3fABGWwflFZrr4Pi9VqA0As3HEyWN/nQ8gUPVN?=
 =?us-ascii?Q?7AJncI5Nwi20STZueXyz7qjqNKYsIgeGg/JNaehtOAKI9JdgZsdW9CBwZ8w1?=
 =?us-ascii?Q?iQysLlfFYgIa4pPqbaxc1r6xQ7srhufW2y8nfQCGZCOGMgroAEdUAzKy4/DI?=
 =?us-ascii?Q?2818TMu6/lWcCImFFmaDvWe+lJx49pov9xDvbznO2UcBrATl7gK6BH/sQ6cZ?=
 =?us-ascii?Q?rXmFwFrKPtTYobYdMR9UF7N8ggZvvh6D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:07:48.3403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e106963d-1f7a-4fd1-7b2b-08dcabaf5348
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
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

This is to address the Coverity explicit null dereferenced warnings
by NULL returns from amdgpu_mes_ctx_get_offs* but without follow-up
Checks. Meanwhile refactor the code to keep only one *_get_gpu/cpu_addr.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 ++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 17 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 12 ++++++------
 11 files changed, 55 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e499d6ba306b..fb708b695db8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1082,7 +1082,7 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 		int offset = offsetof(struct amdgpu_mes_ctx_meta_data,
 				      compute[ring->idx].mec_hpd);
 		ring->eop_gpu_addr =
-			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+			amdgpu_ring_get_gpu_addr(ring, offset);
 	}
 
 	switch (queue_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index ad49cecb20b8..01dd7b30ba74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -169,16 +169,6 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
 		ring->funcs->end_use(ring);
 }
 
-#define amdgpu_ring_get_gpu_addr(ring, offset)				\
-	(ring->is_mes_queue ?						\
-	 (ring->mes_ctx->meta_data_gpu_addr + offset) :			\
-	 (ring->adev->wb.gpu_addr + offset * 4))
-
-#define amdgpu_ring_get_cpu_addr(ring, offset)				\
-	(ring->is_mes_queue ?						\
-	 (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
-	 (&ring->adev->wb.wb[offset]))
-
 /**
  * amdgpu_ring_init - init driver ring struct.
  *
@@ -332,8 +322,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 
 		offset = amdgpu_mes_ctx_get_offs(ring,
 					 AMDGPU_MES_CTX_RING_OFFS);
-		ring->gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		ring->ring = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		ring->gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		ring->ring = amdgpu_ring_get_cpu_addr(ring, offset);
 		amdgpu_ring_clear_ring(ring);
 
 	} else if (ring->ring_obj == NULL) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 582053f1cd56..f65f13d147b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -436,14 +436,15 @@ static inline void amdgpu_ring_patch_cond_exec(struct amdgpu_ring *ring,
 	ring->ring[offset] = cur - offset;
 }
 
-#define amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset)			\
-	(ring->is_mes_queue && ring->mes_ctx ?				\
-	 (ring->mes_ctx->meta_data_gpu_addr + offset) : 0)
-
-#define amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset)			\
-	(ring->is_mes_queue && ring->mes_ctx ?				\
-	 (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
-	 NULL)
+#define amdgpu_ring_get_gpu_addr(ring, offset)				\
+	(ring->is_mes_queue ?						\
+	(ring->mes_ctx->meta_data_gpu_addr + offset) :			\
+	(ring->adev->wb.gpu_addr + offset * 4))
+
+#define amdgpu_ring_get_cpu_addr(ring, offset)				\
+	(ring->is_mes_queue ?						\
+	((void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset)) : \
+	((void *)(&ring->adev->wb.wb[offset])))
 
 int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 183a976ba29d..8eca0f1733ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -80,7 +80,7 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
 
 		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
 				  sdma[ring->idx].sdma_meta_data);
-		csa_mc_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		csa_mc_addr = amdgpu_ring_get_gpu_addr(ring, offset);
 	} else {
 		r = amdgpu_sdma_get_index_from_ring(ring, &index);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index dcef39907449..abda3fba1cba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -546,11 +546,11 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		padding = amdgpu_mes_ctx_get_offs(ring,
 						  AMDGPU_MES_CTX_PADDING_OFFS);
 
-		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		ib.ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		ib.ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 
-		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, padding);
-		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, padding);
+		gpu_addr = amdgpu_ring_get_gpu_addr(ring, padding);
+		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, padding);
 		*cpu_ptr = cpu_to_le32(0xCAFEDEAD);
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
@@ -5895,14 +5895,14 @@ static void gfx_v11_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 				  gfx[0].gfx_meta_data) +
 			offsetof(struct v10_gfx_meta_data, de_payload);
 		de_payload_gpu_addr =
-			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+			amdgpu_ring_get_gpu_addr(ring, offset);
 		de_payload_cpu_addr =
-			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+			amdgpu_ring_get_cpu_addr(ring, offset);
 
 		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
 				  gfx[0].gds_backup) +
 			offsetof(struct v10_gfx_meta_data, de_payload);
-		gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		gds_addr = amdgpu_ring_get_gpu_addr(ring, offset);
 	} else {
 		offset = offsetof(struct v10_gfx_meta_data, de_payload);
 		de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f384be0d1800..df817b898e48 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -456,11 +456,11 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		padding = amdgpu_mes_ctx_get_offs(ring,
 						  AMDGPU_MES_CTX_PADDING_OFFS);
 
-		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		ib.ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		ib.ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 
-		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, padding);
-		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, padding);
+		gpu_addr = amdgpu_ring_get_gpu_addr(ring, padding);
+		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, padding);
 		*cpu_ptr = cpu_to_le32(0xCAFEDEAD);
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2929c8972ea7..b26658414f3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5359,7 +5359,7 @@ static void gfx_v9_0_ring_patch_ce_meta(struct amdgpu_ring *ring,
 					  gfx[0].gfx_meta_data) +
 			offsetof(struct v9_gfx_meta_data, ce_payload);
 		ce_payload_cpu_addr =
-			amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_offset);
+			amdgpu_ring_get_cpu_addr(ring, payload_offset);
 	} else {
 		payload_offset = offsetof(struct v9_gfx_meta_data, ce_payload);
 		ce_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
@@ -5391,7 +5391,7 @@ static void gfx_v9_0_ring_patch_de_meta(struct amdgpu_ring *ring,
 					  gfx[0].gfx_meta_data) +
 			offsetof(struct v9_gfx_meta_data, de_payload);
 		de_payload_cpu_addr =
-			amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_offset);
+			amdgpu_ring_get_cpu_addr(ring, payload_offset);
 	} else {
 		payload_offset = offsetof(struct v9_gfx_meta_data, de_payload);
 		de_payload_cpu_addr = adev->virt.csa_cpu_addr + payload_offset;
@@ -5590,9 +5590,9 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 				  gfx[0].gfx_meta_data) +
 			offsetof(struct v9_gfx_meta_data, ce_payload);
 		ce_payload_gpu_addr =
-			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+			amdgpu_ring_get_gpu_addr(ring, offset);
 		ce_payload_cpu_addr =
-			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+			amdgpu_ring_get_cpu_addr(ring, offset);
 	} else {
 		offset = offsetof(struct v9_gfx_meta_data, ce_payload);
 		ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
@@ -5688,14 +5688,14 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume, bo
 				  gfx[0].gfx_meta_data) +
 			offsetof(struct v9_gfx_meta_data, de_payload);
 		de_payload_gpu_addr =
-			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+			amdgpu_ring_get_gpu_addr(ring, offset);
 		de_payload_cpu_addr =
-			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+			amdgpu_ring_get_cpu_addr(ring, offset);
 
 		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
 				  gfx[0].gds_backup) +
 			offsetof(struct v9_gfx_meta_data, de_payload);
-		gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
+		gds_addr = amdgpu_ring_get_gpu_addr(ring, offset);
 	} else {
 		offset = offsetof(struct v9_gfx_meta_data, de_payload);
 		de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b7d33d78bce0..533b1d9964b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -982,8 +982,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 		uint32_t offset = 0;
 		offset = amdgpu_mes_ctx_get_offs(ring,
 					 AMDGPU_MES_CTX_PADDING_OFFS);
-		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
@@ -1060,13 +1060,13 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	if (ring->is_mes_queue) {
 		uint32_t offset = 0;
 		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
-		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		ib.ptr = (void *)amdgpu_ring_get_cpu_addr(ring, offset);
 
 		offset = amdgpu_mes_ctx_get_offs(ring,
 					 AMDGPU_MES_CTX_PADDING_OFFS);
-		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 630b03f2ce3d..e94f52e34489 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -871,8 +871,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 		uint32_t offset = 0;
 		offset = amdgpu_mes_ctx_get_offs(ring,
 					 AMDGPU_MES_CTX_PADDING_OFFS);
-		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
@@ -949,13 +949,13 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	if (ring->is_mes_queue) {
 		uint32_t offset = 0;
 		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
-		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		ib.ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 
 		offset = amdgpu_mes_ctx_get_offs(ring,
 					 AMDGPU_MES_CTX_PADDING_OFFS);
-		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index dab4c2db8c9d..e29260d5b694 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -845,8 +845,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 		uint32_t offset = 0;
 		offset = amdgpu_mes_ctx_get_offs(ring,
 					 AMDGPU_MES_CTX_PADDING_OFFS);
-		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
@@ -923,13 +923,13 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	if (ring->is_mes_queue) {
 		uint32_t offset = 0;
 		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
-		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		ib.ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 
 		offset = amdgpu_mes_ctx_get_offs(ring,
 					 AMDGPU_MES_CTX_PADDING_OFFS);
-		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 41b5e45697dc..efd3c9bdb7c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -857,8 +857,8 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 		uint32_t offset = 0;
 		offset = amdgpu_mes_ctx_get_offs(ring,
 					 AMDGPU_MES_CTX_PADDING_OFFS);
-		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
@@ -935,13 +935,13 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	if (ring->is_mes_queue) {
 		uint32_t offset = 0;
 		offset = amdgpu_mes_ctx_get_offs(ring, AMDGPU_MES_CTX_IB_OFFS);
-		ib.gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		ib.ptr = (void *)amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		ib.gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		ib.ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 
 		offset = amdgpu_mes_ctx_get_offs(ring,
 					 AMDGPU_MES_CTX_PADDING_OFFS);
-		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
-		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
+		gpu_addr = amdgpu_ring_get_gpu_addr(ring, offset);
+		cpu_ptr = amdgpu_ring_get_cpu_addr(ring, offset);
 		*cpu_ptr = tmp;
 	} else {
 		r = amdgpu_device_wb_get(adev, &index);
-- 
2.43.0

