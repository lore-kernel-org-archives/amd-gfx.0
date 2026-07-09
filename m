Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33135C44507
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA53210F6E9;
	Thu,  9 Jul 2026 21:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RojXLel2";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F198410F6E6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSCGCqHKx8Jr3dr2AhxJxI9jJmD4SueGSkSmNJt6TBHT3xrmnRUnyUXvPUue8j6oGcmRJimgX/gL4MGgbQoYU4zp/myEauFK0Q+S4P7esemKnHP6J8flCN9/j16FC9FtSp+m3HVP/b9Q1IsF7fWexWkwpChM2g9IFSgbRtdmOrmblkAwBCspE11fKUHuDVcdMFErieMsVGYmuzYpfyyxsiiX6HZWI3jT/iVePuu0+0hESP+QAsuci/3IcKDLVkqBTlQ+a2EJnDoLxXRackK4weojcNdZ9NMhksbWIAqCVOxMZnL2sIwigRm5tReM8vxy99HArveGjrbw1Ncxw2g29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx9dzbtFEmGVJLsJ+qAoX3/fMd339NQltnSLlqMIN1k=;
 b=yGGEGDODjDCdlS+QI0Kaawt+P5XG6Gby6LXWu0jePAsTpZghZQDSoxYzFJPqG3ovZjdhORM2YUwm0/gjSu8zpOP4M87ZNUIXP2jmAaLxVtCOTAW5rDmaAbZOfsPjak/EPvNMLZNa+yvOHgROcq8lwRNSai1pEvFaeCMMTrIEa+QC57icHivHHQk7KlwR9IKNssGWlur0JePNnvUL/4Anhn1t3rDmnq+CrbuCg3H64kIhaTJPjZhBRwcXZtEyhYn8uW9rmgC83YMfeE2fQ61O/1Hq9AGrFd3aTxXlGE09SCZxRHDgC/PwY6BGFFBcSmYLdCGMlltGUL+NLwlXGQo35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx9dzbtFEmGVJLsJ+qAoX3/fMd339NQltnSLlqMIN1k=;
 b=RojXLel2l6zmcAHMRGlVc52SMw6oRcAFzGgfrgfyEQpwZw/M5OaQN0mWzcGz/odk7r9SPIV6zW5hkbTsec0nF9U5Nox5dFoOWKJxMAsH7VqvhE9Sosf4gikRVipdkdsML7QdQ6rTIs36SfdE50NjEBVDl6864X+x5uhWyRZtlAE=
Received: from BLAPR03CA0117.namprd03.prod.outlook.com (2603:10b6:208:32a::32)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:27 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:32a:cafe::81) by BLAPR03CA0117.outlook.office365.com
 (2603:10b6:208:32a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:24 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:04 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 38/80] drm/amd/display: Tear down dangling pipe on boot to fix
 s0i3
Date: Thu, 9 Jul 2026 16:48:06 -0400
Message-ID: <20260709205936.5719-39-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: b4408ba6-a965-4bd3-b3e0-08deddfd607f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8FZUKl3EIi1u+NWto28fl6BUihF6ioUTj5voXbAFdMaSIFyuPaNXuVkLjdKe4qioIWGBTRVCwU85tb6I6Nj3ahE0zzeltzkEz+cCcH4rDt+MX0JVlxQb9+qSElk9grVQolhdA9WftAi4y1cKcyRqpCdzgnGcpWUcTg3x1pC9vWGfUsZdGBlk3YBXEzssV9P4sp6f5DnuiLIYb+W+8XPqkz57pNZy5nzIhX/hSve1udJXdNM0olgurAlYBS+Lv5U58Zb8ilpDyNYdbbThHP1oVWZk9vQdvuOqhdJEFK14nLhL0qJgvkrq5guMNlE/vdB+h6RbMSLy1ciUQJV6/y32zKHSVwX4gM7IMfK1yqgg/jVd/nxHLjfO1kbQrcYM8YHD1Rzz7lgL68zzvrUAIuQPHqEvFzbxJrF8kXPcfGj1NJ/sxw6PAap9rGrGbAaihKSTZrYIdHCKKjnWwloR5E2uBxj/m0cV8Kqza+KcIxKdyQlu4y1kZ28mc4v9PgR1rS3zeI5rEXquhaGoQvRHyPHEgX83xZN5sK8yvMDd4igkIYcD4Y5xCQ9jKLuSISUVI/oMY2k/akPqEYwAFdf2DhnyHpZ8PkQt+ylmKuHdKkTKloua3ooQDAr4ht1dx1hkLgUlvFD2Gt231ci+ArBbk6T/Wy4lSK62TG0oo4vbSN6aozsshc1ZnKy/4bkoTuDoQAJnR08a8876tWGl7dJuFVeMsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0r2B9nBYY7Pz9vc6d6TkoqmeKiQ42qQKAPDNl+rax5y215QNO6UgKT8aVNDbMmHQyc1E9qksRSNRJyRFonQEa8HHbTuc6pJYJDc6D0aRnm0Cg4h1fO8nwD4bScIo8UreEEx6b86kqVHDYRGUD3a4ry7pqzSPfaiVAXanJyfz+e8i8PgXuakbHQJ1i9oRadC754YxulUHYpHVfgDLT6ulQpBNqAH9VmGbuA8leTwPe4phWGIwsiCbDx0GsEuUQIdZIA4Ab5bV6ZjEbCPZAXT7aof4IZzlNtCN2Z+GE4ElyKAioxhNV30f6G3+hECqIXbS/Dje2tPASjSvpFXhxZXcjKAlI18/ZQl6KdoJB/57bzfUeT4guyRVWGjIICZunF5zSa1ha8JH6s8mPylvfZl75GY7eZkMtc+IBVIZdtoPTMaaEnaK7MZIYaR4K2kQBl4P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:24.8105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4408ba6-a965-4bd3-b3e0-08deddfd607f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
If an external monitor is connected at power-on and then unplugged
before the driver loads (e.g. at the GRUB menu), the system can no
longer enter the s0i3 deepest suspend state, even though all connectors
report disconnected.

The pre-OS firmware (GOP/vBIOS) lights up a front-end for the display
that is present at power-on. The driver never fully tears this inherited
pipe down, and the leftover pipe keeps the DCN block from reaching idle,
which blocks s0i3.

[How]
Add dc_disable_dangling_timing_generators() to DC core and call it from
amdgpu_dm right after dc_hardware_init(). It scans every enabled timing
generator and classifies it as in-use or dangling. If a dangling pipe
exists and nothing needs to be preserved, power down the hw blocks so
DCN can reach idle.

Assisted-by: Cursor:claude-opus-4.8
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   8 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 109 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
 3 files changed, 119 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d67dcaa3fa8f..d184cc4de693 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -779,6 +779,14 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)

 	dc_hardware_init(adev->dm.dc);

+	/* GOP/vBIOS may leave an OPTC enabled for a display present at power-on
+	 * but no longer driven (e.g. an external DP unplugged at boot). Such a
+	 * dangling pipe keeps DCN out of idle and blocks s0i3. Power it down
+	 * here when nothing needs to be preserved.
+	 */
+	if (adev->flags & AMD_IS_APU)
+		dc_disable_dangling_timing_generators(adev->dm.dc);
+
 	adev->dm.hpd_rx_offload_wq = amdgpu_dm_hpd_rx_irq_create_workqueue(adev);
 	if (!adev->dm.hpd_rx_offload_wq) {
 		drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\n");
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0b54d84c203d..4a1d63e157af 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6234,6 +6234,115 @@ void dc_interrupt_ack(struct dc *dc, enum dc_irq_source src)
 	dal_irq_service_ack(dc->res_pool->irqs, src);
 }

+/* Preserve this tg if a physical link is still lighting a present display */
+static bool should_preserve_tg(struct dc *dc, struct timing_generator *tg)
+{
+	unsigned int i, j;
+
+	/* Check if a physical link is lighting this tg */
+	for (i = 0; i < dc->link_count; i++) {
+		struct dc_link *link = dc->links[i];
+		int fe;
+
+		if (!link || link->ep_type != DISPLAY_ENDPOINT_PHY ||
+				!link->link_enc ||
+				!link->link_enc->funcs->is_dig_enabled ||
+				!link->link_enc->funcs->is_dig_enabled(link->link_enc) ||
+				!link->link_enc->funcs->get_dig_frontend)
+			continue;
+
+		/* Get the DIG front-end this link's encoder drives; skip if none */
+		fe = link->link_enc->funcs->get_dig_frontend(link->link_enc);
+		if (fe == ENGINE_ID_UNKNOWN)
+			continue;
+
+		/* Find the stream encoder bound to this link's front-end */
+		for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
+			struct stream_encoder *se = dc->res_pool->stream_enc[j];
+
+			/* Skip unless this stream encoder feeds our front-end and drives this tg */
+			if (se->id != fe || !se->funcs->dig_source_otg ||
+					(int)se->funcs->dig_source_otg(se) != tg->inst)
+				continue;
+
+			/* This link drives the OTG: keep a seamless-boot eDP, or
+			 * any external link whose sink is still connected.
+			 */
+			if (link->connector_signal == SIGNAL_TYPE_EDP)
+				return true;
+			if (link->link_enc->funcs->get_hpd_state &&
+					dc->link_srv->get_hpd_state(link))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * GOP/vBIOS may leave an OPTC enabled for a display present at power-on but no
+ * longer driven (e.g. external DP unplugged at boot). Such a dangling pipe keeps
+ * DCN out of idle and blocks s0i3. If nothing needs to survive (no committed
+ * stream or seamless-boot eDP) and no sink is still connected, power down all hw
+ * blocks.
+ */
+void dc_disable_dangling_timing_generators(struct dc *dc)
+{
+	struct dce_hwseq *hws = dc->hwseq;
+	bool any_dangling = false;
+	bool any_preserved = false;
+	bool any_connected = false;
+	unsigned int i;
+
+	/* No real hw to touch on a virtual/emulated environment */
+	if (dc->ctx->dce_environment == DCE_ENV_VIRTUAL_HW)
+		return;
+
+	/* Wake hw out of IPS before reading/touching tg state */
+	dc_exit_ips_for_hw_access(dc);
+
+	/* Classify every enabled tg as either to-preserve or dangling */
+	for (i = 0; i < dc->res_pool->timing_generator_count; i++) {
+		struct timing_generator *tg = dc->res_pool->timing_generators[i];
+
+		if (!tg || !tg->funcs->is_tg_enabled ||
+				!tg->funcs->is_tg_enabled(tg))
+			continue;
+
+		if (should_preserve_tg(dc, tg))
+			any_preserved = true;
+		else
+			any_dangling = true;
+	}
+
+	/* A physically connected sink (HPD asserted) will be re-lit by a
+	 * subsequent atomic commit. For that case we don't call the global
+	 * power_down().
+	 */
+	for (i = 0; i < dc->link_count; i++) {
+		struct dc_link *link = dc->links[i];
+
+		if (link && link->ep_type == DISPLAY_ENDPOINT_PHY &&
+				link->link_enc && link->link_enc->funcs &&
+				link->link_enc->funcs->get_hpd_state &&
+				dc->link_srv->get_hpd_state(link)) {
+			any_connected = true;
+			break;
+		}
+	}
+
+	if (!any_dangling)
+		return;
+
+	if (!any_preserved && !any_connected && hws && hws->funcs.power_down) {
+		/* Truly headless / all sinks unplugged: nothing to preserve */
+		DC_LOG_DC("%s: powering down dangling hw blocks to allow idle\n",
+				__func__);
+		hws->funcs.power_down(dc);
+		return;
+	}
+}
+
 void dc_power_down_on_boot(struct dc *dc)
 {
 	if (dc->ctx->dce_environment != DCE_ENV_VIRTUAL_HW &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c78fdfc0ef4b..572559d403ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -3010,6 +3010,8 @@ void dc_resume(struct dc *dc);

 void dc_power_down_on_boot(struct dc *dc);

+void dc_disable_dangling_timing_generators(struct dc *dc);
+
 /*
  * HDCP Interfaces
  */
--
2.55.0

