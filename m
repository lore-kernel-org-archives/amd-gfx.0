Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D72C352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 16:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C2E20714
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 16:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k21Aoa5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C2E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 277EF6EEC3;
	Tue, 11 Feb 2020 16:41:02 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADC86EEC1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 16:41:00 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id u6so13253025wrt.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5L7XMWtkN16lvACJWYzWpXomfmsrJev14sUMnUX/KTY=;
 b=k21Aoa5VGxruNeU+aQt8bbMRh4tonHC6tRdj4ew+f+13Gxnjaotj4aKnnZdQWNwiyF
 k2YLz2WtmfiWUGz90TaYbqBiZjuRP0b8JRvBQa41imZ3vRXDvttYRh8J5FKTz2iGcUgd
 WLGMm6W8j74d7GjlvfoMv+S8CdQCukjvhMbZ7lP4UhyKWk6Z5t5SRUpEwj17N9lAs44c
 vougUyVwUcGL0AUGD49a2MZZEUvcdMzskKa9AC/qCW0u5RkCxkNBjC1jKcSNMzKx39OI
 QZhUjBqL36XLpilAtdth5K/FwBAD6FpSe5F9plNpJ09b3EJkqHyFEGWlifiCmW/QUzKa
 uxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5L7XMWtkN16lvACJWYzWpXomfmsrJev14sUMnUX/KTY=;
 b=jiZ8VgT5ZwUdAXWW12fE6GmfzhJzGnfaSA6Z3UXlqZp/nZtspPtXu6tSjtK3xuCuKj
 ry1BMUFOL5gM5TVypPnihqym8n/2wHpgErKCSXjKKmUQb5DnX4PTgftxFI3bByjgWNSn
 6WTmoB2FQy3Zn9lC+rEs4F7MoI7HLx5+X1IYXFzi04D5HyoBI4ClC1Mnvt4i6Zn0MUoH
 b5Ht+jSRCRsYo4pbI2guMCcfA1ooNHNLQHJNWQu06UfOMVPfqnMDi7vcisKF/Nq+NXTB
 xOkNT79O3kJf2VzBQpunNQugVDcNwa1pUAvdB2py/1N6NpAX9SPvHico8IkQ6/WTMUut
 Zt6A==
X-Gm-Message-State: APjAAAXOisnuWGPOpA9KQ1QUVcKSQlUwcfOqcJH2FeU5nmFHR8KSiHSZ
 3gK0wmotMypVUChY2YMAF8Z28F5rkwVt9Ys6R68+dQ==
X-Google-Smtp-Source: APXvYqy625x7tMruQNaHqsp5MrfxgCkbSfsmZk8j+P2/p9aNwX4yjefm+PqUJry5Nl4mklc5kW1ZbWaUSVjXg7Et8uU=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr9844674wrn.124.1581439259507; 
 Tue, 11 Feb 2020 08:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20200210184807.6271-1-rajneesh.bhardwaj@amd.com>
 <20200210184807.6271-5-rajneesh.bhardwaj@amd.com>
In-Reply-To: <20200210184807.6271-5-rajneesh.bhardwaj@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Feb 2020 11:40:48 -0500
Message-ID: <CADnq5_NZVPV6neye8pZjzc87Pjqb882K8SO0DvD_TGmFM42bsg@mail.gmail.com>
Subject: Re: [Patch v4 4/4] drm/amdgpu/runpm: enable runpm on baco capable VI+
 asics
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Kuehling,
 Felix" <felix.kuehling@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 10, 2020 at 1:48 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@amd.com> wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Seems to work reliably on VI+ except for a few so enable runpm barring
> those where baco for runtime power management is not supported.
>
> [rajneesh] Picked https://patchwork.freedesktop.org/patch/335402/ to
> enable runtime pm with baco for kfd. Also fixed a checkpatch warning and
> added extra checks for VEGA20 and ARCTURUS.
>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 3a0ea9096498..0f3563926ad1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -170,10 +170,16 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
>         }
>
>         if (amdgpu_device_supports_boco(dev) &&
> -           (amdgpu_runtime_pm != 0)) /* enable runpm by default */
> +           (amdgpu_runtime_pm != 0)) /* enable runpm by default for boco */
>                 adev->runpm = true;
>         else if (amdgpu_device_supports_baco(dev) &&
> -                (amdgpu_runtime_pm > 0)) /* enable runpm if runpm=1 */
> +                (amdgpu_runtime_pm != 0) &&
> +                (adev->asic_type >= CHIP_TOPAZ) &&
> +                (adev->asic_type != CHIP_VEGA20) &&
> +                (adev->asic_type != CHIP_ARCTURUS)) /* enable runpm on VI+ */
> +               adev->runpm = true;
> +       else if (amdgpu_device_supports_baco(dev) &&
> +                (amdgpu_runtime_pm > 0))  /* enable runpm if runpm=1 on CI */
>                 adev->runpm = true;
>
>         /* Call ACPI methods: require modeset init
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
