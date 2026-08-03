Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CE1C5518F
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 07:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C15010E8A2;
	Tue,  4 Aug 2026 07:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JcFVzeYY";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B8C10E703
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 15:25:57 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47fe45db360so109672f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785770756; x=1786375556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9LoyqYzYJ0Nb5xInecrCvJNeUVfm0JCLfhe5/5aWpTE=;
 b=JcFVzeYYMezuM1/WVlh0hs57+HiFxsWB6mLR3X/08fk63m3DanXNmAwBOpjeeaNkvG
 LCookTF874h84LMmHXLx7glwzG2WEZEM/x37wpoJ9Vl/IEJjTJ89fjgWXOJ/8cD/33fj
 tD18P4Dlz0A03A0XBPDXloaDxqItN1H72IhpUbmzRptDC5o9U2xzJv+Qw6ZNt2ft69dV
 1WYbX+CBLuVqBt1CIFtp7skALtWUC9X2DOYKdsl25u5rFQFYxIjvVDXN5JjCkqblOMLA
 3ueIB6R4jf7c9lkF7m7nAvZTMX6CVEx9UdEhjcQTWHEWBjeVXdXPNidcbkbhpe2mo62y
 Tgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785770756; x=1786375556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9LoyqYzYJ0Nb5xInecrCvJNeUVfm0JCLfhe5/5aWpTE=;
 b=LyqzEb69Cm4HHh9zYL8WFPpHmKjcTpR5+caW+WSwc/+085q2Lb8q1Znx7XAUCWRgkP
 DpXyqiDqE0j98StF2wcqhwi7VFayClDH/FwfjLF/oJyOm+cktQitU8HSFx60G7DdhBla
 UVYdknI5nmzV8Vs9UdeqjukHQO0B7GU/RuJdYgceLdftcZ3KbcQeDnHBoZJBp9xSnzDE
 8fPQPQ/KPHZKUETNcKlU0MiObTV+XhNsdPNq3u6+AjbA8Tsyt29QYju2EPb1HcxPTq4f
 8WIP861K2eO0ZGPXr3D00Fj54JHY99Njwb5OauYmRsUCxGxHIAufub4pe56VrjemxZZG
 QXMw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpz074FnvovESSG8aSS0SeaMVdSPCfiHUDWQ5XA0Bt1wd52k9mWQz8fot9sNBofehVdy0auJUdT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDBrSvQcIVPMtyKOhuRoXBMUgAhOYLAvEmXYR9eKrXks2o4lRk
 YexDHV3r63A2kNo4sL1clE0xb0Zh1eo7FUc6JKxtMteVs+hqxqLe8azJ
X-Gm-Gg: AR+sD10VihvpYXY/9yzdcufPxEeASBI0z6I2+7ekR0O33BTXruI2r7eonHOfMI/oTAC
 2+gbG5aEu10aZlCRQZKuRd+pBHLgSEVmanjOSdoydvN2Ikzq0+B8Kd0sQoh/SLsHLrHY+u5vhkE
 1D5QZDL7rNB1ckKwWGuHG1E9sa/kBb5AT/89bVqiOwLguq6TPkVT/+2gtp79HnoRcC9+q4JZ50t
 qd6+RouB0//UNURRm112G4k8kI1NlQ3yDJkaPWUzcKd154RpagKHl5T7G7Sew5prWAjjkpBenhe
 Ma3qbxOUBHnUziSVyWIymYQwtTU4vo8B4GATRrnOwilZkqW5jOzwn4RQUiCP5pKTJ9jvYkk7Tim
 /zc1rnlpmmDnAlHVXvVcIfqdi1YXk+3+VlEpn3Ifra0uhWtOPI7nKelM7m+wrLNIimd8BBz06DJ
 0u4pecft8XZu4YTfaM6T9xzAT1e7ONGqEF+82ipuAyWdqE/kdtqMy5gUgc+VtK8HUoROp4x/aby
 QuZn/1fgoItbdrs09hOclfy0HOpjytMLIn1Ynph4rPRYkV+uqCyybjqOwu5dORYlgSU2oFcKl7s
 Ro8=
X-Received: by 2002:adf:e197:0:b0:47f:6c7e:b32d with SMTP id
 ffacd0b85a97d-47fd72a0d89mr15322739f8f.1.1785770756108; 
 Mon, 03 Aug 2026 08:25:56 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B85F300A5CC0DBDABDC4661.dsl.pool.telekom.hu.
 [2001:4c4e:1b85:f300:a5cc:dbd:abdc:4661])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2abbsm34461507f8f.9.2026.08.03.08.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:25:55 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: nlucasgit@gmail.com
Cc: Igor Paunovic <royalnet026@gmail.com>, amd-gfx@lists.freedesktop.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, joshua@froggi.es, mwen@igalia.com,
 leorize+oss@disroot.org, alex.hung@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/amd/display: fix BT.2020 YCbCr output CSC
 matrices for DCE
Date: Mon,  3 Aug 2026 17:25:33 +0200
Message-ID: <20260803152533.9008-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <15b28cafab1b55f3e4cad9bb542847d22e776bda.1785616749.git.nlucasgit@gmail.com>
References: <15b28cafab1b55f3e4cad9bb542847d22e776bda.1785616749.git.nlucasgit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Aug 2026 07:18:42 +0000
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

Hi Nathan,

I hit exactly this on a DCE 11.2 part, so here is a data point for the
path you could not test.

Setup: XFX RX 580 8GB (Polaris10, DCE 11.2) as an external GPU on an
Orange Pi 5 Plus (RK3588, arm64) over PCIe Gen3 x4, driving a Sony 65"
HDR10 TV at 3840x2160@60 with HDR enabled under KWin/Wayland. The sink
lists 3840x2160@60 only in its YCbCr 4:2:0 video data block and caps
TMDS at 300 MHz, so the stream comes out as PIXEL_ENCODING_YCBCR420
(confirmed in hardware: FMT_CONTROL = 0x002a0000, FMT_PIXEL_ENCODING = 2),
and with the compositor setting Colorspace=BT2020_RGB the output color
space ends up COLOR_SPACE_2020_YCBCR_LIMITED.

My tree predates 51e6668ab4ba, so global_color_matrix[] had no BT.2020
row at all. That is worth recording as its own failure mode: with no
matching entry, dce110_opp_set_csc_default() programs no matrix and
configure_graphics_mode() leaves OUTPUT_CSC_GRPH_MODE at 0, so the
output CSC stays bypassed and plain RGB is fed to the 4:2:0 formatter
while the AVI infoframe declares YCbCr 4:2:0 with BT.2020 colorimetry.
The sink then applies a BT.2020 YCbCr to RGB matrix to RGB data: luma
lands on green, Cb/Cr sit near mid scale, and the picture is washed out
with a heavy green cast. SDR on the same link was fine, since it stays
on the BT.709 entry.

Applying 51e6668ab4ba plus this series on top of 7.0 fixes it: colors
are correct on that TV in HDR, across a reboot, with no amdgpu errors in
the log. As a cross-check, the same desktop on a second monitor driven
by a completely different pipeline (the SoC's own display controller)
now matches it.

I also booted 51e6668ab4ba without this series on the same setup and
could not tell the two apart by eye. That is not a counter-argument to
the fix, just a note on sensitivity: the compositor maps SDR content to
around 350 nits, so nothing gets near the top of the PQ range where the
full-range luma scaling would clip, and the residual difference stays
below what this TV's processing reveals.

Tested-by: Igor Paunovic <royalnet026@gmail.com>

Thanks,
Igor
