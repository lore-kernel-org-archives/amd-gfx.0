Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7A7CA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F07210E280;
	Mon, 25 Aug 2025 21:33:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PGPXYqIw";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E797D10E58A
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:33:38 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3c763484ccdso1452178f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756157617; x=1756762417; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y8cOjQgjqMEMFJUYuU9Ei+bx/dnBQCfnQ5UhOSLxaRc=;
 b=PGPXYqIwRPpLzCyHLg0i+mJP/IEQx4B9pJZhh09p8AU4LpTgprU2D1/r8rMxaovrtY
 TkRLMGMTZyNxXzAmCjfcMtBH8G90sR9fdCcrINPikzBa9bEZVWGejtuPuaCLeDdgYufV
 TA/fG87VLSf8ltDzS3w0/HClor6UdmxJQXCyZ+7UEORZkB+w4V+QbBVnpvWBNBkjBNs1
 VoVpzN6XtfubEJJrls0iJSAP0ePQSCpVCy19XYJ+tMPf+xURu3AHuPnwQINuI7zBTg5M
 jl3LM+kgvhiux6fAv+cugy5v6d2tV4dVz1BB2hC1hKtbjHv7Qatg0Jq6YrjZLHScaqG3
 4O5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756157617; x=1756762417;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y8cOjQgjqMEMFJUYuU9Ei+bx/dnBQCfnQ5UhOSLxaRc=;
 b=BTEk2vwQ6XA1BxQ+aG7qjt3sz3cwf4MEeKyhW5lMXFyMpZ8IWAPnvdNI2Z5B8wPb5I
 a1K9+R3zjr7ViiCo10tjxXJ44euiQkqp6NLVs+6ViQZ4TMr57dnpY40ZNiAxp8qyrhj1
 DIXpndLFivvcj8vY6wnZzGYPYoOssD/SBuiectpmh3fpPOil6k1vVJkFGVOb5T+Ittbx
 OsMrQU06Dju7Z1k38oP0spAsjJp3MZmzPhOcoILGsQtb+oA2oNG1syfIqPcxmesIIgsp
 DxFRZ+XRbzQfdZGvL1KBDBTvYfjDsaKVLUK873y00YQ8O2/ovqyqr+6Ib5rduELnlitB
 YW+g==
X-Gm-Message-State: AOJu0YxHVxl5pEu4pdfg90sUCC3it7Zi/Fy7WXMGq/6zmMdRXnplXsP9
 A0vMLkhw+HqqUSW4CHqVMhKerrvS7GJWvLHGxiX/hiefBDOHJRZW2H857Cwg2Q==
X-Gm-Gg: ASbGncsAJ/yQUcobFll5PpGy0pMHQPT0spcJzPL0JkKL+E+/BloBc27A7s3X/toheTw
 2WEOPPLn7bsrlv9H963+ANDUvArUSdxUyR061yOQBelB0O9iIPrrpaPYUZiwXxHPK415xrWQSTN
 DxsZZZupFAYk1HWwlR/4lAxnlyI+jWhKG7nASx/1g55Aelwne27u1uwh8cNQxA7k08osSe45xYM
 3pGZS7VewM7yBLVeDk9Z66dwJNL/IJwKZECgpbhtm4nNpccRlaDIWtefXM1H2LdzW3hy8u9WWM0
 saMt7PvsIgpGA+G+TsolUZnlU5uiqZrcyvXHyCcJXrseadVPCLix3tAnhEBhpIt7XJhcmRehpnn
 rWyhvA7aQrZoM6Sftx73DVyn+8axXPGwwaAyUJC8i1dV9XpB+KLF3FuVtuUdkCjIR1/AsBmpY8y
 O3/k7f3KKIPMKrIoTz7PBMy/rBJg==
X-Google-Smtp-Source: AGHT+IHktfBGs4DsJ05O3+J6HHnY6GyH9tp+2Va1CJ9ciiMUo+jqTZDcpSrBhE/gGRVkcxjGevLnjg==
X-Received: by 2002:a05:6000:2f87:b0:3b7:94ad:ef50 with SMTP id
 ffacd0b85a97d-3cb02be25e2mr845650f8f.2.1756157617332; 
 Mon, 25 Aug 2025 14:33:37 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7a361de72sm11470874f8f.8.2025.08.25.14.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:33:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/display: Fix DVI-D/HDMI adapters
Date: Mon, 25 Aug 2025 23:33:33 +0200
Message-ID: <20250825213333.612600-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

When the EDID has the HDMI bit, we should simply select
the HDMI signal type even on DVI ports.

For reference see, the legacy amdgpu display code:
amdgpu_atombios_encoder_get_encoder_mode
which selects ATOM_ENCODER_MODE_HDMI for the same case.

This commit fixes DVI connectors to work with DVI-D/HDMI
adapters so that they can now produce output over these
connectors for HDMI monitors with higher bandwidth modes.
With this change, even HDMI audio works through DVI.

For testing, I used a CAA-DMDHFD3 DVI-D/HDMI adapter
with the following GPUs:

Tahiti (DCE 6) - DC can now output 4K 30 Hz over DVI
Polaris 10 (DCE 11.2) - DC can now output 4K 60 Hz over DVI

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 827b630daf49..42180e6aca91 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1140,6 +1140,10 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		if (sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A &&
 		    !sink->edid_caps.edid_hdmi)
 			sink->sink_signal = SIGNAL_TYPE_DVI_SINGLE_LINK;
+		else if (dc_is_dvi_signal(sink->sink_signal) &&
+			aud_support->hdmi_audio_native &&
+			sink->edid_caps.edid_hdmi)
+			sink->sink_signal = SIGNAL_TYPE_HDMI_TYPE_A;
 
 		if (link->local_sink && dc_is_dp_signal(sink_caps.signal))
 			dp_trace_init(link);
-- 
2.50.1

