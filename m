Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C9FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A1110E900;
	Tue, 10 May 2022 20:14:31 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDDA10E900
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:14:31 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id 15so15526991pgf.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ilHamvQZew0uUAlId3EEnSHzpWlCsEZqmiWoJnriPLc=;
 b=BwuE3Ou42oZdu2eDcCNX8LzqN3iehDJ0HjNm8aN0nIlWwRyUw+fMwTofAcjeloOpyU
 3KbN7k73WTAmtvIwlChQA9cRx1b6lCYDOPrIldhfsLLrTgzFbafB9lJQroyaJWy0yBwD
 M+KeF80L94P28AKQZGe+svLVX2aXeX0Y6xsacXnOGjO/b2ZlalInR0ynVssBAwHIzeDK
 NLUhKoTCayIDFzu/UdgJ81HUFCfYizS7o8rGSIF3A1pdg7YLD7wmZkJJz0KJWh/b0s9E
 00Dl7dQlu/PWGZToNlGg9kKT6mHOh2btHoUmoug0eGtfdk59yilGaOsaZill9FVjfH7E
 aXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ilHamvQZew0uUAlId3EEnSHzpWlCsEZqmiWoJnriPLc=;
 b=tbg/8nb4JzLM4DpJiMUU3FCI0NMPH4OlK71Nucim/Ls2D4CiQM+OVbgnp7EF2e4sJT
 3IR6m2umOGvqyrvKp812WWv2CzE0mB+kIrkclCsENUz7Qlxx6kj23Y3V85k1ibG9UHGo
 e0Soj2YH9YyrCJAKFEcEKb60S46PORQ8qN8D//Rm1Jn8VRSyTNKacpPyoUXENtPjcESM
 zjWZarmAqjd3l9Q9HVDT8IQZRlpckHqsuJMqqs8RiWeU+jLBZKT9KfP7CN09phV55cs2
 JOqdiZ5q9OCzQkrPkyEoGZ8BglJ1DaD9Zy9xuJ8I/G5Zcc9znL75TEz15WPVSUEqcONQ
 hjng==
X-Gm-Message-State: AOAM5331Bcgg+04MsrvOQeBlkzJF0YxLQHbOFiyiy6OMqkQhx/YtK1ug
 BnAEBUd3Za07ClMe7Guqv15Y6MaQU7GBcUcFBVr29+dz
X-Google-Smtp-Source: ABdhPJwX66QlWZBlCNOHP0zYO1ht1NEIbRRXBH9XTct90YUyVwjQgujoShqMkjUd9F2NX1QtqPXOQZ4Rrlz9G8ksjOQ=
X-Received: by 2002:a63:9a11:0:b0:3a3:3a8a:1006 with SMTP id
 o17-20020a639a11000000b003a33a8a1006mr18081400pge.116.1652213670849; Tue, 10
 May 2022 13:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220506112312.347519-1-christian.koenig@amd.com>
In-Reply-To: <20220506112312.347519-1-christian.koenig@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 10 May 2022 16:13:54 -0400
Message-ID: <CAAxE2A4Bny50ywdTXi0MBV_Pb-onx0yVhPOsb2Lk9XtbJ1R4rQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: add AMDGPU_GEM_CREATE_DISCARDABLE
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f1afc305deadf8ad"
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000f1afc305deadf8ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does this really guarantee VRAM placement? The code doesn't say anything
about that.

Marek


On Fri, May 6, 2022 at 7:23 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Add a AMDGPU_GEM_CREATE_DISCARDABLE flag to note that the content of a BO
> doesn't needs to be preserved during eviction.
>
> KFD was already using a similar functionality for SVM BOs so replace the
> internal flag with the new UAPI.
>
> Only compile tested!
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c       | 2 +-
>  include/uapi/drm/amdgpu_drm.h              | 4 ++++
>  6 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 2e16484bf606..bf97d8f07f57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -302,8 +302,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev,
> void *data,
>                       AMDGPU_GEM_CREATE_VRAM_CLEARED |
>                       AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
>                       AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
> -                     AMDGPU_GEM_CREATE_ENCRYPTED))
> -
> +                     AMDGPU_GEM_CREATE_ENCRYPTED |
> +                     AMDGPU_GEM_CREATE_DISCARDABLE))
>                 return -EINVAL;
>
>         /* reject invalid gem domains */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 8b7ee1142d9a..1944ef37a61e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -567,6 +567,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>                 bp->domain;
>         bo->allowed_domains =3D bo->preferred_domains;
>         if (bp->type !=3D ttm_bo_type_kernel &&
> +           !(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE) &&
>             bo->allowed_domains =3D=3D AMDGPU_GEM_DOMAIN_VRAM)
>                 bo->allowed_domains |=3D AMDGPU_GEM_DOMAIN_GTT;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 4c9cbdc66995..147b79c10cbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -41,7 +41,6 @@
>
>  /* BO flag to indicate a KFD userptr BO */
>  #define AMDGPU_AMDKFD_CREATE_USERPTR_BO        (1ULL << 63)
> -#define AMDGPU_AMDKFD_CREATE_SVM_BO    (1ULL << 62)
>
>  #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user=
,
> bo)
>  #define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm, bo=
)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 41d6f604813d..ba3221a25e75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -117,7 +117,7 @@ static void amdgpu_evict_flags(struct
> ttm_buffer_object *bo,
>         }
>
>         abo =3D ttm_to_amdgpu_bo(bo);
> -       if (abo->flags & AMDGPU_AMDKFD_CREATE_SVM_BO) {
> +       if (abo->flags & AMDGPU_GEM_CREATE_DISCARDABLE) {
>                 placement->num_placement =3D 0;
>                 placement->num_busy_placement =3D 0;
>                 return;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 5ed8d9b549a4..835b5187f0b8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -531,7 +531,7 @@ svm_range_vram_node_new(struct amdgpu_device *adev,
> struct svm_range *prange,
>         bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>         bp.flags =3D AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>         bp.flags |=3D clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
> -       bp.flags |=3D AMDGPU_AMDKFD_CREATE_SVM_BO;
> +       bp.flags |=3D AMDGPU_GEM_CREATE_DISCARDABLE;
>         bp.type =3D ttm_bo_type_device;
>         bp.resv =3D NULL;
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 9a1d210d135d..57b9d8f0133a 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -140,6 +140,10 @@ extern "C" {
>   * not require GTT memory accounting
>   */
>  #define AMDGPU_GEM_CREATE_PREEMPTIBLE          (1 << 11)
> +/* Flag that BO can be discarded under memory pressure without keeping t=
he
> + * content.
> + */
> +#define AMDGPU_GEM_CREATE_DISCARDABLE          (1 << 12)
>
>  struct drm_amdgpu_gem_create_in  {
>         /** the requested memory size */
> --
> 2.25.1
>
>

--000000000000f1afc305deadf8ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Does this really guarantee VRAM placement? The code d=
oesn&#39;t say anything about that.</div><div><br></div><div>Marek<br></div=
><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Fri, May 6, 2022 at 7:23 AM Christian K=C3=B6nig &lt;<a href=3D"mai=
lto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Add a=
 AMDGPU_GEM_CREATE_DISCARDABLE flag to note that the content of a BO<br>
doesn&#39;t needs to be preserved during eviction.<br>
<br>
KFD was already using a similar functionality for SVM BOs so replace the<br=
>
internal flag with the new UAPI.<br>
<br>
Only compile tested!<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c=C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 +<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 1 -<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c=C2=A0 =C2=A0 | 2 +-<br>
=C2=A0drivers/gpu/drm/amd/amdkfd/kfd_svm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-=
<br>
=C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 4 ++++<br>
=C2=A06 files changed, 9 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c<br>
index 2e16484bf606..bf97d8f07f57 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
@@ -302,8 +302,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, voi=
d *data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AMDGPU_GEM_CREATE_VRAM_CLEARED |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 AMDGPU_GEM_CREATE_EXPLICIT_SYNC |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0AMDGPU_GEM_CREATE_ENCRYPTED))<br>
-<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0AMDGPU_GEM_CREATE_ENCRYPTED |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0AMDGPU_GEM_CREATE_DISCARDABLE))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* reject invalid gem domains */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index 8b7ee1142d9a..1944ef37a61e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -567,6 +567,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bp-&gt;domain;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;allowed_domains =3D bo-&gt;preferred_dom=
ains;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bp-&gt;type !=3D ttm_bo_type_kernel &amp;&a=
mp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(bp-&gt;flags &amp; AMDGPU_GEM_C=
REATE_DISCARDABLE) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;allowed_domains =3D=3D AMD=
GPU_GEM_DOMAIN_VRAM)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;allowed_doma=
ins |=3D AMDGPU_GEM_DOMAIN_GTT;<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h<br>
index 4c9cbdc66995..147b79c10cbb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
@@ -41,7 +41,6 @@<br>
<br>
=C2=A0/* BO flag to indicate a KFD userptr BO */<br>
=C2=A0#define AMDGPU_AMDKFD_CREATE_USERPTR_BO=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1=
ULL &lt;&lt; 63)<br>
-#define AMDGPU_AMDKFD_CREATE_SVM_BO=C2=A0 =C2=A0 (1ULL &lt;&lt; 62)<br>
<br>
=C2=A0#define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_u=
ser, bo)<br>
=C2=A0#define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm,=
 bo)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 41d6f604813d..ba3221a25e75 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -117,7 +117,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object=
 *bo,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 abo =3D ttm_to_amdgpu_bo(bo);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (abo-&gt;flags &amp; AMDGPU_AMDKFD_CREATE_SV=
M_BO) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (abo-&gt;flags &amp; AMDGPU_GEM_CREATE_DISCA=
RDABLE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 placement-&gt;num_p=
lacement =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 placement-&gt;num_b=
usy_placement =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c<br>
index 5ed8d9b549a4..835b5187f0b8 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<br>
@@ -531,7 +531,7 @@ svm_range_vram_node_new(struct amdgpu_device *adev, str=
uct svm_range *prange,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bp.flags =3D AMDGPU_GEM_CREATE_NO_CPU_ACCESS;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bp.flags |=3D clear ? AMDGPU_GEM_CREATE_VRAM_CL=
EARED : 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0bp.flags |=3D AMDGPU_AMDKFD_CREATE_SVM_BO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bp.flags |=3D AMDGPU_GEM_CREATE_DISCARDABLE;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bp.type =3D ttm_bo_type_device;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bp.resv =3D NULL;<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 9a1d210d135d..57b9d8f0133a 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -140,6 +140,10 @@ extern &quot;C&quot; {<br>
=C2=A0 * not require GTT memory accounting<br>
=C2=A0 */<br>
=C2=A0#define AMDGPU_GEM_CREATE_PREEMPTIBLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt; 11)<br>
+/* Flag that BO can be discarded under memory pressure without keeping the=
<br>
+ * content.<br>
+ */<br>
+#define AMDGPU_GEM_CREATE_DISCARDABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1=
 &lt;&lt; 12)<br>
<br>
=C2=A0struct drm_amdgpu_gem_create_in=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** the requested memory size */<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--000000000000f1afc305deadf8ad--
