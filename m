Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD113FF886A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CFFA10E62C;
	Mon, 27 Apr 2026 08:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IFbcKvXa";
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B680710F5AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 14:08:20 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-4233e152457so5588174fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777039700; x=1777644500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Awi4viU8NvHRlCqV4pUg2d0xyjRYURsNTCZSqlhhrUI=;
 b=IFbcKvXaihoQFRtDhH4tAzVc3IeWELWNGdThrJwq9l8J/mJtpo9tUbSEHg7kik18KY
 ueTr5bvAitQMiYXldukBjUiIGTllXXvrvazTxzSOh85qcthjCWY5pSQioCnyvrn2zkAg
 aHDpXDliYIF1heIAm8WSL13jmWne5JBTY1p6Cs8wiNhXCI027EoSMcatYpYGR6Ociv3j
 oOIEEw5D+sJo9sSYoOy6toKzb6N8URwrQwLkVQ+sc8B3zAgLE2iNEy3rYRCSMc/VVzrU
 U+fWG3kf9ixPSAbwmIFpL6JsLEVM9BpSJIWxRVXJDRQu1jr1PHzz90jSCtUV34oePREc
 D9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777039700; x=1777644500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Awi4viU8NvHRlCqV4pUg2d0xyjRYURsNTCZSqlhhrUI=;
 b=A7C5FoD2ksw3s8JJFW1/mTWU5xzhwtlgpBhtriDfix+PYWA7Db9v9JPXZVKKk2EzkK
 bzJLHv40rnmOv8K7pYJqLuNGok2DS1ZqQZ6BqWruiel63dgGxlL/BRtXYpoI2V128zDK
 9KLp/ErUKCS7xqoZ3GOXMWkZNRstAyl0sg/ldkcIdxv4aCTVwlRUhsGey5piOHMqb2wM
 Jcyv1LnSGhBFxglSKuQ0jcAIGJkX15voBan0ojjacu3EJp1uCBmI+d4jzW1GBeqC3o4N
 AdkaXBpnReLuKTNXGBCbCm7l44O0yGMWz2KjmWRYdSabBGFZ7Eeiq7nIiVE71KGTmTtO
 BSqg==
X-Gm-Message-State: AOJu0Yx6mGS7uj5BLWdFF4CUZnCbyvB7qBXrqE114ZNA29q28b/kE/NR
 iPlQVI1ZUE8PhtGgn0+735Lbolzd4bn/bWkAiAUU/pFz5YXWqqWtgPY=
X-Gm-Gg: AeBDietw6qIvgyTgZiDQVyYd1D5IBrT1uG7bhty2NdaMbfsnPSUauxZ4wKFWEwHXJib
 yQ76gsTx53BW/PR52EoqXOuMFyOlNaoKd150IMYaMfty6TY9qrg/XY4dJSbo5/lOGnvknNhpVOX
 SQE0Eatkfb+pCj6zpY7NQC8ZfyhJ4oaOvYXb/fSIbF4yeaSozQSq1Cendz88mWlsmJW7WkaI5Q0
 wac3rNc+cxbfwN80iIavvr9wV/bnK/UtH83Gc2jbsOm0OYeM3o78a9Wtxpye3xNe4OUG4hSiNsF
 yNL+9kTiU7/B9/VrFrNDDwkZWAcaz3sjnR9ma/de0Ht1/MvItGZ7Dcn5VeOfhxXXmQBiW0gFBoc
 hjxhRJnp+E/pZ/5A818KYZxRI6GnQ8wQWcWOx1NEeGb85D9p4cvcEK3TEEV6/b2FkAAZJL61vp/
 VMe+qnqn2prdaSsbbASQibxW9NiPQ5sQF0FWF35vVa0Nu7csx4GWCoiK77Z/BD4mtlz1VySC59R
 EwBX/FOejA4Pe77C2SP/jwMoomxG/RhjAg=
X-Received: by 2002:a05:6870:9109:b0:42c:f89:7555 with SMTP id
 586e51a60fabf-42c0f89783cmr10667903fac.11.1777039699909; 
 Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a2dd1sm22228653fac.9.2026.04.24.07.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:08:19 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, stable@vger.kernel.org,
 "John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v2 2/2] drm/amdgpu: remove superfluous BUG_ON in
 amdgpu_cs_vm_handling
Date: Fri, 24 Apr 2026 09:08:16 -0500
Message-ID: <20260424140816.43766-3-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424140816.43766-1-jbmoore61@gmail.com>
References: <20260424140816.43766-1-jbmoore61@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Apr 2026 08:37:19 +0000
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

Remove the BUG_ON(!bo_va) in amdgpu_cs_vm_handling() that is
unreachable: bo_va is assigned from fpriv->csa_va on the line
directly above, inside an if (fpriv->csa_va) block, so it is
guaranteed to be non-NULL at that point.

Signed-off-by: John B. Moore <jbmoore61@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 53f537f3e..556c62948 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1137,7 +1137,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 
 	if (fpriv->csa_va) {
 		bo_va = fpriv->csa_va;
-		BUG_ON(!bo_va);
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
-- 
2.43.0

