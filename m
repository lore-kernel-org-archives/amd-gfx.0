Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F6DC3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 13:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC3510E5B8;
	Tue, 23 Jul 2024 13:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GLy+d/21";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3858010E48C
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 13:08:18 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5a10835487fso3676833a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 06:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721653696; x=1722258496; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4h9JyQJubUNjSIg4/BB4kCwZYXdNCqLL016efGMdEW4=;
 b=GLy+d/21L7eZx4x/Q1OkKuhy5KDPPc004Nh1yO9rT8gTSOPiLUgVaFE7riN6GjxXIH
 TJHT1H21lxlH2IUUbDmuuANtqo6DtUkv0B3V/U7gLYmpMZ5DBfgjCb3ibYLTRUUyy65W
 xRQKfKdKdK9jqfHMHGfwhdbmWRHfgiYszUc8cam084tEyjhyscSxNP3Cr1n9w/uF/CgI
 CvrVaauwzDxbly6yk1U3SV/eoAkgsXoaY/nPUBQIEEUsEHN+Qs/3urHNQUIus+mjNz6x
 zB3yDupNu9dy7TgBjpaspb0f3+xj6/FBirAEc5N9ADj/CzQFwq788kcmGcmy3DkKVILt
 s4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721653696; x=1722258496;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4h9JyQJubUNjSIg4/BB4kCwZYXdNCqLL016efGMdEW4=;
 b=M8hcmaLX0YjzmKbMPs1eq7ITv5knNJMxvvBH+HwESgmOKi7Ai2F3AEsUUSrtNYKE7k
 sqXZg+hSCI4ArVyi4tSGmhx7Fg7ZqdvYbcSzPRRgPiOGZobD+OAksfBknvr/8Zmjheka
 PMrwp4xwZrOaoX2aexPcSb/TwuCHevLjsk8SLpzfyEItaJhlKhzqCV4psLpW6yRuNJir
 xZkQtVNL9gu+ZHYcMRttc1N7+sCm6dyhgFBWLNPBYEa/mPzA2sdnTUtNhK6fYTukurtS
 QV5OeevINcf+nxiElwd/6mz+jdi4ZC+EpTECnATBDy1weqm9wSCIZ1drer/NtH/1b16D
 Ckzw==
X-Gm-Message-State: AOJu0YynoEzwVNxSjcIzMb6FZL+Uo+CiOFKiZFZWFN7SQ6Ve7QON8hFO
 QACdKnb70RtLKwzoFuO+Pc11XgEf27Dj9GjO6kF8mX8KofTmjddkSrmKvTBwAraMitF5lBnqV7z
 q/ZifVr+99OLRHeNHsmxTJKGwRZyTpxeU
X-Google-Smtp-Source: AGHT+IFZmo/Atk+y9LOlcIOLCidnyquWlzy3WWtV8xYRK8I5zjs5NLy920jFXctoIIROWc14i7B/LDoHtAmtsnbcdAQ=
X-Received: by 2002:a05:6402:27c6:b0:5a3:a4d7:caf5 with SMTP id
 4fb4d7f45d1cf-5a47b5c0641mr4676370a12.36.1721653695982; Mon, 22 Jul 2024
 06:08:15 -0700 (PDT)
MIME-Version: 1.0
From: Andrew Worsley <amworsley@gmail.com>
Date: Mon, 22 Jul 2024 23:08:04 +1000
Message-ID: <CA+Y=x3m=fJs58=-=+77XuGAvURCEo5c1MOsfNUJeeNwYqd66Qg@mail.gmail.com>
Subject: amdgpu various gfx timeouts when running zoom on 6.10 kernel
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 23 Jul 2024 13:02:21 +0000
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

Twice running zoom when I connected to a meeting zoom crashed the
graphics - screen went black but recovered.

I've attended other meetings fine - so perhaps this zoom meeting was
triggering particular issues.

Any suggestions on how to avoid / debug this. Is it a zoom fault or
should the driver handle things better?
It's Framework 16in laptop - AMD Ryzen 7 7840HS w/ Radeon 780M
Graphics (family: 0x19, model: 0x74, stepping: 0x1)

Otherwise I guess just another bug? report on the latest 6.10 mainline kernel

Thanks

Andrew
-------------

First crash gave:

...
[  353.424445] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring
gfx_0.0.0 timeout, signaled seq=367613, emitted seq=367615
[  353.424601] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
information: process Xorg pid 1354 thread Xorg:cs0 pid 1398
[  353.424730] amdgpu 0000:c1:00.0: amdgpu: GPU reset begin!
[  355.464683] amdgpu 0000:c1:00.0: amdgpu: MES failed to respond to
msg=REMOVE_QUEUE
[  355.464689] [drm:amdgpu_mes_unmap_legacy_queue [amdgpu]] *ERROR*
failed to unmap legacy queue
[  355.672775] [drm:gfx_v11_0_hw_fini [amdgpu]] *ERROR* failed to halt cp gfx
[  355.674318] amdgpu 0000:c1:00.0: amdgpu: MODE2 reset
[  355.684463] amdgpu 0000:c1:00.0: amdgpu: GPU reset succeeded,
trying to resume
[  355.684956] [drm] PCIE GART of 512M enabled (table at 0x000000807FD00000).
[  355.685292] amdgpu 0000:c1:00.0: amdgpu: SMU is resuming...
[  355.687288] amdgpu 0000:c1:00.0: amdgpu: SMU is resumed successfully!
[  355.688843] [drm] DMUB hardware initialized: version=0x08000500
[  356.078340] [drm] kiq ring mec 3 pipe 1 q 0
[  356.080464] amdgpu 0000:c1:00.0: [drm:jpeg_v4_0_hw_init [amdgpu]]
JPEG decode initialized successfully.
[  356.081194] amdgpu 0000:c1:00.0: amdgpu: ring gfx_0.0.0 uses VM inv
eng 0 on hub 0
[  356.081197] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.0.0 uses VM
inv eng 1 on hub 0
[  356.081198] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.1.0 uses VM
inv eng 4 on hub 0
[  356.081200] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.2.0 uses VM
inv eng 6 on hub 0
[  356.081201] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.3.0 uses VM
inv eng 7 on hub 0
[  356.081202] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.0.1 uses VM
inv eng 8 on hub 0
[  356.081204] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.1.1 uses VM
inv eng 9 on hub 0
[  356.081205] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.2.1 uses VM
inv eng 10 on hub 0
[  356.081206] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.3.1 uses VM
inv eng 11 on hub 0
[  356.081208] amdgpu 0000:c1:00.0: amdgpu: ring sdma0 uses VM inv eng
12 on hub 0
[  356.081209] amdgpu 0000:c1:00.0: amdgpu: ring vcn_unified_0 uses VM
inv eng 0 on hub 8
[  356.081211] amdgpu 0000:c1:00.0: amdgpu: ring jpeg_dec uses VM inv
eng 1 on hub 8
[  356.081212] amdgpu 0000:c1:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM
inv eng 13 on hub 0
[  356.083844] amdgpu 0000:c1:00.0: amdgpu: recover vram bo from shadow start
[  356.083846] amdgpu 0000:c1:00.0: amdgpu: recover vram bo from shadow done
[  356.083857] amdgpu 0000:c1:00.0: amdgpu: GPU reset(2) succeeded!
[  356.084385] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
initialize parser -125!
[  356.139465] show_signal_msg: 14 callbacks suppressed
[  356.139469] zoom[3151]: segfault at 88 ip 00007f9e1beaa96d sp
00007ffe48b145c0 error 4 in libQt5Qml.so.5[2aa96d,7f9e1bc00000+463000]
likely on CPU 2 (core 1, socket 0)
[  356.139481] Code: 56 41 55 41 54 49 89 fd 55 53 48 83 ec 18 81 fe
ff 03 00 00 89 74 24 0c 7f 33 48 63 c6 4c 8d 8f 10 20 00 00 89 f3 4c
8d 24 c7 <49> 8b 04 24 4c 39 c8 0f 84 46 01 00 00 48 83 c4 18 5b 5d 41
5c 41
...


  The 2nd was:

...
[  419.721629] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring
gfx_0.0.0 timeout, signaled seq=504752, emitted seq=504754
[  419.721966] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
information: process zoom pid 6359 thread zoom:cs0 pid 6487
[  419.722119] amdgpu 0000:c1:00.0: amdgpu: GPU reset begin!
[  421.763459] amdgpu 0000:c1:00.0: amdgpu: MES failed to respond to
msg=REMOVE_QUEUE
[  421.763466] [drm:amdgpu_mes_unmap_legacy_queue [amdgpu]] *ERROR*
failed to unmap legacy queue
[  421.970628] [drm:gfx_v11_0_hw_fini [amdgpu]] *ERROR* failed to halt cp gfx
[  421.972159] amdgpu 0000:c1:00.0: amdgpu: MODE2 reset
[  421.981902] amdgpu 0000:c1:00.0: amdgpu: GPU reset succeeded,
trying to resume
[  421.982359] [drm] PCIE GART of 512M enabled (table at 0x000000807FD00000).
[  421.982470] amdgpu 0000:c1:00.0: amdgpu: SMU is resuming...
[  421.984527] amdgpu 0000:c1:00.0: amdgpu: SMU is resumed successfully!
[  421.986302] [drm] DMUB hardware initialized: version=0x08000500
[  422.402515] [drm] kiq ring mec 3 pipe 1 q 0
[  422.404548] amdgpu 0000:c1:00.0: [drm:jpeg_v4_0_hw_init [amdgpu]]
JPEG decode initialized successfully.
[  422.405292] amdgpu 0000:c1:00.0: amdgpu: ring gfx_0.0.0 uses VM inv
eng 0 on hub 0
[  422.405295] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.0.0 uses VM
inv eng 1 on hub 0
[  422.405297] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.1.0 uses VM
inv eng 4 on hub 0
[  422.405298] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.2.0 uses VM
inv eng 6 on hub 0
[  422.405299] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.3.0 uses VM
inv eng 7 on hub 0
[  422.405301] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.0.1 uses VM
inv eng 8 on hub 0
[  422.405302] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.1.1 uses VM
inv eng 9 on hub 0
[  422.405303] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.2.1 uses VM
inv eng 10 on hub 0
[  422.405304] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.3.1 uses VM
inv eng 11 on hub 0
[  422.405305] amdgpu 0000:c1:00.0: amdgpu: ring sdma0 uses VM inv eng
12 on hub 0
[  422.405307] amdgpu 0000:c1:00.0: amdgpu: ring vcn_unified_0 uses VM
inv eng 0 on hub 8
[  422.405308] amdgpu 0000:c1:00.0: amdgpu: ring jpeg_dec uses VM inv
eng 1 on hub 8
[  422.405310] amdgpu 0000:c1:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM
inv eng 13 on hub 0
[  422.408029] amdgpu 0000:c1:00.0: amdgpu: recover vram bo from shadow start
[  422.408031] amdgpu 0000:c1:00.0: amdgpu: recover vram bo from shadow done
[  422.408043] amdgpu 0000:c1:00.0: amdgpu: GPU reset(4) succeeded!
[  422.427724] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
initialize parser -125!
....
