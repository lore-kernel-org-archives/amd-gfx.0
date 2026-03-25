Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83300FEA817
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2282310E797;
	Wed, 25 Mar 2026 07:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3sXzoDF";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250A810E797
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhGWrZIrxntI9A5YoGtXY/TRQJDZqk+1CdSMQFfuT3UO3AQV/WZmYM6VrDGiudO64EF07QJBYow/VS88y/ArwknRbhGvOHwVLz/RXSM/gMh1d0JurJmztkhRT0CzN+kjn0Fe+T8hBkMDTHtKdpodVuktHjZEYkOBzLgs0auMOtzLcT0ASXS2RPpiTfOx4WJ+zD1CvUr05fagJacvmed/5zGU4ODNzo1+ZES1m8XJE4u5zX1Qj27riaHbNoTRolbh8c6HssrO1zOCJmky9WXJYND21YpXumgB4Z9YkYV6YqIowXQi76FVyZ78Gv38GxW8f2W4jiFooxrmK43d+lWeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obOTOCLcJIihvCz7rm4LBX8dSHT+W6OArrBXPIIvqrs=;
 b=fw9siVaJEcr22Q+UZUMORCONph2OyA7h+kCUvvnMX8sk+AgEy5ZGupwW6DsJlwpHV2TIt0SI5/pBcM/3DSiHB0i+gcogLmapKdXaIecDDoGnanTmMEmbezqJuYKQj55MTpgd9NhAeOWjZGYj5p3y7x7dQvcYEB8GTdyHd1J7sNuMifG3Az78mYE1BKV37HOrcxIw3wEEC12nAHeoq362gAQNv+rBAggSblsOhPPQX9wNhYXbinagKe+yDgVcJUEM5CzmCoxDWJ/pqSEQepAgdUbHVuFwOdIAoLaOkxDCiqMnL+mK5fiEGo/egR8biScFC4QRsBUFkpg72qKKR2ZGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obOTOCLcJIihvCz7rm4LBX8dSHT+W6OArrBXPIIvqrs=;
 b=D3sXzoDFcxtLNOTmr0hXC0HyiBw/wfDAUUyynAE65n9Ih6ZY2ZVO3PO8EPaiQ0HNxOq9DrvzXRjM4t7SyxCemwsKFbqWCw2EyxyhNBi5ti8QkXEBe1PuYJE/fMa4duKWu8m+PhXfkDT6wkzVCdNKHe3OolZxbCiRrBg/GSg/574=
Received: from MN2PR15CA0043.namprd15.prod.outlook.com (2603:10b6:208:237::12)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:08:52 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::4) by MN2PR15CA0043.outlook.office365.com
 (2603:10b6:208:237::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:08:50 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:08:46 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 04/29] drm/amd/display: Avoid turning off the PHY when OTG is
 running for DVI
Date: Wed, 25 Mar 2026 15:06:10 +0800
Message-ID: <20260325071003.4022594-5-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bca4211-c29a-4f5c-d8ab-08de8a3d5dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +7CpQGyKWpW7BN5jfTssLQ8urvBWZEvX/f+6L2Reqf74SpBzwXqNMXPUxz8Jceb4NP5smufR8U0BM+Ul28SaWX4Nsa2Xc3cFhKuEQd5eDl81x4YLffu2Pf+hIeIs1XNsBEU8sXLjr4up8oCNiJg6xh+Bcd8SMv3i3xw3jz52u4WtBefoNBis47SCTJK73oZj6sS1Doi6QWFzvK5Fxc4TLW8y4pbiRgkmJOkLdC2u7iqcUn8A7hi5FBGTyY2awxMeWf0VZb9LHYXYr8wXC23fZpA5hxwKBUyKjvgGj3h5fh8IjTtkT0IXP93KQTC10h5PM0Qx0YdoaJSYMmaH/lA/PlNiQW+BdmjGFZ+GP5/Kbws7NJ4P8k50YFcMr5c66UpCb98om2cgiS6Sfn6/pLIwzuHNrPlEnP13UYT/arQ0tMZhdubAnnVwUc9wl2AZzPxKHWyc1SEzZRI+uFxa1NzpiP665UF9mJsEPG9Ez3mMnwZ02rmP8sr5crFj/uM4yU7s8ZgB0uDivgfQ/OnGFE1XXAU7/c9tDvUEvTvCOeUJKpOVLE16kdMyQmKkUiQM4BdFxJGpyViBJYK+PiFjgmSPRTfey6PYKXkQfyM+I1gOZXCL/mVXwNRYEyjsrLmcbRfrSrEmwR2uqiTQngEDSzlTwOJSO39Vaz+mRXercw7rnVDeqWCNqaZ8EcM6lVY1vruVz7wWb0CFtc1XWKeBuRswJI532wc87o/p76yWLHU+CsAHFyWoypVjQJNTMX3kbYazCzdJPZRx1axwUiFtSujNvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RXOA9unw//flkZmmqIcdO4JrFHkGPhPQqm3A9vt1B0S7iWO17SlGRNX0tTgKaEib9nUGIYUiNB6ipyrPfhvHIt5QMYiKG3Jd9gFza3Hpn5LytvryKI+D+DTAYLhy4uUcGLj3Am9WG0uShM0c2z+4dHH2ODmNr7SYyqizZXNp8MaTIzx1kv6xFND16Ib0jk+LmuIubfcDOcIJotTaEdtLFsrpQ8GIjuK7Smyzpw/zooScuWirDVcxO1QszqNJ8gTRcwy+EdWKJY3azgRp7zZLrHHjCnXS6m8eoqgS7Hr1l5bdeGQaGavrgivpNmEgoB/wn6hAXFJx1iszKF1lMj8Z8cyOKlRRCN7as8iSrMdBzO35kvkeT2t3Ilge6GNDC3l/VHm+apSQ0Srilx9pVOGM+Jo7NuToTNxlO+KrqcrGFaLRFpMfwno1/y7lJjSW3gkE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:08:50.5094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bca4211-c29a-4f5c-d8ab-08de8a3d5dda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The OTG's virtual pixel clock source for DVI comes from the PHY.

If the signal type is DVI then the OTG can become stuck on pre DCN401
ASIC when DPMS off occurs because the OTG remains running but the
PHY transmitter is disabled.

[How]
There exists logic to keep track of the OTG running refcount on the
link to determine if the link needs to go to PLL_EN instead of TX_EN
but the logic only checks for HDMI TMDS on older ASIC.

DVI is still a TMDS signal type so the constraint should also apply.

Replace the checks for dc_is_hdmi_tmds_signal with dc_is_tmds_signal to
cover both HDMI and DVI for the symclk refcount workaround.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 4 ++--
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 8a17cc036399..d2025779d036 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1568,7 +1568,7 @@ static enum dc_status dce110_enable_stream_timing(
 			return DC_ERROR_UNEXPECTED;
 		}
 
-		if (dc_is_hdmi_tmds_signal(stream->signal)) {
+		if (dc_is_tmds_signal(stream->signal)) {
 			stream->link->phy_state.symclk_ref_cnts.otg = 1;
 			if (stream->link->phy_state.symclk_state == SYMCLK_OFF_TX_OFF)
 				stream->link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
@@ -2418,7 +2418,7 @@ static void dce110_reset_hw_ctx_wrap(
 				BREAK_TO_DEBUGGER();
 			}
 			pipe_ctx_old->stream_res.tg->funcs->disable_crtc(pipe_ctx_old->stream_res.tg);
-			if (dc_is_hdmi_tmds_signal(pipe_ctx_old->stream->signal))
+			if (dc_is_tmds_signal(pipe_ctx_old->stream->signal))
 				pipe_ctx_old->stream->link->phy_state.symclk_ref_cnts.otg = 0;
 			pipe_ctx_old->plane_res.mi->funcs->free_mem_input(
 					pipe_ctx_old->plane_res.mi, dc->current_state->stream_count);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 307e8f8060e6..a673ab0803a8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -893,7 +893,7 @@ enum dc_status dcn20_enable_stream_timing(
 		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 	}
 
-	if (dc_is_hdmi_tmds_signal(stream->signal)) {
+	if (dc_is_tmds_signal(stream->signal)) {
 		stream->link->phy_state.symclk_ref_cnts.otg = 1;
 		if (stream->link->phy_state.symclk_state == SYMCLK_OFF_TX_OFF)
 			stream->link->phy_state.symclk_state = SYMCLK_ON_TX_OFF;
@@ -2856,7 +2856,7 @@ void dcn20_reset_back_end_for_pipe(
 		 * the case where the same symclk is shared across multiple otg
 		 * instances
 		 */
-		if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+		if (dc_is_tmds_signal(pipe_ctx->stream->signal))
 			link->phy_state.symclk_ref_cnts.otg = 0;
 		if (link->phy_state.symclk_state == SYMCLK_ON_TX_OFF) {
 			link_hwss->disable_link_output(link,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 94f63fd54e3e..1fba44aecdd3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -548,7 +548,7 @@ static void dcn31_reset_back_end_for_pipe(
 	 * the case where the same symclk is shared across multiple otg
 	 * instances
 	 */
-	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+	if (dc_is_tmds_signal(pipe_ctx->stream->signal))
 		link->phy_state.symclk_ref_cnts.otg = 0;
 
 	if (pipe_ctx->top_pipe == NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index a72284c3fa1c..ca611b3c22d3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1938,7 +1938,7 @@ void dcn401_reset_back_end_for_pipe(
 		 * the case where the same symclk is shared across multiple otg
 		 * instances
 		 */
-		if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+		if (dc_is_tmds_signal(pipe_ctx->stream->signal))
 			link->phy_state.symclk_ref_cnts.otg = 0;
 		if (link->phy_state.symclk_state == SYMCLK_ON_TX_OFF) {
 			link_hwss->disable_link_output(link,
-- 
2.43.0

