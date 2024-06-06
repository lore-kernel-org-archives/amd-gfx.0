Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FCDC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324B210EAB7;
	Thu,  6 Jun 2024 21:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dCNGqsbj";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9742D10EAA9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmExv47fpCLPLZ7pbkE9giFNSFrBbKe+jJwv9PLNKhCdpiaWhE7XG/FriFqv7JTC+/U/XRYcsmUkaL+w6kjWXJf7ctQUzGjSj0jvHJJDeQZecUBvoRbvk3fW7Vnj7ckqKoBhsGDChfPc4j0F12K4iWAFgk/vU/s1qKxXUnywO1ZF5a/RuPod27hOqH5WDGkhc3bDWe1cMqlmmdBpqH5leHGYzlP7D6LI/ahtIGxXw368VLzbV18jnifoPJaXEpgPlNd7z4rtKyVxaQEuGoiBEZkqsJ13C2bJPQdreRUkxzSgH13Q0ZjZfdhM507nYiRaS++vMJsPljOZTZqugaaesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndLqZ2p8WPrKyuk2MqQ8gFbi3Tb0q6hZAsg8Ylu75nE=;
 b=faCoadMOHkjQfN6ZM7+J2SAOag6+0GMHSGXQDr/kAWyBmnF+TywYC8QMexjwI3ivOyYSl/YZqmtXJs8IsgwVgZEOftc10nkCE4SueWOG6YAGhOyTmCfu1XyiuHvu8SFK3Pz2KbBuN6fvMq6D/iOR3YX7dGFeDAYznA+hRoswrJQF3JxL4vRiumXuREXCbIeIx0Tfv3au+aTUb/7Uzq3WxuiBYpaSVX5sgksaqKqZIZ33ia07A1ZSA+Z+B4brsOiq/NQR3dkM0cF3k5fA2OPR51za0LQ20h0uZX0BeaUzounWEdCpv4d6JkBZgTHi/KHs/dOVKQc2R8nabq7M0xWw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndLqZ2p8WPrKyuk2MqQ8gFbi3Tb0q6hZAsg8Ylu75nE=;
 b=dCNGqsbjZkKNqf7HPvJSrsGy4hguBpcloJMb+Fz9Evg0Ap6Gwzqd1Zpuh7ohYtbJllxOXjQTMO4TC6I2051Fc7kYfNKnwvay+n4rkM1fbtU5EPMmXp8iBmHU1E7qHdQWMuWbWQgGz8PUMTsKLIu0YtAuip6+O2DtAmQcosxuKBM=
Received: from SN7PR04CA0047.namprd04.prod.outlook.com (2603:10b6:806:120::22)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:02:13 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::cd) by SN7PR04CA0047.outlook.office365.com
 (2603:10b6:806:120::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:13 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:11 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 15/67] drm/amd/display: Fix multiple cursors when using 4
 displays on a contiguous large surface
Date: Thu, 6 Jun 2024 16:58:36 -0400
Message-ID: <20240606205928.4050859-16-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef16f2d-2a27-4ec2-19fd-08dc866bf088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2WjuaJFAbT+QSLIBCJyop1BUqEn6iWt9LJXUcqLRski0AuXnFbBC9L3Ix3Z8?=
 =?us-ascii?Q?bMt1hT0M8mCLs5hNKapJdOzmrGcWHfHR5KRedVyt6w93Ho6yty1xMqbcXPt4?=
 =?us-ascii?Q?Z38lWrfPYSuTo8fTp6D5DY+ErcVSxy+EdPeZp7ynbM69g4JNJAguMUFzYJDN?=
 =?us-ascii?Q?t134VTaIMjkOHDW7wrg+opJst+Lguskj4N/0pkSVGoj4TPLJk1Bk6OHWWUYb?=
 =?us-ascii?Q?pkIGAOwl/DTFpkCupujiQVKeoIoQGGpFTBkYfQemFdtPDzYC5aHSsFHKNEJJ?=
 =?us-ascii?Q?f1keB3yOPvJ05a2tu+nSMXt+z1qKO6JN45G8RVp8KxxqAyiTzKNE6xCSqe14?=
 =?us-ascii?Q?KRc6sNhDuRpYBDJbH3OjKI+gJj5KXeqJtY1BDGu2p6vhtnT9xDiNY7E1Siep?=
 =?us-ascii?Q?WMMVFPuj13pxnGEQHejjHefv8ixfdyQIlYxmQHRKBhNZ4NKok/ork0Q/z53o?=
 =?us-ascii?Q?7hed0kB6/CZf9R4YiUncTev0PJ8irhcLxHNkDcFb7xaGjM5CusdqjUjs8VCR?=
 =?us-ascii?Q?fanmIfwxoohRLXbzZhAmqBgCqAG6c/xHRESuz+b5TMV3jTZnCEftBYF/5Eit?=
 =?us-ascii?Q?JKG8x/bdiGOa0Otr2nPL2BFijzIWS8nHBjQbIKo4SHvJyw9XJKATIulp0ocb?=
 =?us-ascii?Q?EYgR1RipsyTeqzVRgMTliSjze0W43fVY5cWN/C+ydeawvwbw7yX7C7zIRDWm?=
 =?us-ascii?Q?0rh+8YpGatbHYv3T93kTeI09TvqzF688QMPYrMiR5ga2T1F6H37+uv8MX9p5?=
 =?us-ascii?Q?hBp9NDrtEXIwlmWriQgYEYdwWuqwx0+4zjzZJAE8/+0TEQtGnLEYFoFgY6eS?=
 =?us-ascii?Q?jhe1EuF3gpPFkegWFzZjLUt2fidynLoDVldHSQp8uL2Sq9e9YFOXsqfoomu+?=
 =?us-ascii?Q?zvb6vIsdAgqErBA6FCZ/NyK8Or8yyGbIkA08y1koyOjvKo8t+OlLmR/zQPtF?=
 =?us-ascii?Q?SkTQn4Dq0zfHMWAAg42D6h4XPNYMoP2by8ramUfk7xqdHDXXrrDu8GIPxCsQ?=
 =?us-ascii?Q?nBy1HugdsWE8+z7FxujYsmzL7l0ftYfD0eb9h6I2kQ1LB5VGWBA2WU+an1cC?=
 =?us-ascii?Q?vcQwL4HhxhYtVCzKyoZNblqkR1t34kqusjyoOzbPYNzYVQNAev7iFocS0mus?=
 =?us-ascii?Q?RyAl/CVRdv14Z/pxNSLncKY2sBi/Wp1dAWx3FBwciDiY4oSbvOm7JMAtQG2j?=
 =?us-ascii?Q?jb5rbhinDw2+iECYNWyzZea77nsrxN9f9G01xCeQ3+dmL1DY+MEdrlwzrkqK?=
 =?us-ascii?Q?sKvEtb4Myea/9knRBZOv3pzou9qo8N5UU4B2RpMmRF+pfXpwueOCSqdq28sa?=
 =?us-ascii?Q?svg1yLNBxSQwOevYcmd2TtmtbvSAwn7v1A3PTTLGMXcA+G1fkpfg6iDSf9gV?=
 =?us-ascii?Q?gl/rLJCjZ+a2qEnRoXkqJBoJxNm9A/dePP5sBCtLLecmvErQ4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:13.3904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef16f2d-2a27-4ec2-19fd-08dc866bf088
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
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

From: Nevenko Stupar <nevenko.stupar@amd.com>

[Why & How]
Remove some cursor offset calculations for rotated cursor for fixing a bug where multiple cursors are seen.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 407a45a3ae2c..b9541d5ab601 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1126,10 +1126,6 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	 */
 
 	if (param.rotation == ROTATION_ANGLE_90 || param.rotation == ROTATION_ANGLE_270) {
-		x_pos = pipe_ctx->stream->dst.x + x_pos * pipe_ctx->stream->dst.width /
-			pipe_ctx->stream->src.height;
-		y_pos = pipe_ctx->stream->dst.y + y_pos * pipe_ctx->stream->dst.height /
-			pipe_ctx->stream->src.width;
 	} else {
 		x_pos = pipe_ctx->stream->dst.x + x_pos * pipe_ctx->stream->dst.width /
 			pipe_ctx->stream->src.width;
@@ -1225,15 +1221,6 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 			}
 		}
 	} else if (param.rotation == ROTATION_ANGLE_90) {
-		if (!param.mirror) {
-			uint32_t temp_y = pos_cpy.y;
-
-			pos_cpy.y = pipe_ctx->plane_res.scl_data.recout.height - pos_cpy.x;
-			pos_cpy.x = temp_y - prev_odm_width;
-		} else {
-			swap(pos_cpy.x, pos_cpy.y);
-		}
-
 	} else if (param.rotation == ROTATION_ANGLE_270) {
 		// Swap axis and mirror vertically
 		uint32_t temp_x = pos_cpy.x;
@@ -1284,15 +1271,6 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 				pos_cpy.y = temp_x;
 			}
 		} else {
-			if (param.mirror) {
-				swap(pos_cpy.x, pos_cpy.y);
-
-				pos_cpy.x = pipe_ctx->plane_res.scl_data.recout.width - pos_cpy.x + 2 * pipe_ctx->plane_res.scl_data.recout.x;
-				pos_cpy.y = (2 * pipe_ctx->plane_res.scl_data.recout.y) + pipe_ctx->plane_res.scl_data.recout.height - pos_cpy.y;
-			} else {
-				pos_cpy.x = pipe_ctx->plane_res.scl_data.recout.width - pos_cpy.y;
-				pos_cpy.y = temp_x;
-			}
 		}
 	} else if (param.rotation == ROTATION_ANGLE_180) {
 		// Mirror horizontally and vertically
@@ -1320,7 +1298,6 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 					}
 				}
 			} else {
-				pos_cpy.x = recout_width - pos_cpy.x + 2 * recout_x;
 			}
 		}
 
@@ -1332,8 +1309,6 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		 * Simplify it as:
 		 *   pos_cpy.y = recout.y * 2 + recout.height - pos_cpy.y
 		 */
-		pos_cpy.y = (2 * pipe_ctx->plane_res.scl_data.recout.y) +
-			pipe_ctx->plane_res.scl_data.recout.height - pos_cpy.y;
 	}
 
 	hubp->funcs->set_cursor_position(hubp, &pos_cpy, &param);
-- 
2.34.1

