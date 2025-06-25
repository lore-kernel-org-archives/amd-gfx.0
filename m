Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96FDC7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 07:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB8610E67B;
	Wed, 25 Jun 2025 07:31:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J4tIbzt2";
	dkim-atps=neutral
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C208935C;
 Wed, 25 Jun 2025 04:33:26 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-6119b103132so334140eaf.1; 
 Tue, 24 Jun 2025 21:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750826005; x=1751430805; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=svvoZRQAQYLprXCD4uzV0H0/7gLbHv8B7k/TUd/fqdQ=;
 b=J4tIbzt20nyZbpVsnzy3Y8ka+LUJh3/DgrDOV2aHVYdQXuup9Z1Yhq1Gt6hL1ga1EB
 s30TFmF/5mXRfV37MMnG4AJCupC+ilMwYtVkpCKu61dDKQLvGvpbpAgMu+qmJlUnNyg7
 Hlu4mwES41I+IKqFc2waAZqYIQTP8minGh3kRM7hXJMcqdDa2ufNoev+ZRg2kWgDU/Pv
 6r35Rk3+Qhjo8s/+1bvb22WGF0ORLAok3E0iosouRHqWge4h3JQS0Zmrfkvq5N/pv8vW
 QKiWY8jWJqGv90rrAM9ZGMYXiJN3q8+un5lqVc1/1DY4Hv+NECmWeyjPSl0+KFuqWFtU
 Dbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750826005; x=1751430805;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=svvoZRQAQYLprXCD4uzV0H0/7gLbHv8B7k/TUd/fqdQ=;
 b=vZN1/yYelBKX9GRmPaPdjS+F28MjRYLlBMk3sIQjspqZJxAcz1qmMSy6keLw2zp+VP
 LRKQ57kHRTH0vPWSGKd672pGUtSoKWp5JZKipDZrJ1TbbBEUsgqx5ssTuMw1+LBfo3xn
 2HAloIzXIr+q1fZVPJO54PaQV59/WeYBO1WM4TJ5C9RMJPBmtZoQ61GZIl3eH7KUweUs
 ZLfyFJjtEyg7MQS5HZuU2oY8eSTvSvpdoBRpA67JCbrULrPwJ9/lMetiFAM/7yGoj/Uc
 CsU7yi1YClfucjrsHcFcdvl8q4IruM2o6jZx9HfaDwgW9RhljKIe0sEJMIfUdJXODxlh
 UVsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKAUWEQiJcuF8hnT88rnP73pM8z+nOsI9lHlSgl5mb9Z8sKaFBkTWlRHE5jQEYMz2b3zVLctY7JyVNjDzG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEP+rMj2srCk8Fr7JDcfQZBk16jHRCaweEy/Gg9Hxgj7J/ulSX
 7jQED4AlqQ8XJLQ4jKCHQbLiuwgKpHRKRTHGjpNoMgPS1bP3hVnvIw6uV3wXuaszlEpsnjaMbHc
 yCKZa6EzZ48fL38k27O4T074F7ePy2fSo+BaP4K8=
X-Gm-Gg: ASbGncs4DusP4r8ySUjGg/NVihEtC5TkJXBx6HY7E7CZWeA7Gd9+r33K4fF1WX6Ub3n
 BcINJopiQEPR3lzFYprFGA8aPTyO60QyJEaXzFFj5HYZpds12wBTXX7CT+uoLC7Gr465rUzaLuL
 HmTAgas1CevClZfrJdwk+Wi/ZvL1fz4/S4yHhnQWvNXAzxR3Z8JS/r/1uxBXFvTNBRhdRL1/6sj
 w7/8w==
X-Google-Smtp-Source: AGHT+IFLeLn5jrYZqGya/eYJGNVX66J08eNeQHVdk1wEt/SYa04UDblSx11lUlwcB519y4Se0w2qmGV6ILYBtafU7l4=
X-Received: by 2002:a05:6820:6ae5:b0:611:86c1:7656 with SMTP id
 006d021491bc7-6119dbb0bc7mr981629eaf.4.1750826004576; Tue, 24 Jun 2025
 21:33:24 -0700 (PDT)
MIME-Version: 1.0
From: Johl Brown <johlbrown@gmail.com>
Date: Wed, 25 Jun 2025 14:33:13 +1000
X-Gm-Features: Ac12FXyXfKza776_5-ZRN1udU3wZq0lBRIvqoS-xmXqY715AvKL50E5lfHNtz94
Message-ID: <CAOR=gxQahs8SXmObsj-6-ux3BMpTZc=8WrSZ83hikpoBZR3OZg@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIFJYLTU4MCAoZ2Z4ODAzKSBHUFUgaGFuZ3Mgc2luY2UgfnY2LjE0Lg==?=
 =?UTF-8?B?MSDigJMg4oCcc2NoZWR1bGVyIGNvbXBfMS4xLjEgaXMgbm90IHJlYWR54oCdIC8gUk9DbSA1LjctNi40?=
 =?UTF-8?B?KyBicm9rZW4=?=
To: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx-owner@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000010fd5a06385df2cb"
X-Mailman-Approved-At: Wed, 25 Jun 2025 07:31:07 +0000
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

--00000000000010fd5a06385df2cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good Afternoon and best wishes!
This is my first attempt at upstreaming an issue after dailying arch for a
full year now :)
Please forgive me, a lot of this is pushing my comfort zone, but preventing
needless e-waste is important to me personally :) with this in mind, I will
save your eyeballs and let you know I did use gpt to help compile the
below, but I have proofread it several times (which means you can't be mad
:p ).


https://github.com/ROCm/ROCm/issues/4965
https://github.com/robertrosenbusch/gfx803_rocm/issues/35#issuecomment-2996=
884779


Hello Kernel, AMD GPU, & ROCm maintainers,

TL;DR: My Polaris (RX-580, gfx803) freezes under compute load on a number
of kernels since v6.14 and newer. This was not previously the case prior to
6.15 for ROCm 6.4.0 on gfx803 cards.

The issue has been successfully mitigated within an older version of ROC
under kernel 6.16rc2 by reverting two specific commits:

   -

   de84484c6f8b (=E2=80=9Cdrm/amdkfd: Improve signal event slow path=E2=80=
=9D, 2024-12-19)
   -

   bac38ca057fe (=E2=80=9Cdrm/amdkfd: implement per queue sdma reset for gf=
x 9.4+=E2=80=9D,
   2025-03-06)

Reverting both commits on top of v6.16-rc3 restores full stability and
allows ROCm 5.7 workloads (e.g., Stable-Diffusion, faster-whisper) to run.
Instability is usually immediately obvious via eg models failing to
initialise, no errors (other than host dmesg)/segfault reported, which is
the usual failure method under previous kernels.
------------------------------

Problem Description

A number of users report GPU hangs when initialising compute loads,
specifically with ROCm 5.7+ workloads. This issue appears to be a
regression, as it was not present in earlier kernel versions.

System Information:

   -

   OS: Arch Linux
   -

   CPU: Intel(R) Core(TM) i7-7700K CPU @ 4.20GHz
   -

   GPU: AMD Radeon RX 580 Series (gfx803)
   -

   ROCm Version: Runtime Version: 1.1, Runtime Ext Version: 1.7 (as
per rocminfo
   --support)

------------------------------

Affected Kernels and Regression Details

The problem consistently occurs on v6.14.1-rc1 and newer kernels.

   -

   Last known good: v6.11
   -

   First known bad: v6.12

The regression has been bisected to the following two commits, as reverting
them resolves the issue:

   -

   de84484c6f8b (=E2=80=9Cdrm/amdkfd: Improve signal event slow path=E2=80=
=9D, 2024-12-19)
   -

   bac38ca057fe (=E2=80=9Cdrm/amdkfd: implement per queue sdma reset =E2=80=
=A6=E2=80=9D, 2025-03-06)

Both patches touch amdkfd queue reset paths and are first included in the
exact releases where the regression appears.

Here's a summary of kernel results:

Kernel | Result | Note

------- | -------- | --------

6.13.y (LTS) | OK |

6.14.0 | OK | Baseline - my last working kernel, though I am not exactly
sure which subver

6.14.1-rc1 | BAD | First hang

6.15-rc1 | BAD | Hang

6.15.8 | BAD | Hang

6.16-rc3 | BAD | Hang

6.16-rc3 =E2=80=93 revert de84484 + bac38ca | OK | Full stability restored,=
 ROCm
workloads run for hours.
------------------------------

Reproduction Steps

   1.

   Boot the system with a kernel version exhibiting the issue (e.g.,
   v6.14.1-rc1 or newer without the reverts).
   2.

   Run a ROCm workload that creates several compute queues, for example:
   -

      python stable-diffusion.py
      -

      faster-whisper --model medium ...
      3.

   Upon model initialization, an immediate driver crash occurs. This is
   visible on the host machine via dmesg logs.

Observed Error Messages (dmesg):

[drm] scheduler comp_1.1.1 is not ready, skipping
[drm:sched_job_timedout] ERROR ring comp_1.1.1 timeout
[message continues ad-infinitum while system functions generally]

This is followed by a hard GPU reset (visible in logs, no visual
artifacts), which reliably leads to a full system lockup. Python or Docker
processes become unkillable, requiring a manual reboot. Over time, the
desktop slowly loses interactivity.
------------------------------

Bisect Details

I previously attempted a git bisect (limited to drivers/gpu/drm/amd)
between v6.12 and v6.15-rc1, which identified some further potentially
problematic commits, however due to undersized /boot/ partition was
experiencing some difficulties. In the interim, it seems a user on
<https://github.com/robertrosenbusch/gfx803_rocm/issues/35#issuecomment-299=
6884779>
the
gfx803 compatibilty repo discovered the below regarding ROC 5.7:

de84484c6f8b07ad0850d6c4  bad
bac38ca057fef2c8c024fe9e  bad

Cherry-picking reverts of both commits on top of v6.16-rc3 restores normal
behavior; leaving either patch in place reproduces the hang.
------------------------------

Relevant Log Excerpts

(Full dmesg logs can be attached separately if needed)

[drm] scheduler comp_1.1.1 is not ready, skipping
[ 97.602622] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 timeout,
signaled seq=3D123456 emitted seq=3D123459
[ 97.602630] amdgpu 0000:08:00.0: amdgpu: GPU recover succeeded, reset
domain time =3D 2ms

------------------------------
References:


   -

   It's back: Log spam: [drm] scheduler comp_1.0.2 is not ready, skipping
   ... (https://bbs.archlinux.org/viewtopic.php?id=3D302729)
   -

   Observations about HSA and KFD backends in TinyGrad =C2=B7 GitHub (
   https://gist.github.com/fxkamd/ffd02d66a2863e444ec208ea4f3adc48)
   -

   AMD RX580 system freeze on maximum VRAM speed (
   https://discussion.fedoraproject.org/t/amd-rx580-system-freeze-on-maximu=
m-vram-speed/136639
   )
   -

   LKML: Linus Torvalds: Re: [git pull] drm fixes for 6.15-rc1 (
   https://lkml.org/lkml/2025/4/5/394
   <https://www.google.com/search?q=3Dhttps://lkml.org/lkml/2025/4/5/394>)
   -

   Commits =C2=B7 torvalds/linux - GitHub (Link for commit de84484) (
   https://github.com/torvalds/linux/commits?before=3D805ba04cb7ccfc7d72e83=
4ebd796e043142156ba+6335
   <https://www.google.com/search?q=3Dhttps://github.com/torvalds/linux/com=
mits%3Fbefore%3D805ba04cb7ccfc7d72e834ebd796e043142156ba%2B6335>
   )
   -

   Commits =C2=B7 torvalds/linux - GitHub (Link for commit bac38ca) (
   https://github.com/torvalds/linux/commits?before=3D5bc1018675ec28a8a60d8=
3b378d8c3991faa5a27+7980
   <https://www.google.com/search?q=3Dhttps://github.com/torvalds/linux/com=
mits%3Fbefore%3D5bc1018675ec28a8a60d83b378d8c3991faa5a27%2B7980>
   )
   -

   ROCm-For-RX580/README.md at main - GitHub (
   https://github.com/woodrex83/ROCm-For-RX580/blob/main/README.md)
   -

   ROCm 4.6.0 for gfx803 - GitHub (
   https://github.com/robertrosenbusch/gfx803_rocm/issues/35#issuecomment-2=
996884779
   )
   -

   Compatibility matrices =E2=80=94 Use ROCm on Radeon GPUs - AMD (
   https://rocm.docs.amd.com/projects/radeon/en/latest/docs/compatibility.h=
tml
   )


------------------------------

Why this matters

Although gfx803 is End-of-Life (EOL) for official ROCm support, large user
communities (Stable-Diffusion, Whisper, Tinygrad) still depend on it.
Community builds (e.g., github.com/robertrosenbusch/gfx803_rocm/)
demonstrate that ROCm 6.4+ and RX-580 are fully functional on a number of
relatively recent kernels. This regression significantly impacts the
usability of these cards for compute workloads.
------------------------------

Proposed Next Steps

I suggest the following for further investigation:

   -

   Review the interaction between the new KFD signal-event slow-path and
   legacy GPUs that may lack valid event IDs.
   -

   Confirm whether hqd_sdma_get_doorbell() logic (added in bac38ca) returns
   stale doorbells on gfx803, potentially causing false positives.
   -

   Consider back-outs for 6.15-stable / 6.16-rc while a proper fix is
   developed.

Please let me know if you require any further diagnostics or testing. I can
easily rebuild kernels and provide annotated traces.

Please find my working document:
https://chatgpt.com/share/6854bef2-c69c-8002-a243-a06c67a2c066

Thanks for your time!

Best regards, big love,

Johl Brown

johlbrown@gmail.com

--00000000000010fd5a06385df2cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Good Afternoon and best wishes!<br>This is my first attemp=
t at upstreaming an issue after dailying arch for a full year now :)<br>Ple=
ase forgive me, a lot of this is pushing my comfort zone, but preventing ne=
edless e-waste is important to me personally :) with this in mind, I will s=
ave your eyeballs and let you know I did use gpt to help compile the below,=
 but I have proofread it several times (which means you can&#39;t be mad :p=
 ).<br><br><br><a href=3D"https://github.com/ROCm/ROCm/issues/4965">https:/=
/github.com/ROCm/ROCm/issues/4965</a><br><a href=3D"https://github.com/robe=
rtrosenbusch/gfx803_rocm/issues/35#issuecomment-2996884779">https://github.=
com/robertrosenbusch/gfx803_rocm/issues/35#issuecomment-2996884779</a><br><=
div class=3D"gmail-markdown gmail-markdown-main-panel gmail-stronger enable=
-updated-hr-color" id=3D"gmail-model-response-message-contentr_417345950294=
85f8" dir=3D"ltr" style=3D"background:none 0% 0%/auto repeat scroll padding=
-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;colo=
r:rgb(27,28,29);columns:auto;direction:ltr;float:none;isolation:auto;margin=
:0px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak=
:normal;zoom:1;font-family:&quot;Google Sans Text&quot;,sans-serif;line-hei=
ght:1.15"><p style=3D"background:none 0% 0%/auto repeat scroll padding-box =
border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:a=
uto;direction:ltr;float:none;isolation:auto;margin:0px 0px 16px;opacity:1;o=
utline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;l=
ine-height:1.15"><br></p><p style=3D"background:none 0% 0%/auto repeat scro=
ll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear=
:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 1=
6px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:=
normal;zoom:1;line-height:1.15">Hello Kernel, AMD GPU, &amp; ROCm maintaine=
rs,</p><p style=3D"background:none 0% 0%/auto repeat scroll padding-box bor=
der-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto=
;direction:ltr;float:none;isolation:auto;margin:0px 0px 16px;opacity:1;outl=
ine:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line=
-height:1.15">TL;DR: My Polaris (RX-580, gfx803) freezes under compute load=
 on a number of kernels since v6.14 and newer. This was not previously the =
case prior to 6.15 for ROCm 6.4.0 on gfx803 cards.</p><p style=3D"backgroun=
d:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border=
:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;is=
olation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;pa=
dding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15">The issue has b=
een successfully mitigated within an older version of ROC under kernel 6.16=
rc2 by reverting two specific commits:</p><ul style=3D"background:none 0% 0=
%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none r=
gb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:aut=
o;margin:0px 0px 16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px =
0px 0px 27px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><li style=3D=
"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0=
,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;flo=
at:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) n=
one 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height=
:1.15"><p style=3D"background:none 0% 0%/auto repeat scroll padding-box bor=
der-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto=
;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outli=
ne:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;=
zoom:1;line-height:1.15">de84484c6f8b (=E2=80=9Cdrm/amdkfd: Improve signal =
event slow path=E2=80=9D, 2024-12-19)</p></li><li style=3D"background:none =
0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px no=
ne rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation=
:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0=
px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><p style=
=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,=
0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;=
float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29=
) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-hei=
ght:1.15">bac38ca057fe (=E2=80=9Cdrm/amdkfd: implement per queue sdma reset=
 for gfx 9.4+=E2=80=9D, 2025-03-06)</p></li></ul><p style=3D"background:non=
e 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px =
none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolati=
on:auto;margin:0px 0px 16px;opacity:1;outline:rgb(27,28,29) none 0px;paddin=
g:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15">Reverting both comm=
its on top of v6.16-rc3 restores full stability and allows ROCm 5.7 workloa=
ds (e.g., Stable-Diffusion, faster-whisper) to run. Instability is usually =
immediately obvious via eg models failing to initialise, no errors=C2=A0<sp=
an style=3D"background-color:rgba(0,0,0,0)">(other than host dmesg)</span><=
span style=3D"background-color:rgba(0,0,0,0)">/segfault reported, which is =
the usual failure method under previous kernels.</span></p><hr style=3D"bac=
kground:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);=
clear:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px =
0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;sp=
eak:normal;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0%/auto =
repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,2=
8,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;margi=
n:0px 0px 16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:=
auto;speak:normal;zoom:1;line-height:1.15">Problem Description</p><p style=
=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,=
0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;=
float:none;isolation:auto;margin:0px 0px 16px;opacity:1;outline:rgb(27,28,2=
9) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15">A=
 number of users report GPU hangs when initialising compute loads, specific=
ally with ROCm 5.7+ workloads. This issue appears to be a regression, as it=
 was not present in earlier kernel versions.</p><p style=3D"background:none=
 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px n=
one rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolatio=
n:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:=
0px;quotes:auto;speak:normal;zoom:1;line-height:1.15">System Information:</=
p><ul style=3D"background:none 0% 0%/auto repeat scroll padding-box border-=
box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;dir=
ection:ltr;float:none;isolation:auto;margin:0px 0px 16px;opacity:1;outline:=
rgb(27,28,29) none 0px;padding:0px 0px 0px 27px;quotes:auto;speak:normal;zo=
om:1;line-height:1.15"><li style=3D"background:none 0% 0%/auto repeat scrol=
l padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:=
none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 8p=
x;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:a=
uto;speak:normal;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0%=
/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rg=
b(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto=
;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0p=
x 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15">OS: Arch Linux<=
/p></li><li style=3D"background:none 0% 0%/auto repeat scroll padding-box b=
order-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:au=
to;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;out=
line:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:norma=
l;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0%/auto repeat sc=
roll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);cle=
ar:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px=
 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quote=
s:auto;speak:normal;zoom:1;line-height:1.15">CPU: Intel(R) Core(TM) i7-7700=
K CPU @ 4.20GHz</p></li><li style=3D"background:none 0% 0%/auto repeat scro=
ll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear=
:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 8=
px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:=
auto;speak:normal;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0=
%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none r=
gb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:aut=
o;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0=
px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15">GPU: AMD Radeo=
n RX 580 Series (gfx803)</p></li><li style=3D"background:none 0% 0%/auto re=
peat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,=
29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:=
0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4p=
x;quotes:auto;speak:normal;zoom:1;line-height:1.15"><p style=3D"background:=
none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0=
px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isol=
ation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padd=
ing:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15">ROCm =
Version: Runtime Version: 1.1, Runtime Ext Version: 1.7 (as per <code style=
=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgb(233=
,238,246);border:0px none rgb(87,91,95);clear:none;color:rgb(87,91,95);colu=
mns:auto;direction:ltr;display:inline;float:none;isolation:auto;margin:0px;=
opacity:1;outline:rgb(87,91,95) none 0px;padding:1px 6px;quotes:auto;speak:=
normal;zoom:1;font-family:&quot;Google Sans Text&quot;,sans-serif;line-heig=
ht:1.15">rocminfo --support</code>)</p></li></ul><hr style=3D"background:no=
ne 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);clear:none=
;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px;op=
acity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal=
;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0%/auto repeat scr=
oll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clea=
r:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px =
16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak=
:normal;zoom:1;line-height:1.15">Affected Kernels and Regression Details</p=
><p style=3D"background:none 0% 0%/auto repeat scroll padding-box border-bo=
x rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direc=
tion:ltr;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb=
(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height=
:1.15">The problem consistently occurs on v6.14.1-rc1 and newer kernels.</p=
><ul style=3D"background:none 0% 0%/auto repeat scroll padding-box border-b=
ox rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;dire=
ction:ltr;float:none;isolation:auto;margin:0px 0px 16px;opacity:1;outline:r=
gb(27,28,29) none 0px;padding:0px 0px 0px 27px;quotes:auto;speak:normal;zoo=
m:1;line-height:1.15"><li style=3D"background:none 0% 0%/auto repeat scroll=
 padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:n=
one;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px=
;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:au=
to;speak:normal;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0%/=
auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb=
(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;=
margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px=
 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15">Last known good:=
 v6.11</p></li><li style=3D"background:none 0% 0%/auto repeat scroll paddin=
g-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;col=
umns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px;opacit=
y:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;spea=
k:normal;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0%/auto re=
peat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,=
29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:=
0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4p=
x;quotes:auto;speak:normal;zoom:1;line-height:1.15">First known bad: v6.12<=
/p></li></ul><p style=3D"background:none 0% 0%/auto repeat scroll padding-b=
ox border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;column=
s:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px;opacity:1=
;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1=
;line-height:1.15">The regression has been bisected to the following two co=
mmits, as reverting them resolves the issue:</p><ul style=3D"background:non=
e 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px =
none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolati=
on:auto;margin:0px 0px 16px;opacity:1;outline:rgb(27,28,29) none 0px;paddin=
g:0px 0px 0px 27px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><li st=
yle=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba=
(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:l=
tr;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28=
,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-=
height:1.15"><p style=3D"background:none 0% 0%/auto repeat scroll padding-b=
ox border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;column=
s:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px;opacity:1=
;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:n=
ormal;zoom:1;line-height:1.15"><code style=3D"background:none 0% 0%/auto re=
peat scroll padding-box border-box rgb(233,238,246);border:0px none rgb(87,=
91,95);clear:none;color:rgb(87,91,95);columns:auto;direction:ltr;display:in=
line;float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(87,91,95) n=
one 0px;padding:1px 6px;quotes:auto;speak:normal;zoom:1;font-family:&quot;G=
oogle Sans Text&quot;,sans-serif;line-height:1.15">de84484c6f8b</code> (=E2=
=80=9Cdrm/amdkfd: Improve signal event slow path=E2=80=9D, 2024-12-19)</p><=
/li><li style=3D"background:none 0% 0%/auto repeat scroll padding-box borde=
r-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;d=
irection:ltr;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline=
:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zo=
om:1;line-height:1.15"><p style=3D"background:none 0% 0%/auto repeat scroll=
 padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:n=
one;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px=
;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:au=
to;speak:normal;zoom:1;line-height:1.15"><code style=3D"background:none 0% =
0%/auto repeat scroll padding-box border-box rgb(233,238,246);border:0px no=
ne rgb(87,91,95);clear:none;color:rgb(87,91,95);columns:auto;direction:ltr;=
display:inline;float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(8=
7,91,95) none 0px;padding:1px 6px;quotes:auto;speak:normal;zoom:1;font-fami=
ly:&quot;Google Sans Text&quot;,sans-serif;line-height:1.15">bac38ca057fe</=
code> (=E2=80=9Cdrm/amdkfd: implement per queue sdma reset =E2=80=A6=E2=80=
=9D, 2025-03-06)</p></li></ul><p style=3D"background:none 0% 0%/auto repeat=
 scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);=
clear:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px =
0px 16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;s=
peak:normal;zoom:1;line-height:1.15">Both patches touch <code style=3D"back=
ground:none 0% 0%/auto repeat scroll padding-box border-box rgb(233,238,246=
);border:0px none rgb(87,91,95);clear:none;color:rgb(87,91,95);columns:auto=
;direction:ltr;display:inline;float:none;isolation:auto;margin:0px;opacity:=
1;outline:rgb(87,91,95) none 0px;padding:1px 6px;quotes:auto;speak:normal;z=
oom:1;font-family:&quot;Google Sans Text&quot;,sans-serif;line-height:1.15"=
>amdkfd</code> queue reset paths and are first included in the exact releas=
es where the regression appears.</p><p style=3D"background:none 0% 0%/auto =
repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,2=
8,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;margi=
n:0px 0px 16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:=
auto;speak:normal;zoom:1;line-height:1.15">Here&#39;s a summary of kernel r=
esults:</p><p style=3D"padding-top:0px;padding-bottom:0px;line-height:1.15;=
margin-top:0px">Kernel | Result | Note</p><p style=3D"padding-top:0px;paddi=
ng-bottom:0px;line-height:1.15;margin-top:0px">------- | -------- | -------=
-</p><p style=3D"padding-top:0px;padding-bottom:0px;line-height:1.15;margin=
-top:0px">6.13.y (LTS) | OK |</p><p style=3D"padding-top:0px;padding-bottom=
:0px;line-height:1.15;margin-top:0px">6.14.0 | OK | Baseline - my last work=
ing kernel, though I am not exactly sure which subver</p><p style=3D"paddin=
g-top:0px;padding-bottom:0px;line-height:1.15;margin-top:0px">6.14.1-rc1 | =
BAD | First hang</p><p style=3D"padding-top:0px;padding-bottom:0px;line-hei=
ght:1.15;margin-top:0px">6.15-rc1 | BAD | Hang</p><p style=3D"padding-top:0=
px;padding-bottom:0px;line-height:1.15;margin-top:0px">6.15.8 | BAD | Hang<=
/p><p style=3D"padding-top:0px;padding-bottom:0px;line-height:1.15;margin-t=
op:0px">6.16-rc3 | BAD | Hang</p><p style=3D"padding-top:0px;padding-bottom=
:0px;line-height:1.15;margin-top:0px">6.16-rc3 =E2=80=93 revert de84484 + b=
ac38ca | OK | Full stability restored, ROCm workloads run for hours.</p><hr=
 style=3D"background:none 0% 0%/auto repeat scroll padding-box border-box r=
gba(0,0,0,0);clear:none;columns:auto;direction:ltr;float:none;isolation:aut=
o;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;q=
uotes:auto;speak:normal;zoom:1;line-height:1.15"><p style=3D"background:non=
e 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px =
none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolati=
on:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding=
:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15">Reproduction Steps</=
p><ol start=3D"1" style=3D"background:none 0% 0%/auto repeat scroll padding=
-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;colu=
mns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 16px;opacit=
y:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 28px;quotes:auto;spe=
ak:normal;zoom:1;line-height:1.15"><li style=3D"background:none 0% 0%/auto =
repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,2=
8,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;margi=
n:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px =
4px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><p style=3D"backgroun=
d:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border=
:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;is=
olation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;pa=
dding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15">Boo=
t the system with a kernel version exhibiting the issue (e.g., v6.14.1-rc1 =
or newer without the reverts).</p></li><li style=3D"background:none 0% 0%/a=
uto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(=
27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;m=
argin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px =
0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><p style=3D"backg=
round:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);bo=
rder:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:non=
e;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0p=
x;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15"=
>Run a ROCm workload that creates several compute queues, for example:</p><=
ul style=3D"background:none 0% 0%/auto repeat scroll padding-box border-box=
 rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direct=
ion:ltr;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(=
27,28,29) none 0px;padding:0px 0px 0px 27px;quotes:auto;speak:normal;zoom:1=
;line-height:1.15"><li style=3D"background:none 0% 0%/auto repeat scroll pa=
dding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none=
;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px;op=
acity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;=
speak:normal;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0%/aut=
o repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27=
,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;mar=
gin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0p=
x 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><code style=3D"back=
ground:none 0% 0%/auto repeat scroll padding-box border-box rgb(233,238,246=
);border:0px none rgb(87,91,95);clear:none;color:rgb(87,91,95);columns:auto=
;direction:ltr;display:inline;float:none;isolation:auto;margin:0px;opacity:=
1;outline:rgb(87,91,95) none 0px;padding:1px 6px;quotes:auto;speak:normal;z=
oom:1;font-family:&quot;Google Sans Text&quot;,sans-serif;line-height:1.15"=
>python stable-diffusion.py</code></p></li><li style=3D"background:none 0% =
0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none =
rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:au=
to;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px =
0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><p style=3D"b=
ackground:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0=
);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float=
:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) non=
e 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1=
.15"><code style=3D"background:none 0% 0%/auto repeat scroll padding-box bo=
rder-box rgb(233,238,246);border:0px none rgb(87,91,95);clear:none;color:rg=
b(87,91,95);columns:auto;direction:ltr;display:inline;float:none;isolation:=
auto;margin:0px;opacity:1;outline:rgb(87,91,95) none 0px;padding:1px 6px;qu=
otes:auto;speak:normal;zoom:1;font-family:&quot;Google Sans Text&quot;,sans=
-serif;line-height:1.15">faster-whisper --model medium ...</code></p></li><=
/ul></li><li style=3D"background:none 0% 0%/auto repeat scroll padding-box =
border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:a=
uto;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;ou=
tline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:norm=
al;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0%/auto repeat s=
croll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);cl=
ear:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0p=
x 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quot=
es:auto;speak:normal;zoom:1;line-height:1.15">Upon model initialization, an=
 immediate driver crash occurs. This is visible on the host machine via dme=
sg logs.</p></li></ol><p style=3D"background:none 0% 0%/auto repeat scroll =
padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:no=
ne;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 16px=
;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:nor=
mal;zoom:1;line-height:1.15">Observed Error Messages (dmesg):</p><span clas=
s=3D"gmail-" style=3D"background:none 0% 0%/auto repeat scroll padding-box =
border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:a=
uto;direction:ltr;display:inline;float:none;isolation:auto;margin:0px;opaci=
ty:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zo=
om:1;line-height:1.15"><span class=3D"gmail-ng-tns-c297625106-359 gmail-ng-=
star-inserted" style=3D"background:none 0% 0%/auto repeat scroll padding-bo=
x border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns=
:auto;direction:ltr;display:inline;float:none;isolation:auto;margin:0px;opa=
city:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;=
zoom:1;line-height:1.15"><div class=3D"gmail-code-block gmail-ng-tns-c29762=
5106-359 gmail-ng-animate-disabled gmail-ng-trigger gmail-ng-trigger-codeBl=
ockRevealAnimation" style=3D"background:none 0% 0%/auto repeat scroll paddi=
ng-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;co=
lumns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 16px;opac=
ity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;z=
oom:1;line-height:1.15"><div class=3D"gmail-formatted-code-block-internal-c=
ontainer gmail-ng-tns-c297625106-359" style=3D"background:none 0% 0%/auto r=
epeat scroll padding-box border-box rgb(240,244,249);border:0px none rgb(27=
,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;mar=
gin:0px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;sp=
eak:normal;zoom:1;line-height:1.15"><div class=3D"gmail-animated-opacity gm=
ail-ng-tns-c297625106-359" style=3D"background:none 0% 0%/auto repeat scrol=
l padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:=
none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px;opacit=
y:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoo=
m:1;line-height:1.15"><pre class=3D"gmail-ng-tns-c297625106-359" style=3D"b=
ackground:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0=
);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float=
:none;isolation:auto;margin:0px;opacity:1;outline:rgb(27,28,29) none 0px;pa=
dding:0px;quotes:auto;speak:normal;zoom:1;font-family:&quot;Google Sans Tex=
t&quot;,sans-serif;line-height:1.15"><code role=3D"text" class=3D"gmail-cod=
e-container gmail-formatted gmail-ng-tns-c297625106-359 gmail-no-decoration=
-radius" style=3D"background:none 0% 0%/auto repeat scroll padding-box bord=
er-box rgba(0,0,0,0);border:0px none rgb(87,91,95);clear:none;color:rgb(87,=
91,95);columns:auto;direction:ltr;display:block;float:none;font-variant-num=
eric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;f=
ont-size-adjust:none;font-kerning:auto;font-feature-settings:normal;font-st=
retch:normal;font-size:14px;line-height:1.15;font-family:&quot;Google Sans =
Text&quot;,sans-serif;isolation:auto;margin:0px;opacity:1;outline:rgb(87,91=
,95) none 0px;padding:16px;quotes:auto;speak:normal;zoom:1">[drm] scheduler=
 comp_1.1.1 is not ready, skipping
[drm:sched_job_timedout] ERROR ring comp_1.1.1 timeout
[message continues ad-infinitum while system functions generally]</code></p=
re></div></div></div></span></span><p style=3D"background:none 0% 0%/auto r=
epeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28=
,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;margin=
:0px 0px 16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:a=
uto;speak:normal;zoom:1;line-height:1.15">This is followed by a hard GPU re=
set (visible in logs, no visual artifacts), which reliably leads to a full =
system lockup. Python or Docker processes become unkillable, requiring a ma=
nual reboot. Over time, the desktop slowly loses interactivity.</p><hr styl=
e=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0=
,0,0,0);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;mar=
gin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes=
:auto;speak:normal;zoom:1;line-height:1.15"><p style=3D"background:none 0% =
0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none =
rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:au=
to;margin:0px 0px 16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px=
;quotes:auto;speak:normal;zoom:1;line-height:1.15">Bisect Details</p><p sty=
le=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(=
0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:lt=
r;float:none;isolation:auto;margin:0px 0px 16px;opacity:1;outline:rgb(27,28=
,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15"=
>I previously attempted a <code style=3D"background:none 0% 0%/auto repeat =
scroll padding-box border-box rgb(233,238,246);border:0px none rgb(87,91,95=
);clear:none;color:rgb(87,91,95);columns:auto;direction:ltr;display:inline;=
float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(87,91,95) none 0=
px;padding:1px 6px;quotes:auto;speak:normal;zoom:1;font-family:&quot;Google=
 Sans Text&quot;,sans-serif;line-height:1.15">git bisect</code> (limited to=
 <code style=3D"background:none 0% 0%/auto repeat scroll padding-box border=
-box rgb(233,238,246);border:0px none rgb(87,91,95);clear:none;color:rgb(87=
,91,95);columns:auto;direction:ltr;display:inline;float:none;isolation:auto=
;margin:0px;opacity:1;outline:rgb(87,91,95) none 0px;padding:1px 6px;quotes=
:auto;speak:normal;zoom:1;font-family:&quot;Google Sans Text&quot;,sans-ser=
if;line-height:1.15">drivers/gpu/drm/amd</code>) between <code style=3D"bac=
kground:none 0% 0%/auto repeat scroll padding-box border-box rgb(233,238,24=
6);border:0px none rgb(87,91,95);clear:none;color:rgb(87,91,95);columns:aut=
o;direction:ltr;display:inline;float:none;isolation:auto;margin:0px;opacity=
:1;outline:rgb(87,91,95) none 0px;padding:1px 6px;quotes:auto;speak:normal;=
zoom:1;font-family:&quot;Google Sans Text&quot;,sans-serif;line-height:1.15=
">v6.12</code> and <code style=3D"background:none 0% 0%/auto repeat scroll =
padding-box border-box rgb(233,238,246);border:0px none rgb(87,91,95);clear=
:none;color:rgb(87,91,95);columns:auto;direction:ltr;display:inline;float:n=
one;isolation:auto;margin:0px;opacity:1;outline:rgb(87,91,95) none 0px;padd=
ing:1px 6px;quotes:auto;speak:normal;zoom:1;font-family:&quot;Google Sans T=
ext&quot;,sans-serif;line-height:1.15">v6.15-rc1</code>, which identified s=
ome further potentially problematic commits, however due to undersized /boo=
t/ partition was experiencing some difficulties. In the interim,<a href=3D"=
https://github.com/robertrosenbusch/gfx803_rocm/issues/35#issuecomment-2996=
884779"> it seems a user on </a>=C2=A0the gfx803 compatibilty repo discover=
ed the below regarding ROC 5.7:</p><span class=3D"gmail-" style=3D"backgrou=
nd:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);borde=
r:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;display:inli=
ne;float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(27,28,29) non=
e 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><span c=
lass=3D"gmail-ng-tns-c297625106-360 gmail-ng-star-inserted" style=3D"backgr=
ound:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);bor=
der:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;display:in=
line;float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(27,28,29) n=
one 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><div =
class=3D"gmail-code-block gmail-ng-tns-c297625106-360 gmail-ng-animate-disa=
bled gmail-ng-trigger gmail-ng-trigger-codeBlockRevealAnimation" style=3D"b=
ackground:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0=
);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float=
:none;isolation:auto;margin:0px 0px 16px;opacity:1;outline:rgb(27,28,29) no=
ne 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><div c=
lass=3D"gmail-formatted-code-block-internal-container gmail-ng-tns-c2976251=
06-360" style=3D"background:none 0% 0%/auto repeat scroll padding-box borde=
r-box rgb(240,244,249);border:0px none rgb(27,28,29);clear:none;columns:aut=
o;direction:ltr;float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(=
27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:=
1.15"><div class=3D"gmail-animated-opacity gmail-ng-tns-c297625106-360" sty=
le=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(=
0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:lt=
r;float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(27,28,29) none=
 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><pre cla=
ss=3D"gmail-ng-tns-c297625106-360" style=3D"background:none 0% 0%/auto repe=
at scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29=
);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0p=
x;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:no=
rmal;zoom:1;font-family:&quot;Google Sans Text&quot;,sans-serif;line-height=
:1.15"><code role=3D"text" class=3D"gmail-code-container gmail-formatted gm=
ail-ng-tns-c297625106-360 gmail-no-decoration-radius" style=3D"background:n=
one 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0p=
x none rgb(87,91,95);clear:none;color:rgb(87,91,95);columns:auto;direction:=
ltr;display:block;float:none;font-variant-numeric:normal;font-variant-east-=
asian:normal;font-variant-alternates:normal;font-size-adjust:none;font-kern=
ing:auto;font-feature-settings:normal;font-stretch:normal;font-size:14px;li=
ne-height:1.15;font-family:&quot;Google Sans Text&quot;,sans-serif;isolatio=
n:auto;margin:0px;opacity:1;outline:rgb(87,91,95) none 0px;padding:16px;quo=
tes:auto;speak:normal;zoom:1">de84484c6f8b07ad0850d6c4  bad
bac38ca057fef2c8c024fe9e  bad
</code></pre></div></div></div></span></span><p style=3D"background:none 0%=
 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none=
 rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:a=
uto;margin:0px 0px 16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0p=
x;quotes:auto;speak:normal;zoom:1;line-height:1.15">Cherry-picking reverts =
of both commits on top of <code style=3D"background:none 0% 0%/auto repeat =
scroll padding-box border-box rgb(233,238,246);border:0px none rgb(87,91,95=
);clear:none;color:rgb(87,91,95);columns:auto;direction:ltr;display:inline;=
float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(87,91,95) none 0=
px;padding:1px 6px;quotes:auto;speak:normal;zoom:1;font-family:&quot;Google=
 Sans Text&quot;,sans-serif;line-height:1.15">v6.16-rc3</code> restores nor=
mal behavior; leaving either patch in place reproduces the hang.</p><hr sty=
le=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(=
0,0,0,0);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;ma=
rgin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quote=
s:auto;speak:normal;zoom:1;line-height:1.15"><p style=3D"background:none 0%=
 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none=
 rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:a=
uto;margin:0px 0px 16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0p=
x;quotes:auto;speak:normal;zoom:1;line-height:1.15">Relevant Log Excerpts</=
p><p style=3D"background:none 0% 0%/auto repeat scroll padding-box border-b=
ox rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;dire=
ction:ltr;float:none;isolation:auto;margin:0px 0px 16px;opacity:1;outline:r=
gb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-heig=
ht:1.15">(Full dmesg logs can be attached separately if needed)</p><span cl=
ass=3D"gmail-" style=3D"background:none 0% 0%/auto repeat scroll padding-bo=
x border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns=
:auto;direction:ltr;display:inline;float:none;isolation:auto;margin:0px;opa=
city:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;=
zoom:1;line-height:1.15"><span class=3D"gmail-ng-tns-c297625106-361 gmail-n=
g-star-inserted" style=3D"background:none 0% 0%/auto repeat scroll padding-=
box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;colum=
ns:auto;direction:ltr;display:inline;float:none;isolation:auto;margin:0px;o=
pacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:norma=
l;zoom:1;line-height:1.15"><div class=3D"gmail-code-block gmail-ng-tns-c297=
625106-361 gmail-ng-animate-disabled gmail-ng-trigger gmail-ng-trigger-code=
BlockRevealAnimation" style=3D"background:none 0% 0%/auto repeat scroll pad=
ding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;=
columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 16px;op=
acity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal=
;zoom:1;line-height:1.15"><div class=3D"gmail-formatted-code-block-internal=
-container gmail-ng-tns-c297625106-361" style=3D"background:none 0% 0%/auto=
 repeat scroll padding-box border-box rgb(240,244,249);border:0px none rgb(=
27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;m=
argin:0px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;=
speak:normal;zoom:1;line-height:1.15"><div class=3D"gmail-animated-opacity =
gmail-ng-tns-c297625106-361" style=3D"background:none 0% 0%/auto repeat scr=
oll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clea=
r:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px;opac=
ity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;z=
oom:1;line-height:1.15"><pre class=3D"gmail-ng-tns-c297625106-361" style=3D=
"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0=
,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;flo=
at:none;isolation:auto;margin:0px;opacity:1;outline:rgb(27,28,29) none 0px;=
padding:0px;quotes:auto;speak:normal;zoom:1;font-family:&quot;Google Sans T=
ext&quot;,sans-serif;line-height:1.15"><code role=3D"text" class=3D"gmail-c=
ode-container gmail-formatted gmail-ng-tns-c297625106-361 gmail-no-decorati=
on-radius" style=3D"background:none 0% 0%/auto repeat scroll padding-box bo=
rder-box rgba(0,0,0,0);border:0px none rgb(87,91,95);clear:none;color:rgb(8=
7,91,95);columns:auto;direction:ltr;display:block;float:none;font-variant-n=
umeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal=
;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;font-=
stretch:normal;font-size:14px;line-height:1.15;font-family:&quot;Google San=
s Text&quot;,sans-serif;isolation:auto;margin:0px;opacity:1;outline:rgb(87,=
91,95) none 0px;padding:16px;quotes:auto;speak:normal;zoom:1">[drm] schedul=
er comp_1.1.1 is not ready, skipping
[ 97.602622] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 timeout, signaled=
 seq=3D123456 emitted seq=3D123459
[ 97.602630] amdgpu 0000:08:00.0: amdgpu: GPU recover succeeded, reset doma=
in time =3D 2ms
</code></pre></div></div></div></span></span><hr style=3D"background:none 0=
% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);clear:none;col=
umns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px;opacit=
y:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoo=
m:1;line-height:1.15"><div class=3D"gmail-markdown gmail-markdown-main-pane=
l gmail-stronger enable-updated-hr-color" id=3D"gmail-model-response-messag=
e-contentr_40d09fe278a38573" dir=3D"ltr" style=3D"background:none 0% 0%/aut=
o repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27=
,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;mar=
gin:0px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;sp=
eak:normal;zoom:1;line-height:1.15"><span style=3D"background-color:rgba(0,=
0,0,0)">References:</span><br style=3D"background-color:rgba(0,0,0,0)"><br =
style=3D"background-color:rgba(0,0,0,0)"><ul style=3D"background:none 0% 0%=
/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rg=
b(27,28,29);clear:none;columns:auto;float:none;isolation:auto;margin:0px 0p=
x 16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 27px;qu=
otes:auto;speak:normal;zoom:1;line-height:1.15"><li style=3D"background:non=
e 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px =
none rgb(27,28,29);clear:none;columns:auto;float:none;isolation:auto;margin=
:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4=
px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><p style=3D"background=
:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:=
0px none rgb(27,28,29);clear:none;columns:auto;float:none;isolation:auto;ma=
rgin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0=
px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15">It&#39;s back: Log=
 spam: [drm] scheduler comp_1.0.2 is not ready, skipping ... (<span class=
=3D"gmail-" style=3D"background:none 0% 0%/auto repeat scroll padding-box b=
order-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:au=
to;direction:ltr;display:inline;float:none;isolation:auto;margin:0px;opacit=
y:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoo=
m:1;line-height:1.15"><span class=3D"gmail-ng-star-inserted" style=3D"backg=
round:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);bo=
rder:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;display:i=
nline;float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(27,28,29) =
none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><a t=
arget=3D"_blank" rel=3D"noopener" href=3D"https://bbs.archlinux.org/viewtop=
ic.php?id=3D302729" class=3D"gmail-ng-star-inserted" style=3D"background:no=
ne 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px=
 none rgb(11,87,208);clear:none;color:rgb(11,87,208);columns:auto;direction=
:ltr;display:inline;float:none;isolation:auto;margin:0px;opacity:1;outline:=
rgb(11,87,208) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-he=
ight:1.15">https://bbs.archlinux.org/viewtopic.php?id=3D302729</a></span></=
span>)</p></li><li style=3D"background:none 0% 0%/auto repeat scroll paddin=
g-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;col=
umns:auto;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rg=
b(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:=
1;line-height:1.15"><p style=3D"background:none 0% 0%/auto repeat scroll pa=
dding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none=
;columns:auto;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outlin=
e:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;z=
oom:1;line-height:1.15">Observations about HSA and KFD backends in TinyGrad=
 =C2=B7 GitHub (<span class=3D"gmail-" style=3D"background:none 0% 0%/auto =
repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,2=
8,29);clear:none;columns:auto;direction:ltr;display:inline;float:none;isola=
tion:auto;margin:0px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;q=
uotes:auto;speak:normal;zoom:1;line-height:1.15"><span class=3D"gmail-ng-st=
ar-inserted" style=3D"background:none 0% 0%/auto repeat scroll padding-box =
border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:a=
uto;direction:ltr;display:inline;float:none;isolation:auto;margin:0px;opaci=
ty:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zo=
om:1;line-height:1.15"><a target=3D"_blank" rel=3D"noopener" href=3D"https:=
//gist.github.com/fxkamd/ffd02d66a2863e444ec208ea4f3adc48" class=3D"gmail-n=
g-star-inserted" style=3D"background:none 0% 0%/auto repeat scroll padding-=
box border-box rgba(0,0,0,0);border:0px none rgb(11,87,208);clear:none;colo=
r:rgb(11,87,208);columns:auto;direction:ltr;display:inline;float:none;isola=
tion:auto;margin:0px;opacity:1;outline:rgb(11,87,208) none 0px;padding:0px;=
quotes:auto;speak:normal;zoom:1;line-height:1.15">https://gist.github.com/f=
xkamd/ffd02d66a2863e444ec208ea4f3adc48</a></span></span>)</p></li><li style=
=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,=
0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;float:none;iso=
lation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;pad=
ding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><p s=
tyle=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgb=
a(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;float:none=
;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px=
;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15">=
AMD RX580 system freeze on maximum VRAM speed (<span class=3D"gmail-" style=
=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,=
0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;=
display:inline;float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(2=
7,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1=
.15"><span class=3D"gmail-ng-star-inserted" style=3D"background:none 0% 0%/=
auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb=
(27,28,29);clear:none;columns:auto;direction:ltr;display:inline;float:none;=
isolation:auto;margin:0px;opacity:1;outline:rgb(27,28,29) none 0px;padding:=
0px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><a target=3D"_blank" =
rel=3D"noopener" href=3D"https://discussion.fedoraproject.org/t/amd-rx580-s=
ystem-freeze-on-maximum-vram-speed/136639" class=3D"gmail-ng-star-inserted"=
 style=3D"background:none 0% 0%/auto repeat scroll padding-box border-box r=
gba(0,0,0,0);border:0px none rgb(11,87,208);clear:none;color:rgb(11,87,208)=
;columns:auto;direction:ltr;display:inline;float:none;isolation:auto;margin=
:0px;opacity:1;outline:rgb(11,87,208) none 0px;padding:0px;quotes:auto;spea=
k:normal;zoom:1;line-height:1.15">https://discussion.fedoraproject.org/t/am=
d-rx580-system-freeze-on-maximum-vram-speed/136639</a></span></span>)</p></=
li><li style=3D"background:none 0% 0%/auto repeat scroll padding-box border=
-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;fl=
oat:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) =
none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-heigh=
t:1.15"><p style=3D"background:none 0% 0%/auto repeat scroll padding-box bo=
rder-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:aut=
o;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,=
29) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-h=
eight:1.15">LKML: Linus Torvalds: Re: [git pull] drm fixes for 6.15-rc1 (<s=
pan class=3D"gmail-" style=3D"background:none 0% 0%/auto repeat scroll padd=
ing-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;c=
olumns:auto;direction:ltr;display:inline;float:none;isolation:auto;margin:0=
px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:n=
ormal;zoom:1;line-height:1.15"><span class=3D"gmail-ng-star-inserted" style=
=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,=
0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;=
display:inline;float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(2=
7,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1=
.15"><a target=3D"_blank" rel=3D"noopener" href=3D"https://www.google.com/s=
earch?q=3Dhttps://lkml.org/lkml/2025/4/5/394" class=3D"gmail-ng-star-insert=
ed" style=3D"background:none 0% 0%/auto repeat scroll padding-box border-bo=
x rgba(0,0,0,0);border:0px none rgb(11,87,208);clear:none;color:rgb(11,87,2=
08);columns:auto;direction:ltr;display:inline;float:none;isolation:auto;mar=
gin:0px;opacity:1;outline:rgb(11,87,208) none 0px;padding:0px;quotes:auto;s=
peak:normal;zoom:1;line-height:1.15">https://lkml.org/lkml/2025/4/5/394</a>=
</span></span>)</p></li><li style=3D"background:none 0% 0%/auto repeat scro=
ll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear=
:none;columns:auto;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;o=
utline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:nor=
mal;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0%/auto repeat =
scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);c=
lear:none;columns:auto;float:none;isolation:auto;margin:0px 0px 8px;opacity=
:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak=
:normal;zoom:1;line-height:1.15">Commits =C2=B7 torvalds/linux - GitHub (Li=
nk for commit de84484) (<span class=3D"gmail-" style=3D"background:none 0% =
0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none =
rgb(27,28,29);clear:none;columns:auto;direction:ltr;display:inline;float:no=
ne;isolation:auto;margin:0px;opacity:1;outline:rgb(27,28,29) none 0px;paddi=
ng:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><span class=3D"gma=
il-ng-star-inserted" style=3D"background:none 0% 0%/auto repeat scroll padd=
ing-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;c=
olumns:auto;direction:ltr;display:inline;float:none;isolation:auto;margin:0=
px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:n=
ormal;zoom:1;line-height:1.15"><a target=3D"_blank" rel=3D"noopener" href=
=3D"https://www.google.com/search?q=3Dhttps://github.com/torvalds/linux/com=
mits%3Fbefore%3D805ba04cb7ccfc7d72e834ebd796e043142156ba%2B6335" class=3D"g=
mail-ng-star-inserted" style=3D"background:none 0% 0%/auto repeat scroll pa=
dding-box border-box rgba(0,0,0,0);border:0px none rgb(11,87,208);clear:non=
e;color:rgb(11,87,208);columns:auto;direction:ltr;display:inline;float:none=
;isolation:auto;margin:0px;opacity:1;outline:rgb(11,87,208) none 0px;paddin=
g:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15">https://github.com/=
torvalds/linux/commits?before=3D805ba04cb7ccfc7d72e834ebd796e043142156ba+63=
35</a></span></span>)</p></li><li style=3D"background:none 0% 0%/auto repea=
t scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29)=
;clear:none;columns:auto;float:none;isolation:auto;margin:0px 0px 8px;opaci=
ty:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto;spe=
ak:normal;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0%/auto r=
epeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28=
,29);clear:none;columns:auto;float:none;isolation:auto;margin:0px 0px 8px;o=
pacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:auto=
;speak:normal;zoom:1;line-height:1.15">Commits =C2=B7 torvalds/linux - GitH=
ub (Link for commit bac38ca) (<span class=3D"gmail-" style=3D"background:no=
ne 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px=
 none rgb(27,28,29);clear:none;columns:auto;direction:ltr;display:inline;fl=
oat:none;isolation:auto;margin:0px;opacity:1;outline:rgb(27,28,29) none 0px=
;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><span class=
=3D"gmail-ng-star-inserted" style=3D"background:none 0% 0%/auto repeat scro=
ll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear=
:none;columns:auto;direction:ltr;display:inline;float:none;isolation:auto;m=
argin:0px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;=
speak:normal;zoom:1;line-height:1.15"><a target=3D"_blank" rel=3D"noopener"=
 href=3D"https://www.google.com/search?q=3Dhttps://github.com/torvalds/linu=
x/commits%3Fbefore%3D5bc1018675ec28a8a60d83b378d8c3991faa5a27%2B7980" class=
=3D"gmail-ng-star-inserted" style=3D"background:none 0% 0%/auto repeat scro=
ll padding-box border-box rgba(0,0,0,0);border:0px none rgb(11,87,208);clea=
r:none;color:rgb(11,87,208);columns:auto;direction:ltr;display:inline;float=
:none;isolation:auto;margin:0px;opacity:1;outline:rgb(11,87,208) none 0px;p=
adding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15">https://github=
.com/torvalds/linux/commits?before=3D5bc1018675ec28a8a60d83b378d8c3991faa5a=
27+7980</a></span></span>)</p></li><li style=3D"background:none 0% 0%/auto =
repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,2=
8,29);clear:none;columns:auto;float:none;isolation:auto;margin:0px 0px 8px;=
opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes:aut=
o;speak:normal;zoom:1;line-height:1.15"><p style=3D"background:none 0% 0%/a=
uto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(=
27,28,29);clear:none;columns:auto;float:none;isolation:auto;margin:0px 0px =
8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px;quotes=
:auto;speak:normal;zoom:1;line-height:1.15">ROCm-For-RX580/README.md at mai=
n - GitHub (<span class=3D"gmail-" style=3D"background:none 0% 0%/auto repe=
at scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29=
);clear:none;columns:auto;direction:ltr;display:inline;float:none;isolation=
:auto;margin:0px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quote=
s:auto;speak:normal;zoom:1;line-height:1.15"><span class=3D"gmail-ng-star-i=
nserted" style=3D"background:none 0% 0%/auto repeat scroll padding-box bord=
er-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;=
direction:ltr;display:inline;float:none;isolation:auto;margin:0px;opacity:1=
;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1=
;line-height:1.15"><a target=3D"_blank" rel=3D"noopener" href=3D"https://gi=
thub.com/woodrex83/ROCm-For-RX580/blob/main/README.md" class=3D"gmail-ng-st=
ar-inserted" style=3D"background:none 0% 0%/auto repeat scroll padding-box =
border-box rgba(0,0,0,0);border:0px none rgb(11,87,208);clear:none;color:rg=
b(11,87,208);columns:auto;direction:ltr;display:inline;float:none;isolation=
:auto;margin:0px;opacity:1;outline:rgb(11,87,208) none 0px;padding:0px;quot=
es:auto;speak:normal;zoom:1;line-height:1.15">https://github.com/woodrex83/=
ROCm-For-RX580/blob/main/README.md</a></span></span>)</p></li><li style=3D"=
background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,=
0);border:0px none rgb(27,28,29);clear:none;columns:auto;float:none;isolati=
on:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding=
:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><p style=
=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,=
0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;float:none;iso=
lation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;pad=
ding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><spa=
n style=3D"background-color:rgba(0,0,0,0)">ROCm 4.6.0 for gfx803 - GitHub (=
</span><span class=3D"gmail-" style=3D"background:none 0% 0%/auto repeat sc=
roll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);cle=
ar:none;columns:auto;direction:ltr;display:inline;float:none;isolation:auto=
;margin:0px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:aut=
o;speak:normal;zoom:1;line-height:1.15"><span class=3D"gmail-ng-star-insert=
ed" style=3D"background:none 0% 0%/auto repeat scroll padding-box border-bo=
x rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direc=
tion:ltr;display:inline;float:none;isolation:auto;margin:0px;opacity:1;outl=
ine:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line=
-height:1.15"><a target=3D"_blank" rel=3D"noopener" href=3D"https://github.=
com/robertrosenbusch/gfx803_rocm/issues/35#issuecomment-2996884779" class=
=3D"gmail-ng-star-inserted" style=3D"color:rgb(11,87,208);background:none 0=
% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px non=
e rgb(11,87,208);clear:none;columns:auto;direction:ltr;display:inline;float=
:none;isolation:auto;margin:0px;opacity:1;outline:rgb(11,87,208) none 0px;p=
adding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15">https://github=
.com/robertrosenbusch/gfx803_rocm/issues/35#issuecomment-2996884779</a></sp=
an></span><span style=3D"background-color:rgba(0,0,0,0)">)</span></p></li><=
li style=3D"background:none 0% 0%/auto repeat scroll padding-box border-box=
 rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;float:=
none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none=
 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.=
15"><p style=3D"background:none 0% 0%/auto repeat scroll padding-box border=
-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;fl=
oat:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) =
none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-heigh=
t:1.15">Compatibility matrices =E2=80=94 Use ROCm on Radeon GPUs - AMD (<sp=
an class=3D"gmail-" style=3D"background:none 0% 0%/auto repeat scroll paddi=
ng-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;co=
lumns:auto;direction:ltr;display:inline;float:none;isolation:auto;margin:0p=
x;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:no=
rmal;zoom:1;line-height:1.15"><span class=3D"gmail-ng-star-inserted" style=
=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,=
0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;=
display:inline;float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(2=
7,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1=
.15"><a target=3D"_blank" rel=3D"noopener" href=3D"https://rocm.docs.amd.co=
m/projects/radeon/en/latest/docs/compatibility.html" class=3D"gmail-ng-star=
-inserted" style=3D"background:none 0% 0%/auto repeat scroll padding-box bo=
rder-box rgba(0,0,0,0);border:0px none rgb(11,87,208);clear:none;color:rgb(=
11,87,208);columns:auto;direction:ltr;display:inline;float:none;isolation:a=
uto;margin:0px;opacity:1;outline:rgb(11,87,208) none 0px;padding:0px;quotes=
:auto;speak:normal;zoom:1;line-height:1.15">https://rocm.docs.amd.com/proje=
cts/radeon/en/latest/docs/compatibility.html</a></span></span>)</p></li></u=
l></div><p style=3D"background:none 0% 0%/auto repeat scroll padding-box bo=
rder-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:aut=
o;direction:ltr;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outl=
ine:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line=
-height:1.15"><br></p><hr style=3D"background:none 0% 0%/auto repeat scroll=
 padding-box border-box rgba(0,0,0,0);clear:none;columns:auto;direction:ltr=
;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,2=
9) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><=
p style=3D"background:none 0% 0%/auto repeat scroll padding-box border-box =
rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;directi=
on:ltr;float:none;isolation:auto;margin:0px 0px 16px;opacity:1;outline:rgb(=
27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:=
1.15">Why this matters</p><p style=3D"background:none 0% 0%/auto repeat scr=
oll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clea=
r:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px =
16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak=
:normal;zoom:1;line-height:1.15">Although gfx803 is End-of-Life (EOL) for o=
fficial ROCm support, large user communities (Stable-Diffusion, Whisper, Ti=
nygrad) still depend on it. Community builds (e.g., <span class=3D"gmail-" =
style=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rg=
ba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction=
:ltr;display:inline;float:none;isolation:auto;margin:0px;opacity:1;outline:=
rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-hei=
ght:1.15"><span class=3D"gmail-ng-star-inserted" style=3D"background:none 0=
% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px non=
e rgb(27,28,29);clear:none;columns:auto;direction:ltr;display:inline;float:=
none;isolation:auto;margin:0px;opacity:1;outline:rgb(27,28,29) none 0px;pad=
ding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><a target=3D"_bl=
ank" rel=3D"noopener" href=3D"https://github.com/robertrosenbusch/gfx803_ro=
cm/" class=3D"gmail-ng-star-inserted" style=3D"background:none 0% 0%/auto r=
epeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(11,87=
,208);clear:none;color:rgb(11,87,208);columns:auto;direction:ltr;display:in=
line;float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(11,87,208) =
none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15">gith=
ub.com/robertrosenbusch/gfx803_rocm/</a></span></span>) demonstrate that RO=
Cm 6.4+ and RX-580 are fully functional on a number of relatively recent ke=
rnels. This regression significantly impacts the usability of these cards f=
or compute workloads.</p><hr style=3D"background:none 0% 0%/auto repeat scr=
oll padding-box border-box rgba(0,0,0,0);clear:none;columns:auto;direction:=
ltr;float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,2=
8,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15=
"><p style=3D"background:none 0% 0%/auto repeat scroll padding-box border-b=
ox rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;dire=
ction:ltr;float:none;isolation:auto;margin:0px 0px 16px;opacity:1;outline:r=
gb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-heig=
ht:1.15">Proposed Next Steps</p><p style=3D"background:none 0% 0%/auto repe=
at scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29=
);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0p=
x 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;=
speak:normal;zoom:1;line-height:1.15">I suggest the following for further i=
nvestigation:</p><ul style=3D"background:none 0% 0%/auto repeat scroll padd=
ing-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;c=
olumns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 16px;opa=
city:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 27px;quotes:auto;=
speak:normal;zoom:1;line-height:1.15"><li style=3D"background:none 0% 0%/au=
to repeat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(2=
7,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;ma=
rgin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0=
px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><p style=3D"backgr=
ound:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);bor=
der:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none=
;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px=
;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15">=
Review the interaction between the new KFD signal-event slow-path and legac=
y GPUs that may lack valid event IDs.</p></li><li style=3D"background:none =
0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px no=
ne rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation=
:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0=
px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15"><p style=
=3D"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,=
0,0,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;=
float:none;isolation:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29=
) none 0px;padding:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-hei=
ght:1.15">Confirm whether <code style=3D"background:none 0% 0%/auto repeat =
scroll padding-box border-box rgb(233,238,246);border:0px none rgb(87,91,95=
);clear:none;color:rgb(87,91,95);columns:auto;direction:ltr;display:inline;=
float:none;isolation:auto;margin:0px;opacity:1;outline:rgb(87,91,95) none 0=
px;padding:1px 6px;quotes:auto;speak:normal;zoom:1;font-family:&quot;Google=
 Sans Text&quot;,sans-serif;line-height:1.15">hqd_sdma_get_doorbell()</code=
> logic (added in bac38ca) returns stale doorbells on gfx803, potentially c=
ausing false positives.</p></li><li style=3D"background:none 0% 0%/auto rep=
eat scroll padding-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,2=
9);clear:none;columns:auto;direction:ltr;float:none;isolation:auto;margin:0=
px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;padding:0px 0px 0px 4px=
;quotes:auto;speak:normal;zoom:1;line-height:1.15"><p style=3D"background:n=
one 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0p=
x none rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isola=
tion:auto;margin:0px 0px 8px;opacity:1;outline:rgb(27,28,29) none 0px;paddi=
ng:0px 0px 0px 4px;quotes:auto;speak:normal;zoom:1;line-height:1.15">Consid=
er back-outs for <code style=3D"background:none 0% 0%/auto repeat scroll pa=
dding-box border-box rgb(233,238,246);border:0px none rgb(87,91,95);clear:n=
one;color:rgb(87,91,95);columns:auto;direction:ltr;display:inline;float:non=
e;isolation:auto;margin:0px;opacity:1;outline:rgb(87,91,95) none 0px;paddin=
g:1px 6px;quotes:auto;speak:normal;zoom:1;font-family:&quot;Google Sans Tex=
t&quot;,sans-serif;line-height:1.15">6.15-stable</code> / <code style=3D"ba=
ckground:none 0% 0%/auto repeat scroll padding-box border-box rgb(233,238,2=
46);border:0px none rgb(87,91,95);clear:none;color:rgb(87,91,95);columns:au=
to;direction:ltr;display:inline;float:none;isolation:auto;margin:0px;opacit=
y:1;outline:rgb(87,91,95) none 0px;padding:1px 6px;quotes:auto;speak:normal=
;zoom:1;font-family:&quot;Google Sans Text&quot;,sans-serif;line-height:1.1=
5">6.16-rc</code> while a proper fix is developed.</p></li></ul><p style=3D=
"background:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0=
,0);border:0px none rgb(27,28,29);clear:none;columns:auto;direction:ltr;flo=
at:none;isolation:auto;margin:0px 0px 16px;opacity:1;outline:rgb(27,28,29) =
none 0px;padding:0px;quotes:auto;speak:normal;zoom:1;line-height:1.15">Plea=
se let me know if you require any further diagnostics or testing. I can eas=
ily rebuild kernels and provide annotated traces.<br><br>Please find my wor=
king document:=C2=A0<a href=3D"https://chatgpt.com/share/6854bef2-c69c-8002=
-a243-a06c67a2c066">https://chatgpt.com/share/6854bef2-c69c-8002-a243-a06c6=
7a2c066</a></p><p style=3D"background:none 0% 0%/auto repeat scroll padding=
-box border-box rgba(0,0,0,0);border:0px none rgb(27,28,29);clear:none;colu=
mns:auto;direction:ltr;float:none;isolation:auto;margin:0px 0px 16px;opacit=
y:1;outline:rgb(27,28,29) none 0px;padding:0px;quotes:auto;speak:normal;zoo=
m:1;line-height:1.15">Thanks for your time!</p><p style=3D"background:none =
0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0);border:0px no=
ne rgb(27,28,29);clear:none;columns:auto;direction:ltr;float:none;isolation=
:auto;margin:0px 0px 16px;opacity:1;outline:rgb(27,28,29) none 0px;padding:=
0px;quotes:auto;speak:normal;zoom:1;line-height:1.15">Best regards, big lov=
e,</p><p style=3D"padding-top:0px;padding-bottom:0px;line-height:1.15;margi=
n-top:0px">Johl Brown</p><p style=3D"padding-top:0px;padding-bottom:0px;lin=
e-height:1.15;margin-top:0px"><a href=3D"mailto:johlbrown@gmail.com">johlbr=
own@gmail.com</a></p></div></div>

--00000000000010fd5a06385df2cb--
