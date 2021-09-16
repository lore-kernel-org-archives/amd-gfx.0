Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B31C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 00:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE69B6120E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 00:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE69B6120E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 543DC6EA85;
	Thu, 16 Sep 2021 00:20:17 +0000 (UTC)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC3B6EA85
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 00:20:17 +0000 (UTC)
Received: by mail-io1-xd36.google.com with SMTP id b7so5815728iob.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y7zGuCNQymr8m0d72iMfw6iDfDeNu5AF304a2wUZrTI=;
 b=c/wQvKe4fPcPnmrKEWRpsrAWmC2h0xyT34P9y6a2nyBJUJpZuy2zBYwUGho8l2DzHn
 OMqOnQ7sVZomKPHiArUou2mPUls+AtHLVTbJYnULp/WVpmTObMzlAQzD4v0m3WPk1XLU
 SU43MLrbbPQ2ZqzA/4WuaE8wUC93BVKSwmisPQfr3Myl2g3y/hi9pSa3lUFIyIfK5/a3
 Kn4dGVQ1Z/sgHj4JoNstZCg1INz7QZEoj0Ll+7rlmpADQIDtmn43RT8a89B2Poa0x0i/
 D4cDA6SF471NjeTzhMqHBLLKXB4AniexlBzgRCjpc95DwJfsnBqVeZAALXkAgvrcsaO6
 6n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y7zGuCNQymr8m0d72iMfw6iDfDeNu5AF304a2wUZrTI=;
 b=KljaBreZvVKQm2oRDd6jj0hfjbn/1RC5Ear/XlEWu/ZR2Ks7bYf9YR0qTeHz/EeWJp
 ImIBmI2hl3p9tk5Vvft4jtwtBtC8svTORInI7cO93x8Wz30lVzEA1kF4eGmCYm8M2twT
 PUx2JMe/1bJynIVfTpuD2+37ud7JkG3SXbWJRd/GmdPOXDMiSeW2Qh1OCnC0CMb9AnRp
 114f508EdX9/exgodcTQGLhXdQtqW7p/Zjw0A6juYzT4GTH/JfwnYl6qQEac4oBGHZZ9
 Kg/3vylKl+cUU+6fAI+1a3eHJRXaBGcljXU/SuJHu2tauN1NzQ1meYNQ/9zz9sWPUr+2
 BTGA==
X-Gm-Message-State: AOAM531vfGed1gRSbKDnWjt0hGtbcRvhmKQqFdNvjzMVq8FXFQy05UJW
 uJt1i0BLFbtWyfCxl8ax9oTcJZeavPbDSCCCLS/i6Q==
X-Google-Smtp-Source: ABdhPJynjvrPoWk56O2DdkYqt+L8z1Kz6K2Aa5mlp+dwPc7Qv6KrAOOapISgaaRWCfCy0vBO/304vheLy8Q0J7SfWFE=
X-Received: by 2002:a05:6602:584:: with SMTP id
 v4mr2210156iox.85.1631751616386; 
 Wed, 15 Sep 2021 17:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210914235948.893422-1-joshua@froggi.es>
 <20210914235948.893422-3-joshua@froggi.es>
 <CAAxE2A4yR7aXPocAHdsKsyN-vVQFUKiX_7gyxD6-iG4mzHTs6A@mail.gmail.com>
In-Reply-To: <CAAxE2A4yR7aXPocAHdsKsyN-vVQFUKiX_7gyxD6-iG4mzHTs6A@mail.gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Thu, 16 Sep 2021 02:20:04 +0200
Message-ID: <CAP+8YyEmyFG3t3GrMuAbwCtyvAumwsoGsVuzB3gtPsBJi2RBgQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Add modifiers capable of DCC image
 stores for gfx10_3
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: Joshua Ashton <joshua@froggi.es>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="00000000000074f98905cc11c70a"
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

--00000000000074f98905cc11c70a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 16, 2021, 2:12 AM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wrot=
e:

> Based on the discussions we had about displayable DCC internally, only
> MAX_COMPRESSED_BLOCK =3D 64B with both DCC_INDEPENDENT_64B_BLOCKS and
> DCC_INDEPENDENT_128B_BLOCKS is supported by DCN on RDNA 2.
>
> Is there something new on the hardware side that I missed?
>

Per the comments you put in mesa that was only needed for 4k?

https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/amd/common/ac_surf=
ace.c#L1444


> Marek
>
> On Tue, Sep 14, 2021 at 7:59 PM Joshua Ashton <joshua@froggi.es> wrote:
>
>> Some games, ie. Doom Eternal, present from compute following compute
>> post-fx and would benefit from having DCC image stores available.
>>
>> DCN on gfx10_3 doesn't need INDEPENDENT_128B_BLOCKS =3D 0 so we can expo=
se
>> these modifiers capable of DCC image stores.
>>
>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>> Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> ---
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 +++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 2a24e43623cb..a4e33a4336a0 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4817,6 +4817,16 @@ add_gfx10_3_modifiers(const struct amdgpu_device
>> *adev,
>>                     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>>                     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
>> AMD_FMT_MOD_DCC_BLOCK_64B));
>>
>> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
>> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X)=
 |
>> +                   AMD_FMT_MOD_SET(TILE_VERSION,
>> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
>> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
>> +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
>> +                   AMD_FMT_MOD_SET(DCC, 1) |
>> +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
>> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
>> AMD_FMT_MOD_DCC_BLOCK_128B));
>> +
>>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
>>                     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X)=
 |
>>                     AMD_FMT_MOD_SET(TILE_VERSION,
>> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
>> @@ -4829,6 +4839,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device
>> *adev,
>>                     AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>>                     AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
>> AMD_FMT_MOD_DCC_BLOCK_64B));
>>
>> +       add_modifier(mods, size, capacity, AMD_FMT_MOD |
>> +                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X)=
 |
>> +                   AMD_FMT_MOD_SET(TILE_VERSION,
>> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
>> +                   AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
>> +                   AMD_FMT_MOD_SET(PACKERS, pkrs) |
>> +                   AMD_FMT_MOD_SET(DCC, 1) |
>> +                   AMD_FMT_MOD_SET(DCC_RETILE, 1) |
>> +                   AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
>> +                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>> +                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK,
>> AMD_FMT_MOD_DCC_BLOCK_128B));
>> +
>>         add_modifier(mods, size, capacity, AMD_FMT_MOD |
>>                     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X)=
 |
>>                     AMD_FMT_MOD_SET(TILE_VERSION,
>> AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
>> --
>> 2.33.0
>>
>>

--00000000000074f98905cc11c70a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Sep 16, 2021, 2:12 AM Marek Ol=C5=A1=C3=A1k &l=
t;<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank" rel=3D"noreferrer">=
maraeo@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><di=
v dir=3D"ltr"><div>Based on the discussions we had about displayable DCC in=
ternally, only MAX_COMPRESSED_BLOCK =3D 64B with both DCC_INDEPENDENT_64B_B=
LOCKS and DCC_INDEPENDENT_128B_BLOCKS is supported by DCN on RDNA 2.</div><=
div><br></div><div>Is there something new on the hardware side that I misse=
d?<br></div></div></blockquote></div></div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Per the comments you put in mesa that was only needed for 4k?=
</div><div dir=3D"auto"><br></div><div dir=3D"auto"><a href=3D"https://gitl=
ab.freedesktop.org/mesa/mesa/-/blob/main/src/amd/common/ac_surface.c#L1444"=
>https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/amd/common/ac_sur=
face.c#L1444</a></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div></=
div><div><br></div><div>Marek<br></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 14, 2021 at 7:59 PM Josh=
ua Ashton &lt;<a href=3D"mailto:joshua@froggi.es" rel=3D"noreferrer norefer=
rer" target=3D"_blank">joshua@froggi.es</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Some games, ie. Doom Eternal, presen=
t from compute following compute<br>
post-fx and would benefit from having DCC image stores available.<br>
<br>
DCN on gfx10_3 doesn&#39;t need INDEPENDENT_128B_BLOCKS =3D 0 so we can exp=
ose<br>
these modifiers capable of DCC image stores.<br>
<br>
Signed-off-by: Joshua Ashton &lt;<a href=3D"mailto:joshua@froggi.es" rel=3D=
"noreferrer noreferrer" target=3D"_blank">joshua@froggi.es</a>&gt;<br>
Reviewed-by: Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwenhuizen.n=
l" rel=3D"noreferrer noreferrer" target=3D"_blank">bas@basnieuwenhuizen.nl<=
/a>&gt;<br>
---<br>
=C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 ++++++++++++++++++=
+<br>
=C2=A01 file changed, 21 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 2a24e43623cb..a4e33a4336a0 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -4817,6 +4817,16 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<br>
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
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
@@ -4829,6 +4839,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device *ad=
ev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));<br>
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
MT_MOD_SET(DCC_INDEPENDENT_128B, 1) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AMD_F=
MT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 add_modifier(mods, size, capacity, AMD_FMT_MOD =
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AMD_F=
MT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |<br>
-- <br>
2.33.0<br>
<br>
</blockquote></div>
</blockquote></div></div></div>

--00000000000074f98905cc11c70a--
