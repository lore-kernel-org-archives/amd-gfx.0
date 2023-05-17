Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C73AC77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD8E10E011;
	Wed, 17 May 2023 11:38:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143A110E011
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:38:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu1bSRYrgjxm1xsUH0z5tfsW3ydAf+YI7s/Ots7kULjAgiSyRIr6eLJnvh9XJS/6hSL7t2WuHkuCMjfFCWNIJ/KHheQvfLS7b3wBY9aB/y4VR+0rY1udfSAs9mt/mvVz90rZkImlPWluTDIWsx3+RpaYewS4bmTBQJg/bxGXDGbyMku2cDyhSTumFBCc3o+4XcjtjajSl+/5cWQzhE2wK9Bg9tdFN42Ju4j8dgj7ZlkRKcD1Z+/7D68uGu0bjGS+F1F+P71iwYMPiq8kJliv/X+H/KADeAewAGu4/scBXgw7f7dm44hbIlnmB4pgiYJqR0W99He6NrA9OOwYRCPZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4iQJFxu/MYqM7VykkYYB3eV7+UUpfrj95am4awJda4=;
 b=GIO02oKWf5TfStJhEon/2vywddGSyJyU+btAYChKH2x46XFS22zoE+ucSLIsu9SCbs0V+0IxPrLFVMZgVEZ/eTXb2CFzrmuBZQtIncqet8C0N1LGoHtZ7Ds2LerirB+Rrt+V4bZL6BuUPjL+JJd9ng5JCoekWoYJz5oXZHhj0GQghyYWAK7dysdWf/S/gnhrzeJ7w0cfk4qVsDVmALZvAAecayAvQK6g1hzHTbJV+49T0KQZP4fkJP/x3M25JFYrukhkChw8KmvOXSghzcuAHM/Igskx0vZ/WxgIhg2Krm0ZFGWcJ3t7nektkY6POEL3YlJF3jkChqS0L2+0TXjsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4iQJFxu/MYqM7VykkYYB3eV7+UUpfrj95am4awJda4=;
 b=p/d52I2N2T6JsQXJt3Dkbg2MFjDe2PoEn/08vZk8rnNVcCKb52/dmMqEmrr9IF+L6xLoxcri9Sz0xN5nuWxgmirTbz8mtTdqcGPv8gbSnK8AdhuYVJWNn8EgcI1LHaFEPM4NACATLvOdciBnujLU9t6czuv7YNiuQI2EhQGBR+w=
Received: from MW4PR04CA0272.namprd04.prod.outlook.com (2603:10b6:303:89::7)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 11:38:29 +0000
Received: from CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::7c) by MW4PR04CA0272.outlook.office365.com
 (2603:10b6:303:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17 via Frontend
 Transport; Wed, 17 May 2023 11:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT073.mail.protection.outlook.com (10.13.174.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 11:38:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:38:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 04:38:27 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:38:22 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/18] drm/amd/display: disable dcn315 pixel rate crb when
 scaling
Date: Wed, 17 May 2023 19:37:08 +0800
Message-ID: <20230517113723.1757259-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT073:EE_|BN9PR12MB5068:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b4a99b-9b0d-410f-ea25-08db56cb3c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tY7FiZmIT3C/17UbODsYPQlKPuHkG6z52gAqaTtkLTlAXD3ApVAhZVlPjhhCh8YqnKJ9ZqoODqnhyG44/iIGeX7Cp9xggmxg+H6SZOFHcFiFINjNit3n/xv/162afHfws60vfJjl+Otd7dcDjmR6V9UEU9sg8twWp0zZh/vI4DJm4VXMc1vulm/LSH0OH2GD4KfIa9DAasYjByY6ZpdLTON0bOf200BNzPidKd9nUyeyJafnCFY+qJBOBo8EbO7FYUUBCln7Eo1hkdR+CImx3u5OdeU1DbugJTP+yTF2pHO90SDqSej1OXPDTARZP5C1RbqSIYWY/iT5IR5ArGeWUTwYDp0Cft7DDmSsOcSkDtjbOGN/E4rnIFz72+d35xmOLxQZVqxFch/mNnmWpddEDk6zYSdsuTeif7icu9Sv3s0PDO4Hzhf2pZxXMdzn7u77V6uXs1Owt+s5+Y/rt9oSF6AlXC10iHh+Ik+0CKcunDUlA6FuSvfcyALwb1ZO03BX5Tv1W0FBruYHr0If0wYNLw1uGnhT9mtxu0RtXLpmH6vJEPO59pyf5XeOgVvYbm0YraPrSEgNXiL3TTdvaKm0yucd8ehTgPdYbqaKeGX+E53cGCeRztiIXxs9BF5+yeaw1NhDIhg+CZjY+B7/Nm14hH0d5j8qCqKMWTIsI0Vd2E1sNmxkcYPan+Om3KOsxiXBcE7uUOsioER/OUdis1Qq8T7i7uaCtxLNJj4NRpdBJ+LByZN1hdQV+ouGMzCaC1/wYdCajK7FDiBMv9/f6g91Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(8676002)(8936002)(336012)(426003)(47076005)(54906003)(36860700001)(83380400001)(82310400005)(81166007)(82740400003)(1076003)(26005)(356005)(2616005)(186003)(40460700003)(41300700001)(478600001)(70206006)(7696005)(6666004)(86362001)(40480700001)(70586007)(6916009)(4326008)(36756003)(316002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:38:28.7288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b4a99b-9b0d-410f-ea25-08db56cb3c15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>, Tom
 Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Ariel Bernstein <eric.bernstein@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

The rough calculation does not account for scaling. Also, make 2
segments the minimum allowed per surface to avoid potential 0 detile
with mpc/odm combine on such outputs.

Reviewed-by: Ariel Bernstein <eric.bernstein@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 42a0157fd813..c6bc2d603ab8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1666,6 +1666,14 @@ static bool allow_pixel_rate_crb(struct dc *dc, struct dc_state *context)
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
 
+		/*Don't apply if scaling*/
+		if (res_ctx->pipe_ctx[i].stream->src.width != res_ctx->pipe_ctx[i].stream->dst.width ||
+				res_ctx->pipe_ctx[i].stream->src.height != res_ctx->pipe_ctx[i].stream->dst.height ||
+				(res_ctx->pipe_ctx[i].top_pipe->plane_state && (res_ctx->pipe_ctx[i].top_pipe->plane_state->src_rect.width
+														!= res_ctx->pipe_ctx[i].top_pipe->plane_state->dst_rect.width ||
+					res_ctx->pipe_ctx[i].top_pipe->plane_state->src_rect.height
+														!= res_ctx->pipe_ctx[i].top_pipe->plane_state->dst_rect.height)))
+			return false;
 		/*Don't apply if MPO to avoid transition issues*/
 		if (res_ctx->pipe_ctx[i].top_pipe && res_ctx->pipe_ctx[i].top_pipe->plane_state != res_ctx->pipe_ctx[i].plane_state)
 			return false;
@@ -1715,10 +1723,15 @@ static int dcn315_populate_dml_pipes_from_context(
 			/* Ceil to crb segment size */
 			int approx_det_segs_required_for_pstate = dcn_get_approx_det_segs_required_for_pstate(
 					&context->bw_ctx.dml.soc, timing->pix_clk_100hz, bpp, DCN3_15_CRB_SEGMENT_SIZE_KB);
+
 			if (approx_det_segs_required_for_pstate <= 2 * DCN3_15_MAX_DET_SEGS) {
 				bool split_required = approx_det_segs_required_for_pstate > DCN3_15_MAX_DET_SEGS;
 				split_required = split_required || timing->pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc);
 				split_required = split_required || (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
+
+				/* Minimum 2 segments to allow mpc/odm combine if its used later */
+				if (approx_det_segs_required_for_pstate < 2)
+					approx_det_segs_required_for_pstate = 2;
 				if (split_required)
 					approx_det_segs_required_for_pstate += approx_det_segs_required_for_pstate % 2;
 				pipes[pipe_cnt].pipe.src.det_size_override = approx_det_segs_required_for_pstate;
-- 
2.25.1

