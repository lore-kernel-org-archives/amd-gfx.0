Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1991CD343F
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 16:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D5310EB9B;
	Tue, 12 May 2026 16:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cZ779KCX";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E6210EB75
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 16:27:16 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so3657757f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778603235; x=1779208035; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TmxuQpEJRXeKnWJ7ISt3nttPwwK0oBhYbP4DE9w9FFk=;
 b=cZ779KCXU0+OlZ3Ze2A7/CsREc5r1FvZRuJpaRz7fhv6Kean8RuLRGqYubuJtLcK1V
 X7qHDZcAFkkUEAFHOuJChpsTIlmK1WvuQawjgUsaGNsJmLUSS6XcKhdIzsr7TBP6Q1nJ
 aTgx31/ChiPiifbWzMqiiNrDPMHKn6xl0cVFpG3SxIP3LhnuQ/AiMwTXztWi+wqHuyDT
 eJDQQ4Q3wowaklKtEDyh8QsdnlT5lpg1xvajrvy71bnkfJSfLczrODQwPo6MM7NXX71e
 TQjhJmPiCo9HA+YEn+b3oqXGx77LZto7EdXEXePtDmV5jJczYbnXn4D1hlEXyVLDFu+/
 Redw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778603235; x=1779208035;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TmxuQpEJRXeKnWJ7ISt3nttPwwK0oBhYbP4DE9w9FFk=;
 b=KZrNkVE0DXOjQplxBYtJiIvoUXOPa8d8AXCg7mIJRpKN4TuBTemPpoGrCkdHdbeazf
 oPXGFhO2cHfrrUIWRwoim6Z38AIJlpz99PuvrTPr+GSVMPARk0PjBtXCx24WwYQ5P3tJ
 FRZmA68IDC3hkXYUuLNULH2PtoWQfCHE/cFIe7r7xF6MiO+AObapwaYCu7p8M3AvhIPe
 tZ2co4xrNzwufwH1EUU7q8ZID5aoTUkq9tNjLYeT7YFl9aHjbP2NO5niSFcYl6N+pDrK
 l5gEtm4B3F+fYW0Dg6XfUJ5RoiqsraA4ACEuxajB85ZPAHjW86RiSFaJ3l8jdX68FM+f
 eYVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dMMJXp+QgMFykQcYx2URKnuFQwOYt3/MnoyL1wMwsrQBcdMONOiiw4P9nrDP2SgI/u00osC2q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdGiiXF4YZZ+cMUPzJSVKjERAWsjVzpTuAexoJBxmIsCPknqpl
 3r5n6J0aCY70Z4TRD2rj9Hcux9IeYBrqL6d7Ir0sGHZBMV0Vrup9moNr
X-Gm-Gg: Acq92OEL9vVqIfTX7NZHfeKABp+uJJwJGfaNwQdJwpmDwzQJfMt/uHNSY6reA9ne++1
 KgqPp2OyWWjdDTTybCMM4XJK+Bvtk+lNJpS7zAv8nFZQKW++hSYRCjlXI7obIbA5A+KijS+zjfa
 KYI0HDHFgm9kAAn+1UwUQ+RkN6dC0XI5UAqYsAqfqGaBKIU86Xs6rgfk6U1qs5y1lAXuXKUIJo4
 MuxbJVI4BezYV+GHtE1BfQlbNVbe+/YItN3qf3AXE/d+JRC5SZWNE9c/ULuBdciPR8k6a4XUeBj
 D0ZLjfYhMMuAn8tbKNYz6A2AYR24yweve/Ku6OxpNF+rTbst10qK8KlXn5anDC9PxLgoFiE/R9R
 PQ9te27ObKXQtvYFZc4k0bKHRc6/TuScqojwbPBtTkOcqeMPxPayETB7Zmp1Yln1pgVjIJzQJsH
 CA+LypJdyB2saJ8avtuYAX7gPKwAqRZARkQPJK
X-Received: by 2002:a05:6000:420b:b0:449:4079:4c39 with SMTP id
 ffacd0b85a97d-4546310a45emr30198085f8f.29.1778603234650; 
 Tue, 12 May 2026 09:27:14 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b9:5900:3e99:f03a:ee63:3e8e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120ec0asm33019349f8f.17.2026.05.12.09.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 09:27:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: vprosyak@amd.com
Subject: [PATCH 4/4] drm/amdgpu: restart the CS if some parts of the VM are
 still invalidated
Date: Tue, 12 May 2026 18:27:11 +0200
Message-ID: <20260512162711.51118-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512162711.51118-1-christian.koenig@amd.com>
References: <20260512162711.51118-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure that we only submit work with full up to date VM page tables.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 10d8dcc3a972..b26f681527f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1280,6 +1280,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
 	struct amdgpu_job *leader = p->gang_leader;
+	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *gobj;
 	unsigned long index;
@@ -1325,7 +1326,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		amdgpu_hmm_range_free(e->range);
 		e->range = NULL;
 	}
-	if (r) {
+
+	if (r || !list_empty(&vm->invalidated)) {
 		r = -EAGAIN;
 		mutex_unlock(&p->adev->notifier_lock);
 		return r;
-- 
2.43.0

