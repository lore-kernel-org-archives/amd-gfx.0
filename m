Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27A9C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 00:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C2D4610A6
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 00:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C2D4610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D89D16EA89;
	Thu, 16 Sep 2021 00:37:50 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809836EA89
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 00:37:49 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id o8so2737367pll.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4OctmAqE6uAa0QDzaBFHl94KbvYnQoEQzxxOaxgS05w=;
 b=exeqzkrvfRlU/7m01oyNY0Y2tmABdG5JINCQLM4UBOdBbzDy0itqxzgNFLtsBa1r65
 Z6X92sQKyZbZ1GQ1kkDOgz+7vPjgHrUM9JXprvrCqPL2l9/DngcNL9ViDbnWQxv0ir1y
 K6I3cZL3GtqOfNyqiTAyYaHdln3L19QM46BK3MDQzsP9fnx+LJ78hPClJLTsvFM7ehz9
 KBVge217s58b1Nykl/V+jpJLFegmmm8OswpxHSFEGir9QR2j9TokdHOis2vcnj308ZSl
 /IZyq4X6BBVlV661zX16+ZHseCoovYMqSnF/8JffH5XgecMhx1rRo1bILVQYynKzhzGo
 6daQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4OctmAqE6uAa0QDzaBFHl94KbvYnQoEQzxxOaxgS05w=;
 b=52EWWFOWexE/bVPfdk0Wza8bk9ljz0J+f+hy4W0eiJQdC6Qdg7SuMm/Nzo8MqC/9P1
 NWYaT0iRtv36uo8nAR5szXUyN2SkrdOIUH+pgDS/IcLUL34k41HQug8QrU70B22/tM69
 tPiQKMpY62JbHPNxNgUkzRI9A7Jpjt/nYgC4YgxWocsdF1QMbBe6FVFhn0loUnn4eJOZ
 m4Q891v9QeVpiUGsAdONBaFPTm0rDt7kKL3PumgaU3nEz4lxztacrL1f52/RNBioevh+
 xqcivpXNdqOBIqjKz+HgD6lj1x7dHqrAzWbhSCGZdJtUjHVy3lkP6n4ohcCf5z7ER27W
 DJQg==
X-Gm-Message-State: AOAM532iinql6f+qD+cvVH8vDAkb7K3BGjZDQp7ThZ/6FwbsQ+516k7s
 Yxe3QxwwBErndcoVS4mH1ZAFYakZREz0/U5diRiR+2IO0ok=
X-Google-Smtp-Source: ABdhPJySxmgotHXBQIda+NdeR7BDJ8Z5/v2MmWoXzfRGuUJRjPU4rMvVwfq32BR17UdK4a5YlVe2YhY1LO0kbb/jq7E=
X-Received: by 2002:a17:90a:7301:: with SMTP id
 m1mr2724494pjk.164.1631752669161; 
 Wed, 15 Sep 2021 17:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210914235948.893422-1-joshua@froggi.es>
 <20210914235948.893422-3-joshua@froggi.es>
 <CAAxE2A4yR7aXPocAHdsKsyN-vVQFUKiX_7gyxD6-iG4mzHTs6A@mail.gmail.com>
 <4f77cc16-783c-3920-d666-431b7252641e@froggi.es>
In-Reply-To: <4f77cc16-783c-3920-d666-431b7252641e@froggi.es>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 15 Sep 2021 20:37:12 -0400
Message-ID: <CAAxE2A5ZLjc1G=0YuykgvpQUrxqyFStFgWxZOQ4OvaF5d2Qx8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Add modifiers capable of DCC image
 stores for gfx10_3
To: Joshua Ashton <joshua@froggi.es>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, 
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: multipart/alternative; boundary="00000000000034eee805cc120605"
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

--00000000000034eee805cc120605
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, I forgot about 4K. It looks good. Thanks!

Marek

On Wed, Sep 15, 2021 at 8:23 PM Joshua Ashton <joshua@froggi.es> wrote:

>
>
> On 9/16/21 01:11, Marek Ol=C5=A1=C3=A1k wrote:
> > Based on the discussions we had about displayable DCC internally, only
> > MAX_COMPRESSED_BLOCK =3D 64B with both DCC_INDEPENDENT_64B_BLOCKS and
> > DCC_INDEPENDENT_128B_BLOCKS is supported by DCN on RDNA 2.
> >
>  From my testing:
>
> It works fine when setting PRIMARY_SURFACE_DCC_IND_BLK to 2
> (hubp_ind_block_128b) with 128b blocks alone.
>
> Previously, PRIMARY_SURFACE_DCC_IND_BLK would only ever be 1 or 0, and
> both of these values do not work for 128b.
>
> This change has been tested with both Gamescope compositing and for Doom
> Eternal.
>
> I have validated that the modifiers are in use in both of these
> scenarios and the register values were found and tested with
>
> sudo umr -O bits -r vangogh.dcn301.mmHUBPREQ0_DCSURF_SURFACE_CONTROL
>
> - Joshie =F0=9F=90=B8=E2=9C=A8
>
>
> > Is there something new on the hardware side that I missed?
> >
> > Marek
> >
> > On Tue, Sep 14, 2021 at 7:59 PM Joshua Ashton <joshua@froggi.es
> > <mailto:joshua@froggi.es>> wrote:
> >
> >     Some games, ie. Doom Eternal, present from compute following comput=
e
> >     post-fx and would benefit from having DCC image stores available.
> >
> >     DCN on gfx10_3 doesn't need INDEPENDENT_128B_BLOCKS =3D 0 so we can
> expose
> >     these modifiers capable of DCC image stores.
> >
> >     Signed-off-by: Joshua Ashton <joshua@froggi.es
> >     <mailto:joshua@froggi.es>>
> >     Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl
> >     <mailto:bas@basnieuwenhuizen.nl>>
> >     ---
> >       .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21
> +++++++++++++++++++
> >       1 file changed, 21 insertions(+)
> >
> >     diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >     b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >     index 2a24e43623cb..a4e33a4336a0 100644
> >     --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >     +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >     @@ -4817,6 +4817,16 @@ add_gfx10_3_modifiers(const struct
> >     amdgpu_device *adev,
> >                          AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> >                          AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> >     AMD_FMT_MOD_DCC_BLOCK_64B));
> >
> >     +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> >     +                   AMD_FMT_MOD_SET(TILE,
> >     AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> >     +                   AMD_FMT_MOD_SET(TILE_VERSION,
> >     AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> >     +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> >     +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
> >     +                   AMD_FMT_MOD_SET(DCC, 1) |
> >     +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> >     +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> >     +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> >     AMD_FMT_MOD_DCC_BLOCK_128B));
> >     +
> >              add_modifier(mods, size, capacity, AMD_FMT_MOD |
> >                          AMD_FMT_MOD_SET(TILE,
> >     AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> >                          AMD_FMT_MOD_SET(TILE_VERSION,
> >     AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> >     @@ -4829,6 +4839,17 @@ add_gfx10_3_modifiers(const struct
> >     amdgpu_device *adev,
> >                          AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> >                          AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> >     AMD_FMT_MOD_DCC_BLOCK_64B));
> >
> >     +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> >     +                   AMD_FMT_MOD_SET(TILE,
> >     AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> >     +                   AMD_FMT_MOD_SET(TILE_VERSION,
> >     AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> >     +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> >     +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
> >     +                   AMD_FMT_MOD_SET(DCC, 1) |
> >     +                   AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> >     +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> >     +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> >     +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
> >     AMD_FMT_MOD_DCC_BLOCK_128B));
> >     +
> >              add_modifier(mods, size, capacity, AMD_FMT_MOD |
> >                          AMD_FMT_MOD_SET(TILE,
> >     AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> >                          AMD_FMT_MOD_SET(TILE_VERSION,
> >     AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> >     --
> >     2.33.0
> >
>

--00000000000034eee805cc120605
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Ah, I forgot about 4K. It looks good. Thanks!</div><d=
iv><br></div><div>Marek<br></div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 15, 2021 at 8:23 PM Joshua Ash=
ton &lt;<a href=3D"mailto:joshua@froggi.es" target=3D"_blank">joshua@froggi=
.es</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><br>
<br>
On 9/16/21 01:11, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; Based on the discussions we had about displayable DCC internally, only=
 <br>
&gt; MAX_COMPRESSED_BLOCK =3D 64B with both DCC_INDEPENDENT_64B_BLOCKS and =
<br>
&gt; DCC_INDEPENDENT_128B_BLOCKS is supported by DCN on RDNA 2.<br>
&gt; <br>
=C2=A0From my testing:<br>
<br>
It works fine when setting PRIMARY_SURFACE_DCC_IND_BLK to 2 <br>
(hubp_ind_block_128b) with 128b blocks alone.<br>
<br>
Previously, PRIMARY_SURFACE_DCC_IND_BLK would only ever be 1 or 0, and <br>
both of these values do not work for 128b.<br>
<br>
This change has been tested with both Gamescope compositing and for Doom <b=
r>
Eternal.<br>
<br>
I have validated that the modifiers are in use in both of these <br>
scenarios and the register values were found and tested with<br>
<br>
sudo umr -O bits -r vangogh.dcn301.mmHUBPREQ0_DCSURF_SURFACE_CONTROL<br>
<br>
- Joshie =F0=9F=90=B8=E2=9C=A8<br>
<br>
<br>
&gt; Is there something new on the hardware side that I missed?<br>
&gt; <br>
&gt; Marek<br>
&gt; <br>
&gt; On Tue, Sep 14, 2021 at 7:59 PM Joshua Ashton &lt;<a href=3D"mailto:jo=
shua@froggi.es" target=3D"_blank">joshua@froggi.es</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:joshua@froggi.es" target=3D"_blank">joshu=
a@froggi.es</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Some games, ie. Doom Eternal, present from compute =
following compute<br>
&gt;=C2=A0 =C2=A0 =C2=A0post-fx and would benefit from having DCC image sto=
res available.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0DCN on gfx10_3 doesn&#39;t need INDEPENDENT_128B_BL=
OCKS =3D 0 so we can expose<br>
&gt;=C2=A0 =C2=A0 =C2=A0these modifiers capable of DCC image stores.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Joshua Ashton &lt;<a href=3D"mailto:=
joshua@froggi.es" target=3D"_blank">joshua@froggi.es</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:joshua@froggi.es" targ=
et=3D"_blank">joshua@froggi.es</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reviewed-by: Bas Nieuwenhuizen &lt;<a href=3D"mailt=
o:bas@basnieuwenhuizen.nl" target=3D"_blank">bas@basnieuwenhuizen.nl</a><br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:bas@basnieuwenhuizen.n=
l" target=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.=
c | 21 +++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A01 file changed, 21 insertions(+)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/=
amdgpu_dm.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 2a24e43623cb..a4e33a4336a0 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_=
dm.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_=
dm.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -4817,6 +4817,16 @@ add_gfx10_3_modifiers(const =
struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_device *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_DCC_BLOCK_64B));<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size=
, capacity, AMD_FMT_MOD |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(TILE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(TILE_VERSION,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(PACKERS, pkrs) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(DCC, 1) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_DCC_BLOCK_128B));<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, siz=
e, capacity, AMD_FMT_MOD |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(TILE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(TILE_VERSION,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -4829,6 +4839,17 @@ add_gfx10_3_modifiers(const =
struct<br>
&gt;=C2=A0 =C2=A0 =C2=A0amdgpu_device *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_DCC_BLOCK_64B));<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0add_modifier(mods, size=
, capacity, AMD_FMT_MOD |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(TILE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(TILE_VERSION,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(PACKERS, pkrs) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(DCC, 1) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(DCC_RETILE, 1) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_DCC_BLOCK_128B));<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, siz=
e, capacity, AMD_FMT_MOD |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(TILE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 AMD_FMT_MOD_SET(TILE_VERSION,<br>
&gt;=C2=A0 =C2=A0 =C2=A0AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.33.0<br>
&gt; <br>
</blockquote></div>

--00000000000034eee805cc120605--
