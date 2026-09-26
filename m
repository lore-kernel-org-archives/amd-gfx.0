Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF0BC98332
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Sep 2026 13:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1885410E393;
	Sat, 26 Sep 2026 13:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XjUs3tMb";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24F610E393
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Sep 2026 13:21:24 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2af876539fso143118766b.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Sep 2026 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790428883; x=1791033683; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kBaWipxq8/5kX92ZsGODEl5WsEwUq1e+qktpLgVdfh8=;
 b=XjUs3tMbIw/x9OVpItpgBaoeqY2dXPjwF2eLKJWVWZPq5Ttj7WMQoHMVLTsFbY58wb
 Bdk50JQMh2m5WL4JtsQgv+9oH3vAqnI1wAwrhRgtDET4BDo+fT9crOuO+qpBsN0+OfYU
 aRQEOr6ZeBpw6/GHu6P0za7ntEa+YBwxMoTZkMF1ynlrnkgNdTArw3sf8MQkQPGL26MK
 INt8fz7cOiS8/d49sj/pCeZ+DBtkenaFKdZHdvvCEGyULS/5Ac2mDwy2M+eeGWWazYzs
 ntLLMIyGqF3rEzkyUSSw9PGpeUKKNLDQVtsAfGdAm7RyUHwR3gctU8DqKnarkQ+2iMtU
 bXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790428883; x=1791033683;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kBaWipxq8/5kX92ZsGODEl5WsEwUq1e+qktpLgVdfh8=;
 b=VP07/C6uGuNO65yPR+A/nbrUzoYGdukddyLzil9JUrgI1M/+Ray5xnizKtIYi95QxY
 bsZ5ccg5WYLMaFQ4he+j2w8IgmgwErht19k/CCeCZaNElOBwzOcvJZyEbmdzdUrHWV6g
 kIXb3nVKwyoxl9+vnCk9XHn7KS8OPxp1hwNA0e2zCb3qRWVPJOb6RpdkAoYhcR/1Nmkg
 0AFiloP+2WjT1DSLRcZBAfBXW+9JvNkcReSLq34WCkLZ5T5KO83ROHNXeJjvam11P9Ze
 tpmIpYPtuEOYsByde5HTpqeJ6kSDsCj9RBX5QUXlIAmi0bd30Y8LWaT1/0PLuHLRCNBy
 NyRQ==
X-Gm-Message-State: AFuF++kQegS2PfNWVck4p6QkExu6zJhVpZX8pMzR0Bgksnh/buJUXA24
 0nPFeTWp9j/KT+AKVcASoPuFpHEqNNZeS5SAw3bTU+unzmWnqHjsIpe9
X-Gm-Gg: AYBFou3R2xdHdCZSlBsh6lqZ/z/8Uqqz/6PLPP26XI4zvsW0p7ysbzCRnsBd5mch+5Q
 J5Ta99PWWgBZmF2u69VGndClh9ZtuQhZ3/UkMYLtikrjt/Kkaga+qOSEGOrgimX7h+g5T+PoGM3
 kuGicf9olf8tvugGupdsWnNkhfsn66h+x8XefSrKKyMtYLwtALMHotBt9jEN5G3hJp/KLX3n8NJ
 vnsVypZVeIRTWpD7sWO/XEyPpAoUVPQe9pOY3CrjDKFHwRx+nzzCWhf2DQyLhKra8Xt+1K3jAF1
 /EZjwG1l6HqOW3GdRydMB8lESOBTqjr0/vLRiei8sgEzM2yQ5hteFDXNsPTNMwNxK4yLvV2MVCG
 WWM1IoiabhEsmB8ZtMT1phaB2h96lpymi4G09/ssvqQIWt/xpX+AIB80G/HvVopnDKbOHxEZadu
 En8gsaXV0kkN4FFJn77LkdpVuw47qtl5UdZnG+hE9a0MDTPYrRNAx3IA5PeguiUz6VI+NXzPn4E
 stVhDEVAMFScL2ySCfhESVQG9+yUJ8I4ER1GNItrrPQy2Y8BNj7
X-Received: by 2002:a17:907:e8d:b0:c20:af9d:4533 with SMTP id
 a640c23a62f3a-c2ae97cc883mr396016766b.19.1790428882881; 
 Sat, 26 Sep 2026 06:21:22 -0700 (PDT)
Received: from timur-max.localnet (netacc-gpn-7-134-151.pool.yettel.hu.
 [176.77.134.151]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2af3128c48sm172812166b.3.2026.09.26.06.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 06:21:20 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 00/12] RFC: drm/amdgpu/sdma: Refactor SDMA v4 and older
 functions to be per-instance
Date: Sat, 26 Sep 2026 15:21:18 +0200
Message-ID: <SJRPDjCmS32TuE5GdJ7FSA@gmail.com>
In-Reply-To: <CADnq5_PTpPaVgVN0RbebrxcGDTHKEeLm-LQDhi5Ofn3dTG5t0w@mail.gmail.com>
References: <20260907203316.159103-1-timur.kristof@gmail.com>
 <CBgaIVTsRE2O7KG28C_9bw@gmail.com>
 <CADnq5_PTpPaVgVN0RbebrxcGDTHKEeLm-LQDhi5Ofn3dTG5t0w@mail.gmail.com>
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

On 2026. szeptember 16., szerda 22:23:42 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Alex Deucher=20
wrote:
> On Tue, Sep 15, 2026 at 1:23=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof=
@gmail.com>=20
wrote:
> > On Friday, September 11, 2026 9:00:07=E2=80=AFPM Central European Summe=
r Time Alex
> >=20
> > Deucher wrote:
> > > On Mon, Sep 7, 2026 at 4:40=E2=80=AFPM Timur Krist=C3=B3f <timur.kris=
tof@gmail.com>
> >=20
> > wrote:
> > > > This series applies on top of my previous series:
> > > > "Improve existing SDMA queue resets" (currently under review)
> > > >=20
> > > > Prepare the code for implementing recovery for
> > > > SDMA v4 and all older SDMA (and SI DMA) versions.
> > > > Reorganize the SDMA 4.0 code so that the functions that are
> > > > responsible for managing the SDMA engines take an instance ID
> > > > as an argument.
> > > >=20
> > > > This makes it possible to manage the SDMA instances
> > > > independently of each other, which will enable us to
> > > > also use these functions to implement resetting and
> > > > recovering them independently. (The actual recovery
> > > > implementation will be in a follow-up patch series
> > > > which I will submit after this one is accepted.)
> > >=20
> > > This series looks fine to me, although I think I would prefer to apply
> > > it along with the relevant soft reset changes to avoid churning the
> > > code until each family is ready.  E.g., apply the cik_sdma refactor
> > > along with the CIK soft reset support, etc.  Unless you have something
> > > else in mind.
> >=20
> > Thank you Alex.
> >=20
> > My plan is the following:
> >=20
> > 1. I would like to first refactor the functions for every SDMA IP block
> > version to be per-instance.
> > 2. Then, I'd like to improve the soft reset code, more specifically the
> > multi- ring reset helpers and amdgpu_device_ip_soft_reset() to make them
> > aware of IP block instances and change SDMA v4.4.2, v5.0 and v5.2 over =
to
> > use that code. 3. With all of that out of the way, it will be pretty ea=
sy
> > to hook up the same soft reset mechanism for SI, CIK, VI as well.
> > 4. At that point, we should also consider if we want soft reset for SDMA
> > v6
> > and v7. Technically these versions support proper queue reset through t=
he
> > MES, but in practice I've seen the MES fail so often that I wouldn't
> > consider it stable.
> >=20
> > This RFC is basically a prototype for step (1) and only takes care of S=
DMA
> > v4 and older just to show how I imagine doing the refactor. If you like
> > this direction, I would like to do the same for all IP versions before
> > moving forward with soft reset changes and other refactors. I prefer to
> > do this first for all IP versions because I think it's important to have
> > consistency within the code base regarding how the SDMA is programmed.
> >=20
> > What do you think, would that be OK for you?
>=20
> Do you have a PoC working on at least one generation based on the code
> restructure?  I guess I'd rather not restructure everything until you
> know the end result actually works for what you are trying to do.

(Sorry for the late reply.)

Okay, that sounds reasonable to me. I will get back to you once I got it fu=
lly=20
working on multiple HW generations.

Thanks & best regards,
Timur



