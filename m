Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F359C433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0BA206D8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 20:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCsRsLi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0BA206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0F16E4BB;
	Tue,  4 Aug 2020 20:33:18 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733676E4BB
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 20:33:17 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id g8so3844612wmk.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2020 13:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ba/vp9WP1dOScQnxeEY1wkyVef5JbFdpUB1JMTIzOXM=;
 b=kCsRsLi2SD+QamBMmJpIn43hhCK0ce/RE0p2jh14AC5U4cP1tkt3v9dPjT1KpbiAJ1
 FVXFFRdzlOeDOmtH1RjiyfmtSAh29ZCXsRP/cgsCPbh0LPzgZScU/5Tsz5q9LtZiDABm
 xmEEoKOR2QML4R9zYbSEk4uxNT+nEWAERnunFM56H3pbImnhfeiGQX4fdDzXOc5Guaru
 wSPWikTfJYCVlo8OQUMTaJM65enqaEmex/TPt1H7LGk+c1aw1z70qb3AtQLIXJ6O+VND
 +sXAMJUsFvv6Ids7QQJ6fLqZx0zB2hS1Aoa2w5KkdWOUZp3SVeB1K+SH+6z6qlQhYZJk
 T0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ba/vp9WP1dOScQnxeEY1wkyVef5JbFdpUB1JMTIzOXM=;
 b=BR1sU9LxaedG7d3WQNcmCVsdMa5R0ChW0Rm/3jwSz/NjG0Q+JcZGJ5fZxnNu85xcsG
 Y7TF+ec2RElaHOGaZCaXR6LriYdD/IYG0esylW7JjS2tdKiFsChAIagGreN9d9rBkM/7
 Gq6fV5lM6FXTIdDGl5wlGKbx/LdOAiJKXuekNYfRP49drjUk4eq7UJlkgwGXMOeASRzg
 6fZUIkPCsdNMHkjJrDCzRE9L7TQ2OQU+VREqdX7L2JuJGXEYZShBCtZakNQQJImz55HO
 d35//0F0ZHAIlg4SR9L7gtHvGKgLvkcky6uhyx0ppiSd9x7tFRdNHvA6APaLIe6HhXW3
 xRIQ==
X-Gm-Message-State: AOAM532r8GMX0gp50aMBYTVtOPndjJ0F9mM4k5RSF4ZTXZZ6NpS3wr7G
 SVq1lBEVzQeQ5U0yHq6SY95m1Df61LAQsom7HYHQFg==
X-Google-Smtp-Source: ABdhPJxU9B4e/oeIlSyvXTNo0Yyfhw5gksvyf2sQkr9hqJY7xbRottrbT/yc6ukyCamIoeFFVLeCKHUU+G28HdET6Y4=
X-Received: by 2002:a7b:c941:: with SMTP id i1mr170673wml.73.1596573196039;
 Tue, 04 Aug 2020 13:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200803143519.GB346925@mwanda>
In-Reply-To: <20200803143519.GB346925@mwanda>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2020 16:33:04 -0400
Message-ID: <CADnq5_OCkSv5dgtxy2r1VApwTKXQe6oZapA+1VF2aj4Ux77-wQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Indent an if statement
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>, kernel-janitors@vger.kernel.org,
 Samson Tam <Samson.Tam@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 David Airlie <airlied@linux.ie>, Reza Amini <Reza.Amini@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Martin Leung <martin.leung@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Aug 3, 2020 at 10:35 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The if statement wasn't indented so it's confusing.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index ca26714c800e..c6b737dd8425 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -71,7 +71,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>                 if (ASIC_REV_IS_TAHITI_P(asic_id.hw_internal_rev) ||
>                     ASIC_REV_IS_PITCAIRN_PM(asic_id.hw_internal_rev) ||
>                     ASIC_REV_IS_CAPEVERDE_M(asic_id.hw_internal_rev))
> -               dc_version = DCE_VERSION_6_0;
> +                       dc_version = DCE_VERSION_6_0;
>                 else if (ASIC_REV_IS_OLAND_M(asic_id.hw_internal_rev))
>                         dc_version = DCE_VERSION_6_4;
>                 else
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
