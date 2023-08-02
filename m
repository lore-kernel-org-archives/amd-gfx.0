Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68583C04E69
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 14:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2055A10E54D;
	Wed,  2 Aug 2023 14:59:07 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E64110E129
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 14:59:05 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a707bc2397so561357b6e.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Aug 2023 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1690988344; x=1691593144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pkmn55yZh1Rz2MwlfyBOzuu4eBd6dwrDT9L9Cwq53pI=;
 b=OtTCxZ1uO6KGb/7Vy+iET/QDAClw9bYJdjMQW2anIJXeLYWTLukaWJ5plk49aE85YL
 TNMMtTu6wuQf5Iyoz6rgoIVSDddrA79p8WUKfWw9xTOiK9Oy9KQHBTvEro6vYv2K0Wz1
 rCA1DBZoDP9ZSyC8RT8C7A5MHk2Pq+iZgGNDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690988344; x=1691593144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pkmn55yZh1Rz2MwlfyBOzuu4eBd6dwrDT9L9Cwq53pI=;
 b=apeKzTTts48YGIqe+wR5js/w/iD8QACaAMAEiMgvB/8aPi6H6miICQmR6VVhWN17JN
 x702KRsC/xYqWa66XiVEGhJxpoDYqc4RA98NVx4CeHfxPRZkstWZXR9Tstd+ZEboKdB6
 nQOABleB2ickS/K4S6OjeeWoLCWzfreuCHpeRiQKRmU1DCtc2bheZqR+JdkDpS+fYeZg
 eaXTHSzLHVUyY9PJ76oWdi9nyO0bUmmSbbCreOfCdb7Ex0bdSxp6HmpOEHIU1/5u3OH6
 3fdJm/eU/4F2JYD6rnud1NaIOKEhU0vuQi0WyhnI7ou1OQEhLUbp0myUknMMS/1Sl737
 Ii8A==
X-Gm-Message-State: ABy/qLYotkqwlIyLQ4CBJNuhN600if5G/GVPwVYoPYmOgkPdourCCAqF
 83LQqb3eOJx6cAkBhDy9kBe3GXZl/MYRRj1+dt9NgQ==
X-Google-Smtp-Source: APBJJlG7s6LInHyvHFYr1Mc+JjNw0wI3JAe6FASZYgSUHMNQkbDcagsLdus2tHIGWJRIhFSeeDhMRcI3pXptt+vnN3w=
X-Received: by 2002:a05:6808:1926:b0:3a7:16f3:a46e with SMTP id
 bf38-20020a056808192600b003a716f3a46emr12040217oib.2.1690988344485; Wed, 02
 Aug 2023 07:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230707224059.305474-1-andrealmeid@igalia.com>
 <20230707224059.305474-7-andrealmeid@igalia.com>
 <ZK0ZlciR66oTO+Td@phenom.ffwll.local>
 <20230713105142.122a0cc1@eldfell>
 <35a8e502-c36c-e67e-29ba-a20ae6134c6d@igalia.com>
In-Reply-To: <35a8e502-c36c-e67e-29ba-a20ae6134c6d@igalia.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 2 Aug 2023 16:58:52 +0200
Message-ID: <CAKMK7uFMYjueTT8DTE5MER6wPNCHCS8gJriQsAR=4WnzAXRp8w@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/doc: Define KMS atomic state set
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Simon Ser <contact@emersion.fr>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, hwentlan@amd.com,
 ville.syrjala@linux.intel.com, Pekka Paalanen <ppaalanen@gmail.com>,
 Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, alexander.deucher@amd.com,
 Daniel Stone <daniel@fooishbar.org>, Dave Airlie <airlied@gmail.com>,
 christian.koenig@amd.com, joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 31 Jul 2023 at 04:01, Andr=C3=A9 Almeida <andrealmeid@igalia.com> w=
rote:
>
> Em 13/07/2023 04:51, Pekka Paalanen escreveu:
> > On Tue, 11 Jul 2023 10:57:57 +0200
> > Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> >> On Fri, Jul 07, 2023 at 07:40:59PM -0300, Andr=C3=A9 Almeida wrote:
> >>> From: Pekka Paalanen <pekka.paalanen@collabora.com>
> >>>
> >>> Specify how the atomic state is maintained between userspace and
> >>> kernel, plus the special case for async flips.
> >>>
> >>> Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> >>> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >>> ---
> >>> v4: total rework by Pekka
> >>> ---
> >>>   Documentation/gpu/drm-uapi.rst | 41 +++++++++++++++++++++++++++++++=
+++
> >>>   1 file changed, 41 insertions(+)
> >>>
> >>> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-u=
api.rst
> >>> index 65fb3036a580..6a1662c08901 100644
> >>> --- a/Documentation/gpu/drm-uapi.rst
> >>> +++ b/Documentation/gpu/drm-uapi.rst
> >>> @@ -486,3 +486,44 @@ and the CRTC index is its position in this array=
.
> >>>
> >>>   .. kernel-doc:: include/uapi/drm/drm_mode.h
> >>>      :internal:
> >>> +
> >>> +KMS atomic state
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >>> +An atomic commit can change multiple KMS properties in an atomic fas=
hion,
> >>> +without ever applying intermediate or partial state changes.  Either=
 the whole
> >>> +commit succeeds or fails, and it will never be applied partially. Th=
is is the
> >>> +fundamental improvement of the atomic API over the older non-atomic =
API which is
> >>> +referred to as the "legacy API".  Applying intermediate state could =
unexpectedly
> >>> +fail, cause visible glitches, or delay reaching the final state.
> >>> +
> >>> +An atomic commit can be flagged with DRM_MODE_ATOMIC_TEST_ONLY, whic=
h means the
> >>> +complete state change is validated but not applied.  Userspace shoul=
d use this
> >>> +flag to validate any state change before asking to apply it. If vali=
dation fails
> >>> +for any reason, userspace should attempt to fall back to another, pe=
rhaps
> >>> +simpler, final state.  This allows userspace to probe for various co=
nfigurations
> >>> +without causing visible glitches on screen and without the need to u=
ndo a
> >>> +probing change.
> >>> +
> >>> +The changes recorded in an atomic commit apply on top the current KM=
S state in
> >>> +the kernel. Hence, the complete new KMS state is the complete old KM=
S state with
> >>> +the committed property settings done on top. The kernel will automat=
ically avoid
> >>> +no-operation changes, so it is safe and even expected for userspace =
to send
> >>> +redundant property settings.  No-operation changes do not count towa=
rds actually
> >>> +needed changes, e.g.  setting MODE_ID to a different blob with ident=
ical
> >>> +contents as the current KMS state shall not be a modeset on its own.
> >>
> >> Small clarification: The kernel indeed tries very hard to make redunda=
nt
> >> changes a no-op, and I think we should consider any issues here bugs. =
But
> >> it still has to check, which means it needs to acquire the right locks=
 and
> >> put in the right (cross-crtc) synchronization points, and due to
> >> implmentation challenges it's very hard to try to avoid that in all ca=
ses.
> >> So adding redundant changes especially across crtc (and their connecte=
d
> >> planes/connectors) might result in some oversynchronization issues, an=
d
> >> userspace should therefore avoid them if feasible.
> >>
> >> With some sentences added to clarify this:
> >>
> >> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > After talking on IRC yesterday, we realized that the no-op rule is
> > nowhere near as generic as I have believed. Roughly:
> > https://oftc.irclog.whitequark.org/dri-devel/2023-07-12#1689152446-1689=
157291;
> >
> >
>
> How about:
>
> The changes recorded in an atomic commit apply on top the current KMS
> state in the kernel. Hence, the complete new KMS state is the complete
> old KMS state with the committed property settings done on top. The
> kernel will try to avoid no-operation changes, so it is safe for
> userspace to send redundant property settings. However, the kernel can
> not assure that every redundant information will always result in a
> no-op, giving the need to take locks to check par of the state. Giving
> that, some redundant information can lead to a full damage path. This is
> not something bad by itself, but userspace need to be aware of that side
> effect.

I think the addition about damage tracking should be a separate
paragraph, and not mixed in with the general explanation that no-op
updates might lead to oversync/overlocking issues. Because the damage
tracking issue is more a question of efficiency/power usage, but
should not (for most drivers/hw at least) result in delays and missed
updates due to oversynchronization of updates.

Also in my opinion the exact damage update rules are more a plane
property issue, and should probably be clarified there if the current
documentation is not clear enough. Since it's not about whether no-op
updates get avoided by the kernel, but what exact damage is implied in
various cases (and that implied damage has to exist, otherwise
backwards compatibility is broken, but userspace can avoid these
issues by setting an empty damage property for that plane update
explicitly).

So I think for this doc part here the discussed text is still good
enough, but we might need more in other places.
-Sima


>
> > Thanks,
> > pq
> >
> >>> +
> >>> +A "modeset" is a change in KMS state that might enable, disable, or =
temporarily
> >>> +disrupt the emitted video signal, possibly causing visible glitches =
on screen. A
> >>> +modeset may also take considerably more time to complete than other =
kinds of
> >>> +changes, and the video sink might also need time to adapt to the new=
 signal
> >>> +properties. Therefore a modeset must be explicitly allowed with the =
flag
> >>> +DRM_MODE_ATOMIC_ALLOW_MODESET.  This in combination with
> >>> +DRM_MODE_ATOMIC_TEST_ONLY allows userspace to determine if a state c=
hange is
> >>> +likely to cause visible disruption on screen and avoid such changes =
when end
> >>> +users do not expect them.
> >>> +
> >>> +An atomic commit with the flag DRM_MODE_PAGE_FLIP_ASYNC is allowed t=
o
> >>> +effectively change only the FB_ID property on any planes. No-operati=
on changes
> >>> +are ignored as always. Changing any other property will cause the co=
mmit to be
> >>> +rejected.
> >>> --
> >>> 2.41.0
> >>>
> >>
> >



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
