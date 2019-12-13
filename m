Return-Path: <SRS0=wwPX=2D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8EDC33CB8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 20:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6252468B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2019 20:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbELLeWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6252468B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E39A16EB5A;
	Fri, 13 Dec 2019 17:11:08 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6936EB5A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 17:11:07 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p17so358731wma.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2019 09:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mKpajWEml4+FOMlblBcX3L1pWZcBGCypXaimI8tJVi0=;
 b=IbELLeWwILy2TpCTxLh1P4cHyRKAfQ+HP9gOeqc3dtDQ230KHpcSrW0Y78tWQ9S42e
 xy6uDpDjVhlG0df08QsUZngUs5xjQs11EIgcwRP/+GKJ5Z8ou10rfuGKT2zUk9VAbGcY
 err2NktIW55yMrNupovgLmNKyoFIXt0u4yp6TtodIflq+QzrDMqvs4g6T+aFi7A+L0Z+
 zQRMK4NgPT3L2tdEofgDS2UOzLdWCw9d7Uy7AS3iHbsbgQxFhKlhwQcpI+Cvnj4zEE55
 gyqEAW7kSvJyKFj4buf/HPnW+MTPOVlkAvnuGaeZh6jMRkEUTWGJkOW6IPzhbsRwc7h4
 Y22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mKpajWEml4+FOMlblBcX3L1pWZcBGCypXaimI8tJVi0=;
 b=IE0mig0UrW4y1h1cNWB9Mi1WBDJ7bHK0DM4ByvW9DmCzwP0kQ0KzWdfIVizfsBF6n0
 XYEf3R3Z94/lUJNr+bwaleTKu8OVkmBpkR70ahUCGppExGxpZ2iyX3XoKKcLIMZ9NWoY
 TUAePZE9a+C9c3u4Emnv0lLmlAmlERa5z9wMJqNCq/OoaKFXezgPhAFw+9lPyjeNcEE1
 8aYvj2ScJPPBXqqQoqnzWTDkCDGBCl0XiQ40kG9SMOp0fnc/g9B2pNKika/zkz1FaES5
 E6n/CrB8zzpWwQFFj9d7zSIXH5oFQEIL/Orakd3pqQ3thla+0/LIU1YGfrfXM7W82lvP
 5w2w==
X-Gm-Message-State: APjAAAVyqBEQny6lA1VD+oTTR36qe8DFTBS7oaCGS+feRA8RQenSJ3xs
 Lptgha3qowVTke2nNNWIBsZ6HjmvIfHCPsVMw/A=
X-Google-Smtp-Source: APXvYqyw48c46fnQfiPS6PWjiWJDGu9rR9l7gzrbjHXXqnL3Nkp8idbZA0f9O3WX2faT0FLpPss/TbTO8Qxme0q3NXw=
X-Received: by 2002:a1c:e909:: with SMTP id q9mr15211829wmc.30.1576257065551; 
 Fri, 13 Dec 2019 09:11:05 -0800 (PST)
MIME-Version: 1.0
References: <20191213161124.24622-1-zhan.liu@amd.com>
In-Reply-To: <20191213161124.24622-1-zhan.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Dec 2019 12:10:53 -0500
Message-ID: <CADnq5_MMqfQoLxTbMhKEKnnNzVhQC_OH077JoEDzQqwwB_oCMQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd/powerplay: Copy watermark to SMU
To: Zhan Liu <zhan.liu@amd.com>
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
Cc: Kevin Wang <Kevin1.Wang@amd.com>, tiancyin <Tianci.Yin@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Hersen Wu <hersenxs.wu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 13, 2019 at 11:11 AM Zhan Liu <zhan.liu@amd.com> wrote:
>
> [Why]
> Watermark value was expected to copy to SMU
> within navi10_display_config_changed(). But
> navi10_display_config_changed() is never called.
> As a result, the watermark value is never
> copied to SMU.
>
> [How]
> At end of navi10_set_watermarks_table,
> copy watermark to SMU.
>
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>

This and the renoir patch are:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Do we know why this isn't getting setup in the display configuration
callback?  Are the watermarks static or do the depend on something?

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 15403b7979d6..f4cdd78492fa 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1472,6 +1472,17 @@ static int navi10_set_watermarks_table(struct smu_context *smu,
>                                 clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
>         }
>
> +       /* Pass data to smu controller */
> +       if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
> +                       !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
> +               int ret = smu_write_watermarks_table(smu);
> +               if (ret) {
> +                       pr_err("Failed to update WMTABLE!");
> +                       return ret;
> +               }
> +               smu->watermarks_bitmap |= WATERMARKS_LOADED;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.17.1
>
> Fix a typo here.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
