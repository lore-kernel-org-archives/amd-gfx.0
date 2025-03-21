Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBD8C36000
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 19:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F89A10E82A;
	Fri, 21 Mar 2025 19:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J2p6uQDU";
	dkim-atps=neutral
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7040310E82A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 19:42:38 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-72b87587c61so264172a34.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742586157; x=1743190957; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6kKk59Ab4f9zo725Wk2WUUeEPcd13MEnX8W8aKqVJ3Q=;
 b=J2p6uQDUVG4ilJctw0xlBazKo7IiUATpp+f5GKy7xPgY7v5QcxFJuzyRNRAYx/g+PE
 MFQy5ejt4Un9PUUCh+Pj6RRdxxSxgoyge7B7Tbkq9F3qYjsvnHPZqAdiVQdZ4CW+0AcD
 RQLWMlwQIMIgA9AFUUeJbsh43hSN0zW1Q1A18GPcxGf8pnZHFB/QkHlv2Fb3zLqJKfTM
 Mj3dBFqPxWNEpEn1jeI7J+EzLZnJzAzs+aw2oEJfUihoCHsOp1fszD/nh7+p8tg0Czzy
 1JaNoeZiux4dFo3lzHnoc5QBLex6QtbaquXaIIoMCYDE3XyYZtr1nigQRk6V7NOLLvvN
 k+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742586157; x=1743190957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6kKk59Ab4f9zo725Wk2WUUeEPcd13MEnX8W8aKqVJ3Q=;
 b=Vdj4PJYabVLXxxWKSqQ3zpmYt+ufgf2BZw52uQXx4JiRSuhI75a3QiooZ9QWw7lTlE
 2+hQQ9elQbAk7hkgEW6pQFBMTJatvXuvLVPYmYy497W/gZA/G4Wfj3rnqkZmzA+p1AT5
 FJEG6cXAYy1sVXhiJelnjDzLlpEREGPQbGyuTc9OMHjPK5Ga3SscTRoGCxE6wiHi+xLj
 GbnbH86q0VXsXg3H/vYP5OFHbvUxb/WUkRNODjXbnZhBB5TC2HV/CsWW8o8/muioYBPr
 caTXbLLNN3RM/gm9hiT13jvgAynnhysPu3v0AMChHjLKwaW7vb8ctqPMWaFCjw9JWFdJ
 9iFA==
X-Gm-Message-State: AOJu0YzrlzDqK72bp79/Rtq2e8TSgBd8GEHLltSE8wgeOhuCjA2fbe22
 dl5Yos4IFQB5WorOH1J/yYkUUxeQ7t65kzYAUT9PAM8jRdBOMfqKBtmekOhu/snzAOR8LCJGkep
 QFO7fI+cSnpKXxL7Bo98DRXpQmYo=
X-Gm-Gg: ASbGncsjGiqiulyk/1a7PK7EboLLuQOuk//koRFZhJaG/KYWEwtoq58VBBHqTjPabe1
 huYr/9FRMEf0pERKE97kwtwDiedyWZSrWLcC2jcSzAMYvd9niq02ceLmCa8HY/TZcRQBl90pqwb
 BNswpQPb0Mnt7y8TPw3i/I/39P2Di1ZVeUpE5vEw==
X-Google-Smtp-Source: AGHT+IE5lVaOEGk5DUyBRt4/sqkM8/EJ9l6DMqrOrZaYmBvCGIqqQV7H4NNNbUnWMJ9RPac3T1V4g/6j+RQXMZsGS9k=
X-Received: by 2002:a05:6870:3294:b0:29e:6394:fd47 with SMTP id
 586e51a60fabf-2c7a380c535mr186980fac.4.1742586157385; Fri, 21 Mar 2025
 12:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250317212919.1018717-1-alexander.deucher@amd.com>
In-Reply-To: <20250317212919.1018717-1-alexander.deucher@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 21 Mar 2025 15:42:01 -0400
X-Gm-Features: AQ5f1JqWJPMSO-haUQJ-IGYLU8vZls-YgkofOfAXynTYIVtPfZZq8DlwPsR_PW8
Message-ID: <CAAxE2A5FxaUh7vtPdqC-c_tAtSzXOjonpBBUj8=C7HDbL-pR0w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add UAPI to query if user queues are supported
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, marek.olsak@amd.com, prike.liang@amd.com, 
 sunil.khatri@amd.com
Content-Type: multipart/alternative; boundary="000000000000e6cfbe0630df7474"
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

--000000000000e6cfbe0630df7474
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is not in device_info, but it'll do.

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

Marek

On Mon, Mar 17, 2025 at 5:38=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com>
wrote:

> Add an INFO query to check if user queues are supported.
>
> v2: switch to a mask of IPs (Marek)
>
> Cc: marek.olsak@amd.com
> Cc: prike.liang@amd.com
> Cc: sunil.khatri@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
>  include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 3b7dfd56ccd0e..1d683c0487697 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1340,6 +1340,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>                         return -EINVAL;
>                 }
>         }
> +       case AMDGPU_INFO_UQ_SUPPORTED: {
> +               struct drm_amdgpu_info_uq_supported uq_supported =3D {};
> +
> +               if (adev->userq_funcs[AMDGPU_HW_IP_GFX])
> +                       uq_supported.supported |=3D (1 << AMDGPU_HW_IP_GF=
X);
> +               if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE])
> +                       uq_supported.supported |=3D (1 <<
> AMDGPU_HW_IP_COMPUTE);
> +               if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
> +                       uq_supported.supported |=3D (1 << AMDGPU_HW_IP_DM=
A);
> +               ret =3D copy_to_user(out, &uq_supported,
> +                                  min((size_t)size,
> sizeof(uq_supported))) ? -EFAULT : 0;
> +               return 0;
> +       }
>         default:
>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>                 return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 5dbd9037afe75..4b64e91002c05 100644
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
> +       /** returns a mask for each IP type (1 << AMDGPU_HW_IP_*) */
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

--000000000000e6cfbe0630df7474
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This is not in device_info, but it&#39;ll do.</div><d=
iv><br></div><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:=
marek.olsak@amd.com">marek.olsak@amd.com</a>&gt;</div><div><br></div><div>M=
arek</div></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 17, 2025 at 5:38=E2=80=AFPM Ale=
x Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander.deuche=
r@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Add an INFO query to check if user queues are supported.<br>
<br>
v2: switch to a mask of IPs (Marek)<br>
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
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++<br>
=C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 8 ++++++++<br>
=C2=A02 files changed, 21 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 3b7dfd56ccd0e..1d683c0487697 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -1340,6 +1340,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_INFO_UQ_SUPPORTED: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_amdgpu_i=
nfo_uq_supported uq_supported =3D {};<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;userq_=
funcs[AMDGPU_HW_IP_GFX])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uq_supported.supported |=3D (1 &lt;&lt; AMDGPU_HW_IP_GFX);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;userq_=
funcs[AMDGPU_HW_IP_COMPUTE])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uq_supported.supported |=3D (1 &lt;&lt; AMDGPU_HW_IP_COMPUTE);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;userq_=
funcs[AMDGPU_HW_IP_DMA])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0uq_supported.supported |=3D (1 &lt;&lt; AMDGPU_HW_IP_DMA);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D copy_to_use=
r(out, &amp;uq_supported,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 min((size_t)size, sizeof(uq_s=
upported))) ? -EFAULT : 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_DEBUG_KMS(&quot=
;Invalid request %d\n&quot;, info-&gt;query);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 5dbd9037afe75..4b64e91002c05 100644<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/** returns a mask for each IP type (1 &lt;&lt;=
 AMDGPU_HW_IP_*) */<br>
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

--000000000000e6cfbe0630df7474--
