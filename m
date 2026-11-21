Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9F606A32E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rk9DGLtZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F346010E720;
	Mon, 23 Nov 2026 08:30:10 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6902110E113
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Nov 2026 03:02:54 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-38699cf08dfso512912eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2026 19:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795230173; x=1795834973; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Guzi9+/70idztYEfgK/lQL3nqGfBTC47et0quiLCDzQ=;
 b=rk9DGLtZHBMcnfKJGS/kFnWyV4bYn4nTV1+DrQ1BpjPyQ2jVXikKflaEkV6onVJVcI
 HDmqTZ/KLeFmt6jC3GjWI7isAKRGRIicPAqbpVxDE60632Trnh09m0FtI35ysEI4a7Un
 VP3Ns2xh+59K0O3ySwGPkHohWc2FsU5UoVEpjcwTFEuu6RRJCnfCntQIrQjO3/mPWa7m
 DCRvxAWCrnUbGmT7hA0lhjFDpnozXD+YM7UEX5/D96tbpyPzeotrkE1gv1bD3Le4Tw6S
 ifweeOcxnPDJuOOEGYrv64MWacopGSiDWZK2s1bMcn9CNxLh6h3e/Vv3RXCqZ2+at4fI
 58GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795230173; x=1795834973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Guzi9+/70idztYEfgK/lQL3nqGfBTC47et0quiLCDzQ=;
 b=ELZNM3dONW9CzCT6RrhnsOQkXpup/esw8VwIoAslBhFWiAJTcBXJ/ueVI4NHqR4P9c
 ikkMJSCytjaefyoGVVtci6UVkDAfbQAg0NZmZEeKPM9ayWW6tJ2ephQnuKko1JMjJUWl
 IazAXGLmFUFMv8EmT9hEgWu4VncvZmirajoa/HJJTXaCW33tGtpNy9ZMwZfUdLGQ9yBC
 f98l5yBtUV27HNcaasAcs4e8l3PE71xnNP+I/M7fGSSjHPvJz2Y+JzTdMCPLVgGptS2D
 RCpa+6nKvQoy3FmKnm65LG+w3O/CabLgFh4XeKhUJuGs3njEyXfQ4MFzIxp7bYJOT/7L
 B6Pw==
X-Gm-Message-State: APuU4Z/uWDuAt6abHQfFHH2leTUBbcbsPiHqkUP2lmCzLacSd3sWtjM9
 7ThWufYbOcYXmsBls0m1vXKnoehQqIPjgrFxLJI02A18ANrCUyM5Dc13Z5PrcXWl
X-Gm-Gg: AZFdTZe+iC8F8PzGlhlV4Is5hPWZbIOaLnBOKTZ+OkwoqW3D1GfG+/rv7qSm8TLw4bv
 QTvK4nCTQtq8wPVPMbtMnz93CG3magDhevYUTXuSJja6FWoyxUBUcgooKLsAJ4ugQwmNHRtTcjY
 mUpced73Z9H+4kRjJLROeNPoPc+44p5SyFivwCaut7iwEe92TpQAJUGzm0qTL1rRmhipvXYz44+
 DS777tRaJFit77+UCDB+PLqIkjQpf82laStvID4HHEQnbpPi2x09SKnUnVLG7JoD0bN88a3pIqm
 SU1npUnwPI0qrFqmrMIBfyELpAIy2FGNxUQHUpJ8JJI8/qJJKZYduhZ9IfHotv49cPsrHfK/trt
 eRHvwsEAA3seZYwB5B+TkP1CUYB/JQF1jGL3Z4WXxn24AhBV8TXDw1+NX3Plk7xmkByPk9skgv3
 /W3NFmMK1x7KzNVfcYXUgscTAD3YN4xmVGxjhgNsXrNe+J8pKqOG9cpmfCpWTu7YmX0PLIlJ0/t
 sNB8cILjlbxl7Ro4dxWn6Erk+MDfkQaIlgmvomlNBJpV3OR9bT8+/NTOUBt+ekJ5cdUuipGmCPT
 gnfZ163FVlI2BBye3dBy
X-Received: by 2002:a05:7301:1806:b0:381:4b4b:f96c with SMTP id
 5a478bee46e88-38570450b07mr5162511eec.34.1795230173484; 
 Fri, 20 Nov 2026 19:02:53 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm11651970eec.0.2026.11.20.19.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 19:02:53 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Candice Li <candice.li@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu: Document parse_psp_v1_bin_descriptor
Date: Sat, 21 Nov 2026 03:02:50 +0000
Message-ID: <20261121030250.1674303-1-takano32@gmail.com>
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

The kernel-doc comment of parse_psp_v1_bin_descriptor says what the
function does but names neither of its two parameters and does not
describe its return value, so kernel-doc reports:

  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:4440 function parameter 'desc' not described in 'parse_psp_v1_bin_descriptor'
  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:4440 function parameter 'hdr' not described in 'parse_psp_v1_bin_descriptor'

Describe both parameters and the return value.  kernel-doc prints each of
these warnings twice, so the file goes from four warning lines to none, and
from six to none with -Wall.

Written with Hermes Agent, an LLM assistant; the author reviewed it and ran
kernel-doc on the file with and without the change.

Fixes: 581ada8f9bf3 ("drm/amdgpu: factor PSP v1.0 firmware bin descriptor parsing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608210800.S15sl61g-lkp@intel.com/
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 82a2684dbd2e..3fd93cb1e634 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4435,6 +4435,9 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 /**
  * parse_psp_v1_bin_descriptor - Populate struct psp_bin_desc from a
  * v1.0 PSP firmware header (standalone images such as ASD or TOC).
+ * @desc: the descriptor to populate
+ * @hdr: the firmware header to read
+ * Return: 0 on success, -EINVAL if either argument is NULL.
  */
 static int parse_psp_v1_bin_descriptor(struct psp_bin_desc *desc,
 					const struct psp_firmware_header_v1_0 *hdr)

base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
-- 
2.53.0

