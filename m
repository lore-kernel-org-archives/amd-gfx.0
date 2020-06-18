Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BACC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 15:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439EB206F7
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 15:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtMsv7Aw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439EB206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18CD6EB23;
	Thu, 18 Jun 2020 15:15:41 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F016EB23;
 Thu, 18 Jun 2020 15:15:41 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id t18so6464926wru.6;
 Thu, 18 Jun 2020 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hzlvT3gaSlLbN4f2sLYshLtTaNcAUW9eRJsVAjGv5Ko=;
 b=qtMsv7AwvP28H04YkN6EWvksFGG0W2yZaMKLxPJQnvzfC1QQON8ZhE78yHS6xPa5XO
 LuiCJ2qpgqvmf7JWSmKmcLlvT7gbb8MNVZ/YDM2iaZ33v2R6E7nQUsOJfPs5r2/er912
 jET4OpIXCXlSDDLNklSrG+fTsA7WWKpAqytffIVZxEGG/s/hALY1Ff+5ZbazpmvDUdDa
 FHHjlmjUR9YhqlQQX+vVZWEjoVcE4rYIGTRG3JaK1ci4Xp9ZPfxugrCG/b7uPn2VzEfP
 PclGgDIyESG5oFxxhN+omK4rA0i7kxs3fnCpe8cVZTjOm68UKcE8YUVyKdNjBCs3LwYy
 CrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hzlvT3gaSlLbN4f2sLYshLtTaNcAUW9eRJsVAjGv5Ko=;
 b=TvzcJH16no1MWt8e/W37dqAs+oVSW18T9R8FpADSk4E4l5Ctx4ym5gMTN3CCntQqaL
 KDwEqJSXCW449bP1LXowrARblgG4whDQAh7ipKPml7n2t85mSVCs8a1trbH3mbBXnty7
 mEETauwCeFzfEz2Kvbm2oK1REai4h0o/KPnWSILV0d/AqlAHxcT7xD+w0lXMv9B84AYn
 rmJs8F9hYnd8fo+yiQT89ZU2Rmeu3kxbng6rbWd8QqxTqzLFzGScwf9Oss9dDFR9Ucm1
 L4bpxnPyZI+LGY8wqtEHUby4w+4M9hYllMuil66dR3Tt/0AqixKFinFUb9IeJePd+cyd
 c8Gw==
X-Gm-Message-State: AOAM532D3ERpNvYIf1z06VE1j7VFPXQoTjqdfq5Tqs6h1vGTibsMd0Ag
 HHj2HVuSOktV2LNzGD7LGZI5NrJP476MCbgWTEw=
X-Google-Smtp-Source: ABdhPJzZdbx39Ada+O27jmlcsTDezs3Ch1jm0rrsMzDul8XqjyMgpuRoP5sfTmlIH1uh8tBxx7i44dGJ+BtI4f4Dxj8=
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr5073030wrq.362.1592493340203; 
 Thu, 18 Jun 2020 08:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200618102622.12256-1-colin.king@canonical.com>
In-Reply-To: <20200618102622.12256-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Jun 2020 11:15:29 -0400
Message-ID: <CADnq5_OeVaKbr46WDQ0GcnLd1CE2EbwmRxyVOVqJcqwkJN5qNg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove redundant initialization of variable
 ret
To: Colin King <colin.king@canonical.com>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 18, 2020 at 6:26 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index b2cdc8a1268f..58b76d3d7365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -1609,7 +1609,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>                 const char *buf,
>                 size_t count)
>  {
> -       int ret = 0xff;
> +       int ret;
>         struct drm_device *ddev = dev_get_drvdata(dev);
>         struct amdgpu_device *adev = ddev->dev_private;
>         uint32_t parameter_size = 0;
> --
> 2.27.0.rc0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
