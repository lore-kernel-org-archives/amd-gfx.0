Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7B2D35663
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D003510E5FF;
	Wed, 28 Jan 2026 02:00:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DnKVgePb";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6183110E5FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:00:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvF4ktnpbmcAF62qH5jnwfyUWn3JwT+9b5GsLLya77Ft73OfLD0DSJWGNiX+v87/R61Q4kqBU3fmwDRXdMsxwLVNj9sEOnvGcr7U4iB1I6FYpFsTFBxPp38YH+43T4sqkJDe+izUjEG8nE6yirAK0agFvny5YdfoBWBIAnhlb/BprkCnfCXssJWCUN4WyJVto1DEH0ljjPxY3ESuXCXGW5jyUaULQKj4flYVzzaXoCsIQG8uNOk/b7jlLftXvrBSyR5+0O/Wgci4v+GeJaV8IWsSB8H22sEYj6i8Vn+Bu4sfRzh6hVE5KPwu9hTerpBWetSIxrjoyL3HKbbGW6IpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kC4bbY3xRxRZkrYpPsFMS3VF6zo/QYzZWPtC4Eip2V8=;
 b=exnrdSGrQeG0iKShJ71PKD2tRgEW9zcaKy8SLFxCCy7Hl+E7p5uz4HYOAuX+HX4ZbIJSWvyXE5jknAix18HBYnUxPjCdE8knyqbjKEp/+VZIiTha4gzr2r/f7+/Hn1RKY5YftG9BM3txuX60X8c4qN4JOYQMNc0oVtWD/TJca4fLMEAl2lBBiEHC9cZcXx4++Uv6aRnM7/6aNZVwSqyts8fkBRs6HzMJBRXVA5bh2y+f5CmAQeMks0cyZHVjHiHQeE7AS/wgYZB0SPyWlOj2nj9mgo0kYt8sfvroaQPhxJdTnBsTUK/rI4/mj9wYiSQmDkOkqoYaguQFpRgp5MEHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kC4bbY3xRxRZkrYpPsFMS3VF6zo/QYzZWPtC4Eip2V8=;
 b=DnKVgePby1ATaG8V6JOnjgBTxT5sDzW7jdesgQ6MJEqSPlttmsXNsxaLtlYEINpezaMjOJ3wvXdtM8vTYFKowu7l+Jx9CnP+KNQCXfjL6ikcANDs3bAX0TvZdaTe47eht5euKzTGL3xRNLiWrTN8Zy8O6OYldjNFgCxIjOcmKEc=
Received: from MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27) by
 SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Wed, 28 Jan 2026 02:00:48 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::68) by MN2PR01CA0058.outlook.office365.com
 (2603:10b6:208:23f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 02:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:00:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:38 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:38 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 20:00:35 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 21/21] drm/amd/display: Promote DC to 3.2.368
Date: Wed, 28 Jan 2026 09:51:46 +0800
Message-ID: <20260128015538.568712-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 59eb5494-7001-485c-b39f-08de5e110e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y0NZsgCSH4Ms//dTraRRwBqTuksdg1ngIUix1qeYUgqvPH7Qzql1WygItPub?=
 =?us-ascii?Q?SMIwP7GYy++H+8mJ2dj7dGVdegnYKruAtz4E8bfQTTlOhuBW7R5FOc5knNOw?=
 =?us-ascii?Q?PsPkiJw6MeoHfW2H4x3zOoj6v2YijxwzCX0BJn5Rg76+sLFKRhFyGr6UH+2f?=
 =?us-ascii?Q?6/el1hcgXlKSd9gCOrxVFSlPB7ByVCzLqQbHLyJEvmn4uyBRWAirolgdMQo1?=
 =?us-ascii?Q?hRzzZqzq9Auo1uc2G4XWvH6vw18AP4yso20rJpf+LWzzWswVPOvNIt9p1kYD?=
 =?us-ascii?Q?WLt7WmBzknxEHItJfmDtMEm5h1ugQvZr2k8auvD0+vdwN8Cs28GiuRXtPtt/?=
 =?us-ascii?Q?9sdRoOHG88LDAJaDhQl/y5lX590b+SASM/elDfmQckTRpr40JN47KfagnHQ5?=
 =?us-ascii?Q?BZLQ9o10/5DO2gPirFsD9iHYj0A+NXY/TS2D+pUzBSdNuObBPCz5Ryfcaxfx?=
 =?us-ascii?Q?Cwgr0CTxNgUutFoSOVap61wqktrlUqZr/okum2lTt7mIpAv777Rlhrf0O1e6?=
 =?us-ascii?Q?DSh1B2xUBr6nhlVkww8s9Pn7C5O8D6HCcEoBUwgcp8vXNDF8LfUg/S3Df+lk?=
 =?us-ascii?Q?7tQhSEa7MF6KRIINsXTeoDxM16jIlIoCAZ2o+JRHE3BQ0wKPdxSPl/B+T5rj?=
 =?us-ascii?Q?SH/F+b87kIHazgwatjGcYcOTDvBikJ2zwWis6YkC+0VupfzD9eQZthSbRO1C?=
 =?us-ascii?Q?dqkJOwss/wB7rfCksYh39yayQiCyvUKK6rGt6Gub5SlPP+kpZ6ersTItRJhb?=
 =?us-ascii?Q?NjBqXacJnIsBfOd8LvzRjILnBWfd3DGrPJhlpBS8RzsuI1rLkAf7w5TTQ9gP?=
 =?us-ascii?Q?9e8EV6cZZYl9GdH7dZFLxPkGzNHCYi2fIyqxzQZbxUN1FC5exeAvegZaaBKq?=
 =?us-ascii?Q?RxMJzMaW5kv8WOpLJJbAgo4iDGeNeJo8jcEmZwvn4L4emYcbsRSfJzQ17ArI?=
 =?us-ascii?Q?8+zFbIBPtDM7w4HV/0hqkqm2j+3Xoo+/tWu2EKfV8ZvkQk1R8INB6+vCGTZt?=
 =?us-ascii?Q?JmQU98Sv19baG8WFTKTCk01dAntZzNrA1VQKhd9kG4nsbMjOd7LJHreXR4m2?=
 =?us-ascii?Q?nKDH7dzCsRlVr/G+tHOHOd2aiqYHve4EHdbH3lyz0aToCLPbghVucv+hrK7q?=
 =?us-ascii?Q?D1p34MdsuizLhhCQdt7fKNPdYEo9QjvQfgEslLbH+cDDZLWl5m4kg3TN8TSy?=
 =?us-ascii?Q?7mxwJfphvsa1gV597/Ki26ViJvu6UEESYkLLESfGsLXk3uk6y0MwCYdzlRyM?=
 =?us-ascii?Q?F5LfwCG1qSdlSlnbfWIEJUPXM88gfjI7aQIea3/NkXtM/v2Y0x74t2pH7ZXO?=
 =?us-ascii?Q?xRz0z0siLTNKzdJjeRL90QsJ1xWLIzv4Ziy9MoUZg2HD3dH8ggmMZufa+Ib0?=
 =?us-ascii?Q?yx0LqDC86bDgWKb3RSUrKSSw/8EEZ/a6dDA6EVCBm9SuBj9m9zsYdT1wIYqB?=
 =?us-ascii?Q?wbaUL0EPaiqNTVVuBwHYkHjQtxyeMsoFLqKuGrYWSoV0tVEcrT31i8pECsMR?=
 =?us-ascii?Q?ML4ruu779rlNi1L+uowBMQKDc/XWRthL+z+eFXRgR7AAOsiClbN5zmeQOEdR?=
 =?us-ascii?Q?MbGaDdPtJsNKoeyd/hpNU7sU586BUdyt/ac7zsjc2mXwM1KAULwnLOEd52TS?=
 =?us-ascii?Q?yCYWZvNqX/J2Z7tGqe3WXd0E8GyddNYU5YS3lWm/gD9l3dcTD/kT0L3lvWKH?=
 =?us-ascii?Q?CrZDGQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:00:48.3198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59eb5494-7001-485c-b39f-08de5e110e7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following fixes:
- Migrate DCCG register access from hwseq to dccg component.
- Add lpddr5 handling to dml2.1
- Correct external panel replay fsm control
- Make DCN35 OTG disable w/a reusable
- Make DSC FGCG a DSC block level function
- Make some DCN35 DCCG symbols reusable
- Fix writeback on DCN 3.2+
- Fix IGT link training failure on Replay panel
- Fix system resume lag issue
- Add oem panel config for new features
- Fix IGT ILR link training failure on Replay panel
- Fix a NULL pointer dereference in dcn20_hwseq.c
- Add Gfx Base Case For Linear Tiling Handling
- Migrate DIO registers access from hwseq to dio component.
- Match expected data types
- Add CRC 32-bit mode support for DCN3.6+
- Init DMUB DPIA Only for APU
- DIO memory leak fix.
- Add Handling for gfxversion DcGfxBase

Acked-by: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ce2eceba2ab7..fdfcfa416d16 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.367"
+#define DC_VER "3.2.368"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

