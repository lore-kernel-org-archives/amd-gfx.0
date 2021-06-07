Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F66C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 18:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4946108C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 18:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4946108C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 692456E0A2;
	Mon,  7 Jun 2021 18:48:38 +0000 (UTC)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C94A6E9B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 18:46:15 +0000 (UTC)
Received: by mail-yb1-xb31.google.com with SMTP id q21so26428408ybg.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Jun 2021 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QIG3l40TEJFF67EfkI91xDyKWiHnEpo6YhYb6QmUCZQ=;
 b=sQPZpgVs+MtpKWTI4IRzZ3PJuLTu8qMa9vFrwBqnKk8VMHZBK4B/PyvBEp7xXPfdWB
 6i1hdpQai4otr+8F0DTFqq0NISDZ7rYYrhr8AdmYEgdZm+XbCIkhCq/0b1pYC5TN/qNm
 A7TuXsJbspbuxOQO1/H6l1xCNptpGX75sanXPRfx02sFt/jjk3ZNVG0rdKpFR2ew/N2E
 xCTuCnXgMLCPR0RVlgjqVjpA2dy2VfgU9hA3y7/hLucTWeQujUSlFrLUSqApCBagYUgi
 Fsi3FFAYWtl0eAOzDmYoMoIqTTTsG4t/qg01j8HxoCvUCf1R8xiqg+bN8M5X+CMkjrkE
 rkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QIG3l40TEJFF67EfkI91xDyKWiHnEpo6YhYb6QmUCZQ=;
 b=WpiZWQrg99ywEaAFOu2szx0ST+cVScGOZTjB9ragcKiGiV0Q3jhQlI0JK8yDAax0Ti
 B1j0lr8+WXKuqbAK+J51tIopwSzRFNbF66QWNgY2Af+Yabad303+ql6p9IjPa0d2Gqe7
 N87ugp8+QgS1+GPy+7c5xOHCUlROYi88ggjGEZ20F3os0zGoHKycEp2kBfML5nTtMJYk
 h1MKLmtNu4JMj5ucioWUCyt7gzRj6WtNCfVK8ckunXVJriNji/PgAfC0Wl4DRUZy+yFu
 87U6tgRszU/6NHd1xvWWttKme0ZSh6Jk0JuoPSBiY3vdz7k4z84UejL34RG1jZRZrOaJ
 3Ebw==
X-Gm-Message-State: AOAM532OHsZhRaJEtyxT7V+Dp76hiGsVoSi1QAnHGkpJUyhlrAThszvg
 pCjdp0qGFcgwrM3MH7S6lkSvuFVettPpQyUZBHel+Q==
X-Google-Smtp-Source: ABdhPJx+OQCWtMm0fHPwxlQfxhpmczRZhatDuyLB+jDHY4B8+R3MEIarur8WMWzdZd/rNVnxrCZ3Dv3jaAexjNiZhQQ=
X-Received: by 2002:a25:ba0c:: with SMTP id t12mr25141889ybg.158.1623091574121; 
 Mon, 07 Jun 2021 11:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
 <857025a9-2ac0-ed37-bc9e-a2be9e1780a9@amd.com>
 <CAC0gqY77ztqBfi3g_JYPVEqmahXVJ+bGePMK40WaPmgm4m6gVw@mail.gmail.com>
 <CAJUqKUrM6jrUrZkcfF=R7vNeoj4KvwymwM4tMVy09ndsPci-9Q@mail.gmail.com>
 <20210518185806.gsrzfcxcwo6o47kc@outlook.office365.com>
 <CAOw6vbLBTW03h1-amysV0rAn3YiT6z0C6jds5vPMz1rAEcDGow@mail.gmail.com>
 <517b3280-f7aa-eab3-472e-5e23ad5dc243@amd.com>
In-Reply-To: <517b3280-f7aa-eab3-472e-5e23ad5dc243@amd.com>
From: Sean Paul <seanpaul@google.com>
Date: Mon, 7 Jun 2021 14:45:37 -0400
Message-ID: <CAOw6vb+SAOsp-2Da6UMf+Xgx7V=P3MDjFqm1tjRyV6bZk_HPyg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix overlay validation by considering
 cursors
To: Harry Wentland <harry.wentland@amd.com>
X-Mailman-Approved-At: Mon, 07 Jun 2021 18:48:37 +0000
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
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Nicholas Choi <nicholas.choi@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Mark Yacoub <markyacoub@google.com>
Content-Type: multipart/mixed; boundary="===============0445997105=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0445997105==
Content-Type: multipart/alternative; boundary="000000000000b72d4e05c4317430"

--000000000000b72d4e05c4317430
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 7, 2021 at 2:37 PM Harry Wentland <harry.wentland@amd.com>
wrote:

> On 2021-06-07 2:19 p.m., Sean Paul wrote:
> > On Tue, May 18, 2021 at 2:58 PM Rodrigo Siqueira
> > <Rodrigo.Siqueira@amd.com> wrote:
> >>
> >> On 05/14, Mark Yacoub wrote:
> >>> On Fri, May 14, 2021 at 12:31 PM Mark Yacoub <markyacoub@google.com>
> wrote:
> >>>>
> >>>> On Fri, May 14, 2021 at 11:28 AM Harry Wentland <
> harry.wentland@amd.com> wrote:
> >>>>>
> >>>>> On 2021-05-14 7:47 a.m., Rodrigo Siqueira wrote:
> >>>>>> A few weeks ago, we saw a two cursor issue in a ChromeOS system. We
> >>>>>> fixed it in the commit:
> >>>>>>
> >>>>>>  drm/amd/display: Fix two cursor duplication when using overlay
> >>>>>>  (read the commit message for more details)
> >>>>>>
> >>>>>> After this change, we noticed that some IGT subtests related to
> >>>>>> kms_plane and kms_plane_scaling started to fail. After investigating
> >>>>>> this issue, we noticed that all subtests that fail have a primary
> plane
> >>>>>> covering the overlay plane, which is currently rejected by amdgpu
> dm.
> >>>>>> Fail those IGT tests highlight that our verification was too broad
> and
> >>>>>> compromises the overlay usage in our drive. This patch fixes this
> issue
> >>> nit: s/drive/driver?
> >>>>>> by ensuring that we only reject commits where the primary plane is
> not
> >>>>>> fully covered by the overlay when the cursor hardware is enabled.
> With
> >>>>>> this fix, all IGT tests start to pass again, which means our overlay
> >>>>>> support works as expected.
> >>>>>>
> >>>>>> Cc: Tianci.Yin <tianci.yin@amd.com>
> >>>>>> Cc: Harry Wentland <harry.wentland@amd.com>
> >>>>>> Cc: Nicholas Choi <nicholas.choi@amd.com>
> >>>>>> Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> >>>>>> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> >>>>>> Cc: Mark Yacoub <markyacoub@google.com>
> >>>>>> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> >>>>>>
> >>>>>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >>>>>> ---
> >>>>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
> >>>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>>> index ccd67003b120..9c2537a17a7b 100644
> >>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>>>>> @@ -10067,7 +10067,7 @@ static int validate_overlay(struct
> drm_atomic_state *state)
> >>>>>>       int i;
> >>>>>>       struct drm_plane *plane;
> >>>>>>       struct drm_plane_state *old_plane_state, *new_plane_state;
> >>>>>> -     struct drm_plane_state *primary_state, *overlay_state = NULL;
> >>>>>> +     struct drm_plane_state *primary_state, *cursor_state,
> *overlay_state = NULL;
> >>>>>>
> >>>>>>       /* Check if primary plane is contained inside overlay */
> >>>>>>       for_each_oldnew_plane_in_state_reverse(state, plane,
> old_plane_state, new_plane_state, i) {
> >>>>>> @@ -10097,6 +10097,14 @@ static int validate_overlay(struct
> drm_atomic_state *state)
> >>>>>>       if (!primary_state->crtc)
> >>>>>>               return 0;
> >>>>>>
> >>>>>> +     /* check if cursor plane is enabled */
> >>>>>> +     cursor_state = drm_atomic_get_plane_state(state,
> overlay_state->crtc->cursor);
> >>>>>> +     if (IS_ERR(cursor_state))
> >>>>>> +             return PTR_ERR(cursor_state);
> >>>>>> +
> >>>>>> +     if (drm_atomic_plane_disabling(plane->state, cursor_state))
> >>>>>> +             return 0;
> >>>>>> +
> >>>>>
> >>>>> I thought this breaks Chrome's compositor since it can't handle an
> atomic commit rejection
> >>>>> based solely on whether a cursor is enabled or not.
> >>> For context: To use overlays (the old/current async way), Chrome tests
> >>> if an overlay strategy will work by doing an atomic commit with a TEST
> >>> flag to check if the combination would work. If it works, it flags
> >>> this planes configuration as valid. As it's valid, it performs an
> >>> atomic page flip (which could also include the cursor).
> >>> So to Harry's point, you would pass an atomic test but fail on an
> >>> atomic page flip with the exact same configuration that's been flagged
> >>> as valid. Failing a pageflip causes Chrome to crash (Reset the GPU
> >>> process cause something went horribly wrong when it shouldn't).
> >>
> >> Hi Mark and Sean,
> >>
> >> I don't know if I fully comprehended the scenario which in my patch
> >> might cause a ChromeOS crash, but this is what I understood:
> >>
> >
> > Chrome compositor only does an atomic test when the layout geometry
> > changes (ie: plane is added/removed/resized/moved). This does not take
> > into consideration the cursor. Once the atomic test has been validated
> > for a given layout geometry (set of planes/fbs along with their sizes
> > and locations), Chrome assumes this will continue to be valid.
> >
> > So the situation I'm envisioning is if the cursor is hidden, an
> > overlay-based strategy will pass in the kernel. If at any time the
> > cursor becomes visible, the kernel will start failing commits which
> > causes Chrome's GPU process to crash.
> >
> > In general I'm uneasy with using the cursor in the atomic check since
> > it feels like it could be racy independent of the issue above. I
> > haven't dove into the helper code enough to prove it, just a
> > spidey-sense.
> >
>
> Isn't the cursor supposed to be just another plane? If so, shouldn't
> adding/removing the cursor trigger an atomic test?
>
>
Chrome is using legacy cursor.

Yes it will trigger an atomic test in the kernel, and that atomic test will
fail. Unfortunately Chrome does not expect a failure so it will crash.

Sean


Is Chrome's compositor doing cursor update through legacy IOCTLs or
> through the ATOMIC IOCTL?
>
> Thanks,
> Harry
>
> > Sean
> >
> >> There is a chance that we pass the atomic check
> >> (DRM_MODE_ATOMIC_TEST_ONLY - TEST) but fails in the atomic page flip
> >> because, after use TEST, the compositor might slightly change the commit
> >> config by adding the cursor. The reason behind that came from the
> >> assumption that adds the cursor in the atomic commit config after the
> >> test is harmless. Is my understand correct? Please, correct me if I'm
> >> wrong.
> >>
> >> If the above reasoning is correct, I think the compositor should not
> >> assume anything extra from what it got from the atomic check.
> >>
> >> Best Regards,
> >> Siqueira
> >>
> >>>>>
> >>>>> Harry
> >>>>>
> >>>>>>       /* Perform the bounds check to ensure the overlay plane
> covers the primary */
> >>>>>>       if (primary_state->crtc_x < overlay_state->crtc_x ||
> >>>>>>           primary_state->crtc_y < overlay_state->crtc_y ||
> >>>>>>
> >>>>>
> >>
> >> --
> >> Rodrigo Siqueira
> >> https://siqueira.tech/>
>

--000000000000b72d4e05c4317430
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 7, 2021 at 2:37 PM Harry =
Wentland &lt;<a href=3D"mailto:harry.wentland@amd.com">harry.wentland@amd.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 2021-06-07 2:19 p.m., Sean Paul wrote:<br>
&gt; On Tue, May 18, 2021 at 2:58 PM Rodrigo Siqueira<br>
&gt; &lt;<a href=3D"mailto:Rodrigo.Siqueira@amd.com" target=3D"_blank">Rodr=
igo.Siqueira@amd.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On 05/14, Mark Yacoub wrote:<br>
&gt;&gt;&gt; On Fri, May 14, 2021 at 12:31 PM Mark Yacoub &lt;<a href=3D"ma=
ilto:markyacoub@google.com" target=3D"_blank">markyacoub@google.com</a>&gt;=
 wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Fri, May 14, 2021 at 11:28 AM Harry Wentland &lt;<a hre=
f=3D"mailto:harry.wentland@amd.com" target=3D"_blank">harry.wentland@amd.co=
m</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On 2021-05-14 7:47 a.m., Rodrigo Siqueira wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; A few weeks ago, we saw a two cursor issue in a Ch=
romeOS system. We<br>
&gt;&gt;&gt;&gt;&gt;&gt; fixed it in the commit:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 drm/amd/display: Fix two cursor duplication =
when using overlay<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 (read the commit message for more details)<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; After this change, we noticed that some IGT subtes=
ts related to<br>
&gt;&gt;&gt;&gt;&gt;&gt; kms_plane and kms_plane_scaling started to fail. A=
fter investigating<br>
&gt;&gt;&gt;&gt;&gt;&gt; this issue, we noticed that all subtests that fail=
 have a primary plane<br>
&gt;&gt;&gt;&gt;&gt;&gt; covering the overlay plane, which is currently rej=
ected by amdgpu dm.<br>
&gt;&gt;&gt;&gt;&gt;&gt; Fail those IGT tests highlight that our verificati=
on was too broad and<br>
&gt;&gt;&gt;&gt;&gt;&gt; compromises the overlay usage in our drive. This p=
atch fixes this issue<br>
&gt;&gt;&gt; nit: s/drive/driver?<br>
&gt;&gt;&gt;&gt;&gt;&gt; by ensuring that we only reject commits where the =
primary plane is not<br>
&gt;&gt;&gt;&gt;&gt;&gt; fully covered by the overlay when the cursor hardw=
are is enabled. With<br>
&gt;&gt;&gt;&gt;&gt;&gt; this fix, all IGT tests start to pass again, which=
 means our overlay<br>
&gt;&gt;&gt;&gt;&gt;&gt; support works as expected.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: Tianci.Yin &lt;<a href=3D"mailto:tianci.yin@am=
d.com" target=3D"_blank">tianci.yin@amd.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: Harry Wentland &lt;<a href=3D"mailto:harry.wen=
tland@amd.com" target=3D"_blank">harry.wentland@amd.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: Nicholas Choi &lt;<a href=3D"mailto:nicholas.c=
hoi@amd.com" target=3D"_blank">nicholas.choi@amd.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: Bhawanpreet Lakha &lt;<a href=3D"mailto:bhawan=
preet.lakha@amd.com" target=3D"_blank">bhawanpreet.lakha@amd.com</a>&gt;<br=
>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: Nicholas Kazlauskas &lt;<a href=3D"mailto:Nich=
olas.Kazlauskas@amd.com" target=3D"_blank">Nicholas.Kazlauskas@amd.com</a>&=
gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: Mark Yacoub &lt;<a href=3D"mailto:markyacoub@g=
oogle.com" target=3D"_blank">markyacoub@google.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Cc: Daniel Wheeler &lt;<a href=3D"mailto:daniel.wh=
eeler@amd.com" target=3D"_blank">daniel.wheeler@amd.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Rodrigo Siqueira &lt;<a href=3D"mai=
lto:Rodrigo.Siqueira@amd.com" target=3D"_blank">Rodrigo.Siqueira@amd.com</a=
>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu=
_dm.c | 10 +++++++++-<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 1 file changed, 9 insertions(+), 1 deletion(=
-)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; index ccd67003b120..9c2537a17a7b 100644<br>
&gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu=
_dm.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu=
_dm.c<br>
&gt;&gt;&gt;&gt;&gt;&gt; @@ -10067,7 +10067,7 @@ static int validate_overla=
y(struct drm_atomic_state *state)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_plane *plane;=
<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_plane_state *=
old_plane_state, *new_plane_state;<br>
&gt;&gt;&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0struct drm_plane_state *prima=
ry_state, *overlay_state =3D NULL;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct drm_plane_state *prima=
ry_state, *cursor_state, *overlay_state =3D NULL;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if primary plan=
e is contained inside overlay */<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_oldnew_plane_in=
_state_reverse(state, plane, old_plane_state, new_plane_state, i) {<br>
&gt;&gt;&gt;&gt;&gt;&gt; @@ -10097,6 +10097,14 @@ static int validate_overl=
ay(struct drm_atomic_state *state)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!primary_state-&gt;c=
rtc)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0/* check if cursor plane is e=
nabled */<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0cursor_state =3D drm_atomic_g=
et_plane_state(state, overlay_state-&gt;crtc-&gt;cursor);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (IS_ERR(cursor_state))<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn PTR_ERR(cursor_state);<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (drm_atomic_plane_disablin=
g(plane-&gt;state, cursor_state))<br>
&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn 0;<br>
&gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I thought this breaks Chrome&#39;s compositor since it=
 can&#39;t handle an atomic commit rejection<br>
&gt;&gt;&gt;&gt;&gt; based solely on whether a cursor is enabled or not.<br=
>
&gt;&gt;&gt; For context: To use overlays (the old/current async way), Chro=
me tests<br>
&gt;&gt;&gt; if an overlay strategy will work by doing an atomic commit wit=
h a TEST<br>
&gt;&gt;&gt; flag to check if the combination would work. If it works, it f=
lags<br>
&gt;&gt;&gt; this planes configuration as valid. As it&#39;s valid, it perf=
orms an<br>
&gt;&gt;&gt; atomic page flip (which could also include the cursor).<br>
&gt;&gt;&gt; So to Harry&#39;s point, you would pass an atomic test but fai=
l on an<br>
&gt;&gt;&gt; atomic page flip with the exact same configuration that&#39;s =
been flagged<br>
&gt;&gt;&gt; as valid. Failing a pageflip causes Chrome to crash (Reset the=
 GPU<br>
&gt;&gt;&gt; process cause something went horribly wrong when it shouldn&#3=
9;t).<br>
&gt;&gt;<br>
&gt;&gt; Hi Mark and Sean,<br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t know if I fully comprehended the scenario which in my =
patch<br>
&gt;&gt; might cause a ChromeOS crash, but this is what I understood:<br>
&gt;&gt;<br>
&gt; <br>
&gt; Chrome compositor only does an atomic test when the layout geometry<br=
>
&gt; changes (ie: plane is added/removed/resized/moved). This does not take=
<br>
&gt; into consideration the cursor. Once the atomic test has been validated=
<br>
&gt; for a given layout geometry (set of planes/fbs along with their sizes<=
br>
&gt; and locations), Chrome assumes this will continue to be valid.<br>
&gt; <br>
&gt; So the situation I&#39;m envisioning is if the cursor is hidden, an<br=
>
&gt; overlay-based strategy will pass in the kernel. If at any time the<br>
&gt; cursor becomes visible, the kernel will start failing commits which<br=
>
&gt; causes Chrome&#39;s GPU process to crash.<br>
&gt; <br>
&gt; In general I&#39;m uneasy with using the cursor in the atomic check si=
nce<br>
&gt; it feels like it could be racy independent of the issue above. I<br>
&gt; haven&#39;t dove into the helper code enough to prove it, just a<br>
&gt; spidey-sense.<br>
&gt; <br>
<br>
Isn&#39;t the cursor supposed to be just another plane? If so, shouldn&#39;=
t<br>
adding/removing the cursor trigger an atomic test?<br>
<br></blockquote><div><br></div><div>Chrome is using legacy cursor.</div><d=
iv><br></div><div>Yes it will trigger an atomic test in the kernel, and tha=
t atomic test will fail. Unfortunately Chrome does not expect a failure so =
it will crash.</div><div><br></div><div>Sean</div><div><br></div><div><br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
Is Chrome&#39;s compositor doing cursor update through legacy IOCTLs or<br>
through the ATOMIC IOCTL?<br>
<br>
Thanks,<br>
Harry<br>
<br>
&gt; Sean<br>
&gt; <br>
&gt;&gt; There is a chance that we pass the atomic check<br>
&gt;&gt; (DRM_MODE_ATOMIC_TEST_ONLY - TEST) but fails in the atomic page fl=
ip<br>
&gt;&gt; because, after use TEST, the compositor might slightly change the =
commit<br>
&gt;&gt; config by adding the cursor. The reason behind that came from the<=
br>
&gt;&gt; assumption that adds the cursor in the atomic commit config after =
the<br>
&gt;&gt; test is harmless. Is my understand correct? Please, correct me if =
I&#39;m<br>
&gt;&gt; wrong.<br>
&gt;&gt;<br>
&gt;&gt; If the above reasoning is correct, I think the compositor should n=
ot<br>
&gt;&gt; assume anything extra from what it got from the atomic check.<br>
&gt;&gt;<br>
&gt;&gt; Best Regards,<br>
&gt;&gt; Siqueira<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Harry<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Perform the bounds ch=
eck to ensure the overlay plane covers the primary */<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (primary_state-&gt;cr=
tc_x &lt; overlay_state-&gt;crtc_x ||<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0primary_st=
ate-&gt;crtc_y &lt; overlay_state-&gt;crtc_y ||<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Rodrigo Siqueira<br>
&gt;&gt; <a href=3D"https://siqueira.tech/" rel=3D"noreferrer" target=3D"_b=
lank" class=3D"cremed">https://siqueira.tech/</a>&gt;<br>
</blockquote></div></div>

--000000000000b72d4e05c4317430--

--===============0445997105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0445997105==--
