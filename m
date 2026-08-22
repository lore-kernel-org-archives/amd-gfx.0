Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AF7C5DF97
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Aug 2026 09:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9561C10E491;
	Sun, 23 Aug 2026 09:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RtSSIAnw";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C0110E346
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Aug 2026 14:58:02 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a38098734bso3589226a12.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Aug 2026 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787410681; x=1788015481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MxLxyi+V+p9av77WPt9hWKy9ZGIfmbgiIMqaVzXmUOQ=;
 b=RtSSIAnweF+W5MdGNN33md74zRQ6BO55zGHy7GYHkOvO2a4pf6KOJKEWDE7U3Oh+Ov
 bm56fPs1/NmejIAhdiFELvp3Q9vS0xyELqY0XaYvHbIOagseexm4jsxYfmTK5KzgNx/8
 vVsk+vjhnS2LNuBSCoaw+IJCjDckqWwz2da/KPkDkAPUgw6K4SDc3iWFLIfRLrbf2W4U
 gkzOTr1GnyjVF7Jtb1GfSTb3NcZAdHJDNuGOKS1H1iv4weZGFzeumCTQnr6ladDC23gM
 mpjq6audJNBDUkpyQknLk97r10NhGBIsW7HhFkfdFzK1oyiVdXu0NTBWzvuCSliaptLT
 Zsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787410681; x=1788015481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MxLxyi+V+p9av77WPt9hWKy9ZGIfmbgiIMqaVzXmUOQ=;
 b=kYw/PJVTyEQ8SOsNIotX3YbAVKnIt3H5oVi+4HI22YXosnV8lPAK4TvRpLqIPgSDwH
 SDlZo1O6AcjW/Yy/Z9ZwqeA2c6DJIb2vhvfAsDA6YD8ZXxbe75P9Jm8NMUI31lb7Qfix
 cqq/a9G9FOR2ddC274Tr0J3X95sOD9vPelyJl8N4smJu3e6tU1FLBMnJqnfSqELKbCEH
 9ZMoIz5cqSMnSwStSPBdjH04LdIOsUgWYpWTCH5Nwn+nSPRuKOMDJGRS9fn8YLMXsA/E
 6/CNIP0kiYm2D1xrxtO2x11vGLRQMXHsNOPyhzlKr80Lw6y+rDd0zLwfMCqcvz6XSjtW
 hV3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhcsQkhesnAf7hBhqEPuhFTUqu/0MnVM65e3J78TusBtBkA/acTko9ojh+MRq0RGUXVfGHwSys@lists.freedesktop.org
X-Gm-Message-State: AFuF++l5haILgY3Zj6+xocSdl52+x+phNgdYwdXKQ/m2ZeU5b6SYe4XO
 EzmrvRpwRuREUfbxmwD3wga4kU4PF5lQqLd+GelncDZRI/oVhR8Nag4U
X-Gm-Gg: AR+sD11F7UAa1A+GLJCOE0kEpBeycYiPwyma4YXn2E44j0MwfGYUNvlpgEnAoTYkUxH
 ZmPAfrVh0Dl2ZN+br6zTG8p+kaWaUL/NB4G4Vjal67gX7akZGCVg0nFWHfnNjlj3GWHkZYu+tD6
 hDo6O/Cw1KN+T4qXV8Tm6BBHsYbfFvalhP9QBs+r7QkRD0cg95Jr5FKCPYKEGa20mBMAPBkZjZh
 e4/Sr6m0UUy3bVGRyo3pIMOlYj/NK1lMChqU3jGXkQfxN39H5YzKGOygjLomq4IngFrFu+LnxJc
 HUcmpwdDEU6bFBHX0Wpjf8j1FpT75CqasQCMaTNWGK5lwcggDjaPkSZomvVU9nRG2PamPeYNK1p
 x9idLxJuV5H+3dszr7xPKTsofhN1EvTmJVMbSTERaChvS3AItMlsI/dXPfNSGfNGGGRxDrZAc5M
 0lqrNhH1Om7KngMhwEomdEO0YD+gqZ+SSFNRXQNx+unnOsYE9Lx/jUjNx1htNJbGTXZbMhQfrbr
 8ISSnb19ZRwZZKY6BiA4aOH1hzI5iN5wSAOR2sVhnGwafn0T1VgLqT9tzSuSjVgkV+dKg==
X-Received: by 2002:a05:6402:a0d8:b0:6a0:926e:f907 with SMTP id
 4fb4d7f45d1cf-6a42f184b7dmr17373988a12.1.1787410680740; 
 Sat, 22 Aug 2026 07:58:00 -0700 (PDT)
Received: from localhost.localdomain
 (2a02-a463-a071-0-e100-b32a-30a-b4b.fixed6.kpn.net.
 [2a02:a463:a071:0:e100:b32a:30a:b4b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff17df84sm16471538a12.31.2026.08.22.07.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 07:58:00 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dillon Varone <dillon.varone@amd.com>,
 Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Cruise Hung <Cruise.Hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Peichen Huang <PeiChen.Huang@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Mustapha Ghaddar <mghaddar@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH] drm/amd/display: fix division by zero in get_estimated_bw()
Date: Sat, 22 Aug 2026 16:57:51 +0200
Message-ID: <20260822145751.42328-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:28:04 +0000
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

get_estimated_bw() divides by link->dpia_bw_alloc_config.bw_granularity,
which is zeroed by reset_bw_alloc_struct() and only populated once
DP_TUNNELING_BW_ALLOC_CAP_CHANGED has been handled.

link_dp_dpia_handle_bw_alloc_status(), the DPCD interrupt handler,
calls get_estimated_bw() whenever DP_TUNNELING_ESTIMATED_BW_CHANGED
is set, independently of whether DP_TUNNELING_BW_ALLOC_CAP_CHANGED
has ever fired for that link. A connected USB4/DPIA tunneling device
that reports an estimated-bandwidth change before ever reporting a
capability change drives a division by zero in this IRQ path.

link_dpia_send_bw_alloc_request() already guards the same
bw_granularity division; add the identical guard here rather than
introducing a new pattern.

Fixes: 8e5cfe547bf3 ("drm/amd/display: upstream link_dp_dpia_bw.c")
Assisted-by: gkh_clanker_t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index dd854d992692..f43fc4b78a8d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -103,6 +103,11 @@ static int get_estimated_bw(struct dc_link *link)
 {
 	uint8_t bw_estimated_bw = 0;
 
+	if (link->dpia_bw_alloc_config.bw_granularity == 0) {
+		DC_LOG_ERROR("%s: BW granularity is zero!\n", __func__);
+		return 0;
+	}
+
 	core_link_read_dpcd(
 			link,
 			ESTIMATED_BW,
-- 
2.43.0

