Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8DBCA0FF3
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Sep 2023 19:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C211B10E1F5;
	Fri,  1 Sep 2023 19:03:59 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3931210E731
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Sep 2023 07:31:22 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-99c1f6f3884so195824966b.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Sep 2023 00:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693553480; x=1694158280; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NRkr95h+/ONNstxBPFhhGqHm6f+phH7gUK5uTmvBHds=;
 b=eYFZNH52smYko6LXdCWtHdO/KerGTW7XOPLZKLeFfvIsNVrRNJcZZBgLejHyI5cFIo
 PWhbnn0N+swEiSy+7aInU5Rsvt5MRq1dR+xOkRzgmKE9X1bNEIRR3zjiDVHY+64J8HAV
 doUTr3uYczJfzT4nWhq6sQLhm+IcfkAvo1T37dqdBEphdDWejONOKr+D7aeq/jtTdx4Z
 BljOdYVneKayid2nuufv22Lt/Mk9Tov8/pEd1serKpqDMVM8YOzxIFd9adEd4cmtO5LA
 QLeosKogzQgYpZK/HLcEs7fgBCMJ0c47thuV8a3XLz368w/9xzsIVR0JPkGBhIFlNThQ
 msIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693553480; x=1694158280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NRkr95h+/ONNstxBPFhhGqHm6f+phH7gUK5uTmvBHds=;
 b=hxqX3AyheEvjC6Ze8pEmCvnb9HVfJ2xXi5UuylXRDuYKYUVYY6qKyQkb74DV/6bKG6
 dAMUfeev/mhYVQwsVyUPkDS2L9kW3CTm7H5T7TiQURDstJmjHDHhnAU/WQromqamJ1WJ
 zdrpoBLsEmjs2/8ETOvmCGt+VME/k90AhHVnLIdLcR8NQ4ZN0acmYUPCcPefgWIhqU/x
 Uf2qSsDimBaxxPV65/saLkkA2PopkX8gqX7fuHV5mJVDZqyx2esLNQl3Vuy3SyI5alAz
 gSDDnlrt6hcccwYIprBPgFzuEpxU4symxja3aRkzBikmxmTVLDdpr327KzJi2HG0etNb
 sIcg==
X-Gm-Message-State: AOJu0Yyksd3AlOXoE/oP9dfnFKRBHjmwbiFA3UU67oy4fNYH4HvAnR6K
 PCwk5kPwE7ZS1ptCldaOdZgLvUtzE5VsQpOX
X-Google-Smtp-Source: AGHT+IEuRzeZ+INl0StZfrh73hDpFcylH3J1oy028bnPu1qK7sgr+o96V77qqjKvcXwkC53OeAABlg==
X-Received: by 2002:a17:906:7494:b0:9a1:d077:b74f with SMTP id
 e20-20020a170906749400b009a1d077b74fmr1136272ejl.49.1693553480388; 
 Fri, 01 Sep 2023 00:31:20 -0700 (PDT)
Received: from debian-buildmachine.bernkas.tel
 (cpe-188-129-73-117.dynamic.amis.hr. [188.129.73.117])
 by smtp.gmail.com with ESMTPSA id
 ja8-20020a170907988800b0099bd5d28dc4sm1615947ejc.195.2023.09.01.00.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 00:31:20 -0700 (PDT)
From: Simon Pilkington <simonp.git@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd: Make fence wait in suballocator uninterruptible
Date: Fri,  1 Sep 2023 08:31:12 +0100
Message-Id: <20230901073112.2012-1-simonp.git@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 01 Sep 2023 19:03:54 +0000
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
Cc: Simon Pilkington <simonp.git@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit c103a23f2f29
("drm/amd: Convert amdgpu to use suballocation helper.")
made the fence wait in amdgpu_sa_bo_new() interruptible but there is no
code to handle an interrupt. This caused the kernel to randomly explode
in high-VRAM-pressure situations so make it uninterruptible again.

Fixes: c103a23f2f29 ("drm/amd: Convert amdgpu to use suballocation helper.")
Signed-off-by: Simon Pilkington <simonp.git@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index c6b4337eb20c..10df731998b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -81,7 +81,7 @@ int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
 		     unsigned int size)
 {
 	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
-						   GFP_KERNEL, true, 0);
+						   GFP_KERNEL, false, 0);
 
 	if (IS_ERR(sa)) {
 		*sa_bo = NULL;
-- 
2.40.1

