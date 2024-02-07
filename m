Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E9BC4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 08:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61FCA10E149;
	Wed,  7 Feb 2024 08:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JRW4aX3d";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0994710E19C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 08:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDQZPOd1QQ0GXpTl1HDfGcLfrJ7daeB6Bz2ZSvgVqwanw7CcErlCqSvTNmMwlVkivehcSL+kRXLetDlUDkx7RAtTtE4HHSnOjC4S+Q6EULDeo4lfG5kmnBusV0VFXJFxN+XiEMDIyNJa5WvUYyBU2ShLNtZjeO4WdO0JJMzgMLo3E3tJXb+lbNAQCB+kIyxA1P8bIT2XOAV/pRYaFuxpBSDcRPcGN5FTqcd7RZVN0xyoRmYJ1PRs3kV8VPzTBM/nFB6ZBn/ItBXC+XhCJTtAUmGr864xG0qd1sDwSjAhBsy/ySY9cF9ah+XmW9JGFXQuPPSGBvH/0OKHglUwA+ozZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S2VbhQXWQzTGmEbwPXxBC46lx7JZ9l72ursoQAOie0=;
 b=V/fspFGZFRNOGdobszmB3T7wOfSvfVkR+FYFN4GD0S0FVOgoZ07sh7jUb4PHl8MgDDmFJPETIutQjnMGXsU2T3oV1UetDJgOyI7dTezqW1iVD1VWx2zso1WPU5aXfukgQhAEi2a52HqtArT8jUdMJYZbyupZwY8aMeb+aNcjAucNuQDbype0WVqBhk6d1GEWHeo2YQ9WCcTrO6q5Fx+//boFebCCgksj7L6ZVafF16bIbzx1y//w9fYvSnN+8aohHhGJyUmqFbVTNlfIOpE5clbZmtW44qzI6me1V9x9LG4b/bRVhLqZlKbg+ZelFk3wtGP6zDNXiAmrxyVicL1GvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S2VbhQXWQzTGmEbwPXxBC46lx7JZ9l72ursoQAOie0=;
 b=JRW4aX3dgrZq5O0VOLQ1mf5g6/MzefHsj2B5PDpIS6R9CvH/eO7AeW6eGvmP8JUJOssByiMvVW0xzwh+8+/BRFW0QE5+GStB2IV8mHCX5SPPwxmd2wr2SM7tbRgfg55oMAtu588kED87OL7rUKGdd7S5rHyO9/m6zAyCm3cTXDM=
Received: from CY8PR10CA0035.namprd10.prod.outlook.com (2603:10b6:930:4b::20)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 08:33:38 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::b6) by CY8PR10CA0035.outlook.office365.com
 (2603:10b6:930:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 08:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 08:33:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 02:33:36 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Wed, 7 Feb 2024 02:33:35 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: denote S to the actual clock
Date: Wed, 7 Feb 2024 16:33:33 +0800
Message-ID: <20240207083333.3815944-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: fe0f549d-6c29-43fb-88c6-08dc27b77b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTJwSLDwNWsr2FpriztQMjzP4+bM2mHy0R/oIl71rd+HDkV2Q9fnl1TAF+yontMtblcnt9zbrj5InD6y3f7CgJ7pS2zWE4QQ6FziJ3anIik0CeMKwcvrEsnel1cY3vcGMWARY4W473YwCA40UEZ4EjcPJ6c/TwxBhfQHAmLhtgBh78zJHZWJY+T3O8HOyAFGEWWGJPleVDZBebULJpTa3hx6y3n0JjzKBLOCxHy5gJuf1nVFV3VpeGCIkM0uHB9C0XefVKHRRRj5n1kY0r9j3T1nI7+/DjbFJqc5SGMWU1hhQjSb2LVZLn/TPOa2pYS/tfI1ZVdOp48AhtzbUUEXNnjxLOJEEhzzQM+iqS3MyxnA316aFX+6FtJu8QBqrFlHqm+f4iqPPTl55+UdXMByYd1Yu7tlpAs2LdrP1UhWWCCCHybBtNX4iGQTWWw9DuXg6sg29vtKsQzcXfeChviAWnkMCEZbI8TMmCndBKW0qSN+bkISQVfUjRcVxJAItsiwPP7/Sjt+WDhE/nK7i7gINaJdGrcr9DrTgUUs0mmS1o9YMG/PMKUlnT9nbC7RllUtcovxOzkvakx73Z1EL1opdMBdepOMJuSnrCcsUIjs2rk+2Ffgtp5gHRIXYKb5c03FAZ4HvV8Jn7nH59FPnWhxu6yK3ULie7TLTKEbfYVuzgadWXPcojA7G1ttA1OsTamCvQyI3jDaQOhKE/zS9jkWC4SmM0VpXBOs2spN2KwRA2Q4wxNeuBYwMDmqb94WVwG8dmkR0JRz17a0r39Cc8tKVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(46966006)(36840700001)(40470700004)(36860700001)(41300700001)(70206006)(336012)(26005)(2616005)(7696005)(478600001)(1076003)(8676002)(44832011)(86362001)(47076005)(5660300002)(70586007)(2906002)(4326008)(81166007)(83380400001)(316002)(82740400003)(356005)(6916009)(40460700003)(426003)(36756003)(8936002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 08:33:38.0496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0f549d-6c29-43fb-88c6-08dc27b77b5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349
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

denote S to the actual clock in smu v13.0.0/v13.0.7/v13.0.10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 12 ++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 2e7518f4ae1a..63a930c4da01 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1270,18 +1270,18 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 			 *   - level 1 -> max clock freq
 			 * And the current clock frequency can be any value between them.
 			 * So, if the current clock frequency is not at level 0 or level 1,
-			 * we will fake it as three dpm levels:
+			 * we will denote it to S:
+			 *   - level S -> current actual clock freq
 			 *   - level 0 -> min clock freq
-			 *   - level 1 -> current actual clock freq
-			 *   - level 2 -> max clock freq
+			 *   - level 1 -> max clock freq
 			 */
 			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
 			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
+				size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
+						curr_freq);
 				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
 						single_dpm_table->dpm_levels[0].value);
-				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
-						curr_freq);
-				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
+				size += sysfs_emit_at(buf, size, "1: %uMhz\n",
 						single_dpm_table->dpm_levels[1].value);
 			} else {
 				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 0ffdb58af74e..dbdb50173de7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1259,18 +1259,18 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 			 *   - level 1 -> max clock freq
 			 * And the current clock frequency can be any value between them.
 			 * So, if the current clock frequency is not at level 0 or level 1,
-			 * we will fake it as three dpm levels:
+			 * we will denote it to S:
+			 *   - level S -> current actual clock freq
 			 *   - level 0 -> min clock freq
-			 *   - level 1 -> current actual clock freq
-			 *   - level 2 -> max clock freq
+			 *   - level 1 -> max clock freq
 			 */
 			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
 			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
+				size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
+						curr_freq);
 				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
 						single_dpm_table->dpm_levels[0].value);
-				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
-						curr_freq);
-				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
+				size += sysfs_emit_at(buf, size, "1: %uMhz\n",
 						single_dpm_table->dpm_levels[1].value);
 			} else {
 				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
-- 
2.34.1

