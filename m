Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA2CC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 21:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E33F10E35A;
	Fri, 21 Aug 2026 21:18:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lyI453CY";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2281910E35A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 21:18:24 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38fe113c792so172613a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 14:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787347103; cv=none;
 d=google.com; s=arc-20260327;
 b=kSgjgbBxBiI14cqFLZYso+MteOPVwkB6Cu/f9t0P5Q0MaPCpKgbLdW/62BFIWkF+4K
 MatEf2G0hoi3DNiLUGqktoun2G7UDdLBbQpeowZUw2Etgk9zDzUBi6o6qF8lG6kies1b
 OrZ2z6gEj47RlJOpeSvPQYF+XQvLS4+vfKBBsVrz1l4nuC8Li0KpRAwwlWw1p4pV/Gq8
 j069qIKjomaXOFOUQ96OIP42/xmgZ1ce9IwMDlElsxDOGRieyRgNgIY+z2BKvTAR0rVd
 wNTZ8sHS0tzbjo3TnH5JintBL3jrLq0LJ/m42kXoMiG54S8dD7Xn+ng8Of9NgfIPZmWT
 gT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GP7BnwG0/LtiFJQr9QJK94A+vGNuZ8dz0PfvWxEqYG8=;
 fh=oO11bHpzoIaNrknoc2Ajr7a3eCDSflu8nieW3hpmiV4=;
 b=L7bAv/CPlKkdAOuFoGaus5qpMQ+n/mcMR+pRJ0dZHD9sNr0yncyJs5E5GwMqRC3H4P
 pRHLPT4BL5rEYGWWXW6PvyCbCu3rS99re05hjd9p9AaEOO9gCHB0GU66kkXaqS1mQ/EC
 ScAzbmUleB8s5engx26lX1U5MNCpl2uvZGxT82UQmTNbdY9cw72Ey0AUSGJn4t0y+2vn
 bpf7Hiz2SFbsSkGEx6yhVwKa7at+4fMOGmg3+B0yqQQZcrcYJbhhQ3iMO9AfR/maS7/l
 Z8yWmyr6h55GD64jbj7UC6n8FTIuc+xKsIJ9VjpmxSI2RlafAmrv5Cq9lgIF9JsW1hTS
 uJog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787347103; x=1787951903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GP7BnwG0/LtiFJQr9QJK94A+vGNuZ8dz0PfvWxEqYG8=;
 b=lyI453CYy4q64q1laTEa3uFpmunp7di4jpJnM2KXKkiaeyWsNkcSlgLvPI+64B4t2Z
 cQuzVo09sp7xu42mKcqyWCZ9YxsFxNKzvcla3UfxUfJD8VpiGRhKfMyUkSj3Y6859L3n
 +T2lrb8JTrlVoBLoF3dJT9AkGPUWbH/mTAouqiRPIDYk+i/NDdRBkGOpXNzDtkzHEwAV
 akByWLEsVkD530RmFO69KYHfZaF30efOREHxmzrW5oo7XeEroi0/T9Gm49DyXJC6z/ic
 hZVMlzE1FLX7jOiF+YCip0FdWjkUjMH6HqiwKW5iiP/9NHoB/PHAWxV5KXaT5/B5CxNG
 LMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787347103; x=1787951903;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GP7BnwG0/LtiFJQr9QJK94A+vGNuZ8dz0PfvWxEqYG8=;
 b=jk6teB/gykmGAo0r3dE+9wa3L6JchS6RTECvaMzGhXV5kBg4hNi3qSRflMoviENEvU
 ZFsIIu0A4ujJKoqgE07ejEsqC2a3wHOgi/pndmsuWtlVu/3B23416Ln0Z2PHNVqhFsw4
 B29sBRjPiXSC9kGC4yUrL0oS40BEI6EFS54ADLqXYx8ucy3HsrT8EuANDP528FMMBG9y
 yduC288DG6O1MX0v8ybSko/7hoxeP09v91n2lxDFPGKnKHDk8TykwSSl883e3uexx9Ig
 ZnA1fj4msCN+w8choa6fAH75zvgFyilc0IVXQkJTY+Eo3J3e2dQfzzNosKGx9LDk0kI2
 ymhg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmdBK5Q4RaK89Grzj7ytDZL1/FLS3dCH9fLX9ULYpENJYqjpsYc1t4JmiAmOhRYzDkB/pOkeBA@lists.freedesktop.org
X-Gm-Message-State: AFuF++kDmRZtdYEXD2Pj496COMuvGcAl0IFqEOJiPQeWXQZSjXAthw/j
 ukErNUvSyFj3vDZ33rD8xxmHrnN42equdsqQOtvtlnDftE680eUCNcXcBSjzXwDb9f85KSYcbGw
 pRvkGPumzsXcZL7FXLrIjwG4sIY0fuwg=
X-Gm-Gg: AR+sD13EJ3ynSZgUkj3JLDTTSG0amkMUHx9X4npvr6Mxa2X6uZy1nHmihyC5wDawHod
 FOoRTmEwZqaz0KrKlzk4INdQH7V5klAVoRSitfPWA3zr3dLwxsZVmAbz5PjSDd71i2Vv3o5UF+5
 CrxxUHunEOTK0XTWJR28lqdDa+fgJKwH2mLwbDV6bnY+13lhn8ajxfkSt02eDVgm2wquc+pcwBO
 ++8IOclJl3Cjptv09hlVvV2lDRrTcYHIzBKCKcLd8JSUOBPmmplPcObM+H/VA7ncpS0wvo2bGJZ
 O20cbdNT0tDj4LAzeV+Jv7D2H7Sqpepko0jtG+PVTe4KfCJidXsr/R6t6tSFsMZV9eaOWIjSGcI
 pBL4iWrB5jkVa8KzRPstNeK4Cr2xpAY9m/SDx4urAwQ==
X-Received: by 2002:a17:90b:4a81:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-395c35b913cmr7201623a91.4.1787347103487; Fri, 21 Aug 2026
 14:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260821195224.809173-1-alexander.deucher@amd.com>
 <20260821195224.809173-4-alexander.deucher@amd.com>
 <48b5b000-81b9-4cd0-9750-ec4ba910d96d@amd.com>
In-Reply-To: <48b5b000-81b9-4cd0-9750-ec4ba910d96d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Aug 2026 17:18:11 -0400
X-Gm-Features: AcwNN1UR5uvUmWY7DtQkLF71TlMDs68DJpoudBcpIuQ6A-VadIfE6D-QWihT_nQ
Message-ID: <CADnq5_Oh_v=cus-5Xqer+gO9rw_k=RR+y39KSEFwMsMoYDTJXw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Documentation: add initial UALink Documentation
To: Felix Kuehling <felix.kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Joseph.Greathouse@amd.com
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

On Fri, Aug 21, 2026 at 5:06=E2=80=AFPM Felix Kuehling <felix.kuehling@amd.=
com> wrote:
>
> On 2026-08-21 15:52, Alex Deucher wrote:
> > Document the details of UALink on the GPU.
> >
> > Cc: Felix.Kuehling@amd.com
> > Cc: Joseph.Greathouse@amd.com
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   Documentation/gpu/amdgpu/index.rst  |  1 +
> >   Documentation/gpu/amdgpu/ualink.rst | 74 ++++++++++++++++++++++++++++=
+
> >   2 files changed, 75 insertions(+)
> >   create mode 100644 Documentation/gpu/amdgpu/ualink.rst
> >
> > diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amd=
gpu/index.rst
> > index b2ab182236efb..ba2ee73278672 100644
> > --- a/Documentation/gpu/amdgpu/index.rst
> > +++ b/Documentation/gpu/amdgpu/index.rst
> > @@ -23,4 +23,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA)=
 architectures.
> >      debugfs
> >      process-isolation
> >      amdgpu-glossary
> > +   ualink
> >      ptl
> > diff --git a/Documentation/gpu/amdgpu/ualink.rst b/Documentation/gpu/am=
dgpu/ualink.rst
> > new file mode 100644
> > index 0000000000000..1e0a6c52b7b7a
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/ualink.rst
> > @@ -0,0 +1,74 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +UALink Support
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Connected GPUs in a pod can directly access the remove memory on anoth=
er GPU
> > +over UALink.  Unlike RMDA, there is no copy involved; it is direct loa=
ds/stores
> > +over the fabric.  Shared memory can only be accessed by a remote GPU i=
f the
> > +memory was exported and the importer has been authorized. For the memo=
ry to be
> > +shared, it must be part of a unified physical address space shared bet=
ween
> > +nodes.  This address space is called NPA (Nework Physical Address) spa=
ce.  This
> > +address space is partitioned between the GPUs so that each GPU has its=
 own
> > +segment of the address space in which to export its memory.  Each GPU =
maintains
> > +a dedicated set of page tables for their NPA space similar to GPUVM.  =
Note that
> > +this mechanism only allows for GPU access to remote memory.  The remot=
e memory
> > +is not CPU accessible.
> > +
> > +Exported memory is not pinned.  The exporter may need to move memory o=
r make it
> > +unavailable to the importers.  This is handled via remote TLB shootdow=
ns on the
> > +exporter in the case of TTM evictions or MMU notifiers and remote pres=
ense
> > +checks with retry on the importer.
>
> This is no longer true. We ended up having to pin exported memory. This
> was also discussed with Christian already. In principle it's similar to
> how DMABufs in VRAM are pinned for RDMA access.
>
> Remote TLB shootdown will only be used when exported memory is freed in
> order to remove access by remote GPUs.
>
>
> > +
> > +To access remote memory, the driver can map NPA addresses into its per=
 process
> > +GPUVM page tables just like local memory.  Applications use opaque han=
dles to
> > +represent remote memory.  GPUs in a pod communicate with eachother dir=
ectly to
> > +exchange NPA addresses between importers and exporters.  If a node goe=
s offline
> > +or is reset, their peers will clean up any remaining refrences that ar=
e lost
> > +when that happens.
>
> One important point here is, that NPA addresses are exchanged between
> the kernel mode drivers (through the scale-up fabric). NPA addresses are
> never given to user mode.
>
>
> > +
> > +On the importer, the NPA space is like another physical address space.=
 NPA
> > +addresses can be used as physical addresses for GPUVM to provide GPU v=
irtual
> > +addresses to the memory for processes using the GPU.
> > +
> > +On the exporter, the NPA space provides a way to expose discontiguous =
local
> > +memory as a contiguous address range for remote GPUs.  This allows the=
 exporter
> > +to locally manage the pages mapped into the NPA space.
> > +
> > +Remote NPAs are managed like another device specific TTM pool similar =
to
> > +doorbells or VRAM, however they cannot be CPU mapped.
> > +
> > +
> > +User Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Two IOCTLs are provided to export and import remote memory.
> > +
> > +Export Memory
> > +-------------
> > +To export memory, a UALINK handle must be created for an allocation th=
at can be
> > +shared with another node in the pod.  To do this the exporter calls th=
e GEM
> > +UALink IOCTL with the GEM handle to the buffer it wants to export.  Th=
e IOCTL
> > +returns a unique 128 bit handle which can be shared with the remote ho=
st.
> > +Calling export on the same GEM handle always returns the same UALink h=
andle.
> > +The UALink handle is destroyed when the GEM object is freed.
>
> More precisely, the UALink handle is destroyed when the GEM handle count
> reaches 0.

Thanks.  I've incorporated your comments.

Alex

>
> Regards,
>    Felix
>
>
> > +
> > +Import Memory
> > +-------------
> > +To import remote memory, the UALink handle from the remote node must b=
e
> > +converted from a UALink handle to a local GEM object which represents =
the local
> > +reference to the NPA space on the importer.  If the memory has already=
 been
> > +imported, it just returns a new reference to the existing GEM object. =
 If not,
> > +the importer queries the exporter to get the NPA address.  Once it has=
 that, the
> > +importer can create the GEM to represent the NPA space used by the all=
ocation.
> > +The GEM object is then exported to the caller as a dma-buf. The dma-bu=
f is
> > +leveraged for dynamic attachment which provides the ability to revoke =
access
> > +when necessary.
> > +
> > +
> > +Device to Device Communications
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Devices communicate via a protocol implemented in firmware.  Mesages s=
ent to a
> > +remote node generate an interrupt on that node for servicing.
