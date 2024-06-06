Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF40C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7998E10EAD4;
	Thu,  6 Jun 2024 21:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QkMgGUH1";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31EB10EADA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZxHgKDtVUAS5cAWEaH6ErJGyuKuvfRgZ7twwcTLWWmrm8+P7rbtHwmURkwGCARfWxQILRRGw85Wa4JfDOywt49VWduJJTUvE3CE2wbgOEW7fvKsQ6D75TPbodkyDZRhOwSOHHz8I9SbDpMGHoJhTXLDFfqhdCok/FTLB+2MzrmA4e+9njrJ04ijlx/6Fe0Sg9d0G8B3viYqpwA7A62JZrnIEgp43/HFl7HhVJq1yciqTgw/feS0MuPEJPKAZECwVQ1kN39vyCViQJ3MfQHVI7LzBgvKUFo4qttXqwfV+ZtKW8L2Du8o2r46pWmE1c/ie7QBlg9BedEubM4XA6veWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpXPlP5uxQvBmhMKKaxnlFAZ49LaKCyGJIcSzIDtAX4=;
 b=XmSuGt/xihELjLOEOp/6Qma4se7zcDJgwA4k2BDNepG5OAI1JQcl0tQ9hw+sFrBADORboTmcSxBmw8x6/hkxNZ1HCrmq8+jWimVvrElantI4NAn8eonhTwqwh0emNlyz99slnsxz4NRy4jV+UxmRSL3/RpKjaPU1qL3EaWe1AghNPmpwAbKiJkLH7HcT+M2h7vdR9JqdwLxj47vbVADOOV9rw9kp4rnqm6njjxx/6KQxfA6eHRymdBgLEgw0E29VDmxUg1h/buWQCuSBE5DySsDYd1ih9SfBzCPvrb8YH935lrTQT/jG4BlkhkQJVXL2BawYyWqyadiI0zbnSA0PYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpXPlP5uxQvBmhMKKaxnlFAZ49LaKCyGJIcSzIDtAX4=;
 b=QkMgGUH1xLUqMj9+4CmeaZRSxw+OefRbQnSMBxz5rekh1BlBuyoRgdcNxSNOzcL1GBOst8FBxFFCUxfzBYqCxUeeCxpnwmM+bxFwHhh7hknfxHWgovxnpis9131v2AwhuQ4vVZiGW1CwvQcqkRwaJCwfDbNvqcwCuM9BG5rFOHM=
Received: from MN2PR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:23a::24)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 6 Jun
 2024 21:57:17 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::6e) by MN2PR03CA0019.outlook.office365.com
 (2603:10b6:208:23a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:16 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:15 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Michael Strauss <michael.strauss@amd.com>, George Shen
 <george.shen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 18/67] drm/amd/display: Add fallback defaults for invalid
 LTTPR DPCD caps
Date: Thu, 6 Jun 2024 17:55:43 -0400
Message-ID: <20240606215632.4061204-19-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SA1PR12MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 426af236-12fb-463d-b272-08dc8673a18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DZraoOdJumFnSlfI4xsBrGlbjwKQTQ67ub40jzuxP4OU1zQ5a0fzIKBIXheE?=
 =?us-ascii?Q?JY3HrLDpQJrP5StvDqk2GNXKOTx0BwaqEFdpIeIGyDNSVvWN8k8ULqkg7tQ4?=
 =?us-ascii?Q?MuFskzm1+KsT1+kd0VFQHs8Yrpnc61DbDirQjho99sdFEXxx94YuU+wjl4WZ?=
 =?us-ascii?Q?0Sm9MQ5tuSo4RjfOMcUxau55DX1zGmfBV7pw52GRK3U7WSGsijo3of/RK5XY?=
 =?us-ascii?Q?pokVNnY82vhH5wvK3c3cuKgFMQifqmVhbdvNlurE6ZH3KDSRKUzrWDYdG8Ii?=
 =?us-ascii?Q?k/uNONPynPjXrDxVIPh2bHDnPFZEvW2qZuSjrTvtnmgu8eoaOJ3fkpSQzxzA?=
 =?us-ascii?Q?QsYYd7KBVia7/tPMysefqJpgqcKJr66b91EP5Z3ryerfeSIMolOQMyajUvzU?=
 =?us-ascii?Q?7fZfz5N44kiroYch7d5nAX7CxzMDhjrYKANFvG7rcebHsAJQ7T01cCaksNVq?=
 =?us-ascii?Q?ilZmFXd2Xf0+gnT7oh/0ksbA0lydNLigDBAazYHhAEtSSXwu8mApUwE6iyfc?=
 =?us-ascii?Q?g/51aiPe2W3TibuisveC0G371dhpLsMrNq+16flBdqdLv12yGznxCmgyRSt/?=
 =?us-ascii?Q?vBtuQVT5UmLvMAPrjCipN0rHuMrAuJC2bvFAZI22kQufxoj4ho4h91YrwFex?=
 =?us-ascii?Q?ESs9OJ5GxaftDlRCgXAc8DASE0zS6tmI99ek9+trC1aWM/vcgrgzJpEyzRKw?=
 =?us-ascii?Q?LQKMEVmeWCSMPWyxf7fOP3a0BRCTz6OFPorTUvinl8uDsCE4195JPiz7qyb8?=
 =?us-ascii?Q?giBBlUXnDEjsUk40EbVzYo1SvUb+7vUkPcI+yeT1+6p0Kwxi/bT28ceqIuI3?=
 =?us-ascii?Q?8h2qYPHCwNnRGg5ZnM61GDStwIFAJnI7zZZ4GiLvMcdWDF3IDlMPZzhwfTmX?=
 =?us-ascii?Q?7T4iqoZNQV9x2HRoZF50bHyk+UJMGVva0Pvis9zhtulPLHV9I2YkzAKOeWoz?=
 =?us-ascii?Q?L2vlDnPyxgATNpDvTzyM5fVG/zU1lES61EfuFCzVaWU87E1UEL+X35zxtZuV?=
 =?us-ascii?Q?O2qE5zCnvZ+13OcqvSXQgNkbIeRmkPsKZyJl1miqnGNbl8K5akLg41uGkvZX?=
 =?us-ascii?Q?j1eN152h/xFw36YCoW3rOFztJB1B2u09HPpDD5Np83j7iu34X6gzH+80/vn2?=
 =?us-ascii?Q?Vv++AGO9yuMAyDtaD3rvi78okiCQza0p7m05yswtSTN7nQLK3AXeIAzbQsYB?=
 =?us-ascii?Q?nRHqoCg8c9AaLSfqejrHfmWHDIRch3/4/CSBJxiwXkLDPl2WBSy6qOzXPcCm?=
 =?us-ascii?Q?VNMv7h14Q27MAHJ9aXSyec/FL7SkUqF9t1IkUisuSE2dz63DoVIdHsH8zUTn?=
 =?us-ascii?Q?AMKPCqDaiV4IWBrRsix2n3WBEJPyODrgeXN7In+sMx9J4hr9p9L7Jtc1h6j2?=
 =?us-ascii?Q?b04cPfC2ShZ33SCC4njqRzgLaKtasEwmUQYJ4Wkf6iIALnhpBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:16.8725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 426af236-12fb-463d-b272-08dc8673a18a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
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
Some sinks are observed to return invalid LTTPR revision and/or invalid
LTTPR link rate capabilities.

[HOW]
Assume any LTTPR which reports invalid max link rate supports HBR3.
Don't validate LTTPR DPCD revision in dp_is_lttpr_present check.

Reviewed-by: George Shen <george.shen@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 .../dc/link/protocols/link_dp_capability.c    | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index 964abccebdc6..1ff9876e3ca3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -363,10 +363,10 @@ bool dp_is_128b_132b_signal(struct pipe_ctx *pipe_ctx)
 
 bool dp_is_lttpr_present(struct dc_link *link)
 {
+	/* Some sink devices report invalid LTTPR revision, so don't validate against that cap */
 	return (dp_parse_lttpr_repeater_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt) != 0 &&
 			link->dpcd_caps.lttpr_caps.max_lane_count > 0 &&
-			link->dpcd_caps.lttpr_caps.max_lane_count <= 4 &&
-			link->dpcd_caps.lttpr_caps.revision.raw >= 0x14);
+			link->dpcd_caps.lttpr_caps.max_lane_count <= 4);
 }
 
 /* in DP compliance test, DPR-120 may have
@@ -399,7 +399,20 @@ static enum dc_link_rate get_link_rate_from_max_link_bw(
 
 static enum dc_link_rate get_lttpr_max_link_rate(struct dc_link *link)
 {
-	enum dc_link_rate lttpr_max_link_rate = link->dpcd_caps.lttpr_caps.max_link_rate;
+
+	enum dc_link_rate lttpr_max_link_rate = LINK_RATE_UNKNOWN;
+
+	switch (link->dpcd_caps.lttpr_caps.max_link_rate) {
+	case LINK_RATE_LOW:
+	case LINK_RATE_HIGH:
+	case LINK_RATE_HIGH2:
+	case LINK_RATE_HIGH3:
+		lttpr_max_link_rate = link->dpcd_caps.lttpr_caps.max_link_rate;
+		break;
+	default:
+		// Assume all LTTPRs support up to HBR3 to improve misbehaving sink interop
+		lttpr_max_link_rate = LINK_RATE_HIGH3;
+	}
 
 	if (link->dpcd_caps.lttpr_caps.supported_128b_132b_rates.bits.UHBR20)
 		lttpr_max_link_rate = LINK_RATE_UHBR20;
-- 
2.34.1

