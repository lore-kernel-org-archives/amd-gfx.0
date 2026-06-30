Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F1AC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 13:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9165510E1A3;
	Tue, 30 Jun 2026 13:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CkEJMapV";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC4010E1A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 13:31:00 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-137eb8e3491so449356c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 06:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782826259; cv=none;
 d=google.com; s=arc-20260327;
 b=NGDzE15UKP7cC53gQlWYCMQRqc96gu1bfE7SxX3KkZLgHMmY0a1HHgj5l3uwoRrsB9
 3/PY8Au7hkEEbm73wbzmUzUPPAfvyh5aPS/AIsvtFYX04TC4pqhaZpsIsJeG8ce+2EFY
 9p/jkv01obLmaSSxDkiziqRnoWi5nhP+1m4KlU/NKUiQN2KncXjG1S+klBdrxqEfUfWZ
 4QXCKF1lZiR44/i4RgHbgrKc2p5K4H6eRJ51oWx7YreAY+abjy5+V8N27hTqZNOiBDKg
 HR+AfPPwtGX8paeAK/sPrOcPHL5i44IbEoBAdQEGeMuzCF6zc20dK6TWToeGr5O4BK9Y
 s0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dZ7ZKrFz/LoxsXRp5/3accJXjFAsFZa9cDA5b1lQP0Y=;
 fh=9k/4C+jNX/+ca5X4cGefuZ/zsq/hRrtFLKCoNzV1rIk=;
 b=i44sagGNKQ9MwA+fLuZfFZ1rofB2Q8VMfuD8t27D9UxicpFx66yUwYa0gSj6dG8bwF
 5T7/40uGCTA/tss+bi2TVjG99cJ89VjWHnpqwKOIwKkXaHPPY2Xkp/WlQ2XAz/EMHJYS
 Zxm7KyxYkGAK0fpjNtn2FE4SoRgfF3GRcLe0HqQ7iHDcXV9spe49iMAjtRIaRF9EKfYn
 bbppI5oXgPnUQy9xm8jNhs150vh6AEQ9ldYSbX96Nlvld18P40Oyq+p6RIGeTkXG10/h
 IvO636YDtFI3HzW0TTTgx/gJcR3EuL9uMqO2IDKvj8+OcVG7/Zk1sob8/wr8jRh44hAo
 qu/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782826259; x=1783431059; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dZ7ZKrFz/LoxsXRp5/3accJXjFAsFZa9cDA5b1lQP0Y=;
 b=CkEJMapVtBHCmxvgOCRSQAFAXw9Vac4uLOgauE+jaDlyipatS6toI8ZZpO7OpniXHK
 HQbXe21G4yUanTmOpFByo3CmfM3ho21vsJm8LY8tm9/UGhtDahfMEnsWF8WA9YHFFwBd
 oC0Xez1ToroXpOHEG1DyM79I0vQJ51fzcEI7zOA97UDfooQ6A4Q/0NyD337fnEeuKAX2
 /S5OpO0Mfm6lSiwlw7A6J7iuBAaDXHzot5aYp+Bb03i5D43tpHh3jtSihX/OS6v/859c
 6GjP5yAaMD/RbpY+oT1hojq5Z6SbV3ia6AO2fCLJOyxHPKMAuCDoP+8i6SjmB9iUsXH0
 dxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782826259; x=1783431059;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dZ7ZKrFz/LoxsXRp5/3accJXjFAsFZa9cDA5b1lQP0Y=;
 b=b1SpHqg4ycOr6QrL4PmGq5lXiniYDvFV24BMMZQ17NvxNpHXzHZRP/+hxF14SCHyHh
 DEITLPGUZIQayun71RXx+w9lq455SJzvDASpchVl2ESR5OscPnfJPOjZs3GuJkdtNSJX
 5XpqN5Obxr2Ta53YRA7wFPdizE2vG9WiwXi1yDcTsyxGQkW4rQo5Ro2hix0bKX0g16lo
 cliQTfu8nBD8U1WmysYRrxgE7q02/RdbTg597C2I4GCNfrJcm7fD6K//IStOV2kOWR1d
 LPIyi48mCAG9KV0zUQCKCGj26oFVcsL3kYPGr1cWVldRDu+8XNuLgc4j15p6fhNC44Oa
 XyvA==
X-Gm-Message-State: AOJu0YzyLTV0VFQoxTdeDYF5nHqXBjNpuBNe1zlUcAqsL1KMVmqKzCGl
 krP2I3rVjtglK1R8ogq4wBZI7KQ8WzOAx3IZ04dumo+Jlv2nXU5CbNj2DQEU35LnRv48uudEuxl
 h4DZTVG2vfo/nDczYfiDd7kxkbzA/gtg=
X-Gm-Gg: AfdE7clyHf4sdemMxY+P9ts4LezxjsuZhBZtJ2fvfS33FQTLO14SAVWH3rUivT2ViS3
 P9teufX8NpJ8p/hHCPfX5ES4bwLORytwwLYHDiKbQU74YBwn1VpTs5oyAd1Ub8XVJ95sAA1M7DH
 isT0NPqG5+O39btKzUEzSKTX6UxxS9pganrSupFzv4ESJ6EWWB+GwUyDeCCwOYy1tqLH4/fUEcS
 j1zG4l+QcMbHEajYs1u7FBSozqiJkw7meoXhGnHM9XtBFP+AAJtE3sWFtbo4lrkzmUkcim/dnLy
 iNYWb001uiZtkw1ZeQV/btu7YRTwRkzs2tQx28UMWYnCQ1JUgLWAEShBdEo=
X-Received: by 2002:a05:7022:396:b0:134:d037:aca3 with SMTP id
 a92af1059eb24-13b2a15799amr1116702c88.3.1782826259413; Tue, 30 Jun 2026
 06:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
 <3694635.dWV9SEqChM@timur-max>
 <CADnq5_MiRc2Gei3QcmxVgtykLNfC+QwyxC7W=LsAVjMfCAT5_g@mail.gmail.com>
 <4911451.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <4911451.vXUDI8C0e8@timur-hyperion>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 Jun 2026 09:30:45 -0400
X-Gm-Features: AVVi8CdL4H9i61g92RzrVYI1z7kpmdoOpBtcLXc1iM9R5obskcosi-Y6o10XEBM
Message-ID: <CADnq5_MLEK4eE3tTvory-1-Uo00FCKPfM6mXWh8RMpV3bkMbxA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Save some cycles on the job submission
 path
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Jun 29, 2026 at 6:31=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Monday, June 29, 2026 5:28:14=E2=80=AFPM Central European Summer Time =
Alex Deucher
> wrote:
> > On Fri, Jun 26, 2026 at 1:10=E2=80=AFPM Timur Krist=C3=B3f <timur.krist=
of@gmail.com>
> wrote:
> > > On 2026. j=C3=BAnius 26., p=C3=A9ntek 10:55:57 k=C3=B6z=C3=A9p-eur=C3=
=B3pai ny=C3=A1ri id=C5=91 Tvrtko
> > > Ursulin
> > >
> > > wrote:
> > > > Every job submission on the Steam Deck ends up walking the list of =
IP
> > > > blocks looking for AMD_IP_BLOCK_TYPE_SMC. Half of the call chain is=
 like
> > > >
> > > > the below, while the second half is from amdgpu_gfx_profile_ring_en=
d_use:
> > > >  amdgpu_gfx_profile_ring_begin_use
> > > >
> > > >   amdgpu_dpm_is_overdrive_enabled
> > > >
> > > >    is_support_sw_smu
> > > >
> > > >     amdgpu_device_ip_is_valid
> > > >
> > > > On a game menu screen at 90Hz refresh rate we end up with ~840 call=
s per
> > > >
> > > > second which sticks out when the submission worker is profiled with=
 perf:
> > > >   13.78%  [kernel]  [k] __lock_text_start
> > > >   10.86%  [kernel]  [k] __lookup_object
> > > >
> > > >    8.76%  [kernel]  [k] __mod_timer
> > > >    4.94%  [kernel]  [k] queued_spin_lock_slowpath
> > > >    1.66%  [kernel]  [k] amdgpu_device_ip_is_valid
> > > >    1.54%  [kernel]  [k] preempt_count_add
> > > >    1.42%  [kernel]  [k] amdgpu_sync_peek_fence
> > > >    1.18%  [kernel]  [k] amdgpu_vmid_grab
> > > >    1.17%  [kernel]  [k] amdgpu_ib_schedule
> > > >    1.14%  [kernel]  [k] kthread_worker_fn
> > > >
> > > > Lets short-circuit this walk by simply caching the result of
> > > > is_support_sw_smu() in the device.
> > > >
> > > > This is a micro-improvement but it is at least conceptually nicer t=
o
> > > > avoid
> > > > repeating the same walk so much.
> > >
> > > Hi,
> > >
> > > I agree with cleaning up this thing.
> > > Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > >
> > > That being said, I think is_support_sw_smu() is horrible and should b=
e
> > > removed alltogether, because it goes against how the rest of the powe=
r
> > > management code works.
> > >
> > > In my opinion, we should instead:
> > >
> > > 1. Hook up some function pointers and check those instead,
> > > For example in amdgpu_pm_acpi_event_handler() we should just hook up
> > > smu_set_ac_dc() to the notify_ac_dc() function pointer. There are ple=
nty
> > > of
> > > other similar cases.
> > > Another example, for amdgpu_dpm_mode1_reset() we should introduce a n=
ew
> > > asic_reset_mode_1() pointer in amd_pm_funcs() similar to how it works=
 with
> > > MODE2 reset for consistency.
> > >
> > > 2. Eliminate redundant functions where the same thing is already done
> > > elsewhere.
> > > For example in amdgpu_dpm_is_mode1_reset_supported() it checks
> > > smu_mode1_reset_is_support() which is redundant because the supported
> > > reset
> > > type is available on the ASIC functions already and we can just use t=
hat.
> > >
> > > What do you think?
> >
> > I agree.  This has been a todo for a while.
> >
>
> Thanks Alex. I'd be happy to work on this cleanup. However can you please
> apply Tvrtko's patch? I think it's a nice improvement until that cleanup =
is
> complete.

Sure.  Applied the series.  Thanks!

Alex

>
> Thanks & best regards,
> Timur
>
>
> > > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > > ---
> > > >
> > > > v2:
> > > >  * Approach changed to cache sw_smu status only.
> > > >
> > > > ---
> > > >
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +++
> > > >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 +++++---------
> > > >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 +++++++-
> > > >  4 files changed, 16 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h index 7b09410d6d8f..9803967d1=
5f9
> > > > 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > @@ -851,6 +851,7 @@ struct amdgpu_device {
> > > >
> > > >       struct dev_pm_domain            vga_pm_domain;
> > > >       bool                            have_disp_power_ref;
> > > >       bool                            have_atomics_support;
> > > >
> > > > +     bool                            is_sw_smu;
> > > >
> > > >       /* BIOS */
> > > >       bool                            is_atom_fw;
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c index
> > > > 1e6b75ecafe4..7f935a5778b0 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > @@ -74,6 +74,7 @@
> > > >
> > > >  #include "amdgpu_ras.h"
> > > >  #include "amdgpu_ras_mgr.h"
> > > >  #include "amdgpu_pmu.h"
> > > >
> > > > +#include "amdgpu_smu.h"
> > > >
> > > >  #include "amdgpu_fru_eeprom.h"
> > > >  #include "amdgpu_reset.h"
> > > >  #include "amdgpu_virt.h"
> > > >
> > > > @@ -2130,6 +2131,8 @@ static int amdgpu_device_ip_early_init(struct
> > > > amdgpu_device *adev) adev->cg_flags &=3D amdgpu_cg_mask;
> > > >
> > > >       adev->pg_flags &=3D amdgpu_pg_mask;
> > > >
> > > > +     amdgpu_smu_early_init(adev);
> > > > +
> > > >
> > > >       return 0;
> > > >
> > > >  }
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c index
> > > > 208a2fba6d40..82c9ae6a5092 100644
> > > > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > @@ -591,17 +591,13 @@ static int smu_get_power_num_states(void *han=
dle,
> > > >
> > > >       return 0;
> > > >
> > > >  }
> > > >
> > > > -bool is_support_sw_smu(struct amdgpu_device *adev)
> > > > +void amdgpu_smu_early_init(struct amdgpu_device *adev)
> > > >
> > > >  {
> > > >
> > > >       /* vega20 is 11.0.2, but it's supported via the powerplay cod=
e */
> > > >
> > > > -     if (adev->asic_type =3D=3D CHIP_VEGA20)
> > > > -             return false;
> > > > -
> > > > -     if ((amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D IP_VERSION(11,=
 0, 0))
> > >
> > > &&
> > >
> > > > -         amdgpu_device_ip_is_valid(adev, AMD_IP_BLOCK_TYPE_SMC))
> > > > -             return true;
> > > > -
> > > > -     return false;
> > > > +     adev->is_sw_smu =3D adev->asic_type !=3D CHIP_VEGA20 &&
> > > > +                       (amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D
> > > > +                        IP_VERSION(11, 0, 0) &&
> > > > +                        amdgpu_device_ip_is_valid(adev,
> > >
> > > AMD_IP_BLOCK_TYPE_SMC));
> > >
> > > >  }
> > > >
> > > >  bool is_support_cclk_dpm(struct amdgpu_device *adev)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > > b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h index
> > > > d76e0b005308..efc52d97058b 100644
> > > > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > > @@ -1952,7 +1952,13 @@ int smu_link_reset(struct smu_context *smu);
> > > >
> > > >  extern const struct amd_ip_funcs smu_ip_funcs;
> > > >
> > > > -bool is_support_sw_smu(struct amdgpu_device *adev);
> > > > +void amdgpu_smu_early_init(struct amdgpu_device *adev);
> > > > +
> > > > +static inline bool is_support_sw_smu(struct amdgpu_device *adev)
> > > > +{
> > > > +     return adev->is_sw_smu;
> > > > +}
> > > > +
> > > >
> > > >  bool is_support_cclk_dpm(struct amdgpu_device *adev);
> > > >  int smu_write_watermarks_table(struct smu_context *smu);
>
>
>
>
