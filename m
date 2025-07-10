Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5336BC83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6B310E962;
	Thu, 10 Jul 2025 21:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TrNOPXbd";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5334D10E962
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pl4VEt+MvAsqu/PQUiXlc3K+JBbEJUV32bq5HDwdbUl1BMUxVXmsmb5KXmsWg+27cqNwl8/+60R6+BB/0V44SlScLWMtbQiKRTlVwojCOAqIKOtltDPrbuxQEfT6/XhV+IfWx9UJJ3T4OwRotS0VqTB8dO0HUjJNDt4EdXfKKg5e/E1f8pzdUx06OB8cmIh0OyqfkAfxZks6tjrO0OpQ/S1V1Z1U2REsvkbPsElZDLRb7+XwCQW/M3D+Zdm1FoXOIvvTTYfJ5N2JwqZmaIVjp0NpSNsg8YmivW7Jb6l1BzAu01opJthalLoRD7n7hv4SW+iKU5irr1+LoFRrO4U4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoUVZhaHBHKeQKLKq0k4WG6+Q6yptZRjhBC0brjfpQg=;
 b=Q/wD/rpZTRj05ILw3cOFwkNRBbDssZxot/oARDoUUsrALRhyg5bjs9geC5quxsOs0NB0J/oq1jVPDYvPkCpKSYoNJ+PJQHD8p67Y3IzFaM/WY1aLN9eHvsBnNWya4blpzq6nVkcBcqBlF1xQLyL2QHzOC0gipWdNttszgjIRKlAJVFMLUwhFyBpzIKDibVTjL/ro6r07iapuWffYSv3NpoTkBAVazb1PYlK3JV/O6hopXg4YrSWuqKaYjSaNq4KvlPPPkwYd+6LcFCVryCJWhoN8X564/cYNrVl0BgEuk8ftUfh0eHIvHh6o4b5LJpjve/SSN+ZzuRLw7Y2tghPKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoUVZhaHBHKeQKLKq0k4WG6+Q6yptZRjhBC0brjfpQg=;
 b=TrNOPXbdt20J3LVdRobu1JrqMrwLKyBMOFp2yotrIvUizLpLLcyOFMS6IC7d6ydtsAwrmlbkRn1VpKBlMjuSk7VrXoZrq6ODic48Zm2GUUqeMUqdo4tU9iKgdSCzn/d/cmhjk44ODOW7CgVHn0jpof1kVQ1/cgRpO/Nz6XvI/k8=
Received: from SJ0PR05CA0192.namprd05.prod.outlook.com (2603:10b6:a03:330::17)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 21:29:57 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::3d) by SJ0PR05CA0192.outlook.office365.com
 (2603:10b6:a03:330::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.10 via Frontend Transport; Thu,
 10 Jul 2025 21:29:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:29:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:29:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:29:55 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:29:55 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Yihan Zhu
 <Yihan.Zhu@amd.com>, Krunoslav Kovac <krunoslav.kovac@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 01/18] drm/amd/display: MPC basic allocation logic and TMZ
Date: Thu, 10 Jul 2025 17:25:34 -0400
Message-ID: <20250710212941.630259-2-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: e25cb623-228d-468b-8f8c-08ddbff8eae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1eVyBDlPGw1Kf8xtYRQSnlXwr6QmfpdJlfjifr/kGbNIS2x/33kUJVkCJP4R?=
 =?us-ascii?Q?HiBPr0GMh4Le17ZDCZmuaevyQ0HgxePNZ10noWmuI0ZMBJ5KQLqbFCgwssnj?=
 =?us-ascii?Q?xNKpaxVl4TLy0s1iur4/HOEqWNn5AOC0eSCiq08JROT4dB0/dUgG5j8+soWj?=
 =?us-ascii?Q?iVnsz5gfdDOtmIZ2TCloeb62AlTryE3TB5/ELiAzNQM+lckkzxvtGnSKTNYi?=
 =?us-ascii?Q?Jh8zIulH+tWl5A9qJmNJa/4L8C3hhXx/7Id6pxkiK0YAdSlH58DN1AVX/+9a?=
 =?us-ascii?Q?k6hm+2bSFbCVvPGuJzopcSlBDkzIxW0LMwt8zy9ZojG3tWKAq3Qbf3HHSDMU?=
 =?us-ascii?Q?c1bbAvB1U9h5wp+/Vm78PjWh/erHIsoT0Ui9N46nOPSr7jizwKt5uQN1JSLB?=
 =?us-ascii?Q?AaWW8nBC4Jn2jPXiShFjaD6/iIqGx6GuwMQcOFABVJC/CCmCMtTtc/+aODPC?=
 =?us-ascii?Q?qNR3FRhcfpEG0vY8UIiSCcLStLemmKwP1gn1vO88P3iZdFksm3sgHrv40yp3?=
 =?us-ascii?Q?BJDrh8bPiNzwbhypnqwvbBIoS0OYtffXEIMz9DKoMPBn8IYGIu7GLEMIbxGy?=
 =?us-ascii?Q?zfAiBTJrDNVwjIlvys8/g6tZ97dHLZwVe0OfaRocAMCYRoO47i/V48iwwOB3?=
 =?us-ascii?Q?VAiVku697AAnIuz01GqcD5Z+MMkFcBUduDH2qRaQOl50UcKIiqSa3kSpsT3y?=
 =?us-ascii?Q?2rMRe2Krofe7C5eel4nwugpJ4CKqh8f7kNCLDmY2Zs6H/yG/c9/RaNyXkPPr?=
 =?us-ascii?Q?sr+pVMI0isFIfQw8yKvnCQQ+6qSSDWQkC0k/bRNNR05EqE1anEvSkts3yfwc?=
 =?us-ascii?Q?jEIfNcNOPUr88DK4+TkaOi+h2PbCqDuuwcfx+2M5Hi9/U4obKYM7zmoA6nYZ?=
 =?us-ascii?Q?XxOerKBG1Jmnx41KGirMB2GUFjPLT87UKXY8RMIiG3RekV9pRIZoLIp1CIzS?=
 =?us-ascii?Q?G1BaIfHpCfBxE3KkfBIjMfz1AfV7wFJaChwzJvubRKMHqJz/Qe+mhjkooGEp?=
 =?us-ascii?Q?hhnu+8SgjMni1BBsmpYohZ2Mx01dw519v/IrXSuIrSZfipPNJ3I67Zih/+9H?=
 =?us-ascii?Q?pv9/h5TZb0z1KhhhlC7r1rwb9aHUmzYhYzGgQfJ24cNPkV3VDIdLK9rWR9Es?=
 =?us-ascii?Q?IInBccEmZhhlih5L2ex5z27zgXjwIA8BiKo3TJfuM0YSqmxQXne9gBxTUAkT?=
 =?us-ascii?Q?AxIXt265t1SF0/AMugCchguEihQR9w+C8uRtpDkMM+rseAoSrz4H46bqddWq?=
 =?us-ascii?Q?pTnSxsFPSTAV68a8k2mfGb9lEJBMJq93eWJEZAzQgtL4ZU+QeaoHwsewR8Hj?=
 =?us-ascii?Q?twJaUovKwidbvi20Nv4fWx4WlfK5BQSBJLQlLnKib3gQoEAX8Zu84+LePJW7?=
 =?us-ascii?Q?LpKbquu7+dT1zZ9TLzA/ORcb8GewNDKskP2e0SeBxpWMFrW3WZ0DjvlzoJTm?=
 =?us-ascii?Q?8NwbygxZwkbFEhywZSEm9SFfkMhsw05eRVKckmnwk7TpUUZRlWE9T7iTWtsN?=
 =?us-ascii?Q?PzlxAzpODUlvdnYxhJarXzExNMkIYbSe+oiY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:29:56.8748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e25cb623-228d-468b-8f8c-08ddbff8eae3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
Adding basic logic to allocate unused RMCM block and TMZ support.

Reviewed-by: Krunoslav Kovac <krunoslav.kovac@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  2 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 67 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  7 ++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    | 11 +++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  2 +-
 11 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c744aa9d830f..f37ed24b2430 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -976,6 +976,8 @@ static bool dc_construct_ctx(struct dc *dc,
 	if (!dc_ctx)
 		return false;
 
+	dc_stream_init_rmcm_3dlut(dc);
+
 	dc_ctx->cgs_device = init_params->cgs_device;
 	dc_ctx->driver_context = init_params->driver;
 	dc_ctx->dc = dc;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 47712a4aec55..883054bb18e7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -427,6 +427,8 @@ enum dc_status dc_state_remove_stream(
 		return DC_ERROR_UNEXPECTED;
 	}
 
+	dc_stream_release_3dlut_for_stream(dc, stream);
+
 	dc_stream_release(state->streams[i]);
 	state->stream_count--;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index b883fb24fa12..4d6bc9fd4faa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -856,6 +856,73 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
 	}
 }
 
+/*
+*	dc_stream_get_3dlut()
+*	Requirements:
+*	1. Is stream already owns an RMCM instance, return it.
+*	2. If it doesn't and we don't need to allocate, return NULL.
+*	3. If there's a free RMCM instance, assign to stream and return it.
+*	4. If no free RMCM instances, return NULL.
+*/
+
+struct dc_rmcm_3dlut *dc_stream_get_3dlut_for_stream(
+	const struct dc *dc,
+	const struct dc_stream_state *stream,
+	bool allocate_one)
+{
+	unsigned int num_rmcm = dc->caps.color.mpc.num_rmcm_3dluts;
+
+	// see if one is allocated for this stream
+	for (int i = 0; i < num_rmcm; i++) {
+		if (dc->res_pool->rmcm_3dlut[i].isInUse &&
+			dc->res_pool->rmcm_3dlut[i].stream == stream)
+			return &dc->res_pool->rmcm_3dlut[i];
+	}
+
+	//case: not found one, and dont need to allocate
+	if (!allocate_one)
+		return NULL;
+
+	//see if there is an unused 3dlut, allocate
+	for (int i = 0; i < num_rmcm; i++) {
+		if (!dc->res_pool->rmcm_3dlut[i].isInUse) {
+			dc->res_pool->rmcm_3dlut[i].isInUse = true;
+			dc->res_pool->rmcm_3dlut[i].stream = stream;
+			return &dc->res_pool->rmcm_3dlut[i];
+		}
+	}
+
+	//dont have a 3dlut
+	return NULL;
+}
+
+
+void dc_stream_release_3dlut_for_stream(
+	const struct dc *dc,
+	const struct dc_stream_state *stream)
+{
+	struct dc_rmcm_3dlut *rmcm_3dlut =
+		dc_stream_get_3dlut_for_stream(dc, stream, false);
+
+	if (rmcm_3dlut) {
+		rmcm_3dlut->isInUse = false;
+		rmcm_3dlut->stream  = NULL;
+		rmcm_3dlut->protection_bits = 0;
+	}
+}
+
+
+void dc_stream_init_rmcm_3dlut(struct dc *dc)
+{
+	unsigned int num_rmcm = dc->caps.color.mpc.num_rmcm_3dluts;
+
+	for (int i = 0; i < num_rmcm; i++) {
+		dc->res_pool->rmcm_3dlut[i].isInUse = false;
+		dc->res_pool->rmcm_3dlut[i].stream = NULL;
+		dc->res_pool->rmcm_3dlut[i].protection_bits = 0;
+	}
+}
+
 /*
  * Finds the greatest index in refresh_rate_hz that contains a value <= refresh
  */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ce1957c7862f..6825b8a9af59 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -246,6 +246,7 @@ struct mpc_color_caps {
 	uint16_t ogam_ram : 1;
 	uint16_t ocsc : 1;
 	uint16_t num_3dluts : 3;
+	uint16_t num_rmcm_3dluts : 3;
 	uint16_t shared_3d_lut:1;
 	struct rom_curve_caps ogam_rom_caps;
 	struct lut3d_caps mcm_3d_lut_caps;
@@ -1294,6 +1295,12 @@ union dc_3dlut_state {
 };
 
 
+struct dc_rmcm_3dlut {
+	bool isInUse;
+	const struct dc_stream_state *stream;
+	uint8_t protection_bits;
+};
+
 struct dc_3dlut {
 	struct kref refcount;
 	struct tetrahedral_params lut_3d;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 341d2ffb64b1..5fc6fea211de 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -579,6 +579,17 @@ bool dc_stream_set_gamut_remap(struct dc *dc,
 bool dc_stream_program_csc_matrix(struct dc *dc,
 				  struct dc_stream_state *stream);
 
+struct dc_rmcm_3dlut *dc_stream_get_3dlut_for_stream(
+	const struct dc *dc,
+	const struct dc_stream_state *stream,
+	bool allocate_one);
+
+void dc_stream_release_3dlut_for_stream(
+	const struct dc *dc,
+	const struct dc_stream_state *stream);
+
+void dc_stream_init_rmcm_3dlut(struct dc *dc);
+
 struct pipe_ctx *dc_stream_get_pipe_ctx(struct dc_stream_state *stream);
 
 void dc_dmub_update_dirty_rect(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index b203ed020cd5..a0829bc0708a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1313,6 +1313,7 @@ struct dc_cm2_func_luts {
 		bool mpc_3dlut_enable;
 		bool rmcm_3dlut_enable;
 		bool mpc_mcm_post_blend;
+		uint8_t rmcm_tmz;
 	} lut3d_data;
 	const struct dc_transfer_func *lut1d_func;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index baed31611477..705b98b1b6cc 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -86,11 +86,11 @@ void hubp401_program_3dlut_fl_width(struct hubp *hubp, enum hubp_3dlut_fl_width
 	REG_UPDATE(HUBP_3DLUT_CONTROL, HUBP_3DLUT_WIDTH, width);
 }
 
-void hubp401_program_3dlut_fl_tmz_protected(struct hubp *hubp, bool protection_enabled)
+void hubp401_program_3dlut_fl_tmz_protected(struct hubp *hubp, uint8_t protection_bits)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
-	REG_UPDATE(HUBP_3DLUT_CONTROL, HUBP_3DLUT_TMZ, protection_enabled ? 1 : 0);
+	REG_UPDATE(HUBP_3DLUT_CONTROL, HUBP_3DLUT_TMZ, protection_bits);
 }
 
 void hubp401_program_3dlut_fl_crossbar(struct hubp *hubp,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
index 6e1d4c90ddd4..608e6153fa68 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h
@@ -333,7 +333,7 @@ void hubp401_program_3dlut_fl_crossbar(struct hubp *hubp,
 	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
 	enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r);
 
-void hubp401_program_3dlut_fl_tmz_protected(struct hubp *hubp, bool protection_enabled);
+void hubp401_program_3dlut_fl_tmz_protected(struct hubp *hubp, uint8_t protection_bits);
 
 void hubp401_program_3dlut_fl_width(struct hubp *hubp, enum hubp_3dlut_fl_width width);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 9ad29be925e2..39910f73ecd0 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -335,7 +335,7 @@ static void dcn10_log_hubp_states(struct dc *dc, void *log_ctx)
 		struct dcn_fl_regs_st *fl_regs = &s->fl_regs;
 
 		if (!s->blank_en) {
-			DTN_INFO("[%2d]:  %5xh  %6xh  %5d  %6d  %2xh  %2xh  %6xh  %6d  %8d  %8d  %7d  %8xh %5x %5x %5x",
+			DTN_INFO("[%2d]:  %5xh  %6xh  %5d  %6d  %8xh  %2xh  %6xh  %6d  %8d  %8d  %7d  %8xh %5x %5x %5x",
 					pool->hubps[i]->inst,
 					fl_regs->lut_enable,
 					fl_regs->lut_done,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index c9454fe1cd05..f0d7185153b2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -67,6 +67,8 @@ struct resource_context;
 struct clk_bw_params;
 struct dc_mcache_params;
 
+#define MAX_RMCM_INST  2
+
 struct resource_funcs {
 	enum engine_id (*get_preferred_eng_id_dpia)(unsigned int dpia_index);
 	void (*destroy)(struct resource_pool **pool);
@@ -286,6 +288,7 @@ struct resource_pool {
 	struct hpo_dp_link_encoder *hpo_dp_link_enc[MAX_HPO_DP2_LINK_ENCODERS];
 	struct dc_3dlut *mpc_lut[MAX_PIPES];
 	struct dc_transfer_func *mpc_shaper[MAX_PIPES];
+	struct dc_rmcm_3dlut rmcm_3dlut[MAX_RMCM_INST];
 
 	struct {
 		unsigned int xtalin_clock_inKhz;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index b610beb075d5..cee29e89ec5c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -282,7 +282,7 @@ struct hubp_funcs {
 	void (*hubp_enable_3dlut_fl)(struct hubp *hubp, bool enable);
 	void (*hubp_program_3dlut_fl_addressing_mode)(struct hubp *hubp, enum hubp_3dlut_fl_addressing_mode addr_mode);
 	void (*hubp_program_3dlut_fl_width)(struct hubp *hubp, enum hubp_3dlut_fl_width width);
-	void (*hubp_program_3dlut_fl_tmz_protected)(struct hubp *hubp, bool protection_enabled);
+	void (*hubp_program_3dlut_fl_tmz_protected)(struct hubp *hubp, uint8_t protection_bits);
 	void (*hubp_program_3dlut_fl_crossbar)(struct hubp *hubp,
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_y_g,
 			enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
-- 
2.43.0

