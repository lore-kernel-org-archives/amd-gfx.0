Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121CCE6B278
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89F310E9C3;
	Fri,  1 Nov 2024 13:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l6L18iHB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35BC110E9CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usCv4rm4OZZyU8qyQMuZPYGO82qb0GH5OJUypJ8gCZIYfGYsgBZIgLk7W+/e+aBeTGdrpsNmgsHqsBTs0KRy5sTlCEcn0TgH0wheEYNQG2muBlOU9SLu64rqqUQqMVW3CB4TouAjEPo5RJQWv3pQYTyGpGCS7nGloWKBfZ6DoWiuSu4QqkGjuKci1qkifvP/ihmBmEbLs5+gjkBBVM8Algt1S0lvAHYCTrWq2VkWSynBCCkdE7ap/AN2SptsxsanN/UIRY6aOilc4OqAzMSB9lXcXdpgybiVwERDiZhDF/8nqOuJCYKpRnfHk5DI9+Wuu5wCJH1oRka4ToBvxvG9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WcK1a7sMBYTTjRzjfcw6WG8oOglunwkGey07Ruh9HQ=;
 b=g++bQ7vStHjZL+FYInJgcc4aYwteqTRd8af8CcaIAblXf6Kt+bzzWFdO7y1I65LHNxZhL9WTJXFUHtMOQQMkF6OHiHcxj7o7XTZXvMELU0qxH7UGFYYc9ciJJTVmkh50cL+F6+XC5DmVcN/xzaDzuYr9CVQWYcLTNqBR59gPxDcN/QAWJnEKLSDKGadtr/AHtPgZ56SiCfIFsR1cfVMd57fdmx5zfCP1HNFA5oyOC6vW6zj8Ay8A5gKCQz027c2Afbuf750F0sei/lS1MEzjDy5nqRnzf0rQ3exIeWlTxFjxPvqJlLxqlVNaLQELnl3og8kmbSuch7HJBYGFhteBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WcK1a7sMBYTTjRzjfcw6WG8oOglunwkGey07Ruh9HQ=;
 b=l6L18iHBrh3T/BnnYpZyzVEY/AqvqHKoRppPUuVSik/1cV0nzpkwX7l8B7d5LvAqDZ7wEJt4j9BTDjq18LaFanWfrxNxmHI5G2hBfPUIkgBUCD8StcVxWAO9VvapZLBFpw8dGfvFvq1Yxv/GzUZz93/OLU4pmr7B736VlH7tjqA=
Received: from BN0PR04CA0203.namprd04.prod.outlook.com (2603:10b6:408:e9::28)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 13:50:19 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::33) by BN0PR04CA0203.outlook.office365.com
 (2603:10b6:408:e9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:18 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:16 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 11/17] drm/amd/display: parse umc_info or vram_info based on
 ASIC
Date: Fri, 1 Nov 2024 09:49:34 -0400
Message-ID: <20241101134940.1426653-12-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 0004a07b-02db-476c-e8e4-08dcfa7c1f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v5jWPmFmdXrMMixAXclXrxH7VqYyrn+48Y5o/IC+FE3ZqoV6ew1HNB557+tt?=
 =?us-ascii?Q?NKyemsujN1t4df2nIan13Is2cnNSNPzLwxKlrCt0mVYim+rekUCLD0XAzN7Q?=
 =?us-ascii?Q?fkfm50aP4hEyhuC13xrdToDr/B504QIeVsMsM/L46PuQJ9uotNIbSRHQClxh?=
 =?us-ascii?Q?pGeAJ7FWfHPi71Z06spiex/Ily8bF7DDYXC8b0W54A/ULVo1d2HgmIuj/ZXk?=
 =?us-ascii?Q?G3ZDVD+CV6lwRiqhmtBrHe5kb7tCsFRlLEmULW4ECV4OQW9WSYWEWdidcw7E?=
 =?us-ascii?Q?wdVC2UG8c48xxWDVvpE2Tfh1D5OJjlMzP84WtXOk6OXt+E+IYKQ3nSpF5D+t?=
 =?us-ascii?Q?ArhAwzQ1tPWJILP257q7zTr6JzMAD4lV8hzaLevM9DKOxeDwRgXvHPmn3cmP?=
 =?us-ascii?Q?F+Dci692diEiWstV69xwy5193xtmMTjTqrlR/IolNUgo+hPds2bGlaQjQdQf?=
 =?us-ascii?Q?txhc42dh4SrS7QvpI4d14EKOBuju8pmN1R0LdfJwFJq+1dyARsjEtcybMLGu?=
 =?us-ascii?Q?98+rVreoqIq6wRJC4EzdNrwXoGyTtcWGQw2Y2KZfiL4WAdba2dbgFoLio12J?=
 =?us-ascii?Q?NQJcyeI2xo1EVpA2VkCd5zuETDPwdS9oQ3ExGQRv6YpqWE6Ad35aZzi/Xc+n?=
 =?us-ascii?Q?xNOK+Bq82AGX+aHc79xDSZhl6hOkMjwrXrY2zY5WLjWFogddPpz7Zw2bKeb8?=
 =?us-ascii?Q?zfPTXUwj+JpCUO2ujvf6d/JjOX8GcnL1EMYxQTyzREKOaf8EFGVtnsLc2v5s?=
 =?us-ascii?Q?JiVj8WYi4cuUFTh33jbKZih5v7QlmxcF1RaCRgKhXBQrMb+OkBLtaO3tz5zi?=
 =?us-ascii?Q?Nns62zVXPWRH06aoNrCJQGBnVw+2q1k0vaofIVNlxjy155sTeitTcrrWjT70?=
 =?us-ascii?Q?DtBggao9pfTHE6QGjJA9HR6nzxE1U2IHkMNr3ayGWl8rEr5hvwTLubrzcqUX?=
 =?us-ascii?Q?t4oNwwOtdYCHnD30POOtNQCBE7K94W0GafL82NHqLIpHSldTrZIgaEk7JxeF?=
 =?us-ascii?Q?z6K4BnoQF1HWP1iKpzuUYY/zcgtxYMYbcBu7p2/wAD1z3u3u8eOgKQDDhfDw?=
 =?us-ascii?Q?KVpRoOMpbKZV996d408nEbAWaNRr8soGW52+Mz4MTSc4e3teg6dqPY8jlwam?=
 =?us-ascii?Q?A85rf2sbxXCpvHAsHES/wPnZ6CXz0CHcCyAOVQXJNFZw26IKatDc0/bzT/WD?=
 =?us-ascii?Q?udbVB0P/vcLlqQ28nCrxsmr0XQuDs8TTYtJHbRfgGq//vw+22UnAkVvDD48m?=
 =?us-ascii?Q?x6msrzRxTgi8vMolq8UV7O5QWFYSEWbLj8glAvRXhb+e/i36cmodRXMz6Jhp?=
 =?us-ascii?Q?qblrJBp4HMuLKleAGpj18KDJlP/85w5zuyqbwYCq7IkQhXymB6MNcYcPb5rS?=
 =?us-ascii?Q?9bJKiQM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:18.8476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0004a07b-02db-476c-e8e4-08dcfa7c1f60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

An upstream bug report suggests that there are production dGPUs that are
older than DCN401 but still have a umc_info in VBIOS tables with the
same version as expected for a DCN401 product. Hence, reading this
tables should be guarded with a version check.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3678

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 0d8498ab9b23..be8fbb04ad98 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -3127,7 +3127,9 @@ static enum bp_result bios_parser_get_vram_info(
 	struct atom_data_revision revision;
 
 	// vram info moved to umc_info for DCN4x
-	if (info && DATA_TABLES(umc_info)) {
+	if (dcb->ctx->dce_version >= DCN_VERSION_4_01 &&
+		dcb->ctx->dce_version < DCN_VERSION_MAX &&
+		info && DATA_TABLES(umc_info)) {
 		header = GET_IMAGE(struct atom_common_table_header,
 					DATA_TABLES(umc_info));
 
-- 
2.34.1

