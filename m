Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0889C3ABD7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 11:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5DE10E4FA;
	Tue, 13 May 2025 11:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XH2yICNd";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C723410E4DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 11:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXyYgIUA5EXkW5MbxbyDXXvC+dJtYItXfhawC16bW72WzZvNT9Sw8SR2bN4b1OqI6RidEGFQ9cm/6ivsRzwI03E172DFP5FxWUpRf8soZoNm23R5Dv/9PaYSCsP80Cu1X05j6WuSvRp88gwEhaitdN+ppwlESPg/H7V8HY4ZF7MK5xsque3azpU8Yc1tkkxG4gtzIDIp1ZSNDKXPrgfL49bkBCt4xrYmNneRLSSUe14hj5mYRyjaBdRh400QQO82OsvuTxFTw7TCnuyPty96ydb/ONo/PH6DUcxHeayXnPfc6JIZNO3QhxY3Qw2s11WMhg8B98yG0vMUi95mzga1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc4+jcfVaBPU1dFtoHZx9DOIafuJVYEM+pWXhOa4oMc=;
 b=OtiZ8VJMWp3PYXY3XWN9r1C/jfJ7RR09gmZObzWG1kUDnOCDvBP1ltAfvYOesTtdlblqGBoh7Nq3qPNrRma/SH6dMbLptM5GYu0fOqvV9wUki+0WeHEZNVi4Ue8Gs9ftuQjXYPZrZLZW8oj02rV1N6wK6ZQxJheduT/ySO7Y1xBorGmBPMg6/oxT9U3RFe1h0bc2/1Vuxq7xsY/ot++iWPhZcFBtwAJzgvThBps3GxoYGqEE1DSd/hjkm2R2fBHhQRJGflR5LexzNOH4uBccYTjGnMScKPv/kc+YpJbJQjh8QMdIV1T1I4XWM8nCK7MrBb2DrelzHrOQqmbhTil4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc4+jcfVaBPU1dFtoHZx9DOIafuJVYEM+pWXhOa4oMc=;
 b=XH2yICNde8RdGBkVUHr0lUdx4I533km3MBylTlMT4gI4I8wQvB89z4Gj9HV3roMz/mTc+RfkF+mi2isy777P6a/QFJjX0Cz/CC2TOLWyhQFGJZO/hVLRZUObBaAdcax9FX8+WFEqYL3OogklwxJw/zJVXSRoAgVJBG3ettYcW3U=
Received: from SJ0PR13CA0235.namprd13.prod.outlook.com (2603:10b6:a03:2c1::30)
 by MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 11:25:14 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::94) by SJ0PR13CA0235.outlook.office365.com
 (2603:10b6:a03:2c1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.13 via Frontend Transport; Tue,
 13 May 2025 11:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 11:25:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 06:25:11 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 13 May 2025 06:25:09 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Nevenko Stupar
 <Nevenko.Stupar@amd.com>
Subject: [PATCH 06/11] drm/amd/display: Fix the typo in dcn401 Hubp block
Date: Tue, 13 May 2025 19:24:34 +0800
Message-ID: <20250513112439.2295366-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
References: <20250513112439.2295366-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: b20c9b88-4bc8-49c0-2a60-08dd9210d499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kamq+TWziU/VpmbH91wpxx30fEUrmcHiqUpvzfxvuVfxIFFRo4TlFdjxrhqC?=
 =?us-ascii?Q?f8VADV2g5XF9zrVIrk49bw6U7UX54CxT1k+Rt5K3egtmQpe5dVxHo4PCj6kK?=
 =?us-ascii?Q?zKoonKK3eqVJcs3XYrhbeBRGDECwqVe8WjylamiLoL2URfzVnxnrnHDujBbR?=
 =?us-ascii?Q?W16uK/+IjaP2rHDY8p29GS2jUtxlNo4msLd814nlvDIzT7/RzxpFxNCQxYDk?=
 =?us-ascii?Q?yS6qw7TFub3pi5N6n0lh4FYuCzMQQ+RCTGVbJfCvnMdegUd1KLnO/LQhpgkw?=
 =?us-ascii?Q?xeLU/sdzB492fA2tBxGGFBRy3cGWabHcPAGctmW6V/1JvDzLox2YVyqeNEgt?=
 =?us-ascii?Q?aFUh9dcC+vmKRZDSWEYD915OcOBZYdfAyX2Zhhb+9+vhzG7q8ohdQ3XSEVeG?=
 =?us-ascii?Q?tBhQSQyGPAiLr78xg8hovh+E8VYoiMy1EXotWMbl7QrWOVq4vnlwZNChVBNF?=
 =?us-ascii?Q?fFs8yrZMPAKPzwj5ihRZJkiFj5srQzuEGU5uE6M/jeofRSS3dbvxt6C/Pns7?=
 =?us-ascii?Q?alR7ruAxJWHFaBlmoDhrgKANxC+PGZwPAL7yQ0dknOgw1AVYlWzINamnRGeY?=
 =?us-ascii?Q?GgXz9pY1Ugjdon1shQxWR9gwJFC9FTkj6ZguCq2Y7ucB7xlJGlduZxQgpYWA?=
 =?us-ascii?Q?FAB6x/iO+9J16Inxs19hqiZBOHvZ7PUC8oc+8PWQqgh8Wvyr83PkCMNV5UCA?=
 =?us-ascii?Q?SIFiVu6T0yAjiG1aW0TShmf4UpEf0c6hUWeb8AvGiMWQiTj8nK6J6Gx0BirD?=
 =?us-ascii?Q?AwEyeTocoo6LzqNNpOgBK8l6nceGN675xMOdWuV2ICWgesz6evPya4th/t1H?=
 =?us-ascii?Q?prX9HwltnRulB/oR383880P7rXAdkaQ6UhLrhGxkzrFjypqGeljcVfdJ8K+m?=
 =?us-ascii?Q?UZBSSzc2EPPuDGVXUnuIq+NSW7seciGVHcwuBQI/7W92hmg6zcjuwTafQS7i?=
 =?us-ascii?Q?yb86HSC5qn/eRyHGSJmJbgFp0Z9NLM9aCh6Ifx4LVy6QuP1rojh+i3buB2rh?=
 =?us-ascii?Q?5/MQceOJbUxERssQ78NI20KX5QFlbq720K0uRVrNNm+0g6fKIQRMdjl9i5ju?=
 =?us-ascii?Q?mOJXbldXeSPEJYdK++si5RDnDCMx3WeeYvJfff9PO7gW3JJt6sk6uF8c571E?=
 =?us-ascii?Q?9dnR6RRbR2F8PqxkuWYG/tC94pAF1dEJdIs9vLcvQCveIs+FQG1moxt8YBmO?=
 =?us-ascii?Q?eVeyqzYUQm/zzvpZcaN++Ga1lOJv6z2YgodhN+OlTIl9X4AhNvl/DZ1TcWtA?=
 =?us-ascii?Q?A7JP9rU5qokS7WR74glTPwLUlv4KZBbzgLK0MYmj/mwn9qQ6T+jPrDygpWlD?=
 =?us-ascii?Q?IyAMdHnF3RQZG5QJgAkmjEtpp4aADZe03hCUBfG3HV4ghaqKo29If0pjwu7s?=
 =?us-ascii?Q?oVILTQ53DxR/P5NcEA2sxn/Gd+Ln9L1dWMs5VOZtnNkAxThVZO5rndlo/uqa?=
 =?us-ascii?Q?370L8E0ZkQh2Q0DYApdH22DnXAqOCXfWbRCe3wHqUghmpn5/Lv4kXIoqNfuc?=
 =?us-ascii?Q?D9arl357mMtL/Pf2k2tcgb27Xh0hje3pFlJh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 11:25:13.9211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20c9b88-4bc8-49c0-2a60-08dd9210d499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190
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

From: Nevenko Stupar <Nevenko.Stupar@amd.com>

[Why & How]
Fix the typo for hubp_clear_tiling, currently calls hubp2_clear_tiling
for dcn401 instead of intended hubp401_clear_tiling.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 5ed195377a6c..baed31611477 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -1032,7 +1032,7 @@ static struct hubp_funcs dcn401_hubp_funcs = {
 	.hubp_program_3dlut_fl_tmz_protected = hubp401_program_3dlut_fl_tmz_protected,
 	.hubp_program_3dlut_fl_crossbar = hubp401_program_3dlut_fl_crossbar,
 	.hubp_get_3dlut_fl_done = hubp401_get_3dlut_fl_done,
-	.hubp_clear_tiling = hubp2_clear_tiling,
+	.hubp_clear_tiling = hubp401_clear_tiling,
 };
 
 bool hubp401_construct(
-- 
2.34.1

