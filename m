Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5001BC36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 05:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12C510E00C;
	Mon,  7 Apr 2025 05:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z5yFFSCF";
	dkim-atps=neutral
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0033F10E00C
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 05:40:22 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-6021b5d1c2fso321834eaf.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 06 Apr 2025 22:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744004422; x=1744609222; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lcQekedDka8GM+sZB3s0t0ImMA4H8JvoqX6cgQ+A6es=;
 b=Z5yFFSCF8TmPAKg8CQegEuDfVtxhw/Krf+lWliNX71h2SNnYwjW+ta+hvqJIu33eD1
 SLeZV3Nv/pFiqqhOatADaFcT6umLKvznmHI9DFPpSJGA0UoNXWGmDRTmzQah5hFpca0L
 +D0Pwl9tF5Fc/6+eaS2rBLccdfxYerlTvK+Ymp/rRXm4ggni8bUGcqPQcq6iBSx5k4rY
 Au0AuuAL86G5IaJH1gbteCp50uLMb18eX4k8Jqr/y2hwTt6QGu2Y3xZSCpwXzyznTGPZ
 WrtK79DpOkJjRbaUJvMLz0eeGxgowf3Gs/WVX2eDKx2bZSgAbpbAX1vsL+4WuCP3H0CN
 IJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744004422; x=1744609222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lcQekedDka8GM+sZB3s0t0ImMA4H8JvoqX6cgQ+A6es=;
 b=Nk5P39zLN13S3JqxM1LJa3VDtW5lJrBBMDo7chegXFL0wtk8flhUxk+qUzTIhjU6Sa
 D+WO3rK0thUXT7ELSRp70dmEqh9ENZRyc0CmbLPElrss0z2HnxPYvvOqM+kl9bqaMN3E
 1dCorFk6yp7N+76h+GI+qSnD+D0MzsEUm1nioiZKCguNtaRdQ99goTBAy6Z4gnMpu3//
 VQbEV7KiqQM+zh9KKQbecRqXpNAvrWBKfbyfhxdNcGaC40TQ6Rwnq0BPs2YzyGnEr+y5
 2rfhWcY194Wsrh3PqHBW5WugOZUN6IzgcQ8PRMxBtcs+7Bns+ta7jYYDZ34lvPd0xwZo
 rigw==
X-Gm-Message-State: AOJu0YzHJCmCSmwx23LdHxVXDiC/+2Q0FQvE0xw3+v4V/WzngyGSWT6A
 3t66dH985vvFfLf2I2MVg36AoBiwnTM2Mx5H2J6jI3ohlQJfQ2IHdjmTU+hWjgP8Y/DMvWuf8hG
 9lf5y4k/B1KodjC8GIxJ3svjgtks=
X-Gm-Gg: ASbGncvR4QZGnXkv8l6oJv5MunFHCTxHeFqPbC7+Ja4aNBGqIEYBdsyJ53cPHBiCWTl
 qQPB7EFL9iSEJ73H4HQV1IAcWOjN3JwBgKPsn2MO5fLgQq5bj5iHXQWMbGXDNDNpbfTIl7djPoo
 Eoi/HVO4CkRfvhAyNJZ/hGpqNrilg=
X-Google-Smtp-Source: AGHT+IG6nLrLmMquZfjhlJAk0Jl1Ao043WoaBEIwJRudoYzT5Ah7kfUBSKzvThCV74Qw6mmQi5z907IG0r6fWx41Kwk=
X-Received: by 2002:a05:6870:63a1:b0:29e:3b8e:66c8 with SMTP id
 586e51a60fabf-2cc9e5be818mr2203542fac.6.1744004421997; Sun, 06 Apr 2025
 22:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250324203328.4174703-1-alexander.deucher@amd.com>
In-Reply-To: <20250324203328.4174703-1-alexander.deucher@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 7 Apr 2025 01:39:45 -0400
X-Gm-Features: ATxdqUELL4udIvLc5OzXour95ASiemYQGSkRAINUnj6EJUP0yyouDrSnPEhCEIU
Message-ID: <CAAxE2A7N5ZAVsTrF91gX+9hvNv3MEt_wrnc_GrPVn3+sudHKeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add UAPI to query if user queues are
 supported
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, marek.olsak@amd.com, prike.liang@amd.com, 
 sunil.khatri@amd.com, yogesh.mohanmarimuthu@amd.com
Content-Type: multipart/alternative; boundary="0000000000000f5d4f063229ac9d"
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

--0000000000000f5d4f063229ac9d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

For both patches.

Marek

On Mon, Mar 24, 2025 at 4:34=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com>
wrote:

> Add an INFO query to check if user queues are supported.
>
> v2: switch to a mask of IPs (Marek)
> v3: move to drm_amdgpu_info_device (Marek)
>
> Cc: marek.olsak@amd.com
> Cc: prike.liang@amd.com
> Cc: sunil.khatri@amd.com
> Cc: yogesh.mohanmarimuthu@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++++
>  include/uapi/drm/amdgpu_drm.h           | 3 +++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 3b7dfd56ccd0e..0ba3ef1e4a068 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1009,6 +1009,13 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>                         }
>                 }
>
> +               if (adev->userq_funcs[AMDGPU_HW_IP_GFX])
> +                       dev_info->userq_ip_mask |=3D (1 << AMDGPU_HW_IP_G=
FX);
> +               if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE])
> +                       dev_info->userq_ip_mask |=3D (1 <<
> AMDGPU_HW_IP_COMPUTE);
> +               if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
> +                       dev_info->userq_ip_mask |=3D (1 << AMDGPU_HW_IP_D=
MA);
> +
>                 ret =3D copy_to_user(out, dev_info,
>                                    min((size_t)size, sizeof(*dev_info))) =
?
> -EFAULT : 0;
>                 kfree(dev_info);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 5dbd9037afe75..ef97c0d78b8a0 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1453,6 +1453,9 @@ struct drm_amdgpu_info_device {
>         __u32 csa_size;
>         /* context save area base virtual alignment for gfx11 */
>         __u32 csa_alignment;
> +       /* Userq IP mask (1 << AMDGPU_HW_IP_*) */
> +       __u32 userq_ip_mask;
> +       __u32 pad;
>  };
>
>  struct drm_amdgpu_info_hw_ip {
> --
> 2.49.0
>
>

--0000000000000f5d4f063229ac9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mai=
lto:marek.olsak@amd.com" target=3D"_blank">marek.olsak@amd.com</a>&gt;</div=
><div><br></div><div>For both patches.</div><div><br></div><div>Marek</div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Mon, Mar 24, 2025 at 4:34=E2=80=AFPM Alex Deucher &lt;<a href=3D"mailto:=
alexander.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add a=
n INFO query to check if user queues are supported.<br>
<br>
v2: switch to a mask of IPs (Marek)<br>
v3: move to drm_amdgpu_info_device (Marek)<br>
<br>
Cc: <a href=3D"mailto:marek.olsak@amd.com" target=3D"_blank">marek.olsak@am=
d.com</a><br>
Cc: <a href=3D"mailto:prike.liang@amd.com" target=3D"_blank">prike.liang@am=
d.com</a><br>
Cc: <a href=3D"mailto:sunil.khatri@amd.com" target=3D"_blank">sunil.khatri@=
amd.com</a><br>
Cc: <a href=3D"mailto:yogesh.mohanmarimuthu@amd.com" target=3D"_blank">yoge=
sh.mohanmarimuthu@amd.com</a><br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++++<br>
=C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 3 +++<br>
=C2=A02 files changed, 10 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 3b7dfd56ccd0e..0ba3ef1e4a068 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -1009,6 +1009,13 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;userq_=
funcs[AMDGPU_HW_IP_GFX])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info-&gt;userq_ip_mask |=3D (1 &lt;&lt; AMDGPU_HW_IP_GFX);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;userq_=
funcs[AMDGPU_HW_IP_COMPUTE])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info-&gt;userq_ip_mask |=3D (1 &lt;&lt; AMDGPU_HW_IP_COMPUTE)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;userq_=
funcs[AMDGPU_HW_IP_DMA])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info-&gt;userq_ip_mask |=3D (1 &lt;&lt; AMDGPU_HW_IP_DMA);<br=
>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D copy_to_use=
r(out, dev_info,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0min((size_t)size, sizeo=
f(*dev_info))) ? -EFAULT : 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(dev_info);<br=
>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 5dbd9037afe75..ef97c0d78b8a0 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -1453,6 +1453,9 @@ struct drm_amdgpu_info_device {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 csa_size;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* context save area base virtual alignment for=
 gfx11 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __u32 csa_alignment;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Userq IP mask (1 &lt;&lt; AMDGPU_HW_IP_*) */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 userq_ip_mask;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 pad;<br>
=C2=A0};<br>
<br>
=C2=A0struct drm_amdgpu_info_hw_ip {<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div>

--0000000000000f5d4f063229ac9d--
