Return-Path: <SRS0=Y/Ds=M5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F94C4320A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C6B61181
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Aug 2021 16:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94C6B61181
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 802C46EB97;
	Fri,  6 Aug 2021 16:36:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD2A6EC2C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Aug 2021 16:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK5TVgw155J5BxLcBZ6mLh4jHAFT+ozqVW8c/boF35XsiyshuMhfDhEPubhoOxK/moWyD1UChamBuzEnIOJM7DdSIYBg3i48mu57gZo4KQC5O6K1Hn3MtHZWqIYzW/FXkSDUJIecWpEExnWXaABwu9u0TVUEgSzkT7UrIhOJD2ylCyzIMatrLrtHzOQlUGJse3r0rjW6E/lf+ttwjyAEs9SydchxaLEqs6T+mpu8+DrjJCd80y0+/xy7nfW0NH2Pwj24Di26g32M5v99GKoRr4gPSVz65mo6NPBvFNwrXAR0iC3B/6ZO9G0f2cQDJ5ySLAXB6jbPPFU1futtZ/W8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqpoW8Kkwkmf0gEiAzVU41Om09nlU+wTw06prra6V9Y=;
 b=UXR0dGz24HF+WfrmdFnxiSWqPNiI8Xt24iGvUN3pVbwu/GOFoq9jJgYPhfSdinyu+I9Nsrm3fxRgxhourk0RL/Z+KxRSpjdUC6O6Z67mmY6aXfVjBczPUYuYjelLZeBQ362w8oL/LsZ/EQYlJpzmtEeGK484gTG47StQWOGJ0fv8nqSYJDfLg2+uLgNVX1ZJKSWeON3T32EnD/RY1NNWVWdQETM392AZ5nRxjUFdjod4999m68qRadn0xTcOoXzB4uqIp66D29aBqQw6HccbkV6+T3TOOFv52eyHMrBziNdU2QFn/kY+zVSe4j3NBIFjYCo6OdQlaoP5NfWQiWuIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqpoW8Kkwkmf0gEiAzVU41Om09nlU+wTw06prra6V9Y=;
 b=xLo1Yf8zsZ/9GAK9tjrdWue723Ol0RuG+qm1ZDGLspDNEqwM+rjg4/H4JGPICbEj7eTSd2Ay81Q9cMEbbpWOG/0aUw9qM66qX0FTF/GMMEstiC8OkVgzAtiIsOAIaW8pPCWw0X9XxOKDPR7ArbpLvm+QtKOmWDBAQ4DcOS+OFp4=
Received: from BN9PR03CA0105.namprd03.prod.outlook.com (2603:10b6:408:fd::20)
 by DM5PR12MB1257.namprd12.prod.outlook.com (2603:10b6:3:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 16:35:47 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::a) by BN9PR03CA0105.outlook.office365.com
 (2603:10b6:408:fd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Fri, 6 Aug 2021 16:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 16:35:46 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 11:35:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 09:35:46 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 6 Aug 2021 11:35:44 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <Eryk.Brol@amd.com>,
 <bindu.r@amd.com>, <Anson.Jacob@amd.com>, Ashley Thomas
 <Ashley.Thomas2@amd.com>, Zhan Liu <zhan.liu@amd.com>
Subject: [PATCH 07/13] drm/amd/display: Add AUX I2C tracing.
Date: Fri, 6 Aug 2021 12:34:43 -0400
Message-ID: <20210806163449.349757-8-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210806163449.349757-1-Anson.Jacob@amd.com>
References: <20210806163449.349757-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bff464e-315a-492c-606c-08d958f83e44
X-MS-TrafficTypeDiagnostic: DM5PR12MB1257:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1257A114B3ED3F6A9D1A69E2EBF39@DM5PR12MB1257.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oytvwnJPeL9mNoyeE6VUUxGLhV0cpYHX6ik/pvyPwtJHBftp0mI0PVdQNmfXac4iw15/uwfLB8p9MjKUyL+zHNTrNnPQ4Zjnx+Z78+rdcgFj9S7bsTeCfsDQwTvld9wPRVlroK3WViIzzCmD2wjYqgIR1Lyt/b6ayrN2EG0LX81dWSBMfkQTFXJZSkmrUMslsTpbUo3m/c8tlFxoq9jvruJmzCECShK8qFdC+1qYBUTbiX+Q/KYk9KBufVsrvOgKcVuJ2sXVJGlU/pFNeAx0puGoMrxegG8pgm1KpravtzywN/a2ICSIPqwrZiH6wswYSAVX4AFTG92mF07I5aUTmkPytn4VoIBhOV+kvDihPqglMQXTzyNp6FaenfzTW8FuqwDEHdZ5+PI8o/O5nVGZLzcbDe6TG0sZ6d/1RkEkm6rfjkzpNsiUH/y40Sg5w8pDrewerQbqzYeHtLHhngqhcUfxZ29Ark33wK5GB+sQrZcJeOxfat9cbAItVT5op0fBOEqDk5R81UWA4qJgpbpwLXeZy1DIxsMyWc/1EUUnokfPb3gYyVa4sDnbGIjIKuepDhIwr7NXHVK7zcgCZzRSxqH4/mNv2zdhKP3qdDsQgK02X0nS3FkPjOO2IdSTC7CtQTeLfjhUCTcyrukoJXWEs52wGdhNMFzz/351wXPTOC7wJ7PAScXHU5LN/rBoYKE/9rl1wWgkF8yFvJYHL+sbDxCCD+6Xacuef03w8GRHjos=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(54906003)(1076003)(26005)(316002)(8936002)(30864003)(19627235002)(82740400003)(4326008)(6916009)(478600001)(8676002)(7696005)(70206006)(336012)(70586007)(5660300002)(2616005)(36860700001)(86362001)(356005)(47076005)(82310400003)(426003)(81166007)(36756003)(83380400001)(186003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 16:35:46.8998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bff464e-315a-492c-606c-08d958f83e44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1257
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

From: Ashley Thomas <Ashley.Thomas2@amd.com>

[Why]
Developers can find it useful if the driver can produce
AUX traces without special equipment.

[How]
Add AUX tracing.

Reviewed-by: Zhan Liu <zhan.liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Ashley Thomas <Ashley.Thomas2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 192 ++++++++++++++++++-
 1 file changed, 183 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 058a9356a39a..e14f99b4b0c3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -42,6 +42,11 @@
 #define DC_LOGGER \
 	engine->ctx->logger
 
+#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
+#define IS_DC_I2CAUX_LOGGING_ENABLED() (false)
+#define LOG_FLAG_Error_I2cAux LOG_ERROR
+#define LOG_FLAG_I2cAux_DceAux LOG_I2C_AUX
+
 #include "reg_helper.h"
 
 #undef FN
@@ -623,6 +628,58 @@ int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
 #define AUX_MAX_INVALID_REPLY_RETRIES 2
 #define AUX_MAX_TIMEOUT_RETRIES 3
 
+static void dce_aux_log_payload(const char *payload_name,
+	unsigned char *payload, uint32_t length, uint32_t max_length_to_log)
+{
+	if (!IS_DC_I2CAUX_LOGGING_ENABLED())
+		return;
+
+	if (payload && length) {
+		char hex_str[128] = {0};
+		char *hex_str_ptr = &hex_str[0];
+		uint32_t hex_str_remaining = sizeof(hex_str);
+		unsigned char *payload_ptr = payload;
+		unsigned char *payload_max_to_log_ptr = payload_ptr + min(max_length_to_log, length);
+		unsigned int count;
+		char *padding = "";
+
+		while (payload_ptr < payload_max_to_log_ptr) {
+			count = snprintf_count(hex_str_ptr, hex_str_remaining, "%s%02X", padding, *payload_ptr);
+			padding = " ";
+			hex_str_remaining -= count;
+			hex_str_ptr += count;
+			payload_ptr++;
+		}
+
+		count = snprintf_count(hex_str_ptr, hex_str_remaining, "   ");
+		hex_str_remaining -= count;
+		hex_str_ptr += count;
+
+		payload_ptr = payload;
+		while (payload_ptr < payload_max_to_log_ptr) {
+			count = snprintf_count(hex_str_ptr, hex_str_remaining, "%c",
+				*payload_ptr >= ' ' ? *payload_ptr : '.');
+			hex_str_remaining -= count;
+			hex_str_ptr += count;
+			payload_ptr++;
+		}
+
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_VERBOSE,
+					LOG_FLAG_I2cAux_DceAux,
+					"dce_aux_log_payload: %s: length=%u: data: %s%s",
+					payload_name,
+					length,
+					hex_str,
+					(length > max_length_to_log ? " (...)" : " "));
+	} else {
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_VERBOSE,
+					LOG_FLAG_I2cAux_DceAux,
+					"dce_aux_log_payload: %s: length=%u: data: <empty payload>",
+					payload_name,
+					length);
+	}
+}
+
 bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 		struct aux_payload *payload)
 {
@@ -648,7 +705,34 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 	}
 
 	for (i = 0; i < AUX_MAX_RETRIES; i++) {
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+					LOG_FLAG_I2cAux_DceAux,
+					"dce_aux_transfer_with_retries: link_index=%u: START: retry %d of %d: address=0x%04x length=%u write=%d mot=%d",
+					ddc && ddc->link ? ddc->link->link_index : UINT_MAX,
+					i + 1,
+					(int)AUX_MAX_RETRIES,
+					payload->address,
+					payload->length,
+					(unsigned int) payload->write,
+					(unsigned int) payload->mot);
+		if (payload->write)
+			dce_aux_log_payload("  write", payload->data, payload->length, 16);
 		ret = dce_aux_transfer_raw(ddc, payload, &operation_result);
+		DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+					LOG_FLAG_I2cAux_DceAux,
+					"dce_aux_transfer_with_retries: link_index=%u: END: retry %d of %d: address=0x%04x length=%u write=%d mot=%d: ret=%d operation_result=%d payload->reply=%u",
+					ddc && ddc->link ? ddc->link->link_index : UINT_MAX,
+					i + 1,
+					(int)AUX_MAX_RETRIES,
+					payload->address,
+					payload->length,
+					(unsigned int) payload->write,
+					(unsigned int) payload->mot,
+					ret,
+					(int)operation_result,
+					(unsigned int) *payload->reply);
+		if (!payload->write)
+			dce_aux_log_payload("  read", payload->data, ret > 0 ? ret : 0, 16);
 
 		switch (operation_result) {
 		case AUX_RET_SUCCESS:
@@ -657,30 +741,64 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 
 			switch (*payload->reply) {
 			case AUX_TRANSACTION_REPLY_AUX_ACK:
+				DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+							LOG_FLAG_I2cAux_DceAux,
+							"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_AUX_ACK");
 				if (!payload->write && payload->length != ret) {
-					if (++aux_ack_retries >= AUX_MAX_RETRIES)
+					if (++aux_ack_retries >= AUX_MAX_RETRIES) {
+						DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+									LOG_FLAG_Error_I2cAux,
+									"dce_aux_transfer_with_retries: FAILURE: aux_ack_retries=%d >= AUX_MAX_RETRIES=%d",
+									aux_defer_retries,
+									AUX_MAX_RETRIES);
 						goto fail;
-					else
+					} else {
 						udelay(300);
+					}
 				} else
 					return true;
 			break;
 
 			case AUX_TRANSACTION_REPLY_AUX_DEFER:
+				DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+							LOG_FLAG_I2cAux_DceAux,
+							"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_AUX_DEFER");
+
 				/* polling_timeout_period is in us */
 				defer_time_in_ms += aux110->polling_timeout_period / 1000;
 				++aux_defer_retries;
 				fallthrough;
 			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER:
+				if (*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)
+					DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+								LOG_FLAG_I2cAux_DceAux,
+								"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER");
+
 				retry_on_defer = true;
 				fallthrough;
 			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK:
+				if (*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK)
+					DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+								LOG_FLAG_I2cAux_DceAux,
+								"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK");
+
 				if (aux_defer_retries >= AUX_MIN_DEFER_RETRIES
 						&& defer_time_in_ms >= AUX_MAX_DEFER_TIMEOUT_MS) {
+					DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+								LOG_FLAG_Error_I2cAux,
+								"dce_aux_transfer_with_retries: FAILURE: aux_defer_retries=%d >= AUX_MIN_DEFER_RETRIES=%d && defer_time_in_ms=%d >= AUX_MAX_DEFER_TIMEOUT_MS=%d",
+								aux_defer_retries,
+								AUX_MIN_DEFER_RETRIES,
+								defer_time_in_ms,
+								AUX_MAX_DEFER_TIMEOUT_MS);
 					goto fail;
 				} else {
 					if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
 						(*payload->reply == AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER)) {
+						DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+									LOG_FLAG_I2cAux_DceAux,
+									"dce_aux_transfer_with_retries: payload->defer_delay=%u",
+									payload->defer_delay);
 						if (payload->defer_delay > 1) {
 							msleep(payload->defer_delay);
 							defer_time_in_ms += payload->defer_delay;
@@ -693,37 +811,86 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 				break;
 
 			case AUX_TRANSACTION_REPLY_I2C_DEFER:
+				DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+							LOG_FLAG_I2cAux_DceAux,
+							"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_I2C_DEFER");
+
 				aux_defer_retries = 0;
-				if (++aux_i2c_defer_retries >= AUX_MAX_I2C_DEFER_RETRIES)
+				if (++aux_i2c_defer_retries >= AUX_MAX_I2C_DEFER_RETRIES) {
+					DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+								LOG_FLAG_Error_I2cAux,
+								"dce_aux_transfer_with_retries: FAILURE: aux_i2c_defer_retries=%d >= AUX_MAX_I2C_DEFER_RETRIES=%d",
+								aux_i2c_defer_retries,
+								AUX_MAX_I2C_DEFER_RETRIES);
 					goto fail;
+				}
 				break;
 
 			case AUX_TRANSACTION_REPLY_AUX_NACK:
+				DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+							LOG_FLAG_I2cAux_DceAux,
+							"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_AUX_NACK");
+				goto fail;
+
 			case AUX_TRANSACTION_REPLY_HPD_DISCON:
+				DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+							LOG_FLAG_I2cAux_DceAux,
+							"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_HPD_DISCON");
+				goto fail;
+
 			default:
+				DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+							LOG_FLAG_Error_I2cAux,
+							"dce_aux_transfer_with_retries: AUX_RET_SUCCESS: FAILURE: AUX_TRANSACTION_REPLY_* unknown, default case.");
 				goto fail;
 			}
 			break;
 
 		case AUX_RET_ERROR_INVALID_REPLY:
-			if (++aux_invalid_reply_retries >= AUX_MAX_INVALID_REPLY_RETRIES)
+			DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+						LOG_FLAG_I2cAux_DceAux,
+						"dce_aux_transfer_with_retries: AUX_RET_ERROR_INVALID_REPLY");
+			if (++aux_invalid_reply_retries >= AUX_MAX_INVALID_REPLY_RETRIES) {
+				DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+							LOG_FLAG_Error_I2cAux,
+							"dce_aux_transfer_with_retries: FAILURE: aux_invalid_reply_retries=%d >= AUX_MAX_INVALID_REPLY_RETRIES=%d",
+							aux_invalid_reply_retries,
+							AUX_MAX_INVALID_REPLY_RETRIES);
 				goto fail;
-			else
+			} else
 				udelay(400);
 			break;
 
 		case AUX_RET_ERROR_TIMEOUT:
+			DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+						LOG_FLAG_I2cAux_DceAux,
+						"dce_aux_transfer_with_retries: AUX_RET_ERROR_TIMEOUT");
 			// Check whether a DEFER had occurred before the timeout.
 			// If so, treat timeout as a DEFER.
 			if (retry_on_defer) {
-				if (++aux_defer_retries >= AUX_MIN_DEFER_RETRIES)
+				if (++aux_defer_retries >= AUX_MIN_DEFER_RETRIES) {
+					DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+								LOG_FLAG_Error_I2cAux,
+								"dce_aux_transfer_with_retries: FAILURE: aux_defer_retries=%d >= AUX_MIN_DEFER_RETRIES=%d",
+								aux_defer_retries,
+								AUX_MIN_DEFER_RETRIES);
 					goto fail;
-				else if (payload->defer_delay > 0)
+				} else if (payload->defer_delay > 0) {
+					DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+								LOG_FLAG_I2cAux_DceAux,
+								"dce_aux_transfer_with_retries: payload->defer_delay=%u",
+								payload->defer_delay);
 					msleep(payload->defer_delay);
+				}
 			} else {
-				if (++aux_timeout_retries >= AUX_MAX_TIMEOUT_RETRIES)
+				if (++aux_timeout_retries >= AUX_MAX_TIMEOUT_RETRIES) {
+					DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+								LOG_FLAG_Error_I2cAux,
+								"dce_aux_transfer_with_retries: FAILURE: aux_timeout_retries=%d >= AUX_MAX_TIMEOUT_RETRIES=%d",
+								aux_timeout_retries,
+								AUX_MAX_TIMEOUT_RETRIES);
 					goto fail;
-				else {
+				} else {
 					/*
 					 * DP 1.4, 2.8.2:  AUX Transaction Response/Reply Timeouts
 					 * According to the DP spec there should be 3 retries total
@@ -738,11 +905,18 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 		case AUX_RET_ERROR_ENGINE_ACQUIRE:
 		case AUX_RET_ERROR_UNKNOWN:
 		default:
+			DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_INFORMATION,
+						LOG_FLAG_I2cAux_DceAux,
+						"dce_aux_transfer_with_retries: Failure: operation_result=%d",
+						(int)operation_result);
 			goto fail;
 		}
 	}
 
 fail:
+	DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+				LOG_FLAG_Error_I2cAux,
+				"dce_aux_transfer_with_retries: FAILURE");
 	if (!payload_reply)
 		payload->reply = NULL;
 
-- 
2.25.1

