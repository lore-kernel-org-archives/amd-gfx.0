Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE46C04A68
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 08:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB1DC3184;
	Wed, 27 Jul 2022 08:53:26 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779C2C3184
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 08:53:26 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 s10-20020a4ab54a000000b00435f410bbacso986912ooo.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1nfX1X1aPK8BV1L7+T/YY3BWkRvAMEOVSWH/dDwx5FE=;
 b=l9IqC6BQoNhtKR1GsbVNd2YZ3J3HfSPCrGZ3bvrXyAH92zLjDbAk/JG2ILp3S9e2si
 Az1IJFtQCMybc5HqwqjpZDKGXEul2CEkXl7Rw5kMMOyco5i7/+s5yuleG8L+Plvl81DZ
 RfPxFJFMnEmlc+n4/2ICLbMkco1VfzpzIeM/BdcPycWtZxhMc+nOfZTBP+l7VauVjmWN
 U12QLmcaGH1lmvX+Jzi3CqhCANiEQcuWvA0VMWtQI5WCdiJGAcYEh67QYcwqMx+aHh9e
 rFZxRo/UA9pimWXRssKdmxXaf3LfGvEImupWad8VvgDYiJSZ0DqclN+PTPai8opAGgk0
 g1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1nfX1X1aPK8BV1L7+T/YY3BWkRvAMEOVSWH/dDwx5FE=;
 b=tskfEj9wMnm+qBd/FJhp/vudnviwVwdT7+KY8QYwY/gSXKXpfyC5F0xIwh3MG8YurT
 o/o8rXu+nLm/kuQkpC8LcSEh9PAY49Eeto0jpmgO9poeuSTVhmLM6X2sZG12+J9ySCvS
 tn6wyd1ow/3O4Dk6urlOouaPDag7Nv5Pv8AvDcGUXufrOhc8nxuItMVGZCmifJErJlat
 Z4aFnAws9zhj+XJ0hIEbpV7cA75515TRhE4gqNtjNRJH+29NdC0fqt4Uj2nNCdStxxyA
 ckHVHrKD+SBj1LgbBpGJf0RlqyQAO33mTJl2kqLe+dBicZ1aUlJ9QxIbExGPezFOjdHb
 5f7w==
X-Gm-Message-State: AJIora+BaWkmS4MfpI0OO0M0dFSj0jletCJEn+BShbr9m1ZtiItKjCnY
 wmnEhPCbZYWe8rNuSLzTOkYMSKmz5+QCc8K5vlQ=
X-Google-Smtp-Source: AGRyM1vIS3zDFHS5QThWiAV1Dq1XoxlCcfTN3dJsoftAehggAjYJ0JkiuqWIR87QU/1OFEEi4w/tjp90w//Z/EFVPis=
X-Received: by 2002:a4a:14c7:0:b0:435:440e:c60c with SMTP id
 190-20020a4a14c7000000b00435440ec60cmr7121088ood.89.1658912005327; Wed, 27
 Jul 2022 01:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSh4Uw776o-kySa+=VGY=Ejnt+kgj_HU3DpDT96AMzRwUa0sQ@mail.gmail.com>
 <7f3e2f3e-bd8e-7971-d85e-616ecd858323@amd.com>
In-Reply-To: <7f3e2f3e-bd8e-7971-d85e-616ecd858323@amd.com>
From: Tom Cook <tom.k.cook@gmail.com>
Date: Wed, 27 Jul 2022 09:53:14 +0100
Message-ID: <CAFSh4Uwz3v=93PhcthdgazoEeVjOV2hONAurMDDC2RPEx7-Zdw@mail.gmail.com>
Subject: Re: Crash on resume from S3
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

https://gitlab.freedesktop.org/drm/amd/-/issues/2105


On Tue, Jul 26, 2022 at 6:10 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> The stack trace is expected part of reset procedure  so that ok. The
> issue you are having is a hang on one of GPU jobs during resume which
> triggers a GPU reset attempt.
>
> You can open a ticket with this issue here
> https://gitlab.freedesktop.org/drm/amd/-/issues, please attach full
> dmesg log.
>
> Andrey
>
> On 2022-07-26 05:06, Tom Cook wrote:
> > I have a Ryzen 7 3700U in an HP laptop.  lspci describes the GPU in this way:
> >
> > 04:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile
> > Series] (rev c1)
> >
> > This laptop has never successfully resumed from suspend (I have tried
> > every 5.x kernel).  Currently on 5.18.0, the system appears to be okay
> > after resume apart from the gpu which is usually giving a blank
> > screen, occasionally a scrambled output.  After rebooting, I see this
> > in syslog:
> >
> > Jul 25 11:02:18 frog kernel: [240782.968674] amdgpu 0000:04:00.0:
> > amdgpu: GPU reset begin!
> > Jul 25 11:02:19 frog kernel: [240783.974891] amdgpu 0000:04:00.0:
> > [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_2.1.0 test
> > failed (-110)
> > Jul 25 11:02:19 frog kernel: [240783.988650] [drm] free PSP TMR buffer
> > Jul 25 11:02:19 frog kernel: [240784.019057] CPU: 4 PID: 305612 Comm:
> > kworker/u32:17 Not tainted 5.18.0 #1
> > Jul 25 11:02:19 frog kernel: [240784.019063] Hardware name: HP HP ENVY
> > x360 Convertible 15-ds0xxx/85DD, BIOS F.20 05/28/2020
> > Jul 25 11:02:19 frog kernel: [240784.019067] Workqueue:
> > amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
> > Jul 25 11:02:19 frog kernel: [240784.019079] Call Trace:
> > Jul 25 11:02:19 frog kernel: [240784.019082]  <TASK>
> > Jul 25 11:02:19 frog kernel: [240784.019085]  dump_stack_lvl+0x49/0x5f
> > Jul 25 11:02:19 frog kernel: [240784.019095]  dump_stack+0x10/0x12
> > Jul 25 11:02:19 frog kernel: [240784.019099]
> > amdgpu_do_asic_reset+0x2f/0x4e0 [amdgpu]
> > Jul 25 11:02:19 frog kernel: [240784.019278]
> > amdgpu_device_gpu_recover_imp+0x41e/0xb50 [amdgpu]
> > Jul 25 11:02:19 frog kernel: [240784.019452]
> > amdgpu_job_timedout+0x155/0x1b0 [amdgpu]
> > Jul 25 11:02:19 frog kernel: [240784.019674]
> > drm_sched_job_timedout+0x74/0xf0 [gpu_sched]
> > Jul 25 11:02:19 frog kernel: [240784.019681]  ?
> > amdgpu_cgs_destroy_device+0x10/0x10 [amdgpu]
> > Jul 25 11:02:19 frog kernel: [240784.019896]  ?
> > drm_sched_job_timedout+0x74/0xf0 [gpu_sched]
> > Jul 25 11:02:19 frog kernel: [240784.019903]  process_one_work+0x227/0x440
> > Jul 25 11:02:19 frog kernel: [240784.019908]  worker_thread+0x31/0x3d0
> > Jul 25 11:02:19 frog kernel: [240784.019912]  ? process_one_work+0x440/0x440
> > Jul 25 11:02:19 frog kernel: [240784.019914]  kthread+0xfe/0x130
> > Jul 25 11:02:19 frog kernel: [240784.019918]  ?
> > kthread_complete_and_exit+0x20/0x20
> > Jul 25 11:02:19 frog kernel: [240784.019923]  ret_from_fork+0x22/0x30
> > Jul 25 11:02:19 frog kernel: [240784.019930]  </TASK>
> > Jul 25 11:02:19 frog kernel: [240784.019934] amdgpu 0000:04:00.0:
> > amdgpu: MODE2 reset
> > Jul 25 11:02:19 frog kernel: [240784.020178] amdgpu 0000:04:00.0:
> > amdgpu: GPU reset succeeded, trying to resume
> > Jul 25 11:02:19 frog kernel: [240784.020552] [drm] PCIE GART of 1024M enabled.
> > Jul 25 11:02:19 frog kernel: [240784.020555] [drm] PTB located at
> > 0x000000F400900000
> > Jul 25 11:02:19 frog kernel: [240784.020577] [drm] VRAM is lost due to
> > GPU reset!
> > Jul 25 11:02:19 frog kernel: [240784.020579] [drm] PSP is resuming...
> > Jul 25 11:02:19 frog kernel: [240784.040465] [drm] reserve 0x400000
> > from 0xf47fc00000 for PSP TMR
> >
> > I'm running the latest BIOS from HP.  Is there anything I can do to
> > work around this?  Or anything I can do to help debug it?
> >
> > Regards,
> > Tom Cook
