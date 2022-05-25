Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7722C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 15:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D1110FAC5;
	Wed, 25 May 2022 15:02:19 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B0710FAC5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 15:02:17 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id c14so19484281pfn.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GLB1/51LOYX800zd89N9uQwd921hmPwJJTjVfsTaDRw=;
 b=FSY1r0BxifFVLCRDHbrc328EZlI/OYWTSb7OQJrfu82hIGYVz+4x5Yt3TVdk7G/rY1
 0W46UVUjaa2OjRRie+BXaA3aN+FYPQ7228GQR6RgWl2CsErBM/ajV/z2JmsOr3gbXsEN
 PixyO6s0HPWHRuBfwnPtw/9HiAfwlSI2vSGlURD16NKLxhQ6o+3h0Efl2NZyU6BTxzxd
 qKUqf6jgfQOBQ9Sf8AEw57ulH5TnTWwEVFyeQ5Vv2wlXfSwTWYN1aFqv8Oet6MevE2QT
 nz7949zGVnmovuWwbKA6eZqc6c4A+Hy6NoLYqpsPcx5A6OfK3hlYFB9ndr3PyeZi+eS7
 BzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GLB1/51LOYX800zd89N9uQwd921hmPwJJTjVfsTaDRw=;
 b=QhTDqcHC6ECm4kSwCmx7fDeceJXF1TAjkCi+WPin1IKqWdQQ663QjIqf6NlkO8xXBi
 KCBv/GtX14VZr4qG+uo7pGei86pRgnTluv6u11dYJb1StuBZymc30VyFyX9dQlcZinw4
 FSqVdqvuf5q01wSlwS098HYEMdS23lmrRWe1TEc8Az9BmAKHSSef6s1zmWi2FJ7fgcSX
 Z7jbBDvClFis+hgPYoyMx6L8J1kaBtqskv1jqivAsocY/xuu+XSyZSgx+3PwmwLpvDd/
 YYiCt4+w+lBmH8mbz/lvxV24qjUpd/XnGxej3+wovc8z0hZlFlSgXSTuktKeo0LGQYnJ
 NARg==
X-Gm-Message-State: AOAM533JgtgLr7yNnk7wzgvz8jez3yXbbk8SjQ6C+0FYUmrH43hNQi6P
 3lFho/eRiNTe+BwYLqcOTJ0ZD64KRrPMTFr6bzwpPlyp
X-Google-Smtp-Source: ABdhPJw/ZGy2rLSq2BgK13Clv8/ahTr5B1ZpV7fp5d2KF04XEn6WaRbpFa5X8DRMW+i93rSkvmMid/1k8qAEaTgWIiQ=
X-Received: by 2002:a63:b518:0:b0:3f6:4cd4:548b with SMTP id
 y24-20020a63b518000000b003f64cd4548bmr25980097pge.112.1653490937277; Wed, 25
 May 2022 08:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220520150912.762831-1-alexander.deucher@amd.com>
In-Reply-To: <20220520150912.762831-1-alexander.deucher@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 25 May 2022 11:01:41 -0400
Message-ID: <CAAxE2A5DSbJyxiFBfwoNbz_Zyhz+DOLOn9NjB4kzmyYgxfOTKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size (v3)
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="000000000000f4b01e05dfd75b05"
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

--000000000000f4b01e05dfd75b05
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>

Marek

On Fri, May 20, 2022 at 11:09 AM Alex Deucher <alexander.deucher@amd.com>
wrote:

> Certain GL unit tests for large textures can cause problems
> with the OOM killer since there is no way to link this memory
> to a process.  This was originally mitigated (but not necessarily
> eliminated) by limiting the GTT size.  The problem is this limit
> is often too low for many modern games so just make the limit 1/2
> of system memory. The OOM accounting needs to be addressed, but
> we shouldn't prevent common 3D applications from being usable
> just to potentially mitigate that corner case.
>
> Set default GTT size to max(3G, 1/2 of system ram) by default.
>
> v2: drop previous logic and default to 3/4 of ram
> v3: default to half of ram to align with ttm
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index d2b5cccb45c3..7195ed77c85a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1798,18 +1798,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>         DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>                  (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
>
> -       /* Compute GTT size, either bsaed on 3/4th the size of RAM size
> +       /* Compute GTT size, either bsaed on 1/2 the size of RAM size
>          * or whatever the user passed on module init */
>         if (amdgpu_gtt_size =3D=3D -1) {
>                 struct sysinfo si;
>
>                 si_meminfo(&si);
> -               gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> -                              adev->gmc.mc_vram_size),
> -                              ((uint64_t)si.totalram * si.mem_unit *
> 3/4));
> -       }
> -       else
> +               /* Certain GL unit tests for large textures can cause
> problems
> +                * with the OOM killer since there is no way to link this
> memory
> +                * to a process.  This was originally mitigated (but not
> necessarily
> +                * eliminated) by limiting the GTT size.  The problem is
> this limit
> +                * is often too low for many modern games so just make th=
e
> limit 1/2
> +                * of system memory which aligns with TTM. The OOM
> accounting needs
> +                * to be addressed, but we shouldn't prevent common 3D
> applications
> +                * from being usable just to potentially mitigate that
> corner case.
> +                */
> +               gtt_size =3D max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
> +                              (u64)si.totalram * si.mem_unit / 2);
> +       } else {
>                 gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
> +       }
>
>         /* Initialize GTT memory pool */
>         r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
> --
> 2.35.3
>
>

--000000000000f4b01e05dfd75b05
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Reviewed-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mai=
lto:marek.olsak@amd.com">marek.olsak@amd.com</a>&gt;</div><div><br></div><d=
iv>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Fri, May 20, 2022 at 11:09 AM Alex Deucher &lt;<a href=
=3D"mailto:alexander.deucher@amd.com">alexander.deucher@amd.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Certain GL u=
nit tests for large textures can cause problems<br>
with the OOM killer since there is no way to link this memory<br>
to a process.=C2=A0 This was originally mitigated (but not necessarily<br>
eliminated) by limiting the GTT size.=C2=A0 The problem is this limit<br>
is often too low for many modern games so just make the limit 1/2<br>
of system memory. The OOM accounting needs to be addressed, but<br>
we shouldn&#39;t prevent common 3D applications from being usable<br>
just to potentially mitigate that corner case.<br>
<br>
Set default GTT size to max(3G, 1/2 of system ram) by default.<br>
<br>
v2: drop previous logic and default to 3/4 of ram<br>
v3: default to half of ram to align with ttm<br>
<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com=
" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------<br>
=C2=A01 file changed, 14 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index d2b5cccb45c3..7195ed77c85a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1798,18 +1798,26 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DRM_INFO(&quot;amdgpu: %uM of VRAM memory ready=
\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(unsigned) (a=
dev-&gt;gmc.real_vram_size / (1024 * 1024)));<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Compute GTT size, either bsaed on 3/4th the =
size of RAM size<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Compute GTT size, either bsaed on 1/2 the si=
ze of RAM size<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* or whatever the user passed on module i=
nit */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (amdgpu_gtt_size =3D=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sysinfo si;<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 si_meminfo(&amp;si)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtt_size =3D min(ma=
x((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gmc.mc_vram_size),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((uint64_t)si.totalram * si.mem_unit * 3/4)=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Certain GL unit =
tests for large textures can cause problems<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * with the OOM kil=
ler since there is no way to link this memory<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to a process.=C2=
=A0 This was originally mitigated (but not necessarily<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * eliminated) by l=
imiting the GTT size.=C2=A0 The problem is this limit<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * is often too low=
 for many modern games so just make the limit 1/2<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * of system memory=
 which aligns with TTM. The OOM accounting needs<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to be addressed,=
 but we shouldn&#39;t prevent common 3D applications<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * from being usabl=
e just to potentially mitigate that corner case.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gtt_size =3D max((A=
MDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (u64)si.totalram * si.mem_unit / 2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gtt_size =3D (uint6=
4_t)amdgpu_gtt_size &lt;&lt; 20;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Initialize GTT memory pool */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D amdgpu_gtt_mgr_init(adev, gtt_size);<br>
-- <br>
2.35.3<br>
<br>
</blockquote></div>

--000000000000f4b01e05dfd75b05--
