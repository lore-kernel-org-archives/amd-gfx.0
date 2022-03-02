Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F358BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 18:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7584D10E1FA;
	Wed,  2 Mar 2022 18:05:37 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFAEF10E1FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 18:05:35 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 6-20020a4a0906000000b0031d7eb98d31so2803817ooa.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Mar 2022 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KuqlrQghLjXPF445IeTtqldyIa3TuryzM949NZ8gdBw=;
 b=WksY2Yu9uPwFJ25AZO3jrYSijwVdcvppCd2hq46w53gJ+aeutzVhDg9ko92lOAoW4e
 jdawTE4tBrQn5fraJvDFAPhtw8a83OhHHT3urv/iG1WwylbgoHh3KJdYwfLsxVjQrQu6
 BVrFA3EUdsuOUbpLoJ8S0C5Uxr8lWI92kOVNQtGVPJcW+7nIadVdVURj75zSV41ArZHQ
 8QTToclz4viXkvL6s+96s9ENlT1OGkHYUu0+FVic/xlRfWOk/DIKRnWIlJg5MW90WJ0I
 ZGEhw8V9uPxr8mr4Uv6XHJJXbOnhVoLnXbx0uLWUputh4SV6fBFFFCzuWtjQp/IIeXW4
 sv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KuqlrQghLjXPF445IeTtqldyIa3TuryzM949NZ8gdBw=;
 b=3pX9pciaZpj1ELlVMDNKEPScvkLubpaHAVk+3adMGsxHihA/ZPkGDWftfYqKiZohaF
 ew3lCUC5GAFkNoUmb2bgHp4ilAG7jarqO7xp/1aj/X49JG2jl43XB4F9v+EeDEJteCEH
 tRal7IXaWv3Sa6vplo5ovcOrNvR8kPPfEgS9NtTaifAsi9ruFgszze52hmThTF/JySYd
 ctGy91W4YbIqiG3bp1JYcsQm5HhrUbCzqMmtEac9BIaDyEjsz9XdzlYAgdlTGjjjAY9y
 cpnpGjaUEnF2b24HnESsJhd0DRWGFZ9O9qNCCy2g8vhrBZNKBo2FGmHmAySNG4vXevcm
 DT2A==
X-Gm-Message-State: AOAM530G+dA9sMGwkDdNV0iKWjkvgzUuAO+cmfuQvAjKQGHZH8NmYKBA
 07C9/uAPkWgE+3QerBphj7+slpk10hWP9ZssFQc=
X-Google-Smtp-Source: ABdhPJxS9Wa3PXhZE04dV9A2j0rrIhWPauh+xKvMYYPoUcBLvCfR9aywbYOdIHKzTYU9mg3QodyhBhhq/Vq7q2Ty3fY=
X-Received: by 2002:a05:6870:f617:b0:d9:a3b1:3414 with SMTP id
 ek23-20020a056870f61700b000d9a3b13414mr827378oab.123.1646244333672; Wed, 02
 Mar 2022 10:05:33 -0800 (PST)
MIME-Version: 1.0
References: <CADnq5_Na2UtFUTX5uphZH6THw7PisPM835TLgjB=Ne_3==VJUg@mail.gmail.com>
 <tencent_DD9048474C138FE4294644B7CEEDF7D84806@qq.com>
 <d4d029c6-b132-a0be-5ec6-c295eba4e36d@gmail.com>
In-Reply-To: <d4d029c6-b132-a0be-5ec6-c295eba4e36d@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Mar 2022 13:05:22 -0500
Message-ID: <CADnq5_Pb2DJadaUJhirC=L5BcMBcFNZaSy3dgXnhhBzo+uW3jg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: remove redundant null check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Weiguo Li <liwg06@foxmail.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Mar 2, 2022 at 11:54 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 02.03.22 um 17:17 schrieb Weiguo Li:
> > Remove the redundant null check since the caller ensures
> > that 'ctx' is never NULL.
> >
> > Signed-off-by: Weiguo Li <liwg06@foxmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > v2:
> > * take Christian and Alex's suggestion
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 6 ------
> >   1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ctx.c
> > index f522b52725e4..2f38de406937 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -261,9 +261,6 @@ static int amdgpu_ctx_get_stable_pstate(struct amdg=
pu_ctx *ctx,
> >       struct amdgpu_device *adev =3D ctx->adev;
> >       enum amd_dpm_forced_level current_level;
> >
> > -     if (!ctx)
> > -             return -EINVAL;
> > -
> >       current_level =3D amdgpu_dpm_get_performance_level(adev);
> >
> >       switch (current_level) {
> > @@ -293,9 +290,6 @@ static int amdgpu_ctx_set_stable_pstate(struct amdg=
pu_ctx *ctx,
> >       enum amd_dpm_forced_level level;
> >       int r;
> >
> > -     if (!ctx)
> > -             return -EINVAL;
> > -
> >       mutex_lock(&adev->pm.stable_pstate_ctx_lock);
> >       if (adev->pm.stable_pstate_ctx && adev->pm.stable_pstate_ctx !=3D=
 ctx) {
> >               r =3D -EBUSY;
>
