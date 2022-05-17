Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F75AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 20:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F5511274B;
	Tue, 17 May 2022 20:54:24 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E9A11274B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 20:54:23 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id v65so284172oig.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 13:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=esDt/ygm4WEDZW7NMBdetNiik4xOkEth8NzDieBlCmM=;
 b=gKPmFVts67I2YaFCueBVBPv+QGDtrzBVPTDht4HFOb5YFVrVAJavab1X62rwiHplrN
 VncmnllGh57N9jrTzqfTqGc5yIPFpxPnljl/ZjIipTZTdtqC6C8zpFQf2s/qjCk33CJh
 8k12YFzRsrSu6fZp+UzNMxc9epUCkGnAnpBfTrytYfRjNFrn2EIHyS7UU++CwnQR70OU
 sM7VXfNgZZqhxwygU9E0tuwvWtOec/6A9sb7cgHCJaEOhxl/SScAbGLsrSIebHComKlX
 lnRhLgoCnY+rfY3t9H2mEbFQWJc1L0KeLSTYt9Kho1f4lacmL2xHeR2LD7E3OuxKacqq
 A2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=esDt/ygm4WEDZW7NMBdetNiik4xOkEth8NzDieBlCmM=;
 b=TJGLaC2T0FeSiV+ZGcGnrs3LgZxPlX5DDMXflpXi062VNiKf8UJZSOlTyr1zLFH+Bd
 IVaYfo+CfbUcakIA4Z8EDutLkNNpTdpEy7VFRxlE+DHqnUQUrIW0As/KoeJ5tTb3QXlQ
 bthz5ZItPE2LrfvbuT+mogHdtXK5DM0w1GR0X65Rl0WuLVS3JKf9f9edHHExtx5yiwRO
 bU/48ZqVoEbrvZdRIeKggGWKrlKyRd5a2Gcsgp/9iYh59a41ZwYs3hMBcMlTy48tXdiU
 AIRM5f2Jq2CUzNnUstYA88SRTouEEAcXpGrQFxctUlQG4gXp1HOqqcfUBRS45AnI9s7r
 ZLDQ==
X-Gm-Message-State: AOAM5332Ifk+rBzKIS2m+gYHIPblOMFjekxTZPHcTaT5Ubn9vNFsKfpF
 fA4x0v6v6MQMiw4bPC8pcfy6uUZxkIJ/wrZBdMk=
X-Google-Smtp-Source: ABdhPJw5kDEeaiSUetF9RsHYAT9bdeIQ0xtHtRebB/nPLWv2c7rooin4F070ALFh4+gFNaanpLJlsuw6NgGTUnO/ZC4=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr12159725oiw.253.1652820862717; Tue, 17
 May 2022 13:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220517095700.7291-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20220517095700.7291-1-ruc_gongyuanjun@163.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 May 2022 16:54:11 -0400
Message-ID: <CADnq5_MM7pV-yXRdqRsqoWOugOF8SjXgvksXWoot5W+VkLeAGw@mail.gmail.com>
Subject: Re: [PATCH 1/1] radeon: fix a possible null pointer dereference
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, May 17, 2022 at 9:13 AM Yuanjun Gong <ruc_gongyuanjun@163.com> wrote:
>
> From: Gong Yuanjun <ruc_gongyuanjun@163.com>
>
> In radeon_fp_native_mode(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a NULL pointer dereference
> on failure of drm_mode_duplicate(). Add a check to avoid npd.
>
> The failure status of drm_cvt_mode() on the other path is checked too.
>
> Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> index 0cb1345c6ba4..fabe4f4ca124 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -473,6 +473,8 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
>             native_mode->vdisplay != 0 &&
>             native_mode->clock != 0) {
>                 mode = drm_mode_duplicate(dev, native_mode);
> +               if (!mode)
> +                       return NULL;
>                 mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
>                 drm_mode_set_name(mode);
>
> @@ -487,6 +489,8 @@ static struct drm_display_mode *radeon_fp_native_mode(struct drm_encoder *encode
>                  * simpler.
>                  */
>                 mode = drm_cvt_mode(dev, native_mode->hdisplay, native_mode->vdisplay, 60, true, false, false);
> +               if (!mode)
> +                       return NULL;
>                 mode->type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER;
>                 DRM_DEBUG_KMS("Adding cvt approximation of native panel mode %s\n", mode->name);
>         }
> --
> 2.17.1
>
