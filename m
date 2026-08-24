Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30742C61DB9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 13:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6B3C10EA4B;
	Tue, 25 Aug 2026 13:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=adec.dev header.i=@adec.dev header.b="QrP0x/lj";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56EB10E085
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 19:22:07 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so31892495e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 12:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787599326; cv=none;
 d=google.com; s=arc-20260327;
 b=I0gArlCHbACsGmO9IY7s42pjcAbS8oHGgdMWAFBaOkcRMJaGfKIMFs4ezUnJK0AIcz
 R0gT4vLP65U0DJnTnAnTMPVd1Bvnrg+I01jiu+6CvK2oUC86VQdLs78O5k3dgbgTTGCj
 1bTQd6+O3ipB037w1rynB5Wc2CwNzisUzlIhzJ3T4ZOY09d/OYGAmGqMOsxUaG3WDVCj
 8tOls06yGmEW15Yp7nl323wBlRUjFTPUCEOGj0yxS+V87jmYvfB6f9BCKk0YMxJfQQTM
 coOaDMXe+y0fo54pv/nksQ0GrrNMimyuwvesr+OUQ5zQNWmz6sl+AOHwrOIT8xP3qLPZ
 5BGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hUkO+6VHMkbHHmGHg2153TOIbSKMpkUUJan1pd0ru1Q=;
 fh=RbgENLHjGX51AYcf+CWPtx2IRnsttmLchuQK/WLGTqQ=;
 b=WYC43jTq5Q+XtoG0D6ZP9tUNk9c7lWnCx1/O9aMpCgqYVvMMaxkK1ExH7hQj/zdMW0
 D2lODWtQtRrLyy0ypYhV7zZlakM8Y8CSf19fjLm+xACU9SeAy2Dk5q2sMAd2LtuiKD7W
 AvyIw26ZKhbBk95J9aR4SugVxJJn9ZZrnoci3IDIAyAUN0nurLMltPi6BDHc4jA5kEPz
 WeuQzu2g7ODED2WtfBVofWyu0hY+CW0laT6HQWtuupMdoNDmpXa9ktGFVXfx90bjXWi0
 OpbuNzLFLNb1ZJdzHl/rFOqbij9FBgb4T5yyDh3itCflNj9VhoKpOA5PB+Q0tYSrkCiX
 z5Mw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adec.dev; s=google; t=1787599326; x=1788204126; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hUkO+6VHMkbHHmGHg2153TOIbSKMpkUUJan1pd0ru1Q=;
 b=QrP0x/ljpYAl3p23z9qErTdpn7aLfIc0J94PHFa7jhxzIK3ksf+e373GOUACNir0qw
 eOaBW5QOwTYgAmKd6G82ZsjtTMAtF33Qh4RvsSMsCxIqEPZaZeVEZnyvkxICVfbyUa6u
 /4cOEKsX0vchHnxRWQFrPs291+V928p0SOzAxL/1IWjsBWT+5dVqX9jUEGt3maMNuKyX
 y7N/cPOO0wqArb5m3Sn7SRO3cEUs6jh6Xyo10ovSj6gtiyQHCObCApoXJmsNOWFlDUee
 7OnaGXtSHk1tzoKKWrgLXwsimff/Jssf8guHwMJ0L9s4qIl0pMCYT3tVHYLMaC4Mo6va
 bDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787599326; x=1788204126;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hUkO+6VHMkbHHmGHg2153TOIbSKMpkUUJan1pd0ru1Q=;
 b=oKyE28hDy1uvjP0XuCeYmBPhg/ocjE+cFtIeYdQF0eSopacyBxXLFujd5Bmiah1kVn
 svGfRPB+Qoxt0tuh/TR+uhBNgHWOTqZCMEJvXUpbTyQk6GWo1h2yhVZ26HkcQs/VETVq
 /+Z0ad9YRzOHlM6M3J1rpZlvN6dLTenIPrS3PSnQ09H2o0sqpK++P8gOiO+6ZJtbmwK1
 ZpTIlUCjMUpLhm9WdB6gWiAHZNK+awyfz1dnVjr11RYZjou7DlPGy2rETLyRh4ylIZtF
 60vTLwk2GyXCrqOcKeM5K1uJzeundQXZrXpILFJrD4C56DzWUTVK2hbqOgxjy1LT7fEe
 A6DQ==
X-Gm-Message-State: AFuF++lX6pX4Om2EXFcCv68s8CVD6IfQZ3ttnZ6gINcrJKwgq7IXVrLa
 LvkXAAIFGTvgv6N57TO1kDUf60qwT9I63OslqQ6hr8fh67DZio99N3f5HKzcG13Ox2HAMP/z+nT
 lu2Wlq5bKk2HI5LmJvZrVgPemI5YqXWZwCID7wrhzdw==
X-Gm-Gg: AR+sD10d9pudkOkP3+b125KwXujZRbZ4jiF0p60qvx2q9sD4Bs0FxOR6545i/2jLtu9
 lFrxQG+doBtRYYEHjZq8Pln6m/kxfeCtz/eFKJUVFcd3d4gJEOzRibJqY/ZFKdEPT1aF2DajPZZ
 n/BbknMs54hY+QAjAcRatgfMZ+/J4pDWs6Qtiqg5Kh61qewGkBPRPulslirpZFcKUzhIHV5O3hx
 vFCEvW0SIsxIiMP6slRwqg/pQ9UBlaTKfbL0ldq+h8/2CBke2qrC2PgqWL+rIaYktiPzZSvJ4FK
 7L9Eie6bpgHNFvUBiGojAzb38UN1z3Vr/RQjVxGs3NvBkki13gCgUqk0ZbmHrrZX0caLeH8Ll0s
 tGYHdOOvx2gHe
X-Received: by 2002:a05:600c:4688:b0:499:60bf:c6f7 with SMTP id
 5b1f17b1804b1-499d6523cf8mr14828825e9.13.1787599325772; Mon, 24 Aug 2026
 12:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+9SDS166EhN-DAFNqatoJ84sY2-MMESY=1BXenHAr9CubK=wA@mail.gmail.com>
 <LV8SPRMB00725DD889913F321618A0F38EA02@LV8SPRMB0072.namprd12.prod.outlook.com>
In-Reply-To: <LV8SPRMB00725DD889913F321618A0F38EA02@LV8SPRMB0072.namprd12.prod.outlook.com>
From: Kevin Hake <kevin@adec.dev>
Date: Mon, 24 Aug 2026 12:21:54 -0700
X-Gm-Features: AcwNN1X_Jg-VUFwZ1Jn7hxV2l-uB3nfgY0bQnG_QvUjF3CObKkGQctYGaxRQTc4
Message-ID: <CA+9SDS3ZJKZrwSrm_sXSj7wE0MBrKLkp9+zGZR-CtE_cbeeyuA@mail.gmail.com>
Subject: Re: [drm/amd #3549] Navi 33 idle sclk latch: repro, analysis,
 userspace workaround
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: multipart/alternative; boundary="000000000000d04d030659cfe6b5"
X-Mailman-Approved-At: Tue, 25 Aug 2026 13:01:27 +0000
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

--000000000000d04d030659cfe6b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kenneth,

I think that's the bug - it is reporting 100% utilization but the GPU is
idle - I know it's idle because I traced job submissions and dispatch, and
separately drm_sched_job_done, debugfs pending fences, the kernel's
drm-engine-* nanoseconds - everything points to nothing actually crunching,
at least nothing real from userspace. Not to mention I'm in TTY with
minimal system activity. You can see the behavior in this demo:
https://asciinema.org/a/Qc5CQBW6ycb89ldd

I'm wondering if there's a bug where utilization is calculated something
something like, "how many idle clocks have there been since we last
checked?". If the gpu has been asleep with sclk =3D=3D 0, then it sees 0 id=
le
clocks in the past n seconds (no idle clocks?? we must be really busy!),
and sets utilization to 100. But I'm just speculating, what I can confirm
is that with sclk at 0, a single NOP to the gpu toggles utilization to 100%
and sclk to max. It seems odd numbers of very small work trigger the
toggle, When larger groups of work come in it behaves more normally and
doesn't "stick" high.

Thanks,

Kevin Hake
+1 716 432 7106
+52 81 1300 5479


On Mon, Aug 24, 2026 at 8:10=E2=80=AFAM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:

> AMD General
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

--000000000000d04d030659cfe6b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi Kenneth,<br><br></div>I think that&#39;s the =
bug - it is reporting 100% utilization but the GPU is idle - I know=C2=A0it=
&#39;s idle because I traced job submissions and dispatch, and separately d=
rm_sched_job_done, debugfs pending fences, the kernel&#39;s drm-engine-* na=
noseconds - everything points to nothing actually crunching, at least nothi=
ng real from userspace. Not to mention I&#39;m in TTY with minimal system a=
ctivity. You can see the behavior in this demo: <a href=3D"https://asciinem=
a.org/a/Qc5CQBW6ycb89ldd">https://asciinema.org/a/Qc5CQBW6ycb89ldd</a></div=
><div><br>I&#39;m wondering if there&#39;s a bug where utilization is calcu=
lated something something like, &quot;how many idle clocks have there been =
since we last checked?&quot;. If the gpu has been asleep with sclk =3D=3D 0=
, then it sees 0 idle clocks in the past n seconds (no idle clocks?? we mus=
t be really busy!), and sets utilization to 100. But I&#39;m just speculati=
ng, what I can confirm is that with sclk at 0, a single NOP to the gpu togg=
les utilization to 100% and sclk to max. It seems odd numbers of very small=
 work trigger the toggle, When larger groups of work come in it behaves mor=
e normally and doesn&#39;t &quot;stick&quot; high.=C2=A0<div><br>Thanks,<br=
><br><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmai=
l_signature"><div dir=3D"ltr">Kevin Hake<div><font face=3D"arial, sans-seri=
f">+1 716 432 7106</font></div><div><font face=3D"arial, sans-serif">+52 81=
 1300 5479</font></div></div></div></div><br></div></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 24, 20=
26 at 8:10=E2=80=AFAM Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng@amd.=
com" target=3D"_blank">Kenneth.Feng@amd.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div>





<div lang=3D"EN-US">
<p style=3D"font-family:Calibri;font-size:10pt;color:rgb(0,0,255);margin:5p=
t;font-style:normal;font-weight:normal;text-decoration:none" align=3D"Left"=
>
AMD General<br>
</p>
<br>
<div>
<div>
<p class=3D"MsoNormal">What=E2=80=99s the GPU utilization(observed by sudo =
cat /sys/kernel/debug/dri/x/amdgpu_pm_info) when the sclk is highest?<u></u=
><u></u></p>
<p class=3D"MsoNormal">The policy is that if the utilization is 100%, the c=
lock has to stay highest.<u></u><u></u></p>
<p class=3D"MsoNormal">Could you please elaborate what =E2=80=98a tiny job=
=E2=80=99 is to trigger the issue?<u></u><u></u></p>
<p class=3D"MsoNormal">Thanks.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div style=3D"border-width:1pt medium medium;border-style:solid none none;b=
order-color:rgb(225,225,225) currentcolor currentcolor;padding:3pt 0in 0in"=
>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11pt;font-family:&quot;C=
alibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11pt;font=
-family:&quot;Calibri&quot;,sans-serif"> amd-gfx &lt;<a href=3D"mailto:amd-=
gfx-bounces@lists.freedesktop.org" target=3D"_blank">amd-gfx-bounces@lists.=
freedesktop.org</a>&gt;
<b>On Behalf Of </b>Kevin Hake<br>
<b>Sent:</b> Sunday, August 23, 2026 11:05 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blan=
k">amd-gfx@lists.freedesktop.org</a><br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> [drm/amd #3549] Navi 33 idle sclk latch: repro, analysis, u=
serspace workaround<u></u><u></u></span></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
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
<div>
<p class=3D"MsoNormal">
<span style=3D"font-size:9pt;font-family:&quot;Segoe UI&quot;,sans-serif;co=
lor:rgb(33,33,33)">Some people who received this message don&#39;t often ge=
t email from
<a href=3D"mailto:kevin@adec.dev" target=3D"_blank">kevin@adec.dev</a>. <a =
href=3D"https://aka.ms/LearnAboutSenderIdentification" target=3D"_blank">
Learn why this is important</a> <u></u><u></u></span></p>
</div>
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
=C2=A0 <a href=3D"https://github.com/KevinHake/amdgpu-unstick" target=3D"_b=
lank">https://github.com/KevinHake/amdgpu-unstick</a><br>
<br>
Scripts, logs, and an asciinema demo are attached to the issue. If a<br>
narrower repro would help (specific firmware versions, mesa-free path,<br>
other kernels), tell me what you need and I&#39;ll run it.<br>
<br>
Thanks,<br>
Kevin Hake<u></u><u></u></p>
</div>
</div>
</div>

</div></blockquote></div>

--000000000000d04d030659cfe6b5--
