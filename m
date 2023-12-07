Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB79C10F09
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 14:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB3710E8D1;
	Thu,  7 Dec 2023 14:59:36 +0000 (UTC)
Received: from smtp.gnome.org (smtp.gnome.org [8.43.85.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36DDB10E7E8
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 07:47:49 +0000 (UTC)
Received: from mail-lf1-f42.google.com (unknown [209.85.167.42])
 by smtp.gnome.org (Postfix) with ESMTPSA id A87332804FC8
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 07:47:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.gnome.org A87332804FC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gnome.org;
 s=default; t=1701935268;
 bh=EH12DiGK7WutsxAslJjho/6etRW8cQS/33pwQK6yTDg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CL29VQFQmel2cZooTp8IT+ZmP5EyV3OSmFm6qFGtFty29l+GsnInqdkavg5/GIIER
 AtY+sSX0VQ/FiKuCnVKwzuOUUYg9pLFECjqUM8nPT9oKgTXvQh2YN97w/4m1IgUjIB
 nA6x3WNRYiqQg5fw4Gd7OEQpUr6qIdTT9uDVjWbo=
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-50be3611794so387183e87.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Dec 2023 23:47:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yxhvn63wxmpqQGAedMv+J4wijYObykvcMyprP3D+8jOZn8dD/DG
 GXw5gW4EGC7n297KT8uta7B/5rk0qHH7G1nAL5I=
X-Google-Smtp-Source: AGHT+IGePvf4ryxiBUjBfaG4li89QIrluos5Th1j4kFvFo0BwNAOKFLtzT9fvnPCWrEsVbx0VRwP5NE68QiwvKk7CmQ=
X-Received: by 2002:ac2:555c:0:b0:50b:e14e:de2f with SMTP id
 l28-20020ac2555c000000b0050be14ede2fmr1017956lfk.41.1701935265381; Wed, 06
 Dec 2023 23:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20231205201749.213912-1-hamza.mahfooz@amd.com>
 <b369f492-a88b-460c-b614-51beb2dc2262@amd.com>
 <CAAd53p63BKUSyRd5GOuonN4yhOwt3d43mVUKY3WfGSUwSymKhg@mail.gmail.com>
 <83030633-f361-488e-b25a-98f4c5e0c9be@amd.com>
 <CAAd53p6py2YdvaJBAgve3y4Xf2sayC7LqDE-JeLpQ_LNtFOj1g@mail.gmail.com>
 <2c350488-0110-4b29-bdf3-b2018e723b5b@amd.com>
 <CAAd53p6WypOSURpcL=C9p2M5K4zai33pPhkSSa_EWvSf0QV-1A@mail.gmail.com>
In-Reply-To: <CAAd53p6WypOSURpcL=C9p2M5K4zai33pPhkSSa_EWvSf0QV-1A@mail.gmail.com>
From: Bin Li <binli@gnome.org>
Date: Thu, 7 Dec 2023 15:47:33 +0800
X-Gmail-Original-Message-ID: <CAGBH1r7Tn7vHbUeL4R1hBj-65yD+JWMho52nJ2WfK2R=9jhi0A@mail.gmail.com>
Message-ID: <CAGBH1r7Tn7vHbUeL4R1hBj-65yD+JWMho52nJ2WfK2R=9jhi0A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is
 enabled
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: multipart/alternative; boundary="000000000000ec8439060be6aea2"
X-Mailman-Approved-At: Thu, 07 Dec 2023 14:59:30 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Taimur Hassan <syed.hassan@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000ec8439060be6aea2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario,

I found I missed the part
in drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c with kai.heng's
review.
I will rebuild a new kernel and test it again, and reply later, sorry about
that.



On Thu, Dec 7, 2023 at 2:58=E2=80=AFPM Kai-Heng Feng <kai.heng.feng@canonic=
al.com>
wrote:

> On Thu, Dec 7, 2023 at 10:10=E2=80=AFAM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > On 12/6/2023 20:07, Kai-Heng Feng wrote:
> > > On Thu, Dec 7, 2023 at 9:57=E2=80=AFAM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> > >>
> > >> On 12/6/2023 19:23, Kai-Heng Feng wrote:
> > >>> On Wed, Dec 6, 2023 at 4:29=E2=80=AFAM Mario Limonciello
> > >>> <mario.limonciello@amd.com> wrote:
> > >>>>
> > >>>> On 12/5/2023 14:17, Hamza Mahfooz wrote:
> > >>>>> We currently don't support dirty rectangles on hardware rotated
> modes.
> > >>>>> So, if a user is using hardware rotated modes with PSR-SU enabled=
,
> > >>>>> use PSR-SU FFU for all rotated planes (including cursor planes).
> > >>>>>
> > >>>>
> > >>>> Here is the email for the original reporter to give an attribution
> tag.
> > >>>>
> > >>>> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > >>>
> > >>> For this particular issue,
> > >>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > >>
> > >> Can you confirm what kernel base you tested issue against?
> > >>
> > >> I ask because Bin Li (+CC) also tested it against 6.1 based LTS kern=
el
> > >> but ran into problems.
> > >
> > > The patch was tested against ADSN.
> > >
> > >>
> > >> I wonder if it's because of other dependency patches.  If that's the
> > >> case it would be good to call them out in the Cc: @stable as
> > >> dependencies so when Greg or Sasha backport this 6.1 doesn't get
> broken.
> > >
> > > Probably. I haven't really tested any older kernel series.
> >
> > Since you've got a good environment to test it and reproduce it would
> > you mind double checking it against 6.7-rc, 6.5 and 6.1 trees?  If we
> > don't have confidence it works on the older trees I think we'll need to
> > drop the stable tag.
>
> Not seeing issues here when the patch is applied against 6.5 and 6.1
> (which needs to resolve a minor conflict).
>
> I am not sure what happened for Bin's case.
>
> Kai-Heng
>
> > >
> > > Kai-Heng
> > >
> > >>
> > >> Bin,
> > >>
> > >> Could you run ./scripts/decode_stacktrace.sh on your kernel trace to
> > >> give us a specific line number on the issue you hit?
> > >>
> > >> Thanks!
> > >>>
> > >>>>
> > >>>>> Cc: stable@vger.kernel.org
> > >>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
> > >>>>> Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS
> support")
> > >>>>> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> > >>>>> ---
> > >>>>>     drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 +++=
+
> > >>>>>     drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
> > >>>>>     drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12
> ++++++++++--
> > >>>>>     .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++-
> > >>>>>     4 files changed, 17 insertions(+), 3 deletions(-)
> > >>>>>
> > >>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > >>>>> index c146dc9cba92..79f8102d2601 100644
> > >>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > >>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > >>>>> @@ -5208,6 +5208,7 @@ static void fill_dc_dirty_rects(struct
> drm_plane *plane,
> > >>>>>         bool bb_changed;
> > >>>>>         bool fb_changed;
> > >>>>>         u32 i =3D 0;
> > >>>>> +
> > >>>>
> > >>>> Looks like a spurious newline here.
> > >>>>
> > >>>>>         *dirty_regions_changed =3D false;
> > >>>>>
> > >>>>>         /*
> > >>>>> @@ -5217,6 +5218,9 @@ static void fill_dc_dirty_rects(struct
> drm_plane *plane,
> > >>>>>         if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
> > >>>>>                 return;
> > >>>>>
> > >>>>> +     if (new_plane_state->rotation !=3D DRM_MODE_ROTATE_0)
> > >>>>> +             goto ffu;
> > >>>>> +
> > >>>>
> > >>>> I noticed that the original report was specifically on 180=C2=B0. =
 Since
> > >>>> you're also covering 90=C2=B0 and 270=C2=B0 with this check it sou=
nds like
> it's
> > >>>> actually problematic on those too?
> > >>>
> > >>> 90 & 270 are problematic too. But from what I observed the issue is
> > >>> much more than just cursors.
> > >>
> > >> Got it; thanks.
> > >>
> > >>>
> > >>> Kai-Heng
> > >>>
> > >>>>
> > >>>>>         num_clips =3D
> drm_plane_get_damage_clips_count(new_plane_state);
> > >>>>>         clips =3D drm_plane_get_damage_clips(new_plane_state);
> > >>>>>
> > >>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> > >>>>> index 9649934ea186..e2a3aa8812df 100644
> > >>>>> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> > >>>>> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> > >>>>> @@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
> > >>>>>         struct fixed31_32 v_scale_ratio;
> > >>>>>         enum dc_rotation_angle rotation;
> > >>>>>         bool mirror;
> > >>>>> +     struct dc_stream_state *stream;
> > >>>>>     };
> > >>>>>
> > >>>>>     /* IPP related types */
> > >>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> > >>>>> index 139cf31d2e45..89c3bf0fe0c9 100644
> > >>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> > >>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> > >>>>> @@ -1077,8 +1077,16 @@ void hubp2_cursor_set_position(
> > >>>>>         if (src_y_offset < 0)
> > >>>>>                 src_y_offset =3D 0;
> > >>>>>         /* Save necessary cursor info x, y position. w, h is save=
d
> in attribute func. */
> > >>>>> -     hubp->cur_rect.x =3D src_x_offset + param->viewport.x;
> > >>>>> -     hubp->cur_rect.y =3D src_y_offset + param->viewport.y;
> > >>>>> +     if (param->stream->link->psr_settings.psr_version >=3D
> DC_PSR_VERSION_SU_1 &&
> > >>>>> +         param->rotation !=3D ROTATION_ANGLE_0) {
> > >>>>
> > >>>> Ditto on above about 90=C2=B0 and 270=C2=B0.
> > >>>>
> > >>>>> +             hubp->cur_rect.x =3D 0;
> > >>>>> +             hubp->cur_rect.y =3D 0;
> > >>>>> +             hubp->cur_rect.w =3D
> param->stream->timing.h_addressable;
> > >>>>> +             hubp->cur_rect.h =3D
> param->stream->timing.v_addressable;
> > >>>>> +     } else {
> > >>>>> +             hubp->cur_rect.x =3D src_x_offset + param->viewport=
.x;
> > >>>>> +             hubp->cur_rect.y =3D src_y_offset + param->viewport=
.y;
> > >>>>> +     }
> > >>>>>     }
> > >>>>>
> > >>>>>     void hubp2_clk_cntl(struct hubp *hubp, bool enable)
> > >>>>> diff --git
> a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> > >>>>> index 2b8b8366538e..ce5613a76267 100644
> > >>>>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> > >>>>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> > >>>>> @@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct
> pipe_ctx *pipe_ctx)
> > >>>>>                 .h_scale_ratio =3D
> pipe_ctx->plane_res.scl_data.ratios.horz,
> > >>>>>                 .v_scale_ratio =3D
> pipe_ctx->plane_res.scl_data.ratios.vert,
> > >>>>>                 .rotation =3D pipe_ctx->plane_state->rotation,
> > >>>>> -             .mirror =3D pipe_ctx->plane_state->horizontal_mirro=
r
> > >>>>> +             .mirror =3D pipe_ctx->plane_state->horizontal_mirro=
r,
> > >>>>> +             .stream =3D pipe_ctx->stream
> > >>>>
> > >>>> As a nit; I think it's worth leaving a harmless trailing ',' so th=
at
> > >>>> there is less ping pong in the future when adding new members to a
> struct.
> > >>>>
> > >>>>>         };
> > >>>>>         bool pipe_split_on =3D false;
> > >>>>>         bool odm_combine_on =3D (pipe_ctx->next_odm_pipe !=3D NUL=
L) ||
> > >>>>
> > >>>>
> > >>
> >
>

--000000000000ec8439060be6aea2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mario,<div><br></div><div>I found I missed the part in=
=C2=A0drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c with kai.heng=
&#39;s review.</div><div>I will rebuild=C2=A0a new kernel and test it again=
, and reply later, sorry about that.</div><div><br><div><div dir=3D"ltr" cl=
ass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"=
><div dir=3D"ltr"><br></div></div></div></div></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 7, 2023 at =
2:58=E2=80=AFPM Kai-Heng Feng &lt;<a href=3D"mailto:kai.heng.feng@canonical=
.com">kai.heng.feng@canonical.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Thu, Dec 7, 2023 at 10:10=E2=80=AFAM Ma=
rio Limonciello<br>
&lt;<a href=3D"mailto:mario.limonciello@amd.com" target=3D"_blank">mario.li=
monciello@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On 12/6/2023 20:07, Kai-Heng Feng wrote:<br>
&gt; &gt; On Thu, Dec 7, 2023 at 9:57=E2=80=AFAM Mario Limonciello<br>
&gt; &gt; &lt;<a href=3D"mailto:mario.limonciello@amd.com" target=3D"_blank=
">mario.limonciello@amd.com</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 12/6/2023 19:23, Kai-Heng Feng wrote:<br>
&gt; &gt;&gt;&gt; On Wed, Dec 6, 2023 at 4:29=E2=80=AFAM Mario Limonciello<=
br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:mario.limonciello@amd.com" target=
=3D"_blank">mario.limonciello@amd.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On 12/5/2023 14:17, Hamza Mahfooz wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt; We currently don&#39;t support dirty rectangles o=
n hardware rotated modes.<br>
&gt; &gt;&gt;&gt;&gt;&gt; So, if a user is using hardware rotated modes wit=
h PSR-SU enabled,<br>
&gt; &gt;&gt;&gt;&gt;&gt; use PSR-SU FFU for all rotated planes (including =
cursor planes).<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Here is the email for the original reporter to give a=
n attribution tag.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Reported-by: Kai-Heng Feng &lt;<a href=3D"mailto:kai.=
heng.feng@canonical.com" target=3D"_blank">kai.heng.feng@canonical.com</a>&=
gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; For this particular issue,<br>
&gt; &gt;&gt;&gt; Tested-by: Kai-Heng Feng &lt;<a href=3D"mailto:kai.heng.f=
eng@canonical.com" target=3D"_blank">kai.heng.feng@canonical.com</a>&gt;<br=
>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Can you confirm what kernel base you tested issue against?<br=
>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I ask because Bin Li (+CC) also tested it against 6.1 based L=
TS kernel<br>
&gt; &gt;&gt; but ran into problems.<br>
&gt; &gt;<br>
&gt; &gt; The patch was tested against ADSN.<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I wonder if it&#39;s because of other dependency patches.=C2=
=A0 If that&#39;s the<br>
&gt; &gt;&gt; case it would be good to call them out in the Cc: @stable as<=
br>
&gt; &gt;&gt; dependencies so when Greg or Sasha backport this 6.1 doesn&#3=
9;t get broken.<br>
&gt; &gt;<br>
&gt; &gt; Probably. I haven&#39;t really tested any older kernel series.<br=
>
&gt;<br>
&gt; Since you&#39;ve got a good environment to test it and reproduce it wo=
uld<br>
&gt; you mind double checking it against 6.7-rc, 6.5 and 6.1 trees?=C2=A0 I=
f we<br>
&gt; don&#39;t have confidence it works on the older trees I think we&#39;l=
l need to<br>
&gt; drop the stable tag.<br>
<br>
Not seeing issues here when the patch is applied against 6.5 and 6.1<br>
(which needs to resolve a minor conflict).<br>
<br>
I am not sure what happened for Bin&#39;s case.<br>
<br>
Kai-Heng<br>
<br>
&gt; &gt;<br>
&gt; &gt; Kai-Heng<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Bin,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Could you run ./scripts/decode_stacktrace.sh on your kernel t=
race to<br>
&gt; &gt;&gt; give us a specific line number on the issue you hit?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks!<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Cc: <a href=3D"mailto:stable@vger.kernel.org" tar=
get=3D"_blank">stable@vger.kernel.org</a><br>
&gt; &gt;&gt;&gt;&gt;&gt; Link: <a href=3D"https://gitlab.freedesktop.org/d=
rm/amd/-/issues/2952" rel=3D"noreferrer" target=3D"_blank">https://gitlab.f=
reedesktop.org/drm/amd/-/issues/2952</a><br>
&gt; &gt;&gt;&gt;&gt;&gt; Fixes: 30ebe41582d1 (&quot;drm/amd/display: add F=
B_DAMAGE_CLIPS support&quot;)<br>
&gt; &gt;&gt;&gt;&gt;&gt; Signed-off-by: Hamza Mahfooz &lt;<a href=3D"mailt=
o:hamza.mahfooz@amd.com" target=3D"_blank">hamza.mahfooz@amd.com</a>&gt;<br=
>
&gt; &gt;&gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0drivers/gpu/drm/amd/display/am=
dgpu_dm/amdgpu_dm.c=C2=A0 =C2=A0 |=C2=A0 4 ++++<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0drivers/gpu/drm/amd/display/dc=
/dc_hw_types.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0drivers/gpu/drm/amd/display/dc=
/dcn20/dcn20_hubp.c=C2=A0 =C2=A0 | 12 ++++++++++--<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0.../gpu/drm/amd/display/dc/hws=
s/dcn10/dcn10_hwseq.c=C2=A0 |=C2=A0 3 ++-<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A04 files changed, 17 insertions=
(+), 3 deletions(-)<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_d=
m/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; index c146dc9cba92..79f8102d2601 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgp=
u_dm.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgp=
u_dm.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; @@ -5208,6 +5208,7 @@ static void fill_dc_dirty_r=
ects(struct drm_plane *plane,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool bb_changed;=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool fb_changed;=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 i =3D 0;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Looks like a spurious newline here.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*dirty_regions_c=
hanged =3D false;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt;&gt;&gt;&gt;&gt; @@ -5217,6 +5218,9 @@ static void fill_dc_dirty_r=
ects(struct drm_plane *plane,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (plane-&gt;ty=
pe =3D=3D DRM_PLANE_TYPE_CURSOR)<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (new_plane_state-&gt;rota=
tion !=3D DRM_MODE_ROTATE_0)<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
goto ffu;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; I noticed that the original report was specifically o=
n 180=C2=B0.=C2=A0 Since<br>
&gt; &gt;&gt;&gt;&gt; you&#39;re also covering 90=C2=B0 and 270=C2=B0 with =
this check it sounds like it&#39;s<br>
&gt; &gt;&gt;&gt;&gt; actually problematic on those too?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; 90 &amp; 270 are problematic too. But from what I observe=
d the issue is<br>
&gt; &gt;&gt;&gt; much more than just cursors.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Got it; thanks.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Kai-Heng<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0num_clips =3D dr=
m_plane_get_damage_clips_count(new_plane_state);<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clips =3D drm_pl=
ane_get_damage_clips(new_plane_state);<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw=
_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h<br>
&gt; &gt;&gt;&gt;&gt;&gt; index 9649934ea186..e2a3aa8812df 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.=
h<br>
&gt; &gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.=
h<br>
&gt; &gt;&gt;&gt;&gt;&gt; @@ -465,6 +465,7 @@ struct dc_cursor_mi_param {<b=
r>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct fixed31_3=
2 v_scale_ratio;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum dc_rotation=
_angle rotation;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool mirror;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct dc_stream_state *stre=
am;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0/* IPP related types */<br>
&gt; &gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn20=
/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; index 139cf31d2e45..89c3bf0fe0c9 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_=
hubp.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_=
hubp.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; @@ -1077,8 +1077,16 @@ void hubp2_cursor_set_posi=
tion(<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (src_y_offset=
 &lt; 0)<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0src_y_offset =3D 0;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Save necessar=
y cursor info x, y position. w, h is saved in attribute func. */<br>
&gt; &gt;&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0hubp-&gt;cur_rect.x =3D src_=
x_offset + param-&gt;viewport.x;<br>
&gt; &gt;&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0hubp-&gt;cur_rect.y =3D src_=
y_offset + param-&gt;viewport.y;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (param-&gt;stream-&gt;lin=
k-&gt;psr_settings.psr_version &gt;=3D DC_PSR_VERSION_SU_1 &amp;&amp;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0param-&gt;rota=
tion !=3D ROTATION_ANGLE_0) {<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Ditto on above about 90=C2=B0 and 270=C2=B0.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
hubp-&gt;cur_rect.x =3D 0;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
hubp-&gt;cur_rect.y =3D 0;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
hubp-&gt;cur_rect.w =3D param-&gt;stream-&gt;timing.h_addressable;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
hubp-&gt;cur_rect.h =3D param-&gt;stream-&gt;timing.v_addressable;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
hubp-&gt;cur_rect.x =3D src_x_offset + param-&gt;viewport.x;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
hubp-&gt;cur_rect.y =3D src_y_offset + param-&gt;viewport.y;<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0void hubp2_clk_cntl(struct hub=
p *hubp, bool enable)<br>
&gt; &gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/dc/hwss/=
dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq=
.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; index 2b8b8366538e..ce5613a76267 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/d=
cn10_hwseq.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/d=
cn10_hwseq.c<br>
&gt; &gt;&gt;&gt;&gt;&gt; @@ -3417,7 +3417,8 @@ void dcn10_set_cursor_posit=
ion(struct pipe_ctx *pipe_ctx)<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.h_scale_ratio =3D pipe_ctx-&gt;plane_res.scl_data.ratios.horz=
,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.v_scale_ratio =3D pipe_ctx-&gt;plane_res.scl_data.ratios.vert=
,<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.rotation =3D pipe_ctx-&gt;plane_state-&gt;rotation,<br>
&gt; &gt;&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
.mirror =3D pipe_ctx-&gt;plane_state-&gt;horizontal_mirror<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
.mirror =3D pipe_ctx-&gt;plane_state-&gt;horizontal_mirror,<br>
&gt; &gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
.stream =3D pipe_ctx-&gt;stream<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; As a nit; I think it&#39;s worth leaving a harmless t=
railing &#39;,&#39; so that<br>
&gt; &gt;&gt;&gt;&gt; there is less ping pong in the future when adding new=
 members to a struct.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool pipe_split_=
on =3D false;<br>
&gt; &gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool odm_combine=
_on =3D (pipe_ctx-&gt;next_odm_pipe !=3D NULL) ||<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt;<br>
</blockquote></div>

--000000000000ec8439060be6aea2--
