Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54D3C10F05
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 14:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE6510E8BB;
	Thu,  7 Dec 2023 14:59:32 +0000 (UTC)
X-Greylist: delayed 387 seconds by postgrey-1.36 at gabe;
 Thu, 07 Dec 2023 01:30:10 UTC
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F3610E7CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 01:30:10 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CBF483FAE7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 01:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1701912220;
 bh=emHLT4gqLmIch4z9XMPrHibuwF4mE/rTFPk45mjbu8s=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=Egy47TRQ7SdX+tker6q9JCMasWQOWTbIzGkbAOe8oBcBdm6egFcNHYxu4koLxY0So
 FF6pgFlYbYZ7kzYrolaeBFDZjYZ+5RDn+m5ZbHvMOoFeqh3WB1BwvzfOQptqs7GTij
 RB6OTmVtX/5aCJSRTpb3PB4TIXplK9VNmuCg6Qewv8aBy5Q8N2HpvzC4kzMOeka9jV
 6Xq7Id5hRZzsvcfAbIhoaz8BzaGNX6j4GhUPdutkkK7MjNWkpyzt+tkt5mZHfoqOmV
 1WIJ32qOyRABa0IO0n7pSyanAuo6/uCxO+14vqMQNEEgSmD2WEJzsg79jRs4ij287X
 8s6zRdJdImDiw==
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-286da86884aso439030a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Dec 2023 17:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701912219; x=1702517019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emHLT4gqLmIch4z9XMPrHibuwF4mE/rTFPk45mjbu8s=;
 b=Rf+m7e/OsyaH6k8NxPlRQQcTM+nyaFd8taGD6w8l7fSM4RKNZrsEQS0ujgBbdJBwSj
 dcirg60kjewKVVFz8g05Tw1J0F8RfVegIHwMBqRt2N1+0irWPFSxyJ1amXxHL7Gk2d+v
 xrWoDZATxS1rzX0P39+5Wg/YlvEqozmM5irRBp1la4Yxjf3Ss+Y6sXmRtO/HYyl4Z8hU
 umS+E6UE1y6Qvpjb0EczP+NBkXgrI4BL50LHvbDzKJDE5QwrNea+c5WXAeEUpuL2tE4m
 pzE++EqpwssdZQdnnqEJic8Oo8QydnjnBFzN5DnFCBKQY04wgNO3DxQWPaE/sOsjpcHX
 xkJw==
X-Gm-Message-State: AOJu0Yz0sjuP3RVpG/XeMPRuqskM0LOgwKiIAfatAkB5KyoEN+Oxk1Ee
 PhETgR6Da3CtTDEgUy9Xhsjbf9XmLTb6eqqW0XU0nJREuo6vpVv4AVYusYctc2GAel0O6mkMaD/
 5YTM4alJGQsW5k6YaweuL8qAz5fvR1aImNZfkT4Sb/9+wed9SAT30AJKgdbs=
X-Received: by 2002:a17:90b:1a8d:b0:286:8d69:9d0 with SMTP id
 ng13-20020a17090b1a8d00b002868d6909d0mr1820616pjb.50.1701912219385; 
 Wed, 06 Dec 2023 17:23:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnx2t9z6ysDSDhto5DtiCntsKxH31WUjCWDHYq6T4wIHIahD+SJzbtGueDZZ6nVxFCeG+GLfOz/t1CvwQ8g+o=
X-Received: by 2002:a17:90b:1a8d:b0:286:8d69:9d0 with SMTP id
 ng13-20020a17090b1a8d00b002868d6909d0mr1820609pjb.50.1701912219036; Wed, 06
 Dec 2023 17:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20231205201749.213912-1-hamza.mahfooz@amd.com>
 <b369f492-a88b-460c-b614-51beb2dc2262@amd.com>
In-Reply-To: <b369f492-a88b-460c-b614-51beb2dc2262@amd.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 7 Dec 2023 09:23:27 +0800
Message-ID: <CAAd53p63BKUSyRd5GOuonN4yhOwt3d43mVUKY3WfGSUwSymKhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix hw rotated modes when PSR-SU is
 enabled
To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Leo Li <sunpeng.li@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Taimur Hassan <syed.hassan@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 6, 2023 at 4:29=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/5/2023 14:17, Hamza Mahfooz wrote:
> > We currently don't support dirty rectangles on hardware rotated modes.
> > So, if a user is using hardware rotated modes with PSR-SU enabled,
> > use PSR-SU FFU for all rotated planes (including cursor planes).
> >
>
> Here is the email for the original reporter to give an attribution tag.
>
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

For this particular issue,
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

>
> > Cc: stable@vger.kernel.org
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2952
> > Fixes: 30ebe41582d1 ("drm/amd/display: add FB_DAMAGE_CLIPS support")
> > Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  4 ++++
> >   drivers/gpu/drm/amd/display/dc/dc_hw_types.h         |  1 +
> >   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c    | 12 ++++++++++-=
-
> >   .../gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c  |  3 ++-
> >   4 files changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index c146dc9cba92..79f8102d2601 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -5208,6 +5208,7 @@ static void fill_dc_dirty_rects(struct drm_plane =
*plane,
> >       bool bb_changed;
> >       bool fb_changed;
> >       u32 i =3D 0;
> > +
>
> Looks like a spurious newline here.
>
> >       *dirty_regions_changed =3D false;
> >
> >       /*
> > @@ -5217,6 +5218,9 @@ static void fill_dc_dirty_rects(struct drm_plane =
*plane,
> >       if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
> >               return;
> >
> > +     if (new_plane_state->rotation !=3D DRM_MODE_ROTATE_0)
> > +             goto ffu;
> > +
>
> I noticed that the original report was specifically on 180=C2=B0.  Since
> you're also covering 90=C2=B0 and 270=C2=B0 with this check it sounds lik=
e it's
> actually problematic on those too?

90 & 270 are problematic too. But from what I observed the issue is
much more than just cursors.

Kai-Heng

>
> >       num_clips =3D drm_plane_get_damage_clips_count(new_plane_state);
> >       clips =3D drm_plane_get_damage_clips(new_plane_state);
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu=
/drm/amd/display/dc/dc_hw_types.h
> > index 9649934ea186..e2a3aa8812df 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> > @@ -465,6 +465,7 @@ struct dc_cursor_mi_param {
> >       struct fixed31_32 v_scale_ratio;
> >       enum dc_rotation_angle rotation;
> >       bool mirror;
> > +     struct dc_stream_state *stream;
> >   };
> >
> >   /* IPP related types */
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> > index 139cf31d2e45..89c3bf0fe0c9 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> > @@ -1077,8 +1077,16 @@ void hubp2_cursor_set_position(
> >       if (src_y_offset < 0)
> >               src_y_offset =3D 0;
> >       /* Save necessary cursor info x, y position. w, h is saved in att=
ribute func. */
> > -     hubp->cur_rect.x =3D src_x_offset + param->viewport.x;
> > -     hubp->cur_rect.y =3D src_y_offset + param->viewport.y;
> > +     if (param->stream->link->psr_settings.psr_version >=3D DC_PSR_VER=
SION_SU_1 &&
> > +         param->rotation !=3D ROTATION_ANGLE_0) {
>
> Ditto on above about 90=C2=B0 and 270=C2=B0.
>
> > +             hubp->cur_rect.x =3D 0;
> > +             hubp->cur_rect.y =3D 0;
> > +             hubp->cur_rect.w =3D param->stream->timing.h_addressable;
> > +             hubp->cur_rect.h =3D param->stream->timing.v_addressable;
> > +     } else {
> > +             hubp->cur_rect.x =3D src_x_offset + param->viewport.x;
> > +             hubp->cur_rect.y =3D src_y_offset + param->viewport.y;
> > +     }
> >   }
> >
> >   void hubp2_clk_cntl(struct hubp *hubp, bool enable)
> > diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> > index 2b8b8366538e..ce5613a76267 100644
> > --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> > +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> > @@ -3417,7 +3417,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *p=
ipe_ctx)
> >               .h_scale_ratio =3D pipe_ctx->plane_res.scl_data.ratios.ho=
rz,
> >               .v_scale_ratio =3D pipe_ctx->plane_res.scl_data.ratios.ve=
rt,
> >               .rotation =3D pipe_ctx->plane_state->rotation,
> > -             .mirror =3D pipe_ctx->plane_state->horizontal_mirror
> > +             .mirror =3D pipe_ctx->plane_state->horizontal_mirror,
> > +             .stream =3D pipe_ctx->stream
>
> As a nit; I think it's worth leaving a harmless trailing ',' so that
> there is less ping pong in the future when adding new members to a struct=
.
>
> >       };
> >       bool pipe_split_on =3D false;
> >       bool odm_combine_on =3D (pipe_ctx->next_odm_pipe !=3D NULL) ||
>
>
