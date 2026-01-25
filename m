Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9619CC88E76
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 08:09:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE0610E3DF;
	Mon, 26 Jan 2026 08:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FcZPlHDx";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D2010E371
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 18:39:38 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b8719f5a2b5so50779166b.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Jan 2026 10:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769366377; x=1769971177; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NIMAxiDT59usF3Prsk5bN4xvPD4Qaw8f/xUnPv/laJc=;
 b=FcZPlHDx9CXmto3YypC6oE5pamgA9OYnV+4zOygND8+ntk70rfKeH34gtNlZ85sc5I
 LgIGZkK7IDP8cMUDChHJCdfkM3mn5Lt7/yEAVfc7D6bqDV2+Vloz1OcPRWGITcDUimTF
 qD9XpqpOtOv4Iy11s5z+06l4FsLnp31LtR1U3Lj5qe8sy3cMelt5yxl4dj1vkuxMzu0v
 j9j4I7/Yh6ZX3PX2akAFJ8LQ6xdXsZEgGDOP95RJH+OWAlRXmKmd2Aeluqy24h+CkgML
 CQvY/H88D9aWkZoYUGk4K6FxUxQ+d14CQ3DgTliaPaLggU/7tHT7EcafXGjQ1pT5Q12w
 Q1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769366377; x=1769971177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NIMAxiDT59usF3Prsk5bN4xvPD4Qaw8f/xUnPv/laJc=;
 b=BOLLFwx1p07o2u89WD9MwsBSbPTAPkIRUs8RZrA6sACZHNBePhniQupDN0EEvpAPFq
 WwGqJNINTjuta6RGro13Ds+AunCgZi5i8NX6+ehV47BS8ZanI1IHlUf9Qn/8ADmAZMCH
 l+7ygjjd2wIAYmz4s2HBqFQEElpY0t/BcMbILdCaHvYSqaWrWzm20NCyQieCvHpxGAvb
 QUNTeagwbMAli4dI58AnExKAQcWN8XiSNB48B72uUYjz7Y5eBZwGdJz9apYjBs4QpnUo
 S3lxcXjt42Ckqw8GDkLpM4x13jnSwL3WbiNewH2m0phtn2fFCR5Lnnz3/jE57L5gOkg2
 0Seg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU683rv9/OCt+xX1MEoCZLe6uHAPRc1um6sFlxUPSbwpV3KOb8Wn5XF65zm39FlHgrOF/me/QrC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRR4ZyKXBnosO9LPUZd9uqZXwWh3XjQWaH9aRcEZJH5/IHZdJV
 4NLZjgjsok3bSBbsekBFyuKp6bZdKmcBm+wb8equjS50JS5ksqFUDgbz
X-Gm-Gg: AZuq6aLggCI7jO43A9L2HOj2wHA5oAc39OVaOVGCY+PZhmqab8bsItdVAIAZ0R/tvq3
 lb7wb1Jb83U13qQkFMi5f3wYmHnxtl7rivH07VDHtVqEVx0ssrD7eTRRnf8RLnEF6mCBb6EFX0F
 DXvglLFjY2HUpVuDCVc9zX1ZMyeIw39x8ZCbVOLkTy2k4KULrcHBWe/C0EF1AJcqNVtQdcEVOpn
 Gl+Od88TL/4Hy0VTPOUjLwF99GAvgtLbY2wtmotIsrwhifpiI8VYEg+pgsootuq+wqQKqp98P9z
 ZzbrflRsCmWEp2JW5yOSoZJrLTt12A2MTfuF7Y452p2dW0SNBJXDiXJBkXvwNQpNmXuTt1yPSlA
 C5cieLVSee3uz8MlWwAba6RwyTbGXtq1f43xsRpCbZX6gF6BZfH1dF5pxZNtlYfd9baub1k+6Oy
 0NCvVl4rXnDvnQhTS8Je5w0Kl3isTKU7s0DCxo2hmOoWQtpY133RlPnLaZlmND2P9g
X-Received: by 2002:a17:906:d54e:b0:b87:2099:9f6b with SMTP id
 a640c23a62f3a-b8d3fa9b5ccmr99201866b.3.1769366376862; 
 Sun, 25 Jan 2026 10:39:36 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b3dad3asm499133766b.12.2026.01.25.10.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 10:39:36 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v2 15/19] drm/amd/display: Trigger ALLM if it's available
Date: Sun, 25 Jan 2026 19:39:10 +0100
Message-ID: <20260125183914.459228-16-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260125183914.459228-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Jan 2026 08:09:08 +0000
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

[Why]
ALLM automatically puts TVs into low latency modes (gaming modes) which
we basically always want for PC use, be it gaming, or using precise
inputs like mice and keyboards.

[How]
Read the ALLM info from HDMI caps and use it to determine if ALLM should
be indicated in HDMI Forum vsif. Additionally, make sure VIC modes are
translated in case of ALLM active as VIC cannot be used in conjunction
with hf-vsif. I learned this the hard way...

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c          | 4 +++-
 .../gpu/drm/amd/display/modules/info_packet/info_packet.c  | 7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 848c267ef11e..4a7c9f810e35 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4504,6 +4504,7 @@ static void set_avi_info_frame(
 	unsigned int rid = pipe_ctx->stream->timing.rid;
 	unsigned int fr_ind = pipe_ctx->stream->timing.fr_index;
 	enum dc_timing_3d_format format;
+	bool allm;
 
 	if (stream->avi_infopacket.valid) {
 		*info_packet = stream->avi_infopacket;
@@ -4658,8 +4659,9 @@ static void set_avi_info_frame(
 	if (pipe_ctx->stream->timing.hdmi_vic != 0)
 		vic = 0;
 	format = stream->timing.timing_3d_format;
+	allm = stream->link->local_sink->edid_caps.allm;
 	/*todo, add 3DStereo support*/
-	if (format != TIMING_3D_FORMAT_NONE) {
+	if ((format != TIMING_3D_FORMAT_NONE) || allm) {
 		// Based on HDMI specs hdmi vic needs to be converted to cea vic when 3D is enabled
 		switch (pipe_ctx->stream->timing.hdmi_vic) {
 		case 1:
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 1a1ddcdb4362..0db2db7a197f 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -540,9 +540,10 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 
 		info_packet->valid = false;
 
-		format = stream->timing.timing_3d_format;
-		if (stream->view_format == VIEW_3D_FORMAT_NONE)
-			format = TIMING_3D_FORMAT_NONE;
+		allm = stream->link->local_sink->edid_caps.allm;
+		format = stream->view_format == VIEW_3D_FORMAT_NONE ?
+			 TIMING_3D_FORMAT_NONE :
+			 stream->timing.timing_3d_format;
 		stereo = format != TIMING_3D_FORMAT_NONE;
 		hdmi_vic_mode = is_hdmi_vic_mode(stream);
 
-- 
2.52.0

