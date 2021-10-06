Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D32C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 13:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8849F61131
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 13:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8849F61131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1156E508;
	Wed,  6 Oct 2021 13:23:36 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7CDB6E508
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 13:23:34 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 i26-20020a4ad09a000000b002a9d58c24f5so854304oor.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Oct 2021 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HIxpcPjjliDmNMsnuequZ0gFoYJjA+Pd57/rdj42aTk=;
 b=n6hubWn5AXF/sSj8MUZBeNdimUtLnR1jd7Gowh5bUbbHNEgTO1dd3wn5ZW/d5oCTmK
 nj6lavmhbq/1FojrFBMVYVckHnWUYi/xWSQpEzKh/4zr/n9ZCXz6JNaIra7xNErSt5dY
 ro8MOAGeDt+hNJ5jMuYaNhKQOEd/0NX+ZSsHwicj4JG+bWCC5MKzNy6prOp0cg5twf/S
 gy8hC/v3eQjgYdbu0LWCzfk8YW919QfKDO7aRU9jI98z0QYhsUrOBOK2AN4pOr30IBD2
 duYoa9Z6jrQrrNZsLXABUrtGiNsqlzhjYRfZ5qIo1XpWFUp46UpdoG5hZN2cQu9q0BFn
 wcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HIxpcPjjliDmNMsnuequZ0gFoYJjA+Pd57/rdj42aTk=;
 b=qnBlQ9c6iPvV2pbBf1iL5DAz5/b5YPbW1S+lG9Gdnomn7XX9tEyln53HX5hFvPoNSx
 LxvwMfjl1IQ1kst6NLQyWh0prf/fbbeV0ALA5LJO3f2mQqueF/XjKODwx1/O2YC5TI0o
 RMGtCu4PA4T5lApTA4RfWNqfw+eQ5kVk81lPw5hagXTwBuiqMytF8nZ0dAa7qguma5dk
 sIq/WYpyrjfp83Fn3d+/7Q7aCPS2L/3iHonB2OEnfdgj2/uluYKD1dOMWKXi1hSpMjIy
 9SQccHdaAfwGfej+dgAz9GHeON82ItH9PzZPn5IbSL8h2vB5pvYxD/7ohJgGgk3MVkx3
 SXAA==
X-Gm-Message-State: AOAM533rjpJnYPd0DYjRnGFRq9CR1FVrjufaesCW/Wf561Is+eP2M9Gn
 w8GsJbfvSFfBKWYJl3YHcqZPvrGtOGLgf2FU44I=
X-Google-Smtp-Source: ABdhPJxcO+2T/Un2z3HL3UD8vAOe2oKNLbp3IiO1yhZMKelVD05AWN6AAmRCmewWXvsqFHh4Wm9IQ7YUGfdG6Ud31/o=
X-Received: by 2002:a4a:a6c6:: with SMTP id i6mr17948100oom.73.1633526614154; 
 Wed, 06 Oct 2021 06:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <CADnq5_ONNvuvTbiJDFfRwfnPUBeAqPmDJRmESDYG_7CymikJpQ@mail.gmail.com>
 <YV1vcKpRvF9WTwAo@zn.tnic>
In-Reply-To: <YV1vcKpRvF9WTwAo@zn.tnic>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Oct 2021 09:23:22 -0400
Message-ID: <CADnq5_N5+SEW4JyXLc=FdSHnSbXrGKWjEw4vW1Jxv9-KdWf+Jg@mail.gmail.com>
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To: Borislav Petkov <bp@alien8.de>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Tom Lendacky <thomas.lendacky@amd.com>,
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

On Wed, Oct 6, 2021 at 5:42 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Oct 05, 2021 at 10:48:15AM -0400, Alex Deucher wrote:
> > It's not incompatible per se, but SEM requires the IOMMU be enabled
> > because the C bit used for encryption is beyond the dma_mask of most
> > devices.  If the C bit is not set, the en/decryption for DMA doesn't
> > occur.  So you need IOMMU to be enabled in remapping mode to use SME
> > with most devices.  Raven has further requirements in that it requires
> > IOMMUv2 functionality to support some features which currently uses a
> > direct mapping in the IOMMU and hence the C bit is not properly
> > handled.
>
> So lemme ask you this: do Raven-containing systems exist out there which
> don't have IOMMUv2 functionality and which can cause boot failures when
> SME is enabled in the kernel .config?

There could be some OEM systems that disable the IOMMU on the platform
and don't provide a switch in the bios to enable it.  The GPU driver
will still work in that case, it will just not be able to enable KFD
support for ROCm compute.  SME won't work for most devices in that
case however since most devices have a DMA mask too small to handle
the C bit for encryption.  SME should be dependent on IOMMU being
enabled.

>
> IOW, can we handle this at boot time properly, i.e., disable SME if we
> detect Raven or IOMMUv2 support is missing?
>
> If not, then we really will have to change the default.

I'm not an SME expert, but I thought that that was already the case.
We just added the error condition in the GPU driver to prevent the
driver from loading when the user forced SME on.  IIRC, there were
users that cared more about SME than graphics support.

Alex

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
