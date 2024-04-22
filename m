Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E37C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6A9112BE4;
	Mon, 22 Apr 2024 15:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mQkItiaf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8286B112BF5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGNJvbYBc4PvvFEeIsosmi6OjaJPApjQGjk7CE9nHvELs3j81SInrxO0Gp+rN7sQnzpnle1DC/+Q/nFh4NKpEaIAhru+sDYs8CRIYVj6/Lv2Jwfrgg2MXC2D+7jk5zv3klDlGxo4EZWlxWgCYphzEWbkGDs6cLIOci0Tq0D45y3sjN1kRP1gr5pRWA4lK0jrndoYYrOBB7uTPExqBIsESeIat5p2ilBcflCxyd5IE2WKfFYEBsyUaWdCK2v3qUSI2XFo67wbjWjA4miIX3CPLzSu2AGAbX34GxcjCHob5sMQu+AzjvIBOEmRvTiBvOstr6/rVDW2Zjj3tTuWcfvrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3u25qXcsVygU4j10XHdAz/3vyH0huCWWwbaF3/qZmk=;
 b=CJj8faHY8XLhi7kdESbs+IA4EWcDXGXkpsgqyFtz7AWOupJedUIoWMGkeH9pyMM7ndBmFwujiJXH7Y/Km7fDp5WI8+qSZKkLP9vFwbLMItBF0UvjJAfHQGh8NV0V1Lya489QKtlgUvpyGWgYqDWMG8EOshUY3SlOKZvi5Z1aCO273Qg9JtyNxrfHuNagiZrCpU6gsyqEsZPGvomO77K3uE/yFgCGde7CD5VcyhXL47CJc1HX9N8AF10olJcscPjLNK6N2RpYR+xAQP8+pkoAu9v55sNke3f8to5HowORhXlHCv4+O+l364n7cqABdyhn+Xd8lMiIwvxsZMGu+HPg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3u25qXcsVygU4j10XHdAz/3vyH0huCWWwbaF3/qZmk=;
 b=mQkItiafhsDLt4XuhS6CDwMeAiAv/lJ63uN5Do/yEfaFmWXmuW/2LPzc8NLR7K55xTgFw25Fd4f6fKmUDWiKeUON3tsG0WKkx47Oovs7rAwi3NOCH6tpoOxkDcQqRgaBbGHizdZ94npODPk2+ZAWasFw6NcIoAjvaEK2qXG00RI=
Received: from PH7P220CA0096.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::25)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:45 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::2e) by PH7P220CA0096.outlook.office365.com
 (2603:10b6:510:32d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:43 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:29:38 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dennis Chan
 <dennis.chan@amd.com>, ChunTao Tso <chuntao.tso@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 15/37] drm/amd/display: Fix Replay Desync Error Test
Date: Mon, 22 Apr 2024 11:27:24 -0400
Message-ID: <20240422152817.2765349-16-aurabindo.pillai@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a523c74-2017-4612-f562-08dc62e10952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZcK5I+7OUWgB6vP5wueLwOqOJaUWVIBG+bmDr+dNgpvDaF6LCxTZRrkDTcu+?=
 =?us-ascii?Q?4d3Wch86sC71KIFUbRT9ZbE+tX9vrffkx8YUG1fElYFcgLLjXNd2dDyJOJG1?=
 =?us-ascii?Q?Bbtejob1e5KFY+dMfn58MyYoUdSp3yp+24OcD3XdE/fvtYQXCDEyci7QYe3X?=
 =?us-ascii?Q?eilUNEJCEubCrmq4ai7tc/KTPTyDt0hdxm/BxA3lBRKR4ySddLNWQ3EMb2Wc?=
 =?us-ascii?Q?FaDX50A9rgB64JhpKF81bXSKx2iEKpgdsYcg/dJHrbXP41aAtAJkOXULJhrP?=
 =?us-ascii?Q?ZGfJmifdYCHCPp9RQ6MgOqRlCyoJhNrnFh/Xh11osvDp8pBZjcB+rc7cPVe3?=
 =?us-ascii?Q?873rrWkyeMo82ZeNlbm62K1iMhT67dpV5cUnX0qBHcHKUdY9P6Ub+qglpNzW?=
 =?us-ascii?Q?Cl9YmMvCOWx5kRj5Z+tXH3gRpi47RrOA1NJM3zCwwXps43NDI91mDL9CAL9C?=
 =?us-ascii?Q?XbqLEbGJ7Mq0PWl2rxhxK/Y5nNW6g7WgVX18S3/b+R1MUPGc809WOoGjznZt?=
 =?us-ascii?Q?FyAPgcEuovXskfGx5GGXrabSfa7ORNtJNodg9P0ILDGI8CjHs++/iCkDooAi?=
 =?us-ascii?Q?AncbKwjk5Dyx1wTQC7yrsgyRDvCnF4mdcMqXABSCjYerIHLqrs8X3IgUL/8t?=
 =?us-ascii?Q?Pll1W+UQ6+SEZ1gNpqlZfakyElhgHmwWNDJF6kOkjFMNumlpqpMANjwC6iFo?=
 =?us-ascii?Q?ANT+FeEfniAXose41PGQh6zGB8+CYhD0zZZvIcpLBlwsV5p0P6LPPUk5+csh?=
 =?us-ascii?Q?Tk9JPT8hdBrtODFUOhq0UA8dzKF8fEz5Oqh0t40aXyWYVXYyMNWDucpAI8qc?=
 =?us-ascii?Q?nQSz+cHbDdyZWrB9mys7l6gmDnvUzlFTLoVAzuQ5Sp61o/1xUYPljGiluGTb?=
 =?us-ascii?Q?yn7EC2mIVa2jhfkrGUwTLh750YfVWQC1odkmPdnYjOuda2+6DpqoPjtdLaZD?=
 =?us-ascii?Q?o/XKZ6CSzUWLlOtZ0VSgsPRHOUuUY8jZdFlkNi4hQp1iqgbK0DcAs0QGymNQ?=
 =?us-ascii?Q?mO63CmFARYBsUpAi/AxkZ2orxftM3Y8G81hLfQczkitzZWorMUzh8rp1iTfi?=
 =?us-ascii?Q?nbcHO+Phg46AyB2FhzKPItqp9frVqTmITKyJy/6utJdib1oh9DRXksridze/?=
 =?us-ascii?Q?FEBl1ubhrFujbmx35BOXfYBOJI59bke5gejgEWQP7C1m+Tsd7r1uJiEB5KCj?=
 =?us-ascii?Q?5FFDke7Q9WzcYiM0Av2CvkxMbQD5o7ZxAqjrXVo+7+7VPm3ggrIVpeu9W4qm?=
 =?us-ascii?Q?xcsWQls4030559Oey17Kef9mIWFitP4FZrqt7Z1rJJox7IBLaP//HxlLvbmA?=
 =?us-ascii?Q?GsyZuaYvpVEGfqrVo8jViyAysh8t3cuY60GiOL5q90KEAf2PxmEdM12IP2Y6?=
 =?us-ascii?Q?zboThTU3ZW1XacbttFXn8XLJ9TxL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:44.2738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a523c74-2017-4612-f562-08dc62e10952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355
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

From: Dennis Chan <dennis.chan@amd.com>

When PHY power off, the DP_SEC_CNTL cannot be configured and cause
disable Adaptive sync SDP failed. Regarding the issue, the driver will
disabled AS-SDP in replay state machine.

Reviewed-by: ChunTao Tso <chuntao.tso@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Dennis Chan <dennis.chan@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 6c85ca3b1e1a..d79de4780151 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1035,6 +1035,7 @@ enum replay_FW_Message_type {
 	Replay_Set_Timing_Sync_Supported,
 	Replay_Set_Residency_Frameupdate_Timer,
 	Replay_Set_Pseudo_VTotal,
+	Replay_Disabled_Adaptive_Sync_SDP,
 };
 
 union replay_error_status {
-- 
2.44.0

