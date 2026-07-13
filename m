Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D11AC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 11:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E16E10E5AF;
	Mon, 13 Jul 2026 11:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rsup9S9t";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D07E10E5AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 11:17:03 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so25970765e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 04:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783941422; x=1784546222; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oRRNF2ESU8NTcJ4SNxj8LX6R/C6cJrDA6k8ZaN6Vkq0=;
 b=rsup9S9t2mmAQsWGyTGkiWqI+XUZRfFFYxWFKbDLMxTw1iMKG/Nvtlu8j3TJhBzpO4
 eu3B5eYs7EuYCKee3oFu/AFHXPMoGf0XcUAaJ+awzCPtKcMpWfr+bn6UA2BZqwGY2iLv
 azRsF8GvRjQW/7Q0WwlOQQYmtsGgWT7+DehRKp76wArSgx1zVZ7yE96DvXUWuEr4EUsJ
 h6+fU5tXHZysCU6ndtq5ovCSMM4yaAyR+8GZad7dugpq+G4YtNiacouTysWIohU/2Hp4
 bC7Cyjo7EU4Le1My96h/h7nRUPUf113pqqeJPn6ujl1kpqQD7jznWGNzEtn9mLV9byzl
 UAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941422; x=1784546222;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oRRNF2ESU8NTcJ4SNxj8LX6R/C6cJrDA6k8ZaN6Vkq0=;
 b=pwBH4NkReIfKo8Cigzdm2EOgV/W/35hn4S0a7XRtO2CeL6+NS9Xw/IP51zqkfa8Otx
 i+AoKNvwnR2e1WsSEjYY/ItAluaSXeW3aXrrJ/SUd+60jMgYa1ZlVOF3Ar+HTmIYia8B
 jj4EgAUa+f/qCcGy1WAxsA1AQnICGfOyRtFvQ1sav9GgJPQqqrKQNAJuth/1y0iiTR4b
 x0tDtflNCTZYzLj4OF++xjBkJITe5huH2mg9cc0IT3UfGHBV9MiRJMDVTPStlHUV0Vvm
 pBY6CiI0eeCXGK1062aRIUmWdVF5CqSRyG9X7oOZrzkyLgEsGhqsFZmpIqfOrYwoyWN1
 noNg==
X-Gm-Message-State: AOJu0YyE3xmvLR2PUgepckF3PWkaW4EZmVpQHzZvykeIcgSENCESD0Du
 xC8XqNprVXiosxVybhpMLHI9uELLo0FpkAIawa3QH2jynh9Al//TX6EsEWOFsQ==
X-Gm-Gg: AfdE7cmTwmcwdtcFODQqPJk/5/h8vz55iXNPbVJAisQOW/VZPZcO/4T4myJmtXuLCp8
 KxnP6RSxPlF5v2w2JvM5JZUiSdrjSRv5EaPKDcgBBy856bBWLjXxek9fojUm4vSgY71dDhmA4M4
 dOQq7yx5PcTk1iEAWsb9VQLh2ZdXTjTWbMQwEYVQg06szKRensJ/pmNki0d2Ha9xPZkVsLfj6tA
 irB/UuETkejcgsLd1afuzQTrYxVtiMACG/9KrnfK5nvsYgYWnv9xV8CBqjLmhZFHBnZF6GVGdzI
 dR6CKPUY7XyDR2fLCcHyFYEKjQoyxI1nfjpdBqn8r0Zn3rI6l/VcL4P1AVVXH+zFDMGQNYb9GtK
 uOyCGig1K9mL0JfCdiIhAxTA+eZRuv0KiIuE5nohqZp87hBMovT4+ZX0S8F83dKKmAKLGxF0oWy
 CfJ1GtJEjnOgdeCX+Gh/TG1y1+9j72jKKn0ljGHjS5CT+0RQ6y4D0rS1QcG/Q=
X-Received: by 2002:a05:600c:3b03:b0:493:f069:d205 with SMTP id
 5b1f17b1804b1-493f8818bb4mr84930315e9.19.1783941421682; 
 Mon, 13 Jul 2026 04:17:01 -0700 (PDT)
Received: from timur-hyperion.localnet (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8cdsm87564428f8f.1.2026.07.13.04.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:17:00 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 1/3] drm/amd/pm/si: Don't schedule thermal work when queue
 isn't initialized
Date: Mon, 13 Jul 2026 13:16:59 +0200
Message-ID: <tM3iYIRPQHWYpTCh4LOKcw@gmail.com>
In-Reply-To: <e00d5e54-0713-47e9-9f88-a177a1ffa474@ursulin.net>
References: <20260712173928.259701-1-timur.kristof@gmail.com>
 <e00d5e54-0713-47e9-9f88-a177a1ffa474@ursulin.net>
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

On Monday, July 13, 2026 12:25:38=E2=80=AFPM Central European Summer Time T=
vrtko=20
Ursulin wrote:
> On 12/07/2026 18:39, Timur Krist=C3=B3f wrote:
> > When DPM is turned off with the amdgpu.dpm=3D0 module parameter,
> > the thermal work queue isn't initialized so we shouldn't
> > schedule any work on it.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c index
> > 832953941266..6a54566d1a68 100644
> > --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> > @@ -7692,7 +7692,7 @@ static int si_dpm_process_interrupt(struct
> > amdgpu_device *adev,>=20
> >   		break;
> >   =09
> >   	}
> >=20
> > -	if (queue_thermal)
> > +	if (queue_thermal && amdgpu_dpm)
> >=20
> >   		schedule_work(&adev->pm.dpm.thermal.work);
> >   =09
> >   	return 0;
>=20
> I don't know this code but what is suspicious to me is that there appear
> to be other unguarded entry points to the un-initialized work. Like all
> the flush_work() calls and one cancel_work_sync() as well.
>=20
> Presumably as long as si_dpm_sw_init() is returning success when
> amdgpu_dpm =3D=3D 0 those two can get called?
>=20
> Finding the right Fixes: target might be a good thing too.
>=20
> Regards,
>=20
> Tvrtko

Hi Tvrtko,

That's a nice find. Indeed si_dpm_sw_init doesn't initialize the thermal.wo=
rk=20
when amdgpu_dpm is zero. And in fact the same issue seems to be present als=
o=20
in kv_dpm. I can address both of these in a follow-up series if you like.

Thanks & best regards,
Timur



