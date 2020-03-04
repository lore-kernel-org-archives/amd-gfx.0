Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D71C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 21:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290EB20732
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 21:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5e0TyH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290EB20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462316E102;
	Wed,  4 Mar 2020 21:55:05 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA346E102
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 21:55:03 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id j7so4395398wrp.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2020 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NWvNRXWON5L4OYS7Yhhu6uvHHxPsdAd1ZM67EDX67zw=;
 b=k5e0TyH0GqBUBdTIerg4/jnqJs88ckrTt26BijjLZjzOf7tDSkBBWGMYInP5QrJiv2
 Gj/pHIJpTj+scL9YcWTyshuQr4GQt8QpQcvTpSvxbDTYE8wqW70rxEnV8JqaPDkNGobY
 qfkNjfDsQkQ25zpZ0d/A+Q0Zyvh/Vg/FP7skk8HX7uJPtv6qgJAkGYceNu0/AeUR0avv
 4Z6devxfmC1R2dpzGewI74Cce3M4nNv5T0XRoFrHi7RTfuT8VzSfFWs3FfGIY47jHxjm
 h8l4mlF/6COuo1eNKYjCTH7oJ0y9dEJ9Bu+lmjU3BVzbwUHVGFC5uh6qugc2XvR/OC7L
 3C7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NWvNRXWON5L4OYS7Yhhu6uvHHxPsdAd1ZM67EDX67zw=;
 b=OckUfHw1stRMKis3WId8CSqIW6D6jZsm2i5QODN4UbwDi1GWUYzMh3HBP86X7QVzAs
 I1KNJ1SVfPTz+HO2yEMwxbi3acM2ozxsfMyX0FlTen/9RUjKbHRE3R4lOW8M/1PzeE3n
 qoFF/pQkuuHpUqFAk/rXuuS1f1jaUYjMmb8hevbaI0VJzB1lGGj5ugwlIANGB9Ameolv
 YxZNo5Zkvf4PWAAzHPA/6WsHw/yB7pf9ecd3/7oXBkMnKweqawGaOKnDd+asWTxI0kGm
 i/DMPUcfY0Fl/ksOC0gKSashxVzp9tMBP0vHjnBtUPpDx/LuhMw1m07zpBva4TSvpvmY
 65ww==
X-Gm-Message-State: ANhLgQ0qzVbR0ahw8VOKqnijRZ9AXooMsKXHVKnmgzB7gVD4zXdxq2E5
 SuJqMj4EIHyhyxjiLuWzFo/fB0AnaniMUOSqukL40w==
X-Google-Smtp-Source: ADFU+vvYfPy3kFxCgYRLSqBwGKjh+FL74vQB0KwJHE05pLpXKTupWbyLYD+ndUlB1qq4LnSH8S3m9lHogwINxoTAEjI=
X-Received: by 2002:a5d:5012:: with SMTP id e18mr6313875wrt.419.1583358902082; 
 Wed, 04 Mar 2020 13:55:02 -0800 (PST)
MIME-Version: 1.0
References: <1583358316-2388-1-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1583358316-2388-1-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Mar 2020 16:54:50 -0500
Message-ID: <CADnq5_Puva915Qj7E-WAFENG7A029faOawSqT7JOj+ew0Hnrbw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix GPU reset error.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 4, 2020 at 4:45 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Problem:
> During GU reset PSP's sysfs was being wrongly reinitialized
> during call to amdgpu_device_ip_late_init which was failing
> with duplicate error.
> Fix:
> Move psp_sysfs_init to psp_sw_init to avoid this. Add guards
> in sysfs file's read and write hooks agains premature call
> if PSP is not finished initialization.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 3836acc..6d9b05e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -117,16 +117,6 @@ static int psp_early_init(void *handle)
>         return 0;
>  }
>
> -static int psp_late_init(void *handle)
> -{
> -       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -       if (adev->asic_type == CHIP_NAVI10)
> -               return psp_sysfs_init(adev);
> -
> -       return 0;
> -}
> -
>  static int psp_sw_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -150,6 +140,13 @@ static int psp_sw_init(void *handle)
>                 return ret;
>         }
>
> +       if (adev->asic_type == CHIP_NAVI10) {
> +               ret= psp_sysfs_init(adev);
> +               if (ret) {
> +                       return ret;
> +               }
> +       }
> +
>         return 0;
>  }
>
> @@ -1843,6 +1840,11 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
>         uint32_t fw_ver;
>         int ret;
>
> +       if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
> +               DRM_INFO("PSP block is not ready yet.");
> +               return -EBUSY;
> +       }
> +
>         mutex_lock(&adev->psp.mutex);
>         ret = psp_read_usbc_pd_fw(&adev->psp, &fw_ver);
>         mutex_unlock(&adev->psp.mutex);
> @@ -1868,6 +1870,10 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
>         char fw_name[100];
>         const struct firmware *usbc_pd_fw;
>
> +       if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
> +               DRM_INFO("PSP block is not ready yet.");
> +               return -EBUSY;
> +       }
>
>         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s", buf);
>         ret = request_firmware(&usbc_pd_fw, fw_name, adev->dev);
> @@ -1919,7 +1925,7 @@ static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
>  const struct amd_ip_funcs psp_ip_funcs = {
>         .name = "psp",
>         .early_init = psp_early_init,
> -       .late_init = psp_late_init,
> +       .late_init = NULL,
>         .sw_init = psp_sw_init,
>         .sw_fini = psp_sw_fini,
>         .hw_init = psp_hw_init,
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
