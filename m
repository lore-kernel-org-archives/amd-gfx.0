Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5A8C83F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 14:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C24610E54E;
	Tue,  5 Sep 2023 14:53:11 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0B710E54E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 14:53:10 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ab244ef065so1811922b6e.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693925589; x=1694530389; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLJdzQcW0SFxcemcaVrhBQ47vIs3wGbidL61NRwqa1I=;
 b=j59p7QZktoRftz2e4Vw8dUvn+u3NLN+PS/7TbDbxFO67C/I/VKIIMZMW7WC5xYmTRe
 U3yicXfb2Rm+mge7S9jzHypyFehkQx0sWbQVEzvQNHXdYwIcq/8dq4nAITbq5m4T+s3A
 PHsaozhhxP3Sn+BU9ND6SLOf2AyACdC6q8gCjd4LalH7HI6pU0Kz9FyFv0N1O7MocfQn
 NCbf/5PilwF/DRKrUDlCg3ZGgGtAKzcjUgPNlznDExkzhNmNtoJTydWV6XGUZmtFeByx
 OuIYJNQmDHeHMhw6aEj7KVxFXg7F2Awelxq5CsFik0VMwRIVl62uBQaAvZ3/pTbB0B7m
 Pxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693925589; x=1694530389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLJdzQcW0SFxcemcaVrhBQ47vIs3wGbidL61NRwqa1I=;
 b=boXfGPdCJBAxu+iEatujq4G0oEuxfM78Kif2vWSWVE/sCzM1TR6V39JwUeL/xbOCE0
 heH1KyAeTQ513EkpUKmTLd8RXjNev1krdRSsbVjBGCMtfJ4NT2SN9iEYlPD5eyeXH2Kt
 ZSGpZ0w2f0Y9YB5ePn9Sjozo7d28SRk5O1GFNg515c+thTCtKqYxfPl1XQ9R8ImF4NbP
 goAuyux1rHS4ZwHvKRzQs9CtxO9g8vX90L/buvD4N8nz4KFvqINvbhr5x8wqlSQnUYKC
 h3NVu9vq+O+MpI2c8CISfzg5MasYXMDixS2XdbNR82rD1FVgrH11mYiKr+JX9ItxHxZJ
 Q70A==
X-Gm-Message-State: AOJu0Yyb8kKAyjtrGcqbB82OI7M8gtobWoCJ4xKddpAdiwBLdg4ArpqK
 HzicCIYIEaKpQckWwxhqTpESvZH6K7ChRoAnMFGK3QDe
X-Google-Smtp-Source: AGHT+IEzcyazkb1ESrHjPhbLcvtwSM3HItoe5JzAkBMFOIvvO0lbcdRd4lYZvlp1b5fYvhmrjoyPG8rXnTjn2u7BzJw=
X-Received: by 2002:a05:6870:311f:b0:1bf:df47:7b5e with SMTP id
 v31-20020a056870311f00b001bfdf477b5emr17610831oaa.16.1693925589617; Tue, 05
 Sep 2023 07:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230905142432.99760-1-David.Francis@amd.com>
In-Reply-To: <20230905142432.99760-1-David.Francis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 10:52:58 -0400
Message-ID: <CADnq5_PtnU9OR4-kYJ2MLqyZhhd0N+y=A7XwdqRfFzNSNv1AKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Handle null atom context in VBIOS info ioctl
To: David Francis <David.Francis@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 5, 2023 at 10:50=E2=80=AFAM David Francis <David.Francis@amd.co=
m> wrote:
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 3a48bec10aea..86748290ead7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -947,16 +947,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>                                         ? -EFAULT : 0;
>                 }
>                 case AMDGPU_INFO_VBIOS_INFO: {
> -                       struct drm_amdgpu_info_vbios vbios_info =3D {};
> +                       struct drm_amdgpu_info_vbios vbios_info =3D {0};

IIRC, these should be equivalent.  That said, I believe memset is
generally preferred as not all compilers seem to handle these cases
correctly.

Alex

>                         struct atom_context *atom_context;
>
>                         atom_context =3D adev->mode_info.atom_context;
> -                       memcpy(vbios_info.name, atom_context->name, sizeo=
f(atom_context->name));
> -                       memcpy(vbios_info.vbios_pn, atom_context->vbios_p=
n, sizeof(atom_context->vbios_pn));
> -                       vbios_info.version =3D atom_context->version;
> -                       memcpy(vbios_info.vbios_ver_str, atom_context->vb=
ios_ver_str,
> -                                               sizeof(atom_context->vbio=
s_ver_str));
> -                       memcpy(vbios_info.date, atom_context->date, sizeo=
f(atom_context->date));
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
text->vbios_ver_str,
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
