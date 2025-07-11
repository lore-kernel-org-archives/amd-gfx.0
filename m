Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED0CC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10FB410E9F1;
	Fri, 11 Jul 2025 09:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OsHgjm5n";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9234A10E9F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySWYf8cbsYfCqg/vp1VfKMFbkb95Uo7b8INpIB6nZgpxaHtAjTcN3ZrZzE4S2gZmQQwQNLIoLnR1Y3jbMaPmTa8SJBHVoyMfT4hDZruDXI6gbOxEpvU0ucwfmkRqJ/iPE/e6X0Bx2r9iOK/jFb4XQq+PdA99ErdOHFllygEmd2eG/pIvW4tNs6AN8RCwfrh6S+qhZrH3mcMQgBLVfLAQf1mLJSI8O6QvJCi5zLpM0lyLI1N1gFNRejoRuTGU+cK1CAqOwDp+Yc2oNyjMsGJMgBOHPSWAkZ1zjmW/ZkiGs+hLDWaCRiJE9y+9VilmghiL7/coCwEiBa26N4I6PX/Xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIbLcxteooWLnjDkiNSggH0Ze518o7ClQiZezR4Y6Xg=;
 b=hvjVCk8wc+vKRl7I6gm35FdcsA0K5wyp2iodt+/DIKBVcjbIzARPZTvc1gbIB9LcGCRaHfIAX3XA/Gkk8rtHmIXzjFDwtRuHvBcXoUsVBtDwZgKPFrY7L8yDUIr8esDDJcwYswHeUeUj2DT20+tcu22nrYfZBelvaNyBt5tTHOUDL1LMwDS8OQELopJO7ggt62R7my0yGxkS/7SsxQrBEyfTefSx/tnp5XD1zonbPK1mQ8nLUnhQ2TZrP/AO7+L743uMALXYzBtSU/fCXfjCiKSuP57Z8uRFjHNGnksENwkgfuXiBgqLh6ZUuAJ0uvTyZYVIiWcmeHdmK04y8W/ngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIbLcxteooWLnjDkiNSggH0Ze518o7ClQiZezR4Y6Xg=;
 b=OsHgjm5ngIdDqvUa+MxPlhvXuQSCzFOsfUGYyhC4rYPmxviBsq2//58xgy7a0Q2vvMWnKVi1lh1a4kuRKa5d3Tdn6qmx42puQ8yjC1TxAxMnbSy9uHhPKmAZ3xxNQuTaonw2k5U4nyS5K77sGBXr4uKrvV2OJ3D1yVTlcAila8c=
Received: from CH2PR14CA0044.namprd14.prod.outlook.com (2603:10b6:610:56::24)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.31; Fri, 11 Jul
 2025 09:35:43 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::74) by CH2PR14CA0044.outlook.office365.com
 (2603:10b6:610:56::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 09:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:35:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:35:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 1/3] drm/amd/pm: Use cached metrics data on SMUv13.0.6
Date: Fri, 11 Jul 2025 15:05:21 +0530
Message-ID: <20250711093523.1468431-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: ef73f0e0-1a5e-4f4c-8d20-08ddc05e4e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5PHWdtbBjZ0tpVZ7+Lj3e+VVeyXMnpxunrC8sLD4hhYPhPDJL9YR+7tyLPcz?=
 =?us-ascii?Q?2lZ9yzr2F7MASxKgs16QOIDQ4XtCFqHgJFBazHzOg2WCxQTaiiExZ1B7QnVP?=
 =?us-ascii?Q?u7p8IRqURwsx2vPLadICdzeGXxyHtwxLOd/F7IMg8qfHeZbu/32/giCP+40B?=
 =?us-ascii?Q?VW00hJqDYkbQaFEEr5gF1xj3Rweav0RqSAtGoJXT2xf8xeqpLYPCtHhGjbLh?=
 =?us-ascii?Q?WA0wfRGDPMOO9bbe27yt00lfK+Dn+pQOQk8+70MD9O3RxVS8UtkLp0FfSYZU?=
 =?us-ascii?Q?SfTkhdToUzoQDb1iUj+PHFBKsteYLthDkKGOMjIMWgIP3GgTWPdttgajdzIH?=
 =?us-ascii?Q?erPRNH8uKRlSTGFI47rvwYEdrZvvTjSM/1sayjep8TI8DRmkfQOfWnTQAcL+?=
 =?us-ascii?Q?yFG+RSMamzZLksrhh4OWjrzXDjJX1TK/53FxAa9PUZUYguXFLg5tvgpMKbbp?=
 =?us-ascii?Q?oo+/A9ISuUpf9W77sGBBeNqTnecSMrwf/eM7OyDxe9cG5bmwRNyv3vDRKVCo?=
 =?us-ascii?Q?i3pst+u9+RvoyOaV5zOSmayRGTl0UC8QTzcZOgsZBeAu7b2Osj5eIoV3rF9b?=
 =?us-ascii?Q?f9v9v9ssRQLjclQR5qM0PtllPvBnpuU5hokA8LTOsReQw5OUfuk5+xviKQ6E?=
 =?us-ascii?Q?pBuoWDm1cUVn299T11txU/NSjQWRREub+RlRZMum946kpNZVhbZE+phdstiS?=
 =?us-ascii?Q?/t+lzCRDjGwolm+aSM4GsKOqrNRhx1Qm3npOT7NN1ig5QGmDtfH8TUa2bZO5?=
 =?us-ascii?Q?nTOOVZHG3UWs5Qry3FmGaBwVqVrGgCW+cCzWUPZBWdkyLCAiKr/tvYgjrPFy?=
 =?us-ascii?Q?IjKt+RHyWZSzNdfSGRid9+tk4/ErkzORsazeowejRx8tPNqLF0g9nzkatiLw?=
 =?us-ascii?Q?wdc4DU7Pb01SGaTiuVXyed86d3627/TDINGMT4CHQp4r3qnE6rveF/FrDQPf?=
 =?us-ascii?Q?2SAiokIgVVw3AILv6YiQc6B1R4L+xZMzrtsMQwEMoKaGGt4EBUxBGsRWStJv?=
 =?us-ascii?Q?BWDE8QqWvg9TJvwtsaHiTjX6UqiR/z1r8tD4FhGIXGaLQQ+Qi5Ydm+auXevc?=
 =?us-ascii?Q?nQtAMQQJoEcxIDVWPZuPCTbWeiGo23Gm5YQBG+CkcxamyPaEOsBhpe51KcE4?=
 =?us-ascii?Q?OcCSGT1lsC8b/0onmEnwRvG1i0YMSYuJDHPiGv91BrIr8EzZK+6uikK8hrGq?=
 =?us-ascii?Q?IInvQYMgTPIPkNlT7Lg9Bg1To0VX134Bghcu7AyWXermgMW1to6G02jeXdk/?=
 =?us-ascii?Q?1rfRdRY0FtCgk+SaXRx4tCQ7Utsy6J4ArVr+uYRv3JlJ87xWpsnjdNSgUVdS?=
 =?us-ascii?Q?KZhOZOwhw9Bki1Sfo95n9o+aZ1P1uxTb46LnTvavcfRAbVAvJcEIyQMe1NuU?=
 =?us-ascii?Q?IWk9VKyn9fpsRdJpe2e37u8xjnvdhfgJXO9IhIrAEH/sN/DVkeINY/5NEKtn?=
 =?us-ascii?Q?/hx3qao1WlB3dnuTZqXGz5th+ebf86kgI1V2HO/Hl3v7bRNq35LBvOV8VKNj?=
 =?us-ascii?Q?fc2Hz3i52rZbaKTESnjhS32iUuY987nbmsPb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:35:42.4670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef73f0e0-1a5e-4f4c-8d20-08ddc05e4e09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530
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

Cached metrics data validity is 1ms on SMUv13.0.6 SOCs. It's not
reasonable for any client to query gpu_metrics at a faster rate and
constantly interrupt PMFW.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 68624afe7d83..0fa8652b603a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2693,7 +2693,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	bool per_inst;
 
 	metrics_v0 = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
-	ret = smu_v13_0_6_get_metrics_table(smu, metrics_v0, true);
+	ret = smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
 	if (ret) {
 		kfree(metrics_v0);
 		return ret;
-- 
2.49.0

