Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE2CCEE345
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 19:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1853B10E7E2;
	Wed,  9 Oct 2024 19:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fzCBLBgw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B7410E7DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 19:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5bxmyekvlx+2Qs8TCbgDMtFxgfB5B3m0N4Z2smGEYjV1Aoo97SyDRKqJseMzk5KI9cOpMlDTF5iIhu2Yg/EeesebScFz6ibfa5ySUcrShZ1puP/PY147jDhvUc3a/NXJyf7/yLAlwd7jGUO6InWEwNRfZLOaAAJ6ITpDe/XVef9g6s0Uau4A3yT+yG85k10W0XN4mTkQE25fbcWYQiTIXqrm1RTZfLAX/eupZKMPIy64OLxNGLjDtvqsC75Dav8TLNb5gsmlsKDSMbKEPuahnoAxnsvSLRGRU+a22V51kqQspFV3GaxTcSMPl7/c+NWKlt6ZvuExiJBbSojwLU6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FztxVaepXNyaBFgdxS1hmGXY/+tOlAYuSO7je8cM5w=;
 b=dz22PAqD3JFtKTU8568cecE1R9j4CXLic35+2jaMQrPcPiBpqVv/IMmApDsr/fSKfZM6LLYzQ/kND8HLU1nmfOxe7258TmlKVMILepRcG9KzZDck+zTvexbHTr2Iy4OWsZi3Ba+cyjqkGoPXcfA7Wsimu3oPEtgkl3s3I/VN4ZJ1fX23rtFld9/tzxnrwU8hLR72w6PjaHndaydKVNpyrx6DxRnWDBBvH2QhNOTMOpzMs+lhyiVIS04OQPon9VfM6Rl6VZX9fei4IFW4I0oC/kvgtt4cNWVM6QtzO+/kQdpYGoYZ4UZy+66KQfXAcPpJ1/yAlmlKK3al8aFM5gPZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FztxVaepXNyaBFgdxS1hmGXY/+tOlAYuSO7je8cM5w=;
 b=fzCBLBgwfeISC9SZIlsymenaGFpyuFYxE32LM2I2CdPLIimw/4n+2h3208LkckLlKABhIBYnh7SrOSJt5mv5svek0UdDAVyOtCwAvaA4wnwAjuIKh4Hc9yUMK9Gsuy+Zo9i9jmfPQND3GuFLIZUCglZt04VL5hiMQgjHNSLYiKY=
Received: from BL1PR13CA0439.namprd13.prod.outlook.com (2603:10b6:208:2c3::24)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 19:26:02 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::85) by BL1PR13CA0439.outlook.office365.com
 (2603:10b6:208:2c3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 19:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 19:26:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 14:26:02 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 14:26:01 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, "Leo (Hanghong) Ma" <hanghong.ma@amd.com>, "Chris
 Park" <chris.park@amd.com>
Subject: [PATCH 07/16] drm/amd/display: Fix Coverity change for visual confirm
Date: Wed, 9 Oct 2024 15:23:35 -0400
Message-ID: <20241009192344.650118-8-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: da039ad6-1f99-4c2e-ebcc-08dce898365f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KvT7sOHsNFYCjOrOSq8sYSM6C9zKj61oxZZu6sianlipV/wArqeVG3gZq/Te?=
 =?us-ascii?Q?xLprQzWH7Vr7EmxKLK0poo1zJKY1XJJU3u4eqWc9gqP+4wgDs3bh4uXK1sST?=
 =?us-ascii?Q?i8DXpSxmVuVRVJspltORB2O+6YaWoAftY5FWOb9tYrlhTfMWkc/MqEnM42jb?=
 =?us-ascii?Q?BmR++Xuik/ZLfR2327TUTdFiR5/QEo3L+ZxrCniKX50dAu2DoG7e/sFgkXmd?=
 =?us-ascii?Q?5Xf3MnyrdS3tY5Xe+OqBD++wWc2XTBSt84hzjxxlwsYwlgVS+cL+/boo89IS?=
 =?us-ascii?Q?sy17ahSHSbHc7pX4jwAQmfB1Wgnhqia2DphJk6XBK5jSQOVzKC2XBSjxA57w?=
 =?us-ascii?Q?QvALWgFniyKupMvsZdbTIml0UfVivFx66b4REIR7IUNKnkY5IRJqAaFe6II7?=
 =?us-ascii?Q?2om5iKfrEwdfka72kMvcdiQqbJzuRfYpvy9H+CvAS8UgB5Je/QHD5qXouBSj?=
 =?us-ascii?Q?Hssfr7Wgjq1Wz5qdQzX4gScrNbvUFFRo3/HJ3HOfrorn6xzruLzvlE+Ujndy?=
 =?us-ascii?Q?uOQyWouFrhwCYuLhyYK+rZ3bRn+JII2WWfPWHhupXCbTRJ7mbKm5kRhiWQ2w?=
 =?us-ascii?Q?Kv+7EFgfCLjU5wGPZZu5AZZ/51cqfNK3V7NXp7aUDpbe5BmWLxyAlp8zzuyO?=
 =?us-ascii?Q?0XU7eaFrVtX4LRDbI+qlNOxzpum9pwyfc7r5Oo2hCsQZ0f/uQDKBoa+0XnAK?=
 =?us-ascii?Q?CvJdQPlAcW36kLionKedkBXrfk16irZF4oQ+5Mgyk0AGXfrua60PMC6Xwd0U?=
 =?us-ascii?Q?ylNtP4ZJc1wWZRPig65ykNZOB3uhJOSqA3zbL+I55tvMhw+RAZYEoinqa/b4?=
 =?us-ascii?Q?bjD9w4O11YF62E7Ajv/FELlWhzX1MbkRywCMZNXmjsuWNPZ4sEg3pe++DAy1?=
 =?us-ascii?Q?Fnry0YNKSHBYcmfQiojMU8CAH33nUDo9gresqeiphSentCDwLaWHaRzIItVS?=
 =?us-ascii?Q?+aAxWeAGsUq6SB9vJSjCrH+/4X7ZXfYbtnW5hhyP8R0VPfW3Lae7QwGxVAcT?=
 =?us-ascii?Q?80BTQv00C4plcsJyNVpKwL421lvV3Mzoto9SSlfl7IDbV+D/i8dyQAwZXSOZ?=
 =?us-ascii?Q?df9b3g7u9zu/r7BYJs/i2SWzD4GEygp4+Qx9dwpHOdzjjzp69QNrLoKo8okf?=
 =?us-ascii?Q?H8wJBR0PxxdKbg780Ua5wspi+OSMqTjzMD4wTHuGisxuTZyZ7e0DGX444MIY?=
 =?us-ascii?Q?h/myVzpxz8jWajhUrfKRHbWviiGzsyLG4eqCJAvZYpPo6mMSYGDgEkM1Hwge?=
 =?us-ascii?Q?GhEnOmWZQtEA2QTEcV/K93xYmDp6MLfbPnr9Xh1DDOB1xB20txHXRRxLPzYp?=
 =?us-ascii?Q?zXWMWCk5fLB7WlJFJEBHYnnNUIT6mISv0ItQ1VtsDrKdvz6lCWgv96qb4/mA?=
 =?us-ascii?Q?YGNQvKqBbxN0tjJzexv5HJP0mgwI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 19:26:02.4071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da039ad6-1f99-4c2e-ebcc-08dce898365f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
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

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why && How]
Previous change for Coverity has caused regression on visual confirm
so fix it by reverting the part that affects visual confirm.

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 9291f078ffde..8486c144d81c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -519,7 +519,8 @@ void dc_dmub_srv_get_visual_confirm_color_cmd(struct dc *dc, struct pipe_ctx *pi
 	union dmub_rb_cmd cmd = { 0 };
 	unsigned int panel_inst = 0;
 
-	if (!dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst))
+	if (!dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst) &&
+			dc->debug.visual_confirm == VISUAL_CONFIRM_DISABLE)
 		return;
 
 	memset(&cmd, 0, sizeof(cmd));
-- 
2.34.1

