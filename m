Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC87C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B6E210F72C;
	Thu, 24 Sep 2026 18:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qJ05TOuV";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013039.outbound.protection.outlook.com
 [40.107.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C8E10F72B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jU74bkEPH0lgjlGxsKDr/KZsMyjPD0qgsFisBQwRLgKj9gGRflur25+xD1JTnFDMLs9MDPFrNWdJ1Qzi4oK4JXhrK6+mmxdKaSxUexf7Dqg8fBpzonqFvNZSXYtIEX35NTCVReQe7yOCFXvPxVXySEhkSx/LiORGITtOPU+/docZxxUEq7Ihph60rjF8rdq2Y+AIUzweFEEnvdlYYsi5tvCJ8sTCBNZVmKRK1nduijKIYKn8BXin4g2CKwazdLMbcQ+NGqBwrFQLoauNGxlKHF6xuGQDhxqVhdvaraA6itecmcwAPTPgeaRzaUwOGW1pd2kwsr1aeNq4KmbOiODvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEOIQnNpoiKQ2Fzr82fiitjLAzEOZ7IuaY/qkIw7DTg=;
 b=gCFu5L3hw0/SIXIlTkTlwiNWxXDNO9qU+sUr7NS1VHQPCs71NCXsxmCdC67sqBquaXchrzUFrxAmnsI1vJQxAcM79qV76BmFQoMXmgsSe7DW3rOsaJVqS8FrIQURHEyiYpyO/NZ8ERexqX6yJ6kYizAG8AoDKVR4gzCIoqUdohtHALVY7l76a1arDhyaMEauEu4ACY4gt2gWGASKKSXTEGBccEjpLfFzhiNrnFU0PAg7rz6akruRJPKlGWvXSIXXQaQZhimVoq4QCEapnYU5XQ4/hQTZweS+X87c0nGaaWBgnOiVaEMM0Cnk2LzhMC7G2zjTqcBozv+TaAxpdU2ECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEOIQnNpoiKQ2Fzr82fiitjLAzEOZ7IuaY/qkIw7DTg=;
 b=qJ05TOuV/NtJH3sgi835aAb/BdX/m89lnjpoefFh/1Pbp2Cl09bLwZz4UL6yVxJE0uPHVkF5omqceGx5+wyom4OQ/lvT34StMTBrG7jFc+tMSx9QuTPLNFM8gS1xUsiVJ9ubAIcfHBvqjFMjQTVPjq7k/X1qqp11N6f7rrDLVbU=
Received: from PH8P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::22)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:35 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::72) by PH8P221CA0021.outlook.office365.com
 (2603:10b6:510:2d8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:35 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:18 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Chris Park
 <chris.park@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 24/34] drm/amd/display: Fix HDMI2.2 LT timeout duration
Date: Thu, 24 Sep 2026 14:45:37 -0400
Message-ID: <20260924184824.596894-25-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 342902c6-d9c3-4dde-63fc-08df1a6c2906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: QUZcZg2qYU0k80RD9siu+YEwVkhyB0KAkciCSflPdRYdifq4yqm1rSb5EEAowO3XLWsILFCAUzHGAphh7LABR71+daLU3A4WgaKGtrmI5dZBrm5mXzmLoynfSDJVdY+YWmi3Fpi6KQM89z4UrvpdIjjYMm1H4WYY0FSRbyShJuWdYFdM0OJ42iw/PjK9wWtdeYQ5vaAn6jDKCH+sKPtiwp89RkSxUQRvoqNZ5G4j2MREp25x1+iRf61BqkhYG3G14/GXEtZXep7yhLgNBt/MhfOganP44sElS5oVQL60E+k2N3i0gIOaQbQV2UyyjzAT79dXfdnX2Qr6pBHVVtG2+c5v10kE6A7Zup03+vH54NBj6teV+SAllgyyVQ7AfR2vMA9iYPt9cYud7hEBKQrdLDZY6WC9Hji161GMTKsEL4PBsQ7lVLNTov0HhKEl0lvO4jAo5S56fE3ezBNaznxlDSf7mytldosRcMfw2cenq0v3M9dQyEIgfLDo5Z2MiO7S5ZctWApb/RaT7832gbvmU8cQJucAyWZxc9VPBgr0P2EqbLOB/xDKunSBNJA2Q/X4UPIvXOrnXqkOxNEq8Q9hcULjeeUJLh9wKljFYK2Je7WZfxVTjNc94utaVi4tddDi8RsR4DQTHUC7jlmqNCTNl99Gl0H/s/fzLQa0MDUlbyKeb2K47ombTYG9UC3OywLU+L3/i1LABhpaWrFsUsLnCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6iPPBBP/+wyQ+kWoFT9ikDAc7D8i5MUaL3+8fMEOL1fYrddICFGGLlZR5tD1W8EDaAJUoWP9uawny32JI3zQfG01kc1V7LLXI24QURsaVyhnMTfYceQ1Iey2xGKaEVVrPvfeYYLn0IO+7oTz25T5XX621Lt30PAq1hRmD+kdEJC65QnEE7+A02scyGVK26XVpol1qzVFYx5HCKDA1Ns6YAvnDcuQkiCPRUcyROtT1t2jKghFuDGEG2677N1z/Q5Af4bbFBUdwJaBTrE/Yo0zAd+QiBCJt37psprcB9FGbADlmChoRh8b5thW2TxRHGgOvMuNGMmVW9qhGeGTfHcvJiMUROKu0qn/LEwDHU9eJ7ibR3m/pQMzRZmy+4j3q3jZKt2Of+xg+YxCb4qj0XXdO/wkznHkQBeoDXE07nzNwISg1pwo1goyBXDKAbDXsElN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:35.5710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 342902c6-d9c3-4dde-63fc-08df1a6c2906
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
Current method of keeping track of the LT timeout can cause the actual
elapsed time to creep past the spec-defined limits.

Adjust the behavior to make timeouts more consistent.

Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
---
 .../display/dc/link/protocols/link_hdmi_frl.c | 58 +++++++++++--------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 7f930097da18..2f1b8c0bc8f8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -442,9 +442,9 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 	union hdmi_scdc_status_flags_data status_data = {0};
 	union hdmi_scdc_source_test_req test_req = {0};
 	union hdmi_scdc_LTP_req_data ltp_req = {0};
-	uint16_t num_polls = 0;
-	uint16_t max_polls = 105;
-	unsigned long long wait_time_ns = 2000000;
+	unsigned long long poll_timeout_ns = 200 * 1000 * 1000;
+	unsigned long long wait_time_ns = 2 * 1000 * 1000;
+	unsigned long long num_polls = 0;
 	struct hpo_frl_link_encoder *hpo_frl_link_enc = ddc_service->link->hpo_frl_link_enc;
 	struct link_encoder *dio_link_enc = ddc_service->link->link_enc;
 	uint8_t sink_version = 0;
@@ -452,7 +452,6 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 	uint8_t current_FFE = 0;
 	bool override_FFE = false;
 	bool flt_no_timeout = false;
-	unsigned long long flt_poll_cur_time = 0, flt_poll_last_time = 0, flt_poll_elapsed_time_ns = 0;
 
 	DC_LOGGER_INIT(ddc_service->link->ctx->logger);
 	FRL_INFO("FRL LINK TRAINING:  Starting FRL Link Training.\n");
@@ -483,18 +482,22 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 	offset = HDMI_SCDC_STATUS_FLAGS;
 
 	/*LTS:2: Check FLT Ready, poll for 200ms */
-	while (num_polls < max_polls) {
-		flt_poll_cur_time = dm_get_timestamp(ddc_service->ctx);
-		flt_poll_elapsed_time_ns = dm_get_elapse_time_in_ns(ddc_service->ctx, flt_poll_cur_time, flt_poll_last_time);
-		if (flt_poll_elapsed_time_ns < wait_time_ns)
+	unsigned long long flt_poll_start = dm_get_timestamp(ddc_service->ctx);
+	unsigned long long flt_poll_curr = flt_poll_start;
+	unsigned long long elapsed = 0;
+
+	do {
+		flt_poll_curr = dm_get_timestamp(ddc_service->ctx);
+					elapsed = dm_get_elapse_time_in_ns(ddc_service->ctx,
+						flt_poll_curr, flt_poll_start);
+		if (elapsed < (num_polls * wait_time_ns))
 			continue;
-		flt_poll_last_time = dm_get_timestamp(ddc_service->ctx);
 		num_polls++;
 
 		link_query_ddc_data(ddc_service, slave_address,
 				&offset, sizeof(offset), &status_data.byte,
 				sizeof(status_data.byte));
-		FRL_INFO("FRL LINK TRAINING:  Read FLT_READY = %d.  num_polls = %d\n",
+		FRL_INFO("FRL LINK TRAINING:  Read FLT_READY = %d.  num_polls = %llu\n",
 				status_data.fields.FLT_READY, num_polls);
 		if (status_data.fields.FLT_READY) {
 			/* Spec recommends to clear update flag, but QD980 has problem */
@@ -506,7 +509,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 					link_settings);
 			break;
 		}
-	}
+	} while (elapsed < poll_timeout_ns);
 
 	/*Test Condition - FLT_no_timeout avoid link training*/
 	offset = HDMI_SCDC_SOURCE_TEST_REQ;
@@ -531,15 +534,19 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 		/*Start FLT Timer = 200 ms, or 300ms if link rate >= 16Gbps*/
 		num_polls = 0;
 		if (link_settings->frl_link_rate >= HDMI_FRL_LINK_RATE_16GBPS)
-			max_polls = 155;
-
-		while (num_polls < max_polls) {
-			flt_poll_cur_time = dm_get_timestamp(ddc_service->ctx);
-			flt_poll_elapsed_time_ns = dm_get_elapse_time_in_ns(ddc_service->ctx, flt_poll_cur_time, flt_poll_last_time);
-			if (flt_poll_elapsed_time_ns < wait_time_ns)
+			poll_timeout_ns = 300 * 1000 * 1000;
+		if (flt_no_timeout)
+			poll_timeout_ns = 1000 * 1000 * 1000;
+
+		flt_poll_start = dm_get_timestamp(ddc_service->ctx);
+		uint8_t prev_flt_update = 0;
+
+		do {
+			flt_poll_curr = dm_get_timestamp(ddc_service->ctx);
+					elapsed = dm_get_elapse_time_in_ns(ddc_service->ctx,
+						flt_poll_curr, flt_poll_start);
+			if (elapsed < (num_polls * wait_time_ns))
 				continue;
-			flt_poll_last_time = flt_poll_cur_time;
-
 			num_polls++;
 
 			offset = HDMI_SCDC_UPDATE_0;
@@ -548,8 +555,12 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 							&offset, sizeof(offset), &scdc_update.byte[0],
 							sizeof(scdc_update.byte[0]));
 
-			FRL_INFO("FRL LINK TRAINING:  Read FLT_UPDATE = %d.  num_polls = %d\n",
-					scdc_update.fields.FLT_UPDATE, num_polls);
+			if (prev_flt_update != scdc_update.fields.FLT_UPDATE) {
+				FRL_INFO("FRL LINK TRAINING: FLT_UPDATE=%d polls=%llu\n",
+						scdc_update.fields.FLT_UPDATE, num_polls);
+				prev_flt_update = scdc_update.fields.FLT_UPDATE;
+			}
+
 			/*Set TxFFE = TxFFE0*/
 			/*Program FFE_Levels - scdc_config has this field at 0 */
 			if (override_FFE) {
@@ -680,11 +691,8 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 				/* Workaround for DEDCN3AG-111
 				 * HDMI-FRL Incorrect Serialization Order for LTP4
 				 */
-				if (flt_no_timeout) {
-					return LINK_RESULT_SUCCESS;
-				}
 			}
-		}
+		} while (elapsed < poll_timeout_ns);
 		FRL_INFO("FRL LINK TRAINING:  FAILED - Timeout waiting for FLT_UPDATE to be set by sink.\n");
 		write_buffer[0] = HDMI_SCDC_CONFIG_1;
 		/*FRL_RATE*/
-- 
2.53.0

