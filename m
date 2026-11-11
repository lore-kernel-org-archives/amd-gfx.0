Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9E2606A326
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hflIl6xm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1CD810F8B7;
	Wed, 11 Nov 2026 01:41:32 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010061.outbound.protection.outlook.com
 [40.93.198.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB5910F8BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYOJk1UXs5wyYuny2HZNc4/KT5DQKZW8UjB0umXhSuCYwNBAS7lVLN+jfhizECTW1uUb5rHupPVgqJJ9YrN740gFZ1K5uaWv/9VZj2+1HdCPw1cn+SJ9fkU5hNczAwK1TQqwASucd9SVqSb/7ZDsv1P3JBCHKgwy0USueLeAqTcXF3NKAxg5FpafX5KFeLogVq65ahYvHNPRCUV0WbRFBR/gmXIU2VwaX3005XGqybh3UhSNj9raU48PQQpI5p0AHVive+dvJ2T+fu3bRf8892r2Mhji17tOwAxaX7qH7B3KuWD3vco3VCB6CFLXleUkTbEH/dpMxUJrbW1VrHVpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADfVOQTQZa+qeLy+GiqVQvAqm39cpB1pk86dx+Dym+U=;
 b=KWeJ8xeLFN8r94s70N3qVnn0lJyyvNQUrEIiMHOue4kvfuOFERc7cv98RZ3f5nq0ZJD/6/C2CNo3H25S+2f4V4L/wlVp9YDzIKGwmqsNL9gyMUDt0b9pTE+2WL8FwSnwGX7WSmboQ2m6FnpDwk1mU/KW7vckXYdn/5/BsiN2Fz92Gf6c+odVpsZyqfMXY0OzyqUly5EQxScYbflOGKKuIeCbQR6HDOpoWvrL0ypYAek/9fLFgVSdbokT6O9H6Jvz0eAkm0o4Ct9MrQOxoHq9LVunzHJ8yFbViopd7nFMgBw+smzIM9/58fNJ+6/4E0+T78CZuinmpVaRpTe7HBleRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADfVOQTQZa+qeLy+GiqVQvAqm39cpB1pk86dx+Dym+U=;
 b=hflIl6xm67LxIv2Wpldn+ZwYU+lRGlFDguZrGFsCO+peuy67ApAz9tXPEe92qO00txQT20Q5fGiJWCRR/WN5N7XEJ5O3boU3L74v1CdlZP4y42sSlILwudhwg0Gl1l6G6NRgvrkPDA2Ecbcn5qjx2MfvRnoyPqLDRJ4PUMg4YNA=
Received: from SJ0PR13CA0081.namprd13.prod.outlook.com (2603:10b6:a03:2c4::26)
 by DS3PR12MB086197.namprd12.prod.outlook.com (2603:10b6:8:60a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:41:24 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::9e) by SJ0PR13CA0081.outlook.office365.com
 (2603:10b6:a03:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Wed, 11
 Nov 2026 01:41:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:16 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:13 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 14/74] drm/amd/display: Fix FFE test automation link rate
 change
Date: Wed, 11 Nov 2026 09:28:20 +0800
Message-ID: <20261111014100.3596072-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DS3PR12MB086197:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d636803-504d-45a3-2000-08df3f94e4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|261022105027099003|56012099006|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261009223027099003|261028144727099003|261102123227099003|261009223327099003|261026140227099003|10067099003|261009220027099003|261009221227099003|261009221727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: YcngF6GJ08SyD1EbJYqdrU9ngJD8dKoglJJsmo583+kE2wYhG8XIsNwtGOuhrWxS8y63Z81xqWuwlVsz/qSfcGz6acOsityc3ghKXFAbgbR9ISrI53q4E33yeZeCoKYwU51RyBATUXp3pObihEHXqzy2DTQEHOGPP71KHcFhOT5J1hm/DiExD0msNBMzPjtgGMrA8XbWhd/z7vMNOJ6O/qlKETfxZb3U7KSFujznNDGxaThUuFnwocHA6M1u4O91p0F5XgkUGgGiVE+su5suTerhfG9GO0I/BOi7X/ToxQZ/tMupxMvcs7n1PGK+ICS3Yp3/8e6R1G1gDF0Ahn4pb7TQ3IA9JjrHolomAQiedfpCii6N8UOGuDzl6tg7paha23Ofj3DB+dWXuIEQt3c0Y45mkGBgAMXWi8aIIXTs9c6/0Syz76oUUhvNj3TM4bUtA52CREqDXxU/JTXuOSgIf+yAWVNN3VQnyVWChvxTzhp33GZIYBeTn1WhjJJaqIIpZLpW7gcDzouPwmYrP/1VEdKNtXyX8no0LnUUIiGym5I4iYXuqkO02WGd44dtSKJIO93TGARqP3CkAdDS5kFJ+Y3TAqJ+AVqMMO6B3fF1LkqxWWGpoR8IYS25vKUB/iC1L0i49wJytj1tMiRJDUb580YYxq4gkUScO0lME7iP5ZJs+PoGPlUm79AeLwCQ1aKKHIeAsYkx1d0pjUQre/O5yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(261022105027099003)(56012099006)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261009223027099003)(261028144727099003)(261102123227099003)(261009223327099003)(261026140227099003)(10067099003)(261009220027099003)(261009221227099003)(261009221727099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5GdNpXYIhDqW5ADDQEEl3a9fpxQaaLbw9dX5aJsv+Zw5pZjVqdgz7J2yJQ6pQEqig8zwjQxaCBp4+D5XQJf0AO6GAETn/2LTV7mLCPT0dtij4Usui81fUTF1pRWcTM+L4wGVPx6ckgqMiloE8TMLmKjk/lhoc0ZQeoebIfccnOpwhguB/+qbGAfKfGQ2+XYroxaSkdGzvTE+YXW3lRYSt3HECNHwns3zED7nJ1giqAQlg3QmDmOJUoJgO68m7cEcZUlTPp7OUxNcrrkw1+QI6w789TWrhi+5rBOf5PgNzCtKJ/FRz9w6xi+TpLyjNZ3niM0S9hGGilBe5a/W6fRW8yOXO71lUSpktEFWJ2a3xecrd1hj1vkN6/IMLdkRoMcUawWn1/4VcTJ5v8a23Exxv7kULJoTQbuzmGKtIC3bIyIcVwuPWCrtzpXba+CCOW61
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:23.5501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d636803-504d-45a3-2000-08df3f94e4d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB086197
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
Sink requesting a new link rate is not handled properly on hotplug when
FLT_NO_TIMEOUT is set. Check the existing config on the sink to see if a
link rate update is needed.

Cc: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h  |  1 +
 .../display/dc/link/protocols/link_hdmi_frl.c   | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
index 9e0fe41f28a5..446db6dab312 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
@@ -276,6 +276,7 @@ struct dc_hdmi_frl_flags {
 	bool force_frl_max;
 	bool apply_vsdb_rcc_wa;
 	bool no_timeout;
+	enum hdmi_frl_link_rate no_timeout_frl_link_rate;
 };
 
 struct dc_hdmi_frl_link_training_overrides {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 097df185a618..c31be4900e8d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -461,7 +461,8 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 			sizeof(offset), &test_req.byte, sizeof(test_req.byte));
 	FRL_INFO("FRL TEST REQ:  FLT_no_timeout = %d \n", test_req.fields.FLT_NO_TIMEOUT);
 
-	if (test_req.fields.FLT_NO_TIMEOUT && ddc_service->link->frl_flags.no_timeout) {
+	if (test_req.fields.FLT_NO_TIMEOUT && ddc_service->link->frl_flags.no_timeout &&
+			ddc_service->link->frl_flags.no_timeout_frl_link_rate == link_settings->frl_link_rate) {
 		bool de_emphasis_only = false;
 		bool pre_shoot_only = false;
 		bool no_ffe = false;
@@ -538,6 +539,7 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 
 	if (test_req.fields.FLT_NO_TIMEOUT) {
 		ddc_service->link->frl_flags.no_timeout = true;
+		ddc_service->link->frl_flags.no_timeout_frl_link_rate = link_settings->frl_link_rate;
 
 		/*Specify FRL rate*/
 		write_buffer[0] = HDMI_SCDC_CONFIG_1;
@@ -834,6 +836,15 @@ enum link_result hdmi_frl_perform_link_training_with_fallback(
 
 		msleep(200);
 
+		/* If we're in a NO_TIMEOUT state and link rate changes, cycle the link on/off
+		 * so that the new link rate is properly applied */
+		if (link->frl_flags.no_timeout) {
+			if (link->frl_flags.no_timeout_frl_link_rate != link->frl_link_settings.frl_link_rate) {
+				link->hpo_frl_link_enc->funcs->disable_link_encoder(link->hpo_frl_link_enc);
+				link->link_enc->funcs->disable_output(link->link_enc, SIGNAL_TYPE_HDMI_FRL);
+			}
+		}
+
 		link->ctx->dc->hwss.setup_hdmi_frl_link(link, 0,
 				frl_phy_clock_source_id);
 
@@ -1023,7 +1034,7 @@ void hdmi_frl_set_preferred_link_settings(struct dc *dc,
 	link_stream->link->frl_link_settings = *link_setting;
 	link_stream->link->frl_verified_link_cap = *link_setting;
 
-	while (link_stat != LINK_RESULT_SUCCESS) {
+	while (link_stat != LINK_RESULT_SUCCESS && link_stat != LINK_RESULT_NO_TIMEOUT) {
 		link_set_dpms_off(pipe);
 		/* For DCN3.0, can also have 4:1 combine mode.
 		 * TODO: Add function get_odm_combine_mode that has different
@@ -1101,7 +1112,7 @@ void hdmi_frl_set_preferred_link_settings(struct dc *dc,
 		link_stat = hdmi_frl_perform_link_training_with_retries(link_stream->link);
 
 		/* Enable FRL packet transmission */
-		if (link_stat == LINK_RESULT_SUCCESS) {
+		if (link_stat == LINK_RESULT_SUCCESS || link_stat == LINK_RESULT_NO_TIMEOUT) {
 			link_stream->link->hpo_frl_link_enc->funcs->enable_output(
 					link_stream->link->hpo_frl_link_enc);
 			if (link_stream->link->frl_flags.apply_vsdb_rcc_wa)
-- 
2.43.0

