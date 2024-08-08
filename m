Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACA8C52D71
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 01:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A7B710E628;
	Thu,  8 Aug 2024 01:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="KVk5By7f";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1306510E619
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 01:09:12 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-428098e2b3bso474925e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 18:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1723079350; x=1723684150;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpIJdjd0CtOYwi1e6d++M44rLj76XEv3/lIfKK92osQ=;
 b=KVk5By7f/GBzSXh91ZjU+FH+tUTVDwEoGQeKXnRzPKrWFhQBH/bIyBHiqCf2aG92TC
 3LqhSEzxjyU3v8XSbD4xIx1ACPm+7KoGCoWytk9apXh24cdBZAmBDWXwgumrYShspGaY
 /DuY8mkc9o0Olh5mh/uJZ57i5+geDf6m/yj7q/nO3BME0cMvm9aDd9XJlUDurzhdVNoM
 fo0GEzR+AKPt9s+QGom+RSmHszNTiQK48djn1sD3a7nmNj+Ylf6GcvVkt8mleNJ0+MAa
 uejjsD2XAuGvWZ8UPswINbkmDBg8yPQLbcs+XCnOrFqFCNxtUDKsh3PvWlOlwDRjbTdl
 Wu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723079350; x=1723684150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpIJdjd0CtOYwi1e6d++M44rLj76XEv3/lIfKK92osQ=;
 b=boToljnTQNHxX9qSPqh5UTR3ZXApmqC6zEvviDc1yffDcoZt45LMyzuGO+LCwkceYu
 ySxpSEnBJxji31AI7QQzkHwbgQ3JPv8kQTprnEXGnVIOjwDo/8j4QfbGw9bYYwrwsxGs
 YCmASgvY/VmI6MtqGKiy0+RSWXyB+Gd+59wPKaDs9l8iduHdswAU4X9u5VK2rvjGPVw/
 JRCA2mTxtuL9/GuWx3WJ83cKUTJl7ZyHQ7QdPtarMFwvL4O7RA+LGUAhUPDqoFuAgdR8
 NPGyZMEnMu6wCV1N075kGH1PhX6rhp5KPxIiPdmVmr9x8j7MvQ6RBS31A4aNCkM4V68L
 XPNw==
X-Gm-Message-State: AOJu0YzX3ZcMmoXS/hKO+rcQsugfqHnr++BNgrXGEgMVnUjDw9b+BAgR
 DoXWqjG6OMbMo7LXphOD7KLLMEL/JPsAa3kJER9asR0HwdZL1BdoYa1P8inEyJ98WzEckO0zJng
 JT3Y=
X-Google-Smtp-Source: AGHT+IEAlNz59m+91anWh4GHQXc58g4dm8FxHbmzv5EhZhFySUp2Wrr8j8Lb1EBtvXRjCcIkHDxwmg==
X-Received: by 2002:a5d:47c7:0:b0:368:654:932b with SMTP id
 ffacd0b85a97d-36d27522613mr98283f8f.4.1723079350028; 
 Wed, 07 Aug 2024 18:09:10 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a781:a500:aaa1:59ff:feea:fd4f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d272095b9sm240753f8f.68.2024.08.07.18.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 18:09:09 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, airlied@gmail.com, faith@gfxstrand.net,
 friedrich.vock@gmx.de, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 3/6] drm/amdgpu: Check cs flags.
Date: Thu,  8 Aug 2024 03:09:02 +0200
Message-ID: <20240808010905.439060-4-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
References: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Had no validation before. libdrm_amdgpu memsets this, even
for the raw/raw2 functions.

We have a lot of functions touching the ioctl struct, no
strong opinion on where this is placed, but I thought
early would be good.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b4f55f40ce0e..8d6f42e308fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -185,6 +185,9 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	int ret;
 	int i;
 
+	if (cs->in.flags)
+		return -EINVAL;
+
 	chunk_array = kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t),
 				     GFP_KERNEL);
 	if (!chunk_array)
-- 
2.45.2

