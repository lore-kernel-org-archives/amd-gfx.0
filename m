Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676F606A322
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GTycYspk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707AE10F3E3;
	Mon, 16 Nov 2026 19:34:04 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE3910F3E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:33:58 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-4e5c8b3facaso405994b6e.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 11:33:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794857638; cv=none;
 d=google.com; s=arc-20260327;
 b=MyaSYW2+Vj6TENmeave6bnBm5kp1u0Vf+1KicHQCCDu//PQ7gYC1kaJsXM94GYhNlZ
 P7OZRqBvMle73mc6Izv6UP2SD58OUC+MXDiVqRw1VpAg8pQymgS/FzDGuPfJHpCKGg9v
 uoGFDgRMMmNwfGukvAsmJ5riuj+kzmpRASTr68Zs8eBBJsTbn/o8qxZqrXZEkq6Ys9Kl
 hXqlcgh5anW3wr293X5aQ9u+j8EueK0yTbw8Pes2oM2OYWBfIKx+yeMjjzHjA4stQmkX
 SSQ+A2vWNteq0/LJ17f3yuhjOyODrUF0O54RaFsm9vxIxDS02t8LXlvcMqibooPayvX7
 HrNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AYl3rNA8kxSgOuLzPix9dXced/6F96fQJPkQk2HEVuo=;
 fh=hxQk/uZpkXs5H9xvSBgSM9HoyHLdZh6wDCcQc548gy4=;
 b=d0EDOSQvaHa0FmO6vAsXDP7bzyGnBH4ntFqcygHzmB2hlv8Ngtru7lrcWHB75nNXWa
 1Sep3iDnQRxp+JhQ+EpNhHKLsSS8G584KqCeXE387kUPpmwBMPI5IGXrNYb7XIIkxdAD
 8635ZGLc+T8Ms2iYOqWHaLR8w7hkB4wC+m9DAi42VMT0RmtPnT/Ew1nHXC5IKv/3QNar
 nRiyhWKaF877ZGYQNd45hSSIxtf68acya19UDlWGyAYr0tlUqnNfwjHaGHH2UN7J9aSM
 Z3c0xkiXiYjXkak50tugLbLOR7Nnk+5cwib8M//vgpMPke1ME3n4yfk+C5jLepIO4+Ja
 OIbQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794857638; x=1795462438; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AYl3rNA8kxSgOuLzPix9dXced/6F96fQJPkQk2HEVuo=;
 b=GTycYspkGfZ1j7SzVlAOtI4CDkM+krv2Xu6CooR+XTlyOcX4dT+c9FB3M4s/4y+xNd
 OKcsGbgb/u2lSLK9LUVA1TdYtQDjjCG06Tt8xtqgwxdTeGCHTEBsY1u3qt/NBec5Y+8p
 VSwvLYjQuV3dkSd8gLSNhN2ZlK0nf2tCtMklfEn7oX0SnBindo47uSP7glZp9bvAtXAl
 dfq6H+D9BfKk8L5AJptUlDgnQ7hYyDbWxaan7YJC6CKMNCZNEAYnRTLS9xsY9Ef7AjXZ
 S9JLry99Gw+4tz2kZhsGVsX0SE+pD+xEwSIhMTOqUZoL/X4a0v2fBn6kgHig5s71Spai
 maRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794857638; x=1795462438;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AYl3rNA8kxSgOuLzPix9dXced/6F96fQJPkQk2HEVuo=;
 b=LM28xToT018MY58WHc+uSHNlhev6wbteG1vfdr0MIL4XxGgCvHnKFOuUVdgzxFTONd
 Aax/uhq0kkCVj6k4d6ChqcHA0+Y7+fbg8X+Ufva73rdLS46sgFYXOosTZWn2WBf2M5N/
 pg4AP76tC3SPM5Y2MsqP9MIaeHOEVabBU4VnoAF9ae33yq9og8pgUWNnAb/kL/LDfICD
 TeLDs8bX8DkPOyTuZ6nTDNUdNQ4m7jCuwB3CodmC+2PC3tW3gMdKqSV4uWDFmXtTt3JM
 ILGM+t85KZC0UcXlCpxHKQpWZXOBBj8y+eETst7DT7JU+KEaGvMQfLhsLyhCa4tV73rq
 9O8g==
X-Gm-Message-State: APuU4Z+CFCg3lgXiEdtL+VkC8a8DGN4J21lyXyzgk59SbCOmwAsQpvCN
 +PfyBfx+RdzuiNaUNLLZdLGF1DNqxmp36VTH1Sk3YR+Jg253c+bctB4gKsiXtE7uMHZlkyDa4BN
 w1esLDNcBIB49GM9x90Hby8g+9AruurkU4Q==
X-Gm-Gg: AYBFou1UzHA6Wxm410TjTC80xQ65LgEY7ulOt0Iz0lO1wcnNHcQbAY7KsfUQHfRRKcj
 mbfdBCRQr6WkxVTh6QclKAHUYgJXmVa0R8kGxUGY9aWxGQUpKku52FU87eXJgBlEVuGvJ3Is07J
 Galz120iIkSoKaiPHJvKpTf2tj6JWmAFAFuOLLLbPUt5CydVw6Hp8RUVG/jOOL5rdT8FAlBnaEF
 CQbVY/uU5wkp2jGi4GmExV8SNYfhGEWPh1cPS00WIUFkqPN1mIVB8EfVebgOJj2j3Bw0fxyqdBi
 peTvsfhcigwPYBMCDLcurtmbX6l0otiFWUYiq0RG+w21CcQFiE/YR9PqaklkDGEuJ/E8Yf60NLr
 EF9zj60HknBZ49zTlk5TRLOdhcr3i7SRBakUuV1wxQ/hIYQa+BF5zfD6qziOkNNewGdde3F4hvB
 PYy/M3RaY06h9IbjThS/udlDELWIg3lwxpOq40SdtRVuQ7OaT501RmxVY7Oag=
X-Received: by 2002:a05:6809:8c:10b0:574:6f37:6720 with SMTP id
 5614622812f47-5746f3797aemr3365015b6e.2.1794857637783; Mon, 16 Nov 2026
 11:33:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116161310.3664509-1-siwei.he@amd.com>
 <20261116161310.3664509-2-siwei.he@amd.com>
In-Reply-To: <20261116161310.3664509-2-siwei.he@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Nov 2026 14:33:46 -0500
X-Gm-Features: AclHuK_ijvRMdxfmJB7FYKEgBfRFsjjtT9G9fIwjCCJWZia3L935E2fpWKmRSIc
Message-ID: <CADnq5_NcAEv4ud3s=kUK0WvJjNMy7H3zKJaPCF-raiZtBy-oZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: use logical XCC indices in
 AMDGPU_INFO_CU_BITMAP
To: Siwei He <siwei.he@amd.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, 
 harish.kasiviswanathan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 11:21=E2=80=AFAM Siwei He <siwei.he@amd.com> wrote:
>
> Use logical XCC indices in AMDGPU_INFO_CU_BITMAP in no-partition
> fallback. Also, stop clamping inst_mask to AMDGPU_MAX_GC_INSTANCES.
> Reject with -EOPNOTSUPP so the caller can fall back.
>
> Signed-off-by: Siwei He <siwei.he@amd.com>

Seems like this should be squashed into the first patch.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  5 +++--
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 7a0a1d5542ee..850de3be1659 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2072,11 +2072,17 @@ int amdgpu_gfx_get_cu_bitmap(struct amdgpu_device=
 *adev, u32 inst_mask,
>         u32 num_se, num_sa, sh_mul, se, sa, n =3D 0;
>         int xcc;
>
> -       /* cu_info.bitmap[] only has AMDGPU_MAX_GC_INSTANCES slots */
> -       inst_mask &=3D GENMASK(AMDGPU_MAX_GC_INSTANCES - 1, 0);
>         if (!inst_mask)
>                 return -ENODEV;
>
> +       /* cu_info.bitmap[] only has AMDGPU_MAX_GC_INSTANCES slots */
> +       if (inst_mask & ~GENMASK(AMDGPU_MAX_GC_INSTANCES - 1, 0)) {
> +               dev_warn_once(adev->dev,
> +                             "CU bitmap: %u XCCs exceeds %u slots\n",
> +                             hweight32(inst_mask), AMDGPU_MAX_GC_INSTANC=
ES);
> +               return -EOPNOTSUPP;
> +       }
> +
>         num_se =3D config->max_shader_engines;
>         num_sa =3D config->max_sh_per_se;
>         if (!num_se || !num_sa)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index a8ebc85c9b88..50943ec18b27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1469,10 +1469,11 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *filp)
>                         if (ret)
>                                 return ret;
>                 } else {
> -                       inst_mask =3D adev->gfx.xcc_mask ? adev->gfx.xcc_=
mask : 1;
> +                       /* inst_mask is a logical mask */
> +                       inst_mask =3D adev->gfx.xcc_mask ?
> +                               GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, =
0) : 1;
>                 }
>
> -               inst_mask &=3D GENMASK(AMDGPU_MAX_GC_INSTANCES - 1, 0);
>                 num_xcc =3D hweight32(inst_mask);
>                 num_se =3D adev->gfx.config.max_shader_engines;
>                 num_sa =3D adev->gfx.config.max_sh_per_se;
> --
> 2.43.0
>
