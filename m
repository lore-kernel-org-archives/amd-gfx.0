Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47120F33813
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 08:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEDE10E57F;
	Tue, 17 Mar 2026 08:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ous/b5CV";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E98910E336
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 21:41:35 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43b47b95a77so824803f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773697294; x=1774302094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O2nxslatvodyuswG7kMUtvBCCEm/H7jVAQ8TRNKy+dY=;
 b=Ous/b5CVndHwHyXCV5w4OP/8aPSPxVSB2ntaYSEyqAcjrZ01y7bUuei65Za2KYFep4
 qr6CKwK2zGKqFRn5fugUpQkr7iXOPV9RcGm3RUHqmtfzStiP4OHriouH6VRQEFtg9guw
 NA1GEuMIsNWvii3vo5osjLGCBleKqW/ai7rLUBGin9pcECc0jSrZl41sGhxMFT28pQmR
 7ABQ4+9i1mKbhvGmT/Eda14JaNrDBuKoDMUCrasLaBu3efqcy6/EpR3aUvQNgUwu2dYv
 y9FOj8hJRKi1p5ZYRb7XejhHXp3UkT97Qj+j9ooNA3jFs5MStOeYXfjSksKna0sbewRI
 bcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773697294; x=1774302094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2nxslatvodyuswG7kMUtvBCCEm/H7jVAQ8TRNKy+dY=;
 b=X5DKAPpm2UfPU/r/26vg5IKeTtCQ482vtn9mz9z5TcdywoMU8N9rudUczppnp1h7FP
 ZXqc8iVaQwnSdrnhbM6wPcuEmIVbDytisaXbQ6EOdJ1WTRI+ldO0ORmttCA6X5TmWnVI
 DZd7EGNRivtm6Fp40fxckykFOYi2QVC3ge6cIfuCfCp8v0yzaa12AaAMaTwbOIOIqeJY
 taJmcfMGojxRIqS2KfWTGjLn6GAYW/5Ymx3pC8bNBzGQ8lmWh+5WE6Und/EhRTmU1cxP
 I3Wt5C0NcRJC81Ow2UGy7Mxb35thPLiZPGhOtN6Vy12Um824O3gxCTXvtU34bpru1cyr
 V5rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcxvRAMgNM4LvhljbwEqv4YLrGTaJTidCOLTQycknhAq+4zXsMroAdAKF6cTdMd8Gy+QQzn1pC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqEt6efdw1wzXopnUJx0U47q4PUxbu6savXqqmMQb0fvByIrL1
 QxuJp2uS/DPupTqESATHLv9seRyKIHx9ub4awTu75+zQ3Fn3FNBzvswI
X-Gm-Gg: ATEYQzzjyPqg838r/MPm+DEVpIB+FaZ7Ubzr8VWuUeQJTIGGL/St/dB24XQCaaUTa2c
 SA43MM+ExZMmFUOM+Etw59IefCJ5cPIjteGrH1U8ceUnfmKYDYuROfx1WOIat90dWvQ7meTJ9qf
 Pt1mk32Llp/sUX0IHSrVcQ8ClXf4wOha7H+DtbVL2Atrd7F7UlUOoPnYP9Cp2cR9YXHyGi42gAu
 0SD6NtjVXwq2MjRdK+AuEMgZgjeUuYy/za3dBm79zprbEI8dosElLoz5kRl9QgV8EPGw1p9/Gbr
 KPBcrf6eIQhN5RK/Ehcqc5mCzdB+9SGMYSIE3YvMEqMAA8JfVD+B2e7wMSsrUZ47WqsQUyYCAfs
 0Rtst4968W6wqqahCwh4r9qtznHivInkUco/fc7SZh5oRuvjV5HKwKdHWDuhzjtfF+xiv/3So1Z
 WOalWoe05WcqM1WTSVqpDlbP/0BEyYZi6xsfTlK/F5tDuTmvFVS5hegUCUowkXFKUCSQ6DN5yom
 AXGPljjNCigDVYMxtyooIZl5dyo
X-Received: by 2002:a05:6000:144f:b0:439:c596:fa13 with SMTP id
 ffacd0b85a97d-43a04d84b22mr25944806f8f.4.1773697293871; 
 Mon, 16 Mar 2026 14:41:33 -0700 (PDT)
Received: from rhel.homenet.telecomitalia.it
 (host-82-51-8-214.retail.telecomitalia.it. [82.51.8.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b419270efsm14398934f8f.16.2026.03.16.14.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 14:41:33 -0700 (PDT)
From: Adriano Vero <litaliano00.contact@gmail.com>
To: austin.zheng@amd.com,
	jun.lei@amd.com
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Adriano Vero <litaliano00.contact@gmail.com>
Subject: [PATCH] drm/amd/display: clean up typecasts and ordering in dcn4_calcs
Date: Mon, 16 Mar 2026 22:40:41 +0100
Message-ID: <20260316214041.6275-1-litaliano00.contact@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:18:20 +0000
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

Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
---
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index ca5ac3c0d..3e63320fd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -12670,7 +12670,7 @@ static void rq_dlg_get_dlg_reg(
 			disp_dlg_regs->refcyc_per_vm_req_flip = (unsigned int)(math_pow(2, 23) - 1);
 
 
-		DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < (unsigned int)8);
+		DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < (int unsigned)8);
 		DML_ASSERT(disp_dlg_regs->refcyc_x_after_scaler < (unsigned int)math_pow(2, 13));
 
 		if (disp_dlg_regs->dst_y_per_pte_row_nom_l >= (unsigned int)math_pow(2, 17)) {
@@ -13226,7 +13226,7 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 
 	out->informative.misc.cstate_max_cap_mode = dml_get_cstate_max_cap_mode(mode_lib);
 
-	out->min_clocks.dcn4x.dpprefclk_khz = (int unsigned)dml_get_global_dppclk_khz(mode_lib);
+	out->min_clocks.dcn4x.dpprefclk_khz = (unsigned int)dml_get_global_dppclk_khz(mode_lib);
 
 	out->informative.qos.max_active_fclk_change_latency_supported = dml_get_fclk_change_latency(mode_lib);
 
-- 
2.47.3

