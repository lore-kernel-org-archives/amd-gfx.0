Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7D7EDA6AB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 17:00:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1799810E87B;
	Tue,  3 Mar 2026 17:00:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lIOkp5bR";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4E510E08A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 14:26:24 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7d1872504cbso3167530a34.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2026 06:26:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772547984; cv=none;
 d=google.com; s=arc-20240605;
 b=k7xq1vJeh1e7m/RNH8hrrDUmQYF/l/JF2x56YGZ8U5+xSnmRhHd6w8sDRXXiH/rRXb
 KJYFCNOv07BMmO12MWhEhq/gqGHxaM3rwPHdyD7FPMB4wNepgCy2CpIbgjYmL091MEDA
 EI6O+S44mRGdOpQJ+13keYhw1c1668tgp+DvKYdapKVn1AYzOIz867fRFdJvuwB/e0G4
 MgFLNLUZcQDNcWzy2mvTMu6a1TOquC3jSfu6v7bxAG7Bjy/lbK+JK3hgWAZ3XFmz16Xt
 EBwLKHdywANVg/FOpPdjdJ5BZTLkEN1cpCIapogx7Q018SJ9S3eT+9KrH1lsjgD60VBM
 eYkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zjDQShb2cetjCLPrloiVWT5yoU/lEoVjrpV36OKktkA=;
 fh=hjoHnlzbJAd54qNnBJyoMoj1w6q0D+0tneoeKQ9fI9k=;
 b=Ps1be1XFADGpEOxznuFpt2k7zyxucZIkTSGH7HF1ntbF/w6VIYl87WpOd/WQ4fpv1m
 4BMq/AkzoyR2U6EvlRx6utBsMVthxhWWeIVff+iYuSi6wjEhXg+niTwuuDFCkSauQIPv
 OVgLzFa9XCqbKSSvH4zp5jdlUuWpTWGyCmQQ5ZKSXf4rFHFVs72EJGIfPxWgDAbnDIMc
 cnLsaLkpAGp2fb85X7pnmrStxWTUBpqCCKKMgjEr3IEktoil7tUw+YxLwDpBW96NOyXW
 5ibU9R9p9n5a2vXi+4NFgiX2cknPsg3q+Xb0sWiOQcQfD6PdnmQRozI2J3ETdOOM+u2r
 Qmcg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772547984; x=1773152784; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zjDQShb2cetjCLPrloiVWT5yoU/lEoVjrpV36OKktkA=;
 b=lIOkp5bRiygvmrvHDMnEZuHicBr5AjTfBPu164OJ7mp0vqVvYV/jHC3wDCzuxnlQei
 juNX8R+84wzTt3QXE3pmOBh3XUDhntm70AfTtRMlDQUvRZqcpjKjaPtQrePT8unFsS5b
 4IyJoJj+NtKO3ye+JHFYfPe5TuABNVdanrWNQEmxoJ9cIpp6cl4Z2xBckDMCBK2plUEG
 BUJtVuqBmRZl2aLCjdX/tN2fcPG0CaHCqkWuE6L17NeeToZ4FLD9Q4H7nUzQfddnmzFc
 Hr2ufPkktA3IRaifukXoXoUGzLQ1jRYnH7no1IsOro3YwDkFEnEF7Ng0cEufIczs9fLs
 aUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772547984; x=1773152784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjDQShb2cetjCLPrloiVWT5yoU/lEoVjrpV36OKktkA=;
 b=uldrVoJ5Jb7SCqQcBoIAGRgpg4XPWQ+0qm6Io/YwqFnJQtSQPIj+NUnKhqYTHTjqWU
 pBE0yFTD2dw6Ds8Ei9gmKK80Ay/J5pm99hKKc3IZcVLZR7O3aGTDbrS7s5c8/hglJtMU
 NPemUPmOSFZHxEviTOLGCLyXE6UrFNoBjhJeQXw3ivrEJ8sezjoDXFaxAfkBORx46Rux
 j3LXtWfh5sHtPwfqznRopYYk4aqQ+Hk49RHcTSYXuYIwuNozoynFRVvDuBAv1PPQ6inc
 a6HNuEKZB959+FEE0Xl+5LwFIZtLys2cHu9OvLCJQBx6HIDm7yE7jxgEQ6rXGVwlMpys
 KDww==
X-Gm-Message-State: AOJu0YyXCvSWxR25VsmAzkaaBVcTwhCglIrzXWaxQ72zFwQ6UkTUQWTw
 SHjP6NDVt0pBR7JWsW+noy4u/rgI+Rq7Aq3dvoJrFbf5/uQW1nKf+PvWlonpVqhi0zk07eHsSqy
 t6ee4FPnoSl6yoAUCSyRyCkPPyZMbT/Q=
X-Gm-Gg: ATEYQzykmvKu4vlttVfhsKvREpEEFM97R1l/1g0KohBMYmGkQSB2T3tCBGXg0wEMm0N
 V4wSrDtnvir2PCdB0m2taDlR7AcZcemGwE6ZmlK4D0yb7rjf8mISk1ms6JXonksKKoQh/MwQk+1
 FcwFFQ1CBB2qiB3J8yvqo6+sk1ifQy82fSq5ROu3RvjvR4KAQeFMBg6DUAB5Hp2doN0pYcIUqmq
 kePVXlevktBh+vGCY2nPXqR6Mkr/HtcAbf+b+Z+okdjlaxxKgzXZucOOKs0/AVU7g1ZpqIr+Nmp
 YqeSocF8CHcFMGLgmjO5l+ot+PVwbk78cFfSfA71
X-Received: by 2002:a05:6830:2992:b0:7d1:9066:26b7 with SMTP id
 46e09a7af769-7d5be394227mr1532481a34.6.1772547984067; Tue, 03 Mar 2026
 06:26:24 -0800 (PST)
MIME-Version: 1.0
References: <CPUPR80MB65833AEF510B7D067FCCA46DA370A@CPUPR80MB6583.lamprd80.prod.outlook.com>
In-Reply-To: <CPUPR80MB65833AEF510B7D067FCCA46DA370A@CPUPR80MB6583.lamprd80.prod.outlook.com>
From: Alex Huang <huangalex409@gmail.com>
Date: Tue, 3 Mar 2026 09:26:13 -0500
X-Gm-Features: AaiRm52zXomEfNTsPOWshMnrJHpOX58Ft4I0r1063LnbaBeXiIeelpv3sYCfeLE
Message-ID: <CAOnW2VTGBP=MMWM=W41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com>
Subject: Re: [Bug report] AMD Radeon R9 380 (Tonga) suspend resume regression:
 black screen / no EDID on kernel 6.13+ (ref: Ubuntu #2142389)
To: Danilo Machado <danilomachado2002@hotmail.com>
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev
Content-Type: multipart/alternative; boundary="000000000000f00f81064c1f7c33"
X-Mailman-Approved-At: Tue, 03 Mar 2026 17:00:33 +0000
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

--000000000000f00f81064c1f7c33
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
+cc amd-gfx
+cc regressions
-cc freedesktop

On Tue, Mar 3, 2026 at 7:30=E2=80=AFAM Danilo Machado <danilomachado2002@ho=
tmail.com>
wrote:

> To: freedesktop@lists.freedesktop.org
> Subject: [Bug report] AMD Radeon R9 380 (Tonga) suspend resume regression=
:
> black screen / no EDID on kernel 6.13+ (ref: Ubuntu #2142389)
>
> Dear AMDGPU/DRM maintainers,
>
> I'm reporting a suspend/resume regression affecting the Radeon R9 380
> (Tonga / GCN 3rd gen) on recent kernels (6.13+), observed on Ubuntu 24.10
> derivatives (Zorin OS 18) with kernel 6.17.0-14-generic.
>
A nontrivial amount of pm/EDID changes occurred between 6.12 and 6.13, are
you able to bisect the kernel between those two revisions? Even narrowing
it down to a release candidate should be useful.

#regzbot introduced: v5.12..v5.13
#regzbot from: Danilo Machado <danilomachado2002@hotmail.com>
#regzbot monitor:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389

Best,
Alex H

>
> **Hardware:**
> - GPU: AMD Radeon R9 380 Series (Tonga XT, Tonga)
> - Motherboard: Gigabyte B450 AORUS PRO WIFI (BIOS F66)
> - CPU: AMD Ryzen 5 5500
> - Connection: Direct HDMI
> - Display server: X11
> - Power state: Deep sleep (S3)
>
> **Symptoms:**
> - After suspend (first cycle often works; subsequent cycles fail
> consistently):
>   - System wakes (fans/LEDs active), but display shows black screen / no
> signal ("HDMI Out of Range" on monitor).
>   - EDID read/handshake fails =E2=86=92 no video output recovered.
>   - Keyboard/mouse may respond briefly, but desktop freezes =E2=86=92 har=
d reboot
> required.
> - Logs show:
>   [drm] *ERROR* HDMI-A-1: probed a monitor but no|invalid EDID
>   [drm] *ERROR* No EDID read.
>

> **Kernels tested:**
> - Broken: 6.13.12 =E2=86=92 6.17.0-14 (regression starts between 6.12 and=
 6.13)
> - Stable: 6.12.74 (LTS) =E2=80=93 suspend/resume fully reliable, no EDID =
errors
>
> **GRUB parameters used:**
> quiet splash amdgpu.si_support=3D1 radeon.si_support=3D0 amdgpu.runpm=3D0
> amdgpu.dc=3D0
>
> **Reference:**
> This matches Ubuntu bug #2142389:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389
> (Reported by me on Launchpad; includes full dmesg logs and attachments)
>
> The issue appears to be in the DRM/DC layer (HDMI EDID re-detection durin=
g
> multi-cycle suspend/resume on Tonga). Downgrading to 6.12.74 resolves it
> completely.
>
> Is this a known regression? Any patches or additional debug info needed
> from my side?
>
> Happy to test patches, provide more logs (dmesg, journalctl -b -u
> systemd-suspend, full amdgpu debug), or try kernel builds.
>
> Thanks for your attention and work on amdgpu!
>
>
> Tested kernels:
>
> 6.12.74 =E2=80=94 stable, HDMI resume works
> 6.13.12 =E2=80=94 first resume OK, second suspend fails
> 6.14.x =E2=80=94 HDMI issues
> 6.17.0-14 =E2=80=94 frequent resume black screen
>
> Best regards,
> Danilo Machado
> Minas Gerais, Brazil
> (Original reporter of Ubuntu bug #2142389)
>

--000000000000f00f81064c1f7c33
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>+cc amd-gfx</div><div>+cc regressions</=
div><div>-cc freedesktop</div><div></div><div dir=3D"ltr"><br></div><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Tue, Mar 3, 2026 at 7:30=E2=80=AFAM Danilo Machado &lt;<a href=3D"m=
ailto:danilomachado2002@hotmail.com">danilomachado2002@hotmail.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div clas=
s=3D"msg4344539165856588496">




<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
To: <a href=3D"mailto:freedesktop@lists.freedesktop.org" target=3D"_blank">=
freedesktop@lists.freedesktop.org</a></div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
Subject: [Bug report] AMD Radeon R9 380 (Tonga) suspend resume regression: =
black screen / no EDID on kernel 6.13+ (ref: Ubuntu #2142389)</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
Dear AMDGPU/DRM maintainers,</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
I&#39;m reporting a suspend/resume regression affecting the Radeon R9 380 (=
Tonga / GCN 3rd gen) on recent kernels (6.13+), observed on Ubuntu 24.10 de=
rivatives (Zorin OS 18) with kernel 6.17.0-14-generic.</div></div></div></b=
lockquote><div>A nontrivial amount of pm/EDID changes=C2=A0occurred between=
 6.12 and 6.13, are you able to bisect the kernel between those two revisio=
ns? Even narrowing it down to a release candidate should be useful.</div><d=
iv><br></div><div>#regzbot introduced: v5.12..v5.13<br>#regzbot from: Danil=
o Machado &lt;<a href=3D"mailto:danilomachado2002@hotmail.com">danilomachad=
o2002@hotmail.com</a>&gt;<br>#regzbot monitor: <a href=3D"https://bugs.laun=
chpad.net/ubuntu/+source/linux/+bug/2142389">https://bugs.launchpad.net/ubu=
ntu/+source/linux/+bug/2142389</a></div><div><br></div><div>Best,</div><div=
>Alex H</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div class=
=3D"msg4344539165856588496"><div dir=3D"ltr">
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
**Hardware:**</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
- GPU: AMD Radeon R9 380 Series (Tonga XT, Tonga)</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
- Motherboard: Gigabyte B450 AORUS PRO WIFI (BIOS F66)</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
- CPU: AMD Ryzen 5 5500</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
- Connection: Direct HDMI</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
- Display server: X11</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
- Power state: Deep sleep (S3)</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
**Symptoms:**</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
- After suspend (first cycle often works; subsequent cycles fail consistent=
ly):</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
=C2=A0 - System wakes (fans/LEDs active), but display shows black screen / =
no signal (&quot;HDMI Out of Range&quot; on monitor).</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
=C2=A0 - EDID read/handshake fails =E2=86=92 no video output recovered.</di=
v>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
=C2=A0 - Keyboard/mouse may respond briefly, but desktop freezes =E2=86=92 =
hard reboot required.</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
- Logs show:</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
=C2=A0 [drm] *ERROR* HDMI-A-1: probed a monitor but no|invalid EDID</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
=C2=A0 [drm] *ERROR* No EDID read.</div></div></div></blockquote><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div class=3D"msg434453916585658849=
6"><div dir=3D"ltr">
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
**Kernels tested:**</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
- Broken: 6.13.12 =E2=86=92 6.17.0-14 (regression starts between 6.12 and 6=
.13)</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
- Stable: 6.12.74 (LTS) =E2=80=93 suspend/resume fully reliable, no EDID er=
rors</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
**GRUB parameters used:**</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
quiet splash amdgpu.si_support=3D1 radeon.si_support=3D0 amdgpu.runpm=3D0 a=
mdgpu.dc=3D0</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
**Reference:**</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
This matches Ubuntu bug #2142389: <a href=3D"https://bugs.launchpad.net/ubu=
ntu/+source/linux/+bug/2142389" target=3D"_blank">https://bugs.launchpad.ne=
t/ubuntu/+source/linux/+bug/2142389</a></div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
(Reported by me on Launchpad; includes full dmesg logs and attachments)</di=
v>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
The issue appears to be in the DRM/DC layer (HDMI EDID re-detection during =
multi-cycle suspend/resume on Tonga). Downgrading to 6.12.74 resolves it co=
mpletely.</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
Is this a known regression? Any patches or additional debug info needed fro=
m my side?</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
Happy to test patches, provide more logs (dmesg, journalctl -b -u systemd-s=
uspend, full amdgpu debug), or try kernel builds.</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
Thanks for your attention and work on amdgpu!</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
Tested kernels:</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
6.12.74 =E2=80=94 stable, HDMI resume works</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
6.13.12 =E2=80=94 first resume OK, second suspend fails</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
6.14.x =E2=80=94 HDMI issues</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
6.17.0-14 =E2=80=94 frequent resume black screen</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
Best regards, =C2=A0</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
Danilo Machado =C2=A0</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
Minas Gerais, Brazil =C2=A0</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif;font-size:12pt;color=
:rgb(0,0,0)">
(Original reporter of Ubuntu bug #2142389)</div>
</div>

</div></blockquote></div></div>

--000000000000f00f81064c1f7c33--
