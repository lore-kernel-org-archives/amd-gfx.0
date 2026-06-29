Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1105BC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 15:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B9C10E666;
	Mon, 29 Jun 2026 15:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AtmZzUYn";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CC810E666
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 15:28:27 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30cb5001e5bso162772eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 08:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782746906; cv=none;
 d=google.com; s=arc-20260327;
 b=mPN37OgqsroUheeWPGsI1ZZkv3xijqL7d24L9mRM6uTTc38XR91ygFZE8yZCHcTXu4
 go6GAz4mjJ/9vjp6XWcmHjBfDNSMDuNoUuFEknjbPSW2/XPwOjpGZWu+FJOsfBLSP4JC
 66h+9ZIrMJKHcNbQYV5ASJfSnfCMendXmKQjwjnJ6p9mID3mIlCVcVHWiG6GjoOG1PyV
 m8qVXRrV6Nc3ZlRNTs0hpg/DwgvtC/tbFnfwxCj3/rjSjIdg2AieOKtR55KzYZIKWbg/
 CTfkh6DhTfETneREkvFiRszCEnmaX6p0neolh78C9tOEUU8MVueR/UbRGdxnLCkf9JbG
 h+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=233bFXjxRjH5Zjbc9QTxFdkTjBLkLABDwT56ZmykFtA=;
 fh=9k/4C+jNX/+ca5X4cGefuZ/zsq/hRrtFLKCoNzV1rIk=;
 b=qjs6TtB08gHDVMc6aT5lGNExV6af0lhR+hEURMhqzd87fe8miHw2Co9DQJ1790FpNs
 RazOLMlf9SCsw1+7bPT+n27ELg035zqHCvxqcOxAnYUXNJ/Y8yu32CqXDrP56E/d8cJM
 /IYMVZOp4VwvfWG6B7Yrnap8/pb1hxOzqZMNXhPmCPskFh9AnaVej3l95J0MYRrgtHMB
 eOEE5P+g/yFkbhoI7jf6iB/HGHHEinqzTdW3jUV6DtmlEeaykjcXZwAiGhhRxWY+ivHW
 T2/0TraGW+/5PH0McXU+nmczj9GEmz//o25gkwULLmHJfx90LxR6qprgAF7qPykT+pWv
 Nlvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782746906; x=1783351706; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=233bFXjxRjH5Zjbc9QTxFdkTjBLkLABDwT56ZmykFtA=;
 b=AtmZzUYnkllRccXp/pZ4WDXb/A6yOfzvQjjcFRRbQAP+hx0qvyg7/DVw60KiTqOTgB
 b0MxNoGmWngdPgZPw9c4cBGABGx9xBfV7MkyEecnZ5ncRYqpI7mqyBUlZKNLs/Ba1MYE
 61FZHjDaM4Nl0jTnTj5sPvnMKM8i5W+gNEcaBGgDLoCWhQLsbLIhuMq+DTxr4n9awFT+
 dsy1kGI2Edq1iartAfHlt+31SHQ62Jm0Ue+hVGTHT3Cf2iYZa+KFMOCbdULPk/Iw/wkO
 niWpaGwtDJP7kn7qFLOieSUkQEMQu97uOM1VqwdlXnITOD4Jg6ndNUFEn/rn3Vm3bIq2
 RLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782746906; x=1783351706;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=233bFXjxRjH5Zjbc9QTxFdkTjBLkLABDwT56ZmykFtA=;
 b=blYh2GXhR9ukjM+we9MiJqqD6TK5TC39i8EtemmrHkJUXw2HFQ67O94p9Q8NQKGBKh
 AxC3al5iKVY6bOxt01s/ZQSfNw3EVflTs3rADqedd4VvxBDKNce6W8smzTimQynsh+kX
 jG2cbemAznlhhrew55GEWdFme7lD+lBfS6y5O3/13z+Do7GNgatmsc/r8T7YlGNGQuQ0
 v0RCD+qBTG80mDQDS7XwvAhAgw/I65GqHYi35H55o6bUk5z8YLqwLa/hWVm6rnCayt8m
 EWTxoa/9vUNl5MsK0P1olBocFpqkwPgz8xe/jLDAdLirOZ6csilKdajGQqBWsvJwMW1v
 IiVg==
X-Gm-Message-State: AOJu0Yyrg5LhMzIORqQFGhXKazHpUy0Fiu+faOLAll8n6u75Uvbbobir
 hUa/Tb3Hk4zqGt+yRpqosTHZRNIlsle1+AEFPodgEiLxPVxpbwtjYCHkLdF+i7BA4dwmSwK7WHe
 BHfxckIp/4oBeNqiun5IK/EOCcJehD2k=
X-Gm-Gg: AfdE7cmgaPTisCVFlQK8gt3LNtr1yGCkcDcB2vwShXI2DyB4zigkVd21xRg+Rb7v5HM
 b19qW9FYW+FBQSA4Dqvnf2WZ1yFOwdNAXwNE0KEmzKHf2t0TZI6JtLLUlP+b0FOxdVO8rXeQOj6
 DdtzIuDDZ579sVnc4Uuo0Cy+OOE2ybTGTCxjXMFljRnCJ6i9ARrUcYY3cLH7xR6Hr8RHmhV6C5O
 SJTpWtg14o0Z2SwA6E8RZnZAAgUUeRRTWYJLd67y44JCYgH52xhePOXkvcv94e7pjtaFZX0g1rF
 HG5WHWE+AnqDKYi7ou8VbZePUBMHXuOIM3Td+KNZy4Bejp38e4KYu/HXZ3g=
X-Received: by 2002:a05:7022:6295:b0:137:fea7:9297 with SMTP id
 a92af1059eb24-139dba00013mr6884997c88.1.1782746906072; Mon, 29 Jun 2026
 08:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260626085558.97923-1-tvrtko.ursulin@igalia.com>
 <20260626085558.97923-3-tvrtko.ursulin@igalia.com>
 <3694635.dWV9SEqChM@timur-max>
In-Reply-To: <3694635.dWV9SEqChM@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Jun 2026 11:28:14 -0400
X-Gm-Features: AVVi8CeordtiVHL8RXRJMySgdkOJ93IZmDGNbwcoQMvW5S-bBTwE9OJgo78AN9s
Message-ID: <CADnq5_MiRc2Gei3QcmxVgtykLNfC+QwyxC7W=LsAVjMfCAT5_g@mail.gmail.com>
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

On Fri, Jun 26, 2026 at 1:10=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On 2026. j=C3=BAnius 26., p=C3=A9ntek 10:55:57 k=C3=B6z=C3=A9p-eur=C3=B3p=
ai ny=C3=A1ri id=C5=91 Tvrtko Ursulin
> wrote:
> > Every job submission on the Steam Deck ends up walking the list of IP
> > blocks looking for AMD_IP_BLOCK_TYPE_SMC. Half of the call chain is lik=
e
> > the below, while the second half is from amdgpu_gfx_profile_ring_end_us=
e:
> >
> >  amdgpu_gfx_profile_ring_begin_use
> >   amdgpu_dpm_is_overdrive_enabled
> >    is_support_sw_smu
> >     amdgpu_device_ip_is_valid
> >
> > On a game menu screen at 90Hz refresh rate we end up with ~840 calls pe=
r
> > second which sticks out when the submission worker is profiled with per=
f:
> >
> >   13.78%  [kernel]  [k] __lock_text_start
> >   10.86%  [kernel]  [k] __lookup_object
> >    8.76%  [kernel]  [k] __mod_timer
> >    4.94%  [kernel]  [k] queued_spin_lock_slowpath
> >    1.66%  [kernel]  [k] amdgpu_device_ip_is_valid
> >    1.54%  [kernel]  [k] preempt_count_add
> >    1.42%  [kernel]  [k] amdgpu_sync_peek_fence
> >    1.18%  [kernel]  [k] amdgpu_vmid_grab
> >    1.17%  [kernel]  [k] amdgpu_ib_schedule
> >    1.14%  [kernel]  [k] kthread_worker_fn
> >
> > Lets short-circuit this walk by simply caching the result of
> > is_support_sw_smu() in the device.
> >
> > This is a micro-improvement but it is at least conceptually nicer to av=
oid
> > repeating the same walk so much.
>
> Hi,
>
> I agree with cleaning up this thing.
> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>
> That being said, I think is_support_sw_smu() is horrible and should be re=
moved
> alltogether, because it goes against how the rest of the power management=
 code
> works.
>
> In my opinion, we should instead:
>
> 1. Hook up some function pointers and check those instead,
> For example in amdgpu_pm_acpi_event_handler() we should just hook up
> smu_set_ac_dc() to the notify_ac_dc() function pointer. There are plenty =
of
> other similar cases.
> Another example, for amdgpu_dpm_mode1_reset() we should introduce a new
> asic_reset_mode_1() pointer in amd_pm_funcs() similar to how it works wit=
h
> MODE2 reset for consistency.
>
> 2. Eliminate redundant functions where the same thing is already done
> elsewhere.
> For example in amdgpu_dpm_is_mode1_reset_supported() it checks
> smu_mode1_reset_is_support() which is redundant because the supported res=
et
> type is available on the ASIC functions already and we can just use that.
>
> What do you think?

I agree.  This has been a todo for a while.

Alex

>
> Thanks & best regards,
> Timur
>
> >
> > Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > v2:
> >  * Approach changed to cache sw_smu status only.
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  3 +++
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 14 +++++---------
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  8 +++++++-
> >  4 files changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h index 7b09410d6d8f..9803967d15f9
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -851,6 +851,7 @@ struct amdgpu_device {
> >       struct dev_pm_domain            vga_pm_domain;
> >       bool                            have_disp_power_ref;
> >       bool                            have_atomics_support;
> > +     bool                            is_sw_smu;
> >
> >       /* BIOS */
> >       bool                            is_atom_fw;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c index
> > 1e6b75ecafe4..7f935a5778b0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -74,6 +74,7 @@
> >  #include "amdgpu_ras.h"
> >  #include "amdgpu_ras_mgr.h"
> >  #include "amdgpu_pmu.h"
> > +#include "amdgpu_smu.h"
> >  #include "amdgpu_fru_eeprom.h"
> >  #include "amdgpu_reset.h"
> >  #include "amdgpu_virt.h"
> > @@ -2130,6 +2131,8 @@ static int amdgpu_device_ip_early_init(struct
> > amdgpu_device *adev) adev->cg_flags &=3D amdgpu_cg_mask;
> >       adev->pg_flags &=3D amdgpu_pg_mask;
> >
> > +     amdgpu_smu_early_init(adev);
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c index
> > 208a2fba6d40..82c9ae6a5092 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -591,17 +591,13 @@ static int smu_get_power_num_states(void *handle,
> >       return 0;
> >  }
> >
> > -bool is_support_sw_smu(struct amdgpu_device *adev)
> > +void amdgpu_smu_early_init(struct amdgpu_device *adev)
> >  {
> >       /* vega20 is 11.0.2, but it's supported via the powerplay code */
> > -     if (adev->asic_type =3D=3D CHIP_VEGA20)
> > -             return false;
> > -
> > -     if ((amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D IP_VERSION(11, 0, =
0))
> &&
> > -         amdgpu_device_ip_is_valid(adev, AMD_IP_BLOCK_TYPE_SMC))
> > -             return true;
> > -
> > -     return false;
> > +     adev->is_sw_smu =3D adev->asic_type !=3D CHIP_VEGA20 &&
> > +                       (amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D
> > +                        IP_VERSION(11, 0, 0) &&
> > +                        amdgpu_device_ip_is_valid(adev,
> AMD_IP_BLOCK_TYPE_SMC));
> >  }
> >
> >  bool is_support_cclk_dpm(struct amdgpu_device *adev)
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h index
> > d76e0b005308..efc52d97058b 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > @@ -1952,7 +1952,13 @@ int smu_link_reset(struct smu_context *smu);
> >
> >  extern const struct amd_ip_funcs smu_ip_funcs;
> >
> > -bool is_support_sw_smu(struct amdgpu_device *adev);
> > +void amdgpu_smu_early_init(struct amdgpu_device *adev);
> > +
> > +static inline bool is_support_sw_smu(struct amdgpu_device *adev)
> > +{
> > +     return adev->is_sw_smu;
> > +}
> > +
> >  bool is_support_cclk_dpm(struct amdgpu_device *adev);
> >  int smu_write_watermarks_table(struct smu_context *smu);
>
>
>
>
