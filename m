Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4545C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 13:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 229BC10F1D1;
	Wed,  2 Sep 2026 13:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e8tWDBEa";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65BD10F1D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 13:08:49 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38eca09faa2so81976a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2026 06:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788354529; cv=none;
 d=google.com; s=arc-20260327;
 b=fDj9Z5zy7/7wMEiRyWUvUTnZ9U9oQWaZppTpO7U2R5gcLqCYHx26X8DaMPISjeRXck
 xcpuOmonBRju15Q/KOkne6hbHF6oogz7oO6rGEzPTzn70unIx31GnGsj6PFz7+Mem3Qf
 W0hP698sYWABIx3uuF81uk048un7ep9kRvwKwdvhBiEEtrtlLHS5BIM6536BfYs1xZeq
 Jl5/99DFROUMK+/DxwNJ4SZiE0EGN8n/io2+d3tV1nMYCK/i9g50FgJYOl9ak6aMTHdx
 jbzFimFZXZRfdW6vFaI6ndTpmjEsttuB4o2ZhFl+lIsdMd6xDDydjLjziXNzMwQiMUwB
 Aa9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=efWPR5dz05H/TCL+OhsdnOaYT0ttcrtK7l9T9g79Iso=;
 fh=bFNoRQU9i/NFBX/3MlpMi+OY1yizk/Jh+5bAIeRahO0=;
 b=BfWVyj+Z59fsRGCE0LtARU2IwfNxpyDyC3LNzaq0/PMnb5ebE2veEvCoj+VyGI+E1a
 1GZT/X0qOrafvr/U/58nyQToE2r26dwb8d50yeSZ2DZ5E6yl8pojjQF9VEMdRpl16Rhz
 8jhe829pC4it3/41/InqP1gSmy9atfdmKKmqR9tJdmChG5OLC4odVJRx7nWCjdL3ED7o
 LXNJIoQRT5507d2HruxhvIruCmjF3k/Y6QpbKiZ9HuGdPzQ8e++HRks8mJeEQNv8TM0x
 H7jT/VXkHVtzDWDIjF3zhezKBGZeaaSKdPT6ivLv9HlrzMT1lVxPhJgaX1kCVzHKbgDT
 DY7w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788354529; x=1788959329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=efWPR5dz05H/TCL+OhsdnOaYT0ttcrtK7l9T9g79Iso=;
 b=e8tWDBEaK44b4qRkFOGU1l0JKeCFWwyeDpOPUpcjeLbc5ZA+8Ue81F5iLAu/q60l7b
 Gzy0S57/orTeZ3u4By9ZRW0yo8feST4o3vDeo56kR6sRfxVn7QgG680wxObpYlGoJRO/
 HAtAGENrRAxH5GKJfsqgS6Ua9f2ZzIeUnBQM/9hp4rMv06kjwS4rYanh65llksFsQDc/
 gaPVXfOOAigwtB2A0cKA0A7la/DOjelxduxLnTHnEN7a4rIBet+vVhlRG3h1s0BEtQA5
 TM0tL2bwveRqNlG/XW/wB1OSeECwaLWIaVwpAoXJQmV4NHepyzGIe/OCcHyxALAB2Lpp
 6RcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788354529; x=1788959329;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=efWPR5dz05H/TCL+OhsdnOaYT0ttcrtK7l9T9g79Iso=;
 b=XTu7qqjiWyXx3Ye+DIIqf9IYmDu5D62v87BhBVpDldWENNnZkUaPYm7R6D+fgC4t48
 sT+B7yFZUEzqs53lVlYaQPNOAGzP3mwc40tXO2I75cbW/bPF5keYx1Dde9D2ytadVGVi
 5KAP4Lb/6iHWnjEGz9A9NoQzXOCk5bsLur2i8azQKCizx3SKBCMU/aab9GBddAJRDFCg
 6Ia77xgu0CKVt4rMg6wZjQogxvlDoSge3n7OsPhokboXlC9Uu8z9+LgJI24tNGb9/mx/
 9T6jmB63STvw+MBsD8MjlCZ1aLr5R1OdqpjA4MKslUQT8Lgdsd49lmLfnf7eNGyEP7Ci
 payg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKphxZAcS406U+mJAyXN32O562J9v94Dbutv6ALBgYWiUHYEt5viSsSA08PbqMd3CTtq1e1kya@lists.freedesktop.org
X-Gm-Message-State: AFuF++mME3fp6uUgaZojQAa2Vt38Sl96zmX9j7QOAIV/r/UYpPYjtcna
 GKUN04LSgdoTbBG3XTkw14zQDX4RlOQ/+b/Z94xxkSHPnqHa3O7XtBUbRzGbokIp6F1WI26B7EF
 rV8MrsiE0gTIMJjvKbec47KB1hjTR6WsCrw==
X-Gm-Gg: AYBFou2qIXefHGxWihvhipxMyERAu3xrr1bbH2CWQs+k5hEFnhhT5HdnJd65CH5vCyY
 plkOqAjYGscUe1Kz8ufKQoF2q+DSM+hpexcbSlySbJRBpfYAOm/UsIWNehvDdiOw2DjYj/6QlZl
 QJZP+N3XkVOtJK7jEzPNNqJkG1XYVXUTt/pWrvRvO/+PpDdpGntA5HTOK6PD8qEZYcJyH5rWacF
 KlSyu/F8HfTo4Q5nyjLV98Kg4qd7+WalycHNWKkWnRmUseQZivLObtGi1AtB2AgiqbGI0z8MwCH
 cjprEUgW9rQphMa1DPZXaDLpJBv49HeqZT4M3UF1YDLY1ldt8J9AOWsKaHslKV9p1m+8B7d9oiI
 YGCbdIn2ImwM5lpSm5kXkIiJKDT/R80M=
X-Received: by 2002:a17:90b:2d0b:b0:396:d27c:8696 with SMTP id
 98e67ed59e1d1-39aee1b6f36mr3966825a91.4.1788354529243; Wed, 02 Sep 2026
 06:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
 <20260901201034.2960437-2-alexander.deucher@amd.com>
 <e9266cee-bf04-4076-8e63-5f1fd497f929@amd.com>
In-Reply-To: <e9266cee-bf04-4076-8e63-5f1fd497f929@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Sep 2026 09:08:36 -0400
X-Gm-Features: AcwNN1VOydCIhHrBChSq6-z93IPfVTbcKODLw4MX8in4vm6pEhRRdbprQYyk0Pg
Message-ID: <CADnq5_P3tHa6EtLyok-+WoH06zHQR2BmqBJUfNXyNFDhuzMy4w@mail.gmail.com>
Subject: Re: [PATCH 01/31] drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Sep 2, 2026 at 3:35=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 9/1/26 22:10, Alex Deucher wrote:
> > We need to disallow gfxoff if we touch GC MMIO registers.
> > At the moment we use KIQ or MES for TLB flushes so
> > no intended functional change.
>
> One reason to use the KIQ for TLB invalidation was to avoid enabling/disa=
bling GFXOFF all the time.
>
> So this change here might work around GFXOFF issues, but that only hides =
the problems we have with GFXOFF and doesn't fix them.
>
> The same is true for all other generations.

This was meant to be a short term fix which could more easily be
backported on the way to enabling SDMA later in the series to work
around issues like KIQ dying when doing invalidations.

Alex

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v9_0.c
> > index b46b87291c512..80f1cf1f21736 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -808,6 +808,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_d=
evice *adev, uint32_t vmid,
> >               return;
> >       }
> >
> > +     /* disabllow gfxoff when we invalidate */
> > +     if (vmhub < AMDGPU_MMHUB0(0))
> > +             amdgpu_gfx_off_ctrl(adev, false);
> > +
> >       /* This path is needed before KIQ/MES/GFXOFF are set up */
> >       spin_lock(&adev->gmc.invalidate_lock);
> >
> > @@ -873,6 +877,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_de=
vice *adev, uint32_t vmid,
> >
> >       spin_unlock(&adev->gmc.invalidate_lock);
> >
> > +     if (vmhub < AMDGPU_MMHUB0(0))
> > +             amdgpu_gfx_off_ctrl(adev, true);
> > +
> >       if (j < adev->usec_timeout)
> >               return;
> >
>
