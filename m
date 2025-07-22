Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FC3C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 22:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A1910E725;
	Tue, 22 Jul 2025 22:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uFWybwPU";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A3610E726
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 22:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HonPXzfW/3waR1chQHZ34AX4M78l/IjZP9oNsGz5uxEYCKtZMpOl+UhJ3xmD6dX91eNM5Wjbs4hMtim//SUMF/6IOMBpRh9YoHpvwWoiGX0OSorU/pXabua5ug1luOuQhaQ/KAW5q1xPNtc6hpvggBhJ1Bm5Y9PgWRgXBoJsMGeEiFXXGOsW30KV2wg92mGAnC85RAbsa6ywmwhGiz2foOVZZZSA97Or7f9ra0CaYRj/Fa9xPmyF5z1SPGImz4Jxz50WD8CG6+jaTv4fIxXpHxV5s8beFt06mgh7zbkeM2f4RrOvZL/u0mY33xlGO9K7l/Jd2Jnrp2TpaHb1LI2YuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQIE1d+E7qzDg+dLa//7qFjW0AsVkkwbZyC8R3Pniso=;
 b=dzjOi2hk28SoZ0IYT7YFRhxxGyEOfw2Q1wxAWxE+bQTg0oggLhPX8t8m++5MaU6rPDGQ+zAkNz3SB+q4eb5SBJl1idVRuAb5H2yTS8ju3B5QlBWpj7PdW16g2lCDHFopqcCFrMJhAfyv1I2aZIzyJ/hHB5ZGJsWYRhzQ+jm+Mfwe7xCtEtqHZ6utMgpuS5E0umhn1ePZclMbnNrdHmmq+avDwYeT/G2IKwQe41IObOKNfi8SUcFANeSb94C3LY+7BupfUSOIBtCS5wqEqzyS7zReXhKLzxc5VVUPxdVL31MMYIxsAc3mYqXJFvmApcH5oRmMtxrzQYwOynNdtkY9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQIE1d+E7qzDg+dLa//7qFjW0AsVkkwbZyC8R3Pniso=;
 b=uFWybwPUN6hnQPp+MIWZ1Muxn8QD8zmggvd9yzOPAFDAOCPuY19Noj4oNOUiR6natPCWM23PJasHYiX7szzzEA9/9dSbr8iO7rzd6ORRYLVjsB+FMOX+Sx1X7S1Pz827kgUdAveLnSk3CDymQ7ckCKUS0DtUFkKot/jQ2/k7pLs=
Received: from SJ0PR03CA0361.namprd03.prod.outlook.com (2603:10b6:a03:3a1::6)
 by IA0PPF7D094C5BF.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Tue, 22 Jul
 2025 22:45:59 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::a8) by SJ0PR03CA0361.outlook.office365.com
 (2603:10b6:a03:3a1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Tue,
 22 Jul 2025 22:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 22:45:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:45:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 17:45:58 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 17:45:57 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 19/25] drm/amd/display: Increase AUX Intra-Hop Done Max Wait
 Duration
Date: Tue, 22 Jul 2025 18:44:28 -0400
Message-ID: <20250722224514.2655899-19-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
References: <20250722224514.2655899-15-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0e0815-b514-4a26-e7ba-08ddc971871f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wvy30sEGsjjr+QfNouASHLe4WtNnkfbHR5guTS/VgQTc6c0wUIvN7rysva8i?=
 =?us-ascii?Q?hQ1WOgy+Ub/G3MxcftsAH3UlkOcnvqzlpbPaWBGuwJoXGLBoFB1gONqAkF3e?=
 =?us-ascii?Q?47Ru3+uQse9k17sFMr1at9miPf7P4ZvFJIgoIL7kZptU1K3Ht7SM3LvKgHVw?=
 =?us-ascii?Q?dEOzzMU/6rff8hnN05Qr7KVO5HN/PQTDI/+gcSnTkelK/dIqL3KMOztqlVIp?=
 =?us-ascii?Q?gbyiJzM+Qb/rtRZ39qXQWcGMG0A6G/N8rA0bUPZRQDmKZWCQt57CVbw3gKBZ?=
 =?us-ascii?Q?SnrxKziB6Y+DMns6vEGVabxJI8Wp991p2kCvCHS4XtVl1u/RIOX919wCitwg?=
 =?us-ascii?Q?crcLdF5VGvhyQNNWbf24HtkaeuNzVW77y1DAjy3ZvZyTk0P8Wxbbcv+r13AG?=
 =?us-ascii?Q?m9IFlvRDfHjxYyVXn897QuPznT2WxNjy9IzLdyBKZ6NPYtY+N3lzeLLOGyTs?=
 =?us-ascii?Q?v8dvOFPp/auIi2ilXao/tvJGBQisSsmSyR2ACvMP1XiXcK+87WxZsSLJMQfl?=
 =?us-ascii?Q?ZgEjoW8D8deAUWkXK/wZ2450s1TQQ5nwkkzTjQ4TIX/5KkUInuQvdp8O+Y5h?=
 =?us-ascii?Q?mv7zlMbwO/JiS1z5m2OjJVXMzm9F1fm5ankzVNib7ODdDKZyl3b9EQrsxI/A?=
 =?us-ascii?Q?LFSoYN9dvretH7JYMgdGQd1rhYYFeE+HPY3MXTn7ozyp9g4uZYzVzxwbsZki?=
 =?us-ascii?Q?1+HwEpgtBr6GjzAiBpq4hMKk2fyml5Wy14vQ8to6ZQGR2qgLAGKwiqbG+6Rr?=
 =?us-ascii?Q?ZBZYIlABdZ4+1wczVdHfnTbUeWWQIM4nwI885dyA3+2up8hYSh+F5bzi7+af?=
 =?us-ascii?Q?0+7LaUKt/XYq8pALByovxXepUh70ClIRwVAUWhfEKk8AVIinGtVAyWijDS9T?=
 =?us-ascii?Q?iGf9DHPOlHdfGVxcLWMFxLC3aVNhnBvd5j4+Pr4ZwAMnkHB8+e0OQhMCQ6SL?=
 =?us-ascii?Q?9sYVAVwDQnoGWmHyz50uh2s7PkGhvVeHNBBHh26kqR3HgGhd0UzV9JXv6/0K?=
 =?us-ascii?Q?LflvAMYbCLcO2EzgO4ZDTUkERx91tol8/pAJEkSu4BEwXAr8XACGxFm7DXR+?=
 =?us-ascii?Q?6nmIGitV1cQf07DZhbKqOGIkJn+RTRGflORp51YJJdddXFp5yGVHkr0shJXf?=
 =?us-ascii?Q?ZPuCEz0dqH6dg1Jflcu2bLbo7/5BeD8f86/7x/Sgp0CuxdVM8e+tb6Az4qVY?=
 =?us-ascii?Q?S4DCQ31UJdmJQareZCDAzMS0cf7WpyM/Vy7jspW+oro26dAIcfBxET50uIJa?=
 =?us-ascii?Q?8TaPh7u4/ChaLa1IFIVr29kskIdeSJyTO2MOIMhkP1nG9EaHOOZAYKNi7rzu?=
 =?us-ascii?Q?wUjd6CZVLdgpckxvopzddiWT/tS7o/M0RHdqofirzPuIcfdgFe49IaPzWhDK?=
 =?us-ascii?Q?H2Abk3EpvjlX0yVArTZ8/czBS69Fv88Ylcp7lf5ol8YO7z4YB9cLY+A/+q1J?=
 =?us-ascii?Q?o3XVAaMCEUZcKBVUt+D6f8S209RfLofEomTYoeCMczTQ21IhuNk/+xg6yWvR?=
 =?us-ascii?Q?sdxn5FdbIsQ08me0YLIRga/6dHXZVp8IKnAb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:45:59.0632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0e0815-b514-4a26-e7ba-08ddc971871f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
In the worst case, AUX intra-hop done can take hundreds of milliseconds as
each retimer in a link might have to wait a full AUX_RD_INTERVAL to send
LT abort downstream.

[HOW]
Wait 300ms for each retimer in a link to allow time to propagate a LT abort
without infinitely waiting on intra-hop done.
For no-retimer case, keep the max duration at 10ms.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_training.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 2dc1a660e504..134093ce5a8e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1018,7 +1018,12 @@ static enum link_training_result dpcd_exit_training_mode(struct dc_link *link, e
 {
 	enum dc_status status;
 	uint8_t sink_status = 0;
-	uint8_t i;
+	uint32_t i;
+	uint8_t lttpr_count = dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
+	uint32_t intra_hop_disable_time_ms = (lttpr_count > 0 ? lttpr_count * 300 : 10);
+
+	// Each hop could theoretically take over 256ms (max 128b/132b AUX RD INTERVAL)
+	// To be safe, allow 300ms per LTTPR and 10ms for no LTTPR case
 
 	/* clear training pattern set */
 	status = dpcd_set_training_pattern(link, DP_TRAINING_PATTERN_VIDEOIDLE);
@@ -1028,7 +1033,7 @@ static enum link_training_result dpcd_exit_training_mode(struct dc_link *link, e
 
 	if (encoding == DP_128b_132b_ENCODING) {
 		/* poll for intra-hop disable */
-		for (i = 0; i < 10; i++) {
+		for (i = 0; i < intra_hop_disable_time_ms; i++) {
 			if ((core_link_read_dpcd(link, DP_SINK_STATUS, &sink_status, 1) == DC_OK) &&
 					(sink_status & DP_INTRA_HOP_AUX_REPLY_INDICATION) == 0)
 				break;
-- 
2.43.0

