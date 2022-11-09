Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BEDC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4115D10E58D;
	Wed,  9 Nov 2022 06:17:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F400510E58B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlS914auV2Z9EzgI7Lp54wCbmYtyqJPcUFYyKHNE/0587Ey+QwGnmb2trs5gCzPGOxq621yrlHEQW1okZNxfuGkJ4YIYcG+EvvVFEYkqZhAExR6E2XTRCDBYm5sd8Jp9/N8kOwE9UxvmTp5N3XWH1ngBAUjQPB7OWggCt6DY6Q2L7tLI+qakOcl5H0yykJPHNljJyFtxnQuyoVstzbvUF8I41HaAT1IkrvcDw8OHbDftXcEk2jcgd1Trc7Z+/mzf6rbn+5xVvb+C8ttqCBNuwmHu3UldZBHLBUHvsXtjFLxmuEVre+PLmGCeWF8AK+Zx0TNYdRP0bl6G911+BSQYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knro7DqJRQ1c2VTC9oqtfoAOp+YUe3w1ldqhjiQ7vWU=;
 b=hcGCSBBEkSf89+bUTKBYiUA7QMYQ4bL/4uLB67cpH+aigk2fMyTmYcKxgnps44Vi5YGhi0v6JN9k/E/Su3Pug3wdRW3r9oNpF9MHwqI/JS4tySVEFSCHBaIV4qDf33LQWt5NvX3QQ+IYlb7giFPTs8gIKgyTD4cOSIwcm3KRmQyPfYDxmSDVGXU0G7Yoj4+9MGearoDkzQd2fTfUgCk7QTrvOXbJ1P9Fdmw5QYVE3gWFghi4G+svLXABKvUR0DUEgtFjuhNk/KV/dFOY/DKUSkgagQbjsxgrVdy348cud+n+bVp2qLDfKetW7GwpvB+hK7jft8BCPoN8b6nzt4peWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knro7DqJRQ1c2VTC9oqtfoAOp+YUe3w1ldqhjiQ7vWU=;
 b=bxFHJUexdMBk3VB5TgKeNbcPCrOyjbEI98UzL9sPYO9v+X0K6z5XuiqDVAb0VLvqecFFtT+HVPCU4w6c8H8ekUZKrbmX3cLPfW/bVurrAhGp/StAYPnYnjnIidyJsWj/seR7eP02dKLqksNSbCFvQk5jHNjKoE3HLT/EBvMPyvI=
Received: from MW4PR04CA0140.namprd04.prod.outlook.com (2603:10b6:303:84::25)
 by CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:17:50 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::5e) by MW4PR04CA0140.outlook.office365.com
 (2603:10b6:303:84::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:17:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:17:48 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:17:42 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:17:36 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/29] drm/amd/display: Fix prefetch calculations for dcn32
Date: Wed, 9 Nov 2022 14:13:13 +0800
Message-ID: <20221109061319.2870943-24-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|CH0PR12MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0b4003-3004-4dc5-0ff9-08dac21a20c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2fvqPuDe7t0jDUxG15YfCNHphqP7j5Umia4C1oQK2ZZfZGbsTP+q27CjwPi0+jO2bHIPdTXvqjKApEV9q7Kh5bdznqsZ0ekOYL1z18BWIuWKLQiOC9nwoh40DBUiRkTvllpe7zgKrkAnGk0mTCXhFedn+yL3Z6ozmj2Y/+WbxlQ9ieYJm+V0DaiFMU9a9aqH9A6D35+O/xxIg4/ZI84i93AAcjy/f++UOd7XTbIRhBhlNJ6Z+luy/KgdMd4pXiOw//hwxQWp5UrMADnxiPysAnpPCVv6QGPjces6P0KFjuvV+lJ9pH0O2gpDmuhuVN0KplBiPSoDUMJj+RkG1UuyoAzY0KJri1zVDnndt6/tRmLabBukIyzPSOBLvemahqmO7KpWqx3vIksa+JwDalGyLdPqkqP1GiHE9X4s4pqyfxXLOJIViEojJ+8VFWAk5qOPu+2RkV22UN/ht0aF1zq0YTU1MLc98Ixk+//iIUbBJjBTeMVU8qkcjCGLbqC66xZE4RkKGJz5KNY8E4goXMc0BdQkcXLDdUfzaYp/jIUAt238kcvT0ty3Y20ei/LXT2H9MeR7yOFDD8XtGTmAoPoOLjaftzcWggLxccCMLil79wYVyK/niI/Y8mv/4nHFzvtLNKg3z5ZH1pqPY+7UUA0Nuum8mZIYsqkZ2Q8jUX3s0Hi+ppW+daChSKAjV+Nt7OuymLYn1znqFgkxnb0pvr+RNjIgHFJEaUZdp+TAnpr+sXJ1hekC+feieehMfH0XGzN7VG6lbpsub0u8/tYbPUjgVu+OA+SYKTUq/Kr6SK21VSEfBUI9Y5L+R5UA1mD4W1c
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(86362001)(478600001)(6666004)(8676002)(70586007)(2616005)(26005)(4326008)(19627235002)(316002)(6916009)(70206006)(41300700001)(5660300002)(54906003)(40460700003)(186003)(1076003)(36756003)(8936002)(7696005)(336012)(82740400003)(83380400001)(40480700001)(2906002)(426003)(47076005)(82310400005)(81166007)(356005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:17:49.9311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0b4003-3004-4dc5-0ff9-08dac21a20c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[Description]
Prefetch calculation loop was not exiting until utilizing all of vstartup if it
failed once.  Locals need to be reset on each iteration of the loop.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 7aaf67b464e0..e5c8f6a71b5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -718,6 +718,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 
 	do {
 		MaxTotalRDBandwidth = 0;
+		DestinationLineTimesForPrefetchLessThan2 = false;
+		VRatioPrefetchMoreThanMax = false;
 #ifdef __DML_VBA_DEBUG__
 		dml_print("DML::%s: Start loop: VStartup = %d\n", __func__, mode_lib->vba.VStartupLines);
 #endif
-- 
2.25.1

