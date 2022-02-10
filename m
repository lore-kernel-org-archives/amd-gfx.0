Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0661C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 17:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 847D010E8AD;
	Thu, 10 Feb 2022 17:07:23 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB97E10E8AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 17:07:22 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id 4so6556893oil.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 09:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N+amZU9J2Cum8qYkKn8PfTz6V4KMLCZPE76W0sWUYE0=;
 b=DEJigs2QawYmS8zKT6Y4d/Gj5Ab38UHImv2of8wTU8QYmSMWTl96TICNqmXDK9spVG
 VeT+dQ8SWGYky9tkglcoPcL6iMQhDxlNtp7u7E8jrptmGQwm9NkiUHho30yGRheVPrfG
 syBE+tM0anoamFytr3iiPSQbIjxi7Ck0QkR4IGxaxo91TNrYirOqWWR1VN+yQoEamKLP
 hKJYoJExDRbIa2/KPY09g9H61k4beYZGKS9JLB5doofXknc88OMzMfvQnpH6CkdRCEnX
 05m0hWqRCxp0oES1FxobJRSVOudLX/D2wei7VQxlmbF/aWnGuPhTM9ZKtgutkhr+cuW9
 es0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N+amZU9J2Cum8qYkKn8PfTz6V4KMLCZPE76W0sWUYE0=;
 b=vR9f4krSxrhFSVNmZ/qrkKSeh80m01sLSQ5UY9a1JGAuDbMODf+yjKDgUL2DXwu0xt
 KjhFFQ3QofNaXO2U7re3gWvOUgwFTnLScwLG3NFy15cMDfstebdfYUDcGcIYB9qODUYJ
 EsaBdxnWP6qdcA/NQjRASkA0HonXvdWbKg1QD/M+weJtAtOwM1L8/+h4/c0jMnxHUkCf
 7VNl1h2eMXMFJdRhWrtQHuIuOn/V1AYuNCy9hkaWrdwNa/eYvSXZvgj+d2HwTXq6Dnhs
 R18NypO6dRrLDPYE5UDgpCDOx1mh8mE+OPdBCG2yfEn2A2JyGZpo4sB3rHME5ui16XtB
 BpGQ==
X-Gm-Message-State: AOAM530wuc87N/Ai/iFVOATQXlHF7JudkUJWBUwO0Zf6QcYbOxV+RSJ8
 EUNAgmlt1vkyhGAR2rcidYUH4hywAsqxExIIX/WHor4IZnI=
X-Google-Smtp-Source: ABdhPJzVy/SF2OHvQDjUddzyfJD5D+49muJ2xLwXX+JlxUVRy92CaupVtW+wqYUJjfJ4alrcYCCHaLYPNWxahLmV+1k=
X-Received: by 2002:a05:6808:159e:: with SMTP id
 t30mr1427635oiw.132.1644512842130; 
 Thu, 10 Feb 2022 09:07:22 -0800 (PST)
MIME-Version: 1.0
References: <BY5PR12MB4052A50F44F62CD791BE0C08F22F9@BY5PR12MB4052.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4052A50F44F62CD791BE0C08F22F9@BY5PR12MB4052.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Feb 2022 12:07:11 -0500
Message-ID: <CADnq5_MuuA+ivhMGRVHVGmy8w9-FjMXVZVUHC7i4f5Nxejqi9A@mail.gmail.com>
Subject: Re: Upstream This Patch
To: "Logush, Oliver" <Oliver.Logush@amd.com>
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Cornij,
 Nikola" <Nikola.Cornij@amd.com>, "Wang, Yu \(Charlie\)" <Yu.Wang4@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Subject is wrong.  Should be:
drm/amd/display: extend dcn201 support

On Thu, Feb 10, 2022 at 11:53 AM Logush, Oliver <Oliver.Logush@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
> From 488cc792021a60300df3659de204ebef954ba2bb Mon Sep 17 00:00:00 2001
>
> From: Oliver Logush ollogush@amd.com
>
> Date: Wed, 9 Feb 2022 14:25:13 -0500
>
> Subject: [PATCH] drm/amd/display: extend dcn201 support
>
>
>
> Signed-off-by: Oliver Logush ollogush@amd.com
>
> Reviewed By: Alexander.Deucher@amd.com
>
>            Charlene.Liu@amd.com

Fix the RB lines, they should look like:

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>

>
> ---
>
> drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>
> drivers/gpu/drm/amd/display/include/dal_asic_id.h | 1 +
>
> 2 files changed, 2 insertions(+), 1 deletion(-)
>
>
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>
> index b36bae4b5bc9..71b393194c55 100644
>
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>
> @@ -135,7 +135,7 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>
>
>
>                 case FAMILY_NV:
>
>                                dc_version = DCN_VERSION_2_0;
>
> -                              if (asic_id.chip_id == DEVICE_ID_NV_13FE) {
>
> +                             if (asic_id.chip_id == DEVICE_ID_NV_13FE || asic_id.chip_id == DEVICE_ID_NV_143F) {
>
>                                                dc_version = DCN_VERSION_2_01;
>
>                                                break;
>
>                                }
>
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>
> index e4a2dfacab4c..e672be6327cb 100644
>
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
>
> @@ -212,6 +212,7 @@ enum {
>
> #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
>
> #endif
>
> #define DEVICE_ID_NV_13FE 0x13FE  // CYAN_SKILLFISH
>
> +#define DEVICE_ID_NV_143F 0x143F
>
> #define FAMILY_VGH 144
>
> #define DEVICE_ID_VGH_163F 0x163F
>
> #define VANGOGH_A0 0x01
>
> --
>
> 2.25.1
>
>
