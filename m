Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609F6E83EFA
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F8F10E524;
	Wed,  4 Feb 2026 08:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KGbdZvi+";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D3610E760
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:52 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b8862767cf2so70989766b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770145011; x=1770749811; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHIURFG0mejGoKIh/9LYz0d07pIYeDt6QmhYawdCAFI=;
 b=KGbdZvi+gCFadZXJ3C4sQsa+CpfKWZigKvAGTQ7to/yM4ny4VAIinLp3LemoH8rRnt
 +aL5ZFnSJ9hVbDNAkGjvsnl/3cow3tMVzIVeqnvbEL0vwr2g5Bg3f5U7EbOAO8Ztgxzt
 h0Zg1cYV376zzOyTHLMI4Nzkt2FDYmLyartIaF6u2ZJLkqSimat8Mwdb2/eszp1Cbv+m
 bTJBZ75OmHXtXQAidnvhtWZLbdR9hKpp/GncYDPENxTK1TGDoTHhdWIB4/GjBtdKaPcy
 1ktoEbNDWzvE+TqoK87clODGs1c+tIvMK8BnyRoQgHuo30aCj7teNSw29g3zrM1rGr/e
 1dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770145011; x=1770749811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hHIURFG0mejGoKIh/9LYz0d07pIYeDt6QmhYawdCAFI=;
 b=lZAqnI/fmff+2qHFNGE6P/hiS210pxANTmPQ13J6YaBnMUAj+Nr2bo3W5hbtDDqAo4
 hMp7ts+g8agklpzGVXarLypp8znHytTJkxEC/RQFfoDV7IUW5HHw+cL48+MFB6q+LDFH
 WnzY+Zr8V9FHdRNzuvB9IT+DfkX/RyY/nRMBOkzSpkGtWnIEvcHc60l0MC+VP35i3ZZG
 e16jN1tih9E1iJC0xDEZxmeBynks4PglPwQTsfv2sX/KZTjagJnk53JNscAo69IDnBs6
 ZVO14kKa4ilm9Me+zGYcraHchiH1uAawWuVFge5SZ3VPWWMj3acViGGgMrRR7jYRQGLA
 DyWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9WJZYbEqN8P/UJTCN6bi+rViagDTS7nFkZ3LpspE8M6fNSgbfUVCzyI1LZH7QZDb5LSshNVZ3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDsUl2fDSwPw6YQCbCgQPWaqZQBySn+ha1xYHkszQr+G230DPu
 XCz6tD4txGpUxRwyuT9Kmr19sLUusd63ln/ZlTpwoNpE53q4AdsXKAFj
X-Gm-Gg: AZuq6aKLQAkGoOdJTYIMGU4oZhBDdZS1g4GHn4nDAwoxjJ9XNQ/7Fgv6guQwXxmG1jH
 aHNSWTo56bpIMCWzGE0XoEgcNgDUxJrndwlT1Et+sgQUmpanPUeSyuHXXo1coo5oHCXCSBdVd2G
 wTYv1SuvGY9gnYDpKTcYX6739nYPto4PkUGsZbixQMbfc6zTDNKDNFOtGaS/mW5wvHbbaOWU0o1
 Jrza0MzZqn934XusPohiQePSxBNBH2S9KyjSg6D8PfgGlZL/7zYv06xlTglYWF7s+UbAgF7g9Ol
 DT2JwBoKnQi3Jw8/4DjziFSirnoCJf1Ry5/kau8Qb0IKWN0sKjpxr7h5PPo5arQNfDmEUsarUn2
 lBfhSMVM2hoCzuuKtZSdVgPTqX4i0tiD9ZMk1qXt6xnKlrwYebdJbd9sXCn5N/6rKq7fHzh7jpl
 lUyVlw9S1+k73HweXesigNcgV0D2nvJuNi3z8+kofRtYf0CEcCbxO4hoH/GFbTzl5Y
X-Received: by 2002:a17:907:3f08:b0:b8e:7dcb:7f23 with SMTP id
 a640c23a62f3a-b8e9ef22f6amr20500866b.2.1770145011116; 
 Tue, 03 Feb 2026 10:56:51 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:50 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Subject: [PATCH v3 15/19] drm/amd/display: Trigger ALLM if it's available
Date: Tue,  3 Feb 2026 19:56:22 +0100
Message-ID: <20260203185626.55428-16-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 08:10:21 +0000
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
index 8e110c86bdd4..53e488fdb4ea 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -541,9 +541,10 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 
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

