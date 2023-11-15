Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCADFC5AD4C
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2A810E1D8;
	Wed, 15 Nov 2023 19:44:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6656B10E1D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqtM0DUXQ1LmGikVvQ8XOdUOIVOfleAqXm0F1uAA94tEoNXnVxnIhXW/IRm3meSwcOiyZ5diLpqn5xvRc/BFl3w6gyWmyurfuoVisAR6XrwEx8DO63x9Rw19mGdhfeO6hJRsk5jLoZlfXDKOq75Vma5J8OEgDJa8ODwW+NfGmxzX0U3vKDwGrSSAg4WjWSUbytDmqsM9SHNvoQxcQxKqaSoq+MeI+1SUJoO6DfebGrzahSghnufNl2+a1Shjo6dsNNswppqFD/BOHO+PetNLUyT5SJzMNsQEufvauc6dHj+3bxIxMcWvBCdGsGPWsYnE5BSFdpeRXS6bmO+4XhJwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsk8pfJK16YYrG7j+5X4E6JxXKYEArfwCJJWd58M3PI=;
 b=jZArcPPcdYjMkaH3u3lVJTgORjyP2Ilrwpqo4oibjLKl8dXwCa+tUT4dA2sH27m71zxFjrvicyDsamxZBrsPDu+cJh6RiZaAOyuzibI9QSxlG/Jl6xzqZoUsE3tWs5Tbos/cYaZwMFnuQX1862WHVNj27Cnj2mkaYLT2UL9nfV1yl1NP9+LlhR5mizVMUtjfowzeuqAop4iBaZjTlx76voOButSUmpJ+mgW29L8E0soraJ8/V4046J1mC29aXG+oQcWS+QliOSF2oI7XZ6MNGMrSmSOsnN/mPhG7DJooVtAOeclkhUrJGV5RH9e3NBc9R7ZngmKbbjtQc3nXS1s9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsk8pfJK16YYrG7j+5X4E6JxXKYEArfwCJJWd58M3PI=;
 b=LNJv/imDjFSijGI9ZF2hJR6vDfTAYuU7W0bbcPSBI18eJuADHJgI/NX7LAWy+ddQ9PTYhb2Ajrs9ovUOA7O93xBTY3nV86bX6wbC+he5GH9ZVeuGAYdUWRJaKxngQTP2TjC4y1ccz+iUDaMhv0BN/AWfBHIoqnwMqplwEPQbmic=
Received: from BL0PR1501CA0030.namprd15.prod.outlook.com
 (2603:10b6:207:17::43) by LV8PR12MB9133.namprd12.prod.outlook.com
 (2603:10b6:408:188::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 19:44:13 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::50) by BL0PR1501CA0030.outlook.office365.com
 (2603:10b6:207:17::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 19:44:13 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:11 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/35] drm/amd/display: add skip_implict_edp_power_control
 flag for dce110
Date: Wed, 15 Nov 2023 14:40:17 -0500
Message-ID: <20231115194332.39469-5-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: 6663bfb4-7643-4daf-8aa9-08dbe6133ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/FwfjST1tcMjJC3YkXrpnjb+6gFKhWemFVznW1X2D821MOOt6sm/RiYT++is6ZiAqmcMlbDVYHTYBQi8wp1jqK0mdJDzH4D4qeqoXEPILqhaBaoRlGoSPJ5JHgOHVwQJkNqcSUi7R0wp0kSYC1WfDAgbmF9VEORR8BuawHCw7GvW9yOn2dqSGNTIP3SYPuX5dUS8jdNmbZZZA6efss3QT3XwR5WtoKky1zgZkQKo1H3uZJsXfntuAocb9ToHQJRnqXAjR2bLt7TMNuIy8k7V/fTo9fAM59ZlD8/SnUvsPjmZ0T+uVNT4G3EMRaR2y04VrIUybHKut0vQ+rARDlqnpiliDqTm1U46ikr3mQaxIdCAEQ4BcbE/I98/SRIeTYF647NeWSP3i3KdiNrN7BtJizMstHY84drsLLmZvM0MYngNn01teYxcpiKQztJULIJY9n8iJsSe5Gb/E6F0XrLC1LlLmqFqd9d/jO+Poo3B6XjCuILRy5/LLnsq6i9TVQWb6OH8pLahhPDAkr9jHMwev0kBKVt+wiVB54Ng7E0FuzCkjsZNv+3V2y8+wYrsRHVN0c9X6gO+LiF2Y0tvEhzLqLkdNdtUDZRE7FDVn8XkVpSfJeJ715tooIB0D52KqRxBe6avOVt71cZkjfGPGSH7NyqmEg/7Ae/PYWd3tX+ZVq+TxJoOIfR+2cjqEkST6TiTluYjGhejfDcU+hqbBbiYcIZ5aFY0myNCzSQGhDo9goYSUBCxlJJEIeMt9DvqhJL487oJNHUx7+q916Heni2vo7h6ysiySqNC5hawtyut3si7WJNz0pdz3Fh7kw/7mg8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(81166007)(426003)(36756003)(336012)(36860700001)(356005)(83380400001)(41300700001)(47076005)(40460700003)(8676002)(86362001)(4326008)(1076003)(40480700001)(8936002)(5660300002)(2616005)(316002)(44832011)(6916009)(82740400003)(26005)(16526019)(2906002)(70206006)(478600001)(54906003)(70586007)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:13.2195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6663bfb4-7643-4daf-8aa9-08dbe6133ea2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
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
Cc: stylon.wang@amd.com, Ian
 Chen <ian.chen@amd.com>, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Robin Chen <robin.chen@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ian Chen <ian.chen@amd.com>

If the link requests to skip implicit eDP power control, we should honor
that request.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ian Chen <ian.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 51e42cbb3cdb..706a65a11124 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3114,7 +3114,8 @@ void dce110_disable_link_output(struct dc_link *link,
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 
 	if (signal == SIGNAL_TYPE_EDP &&
-			link->dc->hwss.edp_backlight_control)
+			link->dc->hwss.edp_backlight_control &&
+			!link->skip_implict_edp_power_control)
 		link->dc->hwss.edp_backlight_control(link, false);
 	else if (dmcu != NULL && dmcu->funcs->lock_phy)
 		dmcu->funcs->lock_phy(dmcu);
-- 
2.42.0

