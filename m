Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AE5C5DF89
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3834A10ECBB;
	Tue, 18 Aug 2026 20:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="smSyK8F6";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81AD610ECB1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwV0M+kwCxYmutikgeml8z+yZC+fKueWdskGI1M1k1e65xFTSKS/p/qjWIDh5Jt+4WsvUfmncrYZ6R6eKN47ENPtMBFDLS1DnRtX/YIB+1Zo4KRArAse1shKoP3AkRDphDw6HVCiyWdWGfMjoog0+Ro1d4tsgBROEqJ3tKYsgRFHFEXiUDhmnax3n8bj+hPzW+xQePZlBG73e1G7U1zjXgXwMFBbypq0G8GV3pJbwfPmBAU5VTS/KJYNxZLojDUCJnQzjg27YfIt8Pp2Y96GifvR3F4xpW3eq25JQNr9pbEo+qs38Re0+0/xxs81p8/zjtYAQin/EJ8J1ftu5XvfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbuNfvgX3WYMjlDynn8pwurYoxWgmeZ5MJ22ojjmfVc=;
 b=lTMK1rKGomZCZH5j6SDWawvdNBIYEDa42HkNTKvUoQNfIHBOPAGQWWxOJi5V/ANGISQnSkJ9ilTvr46Mmb1Qrw8U1cp2YFN3v9y197jYRdTObjWfV2HtSONu/gNbRFEVU4unMeQYkprzqe13HEpxJHKaMQKgJrVmBwA3mNEsoZfJZuWItFVRjgFivq7ruGXuD1ZV9CwBnB6LMKSnP9gLY+5BQTSTtVlQvlvSxP9hOmAYZCltuHQsBKHhW81I6QNINyW2FVaIKrpW0XOFPj4clJBAuefc5awVScmHPAUi4D6F4uptvg9waPW9Z/UhdyDgxlMNoGYlT7ccBa36u/2YRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbuNfvgX3WYMjlDynn8pwurYoxWgmeZ5MJ22ojjmfVc=;
 b=smSyK8F6LItguUxMsQXL/BvpcNkzlMRDG1NSmHtGwMkQhGMAUgvGFOMau0tU7xomQ+OyPFuJyM01Rsf/r2JYn3wH2hPEQDYR7EJnQp9W1ukytjkjF8V0AjptqhqB/vY0I8s56E+xmBVafG5+pFcQXEJc4uxKElBNGaLVRRvGOzw=
Received: from BN9PR03CA0564.namprd03.prod.outlook.com (2603:10b6:408:138::29)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:38 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::8c) by BN9PR03CA0564.outlook.office365.com
 (2603:10b6:408:138::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:16 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:16 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>
Subject: [PATCH 32/82] drm/amd/display: Enable min dispclk ODM on DCN42
Date: Tue, 18 Aug 2026 16:15:24 -0400
Message-ID: <20260818202139.4172592-33-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: 825c108a-ebd3-4b6a-2199-08defd66728a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9H2bnqRSqgA3ZLCCQlvg/7UbMiqKc8OKRnYyl9QRS905ow4U13GjgUyqkjYJB14r0PDcDKWmxZimOnj+DMA5L8oMElSWcw4FyM2/qwfd8BngWJaLpv4hq5RHgL9jBaJkpDIk8VGSrfrBc9nPdDCUj8L2VdpKC89mXH7m40szdcf2XAjCyP2i8QmaPoKsUDdiiYpY6mjVxPOMUDndjghcXjjDKR7qn6d4zCB2sHhAj/HjqrWSOLt67G22Fe8aJkonN9gW7wkkObYlMdtRC9e95TkmEzv/uHcsS4BoR4oNcwkwLUUftAPwPDwjvLxnaLUpHs+gcBcbOd8VM8hIVqVWFVgEK9QtTBa3Qhm/gwdBEY/8SCDqceQuEeXVPUS4BEi7wULQEVhSzvrnBohHxWO10LlD3YhoOyK6eHp5mewHpL/7SH4YdbkTk1SMy43rf6pV4nwjdfL5igDpMhjA2tiwmVdcdjNpt8Yt4hGSiYkt3Xe2vbHslHSbe/tKomklnmZAbvD5XzoTym0E+DEwegeqsV4Ij5wtFQ5s6CQpcCsymiWhDOnHfitSJ/4Ist3ZYUDauKNO03ksqYXCZW77MG+rPFsppPT1GhzwJfWY7cbMVv9SGhxipvOVb23bG0wTgK6SZG2ASJdSxvVJ+AFZOPeOD0DjXSmKEm1CtUFXEUcIF8vBaHLCBgztAmEcER8dJ6qk0cmStFfmniP8FXN5mYaryA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ndE0Jf6BksK9tGsDQHfYpU95mbzBhgLzeych1Pz6e81dyDKpJ0+ig8og2QVaUESA0ccvCz/LnsboEas5vcQ+ONrMpP5wmCBaMZe6KsrA9s/r6S6cCaaFU7wV7AkhiMhF76SqTlpUJH61AlL8au72wCynADxvBBWH8ZAZdlaOQ1iNI7meINaAniOy7GLIkCezHkLuztHhQp7xbPBdJhCqv3iqeTxf4c1lQeRfWE2HlFGa2lLkKsfz2XzYbHkfTWKRfnYpCGo8A/ANzutK+dvYBVlqZrA/8WySTRQ/WgoA/kXtbugKm3BYg/UIpE3eX3c1yV8akGU/uBFliDNf2SLu/cUi5B+Wt7/yjrBp15OB7ei55EpDUbzHbZwzGqOEHYmVmcn8Wk4wLEqsI/mkp06xH3KtZX7fy5rwlpN8FmNQDszvkzHFJ/vyfTyiyYA38oSn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:38.2894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825c108a-ebd3-4b6a-2199-08defd66728a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
Dynamic ODM lowers the required dispclk and saves power. DCN42
and the DCN42 variant should follow whatever the driver requests
through the config flag rather than defaulting it off in resource
construct.

[How]
Assign minimize_dispclk_using_odm directly from the config flag
so an enable request from the driver is honoured. No functional
change when the flag is not set.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c    | 4 +---
 .../gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 6370d3903eb52..3c7cd3ecc6872 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -2407,9 +2407,7 @@ static bool dcn42_resource_construct(
 	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
 	 /*this will use real soc clock table*/
 	dc->dml2_options.use_native_soc_bb_construction = true;
-	dc->dml2_options.minimize_dispclk_using_odm = false;
-	if (dc->config.EnableMinDispClkODM)
-		dc->dml2_options.minimize_dispclk_using_odm = true;
+	dc->dml2_options.minimize_dispclk_using_odm = dc->config.EnableMinDispClkODM;
 	dc->dml2_options.enable_windowed_mpo_odm = dc->config.enable_windowed_mpo_odm;
 	dc->dml2_options.map_dc_pipes_with_callbacks = true;
 	dc->dml2_options.force_tdlut_enable = true;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 41f0c67f57fff..8b1ee45d9c13f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -2387,9 +2387,7 @@ static bool dcn42b_resource_construct(
 	dc->dml2_options.dcn_pipe_count = pool->base.pipe_count;
 	 /*this will use real soc clock table*/
 	dc->dml2_options.use_native_soc_bb_construction = true;
-	dc->dml2_options.minimize_dispclk_using_odm = false;
-	if (dc->config.EnableMinDispClkODM)
-		dc->dml2_options.minimize_dispclk_using_odm = true;
+	dc->dml2_options.minimize_dispclk_using_odm = dc->config.EnableMinDispClkODM;
 	dc->dml2_options.enable_windowed_mpo_odm = dc->config.enable_windowed_mpo_odm;
 	dc->dml2_options.map_dc_pipes_with_callbacks = true;
 	dc->dml2_options.force_tdlut_enable = true;
-- 
2.43.0

