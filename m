Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B152FD88F3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1FB10E306;
	Wed, 11 Mar 2026 04:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qChm8HEX";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4AE210E2FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St+qp5AipyAG2/qijlZfxWXQafrJC0DHV+2/97EFqSCjA2usQOCTJpzlKnIAwbKcLpf04jJ6cqtMPHrB6DNWwRmztHkJhhxhFkO8mKTtJQbSacfLNb7Q2jV2W/GEWjOdgGMj0STetF5RzGlQvgyg6QJy1YmIERhz1cEZXv5sZxbwv9vxZ7PbCXHUAmpkpIgLUq0Dg1ThBc+ik372s6q9OKYnVcCUua3//L+RGWOF62T5j1z9JnaGbx8QfLLg9GrT1Dv69v7wc/sve1fWyxUZ23juOBJdoatz8ecyctq4gBTRHgE+oT28KWT6ATSX0WthLY6xLj0yWHUtH1JCi24LeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gT34DG4bucypXFvqJJFM+cIskLlzpK5nkNkSEnl1GoE=;
 b=xUKwx0iOJ8tfsPNCwzWmnlchPi5l+tmLP3ViEBY8BC0n9Gk1MW2LJ4s43/i9VC8gUwvFQ0FkDrqaF3cq7XWCb5wMRXV7hQb+HYlzm+dvgmVpV4pZ5wjcZRuaV4kDhqpgdR+dAWvzFqWl+k5iHzUINlUHrg6TtysmXruifz6NfUqFfphMlTmsJiGRxhcoY2J169mUDvju2+Vp1vMykJ6FV+MI3ak4Z9pdxCKoiHxzmKlYYjReJ9V9aGARQ3wpwY+FDPPFAwpnOOVLt0zWTkAMwhmxR2UMOqm7Td9BiuhA0ZNSdCsXumdBaKIqNcszsSs957ORfuqF6/ZZGjyMlCr02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gT34DG4bucypXFvqJJFM+cIskLlzpK5nkNkSEnl1GoE=;
 b=qChm8HEXrn85HBlSUFRUYVwFfjv9aU1rgMmQo7LWtH1Tp+bMDBFKCl9Q2mHudOZOngL5DX/4D+wGUJOluO6Hux5aSuJIY3N5dpAhGl2qFjcTwHoa1IGLHyhiML9YScBro4bDgU7Nqg8s60w21fCKRSjBVTr82Ox8CyRJPpUViaU=
Received: from SJ2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:a03:505::15)
 by DS2PR12MB9775.namprd12.prod.outlook.com (2603:10b6:8:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 04:04:09 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::a0) by SJ2PR07CA0013.outlook.office365.com
 (2603:10b6:a03:505::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 04:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:04:07 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:04:01 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Benjamin Nwankwo <Benjamin.Nwankwo@amd.com>, "Charlene
 Liu" <charlene.liu@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>,
 "Chuanyu Tseng" <chuanyu.tseng@amd.com>
Subject: [PATCH v2 8/9] drm/amd/display: Clamp dc_cursor_position x_hotspot to
 prevent integer overflow
Date: Wed, 11 Mar 2026 11:33:03 +0800
Message-ID: <20260311040501.2693643-9-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
References: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DS2PR12MB9775:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bceffc-d547-4310-b30f-08de7f233e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2wB/XTQOq2PitlOu3l/NqVt7oBu+kAD1ywducu8KJwZPkyEn4QeS1B5btcUvCBDZ366Rfvz8i9m7fhAYQesO7tAuIAzGrf0eLn17rM1oTdllaL6Ux49mDvV3XE8y/l1DbHNQXoxiDqeBBhlbJDBqoRZEl7LRIsagRLJC1TPlxot56Vzs522jQ7USIh3afwtjER6yFEwX/gGljobaI9H5cla2QfJL2jHrJbhJwaRFS0YHL/rnWZuuZXW2LPph2ujbwYhOwRPhndzZqeFVdq1uk0RPhd76kBD4UZX3lf6rpgn+mRINzaDc9H32wHzTkYmDW4wWL79OtvDcyGiieU3w0t+SBcXK9FwvUkanxx9vF8cXe2ez61xPNKWesnHgHQgr+FgyIE77QlzeQjWgzUueQMvI6JaftiAIFUTEpEVOTG5wZ4xRMh4jeO1GbeKdHazJkcIpEOSzuS1BYFrIdRXO45d/NUCyxMObbrsjxHU7eiS7PBwkuBc21FaK7fHg/72A9qtamhdZY4NXwff+b+bkXCIt9WSuKclEikiax+CyBPA05/exTs5LpCvMp8/Mr1t7SK3XujcVFHeTOl8Civngv4Ga2lPFoSURUFY6nst71qmXftRBcHS071ca5BpDnsSdQB0w9SPoWbW0Mv6XkGBU2o0nqpPqzOBDpdvA+RNMq+sTRpmrjQL394JAsgWVa+LVJ1i2o804XMZU1J4wFoOR2HN2dMZEIs8xH+A8YDdgJaCmtxWqF75egid9vREBwWx4j0pGGhF+SB1LBP1rI7ZmLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fhIKDrAHf4iryf3UXoNHN9V81CdWBwRvIKtanGV7J5koGEdMKy/7AdCvkPO3nCJ0ZuECnMlsKlkRLydHiiMCA7E7yrix+6fbV3gOHn3fUNa9bmbumMPXgFl/BkmKhHMeSnNovH69cXnnml/g/2ckKvdJVND0rYGdwUKiI4FX6JUQN1X6rhZGBTSPFr/DT7UStj488eL2fzPEhLblo0SxpTr7jackyzruazRwDHdmX7LV0wgltNd4eGPCUoaCaIohrddo4hWJHKTiv+m6KE8a5IKvCg/n4x4dP1NlYuN234bxKo44KX7mUM1k2HGVrKwsa7WyznOwynN+SmacBCC0/zRp1zMDXob7JThRlQ/OVIJWVakc+Y1zsg+0zJzncq8QpFwG9lOa6pl4LegP0KVABTtIk6oJOagrNj/ryO2twgkWIn79T5fOnBIWcGbmfMLu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:04:07.8998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bceffc-d547-4310-b30f-08de7f233e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9775
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

From: Benjamin Nwankwo <Benjamin.Nwankwo@amd.com>

why:
Workaround for duplicate cursor. Cursor offsetting via x_hotspot attempts
to write a 32 bit unsigned integer to the 8 bit field CURSOR_HOT_SPOT_X.
This wraps cursor position back into focus if x_hotspot exceeds 8 bits,
making duplicate cursors visible

how:
Clamp x_hotspot before writing to hardware

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Benjamin Nwankwo <Benjamin.Nwankwo@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 4985e885952d..263e0c4d34f6 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -812,9 +812,8 @@ void hubp401_cursor_set_position(
 	int x_pos_viewport = 0;
 	int x_hot_viewport = 0;
 	uint32_t cur_en = pos->enable ? 1 : 0;
-
+	uint32_t x_hotspot_clamped = pos->x_hotspot;
 	hubp->curs_pos = *pos;
-
 	/* Recout is zero for pipes if the entire dst_rect is contained
 	 * within preceeding ODM slices.
 	 */
@@ -845,6 +844,8 @@ void hubp401_cursor_set_position(
 
 	ASSERT(param->h_scale_ratio.value);
 
+	if (x_hotspot_clamped > 0xFF)
+		x_hotspot_clamped = 0xFF;
 	if (param->h_scale_ratio.value)
 		dst_x_offset = dc_fixpt_floor(dc_fixpt_div(
 			dc_fixpt_from_int(dst_x_offset),
@@ -865,7 +866,7 @@ void hubp401_cursor_set_position(
 			CURSOR_Y_POSITION, pos->y);
 
 		REG_SET_2(CURSOR_HOT_SPOT, 0,
-			CURSOR_HOT_SPOT_X, pos->x_hotspot,
+			CURSOR_HOT_SPOT_X, x_hotspot_clamped,
 			CURSOR_HOT_SPOT_Y, pos->y_hotspot);
 
 		REG_SET(CURSOR_DST_OFFSET, 0,
-- 
2.43.0

