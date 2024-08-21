Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ED4C5472E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 07:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F55910E89C;
	Wed, 21 Aug 2024 07:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mlfb75n4";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFA110E548
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 02:45:09 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5bed72ff443so5550479a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 19:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724208307; x=1724813107; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o4cqz96N+ROaBBMWLpFKEgKo/bq32VOrAJWuy8mVm0E=;
 b=Mlfb75n4BR/73vRuBpxyNL+nDOlr3BEdgCUHAn13o5ZlGJnxRJi71fgPKo0zrEJVlQ
 aqWTDLRdkyrdELbwwHaNG2XBEAVW9R5gWrDr3ANV0Ix7QwODGEoVqRAmT8KJr5d668Lx
 JKUDKL++TOF+j04vlmdpEzVFtPpkiJ071y3upBfPZ20NXa2MFZvXkZAJzkekQBP45M1+
 lNlqQTTGmN0QRtnXK1+wGXybxalmoZB80FIwZwMzxa2nlN7GNyhAMvdv+EbOOTWgnBiQ
 m0KfNMncUkFVxLfa7uT8vDtP87VK9bMlvQqJ858RBa26XZBauRJQDlY+/tBZi8efoE4c
 qRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724208307; x=1724813107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o4cqz96N+ROaBBMWLpFKEgKo/bq32VOrAJWuy8mVm0E=;
 b=rUg0NHonGNAaOFk/leijw93uRJzd/6XEBbmUon8ahqvnwbfg6TQTpjf1ngeCSDORVU
 f36ncZ0biFw/InOBuEVmS4qCEbGYP5UrQjKVfoVavKThd6OKWK1rYDgUegltk0K/u7AZ
 O5ELnIJqtTzbIElRhWS2LmOxuto5FqqaFbEco8VrENG7fbMIoiPMSNK7Emz0SyL4YjrI
 QiL2QHvJlI5J92wr11o7ouz0xbVrr6duVsWunHznVAjHDLbTg844kYLvttb2zZ3ELpB9
 e7YywPukWIR/btoT6r0gljkOu4iS6RRS03Cvt3EFnBEEiTaDGdI3epJNArmDybfEirul
 +xfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIdb+fX0X0eMvOF+PEPqjn150+3vuSwcl+VadpZwT7CikdfKgPIlqvHRq8+Jv0mHjcSX4ecFnu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMM1YysBIkoXdbSdWXEVt3J+Xi7Ktok1ks+bh5ZBGUKKnToPft
 JAH811+Xr1zs4qSMtlICPZmyXTS6y8ewOYbKspa6JQp5r1X0gBw68vgCpD0dG88fFevpxADNbly
 sZTChoBJn3usJQK+hSi4XOiWYWDM=
X-Google-Smtp-Source: AGHT+IE/BtNAH4luKFYEHjh92k3KtZ8KEYJ9HdfouOot62dbFjXZDQ2EVtmsXYhf0KyGa4yuegO5enEAusQ+n/KkY1M=
X-Received: by 2002:a05:6402:190c:b0:5be:c73e:26e1 with SMTP id
 4fb4d7f45d1cf-5bf1f1666e6mr391225a12.22.1724208306979; Tue, 20 Aug 2024
 19:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Y=x3n+X6PDza5KAG2fy2wLh0-w5mWQtvKbWvT3E3A0r_makg@mail.gmail.com>
 <CADnq5_N-pvp8czodNT=YDFsqRz-Tet4GHK-JWiDdHnfL-2YF-w@mail.gmail.com>
 <CA+Y=x3kr1F4OVPK8priS6cJZx_4KAT4kiYTLXhGK6qcYSG9TXw@mail.gmail.com>
 <CADnq5_PthnFSeyLxhLSRiWSU1Y2McrMuSC6LXC2CFW3hqmTwVw@mail.gmail.com>
In-Reply-To: <CADnq5_PthnFSeyLxhLSRiWSU1Y2McrMuSC6LXC2CFW3hqmTwVw@mail.gmail.com>
From: Andrew Worsley <amworsley@gmail.com>
Date: Wed, 21 Aug 2024 12:44:54 +1000
Message-ID: <CA+Y=x3k2ctOPbUnopoGj29ytLtnWZkSDFnYS6Z0A+-YbtKRr_g@mail.gmail.com>
Subject: Re: v6.11-rc4 amdgpu regression from v6.10.0
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 21 Aug 2024 07:16:18 +0000
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

On Tue, 20 Aug 2024 at 23:09, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> + Jack
>
> Looks like maybe some older firmware versions don't support this
> properly.  @Jack Xiao Can you find out if there is a minimum firmware
> version needed for legacy queue mapping and add the appropriate check?

Might be even nicer if there was a version bit that could be checked
to see if the feature is present
rather than hardcode the version number into the driver....
>
> @Andrew Worsley does it work correctly with a newer version of firmware?

Yep - it does!
 Didn't even realise there was firmware involved! - google searching
showed on Debian (I'm running bookworm) there is the package
firmware-non-free
  https://tracker.debian.org/pkg/firmware-nonfree which generates the
binary package firmware-amd-graphics
  which has several releases (See
https://packages.debian.org/search?keywords=firmware-amd-graphics)
and there is a newer one 20240709-1 which I installed (lots of new
files in /lib/firmware/amdgpu) then rebuilt my kernel with latest
mainline:
...
commit 0108b7be2a18 (HEAD -> master, mainline/master)
Merge: 521b1e7f4cf0 cf1e515c9a40
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Aug 20 16:06:39 2024 -0700

....

Yep - it boots beautifully !

Not sure what firmware file it ends up loading :

% grep amdgpu dmesg-6.11.0-rc4-amw+.txt
  gives

[    2.636668] [drm] amdgpu kernel modesetting enabled.
[    2.643985] amdgpu: Virtual CRAT table created for CPU
[    2.644517] amdgpu: Topology: Add CPU node
[    2.657219] amdgpu 0000:c1:00.0: amdgpu: Fetched VBIOS from VFCT
[    2.657741] amdgpu: ATOM BIOS: 113-PHXGENERIC-001
[    2.660178] amdgpu 0000:c1:00.0: vgaarb: deactivate vga console
[    2.660182] amdgpu 0000:c1:00.0: amdgpu: Trusted Memory Zone (TMZ)
feature enabled
[    2.660246] amdgpu 0000:c1:00.0: amdgpu: VRAM: 2048M
0x0000008000000000 - 0x000000807FFFFFFF (2048M used)
[    2.660250] amdgpu 0000:c1:00.0: amdgpu: GART: 512M
0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[    2.660449] [drm] amdgpu: 2048M of VRAM memory ready
[    2.660452] [drm] amdgpu: 31048M of GTT memory ready.
[    2.686979] amdgpu 0000:c1:00.0: amdgpu: reserve 0x4000000 from
0x8078000000 for PSP TMR
[    3.239914] amdgpu 0000:c1:00.0: amdgpu: RAS: optional ras ta ucode
is not available
[    3.248124] amdgpu 0000:c1:00.0: amdgpu: RAP: optional rap ta ucode
is not available
[    3.248134] amdgpu 0000:c1:00.0: amdgpu: SECUREDISPLAY:
securedisplay ta ucode is not available
[    3.278022] amdgpu 0000:c1:00.0: amdgpu: SMU is initialized successfully!
[    3.388257] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    3.388276] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    3.388466] amdgpu: Virtual CRAT table created for GPU
[    3.388990] amdgpu: Topology: Add dGPU node [0x15bf:0x1002]
[    3.388993] kfd kfd: amdgpu: added device 1002:15bf
[    3.389007] amdgpu 0000:c1:00.0: amdgpu: SE 1, SH per SE 2, CU per
SH 6, active_cu_number 12
[    3.389014] amdgpu 0000:c1:00.0: amdgpu: ring gfx_0.0.0 uses VM inv
eng 0 on hub 0
[    3.389018] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.0.0 uses VM
inv eng 1 on hub 0
[    3.389022] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.1.0 uses VM
inv eng 4 on hub 0
[    3.389025] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.2.0 uses VM
inv eng 6 on hub 0
[    3.389028] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.3.0 uses VM
inv eng 7 on hub 0
[    3.389031] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.0.1 uses VM
inv eng 8 on hub 0
[    3.389034] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.1.1 uses VM
inv eng 9 on hub 0
[    3.389038] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.2.1 uses VM
inv eng 10 on hub 0
[    3.389041] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.3.1 uses VM
inv eng 11 on hub 0
[    3.389044] amdgpu 0000:c1:00.0: amdgpu: ring sdma0 uses VM inv eng
12 on hub 0
[    3.389047] amdgpu 0000:c1:00.0: amdgpu: ring vcn_unified_0 uses VM
inv eng 0 on hub 8
[    3.389050] amdgpu 0000:c1:00.0: amdgpu: ring jpeg_dec uses VM inv
eng 1 on hub 8
[    3.389053] amdgpu 0000:c1:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM
inv eng 13 on hub 0
[    3.395116] amdgpu 0000:c1:00.0: amdgpu: Runtime PM not available
[    3.395724] [drm] Initialized amdgpu 3.58.0 for 0000:c1:00.0 on minor 0
[    3.407862] fbcon: amdgpudrmfb (fb0) is primary device
[    4.441001] amdgpu 0000:c1:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[   15.976841] snd_hda_intel 0000:c1:00.1: bound 0000:c1:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])


>
> Thanks,
>
> Alex
>

Thank - you

Andrew
