Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC239C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 14:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E16210E17A;
	Wed, 22 Dec 2021 14:25:23 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F33F10E17A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 14:25:21 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id w64so4158147oif.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 06:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pfTZL8Knbs17J+HlCXTbKsePu1y0bnHitSIQiVh5mOI=;
 b=EC7WdILPtOPOrJiDVWcY461w1/ekG/OCxqTUQjwRoD9Na6Vq8zXdEpnlOWhUoDOXSS
 BjY/P670nujx7LAxvpXh5HalCcRJ2UcnTIkZ85yzu/dz3W6ld9W96UdsNcBjANld6vcs
 McQXTO7sdkWsKhf1OVfgxJrdEgH3sGvP3fvzSY/gJTxEeLlbQSwZ9j2d0hYoERYgzKZD
 PpV56AwgHB+WBQZlgx14ASdORKcpJQsu6NeyAZMEJd40tjpQt/1U5TuvRwI5/eVvQ2kz
 Oj3NMNg+nHhZofvKXaXUEeuNyeJmbhR46gTgVcXmMI8uOXG5y6FmHOhpsABK6DVEzU1N
 Qz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pfTZL8Knbs17J+HlCXTbKsePu1y0bnHitSIQiVh5mOI=;
 b=0gyw6co/xPeCxqGQE4vjWm0Oc1w/EapaaFSeGhYo4TpvQu0MZ2zrc9Sy0ziIwaom1/
 G9+0rEzkK6T+5yNVzpLTkLDVhhLSp9WAMhBfn7f0fVfUHxryJkRMX/TGvgXosFs//oti
 xgZgyoXK/YEK4jAFWtvfbNP1hpxd+zbozrvIEszOJrYHBR8WrMNt2EUizxO4K8YMS8JV
 Fx30DPYYwoeV7PTGYCDCIUDosOAqK/QEDPAWyfSwPxzDgw7QVnyu3xw8WVqkt+sqjzhB
 GXLBrg/jHbJLvn6QciAiBztJEuuAby+bpZfh48mBUkEE5v55mkvn+p4ZZV9Odji4g79y
 8djA==
X-Gm-Message-State: AOAM5337XRLVyAprrnKTIFippjZzE5F4gMDJSemH/Uc0R6CIdG8Yi+Dr
 7pIxi3d3PkZBDHyI3ydrwqJSYomslmRYHaXoJQQ=
X-Google-Smtp-Source: ABdhPJy6F1khxlFJXvkUZ6T2kptjqRbM82lEnKERXkK3vRac2mj+GnwzYgr5FfpUqapDeRFAuaPXlvzJxcA4hy5ROCc=
X-Received: by 2002:a05:6808:44:: with SMTP id v4mr925102oic.123.1640183120391; 
 Wed, 22 Dec 2021 06:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20211221145853.725472-1-alexander.deucher@amd.com>
 <DM6PR12MB26191802EE0608EAA06DDBD3E47D9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26191802EE0608EAA06DDBD3E47D9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Dec 2021 09:25:09 -0500
Message-ID: <CADnq5_NgwgKr=r1ROpKcMYh56zrmc3pDRh8XOy2hyjwun22RfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix runpm documentation
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 21, 2021 at 10:13 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Tuesday, December 21, 2021 10:59 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH] drm/amdgpu: fix runpm documentation
> >
> > It's not only supported by HG/PX laptops.  It's supported
> > by all dGPUs which supports BOCO/BACO functionality (runtime
> > D3).
> >
> > BOCO - Bus Off, Chip Off.  The entire chip is powered off.
> >        This is controlled by ACPI.
> > BACO - Bus Active, Chip Off.  The chip still shows up
> >        on the PCI bus, but the device itself is powered
> >        down.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index a78bbea9629d..f001924ed92e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -331,9 +331,10 @@ module_param_named(aspm, amdgpu_aspm, int,
> > 0444);
> >  /**
> >   * DOC: runpm (int)
> >   * Override for runtime power management control for dGPUs in PX/HG
> > laptops. The amdgpu driver can dynamically power down
> [Quan, Evan] This("dGPUs in PX/HG latops") needs also be updated. Maybe missing unintentionally ?
> With that fixed, the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

Yes, good catch.  Fixed up.

Thanks!

Alex

>
> BR
> Evan
> > - * the dGPU on PX/HG laptops when it is idle. The default is -1 (auto enable).
> > Setting the value to 0 disables this functionality.
> > + * the dGPUs when they are idle if supported. The default is -1 (auto
> > enable).
> > + * Setting the value to 0 disables this functionality.
> >   */
> > -MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with
> > BAMACO, 1 = force enable with BACO, 0 = disable, -1 = PX only default)");
> > +MODULE_PARM_DESC(runpm, "PX runtime pm (2 = force enable with
> > BAMACO, 1 = force enable with BACO, 0 = disable, -1 = auto)");
> >  module_param_named(runpm, amdgpu_runtime_pm, int, 0444);
> >
> >  /**
> > --
> > 2.33.1
