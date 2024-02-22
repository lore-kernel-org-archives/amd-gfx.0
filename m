Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45216C54791
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 08:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60D010E8B2;
	Thu, 22 Feb 2024 08:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yonsei.ac.kr header.i=@yonsei.ac.kr header.b="hg/hzEHr";
	dkim-atps=neutral
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com
 [209.85.219.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91B2610E856
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 02:43:07 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id
 3f1490d57ef6-dc6d8bd612dso1471331276.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 18:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yonsei.ac.kr; s=google; t=1708569787; x=1709174587;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FFIJp1B0TB8aayLEQfLvnSpO5I6y8hCCi4TC8ketN3g=;
 b=hg/hzEHryRMjYYlLkNI33U2PpEd6Ze05W6a0qvL21n3fxItFERAg0NfrjnJS9GglXu
 6f7riV7QlOrQK3LjZxd8X2eyEbEiZ2DBDaii30Z1giL7r0o8Jodc6EBv+ffmO716SUuJ
 8bFD4eQMuvOME6nLEtT0sSU4Xu7ybTW537FVevrWgXV6c43e42PGwfpAbVY60WaAnwrf
 z/tYcUB0PrHyASpmk7coF9WO8rGHaxtzi7kRcl17mYIkWarzWgMr8RDGZmGzSFqFMmxL
 u8Epezx0QHgsXaRPJUndyFiEJbm4TC2XOjm0589Cb12KUePsG9GatD+udEslJO8ctAx9
 euCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708569787; x=1709174587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FFIJp1B0TB8aayLEQfLvnSpO5I6y8hCCi4TC8ketN3g=;
 b=xHeY+vkCo4EVdMILmlX5g6XS76UQmozaKuPy4z8mXynmZVUw9TQ+k8ucogVZV2cUri
 2xUZzeyiQBVLPu7n6JGqrCdj4w+Vsa8fFVfRi8Ym8TAYsj1y0oaoik4OaMMTxyq7if+/
 xBIUaVS+P43DUtWgfAm61o9tSwxj4itvP3K+Fa0E6jQieBj6AZ9u5N+WuvnlNSx+G8Wd
 bpLGNoCbOqy5+n07fGKjxdA/EQAfZd/BK1Mg/XLEiRR92L9CaUnBitphAe6zshHqwsN0
 cWwHQveQMkvCpL76F31QrmfVPOvbIB3EeI4m+xSSkTXKzvlB8r2NVHdzuuQ284Ha2prQ
 gPug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC8M/zcIkvGPKmXvRaksxB4s0DoE1tPQt5+f+BfWfEK8fwIhwoVR1WqfAAkWtGEbHSKye2qh/0heSc6ql7a3lAIILXhmFnU2nDsjDKgQ==
X-Gm-Message-State: AOJu0YzqzhyBE/LVFyHWwBz9JOw8vEemQbBtrihJCZ/hnsVtL33dhRFs
 GRHFmQoqYuR4nuhXf3fQlk+BfpeCGclmf3yD3aXUW3d1qEEmgfldKMBqqfrtcMF7uNSbUErRWez
 +M9E339D8nlXAPCxJa3qBezqik03SPy+U0En67A==
X-Google-Smtp-Source: AGHT+IF4uwSiqojWW2jQV+utMamzo8lO9yIx/jtmWhbR9NTybktCw4DX9YAeu+EIlVKKq3o3FdrdGl+miExgZQuXuXo=
X-Received: by 2002:a5b:8cd:0:b0:dcc:417f:a85c with SMTP id
 w13-20020a5b08cd000000b00dcc417fa85cmr1216640ybq.50.1708569786772; Wed, 21
 Feb 2024 18:43:06 -0800 (PST)
MIME-Version: 1.0
References: <1bc864d4-3495-40ff-a719-abdc1291b638@amd.com>
In-Reply-To: <1bc864d4-3495-40ff-a719-abdc1291b638@amd.com>
From: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
Date: Thu, 22 Feb 2024 11:42:56 +0900
Message-ID: <CAKc8oVVPaPwqvOPewNH1dXsV3KnNXLV=OQqPLC5LxG=FncuhJA@mail.gmail.com>
Subject: Re: Reporting a use-after-free in amdgpu and null-ptr-deref
To: vitaly prosyak <vprosyak@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, dokyungs@yonsei.ac.kr,
 jisoo.jang@yonsei.ac.kr, yw9865@yonsei.ac.kr, Xinhui.Pan@amd.com, 
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000003700540611ef6711"
X-Mailman-Approved-At: Thu, 22 Feb 2024 08:21:54 +0000
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

--0000000000003700540611ef6711
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vitaly,

Thank you for looking into this issue!

We have reproduced this issue with a Radeon RX 580 (Polaris 20)
passthrough-ed to a QEMU (4.0.0) VM by VFIO.
All bugs were reproducible on the recent 6.8-rc4 Linux kernel (
https://github.com/torvalds/linux/tree/v6.8-rc4), which I double checked
right now with previous programs.

Below are the QEMU arguments used, in-VM lspci -vvv and /proc/cpuinfo.
Should you need any more information, please let us know.

*QEMU arguments*
qemu-system-x86_64
-m 2G \
-cpu host \
-kernel $KERNEL \
-append "console=3DttyS0 root=3D/dev/sda earlyprintk=3Dserial net.ifnames=
=3D0" \
-drive file=3D$DRIVE_FILE,format=3Dqcow2 \
-enable-kvm \
-device vfio-pci,host=3D$PCI_ADDR,id=3Dgpu,multifunction=3Don,x-vga=3Don \
-nographic

*root@qemu:~# lspci -vvv*
00:03.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Ellesmere [Radeon RX 47)
        Subsystem: Gigabyte Technology Co., Ltd Ellesmere [Radeon RX
470/480/570/570X/580/580X/59]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <-
        Latency: 0
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]
        Region 2: Memory at f0000000 (64-bit, prefetchable) [size=3D2M]
        Region 4: I/O ports at c000 [size=3D256]
        Region 5: Memory at feb80000 (32-bit, non-prefetchable) [size=3D256=
K]
        Expansion ROM at 000c0000 [disabled] [size=3D128K]
        Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr-
TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L1, Exit
Latency L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (downgraded), Width x4 (downgraded)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis-
NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Not Supported,
ExtFmt+ EETLPPrefix+, Max1
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS-
                         AtomicOpsCap: 32bit+ 64bit+ 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+
OBFF Disabled,
                         AtomicOpsCtl: ReqEn+
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPha-
                         EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fee01004  Data: 0021
        Kernel driver in use: amdgpu

*root@snapuzz:~# cat /proc/cpuinfo*
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 183
model name      : 13th Gen Intel(R) Core(TM) i9-13900K
stepping        : 1
microcode       : 0x1
cpu MHz         : 2995.200
cache size      : 16384 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 31
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflushs
vmx flags       : vnmi preemption_timer posted_intr invvpid ept_x_only
ept_ad ept_1gb flexprioritg
bugs            : spectre_v1 spectre_v2 spec_store_bypass mds swapgs
itlb_multihit mmio_unknown eb
bogomips        : 5990.40
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management:

On Thu, Feb 22, 2024 at 10:57=E2=80=AFAM vitaly prosyak <vprosyak@amd.com> =
wrote:

> Hi Joonkyo,
>
> Thanks for your reporting!
>
> I reproduced the first issue with 'amdgpu_gem_userptr_ioctl' when KAZAN
> enabled, but i could not reproduce the other two issues.
>
> Could you indicate what ASIC did you use to reproduce the the issue?
>
> Could you provide details of your system?
>
> Much appreciated for your responce.
>
> Vitaly
>
>
> I placed your findings below to keep the context and track the issues.
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Reporting a slab-use-after-free in amdgpu.eml
>
> Subject:
> Reporting a slab-use-after-free in amdgpu
>
> From:
> Joonkyo Jung <joonkyoj@yonsei.ac.kr> <joonkyoj@yonsei.ac.kr>
>
> Date:
> 2024-02-16, 04:22
>
> To:
> alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com
>
> CC:
> amd-gfx@lists.freedesktop.org, Dokyung Song <dokyungs@yonsei.ac.kr> <doky=
ungs@yonsei.ac.kr>,  jisoo.jang@yonsei.ac.kr, yw9865@yonsei.ac.kr
>
> Hello,
>
> We
>  would like to report a slab-use-after-free bug in the AMDGPU DRM driver
>  in the linux kernel v6.8-rc4 that we found with our customized
> Syzkaller.
> The bug can be triggered by sending two ioctls to the AMDGPU DRM driver i=
n succession.
>
> In amdgpu_bo_move, struct ttm_resource *old_mem =3D bo->resource is assig=
ned.
> As you can see on the alloc & free stack calls, on the same function amdg=
pu_bo_move,
> amdgpu_move_blit in the end frees bo->resource at ttm_bo_move_accel_clean=
up with ttm_bo_wait_free_node(bo, man->use_tt).
> But
>  amdgpu_bo_move continues after that, reaching trace_amdgpu_bo_move(abo,
>  new_mem->mem_type, old_mem->mem_type) at the end, causing the
> use-after-free bug.
>
> Steps to reproduce are as below.
> union drm_amdgpu_gem_create *arg1;
>
> arg1 =3D malloc(sizeof(union drm_amdgpu_gem_create));
> arg1->in.bo_size =3D 0x8;
> arg1->in.alignment =3D 0x0;
> arg1->in.domains =3D 0x4;
> arg1->in.domain_flags =3D 0x9;
> ioctl(fd, 0xc0206440, arg1);
>
> arg1->in.bo_size =3D 0x7fffffff;
> arg1->in.alignment =3D 0x0;
> arg1->in.domains =3D 0x4;
> arg1->in.domain_flags =3D 0x9;
> ioctl(fd, 0xc0206440, arg1);
>
> The KASAN report is as follows:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in amdgpu_bo_move+0x1479/0x1550
> Read of size 4 at addr ffff88800f5bee80 by task syz-executor/219
> Call Trace:
>  <TASK>
>  amdgpu_bo_move+0x1479/0x1550
>  ttm_bo_handle_move_mem+0x4d0/0x700
>  ttm_mem_evict_first+0x945/0x1230
>  ttm_bo_mem_space+0x6c7/0x940
>  ttm_bo_validate+0x286/0x650
>  ttm_bo_init_reserved+0x34c/0x490
>  amdgpu_bo_create+0x94b/0x1610
>  amdgpu_bo_create_user+0xa3/0x130
>  amdgpu_gem_create_ioctl+0x4bc/0xc10
>  drm_ioctl_kernel+0x300/0x410
>  drm_ioctl+0x648/0xb30
>  amdgpu_drm_ioctl+0xc8/0x160
>  </TASK>
>
> Allocated by task 219:
>  kmalloc_trace+0x211/0x390
>  amdgpu_vram_mgr_new+0x1d6/0xbe0
>  ttm_resource_alloc+0xfd/0x1e0
>  ttm_bo_mem_space+0x255/0x940
>  ttm_bo_validate+0x286/0x650
>  ttm_bo_init_reserved+0x34c/0x490
>  amdgpu_bo_create+0x94b/0x1610
>  amdgpu_bo_create_user+0xa3/0x130
>  amdgpu_gem_create_ioctl+0x4bc/0xc10
>  drm_ioctl_kernel+0x300/0x410
>  drm_ioctl+0x648/0xb30
>  amdgpu_drm_ioctl+0xc8/0x160
>
> Freed by task 219:
>  kfree+0x111/0x2d0
>  ttm_resource_free+0x17e/0x1e0
>  ttm_bo_move_accel_cleanup+0x77e/0x9b0
>  amdgpu_move_blit+0x3db/0x670
>  amdgpu_bo_move+0xfa2/0x1550
>  ttm_bo_handle_move_mem+0x4d0/0x700
>  ttm_mem_evict_first+0x945/0x1230
>  ttm_bo_mem_space+0x6c7/0x940
>  ttm_bo_validate+0x286/0x650
>  ttm_bo_init_reserved+0x34c/0x490
>  amdgpu_bo_create+0x94b/0x1610
>  amdgpu_bo_create_user+0xa3/0x130
>  amdgpu_gem_create_ioctl+0x4bc/0xc10
>  drm_ioctl_kernel+0x300/0x410
>  drm_ioctl+0x648/0xb30
>  amdgpu_drm_ioctl+0xc8/0x160
>
> The buggy address belongs to the object at ffff88800f5bee70
>  which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 16 bytes inside of
>  freed 96-byte region [ffff88800f5bee70, ffff88800f5beed0)
>
> Should you need any more information, please do not hesitate to contact u=
s.
>
> Best regards,
> Joonkyo Jung
>
> Reporting a null-ptr-deref in amdgpu.eml
>
> Subject:
> Reporting a null-ptr-deref in amdgpu
>
> From:
> Joonkyo Jung <joonkyoj@yonsei.ac.kr> <joonkyoj@yonsei.ac.kr>
>
> Date:
> 2024-02-16, 04:20
>
> To:
> alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com
>
> CC:
> Dokyung Song <dokyungs@yonsei.ac.kr> <dokyungs@yonsei.ac.kr>, jisoo.jang@=
yonsei.ac.kr, yw9865@yonsei.ac.kr,  amd-gfx@lists.freedesktop.org
>
> Hello,
>
> We
>  would like to report a null-ptr-deref bug in the AMDGPU DRM driver in
> the linux kernel v6.8-rc4 that we found with our customized Syzkaller.
> The bug can be triggered by sending two ioctls to the AMDGPU DRM driver i=
n succession.
>
> The first ioctl amdgpu_ctx_ioctl will create a ctx, and return ctx_id =3D=
 1 to the userspace.
> Second
>  ioctl, actually any ioctl that will eventually call
> amdgpu_ctx_get_entity, carries this ctx_id and passes the context check.
> Here, for example, drm_amdgpu_wait_cs.
> Validations in amdgpu_ctx_get_entity can also be passed by the user-provi=
ded values from the ioctl arguments.
> This
>  eventually leads to drm_sched_entity_init, where the null-ptr-deref
> will trigger on RCU_INIT_POINTER(entity->last_scheduled, NULL);
>
> Steps to reproduce are as below.
> union drm_amdgpu_ctx *arg1;
> union drm_amdgpu_wait_cs *arg2;
>
> arg1 =3D malloc(sizeof(union drm_amdgpu_ctx));
> arg2 =3D malloc(sizeof(union drm_amdgpu_wait_cs));
>
> arg1->in.op =3D 0x1;
> ioctl(AMDGPU_renderD128_DEVICE_FILE, 0x140106442, arg1);
>
> arg2->in.handle =3D 0x0;
> arg2->in.timeout =3D 0x2000000000000;
> arg2->in.ip_type =3D 0x9;
> arg2->in.ip_instance =3D 0x0;
> arg2->in.ring =3D 0x0;
> arg2->in.ctx_id =3D 0x1;
> ioctl(AMDGPU_renderD128_DEVICE_FILE, 0xc0206449, arg2);
>
> The KASAN report is as follows:
> general protection fault, probably for non-canonical address 0xdffffc0000=
000005: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> Call Trace:
>  <TASK>
>  ? drm_sched_entity_init+0x16e/0x650
>  ? drm_sched_entity_init+0x208/0x650
>  amdgpu_ctx_get_entity+0x944/0xc30
>  amdgpu_cs_wait_ioctl+0x13d/0x3f0
>  drm_ioctl_kernel+0x300/0x410
>  drm_ioctl+0x648/0xb30
>  amdgpu_drm_ioctl+0xc8/0x160
>  </TASK>
>
> Should you need any more information, please do not hesitate to contact u=
s.
>
> Best regards,
> Joonkyo Jung
>
> Reporting a use-after-free in amdgpu.eml
>
> Subject:
> Reporting a use-after-free in amdgpu
>
> From:
> =EC=A0=95=EC=A4=80=EA=B5=90 <joonkyoj@yonsei.ac.kr> <joonkyoj@yonsei.ac.k=
r>
>
> Date:
> 2024-02-14, 21:34
>
> To:
> alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com
>
> CC:
> amd-gfx@lists.freedesktop.org, Dokyung Song <dokyungs@yonsei.ac.kr> <doky=
ungs@yonsei.ac.kr>,  jisoo.jang@yonsei.ac.kr, yw9865@yonsei.ac.kr
>
> Hello,
>
> We
>  would like to report a use-after-free bug in the AMDGPU DRM driver in
> the linux kernel 6.2 that we found with our customized Syzkaller.
> The bug can be triggered by sending a single amdgpu_gem_userptr_ioctl to =
the AMDGPU DRM driver, with invalid addr and size.
> We have tested that this bug can still be triggered in the latest RC kern=
el, v6.8-rc4.
>
> Steps to reproduce are as below.
>
> struct drm_amdgpu_gem_userptr *arg;
> arg =3D malloc(sizeof(struct drm_amdgpu_gem_userptr));
> arg->addr =3D 0xffffffffffff0000;
> arg->size =3D 0x80000000;
> arg->flags =3D 0x7;
> ioctl(AMDGPU_renderD128_DEVICE_FILE, 0xc1186451, arg);
>
> The KASAN report is as follows:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in switch_mm_irqs_off+0x89d/0xb70
> Read of size 8 at addr ffff88801f17bc00 by task syz-executor/386
> Call Trace:
> <TASK>
> switch_mm_irqs_off+0x89d/0xb70
> __schedule+0xa62/0x2630
> preempt_schedule_common+0x45/0xd0
> vfree+0x4d/0x60
> ttm_tt_fini+0xdf/0x1c0
> amdgpu_ttm_backend_destroy+0x9f/0xe0
> ttm_bo_cleanup_memtype_use+0x142/0x1f0
> ttm_bo_release+0x67d/0xc00
> ttm_bo_put+0x7c/0xa0
> amdgpu_bo_unref+0x3b/0x80
> amdgpu_gem_object_free+0x7f/0xc0
> drm_gem_object_free+0x5d/0x90
> amdgpu_gem_userptr_ioctl+0x452/0x7e0
> drm_ioctl_kernel+0x284/0x500
> drm_ioctl+0x55e/0xa50
> amdgpu_drm_ioctl+0xe3/0x1d0
> </TASK>
>
> Allocated by task 385:
> kmem_cache_alloc+0x174/0x300
> copy_process+0x32d1/0x6640
> kernel_clone+0xcd/0x690
>
> Freed by task 386:
> kmem_cache_free+0x13b/0x550
> mmu_interval_notifier_remove+0x4c8/0x610
> amdgpu_hmm_unregister+0x47/0x90
> amdgpu_gem_object_free+0x75/0xc0
> drm_gem_object_free+0x5d/0x90
> amdgpu_gem_userptr_ioctl+0x452/0x7e0
> drm_ioctl_kernel+0x284/0x500
> drm_ioctl+0x55e/0xa50
> amdgpu_drm_ioctl+0xe3/0x1d0
>
> The buggy address belongs to the object at ffff88801f17bb80
> which belongs to the cache mm_struct of size 2016
> The buggy address is located 128 bytes inside of
> 2016-byte region [ffff88801f17bb80, ffff88801f17c360)
>
> The buggy address belongs to the physical page:
> page:000000002c2a61bd refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x1f178
> head:000000002c2a61bd order:3 compound_mapcount:0 subpages_mapcount:0 com=
pound_pincount:0
> memcg:ffff8880141aa301
> flags: 0x100000000010200(slab|head|node=3D0|zone=3D1)
> raw: 0100000000010200 ffff88800a44fc80 ffffea00006ca400 dead000000000004
> raw: 0000000000000000 00000000800f000f 00000001ffffffff ffff8880141aa301
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
> ffff88801f17bb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88801f17bb80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff88801f17bc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ^
> ffff88801f17bc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88801f17bd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>

--0000000000003700540611ef6711
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Vitaly,<br><br>Thank you for looking into this issue!<b=
r><br>We have reproduced this issue with a Radeon RX 580 (Polaris 20) passt=
hrough-ed to a QEMU (4.0.0) VM by VFIO.<br>All bugs were reproducible on th=
e recent 6.8-rc4 Linux kernel (<a href=3D"https://github.com/torvalds/linux=
/tree/v6.8-rc4">https://github.com/torvalds/linux/tree/v6.8-rc4</a>), which=
 I double checked right now with previous programs.<br><br>Below are the QE=
MU arguments used, in-VM lspci -vvv and /proc/cpuinfo.<br>Should you need a=
ny more information, please let us know.<br><br><b>QEMU arguments</b><br>qe=
mu-system-x86_64<br>-m 2G \<br>-cpu host \<br>-kernel $KERNEL \<br>-append =
&quot;console=3DttyS0 root=3D/dev/sda earlyprintk=3Dserial net.ifnames=3D0&=
quot; \<br>-drive file=3D$DRIVE_FILE,format=3Dqcow2 \<br>-enable-kvm \<br>-=
device vfio-pci,host=3D$PCI_ADDR,id=3Dgpu,multifunction=3Don,x-vga=3Don \<b=
r>-nographic<br><br><b>root@qemu:~# lspci -vvv</b><br>00:03.0 VGA compatibl=
e controller: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere [Radeon RX 4=
7)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subsystem: Gigabyte Technology Co., Ltd E=
llesmere [Radeon RX 470/480/570/570X/580/580X/59]<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Cap+ 66MHz- U=
DF- FastB2B- ParErr- DEVSEL=3Dfast &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;=
SERR- &lt;-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Latency: 0<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Interrupt: pin A routed to IRQ 24<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Region 0: Memory at e0000000 (64-bit, prefetchable) [size=3D256M]<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Region 2: Memory at f0000000 (64-bit, prefetchable=
) [size=3D2M]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Region 4: I/O ports at c000 [s=
ize=3D256]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Region 5: Memory at feb80000 (32-=
bit, non-prefetchable) [size=3D256K]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Expansi=
on ROM at 000c0000 [disabled] [size=3D128K]<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Capabilities: [48] Vendor Specific Information: Len=3D08 &lt;?&gt;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [50] Power Management version 3<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Flags: PMEClk- DSI-=
 D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: D0 NoSoftRst+ PME-Enable-=
 DSel=3D0 DScale=3D0 PME-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [58]=
 Express (v2) Legacy Endpoint, MSI 00<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0=
s &lt;4us, L1 unlimited<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ =
FLReset-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevCtl:=
 CorrErr- NonFatalErr- FatalErr- UnsupReq-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RlxdOrd+ ExtTag+ Ph=
antFunc- AuxPwr- NoSnoop+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MaxPayload 128 bytes, MaxReadReq 512=
 bytes<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevSta: C=
orrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LnkCap: Port #0, Speed 8GT/s,=
 Width x16, ASPM L1, Exit Latency L1 &lt;1us<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ClockPM- Surprise-=
 LLActRep- BwNot- ASPMOptComp+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LnkSta: Speed 5GT/s (downgraded),=
 Width x4 (downgraded)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TrErr- Train- SlotClk+ DLActive- BWMgmt-=
 ABWMgmt-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DevCap=
2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR+<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A010BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefi=
x+, Max1<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0EmergencyPowerReduction Not Supported, Emergency=
PowerReductionInit-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FRS-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AtomicOpsCap:=
 32bit+ 64bit+ 128bitCAS-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF=
 Disabled,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0AtomicOpsCtl: ReqEn+<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LnkSta2: Current De-emphasis Level: -3.=
5dB, EqualizationComplete- EqualizationPha-<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EqualizationP=
hase2- EqualizationPhase3- LinkEqualizationRequest-<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Retim=
er- 2Retimers- CrosslinkRes: unsupported<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Cap=
abilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Address: 00000000fee01004 =C2=A0D=
ata: 0021<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel driver in use: amdgpu<br><b=
r><b>root@snapuzz:~# cat /proc/cpuinfo</b><br>processor =C2=A0 =C2=A0 =C2=
=A0 : 0<br>vendor_id =C2=A0 =C2=A0 =C2=A0 : GenuineIntel<br>cpu family =C2=
=A0 =C2=A0 =C2=A0: 6<br>model =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 183<br>m=
odel name =C2=A0 =C2=A0 =C2=A0: 13th Gen Intel(R) Core(TM) i9-13900K<br>ste=
pping =C2=A0 =C2=A0 =C2=A0 =C2=A0: 1<br>microcode =C2=A0 =C2=A0 =C2=A0 : 0x=
1<br>cpu MHz =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 2995.200<br>cache size =C2=A0 =
=C2=A0 =C2=A0: 16384 KB<br>physical id =C2=A0 =C2=A0 : 0<br>siblings =C2=A0=
 =C2=A0 =C2=A0 =C2=A0: 1<br>core id =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0<br>cpu =
cores =C2=A0 =C2=A0 =C2=A0 : 1<br>apicid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
: 0<br>initial apicid =C2=A0: 0<br>fpu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 : yes<br>fpu_exception =C2=A0 : yes<br>cpuid level =C2=A0 =C2=A0 : 3=
1<br>wp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: yes<br>flags =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : fpu vme de pse tsc msr pae mce cx8 apic s=
ep mtrr pge mca cmov pat pse36 clflushs<br>vmx flags =C2=A0 =C2=A0 =C2=A0 :=
 vnmi preemption_timer posted_intr invvpid ept_x_only ept_ad ept_1gb flexpr=
ioritg<br>bugs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: spectre_v1 spectr=
e_v2 spec_store_bypass mds swapgs itlb_multihit mmio_unknown eb<br>bogomips=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 5990.40<br>clflush size =C2=A0 =C2=A0: 64<br>=
cache_alignment : 64<br>address sizes =C2=A0 : 40 bits physical, 48 bits vi=
rtual<br>power management:<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Feb 22, 2024 at 10:57=E2=80=AFAM vita=
ly prosyak &lt;<a href=3D"mailto:vprosyak@amd.com">vprosyak@amd.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><u></u>

 =20
  <div>
    <p>Hi Joonkyo,</p>
    <p>Thanks for your reporting!</p>
    <p>I reproduced the first issue with &#39;amdgpu_gem_userptr_ioctl&#39;=
 when
      KAZAN enabled, but i could not reproduce the other two issues.</p>
    <p>Could you indicate what ASIC did you use to reproduce the the
      issue?</p>
    <p>Could you provide details of your system?</p>
    <p>Much appreciated for your responce.</p>
    <p>Vitaly<br>
    </p>
    <p><br>
    </p>
    <p>I placed your findings below to keep the context and track the
      issues.<br>
    </p>
    <p>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>
    </p>
    <pre><fieldset><legend>Reporting a slab-use-after-free in amdgpu.eml</l=
egend></fieldset><table width=3D"100%" cellspacing=3D"0" cellpadding=3D"0" =
border=3D"0"><tbody><tr><td><div style=3D"display:inline">Subject: </div>Re=
porting a slab-use-after-free in amdgpu</td></tr><tr><td><div style=3D"disp=
lay:inline">From: </div>Joonkyo Jung <a href=3D"mailto:joonkyoj@yonsei.ac.k=
r" target=3D"_blank">&lt;joonkyoj@yonsei.ac.kr&gt;</a></td></tr><tr><td><di=
v style=3D"display:inline">Date: </div>2024-02-16, 04:22</td></tr></tbody><=
/table><table width=3D"100%" cellspacing=3D"0" cellpadding=3D"0" border=3D"=
0"><tbody><tr><td><div style=3D"display:inline">To: </div><a href=3D"mailto=
:alexander.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>=
, <a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.k=
oenig@amd.com</a>, <a href=3D"mailto:Xinhui.Pan@amd.com" target=3D"_blank">=
Xinhui.Pan@amd.com</a></td></tr><tr><td><div style=3D"display:inline">CC: <=
/div><a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a>, Dokyung Song <a href=3D"mailto:dokyungs@yon=
sei.ac.kr" target=3D"_blank">&lt;dokyungs@yonsei.ac.kr&gt;</a>,  <a href=3D=
"mailto:jisoo.jang@yonsei.ac.kr" target=3D"_blank">jisoo.jang@yonsei.ac.kr<=
/a>, <a href=3D"mailto:yw9865@yonsei.ac.kr" target=3D"_blank">yw9865@yonsei=
.ac.kr</a></td></tr></tbody></table>

<div lang=3D"x-unicode"><div dir=3D"ltr">Hello,

We
 would like to report a slab-use-after-free bug in the AMDGPU DRM driver
 in the linux kernel v6.8-rc4 that we found with our customized=20
Syzkaller.
The bug can be triggered by sending two ioctls to the AMDGPU DRM driver in =
succession.

In amdgpu_bo_move, struct ttm_resource *old_mem =3D bo-&gt;resource is assi=
gned.
As you can see on the alloc &amp; free stack calls, on the same function am=
dgpu_bo_move,
amdgpu_move_blit in the end frees bo-&gt;resource at ttm_bo_move_accel_clea=
nup with ttm_bo_wait_free_node(bo, man-&gt;use_tt).
But
 amdgpu_bo_move continues after that, reaching trace_amdgpu_bo_move(abo,
 new_mem-&gt;mem_type, old_mem-&gt;mem_type) at the end, causing the=20
use-after-free bug.

Steps to reproduce are as below.
union drm_amdgpu_gem_create *arg1;

arg1 =3D malloc(sizeof(union drm_amdgpu_gem_create));
arg1-&gt;in.bo_size =3D 0x8;
arg1-&gt;in.alignment =3D 0x0;
arg1-&gt;in.domains =3D 0x4;
arg1-&gt;in.domain_flags =3D 0x9;
ioctl(fd, 0xc0206440, arg1);

arg1-&gt;in.bo_size =3D 0x7fffffff;
arg1-&gt;in.alignment =3D 0x0;
arg1-&gt;in.domains =3D 0x4;
arg1-&gt;in.domain_flags =3D 0x9;
ioctl(fd, 0xc0206440, arg1);

The KASAN report is as follows:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in amdgpu_bo_move+0x1479/0x1550
Read of size 4 at addr ffff88800f5bee80 by task syz-executor/219
Call Trace:
=C2=A0&lt;TASK&gt;
=C2=A0amdgpu_bo_move+0x1479/0x1550
=C2=A0ttm_bo_handle_move_mem+0x4d0/0x700
=C2=A0ttm_mem_evict_first+0x945/0x1230
=C2=A0ttm_bo_mem_space+0x6c7/0x940
=C2=A0ttm_bo_validate+0x286/0x650
=C2=A0ttm_bo_init_reserved+0x34c/0x490
=C2=A0amdgpu_bo_create+0x94b/0x1610
=C2=A0amdgpu_bo_create_user+0xa3/0x130
=C2=A0amdgpu_gem_create_ioctl+0x4bc/0xc10
=C2=A0drm_ioctl_kernel+0x300/0x410
=C2=A0drm_ioctl+0x648/0xb30
=C2=A0amdgpu_drm_ioctl+0xc8/0x160
=C2=A0&lt;/TASK&gt;

Allocated by task 219:
=C2=A0kmalloc_trace+0x211/0x390
=C2=A0amdgpu_vram_mgr_new+0x1d6/0xbe0
=C2=A0ttm_resource_alloc+0xfd/0x1e0
=C2=A0ttm_bo_mem_space+0x255/0x940
=C2=A0ttm_bo_validate+0x286/0x650
=C2=A0ttm_bo_init_reserved+0x34c/0x490
=C2=A0amdgpu_bo_create+0x94b/0x1610
=C2=A0amdgpu_bo_create_user+0xa3/0x130
=C2=A0amdgpu_gem_create_ioctl+0x4bc/0xc10
=C2=A0drm_ioctl_kernel+0x300/0x410
=C2=A0drm_ioctl+0x648/0xb30
=C2=A0amdgpu_drm_ioctl+0xc8/0x160

Freed by task 219:
=C2=A0kfree+0x111/0x2d0
=C2=A0ttm_resource_free+0x17e/0x1e0
=C2=A0ttm_bo_move_accel_cleanup+0x77e/0x9b0
=C2=A0amdgpu_move_blit+0x3db/0x670
=C2=A0amdgpu_bo_move+0xfa2/0x1550
=C2=A0ttm_bo_handle_move_mem+0x4d0/0x700
=C2=A0ttm_mem_evict_first+0x945/0x1230
=C2=A0ttm_bo_mem_space+0x6c7/0x940
=C2=A0ttm_bo_validate+0x286/0x650
=C2=A0ttm_bo_init_reserved+0x34c/0x490
=C2=A0amdgpu_bo_create+0x94b/0x1610
=C2=A0amdgpu_bo_create_user+0xa3/0x130
=C2=A0amdgpu_gem_create_ioctl+0x4bc/0xc10
=C2=A0drm_ioctl_kernel+0x300/0x410
=C2=A0drm_ioctl+0x648/0xb30
=C2=A0amdgpu_drm_ioctl+0xc8/0x160

The buggy address belongs to the object at ffff88800f5bee70
=C2=A0which belongs to the cache kmalloc-96 of size 96
The buggy address is located 16 bytes inside of
=C2=A0freed 96-byte region [ffff88800f5bee70, ffff88800f5beed0)

Should you need any more information, please do not hesitate to contact us.

Best regards,
Joonkyo Jung
</div>

</div>
<fieldset><legend>Reporting a null-ptr-deref in amdgpu.eml</legend></fields=
et><table width=3D"100%" cellspacing=3D"0" cellpadding=3D"0" border=3D"0"><=
tbody><tr><td><div style=3D"display:inline">Subject: </div>Reporting a null=
-ptr-deref in amdgpu</td></tr><tr><td><div style=3D"display:inline">From: <=
/div>Joonkyo Jung <a href=3D"mailto:joonkyoj@yonsei.ac.kr" target=3D"_blank=
">&lt;joonkyoj@yonsei.ac.kr&gt;</a></td></tr><tr><td><div style=3D"display:=
inline">Date: </div>2024-02-16, 04:20</td></tr></tbody></table><table width=
=3D"100%" cellspacing=3D"0" cellpadding=3D"0" border=3D"0"><tbody><tr><td><=
div style=3D"display:inline">To: </div><a href=3D"mailto:alexander.deucher@=
amd.com" target=3D"_blank">alexander.deucher@amd.com</a>, <a href=3D"mailto=
:christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>, =
<a href=3D"mailto:Xinhui.Pan@amd.com" target=3D"_blank">Xinhui.Pan@amd.com<=
/a></td></tr><tr><td><div style=3D"display:inline">CC: </div>Dokyung Song <=
a href=3D"mailto:dokyungs@yonsei.ac.kr" target=3D"_blank">&lt;dokyungs@yons=
ei.ac.kr&gt;</a>, <a href=3D"mailto:jisoo.jang@yonsei.ac.kr" target=3D"_bla=
nk">jisoo.jang@yonsei.ac.kr</a>, <a href=3D"mailto:yw9865@yonsei.ac.kr" tar=
get=3D"_blank">yw9865@yonsei.ac.kr</a>,  <a href=3D"mailto:amd-gfx@lists.fr=
eedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a></td></tr=
></tbody></table>

<div lang=3D"x-unicode"><div dir=3D"ltr">Hello,

We
 would like to report a null-ptr-deref bug in the AMDGPU DRM driver in=20
the linux kernel v6.8-rc4 that we found with our customized Syzkaller.
The bug can be triggered by sending two ioctls to the AMDGPU DRM driver in =
succession.

The first ioctl amdgpu_ctx_ioctl will create a ctx, and return ctx_id =3D 1=
 to the userspace.
Second
 ioctl, actually any ioctl that will eventually call=20
amdgpu_ctx_get_entity, carries this ctx_id and passes the context check.
Here, for example, drm_amdgpu_wait_cs.
Validations in amdgpu_ctx_get_entity can also be passed by the user-provide=
d values from the ioctl arguments.
This
 eventually leads to drm_sched_entity_init, where the null-ptr-deref=20
will trigger on RCU_INIT_POINTER(entity-&gt;last_scheduled, NULL);

Steps to reproduce are as below.
union drm_amdgpu_ctx *arg1;
union drm_amdgpu_wait_cs *arg2;

arg1 =3D malloc(sizeof(union drm_amdgpu_ctx));
arg2 =3D malloc(sizeof(union drm_amdgpu_wait_cs));

arg1-&gt;in.op =3D 0x1;
ioctl(AMDGPU_renderD128_DEVICE_FILE, 0x140106442, arg1);

arg2-&gt;in.handle =3D 0x0;
arg2-&gt;in.timeout =3D 0x2000000000000;
arg2-&gt;in.ip_type =3D 0x9;
arg2-&gt;in.ip_instance =3D 0x0;
arg2-&gt;in.ring =3D 0x0;
arg2-&gt;in.ctx_id =3D 0x1;
ioctl(AMDGPU_renderD128_DEVICE_FILE, 0xc0206449, arg2);

The KASAN report is as follows:
general protection fault, probably for non-canonical address 0xdffffc000000=
0005: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
Call Trace:
=C2=A0&lt;TASK&gt;
=C2=A0? drm_sched_entity_init+0x16e/0x650
=C2=A0? drm_sched_entity_init+0x208/0x650
=C2=A0amdgpu_ctx_get_entity+0x944/0xc30
=C2=A0amdgpu_cs_wait_ioctl+0x13d/0x3f0
=C2=A0drm_ioctl_kernel+0x300/0x410
=C2=A0drm_ioctl+0x648/0xb30
=C2=A0amdgpu_drm_ioctl+0xc8/0x160
=C2=A0&lt;/TASK&gt;

Should you need any more information, please do not hesitate to contact us.

Best regards,
Joonkyo Jung
</div>

</div>
<fieldset><legend>Reporting a use-after-free in amdgpu.eml</legend></fields=
et><table width=3D"100%" cellspacing=3D"0" cellpadding=3D"0" border=3D"0"><=
tbody><tr><td><div style=3D"display:inline">Subject: </div>Reporting a use-=
after-free in amdgpu</td></tr><tr><td><div style=3D"display:inline">From: <=
/div>=EC=A0=95=EC=A4=80=EA=B5=90 <a href=3D"mailto:joonkyoj@yonsei.ac.kr" t=
arget=3D"_blank">&lt;joonkyoj@yonsei.ac.kr&gt;</a></td></tr><tr><td><div st=
yle=3D"display:inline">Date: </div>2024-02-14, 21:34</td></tr></tbody></tab=
le><table width=3D"100%" cellspacing=3D"0" cellpadding=3D"0" border=3D"0"><=
tbody><tr><td><div style=3D"display:inline">To: </div><a href=3D"mailto:ale=
xander.deucher@amd.com" target=3D"_blank">alexander.deucher@amd.com</a>, <a=
 href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koeni=
g@amd.com</a>, <a href=3D"mailto:Xinhui.Pan@amd.com" target=3D"_blank">Xinh=
ui.Pan@amd.com</a></td></tr><tr><td><div style=3D"display:inline">CC: </div=
><a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx=
@lists.freedesktop.org</a>, Dokyung Song <a href=3D"mailto:dokyungs@yonsei.=
ac.kr" target=3D"_blank">&lt;dokyungs@yonsei.ac.kr&gt;</a>,  <a href=3D"mai=
lto:jisoo.jang@yonsei.ac.kr" target=3D"_blank">jisoo.jang@yonsei.ac.kr</a>,=
 <a href=3D"mailto:yw9865@yonsei.ac.kr" target=3D"_blank">yw9865@yonsei.ac.=
kr</a></td></tr></tbody></table>

<div lang=3D"x-unicode"><div dir=3D"ltr">Hello,

We
 would like to report a use-after-free bug in the AMDGPU DRM driver in=20
the linux kernel 6.2 that we found with our customized Syzkaller.
The bug can be triggered by sending a single amdgpu_gem_userptr_ioctl to th=
e AMDGPU DRM driver, with invalid addr and size.=20
We have tested that this bug can still be triggered in the latest RC kernel=
, v6.8-rc4.

Steps to reproduce are as below.

struct drm_amdgpu_gem_userptr *arg;
arg =3D malloc(sizeof(struct drm_amdgpu_gem_userptr));
arg-&gt;addr =3D 0xffffffffffff0000;
arg-&gt;size =3D 0x80000000;
arg-&gt;flags =3D 0x7;
ioctl(AMDGPU_renderD128_DEVICE_FILE, 0xc1186451, arg);

The KASAN report is as follows:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: use-after-free in switch_mm_irqs_off+0x89d/0xb70
Read of size 8 at addr ffff88801f17bc00 by task syz-executor/386
Call Trace:
&lt;TASK&gt;
switch_mm_irqs_off+0x89d/0xb70
__schedule+0xa62/0x2630
preempt_schedule_common+0x45/0xd0
vfree+0x4d/0x60
ttm_tt_fini+0xdf/0x1c0
amdgpu_ttm_backend_destroy+0x9f/0xe0
ttm_bo_cleanup_memtype_use+0x142/0x1f0
ttm_bo_release+0x67d/0xc00
ttm_bo_put+0x7c/0xa0
amdgpu_bo_unref+0x3b/0x80
amdgpu_gem_object_free+0x7f/0xc0
drm_gem_object_free+0x5d/0x90
amdgpu_gem_userptr_ioctl+0x452/0x7e0
drm_ioctl_kernel+0x284/0x500
drm_ioctl+0x55e/0xa50
amdgpu_drm_ioctl+0xe3/0x1d0
&lt;/TASK&gt;

Allocated by task 385:
kmem_cache_alloc+0x174/0x300
copy_process+0x32d1/0x6640
kernel_clone+0xcd/0x690

Freed by task 386:
kmem_cache_free+0x13b/0x550
mmu_interval_notifier_remove+0x4c8/0x610
amdgpu_hmm_unregister+0x47/0x90
amdgpu_gem_object_free+0x75/0xc0
drm_gem_object_free+0x5d/0x90
amdgpu_gem_userptr_ioctl+0x452/0x7e0
drm_ioctl_kernel+0x284/0x500
drm_ioctl+0x55e/0xa50
amdgpu_drm_ioctl+0xe3/0x1d0

The buggy address belongs to the object at ffff88801f17bb80
which belongs to the cache mm_struct of size 2016
The buggy address is located 128 bytes inside of
2016-byte region [ffff88801f17bb80, ffff88801f17c360)

The buggy address belongs to the physical page:
page:000000002c2a61bd refcount:1 mapcount:0 mapping:0000000000000000 index:=
0x0 pfn:0x1f178
head:000000002c2a61bd order:3 compound_mapcount:0 subpages_mapcount:0 compo=
und_pincount:0
memcg:ffff8880141aa301
flags: 0x100000000010200(slab|head|node=3D0|zone=3D1)
raw: 0100000000010200 ffff88800a44fc80 ffffea00006ca400 dead000000000004
raw: 0000000000000000 00000000800f000f 00000001ffffffff ffff8880141aa301
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff88801f17bb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff88801f17bb80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
&gt;ffff88801f17bc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88801f17bc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88801f17bd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div></div></pre>
    <p></p>
  </div>

</blockquote></div>

--0000000000003700540611ef6711--
