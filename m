Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4DBC47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EDD110E785;
	Wed, 28 Feb 2024 18:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="250LYjMI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8AD110E632
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZJ8Q6J7qyLlbsiGYKdb9rm7NW0krlp9zh+KMdDFa581Ixbg5XaOlBfIf5mKd1MnilqaLv71ynDzrba7Kwkzlw8pnoMyhDloahi9Sk5u5a0MGRliLtzooDMiYagZsH9irujT3BmPZxOjOtryW6nIkODxCkYSxxPj/knmG2YG2WHYU5XFFUPCNnlCP10Q3XbVoJzb/LmSkkyoyx0MSyHDPkajTveDovh9KD835y+Y14cl5cBcEbT1a6CUeGHshbJ+5jsNX5MAletthh/JgRmuKiOOF7vJrPUBkFBbSA0HaKq/CvRmMEG9fHRbHLQmSCWNIHy2KzD33cecyGQmpyEkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5p+rnMcJnvaxYegWSw0PtsNHaW8sS2Bf3RVTufB31FA=;
 b=EyCAAnMEcrzK7w4Sa+ZQ2e0e9cTzSZvXIIC3cgQRDmc9+f/GsaQYjz7TL1OYOECjj6xMBrttBJ1hF3KTghOYsU3A+sSwDTvVBtaa2z6VIp8+LmKxTNZDDFs8XZabN5fV6Ya5XFgzCy2KMQ0EjWimJ1W2/IHFfXaCwn7t8NB2MFJ8tKf20deBT0mPnLNL6lQYt3bHjxd49eIOgpNIF8gKmk3srJJqM5ev4giG7eFcZeezPAgshf6s3Z/tM5bIW1Yr8RgTp4gifKYqy1eL3LBfyE5qDbZ8wV7cszgI6tiCMoE6LixgzcQ+sWpifW6gfsPjlPc5uh+dFedg8SC7JG0ghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p+rnMcJnvaxYegWSw0PtsNHaW8sS2Bf3RVTufB31FA=;
 b=250LYjMIzvO1KgPxN+EdQleIkGpjt8JOW0yH7BW081V/LzF8NR6OymSx7Jk4c4MxiswY46dIhUZA8vB/1RKLsjVkMBVo8xA2sYuLeZIh2K6YiF5dRnSMTKcQbeJMzE/s5UPs8wVpuP0unoEERgZ2aUYNpNntAgeH8jcJRRgrqNA=
Received: from SN7PR04CA0049.namprd04.prod.outlook.com (2603:10b6:806:120::24)
 by PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:46:52 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::1a) by SN7PR04CA0049.outlook.office365.com
 (2603:10b6:806:120::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 18:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:46:52 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:46:50 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Alvin Lee
 <alvin.lee2@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 27/34] drm/amd/display: Lock all enabled otg pipes even with
 no planes
Date: Wed, 28 Feb 2024 11:39:33 -0700
Message-ID: <20240228183940.1883742-28-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: b53dcce8-aab7-4f46-54f5-08dc388da152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3LG9zy0GRXPnngiFOFES5SfkCf8PeDTZzy5EXnEMFrFkTjvAw8GCkBlTZgYHzIHTvJf3w2syuzJcadCuyegxiOIWYgAD93L7ONSTZg4k+GFmGHtnrXCAeFLzurrosSd+N/MTPXSRo+YWxxVoV+oO/AzpDX6YQJeaxfks19hY2t923M9r57LmC4OyWbdBtcGu8iwzDKbZZxHglOTm7X6z+//EMvqrGx2GoaBaDmm3Y7ea+EngoguYAbodBfO1pk44HLN4O8iHHT0B+nBsleZZFy8I62jOd08iCbJKbXYSFeMFfD04Gn/zsEi+teGVWK/oxmPcF6pJ+6vSwruYCfdELDod3dcDy04xZynVgivZGmL5PRtcirAfLu1PcZ3U7ZvvN70wimJVrQbswjHIzaKCNbbvYIrSGop4BpMhy4agCu8XH/d8ydMafBcUbbCP9LRCwsPKuplVirYa0j7DItzS+0D91igJAuavrwYWxTLD/2pn0gZN0rK062tH9weFKoJsk/6ZqKHFTpZC39wm4Oym4ELs2x9EKli4YFKigfTqu2De0Rk8DrM4q6QI1kJ75V7LcnLzypb/xom9WSR0zAzTjvA6MCDZXnUqgZrNFxfNo/f4/iSldDltotgwbmmZI6JxlSrjiZ0O29l0oqfhZWyUf+SbiITuQTir43ScsRXjmQfIryaioevG1qmVKjfuqqKEAk+3LwL4XW9OiNwin/E/LXfmuiqE81cxpgOQ6fOR9XPZkKp0ykNy3fX+LVI3KhN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:46:52.7214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53dcce8-aab7-4f46-54f5-08dc388da152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799
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

From: Wenjing Liu <wenjing.liu@amd.com>

[WHY]
On DCN32 we support dynamic ODM even when OTG is blanked. When ODM
configuration is dynamically changed and the OTG is on blank pattern,
we will need to reprogram OPP's test pattern based on new ODM
configuration. Therefore we need to lock the OTG pipe to avoid temporary
corruption when we are reprogramming OPP blank patterns.

[HOW]
Add a new interdependent update lock implementation to lock all enabled
OTG pipes even when there is no plane on the OTG for DCN32.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 23 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  2 ++
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index b890db0bfc46..c0b526cf1786 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1785,3 +1785,26 @@ void dcn32_prepare_bandwidth(struct dc *dc,
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
 	}
 }
+
+void dcn32_interdependent_update_lock(struct dc *dc,
+		struct dc_state *context, bool lock)
+{
+	unsigned int i;
+	struct pipe_ctx *pipe;
+	struct timing_generator *tg;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+		tg = pipe->stream_res.tg;
+
+		if (!resource_is_pipe_type(pipe, OTG_MASTER) ||
+				!tg->funcs->is_tg_enabled(tg) ||
+				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM)
+			continue;
+
+		if (lock)
+			dc->hwss.pipe_control_lock(dc, pipe, true);
+		else
+			dc->hwss.pipe_control_lock(dc, pipe, false);
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index 069e20bc87c0..f55c11fc56ec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -129,4 +129,6 @@ bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 void dcn32_prepare_bandwidth(struct dc *dc,
 	struct dc_state *context);
 
+void dcn32_interdependent_update_lock(struct dc *dc,
+		struct dc_state *context, bool lock);
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 2b073123d3ed..67d661dbd5b7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -58,7 +58,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.disable_plane = dcn20_disable_plane,
 	.disable_pixel_data = dcn20_disable_pixel_data,
 	.pipe_control_lock = dcn20_pipe_control_lock,
-	.interdependent_update_lock = dcn10_lock_all_pipes,
+	.interdependent_update_lock = dcn32_interdependent_update_lock,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn32_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
-- 
2.34.1

