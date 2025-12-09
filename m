Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978D5D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 07:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D67C10E485;
	Tue,  9 Dec 2025 07:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ZG5Bshs";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011051.outbound.protection.outlook.com
 [40.93.194.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BBFD10E485
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 07:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LETsjq2LOjzzrvL40LOvQ0OP4vFfuOEs2Bo2J6hwjvDq6Gj5yei2T1idKXkpACrgKetXiIigBec2QkA63zt1axIOy7K5seYnPbGw8FKpAb/+fNTUS3g4GLnMf1bVjvF6s6j5+cE2aEIGEOXqnA14yZ0n6z7vwrLPMjdGIEjncg4VzfVWsCE9YQHmgRCl8Sj0nhTEitKTKGIXSMO3oiw6YNItbaH61K40iLE1vz/uKefvxTNDjR0Bi6qCEw3YaKXVB0H8OweTFMdYZfUV2fVCRPw+0l4Rg+CJuT4T2rtwMdslafqGo1BzfAUYDFKi1GVQOBQs+bqZSTZDYqRlhiYykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avMFFJ1S4y4rBYtQFd3HUvm0hZLyNh6DV6mMbUuuAM0=;
 b=shZOTE4xNydHJPciAvPwsKqxo06PeKCfjsZCka8NkXMsT30slbktQdgh48J5Mlp0mYegTedlMwnyji0B/CIm09AnDgUCilLLIzk7CCEMMzdqHB+eoMOebdR7MpzC+ms2GYsxa830n/+Q1NYxCt33pqa1n/sOhBOG0Yptim5Snzp0DFu990aFGyxOB63G6xttfGsYjIETkHoEc0eI9k3LwC3ZMa34FufhQSAZSb5ES1FD7bwxVJy1YvB2ayw8XxOt/mQuuFJvGAGGn1djKbT7NEL2UD/NHi8E2r4M63M0y0wOmlT4g0tc+6MZrU7UIR1GimCBIUrcwb5KdHKZveC2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avMFFJ1S4y4rBYtQFd3HUvm0hZLyNh6DV6mMbUuuAM0=;
 b=4ZG5BshsMJ0Ua/MD9B/bOog9Wrj8jvA3EPL25iSZLXeY1GrDU+kRLyaDUEg32GDx4G4KqYzaMbFCGXBSCSoMcsq0vbaYtEROciKt/P2bvCwXciF/q+kUsADe8kF8fIr8c7n+AeaallrkzrxGBMUCcr8Nbkpzs9sKRZhnNS1jAsA=
Received: from CH0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:610:b1::14)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 07:38:45 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::87) by CH0PR13CA0009.outlook.office365.com
 (2603:10b6:610:b1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 07:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 07:38:45 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 01:38:43 -0600
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <emily.deng@amd.com>, <lijo.lazar@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH v3] drm/amdgpu: fix mes packet params issue when flush hdp.
Date: Tue, 9 Dec 2025 15:38:31 +0800
Message-ID: <20251209073831.1426657-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: b89b56c1-35e3-4cd2-e556-08de36f5fc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DDHeven6eGCK094sX50vUFMJBB2DLXGzT7FJm0bxhjfaJHtY7ZHn06zgIX+T?=
 =?us-ascii?Q?NLzSAtDhZDNnU+YsMoZijYpBhGiV/pGvkjSkQvuP6F/X4h3W0hXOv4HEA+zy?=
 =?us-ascii?Q?7tWwPeTk1KvpbbKL3UVcE8tAfSzW0gK0tZLLokFUSOJpT7Uxd6KPRBdmcQpg?=
 =?us-ascii?Q?9JjgRQJJm2j5zOlypJxWQUlX/133J06E1dvz3wVjVRnJdatOOSKGzvr+2n6l?=
 =?us-ascii?Q?zBGBdvUiBLbj/Ogy41rlBpPq7NiHDIfcv6MdOFVvVqI6StK1+pOaIguEtHTZ?=
 =?us-ascii?Q?REEAMAY+/QwcdrEiGBpz1RTIspavGSf6cnC30SkCXPPyWuooryzbWMK1cYLT?=
 =?us-ascii?Q?aQ8uhaHgBfqXw2REWGCz9+XiqunePuXfHIsaKqTym1rQmHvH1V/fP6twv5vK?=
 =?us-ascii?Q?uI2x+OJAA3hEbb2Imz4xJHefgh5wLc/dK4p8O2b+1axsQUlC354hVhO/PoX3?=
 =?us-ascii?Q?8ZSDBCT/t3/+4qViqw5jf/RM5ko7ngHTjI235tdNAyFOkCDIuvX79/Xw8zVx?=
 =?us-ascii?Q?PWQuYqxVxbVgkwmN/A31Oi73UyKxr4Imx5GlKvPZqpo5Vg+IvJrd7ftdT/9Y?=
 =?us-ascii?Q?UecEzFlyDGDV77QZQpAh7EDH9i+lXJrRhoucEV4akXN53Bjiv/wR8b7QWlqE?=
 =?us-ascii?Q?T0UE9npt9vPpifLw5z+dmnvHWFFYp7gc39eJlnqzQBRhi1RUL2H3Ry+hAMck?=
 =?us-ascii?Q?2jSy6I5VkPNevdwexaRpyq6jssLAvfeW7RXyZ50D6yaPjTYKa20lqLDeBHQV?=
 =?us-ascii?Q?ehsYSherRNiA3w13GV4FjGIBY+umGsA84SQv0+8krJ0vp/P/piWpDaHRyCjY?=
 =?us-ascii?Q?4LMFDRLq29Ed+DEPyKMRtdwiW4hZZFNHCU9DOg/NlT+1U8OEM8ny7bzy5p4T?=
 =?us-ascii?Q?1vvN4cZw9Y+ROOQhSmQiPmSg4V9xHFTQreK4k7c0RDiVlv5KpPF+3DAjVazG?=
 =?us-ascii?Q?OIpCVl+kbWR6D6Aaq3zLlQS65jzpxbj2oPQfVI/3np5v90iGc9+VetVJwlkX?=
 =?us-ascii?Q?U05zPETU7qQhZUvcYWonHZVdG62t/GGFmhaq7r/Vo8WFM0sbp8Ynv1ihieLf?=
 =?us-ascii?Q?5UpVGEX1yBKEDnydf4WWjd7SjUXhJytizb1vG6FL/fRSbWr18VjbpeWS3Z4n?=
 =?us-ascii?Q?BADQMz27/54SuTENal+ZQJTtt4DR5xzpxXvV2BlCEOqD6ejLZS2h7bs74EOQ?=
 =?us-ascii?Q?pzZJJN0ajLpRH+e4a1K0YLSgTTvBK9cxOxDfwuzhr9Ze65fYvuMU3Gr8kEat?=
 =?us-ascii?Q?TGqkjxUAUQ0i+BqwT/w68t1rMSXQpRcApG8uLZIDQ8UMgDvTqCSdc3crbZwc?=
 =?us-ascii?Q?nva1x9HCHFWmRb6dlOdY8EfUGHOFQMiwTdOeuchSILMBc7ocnwdplhwHttKU?=
 =?us-ascii?Q?TnfdE8hhOzCKpeGlXRoI28mWv68aYtUUds4Lr8e0o6wOrBNL0R6vN+KSyuia?=
 =?us-ascii?Q?BUoWHLtCEQT0G7gbTbsc3G8PDUWUzRtgrUb2TjSIMih+QQBI4s6whuxIAQP8?=
 =?us-ascii?Q?MOJYZUFUg55BKfPAMpF+8lFj3AAc4LS2glvjAu9Hqyrquqy9rPFzVyRjnaGQ?=
 =?us-ascii?Q?BhFzLVawOthqNMwfbAw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 07:38:45.5994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89b56c1-35e3-4cd2-e556-08de36f5fc08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
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

v3:
Unify the get_ref_and_mask function in amdgpu_gfx_funcs,
to support both GFX11 and earlier generations

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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 54 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 58 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 58 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 55 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 55 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 54 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 54 +++++++++++++++--------
 9 files changed, 275 insertions(+), 128 deletions(-)

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
index aaed24f7e716..ed79ceafc57b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4566,6 +4566,40 @@ static void gfx_v10_0_update_perfmon_mgcg(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, 0, mmRLC_PERFMON_CLK_CNTL, data);
 }
 
+/**
+ * gfx_v10_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v10_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	struct amdgpu_device *adev = ring->adev;
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
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
 static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v10_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v10_0_select_se_sh,
@@ -4575,6 +4609,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v10_0_select_me_pipe_q,
 	.init_spm_golden = &gfx_v10_0_init_spm_golden_registers,
 	.update_perfmon_mgcg = &gfx_v10_0_update_perfmon_mgcg,
+	.get_ref_and_mask = &gfx_v10_0_get_ref_and_mask,
 };
 
 static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
@@ -8614,25 +8649,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
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
 	gfx_v10_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
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
index 66a4e4998106..b3ea45e3c60f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2068,23 +2068,10 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	u32 ref_and_mask;
-	int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
-
-	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
-			break;
-		default:
-			return;
-		}
-	} else {
-		ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
-	}
+	int usepfp;
+	struct amdgpu_device *adev = ring->adev;
 
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &usepfp);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
 				 WAIT_REG_MEM_FUNCTION(3) |  /* == */
@@ -4075,12 +4062,46 @@ static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
 	cik_srbm_select(adev, me, pipe, q, vm);
 }
 
+/**
+ * gfx_v7_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v7_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
+		*reg_mem_engine = 1;
+	}
+}
+
 static const struct amdgpu_gfx_funcs gfx_v7_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v7_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v7_0_select_se_sh,
 	.read_wave_data = &gfx_v7_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v7_0_read_wave_sgprs,
-	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q
+	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q,
+	.get_ref_and_mask = &gfx_v7_0_get_ref_and_mask,
 };
 
 static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 5d6e8e0601cb..cc5acfcdf360 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5211,13 +5211,46 @@ static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id
 		start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
 }
 
+/**
+ * gfx_v8_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v8_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
+	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
+			break;
+		default:
+			return;
+		}
+		*reg_mem_engine = 0;
+	} else {
+		*ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
+		*reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
+	}
+}
 
 static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v8_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v8_0_select_se_sh,
 	.read_wave_data = &gfx_v8_0_read_wave_data,
 	.read_wave_sgprs = &gfx_v8_0_read_wave_sgprs,
-	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
+	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q,
+	.get_ref_and_mask = &gfx_v8_0_get_ref_and_mask,
 };
 
 static int gfx_v8_0_early_init(struct amdgpu_ip_block *ip_block)
@@ -6000,25 +6033,9 @@ static void gfx_v8_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
 static void gfx_v8_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 {
 	u32 ref_and_mask, reg_mem_engine;
+	struct amdgpu_device *adev = ring->adev;
 
-	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
-	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
-		switch (ring->me) {
-		case 1:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
-			break;
-		case 2:
-			ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
-			break;
-		default:
-			return;
-		}
-		reg_mem_engine = 0;
-	} else {
-		ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
-		reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
-	}
-
+	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
 				 WAIT_REG_MEM_FUNCTION(3) |  /* == */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e6187be27385..f2ebacc73eb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1997,6 +1997,40 @@ static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,
 	soc15_grbm_select(adev, me, pipe, q, vm, 0);
 }
 
+/**
+ * gfx_v9_0_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v9_0_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	struct amdgpu_device *adev = ring->adev;
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
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
 static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
         .get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
         .select_se_sh = &gfx_v9_0_select_se_sh,
@@ -2004,6 +2038,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
         .read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
         .read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
         .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
+		.get_ref_and_mask = &gfx_v9_0_get_ref_and_mask,
 };
 
 const struct amdgpu_ras_block_hw_ops  gfx_v9_0_ras_ops = {
@@ -5380,25 +5415,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
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
 	gfx_v9_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			      adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			      adev->nbio.funcs->get_hdp_flush_done_offset(adev),
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 89253df5ffc8..b4ba76110c34 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -838,6 +838,40 @@ static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
 	return xcc - 1;
 }
 
+/**
+ * gfx_v9_4_3_get_ref_and_mask - get the reference and mask for HDP flush
+ *
+ * @ring: amdgpu_ring structure holding ring information
+ * @ref_and_mask: pointer to store the reference and mask
+ * @reg_mem_engine: pointer to store the register memory engine
+ *
+ * Calculates the reference and mask for HDP flush based on the ring type and me.
+ */
+static void gfx_v9_4_3_get_ref_and_mask(struct amdgpu_ring *ring,
+					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
+{
+	struct amdgpu_device *adev = ring->adev;
+	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
+		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		switch (ring->me) {
+		case 1:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
+			break;
+		case 2:
+			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
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
 static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v9_4_3_xcc_select_se_sh,
@@ -848,6 +882,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
 	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
 	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
 	.get_xccs_per_xcp = &gfx_v9_4_3_get_xccs_per_xcp,
+	.get_ref_and_mask = &gfx_v9_4_3_get_ref_and_mask,
 };
 
 static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
@@ -2818,25 +2853,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
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
 	gfx_v9_4_3_wait_reg_mem(ring, reg_mem_engine, 0, 1,
 			      adev->nbio.funcs->get_hdp_flush_req_offset(adev),
 			      adev->nbio.funcs->get_hdp_flush_done_offset(adev),
-- 
2.48.1

