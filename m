Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D40AC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 14:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA6310E1D3;
	Tue, 22 Nov 2022 14:12:19 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4646A10E1D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 14:12:16 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-14286d5ebc3so14052240fac.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 06:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fnk6I4i+IQT7oC3cvWQnuIHaKdiQ8/CvwU8yPeOGi7E=;
 b=HtnFBx/tlb5CmtOvRGDkitL8H50pAfHWR6xK6+Rl4EV7lbJA4zF7yQjwACcnlm2/I8
 2/W84MitFTMRRidwsxgqiCt8b84YXsNVeAALbOzCdrZeO6lWvDPrMu35zfCiP9apOA7U
 vv6HJVA/trdviUUno/jP5MciGFjvknVFKwnmlvTlTk0SL/IH0TQe4S82sGY/ZPvVTcAv
 vCvuR4hoD5+b1dVn6+uD/cuuZoiD2R8w4behZnUHcJLpPtwfI5/ItAIXaPM/yO1Vgqip
 mIveLGeHtHLDUfZBBu7xwmaOgU2qlFzBz31aNGE+0dH6+4ueb7d+XPjmOD4uPzHddktz
 +EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fnk6I4i+IQT7oC3cvWQnuIHaKdiQ8/CvwU8yPeOGi7E=;
 b=75i2yWOMtH4iYstL5F3FKyX+JotOVmrflU/t0pMOCiA/IvMWhhdo0y/EYbvGUCuRQb
 4BHpzGdCnw9gp3UjJm+V25Pmd0OxGzG8JADQuzBIJHvhk02h2kbH5ceq6MqNdT9DsaJK
 DhcVidz4JXQkhNazGQppC8DGf2tLPgwY1pVrBmumBykX8RLNn9GlqNmEYwb8YPJ5SIha
 Dcy/t7LuHyvuwbzeFAisKw7mGNA1BAMsqm2T6Ye5S+YWcNbY5fhH57nzhq4zGCekWlwq
 HNBnwPUvDUHKer9t/ltQRFe5KXonb/s9Ggqe4EcMnOFtFLMMlNa/5JlyZW5UuMkOj7wh
 ID3w==
X-Gm-Message-State: ANoB5pm3Bh3DW4kxCs0GMKnAE5X+Ilxf7EL2jjhknQjGmVdZe5K3cUq/
 +/x34VAiguJnH/6MBEHY+gNZpedhHQXrXuLsMSE=
X-Google-Smtp-Source: AA0mqf7u12LQ/o2l/pToTc96vlIsp8jB0Ndut4/lqjf315L/h+hgkUG+njS6VJtHXZjQWYO99k80lwdTuwyXANdstDc=
X-Received: by 2002:a05:6870:b07:b0:13b:d07f:f29d with SMTP id
 lh7-20020a0568700b0700b0013bd07ff29dmr2079655oab.96.1669126335372; Tue, 22
 Nov 2022 06:12:15 -0800 (PST)
MIME-Version: 1.0
References: <622f20c5-5c24-d1c5-f874-6cb80b365e2e@collabora.com>
In-Reply-To: <622f20c5-5c24-d1c5-f874-6cb80b365e2e@collabora.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Nov 2022 09:12:03 -0500
Message-ID: <CADnq5_PKxfk9wEbQp8Mcxszp8R02qqe6ZtuonZ-TH4Zg9Lhrdg@mail.gmail.com>
Subject: Re: Help debug amdgpu faults
To: Robert Beckett <bob.beckett@collabora.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Dmitrii Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?=
 <adrian.larumbe@collabora.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Daniel Stone <daniels@collabora.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 22, 2022 at 6:53 AM Robert Beckett
<bob.beckett@collabora.com> wrote:
>
> Hi,
>
>
> does anyone know any documentation, or can provide advice on debugging amdgpu fault reports?

This is a GPU page fault so it refers the the GPU virtual address
space of the application .  Each process (well fd really), gets its
own GPU virtual address space into which system memory, system mmio
space, or vram can be mapped.  The user mode drivers control their GPU
virtual address space.

>
>
> e.g:
>
> Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: [gfxhub] page fault (src_id:0 ring:8 vmid:1 pasid:32769, for process vkcube pid 999 thread vkcube pid 999)

This is the process that caused the fault.

> Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:   in page starting at address 0x0000800100700000 from client 0x1b (UTCL2)

This is the virtual address that faulted.

> Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00101A10
> Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          Faulty UTCL2 client ID: SDMA0 (0xd)

The fault came from the SDMA engine.

> Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          MORE_FAULTS: 0x0
> Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          WALKER_ERROR: 0x0
> Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          PERMISSION_FAULTS: 0x1

The page was not marked as valid in the GPU page table.

> Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          MAPPING_ERROR: 0x0
> Nov 21 19:17:06 fedora kernel: amdgpu 0000:01:00.0: amdgpu:          RW: 0x0

SDMA attempted to read an invalid page.

>
>
>
> see https://gitlab.freedesktop.org/drm/amd/-/issues/2267 for more context.
>
> We have a complicated setup involving rendering then blitting to virtio-gpu exported dmabufs, with plenty of hacks in the mesa and xwayland stacks, so we are considering this our issue to debug, and not an issue with the driver at this point.
> However, having debugged all the interesting parts leading to these faults, I am unable to decode the fault report to correlate to a buffer.
>
> in the fault report, what address space is the address from?
> given that the fault handler shifts the reported addres up by 12, I assume it is a 4K pfn which makes me assume a physical address is this correct?
> if so, is that a vram pa or a host system memory pa?
> is there any documentation for the other fields reported like the fault status etc?

See the comments above.  There is some kernel doc as well:
https://docs.kernel.org/gpu/amdgpu/driver-core.html#amdgpu-virtual-memory

>
> I'd appreciate any advice you could give to help us debug further.

Some operation you are doing in the user mode driver is reading an
invalid page.  Possibly reading past the end of a buffer or something
mis-aligned.  Compare the faulting GPU address to the GPU virtual
address space in the application and you should be able to track down
what is happening.

Alex

>
> Thanks
>
> Bob
>
