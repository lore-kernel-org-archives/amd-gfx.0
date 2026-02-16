Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66210E7BDA2
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5291A10E464;
	Tue, 17 Feb 2026 08:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DWRvg1+J";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1120210E3CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:46 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-65a360bb9f4so612473a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260344; x=1771865144; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TM/8v34pas6+agtqG0yBbCtyfKtfnXSHfIXKjiQpv5A=;
 b=DWRvg1+J87lMjpzFlROuynMyfQrM4HL4RNyxayztuphQPtqGCfIKgHyQnLv4fgZ32J
 htRpMVqKFCTK30POxww0gFsNxw3bKE0O8lmdQQ6zKnNc2ODmzXwJUCM7Jl3Iy2HguNSk
 6qV3m/A7P3rw5GlPTO/mA0b3goWZDxAtEOvyuUME783iqWO2zKP2NnqsvzcGtEnh4icR
 8+0Q8HRg2ZdLXTwnzjgLT8M3lGQEGv2JkBt3AzmtiXNds//+jUl7F+YOlx3KhToM3qUK
 ZBbeTe190RlSz5s1gRaP9n2XuNVh+mySB3rkvgAd9Ijlqq53TI0+YBOdbGrc3rAYkjo3
 B0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260344; x=1771865144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TM/8v34pas6+agtqG0yBbCtyfKtfnXSHfIXKjiQpv5A=;
 b=NEXUBJHAUvu/xoY9Co3iNN3awnQfsjG0hkt4N5KxvUgh0/+kLm2n9Wk8n8CTWpeACY
 iO4Tp8svJ7ATbaHxI7t6rFjgY1LcqJE0S3uW/RIZbQR1jSAUmfiiu8w4NmOYwGvcMNJN
 1VWKDBWkNArCjZTYYHJ1v7k+3e9C/XOWAvUUMxX+Qy/bxrmuexI/ULRHBsqkLcqKREX5
 /gsyKnIZ+WGuu48rUWerdTZD77Hmtr/3hVNYxUtRwQTZcsD3vDB1u8ArW1U81UT/dmQ8
 TAZvirp7mMPP0MHlPm5kvYcYe9uz4b7ivU4uuzjbhG0G+Pb/OSwz1Jdn0D+5nbDuMyiM
 G6oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP0eCQ0bvnvyOYyMswYHChukcGb1DpF/qEsrOmq1D3zcUeKMSaui0iCSOcTUCvAsGQVZ4lcbof@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1l1a/HDIQP1Cwr8QNP1HY2TiCEiVm0qnHTNVsntxZYYtJA7WE
 6S68CVYAyMgfSUux2BYucrkZMmezqGY0suSOXcqEZ/7rJ9i30z8ASaJL
X-Gm-Gg: AZuq6aIYCQ8TzVrXqiA9Sntvqun1QcGspcE+q3XxKljcHt8uPq2N2K3hrWCe5YYsLs1
 se/kdd2iWVsmmYgXJHouhFR1SiyFMIy9ermsUjET5M9GSvG2BJ0x6SeYqROuBNDsDphIySS9esm
 Kw4iIeeOlX/KTFBD39mu5vb9I+Q+H4jjZQ2o/D551ydS+Y6qTqnobckH4YvlqVOiniBfFTlfoUH
 5oiLMBfMQmGRKnGgBgkKBMNLa9u0/5IZUhkMqRRHTenyygmA6xpESsPvvOwl9GfCNe5k9p/Z/O3
 abP5FJG1N8R2elxaIWg1ecjqJn42funtHnU1WZNX4G7aRHOms2W1dWJNl7ToGaZnj50J3mIde2l
 mRr615CS6JmJkC8pxR87CsLyVD9m5rolk0t/iE3vNunVjyUva9dWkiQajn9YBfor8xDNng9PVKb
 jfLaoKUaI/5aOb5+UQTHPYpG6QNrvG8TqCn8pyYr7X7J4ClAzR2t/N/nusbWk4nhvMlgaE5EWMJ
 bN7
X-Received: by 2002:a17:906:c108:b0:b8e:9ac2:9e0d with SMTP id
 a640c23a62f3a-b8face3fd6fmr326209466b.8.1771260344450; 
 Mon, 16 Feb 2026 08:45:44 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:44 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 19/27] drm/amd/display: Trigger ALLM if it's available
Date: Mon, 16 Feb 2026 17:45:08 +0100
Message-ID: <20260216164516.36803-20-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 08:05:08 +0000
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
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/modules/info_packet/info_packet.c  | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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
2.53.0

