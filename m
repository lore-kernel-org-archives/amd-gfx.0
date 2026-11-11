Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05145606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aCidnbLi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA1A10F8E2;
	Wed, 11 Nov 2026 01:43:48 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF3910F8E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PC90oVHS+xHiMB05O+x0h8y1/qzCmqFlSVWXjqBPYPFzV9qxivO2qgQm0A+OIPR+vqHbnNn76ik4nlOLrCZ3XDTibuDJB3VLvCmqe90y+6oph4dvRWb7d0Re1zxEbdKGpUfDJdUBJdwrW7PNqU65k7cbpVhfM+XknSjg8tjKjTSqpY51RIf37YaT25N1hvV0hP8gAs/519z1XUm5W0Y2VCGBBpIyzYtZCyCJtuHp5kv2ioXWf6yHMoeuiBmIpYIvdOTqIMgHWNk4IhkFOz6NI06doJFGTMx6zZOMvH+JjR2EkgS6+lE2ga8tTRJGsgO3rvNhBe0SGzbqbLkcI5RfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsKl3nBPnPPsJGknXFeg8NH8ShTl0uIsPd9VDpHeexI=;
 b=mx8G9AMl2vuz/K89ztSv3yS6nCpE5xaOyp6FjF4q/7xeDe4GIqKt3tBdCL+Fj7B4Cng5AOer1+7L/2YS6iEU+ROq2YuulrebsR7WE/kJ7z3xSSdNzHPrAIezPLE9hFCEG0yTscDHqVYtQabE3HEJCJ8Trq5XhB/Y2v11loOw0vTf62B7v0iDsk7xp226pJxSyy8AyOKPAdmT567p3UnE/MHdsiPCxzw228pb+D6znt7JrOFBrPqfhbQcUKY/GTNaQVlBtTqAtBmFKrZsnH0vkP8H9JyPUXKIWvnc9ZW6aykGP+NMg644lCWH5T5LtNJ+bw/7niRU6Mcw73dwamhGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsKl3nBPnPPsJGknXFeg8NH8ShTl0uIsPd9VDpHeexI=;
 b=aCidnbLiwoXnfzOfF/OCb9SUskHhcn/iDAs9ZCJNXlVoKvzrPD/O538nOqtnwEHA8NDM7oMFQEOiW997HL2fzLOvaH/k+wbAeYgvlEE41sMn1aGCzLLp3C8hMc4v40JF7KB30EpkGHEPzHtnDlRL2MlNYGCKFOQSyoDNCQDmVuo=
Received: from SJ0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:a03:33e::6)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:43:36 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::9f) by SJ0PR03CA0031.outlook.office365.com
 (2603:10b6:a03:33e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Wed,
 11 Nov 2026 01:43:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:43:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:34 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:43:34 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:43:31 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 49/74] drm/amd/display: Use expanded DMUB-provided SoC BB and
 IP caps
Date: Wed, 11 Nov 2026 09:28:55 +0800
Message-ID: <20261111014100.3596072-50-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f7cc18-3c0a-493a-fee7-08df3f953372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|30052699003|23010399003|36860700016|6133799003|261009223027099003|10067099003|3023799007|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tbXpoCXAMmuskbw584pjZTrZVwRF7Ut8QFvrIQn3vf+UtwGOYJTBw610l1LqHcs70KhTYD6G5z+XD4jWBf2NcsPJVLQshq4Xop0rxrvJbb6NfR5RULRvs27IJhdvNmn/Cl2AlAW+bEOl1zEuMgR+fkhqCige8H9JpCwt52ofn8ADyzYxB25BpsGUxeKu5UkuaQpeD8BEhIqj6H3X9h1uMHXqlTVArbQylkbMe3Xqi2sXac44xpZFVEoumjMa4/ZKe7aZBrPctYKTGdGBrPZu+6pynk4c3GrZfF1JQYWxvZDOxAq6emk79s6xt3VpWFQ0R7paAWphf5MqOc91h4IF/VPuccDkMyruP1yNsYC3bCJHYVkoiz2YFk14dq2G7WHYKYC3J+l510+94gVoYG/4W/GUNeGwfYM0R8QA00aNQLKZAXZ99MLcTNO5RQkehDD4lyTBHshMTJJv/V6nOSxyh+IKdp9p18ocXoJ2jE0VLncJnQ60J7YoauLvORJWJhcHE2gPsB5hE0NEoYo1LzPEoC2g9wEKj4e2+ziGLatAKS5jx4J9ohtQyJaBgyiHQeKgh+2gVFoSay/CETpaMPk7Np/65H6KQ+BWrNUrdc9lUkZ52ocBZeBEIOMQmwI+MHRwmiVbraZPSPJovz5OTPKCVTf0jUGaqNd2rYjx36RciKxYCqr+tAy1qWooXD2BTu+FejROMHDoi+YNMrqimslSHA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(30052699003)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(3023799007)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E6mA8pHT0llP76DSMx7ho2zsSAU9fnXqBuM8DdeOnQmhIEl96F05HPtQKAaxPBxeQYfXVkHfTrljhJMM1m55TL60WxCfpjmaIgXXN/cSkBSAD8jhU9aTngbNbMPzk1dj5pw1MA+dq+4HBWLrXRY/W5upzSrTsrjtOPzXPQVtbD4clrBaktYCTPELGzBOKKYVlR1zmNjIJgOXEmScAc7uImvWnJ+UAU0zzv55XlCpk4twNnLZUo3LUpgaMOJP/xFh6berj8j3YpPehTbJyHm0gaYXCW9nunTBZgsdy/eSDahy2L3oUeVc7LDKZoJeOzV/cXqvN+fVvt0OqsfAPdbFWvZkTLPzijPhGmN6FNvIq7PvJ2qSLsUmxDjbAGshTqT+29B3FAeBpdoaphWdpWQNnWusolPvbyBV+wEQwXRD1zhJHWH4j2WIIB7aSDHQ3WcJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:43:35.4488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f7cc18-3c0a-493a-fee7-08df3f953372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
Some SoC bounding box and IP capability values must be provided by
VBIOS through DMUB for the display to light up.

[How]
- Pass dml2_configuration_options to get_ip_caps so translators can
  read the DMUB bounding box, and update all implementations.
- Take the urgent bandwidth targets, max outstanding requests, return
  bus width and alternate DRAM carveout size from DMUB when provided.
- Override each IP cap with its DMUB value when provided (non-zero);
  otherwise keep the default.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dml21_wrapper/dml21_translation_helper.c  |  2 +-
 .../display/dc/inc/soc_and_ip_translator.h    |  4 +-
 .../dcn401/dcn401_soc_and_ip_translator.c     |  4 +-
 .../dcn42/dcn42_soc_and_ip_translator.c       |  4 +-
 .../dcn42b/dcn42b_soc_and_ip_translator.c     |  4 +-
 .../dcn60/dcn60_soc_and_ip_translator.c       | 96 ++++++++++++++++++-
 6 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
index 2e3ad7152f3f..a7d6ff59870a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/dml21_wrapper/dml21_translation_helper.c
@@ -79,7 +79,7 @@ void dml21_populate_dml_init_params(struct dml2_initialize_instance_in_out *dml_
 
 	if (config->use_native_soc_bb_construction) {
 		in_dc->soc_and_ip_translator->translator_funcs->get_soc_bb(&dml_init->soc_bb, in_dc, config);
-		in_dc->soc_and_ip_translator->translator_funcs->get_ip_caps(&dml_init->ip_caps);
+		in_dc->soc_and_ip_translator->translator_funcs->get_ip_caps(&dml_init->ip_caps, config);
 	} else {
 		dml_init->soc_bb = config->external_socbb_ip_params->soc_bb;
 		dml_init->ip_caps = config->external_socbb_ip_params->ip_params;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h b/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
index 5dcb9f8f4daf..13d59cc082f0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/soc_and_ip_translator.h
@@ -13,7 +13,9 @@ struct soc_and_ip_translator_funcs {
 			struct dml2_soc_bb *soc_bb,
 			const struct dc *dc,
 			const struct dml2_configuration_options *config);
-	void (*get_ip_caps)(struct dml2_ip_capabilities *dml_ip_caps);
+	void (*get_ip_caps)(
+			struct dml2_ip_capabilities *dml_ip_caps,
+			const struct dml2_configuration_options *config);
 };
 
 struct soc_and_ip_translator {
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
index c3dfcf2a73e3..a0181bbb2865 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
@@ -307,8 +307,10 @@ void dcn401_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const st
 	apply_soc_bb_updates(soc_bb, dc, config);
 }
 
-static void dcn401_get_ip_caps(struct dml2_ip_capabilities *ip_caps)
+static void dcn401_get_ip_caps(struct dml2_ip_capabilities *ip_caps,
+		const struct dml2_configuration_options *config)
 {
+	(void)config;
 	*ip_caps = dml2_dcn401_max_ip_caps;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
index c6c1b19b7370..0e9fd4d177d3 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42/dcn42_soc_and_ip_translator.c
@@ -180,8 +180,10 @@ void dcn42_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const str
 	dcn42_apply_soc_bb_updates(soc_bb, dc, config);
 }
 
-static void dcn42_get_ip_caps(struct dml2_ip_capabilities *ip_caps)
+static void dcn42_get_ip_caps(struct dml2_ip_capabilities *ip_caps,
+		const struct dml2_configuration_options *config)
 {
+	(void)config;
 	*ip_caps = dml2_dcn42_max_ip_caps;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.c
index 50669f458e23..e7efca1f0ab1 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn42b/dcn42b_soc_and_ip_translator.c
@@ -26,8 +26,10 @@ void dcn42b_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, const st
 	dcn42_apply_soc_bb_updates(soc_bb, dc, config);
 }
 
-static void dcn42b_get_ip_caps(struct dml2_ip_capabilities *ip_caps)
+static void dcn42b_get_ip_caps(struct dml2_ip_capabilities *ip_caps,
+		const struct dml2_configuration_options *config)
 {
+	(void)config;
 	*ip_caps = dml2_dcn42b_max_ip_caps;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
index aef527c7584b..f33e818d1b1e 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn60/dcn60_soc_and_ip_translator.c
@@ -65,6 +65,19 @@ static void dcn60_update_soc_bb_with_values_from_dmub(struct dml2_soc_bb *soc_bb
 	if (dmub_bb_params->g7_temperature_read_blackout_ns > 0)
 		soc_bb->power_management_parameters.g7_temperature_read_blackout_us =
 				(double) dmub_bb_params->g7_temperature_read_blackout_ns / 1000.0;
+	if (dmub_bb_params->fraction_of_urgent_bandwidth_nominal_target > 0)
+		soc_bb->fraction_of_urgent_bandwidth_nominal_target =
+				(double) dmub_bb_params->fraction_of_urgent_bandwidth_nominal_target / 1000.0;
+	if (dmub_bb_params->fraction_of_urgent_bandwidth_flip_target > 0)
+		soc_bb->fraction_of_urgent_bandwidth_flip_target =
+				(double) dmub_bb_params->fraction_of_urgent_bandwidth_flip_target / 1000.0;
+	if (dmub_bb_params->max_outstanding_reqs > 0)
+		soc_bb->max_outstanding_reqs = dmub_bb_params->max_outstanding_reqs;
+	if (dmub_bb_params->return_bus_width_bytes > 0)
+		soc_bb->return_bus_width_bytes = dmub_bb_params->return_bus_width_bytes;
+	if (dmub_bb_params->alternate_dram_carveout_size_mb > 0)
+		soc_bb->power_management_parameters.alternate_dram_carveout_size_mb =
+				dmub_bb_params->alternate_dram_carveout_size_mb;
 
 	/* populate alt-channel info */
 	for (i = 0; i < 2; i++) {
@@ -141,9 +154,90 @@ static void dcn60_get_soc_bb(struct dml2_soc_bb *soc_bb, const struct dc *dc, co
 
 }
 
-static void dcn60_get_ip_caps(struct dml2_ip_capabilities *ip_caps)
+static void dcn60_update_ip_caps_with_values_from_dmub(struct dml2_ip_capabilities *ip_caps,
+		const struct dml2_configuration_options *config)
+{
+	const struct dmub_soc_bb_params *dmub_ip =
+			(const struct dmub_soc_bb_params *)config->bb_from_dmub;
+
+	if (dmub_ip == NULL)
+		return;
+
+	//only update if value is provided
+	if (dmub_ip->pipe_count > 0)
+		ip_caps->pipe_count = dmub_ip->pipe_count;
+	if (dmub_ip->otg_count > 0)
+		ip_caps->otg_count = dmub_ip->otg_count;
+	if (dmub_ip->num_dsc > 0)
+		ip_caps->num_dsc = dmub_ip->num_dsc;
+	if (dmub_ip->TDLUT_33cube_count > 0)
+		ip_caps->TDLUT_33cube_count = dmub_ip->TDLUT_33cube_count;
+	if (dmub_ip->max_num_dp2p0_streams > 0)
+		ip_caps->max_num_dp2p0_streams = dmub_ip->max_num_dp2p0_streams;
+	if (dmub_ip->max_num_hdmi_frl_outputs > 0)
+		ip_caps->max_num_hdmi_frl_outputs = dmub_ip->max_num_hdmi_frl_outputs;
+	if (dmub_ip->max_num_dp2p0_outputs > 0)
+		ip_caps->max_num_dp2p0_outputs = dmub_ip->max_num_dp2p0_outputs;
+	if (dmub_ip->rob_buffer_size_kbytes > 0)
+		ip_caps->rob_buffer_size_kbytes = dmub_ip->rob_buffer_size_kbytes;
+	if (dmub_ip->config_return_buffer_size_in_kbytes > 0)
+		ip_caps->config_return_buffer_size_in_kbytes =
+				dmub_ip->config_return_buffer_size_in_kbytes;
+	if (dmub_ip->config_return_buffer_segment_size_in_kbytes > 0)
+		ip_caps->config_return_buffer_segment_size_in_kbytes =
+				dmub_ip->config_return_buffer_segment_size_in_kbytes;
+	if (dmub_ip->meta_fifo_size_in_kentries > 0)
+		ip_caps->meta_fifo_size_in_kentries = dmub_ip->meta_fifo_size_in_kentries;
+	if (dmub_ip->compressed_buffer_segment_size_in_kbytes > 0)
+		ip_caps->compressed_buffer_segment_size_in_kbytes =
+				dmub_ip->compressed_buffer_segment_size_in_kbytes;
+	if (dmub_ip->cursor_buffer_size > 0)
+		ip_caps->cursor_buffer_size = dmub_ip->cursor_buffer_size;
+	if (dmub_ip->max_flip_time_us > 0)
+		ip_caps->max_flip_time_us = dmub_ip->max_flip_time_us;
+	if (dmub_ip->max_flip_time_lines > 0)
+		ip_caps->max_flip_time_lines = dmub_ip->max_flip_time_lines;
+	/* 0 is a valid hostvm_mode */
+	ip_caps->hostvm_mode = dmub_ip->hostvm_mode;
+	if (dmub_ip->max_vactive_det_fill_delay_us > 0)
+		ip_caps->max_vactive_det_fill_delay_us = dmub_ip->max_vactive_det_fill_delay_us;
+	if (dmub_ip->ppt_max_allow_delay_us > 0)
+		ip_caps->ppt_max_allow_delay_us = dmub_ip->ppt_max_allow_delay_us;
+	if (dmub_ip->temp_read_max_allow_delay_us > 0)
+		ip_caps->temp_read_max_allow_delay_us = dmub_ip->temp_read_max_allow_delay_us;
+	if (dmub_ip->vblank_nom_default_us > 0)
+		ip_caps->vblank_nom_default_us = dmub_ip->vblank_nom_default_us;
+
+	if (dmub_ip->fams2_max_allow_delay_us > 0)
+		ip_caps->fams2.max_allow_delay_us = dmub_ip->fams2_max_allow_delay_us;
+	if (dmub_ip->fams2_scheduling_delay_us > 0)
+		ip_caps->fams2.scheduling_delay_us = dmub_ip->fams2_scheduling_delay_us;
+	if (dmub_ip->fams2_vertical_interrupt_ack_delay_us > 0)
+		ip_caps->fams2.vertical_interrupt_ack_delay_us =
+				dmub_ip->fams2_vertical_interrupt_ack_delay_us;
+	if (dmub_ip->fams2_allow_programming_delay_us > 0)
+		ip_caps->fams2.allow_programming_delay_us = dmub_ip->fams2_allow_programming_delay_us;
+	if (dmub_ip->fams2_min_allow_width_us > 0)
+		ip_caps->fams2.min_allow_width_us = dmub_ip->fams2_min_allow_width_us;
+	if (dmub_ip->fams2_subvp_df_throttle_delay_us > 0)
+		ip_caps->fams2.subvp_df_throttle_delay_us = dmub_ip->fams2_subvp_df_throttle_delay_us;
+	if (dmub_ip->fams2_subvp_programming_delay_us > 0)
+		ip_caps->fams2.subvp_programming_delay_us = dmub_ip->fams2_subvp_programming_delay_us;
+	if (dmub_ip->fams2_drr_programming_delay_us > 0)
+		ip_caps->fams2.drr_programming_delay_us = dmub_ip->fams2_drr_programming_delay_us;
+	if (dmub_ip->fams2_lock_timeout_us > 0)
+		ip_caps->fams2.lock_timeout_us = dmub_ip->fams2_lock_timeout_us;
+	if (dmub_ip->fams2_recovery_timeout_us > 0)
+		ip_caps->fams2.recovery_timeout_us = dmub_ip->fams2_recovery_timeout_us;
+	if (dmub_ip->fams2_flip_programming_delay_us > 0)
+		ip_caps->fams2.flip_programming_delay_us = dmub_ip->fams2_flip_programming_delay_us;
+}
+
+static void dcn60_get_ip_caps(struct dml2_ip_capabilities *ip_caps,
+		const struct dml2_configuration_options *config)
 {
 	dcn6_test_initialize_ip_caps(ip_caps);
+	dcn60_update_ip_caps_with_values_from_dmub(ip_caps, config);
 }
 
 static struct soc_and_ip_translator_funcs dcn60_translator_funcs = {
-- 
2.43.0

