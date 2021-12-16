Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EFDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 15:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6920810E24C;
	Thu, 16 Dec 2021 15:38:42 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 426F410E24C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 15:38:41 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 n104-20020a9d2071000000b005799790cf0bso29430475ota.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 07:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ww80AeAZqNBcgagA675GRlU7wlLrA+kPXizSVou96AY=;
 b=RowyXX9UK16nAStqzRDVQ+Z1AAzdlrSGheKH11GhM1/lamNMf1HMtzfNZ1eebfzzzm
 yETAoobuhvpOPmzq0YFJzOIzzNfeWtYwybHo8d0NXwQyWn5e7O0YAgJkAKvlPyEwh9p9
 qYnE+cx27EOJ4kXdKlRP1tf6MdHPZpRqB/cqCexu7plVdSQwwrHoKAltVLcBuwkf5J9d
 ytCICbsyI/R+/X/dMyKsQhLjtRcUMJZCKSt5E2GVwcyuosg0Gub88b/J8WzbJx64YFih
 TWh1WNMALop0zAnR1Lw8PRJZObzaPijLGau+CDvo7wmVWSNvewXytOE8/sGI+dtWeVAG
 eoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ww80AeAZqNBcgagA675GRlU7wlLrA+kPXizSVou96AY=;
 b=OVorvYK4BSJLRQr6umOFgFxttZdD5AGcyrxKdtcyn81qbL4U/nmePBWNKX4T6msJ9m
 QlBxx30rW/g0rjAF21s98UJ/gUHqxqReVwX2ZGJ0rzlUlTCCgwVQ6QHO1zOsg4GdUPCF
 KOco4LyM0+HGELXThvkWfCHO6SPYKle0YI4AdHl0FdLM+FYMoW1rrQ+jujLgBoJrMdce
 Y82WqrUc6hVjZaOSR6YXzT4xqYDWlEwHvSFMwWQ+T1bhlWWP26etkLS7nsrVbpULEwoH
 6l8VYcKQZqM+f6VCf78cKQQaOTf2yx0bNWr5Vz0spAEiBrX2KZY73R36MM962dlLmqPU
 vNcg==
X-Gm-Message-State: AOAM531X7/grvwCo2USAahjrm1+I9VFYJKx0yWC3flxn+esG26tabfAX
 BaZCe4LODlBj3CHuqGv3WutyoKFI7tHau6vUwFDqY3zI
X-Google-Smtp-Source: ABdhPJycSpG7BGHNiPaubvXh05v42XY8/lLTz/I3gB6MBrl0hfXynoiWEWHevDUss0552vrVu0LK1MLjiVdC10+saDA=
X-Received: by 2002:a05:6830:1bcf:: with SMTP id
 v15mr13456189ota.200.1639669120558; 
 Thu, 16 Dec 2021 07:38:40 -0800 (PST)
MIME-Version: 1.0
References: <1639136511-6357-1-git-send-email-curry.gong@amd.com>
 <f1f996f4-0bc3-aa01-f9da-3664b14f7861@amd.com>
 <BN7PR12MB2641CA6290B6CEFB4A5016EF9D749@BN7PR12MB2641.namprd12.prod.outlook.com>
 <826e98e0-5e6a-cc87-0690-b444e34bb367@amd.com>
 <DM6PR12MB2619D50306A965F94357A555E4759@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619D50306A965F94357A555E4759@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Dec 2021 10:38:29 -0500
Message-ID: <CADnq5_PthY5p9zDnAHiKTsP8WyptK1Ni+yN4Uqj=JFqJkO7QQw@mail.gmail.com>
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

FWIW, it looks like all versions of VCN need the same fix.  There have
been reports of suspend failing when VCN is in use on other newer APUs
as well.

Alex

On Tue, Dec 14, 2021 at 12:59 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
>
>
>
>
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Monday, December 13, 2021 9:39 PM
> To: Gong, Curry <Curry.Gong@amd.com>; Zhu, James <James.Zhu@amd.com>; amd=
-gfx@lists.freedesktop.org
> Cc: Liu, Leo <Leo.Liu@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Deucher, =
Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended, po=
wergating is explicitly enabled
>
>
>
> Hi Curry, Evan,
>
> It seems vcn1.0 power gate sequence are special.
>
> if the original solution is thread safe, then the following solution will=
 be thread safe also.
>
> static int vcn_v1_0_hw_fini(void *handle)
> {
>     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
>     cancel_delayed_work_sync(&adev->vcn.idle_work);
>
>     if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>         (adev->vcn.cur_state !=3D AMD_PG_STATE_GATE &&
>          RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
> +        if (adev->pm.dpm_enabled)
> +            amdgpu_dpm_enable_uvd(adev, false);
> +        else
> +            vcn_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
>
> [Quan, Evan] Considering adev->pm.dpm_enabled is always true, =E2=80=9Cvc=
n_v1_0_set_powergating_state(adev, AMD_PG_STATE_GATE); =E2=80=9C will becom=
e dead code.
>
> Also, the vcn_v1_0_hw_fini is also used in other scenarios(except the sus=
pend/resume discussed here). So, it seems quite risky compared with Curry=
=E2=80=99s original patch.
>
> Before we can come up with a better idea, I would suggest to land Curry=
=E2=80=99s original patch as a quick fix.
>
>
>
> BR
>
> Evan
>
>
>     }
>
> Best Regards!
>
> James
>
> On 2021-12-13 3:55 a.m., Gong, Curry wrote:
>
> [AMD Official Use Only]
>
>
>
> Hi James:
>
>
>
> With the following patch, an error will be reported when the driver is lo=
aded
>
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>
> @@ -1202,6 +1204,9 @@ static int vcn_v1_0_stop(struct amdgpu_device *adev=
)
>
>         else
>
>                 r =3D vcn_v1_0_stop_spg_mode(adev);
>
>
>
> c
>
>         return r;
>
> }
>
>
>
>
>
> $ dmesg
>
> [  363.181081] INFO: task kworker/3:2:223 blocked for more than 120 secon=
ds.
>
> [  363.181150]       Tainted: G           OE     5.11.0-41-generic #45~20=
.04.1-Ubuntu
>
> [  363.181208] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
>
> [  363.181266] task:kworker/3:2     state:D stack:    0 pid:  223 ppid:  =
   2 flags:0x00004000
>
> [  363.181276] Workqueue: events vcn_v1_0_idle_work_handler [amdgpu]
>
> [  363.181612] Call Trace:
>
> [  363.181618]  __schedule+0x44c/0x8a0
>
> [  363.181627]  schedule+0x4f/0xc0
>
> [  363.181631]  schedule_preempt_disabled+0xe/0x10
>
> [  363.181636]  __mutex_lock.isra.0+0x183/0x4d0
>
> [  363.181643]  __mutex_lock_slowpath+0x13/0x20
>
> [  363.181648]  mutex_lock+0x32/0x40
>
> [  363.181652]  amdgpu_dpm_set_powergating_by_smu+0x9c/0x180 [amdgpu]
>
> [  363.182055]  amdgpu_dpm_enable_uvd+0x38/0x110 [amdgpu]
>
> [  363.182454]  vcn_v1_0_set_powergating_state+0x2e7e/0x3cf0 [amdgpu]
>
> [  363.182776]  amdgpu_device_ip_set_powergating_state+0x6c/0xc0 [amdgpu]
>
> [  363.183028]  smu10_powergate_vcn+0x2a/0x80 [amdgpu]
>
> [  363.183361]  pp_set_powergating_by_smu+0xc5/0x2b0 [amdgpu]
>
> [  363.183699]  amdgpu_dpm_set_powergating_by_smu+0xb6/0x180 [amdgpu]
>
> [  363.184040]  amdgpu_dpm_enable_uvd+0x38/0x110 [amdgpu]
>
> [  363.184391]  vcn_v1_0_idle_work_handler+0xe1/0x130 [amdgpu]
>
> [  363.184667]  process_one_work+0x220/0x3c0
>
> [  363.184674]  worker_thread+0x4d/0x3f0
>
> [  363.184677]  ? process_one_work+0x3c0/0x3c0
>
> [  363.184680]  kthread+0x12b/0x150
>
> [  363.184685]  ? set_kthread_struct+0x40/0x40
>
> [  363.184690]  ret_from_fork+0x22/0x30
>
> [  363.184699] INFO: task kworker/2:2:233 blocked for more than 120 secon=
ds.
>
> [  363.184739]       Tainted: G           OE     5.11.0-41-generic #45~20=
.04.1-Ubuntu
>
> [  363.184782] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
>
> [  363.184825] task:kworker/2:2     state:D stack:    0 pid:  233 ppid:  =
   2 flags:0x00004000
>
> [  363.184831] Workqueue: events amdgpu_device_delayed_init_work_handler =
[amdgpu]
>
> [  363.185085] Call Trace:
>
> [  363.185087]  __schedule+0x44c/0x8a0
>
> [  363.185092]  schedule+0x4f/0xc0
>
> [  363.185095]  schedule_timeout+0x202/0x290
>
> [  363.185099]  ? sched_clock_cpu+0x11/0xb0
>
> [  363.185105]  wait_for_completion+0x94/0x100
>
> [  363.185110]  __flush_work+0x12a/0x1e0
>
> [  363.185113]  ? worker_detach_from_pool+0xc0/0xc0
>
> [  363.185119]  __cancel_work_timer+0x10e/0x190
>
> [  363.185123]  cancel_delayed_work_sync+0x13/0x20
>
> [  363.185126]  vcn_v1_0_ring_begin_use+0x20/0x70 [amdgpu]
>
> [  363.185401]  amdgpu_ring_alloc+0x48/0x60 [amdgpu]
>
> [  363.185640]  amdgpu_ib_schedule+0x493/0x600 [amdgpu]
>
> [  363.185884]  amdgpu_job_submit_direct+0x3c/0xd0 [amdgpu]
>
> [  363.186186]  amdgpu_vcn_dec_send_msg+0x105/0x210 [amdgpu]
>
> [  363.186460]  amdgpu_vcn_dec_ring_test_ib+0x69/0x110 [amdgpu]
>
> [  363.186734]  amdgpu_ib_ring_tests+0xf5/0x160 [amdgpu]
>
> [  363.186978]  amdgpu_device_delayed_init_work_handler+0x15/0x30 [amdgpu=
]
>
> [  363.187206]  process_one_work+0x220/0x3c0
>
> [  363.187210]  worker_thread+0x4d/0x3f0
>
> [  363.187214]  ? process_one_work+0x3c0/0x3c0
>
> [  363.187217]  kthread+0x12b/0x150
>
> [  363.187221]  ? set_kthread_struct+0x40/0x40
>
> [  363.187226]  ret_from_fork+0x22/0x30
>
>
>
>
>
> BR
>
> Curry Gong
>
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Saturday, December 11, 2021 5:07 AM
> To: Gong, Curry <Curry.Gong@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Liu, Leo <Leo.Liu@amd.com>; Zhu, James <James.Zhu@amd.com>; Quan, Eva=
n <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: When the VCN(1.0) block is suspended, po=
wergating is explicitly enabled
>
>
>
> On 2021-12-10 6:41 a.m., chen gong wrote:
>
> Play a video on the raven (or PCO, raven2) platform, and then do the S3
>
> test. When resume, the following error will be reported:
>
>
>
> amdgpu 0000:02:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring
>
> vcn_dec test failed (-110)
>
> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block
>
> <vcn_v1_0> failed -110
>
> amdgpu 0000:02:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
>
> PM: dpm_run_callback(): pci_pm_resume+0x0/0x90 returns -110
>
>
>
> [why]
>
> When playing the video: The power state flag of the vcn block is set to
>
> POWER_STATE_ON.
>
>
>
> When doing suspend: There is no change to the power state flag of the
>
> vcn block, it is still POWER_STATE_ON.
>
>
>
> When doing resume: Need to open the power gate of the vcn block and set
>
> the power state flag of the VCN block to POWER_STATE_ON.
>
> But at this time, the power state flag of the vcn block is already
>
> POWER_STATE_ON. The power status flag check in the "8f2cdef drm/amd/pm:
>
> avoid duplicate powergate/ungate setting" patch will return the
>
> amdgpu_dpm_set_powergating_by_smu function directly.
>
> As a result, the gate of the power was not opened, causing the
>
> subsequent ring test to fail.
>
>
>
> [how]
>
> In the suspend function of the vcn block, explicitly change the power
>
> state flag of the vcn block to POWER_STATE_OFF.
>
>
>
> Signed-off-by: chen gong <curry.gong@amd.com>
>
> ---
>
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 7 +++++++
>
>  1 file changed, 7 insertions(+)
>
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
>
> index d54d720..d73676b 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>
> @@ -246,6 +246,13 @@ static int vcn_v1_0_suspend(void *handle)
>
>  {
>
>   int r;
>
>   struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> + bool cancel_success;
>
> +
>
> + cancel_success =3D cancel_delayed_work_sync(&adev->vcn.idle_work);
>
> [JZ] Can you refer to vcn_v3_0_stop , and add amdgpu_dpm_enable_uvd(adev,=
 false); to the end of vcn_v1_0_stop?
>
> See if it also can help.
>
>
>
> + if (cancel_success) {
>
> +        if (adev->pm.dpm_enabled)
>
> +                amdgpu_dpm_enable_uvd(adev, false);
>
> + }
>
>
>
>   r =3D vcn_v1_0_hw_fini(adev);
>
>   if (r)
