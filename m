Return-Path: <SRS0=S4aW=CO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7E3C433E2
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2020 15:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F2B206B8
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2020 15:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNVhN54s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F2B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47440898CA;
	Sat,  5 Sep 2020 15:50:18 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719E989021;
 Sat,  5 Sep 2020 15:50:17 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a65so9375386wme.5;
 Sat, 05 Sep 2020 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pXbA5QzXaE9R1TUgN58xIlVudUBkwmoW38ydLzuUlbw=;
 b=PNVhN54sLGUBiCB9RkkMawPjyZ+NkUWAY1nYfephvsoOEOVaPPFhxuZtfKHBF4+EDr
 KAkEnIOjmxYPTCOG8N9Cm3237Ww9RU4ICmTZ4iEnCJC64GqnDEIZJme5kfflseCF0kqt
 tJA9Tgkh7ZjCT4e7xP//o7682EjRFAUsh55D4f3aKezTlyTL3Kz1T7KFVXpSnWDwV8bA
 VIf47XZesqvGwbOv4tF2z/cAkBdPio/+UHaolj8lLdXv+fcPnDgne3Bly78KUFEpXxBu
 kSdcI+eONRMxdsm1DB/t0FTfqk6PKzqtoTDsQp5fPkFaTtku7h5MlMdRlzfZ0Vm+H4ex
 OGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pXbA5QzXaE9R1TUgN58xIlVudUBkwmoW38ydLzuUlbw=;
 b=H7+FWdZcOPzaEYcwKFBhKpZXm7TvqCRmuWGIxL1cF+Fi67+DNmD+VwBvfGYCfNTU9A
 Am2xWk984LBOZrzxrMl0YxjMPfsl/qv/RIyFGZ5c5qmg5Ki95/zRm/p8ZSDftht8WTzO
 u7LmMR60fE1KtoMUlG3EDtcgTkE/NFbej7rVD+56hVu7QQPqWW1SxQwRqUJ4AJ3v3oFV
 L9B8z25NVR002lMyfSBduxaY4miCWSq+zmVYHWMVghjSPB9kVcPsnB7RWlFTxVe0+GEd
 UnL7y+f0mgjHKUStWT+psBwCKLbV/6GG1on4tnWqP5q9Cfa74AKuDTXrlucvEZ95RMwD
 A1tA==
X-Gm-Message-State: AOAM531+BZxUfUB3O3bg+hcR6p306LTdr6vmw0KzEv24OvX+R3OHM7WD
 VkCAvdDf647LcAsn8j49mNqNXrqHzDgSMyS7AFs=
X-Google-Smtp-Source: ABdhPJznxRpuo85kX5TUVzhel4uX1W0BIskZ+6ZxFcgOlIJzwDmtxS6yKdWRjfsJ9zntaVYKEnXb1DNLSbTXXdeWCaM=
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr12981690wmj.79.1599321016109; 
 Sat, 05 Sep 2020 08:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200904012218.4971-1-luben.tuikov@amd.com>
 <20200904012218.4971-2-luben.tuikov@amd.com>
In-Reply-To: <20200904012218.4971-2-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 5 Sep 2020 11:50:05 -0400
Message-ID: <CADnq5_NRyOfP48C5w4Q87qx98-hTLQP7PsP8OhGMbXJBu_Gb4A@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Convert to using devm_drm_dev_alloc()
To: Luben Tuikov <luben.tuikov@amd.com>
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
 Daniel Vetter <daniel@ffwll.ch>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Sep 3, 2020 at 9:22 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Convert to using devm_drm_dev_alloc(),
> as drm_dev_init() is going away.
>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

I think we can drop the final drm_put in the error case?  I think the
unwinding in current devm code should take care of it.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 146a85c8df1c..06d994187c24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1142,18 +1142,13 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>         if (ret)
>                 return ret;
>
> -       adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> -       if (!adev)
> -               return -ENOMEM;
> +       adev = devm_drm_dev_alloc(&pdev->dev, &kms_driver, typeof(*adev), ddev);
> +       if (IS_ERR(adev))
> +               return PTR_ERR(adev);
>
>         adev->dev  = &pdev->dev;
>         adev->pdev = pdev;
>         ddev = adev_to_drm(adev);
> -       ret = drm_dev_init(ddev, &kms_driver, &pdev->dev);
> -       if (ret)
> -               goto err_free;
> -
> -       drmm_add_final_kfree(ddev, adev);
>
>         if (!supports_atomic)
>                 ddev->driver_features &= ~DRIVER_ATOMIC;
> --
> 2.28.0.394.ge197136389
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
