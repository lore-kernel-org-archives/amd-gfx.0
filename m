Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF863D6B6A4
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 16:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE1C10E008;
	Wed, 30 Oct 2024 16:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WeI3+Zov";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D961610E008
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 16:02:48 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2e2ab5bbc01so1018760a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2024 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730304168; x=1730908968; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=st64M0ww1jJnVt2gyGGl1zWq7VTaquIXox5yoQVTQ6Q=;
 b=WeI3+Zov5tsgQTSTfxOIVtV4E8V2T3UpI78tWiwjB5aTg8YQQQnGY+EWDQSJEbg/IY
 YEh07wRG0e36vqnDN7vSX154Ke4c/v4wpJxs9L/O6swWmfqyi3ERmEIGFl2nzO9IJYDc
 S6B8gXBFgjploorvlPLnncDzAnekT6/wxLMH2FTZRTSn7nuuR061ZcigKU/RCNa+HvJO
 0iK2BH381J/aqj4UwleK2qgQKOQgqUKvF5wzsI4JA+8snXuMPElsWcewZdr8rAzrJG+H
 UeOPDD+uoYVA4UepqPCR4IHnpwVGDRS6oqjIfWEEUcDJp0pKCHYPnY6KmTMLzG00bhNo
 1LTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730304168; x=1730908968;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=st64M0ww1jJnVt2gyGGl1zWq7VTaquIXox5yoQVTQ6Q=;
 b=wgVK96avNgVYJqTkWJjrvFyfj5DE+oPhyxPEZTQX5mM6xpeXtFSJH0aUL3llEAPgLN
 TZSVQx2SNymxRpKXtFar51Na7tik7fDtEUrVRUr7KYqL4OgvhD3BV/AegVk83+IyRGmB
 S+R9J9fYMk4hlzecruexnRq36gR68TcsdStvrhNCYoojuLN/BZzo4NzyXsOu9msCXgqc
 srvtEEuVDSWPMnGHraY0iuGMjTszry2F1fv6zT0tqoaOaNValYgtLa+IbJpRuzg1HDa5
 U9bcE9leZQ5WkEXQYpmI09m3obhy4YBiwGOyLcNTRvtHQu7xjkBKt3o8MirOAeTYlyvl
 +V2w==
X-Gm-Message-State: AOJu0YxG0WKIfCwz8njUlcxlVZXju4FOngpTZin9ekDBAM8udF6KbmtV
 FjeaeTb1SbJhpHtkis5kG/wxlwqzKIX5hySiTVYTxQJOmN3+tsTvVtnc8kC4wtI1HCuBppja43j
 rWr+hKpmWeH7QXFdEnDK39FHYmiL75w==
X-Google-Smtp-Source: AGHT+IFMRbtrraN7iLB8NaFJWYlhLGCrP2EnxbgSClBTmw/S8M7CXr6AboGtjsTHyPXqPeXr5S2y9NZgi5wWrekq/oE=
X-Received: by 2002:a17:90a:5185:b0:2e2:d562:6b42 with SMTP id
 98e67ed59e1d1-2e8f106d66bmr8100480a91.3.1730304168017; Wed, 30 Oct 2024
 09:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241023210342.685808-1-alexander.deucher@amd.com>
 <CADnq5_M3ar8qGBFVF5p7YUbVsjZvzCdkDcJ-GM7J+T15vfJOhQ@mail.gmail.com>
In-Reply-To: <CADnq5_M3ar8qGBFVF5p7YUbVsjZvzCdkDcJ-GM7J+T15vfJOhQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Oct 2024 12:02:35 -0400
Message-ID: <CADnq5_OAwioJzxgonFEPNCHSWNOvmCowh=_OCQ-jcowP-Bcomw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: Adjust debugfs register access permissions
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping on this series?

Alex

On Mon, Oct 28, 2024 at 10:42=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> Ping on this series?
>
> Alex
>
> On Wed, Oct 23, 2024 at 5:04=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > Regular users shouldn't have read access.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.c
> > index 6e6092916d4e..e44a44405266 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1654,7 +1654,7 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device=
 *adev)
> >
> >         for (i =3D 0; i < ARRAY_SIZE(debugfs_regs); i++) {
> >                 ent =3D debugfs_create_file(debugfs_regs_names[i],
> > -                                         S_IFREG | 0444, root,
> > +                                         S_IFREG | 0400, root,
> >                                           adev, debugfs_regs[i]);
> >                 if (!i && !IS_ERR_OR_NULL(ent))
> >                         i_size_write(ent->d_inode, adev->rmmio_size);
> > --
> > 2.46.2
> >
