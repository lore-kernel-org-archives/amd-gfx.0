Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A2CFEA817
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18C810E798;
	Wed, 25 Mar 2026 07:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GstOsPb1";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F26010E797
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:08:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh6S0TOEZX2wnqGmkFb5fI8ayF8G6KxvGZVNdt7O6wQ8Th2UJF+WsGAtyZemt+cVOxbKvIcfcFyve6YXnQRK2wl6CI5Qjkuxv4goXTtCWhkHkDXJhIsfYFwvzgyxGMkCIpanm1dyYJNvGAA8CpmSYdczPs3BQPab258kyjkv/7a1/4ZI8wTnaDYQO4YfPi+tiHQw9CTo4t+zSQXVrP3A3LI4TPmeTpyVpgJKdMsLe2wPtJ2gGY40PxzSXwVnh28SszVqgQy3lqC12fltbVosWhUXWGkmoSmOKiP6QruxkM62k3G5iK+i7h6b3vcTH5PmKIP7DuNajJl1BLJREF+wXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+bOpySWx32EqyxHjYR9J+OSsVQf7X2rl11LbTUg+gE=;
 b=bECODw5PvMRfq59O4fo+SG7zmHY3fJWlOwqt3vRlWLzHrYpl0t9aAnzwYdDHv6jpVFubC8eyXgeT6BO5lRvb9v18GaCb1QYo+/3I6Yw/Zrc9ns518J7Dpzj5zq3wgT9fyU4U0gl0PAZyRY/DcesRD6wFq/2YttXx6FDwWJBpUVScYmlcJ6zC0lsMvSW9Gq60i2Hy+f95eJ3VpW8f1yIi9OXupeqBvwINjeNhQMhpB3JlSXYbGhqGK+ajsYfeqlRKLhYb0yeS02N1oYsfXYMLIi+LY/b2U7dKUbpmTi2/eHPGb8zEl+tt3bJiQmTFQ7Cf9R/S9eS0Mce3Fj95ROk6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+bOpySWx32EqyxHjYR9J+OSsVQf7X2rl11LbTUg+gE=;
 b=GstOsPb1vTw6ePae59NOxHN5HpKfVbrQAkbh0lftKirhb9QZlZLzjO3GO4I1N59nOkR+Q5Jy4GqJRuz8xYYk3LwvD7+oQM5tYd477HRixEYEFHKM+zPVzySk6rU3+6RoAX0q8HIBVHyqNc7k+gRmyhceA8dBcpCzbUBjoGdNKb8=
Received: from BLAPR03CA0061.namprd03.prod.outlook.com (2603:10b6:208:329::6)
 by DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:08:47 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::61) by BLAPR03CA0061.outlook.office365.com
 (2603:10b6:208:329::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:08:47 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:08:42 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 "Clayton King" <clayton.king@amd.com>, Dillon Varone <dillon.varone@amd.com>, 
 "Chuanyu Tseng" <chuanyu.tseng@amd.com>
Subject: [PATCH 03/29] drm/amd/display: Fix Compiler Warning - unused func
 parameters
Date: Wed, 25 Mar 2026 15:06:09 +0800
Message-ID: <20260325071003.4022594-4-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 928a1054-d22d-4043-601a-08de8a3d5bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KubSl4Ak1fWk7+8DkAVd3bzfSFHtrfkrQduPgwPatvWXfkdNumPR5FG6sKXzG0aTnUt9UaL2F9f5UrO0y3lJqjKQsNPvUYPQi4FVZFmDjJNo2qIcB/2qakFAJZ9EXXTr9U3DzDsruooLJrz4nRpnaTfuG6j8nKCeJu3pakUjaZ8p1+YEbMc33HB8lMecC9VEXn3zphTfXMrF9ZNhCth1Txi4aFVZKCVn4rpTIqmJVpFWwvaIbKAN/5SKH+K4DGtQFMAI1UgK6DY78O5FzEAKZPMyVyYwcsAcJASfkc/xBwuZJ8/+VYciDSCgaWeKpvKdZV+IWPiKy6uEzTY9F6UBetu/RYUW24ztZCROcbz4saMBTZwjsQfdmaakXXQCSdM49v260myzjJhKSJrGfdLefrRFZuZ2a+t54Cd04Xi6Mr0d76NGn70e1rQ11U431IAd7Upzmceyfcvt96YCTnznZJFVFZs+r7/VHLfvNIhCB5Ok7xVwXTqxvr175nUDZrNtciO+BJJ3bTDzb6/8/6MFilNPdzVgfiBggn1W+69RnkClx8OKkdHLRkgL5qF413TXjX1bbMxXI7oYV4aBXPJKmaAH1gBiIItyxZEcAkzWdK02jAESa+0xxugmyckm+fDY2WsX6dAr1Qx0WdcBO0ZGo51F14zRM9qNw7Cngn0JJXDiKDFWWgMQn0vXCBJ1hpu2KyjLyPfAVw6fM9LD3BPLL0NWS2qUKamNAavbod7z0l8PxW5fQ3ytPjBl9TzjnI6ojqTDenL5o2TWn9oNBzGxJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +xkxEaO5lFZaGATI0Z5X6IlrrgmqE8xJ6PcdMrQpovQB7YD6jFxTDy16OWf5IxmQ01GmhlRF5FwYHGPeCgplPnyfvVhVk4ERuhDHQpV+BxOnY1vYkODnuFa9cO77KnlilLx5UrfbtkFxzAds/eGP8b6o9aoQriN0cXpfq49WbeQ5KPQxGDEjNrewVLknouxnwWStoqWmzn0hZUYx2h+O1MmF7lUfca7MaHjLxakb4p3hP/YM2g4P8DVtG0cCwZHt5Z7Y6WTnr9RgN9Qy2v3YwM3MrWW2pQlnkH/oL3gWJmH5prNgqSuuWePJDrXD18kMZj6ROIfioE0K/pkJ+NEsrkbg36UkO1maV0Oml8r3uGIDQZxUReabhMqhTysRpjpsyiOtma2Ok52iquoEk6gO6+Wn/G6EFUsGkFpgQzP9FZ8mYuliZoAHblajqCbhi39A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:08:47.3480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 928a1054-d22d-4043-601a-08de8a3d5bfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

Handling unused function parameter due to cause compiler warning

Reviewed-by: Clayton King <clayton.king@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8b21816cf7c8..5d27666bbc7f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3142,6 +3142,9 @@ static struct surface_update_descriptor check_update_state_and_surfaces_for_stre
 		const int surface_count,
 		const struct dc_stream_update *stream_update)
 {
+	(void)check_config;
+	(void)stream_update;
+
 	const struct dc_state *context = dc->current_state;
 
 	struct surface_update_descriptor overall_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE};
-- 
2.43.0

