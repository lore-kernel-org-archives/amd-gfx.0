Return-Path: <SRS0=mVOi=LU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13325C49EA5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Jun 2021 08:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75A761919
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Jun 2021 08:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75A761919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C34B6EA9F;
	Sat, 26 Jun 2021 08:55:26 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02186E9CA;
 Sat, 26 Jun 2021 08:55:24 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 u8-20020a7bcb080000b02901e44e9caa2aso7268809wmj.4; 
 Sat, 26 Jun 2021 01:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ptTxiGNRR9tLNMxRNvuOfTEawaDh7PBZAwJYDWExn6A=;
 b=WXZPto5hzmyq5c5odNy0McigPUrb1U8D3ElSea0YA6x/fugujmRnICRwcXvzB0modn
 RFnxjMlR5rE8gEr/sN5IsPfVueKZ85sDhJDqHVQdokVO1mBkU5H75gAJjv02f5wgE+hn
 9LbJ/Lux2MkBxb4hmXxfyM2A54N/Inefn2dzazJZSSLXMuZel802aLRLHm61C95k4Knf
 Qzq1O1q8UbX4z+Di3lo98MSoo9TmKjBJp0IDDBkY80mplsdN197X8ah2DRZiZXdVKiON
 Ys/9hFDExx35ZaHsv4nZKEgcmZoYISMbZ7YT3aQ1MdLsDQFfdmlLJG04Z4poXicy4dGf
 XV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ptTxiGNRR9tLNMxRNvuOfTEawaDh7PBZAwJYDWExn6A=;
 b=eGkPQdah5vQVo/0YoK4wwDfuV21Q9/JQS7/vR1XVmRKA6EX+/tULqLKcR+biLMhesh
 JqJp+/heBseeDM9H1rYyGl75RXaNSSZL5R9nWo8ScXgFmp8lCnPcrLwDvtT/GAJnFBZ9
 OnXt+pKH7IqYEBjq9uUAecX7NE/YKow+Zet7E/9DrQf0N/bgmPqY3wyr6TjfAWC1Mkzj
 e0RLfcP0qZ7zUWrFFcHy5iO0IEPbNkbtaVBTXP5mHcWWQxp21doqA8R8MirAtOAyVdW/
 h/wD2GDdOK5qFdMNqb6DTlm+HQheb4rQMcSu3OozhAnrbwLxhTv3jHZsxOwVgvspZy4Q
 rRfg==
X-Gm-Message-State: AOAM5339n6MD/G4uq7Y8G4K0/69P0zfSVGHtzdm1otMM5RDVkZsrD3gX
 jl86u0tpWVmreB3870QMFIM=
X-Google-Smtp-Source: ABdhPJw6/VYXiHMo3tYPsIdCX2Czl9c8v5+Wa4nye0fP9/XfYl++WvluOveXRSNeUl+JlD1lODFXkg==
X-Received: by 2002:a05:600c:2243:: with SMTP id
 a3mr15630087wmm.86.1624697723317; 
 Sat, 26 Jun 2021 01:55:23 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
 by smtp.gmail.com with ESMTPSA id n8sm7967502wrt.95.2021.06.26.01.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Jun 2021 01:55:22 -0700 (PDT)
Date: Sat, 26 Jun 2021 09:55:13 +0100
From: Melissa Wen <melissa.srw@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 24/27] drm/vkms: Don't set struct drm_device.irq_enabled
Message-ID: <20210626085513.akf4cwyqpbchmycf@smtp.gmail.com>
References: <20210625082222.3845-1-tzimmermann@suse.de>
 <20210625082222.3845-25-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210625082222.3845-25-tzimmermann@suse.de>
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
Cc: hamohammed.sa@gmail.com, heiko@sntech.de, emma@anholt.net, airlied@linux.ie,
 nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com, liviu.dudau@arm.com,
 alexandre.torgue@foss.st.com, dri-devel@lists.freedesktop.org,
 michal.simek@xilinx.com, linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, linux@armlinux.org.uk,
 mihail.atanassov@arm.com, festevam@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 jy0922.shim@samsung.com, krzysztof.kozlowski@canonical.com,
 linux-rockchip@lists.infradead.org, linux-mediatek@lists.infradead.org,
 wens@csie.org, jernej.skrabec@gmail.com, jonathanh@nvidia.com,
 xinliang.liu@linaro.org, kong.kongxinwei@hisilicon.com,
 james.qian.wang@arm.com, linux-imx@nxp.com, intel-gfx@lists.freedesktop.org,
 linux-graphics-maintainer@vmware.com, linux-sunxi@lists.linux.dev,
 bskeggs@redhat.com, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
 puck.chen@hisilicon.com, s.hauer@pengutronix.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, inki.dae@samsung.com,
 rodrigosiqueiramelo@gmail.com, john.stultz@linaro.org,
 jani.nikula@linux.intel.com, laurentiu.palcu@oss.nxp.com,
 matthias.bgg@gmail.com, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com,
 amd-gfx@lists.freedesktop.org, hyun.kwon@xilinx.com, tomba@kernel.org,
 jyri.sarha@iki.fi, yannick.fertre@foss.st.com, Xinhui.Pan@amd.com,
 sw0312.kim@samsung.com, hjc@rock-chips.com, christian.koenig@amd.com,
 kyungmin.park@samsung.com, kieran.bingham+renesas@ideasonboard.com,
 philippe.cornu@foss.st.com, daniel@ffwll.ch, alexander.deucher@amd.com,
 tiantao6@hisilicon.com, shawnguo@kernel.org, brian.starkey@arm.com,
 zackr@vmware.com, l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 06/25, Thomas Zimmermann wrote:
> The field drm_device.irq_enabled is only used by legacy drivers
> with userspace modesetting. Don't set it in vkms.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I've also checked here, lgtm.

Reviewed-by: Melissa Wen <melissa.srw@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 027ffe759440..496de38ad983 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -163,8 +163,6 @@ static int vkms_create(struct vkms_config *config)
>  		goto out_devres;
>  	}
>  
> -	vkms_device->drm.irq_enabled = true;
> -
>  	ret = drm_vblank_init(&vkms_device->drm, 1);
>  	if (ret) {
>  		DRM_ERROR("Failed to vblank\n");
> -- 
> 2.32.0
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
