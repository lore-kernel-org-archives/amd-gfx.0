Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3FCC87FCC
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 09:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5437F10E260;
	Thu, 31 Jul 2025 09:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JJVGE0Vt";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1D810E260
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 09:44:15 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4561607166aso4708795e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753955054; x=1754559854; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8gECJJxpjJUK6y5ybBNE3rNQgvQG8WJfLtpLiyvU2Gg=;
 b=JJVGE0VtqdrvoI50rkhwPMNNwg4bpuoUi59ki3t0hlZjogL7v3dgDnqUWd288X8eHV
 kCqSPeR9rkSD3c0D4KjI2Xq/SEstyMCDwHSWEqFxlsHIKYZ/fCd/jesuc1+B2cz0IZfs
 Nm2Bxb/GPdc2DBSrk7VQxnPEs56Gs4q+aTfdHtnu9Cp/ogk+mt1JkNDe8KH6psx4kwRw
 iK1NTXm19qAyvXrQbkcwUGQjuCppU60IYaQVrGkyuNVXj6ijxTjTeX5a9pQzWVoGP6eW
 K7nblUyapMRR0hSreG5RcDXGbFgnGs5XR0Ar//hz9KQ51PVXIBzpi9Wg4k+J/fgGC6+s
 2MDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753955054; x=1754559854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8gECJJxpjJUK6y5ybBNE3rNQgvQG8WJfLtpLiyvU2Gg=;
 b=fxB27qT3y7xM9YsDCi7MlYrmWROr/V1LT6zszrOeiZ///VxwgwhF/vDn1oQWi6hjUF
 La3Rhx9nSxBmuh283yysyNR1FIJCxQSaMWv4XjcayGFeFfYJdHjQmSCSS1HpMdwcJ+vC
 InefvEyxlqLQnHpeiGfNeNHf9Fp5iUnJk6Irbyt1672yMjKaNYIqkGdIBdpsOaMcaaZI
 qCM1xQpEnJEuzMXim/CSQHHPq467zPYlTHs8INABWi9Ke2U00m/1+SpH01CFHRYJ/6ya
 uwj3c4yoXA3zXBFvozYp1ypKcD49gYGLSOdlvP4dMA3OB+HWzLUkXSBXExiFDVeziJC1
 Gasg==
X-Gm-Message-State: AOJu0Yz42sFPjat4n2xic2KV5ABAobaqNqrCV7JOYTmO/XVU1q3ytIeM
 1YljsLi+bU7YNYwpYjiVUEXoDKzLOEyCGYQAwvZliku/jIbj4LQLqYsP103aeA==
X-Gm-Gg: ASbGncvWPbaWjr/ZLfvQnZ2wPO+iv9sveUOu87O+ltag7kX6bb70nufOmkcVImt9pHR
 IXCvnH03prBnpNUGBRDOi/VrkKglBnWRAhhiTpYD2eQJ4Qdm3dG0g6etrL8mHfi53/R5vX902cb
 NrXSNArSZCMDKmdmBDhKdO2v+ZlYEGBamuN+32m4u0NBzb0qO4nVAYuBIyHRxKWu8pfEm1vWMM9
 Gnhk6oxvmdZ2LOjVEnfZOEDpqq01d00N3K60zBCqCCLtby1h9MkAZSYx6tmk5EuaHjSiHkwr28m
 mPg2XnxyujV/z4EK3h6MPvg37WPFh7JT9byJbaHKy7d4wjYgpNj2+OFTMtVon7Mu0h5JKjqW28t
 /n6vzyuTApDeZD0TOYzWd63SO5pVKxZpanhjPLWURcsZmmmvkvjFa5PSja3b/qgALLe4S5d1scT
 SaBx6TsMvv019YqDDaNi0=
X-Google-Smtp-Source: AGHT+IFJxy1d8TB9t4Kn2OsrnzleC/3qjzym2N4lHoCdseQWN1g+PBL4zDXAuTWe35JBfkxFGXRsWg==
X-Received: by 2002:a05:600c:3b95:b0:442:d9fc:7de with SMTP id
 5b1f17b1804b1-45892bc66b0mr49688195e9.22.1753955053296; 
 Thu, 31 Jul 2025 02:44:13 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536b3b4sm58252835e9.3.2025.07.31.02.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 02:44:12 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/7] DC: don't overclock DCE 6-10 and other fixes
Date: Thu, 31 Jul 2025 11:43:45 +0200
Message-ID: <20250731094352.29528-1-timur.kristof@gmail.com>
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

This series fixes various issues that I found while trying to
get old GPUs with DCE 6 to work well with DC.

The most important part of this series is tweaking how
the engine clock is set on DCE 6-10.

For DCE 6 the maximum according to max_clks_by_state is 600 Mhz,
but dce60_validate_bandwidth sets it to 681 MHz, and then
dce60_update_clocks further increases it by 15%, resulting in
a whopping 783 MHz, which is overall 30% more than what the
hardware was supposed to handle. My Tahiti GPU didn't even boot
with DC enabled with that clock setting.
There is a similar issue with DCE 8-10 too, additionally the
dce80_max_clks_by_state data seems to be incorrect, so I changed
the maximum to 625 MHz for DCE 8-10, which is what the legacy
code uses.

I tested these changes and made sure 4K 60Hz (10 bit) output
still works with them on the following GPUs:

* Tahiti (DCE 6)
* Oland (DCE 6.4)
* Hawaii (DCE 8)
* Tonga, Fiji (DCE 10)

I would appreciate if someone from AMD could confirm what the
maximum display engine clocks for these parts really are.

Other than that, the rest of the series deals with some
ligher problems:

There are patches to fill the display information on DCE 6-10
(previously only filled on DCE 11), such as the first CRTC and
its line time, as well as vblank time, display clock etc.
These are going to be needed for DPM.

It also removes some errors and warnings from the logs which
are caused by the VBIOS on old GPUs reporting some information
differently, namely some VBIOS seem to lack encoder capability
entries for some connectors, as well as the actual amount of
connectors on the GPU not matching the number of entries
reported by the VBIOS.
The DC code base already handles these cases well. They are
not actually errors, so we shouldn't spam the logs with them.

Finally, there is also a fix for set_pixel_clock_v3 which
works slightly differently than the other versions.

Timur Kristóf (7):
  drm/amd/display: Don't overclock DCE 6 by 15%
  drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
  drm/amd/display: Find first CRTC and its line time in
    dce110_fill_display_configs
  drm/amd/display: Fill display clock and vblank time in
    dce110_fill_display_configs
  drm/amd/display: Don't warn when missing DCE encoder caps
  drm/amd/display: Don't print errors for nonexistent connectors
  drm/amd/display: Fix fractional fb divider in set_pixel_clock_v3

 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  5 +--
 .../drm/amd/display/dc/bios/command_table.c   |  2 +-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 14 +++----
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        | 40 +++++++++++--------
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 10 ++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 15 ++++++-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |  8 ++--
 7 files changed, 51 insertions(+), 43 deletions(-)

-- 
2.50.1

