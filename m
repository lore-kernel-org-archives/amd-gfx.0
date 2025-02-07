Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E04C0219B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 18:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A41210EBA3;
	Fri,  7 Feb 2025 18:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jh61hGbX";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0140C10EB9C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 18:17:25 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2fa1a428f6aso388613a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Feb 2025 10:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738952245; x=1739557045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sX3uczdImyHFlzN71mdYi2cSgkDTv8a84LOGDxZ60iY=;
 b=Jh61hGbXAjLF3j/enj4bae81JUgsj3CPjmiMWD6wGT4QysZ3Z/fhee7iLSk0C+CMPH
 sEIC1N6Upss2r4jubL5CmEgp6HE4VdgDIVspXKqZ3L4ZnBiggjnEITDVbYssRASG+n6e
 q4RV3HE+/zU9793iRZ4qKX2szlt4w9TRsDPlBgVAbbFfntaxeQPEQHDvb2bwREAnu9g6
 KPAZdyRjOLH1adR/aGmc9NLVPy/MuJGpF68mEIk8VmsBR8DoEgmodVPPmiMN1xC0TmWn
 YxfJ4DK/ixHl0xmYMxhCDLofPzqSWw6jiVtFRtEikvjIZmYWXIGcv4E1P1daaT3lzHmH
 VPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738952245; x=1739557045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sX3uczdImyHFlzN71mdYi2cSgkDTv8a84LOGDxZ60iY=;
 b=H9jRyTblVeuNbn3UgCL3jLoLYeISvYuHuAfRgJEl1y6aZRFWHFbX/YayaAaBVig4ct
 cUsmDiMAtEdfBPga1sep29xKrhA2uIVMsOP+xGyW0Yn/fve7yWzlHpqBT3orqt3+A43Z
 4KELhGn5O4dH3gmZRsEs4sRtAfPfgdqbRziWL/ymCNW1wNkoCh2No/+Cj6OvDF3231uv
 Wbc06w2tAZa9vPOvclEpltcHeW+Hax2DjRmRQquqAvgiFN9Cx2hYh3+CK6qoZPnGxEqQ
 xc6Jg5jwp0kwCYlUwOgP27hS9N83qw+GvxDbTOpl3+oSZrphfi7+VMEaY+u0k+wZGdRT
 G1xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG+QsJI8jHez0/N4ZfBlBAbdgo0sUaG7gxY2zTKFy3t2BcDXoOix/5KXvKvGGQ14wXk3Ibkuda@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yws+Rq324+E3Xk8SW5SFkjZIEGbDQyXn0dQ0B3fFN61lBomahIh
 5DYMYa8X0ArYjb1wbS91R6Htaq1bGitqim8CVL00w4dJ4XlvN5ScAiQaHyZshIUP4mgAacrAK/n
 Fzl5hzwYV8S8uBzyWOG6r5jo+vZw=
X-Gm-Gg: ASbGncuwBQPqKX4fIB96YxAaAZ8eVTp+nonpXk5n4mT8+hXbvlMPjVVX7rI7t6dpTGT
 dp6+xQegVMGlZY3UbVChnPD3FTY6hVMAl+Fh94ov9sB51w2qEwHB+BFg4E5jDgo1PWUKZEk4Y
X-Google-Smtp-Source: AGHT+IHS6hpuPtjE/fiWJGBcalWpGDw5dJiGkhlqq6v+0HDGMvDHbkDbPssT0bLwFJ3Bj0f4ER7DiGljGUyf8zmKORQ=
X-Received: by 2002:a17:90b:1e0d:b0:2ef:93:154e with SMTP id
 98e67ed59e1d1-2fa244f6bbfmr2465041a91.5.1738952245337; Fri, 07 Feb 2025
 10:17:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1738910203.git.gerry@linux.alibaba.com>
 <5d77360ce88ec08ceb6cd9e9347001dc427dc1af.1738910203.git.gerry@linux.alibaba.com>
 <15722654-c1b5-40a4-8934-f2fd353e2193@amd.com>
In-Reply-To: <15722654-c1b5-40a4-8934-f2fd353e2193@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Feb 2025 13:17:13 -0500
X-Gm-Features: AWEUYZkbc4pkxewI1IS_uvUxNvf4oAL_sQ7Oznul6WeZLFt0dIc9Ij4aipA11No
Message-ID: <CADnq5_PnCUv-_EuOowr7yR0einQUyOMptHK=O_wRos5fZJr8GQ@mail.gmail.com>
Subject: Re: [v1 1/4] drm/amdgpu: avoid buffer overflow attach in
 smu_sys_set_pp_table()
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 sunil.khatri@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com, 
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com, 
 amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

On Fri, Feb 7, 2025 at 3:02=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wro=
te:
>
>
>
> On 2/7/2025 12:14 PM, Jiang Liu wrote:
> > It malicious user provides a small pptable through sysfs and then
> > a bigger pptable, it may cause buffer overflow attack in function
> > smu_sys_set_pp_table().
> >
> > Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>
>         Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/dr=
m/amd/pm/swsmu/amdgpu_smu.c
> > index 8ca793c222ff..ed9dac00ebfb 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -612,7 +612,8 @@ static int smu_sys_set_pp_table(void *handle,
> >               return -EIO;
> >       }
> >
> > -     if (!smu_table->hardcode_pptable) {
> > +     if (!smu_table->hardcode_pptable || smu_table->power_play_table_s=
ize < size) {
> > +             kfree(smu_table->hardcode_pptable);
> >               smu_table->hardcode_pptable =3D kzalloc(size, GFP_KERNEL)=
;
> >               if (!smu_table->hardcode_pptable)
> >                       return -ENOMEM;
>
