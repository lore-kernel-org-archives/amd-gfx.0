Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCDBC71157
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 21:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77DB410EA60;
	Fri, 13 Jun 2025 21:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EOlGMcwd";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1E810EA60
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 21:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cI9pueqaREKujHrHSgQAotgy7v+mb1JqaED4caoYWn6/BFufUeJrNwwwnF4sU50JjjlWtSVTJanInE27LLqt5tYU6mZKLYwQ5yX/wwrZCyAwpgg6FUiVtjbKy3haajzyhUqFNLAxkUoyqT4PbjXzL9mUdhii4NsyPMzd5TKtlcCBDzOSV7XNq0YRkmmREuDkEru67+nq9MItXTHXP2V7sLs6ThXsQMFpySYe+tCuTSgb44DUEkY48UK0i+S0f1Z9UUVlbRPlm6lCGfe6F5tNAPk1SnNSyJr8WrM4QWcgKcHv5FHpA/k5s+w/m+s3HDrj2vxiFidPl1pTaDmPsHR99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJMFBKyXy28FQnNPhMnSGb0QGt/vlwgesOyOhF73NWA=;
 b=IMu23/Fv6wJHezNtsE2Dc4A6WOaSwqtPHLqUcYNWdL91BYFW3Ivmseq3n64xIQxQJUz2T/KpNdhpQBeKXFXz1T3gjREA5J5lgVbhaBcFyPTZqyYBWdH4YrQoO1E2JCViiWseFxBodC78/Yp3OC0JXOxfFC7Y4YBw4xPHug7qUJqhzOOYcbxudWHiwRdVsuSEGs/0/EcMiAx/cbR2RPehM1FaWjDQIG+g0VnjmN110OgcMpVvR7MAoTR2KAJLl2g+7HLaldMy7nhphmzaAABL4cUXwcXcpEIZoW5BfviwV/MOeOkgasMTejw86JSogLVjpUu2UPWBS7gR8d54Phe5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJMFBKyXy28FQnNPhMnSGb0QGt/vlwgesOyOhF73NWA=;
 b=EOlGMcwdTxr9ysez5xZ769mlb569qdQvCvD8/ZPhKeSCHIrqJG/LvH3wpZk7jg1uc+GEts+J3pPOKSI0Vfxaq1b2Vg9mmx1GbXePpB/xPTg7tP0GS1xpnS+iaavTINMqhLplTpH1tI/2LuHRL4UkrhHomljYKtW3v8XReWfG5PA=
Received: from CH5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:610:1f4::7)
 by DS5PPFDB3A23D1A.namprd12.prod.outlook.com (2603:10b6:f:fc00::663)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 13 Jun
 2025 21:48:08 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::b) by CH5PR04CA0007.outlook.office365.com
 (2603:10b6:610:1f4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 21:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 21:48:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 16:48:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/27] drm/amdgpu: update ring reset function signature
Date: Fri, 13 Jun 2025 17:47:25 -0400
Message-ID: <20250613214748.5889-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613214748.5889-1-alexander.deucher@amd.com>
References: <20250613214748.5889-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DS5PPFDB3A23D1A:EE_
X-MS-Office365-Filtering-Correlation-Id: b838a318-ec7d-4de2-3e8a-08ddaac3fc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5upw6CTSfPfAz8HWNP9WoZx7J0AZ++i090SEkPGaWVR0UJl+DP5mmLRbYz2B?=
 =?us-ascii?Q?rLA+/SKKL8nNJFBepnSK8ISIpa47VHVeOOpG+g7UQvUdzxOJtcnba4zAxvR0?=
 =?us-ascii?Q?TJjLq/OP0lZELadO1GoRVSrdp231p/zhBxUpUQ/9hKMRGuqd7RCSKS0NfToa?=
 =?us-ascii?Q?SCb7TUPDbbE6q+dolwaEZ03UiH7HiYzzJ7tKbVt9Ijnz5cvHvHR8SLsDuHMP?=
 =?us-ascii?Q?LzdVM2dpd791nkYB8VEcwvhM3BMqAjmF23+xOI2wMN6wZk1Y1nSL6kdEzAGP?=
 =?us-ascii?Q?U3ga0AxhrELq4O/zMV3VK68Cqn+3v16e50O0jotAnC7bB9uEsJP+kVqvuMJo?=
 =?us-ascii?Q?69Gi4eA1ZyEk3yj99lP5NGbB19MIrnfuszENHX84ogRvgyO9FiLgN8uQmu3B?=
 =?us-ascii?Q?A03U4m+BZhHUPzrjUV1+dTJe9zTqj2VavtKfz8DKHsmgW/FLxfkcYKFfZA1n?=
 =?us-ascii?Q?S3f+karMwNpJHTqJdyCXmQo89BGvydSl7JZ+wPPLjXWgO7Fybe9UAUsod4OM?=
 =?us-ascii?Q?oXh5Q4CugrHCpC+stXYrrUC4CeatW7ApkpIX9x96WLn4RUNLHvMZa8beJAK8?=
 =?us-ascii?Q?yNKrhzi2b7igzCJEn+r4JDvZbWu4o4mj9y8f6O/3C7M8u99AloMbisqevVB5?=
 =?us-ascii?Q?M2iwR9f0X5zPc4tWaBzJLWHlzJkDOyc/oc/FidG6cGrfe87+3FZiHnrTu5Bn?=
 =?us-ascii?Q?ilLegUs+mxycKP6dLrc6SrL0z62tgqz2jm0vsz99Um+kM5n3mtIHwVxNrrTO?=
 =?us-ascii?Q?8oE2MXy+izcjImRfKKzzlUL+Ji9pQDorxuT17kIVJH1AsQmlLQCOmVtM+gRN?=
 =?us-ascii?Q?pPWSzBokiMYRIJF1i5XFMsPF8NCz2mE2vpqtrNKUTiUMfeWmnqsOnz84+vP7?=
 =?us-ascii?Q?PwZxf4DOKVSy5D8/ii4jwvv/y2FfCpD/QGp8creP9qhiITCOO/5lji8InkCO?=
 =?us-ascii?Q?ghVmthjFdE9MMN98sJqSEUrKbhZ2HLKJ8c4X+cvqzboYXkHnw/NV32xRjRJd?=
 =?us-ascii?Q?tWPh+PM9dkum9qd9TeWy12f73dWxeZtr0pRhP1+FGilyZT0CFLpPoXRXQhXt?=
 =?us-ascii?Q?PF7IT8HqIJ99J5pUj7CAGGzTNIV4XacorhcRxn9CiyJ32rHxm9TyT1UnyK8X?=
 =?us-ascii?Q?R0ENGsD6Ru14FkMdGcAu3L5umRGlgFFDSL/8EwktABkmtIa7hpcHSSM3gKTY?=
 =?us-ascii?Q?cC41wK/13wWIR7QpDXJNCuOrAf8HEB59SAEVOKpeStSGuOdRLEDsfXHk7WaZ?=
 =?us-ascii?Q?lQnQFyVlx7AsCKN6LX1nV92CVdaRBgseceaOJ5w6XctkhkO8UfRYueDPB/PD?=
 =?us-ascii?Q?+33e5/j34qnGzXRrCdU0P1eZByFUYcaz3cxS/l81hRA8aKzSOmeRD/Hal22t?=
 =?us-ascii?Q?YixuNmShkKczIvrv9hZ9er3uaqXCFBqtg6TgdoosGyCD+dGrbUjTbQBJIeaF?=
 =?us-ascii?Q?uWdDvfJ0Dl8DQAf90Ia3h3QLGlo3v+oPaYFRo6dC+RbPb7zK6gZ5JNhWObYJ?=
 =?us-ascii?Q?UFyY/wZjWZ1aK0PHF5EZTUFmxAq37/biSjKz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:48:08.0609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b838a318-ec7d-4de2-3e8a-08ddaac3fc16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDB3A23D1A
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

Going forward, we'll need more than just the vmid.  Add the
guilty amdgpu_fence.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 4 +++-
 22 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ddb9d3269357c..a7ff1fa4c778e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		if (is_guilty)
 			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
-		r = amdgpu_ring_reset(ring, job->vmid);
+		r = amdgpu_ring_reset(ring, job->vmid, NULL);
 		if (!r) {
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_stop(&ring->sched, s_job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index e1f25218943a4..ff3a4b81e51ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -268,7 +268,8 @@ struct amdgpu_ring_funcs {
 	void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
-	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
+	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid,
+		     struct amdgpu_fence *guilty_fence);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
 	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
@@ -425,7 +426,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
 #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
 #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
-#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
+#define amdgpu_ring_reset(r, v, f) (r)->funcs->reset((r), (v), (f))
 
 unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb5..444753b0ac885 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9522,7 +9522,9 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 	amdgpu_ring_insert_nop(ring, num_nop - 1);
 }
 
-static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
@@ -9579,7 +9581,8 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 }
 
 static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
-			       unsigned int vmid)
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ec9b84f92d467..4293f2a1b9bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6811,7 +6811,9 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
@@ -6973,7 +6975,9 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 1234c8d64e20d..aea21ef177d05 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5307,7 +5307,9 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
@@ -5421,7 +5423,9 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
 	return 0;
 }
 
-static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
+static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d50e125fd3e0d..c0ffe7afca9b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7153,7 +7153,8 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
 }
 
 static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
-			      unsigned int vmid)
+			      unsigned int vmid,
+			      struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c233edf605694..79d4ae0645ffc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -3552,7 +3552,8 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring)
 }
 
 static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
-				unsigned int vmid)
+				unsigned int vmid,
+				struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 4cde8a8bcc837..4c1ff6d0e14ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -764,7 +764,9 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *guilty_fence)
 {
 	jpeg_v2_0_stop(ring->adev);
 	jpeg_v2_0_start(ring->adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 8b39e114f3be1..5a18b8644de2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -643,7 +643,9 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *guilty_fence)
 {
 	jpeg_v2_5_stop_inst(ring->adev, ring->me);
 	jpeg_v2_5_start_inst(ring->adev, ring->me);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 2f8510c2986b9..4963feddefae5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -555,7 +555,9 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *guilty_fence)
 {
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index f17ec5414fd69..327adb474b0d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -720,7 +720,9 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
+				unsigned int vmid,
+				struct amdgpu_fence *guilty_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 79e342d5ab28d..c951b4b170c5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1143,7 +1143,9 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
-static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *guilty_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 3b6f65a256464..51ae62c24c49e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -834,7 +834,9 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
-static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
+				  unsigned int vmid,
+				  struct amdgpu_fence *guilty_fence)
 {
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 35b0a7fb37b96..83596e032ee35 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1670,7 +1670,9 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
 	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
 }
 
-static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
+				   unsigned int vmid,
+				   struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 9505ae96fbecc..6cdaf60826923 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1538,7 +1538,9 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a6e612b4a8928..1f7e21994b796 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1451,7 +1451,9 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
-static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 5a70ae17be04e..43bb4a7456b90 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1537,7 +1537,9 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
-static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int i, r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index ad47d0bdf7775..b5c168cb1354d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -802,7 +802,9 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
-static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int i, r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index b5071f77f78d2..083fde15e83a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1967,7 +1967,9 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 5a33140f57235..57c59c4868a50 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1594,7 +1594,9 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	int r = 0;
 	int vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 16ade84facc78..4aad7d2e36379 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1465,7 +1465,9 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index f8e3f0b882da5..b9c8a2b8c5e0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1192,7 +1192,9 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
+				 unsigned int vmid,
+				 struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-- 
2.49.0

