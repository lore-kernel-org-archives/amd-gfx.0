Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5B6C369AB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 07:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E112B10E752;
	Thu, 24 Apr 2025 07:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pc1u1dCo";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96A2F10E671
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 13:05:56 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-39c1ef4acf2so4205762f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745413555; x=1746018355; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m9oP9LJHM8DzjFt7cBg3tIuMs1wKvIzvoJjs+/tJJ0o=;
 b=pc1u1dCopwLQ2wGoqRyKP/BrSJ6aCYH9PYRD5AmT2yp7+fGn/Ck1P5h+zmo0J8nlQD
 I0z+Y1mClhQm65d+vusw+ewPAj8lnCyXXZgqIK4ghjtNjfHnGC/+iIlkbyHbgay6ElW4
 zH2HpER1yrKCcju8QJLOCqlNcSUpMEe/5NE7OQu9TL14pIEYvyJPp7LGj9fJRn5fWCXB
 3mN/Ld+GVNPQNh6AKYiTrePJiXfWsvnIZI4L1FFm+c9CzVVVqFow00o4V2jdHVodSLgu
 AM4d/rzFzOHnpvFvGqBdFA6U9eJG+0mZRNHHXFGMbzJxvHEPN9kZp+IwmRvXVHPL+FNH
 aMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745413555; x=1746018355;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m9oP9LJHM8DzjFt7cBg3tIuMs1wKvIzvoJjs+/tJJ0o=;
 b=j95OgnnSZZq6jWg256wYPEFx0eD/RYUeayg+KiFC9/OXxW5CtpCNeAwj/p+2Hn833L
 wOyf3WmgTJ/VAevQoL1opTB14748uZgsYZBw5Y0vG/e3f1Gk12Zt7a/sGwZaSCbkDm5E
 Nk+K9RJYam+P1JC9ViZ+BCaKKBgvXq1nWqDBdtb6oqTbq6x4WrMkL7osXM/9HMqqQHQt
 7/LmXXkqJSlLQRXBm/L/UQ/oEwgaaHUCLnD/+9hNhP/F4/agoJsy9hfnR+GpauOfYn3r
 0F5ACOi72znov5KjD2JP+oZ9ZeKSwVLMZLDRz5yFdzqOJmTFJYlEU3uXvWJQ++BkSg39
 ai1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ8ad2FGFljIUINTi0bCwWpo3jaxrEvEbXo429qeGSVcum/swZE5GbR+CNflwJycBZfPL4XbMs@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3jlVKuDsu1uGyeoTpcz4ruPT231IHYPPZtvYx+MkJbldxjOYO
 BhxjXQpqBdfx8poFl3Jo8ddljkuBTp31aUVbSBGVSi+N0lOF5YAsvYFR3xTMpsg=
X-Gm-Gg: ASbGncsOZxRhA55m7XFu7zwcbAtpZ8UoRjKi3Ii1JkJoQpYABjqsPLYI8bdNKRw24Of
 H1Iiu1aWBR1K2NGCIsRqejPgczCv0qBnN6Sr9Kw/guGIuaqXg+StJScFNLgYzqrCdgtzF2n+6nh
 HGvaYj4SnH3A4mrcfiKHkDbqqG+mNuG1ZHdUpvUypKip9bWO70NGQOiH2EXw6oQnNsEJt1PQhNe
 WqxX7gkPXr7qjtaJIK2c+KniSTNKB1SLTj/wiHvwL5+EuDKDM12oc/fF16Pkb584aDi3txV77n+
 4Et/+g+BPFAiZvZkYLx+2AKJyn7WdPJ7V7mbK4e6Tbklvw==
X-Google-Smtp-Source: AGHT+IF+Rp6E7weSNY6LiqORC0ckeKnd04XPXIYVhl3AyYjDyluWx6i3Yijkjfv1CuYQAQkYNgPbXg==
X-Received: by 2002:a5d:64e3:0:b0:391:319c:1950 with SMTP id
 ffacd0b85a97d-39efba2bea4mr15216458f8f.8.1745413555050; 
 Wed, 23 Apr 2025 06:05:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-39efa43c079sm19060125f8f.50.2025.04.23.06.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 06:05:54 -0700 (PDT)
Date: Wed, 23 Apr 2025 16:05:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/amdgpu: Add NULL check for 'bo_va' in
 update_bo_mapping v2
Message-ID: <0becfa4f-252c-4ea8-9a5c-af1d94a186b3@stanley.mountain>
References: <20250411150052.3321230-1-srinivasan.shanmugam@amd.com>
 <20250422131726.3873364-1-srinivasan.shanmugam@amd.com>
 <7c581b1b-5174-4238-8a4f-1724e8977b45@amd.com>
 <306b6484-41a2-4ce0-88f5-a009c893de5d@stanley.mountain>
 <8e999c55-2c06-4b6a-abd5-1af96d3923ad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e999c55-2c06-4b6a-abd5-1af96d3923ad@amd.com>
X-Mailman-Approved-At: Thu, 24 Apr 2025 07:40:49 +0000
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

On Wed, Apr 23, 2025 at 02:52:22PM +0200, Christian König wrote:
> On 4/22/25 16:15, Dan Carpenter wrote:
> > On Tue, Apr 22, 2025 at 03:34:58PM +0200, Christian König wrote:
> >> Am 22.04.25 um 15:17 schrieb Srinivasan Shanmugam:
> >>> This change adds a check to ensure that 'bo_va' is not null before
> >>> dereferencing it. If 'bo_va' is null, the function returns early,
> >>> preventing any potential crashes or undefined behavior
> >>
> >> That commit message doesn't reflect the changes any more.
> >>
> >>>
> >>> Fixes the below:
> >>> 	drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:139 amdgpu_gem_update_bo_mapping()
> >>> 	error: we previously assumed 'bo_va' could be null (see line 124)
> >>>
> >>> drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>>     115 static void
> >>>     116 amdgpu_gem_update_bo_mapping(struct drm_file *filp,
> >>>     117                              struct amdgpu_bo_va *bo_va,
> >>>     118                              uint32_t operation,
> >>>     119                              uint64_t point,
> >>>     120                              struct dma_fence *fence,
> >>>     121                              struct drm_syncobj *syncobj,
> >>>     122                              struct dma_fence_chain *chain)
> >>>     123 {
> >>>     124         struct amdgpu_bo *bo = bo_va ? bo_va->base.bo : NULL;
> >>>                                   ^^^^^^^^^^ If bo_va is NULL then bo is also NULL
> >>>
> >>> 	...
> >>>     135         case AMDGPU_VA_OP_REPLACE:
> >>>     136                 if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
> >>>                             ^^
> >>>
> >>>     137                         last_update = vm->last_update;
> >>>     138                 else
> >>> --> 139                         last_update = bo_va->last_pt_update;
> >>>                                               ^^^^^ This pointer is dereferenced without being checked.
> >>>
> >>>     140                 break;
> >>
> >> Please completely drop that. This conclusion is actually incorrect.
> >>
> >> BO might be NULL here because bo_va->base.bo is NULL and *not* because bo_va is NULL.
> >>
> >> @Dan your script seems to reports false positives here.
> >>
> > 
> > I mean my analysis was only based on only looking at the function itself
> > without looking at the caller.
> > 
> > It turns out that it's a false positve because "bo_va" is only NULL when
> > the operation is AMDGPU_VA_OP_CLEAR.  You need to look at the caller and
> > also where fpriv->prt_va is set in amdgpu_driver_open_kms().  It's a bit
> > too complicated for Smatch to do this level of analysis.
> 
> Yeah that is true but I think that is only halve of the story, the logic in the analyzer looks flawed to me.
> 
> See what is reported here is this case:
> 
> if (A) B=A->B else B=NULL;
> ...
> if (!B) x=A->other_member;
> 
> The analyzer concludes that since A was checked before and when B is set to
> NULL then A must also be NULL in the second usage, but that is incorrect.
> 
> Correct would be if B is NULL then it might be because A is NULL, but it
> doesn't have to be.
> 
> I would double check the Smatch logic,

It's not saying it's NULL, it's saying it was checked for NULL.  It's a
check followed by a dereference without checking.  If I add some debug
code:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f03fc3cf4d50..2ff18a2e2e4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -112,6 +112,7 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
 	return 0;
 }
 
+#include "/home/dcarpenter/progs/smatch/devel/check_debug.h"
 static void
 amdgpu_gem_update_bo_mapping(struct drm_file *filp,
 			     struct amdgpu_bo_va *bo_va,
@@ -133,10 +134,13 @@ amdgpu_gem_update_bo_mapping(struct drm_file *filp,
 	switch (operation) {
 	case AMDGPU_VA_OP_MAP:
 	case AMDGPU_VA_OP_REPLACE:
-		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv))
+		if (bo && (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)) {
+			__smatch_implied((unsigned long)bo_va);
 			last_update = vm->last_update;
-		else
+		} else {
+			__smatch_implied((unsigned long)bo_va);
 			last_update = bo_va->last_pt_update;
+		}
 		break;
 	case AMDGPU_VA_OP_UNMAP:
 	case AMDGPU_VA_OP_CLEAR:

The output is:

drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:138 amdgpu_gem_update_bo_mapping() implied: bo_va = '4096-18446744073709547520'
drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c:141 amdgpu_gem_update_bo_mapping() implied: bo_va = '0,4096-18446744073709547520'

Because if "bo" is non-NULL then "bo_va" must be non-NULL as well.  But
on the else side it could NULL or it could be valid.

regards,
dan carpenter

