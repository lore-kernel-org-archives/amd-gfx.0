Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11333C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 20:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69F010E197;
	Mon, 17 Mar 2025 20:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HZYXt8ss";
	dkim-atps=neutral
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E99D10E197
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 20:44:00 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-601c848abfbso630513eaf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 13:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742244239; x=1742849039; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=//evFCENm5KOBilqjTHh2Wc0cWYTP8OYIK+6oyAt83I=;
 b=HZYXt8ssnLxluMn6JXabZ2gudT4uFx1hm3KVdGBsLZmqxcVKaI3t0FXy2plu5WSOuA
 PD4MjlZJpp6knSdDRSMkS3t0FaZO12t5StM8Gk7Si1OANi5YWQRWbuhAMo9bqU9zCJ+V
 ZhVaRixxsyw67kfHDoJQmcL043Q4QcSXiD1RJVQsVB28zEAZ4cRm+5QGhpfQCgKNQwsd
 iACDKEnCRItV3RafzlW9G3xh+wN3VHfb4H4sme/E5JHS4GGSIlGIYMKJufObIRmqPGXQ
 IwL5Uu7Ugyrlpmv95hYFdcvV4kbHK6f+iD+emPgcunUdFxKH/xMsS+690munYIJ2ILJq
 6YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742244239; x=1742849039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=//evFCENm5KOBilqjTHh2Wc0cWYTP8OYIK+6oyAt83I=;
 b=vzYGHcDKPzI2V0+udEol9BnWy/wCadsUOk4cy2LRJCV92mNqzoG36ak435koJMQ/IW
 wAohGMBzAeatyOiqRSzqgFI+0jVR3X/7GRylyadhWvZ3H+hxwydBUKxYZh5DzqqhdxrO
 q+uvXnarYsbjHHN3yDIokfwmCta59QDShh/LQzjvLIUbUP+qKneN7Gg5j3B5PLKEVTCo
 swm2LojOxwbWbJTSXloICx6SIzMkSVnUBaDHjsUZ6+DMY+U7tkYB72tCKYDU/DMwpRiZ
 g6ugBlyTAFfc0Jhjt91jRaMMBd/nZbbyw7KQg/6VhRmyA4R7JEUMomE45p8NTEn/Hvhh
 DkhA==
X-Gm-Message-State: AOJu0YwgYE9vLwRToSoKlETvFc6mSPHilegRDCgOxsa4kGWZwk8i8cyF
 fz4JjAeZOJwuPUfFeuziwhtvBbDyZal9Upmm04s0O+37Ibihj5dwjd3NL91FkAl2XDNxd6jRR1D
 LBx7thoU4rhsQZ3xJtW0Hkk/k5uFqwQ==
X-Gm-Gg: ASbGncvbRI9sRn3Yy0qHwo0wUA6vdCEeosKj98n2ojuV1Gw4Hd6BaN6NijC2WJCsIn2
 84sNYGWHnTYoXYbClCcPWNEV5YjraPtTUyjn2+CX03IhCDAGegYladBm/YnQn3UF2e5XrPIbNmD
 ehy9nKCzgV+lP72+5YO5/4hfmxfIs=
X-Google-Smtp-Source: AGHT+IEzlHxBN3j0igpA7Tp3x5BzDSfisqOe945+Jmyc8BrdHHsaHu5wJBJczNTz3iKenlhU6haZlCXCDdOYP/rbp0U=
X-Received: by 2002:a05:6870:1649:b0:2b8:f99d:7ce6 with SMTP id
 586e51a60fabf-2c690e9eb05mr2732771fac.3.1742244239366; Mon, 17 Mar 2025
 13:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250317191349.942719-1-alexander.deucher@amd.com>
In-Reply-To: <20250317191349.942719-1-alexander.deucher@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 17 Mar 2025 16:43:23 -0400
X-Gm-Features: AQ5f1JrWD9rWMkFQgXXMjEGf_p-pWWLHiA60PXJ2_7KGW6fkJFAPI5XjnulSgEc
Message-ID: <CAAxE2A5f3bx=yFDRgqsE8uK4QvO_gSkq5fHQm7s10UR3Us1Saw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add UAPI to query if user queues are supported
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, marek.olsak@amd.com, prike.liang@amd.com, 
 sunil.khatri@amd.com
Content-Type: multipart/alternative; boundary="000000000000ffe37406308fd805"
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

--000000000000ffe37406308fd805
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would prefer a bitmask of supported UQ IPs in device info, but this is
fine too.

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

Marek

On Mon, Mar 17, 2025 at 3:23=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com>
wrote:

> Add an INFO query to check if user queues are supported.
>
> Cc: marek.olsak@amd.com
> Cc: prike.liang@amd.com
> Cc: sunil.khatri@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 17 +++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 3b7dfd56ccd0e..38b8983f59d3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1340,6 +1340,23 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>                         return -EINVAL;
>                 }
>         }
> +       case AMDGPU_INFO_UQ_SUPPORTED: {
> +               struct drm_amdgpu_info_uq_supported uq_supported =3D {};
> +               u32 ip_type =3D info->query_hw_ip.type;
> +
> +               switch (ip_type) {
> +               case AMDGPU_HW_IP_GFX:
> +               case AMDGPU_HW_IP_COMPUTE:
> +               case AMDGPU_HW_IP_DMA:
> +                       if (adev->userq_funcs[ip_type])
> +                               uq_supported.supported =3D 1;
> +                       ret =3D copy_to_user(out, &uq_supported,
> +                                          min((size_t)size,
> sizeof(uq_supported))) ? -EFAULT : 0;
> +                       return 0;
> +               default:
> +                       return -EINVAL;
> +               }
> +       }
>         default:
>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>                 return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 5dbd9037afe75..b4b6fe006af8e 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1195,6 +1195,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_GPUVM_FAULT                        0x23
>  /* query FW object size and alignment */
>  #define AMDGPU_INFO_UQ_FW_AREAS                        0x24
> +/* query if user queues are supported */
> +#define AMDGPU_INFO_UQ_SUPPORTED               0x25
>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> @@ -1572,6 +1574,12 @@ struct drm_amdgpu_info_uq_metadata {
>         };
>  };
>
> +struct drm_amdgpu_info_uq_supported {
> +       /** returns 1 if supported, 0 if not supported */
> +       __u32   supported;
> +       __u32   pad;
> +};
> +
>  /*
>   * Supported GPU families
>   */
> --
> 2.48.1
>
>

--000000000000ffe37406308fd805
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I would prefer a bitmask of supported UQ IPs in devic=
e info, but this is fine too.</div><div><br></div><div>Reviewed-by: Marek O=
l=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak@amd.com">marek.olsak@amd.c=
om</a>&gt;</div><div><br></div><div>Marek</div></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon=
, Mar 17, 2025 at 3:23=E2=80=AFPM Alex Deucher &lt;<a href=3D"mailto:alexan=
der.deucher@amd.com">alexander.deucher@amd.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Add an INFO query to check if=
 user queues are supported.<br>
<br>
Cc: <a href=3D"mailto:marek.olsak@amd.com" target=3D"_blank">marek.olsak@am=
d.com</a><br>
Cc: <a href=3D"mailto:prike.liang@amd.com" target=3D"_blank">prike.liang@am=
d.com</a><br>
Cc: <a href=3D"mailto:sunil.khatri@amd.com" target=3D"_blank">sunil.khatri@=
amd.com</a><br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 17 +++++++++++++++++<br>
=C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 8 ++++++++<br>
=C2=A02 files changed, 25 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 3b7dfd56ccd0e..38b8983f59d3c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -1340,6 +1340,23 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_INFO_UQ_SUPPORTED: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_i=
nfo_uq_supported uq_supported =3D {};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 ip_type =3D inf=
o-&gt;query_hw_ip.type;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (ip_type) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_HW_IP_G=
FX:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_HW_IP_C=
OMPUTE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_HW_IP_D=
MA:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (adev-&gt;userq_funcs[ip_type])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uq_supported.supported =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D copy_to_user(out, &amp;uq_supported,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m=
in((size_t)size, sizeof(uq_supported))) ? -EFAULT : 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_DEBUG_KMS(&quot=
;Invalid request %d\n&quot;, info-&gt;query);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 5dbd9037afe75..b4b6fe006af8e 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -1195,6 +1195,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {<br>
=C2=A0#define AMDGPU_INFO_GPUVM_FAULT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x23<br>
=C2=A0/* query FW object size and alignment */<br>
=C2=A0#define AMDGPU_INFO_UQ_FW_AREAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x24<br>
+/* query if user queues are supported */<br>
+#define AMDGPU_INFO_UQ_SUPPORTED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x25<br>
<br>
=C2=A0#define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0<br>
=C2=A0#define AMDGPU_INFO_MMR_SE_INDEX_MASK=C2=A0 0xff<br>
@@ -1572,6 +1574,12 @@ struct drm_amdgpu_info_uq_metadata {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
=C2=A0};<br>
<br>
+struct drm_amdgpu_info_uq_supported {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/** returns 1 if supported, 0 if not supported =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0supported;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 =C2=A0pad;<br>
+};<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Supported GPU families<br>
=C2=A0 */<br>
-- <br>
2.48.1<br>
<br>
</blockquote></div>

--000000000000ffe37406308fd805--
