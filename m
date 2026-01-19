Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEE8CA5FFF
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF94210E3A9;
	Mon, 19 Jan 2026 08:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S5dnYFod";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BFF210E30B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:12:08 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-64b7d213fd6so714486a12.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785127; x=1769389927; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0u8eLdbLCl3RDSNLAMEHYXwCr/EaTB1bb2BDCNJLyI=;
 b=S5dnYFod0NPGHmQdsQj4HNGJLaWwYhTZaFr776uv27n86G8gJs8dA8zxAy4JPYSOmM
 UI+WBCZ/sHyWCC1RpHsF8yCWYtlumSx1mHmSke/u7C4YHaOqOgqhQGeG0rE5mpUVKMuU
 PFh/w6HfrUlN6+lLI7Q5c8Prlv2dqQd74pIifOpcGZeW1nNMiv3s7SYi6wSkCcb11BaV
 ZzY9lYjPYd1GcaWSes8nBp72PS2k6KRdgwJ6NQVxqirHBGUqzNBxUrVD8Xin9wvRa1K7
 696ictE/0mcaFsfZaA3ctGxj4yV7uu7dPKfAP2wfeLHTmbfZiO/E3KPPDhZ4siEfr8ia
 QOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785127; x=1769389927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s0u8eLdbLCl3RDSNLAMEHYXwCr/EaTB1bb2BDCNJLyI=;
 b=Tl1CjGIccbsfFsZy7tQxtz3xXxOJb54lLSIwj9CuNZEKlwx+on6PeUY5+9RbPpA5qE
 AqGdKe2ZvfChsSHyetEt6EL6fsQZgheFWA+d1kbnr1tFx9ON2kZtjt68Cs/ygzpEuYFv
 dvo5d6KhjwTmnZ/5PM1IW4/+B8Xky9dzwM9QlXVZtGhd4fLYx6bZz6JPZRteJhWY0e3Y
 20EMQeHNkEICMBItu9BqUanGYR3qd2aIa9kwyQx5QA6kGL/ihZ/XfHuorPpGIrG5UwP1
 KO6OBiBAAqVSvsrTWT7aRjELC3fCvqsb4KdRAJ97Ml6zmBZ+Qpr19Q82f3gqRFrmJ4Hw
 oZjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyo6EYQ1dKXHnkImDNrLVPr7opQ9fVbXQyzcy2UlG76OYe5kXTW5aturePPx/vce4hSzvKt0Ps@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWIbLLv06gVEjZF/3QJIS5noUAzrHws4pnKwzoQ+L0U+N5U1i1
 y1aImfW1ANgneYWCSTu5i2IxBcyIW0hKhSJTndmFhqu0P8+9PQFzpChl
X-Gm-Gg: AY/fxX7iulDNia+g+rI9Eok24BqmLaaEFrUlPtYMbb5creCoyLbX+t9cwUVD0rx2cxE
 G80WoGH1jmmWBUIjprwKqiIgfrX/7t14aiO3IFBG2cPT1KYuobBm2t/64zRMsrnhCRkkUXQQGU9
 57U1N+yhwc6tg9YKYmRr8Ef1bcGcrALTDFZBLqm5K718jvVasxKsAhZeKJBxGORwnXmTUYS8RIr
 VWGGQwU0JKQKfoeA+BPcLQRXpkNuFHgRcPjHfI61mfCzxILlVzu/1oIj+eAi9dmQXZud6Cctq2A
 2IsWPtSh1+TSBMeQHKAMEthyhESdaYp/no7ZbRh2HbXtEhQRUmioahmWM59lIKqrEAC6EcI+U3t
 4ONFKga8RF7aihNVfC4sj03pjN1dlumgeRih8c2Mshr6FoHU5HxCUaxsdIZJ/6296BRFhNuAjWC
 P0P8yiQ+huhOmrCXm7dfKpEoe2DJvav6i2xdPeowcoL8SaHYPtS6HOiTmdVtpJi3KB
X-Received: by 2002:a05:6402:5216:b0:64b:3b7c:7920 with SMTP id
 4fb4d7f45d1cf-65452cd36d2mr4017295a12.8.1768785126847; 
 Sun, 18 Jan 2026 17:12:06 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:12:06 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 12/17] drm/amd/display: Build HDMI vsif in correct slot
Date: Mon, 19 Jan 2026 02:11:41 +0100
Message-ID: <20260119011146.62302-13-tomasz.pakula.oficjalny@gmail.com>
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
HDMI vsif was assigned to vsp_infopacket (FreeSync) field

[How]
Build HDMI vsif in the correct hfvsif_infopacket field

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3c535a361882..ef7e02ebda41 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7362,7 +7362,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	update_stream_signal(stream, sink);
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
+		mod_build_hf_vsif_infopacket(stream, &stream->hfvsif_infopacket);
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
 	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
-- 
2.52.0

