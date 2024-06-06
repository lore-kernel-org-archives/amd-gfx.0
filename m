Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55452C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3DA410EB06;
	Thu,  6 Jun 2024 21:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ywo2sd8K";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20F010EB03
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJy5IRmC4IbcKTITplc/j3J8VgBaei2CP3gE1SLHdZUHm23EEsjyzPcSYwjCWZU8p/1OIY2mL+fkoU4226zc/MFyyuXOvmnCVgiB2JEzgRi7Navpf8GsktIrwUQPMvIyUSWwpwcFlWwXGoIQwwp7SGYlEWNJdJh94ioLrxhrURv2tx1bKxQm7cj1DgZJQR8uIPvxTmn2dF+SOiBDgRCWrjz7l5wCp0A0OzMKhvt/M4mh5Cub7AhpUhpMpewMaGwUFJWC14S093aGEn/m0xrZbQuX5shdG0jmQ//vpVUJsrrmchdmiHd3zt89XWAmKmW0ciH9NjWdIkiFYSh+oTzPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAGtsWc2oKMBfJTwQos1kn8LgZfK5Atnnc/Gw0d8TNU=;
 b=Vff4pnVEMdhMhyi9h0ApEhe1RfXcF9xixC3k2jCe7w77+RH3PpomRl+u4o8UFJYTfLrRPvJX0N7uXaWozDYke79hkoSwPid0nXh8UUHikV9so0JXJa1edA5idyG4MM001lm+tVFBxMJV37s/4dwA3lHk7SHAUpBY2oMatnoLo1eabLYappLzSlQefyXYz4N2nxolIKDJ27kpj5gj7MQGKouKlflSoni9wbDCkwfsBMjlZtqR7ulqFOdW7LFwFQni5Heh73yFI0Ab8iQnz6LAjexbB8Kg24FklQDuMh9dusOl8gK1gr38wDKEJb2EIhOixEG9r8W7g9JGG5huTs2QlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAGtsWc2oKMBfJTwQos1kn8LgZfK5Atnnc/Gw0d8TNU=;
 b=ywo2sd8Kpxd52R3PNl0cEhByeQABnHmy5NfEHbsV+B9ag06lTXEgwepCmONewGV7RRRH80kDe9Gfl4TK0KfAnfDtT8Ijktpbz+E1NQTi3JBWHG6AXwiobllFmYi0bJFgGLXgPBxJZjBkBCQqcm2KhQVpB3sw0G5gG1Ui02MnFko=
Received: from BL1PR13CA0252.namprd13.prod.outlook.com (2603:10b6:208:2ba::17)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:59:02 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::80) by BL1PR13CA0252.outlook.office365.com
 (2603:10b6:208:2ba::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:02 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:00 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, JinZe.Xu <jinze.xu@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 53/67] drm/amd/display: Disable IPS when it is not allowed.
Date: Thu, 6 Jun 2024 17:56:18 -0400
Message-ID: <20240606215632.4061204-54-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f66f8fa-0637-474b-ac90-08dc8673e04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t9Qr3e16gEu9i2RRhwyYn1iOchTm1Au3C4EbpG+7k+dsAjn3t33BrpA+682W?=
 =?us-ascii?Q?TggpnhdkweqPSQ7j4CqtvL2/6qhNnJloHo68dBr3L0dr/Aru78tRZzcPgkec?=
 =?us-ascii?Q?ea+sPdsZuGLX8nromAPe9DSOeNnzBEPC7nof/yAt69QGja+SpRBE7gEHKiwr?=
 =?us-ascii?Q?fKLxxxEKBzqBJc9fTK3hpIeRwXicX8c02TCOumsMwuWW2fEBi6MCSc/4ZWMe?=
 =?us-ascii?Q?KbaBP38Tj7sLMDhesJwBakuiTbmq/reahtLXhX1wOx3Sd6SEmtKrpfTZYwMi?=
 =?us-ascii?Q?03c4KPjipkmlbzK2/IyTkpujAC9fbg3o/GbYGzRa2oJl7g4Ho+6v6stJu58r?=
 =?us-ascii?Q?5ylroX816/WI/Nd13t9Wg8oSdzQXC6rWeB1ymleymhnnoGQTPXMdHkrpXvcy?=
 =?us-ascii?Q?4LhIX+gmPcJZPec/I6CoYNPMgsccUxvoLpvFHys8tzLIPCSqfuyL9nJ+VXA4?=
 =?us-ascii?Q?0LMF7QJpygJP00PcZ8d34G8z9qIdyaZZhWRWA2UefLjNriswEPRqrboTbe6d?=
 =?us-ascii?Q?lSILFQ7JxtT7s3ioFrNaQSE9Q6X5iaL9Zz5H/LYAuMRyPEWeIB+LbqMEJebJ?=
 =?us-ascii?Q?Y63iAUH0dk1NO71nHbekn9jc4DgXWuZ9b2aeC6U0g7uhsUBr9/iIhWgHiAvK?=
 =?us-ascii?Q?w6otRKcp/A7irhFB1pz+hPX3jLquXnIDHoK2vBt2RrFVGwTUriVXaTcukF65?=
 =?us-ascii?Q?VKfFZltiB4oyRq4CqBuqHHF2/Vgsus4T8pHQ+wbmpThKIoX6AV1k3JUomI3Z?=
 =?us-ascii?Q?nbVloWAG0g/Vsw91xNXyx9a9aCHUBaVQboPRCXkDAaQQDT+gcgF4nvCGsBis?=
 =?us-ascii?Q?lKjhWjjH5JXDcz9gACR6nETucXnZl0kfgcwV03kyVFCbqCgq7XyOoFtj1Etd?=
 =?us-ascii?Q?ondcRpGGgs1YLl5n8wWRTuMmWYhq1d6NyB4cfh3x6+4WLrZTV4C/XiA8l+lW?=
 =?us-ascii?Q?a+6ddj5gYdLEEeK9WFYqQAgNgkcVnlIL6eXwUrvEZOLzU5YgzOjOdgyscv+V?=
 =?us-ascii?Q?RouIA0VvgIEyYnCYtegUQZ4uo4dAoS7qAPLCMwWahgJVgKg08qpJwc84hzGg?=
 =?us-ascii?Q?2a9eC0KBPs+Xy3FQZta+b3IK3HmiJGcQBhH6MGghOJWvSZLL53hhwSoeYJSQ?=
 =?us-ascii?Q?SYNdKwx1dC9qMlmq5kwgH29lx86OZGrRamLlJ3ZA/Ds7nfnUBaY5Umo2NWTr?=
 =?us-ascii?Q?B9vnhjwqoyUg0lpjrrftc2XOm0f3Vys6V0MN0AKe257xZ1CTSB6AoGyqhxFv?=
 =?us-ascii?Q?EavGju7oeb7WXMuT81mw9tkXOMVBppo9C8FY7kUJtihS7Dhbtd8oYc2MeGqF?=
 =?us-ascii?Q?nHMr7V7XODONQHm49+ZaZ7IOtVqFs49aSuATl6zuf16WJxGTizo58gDg4h0E?=
 =?us-ascii?Q?yp0Vu766sBqggaTqWQI6wUTNI/xjzdSmyMnh5hkgn07FACYmeA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:02.1599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f66f8fa-0637-474b-ac90-08dc8673e04e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426
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

From: "JinZe.Xu" <jinze.xu@amd.com>

[Why&How]
Add flag to disable IPS when it is not allowed.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: JinZe.Xu <jinze.xu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h          | 1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1008cab97c76..c97d9b9d5c17 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -924,6 +924,7 @@ struct dc_debug_options {
 	bool disable_z9_mpc;
 	unsigned int force_fclk_khz;
 	bool enable_tri_buf;
+	bool ips_disallow_entry;
 	bool dmub_offload_enabled;
 	bool dmcub_emulation;
 	bool disable_idle_power_optimizations;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 12687d400092..3e4abfa6d517 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1506,6 +1506,8 @@ void dc_dmub_srv_apply_idle_power_optimizations(const struct dc *dc, bool allow_
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
 		return;
 
+	allow_idle &= (!dc->debug.ips_disallow_entry);
+
 	if (dc_dmub_srv->idle_allowed == allow_idle)
 		return;
 
-- 
2.34.1

