Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207DC4332B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 03:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534AA20768
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 03:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juAR90r9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534AA20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E676E981;
	Thu, 19 Mar 2020 03:15:53 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 672026E981;
 Thu, 19 Mar 2020 03:15:52 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id w10so930885wrm.4;
 Wed, 18 Mar 2020 20:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qXI23a1IwY3ie8JXqjTRuDBwO8bkem8ij+8i6dgXZmY=;
 b=juAR90r9kj6szrVeLjR3TGTvGt/zMcldxYmJn8U9QYj+8QdhVaV9VAK/GQ0DfLl4TW
 fd5jFaPfTiKlxV6yK40M6vrXKaEcmVx/CnTFKtRbDCfP0HeO1OdVnNUQ65gY6A/bp/3s
 Spc/FLz/mz/ni0GkDzqK75LDiInTbzU2Hw9s2XVpWwtIdSCMLVSvjLqfZjmMFQ1Cv/hf
 GVFfb7qI8sO6rb/ro5TyESvBQBiVEKFQyVhfpwnTcswdV6c0FQ7pDo6eFGQ6qW+fEtlF
 AIjAW/z74drtsAkU4QYGi3zsAqWvSvrnCDUmW/PhkiTx6YqR4K8lSzGcls8SuBhA9O1E
 6zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qXI23a1IwY3ie8JXqjTRuDBwO8bkem8ij+8i6dgXZmY=;
 b=UzLS0ZrW1QeyZWcpi8hWV6VWrf8uEZ7cOUimBEtIOhiLoXxBEfDkYgvH7jomR+pSbw
 elGptpR+ZBO/CfBZtUBiYL99VxP3+DBVdlwMPxms63rPwXEADefnog7qRioB059cVQbf
 fL3NvfKC9rjV1VcFjPERV89rgD66+5MDNnwxdeZFB/GYkvJxk8p7FINSLS9aC9VJM+bU
 Ewzzs1nnaZ791pHGSh/cx9GBfMJmidJqdhVLhDh27XfLZNB1y+iplTvCIiLJOXeA0a7s
 3oiV6wTLGNGOtJvLBhn+Tm51OkEHzd9qvj0wNP1Q5aLUkCEhH25aPhC57MYUJ5/rt84R
 zt5g==
X-Gm-Message-State: ANhLgQ0Xfn60dqqjmnf4iRu6bSifNOaGeoUYGG+yuTjtF4EnU/LTSqYJ
 uURT+StUHqfTWIq/xmaxUDB1PEMUe7yRV6sFY7LbjQ==
X-Google-Smtp-Source: ADFU+vvmBMldInC533FJxKMKkpTbquGoRgXlwFhvaoYRPaxBTNJcHixQ4n2h9Zrmd9So4evF+r8PD+2g6jOeFH6Io5M=
X-Received: by 2002:a05:6000:111:: with SMTP id
 o17mr1210855wrx.111.1584587751002; 
 Wed, 18 Mar 2020 20:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200318002500.52471-1-natechancellor@gmail.com>
 <20200318210408.4113-1-natechancellor@gmail.com>
 <CAKwvOdmjzemFW9jF-CW1RhLJJbMvFO_NrPUeyi=rdLNVZURsfw@mail.gmail.com>
In-Reply-To: <CAKwvOdmjzemFW9jF-CW1RhLJJbMvFO_NrPUeyi=rdLNVZURsfw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Mar 2020 23:15:40 -0400
Message-ID: <CADnq5_NjjorZhuAx+4gCW=LLGGvRhYqVKXUhAcXriehN3_y-UQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Remove unnecessary variable shadow in
 gfx_v9_0_rlcg_wreg
To: Nick Desaulniers <ndesaulniers@google.com>
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Joe Perches <joe@perches.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 18, 2020 at 5:08 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Mar 18, 2020 at 2:05 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > clang warns:
> >
> > drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:754:6: warning: variable 'shadow'
> > is used uninitialized whenever 'if' condition is
> > false [-Wsometimes-uninitialized]
> >         if (offset == grbm_cntl || offset == grbm_idx)
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:757:6: note: uninitialized use
> > occurs here
> >         if (shadow) {
> >             ^~~~~~
> > drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:754:2: note: remove the 'if' if
> > its condition is always true
> >         if (offset == grbm_cntl || offset == grbm_idx)
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:738:13: note: initialize the
> > variable 'shadow' to silence this warning
> >         bool shadow;
> >                    ^
> >                     = 0
> > 1 warning generated.
> >
> > shadow is only assigned in one condition and used as the condition for
> > another if statement; combine the two if statements and remove shadow
> > to make the code cleaner and resolve this warning.
> >
> > Fixes: 2e0cc4d48b91 ("drm/amdgpu: revise RLCG access path")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/936
> > Suggested-by: Joe Perches <joe@perches.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.  thanks!

Alex

> > ---
> >
> > v1 -> v2:
> >
> > * Remove shadow altogether, as suggested by Joe Perches.
> > * Add Nick's Reviewed-by, as I assume it still stands.
>
> yep, thanks
>
> >
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > index 7bc2486167e7..496b9edca3c3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -735,7 +735,6 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
> >         static void *spare_int;
> >         static uint32_t grbm_cntl;
> >         static uint32_t grbm_idx;
> > -       bool shadow;
> >
> >         scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
> >         scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
> > @@ -751,10 +750,7 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
> >                 return;
> >         }
> >
> > -       if (offset == grbm_cntl || offset == grbm_idx)
> > -               shadow = true;
> > -
> > -       if (shadow) {
> > +       if (offset == grbm_cntl || offset == grbm_idx) {
> >                 if (offset  == grbm_cntl)
> >                         writel(v, scratch_reg2);
> >                 else if (offset == grbm_idx)
> > --
> > 2.26.0.rc1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
