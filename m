Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D999AC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401F910EAE2;
	Thu,  6 Jun 2024 21:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U/DG0u3P";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E428310EAE0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOAiqsx6lP03VvJMkxa9OmmOQt3vyC5FS7+4BHZlHeFtbIroUyl1fgxbEYmxRrgBeSQ8qrBK62OljOBpRYImBSZAa6MyX6eqaWpYkEJl5tPtSSHp0Lzlms3r12momufsizD/e45KP/L0Orx6bHHzrRJSOiyqG7/BM7v/8UjdtXFDu4KpPgHn6icEO7B6nBGerJL6i7f87xd7uEE1eh2TjmjNBT7zemYJcZbiGFhB2UVqFumWVyKVodb8SAPF4OA55pOFIWeoj8jhlfhlIO8Y/5yZu5J8mxcbj2IqYckRIyiXKPGJPmbo5LDbAwAaOfFwB/haY+JOMxFiCzIyVelxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4/Ks+TuQZu1T+5NzoH5GuPj45/dwz6BtR0Z7o7NcLQ=;
 b=PRRTrWmh5R8BaCMzXxeCtUxkcLHL9tWyllSHFOlPIJBoN8ooXlDWFdBJijrYmsPqqob1CG+YNeUQnNcYwQvEC0ffiNld1/dqigTrvN5iaOpFq9X3udH/MwoxHC32YycQvKpfXoEYKqC9NCVybYT+IMTMm6GP20DzW0Fa34ebB9kPE/uX9s0yPpAa4P/dYORurYnP9RxnLhjIs/swVSQ9+9xbizQMG6f/r4Rcwvx4M644CeSvUkgINdKGGnA+QcAgegcWaF00JVB5QAo4DAKNDhPeCJ7kVYb7b4NSk3ENw9l3Tqf94fB7sAfmN7miwxTAwHHs++Q0ZfPrBW9LA2En4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4/Ks+TuQZu1T+5NzoH5GuPj45/dwz6BtR0Z7o7NcLQ=;
 b=U/DG0u3PzduYg/EaC7CCv1nn0BwKJ2Lqm1mxYW53OxffyiEJ0nOEVM+Q/b32wGu142zNOYRnRaTVWniLk/4s4XAop/z4K6ig5wV0g37sXK4uK7SUiZWxEIp/Yk0DXhgVH6+Tm6tFJ1RRDRXXRlWcwdk5LXv4tR8uVzszUrE2ktY=
Received: from MN2PR20CA0036.namprd20.prod.outlook.com (2603:10b6:208:e8::49)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 21:57:40 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::30) by MN2PR20CA0036.outlook.office365.com
 (2603:10b6:208:e8::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:40 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:38 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Sridevi Arvindekar <sarvinde@amd.com>, Ariel Bernstein
 <eric.bernstein@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>, "Zaeem
 Mohamed" <zaeem.mohamed@amd.com>
Subject: [PATCH 27/67] drm/amd/display: DCN401 cusor code update
Date: Thu, 6 Jun 2024 17:55:52 -0400
Message-ID: <20240606215632.4061204-28-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: e7acbdc0-ed60-4437-15c0-08dc8673af64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A6rIn0tFyzxRQtyhlvYJv7atC+ckCsc6epdgy44wxOQThYVyYNWw3A9AncDm?=
 =?us-ascii?Q?zxpkin3RJiO7cqLrA5yzRRO/W/cTeWlN+MdQrRUEIPdhHfDMFz+MbhzKOmfT?=
 =?us-ascii?Q?UaQajh+Iq/JMc8KEVxkBY378KmZ54TaSoGmsr+NNzBb+sTzsMutkvKNbD132?=
 =?us-ascii?Q?IwzUJxndPYLa0WQ6XvmhnqFGkqtXfPZun+pScdRFMve1/ZdbvIdC++KokVmF?=
 =?us-ascii?Q?wfy2v9+IJ0JAwTfLDBZv965HXk17nJtBIaJDf1lYlS4onKxOiV68jLt98ILw?=
 =?us-ascii?Q?wRAb9//DQYpkTFakbAE1t1yv0ksRUjCbYaSyD/ANbOXuYCenW5epjVc/9GTx?=
 =?us-ascii?Q?XmzVmgE1AwJjribjJ4wFay3u7fSinIL3VMoonuOqCaAKPrJIL18UhlK0aT5Z?=
 =?us-ascii?Q?TSYNGPyAknD0O52EQWoz6Mbp3eDA7C1zV0XmzjMlMuYoX7iWU5UqbJ3empIx?=
 =?us-ascii?Q?S/BCWKQ4HOETZq9shUo+bexru97pavHwxXbNFGa24R7ro42Rb6aCdcIiVakm?=
 =?us-ascii?Q?o8HOduC5t9m1g6YPnx4fT31FAdACjC/34zgDc0suRimg+kAMFJu9F7avCULq?=
 =?us-ascii?Q?N6XmxnLVVJWPu1zgrDBFspmj9N179W78vWZ045NQPnI0/YrIpWiqHZheee5N?=
 =?us-ascii?Q?tJR+MtN6tKTdMpkxGOGXIjHPel7e47lgDlo+Xtetk1K5fO0ddz0tflpagW1p?=
 =?us-ascii?Q?9QrG1AcSWTOD0z2b+8vmIJTPTWjXMF7jw746UP8PpRhGpD5eEuJgt5QCEGBi?=
 =?us-ascii?Q?8Nx5aH9jzYUtyahrwFfyMNa1w4q4IW2Q60lxIfpq0jCRsg02sgpZHMo4LR1R?=
 =?us-ascii?Q?cgB/sJe8BMs9PsmYqhT/f5igrgJckT75okw4XctWz2ZYhCbKVBqOLQwe17XG?=
 =?us-ascii?Q?t+MAjFVKLOKbNtdseGGplxxIlZmZw8O/x+3mK2dXSP0QFvB6N+B6ExCzo2hg?=
 =?us-ascii?Q?pk8XlbLpqLtCmpyD7VVBjRT7VqzNJ8BUw08HTQ7zxY/K1CkLVJoxbmL/jOGb?=
 =?us-ascii?Q?NBPLVNJJ707RDr/vjATI66T8hh/bEyv1ifwyi6Gn6HuNRRC2n+yrDnlKksEc?=
 =?us-ascii?Q?8pZ67FDxsiBSzvEaj9QKU2OvDClX5i1MfQCkT+XFCZbH37goaH01oPqLcjsK?=
 =?us-ascii?Q?4yxDQ+CLLSDIGvsXSzKrFv0jtDusjFmi2wQGFjImH+sKUJVkcghLB5vcr+Gk?=
 =?us-ascii?Q?4Epk8w4z1NvHsq20PWgrF3y1Undslyh6rq8eOqdgpGsTZoU8EyaysqZqRXDq?=
 =?us-ascii?Q?8MV/HzIwKlWBlfwzocUP1Sr1KwlmbrBuhriH959w3bSbkX5hJvi+rVUZ9XBu?=
 =?us-ascii?Q?3cBxAPVDUoySfRxYsa2SkYYat4vxfkaeTsMIQ6k3hluY0Y37YBpbFtxsLC3R?=
 =?us-ascii?Q?IIhpHnNwMzjPB4dxTePRhDVOgpWzyN1d2nJYxKP2yAhDK2t73g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:40.1075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7acbdc0-ed60-4437-15c0-08dc8673af64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
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

From: Sridevi Arvindekar <sarvinde@amd.com>

Scaling androtation changes for cursor.

Reviewed-by: Ariel Bernstein <eric.bernstein@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Sridevi Arvindekar <sarvinde@amd.com>
---
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 22 +++++--------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index b9541d5ab601..0b00fdf1297a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1124,14 +1124,10 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	 * pipe to make sure each pipe enabling cursor on its part of the
 	 * screen.
 	 */
-
-	if (param.rotation == ROTATION_ANGLE_90 || param.rotation == ROTATION_ANGLE_270) {
-	} else {
-		x_pos = pipe_ctx->stream->dst.x + x_pos * pipe_ctx->stream->dst.width /
-			pipe_ctx->stream->src.width;
-		y_pos = pipe_ctx->stream->dst.y + y_pos * pipe_ctx->stream->dst.height /
-			pipe_ctx->stream->src.height;
-	}
+	x_pos = pipe_ctx->stream->dst.x + x_pos * pipe_ctx->stream->dst.width /
+		pipe_ctx->stream->src.width;
+	y_pos = pipe_ctx->stream->dst.y + y_pos * pipe_ctx->stream->dst.height /
+		pipe_ctx->stream->src.height;
 
 	/**
 	 * If the cursor's source viewport is clipped then we need to
@@ -1297,18 +1293,10 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 						pos_cpy.x = temp_x + recout_width;
 					}
 				}
-			} else {
 			}
+
 		}
 
-		/**
-		 * Display groups that are 1xnY, have pos_cpy.y > recout.height
-		 * Calculation:
-		 *   delta_from_bottom = recout.y + recout.height - pos_cpy.y
-		 *   pos_cpy.y_new = recout.y + delta_from_bottom
-		 * Simplify it as:
-		 *   pos_cpy.y = recout.y * 2 + recout.height - pos_cpy.y
-		 */
 	}
 
 	hubp->funcs->set_cursor_position(hubp, &pos_cpy, &param);
-- 
2.34.1

