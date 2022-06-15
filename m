Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47569C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 01:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EB8112B8A;
	Wed, 15 Jun 2022 01:23:43 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D04112B8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 01:23:42 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id 123so10036460pgb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 18:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aEPMcdqc6ApyMTtWRy5/WozsI9H5e5M18nMlkb0pmLU=;
 b=TxqK1MVI6PVuVAWK96beuqPEoE1/kYWyL3I5/Nh+V78Rff06Agxt8qBg6W/KYBR38V
 w3+3Q0n208FpYj2drTQkNaXlbPKOKB+FX3dwTfRJTJwcbWKTHjuvMmTeST7XiYpnrCwr
 rWEH51kO8lAtCSabJP30/etBIN+mmhQiU64J4q4Xt2aRkATY/yVyI0B2XOFuC3y6vvxJ
 dXz49MmUJ1DBS+lqqfQE0XFZHoWwsTOG5XxkybabVkpz6yRJUG5O2YMsyw8Mlgi88Xgt
 Fzx9tPck0nXv2PqINdl3QizkWkdfEU15QBSuaxTmMLy88cbtFhQ2qDbI0FTPFdL0MJte
 Fb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aEPMcdqc6ApyMTtWRy5/WozsI9H5e5M18nMlkb0pmLU=;
 b=iAfkHnTyHRsJNtAhE2a/ZdeoriMOe+jJ8a9anw+q62jbWn+5unVz7+X5KjckUgIdgW
 xJgVsJD6Doi+M5Mnk1fMBmcItmU7+FuMV3q3PPi/abNK5Gm90KPFQnb7oHfmARzKr3ss
 4phYgzl/HTLozBPQZCsVx8I6E2z1xdaTcaPcvevDJB7sspw/HLP7AcpDh5/QP0Kmaw+3
 hB39STVrgxGt87q0M+G91izTrCLMqGrZPPXuqaC8YzvZv5KX7HQZDzqUt+FpyumcHPlq
 Y4bOGZjmdRhb6nl3FMhoDqal9xiVqMX1PpyfDOFCI2mCRPkTM9r/7eEV6IBeNC5g8FDS
 kzYw==
X-Gm-Message-State: AOAM532orIB68zkdLpmf9s2NeDngB3TH1sIsKQmZJ/duVtFAAL62sjY8
 4dsQYQwjOAKTYF5RClrPLq/gFeIBsIzhhZ2Thc4=
X-Google-Smtp-Source: ABdhPJzMKIMxY15g3zIJ6mMCy//NeT1s9IpYNR/lRS+w2hFLbdfiby2xUqsDaPtS6ugp1d+JYQ92Ly13qXdR625zi/Y=
X-Received: by 2002:a63:7c4e:0:b0:380:8ae9:c975 with SMTP id
 l14-20020a637c4e000000b003808ae9c975mr6916971pgn.25.1655256222210; Tue, 14
 Jun 2022 18:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220609142725.28973-1-aurabindo.pillai@amd.com>
 <CAP+8YyE1reTB-G=Wkkx2v=eTJUuUCbpAgmEc2Y5ePJLVXYkZKA@mail.gmail.com>
 <CAAxE2A4KVUsjx+zoJG4s9-eZH6+k-xyt21brJtYqHdKAHkfXCg@mail.gmail.com>
 <CAP+8YyGrSbmGUqV5XDBmyufieM7bwd6aWmcMeeZr+Z6hFBgZog@mail.gmail.com>
In-Reply-To: <CAP+8YyGrSbmGUqV5XDBmyufieM7bwd6aWmcMeeZr+Z6hFBgZog@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 14 Jun 2022 21:23:06 -0400
Message-ID: <CAAxE2A7a1bDCGhq132BV4sreMu2kd=wo58+xRvpmGhv5HFksZw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: ignore modifiers when checking for
 format support
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: multipart/alternative; boundary="000000000000231f7b05e1725fe2"
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
Cc: "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, "Siqueira,
 Rodrigo" <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Qiao,
 Ken" <ken.qiao@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000231f7b05e1725fe2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We can reject invalid modifiers elsewhere, but it can't be here because
it's also the non-modifier path.

We expose 256KB_R_X or 64KB_R_X modifiers depending on chip-specific
settings, but not both. Only the optimal option is exposed. This is OK for
modifiers, but not OK with AMD-specific BO metadata where the UMD
determines the swizzle mode.

Marek

On Tue, Jun 14, 2022 at 8:38 PM Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
wrote:

> On Mon, Jun 13, 2022 at 1:47 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> =
wrote:
> >
> > Bas, the code was literally rejecting swizzle modes that were not in th=
e
> modifier list, which was incorrect. That's because the modifier list is a
> subset of all supported swizzle modes.
>
> That was WAI. The kernel is now in charge of rejecting stuff that is
> not capable of being displayed.
>
> Allowing all in format_mod_supported has several implications on
> exposed & accepted modifiers as well, that should be avoided even if
> we should do a behavior change for non-modifiers: We now expose (i.e.
> list) modifiers for formats which they don't support and we removed
> the check that the modifier is in the list for commits with modifiers
> too. Hence this logic would need a serious rework instead of the patch
> that was sent.
>
> What combinations were failing, and can't we just add modifiers for them?
>
>
>
>
> >
> > Marek
> >
> > On Sun, Jun 12, 2022 at 7:54 PM Bas Nieuwenhuizen <
> bas@basnieuwenhuizen.nl> wrote:
> >>
> >> On Thu, Jun 9, 2022 at 4:27 PM Aurabindo Pillai
> >> <aurabindo.pillai@amd.com> wrote:
> >> >
> >> > [Why&How]
> >> > There are cases where swizzle modes are set but modifiers arent. For
> >> > such a userspace, we need not check modifiers while checking
> >> > compatibilty in the drm hook for checking plane format.
> >> >
> >> > Ignore checking modifiers but check the DCN generation for the
> >> > supported swizzle mode.
> >> >
> >> > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >> > ---
> >> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51
> +++++++++++++++++--
> >> >  1 file changed, 46 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> > index 2023baf41b7e..1322df491736 100644
> >> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> > @@ -4938,6 +4938,7 @@ static bool
> dm_plane_format_mod_supported(struct drm_plane *plane,
> >> >  {
> >> >         struct amdgpu_device *adev =3D drm_to_adev(plane->dev);
> >> >         const struct drm_format_info *info =3D drm_format_info(forma=
t);
> >> > +       struct hw_asic_id asic_id =3D adev->dm.dc->ctx->asic_id;
> >> >         int i;
> >> >
> >> >         enum dm_micro_swizzle microtile =3D
> modifier_gfx9_swizzle_mode(modifier) & 3;
> >> > @@ -4955,13 +4956,53 @@ static bool
> dm_plane_format_mod_supported(struct drm_plane *plane,
> >> >                 return true;
> >> >         }
> >> >
> >> > -       /* Check that the modifier is on the list of the plane's
> supported modifiers. */
> >> > -       for (i =3D 0; i < plane->modifier_count; i++) {
> >> > -               if (modifier =3D=3D plane->modifiers[i])
> >> > +       /* check if swizzle mode is supported by this version of DCN
> */
> >> > +       switch (asic_id.chip_family) {
> >> > +               case FAMILY_SI:
> >> > +               case FAMILY_CI:
> >> > +               case FAMILY_KV:
> >> > +               case FAMILY_CZ:
> >> > +               case FAMILY_VI:
> >> > +                       /* AI and earlier asics does not have
> modifier support */
> >> > +                       return false;
> >> > +                       break;
> >> > +               case FAMILY_AI:
> >> > +               case FAMILY_RV:
> >> > +               case FAMILY_NV:
> >> > +               case FAMILY_VGH:
> >> > +               case FAMILY_YELLOW_CARP:
> >> > +               case AMDGPU_FAMILY_GC_10_3_6:
> >> > +               case AMDGPU_FAMILY_GC_10_3_7:
> >> > +                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> >> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> >> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> >> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> >> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
> >> > +                                       return true;
> >> > +                                       break;
> >> > +                               default:
> >> > +                                       return false;
> >> > +                                       break;
> >> > +                       }
> >> > +                       break;
> >> > +               case AMDGPU_FAMILY_GC_11_0_0:
> >> > +                       switch (AMD_FMT_MOD_GET(TILE, modifier)) {
> >> > +                               case AMD_FMT_MOD_TILE_GFX11_256K_R_X=
:
> >> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_R_X:
> >> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D_X:
> >> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_S_X:
> >> > +                               case AMD_FMT_MOD_TILE_GFX9_64K_D:
> >> > +                                       return true;
> >> > +                                       break;
> >> > +                               default:
> >> > +                                       return false;
> >> > +                                       break;
> >> > +                       }
> >> > +                       break;
> >> > +               default:
> >> > +                       ASSERT(0); /* Unknown asic */
> >> >                         break;
> >> >         }
> >>
> >> This seems broken to me. AFAICT we always return in the switch so the
> >> code after this that checks for valid DCC usage isn't executed.
> >> Checking the list of modifiers is also essential to make sure other
> >> stuff in the modifier is set properly.
> >>
> >> If you have userspace that is not using modifiers that is giving you
> >> issues, a better place to look might be
> >> convert_tiling_flags_to_modifier in amdgpu_display.c
> >>
> >> > -       if (i =3D=3D plane->modifier_count)
> >> > -               return false;
> >> >
> >> >         /*
> >> >          * For D swizzle the canonical modifier depends on the bpp,
> so check
> >> > --
> >> > 2.36.1
> >> >
>

--000000000000231f7b05e1725fe2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">We can reject invalid modifiers elsewhere, but it can&#39;=
t be here because it&#39;s also the non-modifier path.<br><br><div>We expos=
e 256KB_R_X or 64KB_R_X modifiers depending on chip-specific settings, but =
not both. Only the optimal option is exposed. This is OK for modifiers, but=
 not OK with AMD-specific BO metadata where the UMD determines the swizzle =
mode.<br></div><div><br></div><div>Marek<br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 14, 2022 at 8=
:38 PM Bas Nieuwenhuizen &lt;<a href=3D"mailto:bas@basnieuwenhuizen.nl" tar=
get=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt; wrote:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">On Mon, Jun 13, 2022 at 1:47 PM Marek=
 Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank">=
maraeo@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Bas, the code was literally rejecting swizzle modes that were not in t=
he modifier list, which was incorrect. That&#39;s because the modifier list=
 is a subset of all supported swizzle modes.<br>
<br>
That was WAI. The kernel is now in charge of rejecting stuff that is<br>
not capable of being displayed.<br>
<br>
Allowing all in format_mod_supported has several implications on<br>
exposed &amp; accepted modifiers as well, that should be avoided even if<br=
>
we should do a behavior change for non-modifiers: We now expose (i.e.<br>
list) modifiers for formats which they don&#39;t support and we removed<br>
the check that the modifier is in the list for commits with modifiers<br>
too. Hence this logic would need a serious rework instead of the patch<br>
that was sent.<br>
<br>
What combinations were failing, and can&#39;t we just add modifiers for the=
m?<br>
<br>
<br>
<br>
<br>
&gt;<br>
&gt; Marek<br>
&gt;<br>
&gt; On Sun, Jun 12, 2022 at 7:54 PM Bas Nieuwenhuizen &lt;<a href=3D"mailt=
o:bas@basnieuwenhuizen.nl" target=3D"_blank">bas@basnieuwenhuizen.nl</a>&gt=
; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Thu, Jun 9, 2022 at 4:27 PM Aurabindo Pillai<br>
&gt;&gt; &lt;<a href=3D"mailto:aurabindo.pillai@amd.com" target=3D"_blank">=
aurabindo.pillai@amd.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; [Why&amp;How]<br>
&gt;&gt; &gt; There are cases where swizzle modes are set but modifiers are=
nt. For<br>
&gt;&gt; &gt; such a userspace, we need not check modifiers while checking<=
br>
&gt;&gt; &gt; compatibilty in the drm hook for checking plane format.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Ignore checking modifiers but check the DCN generation for th=
e<br>
&gt;&gt; &gt; supported swizzle mode.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Aurabindo Pillai &lt;<a href=3D"mailto:aurabin=
do.pillai@amd.com" target=3D"_blank">aurabindo.pillai@amd.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 ++++=
+++++++++++++--<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 46 insertions(+), 5 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.=
c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; &gt; index 2023baf41b7e..1322df491736 100644<br>
&gt;&gt; &gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; &gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt; &gt; @@ -4938,6 +4938,7 @@ static bool dm_plane_format_mod_support=
ed(struct drm_plane *plane,<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =
=3D drm_to_adev(plane-&gt;dev);<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct drm_format_info=
 *info =3D drm_format_info(format);<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct hw_asic_id asic_id =3D ade=
v-&gt;dm.dc-&gt;ctx-&gt;asic_id;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum dm_micro_swizzle microt=
ile =3D modifier_gfx9_swizzle_mode(modifier) &amp; 3;<br>
&gt;&gt; &gt; @@ -4955,13 +4956,53 @@ static bool dm_plane_format_mod_suppo=
rted(struct drm_plane *plane,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return true;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check that the modifier is on =
the list of the plane&#39;s supported modifiers. */<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; plane-&gt;mo=
difier_count; i++) {<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (m=
odifier =3D=3D plane-&gt;modifiers[i])<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* check if swizzle mode is suppo=
rted by this version of DCN */<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (asic_id.chip_family) {<br=
>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
FAMILY_SI:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
FAMILY_CI:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
FAMILY_KV:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
FAMILY_CZ:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
FAMILY_VI:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* AI and earlier asics does not have modifier supp=
ort */<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
FAMILY_AI:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
FAMILY_RV:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
FAMILY_NV:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
FAMILY_VGH:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
FAMILY_YELLOW_CARP:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
AMDGPU_FAMILY_GC_10_3_6:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
AMDGPU_FAMILY_GC_10_3_7:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0switch (AMD_FMT_MOD_GET(TILE, modifier)) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_G=
FX9_64K_R_X:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_G=
FX9_64K_D_X:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_G=
FX9_64K_S_X:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_G=
FX9_64K_D:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return true;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return false;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case =
AMDGPU_FAMILY_GC_11_0_0:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0switch (AMD_FMT_MOD_GET(TILE, modifier)) {<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_G=
FX11_256K_R_X:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_G=
FX9_64K_R_X:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_G=
FX9_64K_D_X:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_G=
FX9_64K_S_X:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMD_FMT_MOD_TILE_G=
FX9_64K_D:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return true;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return false;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0break;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0defau=
lt:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ASSERT(0); /* Unknown asic */<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; This seems broken to me. AFAICT we always return in the switch so =
the<br>
&gt;&gt; code after this that checks for valid DCC usage isn&#39;t executed=
.<br>
&gt;&gt; Checking the list of modifiers is also essential to make sure othe=
r<br>
&gt;&gt; stuff in the modifier is set properly.<br>
&gt;&gt;<br>
&gt;&gt; If you have userspace that is not using modifiers that is giving y=
ou<br>
&gt;&gt; issues, a better place to look might be<br>
&gt;&gt; convert_tiling_flags_to_modifier in amdgpu_display.c<br>
&gt;&gt;<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D plane-&gt;modifier_c=
ount)<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n false;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * For D swizzle the canonic=
al modifier depends on the bpp, so check<br>
&gt;&gt; &gt; --<br>
&gt;&gt; &gt; 2.36.1<br>
&gt;&gt; &gt;<br>
</blockquote></div>

--000000000000231f7b05e1725fe2--
