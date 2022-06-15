Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD757C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 00:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC3A10EFFD;
	Wed, 15 Jun 2022 00:38:07 +0000 (UTC)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E45D10EFFD
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 00:38:06 +0000 (UTC)
Received: by mail-yb1-xb2b.google.com with SMTP id l204so17850438ybf.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 17:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=80dCoZ3CpmlN+gSJXitDsSO4DQUyA3f7pFLB1pi7UQ0=;
 b=fIN7p6Yd9XT1VylsXatM54Y7dybgQHjlKQVWsRUTmdsvmGkfAFlY8AIjdQOPGcYEnM
 sYALmeftWkBBMl3Q6sMt2ukqkZDVJUzPF5hhGPsuw1VnMrZClh0BGkcQv9aIhgU+oY9m
 dr3wn62QMKFrS4B6zO8gYx7gzKM2I/NgClJwHYqMonJNygzM4SqQJbnjDaxyXrHBiPNT
 z21qPzUimjCXrIYiI/M92Yg+ilBmql8gc1aagG5t5v8WzIrA2skabk1vXtQCHKfNBpRY
 rb/Ay6/J2f9apqx6jU64MJIUbVwfXv31mxIsMQGYF6opIIasVFd9/sIhxIQdszQ+k2jp
 pciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=80dCoZ3CpmlN+gSJXitDsSO4DQUyA3f7pFLB1pi7UQ0=;
 b=aqAgL7EUROz2tK8nAMSi5ZmvQ/kO9NeaTRLu/uPzTPYk5skrwJcIpa9l0SML5TVtEv
 12dg9gZN5vgbWY+ghBXbU7AU0Q+j8ReM9+a9NgZtO0Ujx2YFwzaq7ea3kAMrvdenBD8B
 QRu82YW31bB1NQFQiGUKbarPb1s+Rje8k3Nt8oD4VdprzRk5PiBcEExyWWv7oFnWIn/j
 e3tS12DTXcwVZxU53Dora0na3d4sKiaVxrx0RIzJ9cYsp5Pa4wpMG0BmWEqUuGnZI+pS
 SxIG72QLgHV/jAxaifV7vDrQMItVWug/2Aj+vuph7plEZER4es2Gqoe9UV0T3nX8N7yD
 IWVQ==
X-Gm-Message-State: AJIora8uaIrNOYYcczD+Agq+aITB0yQH/zbWgmdjVyklVTc8LcJw5vqw
 FY8W1h+97qCjHp3QvsSwrmV2hsFnuBJZqNaX2Jt1Nw==
X-Google-Smtp-Source: AGRyM1tCgcQsQk6vP9MGXXiDINDwC6XV23quC4/w4OP2SXSl5tlVdSpr8ySnj0R9yIn97cU0xRscvyuSV6ElboxbeOY=
X-Received: by 2002:a25:cb8a:0:b0:65c:a718:475c with SMTP id
 b132-20020a25cb8a000000b0065ca718475cmr7796500ybg.352.1655253485284; Tue, 14
 Jun 2022 17:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220609142725.28973-1-aurabindo.pillai@amd.com>
 <CAP+8YyE1reTB-G=Wkkx2v=eTJUuUCbpAgmEc2Y5ePJLVXYkZKA@mail.gmail.com>
 <CAAxE2A4KVUsjx+zoJG4s9-eZH6+k-xyt21brJtYqHdKAHkfXCg@mail.gmail.com>
In-Reply-To: <CAAxE2A4KVUsjx+zoJG4s9-eZH6+k-xyt21brJtYqHdKAHkfXCg@mail.gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 15 Jun 2022 02:38:17 +0200
Message-ID: <CAP+8YyGrSbmGUqV5XDBmyufieM7bwd6aWmcMeeZr+Z6hFBgZog@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: ignore modifiers when checking for
 format support
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>, "Siqueira,
 Rodrigo" <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Qiao,
 Ken" <ken.qiao@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 13, 2022 at 1:47 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wr=
ote:
>
> Bas, the code was literally rejecting swizzle modes that were not in the =
modifier list, which was incorrect. That's because the modifier list is a s=
ubset of all supported swizzle modes.

That was WAI. The kernel is now in charge of rejecting stuff that is
not capable of being displayed.

Allowing all in format_mod_supported has several implications on
exposed & accepted modifiers as well, that should be avoided even if
we should do a behavior change for non-modifiers: We now expose (i.e.
list) modifiers for formats which they don't support and we removed
the check that the modifier is in the list for commits with modifiers
too. Hence this logic would need a serious rework instead of the patch
that was sent.

What combinations were failing, and can't we just add modifiers for them?




>
> Marek
>
> On Sun, Jun 12, 2022 at 7:54 PM Bas Nieuwenhuizen <bas@basnieuwenhuizen.n=
l> wrote:
>>
>> On Thu, Jun 9, 2022 at 4:27 PM Aurabindo Pillai
>> <aurabindo.pillai@amd.com> wrote:
>> >
>> > [Why&How]
>> > There are cases where swizzle modes are set but modifiers arent. For
>> > such a userspace, we need not check modifiers while checking
>> > compatibilty in the drm hook for checking plane format.
>> >
>> > Ignore checking modifiers but check the DCN generation for the
>> > supported swizzle mode.
>> >
>> > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> > ---
>> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++++-=
-
>> >  1 file changed, 46 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > index 2023baf41b7e..1322df491736 100644
>> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > @@ -4938,6 +4938,7 @@ static bool dm_plane_format_mod_supported(struct=
 drm_plane *plane,
>> >  {
>> >         struct amdgpu_device *adev =3D drm_to_adev(plane->dev);
>> >         const struct drm_format_info *info =3D drm_format_info(format)=
;
>> > +       struct hw_asic_id asic_id =3D adev->dm.dc->ctx->asic_id;
>> >         int i;
>> >
>> >         enum dm_micro_swizzle microtile =3D modifier_gfx9_swizzle_mode=
(modifier) & 3;
>> > @@ -4955,13 +4956,53 @@ static bool dm_plane_format_mod_supported(stru=
ct drm_plane *plane,
>> >                 return true;
>> >         }
>> >
>> > -       /* Check that the modifier is on the list of the plane's suppo=
rted modifiers. */
>> > -       for (i =3D 0; i < plane->modifier_count; i++) {
>> > -               if (modifier =3D=3D plane->modifiers[i])
>> > +       /* check if swizzle mode is supported by this version of DCN *=
/
>> > +       switch (asic_id.chip_family) {
>> > +               case FAMILY_SI:
>> > +               case FAMILY_CI:
>> > +               case FAMILY_KV:
>> > +               case FAMILY_CZ:
>> > +               case FAMILY_VI:
>> > +                       /* AI and earlier asics does not have modifier=
 support */
>> > +                       return false;
>> > +                       break;
>> > +               case FAMILY_AI:
>> > +               case FAMILY_RV:
>> > +               case FAMILY_NV:
>> > +               case FAMILY_VGH:
>> > +               case FAMILY_YELLOW_CARP:
>> > +               case AMDGPU_FAMILY_GC_10_3_6:
>> > +               case AMDGPU_FAMILY_GC_10_3_7:
>> > +                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
>> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
>> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
>> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
>> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
>> > +                                       return true;
>> > +                                       break;
>> > +                               default:
>> > +                                       return false;
>> > +                                       break;
>> > +                       }
>> > +                       break;
>> > +               case AMDGPU_FAMILY_GC_11_0_0:
>> > +                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
>> > +                               case AMD_FMT_MOD_TILE_GFX11_256K_R_X:
>> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
>> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
>> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
>> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
>> > +                                       return true;
>> > +                                       break;
>> > +                               default:
>> > +                                       return false;
>> > +                                       break;
>> > +                       }
>> > +                       break;
>> > +               default:
>> > +                       ASSERT(0); /* Unknown asic */
>> >                         break;
>> >         }
>>
>> This seems broken to me. AFAICT we always return in the switch so the
>> code after this that checks for valid DCC usage isn't executed.
>> Checking the list of modifiers is also essential to make sure other
>> stuff in the modifier is set properly.
>>
>> If you have userspace that is not using modifiers that is giving you
>> issues, a better place to look might be
>> convert_tiling_flags_to_modifier in amdgpu_display.c
>>
>> > -       if (i =3D=3D plane->modifier_count)
>> > -               return false;
>> >
>> >         /*
>> >          * For D swizzle the canonical modifier depends on the bpp, so=
 check
>> > --
>> > 2.36.1
>> >
