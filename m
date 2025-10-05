Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1FDCAC5BB
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Oct 2025 01:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 620F210E24F;
	Sun,  5 Oct 2025 01:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ISAQBzDA";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 487CD10E24F
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Oct 2025 01:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNZnAVq2upygCtIqPYLAFu7vKPC1SDGsS2EbYKukCzR8QLnwhGmmFbrjSxsWBTEkSHOaKDM2F7ap806els6r4jRzFtI8fZFzZ7jDpoP1Z/Zr6TmWnOZFZfgJzYY0y+qJVyXewylQVC71odX7KCznt3bAD3KHE3US2mOsR5d0RRFRHHK3yD/CQJ71dJvZ2cN1oXRvQ6eOzp0I6HdCqOxW/W96JFxTEClNYH+nzm7gtOkCxqG8BYh+D1NgVSOb4BhAIESk/5Wt9+h5KccEoPUj0JgmyfRuXjGJSfvsqYexGLUYWFf9OaX10K/UgXiEub/UFGtGik97td5jdXhglTtjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnYmLNAcVrdXd09+cOo07GSAIbrSR53FbcFSS/PIo34=;
 b=M3kFqKJnJGSbR7RFC46UxaaDwpRK0mWX1pdB0/KEAIPrV//LjcYNioBorcawHUtpXgev7gM0QuJtMTPx8NyCH35UrCzLQX8eGNaas0G+CbZEhTRvqL17FeoDzaVGx/rf96mi4PhRLRnIM0FVVoFkKQmIY5yOXAArKSwdamP0O4Ait6P4iqpO4FNfXfBaKdqsisumNyN/eCD7jHvtrlp4AfHFGG/FYNtIdtjp0ToNUW3h73pmYXoYppjvqg8nKwUexBdqhJQ8ynMuQ7PieIw9db70GJ9jfZL5xMm8EBV0mmRZ/w/y5ZUcIKHFAHw8lTtnwtMJJ3DLbjpVwvcuio25MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnYmLNAcVrdXd09+cOo07GSAIbrSR53FbcFSS/PIo34=;
 b=ISAQBzDAjFcZOtNeEcG4GRoGtcnGmM+w0e9ISfP2oiG00SW8CI6/4rl+8VQHIIIF8AZVAIoYEGkpYMIGRJIKKy0T1FR74RdLGHuxldm6vTfA2lRROp/BvpuAYvIaRouG+x2yAWuT2CzabhVQqPLeeBUGIqsz4f/hhTVWm9W/3Yw=
Received: from BN8PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:ac::39)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Sun, 5 Oct
 2025 01:34:42 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::27) by BN8PR07CA0026.outlook.office365.com
 (2603:10b6:408:ac::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.18 via Frontend Transport; Sun,
 5 Oct 2025 01:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Sun, 5 Oct 2025 01:34:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 4 Oct
 2025 18:34:41 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 4 Oct
 2025 18:34:41 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sat, 4 Oct 2025 18:34:34 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Disable VCN queue reset on SMU v13.0.6 due to
 regression
Date: Sun, 5 Oct 2025 09:34:20 +0800
Message-ID: <20251005013434.3801595-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca7d2db-70d4-4c43-b920-08de03af5b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f1S7OsBXy6xHYpJX9i9xHwPL5mwtgW2rIhk9mzVKClT9e4mfcaTEnqqvus/2?=
 =?us-ascii?Q?xuFNG8knU2+9cTvh5RwIz/YguQ61jkNcvIGyAsKB+D9sfAtySxik76194nSE?=
 =?us-ascii?Q?k2OR3KB794eekEPzRRE+LgISaGABF6kEB9knirhyoEMApEgbh/LFpPZwyEx6?=
 =?us-ascii?Q?G/bniRJvozU0DuThS/9shynNkNfojDiWS937B1kQq5KVwVToSj5jQcGyOSTY?=
 =?us-ascii?Q?WbdaEDbYpUYxsT5+3PybpgGXCFRMiiHfdWc4tHMtI+UVuLymx173t7Vi/U0O?=
 =?us-ascii?Q?IrQSuihuGVA7f2K1U86XQzrX0TlFWCQHeJLRNn1r2STK5u6UCk7mzoLGeihI?=
 =?us-ascii?Q?2cKkq7Y/Qm5ERH8lqJ5hd5o70pUtC6JIkvZoY82U1EWZTY0cgxtktYjSgnnM?=
 =?us-ascii?Q?aCp3urLXSlWd57wCcWbvVgtIbcWzTf1XzfmPXiMJkyFkL1IBTYZ3V5XWC74l?=
 =?us-ascii?Q?1yRw+tIA+T2B6s2e+d+aTYWv/6R+ktR/FWQlFtptfmtpqtYwB7hwKLecqy6U?=
 =?us-ascii?Q?K6DPST7HvR7mUae1B4WABUZjomS9uqpysVffhkzi3uZdZO7pWGJlNs29Bd22?=
 =?us-ascii?Q?xWHhoPWWnlsTyYTndjG9XsjnbWMVGjIDkb0idGX/agthMVK0EUazrVBWrKCb?=
 =?us-ascii?Q?0GFTrww5eQhRySaKpSqDY55/MhKKrswskyGGIMPjMbY8yp9i1FUOG1uPZksY?=
 =?us-ascii?Q?hbRwkB3DBxb519KeXDpMuTclxZHogjnE5gUCQXCnnattNjxDqgik27dFkE3L?=
 =?us-ascii?Q?niMWWOBkEJpznpTTbh8tI0kquTi7ihCoF8vXUJNaK0KyAa/CAgmh3IxQdp3L?=
 =?us-ascii?Q?x09B2Fhs0g93pHlqW8kt6azHmzoMJJuBHRk2+uy87BSXrT1JIWvimoEDs+P4?=
 =?us-ascii?Q?2XgZTRGxPZnR5qFnY2U3VOJc4BS6BTzZVpztRTNQAURxtIIBh50+2OxFzcbI?=
 =?us-ascii?Q?mJ+PhuI00ixTENnGsNyJWzGOrRU4uB5OMjSKt6F1zDhzT1edI/aDeIzqvrfb?=
 =?us-ascii?Q?Z71mZN/ob/PpvUdJSQbGFCVrdNWimNHOLs4d+c/ln1tMawKctT2pSUMZytr7?=
 =?us-ascii?Q?r1s4icB//xh1QAdgskKMjIuWR/yKWLXmWhDuezlLQhBc0q/71ACDOHzBdNKu?=
 =?us-ascii?Q?nzlMp1/7pbNdHy5cbm4yH5VcyrQLcrKeaAC0Ste2mTz/osk/Kmy7j1Pe9dMc?=
 =?us-ascii?Q?c//r7yeEz8BkAQCSpMr20jdbI92zEitZJYn+CnzR6BuxDeER6AZp6z/gKYRn?=
 =?us-ascii?Q?rLY5pdT88H/6yISDvrx1uxkc+32yThV/lgFY4byt1EOcOU1dLQ0Bos85WEtz?=
 =?us-ascii?Q?SDccHoAhCwMAw1I7QV7DiBKn+M1f+99N+LxUyLAiq2xyhHM617+1YQUNDrRQ?=
 =?us-ascii?Q?LyH/9DaQAy8d9rcWLXLlLG/cqeDiPNUVmAWJKmYPPlVqsJvHQplyJc90hgcD?=
 =?us-ascii?Q?/pPoHTClMLdl/XlTKrdGTP+QTZChjtCjbFbFc2cVuQaY0y7CH+Z7oYG2oy4f?=
 =?us-ascii?Q?4j3SSBY9u5BL0ff6y2M6Dd2wpymDdoH+jqCw6rnuJh7nPBgXnBnBJKIw+6sP?=
 =?us-ascii?Q?uue8xQ+AtQwPiejJiP4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 01:34:42.2605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca7d2db-70d4-4c43-b920-08de03af5b88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
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

Disable VCN reset capability for the program 4 as it's
causing regressions.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 72ca6302da63..285cf7979693 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -450,8 +450,7 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 	    ((pgm == 4) && (fw_ver >= 0x4557000)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 
-	if (((pgm == 0) && (fw_ver >= 0x00558200)) ||
-	    ((pgm == 4) && (fw_ver >= 0x04557100)))
+	if ((pgm == 0) && (fw_ver >= 0x00558200))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 }
 
-- 
2.49.0

