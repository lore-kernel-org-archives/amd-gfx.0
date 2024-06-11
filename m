Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC017C41513
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228F810E6EB;
	Tue, 11 Jun 2024 16:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EhIIMyMr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053F310E6D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMrPXDHPiKcG8h7AdauSzpDlJ33nZPKLJcx0oSUPRVIQZn3qpMcHly8hPAieofEAbCpUaXpM85c40OJgKesa6gv78EfAh0OPWN4U3lykAqSUH238QqdFO6XhNRpIusbuM7BZ8TxkGUppo/4Un9u4LYAn9wc3jh8xPQQxzFvaG3WQMD6WLDQj8f2HCT5ax9xwHy6vxhKQy3UskB3RugbkVJ8xlyQofzOQIcHnwsB0/uivokeHBJqLs25/B5aBDey5BO1iFC7DhbHK6yCyMtIGcirbGG+szBtk5le9Q5PLZB8rbmVeHs7v1bQ4nvY+r4XVawL+I/neCX256vF5HCQNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhZw/SgZZN03UMapOkZRnGeiPsADZxQBoqRK0ifzMhk=;
 b=Br6kVqucbkTtYUftNKAcMvFPSHIJGPmxHTnRfm4enLCHhPHjPJL2e1jMvz7uKYnI7whsPs4qNL+XkjLUPYq8jhCGACETesj1wKVl17oBoePwWIKMKTtp++E586dLrYbOsPfVNjsj+LrxH5SnfwyJGfcVCJr2NpgYDykbbircSEr+V69NIAEaux86gHXqmJ/BjQHxJcwk6urwwNcywCyrC1xiAPKu1c1qW+5+9THn5RyR6arf1H3RkOWXoPYnUK3NEt8O1V1TDODZ4ecCs/1PzVWShNTHVnIMnQjceNCCdjglyw+M8F3F/1M/nCpTBrM6rtJ3C1XT0anAlcPisCQjBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhZw/SgZZN03UMapOkZRnGeiPsADZxQBoqRK0ifzMhk=;
 b=EhIIMyMrOV2Xo2CdSJBpKtiaWi1CHnQUkr1Ocf+8eZgVit0TZEffPgEi99tQh40tLjiCcFgYR8UREQsuZzLDMWvWFYAN3K6hg7DimH0C33/oMM7fHD2XyQCiiuFzPnjRs5ZaS226bDEyfU3SW/AJKV3M3SNhVwlNKR1nFV4rKdI=
Received: from BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27)
 by SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:46 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::1e) by BLAPR03CA0022.outlook.office365.com
 (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:46 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:44 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 27/36] drm/amd/display: Remove redundant checks for
 res_pool->dccg
Date: Tue, 11 Jun 2024 12:51:30 -0400
Message-ID: <20240611165204.195093-28-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5ae689-0dda-4eb9-d9ed-08dc8a36eb5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NLqlftxJpAUMa1SYjU4I5qwWTs3skRCBlOQyDvAiO843VvzNqpxmkKlmdydw?=
 =?us-ascii?Q?VNQ0D7C89fpaINqDXU9Arqs7/pgQ4cSq3Cwf9TbEOIzYqey49nFM69GRPHUR?=
 =?us-ascii?Q?CkQCEk+962KL6CE3XcWZ5keqzI0oNOhtbHIUwN4ObThyTIxcRwsfdBYnAlpV?=
 =?us-ascii?Q?TWPSeo0d07W6ZxK12z24tkT2eOnpDgv/lJdlPERI1Gp2HeVxDUXPsI0RqCek?=
 =?us-ascii?Q?ZFVuglKwlT60sQtx6Fel0gF7lRb195WnwzHYsbQOjd16wXhb6Fa7cTeWqnPV?=
 =?us-ascii?Q?pkhBMV9Sk/pxbkIdUbw8kmJbdHRR5IXsk6b5zjgAq4xyJS1pksyDFAP1p36B?=
 =?us-ascii?Q?7JDmvMU5KkxcPSRBIPZixaIa9mvzo4T1eV4fczKaS0bkhjLVV7hjX86TGpUK?=
 =?us-ascii?Q?AfbCnQaQQE5AZlR0hMonFf+/TWnwDbuGNrP/Ku5+QgAizRl8jW/GzorMPR/W?=
 =?us-ascii?Q?6hmYybp4oC/EU/SBkd96DJ1Fpa3IKCkrYZT4Tpmodzn4Drp3nlz1T9v8DJ4Z?=
 =?us-ascii?Q?n1RIVZSUBnRwAkt0iuk1fqQ98FqBVW8HDwhzdDG9Zjnp+8y6EWj9c4vnkT6u?=
 =?us-ascii?Q?B+JovVWlf9OuWO5d33gwa0cpohNoTAYIkcfRq0SEqsbHRQBwxYvqWf26Q+wS?=
 =?us-ascii?Q?hbt8B87dkzWMFpt5CPnDYh0usc7twhsDNaWSgLSQSccy5206KAtShzDHfiUG?=
 =?us-ascii?Q?Qyut+tpUY2crIktCt0lVW8ykRmq707h7phYfw4kGHSCNiuetIlruEaAJSr0Y?=
 =?us-ascii?Q?2f/1k2PAj9GdglWqvhLpeo/9omJzKO2Agkh9pL/Ympw8sxCVmstSxphL125J?=
 =?us-ascii?Q?sdKxbOrgXOcByYNxXtak7iSP1IDyWHvp9zo/FyYENyl5hW8wCP7DAwMHC4mS?=
 =?us-ascii?Q?UCnUu41LmMsuF8v9lFopqUjk4MpNG+BFuMxRkod3xZrtGKHeEvB7xZibzytV?=
 =?us-ascii?Q?V3BWFR2KEe+3PX2C6oRh4E9JVVNX1oHgH559y8/s54KfsXVpe05+cIqvYYEA?=
 =?us-ascii?Q?NV6EYU5+spqauAU2GwxVennO6sKvHooz/YWsR3C816wj4EbOv3+vH/HpMM4x?=
 =?us-ascii?Q?fEYPkxlTj4qTAf0BoZLtAhoesPWVihZHb6zcIXozKiNxsvkn5zmL5mZB/uqN?=
 =?us-ascii?Q?wXz1aEWgEi1XZ9JWRj0GNMhC1LinkGJMJR8L7MGjbA5yt5Ap1Fkn+3Ttve2a?=
 =?us-ascii?Q?3piaIPsEATHv9ZHlyxc5nQ/ONYMsNlWujMD8wfXXcXNa73onnQhOpj3SSRQb?=
 =?us-ascii?Q?pEqLaTkb2W+HWm2sfkSjs3gmGoqY+YXzc62b6awD1CkHXvHVU0quYbCihdJz?=
 =?us-ascii?Q?bauJGqRSdRenlYqUf35gippNuJpaK8UWdofbOt9kPAYSvMDf2qVa0Jh59Yqr?=
 =?us-ascii?Q?O45vY8Xp8tvv2hJjPxaW+dVOqk7yfXaXX6wozB2SKVn4fhO6+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:46.0740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5ae689-0dda-4eb9-d9ed-08dc8a36eb5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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

From: Alex Hung <alex.hung@amd.com>

The null checks for res_pool->dccg are redundant as it was already
dereferenced previously, as reported by Coverity; therefore the
null checks are removed.

This fixes 6 REVERSE_INULL issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index 86d871cc74c7..f96adc689055 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -240,7 +240,7 @@ void dcn201_init_hw(struct dc *dc)
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 			dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-		if (res_pool->dccg && res_pool->hubbub) {
+		if (res_pool->hubbub) {
 			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
 					dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
 					&res_pool->ref_clocks.dccg_ref_clock_inKhz);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 9ef38a3759b1..567300c3acaa 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -656,7 +656,7 @@ void dcn30_init_hw(struct dc *dc)
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-		if (res_pool->dccg && res_pool->hubbub) {
+		if (res_pool->hubbub) {
 
 			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
 					dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 1c8abb417b6e..746c522adf84 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -132,7 +132,7 @@ void dcn31_init_hw(struct dc *dc)
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-		if (res_pool->dccg && res_pool->hubbub) {
+		if (res_pool->hubbub) {
 
 			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
 					dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 33b8df995869..a597b2342472 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -806,7 +806,7 @@ void dcn32_init_hw(struct dc *dc)
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-		if (res_pool->dccg && res_pool->hubbub) {
+		if (res_pool->hubbub) {
 			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
 					dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
 					&res_pool->ref_clocks.dccg_ref_clock_inKhz);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index d894c52bfdaf..a1e1f76bfde7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -188,7 +188,7 @@ void dcn35_init_hw(struct dc *dc)
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-		if (res_pool->dccg && res_pool->hubbub) {
+		if (res_pool->hubbub) {
 
 			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index cb8e417fb032..6ba2e1cd20c7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -259,7 +259,7 @@ void dcn401_init_hw(struct dc *dc)
 		res_pool->ref_clocks.xtalin_clock_inKhz =
 				dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency;
 
-		if (res_pool->dccg && res_pool->hubbub) {
+		if (res_pool->hubbub) {
 			(res_pool->dccg->funcs->get_dccg_ref_freq)(res_pool->dccg,
 					dc->ctx->dc_bios->fw_info.pll_info.crystal_frequency,
 					&res_pool->ref_clocks.dccg_ref_clock_inKhz);
-- 
2.45.1

