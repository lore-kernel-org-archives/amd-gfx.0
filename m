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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D315C41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A4E2064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3EEsEvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A4E2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3066E956;
	Wed,  7 Oct 2020 16:32:52 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E72A76E979
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:50 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id o21so2420956qtp.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=80fccle5uMb0KOag9oSlBj+vfwP4PJxiTgj0KZ+cNjA=;
 b=P3EEsEvIMXwwXkE+ICdq0b15SXd9bRVJkLZW+nEzM6xWVR2vKbiTEaq7mA6qqbXXQ6
 d+A57ClAMcpvKP7tXospFDisG4KHsV9vWIr5kefsr8iGc4s21iPYUx/BkOM6JxMwUIr7
 r0oXqZQcYLUhMVZemn+9UvN9GpYg1W1+/6rn1w4fIti0aq6PIc+I100couooZ+V4MeJI
 fM6GdbGqDVCfO5g/dJMpPvJFriGszKYn1umVtIETnV9ZuVsEjk73h1vjy7/z0/z03G+q
 5uHSd25lmZwLrfw2xS57uUecd9cMaU6spg24UK6QPqYmj7uBxQ/ercPpK9gTNSfAQ/yU
 6Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=80fccle5uMb0KOag9oSlBj+vfwP4PJxiTgj0KZ+cNjA=;
 b=Vp7ihLDxvnWO/wQuHU2gJ429ZLEW72qhioWOE9H+bNjj9ratRAUi2nlkfqeU7Hrfoy
 KTDXJgQHHOQM7H7jeLRXALPlIJkn7rJq5hXH78sjzDTp6VXZUaM2hM59gTJ/KuFbHN/L
 UwfjJpr7Wycf2SC68LshZ6f78VDwjHMAjQpxQXNdj4Eh/flItIymQRKFs5EIP09IcNBl
 aIA9zsLGzuO7zI+rk8rlrTk9G/dDFe4wrKjSgsXUGHGxeyOnpzcouC1LUrL8TvcgLbtn
 LArt/5Rhrp6CjGllhbX7vKwQ5Qvf+921hPerGyG8ZRB7BsfmellJyHP0ODqeSKGY3fc1
 t30Q==
X-Gm-Message-State: AOAM531Un+XJPnKqWX12C8ixBoKegC+GDzplIN6f6ZyPGV9aLrRcaekE
 foY7pUfMZxJhe9MIKB21VxSwk033E44=
X-Google-Smtp-Source: ABdhPJzbELjxXWdyzTEEu68+1foOz/vaHMg4FbW5JLWeK0RWOJXwOrhcq5rOcJvjARH6hoOdnVNsgg==
X-Received: by 2002:ac8:6e90:: with SMTP id c16mr3973418qtv.391.1602088369953; 
 Wed, 07 Oct 2020 09:32:49 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 45/50] drm/amdgpu: enable hdp CG and LS for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:30 -0400
Message-Id: <20201007163135.1944186-46-alexander.deucher@amd.com>
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
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Set hdp CG and LS flag for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index b8b9ac722b6d..c73ad0482022 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -917,7 +917,9 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG |
 			AMD_CG_SUPPORT_MC_MGCG |
-			AMD_CG_SUPPORT_MC_LS;
+			AMD_CG_SUPPORT_MC_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG |
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
