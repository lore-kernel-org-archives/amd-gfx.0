Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97513C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660CE20708
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqHN8ZIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660CE20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D066E123;
	Tue, 28 Jan 2020 20:15:31 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21FC6E123
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 20:15:29 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id q9so3888149wmj.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 12:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UFocr1OZqfUg3bmEOAkET+wQr/XSbmGGBJmeInfqso4=;
 b=ZqHN8ZIj1OC/5+dP55GkK3tQet9GUaVpgZlH4uvdp+UjUlDBJ0z8Fi/abRKMMLfxzc
 vuEUVNit9KFH60CNaWBiqh2QeuKYV6y1qyBNRD1pKkDXdGaJrRrheMu22PgJsDQHK/sq
 yGL3exCozndYkJuJ5t4EHZpDQaw5rJtNWmDQVaWHkRK44nL9gT4TK0Hq2q1uswfNa7+2
 jSZC6ZvB8oHZLUVPsxCAzhVRpr3dKnpOdL6/A9kxwxhFMbQ0yCBKMnPIq+S+GC1od3Eq
 yYFA7jvFKIyjJNlt97trjRNUZzsUP4eF27Gi7wGh9w9AtNenAR6YdNSM7HfiqDOBLjjY
 aXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UFocr1OZqfUg3bmEOAkET+wQr/XSbmGGBJmeInfqso4=;
 b=QSWGug0Jbu75I2sKd4NQdtAwb2a5mNMVkHTKT8YUGuCmsSrwowFGqr2b7a0c3C6oOU
 JbwZryftJnedth7mo7Jwq+UyEOPULd5g74xz9MgJCKs8PCYNaAtGEFx07+aTlDULpJvB
 ORkZtZtv3bdVm6C6pqpYSU+xWv9cbo6ZPCs96EoitcMnYsK/ckBeTh4XdeoCbRIlaTo6
 xL6Kd1Z9bWlVVLBmJzunROOIBjRzl1RXwEVHdDyeiS2hxikkTCiTGuJKaetKk6yozYsV
 fJz52yh1OTtqoVKqRAEFAXg58CSj6V3sBK7Ricf2A7Vut4/ppOJlxPAj/44OwxubXfq6
 nFvA==
X-Gm-Message-State: APjAAAXMMhRVcooYepayzW+SIEaI4fb0uyckplyVGdvBjyOjlLsLuMJ0
 nwi0ewggiXgtq7J8yXRyKin04PyvOGv3gb/1ZwE=
X-Google-Smtp-Source: APXvYqweDshBYqDVSmBznOSMZSf+yNZb5CueDyPiBR4uqbTccNb+iqEDtgpy0iiQwAO8F8ODpVWuXL/MWe6+zDUlZgU=
X-Received: by 2002:a05:600c:2c53:: with SMTP id
 r19mr6854698wmg.39.1580242528478; 
 Tue, 28 Jan 2020 12:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
 <20200128012923.25536-3-rajneesh.bhardwaj@amd.com>
In-Reply-To: <20200128012923.25536-3-rajneesh.bhardwaj@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jan 2020 15:15:17 -0500
Message-ID: <CADnq5_P_z3P=16vSChO86XN3=bSJ1hmzZmfq1mQMi5iyaBC_pg@mail.gmail.com>
Subject: Re: [Patch v1 2/5] drm/amdgpu: Fix missing error check in suspend
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 27, 2020 at 8:30 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@amd.com> wrote:
>
> amdgpu_device_suspend might return an error code since it can be called
> from both runtime and system suspend flows. Add the missing return code
> in case of a failure.
>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 137e76f0e3db..71466df6dff6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1236,6 +1236,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>         drm_kms_helper_poll_disable(drm_dev);
>
>         ret = amdgpu_device_suspend(drm_dev, false);
> +       if (ret)
> +               return ret;
> +
>         if (amdgpu_device_supports_boco(drm_dev)) {
>                 /* Only need to handle PCI state in the driver for ATPX
>                  * PCI core handles it for _PR3.
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
