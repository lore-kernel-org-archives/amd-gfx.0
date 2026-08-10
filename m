Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71269C5AD7B
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 15:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C727A10E90E;
	Mon, 10 Aug 2026 15:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TZeC+kS3";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93FBB10E921
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 15:58:50 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-ca8a3a77daaso138472a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 08:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786377530; cv=none;
 d=google.com; s=arc-20260327;
 b=sts5CL4CahnlcEGd5PU8VUvYmfRnp9t1I9fE50IcSJGabTB62OdlEm0Sj1+RZKVh7F
 TZF0oOuyB6B2Os9chJAeHQl/aCqRNQMcQeJ7OHQ+hGahjCtMKs2RK5crlVqNQoN/yYHG
 PI/wjsYRTwBWxdQTwpfQG/tl60SbpaKQrIvJ5J39K0gRwhhK4/FRz3X3PKqgt4VzU6rL
 dD8vjdaBBrPYzs1wgeKQaGXB/jJBbeLtwrtM3Nbvn6KxILkJci2UQNgwtNks1vFoFoKi
 gYv3IQv+Y4hRM89yCHCgIic1YGAyma2NtCRJSm4ugO0OPTz4Vqr2f4pspN4u6QqlOmPc
 ariA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U9YsY8rcR2nimCA0FSAl9uZhbzoYDRMtkxeKyVzVCa8=;
 fh=LR5nYlp4SQ9Y5RoHOFFN8/5sCDfwuxixotjwSflQ0w0=;
 b=r5Xe3eONv9RT08DI/tzYcn2UNpLMd1G9kp7cEkgUHMxdyGSHVcnT4fBCYwieT2YZsA
 H8JxwXaaYrTn2rjSEKNqZTOIOA5xYowb/SJkrnRZxZnblX+6/YcZfpPBusw7fXzW8+Hu
 0Vjh6YPOV/x2nnVphS8oczPJIAHQHxtHCfo6f7r6AqqU7lawUYKfFi20RWMyCi82sg66
 z3Gk1nqRfogTi1zHw3BrcUsltvXomLpeBQoUObEo+IXxL8HJw1DkBs5Teoh334nG8bkW
 sj1w9OILFnJAjAy2g3nea1aFmfNOIjPl9RsBIAL4jIdEIfRdXLhSvtrg2glhpMfXmsTa
 UUzw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786377530; x=1786982330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U9YsY8rcR2nimCA0FSAl9uZhbzoYDRMtkxeKyVzVCa8=;
 b=TZeC+kS3y16O4OAYlVuAiQrJckDwzGYPWReCTyUnQ76ZbOdmUJmvxCOEmmFZluSxV/
 bx5SgvH4JI384V+BaOnO1IutIGYQIKZvAD82QgcFbqKUoUmQOIR7n+AMHbxQ20KDS8kQ
 9aQbATpwQguQTpfbY0PaTLkkhDC5n2F2PoqggKsnHNP3bCBgED292qB8SOsDZxwXolTN
 4hGiPQbCIKcYyri0ntbNsjBz5tQlgLW+056ttawr/rPaerBGdcI3smXOY8WR1Z/6y6M8
 RieKeKp1DiRLasCJl+HjiC/7boBBNJEgalFSji1PXlP30Y9m7zIdEUUY7u9p9G7YQ1tX
 SsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786377530; x=1786982330;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U9YsY8rcR2nimCA0FSAl9uZhbzoYDRMtkxeKyVzVCa8=;
 b=AO9goAQ7ac0aJXLjzhvBFPCIYdKIKwx3L/8mIxphffUSTf0r6ntMgRFs+kwLDrT/AN
 fT+0kpj2ELdB0SBUvu5qocGN5bROAUbELT2RavLzc+6CinOmMuiSUk3ICNM8e+MSEKbl
 8JZOxfo7cDBARNOwxzl62QtqqaKIZVG9H34g1PJM8zQXgpfC9V0dCUDIBAstc/sZ68TG
 qA59wuz8EJJxXk6ySGSJ/LTuv3ziInRKji+pjiiR7GLHu4JjnAYH6z+AWMPflM69ZPWN
 xFc7iNu4ggQ8XB/32W/9vhOgPp4++f9I8gOI8SZIb9rs7YU8TN4dcwrpOvcBZinFXhSU
 hd0g==
X-Gm-Message-State: AOJu0Yy9Sxy5zzry1OZNmP5O3dgn3bt21bSCsPlowiCUoCp3g2HxzIdP
 th3eF9d1EbgtVuAuI9Gb9yadhLK/iRK3bxGDvYAtdp4KrRHzrBFsfJqjyrf5X2iWa84noK98wmX
 1/gGINYnl998vHEesrOIeyzClPRFHK8o=
X-Gm-Gg: AR+sD10UdmLeB5952mtKUWCzP7abHmpsbrSyqAtC9bRx05QBR9pR+lqcOtVeSgJCPTw
 +ES+pUir6NE/BRxErBqDkX8SL0oOfqZ40I7n1BsJiDDcBfRqDPIS0RR8QEr/5Z50wdFmwpr/gZD
 5fmP/CuuYmwST7u6gfaoCwrqvF3BZCiK0UKKMJCoIkUs7qAKechGthgof3jPnxAl9vnJpeY4ZwC
 yxNg0QuOs/r8y0nRvGXgJg+URn0M/MXOhMUZp9r4HRv4HlD0fcGZhYbo5XceESREPpi+STwadHm
 yyEr6vuuvSs64hj+zIk2/lgxvyTdthYEJvCPtC1yqixc0mGWFz8K+wWRih5lL63NYOUnSl3SBYw
 c7y1AMkVJ6KT1oJMkbNe6Yjg/4TWGT0c=
X-Received: by 2002:a17:90b:53cf:b0:38f:57f0:1f51 with SMTP id
 98e67ed59e1d1-3903bb01d55mr29573434a91.0.1786377530063; Mon, 10 Aug 2026
 08:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260605221853.903153-1-alexander.deucher@amd.com>
 <20260605221853.903153-2-alexander.deucher@amd.com>
 <CADnq5_MOVBmf5Y6mPumdjiTRx-ffJROo2vsc7QmoV6pbzijNEA@mail.gmail.com>
In-Reply-To: <CADnq5_MOVBmf5Y6mPumdjiTRx-ffJROo2vsc7QmoV6pbzijNEA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 11:58:38 -0400
X-Gm-Features: AUfX_mzJ88Zyzov4WGhabqKvsFeDIOzVfMGTdVARHgWR9M-N65cya4Gv_adiPK0
Message-ID: <CADnq5_N8WgGpn15uBynApdkqJdnSaeOFXUyzpG8Q3_3iyHcK1w@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: fix missing check in vm_flush()
To: Alex Deucher <alexander.deucher@amd.com>, David Rosca <david.rosca@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

+ David

Ping?

On Fri, Aug 7, 2026 at 9:04=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> Ping?
>
> Alex
>
> On Fri, Jun 5, 2026 at 6:44=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
> >
> > We shouldn't return early if we need to emit spm update.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 7e0e2281719b1..13031e4b6f1d5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -809,7 +809,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
> >                 &job->base.s_fence->scheduled =3D=3D isolation->spearhe=
ad;
> >
> >         if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &=
&
> > -           !cleaner_shader_needed)
> > +           !cleaner_shader_needed && !spm_update_needed)
> >                 return;
> >
> >         amdgpu_ring_ib_begin(ring);
> > --
> > 2.54.0
> >
