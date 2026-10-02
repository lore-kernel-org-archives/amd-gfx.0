Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C687DCA5FE0
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E94310E6BB;
	Fri,  2 Oct 2026 19:33:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OEY9rBJt";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A6E10F9E7
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLPuR0F8pFTrGaQmKwApB8bYCerYcO+HTQFYKk3Dz3owNzckbRQ4NywRRlKriym3Cp6artLzfnA1Qnn9TtX2Lh+21AZlBmsBK+pfscNSsJzeYGt0AOQChSLKnqe+fkpHWP4HNzuyKSGcg+nYSMsoVfW7M4Fh3j0bCQOjLH1yZVm+l4hEmoaHGJ/VKkF33IsVO/9Nq9BpdvPX1IZa/zQ8Qk+U1M2XlrKoDKxMGRg4DO4+Xh6YZTYkFZmSu0h/8858aoGwgr7LOe6BGJWTFr1V8iBOq0YEULXpA7nuN7WwZXnHoS8+B+tpacEa4x2pipLd/cAb1RX0g5A5We7GzBLDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b56hn/d073fKCXtQGhjM283B9XAHnRr24/VWc9rUkc=;
 b=rvdPuVnpHIutiZ4uQtpM739TrhQPSEIqqq387UyV/+VYJoGNzfOMINbSJFU2bGVHzBntAHIhMi++6da5kqvJzvCedy6u86Ox2qxZ+1G+cgUYUvtnHR5PFaP8yjFd6GGM+SdJsI+sXcaZr9fgk+9fDzkTYCyLNyGDQSamTWoYTDe/14QRiddgj39pS6ppgduSHkQCGr1E+MKUPpujsGl3VFeHww7w5CKo2zZZNtUTw3SV3hf3ww3pnZUOGF8Neiup1h2T0IBdT6YwqPTjNcU4Ra7e/kHiU7bRromxP1stYebv/AnGanxo4lzdSRJPDoYmbHyYgvyqBz08NuAk6My8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6b56hn/d073fKCXtQGhjM283B9XAHnRr24/VWc9rUkc=;
 b=OEY9rBJtDnFpOSak0IkhXgaxUJreblVHoM1PeP4mpbi+fW41IcG01NRv7fnub2/dhr7ZLeImYAUYrhN/BLSUfwNEGd6EzXfMl0C49pUGWou+a6fGxIkPww7cSPxqqO5TnbVEpCGNyVVkhiAEFbUoUppLfCLtLmGyUYi+QNaOZjk=
Received: from CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::16)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 19:33:22 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::8a) by CH0P223CA0005.outlook.office365.com
 (2603:10b6:610:116::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:33:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:16 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:16 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 12/17] drm/amd/display: Revert "avoid to write signal specific
 for tmds"
Date: Fri, 2 Oct 2026 15:32:35 -0400
Message-ID: <20261002193240.3441018-13-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 2daf7ccf-c0ca-4a55-d738-08df20bc03cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|56012099006|11063799006|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: cBaMYt5G2kgrBUWG5cxFHCNWUehLmHJ92OHj84wDlBE29FRP3QUUO4u87RxFNKq8+kJwq6J7L4WN6Mraf4YHHybUo2VK07V94umy+yF2RY1ewbkhahIde7TURdLIkCKU7vlaY2YPdH9KcIL0LO0QRw3hjS8tfxxGj9V32OVnmR/GGQJv1MEeE9h1Er/vVVHfrE6GqwEK48VKqkcoK/4aVeJFxHTGdsufKOyRaCgMv6bc70XeAabZyZb+K7Ef2BwdvyOFWVTiO9seeuYO3bcg3cS3rFOOqTajTrO/uHfpisRXpiU87dvcjqQvzhgVlx2+sxhelsubdF5FUUv17bcsWDvS39qdSjg5b3M10snaCjV6Mx8KcmdLKH+nB8JufquYAEG7JS1n42+pG3M05BM6wbfQKQp2oh5f5LAZP8dcXq20SnD37Li4BOSNm6RUJjtx3BA1/MFGXiOnwV0PbGbQz2POzURHHHt0s6WfpKohHWo7twawv+Tg/sV3sQSC5vxdl7z4aBjkYH376Sjn+vMsqHrs4FfbBDv/vHS3NY+MjzrjQyodGiKN6dIQN6kNTDnaqGZ7me91q001nRQbsoZyTvFRRNtr22pU1qqovyExOrA52XuaZiyVrc3n0RP5g316x0oIaB/7NXoIhlGrUlv7uRrMhM4nmN6TPqiUkhok13IzgNzp0LkwuOym1qr7k6q6XEkIzM6bQT1ZyorWV2BYSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GkvLpIyVR/XnWevfCvm41aQxAddYmZPnInBdi3E4mKRjXZ2K/A0P6uj3Q8sbb+XwetSjfdB8Zgcopz+OJv9gZMHOcKUL6Rop4pWtSyQ6qzB5MLJiQIXLAMQuwSrPfNSciixuw6M//dGDk+BMPlaP5EfzIhFLd89nh1lSExq2W3daVQz3JEzRIF/nfBpufQypzs3e/6YL2DViQVTSx+p31aakUm/q1panxX9zXAqnIEov1NKbb82R2BGmQ9D75rZYcxSqeIAosIOiyxSbDIjEzHjVpReepH2Blp9kgIZY1iJs4xXq+pUKt94HHrZog+XfGPxX6mnVENOgIQwEWqtRW2M8Fvu4LjpsnTyGUQ/ly1QYDzBrX+KGODzzQUDVb7UoOnv1izaZSIk7UGUMPOYOV+ItsRCRTdMeijpvTz81ILKeNufRQToLlwguzJqvrUkL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:19.9033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2daf7ccf-c0ca-4a55-d738-08df20bc03cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911
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

From: Joshua Aberback <joshua.aberback@amd.com>

This reverts commit 8be7aa94fe09165047495120fa4d66a9aa5ca1e4.
The change regressed HDMI output on the TMDS-to-FRL switch.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c          | 2 --
 drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c | 8 +++-----
 drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h | 1 -
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index ec503d3541c9..0d3b65d40807 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1909,7 +1909,6 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 		write_scdc_data(
 			stream->link->ddc,
 			stream->phy_pix_clk,
-			dc_is_hdmi_frl_signal(pipe_ctx->stream->signal),
 			(stream->timing.flags.LTE_340MCSC_SCRAMBLE != 0));
 
 	if (dc->debug.enable_hdmi_idcc) {
@@ -2450,7 +2449,6 @@ enum dc_status link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		write_scdc_data(
 			link->ddc,
 			165000,//vbios only handles 165Mhz.
-			dc_is_hdmi_frl_signal(stream->signal),
 			false);
 		if (masked_chip_caps == AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_TISN65DP159RSBT) {
 			/* DP159, Retimer settings */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index 3fbfc6e2594b..db798656c8a8 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -570,7 +570,6 @@ struct ddc *get_ddc_pin(struct ddc_service *ddc_service)
 
 void write_scdc_data(struct ddc_service *ddc_service,
 		uint32_t pix_clk,
-		bool is_frl,
 		bool lte_340_scramble)
 {
 	bool over_340_mhz = pix_clk > 340000 ? 1 : 0;
@@ -587,10 +586,9 @@ void write_scdc_data(struct ddc_service *ddc_service,
 		(ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite ||
 		!ddc_service->link->local_sink->edid_caps.scdc_present))
 		return;
-	if (is_frl) {
-		hdmi_frl_LTS_clear_Link_Setting(ddc_service);
-		hdmi_frl_LTS_clear_Update_flag(ddc_service);
-	}
+	hdmi_frl_LTS_clear_Link_Setting(ddc_service);
+	hdmi_frl_LTS_clear_Update_flag(ddc_service);
+
 	link_query_ddc_data(ddc_service, slave_address, &offset,
 			sizeof(offset), &sink_version, sizeof(sink_version));
 	if (sink_version == 1) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
index 200823954fc6..fdd8a3dce97f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.h
@@ -91,7 +91,6 @@ uint32_t link_get_fixed_vs_pe_retimer_write_address(struct dc_link *link);
 void write_scdc_data(
 		struct ddc_service *ddc_service,
 		uint32_t pix_clk,
-		bool is_frl,
 		bool lte_340_scramble);
 
 void read_scdc_data(
-- 
2.34.1

