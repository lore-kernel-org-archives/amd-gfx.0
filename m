Return-Path: <SRS0=Av9g=OK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3CAC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 16:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4A060F23
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Sep 2021 16:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A4A060F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02CC6E532;
	Mon, 20 Sep 2021 16:12:23 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C0156E532
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Sep 2021 16:12:22 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 c42-20020a05683034aa00b0051f4b99c40cso24325572otu.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Sep 2021 09:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dOnLUIHN6VLJNP81unz3NTIonU8/6BBunqwe36vkiSE=;
 b=NQ/8drWoCL+j7z2czJUuQnWbQ7k+yMgFz3ZEtUXqNY4xpyKtJ1AiqY3LhErqe/GbGW
 zyDHy/eJSqr1SQzmVqmUumb8RIg18e6oJMyJInIGDvABUV5Q2RkwxscKoXDTQ6pPa9zx
 aMHraNmcA8VuIjyl/dLfkqUOhDTImwqVk6Osmmu1HOaelVQcuSevw1vqmUER6aPDJNiu
 X20FLuplCwdQljzq+DgfLCiXtO+XSPdQlLH1efx8mdgP3tBGNZxs08F1yIo6H6PDN8Tn
 rtNXao4B9ExIO243CHAh3BrjHXJM2uwPGiajZliThSlJtMXHRmHCskGDXqU8bOxEyRCh
 j6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dOnLUIHN6VLJNP81unz3NTIonU8/6BBunqwe36vkiSE=;
 b=DskXXmIhzCFiGPZ67xV9aIQ4xkrbTg2qcI0YP2Ak4e6TP50tRdXUTBKmxuQtn5wboa
 Lx33F9ROXVEl8UKxyFIzJqpsUbrkVzVvxMJlRTUyt/2o484nIE4M35sn0dNiS3aZyF27
 UlvWUW80on/GLyIFFi101uyAep4rgmqj56saufPvLmlakhvDMGHSUIRCYgfbPDoV+7IT
 QNHo1V9z9uhnf4QjjyRsf2ZlQ+a3fEjSsl8aKgmCY5EbUVtuBDo6WTPu9BN7zxre6Veq
 APiLA/BUrE4CWhEhQi8MzuQkUDjV4LuairVB0g0hddhjPjDbH7yneh5/nwpiqKttbMCw
 jdfw==
X-Gm-Message-State: AOAM533xh17h5U1w8ucK6SG4SyLIrEVOn07HAJIsayS+eKGNa2LOOsfP
 VvwajbiC7cLMl3o0eRuVJUBaqF0yYz+buzt5Qf8=
X-Google-Smtp-Source: ABdhPJzuLdo5T5sGyAs/+bqfwClgtMfuAA34ANliaQFrA6rtWJ7F62CQPDJUx2xyjWuJgRGVNyPsdZc6fX4m+YTEVYM=
X-Received: by 2002:a05:6830:25d3:: with SMTP id
 d19mr22338664otu.357.1632154341615; 
 Mon, 20 Sep 2021 09:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210917113045.22194-1-andrey.grodzovsky@amd.com>
 <20210917113045.22194-2-andrey.grodzovsky@amd.com>
In-Reply-To: <20210917113045.22194-2-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Sep 2021 12:12:10 -0400
Message-ID: <CADnq5_P+Jd1FjfbbgiAnL=eY-LCf0zeJS0PAUjiNCpN1SRazVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix resume failures when device is gone
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Sep 17, 2021 at 7:31 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Problem:
> When device goes into suspend and unplugged during it
> then all HW programming during resume fails leading
> to a bad SW during pci remove handling which follows.
> Because device is first resumed and only later removed
> we cannot rely on drm_dev_enter/exit here.
>
> Fix:
> Use a flag we use for PCIe error recovery to avoid
> accessing registres. This allows to successfully complete
> pm resume sequence and finish pci remove.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index db21af5e84ed..04fb4e74fb20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1522,6 +1522,10 @@ static int amdgpu_pmops_resume(struct device *dev)
>         struct amdgpu_device *adev = drm_to_adev(drm_dev);
>         int r;
>
> +       /* Avoids registers access if device is physically gone */
> +       if (!pci_device_is_present(adev->pdev))
> +               adev->no_hw_access = true;
> +
>         r = amdgpu_device_resume(drm_dev, true);
>         if (amdgpu_acpi_is_s0ix_active(adev))
>                 adev->in_s0ix = false;
> --
> 2.25.1
>
