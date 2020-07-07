Return-Path: <SRS0=Rnur=AS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747D4C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 18:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C01F20675
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2020 18:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rN9uqEjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C01F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06EDB6E248;
	Tue,  7 Jul 2020 18:22:18 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0413D6E248
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2020 18:22:16 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id l17so120589wmj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2020 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6CvdL6zwnxLUEIJ3NJoaOnkYBKKFjB/fZTdO4ueU6kA=;
 b=rN9uqEjj9BpiuobaCurP2VvzyxzyPUs8EhdS95LAi2bhYXMLBepPgG492/cXszAQeg
 qoN7JnPYCLZ2MhV8KWkgJz4lJtSb5dGZQOgDIF+XJDFgT8RAVun67/W248DaSgd2eojH
 E03MYzUlfBNln6W2DNQLdRCrazZ1tC3vaHF5+UhlaY3nuY47w+FWcIax/Frnub+8S6uj
 gWQbDzUFXuM9qlgZi8WrsF7EKNgBn3DscXz5ljQi4UFb3A/3EE7LyU3vZzH7iHzTAQ2r
 abj6OkPVc+gwqUsauC/lmoScNrKExauTpZIvbaVVjOHmyascXZrCKwaDwC+fdSGGu00l
 vb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6CvdL6zwnxLUEIJ3NJoaOnkYBKKFjB/fZTdO4ueU6kA=;
 b=gSVh8O3IcHHD8E97p93LAF+dFCvQOGLZQyfCja43yv6Iza90KY4PtVUYPE9Sl5d72x
 I3YbWAdKiI2eIFyAPMXjEETJ68QzYQvzyGxHTWnXjrqJWW1DGKDxdRYe6QK/j0Tjndx7
 jtItyjob2v0HeiCKxXwvcGJAl180/2MvDQiveproYaOy8PREWpOgSdp8wuA46Xq6me87
 bHJ9+8a2/iuv4dLAE9VFOIXmZaKcy5HLohAVf5zMKARxcyQnKlvg/N0L1XddzbOFw4cv
 uu+urwS1MxinVyD0/sGzoRA5e1EPLp5gbP1Gzsy5/0LWhs8KDwnFd9syhZyPXBz3yxaA
 6vmw==
X-Gm-Message-State: AOAM531/iqQmFnC8HZrS9kten56Jf72w8KRbMISbWnFWtN/N9KurAe8D
 ufTRdKazRUR5fA4wzZiBpOzczu7UNg7FgAWJf6415LuM
X-Google-Smtp-Source: ABdhPJzMrerYgrB6RUscLB61DppI1l+cGapBH41SA8KQedgYW1gaxg8bHii3/d+JLa6AzIvJ9Ki0Fy/dnrXqIMseBRk=
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr5417223wmk.39.1594146135630;
 Tue, 07 Jul 2020 11:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <119ce850-c07f-8a4d-ac3c-78e021b7dd32@amd.com>
 <20200707180430.2760835-1-ytht.net@gmail.com>
In-Reply-To: <20200707180430.2760835-1-ytht.net@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jul 2020 14:22:04 -0400
Message-ID: <CADnq5_N4cXHePP3q-4S-mJpkaMKMZRp_e_uB1P5hG-_f06rDyA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix null pointer reference to adev.
To: Lepton Wu <ytht.net@gmail.com>
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
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 7, 2020 at 2:15 PM Lepton Wu <ytht.net@gmail.com> wrote:
>
> I hit this when compiling amdgpu in kernel. amdgpu_driver_load_kms fail
> to load firmwares since GPU was initialized before rootfs is ready.
> Just gracefully fail in such cases.
>
> v2: Check return code of amdgpu_driver_load_kms
>
> Signed-off-by: Lepton Wu <ytht.net@gmail.com>

Already fixed:
https://cgit.freedesktop.org/drm/drm/commit/?id=7504d3bbec7da70516a13e34415b92bf5203399a

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 126e74758a34..75bcd1789185 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1111,7 +1111,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>
>         pci_set_drvdata(pdev, dev);
>
> -       amdgpu_driver_load_kms(dev, ent->driver_data);
> +       ret = amdgpu_driver_load_kms(dev, ent->driver_data);
> +       if (ret)
> +               goto err_pci;
>
>  retry_init:
>         ret = drm_dev_register(dev, ent->driver_data);
> --
> 2.27.0.212.ge8ba1cc988-goog
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
