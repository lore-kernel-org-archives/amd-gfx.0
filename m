Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8032DC54E67
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 16:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E688510FE36;
	Fri, 15 Mar 2024 16:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XxjP0+Fd";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E44110FE36
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 16:44:45 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1dd9066b7c3so16655255ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710521085; x=1711125885; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tsDhVW89tF+Qu8fD9oV+RCIpwRcajF+955rDL5O0Ec=;
 b=XxjP0+Fd7OlZgj6+GTepUvxqEHN++fQx62jpKBpXcHLF/+YJuk+tQH/Tw0K56BN1wJ
 G1LHXbUEQcEjrg2i5GinmlCO0Trk9yB7NPUgHhgPOjX+cqkLrbczBzqNJBkkcKE59Ltu
 XTQUH+evT6uynrkwaKNwnp5ljBVDkinuz5fjSPtB7GjoNdpImj8v7ZhWNuNeyjuMkj0H
 xpYe1h6drDscfeFHhJQANMYkhFuRZPFzeXU8ajVQdORH/DmfpRZjj3bql3YMFTQadc0k
 7tocEH6J7Y6mF8SjLsV7voLtlsHSgkfidDfzz7DayNmCBrIntFVQQ5BQIbte0u6bAzut
 njyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710521085; x=1711125885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tsDhVW89tF+Qu8fD9oV+RCIpwRcajF+955rDL5O0Ec=;
 b=PiwrJLEU4TPN3d6R/bTnyk0m75oNQkHUWluZkMV510dfNleI20FfUQnlYip5ETlWVk
 dLNQHfW2t2SS41sdaiL88LQdhZx0lkY0ZnSSeZ4ZXiorKdalDjZ+qPvj7HJ58lslPT4V
 TlKkpPbL7pIb7vmtgAwh2Qeb7uobB3CH4qnvnRgU2AJ13xZCieiMu1pUNDJPzB+hdoGa
 ZwvgCtyh5uI9emM1S8jvCXctWmsuUDGdMIlR1+K2VpjH7M4CMw25UYHktaggZ4VOPCbC
 Uo1+4m1uXR4pxaz4sDG/Sj/ApfSBedKXnasdMHmnVS8XdgMFysDAZs1+scwOq2uvAaWe
 eLSA==
X-Gm-Message-State: AOJu0YzecDeInhjNAKf4LbZDgN1O1LOL92YLPz8uYRSnchgfaMms+Lbi
 7aGIOvXC/MpRCuUEn0biPMEvntMycgDz6CV5KnzvqPIAZkdw8xDNioGV9EQQWm5jWJf0tCFduVo
 zS9LOznvMpDOmdVpmVCJ7mvZCCmc=
X-Google-Smtp-Source: AGHT+IEHwS1lQj7WDLBNziepsrqpAeaYo7/4IaoBEwwgVrEYUkZZ1ko1Ox/c2gWhESw8inXmFE0Oxo7kTCoudooCAr8=
X-Received: by 2002:a17:903:1251:b0:1dc:696d:ec6e with SMTP id
 u17-20020a170903125100b001dc696dec6emr5724853plh.21.1710521085287; Fri, 15
 Mar 2024 09:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240315160108.2595995-1-alexander.deucher@amd.com>
In-Reply-To: <20240315160108.2595995-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Mar 2024 12:44:33 -0400
Message-ID: <CADnq5_PMfhTQ+=aSJ5DqCj3p5hjbQUHZsx=3xXc0FEqL_9WDiQ@mail.gmail.com>
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

On Fri, Mar 15, 2024 at 12:07=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Covers GPU page fault debugging and adds a reference
> to umr.
>
> v2: update client ids to include SQC/G
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  Documentation/gpu/amdgpu/debugging.rst | 79 ++++++++++++++++++++++++++
>  Documentation/gpu/amdgpu/index.rst     |  1 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/debugging.rst
>
> diff --git a/Documentation/gpu/amdgpu/debugging.rst b/Documentation/gpu/a=
mdgpu/debugging.rst
> new file mode 100644
> index 000000000000..8b7fdcdf1158
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/debugging.rst
> @@ -0,0 +1,79 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + GPU Debugging
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +GPUVM Debugging
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To aid in debugging GPU virtual memory related problems, the driver supp=
orts a
> +number of options module paramters:
> +
> +`vm_fault_stop` - If non-0, halt the GPU memory controller on a GPU page=
 fault.
> +
> +`vm_update_mode` - If non-0, use the CPU to update GPU page tables rathe=
r than
> +the GPU.
> +
> +
> +Decoding a GPUVM Page Fault
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +If you see a GPU page fault in the kernel log, you can decode it to figu=
re
> +out what is going wrong in your application.  A page fault in your kerne=
l
> +log may look something like this:
> +
> +::
> +
> + [gfxhub0] no-retry page fault (src_id:0 ring:24 vmid:3 pasid:32777, for=
 process glxinfo pid 2424 thread glxinfo:cs0 pid 2425)
> +   in page starting at address 0x0000800102800000 from IH client 0x1b (U=
TCL2)
> + VM_L2_PROTECTION_FAULT_STATUS:0x00301030
> +       Faulty UTCL2 client ID: TCP (0x8)
> +       MORE_FAULTS: 0x0
> +       WALKER_ERROR: 0x0
> +       PERMISSION_FAULTS: 0x3
> +       MAPPING_ERROR: 0x0
> +       RW: 0x0
> +
> +First you have the memory hub, gfxhub and mmhub.  gfxhub is the memory
> +hub used for graphics, compute, and sdma on some chips.  mmhub is the
> +memory hub used for multi-media and sdma on some chips.
> +
> +Next you have the vmid and pasid.  If the vmid is 0, this fault was like=
ly
> +caused by the kernel driver or firmware.  If the vmid is non-0, it is ge=
nerally
> +a fault in a user application.  The pasid is used to link a vmid to a sy=
stem
> +process id.  If the process is active when the fault happens, the proces=
s
> +information will be printed.
> +
> +The GPU virtual address that caused the fault comes next.
> +
> +The client ID indicates the GPU block that caused the fault.
> +Some common client IDs:
> +
> +- CB/DB: The color/depth backend of the graphics pipe
> +- CPF: Command Processor Frontend
> +- CPC: Command Processor Compute
> +- CPG: Command Processor Graphics
> +- TCP/SQC/SQG: Shaders
> +- SDMA: SDMA engines
> +- VCN: Video encode/decode engines
> +- JPEG: JPEG engines
> +
> +PERMISSION_FAULTS describe what faults were encountered:
> +
> +- bit 0: the PTE was not valid
> +- bit 1: the PTE read bit was not set
> +- bit 2: the PTE write bit was not set
> +- bit 3: the PTE execute bit was not set
> +
> +Finally, RW, indicates whether the access was a read (0) or a write (1).
> +
> +In the example above, a shader (cliend id =3D TCP) generated a read (RW =
=3D 0x0) to
> +an invalid page (PERMISSION_FAULTS =3D 0x3) at GPU virtual address
> +0x0000800102800000.  The user can then inspect can then inspect their sh=
ader

removed the duplicated text above locally.

Alex

> +code and resource descriptor state to determine what caused the GPU page=
 fault.
> +
> +UMR
> +=3D=3D=3D
> +
> +`umr <https://gitlab.freedesktop.org/tomstdenis/umr>`_ is a general purp=
ose
> +GPU debugging and diagnostics tool.  Please see the umr documentation fo=
r
> +more information about its capabilities.
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgp=
u/index.rst
> index 912e699fd373..847e04924030 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -15,4 +15,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) a=
rchitectures.
>     ras
>     thermal
>     driver-misc
> +   debugging
>     amdgpu-glossary
> --
> 2.44.0
>
