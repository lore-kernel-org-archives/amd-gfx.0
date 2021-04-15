Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2984BC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 16:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C1B61184
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 16:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C1B61184
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 024856EA92;
	Thu, 15 Apr 2021 16:27:27 +0000 (UTC)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9131A6EA92
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 16:27:25 +0000 (UTC)
Received: by mail-il1-x12c.google.com with SMTP id r5so12500552ilb.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 09:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2G4i4dkZatM80dqAywTAxWrV7fBFOEQR0tVBUmwUS5g=;
 b=Rj18V3Jy9Ojfz79Rd+yXVr6jV6M7l/DYzyn8TGXq2Fx5eXtcW1Q5p05+mnZUFATXnc
 vFF+dB7CxK9/xDoXjrdWjsDuhzszgC5PIQmFllyZywBL2VljcTqdKJfzbWbvVA8xMQGZ
 wILo1s4q1CkSWdVzFSdCL8qtQbfvjBMsVA/an7ix8nnSKSMdOpe+wvteQqeRbGwu6K0W
 oaUNjB5rBjbr1GYhBXb5oqYV6xqDAtMyq0xP9dZ2TArdr/tr+fAZVWVZbfTD09dQq1AW
 qGced2xwk0whuhgbUrxKy5bc3ADZh2g7vWpLggjSouVU4MsF4lrnoxre5hdHVTTzqTeP
 bUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2G4i4dkZatM80dqAywTAxWrV7fBFOEQR0tVBUmwUS5g=;
 b=gxfDL7Z/h8qOIgMGVqKAIAsRWgk59685mv2oxHnBKbu+PVC4P256yG7UFQFBp2sPd5
 noCYfjT4KbmbXX6vjPu13CU+bz7/luBpHdDnzfGrQllusCqejig5EWnaNh77wXfly/eR
 SlbQ5tFkvmzLKGT6Zum1qgVpKZlXu91rXN7pWULCHBUWSsNb0N4AcvzH3sUsaEqGqJUR
 eItDDBFtZyDEorZNHBy9/ENou1YEohQjKphfIJLMFkUnmL5WuwdK6vg0KHF9IO3MrugK
 IDnO0DCn4kz1qivwhmm9aFB8w1fRKlYPjs4p2vNIYDi1Dscqmhfs6fm5FL5OtsoUnQqD
 gkhw==
X-Gm-Message-State: AOAM531J8+imzKQKXCFc7bW1/CJzCO5bSTetQ3MQ6xtp73F9BeIK9QJZ
 1jmtD42C2kITbRhkD37CQ57UTbK5XwGXjOSTYOzIew==
X-Google-Smtp-Source: ABdhPJxMM5wRdpR2a0rkZNJRhiB1C9QXsVvwk2xwCkrYC65jb8Tow76mKQTILOCwHek2SZ7yBsF5xW7voStXq3q6jm8=
X-Received: by 2002:a92:d68a:: with SMTP id p10mr3456095iln.40.1618504044981; 
 Thu, 15 Apr 2021 09:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210414233533.24012-1-qingqing.zhuo@amd.com>
 <CAP+8YyHU8GtCzFk71h1qjQWKYQpMwrA=s88dw2Fu3_0LXSMEWA@mail.gmail.com>
 <DM6PR12MB2939FC23A4404409980F7D1AFB4D9@DM6PR12MB2939.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2939FC23A4404409980F7D1AFB4D9@DM6PR12MB2939.namprd12.prod.outlook.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Thu, 15 Apr 2021 18:27:14 +0200
Message-ID: <CAP+8YyGkpq=Ofq67_LVrTb5+9f6oJO6HuvBNcXzyji2Zu1Wqig@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Update modifier list for gfx10_3
To: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>
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
Cc: Mark Yacoub <markyacoub@chromium.org>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: multipart/mixed; boundary="===============0396012134=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0396012134==
Content-Type: multipart/alternative; boundary="000000000000ab46d005c005568f"

--000000000000ab46d005c005568f
Content-Type: text/plain; charset="UTF-8"

Btw please add a fixes tag so it gets directed to stable releases.

Thanks!

On Thu, Apr 15, 2021, 6:06 PM Zhuo, Qingqing <Qingqing.Zhuo@amd.com> wrote:

> [AMD Public Use]
>
>
>
> Inline.
>
>
>
> *From:* Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> *Sent:* Thursday, April 15, 2021 7:26 AM
> *To:* Zhuo, Qingqing <Qingqing.Zhuo@amd.com>
> *Cc:* amd-gfx mailing list <amd-gfx@lists.freedesktop.org>; Mark Yacoub <
> markyacoub@chromium.org>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> Wheeler, Daniel <Daniel.Wheeler@amd.com>; Siqueira, Rodrigo <
> Rodrigo.Siqueira@amd.com>; Kazlauskas, Nicholas <
> Nicholas.Kazlauskas@amd.com>
> *Subject:* Re: [PATCH 1/2] drm/amd/display: Update modifier list for
> gfx10_3
>
>
>
>
>
>
>
> On Thu, Apr 15, 2021 at 1:35 AM Qingqing Zhuo <qingqing.zhuo@amd.com>
> wrote:
>
> [Why]
> Current list only includes modifiers where DCC_MAX_COMPRESSED_BLOCK
> is set to AMD_FMT_MOD_DCC_BLOCK_128B, while AMD_FMT_MOD_DCC_BLOCK_64B
> is also supported and used by userspace.
>
> [How]
> Add AMD_FMT_MOD_DCC_BLOCK_64B to modifiers with DCC supported.
>
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e29cb2e956db..c3cbc3d298e7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4535,6 +4535,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device
> *adev,
>         int pipe_xor_bits =
> ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
>         int pkrs = ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs);
>
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
> +                   AMD_FMT_MOD_SET(DCC, 1) |
> +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_64B));
>
>
>
> Thanks for finding this issue. Looking at it it looks to me like the
> original entries are mistaken. Can we just change the
> DCC_MAX_COMPRESSED_BLOCK in the already existing DCC entries? Looks like
> Mesa always uses the AMD_FMT_MOD_DCC_BLOCK_64B anyway, and I don't think
> DCC_INDEPENDENT_64B=1 + DCC_MAX_COMPRESSED_BLOCK=AMD_FMT_MOD_DCC_BLOCK_128B
> makes sense.
>
>
>
> Thanks for the suggestion. Will send out an updated version soon.
>
>
>
> +
>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
>                     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>                     AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> @@ -4546,6 +4557,18 @@ add_gfx10_3_modifiers(const struct amdgpu_device
> *adev,
>                     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>                     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_128B));
>
> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +                   AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
> +                   AMD_FMT_MOD_SET(DCC, 1) |
> +                   AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_64B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> AMD_FMT_MOD_DCC_BLOCK_64B));
> +
>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
>                     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>                     AMD_FMT_MOD_SET(TILE_VERSION,
> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> --
> 2.17.1
>
>

--000000000000ab46d005c005568f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Btw please add a fixes tag so it gets directed to stable =
releases.<div dir=3D"auto"><br></div><div dir=3D"auto">Thanks!</div></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu,=
 Apr 15, 2021, 6:06 PM Zhuo, Qingqing &lt;<a href=3D"mailto:Qingqing.Zhuo@a=
md.com">Qingqing.Zhuo@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">





<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:break=
-word">
<div class=3D"m_1862946999310511708WordSection1">
<p class=3D"m_1862946999310511708msipheader87abd423" style=3D"margin:0in"><=
span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;col=
or:#317100">[AMD Public Use]</span><u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:#548235">Inline.<u></u><u></u><=
/span></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Bas Nieuwenhuizen &lt;<a href=3D"mailto=
:bas@basnieuwenhuizen.nl" target=3D"_blank" rel=3D"noreferrer">bas@basnieuw=
enhuizen.nl</a>&gt; <br>
<b>Sent:</b> Thursday, April 15, 2021 7:26 AM<br>
<b>To:</b> Zhuo, Qingqing &lt;<a href=3D"mailto:Qingqing.Zhuo@amd.com" targ=
et=3D"_blank" rel=3D"noreferrer">Qingqing.Zhuo@amd.com</a>&gt;<br>
<b>Cc:</b> amd-gfx mailing list &lt;<a href=3D"mailto:amd-gfx@lists.freedes=
ktop.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx@lists.freedesktop.or=
g</a>&gt;; Mark Yacoub &lt;<a href=3D"mailto:markyacoub@chromium.org" targe=
t=3D"_blank" rel=3D"noreferrer">markyacoub@chromium.org</a>&gt;; Deucher, A=
lexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" target=3D"_blank"=
 rel=3D"noreferrer">Alexander.Deucher@amd.com</a>&gt;; Wheeler, Daniel &lt;=
<a href=3D"mailto:Daniel.Wheeler@amd.com" target=3D"_blank" rel=3D"noreferr=
er">Daniel.Wheeler@amd.com</a>&gt;; Siqueira, Rodrigo &lt;<a href=3D"mailto=
:Rodrigo.Siqueira@amd.com" target=3D"_blank" rel=3D"noreferrer">Rodrigo.Siq=
ueira@amd.com</a>&gt;; Kazlauskas, Nicholas
 &lt;<a href=3D"mailto:Nicholas.Kazlauskas@amd.com" target=3D"_blank" rel=
=3D"noreferrer">Nicholas.Kazlauskas@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/display: Update modifier list for g=
fx10_3<u></u><u></u></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">On Thu, Apr 15, 2021 at 1:35 AM Qingqing Zhuo &lt;<a=
 href=3D"mailto:qingqing.zhuo@amd.com" target=3D"_blank" rel=3D"noreferrer"=
>qingqing.zhuo@amd.com</a>&gt; wrote:<u></u><u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal">[Why]<br>
Current list only includes modifiers where DCC_MAX_COMPRESSED_BLOCK<br>
is set to AMD_FMT_MOD_DCC_BLOCK_128B, while AMD_FMT_MOD_DCC_BLOCK_64B<br>
is also supported and used by userspace.<br>
<br>
[How]<br>
Add AMD_FMT_MOD_DCC_BLOCK_64B to modifiers with DCC supported.<br>
<br>
Signed-off-by: Qingqing Zhuo &lt;<a href=3D"mailto:qingqing.zhuo@amd.com" t=
arget=3D"_blank" rel=3D"noreferrer">qingqing.zhuo@amd.com</a>&gt;<br>
---<br>
=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++++++++++++++++++=
+<br>
=C2=A01 file changed, 23 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index e29cb2e956db..c3cbc3d298e7 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -4535,6 +4535,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int pipe_xor_bits =3D ilog2(adev-&gt;gfx.config=
.gb_addr_config_fields.num_pipes);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int pkrs =3D ilog2(adev-&gt;gfx.config.gb_addr_=
config_fields.num_pkrs);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(PACKERS, pkrs) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_64B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<u></u><u>=
</u></p>
</blockquote>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks for finding this issue. Looking at it it look=
s to me like the original entries are mistaken. Can we just change the=C2=
=A0 DCC_MAX_COMPRESSED_BLOCK in the already existing DCC entries? Looks lik=
e Mesa always uses the AMD_FMT_MOD_DCC_BLOCK_64B
 anyway, and I don&#39;t think DCC_INDEPENDENT_64B=3D1 + DCC_MAX_COMPRESSED=
_BLOCK=3DAMD_FMT_MOD_DCC_BLOCK_128B makes sense.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><span style=3D"color:#548235">Thanks for the suggest=
ion. Will send out an updated version soon.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#548235"><u></u>=C2=A0<u></u></=
span></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
@@ -4546,6 +4557,18 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(PACKERS, pkrs) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_RETILE, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_64B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
-- <br>
2.17.1<u></u><u></u></p>
</blockquote>
</div>
</div>
</div>
</div>

</blockquote></div>

--000000000000ab46d005c005568f--

--===============0396012134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0396012134==--
