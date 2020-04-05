Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E366C2BA2B
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F262520644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J0VQa/ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F262520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB7989F75;
	Sun,  5 Apr 2020 20:41:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A5089EA6
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b84mnUvuuzeeuxsaP7O98DjuEWdE0RFEVlZEbMzRGxLBNC7gIle6TRzz0FWfwop90ak5lDxW++114Lr7/T1Muq7OGUcq9vajhV4K9VGq5VyhY0IlegGUgL/tmslVuVBJ+kS0ZyJlix+RSuKIYP1HzLanTMOfqkjQAcMCEaI4LnHscHKdVA8heMs0/nHrHen8oHjH2X8lT5sdGITFd+r08BH42tIDuxAg9LV5lkR+M2iMpTnr9L+uklfktDUvDFQr9s6oTeK4M+HFtTeLxNPmPxpXM1tDSaZbPD9VUoEKJ0231gRTKD9Tc3TEWSWSMqPUXJRWBbCig8u++3koeChmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tJi52JEjbzl4AuXcoKwmgcacc+GBQFpSNyv8eyHsGc=;
 b=PiPxv4li8EwaIB1rmcaGfFPoU+pKVl88qEigRISWNultJfkO2h2xx6zyQd5w/9UtYzOExh+eGy5g/ldZdwPL8EnizJrjV34kzbJz+1p6QpB6NCuI8mPrjF0c0XfcthIICqB4vf6BUUK040cZm7jzdOPZcTQG+4a4J+NxIcGsUDSTBTiZKxRDehU4x26rWw0Gl3Akr5yiySmPGqjABJxR6JRoHUwoXVUcKDIxZVUakYXZ1ASogTDw3OY8X6QH8cVo9CW/twm/F96sMZTT8V376F2jgRRAWHW44tsM6fasj+AfV55bP8sSHCNMpBwmQmrhbV8LLSyOTxeE2vIIWcPGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tJi52JEjbzl4AuXcoKwmgcacc+GBQFpSNyv8eyHsGc=;
 b=J0VQa/zeVBVubfmbPpU3HQA0SIwhXavYZAGoCavmL4wHm8AgyvdLys9XjLr6WhbcS1uWyhFVP0A2VlXOWkBr5bBkONG4gaVMwohVmmu0kFVfHeCXEYS1I3ue9KWUAquGuS250/a8QJo4V3IT7j3m/+b3ofziIWsSAPpidoaAQnY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:42 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:42 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/36] drm/amd/display: Implement abm config table copy to
 dmcub
Date: Sun,  5 Apr 2020 16:40:43 -0400
Message-Id: <20200405204115.683559-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:41 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 755a0459-cf61-403b-1f2f-08d7d9a1bf98
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255506AE3A7FE1BDD776BBEB98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tP+D1MVh15HMUufWs7To2y6eXGi11MI/ejnM5DQ3JK/TlFn4jIakrQsq3rKS0tGIXb8+/oIbjIHSCEWjh0t4cQOGtr2L33tC0EMLAHrn3VEwMMi2FYGVyoElxETLzTkUCQPSQkhN7LdP68U8cgKzVDb/lZboFPXvqjBplkgBIBxqOaMehQ8Wd7SostjoxWuPUtXNoz5WzpzRqNNYppo9T579rt2IsV54srBY9f3j1Xu02anR1+VZPzYP+drGMsT95/YLGjXyQ7EsmeOtjdaZo7OvKC8GHkBfHZpuJcPEqjKZMiMlR0AHPRZYqsDFT5DNaJc5aQKXt9mBe3sxO910HqJn6td8U1vH+E9hCu8s5JmAQKL9wsyTPwI/J3ynZ+PcXaL7U/pwZ8JIgBRt1S54jCiAC+4q0ARJ0xR1NyeDK4DTvuBoG0YAq7MRVh/HZGco
X-MS-Exchange-AntiSpam-MessageData: F9/HQmgqyuw9ntKChO+OhQZW+CBOnlDDGK286IV/bgNNmHhFups3VJPraWQWlfCFwDaH0jGMJYzoQW33jZ5E8wve/xyIRNJYR5IJB4k5NV/1A06w+CGYJ5vHQM3RRb5NKRLuIdsBsK4GIZELYsDvprqEq2MRmg10ZpCzt6GsjBs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755a0459-cf61-403b-1f2f-08d7d9a1bf98
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:42.7072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yppkhk6Wg6WsaoctZMQTNCAgrE9zobgGKMRWIfQdxZM53qEZeLGnk7P2CZ3bxo6Dw6ZCzzZKTSigo6LoyelLHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Wyatt Wood <wyatt.wood@amd.com>, Harry.Wentland@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
Driver must pass abm config table to dmub fw. This provides various
parameters for abm functionality.

[How]
There is too much data to be passed in an inbox message, so we must pass
this data using an indirect buffer.  Copy the table to cw7 via x86,
driver copies to fw_state structure.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 25 ++++++++++++++++---
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |  3 +--
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   | 10 ++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  2 +-
 .../amd/display/modules/power/power_helpers.c |  4 +--
 6 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
index a4dae31400fa..e345df621a6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
@@ -447,7 +447,7 @@ static const struct abm_funcs dce_funcs = {
 	.set_backlight_level_pwm = dce_abm_set_backlight_level_pwm,
 	.get_current_backlight = dce_abm_get_current_backlight,
 	.get_target_backlight = dce_abm_get_target_backlight,
-	.load_abm_config = NULL,
+	.init_abm_config = NULL,
 	.set_abm_immediate_disable = dce_abm_immediate_disable
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 81c967917c5b..06435ecaf6a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -348,11 +348,30 @@ static bool dmub_abm_set_backlight_level_pwm(
 	return true;
 }
 
-static bool dmub_abm_load_config(struct abm *abm,
-	unsigned int start_offset,
+static bool dmub_abm_init_config(struct abm *abm,
 	const char *src,
 	unsigned int bytes)
 {
+	union dmub_rb_cmd cmd;
+	struct dc_context *dc = abm->ctx;
+
+	// TODO: Optimize by only reading back final 4 bytes
+	dmub_flush_buffer_mem(&dc->dmub_srv->dmub->scratch_mem_fb);
+
+	// Copy iramtable into cw7
+	memcpy(dc->dmub_srv->dmub->scratch_mem_fb.cpu_addr, (void *)src, bytes);
+
+	// Fw will copy from cw7 to fw_state
+	cmd.abm_init_config.header.type = DMUB_CMD__ABM;
+	cmd.abm_init_config.header.sub_type = DMUB_CMD__ABM_INIT_CONFIG;
+	cmd.abm_init_config.abm_init_config_data.src.quad_part = dc->dmub_srv->dmub->scratch_mem_fb.gpu_addr;
+	cmd.abm_init_config.abm_init_config_data.bytes = bytes;
+	cmd.abm_init_config.header.payload_bytes = sizeof(struct dmub_cmd_abm_init_config_data);
+
+	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd.abm_init_config.header);
+	dc_dmub_srv_cmd_execute(dc->dmub_srv);
+	dc_dmub_srv_wait_idle(dc->dmub_srv);
+
 	return true;
 }
 
@@ -365,7 +384,7 @@ static const struct abm_funcs abm_funcs = {
 	.get_current_backlight = dmub_abm_get_current_backlight,
 	.get_target_backlight = dmub_abm_get_target_backlight,
 	.set_abm_immediate_disable = dmub_abm_immediate_disable,
-	.load_abm_config = dmub_abm_load_config,
+	.init_abm_config = dmub_abm_init_config,
 };
 
 static void dmub_abm_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
index 9cca0ca30fee..0cae258a903e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/abm.h
@@ -60,8 +60,7 @@ struct abm_funcs {
 
 	unsigned int (*get_current_backlight)(struct abm *abm);
 	unsigned int (*get_target_backlight)(struct abm *abm);
-	bool (*load_abm_config)(struct abm *abm,
-			unsigned int start_offset,
+	bool (*init_abm_config)(struct abm *abm,
 			const char *src,
 			unsigned int bytes);
 };
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
index c2671f2616c8..af678462f0e6 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_srv.h
@@ -565,6 +565,16 @@ dmub_srv_send_gpint_command(struct dmub_srv *dmub,
 enum dmub_status dmub_srv_get_gpint_response(struct dmub_srv *dmub,
 					     uint32_t *response);
 
+/**
+ * dmub_flush_buffer_mem() - Read back entire frame buffer region.
+ * This ensures that the write from x86 has been flushed and will not
+ * hang the DMCUB.
+ * @fb: frame buffer to flush
+ *
+ * Can be called after software initialization.
+ */
+void dmub_flush_buffer_mem(const struct dmub_fb *fb);
+
 #if defined(__cplusplus)
 }
 #endif
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index ce32cc7933c4..0be8a54cc475 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -70,7 +70,7 @@ static inline uint32_t dmub_align(uint32_t val, uint32_t factor)
 	return (val + factor - 1) / factor * factor;
 }
 
-static void dmub_flush_buffer_mem(const struct dmub_fb *fb)
+void dmub_flush_buffer_mem(const struct dmub_fb *fb)
 {
 	const uint8_t *base = (const uint8_t *)fb->cpu_addr;
 	uint8_t buf[64];
diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 8bf1bdd0f457..c1a95da6706f 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -671,8 +671,8 @@ bool dmcu_load_iram(struct dmcu *dmcu,
 	// ABM 2.4 and up are implemented on dmcub
 	if (dmcu == NULL) {
 		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
-		result = abm->funcs->load_abm_config(
-			abm, 0, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
+		result = abm->funcs->init_abm_config(
+			abm, (char *)(&ram_table), IRAM_RESERVE_AREA_START_V2_2);
 	} else if (dmcu->dmcu_version.abm_version == 0x24) {
 		fill_iram_v_2_3((struct iram_table_v_2_2 *)ram_table, params);
 			result = dmcu->funcs->load_iram(
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
