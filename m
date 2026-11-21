Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8C606A33B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xlzPZIyR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0814010E724;
	Mon, 23 Nov 2026 08:30:11 +0000 (UTC)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF8BA10E05C
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Nov 2026 05:24:49 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-14394530ec6so2464157c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 21:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795238689; x=1795843489; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vrAH11RxlITDJuS6ccKcKd1F7cmDmkL8RNwIxF0LPl8=;
 b=xlzPZIyRSnc9jpUgln19F7RedUGwhQ7p/EjO1AZ6JtRTFW4WsIIj/sdkPE6fdp9Zor
 aVkFE9Ab40DsP6qgpmho/ogAx6m+Jqq6CLbLavmtecQcRslQfd81py+dkRoT1k0X6dzc
 ueb9cnv01PHeADQxK1urmGoHzX/F2nVqnIqd7ly9pAcZOIU8l+DMQphM2IYwSfI2qqT9
 XLpBml7NijRUAgBfad3fA6WR9naKWRGN+pVAQp/oyOXCxPEsMtlhiF3/YwelJBH4mFhL
 TTM3Gc3rCcQAPm+82cfGmuQTkRW1aXNdhcEj8GwsQbLUhWwyNoQPcTodX5KkPB8e+0HO
 PSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795238689; x=1795843489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vrAH11RxlITDJuS6ccKcKd1F7cmDmkL8RNwIxF0LPl8=;
 b=PLEQaF1/i0pOwCdimIxAJUl+up7A/cyzh5fr4pE8EMwbiTk868HW7tFZ8FGzwJsiAz
 3R03dwJD0AX6KVzj57HwwF4vK37UB3bwgmt5dhso2a1xAPEHDL1OhDVd8zDIhaS09p89
 TeC1rBpDSLZzayQyEwdYvGxuK3p3FrKSP4Ans/uysGWA9xPxPUfu+Q+WAPWqToK2hh7U
 GMiaB/ecBCFME0yRBJrHKlRYB45eYk74lbxeVKsPKNSyEBRjbUHe39abBfv5MAs7AWFw
 AkS/zFQXe2h5Xo7qahzy25H/WuxvWctb3FDCfc9hTonK33kLnEjc4ovUgyNNhbyY2lQX
 sQ5A==
X-Gm-Message-State: APuU4Z88qygoDvSKt/RGTysmL/R0taISK7I9nyVLvWkRumWGvyhfhvAU
 P2aeis1/ykBxwtQN6u+FBwfqv/LEr7PFvu+PWIBSE+EVEFxYHX6dZztV6/Bl7+tM
X-Gm-Gg: AZFdTZctgAG+MEvilX6MrTHU8Q61TqC1tVTZ4SPxgZGPGyOyVdSHtEB7e7r840RCcfi
 OD8AHrNbd9TSiQUwUlNXnkfkpV+LvY+oRFnvaLbbXrJI9wuqZw9CrjXaR8hUqHSs/H60y5N9ONM
 UaFcGaML6DTfrUEdH0qdvNSKqR0mxOwdT9R2XvWauxybIb1DNjxyGSvtLd2NIBTLybXlgeyVFyr
 gbNUR0KLDbGrIK+plms0WKHS3m4A0puxII9yzLBU394OF5W0XO8YqaUcqm7L/nzofG+niYl1I4P
 xJLO4/1914MBMgq0WGPFQLTTcRNnqaYQgy4Q67KlIBrq2hUBL3B0Y+M1TMOny2jIQOE12RFIQTg
 haxV3zWCldIcdJPWKJ6dfALKjqfNOKnhaUevw98AvCr74fM0bnOYCbLvqUQk+Tv2fSXp4m6LH4h
 uUGpG7My4ckXzvof6toq3kOgi9gX+lRidUtws/gUZMb01L9HTduj9+5mNk99+7ZzFPHPD7ZYcJV
 BuD86txzR3Q1VOVZihIANF6PTbuF9RYjCmt4JgRaW0r4nl1pRIqRvx8yPM5mj4Bm3iCfo4xTxgx
 2n73GtaZPol+QKDm6NPP
X-Received: by 2002:a05:701a:8148:10b0:143:2719:f800 with SMTP id
 a92af1059eb24-1b556908ecdmr4821202c88.40.1795238688807; 
 Fri, 20 Nov 2026 21:24:48 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556829d31sm19330849c88.9.2026.11.20.21.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 21:24:48 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] drm/amd/display: Fix spelling mistake "pre-definied" ->
 "pre-defined"
Date: Sat, 21 Nov 2026 05:24:44 +0000
Message-ID: <20261121052444.1797470-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 08:30:10 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Three kernel-doc lines in dc.h spell the word with an extra "i": the
@dgam_rom_caps and @ogam_rom_caps entries of dpp_color_caps, and the
@ogam_rom_caps entry of mpc_color_caps.  No other file in the tree has
this spelling.  The @dgam_rom_for_yuv entry above them already uses the
hyphenated form, so fix the three lines to match.

No functional change.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
checked that the change touches comments only.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..3492ff0af1ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -250,8 +250,8 @@ struct rom_curve_caps {
  * @ocsc: output color space conversion
  * @dgam_rom_for_yuv: pre-defined degamma LUT for YUV planes
  * @upsp_pre_scaler: Ability to upsample 420/422 before scaling
- * @dgam_rom_caps: pre-definied curve caps for degamma 1D LUT
- * @ogam_rom_caps: pre-definied curve caps for regamma 1D LUT
+ * @dgam_rom_caps: pre-defined curve caps for degamma 1D LUT
+ * @ogam_rom_caps: pre-defined curve caps for regamma 1D LUT
  *
  * Note: hdr_mult and gamut remap (CTM) are always available in DPP (in that order)
  */
@@ -310,7 +310,7 @@ struct lut3d_caps {
  * @num_rmcm_3dluts: number of RMCM 3D LUTS; always assumes a preceding shaper LUT
  * @shared_3d_lut: shared 3D LUT flag. Can be either DPP or MPC, but single
  * instance
- * @ogam_rom_caps: pre-definied curve caps for regamma 1D LUT
+ * @ogam_rom_caps: pre-defined curve caps for regamma 1D LUT
  * @mcm_3d_lut_caps: HW support cap for MCM LUT memory
  * @rmcm_3d_lut_caps: HW support cap for RMCM LUT memory
  * @preblend: whether color manager supports preblend with MPC

base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
-- 
2.53.0

