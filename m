Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F59C4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 05:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6F310E08C;
	Thu,  8 Feb 2024 05:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="piuUmf13";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D6C10E087
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 05:34:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFdN11mYkANr9Q/CGVIgTC/ThIVXPwWN1K/+rva6fkJ+XAFSYFqqGDihRpu+60hCIkBmHG9cBPpyAV8J8O9QE1Bo3f6GwnvE7JpGGeyjufim/dYhC8vH4ZTZ+C8gap9+5bpb2jQilyqJbCyjw38R9sMw6BFpBPQEDNOykeA+pF0iDFrt4HuJNQ+fVun4aZ6K/1jJ+HkWVRPkwAdXIjJasifDGVBmuD4KWgfAtmLiim8svBLe9iux56NyeGL02AvsYkROQ9CPcRXQ4bEZnfY/N+5VhY9t4KjGRX6Ndk4WELeSZmJEZnspd682EAN8VLdOy/ITEQMp6reGZF22njjj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWND2SpT+YjdZ+OcZFpmFISXylTMHZaXCSXDfH05aYw=;
 b=GTKA6xXEpzD5FV3l6qxgNy5JfQhCS2CjpcAr1/jV2tVKacijra1ljm2RiCBc+48jHxzFd2T6GyK96pMjOxVVqIefGqpFJ7rNCVZfVyNFAMniMTnfqWG3wpQJXoNpbX4wMZMLgnW0iM+sIptRUg4669PdYMilDaEWvhDHJyu8Rm76N5GhyJZtLpvFisahtdJCk8kpJtpMxPosuSJAHxGtxvUwVK66NIthlYCTsGfXc7diannU8yYb3U4qEwIbh9T1FXNIHbzLpNA2SCtcol02wOWQDd0th5se20IFgliZaZEFbh+Vl06bsrSiQkq1bXhy9OJYvQVucCRRwZ+YSbIUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWND2SpT+YjdZ+OcZFpmFISXylTMHZaXCSXDfH05aYw=;
 b=piuUmf13xWTrx82WrtnvZzuGWQ/B9DAPV1RBAbDUAxxRL+d17U3l6TZTkXvXRt3XxwFV6JDctOoDntQmXmUUoNSGKwRymv+JZvj6KIfuVQz2EeDbiMDZ20zP14VVnEs1p08Nvs/xI+kiC/VEXfZDqksI7l9McpQedWh/4tBLMd0=
Received: from DS7PR03CA0224.namprd03.prod.outlook.com (2603:10b6:5:3ba::19)
 by LV8PR12MB9156.namprd12.prod.outlook.com (2603:10b6:408:181::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 8 Feb
 2024 05:34:24 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com (2603:10b6:5:3ba::4)
 by DS7PR03CA0224.outlook.office365.com (2603:10b6:5:3ba::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.39 via Frontend Transport; Thu, 8 Feb 2024 05:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 05:34:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 23:34:22 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 23:34:22 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Wed, 7 Feb 2024 23:34:21 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: denote S to the deep sleep clock
Date: Thu, 8 Feb 2024 13:34:19 +0800
Message-ID: <20240208053419.3978393-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|LV8PR12MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: f24aff85-1367-4293-9940-08dc28679b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgZtyd9QxqKZdb0Q5DU6zD2W84PJ9zXXziM+DBl9+l+0jAVFWgOITK5gbcIhU7rYWZKZj514TzBhkeN8z2eJnxgpoo4wOq9kiR+C+T5HCqI59uWyVfEp+y4KRy27EXddLj0N0fWxuQ9m/ceJCDoqBCJDIeJAKcNzdiFvX5R+jy+3LPySGPBvg30G3wSOnh10iE53sgLE7ucfUqBCmllU+aKFwspw/DAl84jw2dndUyZL33MCCVvNjbfSlSm4ubv2XDERQzAFAzrvOh1eAgKZZ3p8bGOrIVpWtMh5MlPwdD0muztq5a07V0AE8DeTQzMt4JfvfU99P86FzQls4sEAnDsmn/Xm9bBrLH89a0C5iwigeyyNL7IaqoP5dUQTYaAMO8FClslbGlaJpl5jhB7gyOAoJnl6r2MkuOdQQXtcdKa2iSM/Midk3g0W00buXSQlQ1tJA2VzuUb2hA7C7VK2Yrat5iLf4GDvv9NBB8o96hXuM4Bsn54B0LjVJPXvE7JmSRvLUA8yikoMaXG8IqDy2xGeTLt5jyrX1kyKPmJycSCFrs1gmmFRlp6Nh8vXebaUfmIATXWVn+aut2HRW22OalF4NQFGrVSfqu3Vq12kOsk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(2616005)(1076003)(336012)(426003)(26005)(83380400001)(41300700001)(36756003)(6916009)(478600001)(7696005)(356005)(81166007)(316002)(70586007)(8936002)(82740400003)(8676002)(70206006)(44832011)(86362001)(2906002)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 05:34:23.4968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f24aff85-1367-4293-9940-08dc28679b8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9156
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

denote S to the deep sleep clock for the clock output on smu v13.0.0/v13.0.7/v13.0.10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 27 +++++++++++++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 27 +++++++++++++------
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 2e7518f4ae1a..fd33646970a4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -109,6 +109,7 @@
 #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
 
 #define LINK_SPEED_MAX					3
+#define SMU_13_0_0_DSCLK_THRESHOLD 100
 
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1269,20 +1270,30 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 			 *   - level 0 -> min clock freq
 			 *   - level 1 -> max clock freq
 			 * And the current clock frequency can be any value between them.
-			 * So, if the current clock frequency is not at level 0 or level 1,
-			 * we will fake it as three dpm levels:
+			 * So, if the current clock frequency is lower than level 0,
+			 * we will denote it to S:
+			 *   - level S -> current actual clock freq
 			 *   - level 0 -> min clock freq
-			 *   - level 1 -> current actual clock freq
-			 *   - level 2 -> max clock freq
+			 *   - level 1 -> max clock freq
 			 */
 			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
-			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
+			     (single_dpm_table->dpm_levels[1].value != curr_freq) &&
+				 (curr_freq < SMU_13_0_0_DSCLK_THRESHOLD)) {
+				size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
+						curr_freq);
 				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
 						single_dpm_table->dpm_levels[0].value);
-				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
-						curr_freq);
-				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
+				size += sysfs_emit_at(buf, size, "1: %uMhz\n",
 						single_dpm_table->dpm_levels[1].value);
+			} else if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
+						(single_dpm_table->dpm_levels[1].value != curr_freq)) {
+				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
+						single_dpm_table->dpm_levels[0].value,
+						single_dpm_table->dpm_levels[0].value == curr_freq ? "*" : "");
+				size += sysfs_emit_at(buf, size, "1: %uMhz *\n", curr_freq);
+				size += sysfs_emit_at(buf, size, "2: %uMhz %s\n",
+						single_dpm_table->dpm_levels[1].value,
+						single_dpm_table->dpm_levels[1].value == curr_freq ? "*" : "");
 			} else {
 				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
 						single_dpm_table->dpm_levels[0].value,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 0ffdb58af74e..2ecebad7a9cb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -85,6 +85,7 @@
 #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
 
 #define LINK_SPEED_MAX					3
+#define SMU_13_0_7_DSCLK_THRESHOLD 100
 
 static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1258,20 +1259,30 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
 			 *   - level 0 -> min clock freq
 			 *   - level 1 -> max clock freq
 			 * And the current clock frequency can be any value between them.
-			 * So, if the current clock frequency is not at level 0 or level 1,
-			 * we will fake it as three dpm levels:
+			 * So, if the current clock frequency is lower than level 0,
+			 * we will denote it to S:
+			 *   - level S -> current actual clock freq
 			 *   - level 0 -> min clock freq
-			 *   - level 1 -> current actual clock freq
-			 *   - level 2 -> max clock freq
+			 *   - level 1 -> max clock freq
 			 */
 			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
-			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
+			     (single_dpm_table->dpm_levels[1].value != curr_freq) &&
+				 (curr_freq < SMU_13_0_7_DSCLK_THRESHOLD)) {
+				size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
+						curr_freq);
 				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
 						single_dpm_table->dpm_levels[0].value);
-				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
-						curr_freq);
-				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
+				size += sysfs_emit_at(buf, size, "1: %uMhz\n",
 						single_dpm_table->dpm_levels[1].value);
+			} else if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
+						(single_dpm_table->dpm_levels[1].value != curr_freq)) {
+				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
+						single_dpm_table->dpm_levels[0].value,
+						single_dpm_table->dpm_levels[0].value == curr_freq ? "*" : "");
+				size += sysfs_emit_at(buf, size, "1: %uMhz *\n", curr_freq);
+				size += sysfs_emit_at(buf, size, "2: %uMhz %s\n",
+						single_dpm_table->dpm_levels[1].value,
+						single_dpm_table->dpm_levels[1].value == curr_freq ? "*" : "");
 			} else {
 				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
 						single_dpm_table->dpm_levels[0].value,
-- 
2.34.1

