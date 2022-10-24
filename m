Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3842C67871
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 20:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E1E010E7A4;
	Mon, 24 Oct 2022 20:06:43 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CCB10E7A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 20:06:38 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-12c8312131fso13147547fac.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GOr+snYoajAsyedFUaWI4eqDrg7ZclZ5KAEVk5VLW64=;
 b=Hbtrcn2YZ2umTwD4NxLCMxbdGPQrUbjZn39Dyw4gcYwY1QSilFlNzw64qrZdeaQDqf
 XEmcFVANWBuh2N0DXJDMvzSLvycpZL990i+/YkYVWMl7kRzBMl7a0U3eic1sOiLRFgyd
 09HgAomr8mHtYaDHkK/Nq3flW22TJoGmBgE0+jfoz1qFXYwr8OKgoWFpkhJxixo9Lg3J
 HP0kie+Wb1K8wLR1g++xDwfNmO32u5HunkPVFNscvhDgmTyTGuO888T5fwFIRbGLguJv
 QPxFqDn5O8xzR1TkovJraZmMbYWIhqkeHkxYvd/WbueM90YGYJVxy06elNDIxOQGYVSr
 vkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GOr+snYoajAsyedFUaWI4eqDrg7ZclZ5KAEVk5VLW64=;
 b=oKaxEIXKKoH6cHU/sjnGDdnl+ipyhOx62ExZPwR0QAil+eO5rGaBQYfYZbX44jrfVE
 Ev8ZTYorvZZi9KhQN6b8PRzsWcnSWZ52fXX+/Wv5j8bzs10uLdyjhpbuiWCHsC5IT2g4
 5rKOsV8Yue9Ek4OElmiF/HS34NKfsEGuCU5V5IrqtnrcolfCaACNOewMqxQ66ge6xNZ9
 vvvymVjmIm/Oqm4XcBd8IeEyfs3j7bEJbTXu6YiGKnuwPu0tM/1QHotSkrCt4KZAqwke
 Q3kCdEb2GSoyboWKiSbnC876RKT/YJcqFnHqDjjXPlRLnnbwvhHcH25l9NG4bX2MWX2M
 5ghQ==
X-Gm-Message-State: ACrzQf0K7rpFTPRzWKijzMn201i1lj+UvKSRaDk2/U7pd0JEmVA+SY5n
 OEVQQjPhCReL/1YqawYKKb3pfy2yK/OUt9tsC/UwtNztUB8=
X-Google-Smtp-Source: AMsMyM58PVEGG406eUS5xnIUA5cicfOejUC+kuA4RikiFYDMKtgZpNnG9YfjlzSRmpqOIcx7Ir3/KiACrHMUPGmkQq4=
X-Received: by 2002:a05:6870:a116:b0:13a:f9de:6fd0 with SMTP id
 m22-20020a056870a11600b0013af9de6fd0mr14392636oae.46.1666641997886; Mon, 24
 Oct 2022 13:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20221024200301.7641-1-Gavin.Wan@amd.com>
In-Reply-To: <20221024200301.7641-1-Gavin.Wan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Oct 2022 16:06:26 -0400
Message-ID: <CADnq5_N1BQD+RsEj0LhcHv_SPr5YMve-3Vgb6vw+XgFQq=E5-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Disable GPU reset on SRIOV before remove pci.
To: Gavin Wan <Gavin.Wan@amd.com>
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

On Mon, Oct 24, 2022 at 4:03 PM Gavin Wan <Gavin.Wan@amd.com> wrote:
>
>   Fixes: f5c7e7797060 ("drm/amdgpu: Adjust removal control flow
>          for smu v13_0_2")
>
>   The change of the commit f5c7e7797060 ("Adjust removal control
>   flow for smu v13_0_2") brought a bug on SRIOV envrionment. It
>   caused unloading amdgpu failed on Guest VM. The reason is that
>   the VF FLR was requested while unloading amdgpu driver, but the
>   VF FLR of SRIOV sequence is wrong while removing PCI device.

Please move the Fixes line down below the patch description and above
the Signed-off-by/Reviewed-by/Acked-by/etc. tags.  Feel free to
add:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Thanks,

Alex

>
> Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
> Change-Id: I1ff8dcbffd85d7f3d8267d660fd8292423d2f70f
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 16f6a313335e..ab0c856c13b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2187,7 +2187,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>                 pm_runtime_forbid(dev->dev);
>         }
>
> -       if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) {
> +       if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 2)) &&
> +                       !amdgpu_sriov_vf(adev)) {
>                 bool need_to_reset_gpu = false;
>
>                 if (adev->gmc.xgmi.num_physical_nodes > 1) {
> --
> 2.34.1
>
