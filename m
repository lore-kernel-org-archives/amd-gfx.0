Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71821C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 14:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E34DD10EDB0;
	Fri, 14 Jan 2022 14:58:38 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE7210EDB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 14:58:38 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id t9so12436091oie.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 06:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wfClCLv6Y1r8w1Mu+agZFlOnL6tT+xTZ/GoMhkTbfjo=;
 b=lla/8dPmgBwIE5Ye+/wPVYx4oODRSuU0LWqPXzTmjCkU1MHT4PyuZTKKBe3l/8maGy
 zGjT8mAseUGWVU1Fr5pUs90fhfl/4wIAzCJce1q26mz0N9EV894vNhMwd8xADKFb7MJX
 QSqE+Gu3lORLKfEe3P8Xo5gRH+Wh92nd+GVNSB0/0jJtbTztkUL+aR/+H0tceNsf1Wpv
 L2l4wB/y/iJs8GRZcLjRUQ9FfH583XbfrI+WT8SZs+04EURyFMwayApsm03ij2H2XLnL
 CGpG1IYL9fZu/EAhEZcqkqCWfIQdn2QEusCif3tdBVlBEVHX+ND0tMLJPQcDTqRm9F0a
 26Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wfClCLv6Y1r8w1Mu+agZFlOnL6tT+xTZ/GoMhkTbfjo=;
 b=3HmAJc0jq3xvVJJZXvUx9/YNeVXaRwtRdueFjEEfbP6k0obrLUs2ObM2BlF9twCc+u
 wLQLEgIKGwyrU+tP4izEKOd2YKONroBnlxfXwikDT5R2thecYWM+RuRbwfWmiPT6UXzB
 7wGOWVATiyKWoQbd3tbWBM4I0dhJ1mbyAV9pxPl5ntG7hb7AINK9Y+xxenf6o0GFkbfa
 JNLVVwy+KeOsUEl9Qz1qVCj+jnRBloW/Qb9FsgVIl7Dfbtdoc0sGJPyC7EzpTa/C7kRP
 OJO/aHl8I5S+jhDLCPrrXvXLgH1NpzXrwtlAecL36FJiz66mhow09GWV+j+sSeevqmmm
 jIiA==
X-Gm-Message-State: AOAM530cqio+QdH3PStS5kwwv11gWpXgX44J7X4dJxoXk6Nmr08ucbtb
 MPqpP873IhOstLALeOBoaq83OTPCusocmtma6UY=
X-Google-Smtp-Source: ABdhPJz/wm3H+YEiAJ3MpcV1GlQbLxHcJ9Y/g45F2Nl022nbTv2aOmXXrx1SbSLP3iCas2q//oDlugM9xkV1SktK/RQ=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr7410616oib.120.1642172317794; 
 Fri, 14 Jan 2022 06:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20220114065141.14506-1-lukas.fink1@gmail.com>
 <CADnq5_PBt9-x9d9TuW7_0Yrarpmp2bMTdDPXFv2ep=p89sULkg@mail.gmail.com>
In-Reply-To: <CADnq5_PBt9-x9d9TuW7_0Yrarpmp2bMTdDPXFv2ep=p89sULkg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Jan 2022 09:58:27 -0500
Message-ID: <CADnq5_OVB-P2dE=ZZRXC2QsL6tFTXbZoaPw3FmK6XHECvZgZZg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix rejecting Tahiti GPUs
To: Lukas Fink <lukas.fink1@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 xinhui pan <Xinhui.Pan@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 14, 2022 at 9:56 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Jan 14, 2022 at 3:27 AM Lukas Fink <lukas.fink1@gmail.com> wrote:
> >
> > eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device") added
> > generic bindings to amdgpu so that that it binds to all display class devices
> > with VID 0x1002 and then rejects those in amdgpu_pci_probe.
> >
> > Unfortunately it reuses a driver_data value of 0 to detect those new bindings,
> > which is already used to denote CHIP_TAHITI ASICs.
> >
> > The driver_data value given to those new bindings was changed in
> > dd0761fd24ea1 ("drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type by default")
> > to CHIP_IP_DISCOVERY (=36), but it seems that the check in amdgpu_pci_probe
> > was forgotten to be changed. Therefore, it still rejects Tahiti GPUs.
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1860
> > Fixes: eb4fd29afd4a ("drm/amdgpu: bind to any 0x1002 PCI diplay class device")
> >
> > Signed-off-by: Lukas Fink <lukas.fink1@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 9ec58bf74012..224d073022ac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -1903,7 +1903,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
> >                         return -ENODEV;
> >         }
> >
> > -       if (flags == 0) {
> > +       if (flags == CHIP_IP_DISCOVERY) {
> >                 DRM_INFO("Unsupported asic.  Remove me when IP discovery init is in place.\n");
> >                 return -ENODEV;
> >         }
>
> Thanks.  Actually this entire check can be removed at this point.  The
> IP discovery support is in place.  I'll send a patch.

Actually, I'll take this patch and then send a patch to remove it on
top of that.  Thanks for fixing this.

Alex

>
> Alex
>
>
> > --
> > 2.34.1
> >
