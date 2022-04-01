Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704DAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Apr 2022 13:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FA4C10E2D5;
	Fri,  1 Apr 2022 13:59:26 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ADA4883F4
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Apr 2022 13:59:23 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id i7so2883043oie.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Apr 2022 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=viHmoUaWP6Z4T5ldlfaqNi+O4wBu1fYOS+gUaAsQgnk=;
 b=Hd/8LWZUzI4gG1uWg4tUpyHl87Thk/kWxngYUoTDLedMMBYDfvptC7HmzruRUQRHr1
 HqIbYtYgymtUadFg/J3L1kQk/VmUFubdqVy1g/kNHDZvFBxHPwrpir2Qj5k/gjnH1bmh
 GdB/hMgceCp7YfThFLnbOmB0h1z0EVnCzKlMEnDJOn2Bo1vHHTaMVdrYt9T8H1E3oGjh
 fJ3JE/iQflvIZvVhipeDeemuA1mpc6eJWoFIXMnH5Q8ERb10s7iHIGx7Izz1heiqNPLa
 ruRpcJFYKMxZpWo7uQL4kbjiOJ+13eKWBjkpZzvW1NOmG9S94GqIteZO5k2VT7JIQ/Um
 9Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=viHmoUaWP6Z4T5ldlfaqNi+O4wBu1fYOS+gUaAsQgnk=;
 b=yVIYq7zwQ6ZrbO1xiTeFT4muwi/WF9RDPxm1M+u12mJdAueQhJRfgeJRq+kqKgukyQ
 4Y7ZB+04mIlM5Eexf2T6k3FZ0yUEWMX4/Wy/ySxYaH1KwsZITZRSXeBRuMfsgxNJ1DZS
 8vN0qzezTwbUAkOrw+F1CwtgRoq/6RF1wmg7scIE4+7wLQCPCXCzp56/PFDLwREf6MFd
 3QrGvDlGuy8Qd7RE6NYv3rSdc4wo91NXC5cwGTOW+uPCINCR7z6Ot8STHxkmgXNmuiUz
 qR2XHFzesoKKQhLaEfx/2effh92RtzstsOBGXR/lPo5Iwjo1+z6r6VOykd1WQ0DXqWwU
 12dw==
X-Gm-Message-State: AOAM532Tsjh3DRyziz1+hkHCsU2qHQTnZbm7a/8vTl1eMwX7O+dBJd5q
 Alo7L68S6ZE5rxw0Tk2/cyRfe9amoqtjhdn475eEYcu3
X-Google-Smtp-Source: ABdhPJypXUApcCg7R7aZn/327g1LRJjrlvthtlAzPVi8l/1riODLSE8EzKrCwIArYcy140FO5Fp4gbBJVP3bFSgQIu8=
X-Received: by 2002:a05:6808:df1:b0:2ec:b193:ad6c with SMTP id
 g49-20020a0568080df100b002ecb193ad6cmr4541946oic.200.1648821563143; Fri, 01
 Apr 2022 06:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220331145623.1854199-1-alexander.deucher@amd.com>
 <3f4eb7d0-2e48-a814-e939-a245f410f9c5@amd.com>
In-Reply-To: <3f4eb7d0-2e48-a814-e939-a245f410f9c5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 Apr 2022 09:59:12 -0400
Message-ID: <CADnq5_Pae+n1Q6mhxhGta9Oukd33rM5ZTDRWXCg4h5-qO+U5+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't use BACO for reset in S3
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 1, 2022 at 7:53 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 3/31/2022 8:26 PM, Alex Deucher wrote:
> > Seems to cause a reboots or hangs on some systems.
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1924
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1953
> > Fixes: daf8de0874ab5b ("drm/amdgpu: always reset the asic in suspend (v2)")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > index c73fb73e9628..1ff6c42fb110 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > @@ -173,6 +173,9 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
> >
> >       if (!pp_funcs || !pp_funcs->get_asic_baco_capability)
> >               return false;
> > +     /* don't use baco for reset in S3 */
> > +     if (adev->in_s3)
> > +             return false;
> >
>
> Suggest to add && !adev->runpm to the workaround.  For runpm supported
> devices, most likely it should work.

hmm.  I've kind of gone back and forth with this.  BACO works fine for
runtime suspend on all of the GPUs that reported problems in the bugs.
I think it's probably something timing related with the state of the
system during suspend.  Actually, thinking about it more, I think it
may be related to the fact that BACO also controls the power to other
devices on the GPU (e.g., audio or USB).  For runtime suspend, that is
handled via device dependencies, but at system suspend time, perhaps
the BACO sequence causes havoc with the other devices.

Alex

>
> Thanks,
> Lijo
>
> >       mutex_lock(&adev->pm.mutex);
> >
> >
