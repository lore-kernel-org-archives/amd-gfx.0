Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2554C07C79
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC40112BFC;
	Mon, 22 Apr 2024 15:30:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lwNkWyko";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D319112BFC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScMcA0oi4/DH5z/2XdvpiBMXiWy70bWa2QzLXGC6r7E/mJTK8byWx6C6EnZi5+lzrQGecgtLyyODgM97jYDCbQhCMEBFsTg5jLKhqaWYbLCvsWYJIpWPzYRU+DigtLKHldEK6V8y343tNyCFGifMZYi5CyoEnOFuBqc69S05aR34o4irlA9XQ6iZ+6rsVJIQD+DfdrLjVJ7dJ1wjqbdK71rfTLTglb70/xXKrKwA2yNBM1eMt6+x3dH6GPRK8vaKMvMFPXwSr6UN5Uil44cR/uMlDjuuf6QgieFm8ai7V+/cbvf+bK+8YSD5mYHdR+0y3+bZd+cGdRWzcIynlpFkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfJYz9tmLKB6q12f40qReOiNIR6GaQ8quSCpPNYG8Qg=;
 b=BThibSV38bxh+/bhj5mhkkVsggwbnwhCP6Tj2hAeorYTewS0a0qzNGvfpt5PKic4L7F33f3HaFtj1oLZ3kZFDKc7aSla7r+s72TPzg4kLm5V67F3UET3O/iOv/Nh3mdmfkvf78kKUDBrWAq701Vxxsx7RD8GBQMGBNWhEeWwh7LtX3rhLXJIXsCqL0QGsxHpQzXnDOUXuyJiSNuzF9v43X1sveCzkVMkelxAh7zauUB+VyheY7B2JC8A9OX6ACzQB8Q7W8lNgBzaEe13L645uN7GHlxFK9ocVr+kYLhCiWqO/eW+YEqHN/tQas2m9OJK4paCVA9IjRDhxzEZQ0Qa5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfJYz9tmLKB6q12f40qReOiNIR6GaQ8quSCpPNYG8Qg=;
 b=lwNkWykoKwP/WVJrJHpgg/2svy0b4ZSdiK3qaSSjv0uQuv9nspqRzYcrFzwPgUa4PoX1zFTd9BX3HWd1P9gRl/MHdbw3sSvVtkC0Wgl3ggfGP+C9YFGAidKqfIdY31fGz4HvohwGq/YuSJTwCu+7q+iPbodt9qCtZUtPvsdkW2c=
Received: from CH0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:610:cc::11)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:30:36 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::29) by CH0PR03CA0066.outlook.office365.com
 (2603:10b6:610:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Mon, 22 Apr 2024 15:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:30:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:35 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:30:29 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Charlene Liu <charlene.liu@amd.com>, Aurabindo
 Pillai <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 24/37] drm/amd/display: Force flush after write to IPS driver
 signals
Date: Mon, 22 Apr 2024 11:27:33 -0400
Message-ID: <20240422152817.2765349-25-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 712200cf-09af-4f9c-c15e-08dc62e12834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WLqHxUu57mNLnPiNhVA0ogwN3biDptXbQOIeHP4NXkp0D/Yvnq12kAEzW/Z2?=
 =?us-ascii?Q?OH0dEqbUgkgJd4nW3I+f70Mi/631PyufzXK6IzEc/7TmCdqRe+CEFmKokz9+?=
 =?us-ascii?Q?n2z+gaWyey41yGY8B70fvTqZd8H9AZkHJzqvJybgkga79zOJp7dzk8SYWNy3?=
 =?us-ascii?Q?6BWpwEOMSUO+CL1XGpdQlovL2jtA+JkGB4CSxeRcQBWLsmyoCehpPGKv6Dlx?=
 =?us-ascii?Q?oB8sW3aO7Zh9EJqcTNR4li6ATOu1efSbkgFqepiGujgrnaVtMxYDC99kya9z?=
 =?us-ascii?Q?b9C1pVUd9NFHZP2zzEP/DKyCMkvW8FUIdGXuILnQFGxmjImFW0RywxXEjcVN?=
 =?us-ascii?Q?rib3FgpjKEl3kOjfvs5U5O7KBzEH8rPmAa8FltRnrgjRkO7CDiSvhdR3YNN7?=
 =?us-ascii?Q?kin4/W373mGrOXnkukj8gsoL24YZxKnjl8/wzPo0JepkQwa9PeBxHzHcQR1+?=
 =?us-ascii?Q?VS7KHnPE0+DQt+SCi9ZfNgEpLofzK2svvr4Uhd7XLdAMalaWO5NlGC1Ht6qZ?=
 =?us-ascii?Q?IETpy+94HUXONfA6ZsjddxhpTYvDFTr0F9yFhrELaWP6S3xCad+GLayNw+MH?=
 =?us-ascii?Q?TskCdKYKC7p6NZtxVUrl2d3aojuMnXpb+xB7pn2wW7A1MunR4D9dQYGB9z1h?=
 =?us-ascii?Q?/1loUROa6N9GcaxEcz5CkaJF2s2WoyVo9RBky+uDioVunpbpureJ9YkVjjiO?=
 =?us-ascii?Q?itC7WdSxPQjbJuEDGtd2Lyp/sYxxUy0u5ZeCsQTdClEEMZkdT/j7xJu9J3lK?=
 =?us-ascii?Q?Z1aC5YlBlGOkHonSJG0dHGLg1zvGYbs66uwoRZjYDx/7roftJAHSN8CKGWRe?=
 =?us-ascii?Q?MjqoMDBsw5eGEjFIMakxXBTwMHMWEOuqKYKnvAMvYkFmVX8PeSCYRQdR/bRr?=
 =?us-ascii?Q?gz985zFddAXNqc3v8zltwm9F1HFt1uEuWAhUNMA6FLU8XctkeaK/2G/W5Ymm?=
 =?us-ascii?Q?xGu85jFhinyy7Gv61p9VUpbEDgsX1T2Za0IcEfOm/L4TTD4gG7UhV72TrpMv?=
 =?us-ascii?Q?XO3+JJ4/7eM2qxApqguyJ9AmTH5+AVnpUGxo3WXwah2dcOcKt/1Nq5QJ5NT4?=
 =?us-ascii?Q?0QXzC6T6Jjr8x7uxzPt1OrfaHXVGyny3iGvRbXwZNTZXY5m083H/iRBXQjXv?=
 =?us-ascii?Q?3CwbTwNoCigUpJeORSpxes1XQevhgpQTX6i5Rc3ui4KQ7c10ATiR9BGi7THE?=
 =?us-ascii?Q?BOcwlre4IdYyxKHA44FOJC0GudrFlXUPSzth1HjadpC4LPG+60uuc9HL9u2F?=
 =?us-ascii?Q?0kLIYzoV5KwTsLkwbvcF/WBhEDKhDyGxA4p8qn9TgfA9gzib9xlO67Z0SyQK?=
 =?us-ascii?Q?n48tF4y5RNR1o7WB4Q5jTsWl9/b5oOi0i9rVSy6Ax2xJEGSXAn8viHApEZaK?=
 =?us-ascii?Q?XmrzTFeCAcUeZIk6OnK4FbanOfcf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:30:36.0852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712200cf-09af-4f9c-c15e-08dc62e12834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886
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

[Why]
It's possible that the write hasn't fully completed by the time we
send (and flush) a command to DMCUB to notify idle to request IPS2
exit.

[How]
Perform a readback of the volatile structure into dc_dmub_srv state.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 3177000335b2..33d3307f5c1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1296,6 +1296,7 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 		}
 
 		ips_driver->signals = new_signals;
+		dc_dmub_srv->driver_signals = ips_driver->signals;
 	}
 
 	DC_LOG_IPS(
@@ -1339,6 +1340,7 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		ips2_exit_count = ips_fw->ips2_exit_count;
 
 		ips_driver->signals.all = 0;
+		dc_dmub_srv->driver_signals = ips_driver->signals;
 
 		DC_LOG_IPS(
 			"%s (allow ips1=%d ips2=%d) (commit ips1=%d ips2=%d) (count rcg=%d ips1=%d ips2=%d)",
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 72cc483e1556..3297c5b33265 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -53,6 +53,7 @@ struct dc_dmub_srv {
 	void *dm;
 
 	int32_t idle_exit_counter;
+	union dmub_shared_state_ips_driver_signals driver_signals;
 	bool idle_allowed;
 	bool needs_idle_wake;
 };
-- 
2.44.0

