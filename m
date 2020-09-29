Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECDCC4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CDD20773
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssKlzkHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CDD20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905ED6E1F7;
	Tue, 29 Sep 2020 15:13:25 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A5896E1F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 15:13:24 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id z4so5851701wrr.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ysan0j2ITN6KiqzUtltSL0fKREP9FUGNXqYdgzUWkkQ=;
 b=ssKlzkHmwviYCmfp2KakVLqH+hMFXmeyJu1tAg36fhqo5j2Z2EoQ117ZCguuMU/MKq
 LAIkCR8wYeSSD7qhnkICRrqFoc8Ib7m5X6i9OymsT9ESXAaIL3zIsJVSMIN4QllTgKdt
 npeAMlkqwTkevZaCRPDNlGv19CMlwxbLvABfBlZea3nAToykjEKdeGBofR9jNkljMq8G
 tYtDYl6PfKyBpQBSsCGk2itsvYYYMif44CabA7NrdgJ+tJogzseD8wfwtY2naNXxCz4q
 HDAy2+KUQWjXjogfAZW7FRG2azByfq+FAxJFB5IEP40OxGFtJqWu5vb+UAIqUlEhfWOJ
 rOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ysan0j2ITN6KiqzUtltSL0fKREP9FUGNXqYdgzUWkkQ=;
 b=Mz0k5JbmUCx5XPnl7VlasYC8UsCNQI+VlQuTAdYi+0qeDsLIJkIwe87ObCTCYPJrGj
 gxKm7f1nrzCagueB2F7HPeHMT5jT6pUkE8HALM7k8f3M+/kfQl+hPELzba5nNbaHGeZm
 tO0lzWglwomG6xCbJcd4gnRmonl7ZJVztjdlUDg8d9h1m8uisNURUhL6cXiayVs2rnS4
 yQ0c7Zy0GiBgG9W4aYRpZr6bm2yaXBj34+pfl8YlndHjCflo0a+PGa4UWKrlWBB+OUti
 OlKl7jzd8Mz3THgY7JTxJVPdy5eT0icIqkY5IUWQ/ictEnbL8Gxipjs/RUT9hEic7idj
 pTzQ==
X-Gm-Message-State: AOAM530WKT4BywGwwcUIeLz96fg+KVYBk3rdhD4TqVXT6oqRNNnKQnS4
 ToEwZxEazz34KQ5U4PXKy0VgxmmG0pI179gzxOAgPama
X-Google-Smtp-Source: ABdhPJwDFbRCIskR/dPVIbeTDLyvZdSEwy9VVnD5CFZIndztSjhrFgvv3OREda/5TiLfSeDu0nPiYpZQD3eaPLoVkF8=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr4854579wrr.111.1601392403078; 
 Tue, 29 Sep 2020 08:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-41-alexander.deucher@amd.com>
 <9ecb966a-4b3e-2ffa-b72c-c88bd31b87a0@amd.com>
In-Reply-To: <9ecb966a-4b3e-2ffa-b72c-c88bd31b87a0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Sep 2020 11:13:11 -0400
Message-ID: <CADnq5_MYZZsZTZDxU-SgK-bQ7Y-24wteSTE+e63jhtzYTZJn-A@mail.gmail.com>
Subject: Re: [PATCH 41/45] drm/amdgpu: add gfx power gating for gfx10
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 28, 2020 at 6:48 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-09-25 4:10 p.m., Alex Deucher wrote:
> > From: Huang Rui <ray.huang@amd.com>
> >
> > This patch is to add power gating handle for gfx10.
>
> Ray, you can just say:
>
> "This patch adds power gating handler for gfx10."
>
> You can drop "is to" and just use "adds".
> And similarly for all other patches where you use that.
>
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 27 ++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index fd29a6d7285b..f2849f180c91 100755
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -7583,6 +7583,30 @@ static bool gfx_v10_0_is_rlcg_access_range(struct amdgpu_device *adev, u32 offse
> >       return gfx_v10_0_check_rlcg_range(adev, offset, NULL, 0);
> >  }
> >
> > +static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
> > +{
> > +     int data;
> > +
> > +     if (enable && (adev->cg_flags & AMD_PG_SUPPORT_GFX_PG)) {
> > +             data = RREG32_SOC15(GC, 0, mmRLC_PG_CNTL);
> > +             data |= RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
> > +             WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
> > +     } else {
> > +             data = RREG32_SOC15(GC, 0, mmRLC_PG_CNTL);
> > +             data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
> > +             WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
> > +     }
> > +}
>
> So here, you can just do:
>
> static void gfx_v10_cntl_power_gating(struct amdgpu_device *adev, bool enable)
> {
>         data = RREG32_SOC15(GC, 0, mmRLC_PG_CNTL);
>         if (enable && (adev->cg_flags & AMD_PG_SUPPORT_GFX_PG))
>                 data |= RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
>         else
>                 data &= ~RLC_PG_CNTL__GFX_POWER_GATING_ENABLE_MASK;
>         WREG32_SOC15(GC, 0, mmRLC_PG_CNTL, data);
> }
>

Updated.  Thanks!

Alex

> Regards,
> Luben
>
> > +
> > +static void gfx_v10_cntl_pg(struct amdgpu_device *adev, bool enable)
> > +{
> > +     amdgpu_gfx_rlc_enter_safe_mode(adev);
> > +
> > +     gfx_v10_cntl_power_gating(adev, enable);
> > +
> > +     amdgpu_gfx_rlc_exit_safe_mode(adev);
> > +}
> > +
> >  static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs = {
> >       .is_rlc_enabled = gfx_v10_0_is_rlc_enabled,
> >       .set_safe_mode = gfx_v10_0_set_safe_mode,
> > @@ -7630,6 +7654,9 @@ static int gfx_v10_0_set_powergating_state(void *handle,
> >       case CHIP_NAVY_FLOUNDER:
> >               amdgpu_gfx_off_ctrl(adev, enable);
> >               break;
> > +     case CHIP_VANGOGH:
> > +             gfx_v10_cntl_pg(adev, enable);
> > +             break;
> >       default:
> >               break;
> >       }
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
