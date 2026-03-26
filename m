Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FA2109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A656C10E91E;
	Thu, 26 Mar 2026 03:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qeq96uV7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5271610E918
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJjR1pbrDztnbjLqTyeYTeOcv3UtN4DDE1awSWLllsoKHPuJGPt8gRSkcjrrjEEzWxHCuUJLiYSUXn6rhCl6x5+nbPDGDYuW1HBLtktRjs3sT70zBXBSZeDUExxzOB2SAOEEdAPkHjD8OacUOf0zgFFgKtBFhDUa1xCP9ZmE+HOwakt8oVyDX0K8fBTzrTKhSAqECd2iaXOjIlcCf0eZZWvVvuqGVLE9n+9ps46dTn5m+PZDVZ13Oi6B23z22khlsjYRFn8FRD4Xzi31Hgzc2R5b1pwb5tswtww2oBf5Rn+Wtgi9FT6UQuHmNkftH0/GDzqRaVpt2Qg9mOgn66dPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obOTOCLcJIihvCz7rm4LBX8dSHT+W6OArrBXPIIvqrs=;
 b=L44Q7mLX76NRE8gXGm5m9d8qn36owLmiSxYsxgq++qPbXG2k1tB6Je9xKALSGOG/gEKT30nlSH4C6ZeCSsobQfnT1ePhpYEy8cEpnptb5t8sqCbqB1Rk41KwspqbaUfX897TuQTpxuJYLpzWQa4d6fQ4R/pdhDMX4T3fT2GosCn+I/NPnA6s61EG3koH6GLvCYZGUegxHhzM6y5uJJelAiLnfUYYxat2DIayRsWg+lSWME7ciB4vfsNkfXsWOXlDPWFC8bxYZZ5Gm4DrNlFCzxbXxC1IMUqbhPfE6d6gj6BxscMDUd8Cj9N1WfgrOmjTanjuuNDHk0ROA8x+iT+i3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obOTOCLcJIihvCz7rm4LBX8dSHT+W6OArrBXPIIvqrs=;
 b=Qeq96uV7LmSCrVB5IqwbRZCnYYlaH8cpH7HYiynvfFGn1zddQDhit9zrX7mV3P8x57dQjcRzgHa3oO2QunB4suz+iGgG3i/IXQpw1lc45FZG0njV80TcQ3z4YeSBYTXALk0CwAX3Q3HS1tBS60SkAVOPzwIhmJdl9LXaxzcFcfA=
Received: from BL0PR0102CA0032.prod.exchangelabs.com (2603:10b6:207:18::45) by
 DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.6; Thu, 26 Mar 2026 03:00:44 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::a) by BL0PR0102CA0032.outlook.office365.com
 (2603:10b6:207:18::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:00:44 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:00:40 -0500
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
Subject: [PATCH v2 05/30] drm/amd/display: Avoid turning off the PHY when OTG
 is running for DVI
Date: Thu, 26 Mar 2026 10:56:56 +0800
Message-ID: <20260326030153.406612-6-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d25bfd-657e-4399-9d1a-08de8ae3df8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V3ccWjZHeC5cYamlaRL6UeUXuWgUxkOrz6TFEFyhVtIj6DSKc7cw+9Fwlu31eyyA3V2Yfuhh4hZdTDPRFpPCf9t0iHtRIRRDXdTCVV+rMDjxpoAH6yBY4FpQogEvJOsLg/h/JnFQB01s2xMIMsyznzjUqo703ks9lUwbQB04xL4jFJ+TI1Lt+OBZbVt1CSCjNehaLiiZnkz7EEZCzmPBR96lfV68bgYKUb5bNAxRteamAfiJYhzHv/BbTVnvIHUPdmUYNil/UgCDrPTeW+KPJsg04f67RDaG31QWt4h1P0emCL/ipwIx6XaphhWWLLrb1SeuOCQ5AQbIabnqIf5BNPFhzCYxR5uHZ8qd1h1RmJ4BIpla4npFKJLpdKwJP+ESBdPOZW7fO5XT09l2XVXLQ5vx++Md51WvipBhqdsUpnVXqJBoUEOOaKCTIrusANJ3e1jR7MXnEefpAzsHg51CE4ojDX1gZV0a2PlaAkc1Lph8U+n9BC6DNaenDk2oscWLvjhll9i1xeVjl4GY1cNaGEOdKaK9ZJFMvdSrNxKux53N0va7Vw6lhhXh+s+GswPeMwFD5k8fAtXfSbLPMHuSWhQ+wpzyqDrK2lIRGS4PJcpYUaVkE2UkNZ8N+TKwPAqVyoN1eTRDsmYuMyKFo6EfDKEpwiY71LJIMW+bEE+0hzSF8NaeEAcBpzuzyBTzqjfFguIFqpfps3AMTJZJR/odL0QlbswfZ9OYQiF/Za9zyZxUFKcv2pIrWM0zLbfCuoWU8EqquYmGbkPWeXWJPIovwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dfdufA9MBikDofxWTCzMTTMxr2SzXKNtS/czUz2YklxQXYkjvFNqsq9oxmK6OoHmSDeA/+M6MsJqZGUbY7si0e1RHQzLuJ+5vV/qCupZ7YXdS4as4+ZK/pxqTycTi5Z67ORy7W7kBzdi3efOukKQNPDo+/N7zWTAxgiAT4QitcKfCWP+ph3ytIIbHCkzq0smXqG509SCXM2bLGTuyYcydw7qAON2mZ7FZ2klbTLsLRLd9KiYidHh0cTcnsSBT+o91zUIKSe3RQP3Uv8yZn2iyRSOiXHC/0qQGfoti9w99DXjF2o0PUqJe8zFcX66s+GlpLrz7lIq+aFJpSQf+qTiJftB70Z8WSp33yYodLHbdV5vbJ+v0kGM0MmlxoRCu5fzbGZnAKkluib+T1UDJPwdtBlO5rmaDC1M3P2hOuPs+kZry2MojZiVxK8cBiInVJIo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:00:44.5395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d25bfd-657e-4399-9d1a-08de8ae3df8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
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

