Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13813C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A0310E856;
	Thu, 25 Jul 2024 15:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DdGWnZrA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2C510E863
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5qjRyWrtN+Q0DEduspWNb9Wi4sxXVZRALzLR59tFQZek8hWlsJ4gY8a1sAB2waRQWw2bPXBrK8vEP+BGW+KG3vzSmpP8hDWf+Zem9fuNxUx6mE3yx42nb8XTIKulocWiRDfcm2tQ6jAckgtyxB5NJ5fTo19h9zP/d4UVoz4VOcF/BaP4KdjWbyOlZUoSJXcMfJxKxlVTjP7yUWLuIYD0IRLTQG44/kz4ShQ908z4uTGU5R48IOrHv2nioiA0i9ALy8zbK7LDHL4nqQ2XOXAE2/rn31EZWp3wVe9ndglwkZQj+n5Gbz6ScJCnKu6l/isBtr3LBENAX/S9lkMdABzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxPHNDsPNppJoHSxRF0zSGhzQP9GnTMRXPzhkaloIDQ=;
 b=QETz3jjzKBpXyFDG5oKhsM3n0kU32BPL17QMWo8Z2b4twhYURb2t+0Zff1BfsxJEEjdi0V7okU31SDGF2cQulDJyzZO0xGnsYI4+z2gVaVvKfo2AxE0KH4miVuXEb7g+G8F8TNyxnIJJ2LzWuYvHkaTLRfZmywVWiAnumS7owJaehnZcDE5mCUBCi+DsNThmrJRRJMxM7OKcxAID7WJDnOW15bERKgYBSjWndECa547lds3+NiWamUaRdxHxPHccOlLgBsPho1nE/tRnecwSkkbUnOyfAnmf35h1Tz0+ILQPv8L1mjsK7SOr2tTNjGfa9DlYTDKmb2h8B0WntKZeQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxPHNDsPNppJoHSxRF0zSGhzQP9GnTMRXPzhkaloIDQ=;
 b=DdGWnZrAcxssXyBWuQUBycD+319xE6lJi29p2q/woRRqZZcD45gbQRYjBUzevb2doFuU40+Qs9PYxcpfpRE6kVPOAD31L6WLG4dc+LFRZ+5m0sg3dgg3FIrTHDCSGuFcLGSeHPItinlWmGrjtLUYY2/ddl9kzUSwFCv8Zv2RM9g=
Received: from CYZPR10CA0003.namprd10.prod.outlook.com (2603:10b6:930:8a::15)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 25 Jul
 2024 15:01:27 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::de) by CYZPR10CA0003.outlook.office365.com
 (2603:10b6:930:8a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiadong Zhu <Jiadong.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/53] drm/amdgpu/gfx9.4.3: implement reset_hw_queue for
 gfx9.4.3
Date: Thu, 25 Jul 2024 11:00:32 -0400
Message-ID: <20240725150055.1991893-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: b96fd859-6384-4bd4-2063-08dcacbaa85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J0LbKy1cTzFCbCKiHc0VK5I9wnGzsFMC5fmeawgfuwDgBEgJxBV0Zz8/C5sI?=
 =?us-ascii?Q?Q6Fti6MO5tpVIN/F67oedtsMNmxts5+042C9FbbMr8I5rc4T8/1pn6833Zbt?=
 =?us-ascii?Q?rzgYTzY3sqvWAh3jm0T8wp6tsH+KRPMT1cjMgyywn6dPQ53j9GrAKJrBFAel?=
 =?us-ascii?Q?Xm9LmnZV79qlPqoQQaU+S1FEojvd03clDelz3oH1xZRblisHd+5AVShCrvCY?=
 =?us-ascii?Q?iySHiKDaHcf42KMlyQ5RXvuWYOVtdk0oSu9LoOqREVFoBk75b/BPMI6ge+1W?=
 =?us-ascii?Q?zA6q/9X0+qzIZp0C1m6zePEvebxbiz6smxW7gubt5ky2EdOA7vcQ9oECpYdg?=
 =?us-ascii?Q?4Vl2GPotfsyTH+CV2JzxZCpCxRbjWsDTRY40mcpgdGYWjn2MN0TpUMZO/e8Q?=
 =?us-ascii?Q?SmRcd+diXwPFPuKAiC5x9SsRhsAfElcWnuDsaOlxSF3TwZniLttRJqHy9UdN?=
 =?us-ascii?Q?3Cszy0i2M3uQLt4xi5Mz3N2SdnJ/J62dtYdffRX2MjSLBdyN35kJwDOtVtMY?=
 =?us-ascii?Q?hoyNuIXsuKsamtAFg4PUyts6z3INVioNgf9CgDVPnIQQ28YSOtbO0LGN2yMH?=
 =?us-ascii?Q?nmYQy4lLlbHha+ehvjo2Lm6Gkm2id0UlG55W2UbGUYXfvAJIrfXpYStuEDWX?=
 =?us-ascii?Q?5rbJany/Z7XeX8oREP0RIqtFw8bX4+5t1u0DsqvgAYhHGGGl7lYcG+/MvL3W?=
 =?us-ascii?Q?FXnWa1l45LCLj23zXRLVocHgNMh5fn13eA5D8csN+YnS4SmoleiI8EXngGqL?=
 =?us-ascii?Q?l0QFNI405/jtPAHTnnTiujzTDh0chItwNV18ShKiBOy84bNAfynrS4Q6nIKZ?=
 =?us-ascii?Q?/ALYkxeleL284P5oncbqYH3C7KG0DgEn8LIibvynaMGdO7P3ek3GIxhEPOHV?=
 =?us-ascii?Q?YCoNU8xo5eIRvs/w/buvJmEo4Uv9rQIWrFl+QZggk5WlOdKcUhDlV28wEnEj?=
 =?us-ascii?Q?ZyahK9GpZAtlumEZladV1ZvN/EmIa//Ff1am8cAYAouBkzoU68DkFcuLEjCe?=
 =?us-ascii?Q?b1ygnLFnQ+LOZfpYyttA3qs7/q+pRdMsCiDSB98g40qqawUky6GIGgYHT3Wb?=
 =?us-ascii?Q?XlNSHLVr04xpFhNMbauoHh1p3f/MfJWcDgjJfzF7t6Tqao18wzj51ki4W3OQ?=
 =?us-ascii?Q?Rq+37g0or1KQUEXU0NndDN+h0J92Fvy6QaYCyuQQ8suWBHUFLNWKUm8unMlk?=
 =?us-ascii?Q?WxH6USSnHj0UXaIOEkjxI0YhXmIJoFfOjhxIQjh6N7TmGrYi8g5n42TF5bYJ?=
 =?us-ascii?Q?4tJ1Bxfuy0lwSzwz142z6Y6P2SezhIx1siBaQNzU/h0X1Bgl9vPy+/JswwIr?=
 =?us-ascii?Q?C6ZF4dlR04RRKzPVzW92BpWoDD8mDdow8RvM2N6muW4qrZnHS7UE1Foh7w4Z?=
 =?us-ascii?Q?3JvV10DfudJ1yl+LUx/XIJoaxmlZpD0Y/n5Gmtdo0gmUqrRAU/YOujCaBA2D?=
 =?us-ascii?Q?6TzG5AA7T5DO0eBBbQm2F6cq0mhSlbdn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:26.6997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b96fd859-6384-4bd4-2063-08dcacbaa85e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Using mmio to do queue reset. Enter safe mode
before writing mmio registers.

v2: set register instance offset according to xcc id.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a0ff18dd4acf..221a7e1725c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -71,6 +71,8 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				struct amdgpu_cu_info *cu_info);
+static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 
 static void gfx_v9_4_3_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
@@ -182,12 +184,46 @@ static void gfx_v9_4_3_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
 			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
 }
 
+static void gfx_v9_4_3_kiq_reset_hw_queue(struct amdgpu_ring *kiq_ring, uint32_t queue_type,
+					  uint32_t me_id, uint32_t pipe_id, uint32_t queue_id,
+					  uint32_t xcc_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = kiq_ring->adev;
+	unsigned i;
+
+	/* enter save mode */
+	gfx_v9_4_3_xcc_set_safe_mode(adev, xcc_id);
+	mutex_lock(&adev->srbm_mutex);
+	soc15_grbm_select(adev, me_id, pipe_id, queue_id, 0, xcc_id);
+
+	if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_DEQUEUE_REQUEST, 0x2);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSPI_COMPUTE_QUEUE_RESET, 0x1);
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout)
+			dev_err(adev->dev, "fail to wait on hqd deactive\n");
+	} else {
+		dev_err(adev->dev, "reset queue_type(%d) not supported\n\n", queue_type);
+	}
+
+	soc15_grbm_select(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	/* exit safe mode */
+	gfx_v9_4_3_xcc_unset_safe_mode(adev, xcc_id);
+}
+
 static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm4_funcs = {
 	.kiq_set_resources = gfx_v9_4_3_kiq_set_resources,
 	.kiq_map_queues = gfx_v9_4_3_kiq_map_queues,
 	.kiq_unmap_queues = gfx_v9_4_3_kiq_unmap_queues,
 	.kiq_query_status = gfx_v9_4_3_kiq_query_status,
 	.kiq_invalidate_tlbs = gfx_v9_4_3_kiq_invalidate_tlbs,
+	.kiq_reset_hw_queue = gfx_v9_4_3_kiq_reset_hw_queue,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
-- 
2.45.2

