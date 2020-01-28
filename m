Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88332C2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A8162070E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 20:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEQC//3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8162070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0856F3E2;
	Tue, 28 Jan 2020 20:14:44 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE15B6F3E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 20:14:42 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id w15so17618313wru.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W+OzFAtDPoho58BmhLihNfDGa3T/ar1e5aSVjbxK/mU=;
 b=lEQC//3W81K5IOEPsClTlGmnPNpOPI0wkTnjIRq/s4W5svn3mA0s/2sGigdwvHmmOb
 lVtufJtaTs4OGybH0NeRhGxMEBDc0WaHHEjG3aWMDDyLs2MdlWOhq048e9UESAMrY6aW
 P2F8QwfqscOCVAPfxXYlirtDBwCKyqhrmf6tLYoYw1+0Kg1tgcTnUcBkxKcdCnIARWqB
 DM+mBKcvE305yD0QVxksffhbjHGy3hT00QnEL7g5cG7sxv+i2eUtp38r6WaGjL539/ig
 iI7CU0WEVjrFezbXKe5QOnK9hbnQ2ySBBmgfk511Gsk6/V91Rnq5oeJb0lI6kgeWbzHS
 5o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W+OzFAtDPoho58BmhLihNfDGa3T/ar1e5aSVjbxK/mU=;
 b=OrXrMdNYNQ7vU3a51BBI8VGKGf7dsL3cDoaow6vf2y1itVsnrOl/0IZbPUkr6xaBdC
 NtbM6BkBWdjK/dzeEcIG3Z92oWiOjDeaz+oNHXKLBntb8axmkTy4ciGutvxrHpYXN1U9
 UmCDKPD/d5ZFGeNIablmPo0gddqCpld6p0hrfqIwJ7EwgkNEsSWRIh00n69QbBCIFA7t
 7O4qFI4ZeizBVlV9BUfpAf5IMISlg5MoycQQfZp4HqEECQJ4im4lhRjxsS1Ecq/Hnp1T
 /gW47+URWrovSwfMWDq3ZQOUhVjun05wchXjFe1LsKNVDwldKGK9DtqbtMmF3yWUmfjx
 y9uw==
X-Gm-Message-State: APjAAAWnMYnWI2aac+iBP0k9wdeXuHgViF2WPHIVW2YAnnODOIHPG1SV
 VtP8n4y2pRxC7az++h74/Rh+msWxM+42y45f6Lnd75s4
X-Google-Smtp-Source: APXvYqxsza8Rg9LP6a2/vxRB/fQZq77oYsg3ZjVLI+NudrZiSQZb0axWf/ynbN60Q8q62MeXoNCMJqM9CVR+kL6Qd5M=
X-Received: by 2002:a5d:5091:: with SMTP id a17mr30072272wrt.362.1580242481363; 
 Tue, 28 Jan 2020 12:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
 <20200128012923.25536-2-rajneesh.bhardwaj@amd.com>
In-Reply-To: <20200128012923.25536-2-rajneesh.bhardwaj@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jan 2020 15:14:29 -0500
Message-ID: <CADnq5_N6vKSpLGBj2TkiCOaOskrT2T4EQ3NmNp0hOLumCLithw@mail.gmail.com>
Subject: Re: [Patch v1 1/5] drm/amdgpu: always enable runtime power management
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
> This allows runtime power management to kick in on amdgpu driver when
> the underlying hardware supports either BOCO or BACO. This can still be
> avoided if boot arg amdgpu.runpm = 0 is supplied.
>
>         BOCO: Bus Off, Chip Off
>         BACO: Bus Alive, Chip Off
>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

This patch should be the last one in the series, otherwise we'll
enable runpm on BACO capable devices before the KFD code is in place.
Also, it's only supported on VI and newer asics, so we should use this
patch instead:
https://patchwork.freedesktop.org/patch/335402/

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 3a0ea9096498..7958d508486e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -169,11 +169,10 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
>                 goto out;
>         }
>
> -       if (amdgpu_device_supports_boco(dev) &&
> -           (amdgpu_runtime_pm != 0)) /* enable runpm by default */
> -               adev->runpm = true;
> -       else if (amdgpu_device_supports_baco(dev) &&
> -                (amdgpu_runtime_pm > 0)) /* enable runpm if runpm=1 */
> +       /* always enable runtime power management except when amdgpu.runpm=0 */
> +       if ((amdgpu_device_supports_boco(dev) ||
> +                       amdgpu_device_supports_baco(dev))
> +                       && (amdgpu_runtime_pm != 0))
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
