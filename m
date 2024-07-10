Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D006C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2955B10E8C0;
	Wed, 10 Jul 2024 19:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rSQUfPNV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6441010E8BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOe/4lQepo1eT1Q3ElTchmkO4ZPw4PXWzrR2R4GVdgk3zExTqghn5Pe6S6dgs+/wfTfiUacI19AP/Msv1bod7ZoEkf/VtksG1Jl6InGVJoF/wUmHbB3PrwVDyt2o61sTu788pyhcpi05P2xcAPbP2bbqDf6W+obNX68u+VS/YFtW0+QIPIHZ/loBUkvXIcdrso1OjPWJ/C640ZrhtdsHr9YxAtcmaSDlF+eJ2GVfWVOIuZkq+S4kwBdXJgkL72plWLfOw0whkNdTNI4uSZOarXJb67YFHHwDBfWnmSoT4uBYnTwbyyeL7lLoYPgDCOBeDT/QchuCmGoH5R7yBqjkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7BFgj3zorh61LZs2rzhm8T9tn0hjbKKrlYjMVsKsN8=;
 b=ZbXsvhwAAtl8icEuzv7xm4JuvAxZ0xnOtK9o682aj4+wuudRWzufk9KRGUUYelc8zWdSspcfsImSPax2oBJH9I1I91akPkSmmti072BJNuFSl+fR30Z730FSSs7XNOBgPPxr9EvZ5nDL5ecJb6ehJcdtyXhVYCUbj0NMjSuK+FiBJiH1OS+Y9IC1oL6zOIh3Pl/95VsAd3pVbLbMv8C91jTu4expM3POng5mM6kdqWf8HoCSkI4hkUmPQj+56F3iBEL3eJJ48/LobgLx5OXGZd7lYOifoErq+6sDfekls8M6RSbcFpEeKKjqlUStpd1ZeR6Xzn616eUwV/ApMWdmaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7BFgj3zorh61LZs2rzhm8T9tn0hjbKKrlYjMVsKsN8=;
 b=rSQUfPNVX4hNQqde32tZdaVREi8tqzDFRmKHu28LeONa0aNEqZhA11Ng/jPMrgO7W0mE2sA4mfIqU0+OTVTvrHlH4Jv+hSQG45lE2bKOiZ4O4O32z04RW4u1gC4WlnCIpCfK/G0fAGvQCkWVxrwC3PRkmc9Vg79mrHTF9s3gHyM=
Received: from BY5PR17CA0033.namprd17.prod.outlook.com (2603:10b6:a03:1b8::46)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.40; Wed, 10 Jul
 2024 19:39:39 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::94) by BY5PR17CA0033.outlook.office365.com
 (2603:10b6:a03:1b8::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:35 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:35 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Nevenko Stupar
 <nevenko.stupar@amd.com>
Subject: [PATCH 31/50] drm/amd/display: Calculate ODM width using odm slice
 rect, not recout
Date: Wed, 10 Jul 2024 15:36:48 -0400
Message-ID: <20240710193707.43754-32-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 083fcde0-c98f-4348-0377-08dca1180975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Kvto/Ii/iJaqRBB1qkmgF7RX/Xi368Z3FqcVXZkTJAO2Tg8qRF2paW6fRsV?=
 =?us-ascii?Q?uZHtS9IHak5BWBra4CLrnuB/6H1ul6LHXnRqBkqYMbyEF9OaveTxLxzcEIrf?=
 =?us-ascii?Q?m680cDXB2z0FjushNu8DsMTQ2mSsl+6mY11CRbpXqjlFL9MQK5CWkiZSAQKj?=
 =?us-ascii?Q?bt+CIybTL4WuuLoVlvMJMPzAFSnMW9FNkYHszvjQ4s5h06X9Wvxa9U0SRjRG?=
 =?us-ascii?Q?M18W4lWqBwb30b8xhYJ5xLdvXxLMA34xTXaG+vCbRPVSF9egWpm5yw29etwm?=
 =?us-ascii?Q?ABgI9jK7Svq67c2h0xCutkLDj1n2PSKM48bD/BUnmLmhwfdyOH25doeHDdED?=
 =?us-ascii?Q?hlZIFv0VbDb8ENX7I34wE515p4s7X+jfvnQ02o30v53MEZMDx5EHKUZMgysq?=
 =?us-ascii?Q?R60VDlID0FKHWjXt+oL7a8wMB+cPPeQ1Bmb8jR11qvsKdYFu1Y4PBmgNrKaj?=
 =?us-ascii?Q?/uROiaGfpjfPkDdqS1Aqg30PmHQowwf1bTGjzDdDNUL+DqaAW+8q7O2bUVVq?=
 =?us-ascii?Q?8gwKpmJBw2dDDOx3A9EaCxLYc/VCHcC5XtCyGIgRGWJ+gu56Gzu5YCW89pmK?=
 =?us-ascii?Q?q+YRnVedA9+Fl9SOVWzntk26MSEwnIiJ8sVzHw6WTlhBMzrXBD7PbV6dAncY?=
 =?us-ascii?Q?fHafwOuVtMCAwGUG1p0zJR0RKILDZQGDozeXBSmVZFx5KkrNpO2aAHS0SNtR?=
 =?us-ascii?Q?foz0Sv9Mt9PpLor7WHaiq09I/5LvKfwYMX2k5tMc2HPJ51ljVVd/njKC5MP3?=
 =?us-ascii?Q?bQ+OKJ7eKwI/KD8zte9Pcn+mrO7mg5acuwChfGc0X9LPWiIcTUU/d5Z1H4FF?=
 =?us-ascii?Q?77rmWR7KKdnvgO07LvzcdREeXcf7xmz43QkwIeMXbI+5kYzyubL+E0R1Eun3?=
 =?us-ascii?Q?n7QfRoBY6jP+k/5QD8MedUZaZ19pLyIc0jT0Wgs+akCaOu5pooibV3S2W9JU?=
 =?us-ascii?Q?rpHWd+gScQYpkFu7qE0xhRh60O9A+zEw+deGrAN3CmQ+3GRKFlUnertGDO1g?=
 =?us-ascii?Q?T0Zn4f2seqgLq8/m9cR2Ly7x49ZXhn47jpI0m59xoBFnbS4PIKWh9F+Kdnvd?=
 =?us-ascii?Q?zalEWkpQQ+o9YyEUp4WDBjb3V7MNW1BUayzDcVUn6U/GqENquvURFdPSYTB2?=
 =?us-ascii?Q?6QzbMwnAJZ8wPi5R5EQyvjOK/omX/kliVMLYjkPGVR0arTdwU5NSlWhMstlM?=
 =?us-ascii?Q?szP1BEpXp4RZq7m1xUxf6RA5EQ9xg5/A4me4oAXB356uvzawWL+nfTx7Tiiu?=
 =?us-ascii?Q?aTbqJU+r0BBkvKWmPX9oqAF0hBTHvicJUV71NeuDFY1UfEk8Hvndz5rlemu9?=
 =?us-ascii?Q?hSGlnANjJULFv03Pq+ed+I+yUIajcNNppL6YXK3dF4yvop0TdAVEvTJU1l+X?=
 =?us-ascii?Q?yW/JOWi2FKrjjV0bzHeuTGnr+bH5UVP42RK5VyHNidUovFivj/ogEsSXyHMs?=
 =?us-ascii?Q?AGx6R9gVB1ozPHJg5HiyVWLXwkk9Rn3h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:38.6437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 083fcde0-c98f-4348-0377-08dca1180975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
There are scenarios where ODM4:1 is used but the
surface is entirely outside of the first and last
ODM slice. In this case the recout.width for the
first and last slice is 0 because there's no overlap
with the surface and that ODM slice, but this causes
the x_pos for the cursor in this scenario to be
calculated incorrectly. Instead we should use the
ODM slice width instead of the recout width.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index b9378f18c020..31e0e9210dd7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1115,10 +1115,10 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		.mirror = pipe_ctx->plane_state->horizontal_mirror,
 		.stream = pipe_ctx->stream
 	};
+	struct rect odm_slice_src = { 0 };
 	bool odm_combine_on = (pipe_ctx->next_odm_pipe != NULL) ||
 		(pipe_ctx->prev_odm_pipe != NULL);
 	int prev_odm_width = 0;
-	int prev_odm_offset = 0;
 	struct pipe_ctx *prev_odm_pipe = NULL;
 	bool mpc_combine_on = false;
 	int  bottom_pipe_x_pos = 0;
@@ -1183,12 +1183,12 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		prev_odm_pipe = pipe_ctx->prev_odm_pipe;
 
 		while (prev_odm_pipe != NULL) {
-			prev_odm_width += prev_odm_pipe->plane_res.scl_data.recout.width;
-			prev_odm_offset += prev_odm_pipe->plane_res.scl_data.recout.x;
+			odm_slice_src = resource_get_odm_slice_src_rect(prev_odm_pipe);
+			prev_odm_width += odm_slice_src.width;
 			prev_odm_pipe = prev_odm_pipe->prev_odm_pipe;
 		}
 
-		x_pos -= (prev_odm_width + prev_odm_offset);
+		x_pos -= (prev_odm_width);
 	}
 
 	/* If the position is negative then we need to add to the hotspot
-- 
2.34.1

