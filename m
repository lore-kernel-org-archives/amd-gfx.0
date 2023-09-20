Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D0ECE79A9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0436110E429;
	Wed, 20 Sep 2023 03:18:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E705610E428
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW8X/W7KYoqv7XMO5mj4d/pl8dhyoHDegwiLUSo2YFe4fPAl9RKf2TEfdeRNJxPJ4UO3Z4cHeF9oHKe+o7Jvv3s/+jYXyiIq0O4sH1ksYey7VpvNpWXN3d/MBe5ldAzH7aAUdUda6EGdIvdjIKM8XYp2MRQfjZwfmNj+7mOGsQOjZJdVnjpZy8NSRlnEYZiDnSgVW8W0UuCkWxF0Ow3oAzSknCjP6NmzWwYxcz3STNQVYVoIMFtFM1xfTx3OAgaVI+r8t0XvjgyRroRGA+at/HIW96xnIdgVpX+iSKQboRwGzPApDCOhv0ZbRhUfdG9vnQpuVT6fLxNoPMVdaj2VCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ptq6MQuZScGRLez7/g5q6eebTC5OmqoZqY1QCV8gBN0=;
 b=dlUxAlgswv/fviK6Q8/x1Pbo4p4fr362iyeXX5+LEvGRZGSoqJw41zCybEF+rUjBb5vIZP6Lv7Z5YYnoC0Y26qs882VAHsj033+xKEVjl2LcQDYM86p+uaKBNBQkkQFLPgLW6Wy2fSfvtJr5v6vfzYEKCfautcumoFSpzcadRBq00nzVKnqaoYQTypwvw6ut8tgmnMxnoUIKbZqiF4fDmm+0msn98kBrcA2nYtYphZ2riXG5D7rjelyU7Wy6HokQx6AQe700Cmg5J6PTqjrXoi016KUK3qccN1RX+zoCz0gFwxf4+S0rdgveesAnZ72zN5kcnc3DO034LJWOY/UA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptq6MQuZScGRLez7/g5q6eebTC5OmqoZqY1QCV8gBN0=;
 b=NP/a9booOEC33TzlOs2eKZ2wwT+VERtPdUW6B2Iwknp3R8tQ8VEp+lreoRtqVJ7BUkwjBYbnDTsgFT+e/ktL1qqam1ObZnDX6413L8D6tcdeQPcKyjGR4OPbCgHMp8aVaSZjaLj5YlghDvnbOm3Qg59sk30yrgTRimCANC10A1g=
Received: from MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 03:18:49 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::95) by MN2PR08CA0019.outlook.office365.com
 (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 03:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:18:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:18:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:18:37 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:18:32 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/19] drm/amd/display: remove guaranteed viewports limitation
 for odm
Date: Wed, 20 Sep 2023 11:16:10 +0800
Message-ID: <20230920031624.3129206-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: e387806a-c990-431e-5a66-08dbb9884ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uox+9itDGExv8UCry0KSdWU006RCsXpYYinx1obxxxYOiMJP6stB9Pqdg3uNKt/7FqcMsFyK9w8cjo/qImRewKfosY1eoxs/r3RdQsUP4YDnDlDYOAjCGOt0nk/Hh3Nd+31LP4cDwgXtxSOPltM5/mLIeF2a1xclrRmNGQPGljMQYhTzq3Fc9UeqjDNf+zkXJQyz7F6J3JWr7a6DfAQBkzoubrntc8AxZ4aZX2x/TERFpQP5yVG9irg2SGdrE2m2YPBCYMBfGpOGn12vYijrND3NAg5sEaAEvnG6AmaE0+mmYkNktl/1VKnqnFbz+NGHYB0gb1yyFaSts3501yKc1/v1qVUYREdrLESgkY/vQP3cAzAZpMRyeP5tUxRiAkhvqU0d6JY2+qkqIMZj2pbuWTtt3mqlPWbncyaLGNWz3qPLPVYkZWkFWwHpVQ7DVi2DNciMzz9jYk7A5rAqjk0DBGDwf6G/C6Al2fdhONLFCdI8rzWSBrIhT97KNfr1qR3fwPR/RiC5Ptl++rBge8zS80zog+bERZJWf/dgnverb18HpnqwnWB60GDBuTDt1NHJEiP0BIwy1O95jEVzMsz7xs8qlSRWVKSelB7DDVdQxg+ZrJQgqQoFh+Jk7aPXxvWoXdvCvGm+qdVIvWB+N1hmBvhJMk6gJTGoMDh3IQcX1P9+4KbwlAVFESZUdCWO0yB759Lo2nMWALKymMhG0jIru3K4FrlWv3raiJ9vis7tJxEFigs5kioTss25G3PMB6J9GAocYu5MCg3/brs1/RXo6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(7696005)(40460700003)(478600001)(36860700001)(6666004)(82740400003)(81166007)(86362001)(356005)(47076005)(426003)(36756003)(2616005)(83380400001)(26005)(1076003)(70586007)(6916009)(54906003)(2906002)(8676002)(8936002)(70206006)(316002)(41300700001)(40480700001)(5660300002)(336012)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:18:49.1647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e387806a-c990-431e-5a66-08dbb9884ecf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
With the more generic hw minimal state transition sequence,
this limitation has been overcome.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 34 -------------------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 27 ---------------
 2 files changed, 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e2dcb836a0f0..a2360dfdc83b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3948,40 +3948,6 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 				*is_plane_addition = true;
 			}
 		}
-		if (dc->config.enable_windowed_mpo_odm) {
-			const struct rect *guaranteed_viewport = &stream->src;
-			const struct rect *surface_src, *surface_dst;
-			bool are_cur_planes_guaranteed = true;
-			bool are_new_planes_guaranteed = true;
-
-			for (i = 0; i < cur_stream_status->plane_count; i++) {
-				surface_src = &cur_stream_status->plane_states[i]->src_rect;
-				surface_dst = &cur_stream_status->plane_states[i]->dst_rect;
-				if ((surface_src->height > surface_dst->height && surface_src->height > guaranteed_viewport->height) ||
-						(surface_src->width > surface_dst->width && surface_src->width > guaranteed_viewport->width))
-					are_cur_planes_guaranteed = false;
-			}
-
-			for (i = 0; i < surface_count; i++) {
-				if (srf_updates[i].scaling_info) {
-					surface_src = &srf_updates[i].scaling_info->src_rect;
-					surface_dst = &srf_updates[i].scaling_info->dst_rect;
-				} else {
-					surface_src = &srf_updates[i].surface->src_rect;
-					surface_dst = &srf_updates[i].surface->dst_rect;
-				}
-				if ((surface_src->height > surface_dst->height && surface_src->height > guaranteed_viewport->height) ||
-						(surface_src->width > surface_dst->width && surface_src->width > guaranteed_viewport->width))
-					are_new_planes_guaranteed = false;
-			}
-
-			if (are_cur_planes_guaranteed && !are_new_planes_guaranteed) {
-				force_minimal_pipe_splitting = true;
-				*is_plane_addition = true;
-			} else if (!are_cur_planes_guaranteed && are_new_planes_guaranteed) {
-				force_minimal_pipe_splitting = true;
-			}
-		}
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 1f53883d8f56..dcbd38bb3ed1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1267,8 +1267,6 @@ static bool should_allow_odm_power_optimization(struct dc *dc,
 {
 	struct dc_stream_state *stream = context->streams[0];
 	struct pipe_slice_table slice_table;
-	struct dc_plane_state *plane;
-	struct rect guaranteed_viewport;
 	int i;
 
 	/*
@@ -1333,31 +1331,6 @@ static bool should_allow_odm_power_optimization(struct dc *dc,
 		for (i = 0; i < slice_table.odm_combine_count; i++)
 			if (slice_table.odm_combines[i].slice_count > 1)
 				return false;
-
-		/* up to here we know that a plane with viewport equal to stream
-		 * src can be validated with single DPP pipe. Therefore any
-		 * planes with smaller or equal viewport is guaranteed to work
-		 * regardless of its position and scaling ratio. Also we know
-		 * any plane without downscale ratio greater than 1 should also
-		 * work. Up until DCN3x we still have software limitation that
-		 * doesn't implement a smooth transition between ODM combine and
-		 * MPC combine during plane resizing when we are crossing ODM
-		 * capability boundary. So we are adding this guaranteed
-		 * viewport condition to limit ODM power optimization support
-		 * for only the planes within the guaranteed viewport size. Such
-		 * planes can be supported with ODM power optimization without
-		 * ever the need to transition to MPC combine in any scaling
-		 * ratios and positions. Therefore we cover the software
-		 * limitation of this transition sequence.
-		 */
-		guaranteed_viewport = stream->src;
-		for (i = 0; i < context->stream_status[0].plane_count; i++) {
-			plane = context->stream_status[0].plane_states[i];
-
-			if ((plane->src_rect.height > plane->dst_rect.height && plane->src_rect.height > guaranteed_viewport.height) ||
-					(plane->src_rect.width > plane->dst_rect.width && plane->src_rect.width > guaranteed_viewport.width))
-				return false;
-		}
 	} else {
 		/*
 		 * the new ODM power optimization feature reduces software
-- 
2.37.3

