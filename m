Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C5C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0322623108
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAORXy8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0322623108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9169A6E3B0;
	Mon, 24 Aug 2020 16:38:14 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5256E2F8;
 Mon, 24 Aug 2020 16:38:13 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0F0D322EBD;
 Mon, 24 Aug 2020 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598287093;
 bh=BEll8sFvUbNOHlfpKXOfgKFukcive1Uh8g55XCOmxSw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PAORXy8fhc+NEMJ5jJtKXw4mto5o6b4yD+vYxLcZV8TFJMZYyF75Gjh1SIabpYdYl
 lMWdZFNhCVRUk4n0IqPqBpBZ6dOszAh2OqQ1gWF0DZgssnKkU2IE0F3TFWExBH/5P/
 XUpmGrHSC9L5232Juyl7L17RL05R1NbqkcAZHCVE=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 16/38] drm/amd/display: Switch to immediate mode
 for updating infopackets
Date: Mon, 24 Aug 2020 12:37:28 -0400
Message-Id: <20200824163751.606577-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163751.606577-1-sashal@kernel.org>
References: <20200824163751.606577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Ashley Thomas <Ashley.Thomas2@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[ Upstream commit abba907c7a20032c2d504fd5afe3af7d440a09d0 ]

[Why]
Using FRAME_UPDATE will result in infopacket to be potentially updated
one frame late.
In commit stream scenarios for previously active stream, some stale
infopacket data from previous config might be erroneously sent out on
initial frame after stream is re-enabled.

[How]
Switch to using IMMEDIATE_UPDATE mode

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Ashley Thomas <Ashley.Thomas2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c  | 16 ++++++++--------
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h  | 14 ++++++++++++++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 9aa258f3550b6..ddf66046616d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -121,35 +121,35 @@ void enc1_update_generic_info_packet(
 	switch (packet_index) {
 	case 0:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC0_FRAME_UPDATE, 1);
+				AFMT_GENERIC0_IMMEDIATE_UPDATE, 1);
 		break;
 	case 1:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC1_FRAME_UPDATE, 1);
+				AFMT_GENERIC1_IMMEDIATE_UPDATE, 1);
 		break;
 	case 2:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC2_FRAME_UPDATE, 1);
+				AFMT_GENERIC2_IMMEDIATE_UPDATE, 1);
 		break;
 	case 3:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC3_FRAME_UPDATE, 1);
+				AFMT_GENERIC3_IMMEDIATE_UPDATE, 1);
 		break;
 	case 4:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC4_FRAME_UPDATE, 1);
+				AFMT_GENERIC4_IMMEDIATE_UPDATE, 1);
 		break;
 	case 5:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC5_FRAME_UPDATE, 1);
+				AFMT_GENERIC5_IMMEDIATE_UPDATE, 1);
 		break;
 	case 6:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC6_FRAME_UPDATE, 1);
+				AFMT_GENERIC6_IMMEDIATE_UPDATE, 1);
 		break;
 	case 7:
 		REG_UPDATE(AFMT_VBI_PACKET_CONTROL1,
-				AFMT_GENERIC7_FRAME_UPDATE, 1);
+				AFMT_GENERIC7_IMMEDIATE_UPDATE, 1);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index a512cbea00d17..b9656614950e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -275,7 +275,14 @@ struct dcn10_stream_enc_registers {
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC2_FRAME_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC3_FRAME_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC4_FRAME_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC0_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC1_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC2_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC3_IMMEDIATE_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC4_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC5_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC6_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC7_IMMEDIATE_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC5_FRAME_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC6_FRAME_UPDATE, mask_sh),\
 	SE_SF(DIG0_AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC7_FRAME_UPDATE, mask_sh),\
@@ -339,7 +346,14 @@ struct dcn10_stream_enc_registers {
 	type AFMT_GENERIC2_FRAME_UPDATE;\
 	type AFMT_GENERIC3_FRAME_UPDATE;\
 	type AFMT_GENERIC4_FRAME_UPDATE;\
+	type AFMT_GENERIC0_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC1_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC2_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC3_IMMEDIATE_UPDATE;\
 	type AFMT_GENERIC4_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC5_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC6_IMMEDIATE_UPDATE;\
+	type AFMT_GENERIC7_IMMEDIATE_UPDATE;\
 	type AFMT_GENERIC5_FRAME_UPDATE;\
 	type AFMT_GENERIC6_FRAME_UPDATE;\
 	type AFMT_GENERIC7_FRAME_UPDATE;\
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
