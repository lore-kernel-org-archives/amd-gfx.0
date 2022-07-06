Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6171DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 15:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D641110E217;
	Wed,  6 Jul 2022 15:25:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD55D10E217
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 15:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKtt7xUN/eT/CbJL1PbxrcabryfQuAbfbH5p/TQP3i2TdGGdkaHwRtIicIhMkl/+TWwcGyrN34hfw5U+iYA23e3Rwybjbs2/XqaJdAD4NWEDd/PRvw4f4GAPlaiv046NA2ZMaRvGfbnVb8djmZi5zJApZoggqgfn/A3Hk+qkoI5Oh/6JRyDmtkDES8VfPhgJJ9CVXXwYR80hjkxiI64dnl5Hej/uxs6/nLiaM2eZAHjFmwCFKbiFsM1BBMMg2+4wuGC2rj1ZYb8epHVyJIU/FGkAJ53NlpRwuJ7vvlOxtIbQIoASF85g9pCVidoB6udKM0b2BPAb7s30lhY9dcQdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhjAyL7/X3UXypQN+fTKG7Uc/KVQiqUKosyeVgTjFe0=;
 b=SJykqlAAMV65E+iKg50VUd0YvbR/qvOadmhCGrSJ/JXTgO2iZTbWAmeHW6aKOnpfadhucGQMlhTIXVhffz7K7Gf/OdgOjGcguLp/VJRRll4p3D1nn80tTr9CaPXsEEjK1REQFuRVLqH94YidV+3FMN7+af5lhod+qXl/aIfhj/u0XstVt9PfSlfe1k2dmVsI0hdWcwAyUtLsA+sYhZJh66yMPv4tZ8cFoh/GIaayxrd62doGK2Fk2Bhshid5yDn5qQ8gCkpq1knClBKn0QHANwfgIM0RYSjdFTFqwvntNJuXPKMl4greABMXXC/uX9bbUV5aF1HVow77dU150AsgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhjAyL7/X3UXypQN+fTKG7Uc/KVQiqUKosyeVgTjFe0=;
 b=EPozF5iI56ze6yAGHNvSkplGKw9boVAh7+XjNmXuyChGgM2Ra8odiqnJ/h8tWg2Ymk4/K5R22nt9sIsEdRtD02SpAL9lDrvtanxRvuCm/S+PyEq7XRW6iLaPkdTBpG237g1taQzYMiFU6ge5yW7CZUsEPFzIf0W9Sd2YwTt/VyM=
Received: from BN9PR03CA0806.namprd03.prod.outlook.com (2603:10b6:408:13f::31)
 by MN2PR12MB3086.namprd12.prod.outlook.com (2603:10b6:208:c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 6 Jul
 2022 15:25:08 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::24) by BN9PR03CA0806.outlook.office365.com
 (2603:10b6:408:13f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 6 Jul 2022 15:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 15:25:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 10:25:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 10:25:07 -0500
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Wed, 6 Jul 2022 10:25:07 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: remove stale debug setting
Date: Wed, 6 Jul 2022 11:25:07 -0400
Message-ID: <20220706152507.1075669-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64023b6b-bdea-495c-08d1-08da5f63b5f4
X-MS-TrafficTypeDiagnostic: MN2PR12MB3086:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDXl0x6HbDqRbxaRWcI1zv+xkU+IMQES7RRw0sTVMYXH4Aax4+zegw/B7eGs29liHcEHs35YioH5JEyqf0VlMbKnjfczpaLlmCXKV6EpY0GKGQzE8mSMn5Tdyf+RHG5330tMUVN11yipCvi11MnTQs0QDgTu4mMWgxrNQiUVGeSwhI49DwJSfnwGnznM7M211egqL+sALil87oQFg3cgjJpskLye139hJ4WQorqQ8BnZ2lGyzF7+QMC+Jmd9W1jR3mZnsfABmX/ZOczdYVhNkW8xLuiDGqDphUJGqm7o2vl73GSQCH/SwEC9QY5DAqKe2IX/N6ucqZmT+jqaU+CbtikiYxoKUzN76fX13ZiU102nJf6TL0oT2DmqRrIZjgNyGkPvT8JUGanhsq5tKJ8EaLixvWxqTmVRpmgujMCC8sb0NSFxuq38VJ+Z2rXupz6uNl3IyYHDHqwE6a2yfe+HONGZafXca0yLTkQnVIoOG3/WtWpsbnCAKukCQGXJVInRkPKqBPP08pELp/aBge3Y5qUyFR9l9/LQA1dwo+huwEdv9xYAeoGM/nRH5X0FQmwIuAhM+8Afo2+eD+V/p/Z1HQCyiSYc5YcIIYYVYhd/DfhMzflnDykHRh7mFQ7F0EXUbpGUUljjUEWV2BW3rswpOG+5NZS2LUbcTt9q1NG5jsjQUDfZtWUQ5EGGxVcyyrER5sQ0H2LtNtNdP9p8DJKMIZe0vCPYMqxchFRbsQuJ9wqiRvUEuB+x429jc6V1hZWeNbjQQoyaDZJhwWbn7yrk+jQ6khRxyWEOwTn25j0rV1mitgee5EFiErHnv6lR7NJMm+r/w0iMt8PwQ4MQVC84E+iqss0EoKIaJt/yM5L5wX61242nlIvVyGpXohh3u0S/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(40470700004)(46966006)(2906002)(478600001)(40480700001)(40460700003)(82740400003)(356005)(6916009)(54906003)(316002)(70586007)(4326008)(70206006)(8676002)(81166007)(86362001)(5660300002)(186003)(82310400005)(7696005)(1076003)(26005)(8936002)(2616005)(4744005)(47076005)(41300700001)(36860700001)(336012)(426003)(83380400001)(36756003)(44832011)(34020700004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 15:25:08.4791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64023b6b-bdea-495c-08d1-08da5f63b5f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3086
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
Cc: Rodrigo.Siqueira@amd.com, aurabindo.pillai@amd.com, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
The debug option to disable idle power optimization can be dropped

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index baaeaaff23df..1cc1296aed9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -736,7 +736,6 @@ void dcn32_init_hw(struct dc *dc)
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 
-	dc->debug.disable_idle_power_optimizations = true;
 	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
 		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
 
-- 
2.37.0

