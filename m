Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F4C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 21:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB400206E6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 21:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fI8BfHY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB400206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DF96E5C1;
	Thu,  4 Jun 2020 21:00:23 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAA236E5C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 21:00:21 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id d128so7061491wmc.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jun 2020 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n0qs/1kW1C+FyjsgHT5eQmKoYpljZoNDPDwG2z4jBa4=;
 b=fI8BfHY0TiQI9qyY0O8oGW0rSvHqmwYaO7Yc4xOEwkkdu3AxYAKK2NKauILISqrbGC
 fGVAZtkVF5VzE/YBOnzQXzSb2CpAFRaSdVGqtWDyUG9jq7VuEM5J/PHDz5y0WeRVD25f
 jL09EM7wxbDsxN8NL8sLZ7IUX6xz3Rd32yi/LzlthYon0JoSRcTaNwRefCvx2k/ECe3x
 T6tYUQV8/NNt+4NdEdKNtvHmOWz+H2GbcQ7Cn6ybH9J3teB6nHxqnTZGdTFwGKbZKjlV
 AmI7reNakIWoMqtxH6SawSC/ctGt60UrGmTQ+Zijie4cZ9uoXtbp3WyfZEzcYOKLfZXR
 aJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n0qs/1kW1C+FyjsgHT5eQmKoYpljZoNDPDwG2z4jBa4=;
 b=qYqUZdBGd+s3EunZo6jnt9t5xMAhuFUS7F005vLhxzK3keq5CM+FKeEyejgGnFp0Y4
 Z+7D23/6bo9jFZjKP7cy55Bk9WiclYV/W/eOoQDFApMLXFIEDhVvrpct9191Xes8+N+l
 33SfGWHD5qswo+xdG5nEu8vRO8NOTlbimnT/RXahQctptnYVtZgkYjEJQhZDVwZOy7hu
 C44l1+YscbIPIvSaJo3umAz+mRXRmHvV53MVmgR5qNj9Kk8qma3uBI/Z2ezt5crc6Qo4
 F+CZ0Ft7Cid3FsMt33VFg0tyAMHrclthVG8s50v7Cih9kaYH9o4mh8ueeJcRJX/Gn2mj
 9Vbw==
X-Gm-Message-State: AOAM533FRtzwYvZQcvt0eIQXykzXEzx3Tft5+QcBpDl3chRkZCY1CdnP
 LPSwW1ikPNS1WBr2+xxQDDAy9qdPKYa8hgq+BFMvrI8z
X-Google-Smtp-Source: ABdhPJwxju3o+0wsSD2rHMlQcc9GRH1awX2/B9n4dkuh/jspI6yFzOw0mBnpFwKLTgZlngdGN2ynaKLhJa9ykuJXjU8=
X-Received: by 2002:a1c:9c85:: with SMTP id f127mr5828411wme.79.1591304420540; 
 Thu, 04 Jun 2020 14:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200604044619.18658-1-evan.quan@amd.com>
 <20200604044619.18658-10-evan.quan@amd.com>
In-Reply-To: <20200604044619.18658-10-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jun 2020 17:00:09 -0400
Message-ID: <CADnq5_O461g3JWP=HgmBZw3yO9LJe2k3aw0bf1sfkOPMqAVPEA@mail.gmail.com>
Subject: Re: [PATCH 10/16] drm/amd/powerplay: max code sharing between
 .hw_init and .resume
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
> Then redundant code can be dropped.
>
> Change-Id: Icbafbb7ffc8189a09f4236786aea6702ee73f9f4
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Subject could be clarified as:

drm/amd/powerplay: maximize code sharing between .hw_init and .resume

With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 42 ++++++++++------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 3bd6b9a5b63c..4c1f7c36b74b 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1193,10 +1193,28 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
>          * Set PMSTATUSLOG table bo address with SetToolsDramAddr MSG for tools.
>          */
>         ret = smu_set_tool_table_location(smu);
> +       if (ret)
> +               return ret;
>
>         if (!smu_is_dpm_running(smu))
>                 pr_info("dpm has been disabled\n");
>
> +       /*
> +        * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
> +        * pool location.
> +        */
> +       ret = smu_notify_memory_pool_location(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_enable_thermal_alert(smu);
> +       if (ret)
> +               return ret;
> +
> +       ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
> +       if (ret)
> +               return ret;
> +
>         return ret;
>  }
>
> @@ -1276,22 +1294,6 @@ static int smu_hw_init(void *handle)
>         if (ret)
>                 goto failed;
>
> -       /*
> -        * Use msg SetSystemVirtualDramAddr and DramLogSetDramAddr can notify
> -        * pool location.
> -        */
> -       ret = smu_notify_memory_pool_location(smu);
> -       if (ret)
> -               goto failed;
> -
> -       ret = smu_enable_thermal_alert(smu);
> -       if (ret)
> -               goto failed;
> -
> -       ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
> -       if (ret)
> -               goto failed;
> -
>         adev->pm.dpm_enabled = true;
>
>         pr_info("SMU is initialized successfully!\n");
> @@ -1488,14 +1490,6 @@ static int smu_resume(void *handle)
>         if (ret)
>                 goto failed;
>
> -       ret = smu_enable_thermal_alert(smu);
> -       if (ret)
> -               goto failed;
> -
> -       ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
> -       if (ret)
> -               goto failed;
> -
>         if (smu->is_apu)
>                 smu_set_gfx_cgpg(&adev->smu, true);
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
