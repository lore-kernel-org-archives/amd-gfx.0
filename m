Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0087C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4A561039
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F4A561039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1920489216;
	Wed,  6 Oct 2021 18:10:43 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B1D89216
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 18:10:42 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 5-20020a9d0685000000b0054706d7b8e5so4217990otx.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Oct 2021 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vDJG33beoekgnoibdIUsfRXOx9O3G1/t6zYh/kfqMkc=;
 b=H0DIO9Ii0mRx0UpHPomb5+nZMKQtVZfVVIuojCoaiHoX7ia16/vO/R2921fQgLVlV2
 IfGGE1RQRE+IhWgnasPSfVtu8gFWjCrLJqTH2+7xc4hcklCtNks4WaBMmb5TeARfr5ho
 Vd5aT4WZnTwAOpeOcVCqUKqLFZem/dhMK1aYLq9uSkcCzZkYP/3A4j6HJf1T4uvsxAh3
 HyhYPsdg1+9y++eiynSoiIkEa2KpeS6HbKlJDXZaXVj1Nw6zW8JDsWCWOmg/yUYwDger
 TRqqTcD5PNuXYZiheR6fdhaIKEzv+HezvqhduSaUKIb41xYkD1dJkCxT8I3PVoTVpX9T
 6zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vDJG33beoekgnoibdIUsfRXOx9O3G1/t6zYh/kfqMkc=;
 b=Pxh+GGp4qEQRw04xA7+VFQcRHFuLeAHFUc/AkGH5/f8pQcaF8EXncGr482FE6yS8Iy
 Ek6e6txcy7idsQgXUGt2IgA29UpxPelExQXAxxQwHhLmk/tJgVA8UvZqPfPGwxyyQiNy
 nSb0m4C75+VZydMr21T2yOE0myA32obkjoyABbmEJVuP0IsfyNyzDWn/xp4wwUCj7751
 jTwRFP+LL7WHpocO2Tstzw96+9rpypFb5yyu3wWlNd6OZQfmq1/nROlE4ORnARdSTCN1
 R483CbkyHXL1qCGI5R7S9CDApmXEniW9MDWhtjejXT8UDzZbNhbSiKxNGSh/sBJTFev3
 GXqQ==
X-Gm-Message-State: AOAM533Jm27Dp0Ysjp6QH5pRW0MlhcAe/TtYrOlpV+MN3PScFQzBCihP
 Lr05XwClJ3iJJv/6EvbOaydoSAxhFHKlJS159OA=
X-Google-Smtp-Source: ABdhPJykj0/VkYXXLu+qLjHrqNh2F/gadqD3VfJNaPGpd4zaqwOar9O4qZCsU5MO3xosaeHAbnx/JLnnBP56Uy0Z8mY=
X-Received: by 2002:a05:6830:214c:: with SMTP id
 r12mr148129otd.200.1633543841270; 
 Wed, 06 Oct 2021 11:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
In-Reply-To: <YV3hbK/uhChK5Pse@zn.tnic>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Oct 2021 14:10:30 -0400
Message-ID: <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 X86 ML <x86@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 6, 2021 at 1:48 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Ok,
>
> so I sat down and wrote something and tried to capture all the stuff we
> so talked about that it is clear in the future why we did it.
>
> Thoughts?
>
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Wed, 6 Oct 2021 19:34:55 +0200
> Subject: [PATCH] x86/Kconfig: Do not enable AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
>  automatically
>
> This Kconfig option was added initially so that memory encryption is
> enabled by default on machines which support it.
>
> However, Raven-class GPUs, a.o., cannot handle DMA masks which are
> shorter than the bit position of the encryption, aka C-bit. For that,
> those devices need to have the IOMMU present.

This is not limited to Raven.  All GPUs (and quite a few other
devices) have a limited DMA mask.  AMD GPUs have between 32 and 48
bits of DMA depending on what generation the hardware is.  So to
support SME, you either need swiotlb with bounce buffers or you need
IOMMU in remapping mode. The limitation with Raven is that if you want
to use it with the IOMMU enabled it requires the IOMMU to be set up in
passthrough mode to support IOMMUv2 functionality for compute support
and due to other hardware limitations on the display side. So for all
GPUs except raven, just having IOMMU enabled in remapping mode is
fine.  GPUs from other vendors would likely run into similar
limitations.  Raven just has further limitations.


>
> If the IOMMU is disabled or in passthrough mode, though, the kernel
> would switch to SWIOTLB bounce-buffering for those transfers.
>
> In order to avoid that,
>
>    2cc13bb4f59f ("iommu: Disable passthrough mode when SME is active")
>
> disables the default IOMMU passthrough mode so that devices for which
> the default 256K DMA is insufficient, can use the IOMMU instead.
>
> However 2, there are cases where the IOMMU is disabled in the BIOS, etc,
> think the usual hardware folk "oops, I dropped the ball there" cases.
>
> Which means, it can happen that there are systems out there with devices
> which need the IOMMU to function properly with SME enabled but the IOMMU
> won't necessarily be enabled.
>
> So in order for those devices to function, drop the "default y" for
> the SME by default on option so that users who want to have SME, will
> need to either enable it in their config or use "mem_encrypt=on" on the
> kernel command line.

Another option would be to enable SME by default on Epyc platforms,
but disabled by default on client APU platforms or even just raven.

Other than these comments, looks fine to me.

Alex

>
> Fixes: 7744ccdbc16f ("x86/mm: Add Secure Memory Encryption (SME) support")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: <stable@vger.kernel.org>
> Link: https://lkml.kernel.org/r/8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de
> ---
>  arch/x86/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8055da49f1c0..6a336b1f3f28 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1525,7 +1525,6 @@ config AMD_MEM_ENCRYPT
>
>  config AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
>         bool "Activate AMD Secure Memory Encryption (SME) by default"
> -       default y
>         depends on AMD_MEM_ENCRYPT
>         help
>           Say yes to have system memory encrypted by default if running on
> --
> 2.29.2
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
