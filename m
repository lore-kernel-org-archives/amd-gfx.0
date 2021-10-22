Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D72BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 13:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE76360C51
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 13:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE76360C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E4E6ED9D;
	Fri, 22 Oct 2021 13:58:21 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0B46ED9D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 13:58:20 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 w12-20020a056830410c00b0054e7ceecd88so4502570ott.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MQajGaTlnz6Ak4LNmf7ZzswaIG93Nnebc70u9QBRgJg=;
 b=o1GWTywtrLeY0raL9wZHLSjjEDAHIpIqshmnpS2FSI+0zeRGIz+OhtIlk0gv1gJ7bt
 4dc7sYSdZHuR+pIljXq3E7VtbVGwhwH6NEq7Ew8zOayiNVxlaelZyXC+tgF/NJtPYa68
 tv4JyMumQt+siRnrDA+LHVGqELCChc0n1MEENNPjdafbV9gXWlCl8m0BBcMybvzas5N8
 31tY0aJMYaELfXxhiE6IjxRSHXD7xxqTqe2bGgTf8Eag/RATL/8mv/hdqht/nsDBEh/j
 RgBe9/zQA52lfCEltFJaafiRtNG8/4P7wLKOkWiVZ9Ya9BqOjiFSpC0du9rNpT/iwNfR
 zaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MQajGaTlnz6Ak4LNmf7ZzswaIG93Nnebc70u9QBRgJg=;
 b=aB+dXhsuBY7blFlRxBND9nHFxXqz/X0DOzNwGg/6xfg+p8N3vYqOlZb491JAshSjGW
 zx/DgKT/esvjGElwSh6OheL+sps5QewvyG761S5dalvv+Cr4OyFa3DOgH3h/J7ER68JQ
 tAxIE4YWFLlfhg6jBDlV8NUqFzrsI9SoprUvIHSOAqzX7GdhBXuNORjftYCPMM99o/On
 R+Ia2QntZiC4sezgOVFGITyh6T6v5dcIVO8rG5ehOOukDuylcwM7KRaAPCvuEzj/hqtd
 4ZMyxoYTGVqqdTjKqgBxsPNT/s/x4UKTe0ZXCG+ecY2xCjotSzDP7yHDVa7U6yrHgJLi
 4naA==
X-Gm-Message-State: AOAM533n2glfXkGFY0LgWETFHGVlxUE6r6J76hyASF8uW5pFdTdiF11z
 7ZepF6m8k4/QapAq0qCaFlmEdeRYvLiS8MKnlf3khR3yWfY=
X-Google-Smtp-Source: ABdhPJySHeepbxbw87HdQlvillbPuMXa4+7Ly6Cu9MV0uPMRiGDSb4rbvx5AfllVmAIcZ+Xzjffqsp/Snxsrn8lvtb8=
X-Received: by 2002:a9d:1b4f:: with SMTP id l73mr46917otl.200.1634911099427;
 Fri, 22 Oct 2021 06:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211014153433.169454-1-contact@emersion.fr>
 <f6993cb2-53e0-b4c8-48f2-c5bf4eaaf511@amd.com>
 <25eb363b-e97f-0762-f39a-a8a459ba019f@amd.com>
In-Reply-To: <25eb363b-e97f-0762-f39a-a8a459ba019f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Oct 2021 09:58:08 -0400
Message-ID: <CADnq5_NBpCm8fpueH2LF+Tepm9i33bp_nf-BbLo2pGXqkP3QiA@mail.gmail.com>
Subject: Re: [PATCH] amd/display: remove ChromeOS workaround
To: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira Jordao <rjordrigo@amd.com>,
 Simon Ser <contact@emersion.fr>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Harry Wentland <hwentlan@amd.com>,
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@chromium.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 21, 2021 at 2:19 PM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
>
>
> On 2021-10-21 13:55, Rodrigo Siqueira Jordao wrote:
> > Hi Simon,
> >
> > I tested this patch and it lgtm. I also agree to revert it.
> >
> > Btw, did you send the revert patch for "amd/display: only require overl=
ay plane to cover whole CRTC on ChromeOS"? I think we need to revert it as =
well.
> >
>
> Agreed that this patch is good but we'll need to also revert the is_chrom=
eos w/a.

I've reverted that and applied this one.  Thanks!

Alex

>
> This patch is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > Sean, Mark
> >
> > For ChromeOS, we should ignore this patch. Do we need to take any actio=
n to avoid landing this patch on ChromeOS tree?
> >
> > Thanks
> > Siqueira
> >
> > On 2021-10-14 11:35 a.m., Simon Ser wrote:
> >> This reverts commits ddab8bd788f5 ("drm/amd/display: Fix two cursor du=
plication
> >> when using overlay") and e7d9560aeae5 ("Revert "drm/amd/display: Fix o=
verlay
> >> validation by considering cursors"").
> >>
> >> tl;dr ChromeOS uses the atomic interface for everything except the cur=
sor. This
> >> is incorrect and forces amdgpu to disable some hardware features. Let'=
s revert
> >> the ChromeOS-specific workaround in mainline and allow the Chrome team=
 to keep
> >> it internally in their own tree.
> >>
> >> See [1] for more details. This patch is an alternative to [2], which a=
dded
> >> ChromeOS detection.
> >>
> >> [1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxu=
cx8hQArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=
=3D@emersion.fr/>> [2]: https://lore.kernel.org/amd-gfx/20211011151609.4521=
32-1-contact@emersion.fr/>> Signed-off-by: Simon Ser <contact@emersion.fr>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: Harry Wentland <hwentlan@amd.com>
> >> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> >> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> >> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >> Cc: Sean Paul <seanpaul@chromium.org>
> >> Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when=
 using overlay")
> >> Fixes: e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay validation =
by considering cursors"")
> >> ---
> >>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 -----------------=
--
> >>   1 file changed, 51 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 20065a145851..014c5a9fe461 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -10628,53 +10628,6 @@ static int add_affected_mst_dsc_crtcs(struct =
drm_atomic_state *state, struct drm
> >>   }
> >>   #endif
> >>   -static int validate_overlay(struct drm_atomic_state *state)
> >> -{
> >> -    int i;
> >> -    struct drm_plane *plane;
> >> -    struct drm_plane_state *new_plane_state;
> >> -    struct drm_plane_state *primary_state, *overlay_state =3D NULL;
> >> -
> >> -    /* Check if primary plane is contained inside overlay */
> >> -    for_each_new_plane_in_state_reverse(state, plane, new_plane_state=
, i) {
> >> -        if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) {
> >> -            if (drm_atomic_plane_disabling(plane->state, new_plane_st=
ate))
> >> -                return 0;
> >> -
> >> -            overlay_state =3D new_plane_state;
> >> -            continue;
> >> -        }
> >> -    }
> >> -
> >> -    /* check if we're making changes to the overlay plane */
> >> -    if (!overlay_state)
> >> -        return 0;
> >> -
> >> -    /* check if overlay plane is enabled */
> >> -    if (!overlay_state->crtc)
> >> -        return 0;
> >> -
> >> -    /* find the primary plane for the CRTC that the overlay is enable=
d on */
> >> -    primary_state =3D drm_atomic_get_plane_state(state, overlay_state=
->crtc->primary);
> >> -    if (IS_ERR(primary_state))
> >> -        return PTR_ERR(primary_state);
> >> -
> >> -    /* check if primary plane is enabled */
> >> -    if (!primary_state->crtc)
> >> -        return 0;
> >> -
> >> -    /* Perform the bounds check to ensure the overlay plane covers th=
e primary */
> >> -    if (primary_state->crtc_x < overlay_state->crtc_x ||
> >> -        primary_state->crtc_y < overlay_state->crtc_y ||
> >> -        primary_state->crtc_x + primary_state->crtc_w > overlay_state=
->crtc_x + overlay_state->crtc_w ||
> >> -        primary_state->crtc_y + primary_state->crtc_h > overlay_state=
->crtc_y + overlay_state->crtc_h) {
> >> -        DRM_DEBUG_ATOMIC("Overlay plane is enabled with hardware curs=
or but does not fully cover primary plane\n");
> >> -        return -EINVAL;
> >> -    }
> >> -
> >> -    return 0;
> >> -}
> >> -
> >>   /**
> >>    * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu=
 DM.
> >>    * @dev: The DRM device
> >> @@ -10856,10 +10809,6 @@ static int amdgpu_dm_atomic_check(struct drm_=
device *dev,
> >>               goto fail;
> >>       }
> >>   -    ret =3D validate_overlay(state);
> >> -    if (ret)
> >> -        goto fail;
> >> -
> >>       /* Add new/modified planes */
> >>       for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_s=
tate, new_plane_state, i) {
> >>           ret =3D dm_update_plane_state(dc, state, plane,
> >>
> >
>
