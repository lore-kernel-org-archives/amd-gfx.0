Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173B9CF8851
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 15:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A2410EA3E;
	Fri,  4 Oct 2024 15:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hxvuz97P";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1872410EA3C
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 15:57:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkYX9XpPiQKY0GWeqnJUOph6nnFQvsYU+Tzh7U+6qLmjt1DlR5nedsoUU53u84uXKp6WTTlZT1/XakBTMAG7dvp73rdD46I+Dq4CPUJ2G2cDDke2GZu6eYRydP/elznrbJGpMh4mGAiyaetav5IelL/TcAoL32itCVKrVb0nk3N7O/+gMennZlzjwAaUw7rYC1pOK27P+2pTBgWMXAZgIe8sWJ//PZ1PisMeGJG/XlJN/EFCssNflMg6PWfJ0zOfUolh7wRermmVa+8FqlHuq18qM/x2PVuJ6MjznT17eXGxqNM51V63SIBCtNlMnQ443Cfo205S7wuH8XqszzmfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBDOm1Vqf+LnsYD14lQERbUtcK2cFsACO/VV0gegPRA=;
 b=km6HetVdwRK3b5mBwnnF30nKJ+lRKjvxmRYReB8vE3uVi/gmYECKfn+6i9kPkwm5ldPFh9O7BNKppMnzlMefOblRwxJWRRt51IXkeoNF3/+pmuPWQ6mn5kRHSKBKSIYaAjBSxe3HZP/fjeW3m7MTBMY5Bj5mK282NLvv6gKyjNhE9wxmO9KxW3hjtL9OiPC9rHmthcYCJaqGI2Poo/N5NKbG1kqDCu7lXddFUC6fjAiQe0sYjkZETVAra7mC/U8myoRez0fMTnlc8YtREZo+RT5LFCDPPWqWGNMTYIurXirHdREUdpUp/y/JkLfbtJbKB9TPKVMZ/8rk4JSmB5op1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBDOm1Vqf+LnsYD14lQERbUtcK2cFsACO/VV0gegPRA=;
 b=Hxvuz97PS9Xeq1CuT0GHUW+JXAmNsZY7CmaOeZ72mWsRh67Yu9vgFV6SMI61X6+FyDajj6TNRdtsFsxULQMK0ow6TgGjRr8KjfaFBPloFRE/mFeCD+RBWP1WUtp+XyiDnuIAOEMC3OS0sqydZ2bCq6PYrlND+/hzUqFSN7IxUMQ=
Received: from CH5P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::11)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Fri, 4 Oct
 2024 15:57:53 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::3b) by CH5P223CA0010.outlook.office365.com
 (2603:10b6:610:1f3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 15:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Fri, 4 Oct 2024 15:57:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 10:57:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/swsmu: Only force workload setup on init
Date: Fri, 4 Oct 2024 11:57:36 -0400
Message-ID: <20241004155738.488919-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004155738.488919-1-alexander.deucher@amd.com>
References: <20241004155738.488919-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: f29fe0c7-e3c1-4eae-b794-08dce48d4e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d2B7cBcNJB0dUghNeqA07ZS+GXtmiCWA+3NrshBy5ehl02waMR14KPx/w12V?=
 =?us-ascii?Q?z5H8r7EE2FWhaLaoTy79xFwmBI7rc/AlcaxCt84YYX67YHjAgRkWlgvrEPWI?=
 =?us-ascii?Q?A88Y4NBU/2W+a4WKkBdDjNPSNORP4ZXfy28OqmdMoUYpQStP/71oQH6c1OkM?=
 =?us-ascii?Q?2AqsarVx3jKYeldUxbfLGeloEJYoAnc3NOPXr4DtJC6C0VMyF1dEFXE68RX9?=
 =?us-ascii?Q?0CwUzkZjhIL5wl7t9kzzD6kE8e0ITlfId87kQRIUnpHd7fEf/brshHkmA6eb?=
 =?us-ascii?Q?6Hvo/HHue+B4SgM0xSSSZC3fG2MRGGS92sZ7+u0l/EeRbw0mZP5ST2e4L5cs?=
 =?us-ascii?Q?heZ3SxqaAILvdnFvaVArdtv96va3cuhQPSyCg+JrNS5WD2pnh2ulHJN0N2xY?=
 =?us-ascii?Q?0dsE6SzptrZ8h32gFTw/xF5c+99V8yKTtihMKNQY9Sq7FolUGl4jmclGfG8I?=
 =?us-ascii?Q?CCu5L692jfKlfqxnZoOuChUnVlASspHnbeJ9HOr6c+LEDnsAOFENKn8ixLG+?=
 =?us-ascii?Q?UvBezefixI8YfeNY4QoR+TMMlb8krFn40H9K73Ovpchu9jI7ZN+/qm8B9bww?=
 =?us-ascii?Q?F8iCWjshn2kSuXo7KI1IsDc+9HHexmsoSg70Tz6tJjyk3mBPN3vvWHdvjtgF?=
 =?us-ascii?Q?ycFcymMQOhKJ5XqSQtyNFax/E7kkk9kRlN5lhUFAijXrh5eyAEGZ5LmW5buy?=
 =?us-ascii?Q?62WjtSByv4h3sKIDhz144vPn3dgmdPxS/1IgtQhofkQrfcB60972EjZJdUmq?=
 =?us-ascii?Q?TPmpaulG65RMJUEw2K4yBS7hhEvIEQJp0zvc0TR93dybDeo7Tp5mruzyq4Fx?=
 =?us-ascii?Q?pXNRzfKnrTCYk9Y0GjcRUSJ2qAW0hiISw1zAc5QlJo6F/0eji1IS1Mq9ePhN?=
 =?us-ascii?Q?ueZr2KsFAxHR9cBhppyZuQl57yHJPHlyLy6WOLP0pdj8MjywNWn4ila5gEyj?=
 =?us-ascii?Q?bWzIKx+1h18ZExwISSW3dnUrpRhylKU8s1ZomaCASzFNRmnwGnP6u7hxfYIs?=
 =?us-ascii?Q?pKoeKc1Qs/ldvGn7yvesRYkO/FF+wgITq3St7PXpwWbhufOKA25KxDbe8TIX?=
 =?us-ascii?Q?XCpFkBrZNcFjMal9PraFCE2hscXfG0ijjeIQI/X4TETTBzqx/gm0Cnp+sOO7?=
 =?us-ascii?Q?HfACcdxXlTR7SKYrSgYS5SqH3S7rocjK79KLfvKGbKkCJM7h6NxwZEqwyVUp?=
 =?us-ascii?Q?+K/XLpjmrPErfpPXuixD1HJ5GJRK9xBonISsQLymbngMRr6OBqTazDY1sUjL?=
 =?us-ascii?Q?7WwXSeLqWZCEYCBJYlG+RflseZEFgpQhk62j7hBRtSDaF/GcYLhZd9ApwyZU?=
 =?us-ascii?Q?imSzZ3mWIn7pDhZNvqI7oO8i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:57:53.7894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f29fe0c7-e3c1-4eae-b794-08dce48d4e85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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

Needed to set the workload type at init time so that
we can apply the navi3x margin optimization.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3618
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3131
Fixes: c50fe289ed7207 ("drm/amdgpu/swsmu: always force a state reprogram on init")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5b0cdda96b38..4cca1dcac60c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2232,7 +2232,7 @@ static int smu_bump_power_profile_mode(struct smu_context *smu,
 static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 					  enum amd_dpm_forced_level level,
 					  bool skip_display_settings,
-					  bool force_update)
+					  bool init)
 {
 	int ret = 0;
 	int index = 0;
@@ -2261,7 +2261,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		}
 	}
 
-	if (force_update || smu_dpm_ctx->dpm_level != level) {
+	if (smu_dpm_ctx->dpm_level != level) {
 		ret = smu_asic_set_performance_level(smu, level);
 		if (ret) {
 			dev_err(smu->adev->dev, "Failed to set performance level!");
@@ -2277,7 +2277,7 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
 
-		if (force_update || smu->power_profile_mode != workload[0])
+		if (init || smu->power_profile_mode != workload[0])
 			smu_bump_power_profile_mode(smu, workload, 0);
 	}
 
-- 
2.46.2

