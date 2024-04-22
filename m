Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34300C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A5D112BEE;
	Mon, 22 Apr 2024 15:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ocFcmtEn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0354112BEE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNWYdEBEbK0iXffSoeLKnI8CuV+N310DwYyO3/4YQfHsr+5nVOb1drbPZj3aCMoqEcCplPqlOuHRfZ2K8aHYrPkSgDYpbOom9vR4YfHy4y1onLwvuVqH/d2bgW3qGMR4kuvV3SqqaaV5THHK79Qt3b7FzbrUnTJaqMrghPrSFzp+/70SyxJSljGBhbtUwpVPXMHg1Cl0fKPBEiSOUkcJvwPTcXLK4Ya2SJZguC4NDmCr75e3nf3v7+Tb+6FHnKfbl/BKGinFWUtYfccJoohi4moL4t5pPflgNFK8mnu8TUycPa8Uh8qjZ/5is5yqdWDX6N0+SGq9ECHQhS/VvRNnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EK9aPOWRPPxtnXKKs0zmXhWaADy8ALuBMsTCK7SbULA=;
 b=OWFbdNbwB5WPo3W2Vae6qvSkLm7Moc/QHYYTyu3auwm8ciBtv9Bv2PBsmyGDaggPJroqq3beWXczhS5oHI5kfqE+tSWXcCYZ1MefRLfyAKxYgrB50JRg1IJJME2gIJI6AZfLVq/NtRr4v2WDQK0ghExZBi9ybchCAK40tSxw1hlYWFDWiV+ILg0nvOQVdSG2fbB6K3yef9nQtbJCqvoP1lUsYY1ygnTOtO4WaZA690l22kzHLu43pqcPj+7JctyLLuTU9GK8PHQ2zsKJtfuVlS4un0A1XO8074LXMgf8yz0Tm14czS7x0XjA36C9IpzKcijos+vMV6KILiPuyS3mAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK9aPOWRPPxtnXKKs0zmXhWaADy8ALuBMsTCK7SbULA=;
 b=ocFcmtEn/6WyHG4V6uv2Nz5yam87Ovnx+5wo0Pl4441n3vMzt5l8xIwimSWWSSjyiQ9462KQGw0T/qWMp8zQOcOYxxNeOkXorG+bkE9XrQN650XS/rD72Q6Zt+z1p+iR+jqDRPVQNuuZCtyRyzYrfaZw3sLP2XhFeGAZA7NUs5U=
Received: from CH0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:610:76::30)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:11 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::2a) by CH0PR04CA0025.outlook.office365.com
 (2603:10b6:610:76::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:29:09 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:29:04 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 10/37] drm/amd/display: Add some HDCP registers DCN35 list
Date: Mon, 22 Apr 2024 11:27:19 -0400
Message-ID: <20240422152817.2765349-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: e76950bc-67c0-4ceb-1129-08dc62e0f58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?snN+mJGzEKr2dEwyr6gbpmdkpfUeRXMIS1LU5Rx5jKM6AZ3aVfysQ4mfnqL/?=
 =?us-ascii?Q?j0ZyuT7Bi588wvtnl9j2CO7foFWvZZbH6nbOdvAJMqkLCbPjbgBYthXjS3hD?=
 =?us-ascii?Q?I4jneJN7iGGuMmVQkfpn0Ll/qg5bZX4rDdnGAoNuc80Md9SQ6bCW+Jiv2ug4?=
 =?us-ascii?Q?EJBvHn65HtquM//d5wVO6Ca/mdUW0CK6igUPO9vMxkNVwYQyCv7SscO61uc5?=
 =?us-ascii?Q?xoMkRelqk81rrOALa5i4MtfwoDbGZhhLCbk2VAVe8QbhIHna5zT9UNctlIEW?=
 =?us-ascii?Q?GWLUQq2hJMXdq3q66rVvS4AANuGVT5wBiJdZ1X7qB/skSdHGz3yJRB6MtC8Z?=
 =?us-ascii?Q?p+tCkmbQZ3LQwZlnpAfJoAD5W5fBMJ4KZBgziTs6u9fo/+nkkg7lnyXmeTTX?=
 =?us-ascii?Q?ofkmkcTxk6cYh8vum0gQCwJNKfFJdaIkkiryU3xPKmBz+O0LOPMA40j21btw?=
 =?us-ascii?Q?HS++6oBoGCQm1WCMa4O8b4j3wB8qjxoOldeJ6WFcK0GqXLh7bTf1BCNTH86t?=
 =?us-ascii?Q?v6i6Fe5zwklYIAgaaznZcVcKuFIUPvNoDUqz5bT+iT8m0gqxuhHvm7ZCVIJR?=
 =?us-ascii?Q?wQzLeOZGZwOI+rEX1i7kZFfSrerJ0q51aGxMOiuiJExdSSGzZC3Oxu1M6Qqj?=
 =?us-ascii?Q?amusWX3m02fUWfnd7gy95QRyocRt1Roq5unVWF19ldXH6LnuVOyjRWQXBQCm?=
 =?us-ascii?Q?Ef6QEWn5m4Dag42dlNvdMHt1gL9/9lwcUzfC0s8PW2bt3lqL2kGY3OGKJp0x?=
 =?us-ascii?Q?Fiz5zk6C+/C76oPs03UdSZbUvIvRnqPv9MQUXZWNF6cr7GSJ1+rvcp2jyKGY?=
 =?us-ascii?Q?C4jaGUlZA1AXRRxfnRS43kOgO+LWiYvnyACr8SLWp2MqfrJ7x9EKz/T07mnp?=
 =?us-ascii?Q?Ad/scVJ1qnYG24T4mOYDgXT3ZuQjCpGBICmdTTxrJl6IMYcbDqwfYuSD9cOt?=
 =?us-ascii?Q?DbBn0jIiKGYvC2Y+Wx/QpoNECgSxsNmoeYMB2M0bqCa6dq3LGNwbwTvBrN+h?=
 =?us-ascii?Q?QYb2yPPooXxhLKa4taOl9LI0DGgv7HtawpIcT5eMu3bBBfW6fEhIi3jPSCta?=
 =?us-ascii?Q?PTwq8iqjb86nbxWM4DNraHYig3B1iZNSw+KZuBaCgqKI7i5LvGF+20lM1KMZ?=
 =?us-ascii?Q?nwO9muKnBFkgaT+TWNExMGeVDzbclQxVNOdIu1GE5H0uLXwusyz+pU+yhp7a?=
 =?us-ascii?Q?2aT1OU1JuqW828fs7RE6eRz+hOpHlYt32mk4OWJrfKA60zaDTqSyf+8YqRdY?=
 =?us-ascii?Q?q+K4tX5E76jWj5/ho4e4Go4r9BOi75XYa9r2wKdd2JXuGjGKyUWmDsnnmI1I?=
 =?us-ascii?Q?IPcpsm1iJvF/LRxklPdlf79IhDkoExcXfR6Dq/7U5TIjH1IP7jueuRDIZvYs?=
 =?us-ascii?Q?NYBzC5933IOpWPtCHdsJt5uTJ/A3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:10.8214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e76950bc-67c0-4ceb-1129-08dc62e0f58b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Add some missing HDCP registers to be used in DCN35.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../amd/display/dc/dcn35/dcn35_dio_link_encoder.h    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.h
index e1e560732a9d..d546a3676304 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.h
@@ -37,7 +37,9 @@
 	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_MODE, mask_sh),\
 	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_CLK_EN, mask_sh),\
 	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_SOFT_RESET, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, HDCP_SOFT_RESET, mask_sh),\
 	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_SYMCLK_G_CLOCK_ON, mask_sh),\
+	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_SYMCLK_G_HDCP_CLOCK_ON, mask_sh),\
 	LE_SF(DIG0_DIG_BE_CLK_CNTL, DIG_BE_SYMCLK_G_TMDS_CLOCK_ON, mask_sh),\
 	LE_SF(DIG0_DIG_CLOCK_PATTERN, DIG_CLOCK_PATTERN, mask_sh),\
 	LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
@@ -114,7 +116,15 @@
 	LE_SF(DIO_CLK_CNTL, SYMCLK_FE_G_GATE_DIS, mask_sh),\
 	LE_SF(DIO_CLK_CNTL, SYMCLK_R_GATE_DIS, mask_sh),\
 	LE_SF(DIO_CLK_CNTL, SYMCLK_G_GATE_DIS, mask_sh),\
-	LE_SF(DIO_CLK_CNTL, DIO_FGCG_REP_DIS, mask_sh)
+	LE_SF(DIO_CLK_CNTL, DIO_FGCG_REP_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, DISPCLK_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKA_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKB_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKC_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKD_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKE_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKF_G_HDCP_GATE_DIS, mask_sh),\
+	LE_SF(DIO_CLK_CNTL, SYMCLKG_G_HDCP_GATE_DIS, mask_sh)
 
 
 void dcn35_link_encoder_construct(
-- 
2.44.0

