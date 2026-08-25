Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A42C61DC7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 12:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0729310ECE2;
	Wed, 26 Aug 2026 12:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=adec.dev header.i=@adec.dev header.b="XHzQ2Tn9";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13AA10EAFE
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 17:02:03 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so23485465e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 10:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787677322; cv=none;
 d=google.com; s=arc-20260327;
 b=ilfB465cmZyIpo9+BX67jGjGh65aDg6lwe37JSkzqG/hF31w0R/69xALOQ7piai0+y
 rhKVjjtFv9VUmPMygbqzrWB/aTgnsIv1dzPS0FErNi9bLrV2fSZgnn9bdqte97EjeXtF
 Llv5isgSUUIX2i7188rNqJPIDC7PWed3v644IIfkE342FE12sG6EGQlxGELfA9/O1DvN
 6dhrb5P9PkfarYXowkP5QL1FKNDtij2ahzq7L8FZn8tMj0pSNzEVoPpAm4Zg99E35eln
 MzwaPu5ejOVmh9FOwH6V1D6XTa53IhKRggmgz4pWMIUevptsZgrFQDTafC5GG2emP+8f
 gaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UnUT/eTP0TbepoMRgx5aSbRNysgz26lqj+aKOdNTqnc=;
 fh=RbgENLHjGX51AYcf+CWPtx2IRnsttmLchuQK/WLGTqQ=;
 b=CaQaCPefeGkD/zPKroRBHJv+TcsdplIgJoj7YuOwGvf1G5FQNuj9oDEI7e0Ebgim12
 EOHJqHHgZLoPurxOwLr1woxrZaKJrrV8cAmZ7pJd+QSgdhYcVDSI/InavoPqExS6NCa6
 aX3gYzcpic16q3e69yl/z6rlykKveg/ui0Q6qZ+wpCHup39OMMFmrPqrsiT8NlLwq+bT
 Mw30B4xjspGq14oscPRoSS6Q3f1hkSegMtPr+VOiUNpipMV4VbE+2VRt0lXSoYATrQf7
 VUb8GibTh7LLG+/l7IAq+tCNCqPUE6/W75aA4GgYH4sEB9Dw3gu9l+4XJVsRxTsSqH7J
 QYCA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adec.dev; s=google; t=1787677322; x=1788282122; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UnUT/eTP0TbepoMRgx5aSbRNysgz26lqj+aKOdNTqnc=;
 b=XHzQ2Tn95zSb1qeE72rICgzOj9MYBB6FkIsGpOnClEI3ERtbamXYBtR1CmqqLFRwnO
 SpIe3P9xVWsbrBk3NKjywzxczA1whMeX15ZP4bJFX/utLjYI6ByxmwrFGmjf59V60UyH
 BjC91s8a93cZbfSWlZui4vDBjIYcorEiHsnrkys1RVPT1c5Qn9qYLDciUbexXn0fL0Xs
 rHv8fQnLVBZ/VyRTuqNvn3+Kbvw9IwVm2zQq/ZqkrHq+dhrSc25/+yiKGnKKJct7VH80
 DCOkUhV6EZd7Cnl5ivYu7xvL90XOitIisIb5/zfEKJfn0JJtfNWgJH1BpyYgRQ0IG0v1
 /Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787677322; x=1788282122;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UnUT/eTP0TbepoMRgx5aSbRNysgz26lqj+aKOdNTqnc=;
 b=G21ka7syZQyPDV/cP9xTmisOJiUfPBXcVeb0D4JM7vffh0YOhG8qYMfjioKvAjxwmQ
 /4+CUM1P+szN21QMMCxsLNF7Xh09SlhEOFi9Qa0rO7W/Pydk0gDFxtl2vq+WIIVBGMQQ
 oJrt9kzlRG2Ki2f7sVvy0ZBxiMoSygyC/CjSU4qHiVVpDub//Xmle61DX7KzRO0ZjZL/
 ai1yiclteJdj4HzZdvpjhLG9i7eCwfc7bTAXdBJVzR5g70oXavuIo7DZYeaLuoDqtIF4
 r/2pgdvetx3JNUtTw88bjct2mJ2O3j+SxS8iAiDfLm7LQW1eDQlS6UGxBpBAB6nKdgX1
 vahQ==
X-Gm-Message-State: AFuF++nWekR3QZl0b1lGUPEuNjvFngKLKEwEY0J3Jh6t9l6fZiwEtYtn
 1Bu5Rd1Jxm0i7cOZd5ft8TsUZa0gzAmA7yFwMqEkKDapgjZ+FI2KwwfdaOUR8rSdNTiR66qQ5bK
 8PbmWp8UoXpn9ARVxMf0KentyLlDTQyP/WXX40UD3BsuoG/qstfSaJwS8Jg==
X-Gm-Gg: AR+sD1176xRU5f0kgUH2GC2o0UiVR5zmNqr/+U8WBP7RFmAuNec9+g6qzEqcHP6+2J9
 d+BpZES+rYVVacJsmGhOD6v4q46TydqeO1wZQICX76NGJduZ5Krr+GA35R9nEtP3pGqS9Ue1y7P
 5JktTSQ9Jtk866RfEymy4zn0PqfUO0H6+YVZso6bVkK+gnZcaTVSg4W5P8X95Kqp7D/Lp+nzK53
 rFibG1wJyPYPSqiq4Qdo2egI2nxMXDW8B5zx1lp06rz3rlA6d1QgZQBwVclymJzN8MVJxbbovAw
 bFeuw7+KmgpO/fijg7Rp5Z9OGHaOUNP8hMyfosx2faAJMxI=
X-Received: by 2002:a05:600c:4e55:b0:499:484a:81d0 with SMTP id
 5b1f17b1804b1-499dc723fadmr3632585e9.9.1787677320433; Tue, 25 Aug 2026
 10:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9SDS166EhN-DAFNqatoJ84sY2-MMESY=1BXenHAr9CubK=wA@mail.gmail.com>
 <LV8SPRMB00725DD889913F321618A0F38EA02@LV8SPRMB0072.namprd12.prod.outlook.com>
 <CA+9SDS3ZJKZrwSrm_sXSj7wE0MBrKLkp9+zGZR-CtE_cbeeyuA@mail.gmail.com>
 <LV8SPRMB00723AA536F29362F97522598EAF2@LV8SPRMB0072.namprd12.prod.outlook.com>
 <CA+9SDS19LFoLCEOCeEcu3Lk21Mvevr+EJwQLhpr0VWUX-9Ah7w@mail.gmail.com>
 <LV8SPRMB0072B2C64F2BF96E4F4B0DE58EAF2@LV8SPRMB0072.namprd12.prod.outlook.com>
In-Reply-To: <LV8SPRMB0072B2C64F2BF96E4F4B0DE58EAF2@LV8SPRMB0072.namprd12.prod.outlook.com>
From: Kevin Hake <kevin@adec.dev>
Date: Tue, 25 Aug 2026 10:01:46 -0700
X-Gm-Features: AcwNN1W5yOZNnR3B2FP_UHNLKaLf9Ie2McffZ3OYcKvdcfuadC-c8PLQnggd3HU
Message-ID: <CA+9SDS18nNqobj5UGQOjfz-zEhH+qUCruX3UROFD8jSRWQN1gg@mail.gmail.com>
Subject: Re: [drm/amd #3549] Navi 33 idle sclk latch: repro, analysis,
 userspace workaround
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/mixed; boundary="000000000000a87df00659e20fc1"
X-Mailman-Approved-At: Wed, 26 Aug 2026 12:46:21 +0000
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

--000000000000a87df00659e20fc1
Content-Type: multipart/alternative; boundary="000000000000a87def0659e20fbf"

--000000000000a87def0659e20fbf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah ok, when I'm back home on Friday I'll add more logging and send an
update.
Thanks!


Kevin Hake
+1 716 432 7106
+52 81 1300 5479

On Tue, Aug 25, 2026, 7:18=E2=80=AFAM Feng, Kenneth <Kenneth.Feng@amd.com> =
wrote:

> AMD General
>
> I am suspecting that clock gating could be disabled so the utilization is
> stuck at 100%.
>
> When the utilization is 100%, any chance you can check on your system wit=
h
> debugfs: /sys/kernel/debug/dri/x/amdgpu_pm_info?
>
> The output: "Clock Gating Flags Mask:=E2=80=A6=E2=80=9D indicates if cloc=
k gating is
> disabled or not.
>
> Thanks.
>
>
>
>
>
>
>
> *From:* Kevin Hake <kevin@adec.dev>
> *Sent:* Tuesday, August 25, 2026 3:23 PM
> *To:* Feng, Kenneth <Kenneth.Feng@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org; Deucher, Alexander <
> Alexander.Deucher@amd.com>
> *Subject:* Re: [drm/amd #3549] Navi 33 idle sclk latch: repro, analysis,
> userspace workaround
>
>
>
> The KDE session is actually still live on tty1 during that test, I've jus=
t
> switched to TTY3. I'm away for a few days so can't confirm if I have logs
> of exactly what sent those, but it may be regular background system
> activity like maybe Wayland cleaning up context(?)
>
>
>
> But the NOP is just the smallest reproducer I could come up with - I
> originally caught the behavior just watching regular system activity.
>
> When I saw sclk toggle from 0 to high and stay there with no other jobs
> dispatched, iirc it was always <10 jobs showing up on that log line. My
> first attempt to trigger it myself was a simple open gl task, but that
> didn't work - iirc setting up the context, running it, and destructing
> dispatched a larger bunch of tasks (20-something). It wasn't until I held
> the context between "pokes" that I could get the manual clock toggling
> behavior.
>
>
>
> Maybe worth noting the Python version of the "poke" reproducer (used in
> the demo) is using a GL stack to dispatch an empty compute shader, wherea=
s
> the c poke is the more barebones PM4 packet with NOP,  but either one act=
s
> as a toggle.
>
>
>
> In the wild, the pattern seems to be:
>
> GPU idles, sclk->0
>
> Lone task comes in and completes with nothing behind it
>
> sclk->max
>
> Later, another task comes in
>
> sclk->0 (my speculation is queuing or completing a task triggers a test o=
f
> % of recent idle clocks, and since it's been sitting at max clock with
> nothing to do, it sees 100% idle clocks and immediately throttles back do=
wn
> to 0)
>
>
>
> - Kevin
>
>
>
>
>
>
>
>
>
> On Mon, Aug 24, 2026, 9:04=E2=80=AFPM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:
>
> AMD General
>
>
>
> Thanks Kevin.
>
> At the beginning of the video, right after gpu-monitor.py is executed,
> there are 13 jobs dispatched.
>
> Are they also the NOP packets?
>
> Thanks.
>
>
>
> *From:* Kevin Hake <kevin@adec.dev>
> *Sent:* Tuesday, August 25, 2026 3:22 AM
> *To:* Feng, Kenneth <Kenneth.Feng@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org; Deucher, Alexander <
> Alexander.Deucher@amd.com>
> *Subject:* Re: [drm/amd #3549] Navi 33 idle sclk latch: repro, analysis,
> userspace workaround
>
>
>
> You don't often get email from kevin@adec.dev. Learn why this is importan=
t
> <https://aka.ms/LearnAboutSenderIdentification>
>
> Hi Kenneth,
>
> I think that's the bug - it is reporting 100% utilization but the GPU is
> idle - I know it's idle because I traced job submissions and dispatch, an=
d
> separately drm_sched_job_done, debugfs pending fences, the kernel's
> drm-engine-* nanoseconds - everything points to nothing actually crunchin=
g,
> at least nothing real from userspace. Not to mention I'm in TTY with
> minimal system activity. You can see the behavior in this demo:
> https://asciinema.org/a/Qc5CQBW6ycb89ldd
>
>
> I'm wondering if there's a bug where utilization is calculated something
> something like, "how many idle clocks have there been since we last
> checked?". If the gpu has been asleep with sclk =3D=3D 0, then it sees 0 =
idle
> clocks in the past n seconds (no idle clocks?? we must be really busy!),
> and sets utilization to 100. But I'm just speculating, what I can confirm
> is that with sclk at 0, a single NOP to the gpu toggles utilization to 10=
0%
> and sclk to max. It seems odd numbers of very small work trigger the
> toggle, When larger groups of work come in it behaves more normally and
> doesn't "stick" high.
>
>
> Thanks,
>
> Kevin Hake
>
> +1 716 432 7106
>
> +52 81 1300 5479
>
>
>
>
>
> On Mon, Aug 24, 2026 at 8:10=E2=80=AFAM Feng, Kenneth <Kenneth.Feng@amd.c=
om>
> wrote:
>
> AMD General
>
>
>
> What=E2=80=99s the GPU utilization(observed by sudo cat
> /sys/kernel/debug/dri/x/amdgpu_pm_info) when the sclk is highest?
>
> The policy is that if the utilization is 100%, the clock has to stay
> highest.
>
> Could you please elaborate what =E2=80=98a tiny job=E2=80=99 is to trigge=
r the issue?
>
> Thanks.
>
>
>
>
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of *Ke=
vin
> Hake
> *Sent:* Sunday, August 23, 2026 11:05 PM
> *To:* amd-gfx@lists.freedesktop.org
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Subject:* [drm/amd #3549] Navi 33 idle sclk latch: repro, analysis,
> userspace workaround
>
>
>
> Some people who received this message don't often get email from
> kevin@adec.dev. Learn why this is important
> <https://aka.ms/LearnAboutSenderIdentification>
>
>
> Hi all,
>
> Follow-up to drm/amd issue #3549 ("AMD GPU usage peaks with system in idl=
e
> =E2=80=94
> Radeon RX 7600 XT"), where I posted a root-cause analysis and reproducer
> a few weeks ago (note 3586398). The thread's been quiet, so I'm summarizi=
ng
> here in case it's useful to whoever owns PMFW/swsmu for SMU 13.0.7.
>
> Behavior (RX 7600 XT / Navi 33, kernels 6.x=E2=80=937.1, likely any DE (t=
ho I'm on
> Plasma w/Wayland) or bare TTY):
>
>   - With the gfx job stream verifiably empty, a single tiny job submitted
>     while sclk is at 0 (deep sleep) latches sclk at max (~2990 MHz, ~115 =
W)
>     indefinitely. A second completed gfx job clears it. So at true idle t=
he
>     card toggles between 0 and max on every stray job, and can sit at max
>     for an hour with the screen off.
>   - Light sustained load (video, a compositor, radeontop) masks it, which
>     is why the earlier "monitoring tools toggle gfxoff" hypothesis looked
>     plausible. It reproduces on demand from a TTY with nothing polling.
>   - Umio's finding that disabling GFXOFF via ppfeaturemask stops the spik=
es
>     is consistent with this model: without GFXOFF there is no "single job
>     from deep sleep" transition to mis-handle.
>
> How I measured:
>
>   - Job stream: a private ftrace instance on amdgpu_cs_ioctl /
>     amdgpu_sched_run_job / drm_sched_job_done, cross-checked against fdin=
fo
>     drm-engine counters and debugfs amdgpu_fence_info, so I could prove t=
he
>     kernel submitted nothing while clocks moved.
>   - Clock: sampling the firmware's gpu_metrics (v1.3) at 1 kHz, matched t=
o
>     the driver's 1 ms refresh of that table, to catch the ramp edges.
>   - Stimulus: a minimal compute dispatch with a held context (no setup/
>     teardown jobs), and later a one-packet PM4 NOP via libdrm =E2=80=94 e=
ither one
>     toggles the latch.
>
> Everything points at the firmware's clock selection rather than the drive=
r.
> Since PMFW can't be patched from outside, I published a small userspace
> workaround: a C daemon over libdrm/render node that submits one PM4 NOP
> when it sees sclk latched (same binary is the manual reproducer):
>
>   https://github.com/KevinHake/amdgpu-unstick
>
> Scripts, logs, and an asciinema demo are attached to the issue. If a
> narrower repro would help (specific firmware versions, mesa-free path,
> other kernels), tell me what you need and I'll run it.
>
> Thanks,
> Kevin Hake
>
>
>
>
>
>
>

--000000000000a87def0659e20fbf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><div dir=3D"ltr"><div dir=3D"auto">Ah o=
k, when I&#39;m back home on Friday I&#39;ll add more logging and send an u=
pdate.<br></div><div dir=3D"auto">Thanks!=C2=A0</div><div dir=3D"auto"><br>=
<div><br></div><div data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Kev=
in Hake<div><font face=3D"arial, sans-serif">+1 716 432 7106</font></div><d=
iv><font face=3D"arial, sans-serif">+52 81 1300 5479</font></div></div></di=
v></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Tue, Aug 25, 2026, 7:18=E2=80=AFAM Feng, Kenneth &lt;<a href=3D"=
mailto:Kenneth.Feng@amd.com" rel=3D"noreferrer noreferrer" target=3D"_blank=
">Kenneth.Feng@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">





<div lang=3D"EN-US">
<p style=3D"font-family:Calibri;font-size:10pt;color:rgb(0,0,255);margin:5p=
t;font-style:normal;font-weight:normal;text-decoration:none" align=3D"Left"=
>
AMD General<br>
</p>
<br>
<div>
<div>
<p class=3D"MsoNormal">I am suspecting that clock gating could be disabled =
so the utilization is stuck at 100%.<u></u><u></u></p>
<p class=3D"MsoNormal">When the utilization is 100%, any chance you can che=
ck on your system with debugfs: /sys/kernel/debug/dri/x/amdgpu_pm_info?<u><=
/u><u></u></p>
<p class=3D"MsoNormal">The output: &quot;Clock Gating Flags Mask:=E2=80=A6=
=E2=80=9D indicates if clock gating is disabled or not.<u></u><u></u></p>
<p class=3D"MsoNormal">Thanks.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div style=3D"border-width:1pt medium medium;border-style:solid none none;b=
order-color:rgb(225,225,225) currentcolor currentcolor;padding:3pt 0in 0in"=
>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;C=
alibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11pt;font=
-family:&quot;Calibri&quot;,sans-serif"> Kevin Hake &lt;<a href=3D"mailto:k=
evin@adec.dev" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">k=
evin@adec.dev</a>&gt;
<br>
<b>Sent:</b> Tuesday, August 25, 2026 3:23 PM<br>
<b>To:</b> Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng@amd.com" rel=3D=
"noreferrer noreferrer noreferrer" target=3D"_blank">Kenneth.Feng@amd.com</=
a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" rel=3D"noreferr=
er noreferrer noreferrer" target=3D"_blank">amd-gfx@lists.freedesktop.org</=
a>; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" rel=
=3D"noreferrer noreferrer noreferrer" target=3D"_blank">Alexander.Deucher@a=
md.com</a>&gt;<br>
<b>Subject:</b> Re: [drm/amd #3549] Navi 33 idle sclk latch: repro, analysi=
s, userspace workaround<u></u><u></u></span></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">The KDE session is actually still live on tty1 durin=
g that test, I&#39;ve just switched to TTY3. I&#39;m away for a few days so=
 can&#39;t confirm if I have logs of exactly what sent those, but it may be=
 regular background system activity like maybe
 Wayland cleaning up context(?)=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">But the NOP is just the smallest reproducer I could =
come up with - I originally caught the behavior just watching regular syste=
m activity.=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">When I saw sclk toggle from 0 to high and stay there=
 with no other jobs dispatched, iirc it was always &lt;10 jobs showing up o=
n that log line. My first attempt to trigger it myself was a simple open gl=
 task, but that didn&#39;t work - iirc setting
 up the context, running it, and destructing dispatched a larger bunch of t=
asks (20-something). It wasn&#39;t until I held the context between &quot;p=
okes&quot; that I could get the manual clock toggling behavior.<u></u><u></=
u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Maybe worth noting the Python version of the &quot;p=
oke&quot; reproducer (used in the demo) is using a GL stack to dispatch an =
empty compute shader, whereas the c poke is the more barebones PM4 packet w=
ith NOP,=C2=A0 but either one acts as a toggle.=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">In the wild, the pattern seems to be:<u></u><u></u><=
/p>
<p class=3D"MsoNormal">GPU idles, sclk-&gt;0<u></u><u></u></p>
<p class=3D"MsoNormal">Lone task comes in and completes with nothing behind=
 it<u></u><u></u></p>
<p class=3D"MsoNormal">sclk-&gt;max<u></u><u></u></p>
<p class=3D"MsoNormal">Later, another task comes in<u></u><u></u></p>
<p class=3D"MsoNormal">sclk-&gt;0 (my speculation is queuing or completing =
a task triggers a test of % of recent idle clocks, and since it&#39;s been =
sitting at max clock with nothing to do, it sees 100% idle clocks and immed=
iately throttles back down to 0)=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">- Kevin<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><u></u>=C2=A0<u></u></p=
>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><u></u>=C2=A0<u></u></p=
>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><br>
<br>
<u></u><u></u></p>
<p class=3D"MsoNormal">On Mon, Aug 24, 2026, 9:04<span style=3D"font-family=
:&quot;Arial&quot;,sans-serif">=E2=80=AF</span>PM Feng, Kenneth &lt;<a href=
=3D"mailto:Kenneth.Feng@amd.com" rel=3D"noreferrer noreferrer noreferrer" t=
arget=3D"_blank">Kenneth.Feng@amd.com</a>&gt; wrote:<u></u><u></u></p>
<blockquote style=3D"border-width:medium medium medium 1pt;border-style:non=
e none none solid;border-color:currentcolor currentcolor currentcolor rgb(2=
04,204,204);padding:0in 0in 0in 6pt;margin-left:4.8pt;margin-right:0in">
<div>
<p style=3D"margin:5pt"><span style=3D"font-size:10pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:blue">AMD General<u></u><u></u></span></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Thanks Kevin.<u></u><u></u></p>
<p class=3D"MsoNormal">At the beginning of the video, right after gpu-monit=
or.py is executed, there are 13 jobs dispatched.<u></u><u></u></p>
<p class=3D"MsoNormal">Are they also the NOP packets?<u></u><u></u></p>
<p class=3D"MsoNormal">Thanks.<u></u><u></u></p>
<p class=3D"MsoNormal"><img border=3D"0" width=3D"626" height=3D"370" style=
=3D"width:6.5208in;height:3.8541in" id=3D"m_7888301642954205455m_-233940843=
5247098065m_7144945539502236446m_-3329871365474375399m_-8292506879013255752=
m_8106083757949606588m_4668711718003070156Picture_x0020_1" src=3D"https://m=
ail.google.com/mail/u/0?ui=3D2&amp;ik=3D312744bcb4&amp;attid=3D0.2&amp;perm=
msgid=3Dmsg-a:r4899060653325978718&amp;view=3Dfimg&amp;fur=3Dip&amp;permmsg=
id=3Dmsg-a:r4899060653325978718&amp;sz=3Ds0-l75-ft&amp;attbid=3DANGjdJ_ZrDf=
C-Lj3sK1o-8hrVvwG06Lgvv6W33xH91Ojq717jCVASxVCkYWR2iqY5GSUjFhHK5lPsoeWlTiFkr=
_PYzsq9-rQ-zS1B-pFh2dlyMVHst_Yg34Ws0ZCAFc&amp;disp=3Demb&amp;realattid&amp;=
zw"><u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div style=3D"border-width:1pt medium medium;border-style:solid none none;b=
order-color:rgb(225,225,225) currentcolor currentcolor;padding:3pt 0in 0in"=
>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;C=
alibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11pt;font=
-family:&quot;Calibri&quot;,sans-serif"> Kevin Hake &lt;<a href=3D"mailto:k=
evin@adec.dev" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">k=
evin@adec.dev</a>&gt;
<br>
<b>Sent:</b> Tuesday, August 25, 2026 3:22 AM<br>
<b>To:</b> Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng@amd.com" rel=3D=
"noreferrer noreferrer noreferrer" target=3D"_blank">Kenneth.Feng@amd.com</=
a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" rel=3D"noreferr=
er noreferrer noreferrer" target=3D"_blank">amd-gfx@lists.freedesktop.org</=
a>; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" rel=
=3D"noreferrer noreferrer noreferrer" target=3D"_blank">Alexander.Deucher@a=
md.com</a>&gt;<br>
<b>Subject:</b> Re: [drm/amd #3549] Navi 33 idle sclk latch: repro, analysi=
s, userspace workaround</span><u></u><u></u></p>
</div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" align=3D"left" widt=
h=3D"100%" style=3D"width:100%">
<tbody>
<tr>
<td width=3D"0" style=3D"width:0.3pt;background:rgb(166,166,166);padding:5.=
25pt 1.5pt">
</td>
<td width=3D"100%" style=3D"background:revert;border:revert;color:revert;di=
rection:revert;display:revert;font-size:revert;height:revert;letter-spacing=
:revert;line-height:revert;margin:revert;opacity:revert;outline:revert;over=
flow:revert;padding:revert;table-layout:revert;text-align:revert;text-inden=
t:revert;text-orientation:revert;text-overflow:revert;text-transform:revert=
;vertical-align:revert;white-space:revert;width:revert;word-break:revert;wo=
rd-spacing:revert;writing-mode:revert;zoom:revert">
<p class=3D"MsoNormal">
<span style=3D"font-size:9pt;font-family:&quot;Segoe UI&quot;,sans-serif;co=
lor:rgb(33,33,33)">You don&#39;t often get email from
<a href=3D"mailto:kevin@adec.dev" rel=3D"noreferrer noreferrer noreferrer" =
target=3D"_blank">kevin@adec.dev</a>. <a href=3D"https://aka.ms/LearnAboutS=
enderIdentification" rel=3D"noreferrer noreferrer noreferrer" target=3D"_bl=
ank">
Learn why this is important</a> </span><u></u><u></u></p>
</td>
<td width=3D"75" style=3D"background:revert;border:revert;color:revert;dire=
ction:revert;display:revert;font-size:revert;height:revert;letter-spacing:r=
evert;line-height:revert;margin:revert;opacity:revert;outline:revert;overfl=
ow:revert;padding:revert;table-layout:revert;text-align:revert;text-indent:=
revert;text-orientation:revert;text-overflow:revert;text-transform:revert;v=
ertical-align:revert;white-space:revert;width:revert;word-break:revert;word=
-spacing:revert;writing-mode:revert;zoom:revert">
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt">Hi Kenneth,<u></u><u></=
u></p>
<p class=3D"MsoNormal">I think that&#39;s the bug - it is reporting 100% ut=
ilization but the GPU is idle - I know=C2=A0it&#39;s idle because I traced =
job submissions and dispatch, and separately drm_sched_job_done,
 debugfs pending fences, the kernel&#39;s drm-engine-* nanoseconds - everyt=
hing points to nothing actually crunching, at least nothing real from users=
pace. Not to mention I&#39;m in TTY with minimal system activity. You can s=
ee the behavior in this demo:
<a href=3D"https://asciinema.org/a/Qc5CQBW6ycb89ldd" rel=3D"noreferrer nore=
ferrer noreferrer" target=3D"_blank">https://asciinema.org/a/Qc5CQBW6ycb89l=
dd</a><u></u><u></u></p>
<p class=3D"MsoNormal"><br>
I&#39;m wondering if there&#39;s a bug where utilization is calculated some=
thing something like, &quot;how many idle clocks have there been since we l=
ast checked?&quot;. If the gpu has been asleep with sclk =3D=3D 0, then it =
sees 0 idle clocks in the past n seconds (no idle clocks??
 we must be really busy!), and sets utilization to 100. But I&#39;m just sp=
eculating, what I can confirm is that with sclk at 0, a single NOP to the g=
pu toggles utilization to 100% and sclk to max. It seems odd numbers of ver=
y small work trigger the toggle, When
 larger groups of work come in it behaves more normally and doesn&#39;t &qu=
ot;stick&quot; high.=C2=A0
<u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><br>
Thanks,<u></u><u></u></p>
<p class=3D"MsoNormal">Kevin Hake
<u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">+1 716 432 7106</span><u></u><u></u></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Arial&quot;,sans-se=
rif">+52 81 1300 5479</span><u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">On Mon, Aug 24, 2026 at 8:10<span style=3D"font-fami=
ly:&quot;Arial&quot;,sans-serif">=E2=80=AF</span>AM Feng, Kenneth &lt;<a hr=
ef=3D"mailto:Kenneth.Feng@amd.com" rel=3D"noreferrer noreferrer noreferrer"=
 target=3D"_blank">Kenneth.Feng@amd.com</a>&gt;
 wrote:<u></u><u></u></p>
<blockquote style=3D"border-width:medium medium medium 1pt;border-style:non=
e none none solid;border-color:currentcolor currentcolor currentcolor rgb(2=
04,204,204);padding:0in 0in 0in 6pt;margin:5pt 0in 5pt 4.8pt">
<p style=3D"margin:5pt"><span style=3D"font-size:10pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:blue">AMD General</span><u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">What=E2=80=99s the GPU utilization(observed by sudo =
cat /sys/kernel/debug/dri/x/amdgpu_pm_info) when the sclk is highest?<u></u=
><u></u></p>
<p class=3D"MsoNormal">The policy is that if the utilization is 100%, the c=
lock has to stay highest.<u></u><u></u></p>
<p class=3D"MsoNormal">Could you please elaborate what =E2=80=98a tiny job=
=E2=80=99 is to trigger the issue?<u></u><u></u></p>
<p class=3D"MsoNormal">Thanks.<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<div style=3D"border-width:1pt medium medium;border-style:solid none none;p=
adding:3pt 0in 0in;border-color:currentcolor">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;C=
alibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11pt;font=
-family:&quot;Calibri&quot;,sans-serif"> amd-gfx &lt;<a href=3D"mailto:amd-=
gfx-bounces@lists.freedesktop.org" rel=3D"noreferrer noreferrer noreferrer"=
 target=3D"_blank">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
<b>On Behalf Of </b>Kevin Hake<br>
<b>Sent:</b> Sunday, August 23, 2026 11:05 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" rel=3D"noreferr=
er noreferrer noreferrer" target=3D"_blank">amd-gfx@lists.freedesktop.org</=
a><br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">Alexander.De=
ucher@amd.com</a>&gt;<br>
<b>Subject:</b> [drm/amd #3549] Navi 33 idle sclk latch: repro, analysis, u=
serspace workaround</span><u></u><u></u></p>
</div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" align=3D"left" widt=
h=3D"100%" style=3D"width:100%">
<tbody>
<tr>
<td width=3D"0" style=3D"width:0.3pt;background:rgb(166,166,166);padding:5.=
25pt 1.5pt">
</td>
<td width=3D"100%" style=3D"background:revert;border:revert;color:revert;di=
rection:revert;display:revert;font-size:revert;height:revert;letter-spacing=
:revert;line-height:revert;margin:revert;opacity:revert;outline:revert;over=
flow:revert;padding:revert;table-layout:revert;text-align:revert;text-inden=
t:revert;text-orientation:revert;text-overflow:revert;text-transform:revert=
;vertical-align:revert;white-space:revert;width:revert;word-break:revert;wo=
rd-spacing:revert;writing-mode:revert;zoom:revert">
<p class=3D"MsoNormal">
<span style=3D"font-size:9pt;font-family:&quot;Segoe UI&quot;,sans-serif;co=
lor:rgb(33,33,33)">Some people who received this message don&#39;t often ge=
t email from
<a href=3D"mailto:kevin@adec.dev" rel=3D"noreferrer noreferrer noreferrer" =
target=3D"_blank">kevin@adec.dev</a>. <a href=3D"https://aka.ms/LearnAboutS=
enderIdentification" rel=3D"noreferrer noreferrer noreferrer" target=3D"_bl=
ank">
Learn why this is important</a> </span><u></u><u></u></p>
</td>
<td width=3D"75" style=3D"background:revert;border:revert;color:revert;dire=
ction:revert;display:revert;font-size:revert;height:revert;letter-spacing:r=
evert;line-height:revert;margin:revert;opacity:revert;outline:revert;overfl=
ow:revert;padding:revert;table-layout:revert;text-align:revert;text-indent:=
revert;text-orientation:revert;text-overflow:revert;text-transform:revert;v=
ertical-align:revert;white-space:revert;width:revert;word-break:revert;word=
-spacing:revert;writing-mode:revert;zoom:revert">
</td>
</tr>
</tbody>
</table>
<p class=3D"MsoNormal"><br clear=3D"all">
<u></u><u></u></p>
<p class=3D"MsoNormal">Hi all,<br>
<br>
Follow-up to drm/amd issue #3549 (&quot;AMD GPU usage peaks with system in =
idle =E2=80=94<br>
Radeon RX 7600 XT&quot;), where I posted a root-cause analysis and reproduc=
er<br>
a few weeks ago (note 3586398). The thread&#39;s been quiet, so I&#39;m sum=
marizing<br>
here in case it&#39;s useful to whoever owns PMFW/swsmu for SMU 13.0.7.<br>
<br>
Behavior (RX 7600 XT / Navi 33, kernels 6.x=E2=80=937.1, likely any DE (tho=
 I&#39;m on Plasma w/Wayland) or bare TTY):<br>
<br>
=C2=A0 - With the gfx job stream verifiably empty, a single tiny job submit=
ted<br>
=C2=A0 =C2=A0 while sclk is at 0 (deep sleep) latches sclk at max (~2990 MH=
z, ~115 W)<br>
=C2=A0 =C2=A0 indefinitely. A second completed gfx job clears it. So at tru=
e idle the<br>
=C2=A0 =C2=A0 card toggles between 0 and max on every stray job, and can si=
t at max<br>
=C2=A0 =C2=A0 for an hour with the screen off.<br>
=C2=A0 - Light sustained load (video, a compositor, radeontop) masks it, wh=
ich<br>
=C2=A0 =C2=A0 is why the earlier &quot;monitoring tools toggle gfxoff&quot;=
 hypothesis looked<br>
=C2=A0 =C2=A0 plausible. It reproduces on demand from a TTY with nothing po=
lling.<br>
=C2=A0 - Umio&#39;s finding that disabling GFXOFF via ppfeaturemask stops t=
he spikes<br>
=C2=A0 =C2=A0 is consistent with this model: without GFXOFF there is no &qu=
ot;single job<br>
=C2=A0 =C2=A0 from deep sleep&quot; transition to mis-handle.<br>
<br>
How I measured:<br>
<br>
=C2=A0 - Job stream: a private ftrace instance on amdgpu_cs_ioctl /<br>
=C2=A0 =C2=A0 amdgpu_sched_run_job / drm_sched_job_done, cross-checked agai=
nst fdinfo<br>
=C2=A0 =C2=A0 drm-engine counters and debugfs amdgpu_fence_info, so I could=
 prove the<br>
=C2=A0 =C2=A0 kernel submitted nothing while clocks moved.<br>
=C2=A0 - Clock: sampling the firmware&#39;s gpu_metrics (v1.3) at 1 kHz, ma=
tched to<br>
=C2=A0 =C2=A0 the driver&#39;s 1 ms refresh of that table, to catch the ram=
p edges.<br>
=C2=A0 - Stimulus: a minimal compute dispatch with a held context (no setup=
/<br>
=C2=A0 =C2=A0 teardown jobs), and later a one-packet PM4 NOP via libdrm =E2=
=80=94 either one<br>
=C2=A0 =C2=A0 toggles the latch.<br>
<br>
Everything points at the firmware&#39;s clock selection rather than the dri=
ver.<br>
Since PMFW can&#39;t be patched from outside, I published a small userspace=
<br>
workaround: a C daemon over libdrm/render node that submits one PM4 NOP<br>
when it sees sclk latched (same binary is the manual reproducer):<br>
<br>
=C2=A0 <a href=3D"https://github.com/KevinHake/amdgpu-unstick" rel=3D"noref=
errer noreferrer noreferrer" target=3D"_blank">https://github.com/KevinHake=
/amdgpu-unstick</a><br>
<br>
Scripts, logs, and an asciinema demo are attached to the issue. If a<br>
narrower repro would help (specific firmware versions, mesa-free path,<br>
other kernels), tell me what you need and I&#39;ll run it.<br>
<br>
Thanks,<br>
Kevin Hake<u></u><u></u></p>
</blockquote>
</div>
</blockquote>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><u></u>=C2=A0<u></u></p=
>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><u></u>=C2=A0<u></u></p=
>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><u></u>=C2=A0<u></u></p=
>
</div>
</div>
</div>

</blockquote></div>
<br><br></div>
<br><br></div>

--000000000000a87def0659e20fbf--

--000000000000a87df00659e20fc1
Content-Type: image/png; name="image001.png"
Content-Disposition: attachment; filename="image001.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_1a03951a2074cff311>
X-Attachment-Id: ii_1a03951a2074cff311

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
--000000000000a87df00659e20fc1--
