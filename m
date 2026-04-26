Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B0CFF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D03710E625;
	Mon, 27 Apr 2026 08:37:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pxOFpbPH";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0524510E20F
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2026 19:19:13 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so6301249f8f.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2026 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777231152; x=1777835952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zhjzk6+k9bpCPC8O+MN7tV3ddOFfrvXcuTes7z8vTpM=;
 b=pxOFpbPH1jut33I/dJ+EdE/A2hzNU+Hl+z+B+Wmkcuxma7CTGnEzBDxsAEt0xuQsIS
 4jRFoONLDIUcp8/Y2ywwcc8tAxwavIv/J+KKziRhMR4BOdIPMYrORbFTNWJhAvByahlY
 whJlV5b9s1XLRrIo5EW/7ZKDnZWR+M+Q8OU1Snr1xn8v84iYFg9ydLP8YsXqD9zumq1Z
 B4eft2Xu8Ea186z/NtR8T4/Www1g6lHdHAjS84Jl745eqk1nKMGAnYdxxDyXjF31w50L
 G2YwLm50pBnUIK3XtJNBKN1jg331Z5ZUYqeXE7HpIQ1JojUxe5JEwLqfcdMz3E6mYqpt
 vIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777231152; x=1777835952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zhjzk6+k9bpCPC8O+MN7tV3ddOFfrvXcuTes7z8vTpM=;
 b=AyIzPj0PPM5h3856xoTeBb2+rELFW/3w/FdckPTvU2K9g62OxRgUgqrqprFDtzZ474
 WM5m6RPgKhkyDb6inAM1qLjeOTxutJu92qghB4nE7mj9Lav0j96FARUY2HwWiG8RtoFW
 0wEu+FNZwiWZPrBt9W3sgBy4L0IQCsFlkEZ3Ay0YnRbCCYH9SJMPK36I+V6eytAkZBVZ
 hiu6t7s6ImpHjddBdqra/WBUNUcdt1ggB6124ugQBb8rVQu8YmMcwtTDZI8p7/xhsSoS
 rqQxi0iZOE4GMhiCpCMOeH7OkfrRqjxxFB7shrkaKY6Bv80SCin4TDtUD8tUk4n2QQfE
 lzxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9coAfc6DPF4FjrbpqeBzrH2GRBvJbhucCMc2TRV3Xb7GtFDPHmkNZjmgIO161cLXM7mzYktE5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiLpLt0MTlb620SPM5TFWIOHXSw3J1d1PjMDKggHGh7L7DF0N5
 +r0+ANmBajQDHXLh0IudB7a7V8pkqCM9dNEGQvI3H2YJPUSBw+IJfMe3
X-Gm-Gg: AeBDievauvLJHf6aciz7pcXG1Y3adgFR4XEGC39tSLO8CYQegXNAiHkqu2O0eupDuVy
 LbPxDsYll9iNgtGMQ4oRdDk2g+LCwdwC8pUoSuNh6bHmi/U2Q2OWKgFAgKYb8EsRNYcIR1vKviF
 1AZsqq5qBkmETnzFUn/ek3zbIRa10Nifml8SVCiRuWYGT5WZHoiz5yH5badUAZnM2GqURSM+gXX
 sncJkDk9vjAU//06f2QE5OBpwmD/EhxRoTUyOiXxQE/Du2B7vbLmG0lRt6TMJZdonLt+rFbPtUu
 dG+ZmZToNn/HY9SxkYg4+JSjnpUifME5odRa4uOjrUzUB7LZ1mkppsC9gBcmWtGWfgAwlv4VEfP
 dAqST2/DprSPv2uit4R+lyCwDNCLlKI/9r7WiTR8GJkE+4SlyeQk+WIWWBegybTLOwd3OULAy/c
 UvCV9OcmNYuHvSEySoF3Eo1pQ67AXb7pVYwR9ST/pn42HcpCPNzUaSakkusZ5+mlyTMMcfljB2x
 FhR6SBBPYG2Jkol2VlcZEjH0qx1WCWbz1fZjE6wKWE86wNOEyM=
X-Received: by 2002:a5d:5f84:0:b0:43d:7783:c684 with SMTP id
 ffacd0b85a97d-43fe3e1e092mr63569379f8f.43.1777231152150; 
 Sun, 26 Apr 2026 12:19:12 -0700 (PDT)
Received: from fedora.homenet.telecomitalia.it
 (host-82-60-237-185.retail.telecomitalia.it. [82.60.237.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a092sm39057567f8f.23.2026.04.26.12.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 12:19:11 -0700 (PDT)
From: Adriano Vero <adri.vero.dev@gmail.com>
To: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com
Cc: siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Adriano Vero <adri.vero.dev@gmail.com>
Subject: [PATCH] drm/amd/display: clarify average bandwidth comment in
 dcn4_calcs
Date: Sun, 26 Apr 2026 21:18:25 +0200
Message-ID: <20260426191825.9727-1-adri.vero.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Apr 2026 08:37:19 +0000
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

Replace a stale FIXME_DCN4 comment in calculate_avg_bandwidth_required()
that questioned whether cursor_bw and tdlut bandwidth should be included
in the average bandwidth calculation.

cursor_bw is already correctly included in all four accumulation
sites below the comment. tdlut bandwidth is intentionally absent
because tdlut data is fetched only during prefetch and blanking
intervals, not during active display, and therefore does not
contribute to active average bandwidth.

Also clarify the phantom pipe handling: phantom pipes are excluded
from sys_active average BW but included in svp_prefetch average BW,
which matches the existing code structure.

Signed-off-by: Adriano Vero <adri.vero.dev@gmail.com>
---
 .../dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c  | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index ca5ac3c0d..34a2a8326 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -2845,8 +2845,14 @@ static void calculate_avg_bandwidth_required(
 		dram_overhead_factor_p0 = dcc_dram_bw_nom_overhead_factor_p0[k] * mall_prefetch_dram_overhead_factor[k];
 		dram_overhead_factor_p1 = dcc_dram_bw_nom_overhead_factor_p1[k] * mall_prefetch_dram_overhead_factor[k];
 
-		// FIXME_DCN4, was missing cursor_bw in here, but do I actually need that and tdlut bw for average bandwidth calculation?
-		// active avg bw not include phantom, but svp_prefetch avg bw should include phantom pipes
+		/*
+		 * cursor_bw is included in the average bandwidth calculation below.
+		 * tdlut bandwidth is intentionally excluded: tdlut data is fetched
+		 * only during prefetch/blanking intervals and does not contribute
+		 * to active average bandwidth.
+		 * Phantom pipe contributions are excluded from sys_active but
+		 * included in svp_prefetch average bandwidth.
+		 */
 		if (!dml_is_phantom_pipe(&display_cfg->plane_descriptors[k])) {
 			avg_bandwidth_required[dml2_core_internal_soc_state_sys_active][dml2_core_internal_bw_sdp] += sdp_overhead_factor * (ReadBandwidthLuma[k] + ReadBandwidthChroma[k]) + cursor_bw[k];
 			avg_bandwidth_required[dml2_core_internal_soc_state_sys_active][dml2_core_internal_bw_dram] += dram_overhead_factor_p0 * ReadBandwidthLuma[k] + dram_overhead_factor_p1 * ReadBandwidthChroma[k] + cursor_bw[k];
-- 
2.53.0

