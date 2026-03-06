Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43459F513EE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1A5210E306;
	Fri,  6 Mar 2026 03:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5o8E2Krr";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F1A210E306
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:26:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYOu98Qwks9PgpV0tOejN1ZaR6m7QXqV3w815uqlE58jTJm8nLCVQClt/rckmU/WlAM5l3g+LO1h60qpdxcjB3ZKcUztfZU4JCCSMpB7fLnnxDBsQ+LHQC4L/WZW33eC7cKC19Cp4uJGHxKTFKynvG8IuOeizwv+rHgRZWEBbEfpFWyv4V+BwZEuefaf5kaMKo2rT6z15kIVpbQLbDQL90yXhMCB8i/vW+vhSKTm42pF0bwLVqWVVYkMRZl7VB2G/t8NmarO8FeNFEquFecJI0u3M69bBDg6kULN8chA/YZzht+X0J70burgsLV3paqKh9BOjFXOnvlgyz+VULOhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsoA8dFvAkbWgeBOu1jP4j9VTOwoRwSoqGzcNYfRU/Q=;
 b=cK4YE2yHCLIba8C+/V/VFyahG01a7eaO9gMHbwl1DNkcWPlNg1icz/aMyZt2C8FUT9PlCZhMhAUsPUflG5ZRmiJeZbesE8/FsQcDhyeo0lQdoQiNjFZHBmX9RlQBUO/1zN54d8b8ik/hkbkAh7Ucp5hU/HkFIsfpewlef2msbwEcPij+xXDYe+p3y+9Q6gEwsU4nkITWiPnQJyeDQCnRGmiw7Pw4RCkz2HLYiOmmYhrVXH4vAP+SlEnOjwGjxm661d3uuvPnjCMI0oFIdJm+QF5tqxNk9HTHQCsBbI0mpKq9qnh4LiYE/1q0NWst8bJyFw07MjqQka01KPENIY5loA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsoA8dFvAkbWgeBOu1jP4j9VTOwoRwSoqGzcNYfRU/Q=;
 b=5o8E2Krrnn/tp2d4drGtfSlx5ec1t2hHHj0ZTrCiegKC9BkKG12p39DZNirSnQmJE+PqztE/obc/Hz9qaRU5WHoACF8fZlA1HSDuGtdOHkSqJHD6cDNyE0RQNFvcrpaDf1GtXSrCFaXZIm/ot3ojQCfx4Xk/gjNR5PT34Gz5iWE=
Received: from BY3PR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:217::17)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Fri, 6 Mar 2026 03:26:44 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::d6) by BY3PR04CA0012.outlook.office365.com
 (2603:10b6:a03:217::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 03:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:26:43 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:26:41 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 13/21] drm/amd/display: Check for S0i3 to be done before DCCG
 init on DCN21
Date: Thu, 5 Mar 2026 20:13:39 -0700
Message-ID: <20260306031932.136179-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd28c39-7cde-4d83-472b-08de7b3030a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: m3ReTjDl3hZhJaKVV5qpVqXzF7m/kH7bpy7UMOMAirwfeMhsp5uQNFB8wsFsgFcobJ+ZGGA51zRU+U8zUIrt2OZtbQuFRgXRHR++kGtPqE8UkHX53oKL/NKFd4uGiNBGlze4n9B5KqjtbBgF9m9d+BfEmHV8JnaF6GOYs61p73GT4GhgQiPAZToDMzumt5fTRXHUIN/bMQXFzfmPO70mFboQ7XXdl4AgZzukIQwHeT61Mt6nT1kdVD0Ch3PuMFh0cZsevwiUkh33bSmCtNmeOmn7OcWGRnl7FFyVcouEPzb9XeAcnS8G5untKYrnKsomO7d1ds3LyT9lD8Lz3nTlihrHuT571t7LCaaHMDFUeOuXgmBA7bXtbkdH0yb3tf9vnGgr63smoS2Eirpzab+ssKpVoIlQAKrILOxneE37YvvoW8qZ1+vAvhbSPp8IWDFM3OxEz5DPdufo8Ngzpm3RpV/QXOJCnTkU8I9w2hB82hDhFi3wXjLZyNvuHFZ9DA915XqPc8hnL0C9Bc9ErxyKsvf9BLUwCcaq3UZ6DHmCCBqxgyVGlWxIaU7VzqvC9iplLEOKrBkGm+N+UYkAt0+gzwvCPADmvs1cYAYdJjIYuC5Oq5kJnzqozFi86a/hfFJWTyWIdFDHBzpm9wHFtb+mEFvROx2eZG326YaTnOFw3/anip6RgtK3Kbi7ETV68sEdKhstZYt+yG0LwjvdAg68/2Ryq/tHj1CAaUEjK+MvPsVH1bdynA271nYou+21ids8B0w1Qg2AgRE/S/Q9zqNoog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sEMcazDEkUp+IPZhKCIYYtUonNxGROvMDHzHGm+rlexaFrijy7MywfBVHpN4HVtwj83yq6TbZl5RTUwaotNiL/18RlNKgP65eIywhN6rQOW7xP0U5PVv2gS5HKTO8+DQFXsCeWikbbvErlNzAXyTdR/RILxZkRNlew41sFx6PQBZQaTsaN1UpbcC/Ym3ncVO6yzSxQurwIxaCwhLS40FVzs6/1EuMa8dO+A9UUp7MZKehv5eRKUS1ETdWdqF97b/yzvyBbYtRXJvN5bSSBaHAalzHdKcWe9a3wUNj0BeuvIb3TjDMsfvk5aY7DNnk2e0NVq6g+/5YRKn1Uk/qnH1BfR3dpqQdcXgDDheO2Zkn4awXx0jR8xGlVhEusizt54+k2JtVCc28eSIpS64IBRUustfpuK9RzFJ6Nj+49u97F4cM6PG0MYHnqcney4VlJiJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:26:43.5944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd28c39-7cde-4d83-472b-08de7b3030a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
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

From: Ivan Lipski <ivan.lipski@amd.com>

[WHY]
On DCN21, dccg2_init() is called in dcn10_init_hw() before
bios_golden_init(). During S0i3 resume, BIOS sets MICROSECOND_TIME_BASE_DIV
to 0x00120464 as a marker. dccg2_init() overwrites this to 0x00120264,
causing dcn21_s0i3_golden_init_wa() to misdetect the state and skip golden
init.
Eventually during the resume sequence, a flip timeout occurs.

[HOW]
Skip DCCG on dccg2_is_s0i3_golden_init_wa_done() on DCN21.

Fixes: f5472343f468 ("drm/amd/display: Migrate DCCG registers access from hwseq to dccg component.")
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/dc/dccg/dcn21/dcn21_dccg.c    | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
index b48dcafbae66..bdc3ce5d4f47 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c
@@ -96,6 +96,25 @@ static void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppcl
 	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
 }
 
+/*
+ * On DCN21 S0i3 resume, BIOS programs MICROSECOND_TIME_BASE_DIV to
+ * 0x00120464 as a marker that golden init has already been done.
+ * dcn21_s0i3_golden_init_wa() reads this marker later in bios_golden_init()
+ * to decide whether to skip golden init.
+ *
+ * dccg2_init() unconditionally overwrites MICROSECOND_TIME_BASE_DIV to
+ * 0x00120264, destroying the marker before it can be read.
+ *
+ * Guard the call: if the S0i3 marker is present, skip dccg2_init() so the
+ * WA can function correctly. bios_golden_init() will handle init in that case.
+ */
+static void dccg21_init(struct dccg *dccg)
+{
+	if (dccg2_is_s0i3_golden_init_wa_done(dccg))
+		return;
+
+	dccg2_init(dccg);
+}
 
 static const struct dccg_funcs dccg21_funcs = {
 	.update_dpp_dto = dccg21_update_dpp_dto,
@@ -103,7 +122,7 @@ static const struct dccg_funcs dccg21_funcs = {
 	.set_fifo_errdet_ovr_en = dccg2_set_fifo_errdet_ovr_en,
 	.otg_add_pixel = dccg2_otg_add_pixel,
 	.otg_drop_pixel = dccg2_otg_drop_pixel,
-	.dccg_init = dccg2_init,
+	.dccg_init = dccg21_init,
 	.refclk_setup = dccg2_refclk_setup, /* Deprecated - for backward compatibility only */
 	.allow_clock_gating = dccg2_allow_clock_gating,
 	.enable_memory_low_power = dccg2_enable_memory_low_power,
-- 
2.43.0

