Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E282BC5519F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 18:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CF1223C7
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 18:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvXFWHCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CF1223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0751F89DFD;
	Tue, 17 Nov 2020 18:43:01 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE5089CAF;
 Tue, 17 Nov 2020 18:42:59 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id p1so24178172wrf.12;
 Tue, 17 Nov 2020 10:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sCMQ/QonvivA+lIMBxKQU3+hpAIR8NvsAFKTyOancic=;
 b=GvXFWHCgA+OCToZUPLj9a0WvXhkO+wcsaN34rwur1n8sRxT3eIe2VSgX0Qm5R5Sogs
 JTdWc2LRy6jtqkaMHA4E1BCp0oAXKj1yvJLOQQ04C1xADC9TN3Xhil2Mi3phOLIM0diZ
 eOm2CEMWHqsgyriBBGxULfRWvpm6p0ym6dR9ggLfo8vVTZ1wfEKDO4WULuffA1ivfE3p
 CO6HsAyrmuHft+150tGUARYOIPm9af6LjYqrGa53flJy7Lw8Fh8WjizLO5KLncFIl1eP
 dCDojQVDAbAgwk/dkNUqJc98UQRDncud/7nTlQecShy3GdOvr5cR1Yk1E6XzLcj2YM4p
 E+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sCMQ/QonvivA+lIMBxKQU3+hpAIR8NvsAFKTyOancic=;
 b=NuELn2TcbzG555ZpQnywb8Zp4T4cQBACgNZITAOToF4OfwJkg7k7wW0e9q3KD45MSw
 crT8vl+KDmn/JBrHtNQ2lGWF56ZHdrFq2afxh2I/+dTUDSEPup8/1BRJyvgayCf/DDG9
 pbTkKXeD3ZgKakD9AiMsdbu5CBMXnrXhqyv6sOXo6VSmsmsc6UDVXmQ+XJrHNNW10U0o
 XfQUQ0OxnrrP+ITc/7PZfh+rbjxy0xSWEnfF8rN7USjq3tvyI5+2fRL/JeqJZC1rriBF
 2s0EJ7cim1bSEUk9SerPwa9zDNh85O0vRBdZWS9DV/L6LQg+R8mrg8qgwTTfMg79CqF2
 CdZw==
X-Gm-Message-State: AOAM531G7krX+P016KFHI3xpiJce5s1dwO5ySmYELTp9gjCqA7t2tIS4
 wZaU/0dn+Ujm02OnghZgTzavsQbARK3SR2jdIS+Y86fJ
X-Google-Smtp-Source: ABdhPJyhhbPWxQDD0L/vTj/Ph0WR5F1wMtAKEbsL4r39UQpFucNpmyQfQlTisLjsWBuS1l+uhFLwNKL2xtOl+y3bt9g=
X-Received: by 2002:adf:e551:: with SMTP id z17mr951496wrm.374.1605638578216; 
 Tue, 17 Nov 2020 10:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20201117131137.420396-1-colin.king@canonical.com>
In-Reply-To: <20201117131137.420396-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2020 13:42:46 -0500
Message-ID: <CADnq5_PK_Z3eAwK6gNOu-KP1nV2=xiMS3O3RbQbYuRaQUOn7qA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: fix spelling mistakes in dev_warn
 messages
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
Cc: Xiaojian Du <Xiaojian.Du@amd.com>, David Airlie <airlied@linux.ie>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 17, 2020 at 8:11 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are two spelling mistakes in dev_warn messages. Fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index afa542a5af5f..9a2f72f21ed8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -689,14 +689,14 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
>
>                 if (input[0] == 0) {
>                         if (input[1] < smu->gfx_default_hard_min_freq) {
> -                               dev_warn(smu->adev->dev, "Fine grain setting minimun sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
> +                               dev_warn(smu->adev->dev, "Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
>                                         input[1], smu->gfx_default_hard_min_freq);
>                                 return -EINVAL;
>                         }
>                         smu->gfx_actual_hard_min_freq = input[1];
>                 } else if (input[0] == 1) {
>                         if (input[1] > smu->gfx_default_soft_max_freq) {
> -                               dev_warn(smu->adev->dev, "Fine grain setting maximun sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
> +                               dev_warn(smu->adev->dev, "Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
>                                         input[1], smu->gfx_default_soft_max_freq);
>                                 return -EINVAL;
>                         }
> --
> 2.28.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
