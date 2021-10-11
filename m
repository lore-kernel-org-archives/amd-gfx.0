Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98381C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 14:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666B66023F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 14:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 666B66023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB8F89B99;
	Mon, 11 Oct 2021 14:32:28 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E4E89B3C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 14:32:27 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id q129so4160745oib.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2/ZTOy0q28dn/Ouhxt088aYYUW3NaH1tWSvL9KzCcik=;
 b=P/k1oVfKmFY5wGSr/y+gQwLi2aHhybye08VwzgW+vUlk/Izsyfx8dLHennK69xkCCY
 CWhh5iuax8ItdUlYtZaAfm3bUNePH+bVkpiy856Pm9suL8rFjiTZeNR3TVPA87EzzJfd
 Qg+GNKN4YbVd1huamqej/LMBCy/n6gXWAA2nQZzsyLMujir/YPbaUMov6PXKKreA1ugb
 AEqYVwzUQcAFK3DXVtMjFtc0LJtkrjkI6tru5ySiIz7tMMF38nLCq7HX/74LWUXGri0z
 8ePM+7jZdspWhEFaYcXlgCZR2Nm3+KxLWKdiYTGoZD5rBn05Vdelk+Sdc9DZTJW2XwKw
 1FeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2/ZTOy0q28dn/Ouhxt088aYYUW3NaH1tWSvL9KzCcik=;
 b=u5TqZU5rj9XrEdE4C5WRt2T+9aILqHNqVkIuoD3vYa93+ajl9Yi/7YS87IR0tCorId
 1/gcd9rAUbFF0ufUZBQdIAdmcGZN7hZOCdqdZTF1e1/xL1J+Yi9jfPf7xHEsdomQdUHO
 WGiNX28Pq79kM9yya01mOn/xf/nEt8YRHr7v0+Fc5YAmoIzXej2P0ABUQoDsw8Cuo/ES
 ljn58iwdG7ViktWDZRl16dhI4Sxot3OHOpENWVE8fQMTh6w1HvVvELk4HLE3ZgeOFrPX
 DanNFfUhqJgIZ+lk3HTqXosAUeZIc3r/zzej3FdajQhviWC7J+adu/TeIixmlunQ4og6
 OQHQ==
X-Gm-Message-State: AOAM530X05+Ez+MO27Zrvt+eD+aX6QL9be342KMJ9vnwwoxiBuWF6PKe
 5zhhTb8vAJT+T+7eOCPONU+M0K4ANeH8ujIVvfk=
X-Google-Smtp-Source: ABdhPJxuzkit/sOHalSr+6UHB9Gpc9rUb8EpsnE55/ckQ/rW0zX9VvQ3PO6tkY68syjSbrrw5nHLIoou8bLrojRbxlY=
X-Received: by 2002:aca:d6d2:: with SMTP id
 n201mr17936070oig.120.1633962746584; 
 Mon, 11 Oct 2021 07:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
 <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
 <96f6dbed-b027-c65e-6888-c0e8630cc006@amd.com> <YV3hbK/uhChK5Pse@zn.tnic>
 <d704afb9-7c7c-fa55-4329-58bb2fa25b33@molgen.mpg.de>
 <YWQ3963xcO3xbFo5@zn.tnic>
 <87d93314-ba3e-464f-d051-84a8de674b06@amd.com>
 <139ed784-d622-b0d2-3650-736b42e624f0@molgen.mpg.de>
 <be2b3cca-9822-4bb7-12b4-4c5c89318625@amd.com>
 <8b21ebbd-f7ca-8af3-5398-8320c6ed6422@molgen.mpg.de>
In-Reply-To: <8b21ebbd-f7ca-8af3-5398-8320c6ed6422@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Oct 2021 10:32:15 -0400
Message-ID: <CADnq5_OLaFFuK-LaEw+aXdbJcXa0pEUEBJaCbaeuOxVbEat_oA@mail.gmail.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Borislav Petkov <bp@alien8.de>
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

On Mon, Oct 11, 2021 at 10:21 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Tom,
>
>
> Am 11.10.21 um 15:58 schrieb Tom Lendacky:
> > On 10/11/21 8:52 AM, Paul Menzel wrote:
>
> >> Am 11.10.21 um 15:27 schrieb Tom Lendacky:
> >>> On 10/11/21 8:11 AM, Borislav Petkov wrote:
> >>>> On Mon, Oct 11, 2021 at 03:05:33PM +0200, Paul Menzel wrote:
> >>>>> I think, the IOMMU is enabled on the MSI B350M MORTAR, but
> >>>>> otherwise, yes
> >>>>> this looks fine. The help text could also be updated to mention
> >>>>> problems
> >>>>> with AMD Raven devices.
> >>>>
> >>>> This is not only about Raven GPUs but, as Alex explained, pretty much
> >>>> about every device which doesn't support a 48 bit DMA mask. I'll expand
> >>>> that aspect in the changelog.
> >>>
> >>> In general, non-GPU devices that don't support a 48-bit DMA mask work
> >>> fine (assuming they have set their DMA mask appropriately). It really
> >>> depends on whether SWIOTLB will be able to satisfy the memory
> >>> requirements of the driver when the IOMMU is not enabled or in
> >>> passthrough mode. Since GPU devices need/use a lot of memory, that
> >>> becomes a problem.
> >>
> >> How can I check that?
> >
> > How can you check what? 32-bit DMA devices? GPUs? I need a bit more
> > information...
>
> How can I check, why MEM_ENCRYPT is not working on my device despite the
> IOMMU being enabled.

I think there are several potential problem cases:

1. Device is in passthrough mode in the IOMMU and the device has a
limited DMA mask.  This could be due to a hardware requirements (e.g.,
IOMMUv2 functionality) or a hardware/platform requirements (e.g., ACPI
IOMMU tables define passthrough for a specific device or memory
region).  This is the case for Raven.

2. Device driver bug (e.g., driver not using the DMA API properly)

Alex

>
>
> Kind regards,
>
> Paul
