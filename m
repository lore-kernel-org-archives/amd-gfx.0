Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAE3C388F9
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 17:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D772121D91
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 17:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMqav19o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D772121D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 155B56E145;
	Mon,  2 Nov 2020 17:44:48 +0000 (UTC)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F2D6E093;
 Mon,  2 Nov 2020 17:16:11 +0000 (UTC)
Received: by mail-pf1-x444.google.com with SMTP id w65so11678597pfd.3;
 Mon, 02 Nov 2020 09:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=FiaA239A2PQwcQasT6cnNh3FC/zYFdQwcuNqSx9+MnE=;
 b=JMqav19onHdxHgN0cN+/6LBFGp1c/lYlCJS0cCzcGMtYJOMAqFmeF7FBbWDmMxzIqf
 BHCCtcEmTUg0SMmeX/vprtLJcU5+/hPf6PqySAqR+jVXVr9otFhM0rcbvEOV2EM3Aque
 FJf/yYrsRybLIkZ9wOEuTMi/8PFbNdzqKz9GPA/GWxh7XHUgErIA3q+pS2kNon+HtGw7
 WVXYyRd/vyn8GDD6u2Da1jYDOEDQjTTgU3Jn0M798NGuuM1YFfV71pKu651Elg1SyUrE
 jWtRs250nOXAgQTOXHEgzhfbmLpCV9jlOqII7p63G2NKFF68SkyX7f2TMg50o4m2HTP2
 amfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=FiaA239A2PQwcQasT6cnNh3FC/zYFdQwcuNqSx9+MnE=;
 b=PYi4UQ/rxnDre2SRS5b9w6wErxah1JSSUWrE8T1pLnR9e4zfl0s6xDvtcnF0F3h9UJ
 jVsLorC8NRpNyikjoecsU11aSs95/R2ZMu7DdCJ8DFKdg/RYwXlaV60dCuBdZRHZBd4f
 LoFhLOveVADciHfi4yx6ad9S1lMo6DzGTxiQsIpL5lbcHgJZLEDbItA0K3JjU9RvCB+G
 /ZczV1iVwh/Wq81JioU3Pox/g+GOCaTj6ayEDIYJ/6Ly13LJXnlR7y/Ufkg2u+2pkYgG
 Rn8YP9UBk+aqGfIXFpJC8gzW6ChJ1sb/leUAnqpueGr2/hHAqyVjPOkWqWf1+IsnGvfj
 BmKw==
X-Gm-Message-State: AOAM531zePHIwGHgEDeNLD7/COeHLcbV/aS4clv8Ftfc6TKrTP+3nzs0
 i/H+Op16M3T0RFxIDwrWkHM=
X-Google-Smtp-Source: ABdhPJzWUXbXlsx2BdAw8cQo90IiH2be5wSFJGPhmOzuExBRvWBjzU1BWzYb/P9d2vappgwJgNm96A==
X-Received: by 2002:a17:90a:2e07:: with SMTP id
 q7mr6193549pjd.103.1604337370937; 
 Mon, 02 Nov 2020 09:16:10 -0800 (PST)
Received: from localhost ([160.202.157.3])
 by smtp.gmail.com with ESMTPSA id q16sm4199061pff.114.2020.11.02.09.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:16:10 -0800 (PST)
Date: Mon, 2 Nov 2020 22:46:03 +0530
From: Deepak R Varma <mh12gx2825@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, gregkh@linuxfoundation.org,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] drm/amdgpu/dce: improve code indentation and alignment
Message-ID: <d644879c4cac32a7cbdbbeebc97c98efd421e17f.1604336791.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 02 Nov 2020 17:44:47 +0000
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
Cc: melissa.srw@gmail.com, daniel.vetter@ffwll.ch, mh12gx2825@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

General code indentation and alignment changes such as replace spaces
by tabs or align function arguments as per the coding style
guidelines. Issue reported by checkpatch script.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 5963cbe0d455..00f8e60909b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2677,7 +2677,7 @@ static int dce_v10_0_crtc_set_base_atomic(struct drm_crtc *crtc,
 					 struct drm_framebuffer *fb,
 					 int x, int y, enum mode_set_atomic state)
 {
-       return dce_v10_0_crtc_do_set_base(crtc, fb, x, y, 1);
+	return dce_v10_0_crtc_do_set_base(crtc, fb, x, y, 1);
 }
 
 static const struct drm_crtc_helper_funcs dce_v10_0_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 1954472c8e8f..80036f7ce560 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -2785,7 +2785,7 @@ static int dce_v11_0_crtc_set_base_atomic(struct drm_crtc *crtc,
 					 struct drm_framebuffer *fb,
 					 int x, int y, enum mode_set_atomic state)
 {
-       return dce_v11_0_crtc_do_set_base(crtc, fb, x, y, 1);
+	return dce_v11_0_crtc_do_set_base(crtc, fb, x, y, 1);
 }
 
 static const struct drm_crtc_helper_funcs dce_v11_0_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 3a44753a80d1..943976349346 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2567,7 +2567,7 @@ static int dce_v6_0_crtc_set_base_atomic(struct drm_crtc *crtc,
 					 struct drm_framebuffer *fb,
 					 int x, int y, enum mode_set_atomic state)
 {
-       return dce_v6_0_crtc_do_set_base(crtc, fb, x, y, 1);
+	return dce_v6_0_crtc_do_set_base(crtc, fb, x, y, 1);
 }
 
 static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 3603e5f13077..7973183fa335 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2498,7 +2498,7 @@ static void dce_v8_0_crtc_disable(struct drm_crtc *crtc)
 	case ATOM_PPLL2:
 		/* disable the ppll */
 		amdgpu_atombios_crtc_program_pll(crtc, amdgpu_crtc->crtc_id, amdgpu_crtc->pll_id,
-                                                 0, 0, ATOM_DISABLE, 0, 0, 0, 0, 0, false, &ss);
+						 0, 0, ATOM_DISABLE, 0, 0, 0, 0, 0, false, &ss);
 		break;
 	case ATOM_PPLL0:
 		/* disable the ppll */
@@ -2585,7 +2585,7 @@ static int dce_v8_0_crtc_set_base_atomic(struct drm_crtc *crtc,
 					 struct drm_framebuffer *fb,
 					 int x, int y, enum mode_set_atomic state)
 {
-       return dce_v8_0_crtc_do_set_base(crtc, fb, x, y, 1);
+	return dce_v8_0_crtc_do_set_base(crtc, fb, x, y, 1);
 }
 
 static const struct drm_crtc_helper_funcs dce_v8_0_crtc_helper_funcs = {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
