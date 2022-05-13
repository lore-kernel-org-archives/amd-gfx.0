Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2633AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 21:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA8110E548;
	Fri, 13 May 2022 21:17:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188E810E548
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 21:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwoGP5vOOv+r1MJuQOi6Ohlwb87ppOXJ6OvMnjLeuTgu4PUWj3gUFSb3qANdp2GHKZHB5CxJRhkSV0EsO/+Yp+HkUQjoqD3HKnCbhwTMgLyzO2r3ARJGn5l/ddyqfd/KTs3VNiPMFSCXURdyuGSMoRyFn7T7MQXqLqa3IZ1CnTtXfFPbtff9WIknpmDnO0HkOdLRdc9EXfBK4pHjrOjpOSGbkAZrno8X59Ucu5xV6zSIeazglUzGnji+d7EYQSqNibAvrRUc9B7svHlxklONawjY9CLRYbFeXz9RfzGcmtv8WydegQxXmcMUqoK9D3M+iaPkWNfJtqlt5DqKyLs4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWCxgivtBajgjAWyXzTRGFNlmQxkyLFWKQZBX/5raXo=;
 b=jr4VKmRtfyAHnXlaQZp/+SDQEewPuZGRvGJ/6sau6bKV0oPRZHUMUDIi0pvwpykWjPpBlohujYxqP9hL9YwFH6+1MI2JwoSku8jwTMuhZvedIizwKYz2JG2KogxOvvPBgrVOX9Ioc1wkyybTmnKvgDWN2QgRfKDhijH3J1TPh1jkcmOcVSz3QKrP7omTl8q1wVyNmopwwLMI3/y1k6qrdyabCA9r0DGU5NnW4P2B6I5cBU0TjfB+BsketNOyI9EQ3Zc/XAUid6nxJUAbCjZdR8pSA+4ZNkBOYyYMiDJz6CaY4/THKXB8a117Ct4wwPbW7wFKI/TDuDWDga7NJokJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWCxgivtBajgjAWyXzTRGFNlmQxkyLFWKQZBX/5raXo=;
 b=gXF3KVoke7S/PaVJUkPotxGGDBsD1ioxS29lIg5UBcMNGSK9nmg05R8rP7AAVAK/qfY00xG/MFGtC/j/o4dFGq4Joosr4ZU1rwxbFbF5UkgDnK34YUc6MjagUjcCEaJGlNiRoR8jmcI4GCFBT/UY0ab5Ge03T7t8gFEWYPhLMak=
Received: from MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::12)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 21:17:24 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::6f) by MW4P221CA0007.outlook.office365.com
 (2603:10b6:303:8b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 21:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 21:17:23 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 16:17:22 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 06/11] drm/amd/display: Allow individual control of eDP
 hotplug support
Date: Fri, 13 May 2022 17:16:46 -0400
Message-ID: <20220513211651.1312846-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
References: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcfdacf0-3bea-4dcb-f0aa-08da3525f97e
X-MS-TrafficTypeDiagnostic: CY5PR12MB6348:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB63484BA42692710AB91E696DFBCA9@CY5PR12MB6348.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YSgOUZnn2JkBg/7zBEafRkGSfqPHZI+h8s8bP6SphkWdg3/nvdLllUBcserQMNgnalH6MJ0ezF7fLx1exnnCxrCavt5iT3Y/cwMAgYK0quQQ9zJHcKD3Oczom3K886r80j1l95hrraCbq4rJSdpcxkljReJ/RA/RQQ0DBcT6bTNoqGeDest3LTgkWxUfMdafMs0P0lNwD0Qqk49tvIhpVn0m/sOvPVX9aVK9ZfEzbSryKNYwBalOeKNYSfnnxd5yp64/O0mVdGl8VuHmYa9QdYEkhxzCQ2DmFiKK0KOXByYPlaQX1xIOmQJM8IqUascOMQAXaXl/q3NXPQy6mSmsvFORSL33U+kkBS7fwa8DTWS9bib4Y2CWYNzUs66Jy5zjgEbKk+UweYMP1OzM7RA5zcs1xPYsQiaRvTt2I4mrgTi/3kl5Ovo3joIiBYj/TNepXTmxPRT1Srba1DZhcfliyDDVt3e6FDI7KQyxfWXX8siCqIvGYo9sbss6nOyWft5IXdlHkmS26KwqJHHyavqZFdowj9OqMO3w88kE3rqpbbixmecW+U4JyjWerLBUbuhTr5JeWxd6RzycvXpF5MNPIlpzUJFyfP5ebWh9dmXouM28DxOqKfN8LNwF0ipQY2iisAI6cMtgQGWNdmNNalTXPQmf+Gp/Iv0idWu8nw2N98NGqkv2lYBpPGK8ohcOXzoDo8NMtyu9SxV5a92Oj5D0HQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(54906003)(26005)(82310400005)(6916009)(4326008)(8936002)(6666004)(8676002)(70586007)(1076003)(70206006)(40460700003)(508600001)(36756003)(86362001)(36860700001)(2616005)(2906002)(356005)(426003)(5660300002)(336012)(16526019)(44832011)(186003)(47076005)(316002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:17:23.9754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfdacf0-3bea-4dcb-f0aa-08da3525f97e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Derek Lai <Derek.Lai@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Derek Lai <Derek.Lai@amd.com>

[Why]
Second eDP can send display off notification through HPD
but DC isn't hooked up to handle. Some primary eDP panels
will toggle on/off incorrectly if it's enabled generically.

[How]
Extend the debug option to allow individually enabling hotplug
either the first eDP or the second eDP in a dual eDP system.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Derek Lai <Derek.Lai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 21 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b40abd2bf7f6..a789ea8af27f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1605,8 +1605,25 @@ static bool dc_link_construct_legacy(struct dc_link *link,
 		if (link->hpd_gpio) {
 			if (!link->dc->config.allow_edp_hotplug_detection)
 				link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
-			link->irq_source_hpd_rx =
-					dal_irq_get_rx_source(link->hpd_gpio);
+
+			switch (link->dc->config.allow_edp_hotplug_detection) {
+			case 1: // only the 1st eDP handles hotplug
+				if (link->link_index == 0)
+					link->irq_source_hpd_rx =
+						dal_irq_get_rx_source(link->hpd_gpio);
+				else
+					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
+				break;
+			case 2: // only the 2nd eDP handles hotplug
+				if (link->link_index == 1)
+					link->irq_source_hpd_rx =
+						dal_irq_get_rx_source(link->hpd_gpio);
+				else
+					link->irq_source_hpd = DC_IRQ_SOURCE_INVALID;
+				break;
+			default:
+				break;
+			}
 		}
 
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 26c24db8f1da..7cfc04a8ef15 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -329,7 +329,7 @@ struct dc_config {
 	bool disable_dmcu;
 	bool enable_4to1MPC;
 	bool enable_windowed_mpo_odm;
-	bool allow_edp_hotplug_detection;
+	uint32_t allow_edp_hotplug_detection;
 	bool clamp_min_dcfclk;
 	uint64_t vblank_alignment_dto_params;
 	uint8_t  vblank_alignment_max_frame_time_diff;
-- 
2.25.1

