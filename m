Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE500C5475B
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 05:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6044B10F104;
	Thu, 14 Mar 2024 05:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="QLjAqyIl";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B10710F104
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 05:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1710395595; x=1711000395; i=friedrich.vock@gmx.de;
 bh=Yu2m2f7oypI6/NNgrnFiPk7uE/x34rG/0v9DQgwkznw=;
 h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
 b=QLjAqyIlUYsv5K29ajrJBvDWHM7/pHMVZvf/1ZIgUP3EJ2NBJnSPFfqEtd348zdH
 9eM3pou1IiCpE4EekZukfFLoGBJrCZoTez1q3MhD4SJ4U/1ewjZlNQK0h66o4NohJ
 UMiXD+zwDifRKXuOZ7xGXQGWYfIsx9rhVcqLauq3K5MoWt6vIC9hBQYZl1zHjhFvv
 6Prxazqu1z3OHFROfBL7m2bMdyRD+AqZiSj3Xd2geUZI2m9v57zfgBqKIF2sZaExx
 +TvgSISMnKwIPhpWMH5n+6qXqPCESdBLr6nJaG4zzLU0XTFCbnnEfx89cwF0KXqYb
 ZXKyiINZVLoAj0VGEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.177.3] ([213.152.118.97]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvY2-1rFvsA3fOK-00Up6f; Thu, 14
 Mar 2024 06:53:14 +0100
Message-ID: <f632c497-aa97-427c-a35b-a2bb47e0d8c1@gmx.de>
Date: Thu, 14 Mar 2024 06:53:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Friedrich Vock <friedrich.vock@gmx.de>
Subject: Re: [PATCH] Documentation: add a page on amdgpu debugging
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240313210147.484930-1-alexander.deucher@amd.com>
Content-Language: en-US
Autocrypt: addr=friedrich.vock@gmx.de; keydata=
 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
 f7+xmX0X3AMtWz/15Y+7cPO2
In-Reply-To: <20240313210147.484930-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nKczI6sdRCFBe/cisyKZPfmiKOg4Gxho6yHYeQ1CSIPDcvm5Sw7
 0Yc2DjQipkgjYe+vpd6CfGGLixKOxTZa0BeuQE/faFQpT/5qYte9ee1YihNqdUlvNrqui1b
 yiGh8yt0EKATOw0dgV+Gylfq2wilVUhuQ1zdFhaF+oj7DPzsQ0VM3vnu7HI/MwIoEuL5o5S
 Ah/HjvjORIZViI4o643mA==
UI-OutboundReport: notjunk:1;M01:P0:cz/EQL8Tmz0=;H8v6PUYjGnqmmtAv20/QxjNfq8r
 CW1A9FidW1Onl6a+8/1vru7ypcjh7HVDjWcpLbRYhvl/NWT0yljjy8ATQhcIZsaSMoKAGww21
 Yqo52li/vLzuqb/aWr+4Y7poYO/2/lZFWlU6V33tg34T586VvisC9LDfQYZLdYX/BwVixLRex
 8+ewyx8cDkG9PJc5vv1Dz4gE7NYY01hlBDP+VZfE96yAd5jTA+9w2oDyN72noKYlxy39X9M/M
 W7sODwzTItoy6L7NB04j0ehktqcg+yyFBCIuXl52bRX4CMzlFIcuDKgtbZ9ts2snBpKpTBcs2
 RLB3KBFIo8upd2r0Qj+TqRirdiNj2DbzclrAT0i6YIEeLONnE8wCWMrJY6k65Nk2KY1sfBuDs
 4n1AbvISInwDmePHyo+2BQZq1zHltQGXA/RHI9SOz+lfxbVFVd0n9aaTL0bJJ0NzaX63QymPJ
 6ePGmd9arnSwCy8o/djgAA4T07hkaIvR8JzW4m5MfHhu8mseTbGJ74lxSH+i+uIC0KkVJLzYh
 dpQsrag35hwoukAR8U96EZBs1gZsbbTzY5Nwi9SXYEG2xVAlQjXmHvDtWJFPCvPPi8BNaDh1H
 9MhWsqI9jqhRFYlaKkjY4L/hpgsrg563mnIre9Oit8VYkx5E8HEcQ7e7lLVBxxShobZYm1emQ
 Srp/sN+Di+roJs10A8esoxho0fOCHFAVSMaSTKwwCRdKyS1HFduXQl2Wv+qeT2wkiF+JP1N4y
 Z4dDUiGjF3wdbSxU68dhY6c12mu4Gf5dDW+Tl4cDiKZaW8OPAEGlydWtAncEsBbQMBPoXT2Qh
 PRTRhZeXWrUMuUThJ6/6RrmsNG3V2tP9SsQcX6WMjDiAk=
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

On 13.03.24 22:01, Alex Deucher wrote:
> Covers GPU page fault debugging and adds a reference
> to umr.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   Documentation/gpu/amdgpu/debugging.rst | 79 ++++++++++++++++++++++++++
>   Documentation/gpu/amdgpu/index.rst     |  1 +
>   2 files changed, 80 insertions(+)
>   create mode 100644 Documentation/gpu/amdgpu/debugging.rst
>
> diff --git a/Documentation/gpu/amdgpu/debugging.rst b/Documentation/gpu/=
amdgpu/debugging.rst
> new file mode 100644
> index 000000000000..29971a7a6815
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
> +To aid in debugging GPU virtual memory related problems, the driver sup=
ports a
> +number of options module paramters:
> +
> +`vm_fault_stop` - If non-0, halt the GPU memory controller on a GPU pag=
e fault.
> +
> +`vm_update_mode` - If non-0, use the CPU to update GPU page tables rath=
er than
> +the GPU.
> +
> +
> +Decoding a GPUVM Page Fault
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +If you see a GPU page fault in the kernel log, you can decode it to fig=
ure
> +out what is going wrong in your application.  A page fault in your kern=
el
> +log may look something like this:
> +
> +::
> +
> + [gfxhub0] no-retry page fault (src_id:0 ring:24 vmid:3 pasid:32777, fo=
r process glxinfo pid 2424 thread glxinfo:cs0 pid 2425)
> +   in page starting at address 0x0000800102800000 from IH client 0x1b (=
UTCL2)
> + VM_L2_PROTECTION_FAULT_STATUS:0x00301030
> + 	Faulty UTCL2 client ID: TCP (0x8)
> + 	MORE_FAULTS: 0x0
> + 	WALKER_ERROR: 0x0
> + 	PERMISSION_FAULTS: 0x3
> + 	MAPPING_ERROR: 0x0
> + 	RW: 0x0
> +
> +First you have the memory hub, gfxhub and mmhub.  gfxhub is the memory
> +hub used for graphics, compute, and sdma on some chips.  mmhub is the
> +memory hub used for multi-media and sdma on some chips.
> +
> +Next you have the vmid and pasid.  If the vmid is 0, this fault was lik=
ely
> +caused by the kernel driver or firmware.  If the vmid is non-0, it is g=
enerally
> +a fault in a user application.  The pasid is used to link a vmid to a s=
ystem
> +process id.  If the process is active when the fault happens, the proce=
ss
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
> +- TCP: Shaders

For shader accesses, maybe including SQC (data)/SQC (inst) for SMEM
accesses/instruction prefetching would be useful?

Thanks,
Friedrich

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
> +Finally, RW, indicates whether the access was a read (0) or a write (1)=
.
> +
> +In the example above, a shader (cliend id =3D TCP) generated a read (RW=
 =3D 0x0) to
> +an invalid page (PERMISSION_FAULTS =3D 0x3) at GPU virtual address
> +0x0000800102800000.  The user can then inspect can then inspect their s=
hader
> +code and resource descriptor state to determine what caused the GPU pag=
e fault.
> +
> +UMR
> +=3D=3D=3D
> +
> +`umr<https://gitlab.freedesktop.org/tomstdenis/umr>`_ is a general purp=
ose
> +GPU debugging and diagnostics tool.  Please see the umr documentation f=
or
> +more information about its capabilities.
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdg=
pu/index.rst
> index 912e699fd373..847e04924030 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -15,4 +15,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) =
architectures.
>      ras
>      thermal
>      driver-misc
> +   debugging
>      amdgpu-glossary
