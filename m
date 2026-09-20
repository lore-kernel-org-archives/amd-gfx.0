Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0177DC982F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14B310E4A8;
	Mon, 21 Sep 2026 07:11:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oKQ/xK8Z";
	dkim-atps=neutral
Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com
 [74.125.231.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04F210E70C
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Sep 2026 01:31:06 +0000 (UTC)
Received: by mail-oa2-f12.google.com with SMTP id
 586e51a60fabf-46accbdfc20so1550953fac.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Sep 2026 18:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789867866; x=1790472666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6hTqSEJnD6ZpSU2Pd3zom/nMKHhVqSJvkKONP60toIw=;
 b=oKQ/xK8Z0PhAZz85YxTUWY2/H/W19gHzFznal+fO52eEV87Z51JG7Up+YWZUruTmsU
 xrH4mn9hBXzc81MBmq+yjd6Gl2LSbtBvP8CfEQ0YmZvKaLVQfZ/P4FVzc3d6S7qFXpJo
 Javrx4syJbZHYsCT2F//X50wLn1gP0F8N/TdCviyagkqXB/IyvmB5QK2xg3sdx/PsMG2
 uJqvALIIxmgQ2UiIPRjUp+jrrrzZnHFQNGoqgnKi1Nkz+8QJZuYq2Dd607NgPot6KCpL
 ZDvtX8IqsjEhodi3YoROs/Ti8D21XnFBQVP0OObDSyyofydG+UQLHU4fRb+IvJEPMfaH
 CjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789867866; x=1790472666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6hTqSEJnD6ZpSU2Pd3zom/nMKHhVqSJvkKONP60toIw=;
 b=Rse9KmofHtw6X3eOJae40B8StjSNiBl5QOiYoyil/AtPHSiNdrkax76Ttf6lcYjqc3
 LBLwfYDa99hhbKxD6ZV9cA1LxZ24HvbmrTrkwSPP9ZUUGKHCRC0mizA08RKicxiW33OT
 F856Dl0odXIGs5zKm8uZ4qAgwwx4eEpe4tcMe4PedwxsCbXkxFUX9lTi2Gq4APJunkAJ
 moEMENXkIh9c4pMQ8+LN+ubqIxIs2+RjzsoXLVsF3okvmychecBnEOn/dY6LpRGDlnhg
 5A/gPytYQ8lDMAc7FAXYduKR85Gxl9OzUFO4ii9Ma+8U1ncmdfi/NkjfstDr/EO0ckIX
 Jw5Q==
X-Gm-Message-State: AFuF++ngAREaAqGHfIz7Yk8cCzS2im9OxlIizAeYUmwPoqeNxOtPZRs4
 gF3rgZg7cF80Tly4w5c0nKGsewHZt48Av+r/tx38dm2TQmjVU+wcJIzfxYk78lC3V3w=
X-Gm-Gg: AYBFou3j/AwFrH5xlCKZ5adOO3QXWfLASR2NrMtdmv1MiSyF0RhUiOj1adkiH17XY0h
 qJG7EWgvFdNA9RJ5s8a71mhHrRAVpI5qqBkbP0NMiC8ZXe2Qv/AQo2S6ROzWm8mkbhSMXTdlJ8U
 pyMgDbYlOaFkSB+u4PFFA1NvLTbuNL9ewg0RBiPhmij/AiBRHw11DS7JSP63Po50rYF+U57uAzV
 gZ0vBbCzMUk/lfQCRDf9SmgwwZOSBlVLTEgP0HcUh20GZT5CopLhDdFu8KIfAcU4EQxGBrJRXPe
 BxUTrzEzMJnZjwoa/Vw4W+9KhwwnDbPGA4UXCwhZgmul/cbilEpf3PT27PSXFJRyE851S+ft0oQ
 XUXtXV2q53vvHimjPNciv3rvIebyEJ1EYV+pKsZRvY1Kobimrya011MEMRPj06btqhdaXqb86CG
 rPPxT0Anez4G8w0yCCgJbKOMIlCKJrhSOlejZmVCxN3kYyWzR0rXqK0+7tws1mDnubPxnNcBG8F
 7BJwwMluVnKXfSW+MozQJfT482Y5EqiLJ8bdB9yuO+QaniMXxnW
X-Received: by 2002:a05:6870:31a1:b0:485:d31b:775a with SMTP id
 586e51a60fabf-486e6de37d1mr7187523fac.24.1789867865863; 
 Sat, 19 Sep 2026 18:31:05 -0700 (PDT)
Received: from cachyos-x8664.localdomain ([167.89.205.219])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db449dsm3552088fac.15.2026.09.19.18.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 18:31:05 -0700 (PDT)
From: David Janice <djanice1980@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 dri-devel@lists.freedesktop.org, David Janice <djanice1980@gmail.com>
Subject: [PATCH] drm/amd/display: Allow 300 ms for HDMI FRL link training at
 every rate
Date: Sat, 19 Sep 2026 20:30:50 -0500
Message-ID: <20260920013050.21259-1-djanice1980@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:11:54 +0000
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

hdmi_frl_perform_link_training() gives LTS:3 a single budget of 105 polls
at 2 ms (~210 ms) that starts at the FRL_Rate write and is not restarted
when the sink raises its first FLT_update with the LTP request. A sink
that needs close to 200 ms after the LTP request to report lock therefore
fails whenever its LTP request itself takes more than a few tens of ms.

Measured on an LG C2 (GSM 49352, 2022) driven by a Strix Halo DP-HDMI
FRL PCON, DPMS off/on with drm.debug=0x2, kernel 7.2.6:

  6G x4  (3840x2160@60 10bpc):  LTP request at poll 11 (~21 ms),
         lock at poll 100 (~179 ms later): PASSED first try.
  10G x4 (3840x2160@120 10bpc): LTP request at poll 22 (~44 ms),
         no lock by poll 105: "FAILED - Timeout waiting for FLT_UPDATE".
         Retry 200 ms later: LTP request at poll 11, lock at poll 101:
         PASSED.

The sink answers FLT_READY on the first poll every time and locks in a
steady ~180 ms at both rates, so it is neither slow to wake nor
marginal; the total just does not fit 210 ms once the LTP request is
late, which happens far more often at 10G. On this system that is the
difference between reliable DPMS wakes at 4K60 and mostly dark ones at
4K120: hdmi_frl_perform_link_training_with_retries() retrains at the same
rate up to four times 200 ms apart and the output is then left dark.

"drm/amd/display: Update and revert FRL LT Timeout behaviour" already
allows 155 polls (~300 ms) for 16 Gbps and above. Use that budget at
every rate. With the change applied to 7.2.6, five consecutive DPMS
wakes at 10G x4 trained on the first attempt; three of them locked at
poll 104-105, i.e. inside the last 1-2 polls of the old budget.

Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: David Janice <djanice1980@gmail.com>
---
 .../amd/display/dc/link/protocols/link_hdmi_frl.c  | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
index 7f93009..005feb9 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
@@ -528,10 +528,18 @@ static enum link_result hdmi_frl_perform_link_training(struct ddc_service *ddc_s
 
 		FRL_INFO("FRL LINK TRAINING:  Poll for FLT_UPDATE.\n");
 		/*LTS:3: Start Link Training*/
-		/*Start FLT Timer = 200 ms, or 300ms if link rate >= 16Gbps*/
+		/*
+		 * Start FLT Timer = 300 ms. HDMI 2.1 specifies FLT_TIMEOUT = 200 ms,
+		 * but this budget runs from the FRL_Rate write to the final
+		 * FLT_update and some sinks need more than that in total: an LG C2
+		 * (2022) at 10G x4 raises its first FLT_update (the LTP request)
+		 * ~45 ms after the rate write and reports lock a further ~180 ms
+		 * later, ~225 ms in all, so it failed the 105-poll (~210 ms) budget on
+		 * most DPMS wakes at 4K120 while at 6G x4 (~20 ms + ~180 ms) it just
+		 * fit. Use the 300 ms already allowed for >= 16 Gbps at every rate.
+		 */
 		num_polls = 0;
-		if (link_settings->frl_link_rate >= HDMI_FRL_LINK_RATE_16GBPS)
-			max_polls = 155;
+		max_polls = 155;
 
 		while (num_polls < max_polls) {
 			flt_poll_cur_time = dm_get_timestamp(ddc_service->ctx);
-- 
2.55.0

