Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B547CD128A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 21:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C3010FA91;
	Wed, 10 Apr 2024 21:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CHhHWmlO";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB79F10EA5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 21:28:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afj5U1Q6eV08pbAvdFZVA0MN0OMPd07Qr/+K906qUKkZWrAkUVAQVu6GExS9igb1DaWQ/uQGUOi4JBWjcZHR3y4QrIhmHU5gFmwCvdEXxfGP3CwtRKcZ5Pp2KqM7D31+k9aVt3MzVsS5jdM4cKTGyoT7Q4j3cjJSe0UlqkQCIrK57cIY7+bjBOA972g14IeBJn3q271t0u8SfpwKz4YaK3QkQn45fZMHrvllnb44C4iGZGFn6HKzOEZshT3cPTqY5Amfb+SObkFINvB4aGk0oWmxYCNXN0lbGtEmxyatQXz9veJUeNlxN1OwnVqI1IpgI8ZVDBJXkY1GmR/0mxxO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33HGepZpx97lQZTiD4zwRr4EK/O+1ydN9f+tld49Ldc=;
 b=mrHqFa/zZezZp9ZX+GpM9PWa/RjUPMOQAE5pkdgJNVg7fRkT987kVGlWydfaAoCgEJ2iuhV09eJkY+tf2f+YvtqGJPqGQMYv0Ev6+GfzkfXfcDAdl+ATuc7KJEBSbcTp6tKGOfvDQ9e6qbPITqiPL4N5h/s38y8dUPaWOA9/oxNQWB99+5xYT7YHA3yKPEv4EfHXwpxUdkZhPdPQJiEJZ+DXxsZzA1ngiBu8xpH1ZjuhniJgDN6TjCYKNWlFskCqNCvBn4xZUxksybRsVllpUQyFivNQbbgt9Mt9I6xPxANyG3vpqLfkKXqFMCEX487n9ofhlw6rUf323Sz4BcUuOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33HGepZpx97lQZTiD4zwRr4EK/O+1ydN9f+tld49Ldc=;
 b=CHhHWmlORWradRqc02Q2ZYMZCIMn0uIzD5MPneeMDGSRItSexUpWMyh+uaKwlCSsApsvrqu+m6N7Xtrx/5lqOAQd2lhJVgk6YuZ9ZXsQMc/QaxnagWtQtx6C1c/ztzPi/6XrLKqeiUX0vdSvDlnwyQOvj3A0boE7E0rZJ1aCS3s=
Received: from BN9PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:fb::24)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 21:28:13 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::ac) by BN9PR03CA0049.outlook.office365.com
 (2603:10b6:408:fb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 21:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 21:28:12 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 16:28:10 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, "Bitnun, Ethan"
 <Ethan.Bitnun@amd.com>, Ethan Bitnun <etbitnun@amd.com>
Subject: [PATCH 13/25] drm/amd/display: Improve the log precision
Date: Wed, 10 Apr 2024 15:26:02 -0600
Message-ID: <20240410212726.1312989-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
References: <20240410212726.1312989-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: a27bd54e-c0c5-4fd2-5e06-08dc59a52062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tnjCt1zz5NcSxGG5L5/7Gb/3vE7fxJcGVa5063b6ndhImW6BB2wPg56SaSbjdd2kp9y6dL56d/uOv7UsDikTMb1NohWQH6bscf9RSnpFFYAcaaQ2stlX4LDwD8fYjl1791VdZyVahvSNlhzJY8IEZhYkpBQ5thdMnFp9RgAESIdtF43GehV7lL24Dh7gN0nOp5wiH5wTXwd1s01nmjRKxiQbSYvL7HwlwIfxXxZ21Zg/KqAL4hi8cZp3hCVwd1zRcUsD5dp9WB/os0zi1GbJh1l+DcWnn24hZnElLNoaYoNsRCNgRxdPo4ZT/iAGoToCykcxp9znDkYF/8Pc2QYKotf7Uwz+kt+tLHgqcnKARWIO9apStTrz8vJw6Gghq5qczMyCzLD6jNy8/9omgqky87FW9Ci8B93RQrEm5N133/KPAPVgCK5L1icYMiXc61STuenpS+9C6S2prpliJB4V7V3Nd3bfTYlmHu/BhgRUPrikOmiiJghEu1p6595IeYMDx7bCEUTdz/NbK8CbFQf9gbkOSYXvJm7V99UPiK99DBk8tKVenHcg3vAi1CnDatt6jMtZ1xqyTLNsg3ziFDHNvr62h7tSmlJTN0hje22cWXEK6x3D7avePYNaEiqsnaeR6K4n6EnUp6mQmynFunUq8x8LpfAxz0w+LO3mMtAFUjcs6GTV2UL+ikvLAgamD0fHxo/v3/cXFleIufwElZ+4Dyc0H5Lk64YhE0nXwRCMT1hEUKxi1PgSn7hHT9ddvKn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:28:12.5998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27bd54e-c0c5-4fd2-5e06-08dc59a52062
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

From: "Bitnun, Ethan" <Ethan.Bitnun@amd.com>

The previous assumption that there will be an optimize_bandwidth call
following every prepare_bandwidth call was incorrect and caused small
inaccuracies in logging, as some info was only updated in later prepare
calls.

Signed-off-by: Ethan Bitnun <etbitnun@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 358a83b1114b..7eecb3403f74 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -830,7 +830,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		dmcu->funcs->set_psr_wait_loop(dmcu,
 				clk_mgr_base->clks.dispclk_khz / 1000 / 7);
 
-	if (dc->config.enable_auto_dpm_test_logs && safe_to_lower) {
+	if (dc->config.enable_auto_dpm_test_logs) {
 	    dcn32_auto_dpm_test_log(new_clocks, clk_mgr, context);
 	}
 }
-- 
2.43.0

