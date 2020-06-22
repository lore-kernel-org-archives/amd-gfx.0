Return-Path: <SRS0=8rPh=AD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6A9C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 19:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456DA20716
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2020 19:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCZGpqZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456DA20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB4506E167;
	Mon, 22 Jun 2020 19:48:03 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6279E899F3;
 Mon, 22 Jun 2020 19:48:02 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id g75so692329wme.5;
 Mon, 22 Jun 2020 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gBc+0vrtOxcD021MUOTNNQdQfnjCsQrAby5hoJa8Kto=;
 b=LCZGpqZeDWC00oxT1l2xDq5CVRNcNOypP7WR7/Opgx2dByTukTXSPOT91XqlUSPAHe
 YMcLj893gD8rBwMOB46CZN4C4EOwJGAk3OEjjm0mGp8D7fxAvToqYS3kQT9eyjATbi8p
 8+qr1QXUoEVnIKqffwfHiOJQlpH9MywFXIRsZvpmc7ik4JADChxm8qkrui1f3r6uI1BC
 W/3SQGDELdyQIdeevvGpFCE+6uBwVJzrSy0DSzW+kjDcxdKJ03bNhnp6eZP29+BQdt+u
 0qX2OnGjUga/kjAcBD7zoXTnDk3FkgpW4FoJlc8uXCKCUc8RaOzDIwhJBmU/ypsncdg3
 dRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gBc+0vrtOxcD021MUOTNNQdQfnjCsQrAby5hoJa8Kto=;
 b=r63dhYFh2mHk3SJkg/x8cfTGM3VJx2kFKt/29m7o+iARU+jFqErEBPjUx5lMX3KMZX
 X7KABh0s4teW2Yk8Yfg9h5RY7EGBk9/NQtiEvuMUOXxnwazzEMcstbQldvLMB/0ot2cj
 OuaUipbuOBZ/0T4QSv2st3YJCSBuJSk+vvK1mVOo87scgMfvB02vxFPgzCjsM1X/bB+v
 bm+EKbw2kVrw5tAEWLxd2ADXeYB57pP0E+rNRadM5YVAgUnHUZX4GS4hiomAEJ5zDnX0
 LX2xvNzhPNqoGH89xMOAr6S3xvW4QCgkc+iLmHZZlC9wDxDxp0R1fCY37Wzg/RBels1D
 0+ZA==
X-Gm-Message-State: AOAM531UzkLl9/gAuccdX6ExL7fzMDRmPFTTWleDDhJ5aUf9YYd/AeoL
 6Uf/Ke2dfZp9lGFQKjfiplk1WZR28suOBoB9LDo=
X-Google-Smtp-Source: ABdhPJzrkhpUifB6Xvx3B0iz8wpxbsMLskrD6b3iK6/o24NfofseFWShOI7rhM0sUnwLB3YIi1Ipf92Me1Q9oA91gfA=
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr19698396wml.70.1592855281083; 
 Mon, 22 Jun 2020 12:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <1592719388-13819-1-git-send-email-andrey.grodzovsky@amd.com>
 <1592719388-13819-4-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1592719388-13819-4-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Jun 2020 15:47:49 -0400
Message-ID: <CADnq5_OPtWz9eq4-c320f7xjd7A=016ZVWmi58q_v-YAHw+=MA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] drm/ttm: Add unampping of the entire device
 address space
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Pekka Paalanen <ppaalanen@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jun 21, 2020 at 2:05 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Helper function to be used to invalidate all BOs CPU mappings
> once device is removed.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Typo in the subject:
unampping -> unmapping

Alex


> ---
>  drivers/gpu/drm/ttm/ttm_bo.c    | 8 ++++++--
>  include/drm/ttm/ttm_bo_driver.h | 7 +++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index c5b516f..926a365 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1750,10 +1750,14 @@ void ttm_bo_unmap_virtual(struct ttm_buffer_object *bo)
>         ttm_bo_unmap_virtual_locked(bo);
>         ttm_mem_io_unlock(man);
>  }
> -
> -
>  EXPORT_SYMBOL(ttm_bo_unmap_virtual);
>
> +void ttm_bo_unmap_virtual_address_space(struct ttm_bo_device *bdev)
> +{
> +       unmap_mapping_range(bdev->dev_mapping, 0, 0, 1);
> +}
> +EXPORT_SYMBOL(ttm_bo_unmap_virtual_address_space);
> +
>  int ttm_bo_wait(struct ttm_buffer_object *bo,
>                 bool interruptible, bool no_wait)
>  {
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
> index c9e0fd0..39ea44f 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -601,6 +601,13 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
>  void ttm_bo_unmap_virtual(struct ttm_buffer_object *bo);
>
>  /**
> + * ttm_bo_unmap_virtual_address_space
> + *
> + * @bdev: tear down all the virtual mappings for this device
> + */
> +void ttm_bo_unmap_virtual_address_space(struct ttm_bo_device *bdev);
> +
> +/**
>   * ttm_bo_unmap_virtual
>   *
>   * @bo: tear down the virtual mappings for this BO
> --
> 2.7.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
