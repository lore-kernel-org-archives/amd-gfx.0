Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C599C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 17:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC57F604AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 17:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC57F604AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8203D6E90D;
	Mon, 11 Oct 2021 17:20:37 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC826E90D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 17:20:36 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id z3so11364908qvl.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 10:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RdOzdvfDv2GljffusM/Ehb0EaDpYPMlyS7xf+FUDxDY=;
 b=46Rsial5eCW9iaCO/XrmacMMF9b9UR8bcQmtgbgjUGGDscF+dty6sP0zzJUbvK45ee
 2YqmVG0y2O8V5GfttjldKLaslGnH/PivB6YX8m7OIjIjUleQwufp+9DjZOVAimO9bykU
 roM/xn5UMn4o9F6cfhI2KQJzD1ga8bv5ukcBJioRh/nTqzgkHMuK1HtgDIPbDU8IJnSz
 ZLn2h0BWIejaBG3xfzDNxEfaPTA5f8oJXvT2q7cUcSQZ3L85J3V3JOMDYWe/72HhVtom
 VkILXzsOv5qI31FoQbqJdoqyZVhTFlcKZYSNVxQSXpeNjXaVdjbWRL9d+YDNuksqNC9m
 wpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RdOzdvfDv2GljffusM/Ehb0EaDpYPMlyS7xf+FUDxDY=;
 b=L0uFp4q7amgoxHrUQtqaPt11NhwF1K3fJ5EZrsKc939U1ngWPWuqKRosGC9glUA9aV
 yOPOg0BAO2pss1X0QSh0g5q56s/u6tnZCD4wFjjMN1aibptm5bM+I/9pZ1rm02vcS5xk
 8jSQog+kVqzSa8N5xZn799RSDiR3gCn9i9xX4u1a4dTg2oEeY+VwpSZv/4qXzzunOKsI
 x2ZomJ8ZXcQn9iWCZSow1tsBgOs8vFFOA97+PjRurdprtXy4oVR2/UzBUKTR/1hZbslD
 6v9mnAUZNJZKzbPYeDxmKky26igHlIVq5qqyLMDF2xFsT27aTDPOn+fPLmrISqQItqFf
 hT2Q==
X-Gm-Message-State: AOAM531PCWFNe1SMbGBiSkqdBFAePG7sQdgaX4lT3pQtkAM3By/NQprs
 NhQ8uD9lFUghDAXmx6yBy5ZqLHJ2JzSirk1HLU6l+w==
X-Google-Smtp-Source: ABdhPJxTIXJw2sOCyWu/LB7MGU3LNyZJiDglhmiWJQLJ93KY8n3am/7djp5YyUU+hgPjt8LzRUHfMK2sLY6qa+eqMFE=
X-Received: by 2002:a0c:8c81:: with SMTP id p1mr25091864qvb.7.1633972835174;
 Mon, 11 Oct 2021 10:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210928164237.833132-1-alexander.deucher@amd.com>
 <20210928164237.833132-29-alexander.deucher@amd.com>
In-Reply-To: <20210928164237.833132-29-alexander.deucher@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Mon, 11 Oct 2021 18:20:24 +0100
Message-ID: <CAHbf0-Egsi3MFD2BQyO1f7kFp8eQAH55bGkCvNauCH3KxR+LbQ@mail.gmail.com>
Subject: Re: [PATCH 28/64] drm/amdgpu: drive all navi asics from the IP
 discovery table
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

This patch breaks things for me on my Green Sardine & Navy Flounder
system (Asus ROG G513QY)

It doesn't get past post with amdgpu built in, will try as a module

Cheers

Mike

On Tue, 28 Sept 2021 at 17:44, Alex Deucher <alexander.deucher@amd.com> wro=
te:
>
> Rather than hardcoding based on asic_type, use the IP
> discovery table to configure the driver.
>
> v2: rebase
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5e0956b19d69..9c47cc636429 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2142,26 +2142,6 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>                 if (r)
>                         return r;
>                 break;
> -       case  CHIP_NAVI14:
> -       case  CHIP_NAVI12:
> -       case  CHIP_SIENNA_CICHLID:
> -       case  CHIP_NAVY_FLOUNDER:
> -       case  CHIP_DIMGREY_CAVEFISH:
> -       case  CHIP_BEIGE_GOBY:
> -       case CHIP_VANGOGH:
> -       case CHIP_YELLOW_CARP:
> -       case CHIP_CYAN_SKILLFISH:
> -               if (adev->asic_type =3D=3D CHIP_VANGOGH)
> -                       adev->family =3D AMDGPU_FAMILY_VGH;
> -               else if (adev->asic_type =3D=3D CHIP_YELLOW_CARP)
> -                       adev->family =3D AMDGPU_FAMILY_YC;
> -               else
> -                       adev->family =3D AMDGPU_FAMILY_NV;
> -
> -               r =3D nv_set_ip_blocks(adev);
> -               if (r)
> -                       return r;
> -               break;
>         default:
>                 r =3D amdgpu_discovery_set_ip_blocks(adev);
>                 if (r)
> --
> 2.31.1
>
