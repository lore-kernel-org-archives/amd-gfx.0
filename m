Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE62DC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 03:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7852B64EEE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 03:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7852B64EEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C8C6E46B;
	Thu,  4 Mar 2021 03:57:59 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71DC6E46B
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 03:57:58 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id x20so28605494oie.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Mar 2021 19:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ke9YY1BpVPd1/EmGQRtGP0QcRUfJ/7BhF610iGBD9Hg=;
 b=t+wu08UZ24mQu9ogGwv5V80eAwcQYKz71mAlAZR9IjnJsDdvYjzCvuisu79glZwjoT
 Xc9GZYQ6o7j3fm9CoCQMuT5e5k0SYkPNMZ7zIFuVZ20Uy8U2yJmEPZhxxZGZbUzhUKC0
 B0tw5Z5tEykQWqvNleIqkdH8WHRbyywQuaV8Ar64/XZ5ZZzhUrunEhQr6PSxxK2EzzZ0
 I58yXxcsnirAypB1q4EbAyB0ATjC0oXp5fIhW5KuUGuX/Gv5w7FBmLqW4+IZIAKHNVdA
 TWc6i3v25Zo+lVenz5L80cuVcloT9J3x/qefVjm+GVhPP9Knvopm0N6a5KWf8KB3NyfP
 AFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ke9YY1BpVPd1/EmGQRtGP0QcRUfJ/7BhF610iGBD9Hg=;
 b=eQHKhlLYe4greJpSfGvYR1plqOXYLO+hA+Pn8MUOMiEqYFwlq1PE19/XMx+YwFTzzT
 kW4kU84hly6xuOYAXkXi3FN0GMfuJ2FRWgO4IQ0fRfoqh93WsbBV870uiGAsZApveu+d
 4A/+Wn/MwDX9/ZRAar465FGPXB7/qCDg84Wp/GQG5Q50v08I/2fTfDI4v9PQ6+OfezbG
 wh2blRm85Q6oolIwC5qUJxDK1WvIMokY1elgIXo6g7+skbupeEN2GyXEyoQPlysxmBPe
 En1U2wd8esW1GJzOx5wQay/ciqFBTXv4hzLaNs88+r7UCisePcnoQ+1xxB+i9udIzpd7
 gsSw==
X-Gm-Message-State: AOAM531LCoc2f6DtIos62RzzUX9DDChVZWRDNIhc1q3WBptt2E3mENTP
 NIcW9Bvo3UDPbrBpoV5mAg3GqQzWGLYfOEeOmko=
X-Google-Smtp-Source: ABdhPJzKB5kQQeb6gTMSvyrsRW+EYP/LMk6pQngxeC8DGRDC2pcv6lFIoDSf8y2y420N/2g4bIvGmulElLEHH8TjAK0=
X-Received: by 2002:a05:6808:f15:: with SMTP id
 m21mr1592296oiw.123.1614830278034; 
 Wed, 03 Mar 2021 19:57:58 -0800 (PST)
MIME-Version: 1.0
References: <20210304034644.37610-1-Feifei.Xu@amd.com>
In-Reply-To: <20210304034644.37610-1-Feifei.Xu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Mar 2021 22:57:47 -0500
Message-ID: <CADnq5_PaR5pwTHFoOO_2-wKjWPLX=+LS0z34ns3axA1ZP2RUFw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: soc15 pcie gen4 support
To: Feifei Xu <Feifei.Xu@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 3, 2021 at 10:46 PM Feifei Xu <Feifei.Xu@amd.com> wrote:
>
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 28b991904eaa..437cdc56bdc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -569,7 +569,7 @@ static int soc15_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk
>         return 0;
>  }
>
> -static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
> +static void soc15_pcie_gen4_enable(struct amdgpu_device *adev)
>  {
>         if (pci_is_root_bus(adev->pdev->bus))
>                 return;
> @@ -581,7 +581,8 @@ static void soc15_pcie_gen3_enable(struct amdgpu_device *adev)
>                 return;
>
>         if (!(adev->pm.pcie_gen_mask & (CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2 |
> -                                       CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)))
> +                                       CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3 |
> +                                       CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)))
>                 return;
>
>         /* todo */
> @@ -1374,8 +1375,8 @@ static int soc15_common_hw_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       /* enable pcie gen2/3 link */
> -       soc15_pcie_gen3_enable(adev);
> +       /* enable pcie gen2/3/4 link */
> +       soc15_pcie_gen4_enable(adev);
>         /* enable aspm */
>         soc15_program_aspm(adev);
>         /* setup nbio registers */
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
