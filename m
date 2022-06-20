Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F33DC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 13:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC86510E1AD;
	Mon, 20 Jun 2022 13:44:32 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4F610E1AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 13:44:31 +0000 (UTC)
Received: by mail-yb1-xb33.google.com with SMTP id x38so19031884ybd.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lvPVnt4us2cMDh7yrq2s/+TI36p7XGmX7bIU0Zr9pqs=;
 b=ETtDFpmm2AyWAunUEJEkEC8Hsur02sZJ5M0WuipJhhVugsYIEOkNyXTf5VqUjHKIJ3
 HYTwPceK7B+oMLi4CsmgJR6PoeEt0DHxlxPfVnub/XhlQu1p+l7R3z07NA/0+iGirUPA
 iVDLqzyD2ITYMjyCYSFogt8/aGiMcTxK2P+Jv1RyeO7cw90UEdbFEaeqI3O9mk6FIrp2
 OLIhlXrepqlyYBBJs1iN3vGwqOfZLY/vt2S1jIyLrT6XFKtH+WlrpmA6JhxneKP7ECcx
 mI5h43ocQxBWBuk+oayqG5556YrNxGk5KyG0U7BAUKah8ptmwJhKtyxLCmUxHEkl0MlY
 XRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lvPVnt4us2cMDh7yrq2s/+TI36p7XGmX7bIU0Zr9pqs=;
 b=0sjhNVzwuP4izpDl2jDpsNQ5inx8S3zuO/M2dnGr1Qmc5PQOJ5Z6XHUMLv1B+NzQlW
 R1JOIfVouYWREIfl6akzCNvZZKNiCpNJa0MnE4gDgCxnnbaYKfn5HLh56vYh9l5Os2xs
 MokPOIXOwxn6fbt6tH3gxcloU525i3Nh4pNKtHc8jQGhVsjk+lbjtpKbHRDjZLK5pw5f
 VWHI8IAWBbdFnySi2EBndUF6ZN4gMI28Q3JxXPxJ59DK1FO7At8OCXcu1vJTM0DY35HB
 dqJWwPgS4qmaT32UUN9h+jZworpX59P33d3zJ7JNKqOfYqURZPvf2H8edmB54SNrgavM
 FFWw==
X-Gm-Message-State: AJIora8sDsBse93Qr6aeDTUMSqZ8a+zg8kWzK8jMBAdb3aIh9x8byrvd
 fVZfCgPPUsx64OluNVYBQkgdHrbc2bwGF/0JmQI=
X-Google-Smtp-Source: AGRyM1tvskli6SgsLqWKitDR/YTSxNtFqEJtGqSfOeviDZ+XtkmDFsDFZdLoSIe/9iSjk0jbBUK9+7IsF+gjzFeqQS0=
X-Received: by 2002:a25:7497:0:b0:668:fc45:30c5 with SMTP id
 p145-20020a257497000000b00668fc4530c5mr7530391ybc.373.1655732670974; Mon, 20
 Jun 2022 06:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220620113934.2967402-1-yifan1.zhang@amd.com>
In-Reply-To: <20220620113934.2967402-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Jun 2022 09:44:20 -0400
Message-ID: <CADnq5_Mdi9-KtLAgCoCqp+77djGUb-YOB56iqa3Y5aiFLMHg8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add LSDMA block for LSDMA v6.0.1
To: Yifan Zhang <yifan1.zhang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Tim Huang <Tim.Huang@amd.com>, Huang Rui <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 20, 2022 at 7:45 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> This patch adds LSDMA ip block for LSDMA v6.0.1.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 11bbd76c581c..37234c2998d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2333,6 +2333,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>
>         switch (adev->ip_versions[LSDMA_HWIP][0]) {
>         case IP_VERSION(6, 0, 0):
> +       case IP_VERSION(6, 0, 1):
>         case IP_VERSION(6, 0, 2):
>                 adev->lsdma.funcs = &lsdma_v6_0_funcs;
>                 break;
> --
> 2.35.1
>
