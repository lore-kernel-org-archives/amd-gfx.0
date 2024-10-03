Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DC4CF34D8
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D19010E274;
	Thu,  3 Oct 2024 23:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bREIv3Ki";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A7310E9A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btry0jRRtdPXlaOLjKYqxkLiPEvyfMX7Nx5Rpx4ttl/IbQAogakOzL1EIw15qQv10cS7HTq7A/51O14TJSxyIhy+bmQZ2mtV/DCeMie8msUI6p6VVQOj0xbZNQTMkM4oD72s9SjlC+ai3zTS0PjI0B4pFgEw2jCsWJPpstKux7HfXloAxAdpLrMMADc8L4gPUty1cZDWGnOnYBBg64UuXzWp7sFZQEQiIRsZM/TvvvEK1LtIWmQspC788r5OUO0nZwOw0/sXoOxDNXQjGpIZQBo8zN9pCc01IdrYo8xJF6MrRb07WmqrXZK355r7G3FpSMCtbXq3CSswFRlRldyACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6HkrZCb3jyqEw4LqmP8FKORtiTUOUbZJjdE1Y72Q4I=;
 b=Qf5hZbpUAtme+Qu45fueQ8qH/FiYj60Wgy9BEVFdx37n6WYxP1ltZjaTZQLB7iykxU/wN+y2r3gfCYqDuNrHa0ry8RU8wjn+Nggf/azNxRoIA+oEUhIUDRFY4TbGAzGFN8HWt+Ga3e+Ic9wEo3g33cBKojuvZFSx1WsWJMkoMpWIk9Bb0VD7NZF3BOAxKZzjk8HjC8ZGTPeyB69FztxpukcRiR8ZJvME4chyiMJsVnsG0bpelz+ZG1WPhLpBNgD97ltizxrup3e6lYWP9XBm3mxvsGut8ZM8fAY1CVhaQXaz8UjJ68HJ2FcXyDFIBmEjW19UJ42ZEkp83jJZenFxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6HkrZCb3jyqEw4LqmP8FKORtiTUOUbZJjdE1Y72Q4I=;
 b=bREIv3KiDNgQnsbIn4OBsi5IPPhLMurd8oPiMtrdqzup2+GNfJK5myPGykb81OnUfc1WzIF7flsnD9MLQr7WUKQ+oNAVcrk9nVXxZfJGHKkA5rE96kn/LIM1+LzZvTrxm3d+/ifDFK0Y3vpzy7mNIWH/hCOApkMb99tFNIoEX9U=
Received: from PH7P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::8)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 23:35:51 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::c9) by PH7P221CA0014.outlook.office365.com
 (2603:10b6:510:32a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:50 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:48 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, po-tchen <robin.chen@amd.com>, Anthony Koo
 <anthony.koo@amd.com>
Subject: [PATCH 08/26] drm/amd/display: Display lost signal on playing video
Date: Thu, 3 Oct 2024 17:33:26 -0600
Message-ID: <20241003233509.210919-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 237253bd-c3dc-4f13-8432-08dce4041dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NGv44JVKTGPPGMvoGNA6oUViojKCeJQGtVVYMKAjfhzRt8yPFI4KwFenvx9m?=
 =?us-ascii?Q?BRD0A7C0kPinN94n03bBcA9Uz6x/u42hgevn68Xg1SzvtvaCM1HtCHnqRBCz?=
 =?us-ascii?Q?N/t5tj0NgmWtm9+uT6uGulNf5Wj27aKOe+cM5mpUc2KerIRlD6VtHrtffrKu?=
 =?us-ascii?Q?4haKH8cKKmucckLbQ1/laZnB1qgiIzwRmYoCi3xRv5HgW0zftwE90nabV2Dd?=
 =?us-ascii?Q?IoHea1Vc4Q5k2b2+QnJWoDA8UcwJiYVU5EbYTLy5xZVlv67ao9t4Na5Gt3uI?=
 =?us-ascii?Q?ZJVA2OczYuhI/S4/xN5sHol2ismJu31dGwyo66CPODnowSuYgXnm40DlkNzR?=
 =?us-ascii?Q?Rn4C2EfJyaGZ/Pp3DuIKaxaWKxetdARq0rfqYRnSa1HTBcN7nT7UT3nEdtvN?=
 =?us-ascii?Q?G+9wXuV9Xwnjea47YeLYc2R0oF/+/Q6l9tFW20UozaTSl8e4HgtFJNmQ+HpT?=
 =?us-ascii?Q?HQcziF7y6XG7oAUExFf8PBqko026xPFmGDZFJobjfxxR9iKNWADYNvWzUxD0?=
 =?us-ascii?Q?sTWnRv4R9mV/6FN0GToO3mV/LyrEbJcNcjkhStwTulBgdpMEDBo2qYwyjTNQ?=
 =?us-ascii?Q?42EPAaJGweHlMhdnIXy7nrEFJM/GPZCY2m2dTiXzeVkXClC6gAbf813BH9dN?=
 =?us-ascii?Q?8/zK3m8tBog4cuA6L4dQc7tuZXWZVwbsU/cjFgZeCSO9V0NO866oerFwWga+?=
 =?us-ascii?Q?0WTMA1dZOUFI+H9WeJNpeCtXG7omAwlUxiFEBZRKZEKXMzDEkhjttA8dKOBM?=
 =?us-ascii?Q?pi2ePh5woG0zbe+SlVtmGX9dtYeQ0XkUAtym+uJKg0FpGd9ukzi7hAMKfrW7?=
 =?us-ascii?Q?1mCZzxgEUqEwubo+zEyMIrIHZBFm9tTmI5g5dRtzkWchCql5VxzG7WSIAkmQ?=
 =?us-ascii?Q?XP+JqvHEipHO0Pntp1wmVufBDKg+r7m8SgaQ3Hi1BrqTvrvjW3yHz7y4mym/?=
 =?us-ascii?Q?1/DurOGT72z8/bDM9i3WNLQfj2uWPT5yGFUK1hCIGR7fibFo7YkZOtTZ9ll0?=
 =?us-ascii?Q?5laqazIB+NyeHHXUXagSAOAhIrb27G6F34nPOQEA1dbUk7mx7dcbioJQVxxF?=
 =?us-ascii?Q?o8X8X1aRPN00TXi1NfEreOJRvxdsrC9dIg3hbX0RCtuQGzQycMDV+Ot5WjnB?=
 =?us-ascii?Q?7AdoONIZZTk/jZnfvJL2Z0dz9pj03OSMqNb7OiBgVH7x0PGOGQ1RHr92ilEl?=
 =?us-ascii?Q?Kh5t1mOfUSfxT6KAzEfKRijd7IYWmuhidAZ05LILSMqjURnRZhqvUGPW9hI8?=
 =?us-ascii?Q?vgy/NTfKmL6saPEkREVwZx1HMoHwuxwB4CNsLt+ezyeQ1sYf3mZMWWXxYEtW?=
 =?us-ascii?Q?a1ZX+i781JEhYuVb/Eaako4QR3qmyk7HCKjs6TCAGvxalj4MK/8oX4cxlAng?=
 =?us-ascii?Q?zHU3h4n1uWrlanXF6Nw4TX1AU5g3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:50.9674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 237253bd-c3dc-4f13-8432-08dce4041dd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
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

From: po-tchen <robin.chen@amd.com>

[Why]
When Source extend the vblank to reach the minimum panel
refresh rate, the vtotal length could have 1 line longer
than the maximum supported vtotal.
The reason is we optimized the vtotal/refresh-rate calculation
to get more accurate vtotal number by rounding the calculation
result. But when the target refresh rate is the minimum
refresh rate, the vtotal result could be round up and over
the maximum supported vtotal.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: po-tchen <robin.chen@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../drm/amd/display/modules/freesync/freesync.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index bbd259cea4f4..fc4268729017 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -48,6 +48,7 @@
 #define VSYNCS_BETWEEN_FLIP_THRESHOLD 2
 #define FREESYNC_CONSEC_FLIP_AFTER_VSYNC 5
 #define FREESYNC_VSYNC_TO_FLIP_DELTA_IN_US 500
+#define MICRO_HZ_TO_HZ(x) (x / 1000000)
 
 struct core_freesync {
 	struct mod_freesync public;
@@ -132,9 +133,19 @@ unsigned int mod_freesync_calc_v_total_from_refresh(
 			((unsigned int)(div64_u64((1000000000ULL * 1000000),
 					refresh_in_uhz)));
 
-	v_total = div64_u64(div64_u64(((unsigned long long)(
-			frame_duration_in_ns) * (stream->timing.pix_clk_100hz / 10)),
-			stream->timing.h_total) + 500000, 1000000);
+	if (MICRO_HZ_TO_HZ(refresh_in_uhz) <= stream->timing.min_refresh_in_uhz) {
+		/* When the target refresh rate is the minimum panel refresh rate,
+		 * round down the vtotal value to avoid stretching vblank over
+		 * panel's vtotal boundary.
+		 */
+		v_total = div64_u64(div64_u64(((unsigned long long)(
+				frame_duration_in_ns) * (stream->timing.pix_clk_100hz / 10)),
+				stream->timing.h_total), 1000000);
+	} else {
+		v_total = div64_u64(div64_u64(((unsigned long long)(
+				frame_duration_in_ns) * (stream->timing.pix_clk_100hz / 10)),
+				stream->timing.h_total) + 500000, 1000000);
+	}
 
 	/* v_total cannot be less than nominal */
 	if (v_total < stream->timing.v_total) {
-- 
2.45.2

