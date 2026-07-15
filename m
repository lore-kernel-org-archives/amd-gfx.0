Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3B0C44507
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 10:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9850710E17B;
	Wed, 15 Jul 2026 10:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A1raBUc0";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8B810E17B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 10:50:28 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493f45e206dso3828925e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784112627; x=1784717427; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=82YYsHlE1F+1QU2MA4eaIiMI406Qh5FGCdQWkVgQpQo=;
 b=A1raBUc0hSL4LEcT6v+XmG0ZHD12uQlpY8mXOzbpbfJOLNN7aXG/mF+6bRCN/XWqFn
 fpiAmFOa2bOSRrGeigyZRoiZ9XeAGqUq/KG6ELddT8HMMahLh4n7mSLovvIIorfhGSY7
 cqOCOV2QOcBrU+wrQAL1kCOmtUice48qM4UKpISLvANC+1GIg+d/QodmLPClIJvvuLwB
 qAbRQXE6kyjRF7MXbZM4raH2QLgupawHMtqNF/SYl/FeajMBrvkBdMyORz/HasqZcaf1
 f5XZK4AQ56ovBdFUsiFFdpL1JtB/hRFM6cNapteb8HbKhpCgGBrwXp+Jr5C2mfbegIgI
 zKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784112627; x=1784717427;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=82YYsHlE1F+1QU2MA4eaIiMI406Qh5FGCdQWkVgQpQo=;
 b=ddNOW/Bv99cIlT/bvB+2GRyStdWuNRF9YYFmNIomux5so4eKczYCS8e8/buS0zJICC
 cQRlLkuvt1TBQOpctfES9KreYx2W6kr5Zy835rvzanD8HcvPD2ShTKfVap2y6MtTLxne
 S8rPi7/oqBP/jNZjIczCdkxv9PH41c2C9Y4zyAOMZQ1DMi4x0EuoXd5nJ5jDxlImEUUm
 +eiZJ9AIxpwkWFfb035YXxZR/+aohkzFrESiQLEdDcNCnDsIBebDyjR+aWsoRIcegdyV
 wWPP5ji1f+EHNkZU8kLny3hlB1jfnATHDS01E9CTaRMHIQntgloYsszmL4oC/iMfgSiC
 5wZg==
X-Gm-Message-State: AOJu0YxChZzJwerjUL+G9IxCJnNoeyNMRO3ZvjJnlCzu7sBAMOaUBReJ
 L1/mury06sDPTMR8ZsQ69Qn9h4Ld4ENg4qJRog9/xxhgy/6/IMKAib5J
X-Gm-Gg: AfdE7cmjBFiSMn07XgF8uwFuIAUjbTxmBs6Tf27HF0Dq/WIiTNXKFTpCjrcaooBONdu
 NFv1VixNacMafqFpb3JGgJ/0Yni5TcjfB/lPShF4Qj4aix+1sVEovfXfK3gRYTSormR0UUPZRBy
 qqoTU70aPRbnlRuvNgRF5OezQfeoywPUjvzcIPKSmPHWtGaT6VILdOv+RCyy9JAD2PJt+Lk7zAw
 fioaYlSKF5SL0Nk66tHzyM7hj2Ezuu07sv00Lpl+AwI8ljnS+BqcQi5Vj3Pm4CeS+7GRl91rR4v
 79OawSiPz4ni/gndC7hoXl3IuexlN95kmwc0pubG5JbA98su3PPKjLbS1iI/tKsqT0nqh9B3gPs
 EUp2WaKaxgLG3CuQ8mfg3Cl4YN3+/irmsuEJCDIouI2Esso6Zq0E/uZJaNI6Jy73t5azywsD/vY
 cF/VYtFfrd4h2dbsu2GIt7m/EKVISRFPdpn2f9DZthfmJK7n6icWJQmce2lDoEH9SW7q20EpOjo
 Gy6f32gD57MkMDqWvRxD1zqgXgHGWhlcT4funvA
X-Received: by 2002:a05:600c:a010:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-493f8885752mr172267175e9.6.1784112626714; 
 Wed, 15 Jul 2026 03:50:26 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c6fe0c6sm42423545e9.1.2026.07.15.03.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:50:26 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 Alex Deucher <alexdeucher@gmail.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Subject: Re: [PATCH 3/9] drm/amdgpu/gfx7: Return error code when compute ring
 tests fail
Date: Wed, 15 Jul 2026 12:50:24 +0200
Message-ID: <6929993.MDQidcC6GM@timur-max>
In-Reply-To: <dddb24b1-2ee5-4dc7-ac40-b66f08fec51c@amd.com>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <7296879.9J7NaK4W3v@timur-max> <dddb24b1-2ee5-4dc7-ac40-b66f08fec51c@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. j=C3=BAlius 15., szerda 11:50:30 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 7/15/26 10:02, Timur Krist=C3=B3f wrote:
> > On 2026. j=C3=BAlius 14., kedd 22:41:33 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Alex Deucher=20
wrote:
> >> On Tue, Jul 14, 2026 at 4:14=E2=80=AFPM Tvrtko Ursulin <tursulin@ursul=
in.net>=20
wrote:
> >>> On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> ...
>=20
> >>> I actually might like this because maybe it gets us closer to removing
> >>> the ring->sched.ready hack but what I am just not sure if the idea was
> >>> to allow driver to function with some non-functional rings after resu=
me.
> >>> Under the premise that if they initialized during init, then after
> >>> resume they must too, or if they don't, it is a transient glitch. I
> >>> don't know.. I am being imaginative here thinking about silly driver
> >>> workarounds for weird hardware glitches. It is much more likely this =
was
> >>> just an oversight and it is completely fine to to error out.
> >>>=20
> >>> I have to defer to Alex and Christian on this one.
> >>=20
> >> The reason for not checking the errors was because compute queue
> >> failure was not seen as fatal.  There are a lot of compute queues
> >> (relative to other engines), so if something happened, it seemed
> >> better to just continue in a degraded mode with fewer compute queues
> >> than to fail to resume in general.
> >=20
> > We had a conversation about a similar topic (it was about UVD), where A=
lex
> > said that in general we should prefer not to handle degraded functional=
ity
> > in amdgpu. I think the same principle should apply here.
>=20
> Yeah, well that's a rather problematic topic.
>=20
> Ignore such errors leads to never fix them. But on the other hand if we
> handle that as fatal and UVD doesn't comes up after resume you end up with
> a black screen while otherwise UVD is just not working.

Yeah, that was exactly my point when we talked about it.

However, Alex convinced me that we shouldn't bother supporting these degrad=
ed=20
use cases. After spending more time working on amdgpu, I think it would rai=
se=20
more problems than it solves if we allowed that.

> > 1. My main problem with handling degraded functionality here is that I
> > have
> > never seen any issue where just some compute queues fail to initialize
> > after boot or after suspend/resume. That means we can't meaningfully te=
st
> > that scenario, so we can't trust any code we write to handle that eithe=
r.
> We had a bunch of cases where some engine didn't worked in the past (UVD,
> VCE, Compute) either on initial load or after suspend/resume.
>=20
> Especially there was a Compute issues that was really annoying because it
> only caused trouble after Mesa switched to using compute engines for
> VA-API. Before that we didn't even know that Compute rings sometimes don't
> properly come up again after a resume.

=46ortunately now we have ring tests and ring IB tests which we execute on=
=20
initialization to make sure the rings work.

> > 2. It would be very tedious to keep track of which queues didn't work in
> > the first place vs. which are those that don't work because of a bug in
> > the soft reset code. I consider the soft reset as failed if not all
> > queues work correctly.
> >=20
> > Considering the above, I vote that we should just expect all queues to
> > work
> > correctly at initialization and after a recovery. What do you guys thin=
k?
>=20
> Well it's basically choosing what is the lesser evil.

Agreed.


