Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D29BC71143
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 18:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071A110E6E7;
	Wed, 11 Jun 2025 18:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qbh2AjPe";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DBF10E6E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 18:41:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ8uu0dVbR2+8+/IrqSegcrBb35nklfliuz8HDy0wrnTxAp6VtkqR/h/OTQ265CJmGcgnoF+sKNJlKQpeFyqLMkDdkhLot928RBo5KKDcA9K75Yzv+O2G3CBJIf1owLhm8musft8P2wd5pzAWs1l61pKPT3NO4wx/gqjnPtkh6qROWeg+egfxwF1ElyLo7R/RzLxLIYYXRQAQVCoZfdqImxBxEdwZdJ4e2Yuk3QnwJSw+Vxhq0nFHdU/4aqTAP6Q7W2cBZ4GDjBYkiXp13lZYWPFY/n/TvZLSdow/s2r2Fh/XSmLVFM68R6bFV0pWeC/hwiqIwOh2adtnRiKde1J2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9np1tgEvkpl1uZM12hv3aZSXlwh9mqRPKlakM6yzDFU=;
 b=LyH3XerXgBnwqxQz0fdXdR0rtDA5LE7MsSb9u67r8IocjMDvAslgtL+JHqn3EUDnwHGdKhgOaHFRMC+cjgMeymreEupizh2cNCLDbysl4UCLiukoZoq67d1HxeTZ1EMIFLqGGkrpQlNqD/6kYa+p9Nw+AuN/pKqBKTthAujvC3Nlldp9JNZpQAyUl9nwwPK487Y5m8abNNzBDVpdG9D9uhCyg3IX6Hiiq5Hb7e9LYhNcq0ToK9s5rvTyP6QJP6KuBalXEl8i01c+vkHwA1455azOq/CuKj7+zV2kEILutHAy2pr8MXLyCmlmhcGFNp3gvFqHj5GNm1EdrYbJjsr7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9np1tgEvkpl1uZM12hv3aZSXlwh9mqRPKlakM6yzDFU=;
 b=qbh2AjPeb5WIOxSLYhu4mpvLCI+UcIjS+7QarxbnLgpAe0Nhsquz9Rl8N0hFG6TRyBBXAjPCppNR6bXwqXDDUJWl6szXFNNX0ZT0nkb87uG9O322NOnJ6Cx5f+5HOREUDp5QY65qGf5/Yb+mwATPPzQa1gDnD/IEVxQh7y0W1oQ=
Received: from BN8PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:70::43)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Wed, 11 Jun
 2025 18:41:18 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::5d) by BN8PR04CA0030.outlook.office365.com
 (2603:10b6:408:70::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 11 Jun 2025 18:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 18:41:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:16 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 11 Jun 2025 13:41:15 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Ovidiu Bunea <ovidiu.bunea@amd.com>
Subject: [PATCH 06/10] drm/amd/display: Add pwait status to DMCUB diagnostics
Date: Wed, 11 Jun 2025 14:39:56 -0400
Message-ID: <20250611184111.517494-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611184111.517494-1-aurabindo.pillai@amd.com>
References: <20250611184111.517494-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 83812ece-0d98-40ec-075a-08dda9178d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XH0QlKct9XYn0SjKHhfJW4/PpQQFD5UZEeyd5LxI7FRX0nbEJqurgPpK1GXj?=
 =?us-ascii?Q?HF4g5txpYVpRHzvXML0k9sRGW7ST/WEODzqtJJojcVVavPWLIcqV0La3bpmT?=
 =?us-ascii?Q?aFUC18RncIfuJal7xxO3ni8Oo1dJItN68vRf3AAIyxPupxynREhHfU8BazmN?=
 =?us-ascii?Q?uz3FbxcN+PMNOB31NBPBb6YdOSPFCFjAyYNGgf6BMq3iKeeE/QjWYsRU/2Ld?=
 =?us-ascii?Q?IIIv4Npm5kV7DUWEU1QJ112yf/YLN8+KuqQdvUWrxhLkeVWonMVeD+b/vRm3?=
 =?us-ascii?Q?wWzYXBZTJU43eGJ/E9SOxbBaNGD/EO1pP9q8K1cYDCrEVzVxCiWgGx4bp3wS?=
 =?us-ascii?Q?XmvpMG6LbEbnyhVMAcxbtMqi/FLyfwWKE2dGwKMjvgNX105CU1HnOO218Up0?=
 =?us-ascii?Q?JkPstN6ubyaoR6GoQwyOLlnRu7D+ncza2fXErIvR9A+m0F2SI6fKLhQ+3FHz?=
 =?us-ascii?Q?0/BdvFwlyAONIwW/kqTwMzsxt+hTIrifb/98uXb+VNB7m6v9roi0CD8CPV+j?=
 =?us-ascii?Q?3tbwsxZGiy2j/0HHjuYQnruANX+AzDHXJq80oD8bdkJwgLsBZ3fBNi71BgVf?=
 =?us-ascii?Q?OeOwXCnKLZqFEgec5sqtknAxELaNXToXhKMEVCYX9VMYZ3LViplFIAfa+9zM?=
 =?us-ascii?Q?52yYLk32xfytviOoHJp7MihO1Hnfm2xpkqGDDIpNmXHxX198ryh13Wbd52kK?=
 =?us-ascii?Q?SCCPWNy6u0uM5vGMRaAPR8Wjsrm67OKOEiZ9ZFxKJ7AHfmfmTnbPdssLi3Fw?=
 =?us-ascii?Q?TnUEq8S9cH5RaxAhiHvon48VrnohsnCJuH45jIqosh2IFMU+w5+hFwbpWhio?=
 =?us-ascii?Q?iOoXttJE44laiiwVj0s0kuVKaYhP996Rq2gnCspv+pQEMKvTXF5KLqLncQyl?=
 =?us-ascii?Q?t2ltM7C7pXCM7zBOid/tHVqHk7dVPqtKR5vw5psx+rGIVfCDU/U+7t04Eicr?=
 =?us-ascii?Q?5Es1avWaaG9/CixblCV+WUzizn6QQIySsBGgN9M9zZru1wgs5lmfg2KhNYZZ?=
 =?us-ascii?Q?Fji+6nAJxwZKQxeBKCp06faqnSLkKPW6zkNHDzITNUi1Mi5tiJ2pSbKeRDyc?=
 =?us-ascii?Q?HRhkL6Lf7L6XYFyqmc8MN5IxbyvTL0xi5Yzb6W8O4O+t19Odoim7H9f9dGgm?=
 =?us-ascii?Q?TjPwSQqdyiFP4Bq0HaolRiin7DWhULRbb8TfZB+2qhuQqlCJ8YxqSwnzGfWp?=
 =?us-ascii?Q?i1szhlmshH/eaV/Ii+eep7OxprHt8ITLqI6zUjGzjCxC5aVGrVf4bNtE9spe?=
 =?us-ascii?Q?LmN6T7A8xmJtOA4USJVRJmtQjB2e8E7hJ21lI+5tDslikk+/rMQAeMiPTB+X?=
 =?us-ascii?Q?FN/vkaKEd79+WoPDhVzYWbbhwSclk+qgdYj0cRKFg1bUYk7j/m0Mj4mw4+cz?=
 =?us-ascii?Q?vlp1vulWI/v6LZc+hVHehJLTmNG8WBHF6H4ppBwL/DWA3wSF6nKp0WdYrov1?=
 =?us-ascii?Q?GUWSWU6gDyYtBa74UKk90oFiydFMVdpEwWBkB3ICQc0RQC5iFQPKJqzo5bQx?=
 =?us-ascii?Q?q1Fgk63tmyDTdnbpZJ7FGyYhmtM3DYWioc49?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:41:17.8450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83812ece-0d98-40ec-075a-08dda9178d72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
To know if the firmware is idle when logging.

[How]
Add the pwait status to the DMCUB diagnostics.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  | 5 ++++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c  | 5 ++++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c | 5 ++++-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 211486724e84..479db84fcdc2 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -356,6 +356,7 @@ struct dmub_diagnostic_data {
 	uint8_t is_traceport_en : 1;
 	uint8_t is_cw0_enabled : 1;
 	uint8_t is_cw6_enabled : 1;
+	uint8_t is_pwait : 1;
 };
 
 struct dmub_srv_inbox {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index a308bd604677..3f38db752b84 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -416,7 +416,7 @@ uint32_t dmub_dcn31_get_current_time(struct dmub_srv *dmub)
 
 void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub)
 {
-	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
+	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset, is_pwait;
 	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
 	struct dmub_timeout_info timeout = {0};
 
@@ -466,6 +466,9 @@ void dmub_dcn31_get_diagnostic_data(struct dmub_srv *dmub)
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
 
+	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
+	dmub->debug.is_pwait = is_pwait;
+
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 2884977a3dd2..2228d62adc7e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -454,7 +454,7 @@ uint32_t dmub_dcn35_get_current_time(struct dmub_srv *dmub)
 
 void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub)
 {
-	uint32_t is_dmub_enabled, is_soft_reset;
+	uint32_t is_dmub_enabled, is_soft_reset, is_pwait;
 	uint32_t is_traceport_enabled, is_cw6_enabled;
 	struct dmub_timeout_info timeout = {0};
 
@@ -505,6 +505,9 @@ void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub)
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
 
+	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
+	dmub->debug.is_pwait = is_pwait;
+
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
index 2575dbc448f7..b31adbd0d685 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn401.c
@@ -413,7 +413,7 @@ uint32_t dmub_dcn401_get_current_time(struct dmub_srv *dmub)
 
 void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub)
 {
-	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
+	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset, is_pwait;
 	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
 	struct dmub_timeout_info timeout = {0};
 
@@ -464,6 +464,9 @@ void dmub_dcn401_get_diagnostic_data(struct dmub_srv *dmub)
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
 
+	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
+	dmub->debug.is_pwait = is_pwait;
+
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
 
-- 
2.49.0

