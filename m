Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BA9C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 18:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 720076108D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 18:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720076108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301986E9BB;
	Mon,  7 Jun 2021 18:38:20 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F516E527
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 18:20:24 +0000 (UTC)
Received: by mail-yb1-xb29.google.com with SMTP id f84so26441066ybg.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jun 2021 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XgfMYrCJp5iCOdPZYP1i6kH9oOKvwG/e5SDsjk4hVEU=;
 b=jHW9nPV00MPj/QmcBJYX+2qGHEebGirbyfwG/r+KOuQ+XfczYoQ/6gvMdXs712WfB7
 fF+0/b3xXraeztD5bdQEUeUpSa6wUYnu48sp64chk/MQ0hgEEerLAN5c2HDqmKOYoxsu
 7qPKV6F97LdwtqSCnewNWieovC2oq+cMhtXfdWiDR8BB+ThdQxAmp+blIA2LlDNOC578
 tUxUMRUMDKhtt1bLKSjb6PB3iOUlL7a5zC7Ooj0D5+37lXZ3kYoey2Kms/wz4ZWrFZgp
 uUh+pTS+UbgvqAS24wptEE1YZyIJZOBtT2kQBK9NAfH/ogkzLc/hP6HJBkA92fySqppu
 xlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XgfMYrCJp5iCOdPZYP1i6kH9oOKvwG/e5SDsjk4hVEU=;
 b=ZejBCp3jsToY7UDCInU2/p/Yju7xkLDe/v5oEPiP71i1YuH11uBZ1f6R+zL96P/bka
 exI5AGG5urSXREa5Yzl7qCJ0zuXmwy/K8SV6E8+CiX8/eOqjkeMj1mAXQayWtm6h+dE1
 matUDrLtEju+wMJh+l2STRdMqsrRCYNap47RfuZJSdGmvtpjnu8nvYsuvBTA8qHJmRL9
 W8HcIi122mb5YqJkgZHLIZVirX+/gwZP0+bEW97pEmimYcdRZXQftLFb1KvyfMKbCBHR
 DIb3RxulzNWcbkBG3nfruhbPo+X9l7TeS/DD/oUK5ABOFsuoVqoHoY2C71CEHky5FzPZ
 L+rQ==
X-Gm-Message-State: AOAM531fEoIdjDXutkbef17sumRekj4MiAPL4fk8SWIOIjbDphiHIT61
 ZZkI71IFzAnf0wwFzJ2G7QXBHIqGMNzI91roj8cOYw==
X-Google-Smtp-Source: ABdhPJyE+l506N82hSgEX01Zxuux16zviLXJqSdtEQyI0SU+6vcjaDXzxl7qZSB254RMLLlSNBg6LU6TBbzjpTyrbcs=
X-Received: by 2002:a25:d9ca:: with SMTP id
 q193mr25711565ybg.496.1623090023801; 
 Mon, 07 Jun 2021 11:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
 <857025a9-2ac0-ed37-bc9e-a2be9e1780a9@amd.com>
 <CAC0gqY77ztqBfi3g_JYPVEqmahXVJ+bGePMK40WaPmgm4m6gVw@mail.gmail.com>
 <CAJUqKUrM6jrUrZkcfF=R7vNeoj4KvwymwM4tMVy09ndsPci-9Q@mail.gmail.com>
 <20210518185806.gsrzfcxcwo6o47kc@outlook.office365.com>
In-Reply-To: <20210518185806.gsrzfcxcwo6o47kc@outlook.office365.com>
From: Sean Paul <seanpaul@google.com>
Date: Mon, 7 Jun 2021 14:19:46 -0400
Message-ID: <CAOw6vbLBTW03h1-amysV0rAn3YiT6z0C6jds5vPMz1rAEcDGow@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix overlay validation by considering
 cursors
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
X-Mailman-Approved-At: Mon, 07 Jun 2021 18:38:20 +0000
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
Cc: Mark Yacoub <markyacoub@chromium.org>, "Tianci . Yin" <tianci.yin@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Nicholas Choi <nicholas.choi@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 18, 2021 at 2:58 PM Rodrigo Siqueira
<Rodrigo.Siqueira@amd.com> wrote:
>
> On 05/14, Mark Yacoub wrote:
> > On Fri, May 14, 2021 at 12:31 PM Mark Yacoub <markyacoub@google.com> wrote:
> > >
> > > On Fri, May 14, 2021 at 11:28 AM Harry Wentland <harry.wentland@amd.com> wrote:
> > > >
> > > > On 2021-05-14 7:47 a.m., Rodrigo Siqueira wrote:
> > > > > A few weeks ago, we saw a two cursor issue in a ChromeOS system. We
> > > > > fixed it in the commit:
> > > > >
> > > > >  drm/amd/display: Fix two cursor duplication when using overlay
> > > > >  (read the commit message for more details)
> > > > >
> > > > > After this change, we noticed that some IGT subtests related to
> > > > > kms_plane and kms_plane_scaling started to fail. After investigating
> > > > > this issue, we noticed that all subtests that fail have a primary plane
> > > > > covering the overlay plane, which is currently rejected by amdgpu dm.
> > > > > Fail those IGT tests highlight that our verification was too broad and
> > > > > compromises the overlay usage in our drive. This patch fixes this issue
> > nit: s/drive/driver?
> > > > > by ensuring that we only reject commits where the primary plane is not
> > > > > fully covered by the overlay when the cursor hardware is enabled. With
> > > > > this fix, all IGT tests start to pass again, which means our overlay
> > > > > support works as expected.
> > > > >
> > > > > Cc: Tianci.Yin <tianci.yin@amd.com>
> > > > > Cc: Harry Wentland <harry.wentland@amd.com>
> > > > > Cc: Nicholas Choi <nicholas.choi@amd.com>
> > > > > Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> > > > > Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> > > > > Cc: Mark Yacoub <markyacoub@google.com>
> > > > > Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> > > > >
> > > > > Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
> > > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > index ccd67003b120..9c2537a17a7b 100644
> > > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > @@ -10067,7 +10067,7 @@ static int validate_overlay(struct drm_atomic_state *state)
> > > > >       int i;
> > > > >       struct drm_plane *plane;
> > > > >       struct drm_plane_state *old_plane_state, *new_plane_state;
> > > > > -     struct drm_plane_state *primary_state, *overlay_state = NULL;
> > > > > +     struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
> > > > >
> > > > >       /* Check if primary plane is contained inside overlay */
> > > > >       for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
> > > > > @@ -10097,6 +10097,14 @@ static int validate_overlay(struct drm_atomic_state *state)
> > > > >       if (!primary_state->crtc)
> > > > >               return 0;
> > > > >
> > > > > +     /* check if cursor plane is enabled */
> > > > > +     cursor_state = drm_atomic_get_plane_state(state, overlay_state->crtc->cursor);
> > > > > +     if (IS_ERR(cursor_state))
> > > > > +             return PTR_ERR(cursor_state);
> > > > > +
> > > > > +     if (drm_atomic_plane_disabling(plane->state, cursor_state))
> > > > > +             return 0;
> > > > > +
> > > >
> > > > I thought this breaks Chrome's compositor since it can't handle an atomic commit rejection
> > > > based solely on whether a cursor is enabled or not.
> > For context: To use overlays (the old/current async way), Chrome tests
> > if an overlay strategy will work by doing an atomic commit with a TEST
> > flag to check if the combination would work. If it works, it flags
> > this planes configuration as valid. As it's valid, it performs an
> > atomic page flip (which could also include the cursor).
> > So to Harry's point, you would pass an atomic test but fail on an
> > atomic page flip with the exact same configuration that's been flagged
> > as valid. Failing a pageflip causes Chrome to crash (Reset the GPU
> > process cause something went horribly wrong when it shouldn't).
>
> Hi Mark and Sean,
>
> I don't know if I fully comprehended the scenario which in my patch
> might cause a ChromeOS crash, but this is what I understood:
>

Chrome compositor only does an atomic test when the layout geometry
changes (ie: plane is added/removed/resized/moved). This does not take
into consideration the cursor. Once the atomic test has been validated
for a given layout geometry (set of planes/fbs along with their sizes
and locations), Chrome assumes this will continue to be valid.

So the situation I'm envisioning is if the cursor is hidden, an
overlay-based strategy will pass in the kernel. If at any time the
cursor becomes visible, the kernel will start failing commits which
causes Chrome's GPU process to crash.

In general I'm uneasy with using the cursor in the atomic check since
it feels like it could be racy independent of the issue above. I
haven't dove into the helper code enough to prove it, just a
spidey-sense.

Sean

> There is a chance that we pass the atomic check
> (DRM_MODE_ATOMIC_TEST_ONLY - TEST) but fails in the atomic page flip
> because, after use TEST, the compositor might slightly change the commit
> config by adding the cursor. The reason behind that came from the
> assumption that adds the cursor in the atomic commit config after the
> test is harmless. Is my understand correct? Please, correct me if I'm
> wrong.
>
> If the above reasoning is correct, I think the compositor should not
> assume anything extra from what it got from the atomic check.
>
> Best Regards,
> Siqueira
>
> > > >
> > > > Harry
> > > >
> > > > >       /* Perform the bounds check to ensure the overlay plane covers the primary */
> > > > >       if (primary_state->crtc_x < overlay_state->crtc_x ||
> > > > >           primary_state->crtc_y < overlay_state->crtc_y ||
> > > > >
> > > >
>
> --
> Rodrigo Siqueira
> https://siqueira.tech
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
