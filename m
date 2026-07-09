Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3726C44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA1810F6C5;
	Thu,  9 Jul 2026 21:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DjCrXlVZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ABD510F6C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs56j8F4XoOJHC5HPb/0AgUOvDiDzXvumbPmoAYNS29JJ9HiuataE/xJjbBVJr1XLHUKVW1oIkSN4wQfqV9HbWTHFHgkdeUDjOBGhnN1EbaKZp3xCfimqD2FUZEPVV8z51Xz+35Tbbp1vga90UyDyZxBgcEV929/CBOW4lEpRLZv65KMGHDyQidtZDfllBF1GVsKmjlbz/6YqnmXDMzHa0+Ublgsqz3DcTW5PrwaFAl4/c+nlZVu2siljCBTUttW6h86eqXQWL5Hy5nr8tjNSA7DzHCkbyV5xRJEpD5bw9xv3YtEWKywHQ9hl4mX0Pl13DpzTqpBjQSyJxqJ9jta+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9M2Fjc4lD7mG7P+P2vgIaQ/nhJ32/en9GCE5qENAqo=;
 b=KHAtsMRixQezT9oHuu6qqLgkuXoH3dH1YAwfcbXog17zSHSfsDJwETN5cQBRHALqzmcHQaVPuNu25zjyMvHgEqXH5lfH2xqYVO7cxZHmz4NioafRbqsJJ/NvRRoEs4ss0J2IvMaf1U1UruYI53qzuCpsGOTtr6ZrZgtNQ3s3njDSav6AM5z3/KWlJc/GHVHd8LVjs+4Jyb24xDDjkPSO0d8J47rP7wBQfMVekcbAauiKgkeeAMeE9eQMqRkPJK1ttLRm73O1qZev3g6nt9KpM9FhBgxUDD3UGON2QVJpt+EkkBhgVc/0M7spFhMKC3zn7UMVMK7CHpq1vGTQ8KIhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9M2Fjc4lD7mG7P+P2vgIaQ/nhJ32/en9GCE5qENAqo=;
 b=DjCrXlVZ9INXmJIgFtYrcy3FBfPUkKqK1EQLJhNge+FwTjCa7jWq7lncXz7/QzU3HgbrqYVP4y8mri2mU/TyYCFfKkqDKN2B+6MCKzzh1Oy3CWJDrWhUzvzcZI4TlHTsPWmgFZWWFXaPbkcXfEeYJ8tQs8Ci7+mucYUnarBD+ag=
Received: from MN2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:208:1a0::14)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:14 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::39) by MN2PR07CA0004.outlook.office365.com
 (2603:10b6:208:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:14 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:52 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Leo Chen
 <leo.chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 22/80] drm/amd/display: ensure dtbclk clk_src selected before
 hdmistream_clk_en
Date: Thu, 9 Jul 2026 16:47:50 -0400
Message-ID: <20260709205936.5719-23-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: a552b7f6-cfc0-4196-f575-08deddfd5a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HpcnCLxNipFSwdGWGkrQ3ark57WATcq/XNUGqDAqtabRE7lOdundFY+vY/ARri8MI3SN4Hs72pRvW1SH/pnXbS4b41uRe9Ztj8dXCuFeE640O216nH3h2XCT02i/hJar8HUZMpTDnaQz4K+jktWSP1Pv7B2uERqPKv0HhWvUWaYNGhfYphMuc0ggcomQq7S9BD2N8pvR6+xQBqfTkDcHjjGo46ej5rSXzmeyYC2b8g31+nz6vgHQs0AO2yv8/KKZ+ydNQ7O2MS0Ne/J8Q5fU9PCYhx60FMUxOKywzGMWOv90p+Q6oHweKWSr/zdrWYucrMIGWHpT6nOaycU9LWoZJKJvid5DbYni+86sZHS4TU5yUWjHB9n70E2qIE+Up/UnoYrJIguB75VqJFjRtgys/dk3AwuQzEtrQX2ZJ9Cc7qNXmxDbDx3TkRB/eRt2tDZxzedPCwnZy6xHaYJuF6SHC4Pog6gU71jvgLaXniA5OOup0+4D4Pfd9c7ZymCKOJhM37b1EHcHoAMDKVpvtsahgv44PjaZ4rZEEDvVg9jFYOHFueXYzo3dCxAcpl7RcibOFoCMIg83VtjR0+BWPkjA/BcqtG1UN/lGrU4WCtxqI9DnA3ZwZ5fsHNRC4oSfgEPQoo3EPoJqJgg6uAfdZeNCkMirsd6EkohbvwPZYEw0hqu37wdMl1KnRkcjBRWcpigw39bvJwDJXL2VFMXd1ANIog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gqYXLHm0nQEY+Pv2/acIOm2dFjnhIWgQ1l6jzwN3mZMOprcYc82dSfFOxCMhP0kXm5hIk6qisKX5qVngzZsFxI55W3Ear3v6Q8TOV9YVDBrHkPs6pHJrRVmF6YbJQaCfDwHSXGPOPPUcIVFpRSXeqJqek5iex1/HbHY356VlpTLqYDEdPIXKLrDDiZVhT1F8El9hAkUrrNHBELk7HgvlUpS7G11bWiffwM4cNRM4U+483Db5IZ0o+9ZrVpkeo7gsrlhb8fi+rUt54lTxP3eRNVD6tr5pKoEvrKBv2Sy2LqkCg+M0k6miNmCuLCLG5OYVe5b3gPOtuj+lwhU0mTJ7/wGT/RYx5FkAD2UqvMqmxQZMlUNpNpOGiadF8vTQvELP+qcihJFNYptT5OEs/n7JFjhw1xW+Gykvayqwb/6NgEgkZfWxUnkoeIphpFOo3fAW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:14.7297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a552b7f6-cfc0-4196-f575-08deddfd5a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
correct a sequence issue by switching to dcn35's dccg sequence:
to make sure select dtbclk src first before programming hdmistream_clk_en.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h | 5 ++++-
 drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 83589777f1ca..85da247139c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1654,7 +1654,7 @@ void dccg35_set_dpstreamclk_root_clock_gating(struct dccg *dccg, int dp_hpo_inst



-static void dccg35_set_hdmistreamclk(
+void dccg35_set_hdmistreamclk(
 		struct dccg *dccg,
 		enum streamclk_source src,
 		uint32_t otg_inst)
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
index 554700287c1a..58f4c1e998b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.h
@@ -269,5 +269,8 @@ void dccg35_disable_dscclk(struct dccg *dccg, int inst);

 void dccg35_enable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst);
 void dccg35_disable_symclk_se(struct dccg *dccg, uint32_t stream_enc_inst, uint32_t link_enc_inst);
-
+void dccg35_set_hdmistreamclk(
+		struct dccg *dccg,
+		enum streamclk_source src,
+		uint32_t otg_inst);
 #endif //__DCN35_DCCG_H__
diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
index 616a896f0782..3b03b152da22 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c
@@ -313,7 +313,7 @@ static void dccg42_init(struct dccg *dccg)
 static const struct dccg_funcs dccg42_funcs = {
 	.enable_hdmicharclk = dccg401_enable_hdmicharclk,
 	.disable_hdmicharclk = dccg42_disable_hdmicharclk,
-	.set_hdmistreamclk = dccg401_set_hdmistreamclk,
+	.set_hdmistreamclk = dccg35_set_hdmistreamclk,
 	.set_hdmistreamclk_root_clock_gating = dccg35_set_hdmistreamclk_root_clock_gating,
 	.update_dpp_dto = dccg35_update_dpp_dto,
 	.dpp_root_clock_control = dccg35_dpp_root_clock_control,
--
2.55.0

