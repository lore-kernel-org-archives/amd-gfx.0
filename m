Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86764CA6019
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9DA810E3C8;
	Mon, 19 Jan 2026 08:18:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kogE3Y/0";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED53410E309
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:12:12 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-655b5094119so517686a12.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785131; x=1769389931; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NIMAxiDT59usF3Prsk5bN4xvPD4Qaw8f/xUnPv/laJc=;
 b=kogE3Y/0e2gwBPsHNj8YjQIBQzSDgNp3zXjlFLTMEqcGEXfrWn2y9f42paaF8MpOwg
 x+g7bCuIrP28xTQsrTHblPd4YOIXdHyG8nsaPvAMxrjbUdaAdIdmcT902iCREQejgeFd
 AhZ/Zbu8BVgHW2EFOVYiHTal8MEPV1kl9xC8ukoCf7kdsjdknK/BaNxOycg21jLPKCNX
 d34GF0ufDh5Z2QgjVKXHXOZjc/0bbnz5XbrXDvMulEypEL3HMfu6rLFxEANkIxsMyf47
 Q6o4M9QICcXEI8GbB5StYUhtmhVYLSFA6yORphHzqDhp2Nj3m4LEWTlzsknLAbVxOq7d
 DZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785131; x=1769389931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NIMAxiDT59usF3Prsk5bN4xvPD4Qaw8f/xUnPv/laJc=;
 b=mJtHAKR7AoxlFnKqSdT+iKFa7Ww1UtpEha3/Hv+rOjc+bvnx5KvMUqby6nDiND5AgC
 nS6zfIw5qkNrGhKvLDhAPPZI3jSIuN35MmBesrDmWxr3Dyb2LEQ5BQXNKjk8liPfuoPy
 dPIYEDKGaZrOPK5rj+EjyT948MtOnfcoV6bRb17MukKAYwoJP1ejwXJ7/6X2oDMRbSe9
 3zsKzczJhZFZabfFA1/660SbqZlfyGenTq8q/hhQ/4toB6L/tj76IQXhpvGCdhG62XO/
 jJyzUSUZix80yEdhhmcEKio1VaVkp/fPTeIWaKpvIt3c82/dntZVvUK7HdhW98ESqajz
 96uQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1IkYC4I62Ty77OspmBTqpEkv2hS8K0WMquE77fGdWWvfLrncRckCu/EPVV50a9fYR18xZTvwG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNUYeNGlxuOCVHAGW1OMA7eeM63NJrMf0wvCrG4iDpFXSccOF4
 mAF9CHdFsMsuHaT+Imtx2mihyQsLRI2GmRUR1wCZH48ZNmHCA6sPP3bV
X-Gm-Gg: AY/fxX5KWxMVvcvs9y43ZGI5zMa5DGsXjx5uzHi8af6r6ydQakL0wOl0cT2IUTaLiFb
 HmQ/ukFAOPqLuaagk1egjBmbQOPuQw4/wdxiuICHLkAI+vIFKEuVeqcqgK9LPuPZGWbIkJ+SThE
 /jrN5ytQZlLkzmatNqrGXqh6qdr/0dfczOTlUgDqaWHmn6qxKVTS9/QOp7FijVbEh7aeAV1ih3w
 M+NIkEeY6D4mMt/to2/p0qM47kZj+796zreHlo4faEGANGdrl7EyEzdueT5nl/oBsbp96Q9JEQO
 HV3b0bgf7S8AKjeWgkNj4hrjh3RPLUuUbJ79Rw3J3nwsm6DP/WjSr4KkHCJI2v39oJ5AH1BmiE1
 sQOdgTe2XGD7aQr1Gt8dsnK6osbRe4cGOsnv7YESOPcKWRBh7kQ4Jr2knl1UEiBJXFC8dM/TP1q
 hS7T8wJZCHr0fCNweu0tRADxwsR3bQZ0Jw8DqLzXGgp7GAUn5GzT7k90t2GbozoAx8
X-Received: by 2002:a05:6402:348d:b0:64c:9e19:982d with SMTP id
 4fb4d7f45d1cf-654523cc85bmr4269853a12.1.1768785131391; 
 Sun, 18 Jan 2026 17:12:11 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:12:10 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 15/17] drm/amd/display: Trigger ALLM if it's available
Date: Mon, 19 Jan 2026 02:11:44 +0100
Message-ID: <20260119011146.62302-16-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Jan 2026 08:18:28 +0000
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

