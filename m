Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2E6C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836BC10EAD3;
	Thu, 20 Jun 2024 16:12:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q5CPggc0";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4317F10EAD3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZyoat8xCXHF80TebDvk0vn0OJVK5psER2F76qEx6+AD8BFGYEqPx5+9yWqnlSDhQ2oTnj9spAegTXkA8x1uWFoQe48QeMAxsUsN7/3J2YfCcYnWJzXRL14U4M9UDfHoLd6y7VptN4hZH99zPgb3U9ZYvn6AFxNKlTsuMUS8ZdNgpebaO2fYgCkL5XwkUN4PKmRuBenhhs9O1dnced2ICipkGf7zinNZlOQsUHBodN0UiP1yJJ7e7X7YZuVxsT/2m/sKYJEZVTvorjHyQNn/DdwHN5BMGOGGXNUqxyb8+UBy8TMf9gisGPBo9o/Ms4Gp93LFpOa46+a2uUfq1QmQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMw0j3PEWj15N0PPt01Q11S6myEnAXnBm5C7viBcy/c=;
 b=Egll0IqwYrhsmjUWfmvZPMb810GKDaEEeSmKHiCFops2vi1M+ewwdwxjSpJcKQNyHppMjXS1PEB5VnYwZO7DgL1eHj+yy/Vh1wGf5gtedOqYGRj5gSEnMYZFmb/37SI8YpWta7aMys7lsR8DEL/j7P+8KkygRY6KGW5EQqvanog3EwpMpxS9/7nv4Je7rJTYKLbTQmfKz/SRTTFO6EeLa3bBal32m89uGa4UIxBbFQ2TC5EwEWMKcJk9SesA3HuiWEhBCxy53gzslLQDNesPNyzUDZNGZo55x/SDK6my9nFBf5eJOA6rNo+WrMgsUXbO2QbqcC5uaPNLrl4APRI/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMw0j3PEWj15N0PPt01Q11S6myEnAXnBm5C7viBcy/c=;
 b=Q5CPggc0SSuijTJwkQbtDP3U7uUGbJ0NEOtZjVMrjIyzTqaFpJng80eCe4U3XuUUgERVtKLFk087nKH5/jTadZQylQzbUjpbvjVFgOVx0F9uk1eOt4SrePnKIBXXgPMkmbkSCTqS2Sxn/rmpA0DOxcm5NWB0uWsoEWHtvK8i7Hw=
Received: from CY8PR19CA0019.namprd19.prod.outlook.com (2603:10b6:930:44::28)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 16:12:18 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::da) by CY8PR19CA0019.outlook.office365.com
 (2603:10b6:930:44::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 16:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:12:18 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:12:15 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nicholas Susanto <nicholas.susanto@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 01/39] drm/amd/display: Temporarily disable HPO PG on DCN35
Date: Thu, 20 Jun 2024 10:11:07 -0600
Message-ID: <20240620161145.2489774-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c718342-ab8e-4a9b-b3b4-08dc9143c20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zjmd8pR+FgYDjJ+3Xcv73ojd9CcOiDMY/sse8ICWTb81MvZByBA4bjYpdP+c?=
 =?us-ascii?Q?1K4b/L3kXHl4gShIQ/OIBb6UHin4VugniNOgQ/KcOc3U7ofYaFyRqn91qqI6?=
 =?us-ascii?Q?M46gjUjU8jXusDT1fxQspPYMgPCS/rGhVkabY4idF8bgVL8ATt7HlQo/+CGl?=
 =?us-ascii?Q?MPl7I48oh2fDDwUL/4BynfmBu3NMyBEaih86m3+O9pmO/EU59lPStqTKpRce?=
 =?us-ascii?Q?61FmnRLmcg5RoEjsO8nUfd/Pm+VIzN1mpRZLkPB9EjlzGBxs7hj6OZSiNziZ?=
 =?us-ascii?Q?alXby5jvFBYc1wtQwmy8L3f6AOF1AJGWGZrWn29ASCS8JE+yE78xb8YNPHaO?=
 =?us-ascii?Q?Hz348/2cMjZWTx6m3GQxzsKmKHQj0+tpzdmjJNWvXXWvhl8N1ZVZR7Nj7fRM?=
 =?us-ascii?Q?klf2Iq/41dM8A4OmzFiGFOj6tsy+iPSnCZ3c/M8qK1h3stxZtZ1lRtgrjGgG?=
 =?us-ascii?Q?FrE4rt3EK/GkpuCWEHEJt0nyGA9+E9eSLQdF7Cpix8G/C8zFvEUn0oXsqbAP?=
 =?us-ascii?Q?ZyxhL9nMPBMSf/B3vxniF1k6OcHhoGCCmwAolgy+1evdtnS4/ITWBTL2tDdb?=
 =?us-ascii?Q?XUQbfy3KKSnY3M2a5Ud+0/Y8w5gESlg1AqC8EqAtheXuuTtM9dCAoOCfkzYK?=
 =?us-ascii?Q?JeGFJZHx7PeX4ae1/bFzOhXXwD+vM6AiNKlA48vTZ6kyGd9UnmPlafVDP+Rj?=
 =?us-ascii?Q?+8A4qpDGz4+mPXJxjkB4lF+rKoEAKYdH+er1yU2Txw2K4HarA+j3JgySbd1Y?=
 =?us-ascii?Q?HFsIxdCKOvQBDGp21STEvlZbDu4b/wXoHwxFC5R7heVZfftoB8QzcZVE2bUk?=
 =?us-ascii?Q?xf9YcLd93t2Iu8QyiqP5riRw3LA3nZzhysNzYz3n5V7mwqz3QLFEFki/ED8w?=
 =?us-ascii?Q?70nYwigs0Lynve+03domytT1nh8DlFKVpYDmYaqTuORANzQCwbwDvrUoK8A1?=
 =?us-ascii?Q?bzLDl/n6fDosGYBuLY2hbBu9yWPlTlvfuVqDj73klzuDsSZ5kbUbmG640TK2?=
 =?us-ascii?Q?hdl4eb6B2b3o/DOb17eT0ZRlLy1ttLhDSMbEkvlrlAuVBGQZytaYpNy9oddj?=
 =?us-ascii?Q?2GwJU52L5od6ww+0r9/ZtaZHqiE8DhGofnquwHPrZYe6bpUiTKh0UEZj9wu+?=
 =?us-ascii?Q?3mD3iotkSy5uq1dEoQ76FjizoWTanYV3bNwmbwz6ylT2m5gqQHqS+G+lA+q1?=
 =?us-ascii?Q?pRheziCkaeYd1zEpGGZErlBw3eYNZsZ/6MjK+sbcdhqr74F8lhwUHT7HYT09?=
 =?us-ascii?Q?klRQNDYSail8cNZaheZcT9zMLuq/tyQAeyonVX+s6BMBB7MNMmW4pKRqdeXz?=
 =?us-ascii?Q?gz9+lnlXisW8jJlZwgW92d977oXC77h1cuzxb1jnfGREVup99UtGsvFCO9UD?=
 =?us-ascii?Q?sBbfty2KrWn6CSSg0ouKo6ocgBS3lh0YTm/D2Sr1vkaTw1n28A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:12:18.2472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c718342-ab8e-4a9b-b3b4-08dc9143c20e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
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

From: Nicholas Susanto <nicholas.susanto@amd.com>

[WHY]
On hotpluggin a 4k144 HDMI FRL setup, display fails FRL link training
and falls back to TMDS which is caused by driver not ungating HPO before
doing FRL link training.

[HOW]
Enable debug flag to disable HPO power gate in DCN35

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 0094ef223c5d..67ab8c1962ff 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -721,7 +721,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dpp_power_gate = true,
 	.disable_hubp_power_gate = true,
 	.disable_optc_power_gate = true, /*should the same as above two*/
-	.disable_hpo_power_gate = false, /*dmubfw force domain25 on*/
+	.disable_hpo_power_gate = true, /*dmubfw force domain25 on*/
 	.disable_clock_gate = false,
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
-- 
2.34.1

