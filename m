Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44097C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 16:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DAE160EB1
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 16:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DAE160EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8ECE6E526;
	Mon, 11 Oct 2021 16:05:43 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4E86E526
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 16:05:41 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id a3so25269325oid.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 09:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nSee7KtM9X8rG8D4MwSrt8EM6ucCH+R9nFgw8OJr1AU=;
 b=Xbw13qTZgagmtSPY2rkIeitbwLTrOeLJsy7CPRw/8pWejPwsZ6evtyIxbGdmIGYidZ
 h2uaMAsH50bOz0WiGwRy8N1VNIveB9R2u0QjgJD6wjP4gpcAkY8sRkol6sv3zMFa8Nf8
 bKWL3HyDDMFFhg2qYUrpvnV7P4LKEqLcnWowWFNRnckoMWbEUpqdJkcn6Vpritb8d9Uj
 +HyufEA8QSjWT/MxFNp+d8Do3ERe9t26x7JiQG4nJInQ/sxLWkkCYo9C9wHz3dSvFjmd
 H8eMNg0GEtOEfGLsZ0gJHjoVVJ3gBwlv+4wB8iSNBv+fxtUTpF57TMna90RZGxK2lqOq
 sy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nSee7KtM9X8rG8D4MwSrt8EM6ucCH+R9nFgw8OJr1AU=;
 b=2j3DH/w2wtO8N9tvPK9Gq/0mSsc32kn2/gbSIEunTqRSusoRsV7nXG/ElrlGUfz+8c
 IvZ6t9WSM91kkIl5/UMsu/r84WVKiMdFfqJnRgZ3P50p7ejDOUxJef3ANZ5OI6qvURKw
 SyDp4SvDoSfK0pMpv1TRqjyJDiYovvAGzPKOW8OmLx/Zz0Td2J9GOzNb1kLNHjjFYWIi
 0BrGJh7AEoqeW14g1x/q/Yy6SKqTwXO9jjMaClb4PmspLFO497qMtm+gqFH3nZLd0L+n
 XO3liqq25nxAEY7TUEDzxJf1e/0epPht15xlh4PAD+8EHBywl4xdTcn//EkFPyb1SBQW
 k11w==
X-Gm-Message-State: AOAM5304u3hDE0KOhINVPMrWtmnO7U34vYffuuHQVU1Fd0Bom4fbhslw
 1n/oYUPNLBZpuvfK1jFn6uDoCfisyddt8BF3OBk=
X-Google-Smtp-Source: ABdhPJw2XouqEqIRocixtR0bpAG0gAlXUGFHRFTt4Dmg4x0Q7IOfR3tDAxZZYMHgAdFeCICbirtK9QIj4YjudSzLW0U=
X-Received: by 2002:a05:6808:1141:: with SMTP id
 u1mr18793414oiu.123.1633968340570; 
 Mon, 11 Oct 2021 09:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
 <YWQ3963xcO3xbFo5@zn.tnic>
 <87d93314-ba3e-464f-d051-84a8de674b06@amd.com>
 <139ed784-d622-b0d2-3650-736b42e624f0@molgen.mpg.de>
 <be2b3cca-9822-4bb7-12b4-4c5c89318625@amd.com>
 <8b21ebbd-f7ca-8af3-5398-8320c6ed6422@molgen.mpg.de>
 <CADnq5_OLaFFuK-LaEw+aXdbJcXa0pEUEBJaCbaeuOxVbEat_oA@mail.gmail.com>
 <YWRgN63FOrQGO8jS@zn.tnic>
In-Reply-To: <YWRgN63FOrQGO8jS@zn.tnic>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Oct 2021 12:05:29 -0400
Message-ID: <CADnq5_PtpbRrpkK2KQ=UOJughGRymOcO7J4KU+SnbiiD8Z+8Ag@mail.gmail.com>
Subject: Re: [PATCH -v2] x86/Kconfig: Do not enable
 AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT automatically
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

On Mon, Oct 11, 2021 at 12:03 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Ok,
>
> here's v2, I've added "however" number 3 below which should summarize
> Christian's note about coherent and concurrent use of memory by the GPU
> and CPU, which obviously cannot work with bounce buffers.
>
> I'll send it to Linus next week if there are no more complaints.
>
> Thx.
>
> ---
> From: Borislav Petkov <bp@suse.de>
>
> This Kconfig option was added initially so that memory encryption is
> enabled by default on machines which support it.
>
> However, devices which have DMA masks that are less than the bit
> position of the encryption bit, aka C-bit, require the use of an IOMMU
> or the use of SWIOTLB.
>
> If the IOMMU is disabled or in passthrough mode, the kernel would switch
> to SWIOTLB bounce-buffering for those transfers.
>
> In order to avoid that,
>
>   2cc13bb4f59f ("iommu: Disable passthrough mode when SME is active")
>
> disables the default IOMMU passthrough mode so that devices for which the
> default 256K DMA is insufficient, can use the IOMMU instead.
>
> However 2, there are cases where the IOMMU is disabled in the BIOS, etc.
> (think the usual hardware folk "oops, I dropped the ball there" cases) or a
> driver doesn't properly use the DMA APIs or a device has a firmware or
> hardware bug, e.g.:
>
>   ea68573d408f ("drm/amdgpu: Fail to load on RAVEN if SME is active")
>
> However 3, in the above GPU use case, there are APIs like Vulkan and
> some OpenGL/OpenCL extensions which are under the assumption that
> user-allocated memory can be passed in to the kernel driver and both the
> GPU and CPU can do coherent and concurrent access to the same memory.
> That cannot work with SWIOTLB bounce buffers, of course.
>
> So, in order for those devices to function, drop the "default y" for the
> SME by default active option so that users who want to have SME enabled,
> will need to either enable it in their config or use "mem_encrypt=on" on
> the kernel command line.
>
>  [ tlendacky: Generalize commit message. ]
>
> Fixes: 7744ccdbc16f ("x86/mm: Add Secure Memory Encryption (SME) support")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: <stable@vger.kernel.org>
> Link: https://lkml.kernel.org/r/8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  arch/x86/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index bd70e8a39fbf..d9830e7e1060 100644
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
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
