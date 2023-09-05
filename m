Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6816C83F3E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 17:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0421F10E0F2;
	Tue,  5 Sep 2023 17:05:31 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491EE10E0F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 17:05:29 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3aa14ed0e7eso22799b6e.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693933528; x=1694538328; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTGffo6oiX6PceCAEBoxA6fIP5i4M80d6m4XAMfllDg=;
 b=bOjB8ngJVItP+9BLHhHvhJZ8fVfI+Fo1ha1mvfsOy0d/+OCQB01Ww8rTtu355TDzYV
 1wBCwmwCCHBMV8ju4GU0RLMxpGZJ8CXHj+Y0Pz88T7y4ICKTtUPqISOk48zYBKx1yHI4
 0lvyF/QmjXgJKWquhQkNJt5CsXSz3s4NqM0TFpRSyvzbrApMYhH5eEA7aO7Z8ImSYYuv
 50OrTd1EFs3V2+80MZuvSDj2tQKUSF7I1wa7wr7ZrRS6JbUVzuoZdVwwEs7Z3HWZ/4Eo
 JGIZfRRLkQxBruLipKjW7/yPxaMcHFnl4STIIIeEMY36nMOFGkl/Pe8+zEynIOKkfJ0v
 Cetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693933528; x=1694538328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PTGffo6oiX6PceCAEBoxA6fIP5i4M80d6m4XAMfllDg=;
 b=WMx1zmsq5qmRVkFe6B1vomn6M/gFXvRMX5i+5UmpxkCGOdg1ulOk/JYBSSy5M1RzFT
 dj37PsXLE8QpmrAc5+3RjsKyqGXoaVgJhuPKLSeD1NHs7ZksekyJM8vyKteMFsXgcaGy
 Nsdw0+1q+MiOVTmZRU67S6SF4NcBSzuH57zI1CFLRrW7BNb+h9J5m0l14BIhUXVGvQHE
 MiDh8Jsw0NC3HW5TUTrOSej0Mp2yovJmw3+1V9jXKVQ3nVy7CijspoxizEHXUFBJtFge
 MtaWs5luIZylGwH1eFhadIRhRt5YOSUBP95TWSIt4CUvjRS4c287R+bAouYo08zfGOxp
 +bMQ==
X-Gm-Message-State: AOJu0YyS/HMEFnk5tQtcqDjh5TQu8LbghFDl4GWK7gK01uIOiTxf0aCS
 p0RVRb1XQ0j3xVJmcCfPEa371vw8FzmsKuLUr83K+hB3
X-Google-Smtp-Source: AGHT+IFvc4JPiFBq8BCm1BZkDPo19WxkqzhaUJF/KXFdcvaPMqPvCi2iINBJyEkd7iqnYSLosdihrwhQUzN7QReN09s=
X-Received: by 2002:a05:6808:f13:b0:3a4:8ecb:185c with SMTP id
 m19-20020a0568080f1300b003a48ecb185cmr10690903oiw.22.1693933528398; Tue, 05
 Sep 2023 10:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230905142432.99760-1-David.Francis@amd.com>
 <CADnq5_PtnU9OR4-kYJ2MLqyZhhd0N+y=A7XwdqRfFzNSNv1AKg@mail.gmail.com>
 <BL1PR12MB5898778A4B494B39C494FC4B85E8A@BL1PR12MB5898.namprd12.prod.outlook.com>
 <baca9abb-ea87-3ecc-71c2-d7b376a4d9fd@amd.com>
In-Reply-To: <baca9abb-ea87-3ecc-71c2-d7b376a4d9fd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 13:05:17 -0400
Message-ID: <CADnq5_O4RvryQM_W+mKz04bM0fn3yYuSn39Su8TthTqidLAFFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Handle null atom context in VBIOS info ioctl
To: "Francis, David" <David.Francis@amd.com>
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 5, 2023 at 12:15=E2=80=AFPM Francis, David <David.Francis@amd.c=
om> wrote:
>
> [AMD Official Use Only - General]
>
>
> [AMD Official Use Only - General]
>
> Yeah we've had JIRAs (e.g. https://ontrack-internal.amd.com/browse/SWDEV-=
409711 ) raised that ASAN can't compile the thunk due to using =3D {0} . Us=
ing memset is definitely preferred to save trouble later.
>
>  Kent
>
> This is kernel code, not thunk. {} and {0} are extensively used throughou=
t
> the kernel in general and our driver in particular, so I don't see this c=
ausing problems.

Speaking for the kernel, we've seen problematic behavior when using {}
vs {0} vs memset.  memset always seems to do the right thing, the
others don't.  E.g., there was a series of patch sets to switch
everything from {} to {0} or vice versa, we just traded one issue for
another.  For this patch, you can probably just drop that hunk as I
don't see a need to change it.  Whether you switch to memset or not is
up to you.

Alex


>
>  David
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, September 5, 2023 10:53 AM
> To: Francis, David <David.Francis@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Handle null atom context in VBIOS info i=
octl
>
> On Tue, Sep 5, 2023 at 10:50=E2=80=AFAM David Francis <David.Francis@amd.=
com> wrote:
>
> On some APU systems, there is no atom context and so the
> atom_context struct is null.
>
> Add a check to the VBIOS_INFO branch of amdgpu_info_ioctl
> to handle this case, returning all zeroes.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>
> index 3a48bec10aea..86748290ead7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -947,16 +947,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
>
> *data, struct drm_file *filp)
>
>                                         ? -EFAULT : 0;
>                 }
>                 case AMDGPU_INFO_VBIOS_INFO: {
> -                       struct drm_amdgpu_info_vbios vbios_info =3D {};
> +                       struct drm_amdgpu_info_vbios vbios_info =3D {0};
>
> IIRC, these should be equivalent.  That said, I believe memset is
> generally preferred as not all compilers seem to handle these cases
> correctly.
>
> Alex
>
>                         struct atom_context *atom_context;
>
>                         atom_context =3D adev->mode_info.atom_context;
> -                       memcpy(vbios_info.name, atom_context->name,
>
> sizeof(atom_context->name));
>
> -                       memcpy(vbios_info.vbios_pn, atom_context->vbios_p=
n,
>
> sizeof(atom_context->vbios_pn));
>
> -                       vbios_info.version =3D atom_context->version;
> -                       memcpy(vbios_info.vbios_ver_str, atom_context->vb=
ios_ver_str,
> -                                               sizeof(atom_context->vbio=
s_ver_str));
> -                       memcpy(vbios_info.date, atom_context->date,
>
> sizeof(atom_context->date));
>
> +                       if (atom_context) {
> +                               memcpy(vbios_info.name, atom_context->nam=
e,
> +                                      sizeof(atom_context->name));
> +                               memcpy(vbios_info.vbios_pn, atom_context-=
>vbios_pn,
> +                                      sizeof(atom_context->vbios_pn));
> +                               vbios_info.version =3D atom_context->vers=
ion;
> +                               memcpy(vbios_info.vbios_ver_str, atom_con=
text-
> vbios_ver_str,
> +                                      sizeof(atom_context->vbios_ver_str=
));
> +                               memcpy(vbios_info.date, atom_context->dat=
e,
> +                                      sizeof(atom_context->date));
> +                       }
>
>                         return copy_to_user(out, &vbios_info,
>                                                 min((size_t)size, sizeof(=
vbios_info))) ? -EFAULT : 0;
> --
> 2.34.1
>
