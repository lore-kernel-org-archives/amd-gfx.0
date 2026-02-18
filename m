Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F83E9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6556910E603;
	Wed, 18 Feb 2026 16:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VAv1Sj7p";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7BCD10E605
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHQvDyE3dqpUN5JcxXaeEiWg3jgvUOENACYDbB7J1Qci1Ef7NeJkgCiMbwdMxoHE/m7V36mIHIOL6mBGQ9qK0ZffZY588K7LvTJAu60TD30AVvsQn77I92h0S7LmmWFzoJ4CcRAZ5BDcpzg1c2VOX+VBiPWHJjEM4dv3H83K5VTcR9LnVNcnEWxhQRJjsLjrkfigD+YzKM4c9scMiXCCTAweweZh6gesToTuHIe39+O+cSaNnqIF++QSrwA7oTXmPDX2ONIoiG250VB7OdW4SYR7+riWGD2G//BXfl0hUijVSb+VDgoCwrJmFJRUWVl8JQVfdrAwtfXvJCUbggWSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jo/DWVyS5+pZbb+y1jhEUYpHMlftbtAFtf70M1bzNk=;
 b=fF6RBCN75d6Zqe92yQCaZZTf0d/qLtbyNS0mihcefeYmiXX1hAitbY1O+7uOEpQWisUR5XNniisiZdt3IgHltXHp6Ejj0b2HYaJfWxyFeCsW/bMUMw/GMSe/H79LK7apaBgCZ005EsIT1JP0D83e3B67OzowyFw6FI0crW9s6MFJxxzDPxcTZYheF7Ao0mw+JWT67PlqkQ7a1patRCSqmTHO+NzoWTuBpLm2b8bQC3+OS11crCh6HUt2e0VLOxCEA4N6buS6U68mdyeBLnDNVssuXU0hWa8vZfHhIchRfe7x7ngvAZk6v+VRaZUp4uI2VI3xTzAHpS/vA/wxbgeSSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jo/DWVyS5+pZbb+y1jhEUYpHMlftbtAFtf70M1bzNk=;
 b=VAv1Sj7pxpqYslD5t3WV7O4882TTmwZ0ZX/djZPREMrCzIx41M/I4QrWDTqyO2Lf4g+K0sO/A349/sE//TMasLy0jiUpnWmsTcsf0y4uT99qHNADNwkQRqn4AXrjUnhzMTOf25lp2g3oPR2Vs9l/cDu1ITOBOSqwYabXT0qpahc=
Received: from SJ0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:a03:3a0::8)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:51:40 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::55) by SJ0PR03CA0243.outlook.office365.com
 (2603:10b6:a03:3a0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 16:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 16:51:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 10:51:24 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 10:51:24 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 10:51:23 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Subject: [PATCH 5/9] drm/amd/display: Fix dcn401_optimize_bandwidth
Date: Wed, 18 Feb 2026 11:48:06 -0500
Message-ID: <20260218165116.155001-6-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
References: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: ee98bfed-bda5-42b8-3016-08de6f0dfcfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ovRacBSYBEte9gTBFilQYlb4UuNJWd8/GSSZ49gdWbRgjjkL3ZxzMcECfTvn?=
 =?us-ascii?Q?kduT1U4DpkVvPKgbQck81sAVoFRIWqw+SbswjfYWbHs7W5q/109j9hr8tns3?=
 =?us-ascii?Q?2WfyAUtxInwIVpfk1EPsNgpl5KLBvPo+7NZfVA5Qfc5Qz4v6lJwNVNRmdL1o?=
 =?us-ascii?Q?yNDzUESFr4mxOJFKTDUdwjtioAiPaIey36iTNAvwsQ/YH9Y5bNqJ3zSwwCi9?=
 =?us-ascii?Q?FyIXKr3PaRbrbPozZnHkUL2+ceblgm9/OQzLLrxJa4zIN3qvecQhtHESOKBd?=
 =?us-ascii?Q?+a4ORA4NhTMITZh0uprqwZst81VwiqYmXklXnxHVQcOUjIFtSzYzydKyXXCx?=
 =?us-ascii?Q?Uo99K4K2k7ybxs5VJD8nce+rWrG4Ec68C5ggDtmVjPBDCKzPwwlXQg8XVD8j?=
 =?us-ascii?Q?/Gthh0Ezj2D87leUAofF7H6eDJQT91T7fkkF8KlsgfSn0/ITsIiyOJoIgUNN?=
 =?us-ascii?Q?9cemzhlUwyQpqP9cQpAYjXDAyp9FPOzASsL2S8B0vqEZcujNF886xEeL9Yzi?=
 =?us-ascii?Q?uYpeN7BoOgpPKutnI7X7xdBT6OplIXjGenGpY5M1AfYx09YiFf8DtyqrMkOa?=
 =?us-ascii?Q?ovDVuyQceYk7d/+gLOFG+AAzmBoemHx8Ql3A2hih8Oe/fI2cqqf6/hRYjTl6?=
 =?us-ascii?Q?YEqhab4mryZ4ze0iUnQw9XCF4j1zHEhdwzCbQj9iPjBUZYNU2efDeCHjFfhl?=
 =?us-ascii?Q?OpEgZ0wOOVtiz38ee7CeOxKGR9hyIda2nL7rpzHL57PK63GxdwMrbWqf/Vbc?=
 =?us-ascii?Q?3eomTkNeYK3uu/XURvK75jhgqYYppbKKlm9BGcL/bMlqJlWC42/KbmjKHuVd?=
 =?us-ascii?Q?Yo4r5Z34oDV40Mm5/wk1mLBS5Fnk8kEvHI9R9JnAbAeok2+TAXJAfQNfw9l/?=
 =?us-ascii?Q?pp/ACSd9WWQv6LbvqvNtWUIeUaumFvaHj/MftMiZ8xubCPMPsxFy+9A0RfMq?=
 =?us-ascii?Q?q1rm8r6LFLqCzdCGeqBSHuJGtICUFTCvO8chNx6V6ncPgZlJMf8pVwtBfODm?=
 =?us-ascii?Q?QLxJBNC/V4Hj0Tslyu2+c/tpWasMkkVzuEwnYvB4h2bW1/SnU8cLT58zPr/z?=
 =?us-ascii?Q?WEAfqDILB8oEbB0Kyuh/22qBHY0RAWi2qB6ncny0hdpWTHmmjUcjllSp6bjl?=
 =?us-ascii?Q?CwRzvsthAf0H96j39PagSmN22+avaQFQdzjDyBARkXIoXBQiazfmHWQrDwOe?=
 =?us-ascii?Q?88QHIKgM1lA7Eev44TLtF8lpMgXry8errMInE3W9Di7cAnLjysK2mPLUEYab?=
 =?us-ascii?Q?q+JGOJHZnV2ccRtbbc6bXTDYASp/PfzXoxsu/77qx/tk3tqQI74gn0scqSuF?=
 =?us-ascii?Q?WxlzKwnBMZ0+Dq7UQduVaNt1epKqUCrQZOW28Aa0/5j2YGhXzDyyQV/4Hfq8?=
 =?us-ascii?Q?YrHqPQmjzwkVyBEyBI9fp0GEI4LVLuAMNkKKcgdIFIC86oo+C+Pc0aObw+Ew?=
 =?us-ascii?Q?NmhOzDdJ1AACc2631uUM7DS7r7/An7WvQqEFOhzq8tQVp5wDITzR3AU1hWKl?=
 =?us-ascii?Q?7ummWzvDvXHPL03oV9wMKTBB/UsLU6Vod8nrfocJqG2Axjq8H4/Rcro8rdqn?=
 =?us-ascii?Q?sqJSe+yiMl2gG8gnJBgbPQn/13vH+f7uBgijb/3foBNAMp5CBwuypOxgNUIM?=
 =?us-ascii?Q?bMpiXAfIfqfmyURO/pdvP3zqWx7VJBBZ0DWkFYKarHGymqJoA318NAsfsCPW?=
 =?us-ascii?Q?PIFMUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wjvhx1cqigxFXauGjdM2BrNQhf8RoRzJwuV79vIXVZx8POc2msaP6hetpxHIIKMcn17k/9o2jQQIymErV5IYyvy8hsPGDvjsUz4B+zy1erMeYEGVguSmEBO+tXmtf4mbySrbWLeHDO++3+V0F6pJ6fGM9xw2ZOz3gI8bHOBoheOPHio/su3TrtPdrHSlhBxP3Ur5HDdC5jhMG/Q5gIWWD+v4ntaqv6COdbWlcQtK89SQgAeuommt/Klg7Gu2Yx0zWKondVyWw+4W6fVrVhi50S7UyWa+XW+YVRszDHVmrHEOLH0xOAxEoVn1YSE8vmSkfHaYYhmYK1Y6uXfyo5m2hfh595yy2QGE8uyU8mqskePs+mBTICFmDNvURdRFb9ckTmvJHdZBIDPHZlWYiHojhTPgCMBHCyDSRaNob58uLpbgc1RWmV/mLNu3VgXeAguR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:51:40.1550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee98bfed-bda5-42b8-3016-08de6f0dfcfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why&How]
We should check for != zstate disallow and programming extend blank from a
different struct.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f604c30e8493..95d9e17a269b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1483,7 +1483,7 @@ void dcn401_optimize_bandwidth(
 			dc->clk_mgr,
 			context,
 			true);
-	if (context->bw_ctx.bw.dcn.clk.zstate_support == DCN_ZSTATE_SUPPORT_ALLOW) {
+	if (context->bw_ctx.bw.dcn.clk.zstate_support != DCN_ZSTATE_SUPPORT_DISALLOW) {
 		for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
@@ -1491,7 +1491,7 @@ void dcn401_optimize_bandwidth(
 				&& pipe_ctx->stream->adjust.v_total_min == pipe_ctx->stream->adjust.v_total_max
 				&& pipe_ctx->stream->adjust.v_total_max > pipe_ctx->stream->timing.v_total)
 					pipe_ctx->plane_res.hubp->funcs->program_extended_blank(pipe_ctx->plane_res.hubp,
-						pipe_ctx->dlg_regs.min_dst_y_next_start);
+						pipe_ctx->hubp_regs.dlg_regs.min_dst_y_next_start);
 		}
 	}
 }
-- 
2.43.0

