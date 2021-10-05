Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3423C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 14:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688F961354
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 14:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 688F961354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC2686E40C;
	Tue,  5 Oct 2021 14:48:28 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD376E40C
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 14:48:27 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id e24so26519160oig.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Oct 2021 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fP85uqPvsPSl2MUwxPDDeDYwMbz9jeEPyhfkUL7Uxk8=;
 b=Lhcbo43r147Wu0u8Wpp+9wVGM//0MYXGTdRlFyuSbAdh5ABUTCucDCjgyRL/4SnoX7
 bMioEsUENxhYa6S6Q2HQJFs9grfOcOzpZcmnOPjAFtZJLiQIrQ9M+gSNwsgq3qD8M+KZ
 tdiK4aSKR3Qw9+gkvCSl+IjUyGEFroTIx9wgF2WlpQ8fCmjUzoJdRQafIthSTAN4KBPi
 FQW3Vgar126Ayw2smtcCzwmHorrIgmeDmfX5HHR24bF7TaFs9iXO8tN1M7YeLF+Mj9/L
 8HyM59eeQDQfZKhagPaUa5MeBbcqIImrpjmp6VbQkdxjV7BuWMIa8ILg6CJrhuOEZVyU
 6PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fP85uqPvsPSl2MUwxPDDeDYwMbz9jeEPyhfkUL7Uxk8=;
 b=0BXkUwVzY5Gj7/tcVB2DACwgul/px2WygP1WQx27saQHMJKGWuFfvlG/6NvcK0OHHh
 2QZyfAn99F9C+RJWe/Oo9GY58riJovtVrP4GUB9VS/F35OnmttPdFu21N9xKm9F8tKuM
 r5l0IPlLx8GgdrzWhZuACiny1jVLaELGLBjr/r0H4M/cBo+tbb6P7vp8dKZl1vNcrTqP
 Qo+E6WgfaDu7mHijpSKusYRO2eKH3rnoqVuxTNP1Qv/mDbsbgVDxssGvSmt05I0qDKLp
 A82Fzm2MERM2bsJ6lFJ4qR3lnNUytGJE9m/clsxIFspuUgVMJO8EqlfXwxp09wyhuHhM
 dxhw==
X-Gm-Message-State: AOAM532IDChU8/SyDRCa41eHTs8hLU4WYYT0aje9moiBBm8gWe3JCaZo
 Q6QMuTUuSkY70dgXLIb18g8PDY8JDwMD4zj3VnA=
X-Google-Smtp-Source: ABdhPJz9dZiqVvIsst2xFd1wbDlv+vS4x96AHQf0IhY9TJqV+48wGcgEMHwUM41/xBLgGgcIpZ7Gd4s+1oQ2H7ETcVc=
X-Received: by 2002:aca:ab4d:: with SMTP id u74mr2828586oie.120.1633445306493; 
 Tue, 05 Oct 2021 07:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
In-Reply-To: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Oct 2021 10:48:15 -0400
Message-ID: <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 X86 ML <x86@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Tue, Oct 5, 2021 at 10:29 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Tom, dear Linux folks,
>
>
> Selecting the symbol `AMD_MEM_ENCRYPT` =E2=80=93 as done in Debian 5.13.9=
-1~exp1
> [1] =E2=80=93 also selects `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT`, as it def=
aults
> to yes, causing boot failures on AMD Raven systems. On the MSI B350M
> MORTAR with AMD Ryzen 3 2200G, Linux logs and the AMDGPU graphics
> driver, despite being loaded, does not work, and the framebuffer driver
> is used instead.
>
>      [   19.679824] amdgpu 0000:26:00.0: amdgpu: SME is not compatible
> with RAVEN
>
> It even causes black screens on other systems as reported to the Debian
> bug tracking system *Black screen on AMD Ryzen based systems (AMDGPU
> related when AMD Secure Memory Encryption not disabled --
> mem_encrypt=3Doff)* [2].

It's not incompatible per se, but SEM requires the IOMMU be enabled
because the C bit used for encryption is beyond the dma_mask of most
devices.  If the C bit is not set, the en/decryption for DMA doesn't
occur.  So you need IOMMU to be enabled in remapping mode to use SME
with most devices.  Raven has further requirements in that it requires
IOMMUv2 functionality to support some features which currently uses a
direct mapping in the IOMMU and hence the C bit is not properly
handled.

Alex

>
> Should the default be changed?
>
>
> Kind regards,
>
> Paul
>
>
> [1]:
> https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/changelog=
#L1138
> [2]: https://bugs.debian.org/994453
