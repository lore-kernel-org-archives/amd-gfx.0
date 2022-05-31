Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C17C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 21:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D62510E165;
	Tue, 31 May 2022 21:14:02 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E20310E165
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 21:14:00 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-f2a4c51c45so66141fac.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/VEcJKE0VqG4mGPPKnuNc++39dwURobverBWENyZHGQ=;
 b=fJWYwsBsL5LZbbAvLRmn54C/929boKjhvuAjq4Qy9O0XbdZzXM8fzs538BFCwKr8b/
 iZFxZ9t57lik6+FijKNWEnh6zCC80X7mYoTxPdo2QrrEyAR69tb3bF6AHiZWnezrbtaC
 agunuTOONtL1gyZv1UAD4wY384Ve59vwA9BvvIWAyafriovD6dn0TVIsnwyDx0uVNes+
 5L877MsnYYUayLaLJxoxCOcaj0m7aMGHhuIbBgwOaXC/2zF+QKuvGEJc4Z4LFDoTHCkn
 6wPIae5AnKSNlnDf0r/ABuND3OnCYlLwdGknDCDqO56/03epX0SVgUkLBZICoSOS+Jwd
 ZlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/VEcJKE0VqG4mGPPKnuNc++39dwURobverBWENyZHGQ=;
 b=UG7kBPKCkrUGNl8dA9vcjdINhKAYehfCZvcB/7hwuFzhMfzch6exQPpqHYM00sQh+i
 5GVuJd1ai0GgRsIlYIAc9v7o3e+EJacMxlZy3sb/F9F5PUkABB1KgyyCNrNuGm5kAWEU
 WResJNefdTQUhfhPT3/JKgAm4PwKVhm/JTYwW2SaX1W0aIQAgMoNV4aqJlNwkpw5KJxZ
 Q03cl0yTFMRfrEbXaKuVI/eotsnMtVwS62wh+tLMxsKKYZmKg2khf8/Wswv80UZkXRF+
 +A0z4bSw2trdsxzW8BNnCjvzofbIQzMTP2iZAqYVI8CjITLFdT+doYJBqoVU9ZeG5eHg
 iNPg==
X-Gm-Message-State: AOAM532KXWuEwCHALQQMJVHoB2L5o0/cHx5A7R1z8IFa0zZITr/Pv6SE
 AsLSFAQoYMWBxHg6S9QYfjRdLkYVAlHLBsd6AdFVqqkxqjk=
X-Google-Smtp-Source: ABdhPJxfrNWPAAKEMSm75SK5RirhQGjFik4inNl+WgsORo3wA4Y2aT8UFfZFAaGIdjYruNPVYyfHMCbbnvnLAaVqTrI=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr13913786oaa.200.1654031639836; Tue, 31
 May 2022 14:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
 <20220525020926.1951685-5-alexander.deucher@amd.com>
In-Reply-To: <20220525020926.1951685-5-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 May 2022 17:13:48 -0400
Message-ID: <CADnq5_NrB-ngBCakdk3VFmnQ1Ptk7unNtD9W8FG5KcYvQse=+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix up comment in
 amdgpu_device_asic_has_dc_support()
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, May 24, 2022 at 10:09 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> LVDS support was implemented in DC a while ago.  Just DAC
> support is left to do.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index dab0c59bfb1b..fa26e462e750 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3286,7 +3286,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>         case CHIP_MULLINS:
>                 /*
>                  * We have systems in the wild with these ASICs that require
> -                * LVDS and VGA support which is not supported with DC.
> +                * VGA support which is not supported with DC.
>                  *
>                  * Fallback to the non-DC driver here by default so as not to
>                  * cause regressions.
> --
> 2.35.3
>
