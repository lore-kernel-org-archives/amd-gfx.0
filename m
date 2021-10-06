Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856DCC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435516113A
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 18:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 435516113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DEC6EE02;
	Wed,  6 Oct 2021 18:37:08 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2FE6EE02
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 18:37:07 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 l16-20020a9d6a90000000b0053b71f7dc83so4286893otq.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Oct 2021 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0hugsBbFZUCDXNjsc+rGS4MvBKlrA0O8GjGIvI5uqac=;
 b=hHwBl24oGcmxhDDwfRwb/ze3Gxl536nKMitO2Ow9cOzjg6AWe7IFyhl++56ViyVrQm
 K8Lbfr0qim9BfXvS2RMqMc1GW/jI0nMFM/Owj06IfEtWGZG1QdoHarcCDYQFqHQk49km
 FnkSPQoB3UqIDiBP4cVgF6MY1FxQQq8MSaHi/NzC6iynU8IA2nqZUR5TYcJx7PQI2k1H
 UwZEbIk/F5n06P3YTODO+v9QVWVVoBt5/GRQlDyO8qJEOUWyyhBnZUGjIKq6OUD9g/GZ
 P0iCTfDmgUw5Jeg6fToV2goVvpH/aHD4VV7Npq0V6mGicpiebZ0Tp8PFapzOOeqPGewq
 5n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0hugsBbFZUCDXNjsc+rGS4MvBKlrA0O8GjGIvI5uqac=;
 b=CU+DqGkrGatEnxcwueKN/2TMgd0ZW0wisEPSRCjfcn8qYkPVLrkfZyOe1GiqC3wuqj
 8u0N3wI+1QCY6mbZfRiAPXVtuRRnGvgd2m/wUiopttyGMLIDpPDBu1Bfx8AYbxam4IH6
 HoIe2YyDs+jIIl9K5rVmyXGMMyRbJGRcLW/JiNiBsmLbH+8XfG53ZrSD65C2/PLH1ANR
 k4FcnSKfxEwJgieO/vqdMIiY/uP0Xx49c8+xyu8Xf052TrVyUqKGzeachnr7QX5+TXOw
 PYw4BWswH3goOKVCjIK7viXkpYH9uckFjxbmO6qc+hoeBtvtj/iqJypbmNSOsFa8sic3
 jaAw==
X-Gm-Message-State: AOAM532ug4OcFCYxZFOiobAPjEd1g81S+pAmapR4zJltLmZTNNoWXzfP
 DQbbh7xsqbS+LSgPKxgeNgEQ0dyDThwJ1t0cf48=
X-Google-Smtp-Source: ABdhPJy2X8EP5QUKM+hJQOQmwlt/xE/zy6YaVqxKaTHl9MDg4dNk9Z8bjjvVtlXhHL7K3n14DqeXzTLdQ43HRTKk+b8=
X-Received: by 2002:a05:6830:1bc6:: with SMTP id
 v6mr212601ota.299.1633545427166; 
 Wed, 06 Oct 2021 11:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <CADnq5_NgR7tdyeGOdqHCGRMd9DCTJwcRfBXaZcOQDJbEeypf2A@mail.gmail.com>
 <YV3pQCZ4GYbdpEm5@zn.tnic>
In-Reply-To: <YV3pQCZ4GYbdpEm5@zn.tnic>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Oct 2021 14:36:56 -0400
Message-ID: <CADnq5_O8rTnWH5md1qWauW_3sDTO+qf=vNzPZC1E70NT7Wb99A@mail.gmail.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To: Borislav Petkov <bp@alien8.de>, Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, 
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

On Wed, Oct 6, 2021 at 2:21 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 06, 2021 at 02:10:30PM -0400, Alex Deucher wrote:
> > This is not limited to Raven.
>
> That's what the innocuous "a.o." wanted to state. :)

Whoops, my eyes passed right over that.

>
> > All GPUs (and quite a few other
> > devices) have a limited DMA mask.  AMD GPUs have between 32 and 48
> > bits of DMA depending on what generation the hardware is.  So to
> > support SME, you either need swiotlb with bounce buffers or you need
> > IOMMU in remapping mode. The limitation with Raven is that if you want
> > to use it with the IOMMU enabled it requires the IOMMU to be set up in
> > passthrough mode to support IOMMUv2 functionality for compute support
> > and due to other hardware limitations on the display side. So for all
> > GPUs except raven, just having IOMMU enabled in remapping mode is
> > fine.  GPUs from other vendors would likely run into similar
> > limitations.  Raven just has further limitations.
>
> Hmm, and in passthrough mode it would use bounce buffers when SME is
> enabled. And when those 256K are not enough, it would fail there too,
> even with IOMMUv2. At least this is how it looks from here.
>
> Dunno, it feels like doing GPU compute and SME does not go hand-in-hand
> real smoothly currently but that probably doesn't matter all too much
> for both user camps. But that's just me with a hunch.

Well, this limitation only applies to Raven which is an integrated GPU
in client parts.  SME was initially productized on server parts so
there was not a lot of concern given to interactions with integrated
graphics at the time.  This has since been fixed in newer integrated
graphics.  dGPUs work fine as long as the IOMMU is in remapping mode
to handle the C bit.

>
> > Another option would be to enable SME by default on Epyc platforms,
> > but disabled by default on client APU platforms or even just raven.
>
> Thing is, we don't know at SME init time - very early during boot -
> whether we're Epyc or client. Can we find that out reliably from the hw?
>

From the x86 model and family info?  I think Raven has different
families from other Zen based CPUs.

> And even if we do, that's still not accurate enough - we wanna know
> whether the IOMMU works.

Right.

>
> So I guess we're all left to the user to decide. But I'm always open
> to suggestions for solving things in sw and not requiring any user
> interaction.

@Tom Lendacky Any ideas?

Alex

>
> > Other than these comments, looks fine to me.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
