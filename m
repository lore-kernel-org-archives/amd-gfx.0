Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF72D69116
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 14:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A7E10EC96;
	Thu, 28 Nov 2024 14:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GY76RFBg";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBDF10ECAC
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 14:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETULQUuZwu2Gwm6O5BqdXWJ0qqYL8AOmB7rSkC8bad1OIwBVyxpshzw7zX+4qMa8+B6aPxWydZ196HEteBvbmHJyWYQq0WyKj6UC9A0YJl9N0anredzkURjJ5A7fZYVH0HSs6qW1/8htiwDJQh8HdOQFOe9sgW27+80CumXXwAfhNpvZUIQDbvZO6ypcYoX5dSltGFAv2RdpP1phtHIHqYbG5tpfLk+rcbjDsC+JeMgumh7Yp48z1lW7x/1RLAhed67GuLYQEPVhYaSyVstLacMOUnZauK4ZOyIrqMf+bCkFaY6ZVbpIJr+EkKlerBUs8aiMew+ATlpOGYAfAYojqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLDx9IL/03BMzEulIfk8gPPsr9d39TlGt3poSAo07qE=;
 b=kC6HH7pGb56cljbJDHjoGxv2bncBq/7UylhLb7LD2LcNu6ThHNQWSsurYpclvQJX8jrIfuOSGpcZ+JJ5kjx/3pJkis3ZgcXDkijQCJgiMmtSBqNs0OHxDIXKeztFp4VOJXop55/9OnP8+xOCdwJsDHGxIBN/Ch9TwH3kTkRPH3XSgBbglqNx4Mzb6xZk26n9hygjQQCBCo11Avt5MDls4J604vqQUfEZr16sKr6pAKqRYmjzJaUyLUy5W92KFhTB3S6ep/X/sNbpJ23r/xdKh0qAQ5KgXCIUGHWz6pcHBOMkEoEU+3sM3nmx1aX7y8w8JCEICmU8brOsG5VJMVUVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLDx9IL/03BMzEulIfk8gPPsr9d39TlGt3poSAo07qE=;
 b=GY76RFBg91oI+p9E/PFHBQfMmsE07nmdOnnjxp2ALaLJ15WcFSWxr29j+uDj2rFu8UM3mYBCs8Q23QybePX013f2eS0l+plFxnNk1QsRGhkCulbAyJQw05ORv4GC868+Zrw8U8tg9QSVt5OKwHNRfjRpQfBz9e14M1/abeWUxJo=
Received: from SA0PR11CA0088.namprd11.prod.outlook.com (2603:10b6:806:d2::33)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 14:30:21 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::fb) by SA0PR11CA0088.outlook.office365.com
 (2603:10b6:806:d2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 14:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 14:30:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 08:30:20 -0600
Received: from jzuo-linux.phub.net.cable.rogers.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Nov 2024 08:30:19 -0600
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Peterson
 <peterson.guo@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 5/9] drm/amd/display: Check that hw cursor is not required
 when falling back to subvp sw cursor
Date: Thu, 28 Nov 2024 09:26:27 -0500
Message-ID: <20241128142958.28370-6-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128142958.28370-1-Jerry.Zuo@amd.com>
References: <20241128142958.28370-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 978d5a6b-998b-4119-bfa7-08dd0fb9309f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6dBl946R6kgaUOzFJ5dlWZjeg1hw5rzqZHIbTvrLFfEFnl6iHhwm69aO+qbd?=
 =?us-ascii?Q?yDv3LWPjZvAvGnS7f14BaT2SQjx5XcZ/ydxz8Uuw/FbL/+ckSecrHnaOus7s?=
 =?us-ascii?Q?LjtbrX+Fd9pc2JYln1zu1QV8Fx3aaOGaQCkZcPaYFspt6yEXBIhrNKhmXrBS?=
 =?us-ascii?Q?sd1pBQ8sCy3sQVT2dXQn0thB4Vij2M3TFIhe2RPDeCMlRvgsv4vynzMlXjCk?=
 =?us-ascii?Q?7h+GPbC4lcL0Hn3EZa4IUdXOraBnVH+hV3WDZq6SFkPW/LsB2NtCp/SRVsaR?=
 =?us-ascii?Q?oue1/5Jy8haJEDlb2ScN4ItId1zJr3IhIVmbt3yWg4s1W9HerpUfabFXqDsQ?=
 =?us-ascii?Q?TTSq79KJxIDS46aGRmAS+g14DAqJgZBPBeSeCRaHAgCKQc4OCsvFg9kXE3IL?=
 =?us-ascii?Q?ykItCQCW46DaKp9HmyldhLDiB8ZEb0KSrpb0IXMqA4j15IFSq01Olv3mXxA8?=
 =?us-ascii?Q?Puk7j7tb2ODxnqT6Tn71pioSY6xe8Z0GGmCVe/hTqe2Ab8doPJh2aN2NSdTK?=
 =?us-ascii?Q?FdLf7u213CgHHcm0+IqVtB3EMVWPuBCfFP3UieTMNWXjihqoaPCp2rpDxtfe?=
 =?us-ascii?Q?sYC8Z04NgJkx7PI/qHiaCUgu2HgSR3UZFWdauwq1oonZQ7XcR65dQQE8SHm/?=
 =?us-ascii?Q?GOAXSwHOjGTqYA/HR2i1VykQ27Ex00ntNfa0wcWauiOzoGNcrgqk5fqQzKbQ?=
 =?us-ascii?Q?5+GkrspmMcXMzJE0tQzq0/ode3TiaIQNFyOzX+Tq3pysKQ8WaEXLM+ji32e6?=
 =?us-ascii?Q?IahX3uyR39+XTx9pHbvSX82RR6VJwxWrXdT/VATng+xC7Ibi9f+AsfBkbWqP?=
 =?us-ascii?Q?dh/aOyARHRf2B/ol5DBLHd5SCjOmCFm6BZqxGBicweAHRJzGX2PxUN+nwuYY?=
 =?us-ascii?Q?XFib/PAH/4z0d26IjqGJijh2mhtijEHoaDifK5oS5w5cLmVwj1zXHw/BicZw?=
 =?us-ascii?Q?UYEsTNs8x0gG5BrrDNACKX2VC4g1mMLhkV/sqagdbwsZKzgBSwMkMJRNOZb2?=
 =?us-ascii?Q?tAKmgsstb8J+W8CDXIITzD2AFCHN7kJN1Tp2b0MQxzU77k7b6yXHLfDEXfqU?=
 =?us-ascii?Q?ezcdbJAv8T0lZB7NRs20JA7I0Ff4Ue2gRrz9MWbiGozSfwqadQeR3nZiVzPo?=
 =?us-ascii?Q?8zUvkM/1sqZlrUfohsyP0NtC3BZuQWH/TXNvMkpESXTP/e2fLXvR+tjIbn+Q?=
 =?us-ascii?Q?ND1NkmN2nx8TyUJPsrME65Mh3KxQdjM96mitcwiOIEn/tiC7IFohxQzQ1qhU?=
 =?us-ascii?Q?xwOORqVEb/ioYgjT4ubEcE8WCVSCJ6eECiokZTOHWTbWic4+WxQpl6J4Dm4S?=
 =?us-ascii?Q?FcgQh6ulLpK0SjJHiqK4XTnVFVROsI5qSW6ZzT9wr8Vu6ak236NhwPeBGIrC?=
 =?us-ascii?Q?q6ZM0Duh/Vk7N2LUrPVuW2SX2ZNn04J+aE5pC9plsbqlCDKpgWxC2s7jHaEl?=
 =?us-ascii?Q?KQUmwDwn1BSMCGvrD5grZc1ZyRzUcf6M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:30:21.4839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 978d5a6b-998b-4119-bfa7-08dd0fb9309f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
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

From: Peterson <peterson.guo@amd.com>

[WHY]
When using a sw cursor and flip immediate, the plane that is flipping
immediately will do partial updates causing tearing.
When on certain displays, subvp is expected based on
timings but should be disabled in specific use cases that are not
accounted for.

[HOW]
This was fixed by improving the timings check by using the hw cursor
required flag to cover the unaccounted use cases.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Peterson <peterson.guo@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 49fe7dcf9372..dc14c0d05e8f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6056,7 +6056,7 @@ void dc_query_current_properties(struct dc *dc, struct dc_current_properties *pr
 	bool subvp_sw_cursor_req = false;
 
 	for (i = 0; i < dc->current_state->stream_count; i++) {
-		if (check_subvp_sw_cursor_fallback_req(dc, dc->current_state->streams[i])) {
+		if (check_subvp_sw_cursor_fallback_req(dc, dc->current_state->streams[i]) && !dc->current_state->streams[i]->hw_cursor_req) {
 			subvp_sw_cursor_req = true;
 			break;
 		}
-- 
2.43.0

