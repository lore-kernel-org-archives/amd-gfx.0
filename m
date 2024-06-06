Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CB9C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCBC10EAD8;
	Thu,  6 Jun 2024 21:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fVuAyl0N";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D16610EAD6
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpI21vca382JK+2SHWGgKgfL0Scs+qWG6VRybtexgaBsYdNZC23v0J+3ixeK1grnH9+o4d7xLVOU59QV/5zo7u3t03832lRDf2mEpry50v5WxTvWBtUFi64GIxMfEWi5wzfPCKAq3nseyKHnu79ygw1vMRavUEqaGQEVLVbIX7aqu7ZeeLMfsBrqKCsUJg84VAotw3UlKBF6MRB//43ykQJ76ULCB7nfv3A04+Bl9nBwE9S+6UGmhwGHIG++/Ffi+M+6n3rcFC7nSqIq52WV4Izo1shHbJs79rkwt6n8mEOdIxR6I4eb1Icv7UXUiU2ZH+YHSlGUQpk0OCuv1j665Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndLqZ2p8WPrKyuk2MqQ8gFbi3Tb0q6hZAsg8Ylu75nE=;
 b=JxzxuAJXGoHUwhswypDIolPdRU/BuTS+1rYIfZXVzUQUFcME76t4S1GV4QO4I+VJ9T38iE+mHqR/okS2+RXizLjRelS98i8K+vSGM0OXVvvx6qRlskV55i6K9kCNzjj9ZOAGlDZslbE3jKk2DjvYWTFvMjBiQTRV2VFpHYki8FbvAyrYwuZLAfxE82DYSvBSq5OA3K+AgQSbCafyT9EBLj7E9kDGkloVr2PhnhebLscevITspIT3M01e7TXC14AcL5hdu/GL3R8FizYfSmrI5mkzM6kqfJ+YBOcUuJ2toX8GLzFhPPljuITC1fZbf8DACzeEchVxZJte4OCxYKfwrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndLqZ2p8WPrKyuk2MqQ8gFbi3Tb0q6hZAsg8Ylu75nE=;
 b=fVuAyl0Nzpeg442hILjKukdm9ZXpmlZILPPtuqxjYYkrLsNJV5/bT8+pHXw4jFPjGOsd0mrn0dAAiJmyf7qBHFl6ZGWCkQaaMQBMiWvPC35fp0peWM0XAnpPxQei4X5JA/yp2zwXsZ+ucsDJQ0yvSlbYwlZpc+cTjX4yyu2QMaM=
Received: from MN2PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:23a::28)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 21:57:13 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::7d) by MN2PR03CA0023.outlook.office365.com
 (2603:10b6:208:23a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:13 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:10 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 15/67] drm/amd/display: Fix multiple cursors when using 4
 displays on a contiguous large surface
Date: Thu, 6 Jun 2024 17:55:40 -0400
Message-ID: <20240606215632.4061204-16-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: d9411e8c-d577-4303-8eb5-08dc86739f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GW0E64CKiZtQlroc9oP48UQauwdoEwMd1V1heyX4HCR/3IYKFwIMTuX264hE?=
 =?us-ascii?Q?LiQhJZs7epZVWgen6m21BuB7qrof2yaHE66LA2FO90DadMK7LZ78cOdGcbtb?=
 =?us-ascii?Q?RxAI0xXh3C69WxmOflnV6YT/zdkHxf3VLv9HflIHKPYi6lGz+DVCwdWKYWyw?=
 =?us-ascii?Q?nM3rrYQ2RE35+z4UB2MfQvVEubEQKA8KBRETAoTd5vO6JJFv+5KoWok3AdH5?=
 =?us-ascii?Q?tcOKIdUfKTtDSOLfJzAc30IlT7BiZ7VKOk1wPyaec6x+c8A4HIDFsb3wvHOZ?=
 =?us-ascii?Q?Syy/uzn1j8t+HsbDDMFoz8sjw2wpAGPEWV5+KLMXb7svPXg2GjPqdiZVtbd+?=
 =?us-ascii?Q?v77AmMtRGbMe9IS7C3rIKUutCBQuF7WZU27fcmv8eXHqrJnCVf5uyoSw4odi?=
 =?us-ascii?Q?4t8qlrG/Gf3hVFLqj4XAWxez6HNaKoT0ho0tjv5CJ+bp4SeQa/GRXHG/qeiA?=
 =?us-ascii?Q?7a10K266t+3VOMwvPp8nn8bIXVY8uYOkP+J+1xFzCBMKUKshuRQAavgiSGCz?=
 =?us-ascii?Q?b+wFss2Vr9Z5ZIxVqRbMkEa4okUd+WSpQDLVpbBaT2AIgeOG4diP6qDKVknU?=
 =?us-ascii?Q?IrfBLChtZO5c3Nm2cETw/hop7DLlWWvwsIKm/o4AR8iLqLFPhUTaor/tNLMk?=
 =?us-ascii?Q?3RdGH+wPK+FnA339hUtBlqDjIRzE5uGR+QhYA35Zd8Y25I421vEMVx0qrn7U?=
 =?us-ascii?Q?p+NF/DugInLLU2bUALLAcLhI0i++UfRKbMDqhWwquUCLe/3+1kzkaaIn+eEG?=
 =?us-ascii?Q?cmVmkB11rCUlyYVwg+0JXIAihP4sZI1UyibePSevLH3lXBPUTKaNIqWt0Kxu?=
 =?us-ascii?Q?nquN+2UW2nVb/LW6joXKPvNl5XVrHlolqGNEMfYiRlhAceVtOR7MfmMCsv8Z?=
 =?us-ascii?Q?yLTcQ7zAc+2wbTMTu7oABS4abqM54vac7lVX2GwXEYessMaZagEQF/k8j8iY?=
 =?us-ascii?Q?p8+M8Eb1PJ1iCOKIf5bjGSJM5nvYyGIVOFAFA+UogaNbOyCNM4FRt3wEZrTE?=
 =?us-ascii?Q?WyN0HnKzwmTIRS9NtAlAc2U0X2FpDvH5WPuttEPZgNi7yxsKRhmSbrA4n2LH?=
 =?us-ascii?Q?ePxsIZolxxPwHc9rimg8erfxlIwV647MtzZRnL/dYoSIhhMxHUwzHqC76hN1?=
 =?us-ascii?Q?okVRZEGnPgpftttm+PTXwuOKUNfG2+cAjOevD03z5Wqoh7hI4C5/Sh540DYo?=
 =?us-ascii?Q?LqCovr4WzONZzQ3iNBnvfqxwyZo0LwJt4i129wprwoUy56aUeH9nPMCpZNeX?=
 =?us-ascii?Q?++HmtS0yWax78SE/wOB9uVXnWmi6nZutGvKcM1WxRpCX5EUSb8b2wOV0fxub?=
 =?us-ascii?Q?8XQ81EqLBKcc0lzmy/CZe/cN0HVXfiB4Sv2A/UFn1ZYWHx5QiAxwgiZUO2C2?=
 =?us-ascii?Q?hrU+H1cScOr75LjG/+iJ5XkwlAn6FIId0f/EBrwxojIYiwUJEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:13.2474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9411e8c-d577-4303-8eb5-08dc86739f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
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

