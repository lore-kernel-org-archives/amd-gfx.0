Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32940C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 08:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61B2208C7
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 08:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FOBwhnKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61B2208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 589236E2F9;
	Mon,  7 Sep 2020 08:06:14 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED376E2F9
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 08:06:12 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a9so13259997wmm.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2020 01:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=J1Mpi4UEGst1+jfTnSAZj1njlq1xD6nM4x6w31L/2X0=;
 b=FOBwhnKLM1GK4o55+YgVRJeoCXrR0a/twv0kdgj2Dq5MTJ9AQc7YprEvSbcjJjzWxb
 pEKPxBs8/0EgAthjuLFjWRjPxmVQPqZq1Q5LjmfvN/l9W+3pQEosyGzE/Ophf1h2LeEO
 x1YRnxSN+YZH9+bM2Gu5Cv0spcDU8nzdt0nz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J1Mpi4UEGst1+jfTnSAZj1njlq1xD6nM4x6w31L/2X0=;
 b=dwzKgVqJpBf1iJwbswI2XHxyd/JGV/5Z2AefLIMr3BaTgaCjU0nSaOelDZbfH/C70i
 O58BMKpruRuvA/O3kwzeWacArGusJOPHynutVeAw3dPaf0cBnjGSSAL5E9D2LRFsE/Tq
 YzfSJ8FNVIr0WjKVAtWPgotzLUK5RzWavwT/als7YvVibdTGRks8cybUNhHD8vUdDWGs
 S3EPfbazn2WphvIQ/tehN88XLxUjyvM0uJqKY0s/IZF0waR5+4mI1JTY0zG+gTmW3K0H
 JToKCgLajAbnTp12HTw0d2GOJKoYZ2Atuf9k4DYUcj6RStlERTJSb0uwVfnylrpDGvdb
 rwcQ==
X-Gm-Message-State: AOAM532tAX0qNNbQOv1G56KMrMcJtzjh439Ot4J3LfsPy5kEuKM4IQLv
 PpRVSo+kj7/CAwfJdMIOQkFjJg==
X-Google-Smtp-Source: ABdhPJyP3+GM7ddbwBGCkBbL4EcryirV3FquaTBp2f8U3roTfj+eTB2QdzV7CLgAoppO8cZcTc4LoQ==
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr18787566wmb.129.1599465971341; 
 Mon, 07 Sep 2020 01:06:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id d2sm7437483wro.34.2020.09.07.01.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 01:06:10 -0700 (PDT)
Date: Mon, 7 Sep 2020 10:06:08 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Convert to using devm_drm_dev_alloc()
Message-ID: <20200907080608.GP2352366@phenom.ffwll.local>
References: <20200904012218.4971-1-luben.tuikov@amd.com>
 <20200904012218.4971-2-luben.tuikov@amd.com>
 <CADnq5_NRyOfP48C5w4Q87qx98-hTLQP7PsP8OhGMbXJBu_Gb4A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_NRyOfP48C5w4Q87qx98-hTLQP7PsP8OhGMbXJBu_Gb4A@mail.gmail.com>
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

On Sat, Sep 05, 2020 at 11:50:05AM -0400, Alex Deucher wrote:
> On Thu, Sep 3, 2020 at 9:22 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
> >
> > Convert to using devm_drm_dev_alloc(),
> > as drm_dev_init() is going away.
> >
> > Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> 
> I think we can drop the final drm_put in the error case?  I think the
> unwinding in current devm code should take care of it.

Same applies for the pci remove hook too.
-Daniel
> 
> Alex
> 
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 146a85c8df1c..06d994187c24 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -1142,18 +1142,13 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
> >         if (ret)
> >                 return ret;
> >
> > -       adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> > -       if (!adev)
> > -               return -ENOMEM;
> > +       adev = devm_drm_dev_alloc(&pdev->dev, &kms_driver, typeof(*adev), ddev);
> > +       if (IS_ERR(adev))
> > +               return PTR_ERR(adev);
> >
> >         adev->dev  = &pdev->dev;
> >         adev->pdev = pdev;
> >         ddev = adev_to_drm(adev);
> > -       ret = drm_dev_init(ddev, &kms_driver, &pdev->dev);
> > -       if (ret)
> > -               goto err_free;
> > -
> > -       drmm_add_final_kfree(ddev, adev);
> >
> >         if (!supports_atomic)
> >                 ddev->driver_features &= ~DRIVER_ATOMIC;
> > --
> > 2.28.0.394.ge197136389
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
