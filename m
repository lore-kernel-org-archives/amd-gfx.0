Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AF2CC6B1D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 02:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B538710E36C;
	Fri,  3 Apr 2026 02:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gFCbe7Dm";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 398A510E43B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 02:07:28 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12776bebe9fso3657168c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Apr 2026 19:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775182047; cv=none;
 d=google.com; s=arc-20240605;
 b=aBI9dIG3IiQ7v4VMIIGP+2bQI3iG8fm+heA3iwOluhCrSIxQbtVtiNEAflfwyBL8++
 BmwFGumi09RcBjKlqu35kalUYtosy76XnbrLMW2AIf2tD746t4eEmCcJqSpRfD0Fohgc
 d5o5WSo0jqbL1Zs5egJPsysoHCCfKWO5xDeX2t20pb9CbaHFNEKfbD1jC+lXkGwKzP/n
 zlCp49wMNKGK+/0XAT+X1BTLA5v9eP9SpLgpK4omqMV4CDkMXtG7X7sD8H8vasqLxul9
 t69sq/L8SQZ5it+08trg1gk+NPuvzfCx0QUzi+RQdUAY2NoC8Y+IB01zhfVaxsmCBDe3
 vkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6bdlFMjKwX6jg6vEgqWB3zFv/fhyRvvRLyn/3ttJYok=;
 fh=f8RDCCwf1SEj3PjZgU9FdXV9mJLwrU5R2kbPTHsrV2s=;
 b=c5oFpksFUgmS+5tVG0K94wFlWSkWnK1K0qukscuV/pOxo5AH5SdsxnZuaTDBvFEnCN
 OtW7oXZc0GgjIZIEtag/tJxAQP2fUin+luZHTr/hw7oyX+y7yhYv/gXoCU7EOt7z1fT1
 9o5OA1IUZALkvh+oonc6tQEvVD5eFxhsIs0lJSJJkBzcqZUA741cfvyWuRCuaUtcZ9BG
 0EqVEXHRbzZVZzT0+yxtQ968T1+MJw3YaUOP0K0KwCXszZ8h80Gt9/9oGrVCQrJbLDPF
 ClaIedhfwRYhK4nCqckxaa2i6jszIie612HTmeVmYOd9vxSKUjUgY3th+8ew2NkFIpgz
 zySw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775182047; x=1775786847; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6bdlFMjKwX6jg6vEgqWB3zFv/fhyRvvRLyn/3ttJYok=;
 b=gFCbe7DmVN4Xi1xdbq3LjLZYhavFicbXHMJYXbGBUxliE0KASQZsq05vqP3smJHtOr
 uinALXkTqneUoehCdxA9HiHGY1bvUc3/f8ztlIdUHJR6J4BMpHhg6vCbLuIS4uREPmVs
 /9aorn4cb7wJWnj3OhjGSfO3MBeuis4O2b57LIsLNrPEhG49ZBSyqCEDKDrc+eBxmjIY
 9hON6hdhFimba82F0uAFpdUYxenU2lWJIoj9U5fJVfG1F3dY1dM3QetWhgQOOM8f5Ekf
 k7i3NIrPykLMV/N3wv19eVcxzNr99zIxyyq7XRrQY0ZGO3W6yOucPYoPIN2o44hwEL4Y
 VTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775182047; x=1775786847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bdlFMjKwX6jg6vEgqWB3zFv/fhyRvvRLyn/3ttJYok=;
 b=NivwIwMUOiZbQJwK1fPbG71jpVZEr2y/LeqyA2CN0Kk3llUNvaBweZqU3VyPg+T9JG
 yLsvhBEOcHDm+XNwaO8wFJZzsbqJaaR/vje2t99vTtlpKoTx97iyxDtvwqMuWhE3hwv0
 IRzu5+evToLj2Q1Lv8fucdSepNDomAnJhOe+kktY/McgrhGsDhpfGFXEQGN5w/JPhuKD
 aN0DWUrxKB0aQXtCwuidrp2Nk0NQOO6yO/GeHrKGb4FAgHmJCvE3mJOWLq/BEykKHBjK
 Lr1IRVBxyYPUaMckYZ8RPR9OAZG/7VSvXe11+EZeIBYHK0cNqzjJd/zKaJl48YtSkuTl
 e09g==
X-Gm-Message-State: AOJu0Yz/DMR0VVqXFb09VBdu/OjVYHKBm/otuOzI65I7K4iLugAofInb
 kNjHmisC08h0He9E1KjX2H8vzc2RwsSidwJIEuHjOcHBZ5QivJIFAYD6y4qtewk5+0924fAavO0
 PDm3qqUC2E+JE2SaaRFjXNPbeoBC6gF0=
X-Gm-Gg: ATEYQzyhu/BH+Chal/14Gn7qbJ1kikjk0Lz3M1NkLtj63SiNRsm2HtmLPCVh6PDBAno
 iVLRWjoA+RD81nnG4yAG30B8Bb9KZfeYIfgWalTYLOcc17NEnafEwqscXzMPdfymWsEgiP5bCnE
 4TmMGe3Eh3QT8v72PCu5MbaX93fCdqJ1UkydcOKag3p6ozVEQPWZNS4fxs4O0hUz43jKhfeKOR8
 oOVdFKJ5IKVb6iaRBjkVCr40qp2tlSxUuZQSAiPohQj4Cu0wpouX3ttbpXUvCRjLY9vfW+jXc5B
 KFgHq1HO3CJCbaPSMhkUZjy8mTLRzU3Wzk9vhl9e0A==
X-Received: by 2002:a05:7022:b9c:b0:128:cf86:d1cb with SMTP id
 a92af1059eb24-12bfb76b78amr632139c88.31.1775182047343; Thu, 02 Apr 2026
 19:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260321052033.23472-1-mario.kleiner.de@gmail.com>
 <f4861fc9-a602-44b9-b5c3-6b9c7f233b15@amd.com>
In-Reply-To: <f4861fc9-a602-44b9-b5c3-6b9c7f233b15@amd.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Fri, 3 Apr 2026 04:06:50 +0200
X-Gm-Features: AQROBzBYKvLcn-fpWdDlHhBv6oqIOkFDp46xmMBpkM_oFXmS8VBAM6auqfiTp6Y
Message-ID: <CAEsyxyidQQMYH5TZt9D-4iGSmhPRp-iQ7meqer-YdJ9FPc6cZw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Change dither policy for 10 bpc output
 back to dithering
To: Harry Wentland <harry.wentland@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, Aric Cyr <aric.cyr@amd.com>, 
 Anthony Koo <anthony.koo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Krunoslav Kovac <krunoslav.kovac@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/alternative; boundary="00000000000057fa0b064e84c7cc"
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

--00000000000057fa0b064e84c7cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's great to hear! Maybe still a happy end for my users and Ubuntu
26.04-LTS.

Thanks Harry!

On Wed, Apr 1, 2026 at 9:32=E2=80=AFPM Harry Wentland <harry.wentland@amd.c=
om>
wrote:

>
>
> On 2026-03-21 01:20, Mario Kleiner wrote:
> > Commit d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc t=
o
> > round") degraded display of 12 bpc color precision output to 10 bpc sin=
ks
> > by switching 10 bpc output from dithering to "truncate to 10 bpc".
> >
> > I don't find the argumentation in that commit convincing, but the
> > consequences highly unfortunate, especially for applications that
> > require effective > 10 bpc precision output of > 10 bpc framebuffers.
> >
> > The argument wasn't something strong like "there are hardware design
> > defects or limitations which require us to work around broken dithering
> > to 10 bpc", or "there are some special use cases which do require
> > truncation to 10 bpc", but essentially "at some point in the past we
> > used truncation in Polaris/Vega times and it looks like it got
> > inadvertently changed for Navi, so let's do that again". I couldn't fin=
d
> > evidence for that in the git commit logs for this. The commit message
> also
> > acknowledges that using dithering "...makes some sense for FP16...
> > ...but not for ARGB2101010 surfaces..."
> >
> > The problem with this is that it makes fp16 surfaces, and especially
> > rgba16 fixed point surfaces, less useful. These are now well
> > supported by Mesa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by
> > OSS AMDVLK Vulkan/WSI/display, and also by GNOME 50 mutter under Waylan=
d,
> > and they used to provide more than 10 bpc effective precision at the
> > output.
> >
> > Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuffe=
r,
> > e.g., gamma tables, CTM, can be used for color correction and will
> > benefit from an effective > 10 bpc output precision via dithering,
> > retaining some precision that would get lost on the way through the
> > pipeline, e.g., due to non-linear gamma functions.
> >
> > Scientific apps rely on this for > 10 bpc display precision. Truncating
> > to 10 bpc, instead of dithering the pipeline internal 12 bpc precision
> > down to 10 bpc, causes a serious loss of precision. This also creates t=
he
> > undesirable and slightly absurd situation that using a cheap monitor
> > with only 8 bpc input and display panel will yield roughly 12 bpc
> > precision via dithering from 12 -> 8 bpc, whereas investment into a
> > more expensive monitor with 10 bpc input and native 10 bpc display will
> > only yield 10 bpc, even if a fp16 or rgb16 framebuffer and/or a properl=
y
> > set up color pipeline (gamma tables, CTM's etc. with more than 10 bpc o=
ut
> > precision) would allow effective 12 bpc precision output.
> >
> > Therefore this patch proposes reverting that commit and going back to
> > dithering down to 10 bpc, consistent with the behaviour for 6 bpc or 8
> bpc
> > output.
> >
> > Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 wit=
h
> > a native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer
> and
> > measuring resulting color precision with a photometer. No apparent visu=
al
> > artifacts or problems were observed, and effective precision was measur=
ed
> > to be 12 bpc again, as expected.
> >
> > Fixes: d5df648ec830 ("drm/amd/display: Change dither policy for 10bpc t=
o
> round")
> > Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> > Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> > Cc: stable@vger.kernel.org
> > Cc: Aric Cyr <aric.cyr@amd.com>
> > Cc: Anthony Koo <anthony.koo@amd.com>
> > Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> > Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
>
> Kruno and I chatted a bit more about this and the best way forward
> seems to be to re-enable SPATIAL10 dither and then override that
> when needed in our Windows driver.
>
> Patches is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Will pull it in today.
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > index c9fbb64d706a..29db5404c4a0 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> > @@ -5056,7 +5056,7 @@ void
> resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
> >                       option =3D DITHER_OPTION_SPATIAL8;
> >                       break;
> >               case COLOR_DEPTH_101010:
> > -                     option =3D DITHER_OPTION_TRUN10;
> > +                     option =3D DITHER_OPTION_SPATIAL10;
> >                       break;
> >               default:
> >                       option =3D DITHER_OPTION_DISABLE;
>
>

--00000000000057fa0b064e84c7cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>That&#39;s great to hear! Maybe still a happy end for=
 my users and Ubuntu 26.04-LTS.</div><div><br></div><div>Thanks Harry!</div=
></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">On Wed, Apr 1, 2026 at 9:32=E2=80=AFPM Harry Wentlan=
d &lt;<a href=3D"mailto:harry.wentland@amd.com">harry.wentland@amd.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 2026-03-21 01:20, Mario Kleiner wrote:<br>
&gt; Commit d5df648ec830 (&quot;drm/amd/display: Change dither policy for 1=
0bpc to<br>
&gt; round&quot;) degraded display of 12 bpc color precision output to 10 b=
pc sinks<br>
&gt; by switching 10 bpc output from dithering to &quot;truncate to 10 bpc&=
quot;.<br>
&gt; <br>
&gt; I don&#39;t find the argumentation in that commit convincing, but the<=
br>
&gt; consequences highly unfortunate, especially for applications that<br>
&gt; require effective &gt; 10 bpc precision output of &gt; 10 bpc framebuf=
fers.<br>
&gt; <br>
&gt; The argument wasn&#39;t something strong like &quot;there are hardware=
 design<br>
&gt; defects or limitations which require us to work around broken ditherin=
g<br>
&gt; to 10 bpc&quot;, or &quot;there are some special use cases which do re=
quire<br>
&gt; truncation to 10 bpc&quot;, but essentially &quot;at some point in the=
 past we<br>
&gt; used truncation in Polaris/Vega times and it looks like it got<br>
&gt; inadvertently changed for Navi, so let&#39;s do that again&quot;. I co=
uldn&#39;t find<br>
&gt; evidence for that in the git commit logs for this. The commit message =
also<br>
&gt; acknowledges that using dithering &quot;...makes some sense for FP16..=
.<br>
&gt; ...but not for ARGB2101010 surfaces...&quot;<br>
&gt; <br>
&gt; The problem with this is that it makes fp16 surfaces, and especially<b=
r>
&gt; rgba16 fixed point surfaces, less useful. These are now well<br>
&gt; supported by Mesa 25.3 and later via OpenGL + EGL, Vulkan/WSI, and by<=
br>
&gt; OSS AMDVLK Vulkan/WSI/display, and also by GNOME 50 mutter under Wayla=
nd,<br>
&gt; and they used to provide more than 10 bpc effective precision at the<b=
r>
&gt; output.<br>
&gt; <br>
&gt; Even for 8 or 10 bpc surfaces, the color pipeline behind the framebuff=
er,<br>
&gt; e.g., gamma tables, CTM, can be used for color correction and will<br>
&gt; benefit from an effective &gt; 10 bpc output precision via dithering,<=
br>
&gt; retaining some precision that would get lost on the way through the<br=
>
&gt; pipeline, e.g., due to non-linear gamma functions.<br>
&gt; <br>
&gt; Scientific apps rely on this for &gt; 10 bpc display precision. Trunca=
ting<br>
&gt; to 10 bpc, instead of dithering the pipeline internal 12 bpc precision=
<br>
&gt; down to 10 bpc, causes a serious loss of precision. This also creates =
the<br>
&gt; undesirable and slightly absurd situation that using a cheap monitor<b=
r>
&gt; with only 8 bpc input and display panel will yield roughly 12 bpc<br>
&gt; precision via dithering from 12 -&gt; 8 bpc, whereas investment into a=
<br>
&gt; more expensive monitor with 10 bpc input and native 10 bpc display wil=
l<br>
&gt; only yield 10 bpc, even if a fp16 or rgb16 framebuffer and/or a proper=
ly<br>
&gt; set up color pipeline (gamma tables, CTM&#39;s etc. with more than 10 =
bpc out<br>
&gt; precision) would allow effective 12 bpc precision output.<br>
&gt; <br>
&gt; Therefore this patch proposes reverting that commit and going back to<=
br>
&gt; dithering down to 10 bpc, consistent with the behaviour for 6 bpc or 8=
 bpc<br>
&gt; output.<br>
&gt; <br>
&gt; Successfully tested on AMD Polaris DCE 11.2 and Raven Ridge DCN 1.0 wi=
th<br>
&gt; a native 10 bpc capable monitor, outputting a RGBA16 unorm framebuffer=
 and<br>
&gt; measuring resulting color precision with a photometer. No apparent vis=
ual<br>
&gt; artifacts or problems were observed, and effective precision was measu=
red<br>
&gt; to be 12 bpc again, as expected.<br>
&gt; <br>
&gt; Fixes: d5df648ec830 (&quot;drm/amd/display: Change dither policy for 1=
0bpc to round&quot;)<br>
&gt; Signed-off-by: Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gm=
ail.com" target=3D"_blank">mario.kleiner.de@gmail.com</a>&gt;<br>
&gt; Tested-by: Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gmail.=
com" target=3D"_blank">mario.kleiner.de@gmail.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable=
@vger.kernel.org</a><br>
&gt; Cc: Aric Cyr &lt;<a href=3D"mailto:aric.cyr@amd.com" target=3D"_blank"=
>aric.cyr@amd.com</a>&gt;<br>
&gt; Cc: Anthony Koo &lt;<a href=3D"mailto:anthony.koo@amd.com" target=3D"_=
blank">anthony.koo@amd.com</a>&gt;<br>
&gt; Cc: Rodrigo Siqueira &lt;<a href=3D"mailto:rodrigo.siqueira@amd.com" t=
arget=3D"_blank">rodrigo.siqueira@amd.com</a>&gt;<br>
&gt; Cc: Krunoslav Kovac &lt;<a href=3D"mailto:krunoslav.kovac@amd.com" tar=
get=3D"_blank">krunoslav.kovac@amd.com</a>&gt;<br>
&gt; Cc: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" targ=
et=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
<br>
Kruno and I chatted a bit more about this and the best way forward<br>
seems to be to re-enable SPATIAL10 dither and then override that<br>
when needed in our Windows driver.<br>
<br>
Patches is<br>
Reviewed-by: Harry Wentland &lt;<a href=3D"mailto:harry.wentland@amd.com" t=
arget=3D"_blank">harry.wentland@amd.com</a>&gt;<br>
<br>
Will pull it in today.<br>
<br>
Harry<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drive=
rs/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; index c9fbb64d706a..29db5404c4a0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c<br>
&gt; @@ -5056,7 +5056,7 @@ void resource_build_bit_depth_reduction_params(s=
truct dc_stream_state *stream,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0option =3D DITHER_OPTION_SPATIAL8;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case COLOR_DEPTH=
_101010:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0option =3D DITHER_OPTION_TRUN10;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0option =3D DITHER_OPTION_SPATIAL10;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0option =3D DITHER_OPTION_DISABLE;<br>
<br>
</blockquote></div>

--00000000000057fa0b064e84c7cc--
