Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB4BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 16:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2422160F36
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 16:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2422160F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC9D6ECC3;
	Mon, 13 Sep 2021 16:54:05 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 150AC6ECC3;
 Mon, 13 Sep 2021 16:54:05 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 c8-20020a9d6c88000000b00517cd06302dso14175398otr.13; 
 Mon, 13 Sep 2021 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4GPzHkZA+qOlSyT36DTpQf9mRfat2Hn9YzRuIIpxhPk=;
 b=QJcBP2YTK7N50SUPa1Ljm4GShk9dnSUtwSQPY6tGGiGD4R8/5aSYsRQDL8HE5lyBUG
 uEVuUOGkSNEAL2wFdPAiCXYj/vtyq3pEQHhTurDp4MYCzGVn5oyntInic3oxwLZV2AQZ
 gM9TsPkmYWSjR0EjRwo5YfVTbFZWtt1xLOq//UZ6o80a5FQ9pKQf0Wo3SblE4DSwLeZ6
 jU+oNCuRIBfA/WZElfEUd6IPpGPNYkPFFRFPHDkymuYP6+ASDMou9ElSwE8Mon1F/sPI
 RrSCTbsIsN3kb3rTCP3DmZJ+KV+BgnH+XxgdZd8qQzMpgh6kj0w51mhy5p2BMDNI/YkD
 6Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4GPzHkZA+qOlSyT36DTpQf9mRfat2Hn9YzRuIIpxhPk=;
 b=gNGe7JkCRS7Ee6Pwic7mJ5OsecPqegyzYHPyaKOEUIM5Hf9LgYxpg6lKkqzw7i8urZ
 TUMufUSYXGY5lZ7bbW3O4V9kbYne4Fzjpftl8/b3qWa1C6bcA9wKOr3ZcOlphByRI/Ud
 9ycYvDSx7+QS4vEe/HO7zaJGll554wZeChyji/RbUD3R9gDHWrxr5Yio14VKbI72B/v3
 TTrULO51Tne1qKKDH3rum2Fl8psMleCgZp/hk2LN2NrYV3quR+iTMKb792Iv2aSgY7Dc
 inx3//pyvRqXAAkuYvBhKAHANKOM1w64VPaDAbH4to495hJSuenPQ1MXo4b1FNbsff8c
 BRFw==
X-Gm-Message-State: AOAM530noyuzlFogtUfpt2gRG5M22+jklpbWRRpv8/qSW53cJdsZqaAB
 jwPZ+jTDkTeRsQXHIU0aEK7/ADI/lEQ0Ts+4z+4=
X-Google-Smtp-Source: ABdhPJwk5S0+em7NHoRvEFg67o03NoLil78mKcS+Rr4NM7fZFDsLOkEoddrFSAC/whvRpqZ9s2pQzRjuOUUQRpKlYRA=
X-Received: by 2002:a05:6830:25d3:: with SMTP id
 d19mr10955101otu.357.1631552044428; 
 Mon, 13 Sep 2021 09:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210913083411.11215-1-pmenzel@molgen.mpg.de>
 <20210913083411.11215-2-pmenzel@molgen.mpg.de>
In-Reply-To: <20210913083411.11215-2-pmenzel@molgen.mpg.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Sep 2021 12:53:53 -0400
Message-ID: <CADnq5_Mgwtdtiqn11kcwsn5Q581i5FDZ1WKE-02Lg3BNBZ4TCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Demote TMZ unsupported log message from
 warning to info
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks.

Alex

On Mon, Sep 13, 2021 at 4:46 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> As the user cannot do anything about the unsupported Trusted Memory Zone
> (TMZ) feature, do not warn about it, but make it informational, so
> demote the log level from warning to info.
>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c4c56c57b0c0..bfa0275ff5d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -598,7 +598,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
>                 break;
>         default:
>                 adev->gmc.tmz_enabled = false;
> -               dev_warn(adev->dev,
> +               dev_info(adev->dev,
>                          "Trusted Memory Zone (TMZ) feature not supported by hardware\n");
>                 break;
>         }
> --
> 2.33.0
>
