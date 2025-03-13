Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B645EC282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 14:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B95A10E8DA;
	Thu, 13 Mar 2025 14:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OrcBwmX6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B7E10E8D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 14:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HqOFbsAl4gRAWwuNj7doohDosLVgIcsnDdVh+9Vm0eteuDHH6C+oTzm2A2VLVsI9R/xWvImBWJc0anPXLndOHeCTUuXt+b6aUaNA0r6ANfpEBouwaKeob4q/RZof3re2M24aQVa/h+BiURvEgPWevIGML2LSdikIbTDjUPL+cdtlvXnuZJyWxGDD2dtUzKDU0TTCyAKzurp6Pnug0LlGw3nftWRxf58gGhkN8CWbEqn+bpVqLpRj8APqSxT7K/qCyMuyjY23cL4551y2v3rNT/h1RRs0TdvKtYnTi43hP0PnEXwEp9i4iUSCi+J8VeK/pIv+xM7isog6su4y3hWzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mydzsa8SN90oI/R8TqOflIVeVxwMriakLall69yZ+iA=;
 b=PRy4Gtx7XQ9MCx83p1Ot/7bxnW8ygZWHuRtbuUL80ndinT6HHpPV9MSN0S41lf2VGveI9jX+MCZ+oITY8zDegKcK95NYm7XknHLjQeScaLKFy9MVb1FoLPNAPCXLtaIlKRMqDgzaT+2dMz/KVVcoMNr+5lYqldJev0F8soCpjoztJh34KdIb6pUAGY9D073Oh3gKIXWEFA6hxOoDXLT1UxsVRWngvOEqrLFHTMIB+ynMeGMQ3AUh/VH5P+5hhdMZdZ+lmgvBvK0kl8AmRZMZhea3uZ50DsFQrJca2D+5G5DpHQvfG9KJFRcoCtDfYUuD5eUmC5dSyPrTgJdATzzRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mydzsa8SN90oI/R8TqOflIVeVxwMriakLall69yZ+iA=;
 b=OrcBwmX6s+6MX0KywyK3NQzBRRx4waGTjUNgW5qVXGZh/wzAaCGXXze4XtqsxpiTPsfQ/7F3N6VAGhSHWYPAbGb7/Mi8uHV57WjzyfKIFqEMbYNpksKMH4mndVAEyfWEDXBI15IiEDCvDhGYXLi2+1bQjXstWjacq6H9RIeinZE=
Received: from BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 14:41:58 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::c4) by BL1PR13CA0334.outlook.office365.com
 (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Thu,
 13 Mar 2025 14:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Thu, 13 Mar 2025 14:41:58 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 09:41:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/11] drm/amdgpu/gfx12: add support for disable_kq
Date: Thu, 13 Mar 2025 10:41:33 -0400
Message-ID: <20250313144136.1117072-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313144136.1117072-1-alexander.deucher@amd.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: ab17207b-a9b9-4dfc-a9fb-08dd623d3551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iq7quVrdwcbNjP/3IgSaJPIdMgcnNLquJiRhD/7d1GiYL0NU3ef5d1pa073b?=
 =?us-ascii?Q?+aJvyPsmJJpsEytB7+eQL9RmRXULrUOl0U3tz22gPVrz6T3a5FtUbobiSKx5?=
 =?us-ascii?Q?9mfr5VTeNvA2KwwpDWTatdDCoVopYBEqxZx7g/Kg5nKU8Pe88uugKJbjdBdj?=
 =?us-ascii?Q?LeExBFu19Anz9xlmF8eHxOeC1Ck9EIF8ElvEnWD7MfELn1I1jZgXI2aQrn4O?=
 =?us-ascii?Q?CmnpujZRQq9D9rSU71sBH6cpHzF0kzhNm0VeGzC9D43bdLiAgczrRWlahS5S?=
 =?us-ascii?Q?yDaMxnckk68X2DIppoD8A1pvn1WAp3ym/5yHkaF008st5d37mZGKojkp8liN?=
 =?us-ascii?Q?QlYzyrznGIB3FYkud5+yJOQ3d2cjORJibZmtHzffbVohFtwwgK5UjE02sipQ?=
 =?us-ascii?Q?vLwg0s+zu6K5x/Dh5AVO+TkhNFH8kNsEXUhbGmHh6wCNssJ42z8JDfQ2V+I+?=
 =?us-ascii?Q?ekRdpXfaQg0mPT9Qi274Gm+3B60OyGCOI6iVNb8TjmEtaAF3hBahJAhEoXCn?=
 =?us-ascii?Q?QJpUYKO/w7ePO/Dls02OHfav5KVdY9qKIN2Qdc3pB0w4KT+AEWfXc6mEGsAV?=
 =?us-ascii?Q?fxrMPFaY4REcn9hkq1+mS9alvsi6jB7etGwJrWvomBJtI1ID0Aulmw7ohtvG?=
 =?us-ascii?Q?R7yOF7NMYQ3ZDz2iVKKe6j71nE1+TToNUSEAh1hBG4nenA+ln2VcFd6q3kZv?=
 =?us-ascii?Q?0EPgoV6LLlNe1mdk8xv+YGuN2WlB0A7QpRQ7Ze0EYhNvLZdW+OgH4XWxrbG/?=
 =?us-ascii?Q?UhP8U4ZfYAYWuESvNvrUeeOsqGplfXed01oALrcr2k3GoB2FFlsKo49d8FhA?=
 =?us-ascii?Q?bm9oFfZ5ppRWNMb7EhIE5ECvBTMjELZ6/PQV1eaDIPw982oo6HTYQk4ZPyV9?=
 =?us-ascii?Q?+KlhGnAO33WceR7j6gTuDnx5SLYk+A+3/YZ/TvKXLedP0JsIp+TAULlzZUjV?=
 =?us-ascii?Q?qSOrbZpym1nrPZil9aKi3i7T9jshrZtbALAsRmT9SZGk7NRj9aCmla/2Vvkx?=
 =?us-ascii?Q?pdqIQMwpWYhc66rO4TBwTa2DajLfsdjDWsB2LDorehu5OGYIS98eZCVDLfc4?=
 =?us-ascii?Q?gLv5bCJ/txaW0Bocln9eQwKrB0HIfoVt83hgx4MBiAIFAMmdbV/jqtLURXIO?=
 =?us-ascii?Q?t+93tVsL5kZu+aK4Bonejzni/xv9I7Gh7eLOFEPnZVZwtYvNrT/rWwqmkqPM?=
 =?us-ascii?Q?0T5MrkoaC1rfSeZyZ4tO5bZgcQq1yoME+9mxMVJFaHgdPTlPtucETcX2ZBhM?=
 =?us-ascii?Q?Ibtf7/t7uPLL0QIAWYP/vHIcXNUKFUuTcvTIB/uVtq7i18pd4bOL7Huw0Scx?=
 =?us-ascii?Q?AgpqnsWPugp1o6O1kRCk2Ubj5DyKBkuXjAm5iWy2hhCI6dgMHGsx69eCB8J7?=
 =?us-ascii?Q?X/owZkKEx8brfqmsCWvoK+lRq2t5s44EHM2zbQ+l5tOW+lk8lbHqF9HusRmp?=
 =?us-ascii?Q?hoGy5nDRDaDBOhIoiDNky2mBbory0VKf+/JOMIB8k1bMDK062L19Sw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:41:58.3081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab17207b-a9b9-4dfc-a9fb-08dd623d3551
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

Plumb in support for disabling kernel queues.

v2: use ring counts per Felix' suggestion
v3: fix stream fault handler, enable EOP interrupts
v4: fix MEC interrupt offset (Sunil)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 183 +++++++++++++++++--------
 1 file changed, 125 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 34cf187e72d9f..a99507e4fdb27 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1421,11 +1421,13 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 
-	/* recalculate compute rings to use based on hardware configuration */
-	num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
-			     adev->gfx.mec.num_queue_per_pipe) / 2;
-	adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
-					  num_compute_rings);
+	if (adev->gfx.num_compute_rings) {
+		/* recalculate compute rings to use based on hardware configuration */
+		num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
+				     adev->gfx.mec.num_queue_per_pipe) / 2;
+		adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
+						  num_compute_rings);
+	}
 
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_GRBM_CP,
@@ -1471,37 +1473,41 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	}
 
-	/* set up the gfx ring */
-	for (i = 0; i < adev->gfx.me.num_me; i++) {
-		for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
-				if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
-					continue;
-
-				r = gfx_v12_0_gfx_ring_init(adev, ring_id,
-							    i, k, j);
-				if (r)
-					return r;
-				ring_id++;
+	if (adev->gfx.num_gfx_rings) {
+		/* set up the gfx ring */
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
+					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
+						continue;
+
+					r = gfx_v12_0_gfx_ring_init(adev, ring_id,
+								    i, k, j);
+					if (r)
+						return r;
+					ring_id++;
+				}
 			}
 		}
 	}
 
-	ring_id = 0;
-	/* set up the compute queues - allocate horizontally across pipes */
-	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
-		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
-			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
-				if (!amdgpu_gfx_is_mec_queue_enabled(adev,
-								0, i, k, j))
-					continue;
+	if (adev->gfx.num_compute_rings) {
+		ring_id = 0;
+		/* set up the compute queues - allocate horizontally across pipes */
+		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					if (!amdgpu_gfx_is_mec_queue_enabled(adev,
+									     0, i, k, j))
+						continue;
 
-				r = gfx_v12_0_compute_ring_init(adev, ring_id,
-								i, k, j);
-				if (r)
-					return r;
+					r = gfx_v12_0_compute_ring_init(adev, ring_id,
+									i, k, j);
+					if (r)
+						return r;
 
-				ring_id++;
+					ring_id++;
+				}
 			}
 		}
 	}
@@ -3495,12 +3501,18 @@ static int gfx_v12_0_cp_resume(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (!amdgpu_async_gfx_ring) {
-		r = gfx_v12_0_cp_gfx_resume(adev);
-		if (r)
-			return r;
+	if (adev->gfx.num_gfx_rings) {
+		if (!amdgpu_async_gfx_ring) {
+			r = gfx_v12_0_cp_gfx_resume(adev);
+			if (r)
+				return r;
+		} else {
+			r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
+			if (r)
+				return r;
+		}
 	} else {
-		r = gfx_v12_0_cp_async_gfx_ring_resume(adev);
+		r = gfx_v12_0_cp_gfx_start(adev);
 		if (r)
 			return r;
 	}
@@ -3711,6 +3723,46 @@ static int gfx_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return r;
 }
 
+static int gfx_v12_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
+					      bool enable)
+{
+	if (adev->gfx.disable_kq) {
+		unsigned int irq_type;
+		int m, p, r;
+
+		for (m = 0; m < adev->gfx.me.num_me; m++) {
+			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
+				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				if (r)
+					return r;
+			}
+		}
+
+		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
+			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
+				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+					+ (m * adev->gfx.mec.num_pipe_per_mec)
+					+ p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
+							   irq_type);
+				if (r)
+					return r;
+			}
+		}
+	}
+	return 0;
+}
+
 static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -3721,6 +3773,7 @@ static int gfx_v12_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	gfx_v12_0_set_userq_eop_interrupts(adev, false);
 
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
@@ -3809,11 +3862,19 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (amdgpu_disable_kq == 1)
+		adev->gfx.disable_kq = true;
+
 	adev->gfx.funcs = &gfx_v12_0_gfx_funcs;
 
-	adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
-	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
-					  AMDGPU_MAX_COMPUTE_RINGS);
+	if (adev->gfx.disable_kq) {
+		adev->gfx.num_gfx_rings = 0;
+		adev->gfx.num_compute_rings = 0;
+	} else {
+		adev->gfx.num_gfx_rings = GFX12_NUM_GFX_RINGS;
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
+	}
 
 	gfx_v12_0_set_kiq_pm4_funcs(adev);
 	gfx_v12_0_set_ring_funcs(adev);
@@ -3844,6 +3905,10 @@ static int gfx_v12_0_late_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = gfx_v12_0_set_userq_eop_interrupts(adev, true);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -5043,27 +5108,29 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 	pipe_id = (entry->ring_id & 0x03) >> 0;
 	queue_id = (entry->ring_id & 0x70) >> 4;
 
-	switch (me_id) {
-	case 0:
-		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
-			ring = &adev->gfx.gfx_ring[i];
-			if (ring->me == me_id && ring->pipe == pipe_id &&
-			    ring->queue == queue_id)
-				drm_sched_fault(&ring->sched);
-		}
-		break;
-	case 1:
-	case 2:
-		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-			ring = &adev->gfx.compute_ring[i];
-			if (ring->me == me_id && ring->pipe == pipe_id &&
-			    ring->queue == queue_id)
-				drm_sched_fault(&ring->sched);
+	if (!adev->gfx.disable_kq) {
+		switch (me_id) {
+		case 0:
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		case 1:
+		case 2:
+			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+				ring = &adev->gfx.compute_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		default:
+			BUG();
+			break;
 		}
-		break;
-	default:
-		BUG();
-		break;
 	}
 }
 
-- 
2.48.1

