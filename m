Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240EBC531F7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B05BD10F1CC;
	Thu, 23 Jul 2026 20:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zkDggUJL";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FCC10F1D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJPEEmgtEyg3xIp2mAZT2DM0dLezgsA5QwlPqJAI03GIL5gOz85GIZhunkEweBmVUi9cDDOSVuCL8RMg4jesPzIqRnNObQ5XlbxQ2gzr9t39wNeYgSExOo13IuvNPZElbbHlKf9moLDIgWxDAWRf5u4a5RMebSOw/VM0CuWavI534dDmpSdMNETgP9UtV8SNo1BTBwO1my8e/QtpZqINe0mcN+9a1JyABx/X4TjYtG8k7Se65xnyhtLb6GVU3IShA7t0xqvBPIE28DZRzbb8ImhDs2b1upvs8GVR4vcEF4WAgYoBxRroUkKuWFOpZEbXlrZOGrYkUILveJMtzOAMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWoxHMHTdnsmolw0/IZLJIzCFYyX2SYnd+ofT8nxA3Y=;
 b=Zin4gzC4zOaBZ4zj6qIUroZmc9kT+OWj0DW39gJC5+6dpiZvcLiOXaRfCp6I0niYyCBuw6YKLZ+sFDLBg0hK8yTdZTmqXndOr41c8Dr6gWZdq/Gwt1y4RkzW3Wab8h1pX6rni7NFK5bk7FDDoM8ME1BZD/OlY/3j1PAP7qaNPhQWFw1Cnk0xePmTP3pWBQU1Z98S3BUb4Lc2K5K/aqGa5h/WarNMZDEo/xRdC4k7FrQXXj0C36ky+KFyTp1bZnIftR5xvh2zzx4FErdf9QcCpZBu2lGSfKL/UnqtnpjjvhrVNFMRYxpizJY+XxDvNliDEYtEWI/afNTN6ZMPC3bBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWoxHMHTdnsmolw0/IZLJIzCFYyX2SYnd+ofT8nxA3Y=;
 b=zkDggUJLer1Igqyi2DUEHedEZL0Bpn1PZXOba4siWieyry0cPirpBZfoh76g/eER3kFeorYQbpSuw/PtrzLncMjS9LcaZQZ5KJN2Mk7XukD6mxPSK5J1NW93Eo+XCY6i3AQxVURZy9F07X2g97dcZgRCbrMYPUbWT2vNBlFAUGc=
Received: from BN9PR03CA0683.namprd03.prod.outlook.com (2603:10b6:408:10e::28)
 by CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 20:19:15 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::20) by BN9PR03CA0683.outlook.office365.com
 (2603:10b6:408:10e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:15 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:04 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Nicholas Carbones <Nicholas.Carbones@amd.com>,
 "Dillon Varone" <dillon.varone@amd.com>
Subject: [PATCH 21/49] drm/amd/display: Correct vblank_end calc for fams cmd
 packet
Date: Thu, 23 Jul 2026 16:13:29 -0400
Message-ID: <20260723201908.373300-22-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|CY5PR12MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 59250fa3-ffaa-45b6-6bfd-08dee8f7aabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SJPJR4l4IuCpKnSZ4z3JLrzrYwuuJWDAs3KJgtB72FygXcymfITCQ5JnSlG2r3vZ0v64cK0iTkM+7iX0nRGNZ5+ljvSioQikPuad8WhKCS7qAJwMwfgv6q1xO6H9GSunJbzaiJHXr+6XgwN13EKvSp3126eCQyRwL83Gg17wVldN+meER799j64gnqbN+DJEMKMjbWrOz1SU+P9M5Yxjuf4W7n4/F+F4R5DjBMIUqv/2hqyll+mvOOpB9uJ2yaFYZlkA4oSoQsxOYg8YqzHXs08H1IBShtjoYd/L1W4/w2DtPVgG4cDFKcFSoCztebPHqoOTvNPSt7ZZqvVdl6NLcaXlnnMrLMXAimy08yoSJ+yyEr3gGFJMrBVaCNkGRU5m+3VFUhYSH2FQRYYF4Ka9pO50YIiQ7/TVIAjKVv9y7cVX9jJjocXRrP49oNX5G0uBA0RQjXEkyy5hpveNJlM4CBRYsVncw2ZtbdpE6i3z7QvGZPZae/xjfb9LkTNkcrVPwdst6300iLaIo+dCyzqRoGqLIKc/YHq2Fov0PyCzW0JOMq5MW68bN8lmP2j3h0B5qU+9WFIAf2A1H1lc68L0RMBIqMnEudty9UVleq1sLvwYaWWWgKorZLa4QrMbeOVUzHj24asnK5HMVZlMyiqEvLknAd5B6pve1EXJH6sj8jS4bqYH4pUSTET5rb+H60hcEuJWbrhX5uw8TqGP25ispg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uLlqeicKyxeAdNRsmxNuvQ4Ebokg1b4Qlq0vNADyLrK5wPF6C3UQauFxkOxl//oEppYrOve9ZHrW6YZCotleHnlN0s7FW4rIXMAQU+dJsqmBCKratUMINdbOa0TEUJzq68tWkj9wBlSs9YquHvRTfNgk+sI1EkJ14Tk5ijdGFnGj/xr9eAwHXsfkbOUEeBjlCpkukUzyzsHOvjESAnAZ9hcy59PwJXZ+sxOaW1Y6WusxZ4nWVL1VHUxdZGKyRLtFzsUhseO5yQ/+sP4qktEGw5reQzyCXtz2tWrBcgJlmc/NzcIp9l+CDwyWYSYh3JBiMWL+siLMBLgL2zH5pg5DsTvhVmg/FJbTuF7tiJz35Jc7yvRSowqx9dPF+nLTGpdTiOFcbW/wnS6I+rvgDTSflHk3dutrVU35nV6RZ7RjFvr+iQGCr/E8tn/qJp1dGyWc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:15.1602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59250fa3-ffaa-45b6-6bfd-08dee8f7aabb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107
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

From: Nicholas Carbones <Nicholas.Carbones@amd.com>

[Why]
By changing how we populate vblank_nom, constraining vblank size, the
vblank_end calculation for the fams command packet gets affected. We add
up v_active with a new vblank_nom value for stream pstate's nom_vtotal,
which describes the vtotal and nominal refresh rate, and that causes
underflow.

[How]
Set nom_vtotal equal to the timing's v_total.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Carbones <Nicholas.Carbones@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 .../display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index d5f20c85006e..8f481ef9316f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1710,7 +1710,7 @@ static void build_pstate_meta_per_stream(struct dml2_pmo_instance *pmo,
 	/* common */
 	stream_pstate_meta->valid = true;
 	stream_pstate_meta->otg_vline_time_us = (double)timing->h_total / timing->pixel_clock_khz * 1000.0;
-	stream_pstate_meta->nom_vtotal = stream_descriptor->timing.vblank_nom + stream_descriptor->timing.v_active;
+	stream_pstate_meta->nom_vtotal = stream_descriptor->timing.v_total;
 	stream_pstate_meta->nom_refresh_rate_hz = timing->pixel_clock_khz * 1000.0 /
 			(stream_pstate_meta->nom_vtotal * timing->h_total);
 	stream_pstate_meta->nom_frame_time_us =
-- 
2.53.0

