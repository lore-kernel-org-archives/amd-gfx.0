Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5A1D3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 11:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F098310E430;
	Mon,  8 Dec 2025 11:17:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WCun2i7g";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF3A10E128
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 11:17:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfEGXXU7fPBUu1R/mlPcUO0s/NucX1bt4XfIabAEm41FYVewsGZ7Az1TDHDrYZFZ+mtVVIf7DQif/TiF7PoZVNzupPKXy6o7/8nP7c4TGHZ1SHWN7rxtZ4G1Mfc2OFSTtLJPzO+gsQS1Wa0ridgXSgjBWSjgyldOmnvc8D+8U4MyDsVEWpzRJmauzRKR8GFqVq0shnKcaBfAErnNzAJXuBT2Tv6m5TH9hF4rFqQm7OsMWF1V8nuU5XObB/xt25VF3aVDKBEhk0+2EbPISEW+XTrd3P80ecBMauETb4AHL6Za+p0JPY4zLo8NhAelr+ij5jRR61X2Ko0K7BLiPvfoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZki4Yac9gOBP3WfEsadtB0TS1NGv9nXAmdOQ+bh6pI=;
 b=AdNwY2xQj9CubMwpvL6uCr3p+dJ5wEDnymJjJXgCvgI8rlLoETpOu8WedGXVSQI7BF6XuMW4jPpTLPT3XBWOo9PM6PnIguMgID0k1N6gO62lVk0EalXiJU6XOskg7OiJZc90JvoUerLpTYYNSQt9V25JdiFFnmzkMLCxE/rGarSF+F77RqGKmJErYWAC/+c1sM04eUHcowcEIwUqgWgXqsParkPQu+FPX12XgCUk/hSuxnQU5CHxUGaR37kO8cp3qSAvFZaA/ISbh+aWCAcnUZ5LuxaKO/SK5XW146nwZeG/HNzfhiCROAOF1R7xLzDMsYicy2w31GGN+uiuBvwy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZki4Yac9gOBP3WfEsadtB0TS1NGv9nXAmdOQ+bh6pI=;
 b=WCun2i7gbExCQPTqom8NTZg6Ov3TdBgzbNvC022jIFmP7pbuSxT3LablnXtAj7yMRL7s+RcP8vwXSORcVG5HzSQjpBW9udLiYhlR7xnGGOPecWDEnvEd8Q2fi/3DXwfupte9AN/jrlJBoAap7MjjZEK3XOgXLtvv1KsErGI0uHw=
Received: from DM6PR12CA0005.namprd12.prod.outlook.com (2603:10b6:5:1c0::18)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 11:17:12 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::fc) by DM6PR12CA0005.outlook.office365.com
 (2603:10b6:5:1c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 11:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 11:17:12 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 05:17:10 -0600
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <emily.deng@amd.com>, <lijo.lazar@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH v2] drm/amdgpu: fix mes packet params issue when flush hdp.
Date: Mon, 8 Dec 2025 19:16:55 +0800
Message-ID: <20251208111655.1396987-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d29287-1df9-4e15-35b1-08de364b55bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k13ZeOKfGPxnSLTjG1NKh4lPpmEd2hHO0CTTy5lQnMY3lQSUgiiKIV25Pop3?=
 =?us-ascii?Q?RFJRzsiY5plobJK36KPhpaN0tPBjjxUkrDjpNiNxx1x4KG4QXBgkkbMSoF+L?=
 =?us-ascii?Q?X7iXbaPrlg7fNXDEnlgUViwvqCHtdcWQUkSIWUt4pFtMLn9ySUHnLgxhTg4q?=
 =?us-ascii?Q?6ymS/Fv5Ri+bmeuFIOVkvs43P5YYDGtPmLAZ195tI3Dvp09GaOm/is4KKnHW?=
 =?us-ascii?Q?HKiiQGBRnAQcdo9o+ods8Yhsb8Kw9yu3Nl3QULqZWKQo++uKVD/zFn5J0quM?=
 =?us-ascii?Q?A6+1d8aHYK5vTDn1pC3rFLFifEiHOAYLaxF6k5GUzE95e5vLofGROaBy2Ybw?=
 =?us-ascii?Q?zJHFwkcX9S+BZ1PQ/HVytE3trBpuTxF/AzeSmbT7+2Sw0Tx0j2Up1prWfVCW?=
 =?us-ascii?Q?xTYvJoM9x6Ay0ql84jsEQCWyh1i30GaCNWzDJTHBnLU3rESxdKdQCTkUJpGS?=
 =?us-ascii?Q?mJYojPv/IEhW6PF7/+2SwCsJvSNLWhstPy2cVWV7i2YvRQKHnsaAqtvysi/z?=
 =?us-ascii?Q?osbjl/tz6Gb3I8l2EL5EB+oMaF5uqyh16mOK08AkFQGLutFAcIvUVXArVycG?=
 =?us-ascii?Q?Uu2BssbGgmpElGxpn7lM/KmYQHz9Z18K7wl/YVYPoNKDVAGjjMLP6dywHDf1?=
 =?us-ascii?Q?Ryafy8TYqNxFx3AFT3zTlT+L2yc9pH8z/Hjxyy43L+n84TwMRxHqI318sjDB?=
 =?us-ascii?Q?Bps3UHRNWeY1B4rNiBVgV4rmyq1GNwhfUSJfvMYc2qe4/V+pwjpAf0fy28fP?=
 =?us-ascii?Q?2rvZbpmUZNswi4kqb+34bpcI/j5Az3x7aM3TEduJws5LpLraoS0LHOZgX9jg?=
 =?us-ascii?Q?AkPl+WOghqOG8H8qN4BFJng3ufajrrxA4EPG5q4Iatli9suBWniWAvtOAXBN?=
 =?us-ascii?Q?hWFiromz2b5YOcLflwkKBIyepFI2d3ynXf2vhgDvWRemqsqX+0tJ+iL7t3o2?=
 =?us-ascii?Q?IHrY7UgMbk/8X0z75sHgyQ3lvig3DlcrEI5S3CILCZtWceWaoplvlKygoFj1?=
 =?us-ascii?Q?04qJtIUPe7p5uw3rml46ti9jO09aIoMPt7Sa+TB5YapgOMUpMHuwLFy8vtAS?=
 =?us-ascii?Q?WMJlJQUM0gVSNbrB/J1qDtm11xKWErern8uys95PvayyftiJg6YG38GbRsB2?=
 =?us-ascii?Q?6yFA6423nYW65MA+YeO6QhJJxmern6o8jso5/mWrD/KhYb7FnZ6JfWGnswYL?=
 =?us-ascii?Q?Vbmg3+Bf2GVZMWBfqLoUTgUysVmkmJjReof++VAa68SthUfRHsmPUwZPzi7G?=
 =?us-ascii?Q?zP1Vx7HlzUB3Bi61twmxFdiIpWoOSsWg1XsDKai3pXtxMYlvaW/7WcIG96MU?=
 =?us-ascii?Q?BNxtTqiMjDdy4CqON8y+RmvRnW4GUXpoxRGoaqRwssSdDMscfp6Y/DauCC32?=
 =?us-ascii?Q?xhA5ZQw20kH8Ip1Nf66Z5gFL104NQpXWJkIF6YMe0XGNWjuTBGKZd8QKgzhK?=
 =?us-ascii?Q?QMhZctp3ppVjUWwPpXf2ShTDQ0SM09Df23PqAezsaFstrQPu4a3dNYOr+ps6?=
 =?us-ascii?Q?1PnnaLMXX6NYnaez8C8j3kiJqkJCkU8vnLdCjzSQA3a8mzsbN3NvwwNmP0xp?=
 =?us-ascii?Q?j7lCbiLqVCcy/YKlvPQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 11:17:12.1731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d29287-1df9-4e15-35b1-08de364b55bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687
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

v2:
place "get_ref_and_mask" in amdgpu_gfx_funcs instead of amdgpu_ring,
since this function only assigns the cp entry.

v1:
both gfx ring and mes ring use cp0 to flush hdp, cause conflict.

use function get_ref_and_mask to assign the cp entry.
reassign mes to use cp8 instead.

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 58 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 58 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  3 +-
 8 files changed, 101 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index efd61a1ccc66..090714127cba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -356,6 +356,8 @@ struct amdgpu_gfx_funcs {
 				     int num_xccs_per_xcp);
 	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
 	int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
+	void (*get_ref_and_mask)(struct amdgpu_ring *ring,
+				uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
 };
 
 struct sq_work {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 895b841b9626..5c7724f203d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -556,11 +556,20 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
 
 int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
 {
-	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
+	uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
+	struct amdgpu_ring *mes_ring;
+	uint32_t ref_and_mask = 0, reg_mem_engine = 0;
 
+	if (!adev->gfx.funcs->get_ref_and_mask) {
+		dev_err(adev->dev, "amdgpu_mes_hdp_flush not support\n");
+		return -EINVAL;
+	}
+
+	mes_ring = &adev->mes.ring[0];
 	hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
 	hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
-	ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
+
+	adev->gfx.funcs->get_ref_and_mask(mes_ring, &ref_and_mask, &reg_mem_engine);
 
 	return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
 					     ref_and_mask, ref_and_mask, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index aaed24f7e716..aafd34ddcfcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8616,7 +8616,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	u32 ref_and_mask, reg_mem_engine;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
 		switch (ring->me) {
 		case 1:
 			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f4d4dd5dd07b..c3d8e7588740 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1072,6 +1072,44 @@ static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
 	}
 }
 
+/**
+ * gfx_v11_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v11_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	struct amdgpu_device *adev = ring->adev;
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+	    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
+			break;
+		case 3:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
+		*reg_mem_engine = 1; /* pfp */
+	}
+}
+
 static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v11_0_select_se_sh,
@@ -1081,6 +1119,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
 	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
+	.get_ref_and_mask = &gfx_v11_0_get_ref_and_mask,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
@@ -5833,25 +5872,8 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
-
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
-		reg_mem_engine = 1; /* pfp */
-	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f9cae6666697..b805ed4f88aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -929,6 +929,44 @@ static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
 	return -EINVAL;
 }
 
+/**
+ * gfx_v12_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v12_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	struct amdgpu_device *adev = ring->adev;
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+	    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
+			break;
+		case 3:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
+		*reg_mem_engine = 1; /* pfp */
+	}
+}
+
 static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v12_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v12_0_select_se_sh,
@@ -938,6 +976,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
+	.get_ref_and_mask = &gfx_v12_0_get_ref_and_mask,
 };
 
 static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
@@ -4389,25 +4428,8 @@ static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 ref_and_mask, reg_mem_engine;
-	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
-
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
-		reg_mem_engine = 1; /* pfp */
-	}
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 66a4e4998106..176658846b81 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2070,7 +2070,8 @@ static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	u32 ref_and_mask;
 	int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
 		switch (ring->me) {
 		case 1:
 			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e6187be27385..bc1d0870cb2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5382,7 +5382,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	u32 ref_and_mask, reg_mem_engine;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
 		switch (ring->me) {
 		case 1:
 			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 89253df5ffc8..418b8daa7097 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2820,7 +2820,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	u32 ref_and_mask, reg_mem_engine;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
+	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
 		switch (ring->me) {
 		case 1:
 			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
-- 
2.48.1

