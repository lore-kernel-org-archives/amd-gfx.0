Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E315E7718D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A426710F07F;
	Fri, 20 Dec 2024 21:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ccKO0dFs";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E6210F07C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUAogW+grnoYOD+wHAqoE+KMZMHu/mI6EBxEgddYyVGDI6Js6Ebk2Q+6ezChkwIBICxQcHwI4v96Rd0xK8YOG79x0NtpYvFjIyKQdAMKNFtD3pvxCg4MitwXWR9uhyNXOrvNMo+e4riliQfi5dLka4v+lt2ik1Rk4W4uiH9InUyzKOFlMnGmx7GexHZEOBi1tLONYAezM533rEmSG9Ye+eUm2n/R3AKJGC0V65u6Z6Kshl+k8IOPVm/YYXTeGeLkEM4Oak5tiFYsjNve/D2gOJ8hAirgHKidF1V0jQ53kR7ZXXwHksZpNsoOfM7fWl4G3/uFZaDqjSc3xkDvDXoFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cTs8EaWOl1nYsZhSZ1+JJ1k49Ng25py2N6UxsfC7NU=;
 b=Nwvrqhmo3YYy1NTvO4w/tdSBC5F+FcHf5oMgE8AO5XkYS6WcGWbkLf8V3uP4que3ERA7s0FQEl1XSyJu3C3LvkrV0MwaK79TuHtudvmOLxi2oXN+lvSdnkUwvoOpZ+0jtVlhX4EE8U8ncaHLllFH352jpQqxK/vAzrPRdRfi/rZTrYTTm0SEPmCN9JRSsNSDBQi4w2dueV+q9//YtYCkzrvSIJqvlhAQeTAQ3qKFUkvyrJyZhieZWbkphodXJXnYZDs1mal0cz2yS8KmbgQbZxPAHp9DkqqXO2qgSKOCyMaLrX6C0MNpv841ASJkvQOPdU0QlCB593KhLU2LQO5IVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cTs8EaWOl1nYsZhSZ1+JJ1k49Ng25py2N6UxsfC7NU=;
 b=ccKO0dFsArcoyICN98YJdxF8l+Ts9NOWHhL7BB8StBuNCa9jPCYHrUyQeZXOojD2enSBnEl4sorjjAevNNxK7FiioGgm/RUcNws+pX1S8r90+ei1OSQxf0mF80hKF8bcNEPBUS5ytlEmDRT8XaqbtU6Q27ngHkaGlmuZq89GGHI=
Received: from SJ0PR13CA0114.namprd13.prod.outlook.com (2603:10b6:a03:2c5::29)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:51:20 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::c6) by SJ0PR13CA0114.outlook.office365.com
 (2603:10b6:a03:2c5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.9 via Frontend Transport; Fri,
 20 Dec 2024 21:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:18 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:18 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:17 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Samson Tam
 <Samson.Tam@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: [PATCH 18/28] drm/amd/display: fix init_adj offset for cositing in SPL
Date: Fri, 20 Dec 2024 16:48:45 -0500
Message-ID: <20241220214855.2608618-19-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: b535ab33-a08e-45b9-4264-08dd2140701b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RTcOW7+XJiMn7uzVhry6TKLj8HM/L6SzKcFjl7RwPBsDK8wb7oMwBUmtEbqj?=
 =?us-ascii?Q?ibBD/hGq150w+NgFWJ/lZnGFpEWIfx3k42u+yB/OXlB8qPUnt2Sb5gqxTt/w?=
 =?us-ascii?Q?KdWTD9++Wf1Xad5iZpTL3Yw90VtYZweYZIzUUhxThA6mPjxlckwnQS9Ph4KU?=
 =?us-ascii?Q?05bQOYMzpIB9YWl5nAXBYeKz/6oXy5EqZgOO2XsIg0afZmRmyYx8FkuQgDKQ?=
 =?us-ascii?Q?HeWLuWCl3XXva7XCuErX6ktYtSqESz7KNjDJNIJDSMPnp7VV2dEUKWZAEbSM?=
 =?us-ascii?Q?NWyD2NZh0Neb7kxmkfNWrzPChNSaBRttMXuP/UtQtDmTz64y9vxDtse/mydd?=
 =?us-ascii?Q?Swnwg/dS/rd9xB9eXYh6kmJetwdWFpofr2zawKEAYtwEaCJBio19V6MW9TyJ?=
 =?us-ascii?Q?58AOSxF68LC5V2S/pfxfT6p3HIfmkwZxFM/W9A7Ypg/4G032ihNps4ssnQwI?=
 =?us-ascii?Q?bK1h3Ku8t7KKWmcsP5R/Ns44O//fPb4/qr3H/EOO+I/GPVPzg342gJMWzYFR?=
 =?us-ascii?Q?wZmI8XvoCDNWq5glMCChVkaBtpxjvUOqTCdy+btHPuttVEvnb4MllXKz0t90?=
 =?us-ascii?Q?LdsQTyOG/egmfBCmjKtLGyt/83Oi3pAcUHxstbcjI82lqyO2Ir4six61Lpla?=
 =?us-ascii?Q?mJVDwuafHLg7fAckDjXBqBNN6OmCcyyKdF79YbKXcWs8WnpgGc1G+0+fCCV6?=
 =?us-ascii?Q?h5bjQdouR1Yp35dmoUdKg4fcqGpDyOiqJCIGwUUhuWdlEbqEZuhdQ81j1Rrz?=
 =?us-ascii?Q?rtqj8lMeQ4i4cvp6kGaW2LhWdJIto8MMkCXGR38vDu89M0lfYLvBzT/C7Zmg?=
 =?us-ascii?Q?feNmtjQRHXICZeAzbHNvSNfcWm8E7dIB0g4xwjlQ9xyjef+fvolP1w6Qk0du?=
 =?us-ascii?Q?u0crNSOJe3JDUk1aqrU2wEqzxJGwGmzao9SJcA9zJH6zlix7fdOn9K+tdxSm?=
 =?us-ascii?Q?SXp+60hQQO5lm53qZEDEjlGT5WTrdUSiHLFR/x9CmC/Ho6T3KyfAhg4X1zvj?=
 =?us-ascii?Q?lrtP7zdYXfsktCp4ZSWPFJ0ZiX5i5XoOiV/KS1NeJClttD+PQOwYXq0/ivz9?=
 =?us-ascii?Q?qdEVcrhIVm86dVdwr6EVGD/PiRhLD3UhJgMWZSrnyw443XCY6j4STFKQ+9aj?=
 =?us-ascii?Q?9IpFCDAm6FQ3kiZ2sR546AuDcIu5tSuI+9TinA4k3RTlws2q1n3mlDwHRZ5b?=
 =?us-ascii?Q?sCjqXSpD7P8G59N2dlmnCsVLv/6KTYzbjjX06kNKuUvj64HHVDhOxdCJIzNu?=
 =?us-ascii?Q?HCJ2rZJFROuKI8/J1Al+u+oZ9H22Yd0YZf8o02KQ48I9u7JYBJ8IHchZ8bRf?=
 =?us-ascii?Q?nywNmYEZGBYmRQcCfpaYTwEj0muMOum6afUeHRv6DVwlxYjQeiGZbCTUjx0v?=
 =?us-ascii?Q?TQ5NkQHmnTstv3oCjI6LZqCAsuKtWih7o0erqWlyKV+RM/UCEPrCnaPzzLaR?=
 =?us-ascii?Q?dUI1dhKA9FjlnMXaNMBzI8dnAX54UAugF19o6vQGs3mSitoh7JKEvy8IGCug?=
 =?us-ascii?Q?Ug6weIkdxw6/gnU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:19.7217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b535ab33-a08e-45b9-4264-08dd2140701b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
init_adj offset is applied when cosited not interstitial
Adjust cositing offset in SPL

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/dc/resource/dcn401/dcn401_resource.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c           | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index d75f8da63e10..c6ed0b921523 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -737,7 +737,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.enable_stall_recovery = true,
 		}
 	},
-	.force_cositing = CHROMA_COSITING_TOPLEFT + 1,
+	.force_cositing = CHROMA_COSITING_NONE + 1,
 };
 
 static struct dce_aux *dcn401_aux_engine_create(
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 1306ce0321e2..a7f36b5c53d1 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -633,20 +633,21 @@ static void spl_calculate_inits_and_viewports(struct spl_in *spl_in,
 
 		switch (spl_in->basic_in.cositing) {
 
-		case CHROMA_COSITING_LEFT:
-			init_adj_h = spl_fixpt_zero;
+		case CHROMA_COSITING_TOPLEFT:
+			init_adj_h = spl_fixpt_from_fraction(sign, 4);
 			init_adj_v = spl_fixpt_from_fraction(sign, 4);
 			break;
-		case CHROMA_COSITING_NONE:
+		case CHROMA_COSITING_LEFT:
 			init_adj_h = spl_fixpt_from_fraction(sign, 4);
-			init_adj_v = spl_fixpt_from_fraction(sign, 4);
+			init_adj_v = spl_fixpt_zero;
 			break;
-		case CHROMA_COSITING_TOPLEFT:
+		case CHROMA_COSITING_NONE:
 		default:
 			init_adj_h = spl_fixpt_zero;
 			init_adj_v = spl_fixpt_zero;
 			break;
 		}
+
 	}
 
 	spl_calculate_init_and_vp(
-- 
2.34.1

