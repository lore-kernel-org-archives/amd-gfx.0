Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE99606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SlzXX+eN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B36110F825;
	Tue, 17 Nov 2026 17:13:54 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971FE10F823
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3nZLOtBp0ErH+Fm7Li47zHwUFFoa4SFizakIydgW7hkt5rEKnE/5DsqgQFflFKwhSR9xXy5+fOiJCe9GTkW+t/fqja/QrkahrX0oLWU4cMCsUCUZ08zLBIJs384J5tILD+x6riPlr/eY4/NTRsPLot+QsGJ5ebmZSP7ddnqjrAE7HMxaRo26FuVIntxICi74ec7rnuK8tpMkY5uLRE0v62PGZBxaMIn2/82NOAhEAG898u7a1yHzMdt4Q2D0m5uyQuewKjSHcbfGT1WdRT8kLexs1gwBm8LKA0VyA5PIngCWWNq5Y4UZq8VzBgjDy05xF1Cb+9wVblJoOc/OTNShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6SZPnfd/eJPd0OB8QbJWymUYftj2RhtLkDP4Y5mfGI=;
 b=sY+ptO+2KDplA5M5gfA+5uyHjGoC9HdLbL54d40IyIx+PlxbYrDiEI/vNqCNDVBztmQ/n7DcO1NXP+fGSjeNr25KZmFtciVvdnmSLSooXpZmU3sKD8xeadZXFD1r1NUJZhF+KbOHHVYxIpPs4tpDI99vSeRk+Zy4QNBd5Q2LhyEVYjyyHWt3Q6Y1nCF8QERwd/sZ5FWQGYkC55fwG043oQL29atkD7m1uJo1ykbXVzupUoJiAJ7zq628peJ+L6Uwk1FHdIMLygdvWaUssfJsdyHLXEzVwguhAvdjKYkG/d5JCShBovCZ4m8esCW3VRt0bgjQ3Z7Y4Q+fjYQBsw4XSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6SZPnfd/eJPd0OB8QbJWymUYftj2RhtLkDP4Y5mfGI=;
 b=SlzXX+eNFQY4hlOJLkwqY49s+zv8atTuZR19C9/A5CQay1L69J370uhyD/7g1dpzqL49Dfcw21CgVnAi2HFCIof/vInNHUKdIEyfNr9RxTl9zwaMyHdi1O62sXrD3Ugwj0x2RQJhdtUbfvrSB7IF01T/oe3xMN6PZOMve2d/CDI=
Received: from DS2PEPF00004558.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50f) by MN0PR12MB5812.namprd12.prod.outlook.com
 (2603:10b6:208:378::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:13:02 +0000
Received: from PH3PEPF0005961C.namprd05.prod.outlook.com
 (2603:10b6:518:1::24a) by DS2PEPF00004558.outlook.office365.com
 (2603:10b6:f:fc00::50f) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.1 via Frontend Transport; Tue, 17
 Nov 2026 17:13:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH3PEPF0005961C.mail.protection.outlook.com (10.167.243.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 17:13:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:13:01 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:12:52 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Samson Tam <Samson.Tam@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 06/33] drm/amd/display: add extra 0.25 line reserved for
 TSetup/TCalc inefficiency
Date: Tue, 17 Nov 2026 05:50:43 +0800
Message-ID: <20261116215641.2800595-7-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961C:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de57bf8-4738-4aa7-f052-08df44ce0969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|6133799003|22082099003|18002099003|261009223027099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|56012099006|11063799006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: ItrkyNvWMoq69gguZpulPZHmpxnGwaAl/OJolmgFm8oXxLmqExw8GjdUcgAqTyVtyGI2CY4NETwgEnFquVEAJbglT8NgN24QPOEbofAcCyBDg8GO2MHGX/wlo7LXOJro9e5HQRlJTMUfzc21I2nWDqpQiU0jF1/g0PRMAM66UVPt0RfUg9efcxEL34Jueuz0xfK0deqaQ6KbiRidEus6Yz/UITJwsDDaR0Jlu6I8PsQnKUYlalQW2RQf261kdgXdyPu1RbeCc0AGF3W2vIHx4/mIMG0+rSn27FeFAI5MhXTAWVq0/uvVgvWbT5Kx9x7WAgBnAQ4socxJAnHApvGVzoYlPsYLtwc+pOuzA7/uzJZGpYB/KBLeSTfywHwal15VrTA1qXX3Gam9+jlhXzJWfXYV+nzBN101k/jtbqzj3l9XNoh0LTQ3Pe6akUC2Vhx/pKDeGnqQLO3a7bPdRFXEeV8SGcQ5HFYVheZDGdU2v+Z5fnNhas/E0SKUW4lXuWW/tUVh9u5tykvAzi/OqpuRZ9aUr75OOHFhkGgKx+1bYjBgEmZElP7XNVkBDl5o/KEVYl6QpKMdP2pxZUVLDbk3HCPZ3I7qX3d2af8Ls2X5NZZIUr/y8rJ+B/S+crhBv24Mq0tYvZN+4EuCCzIgokoRFFXaaDd/XxqgyQkT8+y2JZhd7/uW7Dxci/T3ZA22UxYFKeyafhm7qXAYt18e4pjXTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261009223027099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cVzqtedctY/v8zdTVkMyMEtnqZcll1zdj7VjRcvv0HOKw7wUYYXwo216bzM+d6wtVPc+b43s2rm6iLKpcTUrrmFdRUXlbrbgfDWszMFkSsjUvXhz2OX1RXywZyG90CaX9SFbNAv8q/uHk7Iy3RmpwqWsMBc7+5Zig6TELWsu1bw8fkn6883+OeBoGEtG4wwloWIvLRYtZCIo/UdaoMhAZigqQGeHM0ETiiHnacr4X6JjuoVaDD1Tm7mysw32vFDVPi3SH1ifPg3wyFzS8aa66IUsUYMwsNYuw5phwvNMXmo8DWWnpSPm5PEHelLDjwlycnuUuQBDfCMN7ZuKoLPlhwTyySvlKnyqH1Ad3OMiDQjJ6KGc5UvkL8oNeQ2xE80DUPRUrVIHYbv/94wUoGbR8Ng5U5hQIRZQPt0IE5aFS+vMtV2ttnVgN0khAk5AR615
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:13:02.0452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de57bf8-4738-4aa7-f052-08df44ce0969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF0005961C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Some four display configurations fail to light up all displays,
 failing during prefetch validation.

[How]
Add extra 0.25 lines for min_vblank_unreserve_otg_vlines to account
 for inefficiency from TSetup/TCalc

Also fix nom_vtotal and allow_end_otg_vline calculations.  Not related
 to display config issue.

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c   | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
index c4db8ff3ee30..71407eec2d83 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c
@@ -409,8 +409,8 @@ static bool dcn6_update_worksheet_for_pstate_admissibility(struct dml2_optimizat
 	const double vblank_ratio = 0.8;
 	const double min_vblank_unreserved_ratio = 0.15;
 	const double min_vblank_unreserved_time_us = 50.0;
-	// min reserved for prefetch + 1 line lost for max vstartup
-	const unsigned int min_vblank_unreserved_otg_vlines = 4 + 1;
+	// min reserved for prefetch + 1 line lost for max vstartup, and +1/4 for inefficiency from TSetup/TCalc, in quarter OTG vlines
+	const unsigned int min_vblank_unreserved_otg_vlines_x4 = (4 + 1) * 4 + 1; // 5.25
 
 	unsigned int plane_index, stream_index, stream_index1;
 	double ideal_disallow_time_us, disallow_time_us;
@@ -464,7 +464,7 @@ static bool dcn6_update_worksheet_for_pstate_admissibility(struct dml2_optimizat
 				vblank_time_us = display_config->stream_descriptors[stream_index].timing.vblank_nom *
 					per_stream_pstate_meta[stream_index].otg_vline_time_us;
 				min_unreserved_vblank_time_us = math_max2(
-					per_stream_pstate_meta[stream_index].otg_vline_time_us * min_vblank_unreserved_otg_vlines,
+					per_stream_pstate_meta[stream_index].otg_vline_time_us * min_vblank_unreserved_otg_vlines_x4 / 4.0,
 					math_min2(vblank_time_us * min_vblank_unreserved_ratio,
 						min_vblank_unreserved_time_us));
 
@@ -718,7 +718,7 @@ static void dcn6_build_pstate_meta_per_stream(const struct dml2_display_cfg *dis
 
 	/* common */
 	stream_pstate_meta->valid               = true;
-	stream_pstate_meta->nom_vtotal          = stream_descriptor->timing.vblank_nom + stream_descriptor->timing.v_active;
+	stream_pstate_meta->nom_vtotal          = stream_descriptor->timing.v_total;
 	stream_pstate_meta->otg_vline_time_us   = (double)timing->h_total / timing->pixel_clock_khz * 1000.0;
 	stream_pstate_meta->vblank_start        = timing->v_blank_end + timing->v_active;
 	stream_pstate_meta->nom_refresh_rate_hz = timing->pixel_clock_khz * 1000.0 /
@@ -837,7 +837,10 @@ static void dcn6_build_pstate_meta_per_stream(const struct dml2_display_cfg *dis
 		stream_pstate_meta->method_vactive.common.allow_start_otg_vline =
 				timing->v_blank_end + stream_pstate_meta->method_vactive.max_vactive_det_fill_delay_otg_vlines;
 		stream_pstate_meta->method_vactive.common.allow_end_otg_vline =
-				stream_pstate_meta->vblank_start -
+				stream_pstate_meta->vblank_start +
+				stream_pstate_meta->nom_vtotal -
+				stream_descriptor->timing.v_active -
+				stream_descriptor->timing.vblank_nom -
 				stream_pstate_meta->blackout_otg_vlines +
 				stream_pstate_meta->method_vactive.reserved_blank_required_vlines;
 	} else {
-- 
2.43.0

