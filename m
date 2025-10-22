Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3E8CCF9E8
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 07:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5561910E8B8;
	Thu, 23 Oct 2025 07:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ipE4sNSX";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A87710E166
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 16:51:28 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-b6d3effe106so83833666b.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761151887; x=1761756687; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hewebkT9BYGaFW4AHn5/lDXF4E05jwqSkz6WebH3+FU=;
 b=ipE4sNSXpCO0U8raEl4Gq6cTQvsnnLHZ0gtxciccFH70lTXR53b0fnhPwx+StoVJse
 Rqitgo65s6Fp3Faelk/Jkh/5tfLn2xR+CxXSazAOVKGNEiPUQE0b4d3OzK8WAgzeNxjV
 Or5K9esWuNj5Pm6TEUyu7k9ltFwekcz2xF6ioeXRx/kE/A4G9wgHEliZhQuhZMzd5stM
 2w0uaa38On76B/tG54w7KAIe7t9SGNh+m6W8cwLNZ+IR3/j16C6JEvtr/AnjsRFnRYlG
 pTO4FRI2Blcp7aNZrumDHScUZ8njbWda9dGrfOMC9aTcOFWipsVPihwAOUSkePP5ofnc
 nshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761151887; x=1761756687;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hewebkT9BYGaFW4AHn5/lDXF4E05jwqSkz6WebH3+FU=;
 b=VDwnmnCZh1JCny20W5HKASiPYZ1kXfYdnrECEs2m7jE3t3Qlysy2sxUF/kVkfKqml8
 Vf4w1Yd4rDnpJjCfcafoOS4vS1bJawhQq+X7K8RAmFRWTTUBOAuMDbwKRZb+frlpZVeK
 r483mkRZD164Pw4kXJLDdwa4yLl3L1mIBkW+WcIT33Z9LMlyb7EeQ6FhDffpbVr+8LQu
 0Ji2rTB/n98LD4riDdhVlLYmecQ4LuzIPshwVrGz55Odv4OVSU8k1WIkVyE7EEDREKpS
 aBOdaW0UJOB6XNNhR9k4hdu5IV7fhVQvnI63Ec2ZmVeReGEyoBFRHxw0Kh66PCcwW0D9
 p91g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQSlSu3lt3pE0TKY1SwzxTYQAtwJ3E8cmnkDQcf3p74blnDVFsBrzoHABox+mpkIDzRLPiD9Dl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPSfmrLrlhg3PC/Dj2Si665nCvwlrwy8UfDp9Isp5oKWbZDYdl
 ssCBWvzeaKKKMJQeZFdPI/G4Guj+w6xwqBy4Yg30uL46QSc+tl89aSdcxs7UuCZFeio=
X-Gm-Gg: ASbGncu5SZlAZpm7hDhpNhmUjpcLI5+Yrtdtf9UnDsPTTqA3542TZcfxI+NI6iOVRRQ
 Bw+8B+l9aHb9LR2ST2GOdrO4nv/0GIagJymUBLkQU+l8izVc94RVz2bVt+cSXN+HpmjGbWDY2Z8
 BA2EpnaFacSIoXBj1OTiuhZxr2w5Emai7AlVRhctRqhLAJGYdmCiIhGyxjkw3a/qWKm2aiF8av1
 JEEsWKzyqI/dPSXYqJ4MB/BMy8xykbPXjEsYtZjXzMOZnm4W6YGWg3NlDfEJYpmMqxNPouchDUa
 gnYDah2C2JmE1w6PIsETKDiCRkEVJ/GB8bxbD0K9bo2vpr3LNtuGSuJVAiZJrlDkCu457rwxkEn
 7Mn0sz+WVQlqs6w1atZN9jjHM38qcQBMiiSLA/FSnXJ5f8LXzOzW8AmUG3bsm6iKNttKmfbD18n
 /xTBGgH35mMmA=
X-Google-Smtp-Source: AGHT+IEnxvO4FiGis2u9MAnkLdrIabhy0DeX4flJcd/EfQ7kPzqePDzP8ugGngOXqnHdV+i79Y94vw==
X-Received: by 2002:a17:907:c10:b0:b6d:4303:7589 with SMTP id
 a640c23a62f3a-b6d430377demr73416466b.25.1761151886706; 
 Wed, 22 Oct 2025 09:51:26 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65ebc4d552sm1415803166b.80.2025.10.22.09.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 09:51:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 073AF5F7A0;
 Wed, 22 Oct 2025 17:51:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: linux-pci@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@linaro.org>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Bjorn Helgaas <bhelgaas@google.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, D Scott Phillips
 <scott@os.amperecomputing.com>
Subject: 2499f53 (PCI: Rework optional resource handling) regression with
 AMDGPU on Arm AVA platform
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Wed, 22 Oct 2025 17:51:24 +0100
Message-ID: <874irqop6b.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 23 Oct 2025 07:51:01 +0000
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


Hi,

I've been tracking a regression on my Arm64 (Altra) AVA platform between
6.14 and 6.15. It looks like the rework commit broke the ability of the
amdgpu driver to resize it's bar, resulting in an SError and failure to
boot:

  [   15.348097] amdgpu 000d:03:00.0: amdgpu: detected ip block number 8 <v=
cn_v4_0>
  [   15.355901] amdgpu 000d:03:00.0: amdgpu: detected ip block number 9 <j=
peg_v4_0>
  [   15.363202] amdgpu 000d:03:00.0: amdgpu: detected ip block number 10 <=
mes_v11_0>
  [   15.384163] amdgpu 000d:03:00.0: amdgpu: Fetched VBIOS from ROM BAR
  [   15.390434] amdgpu: ATOM BIOS: 113-4481LHS-UC1
  [   15.400079] amdgpu 000d:03:00.0: amdgpu: CP RS64 enable
  [   15.411830] amdgpu 000d:03:00.0: amdgpu: Trusted Memory Zone (TMZ) fea=
ture not supported
  [   15.419932] amdgpu 000d:03:00.0: amdgpu: PCIE atomic ops is not suppor=
ted
  [   15.426719] [drm] GPU posting now...
  [   15.430329] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit,=
 fragment size is 9-bit
  [   15.438871] amdgpu 000d:03:00.0: BAR 2 [mem 0x340010000000-0x3400101ff=
fff 64bit pref]: releasing
  [   15.447648] amdgpu 000d:03:00.0: BAR 0 [mem 0x340000000000-0x34000ffff=
fff 64bit pref]: releasing
  [   15.456452] pcieport 000d:02:00.0: bridge window [mem 0x340000000000-0=
x340017ffffff 64bit pref]: releasing
  [   15.466095] pcieport 000d:01:00.0: bridge window [mem 0x340000000000-0=
x340017ffffff 64bit pref]: releasing
  [   15.475738] pcieport 000d:00:01.0: bridge window [mem 0x340000000000-0=
x340017ffffff 64bit pref]: releasing
  [   15.485386] pcieport 000d:00:01.0: bridge window [io  0x1000-0x0fff] t=
o [bus 01-03] add_size 1000
  [   15.494252] pcieport 000d:00:01.0: bridge window [mem 0x340000000000-0=
x3402ffffffff 64bit pref]: assigned
  [   15.503809] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: ca=
n't assign; no space
  [   15.512063] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: fa=
iled to assign
  [   15.519796] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: ca=
n't assign; no space
  [   15.528049] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: fa=
iled to assign
  [   15.535787] pcieport 000d:01:00.0: bridge window [mem 0x340000000000-0=
x3402ffffffff 64bit pref]: assigned
  [   15.545349] pcieport 000d:02:00.0: bridge window [mem 0x340000000000-0=
x3402ffffffff 64bit pref]: assigned
  [   15.554911] amdgpu 000d:03:00.0: BAR 0 [mem 0x340000000000-0x3401fffff=
fff 64bit pref]: assigned
  [   15.563612] amdgpu 000d:03:00.0: BAR 2 [mem 0x340200000000-0x3402001ff=
fff 64bit pref]: assigned
  [   15.572313] pcieport 000d:00:01.0: PCI bridge to [bus 01-03]
  [   15.577962] pcieport 000d:00:01.0:   bridge window [mem 0x50000000-0x5=
02fffff]
  [   15.585175] pcieport 000d:00:01.0:   bridge window [mem 0x340000000000=
-0x3402ffffffff 64bit pref]
  [   15.594038] pcieport 000d:00:01.0: bridge window [mem 0x340000000000-0=
x340017ffffff 64bit pref]: can't claim; address conflict with PCI Bus 000d:=
01 [mem 0x340000000000-0x3
  40017ffffff 64bit pref]

Failure to claim space for the bridge window...

  [   15.611321] pcieport 000d:00:01.0: PCI bridge to [bus 01-03]
  [   15.616971] pcieport 000d:00:01.0:   bridge window [io  size 0x1000]
  [   15.623315] pcieport 000d:00:01.0:   bridge window [mem 0x50000000-0x5=
02fffff]
  [   15.630527] pcieport 000d:00:01.0:   bridge window [mem size 0x1800000=
0 64bit pref]
  [   15.638174] pcieport 000d:01:00.0: bridge window [mem 0x340000000000-0=
x340017ffffff 64bit pref]: can't claim; no compatible bridge window
  [   15.650508] pcieport 000d:01:00.0: PCI bridge to [bus 02-03]
  [   15.656164] pcieport 000d:01:00.0:   bridge window [mem 0x50000000-0x5=
01fffff]
  [   15.663381] pcieport 000d:01:00.0:   bridge window [mem size 0x1800000=
0 64bit pref]
  [   15.671036] pcieport 000d:02:00.0: bridge window [mem 0x340000000000-0=
x340017ffffff 64bit pref]: can't claim; no compatible bridge window
  [   15.683370] pcieport 000d:02:00.0: PCI bridge to [bus 03]
  [   15.688764] pcieport 000d:02:00.0:   bridge window [mem 0x50000000-0x5=
01fffff]
  [   15.695982] pcieport 000d:02:00.0:   bridge window [mem size 0x1800000=
0 64bit pref]
  [   15.703643] [drm] Not enough PCI address space for a large BAR.

Realisation not enough space for the BAR

  [   15.703648] amdgpu 000d:03:00.0: amdgpu: VRAM: 8176M 0x000000800000000=
0 - 0x00000081FEFFFFFF (8176M used)
  [   15.719119] amdgpu 000d:03:00.0: amdgpu: GART: 512M 0x00007FFF00000000=
 - 0x00007FFF1FFFFFFF
  [   15.727470] [drm] Detected VRAM RAM=3D8176M, BAR=3D256M
  [   15.732339] [drm] RAM width 128bits GDDR6
  [   15.736552] [drm] amdgpu: 8176M of VRAM memory ready
  [   15.741516] [drm] amdgpu: 15888M of GTT memory ready.
  [   15.746592] [drm] GART: num cpu pages 131072, num gpu pages 131072
  [   15.752862] [drm] PCIE GART of 512M enabled (table at 0x00000080000000=
00).
  [   15.850408] [drm] Loading DMUB firmware via PSP: version=3D0x07002D00
  [   16.128604] [drm] Found VCN firmware Version ENC: 1.23 DEC: 9 VEP: 0 R=
evision: 16
  [   16.446347] SError Interrupt on CPU3, code 0x00000000be000411 -- SError
  [   16.446354] CPU: 3 UID: 0 PID: 11 Comm: kworker/u128:0 Tainted: G     =
U             6.14.0-rc1-ajb-debian-bisect-00027-g2499f5348431-dirty #68
  [   16.446359] Tainted: [U]=3DUSER
  [   16.446360] Hardware name: ADLINK AVA Developer Platform/AVA Developer=
 Platform, BIOS TianoCore 2.04.100.07 (SYS: 2.06.20220308) 09/08/2022
  [   16.446362] Workqueue: efi_rts_wq efi_call_rts
  [   16.446371] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
  [   16.446374] pc : __wake_up_common_lock+0x40/0xc0
  [   16.446379] lr : __wake_up+0x20/0x40
  [   16.446382] sp : ffff800080aa3790
  [   16.446383] x29: ffff800080aa3790 x28: ffff3e8780bcb780 x27: 00000000f=
a481000
  [   16.446387] x26: ffff3e87a7e14b98 x25: ffffb6df6e1e2978 x24: ffffb6df6=
e351ed8
  [   16.446390] x23: ffff3e87a7e10000 x22: 00000000000000c0 x21: 000000000=
0000003
  [   16.446392] x20: 0000000000000000 x19: ffff3e87a7e14b98 x18: 000000000=
0000000
  [   16.446395] x17: ffff3e878245d180 x16: ffffb6dfa26e0c28 x15: ffff3e878=
10bcbc0
  [   16.446398] x14: 00000000fa481758 x13: 0000000000000000 x12: ffff80008=
0aa3dd7
  [   16.446401] x11: 0000000000000040 x10: ffff3e87801ba830 x9 : ffffb6dfa=
26e0c48
  [   16.446403] x8 : ffff3e8786eb5268 x7 : 0000000000000000 x6 : 000000000=
0000000
  [   16.446406] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 000000000=
0000000
  [   16.446408] x2 : 0000000000000000 x1 : 0000000000000003 x0 : 000000000=
0000001
  [   16.446412] Kernel panic - not syncing: Asynchronous SError Interrupt

Boom - unrecoverable bus error triggered by the PCI access.

  [   16.446414] CPU: 3 UID: 0 PID: 11 Comm: kworker/u128:0 Tainted: G     =
U             6.14.0-rc1-ajb-debian-bisect-00027-g2499f5348431-dirty #68
  [   16.446417] Tainted: [U]=3DUSER
  [   16.446418] Hardware name: ADLINK AVA Developer Platform/AVA Developer=
 Platform, BIOS TianoCore 2.04.100.07 (SYS: 2.06.20220308) 09/08/2022
  [   16.446419] Workqueue: efi_rts_wq efi_call_rts
  [   16.446424] Call trace:
  [   16.446425]  show_stack+0x34/0x98 (C)
  [   16.446431]  dump_stack_lvl+0x60/0x80
  [   16.446436]  dump_stack+0x18/0x24
  [   16.446440]  panic+0x164/0x378
  [   16.446443]  nmi_panic+0x90/0x98
  [   16.446448]  arm64_serror_panic+0x6c/0x80
  [   16.446452]  do_serror+0x30/0x78
  [   16.446456]  el1h_64_error_handler+0x30/0x50
  [   16.446462]  el1h_64_error+0x6c/0x70
  [   16.446464]  __wake_up_common_lock+0x40/0xc0 (P)
  [   16.446468]  __wake_up+0x20/0x40
  [   16.446471]  amdgpu_ih_process+0x100/0x160 [amdgpu]
  [   16.447083]  amdgpu_irq_handler+0x34/0xa0 [amdgpu]
  [   16.447637]  __handle_irq_event_percpu+0x60/0x1d8
  [   16.447642]  handle_irq_event+0x4c/0x110
  [   16.447646]  handle_fasteoi_irq+0xb4/0x220
  [   16.447649]  handle_irq_desc+0x3c/0x68
  [   16.447652]  generic_handle_domain_irq+0x24/0x40
  [   16.447656]  gic_handle_irq+0x54/0x124
  [   16.447658]  do_interrupt_handler+0x58/0xa0
  [   16.447661]  el1_interrupt+0x34/0x58
  [   16.447665]  el1h_64_irq_handler+0x18/0x28
  [   16.447669]  el1h_64_irq+0x6c/0x70
  [   16.447672]  0xfad10918 (P)
  [   16.447674]  0xfabe01c8
  [   16.447676]  0xfabe02d4
  [   16.447677]  0xfa3e209c
  [   16.447679]  0xfa43ae7c
  [   16.447680]  0xfa43b6bc
  [   16.447681]  0xfa436e44
  [   16.447683]  0xfa43c3f8
  [   16.447684]  __efi_rt_asm_wrapper+0x50/0x78
  [   16.447687]  efi_call_rts+0x1c8/0x280
  [   16.447691]  process_one_work+0x178/0x3e0
  [   16.447695]  worker_thread+0x204/0x3f0
  [   16.447698]  kthread+0x10c/0x1f0
  [   16.447703]  ret_from_fork+0x10/0x20
  [   16.447705] SMP: stopping secondary CPUs
  [   16.447796] Kernel Offset: 0x36df225a0000 from 0xffff800080000000
  [   16.447798] PHYS_OFFSET: 0xffffc97880000000
  [   16.447799] CPU features: 0x200,00002170,00901250,8241720b
  [   16.447802] Memory Limit: none
  [   16.471034] pstore: backend (efi_pstore) writing error (-16)
  [   16.801136] ---[ end Kernel panic - not syncing: Asynchronous SError I=
nterrupt ]---

The bisection was slightly complicated by the fact I'm carrying some
additional patches to work around other PCIe issues which however work
find before the failing commit. For convenience I've pushed a branch with t=
he work
around applied here:

  https://gitlab.com/stsquad/linux/-/commits/testing/pci-amdgpu-regression-=
reference

Additional information

lspci -vv info for card

  000d:03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD=
/ATI] Navi 33 [Radeon RX 7600/7600 XT/7600M XT/7600S/7700S / PRO W7600] (re=
v cf) (prog-if 00 [VGA controller])
          Subsystem: Sapphire Technology Limited Device e448
          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+
          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
          Latency: 0
          Interrupt: pin A routed to IRQ 151
          NUMA node: 0
          IOMMU group: 21
          Region 0: Memory at 340000000000 (64-bit, prefetchable) [size=3D8=
G]
          Region 2: Memory at 340200000000 (64-bit, prefetchable) [size=3D2=
M]
          Region 5: Memory at 50000000 (32-bit, non-prefetchable) [size=3D1=
M]
          Expansion ROM at 50100000 [disabled] [size=3D128K]
          Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
          Capabilities: [50] Power Management version 3
                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1+,=
D2+,D3hot+,D3cold+)
                  Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
          Capabilities: [64] Express (v2) Legacy Endpoint, IntMsgNum 0
                  DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4=
us, L1 unlimited
                          ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- T=
EE-IO-
                  DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                          MaxPayload 128 bytes, MaxReadReq 512 bytes
                  DevSta:	CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-=
 TransPend-
                  LnkCap:	Port #0, Speed 16GT/s, Width x8, ASPM L1, Exit La=
tency L1 <1us
                          ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                  LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                  LnkSta:	Speed 16GT/s, Width x8
                          TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                  DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROP=
rPrP- LTR+
                           10BitTagComp+ 10BitTagReq+ OBFF Not Supported, E=
xtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
                           EmergencyPowerReduction Form Factor Dev Specific=
, EmergencyPowerReductionInit-
                           FRS-
                           AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
                  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                           AtomicOpsCtl: ReqEn-
                           IDOReq- IDOCompl- LTR- EmergencyPowerReductionRe=
q-
                           10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                  LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Re=
timer+ 2Retimers+ DRS-
                  LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- Spee=
dDis-
                           Transmit Margin: Normal Operating Range, EnterMo=
difiedCompliance- ComplianceSOS-
                           Compliance Preset/De-emphasis: -6dB de-emphasis,=
 0dB preshoot
                  LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationC=
omplete+ EqualizationPhase1+
                           EqualizationPhase2+ EqualizationPhase3+ LinkEqua=
lizationRequest-
                           Retimer- 2Retimers- CrosslinkRes: unsupported
          Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                  Address: 00000000ffb77040  Data: 0000
          Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=
=3D1 Len=3D010 <?>
          Capabilities: [150 v2] Advanced Error Reporting
                  UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-=
 RxOF- MalfTLP-
                          ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP=
- AtomicOpBlocked- TLPBlockedErr-
                          PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisID=
ETLP- PCRC_CHECK- TLPXlatBlocked-
                  UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-=
 RxOF- MalfTLP-
                          ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP=
- AtomicOpBlocked- TLPBlockedErr-
                          PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisID=
ETLP- PCRC_CHECK- TLPXlatBlocked-
                  UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF+ MalfTLP+
                          ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP=
- AtomicOpBlocked- TLPBlockedErr-
                          PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisID=
ETLP- PCRC_CHECK- TLPXlatBlocked-
                  CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonF=
atalErr+ CorrIntErr- HeaderOF-
                  CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonF=
atalErr+ CorrIntErr- HeaderOF-
                  AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- E=
CRCChkCap+ ECRCChkEn-
                          MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCa=
p-
                  HeaderLog: 00000000 00000000 00000000 00000000
          Capabilities: [200 v1] Physical Resizable BAR
                  BAR 0: current size: 8GB, supported: 256MB 512MB 1GB 2GB =
4GB 8GB
                  BAR 2: current size: 2MB, supported: 2MB 4MB 8MB 16MB 32M=
B 64MB 128MB 256MB
          Capabilities: [240 v1] Power Budgeting <?>
          Capabilities: [270 v1] Secondary PCI Express
                  LnkCtl3: LnkEquIntrruptEn- PerformEqu-
                  LaneErrStat: 0
          Capabilities: [2a0 v1] Access Control Services
                  ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- Upstrea=
mFwd- EgressCtrl- DirectTrans-
                  ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- Upstrea=
mFwd- EgressCtrl- DirectTrans-
          Capabilities: [2d0 v1] Process Address Space ID (PASID)
                  PASIDCap: Exec+ Priv+, Max PASID Width: 10
                  PASIDCtl: Enable+ Exec+ Priv+
          Capabilities: [320 v1] Latency Tolerance Reporting
                  Max snoop latency: 0ns
                  Max no snoop latency: 0ns
          Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
          Capabilities: [450 v1] Lane Margining at the Receiver
                  PortCap: Uses Driver-
                  PortSta: MargReady+ MargSoftReady-
          Kernel driver in use: amdgpu
          Kernel modules: amdgpu

iomem layout from a working bootup (e89df6d2beae):

  08000000-0fffffff : PCI Bus 0002:00
    08000000-081fffff : PCI Bus 0002:01
    08200000-083fffff : PCI Bus 0002:02
  20000000-2fffffff : PCI Bus 0004:00
    20000000-217fffff : PCI Bus 0004:01
      20000000-217fffff : PCI Bus 0004:02
        20000000-20ffffff : 0004:02:00.0
          20000000-202fffff : efifb
        21000000-2101ffff : 0004:02:00.0
    21800000-219fffff : PCI Bus 0004:03
      21800000-21801fff : 0004:03:00.0
        21800000-21801fff : xhci-hcd
    21a00000-21bfffff : PCI Bus 0004:04
      21a00000-21a7ffff : 0004:04:00.0
        21a00000-21a7ffff : igb
      21a80000-21a83fff : 0004:04:00.0
        21a80000-21a83fff : igb
    21c00000-21dfffff : PCI Bus 0004:05
  30000000-3fffffff : PCI Bus 0005:00
    30000000-301fffff : PCI Bus 0005:01
    30200000-303fffff : PCI Bus 0005:02
    30400000-305fffff : PCI Bus 0005:03
      30400000-30403fff : 0005:03:00.0
        30400000-30403fff : nvme
    30600000-307fffff : PCI Bus 0005:04
      30600000-30603fff : 0005:04:00.0
        30600000-30603fff : nvme
  40000000-4fffffff : PCI Bus 000c:00
    40000000-401fffff : PCI Bus 000c:01
  50000000-5fffffff : PCI Bus 000d:00
    50000000-502fffff : PCI Bus 000d:01
      50000000-501fffff : PCI Bus 000d:02
        50000000-501fffff : PCI Bus 000d:03
          50000000-500fffff : 000d:03:00.0
          50100000-5011ffff : 000d:03:00.0
          50120000-50123fff : 000d:03:00.1
            50120000-50123fff : ICH HD audio
      50200000-50203fff : 000d:01:00.0
  70000000-7fffffff : PCI Bus 0000:00
    70000000-701fffff : PCI Bus 0000:01
  88300000-883fffff : reserved
  88500000-885fffff : IFX0785:00
    88500000-885fffff : IFX0785:00
  88900000-8891ffff : AMPC0005:00
  90000000-91ffffff : System RAM
  92000000-927bffff : reserved
  927c0000-f896ffff : System RAM
    d54f0000-d6adffff : Kernel code
    d6ae0000-d6daffff : reserved
    d6db0000-d717ffff : Kernel data
    ef650000-f3650fff : reserved
    f3850000-f49a2fff : reserved
    f88b0000-f88bffff : reserved
  f8970000-f898ffff : reserved
  f8990000-f899ffff : System RAM
  f89a0000-f89fffff : reserved
  f8a00000-f9196fff : System RAM
    f8a00000-f8a00fff : reserved
    f8a02000-f8a02fff : reserved
  f9197000-f91ecfff : reserved
  f91ed000-f94cffff : System RAM
    f91fb000-f91fbfff : reserved
  f94d0000-f950ffff : reserved
  f9510000-f98bffff : System RAM
  f98c0000-f98fffff : reserved
  f9900000-f999ffff : System RAM
  f99a0000-f99dffff : reserved
  f99e0000-f9f4ffff : System RAM
    f9ef0000-f9f1ffff : reserved
  f9f50000-f9f6ffff : reserved
  f9f70000-fa0affff : System RAM
  fa0b0000-fa0effff : reserved
  fa0f0000-fa1cffff : System RAM
  fa1d0000-fa26ffff : reserved
  fa270000-fa33ffff : System RAM
  fa340000-fa4affff : reserved
  fa4b0000-fa4bffff : System RAM
  fa4c0000-fa57ffff : reserved
  fa580000-fa72ffff : System RAM
  fa730000-fa7cffff : reserved
  fa7d0000-faa4ffff : System RAM
  faa50000-faaeffff : reserved
  faaf0000-fab7ffff : System RAM
  fab80000-fac1ffff : reserved
  fac20000-facaffff : System RAM
  facb0000-fad4ffff : reserved
  fad50000-fae1ffff : System RAM
  fae20000-faebffff : reserved
  faec0000-faf4ffff : System RAM
  faf50000-fafeffff : reserved
  faff0000-ffefffff : System RAM
    fbe00000-ffdfffff : reserved
  fff00000-fff4ffff : reserved
  fff50000-fffaffff : System RAM
  fffb0000-fffdffff : reserved
    fffc0000-fffc0fff : reserved
  fffe0000-ffffffff : System RAM
    fffe0000-fffeffff : reserved
  80000000000-8007fffffff : System RAM
    800002bc000-800002bcfff : reserved
    80000840000-8000084ffff : reserved
    80000850000-8000085ffff : reserved
    80000860000-8000086ffff : reserved
    80000870000-8000087ffff : reserved
    80000880000-8000088ffff : reserved
    80000890000-8000089ffff : reserved
    800008a0000-800008affff : reserved
    800008b0000-800008bffff : reserved
    800008c0000-800008cffff : reserved
    800008d0000-800008dffff : reserved
    800008e0000-800008effff : reserved
    800008f0000-800008fffff : reserved
    80000900000-8000090ffff : reserved
    80000910000-8000091ffff : reserved
    80000920000-8000092ffff : reserved
    80000930000-8000093ffff : reserved
    80000940000-8000094ffff : reserved
    80000950000-8000095ffff : reserved
    80000960000-8000096ffff : reserved
    80000970000-8000097ffff : reserved
    80000980000-8000098ffff : reserved
    80000990000-8000099ffff : reserved
    800009a0000-800009affff : reserved
    800009b0000-800009bffff : reserved
    800009c0000-800009cffff : reserved
    800009d0000-800009dffff : reserved
    800009e0000-800009effff : reserved
    800009f0000-800009fffff : reserved
    80000a00000-80000a0ffff : reserved
    80000a10000-80000a1ffff : reserved
    80000a20000-80000a2ffff : reserved
    80000a30000-80000a3ffff : reserved
    80000a40000-80000a4ffff : reserved
  80100000000-807ffffffff : System RAM
    807d8c10000-807fbffffff : reserved
    807fc009000-807fc039fff : reserved
    807fc03c000-807fc03ffff : reserved
    807fc040000-807fc040fff : reserved
    807fc041000-807fc044fff : reserved
    807fc045000-807fc06afff : reserved
    807fc06b000-807ffffffff : reserved
  100002600000-100002600fff : ARMH0011:00
    100002600000-100002600fff : ARMH0011:00 ARMH0011:00
  100002620000-100002620fff : ARMH0011:01
    100002620000-100002620fff : ARMH0011:01 ARMH0011:01
  1000026c0000-1000026cffff : APMC0D0F:00
    1000026c0000-1000026cffff : APMC0D0F:00 APMC0D0F:00
  1000026d0000-1000026dffff : APMC0D07:02
  1000026f0000-1000026fffff : APMC0D07:00
  100002730000-100002730fff : arch_mem_timer
  100002750000-10000275ffff : APMC0D0F:01
    100002750000-10000275ffff : APMC0D0F:01 APMC0D0F:01
  100002780000-10000278ffff : APMC0D0F:02
    100002780000-10000278ffff : APMC0D0F:02 APMC0D0F:02
  1000027b0000-1000027bffff : APMC0D07:01
  1000027c0000-1000027c0fff : sbsa-gwdt.0
    1000027c0000-1000027c0fff : sbsa-gwdt.0 sbsa-gwdt.0
  1000027d0000-1000027d0fff : sbsa-gwdt.0
    1000027d0000-1000027d0fff : sbsa-gwdt.0 sbsa-gwdt.0
  100010000000-10001fffffff : ARMHC600:00
    100012500000-1000164fffff : ARMHC600:00
  10008c000a00-10008c000bff : ARMHD620:00
  10008d000a00-10008d000bff : ARMHD620:04
  100100000000-10010000ffff : GICD
  100100140000-10010113ffff : GICR
  200000000000-23ffdfffffff : PCI Bus 0002:00
    200000000000-2000001fffff : PCI Bus 0002:01
    200000200000-2000003fffff : PCI Bus 0002:02
  23ffe0000000-23ffe001ffff : arm-smmu-v3.3.auto
    23ffe0000000-23ffe0000dff : arm-smmu-v3.3.auto
    23ffe0010000-23ffe0010dff : arm-smmu-v3.3.auto
  23fff0000000-23ffffffffff : PCI ECAM
  27fff0000000-27ffffffffff : pnp 00:00
  280000000000-2bffdfffffff : PCI Bus 0004:00
    280000000000-2800001fffff : PCI Bus 0004:01
    280000200000-2800003fffff : PCI Bus 0004:03
    280000400000-2800005fffff : PCI Bus 0004:04
    280000600000-2800007fffff : PCI Bus 0004:05
  2bffe0000000-2bffe001ffff : arm-smmu-v3.4.auto
    2bffe0000000-2bffe0000dff : arm-smmu-v3.4.auto
    2bffe0010000-2bffe0010dff : arm-smmu-v3.4.auto
  2bfff0000000-2bffffffffff : PCI ECAM
  2c0000000000-2fffdfffffff : PCI Bus 0005:00
    2c0000000000-2c00001fffff : PCI Bus 0005:01
    2c0000200000-2c00003fffff : PCI Bus 0005:02
    2c0000400000-2c00005fffff : PCI Bus 0005:03
    2c0000600000-2c00007fffff : PCI Bus 0005:04
  2fffe0000000-2fffe001ffff : arm-smmu-v3.5.auto
    2fffe0000000-2fffe0000dff : arm-smmu-v3.5.auto
    2fffe0010000-2fffe0010dff : arm-smmu-v3.5.auto
  2ffff0000000-2fffffffffff : PCI ECAM
  300000000000-33ffdfffffff : PCI Bus 000c:00
    300000000000-3000001fffff : PCI Bus 000c:01
  33ffe0000000-33ffe001ffff : arm-smmu-v3.0.auto
    33ffe0000000-33ffe0000dff : arm-smmu-v3.0.auto
    33ffe0010000-33ffe0010dff : arm-smmu-v3.0.auto
  33fff0000000-33ffffffffff : PCI ECAM
  340000000000-37ffdfffffff : PCI Bus 000d:00
    340000000000-3402ffffffff : PCI Bus 000d:01
      340000000000-3402ffffffff : PCI Bus 000d:02
        340000000000-3402ffffffff : PCI Bus 000d:03
          340000000000-3401ffffffff : 000d:03:00.0
          340200000000-3402001fffff : 000d:03:00.0
  37ffe0000000-37ffe001ffff : arm-smmu-v3.1.auto
    37ffe0000000-37ffe0000dff : arm-smmu-v3.1.auto
    37ffe0010000-37ffe0010dff : arm-smmu-v3.1.auto
  37fff0000000-37ffffffffff : PCI ECAM
  3bfff0000000-3bffffffffff : pnp 00:00
  3c0000000000-3fffdfffffff : PCI Bus 0000:00
    3c0000000000-3c00001fffff : PCI Bus 0000:01
  3fffe0000000-3fffe001ffff : arm-smmu-v3.2.auto
    3fffe0000000-3fffe0000dff : arm-smmu-v3.2.auto
    3fffe0010000-3fffe0010dff : arm-smmu-v3.2.auto
  3ffff0000000-3fffffffffff : PCI ECAM
  63fff0000000-63ffffffffff : pnp 00:00
  67fff0000000-67ffffffffff : pnp 00:00
  6bfff0000000-6bffffffffff : pnp 00:00
  6ffff0000000-6fffffffffff : pnp 00:00
  7bfff0000000-7bffffffffff : pnp 00:00
  7ffff0000000-7fffffffffff : pnp 00:00

working dmesg from same:

  [   15.500492] [drm] GPU posting now...
  [   15.504110] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit,=
 fragment size is 9-bit
  [   15.512654] amdgpu 000d:03:00.0: BAR 2 [mem 0x340010000000-0x3400101ff=
fff 64bit pref]: releasing
  [   15.521431] amdgpu 000d:03:00.0: BAR 0 [mem 0x340000000000-0x34000ffff=
fff 64bit pref]: releasing
  [   15.530230] pcieport 000d:02:00.0: bridge window [mem 0x340000000000-0=
x340017ffffff 64bit pref]: releasing
  [   15.539881] pcieport 000d:01:00.0: bridge window [mem 0x340000000000-0=
x340017ffffff 64bit pref]: releasing
  [   15.549528] pcieport 000d:00:01.0: bridge window [mem 0x340000000000-0=
x340017ffffff 64bit pref]: releasing
  [   15.549535] pcieport 000d:00:01.0: bridge window [io  0x1000-0x0fff] t=
o [bus 01-03] add_size 1000
  [   15.549544] pcieport 000d:00:01.0: bridge window [mem 0x340000000000-0=
x3402ffffffff 64bit pref]: assigned
  [   15.549546] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: ca=
n't assign; no space
  [   15.549549] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: fa=
iled to assign
  [   15.596468] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: ca=
n't assign; no space
  [   15.607594] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: fa=
iled to assign
  [   15.618090] pcieport 000d:00:01.0: bridge window [io  size 0x1000]: ig=
noring failure in optional allocation
  [   15.618095] pcieport 000d:01:00.0: bridge window [mem 0x340000000000-0=
x3402ffffffff 64bit pref]: assigned
  [   15.628249] pcieport 000d:02:00.0: bridge window [mem 0x340000000000-0=
x3402ffffffff 64bit pref]: assigned
  [   15.637806] amdgpu 000d:03:00.0: BAR 0 [mem 0x340000000000-0x3401fffff=
fff 64bit pref]: assigned
  [   15.646506] amdgpu 000d:03:00.0: BAR 2 [mem 0x340200000000-0x3402001ff=
fff 64bit pref]: assigned
  [   15.655205] pcieport 000d:00:01.0: PCI bridge to [bus 01-03]
  [   15.660856] pcieport 000d:00:01.0:   bridge window [mem 0x50000000-0x5=
02fffff]
  [   15.668069] pcieport 000d:00:01.0:   bridge window [mem 0x340000000000=
-0x3402ffffffff 64bit pref]
  [   15.676931] pcieport 000d:01:00.0: PCI bridge to [bus 02-03]
  [   15.682586] pcieport 000d:01:00.0:   bridge window [mem 0x50000000-0x5=
01fffff]
  [   15.689804] pcieport 000d:01:00.0:   bridge window [mem 0x340000000000=
-0x3402ffffffff 64bit pref]
  [   15.698672] pcieport 000d:02:00.0: PCI bridge to [bus 03]
  [   15.704067] pcieport 000d:02:00.0:   bridge window [mem 0x50000000-0x5=
01fffff]
  [   15.711285] pcieport 000d:02:00.0:   bridge window [mem 0x340000000000=
-0x3402ffffffff 64bit pref]
  [   15.720157] amdgpu 000d:03:00.0: amdgpu: VRAM: 8176M 0x000000800000000=
0 - 0x00000081FEFFFFFF (8176M used)
  [   15.729714] amdgpu 000d:03:00.0: amdgpu: GART: 512M 0x00007FFF00000000=
 - 0x00007FFF1FFFFFFF
  [   15.738064] [drm] Detected VRAM RAM=3D8176M, BAR=3D8192M
  [   15.743019] [drm] RAM width 128bits GDDR6
  [   15.747258] [drm] amdgpu: 8176M of VRAM memory ready
  [   15.752219] [drm] amdgpu: 15888M of GTT memory ready.
  [   15.757297] [drm] GART: num cpu pages 131072, num gpu pages 131072
  [   15.763558] [drm] PCIE GART of 512M enabled (table at 0x00000081FEB000=
00).
  [   15.884845] [drm] Loading DMUB firmware via PSP: version=3D0x07002D00
  [   16.129125] [drm] Found VCN firmware Version ENC: 1.23 DEC: 9 VEP: 0 R=
evision: 16

From discussions with Ard it seems if the firmware had resized the BAR firs=
t,
and then assigned the resources, there would be no issue. However there
is no latter firmware for the platform.

While the PCI change has provoked this regression I suspect the amdgpu code
could handle the failure to resize the BAR better and if it can't get
what it wants just not initialise the driver. I did hit some cases while
bisecting where the GPU just wasn't visible.

I'm available to test patches and generate additional debug info so do
let me know if there is anything I can do to help.

Thanks,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
