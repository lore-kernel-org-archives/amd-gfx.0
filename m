Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0B6C5CFC1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 17:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F17D10F6D3;
	Fri, 14 Aug 2026 17:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fD30MB0s";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B2AA10F6D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 17:29:05 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38f57e312ecso247660a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 10:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786728545; cv=none;
 d=google.com; s=arc-20260327;
 b=C+jGYwmBiFTSx64NzbVCCYBhE7U+w8+H6HAXNaZ8e+ztZcH7aeYdSJblE1S5NL2hQ0
 N2ydq+2O8ncarAhjb1gOStVHaGpvSunrVa9cM980Opy528f6CGP6ccoZeCElzsdUN74Q
 8cOAh4ncuwaHK6Wh9bn9VrCOq48GfxFtn/fa4WchPhc1sZ1pWCjz8LJyZc+9kMdSDhpH
 MwXArPu0j8plyv1nkMamJHgjTPTY0/K+nZbpcOZt597S3/q1rPXz1G+JkgNokMQCL7kW
 qasfywVW1vOhFG9qbXMVpuPLab9jG9JUf/UMLRAh77MhgfBAK6TyD4GJ3JevgXVFF2LF
 XOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L6lWVMiyqjiSuEbLnwYPaGVchnYCv576gE9qBCdVBvM=;
 fh=D6oavYGmJfjvNHEzIAGxYN+ZtVRKl3ejlLfn0w/Q+xw=;
 b=gQzEY8dExUWYObpzV7pi6Nz3x7O5CRncuxEiXoG/+3wsa0vupmeGoOellc9OR77+2U
 vtXysf3kjZsLEDIFHwwF/3eB+AZv0P+RkqFDH3H+uBT9NEQrVbhcn/ndrh+SbNCPNHrm
 jzG1XHgpCq9ffoNhG0ELY3N3AYNpBGvCNxUNRuCmv/K0ZmjYyNULOfHZeZPWh88i4nFU
 Y7Ewm1JLSRncQ4BcRSubyp5k/Ejne3WpFVEE+f7NyYs+tB+J+Nv9LcQTCGD2oT1In1W+
 od81dgIR/NxgIM2lGnj0LALUKinzLO07hzpza+wL7YCsm/0J+lJQv5ZMJLluc+HGYVYH
 1uHA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786728545; x=1787333345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L6lWVMiyqjiSuEbLnwYPaGVchnYCv576gE9qBCdVBvM=;
 b=fD30MB0sH542aog+OUm9BP0UFQD4618dEtYiyRkUnJ0yK9A5znNQURAwD8S858785f
 mVG6M7Sr8nH/NPnN468OOOJ4ltTKP59Lc5tF1llnYrLox1ErQ2spPPz7xqA+OtK3bGxI
 95l1Zb+llzgJIzorTTyR0syU0yTWBpBPJWheaQL4f0rj+Zn7LsFG2S5Lr8Pv8RKqR7Cg
 3RXcFFA6B+GJn5BNnPyQCTFmUIgNg/7wJUgQDXeBXzNxqfVb7w9OxTQ+54aNG8bHWq5a
 RfsHErIecdYSRc+12L7xgJ7HVkW0f8k3eoRAyC6MucDzdSb9wmI6mEbrAraLWCHSAV0k
 D9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786728545; x=1787333345;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L6lWVMiyqjiSuEbLnwYPaGVchnYCv576gE9qBCdVBvM=;
 b=pB6MvFMB89doayfdoWOWlxwg7eMB5s5MDl3HWqUN6ZAOymYIIgZpjyoOscyc5ln8f7
 5yC45nEdx1rtnvefr6fUBeU0yfZC1gSo3gBmCDtKYJw5Behfxh4xz1Qv0VAGNhZIDMlj
 5tOTGpt0m4F7LxouglRekAye4KtbwHlSBgEaLqEsMcZoHzGoMHrb+sBK1a5t/qoFJ62x
 39qNkAJkiaGLMAdHquq7U148fzrUKZCPjG1e5fhKXwn+RN7IMMKGPeE6FF+dwxmfGtNn
 S9AdBn/l6ipMdRgjaR2ZNrJnI1Q/HsQJhdCS6XuHUDrc7aK3X9VncyNq9HDGKxxoNMNe
 lM1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcY7aDkikDxempiWg/3O/yT095OTalwty2hSXWOQ5l6z8zOnFo9JCpSd8OyjtGz7snWEKYFrE1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6z/wZNcuLp6uRdlr+VGnxhLGprVRZDCA/aiOQ+I9dPLiovkZn
 1x3hFhCivKfNuVHRFMI9kOBM90nhzxbuGHU7t+oMoRkx99G10+qqYamI0balwhl420GXbk4sVfN
 Ed5nYma5BHb7S6IQEi/rWSsrlvzzp9IE=
X-Gm-Gg: AR+sD13ZmwXe120ZbFwtFROVVzTfSrdPZtKcUi8Q4K87ZWWV9C9n+SEuWGca7fk28SN
 mbMrzOyOclxHMELV/YPMINFTfx1/EXdzgPn2hTAQVXMtPp0YkEl7pr0P+LBAYhZA3gttAExFie9
 72bcin4igr31ovDELedm/gYGToPLj4oeI2zTVrJpAkUCpAt9xO3R6Cwly8rMuTUWHjRdtmQv4TU
 k4y3iRwPurZm+W+6kgx/MWHiqVFsVgZhMzPTekRrGJSpEGgFz4Hvl929dz+WM9fdk7yHDPqdEfd
 /pO999+V1NPyJ6vO35pjyZPY7YY6FdJw09VxwB27p60sfNeF6IRIXG6yUEgbCAkc5vh03OuUYyb
 cKdELJHX0oMOIJluUpPdkCDv+lXTffpPKi1LbkJ7O1A==
X-Received: by 2002:a17:90b:164b:b0:36d:b30b:14ed with SMTP id
 98e67ed59e1d1-3933b94fb5dmr5938451a91.2.1786728544802; Fri, 14 Aug 2026
 10:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260814154212.2688253-1-alexander.deucher@amd.com>
 <3af940dd-adcf-43d2-a825-241ca54062b2@amd.com>
In-Reply-To: <3af940dd-adcf-43d2-a825-241ca54062b2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Aug 2026 13:28:52 -0400
X-Gm-Features: AcwNN1XBKMTtbcDsOKwpdYcBOkSyhPEKuyc5MZ6-NySPWbKRZkndquhfeNqIb88
Message-ID: <CADnq5_NJbkeW93_uincWR1Y79-d4dNqmFOH2QOKtx-ZpH14umA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: handle pipeline sync without a VM fence
To: David Rosca <david.rosca@amd.com>
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

On Fri, Aug 14, 2026 at 1:14=E2=80=AFPM David Rosca <david.rosca@amd.com> w=
rote:
>
>
> On 8/14/26 17:42, Alex Deucher wrote:
> > If we end up emitting a VM fence keep pipeline sync
> > associated with that fence.  If not, emit them as
> > part of the IB fence.
> >
> > Cc: David Rosca <david.rosca@amd.com>
> > Fixes: cb1e657ccac8 ("drm/amdgpu: handle GDS and SPM without a VM fence=
")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 6 +++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
> >   3 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ib.c
> > index da4dc489e80bd..360e6f00cb7c0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> > @@ -222,7 +222,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed int num_ibs,
> >               vm_af =3D job->hw_vm_fence;
> >               /* VM sequence */
> >               vm_af->ib_wptr =3D ring->wptr;
> > -             amdgpu_vm_flush(ring, job, need_pipe_sync, &emit_spm_need=
ed,
> > +             amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_nee=
ded,
> >                               &emit_gds_needed);
> >               vm_af->ib_dw_size =3D
> >                       amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr,=
 ring->wptr);
> > @@ -235,6 +235,10 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, u=
nsigned int num_ibs,
> >       if (ring->funcs->insert_start)
> >               ring->funcs->insert_start(ring);
> >
> > +     /* this may have been handled by amdgpu_vm_flush */
> > +     if (need_pipe_sync)
> > +             amdgpu_ring_emit_pipeline_sync(ring);
> > +
> >       if (emit_spm_needed)
> >               adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, =
ring, job->vmid);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 71050a86bcc3a..4bd9368b13d97 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -772,7 +772,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_rin=
g *ring,
> >    * Emit a VM flush when it is necessary.
> >    */
> >   void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job=
,
> > -                  bool need_pipe_sync, bool *emit_spm_needed,
> > +                  bool *need_pipe_sync, bool *emit_spm_needed,
> >                    bool *emit_gds_needed)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> need_pipe_sync should also be removed from this condition below:
>
>      if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>          !cleaner_shader_needed && !spm_update_needed)
>          return;

It's still needed, we just need to dereference it first.

Alex

>
> With that, Reviewed-by: David Rosca <david.rosca@amd.com>
>
> > @@ -847,8 +847,10 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, str=
uct amdgpu_job *job,
> >               patch =3D amdgpu_ring_init_cond_exec(ring,
> >                                                  ring->cond_exe_gpu_add=
r);
> >
> > -     if (need_pipe_sync)
> > +     if (emit_fence && *need_pipe_sync) {
> >               amdgpu_ring_emit_pipeline_sync(ring);
> > +             *need_pipe_sync =3D false;
> > +     }
> >
> >       if (cleaner_shader_needed)
> >               ring->funcs->emit_cleaner_shader(ring);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.h
> > index 7f2ba728e3ed3..d32183cd9e0fc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -512,7 +512,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
> >                      int (*callback)(void *p, struct amdgpu_bo *bo),
> >                      void *param);
> >   void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job=
,
> > -                  bool need_pipe_sync, bool *emit_spm_needed,
> > +                  bool *need_pipe_sync, bool *emit_spm_needed,
> >                    bool *emit_gds_needed);
> >   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
> >                         struct amdgpu_vm *vm, bool immediate);
