Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DA3C369A2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 17:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068A310E362;
	Thu, 10 Apr 2025 17:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YONlx8KQ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F5A10E134
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 17:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol0HrDMVhm4ZssKCblUjefCLm9uzF3cSnNGk3ulD+HmCSxILHDuoWbkqoxg90g51PUHCrmb8g/hD9uZC6+6XITB3+yyVVypxZOTv5CzyLPtBXYHAvV+3A7734t2UmTRxuV+EDIgdZDaTL3vbAKhYw6AfEw84ixqVpnaDrj8Do3WI2NxqA1VdrpKVuTZ3Y/uZTbO8YUjTt+6lXsI5vmBWDYgFWhyEq2cnMk0N/WouJxYo5qI2TtXnbmySRWoZH4iSWN6dP175r1cVMtTZ1ktGH0/FkobaXTcLbgl6xLovus4dPrXCTxA4g6LyZPa/xCC4kFK7a70Jcqqk6MhqhG91ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcpHNh1s9vc5S4dti+xVxwYaaAZIcsCjTf7JLCWRYw8=;
 b=ArcqHw+g663CuuzU+9tKvOi2eoREOOwLPdmeE+OUtNhKQlGntKP+CD47CgTG4Tx8dCl7vYRt0ndwyPu1E4yF82Ndik22Vuw/0+XBlvtT6VWIdnivljrXdlnQ8uFbp8weoSTaUQmbX9DdpHG8rhXXD9LfdAvcJ7RRpHaqwO8UzIKUx6q+YtK2ealKWEAlO1lc0tm79yVVIEX6vvUhtxnaKOYEPmbHvuv5HyOtR7mdWrVagtEg/cxmEcdg7MZxNvgAIHWyv7C1nvhluN/kB/c3Fp3yyO9PasAn5BJyYRGqe6bw9jhVsarrCHHk4muHIdUx807J4rB+Qe/B4FfVmtZ6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcpHNh1s9vc5S4dti+xVxwYaaAZIcsCjTf7JLCWRYw8=;
 b=YONlx8KQcNt8wibIG428RKy1OVuuwyuGktn9DBx0+p26imPSvK5fcpksa9sanEhlEcO4ib92GkBhFQ1PIo3QQKO3aAnOvWmXKPucT96OLhgxdnwWYJ7rteOgAxUoN+YM75/vyyF3201ttHTi7qlFque7HIkEoBegKJ5s7kzOXhc=
Received: from BN0PR04CA0183.namprd04.prod.outlook.com (2603:10b6:408:e9::8)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 17:24:36 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::87) by BN0PR04CA0183.outlook.office365.com
 (2603:10b6:408:e9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 17:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 17:24:35 +0000
Received: from AUS-V14-AI-23.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 12:24:35 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] platform/x86/amd: pmc: Require at least 2.5 seconds between
 HW sleep cycles
Date: Thu, 10 Apr 2025 12:24:11 -0500
Message-ID: <20250410172411.10075-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410172411.10075-1-mario.limonciello@amd.com>
References: <20250410172411.10075-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dffa8c-ff47-4e1c-558a-08dd785490e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kJ2XLXRjLi57K0xNoLDWqaAX8fJdwRQeEhHhVDU+pro2YyaJEIKsTTTjyzjT?=
 =?us-ascii?Q?s0vv8RR2kYIWHq6TaDeCG+qOLbB9PyiZaZxuX+zQAhWX5LmdF7/qvUbKf+Ay?=
 =?us-ascii?Q?PWyjXFucRaQp+2XFbmM9513RCWaJ53dtUq3cX6eIoed57pnNaUi+/1uqe3Dc?=
 =?us-ascii?Q?LoTtDraumfcU7zOkn3Nc0XLT158NLZ6U55k+6eiBgR/V67oNMjgdqpLLuUc+?=
 =?us-ascii?Q?ZpbImn91eHa/7pFquIYGTAtHOLJX67eSLBQS0paZjIIkRUz6NlsUMGfo0WW9?=
 =?us-ascii?Q?SarA4tu5rQBOgtaZ62pZXlVGZP2naEIuqFnl8LuJDNasilmn1dGRi9OPGNw3?=
 =?us-ascii?Q?QCCEIlr4OhMV/b9luYe8txu5LpprzJ7edh8qVEp1EqXEpBs1Bl+xYCY8MgLD?=
 =?us-ascii?Q?yMgeW5hLvk+HwMPFAskm0aRjH37UJgapdgyTqImyjkZfG5xEUm5kKC1TBz2H?=
 =?us-ascii?Q?bQ5pOCkIUjNnk3qLFis+Xp0/1I+QiFooFFwGs7tXbIiiQtVVqQqLb1JFOotq?=
 =?us-ascii?Q?Zhpi7y2SS7iOKltvh+LOOjImHLrjGKZfGfdGK/+pgsrspMFa6SQQKzUHhV5Z?=
 =?us-ascii?Q?zOnaB76/335hGB/Sx6ixDoj8PfiQTsXqoqvOswxcIgvec8jZJGlg1C2eTmhI?=
 =?us-ascii?Q?PUQa4m7lG7ke6qCGeaaiiDTPUZYyaz2oirHJyYg6qf9IggpbPP+9Da7irQmY?=
 =?us-ascii?Q?hfVbp0doSBlza76+RQEdesYZvJXzF6y01ebSOU33PVliZ2ryfFbA900pRi4z?=
 =?us-ascii?Q?/7oGrG1Rsj9wp7fNsFCwNqgyTB51RC1bKL39ZAranNQNBntLeZOaiBO5SJfr?=
 =?us-ascii?Q?a4ExkUbe+UjKsBELrmI7XupZ2OF6AsZuKqlb2u67lXQLpS91rM3KbKpBLcgs?=
 =?us-ascii?Q?WFZCfZGHyQkS4g8FqQNgD9JbNXI0V8+GEX2FT1EeziqeMdKT7uOl9lVivfoz?=
 =?us-ascii?Q?7ALqSQmxL1IIhgeE5SE/rkqN6KW6qnHm/uwvkZnijuyhON7ho/3wMoaq9Tyz?=
 =?us-ascii?Q?vHfVRGg7DrsSdFDLH9C1aQTS3Eqb2fT2nlsaI/ecCy+0rCWKugHQYQYvwS8Q?=
 =?us-ascii?Q?W3mtfTMwc4g7uQW4PsCzLGT8AVZ3X0R011X3aIPPUpKXAdKKgxOppyLC6SEv?=
 =?us-ascii?Q?zmJqQ1OXQwzsL8cRO9fWhvZZCLjpHdy3n44IWQqwVZhZD5fKL9aijK1tohNF?=
 =?us-ascii?Q?oKqT1gWslAembsVtvNl4rSwZ0EY52zKpLfE8GdIsHA6XlAMkmggSz56pw65T?=
 =?us-ascii?Q?wNBOS6GOLwBmR3TJCrczVWSiAJ+75FjylWKn5y9Ncue793T9A350cF4Pqnjx?=
 =?us-ascii?Q?GkexuLPq/CcMdEoDWEOCqJMskbJMLbdrj1fQb5+hWkbPRgu00gT/YfPRm1kJ?=
 =?us-ascii?Q?xeP79WEaPpJap8MjDNpDNII2ulSY4A+XjWWku4LLtuS07NIwGxC2JJuYnTep?=
 =?us-ascii?Q?YYlwu2YmBKJ7x0qIuT4YFFfO/JKfRqpAJpg6FhoVAg3aBrTpFuh73JNZ42Tm?=
 =?us-ascii?Q?uMvQ872/NvNBlio=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 17:24:35.9741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dffa8c-ff47-4e1c-558a-08dd785490e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

When an APU exits HW sleep with no active wake sources the Linux kernel will
rapidly assert that the APU can enter back into HW sleep. This happens in a
few ms. Contrasting this to Windows, Windows can take 10s of seconds to
enter back into the resiliency phase for Modern Standby.

For some situations this can be problematic because it can cause leakage
from VDDCR_SOC to VDD_MISC and force VDD_MISC outside of the electrical
design guide specifications. On some designs this will trip the over
voltage protection feature (OVP) of the voltage regulator module, but it
could cause APU damage as well.

To prevent this risk, add an explicit sleep call so that future attempts
to enter into HW sleep will have enough time to settle. This will occur
while the screen is dark and only on cases that the APU should enter HW
sleep again, so it shouldn't be noticeable to any user.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/pmc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index d789d6cab7948..0329fafe14ebc 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -644,10 +644,9 @@ static void amd_pmc_s2idle_check(void)
 	struct smu_metrics table;
 	int rc;
 
-	/* CZN: Ensure that future s0i3 entry attempts at least 10ms passed */
-	if (pdev->cpu_id == AMD_CPU_ID_CZN && !get_metrics_table(pdev, &table) &&
-	    table.s0i3_last_entry_status)
-		usleep_range(10000, 20000);
+	/* Avoid triggering OVP */
+	if (!get_metrics_table(pdev, &table) && table.s0i3_last_entry_status)
+		msleep(2500);
 
 	/* Dump the IdleMask before we add to the STB */
 	amd_pmc_idlemask_read(pdev, pdev->dev, NULL);
-- 
2.43.0

