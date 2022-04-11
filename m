Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C650C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 16:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D680010E3FB;
	Mon, 11 Apr 2022 16:28:40 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D0410E9DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 16:28:40 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-d6e29fb3d7so17785967fac.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CsfcIVKMTKI5b1Js6xMB9v7uNz7795DyDfRZI3ekOUA=;
 b=KsfW2WjFBRyQOuOq5Vjrw1LG4nc4t3I844z62JhXrCTRnYqfDZjTlaMWAkup1LJxlM
 6Ml2ose0yf1FFCGrTB9SUXC7hIkC+urVyVcsU7SmehuLnjyUFIr754esovcvr89oHF39
 P+F0xzO9oiM2+XtavlMEtFZeDqHPRR5d6OYD8o/FEnsbMRy5AawNmlPh1qL3JWWD1fHE
 ZbydruQW87Acejgi0R4KpiLtRtfEQsH//ILudC/jLelUQGbeWxLRS/9j1qZDsHA/Ywrh
 twdixJea1PnJQJ5f1iiiaBX8NtxAnbGUmXh7bTmS09LuC4mtRtqYK8KpH5eyv0aExsB6
 1j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CsfcIVKMTKI5b1Js6xMB9v7uNz7795DyDfRZI3ekOUA=;
 b=z83rl/WJ3TCyDho3/HZy3Y8VJpWzMD7reMEXlZD76oiMde6w11GqrZim45faM3hQVr
 gVoERaELgeBl6wlTkSQsEV/+NEumJjlnf89KHL61hGXea0nG1DmtZLwaNAxB2+hVIoML
 rJQVbY+EqCf8U86YO2ieA+mvl+6g+g2y0sc65rddVkuhenSE+vPQEaz4+wzHXeTSP6ze
 luV+FNeVi/cTTREPeotWXkuX59JKpqG36h94jnB9mrqymUq78FKJB6eoH73+/c8clk+K
 ma8rRRbj+ktWyKDZyKrjEFQTcFokEA/DllSOWlngrDug/NZEuKFyWKaTtTwykFFfmZgj
 ODtA==
X-Gm-Message-State: AOAM533LmdAsohqtXEBRl7QLRlTmI7DwVoD65b3GwvM4MbrNkmtQhveV
 4Iu+9qk6NknAWaTBIAff7Ks3Mpifs8V26bGS1/F6JyNv+S4=
X-Google-Smtp-Source: ABdhPJxjVBl8/ZWWwbyVVd7ZzXbrCqA5xmzhCs3ypb90yXlmpVvBxwgSxUkSQyp5agtQMDz2Gl1c43WZRqldd7XWpSI=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr15153199oap.253.1649694519457; Mon, 11
 Apr 2022 09:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220411135939.906700-1-yongqiang.sun@amd.com>
 <f06ce5e3-158b-88a8-06f0-53b88c4fad45@molgen.mpg.de>
In-Reply-To: <f06ce5e3-158b-88a8-06f0-53b88c4fad45@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Apr 2022 12:28:28 -0400
Message-ID: <CADnq5_PSZX+11meHYn9CR3A4LiseGo30TwbkOuPgTQsfbYxmCg@mail.gmail.com>
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
Cc: Jingwen Chen <jingwen.chen2@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>,
 "Luo, Zhigang" <zhigang.luo@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "monk.liu" <monk.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 11, 2022 at 11:28 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Yongqiang,
>
>
> Thank you for your patch.
>
> Am 11.04.22 um 15:59 schrieb Yongqiang Sun:
> > MS_HYPERV with vega10 doesn't have the interface to process
> > request init data msg.
>
> Should some Hyper-V folks be added to the reviewers list too?
>
> > Check hypervisor type to not send the request for MS_HYPERV.
>
> Please add a blank line between paragraphs.
>
> > Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_virt.c
> > index 933c41f77c92..56b130ec44a9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -23,6 +23,10 @@
> >
> >   #include <linux/module.h>
> >
> > +#ifdef CONFIG_X86
> > +#include <asm/hypervisor.h>
> > +#endif
> > +
> >   #include <drm/drm_drv.h>
> >
> >   #include "amdgpu.h"
> > @@ -721,8 +725,12 @@ void amdgpu_detect_virtualization(struct amdgpu_de=
vice *adev)
> >                       break;
> >               case CHIP_VEGA10:
> >                       soc15_set_virt_ops(adev);
> > -                     /* send a dummy GPU_INIT_DATA request to host on =
vega10 */
> > -                     amdgpu_virt_request_init_data(adev);
> > +#ifdef CONFIG_X86
> > +                     /* not send GPU_INIT_DATA with MS_HYPERV*/
> > +                     if (hypervisor_is_type(X86_HYPER_MS_HYPERV) =3D=
=3D false)
> > +#endif
>
> Why guard everything with CONFIG_X86? (If it=E2=80=99s needed, it should =
be done
> in C code.)

X86_HYPER_MS_HYPERV only available on x86.

Alex

>
> > +                             /* send a dummy GPU_INIT_DATA request to =
host on vega10 */
> > +                             amdgpu_virt_request_init_data(adev);
> >                       break;
> >               case CHIP_VEGA20:
> >               case CHIP_ARCTURUS:
>
>
> Kind regards,
>
> Paul
