Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA75C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 21:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D624A10EA72;
	Tue, 10 May 2022 21:22:16 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE4E10E906
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 21:22:15 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id fv2so344394pjb.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dpJqLwpXW1iiPMXudJnJRr2j8FLoL6wJh/A3X7BAzAE=;
 b=AitysmPY98Qi+KXjx/J7rVI4y1Xgx/IsLIDltoEOPeyUj+N+/3eOaKhBLBirLvBlY3
 aA3b7yNtgLDy2+NXiEfekwrzQXbTVE67il9ASOjL5VkzywY9FiNdwa7c1cV27dvQktK8
 97HDnmaxkB919UwcEmUwl3GIoo8CbOzV/fS4Aj5XiqjsfeFwiaeOfJskZKve/U0MxFBY
 jBiE8NQvrpLTW9Ew1X6SdYOCrovyDrw2Xoa5Bx1eNlEKBANuYBGWFsMYPIFnw3IG0YWg
 b1BhbwW3wbE+wtDJz7HDG9yPYJ9JXe9jWaipFlemUhNBeNgfwFkq2oWyw31LKaHic5v/
 9aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dpJqLwpXW1iiPMXudJnJRr2j8FLoL6wJh/A3X7BAzAE=;
 b=Cjafrw+GbXmF9TzKo4+tJlFAxxpDh8fB3tpdAq0NETftN7zp81x/8hoXZNncYeX/et
 R1ICQET2VrGundZ3cQgpyuz9mLVWad7OSf3QIJzHZbx2gMNGTtEfeWWZDljRoXlyiOz3
 zYXARCScwKwh4tG/PRdAXf6R3MD9XxDQrh4AF2Ny7/L0wsrnMCjif2NwO7pHF/BfNU8K
 lEC9eoe5ZbPLKEMKUhO6rJsQqpGr7iQT7cF8WR2+L8vPqNCAqITneaTQhO9UEhMMex2y
 lKXVIZ0xlKTDQKlhfJ9HcEjlM9fccI7WYJ8nOmZu6QgcTQo8wtB7HpjY4VzFmhUggSGQ
 72tQ==
X-Gm-Message-State: AOAM530PvfZfENimgCAi77cW5DU9LcHV9eMjqBdeD/u+50yoHdRIiCR9
 UCsmnSLCPFppkur6JNKMIWK5n3etN25i5cy1tKA=
X-Google-Smtp-Source: ABdhPJweq6kyL3Jv3LQthkuUKpERWWCTGfYqc5VSsH50zNOtalUS4jj/7mDmrCh/T2LaWJWuovePMf6/LfWk0Xx8Hc8=
X-Received: by 2002:a17:903:18a:b0:15e:c983:7c2e with SMTP id
 z10-20020a170903018a00b0015ec9837c2emr21865688plg.29.1652217734893; Tue, 10
 May 2022 14:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <20220506112312.347519-2-christian.koenig@amd.com>
In-Reply-To: <20220506112312.347519-2-christian.koenig@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 10 May 2022 17:21:38 -0400
Message-ID: <CAAxE2A7+-MKrh1BoXhGNBY38_7PkvrmZvn-tg4-4CFNXBvdKqw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: add AMDGPU_VM_NOALLOC
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000002e154505deaeeb46"
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

--0000000000002e154505deaeeb46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A better name would be:
AMDGPU_VM_PAGE_BYPASS_MALL

Marek

On Fri, May 6, 2022 at 7:23 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Add the AMDGPU_VM_NOALLOC flag to let userspace control MALL allocation.
>
> Only compile tested!
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 3 +++
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 3 +++
>  include/uapi/drm/amdgpu_drm.h           | 2 ++
>  4 files changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index bf97d8f07f57..d8129626581f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -650,6 +650,8 @@ uint64_t amdgpu_gem_va_map_flags(struct amdgpu_device
> *adev, uint32_t flags)
>                 pte_flag |=3D AMDGPU_PTE_WRITEABLE;
>         if (flags & AMDGPU_VM_PAGE_PRT)
>                 pte_flag |=3D AMDGPU_PTE_PRT;
> +       if (flags & AMDGPU_VM_PAGE_NOALLOC)
> +               pte_flag |=3D AMDGPU_PTE_NOALLOC;
>
>         if (adev->gmc.gmc_funcs->map_mtype)
>                 pte_flag |=3D amdgpu_gmc_map_mtype(adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index b8c79789e1e4..9077dfccaf3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -613,6 +613,9 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device
> *adev,
>         *flags &=3D ~AMDGPU_PTE_MTYPE_NV10_MASK;
>         *flags |=3D (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
>
> +       *flags &=3D ~AMDGPU_PTE_NOALLOC;
> +       *flags |=3D (mapping->flags & AMDGPU_PTE_NOALLOC);
> +
>         if (mapping->flags & AMDGPU_PTE_PRT) {
>                 *flags |=3D AMDGPU_PTE_PRT;
>                 *flags |=3D AMDGPU_PTE_SNOOPED;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 8d733eeac556..32ee56adb602 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -508,6 +508,9 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device
> *adev,
>         *flags &=3D ~AMDGPU_PTE_MTYPE_NV10_MASK;
>         *flags |=3D (mapping->flags & AMDGPU_PTE_MTYPE_NV10_MASK);
>
> +       *flags &=3D ~AMDGPU_PTE_NOALLOC;
> +       *flags |=3D (mapping->flags & AMDGPU_PTE_NOALLOC);
> +
>         if (mapping->flags & AMDGPU_PTE_PRT) {
>                 *flags |=3D AMDGPU_PTE_PRT;
>                 *flags |=3D AMDGPU_PTE_SNOOPED;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 57b9d8f0133a..9d71d6330687 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {
>  #define AMDGPU_VM_MTYPE_UC             (4 << 5)
>  /* Use Read Write MTYPE instead of default MTYPE */
>  #define AMDGPU_VM_MTYPE_RW             (5 << 5)
> +/* don't allocate MALL */
> +#define AMDGPU_VM_PAGE_NOALLOC         (1 << 9)
>
>  struct drm_amdgpu_gem_va {
>         /** GEM object handle */
> --
> 2.25.1
>
>

--0000000000002e154505deaeeb46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>A better name would be:</div><div>AMDGPU_VM_PAGE_BYPA=
SS_MALL</div><div><br></div><div>Marek<br></div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 6, 2022 at 7:23=
 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail=
.com">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">Add the AMDGPU_VM_NOALLOC flag to let=
 userspace control MALL allocation.<br>
<br>
Only compile tested!<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 ++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c=C2=A0 | 3 +++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c=C2=A0 | 3 +++<br>
=C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 2 ++<br>
=C2=A04 files changed, 10 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c<br>
index bf97d8f07f57..d8129626581f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
@@ -650,6 +650,8 @@ uint64_t amdgpu_gem_va_map_flags(struct amdgpu_device *=
adev, uint32_t flags)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pte_flag |=3D AMDGP=
U_PTE_WRITEABLE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags &amp; AMDGPU_VM_PAGE_PRT)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pte_flag |=3D AMDGP=
U_PTE_PRT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &amp; AMDGPU_VM_PAGE_NOALLOC)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pte_flag |=3D AMDGP=
U_PTE_NOALLOC;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;gmc.gmc_funcs-&gt;map_mtype)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pte_flag |=3D amdgp=
u_gmc_map_mtype(adev,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index b8c79789e1e4..9077dfccaf3c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -613,6 +613,9 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *=
adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags &amp;=3D ~AMDGPU_PTE_MTYPE_NV10_MASK;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D (mapping-&gt;flags &amp; AMDGPU_PTE=
_MTYPE_NV10_MASK);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*flags &amp;=3D ~AMDGPU_PTE_NOALLOC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*flags |=3D (mapping-&gt;flags &amp; AMDGPU_PTE=
_NOALLOC);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mapping-&gt;flags &amp; AMDGPU_PTE_PRT) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D AMDGPU_=
PTE_PRT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D AMDGPU_=
PTE_SNOOPED;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c<br>
index 8d733eeac556..32ee56adb602 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c<br>
@@ -508,6 +508,9 @@ static void gmc_v11_0_get_vm_pte(struct amdgpu_device *=
adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags &amp;=3D ~AMDGPU_PTE_MTYPE_NV10_MASK;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D (mapping-&gt;flags &amp; AMDGPU_PTE=
_MTYPE_NV10_MASK);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*flags &amp;=3D ~AMDGPU_PTE_NOALLOC;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*flags |=3D (mapping-&gt;flags &amp; AMDGPU_PTE=
_NOALLOC);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mapping-&gt;flags &amp; AMDGPU_PTE_PRT) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D AMDGPU_=
PTE_PRT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *flags |=3D AMDGPU_=
PTE_SNOOPED;<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index 57b9d8f0133a..9d71d6330687 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
+++ b/include/uapi/drm/amdgpu_drm.h<br>
@@ -533,6 +533,8 @@ struct drm_amdgpu_gem_op {<br>
=C2=A0#define AMDGPU_VM_MTYPE_UC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(4 &lt;&lt; 5)<br>
=C2=A0/* Use Read Write MTYPE instead of default MTYPE */<br>
=C2=A0#define AMDGPU_VM_MTYPE_RW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(5 &lt;&lt; 5)<br>
+/* don&#39;t allocate MALL */<br>
+#define AMDGPU_VM_PAGE_NOALLOC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt=
; 9)<br>
<br>
=C2=A0struct drm_amdgpu_gem_va {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /** GEM object handle */<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--0000000000002e154505deaeeb46--
