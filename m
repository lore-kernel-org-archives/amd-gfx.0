Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE83C3DA63
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 08:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF10210E4DD;
	Tue, 23 Jul 2024 08:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kode54.net header.i=@kode54.net header.b="yFogl0Q7";
	dkim-atps=neutral
X-Greylist: delayed 366 seconds by postgrey-1.36 at gabe;
 Tue, 23 Jul 2024 08:56:31 UTC
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com
 [95.215.58.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C22E10E4DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 08:56:31 +0000 (UTC)
X-Envelope-To: alexdeucher@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; s=key1;
 t=1721724622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJ3RA1yKeLZMFVlJfElG7YMB12PyUVcx2YZHgBMuUAI=;
 b=yFogl0Q7ptXVu3daKTd70JXFypgU2Hkh5TosY78cTgwcNliX1iWOBh2ZQCs9OjlmyhothO
 0VaIckMVw6U8Hdc72GKuS8qY1nezCuekr6MQxgcEiRaVLDOcd61r9pjsfvXFzmC6gX8NCD
 hA/8rSjW977E0rWxhiZYDhwgrWSIzymXNJcUQzrBhXbGj18NDWfXdfxRmWfp+B+cRfLjZn
 E096OU0I9Qm9hWAbreK101S+bq72U2d3PE+FqO0/N9bJ3dv3HV0NuiCfuEVLNy3yZYtwgO
 KmBLq8d29WHTmRzvAW/k/TqjmoLh55DRN2qyXRy+NFdqv84illYRlc2BxarxQw==
X-Envelope-To: amd-gfx@lists.freedesktop.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Christopher Snowhill <chris@kode54.net>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 00/34] GC per queue reset
In-Reply-To: <CADnq5_NHzGzPe73Ks8au=_up87PTJU11mHpCxVcQBNcWkW-b8w@mail.gmail.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
 <CADnq5_NHzGzPe73Ks8au=_up87PTJU11mHpCxVcQBNcWkW-b8w@mail.gmail.com>
Date: Tue, 23 Jul 2024 01:50:18 -0700
Message-ID: <87a5i8jxv9.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
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

Alex Deucher <alexdeucher@gmail.com> writes:

> On Thu, Jul 18, 2024 at 10:15=E2=80=AFAM Alex Deucher <alexander.deucher@=
amd.com> wrote:
>>
>> This adds preliminary support for GC per queue reset.  In this
>> case, only the jobs currently in the queue are lost.  If this
>> fails, we fall back to a full adapter reset.
>
> Also available here via git:
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next=
-queue-reset

Just tested this, after encountering the double-add crash trying to
reset after a GPU hang. It doesn't seem to gracefully recover from this
particular GPU hang, but at least now it resets properly. Still not
going to attempt to run it against KDE / Plasma 6.1.3 on Arch, as that
loves to hang if there's any Xwayland involved in the GPU reset event.

However, under labwc-git with my own PR applied to it, it recovers okay,
though Xwayland eventually crashes and is restarted by labwc. Here's a
dmesg log excerpt of the reset and recovery event:

[  189.830630] amdgpu 0000:0a:00.0: amdgpu: ring gfx_0.0.0 timeout, signale=
d seq=3D52410, emitted seq=3D52412
[  189.830642] amdgpu 0000:0a:00.0: amdgpu: Process information: process St=
ray-Win64-Shi pid 11560 thread vkd3d_queue pid 11719
[  190.099191] amdgpu 0000:0a:00.0: amdgpu: GPU reset begin!
[  190.457702] amdgpu 0000:0a:00.0: amdgpu: Dumping IP State
[  190.459418] amdgpu 0000:0a:00.0: amdgpu: Dumping IP State Completed
[  190.459420] amdgpu 0000:0a:00.0: amdgpu: MODE1 reset
[  190.459423] amdgpu 0000:0a:00.0: amdgpu: GPU mode1 reset
[  190.459483] amdgpu 0000:0a:00.0: amdgpu: GPU smu mode1 reset
[  190.967464] amdgpu 0000:0a:00.0: amdgpu: GPU reset succeeded, trying to =
resume
[  190.967824] [drm] PCIE GART of 512M enabled (table at 0x0000008000300000=
).
[  190.967912] [drm] VRAM is lost due to GPU reset!
[  190.967914] amdgpu 0000:0a:00.0: amdgpu: PSP is resuming...
[  191.042264] amdgpu 0000:0a:00.0: amdgpu: reserve 0xa00000 from 0x82fd000=
000 for PSP TMR
[  191.143003] amdgpu 0000:0a:00.0: amdgpu: RAS: optional ras ta ucode is n=
ot available
[  191.156566] amdgpu 0000:0a:00.0: amdgpu: SECUREDISPLAY: securedisplay ta=
 ucode is not available
[  191.156572] amdgpu 0000:0a:00.0: amdgpu: SMU is resuming...
[  191.156576] amdgpu 0000:0a:00.0: amdgpu: smu driver if version =3D 0x000=
0000e, smu fw if version =3D 0x00000012, smu fw program =3D 0, version =3D =
0x00413e00 (65.62.0)
[  191.156580] amdgpu 0000:0a:00.0: amdgpu: SMU driver if version not match=
ed
[  191.156609] amdgpu 0000:0a:00.0: amdgpu: use vbios provided pptable
[  191.215750] amdgpu 0000:0a:00.0: amdgpu: SMU is resumed successfully!
[  191.217023] [drm] DMUB hardware initialized: version=3D0x02020020
[  191.530005] [drm] kiq ring mec 2 pipe 1 q 0
[  191.532863] amdgpu 0000:0a:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng =
0 on hub 0
[  191.532866] amdgpu 0000:0a:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng =
1 on hub 0
[  191.532867] amdgpu 0000:0a:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 4 on hub 0
[  191.532869] amdgpu 0000:0a:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 5 on hub 0
[  191.532870] amdgpu 0000:0a:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 6 on hub 0
[  191.532871] amdgpu 0000:0a:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 7 on hub 0
[  191.532872] amdgpu 0000:0a:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 8 on hub 0
[  191.532874] amdgpu 0000:0a:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 9 on hub 0
[  191.532875] amdgpu 0000:0a:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 10 on hub 0
[  191.532876] amdgpu 0000:0a:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 11 on hub 0
[  191.532878] amdgpu 0000:0a:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 12 on hub 0
[  191.532879] amdgpu 0000:0a:00.0: amdgpu: ring sdma0 uses VM inv eng 13 o=
n hub 0
[  191.532880] amdgpu 0000:0a:00.0: amdgpu: ring sdma1 uses VM inv eng 14 o=
n hub 0
[  191.532881] amdgpu 0000:0a:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng =
0 on hub 8
[  191.532883] amdgpu 0000:0a:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv en=
g 1 on hub 8
[  191.532884] amdgpu 0000:0a:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv en=
g 4 on hub 8
[  191.532885] amdgpu 0000:0a:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5=
 on hub 8
[  191.536522] amdgpu 0000:0a:00.0: amdgpu: recover vram bo from shadow sta=
rt
[  191.555443] amdgpu 0000:0a:00.0: amdgpu: recover vram bo from shadow done
[  191.555471] amdgpu 0000:0a:00.0: amdgpu: GPU reset(2) succeeded!
[  191.555663] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize =
parser -125!

Yes, I can reliably hang my gfx ring if I run Stray with -dx12 switch
applied. In-game, though, not on the title screen.


> Alex
>
>>
>> Alex Deucher (19):
>>   drm/amdgpu/mes: add API for legacy queue reset
>>   drm/amdgpu/mes11: add API for legacy queue reset
>>   drm/amdgpu/mes12: add API for legacy queue reset
>>   drm/amdgpu/mes: add API for user queue reset
>>   drm/amdgpu/mes11: add API for user queue reset
>>   drm/amdgpu/mes12: add API for user queue reset
>>   drm/amdgpu: add new ring reset callback
>>   drm/amdgpu: add per ring reset support (v2)
>>   drm/amdgpu/gfx11: add ring reset callbacks
>>   drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
>>   drm/amdgpu/gfx10: add ring reset callbacks
>>   drm/amdgpu/gfx10: rework reset sequence
>>   drm/amdgpu/gfx9: add ring reset callback
>>   drm/amdgpu/gfx9.4.3: add ring reset callback
>>   drm/amdgpu/gfx12: add ring reset callbacks
>>   drm/amdgpu/gfx12: fallback to driver reset compute queue directly
>>   drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
>>   drm/amdgpu/gfx11: add a mutex for the gfx semaphore
>>   drm/amdgpu/gfx11: export gfx_v11_0_request_gfx_index_mutex()
>>
>> Jiadong Zhu (13):
>>   drm/amdgpu/gfx11: wait for reset done before remap
>>   drm/amdgpu/gfx10: remap queue after reset successfully
>>   drm/amdgpu/gfx10: wait for reset done before remap
>>   drm/amdgpu/gfx9: remap queue after reset successfully
>>   drm/amdgpu/gfx9: wait for reset done before remap
>>   drm/amdgpu/gfx9.4.3: remap queue after reset successfully
>>   drm/amdgpu/gfx_9.4.3: wait for reset done before remap
>>   drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for reset_hw_queue
>>   drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
>>   drm/amdgpu/gfx9.4.3: implement reset_hw_queue for gfx9.4.3
>>   drm/amdgpu/mes: modify mes api for mmio queue reset
>>   drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
>>   drm/amdgpu/mes11: implement mmio queue reset for gfx11
>>
>> Prike Liang (2):
>>   drm/amdgpu: increase the reset counter for the queue reset
>>   drm/amdgpu/gfx11: fallback to driver reset compute queue directly (v2)
>>
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   6 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  18 +++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  88 ++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  37 +++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   2 +
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 158 ++++++++++++++++++++-
>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 117 +++++++++++++--
>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h     |   3 +
>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  95 ++++++++++++-
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 126 +++++++++++++++-
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 125 +++++++++++++++-
>>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 132 +++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  54 +++++++
>>  14 files changed, 930 insertions(+), 32 deletions(-)
>>
>> --
>> 2.45.2
>>
