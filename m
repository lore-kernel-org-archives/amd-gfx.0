Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D21C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 21:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDA910EA45;
	Wed, 28 Sep 2022 21:52:04 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5BD10EA45
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 21:52:00 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 x23-20020a056830409700b00655c6dace73so9012331ott.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 14:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date;
 bh=p2TEYk2KigaRxb79NAXrhbe5tzVpnLLncETjBF16/QE=;
 b=Y107p4XdOUY/G3HsFCOKo6+/wOin9DMH4yo2v79GvyYYsUGHbLq4SAXxqsCwm/xPb6
 ICcDebdNOPC4HStPXTU2rnL+TF6hMcz0mbgQZMRhFZ8FEQVJj1EOIfgFSLJkXWM8G0cx
 Cu4U3IAv5DqpRZB4uypnZopSSDh3JS6NIuPTF4qhnlK7Hd3MzBGz+Wew3JG1czVyd+DB
 7t45yRYyIhEaej2VqRZmvs0GIJYKdUNz5Q45Bqv8DfO06cKjEHW8cOh2tBk756o5tBFJ
 ylSOgHxreRArW8PyKdi3sQE+Cdc4d3bYmOtfOWj3GDvrx+WtlEHN2b17NmxooUNvuV42
 +ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=p2TEYk2KigaRxb79NAXrhbe5tzVpnLLncETjBF16/QE=;
 b=Ogv1brZ1o+nlfWHKBrkIYFbwWlKYoYMza7ZEoyCD1fkIBnDMgRa5drg0ww97HbDMXH
 BwVJDi1Wra/eoZuvKuIvKO8HijxHFwjlDsbaOd9qsBDSVN2DKru56XvlvXPfWwPLwe/T
 NlOC4o+LPO9NLdLckdMkhA1zLLSNRUpNpnugWpskPt0jkeCaFz2Mjgt6eiqUaa2rFY0U
 A7VarNgtTCM2BLklVLteGUkCMitWeod6QUnvOZCT5B2Ft1Iuq5Iwo/ZEbGziXomJtX2X
 hc0OwslyPv0ck7hVLJvMoLQ96TrfnJOTmtgtv58prAoQ1HpMJ5SMx5FDs0/DObjmudBB
 MLSA==
X-Gm-Message-State: ACrzQf1j8SRm69UDxXmZNwmTvED4ELNI0PMVqZRPi28EJsDPBXWkL1l5
 VRWVOuXRDbRIsY5ifIw1ktNfM1N4odU9JScsXOI=
X-Google-Smtp-Source: AMsMyM5VlWOR9rx8D9e2bTpH5kY4lBZgQGje9M0A+7+r+ynM0oQaZZV9B1yl0mZrS/JG6Yqx37fYyMYbhtgTtzWdQFs=
X-Received: by 2002:a9d:376:0:b0:655:b4bc:fd6e with SMTP id
 109-20020a9d0376000000b00655b4bcfd6emr15690647otv.233.1664401919549; Wed, 28
 Sep 2022 14:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-6-shashank.sharma@amd.com>
 <6a0d7dea-8c5e-701d-9231-d6f76df76706@amd.com>
 <aa663a5a-3bc4-393e-ff4b-73e3247e79fa@amd.com>
 <6d8dd85d-5d6f-8364-b710-9483944a2090@amd.com>
 <d4037915-2281-b12b-e38b-2e947fb34c75@amd.com>
 <72aa5f24-8f66-2a8b-3338-a082541dd4aa@amd.com>
 <CADnq5_PavsH-=7hQjWn7aBSCVs30AYdNa_ixDUn7o-BRLh=78A@mail.gmail.com>
 <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
In-Reply-To: <546cc67c-f17b-de76-afa1-2823f09120e8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Sep 2022 17:51:47 -0400
Message-ID: <CADnq5_Mg7GFW=s6W5xeGa5vG7_GmedsP6uQG_dpZKkzp1CDJqg@mail.gmail.com>
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

On Wed, Sep 28, 2022 at 4:57 AM Sharma, Shashank
<shashank.sharma@amd.com> wrote:
>
>
>
> On 9/27/2022 10:40 PM, Alex Deucher wrote:
> > On Tue, Sep 27, 2022 at 11:38 AM Sharma, Shashank
> > <shashank.sharma@amd.com> wrote:
> >>
> >>
> >>
> >> On 9/27/2022 5:23 PM, Felix Kuehling wrote:
> >>> Am 2022-09-27 um 10:58 schrieb Sharma, Shashank:
> >>>> Hello Felix,
> >>>>
> >>>> Thank for the review comments.
> >>>>
> >>>> On 9/27/2022 4:48 PM, Felix Kuehling wrote:
> >>>>> Am 2022-09-27 um 02:12 schrieb Christian K=C3=B6nig:
> >>>>>> Am 26.09.22 um 23:40 schrieb Shashank Sharma:
> >>>>>>> This patch switches the GPU workload mode to/from
> >>>>>>> compute mode, while submitting compute workload.
> >>>>>>>
> >>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>>>>
> >>>>>> Feel free to add my acked-by, but Felix should probably take a loo=
k
> >>>>>> as well.
> >>>>>
> >>>>> This look OK purely from a compute perspective. But I'm concerned
> >>>>> about the interaction of compute with graphics or multiple graphics
> >>>>> contexts submitting work concurrently. They would constantly overri=
de
> >>>>> or disable each other's workload hints.
> >>>>>
> >>>>> For example, you have an amdgpu_ctx with
> >>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE (maybe Vulkan compute) and a KFD
> >>>>> process that also wants the compute profile. Those could be differe=
nt
> >>>>> processes belonging to different users. Say, KFD enables the comput=
e
> >>>>> profile first. Then the graphics context submits a job. At the star=
t
> >>>>> of the job, the compute profile is enabled. That's a no-op because
> >>>>> KFD already enabled the compute profile. When the job finishes, it
> >>>>> disables the compute profile for everyone, including KFD. That's
> >>>>> unexpected.
> >>>>>
> >>>>
> >>>> In this case, it will not disable the compute profile, as the
> >>>> reference counter will not be zero. The reset_profile() will only ac=
t
> >>>> if the reference counter is 0.
> >>>
> >>> OK, I missed the reference counter.
> >>>
> >>>
> >>>>
> >>>> But I would be happy to get any inputs about a policy which can be
> >>>> more sustainable and gets better outputs, for example:
> >>>> - should we not allow a profile change, if a PP mode is already
> >>>> applied and keep it Early bird basis ?
> >>>>
> >>>> For example: Policy A
> >>>> - Job A sets the profile to compute
> >>>> - Job B tries to set profile to 3D, but we do not allow it as job A =
is
> >>>> not finished it yet.
> >>>>
> >>>> Or Policy B: Current one
> >>>> - Job A sets the profile to compute
> >>>> - Job B tries to set profile to 3D, and we allow it. Job A also runs
> >>>> in PP 3D
> >>>> - Job B finishes, but does not reset PP as reference count is not ze=
ro
> >>>> due to compute
> >>>> - Job  A finishes, profile reset to NONE
> >>>
> >>> I think this won't work. As I understand it, the
> >>> amdgpu_dpm_switch_power_profile enables and disables individual
> >>> profiles. Disabling the 3D profile doesn't disable the compute profil=
e
> >>> at the same time. I think you'll need one refcount per profile.
> >>>
> >>> Regards,
> >>>     Felix
> >>
> >> Thanks, This is exactly what I was looking for, I think Alex's initial
> >> idea was around it, but I was under the assumption that there is only
> >> one HW profile in SMU which keeps on getting overwritten. This can sol=
ve
> >> our problems, as I can create an array of reference counters, and will
> >> disable only the profile whose reference counter goes 0.
> >
> > It's been a while since I paged any of this code into my head, but I
> > believe the actual workload message in the SMU is a mask where you can
> > specify multiple workload types at the same time and the SMU will
> > arbitrate between them internally.  E.g., the most aggressive one will
> > be selected out of the ones specified.  I think in the driver we just
> > set one bit at a time using the current interface.  It might be better
> > to change the interface and just ref count the hint types and then
> > when we call the set function look at the ref counts for each hint
> > type and set the mask as appropriate.
> >
> > Alex
> >
>
> Hey Alex,
> Thanks for your comment, if that is the case, this current patch series
> works straight forward, and no changes would be required. Please let me
> know if my understanding is correct:
>
> Assumption: Order of aggression: 3D > Media > Compute
>
> - Job 1: Requests mode compute: PP changed to compute, ref count 1
> - Job 2: Requests mode media: PP changed to media, ref count 2
> - Job 3: requests mode 3D: PP changed to 3D, ref count 3
> - Job 1 finishes, downs ref count to 2, doesn't reset the PP as ref > 0,
> PP still 3D
> - Job 3 finishes, downs ref count to 1, doesn't reset the PP as ref > 0,
> PP still 3D
> - Job 2 finishes, downs ref count to 0, PP changed to NONE,
>
> In this way, every job will be operating in the Power profile of desired
> aggression or higher, and this API guarantees the execution at-least in
> the desired power profile.

I'm not entirely sure on the relative levels of aggression, but I
believe the SMU priorities them by index.  E.g.
#define WORKLOAD_PPLIB_DEFAULT_BIT        0
#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 1
#define WORKLOAD_PPLIB_POWER_SAVING_BIT   2
#define WORKLOAD_PPLIB_VIDEO_BIT          3
#define WORKLOAD_PPLIB_VR_BIT             4
#define WORKLOAD_PPLIB_COMPUTE_BIT        5
#define WORKLOAD_PPLIB_CUSTOM_BIT         6

3D < video < VR < compute < custom

VR and compute are the most aggressive.  Custom takes preference
because it's user customizable.

Alex




>
> - Shashank
>
> >
> >>
> >> - Shashank
> >>
> >>>
> >>>
> >>>>
> >>>>
> >>>> Or anything else ?
> >>>>
> >>>> REgards
> >>>> Shashank
> >>>>
> >>>>
> >>>>> Or you have multiple VCN contexts. When context1 finishes a job, it
> >>>>> disables the VIDEO profile. But context2 still has a job on the oth=
er
> >>>>> VCN engine and wants the VIDEO profile to still be enabled.
> >>>>>
> >>>>> Regards,
> >>>>>     Felix
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> Christian.
> >>>>>>
> >>>>>>> ---
> >>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 14 +++++++++++---
> >>>>>>>    1 file changed, 11 insertions(+), 3 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>>>>>> index 5e53a5293935..1caed319a448 100644
> >>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> >>>>>>> @@ -34,6 +34,7 @@
> >>>>>>>    #include "amdgpu_ras.h"
> >>>>>>>    #include "amdgpu_umc.h"
> >>>>>>>    #include "amdgpu_reset.h"
> >>>>>>> +#include "amdgpu_ctx_workload.h"
> >>>>>>>      /* Total memory size in system memory and all GPU VRAM. Used=
 to
> >>>>>>>     * estimate worst case amount of memory to reserve for page ta=
bles
> >>>>>>> @@ -703,9 +704,16 @@ int amdgpu_amdkfd_submit_ib(struct
> >>>>>>> amdgpu_device *adev,
> >>>>>>>      void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *ad=
ev,
> >>>>>>> bool idle)
> >>>>>>>    {
> >>>>>>> -    amdgpu_dpm_switch_power_profile(adev,
> >>>>>>> -                    PP_SMC_POWER_PROFILE_COMPUTE,
> >>>>>>> -                    !idle);
> >>>>>>> +    int ret;
> >>>>>>> +
> >>>>>>> +    if (idle)
> >>>>>>> +        ret =3D amdgpu_clear_workload_profile(adev,
> >>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
> >>>>>>> +    else
> >>>>>>> +        ret =3D amdgpu_set_workload_profile(adev,
> >>>>>>> AMDGPU_CTX_WORKLOAD_HINT_COMPUTE);
> >>>>>>> +
> >>>>>>> +    if (ret)
> >>>>>>> +        drm_warn(&adev->ddev, "Failed to %s power profile to
> >>>>>>> compute mode\n",
> >>>>>>> +             idle ? "reset" : "set");
> >>>>>>>    }
> >>>>>>>      bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u=
32
> >>>>>>> vmid)
> >>>>>>
