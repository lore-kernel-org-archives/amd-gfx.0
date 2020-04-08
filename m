Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69819C2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 278902074F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lpb0URCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278902074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9BF6EA6A;
	Wed,  8 Apr 2020 13:43:57 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D705C6EA6A;
 Wed,  8 Apr 2020 13:43:56 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d77so5204664wmd.3;
 Wed, 08 Apr 2020 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5JeVxarE1Z1RiJROhmbNs4AI7L5YmBuO9l5ang6+c2c=;
 b=Lpb0URCll2uC4ADQJYY7mI50YUF0YKFj5Wty4cYMWCdeGVhx0fncfLWtomod/N9nPY
 F7HrkukZfy+0cuzfU1yzdg6gXZJGJiwbqWb2wZgIq2PKb/IEFLjIIHLYCjx4IQgUiiFv
 tThQFvsr9XYztxj0ojy5TkKXV4gAdTSDwMuo/RtBCqroxK3K1sdaqzWn26369aphBCID
 Q12SF0uW+aQh2s9rkMb5hrd6CUXdp72uGQULxsMa+vNe/aPCczKtclvPZVayDlWpX5BV
 3QjhurMMZIbBiiwBfZd2QkytcEt1327ymh4+gbsbeEuBUGYMRCfhtYuX57h4ZWOOH4DM
 gCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5JeVxarE1Z1RiJROhmbNs4AI7L5YmBuO9l5ang6+c2c=;
 b=A5thQqEkpdp4k2K45BcS5nF2XUBADPZ9JCJ0NeQaoPAZNSwJZcBUpKkzK3evRcXnY8
 euyECIDpdq76tGPI3v12Y7/WE/brbcpGb8A/5FcA3qEBqhqzi+m2qdeSIZr/GSZpbn8i
 yvnej68LIUzaoCVDi4imLQXun89utFjabJvYZrLjlQ9BXmaTV5l9dId9fiNJtu7zPEvZ
 iBYwf29Nzk72FcmCrixUkboTsEf0kVWIUJECcGgaHvxSdvzx40mIJ+z5B2AH+Eah2rxb
 3qRdM2f82cnk40suRUH5FAg4ic1sbX2UmCnYvUpVEwCuYvOXfmlMlTzjyxFFEwRPxQ1a
 0U4A==
X-Gm-Message-State: AGi0PubIndKNhIyh9QY0q5TBgFLEf9NPV/+9KRhOxvpPqStYoE0E4GIh
 Mo5+Oaqwb65rMS2DZnBmQTDgC9+XfE551uXEJZs=
X-Google-Smtp-Source: APiQypKVw6l28/vf8DOlr+wvkyILlmlKHHNxDPwytq39w6kUSGnC9oKbQ4hvvCKuyfTXtGZzV1ALzsk2hRmrkhxMRGY=
X-Received: by 2002:a1c:9d8c:: with SMTP id g134mr4851682wme.79.1586353435428; 
 Wed, 08 Apr 2020 06:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200407182618.2488-1-mail@aurabindo.in>
In-Reply-To: <20200407182618.2488-1-mail@aurabindo.in>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Apr 2020 09:43:44 -0400
Message-ID: <CADnq5_OCkhjVoJ8L-KHOo-2b-thAAcSCHoeJc-DsR7j-8ZX7Yw@mail.gmail.com>
Subject: Re: [PATCH] amdgpu_kms: Remove unnecessary condition check
To: Aurabindo Pillai <mail@aurabindo.in>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 7, 2020 at 2:30 PM Aurabindo Pillai <mail@aurabindo.in> wrote:
>
> Execution will only reach here if the asserted condition is true.
> Hence there is no need for the additional check.
>
> Signed-off-by: Aurabindo Pillai <mail@aurabindo.in>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 60591dbc2..9fedfa531 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -179,12 +179,10 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
>         /* Call ACPI methods: require modeset init
>          * but failure is not fatal
>          */
> -       if (!r) {
> -               acpi_status = amdgpu_acpi_init(adev);
> -               if (acpi_status)
> -                       dev_dbg(&dev->pdev->dev,
> -                               "Error during ACPI methods call\n");
> -       }
> +
> +       acpi_status = amdgpu_acpi_init(adev);
> +       if (acpi_status)
> +               dev_dbg(&dev->pdev->dev, "Error during ACPI methods call\n");
>
>         if (adev->runpm) {
>                 dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
> --
> 2.26.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
