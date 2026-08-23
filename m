Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D3FC5DF94
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 07:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D802610E0DF;
	Mon, 24 Aug 2026 07:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=adec.dev header.i=@adec.dev header.b="XAwT1Pmw";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE23510E00A
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Aug 2026 15:05:29 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso2124771f8f.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Aug 2026 08:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787497528; cv=none;
 d=google.com; s=arc-20260327;
 b=rZBmgrFuCzpvtyOeTU5XSXnVqMNJn0PfGqO+peXIUyYt8RSNmVehm/ZU+SLL+WTrM3
 PClSPTdregqA4iuHsPo3OFjsz40PWQqQ1btS0OZK5xBNvD2A5Am/7mO8uq5VgpzKVr/6
 doRm+rsfbKW8FaWVuHa7iP8/S2OP2llWCK5QOcwsz/5H3NtuOKBICt1egApy31LvcW64
 CKWTBR1cJDeSfAGA8krBKu+B6jeed6R0jk3kHWF+lXEcRWr6kJk+993kOTDjaXblZZa+
 0VNKkDNkl28N/V01oqXIm8WHEH+Tut3lOe569mSXxs2F8N+TwErD4nE8q3cC0J8iLvfi
 sSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=bqy0Z5gt95vgJXQYSwWz6emMp7N4CHp0JpDga+1MlxY=;
 fh=UOs4AE4qjGd21zFslyBEqQZetRrW593aa1+yYb021Fo=;
 b=Fk3g6AyGwuOO812S3JOkvQECnxcrBmybTAWqyCwo5FVFJwRnLlW4Sg4irRl0yCh7Uf
 sO8rlWF2bYR5NlroNV4XxzOy3MaQ1lUE9jbpGvajc+IARHdiMzLCjiJjuhSab3PuFpUb
 q2YbbxKY7ozWSHfv2LHcpuuSHHM+gSbOhW6WLRc4RT06DU4FBEcWHsIoF84BnS9/QtW6
 WPSHHtb4+BcEl9OKP6BEtuP1iEScGowZ0B/hBSaHrzwsSEQC1KMcyqQS8K02IILtYDLt
 EodJc6aqOX1Ys5Uho5vYL0nVwMPYrs9Yf3aI4DPyvt5okrEPk25KyRKvRMBHi0xOcxnp
 vw+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adec.dev; s=google; t=1787497528; x=1788102328; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bqy0Z5gt95vgJXQYSwWz6emMp7N4CHp0JpDga+1MlxY=;
 b=XAwT1PmwFhxmRR7eMM/UIxc42ZqlPj+eUQH8buJncPpAtE0X0A6NaOVPoZ3CDl2NFr
 AnC9+VkLYNzIL1QQhu6hcyEBQ73zAF1VA/8X4157spkIXujJ+G/G8ejHr9e6+Bkln8Rr
 /jhBb/nimn3FYbHZPeZNGpcRb0m7pYt39t8DY8ouS+EZKbgdI2GJFQLeS3CznbWzwQby
 5YuFGa89APo+Y0mlRPRTxp3wQs8vS/6wT5H1chnnGIgKVNLL0bwFKHz9yvR8Fka3udmV
 MUlKQ1Y9Or7MHErSfSxy1EosYZxRbUVisRTpBrofUPMQaDdR2aMUvQTFnzCgsitvoX6b
 v2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497528; x=1788102328;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bqy0Z5gt95vgJXQYSwWz6emMp7N4CHp0JpDga+1MlxY=;
 b=hoKUSiphzcxEwPxecYlw3KMvr9PDIrOQ8tkuATK1kqjZPKC7daUd8QfwC5VL0XiyGf
 X7cosU98aEGWHG2/1lbRAxtXkd9+txy9rmfQol9vNaneN1xQ7t8DGs+ot8ORFrtMlAUK
 jHWGysLCHlRPAgHr+sOEv5QTqXVvV5yl7jLTAQv3+9UG8e8qRu3m/2WFWwTSBe46BRha
 jwlNX4n/WF79w9h4pbkwx5UKttLqAQRf/T9niueouoGDDRe9L1m6CftBwrAm1AhAizib
 QtzuziEFERayZXrnTSYxOMb5ZlQBtIR4eG43Hzi7oJgwd4QYfoKgsgrkbEDO0vJaf1tP
 wMOQ==
X-Gm-Message-State: AFuF++l/5URhVE63kXJoP9xZKuZx+4EZqgpuwqvtNzjRNzySGSDqXC1q
 YFX0BAlQxaKNYTXLbNuwbCc0FdWLJXk4wRP7/K17rDCQkgxePGZURqGODd2HbXNYBw4ECbiplCS
 qbXP+bg5esr82ixQ+qJVR8EPSWaTDrY/aeJ5HikHD8KpCQWXmpCchGPcPLw==
X-Gm-Gg: AR+sD10fD2GrwpFjf5IOvedpnJURn/MwKcG43snA/NwitGkUj1DGH5JXnx4R+5yd9lz
 N2jx/vaaMOc4vzH2MjT6QhfPSuzMVFMKArzHWIagOu63ZvxlV7hjH4MXuFDAgIQ6wqfV2P/G0kF
 oTz5HM+X6tKhbkOdpsrZabH2p5XBuGK4nAGFfdWxm6fW093VwmIvmweiOF3ytr1f9HnhsIKKSLe
 po7GLNpSkNJY26iakjYKUj0LUXH243XttfA0YoKvQYOeT1AV4bqQA6WLZvRS1zeI/SFiqoIisth
 ZdkCMXoD5oiQp9SHsWBMSjm50H5OOw6UoJNUJaJf43eFWphMOvBmoF7JitLxN4eMykyO7mXdl8C
 H
X-Received: by 2002:adf:e18c:0:b0:47f:9283:1fb3 with SMTP id
 ffacd0b85a97d-482c810c17bmr12151252f8f.0.1787497527825; Sun, 23 Aug 2026
 08:05:27 -0700 (PDT)
MIME-Version: 1.0
From: Kevin Hake <kevin@adec.dev>
Date: Sun, 23 Aug 2026 08:05:16 -0700
X-Gm-Features: AcwNN1U0GLbdISq-KdUC6arnYooRAMN4VFXNrQEVjBvWBCrGfjI6oO9bw8E8cFI
Message-ID: <CA+9SDS166EhN-DAFNqatoJ84sY2-MMESY=1BXenHAr9CubK=wA@mail.gmail.com>
Subject: [drm/amd #3549] Navi 33 idle sclk latch: repro, analysis,
 userspace workaround
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Content-Type: multipart/alternative; boundary="0000000000002f07d00659b83398"
X-Mailman-Approved-At: Mon, 24 Aug 2026 07:56:52 +0000
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

--0000000000002f07d00659b83398
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Follow-up to drm/amd issue #3549 ("AMD GPU usage peaks with system in idle =
=E2=80=94
Radeon RX 7600 XT"), where I posted a root-cause analysis and reproducer
a few weeks ago (note 3586398). The thread's been quiet, so I'm summarizing
here in case it's useful to whoever owns PMFW/swsmu for SMU 13.0.7.

Behavior (RX 7600 XT / Navi 33, kernels 6.x=E2=80=937.1, likely any DE (tho=
 I'm on
Plasma w/Wayland) or bare TTY):

  - With the gfx job stream verifiably empty, a single tiny job submitted
    while sclk is at 0 (deep sleep) latches sclk at max (~2990 MHz, ~115 W)
    indefinitely. A second completed gfx job clears it. So at true idle the
    card toggles between 0 and max on every stray job, and can sit at max
    for an hour with the screen off.
  - Light sustained load (video, a compositor, radeontop) masks it, which
    is why the earlier "monitoring tools toggle gfxoff" hypothesis looked
    plausible. It reproduces on demand from a TTY with nothing polling.
  - Umio's finding that disabling GFXOFF via ppfeaturemask stops the spikes
    is consistent with this model: without GFXOFF there is no "single job
    from deep sleep" transition to mis-handle.

How I measured:

  - Job stream: a private ftrace instance on amdgpu_cs_ioctl /
    amdgpu_sched_run_job / drm_sched_job_done, cross-checked against fdinfo
    drm-engine counters and debugfs amdgpu_fence_info, so I could prove the
    kernel submitted nothing while clocks moved.
  - Clock: sampling the firmware's gpu_metrics (v1.3) at 1 kHz, matched to
    the driver's 1 ms refresh of that table, to catch the ramp edges.
  - Stimulus: a minimal compute dispatch with a held context (no setup/
    teardown jobs), and later a one-packet PM4 NOP via libdrm =E2=80=94 eit=
her one
    toggles the latch.

Everything points at the firmware's clock selection rather than the driver.
Since PMFW can't be patched from outside, I published a small userspace
workaround: a C daemon over libdrm/render node that submits one PM4 NOP
when it sees sclk latched (same binary is the manual reproducer):

  https://github.com/KevinHake/amdgpu-unstick

Scripts, logs, and an asciinema demo are attached to the issue. If a
narrower repro would help (specific firmware versions, mesa-free path,
other kernels), tell me what you need and I'll run it.

Thanks,
Kevin Hake

--0000000000002f07d00659b83398
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Hi=
 all,<br><br>Follow-up to drm/amd issue #3549 (&quot;AMD GPU usage peaks wi=
th system in idle =E2=80=94<br>Radeon RX 7600 XT&quot;), where I posted a r=
oot-cause analysis and reproducer<br>a few weeks ago (note 3586398). The th=
read&#39;s been quiet, so I&#39;m summarizing<br>here in case it&#39;s usef=
ul to whoever owns PMFW/swsmu for SMU 13.0.7.<br><br>Behavior (RX 7600 XT /=
 Navi 33, kernels 6.x=E2=80=937.1, likely any DE (tho I&#39;m on Plasma w/W=
ayland) or bare TTY):<br><br>=C2=A0 - With the gfx job stream verifiably em=
pty, a single tiny job submitted<br>=C2=A0 =C2=A0 while sclk is at 0 (deep =
sleep) latches sclk at max (~2990 MHz, ~115 W)<br>=C2=A0 =C2=A0 indefinitel=
y. A second completed gfx job clears it. So at true idle the<br>=C2=A0 =C2=
=A0 card toggles between 0 and max on every stray job, and can sit at max<b=
r>=C2=A0 =C2=A0 for an hour with the screen off.<br>=C2=A0 - Light sustaine=
d load (video, a compositor, radeontop) masks it, which<br>=C2=A0 =C2=A0 is=
 why the earlier &quot;monitoring tools toggle gfxoff&quot; hypothesis look=
ed<br>=C2=A0 =C2=A0 plausible. It reproduces on demand from a TTY with noth=
ing polling.<br>=C2=A0 - Umio&#39;s finding that disabling GFXOFF via ppfea=
turemask stops the spikes<br>=C2=A0 =C2=A0 is consistent with this model: w=
ithout GFXOFF there is no &quot;single job<br>=C2=A0 =C2=A0 from deep sleep=
&quot; transition to mis-handle.<br><br>How I measured:<br><br>=C2=A0 - Job=
 stream: a private ftrace instance on amdgpu_cs_ioctl /<br>=C2=A0 =C2=A0 am=
dgpu_sched_run_job / drm_sched_job_done, cross-checked against fdinfo<br>=
=C2=A0 =C2=A0 drm-engine counters and debugfs amdgpu_fence_info, so I could=
 prove the<br>=C2=A0 =C2=A0 kernel submitted nothing while clocks moved.<br=
>=C2=A0 - Clock: sampling the firmware&#39;s gpu_metrics (v1.3) at 1 kHz, m=
atched to<br>=C2=A0 =C2=A0 the driver&#39;s 1 ms refresh of that table, to =
catch the ramp edges.<br>=C2=A0 - Stimulus: a minimal compute dispatch with=
 a held context (no setup/<br>=C2=A0 =C2=A0 teardown jobs), and later a one=
-packet PM4 NOP via libdrm =E2=80=94 either one<br>=C2=A0 =C2=A0 toggles th=
e latch.<br><br>Everything points at the firmware&#39;s clock selection rat=
her than the driver.<br>Since PMFW can&#39;t be patched from outside, I pub=
lished a small userspace<br>workaround: a C daemon over libdrm/render node =
that submits one PM4 NOP<br>when it sees sclk latched (same binary is the m=
anual reproducer):<br><br>=C2=A0 <a href=3D"https://github.com/KevinHake/am=
dgpu-unstick">https://github.com/KevinHake/amdgpu-unstick</a><br><br>Script=
s, logs, and an asciinema demo are attached to the issue. If a<br>narrower =
repro would help (specific firmware versions, mesa-free path,<br>other kern=
els), tell me what you need and I&#39;ll run it.<br><br>Thanks,<br>Kevin Ha=
ke</div></div></div></div>

--0000000000002f07d00659b83398--
