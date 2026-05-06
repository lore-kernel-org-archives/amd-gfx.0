Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C767CD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14DB10ECCD;
	Wed,  6 May 2026 07:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2fayDK7o";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F4710ECCD
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:04:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qaoaom6yxJGD4bTpXe9C5ACj0ijX2RB5jB4gPVdIyLXERcLSed++iYNTG/9Jm7yfiYFyT5iKZ3v744p7hw6m05gx7EGTLXXkj6073u7/9lneg8R/lpG6ZpZyebxobNZRuLlru+5BlacSYEjzPQ4wpVqYz72epjKJ2GSfzpBUJce5N7gX53SnDDBAkBBN30rdaG+Ttfdr9dZMxgspkkg1d7A+xYMh5AQNljHwOgXBYcOMWH0uKk+bYUneFJa7SEIIc7fMiFdU68P785Yvlv+9zwMZ8U5oupjaPXTVBf4NHPhZHbndkgY5by63jWv4OZ3BQE80MV9TG/opkPy4hSyy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/m5or+oj4sDfdn6+06nafw85VIwb7h2NFI3DoezjMM=;
 b=tLr5KveF9Hynhd/fVE6FLAkFANTKLtZT9+H54wNor6zvt+5S8ZN0iZ+YFtbH74GounDpLAsRIKObBdD3aS4AlaLAmDgJTzOcHJg5qV6VKl4fYpHOkFXlacE5qC+q2coa2HR+eHgNmCGQgxOexEdeavwrDGMGeGbJSOE6dkQuMbL7lC2NPgrNstzanSzoBAC3Rd5mOUGdBmmuAa4DweLYFM2m9jAlDOztzOo3G8lwfjHWlzkQ3SztcVAIhFOeWimbr0hFwn2DN2oRTjhj2ZG+7IDR5CrARq4v7j2wwEvIRTS2bDbWl6wcohZSJ8vau/GzgxQ3d3vZa/LiYpu7Pfos7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/m5or+oj4sDfdn6+06nafw85VIwb7h2NFI3DoezjMM=;
 b=2fayDK7oZKWzKrIo5VjEPUzexqCrEcAPCXnxkctErVzfFhQVSk2IlGzgUCUdJK6rHS/Qjnlrmyy45xIZwTSiy2FcYk8WtEGi7Q6kZt4gwu6/P5HncL4d0Ad4n2j1PjX7TWJkGBMratgPypjI8PdaxX2HO5FbFqjxrjnSsbtd5w0=
Received: from MN2PR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:23a::18)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.17; Wed, 6 May 2026 07:04:29 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::42) by MN2PR03CA0013.outlook.office365.com
 (2603:10b6:208:23a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 07:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:04:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:04:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:04:28 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:04:19 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Nevenko
 Stupar" <nevenko.stupar@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, "James
 Lin" <pinglei.lin@amd.com>
Subject: [PATCH 09/20] drm/amd/display: Refactor dc_link_aux_transfer_raw
Date: Wed, 6 May 2026 12:31:07 +0800
Message-ID: <20260506043342.2164710-10-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6ebb64-9fb7-4bfa-9f7b-08deab3db79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: BsTfwMksNHLi5BS/WobnU+q6jB7v04p3G8kEokxI3r9on+FY8dLaxuRrSqCNmy9SCxoOXWNY6Jo2OO6s1Nk7/CJOgLdIYsOqldBe9vrS+ciIMXDBwj0kqepFGv/bsMT0iElxTabxpEb8PeEgrU9StXjOOqCrMDwMgYSaayn+cOhwHAzQ3nopI4j4QGZZ2+wgkEZ04eA4ecDtkCFqJP58kju5KoT6pZfzpYPEuqReVwIs0XFJcUmTpHZ01ddC4L5+mbahANqN3r7t/9hGlJkHAO1+2isIVOgXCHrDc245RV0/54SxY6R7D6+bCRrgZl0pVZzAQCJZoJ27fQSUw6h7+0JrVHjxhd4RErrt5sN6tPReGvNcTA1u4r5lozWqTgfny7WR1JLLiEcrV+n7uhSd//3GPD3GzsGkNifhnS93PQDZlA1QCn+GQ4yJ8Pl6f6wDiQHmA2XZdlmfa3s8fcHegGI4xWHISQOLRiIEUGh6YHLhKXpspzvANgg6Tvz6w+/t3p8WrJqy4C3wFehN9lqMxG3gaVJFwEjklJ/eba0CP6dkOL5JUoTGowugxb1Fj5UWqNxwoSzcDs2bQcsTXRBCtIUHFTYB2QfIwCB4RqgSRcP9bWhjUj+85q5vu1uhQg8HszmKmBCZSG4ibUW1q2+KU7E19tE6q4RP93IGBw71Ty8fOdhInNfeGa1GbDZyz3wOSc3FytsMiv61H2ke0F8D38+t9cL3KPEmJDp5Fv1OGEA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q8eaKhHg+PU2dgDgRIuQgDr42U0tHxrUju6Tqpu5DnF00YDSrbrV7rYOo9luNLKM63ZTcdLoXEkHVvVLAeuthkG7S1gOXQRfIdoH1T9/kOiYDTplFj0FS0D/hJiup0nTqB+NZz4KTElNVwy1ihMWcIReUR4vWOjQaFrTTw6Ty/J2qa43/cbhs5G64Vta/t94yX5QJxbpwZ7p3f2ZHiiJwsj1YHWcO7YxEYCEjkzvHuQYJow+/IcTDRMDl8y6UVRPfHfTYtVA1B6sCrcbZXPu43LtreGDB81Sxe2tmL1OErPB/awwzvdmENO7bjqs75rnOi4PN685v/cQKTa5SExzP3JzGCmsPkP0EtVlV7jQQKLHmcq8eH0M3WhOtVXtrt/0m1MktsQV0mag8wkyzykbifwz4vOwNaRywuTT96DLURjTfbiTzmRFvIbIZV+hD9UK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:04:29.4604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6ebb64-9fb7-4bfa-9f7b-08deab3db79c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
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

From: Matthew Stewart <Matthew.Stewart2@amd.com>

[Why & How]
The logic for choosing between the dce_aux_transfer function variants is
moved into dce_aux.c rather than link_ddc.c.

The "dce_aux_transfer_with_retries" function now uses
dce_aux_transfer_raw in its implementation as the logic is equivalent.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  | 20 ++++++++++++-------
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |  4 ++++
 .../amd/display/dc/link/protocols/link_ddc.c  |  7 +------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index eee58f946fae..181944ce77ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -559,6 +559,18 @@ static enum i2caux_transaction_action i2caux_action_from_payload(struct aux_payl
 int dce_aux_transfer_raw(struct ddc_service *ddc,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
+{
+	if (ddc->ctx->dc->debug.enable_dmub_aux_for_legacy_ddc ||
+	    !ddc->ddc_pin) {
+		return dce_aux_transfer_dmub_raw(ddc, payload, operation_result);
+	} else {
+		return dce_aux_transfer_raw_with_ddc_pin(ddc, payload, operation_result);
+	}
+}
+
+int dce_aux_transfer_raw_with_ddc_pin(struct ddc_service *ddc,
+		struct aux_payload *payload,
+		enum aux_return_code_type *operation_result)
 {
 	struct ddc *ddc_pin = ddc->ddc_pin;
 	struct dce_aux *aux_engine;
@@ -740,13 +752,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 		if (payload->write)
 			dce_aux_log_payload("  write", payload->data, payload->length, 16);
 
-		/* Check whether aux to be processed via dmub or dcn directly */
-		if (ddc->ctx->dc->debug.enable_dmub_aux_for_legacy_ddc
-			|| ddc->ddc_pin == NULL) {
-			ret = dce_aux_transfer_dmub_raw(ddc, payload, &operation_result);
-		} else {
-			ret = dce_aux_transfer_raw(ddc, payload, &operation_result);
-		}
+		ret = dce_aux_transfer_raw(ddc, payload, &operation_result);
 
 		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
 					LOG_FLAG_I2cAux_DceAux,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
index c850ed49281f..8f4745694016 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
@@ -304,6 +304,10 @@ int dce_aux_transfer_raw(struct ddc_service *ddc,
 		struct aux_payload *cmd,
 		enum aux_return_code_type *operation_result);
 
+int dce_aux_transfer_raw_with_ddc_pin(struct ddc_service *ddc,
+		struct aux_payload *cmd,
+		enum aux_return_code_type *operation_result);
+
 int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index ef9306686b14..70f854cca029 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -401,12 +401,7 @@ int link_aux_transfer_raw(struct ddc_service *ddc,
 		struct aux_payload *payload,
 		enum aux_return_code_type *operation_result)
 {
-	if (ddc->ctx->dc->debug.enable_dmub_aux_for_legacy_ddc ||
-	    !ddc->ddc_pin) {
-		return dce_aux_transfer_dmub_raw(ddc, payload, operation_result);
-	} else {
-		return dce_aux_transfer_raw(ddc, payload, operation_result);
-	}
+	return dce_aux_transfer_raw(ddc, payload, operation_result);
 }
 
 uint32_t link_get_fixed_vs_pe_retimer_write_address(struct dc_link *link)
-- 
2.43.0

