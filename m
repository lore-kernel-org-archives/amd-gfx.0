Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20B2EB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A1E410E63A;
	Wed,  6 Sep 2023 12:50:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2FCE10E637
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeKm0LkbB+LL9W0CVVieqOvbZUdUQi9kegTbCnsquSI4lfLALzAEUc0GLsVph6czUClzlCUjaXeL8EM/tQxJ1FnXHqVukjNHvny/RXmmEKkdS9045yN4i6obn35a9dVrXDCpLW1uIQvPXIFh60Xienec6NVWwlWh+lKsG0dJkz/Gk2u6DXER5zfO5mZxK8yvu5f2WbgUZhIHG5vZ1tuRSGPg75Dd6LSzEU4xPjiW7mlf790IVwr7oLUT9pVYLzuHVuT/dFfi2Frov5b1opoYdL8EWHDiFrbBZW3QqR3en2lUWWF3ABcvN2BMIgHEJgC++FLYxnz+zDRCwzQxY39BzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVDSseOCo4BQFxUHL6daqzoIzz1NC/V0Tx8pxLJ+QSI=;
 b=lzu3IpSz3U/wH8dB953uP+q5dWLjHZFi7P/704cPpPj5BHh0hq5LvxqkMoqBv6M4ZiptbcUcdpOFZiBGD9ugkDe7Jvu2yzumx5pl7Fr0SCl7NItl/A17mCpM+fo+4yAL1uSXnbi+IDIu/JGURCv5ySi+6eQintzx9dAQOG6fLQ4un80pkfKcbrzk7p0Ix8ZBLfBtW8V8BBSXDTfb0so6UYHyceefW8XWI9VaUCQPnKDXpqliCXPjNP8iPibmDX1qGwY9KYbbV1llt/kUe2efRs/xNm3lnwKrbxF9iQrwVR3ZEz9qW5RONFZ3jCT8YjlU3r+TIX3dQCGgrj1x8Oovcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVDSseOCo4BQFxUHL6daqzoIzz1NC/V0Tx8pxLJ+QSI=;
 b=x8SgGyvcrDVb2P748t7Of9tYDORImAlHPYTRcRinrNuidWgTX345t8mnkbRPi1vUPB3eUsFb+VgTaeXqeiG8OBCDP4wn9c+c5zHkBG5za52aHZILbG7nZYiTCjTPPOQhUuRlNnSnWakDhF4HfpiaIbHVCs8Pf+5RIENIqMCdZD4=
Received: from CY8PR12CA0057.namprd12.prod.outlook.com (2603:10b6:930:4c::24)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Wed, 6 Sep
 2023 12:50:33 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::b4) by CY8PR12CA0057.outlook.office365.com
 (2603:10b6:930:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:50:33 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:50:29 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/28] drm/amd/display: only allow ODM power optimization if
 surface is within guaranteed viewport size
Date: Wed, 6 Sep 2023 20:28:21 +0800
Message-ID: <20230906124915.586250-17-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be9eb79-1004-4b5a-ed33-08dbaed7dc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GjkL5ns/2GK2yxaShn4MdGQIxAi+WSdFnIWeMTWmF0Z7v7XY+d2knAngTAlQg9IW8RZHFAH9ptRf5QHaOCusi5a6/V80Dn3bX7aS2xZmZ9toBYjIYg3lUCyEjb+5aMyiU68e5Pmz1/S4bxjOvdcnUybHnWiK0HsOLyV4no1ktb8aByxMvE5vIXt4iT+MK6eMLyKIYTz3rkeZzKTTiAX+KjTJ03Kxt5IstAejNqLKfi5DuUQAzygS6lvITBNdod4pKWXvfWmNjK0m1wx0sC9cbI7Y/S7Mne90qV+67vbPYvg0+9o6vy+NQIuiN0m2VrJjaRqX3G/iUHPozFRr8iZFldjRuVF0uofFOAwV6wE5qifzQjLm/vEkk/vQeeouGwc6zxdYLWM9X3fy2UUrBG8y/JvkBUJQoCc/c3EBKEGqz9WEWK3//OyWR4+D4GfwyWl6KlnxtcI76PEexrH+r9Jl7n0/fMxWGYhKPF/Bv4OpvDPRDtBCtGAyeRh60lsidm3/fIbagvswbxIbx99JtUDXYHpxLhYS4hwBpaw4qgcMZQy2+2qP6qd/9tvOKs0ZQ8cucJULqtMwxNOyx1V6Us6E43T+hkYxgaT0mwkJg9Ww87N/w/U5ojkDqRbyk9lnPjelrmKZRKA0uh0P6lnOEFeeqh0V+LHUU77UsSo8sqthSKQuioMy10ahN4XZTfPefj7leWuOcFrw4EssVhPlv8AFsJkhX+zo2hP1Y50YzxP/xlvXntbVe5Fl3SK1SSOAFC0YfD2WXqp5n+byZUT/Aivrhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(16526019)(7696005)(26005)(2616005)(40460700003)(1076003)(86362001)(47076005)(81166007)(356005)(82740400003)(36756003)(36860700001)(426003)(336012)(40480700001)(83380400001)(41300700001)(44832011)(8936002)(4326008)(54906003)(316002)(5660300002)(70586007)(8676002)(70206006)(6916009)(6666004)(478600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:50:33.6728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be9eb79-1004-4b5a-ed33-08dbaed7dc24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
Current dc update design has limitation to support transition from
ODM combine to minimum transition to MPC combine state seamlessly
at the capability boundary when MPO plane is resizing. This will
require dc update high level refactor in order to remove the design
limitation. The decision is to block such use case for existing products
by limiting ODM power optimization support for only those surfaces
within guaranteed viewport size. This will prevent us from transitioning
to MPC combine state when ODM power optimization is enabled.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 36 +++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 27 ++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dcedda85dcdb..0320bc49458c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3881,6 +3881,7 @@ static void commit_planes_for_stream(struct dc *dc,
  */
 static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 		struct dc_stream_state *stream,
+		struct dc_surface_update *srf_updates,
 		int surface_count,
 		bool *is_plane_addition)
 {
@@ -3918,6 +3919,40 @@ static bool could_mpcc_tree_change_for_active_pipes(struct dc *dc,
 				*is_plane_addition = true;
 			}
 		}
+		if (dc->config.enable_windowed_mpo_odm) {
+			const struct rect *guaranteed_viewport = &stream->src;
+			const struct rect *surface_src, *surface_dst;
+			bool are_cur_planes_guaranteed = true;
+			bool are_new_planes_guaranteed = true;
+
+			for (i = 0; i < cur_stream_status->plane_count; i++) {
+				surface_src = &cur_stream_status->plane_states[i]->src_rect;
+				surface_dst = &cur_stream_status->plane_states[i]->dst_rect;
+				if ((surface_src->height > surface_dst->height && surface_src->height > guaranteed_viewport->height) ||
+						(surface_src->width > surface_dst->width && surface_src->width > guaranteed_viewport->width))
+					are_cur_planes_guaranteed = false;
+			}
+
+			for (i = 0; i < surface_count; i++) {
+				if (srf_updates[i].scaling_info) {
+					surface_src = &srf_updates[i].scaling_info->src_rect;
+					surface_dst = &srf_updates[i].scaling_info->dst_rect;
+				} else {
+					surface_src = &srf_updates[i].surface->src_rect;
+					surface_dst = &srf_updates[i].surface->dst_rect;
+				}
+				if ((surface_src->height > surface_dst->height && surface_src->height > guaranteed_viewport->height) ||
+						(surface_src->width > surface_dst->width && surface_src->width > guaranteed_viewport->width))
+					are_new_planes_guaranteed = false;
+			}
+
+			if (are_cur_planes_guaranteed && !are_new_planes_guaranteed) {
+				force_minimal_pipe_splitting = true;
+				*is_plane_addition = true;
+			} else if (!are_cur_planes_guaranteed && are_new_planes_guaranteed) {
+				force_minimal_pipe_splitting = true;
+			}
+		}
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -4270,6 +4305,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
 	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
 			dc,
 			stream,
+			srf_updates,
 			surface_count,
 			&is_plane_addition);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 883e90be2257..2358c9100cff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1267,6 +1267,8 @@ static bool should_allow_odm_power_optimization(struct dc *dc,
 {
 	struct dc_stream_state *stream = context->streams[0];
 	struct pipe_slice_table slice_table;
+	struct dc_plane_state *plane;
+	struct rect guaranteed_viewport;
 	int i;
 
 	/*
@@ -1331,6 +1333,31 @@ static bool should_allow_odm_power_optimization(struct dc *dc,
 		for (i = 0; i < slice_table.odm_combine_count; i++)
 			if (slice_table.odm_combines[i].slice_count > 1)
 				return false;
+
+		/* up to here we know that a plane with viewport equal to stream
+		 * src can be validated with single DPP pipe. Therefore any
+		 * planes with smaller or equal viewport is guaranteed to work
+		 * regardless of its position and scaling ratio. Also we know
+		 * any plane without downscale ratio greater than 1 should also
+		 * work. Up until DCN3x we still have software limitation that
+		 * doesn't implement a smooth transition between ODM combine and
+		 * MPC combine during plane resizing when we are crossing ODM
+		 * capability boundary. So we are adding this guaranteed
+		 * viewport condition to limit ODM power optimization support
+		 * for only the planes within the guaranteed viewport size. Such
+		 * planes can be supported with ODM power optimization without
+		 * ever the need to transition to MPC combine in any scaling
+		 * ratios and positions. Therefore we cover the software
+		 * limitation of this transition sequence.
+		 */
+		guaranteed_viewport = stream->src;
+		for (i = 0; i < context->stream_status[0].plane_count; i++) {
+			plane = context->stream_status[0].plane_states[i];
+
+			if ((plane->src_rect.height > plane->dst_rect.height && plane->src_rect.height > guaranteed_viewport.height) ||
+					(plane->src_rect.width > plane->dst_rect.width && plane->src_rect.width > guaranteed_viewport.width))
+				return false;
+		}
 	} else {
 		/*
 		 * the new ODM power optimization feature reduces software
-- 
2.42.0

