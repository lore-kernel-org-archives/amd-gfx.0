Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750B5C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03EC710EB01;
	Thu,  6 Jun 2024 21:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AemfFVpT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA7410EB01
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuUI85s/Y5V8a2fSOsXLN5yTNVXJ6QCnC08/+yQmr7C/2AKgzk5RRGlk4FxIXM2t6nJtd3wyypcH542mjoHKVvzjXb4PqJrpFAxg0pUjMry38Rbhc6AP0jsBh0RbzvnmqgPVjifYu4Dbn8JyhAh2GrWdTjwGEPsyvZ5p6Dm5lFTvoErCExPWep8KJ7a/6Nat3/BLw/BKBpvgbYgeNb837H/FeLhwkqSVYjIUhQmt5TSxttxJ2yQPFK4vPAz55D0yLRbNtubKctKsXaYGXLIQ/jXWA77av0Kga+ooN95bd+yh0SnxVWXrquYZu1SgXwcJ/Ge0Eiync3FO+JdCI7pUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/fEIJ8FoSid1LPlKYXlMaFtQuNoJz2VzkdUqTXvKw8=;
 b=XzFr6IZ3XMIXUYvxUqfi+c7IDPaX6C7gxt+/SdoHwKNybH7n/j1qXjHmTvyB+k99dJOHBXe+smBmexmUUTtI8JVJMpARt0vDSj55XjxBnPZfQJ01oHVC3FqAnrEjmtxKJOXNXfXkOQq9KdI+C4jAvy3hn6R93fDPb8vOp2qUa3Zxd3PZeBK8GV7Z0ENuySJz6/WDb55uIm5iZlXW1KxPsoRhv3pcuQq+3emhx5IJXAjWrWM4FmeoEEGA5hyydUI7F+1xhonjED/i7g+VzqgROVgkN25dwJTXJVVAy/GRcRDfq0G/AWxY5TDSaq9xjWabmw09QBnmBuDW6FvvA8WvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/fEIJ8FoSid1LPlKYXlMaFtQuNoJz2VzkdUqTXvKw8=;
 b=AemfFVpTrBF3CjM6b5Iz8+aCFEpCqiJC02lZiGB/+2Qir/mH6XG91pOdUs47rEqR8UocX5pDoj1mUnI7e8cbOzWavgs/l3ctUg2zo37szKMKZ/NlAh7dDgY3s2dDJodgal5N6/BdIb87VkQ8tdQv8pq8in52h2gg84MjJmABrzM=
Received: from BL1PR13CA0258.namprd13.prod.outlook.com (2603:10b6:208:2ba::23)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:58:59 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::22) by BL1PR13CA0258.outlook.office365.com
 (2603:10b6:208:2ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:58:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:58:58 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:58:57 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 50/67] drm/amd/display: Fix uninitialized variables in dcn401
Date: Thu, 6 Jun 2024 17:56:15 -0400
Message-ID: <20240606215632.4061204-51-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2f0ff7-efbe-498b-9db5-08dc8673de38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KMe9gA3SPnRAc6AFT/GQxffg7g19kx7AcrJ4vfn/jRYVLHgYzjaqIQnfn47Z?=
 =?us-ascii?Q?cio1HIIFsNUdkxlt3Elgj5vAhf64K1R5yoOQJmIlhcOee39kntlFbskZxNWr?=
 =?us-ascii?Q?QRo4pgn+TRHO4Z8BplJBKnZdrL4ss/vIIpb9bhoddYil7NcFUMhObcqf9YmW?=
 =?us-ascii?Q?QWUsB/D3mAAI39BaIa+e0l+ujqtM6bPCaR2jEJdMDl9hCDLXCqoy1Kr0S4Li?=
 =?us-ascii?Q?5W7ShJST3M2ROfaxUWM/t64ITAU3XbZb0PkXWsm6U9+mhR2ExrN+Zuge54uK?=
 =?us-ascii?Q?4b3I6yWj+mLRcbgD06FL7Rh9I3lWQPqmJGuY2sBVnoVCXLjqGTM0qE7dAOh2?=
 =?us-ascii?Q?Oz6HYOeYleRwv2QdrQ+P8x6tEySWc7/UEFWdexcCY++Udww3o3NifRC8ZzEj?=
 =?us-ascii?Q?IcjJYf415nIXh1NiPVQ+z4SCYTbO6Ls97ku+pAWA/zNZ/Tyhdlhc8xMjQuFW?=
 =?us-ascii?Q?7Nw6tzLtZrctARh+OsRyeVa3nTBz4OnTkb7O+wOwekmmlXF5n+axCVebR2bb?=
 =?us-ascii?Q?gAKzqvs71YMYsBin+zo+nYsS299APkk8VUOsi8agkN5FCqMypw3mu+bf/bA/?=
 =?us-ascii?Q?oHn1fwPEvQaJbx+2t45SOvDd7sp6axWZ8ZtcLctNgBWKvLcOVQm3j5YUHrNR?=
 =?us-ascii?Q?b0WN+r3KKSU72P/j+0MpPeFGlvDPy+jIvCs4aZKacwwAcUd4EGeyDS5sWeJC?=
 =?us-ascii?Q?N3v/0yRMegmXH+ZLaDnJYqEs3rP80MTdjRdYMLdz6GHrAmC/awb42EklC8Ty?=
 =?us-ascii?Q?Ufsm/C7InlWXVyTgzvJNZo3TL4+0cA2GeLgl4P1vPNUqyKaxJe54YM57+xGF?=
 =?us-ascii?Q?t9U2aOC3EEhzw2rI4Tcw0WDOMZfJl3X3VrvZF86cN0U/eKJCbLK/LcScnel1?=
 =?us-ascii?Q?RxKLWII12bnN2MJjjgpV9b1xZbypJPwOH0Bc4u/rW+7ShO0njAXKJPgDiixu?=
 =?us-ascii?Q?n3AOd+ZK3EZgivWixndFdTs0KAWEhK8jt+PDDJZgP28Egzsrk8B48crR+AIa?=
 =?us-ascii?Q?nTtXUfdgWJzJzqyjLJEv7sGduvR2BR5cQcaqOsVmuMvgVgpXMYy5oN2HGs0s?=
 =?us-ascii?Q?9vJyemBqdJ6yyc8EqbXQOJ8LW6/h2RhGGU2yfwWVfchlEok+eromIe2sN2HH?=
 =?us-ascii?Q?Uo3Yte+396+e2bEionh42GkFqhbjMjdsmnW2LOhUEDskGuS09Rvr4HnKRj6v?=
 =?us-ascii?Q?2+c+GcAyIEmqdYlAifeD163Z7end9TkZGME6OqOX+A+87SSWxdDzN7ZVtZQm?=
 =?us-ascii?Q?rIcma44YQvwRZoHVHXllvUMfkIhEvp4XON6tMEURnRkZWwJJ+fl5WqmZAnRc?=
 =?us-ascii?Q?E/tiXPGIHuyeyV9ladK0pmGbYfRPOmoo4Uob24nprBx8fBZkiUZFCBLKK05d?=
 =?us-ascii?Q?clh3HjQRHrV1G/EUIM3kEk/w6U8JKo9XA4axjp+YGqHsdawmZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:58:58.6756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2f0ff7-efbe-498b-9db5-08dc8673de38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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

From: Alex Hung <alex.hung@amd.com>

This fixes an UNINIT issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index fe0bb6147e36..116411aa0a2b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -805,7 +805,7 @@ enum dc_status dcn401_enable_stream_timing(
 	unsigned int event_triggers = 0;
 	int opp_cnt = 1;
 	int opp_inst[MAX_PIPES] = {0};
-	struct pipe_ctx *opp_heads[MAX_PIPES];
+	struct pipe_ctx *opp_heads[MAX_PIPES] = {0};
 	bool manual_mode;
 	unsigned int tmds_div = PIXEL_RATE_DIV_NA;
 	unsigned int unused_div = PIXEL_RATE_DIV_NA;
-- 
2.34.1

