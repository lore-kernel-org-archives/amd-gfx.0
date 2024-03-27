Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8B3C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 03:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB7810F788;
	Wed, 27 Mar 2024 03:49:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TgUBhkMH";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C26C410F788
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 03:49:19 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-6e6b5432439so4869699b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 20:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711511359; x=1712116159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahizVKV3HxZnYGdzaZMwVxNLtGaVVu7SPtBSWPIU+1M=;
 b=TgUBhkMHTTcDb5X6Q6oeybnhly4010+KvNQRHNa3V3aHblVRjLu16/hWRWm+WdOsws
 IT34EBdyI2lu4mi66DRXPa322FB+5KOnFT5m6df9ekeI7tjRX7duJS5+X+8kEqRF0Cpk
 oQQaywMwpYClSEJ4K6TRUTG7U/Ukj+gfNFod9TNF2OGORJW3RXgBrrXXFfO8Au+FQm+j
 bjShtz64EzzSVqfnz54HJRa+Uya6N7vW6GgdHGce5iu3lQF1L5T+E0n+X2yfUvQuwseb
 ZLLgZWVtyWUnQZw8qK2i55ywFxD9Z6jpjLmzcc2lemPcILb5kcOtfB0KbUpP7KSNjWNk
 2evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711511359; x=1712116159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahizVKV3HxZnYGdzaZMwVxNLtGaVVu7SPtBSWPIU+1M=;
 b=Nm/pBzTu9qV4KYuliduXohvxzn8cNhT8GFk5rgZjMYHdKQpGf8WW825hJ92W62kM2w
 yAonN5HrTCNUKvVObcdBR1HIwQaAviRp2Ng+9GX4NGqKkngHmprgVUWknqIMVzehB7JN
 FrwCdQr8nTcC2QdJZl6oomNOVbzH+xkKjikRAtbNCDzlO4rofjStENwh4nid5kUvRnWu
 Ub5nObeVB6gSXib9s9go4XtmWq+kQ1PZPCa+WW7gc81Ct701IRKoo6mm/pRnouZSlT89
 aYxtjhskqVB62PElB/K8qZ1kNIE7acfM8WQKb+kG6Tihwta8CTb/F7bnpi30yVfuLZ9g
 4uBQ==
X-Gm-Message-State: AOJu0YzG3i5t1i+89AKzO8/cymJJEk6QVJSln1Jh+vZUXL2hHWToZWPY
 b++AK+iXKeNzz9SIf5zOQFvbib7Wmo9LERIxc+GqkIDyREBI81lvBAypv7ttvAhCsQqB0dt3ZJp
 a0fU4iIj2XOe00SZVuAfv31B+Q+GzSmuD
X-Google-Smtp-Source: AGHT+IEg7LIzuCNahzufViHYCcZDd17l8+YhB2BGqIGGIgOiswQJ18JvLBObdVqKlYKOHhGOjZAELKS9BayrvZ/Ac5w=
X-Received: by 2002:a05:6a21:3a45:b0:1a3:5d2a:4001 with SMTP id
 zu5-20020a056a213a4500b001a35d2a4001mr3409020pzb.44.1711511358945; Tue, 26
 Mar 2024 20:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240315160108.2595995-1-alexander.deucher@amd.com>
 <CADnq5_PMfhTQ+=aSJ5DqCj3p5hjbQUHZsx=3xXc0FEqL_9WDiQ@mail.gmail.com>
In-Reply-To: <CADnq5_PMfhTQ+=aSJ5DqCj3p5hjbQUHZsx=3xXc0FEqL_9WDiQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Mar 2024 23:49:06 -0400
Message-ID: <CADnq5_NXhigQc3OPO+ZJYW6_WOg8=yz92Jh1JFSUedwaWCtp5Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add a page on amdgpu debugging
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

ping?

On Fri, Mar 15, 2024 at 12:44=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Fri, Mar 15, 2024 at 12:07=E2=80=AFPM Alex Deucher <alexander.deucher@=
amd.com> wrote:
> >
> > Covers GPU page fault debugging and adds a reference
> > to umr.
> >
> > v2: update client ids to include SQC/G
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  Documentation/gpu/amdgpu/debugging.rst | 79 ++++++++++++++++++++++++++
> >  Documentation/gpu/amdgpu/index.rst     |  1 +
> >  2 files changed, 80 insertions(+)
> >  create mode 100644 Documentation/gpu/amdgpu/debugging.rst
> >
> > diff --git a/Documentation/gpu/amdgpu/debugging.rst b/Documentation/gpu=
/amdgpu/debugging.rst
> > new file mode 100644
> > index 000000000000..8b7fdcdf1158
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/debugging.rst
> > @@ -0,0 +1,79 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > + GPU Debugging
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +GPUVM Debugging
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +To aid in debugging GPU virtual memory related problems, the driver su=
pports a
> > +number of options module paramters:
> > +
> > +`vm_fault_stop` - If non-0, halt the GPU memory controller on a GPU pa=
ge fault.
> > +
> > +`vm_update_mode` - If non-0, use the CPU to update GPU page tables rat=
her than
> > +the GPU.
> > +
> > +
> > +Decoding a GPUVM Page Fault
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +
> > +If you see a GPU page fault in the kernel log, you can decode it to fi=
gure
> > +out what is going wrong in your application.  A page fault in your ker=
nel
> > +log may look something like this:
> > +
> > +::
> > +
> > + [gfxhub0] no-retry page fault (src_id:0 ring:24 vmid:3 pasid:32777, f=
or process glxinfo pid 2424 thread glxinfo:cs0 pid 2425)
> > +   in page starting at address 0x0000800102800000 from IH client 0x1b =
(UTCL2)
> > + VM_L2_PROTECTION_FAULT_STATUS:0x00301030
> > +       Faulty UTCL2 client ID: TCP (0x8)
> > +       MORE_FAULTS: 0x0
> > +       WALKER_ERROR: 0x0
> > +       PERMISSION_FAULTS: 0x3
> > +       MAPPING_ERROR: 0x0
> > +       RW: 0x0
> > +
> > +First you have the memory hub, gfxhub and mmhub.  gfxhub is the memory
> > +hub used for graphics, compute, and sdma on some chips.  mmhub is the
> > +memory hub used for multi-media and sdma on some chips.
> > +
> > +Next you have the vmid and pasid.  If the vmid is 0, this fault was li=
kely
> > +caused by the kernel driver or firmware.  If the vmid is non-0, it is =
generally
> > +a fault in a user application.  The pasid is used to link a vmid to a =
system
> > +process id.  If the process is active when the fault happens, the proc=
ess
> > +information will be printed.
> > +
> > +The GPU virtual address that caused the fault comes next.
> > +
> > +The client ID indicates the GPU block that caused the fault.
> > +Some common client IDs:
> > +
> > +- CB/DB: The color/depth backend of the graphics pipe
> > +- CPF: Command Processor Frontend
> > +- CPC: Command Processor Compute
> > +- CPG: Command Processor Graphics
> > +- TCP/SQC/SQG: Shaders
> > +- SDMA: SDMA engines
> > +- VCN: Video encode/decode engines
> > +- JPEG: JPEG engines
> > +
> > +PERMISSION_FAULTS describe what faults were encountered:
> > +
> > +- bit 0: the PTE was not valid
> > +- bit 1: the PTE read bit was not set
> > +- bit 2: the PTE write bit was not set
> > +- bit 3: the PTE execute bit was not set
> > +
> > +Finally, RW, indicates whether the access was a read (0) or a write (1=
).
> > +
> > +In the example above, a shader (cliend id =3D TCP) generated a read (R=
W =3D 0x0) to
> > +an invalid page (PERMISSION_FAULTS =3D 0x3) at GPU virtual address
> > +0x0000800102800000.  The user can then inspect can then inspect their =
shader
>
> removed the duplicated text above locally.
>
> Alex
>
> > +code and resource descriptor state to determine what caused the GPU pa=
ge fault.
> > +
> > +UMR
> > +=3D=3D=3D
> > +
> > +`umr <https://gitlab.freedesktop.org/tomstdenis/umr>`_ is a general pu=
rpose
> > +GPU debugging and diagnostics tool.  Please see the umr documentation =
for
> > +more information about its capabilities.
> > diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amd=
gpu/index.rst
> > index 912e699fd373..847e04924030 100644
> > --- a/Documentation/gpu/amdgpu/index.rst
> > +++ b/Documentation/gpu/amdgpu/index.rst
> > @@ -15,4 +15,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA)=
 architectures.
> >     ras
> >     thermal
> >     driver-misc
> > +   debugging
> >     amdgpu-glossary
> > --
> > 2.44.0
> >
