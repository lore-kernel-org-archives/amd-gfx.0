Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F730C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 16:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8B064DA8
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 16:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8B064DA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102646E9DF;
	Tue, 23 Feb 2021 16:26:42 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CB96E9DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 16:26:40 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id d9so1986605ote.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 08:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2LAiQFjTFkoMib2qoob/BrHT7yz3dmSgX/Ep1P1zus0=;
 b=QtASsi8QFnNpxIFJJ9IeNnMPkHIQf4nQPk7PK5JuZ+CzT/O6j8J7mb9e9Xq/p7XanL
 K25cf68RCVDqaMQd62hi0jXtmXFe9VzNlLLPvBXpkS9AweBbIIyFoIvxM9wPG8d41tCO
 AtO/Rg8FQ5FA22wnIzrRtDYt91J5BbDRjA1QkdrZqSKi2Iett5SXczb/HmkXp+XZhnMt
 04aPlwk7Vmt0iysGoB1N7UbLhASuxmI0HJkRWrufQ3YgCTwAcZMi52trf0cHq43Dz7Bu
 5pz35NmJ3kFIC8i8slcuk+/QW7j3m3I2FIjljMO8JESUg84MMXUsnGSi+Ij7+n6IIPmH
 I7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2LAiQFjTFkoMib2qoob/BrHT7yz3dmSgX/Ep1P1zus0=;
 b=QEf6kRWL4b9Mwyum2o1Y9EmX3HohmW27bAOcnAaRL+Sk1rAIOkWEffdHQxy5O2VlHi
 4P8+DNiKPg46bmzvPV312xPP1PCn4q5V35CatdDTqLCN7g3cJQTWDgjrxTsN0yyKsJ7E
 mlQXkIyKeoidf5AO3bE1YvVSjDGv3mSOU2BmyOcvM8XPBC7w/C+W40onSsxmTg2jfS/U
 PweDwLN/L07JbAtpzhBOanXjYiXgc3YbwzE+yMbxEXUYfSiRv1iMkLMq1WbPoBznA9P9
 qxz6g8OTykamkISrsXATYRJM/H5OX9w/gYJS1Pm73y/LO595ZUqoSBSwokixi7mk0F71
 vAag==
X-Gm-Message-State: AOAM532f/TM56P4c2FhDvKiI8PXKygjPSH5yF13LxqRaVizln3/GfGxj
 Zbj9N+O7bsxKNkNWd3OmgEZOdv9IIaTI5oQwkKw=
X-Google-Smtp-Source: ABdhPJwjy4toPPxqVsdXXNoHAVXjsF9evHGvcLaENgrr/8BktJfpZZUiWwT0qxFnbT6pY025pf8Jhyl39cIK1xmpcwY=
X-Received: by 2002:a9d:ec7:: with SMTP id 65mr20830942otj.311.1614097599856; 
 Tue, 23 Feb 2021 08:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20210219011913.28464-1-shaoyun.liu@amd.com>
In-Reply-To: <20210219011913.28464-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Feb 2021 11:26:28 -0500
Message-ID: <CADnq5_PXYRnX25Y=k+5dMxHuQmviD83_dei7oQDLOQDirjX38w@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu: get xgmi info at eary_init
To: shaoyunl <shaoyun.liu@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 18, 2021 at 8:19 PM shaoyunl <shaoyun.liu@amd.com> wrote:
>
> Driver need to get XGMI info function earlier before ip_init since driver need to check
> the XGMI setting to determine how to perform reset during init
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: Ic37276bbb6640bb4e9360220fed99494cedd3ef5

I think this patch needs to come first or patch 1 won't work.  With
that changed, this patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 3686e777c76c..3e6bfab5b855 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1151,6 +1151,10 @@ static int gmc_v9_0_early_init(void *handle)
>         adev->gmc.private_aperture_end =
>                 adev->gmc.private_aperture_start + (4ULL << 30) - 1;
>
> +       /* Need to get xgmi info earlier to decide the reset behavior*/
> +       if (adev->gmc.xgmi.supported)
> +               adev->gfxhub.funcs->get_xgmi_info(adev);
> +
>         return 0;
>  }
>
> @@ -1416,12 +1420,6 @@ static int gmc_v9_0_sw_init(void *handle)
>         }
>         adev->need_swiotlb = drm_need_swiotlb(44);
>
> -       if (adev->gmc.xgmi.supported) {
> -               r = adev->gfxhub.funcs->get_xgmi_info(adev);
> -               if (r)
> -                       return r;
> -       }
> -
>         r = gmc_v9_0_mc_init(adev);
>         if (r)
>                 return r;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
