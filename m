Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BBCC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 02:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71CDF10E313;
	Fri, 17 Dec 2021 02:03:13 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2419A10E307
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 02:03:12 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id m6so1560999oim.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 18:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LBCK6Iwz5eQHgNs7glcVc/9HPa+WjDFOqISqThcvSOo=;
 b=YpXRkVua6vkfk2YdRyCWgQfNOOqDgNDCBfy6wMZ0HwXCPAszZM2+Emc0LS0NAwhCWX
 4bF/tOI3arYshUZ4JECh9v/2BOCCFz5ZQjN9OFzC+gC4X5UuiFXLhCjfzh6BN1qJ/yWC
 j4G85H5Jf2YNlKW6Fl22OZnzo/eFoYfD+Q5085H42FaLFxGllgZKqhK4bNXvouT1zI1n
 3fyv9Yw7whvHC1bklQjbT6zpeRr0ncgRJxbbdutgmsSReOT9fDUw80j6IDFdJXGXb1FB
 AJwdEQCrXgvYEGOOBxEC1Ynrfs1+MYNAfmbH7sTTHThy0+HO22YqidXtUwC/9MPZ7Ve3
 e3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LBCK6Iwz5eQHgNs7glcVc/9HPa+WjDFOqISqThcvSOo=;
 b=iIqL66/zZfr1Jmu0O/VNX+N6ZvbpLstdknYPUud9Tr7Rb0AgCLUMxa9p9t0USrnsGq
 15193uz6UFeGRZrWfKWFFZQ/aAkdhUBPvPjXIbx93olI/3IzYwIWVykzZtys1xkbTwOg
 oeh9epBnoeyCi+NPx76FT64hcvuK5PHrJ19GDhWZcAL6oMW70TL50xwwr+RBfg/UHa+V
 FB6B7vPA+DldpucqZ77DqTFS16PNdQbL6hCbntihGKTjhPXPOu/lnLzwDJBaxdP39uhK
 T+Kf2BjAMc9F+oZBNlSDakpfziEyh4bOYhH4WlonIxtInKYdnE7WdTCIF5ES/lXPYeG2
 CEKA==
X-Gm-Message-State: AOAM531hIN3NCowkS5SpyYmlys8zyIGxi6cyrqBEyhgM+jWlPiTsVRlQ
 9iZk9lsmj6phZLRIH7dlFQCJVUG0uxgI7EEri1yvO17r5bE=
X-Google-Smtp-Source: ABdhPJy+xZjLmKSqt1u5r/Qt4J0E0SiA+5m2l7Z5KUhdoC5be3765/I7X6r/hr6rDahh2OF/KcOe1sq2XnVY8R5CURA=
X-Received: by 2002:a05:6808:44:: with SMTP id v4mr487540oic.123.1639706591181; 
 Thu, 16 Dec 2021 18:03:11 -0800 (PST)
MIME-Version: 1.0
References: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
 <f1f996f4-0bc3-aa01-f9da-3664b14f7861@amd.com>
 <BN7PR12MB2641CA6290B6CEFB4A5016EF9D749@BN7PR12MB2641.namprd12.prod.outlook.com>
 <826e98e0-5e6a-cc87-0690-b444e34bb367@amd.com>
 <DM6PR12MB2619D50306A965F94357A555E4759@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_PthY5p9zDnAHiKTsP8WyptK1Ni+yN4Uqj=JFqJkO7QQw@mail.gmail.com>
 <BYAPR12MB26156AFBEA1B63D12F42CF39E4789@BYAPR12MB2615.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB26156AFBEA1B63D12F42CF39E4789@BYAPR12MB2615.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Dec 2021 21:02:59 -0500
Message-ID: <CADnq5_N=iL12aLj7DdapXFp41W+Jnrb=nS+x-2-DPAYws11zGA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
 powergating is explicitly enabled
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhu,
 James" <James.Zhu@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Gong,
 Curry" <Curry.Gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 16, 2021 at 8:43 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Hi Alex,
>
> Per our checking, vcn_v2 and vcn_v3 already have the dpm disablement(belo=
w) in their ->suspend routine which should prevent them from the issue here=
.
>         if (adev->pm.dpm_enabled)
>                 amdgpu_dpm_enable_uvd(adev, false);
> So, maybe it's a different story with those newer APUs. Can you forward t=
he bug reports to me?

https://gitlab.freedesktop.org/drm/amd/-/issues/1712#note_1192187

Alex

>
> Thanks,
> Evan
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, December 16, 2021 11:38 PM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: Zhu, James <James.Zhu@amd.com>; Gong, Curry
> > <Curry.Gong@amd.com>; amd-gfx@lists.freedesktop.org; Deucher,
> > Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended,
> > powergating is explicitly enabled
> >
> > FWIW, it looks like all versions of VCN need the same fix.  There have =
been
> > reports of suspend failing when VCN is in use on other newer APUs as we=
ll.
> >
> > Alex
> >
> > On Tue, Dec 14, 2021 at 12:59 AM Quan, Evan <Evan.Quan@amd.com> wrote:
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > From: Zhu, James <James.Zhu@amd.com>
> > > Sent: Monday, December 13, 2021 9:39 PM
> > > To: Gong, Curry <Curry.Gong@amd.com>; Zhu, James
> > <James.Zhu@amd.com>;
> > > amd-gfx@lists.freedesktop.org
> > > Cc: Liu, Leo <Leo.Liu@amd.com>; Quan, Evan <Evan.Quan@amd.com>;
> > > Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended=
,
> > > powergating is explicitly enabled
> > >
> > >
> > >
> > > Hi Curry, Evan,
> > >
> > > It seems vcn1.0 power gate sequence are special.
> > >
> > > if the original solution is thread safe, then the following solution =
will be
> > thread safe also.
> > >
> > > static int vcn_v1_0_hw_fini(void *handle) {
> > >     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > >
> > >     cancel_delayed_work_sync(&adev->vcn.idle_work);
> > >
> > >     if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> > >         (adev->vcn.cur_state !=3D AMD_PG_STATE_GATE &&
> > >          RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
> > > +        if (adev->pm.dpm_enabled)
> > > +            amdgpu_dpm_enable_uvd(adev, false);
> > > +        else
> > > +            vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
> > >
> > > [Quan, Evan] Considering adev->pm.dpm_enabled is always true,
> > =E2=80=9Cvcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE); =E2=
=80=9C will
> > become dead code.
> > >
> > > Also, the vcn_v1_0_hw_fini is also used in other scenarios(except the
> > suspend/resume discussed here). So, it seems quite risky compared with
> > Curry=E2=80=99s original patch.
> > >
> > > Before we can come up with a better idea, I would suggest to land Cur=
ry=E2=80=99s
> > original patch as a quick fix.
> > >
> > >
> > >
> > > BR
> > >
> > > Evan
> > >
> > >
> > >     }
> > >
> > > Best Regards!
> > >
> > > James
> > >
> > > On 2021-12-13 3:55 a.m., Gong, Curry wrote:
> > >
> > > [AMD Official Use Only]
> > >
> > >
> > >
> > > Hi James:
> > >
> > >
> > >
> > > With the following patch, an error will be reported when the driver i=
s
> > > loaded
> > >
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > >
> > > @@ -1202,6 +1204,9 @@ static int vcn_v1_0_stop(struct amdgpu_device
> > > *adev)
> > >
> > >         else
> > >
> > >                 r =3D vcn_v1_0_stop_spg_mode(adev);
> > >
> > >
> > >
> > > c
> > >
> > >         return r;
> > >
> > > }
> > >
> > >
> > >
> > >
> > >
> > > $ dmesg
> > >
> > > [  363.181081] INFO: task kworker/3:2:223 blocked for more than 120
> > seconds.
> > >
> > > [  363.181150]       Tainted: G           OE     5.11.0-41-generic #4=
5~20.04.1-
> > Ubuntu
> > >
> > > [  363.181208] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > >
> > > [  363.181266] task:kworker/3:2     state:D stack:    0 pid:  223 ppi=
d:     2
> > flags:0x00004000
> > >
> > > [  363.181276] Workqueue: events vcn_v1_0_idle_work_handler [amdgpu]
> > >
> > > [  363.181612] Call Trace:
> > >
> > > [  363.181618]  __schedule+0x44c/0x8a0
> > >
> > > [  363.181627]  schedule+0x4f/0xc0
> > >
> > > [  363.181631]  schedule_preempt_disabled+0xe/0x10
> > >
> > > [  363.181636]  __mutex_lock.isra.0+0x183/0x4d0
> > >
> > > [  363.181643]  __mutex_lock_slowpath+0x13/0x20
> > >
> > > [  363.181648]  mutex_lock+0x32/0x40
> > >
> > > [  363.181652]  amdgpu_dpm_set_powergating_by_smu+0x9c/0x180
> > [amdgpu]
> > >
> > > [  363.182055]  amdgpu_dpm_enable_uvd+0x38/0x110 [amdgpu]
> > >
> > > [  363.182454]  vcn_v1_0_set_powergating_state+0x2e7e/0x3cf0 [amdgpu]
> > >
> > > [  363.182776]  amdgpu_device_ip_set_powergating_state+0x6c/0xc0
> > > [amdgpu]
> > >
> > > [  363.183028]  smu10_powergate_vcn+0x2a/0x80 [amdgpu]
> > >
> > > [  363.183361]  pp_set_powergating_by_smu+0xc5/0x2b0 [amdgpu]
> > >
> > > [  363.183699]  amdgpu_dpm_set_powergating_by_smu+0xb6/0x180
> > [amdgpu]
> > >
> > > [  363.184040]  amdgpu_dpm_enable_uvd+0x38/0x110 [amdgpu]
> > >
> > > [  363.184391]  vcn_v1_0_idle_work_handler+0xe1/0x130 [amdgpu]
> > >
> > > [  363.184667]  process_one_work+0x220/0x3c0
> > >
> > > [  363.184674]  worker_thread+0x4d/0x3f0
> > >
> > > [  363.184677]  ? process_one_work+0x3c0/0x3c0
> > >
> > > [  363.184680]  kthread+0x12b/0x150
> > >
> > > [  363.184685]  ? set_kthread_struct+0x40/0x40
> > >
> > > [  363.184690]  ret_from_fork+0x22/0x30
> > >
> > > [  363.184699] INFO: task kworker/2:2:233 blocked for more than 120
> > seconds.
> > >
> > > [  363.184739]       Tainted: G           OE     5.11.0-41-generic #4=
5~20.04.1-
> > Ubuntu
> > >
> > > [  363.184782] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > >
> > > [  363.184825] task:kworker/2:2     state:D stack:    0 pid:  233 ppi=
d:     2
> > flags:0x00004000
> > >
> > > [  363.184831] Workqueue: events
> > > amdgpu_device_delayed_init_work_handler [amdgpu]
> > >
> > > [  363.185085] Call Trace:
> > >
> > > [  363.185087]  __schedule+0x44c/0x8a0
> > >
> > > [  363.185092]  schedule+0x4f/0xc0
> > >
> > > [  363.185095]  schedule_timeout+0x202/0x290
> > >
> > > [  363.185099]  ? sched_clock_cpu+0x11/0xb0
> > >
> > > [  363.185105]  wait_for_completion+0x94/0x100
> > >
> > > [  363.185110]  __flush_work+0x12a/0x1e0
> > >
> > > [  363.185113]  ? worker_detach_from_pool+0xc0/0xc0
> > >
> > > [  363.185119]  __cancel_work_timer+0x10e/0x190
> > >
> > > [  363.185123]  cancel_delayed_work_sync+0x13/0x20
> > >
> > > [  363.185126]  vcn_v1_0_ring_begin_use+0x20/0x70 [amdgpu]
> > >
> > > [  363.185401]  amdgpu_ring_alloc+0x48/0x60 [amdgpu]
> > >
> > > [  363.185640]  amdgpu_ib_schedule+0x493/0x600 [amdgpu]
> > >
> > > [  363.185884]  amdgpu_job_submit_direct+0x3c/0xd0 [amdgpu]
> > >
> > > [  363.186186]  amdgpu_vcn_dec_send_msg+0x105/0x210 [amdgpu]
> > >
> > > [  363.186460]  amdgpu_vcn_dec_ring_test_ib+0x69/0x110 [amdgpu]
> > >
> > > [  363.186734]  amdgpu_ib_ring_tests+0xf5/0x160 [amdgpu]
> > >
> > > [  363.186978]  amdgpu_device_delayed_init_work_handler+0x15/0x30
> > > [amdgpu]
> > >
> > > [  363.187206]  process_one_work+0x220/0x3c0
> > >
> > > [  363.187210]  worker_thread+0x4d/0x3f0
> > >
> > > [  363.187214]  ? process_one_work+0x3c0/0x3c0
> > >
> > > [  363.187217]  kthread+0x12b/0x150
> > >
> > > [  363.187221]  ? set_kthread_struct+0x40/0x40
> > >
> > > [  363.187226]  ret_from_fork+0x22/0x30
> > >
> > >
> > >
> > >
> > >
> > > BR
> > >
> > > Curry Gong
> > >
> > > From: Zhu, James <James.Zhu@amd.com>
> > > Sent: Saturday, December 11, 2021 5:07 AM
> > > To: Gong, Curry <Curry.Gong@amd.com>; amd-gfx@lists.freedesktop.org
> > > Cc: Liu, Leo <Leo.Liu@amd.com>; Zhu, James <James.Zhu@amd.com>;
> > Quan,
> > > Evan <Evan.Quan@amd.com>; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>
> > > Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended=
,
> > > powergating is explicitly enabled
> > >
> > >
> > >
> > > On 2021-12-10 6:41 a.m., chen gong wrote:
> > >
> > > Play a video on the raven (or PCO, raven2) platform, and then do the
> > > S3
> > >
> > > test. When resume, the following error will be reported:
> > >
> > >
> > >
> > > amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR*
> > > ring
> > >
> > > vcn_dec test failed (-110)
> > >
> > > [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of
> > IP
> > > block
> > >
> > > <vcn_v1_0> failed -110
> > >
> > > amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
> > >
> > > PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110
> > >
> > >
> > >
> > > [why]
> > >
> > > When playing the video: The power state flag of the vcn block is set
> > > to
> > >
> > > POWER_STATE_ON.
> > >
> > >
> > >
> > > When doing suspend: There is no change to the power state flag of the
> > >
> > > vcn block, it is still POWER_STATE_ON.
> > >
> > >
> > >
> > > When doing resume: Need to open the power gate of the vcn block and
> > > set
> > >
> > > the power state flag of the VCN block to POWER_STATE_ON.
> > >
> > > But at this time, the power state flag of the vcn block is already
> > >
> > > POWER_STATE_ON. The power status flag check in the "8f2cdef
> > drm/amd/pm:
> > >
> > > avoid duplicate powergate/ungate setting" patch will return the
> > >
> > > amdgpu_dpm_set_powergating_by_smu function directly.
> > >
> > > As a result, the gate of the power was not opened, causing the
> > >
> > > subsequent ring test to fail.
> > >
> > >
> > >
> > > [how]
> > >
> > > In the suspend function of the vcn block, explicitly change the power
> > >
> > > state flag of the vcn block to POWER_STATE_OFF.
> > >
> > >
> > >
> > > Signed-off-by: chen gong <curry.gong@amd.com>
> > >
> > > ---
> > >
> > >  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++
> > >
> > >  1 file changed, 7 insertions(+)
> > >
> > >
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > >
> > > index d54d720..d73676b 100644
> > >
> > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > >
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > >
> > > @@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)
> > >
> > >  {
> > >
> > >   int r;
> > >
> > >   struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > >
> > > + bool cancel_success;
> > >
> > > +
> > >
> > > + cancel_success =3D cancel_delayed_work_sync(&adev->vcn.idle_work);
> > >
> > > [JZ] Can you refer to vcn_v3_0_stop , and add
> > amdgpu_dpm_enable_uvd(adev, false); to the end of vcn_v1_0_stop?
> > >
> > > See if it also can help.
> > >
> > >
> > >
> > > + if (cancel_success) {
> > >
> > > +        if (adev->pm.dpm_enabled)
> > >
> > > +                amdgpu_dpm_enable_uvd(adev, false);
> > >
> > > + }
> > >
> > >
> > >
> > >   r =3D vcn_v1_0_hw_fini(adev);
> > >
> > >   if (r)
