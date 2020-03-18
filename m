Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E200AC4332E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 20:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B488C20724
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 20:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="n/X1upys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B488C20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D866E963;
	Wed, 18 Mar 2020 20:52:54 +0000 (UTC)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454066E960
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 20:44:08 +0000 (UTC)
Received: by mail-pf1-x444.google.com with SMTP id f206so100973pfa.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=suYHs9658zHP4xficEGq5WrBjqIzHfAOzaIFRECzM5Y=;
 b=n/X1upys3h4rJNYvIw5j6AOUliQjvpmhy+m+9DZtWbYDpENrMWU9gX5OfOPjZCHqCq
 3N7EyTuBY29aXC98swHoyCoDuXnLG1HE/1H5jXDW/qG1EW1lh3uw7U7CfUWRbfjqOkcL
 hSX9Of+C0ataFtlnWTZFimXaINj+GxUPy1TZ1osPcSFYCZ/kscC0Ip/qBbdiSN6vpz8B
 PpgAdT3mzS/u+Sv9CKxeQP2Ut+/oAyg0LMSWhIbEHFuVBW/XOVLB2LgC/R2qCD140Jcm
 MxM0L8LtdKgiUYTUC3GZ3Oceg48BDmYiFzjjt+SlBqWpTOO5mU17+RKzxJjJStQpV7vw
 OnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=suYHs9658zHP4xficEGq5WrBjqIzHfAOzaIFRECzM5Y=;
 b=VeMoI1B10rrZHd4W1FdGpyYh9w3QcLuI3DJy32YgxYqWx17B47s8xB+bukV50t06Fe
 GYBtV3bxA+N1/t32C56r8anjuGxMiHiACOTPp5kLml++GA2Oe1972z2cDe9db2sRbQP1
 O1dWVB/A+obxgPrY96k3OH2zbuJ3gTIEgs41oGGdHUhxH3uoQcpOaxQscmjIQYDY0QQP
 4j9eoiVSOefbnRkr0oy8NpgXF3IGqHFUQaXowS9LGiAdO5puFTeHSKsMw+KNm2R87q/A
 U4CNDrjAOdH5BWU7Zga4/Nbf1DrRgdxPldk/4SjpSBum5glGmQtSlzaYXuJduM3ydNzV
 P+IA==
X-Gm-Message-State: ANhLgQ1wSEQaoAVu2Oo/BOf/Vpzrojq3I301hn1lLzpZQsTT9dYPUjJf
 80pqO4jcM0B6386b19dEr7SZ03v3D4q7ZMEi7T25sg==
X-Google-Smtp-Source: ADFU+vvuYGfe5Sd8RCUOsHGVZHh0QkYvusq8LOKEvmO8g5PG8CN5UlQKq17NQMJwPUgG4KkltVfEVBtrogvoQJfagUE=
X-Received: by 2002:aa7:8b54:: with SMTP id i20mr116252pfd.39.1584564247262;
 Wed, 18 Mar 2020 13:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200318002500.52471-1-natechancellor@gmail.com>
 <3a997f4ee640e607a171a19668f5f5484062116c.camel@perches.com>
In-Reply-To: <3a997f4ee640e607a171a19668f5f5484062116c.camel@perches.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 18 Mar 2020 13:43:54 -0700
Message-ID: <CAKwvOd=AA8NrqmOR=E7+e6dHEVo3DZwfSuK72DGzHG+X56pB7A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Initialize shadow to false in
 gfx_v9_0_rlcg_wreg
To: Joe Perches <joe@perches.com>
X-Mailman-Approved-At: Wed, 18 Mar 2020 20:52:53 +0000
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
 dri-devel <dri-devel@lists.freedesktop.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 18, 2020 at 1:28 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-03-17 at 17:25 -0700, Nathan Chancellor wrote:
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
>
> Wouldn't it be better to get rid of the shadow variable completely?

Yes, much better indeed. Seems it only has one use.

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7bc248..496b9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -735,7 +735,6 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>         static void *spare_int;
>         static uint32_t grbm_cntl;
>         static uint32_t grbm_idx;
> -       bool shadow;
>
>         scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
>         scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
> @@ -751,10 +750,7 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>                 return;
>         }
>
> -       if (offset == grbm_cntl || offset == grbm_idx)
> -               shadow = true;
> -
> -       if (shadow) {
> +       if (offset == grbm_cntl || offset == grbm_idx) {
>                 if (offset  == grbm_cntl)
>                         writel(v, scratch_reg2);
>                 else if (offset == grbm_idx)
>
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/3a997f4ee640e607a171a19668f5f5484062116c.camel%40perches.com.



-- 
Thanks,
~Nick Desaulniers
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
