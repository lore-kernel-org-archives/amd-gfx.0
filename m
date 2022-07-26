Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D64C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 09:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DFBA11B65D;
	Tue, 26 Jul 2022 09:06:58 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E7B11B65D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 09:06:57 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 cb12-20020a056830618c00b00616b871cef3so10416984otb.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 02:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=ylBrzowu+eGaApVeDqlalvEvp+57s7hk0BIPy7jfV9k=;
 b=auVDwqQtDptkEmLPknCD7bcdZDGSp9rxO29K77AJg/LXBB7Ux7TdFn74//V0SB59Iw
 tyM4iXWk3SqUSIB3zcJ8H1NHjWMApe66BYEMvItPEwPT3wmwgI4+MQlx8f7WU/+E8GFJ
 KnUKn2535ODowab5mWLRXW2n/7KAWGPIciH/5N62F9WjvPw9TKz+je1Xs8/3AquOd7hK
 0x8P8axI6NMvlqv29l99cHVVWYKQNyNdHbaC63sviwioK6LekiZmsG9/R1UzMKlqpvvq
 eqFMnKlFKtAlLwAU4XBiWlVaSwCs1HuFaM3bSWb97bFLuQAzf369sYFmfQVE5K4B56aV
 9HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ylBrzowu+eGaApVeDqlalvEvp+57s7hk0BIPy7jfV9k=;
 b=asuzRuAdlLcIPqykL/v4EuuSLbHC0NYZ24K/wXzspn9wXX9FGElviVwcs9WhAPVVu7
 7vgKEYm/YmbV54g/hh9srPSG/yGl97a0bvR02cm7d9V1wnxoaoRyV4uGGOe8Gf8EQfW6
 XfmvL9Ne60eOjhtsr2RAUz7Y4W/Ma1pyCLBInHrJ2RtKqa8MUfrF6PuTWoROQdxwlp9H
 V709D3GVYrDsKTKJ7pafUMpYouwm4AV4ZfEDhWDnSVbmZOS5quPnH+/H99UAYHM0v1ys
 mGv55vRz0cMARPCcnb/k6AIxQtMoeAvrz/ZIdtxxHTcmxtRqTDYzFtHLZRF6hpD775ub
 cLcw==
X-Gm-Message-State: AJIora89Ziaoi6HgtRe/qei9O03tNS9FENTPy/5KLP2qAzPsA97dasyK
 cgRQudjB5T/vcdky1vmfpp6kWKtQkyuJtV3TyHdxozQo
X-Google-Smtp-Source: AGRyM1uUoahGyeyMZew7mlOHVH6np14h7fifZ4udFYsUmzDrAEP0munMbaG4eNMM1r7P8t8M/RK8hWAZAsk8KtXhEkA=
X-Received: by 2002:a05:6830:9c6:b0:60c:7352:2c03 with SMTP id
 y6-20020a05683009c600b0060c73522c03mr6155149ott.138.1658826416603; Tue, 26
 Jul 2022 02:06:56 -0700 (PDT)
MIME-Version: 1.0
From: Tom Cook <tom.k.cook@gmail.com>
Date: Tue, 26 Jul 2022 10:06:45 +0100
Message-ID: <CAFSh4Uw776o-kySa+=VGY=Ejnt+kgj_HU3DpDT96AMzRwUa0sQ@mail.gmail.com>
Subject: Crash on resume from S3
To: amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I have a Ryzen 7 3700U in an HP laptop.  lspci describes the GPU in this way:

04:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Picasso/Raven 2 [Radeon Vega Series / Radeon Vega Mobile
Series] (rev c1)

This laptop has never successfully resumed from suspend (I have tried
every 5.x kernel).  Currently on 5.18.0, the system appears to be okay
after resume apart from the gpu which is usually giving a blank
screen, occasionally a scrambled output.  After rebooting, I see this
in syslog:

Jul 25 11:02:18 frog kernel: [240782.968674] amdgpu 0000:04:00.0:
amdgpu: GPU reset begin!
Jul 25 11:02:19 frog kernel: [240783.974891] amdgpu 0000:04:00.0:
[drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_2.1.0 test
failed (-110)
Jul 25 11:02:19 frog kernel: [240783.988650] [drm] free PSP TMR buffer
Jul 25 11:02:19 frog kernel: [240784.019057] CPU: 4 PID: 305612 Comm:
kworker/u32:17 Not tainted 5.18.0 #1
Jul 25 11:02:19 frog kernel: [240784.019063] Hardware name: HP HP ENVY
x360 Convertible 15-ds0xxx/85DD, BIOS F.20 05/28/2020
Jul 25 11:02:19 frog kernel: [240784.019067] Workqueue:
amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
Jul 25 11:02:19 frog kernel: [240784.019079] Call Trace:
Jul 25 11:02:19 frog kernel: [240784.019082]  <TASK>
Jul 25 11:02:19 frog kernel: [240784.019085]  dump_stack_lvl+0x49/0x5f
Jul 25 11:02:19 frog kernel: [240784.019095]  dump_stack+0x10/0x12
Jul 25 11:02:19 frog kernel: [240784.019099]
amdgpu_do_asic_reset+0x2f/0x4e0 [amdgpu]
Jul 25 11:02:19 frog kernel: [240784.019278]
amdgpu_device_gpu_recover_imp+0x41e/0xb50 [amdgpu]
Jul 25 11:02:19 frog kernel: [240784.019452]
amdgpu_job_timedout+0x155/0x1b0 [amdgpu]
Jul 25 11:02:19 frog kernel: [240784.019674]
drm_sched_job_timedout+0x74/0xf0 [gpu_sched]
Jul 25 11:02:19 frog kernel: [240784.019681]  ?
amdgpu_cgs_destroy_device+0x10/0x10 [amdgpu]
Jul 25 11:02:19 frog kernel: [240784.019896]  ?
drm_sched_job_timedout+0x74/0xf0 [gpu_sched]
Jul 25 11:02:19 frog kernel: [240784.019903]  process_one_work+0x227/0x440
Jul 25 11:02:19 frog kernel: [240784.019908]  worker_thread+0x31/0x3d0
Jul 25 11:02:19 frog kernel: [240784.019912]  ? process_one_work+0x440/0x440
Jul 25 11:02:19 frog kernel: [240784.019914]  kthread+0xfe/0x130
Jul 25 11:02:19 frog kernel: [240784.019918]  ?
kthread_complete_and_exit+0x20/0x20
Jul 25 11:02:19 frog kernel: [240784.019923]  ret_from_fork+0x22/0x30
Jul 25 11:02:19 frog kernel: [240784.019930]  </TASK>
Jul 25 11:02:19 frog kernel: [240784.019934] amdgpu 0000:04:00.0:
amdgpu: MODE2 reset
Jul 25 11:02:19 frog kernel: [240784.020178] amdgpu 0000:04:00.0:
amdgpu: GPU reset succeeded, trying to resume
Jul 25 11:02:19 frog kernel: [240784.020552] [drm] PCIE GART of 1024M enabled.
Jul 25 11:02:19 frog kernel: [240784.020555] [drm] PTB located at
0x000000F400900000
Jul 25 11:02:19 frog kernel: [240784.020577] [drm] VRAM is lost due to
GPU reset!
Jul 25 11:02:19 frog kernel: [240784.020579] [drm] PSP is resuming...
Jul 25 11:02:19 frog kernel: [240784.040465] [drm] reserve 0x400000
from 0xf47fc00000 for PSP TMR

I'm running the latest BIOS from HP.  Is there anything I can do to
work around this?  Or anything I can do to help debug it?

Regards,
Tom Cook
