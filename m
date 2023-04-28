Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC454C77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 21:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 442E610EDF2;
	Fri, 28 Apr 2023 21:45:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C9510E161
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 21:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmbYnZIKerI50xG5NLncO8008BMHXvACs85DQP5xQmnm/tZRqDWpTIPzEmlN0FR/Ys3F6NHdXgpRwUSc/futuGD7JAPECKXs/wOEZqpgG2mZT6YDA855UYRdiuzJuJxgnWer01ZFnG4Fs8ivQoipEpy8MnCFKTLlM0zGZHh5BQZALKr59jwgm3bRErQCrAXO5x3Er1H0ErNoR1c1z8xgp3cqzCegTrgOenf5QdQyNQcnPHxf+sNAmvfS98la5hUbGmi+9OG4QBFGl5/hlBeRBvjs5537dU67qZ0btJeoQZ0YuQAWcgiOCXA1Y4wKaXFJmJHgponiZxipsfmedvgVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8KmkbOSglmzJtzJ32orpR89NPhrqxoLByJu5K71Uvg=;
 b=fmVPVZZeXXPvReFsFWh7C8h7VRVW86Sw8UTGfVONSn2gw4iovPqR7Yta/ugqOPHfX3eQCEufBphZ7SofIXkow1VaSag1zaXUmn3DobN/Hi+GCA/ymeCB/+SnW/6Sxs0NBDvqTMd9EkTTgLiGkqxkrBoW6RTEjwgTj5S8o5y1MHjRvKRu/LRBhFn7S2YAsg0xTknrgHC+fBxQRRKXGqpKtMBBxnBbH0tX8WwP4UVYwxwLtPaxcp5kFCYWOjif7v78Ocnk7PsgxuNcO7vqij79UP3fcvZI31wUQnNv30O2Ty05vl41JUujK/OwGCcG86qp2u8gG49rD/sxevafYVwN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8KmkbOSglmzJtzJ32orpR89NPhrqxoLByJu5K71Uvg=;
 b=NWZsa4EpQDjPlX5m38NwMnT2M6KahI1x6yn2TI6YGTWhNcnkp7luzFiYQdGGXisR88CHTeZuQ80r/fPF3UbPmmBu41O/r+bCi8m21SlNmlQU42inGcxMHsZZ1xw+cUyyQNzOPTrvsvQ4nGzWnGyGJkdGKYl1oifQUfHC+kYhHWE=
Received: from CYZPR20CA0007.namprd20.prod.outlook.com (2603:10b6:930:a2::7)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 28 Apr
 2023 21:45:12 +0000
Received: from CY4PEPF0000C96F.namprd02.prod.outlook.com
 (2603:10b6:930:a2:cafe::5d) by CYZPR20CA0007.outlook.office365.com
 (2603:10b6:930:a2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 21:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96F.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Fri, 28 Apr 2023 21:45:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 16:45:09 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Kazlauskas Nicholas <Nicholas.Kazlauskas@amd.com>
Subject: [PATCH] drm/amd: Downgrade message about watermarks table after s0i3
 to debug
Date: Fri, 28 Apr 2023 16:44:59 -0500
Message-ID: <20230428214459.1237-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96F:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 53328690-c489-41fd-5368-08db4831d835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8T6BA5rQPfXa0prpxLZLjPriuEDcp39zDrUYWExD6cdpMGvwKnX+8njZS9USYqd1mPLrT7drwYsBw+i0UqIU8vsqKYEao3AQIZjJkjZV+jVjG/7fUqGKBQWH9MF+GUNALCPqtua3T5YdGV4Tt7uw18ROn/UDCHWPIjVf4BWQtugeOAGlDzwM/R/LfhzBAKaZSUN3iyzweSGqoRIt72SevYRKKyXOIqMXaly/VuX6+ZnOxXAirzE2lilmUTSqd6s0zE9wdhdq34PhlbBZqoBlFHhdG3GQw1l2ID74xT8hStgjOrclA2IDcM9/v5dzyKbsBJb4iPUSdPwp8WEBO70BYocnr54k6KJD2HfekmSDf6X7DJwMNn87V5zrxigL9SW28gWNdVMZj4wQcrcVT+n9v68ZmEheuDTH5Sye3DvA0mqeUXV06hOA7X3ayv+8TkSsVaItlCEoSOAMseCmFNS+gnm02Pkr7cOYBNeQOjCUBch0ABIOMNfQMVGQyHttZIhi91A+hUSIIX3QvOxN6ZjBd6tc6L3Qs+amCng7lQ0y8+gWzYsA3U3YT44RqNSLG2syLIvoy1qhZrtn+Fu+e1Pqbj8XYHt0WKGHBZ8/SCgpb06N7Kmb8BC0yTeUiv6ULBZwF1JDodxlpF/cfQUVwAWBtN3p5iyLoAEvcLs7FkzCCGm/TXnuH6tqIHCXLHqGKDJx1GwOmJDn85ceS7h69hGCEiDwXXhFVSpLmvl4DKUCobk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(40460700003)(54906003)(426003)(83380400001)(37006003)(47076005)(2616005)(36860700001)(356005)(16526019)(186003)(36756003)(86362001)(40480700001)(81166007)(82310400005)(26005)(336012)(6666004)(1076003)(7696005)(316002)(8936002)(41300700001)(4326008)(6636002)(8676002)(70586007)(82740400003)(44832011)(2906002)(70206006)(15650500001)(5660300002)(6862004)(19627235002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 21:45:11.9934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53328690-c489-41fd-5368-08db4831d835
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035
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
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This message shows up on s0i3 resume for DCN31 and DCN314 platforms but
it has been decided that this flow won't be changed and the message is
expected behavior.

Downgrade the message to debug.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 0827c7df28557..32279c5db7248 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -130,7 +130,7 @@ static int dcn31_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 	if (result == VBIOSSMC_Result_Failed) {
 		if (msg_id == VBIOSSMC_MSG_TransferTableDram2Smu &&
 		    param == TABLE_WATERMARKS)
-			DC_LOG_WARNING("Watermarks table not configured properly by SMU");
+			DC_LOG_DEBUG("Watermarks table not configured properly by SMU");
 		else
 			ASSERT(0);
 		REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Result_OK);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
index 0765334f08259..07baa10a86473 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
@@ -145,7 +145,7 @@ static int dcn314_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
 	if (result == VBIOSSMC_Result_Failed) {
 		if (msg_id == VBIOSSMC_MSG_TransferTableDram2Smu &&
 		    param == TABLE_WATERMARKS)
-			DC_LOG_WARNING("Watermarks table not configured properly by SMU");
+			DC_LOG_DEBUG("Watermarks table not configured properly by SMU");
 		else if (msg_id == VBIOSSMC_MSG_SetHardMinDcfclkByFreq ||
 			 msg_id == VBIOSSMC_MSG_SetMinDeepSleepDcfclk)
 			DC_LOG_WARNING("DCFCLK_DPM is not enabled by BIOS");
-- 
2.25.1

