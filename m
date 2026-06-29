Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A467FC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 22:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE3410E111;
	Mon, 29 Jun 2026 22:31:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="clXgJSwl";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F55710E111
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 22:31:53 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-463f1165e16so3864440f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 15:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782772311; x=1783377111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eCS9DCYOtvMBPvcKFRfwQELWbMaGwyrw/edo1QvRZ8=;
 b=clXgJSwl9J7OiqN4EoWdGnUdx+ZUGjfBkHebC/x5sLhZkuaHvONFIm+W/lcTjO3icP
 DZvp5lEbRLxhywAMas6ikwQo1ujJdaItGFZCsiTMfXhCG7FMnRMyOVN68W6p0PHEMTpz
 uhIIK+dblfGn1qxsoXMyeSeYXMSRY2vEpK4puOkF3+7IXjRugcdmG6MRKJEhxcqKgZZp
 Z4PMvBVGcW9zJz6guQLEDEWBxavA0Nc95cWP2m802L6TURvLPmo7Y9/HBGJFZtPLU7Cj
 DOQUhqPP/tCcWImQdNajR7Kl60ancS7CYDtz6QL+HjEcPrhofuLOp1DVy7nmm7fpbE8z
 hJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782772311; x=1783377111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5eCS9DCYOtvMBPvcKFRfwQELWbMaGwyrw/edo1QvRZ8=;
 b=QHYPRV3mQ6C7psSZ7UYUgGk1TuzI1QHMS6lXbe/zcPOP1PJNz3OHFYsS+jx4xP1Icv
 2Hf0vwmuQ7mglDqNbRQeosIffahdSGAHjyri4WkEnDpU7leI0fcsbUUea9FMc941bC2P
 t7C6o83/S0xF1NEwJ7vQ9y+73TPQm0BfkmGh1FgKBX5ulpAa+EerJ67BygnuaSEIjilV
 yEIAVmVjnKJInVOJK8evAU1YDmKWBk7okUspPFpxc3K0I8lQ8eelubiiGjaqgfOIOlNS
 XdmpkZmQ0Z0GnC8Al2CFUwsiUIdOli8Ny3cGrZPUyrDc+V5UcuVgkz2V11cfTwkt5H7A
 sM6g==
X-Gm-Message-State: AOJu0YxhfzXTRpYAI2oT+a1U4FwXLbz8w025GueFEeflz/VUeGZeNrlD
 GdzrvFQehNybWxg5dbkq0Ee1ygRLe8HrbsGNM/5jbuYFP173pe4fJCSs
X-Gm-Gg: AfdE7clscfHEm/arfJQu8d5p187CfKlIYPnvVoOCvdkP9wjNZsKseEPC95EICs4En8c
 7s3iXHNEnFF84Y5L053X6ftiiohTib2Qf8WbDAAPKIGj0JOdBYqqbxQPTUrFI/8gS5d8nEjv+6u
 HLj+184BLyRpbx48UFWl1kBGz9yw71X1F0Ci+R9PQiKYgmQME/gmUmXXafUHFJQaz84eAa11epI
 yoZrblvXrKnzekv/ANknNUnzvm7V8Q4L6J6WdQT6RyGkh+ggLgDvLAqPX5mbCz+CPFeJ0MlrAtp
 SN10ZJDblSCHdFq0NvmMEMUlyA6gyj93D2UVMupvsHu83XR4jAuKf8b/TfZfOXCcKr/Snm3tpDF
 iYyPZ51teehLK6Xzm5oeKMFmW+4j20G/oqLpOeDBJ+3mmy/tKCKoZp1K1AgS9pMbNEZCdvzlloh
 eR2ngRxQOqM/JHZ0wQiVmmbKSc0+9HIC1NhpviFnnBOzKNxc19HKpROCZpsmI=
X-Received: by 2002:a05:600c:1d9a:b0:493:a570:df7d with SMTP id
 5b1f17b1804b1-493b82ae921mr19891155e9.20.1782772311117; 
 Mon, 29 Jun 2026 15:31:51 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bab4d331sm4171075e9.0.2026.06.29.15.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 15:31:50 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Save some cycles on the job submission
 path
Date: Tue, 30 Jun 2026 00:31:48 +0200
Message-ID: <4911451.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <CADnq5_MiRc2Gei3QcmxVgtykLNfC+QwyxC7W=LsAVjMfCAT5_g@mail.gmail.com>
References: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
 <3694635.dWV9SEqChM@timur-max>
 <CADnq5_MiRc2Gei3QcmxVgtykLNfC+QwyxC7W=LsAVjMfCAT5_g@mail.gmail.com>
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

On Monday, June 29, 2026 5:28:14=E2=80=AFPM Central European Summer Time Al=
ex Deucher=20
wrote:
> On Fri, Jun 26, 2026 at 1:10=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof=
@gmail.com>=20
wrote:
> > On 2026. j=C3=BAnius 26., p=C3=A9ntek 10:55:57 k=C3=B6z=C3=A9p-eur=C3=
=B3pai ny=C3=A1ri id=C5=91 Tvrtko
> > Ursulin
> >=20
> > wrote:
> > > Every job submission on the Steam Deck ends up walking the list of IP
> > > blocks looking for AMD_IP_BLOCK_TYPE_SMC. Half of the call chain is l=
ike
> > >=20
> > > the below, while the second half is from amdgpu_gfx_profile_ring_end_=
use:
> > >  amdgpu_gfx_profile_ring_begin_use
> > > =20
> > >   amdgpu_dpm_is_overdrive_enabled
> > >  =20
> > >    is_support_sw_smu
> > >   =20
> > >     amdgpu_device_ip_is_valid
> > >=20
> > > On a game menu screen at 90Hz refresh rate we end up with ~840 calls =
per
> > >=20
> > > second which sticks out when the submission worker is profiled with p=
erf:
> > >   13.78%  [kernel]  [k] __lock_text_start
> > >   10.86%  [kernel]  [k] __lookup_object
> > >  =20
> > >    8.76%  [kernel]  [k] __mod_timer
> > >    4.94%  [kernel]  [k] queued_spin_lock_slowpath
> > >    1.66%  [kernel]  [k] amdgpu_device_ip_is_valid
> > >    1.54%  [kernel]  [k] preempt_count_add
> > >    1.42%  [kernel]  [k] amdgpu_sync_peek_fence
> > >    1.18%  [kernel]  [k] amdgpu_vmid_grab
> > >    1.17%  [kernel]  [k] amdgpu_ib_schedule
> > >    1.14%  [kernel]  [k] kthread_worker_fn
> > >=20
> > > Lets short-circuit this walk by simply caching the result of
> > > is_support_sw_smu() in the device.
> > >=20
> > > This is a micro-improvement but it is at least conceptually nicer to
> > > avoid
> > > repeating the same walk so much.
> >=20
> > Hi,
> >=20
> > I agree with cleaning up this thing.
> > Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >=20
> > That being said, I think is_support_sw_smu() is horrible and should be
> > removed alltogether, because it goes against how the rest of the power
> > management code works.
> >=20
> > In my opinion, we should instead:
> >=20
> > 1. Hook up some function pointers and check those instead,
> > For example in amdgpu_pm_acpi_event_handler() we should just hook up
> > smu_set_ac_dc() to the notify_ac_dc() function pointer. There are plenty
> > of
> > other similar cases.
> > Another example, for amdgpu_dpm_mode1_reset() we should introduce a new
> > asic_reset_mode_1() pointer in amd_pm_funcs() similar to how it works w=
ith
> > MODE2 reset for consistency.
> >=20
> > 2. Eliminate redundant functions where the same thing is already done
> > elsewhere.
> > For example in amdgpu_dpm_is_mode1_reset_supported() it checks
> > smu_mode1_reset_is_support() which is redundant because the supported
> > reset
> > type is available on the ASIC functions already and we can just use tha=
t.
> >=20
> > What do you think?
>=20
> I agree.  This has been a todo for a while.
>=20

Thanks Alex. I'd be happy to work on this cleanup. However can you please=20
apply Tvrtko's patch? I think it's a nice improvement until that cleanup is=
=20
complete.

Thanks & best regards,
Timur


> > > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >=20
> > > v2:
> > >  * Approach changed to cache sw_smu status only.
> > >=20
> > > ---
> > >=20
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +++
> > >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 +++++---------
> > >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 +++++++-
> > >  4 files changed, 16 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h index 7b09410d6d8f..9803967d15f9
> > > 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > @@ -851,6 +851,7 @@ struct amdgpu_device {
> > >=20
> > >       struct dev_pm_domain            vga_pm_domain;
> > >       bool                            have_disp_power_ref;
> > >       bool                            have_atomics_support;
> > >=20
> > > +     bool                            is_sw_smu;
> > >=20
> > >       /* BIOS */
> > >       bool                            is_atom_fw;
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c index
> > > 1e6b75ecafe4..7f935a5778b0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -74,6 +74,7 @@
> > >=20
> > >  #include "amdgpu_ras.h"
> > >  #include "amdgpu_ras_mgr.h"
> > >  #include "amdgpu_pmu.h"
> > >=20
> > > +#include "amdgpu_smu.h"
> > >=20
> > >  #include "amdgpu_fru_eeprom.h"
> > >  #include "amdgpu_reset.h"
> > >  #include "amdgpu_virt.h"
> > >=20
> > > @@ -2130,6 +2131,8 @@ static int amdgpu_device_ip_early_init(struct
> > > amdgpu_device *adev) adev->cg_flags &=3D amdgpu_cg_mask;
> > >=20
> > >       adev->pg_flags &=3D amdgpu_pg_mask;
> > >=20
> > > +     amdgpu_smu_early_init(adev);
> > > +
> > >=20
> > >       return 0;
> > > =20
> > >  }
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c index
> > > 208a2fba6d40..82c9ae6a5092 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > @@ -591,17 +591,13 @@ static int smu_get_power_num_states(void *handl=
e,
> > >=20
> > >       return 0;
> > > =20
> > >  }
> > >=20
> > > -bool is_support_sw_smu(struct amdgpu_device *adev)
> > > +void amdgpu_smu_early_init(struct amdgpu_device *adev)
> > >=20
> > >  {
> > > =20
> > >       /* vega20 is 11.0.2, but it's supported via the powerplay code =
*/
> > >=20
> > > -     if (adev->asic_type =3D=3D CHIP_VEGA20)
> > > -             return false;
> > > -
> > > -     if ((amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D IP_VERSION(11, 0=
, 0))
> >=20
> > &&
> >=20
> > > -         amdgpu_device_ip_is_valid(adev, AMD_IP_BLOCK_TYPE_SMC))
> > > -             return true;
> > > -
> > > -     return false;
> > > +     adev->is_sw_smu =3D adev->asic_type !=3D CHIP_VEGA20 &&
> > > +                       (amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D
> > > +                        IP_VERSION(11, 0, 0) &&
> > > +                        amdgpu_device_ip_is_valid(adev,
> >=20
> > AMD_IP_BLOCK_TYPE_SMC));
> >=20
> > >  }
> > > =20
> > >  bool is_support_cclk_dpm(struct amdgpu_device *adev)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h index
> > > d76e0b005308..efc52d97058b 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > > @@ -1952,7 +1952,13 @@ int smu_link_reset(struct smu_context *smu);
> > >=20
> > >  extern const struct amd_ip_funcs smu_ip_funcs;
> > >=20
> > > -bool is_support_sw_smu(struct amdgpu_device *adev);
> > > +void amdgpu_smu_early_init(struct amdgpu_device *adev);
> > > +
> > > +static inline bool is_support_sw_smu(struct amdgpu_device *adev)
> > > +{
> > > +     return adev->is_sw_smu;
> > > +}
> > > +
> > >=20
> > >  bool is_support_cclk_dpm(struct amdgpu_device *adev);
> > >  int smu_write_watermarks_table(struct smu_context *smu);




