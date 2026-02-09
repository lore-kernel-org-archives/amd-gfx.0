Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF555E81BBE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 13:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908B510E3E4;
	Mon,  9 Feb 2026 13:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Mc2+Ya7";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012053.outbound.protection.outlook.com
 [40.93.195.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE3CD10E3E4
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 13:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+Dtv2Ct60XF71dIfGidt6L2IbHeZ4UEcmRPy3oTzM/ZiHXyIWl3zYlKSBpcYb20IHSoFTi4agZjlHuV0TIWteJi/SPgbxC8s3RBvit2ldbDk+ZtyirsERkav7Sh40/qRZkEOPXhXkrbGbzRtcuSGVuOwwhsH8aSk+0BjS0jriqu3neO9WBrNfqVp6mLjQZmFRRNUcpRqmUFC9l4t0ophDZso9L9Ap/QhaNOMragAkugOufk+NV3suP4kQDVvzlW2jpj6T86Mu16sMpYEoLKXwM3+2/N79EL/oeyWM8bGUjB9EDzVPeVwmi3H+Qz9ON8d7/5yMx20XDIPJ57OkpdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFRL9qHX1itgPsqUjBs1dzpN5IGOm9qJshPan5xuOmw=;
 b=QghwjjKGwatjjvbcTJGPxwThSUS+HIZkJZFQF9yx7GC1KYrWgrTyYlKleDUnTHyf+cMbjCfCj63RPLfD2nsgg96XYxKFlD3rjNlT4L2ietgciXV73TIjSBmooC99NQEL8k5jJQDjqPK88tUcYUtSozF+/GMtklFxLL2dyewbzEr6rHw7TguFsuPKCX9DTTWZvNi+Zm2iQoS01rBlrhPJr5FeoybTRoPj4dOL36Htm7sRE7msfIBizE3yhlg4tfzkd0sbnEHqKrHBGM/TBQCe3DEZUp5JV3zdg1QipWI2h4FcvVt1t3RtXzu5emhTuVM9ZTcKFAfDhVdF2YWoiVDjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFRL9qHX1itgPsqUjBs1dzpN5IGOm9qJshPan5xuOmw=;
 b=0Mc2+Ya7hL+eE0LVtAtEvhOoj819KfcrbI4htV9sMtjE81DxoRwPGkIz7BDXESXqGzC4iyABm/Wsc1M41erZeuZQtk+NUgdZOBgUDCkJZ1fH8AQ+/DaVDDptt+MKWOodz67lY3esflrZWXAMxW2LydAMcb4WawFs9HBWsvAiT1Q=
Received: from CH2PR18CA0046.namprd18.prod.outlook.com (2603:10b6:610:55::26)
 by LV3PR12MB9409.namprd12.prod.outlook.com (2603:10b6:408:21d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 13:04:46 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::4b) by CH2PR18CA0046.outlook.office365.com
 (2603:10b6:610:55::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend
 Transport; Mon, 9 Feb 2026 13:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:04:45 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 07:04:43 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v7 05/11] drm/amdgpu: Fix set_default_dpm_tables
Date: Mon, 9 Feb 2026 13:04:07 +0000
Message-ID: <20260209130413.118291-5-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
References: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|LV3PR12MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 6360b007-1663-4a5a-7673-08de67dbcc53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DaVCHj66tAMyTCx6UPwNyJVjhX9UNWbIiANlLNp8KjkFh3knpurf0bvxcfiE?=
 =?us-ascii?Q?iEGkyxCvLwW0j0YaHLc8keY3BR6CeYzGyc3JUBqqbxF+yA4zJcdYDQ+OaD3Z?=
 =?us-ascii?Q?+JPDE6rCYKwipQB7cPqaukShmfqa+lubxJza1bYDQIKoay0fqR5s2IL2SWHv?=
 =?us-ascii?Q?4A3ldGMrl4gd26wan+Tc8/FA2kqwPvezzlJ9nBPKMqEllNR7zLat0U4YtzkC?=
 =?us-ascii?Q?s+QAfFnfOHQNbAitdeghatocShcrjkTNaqmPRQ+HDZU25dcfCTh2n0VI5uXx?=
 =?us-ascii?Q?NeFUFdiCjcbaJ82D7QE16D60EHWR9Db2/9zSmC1SK/iJfKUYoF+vaSwsJhaR?=
 =?us-ascii?Q?2DRqIIhH8z/+UmxqiZlloUwuzgc0hgWj/GCFjvUaCvVWXuDb2BI47kUr3dCv?=
 =?us-ascii?Q?7Q8fI/rvCdCbmTwGHuNd+3MoExLedHHxODh26CBxEZHqA5xQ8f1ly86xIC3/?=
 =?us-ascii?Q?R5axNFSQvmP4/FMkJH7rlHNxxLuiNhn4EdmgCnH0IE5sR2RNMhXlEj/NRSja?=
 =?us-ascii?Q?KTtDR1jeoMt8H93pNjTkGSou7FS1EGJaEQcILcpSVqRc8w1qKNAA92pHS88x?=
 =?us-ascii?Q?pHDpcWb+yTKdlOmPQk8EEw0TpRFu3UQiAWNzCftTcAJc06PN3Nvqm+XdvEW7?=
 =?us-ascii?Q?78jBVxyYiNSQ6jk7i/3Grj7F+draKlodaOQZ/Qr4wPYI0AX3rKN3MGH42xwx?=
 =?us-ascii?Q?Xec7qIVVIhoSvGE5qWZ/+zYT3fi9D7pvnhkzvEWEVDSnyeG7Hx3+AQA9R0bS?=
 =?us-ascii?Q?UgiULTKCwII8gcJW3B5f69Y+eHGwKgLeUXkECXsFuh8CsM6PrMdtFZS/R+DI?=
 =?us-ascii?Q?YIFQqq6tM4pgXOEJu9MIjqkwTCk2XJIUWwrQDOu+KcxJRgZnHkLFZG51e6pE?=
 =?us-ascii?Q?Yh5j7K8SpE0KOWY4EHlJSv/1Nk6etabw1NGiyv0FSxOjf0gKAI19Xb8HftV4?=
 =?us-ascii?Q?+83t8miHYUxP7REgbU+bvfInjXj4Is6dByq6Bd5syHLhTWJOHQoz+i9zsJck?=
 =?us-ascii?Q?rQAhSmfuGK9mIdHZzCI9Jru2HCWaEBXsa76DOHY+fmLD85A8Zz8Q3C+WikeW?=
 =?us-ascii?Q?0Cyrx0+rMq/vBQKUbRbkMeLIDn3RqmhST3pDIb8PwzJlz95IvuJ6GZsWPGep?=
 =?us-ascii?Q?5EyM/6akjYIRkdsTiFbh1ppcZmbaiEQ7EaTvkCgvIERcxej2vpVo+1d84492?=
 =?us-ascii?Q?n0eJ0z3iZZSUKnDdFtNLCZ4pW3sn/C4UbIHoXIZZ64mzwcx21r2wIOn0MejN?=
 =?us-ascii?Q?rcti9BDp6PMrkXHjRrY1Jms61/Yvvt/er87h8ThwNc7QQSNPjuLTHPvVMe2W?=
 =?us-ascii?Q?jQO1U0TX4ocvz32gwxA9aLqpU1A5vY2J15WbGKj4t4JmvUJV0TNeXX1yUVcb?=
 =?us-ascii?Q?d19nX6NN6WWpCVY1/gRKXzoWlZyGCxWWs/XWKNXeG9j2TfW7aahjooKOnkmV?=
 =?us-ascii?Q?iAQ/s/J2w99x44KBD4X6LhbXGmji51h1obpEVFaJx8ENXoAZiAX4dJw/DrTg?=
 =?us-ascii?Q?0pUOr9bgc7i0j7xapuRixYUAWAi3ieFd9lvC7pzw12Nm/kK79Mt5afOra+2s?=
 =?us-ascii?Q?QtSkxvg/fa4o96y7t+zxtgLib0P+fo3MHzUm6gm+IKdoHEXjMKD2qcRnR3hN?=
 =?us-ascii?Q?p37EtSC3yDFF5WakLMka/nPh/X7372XZvAYbwFNIbxbImNhXjvpKcSaK7Vni?=
 =?us-ascii?Q?Ai7Byw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2Q58Lt3vx1+QUPhXikJG08qyPO+/CKWQHyrYJRmrbkHk5N04RQ0D44koNVnCOfvbm5KTuvutpV8ruThdTYRVwmlp/XXVkLe68sB2LBRhI+YbEur7NokRJp9sVbfg9CVE9fkcdqsWXQ1mCP+qYJZSmvFGLwggrLDK9gtGJyJQ4k7EUIhMY5kWZDySJqGZ5aFvTr1wP3WLYXgQSJioJ6vc1WIgaRxOng31q2B0Mfr+SVdvNDEtFpHneJMLHNzblP6TL0EYPmV7Os1rhnoeCfFuyRFuqnTgDcQOGEnK+BRen033gr3iGSGJOKG2FNtfQG14mKtWjHz5HjNgmdEkqQJFAc2qPDGal+dWYcPQcb9J9FT7FwXcTyInmbD+X0zYcHZQqn35+whU6P5N8Oz5n2xaTXYSXrr6mNqN6zypRzuwxtV1dXydkEWtk1deoR84mh0D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:04:45.6024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6360b007-1663-4a5a-7673-08de67dbcc53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9409
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

Use smu_v15_0_0_update_table instead of common api

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index d7a4d5d6cc8d..37fe4c1bdbd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@ -1788,7 +1788,7 @@ int smu_v15_0_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 
-	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
+	return smu_v15_0_0_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
 				    smu_table->clocks_table, false);
 }
 
-- 
2.43.0

