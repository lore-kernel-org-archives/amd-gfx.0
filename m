Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19799C4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 15:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971862220D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 15:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKbisV3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971862220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244AE6E895;
	Tue, 22 Sep 2020 15:37:10 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA9D56E895
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 15:37:08 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id q63so19421436qkf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FBQeuzBdoeUYefeWK5I5RVW/4cxtKJPST5wqYUjKjQE=;
 b=HKbisV3X53cmfJj6qE+M8k3se/RYdCXrVTy59EQjTj6o1EGT6sFerWo/UmgBZ83Hnn
 ttogvCtxIk0NRgLMUsU5E1LzrfjnjTldJakoben9fgCd5oQ6OIHiDNhZCS6Qnq4LQuEi
 z0ry75cXHEz5VTkJI1PPA7j8g/pqcjJPfgMtHzpyE2Js5cszwt02vx4BWD8Uy5lEQ9QW
 F1XXrXnwZqmf+/2lnE4TQg+Zh15OLKtl/y8oBjcEnexBn8j8rYH0oejQ49lCNvluWBQW
 LkgdxfFuPYxG4e9J3PbhWKXkNLE83z2IcNelZjBdJJ7sQB146+cpFWiLQHQr6l0mUhdL
 tLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FBQeuzBdoeUYefeWK5I5RVW/4cxtKJPST5wqYUjKjQE=;
 b=gjFbPluYbWMn9IZapnSENrv5rq0wo9j5vTTnkcZdUcxUSDRpUzx1/jjl527byRE8i3
 9ovw5065S8iRGl3rDZQ9Eqy/F7tvoe+zgTC6we489wx9K2+aowd3F9hksDJA3M2/PrnD
 FJZ7bICRYsWn5/8DKE4sGvhFVnACtIvuJ/PZQb6LBGBsHnyDmZLAF2gxxvt5qcq4mbaN
 5TsXQsTDlqPC7dy8VS5fj/Vs4UPTO97+PKn2/TVkc+PsazkRfEAuTLIpuouclH5rrs0w
 xz26/qNj0h2jAJ4gSTOB1gSCWMXDK6IyvI14kV2UWkpbF+klI8FHCfvcXheYRPKA9Y+k
 FqYw==
X-Gm-Message-State: AOAM530Ey0xxCwnh3K6GjXAPFHCgq8YOJtiw8PHnjcbwmushjU6tXX5f
 4fz1t54nSxucZfbAyY6Im9s+GPKPSjo=
X-Google-Smtp-Source: ABdhPJxE8VwCqp/hRKUzCfE32yb+xV8a1w3I0slBSNmX0CTNTU1l0fIuO5cGVD4c8yEFg6Tabiwiuw==
X-Received: by 2002:a37:ef04:: with SMTP id j4mr5092888qkk.187.1600789027644; 
 Tue, 22 Sep 2020 08:37:07 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id g4sm12248241qth.30.2020.09.22.08.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 08:37:06 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix CFLAGS setup for DCN30
Date: Tue, 22 Sep 2020 11:36:59 -0400
Message-Id: <20200922153659.465095-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, hyperkvmx86@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Properly handle clang and older versions of gcc.

Fixes: e77165bf7b02a3 ("drm/amd/display: Add DCN3 blocks to Makefile")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index 025637a83c3b..bd2a068f9863 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -31,9 +31,21 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
 	dcn30_dio_link_encoder.o dcn30_resource.o
 
 
-CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse -mpreferred-stack-boundary=4
-
+ifdef CONFIG_X86
 CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
+endif
+
+ifdef CONFIG_PPC64
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -maltivec
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -maltivec
+endif
+
+ifdef CONFIG_ARM64
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mgeneral-regs-only
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mgeneral-regs-only
+endif
+
 ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
@@ -45,8 +57,10 @@ ifdef IS_OLD_GCC
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
 CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mpreferred-stack-boundary=4
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mpreferred-stack-boundary=4
 else
 CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -msse2
+CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -msse2
 endif
 
 AMD_DAL_DCN30 = $(addprefix $(AMDDALPATH)/dc/dcn30/,$(DCN30))
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
