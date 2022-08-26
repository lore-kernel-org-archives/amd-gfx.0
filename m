Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBE6ECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42C2C10EB82;
	Sat, 27 Aug 2022 02:52:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD3510EB82
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrkmnNd0ALGSXgrLbDC8U0dRLWygPRE2bnEQgtjXGUyt7UQr0gyNUtJjQSyTxa0oPcbqhHLI4EjXWEuY8v1Oum5/CeJrHu5F8A7SxhR1QE8GTNsykOphSYxagJdThIMIxMiCGbjkN3+FkGNC39iR/HL97v1iL/NmK/unCjF005ke6JGhTTN2AWZnoPU/S1r6TkyN1887kdFg3GAia0FAD23bV4cxn3uX2mPFOqQR97JwS5qbh/RJm2KteAcVqwiLA7jqt4sNFAhFyhO8kXCZrBxXoNX30yGl9gWyGpxNFnTz3hQCDtC456uGMsHadSbCdjn5TA7vDkCCXcPGnAbHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09d1pRL8xtoDb5TPIcW026qeucKRQrqR7X21elC9PR0=;
 b=JulLAgGy8zmGE0GD3PrfWx/i9Ejj8VsAb7prtoCQop8OaxjwReJClDVVMNZ3dMHN3RrrqPzUlEbOG7q0B0PdDhEJaqjYuF2UaStvAQkwDDeV5wfzzeozU/wi3dlUQ4mbbkhDDSinbigqmx+TN2VCRDRX+qsgF85Y4qZ5ib9dKZD4zRSoFC4csIAKhwO0U6DiUM7J1enRzx3V8bydbR/9K9ASKChJB7JQJxhfW8Yso8jxMSFlTepMG8GS4J+AVfczvbbrep+FophjWtCBuCS3bdRGBkpWNgMYJ6/fySVYkiyZejZ5UUVwQUL5UpWevveQWuvRebWfWZNqr6hSdPxidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09d1pRL8xtoDb5TPIcW026qeucKRQrqR7X21elC9PR0=;
 b=VWfLxv+QTzv+xXE3oC+RoFQh8SWytqPTyFf6mJ3Sj5INLsH2CnCquPtpt5AFP2TxkhpvRvCAezWvPeIEo+nRhAjt6/+v24VFhqLLTyJI6NsQSOjHlxYlg+qH4PANfyGYTYkM6bTUfb3Cov62Vz2TgougHfe2irz/30K8Yrlyiso=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Sat, 27 Aug 2022 02:52:21 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::e5) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.3 via Frontend
 Transport; Sat, 27 Aug 2022 02:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 02:52:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:52:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 19:52:20 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:52:10
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/33] drm/amd/display: Fix primary EDP link detection
Date: Sat, 27 Aug 2022 06:50:44 +0800
Message-ID: <20220826225053.1435588-25-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d377770-420c-4f68-25fb-08da87d72984
X-MS-TrafficTypeDiagnostic: CH0PR12MB5124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ibsmua6z3/8ht38MnXW1OmK17VZHEG7ZLO60LHFlalL43VTZck0aQL66hkI14rPhh1R273nQc+7xtgKKxqOXWUT6Yn19qaH7cZP3X2EOJM/fWPN4/5faAbzLVyNpLgErIUn8F8GmW6U6g1W524vKP0Ea+l6cTXBV9dXFF93u0PIa22MXyFHXZbPaepJNRobM07mmGMd/FbwbIgEyAdbwz3Hv6sPEujwVAeOjjlIyF/GVWqxEORo6l0YcsT93u6t5MbwmAebFVpOJW5/piXhWdiIufk/4zZ0Jb7jpBdkEZdfNLeQ6c0Xem1ZOp2JfYqLnJK+ojkqNG+z14WWppNHhUO96p44GjKk9mK85FT36iDuxTI8hz1Ht1fQibcdH76lOHSn9eti09ykfAwoz9C2IHblwfQe/eXu3OY1+NIxRX/NJu5LhCd7gazejbzPvtNsoM+/9w8XDtxmm9moD/h2pneNVA1NkTn7YqlsUN8rWkhvAStkX7L3nD4zzxzXLL/Q0VHmiykokYkMU3zo7Vefal7IGlau9vu49SaWiWFW5E9tUV+kbZ2xFApPW2GYcfitJ/AFhjHPxajRv79H4SyC11Cu87DspAKxLpojYeVOmwsF+reY/SLSdzABJHBDBrZ8zJhg5PJatV/y4cJOkx1X+ozdnLNPeS95I26u5esxqLzhxdbQpE1OzTSYsjIBuJHjG24eFwgmeS6uVM0KFL/InFWnNLIXeWES+JDJjzDgbA8sqyD3t4GIwhCSYQpJZFVHoSHjGVvlPYpuD13X9mXXIHFuQROTaKj/xuYbeXdbnqPCxigkiIdkCcUcCVbyhWg6mF0iARLMulSPG4+B2Ur8oXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(6666004)(26005)(7696005)(41300700001)(426003)(47076005)(186003)(336012)(83380400001)(1076003)(2616005)(2906002)(8936002)(5660300002)(82310400005)(40460700003)(40480700001)(6916009)(54906003)(316002)(4326008)(8676002)(70206006)(70586007)(478600001)(356005)(81166007)(82740400003)(36756003)(86362001)(36860700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:52:20.9653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d377770-420c-4f68-25fb-08da87d72984
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Jayendran Ramani <Jayendran.Ramani@amd.com>, Iswara
 Nagulendran <Iswara.Nagulendran@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Harry Vanzylldejong <Harry.Vanzylldejong@amd.com>, wayne.lin@amd.com,
 sregolui <sregolui@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Iswara Nagulendran <iswara.nagulendran@amd.com>

[HOW&WHY]
EDP link detection must
be updated to support a primary EDP with a
link index of greater than 0.

* SWDEV-342936 - dc: DSC bringup for SAG 1.5

[WHY]
SmartAccess Graphics 1.5 (a.k.a SmartMux 1.5)
requires seamless switching between GPUs
with DSC enabled.

[HOW]
Moved DSC programming to
apply_single_control_ctx_to_hw before the stream
enablement logic to ensure the CRC checker provides valid
values for non-black frames
allowing the system to come out of forced PSR on
d2i.

Added additional logic to both generate a black
frame through setVisibility calls and keep track
of the CRCs values for this black frame when
coming out of forced PSR.

Updating logic for DalRegKey_DisableDSC to disable
DSC on EDP and all ports for systems.

[CLEANED]
dc: Moved DSC programming to before stream enablement

[HOW&WHY]
Moved DSC programming to
apply_single_control_ctx_to_hw before the stream
enablement logic.

Co-authored-by: sregolui <sregolui@amd.com>
Reviewed-by: Jayendran Ramani <Jayendran.Ramani@amd.com>
Reviewed-by: Harry Vanzylldejong <Harry.Vanzylldejong@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: sregolui <sregolui@amd.com>
Signed-off-by: Iswara Nagulendran <Iswara.Nagulendran@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c       | 12 ------------
 .../drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 74db87f3dc6f..38fa63d43ad9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4303,18 +4303,6 @@ void core_link_enable_stream(
 		if (pipe_ctx->stream->dpms_off)
 			return;
 
-		/* Have to setup DSC before DIG FE and BE are connected (which happens before the
-		 * link training). This is to make sure the bandwidth sent to DIG BE won't be
-		 * bigger than what the link and/or DIG BE can handle. VBID[6]/CompressedStream_flag
-		 * will be automatically set at a later time when the video is enabled
-		 * (DP_VID_STREAM_EN = 1).
-		 */
-		if (pipe_ctx->stream->timing.flags.DSC) {
-			if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
-					dc_is_virtual_signal(pipe_ctx->stream->signal))
-				dp_set_dsc_enable(pipe_ctx, true);
-		}
-
 		status = enable_link(state, pipe_ctx);
 
 		if (status != DC_OK) {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 801206aed63a..fe346e96c2d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1577,6 +1577,19 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
 		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_OTG);
 
+	/* Have to setup DSC before DIG FE and BE are connected (which happens before the
+	 * link training). This is to make sure the bandwidth sent to DIG BE won't be
+	 * bigger than what the link and/or DIG BE can handle. VBID[6]/CompressedStream_flag
+	 * will be automatically set at a later time when the video is enabled
+	 * (DP_VID_STREAM_EN = 1).
+	 */
+	if (pipe_ctx->stream->timing.flags.DSC) {
+		if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
+			dc_is_virtual_signal(pipe_ctx->stream->signal))
+			dp_set_dsc_enable(pipe_ctx, true);
+
+	}
+
 	if (!stream->dpms_off) {
 		if (dc->hwss.update_phy_state)
 			dc->hwss.update_phy_state(context, pipe_ctx, TX_ON_SYMCLK_ON);
-- 
2.25.1

