Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1EFC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 14:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D9123121
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 14:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D9123121
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67236E86F;
	Tue, 19 Jan 2021 14:12:07 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111BE6E86F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 14:12:07 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id x203so4930520ooa.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 06:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r8JcrmD8TOIkRKBL/pUQltmibktuNVS0o6e6NiLwj7k=;
 b=CQfu8AkzR6AhvmdyaApAKBRHlS68BWSS5m7iCzAUBW/xGyD5TcQKgNboweVw7rzkcu
 wJuQ0eR3OIN4CprQkNWW2ASY62Zsf2BxqDwIbq8/U/9pIAuvQIvMfaZhozMPOzb5AZzS
 cfZJeCtvjjpeyUCt72xFEZ5aEQ02gqfyxTzdIe9kRHwQcY8htLOU3ZmSmKfm7jWjXjdC
 /JF+vCt0jQuN9nnrpncyZJlukPZJPcEeMWazkG/qCpCq0ikF/pM03CDGr2agHsFqlXCI
 5wFpPidosfctXXaXq0zi6vcsNC2ursEILj0FnhPQkxCyNQ+QUL85iz+x9qnYGCvDnSst
 DU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r8JcrmD8TOIkRKBL/pUQltmibktuNVS0o6e6NiLwj7k=;
 b=RoFJL2jxlJ8efu9cnPQG0B1KwC07k/EG24izNEaWNgshgvVamKu2Avx0PaE/WQbv4A
 9wjxUMvm5E30oVRGCW5q9VBZDfxd+53BYFZ+1DSSE+Ibl3Z8Mb5IKg7HoAuyHOikS9Si
 S1grOMy9ATsvQb+z9RmI8BWVsh+8lsqETyiM166As8CvGW+G5Xn1V+1a/FKFl6tHkc4x
 jGlpF0EvBpIyIPSxaM8MLZFVxvJgkgEQYY2a27baVCYZTvN0QYKCWfWHxRtEfl+AwUSR
 k949CX6cW8yalmO7sk/K4/eolz1fSr079ZmoDgn6gjtSIrMyHHB0StPMb4jyxR4nS30C
 Vf2g==
X-Gm-Message-State: AOAM531zd44Yu/taTJnM4IfJVdzy9ZqmeMO7kpApMnkJDaY0Gljh8eCA
 niTvjRx9+eogJGPWZ9FiC4myGkMnRXFMWSoevsE=
X-Google-Smtp-Source: ABdhPJytsZlWJhG1rDhEWFozL434jEAMMTVFks7dWYtt1Bcmwcv5QpYEaXkLezwlzCglPPHoFxEqIY4wNYHPTqM7EN4=
X-Received: by 2002:a4a:a2c5:: with SMTP id r5mr2929280ool.72.1611065526364;
 Tue, 19 Jan 2021 06:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20210119055135.70134-1-ray.huang@amd.com>
 <BYAPR12MB3238BA59B2D36A50A2E93B46FBA30@BYAPR12MB3238.namprd12.prod.outlook.com>
 <20210119065729.GD22628@hr-amd>
 <BYAPR12MB3238D59E095B5A473363325DFBA30@BYAPR12MB3238.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB3238D59E095B5A473363325DFBA30@BYAPR12MB3238.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Jan 2021 09:11:54 -0500
Message-ID: <CADnq5_MJn4xPpDBbQvADN1nM9MKwv+9kk4a3HvxWy8b1GZNqKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove gpu info firmware of green sardine
To: "Liang, Prike" <Prike.Liang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 19, 2021 at 2:20 AM Liang, Prike <Prike.Liang@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Tuesday, January 19, 2021 2:57 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: remove gpu info firmware of green
> > sardine
> >
> > On Tue, Jan 19, 2021 at 02:25:36PM +0800, Liang, Prike wrote:
> > > [AMD Official Use Only - Internal Distribution Only]
> > >
> > > Thanks help clean up. Generally that seems fine but could we keep the
> > green sardine chip name to retrieve the GPU info FW when the IP discovery
> > fail back to legacy mode?
> >
> > Do you want to only clean MODULE_FIRMWARE(gpu_info.bin)? That's fine
> > for me.
> [Prike]  Yeah, that seems enough just remove the green sardine GPU info FW declared for amdgpu driver module.
> >

We can probably remove the renoir gpu_info firmware as well.  We use
the IP discovery table there as well at this point.

Alex


> > Thanks,
> > Ray
> >
> > >
> > > Anyway this patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>
> > >
> > > Thanks,
> > > Prike
> > > > -----Original Message-----
> > > > From: Huang, Ray <Ray.Huang@amd.com>
> > > > Sent: Tuesday, January 19, 2021 1:52 PM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> > > > <Prike.Liang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> > > > Subject: [PATCH] drm/amdgpu: remove gpu info firmware of green
> > > > sardine
> > > >
> > > > The ip discovery is supported on green sardine, it doesn't need gpu
> > > > info firmware anymore.
> > > >
> > > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > index 4d434803fb49..f1a426d8861d 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > @@ -81,7 +81,6 @@
> > MODULE_FIRMWARE("amdgpu/navi10_gpu_info.bin");
> > > >  MODULE_FIRMWARE("amdgpu/navi14_gpu_info.bin");
> > > >  MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
> > > >  MODULE_FIRMWARE("amdgpu/vangogh_gpu_info.bin");
> > > > -MODULE_FIRMWARE("amdgpu/green_sardine_gpu_info.bin");
> > > >
> > > >  #define AMDGPU_RESUME_MS2000
> > > >
> > > > @@ -1825,7 +1824,7 @@ static int
> > > > amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)  if
> > > > (adev->apu_flags & AMD_APU_IS_RENOIR)  chip_name = "renoir";  else
> > > > -chip_name = "green_sardine";
> > > > +return 0;
> > > >  break;
> > > >  case CHIP_NAVI10:
> > > >  chip_name = "navi10";
> > > > --
> > > > 2.25.1
> > >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
