Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C85C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 14:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251C060F9B
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 14:15:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 251C060F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25E089CAF;
	Mon, 25 Oct 2021 14:15:55 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2C889CAF
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 14:15:53 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id y207so15711171oia.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PLTXm2S2POkvD5tyEiqE0nGXpIC5w7Vwb7IsWqWfVk8=;
 b=Q4JUFJW7EsZRTkt6V0iSB/X81368nZMj4xVFJR6M96QHLufh/vE2N5wR3Ub/5ugWo/
 7CnLwITo9lWrYaKDeGAnno2sNSkF8MCyJn88QgU1oZdnXoVgK2WnxeVC0SI4h38HGQVX
 oMea/Cnhwf/IwR2Qx+0FPqtUWDhRqTKzV4bUpKUaVIx8esskR5J2rw0metK5cU4aV7A2
 Z+A9zPXXLuj2XJWgCflS1shx8FgPvg7jDbJLRIL+Avo6tkKS6aVkxe+TT7l34ftgY7cf
 zoqje3IrH+8pjiAsP3FgcNpcYmt8Qek2QyrKDxD6bSCNfytNbZ4LeJXiTiBX7kH5tXRe
 jb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PLTXm2S2POkvD5tyEiqE0nGXpIC5w7Vwb7IsWqWfVk8=;
 b=Gc9gtSUN42xYx/79o/0kzjQROEHuQN/q+Nf5C1/NiQjlZNagkN4W9P5nonYBuz2glP
 I1qINEk2OcBE9n48X1OMJcMZoUL18o2/LFKzKSNp0qvLJht7i7UFM5HC3Z0Qjte4kcn0
 O/CPEILEg987/eO/nAB/i/oO1LrGsp04wj+HcKWkGbHA3rO0RUIWbynKBUZDJL7XhI/t
 C4Fzne9Jdg322Dc/NponUiQj4ya8V41av2DsSpokfwgr6Zj2GFeveiSJ3XTsmB8PZaIG
 IYdIhlN1weOZkj8/GegfKoNt2fpBHLOgR/xcGyvS6fwfQqZBcIzrMbOthxxYvvdeKszp
 VP1w==
X-Gm-Message-State: AOAM531Q2MZwKmDuceMmnnZs7lIBXH2CU0I90eIVNvs78NO/LjeVA+lL
 X2uy0HSdXljpXXMewtIrCbheOWSW9xlfUnOrZtBbSA+4ctG7Bw==
X-Google-Smtp-Source: ABdhPJzJszoloYN2r/5EqBLPy+Po113x4touyd2Cm2C2ekAg+OpS04KxGU8aRluPVgZr8ZVKIECb57qmLDGdhycXFBU=
X-Received: by 2002:a05:6808:1527:: with SMTP id
 u39mr12142130oiw.123.1635171352806; 
 Mon, 25 Oct 2021 07:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <b4adea1b-9a21-75d2-7ee7-25d4f28ef6f8@gmail.com>
 <2303555f-42cd-180c-7a67-1d104bceea7d@gmail.com>
In-Reply-To: <2303555f-42cd-180c-7a67-1d104bceea7d@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Oct 2021 10:15:41 -0400
Message-ID: <CADnq5_PsKDreYH0aNNzfR_TbfMMsfVK=-hCCB0ThZ0PzcLPCpw@mail.gmail.com>
Subject: Re: amdgpu "Fatal error during GPU init"; Ryzen 5600G integrated GPU
 + kernel 5.14.13
To: PGNet Dev <pgnet.dev@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 25, 2021 at 9:48 AM PGNet Dev <pgnet.dev@gmail.com> wrote:
>
> ( cc'ing this here, OP -> dri-devel@ )
>
> i've a dual gpu system
>
>         inxi -GS
>                 System:    Host: ws05 Kernel: 5.14.13-200.fc34.x86_64 x86=
_64 bits: 64 Console: tty pts/0
>                            Distro: Fedora release 34 (Thirty Four)
> (1)             Graphics:  Device-1: NVIDIA GK208B [GeForce GT 710] drive=
r: nvidia v: 470.74
> (2)                        Device-2: Advanced Micro Devices [AMD/ATI] Cez=
anne driver: N/A
>                            Display: server: X.org 1.20.11 driver: loaded:=
 nvidia unloaded: fbdev,modesetting,vesa
>                            Message: Advanced graphics data unavailable fo=
r root.
>
> running on
>
>         cpu:    Ryzen 5 5600G
>         mobo:   ASRockRack X470D4U
>         bios:   vP4.20, 04/14/2021
>         kernel: 5.14.13-200.fc34.x86_64 x86_64
>
> where,
>
>         the nvidia is a PCIe card
>         the amdgpu is the Ryzen-integrated gpu
>
> the nvidia PCI is currently my primary
> it's screen-attached, and boots/functions correctly
>
>         lsmod | grep nvidia
>                 nvidia_drm             69632  0
>                 nvidia_modeset       1200128  1 nvidia_drm
>                 nvidia              35332096  1 nvidia_modeset
>                 drm_kms_helper        303104  2 amdgpu,nvidia_drm
>                 drm                   630784  8 gpu_sched,drm_kms_helper,=
nvidia,amdgpu,drm_ttm_helper,nvidia_drm,ttm
>
>         dmesg | grep -i nvidia
>                 [    5.755494] nvidia: loading out-of-tree module taints =
kernel.
>                 [    5.755503] nvidia: module license 'NVIDIA' taints ker=
nel.
>                 [    5.759769] nvidia: module verification failed: signat=
ure and/or required key missing - tainting kernel
>                 [    5.774894] nvidia-nvlink: Nvlink Core is being initia=
lized, major device number 234
>                 [    5.775299] nvidia 0000:10:00.0: vgaarb: changed VGA d=
ecodes: olddecodes=3Dio+mem,decodes=3Dnone:owns=3Dio+mem
>                 [    5.975449] NVRM: loading NVIDIA UNIX x86_64 Kernel Mo=
dule  470.74  Mon Sep 13 23:09:15 UTC 2021
>                 [    6.013181] nvidia-modeset: Loading NVIDIA Kernel Mode=
 Setting Driver for UNIX platforms  470.74  Mon Sep 13 22:59:50 UTC 2021
>                 [    6.016444] [drm] [nvidia-drm] [GPU ID 0x00001000] Loa=
ding driver
>                 [    6.227295] caller _nv000723rm+0x1ad/0x200 [nvidia] ma=
pping multiple BARs
>                 [    6.954906] [drm] Initialized nvidia-drm 0.0.0 2016020=
2 for 0000:10:00.0 on minor 0
>                 [   16.820758] input: HDA NVidia HDMI/DP,pcm=3D3 as /devi=
ces/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input13
>                 [   16.820776] input: HDA NVidia HDMI/DP,pcm=3D7 as /devi=
ces/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input14
>                 [   16.820808] input: HDA NVidia HDMI/DP,pcm=3D8 as /devi=
ces/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input15
>                 [   16.820826] input: HDA NVidia HDMI/DP,pcm=3D9 as /devi=
ces/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input16
>                 [   16.820841] input: HDA NVidia HDMI/DP,pcm=3D10 as /dev=
ices/pci0000:00/0000:00:01.1/0000:10:00.1/sound/card0/input17
>
> the amdgpu is not (currently/yet) in use; no attached screen
>
> in BIOS, currently,
>
>         'PCI Express' (nvidia gpu) is selected as primary
>         'HybridGraphics' is enabled
>         'OnBoard VGA' is enabled
>
>
> on boot, mods are loaded
>
>         lsmod | grep gpu
>                 amdgpu               7802880  0
>                 drm_ttm_helper         16384  1 amdgpu
>                 ttm                    81920  2 amdgpu,drm_ttm_helper
>                 iommu_v2               24576  1 amdgpu
>                 gpu_sched              45056  1 amdgpu
>                 drm_kms_helper        303104  2 amdgpu,nvidia_drm
>                 drm                   630784  8 gpu_sched,drm_kms_helper,=
nvidia,amdgpu,drm_ttm_helper,nvidia_drm,ttm
>                 i2c_algo_bit           16384  2 igb,amdgpu
>
> but i see a 'fatal error' and 'failed' probe,
>
>         dmesg | grep -i amdgpu
>                 [    5.161923] [drm] amdgpu kernel modesetting enabled.
>                 [    5.162097] amdgpu: Virtual CRAT table created for CPU
>                 [    5.162104] amdgpu: Topology: Add CPU node
>                 [    5.162197] amdgpu 0000:30:00.0: enabling device (0000=
 -> 0003)
>                 [    5.162232] amdgpu 0000:30:00.0: amdgpu: Trusted Memor=
y Zone (TMZ) feature enabled
>                 [    5.169105] amdgpu 0000:30:00.0: BAR 6: can't assign [=
??? 0x00000000 flags 0x20000000] (bogus alignment)
>                 [    5.174413] amdgpu 0000:30:00.0: amdgpu: Unable to loc=
ate a BIOS ROM
>                 [    5.174415] amdgpu 0000:30:00.0: amdgpu: Fatal error d=
uring GPU init
>                 [    5.174416] amdgpu 0000:30:00.0: amdgpu: amdgpu: finis=
hing device.
>                 [    5.174425] Modules linked in: amdgpu(+) uas usb_stora=
ge fjes(-) raid1 drm_ttm_helper ttm iommu_v2 gpu_sched drm_kms_helper crct1=
0dif_pclmul crc32_pclmul igb crc32c_intel cec ghash_clmulni_intel drm sp510=
0_tco dca ccp i2c_algo_bit wmi video sunrpc tcp_bbr nct6775 hwmon_vid k10te=
mp
>                 [    5.174463]  amdgpu_device_fini_hw+0x33/0x2c5 [amdgpu]
>                 [    5.174594]  amdgpu_driver_load_kms.cold+0x72/0x94 [am=
dgpu]
>                 [    5.174706]  amdgpu_pci_probe+0x110/0x1a0 [amdgpu]
>                 [    5.174907] amdgpu: probe of 0000:30:00.0 failed with =
error -22
>
>
> are specific configs from
>
>         https://www.kernel.org/doc/html/latest/gpu/amdgpu.html
>
> required to avoid/workaround the init error?  or known bug?

The driver is not able to find the vbios image which is required for
the driver to properly enumerate the hardware.  I would guess it's a
platform issue.  Is there a newer sbios image available for your
platform?  You might try that or check if there are any options in the
sbios regarding the behavior of the integrated graphics when an
external GPU is present.  I suspect the one of the following is the
problem:
1. The sbios should disable the integrated graphics when a dGPU is
present, but due to a bug in the sbios or a particular sbios settings
it has failed to.
2. The sbios should be providing a vbios image for the integrated
graphics, but due to a bug in the sbios or a particular sbios settings
it has failed to.
3. The platform uses some alternative method to provide access to the
vbios image for the integrated graphics that Linux does not yet
handle.

I would start with an sbios update is possible.

Alex
