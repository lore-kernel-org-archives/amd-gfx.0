Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76229CD4F4C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 00:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CFC510E62D;
	Thu,  5 Sep 2024 00:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Yv5GsdMS";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 848E210E62D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 00:40:20 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2d8a1a58d5aso8267a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Sep 2024 17:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725496820; x=1726101620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sa+31FNlnU51wj1mXaSTAVcMjWfcp62TituCforrV/U=;
 b=Yv5GsdMSoCQzpLNciUgzipJaeIJnfMcV/bcmwK8fHygMue7EkWYiJnXkNeof2qt7Mp
 Zqv2Kotnp1Te2gxoeqsXtO8E38juQT1Ud8vaUvwpTK9At70diz8GMEVT8dEQ4sIaN5+W
 yo/Q9jdpTzgLdygFWMmHBi538Tj9uKGLl0jrTFWaXNDt/C3K/7/R7Sm04iUy47COPzvk
 VjVRpUCjrNODc5ScBfbn84EcrB4cwx9plo9g5nj5kABAO3066YE2mjuYzecED66imVz9
 FuA7OhmHITmmpZOOJiLEj1ZZ/MKCQiByzUfqtpYVuILeVP6ej/7BRm2PnDo5L4XoFPtN
 CJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725496820; x=1726101620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sa+31FNlnU51wj1mXaSTAVcMjWfcp62TituCforrV/U=;
 b=ke9efbkdARZ8fjeiDPCu6ZxHkKgMcFyRYmkFJXahBGoO3zwHrvZqeOIl6teOxQjrkk
 92PXODJwzFYDuZ8N6ztgM0qP5l1yBXvcXpJjo5N6aN1fqzjGsRxN0jL2d0fMN40FHLUR
 xxXXvW7WyFJEeiZY+PhlKMPyn4wCK7lhRspoctotPKbwUV/PHGptm4uI9MzjcmPCcnqi
 +GOlPQfQ3gNKMJXSAv4e8Qt5cuSyAQVPhUQsLMp9wZIZcuBScn0ZEbXprPPzHoQNEKse
 AbQ8r4OolPk2o0V7Zz3H5lfumvxweAAArEqh802S587rL76EPEHVh9p1fWTEqAmY8+aH
 W9OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnjhP+SPQsiFGAdSViZsNVjTdI9Drov+wWsaJaVtkJn1YUXHBTB/Q0OUXWOBXhZIbOgmNWiz8F@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMHxbqZSAmjfef1dbIGWfDopX33QF3n6i930xzwoRVXbo/KDPW
 I4Ze+1adgD3td+Ob46BTysHeVL3gv1mi9RRntHOcKy8LgCCLVc3Np3rO39Mhzs1lLcObjB2E6NK
 SEuUSH2N1cbnS2WQl7E9+cVUxhGAzuvH3
X-Google-Smtp-Source: AGHT+IHFKmelce9Vq4kuclKYQS1ba1YXJBDybSdayDxsUzhxdb+vLX/+AjZAO7HIOwfVRAv6FcvQkPmqsi9hyzlk+7U=
X-Received: by 2002:a05:6a21:6d90:b0:1c4:d403:d531 with SMTP id
 adf61e73a8af0-1ccee5179c2mr11214895637.6.1725496819812; Wed, 04 Sep 2024
 17:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240904132729.1948224-1-srinivasan.shanmugam@amd.com>
 <20240904132729.1948224-2-srinivasan.shanmugam@amd.com>
 <CADnq5_NF64K3Sih7c_N7TqpF8d5M2m7pfPFTDKKqFVwJUHuq4g@mail.gmail.com>
In-Reply-To: <CADnq5_NF64K3Sih7c_N7TqpF8d5M2m7pfPFTDKKqFVwJUHuq4g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Sep 2024 20:40:08 -0400
Message-ID: <CADnq5_NnBnELhWj48MH3+FN9+nm00Z_x1XxtaXWAOGLri11fVw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/gfx9: Refactor cleaner shader
 initialization for GFX9
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Sep 4, 2024 at 8:37=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Wed, Sep 4, 2024 at 9:53=E2=80=AFAM Srinivasan Shanmugam
> <srinivasan.shanmugam@amd.com> wrote:
> >
> > This commit modifies the initialization only if the cleaner shader
> > object has been allocated. This is done by adding checks for
> > adev->gfx.cleaner_shader_obj before calling
> > amdgpu_gfx_cleaner_shader_init
> >
> > The changes are made in the gfx_v9_0_hw_init functions These functions
> > are responsible for initializing software components of the GFX v9.0.
> >
> > This change prevents unnecessary function calls and makes the control
> > flow of the program clearer. It also ensures that the cleaner shader is
> > only initialized when it has been properly allocated.
> >
> > Fixes: 776ad43d4170 ("drm/amdgpu/gfx9: Implement cleaner shader support=
 for GFX9 hardware")
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index 23f0573ae47b..d6d07cfd279e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -3975,8 +3975,8 @@ static int gfx_v9_0_hw_init(void *handle)
> >         int r;
> >         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> >
> > -       amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_s=
ize,
> > -                                      adev->gfx.cleaner_shader_ptr);
> > +       if (adev->gfx.cleaner_shader_obj)
>
> Is this check actually needed?  I think amdgpu_bo_free_kernel() can
> deal with a NULL pointer.

Sorry, wrong function.  In this case we check if the CPU pointers are
valid already.

Alex

>
> Alex
>
> Alex
>
> > +               amdgpu_gfx_cleaner_shader_init(adev);
> >
> >         if (!amdgpu_sriov_vf(adev))
> >                 gfx_v9_0_init_golden_registers(adev);
> > --
> > 2.34.1
> >
