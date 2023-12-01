Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD0FC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F321710E88B;
	Fri,  1 Dec 2023 13:29:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A876A10E89F
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWPMIeijR6D0550qENCvtlFMhPKnTW3oydHqyLZn2i8nRLL+sPaAg2hPcJnc6KZ8nyEoBtsXlf0DsB3xHcxyQovlHmITq4YVZtjlCj0G5Z0aIWuqtvxOu5AAYMvFSwBC9ZsSwZFo7XarVzrdN8sXSWqYXma4H0fyk1wjYEvhVKY5db6CQprNfr5YWYYoa5kYdpeAwA4oudWc/wuGZgVrAe1Z1FKXU888aMy7vDa+TOctjG+15G9C4OY13DkC5uXbP1KNDWgAJdk3XQQ8MOX3LOkDeVDKhai28fegB6ndmRgYpm1i3QpMLU03YUiabEVNgJRmKSA4XDVJSyUgcIJZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHGfPkEAtUFkHayRUwUIXP0vdY5EUd3eKJ3tNv9xtMM=;
 b=jGIJDraM/xMEhe3UdpTZCDS4UtQMJ+icxSSq9bqZqPK9p7t3PyFIwKA7wFeqViAoAtNdtyY8yP++1ZfFA+NF1T2kdnLY+TcqjeW3dq8QA2kUcazypQIPPrlIULQXwTGGhS2iRzOn9y52A1FYcS734yGoWEyfOzyE00PFVCgRJ8/DjaNdbsscOK+mUwK4gOBs+CJVLiyQTqkcxWUHio26RNLRMO5NXvfX+4XIgKl2zChx1ZounkPHRwR8LcBsaLepMWvbLt59aQMy22WCvEUBndtIwQ0MlyDhTiTZVtwGOXwcP1NLKA6WqGF5aSwXYRMm+8LG99EAGwlHAL3e5gDX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHGfPkEAtUFkHayRUwUIXP0vdY5EUd3eKJ3tNv9xtMM=;
 b=M19AEkVlmUk0fvBLN0t0P3qiBjqwUfWjJjrADMK1jLn1gYjh1VU50d/dgolzvroNSoy0RFZJMjGbXdPNYNxJuXaHv0QsPtN2oGATXOQG2BuT6eZ/xmlv1BNGnUtUcON6+qIklf4M9VkJ6JZ+fDkD3o9ge13SeMHKylUFcfW5XqI=
Received: from DM6PR02CA0046.namprd02.prod.outlook.com (2603:10b6:5:177::23)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:29:25 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::f2) by DM6PR02CA0046.outlook.office365.com
 (2603:10b6:5:177::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:25 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:22 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 38/47] drm/amd/display: Validate hw_points_num before using it
Date: Fri, 1 Dec 2023 06:25:34 -0700
Message-ID: <20231201132731.2354141-39-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CH0PR12MB5369:EE_
X-MS-Office365-Filtering-Correlation-Id: 9407bad5-6d85-4794-64ec-08dbf2718962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfVspgwGuE+9jQpp/lj6G1uO6qnzPiCRNFi0iKK6MnWIjWaT4Jbq3KQUE5G/Hyp6E/9TXEv6WgCvoyY2aiqt9+fyX07mrHHMGOgkth0o4NSMBKQNIsh5NHDjB6tOxNpw5zedBShOqgIlFVm73+cwBw//VAtxofhpo0+mLphAH1bR88a1CGads9Z4hJiJJQY7vGf23/NKbMUkR529wXf/y1w4GaBa1Y5HRNucUADlo5nm19x6gkBuLrBLM8D0aARZCz0k6VOFTrYKQ4nynwdJqVUuQPwKanSS9007JqsTjw5z9VfZnKF1UC6alpfQPbdDe1BZEZHJHQ8mQM0YtHTRnhVlO1nXHyZ41z3SVqK/IxDo5mXVd9JCBNcQhDq5Rz3ZiUH0DA3QAswATa5ixGd4BSIXkLC/qMZ3Cm94CYF3ZpK9DXg7IkkDS+2owReoHyZj2E+DIWg8gLzEf3M0dpzhe1MPYY7sM69bVdMXQK/3vQXhP2XLYW0ezAPKxt29kgenh9XT9LxJVrVGlPu1TTVXQ5uak3gaD45lwY4KELTU4gEON6mR0kf82DGKibjjTLTHq5/ReSqxbNabW5uTt1hDdmAM4U+LJv6QIe/z1+7LircuG5opBhCOuiBSrnjuKjMgFoVE7rfQDpW9wTtJ6dW4ZbDx5GLIrmxRQ41q3Wnl6yxTfz95cqzSeRNdU1JaxMjHWpA46792fkO8D1PWxGAVUvBzH3L6GvegccbrXlQ46hMA2jmrN572pCuR4CzS18yh3mywQrPm842Z0YRCjIlSkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(4744005)(36860700001)(54906003)(316002)(86362001)(41300700001)(70206006)(2906002)(40480700001)(81166007)(82740400003)(5660300002)(47076005)(6916009)(70586007)(356005)(426003)(26005)(336012)(16526019)(2616005)(36756003)(1076003)(478600001)(40460700003)(8936002)(8676002)(6666004)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:25.2429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9407bad5-6d85-4794-64ec-08dbf2718962
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
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
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHAT]
hw_points_num is 0 before ogam LUT is programmed; however, function
"dwb3_program_ogam_pwl" assumes hw_points_num is always greater than 0,
i.e. substracting it by 1 as an array index.

[HOW]
Check hw_points_num is not equal to 0 before using it.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
index 701c7d8bc038..03a50c32fcfe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c
@@ -243,6 +243,9 @@ static bool dwb3_program_ogam_lut(
 		return false;
 	}
 
+	if (params->hw_points_num == 0)
+		return false;
+
 	REG_SET(DWB_OGAM_CONTROL, 0, DWB_OGAM_MODE, 2);
 
 	current_mode = dwb3_get_ogam_current(dwbc30);
-- 
2.42.0

