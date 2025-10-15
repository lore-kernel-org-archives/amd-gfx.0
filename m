Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EDCCCD192
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FA7810E6D8;
	Wed, 15 Oct 2025 02:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ji7lljMH";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2CE910E6D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPGo14e6bTl+Ut7NWVgLUYzET7qfrVK/f9KrVsN2PGQG6sVPnXE8UefVv2M8lTgz6lRj5BMFUzMGR5WbjMYmZzCtjSC+kYfRrYm9NgisGh3wMTWMl4Y0hkfHRopK0qi5jsmjG2T/qW5uC+2a0oTd2IKTCB5A2odCiNtEUzvlg5d8UpYiR+QF1j+/yHiP89PvohFKj2kyCUv2ujm11s/bS4kC1zHZ5iXW2jGAV25hv3TZCX0hONBqqixveAK+h+YdJyhSED5r1hpAWvKnN4YSvTjE9SsNXnEo/thZuYaGnq9xx203DYfv7sJ4qoyvfUICozUU7IfLcj9ZMUKGAM7JbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DFT25qvy6Bl0p7pnv7+p/6gZqNQNjXbCu5SFx33CxQ=;
 b=chTTkUNiea+G2Wp3g236qhWSFMm8jlZljvueDBrV2BNPhMDYi30WIhL4tRx9tOPbtkMR9ZhYGE5AHVkaWg6MdyGeCUu7vbIlm86Mm2ubC2wjQ75Zp99x1tLxR+8a8/KCnYPPOrLucjF61Q5+xWCSH996I2dGfaLBL7YIwk9VuVuWEInhAbIkBMqN83k0mFGML+e9tiwwzPMq2pwrmsBPEvsh3AJLKegGqXubfwNRlsMwvNl9OudmVRs0AzUsdIWn3qYvqTbk3OhhvC8WxvxenQQOS/Hb/q8YT1D7CpoRFGncFC9SHg/GfuUK0sRoCkaESfeWcracy329N0qta8Lu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DFT25qvy6Bl0p7pnv7+p/6gZqNQNjXbCu5SFx33CxQ=;
 b=Ji7lljMHlUBept9IAuA+OPipRMHfKdrAxdJoMLTRnxuHH0GCYT6jNlQT2A21N+wiaJp0CQcqyvPOCl1X48wdxDQXH172SGMQDk6wbjaVdqm3zcx4uLXT6n/axBBEqFQRB0jPHsrcK0g1ZkAJChQw/cIXtbAXnWLZ4BSkLNZcrUY=
Received: from BYAPR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:e0::24)
 by DS5PPF922753E5F.namprd12.prod.outlook.com (2603:10b6:f:fc00::65a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 02:58:52 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:e0:cafe::af) by BYAPR05CA0083.outlook.office365.com
 (2603:10b6:a03:e0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 02:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:58:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 19:58:45 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 19:58:45 -0700
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 19:58:42 -0700
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Meenakshikumar Somasundaram
 <meenakshikumar.somasundaram@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 2/8] drm/amd/display: Check disable_fec flag before enabling
 fec.
Date: Wed, 15 Oct 2025 10:57:03 +0800
Message-ID: <20251015025816.1542507-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
References: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DS5PPF922753E5F:EE_
X-MS-Office365-Filtering-Correlation-Id: be9ad5a3-affe-4793-a31f-08de0b96c580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K/oOuKQeNEtNpn3fwCQAtAJoylCCTczlEodEFTvDn26lFAppoFW018bvfhdO?=
 =?us-ascii?Q?XvDs0R6W7AztHYCxE4MeOFgOieuMTLjYP+ZQeAcOFhmg15stHSon5Y5Ny9m1?=
 =?us-ascii?Q?eUPADVmpeOUsYHrnxUX2OkEPG/SLAayaaOvyZrJYXzpD0E1hMXpeST0aWk61?=
 =?us-ascii?Q?mLyHCkSxccmOCf35KsHGLOb7IP9CafV7Q/n3khYyQamkmL55QFqe7cpVgCnY?=
 =?us-ascii?Q?P89YAJoFPtM9xtZ+ry3mtQpCjdNAV3WPBLG9SW9zsRDZ35XxfSI2jmQwOtNb?=
 =?us-ascii?Q?ELgwNj5lL+T96YDGl1qVyq4Wlb2yiuzEFNl2xf0r35epyFcHgkQ/9eUwnhIF?=
 =?us-ascii?Q?SbPF+N5wVe0Do1HFEA94JNehWXFkKV7CbHwl91OP2Qkt2SD3EZf82lPnmr2u?=
 =?us-ascii?Q?LYT9gWUkyDSUFkPE0ZbmaOUsdCCEFg+Zkq5HyOnLWXGsEBroAamhBL+dK1zq?=
 =?us-ascii?Q?3A0ahGWIiYcHqJOguDMbGA2OZuR09ej0dNS+GUMPVI/n9BoGGg2GTW2dxYsh?=
 =?us-ascii?Q?GXowtqplUhx464JeAVKfoNxfTWbCI7ydHy2fsDi53xUt7lkJ8nYHxzGnXVla?=
 =?us-ascii?Q?l/o8KNTXKnBe6c6wDMrS4RFKkWP1aDlr3EEl4Kwwf0y1q/ZZ4zIp2+26uXKh?=
 =?us-ascii?Q?tWjJxdOxP7ZuV3zDQzXa4yVu18eUus+zfnxjI8CUJjuye3vu4URpZSPEU4bE?=
 =?us-ascii?Q?YsburgVxtL0EBuYAqBUYeegDeChGREfzg5rpYgFjgeMLCCDChFuiR9qlkf2C?=
 =?us-ascii?Q?utwTNdK2uZwcY4jpzgv1AnaafTfO+JXqyKTF+gc54PVFDAegRu5HyZvIhftN?=
 =?us-ascii?Q?KrBNCnihi4KvAdRJQ+++2T/UzzPUo6IXrlch+hDJC/5TvX82VbnwCfIfZvy8?=
 =?us-ascii?Q?Ina/ypfH1BqLChkN/GRM2JV7UsANqU1s5D5c/I+Raq5ZHK/9nbwqfulce1gZ?=
 =?us-ascii?Q?1HI/r/1FVozl3hbPttk872hQrVSSE42jr5pVOkBx8TZZUoCthDcq4yVHQep3?=
 =?us-ascii?Q?jwAAjGoEyLHfF7GSHgi1tTMxfwWL98cdCULMGQZZh39mgLlSKa9gU0FVemix?=
 =?us-ascii?Q?v10IxTxm++oMmDsadIM1t9Z1yjXEl3+ahj00FvzlgUHngyd+vowNIZGsKgfc?=
 =?us-ascii?Q?NbYxUokLSGVZYPk1zc+hfPhStxpn6CnWJoiacijDPnrKrpEyCQ9doBHzXiTB?=
 =?us-ascii?Q?xbFVJrYVKjW9fc9EEQr4q75xymz45JiUL3PdkxCSgMKv5gaWm+u6ciMbehlF?=
 =?us-ascii?Q?x21Qsf5GSlnX3H11/wLxT+XBKawbKNYilK90FcGDos9ActRdHJXGV36YoVVi?=
 =?us-ascii?Q?MBgfpU5om38kykFL4xX8AQ0SCZOqkOugbkyFrypDf8YuY0yqoPhc2/6Ca1a3?=
 =?us-ascii?Q?jkewUFIe2hSqZ+Crdgh2F2cc43qP9gXyx70WLdgH5QBQWFiCrMIYByrYzxNJ?=
 =?us-ascii?Q?UD8ZfPxmjRSfX8wGK9et03H4RPrAA0h1YOYWWSMeml5HQ7oAS0OWU3TAdeXj?=
 =?us-ascii?Q?/G1TkVJKcZ//W9iAbBxtTwcHSUHs1eXamulsAhixS6RRflmohITeBKwe/nfK?=
 =?us-ascii?Q?ySW9hG0wJCCKxmKkcuU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:58:51.8364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be9ad5a3-affe-4793-a31f-08de0b96c580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF922753E5F
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
dc debug option disable_fec was not working.

[How]
Check dc debug option disable_fec flag before
enabling fec in dp_should_enable_fec().

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index c33a8c17c38a..701afd2d4ab1 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -357,7 +357,9 @@ bool dp_should_enable_fec(const struct dc_link *link)
 {
 	bool force_disable = false;
 
-	if (link->fec_state == dc_link_fec_enabled)
+	if (link->dc->debug.disable_fec)
+		force_disable = true;
+	else if (link->fec_state == dc_link_fec_enabled)
 		force_disable = false;
 	else if (link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT_MST &&
 			link->local_sink &&
-- 
2.43.0

