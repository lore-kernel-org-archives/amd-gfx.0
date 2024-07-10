Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AB8C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DC910E89E;
	Wed, 10 Jul 2024 19:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rV2I1ujl";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C794C10E89C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:37:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaB0BKe7Ym7V9LIIpn7m9e4PC0wz19ZelNCeTFVeW4DLwjxXJusaVvGq2BR5jCCfQ3dtQ9gFIqlf210fUkoGIrj6q1bEku6eWXcAPlKcNOaAPCAKWKUIqoG6uaCz89C4p/zE/k1V+4Rs7ThiVnxjRGnUNw4ktaSa8pCX3sPWVdoSvlK5rwDxq6roLKMbuMWMcZiknoYYg2pH26c7FWjS7S954QfBu7Oz/qVhhOuLBJjvl2Vn4uNu+TeH4MdTk0xee3I8HoTUCYZZHvBW8Z8CN3ErmbzndoiXpg9xm1Qq8a436/GIiG3FAcyo0GP11iZ3EG041SeydukGp/sEXXnhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNW+OcNw5SawQHHExIzIHFyfOttjSKXhmPbFINzz3Oo=;
 b=gmRaAoPHHFGttAlj47u9ksl7mMBaaBr9voodsK3QVMIK0iXhPP2GHcwhdpM7RKqteeftVp4MLNohVWqk8X8TW32sOT/MDuh70yvW4iUOXCXgzV2GFm8iwqtH8Qv1aGgKMpFr32BfkvYz6gD1xYNybVezwbvmuA5+uKmo9QExjYknv1EKoO6m/PLFN7KwF3Bjs408JvwAlD5I8RsDPO/1fd6JP88AxwokQR/4jtzSMly2z3p6qftxm6dk0ESMfOxo5iEyuf0Fl51wgKYZho/0Ri8+ffWi18FqKtin9UM/ult7bSBPufqmTdDRX0Agtlz9dZwgsIsa7VMJ7zfvN0lsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNW+OcNw5SawQHHExIzIHFyfOttjSKXhmPbFINzz3Oo=;
 b=rV2I1ujlMnO/VJa4FiBfgYwOW9W0TKKpKysN/vT81uiMdB9QD1Lx6YVonYk8g/NzKrVVx7d+vLX/6Rh/sLPT63Q0u8dkL+HMA0d3LUwA4G2j3uWfRuzDt3JrKHywq6YJqIJ4Y076Z4RzuStZ3+EZZFAHYEtQto2bswtzuBn0cgI=
Received: from BY5PR17CA0008.namprd17.prod.outlook.com (2603:10b6:a03:1b8::21)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:37:28 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::90) by BY5PR17CA0008.outlook.office365.com
 (2603:10b6:a03:1b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:37:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:25 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:37:24 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 02/50] drm/amd/display: Disable HBR audio for DP2 for certain
 ASICs
Date: Wed, 10 Jul 2024 15:36:19 -0400
Message-ID: <20240710193707.43754-3-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f5782c-2e12-49c7-d009-08dca117bb8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5G18/uXnwZ5FqAn6lUxyMcY3SFcXT+eGUZVYFGle0V/u2xgjorvI2ukAw8F4?=
 =?us-ascii?Q?0YSnEYNmKjIWYppDELlCrM/1JfAdztYY3P6xAyNbHDMwV9kDTAfvAGsg3N9R?=
 =?us-ascii?Q?WP3FbSVRUBJpQnCME5KU8uhqxd0HZ5x3PPCPi2etzFQNEpeB+5pSVb+L03OX?=
 =?us-ascii?Q?xhDh41K2OYXL7u5qtQmLR1CPhxwpjnYjo2oyq7VYx0NjRTyXmJ8VRpOK0WFw?=
 =?us-ascii?Q?Br0R6cc7OmxW4eWb3M866R9JGGuX8YbJxRQd38A9dMCUzXMty/GyhmGxKwl/?=
 =?us-ascii?Q?3EOhWHn2fCFiXE+FAJYOrdAxVkIVFNaEZlKl2g3/Gs5XOC6q98G5VHJydbuJ?=
 =?us-ascii?Q?Ul6DMHK/5zM9UoGVz7g5s/W89P/Gtck1XrEoTYAk207flbh9OKgaJ0vQH5vO?=
 =?us-ascii?Q?OBo7em7k55h09D/itIFAryepXMPIQ7qyWYzHX/KJxuos607gstjCkH9eOb2n?=
 =?us-ascii?Q?w2YK0wUq78TtZtGfG0aREeFZ4ZgaQjcw5SgKs2pIE87pjQr2bJs7jB2VCoaA?=
 =?us-ascii?Q?7QQWAuEFKC5q245A1t7ed/lCvTCkJpTbyOFGWePJ12/PFe20ozs9O282ULmy?=
 =?us-ascii?Q?v4RcEFY9jqgJAYwb0M8IaLnN6sRrxHD/KO0ZRDKSOMzhOAjyQZuNVRj6ailY?=
 =?us-ascii?Q?cDdQcOr16Nhu+ef2rULVVotoZrxZY+NTwKKNpuTDMkYOTAzekaI93SyLIwN0?=
 =?us-ascii?Q?EJgosNzBke6lL5XbIg64M1agwnioYQkTXiDKkjBEpYStncDgiLOi4pM4k9q0?=
 =?us-ascii?Q?MzDAR+NyOlLGFkSyJY8XumgpikI73G458LzpATSIAV9r4JFbxvKk40yylkRs?=
 =?us-ascii?Q?ZqAwGd8ofbXmPrldGWBvqzWZ9B/NkV6kwfQhlwfwScPN/R028gRkRglE/nPn?=
 =?us-ascii?Q?gVxhU3m/nBXlYZgrG07nIFFyJLXB7nn0CN4dbd3/NC8+5gXaUvCws+gmIKQ6?=
 =?us-ascii?Q?6Gq+o6Ob7wXBR6uooHS/8IkFwMRhAvOTEU74HvZ8o7Cbkqvpk3WTb2ctjKw8?=
 =?us-ascii?Q?oCd7+Wylz52PHN9NoOnD0d5aMEOttd2Yi7rILWIM/2sGZezWZp713SCHMCMP?=
 =?us-ascii?Q?Usc8IbOJZXab/7t0BjW1wONRlc6L7HSKr0e2FAIlhGmJ3iTekphmT6Mmxiel?=
 =?us-ascii?Q?QNd10r29bmn//LAhEvsKESItK5qktb+2dty08zSc81p+nh5ftcBFonyjJk6o?=
 =?us-ascii?Q?cmsVFwaCDFiWfFqTOv3w6nxgAPRlf6qVIpHXeFWyheXXC6VsbBVUM1s0FFaH?=
 =?us-ascii?Q?U4vrjU24TOn1UZEzmrWoInOht1hKUjgAbo/nJkC0X7y+ic5nPQVBy7r2Anip?=
 =?us-ascii?Q?Boqsrz6cXnmAIL8hZiks0eEZ1WvCENLKheR/1hZ8Vcg94CktbMYkXqJMiqdO?=
 =?us-ascii?Q?0C0cYO0R/1KBZ+o8jlnkf+6WMxYjjbUi1peqW0IFsW3coVKsImPvVt4SWXAM?=
 =?us-ascii?Q?uKY8Vr/2DUOe5L9PbwRiqDRprkrIeW+K?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:37:27.7836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f5782c-2e12-49c7-d009-08dca117bb8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
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

From: Alvin Lee <alvin.lee2@amd.com>

[Description]
Due to a HW bug, HBR audio is not supported for
DP2 encoders for certain ASICs.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                         | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c              | 6 ++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.h              | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c   | 5 +++++
 drivers/gpu/drm/amd/display/dc/inc/hw/audio.h               | 2 ++
 .../gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c  | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 1 +
 .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c    | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 1 +
 9 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 73cdebcd9f37..4c9bb913125d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -466,6 +466,7 @@ struct dc_config {
 	bool use_assr_psp_message;
 	bool support_edp0_on_dp1;
 	unsigned int enable_fpo_flicker_detection;
+	bool disable_hbr_audio_dp2;
 };
 
 enum visual_confirm {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index cf5f84fb9c69..eeed840073fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -630,6 +630,11 @@ void dce_aud_az_enable(struct audio *audio)
 			audio->inst, value);
 }
 
+void dce_aud_az_disable_hbr_audio(struct audio *audio)
+{
+	set_high_bit_rate_capable(audio, false);
+}
+
 void dce_aud_az_disable(struct audio *audio)
 {
 	uint32_t value;
@@ -1293,6 +1298,7 @@ static const struct audio_funcs funcs = {
 	.az_enable = dce_aud_az_enable,
 	.az_disable = dce_aud_az_disable,
 	.az_configure = dce_aud_az_configure,
+	.az_disable_hbr_audio = dce_aud_az_disable_hbr_audio,
 	.destroy = dce_aud_destroy,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
index 539f881928d1..1b7b8b079af4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
@@ -166,6 +166,7 @@ void dce_aud_hw_init(struct audio *audio);
 
 void dce_aud_az_enable(struct audio *audio);
 void dce_aud_az_disable(struct audio *audio);
+void dce_aud_az_disable_hbr_audio(struct audio *audio);
 
 void dce_aud_az_configure(struct audio *audio,
 	enum signal_type signal,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 1f2eb2f727dc..51c5195f8325 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1597,6 +1597,11 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 				&audio_output.crtc_info,
 				&pipe_ctx->stream->audio_info,
 				&audio_output.dp_link_info);
+
+		if (dc->config.disable_hbr_audio_dp2)
+			if (pipe_ctx->stream_res.audio->funcs->az_disable_hbr_audio &&
+					dc->link_srv->dp_is_128b_132b_signal(pipe_ctx))
+				pipe_ctx->stream_res.audio->funcs->az_disable_hbr_audio(pipe_ctx->stream_res.audio);
 	}
 
 	/* make sure no pipes syncd to the pipe being enabled */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/audio.h b/drivers/gpu/drm/amd/display/dc/inc/hw/audio.h
index b6203253111c..8c18efc2aa70 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/audio.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/audio.h
@@ -46,6 +46,8 @@ struct audio_funcs {
 		const struct audio_info *audio_info,
 		const struct audio_dp_link_info *dp_link_info);
 
+	void (*az_disable_hbr_audio)(struct audio *audio);
+
 	void (*wall_dto_setup)(struct audio *audio,
 		enum signal_type signal,
 		const struct audio_crtc_info *crtc_info,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 5d1801dce273..ac8cb20e2e3b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1948,6 +1948,7 @@ static bool dcn31_resource_construct(
 
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
+	dc->config.disable_hbr_audio_dp2 = true;
 
 	/* read VBIOS LTTPR caps */
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 969658313fd6..3ed6d1fa0c44 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2220,6 +2220,7 @@ static bool dcn32_resource_construct(
 
 	dc->config.dc_mode_clk_limit_support = true;
 	dc->config.enable_windowed_mpo_odm = true;
+	dc->config.disable_hbr_audio_dp2 = true;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 9a3cc0514a36..a414ed60a724 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1780,6 +1780,7 @@ static bool dcn321_resource_construct(
 
 	dc->config.dc_mode_clk_limit_support = true;
 	dc->config.enable_windowed_mpo_odm = true;
+	dc->config.disable_hbr_audio_dp2 = true;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index ddf251901fb3..5f3705f97bd7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1899,6 +1899,7 @@ static bool dcn35_resource_construct(
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
+	dc->config.disable_hbr_audio_dp2 = true;
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.34.1

