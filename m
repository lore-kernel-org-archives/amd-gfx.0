Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40E1C982C1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 20:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228AD10E0EE;
	Wed, 16 Sep 2026 20:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YKmEKWzQ";
	dkim-atps=neutral
Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com
 [74.125.227.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A3E710E0EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 20:23:57 +0000 (UTC)
Received: by mail-vs2-f41.google.com with SMTP id
 71dfb90a1353d-5c656140de2so4462e0c.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 13:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789590236; cv=none;
 d=google.com; s=arc-20260327;
 b=Vs2FEGQEZ5HLo5F+W884k1y/+I96wvnTCf70mZHijgXJt1GfcMaJyO9asebEEjmTH4
 obVObJF09HM3z0frrBf1Kv+8czTrXiMwkLj3fsJS86AuvW7mbp8fwuN4L2R9dTe90zKI
 xIKoLWmHcX5l2lyybBsn6jdR1qc/oVTpJaYgMLHywbXLEr0CNfkU2sJtfCyo5f16XSbJ
 uLGlgKpbgERdAx0nt8lZC6l8kWHvawV6WUAQZRYGH+tBMhmQ9qfof4XREHsh7N0sVQMm
 eyH4wQvU7GCZ3ZbGC81kanoRCyZ8NrgHteJEgOcKqZKuHLM1cQm21prK6MIzKUAkwqb9
 wpxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lf2G0SGKGXkr+6mqsAjDj30DpcoNvZp4SkSXZZaDHo4=;
 fh=MV8xSw5YdrK5iIewyHRxo4ax7j3M5t3LyeF9RNB5UuI=;
 b=QoTli5z+pJXlwQEX+Ey/dk/aY2Q45Cwl4t3/MonDDCNFKm8llDaKREz10tC7+ovmZ1
 roGjXh43RW3eB8OP7XYhxw3WEr6YaVaVPg1TPA+AFL7JMgC/cSrmad9goyJgdbC4AwIZ
 hgmHGp0cNrplXZ8Ib8N/Y7aSY3YuZkJpKUu/58WrVVaOhGlhDryYPPsWvBdmvtEMqjRO
 fw8N44oG4Astcp8JFLvJMGZ3hzokeSwNRBC4GmrtQuoS9bOOldXHKhfsIKBNbi2c1gXR
 uhtbvoZAkH726ULFFVcdWNG2gTOmB2lZvya5w7Yeit9azbOvZAnrQatab+OHXufiqDS0
 2p4w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789590236; x=1790195036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lf2G0SGKGXkr+6mqsAjDj30DpcoNvZp4SkSXZZaDHo4=;
 b=YKmEKWzQnMm+LNM0oc1wvvdw/alWvWsj14aHg9OvJ6GY4/kmZxGDsr6ZFkeilPH/QQ
 gjr5jHkzUNc51DWCC/VPiSoahZ9t882Yf5NNWBVFYqSIZL4QEcyHrEbyiOP9IzkU9MW6
 uSUdpYxXhK4ueuPa1LNbgeZrlPTt7fYCRpKX3n1PMhYWsGIF5UjdSJNJhwX05ECItoHc
 aY1k8VfphXtRXzyo9oCSdGDywDIA0s364Wt8UJty/oq1MjDn4nlUewAclygTMIbbmEKf
 GPREFQoSpnMSJc53GJct9I+mRwgvxKq5k6SkZC/FhyYYYjI2k8FAPvRh8VdcKKzH+MOS
 RNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789590236; x=1790195036;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lf2G0SGKGXkr+6mqsAjDj30DpcoNvZp4SkSXZZaDHo4=;
 b=L48YDEclF2YDXqPDFrFoMK0HKE7GOrpmEAQ6hiHFdYfJjs9ftG1tvmcWlR3U9yafZo
 9sNS49Rz0l9bAKu/ll8Zf7x+PI6B5Xsg1tCm3weuULNunu5dW8+fPqp/MgIIjnrFF997
 Eg53ut4vGrTzrE+L+k7eJuYifrbaR91fMKfdzFg62PYoUwu5lBnRDP9x0frw+hWQ8IyF
 RgkzHRiZBfdBX0y1S2k10u3Id2Q75fEMDurabMO3YBUKWyR6t3jKPBJMDIvncXk74MXI
 J4M7NRNEXTyYwE8PkJSBAGO9pJgBI/SJAPdTHsxSD1+vWwn5/zpbJ45fIBQ/kgRSW4Lo
 qr7A==
X-Gm-Message-State: AFuF++k/wYlbQh4mwdRQqtlrsNLBgk8oEQFndBWyUCfxBeGadW57kQGs
 WvLG1/HIOUayEWOjNLzbZ75oqpE66ldUJEIH+Mbx+dRWDd0tqwkDAcLEiF12edKgLFs9JnDmsXY
 STaEz8Ar/Sh2+e6uEOx/wLfP+3H4QNi0=
X-Gm-Gg: AYBFou0bw/sYyXzZhc/dGgP8sfKc8IrsT1J4mOB6VwY7sXfQ5sCV1WGhMECny/nwtB6
 dJjwApaIbeS/pzWAho9ocQzO2+YWAQu50jONj86PFU9IoKJAtAsEaV8CI7D1tYvmhMV3veHXwJP
 Y8uJZulLS3O9nteeRiGvHKCH9LIEjmmmRAk4qLkwXCmzZQEOG5LDblE+J+1oisRHkKwMsr2/Dcq
 mE3YdrEQCL4DsHRITQEG+6aKgtenrl20+wsxbf2JpS3WudoNwMzennlwA3HiZUxRuB3gcX1Sr25
 Tp0zl+2f6aBWVOaogWsuLjJu5Apere9gEJViZBRkDdTJoJA0ClTh9ghZpGoca8yjYm7O4nwLhjY
 GKVaJ2fnJDNdMpgD8YB2cRf6/l6XiRAx3tfPF/2Xgsw==
X-Received: by 2002:a05:6102:2268:b0:7a0:f7cc:5039 with SMTP id
 ada2fe7eead31-7a0f7cc5801mr1111639137.0.1789590235885; Wed, 16 Sep 2026
 13:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260907203316.159103-1-timur.kristof@gmail.com>
 <CADnq5_P_cVmHqd5sB6vwGqYA6jSY_fY6EWQp+WofptCgC8nRLw@mail.gmail.com>
 <CBgaIVTsRE2O7KG28C_9bw@gmail.com>
In-Reply-To: <CBgaIVTsRE2O7KG28C_9bw@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2026 16:23:42 -0400
X-Gm-Features: AcwNN1U-EvTGeH9MwtaxzGAGqt6v0sjKiHLeUOEMTLTpLVg4KKuih3En9H1amRw
Message-ID: <CADnq5_PTpPaVgVN0RbebrxcGDTHKEeLm-LQDhi5Ofn3dTG5t0w@mail.gmail.com>
Subject: Re: [PATCH 00/12] RFC: drm/amdgpu/sdma: Refactor SDMA v4 and older
 functions to be per-instance
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com, 
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>
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

On Tue, Sep 15, 2026 at 1:23=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Friday, September 11, 2026 9:00:07=E2=80=AFPM Central European Summer =
Time Alex
> Deucher wrote:
> > On Mon, Sep 7, 2026 at 4:40=E2=80=AFPM Timur Krist=C3=B3f <timur.kristo=
f@gmail.com>
> wrote:
> > > This series applies on top of my previous series:
> > > "Improve existing SDMA queue resets" (currently under review)
> > >
> > > Prepare the code for implementing recovery for
> > > SDMA v4 and all older SDMA (and SI DMA) versions.
> > > Reorganize the SDMA 4.0 code so that the functions that are
> > > responsible for managing the SDMA engines take an instance ID
> > > as an argument.
> > >
> > > This makes it possible to manage the SDMA instances
> > > independently of each other, which will enable us to
> > > also use these functions to implement resetting and
> > > recovering them independently. (The actual recovery
> > > implementation will be in a follow-up patch series
> > > which I will submit after this one is accepted.)
> >
> > This series looks fine to me, although I think I would prefer to apply
> > it along with the relevant soft reset changes to avoid churning the
> > code until each family is ready.  E.g., apply the cik_sdma refactor
> > along with the CIK soft reset support, etc.  Unless you have something
> > else in mind.
>
> Thank you Alex.
>
> My plan is the following:
>
> 1. I would like to first refactor the functions for every SDMA IP block v=
ersion
> to be per-instance.
> 2. Then, I'd like to improve the soft reset code, more specifically the m=
ulti-
> ring reset helpers and amdgpu_device_ip_soft_reset() to make them aware o=
f IP
> block instances and change SDMA v4.4.2, v5.0 and v5.2 over to use that co=
de.
> 3. With all of that out of the way, it will be pretty easy to hook up the=
 same
> soft reset mechanism for SI, CIK, VI as well.
> 4. At that point, we should also consider if we want soft reset for SDMA =
v6
> and v7. Technically these versions support proper queue reset through the=
 MES,
> but in practice I've seen the MES fail so often that I wouldn't consider =
it
> stable.
>
> This RFC is basically a prototype for step (1) and only takes care of SDM=
A v4
> and older just to show how I imagine doing the refactor. If you like this
> direction, I would like to do the same for all IP versions before moving
> forward with soft reset changes and other refactors. I prefer to do this =
first
> for all IP versions because I think it's important to have consistency wi=
thin
> the code base regarding how the SDMA is programmed.
>
> What do you think, would that be OK for you?

Do you have a PoC working on at least one generation based on the code
restructure?  I guess I'd rather not restructure everything until you
know the end result actually works for what you are trying to do.  At
the end of the day the restructuring is pretty minor and it more or
less mirrors what we already did with VCN, but that restructuring got
messy in a few cases.

Alex


> I understand this causes code churn, sorry about that.
>
> Thanks & best regards,
> Timur
>
> >
> > > Timur Krist=C3=B3f (12):
> > >   drm/amdgpu/sdma: Refactor SI DMA functions to be per instance
> > >   drm/amdgpu/sdma: Refactor SI DMA clock gating functions to be
> > >
> > >     per-instance
> > >
> > >   drm/amdgpu/sdma: Refactor CIK SDMA functions to be per instance
> > >   drm/amdgpu/sdma: Refactor CIK SDMA clock gating functions to be
> > >
> > >     per-instance
> > >
> > >   drm/amdgpu/sdma: Refactor SDMA v2.4 functions to be per instance
> > >   drm/amdgpu/sdma: Refactor SDMA v2.4 golden registers to be
> > >
> > >     per-instance
> > >
> > >   drm/amdgpu/sdma: Refactor SDMA v3.0 functions to be per instance
> > >   drm/amdgpu/sdma: Refactor SDMA v3.0 clock gating functions to be
> > >
> > >     per-instance
> > >
> > >   drm/amdgpu/sdma: Refactor SDMA v3.0 golden registers to be
> > >
> > >     per-instance
> > >
> > >   drm/amdgpu/sdma: Refactor SDMA v4.0 functions to be per instance
> > >   drm/amdgpu/sdma: Refactor SDMA v4.0 clock gating functions to be
> > >
> > >     per-instance
> > >
> > >   drm/amdgpu/sdma: Refactor SDMA v4.0 golden registers to be
> > >
> > >     per-instance
> > >
> > >  drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 322 +++++++-------
> > >  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 232 +++++-----
> > >  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 561 ++++++++++++++---------=
-
> > >  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 577 +++++++++++++++--------=
--
> > >  drivers/gpu/drm/amd/amdgpu/si_dma.c    | 160 ++++---
> > >  5 files changed, 1043 insertions(+), 809 deletions(-)
> > >
> > > --
> > > 2.55.0
>
>
>
>
