Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829B9C36000
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC0710E30E;
	Wed, 19 Mar 2025 17:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZEco2tUW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870D110E278
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/ASpRzIdY79+hC7wlvmSqtjHpaMVQXPMCOu7jKN2lgGa3JHyOua3SsRsYBYtzqH1JGBhrPRIiqWFuSbG1cs4Hb4llSXPm8iyCN1RTIVKNSI+U5vxxjAakxiiafvbnp5MwiT3qVlbTv7ZHYcWAHuMQkbgtc5X7tssW+vU9GaTorVWBJmHhFHrZkbLCAs8jeuN4b0nt2f5S6RTx4N+4L15W6uzudXa3iGDQkHFSqlbeKnJlhE/Z8Az/B2YjsjfSsrX5ofqJSxjWkgmpsIk+1NPH9IHUK3ObU4FX8LWlpl0eWhQixDF12k7DFo947QL9xJILnsQHeEcC39SiD5g92kwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dko/HO3LvXl6qNdIayAcu7c9L65AWULDaPCf98BWRyE=;
 b=Euj0yomFbYyJAQh5o8ISGqLKYwrDz/7Yyqm+avYbEW15oF1ujswmOqvlvta9TdtKNFYFyz7Nu8T2Mpc3oVgX+jvEDRGMP0azdxDRlOZYblHb270NV8HG8Tpg9Lca9wTmVCzxwcjyG0MhsAvuhy5egw2twsJyBEamErvbNgJpGYstP6gfvwQvp569tlhDM7eE6DA5TogvnTGyQ3RHfRlOo/weVDPoBS2SVUXamj6B/j5ipJIkT4XMQwu5Hlu5xVQl9HOMpxVmR89KL/DKG6Ypdg1GJ1U0dN8DDcbFvGghmdXlaVOyuW9oa3Nk/3jIcEkW16jZl0coJ9/D8DbhrooEVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dko/HO3LvXl6qNdIayAcu7c9L65AWULDaPCf98BWRyE=;
 b=ZEco2tUWAM5OhAW8LXlGKqiRmJFq4dlnwGJ2/3u1wd8PdIVaCWYYBLqiJYVj1Mvgqclu0xJgst0F858AM2wF7sDbHbUj/jrtT73s+82JEt7ZX5WT6/bgb8ua31DDEle3fYWWLNGHo+0wRUz52n1WbZh7hL7+uCqpXrSZEtg1/bA=
Received: from CH3P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::25)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 17:57:31 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::1a) by CH3P220CA0027.outlook.office365.com
 (2603:10b6:610:1e8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 17:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 17:57:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:30 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:29 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 16/16] drm/amd/display: DC v3.2.326
Date: Wed, 19 Mar 2025 13:55:21 -0400
Message-ID: <20250319175718.2578234-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 42129344-9503-47e9-0078-08dd670f8501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qlm6SnI2WHzvwrYg6oB+8kGq7U9VhF06ks7gb7VfLveHUXBj9Po20wa0fd/O?=
 =?us-ascii?Q?pwN/zs/BChemI8ISQjuO2nbS6GIgZTe3/0+8QkoYOlGEh2/Og/koTayDnQiY?=
 =?us-ascii?Q?WrKFZJB23uF4voDsrL95FwJT86zVDcjItFB6JkhoxBbnuHQcHuxaFV8ZxSza?=
 =?us-ascii?Q?NNrpRsQd925eYvgqVPd4xEGK5Igy48rTo8QTUJkswLIqmLrThT6bZmjS5fAn?=
 =?us-ascii?Q?kxEzO7yk2vUXn1FmTtJUm5qKIAicc0n47An5yJX+mkrLKNtNGFRfltSKbsmw?=
 =?us-ascii?Q?jO2EqHM6ymj4LUGDIChC6OQblThI9uPtBoNdl6ex5aHOtDjK8bnAy1sUa7c9?=
 =?us-ascii?Q?Sry6g6CpL2sYcvxqCm2GF454q9Nu/mdXDaUKrAu/BvaR0EyK9h7KG5qRDAaO?=
 =?us-ascii?Q?WzkSt7teCtCigoNkzTIERyQe/t+i3KRFeyx1GvVWl3J0U6gT7en5k20JoRUF?=
 =?us-ascii?Q?lzyHE0dHD64iA+YhXNGRRU28bZ6EDwkE/wIyn6MiFUE4L/xfxNV9GJ4wImeS?=
 =?us-ascii?Q?CRimzhENA/J4PrQPT/SFvJBEpn+Ky9fZoygBxInARyEwj+KYbu8QWm6dK/NF?=
 =?us-ascii?Q?ERdFEp3ZG4jCtLJWffcrm6hmbPp5l9H9/JRw2Fsq0eBGTNO6JQkFtTdDsRZG?=
 =?us-ascii?Q?uNtwePSiTsAHbRgLGbnnBoppaUfj0NbNUR6jZ26BqiQMuRV+eYSEFDKYRHoF?=
 =?us-ascii?Q?pvBrMzfbwLYTGRuYzg07055GxHqqBtRwzzbeRF85mEApf7Nu5tJ+URIzqiXu?=
 =?us-ascii?Q?zXJVopv179UQ8wZPI5a5PtHyMKIeSJYJM9eYsr7XfumNGtSF2UIj5SNijb5q?=
 =?us-ascii?Q?0Bv8LlcfTctt7Zf0VVgwjvSoHAEpEFmrkwLUMs+BoC1CnI4M+sM5hJNbTxcW?=
 =?us-ascii?Q?2MdUueGMk9fcNK6QIqc1I7gWY1IvwH5lzB0vZyZbKO7w9IImyyz4LTWaZYTG?=
 =?us-ascii?Q?ANs7BNevY+S5RV7bsfhaJDaQGKDlcowqhnqtHHUz14BYHBID0OLQUK4qSv++?=
 =?us-ascii?Q?5s4ZJqqW6T6snM4D4n1Hrd88qJtjRzdDW3aHCXY8vNWPc4/Pbt6/9Yzk80NS?=
 =?us-ascii?Q?TotMN5iR92n4js8VYrgZ/sv7DVyPvpdk8YpSd9aETpASlXtaPOUpk2KvZ3fm?=
 =?us-ascii?Q?AZb0jJnCmXIX6NmxjB2mS0ktVlDxjtFmIqaRqP4QmOGwm4eaKz2JguduCgRF?=
 =?us-ascii?Q?xRHtChS2Xy7pO2FquqmRND72X/rJ6UttRZka5AV0TU97B9hX+Yf1jNKwDM3D?=
 =?us-ascii?Q?EDKF4z/jbfQJsdKaWx6WXi7RwEqofa+5j20gHHwlWcp/zPJhlkFp1mc6vSUY?=
 =?us-ascii?Q?0/1Fbv2OuFYvWW5Ne35YggqzjQOuob1Rs/wnWT4EUQtz0XGw3TJsPd4elkov?=
 =?us-ascii?Q?Wu6dEjGn91u7j/TcIqvNcteJ5lsTDZe1CYBd6olrU9mAV19zeUB53MA6akeN?=
 =?us-ascii?Q?srhy0ZJXFlGtXUetjg8ZASiVAhsDF1lB3frKXYqWg+M9aGy2/N3HqbFx0Xpq?=
 =?us-ascii?Q?ZsO1LR4MNpL0VOE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:30.9302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42129344-9503-47e9-0078-08dd670f8501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
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

From: Aric Cyr <aric.cyr@amd.com>

Summary:

* DML 2.1 resync
* Vblank disable fixes
* Visual confirm debug improvements
* Add command for reading ABM histogram
* Bug fixes & improvements

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 13f3a8370592..0e98af9fb9e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.325"
+#define DC_VER "3.2.326"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.49.0

