Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46DAC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 16:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED2125590
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 16:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWykJUcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED2125590
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FF389CD5;
	Mon, 29 Jun 2020 16:25:31 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84E3C89CD5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 16:25:29 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id k6so17162828wrn.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EaZAkmkRX0QBkd0Hmx1WQEgrlHAMmznRS7ZksQBtNGQ=;
 b=IWykJUclFnWL4FB0L8NSNAp3baiw35kKBRHDqDoT8h29NXWPH6iJ+I8Cmoym/wvj0v
 UIKgE3db3rfCCiJp0P59MJ9vYcBA5xKlceTb9o78sOOaKhLmRSK7C1N1JFDAi7l9MB3D
 K06i+an+l0/IvX7RIyZVJeCsSuERoPbEaZR0TKOdMgDsge5p3yJyKecCGTtJNIvTNoaR
 gSN1ZFh02aD5XaABHRCqMAqi//g6T7WWh9wWeqCd+UFqoLKVcHi+pfJ3EpvB1jeJsH26
 4IpZF0STCTUhzLiE0lIuF7RKyA0LbjED9+dvWsj6/lh5BC0JIjBWSq/sdjhy4Oq1KxvY
 c+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EaZAkmkRX0QBkd0Hmx1WQEgrlHAMmznRS7ZksQBtNGQ=;
 b=AmX+JYrbdUhsENYkOsziwy6XHJh33bgl72iOIrVFcEMRP8QYi5GJLnJAZqY/CcT+S6
 vp3q4pUS8zpC5ohsEnUC4Zov6g+7ZMHc2aTfwYuGNKS/mfoyUiWeWz/1ddcVsV++Ugrf
 jqvP4/saFUcjsxaC1ShP4JhKtKbXoClq6DYF4Aw+rfFVzIobncU63gYuBcoctlenVJ+K
 s22gH+3Pz9yKKmKtZ53jGSBHVDzXlChYeFM7XqIj/BaYF01gsuwYqRRgtD9QAoch3FSr
 2zeiAimCB6VbfgMv4GlB/fRxrMP2g8HzKRMcP0oWadVUIeTxrOSAl/s6HAXXJv/pQU4U
 a1dA==
X-Gm-Message-State: AOAM531LdYK0LFSQ/lrkBIu+0sUT7SNC2yKQHR5oCUmg9KUCAumMwRS/
 MQKAPe/zRfZSt7M8kvt8Tu4nP64MKDbL+iI1yng=
X-Google-Smtp-Source: ABdhPJxuVjyl3J64TssA5AOx8T90aGM3txYNgGigeAYJJBw+ei1BQk6EATs7cnBWyipL57ZzlSjb7rZ9At4newGL9bs=
X-Received: by 2002:a5d:5549:: with SMTP id g9mr18777748wrw.419.1593447928105; 
 Mon, 29 Jun 2020 09:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200628111848.1234-1-evan.quan@amd.com>
In-Reply-To: <20200628111848.1234-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Jun 2020 12:25:17 -0400
Message-ID: <CADnq5_NnQbOXs+oWEeb3xvgeVZEPKLCjiRWkBaS7e8zRfeNuBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: fix compile error with ARCH=arc
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
 kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jun 28, 2020 at 7:19 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Fix the compile error below:
> drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c: In function 'smu_v11_0_init_microcode':
> >> arch/arc/include/asm/bug.h:22:2: error: implicit declaration of function 'pr_warn'; did you mean 'pci_warn'? [-Werror=implicit-function-declaration]
>       22 |  pr_warn("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
>          |  ^~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/smu_v11_0.c:176:3: note: in expansion of macro 'BUG'
>      176 |   BUG();
>
> Change-Id: I4e969082c41f8a8c91f1b0d19eb853eb0a2e0c0d
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

I think this is probably a missing include.  We use BUG() elsewhere in
the driver with no problems.

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 677f8adb920c..48e15885e9c3 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -173,7 +173,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
>                 chip_name = "sienna_cichlid";
>                 break;
>         default:
> -               BUG();
> +               dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
> +               return -EINVAL;
>         }
>
>         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_smc.bin", chip_name);
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
