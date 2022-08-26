Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8331DECAAA3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 20:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C054810E307;
	Fri, 26 Aug 2022 20:36:41 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0FA10E307
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 20:36:37 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-11c59785966so3488027fac.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=5ocdN4rDNliRl7R0SUF+YI+G9fdQOl1blTCcUZ2UE6s=;
 b=asist5RK9a88FfFV8a4b6WrBKHRqiHPBb6xNbXs5pB98wiv2lzvgn2j8BpLK2kXuke
 2HWwqjsipa2D5uyYJOQSO8gDSAZOHaov3pMy/1sYtmz41SPA5qLu3gNkzYpwCqkuv2CA
 VfABFLYknPfqtK23qMeARzto82o6ApeMfGawwZkr2+4qP6ulB9GKJXmezZ+cXuX0RoBN
 fTrbkGgi/PhKRYkNgQJmivnBtoE/imPlfz7hV6nS7comWfiSCJj6aKFxOnNEpgwQ5PGt
 3JsEkqdEwH1d33W2JJzJwPUw0z6eYF2v7bzqzvewWB4CoP9KwAKmxbLJbz34ZKCdXd/x
 ODjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=5ocdN4rDNliRl7R0SUF+YI+G9fdQOl1blTCcUZ2UE6s=;
 b=cMyldntJPhDTX4OxxIMUTcriNnzJIbb48AmJcENkSwfhWm73HXHYEjs8Si6FBAb/63
 EAp8DSPVB7bay6UXR1POC/ecLOpakQKD1FzMfNPHIEfKUNA+sng4DTfdM9sjgmQeeNzN
 baVykTzQ7/lWJ2LLTNjlZgAtthO2EplxbXE202usZsF1KJPH18IV1vxwBG10o3GfJIHu
 ///7/965ZMwpPNd+iRe6dMDpcbo99GWb8Kyb/ybzyZygEygXRD1ZN8MWZxWN5h7jVrVY
 fWn7BDcdAVbhwPUnAVKsBCz8agv68rtaWQJUifCk2c+w0OxxvMvXyVRiPMlEoX8Kto1t
 VZgw==
X-Gm-Message-State: ACgBeo2yrBb1HgAWyQbiSp4nO2CSBWMr0zhZpDFS5NP58g/V1NZq6l8B
 9sNndpCJkkSkYAPVQCQwNULfPVDPYydnwcIwHXU=
X-Google-Smtp-Source: AA6agR7u0YofiK4Rgp95+fM+aWoV1gshi+h27Y/db9Hz4g2amJl+0f/2O/x7DRHsam6R0comsrYczKdwJ7U2T2oJ9K0=
X-Received: by 2002:a05:6870:9a06:b0:11e:3d19:2614 with SMTP id
 fo6-20020a0568709a0600b0011e3d192614mr2727707oab.96.1661546196306; Fri, 26
 Aug 2022 13:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220826154752.10984-1-alex.sierra@amd.com>
In-Reply-To: <20220826154752.10984-1-alex.sierra@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Aug 2022 16:36:25 -0400
Message-ID: <CADnq5_MOnxEG2nmV26doP=RE_io_1MigxQTdNNSCN+y4Gwi25g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: ensure no PCIe peer access for CPU XGMI
 iolinks
To: Alex Sierra <alex.sierra@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 26, 2022 at 11:48 AM Alex Sierra <alex.sierra@amd.com> wrote:
>
> [Why] Devices with CPU XGMI iolink do not support PCIe peer access.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ce7d117efdb5..1ff66718639d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5538,7 +5538,8 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>         return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
>                 adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
>                 !(adev->gmc.aper_base & address_mask ||
> -                 aper_limit & address_mask));
> +                 aper_limit & address_mask) &&
> +               !adev->gmc.xgmi.connected_to_cpu);
>  #else
>         return false;
>  #endif
> --
> 2.32.0
>
