Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D39AC433E7
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 15:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF80922261
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 15:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugjoCo61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF80922261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EB646ECFB;
	Fri,  9 Oct 2020 15:44:48 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B39B6ECFB
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 15:44:47 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id m6so10802269wrn.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Oct 2020 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TAtM7NIi0630dJFRt43EQwnMz9TZ1gAlyf8yCmx2S5o=;
 b=ugjoCo61F60x81fy0WWrKV9WcuHuh3SObuN3vcScEFwyGoWGru4pJT0cfpQkMzo3hx
 CJEYZD+N9QsU8+NAPvNpeKY7q+frZUKuJiaZemkiA/w0TnmLXDXyf4uLm+9/s/td9hpj
 iD18wfIbkBZN/e1wj3q/uKgrabqOMvSDjqT0HRrvKDvSIJ5dOH72teO0jbYGoU7se0xu
 mB9ZFp7E/6mw4OArOZW/ZbJDQn0zirZv+OUJQkciPceFluXRIZrH3WJWKWQvCkySVDdO
 t3XzeCov+n1hYMEHdX6Mm10LKeieNi5IdU1Yns08OXLDW83fbLu3Uy/el/dTyMWFpYrq
 A6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TAtM7NIi0630dJFRt43EQwnMz9TZ1gAlyf8yCmx2S5o=;
 b=tE5QLOJGY0I8hg0qK2q5CcoBihmm0XnFpB50siIPa69E8wU6dXhWsUvJVNVLhPwhah
 CfZeAa4q8ZJ3r0TW/GfrAgtnQTT7maBNzFldB1mwdbIRjvXgM9Q3nBHHWtFAD89nNX3L
 WhQu/1zPxgvmMYfNv7lQrPzi/18kXUindliynedXBTg4WvFU4LhsqGPCJPOQHHXIyEb4
 wJKGfl4Qi5T4Ock+51MpRFwMaoIwx6QsqK/Qd7IVGn5yw+x5hGO3iXYSI4U1mCa1lWq5
 LiDj8qWX4zdAfGUx2AaqulfI7ntibXmww+6pEZzDEYktjylA2Mxsd6xvgv9icNDSw8Ll
 WwLQ==
X-Gm-Message-State: AOAM530Wx0+doddk6zejQ7eTFAyt9HInslpQX+Yttw7201d9pWlJe9In
 fE2yTF7zV7svfSKjkSuMxUZRswqY/AfZbme4sV4=
X-Google-Smtp-Source: ABdhPJx35VNTtmqz5fIE/9K3XqrhOmKwRGh7i+tZT8HB2Kz74FBsvz2avQRzKtbeWwmuc7p6uYnXfEJuxt3U4ynaSaE=
X-Received: by 2002:adf:dd50:: with SMTP id u16mr16160545wrm.419.1602258285926; 
 Fri, 09 Oct 2020 08:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201009074218.144038-1-yebin10@huawei.com>
In-Reply-To: <20201009074218.144038-1-yebin10@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Oct 2020 11:44:34 -0400
Message-ID: <CADnq5_M8m99NXqvLuxZUKGDK-mUgOCTGBPY3QxxJ+mkhjdun=A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix invalid number of character '{' in
 amdgpu_acpi_init
To: Ye Bin <yebin10@huawei.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 9, 2020 at 8:51 AM Ye Bin <yebin10@huawei.com> wrote:
>
> Fix follow warning:
> Checking drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c...
> [drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:770]: (error) Invalid number
> of character '{' when these macros are defined: ''.
> Checking drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: CONFIG_ACPI...
> [drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:770]: (error) Invalid number
> of character '{' when these macros are defined: 'CONFIG_ACPI'.
> ......
> Checking drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: CONFIG_X86...
> [drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:770]: (error) Invalid number
> of character '{' when these macros are defined: 'CONFIG_X86'.
> Checking drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: _X86_...
> [drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:770]: (error) Invalid number
> of character '{' when these macros are defined: '_X86_'.
> Checking drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: __linux__...
> [drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:770]: (error) Invalid number
> of character '{' when these macros are defined: '__linux__'.
>
> Fixes: 97d798b276e9 ("drm/amdgpu: simplify ATIF backlight handling")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 4a93b880c6bf..165b02e267b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -806,8 +806,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
>         }
>         adev->atif = atif;
>
> -       if (atif->notifications.brightness_change) {
>  #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) || defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
> +       if (atif->notifications.brightness_change) {
>                 if (amdgpu_device_has_dc_support(adev)) {
>  #if defined(CONFIG_DRM_AMD_DC)
>                         struct amdgpu_display_manager *dm = &adev->dm;
> --
> 2.16.2.dirty
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
