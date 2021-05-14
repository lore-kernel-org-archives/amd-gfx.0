Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB73C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 17:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9F76144A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 17:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9F76144A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFF396F3A9;
	Fri, 14 May 2021 17:18:04 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394C96F393
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 16:31:24 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 b13-20020a17090a8c8db029015cd97baea9so1594739pjo.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zvYpeVJ9ALSF9lAQomHE0WF16TiUwXel5DaNykJfSbI=;
 b=mssQmcuKJqfE9Ooq4PUolqb5I4qzaeOH5C7ee3YjfI9YNhUsxv66rqo38qBrzDT8v7
 Y2jS/gMTPoFfPiaN9Nw/bMGr8b81Jv3VN002AwYHKoezTskK4wZBpV2PORCEg/nzPkre
 FyY4YwRqdpY3q+t5mZ6tsYbooK8uqEBp7poOjk/yP8b4JyWvJtqN9s952QaPUL5WZHxR
 pb11KAXI9L6EADlhDswCWtYofQDJEuwmpvN6OE7BVve/OaC5bn/NSJHKvV2yB1GlxFGX
 FsOOSEBx4vB9hZhAI2HpsHfCwVlhjCt5U+4agP5QCTD8xe3Om8O7uepEQHvTQr2wzepX
 aF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zvYpeVJ9ALSF9lAQomHE0WF16TiUwXel5DaNykJfSbI=;
 b=bUqvXKhQsRz0VQ92dS5rP08k1PNiAO/VxnOscWXIFI29zhFsbwRzz9HFkdggOTjfxt
 4uw+MwticDfDG/E+0mPNUnYelOpg3vOvqMJXhHuRAeuI+TR5gQim+b+cOtHzTuVLgLkL
 kTFxz5MvfhD3oL91on03qHScmxI5L4BiSpb5JO71G/OIO5gD53UEJcpCtS5TjUy0mgKa
 gZr51u/1RHoxkRXJF/HhWqKAQNVG00HUT6JtO/g7utESQURLP+kOaVdstRnHC5JLvpBY
 GXUwzv5uco1ntzZEVxlzTgQjSD8ptfXMZ9ZI573RBETJJJt1dxmDAgOJzoVOuxo94S8a
 9xzA==
X-Gm-Message-State: AOAM532yNSJK4s8Oo1hswswtw3xGLwsMATQYWm0Mub8MDWuPljgG9/wY
 VugjKel1EXuc3fjO7QctHCWedhP6Qm23NTGyFVHxBw==
X-Google-Smtp-Source: ABdhPJwsOvpfuFb4d0xfzOaE1/DSZYe5nXYdhBk9XWpEiGPY25QAI+dgJP/6Gi+Ejt10Jw2jfkuP5BOL2V5r8NKYanE=
X-Received: by 2002:a17:90a:f996:: with SMTP id
 cq22mr3460474pjb.96.1621009883528; 
 Fri, 14 May 2021 09:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
 <857025a9-2ac0-ed37-bc9e-a2be9e1780a9@amd.com>
In-Reply-To: <857025a9-2ac0-ed37-bc9e-a2be9e1780a9@amd.com>
From: Mark Yacoub <markyacoub@google.com>
Date: Fri, 14 May 2021 12:31:12 -0400
Message-ID: <CAC0gqY77ztqBfi3g_JYPVEqmahXVJ+bGePMK40WaPmgm4m6gVw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix overlay validation by considering
 cursors
To: Mark Yacoub <markyacoub@chromium.org>
X-Mailman-Approved-At: Fri, 14 May 2021 17:18:02 +0000
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 "Tianci . Yin" <tianci.yin@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Nicholas Choi <nicholas.choi@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 14, 2021 at 11:28 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-05-14 7:47 a.m., Rodrigo Siqueira wrote:
> > A few weeks ago, we saw a two cursor issue in a ChromeOS system. We
> > fixed it in the commit:
> >
> >  drm/amd/display: Fix two cursor duplication when using overlay
> >  (read the commit message for more details)
> >
> > After this change, we noticed that some IGT subtests related to
> > kms_plane and kms_plane_scaling started to fail. After investigating
> > this issue, we noticed that all subtests that fail have a primary plane
> > covering the overlay plane, which is currently rejected by amdgpu dm.
> > Fail those IGT tests highlight that our verification was too broad and
> > compromises the overlay usage in our drive. This patch fixes this issue
> > by ensuring that we only reject commits where the primary plane is not
> > fully covered by the overlay when the cursor hardware is enabled. With
> > this fix, all IGT tests start to pass again, which means our overlay
> > support works as expected.
> >
> > Cc: Tianci.Yin <tianci.yin@amd.com>
> > Cc: Harry Wentland <harry.wentland@amd.com>
> > Cc: Nicholas Choi <nicholas.choi@amd.com>
> > Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> > Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> > Cc: Mark Yacoub <markyacoub@google.com>
> > Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> >
> > Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index ccd67003b120..9c2537a17a7b 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -10067,7 +10067,7 @@ static int validate_overlay(struct drm_atomic_state *state)
> >       int i;
> >       struct drm_plane *plane;
> >       struct drm_plane_state *old_plane_state, *new_plane_state;
> > -     struct drm_plane_state *primary_state, *overlay_state = NULL;
> > +     struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
> >
> >       /* Check if primary plane is contained inside overlay */
> >       for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
> > @@ -10097,6 +10097,14 @@ static int validate_overlay(struct drm_atomic_state *state)
> >       if (!primary_state->crtc)
> >               return 0;
> >
> > +     /* check if cursor plane is enabled */
> > +     cursor_state = drm_atomic_get_plane_state(state, overlay_state->crtc->cursor);
> > +     if (IS_ERR(cursor_state))
> > +             return PTR_ERR(cursor_state);
> > +
> > +     if (drm_atomic_plane_disabling(plane->state, cursor_state))
> > +             return 0;
> > +
>
> I thought this breaks Chrome's compositor since it can't handle an atomic commit rejection
> based solely on whether a cursor is enabled or not.
>
> Harry
>
> >       /* Perform the bounds check to ensure the overlay plane covers the primary */
> >       if (primary_state->crtc_x < overlay_state->crtc_x ||
> >           primary_state->crtc_y < overlay_state->crtc_y ||
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
