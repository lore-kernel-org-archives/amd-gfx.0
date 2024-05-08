Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667AFC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 136CC10F640;
	Wed,  8 May 2024 17:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T6aGIf0J";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A13410F640
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdLW6DnC9MMXgq4Va1mILPEo2GwDDVKSJQuyqVEKpdcSi261DEOt8SlNMNmNZK2+w49kBGG7qAJJJHeT9TnttwyhC6lQPxw3Wd1npK3AT1B8z4vn3XL6CWd+kp1cXK2U9Uc8vMzaxZfD8e20ytM1OlrVZjJje3laN5MOLuUGoIv3wtjxo5ZNesi86P+cd97hVs8G3+/c+3vLdJrJELexeE1evbsL6wIghZ8pLXWTtywAnQLIkcNh5jQkMsrDu72PgGeN6h15ECm7DALTluS3atuMBrpqsTwZtl4M9L75nWRlZjFNRJjz5ksLD7XMzQ9gMHV9K/f0c+aZJl5a4dWJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSWlu+oU1x8izn9R1XXZVgKB4HYeRzqCNVid1lj+Ig8=;
 b=NHYnzmTy/tk5YBH00FY2mEtdjWX/fTE7nBrHbeBH8y+QlQfKUYV5TDOKoMpfDiMzAwmwsCI8CNMRBfzgTRy3tCy7J7aJHdB15NL1wXhf/ggL6I5WK3GE9jZpIW+PitoMdsj2P7Pc2sNivsdRi+oCDx75dbmBQAvDAo1cH0JqQVDSEuBegpYvBZj2+OCTYb+Yzn4W+QMQJYJG3nZP3CVhhGOC+ydm9cWVLRSaKr6b2e6DP/rPO2/kucCRP0pQGW+EtJvcS+PBv2+2/3sCIT74dcVFPm5BpSXxFGbebebEmSPKLzLmLzi6YK+TyPXEN7YUKYbpTKzdZDRdwJ0kW1stLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSWlu+oU1x8izn9R1XXZVgKB4HYeRzqCNVid1lj+Ig8=;
 b=T6aGIf0JbIwgF1QTAR1qNbMptPVYmFedu4w600pwrRqq6Q4YSL4/od13hPNmRC8sI7NfA2zQfOEc0pPJNTXrrUuD6UJORxlXVZMK4SVAsnXw1/q2Vywz7xHN+M4NGBcgEEddJ8hCJmkEwsrQvrY3FFi3+sbgdAzrUT0RnxtxWDg=
Received: from BLAPR03CA0109.namprd03.prod.outlook.com (2603:10b6:208:32a::24)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 17:17:58 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::d) by BLAPR03CA0109.outlook.office365.com
 (2603:10b6:208:32a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Wed, 8 May 2024 17:17:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Wed, 8 May 2024 17:17:57 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:17:54 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 13/20] drm/amd/display: Check UHBR13.5 cap when determining
 max link cap
Date: Wed, 8 May 2024 11:13:13 -0600
Message-ID: <20240508171320.3292065-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 3032937e-5371-4208-fc73-08dc6f82ce5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AXtmnAfQKIgb8kMnUQ04mAqcI9W+6/t2C1lNIwtVLTg9HMUdcbbgTBXRiFh/?=
 =?us-ascii?Q?y3N1rK4SUKo38vvh3RLqEigOoV/3cKubJAnPii9RVwLXrm+WUR89xEMIXWgS?=
 =?us-ascii?Q?U9H/xADiFL850qWUPPZZXSfJS3AfSzx07NON2tY8y5BUL2+HGfGLpR23ufmV?=
 =?us-ascii?Q?KZAHRBAHuqi856PSYqbsK4/Hq9VOxLuvyw4lGvviKVehzwh7bd8BL/QzHOI3?=
 =?us-ascii?Q?FFJZTLbsqqfRka/xSPj97hoOR7oGhHoiXCGwwRBgz2ocJQ0818PKVgT4W+aM?=
 =?us-ascii?Q?VO1faDMGcwVod6IBk7pDWlyCYODIiFdKry8m5T1Y5bEguCVJ/UoCHywlOqWf?=
 =?us-ascii?Q?VQ0olOQ8UAA+SSyok3yMSej8AhTkCvdesyzk9KDCg+Z8c2xiBesn4YZ6RmYa?=
 =?us-ascii?Q?6RG/jAldGcXtOA2pqaMfyJFZLK/h1ADOmxGQ5qynGH85HJSP7AW8iNrJl6K5?=
 =?us-ascii?Q?xtM15WMWzciO25XorvjLN7yDgw6T+vlx91kJWWBilpkeU+WTicm1DXGbqQiX?=
 =?us-ascii?Q?KpnRiZw3CNiQWIBQvBhhWbzAnM0GWsB9qdct6koeLyLZD2ic1/YgGzNmIo7e?=
 =?us-ascii?Q?PkhDBDi0n4XXx4mrc8ziJsp2SVHEkUKI2rSl2368XEcaje0lZ0x8WmCpxu7B?=
 =?us-ascii?Q?7yytCNzd5fah+uF+iXFImWj/FiXc0IaAV5quwuCI6q3b0CU/IBsR9w+okEJt?=
 =?us-ascii?Q?j87lG6wGIW8HFNB5lpvpKMaCnNZvNDp04pPIBG4z2w2XFlbcDRmHUvDY2S4f?=
 =?us-ascii?Q?5ciR9XiK1Qbrfd/XtflpfpIqecyNuIKQqWip/6HJPir7X7BqO2BB3+43BzQz?=
 =?us-ascii?Q?mF8tDK4T9tx/eVF2iTOm/Qi99OVIo/pkjC3o579twvFZ09NF9gHjafASuTCh?=
 =?us-ascii?Q?X6ETAWzPms7vrKDwYSAUovzTEGp7HqgWzaGTMnl2jDTv6iGJQH4KdXbRHuVl?=
 =?us-ascii?Q?qi3pjcf6vpXyEZVRhyWN7hqOHy1QLvO/rbjn0pdG+2lZdVQbLnEIELvzgCLN?=
 =?us-ascii?Q?HNdIBDJ4phFQOw1eB4bV7ooynJnGlF274IAk9nk2Ibu4mkC7rOPioqurihfP?=
 =?us-ascii?Q?S0mccZySizLrqSRp9eSR2QXlX3fyBMwFCU8a6YpyvMoiE0zkAENNXJKsDOP6?=
 =?us-ascii?Q?vVAhxR14f8jUWXoXjUeobKnc2kAwCbHlNKBpq5ajrr8JMikKzvesTsCqjU42?=
 =?us-ascii?Q?LYb/ENR3FXePHX31JV4qRzgCx8o8EVCucabBgUX+1/naZIU416PobkP1OsO6?=
 =?us-ascii?Q?hTUuEnUKvGybh58TNv5UeeHbA27a7GYpX4VK1bIqT9dDYDWB5xW11PvdOWJy?=
 =?us-ascii?Q?8YtPajbvzvXAVZo4P3tXeijHhVSa2WMufVY8VNx2RSukMHpOVXknxhJI2yZ6?=
 =?us-ascii?Q?37C7uHpXBk6nH6nP01Covp20cm4W?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:17:57.8087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3032937e-5371-4208-fc73-08dc6f82ce5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
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

From: George Shen <george.shen@amd.com>

[WHY]
UHBR13.5 support is optional, even if UHBR20 is supported by the device.
If source supports max UHBR13.5 while sink, cable and LTTPR support
UHBR20 but not UHBR13.5, UHBR10 should be used as the max link cap.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c    | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 8f57b344f09e..766116ec627d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2062,7 +2062,7 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	enum dc_link_rate lttpr_max_link_rate;
 	enum dc_link_rate cable_max_link_rate;
 	struct link_encoder *link_enc = NULL;
-
+	bool is_uhbr13_5_supported = true;
 
 	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
@@ -2083,6 +2083,9 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 		max_link_cap.link_spread =
 				link->reported_link_cap.link_spread;
 
+	if (!link->dpcd_caps.dp_128b_132b_supported_link_rates.bits.UHBR13_5)
+		is_uhbr13_5_supported = false;
+
 	/* Lower link settings based on cable attributes
 	 * Cable ID is a DP2 feature to identify max certified link rate that
 	 * a cable can carry. The cable identification method requires both
@@ -2101,9 +2104,13 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 	cable_max_link_rate = get_cable_max_link_rate(link);
 
 	if (!link->dc->debug.ignore_cable_id &&
-			cable_max_link_rate != LINK_RATE_UNKNOWN &&
-			cable_max_link_rate < max_link_cap.link_rate)
-		max_link_cap.link_rate = cable_max_link_rate;
+			cable_max_link_rate != LINK_RATE_UNKNOWN) {
+		if (cable_max_link_rate < max_link_cap.link_rate)
+			max_link_cap.link_rate = cable_max_link_rate;
+
+		if (!link->dpcd_caps.cable_id.bits.UHBR13_5_CAPABILITY)
+			is_uhbr13_5_supported = false;
+	}
 
 	/* account for lttpr repeaters cap
 	 * notes: repeaters do not snoop in the DPRX Capabilities addresses (3.6.3).
@@ -2116,12 +2123,19 @@ struct dc_link_settings dp_get_max_link_cap(struct dc_link *link)
 		if (lttpr_max_link_rate < max_link_cap.link_rate)
 			max_link_cap.link_rate = lttpr_max_link_rate;
 
+		if (!link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR13_5)
+			is_uhbr13_5_supported = false;
+
 		DC_LOG_HW_LINK_TRAINING("%s\n Training with LTTPR,  max_lane count %d max_link rate %d \n",
 						__func__,
 						max_link_cap.lane_count,
 						max_link_cap.link_rate);
 	}
 
+	if (max_link_cap.link_rate == LINK_RATE_UHBR13_5 &&
+			!is_uhbr13_5_supported)
+		max_link_cap.link_rate = LINK_RATE_UHBR10;
+
 	if (link_dp_get_encoding_format(&max_link_cap) == DP_128b_132b_ENCODING &&
 			link->dc->debug.disable_uhbr)
 		max_link_cap.link_rate = LINK_RATE_HIGH3;
-- 
2.34.1

