Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0710AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 14:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9841110E143;
	Tue, 12 Apr 2022 14:13:09 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7272810E2D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 14:13:08 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id k10so19203861oia.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=b6YpDp+6gFKoLmapSHMcJ8pQjcQrhKppqQPW1qrfY/M=;
 b=OmQRrxF3c5o1KlJk1ADfn7bF1BdDYI/6MzKE+UbXY8zUlFZmDyaVY3FvxTnAIEa0XJ
 4njrXVLgTxy6M22LJHmyxDfpJ7ZGyeTQwYjdZCYrJlB4P1TCHokXDPBq9hXwtsFzPiWV
 dgVxr0e8bR4X5oAl7zInOA16ohEyFad8aP7T4sk4AS+xF5vZwobNU3fowFkP4aZo1fbw
 p5IEFDRpGPhubpCsos0x6RUgdyVguFDtpUZxDOjAPjuhuidHL356qXpQcP8A5ddnoNNS
 KgnmhtBR9lboTPrbisNcTRfyJQ52UT4qMduUb8bIQChazq0kaFpbJW5pSfXsgoz4EILd
 NrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=b6YpDp+6gFKoLmapSHMcJ8pQjcQrhKppqQPW1qrfY/M=;
 b=u0GpD7zQu+Ktl87RIBNbgN1yJMsPJn9rrKkQRTUt1yugawqQhPptGYUWGGRK2u17NE
 cHexY35IYsp9wIDwEAUnevTwlSDrbRzyKbzCYpb48bF2SMOjLhrw5SBXxJVXvo97zenO
 Q40/XxGEFzAUJOJAZZX1clGY7p2cS8gp0g7UtJNvWHp6LlJJgdr0uecpG7z7QyBOaUA6
 ybeE/uDZu+XVKQQ2ldD9eID9VmhNzw+szC2RnHQlcDIGrLkjZWbu4j3imMqf+Jl8d3wj
 EeE5dqLM4O9482yFBY03Z1rVBfK3EAZT+T3pyUxJPHUdrpccY2ACyfjdW3ybquNcznOt
 SgHg==
X-Gm-Message-State: AOAM533Koc7dB/Np2f35KYp2M7pyixtWcaAHQWjGXQqVDKNjViUiVNH1
 lAOIElrPcJmVu3gSFT22trfUnCjTneCfmXu+nNA=
X-Google-Smtp-Source: ABdhPJzvkvG7jo+a/gm9nQ/3deFhOzLJ1KErpfqpA3Uh0OwD50/Y3p6TDExGZgiwG1OsiMG6x7cSUe+vQyEzjC7hRNI=
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id
 e6-20020a056808148600b002f9e82151d9mr1913551oiw.253.1649772787730; Tue, 12
 Apr 2022 07:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220411135939.906700-1-yongqiang.sun@amd.com>
 <f06ce5e3-158b-88a8-06f0-53b88c4fad45@molgen.mpg.de>
 <CADnq5_PSZX+11meHYn9CR3A4LiseGo30TwbkOuPgTQsfbYxmCg@mail.gmail.com>
 <88760cd1-d1ed-8952-d061-15e238b2ec57@molgen.mpg.de>
In-Reply-To: <88760cd1-d1ed-8952-d061-15e238b2ec57@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Apr 2022 10:12:56 -0400
Message-ID: <CADnq5_MdSn0_X6Bqd-Ljv_QzVpgtBYXUkkALEdFasCiiXx=o7g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with
 vega10
To: Paul Menzel <pmenzel@molgen.mpg.de>
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
Cc: X86 ML <x86@kernel.org>, "Luo, Zhigang" <zhigang.luo@amd.com>,
 Jingwen Chen <jingwen.chen2@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "monk.liu" <monk.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 12, 2022 at 4:01 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> [Cc: +x86 folks]
>
> Dear Alex, dear x86 folks,
>
>
> x86 folks, can you think of alternatives to access `X86_HYPER_MS_HYPERV`
> from `arch/x86/include/asm/hypervisor.h` without any preprocessor ifdef-e=
ry?

I don't really see what problem that solves.  X86_HYPER_MS_HYPERV is
an X86 thing.  Why do we need a processor agnostic way to handle it?
Any code related to that is X86 specific.

Alex

>
>
> Am 11.04.22 um 18:28 schrieb Alex Deucher:
> > On Mon, Apr 11, 2022 at 11:28 AM Paul Menzel wrote:
>
> [=E2=80=A6]
>
> >> Am 11.04.22 um 15:59 schrieb Yongqiang Sun:
> >>> MS_HYPERV with vega10 doesn't have the interface to process
> >>> request init data msg.
> >>
> >> Should some Hyper-V folks be added to the reviewers list too?
> >>
> >>> Check hypervisor type to not send the request for MS_HYPERV.
> >>
> >> Please add a blank line between paragraphs.
> >>
> >>> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
> >>>    1 file changed, 10 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_virt.c
> >>> index 933c41f77c92..56b130ec44a9 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> >>> @@ -23,6 +23,10 @@
> >>>
> >>>    #include <linux/module.h>
> >>>
> >>> +#ifdef CONFIG_X86
> >>> +#include <asm/hypervisor.h>
> >>> +#endif
> >>> +
> >>>    #include <drm/drm_drv.h>
> >>>
> >>>    #include "amdgpu.h"
> >>> @@ -721,8 +725,12 @@ void amdgpu_detect_virtualization(struct amdgpu_=
device *adev)
> >>>                        break;
> >>>                case CHIP_VEGA10:
> >>>                        soc15_set_virt_ops(adev);
> >>> -                     /* send a dummy GPU_INIT_DATA request to host o=
n vega10 */
> >>> -                     amdgpu_virt_request_init_data(adev);
> >>> +#ifdef CONFIG_X86
> >>> +                     /* not send GPU_INIT_DATA with MS_HYPERV*/
> >>> +                     if (hypervisor_is_type(X86_HYPER_MS_HYPERV) =3D=
=3D false)
> >>> +#endif
> >>
> >> Why guard everything with CONFIG_X86? (If it=E2=80=99s needed, it shou=
ld be done
> >> in C code.)
> >
> > X86_HYPER_MS_HYPERV only available on x86.
>
> Sorry, I missed the X86 dependency when quickly looking at the Hyper-V
> stub IOMMU driver `drivers/iommu/hyperv-iommu.c`, but missed that
> `HYPERV_IOMMU` has `depends on HYPERV && X86`.
>
>
> Kind regards,
>
> Paul
>
>
> >>> +                             /* send a dummy GPU_INIT_DATA request t=
o host on vega10 */
> >>> +                             amdgpu_virt_request_init_data(adev);
> >>>                        break;
> >>>                case CHIP_VEGA20:
> >>>                case CHIP_ARCTURUS:
> >>
> >>
> >> Kind regards,
> >>
> >> Paul
