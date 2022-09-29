Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA60C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 18:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F2010E035;
	Thu, 29 Sep 2022 18:32:38 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9073B10E035
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 18:32:33 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 r15-20020a4abf0f000000b004761c7e6be1so686991oop.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 11:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=cy4lCaoI+ZrqyKzpoE7JytiMOcsslvk8NMjGhsDdvNY=;
 b=B+Pm0LSYMFl0API4uyD4MiTGNt42yhMrvJNhahYcpOQxrUH9cXqN9SnOiqJrQmaWUg
 mO6oV6/IPfGBzyfC/vv4TiXmd+w7J5ge+/INhSXL4Db/3+tdi3W72nUJq4tFDYx2+4RB
 Kf8xRqq27WPq4N18eZReXH2BSU7nQy77URXGQkBv8kyh+cCbHUGKLKO1IEzimUrh9Gud
 BBeRekm5NV7MvosLjV9SkErvTdWiX82I8Rh1siu9hDu7YPV+NdPTnO5BYc9qBpWRg95Q
 wyNVvprlfxyY/P3aLoyzoHwgGl4jzkbe1ErSJPUlE6iV6l2YJHGZ1COcDQO1hDsaNAEW
 7F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=cy4lCaoI+ZrqyKzpoE7JytiMOcsslvk8NMjGhsDdvNY=;
 b=Hh7h+HE1ewKzsWS+l23Gq0XCAdcLvfbv/V72g2H+voHLiCO7UvqZKXf8S1T0sOEGNV
 34NbVarqphN2SgX7oaQdYzdywAip+8o0nYE3s7YKXN25gxQ56DLegHFdok5qKZjZAmyB
 DUJdsCPFBFhEwpghmpqnzs7cTKsqP2Y78kJ48B+WICJKFHTwDEM+QGr4TLbyDOs//Smv
 OeGPSrRx073+LLhyQSseZjVd7DPHx1rne+t7i9HbB0haUDdljUZYZecEDsYWQfwrI4wT
 sDDgoXp+LwVQWyia/BKh0K84OrYp5C+VonZLSqlUtBlX5sW7r1OHJgsx14ACrpXmjvD9
 sCEg==
X-Gm-Message-State: ACrzQf0xzi2l33kiw6yIlv63S7ZSeO2bbpTYd6aBGX8x+/qq2sZKULiS
 PKHzm28PN6Hczt8rxzczV/LXKFRtSXntzr5I9oA=
X-Google-Smtp-Source: AMsMyM6bdWuCCdvKlrIwjIR+2a7xx2ElgFtajLmvZB9b2RP5grVyJXE2lN218YYATd5EYlDE3wq2kU73FMhJTTC3Q9Y=
X-Received: by 2002:a9d:450a:0:b0:655:f46f:2bed with SMTP id
 w10-20020a9d450a000000b00655f46f2bedmr1957303ote.123.1664476352505; Thu, 29
 Sep 2022 11:32:32 -0700 (PDT)
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
 <CADnq5_Mg7GFW=s6W5xeGa5vG7_GmedsP6uQG_dpZKkzp1CDJqg@mail.gmail.com>
 <5bf6d05a-58e4-0057-1445-9369b20b1a67@amd.com>
 <369b2225-87a3-b976-bbd1-6f73f190b44a@amd.com>
 <05b4b97e-422d-dc00-bc3f-4dd04758a3c9@amd.com>
 <4cfb549b-9a76-f950-119d-e6e345841d5c@amd.com>
 <fc87e88d-4de0-f307-1fb2-658df564a3a1@amd.com>
 <46b27eb5-1807-044f-111a-bb67622e7fd6@amd.com>
In-Reply-To: <46b27eb5-1807-044f-111a-bb67622e7fd6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Sep 2022 14:32:20 -0400
Message-ID: <CADnq5_O5hdJyQZSUXrZRsauNMwes8GLFOnivfiaLKS_DN3908Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] drm/amdgpu: switch workload context to/from compute
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amaranath.somalapuram@amd.com,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 29, 2022 at 10:14 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 9/29/2022 7:30 PM, Sharma, Shashank wrote:
> >
> >
> > On 9/29/2022 3:37 PM, Lazar, Lijo wrote:
> >> To be clear your understanding -
> >>
> >> Nothing is automatic in PMFW. PMFW picks a priority based on the
> >> actual mask sent by driver.
> >>
> >> Assuming lower bits corresponds to highest priority -
> >>
> >> If driver sends a mask with Bit3 and Bit 0 set, PMFW will chose
> >> profile that corresponds to Bit0. If driver sends a mask with Bit4
> >> Bit2 set and rest unset, PMFW will chose profile that corresponds to
> >> Bit2. However if driver sends a mask only with a single bit set, it
> >> chooses the profile regardless of whatever was the previous profile. t
> >> doesn't check if the existing profile > newly requested one. That is
> >> the behavior.
> >>
> >> So if a job send chooses a profile that corresponds to Bit0, driver
> >> will send that. Next time if another job chooses a profile that
> >> corresponds to Bit1, PMFW will receive that as the new profile and
> >> switch to that. It trusts the driver to send the proper workload mask.
> >>
> >> Hope that gives the picture.
> >>
> >
> >
> > Thanks, my understanding is also similar, referring to the core power
> > switch profile function here:
> > amd_powerplay.c::pp_dpm_switch_power_profile()
> > *snip code*
> > hwmgr->workload_mask |= (1 << hwmgr->workload_prority[type]);
> >          index = fls(hwmgr->workload_mask);
> >          index = index <= Workload_Policy_Max ? index - 1 : 0;
> >          workload = hwmgr->workload_setting[index];
> > *snip_code*
> > hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload, 0);
> >
> > Here I can see that the new workload mask is appended into the existing
> > workload mask (not overwritten). So if we keep sending new
> > workload_modes, they would be appended into the workload flags and
> > finally the PM will pick the most aggressive one of all these flags, as
> > per its policy.
> >
>
> Actually it's misleading -
>
> The path for sienna is -
> set_power_profile_mode -> sienna_cichlid_set_power_profile_mode
>
>
> This code here is a picking one based on lookup table.
>
>   workload_type = smu_cmn_to_asic_specific_index(smu,
>
> CMN2ASIC_MAPPING_WORKLOAD,
>
> smu->power_profile_mode);
>
> This is that lookup table -
>
> static struct cmn2asic_mapping
> sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT,
> WORKLOAD_PPLIB_DEFAULT_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
> WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,
> WORKLOAD_PPLIB_POWER_SAVING_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
> WORKLOAD_PPLIB_VIDEO_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
> WORKLOAD_PPLIB_VR_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
> WORKLOAD_PPLIB_COMPUTE_BIT),
>          WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> WORKLOAD_PPLIB_CUSTOM_BIT),
> };
>
>
> And this is the place of interaction with PMFW. (1 << workload_type) is
> the mask being sent.
>
>         smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
>                                      1 << workload_type, NULL);
>
> In the end, driver implementation expects only one bit to be set.

Shashank and I had a discussion about this today.  I think there are a
few thing we can do to handle this better:

1. Set a flag that if the user changes the default via sysfs that
overrides any runtime setting via an application since presumably that
is what the user wants and we won't change the hint at runtime.
2. Drop the GET API.  There's no need for this, the hint is just a hint.
2. Have the driver arbitrate between the available workload profiles
based on the numeric value of the hint (e.g., default < 3D < video <
VR < compute) as the higher values are more aggressive in most cases.
If requests come in for 3D and compute at the same time, the driver
will select compute because it's value is highest.  Each hint type
would be ref counted so we'd know what state to be in every time we go
to set the state.  If all of the clients requesting compute go away,
and only 3D requestors remain, we can switch to 3D.  If all refcounts
go to 0, we go back to default.  This will not require any change to
the current workload API in the SMU code.

Alex

>
> Thanks,
> Lijo
>
> > Now, when we have a single workload:
> > -> Job1: requests profile P1 via UAPI, ref count = 1
> > -> driver sends flags for p1
> > -> PM FW applies profile P1
> > -> Job executes in profile P1
> > -> Job goes to reset function, ref_count = 0,
> > -> Power profile resets
> >
> > Now, we have conflicts only when we see multiple workloads (Job1 and Job 2)
> > -> Job1: requests profile P1 via UAPI, ref count = 1
> > -> driver sends flags for p1
> > -> PM FW applies profile P1
> > -> Job executes in profile P1
> > -> Job2: requests profile P2 via UAPI, refcount = 2
> > -> driver sends flags for (P1|P2)
> > -> PM FW picks the more aggressive of the two (Say P1, stays in P1)
> > -> Job1 goes to reset function, ref_count = 1, job1 does not reset power
> > profile
> > -> Job2 goes to reset function, ref_counter = 2, job 2 resets Power profile
> > -> Power profile resets to None
> >
> > So this state machine looks like if there is only 1 job, it will be
> > executed in desired mode. But if there are multiple, the most aggressive
> > profile will be picked, and every job will be executed in atleast the
> > requested power profile mode or higher.
> >
> > Do you find any problem so far ?
> >
> > - Shashank
> >
> >
> >> Thanks,
> >> Lijo
