Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B817FC4727D
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59915206CA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBMsBv/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59915206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED206E9B3;
	Fri,  2 Oct 2020 15:10:00 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C3B6E9B3
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 15:09:59 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id c2so1636576qkf.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2020 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=csvZ97nzGVzywQ8znSxkk/uVr8GXxBozn0wpXbamdNs=;
 b=kBMsBv/HIWuqjvD8r6yyndHQ6HqXocaOqcKNorChne2kiddhI/sSRxb0mecoxXA0n3
 l/y2n3oOFGIgCDxv6nU7De3QEasVXGFaicXPhfjAB+b7Cv7pwcwza7r94fJidlrQWo7f
 hTRlqWjqC+77bCI1Yj8CMZK7AnE47T7USC/5Z4w3Vhbf/x7V3X3eFU6dBLjsGCbFNASC
 Hab4l/mK8F2/ZH1ZEl5xtRmEp7Tg4FwSjLzz/dn8oB1zzjQGqeiRIVmH/XtyuP+j2DDt
 4Y4o0dc8Ooz5Ym0JQn8GLp5aKhL9kx2Sfwa4l09Tw+OMlw6whlxWstFxxKQ5iezq/pHl
 iMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=csvZ97nzGVzywQ8znSxkk/uVr8GXxBozn0wpXbamdNs=;
 b=rYNPiH293YR7s4oBlLtF+cBon2y72iagfGcR42Gd2XDQ0jiTH3aQQqtmqxUdPKDgIB
 ytBdhD1gjq5PkLC989SPLkD8wkY5vLhSD3HpNmV1rl5u/a40PjqHZY0g33SJBNt2iS0F
 THFHUD4iFAwsTtmsXvfJ1RE880pQlay8wRZkKElEWIluUpIYtgkjPVcuIiO/lfaw36Y0
 oMvtvtnjRbNqcbmjquOkGSbdyXvuHDJgh9ayQ2FBmcLkxLH48YWp4asJ90v5xgJj4BuY
 iilK8ZzjAMaVx4taWpvej4wfjMN0w1ctkkmdkQhw/VL5NYgjf7P/z5LHGMynLY5eY6ly
 c6HA==
X-Gm-Message-State: AOAM531wfA/Zo/EjI90hklRdXQG8dgPxw7gx4+QSQJqwwVi25nIp2xKq
 k1NHUvSRvR78xPBfCqBcAAGbRRc9YRc=
X-Google-Smtp-Source: ABdhPJwG1izmkobLmVIHjRqjDUvZr/pplEmDpYyd9VxbGjjGRo8pwBE0ipOs164ePq8czD7aos869g==
X-Received: by 2002:a37:af02:: with SMTP id y2mr2581299qke.346.1601651398595; 
 Fri, 02 Oct 2020 08:09:58 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm1248435qkf.98.2020.10.02.08.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 08:09:57 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amdgpu/sdma: add sdma engine support for
 green_sardine (v2)
Date: Fri,  2 Oct 2020 11:09:38 -0400
Message-Id: <20201002150940.1103949-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201002150940.1103949-1-alexander.deucher@amd.com>
References: <20201002150940.1103949-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Initialize the SDMA IP for green_sardine.

v2: use apu flags

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 86fb1eddf5a6..e82f49f62f6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -69,6 +69,7 @@ MODULE_FIRMWARE("amdgpu/picasso_sdma.bin");
 MODULE_FIRMWARE("amdgpu/raven2_sdma.bin");
 MODULE_FIRMWARE("amdgpu/arcturus_sdma.bin");
 MODULE_FIRMWARE("amdgpu/renoir_sdma.bin");
+MODULE_FIRMWARE("amdgpu/green_sardine_sdma.bin");
 
 #define SDMA0_POWER_CNTL__ON_OFF_CONDITION_HOLD_TIME_MASK  0x000000F8L
 #define SDMA0_POWER_CNTL__ON_OFF_STATUS_DURATION_TIME_MASK 0xFC000000L
@@ -619,7 +620,10 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "arcturus";
 		break;
 	case CHIP_RENOIR:
-		chip_name = "renoir";
+		if (adev->apu_flags & AMD_APU_IS_RENOIR)
+			chip_name = "renoir";
+		else
+			chip_name = "green_sardine";
 		break;
 	default:
 		BUG();
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
