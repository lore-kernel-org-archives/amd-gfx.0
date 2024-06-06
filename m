Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1C5C27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA95C10EB12;
	Thu,  6 Jun 2024 21:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OVKC40/G";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B7A910EB0B
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4iafcHDrqDH23PyjXeY4JHDSLu1UqUuUjlLbdv9wrbRxDr4ZRnT0Oh0OgnBo4ALA+k3+dv9QhksA8BL7qb8RAqHjSzL1mPpxWvB0wiGVGdEaVAxyGTmi9b0re54WNkB9QV2VZf/qtbSzWfQWWLm0Gq6+HB4K6ptDHmmKbLiAko4oQYYjMSMnwoJdv9Opds3nk/QpbGaJ8f9rb+pd1ZD+k0W2oeZFWQ6NunEcTivlrqYMv2grdiyIVnsXMKokVGGcKw7w91qF65Lz96ZRijGNg5S0HvZ/QiiVWhhPaI6jL/Mos7RTm2clu30mwUmNB8SURsyqWPhNUebobwytu1F6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYMmSZu+bLFf+TAoJHP3RA9uYeqCX2P7Uh83uQe1yf8=;
 b=GxJHZ5kF88FAsj0EwoIF+i2DreeF4rcl0hIlxlQDJveEIQKbQlTucuWcYqLLWNRVAubl7LhvCqSw2d6iDBe2tcyj/rnqPfjdqEFn45nVMmPNj2degsra8puezXFr2TVLqbKhe/gFy5GWjb/iQ6WK02gCN3IR939hSWg+cn/VhzhUzjPtevoCNX6Y+m0ed0uE+i0yt03e4J+mBDIiWh49HWOlkmCCqQYchPBKwPA5e3OGkCY9LSBw8jXiuAx5hijkcTR/g7l8YaHyiCVQnpXK/dFSnMaA4Hc9CuamonH+qiwcvJMKMoitpXFsgk+2YmUVAUnLcURognDzOA35xGm6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYMmSZu+bLFf+TAoJHP3RA9uYeqCX2P7Uh83uQe1yf8=;
 b=OVKC40/GHKUIjoLV8uu80rF1SUhOPCR3tgH0CO0pEyvYjai/ll8/NrhKrX/Qa12Lx7L//Ami7SV/xf78Y+pm9tVWocUHcsC6dcyZj5cvJSWJ3Llik5d3GREs6F5S+QrE72/c7SVNoA14rNEe2k9FjK7/vlB0fqeJ5q6LmZDOj2A=
Received: from MN2PR15CA0066.namprd15.prod.outlook.com (2603:10b6:208:237::35)
 by CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 21:59:12 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::1a) by MN2PR15CA0066.outlook.office365.com
 (2603:10b6:208:237::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:11 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:10 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 64/67] drm/amd/display: Update idle hardmins if uclk or fclk
 requirement changed
Date: Thu, 6 Jun 2024 17:56:29 -0400
Message-ID: <20240606215632.4061204-65-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 2237d45f-15f7-4474-d7d1-08dc8673e61e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W6NCyd+z+xwJm49+eYFSIf9HW7zDc3NHW7DXXCU2mkdTEzCynKwqMLjpdxKE?=
 =?us-ascii?Q?l6jIGoOE4glHijiznHql1psVZn0Ir4NX6BB04VDmS/VbaCGLFMstogZMxKNC?=
 =?us-ascii?Q?5sfBmW2qT2u6+eMc4OdO22NJKlJMjfLdPISPN7QuqB32rncBcsXLrInx5BeQ?=
 =?us-ascii?Q?frmUJ+g88SPC/QDobpSI+7ztSy+otfPtIoQGwQSbN+B77F3JhBEyr7ZgMpwc?=
 =?us-ascii?Q?/hrW+w/GJXKesexi55IWiyPxB5lXVJirnCoBZA6v5mTRid+zW2FQOC5Yf8C2?=
 =?us-ascii?Q?htm6zlUU2/rXYy287U4IUJAC8ZOinkTnbZqMVaul4xxuOAtDCVskOY1IMrfT?=
 =?us-ascii?Q?j1oNtEFkMtgD8LlPdmA1fSZ4C4wmrUEU1T+FEQlb0Be8IR+Ebo3E0ziyw51G?=
 =?us-ascii?Q?N60FMh5aOLgl2QoMs8Rjm5yPuGNjcfB5q/1uexyHZZF0I4ZsUWJXJkij8yyy?=
 =?us-ascii?Q?m11/oXVZ06FYDN6lHdc7ZvnricHutHnEP3shnauzdDzHYUIer7fkRMj8bflk?=
 =?us-ascii?Q?g5VmMQq8hdSzUJovgWRAu/ER82OXL1Gx5gDTSU6p7qLDZZCVCCedaGRrdvh8?=
 =?us-ascii?Q?KU5XTEgactig5aRrSlJsd0nl4q0ZOWEPJ7mrWqCCHjOUKoVihowJE2/lOXGA?=
 =?us-ascii?Q?MqLJpo8tgJ0KxQSVU43rP64K2CMtg/fQr26VGOafUg+wgGmNKEFYwIrpXHBl?=
 =?us-ascii?Q?M+K9MFBxmeZju0sbCwEE6cF5qTx8AjuU3IDxuAjkHWrpuE+VFU5a9urd2qq+?=
 =?us-ascii?Q?z56RcVKjmjTdKbqsphXEh4kJH3YXORcU/dHaBImly+b0HWlHMIWvHljwpt0P?=
 =?us-ascii?Q?j9FE7GANvCwgNnrQTGxI3c8WnKDfniGxD9XPQv0lqP7QPL7VAB4sunclp/GF?=
 =?us-ascii?Q?BQsZjBvfL4spQ6NE/5Kj1xH5o48eqOvZFsym9ax0eWDWWgWdvTQ1juHSmJ9k?=
 =?us-ascii?Q?JbNjacrHiRHLC7EOuC9L7iYsx2qYjWJGlt8ZjBKO1lhjw2JrLE0olT3vm/1l?=
 =?us-ascii?Q?dc21k4cKB3KbaagYEFQbpPohStX1AwT7I3LQP+XuLaRstHpRbmiNKlLVC2RT?=
 =?us-ascii?Q?ebEjYE6yQecmR8G5p2fB84+c/7IzVmMX/WY0ZHLmSiJl6qav9acBp8tzWwK3?=
 =?us-ascii?Q?6NQkDuuTkNhlFtyg9e/jHS/eqOX/y97ZxUqqycswDvzTgOIydfa4sHPm9krW?=
 =?us-ascii?Q?p/aaq1k3PB2zGExI6ahomQizwPykgiN4TWyBaRhd5pBm4fxAJrqRghWNUIGw?=
 =?us-ascii?Q?dPGChks/hl/nbS5hfbYs7qPp5Tp3BjsmYvoI8zlHEWPKQ/tGjcxuOSziU/TD?=
 =?us-ascii?Q?GaELWypR2nNKPY3L2qqbNQGwMjyF3hRajfPMu5HzJCb3sSWv9fOEBft02JqK?=
 =?us-ascii?Q?3iLE29MenoaTS3PSttpxZpaNKym1zoIhhvolK+783XM2ZQaSZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:11.9284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2237d45f-15f7-4474-d7d1-08dc8673e61e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Update the idle hardmin with SMU if either clock changed.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 28769deaad37..cd1c30fa783a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -940,7 +940,7 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 	}
 
 	/* CLK_MGR401_UPDATE_IDLE_HARDMINS */
-	if (update_idle_uclk && is_idle_dpm_enabled) {
+	if ((update_idle_uclk || update_idle_fclk) && is_idle_dpm_enabled) {
 		block_sequence[num_steps].params.update_idle_hardmin_params.uclk_mhz = idle_uclk_mhz;
 		block_sequence[num_steps].params.update_idle_hardmin_params.fclk_mhz = idle_fclk_mhz;
 		block_sequence[num_steps].func = CLK_MGR401_UPDATE_IDLE_HARDMINS;
-- 
2.34.1

