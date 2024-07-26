Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47774C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 18:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FEB10E0BA;
	Fri, 26 Jul 2024 18:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jhaqJOlL";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5928E10E0BA
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 18:43:34 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2cb4c584029so964007a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722019414; x=1722624214; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0LqrlyYyt+E51e7c+AzwCR8D7Z9qQFETlWAPK+1nWA=;
 b=jhaqJOlL/SU9xf8MU1eEQugdKCfS+sJzwifcKv7fbQlR7Gj+bIexTAFcLuTf6nktco
 1G7nOfuxWycSEZ0m0w1d8VlXrWv1V8ycjHVVK5jjdy3Ljmf4NF2Q+ryYgG6ofxxcdxxM
 eDOKdz0YdxNhkahz8JtnPm5pSjg8A7dw3hhOYi3ZkAKjdzQ2HC+Ve44wpbEpIwr4KzhE
 h7IPseJ8Ea1gNW+OLHpd+jtzoGunWZQLiGe9SVqp15uaH0FuxcgIafJn6sVYN7hlDz6I
 +ebCTAxqmr1b9H2oq1rrmlijS1kEOS0c3u03qf+4tpRep6sxz91iMClC+MQbdtvn6B0m
 hEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722019414; x=1722624214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0LqrlyYyt+E51e7c+AzwCR8D7Z9qQFETlWAPK+1nWA=;
 b=NQeBoYpqwOnHwJ138KdapXOV01oH+fI7RABpuE9rGhF9IoPn/TBqlFurqkrdUn7F+/
 jVVx0yyvyzpMsC/jilzeNqsaOSTns6N96ZZ305Wl4u5os+x1hjFkvoSP20iOhEebKUnu
 /wzE6lHFFrDQaS/VekxiTk0UoAhox+wwBJBslD66UZsAOxFBe6yd5pvMO5cxanzmkz+/
 Jf/OcM+HKNFQcvSL84J4m/QMcOcqyrPiZFi/n1efDzKPSewfPNdW/Zx9Z1l06cX5onOM
 C0AADSaBldp+ynTQXpAMVK9t7pXA5HeHZCIaP26MTsWJZSVH/OXq3uUs//NC7eYVe9zo
 wcig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAUt1bstSkHEXoh67SkkfPEToUR266yLFHSOfvj305E9p0o4+zBPBr05brm9FenvIP/5594CuvvGDvsMpf9VbiURzCzed/VSYN36DaCA==
X-Gm-Message-State: AOJu0YyrS4Anpy4Mn37LNtFjIIRGcpBgJT75Q0Kg8Z7QyUhH4OD4hCNq
 ceygxlg0FGi+RZFh/LuqB2kBhmYUcaVOY/dKVO/Za+DBuTa0i2g+bb1ixM0IwYXuOiqvhfZR+QQ
 KIUexDfNJyAp+xZes0jQAB2sR24k=
X-Google-Smtp-Source: AGHT+IHpn61Tlsl8SReQvXYTSuaVJhGeq8CMh6IE9buv+uzL8Sl9+LzPOWNQkysl2uUVFHMXxURSaWNmnM2QzsnhmAE=
X-Received: by 2002:a17:90b:e8e:b0:2c9:5a87:f17c with SMTP id
 98e67ed59e1d1-2cf7e1d8e63mr395407a91.15.1722019413574; Fri, 26 Jul 2024
 11:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
 <20240726124751.3121312-2-sunil.khatri@amd.com>
 <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
 <57660e1e-1aad-4ba6-be90-abda2b377e3f@amd.com>
 <f967ce91-dd88-4542-8340-1e61813eb780@amd.com>
 <d49c682a-57ea-4061-8b42-59764f603164@amd.com>
 <77bb2c37-d906-4c76-b87d-effbbe6064e4@amd.com>
 <23d1ef60-5756-4c4f-9fb8-04ff0dc31821@amd.com>
In-Reply-To: <23d1ef60-5756-4c4f-9fb8-04ff0dc31821@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jul 2024 14:43:22 -0400
Message-ID: <CADnq5_OY_Zoqcrk-n6JvLt8fQCQifAfMX9r8a0qyRu0i9UEEaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: "Lazar, Lijo" <lijo.lazar@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

On Fri, Jul 26, 2024 at 1:16=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
>
> On 7/26/2024 8:36 PM, Lazar, Lijo wrote:
> >
> > On 7/26/2024 8:11 PM, Khatri, Sunil wrote:
> >> On 7/26/2024 7:53 PM, Khatri, Sunil wrote:
> >>> On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
> >>>> On 7/26/2024 6:42 PM, Alex Deucher wrote:
> >>>>> On Fri, Jul 26, 2024 at 8:48=E2=80=AFAM Sunil Khatri <sunil.khatri@=
amd.com>
> >>>>> wrote:
> >>>>>> Problem:
> >>>>>> IP dump right now is done post suspend of
> >>>>>> all IP's which for some IP's could change power
> >>>>>> state and software state too which we do not want
> >>>>>> to reflect in the dump as it might not be same at
> >>>>>> the time of hang.
> >>>>>>
> >>>>>> Solution:
> >>>>>> IP should be dumped as close to the HW state when
> >>>>>> the GPU was in hung state without trying to reinitialize
> >>>>>> any resource.
> >>>>>>
> >>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>
> >>>>>> ---
> >>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60
> >>>>>> +++++++++++-----------
> >>>>>>    1 file changed, 30 insertions(+), 30 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>> index 730dae77570c..74f6f15e73b5 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>>>> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct
> >>>>>> amdgpu_device *adev)
> >>>>>>           return ret;
> >>>>>>    }
> >>>>>>
> >>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
> >>>>>> +{
> >>>>>> +       int i;
> >>>>>> +
> >>>>>> +       lockdep_assert_held(&adev->reset_domain->sem);
> >>>>>> +
> >>>>>> +       for (i =3D 0; i < adev->reset_info.num_regs; i++) {
> >>>>>> +               adev->reset_info.reset_dump_reg_value[i] =3D
> >>>>>> +
> >>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
> >>>> A suspend also involves power/clock ungate. When reg dump is moved
> >>>> earlier, I'm not sure if this read works for all. If it's left to
> >>>> individual IP call backs, they could just do the same or better to m=
ove
> >>>> these up before a dump.
> >>> Suspend also put the status.hw =3D false and each IP in their respect=
ive
> >>> suspend state which i feel does change the state of the HW.
> >>> To get the correct snapshot of the GPU register we should not be
> >>> fiddling with the HW IP at least till we capture the dump and that is
> >>> the intention behind the change.
> >>>
> >>> Do you think there is a problem in this approach?
> >>>>           amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> >>>>           amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> >>> Adding this does sounds better to enable just before we dump the
> >>> registers but i am not very sure if ungating would be clean here or
> >>> not. i Could try quickly adding these two calls just before dump.
> >>>
> >>> All i am worried if it does change some register reflecting the
> >>> original state of registers at dump.
> >>>
> > I was thinking that if it includes some GFX regs and the hang happened
> > because of some SDMA/VCN jobs which somehow keeps GFXOFF state intact.
>
> For GFX and SDMA hangs we make sure to disable GFXOFF before so for
> those IP's
> I am not worried and also based on my testing on NAVI22 for GPU hang
> their registers
> seems to be read cleanly.
> Another point that i was thinking is after a GPU hang no where till the
> point of dump
> any registers are touched and that is what we need considering we are
> able to read the registers.
>
> For VCN there is dynamic gating which is controlled by the FW if i am
> not wrong which makes the VCN
> off and registers cant be read. Only in case of VCN hang i am assuming
> due to a Job pending VCN should be in power ON
> state and out intent of reading the registers should work fine. Sadly i
> am unable to validate it as there arent any test readily
> available to hang VCN.

We want to take the register dump as early as possible in the reset
sequence, ideally before any of the hw gets touched as part of the
reset sequence.  Otherwise, the dump is not going to be useful.

Alex


>
> >
> > BTW, since there is already dump_ip state which could capture IP regs
> > separately and handle their power/clock gate situations, do you think
> > this generic one is still needed?
> >
> > For whatever we have implemented till now seems to work fine in case of=
 GPU hang withotu fidling the
> > power state explicitly. But Calling suspend of each IP surely seems to =
change some state in IPs and SW state too.
> > So i think until we experience a real problem we should go without the =
generic UNGATE call for all IP's
> >
> > But i am not an expert of power, so whatever you suggest would make mor=
e sense for the driver.
> Regards
> Sunil Khatri
> >
> > Thanks,
> > Lijo
> >
> >>> What u suggest ?
> >>> Regards
> >>> Sunil
> >> I quickly validated on Navi22 by adding below call just before we dump
> >> registers
> >> if(!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
> >>
> >>      amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> >>      amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> >>
> >>      amdgpu_reset_reg_dumps(tmp_adev);
> >>      dev_info(tmp_adev->dev, "Dumping IP State\n");
> >>      /* Trigger ip dump before we reset the asic */
> >>      for(i=3D0; i<tmp_adev->num_ip_blocks; i++)
> >>          if(tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
> >>              tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
> >>                                      (void*)tmp_adev);
> >>      dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
> >> }
> >> If this sounds fine with you i am update that. Regards Sunil Khatri
> >>>> Thanks,
> >>>> Lijo
> >>>>
> >>>>>> +
> >>>>>> +
> >>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[=
i],
> >>>>>> +
> >>>>>> adev->reset_info.reset_dump_reg_value[i]);
> >>>>>> +       }
> >>>>>> +
> >>>>>> +       return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>>    int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> >>>>>>                                    struct amdgpu_reset_context
> >>>>>> *reset_context)
> >>>>>>    {
> >>>>>>           int i, r =3D 0;
> >>>>>>           struct amdgpu_job *job =3D NULL;
> >>>>>> +       struct amdgpu_device *tmp_adev =3D reset_context->reset_re=
q_dev;
> >>>>>>           bool need_full_reset =3D
> >>>>>>                   test_bit(AMDGPU_NEED_FULL_RESET,
> >>>>>> &reset_context->flags);
> >>>>>>
> >>>>>> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct
> >>>>>> amdgpu_device *adev,
> >>>>>>                           }
> >>>>>>                   }
> >>>>>>
> >>>>>> +               if (!test_bit(AMDGPU_SKIP_COREDUMP,
> >>>>>> &reset_context->flags)) {
> >>>>>> +                       amdgpu_reset_reg_dumps(tmp_adev);
> >>>>>> +
> >>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State\=
n");
> >>>>>> +                       /* Trigger ip dump before we reset the asi=
c */
> >>>>>> +                       for (i =3D 0; i < tmp_adev->num_ip_blocks;=
 i++)
> >>>>>> +                               if
> >>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
> >>>>>> +
> >>>>>> tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
> >>>>>> +                                                       (void
> >>>>>> *)tmp_adev);
> >>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State
> >>>>>> Completed\n");
> >>>>>> +               }
> >>>>>> +
> >>>>>>                   if (need_full_reset)
> >>>>>>                           r =3D amdgpu_device_ip_suspend(adev);
> >>>>>>                   if (need_full_reset)
> >>>>>> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct
> >>>>>> amdgpu_device *adev,
> >>>>>>           return r;
> >>>>>>    }
> >>>>>>
> >>>>>> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
> >>>>>> -{
> >>>>>> -       int i;
> >>>>>> -
> >>>>>> -       lockdep_assert_held(&adev->reset_domain->sem);
> >>>>>> -
> >>>>>> -       for (i =3D 0; i < adev->reset_info.num_regs; i++) {
> >>>>>> -               adev->reset_info.reset_dump_reg_value[i] =3D
> >>>>>> -
> >>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
> >>>>>> -
> >>>>>> -
> >>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[=
i],
> >>>>>> -
> >>>>>> adev->reset_info.reset_dump_reg_value[i]);
> >>>>>> -       }
> >>>>>> -
> >>>>>> -       return 0;
> >>>>>> -}
> >>>>>> -
> >>>>>>    int amdgpu_do_asic_reset(struct list_head *device_list_handle,
> >>>>>>                            struct amdgpu_reset_context *reset_cont=
ext)
> >>>>>>    {
> >>>>>>           struct amdgpu_device *tmp_adev =3D NULL;
> >>>>>>           bool need_full_reset, skip_hw_reset, vram_lost =3D false=
;
> >>>>>>           int r =3D 0;
> >>>>>> -       uint32_t i;
> >>>>>>
> >>>>>>           /* Try reset handler method first */
> >>>>>>           tmp_adev =3D list_first_entry(device_list_handle, struct
> >>>>>> amdgpu_device,
> >>>>>>                                       reset_list);
> >>>>>>
> >>>>>> -       if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)=
) {
> >>>>>> -               amdgpu_reset_reg_dumps(tmp_adev);
> >>>>>> -
> >>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
> >>>>>> -               /* Trigger ip dump before we reset the asic */
> >>>>>> -               for (i =3D 0; i < tmp_adev->num_ip_blocks; i++)
> >>>>>> -                       if
> >>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
> >>>>>> -                               tmp_adev->ip_blocks[i].version->fu=
ncs
> >>>>>> -                               ->dump_ip_state((void *)tmp_adev);
> >>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State
> >>>>>> Completed\n");
> >>>>>> -       }
> >>>>>> -
> >>>>>>           reset_context->reset_device_list =3D device_list_handle;
> >>>>>>           r =3D amdgpu_reset_perform_reset(tmp_adev, reset_context=
);
> >>>>>>           /* If reset handler not implemented, continue; otherwise
> >>>>>> return */
> >>>>>> --
> >>>>>> 2.34.1
> >>>>>>
