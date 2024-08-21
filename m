Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2437C5320E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 22:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FC110E708;
	Wed, 21 Aug 2024 22:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dr8w/AG1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D9510E70B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 22:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoG0Co31KHpBYo6Jf5VSWhCWC+CSW6CIFtOCANBWm0eYL8Uz32FvMCZZgj5xV/pPlo3OLSo5SV6MguFGpgllDkUKxzZ6HqApQFhQFSVi8AFBXVDKrXc9QX3Qp2kBrMLUManJw39crsArIkJT0/t/LarR0oVWZ47W4BLyplABkEM71minn3G/MH/2Z9utFBQZ1v6GjUaUUzjQott+3hQTyeq392qj8TR8ruA9dG2XERX8+Be5CWoKwNeII9eeEU25PBTwUdxOtBr0c5+UHmw2Jw30L8M6Ecl1ikPSNqGpJo2NbhboQcFESO0eSniSXq48tBbdxLzZquhHhP91NgtBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=recpLstmOxGFkbF0PPqIOTEtVIIQdEDnzraUfet9QTo=;
 b=PftvIIORN/zSoiCZFzsLMFLlP6kgmkfGfqDwVTdMs/Xk9LbjfC3IB1Rzx/0+G6mNhfBH1JUXqNpenpQUaCIkbLRH526oATGjgYfYSXGRjr8sR2a8YDTJY3H4VY/Sy0b56AoghblQujt7mxN8UUoBpSYkba5PAsVAfJQoPDt1QQGC6D8Xv2kz71L1VYLU2HQZXsvctzRXXJW5ORoZhTrCjvTPX4KMzvnyTytYeZrxI9dGew68sKOl9QnsKhEeiJ097H4g9eJYkgmTuUgW03N3qiwrIZQELgawHmaMO/NcwkszO9T0YMvdk9lGGAIxnyzspHr/zxu3uYUlNhbi6m7vMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=recpLstmOxGFkbF0PPqIOTEtVIIQdEDnzraUfet9QTo=;
 b=dr8w/AG10F7rJjS8MzkTdGtADKZYEK4gdMwX/hjQu7m3PFwT48IqYDRbrJYXjvqOcDeBkVa9wiQ9D0HUKht9KNGTOFDnCkIhnK+OaHqll6hXpM6skgEQ9oUYZgfwD26zu+CL69ERHLr8+9E5PAuk+LS9Mm+WfBSAfGXnMXOr4j0=
Received: from BN9PR03CA0436.namprd03.prod.outlook.com (2603:10b6:408:113::21)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 22:04:43 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::b9) by BN9PR03CA0436.outlook.office365.com
 (2603:10b6:408:113::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 22:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 22:04:43 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 17:04:41 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, ChunTao Tso
 <ChunTao.Tso@amd.com>, Robin Chen <robin.chen@amd.com>
Subject: [PATCH 08/16] drm/amd/display: Retry Replay residency
Date: Wed, 21 Aug 2024 18:01:50 -0400
Message-ID: <20240821220156.1498549-9-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
References: <20240821220156.1498549-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ffe0ce-f6dc-4f10-c1a8-08dcc22d42ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oqjj2F+Kh4y9kAA2hYD+Ag0UMc7a5l1q2oI+KvFIg0j4167Ju1NQ7d3C+j+f?=
 =?us-ascii?Q?o7mJkkv8TsQB6NHlP2xJ5PbqpwUGXcqKfjcupNUvoCkHtAQecz2pJ+TfOQgd?=
 =?us-ascii?Q?5NOPtczYeXysmgI74UviurJQEFFl/F6kfyc91iT16GCrdNkLqa1bruk288BG?=
 =?us-ascii?Q?A+u0pE2KDtl78sj1g8ig30rkCNocIl0ugKN7T/Ov/agUzRfTgkp48T1SxXEJ?=
 =?us-ascii?Q?5OjgAQw+Qke329RBrP+pF7I6+AWRZMYiksTdbLExbuxrrQ8HfHXBLESrwfHA?=
 =?us-ascii?Q?b4G50F1vjikbLRXGvNAcxvt+DtCJ8EgS13RMoyjVngaIGscbSycxAeDcPwBk?=
 =?us-ascii?Q?TBWrecjmwiXCqjz2OffKN7X2yTfkE7ApRum2Q3z9s8QwtqFxwDkFH5Fn6lxj?=
 =?us-ascii?Q?/rF/Q6GfCCRsEWNX0W6KCOpjdy2FdpWSixmfJm0OYAUAwQKNSp6y3Be7eqJk?=
 =?us-ascii?Q?vAnozcOYNyEj91YBLJPKXLYn8e0pTxlL0ig6dtEqkVVI4DnBY5hl59yVI2m5?=
 =?us-ascii?Q?QESlLlpZn0NYSwK000WY/O5DjTPRKUphktJLMkS+cVPEygWJpgsmTW9GKSbj?=
 =?us-ascii?Q?8hmrXTIPU4yY83oI6vKsechkaTuw9kJqsdUe0ZQ8IS+kAmgH/RFDbkyuZcff?=
 =?us-ascii?Q?2anYir6ueTYat06HSkgKtCjWtvjynuSWOPOY/bu0SWrsfkUmnwd1XoZ7FXot?=
 =?us-ascii?Q?YyMFCaQu5mVO8ViA4ni+EXHqWB4lVhQrDfYBG1uSNt21QGH4iRWcKU52R0qW?=
 =?us-ascii?Q?raKkh76Uagv6y84B+nLiNxjD08zjgFRPD72qFEZYXNEGWIiIAZSkv1KY1a0m?=
 =?us-ascii?Q?PUiSIcJ8u4V8nRjyeMJt/R5CBN2pV0DCeawBhvASIyDh5sInOQ9wD2wsDUow?=
 =?us-ascii?Q?L73r3SVj68z3J9m2ugZGpFd2MJIPQ54ZwyydFZNOHgXQi3gJsEPa4nA+N0pM?=
 =?us-ascii?Q?zWUYvSEHOVzkzOHkzfeldwbp7feN/j925LXSdgAk9ZTu2K8PI5RPhrCORYgY?=
 =?us-ascii?Q?UYdWUHdAMLcqDpizkKtJeumwXI5T0Xe5TJCRvMyQMMjsQVaoC0+kKyQyoehm?=
 =?us-ascii?Q?/bY83tzdaCybhIDeuaEA6dFM49claM5oi271xcLyyuD5TL81p7zcaSXI11Ys?=
 =?us-ascii?Q?PP4eJmgENK05hZGu1k/6FgdO+A9xt5tkuNf6uIfDliFhw9xwmHcr6c9muL9p?=
 =?us-ascii?Q?YxIBOCm6o8nSsVrkT3HN6FtS/1WyE8chnnFSUnxbIblKyvn2TcKCzeaZAkHi?=
 =?us-ascii?Q?Nw0F2t5vCDMRnh0gCnLw4dKfD/xfC6C9pIEAFi6bKhrTzhzG7TtTLIfsQzIP?=
 =?us-ascii?Q?euOlNg4wMnq4kJw/ODnLjkD64/nVnKAZrJq4xsgPw2VMmmiK3M3jAjOp49EX?=
 =?us-ascii?Q?Ku87qdSxVfbvsuplS9YT9SNHU+gLp0BUA/UqEVkecYg3axbHGIFcpn1rjHt8?=
 =?us-ascii?Q?Wdf2/rkV+7Ng8eaYDpe1evG3dw+QM/ff?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 22:04:43.1468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ffe0ce-f6dc-4f10-c1a8-08dcc22d42ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551
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

From: ChunTao Tso <ChunTao.Tso@amd.com>

[Why]
Because sometime DMUB GPINT will time out,
 it will cause we return 0 as residency number.

[How]
Retry to avoid this happened.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: ChunTao Tso <ChunTao.Tso@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c   | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 14f935961672..c31e4f26a305 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -12,6 +12,8 @@
 
 #define MAX_PIPES 6
 
+#define GPINT_RETRY_NUM 20
+
 static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
 static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
 
@@ -222,6 +224,7 @@ static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t panel_inst,
 	uint32_t *residency, const bool is_start, enum pr_residency_mode mode)
 {
 	uint16_t param = (uint16_t)(panel_inst << 8);
+	uint32_t i = 0;
 
 	switch (mode) {
 	case PR_RESIDENCY_MODE_PHY:
@@ -249,10 +252,17 @@ static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t panel_inst,
 	if (is_start)
 		param |= REPLAY_RESIDENCY_ENABLE;
 
-	// Send gpint command and wait for ack
-	if (!dc_wake_and_execute_gpint(dmub->ctx, DMUB_GPINT__REPLAY_RESIDENCY, param,
-				       residency, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
-		*residency = 0;
+	for (i = 0; i < GPINT_RETRY_NUM; i++) {
+		// Send gpint command and wait for ack
+		if (dc_wake_and_execute_gpint(dmub->ctx, DMUB_GPINT__REPLAY_RESIDENCY, param,
+			residency, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
+			return;
+
+		udelay(100);
+	}
+
+	// it means gpint retry many times
+	*residency = 0;
 }
 
 /*
-- 
2.34.1

