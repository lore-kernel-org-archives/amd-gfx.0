Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33FFC41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895872064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9VyLJfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895872064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C4EC6E966;
	Wed,  7 Oct 2020 16:32:35 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3CC6E966
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:34 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id j22so2396729qtj.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uh3kH2xExFEMBcGGZc33kB6JWULUk3g6pwFOjiequo8=;
 b=T9VyLJfrpuKjXynN9aQ0hYw49aaZKO+YhydjGsS3VaXXjMddIW3DbOAcxtY58qUlKw
 olOQswENr8l6Jm3Wjo9d0aA3e6sN/bG4KT8xe0IPXKjocb8NCtdAIuJvjohNx/dEyRSi
 +1s6K7IRHb0dT7OiaQOothfa88FomIiBpc08EasNjfsfs89k7i0eytZDIYdBakQ3Xqxa
 EoKS+tgsufhPluXS+yLn/KbMRqB1OT9RSi3LszFmg2tdu06BJsDdizDvqRxN+B6xCsDw
 sKEqI8XYRIull3iFHSDW2vR0h03coTT+41h/Pf2hOXE6t678lDa7m6gQOY6tlTcegAr/
 OiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uh3kH2xExFEMBcGGZc33kB6JWULUk3g6pwFOjiequo8=;
 b=eFhC3p/7BgeII5TBE+zmopv4V/93JP8Gdighm1VJdYvmkfo/WSHxHch3Jhdcz1t4kg
 2KX6PyRKIYfG53u7WNrBHH+33D7arxqjnWlbTGxsTO1l7NI46dR/GtvP06LcJC1mCgjA
 pLny5eo6dcMxs5M2jg67WhssvapuA2++aYUJY1MV/PxpNjZEW1JdjR6I+HipqMwgXBBM
 2xLAiMiJipN0tyX1FuchA6Y+cDGQueift8642CzB64PshWjO11U7UuGltMS36ywcYsAa
 NH6wkDnkWWMwJZtEEY55rgDGAJgdXBv0tqW59oEMJmSAtT85bLTKh5hODMheloBuiSfV
 fthw==
X-Gm-Message-State: AOAM531FmOV3z+q291yCr10Lw0X7tC+Kkc8exAgrqtWmAowtAgsKEZcn
 azBpUibGURYDzAuju/4440Ca4EgNur8=
X-Google-Smtp-Source: ABdhPJy/Ml1qqnz9RHNMikoSp7fpAdmuYeuvx1QbMmUKl4Q5Wg+bxxalc9mJu/7TvWdHZkvTehuS4A==
X-Received: by 2002:ac8:7088:: with SMTP id y8mr4146573qto.155.1602088352167; 
 Wed, 07 Oct 2020 09:32:32 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:31 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/50] drm/amdkfd: Add kfd2kgd_funcs for dimgrey_cavefish kfd
 support
Date: Wed,  7 Oct 2020 12:31:15 -0400
Message-Id: <20201007163135.1944186-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 7a1ff80cfb01..14c3f148735b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -77,6 +77,7 @@ static const struct kfd2kgd_calls *kfd2kgd_funcs[] = {
 	[CHIP_SIENNA_CICHLID] = &gfx_v10_3_kfd2kgd,
 	[CHIP_NAVY_FLOUNDER] = &gfx_v10_3_kfd2kgd,
 	[CHIP_VANGOGH] = &gfx_v10_3_kfd2kgd,
+	[CHIP_DIMGREY_CAVEFISH] = &gfx_v10_3_kfd2kgd,
 };
 
 #ifdef KFD_SUPPORT_IOMMU_V2
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
