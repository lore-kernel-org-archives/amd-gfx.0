Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D97CAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 01:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7415C10E0A7;
	Thu, 18 Sep 2025 01:33:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ixJ86SPo";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A0310E0A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 01:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5OZYbbUTHSZXN3I3NXCq5y6AcycI3MhLKv1sBizFvIgAxDe3xGo4hTT7SMM1tDxrRb89E55jtPYUzpr+Lzjdi8JGa9hyrLxrhgg83hcvAaJF6WF/97zFhX5U8U7zJ2UpaJTC5IMMmcPKnUtAxlvYHIu72J5d9gO/Y9+ivZ8Rh0ZWuCmopUfifmFx8mxUB7j/D4C6kAbTziO5KipoeUPc0rBQjPJ5veZcM/cQnr8v/PyXNI6LTAW3DR0ArRrsvQeiBK4ExlP4OT442S0EqfjlIcaa3p61GKOdytgS0HKtg2lEH1zlse9rTSwcEwpmGAreY/04ygaU+uUINxS7ldn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKv9wz9AtoC3NAHPxvgq2AdHf9mVivk9fSer+hqK/0E=;
 b=MeXFbgZ0qa4OCJ07Tb7GqujKB4gFKzT3vMUfmKj6/hLnbfKueWWNMmMxKRMI+4B+3RDAemJievVNQxcoydiJRJkPRrkpGwbJnkDkx5xgby9I1n/9ZD+7uQ49JpFg7Vnw+UoIZNMTSQpl4jFAEccno7mrb7hq/KYoV/fsH7s63Ylcy922kGoTd4ZJoYiXvISTlVlwjzg7gCZwW7rHZdfJ0J1T3gC3EEuYfsl/z+ymm/Z8KHpJakyEj+WcktCpDT+9LW9R/qVEJDG9rMRve4PFPAXG0YsFllO+xGADPB7OA5NUStQUrsKzWbAZX5K9hG+AjKJBgCviY21GbzFQ8725pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKv9wz9AtoC3NAHPxvgq2AdHf9mVivk9fSer+hqK/0E=;
 b=ixJ86SPo4WOi6u5CSLhgwyQWvYz/gramsRaWpvytIHm6K5dpT+/8TVq0gAo5Nf2tAX++3jbJXD7DZ/CPVNQYAZNJIV5hC3jcpHEx3qDG8PTA/LYK5ec60xZS2mqldO/JEvAnnXeHp8KfRclm6K2OQe9gzrsV4w1xSWQxoYcsEnA=
Received: from MW4PR04CA0237.namprd04.prod.outlook.com (2603:10b6:303:87::32)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 01:33:07 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::b3) by MW4PR04CA0237.outlook.office365.com
 (2603:10b6:303:87::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 01:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 01:33:06 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 18:33:04 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>
Subject: [PATCH 01/21] drm/amd/ras: Add unified ras core folder
Date: Thu, 18 Sep 2025 09:32:12 +0800
Message-ID: <20250918013232.2629215-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: f77dae63-eaa9-482a-3fc1-08ddf65351b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZU8wvKJuU7uywgx7B3lMzmWyD09/Zs5Js5x24+KsbpEvV4yKMB+e5uzuh2CE?=
 =?us-ascii?Q?dCDkQc72h1yWTIBRB9aVfeeZcTwtpVfwmiqcHOeqAG/rQeLGC/lg967CTZyd?=
 =?us-ascii?Q?CvEIQSK32Dhp51k28xiiZWVzexGXew893xk10wPTst43EPzGPnEqza8KAwyR?=
 =?us-ascii?Q?Ai1e2oCxVbGXBI0+yuMpI6CRU3gyDXHajWJ1ryuk6sr9hJ1lA+vSeYLY7qbW?=
 =?us-ascii?Q?js0pp7dilOdSwhtQcbu0QwAyTfbgje0w44UtJBNnhJoe/lTQE2L4/8mTNIqc?=
 =?us-ascii?Q?3qv4PXmbNVBorSur9YQ71zhiVUhqs4zNOhR3tiIjugbTCM7GggikL32v1mTk?=
 =?us-ascii?Q?yZPEpZiJP8+UW7GWJo4wafjEvi15nnGtJ1W3tuSabxfC5I8DNnStSYpkvo6m?=
 =?us-ascii?Q?RoD3QEZ5OmF0o169hPeFtdEEBxJ5/X6URzyboUW/cLOyl1lbLeLLgRc06bH1?=
 =?us-ascii?Q?Wvz0dOJZh91Nc5PkI7/tW6kbusIXUibd/DF+I0vv/QM08ajac7HErOdF1JZI?=
 =?us-ascii?Q?+8iZ4VnRLKQGxyR8tmpA8A2iskv0tzgfP6ti5KWbaugjRBZnmc4NTmOGxH3b?=
 =?us-ascii?Q?SpiU2eJg6fRiFNHf03aqs/uRw9nYnkvXePtf6BAW6RKEvQIlzRyvyTlfMg4T?=
 =?us-ascii?Q?AWIhdnN8C19AQG5vMVq7nijr4ZgTJyRAaE6BBWjMXomPt0E2ow0xM8UMNiK5?=
 =?us-ascii?Q?pdm8MrDoHCcvWPCh3ZcvtcUvuI9hqhNSRYbwDzyrZcs9Q6zKyNSaqdVlCBIj?=
 =?us-ascii?Q?wYVUHpYZrs0KtMFpvbGd2b63iuRFAAzcMrBnjilbTknP5keKZwNa7zcIAjDA?=
 =?us-ascii?Q?OfzDSaIWmAWV2HbD7Vvkt1rF+6k80YPxpj/4K+UnYpu6QsjI0oiuL5YYfijn?=
 =?us-ascii?Q?9VvZpD3P9y/If7CXbLKlNdkcuJZuTcIYMidMSjvv4FaRyTZPjrLnzxkZcV07?=
 =?us-ascii?Q?uSCtsTT0VgJ7R9Ep43+S0XEtowcyPec9tXz6wdpg1uRm04mbhVkhL7D8iyLo?=
 =?us-ascii?Q?B+hQ8kD6Dhtt3MnbP2zBcHJizN6lAKYqk2c0hkYW421lIQqDeY+V3MOarwUP?=
 =?us-ascii?Q?uEpiBVhaI9Twq9QbhTFjFLtWCIIfxBIs7zTGA8hPmd3mZLvv66wS4NG1G42D?=
 =?us-ascii?Q?CQwTkZbUlZAyan0yYT+8b3A76gashRxsjQf3RZ9B7G8EUMLUsK63S2aoyDPZ?=
 =?us-ascii?Q?8SGktgNBR/AH2uHZ4B/kqtDI+KrKfgaqemCsJ522nM65XvnMYag1phQsEe9U?=
 =?us-ascii?Q?w8iv+TvWn73DFnNMW2hRO5t0uDvz9KXYtoioBw73qvJ+HADxqYxFfTfvWUe4?=
 =?us-ascii?Q?ciXEFTfDLvvCSR011tY54YULS030r9kSgs6UJnFGFWx47cYJ6NkA5wIfCu0l?=
 =?us-ascii?Q?KacgeTklj74TWA9VCCVGxIEELKp+St12mcTfLsRMdA2otTaX34XFtNGVLP5O?=
 =?us-ascii?Q?rLMvKyv64ojdX5eg8YZjvdAHAJHdmpxprWj3YvO8jLQzkhFWVBr3Tqm3z7HJ?=
 =?us-ascii?Q?Abi+6JGNUzTwfyPxIjPS/Dfzk8tdnJg3bL65?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 01:33:06.7346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f77dae63-eaa9-482a-3fc1-08ddf65351b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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

Add unified ras core folder.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/Makefile | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/ras/rascore/Makefile

diff --git a/drivers/gpu/drm/amd/ras/rascore/Makefile b/drivers/gpu/drm/amd/ras/rascore/Makefile
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.34.1

