Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C01606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2NlrHXXM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B8810F8E4;
	Wed, 11 Nov 2026 01:44:18 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1A9C10F8E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLkDwgSx5EHpjpVFacqVFvTJg3jvy+ZaVNfFDiVr3WtgnGkyJVcqYQfznECpPpfMX1NukwYMDEXJffkchOkLpOZHFuwho1eoYt7pCyChTJxKKYPP26ojuaJ8SrcW8YG55FBW5ygq9cDFFDzA2492FFSeX0o5IyrooRdDUhJWNH9ib2hOWIaowCQ+Wr4JsCXuc4HtMAVFuRKcd3PiapvATxi28E/+9+feEUC0OlPFKAmGR8dxmp8iR9FE2d3VZ0aTDndULpfcYrcTuuKXg+au3wRrF7U2YEkKJx8t/5bkXavUsnhsoKJGA+sLbWugezcRKYqU+8AdMdynpmAqgCEW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1clpqhiAex7f1tdI6V+sZeAFJOrz+k2ohLWvzBP6RM=;
 b=Zr8ximf5qmDxcyPaLyEZEve7JMlyPgioAeoWpZncMYK7+9jA4GAjW7NjluT0RNbCinLSL3ZSTXjs8lP6nVzGplyTlVZMR+5JRNbWmtweGjuGckpqeDzfe6T8rnb6Q239s4nwfTJsz72kWcDIHoRE3nUaYxVXN6lqa2stwXgVorVOV5EMySfCAmOuILYabX7xs/5kq6CCB36kvT62UmMGco2R8wJWxFpwdlaqztzfCSziUDtoqxgUHllJH7wmMdWiKUvmTPJsyGqqqDH3gIEMxZFRW4zJuzTdPJzqIkZD7ZF3/Nu7nPhevilgrPHoYDpxb8d2BAzTuTNYelj1RiRoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1clpqhiAex7f1tdI6V+sZeAFJOrz+k2ohLWvzBP6RM=;
 b=2NlrHXXMWbe/Ld4cvTRDR25QutwTlGBeLG/S84E/O76cD743BFSe0DMByuR5m6xf0oDL56x3QZTMDGm9NIQ1As7hEBlSSkOWcm7vovrJEExvUERVQxwrLtSp7ywO7zB7r5bckJCei55q+jraE89JRJrnaMTJjc999iktoeWUQw0=
Received: from MW4PR04CA0272.namprd04.prod.outlook.com (2603:10b6:303:89::7)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:44:07 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::94) by MW4PR04CA0272.outlook.office365.com
 (2603:10b6:303:89::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:44:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:44:06 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:44:05 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:44:01 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabriel Abarca <Gabriel.Abarca@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 57/74] drm/amd/display: Increase state if dcfclk deep sleep
 needed exceeds dcfclk
Date: Wed, 11 Nov 2026 09:29:03 +0800
Message-ID: <20261111014100.3596072-58-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: d51495f6-4553-47cd-f3c8-08df3f9545cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|30052699003|20052099010|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L8AjAwjp6hl7XYBIEmGAaX56vEmtAPKwowH5zTBaTNF78gHxjkAp6N8rWoFjZKPQMdEQhsjnymnPZwtbVlaTgVyrH1yJi7HTRcGFaty/qSYVR8HhklMcFKnnWh0HN9yAbvd75qFo47bqwUFVVfhxa/64SwMcBPBZlWu/IzwCoVHs1U9n5lLqbCTZ5lRAx4oiC/YV2u28qRhX0dFRJ7io/gKA3wOibryzmx7eQGJmUzZbkbYZusGfPXqoMGPqd6ulyhJ4RzP2ril2M3GH2zpYJU2UoaIbCpCb+GWb99KuwF9Q//XzuPoJO3TWnbQVZIwGAbmXP3VzL2huoeIWO7eGlukXXpVZVlYt/ncV5W8C9GeXar2fwX+RF07jR380b+ouhMGM06ra9G2HtlACROt1xyEWFo9WYGCgy8svGeynG8ohA0OxTmITAvbxnvEDaeyyb1FCHvazEXu6Be26Pe8QR0UanlQ8E2h/qNc9hghCbpN00i5tJkk3IiR1dsikhRLsfHtvX5g3Zw+y/Au1QSnymlz+4Hu2IRVYlLgHvleOJXpUsLP/TPoM/8jg2KqD6BSYmkM2H8hil8wLGllJtrVzTTwRkybU0nRmXub9MML2YRwLMIFW39UaS75Mq7XkJW21sql0jF8WQ/G7ng8Gsl26FJE+EkwdP+GeTwkPAuBJBUbZooPvJ3fG8Lf5kpVsbn0Jomc+cgTULdlR4rKvHYSseA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(30052699003)(20052099010)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BCVaZeF3WCfQNFp33yLaNt46MMEFaEync0m0ZdP9KhqjDESZWisJfSx3g0IcXfa0o5pJqwz1E3kARR2hI+y1lSkk0XPvOfdYVzGNxiF6aswUM3O4Bxml4DtKUKDlKYe5D8pgQKeLue7rNM8PjkwV4tQEtoShnUyW4bIgUIWLvuD1tLThIM0hYb6BVvf3uCJTvgH/e6FaCofgZzJROhqUXHRD0Vn4W6S39qwj8JQpoysgj9QWBiR8F8q5SvmCDleSx9B9llHy+dCyZHTQ/oYueW8WnFzAY6ZUU7CAK+WArChiK2+DeH7vvEZRvkZwHvoJTOLFi7ghVq7nYpaz6C7EuDI12a6gbzw9Mf9IeC+F45HD2mFRssmsiAm9PVvWDyUv62TCcosCOdNWXRbQRY0FzVEpUyElZwkwsRlnishFfDNmPKsixBw2J8UTRlDdDz4H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:44:06.2569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d51495f6-4553-47cd-f3c8-08df3f9545cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gabriel Abarca <Gabriel.Abarca@amd.com>

For dcn6, take out dcfclk_deepsleep path to line transfer time.
Increase the state if dcfclk deep sleep needed is more than dcfclk.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gabriel Abarca <Gabriel.Abarca@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/inc/dml_top_types.h    |  1 +
 .../dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c  |  2 ++
 .../dml2_core/dml2_core_dcn6_funcs_mode_programming.c  |  4 +++-
 .../src/dml2_core/dml2_core_dcn6_funcs_mode_support.c  | 10 +++++++++-
 .../dml21/src/dml2_core/dml2_core_shared_types.h       |  1 +
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c    |  4 ++++
 6 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index fd7ccefc7fb7..4f4bfa58284a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -382,6 +382,7 @@ struct dml2_mode_support_info {
 	bool temp_read_or_ppt_support;
 	bool qos_bandwidth_support;
 	bool dcfclk_support;
+	bool dcfclk_deep_sleep_support;
 	bool alternate_channel_size_support;
 	bool EnoughUrgentLatencyHidingSupport;
 	bool DSCSlicesODMModeSupported;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index c84cbad7fde1..a497a75ff9ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -13249,6 +13249,8 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 	out->informative.mode_support_info.ViewportSizeSupport = mode_lib->ms.support.ViewportSizeSupport;
 	out->informative.mode_support_info.qos_bandwidth_support = mode_lib->ms.support.qos_bandwidth_support;
 	out->informative.mode_support_info.dcfclk_support = mode_lib->ms.support.dcfclk_support;
+	out->informative.mode_support_info.dcfclk_deep_sleep_support = mode_lib->ms.support.dcfclk_deep_sleep_support;
+
 
 	for (k = 0; k < out->display_config.num_planes; k++) {
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
index b46b396f45d4..464b7b00e8c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
@@ -110,7 +110,9 @@ static void dcn6_mp_calculate_pixel_delivery_times(struct dml2_core_calculate_mp
 			inputs->PSCL_THROUGHPUT,
 			inputs->PSCL_THROUGHPUT_CHROMA,
 			inputs->Dppclk,
-			inputs->DCFCLKDeepSleep,
+		// It is unnecessary and circular to use dcfclk_deepsleep here because dcfclk_deepsleep is derived from the line transferr time
+		// dcfclk is a better value here
+			inputs->Dcfclk,
 			inputs->BytePerPixelY,
 			inputs->BytePerPixelC,
 			inputs->req_per_swath_ub_l,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index 157b579073b6..c1cb43386473 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -3434,6 +3434,9 @@ bool dcn6_ms_check_mode_support(
 		goto fail;
 	if (inputs->support.dcfclk_support == false)
 		goto fail;
+	// it is better to increase the state than to clamp dcfclk deep sleep to dcfclk, so we check if the dcfclk deep sleep is less than or equal to dcfclk
+	if (inputs->support.dcfclk_deep_sleep_support == false)
+		goto fail;
 	if (inputs->support.qos_bandwidth_support == false)
 		goto fail;
 	if (inputs->support.global_dram_clock_change_supported == false)
@@ -3679,12 +3682,17 @@ bool dcn6_ms_check_dcfclk_support(
 			&& inputs->DCFCLK <= soc_bb->max_dcfclk_khz / 1000.0
 			&& inputs->DCFCLK >= soc_bb->min_dcfclk_khz / 1000.0;
 
+	// it is better to increase the state than to clamp dcfclk deep sleep to dcfclk, so we check if the dcfclk deep sleep is less than or equal to dcfclk
+	outputs->support.dcfclk_deep_sleep_support = inputs->dcfclk_deepsleep <= inputs->DCFCLK;
+
 	DML_LOG_VERBOSE("outputs->support.dcfclk_support = %s\n", outputs->support.dcfclk_support ? "true" : "false");
+	DML_LOG_VERBOSE("outputs->support.dcfclk_deepsleep_support = %s\n", outputs->support.dcfclk_deep_sleep_support ? "true" : "false");
 
 	DML_LOG_DEBUG_BOOL(outputs->support.dcfclk_support);
+	DML_LOG_DEBUG_BOOL(outputs->support.dcfclk_deep_sleep_support);
 	DML_LOG_FUNC_EXIT();
 
-	return outputs->support.dcfclk_support;
+	return outputs->support.dcfclk_support && outputs->support.dcfclk_deep_sleep_support;
 }
 
 void dcn6_ms_check_alternate_channel_size_support(
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 9eabee1fc001..4848dbffc184 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -356,6 +356,7 @@ struct dml2_core_internal_mode_support_info {
 
 	struct dml2_core_internal_watermarks watermarks;
 	bool dcfclk_support;
+	bool dcfclk_deep_sleep_support;
 	bool qos_bandwidth_support;
 	bool alternate_channel_size_support;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
index 4f5533dc0430..7cc3a4b4b3b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_utils.c
@@ -306,6 +306,10 @@ void dml2_core_utils_print_mode_support_info(const struct dml2_core_internal_mod
 		DML_LOG_VERBOSE("DML: support: ExceededMALLSize = %d\n", support->ExceededMALLSize);
 	if (!fail_only || support->g6_temp_read_support == 0)
 		DML_LOG_VERBOSE("DML: support: g6_temp_read_support = %d\n", support->g6_temp_read_support);
+	if (!fail_only || support->dcfclk_support == 0)
+		DML_LOG_VERBOSE("DML: support: dcfclk_support = %d\n", support->dcfclk_support);
+	if (!fail_only || support->dcfclk_deep_sleep_support == 0)
+		DML_LOG_VERBOSE("DML: support: dcfclk_deepsleep_support = %d\n", support->dcfclk_deep_sleep_support);
 	if (!fail_only || (support->global_dram_clock_change_supported == 0 && support->global_dram_clock_change_support_required))
 		DML_LOG_VERBOSE("DML: support: dram_clock_change_support = %d\n", support->global_dram_clock_change_supported);
 	if (!fail_only || support->ImmediateFlipSupport == 0)
-- 
2.43.0

