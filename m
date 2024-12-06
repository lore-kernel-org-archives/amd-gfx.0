Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718EFE77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 14:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2575D10E1CF;
	Fri,  6 Dec 2024 14:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PAu81/D7";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52EE110E1CF
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 14:40:58 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ef05d0ef18so295768a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2024 06:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733496058; x=1734100858; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPDJdyQRv4onUlpexog3hCM1MU7WTXgVg2j4AlQZ4BM=;
 b=PAu81/D76IEeUqS0AX+owVpATcn3Z5dKPjqzo4Pp2rigyqVoZKQuSSF8rsYxMTvFw1
 JmHT+7JcLswqWIn1omuJ5nq1xo5feDJ+PqqQMTg6gYTAxiWsEo1k/9Sa3YTRw5v3SQQF
 /HjvUUTCWKG4KHn0QRl1a+JqPMKdVOe493WDwmQP4l3Cl7VPCnM/vU6Yy71nCxHM3+vQ
 tM2dqclGBnoNuojVm7HW0kjM2EoYlSJR9x3We9NvnMhNO5G4RaOH1xRK2Dz3Vxi5yQsd
 f46wu5Hqwh76w7tXZ7xl6XA+jF/RbM7gLM+2n8RnozB7r/y4eLiay09ug/Q0RUJB87ew
 PiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733496058; x=1734100858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPDJdyQRv4onUlpexog3hCM1MU7WTXgVg2j4AlQZ4BM=;
 b=uEsqg6M+4l7gu2bV0m0P86xAJskekLFo4SbrHGuYnKi1eTFICUL0y19M8QV2lCZ9N2
 c4dOO0m2K47euFsQ7h9cX64KlHuGvKHs7o+N8a6qR8Av/NPZgLF5URHmB3L1GqRW13Yw
 PcXFkRzpTKJgpofIa2fFBCqW7nLkUQOAFTVzFDj36bScFQ08lDBUAyzJyfZdzSNoPpqe
 uXrhgIMoc1gpqiaZRBfXZQ+H41kzrf/Axfx3mesFOtE87n/apVHiyCZtXAoDqTB2Ae3n
 Z4haOftwJ6hm7c6LfHzvR+GxgSbd7C4CmZZ0pC7hHIN1XO/BmY73DETcIO0O5Sc/Fhh/
 YeQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4Ss++Kw5SwImArEN0vsinSDuWD0VlBYEBRuSIOEygZE5pPd9tzCNDu+Og084tSyV9GCod7fiT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygSFRVVwfo2seoT3vzjx5Mnq9di9XnsAe//tBtTWw4eWsbizlq
 YwGAFnO2B4Sein6iH/iN3mXy0bvU46pCkmN5CN+s51xZIzOiWKT0WDcSrDyt93xYn/hnzNXQqfP
 ms3Qo4yXCCG4euhcBy7N77lVlFH4=
X-Gm-Gg: ASbGnctssq+dPN9jF3CZAAqEb5P3f9GE20Qyi0ALUx9wzPcSgF+7oVE3WMxfBNMyewY
 wefLdOcIgvJQadVRao1PCodrDMMhEwdw=
X-Google-Smtp-Source: AGHT+IG3TLW256ZtwbWhbq6+ydHUo9IwgGDVd0zrAnqIWVF9hTbu2sBxki1ci7guTYzhZY/xzMoyz1UArtQC+IKNQUk=
X-Received: by 2002:a17:90b:3e81:b0:2ee:cbc9:d50b with SMTP id
 98e67ed59e1d1-2ef6aaeb7d3mr2011986a91.4.1733496057708; Fri, 06 Dec 2024
 06:40:57 -0800 (PST)
MIME-Version: 1.0
References: <20241206143537.2272-1-christian.koenig@amd.com>
 <CADnq5_Mvt5nSa-JMDeYbF=hkn_0Mx2xOXohUgL9JWCs2q1kk7A@mail.gmail.com>
In-Reply-To: <CADnq5_Mvt5nSa-JMDeYbF=hkn_0Mx2xOXohUgL9JWCs2q1kk7A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Dec 2024 09:40:46 -0500
Message-ID: <CADnq5_Ohk8CX8c+5rEaWPPSCD44MMG484F_b+zT4hhjkQde0Sw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix when the cleaner shader is emitted
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: srinivasan.shanmugam@amd.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Fri, Dec 6, 2024 at 9:37=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Fri, Dec 6, 2024 at 9:35=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Emitting the cleaner shader must come after the check if a VM switch is
> > necessary or not.
> >
> > Otherwise we will emit the cleaner shader every time and not just when =
it is
> > necessary because we switched between applications.
> >
> > This can otherwise crash on gang submit and probably decreases performa=
nce
> > quite a bit.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Would be good to get a fixes tag as well.

Alex

>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 68dd4130b5ad..db913d533898 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -674,11 +674,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
> >         pasid_mapping_needed &=3D adev->gmc.gmc_funcs->emit_pasid_mappi=
ng &&
> >                 ring->funcs->emit_wreg;
> >
> > -       if (adev->gfx.enable_cleaner_shader &&
> > -           ring->funcs->emit_cleaner_shader &&
> > -           job->enforce_isolation)
> > -               ring->funcs->emit_cleaner_shader(ring);
> > -
> >         if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync)
> >                 return 0;
> >
> > @@ -690,6 +685,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, stru=
ct amdgpu_job *job,
> >         if (need_pipe_sync)
> >                 amdgpu_ring_emit_pipeline_sync(ring);
> >
> > +       if (adev->gfx.enable_cleaner_shader &&
> > +           ring->funcs->emit_cleaner_shader &&
> > +           job->enforce_isolation)
> > +               ring->funcs->emit_cleaner_shader(ring);
> > +
> >         if (vm_flush_needed) {
> >                 trace_amdgpu_vm_flush(ring, job->vmid, job->vm_pd_addr)=
;
> >                 amdgpu_ring_emit_vm_flush(ring, job->vmid, job->vm_pd_a=
ddr);
> > --
> > 2.34.1
> >
