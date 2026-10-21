Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE8606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hSsDWcKw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 727A910F959;
	Wed, 21 Oct 2026 06:27:17 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5813B10F959
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elm9RJK9ha5nNeR5GlGaXFPk7IlMIlDmQKK6A1adISepdydbEEw4fqS5VfIvDVbeWo5qQRx7eDYreJyk+egAxuqBzJVyba21+mOvCmNlHTWMi+d2bWX6ab+JssUlWMW1v3wwWHO0OFedXWu9+eoa8zO8/CIEb+eiZCewN5FcV4p8+WrW50wopwp/dRauhoabAosOsTfyLdKchXva0FILPS8JyKyHRaNXb0b6Hh20Rl3ArRrOKgZH8SKCJ7DB+ojSgIxJcG8/gMHegjlQwPy36qBtZ5hEad4KiUQ9kxPKZhRLLJhh016mq5PhkzLv/hRUqsoCnHJ3+FTvshOT03iYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2JDWdbGgs7e3j9dh9MK9MUWy6GH+efxqo0zSSGmpBA=;
 b=InnpPeGTeyAJ67dvGdST5SQleYC9TTdWG0sojm+AvZoCBxRlYzMe4b+2n3McyqSHfoSUb+NuHms8v662WkhLCObRWwPEyqd9hG/2XHur4Nl/vMiIWrJ5zJIkuQ/PBuyRXp3NF0Hvmz3ES7RrSX4ZZKXjhGQKAkJ5Q/btJ+OpRA1wZhWs3c7e7aBp3c9RndXqbjYfiBNP4Chk2bwQpSDdaVsK01NTRGBhxIZCIMLIOSUNc1qLG+QM6oLGX3GdNouOYBtJHwJBp5tshm++9YwRykyn2Ybbd7vrZP6c1vm0C+cqrXsoKt+xS3kt4mj39MVPe9SyIO74d8eyxrCUf80Lvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2JDWdbGgs7e3j9dh9MK9MUWy6GH+efxqo0zSSGmpBA=;
 b=hSsDWcKw2IO8b9HpXNV4Bo4dtXnvxqw+U+hW/GXZbTvuAQC1u+EQz3Fk8arqgASlLB+U+sTfpTio00oestboLVa3MTXW84UK/r0DjUayWC5VR0oMQzLsqpSvD46onddaxpTvytTHedW1+DSMLFYtEWor6qT3qcoVZmBg8UOFiIw=
Received: from BN9PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:fb::29)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:27:07 +0000
Received: from BN1PEPF00018545.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::a0) by BN9PR03CA0054.outlook.office365.com
 (2603:10b6:408:fb::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 21 Oct 2026 06:27:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018545.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:06 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:03 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 28/49] drm/amd/display: fec_status check flow
Date: Wed, 21 Oct 2026 14:22:34 +0800
Message-ID: <20261021062519.674697-29-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018545:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b5260b-2360-487c-dedf-08df2f3c548b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|22082099003|10067099003|18002099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: P+YuXswDPAlMEP4Bb5CoGLM5cZmoPMWJBNQvtMtCOgAS02qe36EACTq7CiR6SW1C36oAEJUK7u83T1dvYAfEbG1Sabzy8gAW0nuSsu9nx25oGBWnH5+cz7hQZBRG3dfwdGG0larRT8S+tWKn6u6GtJEZYDU8s//8n3IvRhVTyOy9vhqHohOmKMZKV7ItYI/zYOMvlR1qZbSbwhqtHd3BGRjUMY33sIzQreReeqNI0x4Ivm/358rqZAKveAXQcG1Kj3Ae7/sXMgUWnIACQ5EAKeiMUSXOuLuauOehEFCKXx+2ZJ5YKV+4/3LIGs8CQHWnhLYmyM35r17NASh/oiGqGSrkyRD3rfPmDPRUwUEf8WNBs3DqTVDoHBhHJ8S54FVVxqNjXCEwvH8SW+vstFV8Csnun2Re3lTlaNlLyMrWeRE754lfcpuOHK4NXQa3gWtyVmC7xsfeQQJONRTShj6xB6uJbPsqp0GdqqfxuCBQwByQ30nrXN+TqecXJ65Df77V44s5ULUvHMigEdOszBOoGLfIU9pi13/22IgwXSokeTmDaekRJUheb27zAr+o0Ra5zWE54TSnEN1cYV7xScjXH7jnme15ezbCkG1l98JeUX2SD6NTpRNUhKQvx6OkG8PePeoVAsovBpJwuLtPRKNRO+fvXcQvq7vKTv9uDxwE7KgrVRGzEMea+2pzYotnkhDfZ+3kc+H8DXxH8FJzTq5OJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(22082099003)(10067099003)(18002099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2srjnqVzU87bso4BhrdQ598qSZIHbcXhBYYcy5N/tSgFCw33Aux+1Du7vR/F6kD9Tzepjyp2axCOGNWjiMgnbaLrEpwG59EXPGqd0jmPnmYFnd0A1IpFjlu5Dsopun2w0GbSwOJs0VtRPTJbYDJcS5bQ+TaNbabQpNW8VbhvDydUc/JdVcX98NBRAmUAzmKx5bR5ZhXeykhgV0GsfDZCev9xnCYWRGR9KsqNsbh8/U53FjRPPv3akOPPj9ir7wh8KB6pvsEoECxxNQC6pj9GsbQ+/BbGiBDMMalRFqCVd6E1k6ujdn9SU5urNfoAURm0e5bKf4+e8iaIoOmsGBamusKVVCBT8Pp40JFDYudr9w/S+LX6d9uOWmtLzN/o9qa4RZUZPPvRb7GDEWmYnABLPURv4Xwmsucw202eb5Z6CtkjBHjNDZ+PX+sgpmeyBDEq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:07.2458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b5260b-2360-487c-dedf-08df2f3c548b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018545.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY]
Implement fec_status check flow for 8b10b link.

[HOW]
Check fec_status twice after 8b10b link training done as the spec requires.

Reviewed-by: George Shen <george.shen@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 56 ++++++++++++++++---
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 9b5b0599d977..36700df2d607 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2100,6 +2100,52 @@ static enum dc_status enable_link_hdmi_frl(struct pipe_ctx *pipe_ctx)
 	return status;
 }
 
+/* Post-link-training activity per DP spec: enable FEC and confirm the sink
+ * reports decode-enable within a couple of retries. If the sink never
+ * confirms, leave FEC enabled to align legacy behavior.
+ */
+static void verify_fec_status_after_training(struct dc_link *link,
+		struct pipe_ctx *pipe_ctx,
+		const struct dc_link_settings *link_settings)
+{
+	uint8_t fec_status = 0;
+	uint8_t fec_retry_cnt = 0;
+	uint8_t fec_delay_cnt = 0;
+
+	if (link_dp_get_encoding_format(link_settings) != DP_8b_10b_ENCODING ||
+			link->fec_state != dc_link_fec_ready)
+		return;
+
+	do {
+		/* Clear stale FEC_STATUS bits left over from a previous
+		 * enable/disable cycle before waiting for a fresh
+		 * decode-enable detection from the sink.
+		 */
+		fec_status = DP_FEC_DECODE_EN_DETECTED | DP_FEC_DECODE_DIS_DETECTED;
+		core_link_write_dpcd(link, DP_FEC_STATUS, &fec_status, sizeof(fec_status));
+
+		dp_set_fec_enable(link, &pipe_ctx->link_res, true);
+
+		fec_delay_cnt = 0;
+		while (fec_delay_cnt <= 4) {
+			msleep(1);
+			fec_status = 0;
+			core_link_read_dpcd(link, DP_FEC_STATUS, &fec_status, sizeof(fec_status));
+			if (fec_status & 0x01)
+				break;
+			fec_delay_cnt++;
+		}
+
+		if (fec_status & 0x01)
+			break;
+
+		fec_retry_cnt++;
+
+		if (fec_retry_cnt <= 1)
+			dp_set_fec_enable(link, &pipe_ctx->link_res, false);
+	} while (fec_retry_cnt <= 1);
+}
+
 static enum dc_status enable_link_dp(struct dc_state *state,
 				     struct pipe_ctx *pipe_ctx)
 {
@@ -2109,7 +2155,6 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	struct dc_link *link = stream->link;
 	const struct dc_link_settings *link_settings =
 			&pipe_ctx->link_config.dp_link_settings;
-	bool fec_enable;
 	int i;
 	bool apply_seamless_boot_optimization = false;
 	uint32_t bl_oled_enable_delay = 50; // in ms
@@ -2194,18 +2239,11 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 					       pipe_ctx->stream->signal,
 					       do_fallback)) {
 		status = DC_OK;
+		verify_fec_status_after_training(link, pipe_ctx, link_settings);
 	} else {
 		status = DC_FAIL_DP_LINK_TRAINING;
 	}
 
-	if (link->preferred_training_settings.fec_enable)
-		fec_enable = *link->preferred_training_settings.fec_enable;
-	else
-		fec_enable = true;
-
-	if (link_dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING)
-		dp_set_fec_enable(link, &pipe_ctx->link_res, fec_enable);
-
 	// during mode set we do DP_SET_POWER off then on, aux writes are lost
 	if (link->dpcd_sink_ext_caps.bits.oled == 1 ||
 		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1 ||
-- 
2.43.0

