Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9401D2F326
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 15:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4421B10E48F;
	Tue, 13 Jan 2026 15:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J7dQ4CNF";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFCDC10E48F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 15:35:05 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-11ddccf4afdso551776c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 07:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768318505; cv=none;
 d=google.com; s=arc-20240605;
 b=UOJTJGKKLauOQaquNk1phoaGCIfBV+IprmlG7Yp02Aaghb5semEDA5uUn0ePEalUKY
 r7I0z0F7PwZ0sX3PkTK84lDLIReCiHtF6amSUZB/KGHmIAyXebzLb/d0xhCpixzOxlpD
 n3tuOfuMuhYUt07F+5GTFD5ROV1ptD69KZuF7XLpwuvEp/mG/ILR3Yz6LVw8xU8a/zRb
 kjyggVB7etQIyb3IGeN55aTdwCi/lIBytK5INnExXxErISF7nIyZmkb/pt05kaPpCyhw
 7WH43cGwxX4TVoKzBXSXl/dMEsLng7ZjMrNmAs9gw9vMZIu+9cTNNbs8BHU4V18lxYIW
 Dp4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qu+6rxwWSsJSvLc+WTs2/GnMNXW7wjaViJQkCZKUKHg=;
 fh=GL+581Bbd4MzEbJ42aRDOqN4zUgqbJh4xzdcUyREJZE=;
 b=NvRWVXWpYDFRxlGQAjEnDjRyL7iFh42BblrYiWea6cdGyMK0t9cp0vcm7VgwpFk7kD
 BM18IsjPGALOEWXb1KIymr/macDmBQVejboi4Mk1NyRRBD29hGMB2An4DgTZrV0D37fV
 QeqGkV3LAu4sX82Ot54zLckRMT8CR0T9AmPpidRFWVYPNnKbZkN7WUnKvoDM1yeBXDMf
 2qMfIM7m/QQ7nzHJrMWHZCy+NE4jQUW7T10xGAWZqpurgnY6DFv2w6Koh5QjS5zRuopA
 pgofQ30d3clpOxfCPuX9NAEDWh8IzqEe7tHh3jYSgh91iMwbOxxiqGZyABtbcIlszAls
 TkVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768318505; x=1768923305; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qu+6rxwWSsJSvLc+WTs2/GnMNXW7wjaViJQkCZKUKHg=;
 b=J7dQ4CNFbGdkSlbzxT722SbTrSmtWalFZ41co5ac8HNpnUi+x/qcCIUcfiPmlxd0Au
 EkAupX/kvBHMgumPT/iYm82NvPPX7ZP5m69xsqbLoMzrlzpczGX5l6xS6Y0bdWptPY/U
 /hjBWlpfcLkoY5nW9UyU3WijdqFjWmWJ79TV0IU/f3w2FZ+zJquegWbj8QIhEsaCkGBU
 yjl5oFJtgXPwgZ2cAsbMD3lpIlLhjYdt4yhNp0xJon05TU2U49RKedZeIbKyazvEcM2S
 FDY1ATKlUiKPXTOVeLRVFTy3Opr3aUJJxUre6M+H/y5yh4L6pNQXa5M49o+1umWnFUhH
 Q1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768318505; x=1768923305;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qu+6rxwWSsJSvLc+WTs2/GnMNXW7wjaViJQkCZKUKHg=;
 b=BoqG4lXjwnKPXh463zD+dzxHmMvbcAgjENAlX8HVTaBsh1OInN2MYa9+EbSntTgMy+
 lEPo1qJBMl2ugYYqqvh+2eCtcX0WR5FX+xiGMSNnCOHDWAFmG20ZG00SNhP9fIqyDhjo
 nyVXC6xbGZi4zWohsHc6aFNvm9fd5aUO5E10WI420+9CWPRzEHxRjI4O67ZJwzBdLNO+
 4bvmTLYbfaqMRa0HcCBvLjA1EcwTfjD2jOAnlq1lT4O6c11ZW9oQtN1tqc81T2OYyXZV
 9nNFvXnQLuabWOgWNe03LFM+obf45m3aGdrgFeWNDbsNy12s70rO5E1Tk7ABjQRNmQCK
 NSxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw/YmSeNYwn/iChCBd11ZiftcDc3M/oMxXV8lgIK9S+PIDxpZ7AyMRbMLLciu/dk7HElI5Nj1m@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy++Wu8o1yI47Whh0ZCJ3t/WOmohnHrrJfvAdo/uKK9kZfa6M44
 5bB4/JwmzM2Y3g5aDGs8tXX/onbvF8ld1o3crU3Qw6iYq4SZFFSuhZaZ1wOziAYBmG6YZoJusOv
 DsuXgeB+RYz9IT91xXooLG/Ndt7yOJ5I=
X-Gm-Gg: AY/fxX79IUXAcOdr9UNkVu7SxrNIMJRmwtPfN09GbVYb91xiOxiFjWXBih/H92l3XnT
 m5ZK5zQm2x5oExg1yGE6Z9MWU3oas7k0mGGwI3Q05GBdbJPS7vEgpLXfparm93beb63R/KW7c+W
 CnuVSIEipJrC/XgXFMBKo9wiwUhIMbAfpj5bwIlESol+iyQsJrkgtY0APLIaBB9IRs9L6Z838x7
 SFk8vwNOgNpMq9WMoSvTTZcBqzmmpKiaGPRbsCOD9n4J4Wu3R/c/geR7yZ8dW6YLLSf8shm
X-Google-Smtp-Source: AGHT+IEJol3ANRVtq4Sq8owmLWeuDef0lY5fGITYNMqUgCyagPaNH7KlmtXe5w+rMBv3g/2U2l4fl1VA9Mp3Kj7shrY=
X-Received: by 2002:a05:7022:f415:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-121f8a30d8emr11523333c88.0.1768318503369; Tue, 13 Jan 2026
 07:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
 <CADnq5_MJbjn8zD5O-sjL8vNk4eUD04jTXwkmS9Cwq3_WSajGqg@mail.gmail.com>
 <0288bbdf-880e-4149-ae0e-f2d2154cfbe0@amd.com>
In-Reply-To: <0288bbdf-880e-4149-ae0e-f2d2154cfbe0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jan 2026 10:34:52 -0500
X-Gm-Features: AZwV_Qj--qLeCQ79YwOl_NyqDx8eekqOJweSSCBZZZUwDKR1xVYE7hSyVyf-lG0
Message-ID: <CADnq5_M8-Qq14yYjoWJXgBRqQ42prGar1O6e8nxcEN5WNROTQw@mail.gmail.com>
Subject: Re: [PATCH 00/42] Improvements for IB handling
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

On Tue, Jan 13, 2026 at 9:48=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 1/13/26 15:10, Alex Deucher wrote:
> > On Tue, Jan 13, 2026 at 8:57=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> Patches #1-#3: Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd=
.com>
> >>
> >> Comment on patch #4 which also affects patches #5-#26.
> >>
> >> Comment on patch #27 and #28. When #28 comes before #27 then that woul=
d potentially solve the issue with #27.
> >>
> >> Patches #31: Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.c=
om>
> >>
> >> Patches #32-#40 that looks extremely questionable to me. I've intentio=
nally removed that state from the job because it isn't job dependent and so=
metimes has inter-job meaning.
> >>
> >> Patch #41: Absolutely clear NAK! We have exercised that nonsense to th=
e max and I'm clearly against doing that over and over again. Saving the ri=
ng content clearly seems to be the saver approach.
> >>
> >
> > I disagree.  If the ring emit functions are purely just emitting
> > packets to the ring, it's a much cleaner approach than trying to save
> > and restore packet sequences repeatedly.
>
> Exactly that's the problem, this is not what they do.
>
> See gfx_v11_0_ring_emit_gfx_shadow() for an example:
>
> ...
>         /*
>          * We start with skipping the prefix SET_Q_MODE and always execut=
ing
>          * the postfix SET_Q_MODE packet. This is changed below with a
>          * WRITE_DATA command when the postfix executed.
>          */
>         amdgpu_ring_write(ring, shadow_va ? 1 : 0);
>         amdgpu_ring_write(ring, 0);
>
>         if (ring->set_q_mode_offs) {
>                 uint64_t addr;
>
>                 addr =3D amdgpu_bo_gpu_offset(ring->ring_obj);
>                 addr +=3D ring->set_q_mode_offs << 2;
>                 end =3D gfx_v11_0_ring_emit_init_cond_exec(ring, addr);
>         }
> ...
>         if (shadow_va) {
>                 uint64_t token =3D shadow_va ^ csa_va ^ gds_va ^ vmid;
>
>                 /*
>                  * If the tokens match try to skip the last postfix SET_Q=
_MODE
>                  * packet to avoid saving/restoring the state all the tim=
e.
>                  */
>                 if (ring->set_q_mode_ptr && ring->set_q_mode_token =3D=3D=
 token)
>                         *ring->set_q_mode_ptr =3D 0;
>
>                 ring->set_q_mode_token =3D token;
>         } else {
>                 ring->set_q_mode_ptr =3D &ring->ring[ring->set_q_mode_off=
s];
>         }
>
>         ring->set_q_mode_offs =3D offs;
> }
>
> Executing this multiple times is simply not possible without saving set_q=
_mode_offs, the token and the CPU pointer (and restoring the CPU pointer co=
ntent).
>
> And that is just the tip of the iceberg, we have tons of state like this.

There is not much more than that.  I looked when I wrote these
patches.  Even this state should be handled correctly.  In this case,
the state is saved in the job at the original submission time and is
explicitly passed to the emit ring functions.  As such the original
state is reproduced.  In this case, ring->set_q_mode_offs and
ring->set_q_mode_ptr get reset in gfx_v11_0_ring_emit_vm_flush().
Then they get set as appropriate based on the saved state in the job
in gfx_v11_0_ring_emit_gfx_shadow().  It emits the same ring state
again.

>
> > If the relevant state is
> > stored in the job, you can re-emit it and get the same ring state each
> > time.
>
> No, you can't. Background is that the relevant state is not job dependent=
, but inter job dependent.
>
> In other words it doesn't depend on what job is executing now but rather =
which one was executed right before that one.
>
> Or even worse in the case of the set_q_mode packet on the job dependent a=
fter the one you want to execute.
>
> I can absolutely not see how stuff like that should work with re-submissi=
on.

All you need to do is save the state that was used to emit the packets
in the original submission.

>
> > If you end up with multiple queue resets in a row, it gets
> > really complex to try and save and restore opaque ring contents.  By
> > the time you fix up the state tracking to handle that, you end up
> > pretty close to this solution.
>
> Not even remotely, you have tons of state we would need to save and resto=
re and a lot of that is outside of the job.
>
> Updating a few fence pointers on re-submission is absolutely trivial comp=
ared to that.

It's not that easy.  If you want to just emit the fences for bad
contexts rather than the whole IB stream, you can also potentially
mess up the ring state.  You'd end up needing a pile of pointers that
need to be recalculated on every reset to try and remit the
appropriate state again.  This approach also paves the way for
re-emitting state for all queues after adapter reset when VRAM is not
lost.

Alex

>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >> Regards,
> >> Christian.
> >>
> >> On 1/8/26 15:48, Alex Deucher wrote:
> >>> This set contains a number of bug fixes and cleanups for
> >>> IB handling that I worked on over the holidays.
> >>>
> >>> Patches 1-2:
> >>> Simple bug fixes.
> >>>
> >>> Patches 3-26:
> >>> Removes the direct submit path for IBs and requires
> >>> that all IB submissions use a job structure.  This
> >>> greatly simplifies the IB submission code.
> >>>
> >>> Patches 27-42:
> >>> Split IB state setup and ring emission.  This keeps all
> >>> of the IB state in the job.  This greatly simplifies
> >>> re-emission of non-timed-out jobs after a ring reset and
> >>> allows for re-emission multiple times if multiple resets
> >>> happen in a row.  It also properly handles the dma fence
> >>> error handling for timedout jobs with adapter resets.
> >>>
> >>> Alex Deucher (42):
> >>>   drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
> >>>   drm/amdgpu: fix error handling in ib_schedule()
> >>>   drm/amdgpu: add new job ids
> >>>   drm/amdgpu/vpe: switch to using job for IBs
> >>>   drm/amdgpu/gfx6: switch to using job for IBs
> >>>   drm/amdgpu/gfx7: switch to using job for IBs
> >>>   drm/amdgpu/gfx8: switch to using job for IBs
> >>>   drm/amdgpu/gfx9: switch to using job for IBs
> >>>   drm/amdgpu/gfx9.4.2: switch to using job for IBs
> >>>   drm/amdgpu/gfx9.4.3: switch to using job for IBs
> >>>   drm/amdgpu/gfx10: switch to using job for IBs
> >>>   drm/amdgpu/gfx11: switch to using job for IBs
> >>>   drm/amdgpu/gfx12: switch to using job for IBs
> >>>   drm/amdgpu/gfx12.1: switch to using job for IBs
> >>>   drm/amdgpu/si_dma: switch to using job for IBs
> >>>   drm/amdgpu/cik_sdma: switch to using job for IBs
> >>>   drm/amdgpu/sdma2.4: switch to using job for IBs
> >>>   drm/amdgpu/sdma3: switch to using job for IBs
> >>>   drm/amdgpu/sdma4: switch to using job for IBs
> >>>   drm/amdgpu/sdma4.4.2: switch to using job for IBs
> >>>   drm/amdgpu/sdma5: switch to using job for IBs
> >>>   drm/amdgpu/sdma5.2: switch to using job for IBs
> >>>   drm/amdgpu/sdma6: switch to using job for IBs
> >>>   drm/amdgpu/sdma7: switch to using job for IBs
> >>>   drm/amdgpu/sdma7.1: switch to using job for IBs
> >>>   drm/amdgpu: require a job to schedule an IB
> >>>   drm/amdgpu: mark fences with errors before ring reset
> >>>   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
> >>>   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
> >>>   drm/amdgpu: drop drm_sched_increase_karma()
> >>>   drm/amdgpu: plumb timedout fence through to force completion
> >>>   drm/amdgpu: change function signature for emit_pipeline_sync()
> >>>   drm/amdgpu: drop extra parameter for vm_flush
> >>>   drm/amdgpu: move need_ctx_switch into amdgpu_job
> >>>   drm/amdgpu: store vm flush state in amdgpu_job
> >>>   drm/amdgpu: split fence init and emit logic
> >>>   drm/amdgpu: split vm flush and vm flush emit logic
> >>>   drm/amdgpu: split ib schedule and ib emit logic
> >>>   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
> >>>   drm/amdgpu: add an all_instance_rings_reset ring flag
> >>>   drm/amdgpu: rework reset reemit handling
> >>>   drm/amdgpu: simplify per queue reset code
> >>>
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++--------=
--
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
> >>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
> >>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
> >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
> >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
> >>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
> >>>  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
> >>>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
> >>>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
> >>>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
> >>>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
> >>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
> >>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
> >>>  54 files changed, 952 insertions(+), 966 deletions(-)
> >>>
> >>
>
