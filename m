Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADD0EE3682
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 13:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B2BD10E74A;
	Thu, 12 Feb 2026 13:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="PMp6uoZ6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iR3VBRTO";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852A010E716;
 Thu, 12 Feb 2026 10:04:40 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fBW9y5WYPz9tVR;
 Thu, 12 Feb 2026 11:04:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1770890678; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AFre+AQoW4GTxlb3pSXIvTb4t8qqbMYJPAfw1gHBVE=;
 b=PMp6uoZ6g/YW2ndbafEmmDWh1e0LeIuVF0MHmBwWJlqG1sqPsWdSFKIB2h67eFsLZ+LTqP
 vH8WmNhewktIc3wIbv2mKLMj3uXAKaMhN4Xij6+tIG1J5XsPEYDycMq+IyhABTdHltQFb/
 UcBGnJoFwHUqRT39sZV+ekAIzIQoq/hdxOFRJ4fov8Gq4lxl96HnSPP4nBEy3s8osAnRBc
 ZqY2LDX4vcIUw4g2sd32R3BuHe9iY1G8f077ZpwsB0HerGAH2Sx1BzQMLMPgv18JeowQb5
 jTm2NxMphW331vGG5kV61rrjPBN/1PuIBh5tag43+G/ldUUqBHDwm4WdHsMKzA==
Message-ID: <5069c964d408622285c718c447d64c8493bc2e80.camel@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1770890676; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AFre+AQoW4GTxlb3pSXIvTb4t8qqbMYJPAfw1gHBVE=;
 b=iR3VBRTOiBVZZSmKUl+LmhtSFsSOthtK4Tytz+FwHwqApEZPXWI4Jfp0NLqbcR/d+t+HTY
 bufW6MPrmeBQEwMHcytqtfO+dc8S0FjMUSkXuf2oEx1GFUKM5GQcVS5QMLbSaZvtpseHqc
 xo9+gazY/BnOCgCCI8klKJtuh64u+AW6zsM4YyQkF9R4fKAa2xCD15otmTlQDQaG7iqzBM
 ulnAnQPcWj/0+r5RKFHpy6cUJVPpLK5pM/z42uEdJA6hjT1RKF+pU3m4TXW04bUM6T0/wn
 AVSOU6NnnWCFP8n2jBbtVWuY7Ouq/yT9KcsssIyFAjfed1stGydW021RXUrAAw==
Subject: Re: [PATCH v6 00/31] Fair(er) DRM scheduler
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, phasta@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>, Leo Liu
 <Leo.Liu@amd.com>, Lucas Stach <l.stach@pengutronix.de>, Matthew Brost
 <matthew.brost@intel.com>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Michel =?ISO-8859-1?Q?D=E4nzer?=
 <michel.daenzer@mailbox.org>
Date: Thu, 12 Feb 2026 11:04:31 +0100
In-Reply-To: <12fc3ede-d9af-4d32-8ea4-822a9b93627d@igalia.com>
References: <20260128110806.38350-1-tvrtko.ursulin@igalia.com>
 <7fcca1f49427e0279a740b6c1b9bb072eabc2c35.camel@mailbox.org>
 <12fc3ede-d9af-4d32-8ea4-822a9b93627d@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: a2897b8507150d29d18
X-MBO-RS-META: 3k8xdaneq55s1rsmkthjjeg81odkzk78
X-Mailman-Approved-At: Thu, 12 Feb 2026 13:41:22 +0000
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
Reply-To: phasta@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, 2026-02-12 at 09:56 +0000, Tvrtko Ursulin wrote:
>=20
> On 11/02/2026 11:08, Philipp Stanner wrote:
> > On Wed, 2026-01-28 at 11:07 +0000, Tvrtko Ursulin wrote:
> > > ** NOTE:
> > > =C2=A0=C2=A0=C2=A0 First three patches have been already reviewed and=
 are conceptualy
> > > =C2=A0=C2=A0=C2=A0 independent. But as the code conflicts, I am inclu=
ding them while waiting for
> > > =C2=A0=C2=A0=C2=A0 them to be merged via amd-next, and until they per=
colate back to drm-tip, in
> > > =C2=A0=C2=A0=C2=A0 order to avoid having to maintain two separate pat=
ch series.
> >=20
> >=20
> > So your intention with this v6 is just to get more reviews? What is the
> > purpose?
> >=20
> > And since the plan is supposedly that the drm_sched maintainers take
> > it, when will they know that it's ready now?
> >=20
> > Can we agree on delaying a v7 until all lights are green?
>=20
> I am waiting on Christian to merge the first three patches via amd-next.=
=20
> That is pending for a month now and in the meantime I did not want to
> send this series and have someone tell me it does not apply. If by a=20
> miracle someone actually went to try and give it a spin.

Then praised be the Lord, because this miracle has happened and I was
about to pull this series onto my machines and give it some more
testing and last reviewish look-throughs. That's why I asked about
applicability. Since we basically agree to get it in :)

> For the moment I don't think this is a problem for this series since=20
> there are so many more patches still pending to review. And based on the=
=20
> past experience you will not be merging it any time soon. As there are=
=20
> no design conflicts between the two, the review can progress just fine=
=20
> ignoring the first three patches.
>=20
> > For the future, I think the more canonical (and less confusing) way to
> > handle situations like this is not to include foreign patches into a
> > single-topic patch series, but to hint in the cover letter at the
> > situation and provide links: "Series is blocked by [1], [2]".
>=20
> Again, like that it wouldn't build and no one would be able to test it.=
=20
> For now just skip the first three and focus on the rest and hopefully by=
=20
> v7 I will be able to drop those.

I'd say postpone v7 until the merge conflicts are resolved. Maybe ping
a few of the driver maintainers. I'll also look through it one more
time.

Then hopefully v7 will be mergeable.
(and please no unavoidable changes like merging or adding patches for
v7, except for addressing review feedback)


P.
