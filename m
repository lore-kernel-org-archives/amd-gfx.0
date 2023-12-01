Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A59C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41EC110E8A1;
	Fri,  1 Dec 2023 13:30:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF5010E8A5
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBvxxc7/lLNIcw9kCgjdaYXdn47KVnofANVzhaIDah1CJbgxSdX9j/1guxNMF0uENjQ+h8YOtqmnm4fn55doSmpRyDV2WC7fcYt+zXXV5m4d77RfY0G0aRwB2xWubhfQA4qtpPrYDoyfVtvyJ0CgLeYs9KJNC6YBXaJhIXQfv68TdXPK4LTbJF4EVnt278lKspP7hWOy9KwgC2j1gcvrfC68AJ0oE/TgXHjmmCvlVkzKNiwugZilCOEHbxa3Nka4V3DUCjB1I/xQfNL1Hp8Evs1CCPdH1v07DyyHx+ZRU7qChQgJ0oR5GNHCew7C7axKyXPzG9OskjqfD+Qhzu8WJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vENlvZCyhHmF4Fv+R6hizkr7cVxI4i1HFjaMcUWhSog=;
 b=QcnLQ/oIXWRYLi/HfOw5SJ54v9EpyrIMYq2hqBki1IYW38l5xlFkqJ8anreZJvaab4+m/XOBX3Wr131gJX1u0tMsPQFKcGFoLiOrM7uMRY0OkdLCi/6opC7pPCYfl9Ylii+qBx6FQhRP6L4z/IuC9bgjUDCJQnC7Jovy/FgwBbPTUKp7dX7Bw8uUhDJKVIyhmoXn2yr8gRN6kCgNJLkShCa5Ow85HBR4E5Qpxf46zhvfZdlq6dbRJehZT2f1ye1suSvQJq1tcQMLbxV5HSdzTAMTWM9+VDbnUMvwaQsTtAiKDX88ZpNtGETIXPgdYQg4vat6bpoDcJCBNXNUadknOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vENlvZCyhHmF4Fv+R6hizkr7cVxI4i1HFjaMcUWhSog=;
 b=RkGFbU6199W6cOEwnlaUMY5cL1QXqZvcSHcrg6AmQS1Hq/M/rKxYqefjCMk3LyL3ejnlxEpsFK+A0b2t2l4XpVeTWdZondiW/HhkLfe6YKpvnEowAB6x2r2bmqTT97AQFQqOJW081udezGaPksAtTPMbdOWlW5y+/IAjsCXwoKA=
Received: from CY5PR15CA0186.namprd15.prod.outlook.com (2603:10b6:930:81::28)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 13:29:43 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::bb) by CY5PR15CA0186.outlook.office365.com
 (2603:10b6:930:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.28 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:43 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:39 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 46/47] drm/amd/display: Update code comment to be more accurate
Date: Fri, 1 Dec 2023 06:25:42 -0700
Message-ID: <20231201132731.2354141-47-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 14225fad-a7c1-47b3-51bf-08dbf27193fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+OJiVndPPvPXfD3ExStubuU8a+Pg6g1FnFgoAzAomwZpnQw3DB8xytOiPgLTmZILGMgqn4TQIGtzRY7hbuvbJ2zN7dOXrt2ckx6S6cL5GxKStpVIeTnmY72Rweb9+ATwADSwLF/RYErlFuk2xhmDHWFRmbNC8uo4K8s7fC2/8qDV+FLavLOhM4AouRxADlVUp8EGwX8Fo5KXyJIucIHzK8xUhvLdjSiJ+RdtYKS2ItzcMEZWqcTMMOgKHvvyuqYuwBtiXr6FtHVZVuEXWp9EIQN/Fcsy60MZ3J/KY5OGiGvzuTpuVh6C9WYZm31IzeE6WQ9WNEcKAD3kA05wSJRP4Toqxvs/goGaPgWyKsVOl1qXw6gk0eqNrB/2eONg9d5LGFLvUI3XlOkxAAaMasa+aeNGC2uZnb7+aRZLMp+MbkwgE3qcPoTq7zet47AaaD6fvNBJ7BvE2EwrfrSXmDNQM7w5Ax0zyB3EDZQw/J29JkcISBpZQ6eSe23gwSm+WgXb7nbkD5IlnYEaDiP9eXNvmtodHjphk8nsApeeB4uE3+ezCJjBTo+ksO8PKcjwhZt5HkCBwCwcTWcUKV/QhTDxEB9D/v6gqwmGzklllRyYRmAWh9hgrfRIuQgPq1FizcluZ3jrw4TLL2r59T+Ad0zeo/xZrKzBy5kNDlsLG8/GKQNPB0lmiyKaF6kad57uEwHGaKswWmaZLqIVaVTzBIPRrf4T0AFxwLqY5MBbWjZSdZoogXetrSff2Fd77oklw4DbfqxfmiRMXG2IyHoOkXwpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(2616005)(26005)(86362001)(40480700001)(1076003)(356005)(81166007)(40460700003)(6916009)(70206006)(70586007)(41300700001)(5660300002)(83380400001)(6666004)(426003)(2906002)(36756003)(316002)(16526019)(4326008)(336012)(8936002)(8676002)(54906003)(478600001)(82740400003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:43.0041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14225fad-a7c1-47b3-51bf-08dbf27193fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 102d00a9a24f..9d3925603979 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1521,7 +1521,7 @@ static void program_timing_sync(
 
 		}
 
-		/* remove any other pipes that are already been synced */
+		/* remove any other unblanked pipes as they have already been synced */
 		if (dc->config.use_pipe_ctx_sync_logic) {
 			/* check pipe's syncd to decide which pipe to be removed */
 			for (j = 1; j < group_size; j++) {
@@ -1534,6 +1534,7 @@ static void program_timing_sync(
 					pipe_set[j]->pipe_idx_syncd = pipe_set[0]->pipe_idx_syncd;
 			}
 		} else {
+			/* remove any other pipes by checking valid plane */
 			for (j = j + 1; j < group_size; j++) {
 				bool is_blanked;
 
-- 
2.42.0

