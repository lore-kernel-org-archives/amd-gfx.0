Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341E5C52D6F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Aug 2024 08:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A2A610E08E;
	Sat, 24 Aug 2024 08:28:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bSTsQTFr";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960FA10E18D
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Aug 2024 04:29:13 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-5bf006f37daso4412531a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 21:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724473752; x=1725078552; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EpiEIimviNiVm/3hOcW6Zib4FOcN88JDE8WNZ5EIbkE=;
 b=bSTsQTFru+FcSQDZj681hHj/psBPDFxnPXim+H2z4k8hPYWTtFfqUjwJzPvn4AjHql
 N3XwQfkj8pp4VffXe9tZLXFOtqfrZofYTfz8601GlkiZc9Pj7vwlhdtjPD9F5bm3N0Nw
 bnd99oStgybSndsG0UwQ33mDV8imr/UA5qCSz9rE9UxwZjd/0IzVYobqTuvU8LNSdqzB
 FYDNDpN1oySYKx7IMlMDV6aLLXxLLAkExfmsmw05s3Z/UkS7TfnE1lH0znHvOQzVwtSj
 qorb8ixL+ao8epggjPIjPpK1GXBRHDEqTXRKfOb9WYEZInPy4yhvJKd+69ABVfbYda0m
 X3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724473752; x=1725078552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EpiEIimviNiVm/3hOcW6Zib4FOcN88JDE8WNZ5EIbkE=;
 b=vngxTXgy9iwbtsqwi1S3Ov23feCLD+YYdUaZ9NSzyt4loU5paJE2u7V4WmUm/TjUXs
 HnQfplZwxo7dL6ZPfmtsKaK17x04hPoL+kG0Kag/C1b5Oys1BdjXsmTRxZxtB6RA23P5
 XTBi/UikIzETDdm9JipWFSMkYJ2whrRVyBtS+PA0b3eQxWfNPPLE+ykU9rlvk1h/6HaO
 HMa6VwADeYLLl5TZFxn0nWS+m4ASnMfuKbnTSDPoY2vDzZXbnkmXmUSRGyqBiDYuEszO
 xfE8KSiMItyeh/vcKmr4GkMfXy0bPmALN63MncMJ+AiDT9VajozFPeBAJl+Cbs9bovqi
 cwbA==
X-Gm-Message-State: AOJu0YxmoI7fd2bQXG0fA/KPt3Dz6M7Xc6xxPzKoQFNTqU1sGhFisCpL
 EIXswRAXGfyusoFinpiqO77T63InmWAAk5D8XwWYLND9StVnEOVhnFckIHZnX+IEnmJG1aIUiHG
 fYMPTmgLMaIV156X6HkNQzzIH5KRLdDHG
X-Google-Smtp-Source: AGHT+IF0e/h/Q7UVrn/5DcakfgyaM8aGOfgYZ7dF/5tNwfh3/9skw6lJHsbBVqWcpHVZNT/3mhg3qHGTidW0cJRJZyo=
X-Received: by 2002:a05:6402:2808:b0:5be:fa53:f74 with SMTP id
 4fb4d7f45d1cf-5c087e8f3acmr3962883a12.0.1724473751481; Fri, 23 Aug 2024
 21:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240822102830.2277414-1-Jack.Xiao@amd.com>
In-Reply-To: <20240822102830.2277414-1-Jack.Xiao@amd.com>
From: Andrew Worsley <amworsley@gmail.com>
Date: Sat, 24 Aug 2024 14:28:59 +1000
Message-ID: <CA+Y=x3mx5k_cvFUD0qqUhPGtuXCb3MqeNcXRsTsBh71KpxZN8g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes: add mes mapping legacy queue switch
To: Jack Xiao <Jack.Xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 marek.olsak@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Aug 2024 08:28:43 +0000
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

I tested this patch

On Thu, 22 Aug 2024 at 20:28, Jack Xiao <Jack.Xiao@amd.com> wrote:
>
> For mes11 old firmware has issue to map legacy queue,
> add a flag to switch mes to map legacy queue.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 49 +++++++++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  |  9 +++--
>  4 files changed, 43 insertions(+), 20 deletions(-)
>
...
with the older firmware on the v6.11-rc4 kernel and it seems to work
fine on my laptop:

% grep amdgpu dmesg-6.11.0-rc4-jack-amw+.txt
[    2.556631] [drm] amdgpu kernel modesetting enabled.
[    2.562758] amdgpu: Virtual CRAT table created for CPU
[    2.563277] amdgpu: Topology: Add CPU node
[    2.575279] amdgpu 0000:c1:00.0: amdgpu: Fetched VBIOS from VFCT
[    2.575756] amdgpu: ATOM BIOS: 113-PHXGENERIC-001
[    2.577651] amdgpu 0000:c1:00.0: Direct firmware load for
amdgpu/gc_11_0_1_mes_2.bin failed with error -2
[    2.578177] amdgpu 0000:c1:00.0: amdgpu: try to fall back to
gc_11_0_1_mes.bin
[    2.579118] amdgpu 0000:c1:00.0: vgaarb: deactivate vga console
[    2.579122] amdgpu 0000:c1:00.0: amdgpu: Trusted Memory Zone (TMZ)
feature enabled
[    2.579197] amdgpu 0000:c1:00.0: amdgpu: VRAM: 2048M
0x0000008000000000 - 0x000000807FFFFFFF (2048M used)
[    2.579202] amdgpu 0000:c1:00.0: amdgpu: GART: 512M
0x00007FFF00000000 - 0x00007FFF1FFFFFFF
[    2.579384] [drm] amdgpu: 2048M of VRAM memory ready
[    2.579389] [drm] amdgpu: 31048M of GTT memory ready.
[    2.605229] amdgpu 0000:c1:00.0: amdgpu: reserve 0x4000000 from
0x8078000000 for PSP TMR
[    3.128536] amdgpu 0000:c1:00.0: amdgpu: RAS: optional ras ta ucode
is not available
[    3.136355] amdgpu 0000:c1:00.0: amdgpu: RAP: optional rap ta ucode
is not available
[    3.136365] amdgpu 0000:c1:00.0: amdgpu: SECUREDISPLAY:
securedisplay ta ucode is not available
[    3.146193] amdgpu 0000:c1:00.0: amdgpu: SMU is initialized successfully!
[    3.258706] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    3.258723] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
[    3.258838] amdgpu: Virtual CRAT table created for GPU
[    3.258978] amdgpu: Topology: Add dGPU node [0x15bf:0x1002]
[    3.258982] kfd kfd: amdgpu: added device 1002:15bf
[    3.258995] amdgpu 0000:c1:00.0: amdgpu: SE 1, SH per SE 2, CU per
SH 6, active_cu_number 12
[    3.259002] amdgpu 0000:c1:00.0: amdgpu: ring gfx_0.0.0 uses VM inv
eng 0 on hub 0
[    3.259006] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.0.0 uses VM
inv eng 1 on hub 0
[    3.259009] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.1.0 uses VM
inv eng 4 on hub 0
[    3.259013] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.2.0 uses VM
inv eng 6 on hub 0
[    3.259016] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.3.0 uses VM
inv eng 7 on hub 0
[    3.259019] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.0.1 uses VM
inv eng 8 on hub 0
[    3.259022] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.1.1 uses VM
inv eng 9 on hub 0
[    3.259026] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.2.1 uses VM
inv eng 10 on hub 0
[    3.259029] amdgpu 0000:c1:00.0: amdgpu: ring comp_1.3.1 uses VM
inv eng 11 on hub 0
[    3.259032] amdgpu 0000:c1:00.0: amdgpu: ring sdma0 uses VM inv eng
12 on hub 0
[    3.259035] amdgpu 0000:c1:00.0: amdgpu: ring vcn_unified_0 uses VM
inv eng 0 on hub 8
[    3.259038] amdgpu 0000:c1:00.0: amdgpu: ring jpeg_dec uses VM inv
eng 1 on hub 8
[    3.259041] amdgpu 0000:c1:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM
inv eng 13 on hub 0
[    3.267498] amdgpu 0000:c1:00.0: amdgpu: Runtime PM not available
[    3.268055] [drm] Initialized amdgpu 3.58.0 for 0000:c1:00.0 on minor 0
[    3.280095] fbcon: amdgpudrmfb (fb0) is primary device
[    4.194462] amdgpu 0000:c1:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[   22.685627] snd_hda_intel 0000:c1:00.1: bound 0000:c1:00.0 (ops
amdgpu_dm_audio_component_bind_ops [amdgpu])

Thanks Jack

Andrew
