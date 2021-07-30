Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54700C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEF960F00
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BEF960F00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DB189D4F;
	Fri, 30 Jul 2021 02:21:25 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE88189D00
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 02:21:24 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 y11-20020a4ade0b0000b029024b4146e2f5so2082441oot.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 19:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rY+9G8Q38inHnp5VR3zTK8VfTTInfpSTIAY56RSB2NY=;
 b=DvbzTNXXSNYbMKdI3dvsvH9SUNxoimHMCUQQcizvfZ/SZG5YVPc4mBzWmkq9wGFuzj
 VqYpfCsIHwGx3QQ4QXNnpgiqAHMYDkLpVJkM7segHmfYcjD3py4M8sokFyLlNZp8PLI3
 z1mZBMOODUazqKAidCvDTmrx69qVlkyda9eOuKsBAJrwbwg9NvAbJKwyzLobEA//QtR3
 zbaAZDfZsr46b6yG/K/H5aIV0GhxGun1uEnU/HPiV1mJAngg34i1WRUvlg5pxjnl3ULf
 INbulmVpeMyXWWCl5ewAaXIBrkItzu6QrNhL1bp8kwoISjEv56dL+Jv0yM2mzuRdwpyG
 xC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rY+9G8Q38inHnp5VR3zTK8VfTTInfpSTIAY56RSB2NY=;
 b=X/pzHjD/5rGIFwSjuyw5qKTL9Pttqa+qzB+ABVNarobJ++eriM7CoJJe/prSgrY6w8
 QzQ4rfUFTdb8bwwDdutfG1cgn1Wkg1Jy48iwLOvMdVrUZgdBCWtVz17UyxNfmFZeyC2m
 /lsw8jRcn1Wk1Hb9guEmYOUF7K88e+l8Ao4CxC63w9DQPGPrLA0wcFHUwyW+zaZ9aL69
 TxqJZvNh3bQvAAVi738mYvdyuoPTyHZzUAwuW4BY7n8LmThvowO+hmDo+uhuFlc7r2is
 zmJbgCKZc192QXSci+nuQLRxcuAxa2+l44Z9bRIZqX1A4n6c9YPi7wc15XU8kYADRr0n
 N74g==
X-Gm-Message-State: AOAM532snDx198GiE+f5AGFto5fxNKLvx0D21oJ47Ahs35lty442IWiW
 lhVuoR98g/2c4KdCNwtVOUVNDtYN6pn/BU4jHDo=
X-Google-Smtp-Source: ABdhPJxpCYa0oIfSEw5TIN/yj2T9wh41qaKwgVEfybU/mUG8Lz+r/DLlyFDM+ijLCh2Fx8Q40HSChM0k7R2NbU+Y1AM=
X-Received: by 2002:a4a:2242:: with SMTP id z2mr156897ooe.90.1627611684125;
 Thu, 29 Jul 2021 19:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210729135314.661858-1-standby24x7@gmail.com>
In-Reply-To: <20210729135314.661858-1-standby24x7@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Jul 2021 22:21:13 -0400
Message-ID: <CADnq5_N-T1-Tkf3JS28h_vKHpXhQLpRdWN4aLONLfCnGC7HR6w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay/smu10: Fix a typo in error message
To: Masanari Iida <standby24x7@gmail.com>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, xinhui pan <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Thu, Jul 29, 2021 at 9:56 AM Masanari Iida <standby24x7@gmail.com> wrote:
>
> This patch fixes a spelling typo in error message.
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 43c3f6e755e7..7dd92bdf7ffb 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1580,7 +1580,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
>                 }
>
>                 if (smu10_data->gfx_actual_soft_min_freq > smu10_data->gfx_actual_soft_max_freq) {
> -                       pr_err("The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
> +                       pr_err("The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
>                                         smu10_data->gfx_actual_soft_min_freq, smu10_data->gfx_actual_soft_max_freq);
>                         return -EINVAL;
>                 }
> --
> 2.25.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
