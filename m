Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCCCC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E0610E881;
	Fri,  1 Dec 2023 13:29:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 021FA10E8A7
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7ctajT48sjcpDSwOTrs1cByPWvfebcT8k18c6AVR1aK9qQFKF79Wttt7fPY3yxIdY/6hcqNj7K6UBww5kbePB6Jvj6G+Tj5gCYd5IELF1EdK35R710ZvgBjVK0EMAFRKIwaN5r46cFIWV5dUgu/EQ4g7SaHx1A5ATZnJaipUOJ43v261Da7IN295nHi6z88efOHvsKym6S8fUGY35iusInft/uSO4OIpFf3jW67YssZhuykF1IN2uD+nr+jcgDkX/86B7oCblu9zSDY3sEIZpy5xYxbdt41kT54qVezyoU8K29oi3yUxFfUQewzP2il3s+2pkoGzrwBtz0OVYbEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiFLKfjBS5WAOG8ptl9dfXPgVTHI2SW8vQRhCNp0v/g=;
 b=RQ7v1v4d8AOWDRRzbtW6Me5NtjcMjkkv9wWgP6JaJRQ3AxCpPsYeIv5lflwWRIJ8TO5aqGs6rg3BsnhIwHw2IBqMuXtlhnXiUyQ/eWh3yoVtto0RnptMfKwJpEo4XHM6lhqCwBYV5ZsnckviNT/qRDGyTb96r8D9wE2s74B6MQkL7cjLUIdO001AeL7SHe+Duxuxu1QC7iFP9OssTJNdC7EZmQXxcP+f51WWp99QhspbAGoKOsfWLkICE9JtQuq5xJkoxbcKzX66uGF9VhZMqo3ALiA/vXsO70KkBUPdCZGQefXoyCQ2C8cGl3lz29GyHj0AAD47oiBDdqzjFsDkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiFLKfjBS5WAOG8ptl9dfXPgVTHI2SW8vQRhCNp0v/g=;
 b=UPt6dQ6EHFG97cuzlLVtcHf49iHD9EFeZmD+Cgg2yu/P4/fEmxVYsDXxU8HfAErbrOE4LVWJe9pfcVj+8y+H1jq4oCQ4AeBMqOVbQsOHgTIqsNqKN2s95oUonsbpTYq9FwK6W+4UuW293NGCyCS9fEPbr7ZxbIqYPTD7gfV5NKQ=
Received: from DM6PR02CA0058.namprd02.prod.outlook.com (2603:10b6:5:177::35)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Fri, 1 Dec
 2023 13:28:44 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::73) by DM6PR02CA0058.outlook.office365.com
 (2603:10b6:5:177::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:44 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:41 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 23/47] drm/amd/display: Fix Replay Desync Error IRQ handler
Date: Fri, 1 Dec 2023 06:25:19 -0700
Message-ID: <20231201132731.2354141-24-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 896dbc8c-1a2b-42e8-aafe-08dbf27170d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQCLSkITeYzxUzdvSrdpeIswQ6A4m0UKKwLV6W1a91swrsCuviuPJLZ4NWLfRx8byGprzki0e+As8m3wb6hMOXygA/eZjWygHCbI9I6FdO5EdGM0bCvI5u/zinJ7ytphGaFRxDRImCVm6NS5E/BwCTgeccc0ogPGgVhF2WHWway7L3EPcOwEwKQSWGG+2oxo04PClgGRyYbDmukaku0y8afaLjZKKxyW3rxrmYOprlCmoOKt1syfi93753rgOjEkF+ETBrSaLLXeeKbzjULQ4vcJpB2CKd/LzmDrAji93kBtAjKjK/6xTtJrKInb7y6QIiNLZ1bRLfASl0QlBbccdmEi1NyOeoDrXOjA4ExEC0QsCx4plsVJ8wKBY1mi5vrw3uwafMevmxWhV8zcv8/PzW1g4QPmmLYSAJO/cXJbCoOZR8ZLyOq7k3fu/oyPfvESgpJXeFeyL+qVE06mhoGnHmhrT319vnBwb8eOo614MmeLRZYoFEks24B9RSsURCLaKaGQ1pqwm9B97DMJ8a6LJIGPWp0BPi5ET533Ya8AeOQFP2IwlG9bYu5Fqx0iCvomUh4FzeUDHTvwcEaw+v60yRInMSmkN75/+7TmtXJ2ccmIobVKQyTM0uoPFu0nBFlv/rAnxAKXezyQTCCYiIbG3tAOJIhQT0RBRa2sxw4nE1rBkUEdKWu5uma+W+B6az7z0x2lCTogNC9nHjqaGAa3XXbq8TibONvLRlvA9Sw8Pd1+l7R7r2lhoLVwCwef1Io63O6FIYdneaN6w9CaYiSoHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799012)(186009)(36840700001)(40470700004)(46966006)(86362001)(81166007)(356005)(47076005)(41300700001)(2906002)(36860700001)(8936002)(54906003)(70586007)(2616005)(70206006)(1076003)(336012)(6666004)(478600001)(83380400001)(36756003)(26005)(6916009)(8676002)(5660300002)(426003)(4326008)(316002)(40460700003)(40480700001)(16526019)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:44.0553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 896dbc8c-1a2b-42e8-aafe-08dbf27170d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Robin Chen <robin.chen@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Dennis Chan <dennis.chan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dennis Chan <dennis.chan@amd.com>

In previous case, Replay didn't identify the IRQ type, This commit fixes
the issues for the interrupt.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Dennis Chan <dennis.chan@amd.com>
---
 .../display/dc/link/protocols/link_dp_irq_handler.c  | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index ae271c830c9a..ba69874be5a4 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -190,9 +190,6 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 	/*AMD Replay version reuse DP_PSR_ERROR_STATUS for REPLAY_ERROR status.*/
 	union psr_error_status replay_error_status;
 
-	if (link->replay_settings.config.force_disable_desync_error_check)
-		return;
-
 	if (!link->replay_settings.replay_feature_enabled)
 		return;
 
@@ -210,9 +207,6 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 		&replay_error_status.raw,
 		sizeof(replay_error_status.raw));
 
-	if (replay_configuration.bits.DESYNC_ERROR_STATUS)
-		link->replay_settings.config.received_desync_error_hpd = 1;
-
 	link->replay_settings.config.replay_error_status.bits.LINK_CRC_ERROR =
 		replay_error_status.bits.LINK_CRC_ERROR;
 	link->replay_settings.config.replay_error_status.bits.DESYNC_ERROR =
@@ -225,6 +219,12 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 		link->replay_settings.config.replay_error_status.bits.STATE_TRANSITION_ERROR) {
 		bool allow_active;
 
+		if (link->replay_settings.config.replay_error_status.bits.DESYNC_ERROR)
+			link->replay_settings.config.received_desync_error_hpd = 1;
+
+		if (link->replay_settings.config.force_disable_desync_error_check)
+			return;
+
 		/* Acknowledge and clear configuration bits */
 		dm_helpers_dp_write_dpcd(
 			link->ctx,
-- 
2.42.0

