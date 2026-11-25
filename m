Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6FE606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oRGmlVEQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E99610E65D;
	Wed, 25 Nov 2026 06:55:52 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF55D10EF25
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:55:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uS1PFfqThYM2RG2htkCAd9Ph956P9jSW/IQYtQj8hUQbOTsiW+Ih3bydvUpMK5wNePF6fqL3gaJEVar+LwWWT5TYR5nAM3AXJmvQ2gPoDJLdEUEzFMxgLYHgWxFmxZcMTqwxQMi72gRTclnHkBb8WjGtVHSPqSwgQu7N1R8S+zxtaQYPGIBZpG4KtpPY7s8Ebdi+kL0ytt3fCT+/QNZzQorNP1ZdWKEIE31JIIqht3VKdL5Gd25384ZGyN5AFXxAPH+BUZ1+GKYOe2w3Zo/hUxlG7IcwrULsHc6AeSvpvgnD7s2WJt37ykImoYJ3YTMOnJg5HhxapB8KMaN0JQ1+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWK6Fd7PSF2lZsF3cIjO+10Bv7aXNqd6j/woiBqVIx4=;
 b=a8313r3jzrsWGidKuwQvdu2Mxmt8kfboQnTVDdmYM7G9jlNeI5XyQt58tKB8oc3VE9eZ85hpnDEjPo0G+wjE49jjEggN5EjdzIje8hb4VPEKIO0TcmMq2P3pL2DR+pHX6thS575eLFGfVNsiJqTDPM4qukihOrtvCrn5EeBuZbZLHZtufUWkV5YXbDw7a9ib7UatIz0r5lqDgLnVWuB1j4Eo/JWhNSskoTieSyTQmGLEpplpYmCuhkVJmhkVywr3i4w6NkZ7l5GwRprXyEsxqObYQfBnVwBxDkB8JoYW+gup2LDcxa4ZVZrey3W9NZnedshTniY8xCFyfwY+kh3zYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWK6Fd7PSF2lZsF3cIjO+10Bv7aXNqd6j/woiBqVIx4=;
 b=oRGmlVEQVMxdLr7vNlae/Ynq4VcXm18aMPi4r7EzmKkNVTfNK3/7qvpnlf6stPdqlsrIAOkAKjPqS4f4QqJX8JYhIxe+DWax6kRdkU0MYuJOj3N/u0XmSQBhBDn+qGRRBAOJ3CRwtX3WHjKR5oQSKbf2dk8oHM9t+lbJGgDvQLk=
Received: from SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 06:55:40 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::8c) by SJ0PR03CA0117.outlook.office365.com
 (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 25
 Nov 2026 06:55:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:55:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:37 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:55:37 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:55:29 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Allen Pan <Allen.Pan@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 03/27] drm/amd/display: Add debug option to force DP link rate
Date: Wed, 25 Nov 2026 14:54:52 +0800
Message-ID: <20261125065631.3889665-4-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be194ae-4b21-4340-c18e-08df4ac11da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|22082099003|18002099003|3023799007|11063799006|56012099006|261022075727099003|261009223027099003|261021121427099003|261102123227099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: Gy0uhYNLMB3iD0B4Msre20PYfqAaUYAYIp162xickeWWi1DdIqsaWQ+QzqljU4Q6UbOkzMCbgOvGJCAzHKZFex8aJndpZyilUqQrSsHnbmMT+HEcteCqXTRmGJB4JViScaG2vuBJiMBvHH+I9mlSe/3crT4AaweyfafPK8aTyioaLUtaK25qwIA+wEFlBEkBoY7HGDYwBwARtioyUgyCWJuf015VbhTZ1n5IZK/Olm3niPgOb1JgqokApnsrLjINrQEd/CvG19dqZ6HHgSiX/gjbBwA27badLy8b9VnN/oW2QtpbFLVGBYxu9j+cmS/e/houoOQRggEhXmllslnJkpuYpzXyp8uA8sPwpujHAfGxDu1RL+2OodiIl9jbdjmgDdxUpKnfGIaMFqdbehSx7Uf1SL2j/h5082pSLhvZ6ncYHb/+jJZQbXNU8l2D54Q8wNHN8rN0ju/VGM0T6WBHVkbCmANFyr7DWSezD8sJHHh1W+xCYlEUMsIIv5jV4nvnfYS2vw53arNxb0Ib3nZKUgvZeJyS8IFAnaLWWd+87gVhWMFdtvjegKVpr0XM7LP7cAuJdNkLXdNGc4tBqxT2m7CbcbAlq1S/bNvY7NfLf4UNl6BWdWzDFPFBhmgv3pzPm061gAGqFO5Pz+COSATSFNIMuLZX34uFATfLZuhVtGEu5ZleccZ1xCNVmAPiW5QRg0ZuTFJ3heJONNdNyQKM+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(261022075727099003)(261009223027099003)(261021121427099003)(261102123227099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rZoiWa8DCDzFYLuLBb8fAmSgEj1bZVJjA1yQBMLrsT2wA7/YJsvAPVlWNoD3/A30VARTzs4rfxAw270wl+rjhLcMB39DXIcArDBqYC3feptIwtr+sxX7SlqrAX+193KqudcMQIDenNOWEEEWia2mhn5HWwj+DbEqvMHhD8YKW7kNA9A/2XzTj39CHIwpZQkL5NwX9uaLqKZt6IvhRprdTuGacobNEWc+o5BkFj9XjqraySfY4jDtzk5hh3ekdtaGhl+mR67uVhtNqtsyzJ1Z8S9vByFImKIBkvhXLlQ345hZVMtkAuzbd0kZccgBdwtz9l2y0XN4BXWZ/nyMSfjDP0M11od32CUixJMpu2DjCr1sFSdFGoznPBDMtwWuFH9sOEfL//QDdmuY7tM8H499vRJEYMVG6vVYDjEjAvwECPv9jcIVgFkE/KIU0/5VLra5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:55:39.5456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be194ae-4b21-4340-c18e-08df4ac11da9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276
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

From: Allen Pan <Allen.Pan@amd.com>

[Why]
Link rate testing needs a way to override the max DP link rate that
VBIOS reports for the link encoder, including rates above it.

[How]
Add force_dp_link_rate to dc_debug_options. When set, the DCN4.2 link
encoder reports it as its max link rate instead of the rate VBIOS
reports. dp_get_max_link_cap() still lowers it to the sink's DPCD max
link rate and the cable ID and LTTPR caps, and link settings are
decided as before.

Cc: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Allen Pan <Allen.Pan@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                  |  1 +
 .../display/dc/dio/dcn42/dcn42_dio_link_encoder.c    | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 58e443672411..75d1ede366c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1269,6 +1269,7 @@ struct dc_debug_options {
 	bool enable_dp_dig_pixel_rate_div_policy;
 	bool using_dml21;
 	enum lttpr_mode lttpr_mode_override;
+	enum dc_link_rate force_dp_link_rate;
 	unsigned int dsc_delay_factor_wa_x1000;
 	unsigned int min_prefetch_in_strobe_ns;
 	bool disable_unbounded_requesting;
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
index 3b11be9991c3..687df8cb4b60 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_link_encoder.c
@@ -64,6 +64,16 @@ bool dcn42_program_hpd_filter(struct link_encoder *enc, int delay_on_connect_in_
 	return true;
 }
 
+/* DMs load debug options after link encoders are constructed */
+static void dcn42_link_encoder_get_max_link_cap(struct link_encoder *enc,
+	struct dc_link_settings *link_settings)
+{
+	dcn32_link_encoder_get_max_link_cap(enc, link_settings);
+
+	if (enc->ctx->dc->debug.force_dp_link_rate != LINK_RATE_UNKNOWN)
+		link_settings->link_rate = enc->ctx->dc->debug.force_dp_link_rate;
+}
+
 static const struct link_encoder_funcs dcn42_link_enc_funcs = {
 	.read_state = link_enc2_read_state,
 	.validate_output_with_stream =
@@ -92,7 +102,7 @@ static const struct link_encoder_funcs dcn42_link_enc_funcs = {
 	.get_dig_frontend = dcn10_get_dig_frontend,
 	.get_dig_mode = dcn401_get_dig_mode,
 	.is_in_alt_mode = dcn32_link_encoder_is_in_alt_mode,
-	.get_max_link_cap = dcn32_link_encoder_get_max_link_cap,
+	.get_max_link_cap = dcn42_link_encoder_get_max_link_cap,
 	.dpcstx_set_order_invert_18_bit = NULL,
 	.set_phy_source = NULL,
 	.dpcs_initialize_phy = NULL,
-- 
2.43.0

