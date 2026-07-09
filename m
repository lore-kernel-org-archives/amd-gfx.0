Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749F2C44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A1A10F6A1;
	Thu,  9 Jul 2026 21:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VjFQu9Sm";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BEDA10F6A1
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj+p0ECypegIK4bYndUN7xTBwgSQUC1SN49dd4FVb/lqDKjs8I2Y7NHfraF0mWqUpClnJFwG9Ymnfi2BqpDCeKq6CTgB2i/5V2rfikGYsFGMgH64t9F9m+yN9KmZLDET3UjzgzfW6/Wubkqal6+SPd0V6APb/9L/1jHwrT3er2aVNFWPpiB8Z2M2OWnAWCS364IXnesCuLkOOwNHk3ug42qW2rM7/+IkDNa5ToaRzaUlKhMZ2NnwwYUjwpTn6rnnl5L4/lYZbLTCL24x2E9G1bZ3ZEWROThOxb3cE1sOrgoLBVcPNyzggoSDpCQsA7pigm8UJNTeWeODc7NRmfyPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMwXNYGHW4uaXuuBIcrr5snOas/7hHLYRZnEA19aEW4=;
 b=HifMGc7i//tX1MEmrpqRx8omsaTvebA7huYaau1omubIwvghEaSKR8TZ95+XuB/A/TCWgcUhBC7HE+uRloYkVLT/QWuQHIsVJtz2J4FOklo9FWglNq3Cg+KwalZ9NBa9siJcua8+XGU7yV9uzzR/mocfQu9A2qnQ2YVdt6bdLuTlDA4wDSOnbhkDHF3cvcEFRWBOz1vL56Eua02nPRgp9Q4LFY4/Txe7VUzAe1/aRRRRki3oT521HLeS05sv/WfzTO6QdRScK/MBixAQkQ4ECJgu7C3C5w5we8NIlUBwU9UbSfn1Sop2VGEzqNf3hAZwBOyZL07wIv8Pl1muHJBL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMwXNYGHW4uaXuuBIcrr5snOas/7hHLYRZnEA19aEW4=;
 b=VjFQu9SmId1DUt/royumc/UHGwmdK01+14oWRxGODMqcCvEv7EppBAWL7QsZLvbt9W64r3/GgsUTo0IpltmqlBsrbort6aygzWsRvZcJk+gQJzxdcmzHCq4hvQdvpkA0RNaPSygpvS4jo0zTh6/yvzVMSaqRxWMZNlj9CVhrFSE=
Received: from PH7PR10CA0016.namprd10.prod.outlook.com (2603:10b6:510:23d::8)
 by SJ2PR12MB7845.namprd12.prod.outlook.com (2603:10b6:a03:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 21:01:40 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:510:23d:cafe::76) by PH7PR10CA0016.outlook.office365.com
 (2603:10b6:510:23d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:39 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:32 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 02/80] drm/amd/display: Generalize DMUB memory flushes from
 host
Date: Thu, 9 Jul 2026 16:47:30 -0400
Message-ID: <20260709205936.5719-3-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|SJ2PR12MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 611790cb-be69-4723-9a19-08deddfd4599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i5jowGLa8jzygiV1n0hMZ7mGFdBMUy6N8PA/xsRFaRDGcQGil8ui6UZhNl61w2/18SxGKn8ks0dUQ6HEbODh2/JNlL9ugox60y0a4I8Tvz9ldmr26v6WGxWYFLuSeQPpZxJBFhnQbhDec1bM6QpFt6qWLG+hRae3Ulqtj73RqXLiyr3etcniE8wVqJyl5dpNJtCjLpjAWkg9uyXM8hDe0GPc3cJCw7B9FUCnJrhsycE4jIQX9e5UxwvPOWBHY6QjrpJPYg6WQsG2HogJ7mDVu5jdN4AHcBpijcMRQgHWacK1u/58l6CUxrC0dqYrXwq1rScmv3e0KkWwP+FPlV0aOQsRlRyDItM7VetZUDmsirennr9NsADySUz/JJ6fYN0NJebofVTHB/gkM5b+ifAEq+yFDc8XCarjMFWmsKYeiIDXfMkjXWz03TVBMB4nVpNkkmuHbMAuFFJ3oNO2Srh7RNLzBbDb1S0e2rxiPervqlcFFCixJvToWoBsuCn4GMMXIUsipy8t1Zl87a+zAhRRLVaUrq0LXzIgTz0NwXoDbptFB8dv05eaMd90lVVMKh9xsOUbAm5l5uRuek3UK0hc1ALiNgt1SWP32Z/KbzMz2317XmVTn10FPNXODNt6r4N8RSVy7+fbXrRtvI5JXgWxuEKxWo0AZiasloVVAgqU3rTL8s4NvOBCLPAkxzSdAVHZ7eswUJdrbAl3p7z7A0oYrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QLahAMkepuPtcCGwsuDLZUVPRz565Yx2MlVFLNpDknxiDqETvzuMEkhIeXe3FokIXNP56g0CDzs90xb4hfUk9wud+0hindAunFcDq0NCWgdR6iSS7BnTHBMCOoveS3p0H7eSsW5YwWRtPoCmRIq79zUiKM2bUMKt0eCPFr+UGyZWTb0owqK1nXbYxtHSZLTYGanZ0b6VNDoEkUKtNJTy+SlFgBd7tymIhUO3yhBxIhlxzmL8kxWuUwMmi4fMVKCrV6kK0LHQ+V77r1dFyPUmg80dNe4sQwZVtcxHjjrzOb2PpOIpFqic+My5L9u06zUgX5MFZTbWRCRFyr78ZSq37nuJ3EcpJ75C4HiGzUPabuJRiEDx7jXWM1vJZZqmPXunNYCbGCevOIUEYDvDaaCQJfFMfrI69KiFMeAkd6FktQEjrzZQCc5alFTZ4xn8BHnV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:39.6576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 611790cb-be69-4723-9a19-08deddfd4599
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7845
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Add DMUB service context to aid in platform abstraction when
flushing memory from the host.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  5 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |  4 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  9 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 55 +++++++++++--------
 5 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 9cc912b63ddf..9d08a3055996 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -147,7 +147,7 @@ int dm_dmub_hw_init(struct amdgpu_device *adev)
 	struct dmub_srv_hw_params hw_params;
 	enum dmub_status status;
 	const unsigned char *fw_inst_const, *fw_bss_data;
-	u32 i, fw_inst_const_size, fw_bss_data_size;
+	u32 fw_inst_const_size, fw_bss_data_size;
 	bool has_hw_support;

 	if (!dmub_srv)
@@ -243,8 +243,7 @@ int dm_dmub_hw_init(struct amdgpu_device *adev)
 	if (dmcu)
 		hw_params.psp_version = dmcu->psp_version;

-	for (i = 0; i < fb_info->num_fb; ++i)
-		hw_params.fb[i] = &fb_info->fb[i];
+	hw_params.fb_info = fb_info;

 	/* Enable usb4 dpia in the FW APU */
 	if (dc->caps.is_apu &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 3fe30c8769d3..925d890d7079 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1908,6 +1908,8 @@ static void dc_dmub_srv_ib_based_fams2_update_config(struct dc *dc,
 	config->global.features.bits.enable = enable && context->bw_ctx.bw.dcn.fams2_global_config.features.bits.enable;
 	config->global.features.bits.enable_ppt_check = dc->debug.fams2_config.bits.enable_ppt_check;

+	dmub_srv_flush_buffer_mem(dc->ctx->dmub_srv->dmub, &dc->ctx->dmub_srv->dmub->ib_mem_gart);
+
 	dm_execute_dmub_cmd_list(dc->ctx, 1, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 }

@@ -2073,7 +2075,7 @@ bool dc_dmub_srv_ips_query_residency_info(const struct dc_context *ctx, uint8_t
 	union dmub_rb_cmd cmd;
 	uint32_t bytes = sizeof(struct dmub_ips_residency_info);

-	dmub_flush_buffer_mem(&ctx->dmub_srv->dmub->scratch_mem_fb);
+	dmub_srv_flush_buffer_mem(ctx->dmub_srv->dmub, &ctx->dmub_srv->dmub->scratch_mem_fb);
 	memset(&cmd, 0, sizeof(cmd));

 	cmd.ips_query_residency_info.header.type = DMUB_CMD__IPS;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index 2f4d368bd3fd..f60e43ba6060 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -166,7 +166,7 @@ void dmub_abm_init_config(struct abm *abm,
 	uint8_t panel_mask = 0x01 << inst;

 	// TODO: Optimize by only reading back final 4 bytes
-	dmub_flush_buffer_mem(&dc->dmub_srv->dmub->scratch_mem_fb);
+	dmub_srv_flush_buffer_mem(dc->dmub_srv->dmub, &dc->dmub_srv->dmub->scratch_mem_fb);

 	// Copy iramtable into cw7
 	memcpy(dc->dmub_srv->dmub->scratch_mem_fb.cpu_addr, (void *)src, bytes);
@@ -227,7 +227,7 @@ bool dmub_abm_save_restore(
 	unsigned int bytes = sizeof(struct abm_save_restore);

 	// TODO: Optimize by only reading back final 4 bytes
-	dmub_flush_buffer_mem(&dc->dmub_srv->dmub->scratch_mem_fb);
+	dmub_srv_flush_buffer_mem(dc->dmub_srv->dmub, &dc->dmub_srv->dmub->scratch_mem_fb);

 	// Copy iramtable into cw7
 	memcpy(dc->dmub_srv->dmub->scratch_mem_fb.cpu_addr, (void *)pData, bytes);
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index f4d05dcfef29..94d4b40ee16a 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -329,7 +329,7 @@ struct dmub_soc_fb_info {
  * @load_inst_const: true if DMUB should load inst const fw
  */
 struct dmub_srv_hw_params {
-	struct dmub_fb *fb[DMUB_WINDOW_TOTAL];
+	struct dmub_srv_fb_info *fb_info;
 	struct dmub_soc_fb_info soc_fb_info;
 	uint32_t psp_version;
 	bool load_inst_const;
@@ -592,9 +592,11 @@ struct dmub_srv {
 	void *user_ctx;
 	uint32_t fw_version;
 	bool is_virtual;
+	bool no_ext_reg_access;
 	struct dmub_fb scratch_mem_fb;
 	struct dmub_fb ib_mem_gart;
 	struct dmub_fb cursor_offload_fb;
+	const struct dmub_srv_fb_info *fb_info;
 	volatile struct dmub_shared_state_feature_block *shared_state;
 	volatile struct dmub_cursor_offload_v1 *cursor_offload_v1;
 	volatile const struct dmub_fw_state *fw_state;
@@ -954,14 +956,15 @@ enum dmub_status dmub_srv_get_gpint_dataout(struct dmub_srv *dmub,
 					     uint32_t *dataout);

 /**
- * dmub_flush_buffer_mem() - Read back entire frame buffer region.
+ * dmub_srv_flush_buffer_mem() - Read back entire frame buffer region.
  * This ensures that the write from x86 has been flushed and will not
  * hang the DMCUB.
+ * @dmub: the dmub service
  * @fb: frame buffer to flush
  *
  * Can be called after software initialization.
  */
-void dmub_flush_buffer_mem(const struct dmub_fb *fb);
+void dmub_srv_flush_buffer_mem(struct dmub_srv *dmub, const struct dmub_fb *fb);

 /**
  * dmub_srv_get_fw_boot_status() - Returns the DMUB boot status bits.
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 7463d2ae5055..5a1a2276c432 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -96,7 +96,7 @@ static inline uint32_t dmub_align(uint32_t val, uint32_t factor)
 	return (val + factor - 1) / factor * factor;
 }

-void dmub_flush_buffer_mem(const struct dmub_fb *fb)
+void dmub_srv_flush_buffer_mem(struct dmub_srv *dmub, const struct dmub_fb *fb)
 {
 	const uint8_t *base = (const uint8_t *)fb->cpu_addr;
 	uint8_t buf[64];
@@ -114,6 +114,8 @@ void dmub_flush_buffer_mem(const struct dmub_fb *fb)
 	/* Read anything leftover into the buffer. */
 	if (end < fb->size)
 		dmub_memcpy(buf, base + pos, fb->size - end);
+
+	(void)dmub;
 }

 static const struct dmub_fw_meta_info *
@@ -748,31 +750,38 @@ enum dmub_status dmub_srv_is_hw_init(struct dmub_srv *dmub, bool *is_hw_init)
 enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 				  const struct dmub_srv_hw_params *params)
 {
-	struct dmub_fb *inst_fb = params->fb[DMUB_WINDOW_0_INST_CONST];
-	struct dmub_fb *stack_fb = params->fb[DMUB_WINDOW_1_STACK];
-	struct dmub_fb *data_fb = params->fb[DMUB_WINDOW_2_BSS_DATA];
-	struct dmub_fb *bios_fb = params->fb[DMUB_WINDOW_3_VBIOS];
-	struct dmub_fb *mail_fb = params->fb[DMUB_WINDOW_4_MAILBOX];
-	struct dmub_fb *tracebuff_fb = params->fb[DMUB_WINDOW_5_TRACEBUFF];
-	struct dmub_fb *fw_state_fb = params->fb[DMUB_WINDOW_6_FW_STATE];
-	struct dmub_fb *shared_state_fb = params->fb[DMUB_WINDOW_SHARED_STATE];
+	struct dmub_fb *inst_fb;
+	struct dmub_fb *stack_fb;
+	struct dmub_fb *data_fb;
+	struct dmub_fb *bios_fb;
+	struct dmub_fb *mail_fb;
+	struct dmub_fb *tracebuff_fb;
+	struct dmub_fb *fw_state_fb;
+	struct dmub_fb *shared_state_fb;

 	struct dmub_rb_init_params rb_params, outbox0_rb_params;
 	struct dmub_window cw0, cw1, cw2, cw3, cw4, cw5, cw6, region6;
 	struct dmub_region inbox1, outbox1, outbox0;

-	uint32_t i;
-
 	if (!dmub->sw_init)
 		return DMUB_STATUS_INVALID;

-	for (i = 0; i < DMUB_WINDOW_TOTAL; ++i) {
-		if (!params->fb[i]) {
-			ASSERT(0);
-			return DMUB_STATUS_INVALID;
-		}
+	if (!params->fb_info || params->fb_info->num_fb < DMUB_WINDOW_TOTAL) {
+		ASSERT(0);
+		return DMUB_STATUS_INVALID;
 	}

+	inst_fb = &params->fb_info->fb[DMUB_WINDOW_0_INST_CONST];
+	stack_fb = &params->fb_info->fb[DMUB_WINDOW_1_STACK];
+	data_fb = &params->fb_info->fb[DMUB_WINDOW_2_BSS_DATA];
+	bios_fb = &params->fb_info->fb[DMUB_WINDOW_3_VBIOS];
+	mail_fb = &params->fb_info->fb[DMUB_WINDOW_4_MAILBOX];
+	tracebuff_fb = &params->fb_info->fb[DMUB_WINDOW_5_TRACEBUFF];
+	fw_state_fb = &params->fb_info->fb[DMUB_WINDOW_6_FW_STATE];
+	shared_state_fb = &params->fb_info->fb[DMUB_WINDOW_SHARED_STATE];
+
+	dmub->fb_info = params->fb_info;
+
 	memcpy(&dmub->soc_fb_info, &params->soc_fb_info, sizeof(params->soc_fb_info));
 	dmub->psp_version = params->psp_version;

@@ -800,7 +809,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		 * flushed yet. This only occurs in backdoor loading.
 		 */
 		if (params->mem_access_type == DMUB_MEMORY_ACCESS_CPU)
-			dmub_flush_buffer_mem(inst_fb);
+			dmub_srv_flush_buffer_mem(dmub, inst_fb);

 		if (params->fw_in_system_memory && dmub->hw_funcs.backdoor_load_zfb_mode)
 			dmub->hw_funcs.backdoor_load_zfb_mode(dmub, &cw0, &cw1);
@@ -851,10 +860,10 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,

 	dmub->shared_state = shared_state_fb->cpu_addr;

-	dmub->scratch_mem_fb = *params->fb[DMUB_WINDOW_7_SCRATCH_MEM];
-	dmub->ib_mem_gart = *params->fb[DMUB_WINDOW_IB_MEM];
+	dmub->scratch_mem_fb = params->fb_info->fb[DMUB_WINDOW_7_SCRATCH_MEM];
+	dmub->ib_mem_gart = params->fb_info->fb[DMUB_WINDOW_IB_MEM];

-	dmub->cursor_offload_fb = *params->fb[DMUB_WINDOW_CURSOR_OFFLOAD];
+	dmub->cursor_offload_fb = params->fb_info->fb[DMUB_WINDOW_CURSOR_OFFLOAD];
 	dmub->cursor_offload_v1 = (struct dmub_cursor_offload_v1 *)dmub->cursor_offload_fb.cpu_addr;

 	if (dmub->hw_funcs.setup_windows)
@@ -1014,13 +1023,14 @@ enum dmub_status dmub_srv_wait_for_hw_pwr_up(struct dmub_srv *dmub,
 enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 					     uint32_t timeout_us)
 {
+	const uint32_t delay_us = 100;
 	uint32_t i;
 	bool hw_on = true;

 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;

-	for (i = 0; i <= timeout_us; i += 100) {
+	for (i = 0; i <= timeout_us; i += delay_us) {
 		union dmub_fw_boot_status status = dmub->hw_funcs.get_fw_status(dmub);

 		if (dmub->hw_funcs.is_hw_powered_up)
@@ -1029,7 +1039,7 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 		if (status.bits.dal_fw && status.bits.mailbox_rdy && hw_on)
 			return DMUB_STATUS_OK;

-		udelay(100);
+		udelay(delay_us);
 	}

 	return DMUB_STATUS_TIMEOUT;
@@ -1258,6 +1268,7 @@ bool dmub_srv_get_diagnostic_data(struct dmub_srv *dmub)
 	if (!dmub || !dmub->hw_funcs.get_diagnostic_data)
 		return false;
 	dmub->hw_funcs.get_diagnostic_data(dmub);
+
 	return true;
 }

--
2.55.0

