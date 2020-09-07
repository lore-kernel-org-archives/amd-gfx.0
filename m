Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECB0C43461
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 08:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2857208C7
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 08:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Zzb4dzjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2857208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8649F6E2F9;
	Mon,  7 Sep 2020 08:07:30 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACDA6E328
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 08:07:30 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id m6so14793819wrn.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2020 01:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=a34LqIGh8Ore9lQ5nuwZ0RKCoARr8JhMKOxwLqhOSbg=;
 b=Zzb4dzjmSqGszJ/LTvtdJR7BNlJaQI4LCxCIRH5uIwMPptzHmbFKaaOMhq51k1rbb4
 yoYfY17SP6lESmJgNU0XgPbUXpFzgwKy0urM9aaejVwX5gwP4H2aaXADWsgLqXxGDAIL
 m2e+ybxNJlVoQ1/Ln1481m6bnputLTBHg96hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a34LqIGh8Ore9lQ5nuwZ0RKCoARr8JhMKOxwLqhOSbg=;
 b=P5qO8htGDETcrAhzjgVA+kj/BqDjszIDZwnARo5Reul6rxFkGh1ZeVGWX4XAzhWsNZ
 qsVkW+H/CRhMirXT5kEMOVc1UcreisuR181vklgJBDBpOlpZFSHJAb6sJ1/aDc14UNo1
 HHyiJ7mnTdvG8AdRUQUmrjvPzpYgZwO6Mz0v7xmjekpAXrL60tH68PvGopbZbmbwmHV+
 OdPbeICOi7tFWX3MI6vcl/S0Oyf7NrB6ZLTh7j2va4Vr5VGlj0NoRLM98oW06Shu9rS9
 fK4xvbXFCSutJYVxlLN+n9zuZkQQlxElqvkRCfA2KfH5ddsPDkNyBC/WdYxXLLUfVucv
 T0gg==
X-Gm-Message-State: AOAM533nYjZ2rePB8q8YAQ+S1USlQhcHqGqXIX2Nt7z/yUthIV8Pgyee
 K3sIXaduwSV/VlfZLh7JO1aISA==
X-Google-Smtp-Source: ABdhPJzRMa2LOsZoYLEl10YLrV2gnxP6PrzTF8Ou08ECjZFhZu7sk9ZzY1mOEMNlOLH/oATO7A9zYw==
X-Received: by 2002:adf:81a3:: with SMTP id 32mr20553073wra.368.1599466048658; 
 Mon, 07 Sep 2020 01:07:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id y5sm17213230wrh.6.2020.09.07.01.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 01:07:28 -0700 (PDT)
Date: Mon, 7 Sep 2020 10:07:26 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Convert to using devm_drm_dev_alloc()
Message-ID: <20200907080726.GQ2352366@phenom.ffwll.local>
References: <20200904012218.4971-1-luben.tuikov@amd.com>
 <20200904012218.4971-2-luben.tuikov@amd.com>
 <CADnq5_NRyOfP48C5w4Q87qx98-hTLQP7PsP8OhGMbXJBu_Gb4A@mail.gmail.com>
 <20200907080608.GP2352366@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200907080608.GP2352366@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Luben Tuikov <luben.tuikov@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 07, 2020 at 10:06:08AM +0200, Daniel Vetter wrote:
> On Sat, Sep 05, 2020 at 11:50:05AM -0400, Alex Deucher wrote:
> > On Thu, Sep 3, 2020 at 9:22 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
> > >
> > > Convert to using devm_drm_dev_alloc(),
> > > as drm_dev_init() is going away.
> > >
> > > Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> > 
> > I think we can drop the final drm_put in the error case?  I think the
> > unwinding in current devm code should take care of it.
> 
> Same applies for the pci remove hook too.

KASAN run with unload should have caught this. I strongly recommend doing
that for any changes to the unload code, it's way to easy to mix up
something and release it in the wrong order or from the wrong callback or
with the wrong managed (devm_ vs drmm_) functions.
-Daniel

> -Daniel
> > 
> > Alex
> > 
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++--------
> > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > index 146a85c8df1c..06d994187c24 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -1142,18 +1142,13 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> > > -       if (!adev)
> > > -               return -ENOMEM;
> > > +       adev = devm_drm_dev_alloc(&pdev->dev, &kms_driver, typeof(*adev), ddev);
> > > +       if (IS_ERR(adev))
> > > +               return PTR_ERR(adev);
> > >
> > >         adev->dev  = &pdev->dev;
> > >         adev->pdev = pdev;
> > >         ddev = adev_to_drm(adev);
> > > -       ret = drm_dev_init(ddev, &kms_driver, &pdev->dev);
> > > -       if (ret)
> > > -               goto err_free;
> > > -
> > > -       drmm_add_final_kfree(ddev, adev);
> > >
> > >         if (!supports_atomic)
> > >                 ddev->driver_features &= ~DRIVER_ATOMIC;
> > > --
> > > 2.28.0.394.ge197136389
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
