Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F6CD69112
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 14:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A5D010ECAB;
	Thu, 28 Nov 2024 14:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i4tgOZdg";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F4F10EC96
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 14:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phEGjOEZ6igKaRtX3fvzpyLSOpW2m5MJdURMMGbV0UuHsAOELsk9QvgdoPNguCONgg2vpt9jCGZIDYY3ZjJ+Xs1zvFpLe/cyrLL0a3YWv0Et42tRLDvJWFGl/QVEyOg3FN+N0+Y8KnfezCf0CSK/ESQazFAQ+2/IAfHkpD7eNp0mmyBXrNTa16C+TBkB+cpNCixDebmqHmxxYNq8xMQAS4Z5hnX94CWG5YMycty5g7h8mttbEeAH7MXILg80eyfAGgtivHyU3+gD4GrD6gzhiePOg19j4bA+wzov7lpiHoUj+Fea/Q+POYlY66Lr0E0Oq1kXaklVpZkhJoAGrfmjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAv4Zg0n0mJkvKvww97uf92BcaJENyUHrIFAECfyX5U=;
 b=mag5Vu2VHbgL+5gj11dRufJZA/4RZ2ijcF/UDZlK9P4OHVSUnvt6j4LSoA/lvc+ZA04RPMcpFGI8Xy1Ouw6d1nNcfXusEecXFJcIg02qVq/qeG4gWJeBnbY9GAKrmiNDdtEHtsW7GIEF12YSMPy82tBDl0Yo6/hGpN7nO9gayfCeXaPERCo/ebknHyWEDzHNOCRR0YuiCsPngvyEsMESyjYIJP1c6311NcQPgk0znxbHRI2KnAtGn466VGQfIg5R7vdChFGCcSA5ZqlrzbXTpOV45H8UZArolxD4Y2vvjx5Tk7Y29LbQDImhYRC+V5nPFBIJZhKJSZ9Yic+lRnheng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAv4Zg0n0mJkvKvww97uf92BcaJENyUHrIFAECfyX5U=;
 b=i4tgOZdgCT70/sACj9+XmAAwHjH9iJNTGC3HwUiHiub/ih2dUAIw3G0Doii+hW9SPGykR5BbDScAlUTL7GTfM8zGkXOrgRoSF19lNfIMev72AkAo2V5I/EDP5vFfl+405SaeUBjfRAfpqFnpuEa+CHw0Ft5n2M8TdU6Ch+wUPQs=
Received: from MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::26)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Thu, 28 Nov
 2024 14:30:17 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::8c) by MW4P223CA0021.outlook.office365.com
 (2603:10b6:303:80::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 14:30:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.0 via Frontend Transport; Thu, 28 Nov 2024 14:30:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:15 -0600
Received: from jzuo-linux.phub.net.cable.rogers.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Nov 2024 08:30:14 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Dennis Chan
 <dennis.chan@amd.com>, ChunTao Tso <chuntao.tso@amd.com>
Subject: [PATCH 1/9] drm/amd/display: Revised for Replay Pseudo vblank control
Date: Thu, 28 Nov 2024 09:26:23 -0500
Message-ID: <20241128142958.28370-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128142958.28370-1-Jerry.Zuo@amd.com>
References: <20241128142958.28370-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 10868a26-ce8b-40a5-de23-08dd0fb92dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kRIYEFr0mxXyLoJzI5C3wnbIxogVX/rPLZWlerknKo/f0gsJeYFKbYXMbHrL?=
 =?us-ascii?Q?Kcv1w/HwBIdtRpXwKEHWRvdRDpxKjMsX9+aZ3Vz3CySUsSnPiqZVW32OEI4i?=
 =?us-ascii?Q?v6MAphpuPLGzsH62Mb/UnPG2mI5pW+9CfJUUz4+d08DKOI+1zMCmylncqB6E?=
 =?us-ascii?Q?ZIVYFHA2FNnt+YGXbWGZu7cc3blkbPgE9s5Tpmd1XK2n1ni2pFQScZZcNQJF?=
 =?us-ascii?Q?eUflu/GJ+TYbpH6EKJh9BbgOPEInqu/GzOfNeddG+6H9Een7EiqPXAtOliUr?=
 =?us-ascii?Q?thNm04FMzGoRYh+Zoh145d+EYiAuts3JNbjOg9FMpOKF9xj+YpLYrm7xZ/YU?=
 =?us-ascii?Q?EUCgTL1CTvlugHFesFlmcHuOOXZqH+aERP3sxoPXKGttaHdZPoXMv7lOL4fu?=
 =?us-ascii?Q?+kZuJjeYPNsEgjD6UD6Bgqf5ENW1oSOsfC+I8UX5VTcy7RAVAFoYBi8IL3sT?=
 =?us-ascii?Q?mktxJZEMjgV+C3nClzFv+7Gzk9ddPCOBDk+yB0/KYIy3oKyGMvwjBSqk7Rn4?=
 =?us-ascii?Q?aez90uJ78q3kJCc7XzBAFzuA4ROEjEro4fprpNi2bmFvIU9g9lhhuInX7oyf?=
 =?us-ascii?Q?2dYLzf4a3+rWKYFyObPdJNnIHhHphPvucYx+DfFyQ7k5leyzKwenjNmrtLo9?=
 =?us-ascii?Q?Ca8R02JvR80LiQM8m4eQDxMCljNvp9qH090WUl4h1PFMQ5DrNIa803TzrBYc?=
 =?us-ascii?Q?zVGAfhd+2L9jMh47G5FSZuKvtpOvvAja+91FejTnqBJtBYXZ54cItT/RjFU7?=
 =?us-ascii?Q?NIMLLyy/V5EsWYpB7Daa3yFqxY51dYyk8AlmhNi7JpLXsZ8wOOozmUBF7q+f?=
 =?us-ascii?Q?BlKHSR6hC+7CAVYxcbZ0edYoDLGPAeQBXrBeoQTBz59KwXA+X0Et9g8J6OKa?=
 =?us-ascii?Q?Woo6qbSGPIQjoJth8Yrw9WE1HMT8RNU1KCOTWlVjMTNL4eRbQJodinOtrj57?=
 =?us-ascii?Q?Z7GXCP2tTW3CvRbOFslXpgkKSWwJZdIfqCphUni4ZDAEmywvEk2ZC1IbDzch?=
 =?us-ascii?Q?PQ79l/BlzIeYGcQgEZR6zvQSD/NW3xArikuGlv5oSrHMnl42upbjmhqPyQEC?=
 =?us-ascii?Q?NyIZ5dA10bBGcyZM1i2faKDTzv0vQhMH7bTRlJ+nE7v/3D7g0FrgqxueteO1?=
 =?us-ascii?Q?BLm+Pdk5F9ZWhEZeEt5NlUptRlXI/izWtychWymQrVx3dQPUtg0TiDjxx7zr?=
 =?us-ascii?Q?aFV9K19Oxo8wn16BsXSiAuOtoyYL0njE+167TY9Bt/qZKsR1si4g6iOQqNnu?=
 =?us-ascii?Q?vAAKF4Jj9ZStJnMf6uVTsBd3lWY6BgeZPOttSteNbr777xr6b/3Oz2feIJSK?=
 =?us-ascii?Q?T/eMHtxuaQbx6qhG+Hd1ypyUgPd0nR9g91fnQtVVjmkqRdmeJR57L5H+/sFd?=
 =?us-ascii?Q?NRLWrRryBlJjOTsiI3qpRQu1ppIqDuIz9Z0bx7hAcYHZKLKWRCbEH4Nt4kyA?=
 =?us-ascii?Q?R3xTxrAAi1bujUTvzJle42ugDaCDrf5O?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:30:16.7862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10868a26-ce8b-40a5-de23-08dd0fb92dde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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

From: Dennis Chan <dennis.chan@amd.com>

[why]
Revised Replay Full screen video Pseudo vblank control.

Reviewed-by: ChunTao Tso <chuntao.tso@amd.com>
Signed-off-by: Dennis Chan <dennis.chan@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h                 | 4 ++--
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 4 ++--
 drivers/gpu/drm/amd/display/modules/power/power_helpers.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index edf4df1d03b5..025ab521be25 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1126,8 +1126,8 @@ struct replay_settings {
 	uint32_t defer_update_coasting_vtotal_table[PR_COASTING_TYPE_NUM];
 	/* Maximum link off frame count */
 	uint32_t link_off_frame_count;
-	/* Replay pseudo vtotal for abm + ips on full screen video which can improve ips residency */
-	uint16_t abm_with_ips_on_full_screen_video_pseudo_vtotal;
+	/* Replay pseudo vtotal for low refresh rate*/
+	uint16_t low_rr_full_screen_video_pseudo_vtotal;
 	/* Replay last pseudo vtotal set to DMUB */
 	uint16_t last_pseudo_vtotal;
 };
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 95838c7ab054..85400ef5013a 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -996,9 +996,9 @@ void set_replay_coasting_vtotal(struct dc_link *link,
 	link->replay_settings.coasting_vtotal_table[type] = vtotal;
 }
 
-void set_replay_ips_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal)
+void set_replay_low_rr_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal)
 {
-	link->replay_settings.abm_with_ips_on_full_screen_video_pseudo_vtotal = vtotal;
+	link->replay_settings.low_rr_full_screen_video_pseudo_vtotal = vtotal;
 }
 
 void calculate_replay_link_off_frame_count(struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
index cac302e8fa10..43ceeec417f5 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.h
@@ -62,7 +62,7 @@ void set_replay_defer_update_coasting_vtotal(struct dc_link *link,
 	uint32_t vtotal);
 void update_replay_coasting_vtotal_from_defer(struct dc_link *link,
 	enum replay_coasting_vtotal_type type);
-void set_replay_ips_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal);
+void set_replay_low_rr_full_screen_video_src_vtotal(struct dc_link *link, uint16_t vtotal);
 void calculate_replay_link_off_frame_count(struct dc_link *link,
 	uint16_t vtotal, uint16_t htotal);
 
-- 
2.43.0

