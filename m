Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F79C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 20:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78E2613DC
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 20:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78E2613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7882F6EE72;
	Wed,  2 Jun 2021 20:50:47 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E9D46EE72
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 20:50:46 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id k7so5796459ejv.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2dL6xzPC3X55hfhEhdxOqsidTmzCgiG0chniC5ZfVds=;
 b=pES3XpKWKfCYWAKxqz8kJLS5/2dptKJn/t+9GF15KKo898RkybqWpA++qRT7Ef9kEG
 iexreb3SBwx+NPH9VS48BnspdqqLJ3W8+cdPv/vsPWthGUnyoz7fDV4PCExNDkHOr4im
 cjzn2x3nGBdtgf+4Y+ah+cbwuHP14GebKz2Fnu49IcbU40svPGa3q6UvEHotC7BzP3Xi
 8unmi6tBnudK6WJYvSSMohJh8pSxm5qD1Tb0UwrRUE6SdLfN0uufygs/O3giwOIfH5iH
 ADp5VjOAtxTyazasi7A0bwnm1FT5lgB9fdYsaoSkbemGjLYYdO/neNh+UiY9gYa+jMOP
 zHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2dL6xzPC3X55hfhEhdxOqsidTmzCgiG0chniC5ZfVds=;
 b=NOKe7Qf9Qu7Fu+SBgv8v0yxcUmDsNR39Dx/tjpUrnGi6UswpwbjjMnfdiUAWEA8fWK
 xA6Q9LSSC/wpr5Iv2WDMtU6u5nZ0DrRKgvKazHvGphRPbGb5xJEmakUcYVojaaUEjYoo
 y7IaCympI2unqGAgqtYTRW4Kk4TXds+OynEHUwCNT1I56qiUaUiO69+pWbbN06NFZ8yl
 wBR1VqhDi+XL4E7pLeMJY51ah3NTBq+K4WFpyQlTVRFvNCCXy7buNnHpnjL8lzOZ53OT
 DgaJsIKWQ74glZhXxuI7v7WrDk2/E96KLoOCXaGomfUd8bG3jAg9IL4f9B0YS9rRZMa5
 FPYQ==
X-Gm-Message-State: AOAM531Yfysv6URqQJgOGuPShmbIvJeZRXGSGALRkfUrx57J47nrW1sM
 01UKmLp6Sn9pv9gLSXJTr/fFof0grLm/j1NUZD0IvkLb
X-Google-Smtp-Source: ABdhPJy4wcqr2S/HXbC7lckFfa9kNGUMm1B1QErEqlVvUkRQwkCSEAd2IARmfJunFOXwuhFY1gMiw+O9J469REnOp1E=
X-Received: by 2002:a17:906:388b:: with SMTP id
 q11mr13774550ejd.43.1622667044907; 
 Wed, 02 Jun 2021 13:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR12MB3547CA74B0AA230909080A0AF73F9@DM6PR12MB3547.namprd12.prod.outlook.com>
 <CAEsyxyhmjds=87PKyVVkruwZLOQgk_DALgD_-_nLxzmMiH3qFg@mail.gmail.com>
 <DM6PR12MB3547B98DE79FE9CEAE399CBAF73E9@DM6PR12MB3547.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3547B98DE79FE9CEAE399CBAF73E9@DM6PR12MB3547.namprd12.prod.outlook.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Wed, 2 Jun 2021 22:50:33 +0200
Message-ID: <CAEsyxyiu=yseyqaHN=mKsz6Yx_B-Gq1vjtUXQMEj=eD0beoQHA@mail.gmail.com>
Subject: Re: display regression on Carrizo
To: "StDenis, Tom" <Tom.StDenis@amd.com>
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

On Tue, Jun 1, 2021 at 6:50 PM StDenis, Tom <Tom.StDenis@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Hi Mario,
>
> Yes, this diff fixes the display on my Carrizo:
>
> [root@carrizo linux]# git diff
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index cd864cc83539..ca7739c9f6cb 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -1044,7 +1044,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
>          * SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616 with actual > 10 bpc
>          * precision on at least DCN display engines.
>          */
> -       pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
> +       pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
>         pipe_ctx->plane_res.scl_data.lb_params.alpha_en = plane_state->per_pixel_alpha;
>
>         if (pipe_ctx->plane_res.xfm != NULL)
>
> Tom
>

Thanks. Just sent out a proper patch which should hopefully fix it for
you, limited to dce-11.0 for now.
-mario
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
