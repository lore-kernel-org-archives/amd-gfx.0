Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA921CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5D010E037;
	Wed, 18 Oct 2023 17:42:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B0ED10E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP58WTCH+lVcGh9uyipuPk0k5WmAq3UKIH0mLUMJKpLPGC5v7lXiIZEiXI0MKcOnZ9qVuz36kykBokqMicCm5lla4EiK68LxldOAxdOxoh4/NAuRPtMyT3XL6AcR1808599N18rmPRxNk6G8m0pgJH/Ou+VlkAHmJCYeyLCFTL+TuY+y6U39KxXBoXTKSMXgww8l4HLz9BL6tj9XRYn4oeapPRX/B8vzdfSiGjPZcJkD8+6NKzLhlJd0mWFT/Mf0LZP+VucnGhMLJPsIJAKA7XupU6y9r5F7Ks7dOOUji38vcqktGVXPWiLM2b4YDevOGKkKR160JBuUaNOSk3vjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTxUc9ftsO9KePBFajZhryoSYZA1Dt/jhxNb62vnLV0=;
 b=T5IvvjHVcfPNNwR9lDDONg3JOHiqLeMaQcN8mXj5U8HLiTYRbddStddEGwYV4Nid94AmA5pCIGyiq1uz5hQEk5m0pU58QBoCIAIpy9ALqlb+F7MkhNsOHAUo8KHc9y2zS0jSsAR9X3sGU9eQXFCeifDzdRdBFQOLdou7d546h4XFnhtXQaA8NOBuGJiWYn+zk3Lg9zUdYi6ESTqCfR8Fe4JzCHJf7Ju9uZwU7PGmIbTsd9OaOSlj3N0S0FuU8u2TYS++8UwDnC+OEkDcjPLB0YOKXT/Pvat2bnp0Fd9cFWMUkOJTIFBhsanClI48p4BbYaAeTiHii5JWrgagQSml+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTxUc9ftsO9KePBFajZhryoSYZA1Dt/jhxNb62vnLV0=;
 b=ULf+jLN6wysEhbDDzix7AMcEhJUSbjT5PWTujHAqfMKBIgElgC03Ej2GZ948jg2goMYmhFJXScvz+09ENpyWdSKG3HpTNMTzToW2Ds5gC1o65t4ZLIlZBmY7p5uwL1gaHCjj8peLxcEptG969q2ZT+bgBwST0/2QalcF5lGrbGU=
Received: from BY5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:1e0::24)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 17:42:34 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::52) by BY5PR03CA0014.outlook.office365.com
 (2603:10b6:a03:1e0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Wed, 18 Oct 2023 17:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:42:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:42:01 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:42:00 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/26] drm/amd/display: Reduce default backlight min from 5
 nits to 1 nits
Date: Wed, 18 Oct 2023 13:41:15 -0400
Message-ID: <20231018174133.1613439-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e98f80-7672-43b7-7b37-08dbd0019c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K91s8YBMAkjMGldF39gtRqt8ar++JK4skV46DQO8fgYIULw2BwucD2AKCdMBlZvK54ksKrdvOOwi9NqhWZRVJwxzVQGkkCJ6nsOaS0L+kpH0w3YwmBkdz5n1tNQnzSsGZpIFOjN6vAxNyFehQidpeoU/5Tu4mqeHQIY9cWH7KdE3kc/RZsjvi1DxDdv0ohfs1cPWqwN+zcpPq+SYNo/YIutf0BHadRSIlkxXBDnkhW17Lvx5zpI9HG22nk5u5Uh6e+3JGCBkDGo8ZV1iz8lH+6Txavk35oDavau8OeJ5sS1Eedv4hNDDQPbRbukUX16f/HgNY08zGeuyX1f2YFvAiKzmtLIKbx5eI5Ffy9xdzzctxiZcW93ndLXFTOTbTavnvB6jzs3E0K+v0br+Km2PAVCecbJzKCiQMeJtWFGnsLfzRlcDuLq4tA7BFPoKtKHVTwLDh3rSxVLKFk+A0rjGqHOib8BIIj4cq3efC4FQ9yCRidGZnD6LajBFuOmIj7nOWh8vMUdA8aP1S1l/TgdQHo78PFmTyR95KU11k/Fd7TYyxnvb/etVsH0PtCbiaXunAjW+nkXSXLtTN+++tKOrpu567cu+btwllLvJsIZqBAtbudb/7E/229OAY9LGBaFgAak6Of4BDw/6xj+KdPmA6dvVpoTMSDDD4lQ1xk157Yg71JonTKHZ+/OYIrCB8V+AAGlTZcZoYkpvQ/EBR4HS3YnvVoapYzwV1cQZG0sNAR1DLCpMoDAwrk+W978tB3R34SU/Jf8WrW9h0VrkdFFPmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(54906003)(426003)(26005)(356005)(82740400003)(478600001)(336012)(7696005)(1076003)(81166007)(2616005)(6666004)(316002)(70586007)(6916009)(70206006)(47076005)(36860700001)(83380400001)(8936002)(4326008)(8676002)(2906002)(5660300002)(41300700001)(40460700003)(40480700001)(36756003)(2876002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:42:34.0206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e98f80-7672-43b7-7b37-08dbd0019c76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com,
 Swapnil Patel <swapnil.patel@amd.com>, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Swapnil Patel <swapnil.patel@amd.com>

[Why & How]
Currently set_default_brightness_aux function uses 5 nits as lower limit
to check for valid default_backlight setting. However some newer panels
can support even lower default settings

Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Swapnil Patel <swapnil.patel@amd.com>
---
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 938df1f0f7da..86f97ddcc595 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -283,8 +283,8 @@ bool set_default_brightness_aux(struct dc_link *link)
 	if (link && link->dpcd_sink_ext_caps.bits.oled == 1) {
 		if (!read_default_bl_aux(link, &default_backlight))
 			default_backlight = 150000;
-		// if < 5 nits or > 5000, it might be wrong readback
-		if (default_backlight < 5000 || default_backlight > 5000000)
+		// if < 1 nits or > 5000, it might be wrong readback
+		if (default_backlight < 1000 || default_backlight > 5000000)
 			default_backlight = 150000; //
 
 		return edp_set_backlight_level_nits(link, true,
-- 
2.34.1

