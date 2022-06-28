Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D0DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 12:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 772A6113142;
	Tue, 28 Jun 2022 12:32:36 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82633113142
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 12:32:35 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id k9so2656427pfg.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BhKU9O1JoorkhS0zgnJqqxAOatepAUea4jCUxMOC7Ng=;
 b=SovoBBly2Q++0VsTpMYcyqMWgJfL5XkVskQSUxfUTm+RhCDSQxIqDbeJk36V+gWKyG
 vu3lkS88fE+DblIEKS5Z70Ifh4m+Wa0GPpHPsXsaQlzB1xJmsfKv9wFMplkMjuzq10oz
 KHU3chd90RuHVFJlHeDsvLvlSROL/uUZ3jRfyu7s8uKUJBlNB+S809/lMkrjjoZ9sfLC
 Vv+2sn9ii5AJK8INDZaEkedFu2vLw6PYljIFa1xKCDTpKrtDoofss7SHEB+gaWEc0rmS
 6tRo9pzdv1s9kYG7h1TV76S5GDd2FrO7oOE0nrZsaPYpzOerE0GVpgEEZVQMf8uNttKS
 DX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BhKU9O1JoorkhS0zgnJqqxAOatepAUea4jCUxMOC7Ng=;
 b=FzBkwIjxMIPCmlCjiY46ja7SuXynGJ+R8IgfQ+MHpGm0ywJDrEyQRnUdeQ0d43VXEj
 IB708XOxNY/TfnR3bJbok7EvcYcKGInWxnaWJ2+SOOlUyXcScHXHm/G9nkp20RyBKEpy
 oH1bX425D5XtQAhFfkuzwYp7o6Y/nZVyY7/IANwPB5K4rsV6GR68TcpOR4EQDFLF27nz
 vAEsEtxzSLYzT/JtCgmhXfhDTFsuB6amqUFWejQkmthNZNBToVTDZqW6+ALJmIYvSsSi
 a27jgmg8Wm004t0Wj3ex24S66y6UxMJL/9Ynh4aSUoeh5coRReYsatJMjPdsN3UYSLHp
 k5jQ==
X-Gm-Message-State: AJIora+iZQDiELST2w9TfyH/Vn/Q7OkY4lLnACS3nCn2Q0lriVevU8LQ
 dzDHMjnE1ME7VV/NrdnEyLDPY9wgRQ9D4AWpGRELu6WD
X-Google-Smtp-Source: AGRyM1uzlFPlo7ERreDicaUurvpRV137fiWQLfinceyExhXZqfp7QWT3ijQEQczfOYOndCIDy1CcY80cC8ASCjWJRxU=
X-Received: by 2002:a63:9516:0:b0:40c:c3b9:f984 with SMTP id
 p22-20020a639516000000b0040cc3b9f984mr17805840pgd.116.1656419555045; Tue, 28
 Jun 2022 05:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220627143240.1644836-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220627143240.1644836-1-aurabindo.pillai@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 28 Jun 2022 08:31:58 -0400
Message-ID: <CAAxE2A6kwdBh8ZYuV7R9s5mnx8ORbOcRHtUaSfM9=9jzGk6eHg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: expose additional modifier for DCN32/321
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Content-Type: multipart/alternative; boundary="0000000000002d762505e2813bb8"
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000002d762505e2813bb8
Content-Type: text/plain; charset="UTF-8"

This needs to be a loop inserting all 64K_R_X and all 256K_R_X modifiers.

If num_pipes > 16, insert 256K_R_X first, else insert 64K_R_X first. Insert
the other one after that. For example:

      for (unsigned i = 0; i < 2; i++) {

         unsigned swizzle_r_x;


         /* Insert the best one first. */

         if (num_pipes > 16)

            swizzle_r_x = !i ? AMD_FMT_MOD_TILE_GFX11_256K_R_X :
AMD_FMT_MOD_TILE_GFX9_64K_R_X;

         else

            swizzle_r_x = !i ? AMD_FMT_MOD_TILE_GFX9_64K_R_X :
AMD_FMT_MOD_TILE_GFX11_256K_R_X;


         uint64_t modifier_r_x = ...

         add_modifier(,,,

         add_modifier(,,,
         add_modifier(,,,
         add_modifier(,,,
         add_modifier(,,,
      }


Marek

On Mon, Jun 27, 2022 at 10:32 AM Aurabindo Pillai <aurabindo.pillai@amd.com>
wrote:

> [Why&How]
> Some userspace expect a backwards compatible modifier on DCN32/321. For
> hardware with num_pipes more than 16, we expose the most efficient
> modifier first. As a fall back method, we need to expose slightly
> inefficient
> modifier AMD_FMT_MOD_TILE_GFX9_64K_R_X after the best option.
>
> Also set the number of packers to fixed value as required per hardware
> documentation. This value is cached during hardware initialization and
> can be read through the base driver.
>
> Fixes: 0a2c19562ffe ('Revert "drm/amd/display: ignore modifiers when
> checking for format support"')
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 3 +--
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 1a512d78673a..0f5bfe5df627 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -743,8 +743,7 @@ static int convert_tiling_flags_to_modifier(struct
> amdgpu_framebuffer *afb)
>                         switch (version) {
>                         case AMD_FMT_MOD_TILE_VER_GFX11:
>                                 pipe_xor_bits = min(block_size_bits - 8,
> pipes);
> -                               packers = min(block_size_bits - 8 -
> pipe_xor_bits,
> -
>  ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs));
> +                               packers =
> ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
>                                 break;
>                         case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:
>                                 pipe_xor_bits = min(block_size_bits - 8,
> pipes);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c9145864ed2b..bea9cee37f65 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5203,6 +5203,7 @@ add_gfx11_modifiers(struct amdgpu_device *adev,
>         int pkrs = 0;
>         u32 gb_addr_config;
>         unsigned swizzle_r_x;
> +       uint64_t modifier_r_x_best;
>         uint64_t modifier_r_x;
>         uint64_t modifier_dcc_best;
>         uint64_t modifier_dcc_4k;
> @@ -5223,10 +5224,12 @@ add_gfx11_modifiers(struct amdgpu_device *adev,
>
>         modifier_r_x = AMD_FMT_MOD |
>                 AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |
> -               AMD_FMT_MOD_SET(TILE, swizzle_r_x) |
>                 AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
>                 AMD_FMT_MOD_SET(PACKERS, pkrs);
>
> +       modifier_r_x_best = modifier_r_x | AMD_FMT_MOD_SET(TILE,
> AMD_FMT_MOD_TILE_GFX11_256K_R_X);
> +       modifier_r_x = modifier_r_x | AMD_FMT_MOD_SET(TILE,
> AMD_FMT_MOD_TILE_GFX9_64K_R_X);
> +
>         /* DCC_CONSTANT_ENCODE is not set because it can't vary with gfx11
> (it's implied to be 1). */
>         modifier_dcc_best = modifier_r_x |
>                 AMD_FMT_MOD_SET(DCC, 1) |
> @@ -5247,6 +5250,9 @@ add_gfx11_modifiers(struct amdgpu_device *adev,
>         add_modifier(mods, size, capacity, modifier_dcc_best |
> AMD_FMT_MOD_SET(DCC_RETILE, 1));
>         add_modifier(mods, size, capacity, modifier_dcc_4k |
> AMD_FMT_MOD_SET(DCC_RETILE, 1));
>
> +       if (num_pipes > 16)
> +               add_modifier(mods, size, capacity, modifier_r_x_best);
> +
>         add_modifier(mods, size, capacity, modifier_r_x);
>
>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
> --
> 2.36.1
>
>

--0000000000002d762505e2813bb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This needs to be a loop inserting all 64K_R_X and all=
 256K_R_X modifiers.</div><div><br></div><div>If num_pipes &gt; 16, insert =
256K_R_X first, else insert 64K_R_X first. Insert the other one after that.=
 For example:</div><div><br></div><div>

<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">      </span><span style=3D"color:rgb(0,0,255)">for</span><span style=
=3D"color:rgb(192,192,192)"> </span>(<span style=3D"color:rgb(128,128,0)">u=
nsigned</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D=
"color:rgb(0,0,0)">i</span><span style=3D"color:rgb(192,192,192)"> </span><=
span style=3D"color:rgb(0,0,0)">=3D</span><span style=3D"color:rgb(192,192,=
192)"> </span><span style=3D"color:rgb(0,0,128)">0</span>;<span style=3D"co=
lor:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">i</span><spa=
n style=3D"color:rgb(192,192,192)"> </span>&lt;<span style=3D"color:rgb(192=
,192,192)"> </span><span style=3D"color:rgb(0,0,128)">2</span>;<span style=
=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">i</spa=
n><span style=3D"color:rgb(0,0,0)">++</span>)<span style=3D"color:rgb(192,1=
92,192)"> </span>{</pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">         </span><span style=3D"color:rgb(128,128,0)">unsigned</span><=
span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,=
0)">swizzle_r_x</span>;</pre>
<pre style=3D"margin:0px;text-indent:0px"><br></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">         </span><span style=3D"color:rgb(0,196,0)">/*</span><span sty=
le=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,196,0)">In=
sert</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"co=
lor:rgb(0,196,0)">the</span><span style=3D"color:rgb(192,192,192)"> </span>=
<span style=3D"color:rgb(0,196,0)">best</span><span style=3D"color:rgb(192,=
192,192)"> </span><span style=3D"color:rgb(0,196,0)">one</span><span style=
=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,196,0)">firs=
t.</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"colo=
r:rgb(0,196,0)">*/</span></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">         </span><span style=3D"color:rgb(0,0,255)">if</span><span sty=
le=3D"color:rgb(192,192,192)"> </span>(<span style=3D"color:rgb(0,0,0)">num=
_pipes</span><span style=3D"color:rgb(192,192,192)"> </span>&gt;<span style=
=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,128)">16</=
span>)</pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">            </span><span style=3D"color:rgb(0,0,0)">swizzle_r_x</span=
><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,=
0,0)">=3D</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,0)">!</span><span style=3D"color:rgb(0,0,0)">i</span><spa=
n style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)"=
>?</span><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"colo=
r:rgb(0,0,0)">AMD_FMT_MOD_TILE_GFX11_256K_R_X</span><span style=3D"color:rg=
b(192,192,192)"> </span>:<span style=3D"color:rgb(192,192,192)"> </span><sp=
an style=3D"color:rgb(0,0,0)">AMD_FMT_MOD_TILE_GFX9_64K_R_X</span>;</pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">         </span><span style=3D"color:rgb(0,0,255)">else</span></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">            </span><span style=3D"color:rgb(0,0,0)">swizzle_r_x</span=
><span style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,=
0,0)">=3D</span><span style=3D"color:rgb(192,192,192)"> </span><span style=
=3D"color:rgb(0,0,0)">!</span><span style=3D"color:rgb(0,0,0)">i</span><spa=
n style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)"=
>?</span><span style=3D"color:rgb(192,192,192)"> </span>AMD_FMT_MOD_TILE_GF=
X9_64K_R_X<span style=3D"color:rgb(192,192,192)"> </span>:<span style=3D"co=
lor:rgb(192,192,192)"> </span>AMD_FMT_MOD_TILE_GFX11_256K_R_X;</pre>
<pre style=3D"margin:0px;text-indent:0px"><br></pre>
<pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192,192,=
192)">         </span><span style=3D"color:rgb(0,0,0)">uint64_t</span><span=
 style=3D"color:rgb(192,192,192)"> </span><span style=3D"color:rgb(0,0,0)">=
modifier_r_x</span><span style=3D"color:rgb(192,192,192)"> </span><span sty=
le=3D"color:rgb(0,0,0)">=3D</span><span style=3D"color:rgb(192,192,192)"> .=
..<br>         <br></span></pre><pre style=3D"margin:0px;text-indent:0px"><=
span style=3D"color:rgb(192,192,192)">         add_modifier(,,,<br></span><=
/pre><pre style=3D"margin:0px;text-indent:0px"><span style=3D"color:rgb(192=
,192,192)"><span style=3D"color:rgb(192,192,192)">         add_modifier(,,,=
<br></span><span style=3D"color:rgb(192,192,192)"><span style=3D"color:rgb(=
192,192,192)">         add_modifier(,,,<br><span style=3D"color:rgb(192,192=
,192)"><span style=3D"color:rgb(192,192,192)"><span style=3D"color:rgb(192,=
192,192)">         add_modifier(,,,<br></span></span></span><span style=3D"=
color:rgb(192,192,192)"><span style=3D"color:rgb(192,192,192)"><span style=
=3D"color:rgb(192,192,192)">         add_modifier(,,,<br></span></span></sp=
an>      }<br></span><span style=3D"color:rgb(192,192,192)"><br><br></span>=
</span></span></pre></div><div></div><div>Marek<br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 27, 20=
22 at 10:32 AM Aurabindo Pillai &lt;<a href=3D"mailto:aurabindo.pillai@amd.=
com" target=3D"_blank">aurabindo.pillai@amd.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">[Why&amp;How]<br>
Some userspace expect a backwards compatible modifier on DCN32/321. For<br>
hardware with num_pipes more than 16, we expose the most efficient<br>
modifier first. As a fall back method, we need to expose slightly inefficie=
nt<br>
modifier AMD_FMT_MOD_TILE_GFX9_64K_R_X after the best option.<br>
<br>
Also set the number of packers to fixed value as required per hardware<br>
documentation. This value is cached during hardware initialization and<br>
can be read through the base driver.<br>
<br>
Fixes: 0a2c19562ffe (&#39;Revert &quot;drm/amd/display: ignore modifiers wh=
en checking for format support&quot;&#39;)<br>
Signed-off-by: Aurabindo Pillai &lt;<a href=3D"mailto:aurabindo.pillai@amd.=
com" target=3D"_blank">aurabindo.pillai@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_display.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 3 +--<br>
=C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +++++++-<br>
=C2=A02 files changed, 8 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 1a512d78673a..0f5bfe5df627 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -743,8 +743,7 @@ static int convert_tiling_flags_to_modifier(struct amdg=
pu_framebuffer *afb)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 switch (version) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 case AMD_FMT_MOD_TILE_VER_GFX11:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pipe_xor_bits =3D min(block_size_bit=
s - 8, pipes);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packers =3D min(block_size_bits - 8 -=
 pipe_xor_bits,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ilog2(adev-&gt;gfx.config.gb_addr_config_fields.num_pkr=
s));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packers =3D ilog2(adev-&gt;gfx.config=
.gb_addr_config_fields.num_pkrs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pipe_xor_bits =3D min(block_size_bit=
s - 8, pipes);<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index c9145864ed2b..bea9cee37f65 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -5203,6 +5203,7 @@ add_gfx11_modifiers(struct amdgpu_device *adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int pkrs =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 gb_addr_config;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned swizzle_r_x;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t modifier_r_x_best;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t modifier_r_x;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t modifier_dcc_best;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t modifier_dcc_4k;<br>
@@ -5223,10 +5224,12 @@ add_gfx11_modifiers(struct amdgpu_device *adev,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 modifier_r_x =3D AMD_FMT_MOD |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(TIL=
E_VERSION, AMD_FMT_MOD_TILE_VER_GFX11) |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(TIL=
E, swizzle_r_x) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(PIP=
E_XOR_BITS, pipe_xor_bits) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(PAC=
KERS, pkrs);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0modifier_r_x_best =3D modifier_r_x | AMD_FMT_MO=
D_SET(TILE, AMD_FMT_MOD_TILE_GFX11_256K_R_X);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0modifier_r_x =3D modifier_r_x | AMD_FMT_MOD_SET=
(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* DCC_CONSTANT_ENCODE is not set because it ca=
n&#39;t vary with gfx11 (it&#39;s implied to be 1). */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 modifier_dcc_best =3D modifier_r_x |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC=
, 1) |<br>
@@ -5247,6 +5250,9 @@ add_gfx11_modifiers(struct amdgpu_device *adev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, modifier_dcc=
_best | AMD_FMT_MOD_SET(DCC_RETILE, 1));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, modifier_dcc=
_4k | AMD_FMT_MOD_SET(DCC_RETILE, 1));<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (num_pipes &gt; 16)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, =
size, capacity, modifier_r_x_best);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, modifier_r_x=
);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
-- <br>
2.36.1<br>
<br>
</blockquote></div>

--0000000000002d762505e2813bb8--
