Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED59E68154
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 08:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9ED10E491;
	Tue, 17 Feb 2026 08:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J1zM+Jw5";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2286D10E3D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 16:45:50 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b8f8324d2eeso40830966b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 08:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771260349; x=1771865149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvZ/+fVRqmKiJ2IIikBQGPpOWd0BdH2EkluaR3gmOLg=;
 b=J1zM+Jw5Njyc8vr+20rcnvRfxcISSY5zgoAobNokG/5Gq+i/VnGauzlLu0BSufHdhi
 x0c0IJf9ffYtesr5qVEqo00BS7BaNRWKtQ+fxagarwtGD2D915uBp7mQVFdENmgB7w+H
 ITJAMQnv79zmQGYfFwkQKuH2COov0RnxPr8mc+Vgn/1u1fVpdh1hE2q1z+MuxUqNOYDl
 hthA+/Hj55QxBTeAn7BpyTsc+xJxm8fjFn3zl6g+I1TkfAMAUgXLKYUiXZxKR3eFJgOs
 w/fK1uUIpcrxBEUSOL9wxKw3t02rmC8v/pAgx/XTm8Wrj6hYi6/PVS4N0XgW6HChlfi8
 yD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771260349; x=1771865149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pvZ/+fVRqmKiJ2IIikBQGPpOWd0BdH2EkluaR3gmOLg=;
 b=wdGTJluJJrNnBiVzKcGltxMMuqj4ml7MwC2mgpWndM50TAiq3gI3MicjwA/02xkWP7
 orbdX9r9EI7zJbAUyh+iaz6o7BX+LEK+xd1uYnnlPG0FNLTAdlq8B2Z/xwzryJKMBmEM
 mSPz83+/yWkUKWnJbkNgME8WsP2VLJagIm5zsPHQ8CchX2MHlDkndPeNNaQSPYD0JuVw
 Y3Ct0ZFXwehtSx1eiwLlFgu1jriTDbC9dDlBF5RzWPjSJ09UKh95s8cZ2lSeTjKJ2Q4Y
 VPcv0EOS7XW+sLJ4KOXYech/J4VeZHcVqdkp5vyS4isnhKflnik/1LdEGsqsxnm5PIe0
 lcew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRKtMDR2TK+GJ3ylsytmoymlM+8gUmTkJAaNG8GCkRQSDj9KW4A8WuJFeZLwXrIJ7ruA/sQ2jS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxE8vF0ODq1EkN2EmZfhF/dVA99SNn6gqRh2SUjWW6kVjzZc/ul
 KCreGcH6C5Y30Lwve4P+DG+27OPIpvMisOw/gDlu5kHQmgAdF/GukC2d
X-Gm-Gg: AZuq6aI2y1EAidJQAn36bUK34HspFo7ClnwoJrQSSdAL4vN7niZCyMcqYG5nXDYOf95
 BaIz+LVT/hxsNDlhAZpRnwbcp+1u5ajd3FYNw/AdV2bWamc5yciRm9UfJjSAtzfn8o9MyAnLyga
 h1r3V9aKuOr+Ufi8Fuk7yfCi9wOY9fo6fHhHCKl/Dxs0CTsMok+qhkYQdIUAqf51F23vkkjqZeW
 SLM7FS/VS21mpqOoLnc5xe/uZtfYsT7iiB0wIZKnPs0PDMHprCO0VDDaLdjYl5SyhwIIFjoaFoV
 zcNEwjBA6rdWjXuJKdPtQHBQb/JpQzz/auPyAeI4cstDfzpondu1Vb2H1kZRFacUdSQJvI7jsNr
 uG3qDp/LF7ly2swZ8+Y4eAxNhIo7OaUQCEosi7H+Reqav2R4FJ/HGxEXE5xR/0BMqSb8NNZ3UkO
 wFDhLXNgkVEcQoIoV0KsRZT7AoFBZMlapfu16sVfLd1zku2nQKbrnELWDl9uKbZar/gCkzsO42W
 nPQ
X-Received: by 2002:a17:907:3e88:b0:b73:59b0:34c6 with SMTP id
 a640c23a62f3a-b8face510e0mr348092966b.4.1771260348524; 
 Mon, 16 Feb 2026 08:45:48 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735d185sm264683866b.14.2026.02.16.08.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 08:45:48 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org, daniel@fooishbar.org
Subject: [PATCH v4 22/27] drm/amd/display: freesync_on_desktop support for
 HDMI VRR
Date: Mon, 16 Feb 2026 17:45:11 +0100
Message-ID: <20260216164516.36803-23-tomasz.pakula.oficjalny@gmail.com>
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
Many TVs and other HDMI sinks suffer from blanking and possibly other
glitches when VRR is toggled. With FreeSync present on such sinks, they
behave like the signal is always variable, even in fixed refresh rate
situations. DisplayPort and eDP enforce seamless VRR transitions but
HDMI unfortunately doesn't.

[How]
Keep HDMI VRR toggled if it's supported and not explicitly disabled.
Add logic that control this behavior and use this mode by default until
it can be controlled by connector KMS property.

Functionally, for an end user, this is the same as normal, fixed refresh
rate mode. The only difference is that sink is kept in VRR state which
enables seamless transitions into/out of variable refresh rate.

Uses the already established freesync_on_desktop field and logic.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
 .../gpu/drm/amd/display/modules/info_packet/info_packet.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 7106b409ae54..7e0adb90af39 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -633,6 +633,14 @@ static void build_vtem_infopacket_data(const struct dc_stream_state *stream,
 
 	vrr_active = vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
 		     vrr->state == VRR_STATE_ACTIVE_FIXED;
+	/*
+	 * Enables FreeSync-like behavior by keeping HDMI VRR signalling active
+	 * in fixed refresh rate conditions like normal desktop work/web browsing.
+	 * Functinally behaves like non-VRR mode by keeping the actual refresh
+	 * rate fixed.
+	 */
+	if (stream->freesync_on_desktop)
+		vrr_active |= vrr->state == VRR_STATE_INACTIVE;
 
 	infopacket->sb[VTEM_MD0] = VTEM_M_CONST << VTEM_M_CONST_BIT;
 	infopacket->sb[VTEM_MD0] |= VTEM_FVA_FACTOR << VTEM_FVA_BIT;
-- 
2.53.0

