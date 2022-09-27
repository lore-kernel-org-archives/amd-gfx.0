Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815F8C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 20:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3AE610E01F;
	Tue, 27 Sep 2022 20:40:45 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C50310E01F
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 20:40:42 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 w22-20020a056830061600b006546deda3f9so7047465oti.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=0l0sEcy74nNEwzMFTsBswy0i/XLq/2QNn+sEMZBBG7M=;
 b=nOHO0Hq0xI9mm/pPdz3+o/LSNEZo/RrAqWGmuP7qEPEF6V/KrCYFt9gxA15gZuRyco
 o3TMWYn15UozKowjfnZZPE0fUqm/DUzw7komozCWB88gaMvyGKWUT0Ddn3ISb2KO7kKE
 Q0PdG9+DMqrt1U1FARUccGapTzWrBVmy4EWVAm8+Dmh+1/V2lirRc3QTTVSNiulRr63M
 egZlyiVV/n5hGp3tKyjzTtPf+8JHnCMEqdEPoW/2z+5i2lNz5tCrpuhjyroYukiriOVU
 jUzHE1wXtiRtzik2S7WpUE839ipNwIW7VROY50T11z/4ITjVrKjvRw9mTe7EbUk6RGLQ
 ENUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=0l0sEcy74nNEwzMFTsBswy0i/XLq/2QNn+sEMZBBG7M=;
 b=VPc/OKx9/ZrVId1zYqYktTfoUUuG7zTVCtr+pb/UIJsjYm7hzG9hsd3ZVFGpYIuXIy
 HmlBe8UOECCpu5PSLk4BGVD+cW5O5XqzNVB+EqLwvyuirjl17fNUSugEB+RgeJ/7VOLz
 uQF2wGx9gN9cCjKTRzLVpkA48BUVpYcYYHsoBWWkRdYEmai/wVhLOwZaUk7HjQnbCt6Y
 /xjnUlYTF3BsR8Uu8KUJHoY4tXnrFNlihcYRe+8ZV8k9p15nfcZktBq+s/gTgyntDCir
 xKPo4/ZP4C7VPwNbQjYEGBVPKj/k2mR8xxmvq86ZF2qvOZEokpfI8NvzTk1XPrIxJvNW
 LjPA==
X-Gm-Message-State: ACrzQf2ziqLy+kWY06053UhbBFlS62Hd7wMUw80b+5bIHcvtcm0HLrlf
 95cYzOS43vGd7u1E5jLjABv80SbBHiTOQjPcn4KIOp1d
X-Google-Smtp-Source: AMsMyM58Kqv9K5SBAuWhL1zSvE647OydYkpCrZB9Rfx2pfGplp18/rZ/VnTgYLeCrJT0/GZabCAhx4+uMnwzIBIri1w=
X-Received: by 2002:a9d:450a:0:b0:655:f46f:2bed with SMTP id
 w10-20020a9d450a000000b00655f46f2bedmr12960283ote.123.1664311241144; Tue, 27
 Sep 2022 13:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
In-Reply-To: <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Sep 2022 16:40:29 -0400
Message-ID: <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
To: "Sharma, Shashank" <shashank.sharma@amd.com>
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
Cc: alexander.deucher@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 amaranath.somalapuram@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 27, 2022 at 11:38 AM Sharma, Shashank
<shashank.sharma@amd.com> wrote:
>
>
>
> On 9/27/2022 5:23 PM, Felix Kuehling wrote:
> > Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
> >> Hello Felix,
> >>
> >> Thank for the review comments.
> >>
> >> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
> >>> Am 2022-09-27 um 02:12 schrieb Christian K=C3=B6nig:
> >>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
> >>>>> This patch switches the GPU workload mode to/from
> >>>>> compute mode, while submitting compute workload.
> >>>>>
> >>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>>
> >>>> Feel free to add my acked-by, but Felix should probably take a look
> >>>> as well.
> >>>
> >>> This look OK purely from a compute perspective. But I'm concerned
> >>> about the interaction of compute with graphics or multiple graphics
> >>> contexts submitting work concurrently. They would constantly override
> >>> or disable each other's workload hints.
> >>>
> >>> For example, you have an amdgpu_ctx with
> >>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD
> >>> process that also wants the compute profile. Those could be different
> >>> processes belonging to different users. Say, KFD enables the compute
> >>> profile first. Then the graphics context submits a job. At the start
> >>> of the job, the compute profile is enabled. That's a no-op because
> >>> KFD already enabled the compute profile. When the job finishes, it
> >>> disables the compute profile for everyone, including KFD. That's
> >>> unexpected.
> >>>
> >>
> >> In this case, it will not disable the compute profile, as the
> >> reference counter will not be zero. The reset_profile() will only act
> >> if the reference counter is 0.
> >
> > OK, I missed the reference counter.
> >
> >
> >>
> >> But I would be happy to get any inputs about a policy which can be
> >> more sustainable and gets better outputs, for example:
> >> - should we not allow a profile change, if a PP mode is already
> >> applied and keep it Early bird basis ?
> >>
> >> For example: Policy A
> >> - Job A sets the profile to compute
> >> - Job B tries to set profile to 3D, but we do not allow it as job A is
> >> not finished it yet.
> >>
> >> Or Policy B: Current one
> >> - Job A sets the profile to compute
> >> - Job B tries to set profile to 3D, and we allow it. Job A also runs
> >> in PP 3D
> >> - Job B finishes, but does not reset PP as reference count is not zero
> >> due to compute
> >> - Job  A finishes, profile reset to NONE
> >
> > I think this won't work. As I understand it, the
> > amdgpu_dpm_switch_power_profile enables and disables individual
> > profiles. Disabling the 3D profile doesn't disable the compute profile
> > at the same time. I think you'll need one refcount per profile.
> >
> > Regards,
> >    Felix
>
> Thanks, This is exactly what I was looking for, I think Alex's initial
> idea was around it, but I was under the assumption that there is only
> one HW profile in SMU which keeps on getting overwritten. This can solve
> our problems, as I can create an array of reference counters, and will
> disable only the profile whose reference counter goes 0.

It's been a while since I paged any of this code into my head, but I
believe the actual workload message in the SMU is a mask where you can
specify multiple workload types at the same time and the SMU will
arbitrate between them internally.  E.g., the most aggressive one will
be selected out of the ones specified.  I think in the driver we just
set one bit at a time using the current interface.  It might be better
to change the interface and just ref count the hint types and then
when we call the set function look at the ref counts for each hint
type and set the mask as appropriate.

Alex


>
> - Shashank
>
> >
> >
> >>
> >>
> >> Or anything else ?
> >>
> >> REgards
> >> Shashank
> >>
> >>
> >>> Or you have multiple VCN contexts. When context1 finishes a job, it
> >>> disables the VIDEO profile. But context2 still has a job on the other
> >>> VCN engine and wants the VIDEO profile to still be enabled.
> >>>
> >>> Regards,
> >>>    Felix
> >>>
> >>>
> >>>>
> >>>> Christian.
> >>>>
> >>>>> ---
> >>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
> >>>>>   1 file changed, 11 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>>>> index 5e53a5293935..1caed319a448 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>>>> @@ -34,6 +34,7 @@
> >>>>>   #include "amdgpu_ras.h"
> >>>>>   #include "amdgpu_umc.h"
> >>>>>   #include "amdgpu_reset.h"
> >>>>> +#include "amdgpu_ctx_workload.h"
> >>>>>     /* Total memory size in system memory and all GPU VRAM. Used to
> >>>>>    * estimate worst case amount of memory to reserve for page table=
s
> >>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct
> >>>>> amdgpu_device *adev,
> >>>>>     void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev,
> >>>>> bool idle)
> >>>>>   {
> >>>>> -    amdgpu_dpm_switch_power_profile(adev,
> >>>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
> >>>>> -                    !idle);
> >>>>> +    int ret;
> >>>>> +
> >>>>> +    if (idle)
> >>>>> +        ret =3D amdgpu_clear_workload_profile(adev,
> >>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
> >>>>> +    else
> >>>>> +        ret =3D amdgpu_set_workload_profile(adev,
> >>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
> >>>>> +
> >>>>> +    if (ret)
> >>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to
> >>>>> compute mode\n",
> >>>>> +             idle ? "reset" : "set");
> >>>>>   }
> >>>>>     bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32
> >>>>> vmid)
> >>>>
