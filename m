Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3345FC021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCC1110E55C;
	Tue, 25 Feb 2025 06:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Misg3KHa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E9B610E55C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEP9ov4+fRQT+6s0Y+I9cHmsiNbo7MuaRGD1794ARCYyX2JsF1UNsAoUGwiRtVH1fnjG33tURo7mj53BL9OiPYTBgLZM7nOu0+bQr7A1xbG5hSfFBrI1qVRnY1BkfsNiX1lXzJuYbCCAbotZKxLkmAOyHaxRcs37tXX0xraVkPKq0c2gG/Nq/Gk79Zr0m8oDdabt25C6l29NTKB+r+m/JMbALgkrw2GpkttnMPyBgaweS6XbbflqzOd+aw6gDHtslqGmQzddsKkl15wy8BvZbQ892JkOdc3CLiV7dTwz42hi7y6eJjTO2VVxFABNf0oYP3L0ADBs6BQpMdH8122AZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQADL0oI8FKnmoW0ppnX4Zqpmhg6qJ+Br1lQmRCgEYY=;
 b=R7sznFez9G0yiXlRKE9+V7D4M85N+vZQbsnS5cHIiIX8JKR46F3F5Lr/YDN/DL8TQrsOQNnJf4paJdn+aBe1zAsuBSs1A8CigUgr/DzT9dAVtmNoM3l0T+Ux9ZhO/HN5bFjvw2e+1PJA1CDffrGr7I69EX4G6wVfxRfgtFC/S+KDxYM36B2SrBCWAUzvXnVc4ywiQMgEJ+gB1qTSjiz8yjTWQRoh8bsB5aSVpMwC2kUhaRO9MVaEKjOD+TZ49HbYDPWasGGdWhK8ZoOWnZZ05Wf4nGn7Ut4gEV5rUH0mOJMSyp28FLGMFFQ4gF/mcVHYiPRes23Z+O6JIepeCxPv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQADL0oI8FKnmoW0ppnX4Zqpmhg6qJ+Br1lQmRCgEYY=;
 b=Misg3KHa9gif4G/JRRK2m/apOnLh6MLJuKerHXXI7RjshvrP4gEzcbfMHM0WfuQ6LwzduRJ4XSh6f+v4GYLZtSIwjgNt2SEqkNthELV/1Cm8FKUzLsBqjrubLY4eEEKzRufYNCAvp33eMzctCAeYt0rQulOdwI8bKrtzI/1lgNc=
Received: from BN9PR03CA0562.namprd03.prod.outlook.com (2603:10b6:408:138::27)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 06:37:16 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::13) by BN9PR03CA0562.outlook.office365.com
 (2603:10b6:408:138::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 06:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:37:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:37:15 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:37:11 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 09/27] drm/amd/display: Revert "Increase halt timeout for
 DMCUB to 1s"
Date: Tue, 25 Feb 2025 14:35:52 +0800
Message-ID: <20250225063610.631461-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3c2da7-dc0b-4c91-b3d4-08dd5566d875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XEtqi69ddUrVMXvFui0NSOb078jnevrzg2h67/0Sf5xYw+JCIXXz/LXSUf3o?=
 =?us-ascii?Q?WIzaI4cCbznduOjQ7ahXgLrQ4tMIm4opZThhGSvhSLo/DRjirUcYZCUZKj/P?=
 =?us-ascii?Q?DynxEGx0gxiluc2Bteaefbke5Xer73E5CYICtJp22Xlv1igX+ilp0VabY9Hx?=
 =?us-ascii?Q?dYGy6c52h7joGWwSdU00YLYJclMsRtqrL5JqDjnMImle8HzZDRjn2iuqTr6N?=
 =?us-ascii?Q?X7pR9JO2JSIc99rDajRphuPLvAhvlCpwa5I0llZTitVY0Xzq6pSCyxxPGEq9?=
 =?us-ascii?Q?AElX8fgYI1l1NhmlQ160ox6sE073af+BmhRmRtoz/v5nbrT+hkFi+ihMm1/R?=
 =?us-ascii?Q?OJSRb5FLPSnE79itYY0NEiH4t9KZwnp7WvIgEBnSe1hVGP3becTwPyCIcgen?=
 =?us-ascii?Q?01nKJVkoC3YiVE8/0RZbh5zNhSJ8cWDJ4b0B7aTmzjA6Wubs+Dq2Kou6ad4t?=
 =?us-ascii?Q?IMsUXKXkMPcbip2gCnKu2OFMhFO5Bbj5mnCt71kRuEkOdjMEp7a0o9uRWPUO?=
 =?us-ascii?Q?g1F8+Oz10Dufof52i1jaF803yhXgSlDasGmmtRcCpa58+5BqdOc4+wLhU/si?=
 =?us-ascii?Q?5MI6ukQ3AuR5CLh1NwfeCkjYPkbfH+G+ZOCRW3isb0waabp5QGBg40YGXSNX?=
 =?us-ascii?Q?urfVthCQUf/TgpCk1wrJ42sirh77sWLh0/2zcBPanugflqCjB8a3OZaML4wU?=
 =?us-ascii?Q?QB8LmMoD9e0eW8ngrez/vz7Pzy73po+g7Cv0kk3ngtcCWf4am/FZRl8wujvg?=
 =?us-ascii?Q?45F1Vkge8Ha+9ihESzdbpLDcKX99HmxToHCA5HU4E5i3GS0q1utQJ8nTqDk3?=
 =?us-ascii?Q?fw3S1TjG6F1NtzxsJBf5xBrLqPfPbr6n9joBD5lr0vaxRpFEFzYlp92+okvG?=
 =?us-ascii?Q?lM0NlVt6h2R1cKQj9o9iwNsXAaBZxQ8if0W09fcLR3plgFuRXrlcLhoMO3y4?=
 =?us-ascii?Q?ftCoD7x3VHJ7xMEGcqZVhMKRwFpCUm6FkqvoDRybzjFtBIw+PjnGSUPlEwfF?=
 =?us-ascii?Q?oqZw5jYDhKisRy1opt5kSuhvewnWNoDHgonVlQJ4eoBGUMP5pOprFXfj20OG?=
 =?us-ascii?Q?CVGbYmI/3/5esnjG92hh7dguLOnGXFMsxMBsLTG0TIT2tYm8p0AhV3RuXpj4?=
 =?us-ascii?Q?B5r/V+SSTlnSekrhkVUvbqgUHIUXhuo9/LUHGS9ZDMux7BP5r8olrhY2ZAGW?=
 =?us-ascii?Q?PndcVAu9gW/TmTBr3ADH/Bf/x3rf/G3TP/6RIb4bSychhV0eOAiRt3X2jtgC?=
 =?us-ascii?Q?MTzfaY0qTIGX4b4ArDp579Y/l1avVqtdkY+Xpl8YAyYywp388xZsuwNWll1Z?=
 =?us-ascii?Q?v2ZakSaUa4ziaeEqmF6yZwQB+sUAzeFvuvicb3PGsPQb0ICeumfhqLHzfPx2?=
 =?us-ascii?Q?2UTBZbGcaz8W1ggwUqYLoz5bFZeNzlnu3E1Ngnxy5mNksdPW+lyHD54l3orK?=
 =?us-ascii?Q?uFPS67HzWInW7MujH0VUl7NCALW20Vu/4Z/b8Irx3KenvsGJzFLxAbIs/qGg?=
 =?us-ascii?Q?jptLpb79R5Hw0Fc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:37:16.2588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3c2da7-dc0b-4c91-b3d4-08dd5566d875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

This reverts commit 7f4d49ac3944 ("drm/amd/display: Increase halt
timeout for DMCUB to 1s")

There's two issues here:
1. Each poll is closer to 10us than 1us so it stalls for 15s on PNP.
2. We're reading the wrong scratch register to check for the HALT code.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c | 15 +++++----------
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 1fac75dfc650..3d0bba602b53 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -83,8 +83,8 @@ static inline void dmub_dcn31_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn31_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 1000000;
-	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
+	const uint32_t timeout = 100;
+	uint32_t in_reset, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
 
@@ -125,14 +125,9 @@ void dmub_dcn31_reset(struct dmub_srv *dmub)
 		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
-	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enabled);
-
-	if (is_enabled) {
-		REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
-		REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
-		REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
-	}
-
+	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
+	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
+	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
 	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 652173b10401..e5e77bd3c31e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -88,7 +88,7 @@ static inline void dmub_dcn35_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn35_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 1000000;
+	const uint32_t timeout = 100;
 	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
-- 
2.37.3

