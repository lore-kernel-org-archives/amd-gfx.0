Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B1EC4829E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 20:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6286C10E3DD;
	Wed,  7 Feb 2024 20:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3eVrEOb0";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C271C10E3C8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 20:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y27MzpL6NkcwcfjRxEyxLFSL49ebDGgXv/9VGIHchUdLQONmtqAZWO2fwrR7mePDZo4rYn9h0UvXnCINyFNdPbTsPVZGG4Rq7uOykOU+ysdKszRgMHsEnUcSJ01Y8BPrwihMOgWrKN8434Q8K/WyGNwvWnaH04vKaMjIn15PCil1iM9WqIy3ttzUWTwrsRVXKmCTScIIJbitn2djkHWOJme5fcav57MwX6FLVvpufiL41eRQagzn3WQPWd0VpxE8xQefsqBci/ZvIZKdhZynlZ3mriHQNJNWGAM84wo6+IWrQdMYv+ERyiCIBLVsM1IRCNAfyezolAIGpdzSjJUzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/N7yb5yQg+EKBLvyZOEyMlK2pnyPCPQKZtLSv8nDA4=;
 b=Dd4Jo2iUBKFinZTMTCilLeVLOG9cAfSoV3h1fSPrxCavdAkxwBW/DXBeTAbkyVFFg8rgHxULWMp3hhcQ+Oi76vbKZDSRHuKNzpDTzp2ZDtJMtvOIlgA34JkHDZJbHCzWGMxLZllkOZOJwuygs/6Bukd/LtBAZxykmBH9fUMlrr7nc/r4ZaGJyuj24dMVu3BR4wZqI29IB65PQOjZ+qPRouz4Pe+oBn3a+JIiGBuB5TtCLWkxe9FtfO/jvxYOhwoy+Q4feGPOor/23RN9BGqAFgObIb4+f7eaX1sRAIkdxB0OsskHQLJdQHwXf7fwPu/MG9NmgKHkOZThK+DfBDCSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/N7yb5yQg+EKBLvyZOEyMlK2pnyPCPQKZtLSv8nDA4=;
 b=3eVrEOb0R2knO9OgmobSJrYuAEIorRxFQXPk0B4n9IjcIP9M3R2ZY2OqVhyAZH6JemZuu5pvtdLmcG2haLy3b9sEYAzIusNLL8HZyl7HO1JapfIVMCOTTvaL2Wf+dApERgmVR1SnbLJTpzMnyZ3wlb1LxWf6Atk9rZ5nHzB9UaY=
Received: from DM6PR18CA0003.namprd18.prod.outlook.com (2603:10b6:5:15b::16)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 20:52:14 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::f4) by DM6PR18CA0003.outlook.office365.com
 (2603:10b6:5:15b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 20:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 20:52:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 14:52:12 -0600
Received: from manjaura.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 14:52:11 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 05/15] drm/amd/display: treat plane clip size change as MED
 update type
Date: Wed, 7 Feb 2024 15:50:40 -0500
Message-ID: <20240207205200.1608684-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
References: <20240207205200.1608684-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad7662c-07e7-4487-d50a-08dc281ea979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9CMVEySJ/nJ9mZiP3NMiGr88R9hr1CM0+zXED/QjDRrUNsK9lpQXTPmWMTqrHrqUhwowtfhKwbTZmZyDo6K+evpPlQ0aqS534Otu8dCxRAEPFpbgYohXtZE7JQhxVvWgstPahb207cPdPyiPUngGbqSjX/XMSCRIxqJrHF5BIUceuCO4p+1mnsz/MEQu1QIneP+7moXfhZnR4LJOOTMKUKelDESgyGLHpt1WFtsMD7FGO7aeImStVNEdflWIQrFFve/jRbjWNiCQF58hhrKA/zC+CtMUch67YZtA+XJoddaXUfw5D4ZgQs09ehED4f81jAtXjREJJ2GNiEEtZddiS/qNdiS9jPMrQ3LgtzkVzBnsjDgjjD72pVS0CqY/F++3HUC1izOX4vGkukezdp0Yvktx7hqIDcQW++kP1hgmAxcd9MdgkLSClEenPYgg5srH5ANRdxboPUmltJdsbEND7D+PImUN2HzlBNRjJeBnBRxlL3MHccofaMqoJOmM8hCtN/hbbQiL5FrnYCPrdO0vZfsBvW0qMyZ0h82qGnccGOpalI5dDM4xwdXLlQEAwEUzeVc4VXMSt91V9Ps9g6EwV/h1cnYPeSvQ1DWc7affJc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799012)(46966006)(36840700001)(40470700004)(36756003)(6916009)(316002)(356005)(4326008)(8676002)(8936002)(478600001)(81166007)(6666004)(86362001)(1076003)(2616005)(54906003)(83380400001)(26005)(426003)(336012)(70206006)(7696005)(2906002)(15650500001)(44832011)(5660300002)(82740400003)(70586007)(41300700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:52:13.4887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad7662c-07e7-4487-d50a-08dc281ea979
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
When clip size is changed recout and viewport size would require an
update. When the update is clip size only current driver fails to
program the update into hardware.

[how]
Set a new clip_size_change flag when it is detected and set MED update
type and reprogram scaling params in next program pipe.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                | 7 ++++++-
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 72512903f88f..1d0fd69cc7bd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2454,6 +2454,10 @@ static enum surface_update_type get_scaling_info_update_type(
 		 /* Changing clip size of a large surface may result in MPC slice count change */
 		update_flags->bits.bandwidth_change = 1;
 
+	if (u->scaling_info->clip_rect.width != u->surface->clip_rect.width ||
+			u->scaling_info->clip_rect.height != u->surface->clip_rect.height)
+		update_flags->bits.clip_size_change = 1;
+
 	if (u->scaling_info->src_rect.x != u->surface->src_rect.x
 			|| u->scaling_info->src_rect.y != u->surface->src_rect.y
 			|| u->scaling_info->clip_rect.x != u->surface->clip_rect.x
@@ -2467,7 +2471,8 @@ static enum surface_update_type get_scaling_info_update_type(
 			|| update_flags->bits.scaling_change)
 		return UPDATE_TYPE_FULL;
 
-	if (update_flags->bits.position_change)
+	if (update_flags->bits.position_change ||
+			update_flags->bits.clip_size_change)
 		return UPDATE_TYPE_MED;
 
 	return UPDATE_TYPE_FAST;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c789cc2e216d..f2c27964ec1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1252,6 +1252,7 @@ union surface_update_flags {
 		uint32_t rotation_change:1;
 		uint32_t swizzle_change:1;
 		uint32_t scaling_change:1;
+		uint32_t clip_size_change: 1;
 		uint32_t position_change:1;
 		uint32_t in_transfer_func_change:1;
 		uint32_t input_csc_change:1;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index bc0a21957e33..f15ba7335336 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1740,6 +1740,7 @@ static void dcn20_update_dchubp_dpp(
 	if (pipe_ctx->update_flags.bits.scaler ||
 			plane_state->update_flags.bits.scaling_change ||
 			plane_state->update_flags.bits.position_change ||
+			plane_state->update_flags.bits.clip_size_change ||
 			plane_state->update_flags.bits.per_pixel_alpha_change ||
 			pipe_ctx->stream->update_flags.bits.scaling) {
 		pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->plane_state->per_pixel_alpha;
@@ -1752,6 +1753,7 @@ static void dcn20_update_dchubp_dpp(
 	if (pipe_ctx->update_flags.bits.viewport ||
 			(context == dc->current_state && plane_state->update_flags.bits.position_change) ||
 			(context == dc->current_state && plane_state->update_flags.bits.scaling_change) ||
+			(context == dc->current_state && plane_state->update_flags.bits.clip_size_change) ||
 			(context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling)) {
 
 		hubp->funcs->mem_program_viewport(
-- 
2.43.0

