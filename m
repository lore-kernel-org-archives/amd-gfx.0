Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F048AC79FA0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 09:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8C910E0B9;
	Tue,  8 Sep 2026 09:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BQNlrMd5";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A6010E0B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 09:32:43 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so36009085e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788859962; x=1789464762; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PK45U7tsNj1wK5eIxKWxdnWdGZ6BFKQXEIg8g26ZUL4=;
 b=BQNlrMd5bngNs02jbYWc91H0K4UNk/IRi0Wq4GHWvJMo5SiMdhQWJZszL286h2I+zR
 9magoESsLdoVzrhc/VytWoL70FOmIH6LSHTvPwRz7c5ydd1EBiETVKDWAA731JYIfyrg
 qiNkmMvrR+wKYTzyi4rij1SYqt1gG+qjRWMXPoDrAXj6dHZIJKer2Ypbwv6Gf65ek6Cx
 G+fUp++wm5ClAAlGkDGkDGJPIa4jFx2Divg635icIZjjYBwT4qhMZchIALyFe3NN5DSH
 HnuAH3gVdmsjxtIYetM7s3wEy1Yo3cEfME1nKXUJyQ6dbkj+2ymVTlKLsTI08MPDuiQ8
 BWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788859962; x=1789464762;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PK45U7tsNj1wK5eIxKWxdnWdGZ6BFKQXEIg8g26ZUL4=;
 b=f4eA8nZ4Oz+dy0q1RNj+B+cWf66Vtlkit7oTOjqD2Y2QZMbX/Mu/8zkeWuJFJSXSw5
 0a3L9P2lEh5wJNutppO29Bda6nzpITJT/Bh6v09d5YkRHSk8EVVZtLnJ4Cbem3kx17nx
 9mF+TQJlqz+qewZVEJcFLC+VstKVwhqhmBlw5LIaUcGP8qet8GsX/scdBF8ivEFmQmNv
 Pasa2PE49DimxViGh3XT8vMcQaVbWVEsvA+00TWmtTmYlZ8mOF4TEmYJ9zLT+ESZfRdl
 afDMO1mAQI2ew7kXQf0j+Jc6kkVNLI6egqRwbmls0qfEhGmvGkb5Jcnv3xsU2oGFbrU5
 OpNg==
X-Gm-Message-State: AFuF++lEoY4y2m11AsFILY7SCPHohm57+ICN4pBzZzkzmehDTZpu/ITV
 HcLX2rrhWokQu0XsfUYL4UMQiHrWsqlKoazeR7gZk7qiK0NiNNwu4O0VUA6+wH6r
X-Gm-Gg: AYBFou215kOj+GWjyzKfluBXONdcsY8jS2m6wqqpUj6g3JFdfIk7Mrp4ib8h/TLBwdg
 d5wXAzt4ss1+eXh5Q1NNYtcLvs+uph2CNXVjgdhgIPmQeRDF9sBLTaAtJe2n6A09+PXJ8Q1GBWQ
 toh+OXKKVZgU1JyFnrjo19+NAik30FDIAQzQyKxaLP0DSv49YT9lqVG0JtKQDLuaNSXEVyOVKUB
 WvLe97c+QGZVojsn8ttJYcz6flM1Kh1gWy3RrgweEhYZzBPVsmR8Cs7Z46g2WtNhW7hSZ2gyIef
 yC116suBlyro6cA2WCYb218wKDR5nP2zwkjPDBX79J/+G/riJARDdH8YLb9vQnvexne/F+tJ1t0
 U1aV5uygx8xqGKh6nYDZi8Rcf8gvumJcCJXjImFrgekKPfoOpN0HphsowYkZf1j3lPwh9J55pA6
 PyV3Pju+Ez7ZCRxMejIZhAH1Ii8OmmbJcYndVxSgdgEpT9nafiCOLzmOiGmDmpt/bG2mvV/b3H2
 fjeaqSqK7pBmyBhF9LGcjrhrcYdtMBL
X-Received: by 2002:a05:600c:8706:b0:49d:191b:88be with SMTP id
 5b1f17b1804b1-49d191b88e2mr40776565e9.0.1788859961838; 
 Tue, 08 Sep 2026 02:32:41 -0700 (PDT)
Received: from timur-max.localnet (athedsl-4460056.home.otenet.gr.
 [79.129.254.8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d057f4778sm277565035e9.8.2026.09.08.02.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:32:41 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [RFC 1/2] drm/amdgpu: Store SDMA instance and index in the ring
Date: Tue, 08 Sep 2026 11:32:38 +0200
Message-ID: <F3N0UX71T9uRTCKIeAarRQ@gmail.com>
In-Reply-To: <76000248-b0ac-478d-bb13-45d4eebb1676@igalia.com>
References: <20260622143649.54632-1-tvrtko.ursulin@igalia.com>
 <15g9zLryTPO4j32E_pIEBQ@gmail.com>
 <76000248-b0ac-478d-bb13-45d4eebb1676@igalia.com>
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

On 2026. szeptember 8., kedd 10:54:04 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=A1=
ri id=C5=91 Tvrtko Ursulin=20
wrote:
> On 08/09/2026 09:42, Timur Krist=C3=B3f wrote:
> > On 2026. j=C3=BAnius 22., h=C3=A9tf=C5=91 16:36:48 k=C3=B6z=C3=A9p-eur=
=C3=B3pai ny=C3=A1ri id=C5=91 Tvrtko Ursulin
> >=20
> > wrote:
> >> Instead of searching for the matching SDMA instance inside many of the
> >> SDMA ring vfuncs, lets just cache the instance and index in the new SD=
MA
> >> specific section of struct amdgpu_ring. This converts a function call
> >> plus
> >> array walks to a direct lookup.
> >=20
> > AFAIK, the rings already have the IP block instance ID in the "me" fiel=
d.
> > So this could be simplified by using that. For example like this:
> > https://pastebin.com/raw/jp4Uk2sE
>=20
> Ah thank you, it never occurred to me ring->me is not a management
> engine of some sort but ring's personal pronoun. :)

I think the field should be better documented. AFAIU, it refers to the firm=
ware=20
instance that handles the ring. For SDMA it's the same as the instance ID.

(For graphics/compute this is the "micro engine" CP (command processor)=20
instance. There is only one graphics/compute IP block and there are several=
 CP=20
instance within that same IP block.)

In your words, "on a rainy day" we can write that documentation or just ren=
ame=20
the field to something more meaningful. :)
=20
> >> While at it, we also consolidate the initialization side with a new
> >> amdgpu_sdma_ring_init() helper.
> >=20
> > Can you move that part to a separate commit?
>=20
> Yes that makes much more sense indeed, will do.

Thanks!




