Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3A606A335
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WxO7cC5w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E12010F82C;
	Tue, 17 Nov 2026 17:15:02 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCFB10F82C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzdP4VxoOCUpB4Iu9AZOPta6HYaqG0/ttkKKxzNMxPlVvHNBO8pbCkq9kJUV5pUZ4WKwDCW/v/PIPEpGmDOFcQPhmlTfAbZ0MS3f0/IjwXlT49urkbDEvVVPkb9ZH2hFCXTQ/5xX7nao35kZgDn50q2kARIlLsrrzgqTdhWagYyR5ehRipOvo60eQ4H1CAskhFhA82GPf5xjbNpmq2pdzwFUM+roApKfPKO8nqpYdIUOXk6jcEHO56Lj4cAFa+XeP4DVyhte22EpE697V0ux3PMJCumR/CFVNVc3MwbTMM2qf8ZWAQqJgRjhtVoGO4YoO354cP2SxkCFsfeOlqCbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlT+s3quWGVg3b6bAbVatgP5KZMdnRoGdBe8t4haCKQ=;
 b=A52Hmb6xSltgma0Gmx05XsHd5n9rEtmh9hG6nsKQr6sOBFwwxaO4xEnFZSQ+5qecUI8FlTD5xmKLLj8/TLmbU8QPcWchdBUQtTyXf71/a1tv/+WIVfJ8P028CdD0yrwMA3JxC4OwLr5Tnw2zpRgdqZT/O42tOAwINsimbj3DPqTA8UmenOlrMeef16braTb9SAF/QTa+T++IwVu4zGZ0NTsaK/C+jg9FHyC5V20B+NUlGP8kuuoGr2Ruya9WPg+CUEHDRNUdJWZ7h7mbYh2rMXe+6XpewuLJnNA5KrxrJU7JksPedRb0mJKyJruDLc6QST8WLBHL7mpKOmFW5zFaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlT+s3quWGVg3b6bAbVatgP5KZMdnRoGdBe8t4haCKQ=;
 b=WxO7cC5wPd+bN2cC4kYmdLQ22XVFmeHaeS1nAgpD7xNmgKgH+NKCeDz91ns0ImXpqsc1D7CSE8H45HC5tw7quoZSuB/C6V/Vb863arh9xzc98wPKMP4DwL1S5Dk1m/IDt0XPYM5++KJjEwjh/PfsLPWjcVqLaNQ6ZoKEyDHCIv4=
Received: from CH5PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:1f1::12)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 17:14:38 +0000
Received: from BN1PEPF00018072.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::4a) by CH5PR03CA0017.outlook.office365.com
 (2603:10b6:610:1f1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:14:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018072.mail.protection.outlook.com (10.167.245.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:14:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:14:24 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:14:24 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via
 Frontend Transport; Tue, 17 Nov 2026 11:14:15 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 13/33] drm/amd/display: Add otg versions of
 get_vblank_counter/scanoutpos
Date: Tue, 17 Nov 2026 05:50:50 +0800
Message-ID: <20261116215641.2800595-14-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116215641.2800595-1-PingLei.Lin@amd.com>
References: <20261116215641.2800595-1-PingLei.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018072:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d55437-921f-4f88-109d-08df44ce42d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261102123227099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6yJkUE956BMl087bQrQsfHb3t0z9zOK+bqSXaqrIdrgDPCptpP5qOZiXWoD1cptEOBrcZde/ktI42u7vj81Y+xlgnV0Uncv2+edub/1thOGZEg6/N8jTnWj55VJT0pQytGos3xlajLEyhtKrzY4MMK2nyFOEniGsvMbmTSC72j3sdGPUZNguWL74Aq3iOccy58PJd2ng/lgaRn/5OkdSMzl7WITQsNjg6hhgt15ngBshMxVZ+1D1Jdzkpn394HEC3C0v8xfakan5TT4TC8tbgpyuf4NDCwO1tO1xWkmvB2YZYiUlxx0u/mdID2hu7W7REMclIMKZwdQ6dXbWcxDppKhPVN6++9xQLcQUYxuagZBLz71sseuw6GoRh+LhwCL2I9lMaF9YoLLNMzGzEqIiXrpjD73HTRBx3KUo1JU7QKMR2ZRAp1D5vCf65Qqu223LJ9mJ056K/uSZJpWtT6oobcU6u6/+OkAtUrK3jgFT8CubT/OCJmZmH5j8AunICXdXCkGZ/ks+1+BY8a+a4ppAMyu3o40gsWsSHML9RHdCbgq2vhTAupTaJk5kCc1611MK0sMOXR7vHChwH249q4KUBoiHCsVftg83VdjDEl8cpRE3H9iTAHpQw9uuQiwPKQg7C021AdZiJnVxm3TVrd7ASW6fRWWORmkXHMN8unZHzn78bPNEShrwot88b+JvdCuW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eakpWKMo7x3p80lsf9Jtl80nagyBtlNC9TaWM++7nkySWxfAj+L03gGKAvEMiQMjgBgap+NaythAF3jSQxFArmTKJaEPyTJB6GUM/bUr5ORPkayEBtDXPq4K3h4//KRV6AsMAFWEeItGbcw5U8RdAB7RsG5TjYHzp0SAtlu8cQi7H2EE6qGQxFcGxaUi5Bszj5atMPtC4Q2MzV2/PsNSU6FoKYYDH5PWHpK7HATtFdHSbjrEEgyJqgofOzmPXOYqrINPCbOLtiP2NSmXRd7ZvthzqYGfLKwPbswODCKAx3s55Ck46mVvwzGI0a0Md8MNITgr3M0Em0vJ/BpkRGxyN3Tgf0fxdAF4+PlCQtgatt6R5rF+FWHDEWBx8eyLz2EwCXvgnbDOxXeEIVx6OOuW6y4mnw+Mo9zy0rbmbPs5uE8kmqeMnloySPfyjh+k2h8f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:14:38.4587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d55437-921f-4f88-109d-08df44ce42d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: George Zhang <george.zhang@amd.com>

[why & how]
Add functions to access the vblank_counter and scanoutpos of OTGs by
instance number.

Cc: Sun peng  Li <sunpeng.li@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 38 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  6 +++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 56c7d97733a6..01b5ddd87289 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -862,6 +862,20 @@ uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream)
 	return 0;
 }
 
+uint32_t dc_otg_get_vblank_counter(struct dc *dc, int otg_inst)
+{
+	struct resource_context *res_ctx = &dc->current_state->res_ctx;
+
+	dc_exit_ips_for_hw_access(dc);
+
+	struct timing_generator *tg = res_ctx->pipe_ctx[otg_inst].stream_res.tg;
+
+	if (!tg)
+		return 0;
+
+	return tg->funcs->get_frame_count(tg);
+}
+
 bool dc_stream_send_dp_sdp(const struct dc_stream_state *stream,
 		const uint8_t *custom_sdp_message,
 		unsigned int sdp_message_size)
@@ -937,6 +951,30 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 	return ret;
 }
 
+bool dc_otg_get_scanoutpos(struct dc *dc, int otg_inst,
+				  uint32_t *v_blank_start,
+				  uint32_t *v_blank_end,
+				  uint32_t *h_position,
+				  uint32_t *v_position)
+{
+	struct resource_context *res_ctx = &dc->current_state->res_ctx;
+
+	dc_exit_ips_for_hw_access(dc);
+
+	struct timing_generator *tg = res_ctx->pipe_ctx[otg_inst].stream_res.tg;
+
+	if (!tg)
+		return false;
+
+	tg->funcs->get_scanoutpos(tg,
+				  v_blank_start,
+				  v_blank_end,
+				  h_position,
+				  v_position);
+
+	return true;
+}
+
 bool dc_stream_dmdata_status_done(struct dc *dc, struct dc_stream_state *stream)
 {
 	struct pipe_ctx *pipe = NULL;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 94eccb87cbde..e507d334d598 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -452,6 +452,7 @@ struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i);
  * Return the current frame counter.
  */
 uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream);
+uint32_t dc_otg_get_vblank_counter(struct dc *dc, int otg_inst);
 
 /*
  * Send dp sdp message.
@@ -469,6 +470,11 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 				  uint32_t *v_blank_end,
 				  uint32_t *h_position,
 				  uint32_t *v_position);
+bool dc_otg_get_scanoutpos(struct dc *dc, int otg_inst,
+				  uint32_t *v_blank_start,
+				  uint32_t *v_blank_end,
+				  uint32_t *h_position,
+				  uint32_t *v_position);
 
 bool dc_stream_add_writeback(struct dc *dc,
 		struct dc_stream_state *stream,
-- 
2.43.0

