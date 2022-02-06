Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7340DC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 09:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E8BF10F516;
	Mon,  7 Feb 2022 09:10:33 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09A710E463
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Feb 2022 08:17:19 +0000 (UTC)
Received: by mail-yb1-xb2a.google.com with SMTP id m6so31529802ybc.9
 for <amd-gfx@lists.freedesktop.org>; Sun, 06 Feb 2022 00:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=oUwhUnseUW+bGQTYIs65iPvnP1JsQG2MNuMaM8NXA2w=;
 b=J88qG9ehqMbKpU/BGb/Cc7ee2LWN6RFY5x1KWxZUll1+0SMHOCWO+H31EvqkY4OXDY
 vG3ml0n9EC71VPLGl2R/ErUFCHfvzEe/0pJiy521qF2HmDGvxdcHOMLqEDlHMaXj+Cq6
 /kpScLLc8tt2uMdt4mSwU/AI/7Gv9y/+xBkUqCsd4Yt2mcRySxxGqALCaVflfWB67MK6
 ftnQJOmJPzD3Iy4v+MFlMWxwkd5cxd1x2FCB47mqTV+eFBjVB8lExBI2Zh3xXnojvk1k
 5uP+SZ7t6op7yde8AbymnqbwHWkw5xzwyLX4KcLaZNt3svEIW7RAUHWdM+DaGkefoo1M
 gLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=oUwhUnseUW+bGQTYIs65iPvnP1JsQG2MNuMaM8NXA2w=;
 b=zzjbzsr9lJT1EkD2hgKPNlZL6SnAqgLqWJTLWMkybEO8Fj9nad23XlfTXYtR5DFZ0G
 3EkkrojkathaToPz1QnJKXROcBqX79Dt0ENNxqbAw82wYoLa+yjCC2LZW3V63CnWVd2D
 3PwfihcDafVRG1U5UeL/h+tea2Qy7BRQ9MO6qRJ2NEWFBPDcAqmhdpOpQwAxU8kq4lQO
 oSzoHAO6KlrWIG1mddOrkRYi0j0vEQN/lbG7LWGucfXQP1HTCgb9HiUk+zjlmzpHjHVR
 UoJYYow5dH4GcjsXSFRZ2WCJJYeeEHoelv9Z74/+Ps+F00cdT745KT0vqwoUbZqNAl6O
 bzbQ==
X-Gm-Message-State: AOAM533WP5zZ/qio+/RYjy2/fuayYiykp1gYZSLrkJvHLLcvrYLnCKQ2
 /42CcyL5WXvvj/Ck6Mo8CYpvC5pKtEFkPa9EK+sYFQzr+3o=
X-Google-Smtp-Source: ABdhPJyg0wOdJ8nQQRHbv7/V+bSVhubm/Kn0XMAET3doH6yT5uEPq8rXgrEmJi5+Z0cwiUC9KgXyzYnny28xvFQnahk=
X-Received: by 2002:a25:5ca:: with SMTP id 193mr6339820ybf.483.1644135438773; 
 Sun, 06 Feb 2022 00:17:18 -0800 (PST)
MIME-Version: 1.0
References: <CAOHtt3_wfx1kpcjA3s63x+TaHS8DmCSk629OAN+Bi5nZzwrb5Q@mail.gmail.com>
In-Reply-To: <CAOHtt3_wfx1kpcjA3s63x+TaHS8DmCSk629OAN+Bi5nZzwrb5Q@mail.gmail.com>
From: =?UTF-8?Q?Tomasz_Mo=C5=84?= <desowin@gmail.com>
Date: Sun, 6 Feb 2022 09:17:07 +0100
Message-ID: <CAOHtt39VcCNYwHcEj3NB3904tw4cKBDc-wH_CWvGr3NWM_vH=A@mail.gmail.com>
Subject: Re: Waiting for fences timed out on MacBook Pro 2019
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 07 Feb 2022 09:10:31 +0000
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

On Mon, Jul 12, 2021 at 11:56 AM Tomasz Mo=C5=84 <desowin@gmail.com> wrote:
> I am having trouble getting Linux to run on MacBook Pro 2019 with
> Radeon Pro Vega 20 4 GB. Basically as soon as graphical user interface
> starts, the whole system freezes. This happens with every Linux kernel
> version I have tried over the last few months, including 5.13.

It is significantly better on 5.17-rc2. That is, the whole system is
not frozen. just the screen keeps blinking and visual artifacts show.
Graphical desktop is not usable, but switching between virtual
terminals works just fine.

dmesg | grep amdgpu shows:
[    2.310680] [drm] amdgpu kernel modesetting enabled.
[    2.310888] amdgpu: CRAT table not found
[    2.310891] amdgpu: Virtual CRAT table created for CPU
[    2.310902] amdgpu: Topology: Add CPU node
[    2.310966] fb0: switching to amdgpu from EFI VGA
[    2.311069] amdgpu 0000:03:00.0: vgaarb: deactivate vga console
[    2.311161] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone (TMZ)
feature not supported
[    2.322968] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from VFCT
[    2.322972] amdgpu: ATOM BIOS: 113-D20601MA0T-016
[    2.325980] amdgpu 0000:03:00.0: BAR 2: releasing [mem
0xc0000000-0xc01fffff 64bit pref]
[    2.325983] amdgpu 0000:03:00.0: BAR 0: releasing [mem
0xb0000000-0xbfffffff 64bit pref]
[    2.326015] amdgpu 0000:03:00.0: BAR 0: assigned [mem
0x4100000000-0x41ffffffff 64bit pref]
[    2.326022] amdgpu 0000:03:00.0: BAR 2: assigned [mem
0x4080000000-0x40801fffff 64bit pref]
[    2.326075] amdgpu 0000:03:00.0: amdgpu: VRAM: 4080M
0x000000F400000000 - 0x000000F4FEFFFFFF (4080M used)
[    2.326078] amdgpu 0000:03:00.0: amdgpu: GART: 512M
0x0000000000000000 - 0x000000001FFFFFFF
[    2.326080] amdgpu 0000:03:00.0: amdgpu: AGP: 267419648M
0x000000F800000000 - 0x0000FFFFFFFFFFFF
[    2.326144] [drm] amdgpu: 4080M of VRAM memory ready
[    2.326145] [drm] amdgpu: 4080M of GTT memory ready.
[    2.330452] amdgpu 0000:03:00.0: amdgpu: PSP runtime database doesn't ex=
ist
[    2.330457] amdgpu: hwmgr_sw_init smu backed is vega12_smu
[    3.169108] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])
[    4.427470] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    4.462468] amdgpu: HMM registered 4080MB device memory
[    4.462492] amdgpu: SRAT table not found
[    4.462492] amdgpu: Virtual CRAT table created for GPU
[    4.462567] amdgpu: Topology: Add dGPU node [0x69af:0x1002]
[    4.462572] kfd kfd: amdgpu: added device 1002:69af
[    4.462587] amdgpu 0000:03:00.0: amdgpu: SE 4, SH per SE 1, CU per
SH 5, active_cu_number 20
[    4.462674] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
[    4.462676] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM
inv eng 1 on hub 0
[    4.462678] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM
inv eng 4 on hub 0
[    4.462679] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM
inv eng 5 on hub 0
[    4.462680] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM
inv eng 6 on hub 0
[    4.462682] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM
inv eng 7 on hub 0
[    4.462683] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM
inv eng 8 on hub 0
[    4.462684] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM
inv eng 9 on hub 0
[    4.462685] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM
inv eng 10 on hub 0
[    4.462686] amdgpu 0000:03:00.0: amdgpu: ring kiq_2.1.0 uses VM inv
eng 11 on hub 0
[    4.462688] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng
0 on hub 1
[    4.462689] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng
1 on hub 1
[    4.462690] amdgpu 0000:03:00.0: amdgpu: ring uvd_0 uses VM inv eng
4 on hub 1
[    4.462691] amdgpu 0000:03:00.0: amdgpu: ring uvd_enc_0.0 uses VM
inv eng 5 on hub 1
[    4.462693] amdgpu 0000:03:00.0: amdgpu: ring uvd_enc_0.1 uses VM
inv eng 6 on hub 1
[    4.462694] amdgpu 0000:03:00.0: amdgpu: ring vce0 uses VM inv eng 7 on =
hub 1
[    4.462695] amdgpu 0000:03:00.0: amdgpu: ring vce1 uses VM inv eng 8 on =
hub 1
[    4.462696] amdgpu 0000:03:00.0: amdgpu: ring vce2 uses VM inv eng 9 on =
hub 1
[    4.469544] [drm] Initialized amdgpu 3.44.0 20150101 for
0000:03:00.0 on minor 0
[    4.474424] fbcon: amdgpudrmfb (fb0) is primary device
[    5.547836] amdgpu 0000:03:00.0: [drm] fb0: amdgpudrmfb frame buffer dev=
ice
[    5.636489] audit: type=3D1130 audit(1644133454.781:45): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295
msg=3D'unit=3Dsystemd-backlight@backlight:amdgpu_bl0 comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[   24.927611] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR*
Waiting for fences timed out!
[   24.927611] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR*
Waiting for fences timed out!
[   30.057616] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx
timeout, signaled seq=3D895, emitted seq=3D897
[   30.057933] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
information: process Xorg pid 722 thread Xorg:cs0 pid 723
[   30.058217] amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
[   34.058227] amdgpu 0000:03:00.0: amdgpu: failed to suspend display audio
[   34.314738] amdgpu 0000:03:00.0: amdgpu: MODE1 reset
[   34.314741] amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
[   34.314792] amdgpu 0000:03:00.0: amdgpu: GPU psp mode1 reset
[   34.892364] amdgpu 0000:03:00.0: amdgpu: GPU reset succeeded,
trying to resume
[   36.910260] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
[   36.910263] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM
inv eng 1 on hub 0
[   36.910264] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM
inv eng 4 on hub 0
[   36.910266] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM
inv eng 5 on hub 0
[   36.910267] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM
inv eng 6 on hub 0
[   36.910268] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM
inv eng 7 on hub 0
[   36.910269] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM
inv eng 8 on hub 0
[   36.910271] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM
inv eng 9 on hub 0
[   36.910272] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM
inv eng 10 on hub 0
[   36.910273] amdgpu 0000:03:00.0: amdgpu: ring kiq_2.1.0 uses VM inv
eng 11 on hub 0
[   36.910274] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng
0 on hub 1
[   36.910276] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng
1 on hub 1
[   36.910277] amdgpu 0000:03:00.0: amdgpu: ring uvd_0 uses VM inv eng
4 on hub 1
[   36.910278] amdgpu 0000:03:00.0: amdgpu: ring uvd_enc_0.0 uses VM
inv eng 5 on hub 1
[   36.910279] amdgpu 0000:03:00.0: amdgpu: ring uvd_enc_0.1 uses VM
inv eng 6 on hub 1
[   36.910281] amdgpu 0000:03:00.0: amdgpu: ring vce0 uses VM inv eng 7 on =
hub 1
[   36.910282] amdgpu 0000:03:00.0: amdgpu: ring vce1 uses VM inv eng 8 on =
hub 1
[   36.910283] amdgpu 0000:03:00.0: amdgpu: ring vce2 uses VM inv eng 9 on =
hub 1
[   36.913056] amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow sta=
rt
[   36.913063] amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow don=
e
[   36.913147] amdgpu 0000:03:00.0: amdgpu: GPU reset(2) succeeded!
[   36.915587] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
initialize parser -125!
[   36.916107] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
initialize parser -125!
[   36.916471] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
initialize parser -125!
[   36.916975] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
initialize parser -125!
[   36.917366] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
initialize parser -125!
[   36.917735] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
initialize parser -125!
[   38.243514] amdgpu_cs_ioctl: 101 callbacks suppressed
[   38.243517] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
initialize parser -125!
[   38.243999] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
initialize parser -125!
