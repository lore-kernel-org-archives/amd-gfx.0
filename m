Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B425AC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 21:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F612067B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 21:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsONMRMp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F612067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2826E6E5C8;
	Thu,  4 Jun 2020 21:10:19 +0000 (UTC)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4395E6E7D2
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 21:10:18 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id t18so7619128wru.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E7SozsNJPnKtCb+Xa6Syg2XbUTqldO3iC3sAMlrmsXk=;
 b=PsONMRMpvv9jknreh79HF7rvwQ52Mjdg//iVLzEHUshSzshuIDx5uklnTeDjSPwH0G
 zJ75l3H7Py/Yt3bDWmaAgFx26/ZQXHknuXr/I6Jrlb5GRPxmDaaG8IEm4prNPDDitL9H
 vasuSI2b29o/wbF55AuJUWUSZhU1I7xGfzyelJ6vDYSOT/rzm53hvbDAIVWToMbiTW2F
 2/MmowBeLcSJTpYtz6GAUziU8hxHG/pO7mqV8j+4eek7XwEYIwRGgW/TrCwY4cTjmla3
 ruUqlEHMSR3of6s980er0x05xRCdxQxaZzJ9ONoLStkxsBejELcwTvaLN9PSaggttPXc
 Y3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E7SozsNJPnKtCb+Xa6Syg2XbUTqldO3iC3sAMlrmsXk=;
 b=d8MXhY3iVebVlCSd/hB6qhDdFzwExcT3AgoYK5AlzAIEvf1eyVyDJo2OGUBX3uq3ET
 yj0Bf7GH94dTJHkUKNgTvMCNr84mWdyHpotz+uZyVKyDXmnHMyxXQbfZ+9i0ngx/ayS/
 KZmZLkJ7GYYJXEWvMgcXUS5t1qDgnnXdySe7lTDiQoDJ27kEGELVUBIOLqih46Qdsffg
 GlbXbPeIGs17NOU1zcx5qoX2NC5DUTLUtRAhte3PO6Zv+27K0qSUiFhrKUWJBd23mwz8
 CHnHvQyva7DufAmqqWQR9kU0zm4M5CaRj+6j8r17YzoaEAZ3eUnqmKCPK7XPZH34ubMf
 QPDQ==
X-Gm-Message-State: AOAM531Upa42jLq+XV+6YF4RG0DckKZ4zq7JeQB1nzzzKUyVdWuvppLM
 OGovnvr1CtTlDtmT19AOcEQHMaF3iOkjHeLhwT4=
X-Google-Smtp-Source: ABdhPJxiW0qgmO+WGC/jZ06RXHM0wZ/yX9qbnkRHiH89CMHBGE5+QhGGy13PhUX9KMjrIrCP9FH53EERmti85Jl0yzA=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr6086483wrq.362.1591304924905; 
 Thu, 04 Jun 2020 14:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200604044619.18658-1-evan.quan@amd.com>
 <20200604044619.18658-13-evan.quan@amd.com>
In-Reply-To: <20200604044619.18658-13-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 17:08:34 -0400
Message-ID: <CADnq5_NDZ1iwOrkuqJuFs9ve5cnZqBgSGLdbB1-1Fmv6sxkCPw@mail.gmail.com>
Subject: Re: [PATCH 13/16] drm/amd/powerplay: max code sharing between
 .hw_fini and .suspend
To: Evan Quan <evan.quan@amd.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 4, 2020 at 12:47 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Thus redundant code can be dropped.
>
> Change-Id: I672f84ed5856da53b7f8f915b2f24ca11cd4b228
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Clarify subject:

drm/amd/powerplay: maximize code sharing between .hw_fini and .suspend

With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 44 +++++++++++-----------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 55ffbf1cf086..65f5edcaa405 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1376,6 +1376,26 @@ static int smu_disable_dpms(struct smu_context *smu)
>         return ret;
>  }
>
> +static int smu_internal_hw_cleanup(struct smu_context *smu)
> +{
> +       struct amdgpu_device *adev = smu->adev;
> +       int ret = 0;
> +
> +       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
> +
> +       ret = smu_disable_thermal_alert(smu);
> +       if (ret) {
> +               pr_warn("Fail to stop thermal control!\n");
> +               return ret;
> +       }
> +
> +       ret = smu_disable_dpms(smu);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
>  static int smu_hw_fini(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -1396,19 +1416,9 @@ static int smu_hw_fini(void *handle)
>
>         adev->pm.dpm_enabled = false;
>
> -       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
> -
> -       ret = smu_disable_thermal_alert(smu);
> -       if (ret) {
> -               pr_warn("Fail to stop thermal control!\n");
> -               return ret;
> -       }
> -
> -       ret = smu_disable_dpms(smu);
> -       if (ret) {
> -               pr_warn("Fail to stop Dpms!\n");
> +       ret = smu_internal_hw_cleanup(smu);
> +       if (ret)
>                 return ret;
> -       }
>
>         return 0;
>  }
> @@ -1445,15 +1455,7 @@ static int smu_suspend(void *handle)
>
>         adev->pm.dpm_enabled = false;
>
> -       smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
> -
> -       ret = smu_disable_thermal_alert(smu);
> -       if (ret) {
> -               pr_warn("Fail to stop thermal control!\n");
> -               return ret;
> -       }
> -
> -       ret = smu_disable_dpms(smu);
> +       ret = smu_internal_hw_cleanup(smu);
>         if (ret)
>                 return ret;
>
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
